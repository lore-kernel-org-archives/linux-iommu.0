Return-Path: <SRS0=9w/B=G7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB90C433DB
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 02:36:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4459464DD1
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 02:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4459464DD1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C13598647F;
	Thu, 28 Jan 2021 02:36:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QqY8ELFnOBgw; Thu, 28 Jan 2021 02:36:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 336C18459A;
	Thu, 28 Jan 2021 02:36:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1133DC08A1;
	Thu, 28 Jan 2021 02:36:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C6DEC013A
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 02:36:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 51CAB86475
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 02:36:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EfYve667xkkz for <iommu@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 02:36:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A353F8459A
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 02:36:51 +0000 (UTC)
IronPort-SDR: al+Jy0kbrZ557RLvWOyGcqE59rVT26NwD9I4FBLiSqVacF13Lb/Pd7dxjIHqLRHlXneX84nLgS
 N014rTBCo3fw==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="167844574"
X-IronPort-AV: E=Sophos;i="5.79,381,1602572400"; d="scan'208";a="167844574"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2021 18:36:50 -0800
IronPort-SDR: nLsQGZK3msC0fQVBJzf/FNZGTEAGEiC6noIqWvPeeEo1+quCqcQ/nd6F5GJoZpS3ZQpDlV3VmN
 sCKm9hT2TiLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,381,1602572400"; d="scan'208";a="403312109"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 27 Jan 2021 18:36:47 -0800
Subject: Re: [PATCH RFC 0/9] Possible set of VT-d optimizations
To: Chuck Lever <chuck.lever@oracle.com>
References: <161177711359.1311.417185373365934204.stgit@manet.1015granger.net>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <29d59058-67be-b6f1-9a93-147d0dd4503e@linux.intel.com>
Date: Thu, 28 Jan 2021 10:28:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <161177711359.1311.417185373365934204.stgit@manet.1015granger.net>
Content-Language: en-US
Cc: isaacm@codeaurora.org, robin.murphy@arm.com,
 iommu@lists.linux-foundation.org, will@kernel.org
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

Hi Chuck,

On 1/28/21 4:00 AM, Chuck Lever wrote:
> Hi-
> 
> This collection of patches seems to get the best throughtput results
> so far. The NFS WRITE result is fully restored, and the NFS READ
> result is very close to fully restored.

Very glad to see this. Thanks!

Can you please add below link if you have a next version?

https://lore.kernel.org/linux-iommu/D81314ED-5673-44A6-B597-090E3CB83EB0@oracle.com/

It helps people to understand what regression you have seen.

Best regards,
baolu

> 
> 	Children see throughput for 12 initial writers  = 5008474.03 kB/sec
> 	Parent sees throughput for 12 initial writers   = 4996927.80 kB/sec
> 	Min throughput per process                      = 416956.88 kB/sec
> 	Max throughput per process                      = 417910.22 kB/sec
> 	Avg throughput per process                      = 417372.84 kB/sec
> 	Min xfer                                        = 1046272.00 kB
> 	CPU Utilization: Wall time    2.515    CPU time    1.996    CPU utilization  79.37 %
> 
> 
> 	Children see throughput for 12 rewriters        = 5020584.59 kB/sec
> 	Parent sees throughput for 12 rewriters         = 5012539.29 kB/sec
> 	Min throughput per process                      = 417799.00 kB/sec
> 	Max throughput per process                      = 419082.22 kB/sec
> 	Avg throughput per process                      = 418382.05 kB/sec
> 	Min xfer                                        = 1046528.00 kB
> 	CPU utilization: Wall time    2.507    CPU time    2.024    CPU utilization  80.73 %
> 
> 
> 	Children see throughput for 12 readers          = 5805484.25 kB/sec
> 	Parent sees throughput for 12 readers           = 5799535.68 kB/sec
> 	Min throughput per process                      = 482888.16 kB/sec
> 	Max throughput per process                      = 484444.16 kB/sec
> 	Avg throughput per process                      = 483790.35 kB/sec
> 	Min xfer                                        = 1045760.00 kB
> 	CPU utilization: Wall time    2.167    CPU time    1.964    CPU utilization  90.63 %
> 
> 
> 	Children see throughput for 12 re-readers       = 5812227.16 kB/sec
> 	Parent sees throughput for 12 re-readers        = 5803793.06 kB/sec
> 	Min throughput per process                      = 483242.97 kB/sec
> 	Max throughput per process                      = 485724.41 kB/sec
> 	Avg throughput per process                      = 484352.26 kB/sec
> 	Min xfer                                        = 1043456.00 kB
> 	CPU utilization: Wall time    2.161    CPU time    1.976    CPU utilization  91.45 %
> 
> I've included a simple-minded implementation of a map_sg op for
> the Intel IOMMU. This is nothing more than a copy of the loop in
> __iommu_map_sg() with the call to __iommu_map() replaced with a
> call to intel_iommu_map().
> 
> ---
> 
> Chuck Lever (1):
>        iommu/vt-d: Introduce map_sg() for Intel IOMMUs
> 
> Isaac J. Manjarres (5):
>        iommu/io-pgtable: Introduce map_sg() as a page table op
>        iommu/io-pgtable-arm: Hook up map_sg()
>        iommu/io-pgtable-arm-v7s: Hook up map_sg()
>        iommu: Introduce map_sg() as an IOMMU op for IOMMU drivers
>        iommu/arm-smmu: Hook up map_sg()
> 
> Lu Baolu (1):
>        iommu/vt-d: Add iotlb_sync_map callback
> 
> Yong Wu (2):
>        iommu: Move iotlb_sync_map out from __iommu_map
>        iommu: Add iova and size as parameters in iotlb_sync_map
> 
> 
>   drivers/iommu/arm/arm-smmu/arm-smmu.c |  19 ++++
>   drivers/iommu/intel/iommu.c           | 131 ++++++++++++++++++++------
>   drivers/iommu/io-pgtable-arm-v7s.c    |  90 ++++++++++++++++++
>   drivers/iommu/io-pgtable-arm.c        |  86 +++++++++++++++++
>   drivers/iommu/iommu.c                 |  47 +++++++--
>   drivers/iommu/tegra-gart.c            |   7 +-
>   include/linux/iommu.h                 |  16 +++-
>   7 files changed, 353 insertions(+), 43 deletions(-)
> 
> --
> Chuck Lever
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
