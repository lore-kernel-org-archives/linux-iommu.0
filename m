Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADB623768
	for <iommu@lists.linux.dev>; Fri,  6 Oct 2023 13:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eg2FMSQ1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/u3CTtH/0xmtgXbVUTjKUkrQnv4Z/61DJb+Av5VuGH/ppkwGkOfjkH6K6RP4ePawgs0qD5IQbM6x0bN1oqMzkAK9gYglpulm/lov8A1JeR5DT98wjy1iJDgDoMiNIpwa9HLNy0iQmDhZOoogY7+3apeP+tatKB53YOtGzKriV7wQvwNMv6K6uztYpfLIOex6PZ3EnRok2GbsKPFNcpDHBmccjoTfIb36+dyKeyW1//JDecS5vhXMD/EhbwFj5Uu9GrIUxyf20GXChvp1vCnitlIPcqpvUQKNIttQaPrN5mJOyBqA4IuQNSdnE8qLiAbHNfAdtaPv2SzEnx8McNaoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcP8orDJ1duqcVJfjxv/6DLcRvVOVhHXKIXgjRzzQQM=;
 b=OQU+y8m8HMMfLbrnO1wpC67Seq7cPB4RMiqHxM+vJEPCQEwK2Vf5lF67t3QO17Avr+429evOh3Cibz8DugUoxI18yzg6lphlP+vbXICxCbEDYAAGrA4dqKCBcoHFVS1LJQW5ZaZiq1LvMrJhgLmKizzt8mCi8XjJDdzj7X8j+x+jmIJpAxji23oDBZxW03vTlel2DOxbjC6mvUBWnjv4NgO7edn1rE7ZwqCIPWgysnrObEqebNsobqV2BfiC1Zwf2XIkap1WGuXI80MoHKHEfgl4Au2KcuPZIdRud3+lnhxBZnHsuGxcPC5L3YCpFiq7ZjPnAJhAJpyEbFZUBmLHVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcP8orDJ1duqcVJfjxv/6DLcRvVOVhHXKIXgjRzzQQM=;
 b=eg2FMSQ1FMMBbHKtfAnFF3gRoAnhT3iAn7DzWhfcbjzfcn5WQUZSnBoN9v+sV1shLiMtGsSc4+3AUJaK+zqXlh9tvLK8xVrK8t8H+WSc2WUD3+z7w7uliBJRbKaCjPIyf5Uesyt5NKRBwgVQI0hIH6cr52mICDoOEZy/cQ6TQwHlJkUxX8TJxH/K9oML3l6fEB4UalXfY0hUcNidIhFaGjaM8xxg7p0BxLDdxSHWnlzKXxY99dglbmcnqphID3vARGtSoblq6dfO5w6n6ITIIrSLgjaUgqUO40W7fy04slle85HY+a675ut1w+uo9rKUi5mfrt8IJ+nMh7zVCij85A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CYYPR12MB9016.namprd12.prod.outlook.com (2603:10b6:930:c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 13:53:49 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6838.030; Fri, 6 Oct 2023
 13:53:48 +0000
Date: Fri, 6 Oct 2023 10:53:47 -0300
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
Subject: Re: [PATCH 4/7] iommu/arm-smmu: Pass arm_smmu_domain to
 arm_smmu_init_domain_context()
Message-ID: <20231006135347.GR682044@nvidia.com>
References: <4-v1-cf5846854f51+6db3f-smmu_newapi_jgg@nvidia.com>
 <db259336-1203-4d12-ac80-3108aaf5ec82@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db259336-1203-4d12-ac80-3108aaf5ec82@arm.com>
X-ClientProxiedBy: BL0PR02CA0051.namprd02.prod.outlook.com
 (2603:10b6:207:3d::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CYYPR12MB9016:EE_
X-MS-Office365-Filtering-Correlation-Id: 62210382-abbc-4f7b-5709-08dbc673aa8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wSs2pjOI/MqI064A07qgh5rt0GZsQ+VOyF3cOASbcCpELCdykPrcgYkIv8h9Bk+iC6b0MPg7PUGxZrc6wiVSj5UymHH4sZ/+G6zDrzUKCDWZZdNihR4KX8KhBEk6PPQiBRYKP8ITb56ubPfjWnzByWk7936l6UHBYviz+x/9uKsIHLEfpDdghbhOEiD1s29Fj+fk34A/pxobrFxZ3ZEw4QMiWeHE7VthVgI7MhmyFK48yh/ncAlJD4mDYql7Jst54bqm77ZwiYYUqaBgMf/qbSUworqf31tkB/nduutnThHZExhSRscHgK6HJ6gcoHyz3XQj3p+0wiIe5vCBlzUyyp/E7dyMjFq6DFCrxKBBaeCa0b3mBxBDOHyduQj/m947+tkq2TWG1Z5QT7vtkemZQnELWvNhEFg+SfgAEOBThF1nubEIoG1tAysurUq5lFZhQXMfHRYZ1fsD6RB6VO/5CHIuqmNr2m6MYhTOx2/v3EWoyjwyA9z+Scrdq60iV46WsWdodPuyFPc0yawRwLlnW1TKvb+ZSACOlx84O8KTN0gGzyFk/VPjoVHaaXXuj8YoYheA0bfTZGhmmLuWH33EJlN9NTiwzfeajqDleVVKpGY1OGdCNQSLvGQd4O+k5vXg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(376002)(366004)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(36756003)(41300700001)(6512007)(6506007)(38100700002)(7416002)(33656002)(86362001)(2906002)(83380400001)(5660300002)(4326008)(8676002)(1076003)(6486002)(26005)(478600001)(2616005)(53546011)(8936002)(66556008)(66946007)(316002)(6916009)(66476007)(54906003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?exPBbw0b+/O/BgjukHmfMuMWxpmNGyjtOH4hWUY/ce8WGEpa4IcDKseWoDsO?=
 =?us-ascii?Q?92lMf0YuBr48g/qrHVfWMwb7evQbs5s7X918rjanDHccE2HDFUiWvNt8U+jh?=
 =?us-ascii?Q?FJ2PaWTIj/AedHDsOjKq/6wUNtcoFT5fQ0KQwAhdAbxyZ32sIHc3lQcCAWi5?=
 =?us-ascii?Q?TfGIR2xEcKn+YqThcO4pYhCr2hFjCbaPDIt82kw2n07oXc4XrbTjPGRprZAi?=
 =?us-ascii?Q?dHwIcSnrSRuR460oo2kgoj3i0ooU7sSAeaCShybQ83FtW1SFuqwUWEk+OTRh?=
 =?us-ascii?Q?Os5xuP/X2DtXA2l0tPrSxZINak2YJQZijco52L8VMxeBljIH3xaiZ33NRInq?=
 =?us-ascii?Q?n8LmjjpmhEhAuQOCyrsYBq61+6QWSkGU6jM/X31C5uGH9svtedy5+4VqOs2z?=
 =?us-ascii?Q?Zm0525aUuiR9OZKBXoS8cBs5nNtymzIE1BIJp5XnoA0LmOdkJeRjjS6tM46K?=
 =?us-ascii?Q?+vIXxDtNMSUgsna+xmX0bYJr7sRl//E0Bacd2xTAQERFqxHIySmops24uQuV?=
 =?us-ascii?Q?Kb7Vpnb+vz7f0gl2Li5kF3ObSCgIsQeA7l5irk3gRE//hopQotpXqV/lZRC1?=
 =?us-ascii?Q?IXrVCnyz55BIJndiNT98MhDfE/NZdOrFtnhWTinhB4CwinsaRRKvYXWE74sm?=
 =?us-ascii?Q?aoFRpZDC5LXhSq+0R9VvClcIMaknompETkA+AKpIJjQ06RBUB0kJIN3zghYz?=
 =?us-ascii?Q?rKZUoeHcVXVpcYWJmqjIYZhXVfzogtuxnGzHU1sYoq/rf8mjK+a8Xn7XnllD?=
 =?us-ascii?Q?wR0156CFRa3kjmFk/defvuxJt5oEegFHxJsvlPEzr9YYAVezYZJmzC4U8K6C?=
 =?us-ascii?Q?tu8t/EuRRv/61lizUQ8hJlLTCmugKzDENRwHUUU8GulRv6KNQIP9RSK3Z8c0?=
 =?us-ascii?Q?/Ngr3f/yW+fUPpC3XDOLxzAa8aIYZeYTzrclBNYxYmECBqZsGb7Ca+GxdMdv?=
 =?us-ascii?Q?zNVzf9kxlH48jk8/GMgEOqmQxzbNEqujOXYU/v6+Do8mw+cemAcEnmz1rphb?=
 =?us-ascii?Q?OKT9BRV6MHopE5qltQ+GEMpyQY55OHf/OLe20aFUi+cyKJ/TzFA9NiBi8O2t?=
 =?us-ascii?Q?vrgQieEq86GjxaAsYJ9lGbDm3KmB04E9hjGsFWzmD6PkJ2Gd2MGTIrUiQRzB?=
 =?us-ascii?Q?8RsfMFnQRaLRwvIKhPKX0KCoS93dKCcbA3ek1n/uJztNCEVkhi+yyC6CK/cy?=
 =?us-ascii?Q?oK+3M8UkQSfGw0G3mXuW6ovLTO3YMGTQk5WZ9XCG6MIhHfrUVno4zfCzmOa2?=
 =?us-ascii?Q?9mD7+LY/IwlsjKJJGEYL6lfyZOXXN8QDdnwh54r4gOIubsCa0gfwgPVAEMOV?=
 =?us-ascii?Q?MF0rrLBkotpm8Ffhg6BwGLToaX0ZRkXoFwCao3MwzuLmvuWqrE7JtMe5RXHQ?=
 =?us-ascii?Q?MnDCZvwp4rFQwXGgUDlacDy4ycO1CJcgUBafquKx5VplMV3mD+XHkQw8vhKM?=
 =?us-ascii?Q?s4zKYgtIxdNz0Eh5fFcBYHyIYQyG6Q4PGG9xIJ1T0XEinHKgVIQzWIj7TYe+?=
 =?us-ascii?Q?NPIfqcJb7MprWXFdjgUvYCxubDaNXaY8E8Nqg5TmGy3JeCd6EJm1EO62nlNA?=
 =?us-ascii?Q?FXMUdFYXYpJKikavnvIP5u0UdROfaOwcll7Uu+qi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62210382-abbc-4f7b-5709-08dbc673aa8f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 13:53:48.9525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gyRGsNn3ZQP+20oy+5N+01GvGlM7zWRcZT73Vk8Gf1MVHihbu4I+UIyNfpSv/izv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9016

On Fri, Oct 06, 2023 at 02:43:51PM +0100, Robin Murphy wrote:
> On 2023-10-05 19:28, Jason Gunthorpe wrote:
> > Instead of putting container_of() casts in the internals, use the proper
> > type in this call chain. This makes it easier to check that the two global
> > static domains are not leaking into call chains they should not.
>
> Is there something inherently difficult about to_smmu_domain()? It's hard to
> tell how the aforementioned checks might expect to work since they don't
> appear to be added anywhere :/

?? There are not added checks, this is talking about static checks and
code auditing.

Let's try the commit paragraph again:

Now that we have IDENTITY and BLOCKED domains that do not use the
struct arm_smmu_domain it is important that to_smmu_domain() is only
called on iommu_domain structs passed to the paging domain ops (aka
default_domain_ops). Use the more specific type in several call
chains and remove the few to_smmu_domain() calls that are not
obviously in an op call chain.

This makes it easier to audit the code that the two IDENTITY and
BLOCKED domains are not leaking someplace they should not.

> > @@ -616,7 +616,6 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
> >   	struct io_pgtable_ops *pgtbl_ops;
> >   	struct io_pgtable_cfg pgtbl_cfg;
> >   	enum io_pgtable_fmt fmt;
> > -	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> 
> If at all, I think I'd rather just flip this to a local "struct iommu_domain
> *domain = &smmu_domain->domain;" and avoid the hunk of churn below.

Sure

Jason
