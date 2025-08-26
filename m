Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2080.outbound.protection.outlook.com [40.107.102.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C741621B9DA
	for <iommu@lists.linux.dev>; Tue, 26 Aug 2025 17:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756231101; cv=fail; b=PtzHLzAtMEWiJZFd16gr1Sp4PIUuYMc2Aa1e4uwabsiXvuP3nxfET3xyhYiz4FDVCoKC8KcXHU1uxZZsOIbGaBb7AdOjpNML5TiOKKyJrJC3U0sEoDJJ9bdekZwO2MyPoO1Pmt6zrIHXkb6CTSt4BmYz/+tQiOscfvQKLmDl97g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756231101; c=relaxed/simple;
	bh=qhMuK1RW6TvjuXhTb9shaiY/wpzloRJkcsJUgrCk0nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VKxtYm0sCZHssr3kHszgN1mZ/JKkbNn6Thvjjtb3emT5T+GSS38QBK1MEt7qRqo67QzGysUuBEOu1CDNMlhwp9yftgz0L8rt++5rfiT2O21PHHQI2rtrN4hSuawd2YXx5bzZokzD1UD0dfnM/ibiYy2e2r4W/za5ET2CW9NAk+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GCiQBIKz; arc=fail smtp.client-ip=40.107.102.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GCiQBIKz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJd1FJZpYHw2KN7dIARRjgsQ4zkkRagUUcvp39d0u1L8eFjY9FFwcNvpYcb+cme8MLJjKl1vfxd3iNcMVJSXQ+BQCy+e3Q+0hFs6TdgPH7adBPBPq2kuRZ37AuEUvWA7swFXheLPl1RMHEHebJAk74nSOR/YW6HyjpnEXEMMU3iMSX/RFT7b8XJNAi+4x9JAs+qmRaCmt1AeYvjL5p51A4py+JueQ8Oe3aXmxASeIwHuPHRyopbCu60eOw5Qqhs6cHzJ/4vYKoHEQpyN/kzsKy060RX5lddzjQzmCx3RoK+R+6Xt9vf0B/FP6QdxllI47/7gwSeiSjhGHMiXLH7V6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KCsJX1wFs9BHjlj1WF9+ap65cSvp6CerTX83LA3N2s=;
 b=edDUOkcRy6zq3QxC25lS6MN/V7SZbHbH2UTOm51/BrW7J62rHnODfXjC5wPculPAVPF4ViviMMN3p8gSJ18CIVIH0gCKvCs+vpHQJwj/BpYciYaT1iIN3KP+zAT+QaXDtfdkx9puE6h2b3+lljN8TMPsv0qsLapospA2g7htnNl5nC03RAQPrOdSS/98Gibf/KZZ3bR7xAgoJknX/AWwCdaaqUVPzvseXS+iSN1xh2QlaXYiOmFEceBFzd9Tp5CKIlltGlWhVL2e044qFnKoDp1AgXAsa5Io4ZLaDYA30AvhH2Cjej7//2wn/QCWY4Cn6QfRHXU1BJ4LzwjL999NBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KCsJX1wFs9BHjlj1WF9+ap65cSvp6CerTX83LA3N2s=;
 b=GCiQBIKzZP7Ydkf8+HbOHL3IILrF6ccFLxd/StBwz5t3oU6a0xSO6oqdiUYAytWY52OO7jVBUFmwWKUrcvrBLc4Mr7sgo9pYgZqsgPo1lNZb8eRqGWPfAymboGVVr0pnHDyutR/gtoVIMsCK5im72f6px3V7ab60p5uNlGVHOq7HO+tEmH+1cftkaKo1n5OeTLHXkh2U2GZLEL0PTV9sFOI9qpXQ4a4rJiOrpGjoVGE2WMEK6eLQiAuOe61UPYAUWUEas+aPrzyARGBFVqKxlY9eHJWH1exBEl60SCwl5I/0Ms2vipVsoIX4Mt/XY1T+P9ZLAdz6twBdIAbKYI/xTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18)
 by DS0PR12MB7993.namprd12.prod.outlook.com (2603:10b6:8:14b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Tue, 26 Aug
 2025 17:58:15 +0000
Received: from SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9a57:92fa:9455:5bc0]) by SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9a57:92fa:9455:5bc0%4]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 17:58:15 +0000
Date: Tue, 26 Aug 2025 14:58:13 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, joro@8bytes.org, kevin.tian@intel.com,
	vasant.hegde@amd.com, iommu@lists.linux.dev, santosh.shukla@amd.com,
	sairaj.arunkodilkar@amd.com, jon.grimm@amd.com,
	prashanthpra@google.com, wvw@google.com, wnliu@google.com,
	gptran@google.com, kpsingh@google.com
