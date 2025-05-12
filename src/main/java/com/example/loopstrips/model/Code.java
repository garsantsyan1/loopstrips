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
    @Column(name = "used")
    private boolean used;

}