Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5408618784A
	for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 17:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724089188; cv=fail; b=RYlDkC/MLOgpPxuGKOy1ZegYxGDzHwDUETeHtuhoMz8yy25i1dtnb1Cu4OZp0lg0Tu9E3y4tJt+mrXWF2PDsDLdSYg4mtoZjcmvrM6+9KJTaxd3nZTdwrPjPNG832QP6lfY0UFYAEM63GvjPcJbc9vAmCwu9bP9PsqFQOTG84XQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724089188; c=relaxed/simple;
	bh=ZeoDQ+Ydp0O93nAPEkeP4dFwGm+2Wtko6xMJB/yjJGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o7xUx4GhdtCJKDVA0Sy9Ybi5LWyzwFlmA63JIy6jfPcXkHZJ6/hxXnw+eakkvIJErHiJp3IJ7w+36Ry4xkNVrnm+ZzzRkCJmE5eg7Ga6fsfCiQxDd7L+X8G6gQVlHYWcsr2riUzVcY0J4tP+YHznju1ntnMDrp6PqGzEW12CWgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XV9VHUA9; arc=fail smtp.client-ip=40.107.236.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XV9VHUA9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLrX8Tq3JY1b7sSkGK3tzfo23/4frMo7q7l+HNDSujfN9g7G3iKPMyyUC4zQ0NH4DvsYrt0GN1+Lelc2kw4CRUU6wI5lyoqIw1lMMZKDMeanGh+hDs7azRkzo43qYyxNm53QqlzAUoY0FxH/SjztI2kKtSWK89pL6j3m5jImeM9qSm1I9bvY2m8hpaV3DVXwBh7TdhNPmmomDdIFvo1wMEGFp8QITeXlg539OWzmsltr7CzzzBekEqTQ30jqvHdghVJHDhRDA6UpLfYwXJL/KYzbVux9TjcXbx4E/xobEUeCdUw7hsFNPI5QFtTAcEgTt0uNP/CtUIF/iLUouGH1fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysnNHXQNUGgBZgF54xwvvEKOM9zheGHH+AlxEosYIiY=;
 b=ZbuwqARPjmdg3r/K5wRxz4tZKpHlpbt7ueWNdE/rdVwqd8kMiGrz5Grh93Aah8juWVSP6Qg8dVqPIjaObUsAgix1AIQ0OVNehBo+ZpmHMGlYkpRj0n8NUZn6C20vN0OCvcHDfDmL/KGbaidpag5lnEofaD1XS4jTJ6aZay6923SPBF0iiRlf+MJ3FWBZIl5ctSiwuxsPcBfA/2/2+JpHd2zw/zuDh6s2mvoLoakRpn4Jt+Sx/7p8YTzmLtIvfUZfall3gCNpg2cNZGDgwgYxQU65VALduDqdJ724g9QZH+v0KQazEq4atfAd5mSw4R66VGaVosxflGdYox31r5azIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysnNHXQNUGgBZgF54xwvvEKOM9zheGHH+AlxEosYIiY=;
 b=XV9VHUA9Ab74mAjErtjXad8zAL43R2aJjEbKuxbpn/8yTBB5AX0XSEUzns6Z4NTh3SKMlhc8p8elfos2RV4wePx5s0Gms0oZfiDHteFrBxkjeI4Q0ZBwGuqEfjIxI4mmBOYGkhLrsklO3SAL4A0UFyNdZxvlQ5T0uGBNR65FOXmyLJBMEG3L6ZLwEtJQ5tEXSfqZbXv31/v+2jnIRWJ1uUc2TpD45JkmGbLMQnSrKrjvkErg4FtxyRCrf4KTYcPqOyMjuiA18QKDPBYovZL+/CRCmPFUiSokUhybmo4tBwsmp8DBQ+/4FdIcHGung3+PjRgzjymRMzw/qD1RyoLrFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 17:39:42 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 17:39:42 +0000
Date: Mon, 19 Aug 2024 14:39:41 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v11 9/9] iommu/tegra241-cmdqv: Limit CMDs for guest owned
 VINTF
Message-ID: <20240819173941.GO2032816@nvidia.com>
References: <cover.1722993435.git.nicolinc@nvidia.com>
 <153fb887cf4bf6318c6f313a4be9b40a25a24e7d.1722993435.git.nicolinc@nvidia.com>
 <20240816132103.GA24411@willie-the-truck>
 <Zr+Nmq6LyrBTY6eR@Asurada-Nvidia>
 <Zr+XQfzje2YWIOEo@Asurada-Nvidia>
 <Zr+rme98gB5uqTRX@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr+rme98gB5uqTRX@Asurada-Nvidia>
