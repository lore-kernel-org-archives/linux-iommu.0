Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82476C433F5
	for <iommu@archiver.kernel.org>; Wed, 16 Mar 2022 09:50:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 22E9D60C2D;
	Wed, 16 Mar 2022 09:50:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PC4rxH52tVW1; Wed, 16 Mar 2022 09:50:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BC02B60B86;
	Wed, 16 Mar 2022 09:50:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8EEF4C001A;
	Wed, 16 Mar 2022 09:50:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B519C000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 09:50:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DEB818426F
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 09:50:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bsZ_kEt-q2AU for <iommu@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 09:50:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B8569813DD
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 09:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647424231; x=1678960231;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=ag6lF0N6GjJ11ncqT04s+Zirja0zTp5u1TVDMYmoUzc=;
 b=WhqwqhuEzVfpPpBtQgobDcLhayVwcBukEEgkvZK3iAfd0XX0ylaEBO3S
 d5c7OVAn2qeXKT5iZBzb5DKah4tMAjQX6QMg3pQVkZSCFzNtHsFq3aWv4
 Vsox/JQiH/3nWGwm2PpBMFzVqaA69VU1Rr/aLRxkWELsY9ncHu7aGHvPm
 DqWAoqgnrAUlWus67LJmoAdXZQGFcPvpknEF9e3guBBi0dJvOgmkkZata
 wKucj4IatsdXbce305No17RdzE1c/9bKzvF1o574R7fs66SKM1LD/XXq4
 yNzWd51wI1qqPix/4OV/6+vtZfS8MjiLhcAkeApBJ2KR+3OnXkSmdMs+Q Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256727314"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; d="scan'208";a="256727314"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2022 02:50:31 -0700
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; d="scan'208";a="598645629"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2022 02:50:27 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 16 Mar 2022 11:50:25 +0200
Date: Wed, 16 Mar 2022 11:50:25 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Limonciello, Mario" <mario.limonciello@amd.com>
Subject: Re: [PATCH 2/2] thunderbolt: Use pre-boot DMA protection on AMD
 systems
Message-ID: <YjGy4ZOnLnTyCh8p@lahna>
References: <20220315162455.5190-1-mario.limonciello@amd.com>
 <20220315162455.5190-2-mario.limonciello@amd.com>
 <YjDDUUeZ/dvUZoDN@infradead.org>
 <BL1PR12MB5157D7B7734122684D47923AE2109@BL1PR12MB5157.namprd12.prod.outlook.com>
 <21d33a75-8c0e-7734-b3d1-dbe33cfe0ab0@arm.com>
 <7d588dfa-aa57-7be1-9cbb-61897f81bf99@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7d588dfa-aa57-7be1-9cbb-61897f81bf99@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: Michael Jamet <michael.jamet@intel.com>, Will Deacon <will@kernel.org>,
 "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 Andreas Noever <andreas.noever@gmail.com>,
 "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 Yehezkel Bernat <YehezkelShB@gmail.com>, christian@kellner.me,
 Robin Murphy <robin.murphy@arm.com>
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

Hi,

On Tue, Mar 15, 2022 at 01:36:11PM -0500, Limonciello, Mario wrote:
> + Christian Kellner (Bolt userspace maintainer)
> =

> On 3/15/2022 13:07, Robin Murphy wrote:
> > On 2022-03-15 16:54, Limonciello, Mario via iommu wrote:
> > > [Public]
> > > =

> > > =

> > > > On Tue, Mar 15, 2022 at 11:24:55AM -0500, Mario Limonciello wrote:
> > > > > -=A0=A0=A0=A0 * handled natively using IOMMU. It is enabled when =
IOMMU is
> > > > > -=A0=A0=A0=A0 * enabled and ACPI DMAR table has DMAR_PLATFORM_OPT=
_IN set.
> > > > > +=A0=A0=A0=A0 * handled natively using IOMMU. It is enabled when =
the IOMMU is
> > > > > +=A0=A0=A0=A0 * enabled and either:
> > > > > +=A0=A0=A0=A0 * ACPI DMAR table has DMAR_PLATFORM_OPT_IN set
> > > > > +=A0=A0=A0=A0 * or
> > > > > +=A0=A0=A0=A0 * ACPI IVRS table has DMA_REMAP bitset
> > > > > =A0=A0=A0=A0=A0=A0 */
> > > > > =A0=A0=A0=A0=A0 return sprintf(buf, "%d\n",
> > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iommu_present(&pci_bu=
s_type) &&
> > > > dmar_platform_optin());
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iommu_present(&pci_bu=
s_type) &&
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (dmar_platform_optin(=
) || amd_ivrs_remap_support()));
> > > > =

> > > > Yikes.=A0 No, the thunderbot code does not have any business poking=
 into
