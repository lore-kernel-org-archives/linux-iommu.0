Return-Path: <SRS0=Z7Xn=ZO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D24C432C0
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 16:29:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3B1D20714
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 16:29:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B1D20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 793EA87449;
	Fri, 22 Nov 2019 16:29:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 633ydbWVkXbv; Fri, 22 Nov 2019 16:29:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BD30E87446;
	Fri, 22 Nov 2019 16:29:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1436C1D74;
	Fri, 22 Nov 2019 16:29:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09D64C18DA
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 16:29:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 040B888319
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 16:29:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Kez-F7H1Yf51 for <iommu@lists.linux-foundation.org>;
 Fri, 22 Nov 2019 16:29:09 +0000 (UTC)
X-Greylist: delayed 18:41:31 by SQLgrey-1.7.6
Received: from smtprelay.hostedemail.com (smtprelay0089.hostedemail.com
 [216.40.44.89])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C43F68830E
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 16:29:09 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay08.hostedemail.com (Postfix) with ESMTP id 5E36A182CED2A;
 Fri, 22 Nov 2019 16:29:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: mom43_1547a037e0e3d
X-Filterd-Recvd-Size: 2884
Received: from XPS-9350.home (unknown [47.151.135.224])
 (Authenticated sender: joe@perches.com)
 by omf06.hostedemail.com (Postfix) with ESMTPA;
 Fri, 22 Nov 2019 16:29:06 +0000 (UTC)
Message-ID: <799a49ee8fc8041a00332e0866554ddc04a2b8b0.camel@perches.com>
Subject: Re: [PATCH v2] iommu/iova: silence warnings under memory pressure
From: Joe Perches <joe@perches.com>
To: Qian Cai <cai@lca.pw>, jroedel@suse.de
Date: Fri, 22 Nov 2019 08:28:41 -0800
In-Reply-To: <1574434760.9585.18.camel@lca.pw>
References: <20191122025510.4319-1-cai@lca.pw>
 <7fd08d481a372ea0b600f95c12166ab54ed5e267.camel@perches.com>
 <1574434760.9585.18.camel@lca.pw>
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, dwmw2@infradead.org,
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

On Fri, 2019-11-22 at 09:59 -0500, Qian Cai wrote:
> On Thu, 2019-11-21 at 20:37 -0800, Joe Perches wrote:
> > On Thu, 2019-11-21 at 21:55 -0500, Qian Cai wrote:
> > > When running heavy memory pressure workloads, this 5+ old system is
> > > throwing endless warnings below because disk IO is too slow to recover
> > > from swapping. Since the volume from alloc_iova_fast() could be large,
> > > once it calls printk(), it will trigger disk IO (writing to the log
> > > files) and pending softirqs which could cause an infinite loop and make
> > > no progress for days by the ongoimng memory reclaim. This is the counter
> > > part for Intel where the AMD part has already been merged. See the
> > > commit 3d708895325b ("iommu/amd: Silence warnings under memory
> > > pressure"). Since the allocation failure will be reported in
> > > intel_alloc_iova(), so just call printk_ratelimted() there and silence
> > > the one in alloc_iova_mem() to avoid the expensive warn_alloc().
> > 
> > []
> > > v2: use dev_err_ratelimited() and improve the commit messages.
> > 
> > []
> > > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> > 
> > []
> > > @@ -3401,7 +3401,8 @@ static unsigned long intel_alloc_iova(struct device *dev,
> > >  	iova_pfn = alloc_iova_fast(&domain->iovad, nrpages,
> > >  				   IOVA_PFN(dma_mask), true);
> > >  	if (unlikely(!iova_pfn)) {
> > > -		dev_err(dev, "Allocating %ld-page iova failed", nrpages);
> > > +		dev_err_ratelimited(dev, "Allocating %ld-page iova failed",
> > > +				    nrpages);
> > 
> > Trivia:
> > 
> > This should really have a \n termination on the format string
> > 
> > 		dev_err_ratelimited(dev, "Allocating %ld-page iova failed\n",
> > 
> > 
> 
> Why do you say so? It is right now printing with a newline added anyway.
> 
>  hpsa 0000:03:00.0: DMAR: Allocating 1-page iova failed

If another process uses pr_cont at the same time,
it can be interleaved.


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
