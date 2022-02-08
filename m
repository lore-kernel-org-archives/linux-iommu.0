Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E3ADC433EF
	for <iommu@archiver.kernel.org>; Tue,  8 Feb 2022 04:32:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B83660E8F;
	Tue,  8 Feb 2022 04:32:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id frzeRC-IcPnh; Tue,  8 Feb 2022 04:32:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2998460E50;
	Tue,  8 Feb 2022 04:32:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01D5FC001A;
	Tue,  8 Feb 2022 04:32:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0268FC000B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 04:32:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D585840500
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 04:32:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9Mu6Upjh-weS for <iommu@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 04:32:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 26461404F9
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 04:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644294764; x=1675830764;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=MaA6fWv9eHIr5rZu+J4Ln334/itdZkGgcCnY/wetP3I=;
 b=VPWM/FFLtRK/m4YUpjcJ76cHpYbKwJESrHGhumykieWD3ssfRpPE0Ht7
 3gK72XDB9HitWn/Mms9Qhw9K7Cnqdbj2ulM6wEC4+jjZMR/m9jvGUWMAU
 AgnPt9xPrzc+6NQpgDVDD6tCRUrCzUfbMCvbUJqBxkExyNS11IxqPBbIy
 omdzDIC0XsZp+kF50tfX9X1q/axrNwoAumCzYVVH50escRWLUUPD6h1tz
 IV7oETOwynTV2cwc55V230yHP0Iy1Npr5CK9DVKNWsaC9aGGOpPG6VX0V
 KBBNjxP0b/rlMEE+DnttOFQglWzbNoVSXYLJvrHABpx+W9DnTxDLh9jjI A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="246458241"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; d="scan'208";a="246458241"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2022 20:32:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; d="scan'208";a="677985804"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2022 20:32:41 -0800
Message-ID: <3d3b34a8-4f23-133a-9619-25c834f95cf5@linux.intel.com>
Date: Tue, 8 Feb 2022 12:31:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 06/10] iommu/vt-d: Remove DEFER_DEVICE_DOMAIN_INFO
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
References: <20220207064142.1092846-1-baolu.lu@linux.intel.com>
 <20220207064142.1092846-7-baolu.lu@linux.intel.com>
 <20220207071209.GF23941@lst.de>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220207071209.GF23941@lst.de>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>
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

On 2/7/22 3:12 PM, Christoph Hellwig wrote:
>>   struct device_domain_info *get_domain_info(struct device *dev)
>>   {
>> +	return dev_iommu_priv_get(dev);
>>   }
> 
> I'd remove this now pointles wrapper entirely.

Yes. Will do it.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
