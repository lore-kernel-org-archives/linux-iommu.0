Return-Path: <SRS0=uK2e=GT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69BBC433E0
	for <iommu@archiver.kernel.org>; Sat, 16 Jan 2021 01:20:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5928123A3C
	for <iommu@archiver.kernel.org>; Sat, 16 Jan 2021 01:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5928123A3C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D9F4E2E186;
	Sat, 16 Jan 2021 01:20:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vJJLBT1+61Ry; Sat, 16 Jan 2021 01:20:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9B2B52E194;
	Sat, 16 Jan 2021 01:20:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79D60C088B;
	Sat, 16 Jan 2021 01:20:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D966EC013A
 for <iommu@lists.linux-foundation.org>; Sat, 16 Jan 2021 01:20:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CFB1486341
 for <iommu@lists.linux-foundation.org>; Sat, 16 Jan 2021 01:20:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UnsKCaIkeMqQ for <iommu@lists.linux-foundation.org>;
 Sat, 16 Jan 2021 01:20:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3511386227
 for <iommu@lists.linux-foundation.org>; Sat, 16 Jan 2021 01:20:32 +0000 (UTC)
IronPort-SDR: OM+FCdov7f4wqJ6DpycTPkHgWDSY8sMoUqKHMaZHG2J3p5PpvomRed3jwgrE7hV/B2v8Z8dkDw
 0KWT3c1ut75g==
X-IronPort-AV: E=McAfee;i="6000,8403,9865"; a="165718216"
X-IronPort-AV: E=Sophos;i="5.79,351,1602572400"; d="scan'208";a="165718216"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2021 17:20:28 -0800
IronPort-SDR: DznnGYuwJ/UxxQrmQGJd5b9g6Om3RrfpkvoMPBs122KxptEO3Brz/fbs5840Umw7sUzZLqkujt
 GGgy0p/jLtsg==
X-IronPort-AV: E=Sophos;i="5.79,351,1602572400"; d="scan'208";a="382861945"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.249.175.94])
 ([10.249.175.94])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2021 17:20:18 -0800
Subject: Re: [RFC PATCH v3 1/2] iommu: Add capability IOMMU_CAP_VIOMMU
To: Leon Romanovsky <leon@kernel.org>
References: <20210114013003.297050-1-baolu.lu@linux.intel.com>
 <20210114013003.297050-2-baolu.lu@linux.intel.com>
 <20210114132627.GA944463@unreal>
 <b0c8b260-8e23-a5bd-d2da-ca1d67cdfa8a@linux.intel.com>
 <20210115063108.GI944463@unreal>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <c58adc13-306a-8df8-19e1-27f834b3a7c9@linux.intel.com>
Date: Sat, 16 Jan 2021 09:20:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210115063108.GI944463@unreal>
Content-Language: en-US
Cc: kvm@vger.kernel.org, rafael@kernel.org, linux-pci@vger.kernel.org,
 sanjay.k.kumar@intel.com, mona.hossain@intel.com, samuel.ortiz@intel.com,
 kwankhede@nvidia.com, will@kernel.org, dan.j.williams@intel.com,
 dave.jiang@intel.com, ashok.raj@intel.com, netanelg@mellanox.com,
 maz@kernel.org, vkoul@kernel.org, jgg@mellanox.com, yan.y.zhao@linux.intel.com,
 shahafs@mellanox.com, kevin.tian@intel.com, parav@mellanox.com,
 alex.williamson@redhat.com, bhelgaas@google.com, tglx@linutronix.de,
 megha.dey@intel.com, tony.luck@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com,
 dmaengine@vger.kernel.org, pbonzini@redhat.com, dwmw2@infradead.org
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

Hi,

On 2021/1/15 14:31, Leon Romanovsky wrote:
> On Fri, Jan 15, 2021 at 07:49:47AM +0800, Lu Baolu wrote:
>> Hi Leon,
>>
>> On 1/14/21 9:26 PM, Leon Romanovsky wrote:
>>> On Thu, Jan 14, 2021 at 09:30:02AM +0800, Lu Baolu wrote:
>>>> Some vendor IOMMU drivers are able to declare that it is running in a VM
>>>> context. This is very valuable for the features that only want to be
>>>> supported on bare metal. Add a capability bit so that it could be used.
>>>
>>> And how is it used? Who and how will set it?
>>
>> Use the existing iommu_capable(). I should add more descriptions about
>> who and how to use it.
> 
> I want to see the code that sets this capability.

Currently we have Intel VT-d and the virt-iommu setting this capability.

  static bool intel_iommu_capable(enum iommu_cap cap)
  {
  	if (cap == IOMMU_CAP_CACHE_COHERENCY)
  		return domain_update_iommu_snooping(NULL) == 1;
  	if (cap == IOMMU_CAP_INTR_REMAP)
  		return irq_remapping_enabled == 1;
+	if (cap == IOMMU_CAP_VIOMMU)
+		return caching_mode_enabled();

  	return false;
  }

And,

+static bool viommu_capable(enum iommu_cap cap)
+{
+	if (cap == IOMMU_CAP_VIOMMU)
+		return true;
+
+	return false;
+}

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
