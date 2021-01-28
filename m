Return-Path: <SRS0=9w/B=G7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52176C433E0
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 13:19:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCF8464DE0
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 13:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCF8464DE0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 68364873BF;
	Thu, 28 Jan 2021 13:19:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aydp64JxNE-d; Thu, 28 Jan 2021 13:19:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 56F188738D;
	Thu, 28 Jan 2021 13:19:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40D5CC0FA7;
	Thu, 28 Jan 2021 13:19:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3DEBC013A
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 13:19:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 979E72E0DC
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 13:19:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 82kz3MEp0mAo for <iommu@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 13:19:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 2B4BA2E0DB
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 13:19:35 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B81C64DDE;
 Thu, 28 Jan 2021 13:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611839974;
 bh=oy6DwNZBrTw1qOrMEcuZBUeWInTQEfxSXSimhe4fB/A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JfC8bgCCTgKqX3NqllETad2FdWUXFUpBUzZL8rPeZBQVpjh4Ysb/1RYBoSS5k65xF
 Hzjl029SjTn7sAs6CYqnKXA5z4D1/5OrY+EESVFqQW/g/eNTt79JuXdQXQbkEvUqaY
 XIDBIRaLfXNv78YSM3ZV/hXgr/+3XnK0XZfg9y+3HoTLQUJ9muixlBI/1SY6zNbKZ3
 ujdsEcpqmfZonN78J87TJt9I8OQTIprEN2O3ERC3qlybOAj2V9OYAblMolnZnNlB4L
 8qIptLMzoCsr7Me29eB/BbgPhVg2LdyQ5taETEXJUA03llsRcTclx2b4V9IuWl3jAe
 c1SJCdJCSLE7g==
Date: Thu, 28 Jan 2021 13:19:29 +0000
From: Will Deacon <will@kernel.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH RFC 2/9] iommu: Add iova and size as parameters in
 iotlb_sync_map
Message-ID: <20210128131929.GA2296@willie-the-truck>
References: <161177711359.1311.417185373365934204.stgit@manet.1015granger.net>
 <161177763296.1311.15197214300351076283.stgit@manet.1015granger.net>
 <20210128125112.GN32671@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210128125112.GN32671@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: isaacm@codeaurora.org, iommu@lists.linux-foundation.org,
 Chuck Lever <chuck.lever@oracle.com>, robin.murphy@arm.com
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

Hi Joerg,

On Thu, Jan 28, 2021 at 01:51:12PM +0100, Joerg Roedel wrote:
> On Wed, Jan 27, 2021 at 03:00:32PM -0500, Chuck Lever wrote:
> > From: Yong Wu <yong.wu@mediatek.com>
> > 
> > iotlb_sync_map allow IOMMU drivers tlb sync after completing the whole
> > mapping. This patch adds iova and size as the parameters in it. then the
> > IOMMU driver could flush tlb with the whole range once after iova mapping
> > to improve performance.
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  drivers/iommu/iommu.c      |    4 ++--
> >  drivers/iommu/tegra-gart.c |    7 +++++--
> >  include/linux/iommu.h      |    3 ++-
> >  3 files changed, 9 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index c304a6a30d42..3d099a31ddca 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -2443,7 +2443,7 @@ static int _iommu_map(struct iommu_domain *domain, unsigned long iova,
> >  
> >  	ret = __iommu_map(domain, iova, paddr, size, prot, GFP_KERNEL);
> >  	if (ret == 0 && ops->iotlb_sync_map)
> > -		ops->iotlb_sync_map(domain);
> > +		ops->iotlb_sync_map(domain, iova, size);
> 
> How about using 'struct iommu_iotlb_gather' instead of directly passing
> the iova/size parameters here? The iotlb_sync() call-back uses it
> already.

Heads-up, but I already queued this patch as part of its original series:

https://lore.kernel.org/r/20210107122909.16317-1-yong.wu@mediatek.com

since it's part of the Mediatek series for 5.12.

Would you like me to drop that, or can we stick with passing iova and size
for now, with a view to refactoring it later on?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
