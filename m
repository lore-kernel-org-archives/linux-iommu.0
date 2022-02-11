Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92668C4332F
	for <iommu@archiver.kernel.org>; Fri, 11 Feb 2022 11:35:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0D5F661C1D;
	Fri, 11 Feb 2022 11:35:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VAk_YueeI0nA; Fri, 11 Feb 2022 11:35:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E693060E15;
	Fri, 11 Feb 2022 11:35:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC7F7C0011;
	Fri, 11 Feb 2022 11:35:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D09C6C000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Feb 2022 11:35:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B10396059C
 for <iommu@lists.linux-foundation.org>; Fri, 11 Feb 2022 11:35:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cXFoidi_uw2P for <iommu@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 11:35:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id D6AF060E15
 for <iommu@lists.linux-foundation.org>; Fri, 11 Feb 2022 11:35:18 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EE7911D4;
 Fri, 11 Feb 2022 03:35:18 -0800 (PST)
Received: from [10.57.70.89] (unknown [10.57.70.89])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72E0B3F73B;
 Fri, 11 Feb 2022 03:35:16 -0800 (PST)
Message-ID: <a0d3b1f7-986f-591d-2675-8ee753d2e7db@arm.com>
Date: Fri, 11 Feb 2022 11:35:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: Error when running fio against nvme-of rdma target (mlx5 driver)
Content-Language: en-GB
To: Martin Oliveira <Martin.Oliveira@eideticom.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
References: <MW3PR19MB42505C41C2BA3F425A5CB606E42D9@MW3PR19MB4250.namprd19.prod.outlook.com>
 <62fd851d-564e-e2f3-1a40-b594810d9f01@nvidia.com>
 <MW3PR19MB4250DFC4E2AEB8184299A4BBE42F9@MW3PR19MB4250.namprd19.prod.outlook.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <MW3PR19MB4250DFC4E2AEB8184299A4BBE42F9@MW3PR19MB4250.namprd19.prod.outlook.com>
Cc: Kelly Ursenbach <Kelly.Ursenbach@eideticom.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "Lee,
 Jason" <jasonlee@lanl.gov>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Logan Gunthorpe <Logan.Gunthorpe@eideticom.com>
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

On 2022-02-10 23:58, Martin Oliveira wrote:
> On 2/9/22 1:41 AM, Chaitanya Kulkarni wrote:
>> On 2/8/22 6:50 PM, Martin Oliveira wrote:
>>> Hello,
>>>
>>> We have been hitting an error when running IO over our nvme-of setup, using the mlx5 driver and we are wondering if anyone has seen anything similar/has any suggestions.
>>>
>>> Both initiator and target are AMD EPYC 7502 machines connected over RDMA using a Mellanox MT28908. Target has 12 NVMe SSDs which are exposed as a single NVMe fabrics device, one physical SSD per namespace.
>>>
>>
>> Thanks for reporting this, if you can bisect the problem on your setup
>> it will help others to help you better.
>>
>> -ck
> 
> Hi Chaitanya,
> 
> I went back to a kernel as old as 4.15 and the problem was still there, so I don't know of a good commit to start from.
> 
> I also learned that I can reproduce this with as little as 3 cards and I updated the firmware on the Mellanox cards to the latest version.
> 
> I'd be happy to try any tests if someone has any suggestions.

The IOMMU is probably your friend here - one thing that might be worth 
trying is capturing the iommu:map and iommu:unmap tracepoints to see if 
the address reported in subsequent IOMMU faults was previously mapped as 
a valid DMA address (be warned that there will likely be a *lot* of 
trace generated). With 5.13 or newer, booting with "iommu.forcedac=1" 
should also make it easier to tell real DMA IOVAs from rogue physical 
addresses or other nonsense, as real DMA addresses should then look more 
like 0xffff24d08000.

That could at least help narrow down whether it's some kind of 
use-after-free race or a completely bogus address creeping in somehow.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
