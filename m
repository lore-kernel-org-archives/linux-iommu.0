Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069461D0F62
	for <iommu@lists.linux.dev>; Wed,  2 Oct 2024 17:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727890173; cv=fail; b=VkEPMaEhLxecgk2x9LReEEHbONOut9nF65xDZWuFHy9+D/52D2K6kPkU/pZbZoS4BVg83tEeSwCk2mZWNB7uuIkALUONPy6Fljr8xZWBcr+CHoUVLDeyMuUqJm34ZVhGACwVOMbbRqccvYaOPAdpAGUatKR/pC+RCJUmkaHOO3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727890173; c=relaxed/simple;
	bh=TuHiNhH1ADE7wBjy0m/WqoXBMTxTkq9ViW4JPEQpDng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JT+Q/Y26UcacW/ylPTenR7M5nwtwr4k+SDyxIX6hreAo9+lST+Kp8Axu12PF41Nd73/1GAbuJgRyvlsXYY+KmD7HOrXFSGmTQCPHvMW31tDzuWXHcYEfcNKCwgQXls21DgyZaFHjRyOp1TooSQZKIhFaC7f0AYu78EmQdvSB/Ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jmz8f3gi; arc=fail smtp.client-ip=40.107.92.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jmz8f3gi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igdQqv8twxWI8mjLP8KXEzSx/Ek8D8om+U8ie3zYsw27yngSrtyyIeicqHML+Qi2/oZUoddKIaVGl5rcf22hISZqBg429meoN02JsaypvwKGbjsXzlHUmrS2ExOh8YNNNfc6udoYOhGjvGQWCe6hR+F4S/lQnecXN+PXDJ4aYaBd8wm4S2M+KhPZHMUYwI3bOnUhBXPc4Fs+2MS/468hFVo7t9waSxqLDVMECHsPjI1h6/eQNGDKD+PCJDkbyGouvRkY8MUlcfXGZ7GOB264DcFgsxKGnvtcUHFSkgvH8qO9cmx1lK7HVhXN/zpjdUgvcPKwn3koNBcReoifZsiWyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdOOHHEOwDQFCtX3P4kt7pqwskrG6qzSdaXGggtijIc=;
 b=pm1aU4je6IPvuHlz+SWMVNFTGiixidV9h0r6E8I73lMox2dig/201CVJaCKP6/DdXPx8okEW+mnMPk+L868Ewier28kdHWQ8RvvHbrbtdEhzxa6WuY/BwrjmoVovzSsGRISVZXx5gYSlzNtvKGInPSgTyFwQAAV67lbgqFOii9xwskQ0z9Z0D+4JGg85Tn8S+X0l5RCjOAtcPk7+vOMdzfBK3CPIVXbb9+mETCMfeih0xuHjlVqRfV8RlCVTldGAUjAxM5fmsV2ei10k4xuUUKrGdJwUHQSEJ4FX+v1+bW6jIBTRvTmj15fjVB/gLB1WfcTQ7t7dX8jQ06I9aLFYzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdOOHHEOwDQFCtX3P4kt7pqwskrG6qzSdaXGggtijIc=;
 b=jmz8f3girK/PbBJRRbxoREpKWbp2f6csFhN3lrLfmW324C0lmDclMo/2vrjwHOYeAHecanCySnTKopLrroMOMNHfkRgWGv6hgbcGc3OhR5PF57NKB8tFpqegEi+wc8f4kR38YC6jpPe0NjG4gxYYk9V2y1xl7cH7tB9mMyZbm4Ac8EjHajDzk5+xuAyacC/EQdmMHicL7WlSpOfcwhiNeFgcXEdcj9MqPtYNVDkfKev8aXhpxnAHRqKiFVj5zSj3/4UyPRTcRHaSrQETW+EEnb1g/HVIEVWhyYTmiCWZ3bw7/wWz22a/tFU93HZokBJWKdwKBB/d62PyjP5TQui2ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB7494.namprd12.prod.outlook.com (2603:10b6:208:41a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 17:29:27 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 17:29:27 +0000
Date: Wed, 2 Oct 2024 14:29:26 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V2 9/9] iommufd: map file selftest
Message-ID: <20241002172926.GU1365916@nvidia.com>
References: <1727190338-385692-1-git-send-email-steven.sistare@oracle.com>
 <1727190338-385692-10-git-send-email-steven.sistare@oracle.com>
 <20241001210511.GP1365916@nvidia.com>
 <d6f0c750-a4d9-4c2a-af15-412dfc3a04f9@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6f0c750-a4d9-4c2a-af15-412dfc3a04f9@oracle.com>
