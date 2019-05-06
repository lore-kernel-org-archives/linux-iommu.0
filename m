Return-Path: <SRS0=Zlue=TG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542ECC04A6B
	for <iommu@archiver.kernel.org>; Mon,  6 May 2019 17:57:42 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 096842053B
	for <iommu@archiver.kernel.org>; Mon,  6 May 2019 17:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="VTcOSw6D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 096842053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C34BF4B1A;
	Mon,  6 May 2019 17:57:41 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 11DA34953
	for <iommu@lists.linux-foundation.org>;
	Mon,  6 May 2019 17:56:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6DF55FD
	for <iommu@lists.linux-foundation.org>;
	Mon,  6 May 2019 17:56:26 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id y5so16321898wma.2
	for <iommu@lists.linux-foundation.org>;
	Mon, 06 May 2019 10:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arista.com; s=googlenew;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=XgcBPgF1G8mWsEvrlCrTStioPWUfDuKosdmWCCS6E5E=;
	b=VTcOSw6DyJHMGc0Los3OPWsCksrdPWPyD8vO7tfd4hoUYxYcfmFRvdg6+xhXohcDI4
	iaPbQJh8VcU547wAZs36ZseUPhEx2n6IGa7dslufaoh80Vv9iPal8eujdbqhX47dUUCf
	rd0f8NtzfQWEGvOpMeRmdX8JSJP8cWcKcVhIbhptYXMtK+CkC+jkyMF1+0K9zUfHIWKS
	SJl54+i/RAyvIlSJFHmzstzMCaSBfFTRYRQj0rviMBg1ovVLt3DHD9KLbmEDFh5DQkUB
	K/4VUUv6V6l3X4JgKl9DsDvUKdy2qvZJaDBJBTVgKEAth7AkIIbN3tSX8f+DjWvOa5Un
	ZWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=XgcBPgF1G8mWsEvrlCrTStioPWUfDuKosdmWCCS6E5E=;
	b=nR59lNhXppNfLhIKMCQmZVjyTRY+3slFQUvmpgmIC9yQWWnVGj6tUmXsjbf5Mhm1jm
	DbyVZHBPDjJrfyXaeRICZG4KWIXTAj/AgGHVOq3XkvZIrHz8TbSTl2Z7jgydoCRU4FAb
	bC/kzaA/J+xbqba25wy+Hi03MRq4e1FFZ+WomFoSz/huYZgZ5PENr+qA2sX3ymu/l8/I
	0FG/MfXBIoqOkEMhlVNOzLQPVKeA1vvn3VOXLPLNE+oB5BQjAtRLwlxwDsyQRb+j7/OM
	l8IwxrPCcuof9+3TNB/KwgPxhwY2JuP/qbfoVa3egTO5dTkQ9wq4/MqJFDb5/PgZ/gG0
	4f9w==
X-Gm-Message-State: APjAAAXp8LlrGqkYrg6uDKTisceTMz0hP/DiIXpWR/sD7BOBbOh5s5Jy
	2N6vAcWz14k/qYzLUf3ul/r/MBafzAQn1ZcwglEwkw==
X-Google-Smtp-Source: APXvYqy6O9Hx4Xu6PpK27h5ZvwKOZrtRiCBaX5D6FeKqa43xpsoBRLSUcAf7GCThq5ov8PH4U8Kpn29YDNsu9mBVmhc=
X-Received: by 2002:a1c:2e88:: with SMTP id u130mr10259976wmu.54.1557165384862;
	Mon, 06 May 2019 10:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190430002952.18909-1-tmurphy@arista.com>
	<20190430002952.18909-4-tmurphy@arista.com>
	<20190430111222.GA3191@infradead.org>
	<da835ce2-f73e-3035-e1d7-d3028cc1a838@arm.com>
	<20190430113253.GA23210@infradead.org>
	<96ebb6fc-a889-fa94-09ba-65d505b85724@arm.com>
In-Reply-To: <96ebb6fc-a889-fa94-09ba-65d505b85724@arm.com>
Date: Mon, 6 May 2019 18:56:13 +0100
Message-ID: <CAPL0++61WytVhs63tvt+hdpZKXGinrkYx=4nDtNx1UoNTRWWjw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] iommu/dma-iommu: Use the dev->coherent_dma_mask
To: Robin Murphy <robin.murphy@arm.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Will Deacon <will.deacon@arm.com>,
	David Brown <david.brown@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org,
	Kukjin Kim <kgene@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	Gerald Schaefer <gerald.schaefer@de.ibm.com>,
	Andy Gross <andy.gross@linaro.org>, linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>,
	iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>
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
From: Tom Murphy via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tom Murphy <tmurphy@arista.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Just to make this clear, I won't apply Christoph's patch (the one in
this email thread) and instead the only change I will make is to
rename dma_limit to dma_mask.

On Tue, Apr 30, 2019 at 1:05 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 30/04/2019 12:32, Christoph Hellwig wrote:
> > On Tue, Apr 30, 2019 at 12:27:02PM +0100, Robin Murphy wrote:
> >>> Hmm, I don't think we need the DMA mask for the MSI mapping, this
> >>> should probably always use a 64-bit mask.
> >>
> >> If that were true then we wouldn't need DMA masks for regular mappings
> >> either. If we have to map the MSI doorbell at all, then we certainly have to
> >> place it at an IOVA that the relevant device is actually capable of
> >> addressing.
> >
> > Well, as shown by the patch below we don't even look at the DMA mask
> > for the MSI page - we just allocate from bottom to top.
>
> In the trivial cookie for unmanaged domains, yes, but in that case the
> responsibility is on VFIO to provide a suitable (i.e. sub-32-bit)
> address range for that cookie in the first place. In the managed case,
> allocation uses the streaming mask via iommu_dma_get_msi_page() calling
> __iommu_dma_map(). Admittedly the mask can then get overlooked when
> reusing an existing mapping, which strictly could pose a problem if you
> have multiple devices with incompatible masks in the same group (and
> such that the PCI stuff doesn't already mitigate it), but that's such an
> obscure corner case that I'm reticent to introduce the complication to
> handle it until it's actually proven necessary.
>
> Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
