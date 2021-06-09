Return-Path: <SRS0=g+Up=LD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A21BC47095
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 07:44:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCC0F61361
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 07:44:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC0F61361
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 99A3E608E4;
	Wed,  9 Jun 2021 07:44:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1sjndcBACT5A; Wed,  9 Jun 2021 07:44:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 98494608C4;
	Wed,  9 Jun 2021 07:44:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78842C000E;
	Wed,  9 Jun 2021 07:44:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C486DC000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 07:44:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B3F2D83BE1
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 07:44:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zNd_E8Z0O_7m for <iommu@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 07:44:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3707983BDC
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 07:44:22 +0000 (UTC)
IronPort-SDR: M0lqv2xvn/qzPJUU3WJCQzLOzqRc2giokQc23lmJCj5Uwv/TpL4vCmcM40oEFOqKgsH1VF4tQ1
 Ta8qwGa6aaGw==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="204987659"
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; d="scan'208";a="204987659"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2021 00:44:22 -0700
IronPort-SDR: dCn0BGUyr/Eo3NCPc3xMWLGaHDiICq/7+k7U4ljnprUA1mITTlPV0urd1XA4/V/cYRfRRSevBt
 pxfr3k+JHqUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; d="scan'208";a="552590143"
Received: from allen-box.sh.intel.com (HELO [10.239.159.105])
 ([10.239.159.105])
 by fmsmga001.fm.intel.com with ESMTP; 09 Jun 2021 00:44:20 -0700
Subject: Re: [PATCH 0/5] Short cleanups around DMAR
To: Parav Pandit <parav@nvidia.com>, dwmw2@infradead.org,
 iommu@lists.linux-foundation.org
References: <20210530075053.264218-1-parav@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <7611de37-31c3-a62d-4586-b7403f4e5fde@linux.intel.com>
Date: Wed, 9 Jun 2021 15:43:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210530075053.264218-1-parav@nvidia.com>
Content-Language: en-US
Cc: will@kernel.org
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

On 5/30/21 3:50 PM, Parav Pandit wrote:
> Hi David, Lu,
> 
> This short series contains small cleanup patches for Intel iommu
> in DMAR area.
> 
> Patch summary:
> Patch-1 uses bitfields for few DMAR capabilities
> Patch-2 removes unused iommu_count
> Patch-3 removed unnecessary braces
> Patch-4 define count data type explicitly as unsigned int
> Patch-5 removes unnecessary typecasting
> 
> 
> Parav Pandit (5):
>    iommu/intel: Use bitfields for DMAR capabilities
>    iommu/intel: Removed unused iommu_count in dmar domain
>    iommu/intel: Remove unnecessary braces
>    iommu/intel: Define counter explicitly as unsigned int
>    iommu/intel: No need to typecast

All patches queued for v5.14. Thanks!

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
