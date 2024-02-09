Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487B680BFA
	for <iommu@lists.linux.dev>; Fri,  9 Feb 2024 20:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707509143; cv=none; b=W3dVDxr4YOROx/AYrnSIl9A/mz/VLcnnMqQWenJ3vKgpgvwqF+NYCA+dytPq5yLAOG67MrKrmyeK4A+dk7/Al35AUvFE0qSjpnL7cmhjC2f3taBil7fBZ/KBIKxqF5ngznOdaQZDw/9nwn0Igg9bjGTdR+TzHo9VOkQSTDrQ7WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707509143; c=relaxed/simple;
	bh=5KqCk7kqbNG0tWx/V+e5rQlUsiH4IRC+jdytEP4MbGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E4qKh9bfy+M5Ej5B7prcC046C373eEPvWHTN3C0BlW0yWk32fBp2NGaByEoglPVHT53Sj9tDpmPpd383kNRvOV15n93OIWPA88pjWSP+Gx68OT6NZP5i+qkZYhfgQvvVW7xVGt8IAxBHSSg9b8mIQr6x5GgSGNcRgsGsj5F/pqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V07V3cYZ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V07V3cYZ"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51147d0abd1so1485460e87.1
        for <iommu@lists.linux.dev>; Fri, 09 Feb 2024 12:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707509139; x=1708113939; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIJMwJUHQ+J7xEXKw5dXfeQj52kqJF8fmHwmj7knEYE=;
        b=V07V3cYZCEWJ+Y5mcpc/N1joQBDSoNwFeYyt4dVpLRJZs48wN/KPBh4Tjs9wig0acS
         GGX7QFzj7OK93Y1ZUuwsBdiNTF8KASj6+KlJJi+NoHH6tluixZjY4rDjjAKxxNw6p1RJ
         iUOKyw0PmrmHVeSFUkk+PesCTX4YPalZNmFG6wXgtpQ+0wCdezps1Js1HDJwLbMNkNB4
         OeSZiIcuyWZHSb70XrtaZsctQGDjHKMTFrUYZfPc3ywcdyvr6v23Mud/VRBj/0UQrBlI
         Na/lukX8gUntWAjr2dOuC5YtYR0Y1sx/4d9gbFmc3HVuNJqBTADx8f+OpNQ/bpYip7Fl
         hzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707509139; x=1708113939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oIJMwJUHQ+J7xEXKw5dXfeQj52kqJF8fmHwmj7knEYE=;
        b=xTB/DGvcm9yYB4XokhgO9ziiWCis8OborZVB/w0jFKQL11qaYdPWN6oeR8RoFjE2al
         Qgct34Ek9BPOV9MVc2fO2MHpJsJHq/UWMKjorAe+1lKs66LF6lOg4tN4Dh9MAud7PE4Y
         GXdc8jL4KBE4fdsOEzLYElakOUy5fdTYp3kroWXUY3HiBoH7njLYr5bt3UCSs9T3O8+N
         jPQrpAb6WLktI0hlV8KrTJhCrbByaB9A5T3nd922MH/hzJLm/cgMa+Es7R5spctkiPBR
         P9etn4Db09YyWQGcMkZuJ+deAHwC1BLzT5wfOAEipdpqHYDIKbpKltv5+g0GkluiBHVM
         m5Yw==
X-Gm-Message-State: AOJu0YyfaSPvdM/3fS3Po4NAFlL5A1lOxG1C5JhsaxzAoEGITc7VjPVC
	VL/1Z1Y5bMKPy9/eJUM0+8zMZz2ZVHv6SVNQR46YK9C4joClRMhstGCJMiPMsK4=
