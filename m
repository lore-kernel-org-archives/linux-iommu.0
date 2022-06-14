Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D27BC433EF
	for <iommu@archiver.kernel.org>; Tue, 14 Jun 2022 01:44:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4539440A0F;
	Tue, 14 Jun 2022 01:44:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4cpge_3om__v; Tue, 14 Jun 2022 01:44:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 11CBF4053E;
	Tue, 14 Jun 2022 01:44:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8080C0039;
	Tue, 14 Jun 2022 01:44:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D767EC002D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 01:44:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BE6C74061C
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 01:44:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p2-DMOsOx1An for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 01:44:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D1F844053E
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 01:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655171068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R8tMWrimMGfLwBpAuu2lBsQ7zXDAkGHB6K2YkN+rto8=;
 b=O0+TXiaLeKwhnmfxSR5ab/10WgCUNmvk4c2qkC0o0JrJC+yH63EAfR4lqnYeUbFZkA+x09
 Uxwh9VPZfP/0HjBeNEpH4eIeREO4+Qw6TUhDISRVw43bp10RzukjLyUq+ECrQfEn3nfCU+
 2GADfYsX6N1r2DJ96Ne17qAsFDJ0eUs=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-Ue1O6evONjypmicVYKbfEg-1; Mon, 13 Jun 2022 21:44:27 -0400
X-MC-Unique: Ue1O6evONjypmicVYKbfEg-1
Received: by mail-il1-f198.google.com with SMTP id
 a2-20020a923302000000b002d1ad5053feso5667348ilf.17
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 18:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=R8tMWrimMGfLwBpAuu2lBsQ7zXDAkGHB6K2YkN+rto8=;
 b=hmQSsQFVCj9xMWSF21C1DvrNvGYEEElj2Bp9u6KtezQGQbBcAwxSjWK/Z5UJbmE8nY
 N/CTWnN2r7ll+xssRmKlWT+VCNBch3b2azjOce7WH2rwB4RFlAuO1ot9WPToK0EDuXWg
 YAHUHoyUzsMlodY1AFlddCp7MSDk+rer+VGgkhEtTxXPJReQJnrHGmnm3r1QWcSjVdHo
 +YgCIquVe3wdWi2+DwF9iA7m+O1MWrKtJMH7vfwVbd0/bDRqO35onkhDtE4FKLS6oaqZ
 hErNX23BdLoXNS8IvaL2hauG6Jsaqsg7cXQ4XS0XAwH0x7Pkn3LGpF5u+tiFSEHqb313
 VYXw==
X-Gm-Message-State: AJIora/avDsYGk9fl7DRkCMya+QdaUXI/d19Rk7Afi0A0JwZh2ASwHqI
 faG6pVHKeuwDuyBoERDQWsz3Nq2ZMiZ9HoOwIHaR4h2C/dGuyEoNCgjjXm8HuWJu/MxHgqfFAcE
 r3W99LsXH5adL0rBYpdSbDVpGfPJ6AA5ewi0QIQS6idpVhw==
X-Received: by 2002:a92:cd8e:0:b0:2d3:e757:8df0 with SMTP id
 r14-20020a92cd8e000000b002d3e7578df0mr1532715ilb.190.1655171066691; 
 Mon, 13 Jun 2022 18:44:26 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vtaqA/8b56sYGyTFEUt5xb3zJsIm6CNge5IWbpRTP/JBVTQtlBIseF/tRabKJOi7RdPJ50E8K5f9G5Up9+FLQ=
X-Received: by 2002:a92:cd8e:0:b0:2d3:e757:8df0 with SMTP id
 r14-20020a92cd8e000000b002d3e7578df0mr1532710ilb.190.1655171066465; Mon, 13
 Jun 2022 18:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220505194658.246121-1-steve.wahl@hpe.com>
 <20220512151309.330068-1-steve.wahl@hpe.com>
 <20220613205734.3x7i46bnsofzerr4@cantor>
 <673eb011-94f4-46b0-f1b4-24a02a269f4e@linux.intel.com>