Subject: Re: [PATCH] iommu/amd: Add support for hw_info for iommu capability
 query
Message-ID: <20250826175813.GH2130239@nvidia.com>
References: <20250820042533.5962-1-suravee.suthikulpanit@amd.com>
 <20250825134420.GB1970008@nvidia.com>
 <85c544d7-b274-4696-9fc0-829033eaccaa@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85c544d7-b274-4696-9fc0-829033eaccaa@amd.com>
X-ClientProxiedBy: BY1P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::11) To SA1PR12MB8641.namprd12.prod.outlook.com
 (2603:10b6:806:388::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB8641:EE_|DS0PR12MB7993:EE_
X-MS-Office365-Filtering-Correlation-Id: 22cc9178-17f1-46b2-fdca-08dde4ca2162
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lDwQMtrxy+7xra6m5jKUYMYJxadaOvW5HK+adjDfTx5ZlqgDWK21t5qHRZbq?=
 =?us-ascii?Q?TwyL+o8SUcb40hk2hEmcPg/N2Y0FlTsq25xGcIwPQECcxEuKRO8kDIzz+9Qf?=
 =?us-ascii?Q?BYuZDSV8bM/Gw+9nmWsSqn1zYz2nzE5slTLUdvQHn0tzOwa1Xdd63ONluuYc?=
 =?us-ascii?Q?cgjlMyN9FyjUCmjfgXfnkncMqPn1/Ml6WPgJfx+ZBxDyhC8u9+UoueJIox8d?=
 =?us-ascii?Q?1zM+AvaTvFRMigiL9B6OoyEAuTwOC8x87aA++hnBn5uqHw2RVxBsRVgNW6Rv?=
 =?us-ascii?Q?yPwTQaSCLoH4R/0z61HfJd+2q902GjLk/VVbeqImbatQnZbwHvnLL/7hABAh?=
 =?us-ascii?Q?0HYQZTLtJo0tk9abfgNAL4WgiuV65K4l4jfjZ/I0F6nZOen8ol1hLqVL+MOo?=
 =?us-ascii?Q?jUGDbo9APrHWaytX1lU9d8Vwz4ea4tWofhGprLTfW01YpfAsGGOgd7bNKSsr?=
 =?us-ascii?Q?+rqbO0jY3cOtgyM1L7rOCRo0H6XdPs0CfA2SeeD+IdifyWzL9qiHHpF+QQ6R?=
 =?us-ascii?Q?rNBxm/fV0FoZSzIAPmM5tH9jQNquvTS5Hq+294KDf0tjdHwGhgx7kN8fj1iT?=
 =?us-ascii?Q?poYKKbOKTqV8tznym4En6+7H2iQEx1CdC0+GKzpmHOKHwEU58xhv4TfV5oid?=
 =?us-ascii?Q?4hhaIX70NJKDSzlTQOruygc835tsGp/YXl7k9acls3eugBvEl9YQvkE09mEi?=
 =?us-ascii?Q?5THOqc6DpYLDG8yX/O4K9rGAVj2ThMgo3FtyRC15Rx9EYzgKU2gDE0GVWX5D?=
 =?us-ascii?Q?CIfGdjEj6MicucPsockr/dMm+575D4vgmwOIN/YJB5tkRTzOcAfxONDK5rwS?=
 =?us-ascii?Q?6t4ytaYg0zMnpNgp7H6vG0Kl8ToTeXyxcV8NNGUXrct2Ng9DpSgVENa9iWNL?=
 =?us-ascii?Q?06YTk/d+DENml3k7talNxyonsokGuFLPf/wdoqyIp9g+KFfedYdulgnw2F7z?=
 =?us-ascii?Q?PlwQw/ANCaW7EMoWBG45UD+eVlRiDUCU0OLVtdhpsOfSu1hY+haNKlobrF6h?=
 =?us-ascii?Q?xU7Z1xlHsujwE2/PtLgXCHhFsqNZMa6ib4DrY+M3odhyRyaI2MdVfplJR4jf?=
 =?us-ascii?Q?ug4dGuE6CREHWVr2dcJ4dVO3bwFt0CpqGTZxfxVK1K98fogkLBFCsxVh5uT4?=
 =?us-ascii?Q?NgkEgbNHUFpUE/edroDQe8TlJL9y45ja/kl7IMzbil6tnNdSphkHecLWTLju?=
 =?us-ascii?Q?FNbQdZ+tOjkzvG2GkI3KFT91lG1nK1qTxDSxwd9zaoPzbtOh2/50oqxwwvqY?=
 =?us-ascii?Q?oDs2D9rBHK3Hngck1uOUjTgjAGwCuElXHWNZJQy3ot3zmItSqGj5E8PWPFLY?=
 =?us-ascii?Q?Ls55Oo/oQAjS83xzg6RRc8009IttfT8kAYiH+RPnzE1lka4qsZlS9yEGhEd7?=
 =?us-ascii?Q?t1PtEpS2PmlErRr4irYoUEHMKOLE78eXIkU1hAjCxNS0Iu/0lQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8641.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bTUKMABezW/Tm1rox7mF0DcB+6E4eQk44FWVnWbzIUsugwGeYfrrTD7WLiBV?=
 =?us-ascii?Q?36GHRBtwBdVKJCV9DzQ4GliXnfu4vuNWTmxt94jYu3rcP2qNrDlMA3WZOxv0?=
 =?us-ascii?Q?TWEWTVoPA9XTgfEl3Q0VA1iOZNeV9M++WNGA6c4NQFw+g8FqGgMJAMa11ZjB?=
 =?us-ascii?Q?rxQ8Ud4PdirK3EBnmxNDLwBAWJlBiuCDyuCDxHjEPeyx5YZBM8DPANY4hXjp?=
 =?us-ascii?Q?s5uPCG/sgq9cRiaZ3vW+MEXV4fVCl3w0bE/buwfjI8MYu8vaZXFii+ccIvSx?=
 =?us-ascii?Q?s2ux3RbbBi4qGzIb+AAN0MN3DPdoA5by61bM4xkyKbCorKVKnPGmmm+zHPoN?=
 =?us-ascii?Q?vWs0ga/kYSxWBQsFtnZIHt466/fy5z612b7p1S1GsXFhQhtGVuir+7/tDwhn?=
 =?us-ascii?Q?TCK6ouFLAnQyJyl25G1ZCmk5T0VozdCa/LBLZ/M7smMy4CTXNH90wdIKfBGf?=
 =?us-ascii?Q?XMETyn/Wd83L3rbob9g9RtEYeqJTEWxTKsqN+LG/7BE7l2JqPWsVR+Q0i69Y?=
 =?us-ascii?Q?8aUI580pmPcjJKDqJHtuCQCxTArNmNwxSRYM//GmeW/64YpX0PFmj6qbMVQf?=
 =?us-ascii?Q?bt77lg7cr62kvzPxNt9/uJahR9OZ89k1txX18eqM358kf/vDoXzBK78F7qqp?=
 =?us-ascii?Q?RTPM99WPE9EWEsYsXfSUkVcXs+3wtcRMahN0gApwhJ5Feciy5R42D91bXrVe?=
 =?us-ascii?Q?dErcTsSiYqg3rb3g8QVi0pA4EHsh34x+dgphNmZu0U0+rodjo1V4bmNYFhV2?=
 =?us-ascii?Q?XGaVTFH91ETal5mZANDHquCWf2m1cr64nx11QC8U421BqBLyFP6P6ZdxPZPc?=
 =?us-ascii?Q?pBr9dlqWCa8iNDsFlnFCen6iJKX+qfaH0VhFgAeAlbp/w/PADZCSu0eA6ZDv?=
 =?us-ascii?Q?VluAxsmWvsxDaOxGTtrMYjNWppRC08Ww4yy+LRqXU0uSEY2+BWu1oewSWhcs?=
 =?us-ascii?Q?omJP9BnrTDwM2gxVKjTWwM4qN2CFKhN+0lSkt71b7/VuiwUVRoGKi+N4GXCr?=
 =?us-ascii?Q?rciz+7orPTLECA8mfUgk4D9RcMAmHroLSJySYAfq9hpupbJBDGJtJ9Io9lWw?=
 =?us-ascii?Q?+99XBFOan2aEYsv87zrqD9sAlyFzml1Shs9XsqrbINZkI9AqJHHCxFEEHcaq?=
 =?us-ascii?Q?0v9DbdmyFiIeODWrPbO6cvijBdnohXupncYIsbnKazF79cLtQTyoNtyS984D?=
 =?us-ascii?Q?iBgUCiGnC6Pdqm1vgvoKagiCUzQeMHezf2+l90EcDCME7MhNJtvvO7LM8lLn?=
 =?us-ascii?Q?gp21udiPkK/7+y5nBB0zoiE2LW45MIzJGUqcbkhGLBKxHFQZB/kR4Md1pngE?=
 =?us-ascii?Q?fQlsBcvxsEtHdqDcM/ZR05FK/wGhVI/rvjCtbtJSe04y2+bGiS4D0jvY4V1k?=
 =?us-ascii?Q?6sHsC2xHAojewbwA8IiAsjhIITG2ZViTaMQ4HTn3yzgRmL7OB1kA0EuSG7gW?=
 =?us-ascii?Q?vaFHRVxLk37dV/gfaOMEjKYY4Fjvys9XnuSqKE1dbl3vud7lIbYhyJqNfQRM?=
 =?us-ascii?Q?vd0Ohvnju4NzldrGs3K78tk//+b0kWHoMsbGxDvnuD/HUEJPNzTUpDc+Tgtc?=
 =?us-ascii?Q?2Ull8lGp3+vgjlsn47w1kt6H7ZUyF9o8ldwlyAt7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22cc9178-17f1-46b2-fdca-08dde4ca2162
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8641.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 17:58:15.2879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IjI19+DeV0yVewwji3uZMT/sCcT9yBKotePKzCyxjuClbrppPWb1l57ujohm/2B1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7993

On Tue, Aug 26, 2025 at 12:36:23PM -0500, Suthikulpanit, Suravee wrote:
> > I think you should probably just pass the raw HW value through and
> > require the VMM to figure out what bits it needs based on feature
> > flags elsewhere.
> 
> The problem is some of the features are virtualized by hardware, which needs
> enabling from the Linux AMD IOMMU driver. We cannot just provide all flags
> since VMM would not know if the kernel has the support enabled.

The VMM is not supposed to forward these flags as-is! It is sort of
some kind of maximum what the underlying HW can support.

If you forward as-is then the VMM will forward broken flags it doesn't
support when the kernel gets updated, that isn't OK.

Each and every feature the VMM wants to show in the EFR has to figured
out on its own if it can be supported based on other kernel features.

The utility of the get_info return is for HW features that don't
require any special kernel enablement.

This is all the same as ARM which is working this way, I don't think
there is a reason to deviate here, it just gets confusing and opens up
paths for bugs.

Pass the real values from HW, write a comment similar to ARM that says
these are raw HW values and the VMM must generate its own EFR not copy
blindly from here.

Jason
