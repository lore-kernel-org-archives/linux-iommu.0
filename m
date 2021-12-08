Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF21C433EF
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 02:44:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BEE9F83F57;
	Wed,  8 Dec 2021 02:44:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zAkZrCHf6LY9; Wed,  8 Dec 2021 02:44:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A091482A7F;
	Wed,  8 Dec 2021 02:44:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78683C002F;
	Wed,  8 Dec 2021 02:44:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B86CC0012
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 02:44:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E1791829B6
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 02:44:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eyF23tTajUtp for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 02:44:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A0748829B1
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 02:44:29 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="298538166"
X-IronPort-AV: E=Sophos;i="5.87,296,1631602800"; d="scan'208";a="298538166"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Dec 2021 18:44:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,296,1631602800"; d="scan'208";a="515586056"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 07 Dec 2021 18:44:23 -0800
Subject: Re: [RFC v16 1/9] iommu: Introduce attach/detach_pasid_table API
To: eric.auger@redhat.com, Joerg Roedel <joro@8bytes.org>
References: <20211027104428.1059740-1-eric.auger@redhat.com>
 <20211027104428.1059740-2-eric.auger@redhat.com>
 <Ya3qd6mT/DpceSm8@8bytes.org>
 <c7e26722-f78c-a93f-c425-63413aa33dde@redhat.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <e6733c59-ffcb-74d4-af26-273c1ae8ce68@linux.intel.com>
Date: Wed, 8 Dec 2021 10:44:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <c7e26722-f78c-a93f-c425-63413aa33dde@redhat.com>
Content-Language: en-US
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, lushenming@huawei.com,
 ashok.raj@intel.com, kvm@vger.kernel.org, jean-philippe@linaro.org,
 maz@kernel.org, robin.murphy@arm.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, vsethi@nvidia.com, vivek.gautam@arm.com,
 alex.williamson@redhat.com, Jason Gunthorpe <jgg@nvidia.com>,
 wangxingang5@huawei.com, zhangfei.gao@linaro.org, will@kernel.org,
 kvmarm@lists.cs.columbia.edu, eric.auger.pro@gmail.com
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

Hi Eric,

On 12/7/21 6:22 PM, Eric Auger wrote:
> On 12/6/21 11:48 AM, Joerg Roedel wrote:
>> On Wed, Oct 27, 2021 at 12:44:20PM +0200, Eric Auger wrote:
>>> Signed-off-by: Jean-Philippe Brucker<jean-philippe.brucker@arm.com>
>>> Signed-off-by: Liu, Yi L<yi.l.liu@linux.intel.com>
>>> Signed-off-by: Ashok Raj<ashok.raj@intel.com>
>>> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>
>>> Signed-off-by: Eric Auger<eric.auger@redhat.com>
>> This Signed-of-by chain looks dubious, you are the author but the last
>> one in the chain?
> The 1st RFC in Aug 2018
> (https://lists.cs.columbia.edu/pipermail/kvmarm/2018-August/032478.html)
> said this was a generalization of Jacob's patch
> 
> 
>    [PATCH v5 01/23] iommu: introduce bind_pasid_table API function
> 
> 
>    https://lists.linuxfoundation.org/pipermail/iommu/2018-May/027647.html
> 
> So indeed Jacob should be the author. I guess the multiple rebases got
> this eventually replaced at some point, which is not an excuse. Please
> forgive me for that.
> Now the original patch already had this list of SoB so I don't know if I
> shall simplify it.

As we have decided to move the nested mode (dual stages) implementation
onto the developing iommufd framework, what's the value of adding this
into iommu core?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
