Return-Path: <SRS0=gtiV=HF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9C0C433DB
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 00:19:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0894364F65
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 00:19:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0894364F65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B4E6886135;
	Wed,  3 Feb 2021 00:19:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Pp2IH8KZsgG9; Wed,  3 Feb 2021 00:19:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4E4C486187;
	Wed,  3 Feb 2021 00:19:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32ACDC0FA7;
	Wed,  3 Feb 2021 00:19:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72ABFC013A
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 00:19:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6628384789
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 00:19:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id THSTMdwS-qLK for <iommu@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 00:19:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id EBA3D84785
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 00:19:29 +0000 (UTC)
IronPort-SDR: +hhLWziYULn2W6PtZeGHtrOeUVMdXj5MDal81bcf3ufKu276q1j417dLwJmg4/UWsI0NNxTKQ0
 dnW190BG/kIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="180182333"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; d="scan'208";a="180182333"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2021 16:19:28 -0800
IronPort-SDR: W5OFdWgXT0fIAnC/qdqVNgv32OuvqM3kS8gWPtpomchprrc/CG1wu8rqMfdIqdFV64JNO1zbkw
 XnzLAWpwh/Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; d="scan'208";a="406357196"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 02 Feb 2021 16:19:27 -0800
Subject: Re: [PATCH 1/3] iommu/vt-d: Add new enum value and structure for SATC
To: Joerg Roedel <joro@8bytes.org>
References: <20210202044057.615277-1-baolu.lu@linux.intel.com>
 <20210202044057.615277-2-baolu.lu@linux.intel.com>
 <20210202135130.GV32671@8bytes.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <1dcd57e4-f2b3-d300-c6fe-7b6c6b41cb82@linux.intel.com>
Date: Wed, 3 Feb 2021 08:11:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210202135130.GV32671@8bytes.org>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org
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

On 2/2/21 9:51 PM, Joerg Roedel wrote:
> Hi Baolu,
> 
> On Tue, Feb 02, 2021 at 12:40:55PM +0800, Lu Baolu wrote:
>> @@ -514,7 +514,8 @@ enum acpi_dmar_type {
>>   	ACPI_DMAR_TYPE_ROOT_ATS = 2,
>>   	ACPI_DMAR_TYPE_HARDWARE_AFFINITY = 3,
>>   	ACPI_DMAR_TYPE_NAMESPACE = 4,
>> -	ACPI_DMAR_TYPE_RESERVED = 5	/* 5 and greater are reserved */
>> +	ACPI_DMAR_TYPE_SATC = 5,
>> +	ACPI_DMAR_TYPE_RESERVED = 6	/* 5 and greater are reserved */
> 
> Nit: The comment needs to be updated too.
> 

Yes. Will update it.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
