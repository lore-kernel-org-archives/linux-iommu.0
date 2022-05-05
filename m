Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB44FC4332F
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 06:26:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 344F541730;
	Thu,  5 May 2022 06:26:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bGrwxRUkCOQO; Thu,  5 May 2022 06:26:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D738641701;
	Thu,  5 May 2022 06:26:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A29F9C0039;
	Thu,  5 May 2022 06:26:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C37DEC0032
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 06:26:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ACD5883F86
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 06:26:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MDWbncOnmgPs for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 06:26:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6518883F85
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 06:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651731975; x=1683267975;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=XCojLW+9ezVCq192dbkCy99WssFI1eBwqcSpomU98EU=;
 b=kH0LLO0/1Rh4HnoIYo5qc2hLUyqXVtT3YN2IW+ZTl8qNeFGU3VkUbw6u
 riGDZMEQ+ich+JRcrrVb/Mn3PFf1gn/016AHR5o2zjnoGWravH3ildvx7
 sMUZHml/OdlNQqwQQxpyxB3v+7zygEUXLv1IM6vfMUYwTc8yLOYUf8sDK
 GABnydhOn+9fvkWbfj9JEL6/1ZX2bvOoBGr7XV7qD/vLE08LMvvmtsalZ
 Wt8nG5MN7r/xrItiw2m9EBg647SwMgKOvrOne6QQy6EAbd/MbW60ws8tw
 riSrYjBRz0rHxseCFbuzy2vmNY/Nqie4yCUFA9AXjrd8sATe67r1wTW0Z A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="293207415"
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; d="scan'208";a="293207415"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2022 23:25:49 -0700
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; d="scan'208";a="563092452"
Received: from minhaowa-mobl.ccr.corp.intel.com (HELO [10.255.30.75])
 ([10.255.30.75])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2022 23:25:45 -0700
Message-ID: <ab40853f-3a44-6bb8-21d4-c1f5464b030e@linux.intel.com>
Date: Thu, 5 May 2022 14:25:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 02/12] iommu: Add pasid_bits field in struct dev_iommu
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220502014842.991097-1-baolu.lu@linux.intel.com>
 <20220502014842.991097-3-baolu.lu@linux.intel.com> <YnFuLsvWcjjKBWNy@myrica>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YnFuLsvWcjjKBWNy@myrica>
Cc: Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Vinod Koul <vkoul@kernel.org>, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>
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

On 2022/5/4 02:02, Jean-Philippe Brucker wrote:
> On Mon, May 02, 2022 at 09:48:32AM +0800, Lu Baolu wrote:
>> Use this field to save the pasid/ssid bits that a device is able to
>> support with its IOMMU hardware. It is a generic attribute of a device
>> and lifting it into the per-device dev_iommu struct makes it possible
>> to allocate a PASID for device without calls into the IOMMU drivers.
>> Any iommu driver which suports PASID related features should set this
>> field before features are enabled on the devices.
>>
>> For initialization of this field in the VT-d driver, the
>> info->pasid_supported is only set for PCI devices. So the status is
>> that non-PCI SVA hasn't been supported yet. Setting this field only for
>> PCI devices has no functional change.
>>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> Reviewed-by: Jean-Philippe Brucker<jean-philippe@linaro.org>

Thank you! Very appreciated for reviewing my patches.

Best regards,
baolu

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
