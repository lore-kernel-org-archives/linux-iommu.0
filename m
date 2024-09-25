Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532A814A4F7
	for <iommu@lists.linux.dev>; Wed, 25 Sep 2024 22:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727304209; cv=fail; b=Y6PtrndFVYsoo8AE0ycfu9ZtGCdLfQ+qYDtFfJjMy6sHOJW0aYeZTmUl0bMhXfqkqsMRoaI9VYuJJNF6SObE6TDY5w9vmzREWoJdWENwitYzL31oUQJXE8GeIy17nHqlG932ZFAZ1Zc9ywJGXOVqPA9S24O0/LUEM1ydx2aMneA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727304209; c=relaxed/simple;
	bh=QgHXdCXdc7QIyiDoVGIjVMHobxNp+gn6UMg7edjdoYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NxN2Xx1X5G/Qy8WXWpKGmA1xVuc45hLtbQDWmVotblg3AfFbKfSIoulN6wjqa1wgBdVR++T4l6gHPjr2L9QxEK+pSLmrukqdCa8oBpYruK5pfdVPVqvtPjR4m7MSsakLPX5paeMUc0HZdq5VH4U/ajNqaNCvP/w2G0IoA9AxMds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Own8yJY1; arc=fail smtp.client-ip=40.107.223.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Own8yJY1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJEXJRC/neYK9XOG4c60WzknyAce3dP9zko58yIeHRczDPRH0WVIFrmy9aSnrK2Q3mK/vJLgLKf4SHDuSB3NrSeGq6SmUPugXdh3kD7pfQv4hdK0bfatMgKzCdHA3hiL7t37e6n3y9g1kOB02YKdCrNLvPMtSWlqJnAa0xX9L3t67esh8jAWWxTMUvgh5fPocjU0ytBCmTBvjWn1Q0Mqpzj1V6tfNxAikdfU1YJyTUMbhzoFqUjcxkAhRLG5Q56OyrwrPtNqB8I2Dt0+U0nd1TpDJPzjPIId1L2OWkzKIyon7fH0GdwkpHAm4SyxOjjrVLbqLryfAbIVDewttJXSjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lHmRy50TKO0j9li2PE+9J0yYpm1zxVlOePK11qoOjw=;
 b=Wyb5lPh4DxQKjY9JYRJXl7O5Kq+kFQlUjcDSRiwkG66jTP1WRevFBmijh48uyttEjOl6HwA5/CeyZORnRE/zpdKffsA2aq2CUFAI6txvXk1wedGFZwWpH4w06wjm3i1JKmIfhlasOFs6iJTs8pwfbxjT4wkul7BiEmR8HiHgN5cKos6cRCdwxuVhsa4wr0zKwsL75ob2yy0KUrUepPLaF7igkS9qKnQL4ko/MPIhtRo7bEpwtSe0RKMnss0mYnET1ggTPErW1EM0jIeO+OJo+ph0AWpI/kN6VQUb/IbBfSTFErFCnDUVcYBPa9c5hUy+9ZXQImqYNsC+NOt33uguXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lHmRy50TKO0j9li2PE+9J0yYpm1zxVlOePK11qoOjw=;
 b=Own8yJY1yLOItLCaVfl440Y9W8pEaTFvdb8xCq+w3Yb6gcPiv3kPnHkDexaSu8iXqhIjYcZqHNVdytyJj7R106V6djAo12A1JHNI5+9/JUycJuGEgnpF+Oo3w80JKHFkMSlJlCLlI9yiOBul1792W/wXzSj568WokhCvhebwVdOTLB5ngtErpPHZWfjTJ2/7u2GHbXZ6cZy5jZd8rU9mhoK/Ni5KEi2cr61Y6r+qLWWjref2QpQBbzg9OY3WkH+OkjS0tJrhDugxqDzEtEwDbqwSzdQFNERbuPJD6Wc3KShQLIFniVZffkwEZ9hFdUpexmWZEWi3qZrig4sv2ge2hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Wed, 25 Sep
 2024 22:43:24 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 22:43:24 +0000
Date: Wed, 25 Sep 2024 19:43:22 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Steve Sistare <steven.sistare@oracle.com>, iommu@lists.linux.dev,
	Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCH V2 2/9] iommufd: generalize iopt_pages address
