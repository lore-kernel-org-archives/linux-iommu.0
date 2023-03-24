Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E4A107B7
	for <iommu@lists.linux.dev>; Fri, 24 Mar 2023 19:36:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHfI+rS+2iCvMDew5Omr9f0o5r358Oe2Wt/MWiGaF5VGS93b5k5MMhssM2DxlMD5m39FDUMlew6RmL3CCaEG/OK/Y4Co8JANXVFfXAcLzJnANwF6MRd+hEj4LjmDQgpd7Xa1VWcjsy4lXYXrrFWD0bIWXjwKOyafLZ6URrRbmnUAdch6Y4uXKnACLDRS1B6EfoDrwia6ZpXT8CmnJR/B8Y/LclUEgIdXbPhLa+rTNtV/cw8a6jeAKoBg5o7+hc0DxdtXUmraTra0jclnDi1161AxlZfo3GLsw+brQKNFALekWENXEbSx4x9N+jKUYgnkS0sB2RuZByRq0JSz3OPSmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWzD7emXEQSHzACTsMevMDJopaCuDa4jfOAfqVjksZ0=;
 b=TLrjHPl0CYOMDIYDf113xl50e73AarL/oIXUjyWrvQVeMckre57/soyMgsdQpSPg73eAXsCXkiGvoxu+wp4cBzJuzVVyuweWQ3MdakYARNb7TkpMMv4IbIl3XlAgyb1zqRdVmt/HiQZoaIiMROKmsjf1CtYKBxlggNIxse3d/JTli9kZPe18ymJRAs/qZ+Dt7uFPMrl1Yp7q9pKj7U2zty3kFeIP/4Aeyje/7qhrxyFwxEaLcyzazemnRKfj8KzH2jH8AhoDDyalpp96IDUDeIV1MflRDWuhqF1ceEA+jIWz8zi4/Gj0HH9d0SnCJ+kVCVBrpGbZJczRo5SwXQ/Abg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWzD7emXEQSHzACTsMevMDJopaCuDa4jfOAfqVjksZ0=;
 b=HbsrhXNuH5REGaMWBqsqAF2dECiNd/pqcKCh1QA5ZS99PllEfi725aADT7H7Clzoot5oRjUjnzxAASGQv+CWSwOMtCJ+3WbGRhCjRZi8/L1ZSZNpyBOgIncFyZvHRx5vIfiFoHJB+F2o+DZyVTGSO4s/MWWxsF81joZw/mQh/wAzvw8S/NUC34yUpZ410zCeztm/NXiWzt3vi/1Nc2iiLeDrtRyD7lAZspQpwV73Um6RoW/+CMitst8J03W4zWbd9JEhnJYUTHm666dllspkwH+Xy+s/wV1DPlv7jB6fCtEFBby7vB16B3YRfcPm4qdkgyGJjwRSkSUL33MulpPEDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY5PR12MB6455.namprd12.prod.outlook.com (2603:10b6:930:35::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.23; Fri, 24 Mar
 2023 19:36:21 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Fri, 24 Mar 2023
 19:36:21 +0000
Date: Fri, 24 Mar 2023 16:36:19 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH 6/9] iommu: Fix iommu_probe_device() to attach the right
 domain
