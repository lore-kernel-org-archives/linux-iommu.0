Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A7328DDE
	for <iommu@lists.linux.dev>; Wed, 25 Oct 2023 14:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WlMjQb8a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Emtm91RZGEIaQxYf0zfc0APwJ8zGi1zK0YbjGf/+CXYr+oTKN45lq8wKQbVTOacts0SqticRekgbpXoSIzqIHIJnZd1iPxkcNUlJZ8YtFMgIXFEdiCVGjSuOi8CyHQKrG0kfGE22d5qylxunavHjIOmdzXc79B+fk6XiLMSdVxZjZ85KumWhPICe6m+eJyL0vFgDq+XUAsQjexsI92B2eTdJTqaeeTXR01xQZ6rTayYszjPNqB2wqK2+x70Ijpz2Jn+nkqylHS7C2SIoTZ7BW50aU72rDR8mtttey1QAERuY1muje3wFi37TrNmUrlr3Hh16MfOyFGjCwpAU+TZF4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fX5T6LtI2A0OeCYMeK9Gu9v0NjLIMVOGnURjjAmwWM8=;
 b=PxfB+OiBunOdsQ+eCWtucwEasyrDnhgBP7DCwGKCIaZBW+brGu5Z0Nevyv5+8/JqYA6xIAKXOqyQs1//pp5SHVaoYi4xJ0mtPJjduYBvqMitXCVPo9zZBhyBVPSal7geyvY0fes2YVEFCvsOhZY5PqfROrQNnTo8gZcCt6E+/1Mg/WE3W0xUTd5k/dZeWv/yo7pd1WWa/Iwzuo/iMUcyaE3Q8KWLjGzrNzsGh9LoFNB3Ay5GnyZHTP9h3WYz0qPZeIUn9XFC6PpPbMDHmd6PEyc27snYNMikWCDcqKZPFWG80/NtTNeEjEARqBWrlzi++S7WiC8hJKOXNli4BPBjgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fX5T6LtI2A0OeCYMeK9Gu9v0NjLIMVOGnURjjAmwWM8=;
 b=WlMjQb8aJ6BHaamrR0A/hF6IKGuv9af4UwNU7hf9h9OSec6sgSbFsZpvyOEpePomsVtFUgWmuyZLsjZiToD5/cwm0FhqUtRs3PRifoIA/es+YDldKv/SbHKpLtbn53eY+EFhr0Gm0XFOYFocI9B2h4HI4F356JFMgHmXhJ2vt2O0m9sCX8Cp48UjK6THs9Cn5AhAPJA2ZWLnxvkth+pvKBfm9x13yIjFbwp5NRg96e+vXIz4biUeHQiEF7Sc0iKR7k88KQommJpBytrcG4Qew7+lozzviy4bQ/aFWm2M51EJvbKew6jGHWMv3Wu+GF3HJSD+oivRXnzzgw6HM1yXyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4902.namprd12.prod.outlook.com (2603:10b6:a03:1dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 14:01:06 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Wed, 25 Oct 2023
 14:01:06 +0000
Date: Wed, 25 Oct 2023 11:01:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH 17/27] iommu/arm-smmu-v3: Thread SSID through the
 arm_smmu_attach_*() interface
Message-ID: <20231025140104.GA1118753@nvidia.com>
References: <0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
 <17-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
X-ClientProxiedBy: SN6PR08CA0034.namprd08.prod.outlook.com
 (2603:10b6:805:66::47) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4902:EE_