> > > > either dmar_platform_optin or amd_ivrs_remap_support.=A0 This needs
> > > > a proper abstration from the IOMMU code.

I agree. When it was originally added it was only the DMAR (Intel) based
platforms that provided this hint so adding an abstraction for that did
not make much sense. Now, since we are seeing more and more USB4 host
controllers and many of them support PCIe tunneling (and IOMMU) adding
an API makes more sense.

> > > =

> > > To make sure I follow your ask - it's to make a new generic iommu
> > > function
> > > That would check dmar/ivrs, and switch out thunderbolt domain.c to
> > > use the
> > > symbol?
> > > =

> > > I'm happy to rework that if that is what you want.
> > > Do you have a preferred proposed function name for that?
> > =

> > But why? Either IOMMU translation is enabled or it isn't, and if it is,
> > what's to gain from guessing at *why* it might have been? And even if
> > the IOMMU's firmware table did tell the IOMMU driver to enable the
> > IOMMU, why should that be Thunderbolt's business?
> A lot of this comes from baggage from early Thunderbolt 3 implementation =
on
> systems with ICM (Intel's FW CM). On those systems there was a concept of
> "Security Levels".  This meant that downstream PCIe devices were not
> automatically authorized when a TBT3 device was plugged in.  In those cas=
es
> there was no guarantee that the IOMMU was in use and so the security was
> passed on to the user to make a decision.
> =

> In Linux this was accomplished using the 'authorized' attribute in
> /sys/bus/thunderbolt/devices/$NUM/authorized.  When this was set to 1 then
> the TBT3 device and PCIe topology behind it would be enumerated.
> =

> Further documentation explaining how this works is available here:
> https://www.kernel.org/doc/html/latest/admin-guide/thunderbolt.html#secur=
ity-levels-and-how-to-use-them
> =

> (Intel based) Platforms from 2018+ w/ TBT3 started to use the IOMMU
> consistently at runtime but had this existing implementation of security
> levels to worry about.  Furthermore tunnels could be created pre-boot, and
> so the thunderbolt driver may or may not re-create them based on policy.
> =

> So a new attribute was created "iommu_dma_protection" that userspace could
> use as part of a policy decision to automatically authorize devices.
> Exporting this attribute is very similar to what Microsoft does to let the
> user see the security of the system.
> =

> https://docs.microsoft.com/en-us/windows-hardware/design/device-experienc=
es/oem-kernel-dma-protection
> =

> In Linux today some userspace software "bolt" has a policy included by
> default that will automatically authorize TBT3 and USB4 (w/ PCIe) devices
> when iommu_dma_protection is set to 1.
> =

> > =

> > Furthermore, looking at patch #1 I can only conclude that this is
> > entirely meaningless anyway. AFAICS it's literally reporting whether the
> > firmware flag was set or not. Not whether it's actually been honoured
> > and the IOMMU is enforcing any kind of DMA protection at all. Even on
> > Intel where the flag does at least have some effect on the IOMMU driver,
> > that can still be overridden.
> =

> Take a look at the Microsoft link I shared above.  They also make policy
> decisions based on the information in these tables.
> =

> > =

> > I already have a patch refactoring this to get rid of iommu_present(),
> > but at the time I wasn't looking to closely at what it's trying to *do*
> > with the information. If it's supposed to accurately reflect whether the
> > Thunderbolt device is subject to IOMMU translation and not bypassed, I
> > can fix that too (and unexport dmar_platform_optin() in the process...)
> > =

> > Robin.
> =

> This patch series stems from that history.  To give the best experience to
> end users you want hotplugged devices to be automatically authorized when
> software says it's safe to do so.
> =

> To summarize the flow:
> * User plugs in device
> * USB4 CM will query supported tunnels
> * USB4 CM will create devices in /sys/bus/thunderbolt/devices for new
> plugged in TBT3/USB4 device
> * "authorized" attribute will default to "0" and PCIe tunnels are not
> created
> * Userspace gets a uevent that the device was added
> * Userspace (bolt) reacts by reading
> /sys/bus/thunderbolt/devices/domainX/iommu_dma_protection
> * If that is set to "1", bolt will write "1" to "authorized"  and USB4 CM
> will create PCIe tunnels
> * If that is set to "0", bolt will send an event to GUI to show a popup
> asking to authorize the device
> * After user acks the authorization then it will write "1" to "authorized"
> and USB4 CM will create PCIe tunnels
> =

> =

> Mika,
> =

> I wonder if maybe what we really want is to only use that flow for the
> authorized attribute when using TBT3 + ICM (or IOMMU disabled at runtime).
> If we're using a USB4 host, check IOMMU translation layer active like Rob=
in
> suggested and then automatically authorize from the CM.

I would still leave that policy to userspace to decide.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
