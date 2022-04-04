Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9738C433F5
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 05:55:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6DC9982503;
	Mon,  4 Apr 2022 05:55:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HucpqSwu0sqY; Mon,  4 Apr 2022 05:55:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 659B382B94;
	Mon,  4 Apr 2022 05:55:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30784C002C;
	Mon,  4 Apr 2022 05:55:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B232C0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 05:55:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0365D404C7
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 05:55:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zyjAsPzjHlkB for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 05:55:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6792840142
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 05:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649051732; x=1680587732;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=VRzHUmWn6xSVl9VxnZQQsCjifYYpTLqDX0N+7W19r24=;
 b=Mr/1b8B743QBaHN+Dif0YH7Q8MiPkZBkd7o1bwt3baplIt2k4/kxOXNu
 dL5fd8g3NsEEJD6Fl8HJqzVs3Rs1o2uPjVLi/XReW9QjmJ4SUMl2ZRTOi
 7U4zq+kBTpBhrqaTk/E1RcW2aIFsyp6jP+1KXAopChr18nhdRPBXZOM7d
 ndvUbeiEcLEhQgDjzRq92C53/SsLbeShcOV7hM0oTgtLLfxY0ianVZPIy
 uwYTlHjfdGsf6MTO1RcgI/oDGMHVUR6A5dOw+zYRCpaIgInS5Ar6xQI2w
 exPXFOY6Kt1ElCGa68EBThzihHZenMtYaGAJ11rVga7LkTG5kSPIwjH2A w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="242585667"
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; d="scan'208";a="242585667"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2022 22:55:31 -0700
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; d="scan'208";a="548533670"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.214.140])
 ([10.254.214.140])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2022 22:55:28 -0700
Message-ID: <9be015a3-c436-5829-b117-e0a70bc29954@linux.intel.com>
Date: Mon, 4 Apr 2022 13:55:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RFC v2 08/11] iommu/sva: Use attach/detach_pasid_dev in
 SVA interfaces
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Jacob Pan <jacob.jun.pan@intel.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-9-baolu.lu@linux.intel.com>
 <20220331135922.6c677117@jacob-builder> <20220331222630.GI2120790@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220331222630.GI2120790@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>
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

On 2022/4/1 6:26, Jason Gunthorpe wrote:
> On Thu, Mar 31, 2022 at 01:59:22PM -0700, Jacob Pan wrote:
> 
>>> +	handle->dev = dev;
>>> +	handle->domain = domain;
>>> +	handle->pasid = mm->pasid;
>> why do we need to store pasid here? Conceptually, pasid is per sva domain
>> not per bind. You can get it from handle->domain->sva_cookie.
> That is a mistake - SVA needs to follow the general PASID design - the
> domain does not encode the PASID, the PASID comes from the device

You are right. We should not store any pasid information in the domain.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
