Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B11314264
	for <iommu@lists.linux.dev>; Wed, 14 Feb 2024 08:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707897824; cv=none; b=JOAZpl6s2jrZzAlyQqTDYzJBpnWFSMJFJFxD0WlnGXbCL2eJq4Q8y2QStVj3jLWGF60QjnW+LKhYaL6SYy/XDRAH2AZ/Okpd4+jlJBSTPex07NtXqiKecIUCI9WXYx6shGF6ZvSjyhLuIv+DpGqML7u4y2ATi/hbNCF4JWU5BmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707897824; c=relaxed/simple;
	bh=qDTr6j8KLwnlDyOgYyxvdnWHSER/jDCBOwN2h7/OVsY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Gm86OjOb7FmL77lAJ8+gEaLwOZL1Hhq550AFtw9dJWupXz7qy0sfAV/80X+M/cuMYyS2bZMjY2M8mSy3YY8N1KcezNQqxFIlWxoACVtScUSb7FudrXjiCocur/DgNkr04fehFoLpjg+XrGcsQhJ5Wal2ZgS/mYCfsS6MgeESqs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NmYwySwE; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NmYwySwE"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5610c233b95so5735836a12.0
        for <iommu@lists.linux.dev>; Wed, 14 Feb 2024 00:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707897820; x=1708502620; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f+lzSZn9+OiMBN1+KgbGryw+8pDlfSWOmE0wEWMKQyk=;
        b=NmYwySwErcH2zrnfVV7UTeySj+3QAsE3TsfecGu6VkA2janegmmegKFLpW4WioSFRC
         pk6TKBqdpi+qUWbeG9eI3VsvyXS8UmLIMZ4KJ9ix7CoEmDU8XQ3M2wI4PZ0YKEEXtqOS
         3bkftq3+b4aolyT2Xpk68grWM8evXrfll+mdLQCwEAAF7k0QV2VoNm4AIsuHKi+oV718
         5M313T0SCW2CKNL1ycJL12+6+Fq7RzQo9xss8I1k4VfAWyp9q/7kJEOaJV8ntJxcAhyt
         GHusr/nBLlnLpvIhWUfNkxVxs4CKH3vxe4fhNMtFw4rClm+DJEnVlvBFi0kBiO3n9zjB
         zbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707897820; x=1708502620;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f+lzSZn9+OiMBN1+KgbGryw+8pDlfSWOmE0wEWMKQyk=;
        b=IbUHhcXJGn1sDYBcOa+j2F+BaLLiaC39l3nMygsMEcel8wc5Zg4XUNZudkD4wCbJIZ
         m0YhcacUrJwAUaLbMNoJqLrZp1hOPwKR8vzLI7NFzjmYipD2O7ZvrwwnkbAiYLqpWT0b
         Cz010D68+CCfDP5UgpCUXdu4aC8Cx71xt/y/jYIe52jH+hc2fFNeKfwwysuqvddYoAtc
         es7tNfEIMrtfwPl7E4/+duBUVQjgMVGvDNoeEhcCOO3piVc+/tXd2B6hvnoCszKlhkpH
         3fXSY5kjZbrdVO5AjTC2JqqSMWYID/QKmavjC/603AovCybYO2S02OLY/AvVfaBhXskb
         3YSg==
X-Gm-Message-State: AOJu0YyDFwhzKTqB9bsBaCwpfBFB/tsjBVdL93EePKMhvrZTiFwwYr6I
	YWH5LJRN8JdKQzRz1m9oygPGK/NxhYywNGXBS7zi7o69yGfyt43aUE9OozXay6Qd7Intt4GUSDc
	9
X-Google-Smtp-Source: AGHT+IGN5r4ZcFYFp+4+Yn7l1s10iMMCP2TjCFSbz6fe9ww8VESit0EFqyIK2JUGaE4B+Dopi8sG0g==
X-Received: by 2002:aa7:d84b:0:b0:561:f8f0:162f with SMTP id f11-20020aa7d84b000000b00561f8f0162fmr1307756eds.3.1707897820430;
        Wed, 14 Feb 2024 00:03:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUgC3Ve00MTH2EEYVleRA89JRkiYp9nFWOjbEfzwDClRPOW/s5ccnyFC58kXuKxUm0wJy2Dtz7qwrcJEj9vRhwDE271raZ1osc=
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id l20-20020aa7cad4000000b005638a4f935dsm47209edt.4.2024.02.14.00.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 00:03:39 -0800 (PST)
Date: Wed, 14 Feb 2024 11:03:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: suravee.suthikulpanit@amd.com
Cc: iommu@lists.linux.dev
Subject: [bug report] iommu/amd: Refactor attaching / detaching device
 functions
Message-ID: <41bd6e9a-19c1-43f4-8251-cc9e83737a31@moroto.mountain>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Suravee Suthikulpanit,

The patch 4ebd4c7f2501: "iommu/amd: Refactor attaching / detaching
device functions" from Feb 5, 2024 (linux-next), leads to the
following Smatch static checker warning:

	drivers/iommu/amd/iommu.c:1796 setup_gcr3_table()
	warn: sleeping in atomic context

drivers/iommu/amd/iommu.c
    1781 static int setup_gcr3_table(struct gcr3_tbl_info *gcr3_info,
    1782                             struct amd_iommu *iommu, int pasids)
    1783 {
    1784         int levels = get_gcr3_levels(pasids);
    1785         int nid = iommu ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
    1786 
    1787         if (levels > amd_iommu_max_glx_val)
    1788                 return -EINVAL;
    1789 
    1790         if (gcr3_info->gcr3_tbl)
    1791                 return -EBUSY;
    1792 
    1793         /* Allocate per device domain ID */
    1794         gcr3_info->domid = domain_id_alloc();
    1795 
--> 1796         gcr3_info->gcr3_tbl = alloc_pgtable_page(nid, GFP_KERNEL);
                                                               ^^^^^^^^^^

    1797         if (gcr3_info->gcr3_tbl == NULL) {
    1798                 domain_id_free(gcr3_info->domid);
    1799                 return -ENOMEM;
    1800         }
    1801 
    1802         gcr3_info->glx = levels;
    1803 
    1804         return 0;
    1805 }

The call tree is:

attach_device() <- disables preempt
-> do_attach()
   -> setup_gcr3_table()

attach_device() is holding spin_lock(&dev_data->lock);

regards,
dan carpenter
