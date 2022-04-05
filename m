Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B5FC433F5
	for <iommu@archiver.kernel.org>; Tue,  5 Apr 2022 06:12:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AADE040467;
	Tue,  5 Apr 2022 06:12:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A3pN7rSoKuqo; Tue,  5 Apr 2022 06:12:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7A0DD400CE;
	Tue,  5 Apr 2022 06:12:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46EE3C002C;
	Tue,  5 Apr 2022 06:12:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32E4AC0012
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 06:12:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 291AC4091E
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 06:12:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9d1S2xmyXbr9 for <iommu@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 06:12:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CE62E40918
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 06:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649139168; x=1680675168;
 h=message-id:date:mime-version:cc:to:references:from:
 subject:in-reply-to:content-transfer-encoding;
 bh=OiuiIFuVfxEdjhgvAec/5+Kjr8IxCBzKKOhId+Or194=;
 b=nDzLaq8jWL3qa3AXf5Lhqh3cQZ+u5LjdK6Tkesh16cN46PmDnLwfJhgn
 tzEanR6UEo5DhsqHYnoYB+D5YWsSssDB1AFZgIE79m03HrNPJ1fHPsK3G
 K7bdHtK5VYa+8NLWrTm977vpYYOFOe8LMDGbiDCUr3FZs93rGO9FSG6nV
 EUzps+9h8hYwASiCEw22l+Dp+Hv+PeoPS7I2tQ4JqdWXFPhbDrlunJSe7
 pxXAiADgCj2yTcGRWW0V1g4RS+MqYEAOz7Avf5BMkxab+YLlaXPAOslXy
 KcLSw1R0bxhTWH3KfkM1Ubuazqg5Z1RGOD45P+xvYff+Odek1rCmNbd3t Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="260662669"
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; d="scan'208";a="260662669"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Apr 2022 23:12:47 -0700
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; d="scan'208";a="548932439"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.115])
 ([10.254.212.115])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Apr 2022 23:12:44 -0700
Message-ID: <5ca5d34a-2394-b8bd-837b-cd6bf3301989@linux.intel.com>
Date: Tue, 5 Apr 2022 14:12:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52760F455B3319789BAB1E0E8C1E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220329114259.GB1716663@nvidia.com>
 <BN9PR11MB5276239993592FF808726EF68C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220330115820.GE1716663@nvidia.com>
 <6ebd4f9b-5824-9489-43c3-7810963ec918@linux.intel.com>
 <20220404172403.GO2120790@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH RFC v2 02/11] iommu: Add iommu_group_singleton_lockdown()
In-Reply-To: <20220404172403.GO2120790@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Robin Murphy <robin.murphy@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Will Deacon <will@kernel.org>
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

On 2022/4/5 1:24, Jason Gunthorpe wrote:
> On Mon, Apr 04, 2022 at 01:43:49PM +0800, Lu Baolu wrote:
>> On 2022/3/30 19:58, Jason Gunthorpe wrote:
>>>>> Testing the group size is inherently the wrong test to make.
>>>> What is your suggestion then?
>>> Add a flag to the group that positively indicates the group can never
>>> have more than one member, even after hot plug. eg because it is
>>> impossible due to ACS, or lack of bridges, and so on.
>>
>> The check method seems to be bus specific. For platform devices, perhaps
>> this kind of information should be retrieved from firmware interfaces
>> like APCI or DT.
>>
>>  From this point of view, would it be simpler and more reasonable for the
>> device driver to do such check? After all, it is the device driver that
>> decides whether to provide SVA services to the application via uacce.
> 
> The check has to do with the interconnect, not the device - I don't
> see how a device driver would know any better.

I'm worried about how to support this group flag for devices that are
not connected to the system through PCI buses. If IOMMU can support
sva_bind() only when this flag is set, the SVA on many devices cannot
be supported. Or this flag is always set for non PCI devices by default?

> 
> Why do you bring up uacce? Nothing should need uacce to access SVA.

The uacce is irrelevant here.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
