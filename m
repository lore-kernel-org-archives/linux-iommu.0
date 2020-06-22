Return-Path: <SRS0=gLCG=AD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B6DC433DF
	for <iommu@archiver.kernel.org>; Mon, 22 Jun 2020 23:02:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00E7B2075A
	for <iommu@archiver.kernel.org>; Mon, 22 Jun 2020 23:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="CDLwChJW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00E7B2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id AF0B389429;
	Mon, 22 Jun 2020 23:02:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6YaC75r4ow6T; Mon, 22 Jun 2020 23:02:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 03EFC893EA;
	Mon, 22 Jun 2020 23:02:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD043C088F;
	Mon, 22 Jun 2020 23:02:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19627C016F
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 23:02:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 095B486193
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 23:02:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uKNKJ9Vv2tO0 for <iommu@lists.linux-foundation.org>;
 Mon, 22 Jun 2020 23:02:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com
 [209.85.167.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 12C8785BAE
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 23:02:14 +0000 (UTC)
Received: by mail-lf1-f65.google.com with SMTP id u25so10632268lfm.1
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 16:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ecq4FS9wELzuVh2aNsJmKpLPD9PbAHLuJOkUzY8Xxes=;
 b=CDLwChJW595HajdiJojE/+eW1r1r4swlZKiMJEBB/xgJUPsRe7eatKhRtaAggFj9bD
 7SzxCuD4enZovjYeo6u5UKDTYtZFs1omXlP2i+IVjYWh2nOQGvAi5LMciy5upiypKr7f
 6bDx5tB2jaerpTT/GcWq7hUccgf2L0SGDaRwyd7yQUj89bOAQNLhWjsjc5Qjs342fZc/
 bIgLxa6HcvwPEPhx8OlcMZ5e1H7GcWzrjte7ozSnnSwPsbx68QHWcfWv8QUnQ60N7/iJ
 8KFigh54NcYqABzqIEhNuYZAOZowoa/IpyLCdxifXX1tDDo3gS8+ZXm5JFFXy74iFeV/
 v/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ecq4FS9wELzuVh2aNsJmKpLPD9PbAHLuJOkUzY8Xxes=;
 b=cDSduzl467aRM3/jpinfqLV5ZhifU9k3TQq2W0cYurdUrAHPYNpc8+eHmVFtto3pJ9
 iHdNG6sGGQtcb24eQwSbeGbRj76/XPs6+pkICada0riDZ6PShcB4d+qiK4PeErgKb+si
 2Doga5CxqCj13Ep+5bJF/cTex7ocP01NKo2eRVmGg3nPn8fZYYTzaeyEiJrC/uoqKIj7
 VL9jDKgov1ieEJPqo/wRiY26gm5jlYGEAVqV4l4R0o+Y+01dPejDLp3MqEW8QQLN4SY3
 wYI8y/gII76iEaL0xKuHX1vP4stfXxLd1/mSitQZx55ICOJImUC6Hs5gO115Ga6s42va
 p+Zw==
X-Gm-Message-State: AOAM531dBNCH05eFTIAkU+RtHjgPJGYGjwNcqgZ9QJZG6YJyv8nkGA5b
 SOpslfLRAElIXKNqsDIACDZ56bxtd3iJvSV38NbvMg==
X-Google-Smtp-Source: ABdhPJzpXmJeWyudmGnFcSJwgw8D3FpyMLH8rnnQyE9NCv3nyMOzGL3CkYp5ze+ga7o74BuYJeUW/t+chDaZtbSGJBY=
X-Received: by 2002:ac2:5467:: with SMTP id e7mr10346942lfn.122.1592866931554; 
 Mon, 22 Jun 2020 16:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200616011742.138975-1-rajatja@google.com>
 <20200616011742.138975-3-rajatja@google.com>
 <20200619161009.GH42799@otc-nc-03>
In-Reply-To: <20200619161009.GH42799@otc-nc-03>
Date: Mon, 22 Jun 2020 16:01:34 -0700
Message-ID: <CACK8Z6FZ560vfMYH8idaea31_9dq4Vvo7LiMASnxZKZJtX89wg@mail.gmail.com>
Subject: Re: [PATCH 3/4] pci: acs: Enable PCI_ACS_TB for
 untrusted/external-facing devices
To: "Raj, Ashok" <ashok.raj@intel.com>
Cc: Todd Broch <tbroch@google.com>, linux-pci <linux-pci@vger.kernel.org>,
 "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
 Diego Rivas <diegorivas@google.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Furquan Shaikh <furquan@google.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Christian Kellner <christian@kellner.me>,
 Mattias Nissler <mnissler@google.com>, Jesse Barnes <jsbarnes@google.com>,
 Len Brown <lenb@kernel.org>, Rajat Jain <rajatxjain@gmail.com>,
 Prashant Malani <pmalani@google.com>, Aaron Durbin <adurbin@google.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Bernie Keany <bernie.keany@intel.com>, Duncan Laurie <dlaurie@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Oliver O'Halloran <oohall@gmail.com>,
 Benson Leung <bleung@google.com>, David Woodhouse <dwmw2@infradead.org>,
 Alex Levin <levinale@google.com>
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
From: Rajat Jain via iommu <iommu@lists.linux-foundation.org>
Reply-To: Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Ashok,

On Fri, Jun 19, 2020 at 9:10 AM Raj, Ashok <ashok.raj@intel.com> wrote:
>
> Hi Rajat
>
>
> On Mon, Jun 15, 2020 at 06:17:41PM -0700, Rajat Jain wrote:
> > When enabling ACS, currently the bit "translation blocking" was
> > not getting changed at all. Set it to disable translation blocking
>
> Maybe you meant "enable translation blocking" ?

Oops, yes.

>
> Keep the commit log simple:
>
> When enabling ACS, enable translation blocking for external facing ports
> and untrusted devices.

Ack. Will change in the next iteration (currently waiting to see if
there are any more comments).

Thanks & Regards,

Rajat

>
> > too for all external facing or untrusted devices. This is OK
> > because ATS is only allowed on internal devces.
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > ---
> >  drivers/pci/pci.c    |  4 ++++
> >  drivers/pci/quirks.c | 11 +++++++++++
> >  2 files changed, 15 insertions(+)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index d2ff987585855..79853b52658a2 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -3330,6 +3330,10 @@ static void pci_std_enable_acs(struct pci_dev *dev)
> >       /* Upstream Forwarding */
> >       ctrl |= (cap & PCI_ACS_UF);
> >
> > +     if (dev->external_facing || dev->untrusted)
> > +             /* Translation Blocking */
> > +             ctrl |= (cap & PCI_ACS_TB);
> > +
> >       pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
> >  }
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index b341628e47527..6294adeac4049 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -4934,6 +4934,13 @@ static void pci_quirk_enable_intel_rp_mpc_acs(struct pci_dev *dev)
> >       }
> >  }
> >
> > +/*
> > + * Currently this quirk does the equivalent of
> > + * PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_SV
> > + *
> > + * Currently missing, it also needs to do equivalent of PCI_ACS_TB,
> > + * if dev->external_facing || dev->untrusted
> > + */
> >  static int pci_quirk_enable_intel_pch_acs(struct pci_dev *dev)
> >  {
> >       if (!pci_quirk_intel_pch_acs_match(dev))
> > @@ -4973,6 +4980,10 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
> >       ctrl |= (cap & PCI_ACS_CR);
> >       ctrl |= (cap & PCI_ACS_UF);
> >
> > +     if (dev->external_facing || dev->untrusted)
> > +             /* Translation Blocking */
> > +             ctrl |= (cap & PCI_ACS_TB);
> > +
> >       pci_write_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, ctrl);
> >
> >       pci_info(dev, "Intel SPT PCH root port ACS workaround enabled\n");
> > --
> > 2.27.0.290.gba653c62da-goog
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
