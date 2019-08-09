Return-Path: <SRS0=HAoA=WF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DBFC31E40
	for <iommu@archiver.kernel.org>; Fri,  9 Aug 2019 07:21:45 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECA562166E
	for <iommu@archiver.kernel.org>; Fri,  9 Aug 2019 07:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECA562166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id ED108C7D;
	Fri,  9 Aug 2019 07:21:43 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 07077C79
	for <iommu@lists.linux-foundation.org>;
	Fri,  9 Aug 2019 07:21:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
	[209.85.210.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 3987376F
	for <iommu@lists.linux-foundation.org>;
	Fri,  9 Aug 2019 07:21:40 +0000 (UTC)
Received: by mail-ot1-f65.google.com with SMTP id o101so129056070ota.8
	for <iommu@lists.linux-foundation.org>;
	Fri, 09 Aug 2019 00:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=A7mCF4lTq2gFXOvcmY2h+y2/MZQDfsM2+XB9S0QJ6k4=;
	b=nUaScqdbE0QEkGwQuKqp0hwlAXFHIbKqJA8FDo9X8vFkU3LuM9D0J42kcMUlnlh3Ee
	YLQhp48oPJwLr+8IyD6zgY3aADOI/fh4lSMWKxXJBd170d4pMHBF6O/2nCsLTFdwOJDF
	zahpne2FCwNKk/mHeMpf5Bq1mMmp9RgbNZi1syTNdy7X4OnbClqUpcBA0JZ2vgrSktEz
	m/bqPqs54Wp/Ou0wKEwp83TZeSOa47pP9BN/PWHHoUdgKM96b+hclOE2iCbXLEmkKc6O
	3bcauJJglpesmSiCzKV0KlCN2zOBuPmks+7Hd5eDxOBnscHLTrLMh1MiHgnDjD32Ig/D
	PbEg==
X-Gm-Message-State: APjAAAW2Taf5vQCLRCEy/iNUGnHQwSoInwtkgyOIaXqBU4TYxNhgCZy8
	y+YmvoHm72y6AYej4zez8JxqTiC7QE7OPJbFyWk=
X-Google-Smtp-Source: APXvYqyBXPOK98jaQhUmqtFlEEGP/W76NVu4RQ2ZHS+SsKdevOL3KYGUiRHhF15E80P339HCx6FddAsKPmlukbGoIK8=
X-Received: by 2002:a9d:7a90:: with SMTP id l16mr17247630otn.297.1565335299510;
	Fri, 09 Aug 2019 00:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190808160005.10325-1-hch@lst.de>
	<20190808160005.10325-9-hch@lst.de>
In-Reply-To: <20190808160005.10325-9-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 9 Aug 2019 09:21:28 +0200
Message-ID: <CAMuHMdV0JfZ_K2V7W0FQkobE_zLwe4Uez-EWzMMdTfVffpAWtA@mail.gmail.com>
Subject: Re: [PATCH 8/8] dma-mapping: remove CONFIG_ARCH_NO_COHERENT_DMA_MMAP
To: Christoph Hellwig <hch@lst.de>
Cc: linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Parisc List <linux-parisc@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Helge Deller <deller@gmx.de>,
	the arch/x86 maintainers <x86@kernel.org>,
	linux-m68k <linux-m68k@lists.linux-m68k.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux-foundation.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>
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

Hi Christoph,

On Thu, Aug 8, 2019 at 6:01 PM Christoph Hellwig <hch@lst.de> wrote:
> CONFIG_ARCH_NO_COHERENT_DMA_MMAP is now functionally identical to
> !CONFIG_MMU, so remove the separate symbol.  The only difference is that
> arm did not set it for !CONFIG_MMU, but arm uses a separate dma mapping
> implementation including its own mmap method, which is handled by moving
> the CONFIG_MMU check in dma_can_mmap so that is only applies to the
> dma-direct case, just as the other ifdefs for it.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

>  arch/m68k/Kconfig       |  1 -

For m68k:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
