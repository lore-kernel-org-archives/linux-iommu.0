Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D88C433EF
	for <iommu@archiver.kernel.org>; Wed,  1 Jun 2022 06:39:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36211832B0;
	Wed,  1 Jun 2022 06:39:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9Jj1gczFmrpO; Wed,  1 Jun 2022 06:39:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 16FB18329E;
	Wed,  1 Jun 2022 06:39:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E55B3C0039;
	Wed,  1 Jun 2022 06:39:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51188C002D
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 06:39:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3F06441737
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 06:39:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HFzYY-xhFeXb for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 06:39:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2C13D41736
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 06:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654065562; x=1685601562;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=NTe1lvhDhuLR2ENfcohwPccU6QLRUxsLG1PgvvGRWbs=;
 b=Wd8KNNA0+R7JxsYFSwc2tIKde+pQDEn+vCPIK+LuSePPigAG6rWIWYyG
 ZrNmXoHQo9Fq/AmcESD1sHNqWzbmDsMPEDSNymOipGJvdSM7IWGuFNyia
 5q9v3pGVjsiLd/gNo7KawLhOGJJxFqdQKqvOrzIhQMdSRbKONUCwto2Ki
 y/fSsEiEvdfolyzPQ6nW9d/fd53kVqkkVD6lQPwpnBjmdajSwfOb9XOO8
 KI684BdNVXARCRLvIypl+HdGUEos5W3nfS1GvovuxFuWJLD5YonxbiBEa
 QEPEFplzwiXAGrjX6d0ZOyYbeyKHu3ofofk8r+SWLZX9FcsiEkiPxduCi A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="338536966"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; d="scan'208";a="338536966"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2022 23:39:21 -0700
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; d="scan'208";a="706925259"
Received: from hej1-mobl.ccr.corp.intel.com (HELO [10.255.28.123])
 ([10.255.28.123])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2022 23:39:16 -0700
Message-ID: <dafc1451-d3f9-150a-2d95-12bc4616f3bc@linux.intel.com>
Date: Wed, 1 Jun 2022 14:39:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 01/12] iommu/vt-d: Use iommu_get_domain_for_dev() in
 debugfs
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>
References: <20220530121412.GX1343366@nvidia.com>
 <42623a73-c288-1c0d-7021-93caff4ffb6f@linux.intel.com>
 <20220531131052.GD1343366@nvidia.com>
 <60318d83-e22f-f922-436f-6c31bce24d59@linux.intel.com>
 <20220531145301.GE1343366@nvidia.com>
 <a7d6d830-cb06-e0d7-0688-028f9af900e5@arm.com>
 <20220531151332.GF1343366@nvidia.com>
 <b66a2e3b-9adc-5150-fe00-d68b141b1c28@arm.com>
 <20220531162152.GH1343366@nvidia.com>
 <10f16c13-c50d-892c-a20d-979b2135c953@arm.com>
 <20220531185110.GJ1343366@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220531185110.GJ1343366@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Will Deacon <will@kernel.org>
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

On 2022/6/1 02:51, Jason Gunthorpe wrote:
>> Oh, I've spent the last couple of weeks hacking up horrible things
>> manipulating entries in init_mm, and never realised that that was actually
>> the special case. Oh well, live and learn.
> The init_mm is sort of different, it doesn't have zap in quite the
> same way, for example. I was talking about the typical process mm.
> 
> Anyhow, the right solution is to use RCU as I described before, Baolu
> do you want to try?

Yes, of course.

Your discussion with Robin gave me a lot of inspiration. Very
appreciated! I want to use a separate patch to solve this debugfs
problem, because it has exceeded the original intention of this series.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
