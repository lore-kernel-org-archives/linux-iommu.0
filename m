Return-Path: <SRS0=0DsW=3G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55988C33CB1
	for <iommu@archiver.kernel.org>; Fri, 17 Jan 2020 10:08:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FE0C21835
	for <iommu@archiver.kernel.org>; Fri, 17 Jan 2020 10:08:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE0C21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 012B086BB4;
	Fri, 17 Jan 2020 10:08:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1bnux6WwB+Jx; Fri, 17 Jan 2020 10:08:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4048485F38;
	Fri, 17 Jan 2020 10:08:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12584C18DC;
	Fri, 17 Jan 2020 10:08:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 471A8C077D
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jan 2020 10:08:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 422AD1FEDF
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jan 2020 10:08:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P4b1RVSIML80 for <iommu@lists.linux-foundation.org>;
 Fri, 17 Jan 2020 10:08:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id CBD6420104
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jan 2020 10:08:32 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 59032327; Fri, 17 Jan 2020 11:08:31 +0100 (CET)
Date: Fri, 17 Jan 2020 11:08:29 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Shuah Khan <skhan@linuxfoundation.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] iommu: amd: Fix IOMMU perf counter clobbering during init
Message-ID: <20200117100829.GE15760@8bytes.org>
References: <20200114151220.29578-1-skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200114151220.29578-1-skhan@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Adding Suravee, who wrote the IOMMU Perf Counter code.

On Tue, Jan 14, 2020 at 08:12:20AM -0700, Shuah Khan wrote:
> init_iommu_perf_ctr() clobbers the register when it checks write access
> to IOMMU perf counters and fails to restore when they are writable.
> 
> Add save and restore to fix it.
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  drivers/iommu/amd_iommu_init.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)

Suravee, can you please review this patch?

> 
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index 568c52317757..c0ad4f293522 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -1655,27 +1655,37 @@ static int iommu_pc_get_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
>  static void init_iommu_perf_ctr(struct amd_iommu *iommu)
>  {
>  	struct pci_dev *pdev = iommu->dev;
> -	u64 val = 0xabcd, val2 = 0;
> +	u64 val = 0xabcd, val2 = 0, save_reg = 0;
>  
>  	if (!iommu_feature(iommu, FEATURE_PC))
>  		return;
>  
>  	amd_iommu_pc_present = true;
>  
> +	/* save the value to restore, if writable */
> +	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, false))
> +		goto pc_false;
> +
>  	/* Check if the performance counters can be written to */
>  	if ((iommu_pc_get_set_reg(iommu, 0, 0, 0, &val, true)) ||
>  	    (iommu_pc_get_set_reg(iommu, 0, 0, 0, &val2, false)) ||
> -	    (val != val2)) {
> -		pci_err(pdev, "Unable to write to IOMMU perf counter.\n");
> -		amd_iommu_pc_present = false;
> -		return;
> -	}
> +	    (val != val2))
> +		goto pc_false;
> +
> +	/* restore */
> +	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, true))
> +		goto pc_false;
>  
>  	pci_info(pdev, "IOMMU performance counters supported\n");
>  
>  	val = readl(iommu->mmio_base + MMIO_CNTR_CONF_OFFSET);
>  	iommu->max_banks = (u8) ((val >> 12) & 0x3f);
>  	iommu->max_counters = (u8) ((val >> 7) & 0xf);
> +
> +pc_false:
> +	pci_err(pdev, "Unable to read/write to IOMMU perf counter.\n");
> +	amd_iommu_pc_present = false;
> +	return;
>  }
>  
>  static ssize_t amd_iommu_show_cap(struct device *dev,
> -- 
> 2.20.1
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
