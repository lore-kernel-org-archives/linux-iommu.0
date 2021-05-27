Return-Path: <SRS0=nChL=KW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF792C47089
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 11:19:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6667C610A6
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 11:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6667C610A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 314C4839BC;
	Thu, 27 May 2021 11:19:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Vy-sxrAGxuF; Thu, 27 May 2021 11:19:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id E69F483B3D;
	Thu, 27 May 2021 11:19:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7996C000D;
	Thu, 27 May 2021 11:19:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20DCBC0001
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 11:19:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0C5E740621
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 11:19:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V80jj1EQ9Ckz for <iommu@lists.linux-foundation.org>;
 Thu, 27 May 2021 11:19:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5496040551
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 11:19:53 +0000 (UTC)
IronPort-SDR: vue73SrN486WjyZtZ/WZKWwyBtH3ErDe4+ONuVR4uXYsqMf+j6S9W4A6Lrr+0cESwlGvBHbBBm
 6QlSYXM/Zz2w==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="223911666"
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; d="scan'208";a="223911666"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2021 04:19:51 -0700
IronPort-SDR: qMTkGzZlbxcJQp1hHnj4lt5KkFwi8OSDcNNqVYY6mdA7AMhA7fqtx+FsxZ1s/CXLMQhuctgHH8
 AAArSe7J8nQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; d="scan'208";a="631362727"
Received: from allen-box.sh.intel.com (HELO [10.239.159.105])
 ([10.239.159.105])
 by fmsmga006.fm.intel.com with ESMTP; 27 May 2021 04:19:46 -0700
Subject: Re: [RFC PATCH v3 8/8] vfio: Add nested IOPF support
To: Shenming Lu <lushenming@huawei.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20210409034420.1799-1-lushenming@huawei.com>
 <20210409034420.1799-9-lushenming@huawei.com>
 <20210518125808.345b812c.alex.williamson@redhat.com>
 <ea8c92a8-6e51-8be6-de19-d5e6f1d5527f@huawei.com>
 <83747758-ceb6-b498-8d95-609fdd0d763b@huawei.com>
 <20210524161129.085503ad@x1.home.shazbot.org>
 <90b00e7d-7934-ee79-7643-e2949e2d3af4@huawei.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <9daf8877-a538-2d19-f548-b00ea6f127df@linux.intel.com>
Date: Thu, 27 May 2021 19:18:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <90b00e7d-7934-ee79-7643-e2949e2d3af4@huawei.com>
Content-Language: en-US
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, Cornelia Huck <cohuck@redhat.com>,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, linux-api@vger.kernel.org,
 wanghaibin.wang@huawei.com, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
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

Hi Shenming and Alex,

On 5/27/21 7:03 PM, Shenming Lu wrote:
>> I haven't fully read all the references, but who imposes the fact that
>> there's only one fault handler per device?  If type1 could register one
>> handler and the vfio-pci bus driver another for the other level, would
>> we need this path through vfio-core?
> If we could register more than one handler per device, things would become
> much more simple, and the path through vfio-core would not be needed.
> 
> Hi Baolu,
> Is there any restriction for having more than one handler per device?
> 

Currently, each device could only have one fault handler. But one device
might consume multiple page tables. From this point of view, it's more
reasonable to have one handler per page table.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
