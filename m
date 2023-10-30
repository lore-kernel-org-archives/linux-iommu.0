Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1EDC8D2
	for <iommu@lists.linux.dev>; Mon, 30 Oct 2023 16:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mj45LTYS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOSrslTzIBf2SgaPKQ0s8ClA9GE/oRDO1tNNojSKtyPHyjQ0i2pv6Y975ndUWmfrO18YyxFYGL0ENngUW1PDbbvqpQ/kvkpRxTq5BqFZ7jldVvK73N/BHEpob24zfQGF6zAbNbISElGTUOTEZim7NBoxRdET1Oz1NVJ45It0B+jjq+aIsKxKDHenZ+I/HS/y7PqXrvZzB2mEIExc21WPaJDRygS58iF5SDT+DYE3SmwiRkvsG4eNhzGrtcgOcy94hFf7C3cHa508llcc9cGX7xbMjmApteNC45NcJE+w6s90dZAj4C3rjAoiR9mc3dTmrmuLMS6UZxMRu8eknYs/Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYfej6E5z7mYcpZ1mXkce8fg6tkokz8IIvGkSEWK0cU=;
 b=Cuzwmdw631BA5NXhBdflcIx12MNqClphCifHre0PBXBQwXc+0azxiuLWLXtgxTReRy3JGSxkjQ8jpB2kAhr9clnFfVD1T6c5IhrotqCpIuOloG5zMeX865eLdmvB9OKjafoXPZUr0uSIGwaqlM8/rbfjG81ujSzykH/NCD29/RIuwejeftiPskmYLIkmoynXP910Cv+YAV//kEwPXFTiIEx9CUU+38nB4tNF/87/cSso0ArNNbLe4le0Z0GFTsNT0uumuAF1h2AJEbCR+faarAmV+NCTxFwSgOi/xV+0ooeOOIt7LHMN5dlZCjovdCvhUb1QyMybr5p15bkjApRthA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYfej6E5z7mYcpZ1mXkce8fg6tkokz8IIvGkSEWK0cU=;
 b=mj45LTYSjBI+JFUDzhWJx/DPUo2Ms99JNiANGv9Ayu6NsWpJ3iq+LdlWBpdb4sh99n6+7RkzPc6P4PygALTtTzOXK/2N8EogrKpbqOeB/TGsTm085CV39JO2XYmGfIYsCel2UdLnlyYiJXo5rGyx5DR1i4GDJLAxXZCVcnLrI9RHswT7f9PoW4lYx73RxYtZ+Q0o7RLDFHWP/HEtGUbuZCHgn2lDGuU8sLZJU1zJFuZ2z3s4WIFHRvcgXDAYLQddebRWQIYNolEOmj16R47tWqxboEz0KdTB7+MwWe3yirU8SXt6TaKyHzfIkHcnV3aNX4S27IKZhMAA6VsgpYcECw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB7206.namprd12.prod.outlook.com (2603:10b6:510:226::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27; Mon, 30 Oct
 2023 16:02:18 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Mon, 30 Oct 2023
 16:02:18 +0000
Date: Mon, 30 Oct 2023 13:02:17 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	syzbot+25dc7383c30ecdc83c38@syzkaller.appspotmail.com
Subject: Re: [PATCH] iommufd/selftest: Fix page-size check in
 iommufd_test_dirty()
Message-ID: <20231030160217.GU3952@nvidia.com>
References: <20231030113446.7056-1-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030113446.7056-1-joao.m.martins@oracle.com>
X-ClientProxiedBy: BL1PR13CA0108.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB7206:EE_
X-MS-Office365-Filtering-Correlation-Id: a5f3cf54-d725-40d4-ae57-08dbd96197cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qiBKFUWjmuSDXcvB8Rp/em6wTKA1DQolXK19JcwIMB0il9QRvv2M5tTxeEH9iO/FUur0c/OTDT/Q6EyQjzCkNWgnPbxB6rc3puweUA81IITC89uCZYUkWDayG1y2G7Bq4Q92Vx5AvDsmWMnT9tww3fu+kFDB7RUGhzPeoVIGQARtW6id2VRsL0pqa/pQZhnFlC0Oh7fSFDQxsu7bOqoAt6ivuFAwThyAtufNqaOfGS2iwXztUqtvpW3Bspg9JCTxyeFuLPJrmXS1NzVaHZUuLYY8HNasvxYYDy2co6YuO0/c441AEKv/edxLWQtjoZa4gSxJGAhibCmH15Ln89JuShEPD9m8CJqYii2BwmQRdvtWfpdRaycxLpLtXpa+gw1w9BPGQMbKRz2lnp5bPexFDwrmHgt9EUat0IQ+DnEBwBlP9yC9GH4a8v3aGG47Zd/cu7xqNnVEAd3iYKXnR+PggRyAqtHsSlir0mbTSxhsu+je+etfVCh5YU3xZnM3fm8i6VPJfhuJcBed4gMXPT3XM94+myEy3DAfqLqdnBvW1P2ne9JgpWF/SV3Dzk/9pJt6S/fboZoTDINh510aM8N9ijLuTIiJcDFfvceViRP3CsE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(376002)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(41300700001)(6506007)(6512007)(966005)(6486002)(478600001)(83380400001)(2616005)(26005)(1076003)(2906002)(54906003)(66946007)(66476007)(66556008)(6916009)(316002)(8936002)(8676002)(4326008)(5660300002)(36756003)(86362001)(33656002)(38100700002)(14143004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?msluLZm54ut0q3GaSlnoke7q08CEcZaCwZoWXRA/s8JhEX9z8IJI5XS2HU3v?=
 =?us-ascii?Q?yoJn79hEmGAiZ8c4eeiXwGChCkJqj7aYr8QBSWBc7Qo38AodaM15H2ucPpaM?=
 =?us-ascii?Q?eLlWuio599Ctsyuqm99G2a6mngFdCSFYN/wgQS7ThF1MFQ+dEgi6ySjTNe+R?=
 =?us-ascii?Q?VHa3HPgTMeyn+dvdYH1br1qnRl6Pwky+diqYiOV7qTOOe31P70UHHS+qxvOb?=
 =?us-ascii?Q?bXtuWLkvwe/p9KPLAyAwTcFM96umiku5O0jhxRm1Qh8Wd+gBYHbjAct25lzn?=
 =?us-ascii?Q?zuZdQN7U58vMKkeWu2FymPXDUejxL010fMjgk479rJmlT77XH4uGCqIcWyW5?=
 =?us-ascii?Q?XE2vhkPGadNSpK6Xpskulf9U3igWi/5vBQq3TKNIdocyGommnTclaBdpAo7m?=
 =?us-ascii?Q?hYB8Z84YXmJhZfUWZ8a4JzZIxJD+cJyVa/dcMQ57XioEiPhnLE9ZEHiBqf6M?=
 =?us-ascii?Q?/2m5ZcL7yi5i9xYnzGcfobsY0rdy5IFa8rwPV+6pCJvppEOkkbZPblVB5leX?=
 =?us-ascii?Q?wnb0tC4FVK8Zr+5gmLh/RXF/U5Vk9z7psTGahvo1JdZ30hWSW1hVjRkwOF1X?=
 =?us-ascii?Q?IbYJ+JhqCsW3XFhAN9c1r5ZyzHZj9vchDVJIKRGU/6UK38CkShXqkxY45hi9?=
 =?us-ascii?Q?XWGIwxG4ViLnyTf9kgUQHxKYbPCKDNZBQZIxZD5DShBZB/4BYF4jgMkQ/0rV?=
 =?us-ascii?Q?wBaMHhCwMttRpTfBhY8qBkEvEa0n+wVEfqntP/CvB0LVTc1a6+9spD4kjQ3W?=
 =?us-ascii?Q?8TgPPSKweBIDh3NQzP3vHyT3PsYzGZE8VMvsnO8zFNqmtxIB8BjFUEAm9Szi?=
 =?us-ascii?Q?Ow/J2EKkA2eo6Cp6CfujtJBDougrqbXlx/cRBg+Ey3uqBUYQu/+tcclMQstG?=
 =?us-ascii?Q?MnCB0Ie8iALaHdX1joWDZSGTecVQdchr3XkGJby31Knm5T1p5qbUO0TpsChU?=
 =?us-ascii?Q?U0jfeeAwWmWpTrGFV259Xn5fL6ltV6xGUdeEvXVNp+cga0BoQZVVnrjL2tPt?=
 =?us-ascii?Q?SQjtMuQ/a2cTAfm5bZOlX69zBvI0gg6Ng/jyj27LjOPthkSClBLEKKKMaXgG?=
 =?us-ascii?Q?sO95svWfKweYh98l9q8Dn6MswVt8+wv6SoeMclAeD3BzHiULigIQUoag4b0d?=
 =?us-ascii?Q?81DPj95jTcqZ3qrZsq04Q5YLDU5Ss+8YoEILFVAt2AMyJl8o7lDOKLxGPcuW?=
 =?us-ascii?Q?uKwKJJe1xEvmhSQz474eSCboK9LRkDJa3dFbu4R6o5s2kvkvSZpMEj/zvzT8?=
 =?us-ascii?Q?FB8eLuBNbOhzyPZp8tm047RooIA/IIIFjsHgjq9Eqeh/v6Aii/YBTtm2uraV?=
 =?us-ascii?Q?w6h9A7XX/mkwT025MQNEOS9x6pBBmbxQB0lIOX7PuL5t57jsEJqDW4TbsQvo?=
 =?us-ascii?Q?F261IspFAh3WwOHJMSucvzZtWJNaHJvpA3aYkQsTAm+637fkS4AqaLrI5F6m?=
 =?us-ascii?Q?nTpYydnrnzjDmiXgPXc5mG4SkjuYZuT5xZEvhciWPdvlc1gGhGTH5KUogI2A?=
 =?us-ascii?Q?bXZBHujDQJP8qhAShM8WPcPp9o8+w7xEYaYJHeagWQde8GISUyLn6cmIEybc?=
 =?us-ascii?Q?TsTR0frOVbZagn+y1TU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f3cf54-d725-40d4-ae57-08dbd96197cb
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 16:02:18.6197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y11uxdFBIcw55tTmfMfe/bNVdJtbyyt17TGugaV8UIrKx5pED8nVg56ByjPGTd/o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7206

On Mon, Oct 30, 2023 at 11:34:46AM +0000, Joao Martins wrote:
> iommufd_test_dirty()/IOMMU_TEST_OP_DIRTY sets the dirty bits in the mock
> domain implementation that the userspace side validates against what it
> obtains via the UAPI.
> 
> However in introducing iommufd_test_dirty() it forgot to validate page_size
> being 0 leading to two possible divide-by-zero problems: one at the
> beginning when calculating @max and while calculating the IOVA in the
> XArray PFN tracking list.
> 
> While at it, validate the length to require non-zero value as well, as we
> can't be allocating a 0-sized bitmap.
> 
> Reported-by: syzbot+25dc7383c30ecdc83c38@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-iommu/00000000000005f6aa0608b9220f@google.com/
> Fixes: a9af47e382a4 ("iommufd/selftest: Test IOMMU_HWPT_GET_DIRTY_BITMAP")
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
> This applies against iommufd for-next, but on the other hand it could also be
> squashed in the commit in the Fixes: tag. Both should apply cleanly.
> ---
>  drivers/iommu/iommufd/selftest.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Applied, thanks

Jason
