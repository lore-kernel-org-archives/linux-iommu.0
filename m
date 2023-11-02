Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549741642F
	for <iommu@lists.linux.dev>; Thu,  2 Nov 2023 12:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HIYMVnVs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CjZIbxUP8Sf2jsSFPnjXlhkoDcYXYjvcxA/9ZgSOBI+qL7Al+H1RwFObb/VUfGTEgcxDLTTiaS0PUHS6GNEryhhS++rVLdjO9eryUbZVCqIF8A+fPV+VXQ5uNSeWeN+mpsG1RtFi/L0f5hwhxgoHbZPtbCiCGlHPDneZawAFR1bfZ941v0CrL+d6febnAqiKubMgFfmCrgvCmS/+6Ycy/ZTWTZh7vwJTYIiOxbwNT3lVQqXZCdWcMAvYg6rzMpssnU79cZxZixrlyPR9BAmfaB2lvA2TIdf9bcCSBg5Eky3oTlheZ1Jj8iclEcgxT0KslJDHi2Ns5LFHOo/i4FpAZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2voD0TICW2LSjqJE3A0HD20lGRMrCytnBhsJCJCbLpg=;
 b=FjeoPAKSKba4KeKXclU6XBOYNXJ02fhJ3HKaGYXi5HV3qIAFHPrScLUUceBw0+/hLlKhUX8A7Epn05fcPO31txpyh2HPUDKdFRl9l1mRCfp0nUQwE5dzEXBi8TM12EvcLTWMYgLT+75FUbTdsEIYQFFETKGEvOzbBdP8EzBVBMK0+mB6cWMRBoeQQTANG4Cly6qOBzgKdN7VdPfgNaP00P96rHRtJvWASLJrD4HbIzduzFtLUrmJzNUvAnYaGgzj5oNeslCo7nXJUbc7jEBZjU+UaCe0hxgIkbHQkdqY58/DouqNs1+mmvvRt1OdTExc64eGJmcXYmV+qvhxBuOhVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2voD0TICW2LSjqJE3A0HD20lGRMrCytnBhsJCJCbLpg=;
 b=HIYMVnVsCgNQl76q7ROEjKabq0M0FEzlYAmL1v5qGGtRGsS1BFu7B8OkGG9jB+qkqbDBR5P2l7EmqYJDZxWNtsC3K+rDYjv3PoZ0cHCEBQFnNDRusbQRwgjHPOWcVnFvC37OK00Qrnlabe/Ld9hIGkUKnmTSqoa+A0CaCeeLgSCziTYbvnnydYXf0VaDp5UvS/lJ89GkFgBZ0QfLqWJjM7WEDItJfqytz937p7HRknX4Gstu7PlOh8VkW7eWMWRJD1Gsy4cUIh33n7wUpIEKopOS9RukoqE5tKKjTa9+GQSYdyP7WB0TZnUl9pdn8w1E2g0HzmTwslaBUcvjCDRlag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB6270.namprd12.prod.outlook.com (2603:10b6:208:3c2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 12:12:48 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Thu, 2 Nov 2023
 12:12:48 +0000
Date: Thu, 2 Nov 2023 09:12:47 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jerry Snitselaar <jsnitsel@redhat.com>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Janne Grunau <j@jannau.net>, Joerg Roedel <jroedel@suse.de>,
	Sven Peter <sven@svenpeter.dev>
Subject: Re: [PATCH] iommu: Flow ERR_PTR out from __iommu_domain_alloc()
Message-ID: <20231102121247.GA4488@nvidia.com>
References: <0-v1-ee4b137bfe3f+57-domain_alloc_err_ptr_jgg@nvidia.com>
 <65qhudcviofmcl2g64wca4yy2a772uqvoky6xp62ij2svj67vg@cr2pu6anogqh>
 <20231101231727.GA5675@nvidia.com>
 <98af21ae-f0f0-458a-8a21-7d2002b18ea4@kadam.mountain>
 <3gvk4gzznjsrqouilcqzq7f3lyhmumrm5l25xqk24uuf7426fr@qivhtqql7d2k>
 <9895fa9b-29f6-493f-b4c3-7e227144bd0b@kadam.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9895fa9b-29f6-493f-b4c3-7e227144bd0b@kadam.mountain>
X-ClientProxiedBy: BL0PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:208:2d::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB6270:EE_
X-MS-Office365-Filtering-Correlation-Id: 841e831b-4cc8-4d2f-0d93-08dbdb9d0750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Is4Unoljj2iP3KuQXIXkaHMlY/prKmICgihJTl/sogdmDtDCJwOqfesmAZSW8NjfD74oopXRkneAxrzBN8IpbVNFpctrFWsg4SAueClu6ZHFbKfXFA5gLIFd/syuLJMmbcJ/k/HWnYmZW+Ttc8ci+qNUKBZfoF/xvwbOXYErXP8gjF/2ruulnNXLLE5kGXz8UL/K4PjxGA/AbP7qiCL1/QWbxg8GZxK0Qm5aRO4+f2MGS4+UeDdVF/BA+iYhDH0+zAv6d6ZNeFFVLk4SUFLg5AGa+2XNwSAqsicTNbJwFf/fcUE300KTIhjRnBICx9TmvR7YZR0u6PPPKSlfn9zYj/tR7pb0gCdNU8EbTAIDkiAFWhBfruz4piIHvdrXvXE3F2VATP3YlkLqm+H14mGgbYljt4wC7/wCL++2nP/xIZ+6PNmgA/XTrQQO31bdmAchlK5rqF47vPKnZwZ0WyvHk5SB3fmbppoY+qEdt8VM7XQ/M55+YTznY2cMcbFBTRrSHReDzvk3e566HH9txm9b+29GsheVDXGOP8ktkrqf4rIr8Nwu143+IG5vq8nQwWR+/dwaikQuHRgdHDlj+sl+q+H0E4uUPUM4Ra/+qdGd+HevumzeCZ4SDSvy0s5DxrTS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230922051799003)(230173577357003)(230273577357003)(64100799003)(451199024)(186009)(1800799009)(6506007)(5660300002)(41300700001)(26005)(6916009)(54906003)(316002)(66556008)(1076003)(66946007)(66476007)(2616005)(6512007)(6486002)(478600001)(8676002)(4326008)(83380400001)(8936002)(36756003)(38100700002)(2906002)(86362001)(33656002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SRZFcjWhe1tEO/8TEw32xX0xWf5KvgHvTxVmyt6Mo7mcpR1rk+6KTJiwoVLC?=
 =?us-ascii?Q?/HXn8FWlyMoyB8SnIes0+jZCmTvnXo6oJlKrvgxJkfdftGPXIK3k7CD5Jja6?=
 =?us-ascii?Q?7qm4TIbEtYIKWkzEXXaHY0STsiv/GGWCwov06tPpZzNpjKkHcyH+SDWCpV+E?=
 =?us-ascii?Q?QLEKm6+O8qHoSJxu9amFUjTD0OmlfVIqN8KYrO7EV3nd/zD5JKp/MvfcdDuf?=
 =?us-ascii?Q?4V+37YA5pONeuFqhRw8gakhLhca2hE1F0Y4EjQjZk0EiwKDVJw7xG/XC9icN?=
 =?us-ascii?Q?Nk2EUzF093vE4yUrY9lnUPKoPq3W82Phq+4e04rjf3uepxtC4vEwGIG6ywlN?=
 =?us-ascii?Q?JBujocLu3yXgDbx2eVX/TznVo6zHvD74GVuarB3eFeHhKAiFYWcJdJocpG1J?=
 =?us-ascii?Q?m207dUmS9aiAjm2WMs/e8WJQdLcMxoKK8R1eiz7G/rE8Nk8d5gG5AyH69sLN?=
 =?us-ascii?Q?bd8kVg7dZIbI04NjBnk48FSoIj0+4L6t5nVyijQfEnqErWaRY9a/u077qD/i?=
 =?us-ascii?Q?zaJl/2pwj4lUcOEEJS8Nxovd7xnNEAhtes+eupMLK9vZrJa12rqaBKDoPcTe?=
 =?us-ascii?Q?wqZXPem7u5zjo6Mu9iqvW8cjdhgpSUgTIk41QvKvGIgNjFXFPk+sGfYdkN6j?=
 =?us-ascii?Q?FI9mFxtFTxtL8U0j/etG7+zW/B4VsSbXnUvlg+DjQOs1Su35kRBDmkBDvbZ0?=
 =?us-ascii?Q?miCCeys3pa8NaEf8s2ZF3Zn1BPEC/gIuFlywNoC/ZSJkoGoZVRrZ8au2KAE5?=
 =?us-ascii?Q?P+geQooR6ER9CJMFvej0KUYUONbiGmd3/0FHoyXBxnPqwsrrI8Q60rfCuwRR?=
 =?us-ascii?Q?9PndeJQVl/XOQs+W4BN2o4tLG1R6UDFfdBzQ/dp7U/QXiCpyuO2NV9A5G+6T?=
 =?us-ascii?Q?izUgpGiTKPkq8SSZ88Nllot4XnbcYefaPrPiZRXDW5IY38Dgm54HELFPRF3L?=
 =?us-ascii?Q?F6wf4VYSsd9E16tAxtAv0bITHvxpRmnyaApRl/OnGftG38IOnMqoa7tf+ccq?=
 =?us-ascii?Q?g+sDH0SMwiU9LxswXhev6QeOGadsXumzS4Nkt4aNJnOBpv9210EhqcapqOzU?=
 =?us-ascii?Q?w04gm0JkBD9zwph1HunXtgUJRd7wn5c8iTQ2B5QSMD/GOLdWEBOukcRJ88Ja?=
 =?us-ascii?Q?EJg6xxig5oVjQJbJIpGV/AEnIVXbeo1+WA/DJfFXf9u4I9CoU+vLZQkHG28p?=
 =?us-ascii?Q?wAdx+X/3Cu1ncQ2V3awm9/e2ihXf/inrahyaFKBBYeOAuaL9DkGDbabsVsFS?=
 =?us-ascii?Q?+1K3QGSITzgIQFoRpQ7xZ4rH8y90RFUbar3so+xzv9FQPB1L9UPqKLSs+NHi?=
 =?us-ascii?Q?EFTyCIlz6y3TEczH77pEgDLqB9bT8rTERqrJaEatVK8APe9XBXDq5XRC0C0o?=
 =?us-ascii?Q?vW7dMi+0r1UkKtq1yzla4PMqYDQpO/efFUrq2VaYVuf9RHr7gwqhuv5Rxhg9?=
 =?us-ascii?Q?3nhyNG1siDTds52vmvswar2qazXpPCU1A1j9Qoa61bE4c/sswW2dv4or56/S?=
 =?us-ascii?Q?Q+7iAaOPSYsKBHve9GVpKjRPYOZG9iqrWzUbP6ENfQDAJld5VmDnbkJX3V4y?=
 =?us-ascii?Q?LfXXGghhwFRlKOA5r7JUTlvUdaV8bnjEBIN68puT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 841e831b-4cc8-4d2f-0d93-08dbdb9d0750
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 12:12:48.3453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Zru8rdHgR71F0N7N2Ddk3Rxaj6RHR5CIfz9/dMNxTbGOcBfo8RC+oGYkrsRcLcZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6270

On Thu, Nov 02, 2023 at 08:22:13AM +0300, Dan Carpenter wrote:
> On Wed, Nov 01, 2023 at 10:09:18PM -0700, Jerry Snitselaar wrote:
> > On Thu, Nov 02, 2023 at 07:10:57AM +0300, Dan Carpenter wrote:
> > > On Wed, Nov 01, 2023 at 08:17:27PM -0300, Jason Gunthorpe wrote:
> > > >         /* The driver gave no guidance on what type to use, try the default */
> > > >         dom = __iommu_group_alloc_default_domain(group, iommu_def_domain_type);
> > > > -       if (dom)
> > > > +       if (!IS_ERR(dom))
> > > >                 return dom;
> > > >  
> > > >         /* Otherwise IDENTITY and DMA_FQ defaults will try DMA */
> > > >         if (iommu_def_domain_type == IOMMU_DOMAIN_DMA)
> > > > -               return ERR_PTR(-ENODEV);
> > > > +               return ERR_PTR(-EINVAL);
> > > >         dom = __iommu_group_alloc_default_domain(group, IOMMU_DOMAIN_DMA);
> > > > -       if (!dom)
> > > > +       if (IS_ERR(dom))
> > > >                 return dom;
> > > >  
> > > >         pr_warn("Failed to allocate default IOMMU domain of type %u for group %s - Falling back to IOMMU_DOMAIN_DMA",
> > > 
> > > Not related to your patch, but we should delete/move this warning as
> > > well.  It's on a success path.
> > > 
> > > regards,
> > > dan carpenter
> > > 
> > 
> > It seems worthwhile to note due to the performance implications, if
> > nothing else, of having to fall back to the dma domain type from the
> > two types mentioned in the comment. I'm not sure where would be a
> > better place since this is first spot where it knows that is going to
> > be the case.
> 
> Maybe it should be a pr_info() instead of a pr_warn()?  Maybe I'm just
> wrong.

TBH, I'm not entirely sure what it is for, it has been there a long
time.. I think it means that kernel config and command line options
are incompatible with this iommu driver

But at this moment there are very few drivers that don't support
IDENTITY (s390 notably, I suppose) and the DMA_FQ stuff is no longer
driver visible, so it probably never triggers..

Jason
