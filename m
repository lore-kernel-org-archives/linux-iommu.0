Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792738647;
	b=j2gpRTA6tDT0gX1EJMxRcbdbW6sDsHiZARdWJGe6ghHlsz9sEIgh5vS3NRIFxN05HEwd
	 AL5480GjT2itmyVVpv631rMEUxhX/s/T2324q5mKr+HJ4CqkhN8U/J4UxVokMGrOXBtKU
	 5o89oSblfSOTAsLst5uwCHDRuKKNsTrfvQ0Htec2NkTf+671QhB3dhhniF8vkb39lrU65
	 Ev9P4XXpZPU1KPb3u002kR0Fjm9TncQp9EdNeij/nIqd7O5PEmt5EcxBGy7SXBCz39Vyn
	 e/W88dIdMFENHYbVr12kxYGBbe3G8+jkVCFYAKrrkrmWo/KsIre1nfoLy7eYG3Ugs/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792738647;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HMTH4x6eTSleI4AiB941ha5PbgS09yPkxgROP6geXTQ=;
	b=mjm3I/IiaL8dGS/B/d73ohSI2lPWPrNikKBADPHCAXLKAtYad9EsLUq42PIxOKa2MLa6
	 BUuoGhv9kTRin7U3Wgxurf55m4Q7NWoEb4QHekTh1TAaR7j9fh5faUZ1G6o/wWbJSOnpi
	 wGZVdz4/jyeBcchdKCjymYvqkMoc7XxTCXVkLeQTrJp46D70nRJe141yQo0/ZwbZycwGk
	 HWk5a9khnhZZ6xNu7OTx8LW284NwtkratPJwcdQt1A/4PzHdPA+8LF4GsKco4Am9nsOLv
	 WI4A9aR4rWnzjEpW4w9l/1MUZxLdPO4Su1lX+Fm2DZoouJHHCuQP1E3JYi7thVvvQsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BlQomjO2;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D88606A325
	for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 06:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53D88606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BlQomjO2
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e9ae391a05so3186255ad.1
        for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 23:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792738646; x=1793343446; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HMTH4x6eTSleI4AiB941ha5PbgS09yPkxgROP6geXTQ=;
        b=BlQomjO2/td1LqKcckTS5BvwAYsS+9Y/oF2+JJ56bmcouYbP94d/ifcPMYx06WetwM
         bGA/BZDF5IKQK4RNZFEl3JQm6NZSyxDtSeGKRktKJe8Lh2aSQwcefyrLYp67gIYxutR/
         A/TqfkON8ixrCFFbBIVVx3GgjUlVIugR1XyRqhkTd1anM65ANdDdZo6DHn3BCIm3EU7A
         oxPnt9uwrW69V7APoQc/EHFc7q6o+7ukziemTCUEVLbPaoY1Kavjeqdpiv2tOAOMwYoq
         xjaMcTXdwSxs2ROUBqCfMDqxrSJLKovaD1ymqyQ7f5b7meNtrFQZ6Q8KMGaqYoODnjNb
         VBLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792738646; x=1793343446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HMTH4x6eTSleI4AiB941ha5PbgS09yPkxgROP6geXTQ=;
        b=d48ua/j3uoRFUZ6iQQKXq6kX5JlBigZc4ZKXfGUi4GQt5Rcu5XHLLHh4XEXzxWBNz3
         yirLgOZO3+jiJmDlzoRi1LictA/uHfLANVBF1cezhWSPn89dcMx2qG70f31lHd3dbx+B
         GC+jlqnwocoKNIo8IO9dJvxJ2zGJHa+cQW0y9GMHZ8wDOY9JCEOuPzv9Z8EXInZCh2cq
         UlkddPTbieBW7g5LUU8I58d6Xmsqo+mFMyJTaHXNta/x4lLH6MlwD5EocVRHM8e9X5ei
         7Mb7+NZ/KHWsgIB6L+o/ENd+Is1/w93deiy9R/+H+RrgOSofdMMEYLlwWVXCr0kqSaaC
         RdhA==
X-Forwarded-Encrypted: i=1; AKwUvBzLCqAzF/RiyUsvpjHikSsiw1400rF9YMUv/4Rx/CGy+F90dsNtAc0aRlTrLs12LNQkY6YXUw==@lists.linux.dev
X-Gm-Message-State: AFq9FYI5Z7hyWV/FC9DS/PWaJE60WeMPpgeW1z2aOLPvFIH8HwuaQ6Uf
	Kq1Pl7+eJB/Yo9iWdvNSz/PPBv7NCUxCUI3B6jI+Ict0LSNQJjWc+CEPnK+P8flQ
X-Gm-Gg: AYBFou0Z3QbAzQHNQai2dIIuI6715bkRLH/IXdGDYJlgxowd309Px9mNVOpNRJtANTU
	Koib0vp1xr+97OcLLZtiG8HkKJCMp67qOn/7n6dGk9DxYX6ULcvXv4mbSEXY0Uriqgc3k70F931
	zrySPHD+FGIcqyRnmutlBB2L3Cg4SMDczZIbFoJv394TsaBJYi6B9Mr7fEka7ziQ5e6BMHMEsUk
	av3R104uGYeQDGWrBFDfgHIqKvJBXkY4kMQ+DbCGb597YXDCB7j7Xa6V/DAs7xlf50GCSbTjBHO
	hEsLLyOaLEnclPY+oF+XIwDeQDMQK0P8qdYzeRuyBtFUkvt0IxBnoMAnTrR6Ouhhd7qnDIQ1lZM
	78tlxakalx1KdTIAF2ef4wlamn6eOSkyUC8JF/gxzz8CxcdOilxb1LL9s0Hi3P3NOH3xTuNHiaQ
	oROUQeCWT2I68znUajLx9xE//uO9wRlDXpSn/JemWcuBB+Be95/LzrC1FmhsQPxs02/k6BLIIOK
	dJ599RAcysoLNPVBx6TwAhEwtso//ewlZ/8oPGPhkmo3awZM3xxl91iVU0DZTnoY3yvSu9iwF8=
