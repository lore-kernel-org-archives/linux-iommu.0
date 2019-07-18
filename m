Return-Path: <SRS0=oZX7=VP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F86C7618F
	for <iommu@archiver.kernel.org>; Thu, 18 Jul 2019 17:29:55 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8977B2083B
	for <iommu@archiver.kernel.org>; Thu, 18 Jul 2019 17:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KWAJqDln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8977B2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 526DB1AC5;
	Thu, 18 Jul 2019 17:29:55 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id F2CB01A3F
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Jul 2019 17:29:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
	(mail-eopbgr680071.outbound.protection.outlook.com [40.107.68.71])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B90018BF
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Jul 2019 17:29:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=J64l/XzY5QP8ronq/fmbuf9ueelpuX0+WsfWSeXJBnPC9wBDdDjJeFLXH/xr3bR6uMi4OgyzxZlScSgsUJKivtiPvytvrmP0jQyPOZfOjaIpoFo68fIvlhIt+LFYq9dO001EzjcP5Q9vAI592LkOVaAvYw+fAT16dbWnhmS+NN8OqfaayG3YR+QL5WuVqbr9jd28gTkl7nS6kxktQaSsMNXbCFHyIFPSYpcc+3+YXxW5vi4lQH74xm+PwIDm/ZAfkkGUW9PZLllrtskOneOWMwn/lvOnLnUhTfrbYYUHE/VpXITOOzoi2uSeVURjh8h/XQzUl9KnJ+vK15jTJtFOdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Ad+6b7kITJgXg4eMCaY92QAzPBBwQY35tBvaAL5/8ws=;
	b=Ncj+0nQa9VIame/3By3e7PeoGRnAbMVvQaQJtHLmVWUAwCj/30fLLWBNIiroOLB7529ZFQGKNe1GMcuN2KgCShgjGL1A5IhVt6xMzTvRsHAU4KYMblf26P7PftaXD1dm7DG/HwwZG1N11rZOCMJRt3lmT4yykIRe1ryAg7L8akbVO5xEoPHAknX0AH2kK63E3x4tWDdEMLE7RJ7dr+IBaa/EGLmTh8cibnrulY98kxLLRDN9tIBJGJ7F2K0P4hi2NEBEl257CvOG0Vcri7DAZbE86B1FPaT7nHNnQgUgLh9vq9JyC/dItdvCyFfsupZOhWeWRwNAgAOTqv/AFiRwRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
	smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com;
	dkim=pass header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Ad+6b7kITJgXg4eMCaY92QAzPBBwQY35tBvaAL5/8ws=;
	b=KWAJqDlnyCPMPyyvCQJ14nniAHQGxMYBwCQMU5yM3TmQw7yAmRknn6gIWKkpekJBJPFvjsA98lCmeUvvjPNik27WfqoLqeiJaWTjLOuImmE7hfdUm8C83inzsTu4LlhoNGhshEkJRfnHTpxGhW2+1qmmStJliGTYZ6Or6tgjQ8U=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
	DM6PR12MB3099.namprd12.prod.outlook.com (20.178.30.221) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2073.11; Thu, 18 Jul 2019 17:29:30 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
	([fe80::9c3d:8593:906c:e4f7]) by
	DM6PR12MB3163.namprd12.prod.outlook.com
	([fe80::9c3d:8593:906c:e4f7%6]) with mapi id 15.20.2073.012;
	Thu, 18 Jul 2019 17:29:30 +0000
From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v3 3/6] dma-mapping: Remove dma_check_mask()
Thread-Topic: [PATCH v3 3/6] dma-mapping: Remove dma_check_mask()
Thread-Index: AQHVPRkFgsylEpGHoUyUZi7jfgONZabQooCA
Date: Thu, 18 Jul 2019 17:29:30 +0000
Message-ID: <b11497b4-424b-ac42-e85b-e89524e67e8b@amd.com>
References: <20190718032858.28744-1-bauerman@linux.ibm.com>
	<20190718032858.28744-4-bauerman@linux.ibm.com>
