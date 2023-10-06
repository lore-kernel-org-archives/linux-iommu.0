Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7847286A1
	for <iommu@lists.linux.dev>; Fri,  6 Oct 2023 16:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QVVt7ys/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyffBDaj/4Ddw91tOq0l2WyrZ4WTYRPp1FmojyNl++W4dM6P2TZT8TQYNkJ/ZF5ylVLsGfOn7xSNQScrOw9JbkDEKNtVjKdcsYA6afMDK3Jr5a6ohtikJP2yuQCwDmggKimpS47uZ6swuS3tChoYQax50D/C9NGA5F87lItGlZ2sabVcNuR2TahXz6OiZN6HDYNRxIYBd6VuNVz7BT6D8GbjQ74DsmToOTXhefwrnKVpb70oBjXA3dFH/jLYR32e4sjELwyTxPCYtH4HB0QJWB8Cw6l2D4ku6wwtpVG4V8WQ9WWB4/tyilpG/+ySAH1fQVhhL5QCo4iqL1FvgSnWZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Is0IdjwTHAQ/Gk1TPBkghoyIx9d0fp2OZd4ZoNHoY9s=;
 b=IVu6AYMpYOyEcG3iPdxuOX8tj8jfQ+HnXw+Z3NUWOhWmVP2nFWFiTmUgYattBgc1vb6dOFP/Ym8+pO3EqG9l+HPb3JHpqSoIlpo1C/27a2EPSGykm8gtSuTuxEh4WfZ/oSrJDT7O+9tdw1dA/jZ0Ia98t3SAnAOpPyJfg78kEdq4yoBkPyeBlt7aCnW5/LYLVCUjqvDJVKwiHhWydxPDMPAXYORhP6HFBxCexzjHPRk+jeJ6mrWByPa4bI0RuXLe4z4QDYtf36W1u3D6e0UEdwxAXtCerFUDH6+UakGqCK6+45LTnDkeyq0w2urNH6bToNZygRd2dR66cLpQgozE5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Is0IdjwTHAQ/Gk1TPBkghoyIx9d0fp2OZd4ZoNHoY9s=;
 b=QVVt7ys/+UOhk+MUcU5VOMRpJuwepsc5A0Mj7rC8qLqGUMiODRYfhCNVgxC80QA2a7km8bR3akBcfBITjOz2mOten2WUUc9izhTwJV+O9Ma7C14rNPD0KfUKiNgjIPEu8/3SINuZmNdRVy3pfONwKnCodSvKjpBS0CIptqohqr/0CkvhxyNeBazk1TLTKgOECx/vB1GdMxx7gvucXNzIxN3WyMt5UC9TDoBJTnK6gmjTZ5agAK7y+ZvpjyG9fUUTr/9xVGlUh668aSLBF5HIgayDHMJkBAihzpAco8q1ZemcUk9q0J8c7KSQ3zM64+I3u0jaXb1S/poijVXDaG26qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB7009.namprd12.prod.outlook.com (2603:10b6:510:21c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Fri, 6 Oct
 2023 16:23:29 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6838.030; Fri, 6 Oct 2023
 16:23:29 +0000
Date: Fri, 6 Oct 2023 13:23:27 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steven Price <steven.price@arm.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Heiko Stuebner <heiko@sntech.de>, Joerg Roedel <jroedel@suse.de>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>
Subject: Re: [PATCH 4/7] iommu/arm-smmu: Pass arm_smmu_domain to
 arm_smmu_init_domain_context()
Message-ID: <20231006162327.GA1132146@nvidia.com>
References: <4-v1-cf5846854f51+6db3f-smmu_newapi_jgg@nvidia.com>
 <61ef049f-8c40-47ec-b3fd-d17cbe41b96b@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61ef049f-8c40-47ec-b3fd-d17cbe41b96b@arm.com>
X-ClientProxiedBy: BL0PR02CA0133.namprd02.prod.outlook.com
 (2603:10b6:208:35::38) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: 72477e6b-258c-46ec-0040-08dbc688930f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0fFz8DkjqBFFRsGI4RLZHExA9Sw3VtQdxsSV/PYGpHYLGbGgVvsFrNA4fIM8GeETM1vKa9DuSy6aChNVmClHts7MRRk9zrRFHMZ9NwRtkhWnJqecS/0FcKuodV6yGSOyMhHdEJZhq2hiRJm4as9FKlXJBOX03JvtXvmFGjAyAw5U0X2MIQAn9MlwQ2PasoPFeeRDud7UFvbxyMrjnotZiXq5cg6/UP7KVEzOfYjQfM4Mb02kyUn6giT4lJclbZPyQIwdsx4xySQvOHXs24dfzLdV4pHck47E8dbzD3xQydcHHzokTYKc8sanXEx5vIPsFxNSYGj+/PwVcSCvVrfH2lhWUaIFhOIanx7GlwdyUFjOfR4r9PlSY4nNA5g5eD5r3v3/rCNrX5VXwXhaJfKW3gXbNk1O37n7Qg74GfIgQQFgN4F6qGBXGs12aDKC0+6MUpIE3vbNMKMPv98OYeUfDQKkGXGxwXR4WTm3oJYvHF17Rv7q6LIktgiktv7RTlwKvU929VSRGvDpZAbk8/VMYvHPY0jUOsKfZnr2tCCmV2xgRmmA8f4Kp7zzyGK5hJNQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(366004)(396003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(66556008)(316002)(54906003)(66476007)(66946007)(41300700001)(6916009)(2616005)(53546011)(33656002)(36756003)(26005)(1076003)(6506007)(6486002)(38100700002)(83380400001)(478600001)(86362001)(6512007)(7416002)(2906002)(4326008)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y1R3GDP7C2NrExuZeA4UvfgHJJ80E+Uu8rxJgl8a9Lp3MqTADebAPelvA9K+?=
 =?us-ascii?Q?DxCBcufwhSl28ob654J+XfrCzIfY+5GBkDJWNfOx77VWMZAKw6hxROBuvVbH?=
 =?us-ascii?Q?L7I+TWOscblg6RImK4dIr0EvwDwbhzERH+qY5Jz3WA96L3v6CxP+cdrFedm6?=
 =?us-ascii?Q?El0gC+VcpPPIx2wBS4gS7iRfBQOBkuuvkPcbRbFI6h65C2mS9bqV+eGRWsOb?=
 =?us-ascii?Q?NBaQWQvKAiq6Cnsf1oCjgFvy3mOCyb/S9VKY/wQ1XI4Y0IXvcUQP9alP61+4?=
 =?us-ascii?Q?m6Gw98sEKMI29zYSFNo3ExiikghjKQl+Gw7WSMcbZUkFQdkSBWDmitmJp9Hb?=
 =?us-ascii?Q?KamG9USdV3Q+unDquIsQb4wb2MF4GVMH6pUBTEhEdvNTfNGRit4XsBItfKeT?=
 =?us-ascii?Q?uCQJSBc+F/57WfUM4KDrqzrbZIvAHD+jfQjZI4quEtiE/ofQgnLk11auHTQy?=
 =?us-ascii?Q?dquE+buvDcXtzsCVyvnmc+R5EdoyNYLXrfB6mjiQiFSFPez46MWOeacjgbND?=
 =?us-ascii?Q?pCVdFmokQ4EGtb5z8i+4HChWHq6ATkU5T5zwj/pbH46xamlvcMAXAtZHA8Cs?=
 =?us-ascii?Q?Rs4YB6ICBO/ixVm/QuDi9AkHyNF/HCzeTAUog1vDGSousHJhdtkyhsbO89p0?=
 =?us-ascii?Q?dvEwb160uLk0STE4WW0tHx6h6QsatEO0TCpaqkRNgZxAt+yIWaCTvRAhGZk1?=
 =?us-ascii?Q?Peahjhq9upnnF2JLh3vomomAEAY0t0XG3ShMIJAFKe3A7y2mFqk4UKoQJMya?=
 =?us-ascii?Q?CA7/lf+KJwjWSnMlDKVJl6Dm3yAtMK5ATwT+AKUVUG/quIQiamWw2+S4WeeG?=
 =?us-ascii?Q?uarwnzenGOR0aWbR9nSKEHcalo3RUJnPlsj8R81NuZV1OZcyTh5qf/WbiplY?=
 =?us-ascii?Q?oz+NSwMWcDBEC1EqtZZu5dxgcjpl3E4mBWJfP9h4KuwtSawSQJrjXEYXpQfo?=
 =?us-ascii?Q?8Ghh2QT4mHwGX07dYFNgWn/1Jqwd6XWDhNe5TZS/Sp8aYlq42GmcgD5EyVav?=
 =?us-ascii?Q?DtTXgeu6EFDNDgz3/EuqUi4GPw/kwz+vgbr/ks3iEe/vkMTSOYmtSVRAQbN/?=
 =?us-ascii?Q?wtMS9TmpqVCkSevb1cK74sY3A4ltBI99LMGVKJzwjCWMEgTiesYrACjdwZSj?=
 =?us-ascii?Q?/fuSZos4CN1dRzau7KBDIIOL0YIrFp10mzompYlx8Xch6Wxv17mS81z1tq4J?=
 =?us-ascii?Q?dLCteYuiibAlhCYGCMMEDwkbkW5ZmcvZpYV8o4h/YFJH+iv0P1X/GrYFQb71?=
 =?us-ascii?Q?foL/8o45px7Ij5MaCTockZ1Ia6Yjt9+GsI4FNzVeRBVsDxm848HwQwoB5HBz?=
 =?us-ascii?Q?7kh+dejeC+AU+OcsxFTY7Oc3wnYcU0Aj3AAxuiBfg9qrQG5iVCxLmJcExyd/?=
 =?us-ascii?Q?JRNvxIfSZK2DWAoe0ajngzBrj2UQJYUvKwUVQBNM+YAjAQIk7gsResLvTgxw?=
 =?us-ascii?Q?41LGncVtFfWW5FqTlLHebhfVr2WlVicWjrDJAbipCVwvmaNHkLHXiCVrxniQ?=
 =?us-ascii?Q?bfVx4pQ07K26gREPkJIY4+CnOUtJPEDIZTJK9H8ONY3/0cI1fHCnOjKt2kBr?=
 =?us-ascii?Q?KowcQsPq08Dt9BzmJnhl0n9v/VkwQYbke3SMi5ea?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72477e6b-258c-46ec-0040-08dbc688930f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 16:23:28.9792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GZ9lSPo25GxrGmpqP1jxuvolhDhleszdpka+KvI/9to8DxN/2go3GeMIlLnc/Z65
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7009

On Fri, Oct 06, 2023 at 04:11:22PM +0100, Steven Price wrote:
> On 05/10/2023 19:28, Jason Gunthorpe wrote:
> > Instead of putting container_of() casts in the internals, use the proper
> > type in this call chain. This makes it easier to check that the two global
> > static domains are not leaking into call chains they should not.
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > ---
> >  drivers/iommu/arm/arm-smmu/arm-smmu.c | 28 +++++++++++++--------------
> >  1 file changed, 13 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > index 0fc4f2e8bf3ed5..bf5f541be2399f 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > @@ -393,7 +393,7 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
> >  	u32 fsr, fsynr, cbfrsynra;
> >  	unsigned long iova;
> >  	struct iommu_domain *domain = dev;
> > -	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> > +	struct arm_smmu_domain *smmu_domain = dev;
> 
> Leaving aside Robin's objections - this change is clearly bogus. 'dev'
> is now being case to both struct iommu_domain and struct
> arm_smmu_domain. And AFAICT that won't even "happen to work" because the
> struct iommu_domain isn't the first element of struct
> arm_smmu_domain.

Oh I totally missed that! I fixed it like this:

--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -392,7 +392,6 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 {
        u32 fsr, fsynr, cbfrsynra;
        unsigned long iova;
-       struct iommu_domain *domain = dev;
        struct arm_smmu_domain *smmu_domain = dev;
        struct arm_smmu_device *smmu = smmu_domain->smmu;
        int idx = smmu_domain->cfg.cbndx;
@@ -406,7 +405,7 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
        iova = arm_smmu_cb_readq(smmu, idx, ARM_SMMU_CB_FAR);
        cbfrsynra = arm_smmu_gr1_read(smmu, ARM_SMMU_GR1_CBFRSYNRA(idx));
 
-       ret = report_iommu_fault(domain, NULL, iova,
+       ret = report_iommu_fault(&smmu_domain->domain, NULL, iova,
                fsynr & ARM_SMMU_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);

Thanks!
Jason
