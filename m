Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8A85662
	for <iommu@lists.linux.dev>; Fri, 24 Mar 2023 13:17:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Auu++FSYFEiG9Lre5+WT9gMm0Nb54oGp3+RWJrY6o8AG4zrr4jTbmrutKq/0SWEI+9I8VXePwpSRjmtEygt5FHCw1ssKoJh/jNrmX5FvZCGCmerJXx4YvGyuIrRXJwYzXAFcdG2lYQZgQsiJrmP+GYqRrEhids3ZSkgRY6pMumOLfHVBj5ZFGem9GHy3fpziol9NeT52vMG0Y1V/R7dpaceM7EZPOUhOlpy/uV9nFQl6Z7b8soKYiMQ/QdRDtFcRsbdt1L46UXMs/J5UowgKlxtlTv2zsscQtgkdkJn+dYKsRSPUGVUQO8mbjWekigXFnZle0uk2mfnKEwQSdoXqRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcb18/2DTuZMBle6bbzDakOzRgCy4oETkutmvtp8ux4=;
 b=l0ClrUBjP9rwhXtHTCMLZsJu/ifJGkEmAiqf+EIyFcehO5oX0Wcp3MES3ecF1Kim1dDeGXmZ4lKDl2FbrPhf6Rtz8cn7rGnwGJfgzawCmcTiIttFbWaEkSlhBbhIu2sMDuexjSBAXIeg/c1y4jnFdXCl12MaJN5ocyfXU83tNy8Sap937rWPiyax6y/5C5VXU2beQF7SK2mAdYKbWfeq6fdyh6HKKZRkvcXriT+uflhl3ynkVlDmAd/mXU5wRDuuI1uykCcZd6VMCspifoJvkkCliQtPlmDJVqiC1572meDCICp/oXpmbt5Z56wy2qtwImPBHSbHUKmqdh5HIyPDXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcb18/2DTuZMBle6bbzDakOzRgCy4oETkutmvtp8ux4=;
 b=TMWVvlGoQM8vq1NHkkfAyHqEhH6G2PIm/TcyIu+olyJxUDyWWFl7vkTTxoejbf4bcwvy9h5xDO4xeQSSZHQubfajrAFfLDwOI8JDiT5JWoxt4jxEQzfe1w6o6qiHsvVEc5QTptbomq/G1rMG+NmVpHz7LpMGIjltarRPFM+efM/i5w8CC6ONvH6jlC2mkDKuPF5em+i2decC9PfrBC3s6yGiEJW4tiqJbw8eY+L+greFUtLgjjWAzYj819KZwdMZWq5Dl1R6S3n/gV6JCoknDeAftZRwstGjMmCY6FiCCNf43qFEHVQc7ieb4P8TTiKV0u6K90J47t9xG11R2MB7cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB8248.namprd12.prod.outlook.com (2603:10b6:8:f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 13:17:04 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Fri, 24 Mar 2023
 13:17:04 +0000
Date: Fri, 24 Mar 2023 10:17:02 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH 3/9] iommu: Use __iommu_group_set_domain() in
 iommu_change_dev_def_domain()
