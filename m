Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FF93081D3
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 23:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764716617; cv=none; b=V5Kf3IXEP43VemwQSgMjw7jWYjGARQeTnukpAzf4u6oeiElS1g+5r2XFSQyGiJw7BWQ3Sf256ETK6bgRuWlRKZ6SZaSldAQMMYtjLDcbbiwnrLtqL67CjGwhY9TbD12iu/qqNiyGa6XjQ5G8ogSYfbauhg76ZTPswfrVv3ArWhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764716617; c=relaxed/simple;
	bh=yKnHFQ1kaX8g8nk0EgcTv3IagYqpPlC8br1kFNBevv8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rHK8uCOMrw7Ubul29cIwjUqmuYmfXJIrbktvUO9ntap/3WMIWXjW9H4mDrLs2F3uo8fYASmSpXmB5/DPua7mohwVexUHxODQ4EA7k827cJOAG7zcwKCz0zQPWPv3H1imFywIo+9moZjyCJwplJwftpVSUPBPD4physoy4cA/WcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yLXNf9cw; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yLXNf9cw"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7b9ef46df43so5883121b3a.1
        for <iommu@lists.linux.dev>; Tue, 02 Dec 2025 15:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764716615; x=1765321415; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PrbTAG14fQ4e4lFg6XwBokA/VuQ0C8hu3lsKsfR40dg=;
        b=yLXNf9cwz5rdkL9dHewMRT3Gq2qaFmpkUwCimKxgsdGDy2UGfJ+IKIrtbWY1sFkVEj
         wlqTUiJ9zD0IWpn1dPGEzN/a1czZZ37k7R/UbQKKkyq2b/pOM5e6FGahqMo1FKhHTJbm
         hgGyumb1pL5AVvQH34YwutS3TiEFNt9FB0REsbDsDRT+IA2cq9yWqQR29wpAtNHmpNPM
         ZmAcZ0tIbBxAxqEf/O3XEkeuzN6FHovHfPr1+xyTWHNPEJoFKYdKBI4zL8/lBt3F/b/s
         tAq35KOtqK6ZorHxIm1l+zaruN/4kWI7srmsrG8urqxwIO3Yc/QkWrvcCVXFSEJlmjVf
         4z0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764716615; x=1765321415;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PrbTAG14fQ4e4lFg6XwBokA/VuQ0C8hu3lsKsfR40dg=;
        b=I0MGigNuY5RV+7s+/nZDKFF/uH7gNpllZguJEjOnIIP6G0K2WabkOSgrFsLfIJMb5a
         J/TuyaXIMsJ+dy/1hLYfkRHeZHuZlq1rbqr2qUlScACSq0j6O6RMhU76VQJID1THKW1z
         UbUHlRW67PJy5Az2XP7/L5YyVGLofucY0AZzCTYR/qJ5M/ezbT1IpiBBiY7N2fCNgxuB
         6XGDunVnwKjWid8xblS3kdTpqox7WIglPBdjaaR7FxqaJjYnJ0vOyjVuiR0cqmkd/VqC
         VXFeDWG6kXzGr7MhtOBiEPoOl3wMJrEhp9ZURvuxUbs6k+gZx3E/0bGDD7Q7NdrOPQS6
         2qrw==
X-Forwarded-Encrypted: i=1; AJvYcCW9b7+qXS8YjnvLm6vIGGs2eTQnsq+xNKeFjr3ulQ0HoOufYa4ho3hee2AqHDUEbCfLMo1EHg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2j/wCT3PWpessWwLQa9WXTvsnGde8AP/ebsKC4rt7V8PRFUnU
	haXfvxkt8VBqmKKreaW8iy6455UNo58gsARx3f3UQXMkbrdFqAp/0r+mtaUvWUZU1NA2SeBnoT+
	hxNasxeAMg7Mtow==
X-Google-Smtp-Source: AGHT+IF73IhtHOJfWjVx7aWXFwgxkkcNxwTxexsp+KJDsu7Sndk3wbWZLxaLaJ67euc4ONKi0YZioD+jWQRqDw==
X-Received: from pfbfb24.prod.google.com ([2002:a05:6a00:2d98:b0:781:e8d:dd2b])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:9298:b0:781:17ee:602 with SMTP id d2e1a72fcca58-7e00f7ed693mr186583b3a.28.1764716615287;
 Tue, 02 Dec 2025 15:03:35 -0800 (PST)
Date: Tue,  2 Dec 2025 23:02:50 +0000
In-Reply-To: <20251202230303.1017519-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251202230303.1017519-1-skhawaja@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202230303.1017519-21-skhawaja@google.com>
Subject: [RFC PATCH v2 20/32] iommu: Add APIs to get preserved state of a device
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

The preserved state of the device needs to be fetched at various places
during liveupdate. The added API can also be used to check if a device
is preserved or not. The API is only used during shutdown and after
liveupdate so no locking needed.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 include/linux/iommu-lu.h | 67 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/include/linux/iommu-lu.h b/include/linux/iommu-lu.h
index 95375530b7be..08a659de8553 100644
--- a/include/linux/iommu-lu.h
+++ b/include/linux/iommu-lu.h
@@ -8,9 +8,76 @@
 #ifndef _LINUX_IOMMU_LU_H
 #define _LINUX_IOMMU_LU_H
 
+#include <linux/device.h>
+#include <linux/iommu.h>
 #include <linux/liveupdate.h>
 #include <linux/kho/abi/iommu.h>
 
+#ifdef CONFIG_LIVEUPDATE
+static inline void *dev_iommu_preserved_state(struct device *dev)
+{
+	struct device_ser *ser;
+
+	ser = dev->iommu->device_ser;
+	if (ser && !ser->obj.incoming)
+		return ser;
+
+	return NULL;
+}
+
+static inline void *dev_iommu_restored_state(struct device *dev)
+{
+	struct device_ser *ser;
+
+	ser = dev->iommu->device_ser;
+	if (ser && ser->obj.incoming)
+		return ser;
+
+	return NULL;
+}
+
+static inline void *iommu_domain_restored_state(struct iommu_domain *domain)
+{
+	struct iommu_domain_ser *ser;
+
+	ser = domain->preserved_state;
+	if (ser && ser->obj.incoming)
+		return ser;
+
+	return NULL;
+}
+
+static inline int dev_iommu_restore_did(struct device *dev, struct iommu_domain *domain)
+{
+	struct device_ser *ser = dev_iommu_restored_state(dev);
+
+	if (ser && iommu_domain_restored_state(domain))
+		return ser->domain_iommu_ser.did;
+
+	return -1;
+}
+#else
+static inline void *dev_iommu_preserved_state(struct device *dev)
+{
+	return NULL;
+}
+
+static inline void *dev_iommu_restored_state(struct device *dev)
+{
+	return NULL;
+}
+
+static inline int dev_iommu_restore_did(struct device *dev, struct iommu_domain *domain)
+{
+	return -1;
+}
+
+static inline void *iommu_domain_restored_state(struct iommu_domain *domain)
+{
+	return NULL;
+}
+#endif
+
 int iommu_domain_preserve(struct iommu_domain *domain, struct iommu_domain_ser **ser);
 int iommu_domain_unpreserve(struct iommu_domain *domain);
 int iommu_preserve_device(struct iommu_domain *domain, struct device *dev);
-- 
2.52.0.158.g65b55ccf14-goog

