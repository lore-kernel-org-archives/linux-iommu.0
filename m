Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197F918D656
	for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 12:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723725980; cv=fail; b=lgLUrXwUiCEB+mQIxlI8FdbQdOPeS7ZFHYytFfpYVxGvTksEJxNYxPeTdTYCTW2iajqmrvPWZfjDRuK5h2uNHS7kWrFSqUhvJtZTy1Z5mXMOSBZxApDelrq9EcxvdFdsytYCg5LS5BGFWx1DVoHcMrpKB5VvsWROzDz28d2vjDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723725980; c=relaxed/simple;
	bh=KA94RmL6x8rggNhc+MDy0jsBmKLj6+LJudEIithJ2cM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XYGMZmSScEM7Hcf/3eS+sESzqaS2ynXnBO6jLpBzv3pTuNpaavWkLqW0/zjzjreHC4ihBLJQEzdI3VMDUd/zmqRXL33kbTjkR82f/wdh1L4y64bZwRHsfG33wUms0aiXg52xdZ0cmrJ5aATH0r57CnktmtmxuZ9T28Tg7GG4IFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z90s5TG5; arc=fail smtp.client-ip=40.107.92.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z90s5TG5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aW32I5rmS3NbmaNTJXBiw+x3RkEgKboZUGKW7WL6qLupKN69AOQWZOAm88oRYZDcydtmkjngQgzI/3wrO4GsimjJ+LV+VRyH8BCHhAOgMG43jXm3KdrRrM8YI+PEuChhU8nHGA1D09urb5AevRF71B+NQHu0eG/7UxmO4tfw7j6CFudXLUaQAFuwbOHfYrfJaQdROVIPoQrUuCzNgA4R2NKz4Ka+Xgqgc+qWqEs5OBwXJyKmMZURIIi1NhNHjEKWjP0fpUMYHQe/22KOgwWr6BbiQnkf8WkQDWckDGzbv45tpQzpLks1YdjXZ5xD64zKf+6EFORTbOpu7xN96PQiyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYv6QvQETctERs9cXI28uyOn3NNdJGoixLWbFEyfogs=;
 b=MAvylyMnYV9NFvdNbKp0oH0toqv01QvLN+7U9h1js5L4ECHb2Y3mtYa6CiaMF0ecUyMhN1sYFoRlZPZuMDk2m8uov9RQ4zq3J7wSJdJW2rqfhkCDSLYWd24Uc8ZymbAAnGI51MPQT+klIV3zo4wqWrTog0ZHaOLLJAnwGiQZjtdU7x4BBjlTnyvQsMajvnbGsc+nOPXZCZYe5EUbzh3VcuncGTzaR7fDXpmpVFVP2n8pouYUDTCQtFf+TIrL+a3wTKI3uSVRyQfbiU+DMBArh+CrOG/6rQYq2sMFUQA02uY/lsf78pUEAwqEg4zj7Zp/sdABJNs3KZQOXaxDkRmlpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYv6QvQETctERs9cXI28uyOn3NNdJGoixLWbFEyfogs=;
 b=Z90s5TG5ExaMkWP0FXRnJ7ervXGUdQmkZAhgi8t/2L6TdrmYg7KxSwnG0/lQPxWspDPZ33igk8WimNKdLLkv5fpIV3vVEdRg1q+ktFRP+0a9J/09S6Pq1HD9TKUHuUxLCjtupteyUXLQPxtAuKnRq5nmNNm/6RIZUwsFXGE1YkushyGkejMdNPO4CPAme4XmKPcgFK/nrRkb6h16QEOV/KcRu7dFxUu2oIZjz4UxurgGmwylo/CiBVjjHYH+1U2+aDko+EDgB8jq/RXgComgWPcRXoqajva023U5EXFOlhFA8I/MgWIJ0zVoxFXXBPtuBF56J5L4BRdi8nf/DIdrSA==
