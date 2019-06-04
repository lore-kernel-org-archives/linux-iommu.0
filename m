Return-Path: <SRS0=MUIX=UD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CCDC28CC6
	for <iommu@archiver.kernel.org>; Tue,  4 Jun 2019 21:24:58 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5CCA20848
	for <iommu@archiver.kernel.org>; Tue,  4 Jun 2019 21:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpXJfBaD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5CCA20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 84117D7A;
	Tue,  4 Jun 2019 21:24:58 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 78901CAF
	for <iommu@lists.linux-foundation.org>;
	Tue,  4 Jun 2019 21:24:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
	[209.85.208.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E63E484C
	for <iommu@lists.linux-foundation.org>;
	Tue,  4 Jun 2019 21:24:56 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id g13so2539820edu.5
	for <iommu@lists.linux-foundation.org>;
	Tue, 04 Jun 2019 14:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=rf+FVQdLlTmIquy8GtnYkoZWwK5gBvKD755XOjUXaig=;
	b=RpXJfBaDOqgqcYX8JOal7iS/UhumlB3RIJSKAjhkiyTRz0Zm5kybPTQuauuwxk1X2i
	r/cbqYlfe+lB9KReMWCGWJLGLVIUhffjLPqXlMZDxS1Jxynn+14oWL7VKlEW8EFtj+Tn
	bbGF34FZPFxCQu3YGoQ5H6Dl+qrS+73i3Vzi3FEjG82hwQQjXHncZ3n3m+AxELqrK0yE
	ZkkeXyxFikEUFHaDjp/wNNNn+V4GXkT2ER+tFf6E3cp0XxpAgUIchzzJ6XbgpBnZEn+r
	0PG6TEjeefPbIpGPckPKeCkh8QrqDU76LHBBZA1XGU2xe30A21aWdM31zIU/imET4VeZ
	AHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=rf+FVQdLlTmIquy8GtnYkoZWwK5gBvKD755XOjUXaig=;
	b=VldCnh+cU+S0+DVnU2L7+SxL97UoTVU1TT+REfJyTH4sEFkWEUpWrx69M99li8mUgY
	4dQf548Omo5y72R63L/4Wg3G/ptjm0reo11lQjx7Ot8Vr9NQpN5HhEplMbk8lxi8n9BE
	LKIs2xOFG32NylrIyVS+V7yojvzDWODk5mbCYF5G/Vi+lyNOq0maupYxESTveXlnYuI/
	MFZW50nCNLPaG2HAiGZvlhkfMhjLKSoZa9VNz17HYMTTzgSOgLvrL48eRpGQSht0ZOE0
	v2UzPHNAVdqQdnIcVdCF3ZgYAAqSS83kXcXyq0ZcOGdjc65VgSDdJXHDD5kBbaOn6Fto
	k7og==
X-Gm-Message-State: APjAAAWhw7lvehrN2zhMjDAHX6AImSzp+LDFeL8HuveZApSC1WPLNmks
	s4eTDPszwhAwhbjzqEPLbDVYpIltHAEMeVCd8cs=
X-Google-Smtp-Source: APXvYqze9nAxAtYScKLExAMJ/J8Pl+VAKFZsXTNV2XYiPxjg3cZrmhD5K4HOvAehCxAUiUqK+BPZ+1NHPN04THSrS4M=
X-Received: by 2002:a50:cbc4:: with SMTP id l4mr5976451edi.264.1559683495420; 
	Tue, 04 Jun 2019 14:24:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190506185207.31069-1-tmurphy@arista.com>
	<20190506185207.31069-2-tmurphy@arista.com>
	<33a1e3c1-1906-9e45-d060-e7998424973b@arm.com>
In-Reply-To: <33a1e3c1-1906-9e45-d060-e7998424973b@arm.com>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 4 Jun 2019 14:24:42 -0700
Message-ID: <CAF6AEGuk8GkbZ_XZJg6Gbpng+BaKjVHQ9M-6nGW0pi+h_Nh3Hw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] iommu: Add gfp parameter to iommu_ops::map
To: Robin Murphy <robin.murphy@arm.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Will Deacon <will.deacon@arm.com>,
	David Brown <david.brown@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>, linux-s390@vger.kernel.org,
	"moderated list:ARM/S5P EXYNOS AR..." <linux-samsung-soc@vger.kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	"open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
	Kukjin Kim <kgene@kernel.org>,
	Gerald Schaefer <gerald.schaefer@de.ibm.com>,
	Andy Gross <andy.gross@linaro.org>, linux-tegra@vger.kernel.org,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>, Tom Murphy <tmurphy@arista.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, murphyt7@tcd.ie,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
	Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
	David Woodhouse <dwmw2@infradead.org>
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

On Tue, Jun 4, 2019 at 11:11 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 06/05/2019 19:52, Tom Murphy wrote:
> > Add a gfp_t parameter to the iommu_ops::map function.
> > Remove the needless locking in the AMD iommu driver.
> >
> > The iommu_ops::map function (or the iommu_map function which calls it)
> > was always supposed to be sleepable (according to Joerg's comment in
> > this thread: https://lore.kernel.org/patchwork/patch/977520/ ) and so
> > should probably have had a "might_sleep()" since it was written. However
> > currently the dma-iommu api can call iommu_map in an atomic context,
> > which it shouldn't do. This doesn't cause any problems because any iommu
> > driver which uses the dma-iommu api uses gfp_atomic in it's
> > iommu_ops::map function. But doing this wastes the memory allocators
> > atomic pools.
>
> Hmm, in some cases iommu_ops::unmap may need to allocate as well,
> primarily if it needs to split a hugepage mapping. Should we pass flags
> through there as well, or are we prepared to assume that that case will
> happen rarely enough that it's fair to just assume GFP_ATOMIC? It won't
> happen for DMA ops, but it's conceivable that other users such as GPU
> drivers might make partial unmaps, and I doubt we could totally rule out
> the wackiest ones doing so from non-sleeping contexts.
>

jfyi, today we (well, drm/msm) only unmap entire buffers, so assuming
there isn't any coelescense of adjacent buffers that happen to form a
hugepage on ::map(), we are probably ok on ::unmap()..

we do always only call ::map or ::unmap under sleepable conditions.

btw, would it be simpler to just make gfp_t a domain a attribute?
That seems like it would be less churn, but maybe I'm overlooking
something.

BR,
-R
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
