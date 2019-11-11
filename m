Return-Path: <SRS0=z06/=ZD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FF3C43331
	for <iommu@archiver.kernel.org>; Mon, 11 Nov 2019 05:23:51 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A299D20869
	for <iommu@archiver.kernel.org>; Mon, 11 Nov 2019 05:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A299D20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4EA53C6F;
	Mon, 11 Nov 2019 05:23:51 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5FDC5B6D
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 05:23:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0C17A12E
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 05:23:48 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	10 Nov 2019 21:23:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,291,1569308400"; d="scan'208";a="228824039"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by fmsmga004.fm.intel.com with ESMTP; 10 Nov 2019 21:23:46 -0800
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Add Kconfig option to enable/disable
	scalable mode
To: Qian Cai <cai@lca.pw>
References: <20191109034039.27964-1-baolu.lu@linux.intel.com>
	<472617D4-1652-45FB-90A4-0D45766DB78B@lca.pw>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f5b8521e-d88d-5439-34e2-f7b54a77c9d3@linux.intel.com>
Date: Mon, 11 Nov 2019 13:20:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <472617D4-1652-45FB-90A4-0D45766DB78B@lca.pw>
Content-Language: en-US
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com,
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

Hi,

On 11/11/19 10:58 AM, Qian Cai wrote:
> 
> 
>> On Nov 8, 2019, at 10:43 PM, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>
>> +config INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
>> +    prompt "Enable Intel IOMMU scalable mode by default"
>> +    depends on INTEL_IOMMU
>> +    help
>> +      Selecting this option will enable the scalable mode if
>> +      hardware presents the capability. If this option is not
>> +      selected, scalable mode support could also be enabled
>> +      by passing intel_iommu=sm_on to the kernel.
>> +
> 
> Does it also make sense to mention which hardware presents this capability or how to check it?
> 

The scalable mode is defined in VT-d 3.0. The scalable mode capability
could be checked by reading /sys/devices/virtual/iommu/dmar*/intel-
iommu/ecap. It's currently not friendly for reading. You need to decode
it according to the spec.

Best regards,
baolu


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
