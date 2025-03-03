Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9949D2451E0
	for <iommu@lists.linux.dev>; Mon,  3 Mar 2025 17:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741022876; cv=fail; b=hV3Q73sxQvDRTvnIO1Vt/xieZsyfOQKbw0vS15+y1vM5UnhUopZuAj7AriT0hFF141huJvucnSnahp/cB984JrUfnrwf6kCuITZcjr41FXFV0BTxsNDvAvdM+xZPq3w4201/1V5AsWE52DjWIZHQpCqBNriJo6H5IHKzhRoZm18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741022876; c=relaxed/simple;
	bh=vxAbYOqQOYP8Q4WudYeS2K9iJbtqp0VjVxzNOw2vj1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tjrPZdgSf+3HwypPM68J34ErYQAfm7yuOfG7x+50LmibrRF2kmm4yx/gYc/posHeJ7pv8FVwMqWMukSC0jt6lf23k+x/ivtCJTtxFxyE/Lh1jp4Pi7FArDao9C+Vw0S8bnAhZaA+fKsRqukrzY0R7NOwCIIDER5+UJH4Uky/U6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KMkeiKEw; arc=fail smtp.client-ip=40.107.244.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KMkeiKEw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mDkr7mZUB5ov80wu2b6HfRLu6Fj/XanZmDYYZsgfbtS873AtOSIbImrF0lBRLdUqlAKa8PtayTnGXf9CQSB26Y30ndLFOqywOlZzo+FjaTZ4PsUkqxv+tquE3kFkq1RLt9wiuhEEY6eBmO1w5t/rBSigE7JxDh/bmdeKLMJAiLvg4i55iXfWxa4xrc9AFY8UhKkFyZVsJISZpSOvg4C0BQ3oCEHRQrQ9XicbWqEEd/T5UqmFRPNdwdew/eh4M5ANEYopDndM1uPY+vHiEhSxYnNGeONcT4KgoIzNQt38mqt3teh4kMAr2Uv8jc+cxPGx2JUtWxgggiZYRIG5Z2KNpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVf5K9ZwthiFoSs8KRcwjwWs5qKEwvi5k2vnqyVfWF4=;
 b=PmLGb/8vpmUJf/qFMTV5RnjAUp4ZdPQxO8I6yNdKqfeJLV3wJb7SVJ96bCzH+P5HIbowPkQxFluxwfm9Dk3qVgrbqdv9MIrS/kTxui5eETFUzUrVkj/pUkKenzyNdpDI+XFEUX2BWI1oPYzN2WpRDwh5+wmDFiQtLjBKDmw3wHWT60+87Bu5zcKi/bo8B0i2Pi9tR0r25zv6MtAyhiyf87rHp2+/Y/FxjibMlBXVGSkgM9H4z1sHReDeUX6ww/sGfpIReAZYbt64LGzpZtDyJ+Wyd4sVL91w4rlA3MjhmwCGEO/v7iezBAX9ETMugAvvOdoG+DmAB12Wpf2DvV8VTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVf5K9ZwthiFoSs8KRcwjwWs5qKEwvi5k2vnqyVfWF4=;
 b=KMkeiKEwYDg/czAYw6O58L1CRYQlQyQc0Opedg+7tvT0ZKW5mzsSnzZNpl7y1QrvUB/MJQLlGz7lS9bZpZH3ZZGdunHxeGPsjjYhHa7be+NUWr+slMpPHgK96VOKWWMEq2puo+7ZjMqSVjA4Ns0URZ3NAv9N16jiuxdCefrwPBIiFqn4LfvZrbUq7ynqHhzIrhP4qdPsfZQSKeNgwvWsn35fZhG7CvNLBjC6XuvtWd/WVSZAsBbg5LtryLC9DtfQbwVF9UcL92k7YhttXSodyl5aneYkHxruwd+bgyI+xqxhMASGmzZYhCVaZPKTJBq6AXAKqsY0jgGegeU3W9M9TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB7526.namprd12.prod.outlook.com (2603:10b6:8:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 17:27:47 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 17:27:47 +0000
Date: Mon, 3 Mar 2025 13:27:46 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>, will@kernel.org, joro@8bytes.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Sort out domain user data
Message-ID: <20250303172746.GB133783@nvidia.com>
References: <4e68d5820be06adc1b34fc0d1c9399481151daee.1740742271.git.robin.murphy@arm.com>
 <Z8IapaN1ZD0wImak@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8IapaN1ZD0wImak@Asurada-Nvidia>
X-ClientProxiedBy: LV3P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:234::9) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: c74d2dbe-4fb1-4ccc-bb3a-08dd5a78b75d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PEXVonTPzpT7HEAH18c4QU5u+qmc/A1bWsaTrhQsi0W3Jvq2gzsFUyn7CCgz?=
 =?us-ascii?Q?Efx8s/oG7tZXm4gWTJ5bzaxkqNy5T98/MZpAnC3Y/HREmCH8aGxavEzVanu7?=
 =?us-ascii?Q?kFFlqVCEgMQkOz7ayB5Q2gG8us4lEDGhQF/0Og6r4UFw77ZYRj2hp3IHxecj?=
 =?us-ascii?Q?a0NhHN6SAQohKOVcKLNzFzYOCduE6e5qtLlEPU4k5jl/Vc8XRHqzrItsElXC?=
 =?us-ascii?Q?tIaC4NsKfLiE4q/HCGvInQH8tce+OGjR58f1MNeD4u1e7HH1XK2M5Z5jnbT7?=
 =?us-ascii?Q?3wQTQojOIxJQsTuzx74Wlo0KlSkkpFykVYvP5Lw6vpCTZm125OJyZBI8nfiF?=
 =?us-ascii?Q?HPlbVl6MofB6A159N2P8gcNJELz06J6rRn0UZqxCjKGu7wWNmmAJXjk/VKOk?=
 =?us-ascii?Q?ESNDIV3UYd/2XnuC9gVMkGhx2hIwgMjNXKd0OStqcx8i1wgtoJc/Ohy5tz+a?=
 =?us-ascii?Q?AJGGAzWwjG2yOYZI1kRa3R29JUtG7dY7hgsTUaWISrzfGA70KBAEYtVwomO/?=
 =?us-ascii?Q?7F1OoAW5EY/jWwKFshEHFnydJx0R9ovnUq2+A0zrETuN1wnwY3kwXj4A7kxG?=
 =?us-ascii?Q?RtcuuDqLNpDKkPVJBzUThFEEnvhpnDq8h2mX1oWsIYDxl+2CUYaAcG98w8W1?=
 =?us-ascii?Q?3tBPa6amRmedQM17gWycOK/Is+93oF7baUK2/uw8C3JVB8ZYY7oJZtvcDig0?=
 =?us-ascii?Q?TnrhLhMpq3+y3vYuEcKzIMhxZS/K6RKTGE3lpF+3u3f3h6sEyYktTJoRHXHA?=
 =?us-ascii?Q?UiXZ+EtcWUhG7kRtRS4xBDxeJuwEeCvERUgu2ETGjrUtK7ki2EaMcO1l4uiI?=
 =?us-ascii?Q?8FdLEYumfdFcC2SJyCK/uSfE7PTcwJR63Jv3E8vO8tXbRhPnF+lKfGHT34in?=
 =?us-ascii?Q?JepwM7DQOHCkzyFTIOmKdrPW1yAsKpDZXhappSgeDsejbLR5MKg3y9ZWu/Pz?=
 =?us-ascii?Q?suHBVaGCfaekXZBjuWHE0awe3opInssiXn9J/Ec5D1wiywpnkMqsIuQbpIyj?=
 =?us-ascii?Q?pWO5M45NkpKQ0DgRQOacuJJvaVIM9H0zouJuwWFl0bEvuI+wYn0m5RPUii+n?=
 =?us-ascii?Q?VY8godIQ+VTBnx07LB2Us1SRiOYiNo8cmUibxUVFTBCUMyecoJxhCn0rVD+N?=
 =?us-ascii?Q?jDyXQfVG5J4ff4gzrDOj/n/nOsJzgWfZxJrl63WMGfjfg8NnqfXMIBo2eXV3?=
 =?us-ascii?Q?bVzC9Eb1ybq/AUuqrHg4BLHj5wPtun39IVrWcR+muW1BbDi93FqVQE/Ktmhx?=
 =?us-ascii?Q?DqaCV1UofF52vQbl1ymNWKIW5LhysjgGhSgvYPS1DPa4LGMvZpdmJO/fzB8H?=
 =?us-ascii?Q?udALpsaLnm3JgH5pIzK/I4FeRyJ89DyaoJBMTiQRmUSrgDwUvmjcQoUryEgX?=
 =?us-ascii?Q?O4hP70KaMu32lxJg8jSZOEZqj6kE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9kXq72qFUT6sTxMQ/bst9GChuFk8N04i4yS4pH8+weeNvSEMipv7GNuzDw5j?=
 =?us-ascii?Q?H4jAM6mYDnaWmMm64xoOlkwUBykzrvZUooN14jlse+bMMT50TXGIoY9TPjhq?=
 =?us-ascii?Q?4Mdq76n7r2eaPvJNag0CqUYMzobg1Yb+ybFMP7bLj1Nw1C5BTCxcCgGPuDdb?=
 =?us-ascii?Q?RQOY0B1DW/3YIjwsdbUWz/6PzH6cT+TRIw4oHsDGNvGffyOafzJgywb8njOG?=
 =?us-ascii?Q?nEqmrwpexvylqUqJ0N33AF6LVX5RT6MdR78PFgfaz1QL6qDdgSuxbx2LBj8h?=
 =?us-ascii?Q?CIS8ISbrSH+tEckhQD78rt8qfKmYfmhl9vBjqLwoBTFkaN/cDzjK3k9NUh7e?=
 =?us-ascii?Q?QCCTxSsLJ/9vTLkGoXicktisK7sWUAfa+hHAb6/hBfDWq1O76Tl4tafXxlU5?=
 =?us-ascii?Q?MFAHwCb86Nr0gB9xNoEww305IfzcT1YPGaAXGeQXRx6BrAnr8b27MJcMICI6?=
 =?us-ascii?Q?1Z/rPc3SmFAgvCc0U1yjmLKATpmb4f/YldRxUcMUiCV9WPiWImFIXCwvaEsJ?=
 =?us-ascii?Q?r46pVsaPw0WMQXXFWPeAHSOpr5ZAZvCfbdZA+mZu3SPeHpr0Ts17gkBMhhpc?=
 =?us-ascii?Q?YsCm+DPx5S+KAkSmap8Ab2HG1ex/sI/Evs3g+6g5jSnsv9iV3tom2XEDCuc3?=
 =?us-ascii?Q?TzCdHC3/hYRHYrp+8Scpe643DJ/g1i3fKmFYv/csyeBK0H+Pl21HhM3kwLOt?=
 =?us-ascii?Q?jWE0nt89h35+b9jmUU8KW2QMA5Sd2vWpvHRntJBrJn2192kk4C+CbPWTTszT?=
 =?us-ascii?Q?u1/5rc96CaFubKTwQxn+9mSw2IG7IhGMTDLRlzQYyzdGItFHT2h9DuoNzias?=
 =?us-ascii?Q?zxZbUhMj/PgRxkT/zWlO/n6MlOUhVD7Tg5+UbK1/7baTO3RxigAZPUnVsqx6?=
 =?us-ascii?Q?glNyBuenqNsJQ7YxfYAoXx8onTyVHhBbEFw9i/aitowTSAlA1c+Uu9kZweXv?=
 =?us-ascii?Q?+SvLhR4cQlwRc3B27ALnWE2Ac5ZjyfVTlF3NoyGnnlGGjd4FLofmKxdnIDsm?=
 =?us-ascii?Q?6VwhZY2cyKuRS+QVJcSnIzJR8sb9ozlzOP2zoInNWMT+Ldlji4Pioky9Eh8L?=
 =?us-ascii?Q?9lfu4qdwES9Jk2y5/5MnVWMYxmGvOXtxN4bxgzqklcZugp4sRtLUHGx6Pd4C?=
 =?us-ascii?Q?haHDPo50sul/pS40243of0xUJ3e25zXDFRknan1Or4vw9/oMTRaMvWtzMrsB?=
 =?us-ascii?Q?S+/l3zZhUv+ssL785EAY2kvYHnhdzP4LNYg0qWbzFAcSTDhvyt9I0uPW/7MH?=
 =?us-ascii?Q?cpwsmB4APwKB8JGKZdeMQCLnffl5ryNgzmVmlswbZOy6oS0D2juu33PMWoXB?=
 =?us-ascii?Q?dYJJOKlMYDIkU4EK5pEcUWDVsEKHUmPBfitLf3Q8/dHUZoNtW1lgLCzWg7ap?=
 =?us-ascii?Q?xUFaC7kvxT9yCiEGVIcn+ZAc/81iws7Nf2vpNQC0mkXcIYk+inGJja/6jlsk?=
 =?us-ascii?Q?dHXq+e5SZ0tj2fqxzwynai86s2G22018zNOmD+o4Kt7JD3KSDwZIv2Li9SJn?=
 =?us-ascii?Q?vTydB48r8bgaeNX/D2PSI3yZOdUzHb1fNoP8WssmYYhK68ymO7CUOQOyUcr0?=
 =?us-ascii?Q?ocw3J+FSgLLv7JhuxBfUG1WmUX/B7IKxC9Qx9/n+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c74d2dbe-4fb1-4ccc-bb3a-08dd5a78b75d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 17:27:47.7504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /j6LozOmRlMPiALi/z5uIMiu/QQv/UCMH8ul9aZ3rFGS3S3G33+rxiLbmSKmruzJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7526

