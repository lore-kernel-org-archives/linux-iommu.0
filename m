Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EF5C433E1
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 14:36:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53F9C2177B
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 14:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="d4oybdDx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F9C2177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 17B0587B92;
	Wed, 26 Aug 2020 14:36:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XMoLMUjFyfJn; Wed, 26 Aug 2020 14:36:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 76D4887B2E;
	Wed, 26 Aug 2020 14:36:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36267C016F;
	Wed, 26 Aug 2020 14:36:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 433AFC0051
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 14:36:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 30970203E2
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 14:36:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VFMptFPMgNSg for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 14:36:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by silver.osuosl.org (Postfix) with ESMTPS id F1A69203B0
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 14:36:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5ctDo/ZaI8d2iB80udx21W7lf4BFGHQsK9cSRs5WdcU+gDMmEbKF8IAxCVko+UT4cJhZOCtMgJYED/YP0vtx+VlSZRFkYvkQoJ+5w5Iv+NSLRhyX7/USzTSVYlPkbMGyvkzJug0FVlefbciHHGtmV0nQBehhGfx01hHhx5sHHcPCBfJzNWO6KM+RzXXk7KZEjxJJxC+jVrZzPb9wqgEqJ5FBXi9TjpFDYzjVHo/mge4ocIyyrjLJHlG0+ptV1RV5uYhjyJPkxxJux4ydKPJQrYshkhz+FKWCfDdJJZGgvznUgLNKlwhfH783ZDBSWGHyJYYBkIvb49QfoejGK/2Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YWIDvlh5pUDzY7w45iFRjJ7sbgKO20b1piiU6nk3pk=;
 b=J+fqZ7Jn/7mrsFxzt21/Z4aQLtwQuqiZPaWapaTV/FyrfuNzSGCnPFoESRv9UiOIiRLkfMRoM9SMfVZcNx0m+9qQ7Y+Lt89W337+mTAvNKOK5DMmlp22yx16a9A1yVxfMNWTXZCdX4JYU/V+psczNUXiFzl5Kw3Kg0g9LvLoHadFFNB2yAtkmUp5jKN6jXGOIRYd2Kveg/eVeQ3ZBwcSyZtFzzPFmp1Luw7LI53OeCoxGaqkjNZFkLzZ7Q6tErEbj0IMA1E+ho7IkVcTevinPqqpGVf//xVkaXJ5J7rlGPeHg3iwSpZiFwaCIFmNBfVJ3pHWKMoZeKd+j8RH0JJzwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YWIDvlh5pUDzY7w45iFRjJ7sbgKO20b1piiU6nk3pk=;
 b=d4oybdDxM52V3+f010y7Z1TvQvxllCYkPyOIgSmYZ/vP+H81zrW6M9Gdv7d3TynnRmtPPdRrdg9qGBBE1FDK4dr+8CJejf4fEYpmGOE0G/CdtLyD9p1SQE/N9PuMj/eTEVsjSdG1wpxWPUgEg8g+abQEpHL5mzTBNYZkQQEXP1c=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3917.namprd12.prod.outlook.com (2603:10b6:208:166::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Wed, 26 Aug
 2020 14:20:51 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb%7]) with mapi id 15.20.3305.032; Wed, 26 Aug 2020
 14:20:51 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Joerg Roedel <joro@8bytes.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH 2/2] iommu/amd: Do not use IOMMUv2 functionality when SME
 is active
Thread-Topic: [PATCH 2/2] iommu/amd: Do not use IOMMUv2 functionality when SME
 is active
Thread-Index: AQHWegTrOX3Oax7ItE+ghg+6kipvEKlKc/iw
Date: Wed, 26 Aug 2020 14:20:51 +0000
Message-ID: <MN2PR12MB4488AA440120E3775675CB3FF7540@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200824105415.21000-1-joro@8bytes.org>
 <20200824105415.21000-3-joro@8bytes.org>
In-Reply-To: <20200824105415.21000-3-joro@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-26T14:20:44Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=a3b3e905-9df5-4be6-a8b5-0000d4520fc3;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-08-26T14:20:38Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 5f141d97-40f7-4517-b376-0000eafaf01b
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-08-26T14:20:46Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 62e0af8e-27da-4358-b518-0000281ab297
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: 8bytes.org; dkim=none (message not signed)
 header.d=none;8bytes.org; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.10.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 532fcf0f-c1c0-46e6-2255-08d849cb3ca4
