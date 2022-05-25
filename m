Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0EF8C433F5
	for <iommu@archiver.kernel.org>; Wed, 25 May 2022 02:18:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A1E484061;
	Wed, 25 May 2022 02:18:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4DDBWU69w53V; Wed, 25 May 2022 02:18:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5904184177;
	Wed, 25 May 2022 02:18:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 230BCC0032;
	Wed, 25 May 2022 02:18:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ADAA9C002D
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 02:18:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A9DC741686
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 02:18:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BhtZWGWj7QKH for <iommu@lists.linux-foundation.org>;
 Wed, 25 May 2022 02:18:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AD31C415BA
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 02:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653445104; x=1684981104;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=h3XPzqnp3vKIn+De9Ti6cInP3d6FFD+A7MOLgnLxZgU=;
 b=ZiMmD8DVEJnxlxtbHGKNHQB5UzabaErx+s+gsXvWuwurDBsD5xeRaFwC
 SnkBBAXXRLX9ZiyqHN0zUH1ADljVCJn4aYa+kLypkEj8YYF2Q0guo5rkh
 m76ajdZZ27Zi0cy+5xWkXzAOuW80+svyNzTLkxhnmvtzLNIDt6p+6utIv
 y2n9f+RXPtf7yAGtkZh8IOUUWPcbqMGlkTKXfJZTyInOt+tbU5fv3gmBJ
 mD0nk5RAJvJvSij4sWHuxeFWjZO9/AHlkcHyoX1mKd9VjFFMPGCUHHlVh
 rgj0U35B5Y/6nNQRar7olQLNLtRp2074zc9skHSCv7ZzuJYC3uPzyR9uP A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="273692783"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; d="scan'208";a="273692783"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2022 19:18:23 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; d="scan'208";a="601605960"
Received: from jwang96-mobl.ccr.corp.intel.com (HELO [10.255.29.139])
 ([10.255.29.139])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2022 19:18:17 -0700
Message-ID: <8b4b22d7-3d56-d9b7-cfef-3479001c7cf4@linux.intel.com>
Date: Wed, 25 May 2022 10:18:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v7 03/10] iommu/sva: Add iommu_sva_domain support
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-4-baolu.lu@linux.intel.com>
 <316981d6-6b40-9e2a-09d3-b0d6f8687247@linux.intel.com>
 <BN9PR11MB5276D2DFFBFB4C57FA3854798CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276D2DFFBFB4C57FA3854798CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
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

On 2022/5/24 17:44, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Monday, May 23, 2022 3:13 PM
>>> @@ -254,6 +259,7 @@ struct iommu_ops {
>>>    	int (*def_domain_type)(struct device *dev);
>>>
>>>    	const struct iommu_domain_ops *default_domain_ops;
>>> +	const struct iommu_domain_ops *sva_domain_ops;
>>
>> Per Joerg's comment in anther thread,
>>
>> https://lore.kernel.org/linux-iommu/YodVJ7ervpIdWfg+@8bytes.org/
>>
>> adding a sva_domain_ops here is not the right way to go.
>>
>> If no objection, I will make the sva domain go through the
>> generic domain_alloc/free() callbacks in the next version.
>>
> 
> suppose it's just back to what v1-v6 did which all registered the ops
> in domain_alloc() callback?

Yes.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
