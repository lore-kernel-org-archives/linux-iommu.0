Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4792DC433EF
	for <iommu@archiver.kernel.org>; Fri,  4 Mar 2022 10:37:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1FC360881;
	Fri,  4 Mar 2022 10:37:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pRym_Kf3c4na; Fri,  4 Mar 2022 10:37:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8F6E360B5B;
	Fri,  4 Mar 2022 10:37:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D8ACC0012;
	Fri,  4 Mar 2022 10:37:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2721C000B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 10:37:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C746340439
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 10:37:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2Dn2TIaUK26g for <iommu@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 10:37:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8A209409FD
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 10:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646390228; x=1677926228;
 h=message-id:date:mime-version:cc:to:references:from:
 subject:in-reply-to:content-transfer-encoding;
 bh=vm/Jm/gvPkxhNPuewlN7ptScdBE5PmucbsV3QDz1jqk=;
 b=GNGuWCwRPdW6rKgA9/w+SabLbl9vlURfU4s6rdsc4SVZxpC676pGb6Yp
 uBvvCJE3tq4xY6vqIB8oQ7NhpmNQcJIpF5WaZe/f61Co4oFV7Avvu74gV
 vuCxB2r+vCB7x8TwT/4CkmJV3IdF5VU3i9pUpnf0zaT4HCNSZ1BfHBHm0
 vhW6RJ747CWIkmY++Nkws+g0scgI/c0x3amFyPkcFyX1AhasT1aXTqH4p
 HCEqtQU/kOrw1iXJXsXqKJf5NIJ/+ivALcyk9OsTWTAE8IitQdJQw9Vz+
 I4QEUAzDymbpPdydpIfKq3DSnCfekkkQhbMNrpdq9R+kHzlwV1Qm6aO9r Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="253679633"
X-IronPort-AV: E=Sophos;i="5.90,154,1643702400"; d="scan'208";a="253679633"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2022 02:37:07 -0800
X-IronPort-AV: E=Sophos;i="5.90,154,1643702400"; d="scan'208";a="508947720"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.209.31])
 ([10.254.209.31])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2022 02:37:04 -0800
Message-ID: <9cceda23-aa8b-f088-5c0b-1a0168e98ade@linux.intel.com>
Date: Fri, 4 Mar 2022 18:37:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>
References: <20220301020159.633356-1-baolu.lu@linux.intel.com>
 <YiHdvx6nMQRsL74S@8bytes.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 00/12] [PULL REQUEST] Intel IOMMU updates for Linux v5.18
In-Reply-To: <YiHdvx6nMQRsL74S@8bytes.org>
Cc: YueHaibing <yuehaibing@huawei.com>, Marco Bonelli <marco@mebeim.net>,
 iommu@lists.linux-foundation.org, Jason Gunthorpe <jgg@nvidia.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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

Hi Joerg,

On 2022/3/4 17:37, Joerg Roedel wrote:
> Hi Baolu,
> 
> On Tue, Mar 01, 2022 at 10:01:47AM +0800, Lu Baolu wrote:
>> This includes patches queued for v5.18. It includes:
>>
>>   - [PATCH 1 ~ 11] Various cleanups, no intentional functional changes.
>>   - [PATCH 12] Enable ATS in SoC-integrated devices listed in ACPI/SATC
>>                table.
>>
>> Please consider them for v5.18.
> 
> I would, but this shows non-trivial conflicts when I am applying it to
> the x86/vt-d branch. Can you please re-base the changes and send again?

It's based on this series:

https://lore.kernel.org/linux-iommu/Yhy%2FawfTOkQLLZ95@8bytes.org/

which contains some cleanup in vt-d driver as well.

If I re-base the series onto the vt-d branch, there will also be
conflicts when you merge the core and vt-d branch.

I can re-base anyway if you think that's not a problem.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
