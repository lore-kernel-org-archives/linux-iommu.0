Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9047B79E0
	for <iommu@lists.linux.dev>; Tue, 16 May 2023 19:52:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbRpCVIu3zW/COXbQEFVPD29qh9rEbRxNNyYkxtF1q+1AmT/3VykxAd8xIWFw4HdVP63kvyhWorJELHPsjjr6O3MS3n+eo4avwSVFzS+0TUCR75PtmPr+1PDj4up5P9dMNNjCoF0kdNE2QJVYz8uu3kuZaC73fYPjNMaKe0K93pcVZOmWT2ZDxfDIZDaPw0D0sOOAvZNvYLn50+QMPWhU0oMQyDFC4EYUeUS1GatUPLc6eDBMdg3ZgRkxhzs8lx6qZPIvMeIDk44+4x5EuVqTs+9iHOArFWLE3UKy1eBOZkqGoo4ae8kX2H6XwDI6hsQAhKc8fm1dK0NQsaAqN7Cdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5WjdQc1REP0zN7mkGjA6hfDQ+3egBTvKHBgWRzY6LU=;
 b=nOPakeyfvXFZ0qlxVd6hCLtopidMCEdHL0MxLMuecUJ0ZbsaAdh56y1zmKb5pDVFdOu6I3Igk0+LmeHaoRuekD1XXG+rer7LlITH3V7EcvqjbyvcLWZxGsh+jKos16eQ11mjnGz/UYgHpQx63HWHYT4dM3KcFPgGYg604yxp/yKVfIXKg0ERgLRY7CB1uJpTIZvMd8RX935atpy8Ai+SIH5vN86emFbS4cKD/eN4Kpo4lTppX8yR/SHXry1Agi+HTHN1VfaSLX96cI4i8588QZPKUlyv0jZqMt/shKlwQj0adnvTN+mFOadzhoYzIYvkub2l5Mz1opReASHOMT9c7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5WjdQc1REP0zN7mkGjA6hfDQ+3egBTvKHBgWRzY6LU=;
 b=oMyOBvkvNE6eAGuE5MF8xZTycc50jGLZc76AxwUiUX7CVluFtEEGz9j8o0y8X71JjZTCtNj6HhJurVf06jBiw21P1E+f5TQYR+9KzIipLDbWl/IPJiiEMu0uAq04SNaPKO2lvK3XM2PzxrDVVE0YUQ9/U2qTVsjortLFVGUyhkLHGCmWu1DJnqjHS6AgYmLhbKKthooYxUuuqdTELkAZ0XAeAt1Gt5/GuNejhqgo8sQsmrXyulFXczQc4ahBdzCdUwLhr2ZlQT/YeeWK/GLHHYMjhB/cD5NKGyN9xgaXGEGMqm5wYH0qGuPuwtj57+j62JPBzVkGRV+63OlRuVs1Lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB9209.namprd12.prod.outlook.com (2603:10b6:a03:558::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 19:52:12 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 19:52:12 +0000
Date: Tue, 16 May 2023 16:52:10 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/2] iommu/fsl: Do not use iommu_group_remove_device()
 under ops->device_group()
Message-ID: <ZGPe6mVdcj2Tf4Ce@nvidia.com>
References: <1-v1-8fb05192ea02+e5-fsl_rm_groups_jgg@nvidia.com>
 <33b25946-8970-6711-41a5-8b07ccff77c3@arm.com>
 <ZGOqnWBspvDynyJ4@nvidia.com>
 <e8157615-abd3-9072-6245-50add0eeb284@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8157615-abd3-9072-6245-50add0eeb284@arm.com>
