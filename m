Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C78C433EF
	for <iommu@archiver.kernel.org>; Tue, 28 Jun 2022 11:34:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 58A3460EB7;
	Tue, 28 Jun 2022 11:34:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 58A3460EB7
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NppW5tNI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SLbtfawr3MZH; Tue, 28 Jun 2022 11:34:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 18C4560E64;
	Tue, 28 Jun 2022 11:34:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 18C4560E64
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F11FC002D;
	Tue, 28 Jun 2022 11:34:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 118F1C002D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 11:34:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DF36A408EE
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 11:34:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DF36A408EE
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=NppW5tNI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tl-usVRT2WeR for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 11:34:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B1166408F2
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B1166408F2
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 11:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656416043; x=1687952043;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=WyQ7Lhg64UA7faLJ8umQR8gY+ay9xEU5cNZImGlhWOk=;
 b=NppW5tNIEjrAqLxqc25wLCwP4m124+S9yyHQmbITugqOOMg/L44y6wxS
 PObbhmkKt3SCSU2x0pXkJxx617E1s23Gb5A6q8Wr7tFu20eR0awWNp78C
 zIF6XmQMqCIVgHjgu91rWIg98Hu1UI1xK3l2C9rIfBZO7DJhSePotrD1L
 QTihzrphuIAhziibqAwsZlPXNuFdgrRsdcQkKsWTb5h2RC8doc2Zf+9W/
 Yjl5mSzFAIP4gNp1tbazhCCCuhs4pDYSJql1Ox8o6j1PnnBjKL8LvmPhd
 OaiFpmhsneF9UpFpVniJ3kmqD2IGlzhez/+lBA1eZDEpbsZf3YLoxlDxA w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="307196731"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; d="scan'208";a="307196731"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2022 04:34:03 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; d="scan'208";a="646877561"
Received: from ltang11-mobl1.ccr.corp.intel.com (HELO [10.249.169.64])
 ([10.249.169.64])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2022 04:33:59 -0700
Message-ID: <89130952-155c-38f0-3318-1c071562661f@linux.intel.com>
Date: Tue, 28 Jun 2022 19:33:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v9 04/11] iommu: Add sva iommu_domain support
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-5-baolu.lu@linux.intel.com>
 <BN9PR11MB5276FA1A1A8C20786D958C048CB99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <42825be5-e24c-0f95-f49d-5f50d608506d@linux.intel.com>
 <BN9PR11MB527679FF12B6D990A5E596A88CB89@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527679FF12B6D990A5E596A88CB89@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>
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

On 2022/6/28 16:50, Tian, Kevin wrote:
>> From: Baolu Lu<baolu.lu@linux.intel.com>
>> Sent: Tuesday, June 28, 2022 1:41 PM
>>>>    struct iommu_domain {
>>>>    	unsigned type;
>>>>    	const struct iommu_domain_ops *ops;
>>>>    	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
>>>> -	iommu_fault_handler_t handler;
>>>> -	void *handler_token;
>>>>    	struct iommu_domain_geometry geometry;
>>>>    	struct iommu_dma_cookie *iova_cookie;
>>>> +	union {
>>>> +		struct {	/* IOMMU_DOMAIN_DMA */
>>>> +			iommu_fault_handler_t handler;
>>>> +			void *handler_token;
>>>> +		};
>>> why is it DMA domain specific? What about unmanaged
>>> domain? Unrecoverable fault can happen on any type
>>> including SVA. Hence I think above should be domain type
>>> agnostic.
>> The report_iommu_fault() should be replaced by the new
>> iommu_report_device_fault(). Jean has already started this work.
>>
>> https://lore.kernel.org/linux-iommu/Yo4Nw9QyllT1RZbd@myrica/
>>
>> Currently this is only for DMA domains, hence Robin suggested to make it
>> exclude with the SVA domain things.
>>
>> https://lore.kernel.org/linux-iommu/f3170016-4d7f-e78e-db48-
>> 68305f683349@arm.com/
> Then it's worthy a comment that those two fields are for
> some legacy fault reporting stuff and DMA type only.

The iommu_fault and SVA fields are exclusive. The former is used for
unrecoverable DMA remapping faults, while the latter is only interested
in the recoverable page faults.

I will update the commit message with above explanation. Does this work
for you?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
