Return-Path: <SRS0=28v9=7V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60A1C433E0
	for <iommu@archiver.kernel.org>; Mon,  8 Jun 2020 01:55:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76B982063A
	for <iommu@archiver.kernel.org>; Mon,  8 Jun 2020 01:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76B982063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5219485BD3;
	Mon,  8 Jun 2020 01:55:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iWJ3t7YzyDiw; Mon,  8 Jun 2020 01:55:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AC5B0854CC;
	Mon,  8 Jun 2020 01:55:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 870B9C07FF;
	Mon,  8 Jun 2020 01:55:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 633E0C016F
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 01:54:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5F59285A1D
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 01:54:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HLOD3UvfdbIq for <iommu@lists.linux-foundation.org>;
 Mon,  8 Jun 2020 01:54:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7780D866FC
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 01:54:58 +0000 (UTC)
IronPort-SDR: SEyDMYfpFup2ICVA5qMdAEHbp6zTDM7OTgSVG0G5DylUmy8UqFQmsfafOruZQyvCvDlYoZb37M
 YeHGlB7hHccA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2020 18:54:57 -0700
IronPort-SDR: eGgx29V6/mGhV4quDChJ1q7EOPCwEM2ZGozBumO+2Pq6Gkp36lihZV1XF20/kKgyJe0cy6H7J/
 p0+xKG2tnyYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,486,1583222400"; d="scan'208";a="295297451"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 07 Jun 2020 18:54:53 -0700
Subject: Re: [PATCH V4 3/3] iommu: Document usage of
 "/sys/kernel/iommu_groups/<grp_id>/type" file
To: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
 iommu@lists.linux-foundation.org
References: <cover.1591290586.git.sai.praneeth.prakhya@intel.com>
 <24102f22824b26cf4fa6ec1c84d176110b21c574.1591290586.git.sai.praneeth.prakhya@intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <41050628-4dd2-c31b-e870-36a40c5d9c7b@linux.intel.com>
Date: Mon, 8 Jun 2020 09:50:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <24102f22824b26cf4fa6ec1c84d176110b21c574.1591290586.git.sai.praneeth.prakhya@intel.com>
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

On 6/5/20 9:32 AM, Sai Praneeth Prakhya wrote:
> The default domain type of an iommu group can be changed by writing to
> "/sys/kernel/iommu_groups/<grp_id>/type" file. Hence, document it's usage
> and more importantly spell out its limitations.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> Cc: Sohil Mehta <sohil.mehta@intel.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> ---
>   .../ABI/testing/sysfs-kernel-iommu_groups     | 30 +++++++++++++++++++
>   1 file changed, 30 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-kernel-iommu_groups b/Documentation/ABI/testing/sysfs-kernel-iommu_groups
> index 017f5bc3920c..a498daffeb0c 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-iommu_groups
> +++ b/Documentation/ABI/testing/sysfs-kernel-iommu_groups
> @@ -33,3 +33,33 @@ Description:    In case an RMRR is used only by graphics or USB devices
>   		it is now exposed as "direct-relaxable" instead of "direct".
>   		In device assignment use case, for instance, those RMRR
>   		are considered to be relaxable and safe.
> +
> +What:		/sys/kernel/iommu_groups/<grp_id>/type
> +Date:		June 2020
> +KernelVersion:	v5.8
> +Contact:	Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> +Description:	Let the user know the type of default domain in use by iommu
> +		for this group. A privileged user could request kernel to change
> +		the group type by writing to this file. Presently, only three
> +		types are supported
> +		1. DMA: All the DMA transactions from the device in this group
> +			are translated by the iommu.
> +		2. identity: All the DMA transactions from the device in this
> +			     group are *not* translated by the iommu.
> +		3. auto: Change to the type the device was booted with. When the
> +			 user reads the file he would never see "auto". This is
> +			 just a write only value.
> +		Note:
> +		-----
> +		A group type could be modified only when
> +		1. The group has *only* one device
> +		2. The device in the group is not bound to any device driver.
> +		   So, the user must first unbind the appropriate driver and
> +		   then change the default domain type.
> +		Caution:
> +		--------
> +		Unbinding a device driver will take away the driver's control
> +		over the device and if done on devices that host root file
> +		system could lead to catastrophic effects (the user might
> +		need to reboot the machine to get it to normal state). So, it's
> +		expected that the user understands what he is doing.
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
