Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793362093;
	b=cabIilV4Y1ADW5238gnWTHt3q1xk/m4JxEeGWIImLcFRHezjyouVSa0jZn5k1bj6zswB
	 xg/YgvCKdUUDRVOfqT9aCqI5z5rDtzVK4XgNUAyUIGrCCcLuQeLF7otmJ7ioSZg7Paynh
	 9iAHS6yAcVqhCgMKElyqmInm7I4xj6XogEdXyV43HZ5SXZP3XeWAtJ+y6uxq/B+o7CXTo
	 jpT18dAJ5L2X3Qq8oPnVKa1ycc3ssFn63oA4Sdmjtl9IIe1exgnkqblmHIoT1TQuyhUff
	 dI0NSTTKvmZasLlMdXXHUOZewA5EWVsOJG6eIMMnUt1wkMlnsA7GQRcfE/VuQlrXaSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793362093;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=lW0wLcheEeoD6ntTT61Iywuyf5+FHGoJ+vP2SUi06bQ=;
	b=DH/1CzyOA0eCyT+srlpDRWCCP3hHvmmWvi/bg1vkT45BJaKvR7zlMj7zzeuRPKJBS+nA
	 nSc9oJQFYrOesM09G2wo865W36EB2qmYPvwyvr+hBk2ReMpdnqJRuTK3OhlTrJLz1v2GD
	 /6tCB8yr59NJfiXuDTQCRED06XLTDOgAUIzYucO5xRplmOQ4U2Ywuvi4Z4hmQugPqRbR3
	 HyDPm/7j3MGOtgNpSysI/RwAYeXu7jPgyGlzw1K5KHoAWKZvUgHniQE4JXb9x9B3eVezu
	 Sm6TVMvNhfNF15fygc/wjuwM7h0dIZmUsGYTaPDxBC70kJZ8awmZxCUogEHdoEP4oig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=cqPThT8f;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.71
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010071.outbound.protection.outlook.com [52.101.69.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4468D606A321
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 12:08:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4468D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=cqPThT8f
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TK4D6jW22ODYdYWyn3WZd6HTaODxSoVkQ/CefcQ1aiRPOb9V0HYg/860QdQM942KJ4M9iJuyZFFG7orOy0FPc58UJDrG2jaLjjvJQaYp1Gcy9OZmghf1RQSnGMayMa5vH/bA1DV3/nX2B308ndygAEKpiXJmfPwmVR9lPVr6CZIh10KoNFBmevqwf6AeK3JuP8pBNiKYT+2t8dBB6QSOxCekJ4zhvMxeEVbcSe14i+woAHcnQl0XtyxEnS7hf6yVQYlnBCE0VSwQ1j2lE0FKiIlgxmMtvogWeQ2uw4/UCVeIPR4Ad/itmVv6XM4S5opyM7iXBKi0JxHP4JJvLkAMFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lW0wLcheEeoD6ntTT61Iywuyf5+FHGoJ+vP2SUi06bQ=;
 b=L7TZLTw7QSzTTTEULjC6jOBJ5Ku0Qh+AXWIWqlc6c4a5D/ALHyu0hsJCUOkCzFHpIpzwGidYnGQPtKhYamrNt2ej5tgQo0ETP1vifWPEqa+lKXXAv9G/ULsTWdAzctoL9X+VfVTo1y/A748/Sz3jjfvn8Fxm4zloTqrL7+8via6NkZOFVrZJf1cJwppynvoVEmywC7bjWuDYa9Ch5WhVGWpASGkoasSsGByQf8eaZsoGAkrSl24jO2/jNKxUjfZukk9N+LKU+EPDMcTp8vThtvxgTFo7iCwl3M3P655D4i6pkkSYMWF38IP6NxCsarFTgkYQHgAtzr2SOVDSEqryBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lW0wLcheEeoD6ntTT61Iywuyf5+FHGoJ+vP2SUi06bQ=;
 b=cqPThT8fCdA3jNfy7OzTs5mnPzYQ249/d7eDwVNCOPmjB6RmsdJoaIpzXhvDZ1/9k/hdusT7Sv3TiCbUVr52WbXJt6HS0oIQC6b0pP37i/ep/u75pk+VOWHDOHgvO7oJivpa6paNGtbNtx/Qf704igl9DxeW6hgPVIzfKp75YTeIem5A4qfKZq89IuUyOHDDD9oLf9AkGQVXCn9WPPCw26L+QxFnB6uHoLC7SpUxi1HZoCRjOoBy1ct+RGjEJjm6v6977YAREaQFuqzKOz7GcffwUWAnARbMd4d5BvkBYOW9k/aAo1rFz4lp+Rwn5t3pQPSfvnuSEve675Bn0K7tKA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PA3PPFBB9BDA27D.eurprd04.prod.outlook.com (2603:10a6:108:1::b0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Fri, 30 Oct
 2026 12:08:09 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 12:08:09 +0000
Date: Fri, 30 Oct 2026 20:12:54 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Will Deacon <will@kernel.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC v6 5/5] iommu/arm-smmu-v3: Wire up shared-SID STE
 ordering and feature gating
Message-ID: <auSJxoCvrdMg/rZN@shlinux89>
References: <20261011-smmu-shared-sid-v6-0-cb76b89dc612@nxp.com>
 <20261011-smmu-shared-sid-v6-5-cb76b89dc612@nxp.com>
 <aszfVNP6DGzWYdK0@shlinux89>
 <as1zR1wc7ERxvR1F@nvidia.com>
 <e8c22eb2-ed1f-47c7-b2ac-c56ead1cba8b@arm.com>
 <20261013124400.GI14213@ziepe.ca>
 <4d2a05c3-f7f6-4348-a3b4-c8f3ffa79b6c@arm.com>
 <as6HfzpcalIh6SMs@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as6HfzpcalIh6SMs@nvidia.com>
X-ClientProxiedBy: SI2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:194::9) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PA3PPFBB9BDA27D:EE_
X-MS-Office365-Filtering-Correlation-Id: c7f1e643-a0cf-4934-a0c8-08df367e7630
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|19092799006|1800799024|366016|261026121527099003|11063799006|4143699003|56012099006|261021135927099003|10067099003|261021121427099003|261022105027099003|18002099003|22082099003|261026140227099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	RerJWSTW7qqmZ3JqtDhR40OqbsnD9uoidILJIHCPNoUi3tvDyP0TOHshYL6iDFkFCDLToSvLvCTtNRA6Jee8YNzm+g/R7PKjob9SES7y8Ob5tibTQK1d3VsglMUVLkJ34uV5jOCWYa4b2hEKOT42IP0MUnWsqQ7lgwyzV7SUZJldTn/YvoiCi8l9HKJXERt/bmjsXA0aQmaXjdDsi960z7My949WIVBkU1jPc694wcdjqvHSbUhf8Temwu9uooAZ+fSXWWGySnsU0llkhpU0KA8oMK5Vpxq1+vSpDgRlz0+H4F9t4Km/NETNLJHAWvXpDffDq4ax6la+uvoDe5leWj/S2jQKeW017vVhzQTJOdc9ECb+YnecSWCDTQJfCEQ7W8mUEL/sqaPJSxEVN07lrTSNxfkFv9Bxpcq2uGWNURiuJ+hqVw5GaPXOio8HfMWGrbc/M2o0xvjqfEphZI6S6hZv005PjYOHus80rQ5lge//VCn6dDvIufDqBPIP1BjguhC4JReZxJgaBOZIE82PnGWeNU6BPTZvNMB3vVDDvZvTUCSrGgl4h8w2dStTRJFtHDjKHnsrTFswnNNnzGrahbtRNl5KSuaB+5yb5SBdZWzcT0pTMbVCspgldNXWCcT/MiGkipLlT+SAZ3BDjkiRctKm2pU29akmm4lv7Zm0b88=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(19092799006)(1800799024)(366016)(261026121527099003)(11063799006)(4143699003)(56012099006)(261021135927099003)(10067099003)(261021121427099003)(261022105027099003)(18002099003)(22082099003)(261026140227099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nvJCRGF5gpfADybxkaJu3fC5ldWsPcM7BcfIs/4JsUaewY4KXk3InsNAjN38?=
 =?us-ascii?Q?Dcj7+xPgJk0CB42A1I8VYuxh4wPw8PmNfw9G8bU9Y7A+4FpX6oQOcjJS5Yq+?=
 =?us-ascii?Q?39xVBMrxk4l5f8vkc6rpZSwbsEPyXSI/+XiLuvkQYPQsQUYJqB+y/fy4UF+K?=
 =?us-ascii?Q?4DwBe6mbmE+POtsrwZfScY9g2Fo6aPcn83YqJLXHGsq58AW16Zvpp3H1hpF8?=
 =?us-ascii?Q?FdCzJcRzdXR8fz7YXLOCXfjJEPmrIFLKK+Cq09A3/lCrPz++bDo8xaTpOxqf?=
 =?us-ascii?Q?pSC28E2kyTYpW4MapZKtfIGkTpRtsFtpdau8R1tll6iGuoj1NsxA0xf5bpBE?=
 =?us-ascii?Q?80D2vKlLvM4C2eJJHijlYliiugpuwNxFOk/q6PGgfJotPwcT+nIKBYE9As1H?=
 =?us-ascii?Q?QTMaGb10sdl9+jfEDEVRbElJ+uRUvI5i1rRKXjc2LToFpaE33NCFw4fp5y6e?=
 =?us-ascii?Q?NBBeCOmlGnDVnfAY/pqY+5n0QiiGKvIwx7/sEp9K9ks8tPDs80SZVDTWgVvO?=
 =?us-ascii?Q?0h1S6y9k/KVSrqmxUHc2cDxJcMeh9YHMWxJeKi3bqI7GVjGi77z8H49p++O7?=
 =?us-ascii?Q?gqXc6HSsc1ytv1HhtzjwXYz7CB0DoMqC8qmh7z6eODPUUmhpSsclRkquoQhB?=
 =?us-ascii?Q?9tPgKJugi2vNZeorEo3nZKqo6f62MlDFPG64wSQJmT66yijRdSWBfZOEySBT?=
 =?us-ascii?Q?9V4nj24xMA2K4wdxUhgbv4TsFcSQ5Ran+TdQ1ZVg+TAJWHagjmsTTp2mqHEo?=
 =?us-ascii?Q?Y8AKW8SgJeWxnPDnwaCkPZ72gpOrRkN6g5hBv+L8N2hq5OlrJwaiIfxwZA2i?=
 =?us-ascii?Q?nGCMEnfV43OvqWDR3gA4Hk7U/OVDdr7IwWyCESrWdVYwHxgwGamCuL05Adrj?=
 =?us-ascii?Q?x5VPQQkz2g4KPtaDu2ZrSsFfL+CMQKHtNvT6uPutut4kvMkBJHQlLzdE8kpx?=
 =?us-ascii?Q?j9sCXyX4GIxZgLgFIOifRtkhpZTuouQoO1rhKMQMPz9CPcBBJLHE+U4D195P?=
 =?us-ascii?Q?/Tmz9mFfML5oDEB90bymZDXd8gx1LVy6LvU0rBFvJBsjmqN89fz0S0NJugCM?=
 =?us-ascii?Q?48vJ62pzMqeyn0Cjhjqzexd2e0nbLzOmi3jA5h+ZnL7wQcaj0z684c9qkSb/?=
 =?us-ascii?Q?k0VTE4yunkMQMgPJ1aD0zdHjIzxOaodjfcKtJOMRnGzKU5lVKcLYg96XdK5k?=
 =?us-ascii?Q?BrAZBrRgcG/am5J7UdPNkS9tJlsNFvVgbvqFruBapR27ovXENxU0FYHx4/kf?=
 =?us-ascii?Q?9znYpobP5LXssTuIeDl20qr02hpB59TrkCNYv0Nf17RkVnhCsd8vY23Um3Y6?=
 =?us-ascii?Q?rGy+FyhgLKufXxYFpakGbC0CVzhJ4mTwdYCeCg6LYMrcTjJ5Wveck13WfBox?=
 =?us-ascii?Q?O7I3PbIPpNNedLUwTewKWsoLcBwWN2/CrcBvXgIlihbUPcnOQ/zytQAYJejl?=
 =?us-ascii?Q?wP77+l/KmdkQgk5JWNO3mDguskBG4qLvn6naPsnxI8bNnYCjtCAw8Bxq6IhY?=
 =?us-ascii?Q?bMy7OPEKZdsKBjloSV3zgq6rDmq4wPDITjPOK6813f97q7r+szkzP1nXtkM6?=
 =?us-ascii?Q?hbbJiYVLtJJ4iJeiWIiA7BKdipjuwUPadij0+FZ1Pego7nAIJRtp4whvU/GO?=
 =?us-ascii?Q?knS4q5VwWrnbo6wH5sEGNJu34mAA+ZvZORcq4KMAphSB1e9WbF0oVWyVh2FX?=
 =?us-ascii?Q?QxDKUWpFRnTxLFiFBoDz8NJhNzzVuPqhB7dhMAEdb+UEeudYJdauXIs2yCSW?=
 =?us-ascii?Q?IgalWBrfLZU1n5QwHAc+WB5XLD8n0/MSD1gzS10SYMETnaSaIVve?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f1e643-a0cf-4934-a0c8-08df367e7630
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 12:08:09.0122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OMlCPgSjtfw4VZzmMBjhkvr/FeFtC5aOuw0tARJnO8G1eLFnQHt9yc8y3KTNUmsZNSOYIuxGkp224o2n5eAXWaT1/Tk1t0A/0EAd9axWa9f3YE0q8ZLYF0Tik7i13AoQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PPFBB9BDA27D

