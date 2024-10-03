Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E0A14F9D7
	for <iommu@lists.linux.dev>; Thu,  3 Oct 2024 13:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727961321; cv=fail; b=Pb5Bl12uPYpSy600hqryenGGgSIQu3BVdXAPqMIh5WOIQ9tiEbZ3T1BO8SQ+Sc3fNRu9YzoIbhLxgHCbOX07lRzua38Y+IuF47S5TND1Hp5M78pSNm9n5zvqn+quTJS4YaZYC7qhQEsfH9WqEQdBMIeVahavjKV41x6PIAytHhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727961321; c=relaxed/simple;
	bh=JupslT4YZb0nod5u8TL3/pfBTwaj83brN1kqe0DdvxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FufT9ppbrY3nNN5jgCuzo3s6Pn8k/yMG6tVRoA0tAoXUSjsgHqyji4mViqot04+vh89TKUzjh2btmKtIIixorlBmjSMR3+ARtI2LvJdn4CyojYncDgXEE2bHE/LvOoCR8KvDtJIB/bMI+o57h6wJG233HDUgxsHPURleUiWNPMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xx944N2/; arc=fail smtp.client-ip=40.107.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xx944N2/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dDF904wew8OUbT6rE4GJLNd/KfuFyGkPCMF1I3Cx1t8k5QqOS7v2agZBx0YlK/+JSvcXCWRIGoH3400gxVZNOs08RxvMm1/g0rk770JxLXXSfOOWasBbMQP5XSqgjSkZ5+yVtlH+5qboVnKODVDGQEGEVhJ9m5fQeMFkop5XKBXXDvRCxC/IJgHxj4GIbzPOvApFZ61zhStjRJNwksKf2qSIW4NWUuO8vOCYX61Qcw+tptXZSX5I5/vlg7hiuivaOrBj05eTXWviXDrYrzYekD22VvalKLSZz3ahaGJbVO90ruDsjRiD1jV4WLSl8C6fIyfFy/iAMSTBhhTsELlHNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlCqhJfmcMeA+y7vnJ1UO7aDpCHjEienPdctiqXwu48=;
 b=thY8kI6viPuIuGlQvQnJToVdY5bRniYnJfcf623+GpNcp+JfJA/mg+PP3BIk0+0goUAZlt43yIY303Y3kBVLlDOow7crqnNhGDIyIXqcydxeZOAHoQOvLMgXMhMEcynzMnHSOIeO2XXVG/X3nQxlQgchNdSspm+Hkp89o4oyYqw17nrDmNOdp8dR1RtHYkgeoJaNUQndFMhDKrRrV1lwRDQo7ehpS3+WKxWyFmlt0VztIqCsfoIyzeNeosrct+8vCoPTmtd4ISFIoQVcfYv//H+M3aOrGLqFHJELa7SEOqx4AAnJCkxgyaGBSkWDYCv/TGHsSxffh0OREa2TPsvxJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlCqhJfmcMeA+y7vnJ1UO7aDpCHjEienPdctiqXwu48=;
 b=Xx944N2/z7CS1ibystVQEgEUgZeY+sAkZ6VHE3741FesndiskmRCr6MY5VHjdAyJx63UsfHxUuHqg9ubLzWB5b2gd1klTrMD//LoUj/FYmJJz/A686ACuMgDybgKCAEaYr8DfXsDTRk06Zt+krEIh0h9blEQBDpvHcJK/+aVcC/DGbMBSfYtKE0fgh8N38auzrvIiyjy3KkGamrHD/Mz2PD7tWWADNw/fSUQGl+NByDvPiWHWV4OYgEvXpjLi/Z+LNVHEDvcp4JxTtp0p2fzU4DVyBjIRkdVslSwf0g8x/9xOVH3ne+8zAzBpYB+1gln+4syRzPn4WlgrV4lPWVYIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB8842.namprd12.prod.outlook.com (2603:10b6:806:378::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Thu, 3 Oct
 2024 13:15:15 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 13:15:14 +0000
Date: Thu, 3 Oct 2024 10:15:13 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: bagasdotme@gmail.com, kevin.tian@intel.com, corbet@lwn.net,
	iommu@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, yi.l.liu@intel.com,
	eric.auger@redhat.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, baolu.lu@linux.intel.com
Subject: Re: [PATCH v3] Documentation: userspace-api: iommufd: Update
 HWPT_PAGING and HWPT_NESTED
