Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3B522F19
	for <iommu@lists.linux.dev>; Mon, 18 Nov 2024 16:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731947097; cv=fail; b=JXCgxx/YadCmjxAEOdEsK9xQ9W1H8my/0JUwV7s1PR0N2tKKzxjJ0l+MLGTEnKImuYXQEzkIXbkCC8DgGbs5iLEXOeDjPHiL03euqmR+F4Aljmto/j+wLMIIiwK8Sh/zk6+xIix1uaIe+5xs1ogcPMsT34VcVgiPKnysP3rKfkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731947097; c=relaxed/simple;
	bh=joQ40rLAAm0Nq6gwGZbK2xXlvzzi2R5wXcIrS4hpiB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fQGlU/D7ZF0IpLxfDFZe+VKPraQ5lTynaUKjkC8Cvprv+4I4uirzSdpf8H5THedhrDoK42xI7WBFxTKJxcULTashW3r3Zq6HvE6DkpFdn4W47aFoIgRO/TgnNi4roU/is0HxJUQfF8UkRmEeYgXB5ZlQ0hV50FsE5FD0IOlk5RU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ghP+yB9s; arc=fail smtp.client-ip=40.107.223.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ghP+yB9s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RuOBk5Coo5nh2KBqRL1kJ4Cz/b//ZoFVX7PyarQUjPe3Gn3tIqcJhxOteVzKeT/yjBfRXgfWV+M31V2sSI2GN1vFQVvKI0myufC7AQtSpJL4fEE3M4QC/12GqX7FR697vyYme3llj771FkrAkOumVXY8iovel54g1p+JB3YXaZeWCjUHehYrYhIP9HcuOGbGcdBYw5nVCX7cZrBjCR3ZdtxvWf2Ar/JtLsg7DHcfTdNbkxEJTF3E3WiNyNLke2B42DDgSMPPakPpsjyQvXYuYweeDWyxet4ngsSz0t7/kaDWJnkAk4x2/IbiQX6WR6gflVxMgdy9RQP0WroFeRmHdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7NDQ/QF2xVf7aNASuZuyoLhU8aS8wtLG0eEYkO6IhY=;
 b=vfsr9PZam+/dzxHD9aDddGxyAmBzAYI/DelktpAqdqsCmtEXkZQgOF5IjZf0PVvw1rHZS971y3bCBm/ruICOx7+IdQVBcJqFKBjezkykfbtEjpiCbuRaQ+/0lV6oX8guHY3y5B2z9gcRh7cGgjIj6YdWO8DtuZaddBWkgwYo+mKBT4l5tZ6MPLvqI1C0LFoOCVBNl3jxw8jDJ/H2cvpuE6o4ObzuELSIpz0GZDfI7nOaIn3SS23C/LnhKjK3ZVrpsc2Wmp1qjQN3+wYmlqcPNcn3rvl0ujXitSqCw+fMKwDPhl1ssY4MTfzQUG4entG4rrQVIdmjN8Cmw0k7PrWlyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7NDQ/QF2xVf7aNASuZuyoLhU8aS8wtLG0eEYkO6IhY=;
 b=ghP+yB9s8yC+UR8W8ropdgWp2RNOp0li3GZeZVhe3151I+YoDkvBP3LcdY5epuLVQDjqJwkyQmYe9TUY8k2AqrRDLgPEQXxU5mruYnXw1usjGsoMt61sg5dEJDGhOWZqBbL3bW0ilVTUGQHGhuEwq+q41A2FJgZH7XYjO58O48V7+ai0KMvd+OlTKBrpw9bZrreKTEeDjCA3fY3VkKxNDy3o+EvSYXJQpPa1uII0zBYXLNBtuHjxzcoM7y1KIHTBZWePuEzFK43RomerIfcHUYFynebN9AvrbdlOMKS7nd6fjF/tQUKzsezr7MJrcaYaSEDpUjVLT6M23D+sd51YTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB7819.namprd12.prod.outlook.com (2603:10b6:510:27f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Mon, 18 Nov
 2024 16:24:45 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8158.019; Mon, 18 Nov 2024
 16:24:44 +0000
Date: Mon, 18 Nov 2024 12:24:42 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Pranjal Shrivastava <praan@google.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH v5 1/3] iommu/arm-smmu-v3: Introduce struct arm_smmu_event
Message-ID: <20241118162442.GD35230@nvidia.com>
References: <20241112083018.1662104-1-praan@google.com>
 <20241112083018.1662104-2-praan@google.com>
 <ZzPlMlE2gpH9DQQ4@Asurada-Nvidia>
 <ZzdJAFc_8h6LfVL7@google.com>
 <Zze+VFpGNaXepFWC@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zze+VFpGNaXepFWC@Asurada-Nvidia>
