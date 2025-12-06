Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011037.outbound.protection.outlook.com [52.101.52.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DDF269B1C
	for <iommu@lists.linux.dev>; Sat,  6 Dec 2025 19:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765050150; cv=fail; b=TqxSiTlZkFjtFxAKaTnTysZCI11ZB2oAz/cLtNS3aMOBeD2xg+70h9kP9oAXoz5QjiRh9SeQWg8JvQZz/wSEqDgfU6YMKdejXuZCUl3aYk9ojHEf2qX2zN0Yq/EUlmrbEtJNJHwk5CTXOHaVOjL7sVeWGEluOxA/q8deoOuFAq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765050150; c=relaxed/simple;
	bh=+KGvnRxtqvfX0Gx03Q3gpeIQOWSvah9v9sPrBd8dG6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bOOytxFcD2xr+P2ZjZeKZql2qusfTK6MsDTKnl9VdMeM9fCZQbM6lqwfryR9p9dtzsfn7MI1zOYbsWlchhOsbMIzi5W91lA968U9JPKrQU2LXjXYyGR3dZWYM6cu5TO4vaTiRm2qPYApL8fj2hML3dL85IFIS33h4L3VbU5C8KI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YgmeSvNs; arc=fail smtp.client-ip=52.101.52.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YgmeSvNs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bCjvNnl3iicYeDYnfUPhzRJ3CHtRb4FeHH6j8wEAnhoAJL1CbqI42Hs/zr1qHUGqxa/XisAeFEsuxzmj4Q/LrXBjIh1G6WpcT4wnDHY3MmWIpwjimoAsSeOdhnI9YqhFxV7JxsGs3f3NL/ukXlClGqf48+RTnrUGDe8Z1zFExJG1SG0dnHDznIYDPZeenaeyDD5vQ4NH8zyktr9jBj1k5D2/WfEZQGTgi99bYwnocKp/juYixuT6yiQ5BT7lR0Eh8S2R3XtG9kJMNB6+hOqUCk9lwIaS3tU3kISse0WhRs4k1e5YWFLaeYYDJJvNa6kmyWTIag6QBjjc7qOwYQuggw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H867aHBu0NG6r1w/w8zkD/qNQ9Xzuxb+yBNaCDBDk08=;
 b=jdLxMQwUDD3qUY1zoFXNGsAB2o2TdKpseo1JqcdIDtG3KEMBZ5W6RfYGxPYh7DWYJa+/viU+vDcRjexWSbXZwPDWeQtdnFWFVI32dGL9c7v7fSS0qaGGYc/ulSuhxgwwWwSucAlWQ3RpmSbtF/EDMF3Hc5tTUsfN9vevRl+T28MoroBrESTx+qP6TDTxLaK4cKsW6UoiJf2B3OVffY64XWtlEbtaVarWl8ASh6dPFNEfEf7aSdRomLBTShEdzpw8cNoLM2eB2ZqZad65cI8hHNTeEiGddRHrdCp2kqE1Y25MyZAHQF67B62yNcLK1ZTj959cShZiLZQ83Q7RQMo8AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H867aHBu0NG6r1w/w8zkD/qNQ9Xzuxb+yBNaCDBDk08=;
 b=YgmeSvNsmDqdGJFpyoQ/IFL9Kwvs1ThVWCPXFnoNTbFT61Co1sTpVYe6nt15H6uYn/bQTo2hDK3WgVEc+Clj7UHr9y/nNYAuNNJuvukOA+fy4xqzMO94JX9h6RgrLI+FYuov77eaVDhw5se01Ad4fhB3REhqUEN6xpdde7MJPlV424CUZbk91+18/748V7kKeuHSyiV6ziqai3yIfQlBMv4TqpNd6D8qW3RHndpGjh1+Isy7Sd3/6SpnRDVCAxj4ht1sf5YlbZ/eLUKVfpbXy1cKYcF7hsreacQMLYzRt8NgFTnKS/7f2rJTfgd+BE0Gb9d+FeCuVp3En5ElgmyRyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by CYYPR12MB8732.namprd12.prod.outlook.com (2603:10b6:930:c8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Sat, 6 Dec
 2025 19:42:26 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9388.012; Sat, 6 Dec 2025
 19:42:26 +0000
Date: Sat, 6 Dec 2025 15:42:25 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, skolothumtho@nvidia.com,
	praan@google.com
Subject: Re: [PATCH rc v1 4/4] iommu/arm-smmu-v3-test: Add nested s1bypass
 coverage
Message-ID: <20251206194225.GG1219718@nvidia.com>
References: <cover.1764982046.git.nicolinc@nvidia.com>
 <3c838833d8bbb69a72a85ddbcc325b22ae7a7d6d.1764982046.git.nicolinc@nvidia.com>
 <703ba08f-eec0-44d8-a224-c96706df5fab@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <703ba08f-eec0-44d8-a224-c96706df5fab@linux.alibaba.com>
X-ClientProxiedBy: BL0PR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:207:3c::29) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|CYYPR12MB8732:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fcd5d5b-f846-4063-a7ff-08de34ff9547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oSuCZS+Dc7cVkLTxcxyX2+WdSxKVt7X7wWNLNLRx9ChtKwBy6QzHAvySwgyu?=
 =?us-ascii?Q?8qFKjb3gWud5A0uKzvA0tvEydYQuah0IsRT7klQF/n7INyZtJolzPagKsXpD?=
 =?us-ascii?Q?g2+PO8x+2fldLq4DjctFBoXQLOH4KqBupo3vEbbACbhf3O9oGrZRe9hSK8tN?=
 =?us-ascii?Q?COOFGtgdKwTyjHCyCB69EkpHnfcjZ2HdaMkXdxs5MAA2XToWtssufDyWcQiq?=
 =?us-ascii?Q?CIfHtqvBbbgNMBAWaFMKrsTWE+MeO3B2pAXUJ394RSV0cdDizin8iJpniK/n?=
 =?us-ascii?Q?0+XOvETax85OkFRsP9Yj4HURTyj4Lf7Bl9b8skK0QsxtZvP7CprBBOlCvVqR?=
 =?us-ascii?Q?stpFgnC/TNeSktrUi1XuCSLAnAPq3ZgAhMRVIPhe27+YHLd8j1b6Pmkbm4rM?=
 =?us-ascii?Q?6Wr5AuvStNlxflxc7Cy0aDdq/CVXtEk9S9BVBz6fZGzeyiy0CbluSk23w+CL?=
 =?us-ascii?Q?eSaMB+mW/tMFFyv23ZTEQm2Npz46Y4b30G/UvUQloHcUCel1uyPxfH2ZEZxV?=
 =?us-ascii?Q?TPzVVdovqWhsr/huGo34exEdOKWSA7oiW1mBEuVQIz5Y/K9ULJmY0BHDlMlT?=
 =?us-ascii?Q?6DO05t1UQrjUwClvUBazSqAML5qsKfaRXmE7cxY5rE/yfj9r5hR/KlvsAfg2?=
 =?us-ascii?Q?renmZTc/cyaUEFuD3pOa70Xsr9zoVkhDzwDJaxqchZcr6hy9ICrRNxQhLGCf?=
 =?us-ascii?Q?1+TN7e0TkQz26pxNgytmqkqAJLRqcK3xwJImy2HN/R2uIcP7CoDmY0k+HGvu?=
 =?us-ascii?Q?Pb5nuGTabprzRQBs93KeOhu408nRXdIrVWm4OaRvS1nac5ubP9nq2b7q6aCI?=
 =?us-ascii?Q?Xpg/NNQR9T35XPZNdidbYKstKFNgREHZTesdh7YSoWmsFSNiRHFc+IprQZvd?=
 =?us-ascii?Q?1Pqhg1W1OpZ9SPRH4f1pdQZS8tckIq2u4Fyw9BsOwjXMdb8NNv7rRPm8YRiH?=
 =?us-ascii?Q?U44FXq4BN8d7EfcUhtzYNgfTvqNaIgF9YrHQAZo/9pj/62EDrIMh6HT/KGQu?=
 =?us-ascii?Q?bkrqq/EtJXbeit/O4IUCDEYBmCVDhvqZ2VJ5dT7feTP9JZ3b/tWK4KR+fUyb?=
 =?us-ascii?Q?QNSQnuEAas7/V3cdTk9tFb4l7SWnIhJse2CQtvrtyqFmtdproiB3bKE71xHA?=
 =?us-ascii?Q?H5+Xge+2XhscuB+wVCSSOsPSGhfzlhIwb/zm/uDtbM+2Q8Fo46U1prSWPUqx?=
 =?us-ascii?Q?fBjBIi+6LhS+YHtNScmbrwLTlNFI2RpGa/JoRxsfPkl93zTGhEosge97A8Q0?=
 =?us-ascii?Q?SA1NiOXTeJLblkIMtf5CFP+J0ggStRUO0azNHosfzdAzjbpFLqiiNOTACE21?=
 =?us-ascii?Q?XyNPl/2GWc4gMr8YttntL4iR0KYyYFQ70yHeUeCzDmj5SevO515MyJxqksix?=
 =?us-ascii?Q?WxT9kwhudbwPQE+ZKyrlRAxfH6KOik2NsVnoDjU1E/0MSe6juSMu9mE1MsDo?=
 =?us-ascii?Q?G0ZLVmQ0OoQu5Opfg9FadhF0Z2p9bN9R?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GGV9/YHmE06h1RzkixW2XZKfAbo6Yu4F+erROWTJ6wdA4RrOPGTzsedqhjpK?=
 =?us-ascii?Q?iuGXe3ECawiczWhk2YzWn3bHQT+7zkiXPEDZbqiwkBOCp2M+pl8Ywqhm76Ag?=
 =?us-ascii?Q?OeOjtdtkBMEVJI+66+pv73svGeZ7pxb0lpsC0GIHPKiArhT2cmRV80h2HFpJ?=
 =?us-ascii?Q?8NqlXCcxIEOLwna+2e+ySdPZ8otRFNFnF/kvkSg3WA6MIiWkxk1xzCBeoOFz?=
 =?us-ascii?Q?D9PQY9ZTV62Xm7FZXDXcz5f2aCeSv62TpvM67zC7kb5wwAP/QrSG7njC7MUS?=
 =?us-ascii?Q?9q7/JtNpPdnoNGu51pioF62AmskZQez8SO2HBCKdAs/113OuoQWHg0f2jFxI?=
 =?us-ascii?Q?TcDSz2W5qA4J3Oxm+Ss8mgAXmH/MW7AC3HAqq87k5ZMZjPRdDsdBlScXO+Ho?=
 =?us-ascii?Q?SrhQWamZIfwELhM8AyMgx9XTh6BIb2mwMKY91Erx51/P/xOPpuUvnStUaX/a?=
 =?us-ascii?Q?0DzKP0Yq/7j7Bjcbi7lLiVZ47MxaAFB16GEsom26NsuBB4CGwGqrWmFAyG+M?=
 =?us-ascii?Q?VYTK0O3Lr6ZCbtWvFObbdpB2ZX4YVqiRy0AUI8J7opZarBN6JipnvDnw0sfR?=
 =?us-ascii?Q?HON5qQvqo9ciWIqoRJP3NCzq6ypWQed538rBku9529cfNdllRuBr+/zZSPzq?=
 =?us-ascii?Q?2pHexSDtSxtC1aLW1U16Yj961GcLlRc++zZ+oXqZkmFeK4BzQo/O6f49QtrU?=
 =?us-ascii?Q?yWTovTnA8R9kGc2vqQd+GAW5ewP0AVN7lpLOOhOaf/5VTHdvB5eyAp2Y1LsN?=
 =?us-ascii?Q?yubw5Lwi2Hd3i6MGHFI7AAArg29oL74xEAaP5zRzG1oTqhmFT2KAph26uLxV?=
 =?us-ascii?Q?dGIcCnNO3Un3ARN4Xsz0yyZSXryWZ2NryHxQOZbGK4DxYinKTFmX1H1t+DcY?=
 =?us-ascii?Q?NMUdI6ZnPuIB36WzayjW5SrgoFTiBAU88JjFHq1CS0wp5Gt89+8c5S6SZk0U?=
 =?us-ascii?Q?a1r9W8aB3ms9N6Mu8/HgKQbutncIr9nUgWsF4m1PtrKN06w6MdUpkycvBBSh?=
 =?us-ascii?Q?RHWzo3Z0KsY5SO8p6kgu/TB7wRVOwM+7KTZ4TwSB88Hd+My6jf7cjN9zL0Qv?=
 =?us-ascii?Q?bBimYvIvLZ+Am9JxjMEA3xNvWBRWzcq4t1pNU/pbOFVFjLjjOFnMoplHIV5E?=
 =?us-ascii?Q?WmeVkT8ZOe8AkhMoB8dpn0OzuiT9DEdU60KWjZO7FcOpUr3q6JVkIS8H4Cbk?=
 =?us-ascii?Q?XAKw9CDJ9mkKzgfObo4l1nFIHUu8T/NmMLbQTvu8PyHEEOSt/ADdDHDmGgq3?=
 =?us-ascii?Q?qjmMBf+vnkaenGwgJgSodEfv6oGgHaZXXR92FGzgjfGc6kVGtVS6shyve+86?=
 =?us-ascii?Q?o4+FNPC4+64gGdJnqhpy21g+uI2qfM198wAJKmKYrfuaA9cYyXSrN1KeL8yE?=
 =?us-ascii?Q?fddCAGx7HvB6xORqkYCXP9E28yS7T/M0t2qEpYhAiBKfRibowYKLGahoXhVx?=
 =?us-ascii?Q?vKAl0L6M7WV662ECFJbcTVjpRxtLc/VKOdB0IrApKfpd5/IidKd1vk4f0Il8?=
 =?us-ascii?Q?H1VmgPnnJBPXRtMf+AOsCkgUiMsoCCgFrukhT5dNEa16pFU/4JUC42rrGWpe?=
 =?us-ascii?Q?VU1yLtPIAbyZuOZqmQU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fcd5d5b-f846-4063-a7ff-08de34ff9547
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2025 19:42:26.1374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1aDCmZ1a1HQV+bRgg0TmjZfm8moz7Jp1W/cHuIy03UMNEoerZrB6kY1NwHZcK8gO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8732

On Sat, Dec 06, 2025 at 08:34:09PM +0800, Shuai Xue wrote:
> 
> +	arm_smmu_test_make_s2_ste(&s2_ste, 0);
> +	arm_smmu_v3_test_ste_expect_hitless_transition(test, &s1_ste, &s2_ste,
> +						       NUM_EXPECTED_SYNCS(3));
> 
> With get_ignored(), a nested s1dssbypass STE to a nested s1bypass STE
> will be hitless, a.k.a, NUM_EXPECTED_SYNCS(1).

hitless is tested by the ste_expect_hitless in the function name. The
expected SYNCS have to do with how many updates are required to fix
the STE, 3 is still fine for a hitless update. One to set the unused
bits, one to set the critical qword, one to clear unused bits.

Jason
