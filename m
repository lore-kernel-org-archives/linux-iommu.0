Return-Path: <SRS0=ta7q=7L=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2287FC433E0
	for <iommu@archiver.kernel.org>; Fri, 29 May 2020 01:55:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B37E2075F
	for <iommu@archiver.kernel.org>; Fri, 29 May 2020 01:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B37E2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 51D748923C;
	Fri, 29 May 2020 01:55:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oJug23+hPS+d; Fri, 29 May 2020 01:55:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6A5FA89224;
	Fri, 29 May 2020 01:55:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32246C07FF;
	Fri, 29 May 2020 01:55:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9711AC016F
 for <iommu@lists.linux-foundation.org>; Fri, 29 May 2020 01:55:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 87ABC203E3
 for <iommu@lists.linux-foundation.org>; Fri, 29 May 2020 01:55:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z26n8fVkWLv2 for <iommu@lists.linux-foundation.org>;
 Fri, 29 May 2020 01:55:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 9CDC020381
 for <iommu@lists.linux-foundation.org>; Fri, 29 May 2020 01:55:45 +0000 (UTC)
IronPort-SDR: i50UQe0XbfTGjGCFaTRSb2dmQKONpmDFz0Ds80eee5+Ti8pQWzlCgp4ZH7zvVTbOho5cFAlGzL
 UrmyJ2HkOVLQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2020 18:55:43 -0700
IronPort-SDR: jIYkuuKdhIMPCTEU86TTq4FToGavent5+5l//HG4pI+XKCk5w4NfFiyfG4DorfRX2uz4eIgcSy
 9SQ0a/olv9Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,447,1583222400"; d="scan'208";a="292209492"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 28 May 2020 18:55:41 -0700
Subject: Re: [PATCH V3 0/3] iommu: Add support to change default domain of an
 iommu
To: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
 iommu@lists.linux-foundation.org
References: <cover.1590686413.git.sai.praneeth.prakhya@intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <c863a340-906e-5040-19e7-aec5136c2a45@linux.intel.com>
Date: Fri, 29 May 2020 09:51:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <cover.1590686413.git.sai.praneeth.prakhya@intel.com>
Content-Language: en-US
Cc: Ashok Raj <ashok.raj@intel.com>, Will Deacon <will.deacon@arm.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

Hi Sai,

On 5/29/20 3:23 AM, Sai Praneeth Prakhya wrote:
> Presently, the default domain of a iommu group is allocated during boot time and
> it cannot be changed later. So, the device would typically be either in identity
> (pass_through) mode or the device would be in DMA mode as long as the system is
> up and running. There is no way to change the default domain type dynamically
> i.e. after booting, a device cannot switch between identity mode and DMA mode.
> 
> Assume a use case wherein the privileged user would want to use the device in
> pass-through mode when the device is used for host so that it would be high
> performing. Presently, this is not supported. Hence add support to change the
> default domain of an iommu group dynamically.
> 
> Support this by writing to a sysfs file, namely
> "/sys/kernel/iommu_groups/<grp_id>/type".

The email subject

[PATCH V3 0/3] iommu: Add support to change default domain of an iommu

probably should be changed to

[PATCH V3 0/3] iommu: Add support to change default domain of an iommu
group

Best regards,
baolu

> 
> Testing:
> --------
> Tested by dynamically changing storage device (nvme) from
> 1. identity mode to DMA and making sure file transfer works
> 2. DMA mode to identity mode and making sure file transfer works
> Tested only for intel_iommu/vt-d. Would appreciate if someone could test on AMD
> and ARM based machines.
> 
> Based on iommu maintainer's 'next' branch.
> 
> Changes from V2:
> ----------------
> 1. Change the logic of updating default domain from V2 because
>     ops->probe_finalize() could be used to update dma_ops.
> 2. Drop 1st and 2nd patch of V2 series because they are no longer needed on
>     iommu maintainer's 'next' branch.
> 3. Limit this feature to iommu groups with only one device.
> 4. Hold device_lock and group mutex until the default domain is changed.
> 
> Changes from V1:
> ----------------
> 1. V1 patch set wasn't updating dma_ops for some vendors (Eg: AMD), hence,
>     change the logic of updating default domain as below (because adding a device
>     to iommu_group automatically updates dma_ops)
>     a. Allocate a new domain
>     b. For every device in the group
> 	i. Remove the device from the group
> 	ii. Add the device back to the group
>     c. Free previous domain
> 2. Drop 1st patch of V1 (iommu/vt-d: Modify device_def_domain_type() to use at
>     runtime) because "iommu=pt" has no effect on this function anymore.
> 3. Added a patch to take/release lock while reading iommu_group->default_domain->type
>     because it can be changed any time by user.
> 4. Before changing default domain type of a group, check if the group is
>     directly assigned for user level access. If so, abort.
> 5. Sanitize return path (using ternary operator) in iommu_group_store_type()
> 6. Split 2nd patch of V1 (iommu: Add device_def_domain_type() call back function
>     to iommu_ops) into two patches such that iommu generic changes are now in 1st
>     patch of V2 and vt-d specific changes are in 2nd patch of V2.
> 7. Rename device_def_domain_type() to dev_def_domain_type()
> 8. Remove example from documentation
> 9. Change the value written to file "/sys/kernel/iommu_groups/<grp_id>/type"
>     from "dma" to "DMA".
> 
> Changes from RFC:
> -----------------
> 1. Added support for "auto" type, so that kernel selects one among identity or
>     dma mode.
> 2. Use "system_state" in device_def_domain_type() instead of an argument.
> 
> Sai Praneeth Prakhya (3):
>    iommu: Add support to change default domain of an iommu_group
>    iommu: Take lock before reading iommu_group default domain type
>    iommu: Document usage of "/sys/kernel/iommu_groups/<grp_id>/type" file
> 
>   .../ABI/testing/sysfs-kernel-iommu_groups     |  30 +++
>   drivers/iommu/iommu.c                         | 213 +++++++++++++++++-
>   2 files changed, 242 insertions(+), 1 deletion(-)
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: Sohil Mehta <sohil.mehta@intel.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
