Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2053.outbound.protection.outlook.com [40.107.102.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7A02755E8
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 21:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740606335; cv=fail; b=c27aik4PFLk6OCsfopPlNYVcgEjfsbYox9xUSWQS8QkOlsa1WIZ0nea/RdjuITIK5PYzUgaoQBMOqgnalzpNiFqWvXmKFuM42mIYXlfiJe9gJn4ISGFTuEKXXfQ0hjoOIG87koF1FRhRF1lvkko8sOjA4bu7Fo4ZAN5T16lpxbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740606335; c=relaxed/simple;
	bh=4gihVMi9rnweGiNdpRn9OWHkHbAX4IzCH9Ay609c/uY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xo5JnmK1Hn4idsiDuQLGLf/qTSQn2XzY6I1Bi3wFQJaqzntNcQRzuH4W6u1aZsB2FKfF4qyRtl6876mVmVo9m7/k5KObHsK5XROLT0E5yrGgx+Vh0zjEs/ePRfph14glY+KC3gDYyC7207AJrM72hZlrl9FigIXBg68MU8Igch4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mm7Fey85; arc=fail smtp.client-ip=40.107.102.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mm7Fey85"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=doZ3LEua08xk+rKREIPIuIe8wrUdP0HDv21989FwJQZTAaGK9zpOg/R0dy8p5VxUOvg0WWZy//ZvGS6kpRnonMMVJKc4KxGaqE5+mb41DjB5BlkV7NHVbmnZnBWY18AIYCsXfUH6SkYKH2MEbTg7NCThSk/uBb6Vse2AQHqJuA/sCsuy7ydag4Hlntag0AQfI6sKuZe74Pepp8WFBSxNy0OZutLJGWfp7X9fFO4d7lq7DGmqGAugLxcT9d4p5BCY6RxepFCr+FG0qRYc3/q3GB+kJfhwsGTXOvGGR525x3EHBl5PJvZNhjFmOIkjBHmIzT1Yzs3n/hJaQpdvFvJBIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9S1mMdGfPFfynRj56ooPQBGNfqSQMhbiAewy7oTyNPs=;
 b=P7RWIMnGBPx+tAko7vswL0MIzQxNmba2qyAWnmfsYxH3wzQwi7U1l+P6bxOjJlR3rcY8GZZKLCIiLUBf2v78DfOInRYc1f8opnd1VqSW2QWmckK6DxgjgtT7SFu/F3rrOp3PxVVqV8XMyCMM2/aMHGr9W/0+VIA6IcTjGXLSCGzfPDM3aZ3n07VbCZK3qfxxlJm2czD1WDrCKEOzvDMa6gFVm3489H5GiHEiHyfJl15pZtqDcbN5clbE27MHdOlbo2bqfpDQ1OIukvznadPQv/nHA5qKDnNqofdPTXy02WTxmMavgKXxMTjR2c8x+6DVMJ5B8GhaB6QQsHbL88ns9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9S1mMdGfPFfynRj56ooPQBGNfqSQMhbiAewy7oTyNPs=;
 b=mm7Fey85xOuL50bV4ijE7rmA+l1zFsial0oENDgh8wUkMwUKK8N074O0gDr7vNSzwBfj/EFZWT3zcYznbGYMlJYlbmuc2JlDd0LObQLhya729MHbZ04d4ODiETMU3QrAeMUwCyyJL9UvtbQtFGVgVvYB2rpvyu2F4nFpGg7U/tXhvEwv7Hz/BjlsEoCOhSKB7uV2E2HiMuRwOVK3d0IqVepb4ROnScsQWH/j8ikcHZo25d6jkkwaVn+Gz0CR+53c5OuznBChqCjkiidT8jlyj38opb0E8N9g4OvgmIcUKenT28Sm+o1VJk7nGxtOV3ftoOhRqtqfWHO7IT/YvreiYg==
Received: from DS7PR03CA0037.namprd03.prod.outlook.com (2603:10b6:5:3b5::12)
 by PH0PR12MB7488.namprd12.prod.outlook.com (2603:10b6:510:1e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 21:45:31 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:5:3b5:cafe::9e) by DS7PR03CA0037.outlook.office365.com
 (2603:10b6:5:3b5::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.19 via Frontend Transport; Wed,
 26 Feb 2025 21:45:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 21:45:30 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Feb
 2025 13:45:18 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Feb 2025 13:45:18 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 26 Feb 2025 13:45:17 -0800
Date: Wed, 26 Feb 2025 13:45:16 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
Subject: Re: [PATCH 1/2] iommufd/selftest: Add a helper to get test device
Message-ID: <Z7+LbJUNVMvrJzs9@Asurada-Nvidia>
References: <20250226050130.5814-1-yi.l.liu@intel.com>
 <20250226050130.5814-2-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250226050130.5814-2-yi.l.liu@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|PH0PR12MB7488:EE_
X-MS-Office365-Filtering-Correlation-Id: efb06402-2b58-45a0-edf1-08dd56aee449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xwFY/pviQjUD6IfLgEI71I02jBeAC9XHTScWiTXjOlwuZea3t+t6aMX60ySj?=
 =?us-ascii?Q?39R8B5zpi5e33nrTNXfnFRz5yLvpKXipB31drdb4p7CO9YqKrhoQuZbMaEY3?=
 =?us-ascii?Q?4cWhkRVLSnpUf0oHHY1Mhq4Oq8AV50JEy2OQmn0vsWj6NKwYuHLsgSPG82FF?=
 =?us-ascii?Q?CiwkpEgDPr2WQa+vevzANlsv/FeWVb4c5U1AoVPU6nsu8yh5G98cy8hjrpJt?=
 =?us-ascii?Q?abjGeJNiYFBo5ITXGO92p8iRSgIboMouK+uwWWbtoCVCf3S7B948pCikRgFe?=
 =?us-ascii?Q?k3zfdym9CTbU+54RxhFrVXO+SqSAEGC1eG05J+yolOnMesq5NArA+0INHKvr?=
 =?us-ascii?Q?snjxSOIiZuh58jmYT5O0hjbxI+1TbFaWLuyooP8+4UqjZrh0XS9ot10tMTMX?=
 =?us-ascii?Q?pc0n6nXe1cUJhp0MLO3JV0xqegCQEKaFL4lwMiCfO02+KxURzOAmIzw5har/?=
 =?us-ascii?Q?7QS/BW1ysMf3d1J0DRmwUxXCZ/CH5ja8upbIgssu+M7ntJti65WFUCa8lkQ4?=
 =?us-ascii?Q?srRONdnROUDYTR9hq++/Lq+Of4ZBiYVcKvJG84tJC+0it6jGmpPcSrWE2MHl?=
 =?us-ascii?Q?gbQvBKmnkGlcYMAOMG308KZZB8Sr8/4Z0ZXfwB+aGmWxnPx1TNAnpAw+oPpO?=
 =?us-ascii?Q?01hr/YZQe2BvblbKzqhvjsrpFsZB7N7Tnw4s0x9Rr82r1D1r3roYG4FjlrJD?=
 =?us-ascii?Q?pawXIhEK/bpl6l6XRQW8lc6FKxrdqchNsaRyJT6ieoRL+KLFrg9oI207ARAJ?=
 =?us-ascii?Q?Zn2DOnCqiKfwTdJcSnMMnz7NblPIMpDCtPC9sWj/a30KfzBQUHDt7FH+WPh2?=
 =?us-ascii?Q?Fc0Il1C7SG6JyNwtXbYc5XJTE+QdfihWsyVp2v4b0+R9DQs3jLgZxtkwgWYE?=
 =?us-ascii?Q?twYRNqTOMWu15D9JJj+6usqodeDEoNNL3B0H2zvLXpfW25LQzzyQ+t8i44Qt?=
 =?us-ascii?Q?yhLfkWZXtJYqSelXQNJWLw53b4xfyxJdNqv5FAFi4YhWbpepqLt5Sx/V4JMJ?=
 =?us-ascii?Q?Y8mHvSDHBruFM5SjQPpsKbkbseae12o94/abaoAt51JlauUJGoLQcxkPVCks?=
 =?us-ascii?Q?8YTargqRyBHD6iorPbMTyjROpH3gGxxQOmxsEh0R6kKGUPHgIviZa8SoRypz?=
 =?us-ascii?Q?2jxQg8adE0ZBTUrYV+qYs8nO3xAo/AS47g+ksVdm7CAAnEGZE+wPTL3nP4W+?=
 =?us-ascii?Q?MVkuLOaSdWDhyTZqnHkIS/ILmbpfJCCF5u5bLSIxNH/hhFc679qRNAeIbgqf?=
 =?us-ascii?Q?sHNT/yw28HILzhPmDtnx6EaJ7PWPWl8SDho8Rm7PlTQkwAAR0H5/Tn+vONMm?=
 =?us-ascii?Q?mFE6U9LnnC4Mn050E+Kozc/diVTrD17C0vFLDCJjgwRaylojeTJX8YopDNKT?=
 =?us-ascii?Q?wRgbkYq4Aln1SYAumi+p5cipVbVnYyZD90q93KrEkuuIdWlbWwu26BrB1ee3?=
 =?us-ascii?Q?UaAAjsmHXW5wnQEJvoRSu6b91bi5vbzciq6ttz8PgGpFItqcmTanTfBkOXw5?=
 =?us-ascii?Q?FOGu+foMNfnT3do=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 21:45:30.9420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efb06402-2b58-45a0-edf1-08dd56aee449
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7488

On Tue, Feb 25, 2025 at 09:01:29PM -0800, Yi Liu wrote:
> There is need to get the selftest device (sobj->type == TYPE_IDEV) in
> multiple places, so have a helper to for it.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

With two nits below:

> @@ -968,29 +968,39 @@ static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
>  	return rc;
>  }
>  
> -/* Replace the mock domain with a manually allocated hw_pagetable */
> -static int iommufd_test_mock_domain_replace(struct iommufd_ucmd *ucmd,
> -					    unsigned int device_id, u32 pt_id,
> -					    struct iommu_test_cmd *cmd)
> +static struct selftest_obj *
> +iommufd_test_get_self_test_device(struct iommufd_ctx *ictx, u32 id)

Since it wants selftest_obj, maybe just iommufd_test_get_selftest_obj.

> @@ -1000,7 +1010,7 @@ static int iommufd_test_mock_domain_replace(struct iommufd_ucmd *ucmd,
>  	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
>  
>  out_dev_obj:

out_sobj:

> -	iommufd_put_object(ucmd->ictx, dev_obj);
> +	iommufd_put_object(ucmd->ictx, &sobj->obj);
>  	return rc;

Thanks
Nic