In-Reply-To: <673eb011-94f4-46b0-f1b4-24a02a269f4e@linux.intel.com>
From: Jerry Snitselaar <jsnitsel@redhat.com>
Date: Mon, 13 Jun 2022 18:44:00 -0700
Message-ID: <CALzcddsXciFgKOLSkXxx4Rv_rwh21qe8hkyiEET280D8orP6Vw@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
To: Baolu Lu <baolu.lu@linux.intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnitsel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Dimitri Sivanich <sivanich@hpe.com>, Joerg Roedel <jroedel@suse.de>,
 Russ Anderson <russ.anderson@hpe.com>, Steve Wahl <steve.wahl@hpe.com>,
 Mike Travis <mike.travis@hpe.com>, David Woodhouse <dwmw2@infradead.org>,
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

On Mon, Jun 13, 2022 at 6:36 PM Baolu Lu <baolu.lu@linux.intel.com> wrote:
>
> On 2022/6/14 04:57, Jerry Snitselaar wrote:
> > On Thu, May 12, 2022 at 10:13:09AM -0500, Steve Wahl wrote:
> >> To support up to 64 sockets with 10 DMAR units each (640), make the
> >> value of DMAR_UNITS_SUPPORTED adjustable by a config variable,
> >> CONFIG_DMAR_UNITS_SUPPORTED, and make it's default 1024 when MAXSMP is
> >> set.
> >>
> >> If the available hardware exceeds DMAR_UNITS_SUPPORTED (previously set
> >> to MAX_IO_APICS, or 128), it causes these messages: "DMAR: Failed to
> >> allocate seq_id", "DMAR: Parse DMAR table failure.", and "x2apic: IRQ
> >> remapping doesn't support X2APIC mode x2apic disabled"; and the system
> >> fails to boot properly.
> >>
> >> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> >> ---
> >>
> >> Note that we could not find a reason for connecting
> >> DMAR_UNITS_SUPPORTED to MAX_IO_APICS as was done previously.  Perhaps
> >> it seemed like the two would continue to match on earlier processors.
> >> There doesn't appear to be kernel code that assumes that the value of
> >> one is related to the other.
> >>
> >> v2: Make this value a config option, rather than a fixed constant.  The default
> >> values should match previous configuration except in the MAXSMP case.  Keeping the
> >> value at a power of two was requested by Kevin Tian.
> >>
> >>   drivers/iommu/intel/Kconfig | 6 ++++++
> >>   include/linux/dmar.h        | 6 +-----
> >>   2 files changed, 7 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
> >> index 247d0f2d5fdf..fdbda77ac21e 100644
> >> --- a/drivers/iommu/intel/Kconfig
> >> +++ b/drivers/iommu/intel/Kconfig
> >> @@ -9,6 +9,12 @@ config DMAR_PERF
> >>   config DMAR_DEBUG
> >>      bool
> >>
> >> +config DMAR_UNITS_SUPPORTED
> >> +    int "Number of DMA Remapping Units supported"
> >
> > Also, should there be a "depends on (X86 || IA64)" here?
>
> Do you have any compilation errors or warnings?
>
> Best regards,
> baolu
>

I think it is probably harmless since it doesn't get used elsewhere,
but our tooling was complaining to me because DMAR_UNITS_SUPPORTED was
being autogenerated into the configs for the non-x86 architectures we
build (aarch64, s390x, ppcle64).
We have files corresponding to the config options that it looks at,
and I had one for x86 and not the others so it noticed the
discrepancy.


> >
> >> +    default 1024 if MAXSMP
> >> +    default 128  if X86_64
> >> +    default 64
> >> +
> >>   config INTEL_IOMMU
> >>      bool "Support for Intel IOMMU using DMA Remapping Devices"
> >>      depends on PCI_MSI && ACPI && (X86 || IA64)
> >> diff --git a/include/linux/dmar.h b/include/linux/dmar.h
> >> index 45e903d84733..0c03c1845c23 100644
> >> --- a/include/linux/dmar.h
> >> +++ b/include/linux/dmar.h
> >> @@ -18,11 +18,7 @@
> >>
> >>   struct acpi_dmar_header;
> >>
> >> -#ifdef      CONFIG_X86
> >> -# define    DMAR_UNITS_SUPPORTED    MAX_IO_APICS
> >> -#else
> >> -# define    DMAR_UNITS_SUPPORTED    64
> >> -#endif
> >> +#define     DMAR_UNITS_SUPPORTED    CONFIG_DMAR_UNITS_SUPPORTED
> >>
> >>   /* DMAR Flags */
> >>   #define DMAR_INTR_REMAP            0x1
> >> --
> >> 2.26.2
> >>
> >
>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
