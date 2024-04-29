Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE7247A64
	for <iommu@lists.linux.dev>; Mon, 29 Apr 2024 11:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390992; cv=none; b=DZAJryz3M0bSulzQJRBhGz9zOc0DiLzCzYcqLG77zv/0+mLwvwF8aV/jhe756bR72YrOstbAHQwAV/EJQsvqOWa9IqErvaxthh/ElRmTeHzy/IPStyXTeJw84uGYUJ7wmTAdRA5gAlAGF+RK1qp1Wu7AJhBHDzDqyf0YAtkbUp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390992; c=relaxed/simple;
	bh=wlwCiZQhxacSX1iOcX1bXb8eeSP8O9zxMxdtgI9EZUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D98cN9lIMxFzF+ZyrkbOazENwNbaJHJCohA/QCCyRIwhWZUZEFgSjF0E2tKsFtzpAWYWZLGC8uBpN4raJ1Gg256smphZL0JpVYFYneCPQ22pin5FQP+5CfC0D3ElOlVtFwuNZkiV5NZYGRNzuUl4eq7v8knO4DgJNzf7yI0mb9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JkYPzAGu; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JkYPzAGu"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41ba1ba55ffso14740925e9.1
        for <iommu@lists.linux.dev>; Mon, 29 Apr 2024 04:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714390989; x=1714995789; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i14vi0uS6yalE2yHHE98+WWyzuINERvn0mRjSQcogLE=;
        b=JkYPzAGuUmtGDTa9EcOfhg2s2k4V/qpwQkqkfYc5MBW17ItMyarmUQVB65FOuf0ecI
         6drKoUiA31T/mYBcsFAIYoZThgQCwh0x3kCinnuntjfUeK6rZdCJ82NgLnhCn5ZaAqP0
         KHrSYUfHGIKL6RUIGfHYGUvzrUHvfqeRsQ7f29W+aV+U+1ulUR/kYDq/lCAYcwcn9PFx
         vmosSyqGFl0h8E9hYDMwrvitqIcPqqXADrmBqU0Nnn0VoHBay2DlYLBsAy2tPptp5Cel
         v2SPikMGMxDd8xXb5tN13S7qucIzKocy34u78mA9EjEzvZD72fHm+DD56Ay5CYv1vQlg
         LqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714390989; x=1714995789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i14vi0uS6yalE2yHHE98+WWyzuINERvn0mRjSQcogLE=;
        b=WPMSb5tQQfE362lPewF7z3WGPzplH1OyCab3SQx8FPHlLHaT/zIxAGsCZ855CWKpkV
         mKDYlunJvz7E1PRZBACw+pzPzXMjaox/ezNmROrlQoTcwaCwVPOnp7Cp0mUizQ7YnyH2
         Y4Iafoc0oxeIFG7LCxYvNUSHR+y7v8VCLB3osqRMTPYxkwqaRe3w+cYrj4LOQUAP4yH1
         EPblMTxwNvMZ3qis5dJOG63wFzyOYVGe5jw20feD0aKh0ZeFOOx+szmd8Vzj/DmcjcRr
         OCC208RWbf/Ub65gLTpi7NAtFnZsiNZ14HH2VCh/BXKcCbr+wUDx1tcszJYr0+MvATPu
         P6Vw==
X-Forwarded-Encrypted: i=1; AJvYcCVsmPmZErVvVTVge+33YNVD5ShnsD6szGeWVMrMe016GV59jV4mDTaibGxSDwjKNypXD4kAWXm5+mwwsrtgjZmXLljMaVc=
X-Gm-Message-State: AOJu0YwN8rkkY3OSKLlCpCMwYrz2qOG5OluR5GmHS6Ddte9FP9tsGgzj
	6yeko2d9lMUlOCKHTMtYLBIERHS5TaClC/ESvakIszbfEcP3F1Ok8jumY61nAYs=
X-Google-Smtp-Source: AGHT+IEI1UVkZOMPYRMSz4HtjyDrrZTWNzj/RlriUs5QHmYdGK5xHJYWjf4nbA7zpSf33ACYcYdQ4A==
X-Received: by 2002:a05:600c:3587:b0:41b:8c5c:31b9 with SMTP id p7-20020a05600c358700b0041b8c5c31b9mr7553097wmq.14.1714390989553;
        Mon, 29 Apr 2024 04:43:09 -0700 (PDT)
Received: from localhost.localdomain ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id j28-20020a05600c1c1c00b0041bfb176a87sm7006611wms.27.2024.04.29.04.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 04:43:09 -0700 (PDT)
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
Subject: [PATCH 3/3] arm64: dts: fvp: Enable PCIe ATS for Base RevC FVP
Date: Mon, 29 Apr 2024 12:39:39 +0100
Message-ID: <20240429113938.192706-5-jean-philippe@linaro.org>
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

Declare that the host controller supports ATS, so the OS can enable it
for ATS-capable PCIe endpoints.

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
2.44.0

