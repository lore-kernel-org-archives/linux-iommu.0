Return-Path: <SRS0=wTTv=AV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8E9C433E3
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 21:28:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 380642068F
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 21:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 380642068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 03EB189E89;
	Fri, 10 Jul 2020 21:28:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1NaIwv75Fx-d; Fri, 10 Jul 2020 21:28:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5900189E2F;
	Fri, 10 Jul 2020 21:28:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 332CFC0890;
	Fri, 10 Jul 2020 21:28:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9ABEAC016F
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 21:28:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7BC4889E87
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 21:28:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rq7G+K4-PIqv for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jul 2020 21:28:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by hemlock.osuosl.org (Postfix) with ESMTPS id BB10789E2F
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 21:28:54 +0000 (UTC)
IronPort-SDR: 5A0O4fFyUuHZxAevRj02vHMiMOdwJ22n1g6yYduXXNYGIdc7nfhQP+vEkIXY/O5M/QctDfhZGh
 HHUGbkwFi1Jg==
X-IronPort-AV: E=McAfee;i="6000,8403,9678"; a="166383207"
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; d="scan'208";a="166383207"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2020 14:28:54 -0700
IronPort-SDR: QtJ0Svtzt5o6heD9E9eaHtgim1i9h9gjLpXXGOf4JZ7gPfDKJXpNrqYhYQmshlI4nLU8n/Z1Rf
 QFQDNbv/W8kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; d="scan'208";a="306677452"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.25])
 by fmsmga004.fm.intel.com with ESMTP; 10 Jul 2020 14:28:53 -0700
Date: Fri, 10 Jul 2020 14:28:53 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v4 4/4] PCI/ACS: Enable PCI_ACS_TB for
 untrusted/external-facing devices
Message-ID: <20200710212853.GA328472@otc-nc-03>
References: <20200707224604.3737893-4-rajatja@google.com>
 <20200710202922.GA77140@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200710202922.GA77140@bjorn-Precision-5520>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: Todd Broch <tbroch@google.com>, linux-pci@vger.kernel.org,
 lalithambika.krishnakumar@intel.com,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Diego Rivas <diegorivas@google.com>, Rajat Jain <rajatja@google.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Furquan Shaikh <furquan@google.com>, Arnd Bergmann <arnd@arndb.de>,
 Saravana Kannan <saravanak@google.com>, linux-acpi@vger.kernel.org,
 Christian Kellner <christian@kellner.me>,
 Mattias Nissler <mnissler@google.com>, Jesse Barnes <jsbarnes@google.com>,
 Len Brown <lenb@kernel.org>, Rajat Jain <rajatxjain@gmail.com>,
 Prashant Malani <pmalani@google.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Aaron Durbin <adurbin@google.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Benson Leung <bleung@google.com>, Ashok Raj <ashok.raj@intel.com>,
 Duncan Laurie <dlaurie@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, oohall@gmail.com,
 Bernie Keany <bernie.keany@intel.com>, David Woodhouse <dwmw2@infradead.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Bjorn


On Fri, Jul 10, 2020 at 03:29:22PM -0500, Bjorn Helgaas wrote:
> On Tue, Jul 07, 2020 at 03:46:04PM -0700, Rajat Jain wrote:
> > When enabling ACS, enable translation blocking for external facing ports
> > and untrusted devices.
> > 
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > ---
> > v4: Add braces to avoid warning from kernel robot
> >     print warning for only external-facing devices.
> > v3: print warning if ACS_TB not supported on external-facing/untrusted ports.
> >     Minor code comments fixes.
> > v2: Commit log change
> > 
> >  drivers/pci/pci.c    |  8 ++++++++
> >  drivers/pci/quirks.c | 15 +++++++++++++++
> >  2 files changed, 23 insertions(+)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 73a8627822140..a5a6bea7af7ce 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -876,6 +876,14 @@ static void pci_std_enable_acs(struct pci_dev *dev)
> >  	/* Upstream Forwarding */
> >  	ctrl |= (cap & PCI_ACS_UF);
> >  
> > +	/* Enable Translation Blocking for external devices */
> > +	if (dev->external_facing || dev->untrusted) {
> > +		if (cap & PCI_ACS_TB)
> > +			ctrl |= PCI_ACS_TB;
> > +		else if (dev->external_facing)
> > +			pci_warn(dev, "ACS: No Translation Blocking on external-facing dev\n");
> > +	}
> 
> IIUC, this means that external devices can *never* use ATS and can
> never cache translations.  And (I guess, I'm not an expert) it can
> also never use the Page Request Services?

Yep, sounds like it.

> 
> Is this what we want?  Do we have any idea how many external devices
> this will affect or how much of a performance impact they will see?
> 
> Do we need some kind of override or mechanism to authenticate certain
> devices so they can use ATS and PRI?

Sounds like we would need some form of an allow-list to start with so we
can have something in the interim. 

I suppose a future platform might have a facilty to ensure ATS is secure and
authenticated we could enable for all of devices in the system, in addition
to PCI CMA/IDE. 

I think having a global override to enable all devices so platform can
switch to current behavior, or maybe via a cmdline switch.. as much as we
have a billion of those, it still gives an option in case someone needs it.



> 
> If we do decide this is the right thing to do, I think we need to
> expand the commit log a bit, because this is potentially a significant
> user-visible change.
> 
> >  	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
> >  }
> >  
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index b341628e47527..bb22b46c1d719 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -4934,6 +4934,13 @@ static void pci_quirk_enable_intel_rp_mpc_acs(struct pci_dev *dev)
> >  	}
> >  }
> >  
> > +/*
> > + * Currently this quirk does the equivalent of
> > + * PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF
> > + *
> > + * TODO: This quirk also needs to do equivalent of PCI_ACS_TB,
> > + * if dev->external_facing || dev->untrusted
> > + */
> >  static int pci_quirk_enable_intel_pch_acs(struct pci_dev *dev)
> >  {
> >  	if (!pci_quirk_intel_pch_acs_match(dev))
> > @@ -4973,6 +4980,14 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
> >  	ctrl |= (cap & PCI_ACS_CR);
> >  	ctrl |= (cap & PCI_ACS_UF);
> >  
> > +	/* Enable Translation Blocking for external devices */
> > +	if (dev->external_facing || dev->untrusted) {
> > +		if (cap & PCI_ACS_TB)
> > +			ctrl |= PCI_ACS_TB;
> > +		else if (dev->external_facing)
> > +			pci_warn(dev, "ACS: No Translation Blocking on external-facing dev\n");
> > +	}
> > +
> >  	pci_write_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, ctrl);
> >  
> >  	pci_info(dev, "Intel SPT PCH root port ACS workaround enabled\n");
> > -- 
> > 2.27.0.212.ge8ba1cc988-goog
> > 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
