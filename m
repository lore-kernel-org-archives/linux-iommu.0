Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B537C7471
	for <iommu@lists.linux.dev>; Fri, 24 Mar 2023 15:42:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKXrqwC9FmjnCXUKbt3A2MnHEHHKdRrP844EPyweWyTDVevxUCrSeQxkqlvumWOZhLpN3kbodx7b4c0i+BClqhjM0vS5T4VfxyKebruoX57T8QmSVgFYX9FOBMYQGQ0l6IMxIG/A1zcwcDSgLLZBPX0GzJvA68DfibU19hviv1BNmjjdJ1qZjTzGZSWEUCj+9dv2tJfjyU1gaz7qNHJ64vM5cu3rAMWHf88NHgLfFYDzPqUVaP6odauplhSnLaVP+g6qrN3S70ZwK6BN+ccKAvPmlytFsqIs99nSU4K+RvPTkmozIpqxN9ZOGnq9t5gdELqyHLLEBnxK6gHJjnhCSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFIfmgxcBAuVcMB+FwBup1LZZtK07erjRQA+ks778k4=;
 b=VixYUcj5cFzuCWCQ9BRRKIrRd/ADyaDJ8rghb1+BltnYvnBryj2N3xx+FEEXEAwOzHKT78fHQ7I9Ux9z5IMZtVrFVBRDRnw68nl8YiyPEJqPHwDY58kSuqdMxUrUnbtD9b2rjQRkP8zY17P+Qv5kYGRkJLf8i3Sv1DllL7xSnFblvrV2gYc9jzhjHDIy83Y4e2wyQjqTbK50RCRpySNdkDeTjCxWLCCtZA85Tmgs8qnrMHLbu7cVCQMfmz6f7asYlIw7hn6Zs4MwWJVzDuKVl3Vng+4e1zr0HQaWWePWRujlB8xlnat8Rm6P8df3ghhkNE/t93eRud+qFibCBtNueg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFIfmgxcBAuVcMB+FwBup1LZZtK07erjRQA+ks778k4=;
 b=BR1iqGvfenagLWpWTHKJDU3x3EawNYd+CV8GcDKq2ZSrZHVsMAaaPwTCi5X6wjIKwWaKM7oiHXmhjgkqhLBdpVcrby/nrrgtMB6xpFgAFdIPYWUWxl1rQKTxiq/Fj8/8TSFBLuK31YFqX5DjkfT6eDNFtvIV1m2OZpj0xtzr6lfyLCmtb9EoEhCslRPuqHTzeMcJS20JMpExQjgjzQFM/ye4ZC0iO5rGouwqHxOt5uhS+J48PME3m6yo3YiWAgdbVPRUiBTfbPf9pVPQGrSNTVPJnXTwyyp2nDU1/uwB/ixUmlZMGWnCDHAnWSv6QltD8ujpv1YswDzpl8tPKK5Bpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5270.namprd12.prod.outlook.com (2603:10b6:208:31e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 15:42:10 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Fri, 24 Mar 2023
 15:42:10 +0000
Date: Fri, 24 Mar 2023 12:42:07 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH 6/9] iommu: Fix iommu_probe_device() to attach the right
 domain
Message-ID: <ZB3Ez8pIENCHhDZu@nvidia.com>
References: <0-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
 <6-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
 <BN9PR11MB5276832381FC73EA5E8C05428C849@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276832381FC73EA5E8C05428C849@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: SJ0PR13CA0183.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::8) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5270:EE_
