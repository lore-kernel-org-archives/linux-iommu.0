Return-Path: <SRS0=NqTC=YJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAF3FA372B
	for <iommu@archiver.kernel.org>; Wed, 16 Oct 2019 10:12:02 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A57EC20650
	for <iommu@archiver.kernel.org>; Wed, 16 Oct 2019 10:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXbT4hNK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57EC20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 57DEFC2A;
	Wed, 16 Oct 2019 10:12:02 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7FCC8C21
	for <iommu@lists.linux-foundation.org>;
	Wed, 16 Oct 2019 10:12:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
	[209.85.167.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 68113821
	for <iommu@lists.linux-foundation.org>;
	Wed, 16 Oct 2019 10:12:00 +0000 (UTC)
Received: by mail-oi1-f196.google.com with SMTP id g81so1352042oib.8
	for <iommu@lists.linux-foundation.org>;
	Wed, 16 Oct 2019 03:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=fIAc7kYct8VpQ13hbYyhIsPB/WrvUenHD8qPKsYEDRE=;
	b=oXbT4hNKhD2uIHDdhfwvtPdiz9aqjjELCUA3i1w6gPw4XwKjzXNwIigRbIWeWKfmtp
	9qdDj2ni9pzSrplpKkx6aKJJH5BVecMXKEjfRmExaUQkbwL6Dcg7EvK1RR+mqTWacUYW
	afiIQ1D+Zlqg++/0laoXe2Ar+6NnZo12uopWOpdTgCHSz/6ivR0s4meXhFjXftUJnn5E
	u99AwkDRQkUgDT8393Wwhx2I27Lqxuw4M8b1GclfRCON2hDd079wooQGxrYr/N6VM1o7
	IGBUyL45BfGQHihicMGzaYaw8u+pWwx2np1kLJ+F05A8Q1PHCL/cTaM4Mc7EM/5Ao3v8
	pcig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=fIAc7kYct8VpQ13hbYyhIsPB/WrvUenHD8qPKsYEDRE=;
	b=Lc/yaqWte0NFNlYhQObn45ZHjZI7XTQ+vhJd/jEDgwBfeYYnngtGITXfe9vqKuvp+w
	LscuQSVu791bdeDWmVHPRQAVod8iiArW5cvEtEUCXi+nFwhtw0ozjmQiB2FMKopENXPR
	7kjBqUzhJqZj1CZdVFUfcYhoxhMC2buL6cslIdml1rMGAq7157LqpIdDI4buxFJz4fWL
	8JFaxjPBm415hHQLMTiJ7tByHfFPjBPeZfz/LkYV+2Esu2ieJEW8rIK1L3VyF862fxzK
	wMTNHzuYMdnnooBzoNFW0yJ7T4j3xRpMllckzIHiC8OROW3uTxjPgHA0jbKebhUmPK9e
	yTDw==
X-Gm-Message-State: APjAAAWfqpnXB8pJmuGKrQPMEPgu7giIbJDzXxvpm1fi7lmHkTKHO9cF
	/aaahIGiC6DbjZ57xmybENpZbsj2UYIdKcg3GJA=
X-Google-Smtp-Source: APXvYqzFzZuHz7bFYr0F46QP6TS5NUe9LqN11QyJ2UWcNxcs1w4oo6ZYum/5vBnHKrmP1nIOu2j9iO3oDTxaRC/J2Xg=
X-Received: by 2002:aca:dad6:: with SMTP id r205mr2642336oig.6.1571220719443; 
	Wed, 16 Oct 2019 03:11:59 -0700 (PDT)
MIME-Version: 1.0
References: <20191012122918.8066-1-mayhs11saini@gmail.com>
	<20191014022543.GA2674@ubuntu-m2-xlarge-x86>
In-Reply-To: <20191014022543.GA2674@ubuntu-m2-xlarge-x86>
From: Shyam Saini <mayhs11saini@gmail.com>
Date: Wed, 16 Oct 2019 15:41:39 +0530
Message-ID: <CAOfkYf5wagQzj0UboBdBh6iDq1ox=TN7inpatuhitw+Gsak1GQ@mail.gmail.com>
Subject: Re: [PATCH] kernel: dma: Make CMA boot parameters __ro_after_init
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Kees Cook <keescook@chromium.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-mm <linux-mm@kvack.org>, iommu@lists.linux-foundation.org,
	clang-built-linux@googlegroups.com, Christopher Lameter <cl@linux.com>,
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

Hi Nathan,

On Mon, Oct 14, 2019 at 7:55 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Sat, Oct 12, 2019 at 05:59:18PM +0530, Shyam Saini wrote:
> > This parameters are not changed after early boot.
> > By making them __ro_after_init will reduce any attack surface in the
> > kernel.
> >
> > Link: https://lwn.net/Articles/676145/
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Christopher Lameter <cl@linux.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Shyam Saini <mayhs11saini@gmail.com>
> > ---
> >  kernel/dma/contiguous.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> > index 69cfb4345388..1b689b1303cd 100644
> > --- a/kernel/dma/contiguous.c
> > +++ b/kernel/dma/contiguous.c
> > @@ -42,10 +42,10 @@ struct cma *dma_contiguous_default_area;
> >   * Users, who want to set the size of global CMA area for their system
> >   * should use cma= kernel parameter.
> >   */
> > -static const phys_addr_t size_bytes = (phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
> > -static phys_addr_t size_cmdline = -1;
> > -static phys_addr_t base_cmdline;
> > -static phys_addr_t limit_cmdline;
> > +static const phys_addr_t __ro_after_init size_bytes = (phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
>
> The 0day bot reported an issue with this change with clang:
>
> https://groups.google.com/d/msgid/clang-built-linux/201910140334.nhultlt8%25lkp%40intel.com
>
> kernel/dma/contiguous.c:46:36: error: 'size_cmdline' causes a section type conflict with 'size_bytes'
> static phys_addr_t __ro_after_init size_cmdline = -1;
>                                    ^
> kernel/dma/contiguous.c:45:42: note: declared here
> static const phys_addr_t __ro_after_init size_bytes = (phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
>                                          ^
> kernel/dma/contiguous.c:47:36: error: 'base_cmdline' causes a section type conflict with 'size_bytes'
> static phys_addr_t __ro_after_init base_cmdline;
>                                    ^
> kernel/dma/contiguous.c:45:42: note: declared here
> static const phys_addr_t __ro_after_init size_bytes = (phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
>                                          ^
> kernel/dma/contiguous.c:48:36: error: 'limit_cmdline' causes a section type conflict with 'size_bytes'
> static phys_addr_t __ro_after_init limit_cmdline;
>                                    ^
> kernel/dma/contiguous.c:45:42: note: declared here
> static const phys_addr_t __ro_after_init size_bytes = (phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
>                                          ^
> 3 errors generated.

Thanks for your feedback and reporting this error.

> The errors seem kind of cryptic at first but something that is const
> should automatically be in the read only section, this part of the
> commit seems unnecessary. Removing that part of the change fixes the error.

I have overlooked size_bytes variable
It shouldn't be const if it is declared as __ro_after_init.

I will fix and resend it.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
