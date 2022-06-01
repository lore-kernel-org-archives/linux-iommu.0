Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390BBC433F5
	for <iommu@archiver.kernel.org>; Wed,  1 Jun 2022 10:38:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E45EC60EF5;
	Wed,  1 Jun 2022 10:38:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HBuNpklidSBs; Wed,  1 Jun 2022 10:38:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C1E8E60E9B;
	Wed,  1 Jun 2022 10:38:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A324C0032;
	Wed,  1 Jun 2022 10:38:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 163C7C002D
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 10:38:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EAD71416D7
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 10:38:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YE7uAido79We for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 10:38:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3233940902
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 10:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654079930; x=1685615930;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=mtwSjzvzSsj5uNAepvv6xKBLP1QaTB74LPqp4GVeXMY=;
 b=Tt7Lrpj7nqxbOA0fABAQkAH5lyHI9ejimF9eFyB95dQyCY+rQMXPy5V6
 jjsX0c22fZ0XX1NolAAzuPTC6Lr4t3ka44hPg+gf9NIt/s1ovTTmynZTB
 8TwGWk0/7D2b81NFerBZEVUSJ/2fRkUe5dE/NulcRx5uctTlMRT82saPN
 Jo6UIu9+juELrfZYfkZMGyrhVyHYvAOvvI2+yJ3/0j4jmTcwS0pouCqlW
 CzjePf8mRksSIePhDIH5qnvXR79Hv97ZXqgD7VQVB6XQINn8bFM34tIfU
 d0R33KB4e2UyIeyIGGISv1SumcKhNqXdKjV9+YRdO0xemM9I+cGNJXqub A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="275554175"
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; d="scan'208";a="275554175"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2022 03:38:49 -0700
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; d="scan'208";a="707001500"
Received: from hej1-mobl.ccr.corp.intel.com (HELO [10.255.28.123])
 ([10.255.28.123])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2022 03:38:46 -0700
Message-ID: <369bf961-d5e5-998f-542d-f90bc4c6cb28@linux.intel.com>
Date: Wed, 1 Jun 2022 18:38:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 06/12] iommu/vt-d: Acquiring lock in domain ID allocation
 helpers
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
 <20220527063019.3112905-7-baolu.lu@linux.intel.com>
 <BN9PR11MB52760F17D3B9359EB4BB2B7B8CDF9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52760F17D3B9359EB4BB2B7B8CDF9@BN9PR11MB5276.namprd11.prod.outlook.com>
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

Hi Kevin,

Thank you for the comments.

On 2022/6/1 17:09, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Friday, May 27, 2022 2:30 PM
>>
>> The iommu->lock is used to protect the per-IOMMU domain ID resource.
>> Move the spinlock acquisition/release into the helpers where domain
>> IDs are allocated and freed. The device_domain_lock is irrelevant to
>> domain ID resources, remove its assertion as well.
> while moving the lock you also replace spin_lock_irqsave() with spin_lock().
> It'd be cleaner to just do movement here and then replace all _irqsave()
> in patch 8.

Yeah, that will be clearer.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
