Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2312C433EF
	for <iommu@archiver.kernel.org>; Wed, 18 May 2022 13:14:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8765C611FD;
	Wed, 18 May 2022 13:14:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QdD57ipdsCVo; Wed, 18 May 2022 13:13:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 878F160E8D;
	Wed, 18 May 2022 13:13:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4FCABC0039;
	Wed, 18 May 2022 13:13:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D806C002D
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 13:13:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6BBD160E95
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 13:13:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s9IKbZ4Jnvj7 for <iommu@lists.linux-foundation.org>;
 Wed, 18 May 2022 13:13:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BDD9B60E8D
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 13:13:57 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9033A68AFE; Wed, 18 May 2022 15:13:53 +0200 (CEST)
Date: Wed, 18 May 2022 15:13:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH] dma-iommu: Add iommu_dma_max_mapping_size()
Message-ID: <20220518131353.GB26019@lst.de>
References: <1652706361-92557-1-git-send-email-john.garry@huawei.com>
 <f5b78c9c-312e-70ab-ecbb-f14623a4b6e3@arm.com>
 <9160031b-50be-6993-5a8e-f238391962c5@huawei.com>
 <8f193bdd-3a0a-f9ed-0726-e6081f374320@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8f193bdd-3a0a-f9ed-0726-e6081f374320@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: liyihang6@hisilicon.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, will@kernel.org, hch@lst.de
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

On Tue, May 17, 2022 at 01:02:00PM +0100, Robin Murphy wrote:
>> So how to inform the SCSI driver of this caching limit then so that it may 
>> limit the SGL length?
>
> Driver-specific mechanism; block-layer-specific mechanism; redefine this 
> whole API to something like dma_opt_mapping_size(), as a limit above which 
> mappings might become less efficient or start to fail (callback to my 
> thoughts on [1] as well, I suppose); many options. Just not imposing a 
> ridiculously low *maximum* on everyone wherein mapping calls "should not be 
> larger than the returned value" when that's clearly bollocks.

Well, for swiotlb it is a hard limit.  So if we want to go down that
route we need two APIs, one for the optimal size and one for the
hard limit.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
