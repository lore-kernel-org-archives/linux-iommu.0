Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24761199C9
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 08:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nF6b/AQ4"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40537481094so61136465e9.0
        for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 01:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697011285; x=1697616085; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6DPOMkbV8m1dOR5Sk90YZJLjnmUA8RGbfyNkiDIQZzk=;
        b=nF6b/AQ4HzXM3AbSvQuLlLdPnZS+IQxIkguRQC4EwyzLCGRArmfRO9HiII0ZfYDHfC
         9mfjDEVU01fU9bJhdpmFdUX8bJaLEhQ3900R+FC1bI0b6rJF0A4ELcotO8Fbkg+G1ATF
         Ecvs6KEdY8j4awCgqhHT+sqaeFE3L1mbZlXzZi45gmXK3wadxsRNp/XH0LlLm8DzXWt5
         OJg1tTwDUgYLHkWvP4oNjW52X1OLt5JKWu1wHZ07lgK2U32xlzclFM0bQDGPbygcBLLC
         NWW8imfNnDeghIx2nnqXXPfhwE8ViOpGLL1dmoEym0vKLWd5FeR04bOpms92de/MkI8T
         h3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697011285; x=1697616085;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6DPOMkbV8m1dOR5Sk90YZJLjnmUA8RGbfyNkiDIQZzk=;
        b=YXD+3o6HWfzFgFtP6lMvytY9RTai7c7KUubJk38p/1QyYOe8w0PJvfInUNvMkhjA2V
         m1xOK0eJAVLRhBLmvHNhPnDCzjbOxl68p9qdDTIfcAILn9PjPbtxSq3eRGTGD2KuMnbi
         PEQ6cNscD3PWL6qFqp4GD/2mdR6wy2JKLMzt3pufjPHJFe2XCIs1qL8qkqr24ISftqX9
         gx1fFg7gCKObjG+JkCPTwgxdrOC/A0rJme9MKM6W6OTHlsqNfLxfWeq5ropEhiduuIf/
         E+QRd1PwKezfmZ0AWyHmgQm3TwatYBnPhExM8qRwoYWrBeTQX1fjqTFq25tGYdnb1nSI
         ntDA==
X-Gm-Message-State: AOJu0YwHccWhRuNUwcJdOvgs0FCjepeZvkHa8bpNjzg6aheePZfNa6I3
	VmCnLdGVl1dUKP+qlnSBtPuOHbDvH0hwM13YSXM=
X-Google-Smtp-Source: AGHT+IE7TrMElZ+MD00E1lGL1rYFkYEf2CQuJZ7ft6WMMefYmJIMZYoJAQLIUtkDtLsxIDRMMlS7aQ==
X-Received: by 2002:a05:600c:22cf:b0:401:4542:5edd with SMTP id 15-20020a05600c22cf00b0040145425eddmr17894937wmg.34.1697011285253;
        Wed, 11 Oct 2023 01:01:25 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c3b9000b0040684abb623sm18613958wms.24.2023.10.11.01.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 01:01:24 -0700 (PDT)
Date: Wed, 11 Oct 2023 11:01:21 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, kernel-janitors@vger.kernel.org
Subject: [PATCH] iommu: change iommu_map_sgtable to return signed values
Message-ID: <06672b96-23fd-424c-8880-1626e7bf119c@moroto.mountain>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The iommu_map_sgtable() function returns ssize_t and negative error
codes but it's declared as size_t instead.  I think that static checkers
would have complained if this caused a bug, but even though it doesn't
cause a bug, it's definitely worth fixing.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 include/linux/iommu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 0c4d8ae985ac..b5b254e205c6 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1118,7 +1118,7 @@ static inline void iommu_free_global_pasid(ioasid_t pasid) {}
  * Creates a mapping at @iova for the buffer described by a scatterlist
  * stored in the given sg_table object in the provided IOMMU domain.
  */
-static inline size_t iommu_map_sgtable(struct iommu_domain *domain,
+static inline ssize_t iommu_map_sgtable(struct iommu_domain *domain,
 			unsigned long iova, struct sg_table *sgt, int prot)
 {
 	return iommu_map_sg(domain, iova, sgt->sgl, sgt->orig_nents, prot,
-- 
2.39.2

