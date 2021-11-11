Return-Path: <SRS0=Rhk0=P6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97BDC433F5
	for <iommu@archiver.kernel.org>; Thu, 11 Nov 2021 00:33:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D4CC6124D
	for <iommu@archiver.kernel.org>; Thu, 11 Nov 2021 00:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7D4CC6124D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2E15580D6F;
	Thu, 11 Nov 2021 00:33:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1wx8CrT1EBCH; Thu, 11 Nov 2021 00:33:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F249E80D56;
	Thu, 11 Nov 2021 00:33:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4669C0020;
	Thu, 11 Nov 2021 00:33:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51C2EC001E
 for <iommu@lists.linux-foundation.org>; Thu, 11 Nov 2021 00:33:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 239B180D5C
 for <iommu@lists.linux-foundation.org>; Thu, 11 Nov 2021 00:33:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cXYeu4piTX3r for <iommu@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 00:33:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A9BA180D56
 for <iommu@lists.linux-foundation.org>; Thu, 11 Nov 2021 00:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636590782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MgMCKxcCYSiQGdD+V9jfrQAG7RhOKm16Z+OjmQPKo3Y=;
 b=GSJE2vx0rgL+aBWryQCUVwlvNjtazzHdREsOL1nc6omn5AB1bagc5BYUCy7/mS6VCafvBi
 Cm4k2Q/ILL7OJ67XOiT7L4D+wqeAQVDvkxJXyVKZQtaUZcZmX/h7SNqPjPzcLINiErln3C
 tVLOAMZFTZz7QRGx3sU+ZpyVJ6W8wkE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-fYU4wi6lPgefwE-vr-Mazw-1; Wed, 10 Nov 2021 19:32:59 -0500
X-MC-Unique: fYU4wi6lPgefwE-vr-Mazw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F05E815720;
 Thu, 11 Nov 2021 00:32:57 +0000 (UTC)
Received: from [172.30.41.16] (ovpn-115-6.phx2.redhat.com [10.3.115.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8AB545DEFB;
 Thu, 11 Nov 2021 00:32:50 +0000 (UTC)
Subject: [PATCH] iommu/vt-d: Fix unmap_pages support
From: Alex Williamson <alex.williamson@redhat.com>
To: baolu.lu@linux.intel.com
Date: Wed, 10 Nov 2021 17:32:50 -0700
Message-ID: <163659074748.1617923.12716161410774184024.stgit@omen>
User-Agent: StGit/1.0-8-g6af9-dirty
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: iommu@lists.linux-foundation.org, dwmw2@infradead.org
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

When supporting only the .map and .unmap callbacks of iommu_ops,
the IOMMU driver can make assumptions about the size and alignment
used for mappings based on the driver provided pgsize_bitmap.  VT-d
previously used essentially PAGE_MASK for this bitmap as any power
of two mapping was acceptably filled by native page sizes.

However, with the .map_pages and .unmap_pages interface we're now
getting page-size and count arguments.  If we simply combine these
as (page-size * count) and make use of the previous map/unmap
functions internally, any size and alignment assumptions are very
different.

As an example, a given vfio device assignment VM will often create
a 4MB mapping at IOVA pfn [0x3fe00 - 0x401ff].  On a system that
does not support IOMMU super pages, the unmap_pages interface will
ask to unmap 1024 4KB pages at the base IOVA.  dma_pte_clear_level()
will recurse down to level 2 of the page table where the first half
of the pfn range exactly matches the entire pte level.  We clear the
pte, increment the pfn by the level size, but (oops) the next pte is
on a new page, so we exit the loop an pop back up a level.  When we
then update the pfn based on that higher level, we seem to assume
that the previous pfn value was at the start of the level.  In this
case the level size is 256K pfns, which we add to the base pfn and
get a results of 0x7fe00, which is clearly greater than 0x401ff,
so we're done.  Meanwhile we never cleared the ptes for the remainder
of the range.  When the VM remaps this range, we're overwriting valid
ptes and the VT-d driver complains loudly, as reported by the user
report linked below.

The fix for this seems relatively simple, if each iteration of the
loop in dma_pte_clear_level() is assumed to clear to the end of the
level pte page, then our next pfn should be calculated from level_pfn
rather than our working pfn.

Fixes: 3f34f1259776 ("iommu/vt-d: Implement map/unmap_pages() iommu_ops callback")
Reported-by: Ajay Garg <ajaygargnsit@gmail.com>
Link: https://lore.kernel.org/all/20211002124012.18186-1-ajaygargnsit@gmail.com/
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/iommu/intel/iommu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d75f59ae28e6..f6395f5425f0 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1249,7 +1249,7 @@ static struct page *dma_pte_clear_level(struct dmar_domain *domain, int level,
 						       freelist);
 		}
 next:
-		pfn += level_size(level);
+		pfn = level_pfn + level_size(level);
 	} while (!first_pte_in_page(++pte) && pfn <= last_pfn);
 
 	if (first_pte)


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
