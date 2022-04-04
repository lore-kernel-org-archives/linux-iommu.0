Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8EAC433EF
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 05:44:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 56BD04156A;
	Mon,  4 Apr 2022 05:44:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oNsbYyLjReIW; Mon,  4 Apr 2022 05:43:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0A55E40915;
	Mon,  4 Apr 2022 05:43:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC95FC002C;
	Mon,  4 Apr 2022 05:43:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A292EC0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 05:43:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 79DB840917
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 05:43:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LADZeIHSqXrH for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 05:43:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8C49A40915
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 05:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649051036; x=1680587036;
 h=message-id:date:mime-version:cc:to:references:from:
 subject:in-reply-to:content-transfer-encoding;
 bh=yqOnayDDkq7B2kSo3PZODYxA79khTRkXoKtuKeni4h0=;
 b=N/xU+jWelqcVzHwjIE9paMdmOPEBdFGhFecEuKiJtsu91vZpgCZKGZbD
 XDYZCa3Kl0t6ByMOemt/HZFU/8qJEN4maseCi91bu8jTOCpqDkG3CIc5n
 fFoqqjjSV9lcalm2eZgoLoB5tkB5nsS0Sao00R2VWtsr/19fvcwVitT+D
 sZqW9Aeh2GsELjq/ie343C/R7sCaEMvg+nXeOXE3ZWlz5RthxSEMvdz/h
 0pJwvRaH6MiguUVK7CYOiiQqPC0fCIoyA0sOAgjHFiOSFYuat07ct7cvj
 0UqEp2nhadh3x0SsVdPbGrj7e3W6ABqAXvFawpKMLGlEKRgdYSXnFvbqg g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="323617851"
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; d="scan'208";a="323617851"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2022 22:43:55 -0700
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; d="scan'208";a="548531610"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.214.140])
 ([10.254.214.140])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2022 22:43:52 -0700
Message-ID: <6ebd4f9b-5824-9489-43c3-7810963ec918@linux.intel.com>
Date: Mon, 4 Apr 2022 13:43:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52760F455B3319789BAB1E0E8C1E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220329114259.GB1716663@nvidia.com>
 <BN9PR11MB5276239993592FF808726EF68C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220330115820.GE1716663@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH RFC v2 02/11] iommu: Add iommu_group_singleton_lockdown()
In-Reply-To: <20220330115820.GE1716663@nvidia.com>
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Robin Murphy <robin.murphy@arm.com>
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

On 2022/3/30 19:58, Jason Gunthorpe wrote:
>>> Testing the group size is inherently the wrong test to make.
>> What is your suggestion then?
> Add a flag to the group that positively indicates the group can never
> have more than one member, even after hot plug. eg because it is
> impossible due to ACS, or lack of bridges, and so on.

The check method seems to be bus specific. For platform devices, perhaps
this kind of information should be retrieved from firmware interfaces
like APCI or DT.

 From this point of view, would it be simpler and more reasonable for the
device driver to do such check? After all, it is the device driver that
decides whether to provide SVA services to the application via uacce.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
