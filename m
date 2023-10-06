Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E39B1D551
	for <iommu@lists.linux.dev>; Fri,  6 Oct 2023 12:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fxF+Guq9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hiyL5e63eb3/YxeFsF8FrDL37qthdRYgU1VJb2PFUPr73zcYxkTaEEoJr8UdsVQ77d+pTbl3sejRx2CdqILXY8QksmNJqbbfpqFGc7t23RU4hV9qTZBf7vlMy2WF5z0rYscOAF3KBWMbZwDHanNrEDIetZczzkT5BJIiMO/q6xRaPylqWW+2k990UuLOQ4upnAsJf5QUwmsTaweE+9Y/Y0G/KsKkr+wygjhS63WzIEB2cISKKWUla75Ox51lNZXCUeQwfs9FyP/fbNe0Lq8WPixDPdnfmbLVo66ogBH+luZs16WvwL6s8g19RqtMDMHM7zu7Bqb5NL2DQc7MZtkqsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5op2lIhCRPUQ2+t189F1aaGpZivaZb9oBYsb0KiBX0k=;
 b=MvUbn4q0oQ1DHqbkRwIF4KgNby2tWHOzVNkZ6QJIvwrG66FY0AG+bQWOARoIiYC5/WdGRhYVWiwo/DvqoVAjfDtSUpgYURmJCtDI9SDmdYuYVF/W60fHdl9rFT94uEoMR85l3Xrx9D8avhsxaYn/Tfljvs1ZaLPkeRoewG0kAboMG5XLC89Ea0OgntNXqn9iKw/2XXlbEnfJfCN5SpZVVHGgDRw0HWHWdKK+j3q9EOnxasFZUXOOeH57S+tXqsQqA1zE0tyAyhVaxA+1LR/F57Qf7IFOMJZd8Cw5vW/WeaHZFSTQgyM6Ny5M7WZj+KG8T5J+P/BmhpZr0Kjf9XVaoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5op2lIhCRPUQ2+t189F1aaGpZivaZb9oBYsb0KiBX0k=;
 b=fxF+Guq98kzo/KHlY59DcL9Q2qJIOz6ZFWzLLjR9rxC2Op2fE2IeWo6HgOWLdJ49kZPCTo3feCy+6sZs0nDZrp1ZFEw1O0KVT6BmQseye0QvcaBE7kNJpz31nZFsOH1AZWk+R+leiizLXZE9XvhqfCM3h7ZgnrtiRl91yElP9Mq3HvCsJfMrsg1/LnvLxB+sM79tCploRYpDDl3zk3tYuKyEpKSS0Btd/rk0ADZa+AlVrJtQKqgdvc75Wvrg9yybekEpI3YsxoKUkkZS5lRP2gmHn1AAdTG/PIpvPiWdhdXp4MKbVOQK76q6MiYzW2XJ0QzlI6Q/caSt/rT81zujaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB6888.namprd12.prod.outlook.com (2603:10b6:806:260::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Fri, 6 Oct
 2023 12:30:02 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6838.030; Fri, 6 Oct 2023
 12:30:02 +0000
Date: Fri, 6 Oct 2023 09:30:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Heiko Stuebner <heiko@sntech.de>, Joerg Roedel <jroedel@suse.de>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Steven Price <steven.price@arm.com>
Subject: Re: [PATCH 1/7] iommu/arm-smmu: Reorganize
 arm_smmu_domain_add_master()
Message-ID: <20231006123001.GO682044@nvidia.com>
References: <1-v1-cf5846854f51+6db3f-smmu_newapi_jgg@nvidia.com>
 <a75f54d3-cd16-499d-b6d2-eed38153b0e2@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a75f54d3-cd16-499d-b6d2-eed38153b0e2@arm.com>
X-ClientProxiedBy: MN2PR01CA0051.prod.exchangelabs.com (2603:10b6:208:23f::20)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB6888:EE_
X-MS-Office365-Filtering-Correlation-Id: a4731038-583a-4b94-9b8f-08dbc667f6a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9Sq2g2baCVmam1IFO0wru6gifmvKoLrh2BLoWH+mwIqII/rQNbtS6hIfKFecqFNuSraao8to5+g6CAx+sPTYQcjrOrTHCw+WnxBW62UBm6qzsLEUOJKCiJvM8k1zTxWB1GJ92voU37QGaJrla42sdGAVsUCPh4iQjMukkxBZYqSEl54PZcAcCsfDWh8K2kacn/719EYOTOP5jLm2GutxuVWbSmAUBGC9Xb3KS1gVy80J+QAydd1NCA6nScxyCxkcFsgFWdnDzOJ4v3a4JLCcmhmJsl3aUcAR7pwLCBP+UsvJquDWqyHMivH66RUx0qxZhbV+kExF2P9s+UPM+fdRYulwvV9mdr8RIZrr/BGTa1GmU9hMEvkYYVft/njyZi7WCb/Iqv6Vfz4dXmvFsue22DsEkL6AvIsudAGzoJIph6+wCIwmWH87mpbDYjQjYOC00dVDCMIC583FPV9qapOFwXGeAuhpdNniYKUGCFGFQohgQTBaDWNJf78D1/lgEBJT53HoAxaBJucX5P6aKPvZC9Y+PJSbvDhWekHQuB9skv4plYGO9a7ucAFoutNkgQK0wAX8jEiPa+s95ocot6rp41hTd5yUYxWUMkXFX3HF3/a5Wk6xE+lKQWibPSVl2T6X
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(38100700002)(86362001)(33656002)(36756003)(53546011)(6512007)(2906002)(5660300002)(7416002)(8936002)(8676002)(4326008)(6506007)(6486002)(41300700001)(478600001)(83380400001)(2616005)(1076003)(316002)(6916009)(66946007)(66556008)(66476007)(54906003)(26005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2AZwjBBE4xFdfekg/XWCi1ZxKGmjMOPdY1PFqBQDQqUp2kPDdA5YUAKbOgpO?=
 =?us-ascii?Q?yauiqsuTn/fRbXBmwNH1NvuWhZmbgtIW8vv5TdkdclK+nRMLxXV9vzEH3089?=
 =?us-ascii?Q?+LdJTC3PGCOv4QMW2C9cefPVcNsdKk4hqfgSKl4WM7Nz903sOOl86nCTWASh?=
 =?us-ascii?Q?nwQ10Ju78iOsQu1PIXU5guyq7tvcYn1QzGKvCkteWaDTHfmWiEsEtStWRONi?=
 =?us-ascii?Q?DgDZcLJhFjKs5t+QNVWg2eKhNowZMGeMtwqKvGtnpGz8pvhthoEBHRtpnPT8?=
 =?us-ascii?Q?7Nx6TXeLu0pgQbbXoEogkhy3O5dcV+pVNZIMHJh13xa+RiOQPoI5RDGH76OD?=
 =?us-ascii?Q?KKHSURMwuZCcPY2D65rp0pyH6SD8kcH++Do+me279nV6jla9NYZq8Tj+5KZ3?=
 =?us-ascii?Q?zjBNtif+4tVEyzThKswNoz7td451yXtCG8+H+tOn4AIlYlAIDKXm7GIC0EKx?=
 =?us-ascii?Q?9hXVKqR27/wuaboBrvLXV5igYEHlX/bFvZ2k0D2/ckmguLoNpopvVS2ljD+S?=
 =?us-ascii?Q?QHFRQtbLJv9Z7LNnZgBu15GL8VN/lPXq596hDg+01zBDYp9ipqvuzpzhqvvE?=
 =?us-ascii?Q?ViMXoZ0xeY3yORDoxXmqssf2OYvPTLMgZLx/I0T0te2Yfv36OxCRZXTktDnR?=
 =?us-ascii?Q?rJatmj10tWSeBW/kfheiKST3D21RVr//lFD7ZDBmmfy1+pysdjO9dvWyaa+a?=
 =?us-ascii?Q?3O+9p7Yr0L0UFvxDQrC1zH3V7k2/Zj/2QIRU+YSiIFzx1LcDezy7WYcqKnGT?=
 =?us-ascii?Q?GwtZNbHENy8Uw9Aejbq1Kxq2RowgMY+IVScNhKwVwnZhcyuqj/nhaglDYuF9?=
 =?us-ascii?Q?2cU12hD/t0Y4MfHQPjmSFLBbpfnF/7wzdlo5sIcs0GOgYuy3QCV9qR2mdBGH?=
 =?us-ascii?Q?d9uW4EptTTueoxDmt/yhE6m2FQ8x1OpjJkh3EcgU0uNNqJOOdc7qGbP91Kql?=
 =?us-ascii?Q?Fp1SaVXsYSO16RJCUWCO2fNgXwDc1G2cjpfooivGwm240KVqO5EunVrBEVdi?=
 =?us-ascii?Q?79g1B2zn8J19xMEoV1qGWBGpnfIql+5vwTi2mnKzP0s73pxv9+Z5g6IqAtDb?=
 =?us-ascii?Q?emnp3gzvTcxQGt+gJ3z9Tcd1YyW8Sy7yJ+Vj41pINiwZYyW1mzq/gUVcz3+z?=
 =?us-ascii?Q?2ehAheITUgdffPDDWZ1dX8U9NX80M5ssUS+2uT4h7C7q/C/FD1J3Td7VXzjZ?=
 =?us-ascii?Q?R9pQeit+kLCEAQxyNVLEKUYx8D8HXTogEqDLfie4AZ+O3CeQIGIgOyw38wW5?=
 =?us-ascii?Q?WkEhlmzbSPgEwbd3XbUH01vcYc9aZHMBuj+Oey396+fcscKKFY5W+Xp4qrek?=
 =?us-ascii?Q?361fu9Y4kKnBeUq/GMaKda9Yr+cbneLPH7nVpWa9mKftdfDcqygvjHsFbQAu?=
 =?us-ascii?Q?73lvZ0Z08NXqxZ+biG9ntJqTDJPwiXXJ8LaTO6bB02y0PyNFWD2sRIa8R+/X?=
 =?us-ascii?Q?WiD+4efiHox1zGLT/FX1yxn8DeESgyD8FWbuZ2eg1MzmQTMvVPD3ISpSY1yH?=
 =?us-ascii?Q?k4MtKRMK24dPRpxWzND6JAba+Kz1nRVgMaPeujwe4AB8dLNecsqzomVH3wBt?=
 =?us-ascii?Q?etEkDgOcqG1o1oYogSVn8QFL++Ccx+VvxB/v4IXO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4731038-583a-4b94-9b8f-08dbc667f6a0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 12:30:02.6522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKwsnVrZA6wiI3421OO7pRCnSfom0k8QyAH0ks3QXvPHh9tGgzty02dVeV2VM4g+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6888

On Fri, Oct 06, 2023 at 01:05:03PM +0100, Robin Murphy wrote:
> On 2023-10-05 19:28, Jason Gunthorpe wrote:
> > Make arm_smmu_domain_add_master() not use the smmu_domain to detect the
> > s2cr configuration, instead pass it in as a parameter. It always returns
> > zero so make it return void.
> 
> It doesn't follow that a function named arm_smmu_domain_<operation>() should
> not operate on an arm_smmu_domain... I think this is the point to rename it
> to something like arm_smmu_master_install_s2crs() to reflect that what it's
> actually doing by now is a lot less than it did 10 years ago.

heh, yes, I did not notice
 
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > index d6d1a2a55cc069..7f33363719f4ac 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > @@ -1081,21 +1081,14 @@ static void arm_smmu_master_free_smes(struct arm_smmu_master_cfg *cfg,
> >   	mutex_unlock(&smmu->stream_map_mutex);
> >   }
> > -static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
> > -				      struct arm_smmu_master_cfg *cfg,
> > -				      struct iommu_fwspec *fwspec)
> > +static void arm_smmu_domain_add_master(struct arm_smmu_device *smmu,
> 
> We already have the SMMU device in cfg->smmu, no need to pass it twice.

Sure, but the caller also already has it on its stack..

Thanks,
Jason
