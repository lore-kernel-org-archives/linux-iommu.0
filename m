Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012038.outbound.protection.outlook.com [52.101.43.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5253F2D8376
	for <iommu@lists.linux.dev>; Thu, 23 Oct 2025 13:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225451; cv=fail; b=qc1gxa94Ruu6sbn8CqiAPRvsVrfnaeRSnxPhySxZK7g0bGS9KkkqK6Qq+iVrTUHm/+8Q+/+sSEkykdc8BiG/LMtKsa4vCbDUj+cP5jSzWQxolMwMdRWNb5WqdIxWffz0cPcGCMXvJXf3vXzScl6pmi4EoSrA7EWkMBBICfbicpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225451; c=relaxed/simple;
	bh=9vW9b6ICSEZ4CvKWcHc0bg+ebsEUJBrY3UFjlmmSUCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gOVYjRdlEBTjIbWZWMrsooei365Dr9TY+jN83A1OhpMUh74yrkcq2vSYctwL/DW0NLsTwJg0Q5yheB+SdZGVmitIZFq1RpRTvF0rEni11l3m2ChiIsyMDMikH6wFk4Ut4EE2ITvQRbX7kTUOsjlSevQh+URwNFRffWduKlgIQdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fT7s66WF; arc=fail smtp.client-ip=52.101.43.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fT7s66WF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m/ybW2PF41L3sJ9wvLTzkoFlyQPhTXbz+60CB1VcnHEa0JwuJONNYa/A9+uiIzBRwRZqXsSTerks91RTOkRol5NNkiFJ+KwCPbEOw6QPHlPyjJfWtvfP3BHgZTzEYke6QI3g88oZmuyG4/8bXH99sd73FaEftvebCFxqhYeWXsLkFwUAdAUoQbUViNAm6AgdRyW9LpoU1pQiDdad9mphjO2zvytJLNB/LsnCWfHih4owGcCvTqtOCaJk/eVMKe2lVRtWfBtAZ32Gx8MKFbrY7btuhawBHM09xz5DD5Hp3PxCIVoHAsInp9+hSGFe5IpBqWfPXY9a57ssnYtQEuFnVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=770eKW91iTZvIQmi+3twJFmaEL4vR0IFRo9/yNx+TuU=;
 b=iudUfvyXh6rpmxPpyX+r30CcMz8lMGOHAi45IO0uvqyrIYxVRJMSYdWjjGey8zlJqcqlC8ERZqMDQYgILbf3NZugEQrK8p2LbO4YWUrAklYO5ai/y73q4qMCPKJ5AK8jor88BS5GOTHrYXVMzsa6Ps3Fns3LwxRD3pkIdWyQirgrcZyBG1SZ8DVJCGjtWdqm26wvyY7OhkRrdmFK3Bz4xTOz9zdXeCUDemj5xkhvxTQDHiU9c8zzYF35Os7ZBYWlKz8JlV8wgxPaKw+rdwWRUc3CuLmBW+MSFjsLBdaVPzAJAMy5/5GaINFa9gA+81rmS1/55z4Q5n3enBcE/N/xfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=770eKW91iTZvIQmi+3twJFmaEL4vR0IFRo9/yNx+TuU=;
 b=fT7s66WFgCs18rXol0YdeuInT7JolFLi58i5XUCCL6v3utyZ/ppar/Hg1uVkEHJlNm/MftuvroyfnbMTOlidmV9imEhTrcwrvmxDhnsjmcE4ls7hajqdMMeCC7GtYxJImyXI/ALHwOYAmg3+MvgP6ER7LMVG6aDzEM9JNMcE0jlhIuu5ApP3llDQG/GBS1H+41whADdHVd5xogTGaQVVj60BCGEOWEVJaCWhnqq0YAv/QKBc8sMYOPCL5thZa+sI4v4a9QUsFALLVjhq71LaxmOjFhFQPgTcoDK4N4JdSkpt03Ktajl9iyZn6WpmrkESMcY0GTAEkhjd3nSs61Wn6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by MN2PR12MB4455.namprd12.prod.outlook.com (2603:10b6:208:265::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Thu, 23 Oct
 2025 13:17:26 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 13:17:26 +0000
Date: Thu, 23 Oct 2025 10:17:25 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: nicolinc@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	will@kernel.org, joro@8bytes.org, kevin.tian@intel.com,
	jsnitsel@redhat.com, vasant.hegde@amd.com, iommu@lists.linux.dev,
	santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
	jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
	wnliu@google.com, gptran@google.com, kpsingh@google.com,
	joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
Subject: Re: [PATCH v4 16/16] iommu/amd: Add support for nested domain
 attach/detach
Message-ID: <20251023131725.GG262900@nvidia.com>
References: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
 <20251021014324.5837-17-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021014324.5837-17-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BL0PR02CA0127.namprd02.prod.outlook.com
 (2603:10b6:208:35::32) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|MN2PR12MB4455:EE_
X-MS-Office365-Filtering-Correlation-Id: 85d50f9a-bfb0-405f-38ea-08de12368298
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?joCFax90KzBNhkkVLXLhqZ6otMjf4e6/Ab+Np3mKdCVa/MxsPmE1LvwxAYH1?=
 =?us-ascii?Q?K3md+P1mGEwj5aImBxc5EVPwgL4x9pz3B3QCifpUGpdbjJTvxsC62oj9Mrl1?=
 =?us-ascii?Q?bbRngl6w2zuWQv1ayGlpggdiVlyX2P2rK1aHuz0wKP6PObTFhr4DvIKr5J0l?=
 =?us-ascii?Q?+/YnZwMoyGr0Ho59nZXwAuu4kwqRYd8nwqmTLaBGAEvCs/OQZ0xquE9jbNgg?=
 =?us-ascii?Q?utViV/QTNx9r35zRYUVx+RR2hNfFoeeLWAcW7ewfbgf9O8V5JiaT8o3FEn1C?=
 =?us-ascii?Q?HqJIJ0VX2BBYYYpBc05FaS/Q2GiSYyCaGxTxNamcbn7YhMVSi7cMiFBokxw+?=
 =?us-ascii?Q?wEkTOV4Be9kx0hukGtwEPbS9CB4N3xZ7nLrcmEmqr8PryT9Ou1qq4SzbsHaM?=
 =?us-ascii?Q?Ayon8m3iS6Rc+Hfsl+HyUeOKg97q+HGx53hsU2/qTHrvrB82iAcp6/u3K57c?=
 =?us-ascii?Q?TzxXnMr53bn7NMdaQjfL6oKDVWcsMF9kLHsAknf5n+EIB+FAFlHz7l84onCE?=
 =?us-ascii?Q?5w0ZmxgvGTL8NUSkLtm80hFprHf6ySMLcHalXheYDOVKDssRREIwPrGVbLEr?=
 =?us-ascii?Q?96J1LlvhE91ACck4bDR2uaNGPW1PSHlccEdIsSUuDxqOLc9wK34EGaecEQZ3?=
 =?us-ascii?Q?mbfx3hKHlx8T1n6MM/OxdRVP21g1Im+RjzaJ8fhMJX8AWua3tabEvKhl0QxH?=
 =?us-ascii?Q?wyexzXoPz5UZOcE5e310/y5TD9NYwd09GxDpVBqI9YWyAsEDY8FB1+Y/PoHF?=
 =?us-ascii?Q?wCBMsb3UxMxOuRhBFUP4Hzjv+gvdXzWCqCcsUhD1YFgEO/Aqzvo3ZxBCsl2O?=
 =?us-ascii?Q?i31xxIW8gZsvkEOm7JD8IqyrqHmd0Mm8x3BFQvnkeJBN51xRDw1aykhpnQzW?=
 =?us-ascii?Q?Zz+uoXdowPLJug1KU9v3cDW8O3eLYTUJKASyoYxJbhg2oB6Px38j+GFz+DbE?=
 =?us-ascii?Q?D1ZuMMjHDpjqafltw6L0DDUY7swZyeHqdHLiy3IeMYKh2eT9/bW7YXc4YA63?=
 =?us-ascii?Q?oK8kNAUf3FAP3cq+MsSLdB9mp+PRNrq69NEjYW6cKVfE6w7STSO5J6aXlkq4?=
 =?us-ascii?Q?xGWpROsmpo3hmFgFzXyJUmN9DuZ7qPyVuaB1Gap/p3kg9/eb7dQnz+A+sznC?=
 =?us-ascii?Q?GNNn9mkgHE4HnGHCjjLBV0qIUuRalp/qWRRgF6DwmAO3/bUDKSh/Xmmw90jj?=
 =?us-ascii?Q?U6B+e7iHRpnr8nR+lNRfySCAayDbo3a4o12eAiJ/XuTOn7S8CzUb4Q33A+jR?=
 =?us-ascii?Q?bFbhwG2c9KfR0e/F51QO17GyjjlIOx/O7aQunonqcqefCR5V/6/ZHqgheDMV?=
 =?us-ascii?Q?uHPa0SlqZ1p10p+AWRemLG0bnc1IDyPDwV2ucDU+9ors9L7ipa05+du8ih3E?=
 =?us-ascii?Q?5fuLHC3Sfxl7D6OEIu74B8GANusddNFsihl/uDCJgmrqYwtaOZTpsTLGIjEo?=
 =?us-ascii?Q?2k1pPTwLgsfa250UB/R77xpHsR6Zb9nU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sTzSOef9PwXbtQI0CZpWCk4D/VBLF6lryHlhzPBC30mWeSxXa/dlhCLU4oy/?=
 =?us-ascii?Q?k36kFT5Fq3Eish5fsrLfOkofbC+ORJFeaLv3JQjyznI8fmCKCZYTsx02KW76?=
 =?us-ascii?Q?H0i/WfV5q1KuLd4W9lqEFPZ0qIy1u5XgggozEyUGsL66BUlfx41YeEF0FUZR?=
 =?us-ascii?Q?wNa+KrhIIZqj1WBScV8+QNmrZD1d5eLc3jT4ONPtukMoEuvfSU7pU6ztQ31S?=
 =?us-ascii?Q?IYp4LGAfI/R54/Y4g1j+B72oA+rwteg0CKzQDI0K9o07GeTvyMFZF7hAIYG5?=
 =?us-ascii?Q?OoL/uZyhz2Cik/4bdmhbOGCN0Uv04lgyf+50Yse38NzY8tpT8NQhgVJmmDLw?=
 =?us-ascii?Q?7L/GvKFDq/G1ZTpC5LrPfOwzF30mt5jyPNFV4BY8ya1QKfVJ5D5BYSgedNMI?=
 =?us-ascii?Q?eWmrrF7bYNzpoAYUsNJ9Gaf9LB6LbSNWSjIrU2DgvuFCTUfTAxwVdwOb5O2Y?=
 =?us-ascii?Q?sQDt3VppUbSM5gRETm0ZXJRyCHTSodgI91P/yQKiatPWeJihSZPzO6ONxX4B?=
 =?us-ascii?Q?rgSb9Dsy5dIOLx9hhi5ppSH+rediZOrnentUwmmSa1+B44BYbAYkR/5ByDhv?=
 =?us-ascii?Q?+BFxSesTdXyhB9/LlKud5T4YHKywgc6DbHX5CZUP4Feng2G9hIvZL+HV8nIm?=
 =?us-ascii?Q?681nihDzvjH1t7/8nrUXmo3GllEFyz9mrc118mNx2/KD69szMtpCTSKwDXk6?=
 =?us-ascii?Q?8tYJrxNpNXV2ZxXqvXr+ns6TRJSYH5JFx8+1HbB32QUapZAWDhdvMkh3gyPg?=
 =?us-ascii?Q?j3UaXYusukvsLuXm2+KbwNcNeNTDv8FqEcEKKZfAaJ6pWWVqLF+y47u7/fKk?=
 =?us-ascii?Q?Y5TB4JOetbFehPnNjSX9LDu1a1TnrOu305E+T/U7FB1Xt3Tvu0jWLVeqpJeH?=
 =?us-ascii?Q?STR5ngaH/4ujT0NAz5/G6M91xnnE475n61cMq5yCbhb/AnQt6HsottxchR4C?=
 =?us-ascii?Q?NmaCfKnZYByc3HQAoj64g7gvIY5Ei7BBa/rKgA5O9V+d8/xOSNUuBM5OkcA5?=
 =?us-ascii?Q?ql+o6JvHXTY+XxIQTcPw8BUd3rXzS1mI5jDp0H9dYBhqDm6oUjOOxuDURX4o?=
 =?us-ascii?Q?sLZG0Y0BPfXXB2AvnLuXSYkYhR5j4KvLt7aLANL6qq3Fklbsb/GE4b5KA/uW?=
 =?us-ascii?Q?F1Fr36dWXyEnqMny83o1HgTMFE7N9IaomI4C0tgmXuSXzgeoyso4JsJKC/d4?=
 =?us-ascii?Q?B3+06ZBlLSdDe0Vw2fSKsogsqMnQfNhsk7PTecpsKcSLeIQay/jTmOCMfpq0?=
 =?us-ascii?Q?KAz4Pef35HaZyaWnnf8SqCKFaaj7LjtPMKywSJx0hrIsjnRbMRVuDGjhW6aC?=
 =?us-ascii?Q?vZRvH14jFjRp+jQQ+YKuxBjXtg7MZ5VJhOZoH/25b0DSwM2v1OPs0fb8KPmU?=
 =?us-ascii?Q?T7sYa+VuhaAFcZRQTOluOHcb5Q+CTT8TGTFKHWylTq+cYLT0JHG26e55xluh?=
 =?us-ascii?Q?UhIrRBimuQzsrS+2jFCPXPXC/QAXFrbL10O9kRjUaQOAv1ljKixXJh9Tf54Y?=
 =?us-ascii?Q?lBgAIbM6rQupd5UEARR+Rv3kHRp7NePQiWKLHMHNUQIz0BfOkXxs57l9aMjP?=
 =?us-ascii?Q?KUi0z0kednyGPfYvvuQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d50f9a-bfb0-405f-38ea-08de12368298
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 13:17:26.4541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qi6vOxWOVjA8SWZBgb5IaIL3f7DBp6H4LDa4Bv4C6ifURqp2wPmRjJpcg1M9e2q7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4455

On Tue, Oct 21, 2025 at 01:43:24AM +0000, Suravee Suthikulpanit wrote:
> +static int nested_attach_device(struct iommu_domain *dom, struct device *dev)
> +{
> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
> +	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
> +	int ret = 0;
> +
> +	if (WARN_ON(dom->type != IOMMU_DOMAIN_NESTED))
> +		return -EINVAL;
> +
> +	mutex_lock(&dev_data->mutex);
> +
> +	/* Update device table entry */
> +	set_dte_nested(iommu, dom, dev_data);
> +	amd_iommu_device_flush_dte(dev_data);
> +	amd_iommu_completion_wait(iommu);

The structure is still upside down and it should probably be fixed
rather than duplicate this code (and missing the clone_aliases!)

dev_update_dte() should take in the struct dev_table_entry *:

static void dev_update_dte(struct iommu_dev_data *dev_data,
			   struct dev_table_entry *dte)
{
	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);

	amd_iommu_update_dte256(iommu, dev_data, dte);
	clone_aliases(iommu, dev_data->dev);
	device_flush_dte(dev_data);
	iommu_completion_wait(iommu);
}

And this function should be exported and called instead of open coding
it above.

Rework set_dte_entry() to return new instead of calling
update_dte256().

Jason
