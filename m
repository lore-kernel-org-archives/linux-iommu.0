Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEE0347AD
	for <iommu@lists.linux.dev>; Tue,  7 Nov 2023 17:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Iu9CODmy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G24RDxhUAy8d/nioawwqyKEtlYsp6qSS7C50WBkwYvXGGFTtrT11SxkGYY/vsHcGwfWaGyy7RTuFKrY8fbCKfoEr+j4u0wSo4UWDzgEO57I7GGqrXb5SiJas/mVm6Y50Ftx0xN0++pVcm7rPs0Mk6II5TzHxo7OuMCnc/lqO6+nFlbqiCx+ikPD8W1k8ZygO2h7g/i4JnhBnNTrJRsQ2+CrR9IthwsN7FYBMLYuRjuNqrFpE74OLlSNBKqcOgf0nyJc75zrqUamHbDSekROMVxWGBkNycNs32H6KBFmU8jX0WmOgdTSW8my9qcQdA/02W23d/mAlmkelPvm0gPQ5RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cZAuuW5TMOXi/9TMRMXlKvBWpUejm58Rn+Vs5ZdXu4=;
 b=E1UDDXnRQ1NMbSSei8EX71L7XjNT8GDfrth1b/GKUrTQHNR8ln5zxdeKmmJ/ya76DpumQk4OAtJAEc1V2ET40Fw3LBNbEBsuuGq2THXA7YouXkqJ792CeiyyrlMSQpoGLhFPiODPgw+fvrhHC1QAZEFc7ZY3bv8ULsArG38rHQ6DfWGXsZy0hKxm9wkq+L7XNH1h6YP5qQUTkJ/6q+goQHOoiiFWX1zjtpjaHrRww2Q86gr78kXPLyNB0ye7NspJ2FJUuS68U3wTso8CCUPJEihqDV0erqxlpPBQd+1Hep6HOtKaoYafNiR/Pz/dXzp5z7Z2NRfE9iSf+9/t1w04Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cZAuuW5TMOXi/9TMRMXlKvBWpUejm58Rn+Vs5ZdXu4=;
 b=Iu9CODmyRBw0D01pR31hxGS+rfen92pW+oDw5rX299EKSuobZxrwAfVh70uaUIl44qZKmcBKba3gOELyA8EyGEKDs0l1RT3+5LBvfDmkgtiP0sb0+7XvZSo4cw7QrxO6SYpHHHV0tcspp6jUrjxikg9znGktvmq5EZ3y7b8shbkrVl3vKmSkUou9ZuvRYWx+d/ae7rn/RBkwiq7N3Yl4KqMG+X7Al16ZJQjGNJYlkeXh81fDWRrXmGXKsEMFqHrxfHhmk9up2fGba5ROuzL7UkVs9ZhwDX/FfnoCH9vrl90DTrWjwNiew8A1QdmdZUgqy4rsBJEdvIXiUY3JNs5pMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB6605.namprd12.prod.outlook.com (2603:10b6:8:d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 17:33:13 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%5]) with mapi id 15.20.6954.027; Tue, 7 Nov 2023
 17:33:12 +0000
Date: Tue, 7 Nov 2023 13:33:10 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 21/27] iommu/arm-smmu-v3: Put the SVA mmu notifier in
 the smmu_domain
Message-ID: <20231107173310.GA361903@nvidia.com>
References: <0-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
 <21-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
