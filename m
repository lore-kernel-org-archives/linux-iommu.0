Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B1F3AE6F4
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 22:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788213686; cv=none; b=MFzjiV+cxM60rNwcAprY+lUfDeyQTo0jfc8VsSirWmhZChowaJq4TJIOtfXA46ZgaxJv7ux3gz+OTOS/ubynHq/b6tszbfabihx0QOIQPThOYjMClcArMCjWzVMAFA3v8ET3+7zsJTfkDTHpLmeGmwaenImhRvTfjhs0bY6cn1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788213686; c=relaxed/simple;
	bh=omkHVEp4WPLUzKCvndEtxr3t8U9WsqtBvVkHpVFmX9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pAxXbUzmxcbf0PGO8MLY3TLwqr9ZYlfhKhRu2QxhotsFupM7Ct3yRun28aId55fmMp7C546yUOeAK3ecZzjAZu2LHW9SGBfmUYnqoAbWKZSdLYK48R0dDPlkj1Z2rNn5zf2PucaJ3aUR04fdVsF2CrUD4lyyihSbp7UULe2a3GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ghi3qQ5/; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ghi3qQ5/"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso317506a91.3
        for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 15:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788213682; x=1788818482; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KlAZtR3bxWbXU1u47EK486WJOcGonf0Fz4yohZ71G40=;
        b=Ghi3qQ5/yRRIdTq/okHc1Cwn3pKuChhXk9gD1f6FJHwaZG/2I7wRdf/AdiDCkpiRG3
         9lg7h3CORyjApXvWVjZxyaDdWL14sNV39ncY/W8YaoVacnIAiRkPOyKS22CaiVtjAbp3
         o/N4ywO4XPsVyVjd7XSCvQ21/8C8F24VGcOdMr4KCuwNIF0wRyUQzvfkop68BRh7nh3m
         Mu30Nxmbx1Rpxb7H83i4g4bTI4EZDei39Z6KyX1yPPMZ4ikmLJC1+OYZe5w700PFIwJ+
         7ODR5mkUfKNp1IpmAFC+B3tBOvdUMmH10zvIizq2F8Te92DD89s5Ub1rDFpClcP27Uob
         t0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788213682; x=1788818482;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KlAZtR3bxWbXU1u47EK486WJOcGonf0Fz4yohZ71G40=;
        b=OS02AMlQ/EQMFtQ7xUBBXUcWt0lTwvzCnQgClPh2XLbHb+dUmdquR5uJ7EPst8XCUl
         5TgNphUqkX7L31hSW67Mqh966lKrLgDuHmtM7nXTdQg+taLtXgi6rvmdLsLw2tK+a3wT
         s9qzFv1FiayC+6sTYFc8yF0j7qSGZygytj804IAUiVY34IFyscFEDI3d8PgrQMq6OzG6
         nDMHG5KbRJzdXulx0eassDON7Fk7jxs88mPouEpfSjYHTgkKznKy/7P63KLRUYztXph7
         3LVvdChMvf96cCRBE2w7qGYyTZi+u6ZlRhLJCK9ZEq/R5pSuG4wBO6kJLAwvjAnP+iCC
         8znw==
X-Forwarded-Encrypted: i=1; AKwUvBwSk2rNEAnpil0kbhmOQxPsi1salMBW7FLP8NWTL9e43hwjBVf39b4n4BAis5E30ZedEpl6Zg==@lists.linux.dev
X-Gm-Message-State: AFuF++mQxwu6PPiLl5vBx4zERAdV6NZeLV9B+wb/hC1wrrtYOWKw1ae1
	TyUnSRQj2gAc9aSk8+3FCxyMnuH7dakOjudKoQ7cRIGmwMbJ7u7stCnB
