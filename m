Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315715E0A7
	for <iommu@lists.linux.dev>; Tue,  5 Dec 2023 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T2hTSdH6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arFZ9k9vEkd22zV05lFNd97oKRd4FcSVQNagyu3un9fqzHvNMglXNBVQwPrYEBhl/y5Zeye9bsTS0PQSennIM76yBMkrEYowixq1FH6/T2pMij+mxb3c9HRmLD/E/LSHzhuzi4oFHlqPQLE6udXhGuir/S1DyDcebLAn+Dhz9pwyTkWhfI05tlrXuTDAma7+hBhfOf/74PkB0FYvxrw6iio+tLlR0Q7tXnVWsbBrpuXCFwf4UtW1nrPJQ3YmrsLE+jGBd94sYNAZH9JZg0y+9sxJz111Xb4t0rgVneyABqEKkVigBYm52t12AZZkkx8K5hdK1+nmFQN1fwusAtvU0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SzrZ/Pdn8zUBvLC6eczLic6vFcoi0o9X3onNMoK59cE=;
 b=W3BzTVix+k6l2A3JFBaN7PBZMGuNBQhGTFzIU+mzuN4soz1FK091nwpltKKkAAf5fdTP3zbfsX5ixZUlWuzOpcX9l6+A+YOqPBMX28yvsx3FtqZnwEw7OgoemlH1bKl+PbGkMP1hSC6PtQbYeRDa9pS8Wbr+4d0Wiagr3z+/dT+U0S2OaRNB8foFGoomiGe/Tm7rp3+MD4LonYal6RM/6f/SPku1gx9s3tr3hsvaKPyJyxJVd+Bfv7oCoyJbv9DAChXOofFO+fkV2crDKjQW4MmzJnc7ezFpyo0Z7nBf8iD/F9BFo+Q1MLYAmuxoD1eTp0xvxUTOjMDUkPFyRKPLIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzrZ/Pdn8zUBvLC6eczLic6vFcoi0o9X3onNMoK59cE=;
 b=T2hTSdH68NSkAuirdU1SdDj7AzAJF1pr1PqEirgYZ4PbOGFchexmOsZDmOVN5fGl8y4GgmxdZxENq5vvga68NDs4D/miJshHzsUKWbDuWZXMpX0effUAta/LkAWtct2O3OflHV9bleXI39qJC9ar3KIjIg1tBNYjLmuqvQe4gWPXFYIjpXozhrlv3Y06c919PUU+8n3KZtjyYAmd1S8AmE5Ek26OYvpWX/ctESkTw+qFAjiEmJFn41hN+/Uf/Dn5W1cjTcZwM8MAbk/YKimNCcXGfJ7ZHTSgyO51WACMkucFN4xUN1tHeeCDvE9F3q7U8g+nOvsUUCNbf9f5EfWIAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB7776.namprd12.prod.outlook.com (2603:10b6:208:430::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 14:35:27 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 14:35:26 +0000
Date: Tue, 5 Dec 2023 10:35:26 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Michael Shavit <mshavit@google.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 07/19] iommu/arm-smmu-v3: Move the STE generation for
 S1 and S2 domains into functions
