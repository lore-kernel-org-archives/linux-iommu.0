Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010000.outbound.protection.outlook.com [52.101.61.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF512D660B
	for <iommu@lists.linux.dev>; Mon,  6 Oct 2025 15:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759762898; cv=fail; b=ZCvgJaNQYNGfBvYGLgxetljMtO2WzElXA0XUtplMNT5ya3zQnt3mE498ZeFJkChEgXH7FAQymIC6Sy2x08hd05L6am/UwqpUWouUa0FNpkaAg2GK/95el/h5paCI6pHZ0LNtKYsqQoypHva9oJn2FKKn2VXvkgTbOs7fpZ5ALRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759762898; c=relaxed/simple;
	bh=1UpGRSgXaZNw9/dikDuwCjI7IMxNO/fU2hMAkAr49nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eXeUSunxICZ5UQv7wGJ2xVh9vNvBG2ung++QsS6OyTfG6EhK5gE+FW+aFqSm0MSQZvR6O3gZEVd3Pqzt1RTBKUdOQfW2Vjy/uspCCQOaJ6lJ2G2tVAGrtP8rj/UZJqoQGpEHW+UYUYBixaeDXc8PFL1r5n2+/SeDzaVoaZi7UyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S7DInRGp; arc=fail smtp.client-ip=52.101.61.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S7DInRGp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rLdQJ4SgSdYZOo2G0zkQxJeN5EExhWN8+cw3H4kHcfBeTCsKZSGU/uqKDUrfvatBbaP/j+VbhlHybB9iT1iQU3Whquc6Z/3a1abap5Nk26JbJmufOCjVHYO9HWMN/0IFK/In6Jop6uZL5BRuCelZuL4lN+TKKSV3w3+8F2AS9jmeuN7WEA7PJlzoUC68dShx/4t2WeXbuv3VE6s5+aw8FFB0xJfxUjNRO/qyY+8KUv2wl4GbYM22SOEGJXeoCxvB6ttEcblNNBlUXrdne8yMhDGzgMgAUgEXZWnpe6x9YoB6w1Z+6v5QHyilBp0WfY+uXZRw4eK6lKl3/owRYP+2Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxZhR/sT7xzje4hE37Fe4i9cMyEDu/51QIZYAHGnGq0=;
 b=zTIFwPWwNNOB8WwmLfify1r08dAzly9RnAN2nUABqs4fSFRm21xMemSF6bGc1PfhF4bm0IEq1SEFhNq4tXJ7051PnFA/xxFA87GnQ/R6QWsszpToIbBK3m1MvxdVJsvHJOBC9yp7UWh+nWKVg9Eesn1xdQ6zWg/Zjg7Nj7AbSeKoJ9KB4Oz6mIbczUBHiTeSKwj/0gZ8xC79tuXUFraormGSTzQlLPEI+tSKw9fA7liZKd68FYxID2vn6gS/4sI4cJVstzNL8tijE/mUtJwvTqdHxsTm3J/RvBQzSfKUOZumwpF6fTKjB+FdwftDZDI1KFOZRfrPxg3+7DGtHFb8Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxZhR/sT7xzje4hE37Fe4i9cMyEDu/51QIZYAHGnGq0=;
 b=S7DInRGpa0Qy/OKhgzkIp7YYm/Q2ycaxsKS2bn1BmDOxrMeuXeottqX7TvEwjuej3wkPMZwR4QW2BcR8u8Zjz7PQz+q0r+hgJXXPduP1xA+naMSJ2xQSZlPuHjSUYozog0sZQoVPKid2CozHRw85lf1s+F4UVEYPFa5Q2tm+wdtI+F+Ate/CEQt7RtXODUdbvRa9xhE5Dewj/rQbGAc0dgA0e5Q9Djfw8X54kT3yvuQcZIUAZl3ERNJ5OLHoyZIm0tSIM7Tavm8FEJsiWy+FqzWQnzWO3l6QmjUt1kITwbKuOv3YHF/2nWqASWClSftlcTMPoXIB8CyV4bYeKpXXhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by MN2PR12MB4319.namprd12.prod.outlook.com (2603:10b6:208:1dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Mon, 6 Oct
 2025 15:01:30 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 15:01:29 +0000
Date: Mon, 6 Oct 2025 12:01:28 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, kevin.tian@intel.com, jsnitsel@redhat.com,
	vasant.hegde@amd.com, iommu@lists.linux.dev, santosh.shukla@amd.com,
	sairaj.arunkodilkar@amd.com, jon.grimm@amd.com,
	prashanthpra@google.com, wvw@google.com, wnliu@google.com,
	gptran@google.com, kpsingh@google.com, joao.m.martins@oracle.com,
	alejandro.j.jimenez@oracle.com
Subject: Re: [PATCH v2 12/12] iommu/amd: Introduce IOMMUFD vIOMMU support for
 AMD
Message-ID: <20251006150128.GU3360665@nvidia.com>
References: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
 <20251001060954.5030-13-suravee.suthikulpanit@amd.com>
 <aN7bDNTAadHI/+qn@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aN7bDNTAadHI/+qn@Asurada-Nvidia>
X-ClientProxiedBy: BN9P220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::30) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|MN2PR12MB4319:EE_
X-MS-Office365-Filtering-Correlation-Id: ccbac97a-5ba5-4d12-a2b0-08de04e93aef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AIq4usR45V3Ws96TVR2L1PwcboLGqdgWtlA3Av6+Nz9HqWytqGyyKmHl6blB?=
 =?us-ascii?Q?4MEexyYSas5bak83R7HOH6C2arcglSmm9qsKzT9NYnVF4njVumIYhRYv1cwZ?=
 =?us-ascii?Q?QlfvfyPzHLWObrxyMtqOH19LUfGBWGI0m+2vj0aBsO1btdX54sSNcmionGus?=
 =?us-ascii?Q?VT0LVHncr+DGhEagHuUZDHYntBRR4xlweJ1DLsDSF8wCygMleboIUOs8llyA?=
 =?us-ascii?Q?X10fGWsCClSxOUdyXROpwxKqLhBulnjRlhfr3c/8NSux6PGr4zmViFDVvWu1?=
 =?us-ascii?Q?XjrWyJM7XORqrG09SCYU39ybrXCedfcjO+/ikZd9diWXcJ5TDJiRhNgvMpyU?=
 =?us-ascii?Q?1ypXkaqK5e6VFJcJj31XZy3y8uchhfv8uic7tazAZHSXu6/RorOrcxrQ/QjR?=
 =?us-ascii?Q?HeVTVuw6KL9Y7Mq7ZRHYx2FIy6pTRF9Awa6byDIB/hlsa2pzng4yRtlBIyBp?=
 =?us-ascii?Q?kkIu6bz49TmQRfVflcUmHLV5AVFxbuvA3n1R/9bIMn3qbaStrYqCK1CFf6qS?=
 =?us-ascii?Q?ep0KSBijAF220rrSIHQDNi/3RScMf5tpikLg+PFLMXvTJ37kT7UH4iOIwsY3?=
 =?us-ascii?Q?lnagfPKicA0ReZriuJMhkX1L8eP61IeRuZXHAX7wq+AzYq/ZIMF1e+qoDerH?=
 =?us-ascii?Q?EBooEm23MsF9wBDFx/7CRypREmPrRhtWxybiPcg8xTxoFTMKYwDOOaGR4yN9?=
 =?us-ascii?Q?ZcwcUMJvTZeuR6e8aV6CqWQtO1g5AWqmeqS9mZPVgOAgQhNvtf1ItMmV/nYz?=
 =?us-ascii?Q?Po1OUy91/9byhlDNv15uBiBH+4n0EUr8sYR/aiYltCVoV6opHRkF/oTGfWke?=
 =?us-ascii?Q?Wk/dk4IXCyKr9SeXDK/55om1ItDM3MY/rjuhLkTn6MUQzVLXMIe9YTUlfEkZ?=
 =?us-ascii?Q?ZbMm5H6PfhWphpsNJpmul1RmaBSptwKPR70aeSn7Cq+43kGY9EenjWIR1axD?=
 =?us-ascii?Q?SLT+XUUdc88ejv8saSB2PCwQbHjKYwofc+xRP11am22litnBNCHJH3mNfe96?=
 =?us-ascii?Q?Um+RIZyrbvQnAncHuVx2jXWVbNxABhQAfwdJG7r32lAVBAhgPGtEIPc9PBpM?=
 =?us-ascii?Q?6pTA+GaFXtY77LaRLOeAuLY1F1tGo3NxWzhvJex9CGEFI6MKiefyzInRCnIN?=
 =?us-ascii?Q?hfchgbRrG239dholVWagb2h3ZXhLZyfhuaAKWnJLWRRoZYoZGUeUdn4Y9K6x?=
 =?us-ascii?Q?nxmYLT60MFfgxfQkylBSG+s6rrTumbck+INsK5Q5+TeV87g3qITWl8AuHBeC?=
 =?us-ascii?Q?yi6tnmbMWKkGG4gtEC1wqYR8Sl7ipRYoqANTEtL374yVjtCC/QsjYxB9jAiP?=
 =?us-ascii?Q?zarhuhxeX/m7uHlf0kfmW9rLFyp7wMWrXyJV9l920i4EgACqkCZ53BEYv9LI?=
 =?us-ascii?Q?jPSXrVHHhgq6snrE1h7v2dA65wF9hsbsALwKFLq3mfx/tJsiWpM0JcZM56ml?=
 =?us-ascii?Q?ewKFb8Dm3CmyM7HAPZMi+ZQje3rXiid2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KUWIhez7eWY+cHuoZKmzmmzZzWOTyj6jpVshpd8mTbdtLUORt9ee3kXbbJXg?=
 =?us-ascii?Q?wsqHmlT1BRgZQz6IVBiYM1F3C3crsUclMZHGDZyBeTW6leLMT7cOZR3DrDSj?=
 =?us-ascii?Q?fH7jZ27qiT6hcNb/90Sc+5z9dy5yIiNR3Gye7ZBLln8ncvAgUyiuqCv6XJ0v?=
 =?us-ascii?Q?TnTFMIwj7hEl/gD1cYifE01MQ8kaDVVWdighAOSpDjZhw07E8QAJqE6gIVnl?=
 =?us-ascii?Q?/fIwx3YdwRvyIhaYjiTTrt3WP/s6/XZkRhy3FGCom5iz4+3XCskpiIiOhETF?=
 =?us-ascii?Q?hbW9oXqpI3qy2OqdRksG9YNZfls+UDhj7dChlsxXWSt92zjgIMZbiyLhkWSu?=
 =?us-ascii?Q?jfFg8Fiv54AoM/jSYdaCAxZaxBbm/9htGwgcXWCPOp7SPNURR8BjjhsyUX6U?=
 =?us-ascii?Q?w2m6WZ3ERNroQm/pdzkPOiOnGKPQHH0XEPsjHvAam+F0SLc5F64tg9/u6Pdw?=
 =?us-ascii?Q?boxA+fHlmQtgnh5EPLhXRLduaWr5myJcxO5ClDkFoRRnr50s5sziLWFUW6UO?=
 =?us-ascii?Q?Nkq7oRLgjD9w9orobhBbtF2rUf0j+zDoma2Cq3Fh8l3cmCTCA5N0jt/ht7W5?=
 =?us-ascii?Q?izUBICpuIAKA8cKub5uE2gAkPnWINVmXhlEw9QRsVr8z6p32UZE3LCSHQMMg?=
 =?us-ascii?Q?0i4cKmvCY8aebQ0Cl722Yluw2ZQjv+AfQVL/VEZdzP41EnRvhUckti8H+Ezp?=
 =?us-ascii?Q?JbqfXzwTI4JW3sVQYN7dAVsYeQJg3wBXfNpvxfAstpxqq7IBjg/1sjWn661W?=
 =?us-ascii?Q?bTXHRUMTRDLF15HnHen19shv4QA7jfj7iVKRasb5U5lPB1DoReQH/NYwoOF5?=
 =?us-ascii?Q?0Cm2xpjWesnspJTbn2N6CCLQVQH4D2yNP+suNL4ATsnUzLNI8CzSth0ScP+v?=
 =?us-ascii?Q?eEiejCcXwTntZdJ0Fcx22/22OE1P++05JGgs7Gkk8JfWOwOAh76wGzIvwyz5?=
 =?us-ascii?Q?KvICetVUUaaodUnLMigYbULR/YSJP0x4Q/BoYOaMCwJHd/DSl9tzclUN8pEL?=
 =?us-ascii?Q?dkkymWv5mpRWdwpZuJneo121ACZbiGt48Y90Vumlf7CqOPQcj2ftf3sBvcGF?=
 =?us-ascii?Q?YSRnHDEIsak+XkW7/RfcSFP68UC1sqA7ITcbcgJ3NxTW7LI+A276VSHQoRPe?=
 =?us-ascii?Q?jmAmecrkbq9MdXClE4LUvQ1pifKxj1eual3f9sayjiBBtyADEdC++qoZLQ+y?=
 =?us-ascii?Q?o8sKPeapdo8KXXJmKU0QdwdPkuj5d4ED+Xvo492ESqI+304L/nLf7qXyV36Y?=
 =?us-ascii?Q?qYZTCJw1rZ2+7Jl8kRTjSx1VtLAK0UFoBlZxhb6c8l95h+V5H98a4NfOlKfJ?=
 =?us-ascii?Q?WgNFfaMUdsImKIyy8FZ0PlAIJtjRynhIhwi+/mqSsmb1NX877EtVPsYFf+Q1?=
 =?us-ascii?Q?ZeHgrZ5FJ5IJDC2fZv2Y1mtGiXK50LqTra/8qAht1ogdzVCRlzLMEUcRIQpG?=
 =?us-ascii?Q?feS2uflzcA+fr2U4XH45nldiWOkjAmInIt19W14Gs1EtF9TjwuO/YC5P6PCy?=
 =?us-ascii?Q?YYvtOY59LVP5jjmw1f6HnbSCkofhYWZpxHJCSORncSjjymeFZhH4qyRyNFRY?=
 =?us-ascii?Q?gguCtJhC/o416Rp9pDg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccbac97a-5ba5-4d12-a2b0-08de04e93aef
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 15:01:29.8102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Taxs/2k9y3r6xsKv4A1HCFyEjpmVFpocs8PmYklLFk5NRxQaawCZc4dX9KlmnZCr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4319

On Thu, Oct 02, 2025 at 01:05:32PM -0700, Nicolin Chen wrote:
> > +/*
> > + * See include/linux/iommufd.h
> > + * struct iommufd_viommu_ops - vIOMMU specific operations
> > + */
> > +const struct iommufd_viommu_ops amd_viommu_ops = {
> > +	.alloc_domain_nested = amd_iommu_alloc_domain_nested,
> > +};
> 
> Unfortunately, a viommu_ops with alloc_domain_nested is incomplete,
> IMHO. If this series gets merged alone, it declares that the kernel
> now supports AMD IOMMU's virtualization, which actually won't work
> without a cache invalidation op (SW) or hw_queue (HW-acceleration).

Yeah, I'd move this patch to a series implementing viommu fully.

I'm pretty sure this series is OK as is without it, but it would be
good to at least share a sketch of the viommu support to be sure
before merging it.

Jason
