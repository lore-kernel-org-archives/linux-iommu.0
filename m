Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15AF158879;
	Fri, 28 Jun 2024 12:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719577668; cv=none; b=bh/JW6vg9xhGeWxvIbLgHWYJujYR51pbLXpF4urj6hXmWKdKL+RZibUoLig7iL7tdUOCPQwC5hNyjUdqly/sgWE7g0ia/yWLutROYzdw40DFQgKmy/wg6Ybm6HpQ6YVPMqKNPYgBsf7d227D6L35PyfOouUjPw55KuQSN2sLoY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719577668; c=relaxed/simple;
	bh=EowXbq+3GcSwnDqZA0ItT17PGnvphPglRVy1uSDu0A4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aB1h5iavz5NPZ+uLLo9v6tLWZY0NTPEvQg/QqqX0Ukucc2UKJofcQ8bw7xN2NlxgYw0XyadWbmNrYJQJ1xZmvOQhi4Anfd0yHABfJICRgqk2+9KBTnsuVeImBBR+VfX/6srh8ld7/I8TTVP+KFTzELhkrZ3/Ot2nk2J0BGI9xpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tf6q4bGe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tf6q4bGe"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 538D7C2BBFC;
	Fri, 28 Jun 2024 12:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719577668;
	bh=EowXbq+3GcSwnDqZA0ItT17PGnvphPglRVy1uSDu0A4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tf6q4bGeBsyqG0TS3Li3X2poALFPaAnEzXqht8SEKsDgyhNVVvvAVSJte/SybT6W2
	 /I9stlCzOnb6T++otg2t7xz2N+TlZbhy4UocvVB1JvO8h+v/5KIZioo2O+GC/ucK45
	 CjJkh74/6h0wrG077tuld7gDldNvVYwhYvKayj5XXGt2DQ/bRcQOlYiuJgrd6OhPM0
	 vVulvxpmTWB4EgQ6M3tQkwBYy9IjtteyJzOqMEQWeI0bMAAMaaXbg0iLPfgQxzK3PZ
	 hTqeBCpdc6eP9oSOvxdrwklfuDo+RKHtUL9//f9iTPceG1Y3gHriF99aVZFCAkVGxV
	 G6j32jOrKNN7g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A97C3065B;
	Fri, 28 Jun 2024 12:27:48 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Fri, 28 Jun 2024 14:27:40 +0200
Subject: [PATCH RFC 2/5] iommu/vt-d: Replace cache_tag_match with a tag
 comparison function
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240628-jag-revisit_cache_tag_assign-v1-2-a0c19063c983@samsung.com>
References: <20240628-jag-revisit_cache_tag_assign-v1-0-a0c19063c983@samsung.com>
In-Reply-To: <20240628-jag-revisit_cache_tag_assign-v1-0-a0c19063c983@samsung.com>
To: David Woodhouse <dwmw2@infradead.org>, 
 Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Joel Granados <j.granados@samsung.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3271;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=JWe71x3QOlu5j4Wh0iPnW/XbH7HpQb7ccgT4S59ce+c=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGZ+rD0hWBNGYZ1/T161VVajrGE3mBMB88ZcK
 UVJW+ZAJcusFIkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmfqw9AAoJELqXzVK3
 lkFP3xYL/At0MpQQ3WxWHg2BaBN2WTbirowQaNWk+Rf2ua5BecgxmTIWu2UgzrvkwqYUin+JLxz
 BrgGngxceL0wP+bnLqW6aFGq0vWXBftXiWp9vYx7OdLQFI5fIA4NyyhtXJSkmXzLFW2CCXEHeom
 BivKJFt/UEhcC1uZ05/OJ50tMjgw26mPq2bvjy7a02DNcPiARx0oDS5Rrj0YGfrPbcSxswqLo4/
 tYpvgMwfmqtxyu/VdMdWLVbiwSXctF6IHbl1rplpurwMigB5Ha8XNIhxrxI0zt9mUPsPpSgo46s
 vzPO/2fjiaBiTiro6Xt31Sb+23IRjdPCQK0Xy7TCTRGKBD/4anclveoSK4MqHkAN39EXvIoWB6S
 kciNq9Ubo95B9Fwc15bRv158kx6uA54ynxaR3LYeDMJB5Zt2QuP/FZX2JRw1qRddn+Vs/JpFyJI
 VrWdmOcfs4kyLSp0hTjzRhIWENCikefQd1x74LYKX3V5+Wn9F+ievwClzlgyhbFiZHYPkf+ygR5
 yw=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with
 auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: j.granados@samsung.com

