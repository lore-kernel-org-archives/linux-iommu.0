Return-Path: <SRS0=WwkY=ED=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD805C388F7
	for <iommu@archiver.kernel.org>; Wed, 28 Oct 2020 17:31:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CEB1247F8
	for <iommu@archiver.kernel.org>; Wed, 28 Oct 2020 17:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CEB1247F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id AB7D120380;
	Wed, 28 Oct 2020 17:31:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E+NdwzaHxUSQ; Wed, 28 Oct 2020 17:31:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B344F20031;
	Wed, 28 Oct 2020 17:31:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90FE9C0859;
	Wed, 28 Oct 2020 17:31:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ADF94C0051
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 17:31:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 91EAB863DD
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 17:31:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QuECmdSVOlrF for <iommu@lists.linux-foundation.org>;
 Wed, 28 Oct 2020 17:31:13 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 58412863A4
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 17:31:13 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7742C68BFE; Wed, 28 Oct 2020 18:31:08 +0100 (CET)
Date: Wed, 28 Oct 2020 18:31:08 +0100
From: "hch@lst.de" <hch@lst.de>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: WARNING in dma_map_page_attrs
Message-ID: <20201028173108.GA10135@lst.de>
References: <000000000000335adc05b23300f6@google.com>
 <000000000000a0f8a305b261fe4a@google.com>
 <20201024111516.59abc9ec@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <BY5PR12MB4322CC03CE0D34B83269676ADC190@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20201027081103.GA22877@lst.de>
 <BY5PR12MB43221380BB0259FF0693BB0CDC160@BY5PR12MB4322.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BY5PR12MB43221380BB0259FF0693BB0CDC160@BY5PR12MB4322.namprd12.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
 "linaro-mm-sig-owner@lists.linaro.org"
 <linaro-mm-sig-owner@lists.linaro.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 syzbot <syzbot+34dc2fea3478e659af01@syzkaller.appspotmail.com>,
 Jakub Kicinski <kuba@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
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

On Tue, Oct 27, 2020 at 12:52:30PM +0000, Parav Pandit wrote:
> 
> > From: hch@lst.de <hch@lst.de>
> > Sent: Tuesday, October 27, 2020 1:41 PM
> > 
> > On Mon, Oct 26, 2020 at 05:23:48AM +0000, Parav Pandit wrote:
> > > Hi Christoph,
> > >
> > > > From: Jakub Kicinski <kuba@kernel.org>
> > > > Sent: Saturday, October 24, 2020 11:45 PM
> > > >
> > > > CC: rdma, looks like rdma from the stack trace
> > > >
> > > > On Fri, 23 Oct 2020 20:07:17 -0700 syzbot wrote:
> > > > > syzbot has found a reproducer for the following issue on:
> > > > >
> > > > > HEAD commit:    3cb12d27 Merge tag 'net-5.10-rc1' of
> > git://git.kernel.org/..
> > >
> > > In [1] you mentioned that dma_mask should not be set for dma_virt_ops.
> > > So patch [2] removed it.
> > >
> > > But check to validate the dma mask for all dma_ops was added in [3].
> > >
> > > What is the right way? Did I misunderstood your comment about
> > dma_mask in [1]?
> > 
> > No, I did not say we don't need the mask.  I said copying over the various
> > dma-related fields from the parent is bogus.
> > 
> > I think rxe (and ther other drivers/infiniband/sw drivers) need a simple
> > dma_coerce_mask_and_coherent and nothing else.
> 
> I see. Does below fix make sense?
> Is DMA_MASK_NONE correct?

DMA_MASK_NONE is gone in 5.10.  I think you want DMA_BIT_MASK(64).
That isn't actually correct for 32-bit platforms, but good enough.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
