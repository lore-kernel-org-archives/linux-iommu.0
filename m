Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011070.outbound.protection.outlook.com [40.93.194.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C22353A96
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 20:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784145793; cv=fail; b=IP8op/aETP+v+7Cg+b8RO9AhBarifyGNqfNarBYIcoERBrvrTnRWfxUTXQzeL+Pmr5QSpxhYvOJoA7ye5o7upYj0HeESpij0AFEMc4IrkFyzVLbBgzOR3miAuKRX50BLEpizd7wdVMEe6/k8Ksd2UqsEZ+W769p+z2pqG2Y+bDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784145793; c=relaxed/simple;
	bh=NG+y2w6Mq31ClWhxK75NPA8DJN0ga2wbrByYX43JIQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rJm3QTL70Lh/CGyXvA2YFYwr2mT5jDmydy0nvePkxwpdNxkZ/NCSMvsEsAsWECtvl25ggKZivlmNcbj855dr39UqlLiKKxdna81BaedWmAoJbM1bEMnSF0ovaaG3iVqqWeEWQA0XdU9//ubiYHZNeR4P0LpB2yyz738xM8O4nsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TYdXde9t; arc=fail smtp.client-ip=40.93.194.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TYdXde9t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0pI93BqlMAYqOFsxUa8mj7vf26+4M57ecJRavti4b8yx8+WxzsKrl00zWnj5nvKFRAYdkFOxxlXB0uOo6BB7TuYdLsnAr0nYDS6ilThVlZWiK1GeTiegDOmLsgM9dj50vVb/PzN6szxpmAm3FeoFi9FLbcDKlYkhpkNlHtuvOKWCkoJBIO6yr1kfOIZKyRPn7eJ/RKTC0lVIGmiKje0dz7Nb/yf4tyQO0d4U/ttlqhtwbwxq4Os6+kZWollBId8vMNthRqeVaf8ZPLwi2YDjxtxIritiBBHLemumNiU/3xPJYYCc14dybbByEzex54Tml+16oj0tf6XTwqU9IaaEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQhTZnauKGs/EpYk+jb6ylmK4plfBKPxtok5OKoLa9g=;
 b=YY2dVQynwEbJmlX4U/hXwTEyBMWKAWz4bH4bpUzSqzBeJslo/OV9h54c+Cif0L6QyBdymQ7OFsL4EHQjre9V2oY2bH5aHopH2MdqwTz9Gf0NF4Srf+ZyEPrSKd+ublXNLFGabznundY3+GbHNLQzTtChWdgb6Rg8MZY/uiXA32e0NLwH20Uc2Q3M2xumh1HI9LgQFVKo78fGGbuqn6i1RwFV1xMSjo9Y46GsHZdn4Kf1jdb2RjlMsAh3Pmrkf+FEQ/sHo1Bc3ggPkCOhpd8yrni6zjR3051gsBxRbEPtTgv5yH8Qnr3EIXLXuBYpgExbCaCVfuB0YOFHkuB29GrVqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQhTZnauKGs/EpYk+jb6ylmK4plfBKPxtok5OKoLa9g=;
 b=TYdXde9t1z9qGPh9xGGBP14BT5X5+dXgbRpGRzAXXKRPTeKqMywIn2kvaCb2j5GhL2W7+D32VUsjMthq/UQu3Jt9YdIiEknBPF9C9iFsipffD6QWlIRIbD/6N5hKaeFOYOhbqXQ8Dq/S+oNqgZURRxc3QB5ucSt0noqTSJP+800I5+eqk2xH88teedhoPP30j0Yr19qPkG44RN8eHGdeOJSAHgFPksNLtkOhxZRrZgNcrQnF672DvkEZVkQt0fnJ1CXWCZ5/wsF2qy+8gdgoiUG7UlokvfxYTi9SvfqdoyI+DRl+sMefYDFl5AwJ0QPBo6YWUBMO5kvTtwT5J5zPLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW9PR12MB999208.namprd12.prod.outlook.com (2603:10b6:303:301::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 20:03:05 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0202.014; Wed, 15 Jul 2026
 20:03:05 +0000
Date: Wed, 15 Jul 2026 17:03:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
	Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Pranjal Shrivastava <praan@google.com>
Subject: Re: [PATCH v4 3/6] iommufd: Iterate the cache invalidation array in
 the core
Message-ID: <20260715200304.GJ3775915@nvidia.com>
References: <cover.1784054606.git.nicolinc@nvidia.com>
 <10d92026fce6d6f3e74e1d41edbd03da8bec7e3f.1784054606.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10d92026fce6d6f3e74e1d41edbd03da8bec7e3f.1784054606.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR15CA0059.namprd15.prod.outlook.com
 (2603:10b6:208:237::28) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW9PR12MB999208:EE_
X-MS-Office365-Filtering-Correlation-Id: fdb8a7bb-3741-4279-f445-08dee2ac1537
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|6133799003|3023799007|4143699003|11063799006|56012099006|5023799004|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	h053wiGJpIa9XYEZWdvXz9Sqzzc6fsQEI0mH7ApJDXDFrlDM5X3SbjnecRwzNfxlXLCryulKWLDbxG+4ZnQTe43Ufx0YIedgmSqoyS9sW3LGxf3vE8elkUZToGLs3972uo1qAToUNRN/Swx/nVSAnM8Tzu28fHPYH4Tf/nq1KQilKAUprnrYBj692fb4/A9mZjSE+qUb+rl3cvPM5ti2kkzWc6xUHOwKefh/l4qitobmOcQqEvejMu4SA3EHG0643iOEWEnATJA5SGBrsGCcMwV4US3pSZXrHD+zl329mTCHzKqyEo5whqcGkmwISuF/6RiYIZnzB54UqcNQyCIB8xCUnkCT0Vg8ht4hqdSTKxM99JrkafwMje3PkvlDSj4M/1zgKzCba3s2gMk1N7qFjOfkWwZoqczJUjgg33us+GbeD2OJ90PjU7NJRlRqGfj/jERi+L1+L/pWJDRRwqzhfxd4sxqa+TaEh9kRfv9XLHiDJlkeuY1/N0BB+8ap8R9a7+G/WsRluWKbjQntltZfiiizaTWaT7ZajOkounu1OZ5TnWC/wA+7p/QMx9QsuSwgGvF6GzHCV+fAUGI5q0v5lzjp6ZVrs6Ao5pRS4BehdxDbTwyYrEIkGJXpGXbofkaxi+NOG8Nq9NNRex79mAasHsVh5wm80ZGRKpzZDd4zMJU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(6133799003)(3023799007)(4143699003)(11063799006)(56012099006)(5023799004)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n/pj+9yV2sTU95zc2jci9uWGb054jVtmRWTFhh2kgIVc+Mu6UIndBPYYfmJ2?=
 =?us-ascii?Q?OJbnMP3YU38cLNgNNm5X2VHKVChcJj6ZWni+LUdFdmDTF+scx/hG4tpKCTNe?=
 =?us-ascii?Q?RY+5KZMgA6y7DMrf/dMWONfuc437ItqCMUaTCg/e0+okc01Ab+OiCx8Ws7Jw?=
 =?us-ascii?Q?lZeKeIOuXzD+i6WkAxx3Jkc4imUvaU1U7gZJ4uMQxEzNj86+EbuWIlgpNhxw?=
 =?us-ascii?Q?UyjxDE1Oz4UC3tV8DsxyIVvzel7HQWDyz6rw5vWlR86HDfP1kJzvYC5RCOCQ?=
 =?us-ascii?Q?obc/YSp4tu7qv1tCs/zt+7VcfG+niQ5vH22e3f+xgNiT+Xib1rQuBfX/eDXq?=
 =?us-ascii?Q?SOGHSHmtcVoAQ7sIuxXV+Lxnl5QjGANGd/SNJO3UmJy6TlLMermS9WM7j5AQ?=
 =?us-ascii?Q?B12hDMv8pHGuyMFyhEo7S1ADnUG630dgqL2qh4N8h1KWgud/+23B/gfxGVa/?=
 =?us-ascii?Q?ZUBCIj4+xJVaVEJj4pewkQgJoMiymmNMrTWRFE6zuePqw4yKZcXtyPnEZVvu?=
 =?us-ascii?Q?NugxxIKlqwArUUQxTGZ7hCBVjFyHGFOxETqR/lFsc72CU/4LnvZkQcHdNKwL?=
 =?us-ascii?Q?yj9/4tDfQ1pj79rt/eCShNIsasGp9qRYHEy9BH+45PynUSIQ66eez03929di?=
 =?us-ascii?Q?vxA2QuUDpmb0A5s08iFmK8GCW362RpTmk0AOH+Eo2I8APHmTDtZ1lHSXWtKi?=
 =?us-ascii?Q?ymbXDQd79DiJbAjEIA99ZaCu88lbNDyHThE8FlqbGhX2CvpQaghwkNWKAEiQ?=
 =?us-ascii?Q?tvsdjIsNzfa/EG1hsUpNrE8OEuR1xziAmgxlu0dBjys7LeVDXbkW6bUYXoAH?=
 =?us-ascii?Q?dnAtpggl36RmPlvOnepnOJXmLmelL1LYsGubxzjOBLAinpvZW+rexbB2VL+m?=
 =?us-ascii?Q?k7/qYyz64euEnpi54zkIeQIrTuAbngDrWAf294bkIUj1yjz3utFnBqZsResI?=
 =?us-ascii?Q?YzeiFFJ8uM/LwmnJJqVwbomtHRS7pwT0FtIrSTpej9JeshVdEZYom7/x5ibJ?=
 =?us-ascii?Q?cE7M1zp72nFTjMG3tGgBrQYaSu6rTL40oIJ1RbFoI7+D6xo2wnNlBALzcWAA?=
 =?us-ascii?Q?DN3B3WhPLl/YbXhztb9m7GVnS8Ybm90rnhXxMHWYdlj99wXZnSICzUkee34t?=
 =?us-ascii?Q?XSSoeuoHaM2lom3+WOFAwamQgHwuy7gk3eGywnS9bDsCgTnAHPY6ctFbTrnm?=
 =?us-ascii?Q?Pfoyl6tWuXSsffSL/SiIINueKIB/I2KBTY8bEB335cHlIU0Km8tCEsW96cP9?=
 =?us-ascii?Q?kDSJu3qvVUd1JbeaUYCUIShzinAuAET9Su6JFVpNc2y0vIXlFHE70VV3sosY?=
 =?us-ascii?Q?9cvyaS0VQ1NYHYjgq2EtFkbz9wFnK51wVq+/LWUhzr08cCVtVxExDZbmjBqI?=
 =?us-ascii?Q?ZkHzwIhOYBl12KXMqtI7x+st9fQKAtyEYIWwi+aHhRijvvczjQdNUwLd8uqv?=
 =?us-ascii?Q?s/TOf0n/3J1yVxgMrc2dQ+98yDRJ6nPK/n5Tf1akEp/4s98qELskjFjxl1TD?=
 =?us-ascii?Q?qK8i0rkU3+IZtOQswSFxp8JxFdg4ovmiLa0XxLo1IZIKZgiAfyn39hYrcfMz?=
 =?us-ascii?Q?l3IzrVltGCXJtAG+dLTF3hD0tNCt4Zk69m9PlsG9q+aUl2BCWEOgc+YODRCC?=
 =?us-ascii?Q?PVjw1lm488Szk6xSUCeFQzAVZQfGAkveC88LoWdelTqI/bilNIuNiZ44SnKa?=
 =?us-ascii?Q?bOl+iLZ/7t0Wqlp/E77WQb8adVotyEjZKPTwTYu024d8zfMi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb8a7bb-3741-4279-f445-08dee2ac1537
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 20:03:05.3309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y8HMBYURVMb99lcd8XxdA0wpFDQXb+/vMnojE1PhcOiMS7ipZ6BEu30DvpQtnwq+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW9PR12MB999208

On Tue, Jul 14, 2026 at 11:48:49AM -0700, Nicolin Chen wrote:
> The cache invalidation ops, cache_invalidate_user() for a nested HWPT and
> the cache_invalidate() for a vIOMMU, are each handed the full user request
> array and report how many of the array entries they handled by setting the
> array->entry_num. Every driver therefore implements its own loop over the
> array, and a driver wanting to process that array in fixed-size chunks
> (e.g. to issue commands out of a fixed-size on-stack buffer) has to carry
> the loop and its sub-array bookkeeping all on its own.
> 
> Move the iteration into the iommufd core instead. Invoke the op with a
> sub-array that starts at the first not-yet-handled entry, let it handle a
> prefix of that sub-array and report the count via array->entry_num, then
> advance the base pointer and re-invoke the op until the entire array has
> been consumed or until the op returns an error along the way.
> 
> A driver that handles the entire window in one single call, as all of the
> current drivers happen to do, finishes the loop in just one pass, so this
> does not change any of the existing behavior. It instead lets each of the
> drivers convert to bounded chunk processing on its own, done by each of the
> subsequent changes.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/linux/iommu.h                |  6 ++++--
>  include/linux/iommufd.h              |  2 ++
>  drivers/iommu/iommufd/hw_pagetable.c | 25 +++++++++++++++----------
>  3 files changed, 21 insertions(+), 12 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