X-MS-Office365-Filtering-Correlation-Id: 2661c309-116a-4ff6-7cdb-08dbd562d508
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	akVMso4YlyDspQ89GhMTFZchdlQNrH4dBfpUZILxTwr+o7mcim4wliwEHnJqWsqZj5vljWqlWtRwGG7cprsU4KGwZfDiQzyFJrnNFP6kyE7ZDK7cRMNLCH+vLxHDz11svQgjhm9bSaQcO3Z3NLc4Ll/E+XK5fLql+Ygi0o75aT9RYeo5TmElQGFKwBnI1H6ReOXhYAcxqeGE9G4AenaGJElw7t1OPxUQYDlTMHBWrz+OhmLNOQP1+IK9pArtMYmjdvrbns8HTcTg9zGQqKc1Eug39GrjyTGr1/+WDIgBzO3cgDcmTc2wGQNxRYG6wJNfXwG4bM7vd6Lj82ePrMiFViJVVus2vaS4/pZT6aOI812UiD6tBXnrOql0ADokDSDqm9EyRN4II1XmHllLPB6kUddKmGI4zOTIsFSC4wfGlLifzY7ZONQCrBpCqYPE0YOH43ST5fn0MOZYfHERIVRw9N/n3qDq8gor3KY09YDH/GySDWWDgOWf/I/jNE7cwL/E/xCTC29JlPgTkv88Gq4prKgsS8dy8mkhvoY+kWeRKgCLedOEHxacFO9NtjCkJo/i
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(136003)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(478600001)(86362001)(6506007)(6512007)(110136005)(66476007)(4326008)(36756003)(66556008)(38100700002)(66946007)(54906003)(316002)(8936002)(5660300002)(8676002)(2906002)(41300700001)(6486002)(1076003)(33656002)(107886003)(26005)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IidN9ilefZ2sviMxMSK3kdkAoHvifJUK+4DA31Z6KVffxKtRZ6pVeuRiHcW8?=
 =?us-ascii?Q?3EMi7rb3BFWxek6TYJlqRZjOFjqRSvkkFVLPMvh/33FjwOlttOUgUx+PV/cB?=
 =?us-ascii?Q?X5Hcv+zeAA1usPCYrNjVc8Bo6M+VnwIpBWpwbBOryYXDDK+n0RB+i67LCPxc?=
 =?us-ascii?Q?MKqmXKkGWVZXAZMkT+SjxTAI5zrGt3dyZZYwjE6scdBjcUoOtxqkSfIbixaC?=
 =?us-ascii?Q?oV61fKl4SguTRMa7Y+MxHf0Ivx9pT292kQGCvUbpjKLlbWOiV2rp+84UC9b1?=
 =?us-ascii?Q?ba/gPV34n50x+ZxPcefnxIrNCkmlKB3voKG4ShrKrAuceyNQJ5EBRvfZgM6+?=
 =?us-ascii?Q?ho4K0mCdnd2UcWsUxSlHw+adGlvArDDbmMdRsNqgbv2kMAFieabQSOOgY0Bd?=
 =?us-ascii?Q?FKb5ZWkw2NlMmqAk3tz+yi+Q1sHcpoHdjOLfXV+WWqJOj6cz1LFCEps8CbEG?=
 =?us-ascii?Q?86PNbyFBLY2p9ZE/hU+vJDvCDbdDMcWfj1VnI1AYaDg0vqvv5z3w0+Fxra/Z?=
 =?us-ascii?Q?sb7sHS5erV2XsL5xJ62zjnYkJBu3lvJNb7tX6HITDbVjZ2tD38TEM2M4/OK/?=
 =?us-ascii?Q?PlelXEIfApMZ8SerS+clag7FI51SjSqjU7L+vdn2pFQrl9l792vC9N8CH3Bo?=
 =?us-ascii?Q?ybDZ2Sb97kyM+xOov7g7vIkfnTlr8aCme2GJCkTAefILuJr33a/b8eUzlvlQ?=
 =?us-ascii?Q?Ko6EmkxVNDsJVAl9NJjjHWLOHDQo/H8eAjOomfKSZOZQ0mb9yhtDXh6jAU/D?=
 =?us-ascii?Q?kaFZdmD9qFdw9Q35XxlrsE6SbzUEnnlvIZb5OYXiwLE1zEpKBuuHeWAT3F6c?=
 =?us-ascii?Q?SvmdT8GLk5lrD02oVttrPunpEzOIwdb+xjrpULgl0q2miLy+ynlW6fODX4Hr?=
 =?us-ascii?Q?hvY1sh70pEE8VLga7hpTlaNoy4Js4Ao5G3xnhXa8to0ORyvHqwVAL2o7eb3p?=
 =?us-ascii?Q?ik6mU5is5rUdAqIyWcF4zKGhnIF5AP8C863m6+mWJWv2y8BPHUZ5GB5KyY1F?=
 =?us-ascii?Q?nWj73K+I8uI+e5w+3XLhMA8PmwAKDqP2isuvQgLZU6cnHaec3BQ4KL9WwvXE?=
 =?us-ascii?Q?usbl/4zhoNQljqQoZh64MJvKjYSIX9pWFd+uEA95QCZOK9UnxyElojIgCRPQ?=
 =?us-ascii?Q?5zrNxGlXioWG/MVoKYo7oP52RaNt/PapupI1ylGyzlv+5wJ1pDdNGbP0nG9t?=
 =?us-ascii?Q?Pul+k7f94aqauS7Cq3QjpOKyV0eBr/dUbsng8ciox313dNwxOJA5w7lTeT3n?=
 =?us-ascii?Q?8EKzYV5oq/CqLlSRbN4DkkC7Av/v+JBwcEsyPOLLfW6qbpuwxwMhsuT1AwRC?=
 =?us-ascii?Q?WttFbx4Ci8NF1ZkE63z3Zm42+y97ypePiBOpb+bsL4FlkDTCZ4eGHbZyrnS4?=
 =?us-ascii?Q?2v10cagl4xq3S0UfdUsILihKAJy8rYdZ0akfXh+6KJcMm4PTXm6GMfcT3dIt?=
 =?us-ascii?Q?DBAN33gtd7h9vvBPfHLCfKahq2RDou7aVoZ4w2louz7vllt9cEFCg5jivnKn?=
 =?us-ascii?Q?L+nXh13AQXynt7q/wu3a3UEPQLnGFF/5t2w2/cf2nht1gkiaZ6vv+wXIG3o6?=
 =?us-ascii?Q?8OVgounhULzUjg5hebSUBk3RrRD5xvAsebeJwWFl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2661c309-116a-4ff6-7cdb-08dbd562d508
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 14:01:06.2183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AzNucV4fDx2zP//trDMGj3/czU/o5UokLYw8+2Qzpp76BvZU0QyHLb2AD5tvBvpr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4902

