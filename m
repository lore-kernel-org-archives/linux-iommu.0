Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A7C5C433EF
	for <iommu@archiver.kernel.org>; Wed,  1 Jun 2022 11:02:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BB634408C1;
	Wed,  1 Jun 2022 11:02:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XoN1H9TCp2VW; Wed,  1 Jun 2022 11:02:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A2BEB40127;
	Wed,  1 Jun 2022 11:02:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44E91C0032;
	Wed,  1 Jun 2022 11:02:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2B0DC002D
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 11:02:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7D64360AE2
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 11:02:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qJmmgDvgePvP for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 11:02:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D1FDC60AA3
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 11:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654081353; x=1685617353;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=wFH8T+zSg8Moq4RtO8mNRcBXgugvMhh+yaRgqFYUaWE=;
 b=av55fEiWF4YtILmZeBLvyzFmt/84fHFDeNLVq3XnjP+08u4sdK1H6vJY
 7/YY3/xs6ahDyteGKcwbIR+oKoKozf0EnoWvRX8dZycSQe3DdfKDxyAd7
 BIRh/L8iHxdK8tkFSKxB7mf1ZNThg/PJ6pUIGiEx7KWPEpGEb0nI0u8Fa
 SLHofj8MItpCB4EapMHUxj3asdUMwfWNzFoDxvf5u/snMIzgJdUZeNywc
 NtTWzvsTFsj/a/xIHRf5ki5G47E1KgzrzEyRZLhPTkOe183qUgetpNMNe
 JkKjB011+ZjUe5F6TdwNe1rzb3ueiNJeQ8Ms5rzUg3E8tV6SZvPlYlbcA Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="255422003"
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; d="scan'208";a="255422003"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2022 04:02:33 -0700
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; d="scan'208";a="707007893"
Received: from hej1-mobl.ccr.corp.intel.com (HELO [10.255.28.123])
 ([10.255.28.123])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2022 04:02:30 -0700
Message-ID: <0b0d9e4e-f3bb-e47d-20e5-bf380c79f7b4@linux.intel.com>
Date: Wed, 1 Jun 2022 19:02:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 09/12] iommu/vt-d: Check device list of domain in domain
 free path
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
 <20220527063019.3112905-10-baolu.lu@linux.intel.com>
 <BN9PR11MB5276C3D7134CCE64D88F6F048CDF9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276C3D7134CCE64D88F6F048CDF9@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: Will Deacon <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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

On 2022/6/1 17:28, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Friday, May 27, 2022 2:30 PM
>>
>> When the IOMMU domain is about to be freed, it should not be set on any
>> device. Instead of silently dealing with some bug cases, it's better to
>> trigger a warning to report and fix any potential bugs at the first time.
>>
> 
> 
>>   static void domain_exit(struct dmar_domain *domain)
>>   {
>> -
>> -	/* Remove associated devices and clear attached or cached domains
>> */
>> -	domain_remove_dev_info(domain);
>> +	if (WARN_ON(!list_empty(&domain->devices)))
>> +		return;
>>
> 
> warning is good but it doesn't mean the driver shouldn't deal with
> that situation to make it safer e.g. blocking DMA from all attached
> device...

I have ever thought the same thing. :-)

Blocking DMA from attached device should be done when setting blocking
domain to the device. It should not be part of freeing a domain.

Here, the caller asks the driver to free the domain, but the driver
finds that something is wrong. Therefore, it warns and returns directly.
The domain will still be there in use until the next set_domain().

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