X-ClientProxiedBy: BL6PEPF00013E0B.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:10) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB7819:EE_
X-MS-Office365-Filtering-Correlation-Id: 69903e20-41a4-45c1-55cf-08dd07ed82d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B6M9a2xC5J2P0YGJQ9NFmd/wbHdmahOZzG6WfD5jsUHKxGhinsdwYt/F0eFm?=
 =?us-ascii?Q?9rD/0BFrB2fxTDqO4vFd9Hf/gq3G/1BdPBrKAq7IP9/qWH7yaenqmhsxL3Vs?=
 =?us-ascii?Q?foPKYlmwMFDb4LwWt9/+CCdkMH2N4N02yt8qw1u4Yusv99assIua9/rShxAu?=
 =?us-ascii?Q?wlDkaHyQLWR8MkjjFq7CcEONASJNWh0r8/+33RR33IyAXLnRDpiXcxCs0XVd?=
 =?us-ascii?Q?vOb2SLatmDvpISdS/pDEYVDvuO9D0OuLeKW2mVvsGeWIMfFvjSchl7L1iiwW?=
 =?us-ascii?Q?aTivASYiuxAwFvdXMVjw27PKeZEK1Pi009/sSkbZ+epFrFi1CJwa/2yMqE8w?=
 =?us-ascii?Q?RIrt6w8l3lgI+E2wX0a8HrGP0AnO42/piZjK93lb3dIizMfF5zqrrrXcQm0m?=
 =?us-ascii?Q?/jSjwpsm+Da5MbxpI8DGh0mESYHhaFtGuN/Kk3y87KnInlX7Ddl7vELZWeOd?=
 =?us-ascii?Q?Qt5cFG2l3gajV+62we9rv1QsLNlOEEtqTJrep+7Sh7jChYIE0V3hoBxzlfMd?=
 =?us-ascii?Q?fG3BMIqjZfmMgpPhPHQzlfZU/Y9uaAhmOljjLNYc57/1VO+Qz8nZwNtpIXRC?=
 =?us-ascii?Q?XHvng183AbMj27dmSlU0lWy/5bXxRyUOrFhPSH+vCop+SscyLr5sbKJnkOLa?=
 =?us-ascii?Q?tgLvPi8U6Mk+rOPorGMOQTWVZjqI5AaRFAPieEdGAMJnB39UHJUR5Jux+OmI?=
 =?us-ascii?Q?pMloTWpVec4o+lrHQOvDbOqTdwxAdUbF0OpLshsoCoPMSGAEbyDVsIQy0ACG?=
 =?us-ascii?Q?ZMW862RKn0HvB3G28CRRxR7lr7g225skflo3oZhEz9Ypc2t1/DXrILZYTTGP?=
 =?us-ascii?Q?OsfcKnW9VNXXK2scn0B73vh6ko4eZI+Kng0RBy63eelgMfUWcukCLFdCK0ON?=
 =?us-ascii?Q?nucRuKQPM0aEHZpM7bZOuSegJN21k9LrlHKkWvTNXiXGFYsJx3LefCIjOigd?=
 =?us-ascii?Q?h/KR4+0si6uxSmAD4ikRCQGRPw3eYHoCGrH/4bumfWdDdPZuaaYPEcMIb/gB?=
 =?us-ascii?Q?QbE4qoOV2WBJM8awBLJZ+qezIC/Cjuwy3TdyxJfkaP4HsVTRODimxhNpSpmx?=
 =?us-ascii?Q?fWkPh1DMvL+7LDZ144m3CwUFIMWYZ71+6UKivV/RIOscr4UPMTJIK7OUYiG+?=
 =?us-ascii?Q?WFa1JN3EqcmJkMStxxsS5bnohBxhkt7oT0ufRq0nzODttJXrq7hZiu+JGo6S?=
 =?us-ascii?Q?GY2lF+pT+U/uewp4TYa9bmOxU103ky4MwFhyec5hmjocovTGk5Ow7MFC5OP/?=
 =?us-ascii?Q?rVZnoWRLVpLYm0HifCsE73PEmlhx5w+kSrNHcjMLEKNKaJ8hDy+6tjaMuz/4?=
 =?us-ascii?Q?VHos+YrOIEEUzFzx74l1XyjH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z2C7g2xU2rSruS9GWw6s/WDxcOi1P8g55gMG7L02ntc6byJ4pnjATZdSU5th?=
 =?us-ascii?Q?KFAuc7sY6joEs5lR+EMO9s256m0jonfJj9z7AMZcAbk3Elzw+bqeKlzVFBGz?=
 =?us-ascii?Q?FhnPYAPY2rtPxTYsiVt5JQKIXWT3NDU3K1NVTHcMy2hX9jtU7AmnxL+dc+0O?=
 =?us-ascii?Q?wppSlEyF0vcBlxBc6FuPVykp5pkuQjuswDJEhlIAgSfF9aSSJ9Pkih2T5iYb?=
 =?us-ascii?Q?XUZ1Ltk4Oe7KjavMlDg0sAaDadbXYRrwnjo5TvFHUFbMsuj53xBZldYeQAHE?=
 =?us-ascii?Q?yfGC4BIEbnFbd3wlz9AhdtRsU4V1V/zE51EA8Jx9Bi9ua+pLfrzLczVH9C3p?=
 =?us-ascii?Q?HpAFFRXKZOn+BlBNj4sYNhJTUfEG+CXKb9e1hpa1PsTziJhTHK4RvUQkruwy?=
 =?us-ascii?Q?djnQjpMjEf7xqXHw930GlGwYA1zSzdck4IWfor5GMOaxJ0m5qSgEv3jKyuc+?=
 =?us-ascii?Q?ie7XbsQMDzMnR0XTBOvqgGNi0NKDxVmGy+b4N+hYaDQLhzaRQMM+sfb+cSyj?=
 =?us-ascii?Q?NROh0KccxKi5q8yG4R1CCK7NSIZu8S5+PQjDWio/3j9y8E52pNyVjuAWQkKq?=
 =?us-ascii?Q?SxTmKKy0Hf9d1olXUow51/kiiM6F1CSFBelLJI3H/9/AFJt3YO2dYvC5WDn9?=
 =?us-ascii?Q?5soqgPB2AQKV5YTSA5sk2ijyyOPUph6mnOaiZysLPsNxAeFmTzzWYOZIO26T?=
 =?us-ascii?Q?uraY/usBWyxwkuhdovZUDQovHCUvF4Lh1McCJ9EFHOVPWy+we72RU/2jfu/s?=
 =?us-ascii?Q?LoX0+zS+Ri+6PrB2sBz0ozz5KPost9JuyutMGMRJrNqSytAGsaWSRLxjR43Y?=
 =?us-ascii?Q?r8owLkkwvCjLvAMRwbVg1lqjwA5rJ6+M9bMd7f9Pnv8IKVnPr2IxclbrKkVM?=
 =?us-ascii?Q?y+pUPFMFsC3wU0aU9yFM25HkRsSgIEN56hSlmIbWXBC2wTBAsXFUTAwh00/H?=
 =?us-ascii?Q?AV4W4TBJNkzjbsJbMQaGuzSyU4N/vgS24IzUMr7NapaKuo+cDXIHWfD5JmuK?=
 =?us-ascii?Q?+gY08eD4rs5Cjqpm6UoZHiU6AY0Q/oiQ9AMRS08L/KVfC3Zmu0i9y9zjtIWn?=
 =?us-ascii?Q?NjaS7bvZL5Cw9kIOpLjmG476vAu3dBfEfKWWWEqNzxsscRP05M8eFbprqAMQ?=
 =?us-ascii?Q?fu8oN9kskUYgro71Wk3E9kwI1azkAXRrxXWF4nhaM3XIDXP6+iAdnzz+hwRh?=
 =?us-ascii?Q?n8CSlghKmmbqOHI8T5L5j/VHDVkFDHkQKvdYve8jSz59uflsYrQgAbrOJ3i2?=
 =?us-ascii?Q?CP2dAdCN1UG1qbNzJyfnOLcm44zltgAVFH/9MT7Rv6X3K1TdfpbFmP19hoSH?=
 =?us-ascii?Q?I03KrJJO5scErcEyKgvI5xvsmmjYVuPQd6XnJWPpp3mbOfaqv0hdKZ6qIhRY?=
 =?us-ascii?Q?dphQWMJjOuTcQ9xcXwURn8aIGdOyzEfV+YMrzn9lk9piO7VxwRg6nspVplsF?=
 =?us-ascii?Q?EpvfttrN6ZAg4B80jzGmA4LVogvpkX9vRZMvTJfFLiVxNR9tqjRLjfIcI576?=
 =?us-ascii?Q?blNdxOMYWVyNhXDpjUMjDs0JpxcaXGuMfFE8QBf/uvCHeDXIEdpkDXiTp9nA?=
 =?us-ascii?Q?azhr6jtAU9P3QQuyudc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69903e20-41a4-45c1-55cf-08dd07ed82d6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:24:44.1582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4OkrM4tpZ5XSpjKPElJZRO3cigH5nzTFailwQbAR7O95YEIygnHpTotk15cvYJ0Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7819

On Fri, Nov 15, 2024 at 01:34:12PM -0800, Nicolin Chen wrote:
> On Fri, Nov 15, 2024 at 01:13:36PM +0000, Pranjal Shrivastava wrote:
> > On Tue, Nov 12, 2024 at 03:30:58PM -0800, Nicolin Chen wrote:
> > > On Tue, Nov 12, 2024 at 08:30:16AM +0000, Pranjal Shrivastava wrote:
> > > > +struct arm_smmu_event {
> > > > +       u8                              stall           : 1,
> > > > +                                       ssv             : 1,
> > > > +                                       privileged      : 1,
> > > > +                                       instruction     : 1,
> > > > +                                       s2              : 1,
> > > > +                                       read            : 1;
> > > 
> > > Feels odd to do so...should all of them be:
> > > 	u8			name : 1;
> > > ?
> > 
> > Hmmm, do you mean something like the following?
> 
> Never mind. I see amd_iommu_types.h does something just like that.

I certainly expect to see the u8 repeated and not use , for members of
a structure. Also don't add excessive horizonal alignment.. C code is
not excel. :)

Jason
