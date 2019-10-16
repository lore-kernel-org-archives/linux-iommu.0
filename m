Return-Path: <SRS0=NqTC=YJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B71FA3728
	for <iommu@archiver.kernel.org>; Wed, 16 Oct 2019 17:21:28 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B70C21A4C
	for <iommu@archiver.kernel.org>; Wed, 16 Oct 2019 17:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B70C21A4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 65CD0E41;
	Wed, 16 Oct 2019 17:21:28 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CDF87DA2
	for <iommu@lists.linux-foundation.org>;
	Wed, 16 Oct 2019 17:21:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E26BF6C5
	for <iommu@lists.linux-foundation.org>;
	Wed, 16 Oct 2019 17:21:24 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	16 Oct 2019 10:21:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,304,1566889200"; d="scan'208";a="395964943"
Received: from chenyian-desk1.amr.corp.intel.com (HELO [10.3.52.63])
	([10.3.52.63])
	by fmsmga005.fm.intel.com with ESMTP; 16 Oct 2019 10:21:24 -0700
Subject: Re: [PATCH] iommu/vt-d: Check VT-d RMRR region in BIOS is reported as
	reserved
To: Joerg Roedel <joro@8bytes.org>
References: <20191015164932.18185-1-yian.chen@intel.com>
	<20191016075120.GB32232@8bytes.org>
From: "Chen, Yian" <yian.chen@intel.com>
Message-ID: <b1ebbf77-ced7-be22-d8d8-a7d4e19ad261@intel.com>
Date: Wed, 16 Oct 2019 10:21:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191016075120.GB32232@8bytes.org>
Content-Language: en-US
Cc: "Luck, Tony" <tony.luck@intel.com>,
	"linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "Raj,
	Ashok" <ashok.raj@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org



On 10/16/2019 12:51 AM, Joerg Roedel wrote:
> Hi,
>
> On Tue, Oct 15, 2019 at 09:49:32AM -0700, Yian Chen wrote:
>> VT-d RMRR (Reserved Memory Region Reporting) regions are reserved
>> for device use only and should not be part of allocable memory pool of OS.
>>
>> BIOS e820_table reports complete memory map to OS, including OS usable
>> memory ranges and BIOS reserved memory ranges etc.
>>
>> x86 BIOS may not be trusted to include RMRR regions as reserved type
>> of memory in its e820 memory map, hence validate every RMRR entry
>> with the e820 memory map to make sure the RMRR regions will not be
>> used by OS for any other purposes.
> Are there real systems in the wild where this is a problem?
Firmware reports e820 and RMRR in separate structure. The system will 
not work stably
if RMRR is not in the e820 table as reserved type mem and can be used 
for other purposes.
In system engineering phase, I practiced with some kind bugs from BIOS, 
but not yet exactly same as
the one here. Please consider this is a generic patch to avoid 
subsequent failure at runtime.
>> +static inline int __init
>> +arch_rmrr_sanity_check(struct acpi_dmar_reserved_memory *rmrr)
>> +{
>> +	u64 start = rmrr->base_address;
>> +	u64 end = rmrr->end_address + 1;
>> +
>> +	if (e820__mapped_all(start, end, E820_TYPE_RESERVED))
>> +		return 0;
>> +
>> +	pr_err(FW_BUG "No firmware reserved region can cover this RMRR [%#018Lx-%#018Lx], contact BIOS vendor for fixes\n",
>> +	       start, end - 1);
>> +	return -EFAULT;
>> +}
> Why -EFAULT, there is no fault involved? Usibg -EINVAL seems to be a better choice.
-EFAULT could be used for address related errors.
For this case, I agree, -EINVAL seems better while
consider it as an input problem from firmware. I will make change.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
