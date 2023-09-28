Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369578471
	for <iommu@lists.linux.dev>; Thu, 28 Sep 2023 05:06:38 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso11334036f8f.0
        for <iommu@lists.linux.dev>; Wed, 27 Sep 2023 22:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695877597; x=1696482397; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zXSf9I94ealuoYE5Vp5lTN5HJS5KFGJWsRuMq2A3LdM=;
        b=OGbz/dM/M0V7zwhf5f5QoRNQc/3oDFuZ6nTeL5yU7oUa2cfHmqvvzRWaAEZadFdAXh
         QoaMQly0V1hrGGUXJ7xi9XRyIy+SRvLRJhSZsP+oj0jDmpXi+crsCIQtoa7YyRwIqnSW
         2c2CMrYQgsbRvfByRLP0NX+E+1C4vPxF+zcN3Qt7zEFHsICciK2ISQEfa09jnvkRJMcs
         Y789UESIilSMQkm5Wpb3m+sLJzDor2YyuMNkGR7hT7biyzF4x6R3385AS0a9ljVd7O9+
         KFo0fa2g5hexDmkPkhBjnGAO7qw4Dxan4YdNghTxDwXSk3znNdU3MirAZOjAWykyU+ON
         69HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695877597; x=1696482397;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zXSf9I94ealuoYE5Vp5lTN5HJS5KFGJWsRuMq2A3LdM=;
        b=HnWAEaCqjAc97iOSYhiYlPau+0zy9URxYS8HtLPS8EBKATAcHyWCK6VXEcv9BQJqwG
         QYjO+hYOBs7Q50V0H/Vbc779/yAJM2AbGCNlHmPzoaGw338bE++AI4RTSW7JLtj2OujZ
         fLiJeXgX0HrADCJ237SCJaLxNZlvnN9Fd9fcn5w/zTJIMN6d71ixfCzInb/emrCxHgsT
         IQG98IBnAa/dYdCEi0lOXMSaUCfB4vzN0fGVVNBL3bVQus/f49qxSl3fpIeRYeFab7k+
         0aCHK6gldvbjzqWRkh+9AQIn4TNwTxXO6r0heiCxpIKWlCxv5xqecYLajLm/eibjQ+qg
         A7fA==
X-Gm-Message-State: AOJu0YwuP9KM8DPe8Poy7RXDLoIlN63RTrDkljChMQrA1NQAEgHA+bcp
	I53hRn2/vrAvRBMBSqIoTMcEWR6JltXC8N2+2/0=
X-Google-Smtp-Source: AGHT+IEvOwlh8nd+26+ibj2GWgCpxVrOz9Qbp+vTWjZT/wT4+aQoMTqx9IYYwbjHrWlxgvuiW+M8QQ==
X-Received: by 2002:a5d:46cb:0:b0:321:8181:601e with SMTP id g11-20020a5d46cb000000b003218181601emr184226wrs.8.1695877597371;
        Wed, 27 Sep 2023 22:06:37 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id g7-20020a5d46c7000000b0031fbbe347e1sm18514304wrs.65.2023.09.27.22.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 22:06:37 -0700 (PDT)
Date: Thu, 28 Sep 2023 08:06:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: jgg@ziepe.ca
Cc: iommu@lists.linux.dev
Subject: [bug report] iommu: Add IOMMU_DOMAIN_PLATFORM
Message-ID: <8fb75157-6c81-4a9c-9992-d73d49902fa8@moroto.mountain>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Jason Gunthorpe,

The patch 1c68cbc64fe6: "iommu: Add IOMMU_DOMAIN_PLATFORM" from Sep
13, 2023 (linux-next), leads to the following Smatch static checker
warning:

	drivers/iommu/iommu.c:3030 iommu_setup_default_domain()
	error: 'dom' dereferencing possible ERR_PTR()

drivers/iommu/iommu.c
    3000 static int iommu_setup_default_domain(struct iommu_group *group,
    3001                                       int target_type)
    3002 {
    3003         struct iommu_domain *old_dom = group->default_domain;
    3004         struct group_device *gdev;
    3005         struct iommu_domain *dom;
    3006         bool direct_failed;
    3007         int req_type;
    3008         int ret;
    3009 
    3010         lockdep_assert_held(&group->mutex);
    3011 
    3012         req_type = iommu_get_default_domain_type(group, target_type);
    3013         if (req_type < 0)
    3014                 return -EINVAL;
    3015 
    3016         dom = iommu_group_alloc_default_domain(group, req_type);

That patch changed iommu_group_alloc_default_domain() to return
ERR_PTR(-EINVAL) on s390 systems.  Probably we can just return NULL
instead, right?

    3017         if (!dom)
    3018                 return -ENODEV;
    3019 
    3020         if (group->default_domain == dom)
    3021                 return 0;
    3022 
    3023         /*
    3024          * IOMMU_RESV_DIRECT and IOMMU_RESV_DIRECT_RELAXABLE regions must be
    3025          * mapped before their device is attached, in order to guarantee
    3026          * continuity with any FW activity
    3027          */
    3028         direct_failed = false;
    3029         for_each_group_device(group, gdev) {
--> 3030                 if (iommu_create_device_direct_mappings(dom, gdev->dev)) {
    3031                         direct_failed = true;
    3032                         dev_warn_once(
    3033                                 gdev->dev->iommu->iommu_dev->dev,
    3034                                 "IOMMU driver was not able to establish FW requested direct mapping.");
    3035                 }
    3036         }
    3037 
    3038         /* We must set default_domain early for __iommu_device_set_domain */
    3039         group->default_domain = dom;
    3040         if (!group->domain) {

regards,
dan carpenter
