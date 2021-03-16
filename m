Return-Path: <SRS0=0/W0=IO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FF9C4332B
	for <iommu@archiver.kernel.org>; Tue, 16 Mar 2021 09:23:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90D7764FA7
	for <iommu@archiver.kernel.org>; Tue, 16 Mar 2021 09:23:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90D7764FA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 476AB4313E;
	Tue, 16 Mar 2021 09:23:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HXJ7NNCGQ2ry; Tue, 16 Mar 2021 09:23:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3537643002;
	Tue, 16 Mar 2021 09:23:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A4ADC000B;
	Tue, 16 Mar 2021 09:23:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4383EC000A
 for <iommu@lists.linux-foundation.org>; Tue, 16 Mar 2021 09:23:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3193243002
 for <iommu@lists.linux-foundation.org>; Tue, 16 Mar 2021 09:23:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SEGzQyKF3Zjy for <iommu@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 09:23:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 49F7042FB7
 for <iommu@lists.linux-foundation.org>; Tue, 16 Mar 2021 09:23:41 +0000 (UTC)
IronPort-SDR: tMG6VPS3sqUr6uV9+VsR1UF/z+OVLE5N/d28Q7AnMcQLSATKtXsuLL0KQMzdtmp4PK6DcTCMIy
 d1ObQSI2NF1w==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="168501780"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; d="scan'208";a="168501780"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2021 02:23:40 -0700
IronPort-SDR: CrQEz3Ag/ybTmE/AKIhoS6JlqMs8jIsDGXGu3qBz2a7xb6J+XW5eh5kL00OMxdeOM628wp1Rb5
 /se5GT1T9v/Q==
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; d="scan'208";a="449660949"
Received: from yisun1-ubuntu.bj.intel.com (HELO yi.y.sun) ([10.238.156.116])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA256;
 16 Mar 2021 02:23:35 -0700
Date: Tue, 16 Mar 2021 17:17:51 +0800
From: Yi Sun <yi.y.sun@linux.intel.com>
To: Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v2 04/11] iommu/arm-smmu-v3: Split block descriptor when
 start dirty log
Message-ID: <20210316091751.GN28580@yi.y.sun>
References: <20210310090614.26668-1-zhukeqian1@huawei.com>
 <20210310090614.26668-5-zhukeqian1@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210310090614.26668-5-zhukeqian1@huawei.com>
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

On 21-03-10 17:06:07, Keqian Zhu wrote:
> From: jiangkunkun <jiangkunkun@huawei.com>
> 
> Block descriptor is not a proper granule for dirty log tracking.
> Take an extreme example, if DMA writes one byte, under 1G mapping,
> the dirty amount reported to userspace is 1G, but under 4K mapping,
> the dirty amount is just 4K.
> 
> This adds a new interface named start_dirty_log in iommu layer and
> arm smmuv3 implements it, which splits block descriptor to an span
> of page descriptors. Other types of IOMMU will perform architecture
> specific actions to start dirty log.
> 
> To allow code reuse, the split_block operation is realized as an
> iommu_ops too. We flush all iotlbs after the whole procedure is
> completed to ease the pressure of iommu, as we will hanle a huge
> range of mapping in general.
> 
> Spliting block does not simultaneously work with other pgtable ops,
> as the only designed user is vfio, which always hold a lock, so race
> condition is not considered in the pgtable ops.
> 
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
> ---
> 
> changelog:
> 
> v2:
>  - Change the return type of split_block(). size_t -> int.
>  - Change commit message to properly describe race condition. (Robin)
>  - Change commit message to properly describe the need of split block.
>  - Add a new interface named start_dirty_log(). (Sun Yi)
>  - Change commit message to explain the realtionship of split_block() and start_dirty_log().
> 
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  52 +++++++++
>  drivers/iommu/io-pgtable-arm.c              | 122 ++++++++++++++++++++
>  drivers/iommu/iommu.c                       |  48 ++++++++
>  include/linux/io-pgtable.h                  |   2 +
>  include/linux/iommu.h                       |  24 ++++
>  5 files changed, 248 insertions(+)
> 
Could you please split iommu common interface to a separate patch?
This may make review and comments easier.

IMHO, I think the start/stop interfaces could be merged into one, e.g:
    int iommu_domain_set_hwdbm(struct iommu_domain *domain, bool enable,
                               unsigned long iova, size_t size,
                               int prot);

Same comments to patch 5.

BRs,
Yi Sun

> -- 
> 2.19.1
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
