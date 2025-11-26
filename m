Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012020.outbound.protection.outlook.com [52.101.43.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215D8286400
	for <iommu@lists.linux.dev>; Wed, 26 Nov 2025 18:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764182179; cv=fail; b=h+DjVzyAy+oGLH06uATCBaKPH+ibK9oJBG0N6Sd6iMaadKd+tQuQo/wcE4WPMscVYjutK+eg4jBA6T3AEVXYcGCvCQHrLgI9/mZhM/ROx5++4qdniuBrsFm2+i/D2xsoGW0hWIcK4QfJNWx3eq6uFM0sG/uCD50bRmzOsyPEBv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764182179; c=relaxed/simple;
	bh=XSr2oehm8jHQ38aioPZY+qmWtg6H4udbcMK4RAwgA6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LsV1pHH81Pqp0HLREPzcpJSjsM91LWDPQTVPwlzkdpNtfugIZrrX0EtCqRVTmCZei8XjR05dtq5HBexSntUA0GvbFdqCG5rt+91V2geGqCtUjmb6o2okgvd06hlsworRxyffkKQz3cJRW41rL1Gu4RScVXMO65jbQ3WypQyOovg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W06AVmRo; arc=fail smtp.client-ip=52.101.43.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W06AVmRo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgeHVFY3S1FewdcHHhVLjnHWmKXzfsBoX+fmoYb/zg3s5XpWmnFPRWjtT1FfYhcAgW7Z26HuinRPHVrD7xVbEeLwTYnTYsR2iST+M8B48Eo1OHIbN7XTSK2C9ta7f7SyksRBduq9Swah5aUUY14MSkvnP+YBx+Ea4WT/Mx+I9BYg/JxXNuYa/4gtNP8U+BVupMGZDZUVnyKC7AriEm2uk4Mj7vIf1gOzyppLrp0SKFhfz8BcMNoyARWX++XGP4ugvcYGxx96mu0+KknVZt8EE/RTzVFs+4ewuE0PCxXh+CWu6yIVyitCuEC1IPWBRAiE20X/zM+PbwpCBxLNrpI5fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gcoH50kfunZJ6OK/oWTLqL9LnReDSn6WKo/O8bJKTRY=;
 b=g8CkzOesZiywJYLAqjX9HfcqWoEcOR1xbv+YGtcwk81EWu5rEP72RgGRal2n/BcDXRXlAZOqXWiTs6vBnmJP/TgRNP/lMxuaOHiNcSDUxwQVEsWy0LFTMM5v21nnln4mF35EQ9RWMpaZlRO/AJHvmVgplVJMW3FnsKdyqt/aSa33dt2g4yhLQW1aKb5bBt8yqFerAgBzsQIiIk6f9ZkMX2nMxhVp4CjnpQoFGo5L9rRg8B6Qk/6v+Uu8SUwJlktPrdCUpUpiZEswt0Fct28L3gQLBXxaVirDiCDyhWRnDECit7WKki1Z9Pn6LCzbP/mbOk9DlA5nBehtkaLoF2zRlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcoH50kfunZJ6OK/oWTLqL9LnReDSn6WKo/O8bJKTRY=;
 b=W06AVmRoBFxpT5CIm2Ttazt4n5jLDjAFQMohaazjPfskxAGytWo2g1aY31/YcqYzAHtC11AV5kekL77KDmi9pucJoSQ4YB2o0ZH3cs3dtMACyngvoJLdMCKSq8gs1mfxDbDTLplODavrTJy72Sp6qLD4Aejt4V1uGAMzbOnWWJ/es1kbOgPCloMc/kl7GDiAPPK72UHxTQJzcIf3QMUxLMSZ4rEhh+lN1FUl9kYYYsdM9M5M54a1hBDVyOimbojGT3zDJHD37SqFUCfSIKBRirhoNT7EEeaBkTk1F0EZJW6vsNdFDj9tgS7hpWm8/F16v+RhQF9ILEd10RQbt7pQAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Wed, 26 Nov
 2025 18:36:11 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Wed, 26 Nov 2025
 18:36:11 +0000
Date: Wed, 26 Nov 2025 14:36:10 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, jean-philippe@linaro.org, robin.murphy@arm.com,
	joro@8bytes.org, balbirs@nvidia.com, miko.lenczewski@arm.com,
	peterz@infradead.org, kevin.tian@intel.com, praan@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/7] iommu/arm-smmu-v3: Introduce a per-domain
 arm_smmu_invs array
