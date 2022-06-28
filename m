Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB095C43334
	for <iommu@archiver.kernel.org>; Tue, 28 Jun 2022 12:18:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7B381813DF;
	Tue, 28 Jun 2022 12:18:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7B381813DF
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=czGrpXVN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VtjF9qI7qpBR; Tue, 28 Jun 2022 12:18:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4541482FA9;
	Tue, 28 Jun 2022 12:18:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4541482FA9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26054C0039;
	Tue, 28 Jun 2022 12:18:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB433C002D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 12:18:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 95A2E40A1E
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 12:18:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 95A2E40A1E
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=czGrpXVN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Sq3BahjwU5sC for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 12:18:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A5055404BD
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A5055404BD
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 12:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656418702; x=1687954702;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Xu+W3z9Vfv/K82AHMIeu/0YjAhTvZA+Ccl9JNUx64kI=;
 b=czGrpXVNwacjY6A3HFyMGIVH64Hw8Pubda4e6YTwUWqvmCVSbLJX/CVv
 BtDOHEaQhGRU/quLtotcB6pnrn3rNUGOk9foIn5YW60sDBHAZxUxTTuzv
 pJhuON1Y0CZzXURVflCNeiNoz9SUo2iqz4AkFNgO1qhHkSUeg9POml2sJ
 roRcWKx4+AHQfpej3MPkreg3ryCtAa3/8Kp36Sv4DeL2wg9m0japTRpvW
 +FqSQJ4LLL8yxN9W1yvc/AWZADZQl3qifz+mJO8cGMYMzAIM02300tHDL
 m8SWcb6OioLIjixrvK1+7scYlkoBAKElmBeO8Hyj5WU0i2ndhcSoEKNh7 Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="345720941"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; d="scan'208";a="345720941"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2022 05:18:21 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; d="scan'208";a="646891842"
Received: from ltang11-mobl1.ccr.corp.intel.com (HELO [10.249.169.64])
 ([10.249.169.64])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2022 05:18:17 -0700
Message-ID: <826513b6-15d3-902d-03c2-7f7e68a84095@linux.intel.com>
Date: Tue, 28 Jun 2022 20:18:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v9 10/11] iommu: Per-domain I/O page fault handling
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-11-baolu.lu@linux.intel.com>
 <BN9PR11MB52768181B0EB29DBCB11AEA68CB89@BN9PR11MB5276.namprd11.prod.outlook.com>
 <YrrNarTWvMydIDwQ@myrica>
 <BN9PR11MB527605AA0663E8BE592898FE8CB89@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527605AA0663E8BE592898FE8CB89@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: "Jiang, Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Robin Murphy <robin.murphy@arm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Vinod Koul <vkoul@kernel.org>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
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

On 2022/6/28 18:02, Tian, Kevin wrote:
>> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> Sent: Tuesday, June 28, 2022 5:44 PM
>>
>> On Tue, Jun 28, 2022 at 08:39:36AM +0000, Tian, Kevin wrote:
>>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>> Sent: Tuesday, June 21, 2022 10:44 PM
>>>>
>>>> Tweak the I/O page fault handling framework to route the page faults to
>>>> the domain and call the page fault handler retrieved from the domain.
>>>> This makes the I/O page fault handling framework possible to serve more
>>>> usage scenarios as long as they have an IOMMU domain and install a
>> page
>>>> fault handler in it. Some unused functions are also removed to avoid
>>>> dead code.
>>>>
>>>> The iommu_get_domain_for_dev_pasid() which retrieves attached
>> domain
>>>> for a {device, PASID} pair is used. It will be used by the page fault
>>>> handling framework which knows {device, PASID} reported from the
>> iommu
>>>> driver. We have a guarantee that the SVA domain doesn't go away during
>>>> IOPF handling, because unbind() waits for pending faults with
>>>> iopf_queue_flush_dev() before freeing the domain. Hence, there's no
>> need
>>>> to synchronize life cycle of the iommu domains between the unbind() and
>>>> the interrupt threads.
>>>
>>> I found iopf_queue_flush_dev() is only called in intel-iommu driver. Did
>>> I overlook anything?
>>
>> The SMMU driver will need it as well when we upstream PRI support.
>> Currently it only supports stall, and that requires the device driver to
>> flush all DMA including stalled transactions *before* calling unbind(), so
>> ne need for iopf_queue_flush_dev() in this case.
>>
> 
> then it makes sense. Probably Baolu can add this information in the
> commit msg so others with similar question can quickly get the
> point here.

Sure. Updated.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
