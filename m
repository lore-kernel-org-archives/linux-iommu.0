Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6855EC433F5
	for <iommu@archiver.kernel.org>; Mon, 21 Mar 2022 10:58:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1C89340535;
	Mon, 21 Mar 2022 10:58:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XDBPUREnjO1Z; Mon, 21 Mar 2022 10:58:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 722A240643;
	Mon, 21 Mar 2022 10:58:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42F9DC0012;
	Mon, 21 Mar 2022 10:58:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB080C000B
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 10:58:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 949D560B83
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 10:58:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NXVcGOINpoWu for <iommu@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 10:58:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E896A605AC
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 10:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647860321; x=1679396321;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=6RtiG0C2v7b3JHoXbKF81Ytg+qc2VwLCD93SLy7ttLA=;
 b=GhKcvvBVbeiK7Mq6yYARbJ0jXVLxJy/VWiCCycFWbvk53LOptxsdzKgl
 3bsUSI42UBeT0Az1IR+Cayj2T1vk3Bgb/0h3Znj2VQAE0Mi+US6AeJj1/
 4PYFiPmRex4I1VejyU6AO5gcjhIci0w8cAaUjrnozv6Z2JjFnCKKgTsCo
 N5kQF+/P80xWvw0p79lL3yk31HqzHyFdeVZlYHvgAkgD6sIDvitM8Co/h
 /8Yclbx2Tiajj02A8CjH9AaExghGn6bRnd/C6f5iJ1PdZnaOwFJOxiNi1
 A5d+uHj9rO6Q4qTdy4FMJwyR+zlUY9cF8uV9uZib3eTm+yiWpnGcplShS Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="255088547"
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; d="scan'208";a="255088547"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2022 03:58:36 -0700
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; d="scan'208";a="551675891"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2022 03:58:32 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 21 Mar 2022 12:58:30 +0200
Date: Mon, 21 Mar 2022 12:58:30 +0200
From: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: Re: [PATCH v2 2/2] thunderbolt: Make iommu_dma_protection more
 accurate
Message-ID: <YjhaViFzmEjBgmmu@lahna>
References: <cover.1647624084.git.robin.murphy@arm.com>
 <0dd14883930c9f55ace22162e23765a37d91a057.1647624084.git.robin.murphy@arm.com>
 <DM4PR12MB51683722CF9A553563D0C721E2139@DM4PR12MB5168.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DM4PR12MB51683722CF9A553563D0C721E2139@DM4PR12MB5168.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: "michael.jamet@intel.com" <michael.jamet@intel.com>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>
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

Hi Mario,

On Fri, Mar 18, 2022 at 10:29:59PM +0000, Limonciello, Mario wrote:
> [Public]
> 
> > Between me trying to get rid of iommu_present() and Mario wanting to
> > support the AMD equivalent of DMAR_PLATFORM_OPT_IN, scrutiny has
> > shown
> > that the iommu_dma_protection attribute is being far too optimistic.
> > Even if an IOMMU might be present for some PCI segment in the system,
> > that doesn't necessarily mean it provides translation for the device(s)
> > we care about. Furthermore, all that DMAR_PLATFORM_OPT_IN really does
> > is tell us that memory was protected before the kernel was loaded, and
> > prevent the user from disabling the intel-iommu driver entirely. While
> > that lets us assume kernel integrity, what matters for actual runtime
> > DMA protection is whether we trust individual devices, based on the
> > "external facing" property that we expect firmware to describe for
> > Thunderbolt ports.
> > 
> > It's proven challenging to determine the appropriate ports accurately
> > given the variety of possible topologies, so while still not getting a
> > perfect answer, by putting enough faith in firmware we can at least get
> > a good bit closer. If we can see that any device near a Thunderbolt NHI
> > has all the requisites for Kernel DMA Protection, chances are that it
> > *is* a relevant port, but moreover that implies that firmware is playing
> > the game overall, so we'll use that to assume that all Thunderbolt ports
> > should be correctly marked and thus will end up fully protected.
> > 
> 
> This approach looks generally good to me.  I do worry a little bit about older
> systems that didn't set ExternalFacingPort in the FW but were previously setting
> iommu_dma_protection, but I think that those could be treated on a quirk
> basis to set PCI IDs for those root ports as external facing if/when they come
> up.

There are no such systems out there AFAICT.

> I'll send up a follow up patch that adds the AMD ACPI table check.
> If it looks good can roll it into your series for v3, or if this series goes
> as is for v2 it can come on its own.
> 
> > CC: Mario Limonciello <mario.limonciello@amd.com>
> > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > ---
> > 
> > v2: Give up trying to look for specific devices, just look for evidence
> >     that firmware cares at all.
> 
> I still do think you could know exactly which devices to use if you're in
> SW CM mode, but I guess the consensus is to not bifurcate the way this
> can be checked.

Indeed.

The patch looks good to me now. I will give it a try on a couple of
systems later today or tomorrow and let you guys know how it went. I
don't expect any problems but let's see.

Thanks a lot Robin for working on this :)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
