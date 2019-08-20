Return-Path: <SRS0=xQF/=WQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77560C3A59E
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 21:18:10 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AC612332B
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 21:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gsb4hviy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AC612332B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 365C2D3D;
	Tue, 20 Aug 2019 21:18:10 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id F0C43D39
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 21:18:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
	(mail-eopbgr770081.outbound.protection.outlook.com [40.107.77.81])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6329387
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 21:18:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=AkGlmK6//3dQwCuMSJE7Jq/y/75l2Vr67NlKB0RmuVwiXyRmWc84v7/HdFN/2KqE3odHCDJYnTu4upJ85cVqXY4tpREZtzBlk+C+EiQHOB9Gq8nYE1hBwhOQKpOnOlYE2NrmFCZy6GTB9Zx/JNDo1QsSp9wAw/9OCCz2iunQG/5Cfwj7xmpkGTOD0a3/xH2DZRHnZWC5PQxj2tNoDFe6iDcMinx2nXSQyfnKkt+/2eP1ps61z8dVBP0OrBEDn0UjDDDwzv1JJUJ0s/06b9VpXxOAOLPfkmocvTjSUnX0tf97nX/EtpeTigzYiUBrvX8axUHRgWSXeqMM+8Yp/xrY7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=9pOeAZzvXzUvvfRo+vaIGMMWB2tK4f2bDWbGMZAkbj4=;
	b=GHKE1Vq0FNiFfuLqZ0xCgLLanjwL2glxGoX4KQNp5CToWbLshvLbRI9Q3irABfHxLYvMaFuNbtisHDbrAMdXUxmY+dhvlgd1K+sPnHfbBFMaILPsespGl6W6ls8oO9uO46KzMUxn3ag628sP4kwXC1tmTmm7St44SrFbADYCG8tQ13LW32sxJA6rdSKs7BgGaQC8cERhc/hT/RpiOIc/5coPXe6FE8/parViwdBMqEvB1lcJXE2Ok1vYsoDKnzxhKUTGMmim+mVlYoiwLjYr9ENfih66v9vWtCkhbcXJqboc2zuiBN1/W8ygbTfJ07941pm6UJx60u7UZ0CzQqkZqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
	smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com;
	dkim=pass header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=9pOeAZzvXzUvvfRo+vaIGMMWB2tK4f2bDWbGMZAkbj4=;
	b=gsb4hviy8akl6MaZ4G2T/ZE5wYMnzl3rwwUf3bBcLRUzJUE61pZb4QVvP8IjaOzBbtwg1EqcXPchgV3p3StiEAXc3fTOmnnc3CSETXRq4n3KWq3hLBYfFaN3jYwnBWT3fUHOjezRS18TLg7/FY62+mgrdcfJ4T8Cjo1YH/3WP5g=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
	DM6PR12MB3771.namprd12.prod.outlook.com (10.255.172.212) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2178.18; Tue, 20 Aug 2019 21:18:04 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
	([fe80::585:2d27:6e06:f9b0]) by DM6PR12MB3163.namprd12.prod.outlook.com
	([fe80::585:2d27:6e06:f9b0%7]) with mapi id 15.20.2178.018;
	Tue, 20 Aug 2019 21:18:04 +0000
From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 10/11] iommu: Disable passthrough mode when SME is active
Thread-Topic: [PATCH 10/11] iommu: Disable passthrough mode when SME is active
Thread-Index: AQHVVpE+vHJ4RbcyHUW5UFtccLiK3KcEjFuA
Date: Tue, 20 Aug 2019 21:18:03 +0000
Message-ID: <82e00ce5-df71-5b71-cf5d-3de86aa0a1e8@amd.com>
References: <20190819132256.14436-1-joro@8bytes.org>
	<20190819132256.14436-11-joro@8bytes.org>
In-Reply-To: <20190819132256.14436-11-joro@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0080.namprd05.prod.outlook.com
	(2603:10b6:803:22::18) To DM6PR12MB3163.namprd12.prod.outlook.com
	(2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f004d402-54d1-4de3-4fd3-08d725b3e304
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
	SRVR:DM6PR12MB3771; 
x-ms-traffictypediagnostic: DM6PR12MB3771:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB37718D4248565965DE7D0677ECAB0@DM6PR12MB3771.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:473;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(199004)(189003)(6116002)(81166006)(66946007)(3846002)(66556008)(76176011)(7736002)(66066001)(64756008)(66476007)(8936002)(66446008)(36756003)(7416002)(305945005)(5660300002)(99286004)(52116002)(53936002)(446003)(186003)(6506007)(2906002)(6246003)(6512007)(386003)(26005)(478600001)(53546011)(102836004)(31696002)(81156014)(54906003)(11346002)(316002)(25786009)(86362001)(31686004)(14454004)(4326008)(8676002)(6436002)(6486002)(229853002)(14444005)(486006)(256004)(71200400001)(71190400001)(476003)(2616005)(6916009);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3771;
	H:DM6PR12MB3163.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BqXmetQpD5TrsV0PaAmUt4sBpkamhQA3hpnriw6uymaEVDmezxzfhc5FXUI4JENjffMqQrscRtnHjWlegc+M75Uw5jT8cYm6fr7iyeyLD3Xjvrm8qpw4ly4Hf/X7z93xl0uj9RdkwRgqALjnr/VRcrvSGJClIQczEOqzoKX8hVnu/zWAHLvQ637XlWhX3TCEIKcWv5VITZ8dL8AHZzPFrZRLS3AHN1NC8paRdw5OPHLFSvbRgLFgXTPTUUqSwPrriE8vDfsVDUtxNl17Q6es1c7Yu5NLM2rmT1UgSC5Ob9Gcv6OIqDcONgYpQLO83Uj9ADoJyiQMOW4I4MEPVoRHIm2/DZQe4OFz2eJYLnP18gzfFatVgEioXctXTZPeEjKeMJU8/RkrtOx4uu3Zlw0c6YscXGq1qTah9oQontizPdg=
Content-ID: <4AEFA134D88B2241B30C6ADF7C3A41A9@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f004d402-54d1-4de3-4fd3-08d725b3e304
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 21:18:04.0925 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zl1PfZd5sWvw/Mq3OO1LgJuZOR//jvS2hWc9z/Y6GYFGvLoDOhA1IFC/UIAXYVWB8+SrSJEkSNQoqyMk+Ci1TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3771
Cc: "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
	"tony.luck@intel.com" <tony.luck@intel.com>,
	"linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>, Joerg Roedel <jroedel@suse.de>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>
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

On 8/19/19 8:22 AM, Joerg Roedel wrote:
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

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>  drivers/iommu/iommu.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 01759d4ac70b..ec18c9630e93 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -119,6 +119,11 @@ static int __init iommu_subsys_init(void)
>  			iommu_set_default_passthrough(false);
>  		else
>  			iommu_set_default_translated(false);
> +
> +		if (iommu_default_passthrough() && sme_active()) {
> +			pr_info("SME detected - Disabling default IOMMU Passthrough\n");
> +			iommu_set_default_translated(false);
> +		}
>  	}
>  
>  	pr_info("Default domain type: %s %s\n",
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
