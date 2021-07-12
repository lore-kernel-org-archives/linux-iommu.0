Return-Path: <SRS0=b5xv=ME=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38249C07E99
	for <iommu@archiver.kernel.org>; Mon, 12 Jul 2021 15:47:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B437861152
	for <iommu@archiver.kernel.org>; Mon, 12 Jul 2021 15:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B437861152
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 82D66607E3;
	Mon, 12 Jul 2021 15:47:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C-3Qo6l2029z; Mon, 12 Jul 2021 15:47:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7231C607D5;
	Mon, 12 Jul 2021 15:47:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56D55C001A;
	Mon, 12 Jul 2021 15:47:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C244C000E
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 15:47:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D416783478
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 15:47:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qjVGcTNPAtSG for <iommu@lists.linux-foundation.org>;
 Mon, 12 Jul 2021 15:47:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 959528332A
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 15:47:23 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10043"; a="189687945"
X-IronPort-AV: E=Sophos;i="5.84,234,1620716400"; d="scan'208";a="189687945"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2021 08:47:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,234,1620716400"; d="scan'208";a="412126089"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
 by orsmga006.jf.intel.com with SMTP; 12 Jul 2021 08:47:18 -0700
Received: by stinkbox (sSMTP sendmail emulation);
 Mon, 12 Jul 2021 18:47:17 +0300
Date: Mon, 12 Jul 2021 18:47:17 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 1/4] iommu/vt-d: Disable superpage for Geminilake igfx
Message-ID: <YOxkBeICOosZcVEY@intel.com>
References: <20210709164750.9465-1-ville.syrjala@linux.intel.com>
 <20210709164750.9465-2-ville.syrjala@linux.intel.com>
 <ab04666c-229c-fbd2-07f3-6955b46985db@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ab04666c-229c-fbd2-07f3-6955b46985db@linux.intel.com>
X-Patchwork-Hint: comment
Cc: intel-gfx@lists.freedesktop.org, David Woodhouse <dwmw2@infradead.org>,
 iommu@lists.linux-foundation.org
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Jul 12, 2021 at 07:23:07AM +0800, Lu Baolu wrote:
> On 7/10/21 12:47 AM, Ville Syrjala wrote:
> > From: Ville Syrj=E4l=E4 <ville.syrjala@linux.intel.com>
> > =

> > While running "gem_exec_big --r single" from igt-gpu-tools on
> > Geminilake as soon as a 2M mapping is made I tend to get a DMAR
> > write fault. Strangely the faulting address is always a 4K page
> > and usually very far away from the 2M page that got mapped.
> > But if no 2M mappings get used I can't reproduce the fault.
> > =

> > I also tried to dump the PTE for the faulting address but it actually
> > looks correct to me (ie. definitely seems to have the write bit set):
> >   DMAR: DRHD: handling fault status reg 2
> >   DMAR: [DMA Write] Request device [00:02.0] PASID ffffffff fault addr =
7fa8a78000 [fault reason 05] PTE Write access is not set
> >   DMAR: fault 7fa8a78000 (level=3D1) PTE =3D 149efc003
> > =

> > So not really sure what's going on and this might just be full on duct
> > tape, but it seems to work here. The machine has now survived a whole d=
ay
> > running that test whereas with superpage enabled it fails in less than
> > a minute usually.
> > =

> > TODO: might be nice to disable superpage only for the igfx iommu
> >        instead of both iommus
> =

> If all these quirks are about igfx dedicated iommu's, I would suggest to
> disable superpage only for the igfx ones.

Sure. Unfortunately there's no convenient mechanism to do that in
the iommu driver that I can immediately see. So not something I
can just whip up easily. Since you're actually familiar with the
driver maybe you can come up with a decent solution for that?

> =

> Best regards,
> baolu
> =

> > TODO: would be nice to use the macros from include/drm/i915_pciids.h,
> >        but can't do that with DECLARE_PCI_FIXUP_HEADER()
> > =

> > Cc: David Woodhouse <dwmw2@infradead.org>
> > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > Cc: iommu@lists.linux-foundation.org
> > Signed-off-by: Ville Syrj=E4l=E4 <ville.syrjala@linux.intel.com>
> > ---
> >   drivers/iommu/intel/iommu.c | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> > =

> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index 19c7888cbb86..4fff2c9c86af 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -5617,6 +5617,16 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x=
1632, quirk_iommu_igfx);
> >   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x163A, quirk_iommu_igf=
x);
> >   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x163D, quirk_iommu_igf=
x);
> >   =

> > +static void quirk_iommu_nosp(struct pci_dev *dev)
> > +{
> > +	pci_info(dev, "Disabling IOMMU superpage for graphics on this chipset=
\n");
> > +	intel_iommu_superpage =3D 0;
> > +}
> > +
> > +/* Geminilake igfx appears to have issues with superpage */
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x3184, quirk_iommu_nosp=
);
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x3185, quirk_iommu_nosp=
);
> > +
> >   static void quirk_iommu_rwbf(struct pci_dev *dev)
> >   {
> >   	if (risky_device(dev))
> > =


-- =

Ville Syrj=E4l=E4
Intel
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
