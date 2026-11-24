Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795592320;
	b=cwQAqGqIDlyoeYkigioh/MFkBo6AdDB93cUAp2Y21mpsQaTkIyucY/xNqVold2ow8rhj
	 pQDoQSfempYPFa8NhcVbxLrakd9QcaOKWN8xmMERwbzqTtPsoEra/VMndckRA0bNmp1d/
	 oVrhFBNjfU7xAoj6bOVFpCClGAYEg9HPHSwzjXqLQcWr1MhKoEnptwI5L1UEVwi4qrAra
	 6PzR173phir7SGkNcCaYBebxeNsAewUYoIZOGSHWVjGsTOqftMetV9F+F+3apHyBmU/Bu
	 FbnmqgJfeJdyHcqbZuk7hJ1yDTBqGxReaCQTzIVQpCVL/puLfKBSQJmLW1cHtZKUeNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795592320;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=8PyL3QNZZPiFy87Q9rypWQo81tSJJQG9bcV53fh+//M=;
	b=pxdv9JCtDxlrdiRhEYXV6OvNE/KnCLQfU88rHjCdHRRubZVA4i29eh3DfgUGjoMCwZI+
	 3fJTqRBLKaO3Y8SZJwTTO+n0WQxbuozpk9VAFbaK1BEIRujLMaPl7hkQcKIDMD7RTPKnu
	 780hV/sPpCIShrRgnfijJ9VuKNwrIk3ZxvGH56oc5OqjfPsrVz4sy3wbNiclWzgcIxz/c
	 fvjYJHPjYA+zuybI9GI/D6sUlMxxaLc9qPSdvF/H9F4T5IT9nSWq/uq34LBgccs5nIbu9
	 Wp9Na3Y2t4XkW1g3QjEA59Wl+GQhBoFlLRckwTpNHfTgmY8qsrKqqjiUpjbwhYTZ2PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vp+IR9ZA;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D72A606A684
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 07:38:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D72A606A684
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vp+IR9ZA
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b3f9cbafecso734341a91.3
        for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 23:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795592318; x=1796197118; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8PyL3QNZZPiFy87Q9rypWQo81tSJJQG9bcV53fh+//M=;
        b=vp+IR9ZApXWXJ9yxJgM6heYBOaV8wDlEQrbYxiwP/Ays9GXpCz8AeMo3uDC8SYSoPC
         qzymDLVoe6ZvzE4MAh4jOdh4nmI63mmcT0JjMf1sCMsZkZxAnrK7V6dXFlzm5at/sEOW
         Kvjfw+CDBB2mh0Vr4FFUIliN+5D9JNl/aEmeWv2zywAGqwqXIvZGkuU891wzAPaNb6EJ
         Bl4YCfozt9sA/J0XFpzRb+q3xBHU2ibe/1lV5RpvfHwX3nMe5/r559GsMSd/GYNFErow
         EE+99tjQbOUUs5+afNbZ4YkAWZmg2z3+We2LgXyeM/FLLFkFbU82vKYoFklK5saoC5yj
         Pqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795592318; x=1796197118;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8PyL3QNZZPiFy87Q9rypWQo81tSJJQG9bcV53fh+//M=;
        b=kP35BE+Ju8kzwhHiyH+yd50TJ3ocmDl7SbbTU1BEUFZfaIyRNCPsjz2kQsS35OopjH
         zqZ+TNb+gNNBxQcIbyp2i57w/wGBvrVaaV9Mnb45Ym5FliWp1fCPwUUaZqUoqJhiOh3F
         pL4YwFOB0vNf8SjzWDBUt7P/SIjEtUw8YISXB7KjHS6dzvMjnOB1ecx2CoVMYvlaADLI
         f/lEwufeqHFIH36yQidD3HzDdCnGXQmYfM4vHfu2CUJCvUD9MWlBQnU07PnHK7mu30wh
         NEIEk18v0Kww1UbiuxakHvLZoT5MQpJd0DMm986gu5daGl3JqToeNE0u3HZ1zWXBztho
         /lAQ==