Message-ID: <ZB37s0pvcgkfyZXb@nvidia.com>
References: <0-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
 <6-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
 <BN9PR11MB5276832381FC73EA5E8C05428C849@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276832381FC73EA5E8C05428C849@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: YT4PR01CA0068.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY5PR12MB6455:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bfe9ddc-490f-46ac-30b4-08db2c9f0bde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eUePxloHiLE3o3UST//ft/8mbL08Dl2yT24udiGamJYoJ23I6D7dILaLqKZMsab3ieLmhY43B5HOIQ8YRS8Sq7A+O+7WmUbpQa44w8UtAARJFVNXgHXwft/LwcVTdT8fFiFDMfAbuc5dHW30F5I72QRVfbSMk9UsUoNIXzwL9pFfSvN412hTeAYwZ8TQkjYNmMt/iD2GRiwBh/LiHAxfogK6rEO9pkhWW1DxSnXdp4Ocelj66xKpLuZDz65iTEFcRiS6xIeIv7TEDMJH0Wq2VaiwPZTOpxoxU2GlXnMsBuFwuaQ9ImnwUbXeUYaOIaC3taS+KKI77my7wsB1ohl4/PHEzwbmKsQDc0iSgk7T3rJEY4IZEGMt9ukrXxtP0+FDzaOn7I6dDT7x34tAqbohGY29kpWX9A/qZPsDAxCBPNHXjSt9ViSIaDxZMY5PBb3qBBfVAoyE/2e1JhvrN+U81lq7sux6qOqEgA7jxb9o54P1B806ZZNdXAt5UIw7Bnb7d2Fz4ISXkRBoKYt/dEG43X3W11NRZocz+/WL8prbYP0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199021)(4744005)(478600001)(6512007)(107886003)(66476007)(86362001)(5660300002)(66556008)(6916009)(6506007)(966005)(54906003)(26005)(36756003)(2616005)(186003)(2906002)(6486002)(66946007)(8936002)(41300700001)(38100700002)(8676002)(316002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IXOQn6H1oC21kqJLkKFNhbmNhCTSh3nu1zOHJG8MPlt5snyoM9ILppBslkKN?=
 =?us-ascii?Q?zKI1bHflQATiVz+cJjEV6Q0KlZkROSUVXniPr4wBcXXLlkzdgA4+m0diU9Si?=
 =?us-ascii?Q?AECKcM7mMQcHgDL/9gj98BagrCFB1yiAvnYFGZs5Yt66oN+kOyEAbGfi8nnI?=
 =?us-ascii?Q?Reyf1exJZejlvPw/X2d/74G6i4w7VQvX5l48d4inqPxuZAAF4PRaR6kWL7rQ?=
 =?us-ascii?Q?VSNF3O2Cdw5hqEVrm4+vgT6DaOq3mfpEvAIm1T0vYF4tPQpqevhP1DqZqgrB?=
 =?us-ascii?Q?mXKcz5ibPpnqUyRlBYF5jxkiITt4hjbTGn2Qsa1caWrenoc1O9wVETlnJpMO?=
 =?us-ascii?Q?r2jatImxx6vOcIix443sK3e72mq2hL96KegzBP6UTJVAy5277+GuFze7VodR?=
 =?us-ascii?Q?NAamxoi1E5iXfX8qldbbUgAweA8aJVNS8CZZPw17SXOhnyF8OQ7OHqf321aG?=
 =?us-ascii?Q?sb5bJfmEOSQVzQnFY+o9qLaWnHk4ripAH2I29BFY2dUF+/ltAZkG5hi/p7Dw?=
 =?us-ascii?Q?mwtqPfYopyh8iwzSA9W5HmRb2q0UQVZOD8uX4sWOanGDDrgw+IygZQtz30Fp?=
 =?us-ascii?Q?zALwclqHGb6QkgBdAV6Zv3gB/77tdNZHNBsLGKY8ugU8hXvrrJCOlY97rS+k?=
 =?us-ascii?Q?90SREew1IdB1+LhKTa3XVRuorGuh69fWed9Qj7VhW82JomGq1yHfviGamZLy?=
 =?us-ascii?Q?/v87R5JCtfqIcDQvqS6Pq16FNIFgv119230PZfca/sDU3lJaaVBnwBxEXnSA?=
 =?us-ascii?Q?Fqf9XSSfxBNjkvAFyBU0iRumkuvoh5N7OMBESgxotfkGkjZ7VgECSAZHRwim?=
 =?us-ascii?Q?zuxOlHkzX3/lnXzGtIDxZcowLCQ9SVjlthh5GpxknPoa0qT3rWGp3M8ljrzc?=
 =?us-ascii?Q?ua98Iodn2FHQaHkc66oOryTXTLpb7mk8lXI7vJlf+tUtbfl5E0NgqkTCHGQm?=
 =?us-ascii?Q?hLHMNbPe7cPU9C1Musfk/eBkh8UTJci3bvWwE9FOdarN48v+Cx2lrWnvMjfS?=
 =?us-ascii?Q?oGXqxxISoE9yr3FbOcvHZI/vBg1IS5XkQcgcUxRDUrIlLcHmYnWy+fY8t0bH?=
 =?us-ascii?Q?Usa6+OSbzDUXOR/B5Ov5ffh1HP7MtKOOLmqV4vOt22Z4L7IHT3Sv4Fs6THJQ?=
 =?us-ascii?Q?ZNJbb/s58yTOg+OXnuhsSL+cna9x1wxRvszFL0nXS2t6vzZFkMz0wmOeJ6Is?=
 =?us-ascii?Q?j/IWcvOpDTuVH0OMmAXxyKgCz4tV2cj+WbHMXvbLsbEkbT0IV9hLLXeYgI5m?=
 =?us-ascii?Q?ZCHE64Bu/ktO6lWOzujKeMCv9Mb4BiDNAPhDpppDSEH6szQmCQsOYuk52kGj?=
 =?us-ascii?Q?dvMXJDLkDdHPjQUP+awmcLsXrMCC9PZP/JXddEOPqRH2ag2Ww3VUq4NroLIV?=
 =?us-ascii?Q?U5E2Jr1AuL5g3I8FK1ZhHnTjyO0D6vjSKPsobzIvRf6EkE5pB1oeiKUVMTiR?=
 =?us-ascii?Q?0pEtqvEz+Kaq3A16aRY0MK24ohe6kcK1kp3pV+X81A3sgTUS3nHskoqpeuEP?=
 =?us-ascii?Q?2GjghsZpnWOm9nMbKAD6YspVDfupVa7B3as0hEhZ8O4qPafi8UA/ehxpNLAu?=
 =?us-ascii?Q?mb+BSKriqug1itzGg1CqXwAHUnTL7t929GnBh6Yu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bfe9ddc-490f-46ac-30b4-08db2c9f0bde
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 19:36:21.5621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8WzOGIX+pilwREOYK4mzG8ohjxB0zLn7jYAIGdiNxTcBAAPnfBOaaLnqzRCfay6+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6455

On Fri, Mar 24, 2023 at 07:29:59AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, March 22, 2023 3:53 AM
> > 
> > -	/*
> > -	 * If device joined an existing group which has been claimed, don't
> > -	 * attach the default domain.
> > -	 */
> > -	if (group->default_domain && !group->owner) {
> > +	if (group->domain) {
> >  		ret = iommu_group_do_dma_first_attach(group, dev);
> 
> emm this duplicates with the attach in iommu_group_add_device().
> 
> It sounds cleaner to remove it from iommu_group_add_device() and just
> do attach consistently in bus_iommu_probe() and iommu_probe_device().

This is what I came up with, I will keep it as a followup series:

https://github.com/jgunthorpe/linux/commits/iommu_err_unwind

Jason