X-ClientProxiedBy: MN2PR07CA0028.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::38) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB6605:EE_
X-MS-Office365-Filtering-Correlation-Id: 62d103ad-6cf4-46df-3dea-08dbdfb79e0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZYLid9EDN5AUpTMUPOaMb/b0Rz6Y2oXx9Gi8QkYlW42AcHxaKv43xSjEZhiOcEyf+z5y2BIHZdZ9r4nxW8gtHtDEReutKxziAxvFikF579LkrejEA0gTCSymMCPQmMMhlx0UOQxdf2rAqRQtKJGuzTHo0sRRjr8whW8bo8kRLBqGNdStQ2nsrWovFAF0lRk4MObT38MpDvQzZdmb+lCsXMkFdbPZxbiTb9Ps8Susx8xSCxJ6yxVJQm6AC1qsOwuUNtaBct4nbmT3LJ2hcK53cbuOVn+nvXuyAYmR38rL6xGxCXZEKKK8h6HOPgZdkiMtsWkVwt0TuWC4xojfxRIy1QNH4sffZSqW49Y00bXA17FWRb9/ldoWECl/qFFstGi8Nnso3d/knewYVbwaaBp7uldovIVFBmP9WIPKgPKtKEvHIb6znm7jzZ0cFA1FRxmxwj0aAujDLsDU99almPnrLT0qTBrpBrh3jCWb5mlHByFQqKvy25ktXmwdXCnBEH+5EAQxBaiphKtOonmygy8IV2QWLQgwjY6kToOolEEv3cJk6wfSJN8qA0G2gjcbIXATnDnqcNm36JU5oAxrnlWuWTHn1RuJxKCvWa6UYCGzt0Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(346002)(376002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(38100700002)(86362001)(5660300002)(41300700001)(4744005)(2906002)(33656002)(36756003)(83380400001)(478600001)(6512007)(110136005)(66946007)(2616005)(107886003)(26005)(1076003)(316002)(66476007)(54906003)(66556008)(6486002)(6506007)(8936002)(4326008)(8676002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MxrOY5JRRJ1t+MJkG8ccx0Bs+gXLe9eJHqZ/F0Yw2vRm/8kO7XRLTPSr+Fs/?=
 =?us-ascii?Q?W6uJOkXbgkuU/tbp+KJTkTU6ALcEFuqou9Jni2w8cOEmagZEF5RTwl64pVHr?=
 =?us-ascii?Q?HXy640B1jY39sW8h9hCPTdyO1heSZwH6/f6vGfSiVMZ2C+X1o8JF73tHLPYg?=
 =?us-ascii?Q?IiBoTWYE2nfvaEiH29DHo/gauNMcsZVU+VfRHAfoMsohNPKiLsR4FidbXkjn?=
 =?us-ascii?Q?CG/d+bdVkAVj9qpEKcFoGZla6pWnNaTpoxaAMlRD6Krf/2JL5t4LhfXnu1zP?=
 =?us-ascii?Q?TXbjfrqhwbGRGz3B21P0M39KtqwT66Xu2NZl8vYLVUjrFK+8C+5SUv36VjZU?=
 =?us-ascii?Q?dG3+w9nskAbLM4kW87zTjGcPUq4LlIVRatMuCJ6gOn4IiKgtcNvKpSAHAwfB?=
 =?us-ascii?Q?UnXas6SbjQ9ds+HCR9uqAkckMea2FVkGKTndYQSNdOd1TGh4s5RvII8YqtxA?=
 =?us-ascii?Q?qj86cQM8fUFgPPoaBZ/lFm6N7uEV3tT8aTvT84EJ48a4eyMMAMHOMdLKpnlS?=
 =?us-ascii?Q?ln4tqODdrfsDrfMm9LgR/Yt6G8WYYxeJqJF+MWHukmD87pwyNvNBMdsl9MJl?=
 =?us-ascii?Q?X3d+TAVHrWvQiNL+pxbqNOGndueyaeXKiW0ywKH+TRAlJNt/IVgFvUNrsCux?=
 =?us-ascii?Q?BRIDlIuBrjTaiDO+va1CD1pBrgLKYhSsRwacsBKtY//ows+BHw12SycsIqhg?=
 =?us-ascii?Q?/ujCeqPz4+imvmIRq79zTknBRajEQaWCG7ekC7DqPFYrBX6X4IEPiLk9fUZl?=
 =?us-ascii?Q?Zr44xw2jVqf4aCT59Hw/QTmcSPY30lLHAdWGPFLBCXUY4NG1YBhQFoGJFu5a?=
 =?us-ascii?Q?3n814D7PAdvahXDUBRn08qvX6hWPxuJzZFgXZdFi4JutGntFhG6zVnnX/wDj?=
 =?us-ascii?Q?ZSp7BHvlrDka0HrEs6Zgc7y34K50nhD8kwNKchOcH4y2Uec7w//SmQ9/wcvc?=
 =?us-ascii?Q?OkNyMGBDZ3p7tKIIXI6ea64UMoZeJXC2yp3zt8SveXQeDIje3Yn/8nRSL0oa?=
 =?us-ascii?Q?g/eFkWz8fluk74qmefopoCq+YiqXhK3PCLNieTjFZp77L7QKlwK83HdRobSt?=
 =?us-ascii?Q?nS0WqNQHYQx+6ymA36Uc95bZB6WuNUpMKLTuXVKJaKxj+zxoWkQHWH1FkMBu?=
 =?us-ascii?Q?w8GPKLHkDIvwZIL2Bq0KSiyna8C/LgsQPXhoUYppZ0sUejcLQxV6GLaDQvHQ?=
 =?us-ascii?Q?UBO0qHuNuPZ6eMWh9j6rNpo+B65csK3Lxc1iCksPg0k2yf/9QD8DlzLfoXFf?=
 =?us-ascii?Q?jZ3VRGmCg5GTGvkAZCjek8P+PeYQH/b+qovW02iRBK/iQ5oZkMKXYuLnyQWe?=
 =?us-ascii?Q?l0vgerYVYxvIH67XWiCOYjTDH9x7Wa048NyX2JxLg7aV1O2swXoK3sXboeDc?=
 =?us-ascii?Q?MM2CuHBOQb+DZX33ekUp8SAtALJDY+l1xlC0jdK4SZ0POT6CdIGJS8BXgHfz?=
 =?us-ascii?Q?8v5gk0UowXTCseCB1bXsxSkBYQ+GnIWFy5gLWPzCDrnCtNfSQg5EKxpRmjWj?=
 =?us-ascii?Q?xYIxrr95JtOQrazZZAB8x34PYMhSYPjygktyx6K4hKyGyxhTVqSTRY9Z+1zk?=
 =?us-ascii?Q?aUuLZLGHfAksNNHHMpevhHjpAyB9KNw/USI7WdWT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d103ad-6cf4-46df-3dea-08dbdfb79e0f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 17:33:12.8224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N7UBYCCWMxi/rSaYPc/icqFim2UG6SCduw7rj00gi97dBnPa4Sa3xlJqCWg6oRIz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6605

On Wed, Nov 01, 2023 at 08:36:39PM -0300, Jason Gunthorpe wrote:
> @@ -271,33 +137,27 @@ static void arm_smmu_mm_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
>  			size = 0;
>  	}
>  
> -	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM)) {
> +	if (smmu_domain->btm_invalidation) {
>  		if (!size)

This is a typo it should be

     if (!smmu_domain->btm_invalidation) {

Surprised our testing didn't discover this yet, it seems pretty fatal..

Jason
