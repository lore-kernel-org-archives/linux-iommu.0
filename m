Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 488B5C43334
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 02:51:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C5C8940C75;
	Thu, 23 Jun 2022 02:51:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C5C8940C75
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PwmHhU6Y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JlkGLiGyheFY; Thu, 23 Jun 2022 02:51:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 56AF940223;
	Thu, 23 Jun 2022 02:51:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 56AF940223
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2DDAEC0039;
	Thu, 23 Jun 2022 02:51:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E84B7C002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 02:51:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BBA6A845CB
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 02:51:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BBA6A845CB
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PwmHhU6Y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GjJ6fhHfENmq for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 02:51:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CCBAC845C5
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CCBAC845C5
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 02:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655952690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WfM23hVIuknmtgpETmG7nEzJ3B1ck7bglKwnlvkt/5c=;
 b=PwmHhU6YPeE+XaFuhO+Exhha2PVoVjZOhJjOe63JZYeG7PlQJkv+4zTawOL3AbOgE619FX
 qlyH1YwJAmfmGndVp850+FoWGj1/ucJanCjE9vpdkWyfFxWPti4Kgf+TyoBx3ybfzywnu2
 I+tklA7M3SiC1Rmy17D16BXgWvbO7qk=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-Fht4BaY7NOy1K3a3p1KsDg-1; Wed, 22 Jun 2022 22:51:28 -0400
X-MC-Unique: Fht4BaY7NOy1K3a3p1KsDg-1
Received: by mail-pf1-f200.google.com with SMTP id
 d129-20020a621d87000000b005228d4cbcc4so7513501pfd.12
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 19:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WfM23hVIuknmtgpETmG7nEzJ3B1ck7bglKwnlvkt/5c=;
 b=Wr8FMLktVsinnBoYI6VIUA/jZBdr6Gtmzhuap/nSeFZpIYn8wh35lib8yRciPLY//S
 TubiF4GKcIer5ZHGSG4kKml4TXVffuQWPMY7Oxcn56qV8M02neczfOZEfZo5LsmU3Q5X
 SLaHTh767VPtJ3tBNqEpvYtIKE5fDp27Aexc76itXLMNddUFG5jr+GMv1q9dSgOv3okT
 dlt6RAuUYC5dbHUg128f2acOYLoYut0uxSzmGeYFQgQwDmswCPiKkNPux6owpnh9Iqmb
 uBoqsAm1SRbV/f2X6PuYEMrmwnoqTb2oW2MYkldkZsWF61E83BnGP19A0HGKNqdukpP8
 yPMg==
X-Gm-Message-State: AJIora/23Je5g87RRFUuxHkJuK/eSifCqp60tWEOo7tBfrKm83YpSAK/
 q6phxUBnCqGyW4axcKXLKq+9xooumRBkhqR0DFOFRGGA+YtBjPwHLaW1HS73A0AB/odB8AZ6Efx
 C2Ds6LlpfiHYnRobngSDD22houTB/Jg==
X-Received: by 2002:a17:903:1d2:b0:168:e3b9:e62b with SMTP id
 e18-20020a17090301d200b00168e3b9e62bmr37268992plh.115.1655952687832; 
 Wed, 22 Jun 2022 19:51:27 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uRio08blZno251hjFhWCfKd6yX/kcxS5XW8PD3X5r0HHgawbWNFKF0kb39zCJP4QRS6cNh2A==
X-Received: by 2002:a17:903:1d2:b0:168:e3b9:e62b with SMTP id
 e18-20020a17090301d200b00168e3b9e62bmr37268973plh.115.1655952687565; 
 Wed, 22 Jun 2022 19:51:27 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
 by smtp.gmail.com with ESMTPSA id
 d19-20020a631d53000000b0040d1eb90d67sm2531149pgm.93.2022.06.22.19.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jun 2022 19:51:27 -0700 (PDT)
Date: Wed, 22 Jun 2022 19:51:26 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v3] iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
Message-ID: <20220623025126.ld45k72c2okodvvk@cantor>
References: <9d6177ac-802f-eb11-4307-b0e49d8126b5@linux.intel.com>
 <20220615183650.32075-1-steve.wahl@hpe.com>
 <96984350-3a04-812a-60f1-a09138014fac@linux.intel.com>
 <CALzcdduhpOebY18hiOpMcXLcH83bY_u4fZT09pBcoz2ObqXnGg@mail.gmail.com>
 <f0e4adc8-5d67-b76a-d0f1-2df83bd69a82@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <f0e4adc8-5d67-b76a-d0f1-2df83bd69a82@linux.intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnitsel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Dimitri Sivanich <sivanich@hpe.com>, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <jroedel@suse.de>, Russ Anderson <russ.anderson@hpe.com>,
 Steve Wahl <steve.wahl@hpe.com>, Mike Travis <mike.travis@hpe.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Kyung Min Park <kyung.min.park@intel.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>, Will Deacon <will@kernel.org>
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

