Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ACE40BF2
	for <iommu@lists.linux.dev>; Tue, 24 Sep 2024 19:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727207459; cv=fail; b=FvTkC4dRN4k+biESmtzS3CjTW2LBVoJjPfSFG8uAsVUF/i6r0cIrjhJ2fNg0Va2w7UoUsD/2EXoxS+XFXfkKUWc2d4jKgyY/9V9zUahKd6p2XaGQNgKmjBmWe3IT8Sr7sXTQwCOJba6gLiMMN8IseGr6aRJG2hkO5KsEs7IW7ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727207459; c=relaxed/simple;
	bh=a+e7jxRxlt2QAfTvoSerpxNYPuhArHYIcafwxFPkY2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G0cNSh6WZhjwLTsuJguDG+yUgDf1AGELYyBEQ+I62jDIz1bchm0vil+S7eBt7cyPPEtNJLMpZESONdOOmQ5nqz/o5Gcuv1EeuNWFtYbtM/K4HdJENXgwCWOqdkXuo2oIkJp5Lm23hme0tgVUK2TRPOLVFmFB7eMRHTfsvvSTvdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KCTVdUPI; arc=fail smtp.client-ip=40.107.95.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KCTVdUPI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KoxT/QP1wCNx/dT2kHbCx2U8USp0n4Wag22Gd5DV1YG8/g2cj9PKvvVKDBi66mf1Mn67j2QbwL2oztNfTVG550pYBjbcvQSh1u9tkxMpHzuhqpVP1idQuu2VBNNpSMgFGcccpI0OIBeqSpH+K3rdRibKcFxDeonqvNEXHdNtfju/j/UwG7IpdjmJyOX2PJohv0vccD5zz1Kt5sxLgauKXVnECtJ2uwK/8e/jc2xkqqYTOe8aZb3wwLCmt3LKEfHi1BDopBPDcijf99anF+nC9b3jvUvNbhiaycwrH4bFmzgv44AcP1AiQch2D5L5Q8Tq5l8bNJJROCSX5riQ6zDzzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yt3q6WuMf9KGpIFQaBhmztVhB2fkAJ+GTgfHhafMheI=;
 b=Yn0BbHL+2rOdRPbtWJtOiYH5qE2wuEw4scXm4fTs0I8zb4TZflq7CaWmgDT189TrcDDJb/ABVgsz5HyuKkCkg6S51jJAWq9tiH4+oruZm6Cecvryz2y7YM0w4lkfU8InNKgZxy1Gonil2uzyRLj9vK7739QjwSQU3NxUBVrw5itUsGGaRmUnqEYTJb4neST1yn6yFMCeL6ghe1UF6vLXPAbTy8n7ON4VFkPdeh+7Ghl3k0+md+KHxdOKU/3kJG53f6TZOSZWtoEvb4SXL+CltnsywZG94u9jsop4T3FEPPkU+2lk3DIJCFUK3TqlfEImGfzRuGUu15SNkbgcbiRKSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yt3q6WuMf9KGpIFQaBhmztVhB2fkAJ+GTgfHhafMheI=;
 b=KCTVdUPIRzHccZNABmES3zxMqY0xy4qznPVc5GkkUEkaOGWx536gLXdtR9J4mw1GxC6Fv1I52O56HX2yaELLC55QLOXf4FJFb5WhW5mrtIRi1rGNIBFEYD/111o34YBVu7AqIWOG9Ls50YvuHD2BgrHq2s7yf3gqNzVnxydtovv9VGjqQPisYuccd6CGRUZgb2b2rVnvzvPwFueiIQvqwPCtMkURDX5UKmkGYqHr2Uncq8Gk8UN84Hfq2FEOB3I0Qs2jKutUp3I1KWgrdGzWBSkdzMWzdQdj2sYgdOcxEwXrl6MajgFQKXR7izdHzDrBDn2RqR1Z1xgvXNQpXQjYiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV8PR12MB9133.namprd12.prod.outlook.com (2603:10b6:408:188::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Tue, 24 Sep
 2024 19:50:54 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 19:50:54 +0000
Date: Tue, 24 Sep 2024 16:50:52 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V1 2/9] iommufd: remove uptr from iopt_alloc_iova
Message-ID: <20240924195052.GN9417@nvidia.com>
References: <1726319158-283074-1-git-send-email-steven.sistare@oracle.com>
 <1726319158-283074-3-git-send-email-steven.sistare@oracle.com>
 <ZudGjUsw17YDggfz@nvidia.com>
 <70cd1f1f-95a1-48ee-a5cd-97a5769a1210@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70cd1f1f-95a1-48ee-a5cd-97a5769a1210@oracle.com>
