Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010058.outbound.protection.outlook.com [40.93.198.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59C03043CF;
	Tue, 13 Oct 2026 12:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791894854; cv=fail; b=Fdn+DrTUSkoui1hD7pUwFGyZRLgk/BbCLsEN5A/dx2fhYiipoMT0gRDAZJqbA+PJl7nDR8L+RJeMsQxhYWBVHaZ9ReoSRpXi6TlY5fl8/7VPsW5BzkPcNyhVrlPbpENG8dCdE40Jv6gXA7xPrWUQpSOIKsLUF/8LDJdHGEbzCPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791894854; c=relaxed/simple;
	bh=f6PdXYxA42HukQxCy0L35Q8ZQd1CC+z5XrW77+NuHHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XCShvNsn1tKOU0aPKAZZ1AlZ0euxISXuzISqRh0oNsoFr+Pifgg4ZuY62eGx7blo5AzUQkjb/fp1sBKPGXH9576sPrGc5uDnyQBnDOHskAe6C/7u2RRlqaM/xpndO7bHx63QoyKAJA042k0ZXmVcgAsvnouPNgz/ii7ENCMFF/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qRrBwVKj; arc=fail smtp.client-ip=40.93.198.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qRrBwVKj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AoyEoT3Ufc4/fBCZK6nMCLr8Daxry4L1x0oJhD7w8GtGBWtGBFaukm3l4J+5MEOuktoDs+/XeTat638WCfUDE0YxcC1jihGdsRRcbbIAEW3fFs28OCCzDgBewf5EAUgTzdONFrF99g5reoIqG0MlksM4jdT9/Wb0SwDaMKw+Sq1NOrxhvdwbw5T5csQUimRdP1+6E/MRvTCI92Jp80Uok4FERh6IP5o+GpzR619PYC8k1b1eXah/gc3KeNNAZQdj1H2Nb3cno2wSz7vzVSh4ezPNrWEX2ONYuweRhtqFj+wixCnqqeW1DmA1R/e7FF66URaZKHKy8K0a5p8AhRCSeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1ISaJRBGux7dCiPX/pe5gquu6HvwI8hzN1v3JjFgwc=;
 b=NnPNosXdnYdVPlPuNKXUb+/tsgH+DIKoIgJmeXG0gD/m9t2rzEElkvZ2j0uMAm/PaMWet3cHNPLpfW1MqdeL6aQ7acFBJo9d7mklD+g4OmrVjgpIxPXzehgG45e6UjFjXiAlO49b08NX7F6dDbJoajOGtAO+nRi8fjB1RmCgsZ7XWHMhm6Ly8WRChJz8Citfq4Jf3Rh0MBSvqjpGAbTatYr/VhCRkiQsyrwQ5/RxJ2pYHNdsaBn0ZoF4ydyyLc0qG0rgK9564hF/XgFUP6XsSdOOWeEEdW4pICW6qU4hWbGNmBuf78GqrT63MV2OxQbHfXQSD25reM9yfOSzg6OaAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1ISaJRBGux7dCiPX/pe5gquu6HvwI8hzN1v3JjFgwc=;
 b=qRrBwVKjrEqnd6m3jEacxkrfmM9FsTvsJeq62d6//jGg/wpvtpyXYB9KII8sTQJDrSeobwCb5pXORyfe1oPz0ENx3efpFlMuIKLmRrkQX2EMG8egHKRhKVTksRkXLQAny0X10FtEENkrVRLsr3G3IkjzZTg7YH0bfCMw6sO30cPHQMPENnS7A7MGg9HXFdf37eFcxYPT+ptkaOLhdW2sfUyvhVGwkPsBWSjoXOwADKBY/KjoL6wZPQniJ4sGB9c2djhs+DUW9S8dkFy5eOqkIZi/ucCbTF/s1HHrkuWIHIrzbg4q+zAJA+VGJ/aZ/0ZNTuqKRGaFaujxj90rP2LgOQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by DS2PR12MB9590.namprd12.prod.outlook.com
 (2603:10b6:8:279::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 12:34:00 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 12:34:00 +0000
Date: Tue, 13 Oct 2026 09:33:59 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 13/16] iommufd/viommu: Select vIOMMU operations before
 allocation
Message-ID: <20261013123359.GS13920@nvidia.com>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-14-aneesh.kumar@kernel.org>
 <sashiko-outbox-163690@kernel.org>
 <yq5azewj45u2.fsf@kernel.org>
 <20261012130516.GL13920@nvidia.com>
 <yq5aik36q819.fsf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5aik36q819.fsf@kernel.org>
X-ClientProxiedBy: YT3PR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::32) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|DS2PR12MB9590:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ab4b06c-7a65-4e70-93f0-08df29264238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|10067099003|261009223027099003|5023799004|4143699003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	kaPs30jX5MmzzhTlZAr+99EUdW6abK36dBYr69H1DmCIOqQNZDK+3al9CgzBkVRTokRMLP2abek4+oWHMb2PajwWDjQ9z35Q4nIYRnoUFo08HQIstY54MAm6a4dhcrjyxt4ZRKoxme6wW4ZznqZaQLBvvzdZa8r6WafyS25g+Ei3ciNMID0PVKAGMaGSJkYszH9ne+oSfNvpaq5erurR4Y9zbQr8zbW1Oz3VG7b5MmPca4/PLD4nBikfciqbx5RzGQDusoWNK97QC4qfXo33QmiZhCvfg9jlVDDXf+Kl+lqW5cbprLl+sdkk5zjNRhjpT5wW2sxEpWPND5Mn0XiHQJ5OwIpisA2lWRRodzuXSC6WWgKgjfORPPeCyFcjayen1BeuZ6SlKbbfYYflmDp0HW4Ws5NSq1MZ1TXPzGitaTP4M1WpJamd8NhMdvKJUC0l7RSO+jGsecVpbXG6PkIrm8W7e7mWkAO32SOovDwczWKPYx8LPurtahOzLADiI9dOCH7G5VKWJfI236eZUURTnnuiOowLAk8AqOa4Md/+0HXG1UUAYKdZNLQgSuF97veisQrH0sS9bL30rU59oExWKACH0N33A6YmwljvFBh+5SHfvgzHHuZjRwcPfOVfA7rOyIq5tVb+4MxbZYN5BC43e7Wo1vbdQqcVJZs+VQu6r7A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(261009223027099003)(5023799004)(4143699003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7POvJBVJikdD+yrYbvGj5ooyu1Ro0LFBCShN+HnyO70mzDv9Q1ILPLasta08?=
 =?us-ascii?Q?yzruiRoSt4qDf0275o+LH0WxTKSPK0uQsOhqeJS39lbmMOWbdas3RRXPIooY?=
 =?us-ascii?Q?ZWXXCKDeVp9tu8kaZnD1MUsrUVkbNHAfCwgNxl4fr99KGUO5LmKYLTmuPmHu?=
 =?us-ascii?Q?qo1ZAnBS9749JGA2UDviezdhP4hnQ/MviCR3XW48oa1HQuNiW33uqLW1jeaf?=
 =?us-ascii?Q?W7F4UelpTJ+IB3d6JBG9bvEEAvsRZOCvZq1sKGS4ylcPOW83V3OUdp91ENmw?=
 =?us-ascii?Q?eLpjjPo+SQhWFk6SoSMacNCw3OGVbCTqFlFaJ/Ahx0xxr7q8lfmSkfSE7JRw?=
 =?us-ascii?Q?Ql/QC+wWBjD7CUmsXy7FjnzEq27722QWbblFDMmsoK9QsM8QV5rHSeocSw43?=
 =?us-ascii?Q?RxqpozzRvXHciCo4ILuPFND0T37GniZdnxiVcgYTM+ne8oMaYLHrqgQ9Fgbm?=
 =?us-ascii?Q?AzVrT50WCug1Hsq9c4vyC4jHkQnyKRUDcBtGf2VsMsj7Pt2Kp5seHz5Evy03?=
 =?us-ascii?Q?VwZRmB+qLQ3oJA+ri2F2Gv31kxeUh0kIBhR/+E53Pd57m3tRv47Am9fhTobH?=
 =?us-ascii?Q?4FWcJ7K/xrfIZX4d2JXCV42dwhzjginZDvaC4U0QVbAqSXfBZ9tJjZKIUJBD?=
 =?us-ascii?Q?YOjq2uoV6DLC7GildhbvhlAgEHpcDQaK6IDMzxBrZBX+cSEm3gGCeX/2ukcd?=
 =?us-ascii?Q?0gMuqZWTm6ffmyqndhEfqg7jmDLlP0lz5PaikruhcpSKtjjquZ0YTgIsKRL7?=
 =?us-ascii?Q?eWpky6cBRW96QDSBY2UKP2cmm+X4ZMb9Y9eDz5/LeFEFen84F+igbXmXEJrf?=
 =?us-ascii?Q?4c1ZcMFpYjckoGsMNvrv45at2A2jPOobSX4gMNPN01Yj1l8+llew6EVq/18F?=
 =?us-ascii?Q?CF2POgdPuIXQ1xaZLPeCRoKa/AUNhNkr/E+krbe6e7kWP03rZW2EfqBYdxFY?=
 =?us-ascii?Q?KZearv7RXtjve1B+rxLnucva4sXwi3vtPE0WMIvXWO40+amLEYZetXh3VH4W?=
 =?us-ascii?Q?zWPIiMl+Fw99BIRqSqlQICW3RHkU+5/mlho8fwoir6TzWNpgKFRVyge6QY0s?=
 =?us-ascii?Q?5QI0EP/6vUYhSZXhjysTFRRdRTP78k9fuK7yEeg8P4nayXnfxi6mJ4MXO0YU?=
 =?us-ascii?Q?mxTCFGG5hxbkEmJtrWkBjena8AtyJcaXFN+ml6AFLBuoIQEMELhNA5nWi8ts?=
 =?us-ascii?Q?+3B7VnYqTZdOVf+jexDKjXhGTv/XUlulBS4VSEfiGiJuaV22sHHEDLGLPz5v?=
 =?us-ascii?Q?kjZC0pezbFpDxV/FWjzg2aps4lZnqQgKsAoyNQmCIOinTKB622khjq/v/yan?=
 =?us-ascii?Q?mdF0IbElzqfKfaZZRORNXhrMcOhAXRFMfCvtnODC2JaQzjAQmkwirsFMYuoe?=
 =?us-ascii?Q?Um5K4LqswVS25lDTmABlxeTh/wlSZzwa/TsXFwFqbPJ9Ra+J7hHwOIcGWFnP?=
 =?us-ascii?Q?yicvgPEBQmQxozlRc6Plf2EPNiL9Cxc1F70Q/h1NSsKs3AW7SyAI1cAgxIFZ?=
 =?us-ascii?Q?izB/2k80JI6f7fndDqdQ1+IhvG4R2/WUM6keXSHJFchH/glTGr2bcttHM1hF?=
 =?us-ascii?Q?286PoiGkdLzH3BCtAviwaB1i/RaNs3onP2c25RYfCv2YsS1E+BwujWj856fu?=
 =?us-ascii?Q?CuhRmj1GiBTQe/g2FnOj89lzcX9QXeSS4ENht48cfgPjotMGjYR9N635f3Q7?=
 =?us-ascii?Q?MoIdqMcAOpcUxUYvJbyVZ98ByZbRGUaV4zl6CiwkDNyEoHCh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab4b06c-7a65-4e70-93f0-08df29264238
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 12:34:00.7343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AN0HfvSz7n0U8edc/gU1MH8dFVyLcK+aFevitSGOH87BLT6ppf7kLhfbql/9PNjq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9590

On Tue, Oct 13, 2026 at 02:41:46PM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@nvidia.com> writes:
> 
> > On Mon, Oct 12, 2026 at 03:07:57PM +0530, Aneesh Kumar K.V wrote:
> >> > Currently, amd_iommufd_get_viommu_ops() unconditionally returns the ops
> >> > structure without checking the type argument. If a user requests an arbitrary
> >> > type like IOMMU_VIOMMU_TYPE_ARM_SMMUV3 on an AMD device, the core iommufd
> >> > framework might track the vIOMMU under a mismatched architectural type
> >> > identifier.
> >> >
> >> > The ARM and selftest backends appear to validate this argument against their
> >> > supported hardware types before returning the operations.
> >> >
> >> 
> >> No vIOMMU type has been added for any IOMMU other than Arm. The
> >> documentation also considers IOMMU_VIOMMU_TYPE_DEFAULT reserved.
> >
> > This is a bug in the AMD driver we need to fix, send a patch? It
> > should only accept DEFAULT, not every type.
> >
> 
> But the comment says "Reserved"
> 
>  * @IOMMU_VIOMMU_TYPE_DEFAULT: Reserved for future use
> 
> What is unclear is what using that type on Arm means. Does it imply
> IOMMU_VIOMMU_TYPE_ARM_SMMUV3?.

It fails

Probably thats the better answer, AMD should just always fail until
they get their type added.
> >> >> diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
> >> >> index f3d5b5a7eb4a4..e95138ae71d5b 100644
> >> >> --- a/drivers/iommu/iommufd/viommu.c
> >> >> +++ b/drivers/iommu/iommufd/viommu.c
> >> > [ ... ]
> >> >> @@ -103,16 +105,12 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
> >> >>  	 */
> >> >>  	viommu->iommu_dev = iommu_dev;
> >> >>  
> >> >> -	rc = ops->viommu_init(viommu, hwpt_paging->common.domain,
> >> >> +	rc = ops->viommu_init(viommu, idev->dev,
> >> >> +			      hwpt_paging->common.domain,
> >> >>  			      user_data.len ? &user_data : NULL);
> >> >
> >> > [Severity: Critical]
> >> > Is there a missing check to ensure the domain is owned by the same driver
> >> > before passing it to viommu_init?
> >> 
> >> The viommu_init callback needs to perform this check. For example, the
> >> Arm implementation does:
> >
> > No, the check is missing. If a domain is being used then the core code
> > needs to check it, not the driver.
> >
> > When the ops is first obtained it should be checked along with the
> > domain to be sure it is compatible.
> >
> > The NULL parent domain on the TSM path should be enforced in the core
> > code since there is nothing to check there.
> >
> 
> So, if IOMMUFD_VIOMMU_NO_HWPT is not set, the HWPT must have been
> created with IOMMU_HWPT_ALLOC_NEST_PARENT, and its domain owner must
> match iommu_dev->ops?

And the tsm flow must have IOMMUFD_VIOMMU_NO_HWPT

> Something like:
> 
> 	idev = iommufd_get_device(ucmd, cmd->dev_id);
> 	iommu_dev = iommufd_device_get_iommu_dev(idev);
> 
> 	if (ops->flags & IOMMUFD_VIOMMU_NO_HWPT) {
> 		if (cmd->hwpt_id) {
> 			rc = -EINVAL;
> 			goto out_put_idev;
> 		}
> 	} else {
> 		hwpt_paging = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
> 		if (IS_ERR(hwpt_paging)) {
> 			rc = PTR_ERR(hwpt_paging);
> 			goto out_put_idev;
> 		}
> 		if (!hwpt_paging->nest_parent || !iommu_dev ||
> 		    hwpt_paging->common.domain->owner != iommu_dev->ops) {
> 			rc = -EINVAL;
> 			goto out_put_hwpt;

This only works if the ops came from a real iommu driver.

Jason
