Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03EA5DF3E
	for <iommu@lists.linux.dev>; Wed, 29 Nov 2023 19:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KhC/b9I/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laq4xWPd57cn7LsPnV3V8w0oQLUAOAxfS8uHrDidGbiHEu3uNU/k9Amd1UYjue+ncTKo5P9bBS+ssNgwojoJY3qYpLn0rgjGrEnW2Cg4PaYI/VJOSoNh9b/yNUrlrALsY8gNHvjIIAPPsVqlRQRcBrbi2+MdtYYTBoNACPeSxzOvB8Hm34Y26OQSh9Vt3Cxyo/3K+g1+4x8Rtadax2fettLURDxR+1yFUXhXE60lSoaORR+ckLHWFmdZa4FDomowiLl2f5K9aIdPgt2CU+nWe+4fJucQLAayGlvMh1lcazYMcs/M9F0G/1ntU+aDmLSpk/9QMShqJUkvpZMvHYXEog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVtmpVkqUARo8zBLHhFeAcU5c5elyA61CQAgiXoCSC0=;
 b=bz8aKb/8Q1yPqfaDqZEsh7P0jb2NHlk+V7sA2BNhQXDTibzNParz2stWLXtyX6vxalS7qQK7RdVQr3PJn+Dalp8U3nwHEFfaway434aZ68MHXuEVo64K+hgaShd9tK+O4dnqCBUf2VMPEMz4nam4ZVPgsZfb/tE+Hr0XWQmurvEuDuQ4kH+8j8//AZMqEztoxl6vnbAW69G4eqg2MPyRvOLnaupvBG/25VIogSRgLONpgoG537MNKPj2dwmt224lPClEmW1NA7y8PlfH3yenuoGxgL6Zu5eWpVW1taTm0nF8Gn4QS48B7Kddah1eLXbq3oz5PsSMNGGNQM/24TntbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVtmpVkqUARo8zBLHhFeAcU5c5elyA61CQAgiXoCSC0=;
 b=KhC/b9I/8KouKAr9lzbcBZ1pdpO5WM3LA5uhxGv3+swnX7UaoQCbA6JW7mtam8ttwTQxbmj0WGj7Lkkp8KJ32IKOt27h/SJ47cOy2v6zZue98BFpTWNP3hRdehms42eZtnRBu05H7PJc8QiATQDCJr0u653qMapARJM9H5hG/RPvFsTXYUj5s+Vn9X8Px4iwh8foDxnJ69selos7xK1NcuCG/GuN8uICeAfL3k2ouJMR2ACdvgrv+L4mvrfuL8C8UEZU5ELtyMp9NC8M1aI9DNi+4MljsHeFpOPPeTpFYyIxZ8uy4zkPjYpqCqakoXQfbKglB3p3CIxayi54DiOIBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV8PR12MB9230.namprd12.prod.outlook.com (2603:10b6:408:186::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 19:35:08 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 19:35:08 +0000
Date: Wed, 29 Nov 2023 15:35:06 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
	kevin.tian@intel.com, nicolinc@nvidia.com, mshavit@google.com,
	eric.auger@redhat.com, joao.m.martins@oracle.com,
	jiangkunkun@huawei.com, zhukeqian1@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH 3/5] iommu/arm-smmu-v3: Add read_and_clear_dirty() support
Message-ID: <20231129193506.GB436702@nvidia.com>
References: <20231128094940.1344-1-shameerali.kolothum.thodi@huawei.com>
 <20231128094940.1344-4-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128094940.1344-4-shameerali.kolothum.thodi@huawei.com>
