Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A883025CC64
	for <iommu@lists.linux.dev>; Sun, 28 Sep 2025 19:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759086468; cv=none; b=RYnWc6dOdwzTh6Fv60LmlK1dzCtf+YtPdw9GVNSTG7tpGVZfMbwbp++a+D6vJlUzF7OoxuhpNvLgAgmLobQtbf6eGJ4adS4BHTkEHFB4PhRhiG30WMtwBJuy1Y4aKHWN4lVR/AJQYKePpmVMuFxviESZLWzSDEqyQP6zwG+1tsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759086468; c=relaxed/simple;
	bh=8L0DFfHrZlNZX0VjY4FjLPOo4H3abf6EW6LzlAWKOaY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mZ9bVozzAH/Grzxcq2TE0CwJ1WIYPcibPvzdrh1DmfJpuy+D4bnCb1yQe7ulpdUT1jniYmZaCVZg331f1tr8gzAyPlbcG3s8QEBLaySTnMYmxOszJOekHn0hl1KmP10Jd8GmAXg6YhEOHg40CsaJDNayU9f8JP/SHHs3i4mWfDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=04/Tbo7a; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="04/Tbo7a"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-781171fe1c5so1793900b3a.0
        for <iommu@lists.linux.dev>; Sun, 28 Sep 2025 12:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759086466; x=1759691266; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=unF6bUsLM9O1vzcXGUHanadtXOZ35cPd5k0W1K58MJE=;
        b=04/Tbo7aWjZH0u7l7p6unyM4j6rKq5Eh+YO7hrAxezW7e624gaBq9jfOBzA67uymq8
         DXNCDACiv9lW4+wemsQ+gkYlKZUZsO1KHLYvJfyEBOrDQTkWQR4GWLKhyrBkKqvKmJEK
         HHPmCx+H10tBcEwSRmjjUAtUjhDORbpWZj8WIAX22DYlr3U347S+oRncSjvaFp+bekV5
         4NCHPTvKq3QVVf2C82ZHZA3AXrgSqy/zokc+RVVRbx34vUlkMcjqXOsrDnHCCdqqesUb
         V1ll8qM5m8kZkj5cNwttLrvRl3maBzPE12qVdgR9JItNNgpUSaabYjfImsq+197BqP5a
         dBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759086466; x=1759691266;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=unF6bUsLM9O1vzcXGUHanadtXOZ35cPd5k0W1K58MJE=;
        b=gJRftM73Xt2rDmB4Bm2V3bfPsQNLLba6VIjIU+aKMGHfwQDw+RcBCzW11FoIBQPsXd
         GNnE9Xw8xOLSbKNl5zVxQx/kEcVqdSpzsgpxfkD8lYIJ6nGEVL0cMMV0UxebKNnggAUl
         Txr6SJ1cv/QB466M0vp/aBEclgo2nOgKH56+9CQx749LF4JDeyIkrPIBgdtDsDl1Ji3e
         zFXxQw5yZ5hMH1/6fnNY2+SayUlZfyKwJP0fFBJbzvht3pDcdcyNN610dWpzXgXR9KEO
         g2oCeIJOTdxauJcLuOnqjjM5w1Ux0D6Mrd0hxgTYWbrRdf2OBvwHlT/XpWWQ/EzBtRwz
         kcrw==
X-Forwarded-Encrypted: i=1; AJvYcCWKhyt8PtlteQvYnbb9fEAao+q6hhhU0hCT9q51HnZUGABWClY+fxH2rtml1Kl/CII2wdUxww==@lists.linux.dev
X-Gm-Message-State: AOJu0YyS5YSfzikUe/CYVCvAAK4MxMta1qgZdPE6snk3EPLO6mK2gn6R
	BAHu6yzIeRh4R5lvCiZD+4CZ6NXOwraLkgM/c0dW2jeG10PuBXZHyoGEcaKwhvb6YrSqTeANHtA
	EP8G3isPkQwhpVg==
X-Google-Smtp-Source: AGHT+IFHeLeByvDx3H7Fv/UY9IPnM3xJSFbkXHDcYCobgRG472vqOkunFnZPCYmzKNVjAjQUoI+lXVkr/Z2l0Q==
X-Received: from pfht2.prod.google.com ([2002:a62:ea02:0:b0:776:2281:3189])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:6a26:b0:2e3:a914:aacd with SMTP id adf61e73a8af0-2e7be0668c2mr18263550637.2.1759086465857;
 Sun, 28 Sep 2025 12:07:45 -0700 (PDT)
Date: Sun, 28 Sep 2025 19:06:11 +0000
In-Reply-To: <20250928190624.3735830-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250928190624.3735830-4-skhawaja@google.com>
Subject: [RFC PATCH 03/15] iommu/vt-d: Prevent hotplugs when live update state
 is not normal
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, zhuyifei@google.com, 
	Chris Li <chrisl@kernel.org>, praan@google.com
Content-Type: text/plain; charset="UTF-8"

Hotplugs should not be allowed when the live update state is not normal.
This means either we have preserved the state of IOMMU hardware units or
restoring the preserved state.

The live update semaphore read lock should be taken before checking the
live update state.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/intel/dmar.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index ec975c73cfe6..248bc7e9b035 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -26,6 +26,7 @@
 #include <linux/dmi.h>
 #include <linux/slab.h>
 #include <linux/iommu.h>
+#include <linux/liveupdate.h>
 #include <linux/numa.h>
 #include <linux/limits.h>
 #include <asm/irq_remapping.h>
@@ -2357,6 +2358,10 @@ static int dmar_device_hotplug(acpi_handle handle, bool insert)
 	if (tmp == NULL)
 		return 0;
 
+	guard_liveupdate_state_read();
+	if (!liveupdate_state_normal())
+		return -EBUSY;
+
 	down_write(&dmar_global_lock);
 	if (insert)
 		ret = dmar_hotplug_insert(tmp);
-- 
2.51.0.536.g15c5d4f767-goog

