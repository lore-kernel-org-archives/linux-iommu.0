Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D9CAD30
	for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 13:04:18 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id a14so24163578wru.5
        for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 05:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XKCnZfWdXAsHrDxZD/otcVh0syOS6ydRLxca1WANMkQ=;
        b=PZUMYanhFkPB+/1gYGyErIP1hjMrErP6bH2iL06MzQCCQ5JdpZam0nLapkxpO8g2X8
         PscRWa5o5TXS3qfHaEsKoKv0KjMIJKaIvI4HN8km89+6whSLMqcqX/AXe4V9PdmLva7t
         dgKDxlYNv6B9sHDl/17x/azhSb1kkCT4u0/FMC7s/vFkzAom8VoHGfZAx6vE+TMDiOM9
         sAy/vJ0zYnbDhprYLpJF8rdjtzKEGrH6X+4BNkvfwVoSzhZPJu5dOWQnOX9i0kt6+mSH
         x2QYtiEzuoLNv9Tbpiwzp3RJqAbt4sir11vi0GL9ve11SrE7nvxPA5EaVAutx24gy5c7
         JfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XKCnZfWdXAsHrDxZD/otcVh0syOS6ydRLxca1WANMkQ=;
        b=peu7gHgd9VCdIqcy3EuEpGVqb5hoc1w5yMhBOcmi10Dy2ZS9hbvbDcRMdcOJzklkp7
         3pKUnl+CQhdS57EzEvrIf6lB/UFUHXrsTJizpVYQox1xwgT/HsrUu6pbF73idtBGWeD2
         hwdxPz0VwBVWUQvp/rHVw7xx32+gwRvDATPK/nTWiuVaHw1tEbJyRdE834Eo5LCuyC2P
         z8sswz+HuOQhBqBGvyam8UaS1mZBm2jN5nhqJ+Jj0k1sy8DoUP2d9mQ5cJZwdib13gw9
         1nDDxRVmmYNodR4SS1bfOD5iRQNwCt+hkdWNfEuagjkB6IQwDqlAOavdR4nchD9ELMoi
         wODQ==
X-Gm-Message-State: ANoB5pkJ33692rzOfsi5X54mtVT7PoEKZs0CF3oWL5xOQOeQcuFSzVUh
	q0BHGytRjIrFJUQYpoxta3d0LF9HMC/rJw==
X-Google-Smtp-Source: AA0mqf5C5bdH++OT8tZpg48kCRd05T+YUyWzk012incWIYAEDCnJQe/kVojJjs+7BfMykFZhRK4UBw==
X-Received: by 2002:adf:e284:0:b0:236:b7c6:7ef9 with SMTP id v4-20020adfe284000000b00236b7c67ef9mr10711180wri.10.1668517457194;
        Tue, 15 Nov 2022 05:04:17 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o37-20020a05600c512500b003cf54b77bfesm22854218wms.28.2022.11.15.05.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 05:04:16 -0800 (PST)
Date: Tue, 15 Nov 2022 16:04:14 +0300
From: Dan Carpenter <error27@gmail.com>
To: baolu.lu@linux.intel.com
Cc: iommu@lists.linux.dev
Subject: [bug report] iommu/vt-d: Add SVA domain support
Message-ID: <Y3OOTla3Kp3521hk@kili>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Lu Baolu,

The patch eaca8889a1ef: "iommu/vt-d: Add SVA domain support" from Oct
31, 2022, leads to the following Smatch static checker warning:

drivers/gpu/drm/msm/adreno/adreno_gpu.c:213 adreno_iommu_create_address_space() warn: passing zero to 'ERR_CAST'
drivers/gpu/drm/msm/adreno/adreno_gpu.c:216 adreno_iommu_create_address_space() warn: 'geometry' isn't an ERR_PTR
drivers/iommu/intel/iommu.c:4721 intel_iommu_remove_dev_pasid() error: 'domain' dereferencing possible ERR_PTR()
drivers/iommu/io-pgfault.c:82 iopf_handler() error: 'domain' dereferencing possible ERR_PTR()

drivers/iommu/intel/iommu.c
    4713 static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
    4714 {
    4715         struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
    4716         struct iommu_domain *domain;
    4717 
    4718         /* Domain type specific cleanup: */
    4719         domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
    4720         if (domain) {

The iommu_get_domain_for_dev_pasid() function returns both error pointers
and NULL.  The comments say that it's supposed to only return NULL.  I
don't really understand what's going with these iommu functions.

--> 4721                 switch (domain->type) {
                                 ^^^^^^^^^^^^
    4722                 case IOMMU_DOMAIN_SVA:
    4723                         intel_svm_remove_dev_pasid(dev, pasid);
    4724                         break;
    4725                 default:
    4726                         /* should never reach here */
    4727                         WARN_ON(1);
    4728                         break;
    4729                 }
    4730         }
    4731 
    4732         intel_pasid_tear_down_entry(iommu, dev, pasid, false);
    4733 }

regards,
dan carpenter
