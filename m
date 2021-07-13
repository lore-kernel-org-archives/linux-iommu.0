Return-Path: <SRS0=kZfo=MF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FD5C07E96
	for <iommu@archiver.kernel.org>; Tue, 13 Jul 2021 23:57:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 484A961369
	for <iommu@archiver.kernel.org>; Tue, 13 Jul 2021 23:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 484A961369
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=darnok.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0C13440537;
	Tue, 13 Jul 2021 23:57:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0rQsiV8r1QWP; Tue, 13 Jul 2021 23:57:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E39EC400D8;
	Tue, 13 Jul 2021 23:57:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4711C001A;
	Tue, 13 Jul 2021 23:57:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C7B3C000E
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 23:57:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F158940658
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 23:57:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HiCCGwXVfh3j for <iommu@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 23:57:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BBD5F4053F
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 23:57:43 +0000 (UTC)
Received: by mail-qt1-x829.google.com with SMTP id w13so653626qtc.0
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 16:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=8zVi6Upa6TvGQVrA4Uk3V9Aucme5rYYsn/FFlTnsYBE=;
 b=Jm53ya8qCS8kvz06IHHppipSYsjZFWjWQzGX6KnPDMOqtJsbSAfCMgZi9NE7MQESim
 aiQuq3ZWuZFbvBzPLwVzURfjxjGXTqkP6adcDU4KzvFzuIvXywZ1LI/noRlK57+Rh3Fi
 QFTGh4jfriWjkO/Iw9EnL6z63r+W/6vd6I684CrjXs9ZRIlN8FcDhy3mDA6mHL8vAQXk
 XYWKmdDYiNuPTWnWKolsj8yA2wIEBR4/WZR6XWJtWwu65fC31tGOVXrUepE/RrUW75aQ
 CWesEvdaXRlwNTM5hFkot1Uo1s+PDgLGnPSHhU5qqiX8CnCqC2T6rx+bj2wWMw7AYD49
 69AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=8zVi6Upa6TvGQVrA4Uk3V9Aucme5rYYsn/FFlTnsYBE=;
 b=WXFIErXdgHHuby7+j5vpds7E08raZapYUgfOOftFUXNiqAYWDVhvnldIuRp8tbb8TG
 dLy5F7KVQ49I12O11ai6XJTsj6nsva3ECRqfO6CV7Y8Gs/V4GLr4y1OruS3sw6WR1Y4L
 VY3FUhcTxM6CXWtT+MwgaZMqexXU4gOqZLoVbBqP0s8Ti2rVTro/G5mos/TS9X9Hynk+
 lqqfPUZYsJAN/fCO9rQ0OsiRgkliBgMTZZ0+ZUr1i/ctSqIqcJiNMoxbJIHtQzmOiLRC
 Jk9P1F2Zgww5DI4h7ZeqfU/M0CIvCWhpW9urYF1/MRQJIsl0vzF8FnYa8EMeuVkFJuam
 hMbg==
X-Gm-Message-State: AOAM531F0/wj/jk2W5rtYtXkL+HMJYqafX+EHmTtMOk4kmI3eNEAURqa
 KQPP5dzxANQGlFEM3fh5Pas=
X-Google-Smtp-Source: ABdhPJwnKv9aLbsVfdblhmDtQKkmuAhXYGTLAEDiKLh9RpaAl7uhjGSZDhFpZYjRnHnzu1ZLAdCg4g==
X-Received: by 2002:ac8:5a94:: with SMTP id c20mr6734807qtc.30.1626220662527; 
 Tue, 13 Jul 2021 16:57:42 -0700 (PDT)
Received: from fedora ([130.44.160.152])
 by smtp.gmail.com with ESMTPSA id u11sm226399qkk.72.2021.07.13.16.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jul 2021 16:57:41 -0700 (PDT)
Date: Tue, 13 Jul 2021 19:57:40 -0400
From: Konrad Rzeszutek Wilk <konrad@darnok.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/amd: Enable swiotlb if any device supports iommu
 v2 and uses identity mapping
Message-ID: <YO4odF0EwqxfNLFq@fedora>
References: <20210708074232.924844-1-kai.heng.feng@canonical.com>
 <YObFJREB9/JlcNZP@8bytes.org>
 <fde11cec-d1bd-49be-f129-c69a973d1b3b@arm.com>
 <CAAd53p40RcG0oeYr9QAKMjYRtyq7he=d_b_a39n4Rt5JSVScRQ@mail.gmail.com>
 <f3bdedcb-5602-cbca-7df1-019e8b8c4217@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f3bdedcb-5602-cbca-7df1-019e8b8c4217@arm.com>
Cc: "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>, will@kernel.org,
 open list <linux-kernel@vger.kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Jul 08, 2021 at 03:43:42PM +0100, Robin Murphy wrote:
> On 2021-07-08 14:57, Kai-Heng Feng wrote:
> > On Thu, Jul 8, 2021 at 6:18 PM Robin Murphy <robin.murphy@arm.com> wrote:
> > > 
> > > On 2021-07-08 10:28, Joerg Roedel wrote:
> > > > On Thu, Jul 08, 2021 at 03:42:32PM +0800, Kai-Heng Feng wrote:
> > > > > @@ -344,6 +344,9 @@ static int iommu_init_device(struct device *dev)
> > > > > 
> > > > >               iommu = amd_iommu_rlookup_table[dev_data->devid];
> > > > >               dev_data->iommu_v2 = iommu->is_iommu_v2;
> > > > > +
> > > > > +            if (dev_data->iommu_v2)
> > > > > +                    swiotlb = 1;
> > > > 
> > > > This looks like the big hammer, as it will affect all other systems
> > > > where the AMD GPUs are in their own group.
> > > > 
> > > > What is needed here is an explicit check whether a non-iommu-v2 device
> > > > is direct-mapped because it shares a group with the GPU, and only enable
> > > > swiotlb in this case.
> > > 
> > > Right, it's basically about whether any DMA-limited device might at any
> > > time end up in an IOMMU_DOMAIN_IDENTITY domain. And given the
> > > possibility of device hotplug and the user being silly with the sysfs
> > > interface, I don't think we can categorically determine that at boot time.
> > > 
> > > Also note that Intel systems are likely to be similarly affected (in
> > > fact intel-iommu doesn't even have the iommu_default_passthough() check
> > > so it's probably even easier to blow up).
> > 
> > swiotlb is enabled by pci_swiotlb_detect_4gb() and intel-iommu doesn't
> > disable it.
> 
> Oh, right... I did say I found this dance hard to follow. Clearly I
> shouldn't have trusted what I thought I remembered from looking at it
> yesterday :)
> 
> Also not helped by the fact that it sets iommu_detected which *does* disable
> SWIOTLB, but only on IA-64.
> 
> > I wonder if we can take the same approach in amd-iommu?
> 
> Certainly if there's a precedent for leaving SWIOTLB enabled even if it
> *might* be redundant, that seems like the easiest option (it's what we do on
> arm64 too, but then we have system topologies where some devices may not be
> behind IOMMUs even when others are). More fun would be to try to bring it up
> at the first sign of IOMMU_DOMAIN_IDENTITY if it was disabled previously,
> but I don't have the highest hope of that being practical.

<scratches his head>
It is kind of silly to enable SWIOTLB which will just eat 64MB of memory
"just in case".

The SWIOTLB does have support to do late initialization (xen-pcifront
does that for example - so if you add devices that can't do 64-bit it
will allocate something like 4MB).

Would that be a better choice going forward - that is allocate this
under those conditions?
> 
> Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
