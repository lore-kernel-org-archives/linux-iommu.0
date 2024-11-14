Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A4A3BBEB
	for <iommu@lists.linux.dev>; Thu, 14 Nov 2024 17:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731606661; cv=fail; b=fgcMtnmEF3KYdRh8odRbWWA8idT+Q0CiNWuPUabs4Hs3ZhviSlCQrX10hArJToxNZZG2D6uBj8bLK4nSTyiCbjc2kgu4KzO6x1qonOKAi1icDG7zMhUvVx3D8QAZrBOUexNgl6/gnUEozi+FwcUXfDzJhqcdjLwUBzVG/MF0vko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731606661; c=relaxed/simple;
	bh=cOmxg63SHCSwgiHYia7weHTfuj2FCpgquMiDTvO/26E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hEjHq0gj3dMi1BzQ9zXwySrmrahMMwdu6NvaRz3A1G85K1WcIH0zG8XVIhFGwxNVhAry/lFqkCAC1lLYdKQnI7chaXr272iilKXI9IObe6PCeF9l/ymW/dlSTfqhYNhaEYv6qtHyEipb0eIj+/Qg1Hx3l8i8IeEzQNo9/7KEx1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sfX/KkJo; arc=fail smtp.client-ip=40.107.220.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sfX/KkJo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S5YDnF8cQq8uqVUi0T604NIEspSEX/2O8yYExdglrHuLElBVn8ItHlrU+F/4VIEpKtOXNZ8Pc6Y9pTBqDjsQ/Slc1krRqxYpGNNyUOlkry34pOx8hwOMb24uxvgJhT2q2z25nruQMpjwxufRtJc29UYE0g1sYqZ3uiLGj8ucmQ8vABnZhqnyhjQZJdnOnWSN/lsVTrBIozq1MOpmZwQI1UtA0ORuwCmbnwn780czyguf1OUuIBNwqIDObrGcFYVHOafFbaMcEA36iNZnE8EXOqh4ooNse0kNhJ5DKuj5b3sq3pS3kADRMftkbeGfXNi4d95oeF3qVqcshVCaOfvxmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SmAxYXjXqLtNNA1Pa0PkC1wQ2l6RGwMzlG6TqZ8X/0=;
 b=fnLzMsWqAqUY86bLtKP5Pl6rUGbDnW6i06WAWQITeXfAzXdw/kFdCKTfLMVXY4GrqfNyDDEbCPXXk2YHdU66lc4HsAdeD3OWBCzoWTnE2rzUsCLT3zbIQzq7NCMziEh/58sn1P21/I8NgOVNpz/8jEn5G2AdkSmNSvGgdlDLoUEKC8JbdnbsP1HY38lgONjBr2qOIyrCW2Dg1fSTtEtvpJfC0V+Z5tLJMxVywlsy2Nb1tVXNWKwBLXxu/T27mUyLPUwaKhXz7umioRMaKUZDBbacwnqp3AIN6GrX31Oj89dLALSiVqUIHf5CxhaHvNldXpzKAurSzc8F3y2UZHwxpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SmAxYXjXqLtNNA1Pa0PkC1wQ2l6RGwMzlG6TqZ8X/0=;
 b=sfX/KkJoj7fXOAPgamR0PSA2KarYC5A2RNOcS5ow81cEaknCOOKZNRjtQUzQLy9RKYJFJqwKwu4nbA0HQV9J1OvlUfPx+OdW1nD5ItQwyxG6vP8FVJuAcCCfGmATpdw5qOh/NSr1qQd/i4WtB1itjbZOQ0oR/XbBJIsJu6fDQZwGFp0sctNLZRbbGY6i4O6G+9XRtqLjNxuemMCZBR4jeMp/3QhXLmq1vw1QXX319KgBnzN6Q7TPh1hOXa7Zzm45LJGoBr8J8zg4xK8UiwoPZF9Rm4UMPNnI7+9Wa9kJCqJXFTxQUznWAfVTEaI/n18flsVdyOfdhsBGrJj01ur8nA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB8496.namprd12.prod.outlook.com (2603:10b6:208:446::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Thu, 14 Nov
 2024 17:50:51 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 17:50:51 +0000
Date: Thu, 14 Nov 2024 13:50:50 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH V5 0/4] iommufd live update
Message-ID: <20241114175050.GU35230@nvidia.com>
References: <1731527497-16091-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1731527497-16091-1-git-send-email-steven.sistare@oracle.com>
X-ClientProxiedBy: BN8PR12CA0028.namprd12.prod.outlook.com
 (2603:10b6:408:60::41) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB8496:EE_
