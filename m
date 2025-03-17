Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327A1C8EB
	for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742225711; cv=fail; b=JC4Z0TBzwScAJtq5cNvptImna9VEeZs5uJVNH328Vmw+4X6L8q9FLWcOPLqmq08YS0HJeaYXRcxRvG2yXi8UPbE1SFmB7x7Tu99EUB9BPnFazYqB/7m8Upqde4OWxskqHSw5nmTDDbHSXg50GQAJ27oXaXrDxcCCvjI8gQIrPXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742225711; c=relaxed/simple;
	bh=5if4Dlk3KAcibrCIzUPmZeh0MO/ZFQJFlYz+202XAAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OzoIyI6okTB6o+LJnnoIIOyAvzugXYZasiTO6mj14mEgZqh51LmryaMv3prbYTDiI6/2BJXpdA4aGU1hbyRmU428LqEfixwowSmU5ePr+2xAjd4qIcUgTjrKW31YZ5n4362bBNYI9ENbzk4XStFoGQL8OumJwqPnVJ+AqzqrcxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b/rtYofC; arc=fail smtp.client-ip=40.107.223.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b/rtYofC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dwfjPgFageVFtOLf4yW5R2FARyytMJ/y3Zv/ocWcE1drBzkdbILp3GqXsSEpEZc2ZedbzJo0pZbhNnkt/LCubtzeLDbwc34w/xba1QnsHj07VkDAoIo6IlqlNomKc6Jvstl+oLjVebx6j25Gad9St6c7VT2vDn9RePuV9WLOYu0cuVsOhhWeRnOGlMzWo+42X2rkEeVsFrGGS+zdk4+xqIVn0LLFYQsnzvH7q2H93ZciTxCPBUw2Yi2blF4+65ekrhgEIP26L9rClKtkA/cGKSNwzAoCw/XvSq+jAggYjo/fIaOTMfArWWGRJ7maAE/4l77H0xwe549oOFmFDk67oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5if4Dlk3KAcibrCIzUPmZeh0MO/ZFQJFlYz+202XAAU=;
 b=qG0zfS0FnhO2BYkIoD92xEsOl1/IaRHV26Mt8i9S3/Ox76Tnjjy+FV2ixY1meSB33z0xqFu1MkSejGUC077c98BZZt/rUHPhgqxWg4VHFU3Ks0AQcIcmuIbb3lE5XRrwfYuba8Nnqb15S1NmrKGXo+MozzfHUWGSFY2ILH4Ff6n9/msZuW5zFQTDZxNX1oqlvWoOp/PN2A6hOU+oZ16FsTTg1mCXpbvp4ZS66BLCe3kyRGxWjSmc+nIdENYAJPR5BuAx3hBZ0d9Nzo6/LtDB9w1x6uVgMvlvBAm+jOVA/FAy4h7A950Xe+YgV4P83sxLISKZYARIfsZ/Sx6i7MvBrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5if4Dlk3KAcibrCIzUPmZeh0MO/ZFQJFlYz+202XAAU=;
 b=b/rtYofCxZS7lgRRp2gWcNkMXwaui876sPYm6zangmNXmCtT8qWfEJV6ig4WGus2ZFykITj/4HnKocGeof5nwcU7+0b0Fzd1XbhKNYevTpFCC7Z0+u/aM3Ls0YSOwc1xAsLw2kyKrx8Oq/4CbTKW0+qGuBm8cNxkAYbDQWLZBjD/XLnmNSyrR7ww2A6lCaC9QPYuN6yWp/mjoDu2OXdtLS1L0U0C24/q4xhu6exV/TFgiJ/Qu/9F4FBMj8l8JUT1kFz4TyXrS2pqQhrYWyE4j1T6pwTOz+9IvaNkZZu7cDuy5B9yuboOEkhaPU38fVGn0FS1ZEpymXWVOhOJ1CW8OA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN6PR12MB8472.namprd12.prod.outlook.com (2603:10b6:208:46c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 15:35:07 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 15:35:07 +0000
Date: Mon, 17 Mar 2025 12:35:06 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>
Subject: Re: [PATCH v8 09/12] iommufd: Allow allocating PASID-compatible
 domain
Message-ID: <20250317153506.GG9311@nvidia.com>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-10-yi.l.liu@intel.com>
 <BN9PR11MB52766783E53A987FA872ED918CC82@BN9PR11MB5276.namprd11.prod.outlook.com>
 <a05fe92b-b36f-4240-a20a-07d186cdc4d1@intel.com>
 <BN9PR11MB527619BA7FBF947201ED68F28CCB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <962c985d-3d58-4ad0-9cc3-4ace9ca05481@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <962c985d-3d58-4ad0-9cc3-4ace9ca05481@intel.com>
X-ClientProxiedBy: BN0PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:408:e6::34) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN6PR12MB8472:EE_
X-MS-Office365-Filtering-Correlation-Id: d80c5deb-8283-4ad2-d76e-08dd65694b94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9mjwzTBH1T+rqGaf94rITCzNETgEv2+wJKTuYqknRqCTDFDEN4qKInIvAE9l?=
 =?us-ascii?Q?Z7HWy981y27uxl8yQEksYUMtE2bEf3pqyG5oyYkLRL3Z1FrnBhgog/rKDok9?=
 =?us-ascii?Q?1+Cr18up5wDO92oMLAJnCIoaJOy8xsBljfsngp/MMhXa2CQHWlO6gZiEtLlz?=
 =?us-ascii?Q?xwP4KkCEKqeATFqU7QsvQsDP2WCLZSAVBNGmwYAGPP5OsE9mcxhvlrWDvjJV?=
 =?us-ascii?Q?pdb3T9BZPAM2ASvymENd+C2xQEi07F7ySb4VcGyr9dPZy4hqEKc2pF3Y8ro3?=
 =?us-ascii?Q?yCA1XPPjZUdWJH3NNd+dl84MGjxueE4AiyBBqElwf4ygwuz3rDkM5Zttc1EV?=
 =?us-ascii?Q?gAp5R5kU4TFJjupefxxHA9ofIWyEgC0JagbRqyMp7qA2S2L9YzgtuhZ9iMzy?=
 =?us-ascii?Q?TJjQuFWfN+C6PZuA/epBX9uj/ZguoyqlppcVGSutjF3eaXcWWRQE+4cUcibU?=
 =?us-ascii?Q?53SyrbRHJlfhu0snnHv+/3KCmqVcYAVgKTgmFYwG4SfIqXPJB5pYTuetQ9YG?=
 =?us-ascii?Q?SS5SCF1D0Z1PDzkG5gPvzuEtEWzwDVe8NzsjBH1gSbj0zsR4i09ERdhlUlOL?=
 =?us-ascii?Q?nSaALSgCrKHehRzPU+FpyDfMoLX229OoXu+6SdEnTQ/rkw/gKFvei85T4D0p?=
 =?us-ascii?Q?0cQT6+oVZ85GGQMXab6QpoHSqzC0YyUSUMCWE3Cd2EbmCeo3Fi4kvF4M9fi1?=
 =?us-ascii?Q?Y/fyjK9QuT4RYwjOVVB8VPuUlocJZkqJ5p6J3s9d1IG2T2UezQuiCkNIu8iY?=
 =?us-ascii?Q?YEvdjAYkqNFchZ5MeTcTPaRpJvvxz5EMQlCG4jLviJEhr1613pPt2fmYhs/W?=
 =?us-ascii?Q?arjJgjcUjWtu2AriUiMgIrk6vBe17ocf9YiGITiglEzeHkiC5XyaDiuhxclw?=
 =?us-ascii?Q?KH7jKMPKbDbhhDbxxSb4BI/0O8nDQgKr3THTsnfkN1a2w1msPLL7pl0yykoc?=
 =?us-ascii?Q?Oly2EVwVSEFreE91vDJjeJkTfOpRBUdbjbcDVgaW2Vbcv50iDrXy3uia+XyS?=
 =?us-ascii?Q?UvTtAslmCS/4Lzvvt1kxw7Zodo8Sl3QbjJSrBk9lnNskauTjYwmOpiTgNtE9?=
 =?us-ascii?Q?eUTOk91ocU2kCxZ0nZjhrM1ldNVnu4VMFo40s+waybyPA2rd7w8kFaIsM6Ho?=
 =?us-ascii?Q?uuXuwbAX7J/8gZMhIQJuZ/pP0W23+zzdOGPBRXuqbLDv7jk7Heo0quXoaa9Q?=
 =?us-ascii?Q?GMA0/ebIE9U5NHdHe0qoXBo/Lt39nZixtdUMPtCNKSQGRrpyWxGhFsEXMrFX?=
 =?us-ascii?Q?c5UizG51OMIA9Eaz49Zcn2q8KYGBP2fojUxheo8D0PUGrPyhhn9XXGzgeiu+?=
 =?us-ascii?Q?xhtrcLKRZdVk/DT4SlE/g+803+6744msQ5IqD0tkdU1SU+GugTov20Fw1Btd?=
 =?us-ascii?Q?pXd8FFxxQyU1f4rJRVsB1ZEhFCKN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xPV6iXwnlNhs3ppkiaejtD4wdzuo3j5ocH5F+QujPC4XoOHju37F8WddamKf?=
 =?us-ascii?Q?OHb8lP8aaw0LN1AojIZAUF53t4gxLCEwZoH9NrHIHzcoZrlbVooRAFWORBaC?=
 =?us-ascii?Q?PXNwlXQtbtAv27zvjU6Q1Xe2XDQqGdxueSTZ0QvbiLGfEcAzykXF7ds50Vp/?=
 =?us-ascii?Q?KCLW9cjMzaxPwlzPwl5sf3CJyQ65YsEFPlUahMVZy5TycW/zy74tFtPh702J?=
 =?us-ascii?Q?ftd00c5LOhubzlUbUgAsx8JieICsD0FjOMG096TshXmtk9QaMSLOiDskfJ36?=
 =?us-ascii?Q?xwE2zLUdn1vtS+QsGByxtBFfZ+2hWApNWUSM5rd85rrimFkZV/4Bz28z7Vai?=
 =?us-ascii?Q?IONnGiI8278VKjAsGZqLzcKS6xgKodtqqsfTGJQX3BTYdbEpbrRZh5Lm9etK?=
 =?us-ascii?Q?HXGXyqjbPSDPMT8U+h8oA8YsggZUKq1/kmTbNElWkj+A96/Jn1j7GcJv7DbG?=
 =?us-ascii?Q?nVTfP6P1w6GqalOQkxQ83kzuS/B6dj87W6TISuBvRuxN6wRtksb1k+cjHEcu?=
 =?us-ascii?Q?UHLCJKs8yMUlK0lIZdM8a+AkOEwMDZ9D5xWXtXHKGjctDI/b0HLs78hcG9/o?=
 =?us-ascii?Q?3TyjrEp5jhaCF7KeA+lmulCCc1eJxdbfxzk/B/adtX0JoPiZZ2YbUwrq9KO1?=
 =?us-ascii?Q?A8MkEq/GuyL6ryG4M3MtX1E7WreJ2sb3XAGZMhWkzF+a28GAoXr435h/vtFs?=
 =?us-ascii?Q?RJJE+uhByVnMWzAjLQ62VZg5Z8P++KJnv3nbkxiJ2OVLF2VhuUEjA5ySeuE4?=
 =?us-ascii?Q?bXRT8T4W0uRJQ2GsO0hTxYqOvD8gUqrIVugc62y2LVW3a7wHccpyFqRngRcu?=
 =?us-ascii?Q?5isgm1jOpfHV1Cg5OXllAk1c3sJuKUgs5U51OCbGtOavXXIp+vGr+2gmVM7Q?=
 =?us-ascii?Q?nz+FaDdy+8DtDzdKlUTN4xESyge3TolenHRGOr5qiCEBCIDfFM1/JUdmKm55?=
 =?us-ascii?Q?kSi+0ynAX//+koIZ5fY66rOQ7fuZ0VBNDFhztpM01jyCI2Tu0ywOqHycwnhe?=
 =?us-ascii?Q?YDm4XfqVPVGkNov+8D8kJQ5MH+f75k/9+LUYywBlZ02ICgD5LI77BvuQ3cu/?=
 =?us-ascii?Q?FDBQZjfWgxi8IYdM7IdGbaHHohnluSnktFJVOUOYoKRU1BEoFyJlo4+qDSlH?=
 =?us-ascii?Q?6GQ90bh3gAOQQ0CefuYAPQe/tPKaEY+ok1IALUhd7m/FKuZc5SWRdWs4nnQ7?=
 =?us-ascii?Q?3V1HIY4rTrTMD7Bap7Ccn1er4PaPnWjvafGJwjZVslUs8s/RqbNFFpDr9Efp?=
 =?us-ascii?Q?dluQ5xqtvbP5LNB9IuZGYKY4TIsOTDNxYaFJtNe5YdXvXT3R6NTk0fAubpxo?=
 =?us-ascii?Q?xFqwjCZIAH9IKiGzCTunCpUkhlHlOKf9Yktc0QKGf/bqsTtI0Ro9Ua8fVBSf?=
 =?us-ascii?Q?oFwqSEIQIQ9U6pxEUGq7+jBXZaNLD5ithAYwpg0HE/YGLLB2+KZpU8GgVMuC?=
 =?us-ascii?Q?70f5Gg50+sO71ZZqZVr7xWQu17303W23Zebhtha2EGWQ46my3ZxeXOj96FfC?=
 =?us-ascii?Q?gD3BppNk/njWmI1FuIpSSZeGaV+x4Nvl6ZhgHjydEcqo305Ad1VLxkakjs9L?=
 =?us-ascii?Q?uKRtabo01he5sicoOHo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d80c5deb-8283-4ad2-d76e-08dd65694b94
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 15:35:07.2213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GYYyXfXPBuo6DOljnQJ1Pux849jYVWBnheE7NK8/clkNXsJwqupRVTENDBYW8gH6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8472

On Thu, Mar 13, 2025 at 09:17:18PM +0800, Yi Liu wrote:
> after a second thinking, the original code should be better. It means
> we keep the old users as they are. Old users might be using normal domains.
> If we make it use the pasid-compat domain, it might potentially meet some
> performance deduction? I think it's better to avoid it. While, we can add
> a kdoc to mark that user that wants to attach PASID should first attach its
> RID to pasid-compat domain. I think this should be a reasonable ask since
> such users need to add extra code. I've made it in v9. Let me know if you
> think it differently.

That makes sense to me, there is a performance degredation on some HW
here.

The usage of pasid through vfio is going to be really rare, so better
to leave it fully opt in.

Jason
