Return-Path: <SRS0=HAoA=WF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A92CC31E40
	for <iommu@archiver.kernel.org>; Fri,  9 Aug 2019 16:50:53 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11AE32086A
	for <iommu@archiver.kernel.org>; Fri,  9 Aug 2019 16:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11AE32086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C599EDBB;
	Fri,  9 Aug 2019 16:50:52 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2E1DDCA8
	for <iommu@lists.linux-foundation.org>;
	Fri,  9 Aug 2019 16:50:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from NAM05-BY2-obe.outbound.protection.outlook.com
	(mail-eopbgr710081.outbound.protection.outlook.com [40.107.71.81])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E147A76F
	for <iommu@lists.linux-foundation.org>;
	Fri,  9 Aug 2019 16:50:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=P3p0XdxFd5PNk0B1Dx1necgwDcqjnWZb5RcXWqFvpNz915ZSLnRnW+u0hPtc4GtCPC9dbP6qmp2O45xG+Xi9kTrWTCWfr6ZkIKWS7zBU9dowBuVQh8EDTVv/URhhvqw8lW9IUGvz3LtuyjWGZUOeT1+XXsIe7ekuvCHDqD5dmGSrDA4yCgcfEJHXebXpUJNsXl0KracAqKgNp8d01FoxFtdm7rB5CfWzzwdEDei0tBj9Jx5o6n6XRuMp8jre+mIv8tYIYk5T46+GWEcQNGyF4FQjFO2OV9uYAIwDGmTzwNlRQBRIedLSHagH0OYxoj4sBBPSd4B8z98og2dJDnzWLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=CHX32SBVQElESdgeTaGUtts5k30Jli91KfK+qmfEGKw=;
	b=CY5aTmGFqnbWmUB7RErtkLpdXY/UWEnjXG4W2U/VfQal1q2D66v4TK1zTaHjXDEHkDGrzM/4S2MXOUK3w+lRYxfe8GMmTLpI0Jxwa8AtYVPR6NVwGzM9/OYj+9lIB7s1EDzqvgx2KRkwAaPKlxHrkhiDVgNlbZ6xAtYLkw0+jSW7vDC8hodxRMnm8mOsRATbzM8UPzhpr0nhw/jsYFIsNvagZGJVhOjSxzr6UNJktgApu9tGWhWYA9VBYe0A/ER6JiMv+t1P/Jn4OLPFJBW4B6yRZpiZDnoSXn7CcyL0weIDk6f03PPnTsY81CJw//5ciLPjWLNWemf41cq+PyOCLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
	smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com;
	dkim=pass header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=CHX32SBVQElESdgeTaGUtts5k30Jli91KfK+qmfEGKw=;
	b=L7TkHwiTcbkBVA/+2lYWaF3v7btNClHoe7w0Dna6Fqb5LV9gEc74XEG5MGeD9sjOXj/i1jgmOWfOAUFeiBsevST4rIYBV7rdbgwJ3rc1W8okt0L980FcaqtM4RUUXer+4ray5jsIMfgasp99SDLYmfAABclOd4qfdPTJkjCybmM=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
	DM6PR12MB3113.namprd12.prod.outlook.com (20.178.31.19) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2136.12; Fri, 9 Aug 2019 16:50:49 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
	([fe80::9c3d:8593:906c:e4f7]) by
	DM6PR12MB3163.namprd12.prod.outlook.com
	([fe80::9c3d:8593:906c:e4f7%6]) with mapi id 15.20.2157.015;
	Fri, 9 Aug 2019 16:50:49 +0000
From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 3/3] iommu: Disable passthrough mode when SME is active
Thread-Topic: [PATCH 3/3] iommu: Disable passthrough mode when SME is active
Thread-Index: AQHVTsZIO8GEDV51QUKwXSImTUrW96bzB5aA
Date: Fri, 9 Aug 2019 16:50:48 +0000
Message-ID: <7f383631-ce2c-e7c2-ceff-e7418bf8ff29@amd.com>
References: <20190809152233.2829-1-joro@8bytes.org>
	<20190809152233.2829-4-joro@8bytes.org>
