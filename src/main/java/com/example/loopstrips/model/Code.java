package com.example.loopstrips.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "codes")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Code {

    @Id
    private String id;
    @Column(name = "scan_count")
    private int scanCount;
    @Column(name = "flavor")
    private String flavor;

}