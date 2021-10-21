Return-Path: <SRS0=0R9D=PJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30680C433EF
	for <iommu@archiver.kernel.org>; Thu, 21 Oct 2021 07:00:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9146760FC1
	for <iommu@archiver.kernel.org>; Thu, 21 Oct 2021 07:00:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9146760FC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 57F70835D9;
	Thu, 21 Oct 2021 07:00:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sAJ-9ugz5dRM; Thu, 21 Oct 2021 07:00:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2FBD9833CD;
	Thu, 21 Oct 2021 07:00:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 047DBC0034;
	Thu, 21 Oct 2021 07:00:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 459B4C0033
 for <iommu@lists.linux-foundation.org>; Thu, 21 Oct 2021 07:00:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2E0264036E
 for <iommu@lists.linux-foundation.org>; Thu, 21 Oct 2021 07:00:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Pddi_ipeRLys for <iommu@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 06:59:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 333C14036A
 for <iommu@lists.linux-foundation.org>; Thu, 21 Oct 2021 06:59:58 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7DCB968BEB; Thu, 21 Oct 2021 08:59:54 +0200 (CEST)
Date: Thu, 21 Oct 2021 08:59:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 1/4] dma-direct: factor out dma_set_{de,en}crypted helpers
Message-ID: <20211021065954.GA28712@lst.de>
References: <20211019122916.2468032-1-hch@lst.de>
 <20211019122916.2468032-2-hch@lst.de>
 <b63b1097-9110-5474-9754-a12be7dc1f4f@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b63b1097-9110-5474-9754-a12be7dc1f4f@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

On Tue, Oct 19, 2021 at 12:54:54PM -0700, David Rientjes wrote:
> > -						   1 << get_order(size));
> > -			if (err)
> > -				goto out_free_pages;
> > -		}
> > +		err = dma_set_decrypted(dev, ret, size);
> 
> Should be
> 
> 	if (dma_set_decrypted(dev, ret, size))
> 		goto out_free_pages;
> 
> ?  Otherwise we ignore the value?

Yes.  Except that we also need to undo the remap as well.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
