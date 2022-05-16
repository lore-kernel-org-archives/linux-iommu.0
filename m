Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CD7C433F5
	for <iommu@archiver.kernel.org>; Mon, 16 May 2022 02:04:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B8E4B60A81;
	Mon, 16 May 2022 02:04:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O0eG6SCYqmyl; Mon, 16 May 2022 02:04:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9FB1E60AB3;
	Mon, 16 May 2022 02:04:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 724F2C0032;
	Mon, 16 May 2022 02:04:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2A5DC002D
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 02:04:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9212660AB3
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 02:04:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZIVOsifcSdRd for <iommu@lists.linux-foundation.org>;
 Mon, 16 May 2022 02:04:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 93C2960A81
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 02:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652666642; x=1684202642;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=mw8DJE8yvOSuw3spkKWsSAhd7sIYW0oNHvTKwxzir2Y=;
 b=SBVYEo60sJjtyeuGRCwaY/QejjBPjw8nI494gPTJz+oSmgVG6xYyOMx5
 +uFRt0hf7N4l9mfq43s0rShoUzTsXnIO4k9IF2cNIOuKVEHCK7brsmkLd
 jglOM27CFoyMJr8Ezfbsi0nVNyNjA+TPMgiMOVZAVr+yQ6S0+5y0BiaOr
 ZEmRCiNVIr65iA8aiOvOKjwM0DIN/35/BXcUUHqVJxLc8OIJnQGvOkq/R
 KqpunQq3bRaE8F3w97nYjp3TLPlcpFqKUe9OA1KB0n6wNlP3rTCh4e4w8
 ltBfaP4OcKa5y89xqYuoQEeXV3m15HXE5q98xvNgJUFFDWuEEL6Tjt/Qg w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10348"; a="270403585"
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; d="scan'208";a="270403585"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2022 19:04:01 -0700
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; d="scan'208";a="522254130"
Received: from yanjiepa-mobl.ccr.corp.intel.com (HELO [10.249.192.19])
 ([10.249.192.19])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2022 19:03:56 -0700
Message-ID: <90619325-ea39-410e-2e8b-a38895f0dabf@linux.intel.com>
Date: Mon, 16 May 2022 10:03:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v6 03/12] iommu: Add attach/detach_dev_pasid domain ops
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
 <20220510061738.2761430-4-baolu.lu@linux.intel.com>
 <20220510140238.GD49344@nvidia.com>
 <f56ea479-aa82-37ae-91c3-754816a4ed8b@linux.intel.com>
 <BN9PR11MB5276100AC9BBB7DE5CB800CF8CC89@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Yntrv+nq2t/IeVo2@myrica> <20220511120240.GY49344@nvidia.com>
 <Ynywqxo4P+aEeS6c@myrica> <20220512115101.GU49344@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220512115101.GU49344@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 "Raj, Ashok" <ashok.raj@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Vinod Koul <vkoul@kernel.org>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
 Will Deacon <will@kernel.org>
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

On 2022/5/12 19:51, Jason Gunthorpe wrote:
> On Thu, May 12, 2022 at 08:00:59AM +0100, Jean-Philippe Brucker wrote:
> 
>>> It is not "missing" it is just renamed to blocking_domain->ops->set_dev_pasid()
>>>
>>> The implementation of that function would be identical to
>>> detach_dev_pasid.
>>
>>    attach(dev, pasid, sva_domain)
>>    detach(dev, pasid, sva_domain)
>>
>> versus
>>
>>    set_dev_pasid(dev, pasid, sva_domain)
>>    set_dev_pasid(dev, pasid, blocking)
>>
>> we loose the information of the domain previously attached, and the SMMU
>> driver has to retrieve it to find the ASID corresponding to the mm.
> 
> It would be easy to have the old domain be an input as well - the core
> code knows it.

Thanks a lot for all suggestions. I have posted a follow-up series for
this:

https://lore.kernel.org/linux-iommu/20220516015759.2952771-1-baolu.lu@linux.intel.com/

Let's discuss this there.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
