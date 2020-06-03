Return-Path: <SRS0=U3VV=7Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CE1C433DF
	for <iommu@archiver.kernel.org>; Wed,  3 Jun 2020 00:32:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11E9520738
	for <iommu@archiver.kernel.org>; Wed,  3 Jun 2020 00:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="a2C7Mgmf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11E9520738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7D0A723018;
	Wed,  3 Jun 2020 00:32:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UCyI4TbMUcoZ; Wed,  3 Jun 2020 00:32:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id EBF8620797;
	Wed,  3 Jun 2020 00:32:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9770C0865;
	Wed,  3 Jun 2020 00:32:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7B1DC016E
 for <iommu@lists.linux-foundation.org>; Wed,  3 Jun 2020 00:32:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C63F48880C
 for <iommu@lists.linux-foundation.org>; Wed,  3 Jun 2020 00:32:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1VtI9XYXf68z for <iommu@lists.linux-foundation.org>;
 Wed,  3 Jun 2020 00:32:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D27B987918
 for <iommu@lists.linux-foundation.org>; Wed,  3 Jun 2020 00:32:39 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id h185so365604pfg.2
 for <iommu@lists.linux-foundation.org>; Tue, 02 Jun 2020 17:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Qnzjt+g4cB//ahJdxLx9hz0hNZU/fqEnBmDtd0LYOjI=;
 b=a2C7MgmflNZhuX60tQc+uDBp8E6Awdh6dSwcT+NDEXWcaHr/WWC05JVeSUc7C7RsLJ
 hXQGv1iFTHu42sDAEMWcfgy1fqDYWGp+Feyl8E6t4/q7PBCVzhoeDOKBZaQDvmIkIbY5
 RwlHH0xf8NGNR1/oPvBwUt5llOgKsYTUrBFfWF4ZY2mFdyFM/i3fHCbJ2+GrJLVnMzKh
 wj+93IGgiwqCbuhdFulNMhR8rPmYpXJdPSH9YEOVrLqivLPmyO9PU18fdei+UcJQAT7h
 QBZyjY06AmQ1zHUTVToguV8ZZP+7/LF3YiCKKBP/+vkQ8HElOFTLtkHJBTTvTNH5H/zO
 e3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Qnzjt+g4cB//ahJdxLx9hz0hNZU/fqEnBmDtd0LYOjI=;
 b=oTgljpApf8eBhzFhMG8bElRCb0FkIPu6252J9lrcTcvYTFHyQtp2BJmCj8btrt5/o7
 6mK7YJlRwrXmq0NtBn+1Pbpt2rjNpBX8XgM4bffuLw51ayYKFR2ZyPdwT7t7R/efU/ap
 b0dgRsUEJ+YeUnWTcEnGEDtFFQic4E5TUbDNrtlNkAwi/7bGA+tYv1ZeDnqAGIvw07Ah
 OANqphDV1KVUxe/oy+yBGRXCS2l2ZTL5CbBAFfRM887D0ivnBb6F74RifQqtZdFDTWZR
 rCYli7U/wAMPVDXaxnjhIZIX9/IOf5QwXF+Iit4aXQS/FZnk0js7OQpyBqfjAQAxw25m
 QJuA==
X-Gm-Message-State: AOAM530v5A7we8PrHEAStD3/rGXe6rNK0K7iB/LQjuZMNkLSI/BfFqDY
 cE18441efytLqwDHxzV2MO2uTw==
X-Google-Smtp-Source: ABdhPJzxg/0H0QxEm2ZZRar4GgxFDicXkNmogMqShiKQwEu039y2YbeEh9yGYV9WF3rK2mwrh7WFwQ==
X-Received: by 2002:a63:1a01:: with SMTP id a1mr24703646pga.87.1591144358699; 
 Tue, 02 Jun 2020 17:32:38 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:476b:691:abc3:38db])
 by smtp.gmail.com with ESMTPSA id y10sm138263pgi.54.2020.06.02.17.32.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 17:32:37 -0700 (PDT)
Date: Tue, 2 Jun 2020 17:32:32 -0700
To: Rajat Jain <rajatxjain@gmail.com>
Subject: Re: [PATCH v3] iommu/vt-d: Don't apply gfx quirks to untrusted devices
Message-ID: <20200603003232.GC109930@google.com>
References: <20200602232602.156049-1-rajatja@google.com>
 <20200602234912.GB109930@google.com>
 <CAA93t1r9Kg0OFwoOhNUKYeSbZrFgu5k_eexer34msjsLBNohcg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAA93t1r9Kg0OFwoOhNUKYeSbZrFgu5k_eexer34msjsLBNohcg@mail.gmail.com>
Cc: tbroch@google.com, Ashok Raj <ashok.raj@intel.com>, zsm@google.com,
 levinale@google.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 lalithambika.krishnakumar@intel.com, iommu@lists.linux-foundation.org,
 mnissler@google.com, bleung@google.com, Rajat Jain <rajatja@google.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Mika Westerberg <mika.westerberg@intel.com>
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
From: Prashant Malani via iommu <iommu@lists.linux-foundation.org>
Reply-To: Prashant Malani <pmalani@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

