Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010042.outbound.protection.outlook.com [52.101.56.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C6727874F
	for <iommu@lists.linux.dev>; Fri, 10 Oct 2025 22:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760135920; cv=fail; b=RNTjtY9yTyAn8081rgTLR468iJn8zE1j0yd9ofGP+UInHZAfCs6/JhBk4zL8Sn5YSi/0vOJ+0qk1OwTemzynFHO14pG+2R6TM8yDOIpgKVuLy/eqmakhhnpTmBjsbocTdshtdC94K1V2oLwK4RTCdx/zsnlFmBtvoSeZPeivlWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760135920; c=relaxed/simple;
	bh=O5JILoSQYcpxXoOQx5xttDycEarp8vIAHdi11FHUBOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BspwqywtKjoGL/kkWGsWz4B1RQOt5AHiGqRwmfgsS9xTEqUo0M1NDTRkFEH/mS1IHiAn/2QaebV3zMTI73mYeF5nIa0KXEbEWU+fMUzvt8RuNfsIJct6GDNjHD8P9GE3pK5OsSCDp4o/NKobpTPRf5A1ozB+NPYSCyKl+R2DMcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bHLQD/Kj; arc=fail smtp.client-ip=52.101.56.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bHLQD/Kj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J2pk7jJjou5OK6CF1DG9W4RLxN/H2gOyAP/pRiYB1p78x1btGuXwtJ/a24ROUqEsUfXDwMfXTvWe/TLLmJC8hxqJVMI+W21N9Bmo4Zb7WLU0R/GHxQk3nhNaTNSQwh0mb61RfMjsAR17PXyIXfGJ3EkT/IE6IJ7tHBSwhUFZCnMOdsoCsbuvQ7XAfkiUpZL24bpc1oJYP7DPjBz50NzXvlihyYTHjTDG0LaTOcxpoL/gKYJN1+Lx+tqOLxozralyjscujQvbtb8PDf2Dim0F5mZ0UVas6kES6sr7vyUvADzDxQjwd63IMsBD/Pzq5oXbgkdrsF7XWBhEnJATfkrcxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/d8FHj5/vBCZYpgMSbFqlraV2kYSN1A0b1BDM168JjI=;
 b=fbX/FJgMtenE219oDrqy4vk7LHZ1z7QYkGLv+s/zo/CXJQShbXHwyb5IxJ72tz21KL1N6uIP7HVUeq5pqjYB/mcgWSXOZvU/10rndsLgc+sT7Tiwbr/BXD9QhXjufp4YqnUPXs1vhz5en3LZO8qzkLmyALEhQh+C9NvuYtzYGRUfy88Fd3P4Qgh6L0khrSSWMeIz4n5u/nJdCzCeSOUjGi0inEmE+cAMn+GwsgOvJwcFmIDKUjxYgnTCDGtUZJ5s7AqmfiR229jhuAYmUlB6RMqVcBXfL1JxPmaT2v2LNyDBLb7IukNibsKb6UNeVtwqB1XEqrnnrw2209wNDcrWqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/d8FHj5/vBCZYpgMSbFqlraV2kYSN1A0b1BDM168JjI=;
 b=bHLQD/KjtMpJ2ZLz0AAVnsB1RdRcA0HUe0t4K6YEjKZYjvUyef/epzDjMUfpaTiIvppGtIIp2ymzGoJUq9c6UIMp4qf6C4WwJuYO9GmCBwClRfo9QVTfQQrth8Ix3UE3Q7DeNCoRqxXlk4iEzHRB0NG94a/1s0FkwGTBdBVOO/IVdtCh+BPSHSBMYVexScMaCgPPyPcUjBXI247U8VgsY+dbsCh7yLsmEkODT1VxxhBouWZaB6mU7qNtjiRe6nT7mbPwcvCI7b7WMqKv0CwUlUSziKYg9D8NtTZL/Dku4C5GvOU6Nw72E40YTdhU/g6Nzx9Fmv/oEiBEpxDjl02tig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by PH0PR12MB7887.namprd12.prod.outlook.com (2603:10b6:510:26d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 22:38:35 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 22:38:35 +0000
Date: Fri, 10 Oct 2025 19:38:34 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: nicolinc@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	will@kernel.org, joro@8bytes.org, kevin.tian@intel.com,
	jsnitsel@redhat.com, vasant.hegde@amd.com, iommu@lists.linux.dev,
	santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
	jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
	wnliu@google.com, gptran@google.com, kpsingh@google.com,
	joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
Subject: Re: [PATCH v3 10/15] iommu/amd: Add support for nest parent domain
 allocation
Message-ID: <20251010223834.GK3901471@nvidia.com>
References: <20251009235755.4497-1-suravee.suthikulpanit@amd.com>
 <20251009235755.4497-11-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009235755.4497-11-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BN1PR12CA0017.namprd12.prod.outlook.com
 (2603:10b6:408:e1::22) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|PH0PR12MB7887:EE_
X-MS-Office365-Filtering-Correlation-Id: 87a77171-dece-437a-860a-08de084dbf60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dm8/eT6a5Gfe0IxIM/nLRBG/3IyBJxFOUZrfHbn5TIbZV4nsWP2plQVQQaY3?=
 =?us-ascii?Q?n1jDhQZVYGI8/1gWzNkt4PuS30pH94+65t3diVx5o281Etme5f/bHube7dJ/?=
 =?us-ascii?Q?ThtBqMkSvqV6kfxUlWxUqDVaT0WdRLaJZHyHlFD+qXOajs0O2TnRgtczCNKi?=
 =?us-ascii?Q?MlVj3vtHEHNiK6pYTLQwXunT55FQamBp6N0QPlb7Hrr9fyfqn5tSgxZ5II7A?=
 =?us-ascii?Q?hMRv5f8kXYb7otrxvo/DnVskbbGIIon7Y4J3k52Y1R3sy1a0+msb7ciiZlZb?=
 =?us-ascii?Q?GS70p/U4LNdMdVWAfH7QJ69ecBUmD8zCeS6vBunezOpalRf9QLs70zDDjIl8?=
 =?us-ascii?Q?+pZv7Gdx8lZg/YGMc3VDNVL6foGnU/5+hkMrlfxffZAUTqtaP1ke/1gVsasA?=
 =?us-ascii?Q?KqZj7jIHuGHT84N79+rjV622pR9kVf/HkxERFYRFamf+4/SyOiOUBtkHN1Dg?=
 =?us-ascii?Q?SQirzqCwsU8YCx/x+ZTtMLDm13P2O1M6eXLSzFV23THiZH33OLjc8VT/dqXh?=
 =?us-ascii?Q?qWJt84hopjp38wdXx1oa/G7ty7AIFQ8pSameLY2lk70mUT1pM4m4T7uXybmw?=
 =?us-ascii?Q?LCPhViPlDh9mnSlK9+33eBCesA2xho9AGVRB4jS8eQ/eidyowQ37HnhifcRo?=
 =?us-ascii?Q?kDnxx4GDH0hHZlSaTKlMCSKFc9XsDjbSJHb/94EHDgbCoNW7VRgo+h+fvsqT?=
 =?us-ascii?Q?SjBvUCxnwjI98aIUDJBv/ynYdzDGlHfApa/+mZr0Qk9fyEo9lT29Ii0zJLEo?=
 =?us-ascii?Q?EECKmLsuvnCay25mkYR0eXSQ7elvs9JfpVVcB2DxEyPMA6ipY7IUF/KK2+lW?=
 =?us-ascii?Q?aDxoxtSmAb2kK9Bu9wpPWKESkCEQBIJzT0ZEe7v7CDwJqAb8V8T1cjvKdjZ+?=
 =?us-ascii?Q?M8ENF0eULTtMct/ySI0aquHoK2GBCn7EZ4SKHMnjeakcmm4pEySV7ftVbKqu?=
 =?us-ascii?Q?lOygYPXLvYwngEshgUha1GAO7/Ggy3H7Q6igcJyLAv2DUjmbQLLv84XQpR4o?=
 =?us-ascii?Q?fNvz1hr1bxdercMCGmaLyaLAdMAyUX1mWshqhq5r8P0zn071zTZhxkzoyRZN?=
 =?us-ascii?Q?f+EVapvDvc4zcGZOs7m2DqFnB7s4OppHQxcWptPKVOxZh8v0xHZ3BK4/lg11?=
 =?us-ascii?Q?HmJX3cOmJovoKMfoZtJ2pxiqe6rhsTvTt088lI0anY0+FW1ESh8EEzPyPS7p?=
 =?us-ascii?Q?+2YHyrrjkJxlfbJNDG8IjuH2E1gN1MWdWInriUH/eMbJ0vAjXLtUMMMw9PNe?=
 =?us-ascii?Q?jUsADGy1PVR9VJUh7ZuYUXJbW0jbv/iAapcYMRbc3ICImftL/XEXu9CRTct0?=
 =?us-ascii?Q?y2Lnt2vuqhrfySVB/TtzvZTEIz4+4ZJR/TqcD+PDJad0C08yE0RWjQKwhwOx?=
 =?us-ascii?Q?SBooDIQsmFRNOlTBdwqB3xQmtOE2kDt0EIqZZa5gEOkjt1GLfRyac+Vl3Q1U?=
 =?us-ascii?Q?ZGobEZlli6PpzPR+NriyjTWZAn6bwD72?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B1MX1Z/AnfibRUQGxcOdomGHsx3e/WLEK/IwtluPeHLL58orpTokqDoI0JdE?=
 =?us-ascii?Q?l6Pc3SQOQB29fjWxBt6i6a+zZuSLl2H++eK4V4ib18aIU99FE2fSRlVHBP1O?=
 =?us-ascii?Q?+PGSorA+GmHSTgEBKfoTfrptCN7CMDSvc7Kd746+tx+xng0U4CAngZ0aqQEl?=
 =?us-ascii?Q?37/pAzBO99RIPo4owb/aiowB/EuJfLqcw+BF5ShuGFgrZdt7CIZBFXbFs5IE?=
 =?us-ascii?Q?cs/Fl17qrqiQW/XLw0w39G133FEU+YvgqR41ccsbECT8DRYvyaD8iwm9vGg2?=
 =?us-ascii?Q?0jNvKrmRCyWzLV54GF66AtIGJ6CHl2rplWvEnte6vMdu3eepJKZE1pa+KnzZ?=
 =?us-ascii?Q?heC2NgQHBiaJgSxsMaOSJXGaaKvKIa3Qso7I/RuaNRj/Q1ccXOmsi3noKEVj?=
 =?us-ascii?Q?2GQ3WFXZXqIZvRVD4Ea2IpDch5EiJ59CrvM8sXLQFM/6IM/OPEuff5VHc5BC?=
 =?us-ascii?Q?m7iDJaGAFHHb1RrJVE/zsEaf9ak13xYnb1JwwBvGFIX7+xj1qaVsCWTEC1Qf?=
 =?us-ascii?Q?lpd6YRRC20+wBVRlwfYpW6DnvQj31mn2DVfrrx1hCaRspvYc2qA2vrgADwnd?=
 =?us-ascii?Q?STCeuH3dIpOkeaclkbELGjEpvxZszCv0YjBQJS8EOZ5KFxJu+ta1z9aiicmL?=
 =?us-ascii?Q?34rBuyPeuINHO0d0JK0KGUSM+3R+vGkAnbnNK6PCFkrCwAAAdX3USuSRd+Ok?=
 =?us-ascii?Q?6+KsVQztgIRelUFcqiTaFZw8wAWfDgrvHXc0I5CQOnBcmerRmED9lbKVcnD2?=
 =?us-ascii?Q?9jMM8wWaRWgzS0hS6rxQEhKweOPt+xfahxitSPqrPM81l/tl1D4UjZ0MWi94?=
 =?us-ascii?Q?SfXngMDH7lrHSK7VtvFjUrdNDsbV0s1jlnUpTZicZYyOufTEeNmqzhXjfm1T?=
 =?us-ascii?Q?WhdoEJ1wFPekNUw1tFSfRuTZa5XV9B3yXRa7GuYI4Ur4iV+Dj3hccDSVmexB?=
 =?us-ascii?Q?o7KbxKzcy+CJOvdMeji665WqDh4VVO1Nn3bRIqpR3fmbYRXxwIr7Pddm1lvV?=
 =?us-ascii?Q?6jE1Rz9SLa2LcBecs8n3gYZZG7+Uhl4CCSuPSfnkTRCGQueGZCr0JWnxNAKR?=
 =?us-ascii?Q?TaalTH1MK4/DiXxlrG6c0PsdnXpNH+4K8+ZqjG26StJqHo/J2Msr6TNvPenP?=
 =?us-ascii?Q?YnJkFUXd0c1AZJqAygz6r8smPSjTUe4yFHHQCKgsY/n3XyLb9O7RQ1oOHaZe?=
 =?us-ascii?Q?mmcMYpOl9y4togy4nwdey5XibIAOWzlk+9lIXal0+2WsCR6yfaArx6oPK4dd?=
 =?us-ascii?Q?l207PkVopNzE+c5KecOy3FlGoASPP6mmUk853qWdky5J8rjN3mdM06L2n3zf?=
 =?us-ascii?Q?zFkw2aQ0aSwrBROZ0/cWYjLQTReGG6D41GpnYsLQ/fRDmEKh7RXaxYn2ob87?=
 =?us-ascii?Q?z2p/LKsu0QlYYn48AMT6qipdXRlosUDZy/RCCyP7k6CYjMyf5osvtdMNuAq+?=
 =?us-ascii?Q?DTlsSnYcuI3HQlCWgeEHfLWIXduCnGVIAdhDNMFH3ltQqRKQ12AyUVSMlvxn?=
 =?us-ascii?Q?ufbMyBslicSA/TmTU/b3Tj0FFVmhnbGPqANFwrHhikh4ukMpJA8OqXoMWrWS?=
 =?us-ascii?Q?OS12uTeK2vWRNhsK8z4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a77171-dece-437a-860a-08de084dbf60
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 22:38:35.0747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WAuz9ix3GtJtC2dUpP0HQGiU3mmw+ERNjPmexPE1qWXMvhx7a0I1r3mdXZ2rWFv4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7887

On Thu, Oct 09, 2025 at 11:57:50PM +0000, Suravee Suthikulpanit wrote:
> To support nested translation, the nest parent domain is allocated with
> IOMMU_HWPT_ALLOC_NEST_PARENT flag, and stores information of the v1 page
> table for stage 2 (i.e. GPA->SPA).
> 
> Also, only support nest parent domain on AMD system, which can support
> the Guest CR3 Table (GCR3TRPMode) feature. This feature is required in
> order to program DTE[GCR3 Table Root Pointer] with the GPA.
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h |  1 +
>  drivers/iommu/amd/iommu.c           | 26 +++++++++++++++++++++++---
>  2 files changed, 24 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