X-Gm-Gg: AYBFou0s4xxZbFZ7LLWlvJG3MMv2ySPrdsFxG05GNCUHZDu4GxnwjdldMKy1SgztrH1
	Wr+T/+zhlAbbbqYK92Y3/0ZXnMevFDM3qzbGwonMfyTCMaN4bxkAdVoudWzCWCFGD9ZCo5z++gr
	U2zJaB9NBcKPV7k2TdLap9Qcjhcy0VXWf32TonhLpaNjCl1rrp9OK1biB7S7/pqD8Y2edyrguJ+
	RaWcfPyES8zxYY+07W7xQo29uxJuNdUfPtuNhprGtw6jq/D0eUZM5kwGLSOgOlOi/5YuKGhY9be
	FgeChprlvdEHAjFrxTP9z68hhtq/Mk2hfpmlvrSYA66k9owROjW8qZjdriGmZTQbjAuvziaCVZr
	QClirQFVUXDef/qgF0R5dod2s7SqdurZTmLh0xMYeJPKt5cgvHRlzYTHbCi98sk4PIYCjGaJ+nm
	p+rs6No76FplWEYNaxdhIPEd/P9HpDx0BYHucjbF9A6VfDxYNQbe0G/SdVHlVbWBi2t7kpRhAuB
	etzu8ha1kSsjGjHNAY02Zp9E2S0+xbHZNzx0YvdB9xsUZ102w/UIozDeJDCZq9nCA==
X-Received: by 2002:a17:90a:114f:b0:398:9be5:b41e with SMTP id 98e67ed59e1d1-3989be5b50emr19697772a91.25.1788213681696;
        Mon, 31 Aug 2026 15:01:21 -0700 (PDT)
Received: from [192.168.0.158] (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32874498f9esm29322712eec.20.2026.08.31.15.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 15:01:20 -0700 (PDT)
Message-ID: <8d6ae98b-945f-402a-a7eb-c35c0efae46a@gmail.com>
Date: Mon, 31 Aug 2026 15:01:18 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] IOMMU Performance Optimization support
To: Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Joerg Roedel <joro@8bytes.org>
Cc: amd-gfx@lists.freedesktop.org,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>,
 Jatin Kataria <jkataria@netflix.com>, Boqun Feng <boqunf@netflix.com>
References: <20260831055108.1893285-1-mario.limonciello@amd.com>
Content-Language: en-US
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
In-Reply-To: <20260831055108.1893285-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/30/26 22:51, Mario Limonciello wrote:
> Add support for the AMD IOMMU Performance Optimization (PerfOpt)
> feature as defined in the AMD I/O Virtualization Technology (IOMMU)
> Specification, Section 3.4.9 (MMIO Offset 016Ch).
>
> This feature allows privileged integrated I/O devices (GPUs) to bypass
> the IOMMU when directly accessing system memory.  The IOMMU only
> enforces the IR/IW permission bits without GPA->SPA translations.
>
> Drivers will opt into this behavior, and enable amdgpu to turn this
> feature on when an integrated GPU is already in identity mode.
> If a user prefers to keep it always off (even with identity mode)
> there is also a module parameter to force it off.
>
> Mario Limonciello (2):
>    iommu/amd: Add PerfOpt IOMMU performance optimization support
>    drm/amdgpu: Enable PerfOpt IOMMU perf optimization when GPU in
>      identity domain
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  41 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  12 ++
>   drivers/iommu/amd/amd_iommu.h              |   3 +
>   drivers/iommu/amd/amd_iommu_types.h        |   7 +
>   drivers/iommu/amd/init.c                   |  43 +++++
>   drivers/iommu/amd/iommu.c                  | 214 +++++++++++++++++++++
>   include/linux/amd-iommu.h                  |  11 ++
>   8 files changed, 332 insertions(+)

Hi Mario,


The Legion Go 2 has a significant performance degradation when IOMMU is 
ON and VRAM is set to auto in the BIOS. I applied these to linux-next 
and compared to 7.2 neptune on the Legion Go 2 and got the following 
results:
Game: Avowed
With patches:

Go 2| Vram: 2GB, IOMMU: Off, FPS: 35-40, Frame Time: consistent
Go 2| Vram: 2GB, IOMMU: On, FPS: 35-40, Frame Time: consistent
Go 2| Vram: Auto, IOMMU: Off, FPS: 35-40, Frame Time: consistent
Go 2| Vram: Auto, IOMMU: On, FPS: 35-40, Frame Time: consistent

Without Patches:

Go 2| Vram: 2GB, IOMMU: Off, FPS: 35-40, Frame Time: consistent
Go 2| Vram: 2GB, IOMMU: On, FPS: 35-40, Frame Time: consistent
Go 2| Vram: Auto, IOMMU: Off, FPS: 35-40, Frame Time: consistent
Go 2| Vram: Auto, IOMMU: On, FPS: 20, Frame Time: inconsistent

Overall, this seems to fix the performance issue with IOMMU when BIOS is 
in the factory default setting.

Tested-by: Derek J. Clark <derekjohn.clark@gmail.com>