X-Received: by 2002:a17:902:da81:b0:2e9:6333:fba8 with SMTP id d9443c01a7336-2ea7c2bc159mr10474315ad.16.1792738645512;
        Thu, 22 Oct 2026 23:57:25 -0700 (PDT)
Received: from spiderman.taila3fd8c.ts.net ([202.112.47.77])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea7b3bdae8sm6527545ad.52.2026.10.22.23.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 23:57:25 -0700 (PDT)
From: Li Ximo <lixicaicai@gmail.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Wang Haoran <haoranwangsec@gmail.com>,
	Li Ximo <lixicaicai@gmail.com>
Subject: [PATCH] iommu: Guard iommu_group_first_dev() against an empty device list
Date: Fri, 23 Oct 2026 14:57:05 +0800
Message-Id: <20261023065705.2854692-1-lixicaicai@gmail.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wang Haoran <haoranwangsec@gmail.com>

iommu_group_first_dev() calls list_first_entry(&group->devices, ...) and
immediately dereferences the result with ->dev, without checking whether
the group's device list is empty. list_first_entry() does not return NULL
on an empty list: it returns container_of() applied to the list head,
i.e. a non-NULL wild pointer pointing at &group->devices itself. Since
"list" is at offset 0 in struct group_device, the ->dev read then lands
on whatever struct iommu_group fields happen to follow the list head,
yielding a garbage struct device pointer that the callers
(__iommu_group_alloc_default_domain(), iommu_group_alloc_default_domain(),
__iommu_attach_group(), __iommu_group_alloc_blocking_domain()) go on to
dereference, e.g. via dev_iommu_ops() -> dev->iommu->ops, resulting in a
page fault / kernel oops. An empty group is a legitimate end state: the
list becomes empty when the group's last device is removed under
group->mutex, and nothing in the helper itself prevents it from being
called on such a group. Note that the sibling helper
iommu_group_for_each_dev() in the same file iterates the very same list
with the empty-safe list_for_each_entry(), which suggests the missing
guard here is an oversight rather than a deliberate design. This
potential issue was found during a code audit.

Fix this by making iommu_group_first_dev() return NULL when the device
list is empty - which is the semantically correct answer for "the group
has no devices" - and by teaching all four callers to handle NULL:
__iommu_group_alloc_default_domain() and iommu_group_alloc_default_domain()
return ERR_PTR(-ENODEV), while __iommu_attach_group() and
__iommu_group_alloc_blocking_domain() return -ENODEV, consistent with the
existing error handling in each function. Behaviour on non-empty groups
is unchanged.

Reported-by: Wang Haoran <haoranwangsec@gmail.com>
Reported-by: Li Ximo <lixicaicai@gmail.com>
Signed-off-by: Wang Haoran <haoranwangsec@gmail.com>
---
 drivers/iommu/iommu.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index cd1bca7ed..5f26785bb 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1386,6 +1386,8 @@ EXPORT_SYMBOL_GPL(iommu_group_mutex_assert);
 static struct device *iommu_group_first_dev(struct iommu_group *group)
 {
 	lockdep_assert_held(&group->mutex);
+	if (list_empty(&group->devices))
+		return NULL;
 	return list_first_entry(&group->devices, struct group_device, list)->dev;
 }
 
@@ -1723,6 +1725,9 @@ __iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
 	struct device *dev = iommu_group_first_dev(group);
 	struct iommu_domain *dom;
 
+	if (!dev)
+		return ERR_PTR(-ENODEV);
+
 	if (group->default_domain && group->default_domain->type == req_type)
 		return group->default_domain;
 
@@ -1757,11 +1762,16 @@ __iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
 static struct iommu_domain *
 iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
 {
-	const struct iommu_ops *ops = dev_iommu_ops(iommu_group_first_dev(group));
+	struct device *dev = iommu_group_first_dev(group);
+	const struct iommu_ops *ops;
 	struct iommu_domain *dom;
 
 	lockdep_assert_held(&group->mutex);
 
+	if (!dev)
+		return ERR_PTR(-ENODEV);
+	ops = dev_iommu_ops(dev);
+
 	/*
 	 * Allow legacy drivers to specify the domain that will be the default
 	 * domain. This should always be either an IDENTITY/BLOCKED/PLATFORM
@@ -2362,6 +2372,8 @@ static int __iommu_attach_group(struct iommu_domain *domain,
 		return -EBUSY;
 
 	dev = iommu_group_first_dev(group);
+	if (!dev)
+		return -ENODEV;
 	if (!dev_has_iommu(dev) ||
 	    !domain_iommu_ops_compatible(dev_iommu_ops(dev), domain))
 		return -EINVAL;
@@ -3369,9 +3381,13 @@ void iommu_device_unuse_default_domain(struct device *dev)
 static int __iommu_group_alloc_blocking_domain(struct iommu_group *group)
 {
 	struct device *dev = iommu_group_first_dev(group);
-	const struct iommu_ops *ops = dev_iommu_ops(dev);
+	const struct iommu_ops *ops;
 	struct iommu_domain *domain;
 
+	if (!dev)
+		return -ENODEV;
+	ops = dev_iommu_ops(dev);
+
 	if (group->blocking_domain)
 		return 0;
 
-- 
2.30.2

