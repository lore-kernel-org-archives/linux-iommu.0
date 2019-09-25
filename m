Return-Path: <SRS0=izs0=XU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2747C4360C
	for <iommu@archiver.kernel.org>; Wed, 25 Sep 2019 15:56:17 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C83EC21D7A
	for <iommu@archiver.kernel.org>; Wed, 25 Sep 2019 15:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="vzIeFwYJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C83EC21D7A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B27DACDE;
	Wed, 25 Sep 2019 15:56:17 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6555CC5D
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 15:56:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com
	[207.171.190.10])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 98F53B0
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 15:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
	t=1569426976; x=1600962976;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-id:mime-version: content-transfer-encoding;
	bh=8eqYY9ur+BpjQow27NSR3PFHiC5sz74sI8XmBIPyaR0=;
	b=vzIeFwYJ2XgewKscqE/xllVtN1NwvhgYmNmM2ORm+bsQsLDt0A4D6swK
	zaSuJggyeW1vsw59cxsE41wgn0rXC/nkFkaGXu+42NHRH434bEQL0ZGEX
	WtgqkSPoduWuO2GLEMzArBvP65zwnzaH+Z36uaiq1ljcMNMQAmIqtKi4o Y=;
X-IronPort-AV: E=Sophos;i="5.64,548,1559520000"; d="scan'208";a="836749284"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO
	email-inbound-relay-2a-c5104f52.us-west-2.amazon.com) ([10.47.22.34])
	by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP;
	25 Sep 2019 15:55:36 +0000
Received: from EX13MTAUEA001.ant.amazon.com
	(pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
	by email-inbound-relay-2a-c5104f52.us-west-2.amazon.com (Postfix) with
	ESMTPS id 0CA38A1F99; Wed, 25 Sep 2019 15:55:24 +0000 (UTC)
Received: from EX13D02EUC004.ant.amazon.com (10.43.164.117) by
	EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server
	(TLS) id 15.0.1367.3; Wed, 25 Sep 2019 15:55:23 +0000
Received: from EX13D02EUC001.ant.amazon.com (10.43.164.92) by
	EX13D02EUC004.ant.amazon.com (10.43.164.117) with Microsoft SMTP Server
	(TLS) id 15.0.1367.3; Wed, 25 Sep 2019 15:55:22 +0000
Received: from EX13D02EUC001.ant.amazon.com ([10.43.164.92]) by
	EX13D02EUC001.ant.amazon.com ([10.43.164.92]) with mapi id
	15.00.1367.000; Wed, 25 Sep 2019 15:55:22 +0000
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 4/6] iommu/amd: Check for busy devices earlier in
	attach_device()
Thread-Topic: [PATCH 4/6] iommu/amd: Check for busy devices earlier in
	attach_device()
Thread-Index: AQHVc6Uve2NiguAZIEyX/zucqS5mP6c8i/qA
Date: Wed, 25 Sep 2019 15:55:21 +0000
Message-ID: <7FD56923-E57D-43BE-80FB-31D49A6D4D4A@amazon.de>
References: <20190925132300.3038-1-joro@8bytes.org>
	<20190925132300.3038-5-joro@8bytes.org>
In-Reply-To: <20190925132300.3038-5-joro@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.68]
Content-ID: <B721368C36C1F641B3CCDFC9A96FFEA1@amazon.com>
MIME-Version: 1.0
Precedence: Bulk
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"jroedel@suse.de" <jroedel@suse.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
> Check early in attach_device whether the device is already attached to a
> domain. This also simplifies the code path so that __attach_device() can
> be removed.
> 
> Fixes: 92d420ec028d ("iommu/amd: Relax locking in dma_ops path")
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
> drivers/iommu/amd_iommu.c | 25 +++++++------------------
> 1 file changed, 7 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 2919168577ff..459247c32dc0 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -2072,23 +2072,6 @@ static void do_detach(struct iommu_dev_data *dev_data)
> 	domain->dev_cnt                 -= 1;
> }
> 
> -/*
> - * If a device is not yet associated with a domain, this function makes the
> - * device visible in the domain
> - */
> -static int __attach_device(struct iommu_dev_data *dev_data,
> -			   struct protection_domain *domain)
> -{
> -	if (dev_data->domain != NULL)
> -		return -EBUSY;
> -
> -	/* Attach alias group root */
> -	do_attach(dev_data, domain);
> -
> -	return 0;
> -}
> -
> -
> static void pdev_iommuv2_disable(struct pci_dev *pdev)
> {
> 	pci_disable_ats(pdev);
> @@ -2174,6 +2157,10 @@ static int attach_device(struct device *dev,
> 
> 	dev_data = get_dev_data(dev);
> 
> +	ret = -EBUSY;
> +	if (dev_data->domain != NULL)
> +		goto out;
> +
> 	if (!dev_is_pci(dev))
> 		goto skip_ats_check;
> 
> @@ -2198,7 +2185,9 @@ static int attach_device(struct device *dev,
> 	}
> 
> skip_ats_check:
> -	ret = __attach_device(dev_data, domain);
> +	ret = 0;
> +
> +	do_attach(dev_data, domain);
> 
> 	/*
> 	 * We might boot into a crash-kernel here. The crashed kernel
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
