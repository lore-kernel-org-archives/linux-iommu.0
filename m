Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2279B15DBB7
	for <iommu@lists.linux.dev>; Thu,  1 Feb 2024 12:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789917; cv=none; b=c2+7y69VsZY3pqnjhausu4VK33AbucG/lQ8c1/fxWhUEjeNdaYAeFzYdVQw7dEhdMHfxQ4qpJKP6SqFejhPZUXu9w8i6zjflrybgDrOjKwqg5CBfBRCmK70DhEZCbpRTZLB1yhdLA3nmra9A2P1Dyh5t52UYHYqxr/gq66VS/T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789917; c=relaxed/simple;
	bh=tnkgq6TKhw0S3njLm0h1cwvz40mQDRsV6+RyXmbSQ+I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tEznQueypXY5GtMU0gkHSi45QQd3uYiDQ1mOkKrxBoE3thlmR5c56pIjFzDG2S0e3UKF5UzE8i2XLhsdmoFiYKn44giv4ebLUr8wa1fvZl5+TxDq8DgDpji1FYsevfq/V5m/sBGQ0uHkoJVxrHi1MGZambj+kjJHsyQIfgFSDc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JdM96a+5; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JdM96a+5"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a36126e7459so95291566b.2
        for <iommu@lists.linux.dev>; Thu, 01 Feb 2024 04:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706789914; x=1707394714; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HmcS61wt3WiZJ7MSNdyDaYLcvloghrXIqXKRqKc7Nhc=;
        b=JdM96a+5CKJ9wDQemAjwAEfhi0fmZvsV8Ez0Kt9N+w9SIQlydWzX2TT382C50e1FHU
         xZVe0Mz7UmhA37RfqFYmfoWudg7mt8bU+Zq9OWsFokT7Hh1WZSgwOIxF4Vez9IYzsDjF
         ZP8bPXmePhSOyc3SqgiVvrV+9aKrkfCXQfk5TtdzJPg2XgN8lJD+3mX+1m4NWdWi+eCI
         /jDOB4qiYUVbQT53v3ZDk/iYMEhJdV9fKXEVcBEBDQvBjkahQzrVi59WSsuvb9S50FHe
         /Qfylw26ixryUFfbzyKV+h8n7q96E5/72D7x+0+GZkK7qbDXm1tKfd0v/NvKvK2WG2Zo
         fwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706789914; x=1707394714;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HmcS61wt3WiZJ7MSNdyDaYLcvloghrXIqXKRqKc7Nhc=;
        b=c8nogNkaj7BTVhWENFzqgGG8GssvY5x9j2Yq9OmVlwPM19YWW8lFNUanvBbRunkyYw
         kPNeWrZ/zfoVvVvYq/b17tkJPDuJuwQ0KC9zjFDpv8SE3r1mqgE0RiqvHMF7Tp/uWnFz
         GMHHxPgEzSfes1IKTbD+SNb8X8lkSfR0Ddz2H0jDXlDXwaoGNf32gIy0yWcGD9U4+nAW
         qxEjNLLjAX5QIamW3JsESNITMMe4MRLMf+1fnnNCG50WmqVgBucQp9f7zJ/cGahiR2S8
         zLjJ/Zt1PBDO3HkK/+bplumoBENCAmi3qcRJ/D2ansirEB8JcFPPspcuWKLAQG6o+4S5
         tihg==
X-Gm-Message-State: AOJu0YzUQYrau5VwlUGXGTh8Enrkgpw3sYTmx4NY+RjKhhJV372RBnYf
	KpuYz4rsqc0fRyNOTGDA53XmsfFUH7tEklborgjigE0w16U+ceij9YBAulz9P6k=
X-Google-Smtp-Source: AGHT+IEDkSSbjMmmgzAaURkB6gKbzEJbQatolne5XPLdfpnCfCWuNmo//HmDTbeIqf70E8J9mHQG4g==
X-Received: by 2002:a17:907:1110:b0:a35:b808:8f1d with SMTP id qu16-20020a170907111000b00a35b8088f1dmr3743707ejb.67.1706789914418;
        Thu, 01 Feb 2024 04:18:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUVTkpZpUHaSymXExsv7jyIzN5inNnQ5LIptWi4/qmBBXZs9s/ETpfIj2m9qZ4AZiIQls5wLo/4lprabOg7HAny2VUdWs5lKQo=
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id p14-20020a170906784e00b00a365c673251sm1860912ejm.216.2024.02.01.04.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 04:18:34 -0800 (PST)
Date: Thu, 1 Feb 2024 15:18:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: mshavit@google.com
Cc: iommu@lists.linux.dev
Subject: [bug report] iommu/arm-smmu-v3: Refactor write_ctx_desc
Message-ID: <4e25d161-0cf8-4050-9aa3-dfa21cd63e56@moroto.mountain>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Michael Shavit,

The patch 24503148c545: "iommu/arm-smmu-v3: Refactor write_ctx_desc"
from Sep 15, 2023 (linux-next), leads to the following Smatch static
checker warning:

	drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:1036 arm_smmu_get_cd_ptr()
	warn: sleeping in atomic context

drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
    1022 static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_master *master, u32 ssid)
    1023 {
    1024         __le64 *l1ptr;
    1025         unsigned int idx;
    1026         struct arm_smmu_l1_ctx_desc *l1_desc;
    1027         struct arm_smmu_device *smmu = master->smmu;
    1028         struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
    1029 
    1030         if (cd_table->s1fmt == STRTAB_STE_0_S1FMT_LINEAR)
    1031                 return cd_table->cdtab + ssid * CTXDESC_CD_DWORDS;
    1032 
    1033         idx = ssid >> CTXDESC_SPLIT;
    1034         l1_desc = &cd_table->l1_desc[idx];
    1035         if (!l1_desc->l2ptr) {
                     ^^^^^^^^^^^^^^^
I don't know if l1_desc->l2ptr can be NULL for the call trees in
question so this might be a false positive.  You'd need to enable
CONFIG_DEBUG_ATOMIC_SLEEP=y to see these warnings at runtime.


--> 1036                 if (arm_smmu_alloc_cd_leaf_table(smmu, l1_desc))
                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Sleeping allocation.

    1037                         return NULL;
    1038 
    1039                 l1ptr = cd_table->cdtab + idx * CTXDESC_L1_DESC_DWORDS;
    1040                 arm_smmu_write_cd_l1_desc(l1ptr, l1_desc);
    1041                 /* An invalid L1CD can be cached */
    1042                 arm_smmu_sync_cd(master, ssid, false);
    1043         }
    1044         idx = ssid & (CTXDESC_L2_ENTRIES - 1);
    1045         return l1_desc->l2ptr + idx * CTXDESC_CD_DWORDS;
    1046 }

The call trees which trigger this warning are:

arm_smmu_update_ctx_desc_devices() <- disables preempt
arm_smmu_mmu_notifier_get() <- disables preempt
-> arm_smmu_write_ctx_desc()
   -> arm_smmu_get_cd_ptr()

The patch adds new spinlocks to disable preemption.

regards,
dan carpenter
