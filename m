Return-Path: <SRS0=M77+=AX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4250DC433DF
	for <iommu@archiver.kernel.org>; Sun, 12 Jul 2020 02:58:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0AF320748
	for <iommu@archiver.kernel.org>; Sun, 12 Jul 2020 02:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7qkaNOS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0AF320748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BC75E20770;
	Sun, 12 Jul 2020 02:58:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BvnoA4kfluO9; Sun, 12 Jul 2020 02:58:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id DA83020465;
	Sun, 12 Jul 2020 02:58:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97D9CC088E;
	Sun, 12 Jul 2020 02:58:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68EFBC016F
 for <iommu@lists.linux-foundation.org>; Sun, 12 Jul 2020 02:58:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 64426876D2
 for <iommu@lists.linux-foundation.org>; Sun, 12 Jul 2020 02:58:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mm288NOiapDi for <iommu@lists.linux-foundation.org>;
 Sun, 12 Jul 2020 02:58:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id AF36A876D0
 for <iommu@lists.linux-foundation.org>; Sun, 12 Jul 2020 02:58:40 +0000 (UTC)
Received: from localhost (mobile-166-175-191-139.mycingular.net
 [166.175.191.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D1ABD206F4;
 Sun, 12 Jul 2020 02:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594522720;
 bh=GCEYp34kfSIsAhwGdytjjpiuDjkxNS2Pq5Ga4nERay0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=T7qkaNOSVPVMA1p+OUXR50mxJVKqp+kGpnsAUcwYjmoxKigEkZ+C9uni48nxvzaCc
 vAD4IUBoFIROp4tLxDovrohgR/tnB9hES1edKw0SsJHM9b8vFAzpkFRAVOCGPqNZr3
 feY7YyKAtniCs6zD1STAzEXbVZz+eK3O5AsWgdgg=
Date: Sat, 11 Jul 2020 21:58:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rajat Jain <rajatxjain@gmail.com>
Subject: Re: [PATCH v4 4/4] PCI/ACS: Enable PCI_ACS_TB for
 untrusted/external-facing devices
Message-ID: <20200712025838.GA147150@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAA93t1rjzTYmag1vTDT==7GQ8LLduc9Ne06btEEwiyBRtCeTNg@mail.gmail.com>
Cc: Todd Broch <tbroch@google.com>, linux-pci <linux-pci@vger.kernel.org>,
 "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Diego Rivas <diegorivas@google.com>, Rajat Jain <rajatja@google.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Furquan Shaikh <furquan@google.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Saravana Kannan <saravanak@google.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Christian Kellner <christian@kellner.me>,
 Mattias Nissler <mnissler@google.com>, Jesse Barnes <jsbarnes@google.com>,
 Len Brown <lenb@kernel.org>, Prashant Malani <pmalani@google.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Aaron Durbin <adurbin@google.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Benson Leung <bleung@google.com>, Duncan Laurie <dlaurie@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Oliver O'Halloran <oohall@gmail.com>,
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

On Sat, Jul 11, 2020 at 05:08:51PM -0700, Rajat Jain wrote:
> On Sat, Jul 11, 2020 at 12:53 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Jul 10, 2020 at 03:53:59PM -0700, Rajat Jain wrote:
> > > On Fri, Jul 10, 2020 at 2:29 PM Raj, Ashok <ashok.raj@intel.com> wrote:
> > > > On Fri, Jul 10, 2020 at 03:29:22PM -0500, Bjorn Helgaas wrote:
> > > > > On Tue, Jul 07, 2020 at 03:46:04PM -0700, Rajat Jain wrote:
> > > > > > When enabling ACS, enable translation blocking for external facing ports
> > > > > > and untrusted devices.
> > > > > >
> > > > > > Signed-off-by: Rajat Jain <rajatja@google.com>
> > > > > > ---
> > > > > > v4: Add braces to avoid warning from kernel robot
> > > > > >     print warning for only external-facing devices.
> > > > > > v3: print warning if ACS_TB not supported on external-facing/untrusted ports.
> > > > > >     Minor code comments fixes.
> > > > > > v2: Commit log change
> > > > > >
> > > > > >  drivers/pci/pci.c    |  8 ++++++++
> > > > > >  drivers/pci/quirks.c | 15 +++++++++++++++
> > > > > >  2 files changed, 23 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > > > index 73a8627822140..a5a6bea7af7ce 100644
> > > > > > --- a/drivers/pci/pci.c
> > > > > > +++ b/drivers/pci/pci.c
> > > > > > @@ -876,6 +876,14 @@ static void pci_std_enable_acs(struct pci_dev *dev)
> > > > > >     /* Upstream Forwarding */
> > > > > >     ctrl |= (cap & PCI_ACS_UF);
> > > > > >
> > > > > > +   /* Enable Translation Blocking for external devices */
> > > > > > +   if (dev->external_facing || dev->untrusted) {
> > > > > > +           if (cap & PCI_ACS_TB)
> > > > > > +                   ctrl |= PCI_ACS_TB;
> > > > > > +           else if (dev->external_facing)
> > > > > > +                   pci_warn(dev, "ACS: No Translation Blocking on external-facing dev\n");
> > > > > > +   }
> > > > >
> > > > > IIUC, this means that external devices can *never* use ATS and
> > > > > can never cache translations.
> > >
> > > Yes, but it already exists today (and this patch doesn't change that):
> > > 521376741b2c2 "PCI/ATS: Only enable ATS for trusted devices"
> > >
> > > IMHO any external device trying to send ATS traffic despite having ATS
> > > disabled should count as a bad intent. And this patch is trying to
> > > plug that loophole, by blocking the AT traffic from devices that we do
> > > not expect to see AT from anyway.
> >
> > Thinking about this some more, I wonder if Linux should:
> >
> >   - Explicitly disable ATS for every device at enumeration-time, e.g.,
> >     in pci_init_capabilities(),
> >
> >   - Enable PCI_ACS_TB for every device (not just external-facing or
> >     untrusted ones),
> >
> >   - Disable PCI_ACS_TB for the relevant devices along the path only
> >     when enabling ATS.
> >
> > One nice thing about doing that is that the "untrusted" test would be
> > only in pci_enable_ats(), and we wouldn't need one in
> > pci_std_enable_acs().
> 
> Yes, this could work.
> 
> I think I had thought about this but I'm blanking out on why I had
> given it up. I think it was because of the possibility that some
> bridges may have "Translation blocking" disabled, even if not all
> their descendents were trusted enough to enable ATS on them. But now
> thinking about this again, as long as we retain the policy of not
> enabling ATS on external devices (and thus enable TB for sure on
> them), this should not be a problem. WDYT?

I think I would feel better if we always enabled Translation Blocking
except when we actually need it for ATS.  But I'm not confident about
how all the pieces of ATS work, so I could be missing something.

> > It's possible BIOS gives us devices with ATS enabled, and this
> > might break them, but that seems like something we'd want to find
> > out about.
> 
> Why would they break? We'd disable ATS on each device as we
> enumerate them, so they'd be functional, just with ATS disabled
> until it is enabled again on internal devices as needed. Which would
> be WAI behavior?

If BIOS handed off with ATS enabled and we somehow relied on it being
already enabled, something might break if we start disabling ATS.
Just a theoretical possibility, doesn't seem likely to me.

Bjorn
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
