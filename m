Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DDFCC4332F
	for <iommu@archiver.kernel.org>; Tue,  1 Feb 2022 23:20:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C47E04161B;
	Tue,  1 Feb 2022 23:20:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id alB3N9KKMw7M; Tue,  1 Feb 2022 23:20:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 748A541613;
	Tue,  1 Feb 2022 23:20:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55224C001A;
	Tue,  1 Feb 2022 23:20:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D786FC000B
 for <iommu@lists.linux-foundation.org>; Tue,  1 Feb 2022 23:20:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C522441615
 for <iommu@lists.linux-foundation.org>; Tue,  1 Feb 2022 23:20:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UYG73zdzJMeV for <iommu@lists.linux-foundation.org>;
 Tue,  1 Feb 2022 23:20:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from na01-obe.outbound.protection.outlook.com
 (mail-eus2azlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5C00041613
 for <iommu@lists.linux-foundation.org>; Tue,  1 Feb 2022 23:20:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZgOmay9Hg462Nzs2FeVCItiiGbHCj5tULyIiPtSLeGTLdQ8YY16QoNYBZ2UJRvpsyeXir3V0Q1pCZGjv29QGZ9rAJsw6/dKabZrxSDhGvxX/m5SvH70dkpKAfhkbVAs30MeQr4oZbXu/DkpDNG6o7Y9TUs2M7l/hKrV1coWv6tU03IFmD7HStz3inu7pNSL0N4pevZdlM//LJOh+NBNutYK+OcHT815zHkpoyorJ4QtM5XCoRydQrhKrrGXL4UCJBXQ9YXEqN/5pPEK8EMkcNe+62UrP/lIPO5OmuDm+6bCkbcP8uvQOdvKp8L3lXQ+CRPS72DG6j7XZaDNtjE1jWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buZHvy4yZtocVYUlrc9/IDwi9GBPiCTUZpS60jumck0=;
 b=WSI8J57bfwO+4//zh1fxoR6y1FnlcoVUBD0syTW6H7kGKfydy/LTI6DuIHZvAs1KckLGN4t3y83KT0i0iUUsferPRPgrIwDByRrFCtHt4y2X7jyCQZiAtqQMV4s36AxWfIxgZLCHWSmUc3VPZt9K084mz5yB5J7/e2kZ8i+SWQafFNFqwC374sn12klyCiQppV+KzXyX7418pLJ8+2FCTi+nrZQQRm8fHAN8b538+xsQq8Ib6j5/41QkYXVz/HDNAk2iW+iRv0LMG/w+0rjZ68G15P+E15NqvON8q/QWTnsq0xv74fqOXYQuhO4cf31UFlInoRGgqdIvS0AA2MJbBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buZHvy4yZtocVYUlrc9/IDwi9GBPiCTUZpS60jumck0=;
 b=XbCoWZpOiWyk5hmH0gatbIu1rH2ZZ9U1DZwEPDXpfGWUXJl91UBoVnVGWdx/IEVQ5dmg80KwQnfPX/deOtKadJUetcgsB0ghF8a+TUxZjiV9AfFqDvnGfpNyPmvM6/28aVFf9zcdmfVcQJLLRgJ+AOtUEaK6RDYkrjcwQ/QILkk=
Received: from MN2PR21MB1295.namprd21.prod.outlook.com (2603:10b6:208:3e::25)
 by BYAPR21MB1687.namprd21.prod.outlook.com (2603:10b6:a02:c9::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.4; Tue, 1 Feb
 2022 23:20:09 +0000
Received: from MN2PR21MB1295.namprd21.prod.outlook.com
 ([fe80::e081:f6e4:67eb:4704]) by MN2PR21MB1295.namprd21.prod.outlook.com
 ([fe80::e081:f6e4:67eb:4704%5]) with mapi id 15.20.4975.004; Tue, 1 Feb 2022
 23:20:09 +0000
To: Tianyu Lan <ltykernel@gmail.com>, KY Srinivasan <kys@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>, "wei.liu@kernel.org"
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
 <bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
 <kuba@kernel.org>, "hch@infradead.org" <hch@infradead.org>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "robin.murphy@arm.com"
 <robin.murphy@arm.com>, "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Subject: RE: [PATCH] Netvsc: Call hv_unmap_memory() in the
 netvsc_device_remove()
Thread-Topic: [PATCH] Netvsc: Call hv_unmap_memory() in the
 netvsc_device_remove()
Thread-Index: AQHYF4lItKgPG5VAM0quxqK4NaKG06x/VWFA
Date: Tue, 1 Feb 2022 23:20:09 +0000
Message-ID: <MN2PR21MB1295D29EC97A4BEB9B6FA4A3CA269@MN2PR21MB1295.namprd21.prod.outlook.com>
References: <20220201163211.467423-1-ltykernel@gmail.com>
In-Reply-To: <20220201163211.467423-1-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=930b1b05-0e3a-42ab-9af8-c5c554d86332;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-02-01T23:19:57Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6031131c-e032-4436-003e-08d9e5d963fa
x-ms-traffictypediagnostic: BYAPR21MB1687:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <BYAPR21MB16870953BF03207D20D57000CA269@BYAPR21MB1687.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nd/D6idaDZGx3dXYNTeiPvCerId8WWuEeQcFn/8SurAnI/PLv8hNsbhI5OpBXF8dWeuRgAWqoPT+hJ14hC4eufMv0rliZPJtnlaWg6BMGR1299ANNNZ953rDaH9/Y2u2TRFrsaGduXzGS6ahJnmJleRVMYycBNKWhm3ZWLuBwzKeyokjZ6QwreE1XQfr/C4MPB53WJQC13EuZ4DUOJ9MRbl1mByiJpB0Ab5pqprjnbpMZz3vBALhbOqVTThn3m9VN0ffUNLiGvkQ5Azt55gCInistWaAvcSU42XoBzRi77b/jOS8oum0rA11AjLPbxF0KI/OsY0gMqaN51X+OjBvNjNhAQb7L++m9c2ryvXQ3IF3LYlMJuNxeb4NJgJXtUvNAD7I+bChXJR/yPljoqdc9GUj63szen8k+uDzsLiSGoNF9sJwdE1gcmtjz6KjBHnar5SpsRpbhkae4SN8pDZ/u0y26uXn39swki+7qvXUlwGe/goMMCncDhuZi33XnSdbfgyR86bS6T3Rv+BmpL6tEFIKSXwvJm2hcPq788vwSkKZKwMMMUbdP7EaV01DLwN39buotHDPWz9HKnJtxGLWUQT5j04tOIlcHKU5kHNj8YmBs8GCULeP+rVRkf153OhtKH++ziDBhNyR/J7ItK5PQAKSkI71y+SkwpOoT8PSaZGYvE9YsJQ+s9TR+k0SGlJto+mxxbqv7YTOjGwOaTRn1LPlzicUkXp3nIUEY5geUomleQvpFDPCaMYSk7inTSe3+8RkXlPm+UxzIPsO1LZqfQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR21MB1295.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(54906003)(71200400001)(52536014)(82960400001)(7696005)(6506007)(38070700005)(53546011)(110136005)(8990500004)(6636002)(9686003)(83380400001)(86362001)(55016003)(8936002)(921005)(8676002)(66556008)(82950400001)(66446008)(66476007)(4326008)(122000001)(508600001)(66946007)(64756008)(5660300002)(76116006)(7416002)(186003)(2906002)(33656002)(38100700002)(10290500003)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/70tPy19bnMFWNWH2y/vwIbUc1SaCtQUErSgsF8bRu7PAt9vs+5InBqy+GaB?=
 =?us-ascii?Q?tiYEOlWLd0UYC8y63U6GsPZJZLtul53CsNhD0H1JfC8Fof9sVECOQJ2F/P/5?=
 =?us-ascii?Q?gAACYhnVqrFQZrpCd+VwmhE9ZxJkmOdqfDxp9ZesVrxsmuScxluj9G6fXGsO?=
 =?us-ascii?Q?QMxMfQ0uD7crSd8Gy597hvo380ZGEOlghu3edSLmikUMnqitNP3GwJw/mErP?=
 =?us-ascii?Q?dUxW500UYQLPuGJY1mRTMi654YAwU5KQ6AzdTwpQ8Qf/WT1UnJC7x3ekhCPq?=
 =?us-ascii?Q?cLReSACQPfZz5tQUOnkzzwqa9k+1TXYSsuuXDYfHu4rvOEshh3dF+zRwL1kb?=
 =?us-ascii?Q?DPUZhoM7aosIcW9vR6y5/3RPRCMD4kBLyc3ZNmo5uXsDaTOezflQbWrbltSY?=
 =?us-ascii?Q?OwDX0pInRCTLlBXY61DEdUb9+EwX8LhUsViIy5ba9jHjuRHZ6uyo03qr7wzR?=
 =?us-ascii?Q?F9AJ0rn7ZoB0APrmvQQbTx7C/jKAILmynhMirj4+RlYtBgADl5sbtba0YmUh?=
 =?us-ascii?Q?DjSwMoWRnjt9ObkmnJGq+uVWScNehvDeGp7aCGdAHUa0tetHYrQkFPOIAS/T?=
 =?us-ascii?Q?a9ii3er7eXjeipRCGCEbtY2EVQ26EghOSFe3Ln6zJf3KDOo1zK2pDwUzafQs?=
 =?us-ascii?Q?Uzgmle3xk7l55JijIlMDENgVVmj5IUaoUE4fjWBtP7fvjRf62S31dBABR0Jo?=
 =?us-ascii?Q?uc1MYNalZTVCTHYFCYxFBiAlU2wPOGgtuTFmaoyiuo3d1ts3KbMhUht3GSpL?=
 =?us-ascii?Q?42Stpzhau06oi+onxaDxx8XU5UqrCsyVGMWz8dElEb8ildW7K78N9I33tTvh?=
 =?us-ascii?Q?Vlfeok//LuUSpI5xDCVKoqnxWDfES3Okw9hJlL372F/8unnOrmRmBSZJz0D8?=
 =?us-ascii?Q?pKZ/OHCogU2EVp6t3sUcsiHtre/2aQzMjmpdmn5DWj6/lM6GjbX3nWnSGNhS?=
 =?us-ascii?Q?wL4rkHF7mjK59EhZE4Hh+H9TBu9R13x2TxdJZAGPPLFkiKr3S/yex0i7Mpu7?=
 =?us-ascii?Q?3cv+au+DnT7Ml3/+faLthwbr1hSgICxFsfo7UM77EPLdaF9Lv8j5wu33eQk9?=
 =?us-ascii?Q?YKXeBb0+5ss04/lD0zFRGexYgklHvaD0cr6ogNcG0poEMZtEpZfJNPdINFSy?=
 =?us-ascii?Q?8boMMaQz1CWN3S0LgCOlz27Q4iS5krcYBkUFx/PsLGYniw7n0nyUNH5DNlxJ?=
 =?us-ascii?Q?yykg1o+XRkKqNYAYhVgj3huaMz9d660dvvRhdBmYa59i91ckVFuEYx8hWFSN?=
 =?us-ascii?Q?mYKfiOzZvlWj9Gbaq4wyuAAoa86ZmkhLsS8VS7AGuUxgzWg6PQ0XfhB1T4oC?=
 =?us-ascii?Q?pPMHy1G5A3oFj+lmL+VX7MCaaq3LJHBgRC8s0ILE9SG0gtRELLjn9PnaQHMC?=
 =?us-ascii?Q?q8hjHGiBsigSoDvg4kB3HjeX4YKjPhDK5gotUmbIYPmmXWnvIE3gQCVMQEGO?=
 =?us-ascii?Q?kBS3tbATAVFHBB75rGGkODIZEWcVtSuIICk75N5qnLH/Uf/rCbaECtfHxCHu?=
 =?us-ascii?Q?t57dpGu57ea7uwl5hbZW1AP2509u2A1dr0qJBn0NXD3jF0ddxbswPAM+Rcgq?=
 =?us-ascii?Q?YYG3EtF+JkiKZmW2h0fuXLkNTwZlsOKnsNC84Hpf1hORxWCBv5DF2OLJn5SJ?=
 =?us-ascii?Q?gA=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR21MB1295.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6031131c-e032-4436-003e-08d9e5d963fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2022 23:20:09.6073 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ieok/W4FyOMw8e3zWdachTDzYU7vXkf/jVWwZQxB+VtOwl0Zt4fevRF+5w/WWq77XrxUicLKzNlMOxl1IK+QXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1687
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
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
From: Haiyang Zhang via iommu <iommu@lists.linux-foundation.org>
Reply-To: Haiyang Zhang <haiyangz@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



> -----Original Message-----
> From: Tianyu Lan <ltykernel@gmail.com>
> Sent: Tuesday, February 1, 2022 11:32 AM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Stephen
> Hemminger <sthemmin@microsoft.com>; wei.liu@kernel.org; Dexuan Cui <decui@microsoft.com>;
> tglx@linutronix.de; mingo@redhat.com; bp@alien8.de; dave.hansen@linux.intel.com;
> x86@kernel.org; hpa@zytor.com; davem@davemloft.net; kuba@kernel.org; hch@infradead.org;
> m.szyprowski@samsung.com; robin.murphy@arm.com; Michael Kelley (LINUX)
> <mikelley@microsoft.com>
> Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>; iommu@lists.linux-foundation.org; linux-
> hyperv@vger.kernel.org; linux-kernel@vger.kernel.org; netdev@vger.kernel.org
> Subject: [PATCH] Netvsc: Call hv_unmap_memory() in the netvsc_device_remove()
> 
> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> 
> netvsc_device_remove() calls vunmap() inside which should not be
> called in the interrupt context. Current code calls hv_unmap_memory()
> in the free_netvsc_device() which is rcu callback and maybe called
> in the interrupt context. This will trigger BUG_ON(in_interrupt())
> in the vunmap(). Fix it via moving hv_unmap_memory() to netvsc_device_
> remove().
> 
> Fixes: 846da38de0e8 ("net: netvsc: Add Isolation VM support for netvsc driver")
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>  drivers/net/hyperv/netvsc.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> index afa81a9480cc..f989f920d4ce 100644
> --- a/drivers/net/hyperv/netvsc.c
> +++ b/drivers/net/hyperv/netvsc.c
> @@ -154,19 +154,15 @@ static void free_netvsc_device(struct rcu_head *head)
> 
>  	kfree(nvdev->extension);
> 
> -	if (nvdev->recv_original_buf) {
> -		hv_unmap_memory(nvdev->recv_buf);
> +	if (nvdev->recv_original_buf)
>  		vfree(nvdev->recv_original_buf);
> -	} else {
> +	else
>  		vfree(nvdev->recv_buf);
> -	}
> 
> -	if (nvdev->send_original_buf) {
> -		hv_unmap_memory(nvdev->send_buf);
> +	if (nvdev->send_original_buf)
>  		vfree(nvdev->send_original_buf);
> -	} else {
> +	else
>  		vfree(nvdev->send_buf);
> -	}
> 
>  	bitmap_free(nvdev->send_section_map);
> 
> @@ -765,6 +761,12 @@ void netvsc_device_remove(struct hv_device *device)
>  		netvsc_teardown_send_gpadl(device, net_device, ndev);
>  	}
> 
> +	if (net_device->recv_original_buf)
> +		hv_unmap_memory(net_device->recv_buf);
> +
> +	if (net_device->send_original_buf)
> +		hv_unmap_memory(net_device->send_buf);
> +
>  	/* Release all resources */
>  	free_netvsc_device_rcu(net_device);
>  }

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
