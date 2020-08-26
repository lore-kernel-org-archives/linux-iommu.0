Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029AEC433E1
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 17:31:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3185207BC
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 17:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3185207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BE0D5875EA;
	Wed, 26 Aug 2020 17:31:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gg33bkfMiTBV; Wed, 26 Aug 2020 17:31:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E5888875E0;
	Wed, 26 Aug 2020 17:31:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB0BCC0891;
	Wed, 26 Aug 2020 17:31:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8EEFDC0051
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 16:50:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7D73186399
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 16:50:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KtruQgZI9qDr for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 16:50:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A559286B0E
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 16:50:31 +0000 (UTC)
IronPort-SDR: MBcJmdnLmA088P/iyBVRAMEN3DS4cGEwCNntMvy9ATCZLgmsDOXGbayGCRH7tFcXk0C3kBBiIR
 u+T7DUi6BFXw==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="136398702"
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; d="scan'208";a="136398702"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2020 09:50:30 -0700
IronPort-SDR: O+tRoc/59eCGpVLJON72igRMmtjnFMq9wo28apgxlygz1/37A+zdeFZDDyibhT3bW+C7JSBdFz
 MbToSWPlnzpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; d="scan'208";a="444115517"
Received: from orsmsx606-2.jf.intel.com (HELO ORSMSX606.amr.corp.intel.com)
 ([10.22.229.86])
 by orsmga004.jf.intel.com with ESMTP; 26 Aug 2020 09:50:30 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 26 Aug 2020 09:50:30 -0700
Received: from orsmsx101.amr.corp.intel.com (10.22.225.128) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 26 Aug 2020 09:50:30 -0700
Received: from [10.212.160.45] (10.212.160.45) by ORSMSX101.amr.corp.intel.com
 (10.22.225.128) with Microsoft SMTP Server (TLS) id 14.3.439.0;
 Wed, 26 Aug 2020 09:50:29 -0700
Subject: Re: [patch V2 15/46] x86/irq: Consolidate DMAR irq allocation
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
References: <20200826111628.794979401@linutronix.de>
 <20200826112332.163462706@linutronix.de>
From: "Dey, Megha" <megha.dey@intel.com>
Message-ID: <812d9647-ad2e-95e9-aa99-b54ff7ebc52d@intel.com>
Date: Wed, 26 Aug 2020 09:50:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200826112332.163462706@linutronix.de>
Content-Language: en-US
X-Originating-IP: [10.212.160.45]
X-Mailman-Approved-At: Wed, 26 Aug 2020 17:31:19 +0000
Cc: Dimitri Sivanich <sivanich@hpe.com>, linux-hyperv@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, linux-pci@vger.kernel.org, "K. Y.
 Srinivasan" <kys@microsoft.com>, Dan Williams <dan.j.williams@intel.com>,
 Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 Baolu Lu <baolu.lu@intel.com>, Marc Zyngier <maz@kernel.org>, x86@kernel.org,
 Jason Gunthorpe <jgg@mellanox.com>, xen-devel@lists.xenproject.org,
 Kevin Tian <kevin.tian@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Alex Williamson <alex.williamson@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Jon Derrick <jonathan.derrick@intel.com>, Juergen Gross <jgross@suse.com>,
 Russ
 Anderson <rja@hpe.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 iommu@lists.linux-foundation.org, Jacob Pan <jacob.jun.pan@intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
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

Hi Thomas,

On 8/26/2020 4:16 AM, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
>
> None of the DMAR specific fields are required.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>
> ---
>   arch/x86/include/asm/hw_irq.h |    6 ------
>   arch/x86/kernel/apic/msi.c    |   10 +++++-----
>   2 files changed, 5 insertions(+), 11 deletions(-)
>
> --- a/arch/x86/include/asm/hw_irq.h
> +++ b/arch/x86/include/asm/hw_irq.h
> @@ -83,12 +83,6 @@ struct irq_alloc_info {
>   			irq_hw_number_t	msi_hwirq;
>   		};
>   #endif
> -#ifdef	CONFIG_DMAR_TABLE
> -		struct {
> -			int		dmar_id;
> -			void		*dmar_data;
> -		};
> -#endif
>   #ifdef	CONFIG_X86_UV
>   		struct {
>   			int		uv_limit;
> --- a/arch/x86/kernel/apic/msi.c
> +++ b/arch/x86/kernel/apic/msi.c
> @@ -329,15 +329,15 @@ static struct irq_chip dmar_msi_controll
>   static irq_hw_number_t dmar_msi_get_hwirq(struct msi_domain_info *info,
>   					  msi_alloc_info_t *arg)
>   {
> -	return arg->dmar_id;
> +	return arg->hwirq;

Shouldn't this return the arg->devid which gets set in dmar_alloc_hwirq?

-Megha

>   }
>   
>   static int dmar_msi_init(struct irq_domain *domain,
>   			 struct msi_domain_info *info, unsigned int virq,
>   			 irq_hw_number_t hwirq, msi_alloc_info_t *arg)
>   {
> -	irq_domain_set_info(domain, virq, arg->dmar_id, info->chip, NULL,
> -			    handle_edge_irq, arg->dmar_data, "edge");
> +	irq_domain_set_info(domain, virq, arg->devid, info->chip, NULL,
> +			    handle_edge_irq, arg->data, "edge");
>   
>   	return 0;
>   }
> @@ -384,8 +384,8 @@ int dmar_alloc_hwirq(int id, int node, v
>   
>   	init_irq_alloc_info(&info, NULL);
>   	info.type = X86_IRQ_ALLOC_TYPE_DMAR;
> -	info.dmar_id = id;
> -	info.dmar_data = arg;
> +	info.devid = id;
> +	info.data = arg;
>   
>   	return irq_domain_alloc_irqs(domain, 1, node, &info);
>   }
>
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
