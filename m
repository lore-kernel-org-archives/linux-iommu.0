Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010027.outbound.protection.outlook.com [52.101.201.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5627F2D2486
	for <iommu@lists.linux.dev>; Mon,  6 Oct 2025 14:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759761420; cv=fail; b=DuXOwvpdm/TzKTrZkHSUXHwvlhspkDQKAUGsDXMhIRF0VZo7BzfCA0KtWPD/fVby6QAGqspNbGyMzcXX1oh1S7ZLJccX66+tBSwM4GYDT7y5HmrZjWbaCMdI9lRnVRbCX7DvCq3UzAzjYM/0nkYAsrVJ5LTStXeqRoFJG1hfeHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759761420; c=relaxed/simple;
	bh=hModTrdZc5fmLD6Q0cir+C87UlzgCmLJwWq8+yH/jGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ejCFHWlgeL6dKvyTyYfSWGvQrJ+Gcqb3vTVHnVuPda9qp1JHm4Od4QFsyFcVf43aqtK6uvOEjAr3PYHxoo9zb32+89TJQDmqJJRP7wLGiuOQyxftcqBihLBrulHF640VAyiakVqDIMCSv4es7KaOgCFRkUZfkXllRHZGCft4p5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KmRHrVSS; arc=fail smtp.client-ip=52.101.201.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KmRHrVSS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aWLiCYqIcUrnk8hYSogUzyFz+hlqsrlAdxGPyxY1QHtLhow5hu1IUgdmEohg3ArPBj7ERmG45+SxdSAEDqCbieHYBbK0L1/YKwYJ7cwO3LFC9O/hqNvX3RoxejooS4P+J6mI/86bBqd7WS5Qt+1cpouEyaGEP2MXepov+9eFUxhPikkjyT6tovfei801he1cY9TmDyxpMRpUuHb9n7mMe8FzOrgLEcYNHj7ZqpRhqF57C3gRInn0jXPKqAQUoP4N40mh5kP7qB28msa9kdHFJSGtnGTMHfZ5ujPU1jgK8Qxx9sxwDmvHON9YhtVDEciApYgLP1bbokNwH2+VX6ZZ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXTf67r7gBsQvaN7eBwJoJhwFnVSPNPNmt1bmbOj0wU=;
 b=Btr8MNyRBgdEMZ5qo0il/b6ZLyWosgoiOUXyoBORjH6kxOt/MOCzoya5wWWVR8o6odsD0SpHGJ39NkvrLFv59wISMH7I/o6nAQWx5Adbcm9g8vrVpfgZLgb8YLixQlRtApK5P14RKXlbT+iAORDaxDnrgXRlGiKN/u/whovaY8yYt5aBFCOd9XjUyVDO6caZz2RfefDghH5IdvSaKmE4fjNK45kUZ79NP7Dcl3VjwFkicRG3KL73bLzqJuRdoYDw8baF4pdyPas3lFj7FC9GuyoD8f6uRX5JA6sbmgbscGSXk9fwymnDMDrLJ2vQTmoFZ2TsTQ5QKaneH8vm7whzvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXTf67r7gBsQvaN7eBwJoJhwFnVSPNPNmt1bmbOj0wU=;
 b=KmRHrVSS5jzRcQ4yW2DlqmRHabezHfYPxicBcoJyVAslGszlg8L76IDrplJE646NSzh3eGuKHGJ2XySMi2uti5yKfsTkbLTj+Vz+z5MdIZz5nuMyQBlKanePRrjCpO0N4zI2b2jYo748QPY12P2XpOJw200DCrBzxiRPDbiw/EmZRFfcjgcmYLNnrVEmTClnjxLEsZCpc34aVaEJDxP8Lkv9yu1NTHb77lL95JheKHmFz6d4esurC2NwzUN8xC1n8bGi1QYEHQU/KpgW/Wjx/l9tmANf5ESuaW5YN4Otznz4rCMIdzTGwpp0nL1XlfBy9cJOcPHOBsZrLDaHot8mug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 14:36:49 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 14:36:49 +0000
Date: Mon, 6 Oct 2025 11:36:47 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: nicolinc@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	will@kernel.org, joro@8bytes.org, kevin.tian@intel.com,
	jsnitsel@redhat.com, vasant.hegde@amd.com, iommu@lists.linux.dev,
	santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
	jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
	wnliu@google.com, gptran@google.com, kpsingh@google.com,
	joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
Subject: Re: [PATCH v2 01/12] iommu/amd: Rename DEV_DOMID_MASK to
 DTE_DOMID_MASK
Message-ID: <20251006143647.GO3360665@nvidia.com>
References: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
 <20251001060954.5030-2-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001060954.5030-2-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BL1PR13CA0116.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::31) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|MN2PR12MB4333:EE_
