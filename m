Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792605202;
	b=L0dxsfAsJA2XsH8AuwZUieaYA9EEyeoYoM27s4OUgo2Cco10VgxLU/nFLKTuTv4XHnzN
	 DD+IMKyD5hSgrp5HKwQ53FEZrzrVYbQGzIEEz5PTgcTz1t9pS3Mxt5ya+rkSCtqRJiMhS
	 oTENtPpPK/z6TEqK6vOhpA7CBmhW4gkmvOKqKYEDAvneKAMB5UgVAmdEZ296DFyWOCqLC
	 ViWiVvwCNPyEcC4RJ5V9j0dVi2k8omGI4ELD2zGKfgJoeN43g/vTOSv7kkmznMDP0N35c
	 WtYZaPbgA+dFXajNVGNZvuSR8ifhdhC/+vQhnJqy4K3k8ZxYkBNu90MpRikL1jne5VA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605202;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Date:From:To:CC:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-NV-OnPremToCloud:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=qinLJ3eRQ/tuBpSZ8HHkClQNWeKZVMQnhwuL8f2pSOs=;
	b=4KXtbf0xIboE2NasszCQO62IEgF/Jkiv56CX8YShG8BkgMJna7cdaPFEAVolGLXbSu24
	 wj4tr+l2bzR32HMWHzbeVyBVtcoAQO48uobZjILuHSSz/P88obiMGzWZZKk56mE9LwwRL
	 a3W5IOYQ5CJRRcnx/DAgqWEcYP+vNULpvP4Gs6Vd6Ei1J8aqHrhlP6xwR4yl34DT1EZUt
	 SKXz8jumWoqL9a7SjsBdefzvm9Vz8Ct6KoNExap/eYWoICEwgOrAeslssuOIjMb8TBZ+V
	 e/ytL3QQ0yQplD7d6Z7F2R/u8k4cAGVmk2mvHoeF8Dg+ceVM6Jo19iUcw/1aknEACDA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gnsNaopE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.7
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013007.outbound.protection.outlook.com [40.93.201.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA996606A31E
	for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 17:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA996606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gnsNaopE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UAkvg3oKfFuHG5WHY6mjL9/xXNMucKD+goq/mSfzCPrabxLgaWAcDLVWZFEl25bRwpTyciTd7CVcogvbGkhohULYz+VwhcdP0TWaYOGXY3U+biYxKOXFh+FvbsMvSWh1Wu3lV3KbHgxbRk6/AvDVBVKDTOcRvBboK1DRnOcft6Jz9RCH8pdYschPOUe3BUru01d5UJ6pdbdXFw2im87790bmZMn6vJVSQLz6OI8Y6XwGmIJgpwD86QfTL3G5X1a1PjKEUhE9RxzNnUNytqMa/3w25AZSw6uLwqg/eqo9/7gv3jHtz744dZxjBh0gkwSi27jGqxkQ7d2fHVs8GfSSiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qinLJ3eRQ/tuBpSZ8HHkClQNWeKZVMQnhwuL8f2pSOs=;
 b=tiQQlRiXYcdLcAWRkV8ZHWHH5tlBHnyCWr9aS44bvauIxEITmT7JyKtIklknBmOq7dCG664GDoiENkRBw0kwmMKC/dSEp+nEjmAEmHLxYC3+7gJyyE0pQ6Rc7zfOSRwk1EZXSE8kIG7Ufrhjx8o1x7aahEEwObUyoNWtfhptK6IOep4yxLx6nql/2MOPYJEQTiqjIubHZ67FHJ0fK5j/k1UoJuluMpreyKHmWasGli8eL5gQTC/CBNlBPapQNN+ncsF5NHJNzQhIz95Uif+Nf7xEPQZehYba3S/yvai5QqTWG8IOrsws2d4wx8cxMXBDSZjy8YgY4lEg/N+6AFcQEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qinLJ3eRQ/tuBpSZ8HHkClQNWeKZVMQnhwuL8f2pSOs=;
 b=gnsNaopEEQFcl9eotPcIsiqES3LKfBUJtLjnKSJeJgOd2G2QrYEzvF0gvpZsoAR9kp6dpRLsGPcQTTeqJV0cuhGhIOF7Zg3mU0uuBWu0Uai2m9pAXQaTyFr4QAkKM8l6a5Z7MIXilCJ5efc2OmZLxrCA7qHhYD0iMJdTtHwhcp+L6MT262zT/pzkDtC5IUzaZdcbzWYXQxI1WM0H7s3x2S51KfKsq/daN8ieXbfDV/Mzb7GuwY70WRnUIHolAOifFYMpLf4DbqXJK8IW0b8iAPfH4AanWP3IQirSm4dnk6yDVhutZaxjiLNY5MZQ3NRvbqgaENxKCZnTaB3axhE4kQ==
Received: from SJ0PR05CA0054.namprd05.prod.outlook.com (2603:10b6:a03:33f::29)
 by IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 17:53:17 +0000
Received: from MW2PEPF00014677.namprd04.prod.outlook.com
 (2603:10b6:a03:33f:cafe::5b) by SJ0PR05CA0054.outlook.office365.com
 (2603:10b6:a03:33f::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 17:53:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MW2PEPF00014677.mail.protection.outlook.com (10.167.249.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 17:53:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 21 Oct
 2026 10:52:53 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 21 Oct
 2026 10:52:53 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Wed, 21 Oct 2026 10:52:52 -0700
Date: Wed, 21 Oct 2026 10:52:50 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: John Garry <john.garry@arm.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>,
	<kas@kernel.org>, Cristian Prundeanu <cpru@amazon.com>, Breno Leitao
	<leitao@kernel.org>
Subject: Re: [PATCH v11 09/11] iommu/arm-smmu-v3: Retain CR0_SMMUEN during
 kdump device reset
Message-ID: <atj75zKIeTzUOwRr@nvidia.com>
References: <cover.1791226953.git.nicolinc@nvidia.com>
 <e8f6f198da25cc6b00902cd61bda9e7228cb45ec.1791226953.git.nicolinc@nvidia.com>
 <4b627d0a-b802-4965-9079-44121436d4bc@arm.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4b627d0a-b802-4965-9079-44121436d4bc@arm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PEPF00014677:EE_|IA1PR12MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: abaa77b6-66fd-4aab-75a3-08df2f9c2f67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|82310400026|376014|1800799024|23010399003|6133799003|22082099003|18002099003|10067099003|11063799006|261021135927099003|4143699003|261021121427099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	Lj1syWANfIvaGWxNcKA48qcCH8YcgJwGEBPOCXLflHPckOgGnijQRhG1omLm9Z1UZU/DaVaxQEyzMFGkRMD3IJcelZ664IQpYw70RaE2fhGeGtgTL7pBzOYtEJXkR1KoR5sJoLK5WWhTZ9UaP85TgIrBKDClt1xykwNG1vFMg04xEcUyDekrRK1lBl49smsZ7Buig+Im5zRtueUFHgqTGnGUc2W5lgnslRjOS7wCodk25hDh4GsjsE4ukL1QcE1bV3RU9RyB30zlq6wfs0VME5VDAAJNKimsJX7HZ5vF7CI74rxPtVP496X3fJJk+mEDS1Apqt+0Vzx2n55/5QauAmUHgyXDC9dHAZVrBQjEyiudVNrrWyR8kv1OkWEUz+Gec9umT5lnmhDVCOwauY4CUquUT2WQ4edz15KMfe5cOEORajWTDPB636S6Fqcu1zS1ktX6PMdJs9zT5+TR55mFYzpwtOaOeF0zO1BHaV9YBmmGzZq3Cy4bwz++g+eRO9/VGUOzQQRPWLLA1gt1/G5/13fycr4s3ljOhG/+YKBi4dmyaVGuhwvxcEJ58hbYpXF4rNoBkErTncnr+2jgwax0L9bQ066qgivPMkShq16NNk+Jn4kQ95eLwHHbIJmvZYIl2mZxldlw0F0kGZjMEu6kwE65WTmtRsRruJYEnB0VE+NRSsHZknhnXGK4fNkWw0MMUYydNDPFxuq9KNVH5MdQtA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(82310400026)(376014)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(10067099003)(11063799006)(261021135927099003)(4143699003)(261021121427099003)(56012099006)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bwmzr+Z5Yc7q3a4cWwxG1zataOBmSKs+esVW+c1wIPVERkhwPXkOKGhekffglA+SVNCg+6qsIjDJbQqg3516I7bf5Updi+EZ89mJHQ0UH7OVxJivK/D1Pm9wLAzhFwZlEienoeLngm1s+MVCpgnacxuMqUYqbbwN7HfLBdmj+B/8H+goOSPDpAH0o5JqR1rL3+HHBhlsk0ujQW4T9FYj9tWiP/5ds0Gq6kobV8vf0cH60Y3OAqCPnFn2slAoOErSLEb1FOKuRNI3ZNpZWWyLoZMql/7DdyQStTgCFWwWPyK/QiCK5xuSKJKBZQHW+eE27y7XSw0BoG0+1czMzCd0B5VRk53JwP1vPP0NsXPlrOuwkwiW9e7xA8r/LAWNGMzdgvO7H0JjU7++4opQP+2RQUZjh6BFJbIyGcr5y3tpaaBfkmgclXWC2nclygIhJqu6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 17:53:16.5677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abaa77b6-66fd-4aab-75a3-08df2f9c2f67
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW2PEPF00014677.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090

On Wed, Oct 21, 2026 at 05:53:23PM +0100, John Garry wrote:
> On 10/5/26 20:30, Nicolin Chen wrote:
> > +	/*
> > +	 * In a kdump case (set when CR0_SMMUEN=1 and !GERROR_SFM_ERR), retain
> > +	 * all the live CR0 fields, e.g. CR0_SMMUEN to avoid aborting in-flight
> > +	 * DMA and CR0_ATSCHK to carry on the ATS-check policy, while clearing
> > +	 * only the queue enable bits for this kernel to take over the queues.
> > +	 *
> > +	 * According to spec, updating STRTAB_BASE/CR1/CR2 when CR0_SMMUEN=1 is
> > +	 * CONSTRAINED UNPREDICTABLE. So, skip those register updates and rely
> > +	 * on the adopted stream table from the crashed kernel.
> > +	 */
> > +	if (smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT) {
> > +		dev_info(smmu->dev,
> > +			 "kdump: retaining SMMUEN for in-flight DMA\n");
> > +		enables = reg & ~(CR0_CMDQEN | CR0_EVTQEN | CR0_PRIQEN);
> > +		goto reset_queues;
> 
> nit: Is there some reason to separate the call to arm_smmu_write_reg_sync()
> under the ARM_SMMU_OPT_KDUMP_ADOPT check, below?

Hmm, I think it's left over the versions and they can be merged.

I'll do it in v12.

Thanks
Nicolin
