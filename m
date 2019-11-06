Return-Path: <SRS0=/wjm=Y6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C6CC5DF63
	for <iommu@archiver.kernel.org>; Wed,  6 Nov 2019 18:42:37 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E90E217F4
	for <iommu@archiver.kernel.org>; Wed,  6 Nov 2019 18:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E90E217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0D29ED9D;
	Wed,  6 Nov 2019 18:42:37 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5C877B8A
	for <iommu@lists.linux-foundation.org>;
	Wed,  6 Nov 2019 18:42:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id AB149710
	for <iommu@lists.linux-foundation.org>;
	Wed,  6 Nov 2019 18:42:35 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
	by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	06 Nov 2019 10:42:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; d="scan'208";a="196297343"
Received: from chenyian-desk1.amr.corp.intel.com (HELO [10.3.52.63])
	([10.3.52.63])
	by orsmga008.jf.intel.com with ESMTP; 06 Nov 2019 10:42:34 -0800
Subject: Re: [PATCH v2] iommu/vt-d: Check VT-d RMRR region in BIOS is reported
	as reserved
To: iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>, Ashok Raj <ashok.raj@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>, Tony Luck <tony.luck@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Ravi Shankar <ravi.v.shankar@intel.com>
References: <20191017113919.25424-1-yian.chen@intel.com>
From: "Chen, Yian" <yian.chen@intel.com>
Message-ID: <0414c2e9-d94e-c370-4270-79f7278fb83d@intel.com>
Date: Wed, 6 Nov 2019 10:42:34 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191017113919.25424-1-yian.chen@intel.com>
Content-Language: en-US
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

Hi Joerg,

Do you have any further comment on this patch?

Thanks
Yian


On 10/17/2019 4:39 AM, Yian Chen wrote:
> VT-d RMRR (Reserved Memory Region Reporting) regions are reserved
> for device use only and should not be part of allocable memory pool of OS.
>
> BIOS e820_table reports complete memory map to OS, including OS usable
> memory ranges and BIOS reserved memory ranges etc.
>
> x86 BIOS may not be trusted to include RMRR regions as reserved type
> of memory in its e820 memory map, hence validate every RMRR entry
> with the e820 memory map to make sure the RMRR regions will not be
> used by OS for any other purposes.
>
> ia64 EFI is working fine so implement RMRR validation as a dummy function
>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
> Signed-off-by: Yian Chen <yian.chen@intel.com>
> ---
> v2:
> - return -EINVAL instead of -EFAULT when there is an error
> ---
>   arch/ia64/include/asm/iommu.h |  5 +++++
>   arch/x86/include/asm/iommu.h  | 18 ++++++++++++++++++
>   drivers/iommu/intel-iommu.c   |  8 +++++++-
>   3 files changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/arch/ia64/include/asm/iommu.h b/arch/ia64/include/asm/iommu.h
> index 7904f591a79b..eb0db20c9d4c 100644
> --- a/arch/ia64/include/asm/iommu.h
> +++ b/arch/ia64/include/asm/iommu.h
> @@ -2,6 +2,8 @@
>   #ifndef _ASM_IA64_IOMMU_H
>   #define _ASM_IA64_IOMMU_H 1
>   
> +#include <linux/acpi.h>
> +
>   /* 10 seconds */
>   #define DMAR_OPERATION_TIMEOUT (((cycles_t) local_cpu_data->itc_freq)*10)
>   
> @@ -9,6 +11,9 @@ extern void no_iommu_init(void);
>   #ifdef	CONFIG_INTEL_IOMMU
>   extern int force_iommu, no_iommu;
>   extern int iommu_detected;
> +
> +static inline int __init
> +arch_rmrr_sanity_check(struct acpi_dmar_reserved_memory *rmrr) { return 0; }
>   #else
>   #define no_iommu		(1)
>   #define iommu_detected		(0)
> diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
> index b91623d521d9..bf1ed2ddc74b 100644
> --- a/arch/x86/include/asm/iommu.h
> +++ b/arch/x86/include/asm/iommu.h
> @@ -2,10 +2,28 @@
>   #ifndef _ASM_X86_IOMMU_H
>   #define _ASM_X86_IOMMU_H
>   
> +#include <linux/acpi.h>
> +
> +#include <asm/e820/api.h>
> +
>   extern int force_iommu, no_iommu;
>   extern int iommu_detected;
>   
>   /* 10 seconds */
>   #define DMAR_OPERATION_TIMEOUT ((cycles_t) tsc_khz*10*1000)
>   
> +static inline int __init
> +arch_rmrr_sanity_check(struct acpi_dmar_reserved_memory *rmrr)
> +{
> +	u64 start = rmrr->base_address;
> +	u64 end = rmrr->end_address + 1;
> +
> +	if (e820__mapped_all(start, end, E820_TYPE_RESERVED))
> +		return 0;
> +
> +	pr_err(FW_BUG "No firmware reserved region can cover this RMRR [%#018Lx-%#018Lx], contact BIOS vendor for fixes\n",
> +	       start, end - 1);
> +	return -EINVAL;
> +}
> +
>   #endif /* _ASM_X86_IOMMU_H */
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 3f974919d3bd..722290014143 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -4306,13 +4306,19 @@ int __init dmar_parse_one_rmrr(struct acpi_dmar_header *header, void *arg)
>   {
>   	struct acpi_dmar_reserved_memory *rmrr;
>   	struct dmar_rmrr_unit *rmrru;
> +	int ret;
> +
> +	rmrr = (struct acpi_dmar_reserved_memory *)header;
> +	ret = arch_rmrr_sanity_check(rmrr);
> +	if (ret)
> +		return ret;
>   
>   	rmrru = kzalloc(sizeof(*rmrru), GFP_KERNEL);
>   	if (!rmrru)
>   		goto out;
>   
>   	rmrru->hdr = header;
> -	rmrr = (struct acpi_dmar_reserved_memory *)header;
> +
>   	rmrru->base_address = rmrr->base_address;
>   	rmrru->end_address = rmrr->end_address;
>   

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