X-ClientProxiedBy: BL1P223CA0010.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::15) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV8PR12MB9133:EE_
X-MS-Office365-Filtering-Correlation-Id: 0306644c-3ded-44e7-0c60-08dcdcd23318
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r+gfn3kBuS7jIINUxWflIO3ui9dFquhV68CA6AMC+lkIl3qcWVi4OO5xICy1?=
 =?us-ascii?Q?RP+qhdYnoc4IIOoblMbcrg4awKLFYhBkr8b788HFK1096ldHvo7rfP1QfOCr?=
 =?us-ascii?Q?GR27ttxfHH5ndfagbIjDS7HCA1FO05xp/ogI7dtXv9v5KTEtPJ+yceOReNvo?=
 =?us-ascii?Q?I/3fL8Z7r1T7jzKy2UM4nklI2eyJ5vMV0sGvyhuZtwEzf4bLvuzYxYMt4ZUe?=
 =?us-ascii?Q?br7nfH0fqCFXC8j/BSir5N7RyQtVXu7qjzt1Z/80OGEaSdhLiz/TZH0W8CGu?=
 =?us-ascii?Q?e94hK2q6HAxaHa43MQaEJacJgW7Ost91rsJlyJOzhzvtYa0Uy9xGkOPd7vdw?=
 =?us-ascii?Q?jSUclp9S8NX/8Ga/PQU1Va03Evx4oDRwdAX1fFrEPYFMMx/m2sqdUX8pA9ki?=
 =?us-ascii?Q?VceHIaeESbnrAykIamw79qqNdiSZwMszBh2q6BuAXK+1wfvpxgJXMdj3gsKT?=
 =?us-ascii?Q?r3U6+k0Y5Rp4ItAELBcS7nAK9UgDR1UXMQYRFK1ZVOd1927GnV38vwO76H82?=
 =?us-ascii?Q?ET92znwgS0DBpXhycvxd7hFcLZ7YWMydU4ray7Me1MmGVGCg4Pv6aQe2ts9m?=
 =?us-ascii?Q?EvCN32P9lPFfGKMLQLpRFv33loZdcO5OYOCKv0T0Iq0YoA98BYbS/1BPw3LT?=
 =?us-ascii?Q?ILm35HixnwLw9V861jM9dBJOhv6hWiNjonUk5m6nMB/4fq1nICuNjpeHRJ9f?=
 =?us-ascii?Q?vc56yAg9vke0gE7Z4fsSxGxweWPv77BbXP7ItsNaCKy4kaJIhh7BKPxksFAq?=
 =?us-ascii?Q?Wepl1nDDbWwVvyPe9v90Mkn84St169978JHCSBgXB60H2Gt0gEt9pZ/Hlu7q?=
 =?us-ascii?Q?zme6Ga8WtQ6c7m6PyZ+ZYxpIW1iU1Dy3+em7L7IoKqbx8jYKAj6MCTusK4yk?=
 =?us-ascii?Q?WY/C/P1NLqPjOlspsQq90XhigS4pa4DYCZw//3d+bxKsyDP92S2S4ooOxJwL?=
 =?us-ascii?Q?VaID3If/dIBvl4JUklzgR/VKJj7ZelrGyy4pqMRokOYbpVu+P9Y0p2HZ2HeU?=
 =?us-ascii?Q?p4XusX29hL/Di5Dm/PUNStmaJ5UFJZJ8uF/kZ+ixjPdliHniD2o7TInDK7kN?=
 =?us-ascii?Q?EVJ+4nlhFS+rKnwy9HKIOrOJXEMFGLIKqstp2Esuc1pj/DPmqwKcRmHOwoU6?=
 =?us-ascii?Q?dPf7cTKwFBUz6zJvzrj4syHVQCGLUoGmLhmJog5zEv4oUIJ5BmljYHDdkoxG?=
 =?us-ascii?Q?4TyXF/4kqwQ5n0nFiK+qcIEUjq4haYq/hfcoERqAOezRvM0LSKHa8uuZzGxQ?=
 =?us-ascii?Q?T8hHcUWbxYxmWg3w+P+mZ36lqlxzAzh5lohKc3gnxfV3v2hUjmgG/Dhvlgnw?=
 =?us-ascii?Q?1IoO7ftg3h6N2YXrgXKYZ/0bC0QnN6WBbZGIwb68C8Vrjg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ulfAhslIAE9AcAQPtQ+m4DzK4tDX5+Oy1pd3dY7srjWUDQhgH2+AJ+snMxLL?=
 =?us-ascii?Q?O5hpIAEedCOxP8pNgRbKcuIOPs5DeAswnXsHJ5Ydo2+dEiJjREgqR9DWr0Ut?=
 =?us-ascii?Q?iOM+iLUsq14EjdbTuy4eTSy4EIKVNKRPcDClxo0Cxrm9HOgtwijjrxQhc89Q?=
 =?us-ascii?Q?iZDNsv6d9FLQCvp66RuW+cOvLLPq9DKttze/zbBYe2TvPlHnFAN1H7/64WUQ?=
 =?us-ascii?Q?0CpsdUJD2uzpxfgkIB0m98xy7hhI5xsL2kEPq6cO7OmAIEiAQYnf+nid2xoV?=
 =?us-ascii?Q?JxET8Ai5I1npcgTd3HX/qsdfoLITI5VxMgOjx754OWuHCUDRtpCic9jfaDvt?=
 =?us-ascii?Q?GyDxpK+f4ER5LJRWKf9mje56IzoP7OO6ZHXbaQgPm2WflFf6O+ooDZOLkT4e?=
 =?us-ascii?Q?OPe7mR0AwCO3ZVIJwTX3MArn3HLMjfQ+4fSeITTrjKklkTDKHbGkjURbirhb?=
 =?us-ascii?Q?Vd8fF9zuZ7OWmeNLEvusNWie3Uo28DokRkVhyOPNuzzSlALtVpKLvw+rrncU?=
 =?us-ascii?Q?YcFVNGuqPt+oNHltxeRBEAVBAinBsdQgHYyvDLiNRizeiGLNR3wEUKlU1zCZ?=
 =?us-ascii?Q?iT0E/U6oGrH0q3A2VPyRC0BP5eb3qSfA3ZQdqgzLUQbrf4Kv31P3ZPPQc7a2?=
 =?us-ascii?Q?tPl01sEjne2HAuU3zyTIXrcDbJn4mGu1eu2t+CXIW8nTM5TryRGgHxKMHFtk?=
 =?us-ascii?Q?uQ6Co17VQ6WbEkmrbwnTj1D7OouE5e4HXhN4/21cTWhnH16sDoNPSSdtlTVz?=
 =?us-ascii?Q?HrjAR5SQS1+Ko1WN/7SIpTrBAnNmpeDqiXosLzbZ8jcxEEJXpGtTY5nhfEWL?=
 =?us-ascii?Q?pdEBA2esJHkFZ8JreSG5QmrnJnLeANv/Rt4zNkC3FNuOSW6d8oGW+35sj6rE?=
 =?us-ascii?Q?UcvObSuVkpCoDB2vajjYRUvr3N0MVt5pgn1upQnaRUl7xVqNYXP7yhHXIuaN?=
 =?us-ascii?Q?wKalHZROJTeVwq0J5RA3JkdgNdtXHWZ+B1RrMiUh7jzb6Oc5PV694aHjL38G?=
 =?us-ascii?Q?KpFDi4+DTmoDmYO5MFTWT7+qbMI8JzQJcZ8T9GnmLNo5+FJc7ODcDMTBn4Cd?=
 =?us-ascii?Q?606Dc8j6LWmqDrOnSaqJQ5cnM+QLj3NSm9+vxZWOTj/43p8eDUFmrmHbCXBa?=
 =?us-ascii?Q?7L/ECwBD1IKHxUzk5+/eSLYT2DzxlJUDsJDsH7jlDGrslVc8g/1jD6j2Xkxd?=
 =?us-ascii?Q?aGpgUzt9u1QK1KuMhy2HCEbkh/lZqt4/vXdtjqi3HAIZpIsYMqs6bpQWehCK?=
 =?us-ascii?Q?/n0OxyzJ9CtzEOIIjgwFWiowVyP4Th+8VwIgVTZ+ZaJjuHJEoLWjHUUxVyZu?=
 =?us-ascii?Q?Wh1i+KFGcahEMbYEPBCp7pw5T9Js82MWttKR9OKUPsx6esfVcdVOXE1GRFEU?=
 =?us-ascii?Q?UvoMKGzxXgQKkkXBRa0j1yPweInPHF7YfGTbjb22Riex/jwh+Tzz/ZEI00wm?=
 =?us-ascii?Q?davyNyxguuCd6MIXDLrP6vJJS4n8wMala6pYuTxo64OLTpKFudQjaSyf834p?=
 =?us-ascii?Q?5MXLXvqgjQwCRW1Bg0AGI7EXzoFGWFnL4sG/13qU3BzzsnaOjWLVecLuYDQq?=
 =?us-ascii?Q?vgnZR7claULozIm2+pw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0306644c-3ded-44e7-0c60-08dcdcd23318
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 19:50:53.9956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AhDhPqhXZaDHd7fC8TYscFELVxSwlMNcurgKIJ62D9yQfnE0oRZMMv3D0koaKdSM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9133

On Wed, Sep 18, 2024 at 10:51:32AM -0400, Steven Sistare wrote:
> On 9/15/2024 4:41 PM, Jason Gunthorpe wrote:
> > On Sat, Sep 14, 2024 at 06:05:51AM -0700, Steve Sistare wrote:
> > > iopt_alloc_iova takes a uptr argument but only checks for its alignment.
> > > Pass an offset from start instead to eliminate its dependence on a user
> > > address.
> > 
> > An offset from start is a meaningfully different thing for this, it
> > throws away all the information it is trying to extract (is the uptr
> > huge page aligned)
> 
> Interpret offset as "from the start of the address space, eg 0" and it
> works. That was my intent, since I pass offset from the start of the file
> address space in a subsequent patch.  But instead, I can rename uptr to
> to address and describe it this way:
> 
>   iopt_alloc_iova takes a uptr argument but only checks for its alignment.
>   Generalize this to an unsigned address, which will be the offset from the
>   start of a file in a subsequent patch.  No functional change.

Yes that makes sense

Jason
