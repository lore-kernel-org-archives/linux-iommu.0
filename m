Return-Path: <SRS0=ORUS=OZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EC3C433FE
	for <iommu@archiver.kernel.org>; Tue,  5 Oct 2021 16:48:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7FBD611C5
	for <iommu@archiver.kernel.org>; Tue,  5 Oct 2021 16:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E7FBD611C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A0B8E4028B;
	Tue,  5 Oct 2021 16:48:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OUXFn1l3wtfL; Tue,  5 Oct 2021 16:48:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8706040284;
	Tue,  5 Oct 2021 16:48:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F73DC0011;
	Tue,  5 Oct 2021 16:48:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B39FC000D
 for <iommu@lists.linux-foundation.org>; Tue,  5 Oct 2021 16:48:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8A94940811
 for <iommu@lists.linux-foundation.org>; Tue,  5 Oct 2021 16:48:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gb8wscr5in8v for <iommu@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 16:48:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 361EC4080E
 for <iommu@lists.linux-foundation.org>; Tue,  5 Oct 2021 16:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:Message-Id:Date:Cc:To:From
 :references:content-disposition:in-reply-to;
 bh=uErNDWtyHIBmid4jyg5TQAPNLYpHrbLQkRhkR2esVR8=; b=fMq9tnv8/txWnsmOLZm7Jl46h3
 OzCzofJjTVJUsi8x30NxDM7dmkHDhtYPQIZ8VZt8ot2qvrz6sWJD+rtKR6jdnqTBpKQ5qso0A1IqI
 WUvk90XQnveXWIERxGpUTNoWEauvGyJL1zjuZgrm9ZGdrfSdfFhmormcljE4Intry3ciaDhUA/tuk
 mL+2O6yolkZrDDGezArriWW6RhRavD67de0CjXLVSFWCCSy6Qr/mAY4JQVWDluGBkdgV3fd3c5stt
 Y0O5WWUuMpTIS9neSCxo+8F3xTtIUXyWvy3dTEzbYP4Y4zBncP0eWQfrdgZBOdKfyS0Lg6t0jkrGB
 GkaUeTyQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1mXnc0-0007Y9-G4; Tue, 05 Oct 2021 10:48:18 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim
 4.94.2) (envelope-from <gunthorp@deltatee.com>)
 id 1mXnby-00049r-R6; Tue, 05 Oct 2021 10:48:14 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: Christoph Hellwig <hch@lst.de>,
	iommu@lists.linux-foundation.org
Date: Tue,  5 Oct 2021 10:48:12 -0600
Message-Id: <20211005164812.15938-1-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: hch@lst.de, iommu@lists.linux-foundation.org,
 linux-doc@vger.kernel.org, logang@deltatee.com, sfr@canb.auug.org.au
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH] dma-mapping: fix the kerneldoc for dma_map_sgtable()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Logan Gunthorpe <logang@deltatee.com>, linux-doc@vger.kernel.org
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

htmldocs began producing the following warnings:

  kernel/dma/mapping.c:256: WARNING: Definition list ends without a
             blank line; unexpected unindent.
  kernel/dma/mapping.c:257: WARNING: Bullet list ends without a blank
             line; unexpected unindent.

Reformatting the list without hyphens fixes the warnings and produces
both a readable text and HTML output.

Fixes: fffe3cc8c219 ("dma-mapping: allow map_sg() ops to return negative error code")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 kernel/dma/mapping.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 06fec5547e7c..49885023c223 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -249,12 +249,12 @@ EXPORT_SYMBOL(dma_map_sg_attrs);
  * Returns 0 on success or a negative error code on error. The following
  * error codes are supported with the given meaning:
  *
- *   -EINVAL - An invalid argument, unaligned access or other error
- *	       in usage. Will not succeed if retried.
- *   -ENOMEM - Insufficient resources (like memory or IOVA space) to
- *	       complete the mapping. Should succeed if retried later.
- *   -EIO    - Legacy error code with an unknown meaning. eg. this is
- *	       returned if a lower level call returned DMA_MAPPING_ERROR.
+ *   -EINVAL	An invalid argument, unaligned access or other error
+ *		in usage. Will not succeed if retried.
+ *   -ENOMEM	Insufficient resources (like memory or IOVA space) to
+ *		complete the mapping. Should succeed if retried later.
+ *   -EIO	Legacy error code with an unknown meaning. eg. this is
+ *		returned if a lower level call returned DMA_MAPPING_ERROR.
  */
 int dma_map_sgtable(struct device *dev, struct sg_table *sgt,
 		    enum dma_data_direction dir, unsigned long attrs)

base-commit: 9e1ff307c779ce1f0f810c7ecce3d95bbae40896
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
