Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527651A2388
	for <iommu@lists.linux.dev>; Sat, 15 Mar 2025 10:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742033084; cv=none; b=PXnE+51B/LleBCb0MSe4229W3dq9zxKv+yf9qbz7tE4R0xe5v44rSq/y5zESmcSzzMB+b+D3/sXD7vzIJmyl56FCiarGhXM2BOYDmRslLe7HBtlgFrK830EZ3kTe4ieldaVo01FX3rOPobFE9wQv/VpJlvwSOALFIktaPHQV8HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742033084; c=relaxed/simple;
	bh=eaF1RIBovEKvVXPWzZ7TlXNhzC0kXsTK6g8OrWH4b5U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UYBZcNyGxiV29dCpe6U9aEIeeeIOSbcT6V/AFHUGKPcYKdsUwREkTCYQYKQ837Au/6W4lkVC3erbZC9hz3URaDd9FvFDW33DLl4w59qytKM1asyUYnv8g04u75OleOc86ICSaSIQ83fHucuSvS3c0soxaJaAS9JnnOkYUEANTjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=srplhT4E; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="srplhT4E"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso4774775e9.1
        for <iommu@lists.linux.dev>; Sat, 15 Mar 2025 03:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742033078; x=1742637878; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AYtI8yv5BP0Nx1Vm1uo2TMPV81NdclSbubQ1z6aKrXg=;
        b=srplhT4EYf4sdPK22AxiqIP66kMFCfh95BanIvCpTp41c9RBBSmbWWHdYvb3l6/Aev
         zLYAU/YZxURg8g0rzGVWhTHJMix5IwUz5BnAhtD7ulR9cFp3Ir+FyPIQqfBQ4QKVYghB
         ofxazJ8Ycmv0AhmIIBS5RBQ6GMtJPb82CD+q8Cexj94Dh+l7KeCks+MUG6fErK5djU7Y
         nTjgNoyUF1o4213y6S53zBLpsQemHZ2YBdcHkDQBVUjfXTkVoXhGcEqlfVot2IWB4vwT
         1Fpp1vW/qVjdwHDfcluE31gb3XfX4VIXTS/p5Rg1cKpgvH61n0nE6HthoLuf561oQxMr
         o71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742033078; x=1742637878;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AYtI8yv5BP0Nx1Vm1uo2TMPV81NdclSbubQ1z6aKrXg=;
        b=Rx6WFt+cGawQ2pGmpePf/2eq8/DONzIYKBtubLMjLUeam2Ngp28MmHMJE5jBxwqv/x
         ONGWWmnkkqz/lPfKYh8thK60DfOPmm0AE5BRb2Rhd7fWwgxZ6RNDtqABOESPAb5axUsU
         jHb8+7mojEe0ueCDcU+6/h/vKfwDsxzpeKesWNidzaHAnh0xG86QZWfigpJPVNnXDQnC
         HXoxY60cbPeeDWTHOBuu3sqymS1sDFkOI40tm8LMJPLUSYSPPT3dIz3EM+zR/IhuLGaz
         KZUalYgtSMolXQdMb90uWjjThvZ976gN2WdOAeo4VZK434smOXQO/RgIP/GMYX2d0/pM
         IZYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE7Co03SxzZnEFCZ4qW8MEVJiLrx2KDa0h1LMmBWCcSZulCNMPoWE5WObA05LoszXXXW7Vzg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxbHaGwC+wrtHCvYndC0661GrPdXvb4AFHTyY2IxFGcDbrTxYr1
	GepdrmLdQVUMEI4Q7V6zC/xaRb4uTaMi5KqYNobckMPhhyE+RhyEc9Bq3CmMF64=
X-Gm-Gg: ASbGncvwJPLGT7ofyO5ShVjT/9c9aSCkkXj3LDUS9GF0XIt5hvMR2fyrh8geqTzY8IH
	NEMoDMA+305UOMIP16GoV6CJY2w37VrpVVZHeGnWCzDZywB6CVqhkkb+jqKjXyVF1pjKe57Qm7S
	vwz9sgzhVMQwmk8b2ziJP5TIYE2TiqdDLSB5dBW3ayTUHdirQQ8jiQRsoO/9uIRRsoISFbyO0TB
	Ytwq9YeRUmMBVsgeCNQWKtyILnRJpvQVJrlTv7/CCNqExO2/PGGDS5yCYWUci21aJkplY4WyhdG
	Z9NE2Rmy8+AEt97oPV87ZKSkdq0Fhhyi9oIB+rbT976RShzJIw==
X-Google-Smtp-Source: AGHT+IEt9zEGxqZg2ROZ/j88ZO5jwrU97jppzYLNW0cANVVWvXJgNkpyPkHeWb49BXRPjir2xNC9vg==
X-Received: by 2002:a05:6000:1846:b0:392:bf8:fc96 with SMTP id ffacd0b85a97d-3971ddd5714mr5968309f8f.4.1742033078591;
        Sat, 15 Mar 2025 03:04:38 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d1fe292d0sm44964185e9.20.2025.03.15.03.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 03:04:38 -0700 (PDT)
Date: Sat, 15 Mar 2025 13:04:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	iommu@lists.linux.dev
Subject: [bug report] iommu/amd: Replace slab cache allocator with page
 allocator
Message-ID: <bc412a4f-5031-4c6c-a1ef-8bce170afbc9@stanley.mountain>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Sairaj Kodilkar,

Commit eaf717fa1c3f ("iommu/amd: Replace slab cache allocator with
page allocator") from Mar 7, 2025 (linux-next), leads to the
following Smatch static checker warning:

	drivers/iommu/amd/iommu.c:3200 alloc_irq_table()
	error: we previously assumed 'iommu' could be null (see line 3195)

drivers/iommu/amd/iommu.c
    3186 static struct irq_remap_table *alloc_irq_table(struct amd_iommu *iommu,
    3187                                                u16 devid, struct pci_dev *pdev,
    3188                                                unsigned int max_irqs)
    3189 {
    3190         struct irq_remap_table *table = NULL;
    3191         struct irq_remap_table *new_table = NULL;
    3192         struct amd_iommu_pci_seg *pci_seg;
    3193         unsigned long flags;
    3194         int order = get_order(get_irq_table_size(max_irqs));
    3195         int nid = iommu && iommu->dev ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
                           ^^^^^^^^
This check can hopefully be deleted?

    3196         u16 alias;
    3197 
    3198         spin_lock_irqsave(&iommu_table_lock, flags);
    3199 
--> 3200         pci_seg = iommu->pci_seg;
                           ^^^^^^^
Otherwise it will crash here.

    3201         table = pci_seg->irq_lookup_table[devid];
    3202         if (table)
    3203                 goto out_unlock;
    3204 
    3205         alias = pci_seg->alias_table[devid];

regards,
dan carpenter