X-Google-Smtp-Source: AGHT+IFsS9vPe2TfRx4i7aV2GmcAhtdCmpDu2x8n7eHp26Q8sMs0qB6eM/WuvW7RchuJrL7kzcCZlw==
X-Received: by 2002:a05:6512:ac2:b0:511:4a01:2faa with SMTP id n2-20020a0565120ac200b005114a012faamr50005lfu.32.1707509139174;
        Fri, 09 Feb 2024 12:05:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVq2pZfvA1NxHHAbo8Lz9qp5ZRVqZsh0/tvCd5iFuaQ/wcPV01c6CmCmiIr7hNZsrbfTKMh0KNQ2Ajg0rKzY2PxhAPJ7S0CdpIaDrhleYCDGFZD97So+lG/KhiBuEHQrF+eOFE7hGI09odZrrR1Xb8DS17XcZl4bWe7CqxJeYGkIJBZbuIkPXfy27zPg1w8ne+ycUwe8+fdZ/JbItEkc0J88hJ6QXHIyyCe7U7Nlbelrsdq+nZX5dMrIkrqkhgsqsU=
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id k26-20020ac2457a000000b0051166fc7faesm19900lfm.75.2024.02.09.12.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 12:05:38 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: jgg@nvidia.com
Cc: iommu@lists.linux.dev,
	joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org,
	nicolinc@nvidia.com,
	robin.murphy@arm.com,
	will@kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iommu/arm-smmu: Convert to domain_alloc_paging()
Date: Fri,  9 Feb 2024 22:05:38 +0200
Message-Id: <20240209200538.917366-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <5-v2-c86cc8c2230e+160bb-smmu_newapi_jgg@nvidia.com>
References: <5-v2-c86cc8c2230e+160bb-smmu_newapi_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 17 Oct 2023 Jason Gunthorpe <jgg@nvidia.com> wrote:
> Now that the BLOCKED and IDENTITY behaviors are managed with their own
> domains change to the domain_alloc_paging() op.
> 
> The check for using_legacy_binding is now redundant,
> arm_smmu_def_domain_type() always returns IOMMU_DOMAIN_IDENTITY for this
> mode, so the core code will never attempt to create a DMA domain in the
> first place.
> 
> Since commit a4fdd9762272 ("iommu: Use flush queue capability") the core
> code only passes in IDENTITY/BLOCKED/UNMANAGED/DMA domain types. It will
> not pass in IDENTITY or BLOCKED if the global statics exist, so the test
> for DMA is also redundant now too.
> 
> Call arm_smmu_init_domain_context() early if a dev is available.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)

For some reason this patch breaks booting of the APQ8096 Dragonboard820c
(qcom/apq8096-db820c.dts). Dispbling display subsystem (mdss) and venus
devices makes the board boot in most of the cases. Most frequently the
last parts of the log loog in a following way:

