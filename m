Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com [74.125.224.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDFD33A9F8
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 23:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785194033; cv=none; b=qrZjSZnWYsyIsIvKtwFz05X6daP70YKdeuwmRvyk2ipExOt+FLZQk5Xj4fQHTpyq+mre7ktRA6mOVhQ+gCwZM24QzT6v1DjOwKArquqq9RfDd31FYT8Ev7y4tGOj/78wSQN5zMjeiCZjSOgETcsUy0AHhOP51S3Swy5du2FsKxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785194033; c=relaxed/simple;
	bh=zLSHSlA49BYyyHUHzOoJdO9BHdcI6rnTT6w1nCw/5jk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fHBZsZIHP4RTEU0ST2pNwbTgnRhN7Andcg6VqkACgVwGqZ6GRW41PWQGtC9nX3ym/jpz5tErwt5kxHojHMMeIVWg/Z62t/l9LWvngaH3BWcj4g62EmJaNY+QhGprC2oUVovW7iaGBSXUjxseSJL2Jc3FXbF1dLzd92RfxEedGLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dQp/o1mV; arc=none smtp.client-ip=74.125.224.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dQp/o1mV"
Received: by mail-yx1-f97.google.com with SMTP id 956f58d0204a3-66899fe9077so5059354d50.1
        for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 16:13:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785194031; x=1785798831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SBBRC+4dBOGUpUnVf1j+pdxrs8Bv9jF12/3OQB9wVH8=;
        b=j4mV19WN93MCg0OJM31+ADTIYRSnlV2U+3ZjRn91wlyzAJUMllIk9uiWxbH8CioNY+
         0wTm92fhVCyJ2kP6WhW1h1Y3BhnzJ9r292RVmmk0fpojmlz+iQcG2Sg6n0zlUe8Oy3YR
         bKg4lEX+PspT4NzjdRtcL2hxXyPr4hc1N9bhAB2N/siIb1fV4LTjKV+CL6O/s8h8e/vR
         EtkRkTAZY0WzCLpKhT1hKXNGLyDqVtmIZk5rIez3Fh9QO9isEhwF2jphCLrd9JqbC2DV
         Ym21Lep2Vmmvpa7zyr7IhccU2Q1sB2sTpF4aNO3I13c3BfOJU0UqIE5ctF/6d5YljFod
         RH+A==
X-Forwarded-Encrypted: i=1; AHgh+Ro7yJI5xHlYW4g6hQ977kT/JpsgLA73um5gPXr+z65WG+xZGPZpYpliZXIgODUXYMB2kFhnwQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxwzkbhitP4EUAzGoHsQ/FXWTyzldEO4+7JXHUYNsc9rN6abyD4
	33h8UGSjutBTSeTphhoRwV60S414O8J5+henEbU8+Om/EYNHC//tShPwYisNYT3b6gw2eM4MdjA
	iZW2wua/CQvIMPKfF0es0ALkjPf0Sce7gWum5ALOzUXG6Ocp6fxUhRa4F7iGsanhANcrSIPF6cD
	Rh5LdzFQXx3dc0Jqj+0q99fC5ESoZ17CuxqXpyshOG3Cbkat7//uAydjrOo6x0hHF/s6Z5JS/Xw
	dNy3ifwgCE=
X-Gm-Gg: AR+sD12GQ1kfmwXZKVMVvyah00xB8MnX2v7yQI3Hsxe+0BwjUZz/bFGAkQBvH2amwLj
	tnoOT+gi9L34Y32KrZ9nkG1zxEmrdYD4zL7l8H40P6MqZw+apWsuYL2paZrayq9cZdSgGJPQ8AL
	ZGst+D1hdu/cKRIEgElYK3hsR1UblVIv+g1n1w7VtoHEZYq/MoqULR0cnJENqUOVK2ncS8HjQM8
	wZTegWiTwsp1klEE7HB0XtZ+lJfrwUJ/z0Jn/5sh03LWznWy8QjyOe3Q0bZDPjbMlDL3vrzR+7g
	pupRxQkTrFOXkk06lC0W+rxgDUH8OaJzu25m5//5LtrD/Hda+JfQTJazFhhlOpevOJGERJh2m9Y
	nwR3xXNsnDfPnT95cJ9u48F51aZuDUSUkrxtBpoiJMb9R9fi87RAppqLx6ZMC/gzQx0FXouP/Lf
	AYyYR8mQUjn0wu0L0AqucnJeYMg4tILSJv8Gm+
X-Received: by 2002:a05:690e:4281:10b0:667:8b91:241f with SMTP id 956f58d0204a3-668c7bdabd4mr2396901d50.102.1785194030923;
        Mon, 27 Jul 2026 16:13:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-668c6fd79ebsm746588d50.28.2026.07.27.16.13.50
        for <iommu@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jul 2026 16:13:50 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38dd87656d3so3889588a91.2
        for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 16:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785194029; x=1785798829; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SBBRC+4dBOGUpUnVf1j+pdxrs8Bv9jF12/3OQB9wVH8=;
        b=dQp/o1mVFQryZWXQEwu59655M1jDoEar6zZgg22FT+9Yi4I/8OfOkWnEPKzRWRT+sm
         3vOpqOpQvbG+YQ1qIjSr3P/tNTKOWK8G2bRyiILYv1QgECeo40H4lvzjmZkrB6700esC
         fO+X0aT4ZvZOgWkXHpu1r7fcxSbZR+bRIR2js=
X-Forwarded-Encrypted: i=1; AHgh+RpqG7fJT36s/oSRIChjNk+fT8YJUREFtljbceq6rv0MY35OS2bZDxqBNiBt/AcOT4m/XTUqCQ==@lists.linux.dev
X-Received: by 2002:a17:90b:2ccf:b0:387:df8f:1409 with SMTP id 98e67ed59e1d1-38f2988462emr8728029a91.42.1785194029520;
        Mon, 27 Jul 2026 16:13:49 -0700 (PDT)
X-Received: by 2002:a17:90b:2ccf:b0:387:df8f:1409 with SMTP id 98e67ed59e1d1-38f2988462emr8728013a91.42.1785194029098;
        Mon, 27 Jul 2026 16:13:49 -0700 (PDT)
Received: from stband-bld-1.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc415eafsm36964437eec.7.2026.07.27.16.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 16:13:48 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: dan@reactivated.net
Cc: bcm-kernel-feedback-list@broadcom.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	florian.fainelli@broadcom.com,
	iommu@lists.linux.dev,
	jgg@ziepe.ca,
	joro@8bytes.org,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	nick.hollinghurst@raspberrypi.com,
	robh@kernel.org,
	robin.murphy@arm.com,
	will@kernel.org
Subject: Re: [PATCH 0/6] Add support for Broadcom BCM2712 IOMMU driver (Raspberry Pi 5)
Date: Mon, 27 Jul 2026 19:13:43 -0400
Message-Id: <20260727231343.1520006-1-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260712-bcm2712-iommu-submit-v1-0-80e10cdde2ea@reactivated.net>
References: <20260712-bcm2712-iommu-submit-v1-0-80e10cdde2ea@reactivated.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Hello,

Please give me a few days to give comment and test this on
the Broadcom 7712, the sister chip of the RPi 2712.

Regards,
Jim Quinlan
Broadcom STB/CM

> 
> ---
> Daniel Drake (6):
>       generic_pt: allow missing sw bit in DMA_INCOHERENT case
>       iommupt: allow full-table contiguous leaves in unit tests
>       dt-bindings: iommu: Add Broadcom BCM2712 IOMMU
>       iommu/generic_pt: Add Broadcom BCM2712 page table format
>       iommu: Add Broadcom BCM2712 IOMMU driver
>       arm64: dts: broadcom: bcm2712: Add GPU IOMMU and IOMMU cache nodes
> 
>  .../bindings/iommu/brcm,bcm2712-iommu.yaml         |  65 +++
>  .../bindings/iommu/brcm,bcm2712-iommuc.yaml        |  35 ++
>  arch/arm64/boot/dts/broadcom/bcm2712.dtsi          |  15 +
>  drivers/iommu/Kconfig                              |  15 +
>  drivers/iommu/Makefile                             |   1 +
>  drivers/iommu/bcm2712-iommu-cache.c                |  73 +++
>  drivers/iommu/bcm2712-iommu-cache.h                |   9 +
>  drivers/iommu/bcm2712-iommu.c                      | 587 +++++++++++++++++++++
>  drivers/iommu/generic_pt/.kunitconfig              |   1 +
>  drivers/iommu/generic_pt/Kconfig                   |  10 +
>  drivers/iommu/generic_pt/fmt/Makefile              |   2 +
>  drivers/iommu/generic_pt/fmt/bcm2712.h             | 259 +++++++++
>  drivers/iommu/generic_pt/fmt/defs_bcm2712.h        |  18 +
>  drivers/iommu/generic_pt/fmt/iommu_bcm2712.c       |  10 +
>  drivers/iommu/generic_pt/kunit_generic_pt.h        |  39 +-
>  drivers/iommu/generic_pt/pt_fmt_defaults.h         |  13 +
>  include/linux/generic_pt/common.h                  |   7 +
>  include/linux/generic_pt/iommu.h                   |  13 +
>  18 files changed, 1147 insertions(+), 25 deletions(-)
> ---
> base-commit: f4fb100039e96211609dfc44fb24b9e4a8a0f2f9
> change-id: 20260712-bcm2712-iommu-submit-2e09899e65c4
> 
> Best regards,
> -- 
> Daniel Drake <dan@reactivated.net>
