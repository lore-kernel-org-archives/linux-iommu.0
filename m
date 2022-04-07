Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B395EC433EF
	for <iommu@archiver.kernel.org>; Thu,  7 Apr 2022 13:24:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5F970405D0;
	Thu,  7 Apr 2022 13:24:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 34qxQFEoFj12; Thu,  7 Apr 2022 13:24:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 658A3402A8;
	Thu,  7 Apr 2022 13:24:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 299C7C002C;
	Thu,  7 Apr 2022 13:24:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6F82C0012
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 13:24:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8ED1E81B60
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 13:24:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OpRzjPLXj1cu for <iommu@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 13:24:55 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7A3B481B17
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 13:24:55 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0CF6D68AFE; Thu,  7 Apr 2022 15:24:50 +0200 (CEST)
Date: Thu, 7 Apr 2022 15:24:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 3/4] iommu: remove the put_resv_regions method
Message-ID: <20220407132449.GB6383@lst.de>
References: <20220407062608.711392-1-hch@lst.de>
 <20220407062608.711392-4-hch@lst.de>
 <53c7ef1d-1835-2994-c2d2-6382f53599fa@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53c7ef1d-1835-2994-c2d2-6382f53599fa@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>,
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

On Thu, Apr 07, 2022 at 11:18:20AM +0100, Robin Murphy wrote:
> On 2022-04-07 07:26, Christoph Hellwig wrote:
>> All drivers that implement get_resv_regions just use
>> generic_put_resv_regions to implement the put side.  Remove the
>> indirections and document the allocations constraints.
>
> Unfortunately we need to keep this one for now, as the belated IORT RMR 
> support will finally be the first real user[1][2].
>
> Robin.
>
> [1] 
> https://lore.kernel.org/linux-iommu/20220404124209.1086-6-shameerali.kolothum.thodi@huawei.com/
> [2] 
> https://lore.kernel.org/linux-iommu/20220404124209.1086-7-shameerali.kolothum.thodi@huawei.com/

What these patches to looks wrong to me.  I'll comment there.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
