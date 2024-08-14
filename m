Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FB41B9B2B
	for <iommu@lists.linux.dev>; Wed, 14 Aug 2024 17:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723656414; cv=fail; b=s9xeXq3qC1yzU8o4FpndqcTMj3W1djEYddzPIm0U8WIGlK9WmJZDQArS4ruWbtmg/oEI94PvMrqnzIHKE+M1YB8NMiS7ugEoPZmvBLlMICW2qyyzlLFtbLVQHzhPd/ji77mbmtsjBIxuIPCIkAWiKtAITeyTSRI6H8OaxomPcwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723656414; c=relaxed/simple;
	bh=v92I7ufYp9OKvtgDchM9V2Abe0/AZMv2rN6qnzT0KjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JVUCUYOAQRGbfgU8z1VC34Pf0XxBKrXBsYySdaahPZ4nDMwdVPZBVDF4VDzx20Dfp9ztP2L+aPw6lIUAvTUeOiLoSalhn++k3jcMDvzmdLBzEi4s1qHB5IvDyUmIZcgbXWokj1xU0yszPsQwDJLeKdNJIcSjn16IVkBffIC7Kvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XeFgbHPG; arc=fail smtp.client-ip=40.107.101.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XeFgbHPG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZx/abAEwHetu5A4Rv7c/Vj1FSxqs2t+t4gRv1K/Uv4C14nNAt4mPEc8BqkbgwpG5ZjJS3hrMadT+dmqWZnZcuFSmNIXZlkJJwUpUopd+d4t/oZmdvgqlwvdyiVnJd4TPI01NztxCHgS56emc/L/LlGt4fjLx63FwdBw7sl9PKy92PWzITZrLIP7A+vfnB6kkY6wYrUGOIwEljmCQ0WaoeDIQwCeHepVHO2VPEd+C2kOyjb/LuO0XKanVWSAB8HGOI6oWFQ2DDKEF9Db9BrOFA2lzu2ZmgO4WsZ9+vMjXXc3BH1khtq2Kn2ZNngAYSovdhNQZQLqomFHP86t+qFYSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/mbEdOxpkdDDeMWn5+IZbVt6290tzqV6Ri6t5ONKhc=;
 b=X+Nbg+HgHC4rI+/YuxKwrgkI3+NwMt2V9ggUiEZ8c9nT+RQNa0y5w2V4NQjbPMBkfHAIPTjRv0itwVKbZVnPBhU0D0JfMfsUILBcXl616TdLgYCSZH8OWurwy2LkONKbgJSmK/TwmFreZo7VAkfCH7EFvb3U49MmaDyYzj276HepkJ/dg2ZAEJLhJlPWqn0DvtQsadnEQeMaIhPqEAND+0rtFijzCt+11CfaoEvzb/94Q2kmqiAq3Hh/fdH2yKlL8HbrBJM3u5dQ9k3acSVZ3qKwrhJTjTms2p4jYuG372VPgeNEHUg+f4MTVoqAkb8mQsiGZUwcMJ/gnSSFp+gSsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/mbEdOxpkdDDeMWn5+IZbVt6290tzqV6Ri6t5ONKhc=;
 b=XeFgbHPG1srKZFsjndPQgv6FZ59J8oDO7XTUOxVDiY2g5KfmU5jQ1a6X0ILUXgxcWxbmDYqpWsrDPSj7gJ7Hz0ld3zEKbWFoWpMgYBqsbY0yeOEGuWq9/rViynSfeHlVWU1e3yH/IEwH73Mvg80JLDkUMGKx8ktlPdf02aORtM7lQ78Ex2Gik9eAZ7zGPP2qlCZqX2ThkZTd0kiNm/C98RU7ZXahwn7Vfe7IV66O9wmVfKkAbWk/W6vtKxFrfcjXIY6bzAmP+oZkknyarPz/k1zC/FZbDY4ejiU8iSWnoDnIVPkF5UUXzVlUbe9G0RVKIoFhumc1hee9cbK0S19I/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7767.namprd12.prod.outlook.com (2603:10b6:8:100::16)
 by CY8PR12MB8313.namprd12.prod.outlook.com (2603:10b6:930:7d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Wed, 14 Aug
 2024 17:26:49 +0000
Received: from DM4PR12MB7767.namprd12.prod.outlook.com
 ([fe80::55c8:54a0:23b5:3e52]) by DM4PR12MB7767.namprd12.prod.outlook.com
 ([fe80::55c8:54a0:23b5:3e52%3]) with mapi id 15.20.7849.021; Wed, 14 Aug 2024
 17:26:49 +0000
Date: Wed, 14 Aug 2024 14:26:47 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v11 3/9] iommu/arm-smmu-v3: Pass in cmdq pointer to
 arm_smmu_cmdq_build_sync_cmd
