Return-Path: <SRS0=5Yk+=HG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964C2C433DB
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 11:52:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCD0A64F4A
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 11:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCD0A64F4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7DE0785F2D;
	Thu,  4 Feb 2021 11:52:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MMLLiMcsTOmc; Thu,  4 Feb 2021 11:52:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E69EC85DF5;
	Thu,  4 Feb 2021 11:52:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DAE71C07FD;
	Thu,  4 Feb 2021 11:52:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41721C013A
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 11:52:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 17B5B20796
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 11:52:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d5EaQPBVWUnF for <iommu@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 11:52:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by silver.osuosl.org (Postfix) with ESMTPS id D17D820476
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 11:52:34 +0000 (UTC)
IronPort-SDR: cW9UDeA2u/Gi6m0WMOuxMk2Y2R6cV+7ZOl67pXBnv+IbWrah7r/MIrRO3Cv4v4xDi9OTytL8b9
 hKl+GGsp00yw==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="168340148"
X-IronPort-AV: E=Sophos;i="5.79,400,1602572400"; d="scan'208";a="168340148"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2021 03:52:33 -0800
IronPort-SDR: XLiXXF41jGq+8PTII41pcSTPWFix/gGebf3Femer6hWNuLcMPGKiw0d3I3HW0ZobQColcfM8Mi
 awoEz6GgvzNw==
X-IronPort-AV: E=Sophos;i="5.79,400,1602572400"; d="scan'208";a="393126335"
Received: from jzhu4-mobl1.ccr.corp.intel.com (HELO [10.254.214.206])
 ([10.254.214.206])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2021 03:52:31 -0800
Subject: Re: [PATCH 0/7] [PULL REQUEST] iommu/vt-d: Update for v5.12
To: Joerg Roedel <joro@8bytes.org>
References: <20210204014401.2846425-1-baolu.lu@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <2a10e88d-b7fe-21b5-c558-8bd312ee8d69@linux.intel.com>
Date: Thu, 4 Feb 2021 19:52:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210204014401.2846425-1-baolu.lu@linux.intel.com>
Content-Language: en-US
Cc: Kyung Min Park <kyung.min.park@intel.com>, iommu@lists.linux-foundation.org,
 Chuck Lever <chuck.lever@oracle.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Robin Murphy <robin.murphy@arm.com>
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

Hi Joerg,

I just received some internal comments on the last patch

[PATCH 7/7] iommu/vt-d: Apply SATC policy

We need some extra work on it and probably re-target it to v5.13.

Can you please only consider patch 1 ~ 6 for v5.12?

Sorry for the inconvenience.

Best regards,
baolu

On 2021/2/4 9:43, Lu Baolu wrote:
> Hi Joerg,
> 
> The patches queued in this series is for v5.12. It includes:
> 
>   - Audit capability consistency among different IOMMUs
>   - Add SATC reporting structure support
>   - Add iotlb_sync_map callback support
>   - Misc cleanup
> 
> Please consider them for v5.12.
> 
> Best regards,
> Lu Baolu
> 
> Bjorn Helgaas (1):
>    iommu/vt-d: Fix 'physical' typos
> 
> Kyung Min Park (2):
>    iommu/vt-d: Audit IOMMU Capabilities and add helper functions
>    iommu/vt-d: Move capability check code to cap_audit files
> 
> Lu Baolu (1):
>    iommu/vt-d: Add iotlb_sync_map callback
> 
> Yian Chen (3):
>    iommu/vt-d: Add new enum value and structure for SATC
>    iommu/vt-d: Parse SATC reporting structure
>    iommu/vt-d: Apply SATC policy
> 
>   drivers/iommu/intel/Makefile        |   2 +-
>   drivers/iommu/intel/cap_audit.c     | 205 +++++++++++++++++
>   drivers/iommu/intel/cap_audit.h     | 130 +++++++++++
>   drivers/iommu/intel/dmar.c          |   8 +
>   drivers/iommu/intel/iommu.c         | 337 +++++++++++++++++++---------
>   drivers/iommu/intel/irq_remapping.c |   8 +
>   include/acpi/actbl1.h               |  11 +-
>   include/linux/dmar.h                |   2 +
>   include/linux/intel-iommu.h         |  41 ++--
>   9 files changed, 615 insertions(+), 129 deletions(-)
>   create mode 100644 drivers/iommu/intel/cap_audit.c
>   create mode 100644 drivers/iommu/intel/cap_audit.h
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
