Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C774024A043
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 12:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759235160; cv=none; b=H1ygjFlVeur1v1U2oxwGh1SyM0B9pUr/AZpFn9QhMoTkTxt0pEP1pP18SvakSpFSFF5ObqoynvbaNMki27mQBgsoHeCaznn9n+zDciLoorV2T3ALAraEM2OfCkesfapMlH06UXAwXTC49EXhcNjtePqdR8tl9JuV5PxJfGbt68c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759235160; c=relaxed/simple;
	bh=yDrAqvbEaiFHI18jN+gtlF8I9zQtJDkqQPohZZEUvSo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rC5/CzsIrzs2ilUpgCc7xaSiXWaiKbDgRPGFjRLktVmYanGYvVUXHAhaaoEOu25vDv6TvX+hCvAa9gVycazOZF6BcRNDyXkGgXGE6/qcngLFGVeE8JSwg4lcv3vdWJzjuENtvpEMQuQ/Q44WApET4gIGLzOgDzY3BYPj1ocsnv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aigme0IL; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aigme0IL"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e2562e8cbso45466805e9.1
        for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 05:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759235156; x=1759839956; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GvPVBBH5vGqV3kuJKhWbZIWETLbBu5VFdtdFk49yg78=;
        b=aigme0IL/wQu07//i5jLyZ2id+kjryQ0b9KOjsH00POcmlR2tO4sJxn0KuMTSJYmnT
         Puv2/Mo4UDbk9PrQTXnV61KfRqfRZAjZAJaUPZwWtzhEXLTWYMUlJDfH0OB/AbUE3Eql
         67Bs1b0ljHzD1XnbKmmGRamOpBuWfO4R7CohwzMNusg7KX9QbOPGsv0IPR76qiiNbTh3
         JkV2RMIOmPf/+IiB8MMPSMpYE/HPzdhSiRltYno0k7BnhsGs6hp6Qv4dmR8kkuKAVBbh
         oVPA1hrgokSI0sAP7CeBD2FP9PMwwkyMp6BvIfuy6Ewki7dlEHTJtIhYxuxXtQqWZe5K
         pk/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759235156; x=1759839956;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GvPVBBH5vGqV3kuJKhWbZIWETLbBu5VFdtdFk49yg78=;
        b=XF76IYsLmF9CKfFvB4B3o/cU9Npdni7/J/DuMFzCGHrm0WTzeoadWFgk2E90m9TY0T
         QxXnUiIeGiVXAHzjuCax/wThA2Y2YoET8hpF+UuDGRfQJkNS8pkP2jkEKwTgEl0A73/m
         65zvO36SvOgNhyeaBghJKmf3yYCMwjHwQurfoun/jDyEP+VxpkkrgO5UGHwQPPCp1eMG
         MBub8AvICd4ToMPZzB7bVu0qwLr9lpAOnswWR5BsQkE7s1gadLQ8kyOBPgBlppjLyAxY
         bWPfD4SFFc1roix8SZcMCJVjgv4h9okAHjOjCu5qT88oUxxW4Qgy+KR5W8Lo2vwbtYuu
         UFsA==
X-Forwarded-Encrypted: i=1; AJvYcCXkLReshtteXsMXTThHrknjOI9EJStFgQJFMJZkMgjDYc79ZW5a8qOVW1yi9xUHq9ckfC7paA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyy6K8HAbYhLZSDE8GUHUy6Rs+SZcyjFNysN6koKnVdE3YhX85F
	YhSXPEHiADSdxHC+wguhuqYmlWe+vR2DJZ1qzFMrwbAPf2so9u+bm35UmLC4bAsbtC0=
X-Gm-Gg: ASbGnctALb3GBvaNSU2B8km+Xj4LUg6/tDMjuOqjCYelnRBLAqnJhlbLUr2ROxzmlX8
	u13pFZ5FpxvD59xtIollSedU/OtzJHLCfYV2pBMKyBrhwtSdmMVUsJJ+eO+8awRn1vmOH4Nrrim
	5tOLzazLd3GCKFtrQxGSIVPTGk2t37yEIObkIMHsXv6FziqULMMth3/lLUmFD+WLXdrHFOSD4EZ
	oTqWrgX6PlWErTs4d5QtWuVRqze08NxVEeK2bJ7gS9kMiXvqvc7chFsp1W+nwPwMruXku4CNhfo
	WDp6rP7VKTmJpmxNa3zinL83ANwAfHYENJXUguJL1pS+qEQBK8at7AGgk3PF+VpHSZF5ny0lqcw
	PM0o3i/AVGDJBMnrW5Q7Tj+aU4LQuv6sX99OSiE+2bwhHbp82m21WMcA0f+YDWEY=
X-Google-Smtp-Source: AGHT+IHCMMkMmxX3p2DLBXTZhpA/m4X3bu/Jppin+k2ZScUSiWq4++pq+g8zHiUCjWlwdc3Xc6EA7w==
X-Received: by 2002:a05:600c:4512:b0:45f:28d2:bd38 with SMTP id 5b1f17b1804b1-46e329f9b5amr223551295e9.18.1759235156187;
        Tue, 30 Sep 2025 05:25:56 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e56f3dab0sm54160645e9.1.2025.09.30.05.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:25:55 -0700 (PDT)
Date: Tue, 30 Sep 2025 15:25:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] iommufd: Fix error code in iommu_device_register_bus()
Message-ID: <aNvMULgt6s7-3ceR@stanley.mountain>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This error path accidentally returns success.  Return
PTR_ERR(iommu->fwnode) instead.

Fixes: 885add2e6be6 ("iommufd: Register iommufd mock devices with fwspec")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/iommu/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ddf398d8bcf9..59244c744eab 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -330,7 +330,7 @@ int iommu_device_register_bus(struct iommu_device *iommu,
 	iommu->fwnode = fwnode_create_software_node(NULL, NULL);
 	if (IS_ERR(iommu->fwnode)) {
 		bus_unregister_notifier(bus, nb);
-		return err;
+		return PTR_ERR(iommu->fwnode);
 	}
 
 	spin_lock(&iommu_device_lock);
-- 
2.51.0

