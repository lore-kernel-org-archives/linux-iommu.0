Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E7248AE1B
	for <iommu@lists.linux.dev>; Tue,  5 May 2026 16:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777998731; cv=pass; b=AE5uGeB+RU8HhbKAu+qfOHdvhMHTxBypNt5F7v2ySJ13n/GYb9CTpRmldWgz1cKDe/Df9odcANedF50lIMVACCt0elVVwypH6D47wVwF8A6wj2lMcNm+9CnhtAAd7CI7p+WVvsWWApBaQIcIZPNGyk35DqoauOCyVHcAMet14ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777998731; c=relaxed/simple;
	bh=iy3n3rJ21iXxzxWQtymxZU8jDcKP80ZeTnptO0tAl6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U9vmQKOVkTokgCfjxw57Tx890FoInZdm1xzH51HQAjPkY1IRXF4CwZbX6UQfKheLV6tIvruPZY/8k45xaI46sAAUE5kay8+18MDWzaHxJH8bu/he+Un4VuNiVZ6LuZvPI+z2e90z2ou+RUHNbZAGQTg2dOsFWYXkc+0BEIy9pJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=LsQg+x6b; arc=pass smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="LsQg+x6b"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6949192b843so1951164eaf.1
        for <iommu@lists.linux.dev>; Tue, 05 May 2026 09:32:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777998727; cv=none;
        d=google.com; s=arc-20240605;
        b=WNpfcMRC7sC5repBeq5g/u58tThIGl8OGR8ZqHAcJ+82B2VakHUO9zonm3p8W8HzGT
         /HRduU4MFS6/893jyZWjtv9OMjC2MjT5s6IU4WQT4ocy3HRP+DDbbmjVzEgF/KkPSDl+
         lKQOC6GTLOreZkkU0A6C8Sdks7OlLPw/C7tflTHzkbVrCv11yIkgy0tNmqCplb9KdRuz
         dndHCoqy/QijfR9KI2qoXCuQl9psiu8XpcDrsFK9IOmzWiOguIPkfivOAsNQeJcvcURe
         KQbAOoqxe/AWik6Jyb+mnnT5i+emqJ6IJ7Om9h9OzNLqmBiyDKJdjmOGyIXdnbUMpQoD
         +15Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7eXEy6+DCrmMWFnLDZ4Fw27+W46tPenXbPYSAHMIGQY=;
        fh=ehwjQ4/Yj4vj5OxpU3SiniRPxcpDoGxn2Rk5ywOlaZI=;
        b=WMNtf2P0oVG4cPpaxjNwigEc7wmVPjA87we87Me/4u19XCLqOEtmu929JCqPeIfgZa
         9xkCZNno+3CevfJz6XpBE3JRITUg5utvUjg34X/O3ZRW+KW3tG7N8TIRN6D3gIVXpZNR
         OC9JUjLN3VyUyz7ZNtVJ9U/QoSJiyWOtnSOr2/tCKjNkQKZJHrbsS9Rk5Ne4H2SwHtsg
         D23trZETbth2s9aaWfEO0oP/teqs5K47w638JoiHTvsz7d0I0zPTYEnftc4gQdk8k8ov
         XgD/sM/npezarMq53vB/4ou6BJ+GsUJktUtk0YqiiPFtKYE9XUMG+R3lCoR3DL6SnUpb
         mVZg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1777998727; x=1778603527; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7eXEy6+DCrmMWFnLDZ4Fw27+W46tPenXbPYSAHMIGQY=;
        b=LsQg+x6b3df6CazlYBQ+7iDgkS+QGarHroxhm0hg20l/bn+N/A+VRptXS+RHTHKCFd
         8/gO61iYzzJ9qC0jymwnWq32YxGyGHr5DiIHGNcBgV4yHgFBjRSqFXcTJdJeYzmVO6C7
         Sai49EORiZZHoeM/6Omx+yU+o8Q2I+YYLsQcYkf7/Z8b5WxhVUlHFXOZKuZ6CDgnGZ2R
         0+7WMHqZrCqMwQA+2YRf2VVqfXrN7ktEaDbD+XKv6USoQzYToCeV+EMwJak6Ym7H9wvb
         m4ShUkb3bFjbVXaeBI9LTMEeejh2A42ik5Ll80LkYxPjpvZxfkQj9mufkc+trUKoP37O
         OamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777998727; x=1778603527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7eXEy6+DCrmMWFnLDZ4Fw27+W46tPenXbPYSAHMIGQY=;
        b=Nbzr//OQBCBHZysUwWIB1MXX9K1asssT9E1PWjR/9r/xSJ+4KnwG5Xe2SjDd/pdsEY
         FwXDyBfP6MNdkR/9oYWs6LNW82aOzwDv7BPkoLfAcaEkVisNcRXpAfc1HNkhYxEuQZ+s
         T3ScrboZ5KHpjVv/Yr6woSqT5EiOrWxRoLKDIzSGmw+gLU8Afc53SfFPkq6Yp4TjUQ7R
         yKanaTeGNZkYNqGZDU6pkmwOi2qSc3FtyRd6Oqm8wK+g4CjJIsgMRzDgV2oxuwrr9N4E
         0j5iegHjWTBjwZ1F0AS0IHfKvZjPU6UIZ13XZqn9gOLjelye3MjhIOhMclI/2pebE7Ac
         rh0w==
