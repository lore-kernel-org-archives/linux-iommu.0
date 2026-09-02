Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013070.outbound.protection.outlook.com [40.93.196.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12B34A3F1F
	for <iommu@lists.linux.dev>; Wed,  2 Sep 2026 18:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788373594; cv=fail; b=CyitbN8V1l6fNe3lcFr0bSL3cnYaumCZ3A7dWNuAgkaJmou1BAVxdpYxtNc9Qrvc/LiPLDfwF1XIfYlos126eBDMNo+hyQZtKFytBiD3cG6LYzttIZuFOw/ioOGQE/imi5taH7qPL2d9dw3mxjwb/87AhnyeJoEnIMGtVehzYgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788373594; c=relaxed/simple;
	bh=dSo2dHyVp7GMjYglXOJf+tW7Ku/EdoP91kQJpqfUdO0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g9CIaXj6zkRdlyWvLXjtqoHNBFUISjlctYq/DJTkJ1l1t5DYzoVSmmWN2BG6xrw9PZAd4iLws0NZyqejnSR9KmeffPWepptcmN82hHeskdPFHStUqmsRz/T29HfumtzxVftOP2VJW0dCLeIeAE9L84USU3lUdy5orXW3lPSpmbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2uSCChy5; arc=fail smtp.client-ip=40.93.196.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2uSCChy5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Syo/lAGPewKqf8SFVT+TkOultjyIxuOjJtOVMS0oBbjRpSM10SCWjRxjFrT2QPHhN82Re7mpZZ6EBC9e4SlxbnC80Ezadd66osSnddmXIKkx62Es4+jhqu1Y2nN0oPjgm805DBAUUmETbb1Nq1byLKLLr5TlSM2dWCt4cIcorf+072s6OArH2pIc8lo4P3A1zWPPsNNtoZd2kSOmEDCdeaenWH8VPZCCUwQ8tEFd6Jgsdfh5RgL+nB6to67r56keEuC/sdKdh011370R43FeHizahzoSPdHDcs0Z5ZvYCQlf/fNqvatI3PS6rOx5bjIZRnjlZvatP6YdSz1wzHyhCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bb7Q+VUS8ABZihkEy70BlYm+ZvnDpp5HkXBkcdPr/k=;
 b=JFHwu+6SpPrkbD3w9OfPwCCX8hQn+rVwzKhEzfuJwI55vXrmmMk/UMMf9wAL3j2g1l/AGXyKmcwBKBcUVTLe8TOcNykL6ziF7KOotJLDEP+TmVGmcpjMub5vFcnDa4Sww1m2d1mCS6sFK0Z5e54ooYmpM3zPKOzsuvOihMbDoRi22A3ie9B4XkqBg2Q5ZO6U3AfKrF75n5DanI93nNB0CurYw5OaylZ6Q13x2d1dR/qJjsZmJef5Vb/YX0ZbXL2x4qxTbcH2zy/3dWiyVeodZaRxqh8a9dJKOQMiqlIaSEyM1DP2e2G9a746rcL/qDuwbd8RGy+R59JoyxGSdMuuNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bb7Q+VUS8ABZihkEy70BlYm+ZvnDpp5HkXBkcdPr/k=;
 b=2uSCChy5yEXT8oydNk++L3UzOjg4Rhfwh1aeeeeQaZg74InjMI6c7cDxL2C6iaGtQ8w7qhQ9M03xjqwRiblY1LkUYC3/X8a/+Sn5HD+f/WNONf9Y3zO4ju/Cok1oDCdI99ojoNXo+havCC4Z+oCWvhrVuNa3h4ne8xQolL23GwY=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by PH0PR12MB7840.namprd12.prod.outlook.com (2603:10b6:510:28a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 18:26:21 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%3]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 18:26:21 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Timo Witte
	<timo.witte@gmail.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "Hegde, Vasant"
	<Vasant.Hegde@amd.com>
CC: "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
	<joro@8bytes.org>
Subject: RE: [BUG] iommu/dma: "Not yet supported" CC_SHARED rejection
 regresses dma_alloc_attrs() on SME hosts with IOMMU-attached GPUs (commit
 8277a12d0d60)
Thread-Topic: [BUG] iommu/dma: "Not yet supported" CC_SHARED rejection
 regresses dma_alloc_attrs() on SME hosts with IOMMU-attached GPUs (commit
 8277a12d0d60)
Thread-Index: AQHdOlXtvC0CEdHtbEaScQzOiRGFu7a7E1EAgACIhVA=
Date: Wed, 2 Sep 2026 18:26:21 +0000
Message-ID:
 <BN9PR12MB5146EB49E0988618FBC13515F7B72@BN9PR12MB5146.namprd12.prod.outlook.com>
References:
 <CANB4YXR7h8V5Xp=MXVZeSdvw9UiriSagp=E+ju5RRDNghoPHLQ@mail.gmail.com>
 <yq5ao6egyn5j.fsf@kernel.org>
In-Reply-To: <yq5ao6egyn5j.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-09-02T18:24:18.0000000Z;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD
 Public
 v26;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|PH0PR12MB7840:EE_
x-ms-office365-filtering-correlation-id: 8bfe8df4-3989-493f-6880-08df091fb02d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|4143699003|38070700021|10067099003|11063799006|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info:
 uAJ7RzUtoQOLl0/fy3J8LFMM+hzbKYzjE20diW9s9sCKAJkvmzTG1YlrqwhyEd3Pl4q6bkQnYuIirjStJ59j8Kr2FMvRvQkeOuRXQ57oAVY+cOxa7Pt9gYQTozuFahdMwHwsQHfk/NqQiC51Yx9gDyei2I/pMiaqDW6i2+W1fbFTAJNkJjA/JIQv8bVBz8uyI3/zVrvYN+yE73WFz2re0oIhpPAW2JvV/jsiCiLySpHWzUpfGBIRyxhaU8eKL7cSx1hu4CkLrZ8XJW/ZTSUM1VYjvDD9Zs0e4vInaTSf5ktWVwI18vcTU57yoPDt9BMJKdyaSy/HTXZnaI09kI3FL+FmepOKoLKeuD261jLxMRoz5Q5IJJaRapl5lePiO/YslupDpiv/QBEAmf1dnJVnHms9+EKl+NsKpapGn95lAuphnWLVrTqgXEBELyJEBSgsZajZphG4b1+/2qIttSp669GD0z9XWS9lkqLrEU+s6WNxOr2/BH/Jb3eQ+M9YSrM46KLUeGhSbBL/ZUqKTdhdHlpWnufiQ/gHipZQdTkzbkwnx2/wYhqrR/ZXWQvPWShDDwoy1Wx+viY697fiS5ho+vbEty9NK/q2zgD8WoWGIoDxraKjbCturZPUwI0/N+ONk8xV9caZJZDLs/I/jDTggwm/amiF1jRenoxrUpC19qOQ2edwQy0W/SSa1n8xbsUWO/lW2Q1olu+EMnhRtVD9QpSyFgzJ6hPr6YB3khkF66M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5146.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(4143699003)(38070700021)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xQuiC13bhWaEf9hfdqL69H4ZGLtTF0TVXYWw24vTzYKm/X1dznx5g0sjpdOR?=
 =?us-ascii?Q?HvI4GwVCzbybtDmVriQBPPiXJacgbJgzznNiKfh1XyIMSIzDnBtrEfIjyFhk?=
 =?us-ascii?Q?RYtMDLje9rfCAM1v01LEu4+Qo7IIzZyVB/F3xzclC3av8Z58Fi9s3GAfJcZO?=
 =?us-ascii?Q?YUNXJ+TMXXqTXitGyOOPxvJtxmfyRC81THfZVBcmIuQ5lX4Y1k1I1KdJ4+ZG?=
 =?us-ascii?Q?qTsrP0jZ12HRHgUXubCooMtPatfFxNEPgTl4dYZ3l0aD9AMX+gFlK+woWEdw?=
 =?us-ascii?Q?J6RCroDey8nZgwSYLSqrx8v/3hWUQuekYXStOAhFdySxpGhirBcZWFZnIm7L?=
 =?us-ascii?Q?pQA2SC2WIoGBEhp/MbTx3ISlRxeu8Cx5bxp0TBfl5b+ubNe7twi2Pjch53J3?=
 =?us-ascii?Q?leH4L6r12hFynaXDtTaBO9jRkNe0mlsyVpcKCBMKhuceTtR1WXPpV0ZVHsUp?=
 =?us-ascii?Q?O1MEJ6D8BeacNLXFH3/OJ/hU86iGmFJgRVg5uVm3+hjKrFoiLU7KC362TXNn?=
 =?us-ascii?Q?aGJZxG7ITcqYajTrMLbvNkl5n2De7Tp48uOJ8zGE6cXMPQ3/CyvL+xe2z363?=
 =?us-ascii?Q?qzafFCNv1sz7NzuX65hm+Sw8qr9pYTtaKn1TSSwDsYPCeIo59PvGOKwps2o3?=
 =?us-ascii?Q?Aa4fVRzfW31Ron1A9fZDFibL5LOgHcnLsRu3SgRRl5pq+VjO+0sHmjAVmMqC?=
 =?us-ascii?Q?/qBabQfeaGoMuO2MR7igbIfmspnjrfr/2yQGWngY8XkCyGWWapq/4cPpCT/m?=
 =?us-ascii?Q?ulAUD1XoKd9QMaFpACX+d5fRd9ag5GXx6lDEMQwUnPeWNKziNIsXYkanyF3d?=
 =?us-ascii?Q?q9wrNtAf/D1yUrivknZTl5zumpESa5g3ddjNAUUdOMmH3eiJALp6HBU6+vfY?=
 =?us-ascii?Q?fWiIcRR5bqpPmU1x0Z3DvrFlZLcMgSN5h2k6xNdPXnOHSqDt/CxiZrShknfI?=
 =?us-ascii?Q?fOFkH2FqSQMldSj76y9B/uSAiYHb6lWBe494+WMb1g9Cxr2L+PbUuWRMYsDN?=
 =?us-ascii?Q?/h7I9kADjD0E+Ud6PU3al6XHui0YGV93bynI4OfYijUlERDD3qy1ZgUMbSPk?=
 =?us-ascii?Q?HC7BG6Jw+sV5p8suV7lzYwSjm7lIfvZR0T0IS6n7DdE1XFNdUPdtM/BhGven?=
 =?us-ascii?Q?sfkih8fPa/+/kWeRhz074HiAqVTg+a7E+uqu5p6uOFQ6hmzlTFXJGyNpicvT?=
 =?us-ascii?Q?ODiC+egHyB1H+Wm1RmAd38hvV6vVfUFUrFlNZEk8RnEPaIAUST+5OliDMTzb?=
 =?us-ascii?Q?jbOExY9UTVbWSU6kkLc6QSfeEKJmzT+Z+njZYRZAy1qT/tzCSRaFIYj6s5ef?=
 =?us-ascii?Q?F17p8iYomx3xxDfH6VHWZUjEJeh21vQOwl5uFhTEBeQ8hpsXfXov4jpQ0wwV?=
 =?us-ascii?Q?MOgXFyUZ8l0nNYEHaRaebV3TY9V4blB/dPDSL6SNlD8wcPp6qO7i6A4MgGiy?=
 =?us-ascii?Q?vSrQ/3EHYut6NdlCmnqyHd8KX1UadfC85lhk3if+sGhB+s/T3b7ndhMCTp8Y?=
 =?us-ascii?Q?pacZD+/pYgJs1MW7uHMWcm1uQi13TC0ngIhHfhk7laaO4IZSh7XoL1mApWx2?=
 =?us-ascii?Q?wgStJnL5yZv/SVt11UrfiHnbHXZNwKytrASObX0sWaiOju3ulj/MMoHq/MXo?=
 =?us-ascii?Q?LUC54O9xHIBrsHZCETVOXewwQAFuytQE87uynLedA5MDRpnaJ+DKCoi625Rz?=
 =?us-ascii?Q?sw0LgCTRaHtKtybucnO43RNVXkGmJC9ASU0MfHT0jqi35SEx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bfe8df4-3989-493f-6880-08df091fb02d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 18:26:21.3911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OV9r4TeyhMBRxx5DjG2SjkmusbEHvEhTNcDOSnM/ze9wQWf4Ji5NGaMAW8TBG/jkZ92HOpE+gSWEcgCKMC/XHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7840

Public

> -----Original Message-----
> From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> Sent: Wednesday, September 2, 2026 6:16 AM
> To: Timo Witte <timo.witte@gmail.com>; iommu@lists.linux.dev
> Cc: m.szyprowski@samsung.com; robin.murphy@arm.com;
> joro@8bytes.org; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [BUG] iommu/dma: "Not yet supported" CC_SHARED rejection
> regresses dma_alloc_attrs() on SME hosts with IOMMU-attached GPUs
> (commit 8277a12d0d60)
>
> Timo Witte <timo.witte@gmail.com> writes:
>
> > Commit 8277a12d0d60 ("dma-pool: track decrypted atomic pools and
> > select them via attrs") added to iommu_dma_alloc():
> >
> >     /* Not yet supported */
> >     if (is_alloc_cc_shared)
> >         return NULL;
> >
> > dma_alloc_attrs() auto-sets __DMA_ATTR_ALLOC_CC_SHARED whenever
> > force_dma_unencrypted() is true. On an SME host (mem_encrypt=3Don) an
> > AMD GPU with a 44-bit DMA mask hits that condition, so every GTT
> > (system-RAM) allocation fails with NULL/-ENOMEM, amdgpu init aborts
> > and the system boots without a display.
> > IOMMU in Translated/DMA-FQ mode (iommu group 29).
> >
> > Before the mentioned patch it worked: the IOMMU PTE carries the SME
> > C-bit, so the memory controller transparently decrypts for the device
> > while pages stay encrypted at rest. For IOMMU-backed devices
> > force_dma_unencrypted() is a false positive - the device DMA mask does
> > not limit addressing once the IOMMU translates, so CC_SHARED should
> > not be auto-set for them.
> >
>
>
> This means that, with host memory encryption, DMA does not need to be
> forced unencrypted when the device uses the IOMMU?

+ Tom and Vasant.

Yes, otherwise most devices won't be able to work with encrypted memory sin=
ce most devices don't support a DMA mask large enough to cover the C bit.

Alex

>
> modified   arch/x86/mm/mem_encrypt.c
> @@ -13,6 +13,7 @@
>  #include <linux/cc_platform.h>
>  #include <linux/mem_encrypt.h>
>  #include <linux/virtio_anchor.h>
> +#include <linux/iommu-dma.h>
>
>  #include <asm/sev.h>
>
> @@ -30,7 +31,7 @@ bool force_dma_unencrypted(struct device *dev)
>        * device does not support DMA to addresses that include the
>        * encryption mask.
>        */
> -     if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
> +     if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT) &&
> !use_dma_iommu(dev))
> +{
>               u64 dma_enc_mask =3D
> DMA_BIT_MASK(__ffs64(sme_me_mask));
>               u64 dma_dev_mask =3D min_not_zero(dev-
> >coherent_dma_mask,
>                                               dev->bus_dma_limit);
>
>
> -aneesh
