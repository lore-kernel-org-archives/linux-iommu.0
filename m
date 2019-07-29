Return-Path: <SRS0=zE+z=V2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F4DC7618B
	for <iommu@archiver.kernel.org>; Mon, 29 Jul 2019 16:47:51 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71FE221655
	for <iommu@archiver.kernel.org>; Mon, 29 Jul 2019 16:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLiSPcnQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71FE221655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 223CE1AAE;
	Mon, 29 Jul 2019 16:47:51 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 66BEC1709
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Jul 2019 16:45:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 08D756CE
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Jul 2019 16:45:26 +0000 (UTC)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
	[83.86.89.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 5EE07206A2;
	Mon, 29 Jul 2019 16:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564418725;
	bh=3s9fjiWfoQC1VKr4yL0l0Qevd6ZFmor54tcX1HnS68w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZLiSPcnQxj/Oa8aTvQorsciH0tP2p8wIrhlG6ie7UN7WKJ319q8JtyUD/H5B5DF5x
	am441SDIRY/6vCZqev1DCbkgL3GSnaFhM0yadMvSytmuIvtpXQQzdQif6HB09Ew2wu
	hIXnuQtqpIbrb2ipKDFR0PlNaNkN1awGRd5Jxxtc=
Date: Mon, 29 Jul 2019 18:45:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dmitry Safonov <dima@arista.com>
Subject: Re: Patch "iommu/vt-d: Don't queue_iova() if there is no flush
	queue" has been added to the 5.2-stable tree
Message-ID: <20190729164523.GA30925@kroah.com>
References: <1564417834188112@kroah.com>
	<7f66baf5-6492-12c0-c8b8-19cb1810b082@arista.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7f66baf5-6492-12c0-c8b8-19cb1810b082@arista.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Cc: jroedel@suse.de, iommu@lists.linux-foundation.org,
	stable-commits@vger.kernel.org, dwmw2@infradead.org
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

On Mon, Jul 29, 2019 at 05:36:09PM +0100, Dmitry Safonov wrote:
> Hi Greg,
> 
> On 7/29/19 5:30 PM, gregkh@linuxfoundation.org wrote:
> > 
> > This is a note to let you know that I've just added the patch titled
> > 
> >     iommu/vt-d: Don't queue_iova() if there is no flush queue
> > 
> > to the 5.2-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      iommu-vt-d-don-t-queue_iova-if-there-is-no-flush-queue.patch
> > and it can be found in the queue-5.2 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> Please, make sure to apply the following patch too (kudos to Joerg).
> [Sorry for any inconvenience cause by my copy-n-paste mistake]
> 
> commit 201c1db90cd6
> Author: Joerg Roedel <jroedel@suse.de>
> Date:   Tue Jul 23 09:51:00 2019 +0200
> 
>     iommu/iova: Fix compilation error with !CONFIG_IOMMU_IOVA
> 
>     The stub function for !CONFIG_IOMMU_IOVA needs to be
>     'static inline'.
> 
>     Fixes: effa467870c76 ('iommu/vt-d: Don't queue_iova() if there is no
> flush queue')
>     Signed-off-by: Joerg Roedel <jroedel@suse.de>
> 

Now also queued up to 5.2.y, thanks.

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
