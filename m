Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C9F8C433F5
	for <iommu@archiver.kernel.org>; Fri, 18 Mar 2022 15:12:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 345F560864;
	Fri, 18 Mar 2022 15:12:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rrM60G8-O6jB; Fri, 18 Mar 2022 15:12:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0554A60A72;
	Fri, 18 Mar 2022 15:12:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D49B0C0033;
	Fri, 18 Mar 2022 15:12:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 563FFC0012
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 15:12:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3744741A0A
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 15:12:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8GPZA1eIQzPK for <iommu@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 15:12:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5D9F741879
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 15:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647616331; x=1679152331;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=RyqKF6D9twudookxV1g3lDHqbNq6rtr8FS7sB7gUWvo=;
 b=LjeBv0h5snO45BYsP7/rmSHG15GEf/UCCCiPoHNnuRCDTU0AtgwmMjMn
 P6VcmFzKJlkwrsJbHaAmecD3h8FhAidzajqQAENgQ+0xSIr+Z5b/hsec+
 mbyMnL4xJB8VDqWYf73uzz/GYUE0/qc7f7xFON/1YHMU0W5oO3nrQh917
 9qrdh3UVgySvco1tEOYg+j7L/exoMpQmB73htesBfxYd+fA2Kr2o8gy3X
 hwPH1gwUWszIn+KSVOQPAXs6rSAE94TOhqFe50QI4zvXNo1CfaE/9qvDQ
 /8pv4OOofdVvWsxkJq+MWpbPdHHeI4BvWXuiB+POkMK+rAQVb679g76L+ w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="254707457"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; d="scan'208";a="254707457"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2022 08:11:53 -0700
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; d="scan'208";a="541886651"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2022 08:11:49 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 18 Mar 2022 17:11:47 +0200
Date: Fri, 18 Mar 2022 17:11:47 +0200
From: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] thunderbolt: Make iommu_dma_protection more accurate
Message-ID: <YjShM1g8wGDUymK4@lahna>
References: <2d01fa50c2650c730b0244929097737918e302e7.1647533152.git.robin.murphy@arm.com>
 <BL1PR12MB515783C0F998169D49D92A55E2129@BL1PR12MB5157.namprd12.prod.outlook.com>
 <BL1PR12MB51573F55B3C2B3922BAAA7F1E2129@BL1PR12MB5157.namprd12.prod.outlook.com>
 <YjRvMk1kcbMwJvx+@lahna>
 <65207fdf-c4ab-5165-dbda-8ab55b51adb7@arm.com>
 <YjSCWaq7Ej/2iJPp@lahna>
 <78fc0426-c22a-ec62-f92b-0019bea5947e@arm.com>
 <20220318145121.GA11127@wunner.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220318145121.GA11127@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: "michael.jamet@intel.com" <michael.jamet@intel.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Lukas,

On Fri, Mar 18, 2022 at 03:51:21PM +0100, Lukas Wunner wrote:
> On Fri, Mar 18, 2022 at 02:08:16PM +0000, Robin Murphy wrote:
> > OK, so do we have any realistic options for identifying the correct PCI
> > devices, if USB4 PCIe adapters might be anywhere relative to their
> > associated NHI? Short of maintaining a list of known IDs, the only thought I
> > have left is that if we walk the whole PCI segment looking specifically for
> > hotplug-capable Gen1 ports, any system modern enough to have Thunderbolt is
> > *probably* not going to have any real PCIe Gen1 hotplug slots, so maybe
> > false negatives might be tolerable, but it still feels like a bit of a
> > sketchy heuristic.
> 
> The Thunderbolt Device ROM contains the PCI slot number, so you can
> correlate the Thunderbolt switch ports with PCIe downstream ports
> and know exactly where PCIe tunnels are terminated.
> 
> Code is here:
> * thunderbolt: Obtain PCI slot number from DROM
>   https://github.com/l1k/linux/commit/756f7148bc10
> * thunderbolt: Move upstream_port to struct tb
>   https://github.com/l1k/linux/commit/58f16e7dd431
> * thunderbolt: Correlate PCI devices with Thunderbolt ports
>   https://github.com/l1k/linux/commit/f53ea40a7487
> 
> I implemented that in 2018, so it won't apply cleanly to current
> mainline.  But I kept forward-porting it on my private branch and
> could push that to GitHub if anyone is interested.
> 
> I don't know if this will work out-of-the-box for SoC-integrated
> Thunderbolt controllers.  It was developed with the discrete
> controllers in mind, which was the only thing available back then.

That DROM entry is completely optional and so is the whole DROM for the
host routers (this is the root of the USB4/TBT topology) so
unfortunately we cannot use it here.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