X-Forwarded-Encrypted: i=1; AFNElJ+4iRigyp6EPFbm++moVulvCunOr8czGwHCuD0Bn60+mZ7SrXCIyeCGfRZoyy+oLmAhAfiNWw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwP6ETe7joubwXOoCq2oEieyMUFjNF+blW3w+rlWgOPVtSMkEwR
	EC4WaFKaDQ7b3YGOgndgTEFBWLdvotvo2sVMvvH1u44Aam1SNrV0cP20PqCdoA9mePhbpozxO4n
	xc5ezYCxHD5PCaaHoV+gqTiUzWQZuem0FLOjNCoatVw==
X-Gm-Gg: AeBDietc5AVNtRBtv0YE7bpuAvqwDdZk1wyoFVs3WyTUQd1gjCXKrgBQ5+xwrWkmwW7
	8AXzsBjnGO4Hyui8ERFEVarOEP2haOvzlLWi6uQ04GB91Q/SxbKBlFXaR9u6gK+NiN/GzJtBOfJ
	bxnCnq0g28Vx+7PDaL4eqGUQJCWi3YqVFDVnQ8X9VzItpmUOFnzCOZHPztPgXVq9wft8VozQcDR
	+LwNPs/+JbHiwTNzAatxAhGv3jHthlzbYKmXExh22AX/L4x6ap/HyGARD/OBors65sdD6UEeQdM
	tBSxSNaSFVMYGH8rgKrCHGcE+eDU
X-Received: by 2002:a05:6808:2518:b0:479:ffcf:52dc with SMTP id
 5614622812f47-47c8930caadmr7143176b6e.44.1777998727293; Tue, 05 May 2026
 09:32:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v1-54e7264d71b4+17cc3-iommu_riscv_inv_jgg@nvidia.com>
In-Reply-To: <0-v1-54e7264d71b4+17cc3-iommu_riscv_inv_jgg@nvidia.com>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Tue, 5 May 2026 09:31:55 -0700
X-Gm-Features: AVHnY4KXzwjaC_Gb5GnddRMzX9LqC580rYOWyeA1_Y7wcl4kfXs2AQTViUP1SDo
Message-ID: <CAH2o1u699nbGABw1mcZR=BrZcyy7s_WNz-szpe8bn8bPhuv-yQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] Support non-leaf and range invalidation features in RISC-V
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Albert Ou <aou@eecs.berkeley.edu>, iommu@lists.linux.dev, 
	Joerg Roedel <joro@8bytes.org>, linux-riscv@lists.infradead.org, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Fangyu Yu <fangyu.yu@linux.alibaba.com>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Jason for this series.
I've verified github/iommu_pt_arm64 on RISC-V, looks good.

- Tomasz

On Fri, Apr 10, 2026 at 8:57=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> This is part of the patch pile to get SMMUv3 moved to iommupt. From
> that perspective it introduces the PT_FEAT_DETAILED_GATHER which will
> be used by both RISC-V and SMMUv3 to generate optimized invalidation
> commands.
>
> I don't have any RISC-V anything so this needs to be tested by someone wh=
o
> does.
>
> Improve the invalidation flow in RISC-V:
>  - For single address invalidation, compute a stride based on what
>    IOPTEs were changed by having the gather track level changes in
>    bitmaps. This allows things like unmapping hugetlb-backed mappings
>    to avoid jumping to global invalidation.
>
>  - Support the NL bit to avoid global invalidation when table
>    structure is changed
>
>  - Support the S range invalidation feature to convert any gather
>    into a single invalidation command using an aligned power-of-2
>    size like AMD and VT-d.
>
> This is also a requirement for the kunit iotlb series, which was used
> to test the math used to generate the invalidation commands from the
> gather in this series.
>
> It replaces a similar series Fangyu sent prior to the iommupt
> conversion:
>
> https://lore.kernel.org/linux-iommu/20260208144213.94856-1-fangyu.yu@linu=
x.alibaba.com/
>
> The full patch pile is here:
>
> https://github.com/jgunthorpe/linux/commits/iommu_pt_arm64/
>
> Jason Gunthorpe (7):
>   iommu: Split the kdoc comment for struct iommu_iotlb_gather
>   iommupt: Add struct iommupt_pending_gather
>   iommupt: Add PT_FEAT_DETAILED_GATHER
>   iommu/riscv: Enable PT_FEAT_DETAILED_GATHER and pass gather to
>     iotlb_inval
>   iommu/riscv: Compute best stride for single invalidation
>   iommu/riscv: Add RISCV_IOMMU_CAPABILITIES_NL
>   iommu/riscv: Add NAPOT range invalidation support
>
>  drivers/iommu/generic_pt/fmt/iommu_riscv64.c |   4 +-
>  drivers/iommu/generic_pt/iommu_pt.h          |  98 ++++++++----
>  drivers/iommu/riscv/iommu-bits.h             |  24 +++
>  drivers/iommu/riscv/iommu.c                  | 160 ++++++++++++++-----
>  include/linux/generic_pt/common.h            |   5 +
>  include/linux/iommu.h                        |  42 ++++-
>  6 files changed, 259 insertions(+), 74 deletions(-)
>
>
> base-commit: ac81c0f2e6a779e444c5b6fd43756ef811656098
> --
> 2.43.0
>
