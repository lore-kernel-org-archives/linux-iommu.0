Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE70C433EF
	for <iommu@archiver.kernel.org>; Mon, 21 Feb 2022 04:03:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A997540018;
	Mon, 21 Feb 2022 04:03:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ipm3OdrtKZnq; Mon, 21 Feb 2022 04:03:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 69916400D7;
	Mon, 21 Feb 2022 04:03:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2FE8AC0033;
	Mon, 21 Feb 2022 04:03:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6E90C001A
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 04:03:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BD8A7607C9
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 04:03:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O1fZDweNxmb8 for <iommu@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 04:03:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 855C360087
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 04:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645416212; x=1676952212;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=a8s6oPn2OepoA76s//VWNsP4UZFDI+9oeHKC9k5AQGM=;
 b=M/HWzCybvLl4fVSsSHXzBFMOejqsHoIpnejBmbC63ebvvpFfRWaBfo0y
 RowkODqI9IL8q4lONkg5x3YmZgh/Cphv2ieXocCEjEEI0gnUg5lRKAoQI
 uw6tJdmJCwyC5V3xXqedLFwJbnogxO4uoKGafr5liQ0rNSLJzTiSzE8RA
 dzVKfDNrQ/bA0CAZz859yo2lCdIfqTIbYFCROhNEe46wud9vCSVT2sTkO
 sVNFz2Pd1V/kO8NuvcHnXRGuQ0y9WJmRC6Lf93PTa7t/R6S9OJvri7kHJ
 ek4OXwrdIwFfe6VyaXJBdaOHP7PQSj39JvjzqupVKD0156Ht4zuqWqWXB g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="249010546"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; d="scan'208";a="249010546"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2022 20:03:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; d="scan'208";a="683079024"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 20 Feb 2022 20:03:25 -0800
Message-ID: <97485ead-2570-2782-8766-9a4d8c4c8535@linux.intel.com>
Date: Mon, 21 Feb 2022 12:02:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 01/11] iommu: Add dma ownership management interfaces
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
References: <20220218005521.172832-1-baolu.lu@linux.intel.com>
 <20220218005521.172832-2-baolu.lu@linux.intel.com>
 <YhCc6dKyojInJe7u@infradead.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <YhCc6dKyojInJe7u@infradead.org>
Cc: kvm@vger.kernel.org, rafael@kernel.org, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Stuart Yoder <stuyoder@gmail.com>,
 Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>
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

On 2/19/22 3:31 PM, Christoph Hellwig wrote:
> The overall API and patch looks fine, but:
> 
>> + * iommu_group_dma_owner_claimed() - Query group dma ownership status
>> + * @group: The group.
>> + *
>> + * This provides status query on a given group. It is racey and only for
>> + * non-binding status reporting.
> 
> s/racey/racy/

Yes.

> 
>> + */
>> +bool iommu_group_dma_owner_claimed(struct iommu_group *group)
>> +{
>> +	unsigned int user;
>> +
>> +	mutex_lock(&group->mutex);
>> +	user = group->owner_cnt;
>> +	mutex_unlock(&group->mutex);
>> +
>> +	return user;
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
> 
> Still no no need for the lock here.

We've discussed this before. I tend to think that is right.

We don't lose anything with this lock held and it also follows the rule
that all accesses to the internal group structure must be done with the
group->mutex held.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