From: Joel Granados <j.granados@samsung.com>

Refactor cache_tag_match into a comparison of cache_tag_id. This
clarifies the usage of the function.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/iommu/intel/cache.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index aa8a463b1251..b50ec5520871 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -19,22 +19,20 @@
 #include "pasid.h"
 #include "trace.h"
 
-/* Check if an existing cache tag can be reused for a new association. */
-static bool cache_tage_match(struct cache_tag *tag, u16 domain_id,
-			     struct intel_iommu *iommu, struct device *dev,
-			     ioasid_t pasid, enum cache_tag_type type)
+static bool cache_tag_cmp(const struct cache_tag_id *left,
+			  const struct cache_tag_id *right)
 {
-	if (tag->id.type != type)
+	if (left->type != right->type)
 		return false;
 
-	if (tag->id.domain_id != domain_id || tag->id.pasid != pasid)
+	if (left->domain_id != right->domain_id || left->pasid != right->pasid)
 		return false;
 
-	if (type == CACHE_TAG_IOTLB || type == CACHE_TAG_NESTING_IOTLB)
-		return tag->id.iommu == iommu;
+	if (left->type == CACHE_TAG_DEVTLB || left->type == CACHE_TAG_NESTING_DEVTLB)
+		return left->dev == right->dev;
 
-	if (type == CACHE_TAG_DEVTLB || type == CACHE_TAG_NESTING_DEVTLB)
-		return tag->id.dev == dev;
+	if (left->type == CACHE_TAG_IOTLB || left->type == CACHE_TAG_NESTING_IOTLB)
+		return left->iommu == right->iommu;
 
 	return false;
 }
@@ -48,6 +46,13 @@ static int cache_tag_assign(struct dmar_domain *domain, u16 did,
 	struct intel_iommu *iommu = info->iommu;
 	struct cache_tag *tag, *temp;
 	unsigned long flags;
+	struct cache_tag_id cmp_tag = {
+		.type = type,
+		.pasid = pasid,
+		.iommu = info->iommu,
+		.dev = dev,
+		.domain_id = did
+	};
 
 	tag = kzalloc(sizeof(*tag), GFP_KERNEL);
 	if (!tag)
@@ -66,7 +71,7 @@ static int cache_tag_assign(struct dmar_domain *domain, u16 did,
 
 	spin_lock_irqsave(&domain->cache_lock, flags);
 	list_for_each_entry(temp, &domain->cache_tags, node) {
-		if (cache_tage_match(temp, did, iommu, dev, pasid, type)) {
+		if (cache_tag_cmp(&temp->id, &cmp_tag)) {
 			temp->users++;
 			spin_unlock_irqrestore(&domain->cache_lock, flags);
 			kfree(tag);
@@ -86,14 +91,21 @@ static void cache_tag_unassign(struct dmar_domain *domain, u16 did,
 			       struct device *dev, ioasid_t pasid,
 			       enum cache_tag_type type)
 {
-	struct device_domain_info *info = dev_iommu_priv_get(dev);
-	struct intel_iommu *iommu = info->iommu;
 	struct cache_tag *tag;
 	unsigned long flags;
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct cache_tag_id cmp_tag = {
+		.type = type,
+		.pasid = pasid,
+		.iommu = info->iommu,
+		.dev = dev,
+		.domain_id = did
+	};
+
 
 	spin_lock_irqsave(&domain->cache_lock, flags);
 	list_for_each_entry(tag, &domain->cache_tags, node) {
-		if (cache_tage_match(tag, did, iommu, dev, pasid, type)) {
+		if (cache_tag_cmp(&tag->id, &cmp_tag)) {
 			trace_cache_tag_unassign(tag);
 			if (--tag->users == 0) {
 				list_del(&tag->node);

-- 
2.43.0