Message-ID: <20251126183610.GL520526@nvidia.com>
References: <cover.1764119291.git.nicolinc@nvidia.com>
 <8d02cbd9e58fe99f6a7576934d34b440b89e8c9d.1764119291.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d02cbd9e58fe99f6a7576934d34b440b89e8c9d.1764119291.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL0PR0102CA0016.prod.exchangelabs.com
 (2603:10b6:207:18::29) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|CH2PR12MB4198:EE_
X-MS-Office365-Filtering-Correlation-Id: f170bc76-c751-403d-eefe-08de2d1aac2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p1F0GWgI5GQWPTcbGlzWHFVX8S1x5fRwZaxiNsHcWw2VjSru/mfq89Uj+YUd?=
 =?us-ascii?Q?6FTypEiJq9oTydygYX4okUP6F89v0S1TsSNY16bJoIYfSbpbci9lC1GCQSbt?=
 =?us-ascii?Q?wBlc1ZGSPe1eXmFNtt7vkeNoqw0+QjwSs398dCduvqoges5TTFptEmAko6XB?=
 =?us-ascii?Q?hMKdWNnNByCIQIrFsd7F6U39wMrfalNXYt4/oaedPo/ZwkYUoCzTOAvRQ/60?=
 =?us-ascii?Q?gG1DL2zMLBYZYaRzduWvixcCIyenHJHFknkQi7UevT6Uv1RYlbnBrCv1Dtuv?=
 =?us-ascii?Q?Yy6mCsOEUA0qUtefYicNzy64IRmNdi58QowsAiAC3v7tNry4UZ9G86TvB2rK?=
 =?us-ascii?Q?k2jif4QNCrcieubUh6yG6iOgcbHjqdt2WWkPz1/3Rfkr3rOd5qHIIRzJlRZf?=
 =?us-ascii?Q?6oXDQc/NE0tFDia2m5smbfA4s/qVNoXUqL68yT9Ys53PxKadCR58MHFoSpEL?=
 =?us-ascii?Q?m+kxYHcM2spqxDyj1NE47Aoo9tJBbh27SqpeVEUtTT/Tyh2vAY6rd6vBu+80?=
 =?us-ascii?Q?f//T4ErzqYlgMfavc0FebHD4c0jHwCrPFpXg7qfIbFPGyQu75rCMqrwsndz4?=
 =?us-ascii?Q?6wpSL5YdgeajnPKupawS+K3SlL1VoWpoWQvM6KBJXaSZ6fkRn/I3bM90FcIj?=
 =?us-ascii?Q?zl3fpuwDdrZR/D5wuDgqVW0UMbB0ldROpEKIiFyDQjmA1aLp9XcLAQLezV9c?=
 =?us-ascii?Q?PHDXSMI8cAHj33JZhY8KFBIRNBUIhOADBLBDEZ9sEs6gU5LjpXuCU4FXbX8W?=
 =?us-ascii?Q?16f2Et8DWLPBNLP8FLuVP3MIyQ7ZZsZq7ntag8swnL9ydT4cLSAPK1zGBtOJ?=
 =?us-ascii?Q?aYZZSO532N2xrolBNWMOjN746MYW6l2HkBbbBNTPOS2y52YolDRbs/NX79zN?=
 =?us-ascii?Q?UUddXCFIFKG5ZQKnJFkjHCWayF0M6lBbeMqdUHveLnAcAESOa0HyUujBPUkx?=
 =?us-ascii?Q?IWSZYr7JEizEaaTCmV56IZLj0wK2fX4itV2kZODfxKObQ0s9ev1erV+LtdfK?=
 =?us-ascii?Q?Un1cwCAi8hjdW0Sbbd/hUVKjdsT9xEGpKREKL/BOqRPutdSnU9ecfT/uqEAO?=
 =?us-ascii?Q?1huwjqi/AV0fp9DQCUPZf4iobANs0onsONQtJjVsRuAVVkQwP/SLdw7VrDjL?=
 =?us-ascii?Q?X17MiqSeZb1ac4TBh8+MBysYupyQV57FQ0FxdWPLy+cJuHnBsroMmxubBsRP?=
 =?us-ascii?Q?2OOIG9VMoD/32ojjfTj/5dhuasqUh77tpi5MJXha3vQLJH0syIMBob9AZ83T?=
 =?us-ascii?Q?/ySJxKQrGsiLHyU+2tAB4E/sEumXARukIdcbIV+SPH6U6HrwLakK0+nVK97X?=
 =?us-ascii?Q?HV42PTkEdZ3gZIy9fzBAjjnfAkgKlkQDwn3k4Bx8vjoxjLT0tx7srA8oK8yb?=
 =?us-ascii?Q?jGYKnRIef3cDoKbKx0cQ5FXVOC6qKmPhejO+bdxeRORmoqJPzI9Yl8XcENaW?=
 =?us-ascii?Q?CrOEkRXqlQgN4A+7kimpnjd/k3SNA9Fp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FrwqfGnidx7LR2ath+RoIeWxN3r9o1uC6PfyksPEpPCgIDoCpRxNRJTKwLLu?=
 =?us-ascii?Q?zPipKrZEV428b6ueIZRPP6FsaChkoHZ1J+6mPGp7s77DxUuz3+VU0Go/wUVB?=
 =?us-ascii?Q?svMlTL5SSpTxA6VhqldhUcsWIvOCpxlh4vLpDnLFc6Xhp1jq7De5P6FbQJu1?=
 =?us-ascii?Q?1wmHKWNDouUMjon/6scb51eNWi/d/SZonXZue2TNEG2j0aezdOzOHMPFQ4b2?=
 =?us-ascii?Q?j9TDH37KUfkdb2j19MfhFRL8ODeY5amYLk4gc5c1LwTMFIbHZMKjAxDAUqpo?=
 =?us-ascii?Q?PCzIXDNwOIMNYEPXpKKn4Y0SFc6M2hno/cojqAEAirMAd95fcDjCM/AhPWxs?=
 =?us-ascii?Q?KAtHKs8cLCRMogAjTf7DWLYyWVDg7CpagvgjwmjfFKKECkMxYyvLIctu0StA?=
 =?us-ascii?Q?qDK7ajo+yb0IhsVlSPzVxsplFVPRfRWhNgtp9qWIcpLXKASLpttxGW6NF4sC?=
 =?us-ascii?Q?m2+/OHhf2CNMWgtPjpYSFgceT+lsPvFHXvsg0P7rDnDenoYMyP24oIwo66gk?=
 =?us-ascii?Q?zJFHnx8yuYEwFROuW3zp3+cV/O0ioqEoNyr7qrIfvBvWMk9akC59rife6Zo6?=
 =?us-ascii?Q?hLev/y08IWmJxb4iMJMe3/2MpuRtdFCTSq1AOpOnpsLp6k/GaM6/tE+TLby0?=
 =?us-ascii?Q?yUydc+1j4vR2IeZTaB8WYQ4C9+b2t3GqzQmOLyp9ew53ZY102WN6U5+cu8Oc?=
 =?us-ascii?Q?xyARwsxhdsXfflgjfC5jXZro8OC3jtHRO3DCXU08wmIsVHjdzO8TCZb4DTqK?=
 =?us-ascii?Q?O/WQGkWDDqrsfVM/t4FSP6bG9uM3UDabO8eFjHDjrPvcNATig22sXCeUiqHJ?=
 =?us-ascii?Q?Nj7ocberNSXlWHcMZEjjLnN3XCpQZRj1REAMRCvVFvZfFo37d2eLp1gO0l6X?=
 =?us-ascii?Q?Lk08rkjtbqMm6Eil9djhAIRfeI+BhWJopAlyMtGAajy4MEjhzBs44+IXEpRT?=
 =?us-ascii?Q?IxDFO0BstJ9tYaRzZNjSrtk+y2Ybj0l007DYm8EvY70Xqg4lxJ6eOAFoG4aI?=
 =?us-ascii?Q?/VMjTaBmvybHsJvCo5ZxnvIDnjKdN2OTs7Fyq7BM1GX66jxasPnwAbwEUaZl?=
 =?us-ascii?Q?eiK4tpLtLrjIuCvi0BCs91+poF06U9s4MhwtPn0Yp3fIGlfNA2o+4XBRNWR/?=
 =?us-ascii?Q?7FLXmuxlAEjIVMCnUjYeRdL4jB8RVB/P6wR5gTQRyiz5vBY7geEtfW0N/Q9f?=
 =?us-ascii?Q?QVRPMplffNefZ4owNIwdzzgJoojAXNrxq3hTEvUE3uw9I9edYLFzT1E+u6KT?=
 =?us-ascii?Q?WJNubRg2Cq+6qBHCZvH4OYGK65Kl9hHOXaZyKci36OiHBglsB8SYAOJYh8dn?=
 =?us-ascii?Q?YB8kq9VbSelm8CIlQZDa9/B/2vuwbw7nirm5Wsr8gmA0LT9JpDGNbib+DVgs?=
 =?us-ascii?Q?Bnr+jkwM4OfEY3jAKYYMztk2ynyYclZf4EKfO3ZV66CdPXcn2Ft5U8Ix590v?=
 =?us-ascii?Q?h5IlkhZ5/BsvIVEDXVLA05uVxWmWgIeMVpFIXD3gSaEuWej9JFTVv0G241z9?=
 =?us-ascii?Q?U/GfrLX+DdmzbdEn7GEWtHMDGzMABFsFCr6fhhARFIcFwUo63uBdpJTbvxc7?=
 =?us-ascii?Q?q3X/VQjYz/L/RcOySIw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f170bc76-c751-403d-eefe-08de2d1aac2e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 18:36:11.5828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oItaZJ1un2gdFdzZ2gnA3q2JJNHfo/2kc4+9STgmSEXOARnKOnzx9y712Vkh6glU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4198

On Tue, Nov 25, 2025 at 05:10:08PM -0800, Nicolin Chen wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> Create a new data structure to hold an array of invalidations that need to
> be performed for the domain based on what masters are attached, to replace
> the single smmu pointer and linked list of masters in the current design.
> 
> Each array entry holds one of the invalidation actions - S1_ASID, S2_VMID,
> ATS or their variant with information to feed invalidation commands to HW.
> It is structured so that multiple SMMUs can participate in the same array,
> removing one key limitation of the current system.
> 
> To maximize performance, a sorted array is used as the data structure. It
> allows grouping SYNCs together to parallelize invalidations. For instance,
> it will group all the ATS entries after the ASID/VMID entry, so they will
> all be pushed to the PCI devices in parallel with one SYNC.
> 
> To minimize the locking cost on the invalidation fast path (reader of the
> invalidation array), the array is managed with RCU.
> 
> Provide a set of APIs to add/delete entries to/from an array, which cover
> cannot-fail attach cases, e.g. attaching to arm_smmu_blocked_domain. Also
> add kunit coverage for those APIs.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  97 +++++++
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  |  92 +++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 256 ++++++++++++++++++
>  3 files changed, 445 insertions(+)

New version looks good

Jason
