Return-Path: <SRS0=qwh6=M2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D0FC4338F
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 18:50:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E411760F58
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 18:50:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E411760F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B01D540001;
	Tue,  3 Aug 2021 18:50:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 17e5wwB45TqY; Tue,  3 Aug 2021 18:50:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5FC2640209;
	Tue,  3 Aug 2021 18:50:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C12DC0010;
	Tue,  3 Aug 2021 18:50:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6AA5CC000E;
 Tue,  3 Aug 2021 18:50:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 59A80404DB;
 Tue,  3 Aug 2021 18:50:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linux.microsoft.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ErdKDDhxehgf; Tue,  3 Aug 2021 18:50:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by smtp4.osuosl.org (Postfix) with ESMTP id C76A540476;
 Tue,  3 Aug 2021 18:50:51 +0000 (UTC)
Received: from [192.168.1.115] (unknown [223.178.56.171])
 by linux.microsoft.com (Postfix) with ESMTPSA id A5C7C208AB1E;
 Tue,  3 Aug 2021 11:50:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A5C7C208AB1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1628016651;
 bh=yrbpSB1otFwR1Tu1Csab8DOioMdyKobhXI9/Ft52GG8=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=K4DGdAtk7yYMYs9z4xVcn10z4CVCrOraaCr75QTgoV4kqbgxkL71xW/EllD9G5cVD
 lW/HnybP6aDsZtXAxoQqSe21bWz6x7yYVV0km0Odz69sqgz2qhnpXXYHGtSU1K5m5e
 TPlyfD8ROLWzPNL/MBHwwYT+Lw6cv0iM2XWyOsVs=
Subject: Re: [RFC v1 6/8] mshv: command line option to skip devices in PV-IOMMU
To: Wei Liu <wei.liu@kernel.org>,
 Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
 <20210709114339.3467637-7-wei.liu@kernel.org>
From: Praveen Kumar <kumarpraveen@linux.microsoft.com>
Message-ID: <4a6918ea-e3e5-55c9-a12d-bee7261301fd@linux.microsoft.com>
Date: Wed, 4 Aug 2021 00:20:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210709114339.3467637-7-wei.liu@kernel.org>
Content-Language: en-US
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>, pasha.tatashin@soleen.com,
 Will Deacon <will@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 Michael Kelley <mikelley@microsoft.com>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 virtualization@lists.linux-foundation.org,
 Vineeth Pillai <viremana@linux.microsoft.com>
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

On 09-07-2021 17:13, Wei Liu wrote:
> Some devices may have been claimed by the hypervisor already. One such
> example is a user can assign a NIC for debugging purpose.
> 
> Ideally Linux should be able to tell retrieve that information, but
> there is no way to do that yet. And designing that new mechanism is
> going to take time.
> 
> Provide a command line option for skipping devices. This is a stopgap
> solution, so it is intentionally undocumented. Hopefully we can retire
> it in the future.
> 
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  drivers/iommu/hyperv-iommu.c | 45 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
> index 043dcff06511..353da5036387 100644
> --- a/drivers/iommu/hyperv-iommu.c
> +++ b/drivers/iommu/hyperv-iommu.c
> @@ -349,6 +349,16 @@ static const struct irq_domain_ops hyperv_root_ir_domain_ops = {
>  
>  #ifdef CONFIG_HYPERV_ROOT_PVIOMMU
>  
> +/* The IOMMU will not claim these PCI devices. */
> +static char *pci_devs_to_skip;
> +static int __init mshv_iommu_setup_skip(char *str) {
> +	pci_devs_to_skip = str;
> +
> +	return 0;
> +}
> +/* mshv_iommu_skip=(SSSS:BB:DD.F)(SSSS:BB:DD.F) */
> +__setup("mshv_iommu_skip=", mshv_iommu_setup_skip);
> +
>  /* DMA remapping support */
>  struct hv_iommu_domain {
>  	struct iommu_domain domain;
> @@ -774,6 +784,41 @@ static struct iommu_device *hv_iommu_probe_device(struct device *dev)
>  	if (!dev_is_pci(dev))
>  		return ERR_PTR(-ENODEV);
>  
> +	/*
> +	 * Skip the PCI device specified in `pci_devs_to_skip`. This is a
> +	 * temporary solution until we figure out a way to extract information
> +	 * from the hypervisor what devices it is already using.
> +	 */
> +	if (pci_devs_to_skip && *pci_devs_to_skip) {
> +		int pos = 0;
> +		int parsed;
> +		int segment, bus, slot, func;
> +		struct pci_dev *pdev = to_pci_dev(dev);
> +
> +		do {
> +			parsed = 0;
> +
> +			sscanf(pci_devs_to_skip + pos,
> +				" (%x:%x:%x.%x) %n",
> +				&segment, &bus, &slot, &func, &parsed);
> +
> +			if (parsed <= 0)
> +				break;
> +
> +			if (pci_domain_nr(pdev->bus) == segment &&
> +				pdev->bus->number == bus &&
> +				PCI_SLOT(pdev->devfn) == slot &&
> +				PCI_FUNC(pdev->devfn) == func)
> +			{
> +				dev_info(dev, "skipped by MSHV IOMMU\n");
> +				return ERR_PTR(-ENODEV);
> +			}
> +
> +			pos += parsed;
> +
> +		} while (pci_devs_to_skip[pos]);

Is there a possibility of pci_devs_to_skip + pos > sizeof(pci_devs_to_skip) and also a valid memory ?
I would recommend to have a check of size as well before accessing the array content, just to be safer accessing any memory.

> +	}
> +
>  	vdev = kzalloc(sizeof(*vdev), GFP_KERNEL);
>  	if (!vdev)
>  		return ERR_PTR(-ENOMEM);
> 

Regards,

~Praveen.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
