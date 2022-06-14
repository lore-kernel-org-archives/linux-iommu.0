Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB9FC433EF
	for <iommu@archiver.kernel.org>; Tue, 14 Jun 2022 04:48:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C0DB760A7B;
	Tue, 14 Jun 2022 04:48:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vc2xmCGTfOFF; Tue, 14 Jun 2022 04:48:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A6EB660A9B;
	Tue, 14 Jun 2022 04:48:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 729BEC0039;
	Tue, 14 Jun 2022 04:48:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8238C002D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 04:48:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8F2A760EEC
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 04:48:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 50X642MXT7XF for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 04:48:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1F0D560ED6
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 04:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655182091; x=1686718091;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=WNnlhhRpKdqwqyAN58id52IIA5QPWLuUwmueWv7fjlE=;
 b=dIcj7AO+KBouO2lpquv0Qu9ExWiDWPwPEE5LaHt80NY1+FlVYoIoWvfz
 Ag25gInj+E+rtDvWH9tIV4H1y6a1c9QCrdgIOwFhuOi8YBSRI2Mp5zFSa
 4MDW4jxvMnyUagIAWtbUGGccAXhW39J2qPRA6PTgaRjxg6VSkE2hj3Yxy
 m5JRKvlRDhBvVW2uISS1uV0V5VGWfpD2OW4K6bPXDK273qYAuwVEbbuS1
 JqAw8NWgJg8V9bWx+8ZRYFDSAi1YMkbA6E37sRD59AOuEL9fJgl3M9Kqz
 TIOvFj76+KgSewLF1rBC2ZxyEvEkbACpcLhTFEtlXw2g7e0XhQqGlcjc2 g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="277280245"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; d="scan'208";a="277280245"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2022 21:48:10 -0700
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; d="scan'208";a="910765884"
Received: from gren5-mobl1.ccr.corp.intel.com (HELO [10.255.29.39])
 ([10.255.29.39])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2022 21:48:08 -0700
Message-ID: <2d2a52db-70a8-788e-fedc-197789caa145@linux.intel.com>
Date: Tue, 14 Jun 2022 12:48:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/1] iommu/vt-d: Add set_dev_pasid callbacks for default
 domain
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20220614034411.1634238-1-baolu.lu@linux.intel.com>
 <DM4PR11MB5278EBE8FA26185D91ACCD118CAA9@DM4PR11MB5278.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <DM4PR11MB5278EBE8FA26185D91ACCD118CAA9@DM4PR11MB5278.namprd11.prod.outlook.com>
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

On 2022/6/14 12:02, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, June 14, 2022 11:44 AM
>>
>> This allows the upper layers to set a domain to a PASID of a device
>> if the PASID feature is supported by the IOMMU hardware. The typical
>> use cases are, for example, kernel DMA with PASID and hardware
>> assisted mediated device drivers.
>>
> 
> why is it not part of the series for those use cases? There is no consumer
> of added callbacks in this patch...

It could be. I just wanted to maintain the integrity of Intel IOMMU
driver implementation.

> 
>> +/* PCI domain-subdevice relationship */
>> +struct subdev_domain_info {
>> +	struct list_head link_domain;	/* link to domain siblings */
>> +	struct device *dev;		/* physical device derived from */
>> +	ioasid_t pasid;			/* PASID on physical device */
>> +};
>> +
> 
> It's not subdev. Just dev+pasid in iommu's context.

How about struct device_pasid_info?

Best regards,
baolu

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