Received: from MW4PR12MB7031.namprd12.prod.outlook.com (2603:10b6:303:1ef::6)
 by SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.19; Thu, 15 Aug
 2024 12:46:14 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by MW4PR12MB7031.namprd12.prod.outlook.com (2603:10b6:303:1ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Thu, 15 Aug
 2024 12:46:12 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 12:46:12 +0000
Date: Thu, 15 Aug 2024 09:46:11 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	y@google.com, Mostafa Saleh <smostafa@google.com>,
	iommu@lists.linux.dev, Kunkun Jiang <jiangkunkun@huawei.com>
Subject: Re: [PATCH] iommu: Handle iommu faults for a bad iopf setup
Message-ID: <20240815124611.GE2032816@nvidia.com>
References: <20240815123223.7116-1-praan@google.com>
 <Zr33pnFDbuJntl9H@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr33pnFDbuJntl9H@google.com>
X-ClientProxiedBy: BL1P222CA0023.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::28) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	CH3PR12MB7763:EE_|MW4PR12MB7031:EE_|SN7PR12MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b290147-3eaa-48ca-e5e1-08dcbd283e90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gXP+7JIgObk6IlLspQ55qzFSinTl88joXeYYJQfSIffu7lYSWdN5n2qorOoN?=
 =?us-ascii?Q?igIVKpHEZ5VAf/QEDVORJOUxYEINCR6BxmUZPihNcUl6heakvmJxQwMKgCwi?=
 =?us-ascii?Q?f53r2ql701wbRCl/jUXpEgOtUv8eYCX+DCOBwRgnUyMzs1drx3Jff9qlLFp9?=
 =?us-ascii?Q?SB6Ru8pDv76djdYTYSpsEmE4Ifcw2gQ0KFCgP3IfyAOAsAiHKxvFE2ig9KyG?=
 =?us-ascii?Q?Ykao2yDxVFWx2U7RWMvT7paVKuhZqOlF1ot0AaSS8fz08aSQ+dC29tbhqwwK?=
 =?us-ascii?Q?MolUaDNUNz89qAHVbb1jz9VwP+plKXYB+unDHE9CaKcumR9Xb75DAWSJP4/U?=
 =?us-ascii?Q?lVStxKd3J/SnuzYdh3esUsKpbyVnI7PWG7fwZzfhhGRGIeQrL8HfcGp8BrAq?=
 =?us-ascii?Q?zmaxx+xkDBQcY3Ow6VdUIxNVpi04lEefsFcoHLbB9Lt3HyKGeNOCEHf/qoi+?=
 =?us-ascii?Q?qoE6eVj8m8BIMFlvCsPrsoQ0/TbPbSbbkzzfcHmDaX3YAcnQ/eSJI0buSr35?=
 =?us-ascii?Q?tVVD3rpFfGtDsy68eWcbe3t/lTQozQfrvxjrCy/XZVIydQwCkPxUOm5AnoUz?=
 =?us-ascii?Q?7Txf3J9etkMYbA8DhH9sENzBd569wRJyw/cI6xqIuiXt8mGU2NkddwcI+a92?=
 =?us-ascii?Q?o5Cgshh1ncxwyhm0O84eT1PLXhzlUGNXrry9kx6FUogDEXezj2pK5E6lc3Xz?=
 =?us-ascii?Q?N0oAxDtg0hB22jlpThDhaKWkLisQQLXt50GZPCQW66ShT8MoIDFhV5OAwnJt?=
 =?us-ascii?Q?Tvg68BsdTds5uLBS7okqfvCQCH4pfcK3CyqmB0cgvj+Ex7JwfgkgN953ZKeV?=
 =?us-ascii?Q?7RH3xDJaLaHRnLB/vTqQ3G8gSGAwh1sdPDO1wVxFTXckFznVn4bcolthjHAi?=
 =?us-ascii?Q?L+IiUScisLxl9nnLPA5GiIhix1mnK7HrC5yjhJyXsCfFJeGKiKa7HP0m6hWt?=
 =?us-ascii?Q?S0IcqFYKQjByhKHZKfUCpZn6WfqJj3W2BMZWRtAtjhFmMWJlM7kW69q6gka9?=
 =?us-ascii?Q?brGijiUmB7EIVLTz6udpqdGuPNarGDdzq2nmcyRC903ulit0ofhYiRuaqdXy?=
 =?us-ascii?Q?Xlor70jFBtO8ZKLgwMdG/g78oEde+nL74vtYDOy5l0JVP9Hi9tCqZLXwYj4o?=
 =?us-ascii?Q?+bIFzSS7tMCTIK0hM6SLQFNaA4alwKrc0Oqy4+oiR5l2jdquZJjs7e7SrxLq?=
 =?us-ascii?Q?ARdlLOfL4AhzcslYbTy2Zd5xWlHsEHJQ5zJtF+v8mB9g7CA6Cz+bbw1SOBUg?=
 =?us-ascii?Q?VWzrRYW+lR/X9dtjx3BsPPe28Zln0Ek/QxXOqT9WRm2ucwhz7140ufHE7icb?=
 =?us-ascii?Q?i4uIxc+XqC8uQSaECEiBH0SsCYDu4Eai4jaCI+OgXzDIsg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S7ZZDAAUJj9xCDrWq/78Kf2pfHxHx9EcUefhys+h7yECAjPDmnzb9KirqFxr?=
 =?us-ascii?Q?k2qbP+/rfhdudhoeJbDQmvBSFVzGVQ0ZhNJV8Z0iGfMNvuM3TyqjdTuBTlMU?=
 =?us-ascii?Q?c4YhRUylIZiHgwPCRjaIlEVh7yYhOX06eG9RgQedxuET8ik2YfEugYf/VLv9?=
 =?us-ascii?Q?38IocoDXIax/RXUjwCNfLVRQirdo4s1ufLR3mExIIqyZMzORCxaKtTbELvDS?=
 =?us-ascii?Q?kTcLUpudLg8jy+AIj63UugPVYUgMbbHdbqrHClV/cOMR1K7nGPy4xE/Pf/ua?=
 =?us-ascii?Q?w8XEt6JsL7geW+6DvmHfoLg+Hy46ujyXCWrereX0jkXTkBB/+uu8tsBVRN1c?=
 =?us-ascii?Q?6aPKRJmgTScAFf56rksfiajxmSXI8EPIAuCD2WwpWlmMG8Ny/j/pfwsvKWBE?=
 =?us-ascii?Q?GzCbxPAAgTpEFy2olrtTftc53SHI/URWe0j6uupmSa6q/3QKsUob0w4kj0Kh?=
 =?us-ascii?Q?EsLBa+QwF6mgthUtxB6S5f1jA2yhrUqE9vzYFvTzojVa714Z1endI8MRncsn?=
 =?us-ascii?Q?JD+0f/3DpPXjlRS19osQjKon3TaENlsWo+2UfBl3YKvenhNy0gtSdunvsI6Q?=
 =?us-ascii?Q?3WjvepiFaAdSwz5pIwAvfCvdzEuddXHX/obMEKXwOLkSJBgpJyVkG1NJswwo?=
 =?us-ascii?Q?p6XYYLQ9mfMgsc60mPDT1tPpI1avmm1yDRRmQtPRlaLr8L2IcW+ezoiXOIST?=
 =?us-ascii?Q?e9mqRNGt6fjSRjYoXuGDoOUJoX+TBdGSJV3XX4qss/2FpuRPOEYJiSSF6JAj?=
 =?us-ascii?Q?ndf2If8XyXbiAIYI644WXG6BrRX8l28N1dlOtWXZ3jv92kYM+ogHUx0s++OK?=
 =?us-ascii?Q?dyRTCNsBS8ksDqAIYyGvM/fOaiT/VjiQhkweNIfdFEp/M0mkTU0/egjCKfli?=
 =?us-ascii?Q?9X5smHXStLXAHbZiLs4Jear5lDGhzNzfJBHvhhFkbTXopG5zwwbHo3jQ1Ejc?=
 =?us-ascii?Q?EV3goPLt4MaTq4IXWu4eO4maW+XC86u6hCzUKFxairzF2layw+12KXQBz5Fr?=
 =?us-ascii?Q?9f+f6kZnkZre8bgltXwDykENfjh9xzwQvFbVJv3AGGv5wN64+XWrjWVZrggD?=
 =?us-ascii?Q?cNPzWC9mPUpjv4uHJ9yTGAJAIu1H339fpM6mxqZ6RWaMu05n4FwzDinqIgp8?=
 =?us-ascii?Q?DW9tXH1KxRV+0Ghn8b+fxhLT1sIPiAtQhdZuFIjwIJC9hPuoYEd49qabIWZ4?=
 =?us-ascii?Q?3wyoLXY2EH4+D5R9CSMolkegFwVnD/nlzGzZCqdAGqyENjg40SJdBSAv4M86?=
 =?us-ascii?Q?dV5zB0YI5WJDb4/f3+vFoIfPF2ocz6OIAMnB4Ruljas1+AqkxrqW9Pn37YLV?=
 =?us-ascii?Q?eBDGqRqVMCRexvd5MgNF2BVFLwcnm7N/l7HJ61rrg4Fhv3r8JBh+q/ts+R6n?=
 =?us-ascii?Q?UhtdEawEWoVzKvn3W5cNzpfC9PhQXC4EEVoNM7bnlhlKiIQw9tkTwMD0Zuya?=
 =?us-ascii?Q?Saag7AgJB8rxLNiDTLUJbLJEO6xC2I/vhUlBz/rqIRyM70WyVxtr8EGmbDg1?=
 =?us-ascii?Q?dQBay0QPRMSn1rsHb3108wyV2T2I/EKmyvMt+fNIVcjG+UgICBZ4lj5zqkqg?=
 =?us-ascii?Q?f94sOBM5a/Dm4E8OvhXYW23O9SCE2GJJtg8tG6iV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b290147-3eaa-48ca-e5e1-08dcbd283e90
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 12:46:12.7138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wmHgJNRuN8z+fUOQPYj3qKOyC/s83L0BiZ+YVQPLKFg+dCFT9kl5JwjayGBIi8Dg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7023

