Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C00D16EC19
	for <iommu@lists.linux.dev>; Tue, 14 Jan 2025 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736870800; cv=none; b=NhAFVESJ3Wu2tpx4EydfPlYbkUVf0MlFfqmiBOPkzP9kDQBJHOJejDGTMLZfrF+IY32jh2bvHOXbLI4govG+GClmXKUEtfnh6DoFoxtcEzAT8t0Fjs2Ha+46DRkNzkcMak2WPlofPkGztnl2NX1sh5bVLx3Vsq8bKNr+qGOPIxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736870800; c=relaxed/simple;
	bh=dTe+nnPsZi8oBCf6r8VEkl+bNZLPtuGBo7vS34l10Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IE52rqNkiZLSIsuUc7tQ2xKOtcz4RlZ9rn95yy6w5hDbqRgkWxnTCOqOjY9z7C2u6Z4LIdhnSgzvGInxVia4IrDyT0T8aio8Mh3FhIat5fFlSFJkQ+BSRZczq5zXjbAvCIpwh/QfSZz1KSH5s+f4JYgN4ZChUq6aIFvFYK/jyFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=CjAT5STA; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="CjAT5STA"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43621d27adeso39606285e9.2
        for <iommu@lists.linux.dev>; Tue, 14 Jan 2025 08:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1736870797; x=1737475597; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0gqmZQACO9w3LJC8YO02xH6lzr6nCg5VTTM+s1OBnzI=;
        b=CjAT5STAR0uf1ZjBbqr147bq+wSZIECjtcUVHHh6ALe4zkPZeR1m2RjL96CZ/xIONF
         rfZwQ4TtiocTcPKq57KJFF8npKhBdGIL0EPf4uDUUj85tmpjOqHAYnDguQmiMdUVbQFs
         G1N7vjp2+utQfHRJDv4r/WZzOUMNgxdcAWdFQrDNLRigsGDAVxX6CwJjtD4Wrh6Q8gy2
         Oil0i9mcCEvSZHnAZzq4tIL5AWsA4DM/mEtccTeanCz/1x7nMg1sTaixA3LdMqDRtrIC
         oLdZ8OgbK/jtADq7OLMQpLr3fSChnH1xZf0+liNnvaTrleu/llZUp+XI+NGmBZ8K/wSr
         Xfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736870797; x=1737475597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0gqmZQACO9w3LJC8YO02xH6lzr6nCg5VTTM+s1OBnzI=;
        b=kjwL5VoavSOkcNVNX3dF9m7ayVZZTHHwKneHU5ZKVNWGIXuQi0unc1Q8ij/QwZd475
         pU30pEgpjTjnFLWj5w6PU4b5M5grkViEewXdp/adh17g2HcGEc5xYPjiVoNbBk7X/YD0
         HfIgJRuwPy02t2AgDGzzNRaVjV/5UVb4CGAAUbReEpBN8AeyY0ZJ7GmPHx+Eo447/u0C
         7j7itl92A0oosd1VoxCPHvqqGhdiV1WLS9SiNvp30F1+AXJ7Y+B8FgwqSW61hUYEUNwP
         aL/E/27bkqX9npvmvRztc7B3nRMRbXx+C2gZ6KpbKp+1+Ogs8Lxr3gyUg/lmQ3IC3qZH
         YPdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCuobaJdSzhELaA1xR4NeeRHQGTVje2NCpOzXBv4/VY+4InrOQWHkhTazz+mFMEgJTkNPR5g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzL2GcMEnGdw+OrlZ3c5Ol6L0CZxNIMlyD+y21f+S3GPULDEBu8
	gzoa55UhE7D0e8e7MeyOTOdK2pVPEu5mUo50Y0zMcsEFAMF5uze82p+8XtLidxZpK+SXnGnDe6n
	QLGI=
X-Gm-Gg: ASbGncvcAtf/liaTcMY2SA1Hp6huGBz6pk4uXb2gRc3MKTkNbJdc2Ft0oK1D1TTFjSF
	F8RYv7c+TWBFEIkfwimFypOKPgOipRwqbGB7pn3y73VHFdT85ZoHZ4BcHQ2YBxywGLnjo+vuN0W
	tA5WVIQrFBBkiC6klPAZnBBtLfyw7tOw7YjUM2RovjyHdUnVbSvuSjGT2wtnzbqI3VihlpYnb1c
	ibfq+p/0nmOAF5cmQRsSBUs+Fje/MDa4U+HLe7wqpRAgItTd7PaHRwkRH/O0UfUpIJJVKwQXxyb
	xJ8MOW3YZgHCh/EO
X-Google-Smtp-Source: AGHT+IEtcRD15Bkfdih9jwWpz12XEXEvsL3qzSqJKpUX7+iTScQQy1np3E7eSsjMUQXP8bE7n8kudQ==
X-Received: by 2002:a05:6000:178d:b0:387:8752:5691 with SMTP id ffacd0b85a97d-38a87309d15mr22654193f8f.47.1736870796430;
        Tue, 14 Jan 2025 08:06:36 -0800 (PST)
Received: from fedora.. (cpe-188-129-45-73.dynamic.amis.hr. [188.129.45.73])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38a8e38c1d6sm15505594f8f.50.2025.01.14.08.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 08:06:33 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: will@kernel.org,
	robin.murphy@arm.com,
	joro@8bytes.org,
	jgg@ziepe.ca,
	nicolinc@nvidia.com,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] iommu/arm-smmu-v3: add missing header
Date: Tue, 14 Jan 2025 17:05:56 +0100
Message-ID: <20250114160630.1122885-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

str_read_write is currently undeclared and thus compilation will fail with:
drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:1911:25: error: implicit declaration of function ‘str_read_write’; did you mean ‘sb_end_write’? [-Wimplicit-function-declaration]

So include the missing linux/string_choices.h header to fix compilation.

Fixes: f2c77f6e41e6 ("iommu/arm-smmu-v3: Use str_read_write helper w/ logs")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501111926.qOpnlK9J-lkp@intel.com/
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 0e4cbb2c64d7..a0e395da8a88 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -26,6 +26,7 @@
 #include <linux/pci.h>
 #include <linux/pci-ats.h>
 #include <linux/platform_device.h>
+#include <linux/string_choices.h>
 #include <kunit/visibility.h>
 #include <uapi/linux/iommufd.h>
 
-- 
2.47.1

