Return-Path: <SRS0=5Yk+=HG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3115AC433E0
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 02:22:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C3A564F65
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 02:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C3A564F65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2C6742043C;
	Thu,  4 Feb 2021 02:22:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id glT2zfvyoqxJ; Thu,  4 Feb 2021 02:22:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E32E320437;
	Thu,  4 Feb 2021 02:22:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C046BC08A1;
	Thu,  4 Feb 2021 02:22:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC2DBC013A
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 02:22:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id BD7272043C
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 02:22:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UqWYDlaGrqDI for <iommu@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 02:22:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by silver.osuosl.org (Postfix) with ESMTPS id 6EA2A20437
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 02:22:27 +0000 (UTC)
IronPort-SDR: bmPkuj+qQHLvqP+6PAwlOOuFtjS/vY0bpYFYcgguRz18U98pdlGOFED8EgSmk1Gra067rs8Sf3
 PWPleE8J+n8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="265987716"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; d="scan'208";a="265987716"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2021 18:22:23 -0800
IronPort-SDR: bfbJNbtpCiAp/iCc1C/HPmhsgk4/5FQGkCyHNxR8SYEXxAb9XGI7ytsS2m7O8uAoua5+CwCQ08
 K31AJ9mFy35g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; d="scan'208";a="406918072"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 03 Feb 2021 18:22:21 -0800
Subject: Re: [PATCH v2 3/3] iommu/vt-d: Apply SATC policy
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>
References: <20210203093329.1617808-1-baolu.lu@linux.intel.com>
 <20210203093329.1617808-4-baolu.lu@linux.intel.com>
 <MWHPR11MB1886133A35BA369F7EF3014A8CB39@MWHPR11MB1886.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <c6956ddc-31d8-33dd-f99d-63d0ac006b8e@linux.intel.com>
Date: Thu, 4 Feb 2021 10:13:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB1886133A35BA369F7EF3014A8CB39@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Language: en-US
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Will Deacon <will@kernel.org>, "Raj, Ashok" <ashok.raj@intel.com>
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

Hi Kevin,

On 2/4/21 9:59 AM, Tian, Kevin wrote:
>> From: Lu Baolu
>> Sent: Wednesday, February 3, 2021 5:33 PM
>>
>> From: Yian Chen<yian.chen@intel.com>
>>
>> Starting from Intel VT-d v3.2, Intel platform BIOS can provide a new SATC
>> table structure. SATC table lists a set of SoC integrated devices that
>> require ATC to work (VT-d specification v3.2, section 8.8). Furthermore,
> This statement is not accurate. The purpose of SATC is to tell whether a
> SoC integrated device has been validated to meet the isolation requirements
> of using device TLB. All devices listed in SATC can have ATC safely enabled by
> OS. In addition, there is a flag for each listed device for whether ATC is a
> functional requirement. However, above description only captured the last
> point.

You are right. This series only addresses the devices with the flag set
which have functional requirement for ATS.

> 
>> the new version of IOMMU supports SoC device ATS in both its Scalable
>> mode
>> and legacy mode.
>>
>> When IOMMU is working in scalable mode, software must enable device ATS
>> support.
> "must enable" is misleading here. You need describe the policies for three
> categories:
> 
> - SATC devices with ATC_REQUIRED=1
> - SATC devices with ATC_REQUIRED=0
> - devices not listed in SATC, or when SATC is missing

Yian is working on this part. We planed it for v5.13. He will bring it
up for discussion later.

> 
>> On the other hand, when IOMMU is in legacy mode for whatever
>> reason, the hardware managed ATS will automatically take effect and the
>> SATC required devices can work transparently to the software. As the
> No background about hardware-managed ATS.
> 
>> result, software shouldn't enable ATS on that device, otherwise duplicate
>> device TLB invalidations will occur.
> This description draws a equation between legacy mode and hardware
> managed ATS. Do we care about the scenario where there is no hardware
> managed ATS but people also want to turn on ATC in legacy mode?

The hardware managed ATS is defined in the platform specific
specification. The purpose of this hardware design is backward
compatibility - legacy OSes with no SM or ATS awareness still running
well on them.

> 
> Thanks
> Kevin
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
