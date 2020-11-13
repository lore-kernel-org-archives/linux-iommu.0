Return-Path: <SRS0=vtxH=ET=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42FEC55ABD
	for <iommu@archiver.kernel.org>; Fri, 13 Nov 2020 07:21:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B52A22201
	for <iommu@archiver.kernel.org>; Fri, 13 Nov 2020 07:21:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B52A22201
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BF701873B5;
	Fri, 13 Nov 2020 07:21:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YgfuT1p0pDIr; Fri, 13 Nov 2020 07:21:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A41C8873A8;
	Fri, 13 Nov 2020 07:21:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 939A4C163C;
	Fri, 13 Nov 2020 07:21:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E6E3C0FAA
 for <iommu@lists.linux-foundation.org>; Fri, 13 Nov 2020 07:21:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5B7C320489
 for <iommu@lists.linux-foundation.org>; Fri, 13 Nov 2020 07:21:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GyDfXRfHailp for <iommu@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 07:21:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by silver.osuosl.org (Postfix) with ESMTPS id 92CE220198
 for <iommu@lists.linux-foundation.org>; Fri, 13 Nov 2020 07:21:06 +0000 (UTC)
IronPort-SDR: TiDyn77tVNMR8bBFW8HgwsTlnAmSRb4Zqnn5tBJoLH6yZElN3B5Pm2z0i8ycXUxIa/XLqRMvQi
 tBZAj+ChMhGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="170607086"
X-IronPort-AV: E=Sophos;i="5.77,474,1596524400"; d="scan'208";a="170607086"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2020 23:21:01 -0800
IronPort-SDR: EONXJF7YvBQvv6j5Nm8hLVoWEA4SJGRtIy3wvSNf/su8bmK+TZUrddVSFriM57SurvPJggLmbO
 nBpzcdy8a2xQ==
X-IronPort-AV: E=Sophos;i="5.77,474,1596524400"; d="scan'208";a="542568340"
Received: from zhangn1-mobl2.ccr.corp.intel.com (HELO [10.254.209.85])
 ([10.254.209.85])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2020 23:20:57 -0800
To: Thomas Gleixner <tglx@linutronix.de>, Jason Gunthorpe <jgg@nvidia.com>,
 Ziyad Atiyyeh <ziyadat@nvidia.com>, Itay Aveksis <itayav@nvidia.com>,
 Moshe Shemesh <moshe@nvidia.com>
References: <20200826111628.794979401@linutronix.de>
 <20201112125531.GA873287@nvidia.com> <87mtzmmzk6.fsf@nanos.tec.linutronix.de>
 <87k0uqmwn4.fsf@nanos.tec.linutronix.de>
 <87d00imlop.fsf@nanos.tec.linutronix.de>
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: iommu/vt-d: Cure VF irqdomain hickup
Message-ID: <f507c2cf-f628-3b79-6c36-8ad8a10bb69c@linux.intel.com>
Date: Fri, 13 Nov 2020 15:20:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <87d00imlop.fsf@nanos.tec.linutronix.de>
Content-Language: en-US
Cc: linux-pci@vger.kernel.org, x86@kernel.org,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Marc Zyngier <maz@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 David Woodhouse <dwmw2@infradead.org>
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

On 2020/11/13 3:15, Thomas Gleixner wrote:
> The recent changes to store the MSI irqdomain pointer in struct device
> missed that Intel DMAR does not register virtual function devices.  Due to
> that a VF device gets the plain PCI-MSI domain assigned and then issues
> compat MSI messages which get caught by the interrupt remapping unit.
> 
> Cure that by inheriting the irq domain from the physical function
> device.
> 
> That's a temporary workaround. The correct fix is to inherit the irq domain
> from the bus, but that's a larger effort which needs quite some other
> changes to the way how x86 manages PCI and MSI domains.
> 
> Fixes: 85a8dfc57a0b ("iommm/vt-d: Store irq domain in struct device")
> Reported-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   drivers/iommu/intel/dmar.c |   19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
> 
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -333,6 +333,11 @@ static void  dmar_pci_bus_del_dev(struct
>   	dmar_iommu_notify_scope_dev(info);
>   }
>   
> +static inline void vf_inherit_msi_domain(struct pci_dev *pdev)
> +{
> +	dev_set_msi_domain(&pdev->dev, dev_get_msi_domain(&pdev->physfn->dev));
> +}
> +
>   static int dmar_pci_bus_notifier(struct notifier_block *nb,
>   				 unsigned long action, void *data)
>   {
> @@ -342,8 +347,20 @@ static int dmar_pci_bus_notifier(struct
>   	/* Only care about add/remove events for physical functions.
>   	 * For VFs we actually do the lookup based on the corresponding
>   	 * PF in device_to_iommu() anyway. */
> -	if (pdev->is_virtfn)
> +	if (pdev->is_virtfn) {
> +		/*
> +		 * Note: This is a horrible hack and needs to be cleaned
> +		 * up by assigning the domain to the bus, but that's too
> +		 * big of a change for post rc3.
> +		 *
> +		 * Ensure that the VF device inherits the irq domain of the
> +		 * PF device:
> +		 */
> +		if (action == BUS_NOTIFY_ADD_DEVICE)
> +			vf_inherit_msi_domain(pdev);
>   		return NOTIFY_DONE;
> +	}
> +
>   	if (action != BUS_NOTIFY_ADD_DEVICE &&
>   	    action != BUS_NOTIFY_REMOVED_DEVICE)
>   		return NOTIFY_DONE;

We also encountered this problem in internal testing. This patch can
solve the problem.

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
