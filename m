Return-Path: <SRS0=07Ha=U3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D137FC5B57B
	for <iommu@archiver.kernel.org>; Fri, 28 Jun 2019 16:40:50 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A74492086D
	for <iommu@archiver.kernel.org>; Fri, 28 Jun 2019 16:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qtBdXq0X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A74492086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 74613C87;
	Fri, 28 Jun 2019 16:40:50 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 96AFAA67
	for <iommu@lists.linux-foundation.org>;
	Fri, 28 Jun 2019 16:29:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ua1-f66.google.com (mail-ua1-f66.google.com
	[209.85.222.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 84EDD3D0
	for <iommu@lists.linux-foundation.org>;
	Fri, 28 Jun 2019 16:29:35 +0000 (UTC)
Received: by mail-ua1-f66.google.com with SMTP id f20so2422875ual.0
	for <iommu@lists.linux-foundation.org>;
	Fri, 28 Jun 2019 09:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=bKHVDCcXPiE05peODNTqmlPBXDlbWR2UFo/K1we8S9c=;
	b=qtBdXq0XLD8BVGshscddAtfmjvkM+6vEB2fci5h7bCZ4QPj0ESqwfWXwFxyvi/bgia
	kVGVlU7Y0ZWBE++KzRXh3A/3Gu2lZ6RKr5PHf9WlBNxfOS/5/Wksj1RUTJ3ZKca12D/4
	ANk8oVjWBNAZ/5GUBCJqzKYf2rE9XPxBdJRUy5pynMcNABwPp+fWCNWF5kWfpv7cLuLn
	vsaPOk1Yunt+fZc8Mu0zuBdVCGK6Qg2DiX1apJzz/2NKU4KK3bNQNLYP9dAJ/JRswrfv
	VGLqYs5PjFjamcmAkCZV8ESowBAs/QIf/5reFutLohfqT+K9aTmiLimgGzHTcp7qqn+t
	Hmrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=bKHVDCcXPiE05peODNTqmlPBXDlbWR2UFo/K1we8S9c=;
	b=NLMjQSGy28XwTwsyl0TZY0VHUADYE8fwS/3cwFG3uonwKXBPPI/EupYO3gM3KCYeyn
	Zk/5lfE/6Evvv+5cBUtkeGr4Jcu6mISWvZn72kZeTzidx2LvuYuJd03mHxRatLuhLvT9
	sQjgJLuZV7AW+77vRY/0QASXT4OFOJ/hkvx3YOgLY2YxyLb1ocpw3nIOhlECF1YKXEPm
	95eQRgotnRZoiHnaXmsZPkTr321tkc6oF+t2BEalgdgSBgIPtdKogDlm3Q1e5vq/JwXG
	gGRJJx3z8lOhgf9VSAeOztx8gJTTfJmmqAKxIBb0TGgXzmGxmYYguPeDSyyFrEX894W2
	DiSw==
X-Gm-Message-State: APjAAAWM0fwyydYYzFUP2tmXcKyaIsZCRp/1/kCe/yPjJCfIN1CkFNgm
	cVOJrwvIaqpwUkyAe5rKkviUWJQCnbSeZ2fufIg=
X-Google-Smtp-Source: APXvYqydPIyXvwKpPrZ8ZcD8HVaLsCpFTpEJpv8to51zjquBaIgU+1LKqb+TWKruUHtHlmYHoUFwJbecHP4cb9e2WiU=
X-Received: by 2002:ab0:67d6:: with SMTP id w22mr339818uar.68.1561739374480;
	Fri, 28 Jun 2019 09:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <CACDBo564RoWpi8y2pOxoddnn0s3f3sA-fmNxpiXuxebV5TFBJA@mail.gmail.com>
	<CACDBo55GfomD4yAJ1qaOvdm8EQaD-28=etsRHb39goh+5VAeqw@mail.gmail.com>
	<20190626175131.GA17250@infradead.org>
In-Reply-To: <20190626175131.GA17250@infradead.org>
From: Pankaj Suryawanshi <pankajssuryawanshi@gmail.com>
Date: Fri, 28 Jun 2019 21:59:25 +0530
Message-ID: <CACDBo56fNVxVyNEGtKM+2R0X7DyZrrHMQr6Yw4NwJ6USjD5Png@mail.gmail.com>
Subject: Re: DMA-API attr - DMA_ATTR_NO_KERNEL_MAPPING
To: Christoph Hellwig <hch@infradead.org>
X-Mailman-Approved-At: Fri, 28 Jun 2019 16:40:49 +0000
Cc: linux-mm@kvack.org, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
	Michal Hocko <mhocko@kernel.org>
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

On Wed, Jun 26, 2019 at 11:21 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Jun 26, 2019 at 10:12:45PM +0530, Pankaj Suryawanshi wrote:
> > [CC: linux kernel and Vlastimil Babka]
>
> The right list is the list for the DMA mapping subsystem, which is
> iommu@lists.linux-foundation.org.  I've also added that.
>
> > > I am writing driver in which I used DMA_ATTR_NO_KERNEL_MAPPING attribute
> > > for cma allocation using dma_alloc_attr(), as per kernel docs
> > > https://www.kernel.org/doc/Documentation/DMA-attributes.txt  buffers
> > > allocated with this attribute can be only passed to user space by calling
> > > dma_mmap_attrs().
> > >
> > > how can I mapped in kernel space (after dma_alloc_attr with
> > > DMA_ATTR_NO_KERNEL_MAPPING ) ?
>
> You can't.  And that is the whole point of that API.

1. We can again mapped in kernel space using dma_remap() api , because
when we are using  DMA_ATTR_NO_KERNEL_MAPPING for dma_alloc_attr it
returns the page as virtual address(in case of CMA) so we can mapped
it again using dma_remap().

2. We can mapped in kernel space using vmap() as used for ion-cma
https://github.com/torvalds/linux/tree/master/drivers/staging/android/ion
 as used in function ion_heap_map_kernel().

Please let me know if i am missing anything.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
