Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010033.outbound.protection.outlook.com [52.101.193.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8061EDA0F
	for <iommu@lists.linux.dev>; Sat,  6 Dec 2025 19:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765050636; cv=fail; b=DMhQcNt4o4L5dh5n2zOeGA/7pZq8VCfUz+sldpWAREbD4wYj2cJrTiJt1Tr/zjWui8yrsq+qYQVLkmKubLMT7ehKC+Y8crwcYDBcVldiNPOcUeR3EtpS7GGLjX1fNe3Re2aXV+WDwC5EuthU/SqcP5QSTFmZDHmLf9RTZ93jfT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765050636; c=relaxed/simple;
	bh=hUqm6ExP1ToAHjBJEcOflIbBWJbn+EY9IGCH21vCy8Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uwq1f1gkm+NwJeDReRBdS9J9O5KrqC8sfY2nCS7UL6P/X3HUCBc/bZ9n/EqIHHj/Km8XzeSBXpp6FFGDaDPlIx21kNpgi/kCo4+vf9EWoS5qY55FiPEWeV3x7mQJmaJGTlmGdKXqBtfaiEQ9Px+jddypxACEXfGj085CuGS91Wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=byTogpk8; arc=fail smtp.client-ip=52.101.193.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="byTogpk8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aVfDupOhV0RGKALJzWeBQFWqqHyCME2eskuQcmB97tI8N5q4/C8gbda3O7ddb0MuOvwy4yL51Tky+xADNKomkibV+6yy0/iWOrbZ8aoHsRZMP13WR0edrVqb8OFdwQcN9Y/kMcgq5w7XN7S0BuLw4GSqQFJBYTK9/3NlDHjTsQAMiFnFkHMeLpYDHZaHMxqhY6CnwRXrFsV7GGPWUZXIORoQIlWeNHa0ufHTM0Krj9MHdRulcI3Pt/x4Np98LmjPk2HX2q+nEuzozP30hHBDfQaFTm86pxQPJicHMKWI8wqV307TFqywyGTljnfbnI0fED9lsI917oC1BjSmM+xHvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwXdkXx2JuyGDuc5hEpIgVhaRHoE3MsaJnKizj9ZQtc=;
 b=ITsmfiu4kmmwcZVjIi1keRfkXMQw+hdbOX9rjtmOxMUJeIrnvgQ4uIMsx2SABp737SoDIMunR9PyAn9tmAxh0a+LSvRTyoMVjPtxgArsny+zVsbljUD7y0WrEXejtkaCmTFrWvbkb3HUlv1IZpY8QG6C50o1abWmVGTUVtcgH92grUC1qXgirGXMcYwYxnjXjedVO4+I4jN/+hU9KKn04y1e957kI2aERR/j2ryLS29hJXRt1xAQcTabMDmcxGvrLh3TL/uIK/uWY5d+CVCXRC7y4IBxDhHuOn34VRLUSvacTDQJ/4Edgmd0ZFyZ2lD9oO9yL3C8DaNcl1wEYiV0pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.alibaba.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwXdkXx2JuyGDuc5hEpIgVhaRHoE3MsaJnKizj9ZQtc=;
 b=byTogpk8k9C28Zer1OTQ34G0gStt/neyLyVFVTakQ6odabY3m93lD+Sr0prBIHlt8Pi6bDaNtpyCBvIYXMgxe7GAFJhei9uKtMjN6VB1W5PvcB07UQw/h2F3eE/nHZscLhuqw7o9vWHiDniyXUf1/Ehduy+4PJHApKFMKsP9uxx66u9pGABRuHMMvSdprns1JmUfRgZagYatOr06EgnBGvuzBDVIVNL1OuqvsZttxKDtKuqCYyCK8Cl5nYZ5bSK4gvCo8W/4vTz2he+/hhXjfh9hoq9XLU0kmVf228MtZSNKprSsX27GTDoVag816EQgZWmaNHsbmm3UEGCSpAt0LQ==
Received: from MN2PR14CA0007.namprd14.prod.outlook.com (2603:10b6:208:23e::12)
 by SJ0PR12MB6991.namprd12.prod.outlook.com (2603:10b6:a03:47c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Sat, 6 Dec
 2025 19:50:28 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:208:23e:cafe::f6) by MN2PR14CA0007.outlook.office365.com
 (2603:10b6:208:23e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.13 via Frontend Transport; Sat,
 6 Dec 2025 19:50:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.0 via Frontend Transport; Sat, 6 Dec 2025 19:50:26 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 6 Dec
 2025 11:50:09 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 6 Dec
 2025 11:50:09 -0800
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 6 Dec 2025 11:50:07 -0800
Date: Sat, 6 Dec 2025 11:50:06 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
CC: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<skolothumtho@nvidia.com>, <praan@google.com>
Subject: Re: [PATCH rc v1 4/4] iommu/arm-smmu-v3-test: Add nested s1bypass
 coverage
Message-ID: <aTSI7iFaS1BnmDg5@nvidia.com>
References: <cover.1764982046.git.nicolinc@nvidia.com>
 <3c838833d8bbb69a72a85ddbcc325b22ae7a7d6d.1764982046.git.nicolinc@nvidia.com>
 <703ba08f-eec0-44d8-a224-c96706df5fab@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <703ba08f-eec0-44d8-a224-c96706df5fab@linux.alibaba.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|SJ0PR12MB6991:EE_
X-MS-Office365-Filtering-Correlation-Id: b34b33b3-7b4d-4841-938b-08de3500b412
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WC9kTW9ZWXgxVFd4b3RJQzRaSzQyL1VVMExwMEs0b0JMRnBEUTVXY2RTd1NM?=
 =?utf-8?B?TWVoZ3J3S2puNHArTGU2WnVvV0hvZ09vMytqWW03VEU2VXoySVJyUC96d3d4?=
 =?utf-8?B?d25yT2pPMnpSSWZpcVZQQlVoVEVJaS9Hc3haZmFUVDR2QjRnYktJV1JOSlZT?=
 =?utf-8?B?WmU3VmQwdzlGNUlwelRlUXNieDBUK0lnV2pqK0NCVGNxZTgwNmpEamhiU0xl?=
 =?utf-8?B?S21LdDE2UG5Oa2JrQTNHVkFUd0daSzZMUjl0U0tzRkp6K09mckl1T1FiUHdq?=
 =?utf-8?B?dkRoYlpCZU9DTCtCZFI3cWo3bW10d1Zka2wvZm9DUVdrT0UyWjJhQlNUaUw5?=
 =?utf-8?B?Y2JNT0lVbTdRWEt3TFJHNVBVdWdDOFpyS0Q5YktyMEFTREljYzdIMnZzN2JR?=
 =?utf-8?B?bCtWcVN1WVphYzM1QlBXZy81cXpGSnBYaE5McENydzdBRGMrS210eDBjZWMx?=
 =?utf-8?B?ejk1dDNieS9CZml1ZTQ0cEc1SkdNSGVMOEpPTU5STkRvYlZQNTdOdFdOYjVj?=
 =?utf-8?B?UkJvSWtRcVl2THgvRFhPWWVYRk5ySmt1RERrdnluNG9Kelh3YzdHaGZmSnVu?=
 =?utf-8?B?YWc5cG1lb3BhWkl2bWtTdUZoVUYyMkkvNjhPaXQrNzIrSG1FYTZJc3lzVFdD?=
 =?utf-8?B?OTBDNXBraTBqMThQRzJnazJYK3NoMXh1WVhMWFRFRlViamIra25sUnZLZ016?=
 =?utf-8?B?bDg1M0xoU3JMK0FXd2tOUktGZVNhZGQwNkdaNmhHUDhPSGxqbWpobVhBUW9X?=
 =?utf-8?B?WUFJQ294RUNsNnlOVjhQWFZaU2VwNHNpSWdZMk5TZjhSa1B5RUFvZGRBRlhD?=
 =?utf-8?B?QURxTmUzUDB6cXZja1Bya0FKaHdWaW9WOWljUDAzOS9LMFhqWnU1bVhjTUNG?=
 =?utf-8?B?L25VTkNiSVV4SWhPWVRyZHhGL1VQNnhCTmxJbW9tVXQ1clVDQXovWDh5MjVp?=
 =?utf-8?B?eHhXM2JqcDdsQUtzbzFEZ2d2c2RmY1hKb21ieGlQUGhVQW1laVdIK0FqaURD?=
 =?utf-8?B?SkppclZoU2wyNnhSVENrcGZGL0JQUlV5cFM4aG5jTk9FdjJpL2VaSXNwNHI1?=
 =?utf-8?B?YXk1Nm55bmtwZTRoNE1XV0V1ZjRoTnlUdkpvSW55S0o4bnJ3bk43eWNHZE5H?=
 =?utf-8?B?M0d1bXBCUVV4NUY4L09aUEMzWnhmL3BqYStMcGZHNndRWDF5ZkpwV05Qd1dj?=
 =?utf-8?B?cjgzQlBwdHR1QUVTbVY0MHE3STM5UmxYWGV5Z0VEV0VmeHV2Z1NSeU5uMDhJ?=
 =?utf-8?B?bXg2aVVBY09mZWVQOVFNRVFMd1lRWVo1QjROSDBlTSsyV0hGUTJadWt0bm16?=
 =?utf-8?B?eVRVQ3ZxekFrQU1OaTcrWVJ4cFV6WUVGWWlIZ3d4RDM2Wm9PM1lUWFdPL0Fq?=
 =?utf-8?B?Y1Fua2Y2ejFUTDdYMnkwbWxQM0NMV0tRV0ZXU1I1ZnVDaE1NRW5TSkI3ZjFG?=
 =?utf-8?B?NVRxM01oOUJQSjBNV1ZOdDI5dnlEUGdDT3Yxc29ONUc2S1lWR0tGTUR1dkkw?=
 =?utf-8?B?VFZRbnZxWkhNVldLNDJXdFNDUzhVYU9NL2E5VzZiaVEwTTNHNGhNeWpOdDAr?=
 =?utf-8?B?MlpCcVlqeXE4dXk0SHQ2d1ZmdHN5bXIvdlRqMmUxb1k5U2dkekc1Uy9RRTRT?=
 =?utf-8?B?Q1puUXFzYW95TzlwSkcxcHVqMWZuam9BcHVvdUZYbGtDWUlOV29rRHhDaFJG?=
 =?utf-8?B?R1ZJZ2RkWjdrc29xZVVGQnZJMTNVWXNVQVluZ2lvRnJSQ2NXbWljOEE5b2R1?=
 =?utf-8?B?N0lTQ1Z0bDQyWFJLeGdMZ0xHL3ZkQjIwV2s3YWh2S2YyZlgxc3ppZ3dxZG5r?=
 =?utf-8?B?ZU9Kb1A5VDRKWFlaUlJhWTJxZUw3RDRxTnAyVW5hTmtIMVp6NENYY1dDWmRZ?=
 =?utf-8?B?WnNCQ2N6aXRMT0hXeTl2ejhCcGRJaDU1YVRTYXRwQituM2lneGRQeTNjS3BE?=
 =?utf-8?B?SjhFWTlRT1Z6eVk3M0hlbnFBYjZTYUJobnBYQnRvQjFNQ0dlcGpXUjFCZkVp?=
 =?utf-8?B?cUFKWjdJbFEzVTl3T0pOaUZzZHNsSFVkY1Q5cFd0YVBjUU5DVnh3T1BtanpO?=
 =?utf-8?Q?COU0M0?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2025 19:50:26.8625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b34b33b3-7b4d-4841-938b-08de3500b412
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6991

On Sat, Dec 06, 2025 at 08:34:09PM +0800, Shuai Xue wrote:
> 
> 
> 在 2025/12/6 08:52, Nicolin Chen 写道:
> > STE in a nested case requires both S1 and S2 fields. And this makes the use
> > case different from the existing one.
> > 
> > Add coverage for previously failed cases shifting between S2-only and S1+S2
> > STEs.
> > 
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >   .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 32 +++++++++++++++++++
> >   1 file changed, 32 insertions(+)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
> > index 9287904c93a2..56bdcf5a517e 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
> > @@ -553,6 +553,36 @@ static void arm_smmu_v3_write_ste_test_s2_to_s1_stall(struct kunit *test)
> >   						       NUM_EXPECTED_SYNCS(3));
> >   }
> > +static void
> > +arm_smmu_v3_write_ste_test_nested_s1dssbypass_to_s1bypass(struct kunit *test)
> > +{
> > +	struct arm_smmu_ste s1_ste;
> > +	struct arm_smmu_ste s2_ste;
> > +
> > +	arm_smmu_test_make_s2_ste(&s1_ste, ARM_SMMU_MASTER_TEST_ATS);
> > +	arm_smmu_test_make_cdtable_ste(&s1_ste, STRTAB_STE_1_S1DSS_SSID0,
> 
> arm_smmu_test_make_s2_ste() makes a s2 ste and it will be overwrited by
> arm_smmu_test_make_cdtable_ste(). Finnaly, we got a s1 STE, not a nested
> s1dssbypass ste.

You are right. There is memset.

> I think we need a function like arm_smmu_make_nested_cd_table_ste()
> here.
> 
> Besides, from the function name, I think you mean
> STRTAB_STE_1_S1DSS_BYPASS?

Yes, I will fix these.

Thanks
Nicolin
