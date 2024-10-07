Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8968C1DC044
	for <iommu@lists.linux.dev>; Mon,  7 Oct 2024 16:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319432; cv=fail; b=J8+urr5GHvzXVX2fW/G7OA6hgXicwnRmReMrlcaEUrHQdFDamaCkSCJQCL6xeDM8cdoHGsJ2sBEw1y9zyo8CHKVBmSLO8L5kWg2WoPeStL8rKBFzl2YLP+JIHOGRpLgeHfIPkqbApx67wicf7+iTHE1O5cLMLV0V8n0hKPNcOXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319432; c=relaxed/simple;
	bh=zfSHeghg6vBZ+2uqTtikOWMBVnSaWBgI5UgqiI22lT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q7zxev3Njhn4VsjPsfgHX+/+ViR3VJyhArIwaA9LYzdelQ9zl7Q4fkBp4iFBFGr3EbMALnyfIVoZS/Sws2n8zR0D4ekRT2cjD7efko3cdyueF0yORmSnmiY6bjzpN3jxGIax2TwmnTtEV4J7OBvvoBg3qbXdoEiLQ6xdSM8te8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=brv9vnd0; arc=fail smtp.client-ip=40.107.93.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="brv9vnd0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AEohKl8KaMvLNF7LPyd82PGHFQaq6bhdCzd4jgYvZcpykBQVTTWxdu1ZTwqwEuzt76UDBVew6jsafBEIusTVlF/NMbdNBLP2AxbyuyozYgTva1NsBFxp7lK6mHIfkMOxpR5ApvkcfY0vQsaTu5shkhYq+CRyEa/RxHMM2Qxwm6K/3KjJ4NuHUrZfKUhHVyO3tzUOKFBSFF5fnYpo07VrZAljlrMJf+l1SSlW5EEdrbQCQA75QpCzV3yf9geee1jY7y+XrlpRj3gvZp8ObOAMVFF2+Zmse5XraFyqHhgsiEApy+GOdTXbn16dIgcrvrkPMiHwx57+BH2aF7VI3Pcuzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uymMZML/nkt6Zrd+dtFNByZxeYsB5VSd79MdywVmRT0=;
 b=pzvp1dFNg4rf3ZfpTf39KcwHWvW8PvJeh0rR26rFoB5Ve861TJnvQmAjIevTcCE4nnvOKo/nDo1QwefCkbTPtPOEnXBJmKfXjYqGXohrkWwe5yEoR92aU44Z/4egkCAJ1NGmZPwqHQt4hFBNPbrmunxdKYLFYv2wVyGDaDUJztZ74xZUgltjhD8BKJZ1x3Ue2Jt9tOkAN7X5TezfmVu9/KewN4JWfoZ7gbVibsbf6rdxA1zM9EjIaLuBdbWTcTjIV0vjgDKvYnLkfmSvzXaV/949Pc2+R1lJP5Nxit6jpKZNW4BQHFKazdO6njjjS9Z/r+876eTvfKTyhExYBx84IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uymMZML/nkt6Zrd+dtFNByZxeYsB5VSd79MdywVmRT0=;
 b=brv9vnd0BHaMVLWcyK69f0HViFt9Ot8bhjBtEO4WiRlpU/RYyQgeiCq5h+vnEM20dYiyxSzv4aYN07d4nSOUFNDAgI8K6bxuLwuHH7mSwSPnqqKagjQ9di7YCBw2aGyeRjyGvE/SHePNjbkHzJ+yoIaq2KMH799L4utyjDLlc/ShN9gQyimSXd1HbDfleMsNWAuWe5I+FnxRm9SRZnAjeGMegemhmdJp60agb4S7ZzNFF/EN6r1nxXxgcv/dlUAMssoWyzOyOsvQW3IO8zz+Ah2D/CuHR3CoBxwznNvnyiNkbpV5CQynxBhMPD9lniLG804RoCY9krhHUXs5R0RbaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB6386.namprd12.prod.outlook.com (2603:10b6:208:38a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 16:43:46 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 16:43:46 +0000
Date: Mon, 7 Oct 2024 13:43:44 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>, iommu@lists.linux.dev
Subject: Re: [PATCH V2 2/4] iommufd: Lock all objects
Message-ID: <20241007164344.GV1365916@nvidia.com>
References: <1727358828-97791-1-git-send-email-steven.sistare@oracle.com>
 <1727358828-97791-3-git-send-email-steven.sistare@oracle.com>
 <62312948-e733-408a-a42e-7235dcfcb0a6@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62312948-e733-408a-a42e-7235dcfcb0a6@oracle.com>
X-ClientProxiedBy: BN9PR03CA0330.namprd03.prod.outlook.com
 (2603:10b6:408:112::35) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c0ba52e-7477-4a4c-71a1-08dce6ef3628
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aimhYqNrrvrZr6R8lf/cdBZf67uNSU4PPzcAbHWBVDSxkwfkA0JhSF5ZDKF/?=
 =?us-ascii?Q?MLT7PQ64ZkZOMv3RknsBKwPAZy2/hV/ii17x2U7ag5BYV4tedFobrqPUYkF5?=
 =?us-ascii?Q?bo666ZnlZ7ckaPxzAZEHmNaX07gHCqsmro7KFWnMXjx1/2hr3MCqS8UoxrwI?=
 =?us-ascii?Q?pH98ZF91DSy5MiN2dpygFY7G0KWu5ZUihCs5/UZ4gQ4wyYvLmfBe0eGTKMxn?=
 =?us-ascii?Q?PdCGcO4TTQSZfMi+XdoZnmX1bwg9WaEGMQFJNFbj5fvXBZsePAqVUGCDkPd4?=
 =?us-ascii?Q?bX2S4uPImXKU/Wkr9As4DLOAIAKpOiXO0tXI49/oigRGjrN8Ov4NKvN06DLI?=
 =?us-ascii?Q?VIiUqAV/iNEN6vGZoqMViA7xexNy6Utt7baFGXSPTXnXzdIBtt9u5VxeNTtw?=
 =?us-ascii?Q?Y8c80Kcg93hj9rPIi7HUmaxP7uyRXwSVi5lU0rn88I/ZB6LW/WimfpKm+McX?=
 =?us-ascii?Q?JGmiAoE85Bvfc3rk2uB7FCb8qnnF0yzhgF7444LRQd4Qw3vUE+xguxylTetm?=
 =?us-ascii?Q?nuThTC1twM9BoowrUqfYJP0l/H3vAHyOglNmDFmLlGAUCCFpX3Re1DWH/ipU?=
 =?us-ascii?Q?CgVgP2XZ7tRi+su8MdFWeyDUFUyfbRNvTVZjfeVxHwyn/Qs1vakrnJnFIWx9?=
 =?us-ascii?Q?iFUjIK3X1NEfpNsM2kNyWtQ4cKZe6+/8anjAyt7ZxRAtURMT5Jt6QNTsdTzi?=
 =?us-ascii?Q?2L12Jv0wWP1DZidzC+/RmkradxVVVJmq532hBRIjC7CikeBUdfPoZfnr9rAR?=
 =?us-ascii?Q?BRUHlO4hfctwAdtKCy7Wdho+/lcfhVDlOpsLdp2tZFiYW+djs8H/JVYaPHqV?=
 =?us-ascii?Q?K3CWhzJl8qQh/R28xLVl2tjC2nt9rdzOD2L1fUGIUu8lMBLyLQA0T1GtoRfO?=
 =?us-ascii?Q?TEO23amON5KlmEAAqE/nAK8mHKPsiF5hl+R0aqsysfoAZSGYA7LF6JTgNkYB?=
 =?us-ascii?Q?piCH5qSWYmqn8Cxi6MAXd72BxAtlPc913s7SrrjzzDF+phQTkzDRgubJC8D0?=
 =?us-ascii?Q?fOtbGKnfmOCmYZOi7GE+eBsD4MBIhr39mAnOCZuflKqfddABXxs2zf7j5aZq?=
 =?us-ascii?Q?yfKz+r95PO3vlY+ywuPYaShdjOm1QJ6Q76U+8IS3XS7eG3i5pUQAJqxPzuYY?=
 =?us-ascii?Q?gI1uYyP4/I1udEiWcpHOsT1iv1ovahWHSBV5tPi+Z+WjAJtYxLLRzfmr/MVi?=
 =?us-ascii?Q?jhwzYkH5cxE7+PBP+9nCzSie5Fum7A4BSzxgkM+wnRPNtI5lOQ2FeifcjLl1?=
 =?us-ascii?Q?cdczD6YUleMGpD3qGBfrPRw7jeeuQ37mk4vE2exqYQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b1/bUQTRrw/Smhc91nn+HZ4Foi0gaQYsb5Qr213vaGzJY9yYs87oPlQUJiPO?=
 =?us-ascii?Q?fjX7+dYnpZ0rUKvXklsnbVhpqroyQ0+v/J9LxR/tnMc6DJAgODaH2NAokxLZ?=
 =?us-ascii?Q?BDzkWmalT2spYa2b3H3Z8Qyd0bxkWxc5gdGXodUR+Ris3G5MxQxGqEWiZkgt?=
 =?us-ascii?Q?v6j6IlmBAi571JS9fi/BGM5/X4/vCawCPnB32mQGv82/PX8uEcqWEDt+nJ/v?=
 =?us-ascii?Q?3gUGL9SNOXHn/D/+Y8fI6fIPfUZ/DuvYePAR8Qtrt8SlkPHsE5T1aazHnp1w?=
 =?us-ascii?Q?RU87WK9VyV7GY5YawGL5au1zqObuLuoR9vo0EcJzBldE9ODHWOqnnKMOgdge?=
 =?us-ascii?Q?uZ2b1LkVz/Ke9NhfzLNpeIR2ilY7x4a2D435WC7g+ZvRHcQNG786BWN22Cof?=
 =?us-ascii?Q?WQFDGCYNqk5T3XTlBare9JtjNMyPUGD3MXhJNrV2j7tj6ErEBRh7TTk0tgEq?=
 =?us-ascii?Q?xoIfWpKYGGIS0EtSH78brIm1H/PlAIlM7fegnnVKPLNMAVYTGFs/5XKl5vhV?=
 =?us-ascii?Q?M/xe1yFf9uxq2X1+LeoNJbXnmBYW9ZfkaBCqyHejxLqZcLA8dUuEJMY742ec?=
 =?us-ascii?Q?ZkxzrBJuQEAQE7Zh74l1EcxjLujjEUjJeD8HAjqsbld5aRtrAJoEPP3jQnLu?=
 =?us-ascii?Q?phidQTIy75soBgajP1K2xEZdfyKF7CM2vg5YnLybZQgGUOY0YDDxdgzYnoBT?=
 =?us-ascii?Q?5zHFQGfuQy4NjPQVHXrCtjJ427l48G7hRdUujG3rY5ImrMwPCeJLXyfgnOYC?=
 =?us-ascii?Q?spUPnBinNfvgZIYE3pL/9Hm/v7PE1MUmO2HFyuTclhgi3D0WuXTzfxO+oS+r?=
 =?us-ascii?Q?XxrBNuqCn4ADSSU+R6oiOOhzJjTrTXUZCMvhgbA96G5Hj5wTz+5gC3FWfioS?=
 =?us-ascii?Q?MckYXm23Z7YNpCuHI56TmOaWxRvnfV3RPRcXvURPHLPjNMmanjoyNzrW1UX5?=
 =?us-ascii?Q?6JibM+E+ricaxI1o0FU+x2krtU/qeu/30XfRv7xiPQN9EhvZEnV/U4zMJBEt?=
 =?us-ascii?Q?L7bhlzu50AXyRZmi76rAMSEezM+GUoLFQdD6kDznxE/z5DBMuynJKlu51M4l?=
 =?us-ascii?Q?C5FQuHx5goAfPcpkdYhPgE0z/nWe44uLVhCBIZ9edl5JGnMDMTy0OhQvGtUS?=
 =?us-ascii?Q?02n9uxE+0IPJmU6d30p0XBfDqfQPNTZ+PfmS1utO2cjNvGGa1023rVEJB/PU?=
 =?us-ascii?Q?5aU446v+TnxndFZ6Zm8Xws1MDtbmNmD/8kQWRTctDDeh7Ek+gprimlj0muUm?=
 =?us-ascii?Q?wgCJDn2k2cCk4lhJNl9/wPG1wS+4lxXlmNCpVXnrMaOV2/8SEi+V9d8VM+kh?=
 =?us-ascii?Q?KVu6PX7C4BqGfQJrwQGUpw1dbRceBtBDvagQQ0MGNf9x6FGLrgkev6EnlSbn?=
 =?us-ascii?Q?C0TyE+EkYBPbnmZGziD16/8MchlWncq3iypJTShaQxxRr1rEGZJf/wXbQ+Dq?=
 =?us-ascii?Q?irjjPTGNv+IQZXT5O11DexJ2LP65uDAFOOeyqnyNw8oYWhTjtCVIYev0F6TI?=
 =?us-ascii?Q?lYMi3osYMLCtnBdNUhCe1CBKfZiKyVVivC8NYFPsOyurNmicHrNyZrSom7MV?=
 =?us-ascii?Q?nC1GCNVV5hXAl9h92is=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c0ba52e-7477-4a4c-71a1-08dce6ef3628
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 16:43:46.1053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z4klZYHDtrIYEOgewQWdcNZF0XZxTdLxbLX9euGCOeHVYOmQMVT+iaWLSJYL8tho
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6386

On Mon, Oct 07, 2024 at 12:18:37PM -0400, Steven Sistare wrote:
> Hi Jason,
>   Any comment on this patch before I sent V3?
> There will be only a few changes in V3  in iommufd_take_all_iova_rwsem:
>   * delete lockdep_on/off
>   * replace
>       down_write(&ioas->iopt.iova_rwsem);
>     with
>       down_write_nest_lock(&ioas->iopt.iova_rwsem,
>                            &ictx->ioas_creation_lock);

That seems Ok

Jason