X-Forwarded-Encrypted: i=1; AL+hErGcU0jjaIuDsCZvCDO75fVoMN4AaHP0vUeneBDMD+R9ha46vc28co4Qz5XGgFQrBZ50UfpGVQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9YYemrwlenarvGVMhbQ1WIpPWvg8eI5A6gIkuPVercddZKK7CT
	rzPsJxNDBi8xBm4P4/e619Vs1iHwgQxgiNZvSj4h4+u/MuJuho8EGHF/
X-Gm-Gg: AZFdTZd2yZMtUduLzg5fQsWKX0IAj4NSHKK503f/L86iD7Dl1Fouh4XPrdzQ67Ggg9Y
	0OTtYq60pyw+oD2VrrtGIaE6bZXMSya4w4uKkXjzoPfO6UZIvi6XpS7L0/bQHUR47pbjRrrHUdX
	x3AcSB0O2EowVFhaeTRagAnRei1eSvWhX1bDfkbXHd+gZ9lnOAUgBw4rtumn6H+g7WV5uJ/owed
	nHU4CmqoPdz39YEeZ6URW2i3Y3vY7d3DPoFSd5tTIdZ1C2ToR+awmnF5dpI3gCAYJGQIyRmHAXn
	BJ5iG587ki2Pq964eoWoCLvQ0Wj7dOIVXaLuKoYSe94AwI9DPXaHoLbRlccRfQHCtsxHpob/wnD
	ijCu94HYUfFCzKi1/kPMwGzeu7T/TT5zY+4+cEDeUvBEgyJ+iUhT2q8p6mkhbiQmKT5R8Mmzt7P
	On56Uy6KgGRupf/jWWGX2cHkdJ417IgEVLBBmbpmiXD6aX3HYUQpamfcWcXCGECxbQ4znBa/cG7
	hXdXQ/5OvT5Lyk2PIh8wP8VzPwb88DdOX53Z6jmiysJCCEtLC7sfmqM/nf1yj7ctWuqgDQIoBoV
	2/rKtPzvFGC0Pt36ic6EI9IGXjDilsNJR2KxdLHSSqx2pRG3DL7FjPkQJ+kyD/ubB4pYcVC7sMc
	Jn2j90Y2OM1tw9bCtaRtRUyZ2AMk2rLrdJrOKGwtvSTb/yS3sQZOKEX5p7cdY9zZyFHpDYy4aye
	1gYXbC4EDv6Fl2/JhBYKj7CGXUTPn41w==
