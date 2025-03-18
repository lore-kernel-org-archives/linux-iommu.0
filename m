Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3681C8602
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 12:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742301256; cv=fail; b=HUXjJYoDLiC31jt/YXCfa/ALq8Qh8TREqUaV0zUwrFdGUClrUNrmHcO2Ra63k0LPFygNKi05CQmnsR36n9Nxyc9WKAylJ58n0J7mr7z70EBj2a3BuV1n6cy7RMuLG/GojsiMW0Lj2RRulefFUzhQuh+sB2GZ+L1bYS98pjHdvw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742301256; c=relaxed/simple;
	bh=apDyXpycMSyaYC3P6QPolf+/b/swPzm1fcgVhC3dsFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J/ETrz/3Du1HKRPnJm0bM11/lF214kcSKH7bbBh+6XVnudVE3hnITI0+hZ4o4RVedB9ysuK6P+KyrpNQK7rsM1GRD9UKLA3srAzYNAjmqvzXgQj+PSz0L/uAae6bvxe1AxmSdw/nnG0GeyifHWCHh822A70vNUalxc1jadi+3ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SmlnMx9p; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SmlnMx9p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7PQZEv8aqJtHsJEwy5aTU5lhrYeERI+fMmKUjn/sSpheBoS64N+Jsrz7wGHLaK8bZXcwJdyPmHlYjGxgF0AeSXX/HK6SmSEuVx5pBpczME4JWtstRkx/hwikh6pxdWLEgIZN8ReuqeEpkkW2mbCosEjaZqcr4K7kSuPYtbiXYvUks1HcTeMgNqqzEfPmP1xyQ4oCO+1A7VHt4WySQg2azXYKF+vZ//sX8qpZmNgNX1IlTKvjc0uVZAQ0LJ8wo8BscQmDVBTKGXifYDE/UPIEWNrPw/B3gNUeu01K7kJjv/qxB6xxNcHYCn0TUzQTJj1oCPeX9R2LMoZST8wlgWnlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jz0KRNxHjG7jFTZFaHSWzavC4XG9LxgezzA4v+VwO1s=;
 b=JqidoRjfocw4P7ndNplx89Y7lbI6wwIOIxt/iWW/8IUv28uUdSlaXZ0Fn0MW9p253+3BeTTM+Rr2ShLhUi7x3xbLMTU8DjYJH6ttz5gSeHqnOWyYfUxLU3mSxt5COwJWu9KjzEU7aJBygJvpJCIxWpbpZUOABoZMzltKO8R1I+N/Ey/zW7PYkJCRgH0T5La6R1QIFReTnASGlG+FbnlS9CNpxKS3dnVTh9GCFP5WiyH4Cnu9nLaACO0jn5D/j8oMKQ71791klVA9J8X3DsNfjcozahi+eMgHKBYop1iv7vdER9fVhLR7XuhMF9/CMrWx667EJwAJwbDoF3dIvIDoXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jz0KRNxHjG7jFTZFaHSWzavC4XG9LxgezzA4v+VwO1s=;
 b=SmlnMx9pxix7FBTNG1pNz+e4rq5HplH3F5SVmEVVOXVQ1kOzH/pU1+dPhEdxZ72Uttx8dY21asJ/2ScanpMhzzj+BI+xjfBB0FBO1OipyWrOEE3pG0p75L0nxdxX/Z1KcAiEwCHaIo2S8w4U511SLSBWj4GMmiLMVKE9xhc/Eko4tKr7lp4GMQDeze5UftnxwqeFQCaWzm3tvwVE1m8aw28uh15F9GBewx/G9uIlMcfPeqmTeCMT4O7Azufi7og6v0SXqeyFazXB9Qdrx6yGL3VJccrmRA4bLJvkfkxjdoJqUPtardqtAFkDpfXcCcXixz3Kxdhmu41c/Fax2JWNtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB9221.namprd12.prod.outlook.com (2603:10b6:510:2e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 12:34:07 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 12:34:07 +0000
Date: Tue, 18 Mar 2025 09:34:06 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, nicolinc@nvidia.com
Subject: Re: [PATCH v9 11/21] iommufd/device: Move attached device tracking
 to handle
Message-ID: <20250318123406.GJ9311@nvidia.com>
References: <20250313123532.103522-1-yi.l.liu@intel.com>
 <20250313123532.103522-12-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313123532.103522-12-yi.l.liu@intel.com>
X-ClientProxiedBy: BLAPR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:208:32b::20) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB9221:EE_
X-MS-Office365-Filtering-Correlation-Id: a63261de-e009-4340-8487-08dd66192d44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?upTeFpWonBOQhZ5zgslqsYyNkkCUWJ5IX5yTdxCCjhCNCB2PVCpeaNBWXNDF?=
 =?us-ascii?Q?oOmircM83bMmt9BB5lhj7ktswXSbELDuXapJUbHEQ5tPh0x2vauHZhO6zvy7?=
 =?us-ascii?Q?kBdOsLESKLj7DryyJoNCDMrD64pHYdWCkak/JDYXI39V042avMnad1eQQoBe?=
 =?us-ascii?Q?68wjd3FR+Yc/kJJbgOIDO4VhKaLpRTDHE497ex4DyQ4SGf5KcU6RRxQ6W5Pd?=
 =?us-ascii?Q?xDWZ1D28LhBAx9r4KrVReIzQbt3S2zAKnPccorbO8DCFVvQQG+B1KUqVGNoW?=
 =?us-ascii?Q?K6aMDpX8gHAqd9DscUgb54pmh9YsVhnk/H5e83AbN3Numy8Li8w6T9HrxOYE?=
 =?us-ascii?Q?BTPwU79ppSJRfZEj0fuL/6sJcawVabCGgvKs+oNdqtmFE3MidulMwjI/EfkM?=
 =?us-ascii?Q?nMBkGy9jt9Bo03JVFlX8BVjhisXGae/sIHvK+1yf8iUCkDtaywENdQi27KA8?=
 =?us-ascii?Q?N+38qsC2TWjgTk7qnp0LkcrxeRBOvqTMZPM2+VTZezS3tEH4CU/Rr9aL7FHp?=
 =?us-ascii?Q?nFzXjbGXIeId3gKNQVjPTijQ0NT3Ps4wsbQRKV7zaeWCcIx1fOI6ulhnzXnW?=
 =?us-ascii?Q?/MQqYJ/L8yGVzzPXg/+lt6QipJic1ggDIzOdftuOgqCUt4CjJiRTlKpFliX6?=
 =?us-ascii?Q?KAmIhtpGM9x8IKNfZuF/TEAazDpHVFCMY2t4bJLkbPLh+6T30Naf+lN0aNs/?=
 =?us-ascii?Q?zeIBJn+DK2EnFHZsO/L8qM77KKTxLLiFBtkiURzxWRneVhxlbhu41yWKAyqw?=
 =?us-ascii?Q?vKQdvFIreKOR1IshuCQlHPGP+8mhk1LHYduCp0U5jZOJymsfswKX2f5nKtKn?=
 =?us-ascii?Q?Lc6HkU1ZV2LDhJbhMqwkmvrXzsdn0+2GTU0wVCgUN0dqvByt5D/eM1rcz1BW?=
 =?us-ascii?Q?sJlUK4m6+hvgBpbvoD3U2lePJEEgeq+KVschTcKtLUZuf3Kt7dvNNG3oJS5n?=
 =?us-ascii?Q?1sEGh6GmaaXVcH5JDqxXkOmyMYPyZ6w/NBeeOtWT4TqPMc97M5+wUgwqgLjK?=
 =?us-ascii?Q?URH1HVLrAHayi0h4pudYpdGYQAJq/r4/dJcp0s78hHkf5YYJZ3NtdKsakl3/?=
 =?us-ascii?Q?S4uMSWEDP1TZs4JGfFf9yP2Wn2TRPqdUAdPoU9c8t0uAiBymx5gtrZGmy2xf?=
 =?us-ascii?Q?wrXJoTFu4/qcrIIOMjy5MlgDvrWJK5oKcOx+6A67H+qLDnkf4aoZyTAhuBAA?=
 =?us-ascii?Q?hKedLUZymOgVUpggqwLcigprGN0d4qOWRM4jOU6OvkeH4XVhUOXCVbmHJjft?=
 =?us-ascii?Q?BsugTt5CALsMorul+LTMmGKZOE2S9+LR3e0zozCxoPYpREV9bQ2ciXBwAUgS?=
 =?us-ascii?Q?v9nFrafWsI/ye2jAw4TkSjvXiFP5Jwqo73T1jlPzE6KtBt+kWuJs4JOJCwB1?=
 =?us-ascii?Q?jSswWlrnRXfEB9T8oklmaxdV+sOa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jt3XEvVYPjlX1ArNyHPm6t8i7o8ImJS/Szt7Z17CgdJOHKbFe0Uuj2DeKEF+?=
 =?us-ascii?Q?7w1EdofSoKO2UMKqMOdr6QAmO7LOqe+CDfJUxO6rJfrGk26yn19MU355gw4E?=
 =?us-ascii?Q?x54dfEmi1TxW/BBhwWM71EBBgRH6LQECazqLtgmHjbJstL0kYsm7Efk6ZjHt?=
 =?us-ascii?Q?e5acWwygcSfawOY/sXDWO8lhgUF2fcTKB4Mi05eyQmABkCiaQ9ZRORH94ZSw?=
 =?us-ascii?Q?RKxpayuTAvgrZ8qb0BdoqqW6IDSDqiVWuLiTnnwBaKWb25hmmYRFpIVfiCC+?=
 =?us-ascii?Q?gfJKRX2VqVQu9QijXjU7a/3kON3YqCblUOMTwORruumNsi3E8p8MtvJ9/G7a?=
 =?us-ascii?Q?L5cYGUb/UIx0NN8p8Zhscd28uLTmsNxq5x/2e3yRD2ZP6sYNOVsv59ox9ug0?=
 =?us-ascii?Q?65EyZUJ67YNWSWq23m4kXrdh8pp0DsAEBSeq68L35LEzLGK/+htpFcThHO97?=
 =?us-ascii?Q?FqX3SCSu08v5j0XiGi5JwfsJohCze/3/nSJr+mXNVzZ3UxyoRChurrTVAYPY?=
 =?us-ascii?Q?NQoIO8QJN+9yEP12D7mcwE54RVQ+UQXz97l3DGHxOB/q7fPXPuacyJarj198?=
 =?us-ascii?Q?3Vsr3tz1Pc6JFd13O/uw9C3zIHYVrQZ2MdwFvO9AWXRy+4WKsOYaLXyAtQK9?=
 =?us-ascii?Q?yq2R9l7Bxv+fhD2GzO3fdDJBoCSPPiYN+xrFpQQuErxrQkcgCnIATxa5EZmw?=
 =?us-ascii?Q?2ukSQxbUCmAWjWUDzpb2cXQc9KLFHR6UuWC5wX2h1x1ydD3Ve1sdUwqx292W?=
 =?us-ascii?Q?8+vkKBvM6jlr3IIEzJkfbP/xCp+4qE0rSc1MQuaPvlWYKdAWBtwXvWZnLJj8?=
 =?us-ascii?Q?ZQWqZZ7OaKn0re1DSiVtqmfZ2Y6wD4ip8na0i58q8I7F13uYD+t60+juqSud?=
 =?us-ascii?Q?A3M6mzctZxtGm9OOaNKYYo2wCE99IPxBRCKq+OkxJ8c3bvTfekbOgV7EGbde?=
 =?us-ascii?Q?pgdUC5el9BbY3Yv43mo/8QLE1vJVXlHaWAWoKBwHY2A7r+7k7QZtuN6FSJOj?=
 =?us-ascii?Q?5PUtyvOjDk9rlq+cavljzDklaaHLAouRPJAzz+VgCcQ5Bb32IrCPA/TEkjlt?=
 =?us-ascii?Q?PUwd9hBNX1lQ6U5aGHtUGtkaoV+CeIGqGYEq10B5vdi+TAwYH3cAW4hJezus?=
 =?us-ascii?Q?WUks3d99a7K9iclLR4lBSWue3M7xvlKE3+ru1URKd+4Q+XuHh2UauZW1UdOn?=
 =?us-ascii?Q?S2cLN3ob9l9aVlSe32gjbNwapLRwk6kAEXnR8kF46P6mdKDMEICyEvQoRIYd?=
 =?us-ascii?Q?jcjFF2U+A0S8ZheHI4EyoORLZ5UXiDA02CDziD28DCadgiyfd7FjHpFFuGJi?=
 =?us-ascii?Q?gFf4XsFE83BCk1sSwUq9HXDozNnWXnW6+Dz7+2CHnmFWuyEx13Aktn/gNpgR?=
 =?us-ascii?Q?RsrzUiye2zQMqlKew1IGkCd5pW9yYsr1MTRyg61JsNBG6hHqr9W0Wd/AfVZj?=
 =?us-ascii?Q?gcRPAjx/UVaykXxr+W25Zw/bu1rXkzXlVXLJ7/KlojbBIQt3m5uMcBfrw4SG?=
 =?us-ascii?Q?YQYeM7LKPWgTON0etcrbMaKsN04BOO3yQVCycH+oOUTfiUHPpziwXFBxvMC0?=
 =?us-ascii?Q?8+wwaTe9BLONGpw3XH3MOU5LC4xlv+wyTXNARaba?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a63261de-e009-4340-8487-08dd66192d44
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 12:34:07.7861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /881fGc25t60Q86l06DPt7gmVunfTo0CBqJ7BLg3baGt4PAO9fFzUfvTu+zHzsy1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9221

On Thu, Mar 13, 2025 at 05:35:22AM -0700, Yi Liu wrote:
> By tracking both attached hwpt and devices, iommufd_attach_handle is
> prepared to be used as attach object. This prepares for adding per-PASID
> attachment by using handle.

So this is the patch that really requires re-using the handle..

The issue you are trying to solve is to avoid a second memory
allocation when storing the PASID in the xarray?

struct xarray_pasid_entry {
  	struct iommufd_attach_handle *handle;
	struct xarray device_array;
};

?

I think I'd just accept the additional allocation and not try to make
handle re-usable. Every unique attach gets a unique handle allocation.

Jason