X-ClientProxiedBy: MN2PR17CA0025.namprd17.prod.outlook.com
 (2603:10b6:208:15e::38) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB9209:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eae2467-8137-45aa-1c39-08db56470a63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0jOLlGhCwcs6V8O7V75NPfRx8zu+KatkJhOrOISqyRP+qOUmmEBGaSpGr5OM2mexTNmabw9AKrByMwFPfm0bDHJe+UxhNGpX7OV7dAIqEo8SrjwvFALAgGMzc6FSuQJ8GWw5XcM9vJtulP44dYdukNIVR8GY224lL88ziVsz1e1QvH3GqYSyU2XpyJbSFLKbKXDb0vxXgSzMWWpJ3mHUyoy4FHfZSqSQ+zGghidSqf6ihkupJz1c88QqYZ4arSZ9LYmgOXij3+6AiwhL7QfNlJjH/VfLfrZ82TDyav6bVZmIbkBJP6T5Ik9CfgcyUPmmOXqdksdhK6LyprSK0DaOhOOqflq+W+FbdQ/zbPhF+z9hPo0vD9dc7ULPlKP4sHsYMVL1/DzLPXYcPr9uSNfMsipBebWEIfv8DtzWpsJXXMETo4XApU3RuFM7CjblvAZOR2uny5S62v+s3PheY/bvQLSpIqM4DvPyBkVkA6x9mK4T+2GGX8aftxpE7MPFRjBkjQcnYrskJNnF0nLOIIrXzB8gNd8Kw49TdgdmIw8TFdPJH4V1C4ZqIiHA2oN6EKUO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(451199021)(2906002)(38100700002)(36756003)(54906003)(8936002)(478600001)(8676002)(316002)(66556008)(4326008)(66946007)(6916009)(66476007)(41300700001)(5660300002)(26005)(6506007)(6512007)(86362001)(186003)(83380400001)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ejXBGNVOYkqrpaS48E5B2Inq1Zg3RUhTxfmCOUivbdGPV5V+DzjTlZXk9ST2?=
 =?us-ascii?Q?jeB31hZePRzjqLZFg6Yc779AgkVi46qt5/jOF2T0hlbgh5/ZgmsszsngIEbZ?=
 =?us-ascii?Q?F/jmeQdkc7bg1spNIbgk+OSWFalyb0VKgERz7z8s0NOQo/HqP064XlM9jSvr?=
 =?us-ascii?Q?lfRH+LeikpCSbQlwsS2jEkftDa9y2xAbIuefdXw3tT7khLK/s+XkVJHrnmVH?=
 =?us-ascii?Q?vuHfAhswKMo4m533pNBCOiEVJcwDW6on9U4WHlqzhWuzHz1veZ6cAylaFnP3?=
 =?us-ascii?Q?PKEy6PJg1isk6p77qm/vb5d9XdwHApl1YtxdFtDgiMhVbkWEm5vlKvtLifVY?=
 =?us-ascii?Q?WyfpS0soixZ6dddMVwrokLLE+7AqLfS/mxJIVY9whT7qk+UoVqBpEbvlRbSF?=
 =?us-ascii?Q?nsPvG69CNYowaYdGdPFKajyfQjOsxnXMfRn+8T7svvahmE/f5kywidOuH2ee?=
 =?us-ascii?Q?blPSKmBaaKlMG5wPPPX/fK2lmpcFBLePPMTdP37hrmXQ+2lriVhngI8sSvWz?=
 =?us-ascii?Q?d6BHAlXVvA9ssiks4NzE87LeLYrmu93hCEwfJO2Pz9D8VQSKCJ9lFqZJoHRe?=
 =?us-ascii?Q?hOSbd4/RQbi0G0m9zaNthoXEa+qNDER5eWxeg7+epWyxMR03rnmXbsdiZmxU?=
 =?us-ascii?Q?ONRhtPPuwrH4IfZM3xL6WvCyd7D0oqUg+woiQdpJp8nAFo+gVVAoVzlzAbIG?=
 =?us-ascii?Q?/Z3rbw82frRG5XUeMTil20xuRcSNkgi7zfCF339oq52ah1amyg3mVDp6KnOz?=
 =?us-ascii?Q?xlY/0QgChKrtwrNxPeWXip3I9Yr4nMWU+U6SeUeV3np319zkfImiA/MauxJr?=
 =?us-ascii?Q?R2ShZ+NOcvwZjQhFSoxYOX9r6xPUV9d3u9cD7lxRP3LTg8j4zxRO1UsN8mlf?=
 =?us-ascii?Q?VfM0SiwwFR1iFqY1al7/CCiXiAMpxHFGLJSnihza31W8F75kz4wQbEqKu4gN?=
 =?us-ascii?Q?5G4tFFvwuHzjVzCAUWR0VgPCQzlpbtCti9Ok/y6azvz5NvW9zrsqRzFDZbgB?=
 =?us-ascii?Q?/0UXGlU2tv0Mi8vGL2U8TwRQgsyqFIaRjzsClDf4UkXx57ECmRrZ7gPOsMu1?=
 =?us-ascii?Q?jLYupkAF15k4cQJ1Ie7979tK8wJEicZrfZ4HtLqXXXwKqJrISAHHx4idapuW?=
 =?us-ascii?Q?dM+AxD5i2NT9UQQObpOaXufjZ+tmpdgFCqAkfoeoYqiP84GBaDcSb8gVarJO?=
 =?us-ascii?Q?a4L8vnQ/4Un0G7dSQyhZCY8bOSTalZyYaQ9Oo7sseNF3+HdCLHUlkZcvv+mn?=
 =?us-ascii?Q?HRi00YSSkCWZoSgT9I0UkTAonomzGBbihPIgi3DYpbUwb4ztn1cJzaPTe7xU?=
 =?us-ascii?Q?g+W2AM2dyF1+/nKZfR2Ozj/Hp/n9OdyRPMb2VmJPP9/K1EU7N+1Uj9UuMob9?=
 =?us-ascii?Q?qnoPdzfvFLx8yueDSpX/RdfW1APMIG6Z9JNEwrh8GnI+Rb4zF7fSbEAIyvxe?=
 =?us-ascii?Q?fXlrMZA2Sd7dMytqY4nQ4iKdm91e1fUd3mr67snJIY1Tzm/4yp57xBmQHn3b?=
 =?us-ascii?Q?M4mfvQSknHt8C7h2w9tJgTqQFZy4oJ7lPvBESqKp2J7zy5rRWkCp8l0nxpeY?=
 =?us-ascii?Q?g0Ko4uMk1TwFG5zTFQpXGavlDXu6sS4v+nEl2jHs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eae2467-8137-45aa-1c39-08db56470a63
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 19:52:12.2004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SqV/5LSZyickhEV/AUua8LGPtYtzXfbm/ph0ou3LXtc4pBortmepT0TJ0sfprzX+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9209