Message-ID: <20241003131513.GY1365916@nvidia.com>
References: <20240913052519.2153-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913052519.2153-1-nicolinc@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0228.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::23) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB8842:EE_
X-MS-Office365-Filtering-Correlation-Id: c806f830-734d-46a1-b707-08dce3ad6b27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MgL7yy/An64ykePyYYhyTlqPfXgWQs5oJxetZnuETJU+XVU+04jt64/918u1?=
 =?us-ascii?Q?iME9HiZ+K/6SBz0dFbbMaNOawCOHYV62Ry796EWcl0Ux56/WyDbwvzGZ7Ov+?=
 =?us-ascii?Q?on46mnLAcqlY8KpAl559dq6GuRQRIj3rineXAYhwbJrqniOhWzK5rj5qWts4?=
 =?us-ascii?Q?TeyOVkb6Udbp2fd35ugVq11pZW1ACcBGx5VyzNbEHAVgnUvgT3MOkxrGdKEW?=
 =?us-ascii?Q?OAWlsYYb3fV6b5xKjvHSg4JlSEF6LSsjIK9+lnGuwEQ5eC5Dtzq7gfhcSFgr?=
 =?us-ascii?Q?8UMiAhOJA0Q55iQdXGQY427Tz/dhJ+aZ0foeeYPw8dCOkzaz+uqA3JFO5wq4?=
 =?us-ascii?Q?CJid1PIrB1RKihxTzMMKUWwoyAJRkyz5b4JWOJ0zuKXo/6IrfUdCJlLaG3LA?=
 =?us-ascii?Q?epfgJKBUWYBgxdA5lYunzk1W4XrZTljdNtJOmOG3hve52xUCleS/gEgY47RO?=
 =?us-ascii?Q?it9tGVXQCkb5lM6JsHrV5yJgodOedVsBAMNhr1fVCzgQununiKOs/wM8WmRq?=
 =?us-ascii?Q?/wq+hs978zlHXFlzLJ7Ny0hRvwhJQLVdV/qDNn6nimPQqOmuFzI81eMqQPM3?=
 =?us-ascii?Q?jBQVMbiVKVjwxIQOzBCEu8PbWMmYQLWalsram311olgs02HzMwGDjHF9MAws?=
 =?us-ascii?Q?5Bm/D6xmbMjEWwR1cRuN5VazQdzGeXMbYiDbEtqklo+RcirGccj/5xOHTp+a?=
 =?us-ascii?Q?3CA4hNQhWe6mjZus7hdErdSKAd93hjOOHTHwkOAqewQ6nzcRYE4xroIqA+XZ?=
 =?us-ascii?Q?GJBEKwhAue+z5o8aiSLuTQKbBDfLELtH2TkCTbitMxNErjuQ0PPh7rQAFNBi?=
 =?us-ascii?Q?hOrEFbvPSKcOf6Gbulxjki0dqogvP0plArewIF9qUPsSutjfePlFDhVAcQ7H?=
 =?us-ascii?Q?qfidFpBllByVOsijxHNyYnU0AwJp20wBKasPL72SGKngGH3k5Kr3Vp3Ll5p0?=
 =?us-ascii?Q?b0+Zyoq8ZrR8rMCwLvBDgOpQALNLQ+LjekqAypiw8yMMjiBhVDEWna3Z69rk?=
 =?us-ascii?Q?Sugk1eBnL9eOXPi/G0Sf46KhW4LT6ZkBl/p1ULCHj+OsaJrRi98K3y4PmZvG?=
 =?us-ascii?Q?VxCYBe0gCLZo/0FA9AQnjbNtUuIHTrkbUBSRoM34L1HMf+INbOA8F8AJHE7l?=
 =?us-ascii?Q?/6Irhohl9EMSAF4d5MEUc7jMDlJdbC/wb5BayKPL/4M8r+asfCEkWqViL6K/?=
 =?us-ascii?Q?RKaV1g2TONVbH2jBZKrnstog7KojWSYsV3qoSJ134YVDyEC6znnxsJphgZCP?=
 =?us-ascii?Q?OlpYaL/psC4gT6WfTr9d612ak7HLwr9LdcqZeqvuDQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vzV8HSTUmhA6r0VSSUrCSPOBnwSw3+s9F5KnLoJxCDplxV1i5bRvbU7jCkQ7?=
 =?us-ascii?Q?0Vp/Q1Gr5ljufHyktxm3tPbesOy7S988td4rEoXV8F4vfR2Ml9Xr/YGzbNwJ?=
 =?us-ascii?Q?u8p208KKIq3rhxBlwPqBMvP3l38oipqknF+89nO7iS48ucyUQ7GxQa/85XAw?=
 =?us-ascii?Q?xIM8x3vse8zbqmKWd0l/y1mYUiVxjiUvKh49ilqXyGaOC4swFvOJiFXV6uWc?=
 =?us-ascii?Q?QCfv4Ml9cu8LPVCAnkRIKrpQ+p5CIeRBfU81flNTjJ74f/o/M/e1yW7EDjvQ?=
 =?us-ascii?Q?8Gc4QlUFnsyjFfBHmjnYubN1ivke4KraquMt8UFCbS4UI5V9cLt6r8t/EabU?=
 =?us-ascii?Q?8Mi1q+aMOffooYQuWo2VNLUccAgiwoD6BR0a5bmiP8cp2uJ5cFoqYiWFKlpj?=
 =?us-ascii?Q?/ic2YwOnbTbV3DGYodmyTeutzRpH3AvNq+P8y4FlLUzlJLW+ewceKp1U8fA1?=
 =?us-ascii?Q?CIiVdLGUPS5XzzObtl7CU05gy94SA21cO/MxcXEL8Dp4kvniqjuM8uuRyNir?=
 =?us-ascii?Q?MacJcMGkpkq0IkMvVTjVI6FieeywHQ8vPR1JsoJ/oibP/PgTv8V0OuqW7HZf?=
 =?us-ascii?Q?masn2NiEOXBGdyFo/gL6M31vq6im9efKPBTZgGUYKnYCt7yOtjiuORjSfCbg?=
 =?us-ascii?Q?0Xa01uUENImDjqBO/yyUhmeDJqj00/OFz+Zg5eyBwc1CB87Yk8w9Mf2gP1Ke?=
 =?us-ascii?Q?8+Q2h6+XxKKGYWdA7urVR5QGbO5wa3NLvA+CU62kC9zq4tXi5n+HG3dmhxpa?=
 =?us-ascii?Q?w4wo7RyUyYsYbxyyLXq2biZZdX2rlsjRNgupRwpom/thuoM1/0XteD9QfRYM?=
 =?us-ascii?Q?xMvEbFgVnRPSI2Gj7SbQj+tvxY2fTZyv1ATLlnTLOFbRSDDos+W9Ee9Qsh0u?=
 =?us-ascii?Q?dJVarpEWmryGQCVI08jT8keVdtaaR+gebCDrOE2OC32bg7G6j1alh05bBXSW?=
 =?us-ascii?Q?AedMud+V6ArOxYHIXsUbOoF+wG9ni6p7hK0OfeHPFZq63dEB4dxEAyjsPncz?=
 =?us-ascii?Q?a7AYwvbJgICMtsuBYg1YxuKbOK5XDkKNdyQQSqqVIAaPQac+rS6sKgwhP+oa?=
 =?us-ascii?Q?Dsi3or7m2iS3hajBzPaY98F4DxsKE4tgXfLQJI0eZKODbPl0+bG4EtVnY+CX?=
 =?us-ascii?Q?FNDxd2IFr0ZUyX/fdedCmvAEH72f//Vi3rneW31z6/+ozAFu2mmPTiS0hAmn?=
 =?us-ascii?Q?U8Y4uE1hI7nPJuiEp94GAzHXOZyP3hw/ddtJgxoPyv0sCM3OsICuGOvPhK5m?=
 =?us-ascii?Q?+Vq3eK8TqZNTsC3yc0dZJYW3RDB2gQxrfSyJVeRRzcZlS4vHHvewmVfu5Vwt?=
 =?us-ascii?Q?SCdaH5ydo3L9VNzqgHFwBS3w5jKWGBwgcpABz/idpyjdpwERiGLIrWP0JokC?=
 =?us-ascii?Q?dyamtgSCQM2GabcbCvwZ6h4Vg0NcKBvxSTe0Tv2z6oAtQ2TSEXD0BdoYfy51?=
 =?us-ascii?Q?4EneGEpcuYtbsz3MR8KSeLtnb7ngLpEtUvEXuiClvsp8ElZI4/OcQIUpz+3q?=
 =?us-ascii?Q?pUzgIFdXDLV+HhHtLFP08YXvoLrq9d0y8wZWZM8Ac8KIO6sLZKHkJl6ryH/a?=
 =?us-ascii?Q?buza0GEa0eJjg9aANp8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c806f830-734d-46a1-b707-08dce3ad6b27
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 13:15:14.8819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6/btkV7Ig4HtdMbr3wfYfeCOylWs3/tO8U7ooQthZRPx/ZCW4XuYmc5nbnKEGoYU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8842

On Thu, Sep 12, 2024 at 10:25:19PM -0700, Nicolin Chen wrote:
> The previous IOMMUFD_OBJ_HW_PAGETABLE has been reworked to two separated
> objects: IOMMUFD_OBJ_HWPT_PAGING and IOMMUFD_OBJ_HWPT_NESTED in order to
> support a nested translation context.
> 
> Corresponding to the latest iommufd APIs and uAPIs, update the doc so as
> to reflect the new design.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---

Applied to iommufd for-next, thanks

Jason
