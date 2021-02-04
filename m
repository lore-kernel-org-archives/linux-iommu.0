Return-Path: <SRS0=5Yk+=HG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D61AC433DB
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 05:41:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 728BF64F55
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 05:41:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 728BF64F55
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id F1EB7204EB;
	Thu,  4 Feb 2021 05:41:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lL7qEpnXtp2H; Thu,  4 Feb 2021 05:41:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id EA239273B5;
	Thu,  4 Feb 2021 05:41:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BFF22C0174;
	Thu,  4 Feb 2021 05:41:09 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC3C0C013A
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 05:41:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CE551273EB
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 05:41:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FQ0WaXnWXWMU for <iommu@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 05:41:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by silver.osuosl.org (Postfix) with ESMTPS id 09ABC273B5
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 05:41:05 +0000 (UTC)
IronPort-SDR: 62BsQiv/EkCW8Yn4PUTNhlp0ZsFvkJxAaLLdO1d1M+Pc3hhls0gEk6Mn9/keaTDiiwh5qxSuru
 ic8bt/tIb8zg==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="168857765"
X-IronPort-AV: E=Sophos;i="5.79,400,1602572400"; d="scan'208";a="168857765"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2021 21:41:01 -0800
IronPort-SDR: eS8w5V/JEJ2aCX7rTboXYncEu6oo+dyVIN7SYdEaAD7Cyl+Dbpq6Dc8shvN1gZ0l8cylOT5KBw
 +56WClz+2LOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,400,1602572400"; d="scan'208";a="406963066"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 03 Feb 2021 21:40:59 -0800
Subject: Re: [PATCH 0/7] [PULL REQUEST] iommu/vt-d: Update for v5.12
To: Joerg Roedel <joro@8bytes.org>
References: <20210204014401.2846425-1-baolu.lu@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <b3ccac0c-55e4-fced-f0e5-2ac11be0b58c@linux.intel.com>
Date: Thu, 4 Feb 2021 13:32:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
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

On 2/4/21 9:43 AM, Lu Baolu wrote:
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