X-MS-Office365-Filtering-Correlation-Id: 76053cb1-14d4-482f-e1fd-08dd04d4e148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8Qqof7qRfqLFKh0QeAXK0mGW5niXUdTiNe93B8Qm7lQKR4VR8z3TKpULaT38?=
 =?us-ascii?Q?UNyuIuwUzxpqbX6UmGkSCrjtOFwf8chlxf5iHvaySLGC+sI94Jro3DetPuvy?=
 =?us-ascii?Q?GrZ3D8zhqkibq3ItNbcpquzhFsH+Lo5tEOEH7UnJDDCu7clONfX2aJpeWBPa?=
 =?us-ascii?Q?5tV8J5gS3pjJiY4EG4J7hPPZN8PKBFXwm3FUCPQv+2EieBg6ZTTX8gHKr9MT?=
 =?us-ascii?Q?/Xv82Kgwi0WIshD1IjrD2uxftUE5GMUtshAebYhXJB+qDK8YX0sZSnPZOqos?=
 =?us-ascii?Q?9tJDsuGawcpSzmKciQ7NyAUyp1uZsVe7XDd2E8mpBOdPUcqinZJxChlnTy6Z?=
 =?us-ascii?Q?eKWVD9TxWqbHz3781k1ur+3wePk6XIOUfCS5w7xdSRfrvlE90CNf5zvJ/kVg?=
 =?us-ascii?Q?vh1KwKMF4DKjvNwqSCFmviDCgxa+8AodeDOQM6EtsBAwUqjh/jEoK2ZGytVJ?=
 =?us-ascii?Q?MAOlY8UWoS/vCFbBLCXrNsVVxTNNcNIYag+aj6lbbjnc98ICpXO2mqC5uQwM?=
 =?us-ascii?Q?cS9LLKlqqKqZ5EtGX1LCwo1txfPpcrrXYOhi0hUdfq7Nq15Dej0fqMv2z0cQ?=
 =?us-ascii?Q?DKznjmb4Rq9eWkF+JYUgrj5QQ2q9/rEpU/M8L9oL7akPGK9kjqs4qi+iSlQY?=
 =?us-ascii?Q?PPzACmh1s8kLjwAwVNo2tDQ58h1Ht4DW/4n+LbncouR2L23fBKhlJkkkX2qB?=
 =?us-ascii?Q?lEXXoE4naaVdXVIqZxV+1HH9ZJOHwHtIqOJ1U5a0a27w8l/eWJcS8DMGjSUe?=
 =?us-ascii?Q?p+/closbGfagdsqwy9yN9XHikwgl3s1GMR6LGWRI7SXlupazW+K/KxSOhn1/?=
 =?us-ascii?Q?OsnZm5MR2tGVYVbkdr5Y338aJeclfagMxdgTrlPziIlx7Ack+IoAt/Nz7kex?=
 =?us-ascii?Q?77fwkTVOu02dyoZ2+H+rIBACWNks1mN/X76Nbc348lb8EYgv2pNpkW6IuIXX?=
 =?us-ascii?Q?lhbTL0wFp/xUWFoPnLKsaaqdt0bqx8JNhFXghaL2xwQQfpOT44ZtYCtk/aoG?=
 =?us-ascii?Q?X4dkKza+05oQ7BtQykvu0Kw+894pk/rLA56c/O8XGXkNP9Kqv+fKSvx0p+Dv?=
 =?us-ascii?Q?6oTvJEeuLVq/EXAXA+4py/lsGmaJ9lyk30uQDn6jdFClF6bnddoaBR2mEWLs?=
 =?us-ascii?Q?cJ97xk2z1oY0Rizon3MaIcWeFpudEtNm2egLqia8E5sWzPigg8nXLJIfzGGw?=
 =?us-ascii?Q?r4ysDXy5wcGjjtZZdSMH12I/0/h5XhXBrGmgv14FZd2WQqKJ/IuOpRJ9PgyL?=
 =?us-ascii?Q?1AA8H2+8RXe+V9xkP3za5ECy6m6qJ6Tlb9jR/F/5s5tfk/+Gm1Qo/v/rvm7s?=
 =?us-ascii?Q?EHefGUTAhfP47+QKPkbEFKkb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yBLI+IZQ70DCpzk2+15DXgaHzpQ6g3yX1iA+VSzXmXxiJaIVX3nW+342l/vM?=
 =?us-ascii?Q?nle1/i+6Uae7NF+xkWu42fyeeVPwty+5ijPzaQO3Fag+SMBqMVOnFr6Xzm7M?=
 =?us-ascii?Q?4asuVsd/yW1eWYXoxDt7kk8xcRbaiEkwrb/LjmsdCM8Ok6JBkvZihKsksbLn?=
 =?us-ascii?Q?B/PaQ6ESBe/FkXjwWv6OQoG1+xSkvuVx82dzIdMqgfIxsyjB2LlbHS06UitC?=
 =?us-ascii?Q?/joKLpqFnMjcFj0xjH6DlihwfqL0KAMIRbSB3Z6msVajiTGcK4KGXzuvn4R0?=
 =?us-ascii?Q?U38YoiAlavIrPGyCus4+IPMXgYRPjHLsYsgGntSvVQMo/L/Gi6Ma3/xxkwD4?=
 =?us-ascii?Q?JBCnGUUIQJt6hc+sL0OoRYK41ZSNtyf2o7KLhaT4nBx7/HhDh7lpGq0Sf4Oc?=
 =?us-ascii?Q?dVUyqSaakSZcld7an3kO3xbwUYTVzja0nkK8xblD79QqOtVQWB/XKajOK1QY?=
 =?us-ascii?Q?SmyS/8k7oo7h7cPW6MzklM0Us/hiQALWcpVAxGbEyyWvrFtG+B7FX+MIUMXc?=
 =?us-ascii?Q?xSOVTQugEca2CIyotRAqSJrF/9KHwyVnvO0rM8mqDg8di1+J9cX8RiVy9Tq+?=
 =?us-ascii?Q?XBv5KoqlANABrOg09IbzBi1AwFZDBQEtWCrtS2B1dlI/XlrXM4oX4nV7e1kx?=
 =?us-ascii?Q?XCvOGUkNdO/B/5nA0kH3NF7Mv+v5Bmeg/1NBneut1TSVD8ddgkiKptoKG5Dm?=
 =?us-ascii?Q?3MrclnbQAKvWUe1nEOGTrtOTosVZXQ31Wb8tFzzu3/G/J64NZG3muN2w9xGT?=
 =?us-ascii?Q?cX2uqwz3phcZ3JQJnGDHjXg48Nv3YEv/EyWGm/oxUkhvLSvroUwY8B7DjoSJ?=
 =?us-ascii?Q?Iw5B2aDIaGABaC772acGM9tPQBtcPtYhMhtZiOX5/t+UQ6FSbxvcLLsAFbgv?=
 =?us-ascii?Q?pUt6lIpVq9S1cMrKoP1KygVStnAdlV+UsQ2ZelbMLLHNllEMtzmd2Ax0zWGx?=
 =?us-ascii?Q?voktiwJcn7eOWaiv1cOgPVamiwkiLpunU6yq/kzjcL/rCmn4kuJd89aN35wn?=
 =?us-ascii?Q?3PWjj5cHQBYkn7rSnkhAyfQVI462Ee+lVWAL1AtV1GKm+y9llES9D/qJ8xAP?=
 =?us-ascii?Q?TPk66JHOxKbDrPunrAAgdilFRfPZTx8MUtUzu6ERilQ4Ywpg1uB6GMKYzkpn?=
 =?us-ascii?Q?Jz13R/Ngy7a4rkzmwLlBRsCquE9OdU17AGwFFkEr67NgBqiNYpkv52an7Mox?=
 =?us-ascii?Q?IK/smsNQu0q9GJtafme+hMuf+vLOB8gG5FDgck9PdJOOkTV8N6eGvU9+B1Hv?=
 =?us-ascii?Q?9IYuSDYzNyNLUOXkCAZWUFOVBYIoBhJ54Wpyr1RoqSeaWlwnzm5JLJtop+Hv?=
 =?us-ascii?Q?E2zwMBWMXeZC5btpa5k7RLJ9M3YFdWBrU+roIKKhSRbQidCe8ki95i46S+r/?=
 =?us-ascii?Q?BVO3AOg8CAiCONPEKEsVwXAj7TmFwrglyE3x/ecY0IuezqJu6KkOkq3pZ2KB?=
 =?us-ascii?Q?zxonHXHLCRidxKTbpWCWXVC2Lut3DKJ/qDI8lIvUDF/nSF87THskruYFfgja?=
 =?us-ascii?Q?jH56mmweLvJV0Ltr0gTTscC29AwN9XiAsi1n8IKhrbl5/05IWgPGmsYj3pbB?=
 =?us-ascii?Q?1EMLC5n+ZOMU0u8lLBc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76053cb1-14d4-482f-e1fd-08dd04d4e148
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 17:50:51.7275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NpdDzaq4mdLsooDqgJ8nRL4zCDvm6eUmikIr9JdZfMBlOIZ61d+aNInxeS1o5yIC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8496

On Wed, Nov 13, 2024 at 11:51:33AM -0800, Steve Sistare wrote:

> Steve Sistare (4):
>   iommufd: Export do_update_pinned
>   iommufd: Lock all IOAS objects
>   iommufd: Add IOMMU_IOAS_CHANGE_PROCESS
>   iommufd: IOMMU_IOAS_CHANGE_PROCESS selftest

Applied to iommufd for-next thanks

Jason
