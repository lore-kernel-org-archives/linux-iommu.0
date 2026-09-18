Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010058.outbound.protection.outlook.com [52.101.69.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373B8509EF8
	for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 13:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738636; cv=fail; b=bAns8Kcj3QEWDZeC1qy3l24LqQTPLoqWNHFjZefYYZSt9NiuaIp+z63UHNaDcNdhnl0DX4qLbeIer0+9AG/0TN6qZ+5hAcqeQL7r4dewoYDWDimdjCKSoqsAyQuQuz6NB3JAe+44vJWPacDL5xcNcWuLqwiITVCvvAEawDh92r0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738636; c=relaxed/simple;
	bh=w5zo8l/85O0D4TRhgIwIxx4HQMavUSSoKyctBsT5dRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qc9R6sYJIHMisBiBtIs8ADmYDKAW1L9OOz3B37nZCt+ISUiARSQUeLZQKwSSaamKC8gNwq89n+1bQMzNv74PDZW0G3noV3Y2e7Qk5vcNd3my5Zj6OrkW1MzWaEYBIgmoTQUL32YRKh3kfVJu2VRzqK73Zl2d4hJTkz9vuGrYgHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ZFrME8go; arc=fail smtp.client-ip=52.101.69.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZFrME8go"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tZhzrRLK1vPBK+/xWIWSuV+SyzR2UmXdN4wXMupt6U63pTnsdgOcgZM91zSR52029BdNQtJGQI01M3SzdKAegReZR13ba1XmI3H5m2bExkHlnAqeXqYbD7SlQOEeZ+zk6I+Sm5O0lmbEoC6GHZV9FYyCKpPf0cxsK9XvKv3ycDodQj4Q9sqX9LyZ1p6K0Qmni4JqJsUn4h7vVxi8aPi3i0FZOvJdHZ9d9ihcwDFu4i2w8jbpMcBfr2lKjWtBQHiVF3rd22nmM5oPYcdbf64xdqteU4G37DKuTRTnWgrJDPBOB6ebR8UnK4sXQtoyQsfQ3wHlzk1U8HZJn+mdZ5JcYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjL3iUXwo2/cTbIpkMnuLytGjfyYr45FBZILjUnrt7E=;
 b=t8K+1ipUDwL/BkJSBijB0gtCpUgiuDH4j8S7FDE1vgBaPh5FhP82sbldG+VjEq2Z4Si1+0xcNaQPNWBVussc1O8sN5l0pBcn9O+VoHGt8GHRO2Ck/Wx0lHF3S6EpTxhbtgTF1AK/skAGDEvZ9oAfQsAxifZHI3Bs0XQ0iUqQ26oL9iCruuUsFJX+yAwpbLVZWS49kptD8uTMoi6k7Wtue21SsiJowgJcnM8hEwlvis+gfieISGcgIeVXFMrcdkhkJA5oKUhA45AMvYfaZgofMk3wboxmGjaP3+XgQW7zz96B1d6MFbWOyYX7ypJ6CYR0lSlz1tLsTiYXi+i4eTv+Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjL3iUXwo2/cTbIpkMnuLytGjfyYr45FBZILjUnrt7E=;
 b=ZFrME8gouncwh5/1T6uUrmdVkwblxPJD+370DcmaIjEJt+2yUxfwlbp0OzqbNu2RK+vY0yABQFFmI8WFRVlQi6ILtKw8jlGvauiuUIhNLVClG1t5e5cdzdz59C9g+1lHiGOgUpvwhN19QwlyjVKRULJba1eLKWm4VmSxHUwdo2Ui4dzIViQ8Zf3sXkS5J5FPV9MCQShV2VfiYaL0SwDcWic/qhWaHUNNeS55ZJjysMSQQJeSK+WGxuyzPsPMjqOhWk5YAaV3DQyqRRDRQKTa4yHgGgfNm9oQBJfL7Szn77z+H0fAuLKU9l+gCnGhgHw6pLBavK6Z0HoJVv6xMUHbBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by VI2PR04MB10785.eurprd04.prod.outlook.com (2603:10a6:800:26e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 13:37:10 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 13:37:10 +0000
Date: Fri, 18 Sep 2026 21:41:29 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Frank Li <frank.li@nxp.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC 0/4] iommu/arm-smmu-v3: Support shared Stream IDs
Message-ID: <aq0/iQKcWhgm5wqp@shlinux89>
References: <20260916-smmu-shared-sid-v1-0-517384504aee@nxp.com>
 <20260916161018.GE3196566@ziepe.ca>
 <aqtDg1EH95RYOdCJ@shlinux89>
 <20260917144804.GI3196566@ziepe.ca>
 <aq0lEk56qRi93geW@shlinux89>
 <20260918121132.GA11599@ziepe.ca>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918121132.GA11599@ziepe.ca>
X-ClientProxiedBy: SI2P153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::14) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|VI2PR04MB10785:EE_
X-MS-Office365-Filtering-Correlation-Id: fb8ad6f0-b159-43ce-886d-08df1589f0a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|19092799006|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CifHkrZJqrHdFp/Xisjzl2m1uTe5p+c1Z27l7We3k3fVevX9jWBhXnSZQSmmKAzUc3teY0Rp0hsBLlxW89cmiX/H1aKl/oJPu+p++WUNCPIUuwBu+Q7biAV18Vo13/hSS9fWYcA9TZ7dBtmE9Na3AB1a7QuVUfmV1lmakeGuXqbZW8YGDFKIgNRV+DnYKihh+xE1twJB0VtvWWUhZtTs6NVHYX3IeaGuaQXs3ogcmSQeuu/25VZDPD+aziY9yEW72Gyqzy072p66lr70pUMpOaOhQXpoRH5sGmSeZcUQuUD7RWQZB9+bXROaQmba0t7aM7wWAGqatZyvs5SgRFQHIIf9rRCriFhOuzF3lriTF+drki1q0QTWLS0vLE+ciX2fUibQTLTjd+4SmxMTTuLWAf0qC1H8/2IxqbRXbhLEYc5n1n8/NWhiGOTkL2SbgUn70jgfIdBtCJAGjuivqT6+farEuuSHCbth1X1E3hgxEjVmDWtNu5pNU5KZSA/WxGGZ46JKsdwVz/oQt7PLuxuw35vjlHa7S13cQs/0inCMQo2YLyiCdTpgisBQC4PZ25oxrCxD6UWUeE5EzVlRaQ0YWiUgKYoc9OIuT0m8B6YjxSMAbdRXin0iCc0QW+KD7iKe0St0jKKLskewjeb6FXIrYAT6Y6e5lV0q1bgtRagahMQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(19092799006)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1CL8gtuqfDbh7KSFIzBGcIfpgiBAnq+ZODvpEowYuyW5CNMBE6RKYcHre4I+?=
 =?us-ascii?Q?OEtdwJ1EN/yO3TaaF9Khs/JD51ZGlyDhmdoNNs9yEceFvdg4HR1r2iHBeBMR?=
 =?us-ascii?Q?RIBRgBk3s/4whxy5tYDeX79iV84kykqal3ek1FuIWo75qxqGY8BnMEwCgPnU?=
 =?us-ascii?Q?gLhEZl7axerYNAPdzp6JTnmmjWRROT9GmXosxAxDsVtb1tmVIfNffejT526N?=
 =?us-ascii?Q?EYUDC4+lxNkE5lnu3duhT5YImuJYXfT/Oq2BakwbWWBp0S5uvP1Sei6czN99?=
 =?us-ascii?Q?E4F88MOx76x4W3GQ2JBH6Y8Al2/yHxP8aQ+qBEkLw/ug79tt40qespNAXKPb?=
 =?us-ascii?Q?h9o+Pth4Wiv4hvTFJCe0R4v+fUK02POl0ZnNOG6aZ6r/ROxLZAksZaxvpzRV?=
 =?us-ascii?Q?kEt655PBQC4AiqJOnEU79LGQkgKT54awiWfd0zbTzeLarn5xsIpwQIc67hHj?=
 =?us-ascii?Q?6aMif0xqhVR9Z7C9ASCxiDx0VzBb29wNo2iQjAPtKs8nOvTITJ5jDnL5u3y2?=
 =?us-ascii?Q?0fhnD2Fj92G+kH6OQVXq5N7zlLWonkWPGjX+3VZlO5owpskeDQnc83Rne1l3?=
 =?us-ascii?Q?8SfOjpDUMeI9F9S5SnwzazjaAPEesQIweLPa6W9hRqzlOKhwwBQhmV/GaBuw?=
 =?us-ascii?Q?ZSaY+jlfZa3sAjv1av6DK0tN3Dhp4X4y9RGlVw6toKXMlUcVK8RbLsekPd1q?=
 =?us-ascii?Q?1Y3uaf0ibZkAeTGt+msCopC4MvTTdZwMTs3aZs9MeVs5cX9Sa7Gbk//G+q80?=
 =?us-ascii?Q?swOhABNzXOrw0rY1XA3Zwpmx4fAATQQPcB3fB6recGfagZ0eLUa15ipTUsPt?=
 =?us-ascii?Q?WywmwgZl4OyG99IrBMenyT41/UfwO1wgAq34Ap9tSEOVjtuOtLzqQVCSQKLq?=
 =?us-ascii?Q?Wlw3kBpBW8Zdjtwila1qTwJ9PtLXNeHMpTKeGBmLCOV6Fr+FLzjRDtcTnZs7?=
 =?us-ascii?Q?9hb8fWUmeAUyum98fydHxIrxPHlAJ6OQouA7iJ000OW2Wa8K4MEF2tD3hyLB?=
 =?us-ascii?Q?gKa1fiUiJVnUB4nbyfN5w71yhtPJrwKqmhd5BTXDwwMev6+JkVjw7CrGMIeC?=
 =?us-ascii?Q?jDneAeGsMEW/TenvRbMnzs9TLhCcyUoa8tp+BSr2cmoATn2xlFmqE+5/ujR4?=
 =?us-ascii?Q?qyzwNPm/k/5FJdhcDZ1PQ31u2aEvPYXEA2Ko85H0D/WD+8vO9w6K8kzNHSP4?=
 =?us-ascii?Q?k+jjpit/jl9fO7TCkDRDIfs1dkTKZa8/0H3DZD3c4pBt35Dak8ql+UcVu9Sj?=
 =?us-ascii?Q?er7m+HKZcNutFqB7ccjCXIURUi9zQmU6+pgCk9staikifuO6DcebhlISntUV?=
 =?us-ascii?Q?Zzc8xdmUtVuhiNXA+E3bp7ZWGRAABKa0QQ2PEVgoLiLFprVKR52kjOB4p3c+?=
 =?us-ascii?Q?TCX1Nx1B8Ds/JtUJCN5L2zfqVzrUjxzkty7zgSXoYxLRkc32dLs97JxeVZqj?=
 =?us-ascii?Q?YegUhwbE8r5lJvPLj3aHFYgjJZzPBmGccb+FwA6ujUn9o9ZvDG0KOWbQ4LFm?=
 =?us-ascii?Q?cOMzdDegbcEkIVIsUP44Jyb5HNt9vHTJpwf4O/zwltYfcE5W3d5j5osg/C6c?=
 =?us-ascii?Q?Qf9HhzbS++hnqRTX+LDzWJgvNkOYWlcpHF1cyuObn17bt/s6SVfPXgBytBAq?=
 =?us-ascii?Q?xYkmlMW/inNzb7t1OnVuRoFdFr11jPSX7b7M1fGkvjKPMV+A0lpWFII75xad?=
 =?us-ascii?Q?uTv1DUjU6YrFMZahMJ1pHtcd/cVmhy459vbWS8MLpFsGz/HCXwvh29ygbzDq?=
 =?us-ascii?Q?71RQu+1I156pIyokuA1L5ZadM53V00J7di9FxgN6OWlNqnioofge?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb8ad6f0-b159-43ce-886d-08df1589f0a0
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 13:37:10.4770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8v5vMc6jD26aI7ZAmfazV+BtzpRrUjACbmRtBGELgQVTOxH17Y1soGnJknhWLULeuC4GEFekXg1/8warYNFwbkG4JRXxVSiQk+pb6sZF8ZSIe5zGZdc7DU5IiGlTesTs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10785

