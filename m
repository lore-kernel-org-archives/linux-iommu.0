Return-Path: <SRS0=3N47=YS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908EDCA9EBC
	for <iommu@archiver.kernel.org>; Fri, 25 Oct 2019 14:42:02 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6497D2064A
	for <iommu@archiver.kernel.org>; Fri, 25 Oct 2019 14:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6497D2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3071BD38;
	Fri, 25 Oct 2019 14:42:02 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BB3AAD2E
	for <iommu@lists.linux-foundation.org>;
	Fri, 25 Oct 2019 14:42:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6873114D
	for <iommu@lists.linux-foundation.org>;
	Fri, 25 Oct 2019 14:42:00 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	25 Oct 2019 07:41:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,229,1569308400"; d="scan'208";a="223939301"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by fmsmga004.fm.intel.com with ESMTP; 25 Oct 2019 07:41:57 -0700
Subject: Re: [PATCH v7 03/11] iommu/vt-d: Add custom allocator for IOASID
To: "Tian, Kevin" <kevin.tian@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <1571946904-86776-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1571946904-86776-4-git-send-email-jacob.jun.pan@linux.intel.com>
	<ae437be4-e633-e670-0e1f-d07b4364f651@linux.intel.com>
	<20191024214311.43d76a5c@jacob-builder>
	<AADFC41AFE54684AB9EE6CBC0274A5D19D5CDC60@SHSMSX104.ccr.corp.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <e950cde8-8cd9-6089-c833-23d2ffb539d1@linux.intel.com>
Date: Fri, 25 Oct 2019 22:39:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D5CDC60@SHSMSX104.ccr.corp.intel.com>
Content-Language: en-US
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>, Jonathan Cameron <jic23@kernel.org>
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

Hi,

On 10/25/19 2:40 PM, Tian, Kevin wrote:
>>>> ioasid_register_allocator(&iommu->pasid_allocator);
>>>> +			if (ret) {
>>>> +				pr_warn("Custom PASID allocator
>>>> registeration failed\n");
>>>> +				/*
>>>> +				 * Disable scalable mode on this
>>>> IOMMU if there
>>>> +				 * is no custom allocator. Mixing
>>>> SM capable vIOMMU
>>>> +				 * and non-SM vIOMMU are not
>>>> supported.
>>>> +				 */
>>>> +				intel_iommu_sm = 0;
>>> It's insufficient to disable scalable mode by only clearing
>>> intel_iommu_sm. The DMA_RTADDR_SMT bit in root entry has already
>> been
>>> set. Probably, you need to
>>>
>>> for each iommu
>>> 	clear DMA_RTADDR_SMT in root entry
>>>
>>> Alternatively, since vSVA is the only customer of this custom PASID
>>> allocator, is it possible to only disable SVA here?
>>>
>> Yeah, I think disable SVA is better. We can still do gIOVA in SM. I
>> guess we need to introduce a flag for sva_enabled.
> I'm not sure whether tying above logic to SVA is the right approach.
> If vcmd interface doesn't work, the whole SM mode doesn't make
> sense which is based on PASID-granular protection (SVA is only one
> usage atop). If the only remaining usage of SM is to map gIOVA using
> reserved PASID#0, then why not disabling SM and just fallback to
> legacy mode?
> 
> Based on that I prefer to disabling the SM mode completely (better
> through an interface), and move the logic out of CONFIG_INTEL_
> IOMMU_SVM
> 

Unfortunately, it is dangerous to disable SM after boot. SM uses
different root/device contexts and pasid table formats. Disabling SM
after boot requires changing above from SM format into legacy format.

Since ioasid registration failure is a rare case. How about moving this
part of code up to the early stage of intel_iommu_init() and returning
error if hardware present vcmd capability but software fails to register
a custom ioasid allocator?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
