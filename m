Return-Path: <SRS0=kdPY=IP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0D7C433DB
	for <iommu@archiver.kernel.org>; Wed, 17 Mar 2021 03:12:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84D4A64EF3
	for <iommu@archiver.kernel.org>; Wed, 17 Mar 2021 03:12:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84D4A64EF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1969F4ECCC;
	Wed, 17 Mar 2021 03:12:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yEfBvgjR2G4b; Wed, 17 Mar 2021 03:12:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id A9F404ECAE;
	Wed, 17 Mar 2021 03:12:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84D19C000B;
	Wed, 17 Mar 2021 03:12:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6004BC000A
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 03:12:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5250B431DF
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 03:12:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5yROs1ttvFLV for <iommu@lists.linux-foundation.org>;
 Wed, 17 Mar 2021 03:12:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0B99041468
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 03:12:35 +0000 (UTC)
IronPort-SDR: SoFGm7B2Pdpr+UIq+jqQpinpE1EYXeyuZDK4zIKWb4mTs1Sz11uLhMHg0NirFmFMg0gBsLK+nq
 zI1675uZvWUA==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="176976284"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; d="scan'208";a="176976284"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2021 20:12:35 -0700
IronPort-SDR: FSv7+WVPIfSeBOm8IDU3guGi4HRgtprZGvblH9S2KmesztcKJG0kwooyKi/3v5SdkuRddznjkE
 4JWo7jkqjy5A==
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; d="scan'208";a="412475709"
Received: from yisun1-ubuntu.bj.intel.com (HELO yi.y.sun) ([10.238.156.116])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA256;
 16 Mar 2021 20:12:29 -0700
Date: Wed, 17 Mar 2021 11:06:44 +0800
From: Yi Sun <yi.y.sun@linux.intel.com>
To: Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v2 04/11] iommu/arm-smmu-v3: Split block descriptor when
 start dirty log
Message-ID: <20210317030644.GO28580@yi.y.sun>
References: <20210310090614.26668-1-zhukeqian1@huawei.com>
 <20210310090614.26668-5-zhukeqian1@huawei.com>
 <20210316091751.GN28580@yi.y.sun>
 <84cef87c-af82-8564-fc23-654042448d05@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <84cef87c-af82-8564-fc23-654042448d05@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: Mark Rutland <mark.rutland@arm.com>, jiangkunkun@huawei.com,
 Catalin Marinas <catalin.marinas@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Robin Murphy <robin.murphy@arm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, linux-kernel@vger.kernel.org,
 lushenming@huawei.com, iommu@lists.linux-foundation.org,
 James Morse <james.morse@arm.com>, Marc Zyngier <maz@kernel.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 21-03-16 19:39:47, Keqian Zhu wrote:
> Hi Yi,
> 
> On 2021/3/16 17:17, Yi Sun wrote:
> > On 21-03-10 17:06:07, Keqian Zhu wrote:
> >> From: jiangkunkun <jiangkunkun@huawei.com>
> >>
> >> Block descriptor is not a proper granule for dirty log tracking.
> >> Take an extreme example, if DMA writes one byte, under 1G mapping,
> >> the dirty amount reported to userspace is 1G, but under 4K mapping,
> >> the dirty amount is just 4K.
> >>
> >> This adds a new interface named start_dirty_log in iommu layer and
> >> arm smmuv3 implements it, which splits block descriptor to an span
> >> of page descriptors. Other types of IOMMU will perform architecture
> >> specific actions to start dirty log.
> >>
> >> To allow code reuse, the split_block operation is realized as an
> >> iommu_ops too. We flush all iotlbs after the whole procedure is
> >> completed to ease the pressure of iommu, as we will hanle a huge
> >> range of mapping in general.
> >>
> >> Spliting block does not simultaneously work with other pgtable ops,
> >> as the only designed user is vfio, which always hold a lock, so race
> >> condition is not considered in the pgtable ops.
> >>
> >> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> >> Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
> >> ---
> >>
> >> changelog:
> >>
> >> v2:
> >>  - Change the return type of split_block(). size_t -> int.
> >>  - Change commit message to properly describe race condition. (Robin)
> >>  - Change commit message to properly describe the need of split block.
> >>  - Add a new interface named start_dirty_log(). (Sun Yi)
> >>  - Change commit message to explain the realtionship of split_block() and start_dirty_log().
> >>
> >> ---
> >>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  52 +++++++++
> >>  drivers/iommu/io-pgtable-arm.c              | 122 ++++++++++++++++++++
> >>  drivers/iommu/iommu.c                       |  48 ++++++++
> >>  include/linux/io-pgtable.h                  |   2 +
> >>  include/linux/iommu.h                       |  24 ++++
> >>  5 files changed, 248 insertions(+)
> >>
> > Could you please split iommu common interface to a separate patch?
> > This may make review and comments easier.
> Yup, good suggestion.
> 
> > 
> > IMHO, I think the start/stop interfaces could be merged into one, e.g:
> >     int iommu_domain_set_hwdbm(struct iommu_domain *domain, bool enable,
> >                                unsigned long iova, size_t size,
> >                                int prot);
> Looks good, this reduces some code. but I have a concern that this causes loss of flexibility,
> as we must pass same arguments when start|stop dirty log. What's your opinion about this?
> 
Per current design, start/stop interfaces have similar arguments. So I
think it is ok for now. For future extension, we may think to define a
structure to pass these arguments.

> > 
> > Same comments to patch 5.
> OK. Thanks.
> 
> > 
> > BRs,
> > Yi Sun
> > 
> >> -- 
> >> 2.19.1
> > .
> Thanks,
> Keqian

BRs,
Yi Sun
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
