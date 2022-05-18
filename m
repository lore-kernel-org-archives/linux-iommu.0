Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80ECFC433F5
	for <iommu@archiver.kernel.org>; Wed, 18 May 2022 13:12:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2CF4C408A6;
	Wed, 18 May 2022 13:12:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KT-cUrOvqYCn; Wed, 18 May 2022 13:12:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2A83B40895;
	Wed, 18 May 2022 13:12:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10DC7C0039;
	Wed, 18 May 2022 13:12:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 646CCC002D
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 13:12:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5236F826B0
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 13:12:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id INXKEgqfnX8G for <iommu@lists.linux-foundation.org>;
 Wed, 18 May 2022 13:12:44 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5BE5C8248F
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 13:12:43 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 63B0568AFE; Wed, 18 May 2022 15:12:37 +0200 (CEST)
Date: Wed, 18 May 2022 15:12:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH] dma-iommu: Add iommu_dma_max_mapping_size()
Message-ID: <20220518131237.GA26019@lst.de>
References: <1652706361-92557-1-git-send-email-john.garry@huawei.com>
 <f5b78c9c-312e-70ab-ecbb-f14623a4b6e3@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f5b78c9c-312e-70ab-ecbb-f14623a4b6e3@arm.com>
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

On Tue, May 17, 2022 at 11:40:52AM +0100, Robin Murphy wrote:
> Indeed, sorry but NAK for this being nonsense. As I've said at least once 
> before, if the unnecessary SAC address allocation attempt slows down your 
> workload, make it not do that in the first place. If you don't like the 
> existing command-line parameter then fine, there are plenty of other 
> options, it just needs to be done in a way that doesn't break x86 systems 
> with dodgy firmware, as my first attempt turned out to.

What broke x86?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
