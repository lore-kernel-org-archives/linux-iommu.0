Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CAF28DD1
	for <iommu@lists.linux.dev>; Wed, 25 Oct 2023 13:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="esTsISG8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1a2g5YaIWzJr0OcqKqIn5pSQhyb+knLJFafH3XwAIJGbJ0dcfbmSqrWQ79qdhvy9D8XJbhBcmp9OQeayGNDaWBimdxIH0akqO0T2dMGYWMMBkhRYt4r9XJJALkQl2nuHUfiF4OJPmhR3eLE7z/smcIlD/nKQU+TPNa4aMeA5a1UZwJp0qSSBm+aWTcK/njQqc4J4wXW9ujQDNA3bIwaMSBVNb1ITgOx/pMVMOuM7NWlsHUsPDranrK35ViTE4Csw6Wn6ho+4+0R5nqcT5B8wb2OC2DVJ/QtbZ0Lty7e1h2P5tFl7QmTFqeYTEwR7HYY9Xe71P+D6tfKtSYtOXRG1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gTKFxoyxaGZuq9l7kAPfN+xv1JxEPPhLVPjMn4AmgE=;
 b=QniyWRp4Z6np8T6cRuSCArgm+dW8b5OfMp1Edmif4uQunAoUh4XZA+kbvmOUgr7PlTSfsJvF50DHsjk3oJP6kWDfKVB4eHAm/ca3kUBTPtQrjtzu9jUpQRA52W2feu2HwwphRidrE1rN/1COw4r606T3e+Xeuw1kYiaiLs4oOILrzlULRRayBbt2VMdLrrS7tCeaGbLuM6k4Xn+N8yzvVw85U8E5HP0FAof2S9NLpghuKZP4DxIUWfFfmjclkl/v2o+gOxui8ZwL1ciiV5hsNcUYUTdKydmAb3E+plYVVl/MlL+1QTbIF39WI/LFOyUmUcj7deTNASdtROP5cDyDjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gTKFxoyxaGZuq9l7kAPfN+xv1JxEPPhLVPjMn4AmgE=;
 b=esTsISG8jt+hOc2+ZpiUXElCjWxI37EST+ysIJZKPEfR/xSyS9NuEivi34qJtV+CJbKg4b9aHf0cYGtZJJpOSBtgqbWLBlwbp190CoB9GR5zqZw24nhzLyJJ/NSLIc3fxiZNuUNAPhT1hTjmhwJ3S4JBOE6DdnBo+15l/rsV9FwG+y1aJXcAy6YDd+kKdaVNoOMPGi8GTPpiokUiTWyEgWmy95y2Bvkq28a6iS4Z+twsJjhriLvdIbDR6GhTFdWqRyNr+a0K1Ke1homZyyaZZGjEsZqhODR/yPvYNgzU4PDu/ium3ZqPVjMglIrnGi/ngdK6Bg0y4CMGzA07WWgdYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB6967.namprd12.prod.outlook.com (2603:10b6:a03:44b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Wed, 25 Oct
 2023 13:56:28 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Wed, 25 Oct 2023
 13:56:28 +0000
Date: Wed, 25 Oct 2023 10:56:26 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH 21/27] iommu/arm-smmu-v3: Put the SVA mmu notifier in the
 smmu_domain
Message-ID: <20231025135626.GA1118568@nvidia.com>
References: <0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
 <21-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
