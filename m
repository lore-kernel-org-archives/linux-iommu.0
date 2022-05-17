Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F3EC433F5
	for <iommu@archiver.kernel.org>; Tue, 17 May 2022 10:19:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0638060E31;
	Tue, 17 May 2022 10:19:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mTSB94klxk0S; Tue, 17 May 2022 10:19:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C2EA060B61;
	Tue, 17 May 2022 10:19:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B6EFC0039;
	Tue, 17 May 2022 10:19:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9632C002D
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 10:19:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B7E8C83E8F
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 10:19:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xcMXfhfA3LK4 for <iommu@lists.linux-foundation.org>;
 Tue, 17 May 2022 10:19:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8CAF483E3D
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 10:19:01 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07EF31042;
 Tue, 17 May 2022 03:19:01 -0700 (PDT)
Received: from [10.57.82.55] (unknown [10.57.82.55])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DADC3F66F;
 Tue, 17 May 2022 03:18:59 -0700 (PDT)
Message-ID: <0e9356ee-9ae0-fd6d-b4ba-b1f05d8ba144@arm.com>
Date: Tue, 17 May 2022 11:18:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] iommu/dma: Fix check for error return from
 iommu_map_sg_atomic()
Content-Language: en-GB
To: Niklas Schnelle <schnelle@linux.ibm.com>, Christoph Hellwig <hch@lst.de>
References: <20220513153948.310119-1-schnelle@linux.ibm.com>
 <20220517083657.GA16377@lst.de>
 <27ae8b9f8e61dce4b31a37622e98b1c57b21b104.camel@linux.ibm.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <27ae8b9f8e61dce4b31a37622e98b1c57b21b104.camel@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>
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

On 2022-05-17 11:17, Niklas Schnelle wrote:
> On Tue, 2022-05-17 at 10:36 +0200, Christoph Hellwig wrote:
>> On Fri, May 13, 2022 at 05:39:48PM +0200, Niklas Schnelle wrote:
>>> In __iommu_dma_alloc_noncontiguous() the value returned by
>>> iommu_map_sg_atomic() is checked for being smaller than size. Before
>>> commit ad8f36e4b6b1 ("iommu: return full error code from
>>> iommu_map_sg[_atomic]()") this simply checked if the requested size was
>>> successfully mapped.
>>>
>>> After that commit iommu_map_sg_atomic() may also return a negative
>>> error value. In principle this too would be covered by the existing
>>> check. There is one problem however, as size is of type size_t while the
>>> return type of iommu_map_sg_atomic() is now of type ssize_t the latter gets
>>> converted to size_t and negative error values end up as very large
>>> positive values making the check succeed. Fix this by making the return
>>> type visible with a local variable and add an explicit cast to ssize_t.
>>>
>>> Fixes: ad8f36e4b6b1 ("iommu: return full error code from iommu_map_sg[_atomic]()")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>>
>> I don't see what the point of the newly added local variable is here.
>> Just casting size should be all that is needed as far as I can tell.
> 
> No technical reason just found it easier to read and more descriptive.
> I'll sent a v2 with just the cast, it does simplify the commit message.

Note that this is already fixed upstream, though:

https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/commit/?h=core&id=a3884774d731f03d3a3dd4fb70ec2d9341ceb39d

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
