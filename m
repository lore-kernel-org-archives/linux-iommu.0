Return-Path: <SRS0=1cKf=HA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C81C433DB
	for <iommu@archiver.kernel.org>; Fri, 29 Jan 2021 11:55:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7729D65062
	for <iommu@archiver.kernel.org>; Fri, 29 Jan 2021 11:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7729D65062
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D9C0786A5D;
	Fri, 29 Jan 2021 11:55:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gwbJQsJCDsrX; Fri, 29 Jan 2021 11:55:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 11C1586A02;
	Fri, 29 Jan 2021 11:55:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DCA20C0FA8;
	Fri, 29 Jan 2021 11:54:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 220FFC08A1
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 11:54:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1DD4387487
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 11:54:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3IOw0gt8Xxgu for <iommu@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 11:54:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2C95D87479
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 11:54:57 +0000 (UTC)
IronPort-SDR: 5YLBtqRZqdeHgYsOV2pPEFzWTGQiGJaIXsjuv3yTAFS7Yxh3g0rEwFV4+uBRRY2rwAKlcT3Q78
 unbeDWFWmvyg==
X-IronPort-AV: E=McAfee;i="6000,8403,9878"; a="179632812"
X-IronPort-AV: E=Sophos;i="5.79,385,1602572400"; d="scan'208";a="179632812"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jan 2021 03:54:56 -0800
IronPort-SDR: MHEClnE0vmlJigdcn/duzdrXyYSuLyZrnUN57VwOREBhoir90q66Tr3Zx+NdTaAP61ryHsTAEr
 OKDPoCJmfP5A==
X-IronPort-AV: E=Sophos;i="5.79,385,1602572400"; d="scan'208";a="389271550"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.255.29.47])
 ([10.255.29.47])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jan 2021 03:54:54 -0800
Subject: Re: [PATCH RFC 0/9] Possible set of VT-d optimizations
To: Chuck Lever <chuck.lever@oracle.com>, Robin Murphy <robin.murphy@arm.com>
References: <161177711359.1311.417185373365934204.stgit@manet.1015granger.net>
 <1c89a1c1-4a2b-841e-c88f-cd08598a6546@arm.com>
 <C8B06FC7-F426-4008-8A71-E61895368771@oracle.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <bc2e60cf-b08c-bced-aef0-5ecc470328c7@linux.intel.com>
Date: Fri, 29 Jan 2021 19:54:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <C8B06FC7-F426-4008-8A71-E61895368771@oracle.com>
Content-Language: en-US
Cc: "isaacm@codeaurora.org" <isaacm@codeaurora.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "will@kernel.org" <will@kernel.org>
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

On 2021/1/28 22:52, Chuck Lever wrote:
> 
> 
>> On Jan 28, 2021, at 8:59 AM, Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2021-01-27 20:00, Chuck Lever wrote:
>>> Hi-
>>> This collection of patches seems to get the best throughtput results
>>> so far. The NFS WRITE result is fully restored, and the NFS READ
>>> result is very close to fully restored.
>>> 	Children see throughput for 12 initial writers  = 5008474.03 kB/sec
>>> 	Parent sees throughput for 12 initial writers   = 4996927.80 kB/sec
>>> 	Min throughput per process                      = 416956.88 kB/sec
>>> 	Max throughput per process                      = 417910.22 kB/sec
>>> 	Avg throughput per process                      = 417372.84 kB/sec
>>> 	Min xfer                                        = 1046272.00 kB
>>> 	CPU Utilization: Wall time    2.515    CPU time    1.996    CPU utilization  79.37 %
>>> 	Children see throughput for 12 rewriters        = 5020584.59 kB/sec
>>> 	Parent sees throughput for 12 rewriters         = 5012539.29 kB/sec
>>> 	Min throughput per process                      = 417799.00 kB/sec
>>> 	Max throughput per process                      = 419082.22 kB/sec
>>> 	Avg throughput per process                      = 418382.05 kB/sec
>>> 	Min xfer                                        = 1046528.00 kB
>>> 	CPU utilization: Wall time    2.507    CPU time    2.024    CPU utilization  80.73 %
>>> 	Children see throughput for 12 readers          = 5805484.25 kB/sec
>>> 	Parent sees throughput for 12 readers           = 5799535.68 kB/sec
>>> 	Min throughput per process                      = 482888.16 kB/sec
>>> 	Max throughput per process                      = 484444.16 kB/sec
>>> 	Avg throughput per process                      = 483790.35 kB/sec
>>> 	Min xfer                                        = 1045760.00 kB
>>> 	CPU utilization: Wall time    2.167    CPU time    1.964    CPU utilization  90.63 %
>>> 	Children see throughput for 12 re-readers       = 5812227.16 kB/sec
>>> 	Parent sees throughput for 12 re-readers        = 5803793.06 kB/sec
>>> 	Min throughput per process                      = 483242.97 kB/sec
>>> 	Max throughput per process                      = 485724.41 kB/sec
>>> 	Avg throughput per process                      = 484352.26 kB/sec
>>> 	Min xfer                                        = 1043456.00 kB
>>> 	CPU utilization: Wall time    2.161    CPU time    1.976    CPU utilization  91.45 %
>>> I've included a simple-minded implementation of a map_sg op for
>>> the Intel IOMMU. This is nothing more than a copy of the loop in
>>> __iommu_map_sg() with the call to __iommu_map() replaced with a
>>> call to intel_iommu_map().
>>
>> ...which is the main reason I continue to strongly dislike patches #4-#9 (#3 definitely seems to makes sense either way, now that #1 and #2 are going to land). If a common operation is worth optimising anywhere, then it deserves optimising everywhere, so we end up with a dozen diverging copies of essentially the same code - particularly when the driver-specific functionality *is* already in the drivers, so what gets duplicated is solely the "generic" parts.
> 
> I don't disagree with that assessment, but I don't immediately see an
> alternative API arrangement that would be more successful in the short
> term. If 4/9 - 9/9 are not acceptable, then the responsible thing to
> do would be to revert:
> 
>   - 58a8bb39490d ("iommu/vt-d: Cleanup after converting to dma-iommu ops")
>   - c588072bba6b ("iommu/vt-d: Convert intel iommu driver to the iommu ops")
> 
> for v5.11, work out the proper API design, and then try the VT-d conversion
> again.

