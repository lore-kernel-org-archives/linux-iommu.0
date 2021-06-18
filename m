Return-Path: <SRS0=sMz+=LM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01ABC48BDF
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 18:32:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66500613EE
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 18:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66500613EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 324B460829;
	Fri, 18 Jun 2021 18:32:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4gV96Zupohhl; Fri, 18 Jun 2021 18:32:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0FEDC60819;
	Fri, 18 Jun 2021 18:32:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB40EC000D;
	Fri, 18 Jun 2021 18:32:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 872D3C000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 18:32:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 751CC82813
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 18:32:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5TWgxhlkmqZi for <iommu@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 18:32:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5718B82718
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 18:32:35 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93B121424;
 Fri, 18 Jun 2021 11:32:34 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0DB93F70D;
 Fri, 18 Jun 2021 11:32:32 -0700 (PDT)
Subject: Re: [PATCH v2 12/12] iommu: Do not allow IOMMU passthrough with
 Secure Launch
To: Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org, 
 x86@kernel.org, iommu@lists.linux-foundation.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org
References: <1624032777-7013-1-git-send-email-ross.philipson@oracle.com>
 <1624032777-7013-13-git-send-email-ross.philipson@oracle.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <53edcf0e-c094-876c-ac3d-7c9752e9ea99@arm.com>
Date: Fri, 18 Jun 2021 19:32:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1624032777-7013-13-git-send-email-ross.philipson@oracle.com>
Content-Language: en-GB
Cc: dpsmith@apertussolutions.com, luto@amacapital.net, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, tglx@linutronix.de,
 trenchboot-devel@googlegroups.com
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

On 2021-06-18 17:12, Ross Philipson wrote:
> The IOMMU should always be set to default translated type after
> the PMRs are disabled to protect the MLE from DMA.
> 
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>   drivers/iommu/intel/iommu.c | 5 +++++
>   drivers/iommu/iommu.c       | 6 +++++-
>   2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index be35284..4f0256d 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -41,6 +41,7 @@
>   #include <linux/dma-direct.h>
>   #include <linux/crash_dump.h>
>   #include <linux/numa.h>
> +#include <linux/slaunch.h>
>   #include <asm/irq_remapping.h>
>   #include <asm/cacheflush.h>
>   #include <asm/iommu.h>
> @@ -2877,6 +2878,10 @@ static bool device_is_rmrr_locked(struct device *dev)
>    */
>   static int device_def_domain_type(struct device *dev)
>   {
> +	/* Do not allow identity domain when Secure Launch is configured */
> +	if (slaunch_get_flags() & SL_FLAG_ACTIVE)
> +		return IOMMU_DOMAIN_DMA;

Is this specific to Intel? It seems like it could easily be done 
commonly like the check for untrusted external devices.

> +
>   	if (dev_is_pci(dev)) {
>   		struct pci_dev *pdev = to_pci_dev(dev);
>   
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 808ab70d..d49b7dd 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -23,6 +23,7 @@
>   #include <linux/property.h>
>   #include <linux/fsl/mc.h>
>   #include <linux/module.h>
> +#include <linux/slaunch.h>
>   #include <trace/events/iommu.h>
>   
>   static struct kset *iommu_group_kset;
> @@ -2761,7 +2762,10 @@ void iommu_set_default_passthrough(bool cmd_line)
>   {
>   	if (cmd_line)
>   		iommu_cmd_line |= IOMMU_CMD_LINE_DMA_API;
> -	iommu_def_domain_type = IOMMU_DOMAIN_IDENTITY;
> +
> +	/* Do not allow identity domain when Secure Launch is configured */
> +	if (!(slaunch_get_flags() & SL_FLAG_ACTIVE))
> +		iommu_def_domain_type = IOMMU_DOMAIN_IDENTITY;

Quietly ignoring the setting and possibly leaving iommu_def_domain_type 
uninitialised (note that 0 is not actually a usable type) doesn't seem 
great. AFAICS this probably warrants similar treatment to the 
mem_encrypt_active() case - there doesn't seem a great deal of value in 
trying to save users from themselves if they care about measured boot 
yet explicitly pass options which may compromise measured boot. If you 
really want to go down that route there's at least the sysfs interface 
you'd need to nobble as well, not to mention the various ways of 
completely disabling IOMMUs...

It might be reasonable to make IOMMU_DEFAULT_PASSTHROUGH depend on 
!SECURE_LAUNCH for clarity though.

Robin.

>   }
>   
>   void iommu_set_default_translated(bool cmd_line)
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