X-Received: by 2002:a17:90b:4d10:b0:3b3:bd84:526d with SMTP id 98e67ed59e1d1-3b41c80f762mr24491975a91.2.1795592318203;
        Tue, 24 Nov 2026 23:38:38 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([27.122.59.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ecb486sm29016932a91.16.2026.11.24.23.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 23:38:37 -0800 (PST)
From: Qihang <q.h.hack.winter@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Baolu Lu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
 iommu@lists.linux.dev
Subject:
 [PATCH] iommufd: Validate hw_queue dependency against concurrent destroy
Date: Tue, 24 Nov 2026 17:03:22 +0800
Message-ID: <179559231210.4471.14931493215349444982@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

_iommufd_object_depend() takes a raw pointer that the IOMMU driver kept
in its private structure and does refcount_inc() on it. The driver lock
keeps the object memory readable while depend() runs, but nothing
prevents IOMMU_DESTROY from removing the object concurrently: it drops
the users count to zero, erases the id from ictx->objects and releases
the xarray lock before calling the driver destroy op and kfree().

refcount_inc() on a zero count warns and saturates, but depend() still
returns success and the caller stores the dangling pointer. A later
undepend then reads the freed queue.

Revalidate the depended object under the xarray lock before taking the
reference. If the id no longer resolves to the same object, return
-EBUSY and do not store the dependency. This mirrors
iommufd_try_inc_users(); the check is open-coded because iommufd_driver
may be built-in while iommufd itself is a module.

This also rejects a queue visible to the driver before finalization,
while its creator can still abort the allocation.

Without the patch the mock vIOMMU destroy/alloc test reported
"refcount_t: addition on 0" and a KASAN slab-use-after-free. With the
patch the same test observed -EBUSY and completed without refcount
warnings or KASAN reports. Tegra241 CMDQV hardware was not tested.

Fixes: 0b37d892d042 ("iommufd/driver: Add iommufd_hw_queue_depend/undepend() helpers")
Cc: <stable@vger.kernel.org> # v6.17+
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
 drivers/iommu/iommufd/driver.c | 19 +++++++++++++++++--
 include/linux/iommufd.h        | 17 +++++++++++++----
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index e4d17a748178..31d8c79c4f4d 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -4,9 +4,12 @@
 #include "iommufd_private.h"
 
 /* Driver should use a per-structure helper in include/linux/iommufd.h */
-int _iommufd_object_depend(struct iommufd_object *obj_dependent,
+int _iommufd_object_depend(struct iommufd_ctx *ictx,
+			   struct iommufd_object *obj_dependent,
 			   struct iommufd_object *obj_depended)
 {
+	struct iommufd_object *cur;
+
 	/* Reject self dependency that dead locks */
 	if (obj_dependent == obj_depended)
 		return -EINVAL;
@@ -14,7 +17,19 @@ int _iommufd_object_depend(struct iommufd_object *obj_dependent,
 	if (obj_dependent->type != obj_depended->type)
 		return -EINVAL;
 
-	refcount_inc(&obj_depended->users);
+	/*
+	 * As in iommufd_try_inc_users(), take the reference under the xarray
+	 * lock only if the object is still installed. Keep this check local
+	 * because iommufd_driver can be built-in while iommufd is a module.
+	 */
+	xa_lock(&ictx->objects);
+	cur = xa_load(&ictx->objects, obj_depended->id);
+	if (cur == obj_depended)
+		refcount_inc(&obj_depended->users);
+	xa_unlock(&ictx->objects);
+	if (cur != obj_depended)
+		return -EBUSY;
+
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(_iommufd_object_depend, "IOMMUFD");
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 3087f5b2def8..b0b382beed2f 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -259,7 +259,8 @@ static inline int iommufd_vfio_compat_set_no_iommu(struct iommufd_ctx *ictx)
 #endif /* CONFIG_IOMMUFD */
 
 #if IS_ENABLED(CONFIG_IOMMUFD_DRIVER_CORE)
-int _iommufd_object_depend(struct iommufd_object *obj_dependent,
+int _iommufd_object_depend(struct iommufd_ctx *ictx,
+			   struct iommufd_object *obj_dependent,
 			   struct iommufd_object *obj_depended);
 void _iommufd_object_undepend(struct iommufd_object *obj_dependent,
 			      struct iommufd_object *obj_depended);
@@ -277,7 +278,8 @@ int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 				enum iommu_veventq_type type, void *event_data,
 				size_t data_len);
 #else /* !CONFIG_IOMMUFD_DRIVER_CORE */
-static inline int _iommufd_object_depend(struct iommufd_object *obj_dependent,
+static inline int _iommufd_object_depend(struct iommufd_ctx *ictx,
+					 struct iommufd_object *obj_dependent,
 					 struct iommufd_object *obj_depended)
 {
 	return -EOPNOTSUPP;
@@ -351,6 +353,11 @@ static inline int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 /*
  * Helpers for IOMMU driver to build/destroy a dependency between two sibling
  * structures created by one of the allocators above
+ *
+ * Hold the driver lock protecting @depended from lookup until
+ * iommufd_hw_queue_depend() returns. A queue that has not yet been
+ * published or has already been removed yields -EBUSY. Call
+ * iommufd_hw_queue_undepend() only after a successful depend.
  */
 #define iommufd_hw_queue_depend(dependent, depended, member)                   \
 	({                                                                     \
@@ -361,8 +368,10 @@ static inline int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 		static_assert(__same_type(typeof(*dependent), *depended));     \
 		if (!WARN_ON_ONCE(dependent->member.viommu !=                  \
 				  depended->member.viommu))                    \
-			ret = _iommufd_object_depend(&dependent->member.obj,   \
-						     &depended->member.obj);   \
+			ret = _iommufd_object_depend(                          \
+				dependent->member.viommu->ictx,                \
+				&dependent->member.obj,                        \
+				&depended->member.obj);                        \
 		ret;                                                           \
 	})
 
-- 
2.54.0 (Apple Git-157)