In-Reply-To: <20190809152233.2829-4-joro@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR06CA0032.namprd06.prod.outlook.com
	(2603:10b6:805:8e::45) To DM6PR12MB3163.namprd12.prod.outlook.com
	(2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.159.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5318726a-6675-4e3e-bad2-08d71ce9bb00
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
	SRVR:DM6PR12MB3113; 
x-ms-traffictypediagnostic: DM6PR12MB3113:
x-microsoft-antispam-prvs: <DM6PR12MB311343100FF35E3664177311ECD60@DM6PR12MB3113.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(4636009)(39850400004)(396003)(136003)(366004)(376002)(346002)(199004)(189003)(478600001)(25786009)(2616005)(86362001)(76176011)(102836004)(486006)(6512007)(186003)(476003)(11346002)(229853002)(6486002)(6116002)(2906002)(3846002)(14454004)(256004)(14444005)(6246003)(53936002)(6916009)(52116002)(99286004)(4326008)(66066001)(26005)(8936002)(66446008)(54906003)(36756003)(64756008)(5660300002)(66476007)(66556008)(66946007)(316002)(305945005)(71200400001)(446003)(31686004)(81156014)(8676002)(81166006)(53546011)(31696002)(6436002)(386003)(6506007)(7736002)(71190400001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3113;
	H:DM6PR12MB3163.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1VornK6UV0TVifiRmnW6xHqROpj2GYd41YgqW2JsoJa0ijYsZMp7e3/4a/CsnSu5CrGQoMxq9p6MRt3p7ldGEvyMkpCs7xVSTR2KZ47VVBBUM+cZvAVZ5xvNUM8dGAMwHgsquJ0/rcqHlmfdK9wAmJULzyrqLMz5fIkOfg849ZgGpFau8iE4P8WaTWb+HSmHkM0bAqW7RTsQ3Vh1i3lswd3pqdOTlHs7St5gazBfaKP69Zx1a9W3g0T0AmXGP0x6zTVdDFkJUfkolazfzWKlVZbuCUqgO1xpCEQCHNDhTwFSpkaH7F5PvO5lTsUlJuDbjIVPVbA/HSJw4eFvh+QlIL/cy0bJTQwkmDt+1Mk7hEkkLwroeRO5rDPQ3HcML7wQ1xCnsQpLAg0iwGKr3uVSi36QWVIr99OhA4uWqrR8fqE=
Content-ID: <DEB52BBA38B43F4B863084D137BFABE7@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5318726a-6675-4e3e-bad2-08d71ce9bb00
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 16:50:48.8528 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YrmnfTeufK0bExbMiuvOoJ4u7QpHLVhfph9fuABfO0R9AloT8QtuZol0U9ypHNSkou9VRDPTsPJg4CjX6JDfcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3113
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Joerg Roedel <jroedel@suse.de>, "bp@alien8.de" <bp@alien8.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On 8/9/19 10:22 AM, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Using Passthrough mode when SME is active causes certain
> devices to use the SWIOTLB bounce buffer. The bounce buffer
> code has an upper limit of 256kb for the size of DMA
> allocations, which is too small for certain devices and
> causes them to fail.
> 
> With this patch we enable IOMMU by default when SME is
> active in the system, making the default configuration work
> for more systems than it does now.
> 
> Users that don't want IOMMUs to be enabled still can disable
> them with kernel parameters.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>   drivers/iommu/iommu.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 62cae6db0970..fbe1aa51bce9 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -104,6 +104,12 @@ static int __init iommu_subsys_init(void)
>   	else
>   		iommu_def_domain_type = IOMMU_DOMAIN_DMA;
>   
> +	if ((iommu_def_domain_type == IOMMU_DOMAIN_IDENTITY) &&
> +	    sme_active()) {
> +		pr_info("SME detected - Disabling default IOMMU passthrough\n");
> +		iommu_def_domain_type = IOMMU_DOMAIN_DMA;

Should this also clear the iommu_pass_through variable (the one set by the
iommu kernel parameter in arch/x86/kernel/pci-dma.c)?

I guess this is more applicable to the original patchset that created the
CONFIG_IOMMU_DEFAULT_PASSTHROUGH option, but should the default
passthrough support be modified so that you don't have to specify multiple
kernel parameters to change it?

Right now, if CONFIG_IOMMU_DEFAULT_PASSTHROUGH is set to yes, you can't
just specify iommu=nopt to enable the IOMMU. You have to also specify
iommu.passthrough=0. Do we want to fix that so that just specifying
iommu=nopt or iommu.passthrough=0 does what is needed?

Thanks,
Tom

> +	}
> +
>   	pr_info("Default domain type: %s\n",
>   		iommu_domain_type_str(iommu_def_domain_type));
>   
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
