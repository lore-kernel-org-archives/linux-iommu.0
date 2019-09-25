Return-Path: <SRS0=izs0=XU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FA7C432C1
	for <iommu@archiver.kernel.org>; Wed, 25 Sep 2019 02:50:44 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEC5F20673
	for <iommu@archiver.kernel.org>; Wed, 25 Sep 2019 02:50:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEC5F20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 99042C7C;
	Wed, 25 Sep 2019 02:50:43 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 21C21B8F
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 02:50:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0C38B8A
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 02:50:32 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	24 Sep 2019 19:50:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,546,1559545200"; d="scan'208";a="201100050"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by orsmga002.jf.intel.com with ESMTP; 24 Sep 2019 19:50:29 -0700
Subject: Re: [RFC PATCH 0/4] Use 1st-level for DMA remapping in guest
To: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20190923122454.9888-1-baolu.lu@linux.intel.com>
	<20190923122715.53de79d0@jacob-builder>
	<20190923202552.GA21816@araj-mobl1.jf.intel.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19D58D1F1@SHSMSX104.ccr.corp.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <dfd9b7a2-5553-328a-08eb-16c8a3a2644e@linux.intel.com>
Date: Wed, 25 Sep 2019 10:48:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D58D1F1@SHSMSX104.ccr.corp.intel.com>
Content-Language: en-US
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Kumar,
	Sanjay K" <sanjay.k.kumar@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
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

Hi Kevin,

On 9/24/19 3:00 PM, Tian, Kevin wrote:
>>>>       '-----------'
>>>>       '-----------'
>>>>
>>>> This patch series only aims to achieve the first goal, a.k.a using
> first goal? then what are other goals? I didn't spot such information.
> 

The overall goal is to use IOMMU nested mode to avoid shadow page table
and VMEXIT when map an gIOVA. This includes below 4 steps (maybe not
accurate, but you could get the point.)

1) GIOVA mappings over 1st-level page table;
2) binding vIOMMU 1st level page table to the pIOMMU;
3) using pIOMMU second level for GPA->HPA translation;
4) enable nested (a.k.a. dual stage) translation in host.

This patch set aims to achieve 1).

> Also earlier you mentioned the new approach (nested) is more secure
> than shadowing. why?
> 

My bad! After reconsideration, I realized that it's not "more secure".

Thanks for pointing this out.

Best regards,
Baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
