Return-Path: <SRS0=cHis=CZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942FDC43461
	for <iommu@archiver.kernel.org>; Wed, 16 Sep 2020 01:52:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A9C120BED
	for <iommu@archiver.kernel.org>; Wed, 16 Sep 2020 01:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A9C120BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DA6B686C2B;
	Wed, 16 Sep 2020 01:52:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XB1aZrH7ecfO; Wed, 16 Sep 2020 01:52:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 23C9A86BCB;
	Wed, 16 Sep 2020 01:52:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0632FC0864;
	Wed, 16 Sep 2020 01:52:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F078BC0051
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 01:52:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DAE8186957
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 01:52:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IdB5wD5Coh9d for <iommu@lists.linux-foundation.org>;
 Wed, 16 Sep 2020 01:52:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3AC1886949
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 01:52:47 +0000 (UTC)
IronPort-SDR: nw0XcDjrZf5vkJLKf5Or078nD8mOcDEioOeQI4ELAaFUvW8DJj7tzh0xOb0q+1AzqOUZq3XSBd
 UdoeBo28rrQA==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="244217851"
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; d="scan'208";a="244217851"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2020 18:52:46 -0700
IronPort-SDR: 1R/NaYdPsO3TrrR1z78pfO9jQWIFtldu73K8T0iaNzIRTFYl7QoOYpEdXMPim1jBUmRyOhoFz2
 i0WzoOOOdiNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; d="scan'208";a="409394276"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga001.fm.intel.com with ESMTP; 15 Sep 2020 18:52:42 -0700
Subject: Re: [PATCH v7 00/16] vfio: expose virtual Shared Virtual Addressing
 to VMs
To: "Jacob Pan (Jun)" <jacob.jun.pan@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20200914163354.GG904879@nvidia.com>
 <20200914105857.3f88a271@x1.home> <20200914174121.GI904879@nvidia.com>
 <20200914122328.0a262a7b@x1.home> <20200914190057.GM904879@nvidia.com>
 <20200914224438.GA65940@otc-nc-03> <20200915113341.GW904879@nvidia.com>
 <20200915181154.GA70770@otc-nc-03> <20200915184510.GB1573713@nvidia.com>
 <20200915150851.76436ca1@jacob-builder> <20200915235126.GK1573713@nvidia.com>
 <20200915171319.00003f59@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <9dd60896-0d3c-6d46-cf26-9195df78210f@linux.intel.com>
Date: Wed, 16 Sep 2020 09:46:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200915171319.00003f59@linux.intel.com>
Content-Language: en-US
Cc: yi.y.sun@intel.com, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 kevin.tian@intel.com, "Raj, Ashok" <ashok.raj@intel.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, stefanha@gmail.com,
 Jason Wang <jasowang@redhat.com>, jun.j.tian@intel.com,
 Alex Williamson <alex.williamson@redhat.com>, iommu@lists.linux-foundation.org,
 hao.wu@intel.com
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

On 9/16/20 8:22 AM, Jacob Pan (Jun) wrote:
>> If user space wants to bind page tables, create the PASID with
>> /dev/sva, use ioctls there to setup the page table the way it wants,
>> then pass the now configured PASID to a driver that can use it.
>>
> Are we talking about bare metal SVA? If so, I don't see the need for
> userspace to know there is a PASID. All user space need is that my
> current mm is bound to a device by the driver. So it can be a one-step
> process for user instead of two.
> 
>> Driver does not do page table binding. Do not duplicate all the
>> control plane uAPI in every driver.
>>
>> PASID managment and binding is seperated from the driver(s) that are
>> using the PASID.
>>
> Why separate? Drivers need to be involved in PASID life cycle
> management. For example, when tearing down a PASID, the driver needs to
> stop DMA, IOMMU driver needs to unbind, etc. If driver is the control
> point, then things are just in order. I am referring to bare metal SVA.
> 
> For guest SVA, I agree that binding is separate from PASID allocation.
> Could you review this doc. in terms of life cycle?
> https://lkml.org/lkml/2020/8/22/13
> 
> My point is that /dev/sda has no value for bare metal SVA, we are just
> talking about if guest SVA UAPIs can be consolidated. Or am I missing
> something?
> 

Not only bare metal SVA, but also subdevice passthrough (Intel Scalable
IOV and ARM SubStream ID) also consumes PASID which has nothing to do
with user space, hence the /dev/sva is unsuited.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
