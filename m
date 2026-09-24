Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010032.outbound.protection.outlook.com [52.101.85.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF92E3AC0DD
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 18:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790275562; cv=fail; b=rLL+hrHHRtjE+9dEV8hP2LkadCT4/xR93CTkfxeF0OOC4dxBybVYvWRJIan4mG3RWBU0Q4i9S+VK0fSpIAcH6H30/NtzBrVZLoqX879wZt6RacfL+Z5cQGodxNk809sJ5dC7xexYmFwpWJTwezbpfnIv9y9n+lh/J0OmSOFtOBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790275562; c=relaxed/simple;
	bh=E34N4PZyXlVa0+yysLQmdxyUmzaevHierFD21beON4o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 Content-Type:MIME-Version; b=LubE1NZShsUcFXvWc/5QmQiK0VH7cgZQ/0AlBDaxjqDcsMRvmMGt3dSpGHnBCtg0GFMHNmaE7eNY3/j12+dnh7qEhS2d/4e/evu0MDEmVDZKa6NmRVHPURlC25VHSR1RW0BzNQ1VRNmPiUMUElgWGRrZNd/fgXuzBzTCpYdoyxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PlsBhJj9; arc=fail smtp.client-ip=52.101.85.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PlsBhJj9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZl9pZYTb7DD68DCoErh8x6cydWT8C32CO9ZiIvamA0fwQ1GlfZpCxnZcPo9gC48LvBzjdBz8FV/jfzpgX8h854jJLLTJJS21+MrmI4AmqCjQmXz2O1/tZ1WSayUUZn6LvbV3+L/rWFmZJCcUawAu1ubQm2V1ZE664OrEtpy8/Q7pqg22niOJGdydPDVzMNz5H9WS0l8O0bRkBZgH34Ecz8TIj5YKDvc+dRPTKVYe4zcYb3BwZjYcu5OoXrcQV5mC7U30cHWO6wt76mv4ewX2qd37nlHOj0+Wo+NW5c9cCJHoX7GIIh+yn6Ye+nWdlcNYw2z4qv1783GMut1HMhJYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQYKw3UPMXGTAvnFWG0xCS2XrJofsG9UEoJ3sUj+Ogo=;
 b=zKJRbXSzaUjhtEVG34tKB7yuxwCdm6HkHy6ni2MjT40x2AVOPrVUJzfip7B/Jscdd3ys/gukUJjHpZss40DdC2yq+9XUmd/25iJPDC2vSVR2KDvA+GcfHw89SxOrGz+NSsbTIkqSha1e+ZWuyAI14E7jt5g9slGpfcdPmOZ5NI+DYKJukSU7amiySUlIxhMBhp8FW4srXemL8cwxIz70GSn2loDnAvJwYxkoWqW+P8dkBQIfGokMHwYGi1tL49pz8gP7TtiYG668t1tyPMxu3tDtz/3PienXy3GZkw1GMt0kIPkiFGZ0T4ILT7jfEjRCK2MgWWaMc4AgU4Tjcu0Xrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQYKw3UPMXGTAvnFWG0xCS2XrJofsG9UEoJ3sUj+Ogo=;
 b=PlsBhJj95/Gck4gj5sYDT9TMoRSWDJXDJzbdY4a6SFjYA7USduDLcnMj+u7hZWn6MZ6UQn3ZEcSDwpTHL2Y1n3cq6/VbTiwoS/CblHsdzIkBWnPsqh1GdAg2qdFJB6flUOIM6OdxbYH5AcjYM8ZPhWTPTCnQx/9noCbJWlYWs6/qhQeXJPmIVCCWnnLAtqAxInVchL18qq9syrAzyR4wy1cnO0BDZYFOYXylk90f/MSxqFLVc4sLteetdp4V64Iqst4znp/r+S0p2ShiEGmtLeCp5QGX+pyx/LBzK47xoBv4gfVMQKNL1PdRszFKlfBUAIPe4iiT9fE5B4A4Q540FA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by IA0PPFFEC453979.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::beb) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 18:45:46 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 18:45:46 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
 Karl Mehltretter <kmehltretter@gmail.com>
Cc: Joao Martins <joao.m.martins@oracle.com>, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260911231850.20737-1-kmehltretter@gmail.com>
References: <20260911231850.20737-1-kmehltretter@gmail.com>
Subject: Re: [PATCH] iommufd: Fix iommufd_hw_capabilities reference in
 kernel-doc
