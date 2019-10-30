Return-Path: <SRS0=11OQ=YX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD3ACA9EC5
	for <iommu@archiver.kernel.org>; Wed, 30 Oct 2019 19:26:45 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3712C20650
	for <iommu@archiver.kernel.org>; Wed, 30 Oct 2019 19:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQphk4Fx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3712C20650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 095E6E92;
	Wed, 30 Oct 2019 19:26:45 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 022A0E7B
	for <iommu@lists.linux-foundation.org>;
	Wed, 30 Oct 2019 19:26:43 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5F128876
	for <iommu@lists.linux-foundation.org>;
	Wed, 30 Oct 2019 19:26:43 +0000 (UTC)
Received: from localhost (unknown [84.241.198.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 5714820717;
	Wed, 30 Oct 2019 19:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572463603;
	bh=oZdsRq9DtlyqOY59UsuqYnw0hffYd6itQ5//OM9N0yo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EQphk4FxmCMxFxHG/5TYKSPi7YAgBs5IqWJDk/FAOpM+ZRPDtLpBZImpp4DiuE+Wb
	tzFvBrKBH0SaoI+5McjbOfZ6aDH8VO7HN+u3LOdtTMoGaywUTGTHn+o64hcAY6+Gdi
	++vTdUeKWYBxIh31wAgLOz3E1h5el+0NtcEWvm1A=
Date: Wed, 30 Oct 2019 20:26:40 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 1/2] dma-mapping: Add vmap checks to dma_map_single()
Message-ID: <20191030192640.GC709410@kroah.com>
References: <20191029213423.28949-1-keescook@chromium.org>
	<20191029213423.28949-2-keescook@chromium.org>
	<20191030091849.GA637042@kroah.com> <20191030180921.GB19366@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191030180921.GB19366@lst.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Cc: Kees Cook <keescook@chromium.org>,
	Semmle Security Reports <security-reports@semmle.com>,
	linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
	iommu@lists.linux-foundation.org, Dan Carpenter <dan.carpenter@oracle.com>,
	Jesper Dangaard Brouer <brouer@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, Laura Abbott <labbott@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>, Allison Randal <allison@lohutok.net>
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

On Wed, Oct 30, 2019 at 07:09:21PM +0100, Christoph Hellwig wrote:
> On Wed, Oct 30, 2019 at 10:18:49AM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Oct 29, 2019 at 02:34:22PM -0700, Kees Cook wrote:
> > > As we've seen from USB and other areas[1], we need to always do runtime
> > > checks for DMA operating on memory regions that might be remapped. This
> > > adds vmap checks (similar to those already in USB but missing in other
> > > places) into dma_map_single() so all callers benefit from the checking.
> > > 
> > > [1] https://git.kernel.org/linus/3840c5b78803b2b6cc1ff820100a74a092c40cbb
> > > 
> > > Suggested-by: Laura Abbott <labbott@redhat.com>
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > >  include/linux/dma-mapping.h | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> > > index 4a1c4fca475a..54de3c496407 100644
> > > --- a/include/linux/dma-mapping.h
> > > +++ b/include/linux/dma-mapping.h
> > > @@ -583,6 +583,12 @@ static inline unsigned long dma_get_merge_boundary(struct device *dev)
> > >  static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
> > >  		size_t size, enum dma_data_direction dir, unsigned long attrs)
> > >  {
> > > +	/* DMA must never operate on areas that might be remapped. */
> > > +	if (dev_WARN_ONCE(dev, is_vmalloc_addr(ptr),
> > > +			  "wanted %zu bytes mapped in vmalloc\n", size)) {
> > > +		return DMA_MAPPING_ERROR;
> > > +	}
> > 
> > That's a very odd error string, I know if I saw it for the first time, I
> > would have no idea what it meant.  The USB message at least gives you a
> > bit more context as to what went wrong and how to fix it.
> > 
> > How about something like "Memory is not DMA capabable, please fix the
> > allocation of it to be correct", or "non-dma-able memory was attempted
> > to be mapped, but this is impossible to to" or something else.
> 
> I've fixed the message to "rejecting DMA map of vmalloc memory" and
> applied the patch.

Looks good!  You can apply patch 2/2 as well if you want to take that
through your tree too.

thanks,

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