Hi Nicolin, Robin, Jason

On Tue, Oct 13, 2026 at 12:33:19PM -0700, Nicolin Chen wrote:
>On Tue, Oct 13, 2026 at 05:23:21PM +0100, Robin Murphy wrote:
>> On 13/10/2026 1:44 pm, Jason Gunthorpe wrote:
>> > On Tue, Oct 13, 2026 at 12:22:06PM +0100, Robin Murphy wrote:
>> > > If we're not going to support PASID for shared streams (which I suggest we
>> > > don't...) than we shouldn't strictly need to worry about CD tables anyway.
>> > > So rather than having to special-case CD table sharing for shared streams,
>> > > perhaps it might make sense to generalise back to a "default" per-domain CD
>> > > for non-PASID use, which can then get switched for the private per-stream
>> > > cd_table if and when a device does enable PASID?
>> > 
>> > If we have stared STEs then the group becomes the per-STE data
>> > structure not the master.. We don't have any way right now to do that,
>> > but it would make some sense for the group to store the shared CD
>> 
>> That would be precisely the aforementioned special case that I'd hope to
>> avoid. My point is that the CD represents the domain context, so we really
>> shouldn't have to have multiple copies of that per-device _or_ per-group,
>> _unless_ it is attached via a PASID, since in that case it does need to be
>> copied into a per-device CD table (since the per-domain CD table was indeed
>> the wrong move in hindsight).
>> 
>> So what I'm saying is that if we're going to make anything share CDs, then
>> ideally we should just make all non-PASID devices always directly share the
>> domain's own CD, then if we just enforce that any devices sharing StreamIDs
>> must be non-PASID devices, it should all work out, we save some memory in
>> the normal case, and never have to be concerned with rewriting any STE with
>> a different S1ContextPtr for the _same_ domain except when enabling or
>> disabling PASID for the (single) device owning that STE.
>
>FWIW, master->ats_always_on would be a special case here: it is
>non-PASID but needs s1cdmax to be non zero.
>
>But yea, that sounds like a good approach, though requires a big
>refactor.

I just post out RFC V7 version with sharing CD table. But I not
have the hardware to test the advanced features (:
only tested i.MX95, Qemu, KUNIT.

Thanks
Peng

>
>Thanks
>Nicolin
>
>
