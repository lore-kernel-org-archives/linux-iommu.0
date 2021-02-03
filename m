Return-Path: <SRS0=gtiV=HF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C89C433E0
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 09:48:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE6A764F60
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 09:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE6A764F60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7942B85E9B;
	Wed,  3 Feb 2021 09:48:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3wrrEAFontBF; Wed,  3 Feb 2021 09:48:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D3AE585250;
	Wed,  3 Feb 2021 09:48:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B77F1C0FA7;
	Wed,  3 Feb 2021 09:48:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0FA44C013A
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 09:48:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E735386793
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 09:48:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ekDrgbVbMZeY for <iommu@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 09:48:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C932986786
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 09:48:38 +0000 (UTC)
IronPort-SDR: S+B7DAkG74VVhZQ0fgZWK+WUQxGbsEroXrEDaRGj1ykYJ66J96FjYdPxOqU/xkjEQ6WROqx+it
 ekrSeFDAfg2A==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="199969321"
X-IronPort-AV: E=Sophos;i="5.79,398,1602572400"; d="scan'208";a="199969321"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2021 01:48:38 -0800
IronPort-SDR: z7L5sj5sm456OIh0RnRHAfZ7lYa+DIEDxbjIPakmowt1eQjPoMxpFsbihLkOHIdqSuCyEZB1SC
 ruJsaFLXSn+A==
X-IronPort-AV: E=Sophos;i="5.79,398,1602572400"; d="scan'208";a="371356323"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.211])
 ([10.254.210.211])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2021 01:48:36 -0800
Subject: Re: [PATCH v2 0/3] iommu/vt-d: Add support for ACPI/SATC table
To: Joerg Roedel <joro@8bytes.org>
References: <20210203093329.1617808-1-baolu.lu@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <7217f395-4998-ae81-8e9d-a08bc49956a7@linux.intel.com>
Date: Wed, 3 Feb 2021 17:48:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210203093329.1617808-1-baolu.lu@linux.intel.com>
Content-Language: en-US
Cc: Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>
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

Add the change log. Sorry for the quick sent.

On 2021/2/3 17:33, Lu Baolu wrote:
> The Intel VT-d specification v3.2 comes with a new ACPI SATC (SoC-
> Integrated Address Translation Cache) reporting structure. The SoC
> integrated device enumerated in this table has a functional
> requirement to enable its ATC (Address Translation Cache) via the
> ATS capability for device operation.
> 
> This patch set adds the code to parse the SATC table, enumerates the
> devices in it and satisfies the ATS requirement for them. Please help
> to review. I will queue it in VT-d update for v5.12 if no objection.
> 

Change log:
v1->v2:
  - Rephrase some words in the cover letter, commit message and
    code comments.
  - Refactored a code style to make it look nicer.

Best regards,
baolu

> Yian Chen (3):
>    iommu/vt-d: Add new enum value and structure for SATC
>    iommu/vt-d: Parse SATC reporting structure
>    iommu/vt-d: Apply SATC policy
> 
>   drivers/iommu/intel/dmar.c  |   8 ++
>   drivers/iommu/intel/iommu.c | 162 +++++++++++++++++++++++++++++++++++-
>   include/acpi/actbl1.h       |  11 ++-
>   include/linux/dmar.h        |   2 +
>   4 files changed, 178 insertions(+), 5 deletions(-)
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
