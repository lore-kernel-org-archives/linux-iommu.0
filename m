Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 428EFC4332F
	for <iommu@archiver.kernel.org>; Tue,  8 Feb 2022 04:28:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D25CE404F9;
	Tue,  8 Feb 2022 04:28:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EntAdBCtbJVK; Tue,  8 Feb 2022 04:28:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6AEC240275;
	Tue,  8 Feb 2022 04:28:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F6B3C001A;
	Tue,  8 Feb 2022 04:28:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2F56C000B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 04:28:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C421860BA4
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 04:28:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n8uJK6miLvxm for <iommu@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 04:28:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9586460597
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 04:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644294510; x=1675830510;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=zeTrwKWN4UMeNdimGUS+U9RmLrMA4K1Ld5W0Y65wdyQ=;
 b=ZlqUADTp+cEIRW9Ye9+Kkml64u/YfpkApoGkki5U03S6D6FXdH/3Z3Fy
 s/GK4AEwKy32TkKRBkBd+286kinkEGvVwHim3WPhZPvTwwxzGAsZ2VS59
 odSYfarawkbTGo3zbNw0QLnjLVguXo7RAjY1qoDMHxbJP/nwBG6G+r7rk
 cLzrfJ5kGk3yeYCnmx2BE1zDdC06QxxhgeEBxc3JFq0C8mIKayExyJTeM
 63ZJ8339jfeNA+y8G5WNc/8uhMfzCOiIFJ7YDPsAK61OtQ9VFMh0mdbfO
 9RH7p4Eo/k1uJZFeiIXCOdl06G+tAT/JZ+lHxUXwm5cM4gwz3o545pjWg w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="273395900"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; d="scan'208";a="273395900"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2022 20:28:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; d="scan'208";a="677985044"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2022 20:28:27 -0800
Message-ID: <771436d6-fda5-eeae-16ee-4cb760a056bb@linux.intel.com>
Date: Tue, 8 Feb 2022 12:27:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 01/10] iommu/vt-d: Move DMAR specific helpers into
 dmar.c
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
References: <20220207064142.1092846-1-baolu.lu@linux.intel.com>
 <20220207064142.1092846-2-baolu.lu@linux.intel.com>
 <20220207070849.GA23941@lst.de>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220207070849.GA23941@lst.de>
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

On 2/7/22 3:08 PM, Christoph Hellwig wrote:
>> --- a/include/linux/dmar.h
>> +++ b/include/linux/dmar.h
>> @@ -52,6 +52,32 @@ struct dmar_drhd_unit {
>>   	struct intel_iommu *iommu;
>>   };
>>   
>> +struct dmar_rmrr_unit {
> 
>> +struct dmar_atsr_unit {
> 
>> +struct dmar_satc_unit {
> 
> What about moving all code that is using the structures to dmar.c
> to keep the definitions local?
> 

It's difficult. References to these structures are scattered in iommu.c.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
