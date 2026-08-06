Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012051.outbound.protection.outlook.com [52.101.43.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56EB282F21
	for <iommu@lists.linux.dev>; Thu,  6 Aug 2026 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786031952; cv=fail; b=p15Ov6AeSNCZaCh8solXQ6hIWP56/AOH/3BlHSGag7kEsCCqk8ocHJZ6KtQjtaHlvTNZrUwY+nPe4B5/lJAF7J1cNohp0kVZpte8tGS4bX/5tNYsVFQlUMCAo3E3zzJ4X3wWRpbVcB33U2ymXJrGPHV4Cjbh7tuLrMvPi44E4Js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786031952; c=relaxed/simple;
	bh=uVUlHYlqjrDvTypU+Bg+KsrbejA/2E0rZ/8MO1TLAYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wx7AYroMKHAaNOXl21cjf9QzM8nS4vSrOTUcddZJ8O1516EiA3KcFJ+4RQL/LzXaql9pswm7PX5TNIIwTF961wbWkynB1YtycEicXRUrOjDNDL21xLW4G+EJVp56iuRTI6DiZCd9vszCvXtaxmWJETaerI3r56AxTfTxbX12jms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jfJK8JNf; arc=fail smtp.client-ip=52.101.43.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jfJK8JNf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MhBmundALn/SyZA/IKE1nac669VQAsbeaAEyt+7RjelKYkxE8eJ2DKDIEv50u7i21Cn3DrOA/Kd3Alq0P9+9z886jJ83ztaSB0SzBACTs7H5Ro+98BRBO0k5LpgcFVELU5PUHu9i3asxlj75unKy7xJ9FgzlNenINJkUqWZz9Ul9UBvpHcbjkBAEgc1uXw6nTPVVUtRLiv7lcQ3fxm5U85cC2QzbWv09p33MHdqdegaVf8LeVQan709Cw0nHVKQg41z0d0nKZ0ZYOo3dCBzAv11BlPEirj9/2SoPWzlcJ49knoHTFIjsHdh9CscObCM6dijrFRDZaUPRGHInPUphDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVUlHYlqjrDvTypU+Bg+KsrbejA/2E0rZ/8MO1TLAYA=;
 b=n1pqzb6hOGULEDaHWt4OUDGjcE3xpCmOnztSxNYxBh9KOoIuLHQlbyUsH1HBbw3j6TEVLy6fmwRXemXyzX5oQdZhjNJs4Zgd9hJEZUMk6qmsgJV2/U3tYchexanMNMUQYZc4ECzqvr3hPBOeqyzOTLIoxNaBY3AIU67UojHIU3rNJ1+0Tavg3vdYpnFBiTZuJHZsRbswGQjlqC1s7LC2Q6VyT9VD6CMdOPtXJu+C5g7Nqyj+PvRtP1qMclfX5sdQJ/LypgihxhJlDYySJAgqIGdb9QmHe7Ilg2iBQyRdneSQu+unv8yrmTaVUTqLZuNyNgAQtigg90rBAr96k6u4cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVUlHYlqjrDvTypU+Bg+KsrbejA/2E0rZ/8MO1TLAYA=;
 b=jfJK8JNfqis5+3ZVo9pCybGVQ9hE/DXAq8CE8KNcHVJ4rF80XoHM+QPAkc5kUlJasMSqfF5Iu31Skllps3wjXAQ/xw9YfWTqZIcMJ1DzL7UNwZfNegDVIIwsB5ygVeYTcGbBf1BqruZeTRGCcFr2drHXxcA7c4v+X9WsbOuA5NbKpxt/NduOQWslxJnVwtBNiE9YO1WHjTFO8CPPSLctN5APRdWoG1drtiMBQgLwBVVnmtgDWWvVVxD4R1j4sH4sdhzUrtgJ+cw3q7IsyhQV2E2zjBYPCwAs/Kiwy0RbV2LUA6RfeqT0SQ9uLG4fAMTykXFjEqGB8+q9bh9Z6TIyxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB9176.namprd12.prod.outlook.com (2603:10b6:510:2e9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Thu, 6 Aug
 2026 15:58:57 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 15:58:57 +0000
Date: Thu, 6 Aug 2026 12:58:55 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Will Deacon <will@kernel.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Kiryl Shutsemau <kas@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Pranjal Shrivastava <praan@google.com>,
	Breno Leitao <leitao@debian.org>, Kyle McMartin <jkkm@meta.com>,
	Usama Arif <usama.arif@linux.dev>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iommu/arm-smmu-v3: Shrink command/event/PRI queues in
 kdump kernel
Message-ID: <20260806155855.GB71449@nvidia.com>
References: <amiBagGKn-Aym1DK@willie-the-truck>
 <amiz6GQZ-XGlH706@thinkstation>
 <anHxBh-xGW9JXsa4@willie-the-truck>
 <20260804141704.GB27883@nvidia.com>
 <anINkO1l9Kz8lTVh@nvidia.com>
 <20260804161918.GG27883@nvidia.com>
 <anIXDd839UC/M2n/@nvidia.com>
 <20260804165905.GH27883@nvidia.com>
 <anIjwUVvfWOb9xa4@Asurada-Nvidia>
 <anSFbIHnigVt_3bJ@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anSFbIHnigVt_3bJ@willie-the-truck>
X-ClientProxiedBy: BN9PR03CA0477.namprd03.prod.outlook.com
 (2603:10b6:408:139::32) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB9176:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c9d1310-ffbb-483b-e93b-08def3d39f3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|11063799006|56012099006|10067099003|6133799003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	DNRAiXDuYmKauhFZD7Wm+IBNDvixuRrzUaEXip4yeLO2IoD9R0dIdVYDbRSKwBjMPqpolw0ySfJrg0OUkLdrEV8ZugYHa3MY97bMZZymdux786GkYCOYDhGkChb2eB7fhjzGaWhMFom78ED7ShDTMKniQktmPR0z74VHDllNJ8koNFdb9BF4wpGlbl3fJGd9UzLoANUrxFhFkYY1i7mx35+THUlY3fe1ZzEptntkthfPOKYbRrfCkPgx3s9HTgUmZrPk9JLPJUNpcNX/SBbaEjQ0JNOQ+r/Lxio3V2UhVERkmIWXGxhZMwq9w37Om4UyNW5fmbHW1fmGULdNqvqsf0/ktdVNk69IpaRCT+DSHhNvXH1Qwhac776w3Y7F2B6xCbkxKXZ0YZx4/6NW7l28xuoU4JGy2iU3KAsjQ13vYW9rme/H9Ur9BL/ZvITOUc1U2gQ5On4FHmYW+oioQdNlLHAiJo5g0d4tfkEMtgBokR2L5etPHKvuGWKy+JQSdEt1Q/PiOfTIbafaglm2kV8uGmeu8nZrIhXOQ8v0Bdv2W/ZDreW6L0hdWmKHUWFFT4X/wEj2M+NeFiKrCQQj+XPce9k+7v8szHLaX2jsJBu8FsTkxZeuLgEyiEzG92lRzRJ+gdi/UiDvUM2Xu2WgKwAcNZvCO7OokaSOht/PXf6GwEs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xB3RL8JgOgDOTHn7xHRPY1bbNyFw15WRxbkwUifzLlMU541vmbQiX5F882df?=
 =?us-ascii?Q?kwCzt+qkZM8dr4NL78aN49L+fqQYLONl8J19Qfoxg18GgW36J/8vwelpXH/P?=
 =?us-ascii?Q?Oe5pPmjcvZt+dpxU5FEJKaEL1ZWkeatzx49Q0uUJZMuLwHT85+0r6j3ETJwR?=
 =?us-ascii?Q?xYkCRyMbop+t/HPMEMudOweeiRif4NeryaeLOadYwM/hRP6iEi5Yfzg0UGQG?=
 =?us-ascii?Q?bMrNdvLjzLtb6E8M1aNROirjeJgYFCY1/aSBDp1pJ6DDzhjq0alYudH/4ty2?=
 =?us-ascii?Q?7X8fMdo7KXOySGdPCtr8hFujLmWUoxi/O5Bbft6FXEjYkLKlVH8Ud8sOYp0d?=
 =?us-ascii?Q?rZyjcDsOxhuPg+NOC6mv6Zqsdbrobd5yEkahjPOMOziZaQncO7iEaKvYZ5Rv?=
 =?us-ascii?Q?Dj7u/qFP2j3RJyqPB+VemwRt125uwcqmmvADwKatIfNTmFMIiA85DIgJlHhh?=
 =?us-ascii?Q?se+197naiO2wtkvBK+aSsW4FmQ2GTEvldTjRQXKsfvBEhPc7Y5XbrF1XQasB?=
 =?us-ascii?Q?LGjlAFQhA4Ob/H5aQ+VldmCIv/h8AwF824p0/O+u8U/0Z2CNnULBUft58yrq?=
 =?us-ascii?Q?n/s1tvMe6GLU665KR7rVXUes+9ZA972aly/T15CnL6e4bKWIolLL51BnvGcl?=
 =?us-ascii?Q?CdUBGw9Msn7/LRGT8TIzEGGePWSNMeWqt0hUth7c92opKasnkoDMW3z0J85K?=
 =?us-ascii?Q?mDjNJrnMsZElEkz6FD+52vauVVlB21UV5BwZ9xsXIcVpVwZ/Q8WY38ikbOxa?=
 =?us-ascii?Q?URsZrZVNlHHrddltY8fNhEhFnF6Yzl62InLiZnEr8aUKbjv9fNwyjMX2y5Yj?=
 =?us-ascii?Q?kcbLuA1th36OjELOjDi9obsa6z3fTZjqG+68j7cP1phWjfsXh2h947TUPtG1?=
 =?us-ascii?Q?y4COst5+6q24KsIaxxdpg/6E3FOwFrQRhNPY406E4eSdUWq8nNue0CUk68mY?=
 =?us-ascii?Q?RB5ryZoTnLPYNBwKu19zTQEwiQTR2J65Mq/m8EliT/WVg+9uPna+GFvlLHIA?=
 =?us-ascii?Q?QHPr92+2Mbpbst438OzHJmjDoQjBxN/wngl+xZAIMjLCudWhIscdjoTck+1u?=
 =?us-ascii?Q?tZUOR6weoqQtBZRnFwuqGG3XGoBq8HzcOO85Hxp+8DKKDZ7qbRl58QTEoHJm?=
 =?us-ascii?Q?9WlbaTvDLM+1QGB3YLWcsgq2+9kZ4I7fFVI5BmjKQG7S4woCSG9xqwPgggdD?=
 =?us-ascii?Q?DeDuyzzS8/dY+WdaoqZKjBDGb3ST5Xpt+ShLL888dZm/+mtOuFpmyvGh7UsF?=
 =?us-ascii?Q?GHULlLILw0acMXHsNcnwf13+S9TJUdgWGuBcYJFmh25UbKpaSR4GW9k3+mOc?=
 =?us-ascii?Q?R4QSEfQRog7eyh08LCplLYW0r6NkE0fMMpBNA4h1qaOywcgsoREjeA0Fp2q2?=
 =?us-ascii?Q?hUen8yXdqgpywASevaq1Zfjva60JE3vJd9YLaCSVMOfkqGa0U0/nidETzq6B?=
 =?us-ascii?Q?CWnTOVggteFFjNFWsWzf4FOtQvnHLETVAT42zG+LvhtYTL3rVqj3MxqbXiEu?=
 =?us-ascii?Q?p+or2x0LjjnNDAHty+BjdPnYpR6zDQYOs1AOKyY8SXarGvOHj58n+xc6Yp7r?=
 =?us-ascii?Q?NmS6HmlvvWetq/hE+moRQKxU5u6FlE7hcdPK9NCJEdg078DqSKg/PL4VGWIU?=
 =?us-ascii?Q?UqwbOzLfxTLeTtFu3mUJ1Yz1aXgN69NbBv1O4eadMCoLbDCKyXgClimvhsLq?=
 =?us-ascii?Q?Auu40sxptJ2p9+p6zJVP5e9Mm96Q1V22WOXT9bj4RgFUvcSicEHBlGZbnM5/?=
 =?us-ascii?Q?C98AcZnQgQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c9d1310-ffbb-483b-e93b-08def3d39f3b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 15:58:57.0800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dXkcvwNRz5aZNAUwD1V7VbQW26yNiqFXdf0705uRzru4PZ4B2SWF8C1KrfY+BuLh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9176

On Thu, Aug 06, 2026 at 02:00:28PM +0100, Will Deacon wrote:

> I probably wouldn't make a size of 0 disable the queue, either. Have a
> minimum size of a page or something like that.

If there is an argument someone is pressed for memory on cmdq they
probably also want to disable the fault queue (and fault support
entirely) and shrink the event queue too.

The kdump case was an obvious one, but I imagine an embedded system
may want similar tuning.

The non-disable-able ones should min to page size..

Jason
