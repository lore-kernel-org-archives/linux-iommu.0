Return-Path: <SRS0=ZdmF=UN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D50C31E4B
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 13:48:03 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8EF021537
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 13:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LZajKbx8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8EF021537
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id ACC15EC3;
	Fri, 14 Jun 2019 13:48:01 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A20FBEC2
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 13:48:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 217A9174
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 13:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+xs8xEvecIN+pidhw5Y71rlRjZmb8fJOnZhp8o/DsSw=;
	b=LZajKbx8vMWmoPyPihl3W8b1II
	oarEXVrrz2rxvZ0BgXTxaFSJ89DHAoMwNs46qftGPIs2iOcmI3PGUZe+ESDrKJqwk8Pn/9InuTjbe
	w/TkgWs39UEZl5gAqGPQNkS8QJr9eK5xRj4GSD3z1xgEem0WZvNMx/y06DWCWoiPPtMn6DV1KJtT4
	3dephzfXQQJVrhS8KA9VAcX9i7Lqdp6j+6fd+Du7mG+QFzmKyVufezvRPWVqUb7kH/R5PAyOXYi6v
	YOEZa1MgatXouQX+rfRB0aOlbZAvy1un6+StmE3Bzk1C+2JjRxYHzmpazpOIF5cCv5pJpncKedcmm
	mul+NSrA==;