X-MS-Office365-Filtering-Correlation-Id: ad482608-41b9-4c4b-0673-08de04e5c8af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qmNFI15CuBDLbDY3EQZkmMgUdRW7WhBWCW5vzsw4KYsjSjHt/obWFbNJozjL?=
 =?us-ascii?Q?81dxP6Ba0CUmPkWakSqHpX0H4ilXqMCxnZjlhvx8VERx0VtbKhCbk0Qu3kgu?=
 =?us-ascii?Q?iVROcoOJbA1lakB+/n6lRY0vXRT4ESSWgLsK/BjE08zOAUl2GTKgRCUolEzq?=
 =?us-ascii?Q?eYKli91vi/NrK6hZleoh1ZehVjDE+zMkREL/sFlrT6K5zdDlW3vKhr5WbJye?=
 =?us-ascii?Q?oFRd0FdEAdvBeuANt4XlA5nq3yq5E43ylMI88yAg4ZmBsF90VQxSA+wDiYGh?=
 =?us-ascii?Q?frryEH8hkxZXfX0/CcmctLM13MBAw+F0vEqLwSK5NVOaj9tmzM7FhoocNUxW?=
 =?us-ascii?Q?i0jxgp1nSLZvlhLQFShu0J0JPGlLxO6VhFBZKgal1TklO/jNDwfY+R+7A/gM?=
 =?us-ascii?Q?AUh2B2LJUJuFotwwCPbH2I6/tHmVmbC6brxt8olWwpZH5EFmIx7OFUEGGfOs?=
 =?us-ascii?Q?xURqqFC5OGvDtQP9g/ctJuKkz/CpH0Pe8YcOV4nmQuXswDzf/kqnOOwjDll6?=
 =?us-ascii?Q?jNF1jXwXjt5+qpmezoFNJ0FDDI3Yex/8O1Fn0lGOabHq1nqPDeByXy6QeCGV?=
 =?us-ascii?Q?nhFZSfsCsvX1b+s+x1sXv0QSOKWyburoDysFnWCpyTLwkWetplIegpN+HJPf?=
 =?us-ascii?Q?ZS54gARdgFOqD9nNwI3unSSHtGOleZImy2dH+ktmF/8z4fMi1bPNNk13PLiy?=
 =?us-ascii?Q?2N8EdJ9gs0ET/Rvzc4kJzwv0fSqlRk87jEXdj0aFDufN9Odhds0E0zVvXIPy?=
 =?us-ascii?Q?LEJ01Sddtv2XB1zRGlQcr4Xge+gSKdUxzuVpEAabtixEyZjPHcMlabwXysYp?=
 =?us-ascii?Q?PtEvMCSSG4iaU8a/8MH1hu6JtxSuiC1QZIrDAnIGLuEWn6w1hx5pNAOtYtNg?=
 =?us-ascii?Q?N/YhzPYUiAUJWJ5GQx0/mbagKQaZmxz9lCf4wXu63rRw8xIlpc6kGmnM50Xf?=
 =?us-ascii?Q?56LTxttxo8173cznkeKJl0ZPzosunqG65rNa4cf9LcDnK7DAFluHp37N7O5c?=
 =?us-ascii?Q?9pBd8rcPEf0ZVPvrj8pYIPZ4j1qJX5ehH0+DaquG58XJ5WAWIVn6D6pQ646H?=
 =?us-ascii?Q?ufrX/yd597e/5R07Ccq/jWTduyDf65QUQf7UDeLezAadwbBPBMRZsHauDRq1?=
 =?us-ascii?Q?C8QkxU6Sy3vSScFCzWz03PWpAhwCeau0Gu0rh+IOoz9yrlgIdoHRDyx83kE7?=
 =?us-ascii?Q?ZyDoJxuU9M/Ar12OLKWEvk21/AFzruaVGY33u81EvPuX4+T+te/nEwgKkVOI?=
 =?us-ascii?Q?2aeuVyl6TY1NAZU1+hossLl36Rs7+dX0mT4t9cpXXNUa76idefD1wYc6mc8e?=
 =?us-ascii?Q?5nJEAlcf39kc5mDjrK7HKhcNKKnOxlu0wz1y8f83qY8jz2vUrAlyH/qvGOSD?=
 =?us-ascii?Q?m41WndXYW79MHOoG0t7bmQT3toX/JQmY3gJNsfda7c9IrLKlTUdv19RFtDCO?=
 =?us-ascii?Q?7GLN8sHnc7oorfLtd8Xi2jbAJM3gokpK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ckJrlNL2YhswBnHWm9UOCfwBlEktJ3aApxiI98qRuLiDhE0z0TyK2SsJA6TW?=
 =?us-ascii?Q?c02W1+bOxWOMvGRf5t6rLWz0UfZG8rj5JwjsNBxOHM6DhBDFAH56d+ljUt/H?=
 =?us-ascii?Q?Cm93OBhSj0lwEwkrx6w/eiaRePm5WxWjh8dG2SUJ+le+l6ti5CIMfN2IB3Ig?=
 =?us-ascii?Q?kXRBfTDf+aVF1zYm4aGBg+uuj7oBxnGaGngGnMS1msd+sBC5AZdWWS+6x7eq?=
 =?us-ascii?Q?WZ0L4XojZmaw4IiXQtakkJrVFCjuRGNhZwB0nFB5N2MVqXNhnko2zeI5JdVy?=
 =?us-ascii?Q?JOz2yEtf7d8bNteWMV/ZxsmtS1bwKLdyfhoc4AmEwGIx0OI4QZLG9H92hqPt?=
 =?us-ascii?Q?7lIRtYDLDqYS1reLXP0RNfd1Wi7KKEmcpOKH5HXboFLmSmX41e77Tq+qcEuz?=
 =?us-ascii?Q?Fmaq61tcpSqW/uzFWwMxjTH7cPwxaKfLzHzN/hVD03wW2kZGE0xi90zhnbt3?=
 =?us-ascii?Q?PU4M91t2g9xwSc72o6U8pbBQGNeInYmcc0eAPPtCEERcAEuO45fio38mu1WA?=
 =?us-ascii?Q?6xclPDxNSf3DQledB4u3p6vxFD9gwRjRTm/ghsm3KR+N7TLbEHFSXlsowlfF?=
 =?us-ascii?Q?wpl/zsHabZzl0uYF4L7lba7xTKLFGnhva8KKl1JpbJ80ubGqf53lt06Lyf1a?=
 =?us-ascii?Q?ZGJLfMetFzw2OUWjKvSkmJ/erkeaAIB8CIj6eGFNMdSx7KxwHtkmVqg+UTav?=
 =?us-ascii?Q?SpXdNMncSDyGE9mYi1scptdwOqHH+d9NbqZ2nZ17Vun3iPC8NMiuPSwamRTu?=
 =?us-ascii?Q?3+TQ24Ghyd9i8yyY88gclo7V1bGW5+fTef7pUFaS+CjPxk+mXG2FP1ajbbeH?=
 =?us-ascii?Q?O2juwwvkRZ3G5qdT3sqRYAYvK2Y3hw32AFV0T0ROLJFSHFqpmgCEyV13CrtS?=
 =?us-ascii?Q?GPoMiI0yeQT9lRDYEaYQBw0MzWabTHoLj3EIRgDoRFZ0r+of6C6OyveDIC0c?=
 =?us-ascii?Q?I5dVxNev3oNtKWYpqqDqK0edmudlmoH82NhgS/T3cQ/kK6uAdnGNK7pEKN44?=
 =?us-ascii?Q?e0JFUpyFKDzlccRJYW+xDudsjmgP5r2mK8cQCBG6SX/oqw4diFJdHDWFH/6U?=
 =?us-ascii?Q?0+Vngla/y2Xj3QdQBZLH9XCKDU0x/VhSeCV9FdQIlFh62nqImUT3oH/NEI0u?=
 =?us-ascii?Q?41fktZ6chD5Lqzx4nPjvUULWPiqzMgrIVD32ULpKDw3ZUQVbrD8CPqpzj82F?=
 =?us-ascii?Q?pVtl95IcMrr7p7bXJTlBQnt1zsCSnGpko10Kxm3nWiJo3bQPRQRn5R+BnONC?=
 =?us-ascii?Q?uMEYJ/G5UsWMGjjyRPRHI1qmWMd3edfoR4cLnzS7up/HN65pbxyXYrPWwHsN?=
 =?us-ascii?Q?eBvGEnD2dlFAyLC/LgcxqhBniSn1lQaC+M+FbdMj2kc9OoPmrEwsFkDS9KGW?=
 =?us-ascii?Q?aZibm4V98g/SDMwxFmfOJZ1fOXi8hCZBKKkSXveaYvSs30OYSRzPG/iebn+9?=
 =?us-ascii?Q?+btgOzwdoriJaSWFCBsoVgIiEbCaO+EOo6ELFj0aq2UiEjeSklSA0HrSoWWo?=
 =?us-ascii?Q?1w5rsyglkumArDFtJJ/ITtDniXu+L0//ANy3eHvfHJyQ3zIa34hbLAuXGXOV?=
 =?us-ascii?Q?li4C+b+cUvcHP+mJYWE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad482608-41b9-4c4b-0673-08de04e5c8af
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 14:36:49.5837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GXKGfBSMvyv5SsKvGFOYgCJ2uNch/XE3E0buL5fOLOZD4l+LVs3TiBrUzCHa2SKE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4333

On Wed, Oct 01, 2025 at 06:09:43AM +0000, Suravee Suthikulpanit wrote:
> Also change the define to use GENMASK_ULL instead.
> There is no functional change.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 2 +-
>  drivers/iommu/amd/iommu.c           | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
