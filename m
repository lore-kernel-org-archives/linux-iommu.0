Return-Path: <SRS0=ZipC=YH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00295C4CECE
	for <iommu@archiver.kernel.org>; Mon, 14 Oct 2019 02:39:38 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B363320815
	for <iommu@archiver.kernel.org>; Mon, 14 Oct 2019 02:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IS5BQ/44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B363320815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 70D9B253F;
	Mon, 14 Oct 2019 02:39:38 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6B5A724F9
	for <iommu@lists.linux-foundation.org>;
	Mon, 14 Oct 2019 02:25:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
	[209.85.210.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D49615D3
	for <iommu@lists.linux-foundation.org>;
	Mon, 14 Oct 2019 02:25:46 +0000 (UTC)
Received: by mail-ot1-f68.google.com with SMTP id 67so12546699oto.3
	for <iommu@lists.linux-foundation.org>;
	Sun, 13 Oct 2019 19:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=lP906qLGyTEBqe55BgoOje0n/wNr+NcPtklrVASvvHA=;
	b=IS5BQ/44O5nPSYEgMvhA5ue5f8rm2WjOUI0H0EaNT+szqXdXyFs4SCC/ZwFmnvPMt6
	EwazwfzkAyQiJJ9DFy6cE8623VjFb/VMuqqPQIZlafgsGnERyxmrMqgEnOFOtb+q0pSo
	NfAMizqzvJcwaj3hh2m6SzGAdM7mebp2YR9v3Zi/7ilcovua90ZnveeG/uhxtjs/1TAS
	97f9ArqI/yrg+8V3hNWg0cMWeIjH44FLUMJPrHnkPX+6V4KZQa7hdKZQMaADVgjQUfTK
	pEvBVDvVFMqWh8PLhTpOrAMrb9MpppnpV/v6D4B8va0USsaL2eNeQ65wcNF7wie6mvbN
	xkLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=lP906qLGyTEBqe55BgoOje0n/wNr+NcPtklrVASvvHA=;
	b=VwEINs5J2ihoBOQDsoRty7TTH/6zKlA2aGXLeALs1RHiq4ivcchXmPY9qxibA6x9s2
	g6/GGNIkAzLi/v2U3S1Uvki0nrZxZ03uV35SvQuYPti/gkUu3BlelbCLHViLkI0XYeE4
	B75z/8V7nRG7HKbxeJ693EPucAnZsAnFMCjblY/2xEqg459gmK5B8tnG55Q65ZVUC30s
	EZcifrzEzOJcApEsITmAdf/RqPnhKZpMKIaUsALYMZBQCx/fAHssfpEIGzLWMAk7G0oN
	NytcYD8+1FE5BPE2Li7oI0j6/h1388eDGWRwo5lmkXIwpzBBOHOrdNvfQxV+p0yzyFHn
	Ns+g==
X-Gm-Message-State: APjAAAXlOXX4ObFBSrBRrVPVsJocBSOA8XlMIQAV5zeTIsWZ9drJeEQT
	VOmqAb2Z3erVFnWgUTdn4D8=
X-Google-Smtp-Source: APXvYqx1/+cDEztMyAYHqWplLS7mX+pExI62RCoIIFZ6rpPAtHcWGm4akpgGk84aUZCSA9QdvuLz/Q==
X-Received: by 2002:a9d:12ac:: with SMTP id g41mr21703818otg.57.1571019945644; 
	Sun, 13 Oct 2019 19:25:45 -0700 (PDT)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
	by smtp.gmail.com with ESMTPSA id
	d95sm5617723otb.25.2019.10.13.19.25.44
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sun, 13 Oct 2019 19:25:45 -0700 (PDT)
Date: Sun, 13 Oct 2019 19:25:43 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Shyam Saini <mayhs11saini@gmail.com>
Subject: Re: [PATCH] kernel: dma: Make CMA boot parameters __ro_after_init
Message-ID: <20191014022543.GA2674@ubuntu-m2-xlarge-x86>
References: <20191012122918.8066-1-mayhs11saini@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191012122918.8066-1-mayhs11saini@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: Kees Cook <keescook@chromium.org>, kernel-hardening@lists.openwall.com,
	linux-kernel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	iommu@lists.linux-foundation.org, clang-built-linux@googlegroups.com,
	Christopher Lameter <cl@linux.com>, Robin Murphy <robin.murphy@arm.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Sat, Oct 12, 2019 at 05:59:18PM +0530, Shyam Saini wrote:
> This parameters are not changed after early boot.
> By making them __ro_after_init will reduce any attack surface in the
> kernel.
> 
> Link: https://lwn.net/Articles/676145/
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Christopher Lameter <cl@linux.com>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Shyam Saini <mayhs11saini@gmail.com>
> ---
>  kernel/dma/contiguous.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 69cfb4345388..1b689b1303cd 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -42,10 +42,10 @@ struct cma *dma_contiguous_default_area;
>   * Users, who want to set the size of global CMA area for their system
>   * should use cma= kernel parameter.
>   */
> -static const phys_addr_t size_bytes = (phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
> -static phys_addr_t size_cmdline = -1;
> -static phys_addr_t base_cmdline;
> -static phys_addr_t limit_cmdline;
> +static const phys_addr_t __ro_after_init size_bytes = (phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;

The 0day bot reported an issue with this change with clang:

https://groups.google.com/d/msgid/clang-built-linux/201910140334.nhultlt8%25lkp%40intel.com

kernel/dma/contiguous.c:46:36: error: 'size_cmdline' causes a section type conflict with 'size_bytes'
static phys_addr_t __ro_after_init size_cmdline = -1;
                                   ^
kernel/dma/contiguous.c:45:42: note: declared here
static const phys_addr_t __ro_after_init size_bytes = (phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
                                         ^
kernel/dma/contiguous.c:47:36: error: 'base_cmdline' causes a section type conflict with 'size_bytes'
static phys_addr_t __ro_after_init base_cmdline;
                                   ^
kernel/dma/contiguous.c:45:42: note: declared here
static const phys_addr_t __ro_after_init size_bytes = (phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
                                         ^
kernel/dma/contiguous.c:48:36: error: 'limit_cmdline' causes a section type conflict with 'size_bytes'
static phys_addr_t __ro_after_init limit_cmdline;
                                   ^
kernel/dma/contiguous.c:45:42: note: declared here
static const phys_addr_t __ro_after_init size_bytes = (phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
                                         ^
3 errors generated.

The errors seem kind of cryptic at first but something that is const
should automatically be in the read only section, this part of the
commit seems unnecessary. Removing that part of the change fixes the error.

Cheers,
Nathan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
