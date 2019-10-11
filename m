Return-Path: <SRS0=QcZA=YE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E89AC47404
	for <iommu@archiver.kernel.org>; Fri, 11 Oct 2019 05:10:36 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA9AC214E0
	for <iommu@archiver.kernel.org>; Fri, 11 Oct 2019 05:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="boAOtvmC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA9AC214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 96AA31100;
	Fri, 11 Oct 2019 05:10:35 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7DADF1088
	for <iommu@lists.linux-foundation.org>;
	Fri, 11 Oct 2019 05:02:11 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2EBA414D
	for <iommu@lists.linux-foundation.org>;
	Fri, 11 Oct 2019 05:02:11 +0000 (UTC)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
	[83.86.89.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 6C878214E0;
	Fri, 11 Oct 2019 05:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570770130;
	bh=gL4yGj0SioGU1fefwakreiUM7DxKSrIrbCHtwBEgApM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=boAOtvmCgRi3utYxVgbaKp/aOrYMOXLTUoZ4+SDlZRQ4FMEhDMiOXkGQLIcbmLvOM
	nGxxJ4yX4yyVDd60TH67Coyw5iTm3Dl3MbKo0pN2023VfERjvxVFX4wk8/c8ij47mq
	O68rooK6BtpQmjGir5uykiTv931nWb+IR8x70CYQ=
Date: Fri, 11 Oct 2019 07:02:08 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3 1/2] dma-mapping: Add vmap checks to dma_map_single()
Message-ID: <20191011050208.GA978459@kroah.com>
References: <20191010222829.21940-1-keescook@chromium.org>
	<20191010222829.21940-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191010222829.21940-2-keescook@chromium.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Cc: Semmle Security Reports <security-reports@semmle.com>,
	linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
	iommu@lists.linux-foundation.org, Dan Carpenter <dan.carpenter@oracle.com>,
	Jesper Dangaard Brouer <brouer@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, Laura Abbott <labbott@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
	Allison Randal <allison@lohutok.net>
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

On Thu, Oct 10, 2019 at 03:28:28PM -0700, Kees Cook wrote:
> As we've seen from USB and other areas[1], we need to always do runtime
> checks for DMA operating on memory regions that might be remapped. This
> adds vmap checks (similar to those already in USB but missing in other
> places) into dma_map_single() so all callers benefit from the checking.
> 
> [1] https://git.kernel.org/linus/3840c5b78803b2b6cc1ff820100a74a092c40cbb
> 
> Suggested-by: Laura Abbott <labbott@redhat.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/dma-mapping.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 4a1c4fca475a..ff4e91c66f44 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -583,6 +583,12 @@ static inline unsigned long dma_get_merge_boundary(struct device *dev)
>  static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
>  		size_t size, enum dma_data_direction dir, unsigned long attrs)
>  {
> +	/* DMA must never operate on areas that might be remapped. */
> +	if (unlikely(is_vmalloc_addr(ptr))) {
> +		dev_warn_once(dev, "bad map: %zu bytes in vmalloc\n", size);

Can we get a bit better error text here?  In USB we were at least giving
people a hint as to what went wrong, "bad map" might not really make
that much sense to a USB developer as to what they needed to do to fix
this issue.

Other than that minor nit, I have no objection to this series, thanks
for fixing this up!

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
