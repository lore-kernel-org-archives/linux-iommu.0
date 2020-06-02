Return-Path: <SRS0=royy=7P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F142FC433E1
	for <iommu@archiver.kernel.org>; Tue,  2 Jun 2020 20:19:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CA88206C3
	for <iommu@archiver.kernel.org>; Tue,  2 Jun 2020 20:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA88206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 41F2B226EA;
	Tue,  2 Jun 2020 20:19:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bUjEELg8Y2Rd; Tue,  2 Jun 2020 20:19:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 37F7D20789;
	Tue,  2 Jun 2020 20:19:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18458C0865;
	Tue,  2 Jun 2020 20:19:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 715C9C016E
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 20:19:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5D265204B6
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 20:19:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T+j5J98MErVL for <iommu@lists.linux-foundation.org>;
 Tue,  2 Jun 2020 20:19:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 9A3482153E
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 20:19:53 +0000 (UTC)
IronPort-SDR: eij1miRwYr31gQJyn7yLNESM4qDUpKisLt0d+jBY01z+6YaoguON/hlVdqGsSE4LCT0zUXcl+p
 6DVDZkBI4iEA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2020 13:19:52 -0700
IronPort-SDR: suWFequyiB4FMrmPrmoOl+BWU7ncwyzr9QXxGnTG8pVc5JrkgS3IG2sNn1ZcuYbR4jIN/BD82S
 zQ1ZbE4YMz6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,465,1583222400"; d="scan'208";a="272489927"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.25])
 by orsmga006.jf.intel.com with ESMTP; 02 Jun 2020 13:19:52 -0700
Date: Tue, 2 Jun 2020 13:19:52 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH] iommu/vt-d: Don't apply gfx quirks to untrusted devices
Message-ID: <20200602201952.GB17363@otc-nc-03>
References: <20200602054517.191244-1-rajatja@google.com>
 <20200602095003.GI247495@lahna.fi.intel.com>
 <CACK8Z6F2n6yx7Fs43rmUQko3PAHZYcnc_eyE_xPdUHXwf2hhLw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACK8Z6F2n6yx7Fs43rmUQko3PAHZYcnc_eyE_xPdUHXwf2hhLw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: Todd Broch <tbroch@google.com>, Rajat Jain <rajatxjain@gmail.com>,
 Prashant Malani <pmalani@google.com>, Zubin Mithra <zsm@google.com>,
 Mika Westerberg <mika.westerberg@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Krishnakumar,
 Lalithambika" <lalithambika.krishnakumar@intel.com>,
 iommu@lists.linux-foundation.org, Mattias Nissler <mnissler@google.com>,
 Ashok Raj <ashok.raj@intel.com>, Benson Leung <bleung@google.com>,
 Alex Levin <levinale@google.com>, David Woodhouse <dwmw2@infradead.org>
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

On Tue, Jun 02, 2020 at 06:43:00PM +0000, Rajat Jain wrote:
> Hi MIka,
> 
> Thanks for taking a look.
> 
> On Tue, Jun 2, 2020 at 2:50 AM Mika Westerberg
> <mika.westerberg@intel.com> wrote:
> >
> > On Mon, Jun 01, 2020 at 10:45:17PM -0700, Rajat Jain wrote:
> > > Currently, an external malicious PCI device can masquerade the VID:PID
> > > of faulty gfx devices, and thus apply iommu quirks to effectively
> > > disable the IOMMU restrictions for itself.
> > >
> > > Thus we need to ensure that the device we are applying quirks to, is
> > > indeed an internal trusted device.
> > >
> > > Signed-off-by: Rajat Jain <rajatja@google.com>
> > > ---
> > >  drivers/iommu/intel-iommu.c | 28 ++++++++++++++++++++++++++++
> > >  1 file changed, 28 insertions(+)
> > >
> > > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> > > index ef0a5246700e5..f2a480168a02f 100644
> > > --- a/drivers/iommu/intel-iommu.c
> > > +++ b/drivers/iommu/intel-iommu.c
> > > @@ -6214,6 +6214,11 @@ const struct iommu_ops intel_iommu_ops = {
> > >
> > >  static void quirk_iommu_igfx(struct pci_dev *dev)
> > >  {
> > > +     if (dev->untrusted) {
> > > +             pci_warn(dev, "skipping iommu quirk for untrusted gfx dev\n");
> >
> > I think you should be consistent with other messages. For example iommu
> > should be spelled IOMMU as done below.
> >
> > Also this is visible to users so maybe put bit more information there:
> >
> >   pci_warn(dev, "Will not apply IOMMU quirk for untrusted graphics device\n");
> >
> > Ditto for all the other places. Also is "untrusted" good word here? If
> > an ordinary user sees this will it trigger some sort of panic reaction.
> > Perhaps we should call it "potentially untrusted" or something like
> > that?

Wish we called it external_facing rather than untrusted attribute, so its
description is consistent with the spec that defines it. Once we have
Platform Component Security Enhancements. 

to be correct, maybe call "Device located on an untrusted link" rather than
assert blame on the device.

Since the information is harvsted from BIOS tables and there are chances
this could be wrongly grouped such, add "Check with your BIOS/Platform
Vendor.



> 
> Fixed it, posted new patch at
> https://lkml.org/lkml/2020/6/2/822
> 
> Thanks,
> 
> Rajat
> 
> >
> > > +             return;
> > > +     }
> > > +
> > >       pci_info(dev, "Disabling IOMMU for graphics on this chipset\n");
> > >       dmar_map_gfx = 0;
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
