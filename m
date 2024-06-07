Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DBD18629B
	for <iommu@lists.linux.dev>; Fri,  7 Jun 2024 10:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717757899; cv=none; b=eIrTCQlKH5tFPoA9cZqNErt/b2nyXK8cphsZR/7Uaqb+bJIUAIm8owT0Pikblu14vk6FZi31RHu12jSQ6Q2Z8NjjRJbYp+yw2aLIGtJFQKxj6PNAy0T3kHgOsK/JTi96sekrRUpPgLxl48mApJjH4XO2Olocor5yXLPlOUddy7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717757899; c=relaxed/simple;
	bh=O41O/1MskzYdTSPlRhjh40nzcnbFdwsOlCE890eRNOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LdQGaSMDDZ4phSFfCHpKOJ25wv8iT0NSKr4j0zSBEuoJEE5Y+qsZKGIs1yiEH6ckI4Xy8GbA4OGWQ+y431babJmBzo/ojQfbS7Ckz5UXPPd4g2jhkRiQLiapZH5Peg++g6o5YgfAec/V0yBK0eu6MswSvgH5xMdRVhlJF6l7RG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qof+tzS8; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qof+tzS8"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-35ef3a037a0so1107839f8f.0
        for <iommu@lists.linux.dev>; Fri, 07 Jun 2024 03:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717757896; x=1718362696; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjEqBh5QuB3m0cSYJF5Sevhh+bm02dLUsdiKcr4Stbk=;
        b=Qof+tzS8U7MWhcJhVpYlilGPPcwdulvidqf0LQWfap4dX3j2ko7AqT7ALQIWFcb7tX
         wF+a4Tol9gPCr0tYss1V+CQM2gjmEbNQGMEX3MNLMawDScfQqsoPZm2wS/kUoM/z2DzS
         RN7q/N2motxxGIKK6qy/UHQJm9lZEbtECeha3zHJUBwy6CSlAXti/nuHGcV9I6/5kK/J
         IISRshlLVKdnyTiqgvP3/4ApgKu8Z1Tgknw2WnwkmP1Wn/0npt6vE86u6khnHOoHojEi
         3gXUYeA8uNLeDQe/6J+4DUPqrVLsxuRyiLuXqnOlasqVoUeVi3uQuoaGMZ2TEfdcwHmP
         tkBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717757896; x=1718362696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjEqBh5QuB3m0cSYJF5Sevhh+bm02dLUsdiKcr4Stbk=;
        b=nUiVZmE5HRtbq4vhuRouSE2T0BvGkZJmUGj9+MnmwM1kk0HpdVwnR0nKGj/jazrTqj
         +Q18ULw09hmU9JxicgWkin2rLQODfGMA5qgxDCZE8ibv5DUDLqjvZceJMJLjPibIyTj2
         FuZ2C0Ce4zuPc7N00wbashEN9dx6p6x6Z8IFI8ZobWJQUkYfqSeTojQW063xKe4j6uHY
         duQoFOxQV2CPdUtCPqA/iWGZNUMKY+CdFh9yLzYVtNl7+OPqGe0kTHQWbTfMqr9zeHVG
         K127Z8qMcote8byWo9uNEwrlXmSkADMdN9Jebbs4N6TbBv98m/qejK+FPPxT0V6GO1zW
         KJNg==
X-Forwarded-Encrypted: i=1; AJvYcCVTpYAVkdqOWcKoEE9nyqs7GleobezqZozZa7+joYSO4d91bi93IGxezHzNI1zcHNsIuuEJ0+/MIxoZAMnIBzgbPVhSRgw=
X-Gm-Message-State: AOJu0YycFbjhJar9IbKIDidI8aScUuk3dlYCIm60+FJRtFsWzSmpwb5A
	gvN0pL8WPunvzpoOk83tUpSIQMyhPL34BKt8FxX84U9IgdHpDdQUgcgW8OF32w8=
X-Google-Smtp-Source: AGHT+IFX4FLgpNJ8GaYxoZxGPgBzPu85Hq8iJpZp9pD83eICpSj6uwNOOa6+5UgHkLP9J9gGJbKS8w==
X-Received: by 2002:a5d:5090:0:b0:35e:ec8f:cb3d with SMTP id ffacd0b85a97d-35ef0926828mr4809560f8f.0.1717757896329;
        Fri, 07 Jun 2024 03:58:16 -0700 (PDT)
Received: from localhost.localdomain ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5fd1c5fsm3739485f8f.113.2024.06.07.03.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 03:58:16 -0700 (PDT)
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
Subject: [PATCH v2 3/3] arm64: dts: fvp: Enable PCIe ATS for Base RevC FVP
Date: Fri,  7 Jun 2024 11:54:16 +0100
Message-ID: <20240607105415.2501934-5-jean-philippe@linaro.org>
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

Declare that the host controller supports ATS, so the OS can enable it
for ATS-capable PCIe endpoints.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 arch/arm64/boot/dts/arm/fvp-base-revc.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/arm/fvp-base-revc.dts b/arch/arm64/boot/dts/arm/fvp-base-revc.dts
index 60472d65a3557..85f1c15cc65d0 100644
--- a/arch/arm64/boot/dts/arm/fvp-base-revc.dts
+++ b/arch/arm64/boot/dts/arm/fvp-base-revc.dts
@@ -243,6 +243,7 @@ pci: pci@40000000 {
 		iommu-map = <0x0 &smmu 0x0 0x10000>;
 
 		dma-coherent;
+		ats-supported;
 	};
 
 	smmu: iommu@2b400000 {
-- 
2.45.2

