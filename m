Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2460C433FE
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 23:52:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71E366138E
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 23:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 71E366138E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3294B40001;
	Wed, 29 Sep 2021 23:52:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nkXf3tzUAoPQ; Wed, 29 Sep 2021 23:52:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C266B400C7;
	Wed, 29 Sep 2021 23:52:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81A5FC0011;
	Wed, 29 Sep 2021 23:52:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 242C2C000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 23:52:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0A3B2400C7
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 23:52:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W4dWe6-hAU2J for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 23:52:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3837140001
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 23:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=EbaHldIfmljK2aAsHQqeoY1Qg/19dgw063FCWj78kIA=; b=BYOpvsO/6zfK/zmuM4LPBTGkEY
 IX+IV00ne55Vn0YfEDps7ZCSwEilHH8U02Q33wf4MlxPdQ0UWL6DzmjorF0O9tl0Jsm4uIASf2Ene
 aM4efeOMiejklMT3X3x4u5ceMHI9es5C0nZcATdnazTQGIO6GnDxU0gRZUpRLY04BYWJRwGKwIzlM
 MsiSqwPDnK66YxcCdj+o8uhP8jg1uNPzO6/t6Cb0JyUhdXEqKBgV0BT6H0WJz9/AKmbztTCYQsoOP
 zcbO+BgjsyCmu9TditfVdrlL1UcCemw3a1G6PSim8Gk2mjPDqAMmHRRC5zbBXFVy2p6sr5VqIlFuw
 E0w7Az4Q==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1mVjNK-0008VW-LI; Wed, 29 Sep 2021 17:52:35 -0600
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210928200216.GW3544071@ziepe.ca>
 <06d75fcb-ce8b-30a5-db36-b6c108460d3d@deltatee.com>
 <20210929232147.GD3544071@ziepe.ca>
 <93f56919-03ee-8326-10ee-8fbd9078b8e0@deltatee.com>
 <20210929233624.GG3544071@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <142badec-f6f5-e471-698e-8a386aae3c2b@deltatee.com>
Date: Wed, 29 Sep 2021 17:52:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210929233624.GG3544071@ziepe.ca>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: ckulkarnilinux@gmail.com, martin.oliveira@eideticom.com,
 robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org,
 jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net,
 dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch,
 willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com,
 christian.koenig@amd.com, dan.j.williams@intel.com, hch@lst.de,
 sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v3 00/20] Userspace P2PDMA with O_DIRECT NVMe devices
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-mm@kvack.org, Jason Ekstrand <jason@jlekstrand.net>,
 Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 John Hubbard <jhubbard@nvidia.com>, linux-block@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 2021-09-29 5:36 p.m., Jason Gunthorpe wrote:
> On Wed, Sep 29, 2021 at 05:28:38PM -0600, Logan Gunthorpe wrote:
>>
>>
>> On 2021-09-29 5:21 p.m., Jason Gunthorpe wrote:
>>> On Wed, Sep 29, 2021 at 03:50:02PM -0600, Logan Gunthorpe wrote:
>>>>
>>>>
>>>> On 2021-09-28 2:02 p.m., Jason Gunthorpe wrote:
>>>>> On Thu, Sep 16, 2021 at 05:40:40PM -0600, Logan Gunthorpe wrote:
>>>>>> Hi,
>>>>>>
>>>>>> This patchset continues my work to add userspace P2PDMA access using
>>>>>> O_DIRECT NVMe devices. My last posting[1] just included the first 13
>>>>>> patches in this series, but the early P2PDMA cleanup and map_sg error
>>>>>> changes from that series have been merged into v5.15-rc1. To address
>>>>>> concerns that that series did not add any new functionality, I've added
>>>>>> back the userspcae functionality from the original RFC[2] (but improved
>>>>>> based on the original feedback).
>>>>>
>>>>> I really think this is the best series yet, it really looks nice
>>>>> overall. I know the sg flag was a bit of a debate at the start, but it
>>>>> serves an undeniable purpose and the resulting standard DMA APIs 'just
>>>>> working' is really clean.
>>>>
>>>> Actually, so far, nobody has said anything negative about using the SG flag.
>>>>
>>>>> There is more possible here, we could also pass the new GUP flag in the
>>>>> ib_umem code..
>>>>
>>>> Yes, that would be very useful.
>>>
>>> You might actually prefer to do that then the bio changes to get the
>>> infrastructur merged as it seems less "core"
>>
>> I'm a little bit more concerned about my patch set growing too large.
>> It's already at 20 patches and I think I'll need to add a couple more
>> based on the feedback you've already provided. So I'm leaning toward
>> pushing more functionality as future work.
> 
> I mean you could postpone the three block related patches and use a
> single ib_umem patch instead as the consumer.

I think that's not a very compelling use case given the only provider of
these VMAs is an NVMe block device. My patch set enables a real world
use (copying data between NVMe devices P2P through the CMB with O_DIRECT).

Being able to read or write a CMB with RDMA and only RDMA is not very
compelling.

Logan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