On Thu, Jun 23, 2022 at 10:29:35AM +0800, Baolu Lu wrote:
> On 2022/6/22 23:05, Jerry Snitselaar wrote:
> > On Wed, Jun 22, 2022 at 7:52 AM Baolu Lu<baolu.lu@linux.intel.com>  wrote:
> > > On 2022/6/16 02:36, Steve Wahl wrote:
> > > > To support up to 64 sockets with 10 DMAR units each (640), make the
> > > > value of DMAR_UNITS_SUPPORTED adjustable by a config variable,
> > > > CONFIG_DMAR_UNITS_SUPPORTED, and make it's default 1024 when MAXSMP is
> > > > set.
> > > > 
> > > > If the available hardware exceeds DMAR_UNITS_SUPPORTED (previously set
> > > > to MAX_IO_APICS, or 128), it causes these messages: "DMAR: Failed to
> > > > allocate seq_id", "DMAR: Parse DMAR table failure.", and "x2apic: IRQ
> > > > remapping doesn't support X2APIC mode x2apic disabled"; and the system
> > > > fails to boot properly.
> > > > 
> > > > Signed-off-by: Steve Wahl<steve.wahl@hpe.com>
> > > > Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> > > > ---
> > > > 
> > > > Note that we could not find a reason for connecting
> > > > DMAR_UNITS_SUPPORTED to MAX_IO_APICS as was done previously.  Perhaps
> > > > it seemed like the two would continue to match on earlier processors.
> > > > There doesn't appear to be kernel code that assumes that the value of
> > > > one is related to the other.
> > > > 
> > > > v2: Make this value a config option, rather than a fixed constant.  The default
> > > > values should match previous configuration except in the MAXSMP case.  Keeping the
> > > > value at a power of two was requested by Kevin Tian.
> > > > 
> > > > v3: Make the config option dependent upon DMAR_TABLE, as it is not used without this.
> > > > 
> > > >    drivers/iommu/intel/Kconfig | 7 +++++++
> > > >    include/linux/dmar.h        | 6 +-----
> > > >    2 files changed, 8 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
> > > > index 39a06d245f12..07aaebcb581d 100644
> > > > --- a/drivers/iommu/intel/Kconfig
> > > > +++ b/drivers/iommu/intel/Kconfig
> > > > @@ -9,6 +9,13 @@ config DMAR_PERF
> > > >    config DMAR_DEBUG
> > > >        bool
> > > > 
> > > > +config DMAR_UNITS_SUPPORTED
> > > > +     int "Number of DMA Remapping Units supported"
> > > > +     depends on DMAR_TABLE
> > > > +     default 1024 if MAXSMP
> > > > +     default 128  if X86_64
> > > > +     default 64
> > > With this patch applied, the IOMMU configuration looks like:
> > > 
> > > [*]   AMD IOMMU support
> > > <M>     AMD IOMMU Version 2 driver
> > > [*]     Enable AMD IOMMU internals in DebugFS
> > > (1024) Number of DMA Remapping Units supported   <<<< NEW
> > > [*]   Support for Intel IOMMU using DMA Remapping Devices
> > > [*]     Export Intel IOMMU internals in Debugfs
> > > [*]     Support for Shared Virtual Memory with Intel IOMMU
> > > [*]     Enable Intel DMA Remapping Devices by default
> > > [*]     Enable Intel IOMMU scalable mode by default
> > > [*]   Support for Interrupt Remapping
> > > [*]   OMAP IOMMU Support
> > > [*]     Export OMAP IOMMU internals in DebugFS
> > > [*]   Rockchip IOMMU Support
> > > 
> > > The NEW item looks confusing. It looks to be a generic configurable
> > > value though it's actually Intel DMAR specific. Any thoughts?
> > > 
> > > Best regards,
> > > baolu
> > > 
> > Would moving it under INTEL_IOMMU at least have it show up below
> > "Support for Intel IOMMU using DMA Remapping Devices"? I'm not sure it
> > can be better than that, because IRQ_REMAP selects DMAR_TABLE, so we
> > can't stick it in the if INTEL_IOMMU section.
> 
> It's more reasonable to move it under INTEL_IOMMU, but the trouble is
> that this also stands even if INTEL_IOMMU is not configured.

My thought only was with it after the 'config INTEL_IOMMU' block and before 'if INTEL_IOMMU'
it would show up like:

[*]   Support for Intel IOMMU using DMA Remapping Devices
(1024) Number of DMA Remapping Units supported   <<<< NEW

> 
> The real problem here is that the iommu sequence ID overflows if
> DMAR_UNITS_SUPPORTED is not big enough. This is purely a software
> implementation issue, I am not sure whether user opt-in when building a
> kernel package could help a lot here.
> 

Is this something that could be figured out when parsing the dmar
table? It looks like currently iommu_refcnt[], iommu_did[], and
dmar_seq_ids[] depend on it.

Regards,
Jerry


> If we can't find a better way, can we just step back?
> 
> Best regards,
> baolu

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