X-MS-Office365-Filtering-Correlation-Id: 3629f41d-e539-4ea7-c84d-08db2c7e54e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WswSJwUqEgiSscEpsKR4jISaljsKlBm+peGCHOQW5tCPBAvoMCsuGDoRqUM1MnztCawQ9epfV8zMqmh8h0Cw5Iln9usrOP+/lY5Yipk32BcssPCV2V93yy+Ep5qsKSEdjKdEyskrazcaoxf3IQrEIljP1uFZ7U+V+TeHLcGJaWFJVwqf+eRm3nwIZ9HWFUuDylF95HNvCYFuDzWM0tr5MCmbZpgaaTT+txuGCpiseto1/uMaTSPb8xRog35Bin7v7y/AGkI6TXJCPDL/+ghLf6YWxGQXxoYHzihzL8HMLLfSysUU9jwI3AqRTKMyru1icKhAMBQKumCSu3JKg+r0MQxow7eXt5ERz87r4yRTS5zrQDzJwZaQzl9YSgSztfsUtf2GuRWY5Lqk4po4hTcUYeXFfp2hyrxC/h6Z7OouaP+E/xo8a8gSWgUyVDE+mqIMdVZm+o/TvssstBFHMHTrbx540DqnAK36SabqcazgX+J6d3Eoust10MqhmvDb+8/2ofjZaUqXXYjZZ+n9LuPFbrH5WZPmUM02n6c4+pJaZRr3Wy2pypThYEsQaIaGpPck
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199018)(41300700001)(66476007)(5660300002)(8676002)(4326008)(2906002)(4744005)(36756003)(66556008)(86362001)(6916009)(38100700002)(107886003)(6486002)(6666004)(316002)(478600001)(26005)(8936002)(6512007)(66946007)(54906003)(6506007)(2616005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZK0aIBVhpJoj/dbsnlLr4mEnDQr55SW4ZU6zSNegkTgneoREFSK5bqgDn+oU?=
 =?us-ascii?Q?ax/aDCtFayKEUCH+5PyRhhBIJEAEFZW8xW9v+v/MBnDTjBRgQ2PTf8oZNd9D?=
 =?us-ascii?Q?aiRyE+7amJUuyDNrUSA52OU/oYkuXLLvImMJfI2J27a3csd7lf/T0zOPrGbm?=
 =?us-ascii?Q?O8fsV9LiSxYrNMHt+K8xytoquNXLyUtpyBrQhYvKF1qcAUWCOXCvN+kNNA4u?=
 =?us-ascii?Q?Vh1XmZ75JglVPzYBUkA/PXm+1c7AA4CRd6bjuwlf3fwCebXqb5LXSQ1DKniu?=
 =?us-ascii?Q?9HNCziafrddzYpbE1rdOG9jEc15HP4SGXe/rE95+EdlaRZjL+yM9cecLP+T9?=
 =?us-ascii?Q?j6Dlb8HpfOObG1RC75UEtPPqi8H+k72bc/7HbxCjeBW/uJYdzaI1kxxZfhAl?=
 =?us-ascii?Q?kZcYnv2oO02XvO92ItO6/oGVm/s3BZOhVnJ+cuZpKbCXJi570Q1kDNIFgyqi?=
 =?us-ascii?Q?jXg5DxEoXCXaRI3l7FF7VXr0YmtEeMg6jiS+jXoe12ayoPtoqmdToICn+N5f?=
 =?us-ascii?Q?9I41iYd961epcjwgxsDmxF6DWYNtRDQnhNg08WTLRWciSq/Z3nsPl9J3iG+J?=
 =?us-ascii?Q?NqeUCtArsd0y3n7inDhKO/gKYjv4qLq+v3dLkozFMJPn9MYbg6RYEYE49Pp5?=
 =?us-ascii?Q?6JtAgxtLjSEb25Xa8+p0OtlzdSDyukK8ilByYmNL9cxNvqEGkamVhaBspar3?=
 =?us-ascii?Q?SeSHGzMcj5b/3n8XRUoraFPG35tfi4P1w/s183J0r5mqXgTJNvMJR+djyiKP?=
 =?us-ascii?Q?+n/Ng1lXZrkSZQBLbQ/2EwGX7LxTu/IEw6vtXds9gWEnXZXhuXMvhYvBVV4E?=
 =?us-ascii?Q?1fCloimwHvtj8yxzrOmqfGHReS6l/M5JO7rM+gldfCmsat/mYNMesvTlR/PL?=
 =?us-ascii?Q?SBNidsf3bubfT+1rH46hC5Dg0CNZw6Lb74+n/AHd0NfXXliNJO/KssaHw2TC?=
 =?us-ascii?Q?LeCD29Kt+cuGD8h2dM2Ynmd5WwBfbRM/axt+F8kIVgsdaIijRxIWjxrLWU+K?=
 =?us-ascii?Q?L8Opsvzi++zxEEkPm6eZUpf6L8jTCLNONr/kLOEFC5YV47zxg/suViUc6phf?=
 =?us-ascii?Q?nyKn53XpuqlnBxabjTL6WzG3w4U5YFhcnmx19MtjP9OQshZnCVEBNIKah23e?=
 =?us-ascii?Q?Fyu6m6wJwtMtUqrVAbDI22jlgxXT8CePigBQgAQxhXubbBapJioaRtX+ru6W?=
 =?us-ascii?Q?vKhVpvlweqBkzoPzjDkAgBTS00x/q1nIB1AE6GUVjObpmsfn3KFdLjy4FREZ?=
 =?us-ascii?Q?OnMVdNs7PRhdcqTERwXetqD3YPRe2QthhldKVz7kr9/oOpF87kWHlsIYRQ77?=
 =?us-ascii?Q?xSOmmuoDU69aEISvtLMo/cukISbpYe5gmndvSvQSu1AxaixxQAOPKB3ixlHG?=
 =?us-ascii?Q?06V9LKJOE4bXCjITVruIFslfUH4iU8ftYdTvvqubaev00VJGpDm+APP7kDUw?=
 =?us-ascii?Q?mNIQt4qLKV8JxKomOK+Opc7adX1uo0MtRPKHHOOKAnA4mxgE7J6use8Ucdij?=
 =?us-ascii?Q?AbXeiuv2hv0Khcbv5QOTu2jvUk/haytRkqn7rzfLRLNoOQpLqM1faCDQTV/Y?=
 =?us-ascii?Q?1X38UcBQHSNB0Dx9bBBIJ/wvvRlC0I9cOIilINFf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3629f41d-e539-4ea7-c84d-08db2c7e54e3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 15:42:10.6334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ql4adSXD7YDV8kchM1JZfDBTeV0uaTmX3mBL9cB1Q3b8CKRGqmC5QjZXGyk0OXr8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5270

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

Yes, it looks like that code in iommu_group_add_device() is
nonsensical.

I added a patch to remove it, and maybe a few more patches to make
this less duplicated..

Thanks,
Jason