x-ms-traffictypediagnostic: MN2PR12MB3917:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB39175C57E949CE0773164C45F7540@MN2PR12MB3917.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NhlhTDINMvM5cxTo98PlK4a4+xf2OZbsQleVls3w7jpKoLoxdOu8z7QSddf4W5iTzIG5Pf8OrrDpfaKZbJBD+QL6rw2T8qO9wFbk7klEjNgx0SZ8ffD45uxi8sM2S7RsiN+rQeZu22F7hloi260GnDN5vhheIB0UqzJXb2C3NdKvFcR8Eh/FyabPUpKNJfAmR14Pjspi0wpgxtO60YdBty96XszgcM60phZnXB3CRhxkjAeIvCC1POadz33iz+yLyuzqbHQJ88tpAWHfDAC7bInigPFTUBdlj5q5Mcxoj3QAUZFLLoYKBVaAY9URzy/t
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(4326008)(33656002)(64756008)(83380400001)(66446008)(66556008)(66946007)(66476007)(76116006)(8676002)(7696005)(8936002)(71200400001)(2906002)(186003)(54906003)(110136005)(52536014)(55016002)(86362001)(9686003)(6506007)(26005)(53546011)(5660300002)(316002)(478600001)(6636002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: bToiZ6cL8csWIh9E3+KkH5euCoZm4ZOrI0E96PJRKWS/ro86MtaiOm0fDrdFyl00J0KTyKBCLyIC8MzWxeRKBtoLoViKE/f0FL1MdhmHz1CyDkuWCY2zhswGdL+A1QgLNTR+RhnMDBbEKi0HPgoIOipzbfGdZLyb5lXpnM38ommMg1mi2Sr/7Cew+qhxb4PWd559c2ycEqbO4hTvGEH9IiLJK+MmraXxkzD9n05zwGQ/e3Lyhpkl8z2xnSv3f8AoP3YrLlEXQTdUsrqL2JgzpVRLeA6BdRH3duYcBvccHfiLqOGV3LPDlGYMY68XM/FmJhA3KOM33eGeTcoCeJRANXfZN++tGmnGI3chlHs7GIOnt0s3/RULcn4ElpeK9n/kSq094EKOjqED+/1OXpI74cnUXnYW4Cz2BqjUUod1GW6PJkuxfO0p4FqZTirkZ5drvfSrfBqxP2JDqsnXl35ywPFVcyXlPYhX+16yPDM2+rpede5nTptnH1cOfrjnBk/b8rgF+MZgEjiAT9hDtItCehu+qY/ruuNHMcepS6Bd/zOiOa5gpJfxe/7h4OT7x9Mh7QpT4oWmTosYVsLa6DuIO0JKjXo7f4SQB5qoAbF4aF6XyfogmK11b8elmpp6muou/zdPA7ZxdPVYxFLw1l01sg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 532fcf0f-c1c0-46e6-2255-08d849cb3ca4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2020 14:20:51.6249 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Llu3i++yK1Uy9gH4ywdFw53Kb4xdznrCBkvVRpIH8XQo14wuXpeDDBxGIeQesR2raGosIF+oCmAEOc3v2MSY7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3917
Cc: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
 "jroedel@suse.de" <jroedel@suse.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

[AMD Public Use]

+ Felix, Christian

> -----Original Message-----
> From: Joerg Roedel <joro@8bytes.org>
> Sent: Monday, August 24, 2020 6:54 AM
> To: iommu@lists.linux-foundation.org
> Cc: Joerg Roedel <joro@8bytes.org>; jroedel@suse.de; Lendacky, Thomas
> <Thomas.Lendacky@amd.com>; Suthikulpanit, Suravee
> <Suravee.Suthikulpanit@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; linux-kernel@vger.kernel.org
> Subject: [PATCH 2/2] iommu/amd: Do not use IOMMUv2 functionality when
> SME is active
> 
> From: Joerg Roedel <jroedel@suse.de>
> 
> When memory encryption is active the device is likely not in a direct mapped
> domain. Forbid using IOMMUv2 functionality for now until finer grained
> checks for this have been implemented.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/amd/iommu_v2.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iommu/amd/iommu_v2.c
> b/drivers/iommu/amd/iommu_v2.c index c259108ab6dd..0d175aed1d92
> 100644
> --- a/drivers/iommu/amd/iommu_v2.c
> +++ b/drivers/iommu/amd/iommu_v2.c
> @@ -737,6 +737,13 @@ int amd_iommu_init_device(struct pci_dev *pdev,
> int pasids)
> 
>  	might_sleep();
> 
> +	/*
> +	 * When memory encryption is active the device is likely not in a
> +	 * direct-mapped domain. Forbid using IOMMUv2 functionality for
> now.
> +	 */
> +	if (mem_encrypt_active())
> +		return -ENODEV;
> +
>  	if (!amd_iommu_v2_supported())
>  		return -ENODEV;
> 
> --
> 2.28.0
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
