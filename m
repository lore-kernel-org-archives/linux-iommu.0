Return-Path: <SRS0=izs0=XU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA50C432C2
	for <iommu@archiver.kernel.org>; Wed, 25 Sep 2019 15:50:56 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B154221D7B
	for <iommu@archiver.kernel.org>; Wed, 25 Sep 2019 15:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="XuEqKdtm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B154221D7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9A5AEDC2;
	Wed, 25 Sep 2019 15:50:56 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 42D56D9D
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 15:50:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7C6C08B5
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 15:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
	t=1569426653; x=1600962653;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-id:mime-version: content-transfer-encoding;
	bh=2LUdJMEXXXK20G9OYAMZ9UJStuWi0sCs+r9ISTW7GDo=;
	b=XuEqKdtmxTlkMjN9ezyJVpX31QK8JHj5dQpWkq4J3Bhm25qG0NbF2GPo
	m+k+Ww8vxsDtQUnJlvCW5zhv8noW3rq92dJHsBAPn6k18vxIxdz9Uwdbn
	ljPmgqZ7vnr3YJJSpoNtdV9wEz7VncMuPmSyrqCiQVvhsLRKMVtU9jNiC s=;
X-IronPort-AV: E=Sophos;i="5.64,548,1559520000"; d="scan'208";a="753159685"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO
	email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com)
	([10.124.125.2])
	by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP;
	25 Sep 2019 15:50:43 +0000
Received: from EX13MTAUEA001.ant.amazon.com
	(iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
	by email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com (Postfix) with
	ESMTPS id AD5472820E2; Wed, 25 Sep 2019 15:50:41 +0000 (UTC)
Received: from EX13D02EUC004.ant.amazon.com (10.43.164.117) by
	EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server
	(TLS) id 15.0.1367.3; Wed, 25 Sep 2019 15:50:40 +0000
Received: from EX13D02EUC001.ant.amazon.com (10.43.164.92) by
	EX13D02EUC004.ant.amazon.com (10.43.164.117) with Microsoft SMTP Server
	(TLS) id 15.0.1367.3; Wed, 25 Sep 2019 15:50:40 +0000
Received: from EX13D02EUC001.ant.amazon.com ([10.43.164.92]) by
	EX13D02EUC001.ant.amazon.com ([10.43.164.92]) with mapi id
	15.00.1367.000; Wed, 25 Sep 2019 15:50:39 +0000
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 2/6] iommu/amd: Remove amd_iommu_devtable_lock
Thread-Topic: [PATCH 2/6] iommu/amd: Remove amd_iommu_devtable_lock
Thread-Index: AQHVc6SDZEQPYSUGmEKCyZ9GS9cQuac8iqmA
Date: Wed, 25 Sep 2019 15:50:38 +0000
Message-ID: <ABED92CE-D4E0-4DC0-BA2E-E7C66B6833A6@amazon.de>
References: <20190925132300.3038-1-joro@8bytes.org>
	<20190925132300.3038-3-joro@8bytes.org>
In-Reply-To: <20190925132300.3038-3-joro@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.196]
Content-ID: <E2350CE7815F0F4789B5C66CF9B1DA1E@amazon.com>
MIME-Version: 1.0
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"jroedel@suse.de" <jroedel@suse.de>
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
From: "Sironi, Filippo via iommu" <iommu@lists.linux-foundation.org>
Reply-To: "Sironi, Filippo" <sironi@amazon.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org