Received: from 213-225-9-13.nat.highway.a1.net ([213.225.9.13] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
	id 1hbmYQ-0004jF-5L; Fri, 14 Jun 2019 13:47:42 +0000
From: Christoph Hellwig <hch@lst.de>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>,
	David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>
Subject: [PATCH 03/16] drm/i915: stop using drm_pci_alloc
Date: Fri, 14 Jun 2019 15:47:13 +0200
Message-Id: <20190614134726.3827-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614134726.3827-1-hch@lst.de>
References: <20190614134726.3827-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: devel@driverdev.osuosl.org, linux-s390@vger.kernel.org,
	Intel Linux Wireless <linuxwifi@intel.com>,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-mm@kvack.org, iommu@lists.linux-foundation.org,
	"moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
	linux-media@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Remove usage of the legacy drm PCI DMA wrappers, and with that the
incorrect usage cocktail of __GFP_COMP, virt_to_page on DMA allocation
and SetPageReserved.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/i915/i915_gem.c        | 30 +++++++++++++-------------
 drivers/gpu/drm/i915/i915_gem_object.h |  3 ++-
 drivers/gpu/drm/i915/intel_display.c   |  2 +-
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
index ad01c92aaf74..8f2053c91aff 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -228,7 +228,6 @@ i915_gem_get_aperture_ioctl(struct drm_device *dev, void *data,
 static int i915_gem_object_get_pages_phys(struct drm_i915_gem_object *obj)
 {
 	struct address_space *mapping = obj->base.filp->f_mapping;
-	drm_dma_handle_t *phys;
 	struct sg_table *st;
 	struct scatterlist *sg;
 	char *vaddr;
@@ -242,13 +241,13 @@ static int i915_gem_object_get_pages_phys(struct drm_i915_gem_object *obj)
 	 * to handle all possible callers, and given typical object sizes,
 	 * the alignment of the buddy allocation will naturally match.
 	 */
-	phys = drm_pci_alloc(obj->base.dev,
-			     roundup_pow_of_two(obj->base.size),
-			     roundup_pow_of_two(obj->base.size));
-	if (!phys)
+	obj->phys_vaddr = dma_alloc_coherent(&obj->base.dev->pdev->dev,
+			roundup_pow_of_two(obj->base.size),
+			&obj->phys_handle, GFP_KERNEL);
+	if (!obj->phys_vaddr)
 		return -ENOMEM;
 
-	vaddr = phys->vaddr;
+	vaddr = obj->phys_vaddr;
 	for (i = 0; i < obj->base.size / PAGE_SIZE; i++) {
 		struct page *page;
 		char *src;
@@ -286,18 +285,17 @@ static int i915_gem_object_get_pages_phys(struct drm_i915_gem_object *obj)
 	sg->offset = 0;
 	sg->length = obj->base.size;
 
-	sg_dma_address(sg) = phys->busaddr;
+	sg_dma_address(sg) = obj->phys_handle;
 	sg_dma_len(sg) = obj->base.size;
 
-	obj->phys_handle = phys;
-
 	__i915_gem_object_set_pages(obj, st, sg->length);
 
 	return 0;
 
 err_phys:
-	drm_pci_free(obj->base.dev, phys);
-
+	dma_free_coherent(&obj->base.dev->pdev->dev,
+			roundup_pow_of_two(obj->base.size), obj->phys_vaddr,
+			obj->phys_handle);
 	return err;
 }
 
@@ -335,7 +333,7 @@ i915_gem_object_put_pages_phys(struct drm_i915_gem_object *obj,
 
 	if (obj->mm.dirty) {
 		struct address_space *mapping = obj->base.filp->f_mapping;
-		char *vaddr = obj->phys_handle->vaddr;
+		char *vaddr = obj->phys_vaddr;
 		int i;
 
 		for (i = 0; i < obj->base.size / PAGE_SIZE; i++) {
@@ -363,7 +361,9 @@ i915_gem_object_put_pages_phys(struct drm_i915_gem_object *obj,
 	sg_free_table(pages);
 	kfree(pages);
 
-	drm_pci_free(obj->base.dev, obj->phys_handle);
+	dma_free_coherent(&obj->base.dev->pdev->dev,
+			roundup_pow_of_two(obj->base.size), obj->phys_vaddr,
+			obj->phys_handle);
 }
 
 static void
@@ -603,7 +603,7 @@ i915_gem_phys_pwrite(struct drm_i915_gem_object *obj,
 		     struct drm_i915_gem_pwrite *args,
 		     struct drm_file *file)
 {
-	void *vaddr = obj->phys_handle->vaddr + args->offset;
+	void *vaddr = obj->phys_vaddr + args->offset;
 	char __user *user_data = u64_to_user_ptr(args->data_ptr);
 
 	/* We manually control the domain here and pretend that it
@@ -1431,7 +1431,7 @@ i915_gem_pwrite_ioctl(struct drm_device *dev, void *data,
 		ret = i915_gem_gtt_pwrite_fast(obj, args);
 
 	if (ret == -EFAULT || ret == -ENOSPC) {
-		if (obj->phys_handle)
+		if (obj->phys_vaddr)
 			ret = i915_gem_phys_pwrite(obj, args, file);
 		else
 			ret = i915_gem_shmem_pwrite(obj, args);
diff --git a/drivers/gpu/drm/i915/i915_gem_object.h b/drivers/gpu/drm/i915/i915_gem_object.h
index ca93a40c0c87..14bd2d61d0f6 100644
--- a/drivers/gpu/drm/i915/i915_gem_object.h
+++ b/drivers/gpu/drm/i915/i915_gem_object.h
@@ -290,7 +290,8 @@ struct drm_i915_gem_object {
 	};
 
 	/** for phys allocated objects */
-	struct drm_dma_handle *phys_handle;
+	dma_addr_t phys_handle;
+	void *phys_vaddr;
 
 	struct reservation_object __builtin_resv;
 };
diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
index 5098228f1302..4f8b368ac4e2 100644
--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -10066,7 +10066,7 @@ static u32 intel_cursor_base(const struct intel_plane_state *plane_state)
 	u32 base;
 
 	if (INTEL_INFO(dev_priv)->display.cursor_needs_physical)
-		base = obj->phys_handle->busaddr;
+		base = obj->phys_handle;
 	else
 		base = intel_plane_ggtt_offset(plane_state);
 
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