Message-ID: <ZB2izrAqR+ZEiQGY@nvidia.com>
References: <0-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
 <3-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
 <BN9PR11MB52769E3DD95D30D1B97E3C9C8C849@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52769E3DD95D30D1B97E3C9C8C849@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BYAPR08CA0011.namprd08.prod.outlook.com
 (2603:10b6:a03:100::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB8248:EE_
X-MS-Office365-Filtering-Correlation-Id: 607f3c95-d739-4197-74de-08db2c6a0fa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GRoXMZy456ssVHLIn/nb+yEO8qI75wJyY2JetC45ma+OYU1k2VEONlWWFQf0jWbdUZp533wFfIHC/9Wfu+89X3+Un5iQMb0mkMXonydxEeUcCGsYe+iflerqJNZ4CvpcayOo6O/awQ6mQZljsXzEJJJTqhSEOFAVA/p7qEaZsKY8Gjg53BpJR6X2N9ancQkfjk9+nrk8C1S33qEX2o+vhVKsDGOWUKHqv45UgxbiEowLH/6lp2NeD1lrpot9unqP1sptCMJ971np3Of8BdD9MhWe3Ufjmo2JBzrTPwlhe42XDvnTclU66mUcgA2R2/qwpKr3gWqlvcMS0rMZ9xboV3xQqHflyi65SDgMG053KDVoC6xXiLYLuT4nc5e+DV6Xju+28BA3RdgUTiyEVp3JdDCC4AXyYSEztwQtlFyQH8NeC+i5Yh8hoLfqMrAec/NXJ6ccFFeHjth4Xrc511G+hUdXEzIOypkZ00Izf7IxverMO0BBjb5wfzLzb5+aHbmSm+SMj5balXJiWdi4nMZnAdj8QRa9+Wo8jjYQYVEoniCUMGL16hlfucWngS84KQHNfaui5aBCLSsoHGhGH14oho/WsQypoRSt6Q+dXLs3uWs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(451199018)(4326008)(41300700001)(4744005)(8676002)(5660300002)(6916009)(2906002)(66476007)(36756003)(86362001)(38100700002)(966005)(6486002)(107886003)(316002)(478600001)(8936002)(83380400001)(66556008)(54906003)(6512007)(26005)(66946007)(6506007)(2616005)(186003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XsRNTiltATEmdORWeIINfWC/Vz8eg46KnQr/plu/hpvLIQ3xsF+/ScPYDQ2g?=
 =?us-ascii?Q?aTxqsHn4D/q7zbrGu5lCxYe1XDKaUJ5Wd0YRaxFIm3H4G9W4cTUBUVDUVxtq?=
 =?us-ascii?Q?2sNy6QEVB0BCF2msT+cjEWkxkAycdBgU7pyqM14Pk7ok1nizKg8XyUchV/is?=
 =?us-ascii?Q?1lTLGWbYajXGsVBEXrI18Lv9+ZmGOkXi/SFGd93f01lmglcgroFJaeMUcu0O?=
 =?us-ascii?Q?jqpFlXedHBhFCpSTVuhpDCt7/6m7fxdFXgBziq4dXDGsWt4ULj63aFg9/07j?=
 =?us-ascii?Q?kuC9ekjH+45+wG2yK0saYIFXKP7e272pA1A9Bd542m79FSNv+Fqt+8Ff0ekb?=
 =?us-ascii?Q?vtb9SunLzITJJopIxeZ8jZ4WpZRoi5FAZ+qg0uvfVyj41G6Qi6jbLUvxo39D?=
 =?us-ascii?Q?4Om9H84V4NlwDfzBO27Br/B7c7i6+jCV1jUiy1uQ4cN+m+++++E0fgEqxD+n?=
 =?us-ascii?Q?L95VT80zUtaqEzds9SwDBsgEpCIIsjAgw6PbI9wTUqUxMzAY47yYpCr4WW5P?=
 =?us-ascii?Q?Efu2i0t8WiBRX+u1rvg6gA4fpbQR2s1SPjWmexMynGH45LZ0BNx9ni05tu9I?=
 =?us-ascii?Q?tR6CRd9BB5uykSiqY+Ij350rcTgdxIufpZ7cC4oSHbdo+c6TC3LKmvYOQJrL?=
 =?us-ascii?Q?ASR3CXcVA/Eqt/oWxFHtpC2gkrw5kcdLZc4bR9KIZ3IWr2belX/aXXxxsYAu?=
 =?us-ascii?Q?wszRuE9yR2PCd60sNbZi/guEGLQr9KT+fg8qVxR7tvDmtkxiAOuf9ACBpQE8?=
 =?us-ascii?Q?LQq7wQEf/NqlOUOHTUGJuWR5k/huyjtcWAH3YrmxVHIN456t3gEHTdJ4IbWE?=
 =?us-ascii?Q?kOLAVz+xDWgQ6OEIDq1tLpPyPU/3FtTSwf5u9kiHmb5FymxwtgRiKSm2NNmg?=
 =?us-ascii?Q?OQoFShZN33VRZRmia88j3XbY7KznNGzDGLpFddqnnY1bTWoSLjOTb8e+aGt+?=
 =?us-ascii?Q?mf86+ubgabhRRbwqJxr+aENXYjB3SinFvwTj7nic4fhQ8KcTGeg+JykTIeIS?=
 =?us-ascii?Q?KjIphO/oxHikynCLzykBKyhrRYfOw6uKHtipq4ZRxEWIHTqMqE+Nq/YmywXr?=
 =?us-ascii?Q?wrKmRWXYCWkzoiFZOm6IcEgU1ejN78d7NW7uij0fnfQQ80r5mZ7gFwWxoPY0?=
 =?us-ascii?Q?j4u2ioaX4CmmlrdQ1zNE6rVQwW+1Jg0dCoQlDsu348WIseG+ecfHyTUh6vPU?=
 =?us-ascii?Q?hJ5rh8imfLFvT/7msRxZQnmNclnK9QZEQ+m/x2HqQ/t/+jeLNNCLXOYa+ISm?=
 =?us-ascii?Q?ZLWWMRTM1dEaGlXjI1jBYX6RsbnW/9k9WGamTbsbnvemQ0Sakhah2tnb8qjv?=
 =?us-ascii?Q?4WpddSb1zkAwNWB9WK/0VLlmkzfyTXd7/ab8VUxxE6a31lKrE4ctbs77faeY?=
 =?us-ascii?Q?StqxzY6jBijG1hODmsBkHsclwfiRJCXw+HVCoVVI26GWIP1lw2DBXGgHOUGZ?=
 =?us-ascii?Q?kSRXpxZex6vnqb9oSpQct+bwGuqrIikzXqMSXwGyvnLMFfipoq08az6Uaw7D?=
 =?us-ascii?Q?7vGjVlfDbYQf1BU4dypL8wx5mQKQQ0xkMmr0yGhZc3oJM1FwKofj6dxDjZ5A?=
 =?us-ascii?Q?iZeRLO2m9r/5lbOWFgAyllWU9DQQFLjKxaEGgiUW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 607f3c95-d739-4197-74de-08db2c6a0fa5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 13:17:04.4964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 36RfJElzVocdc33weese7DPz8JzEz1rqH/s8hiuRxaQi2p8wz1OYWYdmgkj0ltFS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8248

On Fri, Mar 24, 2023 at 07:19:35AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, March 22, 2023 3:53 AM
> > 
> > This is missing re-attach error handling if the attach fails, use the
> > common code.
> > 
> > The ugly "group->domain = prev_domain" will be cleaned in a later patch.
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Joerg just picked Baolu's series [1]. this should be rebased atop.
> 
> [1] https://lore.kernel.org/linux-iommu/20230322064956.263419-1-baolu.lu@linux.intel.com/#t

Yeah, I just did it, and made a few more adjustments. The default
domain setup stuff looks really clean and straightfoward in the v2

Jason
