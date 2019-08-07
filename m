Return-Path: <SRS0=TgA1=WD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79CEC31E40
	for <iommu@archiver.kernel.org>; Wed,  7 Aug 2019 01:11:00 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC9F8214C6
	for <iommu@archiver.kernel.org>; Wed,  7 Aug 2019 01:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzbNUPq0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC9F8214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6BBC9E3A;
	Wed,  7 Aug 2019 01:11:00 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B2C8DE32
	for <iommu@lists.linux-foundation.org>;
	Wed,  7 Aug 2019 01:10:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
	[209.85.210.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 50BEC7D2
	for <iommu@lists.linux-foundation.org>;
	Wed,  7 Aug 2019 01:10:59 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id r7so42472563pfl.3
	for <iommu@lists.linux-foundation.org>;
	Tue, 06 Aug 2019 18:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=pLscVIeraRyEsI/ZVsWf/Ehn8nKpW7O5E+U+Ez0Tgko=;
	b=LzbNUPq0Ea+FnwMLE91PDoI/5bNlSNdOirxg1wJ/cK1TeMkvkx1bNTHQcVhyW2mUCR
	yttgLXNjYR8eImJyCYzI6WNl5fHy/8Dxho/3VhfTSAG4SGDlyCgYiEPnbBNiczyRj8Ue
	KVCIkXNa5uP6WJrcMgy52dJrG5FjDRQBCsNxloOJH9wAG+jvr/mGWxJ16iGx0WW+/0dB
	PSd9pUJfpRuQ4vYd1kRs5s25zexrDVuGJ0RLtx4TrzekgcfIH9+IpuV4FnXVMM+lkajQ
	qGUSorw3PwT3tB+w4wSHhvajndjPXXTKoS+ugbOM2wMjM0xlPVd3NLG3hKgV0m7nKxLI
	2ZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=pLscVIeraRyEsI/ZVsWf/Ehn8nKpW7O5E+U+Ez0Tgko=;
	b=omzsFe1rhmnYF65TtS+35xClol8/+aCET+BI13VnB8eCeioltlE0XXHD6DBTpmOv5K
	A1eZhSpb/RhOEKgc8c1N7omyHnvY3XAM2JOFZAZaBHC0zc1ypgdWR1fU38f72kGQRDLq
	s2/aErBA9mVBTUC7Q7ZeKGi65JasQhMI9vYlSlA5tfHCp9/6hS6a2SzQ+q7PoUAwMR8B
	APtYdsjXuki4WvZbtsuckQtb+OHDZI8yv48mre7wO/Hv34DhPKsZ/61lHq5HU4ZOWhsj
	Jkvr1sKftZKNMUxzGVXLaiNSPl12v4pTm9kKiJyZ7W28ajf5pedJ9FUs25AcFs2Yecb5
	GU7w==
X-Gm-Message-State: APjAAAViIY3NKMtJ11bRRLpu9hl0NJ47CxN+FwgLP7f6Bybuv2H1JQbU
	fWUvan4+i6x3YdHOSTQE7j5geaOp
X-Google-Smtp-Source: APXvYqy7vy9fxJWpyg8H8vgqCEolK/v4wc00RVrlInzYNz+R/ESIPhCyj/3u6iXrLnghDeE52Pq/uQ==
X-Received: by 2002:a63:c1c:: with SMTP id b28mr5501936pgl.354.1565140258529; 
	Tue, 06 Aug 2019 18:10:58 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
	[216.228.112.22]) by smtp.gmail.com with ESMTPSA id
	c23sm82098381pgj.62.2019.08.06.18.10.57
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 06 Aug 2019 18:10:58 -0700 (PDT)
Date: Tue, 6 Aug 2019 18:11:51 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/dma: Handle SG length overflow better
Message-ID: <20190807011150.GA8938@Asurada-Nvidia.nvidia.com>
References: <fbdbb8c0e550ae559ea3eedc1fea084c0111f202.1564418681.git.robin.murphy@arm.com>
	<20190806152529.GB1198@8bytes.org>
	<166ef834-c10e-5f94-ee89-6a0caedf323d@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <166ef834-c10e-5f94-ee89-6a0caedf323d@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: iommu@lists.linux-foundation.org
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

Hi Robin,

On Tue, Aug 06, 2019 at 04:49:01PM +0100, Robin Murphy wrote:
> Hi Joerg,
> 
> On 06/08/2019 16:25, Joerg Roedel wrote:
> > Hi Robin,
> > 
> > On Mon, Jul 29, 2019 at 05:46:00PM +0100, Robin Murphy wrote:
> > > Since scatterlist dimensions are all unsigned ints, in the relatively
> > > rare cases where a device's max_segment_size is set to UINT_MAX, then
> > > the "cur_len + s_length <= max_len" check in __finalise_sg() will always
> > > return true. As a result, the corner case of such a device mapping an
> > > excessively large scatterlist which is mergeable to or beyond a total
> > > length of 4GB can lead to overflow and a bogus truncated dma_length in
> > > the resulting segment.
> > > 
> > > As we already assume that any single segment must be no longer than
> > > max_len to begin with, this can easily be addressed by reshuffling the
> > > comparison.
> > 
> > Has this been triggered in the wild of can this patch wait for the next
> > merge window?
> 
> My impression was that it's possible to hit this via relatively funky, but
> legitimate, use of dma-buf from userspace, however I don't know off-hand how
> many drivers actually support creating and exporting such crazy-large
> buffers in the first place.
>
> Nicolin - is your use-case something that's easy to do with standard
> software on stable kernels, or did it only come to light as part of a "big
> stack of embedded magic" type thing?

Well..it was triggered in our downstream test that's supposed to
cover large size (> 4G) corner case, so I don't feel it's "easy"
but our test case was running with 4.14 kernel so I also feel it
might be a good idea to Cc stable kernel even if we postpone the
patch during the merge window. I'll personally be fine with any
decision though -- if no one else cares that much, I'll backport
to our downstream 4.14 on my own.

As a reference, here is a partial list of mainline drivers that
were potentially affected, and are now secured by this change:
      drivers/dma/dw-edma/dw-edma-core.c:745:
        dma_set_max_seg_size(dma->dev, U32_MAX);
      drivers/dma/dma-axi-dmac.c:871:
        dma_set_max_seg_size(&pdev->dev, UINT_MAX);
      drivers/mmc/host/renesas_sdhi_internal_dmac.c:338:
        dma_set_max_seg_size(dev, 0xffffffff);
      drivers/nvme/host/pci.c:2520:
        dma_set_max_seg_size(dev->dev, 0xffffffff);

Above all, thanks for the fix.

Nicolin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