On Fri, Sep 18, 2026 at 09:11:32AM -0300, Jason Gunthorpe wrote:
>On Fri, Sep 18, 2026 at 07:48:34PM +0800, Peng Fan wrote:
>
>> However, the DMA channel case was just one example - the shared-SID
>> need exists independently of it. Our SoC (i.MX95) has only 64 SIDs
>> total, serving MMC, SD, NET, PCI, DMA, NPU, DSP, DISPLAY and more.
>> Some of these are genuinely separate platform devices (distinct DT
>> nodes, distinct drivers) that share a SID by hardware design because
>> the SID space is exhausted.
>> 
>> That cross-IP case cannot be solved by DT restructuring - the devices
>> really are separate. Would you be open to reviewing the shared-SID
>> SMMU support (patches 1-4) on that basis, independent of the DMA
>> channel question?
>
>I think you should revise your commit message/cover letter to focus on
>something that is not a DT abuse and try again 

Yes. I will prepare RFC V2 with revised cover letter.

>
>IIRC Robin said the SID aliasing was a PITA on SMMUv2 so it
>really needs to have a strong reason.

Not like sever/data center chips, i.MX95 does not the advanced features,
so in [PATCH RFC 4/4], those advanced features are marked as not supported.

In the chip internal bus, there are only 6 bits are used to carry SID
on the bus, so limited SIDs.

Hope we could move forward to support just simple SID sharing between
platform devices without advancing features.

Thanks,
Peng

>
>Jason
>
>
