Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011004.outbound.protection.outlook.com [52.101.62.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7970039D3EB
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 13:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780319480; cv=fail; b=U2Xk7h7/urZ/CNm21Q3szg+5uiPJlVEF6wVYCzA7g/1yLta572rhwb9HnLsFzZfZZ3peopMZKOsbl436em2eYxyeMfdLjAZrm86lUN7fO6MMJLYteQxAzyRJPvpjQqGOk1Fbz0je8QJSVLU3N0/lRKE+xvO7SvqPJojeuc7/LGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780319480; c=relaxed/simple;
	bh=LTPaCYfbKGMIKABARpS5RRo4gvEwuKJ+iPZJ3qcViug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CGVRDYIvskrxxHdTBWrjlUFg2vj1MxSTtQhBCCMbE4gBbRsaYslzk45vSpfilXQnAKDKlvkTWLaiKEvmD0OVc+89JEiTYXmvMUEZmKloU0z5mMqa43MAjCDmZPpPQN/ToR2CsEVAVdXfIrTz6We3hPpuGxKuXLaxHByQL7F/31k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bam1NRfs; arc=fail smtp.client-ip=52.101.62.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bam1NRfs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODTC0Cg/MlXLYqunSmPfa1AwBr+Ne3n07WXgLw3lwUidVAYlNmBVImeRy08jlSrPG1pYH7YskqjPSwKeprLEGKOVBH1ggzLkl4zn+9zrv+Flqu2igDH0xk81MaVYlJmfsTYvN5eRpqatmt71t3Dlbah94JRNpf7koEMapt99Pgn1SN7joYdC03BTnKafDAHWxl9eBHC410tBH2q9wAuzvixQrObPWN5hDY1RfZikRK7so20Tmjam5oNwh/zGOG17FLRlmb7XFrT7yUQhz8peNRQFoupZ1vsjrHfl3nV4KdpEmzbSn0SqbDMQXVoNKgx9pRfuKSY+pmS2LDWhiBD/JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8ptlDj2fczuGejvha0xXEGQz6zaKAa4o1Vajpb1ORc=;
 b=KX0cz6vmJvwxD5UyuDxFFWrksVmhOZs37Z0dgYvtPw7HMKceko4BE8F20wYkFVBVRMpLOT/8ZIBgxbCXk2kRNlG+ErFPueow3J7zwCBmGoky9Ne4nqVt1XBidRQeag8t7/6fHHhBrviQXpDTZMztFRT/3kAmWHbM6/DkNylVVFF3tGPWtmRvaBJNqUL8fs6qENCLHQQqz33OXEZHulRHA53gk40Jy7Y9IyvAzqsErBEf3zCbmwBebDXMsqoU92ctlEwscxUxf0t0ElrqgAAgxmdHvYyLssG2+HIqx7FfGSPZhRRBgUrHYM45VmhQxR0J9FF6R3ETajI+33Hc8u207Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8ptlDj2fczuGejvha0xXEGQz6zaKAa4o1Vajpb1ORc=;
 b=bam1NRfsa7LUcLavLd0TEqV2jDBUQo6NkyXZNdsTKO6SnGINa91tLb0lXKvA2TpkLCgM+QgDlYX69hmzgrF985f3pz4mh1Tmit1GtjJpg9wqdfdRfFsK73x+OaFgg04NzAd4TNY0U7USBZCmTSQb01X3gwdp3Rm16jgt1fIFxo2VpLCAlCXWmRqbRiiXI6+/SRT53LI3ZAmdk2Ri5y1RBsJmDOpeSsMrbbZCsmRqLMefrrDvo7+bipxNkH2al38XY74EKsObhDGGCuqTWf4AEdAKUbv7wQSGkHANfLRI2dRArAlgjImYmP70VlJ6WkwXkyjvOKcLctBI/T+TIJ9GFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB5723.namprd12.prod.outlook.com (2603:10b6:8:5e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.16; Mon, 1 Jun 2026 13:11:13 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 13:11:13 +0000
Date: Mon, 1 Jun 2026 10:11:12 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
	sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
	wnliu@google.com, dantuluris@google.com, chriscli@google.com,
	kpsingh@google.com
Subject: Re: [PATCH v2 12/26] iommu/amd: Add per-VM private IPA alloc/map
 helpers
Message-ID: <20260601131112.GN3195266@nvidia.com>
References: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
 <20260528051738.596013-13-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528051738.596013-13-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BL0PR01CA0016.prod.exchangelabs.com (2603:10b6:208:71::29)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB5723:EE_
X-MS-Office365-Filtering-Correlation-Id: 12a548bf-5a16-4f0e-b13c-08debfdf418a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	BOED9evitUv8+cdHesKc3CHWCsOKq3fqdoRG/5OVMlzDUHiBLVuG/zAYI7rYHBZysqVn9YjXjSpuIA0cp4WDRprCrdCWJsFoqIwv79je6hHdiJQLEKYkvoueFGwiHig8XkFJHVQIf7iGoQVFB9oFxPjcF3D53KbzmmX/1tIiD5EIT3CqKWAaWbGbOXqbCfOYUYdRaPCRuIhxtV8AfUSerN0lHu6eceNCBK6ygd1+qokEJins6D4Ue+tfaDdzy6QobSCJo21jdwVtMiFH0zaw/tfgqeQG31vg8zEvEk3aPGnlmHAETN1oLKKOcJi8qXPxoV03oVipyAF5uSC2WQ6DbqIk4ZU1RXXYtM9gyG0OfX+yuRgG1ogBRSP5ICNAdvJhBXFf/it+TIZA2+F32hc8QFvAlGJQtPhFfWo+o6cNVpBvMYp5PgrwqmdrnUEoF8xXnIkz3N6eFwMXyGJoDPL8hlBOdK4HgFoQ1yCeMfNkqbA+LDQu9QshMZrLbBql9zvK86sxxmAB53wanasc1PsyjSbOvqfdfv5LNFjJqhVufrJIIDOPhsJE6tDpgdHjDTDc3Ixg64Ael47XaFpb2/4G0bxmVhxOdNwszF3ngYEYjsxQvbwCgLM2FgSoxKmts5e6wnHXIX0W7dKq2JzKcDiCz6JgrwtGNZceR4arqegRSuccDJ5f4HYH18rW7ykJNWii
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tKvmT9qPkcz60Drv+Keru06IRMlsW1Zna9cD+febnqTml4rmhjlB7dAEqIv3?=
 =?us-ascii?Q?lljRONTml4OIT0FusAL8vdWwcJISEQDLmSrT3WzsEnVoUHllLH5Hg6lcJsYi?=
 =?us-ascii?Q?AT23s8PAVGN37rh2U4vbCRLzEUxPi2wtgFLMdcH1VOqe06/iQHzVWhFkrLfc?=
 =?us-ascii?Q?qJMBcR4stvrOTvgPp5ElCjXJlaHti+0WtWMDuDmlYAZM+T56KkTcB4qSKONv?=
 =?us-ascii?Q?yUIGKM1iJuWT9jq4n+5/DpzWjo5MznqrpT8RUvyrgJwc1DkYjEbY3YfsaC3I?=
 =?us-ascii?Q?JWyEdlL0+zCjcUrSBOdK8xF5t7M0GuqPOf3DVw4RJ7wM/Dy1P34r572vGmJ/?=
 =?us-ascii?Q?oqO0zXjzDdoFm+6bqpN4UrqsfQOXTk0jXaLCyt72TuETbC7uFLc6N+MTaWz/?=
 =?us-ascii?Q?pT/k/gRnsN7/ENBmiVxtbhAGq3JB8xiGqfgNJM5qaFOGcMnUp5CHjl7XG7oJ?=
 =?us-ascii?Q?Qhnqmy9W9RTudsGtTrZLhXn8ZQJ5YWvzKf9tmwD1pWO7n+e4ewlFKDEIts2E?=
 =?us-ascii?Q?7J7OM5X/RHQJeyyVJsD+0q8RRfe2VU3XBDyjncGG2nu0f5ys/fG8ZOcBwcjs?=
 =?us-ascii?Q?G3aPN2Dz5osnYLPt1IKoDq+/DadlhpOzDVlOGSvtQ3lIxQ452OR889neLwCt?=
 =?us-ascii?Q?ugDEUPQzvDcT3HnoiBw7lwLNIBRR1qyTAvq6ZW6f4RGPEopf1UJP0NGbBKwn?=
 =?us-ascii?Q?9bJDYK8f6phKg/SUUslssa5bxFFfHhD3bAn7znmmzPfvDBH03MMk3TBIYC4j?=
 =?us-ascii?Q?akeWrPxxQNAcIsMTfhWF6o2a04s5p2z+gei5NmSoW+xnwF3q7aU49EpD9BbB?=
 =?us-ascii?Q?SwdwOHBabo6R15XZ/UrLHm/ZEC5Dg/Oo9YKydvQ2slHHwMq3CInzuQrxbPXN?=
 =?us-ascii?Q?GSWQo13gRo94Wnae56kWfQwFNhAa3cYfpcKZJneTmV6woVPT/9dL+NRMLF4h?=
 =?us-ascii?Q?19uHa9QmDeQBOCpvwkTitZVaGPzBPI3hz8Y5E5/vrRjXVBgU2zcqlv/dSbUc?=
 =?us-ascii?Q?jLTlV5QOsACmPjjnpNRdqgTMxUvPtArSqygZZs3kNl628dy4nQK6v8lESOPS?=
 =?us-ascii?Q?dKai4atWAN31dXSCRjf1sYoFwOOu5H0L28UXryPSj4S7GfOTWRenYFAPPkZA?=
 =?us-ascii?Q?f1YSNX7TQGTGIv2PI+IUbySzk4TAxftkiDNKXCfvDB9ng5PvwMcXI4/n7MAC?=
 =?us-ascii?Q?5xBn2gQxMRWBfrsXB3w0P9h+vV313szhY6GNQlJMbr3Zaig21r+Eylyrz2T+?=
 =?us-ascii?Q?eRuti+rgkmTTGjGMuGNIMzivdbfyBg6yj7neN6M8KWypCI6R+hxR8tJS1mX+?=
 =?us-ascii?Q?foOhbciegCLWMn+l3svSxQ/aDoH52yW0zGvCpz361xAr/lOly6Rz3Pf4NHl+?=
 =?us-ascii?Q?eqb9x4d9B/p7ySWUZ4N1CytPvT58mUuqo4UsLxYaBziJAoRjnyQVC1B09/jA?=
 =?us-ascii?Q?O5Nggp6d/JAgdqDmA9wpnLdfqWpEfqOiCFWNXY3DE5TicgqAg5ju0CxG1zZ+?=
 =?us-ascii?Q?5KB++HixxihsTsBYMQSMuIpIntvenZq1AT/kTUqyMWInTT+5M3MhSjkgaUkz?=
 =?us-ascii?Q?5kn9PE93ie3j1fIKf9N4jZEQPlbsaZ1RHh7m1gNZBArkaLxkkNinnzFFLsBe?=
 =?us-ascii?Q?9z0GocP23Qj+NKrW+d9XvI4cQGjvYMGH4u2Dqxn3I4BGi+P0QMxoyLLqDz3d?=
 =?us-ascii?Q?QB/Ox5gnCCEBjwoGQ7HY7d2bR+eUgPnviFi7ag1WUbAs9PNi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a548bf-5a16-4f0e-b13c-08debfdf418a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 13:11:13.2727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FcsJl3ONRg8NC6O8Jr/PsKacpMMSqksO3q7yzfQhz9f9YUk78mvTCS5HP67rwZTy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5723

On Thu, May 28, 2026 at 05:17:24AM +0000, Suravee Suthikulpanit wrote:
> Export amd_iommu_iotlb_sync() and use it for nested domain
> iotlb_sync so nested attach paths can flush gathered IOTLB state.

[ ..]

> --- a/drivers/iommu/amd/nested.c
> +++ b/drivers/iommu/amd/nested.c
> @@ -291,4 +291,5 @@ static void nested_domain_free(struct iommu_domain *dom)
>  static const struct iommu_domain_ops nested_domain_ops = {
>  	.attach_dev = nested_attach_device,
>  	.free = nested_domain_free,
> +	.iotlb_sync = amd_iommu_iotlb_sync,
>  };


I don't get it, what is all of this for?

iotlb_sync should never be called on an IOMMU_DOMAIN_NESTED.

"nested attach paths" should never have gathered IOTLB state.

Jason
