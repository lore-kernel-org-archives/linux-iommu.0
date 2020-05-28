Return-Path: <SRS0=4TkS=7K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1750C433DF
	for <iommu@archiver.kernel.org>; Thu, 28 May 2020 06:42:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74349207D3
	for <iommu@archiver.kernel.org>; Thu, 28 May 2020 06:42:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74349207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 27679888DE;
	Thu, 28 May 2020 06:42:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MqP1xm93AIvL; Thu, 28 May 2020 06:42:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6869688763;
	Thu, 28 May 2020 06:42:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36D72C088D;
	Thu, 28 May 2020 06:42:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49224C016F
 for <iommu@lists.linux-foundation.org>; Thu, 28 May 2020 06:42:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 318528882F
 for <iommu@lists.linux-foundation.org>; Thu, 28 May 2020 06:42:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hSVc1jQwrFVH for <iommu@lists.linux-foundation.org>;
 Thu, 28 May 2020 06:42:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 05B1188763
 for <iommu@lists.linux-foundation.org>; Thu, 28 May 2020 06:42:21 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 2194526B; Thu, 28 May 2020 08:42:18 +0200 (CEST)
Date: Thu, 28 May 2020 08:42:16 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 02/10] iommu/amd: Unexport get_dev_data()
Message-ID: <20200528064216.GN5221@8bytes.org>
References: <20200527115313.7426-1-joro@8bytes.org>
 <20200527115313.7426-3-joro@8bytes.org>
 <20200528061353.GA17035@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200528061353.GA17035@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, jroedel@suse.de,
 linux-kernel@vger.kernel.org
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

On Wed, May 27, 2020 at 11:13:53PM -0700, Christoph Hellwig wrote:
> On Wed, May 27, 2020 at 01:53:05PM +0200, Joerg Roedel wrote:
> > From: Joerg Roedel <jroedel@suse.de>
> > 
> > This function is internal to the AMD IOMMU driver and only exported
> > because the amd_iommu_v2 modules calls it. But the reason it is called
> > from there could better be handled by amd_iommu_is_attach_deferred().
> > So unexport get_dev_data() and use amd_iommu_is_attach_deferred()
> > instead.
> 
> Btw, what is the reason amd_iommu_v2 is a separate module?  It is
> very little code, and other drivers seem to just integrate such
> functionality.

The module contains optional functionality that is only needed by the
amd_kfd driver, which itself only does something useful on (newer) AMD
GPUs. So I made it a separate module back in the days to save the memory
when it is not needed. But this caused other problems with the amd_kfd
module, when they got loaded in the wrong order. And the module is often
loaded by distros anyway, as it successfully loads even when no AMD
IOMMU is in the system. The reason for that was to have the symbols
available for drivers which can optionally use AMD IOMMUv2
functionality.

In fact I have already thought about making it built-in, just havn't
done so yet.


Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