X-ClientProxiedBy: BN9P221CA0017.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::8) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: ac4fa87e-cf99-4a32-366a-08dce307c413
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y9+yeEGQLtHeyOi4c21IUNOzSSEyHK0FkcLODlRLmgrbEndkPYUvHpGvFV1v?=
 =?us-ascii?Q?O2BY/nrNrtLwZbq4le/JCQ1ngM+3mE2at9YaeM/skF9xyr4NNYSMmoPB+nEc?=
 =?us-ascii?Q?kz7wuIqbBzQypLHjaEEL8nP8Odi/AzuI7CwdWQekC0PoUDLwsRV27g4B5E4e?=
 =?us-ascii?Q?sTiIv/XyuikcS+mO5DDLWhCLiW8ug4W0HtaXOY+w/7DV4LphmhUsUAOHsHrR?=
 =?us-ascii?Q?eAkDqs9luYJdcqfYAfRQtSJKNCg72VJ7Gmnc/yRwaWxMkicy17mOMNkWyW4j?=
 =?us-ascii?Q?pOGQpHVA3UufhGOpHx8NvoI3xOhjD+IcW4MjlKmHyvTVX7e6NQFS62mUEUYi?=
 =?us-ascii?Q?w4srsK7FUGjrKs5l61gemVhx33No52SW1s9Y8QiVx3ZzpYAcEnvSYf/Zn8Hd?=
 =?us-ascii?Q?2Y45YroAeXAv/px7sp+aVYORyfV5sLiFMLVdEM4xiGRSH2VbLPJLXUeP1Gx6?=
 =?us-ascii?Q?l2eeECrA0AeZPbWjVBLzz5Mrl+Ki6Sv2MStRd9D/4ck1v+o1HhkbGqwfrXE/?=
 =?us-ascii?Q?XFh6K5IGTYTyZUVIDlnFYwmKQhJDv0/fyj/mow2Geafia29BWfjlWQF/tAg7?=
 =?us-ascii?Q?1sh2TFLVWZivBzgdR2shym9cxOzY5S6srGyCR+4bl3l+XELkP/QJO2NDrt96?=
 =?us-ascii?Q?6z03tA/qlVcF+n23l1msD7q6HmLnIZ1Tbjn8SL1zXRirzLiQmhMb4QHA80n9?=
 =?us-ascii?Q?gBZvBREuEcW5yF9Pd5+ERhZ6/kRACAZUP1DSsQYI6X2QJK28HR66SLXrlYwQ?=
 =?us-ascii?Q?OYojsUSdYzz5R3Ja96nA8jMuhbtcR/YtPsRDMS0oLp39J28em4f7/Fkq0FSq?=
 =?us-ascii?Q?OVKQFLTB10v7zjbVvFb0mfsu4+KOBh45nX9MilF4GLdA/y06DJaOxEWb9RsR?=
 =?us-ascii?Q?JzMJ19IerkE6OQLOYv2NidBhE8l2AX3XovGaetZ0y8CMeMHUDsDXHXjceVaj?=
 =?us-ascii?Q?VCjI+rtr98lpQ/VXa9tqH2LiDkuykRCB/BDoVyMCyRI2grNqSsrtS/MHzeF8?=
 =?us-ascii?Q?E6hJlU6t5blhb65gnC+cQGmvoIuyYIaVJHggimtumwZs4aPAZ0pX7pGT9Ks4?=
 =?us-ascii?Q?xUrsSe5aR7aQm3R4btC60EyDRiuzAtV6uJkqk9xMlUjMKIqOUxNTduqK0K6p?=
 =?us-ascii?Q?yK7PF4OlxTgowQSRSRcAHDKetLuxRd8RynmWWArcmOTQ19Pr/gHX98EfSv+6?=
 =?us-ascii?Q?dUbYheJtSw7rwxC/QqLpD4zEBnpMIc3lgd6FUef64lT0QVbf/c1qGEqz8H4Q?=
 =?us-ascii?Q?fRDejtU/XpU6C1b+gL5bYBYEpOCyYGbXz0TAFqEUOw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UyxZaMsBjef62SDZXXY3Tp0IsSj+1VoVJVqd+4F2gFoB64fuXajSocIRnSWx?=
 =?us-ascii?Q?yhCnzLN+fp4dH4AQVUW4omLtmS5IG3jQm+QV3Y5A7d+/e1BUKCvYmySM7L4f?=
 =?us-ascii?Q?S4pbWvxyUvApNYdaMeotWmk14KV2/uIYkKat9C8fbU8s/fOKgFOnex4Ado47?=
 =?us-ascii?Q?XkUoMHBbV2dzYIN12sTzEW2Lp3YgqscT1orffSTGMTReERXAblfd1uwX7oFO?=
 =?us-ascii?Q?ZGLlKDoHW6jmXt2rKUrVjybiE2wLshgE0wXezif1/TwzHuhzdAwjLkL8ogo7?=
 =?us-ascii?Q?0lryHjoJyOhE38dsgh8DUfkhDB1SagaC0tEQgJ5VWtzF26NMdwn43ulCpX8b?=
 =?us-ascii?Q?Z7V3qCVUn45hsqckGtGinqFGCEzx2hHYGAT4PWGr97b1KxDWeZA1siAOJ1B7?=
 =?us-ascii?Q?bT9QNNWeVjIGhg2TgNDQ4vTURVLSb0JpaTMJC6qrws1FiF/4uaWm8ayIHDdO?=
 =?us-ascii?Q?1laV/XtHq0iGllFdycaCgxrkOcXuDJzVTbxY3KPyopk7yhMnJzGT9FXJ8inl?=
 =?us-ascii?Q?i9+KY4eMDvIp5PhDw8p8OF7ZYueDGpXrk4MaVXU9ApfBGhLS7z7mRoQlksb/?=
 =?us-ascii?Q?LEtRhJ7YcSCqoWhZ9PniOc2ypKS7mItlZUxBlVmwIwsAdFIEfOTEHy8IX/83?=
 =?us-ascii?Q?Zvxeq6DgP2hAEZBTbj8dlSCO4zNfju4yT+NqcvBrWiPSLkY86YSmG3k0P8wj?=
 =?us-ascii?Q?+QaSS2eCjgnva4J+DquvxNbHvVI6Fj0cD8RxV31Pfsm4ZUMp0QLdgk/akteQ?=
 =?us-ascii?Q?nLB3+IlW95aEANZc+H39t7PLo6N31ZLbWvzNxEYcg+JQR9NPFPLX0KqcWLlo?=
 =?us-ascii?Q?3o7Yk4LYaRnRzCCQudTMiIrY9aPsCSFHb6VQBwIaGxVHqUIVl8jJeZXtRBGF?=
 =?us-ascii?Q?f4E4kZX3hEdxQ6+AFmRZJOwAmJCdTtMNA7K4bAEiqSwhKSM64vMVRa10dVrD?=
 =?us-ascii?Q?8/r5Fdu+cxyw/o2woldqBEOq7uTo54UOnXt9pUDhqD2KonP5KTUXKuNuzako?=
 =?us-ascii?Q?ndCXY6g035V/MJe8vHHPT7q8uV0BjdofK/M6ZHtKykgAyqmHuqA0UoDeXjUt?=
 =?us-ascii?Q?evgueTIc45i9wHH8Hh7Qau1tmZ10UrfChfKuNPv9I0NJ7VliHdhbtTZOEwpA?=
 =?us-ascii?Q?q5D51yQQs/M7dZc/hqe493iL5Or7mDEdG+2T6Q+8UWMxuSdv3g2l9pn+Wyap?=
 =?us-ascii?Q?h9iXKxWujcq0hBsIsimQlAImaSXn4O0t4ofJ+p4YBIabN/kb8XqSCh3mlqQa?=
 =?us-ascii?Q?1hUXPvCMdejiTAfhDUFQM4t6Er10hVwiLEybMaYwE5qjQMV2lo7Fr9JNOnxc?=
 =?us-ascii?Q?lxzI85EslVrsE2CQxedbW+cd7i5l5R8TvktuT+R1+H5YOPLYIAsocfLBOaqQ?=
 =?us-ascii?Q?4EB0zPRwtO5UdXOjx//91eFKHbhDe/0lo1XLfAeXFU0SE722aI6zm0JMUOTE?=
 =?us-ascii?Q?STL75NPci9id3XJahNev6zJwum9gCMYMvYizh4dBDvj9TS1fabFcdHBmzVzz?=
 =?us-ascii?Q?kMnNHFYGqolC49ZrVyEVnHBLIAGBCq8Cfw4vfvcOLusbKmvD4n1YtKs7tKHO?=
 =?us-ascii?Q?/ubULVGMiUccAIlwWkU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac4fa87e-cf99-4a32-366a-08dce307c413
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 17:29:27.4914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 70SFdYCrcAEc1CvEYKyueuzLSqOcfrHN/dXccv8Mqa7oUr8HxS6eoA21ngQZyzJo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7494

On Wed, Oct 02, 2024 at 01:26:49PM -0400, Steven Sistare wrote:
> On 10/1/2024 5:05 PM, Jason Gunthorpe wrote:
> > On Tue, Sep 24, 2024 at 08:05:38AM -0700, Steve Sistare wrote:
> > > @@ -33,6 +37,24 @@ static unsigned long get_huge_page_size(void)
> > >   	return strtoul(buf, NULL, 10);
> > >   }
> > > +static int memfd_create(const char *name, unsigned int flags)
> > > +{
> > > +	return syscall(__NR_memfd_create, name, flags);
> > > +}
> > 
> > I think we should just use the glibc definition, or is that an issue?
> 
> Older userland distributions with older glibc do not define it, but maybe
> old enough that they are never paired with newer kernels that support iommufd.
> Your call.

I would keep it simple, it is just a test

Jason