On Tue, May 16, 2023 at 07:24:20PM +0100, Robin Murphy wrote:

> My reading of the current code is that it must absolutely be relying on
> fsl_pamu_init() having run before fsl_pci_init() (they're both at
> arch_initcall level, implying an icky fragile link-order
> dependency), 

Oh, I see, so this platform device would have a group assigned.

> > index b7232c46b24481..6daf620b63a4d5 100644
> > --- a/arch/powerpc/sysdev/fsl_pci.c
> > +++ b/arch/powerpc/sysdev/fsl_pci.c
> > @@ -1353,6 +1353,7 @@ static struct platform_driver fsl_pci_driver = {
> >                  .of_match_table = pci_ids,
> >          },
> >          .probe = fsl_pci_probe,
> > +       .driver_managed_dma = true,
> >   };
> >   static int __init fsl_pci_init(void)
> > 
> > Even though it is a NOP in this case because of ordering, it still
> > would be good for documentation purposes.
> 
> ...however I think you're on to something here - if with this we can safely
> guarantee to negate any ownership problem as well, then flipping it all
> around to *always* rely on the platform device's group might be neatest of
> all.

Okay, it makes sense. I don't see anything wrong with this, the
controller has to have a liodn and thus a group created for PCI to
work.

Though looking at this driver I don't really understand how it works..
The email discussion from 2013 for merging the driver made it clear
that

 .. We can isolate the DMA access to the host based on the to the
 pci bus,device,function number.

But I can't see where in this driver the RID gets relayed into any
kind of HW programming??

When fsl_pamu_attach_device() sees a PCI device it jumps to the
controller and discards the pci device entirely for the functions it
calls? It seems to do the same thing regardless of what PCI device is
attaching? Huh?

Thanks,
Jason