On Thu, Aug 15, 2024 at 12:42:14PM +0000, Pranjal Shrivastava wrote:

> >  	if (!(fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE)) {
> >  		report_partial_fault(iopf_param, fault);
> 
> Apologies, I sent out an older version that missed returning a value.
> Please ignore this email, I'll resend the updated version.

It is probably Ok, the merge should resolve it.

The fix is already in linux-next:

commit fca5b78511e98bdff2cdd55c172b23200a7b3404
Author: Barak Biber <bbiber@nvidia.com>
Date:   Thu Aug 1 09:26:04 2024 -0300

    iommu: Restore lost return in iommu_report_device_fault()
    
    When iommu_report_device_fault gets called with a partial fault it is
    supposed to collect the fault into the group and then return.
    
    Instead the return was accidently deleted which results in trying to
    process the fault and an eventual crash.
    
    Deleting the return was a typo, put it back.
    
    Fixes: 3dfa64aecbaf ("iommu: Make iommu_report_device_fault() return void")
    Signed-off-by: Barak Biber <bbiber@nvidia.com>
    Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
    Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
    Link: https://lore.kernel.org/r/0-v1-e7153d9c8cee+1c6-iommu_fault_fix_jgg@nvidia.com
    Signed-off-by: Joerg Roedel <jroedel@suse.de>


But doesn't look like it made it to rc3 yet

Jason