X-ClientProxiedBy: SA1P222CA0170.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV8PR12MB9230:EE_
X-MS-Office365-Filtering-Correlation-Id: dacaed13-a24b-440d-d662-08dbf1124b6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HV0tqEtEU0cbnEN2au9wLuhEhYht6iZAEh2VZcH0e2QPyt7tmnu6Zm7Zrfh7mY3tuDV6dhVNxyiJkw1z4UWjKdbmlEgSmIfGgiOoIv/SoGbWmEYd2+q5VbiwBFfhpa7Jj1CgicaDxB8OYK+/mPBXQzjJz35XRdkM4gdxvbggqvvIrOzaRKhD510zmGjuGJ7ROMn/BL4MRT8aN+SHJGn6ZH9s4veK3cQrnZpz9qYFZWt/ruxW9h0KnPpeiHiMonR+JVe5p9DVfxAeXOI0jUVUgZoWT0raaP674tk4lAP5F+LgFXPzUnBRUdWWIPyBxRXSDJ8hvmHi/0J6ZV++Ig308cwLjExd+D977gLHsUkpGeZQBs9AHa9j+444aiiUwNXVB0TBhOmw8IorVy5130XNR0rhi6kqoSjNHhvJIr3XGdI6LZAeMiaPpcsfnZi2h0xP03hb1I2kfyTSgP2kF0RJutQm5b90qyKYzVgM7v1/LHfLzN1XF3IpQzWn3Ht6+qAwHft6B+0pAen0TTKArJyD/6oYSIo8lt8/uFK9do/fYvCq6zKtrzkMxY7jS328X0GnsqaoqUjvUQ6mEcu6CO9vGMYZZn60XDssBSeawXOkqft1/SDhpSj7zn/iqzsVFAiM3X4airgRVzRX0CbaKUDRd0Xd4yZhUgdCEPj5oNjZ1s6ckvbNcxLLTkYiHtJDSlfU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(41300700001)(202311291699002)(2906002)(4744005)(86362001)(5660300002)(7416002)(4326008)(8936002)(66476007)(6916009)(26005)(66946007)(33656002)(6486002)(6512007)(2616005)(8676002)(1076003)(316002)(66556008)(38100700002)(36756003)(478600001)(6506007)(27376004)(14143004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gon7ChgPhfTaybZ0QVBHjcJ8sVT+aqLXyReuwsNW1JP2VObx/NXLfA2x/KAP?=
 =?us-ascii?Q?m/hXfHh/yRfJzz8JR01wPhT6uClSakfKuevKu+JiyOcnEGB4FwYCVurOa9oI?=
 =?us-ascii?Q?+muZVq88e3aZo6rYJX13x0djvTgLFH2616Q4+ZdYKV5tUSV7nBBUcCQp5sXx?=
 =?us-ascii?Q?Ky/pDBKubR6X92EcGh/NM/f3vDzksfrLrqWhnoKgcCXbpL7+n3UchjKSL3Nx?=
 =?us-ascii?Q?n2yX+8PQk9StmwUNcyGmZk8nvpy7X0OqDPOIBp00F0e/S6uY2Atibs2N8Qm4?=
 =?us-ascii?Q?9fpyuJTwgRwZ98VKaugr7MzkivJMLAuTQHm1Fl3bD2gHt3S3Kx5LHaIroybR?=
 =?us-ascii?Q?AOb1jteWf1rNt/cdsfdHWS8980gKP5UDhLN2tifQvAF3/kiPfu/v3XETYyPO?=
 =?us-ascii?Q?fS/woBviFuQ1n2S6OxMZS3uLcNYbkyQpYvwi9kBrMUvAQRQ0yhvBaiCAFXpp?=
 =?us-ascii?Q?15gd/DDfvdMdCVZMK5EtlbmJ5krAfI+uFPpbIpOhhZ+SS8WcK9X/zxg6m8yk?=
 =?us-ascii?Q?udqZLl3GfHIGYAywbbLWws4aiXwIZSwzi5Lza2XWwmH9pyoOQAyUwE0xUbOA?=
 =?us-ascii?Q?NGhzVSqHyTcGRGz1QE71F9sHOhFsaJ2+MStlV4XUD98lWARt/xQHz5t2/NFE?=
 =?us-ascii?Q?SBFLJSZpY2zyqKLtXgJOU9zc8fy8I7GlCVyu7Y4kuU7pRR1MIEVuaW/XmmC/?=
 =?us-ascii?Q?LK2Jbm0WDciwg2yOMCiX6G7VNWxJoJMZWAinYBHVjtzwJq9fVzlrrCmMVQML?=
 =?us-ascii?Q?/kt9gHqm51N4TaUitLewoEiuFSm1Vd5EtEzRIkMnHk0Rmw9oWUHd00RJqjAm?=
 =?us-ascii?Q?Ue8FJnSzl7JmYfrzOSSbpqnkbLrE4LGNJZseFAbhq/kZmeYq1gOaS0KcMQXu?=
 =?us-ascii?Q?4qU8HpXRmyCEGERP+EgVOXgV3TMtTOOk70zW7bsl02oqb+887UsUkWQiMK/4?=
 =?us-ascii?Q?urDSPb1f+97sKu9gAUd+V7IO5hex9EiINnqYzwaL8iWNbbXRIKoJQISUxo+1?=
 =?us-ascii?Q?11EsVocrZjMTDQj/OXM85eCvq6+hP2g95R/QGivXhXR1FpTNWn4r4TnaqoQ6?=
 =?us-ascii?Q?4mLdQPyniriO+5ZQeJX+h56esVugE05idT9pZZ2OlgbyL2Rhzi7/TLp5fDhF?=
 =?us-ascii?Q?B7idM/gcHMBm2bY8LEGO2EnaXlGuvEruxqYAiTayPuVQFFYLeH+cG+LKaxQj?=
 =?us-ascii?Q?1jJHUY5IGefPEYMI8KTuu40IY9PC31rlMagjEVCp3+Ep8sq7vqFWAOlwXrsw?=
 =?us-ascii?Q?C65OUSaZApvh2ikDzEKFutIaRc0OMFXhhcK92gXTuLy2to21ykkUzLUeUhsV?=
 =?us-ascii?Q?gkirexKryppBFiG+zDYI4l545JdWpM8vSVjyL/E0d+5oETIDzS7A61QIBuZe?=
 =?us-ascii?Q?BaiY3X9rMMgWYJlsP2WoLdwWaq+lX5cm/mxWeoM/saagDiWr3avd4fCnI6OG?=
 =?us-ascii?Q?1aBGhCqPYp5RhfBiq/p+WGxMXVp/NZrsCoZFtqohsv9pt/1cALAylM1oG2D5?=
 =?us-ascii?Q?RusZwHGXa8QL9JXBPbNS9F0dwJ11/4NJiVF/dqBZVeedsdVvbdu3/yg7yLQA?=
 =?us-ascii?Q?99FHvKp8n8A8yzlHjX3B3W2Fo/XgLegokTtGZpz+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dacaed13-a24b-440d-d662-08dbf1124b6b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 19:35:08.1385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qiiuG4lPYGDk3hhLGRS89ublYmdk/WX3Ib/XFJhMmS7K5OHNv37srgBUcPSj7Ohg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9230

On Tue, Nov 28, 2023 at 09:49:38AM +0000, Shameer Kolothum wrote:

> +static int arm_smmu_read_and_clear_dirty(struct iommu_domain *domain,
> +					 unsigned long iova, size_t size,
> +					 unsigned long flags,
> +					 struct iommu_dirty_bitmap *dirty)
> +{
> +	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> +	struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
> +	int ret;
> +
> +	if (smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
> +		return -EINVAL;
> +
> +	if (!ops || !ops->read_and_clear_dirty) {
> +		pr_err_once("io-pgtable don't support dirty tracking\n");
> +		return -ENODEV;

All these prints concern me, either these can never happen due to
constraints on the caller, eg iommufd, in which case use WARN_ON_ONCe

Or iommufd does allow these improper things and thus it should
silently fail.

Jason
