Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC9CC433EF
	for <iommu@archiver.kernel.org>; Mon, 20 Jun 2022 00:35:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A568040A18;
	Mon, 20 Jun 2022 00:35:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A568040A18
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZCESJQTS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wK9ogkqznqtD; Mon, 20 Jun 2022 00:35:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8683D400D1;
	Mon, 20 Jun 2022 00:35:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8683D400D1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60ED7C0039;
	Mon, 20 Jun 2022 00:35:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9514CC002D
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jun 2022 00:35:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6F56460EBD
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jun 2022 00:35:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6F56460EBD
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ZCESJQTS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tqwHqgpUC4yS for <iommu@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 00:35:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D28D460DFE
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D28D460DFE
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jun 2022 00:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655685337; x=1687221337;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=xR5ggdMBlQy29n7xKM9geifq+2JbfrLe0YAM05RfwrY=;
 b=ZCESJQTSiRwmNRFXVBLGrFe95dzRlUNi41CzjzYz0eXe2r3/HTWCcc6d
 rT1Tfjj56pQ6F2OIzEXTXgBaTIaEGOtImk2giTmprK2f/i9stnURAhQ7S
 daBFr6YDKIbPAohUS3x0hwQ3b6zoNF3EWbYJN7rb0FQsrnU/fciT0FqHB
 cOT5ajofuoPSFqKSlIlcFXK/lZ0renxF8Z20gxjXDkt8zvuWjpr42wTjy
 AJVM1STAbTWzWwmMcBkKMURVFE9iMippIMTtc6iv9736sprA273ws7ekt
 J8abQ46ZsMuRxburRP03v1pldXEfydNO6Mn5XAQ9/0evKZHXDXaZV46Om A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="262808990"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; d="scan'208";a="262808990"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2022 17:35:37 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; d="scan'208";a="832865311"
Received: from lgao7-mobl2.ccr.corp.intel.com (HELO [10.255.31.74])
 ([10.255.31.74])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2022 17:35:33 -0700
Message-ID: <3e806c40-f190-b688-4b60-6fbf3520ff3e@linux.intel.com>
Date: Mon, 20 Jun 2022 08:35:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v8 05/11] iommu/vt-d: Add SVA domain support
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
References: <20220607014942.3954894-1-baolu.lu@linux.intel.com>
 <20220607014942.3954894-6-baolu.lu@linux.intel.com>
 <BN9PR11MB5276F6765461543CD9D2D0D98CAF9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276F6765461543CD9D2D0D98CAF9@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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

On 2022/6/17 15:47, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, June 7, 2022 9:50 AM
>>
>> +
>> +static const struct iommu_domain_ops intel_svm_domain_ops = {
>> +	.set_dev_pasid		= intel_svm_attach_dev_pasid,
>> +	.block_dev_pasid	= intel_svm_detach_dev_pasid,
>> +	.free			= intel_svm_domain_free,
>> +};
>> +
> 
> It's clearer to use set/block for intel callbacks.

Yes. That reads clearer.

--
Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
