Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1733FCCA480
	for <iommu@archiver.kernel.org>; Thu, 30 Jun 2022 14:00:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 97114423EA;
	Thu, 30 Jun 2022 14:00:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 97114423EA
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nh//DLk7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GIQi4K-Q65k5; Thu, 30 Jun 2022 14:00:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CC3CD423F0;
	Thu, 30 Jun 2022 14:00:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CC3CD423F0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0168C007A;
	Thu, 30 Jun 2022 14:00:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42EF6C0011
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 09:33:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 061FE8452F
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 09:33:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 061FE8452F
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=nh//DLk7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hjNen4Ugg5lF for <iommu@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 09:33:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C969B84387
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C969B84387
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 09:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656581631; x=1688117631;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=PgPzLl4LLLWiWoEp5qpCglqPZ3JOM/ueCvqywhPsDcA=;
 b=nh//DLk73Sk/qA8Rf/5Eww21OalrxA2Ct46ybSFx+IObf8Lsw3Ie+6Gt
 FaM9FOtlQeG3M/dAkLKWANN1TeyLlp2f0MdGUg1tpG0RXzI6gBFi077r4
 Ocn4cSI3/VyQ9lfK8vGXW2jO4yPig2h/lMTzLMxH1kgXi7EZDrpHLMkCj
 /YEct4D/Hewbs1F2pPkRwViaOqs6ZsO25wFgoNcWy+moJfh21G97/2fpg
 0sgD1VRZaLPrzk1KqvRBqCcsXRDVEuh4l4K8u5hIcMAUdi4aDrC/+l6ng
 Wo+vkQ3rTiXGkGxAoYkx7qzCPDNpMCfYEp5Y5UlCOUQyR79/he9wPX3Bk A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="368615198"
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; d="scan'208";a="368615198"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2022 02:33:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; d="scan'208";a="693983715"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.138])
 by fmsmga002.fm.intel.com with ESMTP; 30 Jun 2022 02:33:47 -0700
Date: Thu, 30 Jun 2022 17:33:46 +0800
From: Feng Tang <feng.tang@intel.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/iova: change IOVA_MAG_SIZE to 127 to save memory
Message-ID: <20220630093346.GD4668@shbuild999.sh.intel.com>
References: <20220630073304.26945-1-feng.tang@intel.com>
 <13db50bb-57c7-0d54-3857-84b8a4591d9e@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <13db50bb-57c7-0d54-3857-84b8a4591d9e@arm.com>
X-Mailman-Approved-At: Thu, 30 Jun 2022 14:00:37 +0000
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Christoph Lameter <cl@linux.com>,
 Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>
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

Hi Robin,

On Thu, Jun 30, 2022 at 10:02:00AM +0100, Robin Murphy wrote:
> On 2022-06-30 08:33, Feng Tang wrote:
> > kmalloc will round up the request size to power of 2, and current
> > iova_magazine's size is 1032 (1024+8) bytes, so each instance
> > allocated will get 2048 bytes from kmalloc, causing around 1KB
> > waste.
> > 
> > And in some exstreme case, the memory wasted can trigger OOM as
> > reported in 2019 on a crash kernel with 256 MB memory [1].
> 
> I don't think it really needs pointing out that excessive memory consumption
> can cause OOM. Especially not in the particularly silly context of a system
> with only 2MB of RAM per CPU - that's pretty much guaranteed to be doomed
> one way or another.

Yes, the 256MB for 128 CPU is kind of extreme, will remove this.

> >    [    4.319253] iommu: Adding device 0000:06:00.2 to group 5
> >    [    4.325869] iommu: Adding device 0000:20:01.0 to group 15
> >    [    4.332648] iommu: Adding device 0000:20:02.0 to group 16
> >    [    4.338946] swapper/0 invoked oom-killer: gfp_mask=0x6040c0(GFP_KERNEL|__GFP_COMP), nodemask=(null), order=0, oom_score_adj=0
> >    [    4.350251] swapper/0 cpuset=/ mems_allowed=0
> >    [    4.354618] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.57.mx64.282 #1
> >    [    4.355612] Hardware name: Dell Inc. PowerEdge R7425/08V001, BIOS 1.9.3 06/25/2019
> >    [    4.355612] Call Trace:
> >    [    4.355612]  dump_stack+0x46/0x5b
> >    [    4.355612]  dump_header+0x6b/0x289
> >    [    4.355612]  out_of_memory+0x470/0x4c0
> >    [    4.355612]  __alloc_pages_nodemask+0x970/0x1030
> >    [    4.355612]  cache_grow_begin+0x7d/0x520
> >    [    4.355612]  fallback_alloc+0x148/0x200
> >    [    4.355612]  kmem_cache_alloc_trace+0xac/0x1f0
> >    [    4.355612]  init_iova_domain+0x112/0x170
> >    [    4.355612]  amd_iommu_domain_alloc+0x138/0x1a0
> >    [    4.355612]  iommu_group_get_for_dev+0xc4/0x1a0
> >    [    4.355612]  amd_iommu_add_device+0x13a/0x610
> >    [    4.355612]  add_iommu_group+0x20/0x30
> >    [    4.355612]  bus_for_each_dev+0x76/0xc0
> >    [    4.355612]  bus_set_iommu+0xb6/0xf0
> >    [    4.355612]  amd_iommu_init_api+0x112/0x132
> >    [    4.355612]  state_next+0xfb1/0x1165
> >    [    4.355612]  amd_iommu_init+0x1f/0x67
> >    [    4.355612]  pci_iommu_init+0x16/0x3f
> >    ...
> >    [    4.670295] Unreclaimable slab info:
> >    ...
> >    [    4.857565] kmalloc-2048           59164KB      59164KB
> > 
> > Change IOVA_MAG_SIZE from 128 to 127 to make size of 'iova_magazine'
> > 1024 bytes so that no memory will be wasted.
> > 
> > [1]. https://lkml.org/lkml/2019/8/12/266
> > 
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > ---
> >   drivers/iommu/iova.c | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> > index db77aa675145b..27634ddd9b904 100644
> > --- a/drivers/iommu/iova.c
> > +++ b/drivers/iommu/iova.c
> > @@ -614,7 +614,12 @@ EXPORT_SYMBOL_GPL(reserve_iova);
> >    * dynamic size tuning described in the paper.
> >    */
> > -#define IOVA_MAG_SIZE 128
> > +/*
> > + * As kmalloc's buffer size is fixed to power of 2, 127 is chosen to
> > + * assure size of 'iova_magzine' to be 1024 bytes, so that no memory
> 
> Typo: iova_magazine

will fix.

> > + * will be wasted.
> > + */
> > +#define IOVA_MAG_SIZE 127
> 
> The change itself seems perfectly reasonable, though.
> 
> Acked-by: Robin Murphy <robin.murphy@arm.com>
 
Thanks for the review!

- Feng

> >   #define MAX_GLOBAL_MAGS 32	/* magazines per bin */
> >   struct iova_magazine {
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
