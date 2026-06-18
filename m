Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD6528686
	for <iommu@lists.linux.dev>; Thu, 18 Jun 2026 13:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781789801; cv=none; b=JaAYXola3UrxeyOGvvt1NjAns5zv6m4BVM4atSoJ5SCLwzAY9sURpUwChSbnGCk27lst4JLKG15xw0nG+9/A6fk/tfrfinpHc3h8HCEQpK39DLUi1DfpZWkdQSOMwIRQIVnRcwdzJ+KT9wzRJSppr8uL4pUCztZscuYFzTmfE64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781789801; c=relaxed/simple;
	bh=NtK8KAGuOvAPqgQxA0H02Zs1LcqLCIFigx5592EZT3o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YDGs8NJYOCYztcUeLVswSZcQI4/PtBEdnywTvFlnGuaALn/8Xot80HEsPTZXXPrXB4ZImbuoh49yopmRWU9fFN5Fy/4n4n2eQmIXuki1sP0M0RHk+/zatmi3jHnDFDuxAa/M+S/l8NNnyyAu4N81J8g+iphzc5mAMRbmOSQt23c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzKDbH+r; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzKDbH+r"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45ef189aa1cso714353f8f.0
        for <iommu@lists.linux.dev>; Thu, 18 Jun 2026 06:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781789798; x=1782394598; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qavgJPHHOECEJ91w79AZ813o0Mh7WejFknktQtGHNq8=;
        b=YzKDbH+r3TmrSg0Sq2v8V9lVPp/r4sEgEcIhMntDQwkoD+5T5h3jp9TkbGwgD8R0TF
         Jc3ks8J7o9CTrLnr5JEsr66bWztUr7uYQdSnUsNLuXb7WenEdH9TqRfGEqanQLSS4WuZ
         prc4f1l8pTZif0kRhlDKXKwywvl28ry1gmHFXTqMNDV8ArNpfh7ZRDVaQ3/GXuUQiAIP
         tRrtjL1xiRKRxebbn1LAQhwp5VtzY4lAWabBd0YcPj47ap9+EWfOjkFj2Ee9ToIjmMZk
         JPQ3YlnzA3NsDYOKpvF9i6e7n9Sxqof8z2EsWdNl0dXWqqANTkVOMcokF0xcHz1NdMcR
         EFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781789798; x=1782394598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qavgJPHHOECEJ91w79AZ813o0Mh7WejFknktQtGHNq8=;
        b=GdcVwDqrwb+wMV5bkSorfP5KTVG6CGN1Dmo+mfPmj0goHR1bECMFNfxtWa8YxA5Kjx
         Y+L34DtFReXmoNxsIxZtR/nuOIRJ2wfzGxEH3debTiGJHzxMpbrltqfAxbAmsTWU0FEa
         G3XXo3EeLWQ+LnQtSVicCu4ZjQLLuR5ig9TsglbPoRwmM9RD/VUrELZO2tYB7Aa3a1Kr
         kHtyma22NKVZ4EZgXmu5OV6RMou8WBG9JkmReFh3uVyxh9DA2oSZ+JS6v9CVTuBrTStz
         pmOJYzKRmGmZPOWIJcqLTnpBgV1HN9BsaR1IG9G3KKW4114vYZCnh1rUgwv5cDrlrwmH
         SkvQ==
X-Forwarded-Encrypted: i=1; AFNElJ93oNEPJq3Il+RlKQv5RvoFSy316mN8SAC/ErEGFBPcyB+0YukLk0h22aLM2mO9yx9Nm3l8ng==@lists.linux.dev
X-Gm-Message-State: AOJu0YzO9K0rgbomUFynebVoHtpYMBT6+KCW6djLrMI/hj5wgDdZSNz4
	U8AldTf/Q1bBh+FOjfH3CqYxWXi5xLAKidckwPVs9wZkQE8/bEKTyTY9
X-Gm-Gg: AfdE7clAMvibcSN5lwuHwcYazO2xxRCxFM7sm7p05xtGOB/anlNvxOqrTtVWxZJIkSI
	v1sEMkK9r4nrBjxFsTuUp9BPpCo3P2G2y44mDRDRvgUnEJq0BIP+LHSdqA7O2ULJsgI4L8uxe0A
	EelfQfpW1t+8UJ6uEvuJ7km1ji4LMLTJY9o0NOUlF4L7nnhGmJF29PDTnnS0ildxbCUdbXcYPti
	08BkXvp6zPOFqI4CV5WvooqVUdFsYBC88cae/D3ajepqVit0Kri4NELLf9TMxpcpsq/a8IyAEcv
	C7lQVIr5KPPsRs84Qp3KBt/cjHPHMT5o9k7/TmADdIFsUYFVmp0ZkroUX69ariDeWtq2sJ6Q2wG
	N7eXFpop6EuWeOAkLjAZ7hH2ideRFdAvUhBShN1S+WziNtZCskHEHBnfjZUdcnYHwsqr0enxPDS
	8XKQqnswqPrAL44ULBF8Gv9i5hsTIusrIrYo0WZ5ODyCKallm2dD4ftmWMCwrS
