Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CE81862B8
	for <iommu@lists.linux.dev>; Fri,  7 Jun 2024 10:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717757899; cv=none; b=egCb0Qwa6u0EBEX5IfIyxHSC59AFD1Cdp34D5fJD6/83tuC/ISTYMMhW2UY6EU2m8rkrd3yNmiPB72VYLrG44cHX0PJ/e+aeUiVcDAVqQaTARGcZODphasxN1ylMGEXq10GaImSsqedI06yKFeaAXbQkn3vj9NTJb692Xr/uulk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717757899; c=relaxed/simple;
	bh=XeqHKq7C6ItKeEGvPXNfkHtkfptWdfLnGM+VX6C608c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KgTRqzVD788s7EGsVNAp7bIv41RlCD1oJvXLoHO6KqRhUVzKQUV3vHxDCoRmJE38ZFGo4Yqrm7swOyjJuOOcApd3Ez/BLF55j+cfKqmmRMM2jqqZySoIJnL9SXMpE6tUnq0V+K65nQtxrDLEWpTJ8XbHXLsaVQRVje++YcUHhBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VYMjdfZ7; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VYMjdfZ7"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52b976b5d22so2793255e87.1
        for <iommu@lists.linux.dev>; Fri, 07 Jun 2024 03:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717757895; x=1718362695; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDcq5k/0ttuhuW1s9eNFA8PIx5mHSgVIL61fKi53/Ns=;
        b=VYMjdfZ7QtmpLALbqOaqdM06VPIoTbIdRsojonSxAoOGRAu22xRIpcV9Z3Fx2HWyV+
         2N4fhWMLEfP/YCEw6vJNXWWn9ix0ZdSv155RKySDdJ3j+nKFzVdXNPIZzBhAUe9K5uxj
         4umdl4gIrtQ5aG9oO5++KfKoDTcKuV5vCphBPSZEFvds7ILjRCvjNAP913YlvGp6RUJ6
         bpL81yUueOt1b1j2ganoW41MtKTbacbJ/V6UCKIjZrz7gpl6gcdpeUgXkvvLHtH1osOn
         nhhfgEqOHh/i+Ogk35W9hD2po2cDiwuRVpAujymvWBYq0FFh523kK47fJsjU8yNaMJqo
         TwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717757895; x=1718362695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MDcq5k/0ttuhuW1s9eNFA8PIx5mHSgVIL61fKi53/Ns=;
        b=YDKFh/2Ifdx6/qLNe9zTc1Zpq2uTQnfDQhp7/Knh0eHi4XE+goCct8vHt2100q/cre
         oa0Cc2sKluQhsYQz4NSeh6srxlqL1sIN0LbqO4UVm6e1GSBuqgxLkP0U3Ge6mXRRMCJU
         te3zy5upD0UUYfjK5v3OuCE29U/VW9/s/W7I1A2dpOpj5w4uBuIXI1WAXoiOEeoockei
         bn88xVxiZE7ONsIVA20BVyNYo0CJSky5CHG29Wj0bZAN+FRfe1BSd5gtAdmrz0EIRk+A
         2Xyr1dEkm3imnlzpf9foDDq2TJiR2IxHZMroyt5EoAVLgsTsjTSp23pdSo94Lqtg8aaq
         Zzjw==
X-Forwarded-Encrypted: i=1; AJvYcCXUhcnqSFtFm/VNI61w7vQ/yhxwKDcUDErMoTTMrbltFeCLa4NSQITZbDhxh5+h5bUz4ONUOjvorKH04Q30h87ZHEgvl0Y=
X-Gm-Message-State: AOJu0YzB1yiuH46eisuhZliW0BJOFbo0sfR8rVutVRmPfOKf3T/GaFFS
	UlVLG+gGnBSkLDCoFx4FndrkFjc/Ujyx4Bz2zXK897WCnd8esFdYKFhvLziFqbU=
X-Google-Smtp-Source: AGHT+IFKBOo5vF96Rp1eu8L7oXMzKFGJxvSnCqz7HcFftnGZ/GajF1ZZWz5V+BiNnKs89U3LBYWGnw==
X-Received: by 2002:ac2:52b5:0:b0:52b:b173:7490 with SMTP id 2adb3069b0e04-52bb9fea373mr1207405e87.68.1717757894609;
        Fri, 07 Jun 2024 03:58:14 -0700 (PDT)
Received: from localhost.localdomain ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5fd1c5fsm3739485f8f.113.2024.06.07.03.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 03:58:14 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: will@kernel.org,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	liviu.dudau@arm.com,
	sudeep.holla@arm.com,
	joro@8bytes.org
Cc: robin.murphy@arm.com,
	nicolinc@nvidia.com,
	ketanp@nvidia.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 2/3] iommu/of: Support ats-supported device-tree property
Date: Fri,  7 Jun 2024 11:54:15 +0100
Message-ID: <20240607105415.2501934-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240607105415.2501934-2-jean-philippe@linaro.org>
References: <20240607105415.2501934-2-jean-philippe@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device-tree declares whether a PCI root-complex supports ATS by setting
the "ats-supported" property. Copy this flag into device fwspec to let
IOMMU drivers quickly check if they can enable ATS for a device.

Tested-by: Ketan Patil <ketanp@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/of_iommu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 3afe0b48a48db..082b94c2b3291 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -105,6 +105,14 @@ static int of_iommu_configure_device(struct device_node *master_np,
 		      of_iommu_configure_dev(master_np, dev);
 }
 
+static void of_pci_check_device_ats(struct device *dev, struct device_node *np)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+
+	if (fwspec && of_property_read_bool(np, "ats-supported"))
+		fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
+}
+
 /*
  * Returns:
  *  0 on success, an iommu was configured
@@ -147,6 +155,7 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
 		pci_request_acs();
 		err = pci_for_each_dma_alias(to_pci_dev(dev),
 					     of_pci_iommu_init, &info);
+		of_pci_check_device_ats(dev, master_np);
 	} else {
 		err = of_iommu_configure_device(master_np, dev, id);
 	}
-- 
2.45.2

