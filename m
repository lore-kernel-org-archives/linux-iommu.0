Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB742CCA482
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 15:05:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 50C8E83ED0;
	Wed, 22 Jun 2022 15:05:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 50C8E83ED0
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H0cdfvo8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PT3JRXYhutb6; Wed, 22 Jun 2022 15:05:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 52C1583EC3;
	Wed, 22 Jun 2022 15:05:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 52C1583EC3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 268CFC0032;
	Wed, 22 Jun 2022 15:05:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 838F2C002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 15:05:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4F7B2409E9
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 15:05:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4F7B2409E9
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=H0cdfvo8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RYZYcvCWRiYY for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 15:05:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EE69C40012
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EE69C40012
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 15:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655910340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jndzfVF++R7TsK3TV+yk+0zpm8yMa0Qnb1v8H83vdVo=;
 b=H0cdfvo8huFhRnoSl9tTIo+ev6YZEsVj3/QUMxHLNP+Mo/YHyIPPpuZoKVL7nOgS+7ygZL
 iGjPU238ZJuCxvtUEr3UIMeDMry1T/rHfJI44B4FrguG6hu36NPSs0X+HtEzsYm2Q4Z8nr
 5Rixfm9t1UD+nebvl2v106rNOtvgmaA=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-156-1ll7kpElNjqsgvvhJg1XIQ-1; Wed, 22 Jun 2022 11:05:39 -0400
X-MC-Unique: 1ll7kpElNjqsgvvhJg1XIQ-1
Received: by mail-vk1-f200.google.com with SMTP id
 d66-20020a1fcd45000000b0036c2b72f311so1312247vkg.23
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 08:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jndzfVF++R7TsK3TV+yk+0zpm8yMa0Qnb1v8H83vdVo=;
 b=F7UZXrgNMa05U199Jx6ydF4dSSSYLDs7emcEQoUqDWu4LBs16q2VSOBpwWdfvR7r/m
 b9YBggEAPpuEJ7GeyZUkAp/0kKA+q3TPjPz+InXsbzrDFjnHpeb2c6MPxX9UbSlLqDdP
 zEDnxAFxFyFA8FfLPt0TMy7Y5bt7QHZPj5Uw5E+iYwwDeiCRI5U0i49ZYfKlUwzv5AS6
 Ada8seNjKALE4aSIWbX98lHWARvQNUdVmWhD+Ly6gUBmelDla2FQ0idk25cIq/kReqic
 w+v8O5JncmcQlMkB79wpW7Je9i7JtWKSF6yAOnn0zCWX2as1wd6A9Tc1w9lW9LN0UFpm
 Pc3w==
X-Gm-Message-State: AJIora+tbU46kYmltlYJ13mRYXB3uT3opz89782CW+83eB03WdTkb9La
 92FADBc/qhiJYaumpFDCqAJsWSFTra0huZa9JsHox9BMMRPFyXM5xay277EGl5cyeMif757dD/v
 ckx+HSjc2lOCpYIOURqHwy2IFgl02eZ10JFHxiK7sOkU/mw==
X-Received: by 2002:a67:ba09:0:b0:354:5d45:67ed with SMTP id
 l9-20020a67ba09000000b003545d4567edmr1745716vsn.18.1655910338981; 
 Wed, 22 Jun 2022 08:05:38 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uCzYxtP8zvgG7hdrhhklfXqLiR9sESzuYsH1TCnGyeEZJ57pWTrteDT6pEJcJyySZ/ZdON06zXfSc9hwQVjtU=
X-Received: by 2002:a67:ba09:0:b0:354:5d45:67ed with SMTP id
 l9-20020a67ba09000000b003545d4567edmr1745672vsn.18.1655910338758; Wed, 22 Jun
 2022 08:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <9d6177ac-802f-eb11-4307-b0e49d8126b5@linux.intel.com>
 <20220615183650.32075-1-steve.wahl@hpe.com>
 <96984350-3a04-812a-60f1-a09138014fac@linux.intel.com>