X-Received: by 2002:a05:600c:4f91:b0:492:1e36:d16e with SMTP id 5b1f17b1804b1-492333f7ff3mr144524195e9.36.1781789797510;
        Thu, 18 Jun 2026 06:36:37 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a58fddsm233967025e9.8.2026.06.18.06.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 06:36:37 -0700 (PDT)
Date: Thu, 18 Jun 2026 14:36:34 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Guo Ren <guoren@kernel.org>
Cc: Vivian Wang <wangruikang@iscas.ac.cn>,
 zhangzhanpeng.jasper@bytedance.com, alex@ghiti.fr, aou@eecs.berkeley.edu,
 cuiyunhui@bytedance.com, iommu@lists.linux.dev, joro@8bytes.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 luxu.kernel@bytedance.com, palmer@dabbelt.com, pjw@kernel.org,
 robin.murphy@arm.com, tjeznach@rivosinc.com, will@kernel.org,
 yuanzhu@bytedance.com
Subject: Re: [PATCH v1] iommu/riscv: Support 32-bit register accesses
Message-ID: <20260618143634.7f3dd6c5@pumpkin>
In-Reply-To: <CAJF2gTRH6x78A3J5HJ5kUM47aDv8R0yFr8LRP+7jiLX4GL3ssg@mail.gmail.com>
References: <20260615064855.90316-1-zhangzhanpeng.jasper@bytedance.com>
	<20260615123821.373248-1-guoren@kernel.org>
	<7c490aeb-a3d9-4fe9-81de-f9662577851d@iscas.ac.cn>
	<CAJF2gTQ+-gpvUDtOh99aKP2-iDJy3MYOWti9k2Ntd0-J0MXqxQ@mail.gmail.com>
	<e051d822-d0be-4a88-ba86-ec9b5905fd1e@iscas.ac.cn>
	<CAJF2gTRH6x78A3J5HJ5kUM47aDv8R0yFr8LRP+7jiLX4GL3ssg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Jun 2026 17:51:34 +0800
Guo Ren <guoren@kernel.org> wrote:

> Hi Vivian,
>=20
> As noted in the RISC-V IOMMU Specification, Chapter 6:
> > Whether an 8-byte access to an IOMMU register is single-copy atomic is =
UNSPECIFIED, and such an access may appear, internally to the IOMMU, as if =
two separate 4-byte accesses =E2=80=94 first to the high half and second to=
 the low half =E2=80=94 were performed. =20
>=20
> Therefore, the atomicity of 64-bit MMIO accesses is UNSPECIFIED and
> not clearly defined in the current ratified RISC-V IOMMU
> specification. To handle this correctly, the Linux RISC-V IOMMU driver
> should fall back to 32-bit MMIO accesses when reading 64-bit registers
> (e.g., performance counters). The behavior of 32-bit MMIO accesses is
> more precisely defined in the RISC-V IOMMU specification.
>=20
> Thus, many hardware vendors implement 32-bit MMIO (rather than 64-bit
> MMIO) based on the current ratified RISC-V IOMMU specification, and
> this driver does not appear to benefit from 64-bit MMIO access either.
> Performance is fundamentally constrained by bus latency; assuming that
> simply reducing the number of accesses will improve performance is an
> oversimplification that ignores the underlying hardware
> characteristics.

If the bus latency is significant it is almost certainly worth using
memory accesses to avoid re-reading the hi register.

Something like this might work:

static volatile u32 hi_prev, lo_prev;

	u32 hi =3D read_reg_hi();
	u32 lo =3D read_reg_lo();

	if (lo <=3D lo_prev || hi !=3D hi_prev) {
		u32 hi_tmp =3D read_reg_hi;
		if (hi_tmp !=3D hi) {
			hi =3D hi_tmp;
			lo =3D 0;
		}
		lo_prev =3D ~0u;
		hi_prev =3D hi;
	}
	lo_prev =3D lo;
	return (u64)hi << 32 | lo;

It shouldn't need any locking but the accesses do need to be ordered.

	David


