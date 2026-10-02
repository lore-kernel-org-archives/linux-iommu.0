Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013014.outbound.protection.outlook.com [40.107.159.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F3247DD73
	for <iommu@lists.linux.dev>; Fri,  2 Oct 2026 10:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936104; cv=fail; b=avKGXIeJ1t8x2BUpnIMHHqk7eJ7hPBhq4EMBdDcAfyp9TxXsAblDzutYgrgEDirCzyXp5phOfZmE4HyiK8I3aF+oX/T4OY8KNJMZ2qR1L+SA0uKRE+WwrxMp4w2WKFwD1mZEHgi+zDa3b+GKLNcg2loYebkDa514YgReTsqYmzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936104; c=relaxed/simple;
	bh=Kdk5OlTmla2WBMu/r1YPdAH5s0G/miJ+D7wgXKBDxDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VLRmq/MGwWxBB6OMlBVNT3N6DyFnbxJrSKDIGk2APxvszgbRGwUSYSP6aYaKcOVAgEH/WJa8XtM8X5ePAnSYDI6HaIvgPo0VMBc5+YZomQ00J7suT2RsiljTXuOptaLoY8zO8QYxOllEMEWbjtG45k8/qlItpVig2igBgDRJcOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=MvSsheFt; arc=fail smtp.client-ip=40.107.159.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MvSsheFt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uR8BStoELcALwXnNfNt/7TlAa6E1VRNAsPp1bHKfZCqSrMLZ5m7N3RV7ErlvNBvJVPvpYI/baRagvLgP1S8ai+qMmqWhcBdya7RHqeWMAyq8PkveEdyRIFNadDEZMs8uGqVU63G8VDn6zuN5fPrz9JXVkR/XIA+xShjP3iEcN94eGxK3c5hmaSnje6fxqdeYDk6AQcch00/EAFTrLhbLZoB513xAwGJhzNAj/E/ynaEm5lZhEdk97WLFjBEB9T3aM8PDi1A7pdGrZaE51QzTqchhf6vzRCVnqPi7f64owfYXvF0aiSNhIV7erpTES62fpBfSax66dy8BhJ9iHuW0Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pRxeHboNp9h/HSv6zy+V1Mh/+A38NoSBIebFNUvHUU=;
 b=GY9bx5rACj0Qq8pxKcWDfPZ6mroSWm1Drz8hBi5tMX/e8aax48Y7LFYb+amEnkKVe+YS9/Umt6jZ39L7H4EbKtli7HM66dRs7Try/sVHj2kBr1lUC5FGDMjrkB9yq68d3Rkv0GJw++CGcd3xxxt/AfV3JT3A6jItuj4zE8+DYN3x/LrRUif1vdo6OxN+7Bil2a+wSnJS920PSQ3PHrhb0BQHTCZ5X1hyYYhG/mAjN1s2gDd+L7g5198WQKxYcvPyjQseC1I+FXkZ+ruVScoDxsNmA74oBezB9b3Ze5w//wbNWzYLlrd4oG8fTLOPOqmyjFg7WXKH8giJAZkq72EXtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pRxeHboNp9h/HSv6zy+V1Mh/+A38NoSBIebFNUvHUU=;
 b=MvSsheFtL1pQvByFtmih2RYCTLUAumIXUdgrIey9Dsr/BaVdGK364bM8CxcH7vY6qNasvNRTRx2pllI79ow5esZ8brxWES0ZrNDv0YYEaokrUKklODpRapX5nEFJksDCSZgU7e1huS+1xGCLQLb6m2t86A5KBdzC+ihpW5Wi5VX15G5wuWW/11VjoeSnMgj0vNrMFVlQpoCUxhW1FCLoSr9CqzkxT+GCmctbxsELd7ogXleJVo3OuO2kKRGEggNjcljqzXkboXjmVqf/GJOfJIvqaYr0sHjXEXa82+LRO1/mb/+T3UyGRsHGC9HeoB4E1pBSZsQKt3jF1+fSPd5Z7A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by VI0PR04MB11602.eurprd04.prod.outlook.com (2603:10a6:800:2fa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 10:14:58 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0451.022; Fri, 2 Oct 2026
 10:14:56 +0000
Date: Fri, 2 Oct 2026 18:19:22 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC v4 1/4] iommu/arm-smmu-v3: Skip duplicate SIDs when
 erasing streams from RB tree
Message-ID: <ar+FKrasYdz28wJy@shlinux89>
References: <20261001-smmu-shared-sid-ver3-v4-0-06b34fb2e691@nxp.com>
 <20261001-smmu-shared-sid-ver3-v4-1-06b34fb2e691@nxp.com>
 <ar6FNrZfN+ZXVtsk@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar6FNrZfN+ZXVtsk@nvidia.com>
X-ClientProxiedBy: MA5PR01CA0010.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:174::12) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|VI0PR04MB11602:EE_
X-MS-Office365-Filtering-Correlation-Id: 459bb30a-9be6-4da2-6ecd-08df206e015f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|23010399003|1800799024|18002099003|22082099003|4143699003|10067099003|260925021311599003|260925022911599003|260925021911599003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	iKspI3Fs+s+0bcarPtu7dN1WRgCunTLBqCCee58cneRlIrghqkNIxjymDLbFt/rmQe/p9rVZckWV1GklRq1DMvhO27pAxtu8cHFPB2Uedw01BEhvv5mB2OHtNKPxDTRYXeBQ/dlJ9s9hD9szcPvWRqlkbsQ9y6z8oF7OAVFtU+iT1HJcxb/EkRi6MFzLR4YDUSL7Y3mLftYXmzig6AROkKEF7m0dvNb7/psL0Vu2LCrCRNisFiqGxq7pFTMXv3SQFix0YITmnGHKq0LQb6G3L74SWW4CeRQIDWaccf60CaWc6uLOz22aVfC6it+7FDVYKh1wXtNrynZk7+xwC9AdDAiGqelys6ETXS0d2+5+a1LZqSnbbQUv++J0C3QRRV1px3zdRJYZ23MDQ9lmhzmWl1So6jcH9QwdPxj6FLiHkqjCFCknMFSbZzOV5hMY+R7qCTAy1ntP7i1o2WrSdzqLVUQBpFPsfJmOyDx7IY2HLBNKdYjrKxe8qxA0Aav1Xs3p03i4MsGEKlhHUw4l60sKFbubAysEwI1o/5ztUviQRL4jmxCgg4amumeBRp8SJ0+Ui+2uL1fQLqikuTpzoypMjdPA6sSB2zeges3o9GtVSH2pK07zukjVz6fNAjzOhVum5IYDHo8/z0sbWbv0xt6gKs7eS/8WAD57Ww+PMptn2ik=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(23010399003)(1800799024)(18002099003)(22082099003)(4143699003)(10067099003)(260925021311599003)(260925022911599003)(260925021911599003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/IiD44h6emVnir31QslIXeTDPTKY9J8kCxZ+3LNvwZ+CTYxJcd57D3XYL0e/?=
 =?us-ascii?Q?I+48JDXzP7LJnD+DMnIaRESGBupU8GwWJ0KMqYhoxbXa3SpOQciIcdDZhyoI?=
 =?us-ascii?Q?mfvX/zPVUS1xPsX1qavgytrasCY5Sxx7j3cnSJWdCm16MwHLwaMmWrQ+VyXE?=
 =?us-ascii?Q?wVCwEX5E/KTTv5x+Pq1oLbBDZ0GDTHag2/A87rR2/70f/eTBpu+dEGphep22?=
 =?us-ascii?Q?BqcCdcvpGZVpbd+SSzZU6MW5+Uylw3p7VtJYp9hsVFQQaTxiBydxNaswLvBx?=
 =?us-ascii?Q?a1LieH0GzUzUJWQI0vH2ZJZlvZFUz8oBafVf6uvQq6AX9z/wY4wBLKykPPCT?=
 =?us-ascii?Q?5Z4xsSHcHC4aPN5T/DzdY/vWU7nVmkMMUiqOXUqaVQDnhQTjEgwsSGwS+Ib8?=
 =?us-ascii?Q?Gi9pcEUoAFU2aC5idEslOB+StgJZ/I4djl82AjE8jGRw2W6b2WyayjTk5RnG?=
 =?us-ascii?Q?xLYd4wmseH7k7agf+Jwh4NhyJ/jfQeKS2D7OLba9cSHYl2UHBjaNAqzcdeHi?=
 =?us-ascii?Q?avpZ4u8aLu7TUedgLeY1e/jrMLDo0l/x5UXJ8zCKzQ68Jw1idPaGNyvsJxmY?=
 =?us-ascii?Q?IjtQsYC6jE2ejCksKmUcarfkYGU4++LN6/yzQ8jTzI9slnhpKXmB6HV6r0Hw?=
 =?us-ascii?Q?1PLEW5ibLWP3ohaWKYVenKSEVKFS03U/lCST9cQR6pAWvl8Bhw0E2wgklFUs?=
 =?us-ascii?Q?7WNDDg4nwp/K4vTApvS2B4auRW7UtS70OeOwBGI7xb5eC6ctRl8oobNn8qYF?=
 =?us-ascii?Q?hYSnu1ZWEiwJPMF5DrjI+wwVI6E4WmGemxsZigT+QJWynnhQWPXjCYts4VLI?=
 =?us-ascii?Q?mP3dbmbrLmqewqeXO/pD548ariSDR2uLQP2us3ClBjamSsISPik3Po2jlNHh?=
 =?us-ascii?Q?eI6IKcQPqYzizl6wsol1vzMu8zDT+4VLkB1WCFS/YgNTg7GopmzTVQ0ycnUD?=
 =?us-ascii?Q?fdXQAG2a4MZHu9HF6669yKT3jZjLFGq6mBlDMzl+qQH215VXYTFl1ymoHa6J?=
 =?us-ascii?Q?3dRZoYMgA/uM7tDIbGwHF+WstaqLmqIPXrxria+ufLBwph7gpViETsqMmSZb?=
 =?us-ascii?Q?SoK2HVIfi59OJhre5XX9ZonDNowzLoBCAR+CeuhP4YqXO2qZVFFZLupqh38s?=
 =?us-ascii?Q?M7sV/rQW/0hIdYQMRsYZXxegFBty4RTThHHxlW385jdwI+IvxEkN9xDXQ9nU?=
 =?us-ascii?Q?t7EaL/hoy55lvuHFMaEvM/VJQGA3ZtZctGyubxunGvQMFrPKk1NCdScZr0jF?=
 =?us-ascii?Q?FDwOffu+Z8K/6Jc2248WgZUtdw05ZbDIUZBpFCtCdxrcxwuIExA+uNumYgKV?=
 =?us-ascii?Q?+WWnkrIDemWrOJiiFyIZX1Ug3ziBBzHc9lyQHIQDQphrEIWXHRzcLgoxcxiJ?=
 =?us-ascii?Q?aXk/WLC+I5Lt2kbCrBoh7xFr1grchLD8JLxfpVXJykdM05HxpUEC9WDDT06G?=
 =?us-ascii?Q?PbxXs68z71H6CVBecfNfImlxvzdgJrcYXvgLkDmJcNP7ajrT5anlC3fuJHo0?=
 =?us-ascii?Q?JxM7NTcLv/3EQC1MpyV3fQnC+JAUBEoAx6dhw0jeO4t1+ufHLQfi/l/Wsm3a?=
 =?us-ascii?Q?2WuoSZSW0bdUu7hkONSMBhLTgnxpwP5q+WHJG/phw3T4LvanV5CCFqFUDmYF?=
 =?us-ascii?Q?5ccJGmWsEOsiJOAhgSH6iSwQ/xOBwUIFP9PqyUEgl+0m+d/NROAPXhNSKvXX?=
 =?us-ascii?Q?fiJw/VNH9H3hOOysDztILjWUnUe3+reBfxraP/cPySzIUJ7S5RoPnRrUqE8+?=
 =?us-ascii?Q?L5b/1xS6ewoB5/x+5Tr/2Kff5fkfI2wlWKnQT6Ep5cE40Ln2CdaX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 459bb30a-9be6-4da2-6ecd-08df206e015f
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 10:14:55.9709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2HtRecFAoBDkxYC9AKU4SLcHQSM6XrSfVEEAaxLBrz+QSVkNH10IC21G0wDu2dzb+ET9GZkl9juekN8jLAbkqgD+1oCWi22dlc2evK+jPPxBY5zDtnGHr8qzFHyRVxIF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11602

On Thu, Oct 01, 2026 at 09:07:18AM -0700, Nicolin Chen wrote:
>On Thu, Oct 01, 2026 at 08:49:58PM +0800, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>> 
>> Bridged PCI devices may end up with duplicated Stream IDs in
>> master->streams[].  During insertion, rb_find_add() silently
>> drops the duplicate node when it collides with an already-inserted
>> entry from the same master, leaving the duplicate's rb_node in an
>> uninitialized state.
>
>There is already a cleaner fix:
>https://lore.kernel.org/linux-iommu/76c5f9dde30269995ef842a12a3a5e1ebaa3e6df.1790188510.git.nicolinc@nvidia.com/

ok. I will drop patch 1 in v5.

Thanks
Peng

>
>Hopefully Will can take it soon.
>
>Nicolin
>
