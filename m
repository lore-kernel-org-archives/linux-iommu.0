Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2068.outbound.protection.outlook.com [40.107.95.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A1B1741D2
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 12:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723812454; cv=fail; b=DwLgqsWJ3alUqy6nuvhjGnGT1i+HSVqh3kz4mif2q60aRqvAz5KB6Cqk5TtA50/Dg0muY1e+H1EHaxGawfYs+Ixh490R7Hedh4Jw3hvNQfEyFCDEIZf42y+KGvCnu2M6ScBBRY90JXkVKcXNNZ9TF2DLfyMLz4VIvl7JNpu640c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723812454; c=relaxed/simple;
	bh=Io0PHjz9TdDLzgcTh9nqyZAfGbpumKAm/SIuK+p/tA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tUDkMSrNefWW4RmWjrfVMi/blef1guUCgugaB1aMd4OMfce+czLAvCU5ZmTkZOLSWL+JLJ5hE1Y/mgpwaXuy+mfITxAcT4vg6s+fRc6ef20JsHoDDpkImucrx+4WPo3cd47rd6OmVRfeIC182B4HEud/PqDcoYIDANUz0G1YSJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bvx6LURB; arc=fail smtp.client-ip=40.107.95.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bvx6LURB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sPFlXFme1TuufpORMaRWxOxOV5qLiXlusMBThX3GA34kC4t62wMGW4BHrQBC41/zg7It+iSzGadAy9yElhWTZMvngxuOf9+7KDGiUc79Tq4ggClN82n3mkJssYge+jRTK3quh5ZYZDEevCsV8kPkvHhrGkz6GbLrbRW9n+TUC60QGmBUS4Nhdtc7IFpJ4RZ++hS9hBSwsKo4t+fL6/s4GxZawYcXnbsNh9uxxXel31rmjQ7SP4t4fBFlWTcBKeK2CSmCt6KaAd46IRg1pBVAmOrClYXpyAJlvPTV/lR9n8U34XNOscy/1mIkBUwCzeypoiHcb1QTM55ApDG2jzSMQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUNTDoRyJvUgMMKt1Zv1iAf9v4NZCQhzzaZcH1RF6DE=;
 b=p593HxXoMD2WtEC6Uslfeqp0S4BLbFkYRZ8k2mMTRyuBs/4kBj2ZToy1Pej8xL2P6af28+LyobwW56URTYZIUS+sMfTKFBxfwbqbvnzq+ljn88SgdWE+I9ts9bNxwdSQCcuIrz6JWyluv2EoWq5TQteK+KSHF7UNWo7shf/k0cRTKt+fc7IGxqELO4ilu8cn4VJFRTwjggZ4WMgu/X0/KzUVyDN5PZMswKjj9nye5wMM73LLNLuQDhvtW+gAFTAHoWk1npFes+0aomlAReTWRU2VUXRbGhppLFehF10I8BKfJI8yAKIGTkEj9hA+kprp+7jDGWhPaTGK3yY1rcso8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUNTDoRyJvUgMMKt1Zv1iAf9v4NZCQhzzaZcH1RF6DE=;
 b=bvx6LURB0+SrOkYZ4RGAnFCVp2SGeKPfbLjfLgCIL3Un4IW10OWHOSuEkM5H0nO4BASFMFZPKLtLLtHQZ0ikrZF1igaZd9Dr4G20307RNoM8MKmS1HO+/4ZR4rqWWFlVqxCzBtXBJzorIL6Wi7Ub8O0fyQxkZu3UjNkDgoxS5AOhU1qrQFNWNjS3e+fEj9iKsVuGdxi+62p8QN1xA7uyazU6vFCOXxdORgiaPoT3IEnEQLK6hAPGwgn7Ss3NH2lOmThTJR/WqRpi7XBGCeVOPuxcuKiyVxHOjr+jIPblTD56aVa1Nexpx2utvCwfNpFipq31hQ5UmpolWHSxbcPgfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by MN2PR12MB4158.namprd12.prod.outlook.com (2603:10b6:208:15f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 16 Aug
 2024 12:47:28 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 12:47:28 +0000
Date: Fri, 16 Aug 2024 09:47:07 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: Two opens about iommufd pasid + IOPF
Message-ID: <20240816124707.GZ2032816@nvidia.com>
References: <0bf383b7-ed96-49ca-b1da-d1fff48e161a@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bf383b7-ed96-49ca-b1da-d1fff48e161a@intel.com>
X-ClientProxiedBy: MN2PR16CA0048.namprd16.prod.outlook.com
 (2603:10b6:208:234::17) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|MN2PR12MB4158:EE_
X-MS-Office365-Filtering-Correlation-Id: 1af5d75c-5f4e-4bcf-43e6-08dcbdf19616
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9c3Q37BHaY64tMGyM/yYXlOxQ88SLmFnNlsVFQznNlHgmBDh/Yh+iIyxuec9?=
 =?us-ascii?Q?NIFGuVSy1aGq7vmBnBzz1PDUlP0hlVJPSYV8Ulsvdx7GfvEVIAjcsxA1VN03?=
 =?us-ascii?Q?Anv4hP1GyN66ZLC0egYf2NwKKvWYe5s/x8EsiCr2NzYheJZ5EK+tKNBY/bTV?=
 =?us-ascii?Q?y7xLmeFPzsAMOT/BLdZsNZf2JzEHJx1BJziOtNSzpBfO4O/QA8BQL4vkBWu4?=
 =?us-ascii?Q?M5sI1K7JfT1CbrdfJdjPnRV2Z6yEys5HLcuzKYsG644quM34uKxhwDy7o4Ed?=
 =?us-ascii?Q?YuIIehlQBfQx249ZwfvvGZOz2t3RixocvM8ShVUGJmIX3wlfVXFaJV4Y3HCP?=
 =?us-ascii?Q?yMPsop4efLYoSANNvONEDwIq29ymd4N4SyrfBeqylFSvHxOF1vmtq+h6iC7I?=
 =?us-ascii?Q?jyXlY8b/AsXkR9KPGzwlR0zXIgAaX0NYK4/VEIKLSUVX+HVlnUWhGDdJaqsx?=
 =?us-ascii?Q?ovii+KxEJED+6ax+J+Amf6cdUzw7licpBOixEVlu04zJVWesTGjcJp0TU9cv?=
 =?us-ascii?Q?mmgIX3TkU5aawXHSOXYTbRHg9eUl9AZXug7+xR9e8qIrTuwut6cBzN2VCJA0?=
 =?us-ascii?Q?9FutcBVVNyQlLgMC+KvgLl3X2QgLojvJvAX1AJYsNvBpPI2dy+xayjW/5G6G?=
 =?us-ascii?Q?5UDFJ3b9KDm81FFnNuDKbCVrWBIECNPSibvSE3pZd1V7JT7hRgYQ4IzPLULr?=
 =?us-ascii?Q?Ixh1TCM8lEBi4794WDsubkUAIen5nyDDmuLsrYqWPrXNMd8LetEBjqIOmHWN?=
 =?us-ascii?Q?FMEXbhpYnXPkNWeS2i5zeGPizqx0tQ/CgkvUv+9gMeAphWd4QOJ1nVoG16Pz?=
 =?us-ascii?Q?Dq7Rt1K6JSD/usFAyiMgD32CclTMZtGTNbbx59x/FKwNMQyXYR/z0BdqtMs6?=
 =?us-ascii?Q?RMnIUA6m4nRwsFpV1wb75kDZPtDv7bzPMHTBxWWmVtdZDkhyRdQ+NWerwg1c?=
 =?us-ascii?Q?DAzdD2RFVzSTFmPz1njGCyOiqzXuqGJOC0NgtmAK+jsrk0c4QnO1ZR6WXty7?=
 =?us-ascii?Q?DrnkBuxUuw+7cjQiOBBQHPdeGkj0oiclHlpTmEQRQj4EAf54JFryNR//tofu?=
 =?us-ascii?Q?IWF28vlRmIvnzO5MfQSAFwhRcdd++ZSn/2k/x8VSLQXMVTRk6SG9I2eKB6Pv?=
 =?us-ascii?Q?5cDmiphxed1QtMyBl9buwA4vrn3/4kBqcwFF+/F+0FBdr9TyvHOveNNUZ7G0?=
 =?us-ascii?Q?RN6bVR5R3w6jewcaEvjMnjid1ucL6Lljtgi3vYy4uMH586OR+i/WcNQX9C/V?=
 =?us-ascii?Q?Ag8DJ1XtPcZmD6+mc0igphNKoeVEPdORWw6U9YQt9hN2yhwL/uUBn1lp7qA5?=
 =?us-ascii?Q?TbuCJOL1kxE2UBzG81e2nHiUUvBlTpOpKiR6sjS3LGV09CmBVVwrgigPiwNo?=
 =?us-ascii?Q?3ueNEtg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x64nMdwLcj1qefz90XGZbbKrfr6qgZuqola4FgcGGH71qwCzFJS/2qg509c5?=
 =?us-ascii?Q?kF18IkMT6XE8K33DwbSLClzH/EunH48xt/q3+qhpZLn+r/STTM8nljPFtxFV?=
 =?us-ascii?Q?DNCfOI1UHZs7GTeYi8QBSdBLSgX1yCEBYS3SiYldP9tpIuShRVaDtcshHxt7?=
 =?us-ascii?Q?eAVmfvxvj9XcFK7WVtm4gX0swYgWqi+0/1mDGqOtq2Rp7igqRCHDUED/wgm9?=
 =?us-ascii?Q?H3V9X+3puIWjmY90gNordwOKJrG3GEnViq+Hy+mREt0+xAz6LMG3LJa8Du/g?=
 =?us-ascii?Q?vKMQEeM/9AxTMsL4T4oJ3Xjoj07enzMX+AWnGAynlB3kW3psP3mSdDf3/TnK?=
 =?us-ascii?Q?FrQonhHKqNjWcrcRNpgfD+VuXdA2zPZQE0je5LPkjZz70nixwepveIzkbgWQ?=
 =?us-ascii?Q?QtyUgDxZSCnYCnwMU/H+EWjWMEkMvocWK0blm9ffPeUUy60gnWCwdmOuW3DR?=
 =?us-ascii?Q?PEyUbECT2ovPjrZhfm+M5F14q0YYxcOdG5UFAiTx2bVGqPbAvLt4aE41Zn4j?=
 =?us-ascii?Q?Dm3itOd/x/O8Zk22l36bW7iwPcwYDEK67sU1EtteYvol4yHkBPKIZM8TrH9U?=
 =?us-ascii?Q?VdwQ7pq4SqYPcPSUshzkJDA0RWr911Dt2Hx0lVU7ZrkzJAAjKWMOMoLDJVW1?=
 =?us-ascii?Q?H6mjeW0v9zNEiw9n1TAg//K3f40Lne5poQU/muhhLTnEDlU6jA9JNOfQBlMJ?=
 =?us-ascii?Q?JrOat6BC1g0unarTRhEFEOry+qi3xzgHyCr57I1Ua+iySVp8Fq4be+WRIcbg?=
 =?us-ascii?Q?D4zXYGOas6qr7HkjUPd8jDRDFFxmNdztSf9NfPIJXNCM5lMvK0ZOJLDO+mfB?=
 =?us-ascii?Q?ohqr1nf+b6T88XOsLmUQIz20O/vwxTqHEaFNSxYmwk2jCHKMMgN8zpaMToqX?=
 =?us-ascii?Q?ja8u6yCHNVBgpPECpFQw1zMGFXhAOgcAw0x6jaDL7Jz8HnDWhXwKX04mL5dw?=
 =?us-ascii?Q?BT0XW8kk1aCi+htUJ2U1i7mXmARkJlhF1EKIzwvXVoc9FcgaH6g5xWHD5F/5?=
 =?us-ascii?Q?QsMRzPvWTLheV3V2XOkJJWlUSE4TjSLas4Wk4IfMzFB63dscYuPvbQj7VMnN?=
 =?us-ascii?Q?n9fsOUpiQU+bXP+78byo/ZrGOaJ86ZY9oAEXX6CtMdDCg2ndXwJkvScm2wPS?=
 =?us-ascii?Q?hKQUPP/ECaOhmYtFEz2eyJ7o68XbMTMEX9fuTBxeR8yzNEF6Kl2RG4Vdn0/a?=
 =?us-ascii?Q?AdsSQWRCmD/rpCGa0nmxEySLQRIS29BF8L//oDR/XTvnpaW58cNHGNwZ4crX?=
 =?us-ascii?Q?peokAVrWADIsM0ZH8jzgV0D1BgZkg5MhI3MuRnm4mvxn56fONCdGrCZWU+9q?=
 =?us-ascii?Q?BF/ZceFEECMrsL/BZEpXcnvqhMJZWFHiyd16ARIpTXSQrrfdWlRDifHfH11H?=
 =?us-ascii?Q?hK0OhWQDNvmXEMnkVQZPUjeGzvbnn5ypg56iUNPcQqLI+KM/STBA/8v/FF66?=
 =?us-ascii?Q?BediLOzuVNc24ouqoczpDbSz+B1/ysrIjqcekR/kliFz1YvF5jTTwGcDsCl5?=
 =?us-ascii?Q?ZLqoSdl03ulHir5aAIYq9SK8mbgRvn8JVxB6Wngy6w66/18EkyX58jgt7dUm?=
 =?us-ascii?Q?m6xKWQqeGsZeyMs58nM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af5d75c-5f4e-4bcf-43e6-08dcbdf19616
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 12:47:28.4048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FHGDKYUGJuYYGkPlMwXTKzh+eDAY4W+PO7x2ZFZT6fpIU7kEp8PbTgRG9gFC/mT6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4158

On Fri, Aug 16, 2024 at 07:50:05PM +0800, Yi Liu wrote:
> Hi Kevin, Baolu, Jason,
> 
> I've got two opens when rebasing iommufd pasid series on top of 6.11.
> Would like to hear about your ideas. :)
> 
> 1) How to retrieve attached domain for pasid in the iommu core. This is
>    needed when adding domain replacement for pasid. In the before, it can
>    be done by searching the group->pasid_array[1]. However, the
>    group->pasid_array stores iommu_attach_handle after the iopf patch [2].
>    IIUC, iommu_attach_handle is passed only when the domain is
>    iopf-capable. So, if the old domain does not support iopf, then it's not
>    able to get this old domain from the group->pasid_array when trying to
>    do domain replacement. :(
>    Not sure if any side-effect if I always pass an iommu_attach_handle even
>    if the hwpt/domain is not iopf-capable. @Baolu?

You should always pass the handle

Alternatively you could use the xa based encoding I showed earlier to
store either handles or naked domains in the xarray. But really it
seems just fine to have iommufd allocate handle memory

> 2) Should I enable/disable IOPF when attaching/detaching pasid to/from
>    domains just like patch [3] does?
> 
> [1] https://lore.kernel.org/linux-iommu/20240628090557.50898-2-yi.l.liu@intel.com/
> [2] https://lore.kernel.org/linux-iommu/20240702063444.105814-2-baolu.lu@linux.intel.com/
> [3] https://lore.kernel.org/linux-iommu/20240702063444.105814-8-baolu.lu@linux.intel.com/

I would really like to remove IOMMU_DEV_FEAT_IOPF...

Jason
