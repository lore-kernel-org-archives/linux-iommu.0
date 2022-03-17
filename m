Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF13C433FE
	for <iommu@archiver.kernel.org>; Thu, 17 Mar 2022 14:23:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BBBFF40423;
	Thu, 17 Mar 2022 14:23:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r2v_fvxDREYP; Thu, 17 Mar 2022 14:23:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 236BD40494;
	Thu, 17 Mar 2022 14:23:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E44D2C0012;
	Thu, 17 Mar 2022 14:23:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F238C000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 14:23:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 47DDF812C1
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 14:23:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bVnU65RHiJ9b for <iommu@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 14:23:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2459281296
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 14:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647527021; x=1679063021;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=CRwG4aY4JJ4LjAE7lBFW8th+dS3FJs6IUGzKssvwkes=;
 b=lol8pU96yhAhOvcnwLIUgUQQoB7R2kDTY7uvHOqotc6AMngynUdInwAo
 dGHpwL1BNskZexLDQEAeveu1vkb1mQwzrYIJqoM9jDlQPzFhqako1jDNk
 mURsiJTK3RU4kZv7yXqjlkuBP3cF+FQy885SPPm9uIhiz3yGFe4aHYWKy
 qnS++2BFW9O+HhKPjAVBbktvm2qWRsfnlD/QtQiwLbt5A9qjKqy5Ggi+t
 fyCsCSfvNJMaBJBM94xyCIqV0G2qAKXKW1T55Ah26wzpxa76nSN59gTzR
 6rxnEh3OmQ2Qap4xc6wVwebqqaSsZpkxcQS2gpmfQmRVTe2LOvpSxcyDP A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="254434489"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; d="scan'208";a="254434489"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2022 07:23:40 -0700
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; d="scan'208";a="581306413"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2022 07:23:36 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 17 Mar 2022 16:21:22 +0200
Date: Thu, 17 Mar 2022 16:21:22 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] thunderbolt: Stop using iommu_present()
Message-ID: <YjND4iZaLZbhJhbg@lahna>
References: <YjIb+XOGZbWKpQDa@lahna>
 <BL1PR12MB515762E68F3A48A97EB2DC89E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
 <YjIgQfmcw6fydkXd@lahna>
 <3bb6a2f8-005b-587a-7d7a-7a9a5391ec05@arm.com>
 <BL1PR12MB5157DA58C3BDAFB5736676F6E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
 <5ef1c30a-1740-00cc-ad16-4b1c1b02fca4@arm.com>
 <BL1PR12MB5157380CD6FD9EB83E76CBB0E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
 <0709e994-1c8b-56fe-7743-8fdbf3ba748b@arm.com>
 <YjLsfhUmhjOiy6G8@lahna>
 <23f232a1-f511-d2fe-b1f8-5fd32b3a1a8f@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <23f232a1-f511-d2fe-b1f8-5fd32b3a1a8f@arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: "michael.jamet@intel.com" <michael.jamet@intel.com>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
 "hch@lst.de" <hch@lst.de>
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

Hi Robin,

On Thu, Mar 17, 2022 at 01:42:56PM +0000, Robin Murphy wrote:
> On 2022-03-17 08:08, Mika Westerberg wrote:
> > Hi Robin,
> > 
> > On Wed, Mar 16, 2022 at 07:17:57PM +0000, Robin Murphy wrote:
> > > The feeling I'm getting from all this is that if we've got as far as
> > > iommu_dma_protection_show() then it's really too late to meaningfully
> > > mitigate bad firmware.
> > 
> > Note, these are requirements from Microsoft in order for the system to
> > use the "Kernel DMA protection". Because of this, likelyhood of "bad
> > firmware" should be quite low since these systems ship with Windows
> > installed so they should get at least some soft of validation that this
> > actually works.
> > 
> > > We should be able to detect missing
> > > untrusted/external-facing properties as early as nhi_probe(), and if we
> > > could go into "continue at your own risk" mode right then *before* anything
> > > else happens, it all becomes a lot easier to reason about.
> > 
> > I think what we want is that the DMAR opt-in bit is set in the ACPI
> > tables and that we know the full IOMMU translation is happening for the
> > devices behind "external facing ports". If that's not the case the
> > iommu_dma_protection_show() should return 0 meaning the userspace can
> > ask the user whether the connected device is allowed to use DMA (e.g
> > PCIe is tunneled or not).
> 
> Ah, if it's safe to just say "no protection" in the case that we don't know
> for sure, that's even better. Clearly I hadn't quite grasped that aspect of
> the usage model, thanks for the nudge!

There is some documentation here too, hope it is helpful:

https://docs.kernel.org/admin-guide/thunderbolt.html

> > We do check for the DMAR bit in the Intel IOMMU code and we also do
> > check that there actually are PCIe ports marked external facing but we
> > could issue warning there if that's not the case. Similarly if the user
> > explicitly disabled the IOMMU translation. This can be done inside a new
> > IOMMU API that does something like the below pseudo-code:
> > 
> > #if IOMMU_ENABLED
> > bool iommu_dma_protected(struct device *dev)
> > {
> > 	if (dmar_platform_optin() /* or the AMD equivalent */) {
> > 		if (!iommu_present(...)) /* whatever is needed to check that the full translation is enabled */
> > 			dev_warn(dev, "IOMMU protection disabled!");
> > 		/*
> > 		 * Look for the external facing ports. Should be at
> > 		 * least 1 or issue warning.
> > 		 */
> > 		 ...
> > 
> > 		return true;
> > 	}
> > 
> > 	return false;
> > }
> > #else
> > static inline bool iommu_dma_protected(struct device *dev)
> > {
> > 	return false;
> > }
> > #endif
> > 
> > Then we can make iommu_dma_protection_show() to call this function.
> 
> The problem that I've been trying to nail down here is that
> dmar_platform_optin() really doesn't mean much for us - I don't know how
> Windows' IOMMU drivers work, but there's every chance it's not the same way
> as ours. The only material effect that dmar_platform_optin() has for us is
> to prevent the user from disabling the IOMMU driver altogether, and thus
> ensure that iommu_present() is true. Whether or not we can actually trust
> the IOMMU driver to provide reliable protection depends entirely on whether
> it knows the PCIe ports are external-facing. If not, we can only
> *definitely* know what the IOMMU driver will do for a given endpoint once
> that endpoint has appeared behind the port and iommu_probe_device() has
> decided what its default domain should be, and as far as I now understand,
> that's not an option for Thunderbolt since it can only happen *after* the
> tunnel has been authorised and created.

That's correct. We do know the PCIe root/downstream ports (the external
facing ones) that host the tunneled PCIe topology but rest will appear
dynamically after the connection manager established the protocol
tunnel.

> Much as I'm tempted to de-scope back to my IOMMU API cleanup and run away
> from the rest of the issue, I think I can crib enough from the existing code
> to attempt a reasonable complete fix, so let me give that a go...

Sure ;-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
