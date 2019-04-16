Return-Path: <SRS0=xVSy=SS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84818C10F13
	for <iommu@archiver.kernel.org>; Tue, 16 Apr 2019 11:58:52 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E3AE2077C
	for <iommu@archiver.kernel.org>; Tue, 16 Apr 2019 11:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Y3qzE8Cu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E3AE2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id F2D3EFE8;
	Tue, 16 Apr 2019 11:58:51 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5E40CACD
	for <iommu@lists.linux-foundation.org>;
	Tue, 16 Apr 2019 11:58:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BBA325E4
	for <iommu@lists.linux-foundation.org>;
	Tue, 16 Apr 2019 11:58:49 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id q16so25005764wmj.3
	for <iommu@lists.linux-foundation.org>;
	Tue, 16 Apr 2019 04:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=tvK2sa7exPaSAS1BCNTfVTF+f0dJduiqmdfTPCXRTxQ=;
	b=Y3qzE8CuehoVU2JfivbphrYd1kXSDbWiJd15b0YraHpauEe4+3KgXpvysPrkt+d0+q
	Nie2KkJCmBPzIQ1V+zNzrgXmt6Q4MZ/+r86391Oh9LisXSvHVyF1Ifnjb5usb/3vVRCO
	+rq6v7h1N3Hztfqd3Hg9RpyDQgCgLjefkXfnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=tvK2sa7exPaSAS1BCNTfVTF+f0dJduiqmdfTPCXRTxQ=;
	b=FWyj/Zej1binhDYG/RiynmxWMr8qmhKypS10tGV9/Kpe5sR/zxmM2iXCBiv+0MXe5j
	Q0e8rholfYo8cGFxgUy/w9lfIKJDuOhezn+supTYJZsIWMvQ7OAKlcrgLY013z33SYg0
	sL1i0Mkkz4S3U80Sd7Cv2pHwBGnmEdN6ksrxjM026PWnrwsiPhgjtlBnNLxsBgf2tgqG
	vkoOp7yaHsfc066M18vU6PsgCqw6VYRXGWxrA/17JEEkdpldSRzlPznH8Ovg52qr0Shq
	7C4uPwD8zgQBDOnJjSg+zei8+fNc1VX523K06ATZ+PPVE1oBwYh0dHSNP+npnMfoJhBB
	HbXA==
X-Gm-Message-State: APjAAAXqbegi4iLdOfoG9WUneuaNQWSeohQDDNlJ00tX5/2/Yx0PWCo4
	E79aAPYq+dHXER6XfFTZacFYvv1YVrEZ8rknSfUAaw==
X-Google-Smtp-Source: APXvYqx9pEsPdLDRVAfOZknCIo9BraQeodyvjhJEUqZ6zl8QqzmDfeG8+S2TeUCCpTnJFTA694wREsA0FbQTQGLRcEM=
X-Received: by 2002:a1c:b088:: with SMTP id z130mr26203392wme.5.1555415928328; 
	Tue, 16 Apr 2019 04:58:48 -0700 (PDT)
MIME-Version: 1.0
References: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com>
	<20190412223409.GB126710@google.com>
In-Reply-To: <20190412223409.GB126710@google.com>
Date: Tue, 16 Apr 2019 17:28:36 +0530
Message-ID:
 <CABe79T7h9t_Obmo3+B0MHgLZ4ff9GxpBBBLGtSf0C=zmLrWVBQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] PCIe Host request to reserve IOVA
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: poza@codeaurora.org, Ray Jui <rjui@broadcom.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	iommu@lists.linux-foundation.org,
	BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
	linux-pci@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
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
From: Srinath Mannam via iommu <iommu@lists.linux-foundation.org>
Reply-To: Srinath Mannam <srinath.mannam@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190416115836.Z_6FlfOCXuU8gVh8tGPKO8BtlH3zVdVnzIrIix0zccI@z>

Hi Bjorn,

Thanks for review. Please find my reply below.

On Sat, Apr 13, 2019 at 4:04 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Apr 12, 2019 at 08:43:32AM +0530, Srinath Mannam wrote:
> > Few SOCs have limitation that their PCIe host can't allow few inbound
> > address ranges. Allowed inbound address ranges are listed in dma-ranges
> > DT property and this address ranges are required to do IOVA mapping.
> > Remaining address ranges have to be reserved in IOVA mapping.
>
> If I understand correctly, devices below these PCIe host bridges can
> DMA only to the listed address ranges, and you prevent devices from
> doing DMA to the holes between the listed ranges by reserving the
> holes in dma-iommu.
Yes, devices below these PCIe host bridges can DMA only to the listed
address ranges,
and this patch prevents to allocate DMA(IOVA) addresses in the holes
of listed ranges.
>
> Apparently there's something that makes sure driver dma_map_*() always
> goes through dma-iommu?  I traced as far as seeing that dma-iommu
> depends on CONFIG_IOMMU_DMA, and that arm64 selects CONFIG_IOMMU_DMA
> if CONFIG_IOMMU_SUPPORT, but then the trail got cold.  I didn't see
> what selects CONFIG_IOMMU_SUPPORT.
IOMMU_SUPPORT depends on MMU.
>
> This does look like what Robin suggested, as far as I can tell.
> Hopefully he'll take a look and give his reviewed-by.  Thanks for
> persevering!
Thank you.

Regards,
Srinath.
>
> > PCIe Host driver of those SOCs has to list resource entries of allowed
> > address ranges given in dma-ranges DT property in sorted order. This
> > sorted list of resources will be processed and reserve IOVA address for
> > inaccessible address holes while initializing IOMMU domain.
> >
> > This patch set is based on Linux-5.0-rc2.
> >
> > Changes from v3:
> >   - Addressed Robin Murphy review comments.
> >     - pcie-iproc: parse dma-ranges and make sorted resource list.
> >     - dma-iommu: process list and reserve gaps between entries
> >
> > Changes from v2:
> >   - Patch set rebased to Linux-5.0-rc2
> >
> > Changes from v1:
> >   - Addressed Oza review comments.
> >
> > Srinath Mannam (3):
> >   PCI: Add dma_ranges window list
> >   iommu/dma: Reserve IOVA for PCIe inaccessible DMA address
> >   PCI: iproc: Add sorted dma ranges resource entries to host bridge
> >
> >  drivers/iommu/dma-iommu.c           | 19 ++++++++++++++++
> >  drivers/pci/controller/pcie-iproc.c | 44 ++++++++++++++++++++++++++++++++++++-
> >  drivers/pci/probe.c                 |  3 +++
> >  include/linux/pci.h                 |  1 +
> >  4 files changed, 66 insertions(+), 1 deletion(-)
> >
> > --
> > 2.7.4
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
