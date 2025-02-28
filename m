Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEA21EF37B
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 15:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740755579; cv=fail; b=LRWZR+UTL9BqHGp7B1nrgMvedMEOgb9kqz02ciJxo5PXg91DW9AlOqAm8Yan06/Weg0hOqdiSu9GurMVKBoVa4k7glhf+gfmWCtMkYDC4sBcJh0P+xRe7sXYwh6jF4UMT9Encv5qRFeq9pb6iesP/K/syHOEhdxwoIeQ7e25Aa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740755579; c=relaxed/simple;
	bh=lUoN7i2ESJwhWql5/z/knPTjDYIxrg0Z9+lfw/pTLNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nyT999RiHpz8uGbFQsajhNwTD38cPJnWaJ1BK/Azd2EHwZanqTU75jT5XNGzYhLHEMg7nYikczWqpSIwjnJHh1aGBk8PP8vO/b1UiBZLD7b2cQ45lTpkDjj0BY+UQsxyCGaUPuZmKJwj0BS+YqWX47LTvxWhb3/k3JyTk/LmB+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XFf4P0Q0; arc=fail smtp.client-ip=40.107.101.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XFf4P0Q0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YE3YA/dDhRo1BkfVBkOo3nSSDY5ngj0ABOe+csW8KYtyriT4F9YXXRLFHHMJmR49FjYXENuFzKCjFhNq+ORuNMlLrTmbMO50iFI2X3L3b1KO52PN+BemHkiKmkdU0nvBQKaSdKXtbfY5DSHv7nmDadpPFM5eYDsc1+KFIWA6XCz4LmEjkiGC3uFE2VIyIVUUuIbsb/wCJ+k/gwjPIbTjVXovyikWEfyFw+1JcdqRuxc1vcxVX6O8FMgJft3D01NHUimeEfpyIXL6LIRQR6fdprM0sbeBEgMPy4DeNeMP6dLoBzyseGItwtnDiH6TzMuE2VeKoLN+6zzk2zdMeR0bvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIjQ8263SdqmtDzXwt8FZelrwkPX7cxYPla5HAveczg=;
 b=Zquih5WS4qD4y44lmPXYXKXsqfT2bRySUrBLgXVLC7WH+Tna9ozrufxiQ6bMWI+fkJLlkIFot3hKpvRtpC8pQwebfdPkqxXmXx76tnG92xzffxDSkiUBtUUlOTicnZJq0xm+5ORRZWSVv0FFyMWYJQNB1uKAH4on5jyB11pLbrNnlcO/Cjd454PdOukZnndj/GNHmy/FgC9NseSXemycuMYq+N1Fa0hO6ObH6PvKibtZdk3efHpIzUtqcVYQC+8sY7M2yBhE8kJhkYZmi+VFc+h1FAPHZHO0nNWpEDTzv+SHlreq+eOQT+2Wbqo96YtchYZJS35UOx0hUSgJyfpJcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIjQ8263SdqmtDzXwt8FZelrwkPX7cxYPla5HAveczg=;
 b=XFf4P0Q02pjy3QsZ8KW9iDsXPAvwoPv20Z0D1swHwz4dQOfkcRRQdikm/bdbuECsV6n7+OOjvnaR7CbWv4DygIJ//AJOghcwXvGkESPBL/SiX3Zyv6BjG7LJOk1+jhRd5QRoBk/+JsTjXqpyL+sLfGNTzwRL9W1BxsxLByuqZNzx6Wi+P2+7DvDpJ01prYKaymc6EiPPyA4eQKd156jFm0ctKKdvT5H66g5EFYzKLjMH/CpQImXm8aB7bMP2fX671agjmFlJMqganb+IiwwcLWyxh+m4+F8Xn7QJ4zHRta3QDEgwJyg3fVnYSKSubTZe0cGx+3+M01JIXk4MdzMITw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PR12MB8301.namprd12.prod.outlook.com (2603:10b6:208:40b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.20; Fri, 28 Feb
 2025 15:12:51 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 15:12:51 +0000
Date: Fri, 28 Feb 2025 11:12:50 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	joro@8bytes.org, baolu.lu@linux.intel.com, iommu@lists.linux.dev
Subject: Re: [PATCH v8 01/12] iommu: Add iommu_attach_device_pasid_handle()
Message-ID: <20250228151250.GT39591@nvidia.com>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-2-yi.l.liu@intel.com>
 <Z7+SrQFXdheJQzuK@Asurada-Nvidia>
 <db3df4f2-445a-49e5-9362-70cdaf363420@intel.com>
 <Z8CSKOpsl0eDh9sC@Asurada-Nvidia>
 <b153d62d-1d8b-46e1-a7ab-527073a80368@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b153d62d-1d8b-46e1-a7ab-527073a80368@intel.com>