In-Reply-To: <20190718032858.28744-4-bauerman@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0099.namprd12.prod.outlook.com
	(2603:10b6:802:21::34) To DM6PR12MB3163.namprd12.prod.outlook.com
	(2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08159723-7f29-4350-8322-08d70ba57db8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
	SRVR:DM6PR12MB3099; 
x-ms-traffictypediagnostic: DM6PR12MB3099:
x-microsoft-antispam-prvs: <DM6PR12MB3099C4EB9F221E315CB13570ECC80@DM6PR12MB3099.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 01026E1310
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(189003)(199004)(3846002)(25786009)(6486002)(6506007)(386003)(7736002)(71190400001)(53546011)(446003)(71200400001)(7416002)(36756003)(81166006)(316002)(81156014)(110136005)(6116002)(102836004)(68736007)(54906003)(6246003)(76176011)(31696002)(66066001)(6436002)(2501003)(5660300002)(8676002)(31686004)(64756008)(229853002)(66476007)(66446008)(26005)(476003)(486006)(2616005)(66946007)(52116002)(53936002)(8936002)(2906002)(186003)(478600001)(6512007)(14454004)(305945005)(86362001)(66556008)(4326008)(256004)(99286004)(11346002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3099;
	H:DM6PR12MB3163.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DyTU5flNDNBBCzjpAqzG1daGdOEdSIVLDhAjRZjhYFO0iSdyyghjrySaNAfY+wLI+1e7AHVMUT08kuV7tkFVu5rRs0pLpptsEdbb+Kve5ESjqoK235JvSCFjW7d77CIJYIabTas/S87OrhwesUtQNBLQwNSsRkNYIW0/zniR3+Zs1wspn7GCQNmGWzN+HpqZxtirA6nhLAe21VIAkUZu1ZpCe9aUK6sqgg3MPPfSYBIveqhlN7nQZ2sSn064K/MKkzGB4tWLfAo5hOtSP0E82sffeghk0AsqzJnOKLQ7Q8XTsyJkSXXbBa0YbTs6wlGW+el9gM30OGAQzIi6UzZO8TgBHYgwqx5GPvWlwtnexCKjqG1haU+QaZ9p0xiPtR7ri0SzT7ZIT9zQXwYKN4iZklYtQbd+uuavzv17brmrYNQ=
Content-ID: <65559D157A6B024188913D5CB53D72FA@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08159723-7f29-4350-8322-08d70ba57db8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2019 17:29:30.5136 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3099
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Robin Murphy <robin.murphy@arm.com>, Mike Anderson <andmike@linux.ibm.com>,
	Ram Pai <linuxram@us.ibm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Christoph Hellwig <hch@lst.de>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 7/17/19 10:28 PM, Thiago Jung Bauermann wrote:
> sme_active() is an x86-specific function so it's better not to call it from
> generic code. Christoph Hellwig mentioned that "There is no reason why we
> should have a special debug printk just for one specific reason why there
> is a requirement for a large DMA mask.", so just remove dma_check_mask().
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>  kernel/dma/mapping.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 1f628e7ac709..61eeefbfcb36 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -291,12 +291,6 @@ void dma_free_attrs(struct device *dev, size_t size, void *cpu_addr,
>  }
>  EXPORT_SYMBOL(dma_free_attrs);
>  
> -static inline void dma_check_mask(struct device *dev, u64 mask)
> -{
> -	if (sme_active() && (mask < (((u64)sme_get_me_mask() << 1) - 1)))
> -		dev_warn(dev, "SME is active, device will require DMA bounce buffers\n");
> -}
> -
>  int dma_supported(struct device *dev, u64 mask)
>  {
>  	const struct dma_map_ops *ops = get_dma_ops(dev);
> @@ -327,7 +321,6 @@ int dma_set_mask(struct device *dev, u64 mask)
>  		return -EIO;
>  
>  	arch_dma_set_mask(dev, mask);
> -	dma_check_mask(dev, mask);
>  	*dev->dma_mask = mask;
>  	return 0;
>  }
> @@ -345,7 +338,6 @@ int dma_set_coherent_mask(struct device *dev, u64 mask)
>  	if (!dma_supported(dev, mask))
>  		return -EIO;
>  
> -	dma_check_mask(dev, mask);
>  	dev->coherent_dma_mask = mask;
>  	return 0;
>  }
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
