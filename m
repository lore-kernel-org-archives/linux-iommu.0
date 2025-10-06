Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011036.outbound.protection.outlook.com [52.101.62.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786572D5C74
	for <iommu@lists.linux.dev>; Mon,  6 Oct 2025 14:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759761454; cv=fail; b=fmXA+6GAZwtlecJP6MlXoILOfgOkg3jXODZZSzmgVR+cRQGt0itzofqqgBnnSLPo4ZvXKzqR/OpPu4CAN+ixPe2YyNboez/BLwPDnzwo2sQTAlTT5+2F5X24hu9m7FtA2zZIOQf3O5ljSIMU8FDxpgI5Le0VKw5fw9OwSovrzcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759761454; c=relaxed/simple;
	bh=fUos17gTont2XQIIw+1X2M1XdwNlSJ5ZcaKXloCLtls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l3yQMLvritUlECQjwUvVadXqUtvy6i2pODZb4ifD3OupegPUhW89DGYOHiNW90wmIZqNGdkx1g9u585e4jOQQ6W1GLJ7Yu+F18tR7XToGFVuEq6GFIF7V0xRcwzJwdMWiHKAxLafFeUaaEcsiK9T/GYdaedOMOxJ+tbprOugmM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fTwAlG5Q; arc=fail smtp.client-ip=52.101.62.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fTwAlG5Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r4vh4V7Hnf+OuwIS0/FOMcainSp0I+wUIkAbl/1xBM49KK35EVKHLD1vtcwXxZSnF6X1fNeyo/g5mmDgzrb94IG8gmwDXatOyPbOgwy9Eoz6SxHEFz56MlVzBVZ6412GVZWl23D4SaZbueRYI16ohOp/E3TRgIjpT48bCyhmGU7ubcKJffxEugZTT4iDNfi7Rh1tFU/xNhFa1PxirH6mb5OwyPL3XYLN+ZgtZ7iIu9sJEKlYakHGodYeK6oFhxPN0SH2dFMIEV6e5CF6ftxCJ70q57Zk5zG2lvzdkZ36CP2V0WC1h4dK2Vn/rgtIMyMIlWfCmagRSKA1C4U9XDDf3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/n9Kb0YSkdc2xdselGhttnNnVYXIWP0A4ahCl/Jctw=;
 b=NMijDe5CMoHjVvTQHeJD+gwxxoXQYJb1u/Kv67pO5YoYQt3G9wVmzMqsVSG42SHfAgyERJ3KrkM40qk1YMWj7cXHF2NK5ousvIPn8868j1LSDsQM053mcfUB/WZOBtaZaQl+oNf/IETkU+SHx07JVsZywsLB7QFwuXTtz09vQTBzL357AkZk6CQnfZRRgSjS0CKZKFkx/GpfIt1plboNWp3pfr2efgUD/YFSmRtYo7TNIcE37EjegQ+18WBdz+Gah9Ia7gi45wGOtZFUHStoaf4ENWvnkJoqdfb20vMMENd3qVVEm8Q7jl62rcmIBxkvwofTw2sYW8I/AWkt427FOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/n9Kb0YSkdc2xdselGhttnNnVYXIWP0A4ahCl/Jctw=;
 b=fTwAlG5QQxP9BgjXukywDfq5fs+2D2qHycopgt0EYnpZOqJPSsJUQp4hNpnH4obtqWTAS+MXnw8k4Mqa0IFp6CC8eWD8RuqCro1ZTjimGAY4UNonmmoxI2eazQplTlSGVJ/8sIU/rghUPQ1f8HEEc1c7tJb57ohn0RRxHDURZRXy16olTdN7zAQXxSD28Uv1Tc2sZg/XnyzNk27tHKrtIs2HfWefFt+vFbBVJMG1BnQJGJPuqZ/AUdSh+roGSCZlNG2jDQjUHZghPxccqbcurgFFeiHzdyO/iuFerUf8Wd7Yt/mLJjn+bf6FPgKjIvpf2aAFI57G/AgAzxMPVJ/ReA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by BY5PR12MB4146.namprd12.prod.outlook.com (2603:10b6:a03:20d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 14:37:24 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 14:37:24 +0000
Date: Mon, 6 Oct 2025 11:37:22 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: nicolinc@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	will@kernel.org, joro@8bytes.org, kevin.tian@intel.com,
	jsnitsel@redhat.com, vasant.hegde@amd.com, iommu@lists.linux.dev,
	santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
	jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
	wnliu@google.com, gptran@google.com, kpsingh@google.com,
	joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
Subject: Re: [PATCH v2 04/12] iommu/amd: Make amd_iommu_device_flush_dte()
 non-static
Message-ID: <20251006143722.GQ3360665@nvidia.com>
References: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
 <20251001060954.5030-5-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001060954.5030-5-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: MN0P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::13) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|BY5PR12MB4146:EE_
X-MS-Office365-Filtering-Correlation-Id: 218ace0f-28e3-4bcd-ace7-08de04e5dd36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0wJjl0eWdWENUMDTXJTR5lQkjdvMX1eCveeXfdTnjpGIsoQPKznZrBjbDtmT?=
 =?us-ascii?Q?48Ehux5c5axPVEYsgJAszHxQmTec6ekKdsCy7B/Q3D2tq5/KpGrWWocO5JVr?=
 =?us-ascii?Q?SyATsVRHT7uCfYnI97sUH6khxmkfEyu1ghDXH76vL35g6Y1eMviQvaTEn7Ip?=
 =?us-ascii?Q?inI8mBsmTQDN4B2WjcNM1DFccxEBtFIBhzuiGM5ufupvK+cJ0ZMS2y/0IPWy?=
 =?us-ascii?Q?f144nGoM1ZnLilBRfK+5ob3HruJA/524ZAeoRHhgwi9MFlts0EYWtBk5BGIS?=
 =?us-ascii?Q?j0NdjlzbI/QoJCDJcKGcXaGvo5MJBEduqVMMeP0PLGFqm4hGBCXeH6hwoPRl?=
 =?us-ascii?Q?HHRC2lSc/vZbnBx5TxvlQ7Abqd8q8IlYVmkBb+qz6+uz+scL9sGPNonwdmXs?=
 =?us-ascii?Q?zqe4eXCSIYaX8fdZbvZq2qx2ToS2oYsa9qZ2nXkdpsjn17e1+WilXHNrdLwN?=
 =?us-ascii?Q?5tEblPVZMg6krCbl9Rm73ZlJGS4ldsQo9do5xcLrfacpac3dwX++u6pocEPd?=
 =?us-ascii?Q?Mjq6spEVs1BH98M/rQ2Gg0YLUs5MdN/cP8f1ncIgPcIAu4GZr81wL/eMDx3I?=
 =?us-ascii?Q?s20rGUST53BC9FbaboeH53sudKbchEP2IN2j1UvRDLJx6OOfut8okR16NiVi?=
 =?us-ascii?Q?HjF8nghJamMmnhrYe4UVFepPYzXFitMPQNHerYVM2Y7xRYy05rdf7To9wlln?=
 =?us-ascii?Q?6ctWgc4XaZcBUtEVrdcnKUQ2kVYimmBtXDZlkn63E9ORCH0n9nG1A0IOG3bs?=
 =?us-ascii?Q?MHYVW1UBwwy1B7Fp3/G9hFLoT9AHjWjXjNcF3hm4hP77bA4InBtt9WRNbTpj?=
 =?us-ascii?Q?j6kliPeFSTXvHHc7bcjR+1DYwipUI0RqDmefw2rZNgPnzVxMR9tJDOhJAz3B?=
 =?us-ascii?Q?JOk6JfryJSJS5HA31nqJ+TxdHUnoQmU4OQbu6R0wAAXlLE8YAcm/g8KGpiNw?=
 =?us-ascii?Q?DtLexpYp5/KBSSBDhJ+cc99Zouie1tgaXf6eNvP+EFl5yNew1aQYYGlVnM3H?=
 =?us-ascii?Q?Dd3uZ8HYMOH5thErdy/a64OPNAfrquLyA8QnebDG+BBoU32X5FuUKnXKWqGa?=
 =?us-ascii?Q?e1u+qAXXNlCLGfHXAmXduwUfWRBAsXnkaE4oeH1gLESDoZ07FCFgS4VXIydc?=
 =?us-ascii?Q?zmq6Ystt15E0gflchc1lqbQ7goCncnJapVEqE4drRzJN1vN+xyDqMfC7SSAT?=
 =?us-ascii?Q?nL8P69nHMTcH8PCyfFxe+U57KVwSl9k6iZ2/IysI8GLFf9XjvVNDJB9k/uq4?=
 =?us-ascii?Q?W3UE4uWP67lGh7NBrlTIQC/+J8cDY6ubbcDU5d1lepXRmZgbQ+fjsWBNxt3D?=
 =?us-ascii?Q?9NfaqqDkI/pi/y/0QuvoxmCF5jqLU6C7WaLsREwmAQ1z+L9Sn4UdRBBDj4yp?=
 =?us-ascii?Q?HP8mFVWAQ/6G9Bxvq1EI8YygUGBajaFLgPDmgI/DEsqr5pU0oF1yk3rQfAUW?=
 =?us-ascii?Q?imQIHxES+PItsv00NlCo5tiGuByyLigN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RpEgkvj3Z2tHv0qtkR7i/L3Jc0rpPc9U7EQy0kbW9gnNvsrirk63ZiCZqUqB?=
 =?us-ascii?Q?wLiiVHsSmux2eQy85xKRFTky+xdigTSrLjBMDVEVSXhE++9PJnmQwNKiEkRT?=
 =?us-ascii?Q?dnfvO4D+aC+1m0Kj9YC9p7e5hR6CJdx15W1kyr4Y8X8PbdjSeoUp6OKkxmkl?=
 =?us-ascii?Q?otsPzjOpTzjNcSYz2xJKWiK/cwjUdYJuSKkyLBTrG2KHhVK98c5vMGvju/6Y?=
 =?us-ascii?Q?S8ZFVNVN5eKCRckAkcYP5n310ccsTHk4H2ee8eVDdNnryMm6Np2ctTQGm3jR?=
 =?us-ascii?Q?fOo73huU6FDQrrWQewXwgWLdcihWMr9F8kpH1YaIcy+G1H4LVdTT7Q2Vohh2?=
 =?us-ascii?Q?yVVQCG4plZy0Oa62PaBMlWv3jF4IzDXaD2dFti943K9OhZDH8BUlBwuMsHiW?=
 =?us-ascii?Q?r56b4IEnfHVnm3ByoPy40poIiZdvNRl1hZrN/y5S4fVYsalH78RYbieDXW0L?=
 =?us-ascii?Q?WtNvKJ+lDB+eadxtxj2skFdX+PxwD+kOGqeBagUpa3FNagfM0LM+OxMqHEdI?=
 =?us-ascii?Q?80DVka1kXXHGtPlNrMjoAIHohSQ+6TdTiKeMH84w/Y3IGh8Nk2Eq6t6P8kKQ?=
 =?us-ascii?Q?SFNzpbVxd1uReM0HAywf+TQp9NU3zlIhhvN4DPyq7gimLVajthTRhjky6XPD?=
 =?us-ascii?Q?IW6YWJEuhJ46JzvzafOmnZUsewckD77UHDvmKCRFnYwweIPq3TOL0Z8VwSsa?=
 =?us-ascii?Q?uWNe7clyhmL/ktCfj5qRTF4VYhv1zRlI5faUdQikrEYetiKyEtYuFsDGQEHv?=
 =?us-ascii?Q?R6LGAvabnK+4M1smPKqLh196AR854swR7nyNxRzTj8H+BBpNkYpJcHcbPyNW?=
 =?us-ascii?Q?DSjjaXoZaTJTfpyAs/dajyUExyfn04lJTn1fPfy4EwCCEnRfTBulNOngvqnU?=
 =?us-ascii?Q?xXLc23mcjiGJEAPluA3fHeaBLazS//cy7wyxqNsFRs4o0Gd+cAoc5CPnmNOc?=
 =?us-ascii?Q?Gwi8jaxVcc088mfHXggB1/z/0THeLYndR7+X9MbXYekwR8vn/AjPk8UsQjlC?=
 =?us-ascii?Q?FBaxEz/ZdbqzuXceIE8VuxdXDRjEDdq3j9oTh7JrfDCRZ5Ypw0bdTeGof1YO?=
 =?us-ascii?Q?ynVNbNiUGVxgN/dHnznGwFP7Pxt+ST+KGmDRQffbdEF/R9r/tXThlV6gre7u?=
 =?us-ascii?Q?H4c72W6EzXCvbJ7XcXqb9t9eCe9D3sjE+4PqeGW0wI6HhgYiYc/L+1PD87MV?=
 =?us-ascii?Q?N+0i/6/FfIwtACA3mPOY9oRNZ5NF+VWg+OmJ1+X4G3XKsoxFlNZ6MbRWdayg?=
 =?us-ascii?Q?VFT5TEE6UVGqMIIfHb0XFhFMnXi/wXiwjfGtA5oqdHzphMeZnsUFcNXOA5pR?=
 =?us-ascii?Q?Nthv+sKftmd9Cm+41glZidn+ghfLzdh3AqpSc0g/1U41R9gt10XMQ0NO/mHe?=
 =?us-ascii?Q?0vQIxdKUVLvBfrEqoUZBF7URjjmdsZ3/GvWpCV01qQqmQurayG5CJM5Jhear?=
 =?us-ascii?Q?kW+4aX8z5PdzxGypmIpXqdVzO9HHJV9I1JCr27Y6MFxXe9cqRg64zMt7+r0X?=
 =?us-ascii?Q?g+SVRqXC0cHAKv2SGYm9ZkSMr8OU6GK2ZYwLQ4rvoi4E1NYmQMkUw3mZ5iuX?=
 =?us-ascii?Q?10C1w1ivlqkZcuLFfu8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 218ace0f-28e3-4bcd-ace7-08de04e5dd36
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 14:37:24.0775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ARWBTsX0m+WuaJ23rayeuKI1ADYPt+rjtxUrbUV8Oo7ws24qABFPCkY8kRy2LHYj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4146

On Wed, Oct 01, 2025 at 06:09:46AM +0000, Suravee Suthikulpanit wrote:
> To allow reuse in other files in subsequent patches.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h | 3 +++
>  drivers/iommu/amd/iommu.c     | 8 ++++----
>  2 files changed, 7 insertions(+), 4 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
