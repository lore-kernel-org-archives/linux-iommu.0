Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013031.outbound.protection.outlook.com [40.93.201.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B98C2C2374
	for <iommu@lists.linux.dev>; Tue,  4 Nov 2025 18:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762282141; cv=fail; b=H29/Q27BRQHSF2POQ7wFhpdrGGbT/pqwT5VN71npHMao8pBb8Ye3PjjHEjFBv57j9Hh2f1UNR+Vx+ATyCdNMZJ5VKxm5Znnl7M0vJtycgPOXx0bKP3hUhHxRkymwocmebcJrZcKKE3WXqm+vYga61y9aAAoHLbJnOaxxk2zojZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762282141; c=relaxed/simple;
	bh=8YsOgne7rltDSdBbugyYl6Q/8TIKlC5QPe8xXMYWRPY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KeEZYryV+AbqtZ43azflH4qpO9okRssaYBqK8JqSzxAvq1PL6ooJ7JEQEhC0SrPdOj+jAYu1o/UNTs5ir56KpWpUftBHxUZQ8XR99HVTsMkdTHdmGqvsOMFsot8hQAZ5YTfU9mMT8pyLgiX45HOHcdFdKUWzo5ffj8XrB51YnyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KYAR/E6z; arc=fail smtp.client-ip=40.93.201.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KYAR/E6z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nDC8FYaYncRbtvwyx2II5i9MmH8OEblug7gRlZsjyV2e8xsU3WdVXyYiNDfckXQ+R0nW1fJkmts1A8ijIZpQB7h0yNJe0wK8EASTOqmUEayE/1SuzOFvu1aUF9S3RRYi3HhjGhV3PuC6lzOupGfZjp+9tieY/RdL8a8/ZH8w1Mb2wSvpMp74o0f7jtD7rRPFOZds5NqfjJ48CcuB6BcEdE8zzhaienFq3UtDJU7oy8qQqlLP/nQnN6Mx1HH0x5VzblPXezvj92MhBflcjR/05/BR30BPnMZHsCahgPAMgUukeAYlSMAGW3J1ihwMl1DLqWBxsCzZ6etj3AyZ708OPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmkjvicMSJxytvTbbMHSwJDf6sPmiAsI4iGRXJoZjzc=;
 b=O4wEtl6EuMu/Cjhko4huy7TeqOVtsHSW6KMRoEn4GkvGLu0v+dtyR5MY2rTctqi4mE5Oiv/ei6ohBpswIhPfjniZZCiPDlv5EcZ+OG82ZoUEHT6dIIbWIoiaFH7aRkv5yfwyay4zehN7BoH0Tis842q0kyp8Vobn7CHOk3uueOWvGnkOM+Qdm49yHFp9FE57EV5a1d7lpDamjf1BEIPbD2r49lo3m8K2I4T6GwC6gqoMnH3bQahtrqeneAZ4yidQdrROccEMZTqlmDMtUqVktZ7wk+N5RlbZqEiHrLj4q7yHb6JLNzoAxIuHtzo1Va1Ri6FAEMqxq461XmFrX4T0Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.microsoft.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmkjvicMSJxytvTbbMHSwJDf6sPmiAsI4iGRXJoZjzc=;
 b=KYAR/E6zQt1AqWypkBt8kXRKOtxYjhiOxLwWzxp9ZRZgCJB+A3Nu6wRtnAmxyFSHppaaV70da6iziA+HsQM8RRTA8hos4itZdO96NY9J/R6e3aWbsIrpT39uVBW8N/Vuyz+bHbo2wF+bZeHL5nZ2ELb2zyMfw/qw59N3pq/ENgveb0Jjh+xYwseny1StdgCBqzYFTM2i38/f/5Q5tTuzPKOs9Gm+pCbmi2s+Yofj++sqTQ3D8vKW45EKhlYK4Vg+kaDcfWwrI6Gx6wzuQHeMX7FQRZYVosnGuUjexZTL8biwvMYeEKvDbG+unlD+jIujbiGn++/Ra35u6tvnjPg1Pw==
Received: from CH0PR13CA0013.namprd13.prod.outlook.com (2603:10b6:610:b1::18)
 by SA1PR12MB5638.namprd12.prod.outlook.com (2603:10b6:806:229::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 18:48:52 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::ef) by CH0PR13CA0013.outlook.office365.com
 (2603:10b6:610:b1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 18:48:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 18:48:51 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 10:48:34 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 10:48:33 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 4 Nov 2025 10:48:32 -0800
Date: Tue, 4 Nov 2025 10:48:31 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
CC: <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, Jason Gunthorpe
	<jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>, Zhang Yu
	<zhangyu1@linux.microsoft.com>, Jean Philippe-Brucker
	<jean-philippe@linaro.org>, Alexander Grest <Alexander.Grest@microsoft.com>
Subject: Re: [PATCH v2 1/2] iommu/arm-smmu-v3: Fix CMDQ timeout warning
Message-ID: <aQpKf2IPD5xeBu1K@Asurada-Nvidia>
References: <20251020224353.1408-1-jacob.pan@linux.microsoft.com>
 <20251020224353.1408-2-jacob.pan@linux.microsoft.com>
 <aQPptXsqzt6kJS7f@Asurada-Nvidia>
 <20251103151631.0000703a@linux.microsoft.com>
 <aQlVjtTiqd34I+NC@Asurada-Nvidia>
 <20251104102539.00001110@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251104102539.00001110@linux.microsoft.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|SA1PR12MB5638:EE_
X-MS-Office365-Filtering-Correlation-Id: eb284dce-c747-467e-2a70-08de1bd2cc58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y7XbsjH3nZlSQowHM59ygSJFs+Dqg7H/jT5EQAJMAc7lEaDLjesBN0aVqKWN?=
 =?us-ascii?Q?2EZ/4aKVLxvOD+nP0Q4Wfus+4O8g30CZapZzkIbUGcph8J0RnbwbtF39LzEQ?=
 =?us-ascii?Q?BiFSh32ZydXduthmy6fvQt1pzUc3132UvFh6juV8O538s76bQPU7k2InRHIr?=
 =?us-ascii?Q?NjNfxPgtrG/tIAj4Ep7FO4CYfWbPphGPdVeRUKiCx9t9CDEwOBtXkoDZmxRx?=
 =?us-ascii?Q?2yQkzVlwaqjspXiNJZ47BKhbdmmvvMCaa0TkyPTSzUTVe9/JC5wux7bR9UG1?=
 =?us-ascii?Q?p9BVVU3RcY2FkdCl60/Pazu0GyRijhoAvzrcyAtuxaLTSYXRlpoe+JDORNe6?=
 =?us-ascii?Q?xCUztvqjG3o5Nx+AVeJ2Z8zBQN1lZHGE20xIbcB9Xu8g8TnA89IKxjUL+VBL?=
 =?us-ascii?Q?ycRRaiibbaz3Px7mC5U/LMlL+oM207dSXdTmsJUynNiUxOeMP08Sm5MLJg4m?=
 =?us-ascii?Q?qxt1ipEjxUn8vR1yzNXMIE1M859i4lMjY4X1iGZYZDWo0mjxdYby16PHgXEH?=
 =?us-ascii?Q?Vj1fdSssRQHbpC2AK63cL2lOmlbjJMfvIByEG2XGyp8HJn4+iQQd8EKXynBc?=
 =?us-ascii?Q?ISWE8IjYnLkcfL+orMV4kJ58obq2lxQmIUNOGT9GXnKyAzU7uzdwvZjQZ1c3?=
 =?us-ascii?Q?1bozS7psENJcWPSkqPvhF0gh9knOktaSqsSmsHLOhFN7uxVwqQOTZrB2iDur?=
 =?us-ascii?Q?GFRPACJN1BKz3gerkIp051cV66ygtjkpflikpAsva5a2GUG/CivXZCnWPmgq?=
 =?us-ascii?Q?OpNNkMd2Kw4KG1zPc5+pmSCZVRk4f3a20dZ6pXjRkBGdmWNm/mgZwjxkto19?=
 =?us-ascii?Q?LF/fB7e9jAzbrCV8Yx3OWyR9XGWH1a20onqW8rosFG5P85HyvRn1drGGHyPC?=
 =?us-ascii?Q?ujkQ87JHqn4QnfeJGeqB3b7UfN3D7yTik5YsnDptwZ4f1K0M14npFDFrTtWk?=
 =?us-ascii?Q?+y97pYMgsoh1IIqi1R7bmsn2l79BYmQAaYB5qBeEgd39OuFz//DOvURo1BeD?=
 =?us-ascii?Q?FE++irL0rvI6Pu9axCLn9hZX6uguNQ2cXfXQLY9hAIoglN1zFuryhXcWDKsO?=
 =?us-ascii?Q?QB/Zn2U4hmgX213/XEMrDJP2IDZZY6KTwUxWIGCzJNJi1qtOnHWVcafVDriI?=
 =?us-ascii?Q?le4S0vm0ag+sLQwf523rByBOfwgfXDnOsJfxvKHshGM34uNWjnaTRJPMFxXv?=
 =?us-ascii?Q?BErN3/3C6YKfOmjxOwv0q0LiCK6Hqj9c/oVBKdsnThi5C49D9ohfhczmE97r?=
 =?us-ascii?Q?hztrwMs9v8FAZCWr8uxmFeVsDY1Kike49vKZgVFaP6lnCr2wKDBQoe1bJaBy?=
 =?us-ascii?Q?Y4sdistSux1jFKX/lyy09XVGPRKAxsy8gqJa67r9CSazBrUN1JPApmIgw0G0?=
 =?us-ascii?Q?tuEuilJCAJRfEmb+GHEIIQ+YKwznCaOGoC6c31HOso2SNM1rSvn1VC8gn3Uy?=
 =?us-ascii?Q?vDtwZI9TH4Hubi06yFpHkVg83vk3MngC4NMnLygzvbzRA51+WTNY4fabOfYl?=
 =?us-ascii?Q?g0HF0eeIcMYV+GbTjewpud2uLDIHuJuQvh+1NAd9iDNIosuWIcmx4B6MTAWn?=
 =?us-ascii?Q?XVlWLyFg/3paG0/TkbI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 18:48:51.6593
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb284dce-c747-467e-2a70-08de1bd2cc58
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5638

On Tue, Nov 04, 2025 at 10:25:39AM -0800, Jacob Pan wrote:
> > -----------------------------------------------------------------
> > 
> > And the commit message should point out:
> > 
> > The existing arm_smmu_cmdq_poll_until_not_full() doesn't fit
> > efficiently nor ideally to the only caller
> > arm_smmu_cmdq_issue_cmdlist():
> >  - It uses a new timer at every single call, which fails to limit to
> > the preset ARM_SMMU_POLL_TIMEOUT_US per issue.

> Not following what you mean.
> The original code below does honor the timeout of
> ARM_SMMU_POLL_TIMEOUT_US

It sets the timeout per arm_smmu_cmdq_poll_until_not_full(), not
the entire wait-for-space routine. And that's why you moved the
queue_poll_init() to the caller, right?

Nicolin
