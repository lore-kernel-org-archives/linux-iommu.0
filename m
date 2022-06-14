Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F265EC433EF
	for <iommu@archiver.kernel.org>; Tue, 14 Jun 2022 06:13:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F29E823CF;
	Tue, 14 Jun 2022 06:13:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bUXY4xhnTuCb; Tue, 14 Jun 2022 06:13:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9A29C8193E;
	Tue, 14 Jun 2022 06:13:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F581C0039;
	Tue, 14 Jun 2022 06:13:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2423EC002D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 06:13:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 19C2F81D9F
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 06:13:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wwx_UWr111Vc for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 06:13:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 813198193E
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 06:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655187192; x=1686723192;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=IZRzfWpYvGVD0DwSCHu4cFNQN2SHmCQjRiubdBK1bSs=;
 b=CyZ6ErbK9PJKrE09geYmOJ6d0ICtrCfGiAbbGa6tMvdyBM/Iff6xPgc/
 9mOqKnTCxG4eEYpLesgIF5rNZ4JZxSzMBKeBWcJe+SqRZSyXDhtV+4NCl
 wCWRr4F5k+ERCTaDvtECTzvNlx0cBogEKqJE+9ek/n9l7tgWtNF3wjW20
 pYBOoNTrMMvahpSxXccnaQSLbvkxBrcvSF8R5ybuw2QH82LLQNu3i/2/K
 SYohRrXGarApP4rbH63PLcJfMyKNBtxKCptygv2QGDxcQ9+X7dwLfUSgu
 AoYz8zOy6agTFTUEya7oVXODY9jwf6w/F3UgV7RG+ljffJNdxHsW1lnlY Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="303924774"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; d="scan'208";a="303924774"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2022 23:13:11 -0700
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; d="scan'208";a="910803754"
Received: from gren5-mobl1.ccr.corp.intel.com (HELO [10.255.29.39])
 ([10.255.29.39])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2022 23:13:09 -0700
Message-ID: <3e2e6ee7-984f-254e-7a3e-e32d6256c8f2@linux.intel.com>
Date: Tue, 14 Jun 2022 14:13:07 +0800
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
 <2d2a52db-70a8-788e-fedc-197789caa145@linux.intel.com>
 <BN9PR11MB5276DF2C87451A1164A995FB8CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276DF2C87451A1164A995FB8CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On 2022/6/14 13:36, Tian, Kevin wrote:
>> From: Baolu Lu<baolu.lu@linux.intel.com>
>> Sent: Tuesday, June 14, 2022 12:48 PM
>>
>> On 2022/6/14 12:02, Tian, Kevin wrote:
>>>> From: Lu Baolu<baolu.lu@linux.intel.com>
>>>> Sent: Tuesday, June 14, 2022 11:44 AM
>>>>
>>>> This allows the upper layers to set a domain to a PASID of a device
>>>> if the PASID feature is supported by the IOMMU hardware. The typical
>>>> use cases are, for example, kernel DMA with PASID and hardware
>>>> assisted mediated device drivers.
>>>>
>>> why is it not part of the series for those use cases? There is no consumer
>>> of added callbacks in this patch...
>> It could be. I just wanted to maintain the integrity of Intel IOMMU
>> driver implementation.
> but let's not add dead code. and this patch is actually a right step
> simply from set_dev_pasid() p.o.v hence you should include in any
> series which first tries to use that interface.
> 

Yes, that's my intention. If it reviews well, we can include it in the
driver's implementation.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
