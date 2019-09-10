Return-Path: <SRS0=BH3E=XF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449E2C49ED7
	for <iommu@archiver.kernel.org>; Tue, 10 Sep 2019 14:44:47 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1307B208E4
	for <iommu@archiver.kernel.org>; Tue, 10 Sep 2019 14:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1307B208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C9233DA2;
	Tue, 10 Sep 2019 14:44:46 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id AEE64D93
	for <iommu@lists.linux-foundation.org>;
	Tue, 10 Sep 2019 14:44:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 284938A2
	for <iommu@lists.linux-foundation.org>;
	Tue, 10 Sep 2019 14:44:45 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 1F8B8BDE; Tue, 10 Sep 2019 16:44:43 +0200 (CEST)
Date: Tue, 10 Sep 2019 16:44:40 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Qian Cai <cai@lca.pw>
Subject: Re: [PATCH] iommu/vt-d: Make function signatures static
Message-ID: <20190910144440.GA24103@8bytes.org>
References: <20190907064933.15277-1-adam.zerella@gmail.com>
	<20190910081545.GC3247@8bytes.org>
	<1568120816.5576.125.camel@lca.pw>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1568120816.5576.125.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, dwmw2@infradead.org,
	Adam Zerella <adam.zerella@gmail.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Tue, Sep 10, 2019 at 09:06:56AM -0400, Qian Cai wrote:
> On Tue, 2019-09-10 at 10:15 +0200, Joerg Roedel wrote:
> > On Sat, Sep 07, 2019 at 04:49:33PM +1000, Adam Zerella wrote:
> > >  drivers/iommu/intel-iommu.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > Applied, thanks.
> 
> Joerg, not sure if you saw the reply from Lu,
> 
> https://lore.kernel.org/linux-iommu/ba8d4792-3b62-98a8-31d8-74a08be2f983@linux.i
> ntel.com/

No, havn't seen any reply, but I figured out myself :)
This patch is already unmerged.


	Joerg

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
