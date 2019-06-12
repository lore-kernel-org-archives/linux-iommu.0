Return-Path: <SRS0=EPGj=UL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C4AC31E44
	for <iommu@archiver.kernel.org>; Wed, 12 Jun 2019 02:31:42 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80D2E2086D
	for <iommu@archiver.kernel.org>; Wed, 12 Jun 2019 02:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D2E2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3DC3D14E0;
	Wed, 12 Jun 2019 02:31:42 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BDE7114D7
	for <iommu@lists.linux-foundation.org>;
	Wed, 12 Jun 2019 02:29:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 39FAC79
	for <iommu@lists.linux-foundation.org>;
	Wed, 12 Jun 2019 02:29:48 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	11 Jun 2019 19:29:47 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by orsmga004.jf.intel.com with ESMTP; 11 Jun 2019 19:29:41 -0700
Subject: Re: [PATCH v4 6/9] iommu/vt-d: Check whether device requires bounce
	buffer
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <20190603011620.31999-1-baolu.lu@linux.intel.com>
	<20190603011620.31999-7-baolu.lu@linux.intel.com>
	<20190610160802.GX28796@char.us.oracle.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <bf973966-d975-9100-475d-bf30dbb99bf6@linux.intel.com>
Date: Wed, 12 Jun 2019 10:22:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190610160802.GX28796@char.us.oracle.com>
Content-Language: en-US
Cc: alan.cox@intel.com, Christoph Hellwig <hch@lst.de>,
	Stefano Stabellini <sstabellini@kernel.org>, ashok.raj@intel.com,
	Jonathan Corbet <corbet@lwn.net>, pengfei.xu@intel.com,
	Ingo Molnar <mingo@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>, kevin.tian@intel.com,
	Steven Rostedt <rostedt@goodmis.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	mika.westerberg@linux.intel.com, Juergen Gross <jgross@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	jacob.jun.pan@intel.com, Robin Murphy <robin.murphy@arm.com>
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

On 6/11/19 12:08 AM, Konrad Rzeszutek Wilk wrote:
> On Mon, Jun 03, 2019 at 09:16:17AM +0800, Lu Baolu wrote:
>> This adds a helper to check whether a device needs to use bounce
>> buffer. It also provides a boot time option to disable the bounce
>> buffer. Users can use this to prevent the iommu driver from using
>> the bounce buffer for performance gain.
>> 
>> Cc: Ashok Raj <ashok.raj@intel.com> Cc: Jacob Pan
>> <jacob.jun.pan@linux.intel.com> Cc: Kevin Tian
>> <kevin.tian@intel.com> Signed-off-by: Lu Baolu
>> <baolu.lu@linux.intel.com> Tested-by: Xu Pengfei
>> <pengfei.xu@intel.com> Tested-by: Mika Westerberg
>> <mika.westerberg@intel.com> --- 
>> Documentation/admin-guide/kernel-parameters.txt | 5 +++++ 
>> drivers/iommu/intel-iommu.c                     | 6 ++++++ 2 files
>> changed, 11 insertions(+)
>> 
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt
>> b/Documentation/admin-guide/kernel-parameters.txt index
>> 138f6664b2e2..65685c6e53e4 100644 ---
>> a/Documentation/admin-guide/kernel-parameters.txt +++
>> b/Documentation/admin-guide/kernel-parameters.txt @@ -1728,6
>> +1728,11 @@ Note that using this option lowers the security 
>> provided by tboot because it makes the system vulnerable to DMA
>> attacks. +		nobounce [Default off] +			Do not use the bounce buffer
>> for untrusted devices like +			the Thunderbolt devices. This will
>> treat the untrusted
> 
> My brain has sometimes a hard time parsing 'Not' and 'un'. Could this
> be:
> 
> Disable bounce buffer for unstrusted devices ..?
> 

Fair enough.

> 
> And perhaps call it 'noswiotlb' ? Not everyone knows that SWIOTLB =
> bounce buffer.

As I said in previous thread, swiotlb is not only used for BOUNCE_PAGE
case, but also used by direct dma APIs. Will it cause confusion?

Anyway, I have no strong feeling to use 'nobounce' or 'noswiotlb'. It's
a driver specific switch for debugging purpose. People suggested that we
should move this switch into pci module, but I heard that it's more
helpful to implement per-device switch for "trusted' or "untrusted".
So I kept this untouched in this version.

> 
>> +			devices as the trusted ones, hence might expose security +
>> risks of DMA attacks.
>> 
>> intel_idle.max_cstate=	[KNL,HW,ACPI,X86] 0	disables intel_idle and
>> fall back on acpi_idle. diff --git a/drivers/iommu/intel-iommu.c
>> b/drivers/iommu/intel-iommu.c index 235837c50719..41439647f75d
>> 100644 --- a/drivers/iommu/intel-iommu.c +++
>> b/drivers/iommu/intel-iommu.c @@ -371,6 +371,7 @@ static int
>> dmar_forcedac; static int intel_iommu_strict; static int
>> intel_iommu_superpage = 1; static int iommu_identity_mapping; 
>> +static int intel_no_bounce;
> 
> intel_swiotlb_on = 1 ?
> 
>> 
>> #define IDENTMAP_ALL		1 #define IDENTMAP_GFX		2 @@ -384,6 +385,8 @@
>> EXPORT_SYMBOL_GPL(intel_iommu_gfx_mapped); static
>> DEFINE_SPINLOCK(device_domain_lock); static
>> LIST_HEAD(device_domain_list);
>> 
>> +#define device_needs_bounce(d) (!intel_no_bounce &&
>> dev_is_untrusted(d)) + /* * Iterate over elements in
>> device_domain_list and call the specified * callback @fn against
>> each element. @@ -466,6 +469,9 @@ static int __init
>> intel_iommu_setup(char *str) printk(KERN_INFO "Intel-IOMMU: not
>> forcing on after tboot. This could expose security risk for
>> tboot\n"); intel_iommu_tboot_noforce = 1; +		} else if
>> (!strncmp(str, "nobounce", 8)) { +			pr_info("Intel-IOMMU: No
>> bounce buffer. This could expose security risks of DMA
>> attacks\n");
> 
> Again, Intel-IOMMU: No SWIOTLB. T.. blah blah'
> 
> Asking for this as doing 'dmesg | grep SWIOTLB' will expose nicely
> all the SWIOTLB invocations..

Yes. Will refine this.

Best regards,
Baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