Message-ID: <20240814172647.GT2032816@nvidia.com>
References: <cover.1722993435.git.nicolinc@nvidia.com>
 <728977eae3b97466c4afe89111ab0543b0eeb59b.1722993435.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <728977eae3b97466c4afe89111ab0543b0eeb59b.1722993435.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL0PR02CA0094.namprd02.prod.outlook.com
 (2603:10b6:208:51::35) To DM4PR12MB7767.namprd12.prod.outlook.com
 (2603:10b6:8:100::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB7767:EE_|CY8PR12MB8313:EE_
X-MS-Office365-Filtering-Correlation-Id: aa426001-868c-4457-aaf5-08dcbc864782
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?boa9RNHoWdWEFJ3TXYwnq5x1VWZdN+dKCupzTirTNMJHRW1Mrk6Sr80bPNId?=
 =?us-ascii?Q?SjV/fH7+d7EBBBmtfTPlv7bsT1GA7QkU8BmYOW4Oacqxw1zbcpwO4h/wmXDG?=
 =?us-ascii?Q?M5OcLLvSVLBQeZg0Y00zKXOJIVuBN7EBNE91IJrLAcx7aIRsa2h7aNmwhVkT?=
 =?us-ascii?Q?1Jp/YxF2CLoS/oYpTNfa8aq1EWdxfFoQAcPgSAhN0nsnhu4VVpJOY24DPyHs?=
 =?us-ascii?Q?J6SQOd1P0l/6h548o4Jr1+/kfrKPIRJANkqjcT5bp1oIVlJKZ1mI8LXXXIdq?=
 =?us-ascii?Q?eyrD7MNP2HUgaG6GJvaLl8ruuQyrH1/8vrlrGcSbUdh047LjbG9b6hk3htqi?=
 =?us-ascii?Q?ifN4v1kSSigMSqZHVa7f3AV4AWWncdR6GhfRd96PfcYkN/8Radj4ED++lkRB?=
 =?us-ascii?Q?+TyRslfwi+Yrzn+wdoFcYrMEUfXeblQFkWbB/GgWop0QpbjzSVL+P85NzrMi?=
 =?us-ascii?Q?8g3VupI+CWoSQ2YBZ9h4txo3g3CS/i1qyy0SxftbU0nuZjaS5e73mywy1ZFs?=
 =?us-ascii?Q?gd1w2guaUt2smkUgPdSEdQLUPOnB5LtlU1ExGBf3pM2ljJM80subm1Z1h3KY?=
 =?us-ascii?Q?mEIEYMwUikT9WK+c4kdf5gNOLmRcYuSB3/y6UwNeyHQFT3YDBL0liwx/gc3o?=
 =?us-ascii?Q?I+odwnS9FJIaeHma04ephXAtL8DnzoeW6Df4r5+5xo+iMkJoJ8Z4rRYhe217?=
 =?us-ascii?Q?/MEZV4XNAiZOt++WWt1kAg8D2ouoyEpFYuoVpyOMy8Lpgbm7ijseC9PrXdLB?=
 =?us-ascii?Q?Vscdb/9+vatjily0OH7eo0KMLqrbDw3BNs+s669SphMFezbNj8YVHbGbwNfF?=
 =?us-ascii?Q?cVqWEDk1LN9CLhqdvX3jGAUayImZ+QWYwnpp2lUiXSAKOoMVRZs8xCcV7jVE?=
 =?us-ascii?Q?T13bvZ3COhdQ2m4zaY4jHJXuZp8GWuVKoqFKIzIYaK8MXKyOlkprghFxhV4N?=
 =?us-ascii?Q?Rcthokw9paSsl0hbqg58jrqchLGfsTagaSxUzy6HawC+lvIAmgmrumTkgYYW?=
 =?us-ascii?Q?jAxrTe4QZDGUOxVfHgmqpCb/jRfFnO80SLDbUlFMkBs7Sa+/7noiZTaazVs8?=
 =?us-ascii?Q?4cfUNsVCwnkVTaR2NLE0YsmGuZXVJsAg66trzwr5rK6Fi62OFmZO+YgDyCQG?=
 =?us-ascii?Q?hH3IEshy7yLUjrIDRBjasc58X21SwM9pkd/OQ+63IqcwEJcFsQ8rmskP66N0?=
 =?us-ascii?Q?Z3q/LHX6VO1K/8m1ot3AkZtYi7LREsn1/0Bam4O9MHdNExHx6nfCgSpHhWrU?=
 =?us-ascii?Q?SmEG28pqM+HVbUpblPZQpJaA9LixZPeyBjAGyJHVaDOThBcLKKWREcBPsCY/?=
 =?us-ascii?Q?Q/40rqNRoMiN5FzWYP5N+Jra3nYAe/BEbbsYz/u6oMOyVg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kCzXxqWQOj/xVkBqHfip3HiChy2S86uKfEA1PNTSVg/10o8GcNm25WYgHZ6F?=
 =?us-ascii?Q?0GITEBMMLWBvXg/dYnvVCe7xHM71hpnb1VN0KgKMJtG0jZdc0kWOK1FMOHuJ?=
 =?us-ascii?Q?1z+2HRsBDHHNLqaX5uNZthAQCNvapsC0Bt5AopcDEafz/75wKbaCBriISl8R?=
 =?us-ascii?Q?qNKtA0IATq9Z4MretaMDUpT0OX7zsNO+jTV8JZ9A+/jzMd8dHtRg6pU2+tkT?=
 =?us-ascii?Q?BG+79FygxGoqa/Aj+Mgjjo59TdJoDsW+sX7Ncn6OLVWFf+0JpALgmItHtiRc?=
 =?us-ascii?Q?B5N8bfn0LP287vO0vBJE97uezSWo//0Y2H8ZhkqP1HmHfnj6d1ee+JtoZ1LD?=
 =?us-ascii?Q?FM83M/Wz77/RTF8FxfU0eW44qFxYFOJSvJxx2TBK/yN0HTWvruyg7q2rDSWD?=
 =?us-ascii?Q?ZU2PQEMSyBs3w79kDnAoctBKykYPN1SrBydWUgWdEiOHMfyDTsD2b5HWAobT?=
 =?us-ascii?Q?9s91aQLTz3sIHdWR4dt2A2YwHmU9+7dQaI+ueJ/8wEWAzT/Gm061x0taaHpd?=
 =?us-ascii?Q?e8x2pZor9bE5qvaEiat000nFlf5NP25SAXpDomrfd5XrIEow7byCp821bMQB?=
 =?us-ascii?Q?0oe/dX0V3aXh2XfaRXEgEu3JRTM2FC3nBLHeL5ixtXM8o86CsHuO7ytppROP?=
 =?us-ascii?Q?44E98mmsVKR5fhhOUhQ170FUeQmVgQD7rcmZ3aqauHEsztVQxGq9c6eVEw7F?=
 =?us-ascii?Q?Z2Qv3EVjeXjNkzoNmq5KVIr4vhm6zKx8vBCm2YlRV3vG2UVVnxQIBxU9dWKl?=
 =?us-ascii?Q?SHnEByLNPHXo4d1cIDac5GGaGYXYVBOugjxVPuBSks2kfUmKFO9sA+1fjSic?=
 =?us-ascii?Q?FsT2KDUj9LIVzziXuePzvXhj1KfTzn1mtDzieSIUfpsuUs+K0aEkEy5+8PwR?=
 =?us-ascii?Q?jFFbeFRw8UnBUTlA79E9VtlWHj5ih3PNOFqPJ48L9IcFNlWrj5tAnjgaaHWC?=
 =?us-ascii?Q?0/SdtatTOfD1BVroIFqXo3PdGj8VWA7yqb8iGfyxdFcSTUE9CHttLR2TnKJu?=
 =?us-ascii?Q?xChkTm9Bxg7JJivVssvOQh/RhjPGC4BbP/xqG9QaHG93c95qqBDft/V2OVT1?=
 =?us-ascii?Q?Aoqw64eXe+q24+ud8xs31ABPAt5Po8oJjUx3oxTu7tyQOKJh32mMGhS47Gn/?=
 =?us-ascii?Q?bT0sMdZ9qe1DkGZ8OW7GptbdEIxBzihU+tXnQvsqTKOrsCWV/hD5GIRFto3F?=
 =?us-ascii?Q?Boh0Mi2Xv4JWmLSce7Aq+ltSZZre5OsZ1Ao1DdOU5/J0kXEnNslieUSmFyjv?=
 =?us-ascii?Q?E73uD0xyhP6CMKoqaaslIIkFYsSLHjtAohcbYcyhtcLpkjDc5RPwcq2l28KN?=
 =?us-ascii?Q?8pJ7NQO+W/PKrflZgTuM0Sd1dw7okhtVys9o7wUp830n4ZZfGpqgiL6JMV+Q?=
 =?us-ascii?Q?CoxkzPgdQcb19P/Z+8GScX8e2AG+x36s+YrNg8n5yrBSAWH0QMrTi1Eoj6el?=
 =?us-ascii?Q?zA/8V96pvxwS+39/MiSX/VE0KTvwlPmaHY7ngUZq4z1mQ4f+QqDL3AzdNxx1?=
 =?us-ascii?Q?r0nFZg1UyZWJUOuXY7virEdFPMCdqtbhpGIiQkOCKruxoQ2heC89Hz+lSxuh?=
 =?us-ascii?Q?fRpPM+CxdKbIKWelKXQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa426001-868c-4457-aaf5-08dcbc864782
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 17:26:49.2088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HKaMMoRBnd2M96cyaiS78d2jMcC2WvKL0BPG/Zz66K290luCbsYiJRJtmkSp0vH7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8313

On Tue, Aug 06, 2024 at 07:11:48PM -0700, Nicolin Chen wrote:
> The CMDQV extension on NVIDIA Tegra241 SoC only supports CS_NONE in the
> CS field of CMD_SYNC, v.s. standard SMMU CMDQ. Pass in the cmdq pointer
> directly, so the function can identify a different cmdq implementation.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
