Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0000C433EF
	for <iommu@archiver.kernel.org>; Tue,  8 Feb 2022 04:56:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4F72C81A18;
	Tue,  8 Feb 2022 04:56:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cIGhTCSKHLrb; Tue,  8 Feb 2022 04:56:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 48ACE81497;
	Tue,  8 Feb 2022 04:56:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C427C001A;
	Tue,  8 Feb 2022 04:56:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B61F5C000B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 04:56:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 96A1C40293
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 04:56:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3TLHuspN35Zl for <iommu@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 04:56:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 04ABE40266
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 04:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644296183; x=1675832183;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=4UHp9b3HCNBC/b2FQ4096XNfzyJtrjHTTByZZ54WrXk=;
 b=VXW5zvgOFjSMa/qpShm6jm5wZg+muek7FNc2TNuP4LZt59fJFPxQ5d8s
 KN/w19iJBldnbv4m2zP56rT1NsiSB+NPEFHGzhejK9LdjjK7TOOTcIqFj
 vxAi+cNeDiZvP5Y72ASXPvNFp4yszBbB31OoVUYj5KgFyT/2Iwcg+RVco
 yjqkvtygCXqYAxh2Xbr/Pyvz84gemcF65JrxCBalB0y6fA4tSUVGog+SD
 J4Ip8RqiuYE31FO+XbRktUH5OUWrUX4ITkiVLc+zSeSbw1wU7J1fEWcl8
 mgqAF6tR/La3+pdzCKf8k4yF5Ae51ddpMtj4OzmOKAqMmArB1bDCYT+40 Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="236277552"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; d="scan'208";a="236277552"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2022 20:56:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; d="scan'208";a="677988831"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2022 20:56:17 -0800
Message-ID: <6c650dcb-294b-975a-9836-05973f9ea852@linux.intel.com>
Date: Tue, 8 Feb 2022 12:55:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 09/10] iommu/vt-d: Refactor dmar_insert_one_dev_info()
Content-Language: en-US
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20220207064142.1092846-1-baolu.lu@linux.intel.com>
 <20220207064142.1092846-10-baolu.lu@linux.intel.com>
 <20220207102725.3ce9320d@jacob-builder>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220207102725.3ce9320d@jacob-builder>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

On 2/8/22 2:27 AM, Jacob Pan wrote:
> Hi BaoLu,

Hi Jacob,
> 
> On Mon,  7 Feb 2022 14:41:41 +0800, Lu Baolu <baolu.lu@linux.intel.com>
> wrote:
> 
>>   static void intel_iommu_release_device(struct device *dev)
>>   {
>> -	struct intel_iommu *iommu;
>> -
>> -	iommu = device_to_iommu(dev, NULL, NULL);
>> -	if (!iommu)
>> -		return;
>> -
>> -	dmar_remove_one_dev_info(dev);
>> +	struct device_domain_info *info = get_domain_info(dev);
>> +	unsigned long index = DEVI_IDX(info->segment, info->bus,
>> info->devfn);
>> +	xa_erase(&device_domain_array, index);
>> +	dev_iommu_priv_set(info->dev, NULL);
>>   	set_dma_ops(dev, NULL);
>> +	kfree(info);
> Now that info and sinfo are under RCU, should we use kfree_rcu?

Yes. We should use kfree_rcu.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
