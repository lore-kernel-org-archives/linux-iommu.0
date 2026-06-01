Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011053.outbound.protection.outlook.com [52.101.57.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846CC2E9730
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 12:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780315680; cv=fail; b=lANWdEhZtGcAdXUuu2oMv1+72LN36GsdheUDKWa6ndjVpozBggx4G/yDCAXM4ellsImWN3nhdP+sefcbOpUQQMkgbFJ5XR82SDQfprhzDoq551y5jIr/vTBQu8L2qbRTQWeU9R9UdoFv4l8LSaem2KMyXFdyutcce1nBZ/u1XHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780315680; c=relaxed/simple;
	bh=mMfWe1deN4k5olgwow33mgBQIEL/8jHHmuM1X93nV0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CdjgFqnck2hpwY17xvl7Unc8ZTzaqwuSvvaQJzsHSwOGGyCOPSp2dvdYo/Cl4y4/8w3iUNGkFSqfUW0gzYk5BiqZDZkoplFiVsnpub12UpoEqz6B+u6U92S9s+mU1CBrxC14AqbVWgx5tPo4TAq93DC82uEBqXQwAjRmXCGANww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HoTfALB4; arc=fail smtp.client-ip=52.101.57.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HoTfALB4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O98ElozMGSSuQht0P06+1D8tfHzFRsIWI3iDj+mk9H9GK1lNWzvnPV4udzxzQrOiAK2hkPnnXBt4fSVJAMjcMT9dxyoRLSbWBNk9innREpmz2ObRh9j7E3UG/iR7HW8+A2HADqtdjRIc0eyAvXFu+j6DkNQ6/ar7qBi5/L//sabeLPhmE0eZtWYhp2qfiVBSiTnAvY+xLuEG6gUzkFvT934dgsJibwoH4AzXPLjW3Byd8vlHNHoc57u7OzhFThTLHq6R3Rxri7gWgZ37FEYeyNgeZbwbJlgQ43d33DWOATeojGDsddJNIWMUQmCDGVFfRtX5aWE2gV0I4sUPPJ6sAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSHdwmdhzDBPwwvD4+f0ObOtopCbke1YQKk5HT7ld8w=;
 b=yLh1FVLWIxp5JGOj6A0mSacFcr61a27IeZeZc9TQ11pmrfvO95l99NirfwMkD2j5R8n7xDdAusG8+2gFCjWAaAtQBDNCSwXouqTKrhXZvWBWB/SnD26TOhX6CdD4BAeXThYzv5h83D9oROVFeyKtnHwfNZ9od2qmiSOGAxLOj2DgCfF4WCQm+iiyu0Hii8eU2TeuQtTTsIKigPl+zzw2qQBSOmOIcYZiVmM8itd9Na+hdqcGd6V+VBqm/UZEmu3xLJX388tt9xmH0iPLunEL3xty7XfTwqitMz8ea8+dpqsCtCuAfy9LdvF+JxVtKhCDjwjYIDHQkf/1UcVUEYyZgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSHdwmdhzDBPwwvD4+f0ObOtopCbke1YQKk5HT7ld8w=;
 b=HoTfALB4l2hG+7zxRqwRtUHzgrBCPtyvvxiC1mnoF4VvOzD/+hwGvKVHsLWEBRWYdJwSySdgFLUI74E6DcUE959x8vYMbdVwBMcBO+lEnDwmWX+kKcdTBzOPvPy/qxIx0yg2Gcvjkt1IKMwFSCrmPbEzebUrvLeMTKohJ29gklbYTof9PTMJmkE4qbCuUh59aNB9ssOh2Ha/Tq6oyaziEKJvdeEJRAyC4apiah+Mzh81F94EcB0Bhbv+N1GxpBQyedy9dp0QCyw2v51dRIN2/7a/ofveMM8yUNpRo1GIRa8pcSYzhrKcsEEXtY/8Oppv1a2wYaVhMJf1XNPMODFNYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH0PR12MB7010.namprd12.prod.outlook.com (2603:10b6:510:21c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 12:07:55 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 12:07:55 +0000
Date: Mon, 1 Jun 2026 09:07:54 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH rc v3 0/4] iommufd: Fix veventq_depth boundary
Message-ID: <20260601120754.GF3195266@nvidia.com>
References: <cover.1779734952.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1779734952.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN0PR04CA0041.namprd04.prod.outlook.com
 (2603:10b6:408:e8::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH0PR12MB7010:EE_
X-MS-Office365-Filtering-Correlation-Id: 5648de20-bc16-48d5-e35f-08debfd669d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	hfTxszm0CrPgtpSSRqhv1EXD9+VRXYwuOz4bw8ChcZx8xxrPYAGnIi5kp/buO7/2kbRCWhvUVIm8Tvbp2uomVyqvdHwZ7OO2irgXBNqN+xUDi46OMMJ86lt5voa5K3xWyfEgb2KnxBM9iWeLaq2+vQC7w3UyKSu3syebeyBdeeJmmoLoz2B9lqMuxiG6hkVFMy9epYA/HQWDM9AQ+ytBHR02qfo0oPMnV5RgWaiwUQrnQyhRSgq4gChf8lh6vQa5yPVOKFD9EFucWYGSFewaJJA2B6YTN/ymUY1ZCOd/P9e/2Gak5yL/0J3gsD/zJz4yrJwoiKTiuBNEacG0BAiKMeOm93gDbSQNO6tuBKCZFSfSGkP1AKblJl8Vsn0jxlQr3jQpSmaTgx4hRZyOUqeolkT2/pDuhcEsfa5UHFkHIfWU+r7Lerw06t5BaAZY7T/P4TmCu6VqUx5uU9a699IRk1/bRf9twZ63KAdNTNq2KDa0PuOmmotht2BZs8Vca4Nuu9MLWnpJWoWanMrpeijr1rW8SNSR6K9Ny003ERiJTKTrcMTNDTBkmNifYLdOQA8pXdbEPdxqDRvXTICX7oYybWhKGmngfgy0lWjtQsxvJeTJeMQ+2GC0WBCJMUKgUiFm4bSnMWTtaLqUzsxj5wVTvRL0kAZJky+F0/lMPqFFtQqemQ9JJvGv+7BVTNp6ED3f
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FJHsTpWHxsY3C/U51hm0wxmyl1zVpXOiM5b/VeEN51T31qi1TQtWQ31F4IQb?=
 =?us-ascii?Q?i+50IZ7mezryQ3Snd5nQTrttg7wx8F2PbWRTpfX0vCZAWNK9kl7nuwltvjM/?=
 =?us-ascii?Q?HDd0VpM35aWUIJuwGPqqGGvQBX5m4CdJT8hAlc3BIx6h7WY+QDE47g7Y9ngw?=
 =?us-ascii?Q?zuKW73Yq7SGeCo7kyg4v6zxJEwWPYeNFNMI8h9TWhsTIzU5hgko8P34ohoA+?=
 =?us-ascii?Q?Iv78eoEWlykVoYKTnrlbH1SAJfFrAYikPjW6pNWM+5X9HZFKjWybqWG6ZGcP?=
 =?us-ascii?Q?FhojAX2TBGFhW2I/Pxy4//d0V7iiIwx1L1E97BOwSV8kA1w+J0a3OvvrIGi6?=
 =?us-ascii?Q?WpAy3ZsOTkqTjcVzxFObxTfpIDDbT9T4fsU6earFQkqqIGiKsUlZv3X7Jnto?=
 =?us-ascii?Q?N68AC7GU/enmiAn6T8XjflviWVRT9f1K2oSwv/SwW9I1yCecSVkD3Crl1Ohx?=
 =?us-ascii?Q?dBqq6YYkBXCTPvb1S1YzfXiZB4efxHUcOQnugB/Z8+RJq6tv3qyEgvnon89R?=
 =?us-ascii?Q?gCqvLsrvuM+vMRc1vJBY9caknAXV3BMvU7OzxFWSyYuY00MCJjnq8tjFEYcF?=
 =?us-ascii?Q?dpheQvcxw/HmkKgumqoJ2IVwvzGJaUgE80sCH4LV96xb1gy0KPM+Abx3TDTJ?=
 =?us-ascii?Q?lVuO3BEELG8wa82Oi2ezPY24HGJQBaKQAPw/eDJ+uf1lBWwvAp7qO9LSPanu?=
 =?us-ascii?Q?3to0FCJcbSBBh3O7DfZ+BfAS10iSc1U4WaFnra9O1y0dnDMFTd37Nk702vlu?=
 =?us-ascii?Q?SdAqRM35kdeb27rnaN2w3LunmExCJ+Qf2uJccCgt2HWvlwODVxzt0PVWA/Gk?=
 =?us-ascii?Q?jrAOg+1+EcpPVdVJsFmFUhNzrj5Wht628sf+Al/ksvQ53+4UtS3kIV/1IY2h?=
 =?us-ascii?Q?CXBgWjLT9jgl3jsYXpDni5pae3IoUYMjOSgXPhURiT7VDazGxcF/w9jC5nWd?=
 =?us-ascii?Q?kZeYELQA0Rsayoz1L7rwzlfPA5343hXH4QCJR1p+xAyIgX+Nja4yIMMR64T8?=
 =?us-ascii?Q?J2H4oZZMG/E6dTcMXEd8Y0LTImANxwfM4W6+/RzHCBoBZO/vAVJDCv7xTgB6?=
 =?us-ascii?Q?h80BAzwHaFm9XDaxsOEFgrApv5kBFAIz2XIJreHbTY9Cv/VsxAdaY73lDgnT?=
 =?us-ascii?Q?GteGG2+d6BmlwbkJV1L55YERD360INfzGWfpaq6H2OkFMTDm+pSLAFrkDJou?=
 =?us-ascii?Q?MmixW1fSea0qUxXBvI8QtQNp1oG8aFvtwjSYhwybIBt9X8rKDnTNF+y+2XmM?=
 =?us-ascii?Q?ZR8IP3WJX28g4rNuizExx0EQsE9X8900FaBDWf8wbyJrxQ8pa5hTWZXT0Zwb?=
 =?us-ascii?Q?6mh45fhn+1lOQuA7XQCF+pZrsBjxWWLokB/GsM/epApQtC2297EHMUti4L5W?=
 =?us-ascii?Q?p9J77SEPqwKJvVIDfFUKENdU4/WzFMJ1P/4PadxKBSnpRiHiIeafLJS5iP7W?=
 =?us-ascii?Q?cRDsqdD3DQ/PwD3zSJJ2/VLRTVs4MMnyyPPwjwV59OfVPHlD1ptMFyhzioa8?=
 =?us-ascii?Q?ddbMB+aClxELaKEauXFnaUu+Ka0mtfG/qK1Rhh/Jp5YCzfvsNlJ2/KTBODdb?=
 =?us-ascii?Q?SBY26amwFE9AuwPNR/c0/2zE1QsZ5dimOGLExYASGUC4RxxvciRLS5P1yBr/?=
 =?us-ascii?Q?Yj/Qg638CN/z5nNfU2XObFmJEwWgIsqVKiboiORm7kUsC/M14g77m1gMAVuw?=
 =?us-ascii?Q?NIbaxGgcWpgsk8I3k6knWbkKF/satBHUnsc5sqIpWTHrFqnp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5648de20-bc16-48d5-e35f-08debfd669d5
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 12:07:55.5521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: noUGCl3tBZMPE6CCd4UsuAuKDqtZA2wNEyxwq41rwQGZI4t4vu/wqiVAMUoztgcE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7010

On Mon, May 25, 2026 at 11:51:20AM -0700, Nicolin Chen wrote:
 
> Nicolin Chen (4):
>   iommufd: Fix data_len byte-count vs element-count mismatch
>   iommufd: Move vevent memory allocation outside spinlock
>   iommufd: Set veventq_depth upper bound
>   iommufd/selftest: Add boundary tests for veventq_depth

Applied to for-next

Thanks
Jason