Message-Id: <179025358161.16814.994900512568249057.b4-ty@b4>
Date: Thu, 24 Sep 2026 09:39:41 -0300
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: SJ0PR03CA0258.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::23) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|IA0PPFFEC453979:EE_
X-MS-Office365-Filtering-Correlation-Id: a50ec3db-c8aa-4073-5115-08df1a6c0bae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	2Rf8Tmx35pXhdpB3Cj590xP6PPa0lc56RgSrYqyVvHRvoNsEGddvpv5cqwVityggrmnidSqr0xZE8xv8yvDqewulGrc4jmorikzt5mRnZi658RpJ7ZQkhhCp345MuYFhoBzaTw8oXjJGjz1rN4PmFTEYgKhK2j1XS4XG4xgQ9EkpzpWXp0d1i15f0k+6tlegXVfUts5PramulQcoIrp06G+nQ+86UdNX/Icfnph+Q+pHgMQVR0Nsg81glKH++8gEzrR8OogfM/k3Cx3Rw+AfDLE/wf/jqBmNes+OFNmSy1Y1FaKC70Uz8jkyOv/i1nOi2fnzVCOMhb4DH5b81NTZWFeIVQlzaK6Bf4c+bhSEDck4ZQPMD3LrSqs3kRBEb9fvuyF28WedXVtwmyDVLtvmP9ecS1pwBKdHTYRNvHP2X7KW9qQYCzUZiuzDbSfE98kbxJur2zlK+4F9d+CDitviDTG4RjVasd4Vec/+uOj+CFkVofm+uTNh7iXaMxpURwHyQ5MbymcToKyjqcUBpngrTdrAK4KF/OVZnX3aXrctsdA0bV+IOiquQCY9Zry2+ysLXb4/AtfgiHYofrQ/4ACaXeK5tIYg+eXw+Fr/5ZFR9tXsvrnWB/e52AB1aptLQiaTISkiwpH+fX4xt2JZWIgPIxnzcCt5SI249y+pISAXMyA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjRlNkhaeDRGcEhiSmtFcnR3VUNKdEIvaGluY0loMVNGVDkwMm9FYzBYbXRw?=
 =?utf-8?B?Rkk4Sy9VV0J6QzkrN1F2UmhDdjBUeEI2dWUydHh4UkhWSmVCVXBVUzZENDVx?=
 =?utf-8?B?bC9UMlBxVmR2dThDYnpJSjBKRTVzUmc1Mm9janNzNUhLVktSNEM4VEJUS1Ns?=
 =?utf-8?B?MmRnWit3U25NTXo3cVFvcHFwd0JDTDhBV2RMSG9OMkFhWDQwQU1SbzYwaEhU?=
 =?utf-8?B?Z3JPbXVmejZPT0RWQnlzRS9aSmNjUitZWDFXakRnL1dKU1JIc2duaEswMSs5?=
 =?utf-8?B?SGM1b0N1Y1d4OGxwVXZNYUx6VVJST3F4MUsrY1ZIT0VSTlJDQWgwSnRRZ3Ez?=
 =?utf-8?B?NWQvcXFqR2RjN2FTd2pieitkUFY0VVlVeE5PUUFkazlkcUtrOWdIdXNHQjlt?=
 =?utf-8?B?Z1RUVG8rR2VHZ29hTDVjT2N0NU0wZWQxbnVEZ3hPSnNZdjAzMEhqcExlZFZU?=
 =?utf-8?B?ZkN2LzIrclJBaE5GOWlaZGVQdUZrN3JSajdQT0xxdVVWUmV1VlpoZUhtS1dj?=
 =?utf-8?B?RVA2ZXdyd1FsRHNlb0wwVXk3d2YvQmEwZUo2UTJvLzk3TjJlTHJEcVFtWWFo?=
 =?utf-8?B?RHFLdEQvZUptVmFEeXlxN2xaQkl0WFFXdUt3RW00VGd2S0JVK0NMejJwQ0JU?=
 =?utf-8?B?MEc4Wk1uZktEVWVqVDBtZ005RUsvREVkZktHUUpFQzRFcVBKR3RndStiQzB3?=
 =?utf-8?B?aTN2ZGlKRTg4RTEydVFYSmw0U0xXNWhxaEUzdlNGc0VuYVFZcE9HemNaSGwx?=
 =?utf-8?B?YTRqWjcyWW1xY1M1M1JVc0I1NHVyVHdhZE41cHJpM2llM1ZxYnFSWXBVK042?=
 =?utf-8?B?Mm1DM2VqZEJmU0c4VnJQdGUvS1lRUkFzNGY1bXd2Vnc3cGxmdTZMQU9hTlZV?=
 =?utf-8?B?aWdjdDloNVVxNnYyekxiUngyTDdid3o4NDI1SERuYWlKeE13NjVISUUrUXNI?=
 =?utf-8?B?d3U3Qy9lS2pRK0t4L096RDNBMHdyMkk1b1JSZUdYd29pSmVDNVFnQzFBTVBj?=
 =?utf-8?B?VDhsQytjSnAvOVdxN2xOV2N5b2JCeCtYSWZvbUlYeTNhKy9tWDFrdDBJK3RX?=
 =?utf-8?B?empuNGoxTGMzUHdQOHhycnRjZUZTSlVvTVBSY3VpRFoxZ1hhTHAwQlBVaUtr?=
 =?utf-8?B?d2NETWdIQ3VHQUNxeHNlbzg1M2h0MEZ0bGhhZ25FMW4xd0JuVnMzV2ZVMTlO?=
 =?utf-8?B?SWpwRW9HcUpEUmtWZXZ2Vjh5T29BeDhBUDZVYWE4YVJ1Nnl5VUo0ZjJQZHQw?=
 =?utf-8?B?STV3Nk1kbm5nbmFRc3FNTWFScDNTMVZzSThUWm1xZ285VVdERU9ISEt1aXpY?=
 =?utf-8?B?ZWx6SFVoZDRXUnB4c1dPbUtnb1pkeUMwSml2K3VYdkNWM1F2Y2I5a0Uyb1Y1?=
 =?utf-8?B?WlFkRnJDRVdJZkpTUG1MRkl0SXptYWF5ZzdDNXJ4TzJCMWFCNmtZTXVBbVFz?=
 =?utf-8?B?c3dTYWs2eHBaWUV4VVQwVnZHOXFCaWRtaEtpTWxSZElna0hJQUhPWFBIeUZM?=
 =?utf-8?B?RXBpMnYxWTNaUlgwS1ZoVXFHbEQvVHR5a3FWanBJS3RPVWRZS2V2dTNRZ0dy?=
 =?utf-8?B?N2laZWxuOHh6T3JGbVJCaEZka2FDY3pjdnkybm8xaENKVG1uTXVxQit6Ym9G?=
 =?utf-8?B?NHhIWllsVFdSL3RsYmdBdHg5aEVNQS9HdVRZNTA0OTV3MUtJazcrV3c0ek8z?=
 =?utf-8?B?a0FVVUdXK05OK1ppeGNTaTlYSnY4TUZQbmtFRUM5MG1zL2tiWkdSSThEVG1i?=
 =?utf-8?B?NjNZRzRqQjdqQnpVNFpGSUtjanE3ZzZBVWpYSjVFTy94Y1krRllLakptWkJu?=
 =?utf-8?B?WE81VHZnQ080S2F0UlZCeEdkSGNGVGRSVkV2QWdHaEd3dDV4MlNXVk9RYVlj?=
 =?utf-8?B?d2YreGZXM1JzaGs5L2JBNnhaT08rNGJUeXVWUkF3eDJ0KzlKWGl2Mk84M2hG?=
 =?utf-8?B?STFRaWFZeGFadnZDbVNNVDN3ODdIUmVMTnYvUzZ5bXBBSmRKaVNjSjNrZStK?=
 =?utf-8?B?WEVVVGNMcS85OWdTU3A4anlrU2ZTc1RLUEpoN21xeEFGK2JmOTcwSFlxYzNu?=
 =?utf-8?B?ckt5RDZQRnZZY281dXV3bWwxdTlGTEIvcnNLbEtDblNzNTZkNkVuNkE3Y0ZQ?=
 =?utf-8?B?WFRWZUdYL1FrTGkxTk5FRTdGTE50andyWWZxRFhSQUgrRzhBbW5RaEFlR2lS?=
 =?utf-8?B?YURZa3c3aXErNVJSMEdXTGlGbVo1bmtKU0ZsN0RibDRFZGZoNVprSlF0b2tH?=
 =?utf-8?B?Y1lES3FMQ2ZNdU4xcVp2ZTRDOFljU2w5elEyNU96dTV0eEdwYlpXcEoxVDBS?=
 =?utf-8?Q?kt3Jp3WOW+eRrCva1v?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a50ec3db-c8aa-4073-5115-08df1a6c0bae
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 18:45:46.5526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qfQYUgeSAl9SmzDm8cI+BEN29iA57aJM6T2jGVSRt1uOuiS2KfSJwEVWzViPncFI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFFEC453979


On Sat, 12 Sep 2026 01:18:50 +0200, Karl Mehltretter wrote:
> iommufd: Fix iommufd_hw_capabilities reference in kernel-doc

Applied, thanks!

[1/1] iommufd: Fix iommufd_hw_capabilities reference in kernel-doc
      https://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git/commit/?id=54dadb030c7e2350957855d3995de05ae02c2e66

Best regards,
-- 
Jason