X-ClientProxiedBy: SA1PR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB6967:EE_
X-MS-Office365-Filtering-Correlation-Id: d20bdfc0-048e-4437-7caa-08dbd5622f52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	u+d1JSeNdfjdS1UgezmeiV0bI0POti0Ua9YyJ1MmdrIrP3O8npVgyewzIFFmcmxD7zHF6y+gUALsqAiS8HmGGuekzLlmbLBdFPnDhgKackSY49o02qBYrF9A9c3efQrgb+qYup5R/wjGfnthTS5AtX86cMGJj7bNDK6I0czLEdAhfJ+v0DPN0jwLxOBNU78/mJwxQFBlWdxFLZoFbBOINgKlASGSSQp70VBWrWSHcI0BqbX1kxEWL/xw1FAoqerKIFYZvukgrQSct9w05Nm/qHee+S8ptIT2+hjAVsgfQ3iI5/NwDp01fooZiEeWY2YP0YOFIUuuoedexLKWoxpmvTIPKiOHSHbtNvqVsrlzprdWIsNvpvDNVPb48HPgsljgOu0Ak3pFPHmU9wB6naEcrQ5ucIKOCG8aWo/vw5WWXg751k/3hyWJt3ppGSE9dpOQDRemBLDSj4K1QvCWVUgUJiA57oOyUKvg17o4mzE8DrkxPqcaRVKPLeT5lAGuWXq1P+iZnAV/HNDyRogHr74ga96C8RhDXurwpOv4l+VU+eNPvliORKtGxnWk+9lBT5Nb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(396003)(366004)(346002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(2906002)(38100700002)(4326008)(6506007)(26005)(6512007)(1076003)(2616005)(8676002)(41300700001)(107886003)(110136005)(83380400001)(5660300002)(86362001)(36756003)(66556008)(33656002)(8936002)(6486002)(316002)(66946007)(478600001)(66476007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eifBN4JrfjyDnEmBvi5BNhhl70eYeyZNaGVHtwpZG8C2EzOJKDavwsGt/Je8?=
 =?us-ascii?Q?d6/HnFyCVggQ31pLk9sDowkPM2PQMqz+1vNR2iLQTYUNp73KhLoxFcEc2bUb?=
 =?us-ascii?Q?hzZSOW/q34Xu644aNUVkfx8xKs165dTeG+Ug1485/DXcoZbsI/Epa7TR18b5?=
 =?us-ascii?Q?NVnPaD4kNGxVyJCdZfTHY2u70ak+rLpXRfwrSt/evOb1DVPPVxWZr6wYLYCS?=
 =?us-ascii?Q?nQmcTF8BW45SXKUnhoVN8yPemdUhjm1aweSe+IlSjuIjuD/fQu3xg7HYNP3n?=
 =?us-ascii?Q?yIiNDPztGod2lt5ws8Y+YUGsdkw4j89aqJos5Y13F7pQdr6m70rNEpXe7018?=
 =?us-ascii?Q?HnTz0jOc+zIVzNHdYVX6dNnoB05ETlYddwtidscFOT/6PIHas9S0NICywQAz?=
 =?us-ascii?Q?92UEbRiqPbRycAFJbAY9nh+xPBa74V/QyDUOqYTb8ZZtHlqm5ugc1bpKtC0l?=
 =?us-ascii?Q?Jq48aJ1uIg8gotjGMEEzd3VkVkVXJnJxdlYMIb/fa8+WSdt7yalCdUh28/f3?=
 =?us-ascii?Q?8rJc4TPIZYzp8Q/mc7SBfKNmBdzTb9NgZCmrUAKvDjTfCHRnt0F7puRnZkx1?=
 =?us-ascii?Q?to/VFuWC92QmBbi6cp1vmht/uO/1zijyjPnlJQyafGX6NYHJ58qx8eFZ4S+N?=
 =?us-ascii?Q?tn+FXO7rX98nbSqDsqCrH4cd+YOniNDvFu5jW7bQQjUhAV3xV/cLpZ1cH33D?=
 =?us-ascii?Q?pNIwSXxFoSk//uiWiSEzO9QtRrR7hvFd9NFVVvimYWdEbVkMng0TmiBRB5kG?=
 =?us-ascii?Q?T6FM1wtfa6rniJA1xfx48EdtcdaeUr3ny1pWRKeuXWvVSZdg+lOzKisxxui+?=
 =?us-ascii?Q?h5okizkMvsASjpFR+k5gpy1tBSCBP13rQM0QK27FlRVcYqIsUxI5nFCpg8Iz?=
 =?us-ascii?Q?gv4E951EzM/HLGjR9Joso+y5ZaRiS7CtO3AMYGj1p9+fBq3dAJnzS8enEf0c?=
 =?us-ascii?Q?5oq9LUmXQ5g75wXUTPmdv3LnXNck97XKgIRuuhVebfEPoWJsUHFXrhnl/KyM?=
 =?us-ascii?Q?8R3ie7iUpzXuaAtA0rw8URroAFhzKLY4pHR97j2yhyRmlNGG7pUAEu/+jzXQ?=
 =?us-ascii?Q?SaryYJH1dRPWG0S0IGWzpcHkVuON2UIJykSqbZOdXX8Pp8pIC4UaF3DfDwwt?=
 =?us-ascii?Q?MiO0Adtoi98LheXdHLkJRiolyX2Jqquyskk/Jejg1kQibAG089AHaR6fbuSP?=
 =?us-ascii?Q?QWLAIVptHkOX/7ruFISm86U0z0Cqol1yTwLcCaF1TfAVTBuq0NGI2yHLpbNY?=
 =?us-ascii?Q?4RqosqSetK7scYnvHmqR6BZfNdtT4u7NcFeSc59pyVrh3C3OT8U+fq4E1MMj?=
 =?us-ascii?Q?mMsYaWjiY+MutAADKSr475Tf9ShYoq0jZJxe3HYbjTwgMqd40HOtMcY+dYFh?=
 =?us-ascii?Q?BGhRhIn9LfJxQ+anEt8q0dhmgtSmtRhji9xLOuY2R0FRv6mHybCLHlpdfEw7?=
 =?us-ascii?Q?56k5xTFRu7cMN5KE/i5/Nghq1oTlw0ZaR0hHX4zpAHdY5dN5rQxgRhWJULx3?=
 =?us-ascii?Q?Ola3iMGfXu3ULyuAFs0zYMdSG1bBUhXOPb6vlXDEFalXEsYK4AtqFuDX6Hq1?=
 =?us-ascii?Q?mF57pKfVheou4S/hpLVFU64z6SiQaYWUWpNjr7Ip?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d20bdfc0-048e-4437-7caa-08dbd5622f52
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 13:56:28.1883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 58T0sIODNRPnlGX5b/qEacvGZIseegq5LE3InzKAxhPXxSygNHOkRIay4ZQ684Wd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6967

On Wed, Oct 11, 2023 at 08:25:57PM -0300, Jason Gunthorpe wrote:

> @@ -2752,12 +2715,21 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
>  	return 0;
>  }
>  
> -void arm_smmu_remove_pasid(struct arm_smmu_master *master,
> -			   struct arm_smmu_domain *smmu_domain, ioasid_t id)
> +static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
>  {
> +	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> +	struct arm_smmu_domain *smmu_domain;
> +	struct iommu_domain *domain;
> +
> +	domain = iommu_get_domain_for_dev_pasid(dev, pasid, IOMMU_DOMAIN_SVA);
> +	if (WARN_ON(IS_ERR(domain)) || !domain)
> +		return;
> +
> +	smmu_domain = to_smmu_domain(domain);
> +
>  	mutex_lock(&arm_smmu_asid_lock);
> -	arm_smmu_attach_remove(master, smmu_domain, id);
> -	arm_smmu_clear_cd(master, id);
> +	arm_smmu_attach_remove(master, smmu_domain, pasid);
> +	arm_smmu_clear_cd(master, pasid);
>  	mutex_unlock(&arm_smmu_asid_lock);

This is missing the invalidation on clear_cd that the removed SVA code
had, it should be:

	mutex_lock(&arm_smmu_asid_lock);
	arm_smmu_clear_cd(master, pasid);
	if (master->ats_enabled)
		arm_smmu_atc_inv_master(master, pasid);
	arm_smmu_attach_remove(master, smmu_domain, pasid);
	mutex_unlock(&arm_smmu_asid_lock);

To avoid ATC incoherence

Jason