(Trimming text)

On Wed, Jun 03, 2020 at 12:23:48AM +0000, Rajat Jain wrote:
> On Tue, Jun 2, 2020 at 4:49 PM Prashant Malani <pmalani@google.com> wrote:
> >
> > Hi Rajat,
> 
> Hi Prashant, thanks for taking a look.
> 
> >
> > On Tue, Jun 02, 2020 at 04:26:02PM -0700, Rajat Jain wrote:
> > > +static bool risky_device(struct pci_dev *pdev)
> > > +{
> > > +     if (pdev->untrusted) {
> > > +             pci_warn(pdev,
> > > +                      "Skipping IOMMU quirk for dev (%04X:%04X) on untrusted"
> > > +                      " PCI link. Please check with your BIOS/Platform"
> > > +                      " vendor about this\n", pdev->vendor, pdev->device);
> > > +             return true;
> > > +     }
> > > +     return false;
> > minor suggestion: Perhaps you could use a guard clause here? It would save you
> > a level of indentation, and possibly allow better string splitting
> > (e.g keeping "untrusted PCI" together). So something like:
> >
> > if (!pdev->untrusted)
> >         return false;
> 
> I personally have found double negation expressions always confusing,
> even if negation is part of the variable. (For e.g. I have found I
> need to be always stop and convince myself that:
> 
> "if (!pdev->untrusted)"
>     <do something>
> 
> conceptually implies
> 
> "if (pdev->trusted)".
>     <do something>
> 
> So I tend to keep negations to minimum. In this case, it doesn't buy
> us much either, so I'd prefer to keep it the same unless there are
> more opinions on this. OTOH I don't mind changing it too if you feel
> strongly about this.

Ordinarily, I'd agree with you regarding double-negatives.

However, in this case the condition phrasing is so brief ("not untrusted") that I'd
argue the indentation savings outweigh possible interpretation issues.

That said, I don't have a strong opinion here, so will defer to the maintainer's preference.

Best,

> 
> Thanks,
> 
> Rajat
> 
> 
> >
> > pci_warn(...);
> >
> > I also hear the column limit warning is now for 100 chars [1], though
> > I'm not sure how it's being handled in this file.
> >
> > Best regards,
> >
> > -Prashant
> >
> > [1]:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/Documentation/process/coding-style.rst?id=bdc48fa11e46f867ea4d75fa59ee87a7f48be144
> >
> > > +}
> > > +
> > >  const struct iommu_ops intel_iommu_ops = {
> > >       .capable                = intel_iommu_capable,
> > >       .domain_alloc           = intel_iommu_domain_alloc,
> > > @@ -6214,6 +6231,9 @@ const struct iommu_ops intel_iommu_ops = {
> > >
> > >  static void quirk_iommu_igfx(struct pci_dev *dev)
> > >  {
> > > +     if (risky_device(dev))
> > > +             return;
> > > +
> > >       pci_info(dev, "Disabling IOMMU for graphics on this chipset\n");
> > >       dmar_map_gfx = 0;
> > >  }
> > > @@ -6255,6 +6275,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x163D, quirk_iommu_igfx);
> > >
> > >  static void quirk_iommu_rwbf(struct pci_dev *dev)
> > >  {
> > > +     if (risky_device(dev))
> > > +             return;
> > > +
> > >       /*
> > >        * Mobile 4 Series Chipset neglects to set RWBF capability,
> > >        * but needs it. Same seems to hold for the desktop versions.
> > > @@ -6285,6 +6308,9 @@ static void quirk_calpella_no_shadow_gtt(struct pci_dev *dev)
> > >  {
> > >       unsigned short ggc;
> > >
> > > +     if (risky_device(dev))
> > > +             return;
> > > +
> > >       if (pci_read_config_word(dev, GGC, &ggc))
> > >               return;
> > >
> > > @@ -6318,6 +6344,12 @@ static void __init check_tylersburg_isoch(void)
> > >       pdev = pci_get_device(PCI_VENDOR_ID_INTEL, 0x3a3e, NULL);
> > >       if (!pdev)
> > >               return;
> > > +
> > > +     if (risky_device(pdev)) {
> > > +             pci_dev_put(pdev);
> > > +             return;
> > > +     }
> > > +
> > >       pci_dev_put(pdev);
> > >
> > >       /* System Management Registers. Might be hidden, in which case
> > > @@ -6327,6 +6359,11 @@ static void __init check_tylersburg_isoch(void)
> > >       if (!pdev)
> > >               return;
> > >
> > > +     if (risky_device(pdev)) {
> > > +             pci_dev_put(pdev);
> > > +             return;
> > > +     }
> > > +
> > >       if (pci_read_config_dword(pdev, 0x188, &vtisochctrl)) {
> > >               pci_dev_put(pdev);
> > >               return;
> > > --
> > > 2.27.0.rc2.251.g90737beb825-goog
> > >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