Message-ID: <20240925224322.GV9417@nvidia.com>
References: <1727190338-385692-1-git-send-email-steven.sistare@oracle.com>
 <1727190338-385692-3-git-send-email-steven.sistare@oracle.com>
 <ZvMhqXo5MQ24xVND@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvMhqXo5MQ24xVND@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0078.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::23) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: 4db7baad-0242-4ca5-4952-08dcddb376a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VbsLx1x4hvUbljWnTgLzh9aajKcNEOp+haol11UAfqimCYQq+8wWcoXKma23?=
 =?us-ascii?Q?fCzXTcSJjGrgwwAiTEuHSauPDxwtj2oXpMZgqYfpqLRPKF/oUBIUmdD72RwH?=
 =?us-ascii?Q?FU9tF1HpTvUrew+Fwfw9EMUncrtMVwRxbA/+Q7zI5RqQyP5JFGjuCiiaxgIg?=
 =?us-ascii?Q?vpNqC89MqtUQBFUcs9BB/03LJ7Oi9eKYacgzRivKt6FLsGR/8YOyKN1RAvM0?=
 =?us-ascii?Q?p2kI6Rs3vfjfRKUCAQ2WcuUjTh6s0zrUKk50QasOR42W8EIGMAF50HfrXlJZ?=
 =?us-ascii?Q?tjiX+bGttpBFnTKbJiNPRTWOvtXh5NHgxMcWPNM+YD5ZK8fRdy7ihB8srGzM?=
 =?us-ascii?Q?iMQPC/uwOmnm2dSMjabPUwODo5XbEXos5c2fYmO0Rv1Yu+j8QyTzTNVQkmpJ?=
 =?us-ascii?Q?JbvzvS/5Y5+C1XwmolahJfhJ/iMwxiP777cDXkcUJ/U1CADVyRfLRQ7zja7a?=
 =?us-ascii?Q?WmKKmYtocNbIzkwZJS/DtGxMZ4a0fmqdJ0xY5Y2ZDv8S10ZaQlM76LI16Ixn?=
 =?us-ascii?Q?ayfPcrQbx4VmVcP+7udNlErHukVuhxNV1AojKqZwSHthJi1mdRmBHbfoISQh?=
 =?us-ascii?Q?bgdH6FDbH9kKvjX3LneOn2fQAm9DI2jwtsaf9AKifdVBAdVgk5XS3mdueoEP?=
 =?us-ascii?Q?32XQLcWJYaSiq8lD4JuKx8Ugh86iEoUfDAjrLPxsA6cNM9sHNwSLCkZKEarN?=
 =?us-ascii?Q?ingw5Dqcf+5NP6WpKDaMHBvnJ82njBAqfIguK+JW5LiyRpStBNijG17o14YR?=
 =?us-ascii?Q?r12luuTefLTe2qESLS07OogBk9Y008ZJlaLuH8jBN164wgBJAVk0rD5tushd?=
 =?us-ascii?Q?9iEWc4sHlrdT7FwXMm+toIIkjh2jDV4AXh1tiJIhx0fSlFOYitoBBiXBO2aw?=
 =?us-ascii?Q?Cb3JiMhMuuu5pyZRuoeM6uldQLj4heD7Tso4ghrQ3JSYUgSUrIkqEOyDeK51?=
 =?us-ascii?Q?9YmJWFeSqvPtXl54I8hmolfZIjHWmFzXAX/yIVB/qR0g+VayA7SDVEXhdv63?=
 =?us-ascii?Q?y8DGNCs00wYNuifcbUv3MC2/u30zoXPt1wrBwyoe2WwmG4clF5j8GKMsO08x?=
 =?us-ascii?Q?oNJ20kmU91b/NbMGLbz0wygiv7MPOAfkGVe7z63D3El/p0Fqs0+POg06Xv0C?=
 =?us-ascii?Q?yBoFLygLZWuasVd6Ty/9r8oAsFmomaTTNBTOtqkrLbFGVyT1eiejyW36WjOF?=
 =?us-ascii?Q?BA/WU6uxB3mzQ4czYcHvk5/115ERj+tjA9v7d/Dshw8pxFyjyj6z2BIUpaLf?=
 =?us-ascii?Q?zpJWXuxF6Dea3qlq/1AMF2rMTPmH3SxlzeiqdmRn9XrL4waWoZYt7xUXxB3P?=
 =?us-ascii?Q?TRZoaAQk952S1b8whhiICj380k9m9iDXPA9GaP6exCkPUA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Er0ONKkRDyrcrnn7Bg8BFKpIzWRNUborZPp6i1+OcjJYxTTZOYvlz2i8EbAP?=
 =?us-ascii?Q?wyi5FCFPO7QpFr4NktmSuQT3TUIknDQbrgA0uo2/fUaKtEQz8wvz58VIEKaI?=
 =?us-ascii?Q?jXmfqc9fiS6svC1mhcvr/4TNl+OSd56UhC9T4d7/+b7YX8ZJQ6ip6ThEkz/D?=
 =?us-ascii?Q?+f06oOFgQ/rmZkbSOjm32wq8nhmukAiqb3mkgdlq3zD16ApMmSr+iuMhMapT?=
 =?us-ascii?Q?KQgJ9g81jdFAtYRRzYxm+MEhilA1qwMuNX7djn5gLoKWWZjIG71Ap5uj8zFk?=
 =?us-ascii?Q?bxUPDrpo3fTQU1LYHt+gvL/bngMs9q7q5EuRsBqeobPZJGwCNWsc38XnqcEB?=
 =?us-ascii?Q?xhePpIUXWuw5kwSB9iIC6UHr2fINu/f9YDYA/AV6UnVpvZNaa6WI8W+Mwh6e?=
 =?us-ascii?Q?t3GIXXQThnZDvv5bfIza01AggthWW3Nw4XGdH5UGtT+xcgXZFUm0XW6D5alX?=
 =?us-ascii?Q?bP/TlCB1fW20NkuPCsiJyrwF8HEL/kVSkIZd3hwuxsc0UAgtldGvqy5Ag1dL?=
 =?us-ascii?Q?jNd7lI8tANBBnNxRspKHkaK5Ors8/sCJ9S9udp7MAcR2Emd18CVrM43Q2+4v?=
 =?us-ascii?Q?n/YlmuCMXYsuk/ofLODg2pKX/PjwHeWHdrxAczpyRF8XCL/nDDYiuFZviLPM?=
 =?us-ascii?Q?cq3mZLDPVHBsrO0+Lkz4guBDI6jaTZdc8h1l86mK3gyotw6nzrgj7Z6LJsXV?=
 =?us-ascii?Q?FSkxqw33gfBSpq5JGr34ze89ladDp8BzurCKDftIlnsccz/WNsDP1OLzIOPi?=
 =?us-ascii?Q?IVac9PTtceODfbzscw2FUS5SCqaWElaIP3yTXvgKmmyg+KiD/OrhJO19b+Ro?=
 =?us-ascii?Q?0LdePhKnYLDD4qWZF2l5dxwKAgsZMUmDoGg87mITlNDVRF6G5jUS1ED1PV2O?=
 =?us-ascii?Q?nZ9/rzhMZfs8metFABZK3wfALbIvO2RtvB7+voECetceEZgTMznmhn8EIC3e?=
 =?us-ascii?Q?AvR3sQa14vWmUuLdJqDlnTYlPvSyoEVvmEeQh5PhMgxX/tbvJ+rvc02poKiH?=
 =?us-ascii?Q?4wDxHt7IIUvpxSqfExDdC68jmGYkTBBSq8A0DdQPV5NmCihmJJvtDs5n1GsS?=
 =?us-ascii?Q?lfVGmMxqSe7lelj2KfPTQPORZkAkZj2b3bnjmHBtgT6iVJb2fblrO7/hdszi?=
 =?us-ascii?Q?ZA8BXwI3vFy3QpPVOBbYYkeCSqZzQOtkaxr6DwVhs/uAV9nZAjGWn7R+mIRF?=
 =?us-ascii?Q?8yCmmHPOlQA0jXQdfeE/KUWvoo3ASzgdbL8Cmmvbq/ssX4pfjX7l03pYjd0d?=
 =?us-ascii?Q?JBGe7FJ3uBNxKfA5pS6XUu+SVW8hKs81GFXQz8qU9sbMsq9hEp/GBd/uIM0B?=
 =?us-ascii?Q?sShbHZHqHpg8lxw2REb634mFnqaR3HvYC2ocWgvWESkdq7jUxrvUGKrikFzE?=
 =?us-ascii?Q?Xtf09tpWCJUewIsiNjVHj/eSkTZQ+3H0KzeOLZ9h1hfkK3eei11dv9BKyWqD?=
 =?us-ascii?Q?JLvzKsDbX6A4P9WyogNyMwd07WfQ9VoxbvcSgfx05enGzD1BZNVFIHZ7dHbJ?=
 =?us-ascii?Q?GR1tAl+pif1AbyQJyZbNg3uIimXzEoy+Fhm8yMsaFR2BIbaE39ulhgMlU+TW?=
 =?us-ascii?Q?g1RWIbknbHkmEkgOz38=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db7baad-0242-4ca5-4952-08dcddb376a7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 22:43:24.0472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8+6gCdCoq+uMX61vOO5DlTnl9YoiekuTT49q3y72u1v6kqGO5naPDZy4XpsjOqTR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7794

On Tue, Sep 24, 2024 at 01:31:37PM -0700, Nicolin Chen wrote:
> On Tue, Sep 24, 2024 at 08:05:31AM -0700, Steve Sistare wrote:
> > +static int iopt_map_common(struct iommufd_ctx *ictx,
> > +			     struct io_pagetable *iopt,
> > +                          struct iopt_pages *pages,
> > +                          unsigned long *iova,
> > +                          unsigned long length,
> > +                          unsigned long start_byte,
> > +                          int iommu_prot,
> > +                          unsigned int flags)
> 
> I think we should follow the existing coding style by combining
> lines that could fit within 80 characters each.

To make life easy the "coding style" is mostly whatever clang-format
spits out. "git clang-format HEAD^!" for instance will adjust the
current patch.

Jason
