Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF092E3377
	for <iommu@lists.linux.dev>; Sat, 15 Mar 2025 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742033091; cv=none; b=p93fMY9Z7mDhlDFm0jj2VPfSryf2kIsoIBjE/25GyI17djwOTPFt1WTkJqFEtwOoLa/GT3OzGPOgtgZHElHJ7f+bHsMORyCenxMmHFg+c+4cBmavx9Wm4XtIV9226uDbaRg3gCoJpGZHQ6T0E613TYZN+FbNhU9CkWvHvr7e6yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742033091; c=relaxed/simple;
	bh=N8MbLgv1165dTpEcNGiSnLvHm8DcmgUZHKAqaUTWEPg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aV598uazEJ5m4/u14udCV+HmpEQQXbtnTRziK/XfwAA+nQ/o9XhAXwiaz9UR47a16AO20ZiS5CFQ3/nJLTUllcfOR/Y4MVdKjOEeIvyxxfB3AdgIoORQPf4OKVxCCDT40sMHVZEglwi9qNUA/9tj7ipTSrupjsL3HeX8U4U2R/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tbeAvMdU; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tbeAvMdU"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-390cf7458f5so2390328f8f.2
        for <iommu@lists.linux.dev>; Sat, 15 Mar 2025 03:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742033088; x=1742637888; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rYtGuETeT4N2PxyqinXijL5UhCOCxSCo7J87TR1Pzdc=;
        b=tbeAvMdUO9yT/939M1Ze6ahpGewPiybDV24TQ9O6/UpvYAVOdMliKL4ZyEwJJ0sC8g
         Hc16Zf4IENx1S9bK2FNpSyAObeRALowjyzyhNuCIqVO8pltp0WwUBs+1Qe3Ts+WO4nf8
         orU1CDU8LPKHWjY904qP9KwVu4N/AR2cqQujXfmW5fgfNRL6kI/3m3QpVlcc8UeFFlFv
         +MU5WgLylEvLcOgBPqq600RvpkurgChDiuPOcjinjGFrsjiYsrTcYCHhKVp7MqrXrSJU
         I1Fn74P9nt3T2NBvUQWd4YSNllMv5LJUyamKOcie6JkGAj+/qdIjmzJBjKKn0D3Tx4Dl
         YJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742033088; x=1742637888;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rYtGuETeT4N2PxyqinXijL5UhCOCxSCo7J87TR1Pzdc=;
        b=eu20Asxf3mwtJilIBBmeWIxeN5iRQnxr8DwqJgA+2d5g3Ci3/TJ9IALSh0xyM9za3Q
         y5OBSzoska++qYGG3YvIO+Wl0Klc/rulvDficCMszY5bHliExLET/2VEggoDd/NRD6dI
         Z0IUp9vrupaqE+dcPWNKxAfzFh01Vip+cHX+Am8IomAqefc6MPlgxD3gtyclFXpiwxJh
         hq/PHfYnwhpG7sxtTaWeZ4BlOa9cKlPzks6OeDt75vzKODCmu5FPPeuETq4hbfjnAzQI
         WWjVdaGfEfEzlEW1WOAoAg2S4GhZB0+WcKejb3q+8wkSquug+BeDHiphZOiMqtEemrQd
         1PVA==
X-Gm-Message-State: AOJu0Yy2bmvxnf/MbLDCdsp9bjl0OFNKp6kupwrYZ0POoLwgUff+Oo3t
	3Xm3PFdZ6I2GWM8f3pWvfyuqcrNsvVDHQHpG+tfUaDWCZIiUMvom52I/SaFv8F6MFz/pTCq8fCY
	B
X-Gm-Gg: ASbGncsDww1dx2nDfsYjJcAMhmBHZ+i3zfUVbZjFjEInVyknj3qjSq5/rPYTzPlCdAe
	C7BjrJuLI7HBpMM4951BthbJ1ghcP89UnNsWfQlCXkmqXgeFbVOow+l7O0Ew5QcJUshFiZHb216
	iMst2lh0/wVfzY5ctbKlt+wUKt7UjqxvDPzUCRWTdfqCpFm4C0mSBjPTsPtVGC8NSvw5vRjBpzj
	2+B1IhbgvDmZwHp82YMLsgS+yQvJQgndqBRCAvLJ2x8Sc8qSRzTZHfCJtXPyCRI3qK0juXcqDkw
	zaMo3Moq3pZN9/3eIjY53HF7s0wVhS2BAe2h8UWLnV6geQ4hvw==
