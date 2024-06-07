Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A9478C96
	for <iommu@lists.linux.dev>; Fri,  7 Jun 2024 10:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717757897; cv=none; b=Hqz326IpsdZgHXlLK1Qjx4yaR7xRyk4BThQ5LLUEo8uZfZv9iZPm0AD+a5q+s6w9rFUFkC5L6zBIajxSZdPJtoeIhZ++s+hn+FrTjKxN14DLspF2Vj1fcF29zzOLPVcjddeq2MJPDyRwIeJBZAanKUfLYViVYSO8EUpICBFUTzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717757897; c=relaxed/simple;
	bh=YoraCC2os5H7WkIOISlbddzHD3ToIZOoofZYgnih/84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OjvMt/blEeXlt7B/Xk0pZTsS3ak0qJ3n7r5rgpcCuEXnTqJeg7J/PbZnQ/c83bvMeUGcBRu0DtV9tADSVNwrjCEyJJOe3ALMq/By+uFK3I3e5KaoBn1fV49Oe17Xr5LCDexM9gAmyMTMT4wBCG1+KpJ2dCoeBqTz7EiO2BJ9nRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RfGn78OO; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RfGn78OO"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4210aa012e5so21061075e9.0
        for <iommu@lists.linux.dev>; Fri, 07 Jun 2024 03:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717757894; x=1718362694; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E23ckA0xadlytKJal2qSBXEtmljMi1zr8ZXYYtdmN4A=;
        b=RfGn78OOKe6ACMQQ85iVHRexklqsCecuevvK/QuH/XSn5mreLp9ss6SiIIQgg9MRqt
         L67wfmVxK+/Mgg+gkoS8xT/LGPAFYCYQDwJ268nUQ5tihAtVrZLzHkSBKAwe73kW9+lg
         r6g+RIPhzWzHzY0swypBU6o6VMHmE48SFOTSYGShvz0h/IVpfSM8DKHpPUN1fhWUyiJS
         pyOdmsZQH/2Zm8vsHe7alRFcmf0YyXFq/8o4sWF7fu0ql8uWRSw7py9JZO3EEVHTYN3E
         XNfrLi65puWGwNJNMWj/x5GAY5dNaZxuSKbtjmLWZjzv/aY/w1mYX4ITFjZaiyvAtw60
         ntBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717757894; x=1718362694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E23ckA0xadlytKJal2qSBXEtmljMi1zr8ZXYYtdmN4A=;
        b=lu2TKZg7Z37M5UT0AfkgzUbO91EyJxTMZXfVJo4TCSEluzSWkYk1LBTuBaE/p0OkaO
         IX8yBTQmUBkVurc57rQhmaGjK373tg/6M0bUPl9QN12RUInVB5NId5Z2SBkQrUZLKoR2
         aSJlvt/aF+1lbfI0a2+AMZmCGslKp0slFvT0dG4frAfO8sMOyGP93WQYGkSIUf/OYzE4
         D+Fd27qmcQe7169h1Ou6eJtIpSGw2zxD5COWku1MNHF7jdUZLmqiH+NEg/Y3oAX3wRDQ
         sgUmuvzdPXJ7ac2O4fWngTdUddDMVgjT87f8xDHizbzai9gKXxB7Z45Je0HJhdOzpSZT
         s1oQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBcl1MtDuc1P6hXxqA3jLJumP0NMEGPY0wj5z+vpISq2Lxwk8ngjJJAU1WBktdXaTp7QoLCq5xkm2Nqg5lUjuhVitvLxs=
X-Gm-Message-State: AOJu0Yz+v6TwOQNqVNU6uKvjfveNGBVPA2baQ+TdrUGVSACZ8LgUES9P
	C9thvFLCcMW5fTOEobnJcdgXBLCbnlX+VF4kg0pOFKaSyrmewfn+F9x+3/1+lNI=
X-Google-Smtp-Source: AGHT+IGRk39n3pVihAfcUidolbx9s1isjujkvF2fjkdGKFvNrj6NpUKCDBYYeIDpXOQ0xz5Q/dJp6A==
X-Received: by 2002:a05:600c:1d03:b0:421:54f7:c294 with SMTP id 5b1f17b1804b1-42164a20c82mr19745275e9.29.1717757893769;
        Fri, 07 Jun 2024 03:58:13 -0700 (PDT)
Received: from localhost.localdomain ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5fd1c5fsm3739485f8f.113.2024.06.07.03.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 03:58:13 -0700 (PDT)
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
Subject: [PATCH v2 1/3] dt-bindings: PCI: generic: Add ats-supported property
Date: Fri,  7 Jun 2024 11:54:14 +0100
Message-ID: <20240607105415.2501934-3-jean-philippe@linaro.org>
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

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 Documentation/devicetree/bindings/pci/host-generic-pci.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
index 3484e0b4b412e..bcfbaf5582cc9 100644
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
2.45.2

