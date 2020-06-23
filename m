Return-Path: <SRS0=bNYQ=AE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274B3C433E0
	for <iommu@archiver.kernel.org>; Tue, 23 Jun 2020 12:08:37 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE1782072E
	for <iommu@archiver.kernel.org>; Tue, 23 Jun 2020 12:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PMfAOLY4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE1782072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AB9688729E;
	Tue, 23 Jun 2020 12:08:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GdDD8IntAuYl; Tue, 23 Jun 2020 12:08:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 157ED8723F;
	Tue, 23 Jun 2020 12:08:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC424C0890;
	Tue, 23 Jun 2020 12:08:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A04B4C016F
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 12:08:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8D41E88BBB
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 12:08:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NdPyKLbJpxPz for <iommu@lists.linux-foundation.org>;
 Tue, 23 Jun 2020 12:08:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C39A2880E9
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 12:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592914111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ViGxFrmAKxAjcAMItQ3yJ5NR+d/lYg2p2N4cNIacjM4=;
 b=PMfAOLY4HyDQG9yIKU0xYpC/k1OSbUDUw4UCJoXaFTSwhu6LAmM7+vtGx4DGrLHruuva77
 A9Sz2ZnK+k1/vtNhdbK6afgHMOeAFkPy+4A+WZd5fpieo8j9a5vUcesMlqdKbqhKEXF4CF
 u17RbgQyYK8ZvUavXAR1iTwP0giPOL4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-VDK155b3PuKYRbDgZ7WDrg-1; Tue, 23 Jun 2020 08:08:27 -0400
X-MC-Unique: VDK155b3PuKYRbDgZ7WDrg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84AAD8035B9;
 Tue, 23 Jun 2020 12:08:05 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BF2895DAA0;
 Tue, 23 Jun 2020 12:07:59 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, hch@lst.de
Subject: [PATCH v2] dma-remap: Align the size in dma_common_*_remap()
Date: Tue, 23 Jun 2020 14:07:55 +0200
Message-Id: <20200623120755.27710-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: jean-philippe@linaro.org, peterz@infradead.org, akpm@linux-foundation.org,
 robin.murphy@arm.com, bbhushan2@marvell.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Running a guest with a virtio-iommu protecting virtio devices
is broken since commit 515e5b6d90d4 ("dma-mapping: use vmap insted
of reimplementing it"). Before the conversion, the size was
page aligned in __get_vm_area_node(). Doing so fixes the
regression.

Fixes: 515e5b6d90d4 ("dma-mapping: use vmap insted of reimplementing it")
Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v1 -> v2:
- fix line over 80 characters
---
 kernel/dma/remap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
index e739a6eea6e7..78b23f089cf1 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -24,7 +24,8 @@ void *dma_common_pages_remap(struct page **pages, size_t size,
 {
 	void *vaddr;
 
-	vaddr = vmap(pages, size >> PAGE_SHIFT, VM_DMA_COHERENT, prot);
+	vaddr = vmap(pages, PAGE_ALIGN(size) >> PAGE_SHIFT,
+		     VM_DMA_COHERENT, prot);
 	if (vaddr)
 		find_vm_area(vaddr)->pages = pages;
 	return vaddr;
@@ -37,7 +38,7 @@ void *dma_common_pages_remap(struct page **pages, size_t size,
 void *dma_common_contiguous_remap(struct page *page, size_t size,
 			pgprot_t prot, const void *caller)
 {
-	int count = size >> PAGE_SHIFT;
+	int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	struct page **pages;
 	void *vaddr;
 	int i;
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
