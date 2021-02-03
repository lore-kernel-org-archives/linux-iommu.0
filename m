Return-Path: <SRS0=gtiV=HF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00396C433DB
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 00:35:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73C8364F6C
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 00:35:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73C8364F6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1410087093;
	Wed,  3 Feb 2021 00:35:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IK36ytnMazfG; Wed,  3 Feb 2021 00:35:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C06F98707B;
	Wed,  3 Feb 2021 00:35:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB800C0FA7;
	Wed,  3 Feb 2021 00:35:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D0ECC013A
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 00:35:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0C0058690D
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 00:35:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5FfDcBijaHaD for <iommu@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 00:35:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9D81885C90
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 00:35:16 +0000 (UTC)
IronPort-SDR: 7jBuuWTc7eDjjiyGEJHiySmiudKwl703dVTHTcYjpUU4hLjPYa6kA6Yqf+zJZpV8yVI/ignH2w
 ST36175+FjzA==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="265789824"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; d="scan'208";a="265789824"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2021 16:35:16 -0800
IronPort-SDR: e0b6PI9U7DrCgZmVszAo9xeNxmMhntUio8uRLfgVa9xQIUawRHJEMp13YmkFDc13A4FpVbySu0
 dGenMmxrY8bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; d="scan'208";a="406360451"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 02 Feb 2021 16:35:14 -0800
Subject: Re: [PATCH 2/3] iommu/vt-d: Parse SATC reporting structure
To: Joerg Roedel <joro@8bytes.org>
References: <20210202044057.615277-1-baolu.lu@linux.intel.com>
 <20210202044057.615277-3-baolu.lu@linux.intel.com>
 <20210202135305.GW32671@8bytes.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <7650bd0f-7084-fd2c-d197-239dffdd7923@linux.intel.com>
Date: Wed, 3 Feb 2021 08:26:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210202135305.GW32671@8bytes.org>
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

On 2/2/21 9:53 PM, Joerg Roedel wrote:
> On Tue, Feb 02, 2021 at 12:40:56PM +0800, Lu Baolu wrote:
>> +	case ACPI_DMAR_TYPE_SATC:
>> +		satc = container_of(header, struct acpi_dmar_satc, header);
>> +		pr_info("SATC flags: 0x%x\n", satc->flags);
>> +		break;
> 
> Did the pr_info() slip through or is there a real purpose for having
> this information in the kernel log?
> 

Here is just the easiest way for users to know SATC: system has SATC?
ATS is required?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