arm-smmu b40000.iommu: probing hardware configuration...
arm-smmu b40000.iommu: SMMUv2 with:
arm-smmu b40000.iommu: 	stage 1 translation
arm-smmu b40000.iommu: 	address translation ops
arm-smmu b40000.iommu: 	non-coherent table walk
arm-smmu b40000.iommu: 	(IDR0.CTTW overridden by FW configuration)
arm-smmu b40000.iommu: 	stream matching with 2 register groups
arm-smmu b40000.iommu: 	2 context banks (0 stage-2 only)
arm-smmu b40000.iommu: 	Supported page sizes: 0x63315000
arm-smmu b40000.iommu: 	Stage-1: 48-bit VA -> 36-bit IPA
arm-smmu b40000.iommu: 	preserved 0 boot mappings
arm-smmu d00000.iommu: probing hardware configuration...
arm-smmu d00000.iommu: SMMUv2 with:
arm-smmu d00000.iommu: 	stage 1 translation
arm-smmu d00000.iommu: 	address translation ops
arm-smmu d00000.iommu: 	non-coherent table walk
arm-smmu d00000.iommu: 	(IDR0.CTTW overridden by FW configuration)
arm-smmu d00000.iommu: 	stream matching with 2 register groups
arm-smmu d00000.iommu: 	2 context banks (0 stage-2 only)
arm-smmu d00000.iommu: 	Supported page sizes: 0x63315000
arm-smmu d00000.iommu: 	Stage-1: 32-bit VA -> 36-bit IPA
arm-smmu d00000.iommu: 	preserved 0 boot mappings
arm-smmu d40000.iommu: probing hardware configuration...
arm-smmu d40000.iommu: SMMUv2 with:
arm-smmu d40000.iommu: 	stage 1 translation
arm-smmu d40000.iommu: 	address translation ops
arm-smmu d40000.iommu: 	non-coherent table walk
arm-smmu d40000.iommu: 	(IDR0.CTTW overridden by FW configuration)
arm-smmu d40000.iommu: 	stream matching with 42 register groups
arm-smmu d40000.iommu: 	7 context banks (0 stage-2 only)
arm-smmu d40000.iommu: 	Supported page sizes: 0x63315000
arm-smmu d40000.iommu: 	Stage-1: 32-bit VA -> 36-bit IPA
arm-smmu d40000.iommu: 	preserved 0 boot mappings
arm-smmu da0000.iommu: probing hardware configuration...
arm-smmu da0000.iommu: SMMUv2 with:
arm-smmu da0000.iommu: 	stage 1 translation
arm-smmu da0000.iommu: 	address translation ops
arm-smmu da0000.iommu: 	non-coherent table walk
arm-smmu da0000.iommu: 	(IDR0.CTTW overridden by FW configuration)
arm-smmu da0000.iommu: 	stream matching with 4 register groups
arm-smmu da0000.iommu: 	2 context banks (0 stage-2 only)
arm-smmu da0000.iommu: 	Supported page sizes: 0x63315000
arm-smmu da0000.iommu: 	Stage-1: 32-bit VA -> 36-bit IPA
arm-smmu da0000.iommu: 	preserved 0 boot mappings
arm-smmu 1600000.iommu: probing hardware configuration...
arm-smmu 1600000.iommu: SMMUv2 with:
arm-smmu 1600000.iommu: 	stage 1 translation
arm-smmu 1600000.iommu: 	address translation ops
arm-smmu 1600000.iommu: 	non-coherent table walk
arm-smmu 1600000.iommu: 	(IDR0.CTTW overridden by FW configuration)
arm-smmu 1600000.iommu: 	stream matching with 15 register groups
arm-smmu 1600000.iommu: 	12 context banks (0 stage-2 only)
arm-smmu 1600000.iommu: 	Supported page sizes: 0x63315000
arm-smmu 1600000.iommu: 	Stage-1: 36-bit VA -> 36-bit IPA
arm-smmu 1600000.iommu: 	preserved 0 boot mappings
adreno b00000.gpu: Adding to iommu group 0
Bluetooth: hci0: QCA Product ID   :0x00000008
Bluetooth: hci0: QCA SOC Version  :0x00000044
Bluetooth: hci0: QCA ROM Version  :0x00000302
Bluetooth: hci0: QCA Patch Version:0x00000111
Bluetooth: hci0: QCA controller version 0x00440302
platform 9a0000.hdmi-tx: Fixed dependency cycle(s) with /soc@0/display-subsystem@900000/display-controller@901000/ports/port@0/endpoint
Bluetooth: hci0: QCA Downloading qca/rampatch_00440302.bin
spi_qup 7575000.spi: IN:block:16, fifo:64, OUT:block:16, fifo:64
spi_qup 75ba000.spi: IN:block:16, fifo:64, OUT:block:16, fifo:64
phy phy-7411000.phy.5: QUSB2PHY pll lock failed: status reg = 0
phy phy-7411000.phy.5: phy init failed --> -16
dwc3 6a00000.usb: error -EBUSY: failed to initialize core
dwc3: probe of 6a00000.usb failed with error -16
phy phy-7412000.phy.6: QUSB2PHY pll lock failed: status reg = 0
phy phy-7412000.phy.6: phy init failed --> -16
dwc3 7600000.usb: error -EBUSY: failed to initialize core
dwc3: probe of 7600000.usb failed with error -16
i2c_qup 7577000.i2c: using default clock-frequency 100000
i2c_qup 75b5000.i2c: using default clock-frequency 100000
sdhci_msm 74a4900.mmc: Got CD GPIO
scsi host0: ufshcd
ufshcd-qcom 624000.ufshc: ufs_qcom_host_reset: reset control not set
remoteproc remoteproc0: 2080000.remoteproc is available
remoteproc remoteproc1: 9300000.remoteproc is available
mmc0: SDHCI controller on 74a4900.mmc [74a4900.mmc] using ADMA 64-bit
qcom-pcie 600000.pcie: host bridge /soc@0/bus@0/pcie@600000 ranges:
qcom-pcie 608000.pcie: supply vddpe-3v3 not found, using dummy regulator

[ The board resets to the bootloader ]

