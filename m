Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6DAC433F5
	for <iommu@archiver.kernel.org>; Wed,  6 Apr 2022 10:32:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 226A64046D;
	Wed,  6 Apr 2022 10:32:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uOdp3b1T_l_t; Wed,  6 Apr 2022 10:32:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B550140469;
	Wed,  6 Apr 2022 10:32:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76CE2C002C;
	Wed,  6 Apr 2022 10:32:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 971DAC0012
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 10:32:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 717A64046D
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 10:32:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dWUMrA_hbkUs for <iommu@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 10:32:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5B38440469
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 10:32:24 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EAB223A;
 Wed,  6 Apr 2022 03:32:23 -0700 (PDT)
Received: from [10.57.41.19] (unknown [10.57.41.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 923B13F718;
 Wed,  6 Apr 2022 03:32:21 -0700 (PDT)
Message-ID: <0c9a1581-728c-6a5c-b65d-80a4f0948d19@arm.com>
Date: Wed, 6 Apr 2022 11:32:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 1/4] iommu: Introduce device_iommu_capable()
Content-Language: en-GB
To: Christoph Hellwig <hch@lst.de>
References: <cover.1649089693.git.robin.murphy@arm.com>
 <37ec2f9f67098d0caf60dcec558fbe1756ea2621.1649089693.git.robin.murphy@arm.com>
 <20220406052812.GA10507@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220406052812.GA10507@lst.de>
Cc: michael.jamet@intel.com, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, YehezkelShB@gmail.com,
 iommu@lists.linux-foundation.org, mario.limonciello@amd.com,
 andreas.noever@gmail.com, mika.westerberg@linux.intel.com
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

On 2022-04-06 06:28, Christoph Hellwig wrote:
> On Tue, Apr 05, 2022 at 11:41:01AM +0100, Robin Murphy wrote:
>> iommu_capable() only really works for systems where all IOMMU instances
>> are completely homogeneous, and all devices are IOMMU-mapped. Implement
>> the new variant which can give an accurate answer for whichever device
>> the caller is actually interested in.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>
>> v3: New patch; now that the dev_iommu_ops() work has landed we can go
>>      straight to a proper implementation. Also s/dev/device/ to match
>>      the precedent of device_iommu_mapped() for the public API.
> 
> I'm a little worrited about a method with a parameter than can be
> NULL.

FWIW, the intent is that that's only temporary.

> Also usnic, vmd, and vdpa really want to use your new
> device_iommu_capable as they check based on a device.  Just VFIO
> is special as usual..

Indeed, I have those patches in my stack already, I'm just waiting for 
this to land before I think about posting them. Once the DMA ownership 
series lands in parallel, VFIO can also get converted and 
iommu_capable() goes away entirely. At that point I have a patch for the 
Arm SMMU drivers to start actually using the new device argument, but 
Jason's new proposal now puts a twist on that...

On reflection, there's no real need for the internal method to change in 
lock-step with the external interface. I've no objection to holding off 
on adding that new parameter until it's reliably useful, and indeed now 
that I'm looking at it outside the context of the entire cleanup 
mission, that does sound like the right thing to do anyway :)

(also it turns out I need to respin this patch regardless since I 
generated it from the wrong point in my branch, where iommu_present() 
was already gone from the context in iommu.h...)

Cheers,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
