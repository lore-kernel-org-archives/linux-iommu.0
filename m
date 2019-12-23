Return-Path: <SRS0=R7pc=2N=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA84C2D0C0
	for <iommu@archiver.kernel.org>; Mon, 23 Dec 2019 17:36:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBD7A206CB
	for <iommu@archiver.kernel.org>; Mon, 23 Dec 2019 17:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gF2RDbpd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBD7A206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 12334861F4;
	Mon, 23 Dec 2019 17:36:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TEeXCM0gV55o; Mon, 23 Dec 2019 17:36:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1DFCC8618E;
	Mon, 23 Dec 2019 17:36:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F22A7C1D81;
	Mon, 23 Dec 2019 17:36:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4FAC2C0881
 for <iommu@lists.linux-foundation.org>; Mon, 23 Dec 2019 17:36:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3D402859CC
 for <iommu@lists.linux-foundation.org>; Mon, 23 Dec 2019 17:36:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WxQP01dWt2kD for <iommu@lists.linux-foundation.org>;
 Mon, 23 Dec 2019 17:36:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8CBFD8598E
 for <iommu@lists.linux-foundation.org>; Mon, 23 Dec 2019 17:36:52 +0000 (UTC)
Received: from localhost (unknown [198.89.64.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 91A892073A;
 Mon, 23 Dec 2019 17:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1577122612;
 bh=otr7nCBWI0zNJBH4RGVN+HycmHQ8y2MM4Fq4EPBGHtE=;
 h=Subject:To:Cc:From:Date:From;
 b=gF2RDbpdrwp4pnI7DC68yLonKYEJa3W7QTfXg5bSEpQTEyYM6UJ9kTaKo66F8bBdX
 vtGIke/3pURrAMNkHStOibRonnkFzhEANfxAp0aICTqqCMOaGeOdr5qro4zHPhtvXf
 c/WpjSvGbUIwIrb+ILv9lcSQGxOccDnk3pkODpos=
Subject: Patch "iommu: set group default domain before creating direct
 mappings" has been added to the 5.4-stable tree
To: baolu.lu@linux.intel.com, gregkh@linuxfoundation.org,
 iommu@lists.linux-foundation.org, jroedel@suse.de, jsnitsel@redhat.com
From: <gregkh@linuxfoundation.org>
Date: Mon, 23 Dec 2019 12:36:16 -0500
Message-ID: <157712257620086@kroah.com>
MIME-Version: 1.0
X-stable: commit
X-Patchwork-Hint: ignore 
Cc: stable-commits@vger.kernel.org
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


This is a note to let you know that I've just added the patch titled

    iommu: set group default domain before creating direct mappings

to the 5.4-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     iommu-set-group-default-domain-before-creating-direct-mappings.patch
and it can be found in the queue-5.4 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From d360211524bece6db9920f32c91808235290b51c Mon Sep 17 00:00:00 2001
From: Jerry Snitselaar <jsnitsel@redhat.com>
Date: Tue, 10 Dec 2019 11:56:06 -0700
Subject: iommu: set group default domain before creating direct mappings

From: Jerry Snitselaar <jsnitsel@redhat.com>

commit d360211524bece6db9920f32c91808235290b51c upstream.

iommu_group_create_direct_mappings uses group->default_domain, but
right after it is called, request_default_domain_for_dev calls
iommu_domain_free for the default domain, and sets the group default
domain to a different domain. Move the
iommu_group_create_direct_mappings call to after the group default
domain is set, so the direct mappings get associated with that domain.

Cc: Joerg Roedel <jroedel@suse.de>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: stable@vger.kernel.org
Fixes: 7423e01741dd ("iommu: Add API to request DMA domain for device")
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iommu/iommu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2221,13 +2221,13 @@ request_default_domain_for_dev(struct de
 		goto out;
 	}
 
-	iommu_group_create_direct_mappings(group, dev);
-
 	/* Make the domain the default for this group */
 	if (group->default_domain)
 		iommu_domain_free(group->default_domain);
 	group->default_domain = domain;
 
+	iommu_group_create_direct_mappings(group, dev);
+
 	dev_info(dev, "Using iommu %s mapping\n",
 		 type == IOMMU_DOMAIN_DMA ? "dma" : "direct");
 


Patches currently in stable-queue which might be from jsnitsel@redhat.com are

queue-5.4/iommu-fix-kasan-use-after-free-in-iommu_insert_resv_region.patch
queue-5.4/iommu-vt-d-fix-dmar-pte-read-access-not-set-error.patch
queue-5.4/iommu-set-group-default-domain-before-creating-direct-mappings.patch
queue-5.4/tpm_tis-reserve-chip-for-duration-of-tpm_tis_core_init.patch
queue-5.4/iommu-vt-d-allocate-reserved-region-for-isa-with-correct-permission.patch
queue-5.4/iommu-vt-d-set-isa-bridge-reserved-region-as-relaxable.patch
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