X-ClientProxiedBy: BL1PR13CA0331.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::6) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PR12MB8301:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a222d17-fda1-4857-6e4c-08dd580a5e83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uMBTxTKEigrQuF06F72+PHOWu0KLADlnIdiW0UaWmnqQUJMbHYs3mUY/ufgl?=
 =?us-ascii?Q?2W2ILQK/Xf7s7hlJju85QqVXGQAgTQkICmeCXNPOz73nNwIW5D3AqlFOO1d2?=
 =?us-ascii?Q?K4FQV3YybXmkwgQmY4tv3PKveYjNe33H+YDYI1oF30MsH2cblIjs64OXPYyQ?=
 =?us-ascii?Q?07XJi9/tDYE+Y4/zbvEwWKr+l69zTeY8GyfF/Qk0JyG096wKIzvAZS0YdEiL?=
 =?us-ascii?Q?wvxe6Nz/sDycbMWbw7vySagjCyTWMqSNELNaHE3oPTV8BbH3Tdy9wd+tL+RM?=
 =?us-ascii?Q?zk6wtvTXs7gjPgKGGUNc4bqunON9XMFN5Zwsf/vvzCGr5vBwwaPlTmfGx5ZQ?=
 =?us-ascii?Q?vZn7PeIryDwK0gze3LNZnTu1hg5BZhaFN1Q4nSEKeV2R9NqCOXuBhenRnSPs?=
 =?us-ascii?Q?Jb1UsX2lYgF2CwNo4xnN6zshH+qQ9XnpGRhD5jWTw6AcSFyfxlNZD7wmIMId?=
 =?us-ascii?Q?tTYHIKSAdqhcowY18ScX3xY5uoCYVk52Vg03q5LZDnK4EJTJOgXTX4v+I4hx?=
 =?us-ascii?Q?DWOnHSfxNAPqT2+38X9dWrPAcAmPZrAL4zcZOwkyf8rnF7jAQ93Wkw1nhM3D?=
 =?us-ascii?Q?X02aREJI7ZD9zXZnVHAX/ldX4NTDJNXAGVKw0KDvXO0yf7f8oUCPtQ1cgOGG?=
 =?us-ascii?Q?dN0ER/4Nvj/o2aQmvLCaD0SMDpoH0Ak9LKo0jZQXovXtytc3wu7qrmujGzjd?=
 =?us-ascii?Q?88CjNDIN6RNr2xhOk2BwXaGs0o5HyspH+s/Sir7bJNLMNTQ9OlUdK/Y3Qk9F?=
 =?us-ascii?Q?gRFFbRgE79IgK3vVpFu7xiOXFPE9aZwHmmO6HXiomnO6EdcVpzwrF1hP6q6p?=
 =?us-ascii?Q?20+T+UerVSjR40BrrNq63kel+fkivRNy1xm3rxAiCmDA5RC1l6tNSJp4LvV2?=
 =?us-ascii?Q?fkGx4KuetzcUDQQVeFaJ/KXuRnpu0+VJutj1WINdF1vOdKS/NBpfdNkjKW8A?=
 =?us-ascii?Q?yCJEPcwjBJpiDNWgT7vdvH7yXToyHJzRD1FeSF4q4C7fAwZTSAYBp5MH9mX7?=
 =?us-ascii?Q?xfxkkVXpaGoh63LitDKWPyoeHhX6iorUo1aKN7xy5m209tRKZVJTZrk/II3B?=
 =?us-ascii?Q?VwtrGAj5/vbJO5+v7KneSrMGusP6RrOtof4YHi1sei4zxXyXp0p5+MPWm5Q7?=
 =?us-ascii?Q?ptS8iu3g7JBrozXrMfbQy1x6HsMP/WYWVqNHk7UFBsk1y1byGaYZr4LtO+k/?=
 =?us-ascii?Q?Z5vuadIBa3IH4tJEOGSZ2qNoEgSuozTcfNyThzgxflYWOHqK5S95slEfSpUi?=
 =?us-ascii?Q?b5wrfotbR6j0YDNx8HhZHTaKgIl33DNBnCcj+jdb9ee1VV8rJ6isQsJowaR0?=
 =?us-ascii?Q?9Hbb2DgR3v+UZSKIE24GoGkrNQsCGzubXsz6TQRFBiT0JL+ypJ4sEr0LsZOv?=
 =?us-ascii?Q?XFZss+MckJdzHnM91uvUVGn0oDpm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xYQwH7WxTexrR/xMJubvvNzpFPp7LXJZ4VhKdJ5DMczofhP3CIVWxpERtI+R?=
 =?us-ascii?Q?1OOLL6hAVJKXRbq2FRrJc1nevmywov0kXJBIxUVZuafDhj3sAxARuimx0xwz?=
 =?us-ascii?Q?asjmUC9/urZ7IsxSnGlf40kvqZ75svqT+/kbQNhO+YE04RgDvbZlxaKdhrRO?=
 =?us-ascii?Q?t4pVib4E53pgRf6iGzXyqRYYliL6c51xQaYeyX1Bopsi/72mzgOXtBH41k0r?=
 =?us-ascii?Q?Uj4PjDEcqcQs3B+jonOfF3lD711m7u9TekDOILLp68W/7ZykYYPZKERJRZDo?=
 =?us-ascii?Q?9lrwrnn913QkxNxNzEN2BQW0w0Wt+oxgv9as4rNGiiT9eRa7b1cUXOVaS8VG?=
 =?us-ascii?Q?IhKDHuuGN3U7OEtrBY8VB4ogPh+fbqYt1dLCdxkyoPo1ylnCQ2xwEy5zWwsE?=
 =?us-ascii?Q?YPgqsZ4gIiUF+08w6GbO44rT5pcKBKIFsaV7MwntJ0jZkfbmXkyJ3LNw2S9H?=
 =?us-ascii?Q?1dxxlO25kbdw8AnTMD8ewtuBMnHnyvOieny0b6/JreKjCQJ+9WxOiCL/B4MC?=
 =?us-ascii?Q?VxtEFrRCEgPQjI5VTZjyMxICkj1/Dk64l5aTSX8M68DmvDsUGQvvDPtWgQ/f?=
 =?us-ascii?Q?mUlJJsRNO9RnjO4N/sfYOlwSa76UThqAv7I7GuJ4cvTdYEsLF9Q0vINd5gBK?=
 =?us-ascii?Q?cHGUbE5ljgq5lMw7HUb43J2F4lQ+2QCY4OQol/ld5jF2ROEC9vxZoVcDjvGS?=
 =?us-ascii?Q?ehfLKIemgz2lSdi6nZjSMFgkKoHIu771O13VRZ3ndg734tVMdkMc2w6y9qT6?=
 =?us-ascii?Q?VxqwW530rMOd5PAAebiisTHM4ludAag3EJ92G3xdt0VX6ZdWBUk+AEOCxZeb?=
 =?us-ascii?Q?9YqK2ZShVIsc1Teu7uqFroAzzj40bk9rcluBPrwzbWnLQSfLgUNutYsYzXnH?=
 =?us-ascii?Q?Q9B0pv2fPwaUiZWP10k6sipXaMTOMGYRpO88oxj0NdSzGliyjxMybOsQA32z?=
 =?us-ascii?Q?NmUJT3lqQPPoLWfgtPlS4DLwDxu0lou6qS/LXSUz/8J/SY2GMykUG40lj9d5?=
 =?us-ascii?Q?NRpZ1epN4WLSlsnLHU3vNcg79TIbDrxLSWCxzX/yeRCva9lbTHnFeUW1UCtJ?=
 =?us-ascii?Q?i1MelL2i0fbvbQv28aPxe0gl4o6HfuMPeNYOUvdeFV8BPZFyCpCgx84hwrDc?=
 =?us-ascii?Q?k9NHubZ2PA4Rv42SG4D0l4w0yB8u9Vv7Dh3vMdMfK1hQiDHyJ+cQuVG1R70i?=
 =?us-ascii?Q?nSgO3s5BelKtD8AZzurJLH8rDuQ9i1oxlTpzLVOb4oWtaQdijYGzWpOlO2ko?=
 =?us-ascii?Q?Tn6t7YPxCcm7/tbIHJdgnqGka/Tdr6Jtr/ypUrvZKIDURZiWOEPG+XUal7qy?=
 =?us-ascii?Q?MB5D1LCJ8UcXRJLYBkrqENckxzV46lmlYJudXrDr4HJE8a51C6YDrWrqvg3S?=
 =?us-ascii?Q?lmiOTeTH0XF4NkEkLT/yxsR5GBWUibQO4hBIH8O4YmjOoD4k8usRqJe2nvx2?=
 =?us-ascii?Q?Ei4R1gb0yOY45zIija6pMWnJOsy6R5eaL7LdABDApE8SkFc4j8LlNfrZfx0E?=
 =?us-ascii?Q?J3TtogK8zygzjyIfON0FI5Z1UGsBcBz5o3dKCivCNPvQMMCHNLzJlxPsma7l?=
 =?us-ascii?Q?hvPy65SlEzqwXsZ9imI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a222d17-fda1-4857-6e4c-08dd580a5e83
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 15:12:51.6557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 74e9GKKdNLRE6gPoGpAye2m1YxCluKY/iVp1+ix5fXFtJLopVoovpJ8SGlsTHRWS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8301

On Fri, Feb 28, 2025 at 02:48:22PM +0800, Yi Liu wrote:
> But you indeed reminds me. It's improper to have the
> __iommu_attach_device_pasid() in header.

If you do it would be wrapped in an inline for users.

Ie you'd have  iommu_attach_device_pasid() &
iommu_attach_device_pasid_handle() with the !NULL validation just call
out to __iommu_attach_device_pasid()

> > So, overall it doesn't feel very necessary to me...
> > 
> > The iommu_attach_group/iommu_attach_group_handle() case, on the
> > other hand, does take care of some underlying difference. Thus,
> > having two separate functions could make things clear.
> 
> actually, they can share code as well. The below patch actually has started
> it. Though dropped to not blocking the pasid series.

Yeah, I think we can get to the point where all domain attach,
handle/nohandle/pasid/nopasid just calls one function that manipulates
the xarray. You got pretty close in that series

The PASID0 special cases can be handled with flags.

Jason
