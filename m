Return-Path: <SRS0=cQN6=S2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22266C10F11
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 14:28:03 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC66A20811
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 14:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC66A20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id BA6BD13BB;
	Wed, 24 Apr 2019 14:28:02 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DBD80137E
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 14:28:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 71020F4
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 14:28:00 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id EC19267358; Wed, 24 Apr 2019 16:27:43 +0200 (CEST)
Date: Wed, 24 Apr 2019 16:27:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] dma-mapping: remove an unnecessary NULL check
Message-ID: <20190424142743.GC20974@lst.de>
References: <20190424142437.GA29490@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190424142437.GA29490@mwanda>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	"kernel-janitors@vger.kernel.org H Hartley Sweeten"
	<hsweeten@visionengravers.com>, Ian Abbott <abbotti@mev.co.uk>,
	Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190424142743.frqwdcu4dGOGzkPT4L1E5H16lJpzczOU9S0lDkDdlg8@z>

On Wed, Apr 24, 2019 at 05:24:37PM +0300, Dan Carpenter wrote:
> We already dereferenced "dev" when we called get_dma_ops() so this NULL
> check is too late.  We're not supposed to pass NULL "dev" pointers to
> dma_alloc_attrs().

Thanks, applied to the dma-mapping for-next tree.

> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> There are still at least two drivers which do pass a NULL unfortunately.
> 
> drivers/staging/comedi/drivers/comedi_isadma.c:195 comedi_isadma_alloc() error: NULL dereference inside function 'dma_alloc_coherent()'
> drivers/staging/comedi/drivers/comedi_isadma.c:227 comedi_isadma_free() error: NULL dereference inside function 'dma_free_coherent()'

This is staging code.  Per official decree from Linus we can just
ignore it, and I tend to do so to keep my sanity.

> drivers/tty/synclink.c:3667 mgsl_alloc_buffer_list_memory() error: NULL dereference inside function 'dma_alloc_coherent()'
> drivers/tty/synclink.c:3738 mgsl_free_buffer_list_memory() error: NULL dereference inside function 'dma_free_coherent()'
> drivers/tty/synclink.c:3777 mgsl_alloc_frame_memory() error: NULL dereference inside function 'dma_alloc_coherent()'
> drivers/tty/synclink.c:3811 mgsl_free_frame_memory() error: NULL dereference inside function 'dma_free_coherent()'

The !PCI case there is dead since I removed PCI support a while ago.
Looks like it is still too convoluted for static checkers to notice that,
though.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
