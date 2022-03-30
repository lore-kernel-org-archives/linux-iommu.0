Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C5BC433EF
	for <iommu@archiver.kernel.org>; Wed, 30 Mar 2022 11:58:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 79E0A40897;
	Wed, 30 Mar 2022 11:58:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rLjOK27hb2Jr; Wed, 30 Mar 2022 11:58:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 289E3410B9;
	Wed, 30 Mar 2022 11:58:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0A81C001D;
	Wed, 30 Mar 2022 11:58:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5FA7EC0012
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 11:58:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 40A61611ED
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 11:58:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3NHWEmjNg8dq for <iommu@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 11:58:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 227FE60C16
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 11:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1648641484; x=1680177484;
 h=message-id:date:mime-version:cc:to:references:from:
 subject:in-reply-to:content-transfer-encoding;
 bh=i6d3OM34X008YLrBdwkzSuCTCJAwJAXcn3nAL1SIlvQ=;
 b=ZY8wP35zCgRuGkvMJqgM7D1h4b1tLvKI72IlqXeX+huQ96qu99prfav0
 BrSE0dE66fvvQg5zWEWggtKhLayk8dRxDKE3sHzGtdN4/pe/NkyVWYP3u
 IfCpkHHo5x0tENSFWQ8K7oJgO17kkCBr4IvGJ8wrAm5BQ92NohRzMdwhY
 SCCFvQFmeMgYKntsGcvU+Cf09SEt6l1lEVm4lMrA0pwAVWPhcmKuVVnlH
 bkjLP31gYoIC9tqDHxS4TJb5lyaxOUfvSo4Ya3U3pzegHYRh28PPniV8r
 9VuTMfk61EIqtxdx5YYalRy7xCCmmZYJWekpizH6AUiYNq2o2hkFrcTxT g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="241679357"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; d="scan'208";a="241679357"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2022 04:58:03 -0700
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; d="scan'208";a="565505227"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.120])
 ([10.254.215.120])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2022 04:57:59 -0700
Message-ID: <f52d0412-a88c-6c07-1b40-ff866b288641@linux.intel.com>
Date: Wed, 30 Mar 2022 19:57:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52760F455B3319789BAB1E0E8C1E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220329114259.GB1716663@nvidia.com>
 <BN9PR11MB5276239993592FF808726EF68C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH RFC v2 02/11] iommu: Add iommu_group_singleton_lockdown()
In-Reply-To: <BN9PR11MB5276239993592FF808726EF68C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
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

Hi Kevin,

On 2022/3/30 14:50, Tian, Kevin wrote:
>> ie if we have a singleton group that doesn't have ACS and someone
>> hotplugs in another device on a bridge, then our SVA is completely
>> broken and we get data corruption.
> Can we capture that in iommu_probe_device() when identifying
> the group which the probed device will be added to has already been
> locked down for SVA? i.e. make iommu_group_singleton_lockdown()
> in this patch to lock down the fact of singleton group instead of
> the fact of singleton driver...
> 

The iommu_probe_device() is called in the bus notifier callback. It has
no way to stop the probe of the device. Unless we could add a direct
call in the device probe path of the driver core?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
