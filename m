Return-Path: <SRS0=Jdo0=25=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619E4C282DD
	for <iommu@archiver.kernel.org>; Wed,  8 Jan 2020 14:16:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23F2B206F0
	for <iommu@archiver.kernel.org>; Wed,  8 Jan 2020 14:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZClLkUHv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F2B206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id DE6A386C1D;
	Wed,  8 Jan 2020 14:16:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LYEhFeVQNntB; Wed,  8 Jan 2020 14:16:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4C39681C22;
	Wed,  8 Jan 2020 14:16:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3551DC1796;
	Wed,  8 Jan 2020 14:16:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 186CBC0881
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jan 2020 14:16:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0002985459
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jan 2020 14:16:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z0zlV+sHA51i for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jan 2020 14:16:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8390381C22
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jan 2020 14:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=orrAp5qHowtLQpXgT4GjUL4A2C2m41RL5Su2fHM9tqU=; b=ZClLkUHvXL6yYwb1MCz3OxTK6
 UpRfK8988Na6d1OO1FTXXZ7+TAJD1B7Rk6KjEV9W2ERsO9GPpiQgHy0x3TEIgR6q7q3uPFJubQpHM
 15OOeoX5MpgBgPqu5qeVoM7xvY1WSNFfQVthLlWL1143zYYKsbJxhwsH8MMYGFsU1UFxSUzq7dwyj
 a/ye2Ngq8CV7a6CcVzLmh/Wl6KOANnMs+Ncz803LCLCWee8o5WSHodypklEjoPspeHeUJjw7qw/Qo
 r1IAqGSCewkTyxmlPdtvUXDucj98dvjJRQw7G/OAC/mHf/g3IIZpvK0gF5r+k9VyR/seV6ShKd5hT
 YZf+qCI9w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1ipC7v-0004NO-CC; Wed, 08 Jan 2020 14:16:03 +0000
Date: Wed, 8 Jan 2020 06:16:03 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 22/22] iommu/vt-d: Add a quirk flag for scope mismatched
 devices
Message-ID: <20200108141603.GA11875@infradead.org>
References: <20200102001823.21976-1-baolu.lu@linux.intel.com>
 <20200102001823.21976-23-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200102001823.21976-23-baolu.lu@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Roland Dreier <roland@purestorage.com>, Jim Yan <jimyan@baidu.com>,
 iommu@lists.linux-foundation.org
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

> +/*
> + * We expect devices with endpoint scope to have normal PCI
> + * headers, and devices with bridge scope to have bridge PCI
> + * headers.  However some PCI devices may be listed in the
> + * DMAR table with bridge scope, even though they have a
> + * normal PCI header. We don't declare a socpe mismatch for
> + * below special cases.
> + */

Please use up all 80 lines for comments.

> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2f0d,	/* NTB devices  */
> +			 quirk_dmar_scope_mismatch);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2020,	/* NVME host */
> +			 quirk_dmar_scope_mismatch);

As said before "NVME host" host.  Besides the wrong spelling of NVMe,
the NVMe host is the Linux kernel, so describing a device as such seems
rather bogus.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