Probably we could introduce an iommu_ops->map/unmap_range() callback and
let the iommu driver to select "one call per page" map() or simply map a
range in a loop.

Best regards,
baolu

> 
> IMHO.
> 
> 
>> And if there's justification for pushing iommu_map_sg() entirely into drivers, then it's verging on self-contradictory not to do the same for iommu_map() and iommu_unmap(). Some IOMMU drivers - mainly intel-iommu, as it happens - are already implementing hacks around the "one call per page" interface being inherently inefficient, so the logical thing to do here is take a step back and reconsider the fundamental design of the whole map/unmap interface. Implementing hacks on top of hacks to make particular things faster on particular systems that particular people care about is not going to do us any favours in the long run.
>>
>> As it stands, I can easily see a weird anti-pattern emerging where people start adding code to fake up scatterlists in random drivers because they see dma_map_sg() performing paradoxically better than dma_map_page().
>>
>> Robin.
>>
>>> ---
>>> Chuck Lever (1):
>>>        iommu/vt-d: Introduce map_sg() for Intel IOMMUs
>>> Isaac J. Manjarres (5):
>>>        iommu/io-pgtable: Introduce map_sg() as a page table op
>>>        iommu/io-pgtable-arm: Hook up map_sg()
>>>        iommu/io-pgtable-arm-v7s: Hook up map_sg()
>>>        iommu: Introduce map_sg() as an IOMMU op for IOMMU drivers
>>>        iommu/arm-smmu: Hook up map_sg()
>>> Lu Baolu (1):
>>>        iommu/vt-d: Add iotlb_sync_map callback
>>> Yong Wu (2):
>>>        iommu: Move iotlb_sync_map out from __iommu_map
>>>        iommu: Add iova and size as parameters in iotlb_sync_map
>>>   drivers/iommu/arm/arm-smmu/arm-smmu.c |  19 ++++
>>>   drivers/iommu/intel/iommu.c           | 131 ++++++++++++++++++++------
>>>   drivers/iommu/io-pgtable-arm-v7s.c    |  90 ++++++++++++++++++
>>>   drivers/iommu/io-pgtable-arm.c        |  86 +++++++++++++++++
>>>   drivers/iommu/iommu.c                 |  47 +++++++--
>>>   drivers/iommu/tegra-gart.c            |   7 +-
>>>   include/linux/iommu.h                 |  16 +++-
>>>   7 files changed, 353 insertions(+), 43 deletions(-)
>>> --
>>> Chuck Lever
>>> _______________________________________________
>>> iommu mailing list
>>> iommu@lists.linux-foundation.org
>>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
> --
> Chuck Lever
> 
> 
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