Message-ID: <20231205143526.GA2787277@nvidia.com>
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <7-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <ZW6C9yepEVC1amuu@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW6C9yepEVC1amuu@Asurada-Nvidia>
X-ClientProxiedBy: BL1P222CA0016.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7776:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e50e64d-0b6f-49a2-d9e7-08dbf59f6c36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AyNhGAoKfU97AqenWJOC/MRdzc/P9vBZNpKYw41IcovCBFyVo5SVyKswiu8uohmDoVqHZcGPMA8ELZXeIgXS2VrnfkBwreELJycODMj7PZvvyLF8a/yrc/k5KoZ2QXupbUMq2H33drz2a4fKDLCzLS/glNspmededZTzpFWLohqjnbbKUXFfXELvj+Co1P38wFvhfqZ1LJbFBA9wARThS4CYW9V94VRI9MOQUKs0E35QQHZerf7ud8nVZ+ftdatfXaOGnjbEiLU1cl86cmlYvZs6OJCLoKhFXfGmKYG31bOUV6LMVISonUvc3YLWjWDGQhTm/+7UCtgS0Kz5NeAGv719nMhfzBVkYnVfdZpPxwstrHrmxJu8dA6ONH1oGzWbLOJJOu72eHDDeABu1UpNWwMC6GtqGJC4c5q1YDEtPXMUITl2Duhxuls8999Ik++QpoYbC65yFNG+M/A3tqlxrF3b1+FiZRTpCEs8fZIGv1jAfcM/bQsvWI8BEkE2lq3tqL98ydbplTyF2e7xbymFlM+aVMR3apyDc0rSPTbVwW0DbAzWBjHxoV707OqQg0Ta
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(136003)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(1076003)(2616005)(8936002)(4326008)(8676002)(6512007)(6506007)(6862004)(26005)(6486002)(478600001)(316002)(54906003)(66946007)(66556008)(38100700002)(66476007)(6636002)(37006003)(2906002)(33656002)(41300700001)(36756003)(86362001)(5660300002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EqRwq+v7ICuiySCMVYBNp6ANs+EBXBHHSJzdVZskR3eDlJXwMWRTlx/bgE+g?=
 =?us-ascii?Q?3h425zwV8r3LCcef//yT0954Wwnm6FZi9uthThSBqSTn+N3KVt0vDYMRpBfF?=
 =?us-ascii?Q?kzB9jfHWsUvHzW/W42yy/MAuabKFDW0v78YXluK/U00M1Z4h09HGpPzQbbmO?=
 =?us-ascii?Q?TQjh6Sgu5rT9wQoYStCf/9LlBK6JRNqGuSWpHXxEZefyUNFAC23CmOf1EifY?=
 =?us-ascii?Q?Rpz0uhdGdF04p3K2rrkFeI/ZDMl2tBEnqFCiLMc16wijQ3tBLg+zVGCHMirm?=
 =?us-ascii?Q?xNjeZZ9GpSfoFZEZWFwlVK5r7A4qrFpPE87hHDCwZZN8AilvCgtDGakcRjZ4?=
 =?us-ascii?Q?VGaJHoiL9vpz44ijue0BWTY8nuHE5FTOplqwP50MPrbecf9i2vf66Z2Ip23A?=
 =?us-ascii?Q?XDbWIIHW2/DFJ0XwTh+e5vNu/eVESUDcJgZ/50L0l58GsQsSPXkrwHNijrty?=
 =?us-ascii?Q?/2HjWz1bgVaEYoR3Cs2u/Z341u94uqT4pGILb0d8zPIux5WAarQMAfeoXP5f?=
 =?us-ascii?Q?1ZBkYcHBThFGR+iF5y2MekjnvR6z9UUscGu3oJfMKL7nUmiSVh77gXciq5jx?=
 =?us-ascii?Q?05l8s5GDtYdneMoENlcFaex0CwZDJsNQTQ+CQ5EdcTXLmaDOL8ZgkkmXjkwX?=
 =?us-ascii?Q?eWzeRePWTP8QAYpPaxGldADD1dFLSntmdqz+Sl8yJW28Yu8uaaYt3fTdBa8a?=
 =?us-ascii?Q?tgOGesvZPp+5fw6sdKnMtk9MtmpgmMVRHk51KY5l6q1DTwfDjgQEme3/ce7m?=
 =?us-ascii?Q?mUyh/Q8x7NLDDRfAe0I79U7pT9WG90m6iceVDUOIDYluUahlm2Kdij59K68B?=
 =?us-ascii?Q?BnAn+GR0Oksdbva67aMBvVSxVwV9U0o7ZsxdQsXMEE2/m8jOu7cvbLECR/Wb?=
 =?us-ascii?Q?pNofD0GG3dr3hGt71O7QDyAhNNEbyMkbFTJBHIjVC/rPca4OPwE6ImoMmw7b?=
 =?us-ascii?Q?m3i1X11p4tbPk+5WDu3J6p4PmdA5yswGwV69ArDYNG6HzojJKfXRFATxV4If?=
 =?us-ascii?Q?jAhAlpj37V2xaI0g5M43wiL+egX22xLO9w7GfySnUUOzS9UkopWM3Go4ILrz?=
 =?us-ascii?Q?ECqhDvmN5LgehXvSJSMThssxkyOhDL9CKQ244Db44PyUq2axOZXIm4NkSaE8?=
 =?us-ascii?Q?Ab+vM7mfRlD6r7ag5NxMjCalZTvHPRuhI9wsb6PYzloauqTxURyeNRPphVhG?=
 =?us-ascii?Q?m156k8n/SzJ9XS2/z6/y4br9iIAvBBWVaHPVfyH7IRNxKEqLoUrtGCsvUvPW?=
 =?us-ascii?Q?AA6OQYOw4T7tief8nUTbjkEItjn/YvjVXbx6bFH0vTDQXwBrA8eTMgVT39+p?=
 =?us-ascii?Q?rftAoFkNhBDXoQAjwNKswZoQrlJY1J5zYRUcaOqvDoIcWNnbm2Qh6anpDHIU?=
 =?us-ascii?Q?OTuHKpPiWcViIudiBxKJP2ESbh/Gw8+5GU0xIu+Tjt24kSV71esHxdLiKTxw?=
 =?us-ascii?Q?RC22ImNyXBAXUfEM17LueJYDcyv/CpkV053nRBEKaVWfDS+rAbFwV9wgts3c?=
 =?us-ascii?Q?EhL2bjm7GotZ66ryHLy+3ZFtP546RVTTwTFPgXfSLrqIOdHs6vv+jKGhO43y?=
 =?us-ascii?Q?Nxhp9ECAb82+aMU47Lc02z/SRn0eRUjHFHOyef3d?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e50e64d-0b6f-49a2-d9e7-08dbf59f6c36
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 14:35:26.8549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bpO/QuL84lRHVqSEIp5/1IKk8iJ4NrIub80TdWJIhLlN5YslsJne8Ld1gBbGEaN4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7776

On Mon, Dec 04, 2023 at 05:55:03PM -0800, Nicolin Chen wrote:
> On Mon, Nov 13, 2023 at 01:53:14PM -0400, Jason Gunthorpe wrote:
> > This is preparation to move the STE calculation higher up in to the call
> > chain and remove arm_smmu_write_strtab_ent(). These new functions will be
> > called directly from attach_dev.
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> > +static void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
> > +				      struct arm_smmu_master *master,
> > +				      struct arm_smmu_ctx_desc_cfg *cd_table)
> > +{
> > +	struct arm_smmu_device *smmu = master->smmu;
> > +
> > +	memset(target, 0, sizeof(*target));
> > +	target->data[0] = cpu_to_le64(
> 
> Nit: can add a line in-between like arm_smmu_make_s2_domain_ste does?

I removed the line since the arm_smmu_make_abort_ste/bypass functions
also had no line

Thanks,
Jason
