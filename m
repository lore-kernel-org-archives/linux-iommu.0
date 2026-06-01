Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010050.outbound.protection.outlook.com [52.101.46.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F3A372B50
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 13:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780319314; cv=fail; b=ncTLe95+hmrbNvEH8EEpnf3g/Jbz7Bb2X6nUDabeXlmV+uJ7HvHjhyd5ius1YJISrrPaJEJYrz5cvM2a+IL5Zzec5TsWmAk6HsRnIzzZXeEyfOb/i9r92m3LMcaAfazXvwf59MEsTJ0V7Zh85VzwB9+HWQlKiR9htPMp/qmcxyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780319314; c=relaxed/simple;
	bh=v96pYINlug62KOQ37JFqQuBnTYiSYD0z+6Cir38Nqa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FmJha6zfnu6a95HXLPRsKXHxp+Tls2MJctbvmZ91B4r+RvlmqkV1r+4C3DEXiPJNAtPdSq17POaPJ3DAgrCj59GMHaWf7CnPjGxannnZM76Kirls8b8idpB0vK7hg4yeoaO0HQXfmIotFo90FfXB4h3KP267h9Gs6TtJIewgYfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qak5zNSf; arc=fail smtp.client-ip=52.101.46.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qak5zNSf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VSbGqHPZECFOEAXr7tTcfRnanlv1g0Xj5AmknYFHiWFxQbFHZzxtZiyYZA7zj0qa/w1hJrVp4/Xq/T7eRlqBhpSEyBbY5OeKGrAdxU2V5TnSQRhjHmvxe+djWczHoJUb8OCXRVmBP6tuEZ9qL+s5/Q7CS3Ab/1K7UZjNqbMMl1CW0xQ8x7me+Fs8dsr+KiCL1AAU+DUqaH2WF69IKXdB7+Np8uvmnSDM4HkY8EX3kTkO+eeD8/ZMvY3O7eR4aqZ7aJ6BCrjYiKFTQgCymnfxkIzvbqFfIRhQwHZT08ci/ba5KMsD/HaUjTKEMjmrnT5hQojhHH1IpoMTgiXb914glQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzHAGWZGRt+Rf7QCjgc5RyGEM9aCqEnZm5xZAlE2UZA=;
 b=qe3MDLtdjdDz+5kywg4LH7fCjGKGRI40L9Fq+FQIBsuAtGFLwMRlMHZe4KHT+i0h/rdo2NXogqx+63StXQOPIyOtemRJLNPeM3X8+McgyeduKfETUAUYDhNJEHTqJ1uxiwIjigE6yUzMg1aNVFlM92SEXBXlaPpVwFSDQvpZm3exPkreSKClPSIAoMVd5/nPK4BSYCjDrC+UQl/DVXk7OjtFFtj/oUIW5E7B1ARMRYmYrF7eLNZoh6/2gU9awccgYyyGDzXAdTGH8vlB3GHW+NZea114PXd+2mHuriWTFrKCwQzDZrNilMdYmS0o9yo1mehRtY717qtaXqHzFz3Esg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzHAGWZGRt+Rf7QCjgc5RyGEM9aCqEnZm5xZAlE2UZA=;
 b=qak5zNSfVjf0GYhRzG7aO9g8ufvAA3Pube5fFPIZIvwpt95WhEuqWJuCu2tARQ4YxIFY8OanfVMJIWAAURRT/5eO7RNu2zbbFWB4ZIU3GfF4aDNpq8vTjXVhiYOcK0CjcugvQJ0uVkUuGKEM6wApRXf7iQS0msVYxaBGK9/qFDn9r3sbDNhLXRCI3gE9CYaLX8XqDy2tUQPoBCzYO7LQ+fpCEXRSeFollJp4kdRMhoEiO+aPjLL1TZ+8tlmktEikQewj2HzgNZeCz5ZvEynV4btfUrxkJ2DTLMSl66sQPKuvRMx1JvmWAOpfbpgCQgtCskCyUQD0G+MC2qvVhTeDqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB5723.namprd12.prod.outlook.com (2603:10b6:8:5e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.16; Mon, 1 Jun 2026 13:08:26 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 13:08:26 +0000
Date: Mon, 1 Jun 2026 10:08:24 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
	sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
	wnliu@google.com, dantuluris@google.com, chriscli@google.com,
	kpsingh@google.com
Subject: Re: [PATCH v2 12/26] iommu/amd: Add per-VM private IPA alloc/map
 helpers
Message-ID: <20260601130824.GM3195266@nvidia.com>
References: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
 <20260528051738.596013-13-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528051738.596013-13-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: YT4P288CA0009.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB5723:EE_
X-MS-Office365-Filtering-Correlation-Id: 506f0852-ba4e-4a37-afab-08debfdeddf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	vUsnaP0i+sDeaiGP20fViVhIgIGdukMctnQWUJ4uWZSEvDrSo4PPxfQFCVHorSuEIajO9INhBg5PB/omz4ZNI67myaDV7G9c8x7W6J5wNwHozpsNTfhx/JJCKRN+IMDr9I2mQoFMIg6L7fuQ+O4ffNdMMYzX16ubFg71Ry+ByFTdV/AusrMt6hy5qXOOiedpzS0lZdq7mgECtnd+UokAL63fnwObP9qbGgwWXRqhs0fMaGzco4OdpJywPVXh9R1b49ZUaGhC///NvTguy5F5IcQkSwMitSgtRitr9zUcRI69mtO5atZF2j1+P6XnYlFNcSs5yaD2TSwAOPe2X6AMO49m2rjE+utyNwJF3rR1Vom/HCauH9qTNIqF4KvHsRIw1wiw/9EcppRkI/zpT8aOzTGDz3IyyL7oVaA8lqIiq3Z+TQHuqfXsoOLg5fh02Pb3XJOSbb+lGaT6fqWWnClhQr/5pvvcz1O5VcKqecUnkp4xxKrdfmKchx4TWmMSkpNJJmijVAA8It3ynHNggVoBR3wY8Fh0sJHuIrmZmQMlKf4PYnFTHmBtjoU8tzFgsrGm+3hFA9XyNCnbKwczb8QIpGwr1MKe/ldI81qJIatL8nLOG2pMPfgevMfN/cLrfmJaKL7cET0l1RQwfMMI1+mMzUaxzISSsOwgHLI1zLSA0Og5XUBo4wcYb9w1KQLpv3k2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JuqfAxtx265/fg5rx7asGRQRkyPuH3Auw/vMrL9zQ72peXk0V4xY9S5Tq5cN?=
 =?us-ascii?Q?xQ1GQcdMZ/aTO6YkdbYItIRMF+2Sn0tbuL++rgNrF/1NqZvatBCEjTDerz7y?=
 =?us-ascii?Q?m95jbzAsDEPKaU8InrxjfEYMdbzPM+ZV2I76OFpzCM99Q0uErDC/8M1WFksC?=
 =?us-ascii?Q?PKWWwQCzBt1W6aVEcPRKMEvHNxxpes1cMxvalBFkxlgpJqhdHYyy1Hocsfmk?=
 =?us-ascii?Q?fTfLsXcbItaK2/un0vDM15kOW6dbWUVqrUGSPknf7FXgjsK4GqvKE+qsSo9v?=
 =?us-ascii?Q?8QQPfvglMZr33Py3p49yTs81BVHyqlnPd2MgXrua1KAJjsJDG9se7DMuCguj?=
 =?us-ascii?Q?p7bXVgVouuRHh8ilEN7dawzVyTxtl8CXabOYAmSDMlCY3f11mQpq+GowERfh?=
 =?us-ascii?Q?AWhZE65vyNCssIfRCKRt02e8+sU5URVj4X8cbfv/FtcO2XMRhGO5sV4L45ag?=
 =?us-ascii?Q?E56m9ZYBBC4xw+KWHHmswY7aBWHYwuEFNnIDLkdNAlDxmIay4Ne+82yzaa8k?=
 =?us-ascii?Q?PTnWazr+CFl5Qm5IfmUi44YOxAfOc6fy4i0ficsNQ2gLZGhVerhBtIsjDknT?=
 =?us-ascii?Q?v/+MGxGjUsmrdRb4snNeFGrOaTp6fCDdPK1GtavY/uByTGT0aWAP6Y19Xg2E?=
 =?us-ascii?Q?nvI5wVDPW1noIgB116ICEukhDdeGv7pFNbrmcUVUGhiGsJhELVsokE3Iqhx9?=
 =?us-ascii?Q?5NzXhX0FmncLs7LAr4fnjNSJGWj5AJ7/RMt4h7dD6QPd7Qud+Q0KM2ICu8BJ?=
 =?us-ascii?Q?38U1VUwwTHZqNcLxLkgsEwB9QGXs+CukqR3xOjc6jnXcAWNiGYB8W7XnkEcP?=
 =?us-ascii?Q?REIbPqBWSBVKMFOTX8X60d1O7cmBVPVccJKeAok0+qV77jCIhshPC65C4yBd?=
 =?us-ascii?Q?8IUyWA6baIwC24JqoGpndCSeps8RO2GVkVo5XkpFfK4qrPNPE+sPnC/GT61r?=
 =?us-ascii?Q?DD3SM1JXcxxlnBr5h1Lyfl/7lfa9eVDO5vtVZAO5j2h7R8USkyTAGqppRgF+?=
 =?us-ascii?Q?8LpRVUKfrv9MSAsji1LoC1mgAp39gq8JqDTNhoVKOKx9FjSXjXnSZSs9E+z5?=
 =?us-ascii?Q?9YveK94P04IEhlVFBgComRrvRX0ogMe+Nx30JPIqTPqU4Qq3rQo7ACabLQ9i?=
 =?us-ascii?Q?LsxyhoRtmdU9QGNeDmEXWs7JBoNrxheDhUjKgakSLeZLmTSuj3l7VEuOhKI1?=
 =?us-ascii?Q?1GjgLl/5v+DvbMdn1RKnkTc69u1IgasKyl5y/6mP2o04Hn99Gxo/id5agTJd?=
 =?us-ascii?Q?BQZogNVyvt1FHBasCod2gQgjnU81uJImAe/RuaKJSvUp0oXHK0GnL3YhGLPm?=
 =?us-ascii?Q?CIQwxyiJn11wZNY0j10y7ITkojjCRf609YXG+7swoVbRTbqG0TZlc/meAvFg?=
 =?us-ascii?Q?YQnStfIYx5yYeo1OOkrDPtcb9lMU8wpuJqVSrh3XDgZprFC7vbGjVKogQoef?=
 =?us-ascii?Q?5yuKesLhEwpqsrpG3Q5UlsOYzGQ+fT6G7TDT2XXURfbF5pjc1skkIZ+unZy/?=
 =?us-ascii?Q?Rz9vJE1KeC2WUNqaHeZeyUtJggDjbSxyBj56qQIwiZFk91W7VICmuSKF6j62?=
 =?us-ascii?Q?SyP1Lj22xflErAWs0tOBxoBjOpi7/0mlYPC263y/dKZLLZGMcwIdHxiKgPo8?=
 =?us-ascii?Q?tinqvz0O1QDQzR0NXCBiiL60PMthTAvS4x+bTg8NzeRI1UC3rZLEWre9RfNS?=
 =?us-ascii?Q?KH0HvQpbImGnJKwnBJhagkXGpvvtQAw5EWgH0XUmSlIHr3iI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 506f0852-ba4e-4a37-afab-08debfdeddf2
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 13:08:26.3579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /P6xL4x8RqdXpIcpLBpBbZ0cUQFkY4FAQXtPJYgncM2mYhVz6HLeULc/JiXUXiLE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5723

On Thu, May 28, 2026 at 05:17:24AM +0000, Suravee Suthikulpanit wrote:
> +static int __maybe_unused alloc_private_vm_region(struct amd_iommu *iommu, u64 **entry,
> +						 u64 base, size_t size, u16 gid)
> +{
> +	int ret;
> +	u64 addr = base + (gid * size);
> +	int nid = iommu && iommu->dev ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
> +
> +	*entry = (void *)iommu_alloc_pages_node_sz(nid, GFP_KERNEL | __GFP_ZERO, size);
> +	if (!*entry)
> +		return -ENOMEM;

No cast

> +	ret = set_memory_uc((unsigned long)*entry, size >> PAGE_SHIFT);
> +	if (ret)
> +		goto err_out;
> +
> +	pr_debug("%s: entry=%#llx(%#llx), addr=%#llx, size=%#lx\n", __func__,
> +		 (unsigned long  long)*entry, iommu_virt_to_phys(*entry), addr, size);
> +
> +	ret = iommu_map(&iommu->viommu_pdom->domain, addr,
> +			iommu_virt_to_phys(*entry), size,
> +			IOMMU_PROT_IR | IOMMU_PROT_IW, GFP_KERNEL);
> +	if (ret)
> +		goto cleanup_mem_attr;
> +
> +	return amd_iommu_flush_private_vm_region(iommu, iommu->viommu_pdom, addr, size);
> +cleanup_mem_attr:
> +	set_memory_wb((unsigned long)*entry, size >> PAGE_SHIFT);
> +err_out:
> +	iommu_free_pages(*entry);
> +	*entry = NULL;
> +	return ret;
> +}

This all seems duplicated from the prior patch, you should try to make
one helper that does this alloc and map sequence.

> +static void __maybe_unused free_private_vm_region(struct amd_iommu *iommu, u64 **entry,
> +						  u64 base, size_t size, u16 gid)
> +{
> +	size_t unmapped;
> +	u64 addr = base + (gid * size);
> +
> +	pr_debug("%s: entry=%#llx(%#llx), base=%#llx, addr=%#llx, size=%#lx\n",
> +		 __func__, (unsigned long  long)*entry,
> +		 iommu_virt_to_phys(*entry), base, addr, size);
> +
> +	if (!iommu || !iommu->viommu_pdom)
> +		return;
> +
> +	unmapped = iommu_unmap(&iommu->viommu_pdom->domain, addr, size);
> +	if (unmapped != size)
> +		pr_warn("%s: unmapped %#zx of %#lx at %#llx\n", __func__, unmapped, size, addr);

No flush? Or does the gather work for the special domain?

Jason
