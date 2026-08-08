Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C283829BD91
	for <iommu@lists.linux.dev>; Sat,  8 Aug 2026 02:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786156047; cv=none; b=H8R2Hg6TyxMuy0kulMFv25wEKpX4g2NBwg6t7Zb3kKPYS5dEWVzbTAQd8fMuX6qM09WS24ACTK1O19r6KyGc1loPopHnYGM+5s02fxywQyAOOVMqZnSr7RVRaqSiQd33lXg9Wva0OTvAXG1I7BauDEZcfwRiKK1HDVPoZh7TpsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786156047; c=relaxed/simple;
	bh=yOi7yhY6Fy4JlfxwFK8p7Rf7I8U/HAe9qW+3MGP6hOg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iqHkCKq6Vdh6JeLk/BpqVKJagmiViYNV2Y6wLRWG9FMfG/ik9SOg5cQV7JUaFb7/JE20YMu5Jv32DufnmvKbYRVlb2p2cJZYxV0v7Uy/aLoh7STSHbYQMZ7zF5eBflQjmkUY0Lea8DARKDL49gH30jBJsUbmQ69CzwDtiTonx+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dcNpysc+; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dcNpysc+"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-381250979d5so146457a91.0
        for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 19:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786156045; x=1786760845; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9EeRsRgHcmBuChfylKO96SmshYr8igDm3AdVPfiyOQ4=;
        b=dcNpysc+f/wGZeJ3vTqyror8I8Jh5zcapZYv/sJEEd7LzyjjRk3ewd5XUyq7Gz+CQS
         AjG+emvjIuoovD6wthOODCxzcru+YLi1grEZR4RRW4CjAPEuBZYE7DLhV4v9SDN+lsCz
         Rv8VHcdApd2A1mTu/9Iiy1IFhDSRtrJzKWKCagJrNQwNjzIWTk/p6M5kVuhDiJ42OYLB
         V8GJTCOl3gsEZ6ZuIiNsQUpokOPaChnjoH5jdUkeS/7EfASCinceGy0SSIeWN+X06W16
         QMHM2IX5dxVvrsjRWwUWaRxwJFI1c8NKAkvlYciF+WFzT0GIWFUrUUZ3B4XuoJ4ocxv/
         JF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786156045; x=1786760845;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9EeRsRgHcmBuChfylKO96SmshYr8igDm3AdVPfiyOQ4=;
        b=pTJ51/lmcUIgIzhGSp1/X2xmxKzplBgjbbgiVcSufbKbkQp1HxrMV3iqW46jKXssn6
         rD3+3AMaKAsY1f8zjcZqhRHzXjS+RV6HWlvuUQ9PoPiGPZfI708QGkKiQjbUOcQlwNkF
         ooPfl0Qf8kkuginW6kHBPVQ3hZhPY3NicGqpaytrjPoi9h/umJQmp75e0haVadEzeght
         zfe1f2bkzUQcbcP3bxYQk+AuFVtyfVVmHoQRELUkmjmnMY2/BH2R43Ne+38sYfgIauMJ
         HFGV6IuSaIJFndL3kjR4CnBPaQHadtd1D8dzvFg1xoURyAZajNiagKqNgTkTEslmSiFa
         FVlA==
X-Forwarded-Encrypted: i=1; AHgh+Ro8mM3rjhOyQmvvevhXsJh7xMlUBhWabBAq/tfEnU2IEuK7eKd+Mcaw5yyeAmiiAXnFtdOP8g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwdOyHp4vCzgMj/uU9Z4XRSdLmjPFghQrti10pknOzcTvTiKGTQ
	DzNTHAvoo5QWLlCAqvIcFuxYUpoaPk/lVENVs68TUoDQdhPRMxXBY3GwnjDkofRp2VX+soeuw1f
	XwS+fZ4x5AYLQDg==
X-Received: from pjbct6.prod.google.com ([2002:a17:90a:f586:b0:383:bb4e:85a5])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4c45:b0:38f:efed:5448 with SMTP id 98e67ed59e1d1-392822b7b78mr3666061a91.8.1786156044907;
 Fri, 07 Aug 2026 19:27:24 -0700 (PDT)
Date: Sat,  8 Aug 2026 02:27:06 +0000
In-Reply-To: <20260808022723.3893618-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260808022723.3893618-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260808022723.3893618-2-skhawaja@google.com>
Subject: [PATCH v4 01/18] memfd: export memfd_get_seals()
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

memfd_get_seals() is used by iommufd during preservation to make sure
that he preserved memfd was sealed when it was mapped into iommufd.
Since iommufd can be built as a module, export memfd_get_seals() to
avoid linker error.

Cc: Hugh Dickins <hughd@google.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org

Acked-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 mm/memfd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/memfd.c b/mm/memfd.c
index abe13b291ddc..c489b55df3bb 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -6,6 +6,7 @@
  * use by hugetlbfs as well as tmpfs.
  */
 
+#include <linux/export.h>
 #include <linux/fs.h>
 #include <linux/vfs.h>
 #include <linux/pagemap.h>
@@ -309,12 +310,19 @@ int memfd_add_seals(struct file *file, unsigned int seals)
 	return error;
 }
 
+/**
+ * memfd_get_seals - Gets current seals on a memfd
+ * @file: struct file representing the memfd
+ *
+ * Returns seals if file is a memfd, otherwise returns -EINVAL
+ */
 int memfd_get_seals(struct file *file)
 {
 	unsigned int *seals = memfd_file_seals_ptr(file);
 
 	return seals ? *seals : -EINVAL;
 }
+EXPORT_SYMBOL_GPL(memfd_get_seals);
 
 long memfd_fcntl(struct file *file, unsigned int cmd, unsigned int arg)
 {
-- 
2.55.0.679.g6767b8d81c-goog