On Fri, Feb 28, 2025 at 12:20:53PM -0800, Nicolin Chen wrote:
> On Fri, Feb 28, 2025 at 11:31:11AM +0000, Robin Murphy wrote:
> > +enum iommu_domain_cookie_type {
> > +	IOMMU_NO_COOKIE,
> > +	IOMMU_DMA_IOVA_COOKIE,
> > +	IOMMU_DMA_MSI_COOKIE,
> > +	IOMMU_FAULT_HANDLER_COOKIE,
> > +	IOMMU_SVA_COOKIE,
> 
> I would like to change them to IOMMU_COOKIE_* so the iommufd one
> wouldn't feel redundant like "IOMMU_IOMMUFD_COOKIE".
> 
> If you don't mind, I will make the following list:
> -	IOMMU_NO_COOKIE,
> -	IOMMU_DMA_IOVA_COOKIE,
> -	IOMMU_DMA_MSI_COOKIE,
> -	IOMMU_FAULT_HANDLER_COOKIE,
> -	IOMMU_SVA_COOKIE,
> +	IOMMU_COOKIE_NONE,
> +	IOMMU_COOKIE_DMA_IOVA,
> +	IOMMU_COOKIE_DMA_MSI,
> +	IOMMU_COOKIE_FAULT_HANDLER,
> +	IOMMU_COOKIE_SVA,
> +	IOMMU_COOKIE_IOMMUFD,

I like that better too

Jason