> On 25. Sep 2019, at 06:22, Joerg Roedel <joro@8bytes.org> wrote:
> 
> From: Joerg Roedel <jroedel@suse.de>
> 
> The lock is not necessary because the device table does not
> contain shared state that needs protection. Locking is only
> needed on an individual entry basis, and that needs to
> happen on the iommu_dev_data level.
> 
> Fixes: 92d420ec028d ("iommu/amd: Relax locking in dma_ops path")
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
> drivers/iommu/amd_iommu.c | 23 ++++++-----------------
> 1 file changed, 6 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 042854bbc5bc..37a9c04fc728 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -70,7 +70,6 @@
>  */
> #define AMD_IOMMU_PGSIZES	((~0xFFFUL) & ~(2ULL << 38))
> 
> -static DEFINE_SPINLOCK(amd_iommu_devtable_lock);
> static DEFINE_SPINLOCK(pd_bitmap_lock);
> 
> /* List of all available dev_data structures */
> @@ -2080,10 +2079,11 @@ static void do_detach(struct iommu_dev_data *dev_data)
> static int __attach_device(struct iommu_dev_data *dev_data,
> 			   struct protection_domain *domain)
> {
> +	unsigned long flags;
> 	int ret;
> 
> 	/* lock domain */
> -	spin_lock(&domain->lock);
> +	spin_lock_irqsave(&domain->lock, flags);
> 
> 	ret = -EBUSY;
> 	if (dev_data->domain != NULL)
> @@ -2097,7 +2097,7 @@ static int __attach_device(struct iommu_dev_data *dev_data,
> out_unlock:
> 
> 	/* ready */
> -	spin_unlock(&domain->lock);
> +	spin_unlock_irqrestore(&domain->lock, flags);
> 
> 	return ret;
> }
> @@ -2181,7 +2181,6 @@ static int attach_device(struct device *dev,
> {
> 	struct pci_dev *pdev;
> 	struct iommu_dev_data *dev_data;
> -	unsigned long flags;
> 	int ret;
> 
> 	dev_data = get_dev_data(dev);
> @@ -2209,9 +2208,7 @@ static int attach_device(struct device *dev,
> 	}
> 
> skip_ats_check:
> -	spin_lock_irqsave(&amd_iommu_devtable_lock, flags);
> 	ret = __attach_device(dev_data, domain);
> -	spin_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
> 
> 	/*
> 	 * We might boot into a crash-kernel here. The crashed kernel
> @@ -2231,14 +2228,15 @@ static int attach_device(struct device *dev,
> static void __detach_device(struct iommu_dev_data *dev_data)
> {
> 	struct protection_domain *domain;
> +	unsigned long flags;
> 
> 	domain = dev_data->domain;
> 
> -	spin_lock(&domain->lock);
> +	spin_lock_irqsave(&domain->lock, flags);
> 
> 	do_detach(dev_data);
> 
> -	spin_unlock(&domain->lock);
> +	spin_unlock_irqrestore(&domain->lock, flags);
> }
> 
> /*
> @@ -2248,7 +2246,6 @@ static void detach_device(struct device *dev)
> {
> 	struct protection_domain *domain;
> 	struct iommu_dev_data *dev_data;
> -	unsigned long flags;
> 
> 	dev_data = get_dev_data(dev);
> 	domain   = dev_data->domain;
> @@ -2262,10 +2259,7 @@ static void detach_device(struct device *dev)
> 	if (WARN_ON(!dev_data->domain))
> 		return;
> 
> -	/* lock device table */
> -	spin_lock_irqsave(&amd_iommu_devtable_lock, flags);
> 	__detach_device(dev_data);
> -	spin_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
> 
> 	if (!dev_is_pci(dev))
> 		return;
> @@ -2910,9 +2904,6 @@ int __init amd_iommu_init_dma_ops(void)
> static void cleanup_domain(struct protection_domain *domain)
> {
> 	struct iommu_dev_data *entry;
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&amd_iommu_devtable_lock, flags);
> 
> 	while (!list_empty(&domain->dev_list)) {
> 		entry = list_first_entry(&domain->dev_list,
> @@ -2920,8 +2911,6 @@ static void cleanup_domain(struct protection_domain *domain)
> 		BUG_ON(!entry->domain);
> 		__detach_device(entry);
> 	}
> -
> -	spin_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
> }

I'm guessing that it is free not to take the domain lock in cleanup_domain
since this is called when free-ing the domain.  Right?

> static void protection_domain_free(struct protection_domain *domain)
> -- 
> 2.17.1
> 




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Ralf Herbrich
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
