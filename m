Return-Path: <SRS0=ishi=27=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32E1C282DD
	for <iommu@archiver.kernel.org>; Fri, 10 Jan 2020 19:27:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A193C2082E
	for <iommu@archiver.kernel.org>; Fri, 10 Jan 2020 19:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A193C2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 61AA7226B0;
	Fri, 10 Jan 2020 19:27:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RJcagMZI+8rv; Fri, 10 Jan 2020 19:27:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3B64120365;
	Fri, 10 Jan 2020 19:27:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E83FC1D7D;
	Fri, 10 Jan 2020 19:27:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80538C0881
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 19:27:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7C69D86092
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 19:27:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 27wAFMzVKLYC for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jan 2020 19:27:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 703E485FFD
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 19:27:03 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Jan 2020 11:27:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,418,1571727600"; d="scan'208";a="396531119"
Received: from chenyian-desk1.amr.corp.intel.com (HELO [10.3.52.63])
 ([10.3.52.63])
 by orsmga005.jf.intel.com with ESMTP; 10 Jan 2020 11:27:02 -0800
Subject: Re: [PATCH v2 2/2] iommu/vt-d: skip invalid RMRR entries
To: Barret Rhoden <brho@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, Sohil Mehta <sohil.mehta@intel.com>
References: <20200107191610.178185-1-brho@google.com>
 <20200107191610.178185-3-brho@google.com>
From: "Chen, Yian" <yian.chen@intel.com>
Message-ID: <572361a3-b5ae-6717-307c-e0f14d7930cd@intel.com>
Date: Fri, 10 Jan 2020 11:27:02 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200107191610.178185-3-brho@google.com>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
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

Hi Barret,

this looks good.

thanks
Yian

On 1/7/2020 11:16 AM, Barret Rhoden wrote:
> The VT-d docs specify requirements for the RMRR entries base and end
> (called 'Limit' in the docs) addresses.
>
> This commit will cause the DMAR processing to skip any RMRR entries that
> do not meet these requirements and mark the firmware as tainted, since
> the firmware is giving us junk.
>
> Signed-off-by: Barret Rhoden <brho@google.com>
> ---
>   drivers/iommu/intel-iommu.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index a8bb458845bc..32c3c6338a3d 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -4315,13 +4315,25 @@ static void __init init_iommu_pm_ops(void)
>   static inline void init_iommu_pm_ops(void) {}
>   #endif	/* CONFIG_PM */
>   
> +static int rmrr_validity_check(struct acpi_dmar_reserved_memory *rmrr)
> +{
> +	if ((rmrr->base_address & PAGE_MASK) ||
> +	    (rmrr->end_address <= rmrr->base_address) ||
> +	    ((rmrr->end_address - rmrr->base_address + 1) & PAGE_MASK)) {
> +		pr_err(FW_BUG "Broken RMRR base: %#018Lx end: %#018Lx\n",
> +		       rmrr->base_address, rmrr->end_address);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
>   int __init dmar_parse_one_rmrr(struct acpi_dmar_header *header, void *arg)
>   {
>   	struct acpi_dmar_reserved_memory *rmrr;
>   	struct dmar_rmrr_unit *rmrru;
>   
>   	rmrr = (struct acpi_dmar_reserved_memory *)header;
> -	if (arch_rmrr_sanity_check(rmrr)) {
> +	if (rmrr_validity_check(rmrr) || arch_rmrr_sanity_check(rmrr)) {
>   		WARN_TAINT(1, TAINT_FIRMWARE_WORKAROUND,
>   			   "Your BIOS is broken; bad RMRR [%#018Lx-%#018Lx]\n"
>   			   "BIOS vendor: %s; Ver: %s; Product Version: %s\n",

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
