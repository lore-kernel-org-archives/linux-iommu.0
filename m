Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010054.outbound.protection.outlook.com [52.101.46.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705E82DE6E6
	for <iommu@lists.linux.dev>; Mon,  8 Jun 2026 13:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780926385; cv=fail; b=TemfN0DaeJXRRnB9eEteH7vNFmOH5AAGwfEMOJd7XvxYG9cxtLqw4T5+AJd6ZwLD373G+d4Gep2YoRib1Dr8TA1ODSSMcuyAbxsPVGcOlDr2pBmHkbqcndWkRUauvHh7yipMANdzM33G/IAiWro+nJ9eFi/jksPxv5r5LTOtQcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780926385; c=relaxed/simple;
	bh=PgxIT82+5k8jmhigIfAlFh6X1y8WFJM90apZwR733NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sjHZEq5XySsDqAO0LaGUdyC7jSengL83jiQxEfAYrAAvphbbewS8qzHXOZCCIugIsf1Hl9uvfQBEtswoj2sswSr43+8LY6nhLDfp527iKa8xUv98o5zcTjFkbx2uh1c7XUH9HkLn0LcajAsWeR1vd62ghQ82cpJbxazln22046M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lM29aSJY; arc=fail smtp.client-ip=52.101.46.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lM29aSJY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/hgESJn7Ep7mWVrH8v6FnH7kDwiwDjYiV7WsGZL8nBlxpXU2bJKvJ9ZpFQtRI5mhW0MCGG7oI4TxgnD7j+RETiwe0L1xBToz/fpnviYbUDfuUOJZu1ZJ2puUa7miowfhn88JQLMFmYbGKaK3xhlFlApTFs6xo9Q6yKl63aPxSXp48nhu1QQF5MIVEoPW3qUB9nROl5Sjeym9SOzjyvJAqzMuzkTI9nR2cv10KKMBz6y1Q2HT9UvIJjJrq0Nc3HPG+/qYqCy1HjAMXQ2HiSc9FRbjhiIg8OlZJmo8SXBfpXISI79U8nB2Xf53635/gw7ETi93kKhqVw4amFqpIwmcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PvAJuUzC+2YxP86sA9cuRNKnunAVgf7z5MAwRNiKKY=;
 b=Fp7VhkjEO1Et+UU+3fYt9lzsyxXCr34wUZ0IoJ4rFSk0btvAnWZd1y48X0IYDKaPfK7bzkY1t7SD1ug1fORGQXaGVcAATajPs3G9CLkkYEVopdSVPJGpIPGYVgEjVLnd4oloSBIE8clDYH2+fRs6ueSRolqx94fHgiGkZXu1kLoqg7Qmv+l3f2iAJhZ8d+WgC75IXozU9ElotgmLQBBjc60YllouKFWTmnaZyfc+rV4cJqxzJU1UT4V5D9LBLOfM/kFa3sooKw9I+t/0idoacJNpYrB+vt2/VGBCp1emsY29+QSp5CcfhbnRhCnr/Pb47GbB7Khds0HuqtxJcUa7WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PvAJuUzC+2YxP86sA9cuRNKnunAVgf7z5MAwRNiKKY=;
 b=lM29aSJYY/iMwdgSuOPci6uYoSNyDCihynaD9WNxmo0XOd0R3w6QiMWa5AUuBeyuQxnLxE5JLKvtOvcdGuVlj8Ecp6u/qMtzUUgpOe/Ws5lbSXPxpiMzaNVIojS5as2yr0NG3tuB97naUfN7IgQ68UYPP8y3NUqRqdCzfBAv3JpQfc2OM6Wdai1khj1xnsGHzHMAvDFwgCrILvtm+qFip9PwGJ6OVa6pc1kR2coyUyVcWtClUFQoMBYi8Upg5VYwTicSqm0/Ndt61WCo40iFqmE43pUCVKvQ3fOkX1oliPUYvqI9QXltkqbnhq4s1vfCWZvcyxlFO3dCx5v4FcPp3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH2PR12MB4261.namprd12.prod.outlook.com (2603:10b6:610:a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 13:46:17 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 13:46:17 +0000
Date: Mon, 8 Jun 2026 10:46:14 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Yiming Qian <yimingqian591@gmail.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	keenanat2000@gmail.com, linux-mm@kvack.org,
	Christoph Hellwig <hch@lst.de>, John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] iommu/iommufd: Require write access for writable
 MAP_FILE mappings
Message-ID: <20260608134614.GA4111154@nvidia.com>
References: <20260607085320.73274-1-yimingqian591@gmail.com>
 <20260607120935.GG1962447@nvidia.com>
 <38b49fb2-c2c0-4c7f-ac5c-3e79d54728f0@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38b49fb2-c2c0-4c7f-ac5c-3e79d54728f0@kernel.org>
X-ClientProxiedBy: BL0PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:208:91::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH2PR12MB4261:EE_
X-MS-Office365-Filtering-Correlation-Id: d4b69835-a714-4875-d08b-08dec5645045
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	MWY4UoP3GDg33NBbBWWbAlGZvUkaMin+nTshtEUY4c6dtfcN9Tz5PL6EPa5zbSIfmrqlK2fnSx6dJG655TceIq94tEP8kJhHpWHtsW63A3bDwbxLCGbiYXC06mZJ+3knzJmIBS7MeoLxkk3/EUFy1KMjFAHdBpJ6Gxz+nYwIouXqe1gY5Twv4j55KZ1Aafpvd4ZyEDoarmoSW7Xp8hxyl6m25cpGMlyz4r6aYWwwiXL5iQgvP8147e//tKk5ELSavXTrhTdJ47gLi8JIgKrW35khhG7JxCNoRu0m7W0UkNiqjB4bpQXxEoybMKT21Ygc/yiTsWlex6KYPPINb2hMaIwUg6FwTM4P7oHx9KbApBVcWzqtoRY5sdMfoq2NOVfZTU1vv2bhtLoZJYJzyKKbeebIb+sZPJMTJnl3hEmwSIq5T/l9LFBFGab8pyfY57C0J/hrrHydI1n+Deqiq0hQORXqrsCo6ECvDzlRQ8fnVAsIaFCOLdNakdJVkTtLowDgL5tMhiG1pbRVtBAWlADvtW9uXHCgDeHg7tVBtImdcvjuOhOTvhUiWNTXdIrJdzndAXBK5wxDEOKKaX8AzvLOv2SC38ufn6poq78CIly8Ewz7/NjR/zsAVJ56o4L0JxFWx1asxrKmrKn/3t20IBcAPp5dlZDohl1LbrOfpo//eYbs9Ez7Ads9vn4d/W33KWuZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+O97uql4uEz/BPsMISv76mZ2vZnX7Nc7FgiKXnwcPGYoEh9SQ1aU+joY8seW?=
 =?us-ascii?Q?AQgx9QamLfRo0cff91D1CkoiZ7H57/MrCuWJ5qu+xBcdHI5RsGC3L6t9PGjM?=
 =?us-ascii?Q?No8dFZ17j6a1B8Yb+kMEnsipmr6I5Pq/JYS4G6+lpkAROfYMlUpl6Itk6bTw?=
 =?us-ascii?Q?iA+gd9y4oVlSOc7OWBeNMakR3CNZwQ/Z0PCQVZcorHLiRGElzrDdx/AiYUD7?=
 =?us-ascii?Q?w9SEBj+4/Sp3Dfogl7zXWiHGCumexL7nznfSH1yovsf68opdDDS+84JIFneC?=
 =?us-ascii?Q?vFaqaufkLt6/eGqFCXYNeAavowkhrJGX8Kd9fHkUrED03blbhY1/8XpSwgkn?=
 =?us-ascii?Q?niTut0w+lMc6BekhZwKDyeqFoewZpFZnKhV6oKbmtt4PDHmbcVGEZXDgHscU?=
 =?us-ascii?Q?b8M6NecGkifbzdqoJxq6T9Io2OJv3ebWE2Lie2UQ2XVnymsQYQZZREdnhKWM?=
 =?us-ascii?Q?EJ1jOtFKOgXJDdM7lQ+TzwpHpEk/PqNZvOynKibGf5YYmJ3Q3/78MfTm5GdY?=
 =?us-ascii?Q?zxv6zsbr8fLjsNTKzMHQFsHWbqfRlIci0rJ3cmVf579jjKUYtNNwku4fz3+S?=
 =?us-ascii?Q?byMcJ1cQT1NJNmvtEvZsQ171kwHMr1nwaIeviKeSeUtMb2hTDD9dIwr9GR8O?=
 =?us-ascii?Q?AaHbwMTF9ebFwzDkpPDHjgH1sAx3kbOsHSUosWsIHiGm+sDwB1rtTXbbqFtg?=
 =?us-ascii?Q?ObVdqINnq6sX3yFxXLEl5C7PNAjtc+VlfxZ8FciDnXf5K6D/NggkC1HRyyC+?=
 =?us-ascii?Q?c7naDcwnLpFnjH61PfNOpQNhtfxGKGZPeBBTNjWVLAgeoqxsi9LMXcjVj9Xg?=
 =?us-ascii?Q?jf3Qy9Yc+X+NbXI/pUCIs2aQrsLJpuGus3E/hWms5sBukCYdzbrrwOki3q/C?=
 =?us-ascii?Q?TS9KDaDbg2Y57mpl84jIh9VkyYGPEo3MORNqbUQIWigEfzKi1vSBlN7E1MWx?=
 =?us-ascii?Q?pCKnC3PWlT5nuVpx9D7EBHAC+7PaVaN5ZJp6T3sWxnJNFpqsHg5M87gCcyDO?=
 =?us-ascii?Q?ogq8jyD7390z6ilLE/tsIuekv7LnF/ouU9DWPwnY9yL7dbTD4KVZ84Nj2hkf?=
 =?us-ascii?Q?Z8wwvljfFSNxNYHse6268OKTUT2j8RhzNYyYFq4e9HIuYCeraDJqNoDp+AuN?=
 =?us-ascii?Q?d+LX1gx8DOSH+MkhsfBo+rc3Kuvk+QcMtoy3ghzlytQoHtszpJq+pXxQZtPr?=
 =?us-ascii?Q?PI4Uwt7TEUTnFeENdlLMnjd8wcAKDrt3Hd2IzRIauWs7JopIjdQfDSQVV9J4?=
 =?us-ascii?Q?Iaw0Whjt6OqhAcU8K1nA5U1zrP6skS9N7oTb3Hd9PobHAVPABjkZvUZeOsgJ?=
 =?us-ascii?Q?RSWakyoTuYkmAV4WpDUoD9o2Mhmvq/305dYIoPNcFvPntCeOD1+47jssQWw6?=
 =?us-ascii?Q?IOIGlGarr+7UHpri0ZGUKke3VZ8jjZlx0tZbo+wmDBLyhQYqrSznXV7H4o/4?=
 =?us-ascii?Q?mJTbaBIn7bKVYrz21TzbJJ3m6GZ0vxEJ0aKrZq9sAhLd0psk0FRkkr5Jk4c6?=
 =?us-ascii?Q?sB+xo81E0rlU594HSE8VuLpjr3XE5/o2anfm6TzK7R4ro5AebdEEjK1Ckgbw?=
 =?us-ascii?Q?yx7vm24P0oKQsvOBuRfWga8utCwUABNFr/3NVP+KXjmV4+X8cYMZnn5Pg+44?=
 =?us-ascii?Q?UjG56BXcq/So6UaTlp9yBozScQgkKoFeSNO4Z9mJDPDtKf2Y73GVclUT/U78?=
 =?us-ascii?Q?WrV9TlF/IOChzXAeejKzRWFPNs6tLjSKsEJ/6RdZthSc3ZqT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b69835-a714-4875-d08b-08dec5645045
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 13:46:16.9115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YXvBCZzu3rG9D98ZeFxXIdZm7aAfpBx8KarZH8LU/rSufgVs0Lk5jVehfDxyijx6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4261

On Mon, Jun 08, 2026 at 03:38:00PM +0200, David Hildenbrand (Arm) wrote:
> On 6/7/26 14:09, Jason Gunthorpe wrote:
> > On Sun, Jun 07, 2026 at 08:53:18AM +0000, Yiming Qian wrote:
> >> IOMMU_IOAS_MAP_FILE pins folios from a shmem/tmpfs or hugetlb file and
> >> uses them as the backing storage for an IOAS mapping.  When userspace sets
> >> IOMMU_IOAS_MAP_WRITEABLE, the resulting IOMMU PTEs allow DMA writes to the
> >> file-backed folios.
> > 
> > This looks like an issue with the API design in memfd_pin_folios(),
> > all users would have a similar bug I think.
> 
> Agreed.
> 
> Not sure if it should be part of memfd_pin_folios() itself.

I think it should, drivers should not be open coding this.

If there is such a thing as a read-only memfd then memfd_pin_folios()
should accept the usual FOLL_WRITE and deal with it internally.

> > start/pin/destroy kind of thing to manage this?
> > 
> > It should not be open coded like this.
> 
> The permission check is one thing that's clearly missing.
> 
> Not sure about the mapping_map_writable() handling ... it's weird to rely on
> that when we are not actually mmaping.

I don't know anything about sealing, but it shouldn't something check
if it is sealed read-only ?

> Assume we GUP a page and then munmap, mapping_unmap_writable() would be called
> while we still have a writable GUP reference. Hm.

I suspect the user doing the sealing has to ensure there are no pins
to the memfd before it seals it. If it already let the unsealed memfd
out of its control then it probably cannot be reliably sealed read
only?

Jason
 
