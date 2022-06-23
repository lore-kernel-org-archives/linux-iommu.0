Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA00C433EF
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 13:28:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3F9AF410EE;
	Thu, 23 Jun 2022 13:28:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3F9AF410EE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U6ZDSMOhMtaS; Thu, 23 Jun 2022 13:28:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F09304014D;
	Thu, 23 Jun 2022 13:28:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F09304014D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE532C0039;
	Thu, 23 Jun 2022 13:28:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB1C2C002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 13:28:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7FFC14014D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 13:28:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7FFC14014D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1a-T_kC9YjC5 for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 13:28:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8ADE6400AF
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8ADE6400AF
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 13:28:05 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 87A4D67373; Thu, 23 Jun 2022 15:28:00 +0200 (CEST)
Date: Thu, 23 Jun 2022 15:28:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH] dma-direct: use the correct size for dma_set_encrypted()
Message-ID: <20220623132800.GA9262@lst.de>
References: <20220622191424.15777-1-decui@microsoft.com>
 <20220623054352.GA12543@lst.de>
 <SN6PR2101MB132705E084BCC12BCDDF4E7FBFB59@SN6PR2101MB1327.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <SN6PR2101MB132705E084BCC12BCDDF4E7FBFB59@SN6PR2101MB1327.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>,
 Andrea Parri <Andrea.Parri@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Michael Kelley \(LINUX\)" <mikelley@microsoft.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

On Thu, Jun 23, 2022 at 07:00:58AM +0000, Dexuan Cui wrote:
> It looks like commit 4a37f3dd9a831 fixed a different issue?
> 
> Here my patch is for the latest mainline:
> 
> In dma_direct_alloc()'s error handling path, we pass 'size' to dma_set_encrypted():
>   out_encrypt_pages:
> 	  if (dma_set_encrypted(dev, page_address(page), size))
> 
> However, in dma_direct_free(), we pass ' 1 << page_order ' to dma_set_encrypted().
> I think the ' 1 << page_order' is incorrect and it should be 'size' as well?

Indeed.  I've applied the patch now.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
