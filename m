Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFA14503F
	for <iommu@lists.linux.dev>; Mon, 29 Apr 2024 11:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390992; cv=none; b=Zq2x6XKVVzTsZpa2Q3/T7fkgd4z4tvj4QKLJlnv4C2/V0Wks4mS7NaqFMsO98mcU/ktVdBXNDl7UOnO0zrsUlDV0gOhSTShRczLMGq6a+Yqd8dJEHjSmrfYJnMmCjRg/Sie9LUpnK0RUPYYeje49K99kYr8JTagftGjYpDM+rKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390992; c=relaxed/simple;
	bh=xP9omRynCEpRGFZBVMKXP4h+HilIKdIqSnqZkJEzSkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bbbela5lh9I5EWUejpm1SH5/nxthX26PI1IMdbBjihV5Lcojg9S8wjG6IOAxI/IlrS6Wuwk16Q4bCork4us9SwX2AAa/rpNDSaVeIoPpcYBOW4AU8AaevPW7tvWr9/m/9b8NbQtzbtgc5uSy1oEHqBI4xffENqfUaUidLwZudHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N70rDzTg; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N70rDzTg"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2db17e8767cso50415651fa.3
        for <iommu@lists.linux.dev>; Mon, 29 Apr 2024 04:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714390988; x=1714995788; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4AHu2GrYMZd5nsIxhghrANJzfEVXRFCsK+/iWXt8RrI=;
        b=N70rDzTgZVTqT8yhmJchEsGK/cUUWFOy4O67qaKrJrt5snhlXsWaAAQRCm03izL7yw
         g9Wb0UDCPOinVAyMVrf0IBRBabmB+X3Kk66ONnRvTG+t/EGxygjEJzmzTPi239lvM3lo
         LoEc/eV6SpyjkfUkE8xb8ZKgQwKh42IOSFM2QCgPwKa49ZdBrqK1GTDu0/FRxnyJ3kKU
         Qb6O84sDYK+ljM1ApBGSte9ctPdxWhDNP7xanRLXLUU0r2SzeVqlXNOz9hMU56VH4kmB
         71xKriFSB2vK0WERCylxfcfJeFZFIbzYRu6gXuib4AcraGvDRORHqNUFGgZ+ktNyBFL3
         Iw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714390988; x=1714995788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4AHu2GrYMZd5nsIxhghrANJzfEVXRFCsK+/iWXt8RrI=;
        b=cWskcLobpnsidDVh/rRsWRdwFPWzOD9bPu/gOBKVX9M/GiFcGsVGrhnwQ5FPoBl/ge
         y2vWuaAxJ0x6qoM7d8+BXXdaLU929mlV41fHO/VRYZ73Ugt6ASK0DfOJhgnKK36P0hCP
         qg+sAQjM6bq8+86tcu05DJE8LZxwB7VSabk5tZpQCxxfiC9tcXYg4fmnX/A1DJty1A81
         I1yIuiJeDKv1OSUSboaRtniNoeRqZt/8UyF2b81UpAFsokf3qXHl/ZUjfiEPYS1i69fc
         en+PHoBYVsL5EsM4nnujDgGcg7cCmXBwgVYw6uhPi88Aha2crQ24f2wXDiwpqupohkZT
         pqTA==
X-Forwarded-Encrypted: i=1; AJvYcCXXneGkQHwoWuubzRF99rp7rvOhJhVRezcEXXtnHdDAVwZb86X+V5WwHTLHpFdgFQUXB3PCy3UXv/jcMJEN0rmJ3yeUms4=
X-Gm-Message-State: AOJu0YwiDrTouRy4GLLWfZ7LqtgXopk1/efrPpPu/3R1EVroz/Sv02Zv
	oLPVOCLe+QicEj/Q2tUl5WcduBD5IogJFSzVwFKGpfgmf066w2o4cZFWlMaMpzU=
X-Google-Smtp-Source: AGHT+IEM/SX8JWy3onOefygk1LTTCZaAW7PQ3Tj7tXR9aiLyU2Z/2Z/HvLOTcE/H0E6Xb96t5e5h8A==
X-Received: by 2002:a2e:901a:0:b0:2d8:4169:3a58 with SMTP id h26-20020a2e901a000000b002d841693a58mr6273268ljg.41.1714390987975;
        Mon, 29 Apr 2024 04:43:07 -0700 (PDT)
Received: from localhost.localdomain ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id j28-20020a05600c1c1c00b0041bfb176a87sm7006611wms.27.2024.04.29.04.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 04:43:07 -0700 (PDT)
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
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH 1/3] dt-bindings: PCI: generic: Add ats-supported property
Date: Mon, 29 Apr 2024 12:39:37 +0100
Message-ID: <20240429113938.192706-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429113938.192706-2-jean-philippe@linaro.org>
References: <20240429113938.192706-2-jean-philippe@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a way for firmware to tell the OS that ATS is supported by the PCI
root complex. An endpoint with ATS enabled may send Translation Requests
and Translated Memory Requests, which look just like Normal Memory
Requests with a non-zero AT field. So a root controller that ignores the
AT field may simply forward the request to the IOMMU as a Normal Memory
Request, which could end badly. In any case, the endpoint will be
unusable.

The ats-supported property allows the OS to only enable ATS in endpoints
if the root controller can handle ATS requests. Only add the property to
pcie-host-ecam-generic for the moment. For non-generic root controllers,
availability of ATS can be inferred from the compatible string.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
From a while ago: https://lore.kernel.org/all/20200219222454.GA16221@bogus/
---
 Documentation/devicetree/bindings/pci/host-generic-pci.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
index d25423aa71674..94d4a4914a483 100644
--- a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
+++ b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
@@ -110,6 +110,12 @@ properties:
   iommu-map-mask: true
   msi-parent: true
 
+  ats-supported:
+    description:
+      Indicates that a PCIe host controller supports ATS, and can handle Memory
+      Requests with Address Type (AT).
+    type: boolean
+
 required:
   - compatible
   - reg
-- 
2.44.0

