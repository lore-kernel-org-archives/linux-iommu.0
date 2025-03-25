Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF262586FE
	for <iommu@lists.linux.dev>; Tue, 25 Mar 2025 13:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742909752; cv=fail; b=M0cHmjjd7TBj4TrRRz/k07JgDVUGhPtMtljgOd88DEl/oILRgpLqrUOpHDxxWJRjif/ODspYaPPQCDyAEOTGck1SJlZAd5965a9lWrLBWDyaTTuHAKWZxR5jxrJdzSEL8IYeQUlOyMyiN9H5aVEPMojz6x6dMs2x4ShHqP7lggU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742909752; c=relaxed/simple;
	bh=pnpNI+VFeuSKnLb9I6UJJWRyRWygW5kQ4mp25heWz1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gz+2phngicG7Dc94YH4d2qllozPxxrlPI0TMtqq0Vd5Tnx69hmg4TfIDLEVqQlOMl6Na0mQVw2y3OFkH1/6PkV6Cnrm4/82mOI35r28YqEV95xCK/cS1wx8t/uJZVc1Ya39xNs+p5fOxEjCClF8YOTDVjvtfF89Uop+gOTQaSFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cX2/Dj4B; arc=fail smtp.client-ip=40.107.223.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cX2/Dj4B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r8Nt0T2T/Op0PLT7SrwphNFA+kBJ6rsxZPpDHlHErDM0xLxdvc2BrABYshCE8L7MzGzFfLX0EHhNSqMjpHEDImzx5XgaSkyAwNNZJGZCKnx+vqUMabbHnv3VU/0W1rvWsC5kzM5YrAA7aayyYUmFrN+fSyXTJqMO2rFPSpRV8yxwmULTyhjBGLPxfVIcnXFR0fagy6+rkgEcqY5dlzT9xAyHVbFTosTrC6RckVe1cTnDWL6AKQKv9GGkR/5qZB03cogVks6pE5GS2NfDYRfn/lUVfNEYymZmsz8Qlsv02bgjrWlsjyPG9r4CcQJ6pU7dUHr5Gr91ZiRpAcBFcclJPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWwpU3OJXUsXQJw2YbNrcwEA2pkHbrOnTg7K/UlWx04=;
 b=QYBZciwSBv/JWwaMbqWcmvBfmRof7vHR/CWAwzyW6FFYHmflRMJ/y1b4uoXUZXg1WJ/qApTflvymMGJD48+Ase42+sVcf3T597pbhLvBCek1LdHEM21xGGWp9LAL/EO3f62rj4MBTOJzIX2ypfvLEN8PkG6WoEQ7oXsVyHWg6sHhSO0LrVA7QG3tvHyzl5lBBwgj2ARMmvLkZruB083+pYmogRa/Dfy/bqESkaXZUTbIC5qDL4wrpRxA4j3woVpSfv8EkxBOIH2jp1f6g98K6VOGfCOG9jZXpIjStb4jlrX9+m+ruNA2P3tqvAfqnVesru+E499aRT3xzHV6DtDKeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWwpU3OJXUsXQJw2YbNrcwEA2pkHbrOnTg7K/UlWx04=;
 b=cX2/Dj4BQRg6qxY+oR5zZgtEPf1HkXnFYfvMNmSj4aA4vEwhLGyI+p5JapH1YdimmimfA8I0Y7vjhku4MwGwJOoeY3uytsgIDPdIw77xqNP/woAXq0scZVquT3psP+oXMRvcba41o+Xyywi5ui5dkS/5T3TsC54uiWTts/xtFjvphxgCj9PC4YjHbuWmm4catG8WMNItglzbfBWhKDGHfihOjaJMOcMU4m2GUfoIJvsalSoHJQ3tMudxW61NCaYHFjGsS5+2nsSOVj/D/6cyoqT9Zy5iPvNyeEqtJNeYjkVvIxZ04BBUmvZRaTTqvTCwNPsfTQOruSY14aB9yLQjOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 by SA1PR12MB7342.namprd12.prod.outlook.com (2603:10b6:806:2b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 13:35:47 +0000
Received: from MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f]) by MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f%2]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 13:35:47 +0000
Date: Tue, 25 Mar 2025 10:35:43 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, nicolinc@nvidia.com, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev
Subject: Re: [PATCH 0/2] Two fixes to vevent path
Message-ID: <Z+KxLzIFFNp9A67E@nvidia.com>
References: <20250324120034.5940-1-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324120034.5940-1-yi.l.liu@intel.com>
X-ClientProxiedBy: YQXPR0101CA0043.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::20) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8663:EE_|SA1PR12MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: f506733e-ce8b-4f1b-25df-08dd6ba1f343
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EHYxNBPyvaezcgIoVCwDXiPsBwyhpYKLPVX4q34pGfwOkOSrICUU74Bo06Ik?=
 =?us-ascii?Q?OdahCoW3ade1Z2wGhwCb10ax9nmFW0ZvPBBV0tjzaPxOqx1X9HCsNHzSn1A0?=
 =?us-ascii?Q?9S7C3pVMAexc9AGOMBBvPPmq9JwxQQU9C6aV00RzNmyaGy8u+LgRBlo8TnNf?=
 =?us-ascii?Q?80+3Hv4KoCgEYafrvXB7qCk0u57dJ7n7b7Y09A2RGyo2LpVjDaByqz4Wi935?=
 =?us-ascii?Q?G6aKMmvObE0If0t5Yan1vRFVvA83n/NmEZUT8SkCzPo0dJhOLf5/8+QHNR+S?=
 =?us-ascii?Q?8OUEuPiJk8RCmkrDUWxwRnSY1+8DKaONy8BZSsDYqwnwNdyDcn8fhJ7HsJba?=
 =?us-ascii?Q?JgRIXVSEmYkNUB/4k+mz7zk1wo88hHEJiza7aAQUgtVR44nlZYUdIaH6m4Ih?=
 =?us-ascii?Q?mLfvw4FFyuCgmZTfjGG+sAUL9yOWiKj/UPCjt0MdS6JdPK9Lsy4JFA8uY+Em?=
 =?us-ascii?Q?vqtqvHP4HuDP5RA5vvbUbeQInjWyV/QhxlbwM5K7M9HsEgfR01zuSNs3xXSw?=
 =?us-ascii?Q?MKPs0jx0g4IJ4RCWq7x+i+mYslvz3szyXjN/mR7ifpfwjBLJD0PWBYCFiw1b?=
 =?us-ascii?Q?QpEw81yQceYBfdPv5xAUq2XZw7d8Y119JHlwqI7+WxWGHVbg48/niYUSIbDi?=
 =?us-ascii?Q?DyZW4W6e/HphsFSGOOu/6zyJl8YSHgENQi/0fVnd4bvkRz1AG6MHLYvmbden?=
 =?us-ascii?Q?KLQRabO6o8u+hFKTDIlFx+JHXO+AEjumcxdSLdeIzFsH0E6SNoAdMaPg1qDx?=
 =?us-ascii?Q?8MoaVuCsMjMwxeO3S8Y75SuqqzqrB7o39fEXbz6nIGmMdlvDE9UYi4DNxpbj?=
 =?us-ascii?Q?xMV9jIAHWFZyuwkHeHUZUrFM+g/Q7wfO/4PNzTcaSSShe0x4EsX8E13gRRcC?=
 =?us-ascii?Q?Mxp4VjU6RdKrUVD4lxnNyVAQOJHjrUIKnIVMMXdU3+3mFJ7npb3NOCAq1Ltx?=
 =?us-ascii?Q?U+OHzHJ2qXcY15jGg3e0HUBo86mScHyY19cKazn5YC4Xsxrex7DNSwMz/08K?=
 =?us-ascii?Q?5rOQSObb4Ddw/YZta5IlKLJHBu0Ytex/2sbF1YjWkrYlpxKM7Xbwh/WVtEMR?=
 =?us-ascii?Q?ifbFWcjOyaDL43WhA2ZoYO88I5z/uZqU1DLrSDlAx1HCkIKo9yNg1A/tvMp4?=
 =?us-ascii?Q?TxfodS2yezha32Vq/tPMRCFwfRF3mGdPIdMJvYawWfrMhc4+hCulPI7V1ppx?=
 =?us-ascii?Q?O2MA/QJwgwnHW7KFHmX6DoKT5s+10xP92BhHF6jDIUwWInhKq+Hw0U4sgbA7?=
 =?us-ascii?Q?hbtYhQbihwSIFlhDK3oKU3BbqpglRTIZCX/5b7ctqroKPG4oM+RGvrrmC084?=
 =?us-ascii?Q?etvSBw+S1R53l3a6BpXVZQEf7K302ydq+hRdOktlG7DD4gAseO2PhEaxGN6W?=
 =?us-ascii?Q?AblyAGh2hba4+kyl2LaiIHRUHXco?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XYfVS6F01a78aW8jt8Esr+tAy63oru75kO15s46BmVBL4fQGTPWQ0+HRNPFV?=
 =?us-ascii?Q?DRpRIKSi2KYKh32wcGAkFIlmFoSyG+tQyDTeopnE/4zq1uLpyNzzGuNhhCbC?=
 =?us-ascii?Q?crhS7ot40jkKTy6BuGa5aroM3zgOGivzgITP98kcahwttTNM2c6BMK8z72Zb?=
 =?us-ascii?Q?TpuCX/oBqBv5VehAt7ZvoaRfVBXYUSNZ9puV9viw0qdxSM7skBLSIGyk2SrQ?=
 =?us-ascii?Q?cvesijHgqqqQ8xXsl5p7b7ZPfwkzDkUQLFCZZKMCo7AZ6EhiSC5cuV37L0bU?=
 =?us-ascii?Q?FPFpGnQV9XAinsMLRL3btghmwrcJvF5gaHGqs+awn3hXVG4NubtemG9k8xev?=
 =?us-ascii?Q?dboOshEkogOJD9YUryj3k780DOBszRyg7LfMdyIH2RlothTxuQtplGquSMw+?=
 =?us-ascii?Q?CR4MetnMsLIdpDSJa2nU2QjfqZH3aN2oEFO8SyoxByDB0Ls+StqekPPDFIkn?=
 =?us-ascii?Q?+rE0+6MDSTdiN36LSuL8WAkQON7natEof5Buikon7ExDAanWLe8HwkYSD3Gg?=
 =?us-ascii?Q?aVzql3rMtHqHUQydfWXtkAcuQiEyalR5u1f8uECobfKI1Qu6D0uIiyviE+D+?=
 =?us-ascii?Q?St4UStgLJTJX6MCxGfAwbbWdwPbFCRUL2uDP/0axYR7aCCu2aEqVws90NjzS?=
 =?us-ascii?Q?osEHHl0j3XLk5hpi5kbYwId+3BHQH/ji9ewI5L1HEkZE7cbMcxIQM035NVnO?=
 =?us-ascii?Q?xmJDbhpRqTRam6L3Ynt0fe1vFmY9rmBoYafXZi6nXSOm3cMEzoRmM6C78DoU?=
 =?us-ascii?Q?qcLismt5/Aper2NhJTQkDwaCBBXvD4N5YEwbTr0vdhmQNkNd+fufM7NMhzL1?=
 =?us-ascii?Q?iH8/RB7sxfF6TaUXkHnUTqH8DykC1TDTkqxVtfP1CSkWN00Lw4zK6yPnxNTQ?=
 =?us-ascii?Q?vgo6FwgeilL8IrfRcv7oZgt510WQPMfHvogBlNO0VhjOy6BszUb47H5+Nm6L?=
 =?us-ascii?Q?S0WzHloRhHwPolhRLAtcmtLo2KbUgOKT6ElDUWE81d0ZSasC97EE3ZSHdWFq?=
 =?us-ascii?Q?KRIGgpJGnhmTK+UulfM0X3jI1h1N/p3KFa6d85bPyPmh1m+vbVCQbF8+yL9x?=
 =?us-ascii?Q?MPNY1eBwORljVfjeRvTF43w0yM0tqsgMyW4EckOZ9CDPOsWA4V2fqdIOlLro?=
 =?us-ascii?Q?gNvxMNr5f6AT3fHZ/OIdzNdXhIDkjky85OFDo30V7MG03E6eo/FQFJPH3cu7?=
 =?us-ascii?Q?uS4sZxMzl2fXrwKDNtOKL2iQCLuBTswZXR6TscIge9Zb1pcwo3ACFqDRhnWQ?=
 =?us-ascii?Q?hN+lB3CgZqSjM7SlBjtq7sKpx0XB0LSUAZ7ZnSfij42/RddU7qKk1Wje1oG1?=
 =?us-ascii?Q?zPpHk7ZLF7CoO/m+YJwZWgL+xsJ5mPLR5VLxKfIql24i+dDWxoF4y41+ZhTX?=
 =?us-ascii?Q?qCuNSL8dRj1IMz4oDCMK+zehjWobpu8/GhXJYW6POdI2jvzOXs7IHWt3wGH9?=
 =?us-ascii?Q?MC4XUkNz1YHyROViiUlGECmFLk2iFcpq+/vT2z1AsnD4+rsHTST6Xxa408/B?=
 =?us-ascii?Q?578AnOF/fEl5/tYE3dWEP31x8eciDB2PQyZNdhCRgwDE5qXe8L30Lpyyi5iO?=
 =?us-ascii?Q?9q37JTAZDOcYYEE3d9M=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f506733e-ce8b-4f1b-25df-08dd6ba1f343
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 13:35:47.2873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6Cpam4DzOqEbS6ExknBzSnKPqiF91cBJMoplhu96dY1gS5ziA3yOycgTR6CZE4O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7342

On Mon, Mar 24, 2025 at 05:00:32AM -0700, Yi Liu wrote:

> Yi Liu (2):
>   iommufd: Initialize the flags of vevent in
>     iommufd_viommu_report_event()
>   iommufd: Balance veventq->num_events inc/dec

Applied, thanks

Jason
