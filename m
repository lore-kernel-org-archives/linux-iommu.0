Return-Path: <SRS0=DWjf=YY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F835CA9EC3
	for <iommu@archiver.kernel.org>; Thu, 31 Oct 2019 06:50:33 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EE1F20862
	for <iommu@archiver.kernel.org>; Thu, 31 Oct 2019 06:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="juXdlb9b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EE1F20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1EBAB41C;
	Thu, 31 Oct 2019 06:50:33 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1F2FA255
	for <iommu@lists.linux-foundation.org>;
	Thu, 31 Oct 2019 06:50:32 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C798F63D
	for <iommu@lists.linux-foundation.org>;
	Thu, 31 Oct 2019 06:50:31 +0000 (UTC)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
	[83.86.89.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id CD88E2083E;
	Thu, 31 Oct 2019 06:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572504631;
	bh=gbbppg5IoX5D4b7/HzOcXXHVR2UkAXTX0S0crnRQdWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=juXdlb9bZcMTtyT4MYJBmreT4PtueRB/7G1rGLLIVmRNSpd60hLrtvJ4PAYc2avlA
	mW3QPtMtdv4bF865BwLs+0FGz10hEVY6FbzYaw1dui3ois+coXMTXjwBhQA2ys1WVA
	qHXedv2PDRSQjzgkQZAJbSYAkWGv9ZQFB7IbU6TM=
Date: Thu, 31 Oct 2019 07:50:27 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v4 2/2] usb: core: Remove redundant vmap checks
Message-ID: <20191031065027.GA728148@kroah.com>
References: <20191029213423.28949-1-keescook@chromium.org>
	<20191029213423.28949-3-keescook@chromium.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191029213423.28949-3-keescook@chromium.org>
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

On Tue, Oct 29, 2019 at 02:34:23PM -0700, Kees Cook wrote:
> Now that the vmap area checks are being performed in the DMA
> infrastructure directly, there is no need to repeat them in USB.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/usb/core/hcd.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
