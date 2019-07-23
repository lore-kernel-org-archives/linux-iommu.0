Return-Path: <SRS0=bViT=VU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8C7C76194
	for <iommu@archiver.kernel.org>; Tue, 23 Jul 2019 15:37:43 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BE5D2239F
	for <iommu@archiver.kernel.org>; Tue, 23 Jul 2019 15:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BE5D2239F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2F03BCBA;
	Tue, 23 Jul 2019 15:37:43 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B6718B49;
	Tue, 23 Jul 2019 15:37:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 21B69709;
	Tue, 23 Jul 2019 15:37:41 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 56C4968B02; Tue, 23 Jul 2019 17:37:39 +0200 (CEST)
Date: Tue, 23 Jul 2019 17:37:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v2] dma-mapping: Use dma_get_mask in dma_addressing_limited
Message-ID: <20190723153739.GC720@lst.de>
References: <20190722165149.3763-1-eric.auger@redhat.com>
	<77ba1061-08b6-421e-a6dd-d5db9851325b@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <77ba1061-08b6-421e-a6dd-d5db9851325b@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: mst@redhat.com, jasowang@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	iommu@lists.linux-foundation.org, eric.auger.pro@gmail.com,
	robin.murphy@arm.com, hch@lst.de
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

On Mon, Jul 22, 2019 at 06:56:49PM +0200, Auger Eric wrote:
> Hi Christoph,
> 
> On 7/22/19 6:51 PM, Eric Auger wrote:
> > We currently have cases where the dma_addressing_limited() gets
> > called with dma_mask unset. This causes a NULL pointer dereference.
> > 
> > Use dma_get_mask() accessor to prevent the crash.
> > 
> > Fixes: b866455423e0 ("dma-mapping: add a dma_addressing_limited helper")
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> As a follow-up of my last email, here is a patch featuring
> dma_get_mask(). But you don't have the WARN_ON_ONCE anymore, pointing
> out suspect users.
> 
> Feel free to pick up your preferred approach

I can take this for now as we are past the merge window.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
