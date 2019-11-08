Return-Path: <SRS0=V12C=ZA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A83C5DF61
	for <iommu@archiver.kernel.org>; Fri,  8 Nov 2019 01:38:09 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 185312084D
	for <iommu@archiver.kernel.org>; Fri,  8 Nov 2019 01:38:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 185312084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id CCD88CAA;
	Fri,  8 Nov 2019 01:38:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0081BC77
	for <iommu@lists.linux-foundation.org>;
	Fri,  8 Nov 2019 01:38:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6E2B4710
	for <iommu@lists.linux-foundation.org>;
	Fri,  8 Nov 2019 01:38:06 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	07 Nov 2019 17:38:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,279,1569308400"; d="scan'208";a="228037603"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by fmsmga004.fm.intel.com with ESMTP; 07 Nov 2019 17:38:03 -0800
Subject: Re: [PATCH 1/1] iommu/vt-d: Add Kconfig option to enable/disable
	scalable mode
To: Christoph Hellwig <hch@infradead.org>
References: <20191106051130.485-1-baolu.lu@linux.intel.com>
	<20191107093436.GA4342@infradead.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <b91e23c7-e907-5e05-0bed-a135ca683280@linux.intel.com>
Date: Fri, 8 Nov 2019 09:35:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191107093436.GA4342@infradead.org>
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

Hi Christoph,

On 11/7/19 5:34 PM, Christoph Hellwig wrote:
> On Wed, Nov 06, 2019 at 01:11:30PM +0800, Lu Baolu wrote:
>> This adds a Kconfig option INTEL_IOMMU_SCALABLE_MODE_ON to make
>> it easier for distributions to enable or disable the Intel IOMMU
>> scalable mode during kernel build.
> 
> 
> 
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/Kconfig       | 10 ++++++++++
>>   drivers/iommu/intel-iommu.c |  5 +++++
>>   2 files changed, 15 insertions(+)
>>
>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>> index e3842eabcfdd..32f30e27791c 100644
>> --- a/drivers/iommu/Kconfig
>> +++ b/drivers/iommu/Kconfig
>> @@ -242,6 +242,16 @@ config INTEL_IOMMU_FLOPPY_WA
>>   	  workaround will setup a 1:1 mapping for the first
>>   	  16MiB to make floppy (an ISA device) work.
>>   
>> +config INTEL_IOMMU_SCALABLE_MODE_ON
> 
> That should have a DEFAULT in the name as it is a default.

Agreed.

> 
>> +	def_bool n
> 
> n is the default default, so this can just be bool.

Agreed.

> 
>> +#ifdef CONFIG_INTEL_IOMMU_SCALABLE_MODE_ON
>> +int intel_iommu_sm = 1;
>> +#else
>>   int intel_iommu_sm;
>> +#endif /* CONFIG_INTEL_IOMMU_SCALABLE_MODE_ON */
> 
> This can use IS_ENABLED().

We already have below in the code

#ifdef CONFIG_INTEL_IOMMU_DEFAULT_ON
int dmar_disabled = 0;
#else
int dmar_disabled = 1;
#endif /*CONFIG_INTEL_IOMMU_DEFAULT_ON*/

I prefer to make the code style consistent if these two doesn't make
much difference.

> 
> But then again the distro can just add iommu=sm_on to CONFIG_CMDLINE
> and have the same effect, so I don't really get the point of the whole
> patch.
> 
> Or why we can't just enable it by default for that matter.
>

Currently Intel IOMMU scalable mode is by default off since some related
features are still under active development. We will make it default on
later once all features are ready.

No matter scalable mode default on or off, we provide two ways to switch
it between on and off: kernel command and Kconfig option. The former is
mainly used for debugging and testing purpose and the later is liked by
the distributions.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