In-Reply-To: <96984350-3a04-812a-60f1-a09138014fac@linux.intel.com>
From: Jerry Snitselaar <jsnitsel@redhat.com>
Date: Wed, 22 Jun 2022 08:05:12 -0700
Message-ID: <CALzcdduhpOebY18hiOpMcXLcH83bY_u4fZT09pBcoz2ObqXnGg@mail.gmail.com>
Subject: Re: [PATCH v3] iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
To: Baolu Lu <baolu.lu@linux.intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnitsel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

On Wed, Jun 22, 2022 at 7:52 AM Baolu Lu <baolu.lu@linux.intel.com> wrote:
>
> On 2022/6/16 02:36, Steve Wahl wrote:
> > To support up to 64 sockets with 10 DMAR units each (640), make the
> > value of DMAR_UNITS_SUPPORTED adjustable by a config variable,
> > CONFIG_DMAR_UNITS_SUPPORTED, and make it's default 1024 when MAXSMP is
> > set.
> >
> > If the available hardware exceeds DMAR_UNITS_SUPPORTED (previously set
> > to MAX_IO_APICS, or 128), it causes these messages: "DMAR: Failed to
> > allocate seq_id", "DMAR: Parse DMAR table failure.", and "x2apic: IRQ
> > remapping doesn't support X2APIC mode x2apic disabled"; and the system
> > fails to boot properly.
> >
> > Signed-off-by: Steve Wahl<steve.wahl@hpe.com>
> > Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> > ---
> >
> > Note that we could not find a reason for connecting
> > DMAR_UNITS_SUPPORTED to MAX_IO_APICS as was done previously.  Perhaps
> > it seemed like the two would continue to match on earlier processors.
> > There doesn't appear to be kernel code that assumes that the value of
> > one is related to the other.
> >
> > v2: Make this value a config option, rather than a fixed constant.  The default
> > values should match previous configuration except in the MAXSMP case.  Keeping the
> > value at a power of two was requested by Kevin Tian.
> >
> > v3: Make the config option dependent upon DMAR_TABLE, as it is not used without this.
> >
> >   drivers/iommu/intel/Kconfig | 7 +++++++
> >   include/linux/dmar.h        | 6 +-----
> >   2 files changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
> > index 39a06d245f12..07aaebcb581d 100644
> > --- a/drivers/iommu/intel/Kconfig
> > +++ b/drivers/iommu/intel/Kconfig
> > @@ -9,6 +9,13 @@ config DMAR_PERF
> >   config DMAR_DEBUG
> >       bool
> >
> > +config DMAR_UNITS_SUPPORTED
> > +     int "Number of DMA Remapping Units supported"
> > +     depends on DMAR_TABLE
> > +     default 1024 if MAXSMP
> > +     default 128  if X86_64
> > +     default 64
>
> With this patch applied, the IOMMU configuration looks like:
>
> [*]   AMD IOMMU support
> <M>     AMD IOMMU Version 2 driver
> [*]     Enable AMD IOMMU internals in DebugFS
> (1024) Number of DMA Remapping Units supported   <<<< NEW
> [*]   Support for Intel IOMMU using DMA Remapping Devices
> [*]     Export Intel IOMMU internals in Debugfs
> [*]     Support for Shared Virtual Memory with Intel IOMMU
> [*]     Enable Intel DMA Remapping Devices by default
> [*]     Enable Intel IOMMU scalable mode by default
> [*]   Support for Interrupt Remapping
> [*]   OMAP IOMMU Support
> [*]     Export OMAP IOMMU internals in DebugFS
> [*]   Rockchip IOMMU Support
>
> The NEW item looks confusing. It looks to be a generic configurable
> value though it's actually Intel DMAR specific. Any thoughts?
>
> Best regards,
> baolu
>

Would moving it under INTEL_IOMMU at least have it show up below
"Support for Intel IOMMU using DMA Remapping Devices"? I'm not sure it
can be better than that, because IRQ_REMAP selects DMAR_TABLE, so we
can't stick it in the if INTEL_IOMMU section.

Regards,
Jerry

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
