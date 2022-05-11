Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E86C433EF
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 06:02:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EB86441621;
	Wed, 11 May 2022 06:02:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GB2tbdDqlARo; Wed, 11 May 2022 06:02:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8F7254160A;
	Wed, 11 May 2022 06:02:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B6B9C0039;
	Wed, 11 May 2022 06:02:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25FE1C002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 06:02:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1315740178
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 06:02:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mHTJHCmZi4xF for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 06:02:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 273C34011F
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 06:02:21 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 08AF268BFE; Wed, 11 May 2022 08:02:14 +0200 (CEST)
Date: Wed, 11 May 2022 08:02:12 +0200
From: "hch@lst.de" <hch@lst.de>
To: "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Subject: Re: [PATCH] swiotlb: Max mapping size takes min align mask into
 account
Message-ID: <20220511060212.GA32192@lst.de>
References: <20220510142109.777738-1-ltykernel@gmail.com>
 <cd64adcd-26fc-0452-754d-7ab0f5536142@arm.com>
 <PH0PR21MB302530B081D6CE6470D5F9A4D7C99@PH0PR21MB3025.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <PH0PR21MB302530B081D6CE6470D5F9A4D7C99@PH0PR21MB3025.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 Tianyu Lan <ltykernel@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "hch@infradead.org" <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "hch@lst.de" <hch@lst.de>, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 vkuznets <vkuznets@redhat.com>, KY Srinivasan <kys@microsoft.com>,
 Robin Murphy <robin.murphy@arm.com>, "jejb@linux.ibm.com" <jejb@linux.ibm.com>
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

On Tue, May 10, 2022 at 06:26:55PM +0000, Michael Kelley (LINUX) wrote:
> > Hmm, this seems a bit pessimistic - the offset can vary per mapping, so
> > it feels to me like it should really be the caller's responsibility to
> > account for it if they're already involved enough to care about both
> > constraints. But I'm not sure how practical that would be.
> 
> Tianyu and I discussed this prior to his submitting the patch.
> Presumably dma_max_mapping_size() exists so that the higher
> level blk-mq code can limit the size of I/O requests to something
> that will "fit" in the swiotlb when bounce buffering is enabled.

Yes, the idea that upper level code doesn't need to care was very
much the idea behind dma_max_mapping_size().

> As you mentioned, how else would a caller handle this situation?

Well, we could look at dma_get_min_align_mask in the caller and do
the calculation there, but I really don't think that is a good idea.

So this patch looks sensible to me.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