X-Google-Smtp-Source: AGHT+IFJFQUtxayqTwvpvd1/q8vl1EtfUpPoFoaqanvwZkb7kXmvkywZIzxcelzMgJ54aqVjtBO6kQ==
X-Received: by 2002:a5d:6d8a:0:b0:391:255a:748b with SMTP id ffacd0b85a97d-397202a1884mr9539850f8f.39.1742033088205;
        Sat, 15 Mar 2025 03:04:48 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-395cb40fab8sm8758294f8f.63.2025.03.15.03.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 03:04:47 -0700 (PDT)
Date: Sat, 15 Mar 2025 13:04:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kishon Vijay Abraham I <kvijayab@amd.com>
Cc: iommu@lists.linux.dev
Subject: [bug report] iommu/amd: Enable support for up to 2K interrupts per
 function
Message-ID: <d3c8141a-0052-4f04-9df2-0604eeb352d8@stanley.mountain>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Kishon Vijay Abraham I,

Commit 19e5cc156cbc ("iommu/amd: Enable support for up to 2K
interrupts per function") from Mar 7, 2025 (linux-next), leads to the
following Smatch static checker warning:

	drivers/iommu/amd/iommu.c:2401 amd_iommu_probe_device()
	error: uninitialized symbol 'dev_data'.

drivers/iommu/amd/iommu.c
    2353 static struct iommu_device *amd_iommu_probe_device(struct device *dev)
    2354 {
    2355         struct iommu_device *iommu_dev;
    2356         struct amd_iommu *iommu;
    2357         struct iommu_dev_data *dev_data;
    2358         int ret;
    2359 
    2360         if (!check_device(dev))
    2361                 return ERR_PTR(-ENODEV);
    2362 
    2363         iommu = rlookup_amd_iommu(dev);
    2364         if (!iommu)
    2365                 return ERR_PTR(-ENODEV);
    2366 
    2367         /* Not registered yet? */
    2368         if (!iommu->iommu.ops)
    2369                 return ERR_PTR(-ENODEV);
    2370 
    2371         if (dev_iommu_priv_get(dev))
    2372                 return &iommu->iommu;
    2373 
    2374         ret = iommu_init_device(iommu, dev);
    2375         if (ret) {
    2376                 dev_err(dev, "Failed to initialize - trying to proceed anyway\n");
    2377                 iommu_dev = ERR_PTR(ret);
    2378                 iommu_ignore_device(iommu, dev);
    2379                 goto out_err;

dev_data isn't initialized.

    2380         }
    2381 
    2382         amd_iommu_set_pci_msi_domain(dev, iommu);
    2383         iommu_dev = &iommu->iommu;
    2384 
    2385         /*
    2386          * If IOMMU and device supports PASID then it will contain max
    2387          * supported PASIDs, else it will be zero.
    2388          */
    2389         dev_data = dev_iommu_priv_get(dev);
    2390         if (amd_iommu_pasid_supported() && dev_is_pci(dev) &&
    2391             pdev_pasid_supported(dev_data)) {
    2392                 dev_data->max_pasids = min_t(u32, iommu->iommu.max_pasids,
    2393                                              pci_max_pasids(to_pci_dev(dev)));
    2394         }
    2395 
    2396 out_err:
    2397 
    2398         iommu_completion_wait(iommu);
    2399 
    2400         if (FEATURE_NUM_INT_REMAP_SUP_2K(amd_iommu_efr2))
--> 2401                 dev_data->max_irqs = MAX_IRQS_PER_TABLE_2K;
                         ^^^^^^^^^

    2402         else
    2403                 dev_data->max_irqs = MAX_IRQS_PER_TABLE_512;
                         ^^^^^^^^^^
Dead.

    2404 
    2405         if (dev_is_pci(dev))
    2406                 pci_prepare_ats(to_pci_dev(dev), PAGE_SHIFT);
    2407 
    2408         return iommu_dev;
    2409 }

regards,
dan carpenter