On Wed, Oct 11, 2023 at 08:25:53PM -0300, Jason Gunthorpe wrote:
> @@ -2609,26 +2613,27 @@ static void arm_smmu_attach_commit(struct arm_smmu_master *master,
>   * When an arm_smmu_master_domain is removed we have to turn off ATS as there is
>   * no longer any tracking of invalidations.
>   */
> -static void arm_smmu_attach_remove(struct arm_smmu_master *master)
> +static void arm_smmu_attach_remove(struct arm_smmu_master *master,
> +				   struct arm_smmu_domain *smmu_domain,
> +				   ioasid_t ssid)
>  {
> -	struct arm_smmu_domain *smmu_domain =
> -		to_smmu_domain_safe(iommu_get_domain_for_dev(master->dev));
> -
>  	if (!smmu_domain)
>  		return;
>  
> -	if (master->ats_enabled) {
> +	if (ssid == IOMMU_NO_PASID && master->ats_enabled) {
>  		pci_disable_ats(to_pci_dev(master->dev));
>  		/*
>  		 * Ensure ATS is disabled at the endpoint before we issue the
>  		 * ATC invalidation via the SMMU.
>  		 */
>  		wmb();
> -		arm_smmu_atc_inv_master(master);
> +		arm_smmu_atc_inv_master(master, ssid);
>  	}
>  
> -	arm_smmu_remove_master_domain(master, smmu_domain);
> -	master->ats_enabled = false;
> +	arm_smmu_remove_master_domain(master, smmu_domain, ssid);
> +
> +	if (ssid == IOMMU_NO_PASID)
> +		master->ats_enabled = false;
>  }

This is missing the atc invalidation for the PASID case, it should have:

	/*
	 * The translation has already been changed in the STE/CD so flush the
	 * ATC. This must be before the removal of the master_domain to
	 * ensure the ATC does not become incoherent.
	 */
	if (master->ats_enabled)
		arm_smmu_atc_inv_master(master, ssid);

Moved out of the 'if ssid == NO_PASID'

Otherwise S2 domain detach will become incoherent later on.

Jason
