Return-Path: <SRS0=izs0=XU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E51EC432C2
	for <iommu@archiver.kernel.org>; Wed, 25 Sep 2019 15:57:14 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4199821D7C
	for <iommu@archiver.kernel.org>; Wed, 25 Sep 2019 15:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="gwXnZseS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4199821D7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 02840C5D;
	Wed, 25 Sep 2019 15:57:14 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B2E7DC5C
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 15:57:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8F12DB0
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 15:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
	t=1569427032; x=1600963032;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-id:mime-version: content-transfer-encoding;
	bh=VUEwdKuP/kzFngjG/5XuURw3t/aawwqlO7bpIG1qlTg=;
	b=gwXnZseS9oP0cREiASc1JXgXa9O2h2g023EGZSWBT2xgaGkJLqZ3AFl1
	ezECjJZmMDFD4vfhVYsAYcryyig5UAAObHDla6uFMtiDFpTmDmshUek7+
	sJXA6YcI1eyQcYaUO1wfszIYBlKMTmZpBA8bfFJ7BsvKuQrSIWdRQf6WK A=;
X-IronPort-AV: E=Sophos;i="5.64,548,1559520000"; d="scan'208";a="753161440"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO
	email-inbound-relay-2a-69849ee2.us-west-2.amazon.com)
	([10.124.125.2])
	by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP;
	25 Sep 2019 15:57:02 +0000
Received: from EX13MTAUEA001.ant.amazon.com
	(pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
	by email-inbound-relay-2a-69849ee2.us-west-2.amazon.com (Postfix) with
	ESMTPS id 63B9EA2670; Wed, 25 Sep 2019 15:57:02 +0000 (UTC)
Received: from EX13D02EUC001.ant.amazon.com (10.43.164.92) by
	EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server
	(TLS) id 15.0.1367.3; Wed, 25 Sep 2019 15:57:01 +0000
Received: from EX13D02EUC001.ant.amazon.com (10.43.164.92) by
	EX13D02EUC001.ant.amazon.com (10.43.164.92) with Microsoft SMTP Server
	(TLS) id 15.0.1367.3; Wed, 25 Sep 2019 15:57:00 +0000
Received: from EX13D02EUC001.ant.amazon.com ([10.43.164.92]) by
	EX13D02EUC001.ant.amazon.com ([10.43.164.92]) with mapi id
	15.00.1367.000; Wed, 25 Sep 2019 15:57:00 +0000
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 5/6] iommu/amd: Lock dev_data in attach/detach code paths
Thread-Topic: [PATCH 5/6] iommu/amd: Lock dev_data in attach/detach code paths
Thread-Index: AQHVc6RvHaFt/p3wrEefluEpeLbe86c8jHCA
Date: Wed, 25 Sep 2019 15:56:59 +0000
Message-ID: <EAD2F78C-DC79-401C-9781-B075BFD785E6@amazon.de>
References: <20190925132300.3038-1-joro@8bytes.org>
	<20190925132300.3038-6-joro@8bytes.org>
In-Reply-To: <20190925132300.3038-6-joro@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.166.48]
Content-ID: <B3913EA94E624442B54386F217459F58@amazon.com>
MIME-Version: 1.0
Cc: Filippo Sironi via iommu <iommu@lists.linux-foundation.org>,
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
> Make sure that attaching a detaching a device can't race against each
> other and protect the iommu_dev_data with a spin_lock in these code
> paths.
> 
> Fixes: 92d420ec028d ("iommu/amd: Relax locking in dma_ops path")
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
> drivers/iommu/amd_iommu.c       | 9 +++++++++
> drivers/iommu/amd_iommu_types.h | 3 +++
> 2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 459247c32dc0..bac4e20a5919 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -201,6 +201,7 @@ static struct iommu_dev_data *alloc_dev_data(u16 devid)
> 	if (!dev_data)
> 		return NULL;
> 
> +	spin_lock_init(&dev_data->lock);
> 	dev_data->devid = devid;
> 	ratelimit_default_init(&dev_data->rs);
> 
> @@ -2157,6 +2158,8 @@ static int attach_device(struct device *dev,
> 
> 	dev_data = get_dev_data(dev);
> 
> +	spin_lock(&dev_data->lock);
> +
> 	ret = -EBUSY;
> 	if (dev_data->domain != NULL)
> 		goto out;
> @@ -2199,6 +2202,8 @@ static int attach_device(struct device *dev,
> 	domain_flush_complete(domain);
> 
> out:
> +	spin_unlock(&dev_data->lock);
> +
> 	spin_unlock_irqrestore(&domain->lock, flags);
> 
> 	return ret;
> @@ -2218,6 +2223,8 @@ static void detach_device(struct device *dev)
> 
> 	spin_lock_irqsave(&domain->lock, flags);
> 
> +	spin_lock(&dev_data->lock);
> +
> 	/*
> 	 * First check if the device is still attached. It might already
> 	 * be detached from its domain because the generic
> @@ -2240,6 +2247,8 @@ static void detach_device(struct device *dev)
> 	dev_data->ats.enabled = false;
> 
> out:
> +	spin_unlock(&dev_data->lock);
> +
> 	spin_unlock_irqrestore(&domain->lock, flags);
> }
> 
> diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
> index 0186501ab971..c9c1612d52e0 100644
> --- a/drivers/iommu/amd_iommu_types.h
> +++ b/drivers/iommu/amd_iommu_types.h
> @@ -633,6 +633,9 @@ struct devid_map {
>  * This struct contains device specific data for the IOMMU
>  */
> struct iommu_dev_data {
> +	/*Protect against attach/detach races */
> +	spinlock_t lock;
> +
> 	struct list_head list;		  /* For domain->dev_list */
> 	struct llist_node dev_data_list;  /* For global dev_data_list */
> 	struct protection_domain *domain; /* Domain the device is bound to */
> -- 
> 2.17.1
> 

Reviewed-by: Filippo Sironi <sironi@amazon.de>



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
