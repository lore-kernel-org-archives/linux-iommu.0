Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 437CCC433EF
	for <iommu@archiver.kernel.org>; Thu, 17 Mar 2022 08:09:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB837612AA;
	Thu, 17 Mar 2022 08:09:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B6lyI-GP6PqX; Thu, 17 Mar 2022 08:09:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BA01061286;
	Thu, 17 Mar 2022 08:09:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D3A8C001A;
	Thu, 17 Mar 2022 08:09:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9852C000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 08:09:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C55A1612A4
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 08:09:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c7DUwIM2Oaqk for <iommu@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 08:09:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EB27161286
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 08:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647504587; x=1679040587;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=i5uAxe0PmqtwfYW1OGC8/aQYpXunMY6vhmtGfo43Uek=;
 b=T2cnt2cxhMJB1+71/KOmiSZvc9YdCHVP1VLQrz6FgTLvtaP+uWsUVzIx
 O0il4Xl1hL5FKeASOMDLFaCfPMqZ3Zs3+bOVCgQbvyUO4N1QLCt2jJWux
 A7rzguSfj4zrMrRapJWibiey37BhExSVgA2xCfB5EmG2ECXs92evpwl3c
 D3DoWHQJDMIRpS94VFbQ2n4ag32ayvW43bC9QmOb0jsR/ykhUx2L5vy6J
 5YOwfiz7xD5hJhjMEtdZ1v5bxpGeWO4aEq4r3j5DOk529Pmj4DbuzH3fx
 ZI+7Ec47+Pylz3XI1Pb4vi6LD8/1QR2gFznYxrIsfCYECI5xP1mHtC7Y4 Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="236757358"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; d="scan'208";a="236757358"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2022 01:09:47 -0700
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; d="scan'208";a="516675048"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2022 01:09:42 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 17 Mar 2022 10:08:30 +0200
Date: Thu, 17 Mar 2022 10:08:30 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] thunderbolt: Stop using iommu_present()
Message-ID: <YjLsfhUmhjOiy6G8@lahna>
References: <YjHb1xCx4UAmUjrR@lahna>
 <16852eb2-98bb-6337-741f-8c2f06418b08@arm.com>
 <YjIb+XOGZbWKpQDa@lahna>
 <BL1PR12MB515762E68F3A48A97EB2DC89E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
 <YjIgQfmcw6fydkXd@lahna>
 <3bb6a2f8-005b-587a-7d7a-7a9a5391ec05@arm.com>
 <BL1PR12MB5157DA58C3BDAFB5736676F6E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
 <5ef1c30a-1740-00cc-ad16-4b1c1b02fca4@arm.com>
 <BL1PR12MB5157380CD6FD9EB83E76CBB0E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
 <0709e994-1c8b-56fe-7743-8fdbf3ba748b@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0709e994-1c8b-56fe-7743-8fdbf3ba748b@arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: "michael.jamet@intel.com" <michael.jamet@intel.com>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>, "hch@lst.de" <hch@lst.de>
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

On Wed, Mar 16, 2022 at 07:17:57PM +0000, Robin Murphy wrote:
> The feeling I'm getting from all this is that if we've got as far as
> iommu_dma_protection_show() then it's really too late to meaningfully
> mitigate bad firmware.

Note, these are requirements from Microsoft in order for the system to
use the "Kernel DMA protection". Because of this, likelyhood of "bad
firmware" should be quite low since these systems ship with Windows
installed so they should get at least some soft of validation that this
actually works.

> We should be able to detect missing
> untrusted/external-facing properties as early as nhi_probe(), and if we
> could go into "continue at your own risk" mode right then *before* anything
> else happens, it all becomes a lot easier to reason about.

I think what we want is that the DMAR opt-in bit is set in the ACPI
tables and that we know the full IOMMU translation is happening for the
devices behind "external facing ports". If that's not the case the
iommu_dma_protection_show() should return 0 meaning the userspace can
ask the user whether the connected device is allowed to use DMA (e.g
PCIe is tunneled or not).

We do check for the DMAR bit in the Intel IOMMU code and we also do
check that there actually are PCIe ports marked external facing but we
could issue warning there if that's not the case. Similarly if the user
explicitly disabled the IOMMU translation. This can be done inside a new
IOMMU API that does something like the below pseudo-code:

#if IOMMU_ENABLED
bool iommu_dma_protected(struct device *dev)
{
	if (dmar_platform_optin() /* or the AMD equivalent */) {
		if (!iommu_present(...)) /* whatever is needed to check that the full translation is enabled */
			dev_warn(dev, "IOMMU protection disabled!");
		/*
		 * Look for the external facing ports. Should be at
		 * least 1 or issue warning.
		 */
		 ...

		return true;
	}

	return false;
}
#else
static inline bool iommu_dma_protected(struct device *dev)
{
	return false;
}
#endif

Then we can make iommu_dma_protection_show() to call this function.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
