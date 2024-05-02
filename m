Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E1C55C0A
	for <iommu@lists.linux.dev>; Thu,  2 May 2024 09:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714643737; cv=none; b=gTItcCaxQghPpqgWJ0Lm1L0iQrvOII7c0uZtqBN/R/ttOXWiRGXe86iwNk7HVUdp4cB/0Uv7K9B0SsR2Axd3J+a0BVKUn77EAkCcl3LYqbenlPGEp+mod62UtxLR0DamaXAxfpgNIH3/NXPdHf8Y+6CieEujBOnIOfBwwND8lJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714643737; c=relaxed/simple;
	bh=3xZ9AUAXso351g/A/VEX0ATJZhtk3T9iQTV2wk2nD8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=id9qSLvBGngMd0NVOTHQ0FMU6qGGnzNd8gobK/npmJ9sg9qRTtZ4Nb70B3T6+2PkMWpUUbirgejQMxafYqrPKKGzxNk1xV1N4Ud61k4uQh1bRm/kQwIsy2UkGP1F+2I7aY8VJ7bP4IFlLf0B18lgzgZcGLFLNe3RL5OpdAI2Ny0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N10yWTtf; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N10yWTtf"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2b393d8dcbaso453878a91.3
        for <iommu@lists.linux.dev>; Thu, 02 May 2024 02:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714643735; x=1715248535; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3xZ9AUAXso351g/A/VEX0ATJZhtk3T9iQTV2wk2nD8Y=;
        b=N10yWTtfSqIajDdN2X+Bi1SbivfvxRgzejcGuHuV9yZjZxadAFFnOIWZq0ZLlZHPyj
         iaBfHyrUZ+c7aRIYXBHp6wZ4qDLojW05Vv3z9niGDR7c/00HQpaeXlXjwda1HIUtkOvY
         NcccWZh1iJvaPx4zNTr3pe1NKC/KTePsoDpsqnEwR1CKBNXwnwRfOAf3e5wz78VaaYGu
         R3FJGPE9iINgmWJK63DKI5kZe8qISEjRQhpH1qtpPRO1ogF92W6kqyradKb/i8+TLrWe
         psvCPZTtC45oS25dX3/dofnJmOdPiCKOZMtK8d3LytYBv/2qaHYqvlsrzTGtSyyr1uPX
         Qm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714643735; x=1715248535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xZ9AUAXso351g/A/VEX0ATJZhtk3T9iQTV2wk2nD8Y=;
        b=JumlgsCWO7n3KiijoCgWAGgG6EnlfXkZoLFBrCSqzNvFkUVl/Y2/amVFq+c67BsfgU
         GRwkClOcLMFhT6tTSrZwHV4rfJNARpDd6j7tSeu6aUA8yNnG6NYPxlrDxDxySexM3fof
         CbU9/cHbUMfUQYGxoFu3PQV65Q2pW3LH0Fkr2brRCGJbxnmthq2mTrLWuwVdM3I9wzwZ
         DsBgbwk4Ll41SuezJoo5aE9rjn2vXbuhNdlcXZPoUrRI2vveG7t9Zmawl9TO2ox4tuNz
         J84dCBj200tSPcMxB2tFalKMHXPihhSUGARDL68kMPjSKDUd5WhQnXgl+LPPAwcEGr80
         TisQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSfxQ5mgq625yuRrkHZX71ST8HHMbzm4VrBSzWZZ+eYvoDtSflFHr1UjgZyeFOEf7IHT/wNs7BWTyW67xpGlcz6du+zO0=
X-Gm-Message-State: AOJu0Yyfmj0p3Ag+5hrf4vCatST9uUCs7OnOmSBibtPB+WAugFAlhCE2
	2WN6LDE2mhuJWkhBYGEB1NylDDkAO9JmrNQfljKjG8VpuIKLLcrd
X-Google-Smtp-Source: AGHT+IHA3Z6wyvmpDJBDXxRhP5maQQO/EsarH2FyfV8voZAC5wf9u0fdCpOFhlH3D2Vt1JwqF6sQ5Q==
X-Received: by 2002:a17:90a:a683:b0:2a0:3dc3:8a8b with SMTP id d3-20020a17090aa68300b002a03dc38a8bmr4583459pjq.47.1714643735019;
        Thu, 02 May 2024 02:55:35 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id c8-20020a170903234800b001e2b4f513e1sm868379plh.106.2024.05.02.02.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 02:55:34 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id CCEED18462B24; Thu, 02 May 2024 16:55:31 +0700 (WIB)
Date: Thu, 2 May 2024 16:55:31 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Christoph Hellwig <hch@lst.de>, mhklinux@outlook.com
Cc: robin.murphy@arm.com, joro@8bytes.org, will@kernel.org,
	m.szyprowski@samsung.com, corbet@lwn.net, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	petr@tesarici.cz, roberto.sassu@huaweicloud.com
Subject: Re: [PATCH v4 1/1] Documentation/core-api: Add swiotlb documentation
Message-ID: <ZjNjE2KyLxdT0HSR@archie.me>
References: <20240501151651.2912-1-mhklinux@outlook.com>
 <20240502055205.GA28436@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="50akDxSaI0gtHRzG"
Content-Disposition: inline
In-Reply-To: <20240502055205.GA28436@lst.de>


--50akDxSaI0gtHRzG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2024 at 07:52:05AM +0200, Christoph Hellwig wrote:
> Thanks,
>=20
> applied to the dma-mapping tree for 6.10.
>=20

Hi Christoph,

I see the applied commit [1] and it seems like my Reviewed-by: trailer only
have my identity without 'Reviewed-by:' prefix. Care to fix it up?

Thanks.

[1]: https://git.infradead.org/?p=3Dusers/hch/dma-mapping.git;a=3Dcommit;h=
=3D5a1d9682fa4e43c1083f3aaf00bc0cea03c997f6

--=20
An old man doll... just what I always wanted! - Clara

--50akDxSaI0gtHRzG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZjNjDwAKCRD2uYlJVVFO
o296AQDKPO2TVa1/51CPheUeFYeLk8t6YY4YHh0LF8RG/z6/WAD/bpgdfLQ3vnvi
f59evQ1ImDqni9lU4vS5Is2zT1YDggI=
=460q
-----END PGP SIGNATURE-----

--50akDxSaI0gtHRzG--
