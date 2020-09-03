Return-Path: <SRS0=kdGy=CM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6E2C433E7
	for <iommu@archiver.kernel.org>; Thu,  3 Sep 2020 07:28:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D68DE20737
	for <iommu@archiver.kernel.org>; Thu,  3 Sep 2020 07:28:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D68DE20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8E10B20470;
	Thu,  3 Sep 2020 07:28:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CP-x9aw4k+P1; Thu,  3 Sep 2020 07:27:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9ACF820450;
	Thu,  3 Sep 2020 07:27:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71C9CC0052;
	Thu,  3 Sep 2020 07:27:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00815C0051
 for <iommu@lists.linux-foundation.org>; Thu,  3 Sep 2020 07:27:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id EA14086B10
 for <iommu@lists.linux-foundation.org>; Thu,  3 Sep 2020 07:27:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1JoZGQKclaJG for <iommu@lists.linux-foundation.org>;
 Thu,  3 Sep 2020 07:27:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 33F3486B0B
 for <iommu@lists.linux-foundation.org>; Thu,  3 Sep 2020 07:27:57 +0000 (UTC)
IronPort-SDR: cxX1y1M0jH6oYNFSOhfoc4zu+Ip/TLajzjkk5r9X/T4xeZmDzzNHaSukPn9hPdCgAde8YGRm2k
 4meHCUHtUhxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="137051399"
X-IronPort-AV: E=Sophos;i="5.76,385,1592895600"; d="scan'208";a="137051399"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2020 00:27:56 -0700
IronPort-SDR: Ze3ZybqgmXXV2HST0KQmgul6uR9hAPh6E6UsMzLx6EMFfvZfUTDbVKkqtQmSz+4SUv5x0FohOJ
 g/eqXS3+PNow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,385,1592895600"; d="scan'208";a="326108998"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 03 Sep 2020 00:27:53 -0700
Subject: =?UTF-8?B?UmU6IOetlOWkjTog562U5aSNOiBbUEFUQ0ggdjMgMi8yXSBpb21tdS92?=
 =?UTF-8?Q?t-d=3aAdd_support_for_probing_ACPI_device_in_RMRR?=
To: FelixCui-oc <FelixCui-oc@zhaoxin.com>, Joerg Roedel <joro@8bytes.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 "kbuild@lists.01.org" <kbuild@lists.01.org>
References: <20200827100217.21324-1-FelixCui-oc@zhaoxin.com>
 <20200827100217.21324-3-FelixCui-oc@zhaoxin.com>
 <e5b1daaf-f073-94c9-714c-832b10d284f4@linux.intel.com>
 <cde22f0f02f94efcae8bf044e2cd9441@zhaoxin.com>
 <7e5f2c33-c6c3-f344-9014-1f6a306c55aa@linux.intel.com>
 <cfdd29a882d140e5aec2e8c3b77f4968@zhaoxin.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <56fc76e5-a31c-36b6-c6f0-fd8370cd7a91@linux.intel.com>
Date: Thu, 3 Sep 2020 15:22:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cfdd29a882d140e5aec2e8c3b77f4968@zhaoxin.com>
Content-Language: en-US
Cc: Ashok Raj <ashok.raj@intel.com>, Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
 CobeChen-oc <CobeChen-oc@zhaoxin.com>
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

Hi Felix,

On 9/2/20 11:24 AM, FelixCui-oc wrote:
> hi baolu,
> 
>> So you have a hidden device (invisible to host kernel). But you need to
> 
>>setup some identity mappings for this device, so that the firmware
>>could keep working, right?
> 
>>The platform designs this by putting that range in the RMRR table and
>>expecting the OS kernel to setup identity mappings during boot.
> 
>>Do I understand it right?
> 
> 
> Yes. What you understand is correct.

This appears to be a new usage model of RMRR. I need to discuss this
with the VT-d spec maintainer. Do you mind telling which platform are
you going to run this on? What is the motivation of creating such hidden
device?

Basically, RMRRs were added as work around for certain legacy device and
we have been working hard to fix those legacy devices so that RMRR are
no longer needed.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