X-ClientProxiedBy: BN9PR03CA0915.namprd03.prod.outlook.com
 (2603:10b6:408:107::20) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|SA1PR12MB8144:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c020f9a-fef0-4495-0643-08dcc075e861
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wES3GPokWEGcgZzcJyh3gSglTyu7iK6GT04kCmNApuJdcjnl2/p3j9Zyhpx6?=
 =?us-ascii?Q?wKJUqmRwv/AdOto4QP8ERoHGmPzydjwo0BdLPC3XV21q9WAZjy5oHVfDZkfF?=
 =?us-ascii?Q?qe4WmiEyTXh8Ft7caIsKF+CM6aKYkjXnUbdiRie2/szOuQMGcOAXxUSIVbIm?=
 =?us-ascii?Q?+czkgpZmWB02LoRhwYsGlJy8o2mFIYytf/zNHWDVrNeSq+qmnTXn02tELRcZ?=
 =?us-ascii?Q?0k9FH1c8ztP7+iWmgKJ83HAJvLOmHow3kHIeDsUvczCjTn/nuIPXyPe5yKfU?=
 =?us-ascii?Q?ZnETxh5WgyprlNWWrmO3Ssx+mTWCdtFE6P9y5Ebcno4nNSMU+EeJdpyly+IA?=
 =?us-ascii?Q?vAYwwLX71FiwTiSiZl4f76F1AwG1554jHlrVrxMpVpnLq0ZkOa64WEOGMsS7?=
 =?us-ascii?Q?PNvUqAhctHceP7zlK6+u9gs8yek4Y6klBdemvnzdkwdv4v21WKns9nBhFpGy?=
 =?us-ascii?Q?5NzddmvKMuzOfsALsMd4KOnvvwLd+H6TV7GU3j1GSpe+LnjcpVq8D4d1C61H?=
 =?us-ascii?Q?m30LPxVYLcoWsxQkltD9d4cX+ZI/qrT8eOjlPXeJYSzlrFxtb+xn31dwucdZ?=
 =?us-ascii?Q?uDsFqU60Ne5sDsuJgBT1jZSVngddYlw+6iwmKizi0MaAY6atENGK/TtqK1du?=
 =?us-ascii?Q?etA1+tyGHMrV0GX/2vCJTGsBXKclpwCbTdqMrd3twAXVMDH6JkYdrv5n/5HT?=
 =?us-ascii?Q?aPm0IB4wmJziiB8PlVsPkw+CEIcrzo717y4Wl35ulhFYucWSuUwZfYkM+Vqo?=
 =?us-ascii?Q?E9G6DHjz+VTsR6/C3+ZiAfv5PjZOJCOUKfze07DV64cMYcoIT2q7mfqUzkfh?=
 =?us-ascii?Q?YjMj8mx89x8FgiWhDiPygEF1vi59IdbCTRnNQH/wvaH1Ny7Hd8U3+SvoGidz?=
 =?us-ascii?Q?neSe8fM5uP13LEUPet8p7strjR7i+gELHnR5ZttDC7svyVGaew2gcynsu4NC?=
 =?us-ascii?Q?1jUvsPZDNChpNx0ddMkohGax3EbgzqkhTIHpdEJaoUQaQRwUDVa/zTOyZgYD?=
 =?us-ascii?Q?u9XLYGl7BwwFXy4M7qrlDM0Hexo1GU4qYJwBgWfqajLB8s8AEX+TT1TlVJ7E?=
 =?us-ascii?Q?QySJ3h9exqxX7Fac6iKkXB/1ow8N38HQb0P5ppQjv25sOuVw8/X3DC4hgmyT?=
 =?us-ascii?Q?QKac/Bqy6pLMVkuJTax0mnHEKqjU1T4toWeV76A8DoxtnvgTIhvXrVyEJtGc?=
 =?us-ascii?Q?PX0VC7Ot0Vp6GrYnrf1qCXPVBBU1KGt3MYbpR5DP/TqlYZbD7QLGvyrbt+3C?=
 =?us-ascii?Q?deaWVBWSqaj464n8K1q4974Dkg/ticrb+I5mCfEa8Vca/HgsX6Ggs4frE/Uk?=
 =?us-ascii?Q?MwWUsucCNcYD7bEeuWOownErUVokvAyFI9UHrxk95Y7mdh+p4K9OCOJ0hQv/?=
 =?us-ascii?Q?a9+6go0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kMrgcUwfk2WT3sWu0mqsfMr0q9av/r05kyC4stRQqjaMscxYM2LScBmz1SPC?=
 =?us-ascii?Q?Nwpy/0cV2DJPkrdpSuR66Y9ZPyvigHYg7M3Hr1qhq8bMO6ZVIBPLkz6Ot/JU?=
 =?us-ascii?Q?ojiZRsCIIbRSPJVsDhcls0ezIzIq2rBqFcYGS/TJaX3xqNiZ5rCNsYoe4Y1V?=
 =?us-ascii?Q?Vbr4aP7Dlo8Ax6jl58AGuhwOAuWzt9FZxHTQ8IDf+gvdhSugGIE+KAFn0Tu0?=
 =?us-ascii?Q?5PNN2wsl5LNFWzjU+Cbay71mw05ELvru5x7bkEP+JjTj3tY/IpmMjNBQSBFf?=
 =?us-ascii?Q?f9vcdBRxLgktQIMVRUT+Y85XgWCRCZ5TEX3jAtWFoPEhYLv+Gt6Md0zVCU/J?=
 =?us-ascii?Q?CS/wDZSeLdQ+X1g70aPqjJQQXAApPk+QMK7OK/3TPVT0Z8yZ9rpJZoBZXpUK?=
 =?us-ascii?Q?vWsh7dJe3Io8/3EgxUhPaFddSL4cDefaz+kOSqleEQpQT3QoZkF0+PXoW1zk?=
 =?us-ascii?Q?KeztsYa/birngtPYJklLp7fUnHGYlOdzBRABiqm7WYXzZMtlMu1QdGfh44Cn?=
 =?us-ascii?Q?EsuplRM5SD83TPG9YowGs54clR+mcVa426Wi+10oHHOYzwah7C+RTWZBQf9h?=
 =?us-ascii?Q?eMrKhR5a3ztQaBsn7PRt48AMp2eQQkoPkuqCVwU9GgEiGi5uXK/zLuRA7nja?=
 =?us-ascii?Q?zM8F2zeJD+1mgud3UZGG4BgOus0/vZvKjMJSgEi8qPdWKpXNNLyMdp3bRBjm?=
 =?us-ascii?Q?DQ/kscxoewE2pGt7aetfj7zqvn7jm5QlRUsRgFtomUv6Pm9jNzItWlq3DR8Z?=
 =?us-ascii?Q?lAVKr0018+aCyO2MnRLWa2A23pHBcv8AfZaEzyHBv6AfsvhSyzZClOH4CWp7?=
 =?us-ascii?Q?Nh4ZidA3LB2vDgqxs/9rPnYtNkXRb4cUXM5hmr+W6e3hKl7/DuoBzkWz4Qbw?=
 =?us-ascii?Q?CgPECqPLeJOnVbFLa3lvFZ9NtS5ZlltYBwV1V8otittmnEcHTdILlS2zhJNH?=
 =?us-ascii?Q?CGeVCTuky+X+hnxqxVYXpg/tNpMaqjewZdVl7tU7e6hkZbgH5YVd1vDR6q8t?=
 =?us-ascii?Q?Ay+vyByTXrSzIcA4PlmNALDCimu+y3u5MYFxj+OVBZmXdS2sLOB3wwUsD662?=
 =?us-ascii?Q?LVhTeE/F16AZR06n80KwRxF5fgIiwmSTqvYtEcHcVT3uLt+dTasdoREQa+Xc?=
 =?us-ascii?Q?K+n+JA6CAFkilKp0LAjQQQm1933E1dBc1sOHHLhCSsqjxu2gy9dU76fLR4d5?=
 =?us-ascii?Q?p2SHoQK08rusv+IQ+PDo85ReRJI8vLzpcKnx840W0PlrFdloj15osoamhoAB?=
 =?us-ascii?Q?7ByL/HPJiA2u/iQj3bc0m/pP9PggjZhNN6kWemHtNs7V/MikBP9iMk2Y4+oJ?=
 =?us-ascii?Q?oNEGSx8C38k6Kj+9DfUjVkBoSDZTcAx+ea74iSSXI4B/3RsjbHJF60SCBojN?=
 =?us-ascii?Q?8d2IBEJP+RuBWZFH6Wh1P1ZEV5KuDoXg4Lj275KZVIA/vaWuZdarMeOcq+Cw?=
 =?us-ascii?Q?XJevLGvgH/6T6hLOTythtyXvSYcqTw3HZMAYAkdRa/XDav7+SUyVvMG6U1rp?=
 =?us-ascii?Q?3i3pWW5N8rndob9Z6+8VaThdvZYDDT0KYym4zz94FbvgWbp8uFEBFhmXIF98?=
 =?us-ascii?Q?mqaZE33JFmKbvtHWh+rdi4czA9dQKMhi0mg0sCXP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c020f9a-fef0-4495-0643-08dcc075e861
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 17:39:42.3557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oZZ09mcUtiPtKUatSz+iX48QdgnFh+WWvi06lvlSyRfxqWXaBJPQHL/t37AbIQQx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8144

On Fri, Aug 16, 2024 at 12:42:17PM -0700, Nicolin Chen wrote:
> > 
> > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > > index e131d8170b90..c4872af6232c 100644
> > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > > @@ -616,2 +616,3 @@ struct arm_smmu_cmdq {
> > >  	atomic_t			lock;
> > > +	bool                            (*supports_cmd)(struct arm_smmu_cmdq_ent *ent);
> > >  };
> > > 
> > > That being said, the whole thing doesn't seem to have a lot value
> > > at this moment, since the SMMU driver doesn't mix commands?
> 
> OK. I have added a patch for this. Let's just make things a bit
> perfect at once.

> Here is a v13 branch that addressed most of your remarks here:
> https://github.com/nicolinc/iommufd/commits/vcmdq_in_kernel-v13

It seems reasonable to me, it is sort of going back to my original
suggestion to pass in some kind of flag to say which commands were
going to be in the batch. Since all batches are simple op code right
now this seems good enough for today!

Jason
