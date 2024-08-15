Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89217DA79
	for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 11:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723721112; cv=none; b=kIePEaucFpwddFJwIeWITMzBslUimDtGX69t5yAuSBjs62I6Dv6jYXSXcDoKTPmeYURFalvEsdVSbAsZZoxve4UUuIJEfb6oyZWlzUZX7CnnMi57zt5wk35ZqrkC9tu+QqflLPm2KtOjx3zEl4mBeDl0QyuK/wF8WhhnfavBy2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723721112; c=relaxed/simple;
	bh=lFo5gIFDvq0nCBY9vqftpLu+gTHD6YABYYNyYZUhWPg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=unVVdHKvG9sPEhyDekvFmpR8MmI8ttRwMlHOwTWDsQv9TOeFN6mfaTOJr0zxOz0CzDlK6dNOyM3b766Y0ipu9JB5XMqJ6cxSD4s6bdX8Alw5UCAJORa/P9bTOLSPyJ60f3CnQE+btfqSsufHgBT5liFNnt5CP89H2+Hu75uj0lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vuzwkzrM; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vuzwkzrM"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a15692b6f6so1144201a12.0
        for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 04:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723721108; x=1724325908; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sJgccsMLKlvTr7kW7rYfi0K+07lJJOFz1A3IB6P2Qqs=;
        b=vuzwkzrMaC3i2hQavwA0xJQhmXmPGRZJtfTN0UM0r4RHJdj4hjl2pAF0XsdZFEs/SU
         PQuhx8P+dNAGaIQDIbJaEA0WqCH2r5jKbI4zPOXV+06XTJm0DM0XZrRCkFZupwQRjlio
         fkYwxXOQVZFum2rROusaFHG40eNp1hmBVwF0pA7dO4pQIHBsFGQ/AHMRn5ZnslFE2pZA
         C36z0ttjp7tOj79YaAjwgggPV6/gt4ooSx5zfwcKL0uvOJe4fe7lIwoIjUw7OPlZB9oE
         d+edYHajzit3TS4G/LHyyL+sbCaQCf+7YSpBqVbEGDGPThtKrBnpE+on6G6S1dBgGRC4
         b4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723721108; x=1724325908;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sJgccsMLKlvTr7kW7rYfi0K+07lJJOFz1A3IB6P2Qqs=;
        b=K5C5N8oobar1ZjS5afcMgJ0GUkDuIfzmt++2DgpmHCWVK6Hs66dsEmAbOfo2onziWY
         UfGdFpXlYRPZSzTLOWo5AF0mw09Vxhq329oiixNEM4YgtBpaeX40CKp3XfUEE3kvtXJk
         40z5Q4uvlJvHVUiczC2gWFr1N3w5wpkvtd+mHdwBVIuKwXDiZQCzIIsfgSNOwF9xl2M3
         Bed/B+esH9A+7oGmID1aZ1xxXKXJYe1T6cufmMsddR6QY7289mzTo65ZOoevreG8vR+T
         HcIMe/90EmNqc7KGsGJgCHdWkn+mXosXeWOAU59r8rv5XfxF6z8g8WE6AUeU5AsOWUKp
         Q8KA==
X-Forwarded-Encrypted: i=1; AJvYcCVCpLErqoEI+wleTpa2wymwf66iTUs08VAiUtY/hbwqRxgWofpX2jMLVcH6Y9+KJcw6yk5BA6tYUb0D3c7WhALWncLApi0=
X-Gm-Message-State: AOJu0YwEPbcPxuuoAUiAWGdM/rimqjZIeaumOtF8hNmCcxvF1Ern5LaG
	3Lbz2khgINqHBkvoKrvDDlbJMe3mYPXU/F5ogBXUBF51kjVsy1Q4vIzXIIHcbgg=
X-Google-Smtp-Source: AGHT+IHwCYaVWrDMM/XxSAgRaGSfa25IQdFx+8Hr+PoYjdMN7joZtfNCMY3zxeI7foru5gpy24rJbQ==
X-Received: by 2002:a05:6402:3227:b0:5be:bd48:e4ca with SMTP id 4fb4d7f45d1cf-5bebd48e74bmr1231063a12.26.1723721107693;
        Thu, 15 Aug 2024 04:25:07 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbde48fdsm769217a12.28.2024.08.15.04.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 04:25:07 -0700 (PDT)
Date: Thu, 15 Aug 2024 14:25:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Michael Shavit <mshavit@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] iommu/arm-smmu-v3: Fix a NULL vs IS_ERR() check
Message-ID: <9208cd0d-8105-40df-93e9-bdcdf0d55eec@stanley.mountain>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The arm_smmu_domain_alloc() function returns error pointers on error.  It
doesn't return NULL.  Update the error checking to match.

Fixes: 52acd7d8a413 ("iommu/arm-smmu-v3: Add support for domain_alloc_user fn")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9bc50bded5af..cf21d7d2e737 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3062,8 +3062,8 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
 		return ERR_PTR(-EOPNOTSUPP);
 
 	smmu_domain = arm_smmu_domain_alloc();
-	if (!smmu_domain)
-		return ERR_PTR(-ENOMEM);
+	if (IS_ERR(smmu_domain))
+		return ERR_CAST(smmu_domain);
 
 	smmu_domain->domain.type = IOMMU_DOMAIN_UNMANAGED;
 	smmu_domain->domain.ops = arm_smmu_ops.default_domain_ops;
-- 
2.43.0

