Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBF32FF159
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 23:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764716599; cv=none; b=t8KLkLKTkuORQe9X+suzNEiTg9yoqFWDPhpup7vxxR12wZEu2do8jdOehjXjIYmppZUjJxjjPneas+vaUwxpglTsrK34kuOCTblIHKnKfjN63imhNU6Lacow++2I86L+jSIwnsw3I8UugDnA96DZRbpIchvrZJnG6jLMrjNRqrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764716599; c=relaxed/simple;
	bh=1ipPm8UXvL165F9GkVGcUQP4dOA8/4h2qdcDirT989A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uPiIJsbl1o71i4EeUukOkhHT1pAWQR3HHlat5KvxMLZ7X0OXvCgiXoQan6NRS7MlnsJUOIvu1YED75EJeV61n6S6EEeV3ZnTRtb7ik+MEJUBy6FofxVtX4ARwc3UnkGuEhXCaOXoqwDHD6dcepih6Dqbr10MWzTYTenRuDdQjsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eh8DueG0; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eh8DueG0"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7aa9f595688so8628674b3a.2
        for <iommu@lists.linux.dev>; Tue, 02 Dec 2025 15:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764716597; x=1765321397; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SKB5fC33D0H7Z0K5HeryXmAmilE91yTdL7508I20zDA=;
        b=eh8DueG064aDiAlIDN6mRXdwWKv+104nyTIWeXKep6VKv1MzlCIvFBMXGum0OP+p33
         FoxRepcxMvUyMFqK+BVebdvrTnjLdET9q9LfLBhIRowq/XFeW27zxMK3MvmOH1nhldUV
         IM+8Y7jtRNVQ9DkHfrEWkf7AUh2u+p5e3iZuqSJSDNQVm/ouZ+fpcSdp7yMaf4JcY/Ea
         bdGPHeRfMRE8Z/N6ohIa1ZXN2TZbWhazQxTPY3a3X9y5Ripkysq1hZXhi5TFbJQPMkjL
         J+vq/2/M7qv0k30bK73AeTeqiaSVe+pYVFZ70zXB0Srcy4uGn3sqb9O2Tte1Hr8OpXbw
         mmrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764716597; x=1765321397;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SKB5fC33D0H7Z0K5HeryXmAmilE91yTdL7508I20zDA=;
        b=bcsyQTywmrZsDXGtWmJVQgnXDcV7GQsrZK8nCgKyxQ+cOgYDdIGRyHdZ3HBt4dIFeZ
         DUlFJFbVOOKaObs2TL3BZAW8BmO3/vxXsL6skNZ85Eivllmkz1tUPS+w0Aw3xh6PaE0a
         17C6AhyDzRx927Vcyp/8N1fivSTL1QqLDFcXhykXiTRlq7FyxHSorg1NQIfs7rl8dSpz
         F8L+sBIOB2EVlZbSaioV1AaQrauyWwLC15ovTZT8H7Oqw76BP4pYRox1ctNmWi0jrYOI
         CwRGbBoTPu272u6x7bhomyMqQig1kGED7NWRl7npw+dBSFSZOnyvYNCiQ9QhPbcm2W95
         CJpw==
X-Forwarded-Encrypted: i=1; AJvYcCUrT9M00mka1GehhRfS7q6bPnagSz1rQ0Bla35xVgPrs2uU5AbfFIs95cZIW4ecydPTf0/W0A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyyHu63wJvPS8I3BtEHCjjT/qOx7i4VdrmqUqReTDYuN8BnVI7d
	2KM6Nmr1/rcrHPNvzrEIxgQQ5wier6VK2TujlU5/GUFA2nAnRTfD330jMUQKOxMQrhkib06bcVO
	PKavcp5wV+Fb8zA==
X-Google-Smtp-Source: AGHT+IGqwkejLheu2w9mVg7GdTNm2uE/SL9SkQKvI8QWaEiZxdn7fIeJbw9FoYZbMmFS4wXm1pycNKfcSNnDbw==
X-Received: from pfuw18.prod.google.com ([2002:a05:6a00:14d2:b0:7b0:bc2e:9595])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:12cb:b0:7b7:828b:f569 with SMTP id d2e1a72fcca58-7e00e3b230fmr164918b3a.25.1764716597047;
 Tue, 02 Dec 2025 15:03:17 -0800 (PST)
Date: Tue,  2 Dec 2025 23:02:38 +0000
In-Reply-To: <20251202230303.1017519-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251202230303.1017519-1-skhawaja@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202230303.1017519-9-skhawaja@google.com>
Subject: [RFC PATCH v2 08/32] iommu: Register IOMMU FLB with iommufd file handler
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, YiFei Zhu <zhuyifei@google.com>, 
	Chris Li <chrisl@kernel.org>, praan@google.com
Content-Type: text/plain; charset="UTF-8"

Use the IOMMU FLB register/unregister API to associate it with iommufd
LU file handler.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/iommufd/liveupdate.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/liveupdate.c b/drivers/iommu/iommufd/liveupdate.c
index 42b380229c57..782585aff44a 100644
--- a/drivers/iommu/iommufd/liveupdate.c
+++ b/drivers/iommu/iommufd/liveupdate.c
@@ -8,6 +8,7 @@
 #include <linux/kexec_handover.h>
 #include <linux/kho/abi/iommufd.h>
 #include <linux/liveupdate.h>
+#include <linux/iommu-lu.h>
 #include <linux/mm.h>
 #include <linux/pci.h>
 
@@ -362,10 +363,22 @@ static struct liveupdate_file_handler iommufd_lu_handler = {
 
 int iommufd_liveupdate_register_lufs(void)
 {
-	return liveupdate_register_file_handler(&iommufd_lu_handler);
+	int ret;
+
+	ret = liveupdate_register_file_handler(&iommufd_lu_handler);
+	if (ret)
+		return ret;
+
+	ret = iommu_liveupdate_register_flb(&iommufd_lu_handler);
+	if (ret)
+		liveupdate_unregister_file_handler(&iommufd_lu_handler);
+
+	return ret;
 }
 
 int iommufd_liveupdate_unregister_lufs(void)
 {
+	WARN_ON(iommu_liveupdate_unregister_flb(&iommufd_lu_handler));
+
 	return liveupdate_unregister_file_handler(&iommufd_lu_handler);
 }
-- 
2.52.0.158.g65b55ccf14-goog

