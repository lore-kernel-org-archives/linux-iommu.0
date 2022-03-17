Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CFE3C433EF
	for <iommu@archiver.kernel.org>; Thu, 17 Mar 2022 13:43:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C96240359;
	Thu, 17 Mar 2022 13:43:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n1PrxG1VEDid; Thu, 17 Mar 2022 13:43:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id ACCC64033B;
	Thu, 17 Mar 2022 13:43:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D9EFC001A;
	Thu, 17 Mar 2022 13:43:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07C21C000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 13:43:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 055D340337
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 13:43:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0t8EimznMIof for <iommu@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 13:43:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1964040308
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 13:43:06 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44A181576;
 Thu, 17 Mar 2022 06:43:06 -0700 (PDT)
Received: from [10.57.42.204] (unknown [10.57.42.204])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6DA83F766;
 Thu, 17 Mar 2022 06:43:04 -0700 (PDT)
Message-ID: <23f232a1-f511-d2fe-b1f8-5fd32b3a1a8f@arm.com>
Date: Thu, 17 Mar 2022 13:42:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] thunderbolt: Stop using iommu_present()
Content-Language: en-GB
To: Mika Westerberg <mika.westerberg@linux.intel.com>
References: <YjHb1xCx4UAmUjrR@lahna>
 <16852eb2-98bb-6337-741f-8c2f06418b08@arm.com> <YjIb+XOGZbWKpQDa@lahna>
 <BL1PR12MB515762E68F3A48A97EB2DC89E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
 <YjIgQfmcw6fydkXd@lahna> <3bb6a2f8-005b-587a-7d7a-7a9a5391ec05@arm.com>
 <BL1PR12MB5157DA58C3BDAFB5736676F6E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
 <5ef1c30a-1740-00cc-ad16-4b1c1b02fca4@arm.com>
 <BL1PR12MB5157380CD6FD9EB83E76CBB0E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
 <0709e994-1c8b-56fe-7743-8fdbf3ba748b@arm.com> <YjLsfhUmhjOiy6G8@lahna>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YjLsfhUmhjOiy6G8@lahna>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022-03-17 08:08, Mika Westerberg wrote:
> Hi Robin,
> 
> On Wed, Mar 16, 2022 at 07:17:57PM +0000, Robin Murphy wrote:
>> The feeling I'm getting from all this is that if we've got as far as
>> iommu_dma_protection_show() then it's really too late to meaningfully
>> mitigate bad firmware.
> 
> Note, these are requirements from Microsoft in order for the system to
> use the "Kernel DMA protection". Because of this, likelyhood of "bad
> firmware" should be quite low since these systems ship with Windows
> installed so they should get at least some soft of validation that this
> actually works.
> 
>> We should be able to detect missing
>> untrusted/external-facing properties as early as nhi_probe(), and if we
>> could go into "continue at your own risk" mode right then *before* anything
>> else happens, it all becomes a lot easier to reason about.
> 
> I think what we want is that the DMAR opt-in bit is set in the ACPI
> tables and that we know the full IOMMU translation is happening for the
> devices behind "external facing ports". If that's not the case the
> iommu_dma_protection_show() should return 0 meaning the userspace can
> ask the user whether the connected device is allowed to use DMA (e.g
> PCIe is tunneled or not).

Ah, if it's safe to just say "no protection" in the case that we don't 
know for sure, that's even better. Clearly I hadn't quite grasped that 
aspect of the usage model, thanks for the nudge!

> We do check for the DMAR bit in the Intel IOMMU code and we also do
> check that there actually are PCIe ports marked external facing but we
> could issue warning there if that's not the case. Similarly if the user
> explicitly disabled the IOMMU translation. This can be done inside a new
> IOMMU API that does something like the below pseudo-code:
> 
> #if IOMMU_ENABLED
> bool iommu_dma_protected(struct device *dev)
> {
> 	if (dmar_platform_optin() /* or the AMD equivalent */) {
> 		if (!iommu_present(...)) /* whatever is needed to check that the full translation is enabled */
> 			dev_warn(dev, "IOMMU protection disabled!");
> 		/*
> 		 * Look for the external facing ports. Should be at
> 		 * least 1 or issue warning.
> 		 */
> 		 ...
> 
> 		return true;
> 	}
> 
> 	return false;
> }
> #else
> static inline bool iommu_dma_protected(struct device *dev)
> {
> 	return false;
> }
> #endif
> 
> Then we can make iommu_dma_protection_show() to call this function.

The problem that I've been trying to nail down here is that 
dmar_platform_optin() really doesn't mean much for us - I don't know how 
  Windows' IOMMU drivers work, but there's every chance it's not the 
same way as ours. The only material effect that dmar_platform_optin() 
has for us is to prevent the user from disabling the IOMMU driver 
altogether, and thus ensure that iommu_present() is true. Whether or not 
we can actually trust the IOMMU driver to provide reliable protection 
depends entirely on whether it knows the PCIe ports are external-facing. 
If not, we can only *definitely* know what the IOMMU driver will do for 
a given endpoint once that endpoint has appeared behind the port and 
iommu_probe_device() has decided what its default domain should be, and 
as far as I now understand, that's not an option for Thunderbolt since 
it can only happen *after* the tunnel has been authorised and created.

Much as I'm tempted to de-scope back to my IOMMU API cleanup and run 
away from the rest of the issue, I think I can crib enough from the 
existing code to attempt a reasonable complete fix, so let me give that 
a go...

Thanks,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
