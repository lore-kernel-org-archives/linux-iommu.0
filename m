Return-Path: <SRS0=S+y3=AR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F255C433E0
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 23:13:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB3D4206E9
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 23:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="l+Kck4QL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB3D4206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8F914894D3;
	Mon,  6 Jul 2020 23:13:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tgJZmhco5gWk; Mon,  6 Jul 2020 23:13:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id DED8989497;
	Mon,  6 Jul 2020 23:13:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C157DC0893;
	Mon,  6 Jul 2020 23:13:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7EB72C016F
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 23:13:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6D0CA87814
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 23:13:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uUGUknniF28M for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jul 2020 23:13:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
 [209.85.208.193])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 86C7787808
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 23:13:10 +0000 (UTC)
Received: by mail-lj1-f193.google.com with SMTP id d17so32927386ljl.3
 for <iommu@lists.linux-foundation.org>; Mon, 06 Jul 2020 16:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SR19WDvOm+Jc/grBUK3DcAG61rsTa4WPLrkARxPZOAg=;
 b=l+Kck4QLh/GjDatFbN1XEqM3Tz6lakJhs3E9J1XdsBwYLSppoM1PHrBrrsnb5/v4tJ
 XrCDEAlLqxil2gTTmgd650zhncuLDENlO/0gQ/Y0lot0ofj1l6k0We1vcLPui5Eaq1nf
 iZF6FzBFsxbC5H78jo0pWHQ53RAsKmA0Ieq6QuSmcaxBJaXPxDUXAymnSm1l5bXyziUN
 E+k2/BSJGZ4dS3BsQdULyP/OQmSK4uXZTgrF/GtPuB6y8ObR8Hmqz1K86ft5+LQbtoy6
 szM/3+oamdz2utop5yBaSYUpEFUNKElOpbs79VyOw5ciwTV0x4aUw9N4u7XXeXRT0hYa
 w8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SR19WDvOm+Jc/grBUK3DcAG61rsTa4WPLrkARxPZOAg=;
 b=GGrW+4pDPVB7YOmAdubqzGlFqCWf+5cXycWoio72480GnMMzdwdQZeRHIe48eVVrMx
 0QMuA3EAcpfjBHoOASAf/IaMtWhYmWsXUd2PuxaqSa3iMIHQxWpVCHQEWi5hin/N3j78
 r3VdooUV3ROqYVFnqIqnp8y6isWFOC7M6J367XyBcHY5jM5BDd6xs7huQpEJs4Zu5ZVx
 yFrFjvPt9Fl7jveKFpJi9DMjN8iaWqFixlydvCx4b9veiXrZXp9PM+SDHgujObPdgEcq
 v5JaRnmfWL+xyJGwTcoCCLkDrryckAtofeHczqQwyPIjTEV+ZEjeWYxC2T2hTb3pKBOj
 GeyA==
X-Gm-Message-State: AOAM5313dZUktIlWENgJAOLr7y4jhHuM7LMW/lKG+OtIMzB2ZuqD5RLy
 5+NAubW2hFjBAY4KkrXJu+5OE/RYg1toH0LIETwRnw==
X-Google-Smtp-Source: ABdhPJxfpZUF/SiL6XakzrJYzR9zf4mbwwjNucTuoY4CEERAxdf2B8UbWftU6B65j4Lr/o8zaYhyCw9AyRNU1/YVzAk=
X-Received: by 2002:a05:651c:550:: with SMTP id
 q16mr28313693ljp.188.1594077188285; 
 Mon, 06 Jul 2020 16:13:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200630044943.3425049-4-rajatja@google.com>
 <20200706164514.GA124720@bjorn-Precision-5520>
In-Reply-To: <20200706164514.GA124720@bjorn-Precision-5520>
Date: Mon, 6 Jul 2020 16:12:31 -0700
Message-ID: <CACK8Z6EVgeTZLph4CWaztB1WavocMyN237FwDAZudtEa=_e3Cg@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] PCI/ACS: Enable PCI_ACS_TB for
 untrusted/external-facing devices
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Todd Broch <tbroch@google.com>, linux-pci <linux-pci@vger.kernel.org>,
 "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Diego Rivas <diegorivas@google.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Furquan Shaikh <furquan@google.com>, Raj Ashok <ashok.raj@intel.com>,
 Saravana Kannan <saravanak@google.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Christian Kellner <christian@kellner.me>,
 Mattias Nissler <mnissler@google.com>, Jesse Barnes <jsbarnes@google.com>,
 Len Brown <lenb@kernel.org>, Rajat Jain <rajatxjain@gmail.com>,
 Prashant Malani <pmalani@google.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Aaron Durbin <adurbin@google.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Bernie Keany <bernie.keany@intel.com>, Duncan Laurie <dlaurie@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Oliver O'Halloran <oohall@gmail.com>,
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

On Mon, Jul 6, 2020 at 9:45 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Jun 29, 2020 at 09:49:39PM -0700, Rajat Jain wrote:
> > When enabling ACS, enable translation blocking for external facing ports
> > and untrusted devices.
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > ---
> > v2: Commit log change
> >
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
>
> I don't understand this comment.  Is this a "TODO"?  Is there
> something more that needs to be done here?

Yes. I'll mark it as a TODO to make it more clear.

>
> After a patch is applied, a comment should describe the code as it is.
>
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
> > 2.27.0.212.ge8ba1cc988-goog
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
