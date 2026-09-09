Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010043.outbound.protection.outlook.com [52.101.46.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D6221CC5C
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 16:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788971637; cv=fail; b=vAkWogTAKuiQohBaE5IEOSkvAC2l+UE4MAqgQz/ffv9nByOdNj80AWENqFCg6WspUmlzElwsHqScm/6qg8OwwuCQbDMPDx43cH0B4o6ENXWLgRomwZetYZl6OU4vMCf1bxzT1LGMOJ7WcWIP2oOQfocGQlepdnFTxLGDjrZ/3LY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788971637; c=relaxed/simple;
	bh=Ajz6op220DR/KIeaKuJfj/xH12Eb+SnqeoF90inOfOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SOEMhLUSmsfEo+iD1AXCDPEDaWlftzNHDX/sjMSMHE1W4S0ZEpLjg9i/EcB6fU2Rp9AvaTO0Dihd3HJkezio+djlYsKDvVJ9bcsIMaSJwHYtZ8F2Fk4/yVsmG43jvLCwHXwVXee/HCqz5YMGs/1zAVSk+isW4gWPxNXUxYGeowc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vz6eFdwV; arc=fail smtp.client-ip=52.101.46.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vz6eFdwV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kUcyOiasd4+MUeecObdrdJQCzfob7f6yDlj3aGMOhKOmUGV8SyUOnfxcL+Z2lFGtMz16cDvy+sdih/9hGEL0uFZyDdFlcqBCWElYqkvVnaK+vAS3o5+H+mulLVOQ1JaH2wV/qdS81r6AFhvYfunpRZmXenYGhhmPla5puU2oau/+JT5I8laT1W10e05zW07c/slg1X4W7Sf38v7JmHUwkNIJTA0dJmazAZvjHAtog6lPQxzeGg7EwrTwzgLq3Qadorncb3iUVXILTTSjrsoX2KkchEQtmOI/H5AKVvjSbTX9PQPseYDBEZJbgDdfVUhrgLvTwDrHxJC+TqdtxPtiiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1f/qeH5iOOc1kWFb6LcxidQu2HZ1C5v3xVrB7typJc=;
 b=khEf4Wu3tcKM6TZL9kNXEJlqUDJwavlDuRyq/i3cUrMSdXW7kzhil+wkV72gRzTknxpqP29fN6QiV6axC/K4fwogqo1pkV5DGJLRenhkILIcjKc+YSKgj0ivaW8E4ek0z/uMLLFwmDOwUgvuAZsXctark7zXgEDJhquURLBqV99wiHxLZyGbnyhT1YjgDm4JpkqPVVZMyd9E8nux2c/ssNGl0J10SE6K9bZEa9v5rCfqLm7yAIzGXXikc8sUFobkxHkK+PMgeu7+qesu2PgFa7i5T+mSUa4dMOiYR9KXv8ZqYJjjWOG7CI5lnKhaTz9es2iKGzcOIuoXfeULQP0A4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1f/qeH5iOOc1kWFb6LcxidQu2HZ1C5v3xVrB7typJc=;
 b=Vz6eFdwVeDLyGcxlx12KO7liUAHTdJXTNiMAfhLeOv1uUlAtdttVCoTB/ktCb9QH8hXVZvyfbBNWs+Bw4PyVUKNdlg1W78QeYyPTczdfLoYsiNLTMGCy77hi/tUOkoawklrxHtD98ug/2PnCRyOYOICvovaBZM3B05h5BVkyBP7YBgf03xtf0CdXI1lkf6d613v8egf4hbAfT5y6ZhHr+0S7N7/DpOq2P2IrV8sO248lzOgxP0n9OAM1TBGqEx9deUSPhYagE/6CSLU7QREN+m70WNRp9NZm1XRaFNwYYGn4DvuBxB3Jo8ma91hAyERiJu0QWIZfCd4j/Oe1jUT0Og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB5832.namprd12.prod.outlook.com (2603:10b6:510:1d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 16:33:48 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0406.007; Wed, 9 Sep 2026
 16:33:48 +0000
Date: Wed, 9 Sep 2026 13:33:47 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests: iommu: skip when the mock device is not
 there
Message-ID: <20260909163347.GA4146467@nvidia.com>
References: <20260908214825.2682078-1-eva.kurchatova@virtuozzo.com>
 <20260908214825.2682078-2-eva.kurchatova@virtuozzo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908214825.2682078-2-eva.kurchatova@virtuozzo.com>
X-ClientProxiedBy: MN2PR01CA0057.prod.exchangelabs.com (2603:10b6:208:23f::26)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB5832:EE_
X-MS-Office365-Filtering-Correlation-Id: f615dc1a-76bc-49d9-37a2-08df0e902012
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|4143699003|56012099006|5023799004|11063799006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	QGtVEln3/5khIf4MK8Jp7p8BQlQRANqQq36q50FNljzJ0esohwUpYxBbFHrrJMIZGgF5rBKBHWgELQgsGg6Fza+Vb5F/LnPcrEens1d6kNJKRGdSLS98yTFPqvp/A941lcg5IAudETj+7IrAa++DubVNUlnXdle4D4eTTQJjK+oBKRDATvfWc/39STAg4sTHJO4ZUrAqMTAdJflJVfevdpWzP+MEbMr2qsC3wu+6WEbmLjMW75+jc7K9pGrveDEfqojsz9Ct3HaoO0hDRH7bbrw4QRfeniB/nfDl9v2aSHaWJ1EF0tOeG/u4feEOzkgxjl14x49mDDImVi7radOR2gGXkTmtvp/l0F1A4BzANhAuy25cL0oH/cS/o48/hos7LVkDLo3KZMUyIg8zOqMlaW7Kx+UQIomRTqZsN1qPuWqYup/fAXxQdHvcMcPlq0SS4ITEB8E6SaPEfxnhQG5o6JzMyIwrVuJKYqggtu+/GRB50nwbRdRgAD6tNmxEiy7Zivsnli99TBik9H8J77SwiJof735X40MZvTt7T7VkwkWBk4FhGfJAHVshgKBK2jRKVzpohXbgXXbBARR0+lQrKH0WzuAikDHtGOO1CYtjNounnwe4MLcY857xipfVLJYplVM+2sxpjnN7GGUGepQ5sCQaJYiTfsav/KwW/TB1q7s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(4143699003)(56012099006)(5023799004)(11063799006)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qKzA1aiP0qsUKvvDcQ4LLRbXBrR0PpVjw30Wk5COtrqi8rZg9mP7Bq2pFjMG?=
 =?us-ascii?Q?Qpwswq4PjKCn0UCGFkMYTFyEsn6bOKkg+UFKhENnj8s3r3Q5lPO17laYVMry?=
 =?us-ascii?Q?BAOm5iLs+TvGVigvOLDeOFSeu4UXuXhvH9pdTwVEC9YxLoKPb9QTUT6kKCIU?=
 =?us-ascii?Q?AWKT+x4s+dw62dvFdjPVnJncDLnGwGevDYcb4SgezFvNgTl1+4+OCvsnkW8f?=
 =?us-ascii?Q?tM5EnGtl6fPjdo2PiJmqhpbTaoG2vEu9rw+J9G+hGTsy8J3SerDWe9cwxoJt?=
 =?us-ascii?Q?GnhFXHQF7A51I7mMzBuJ0XWX748eg01+HwTmYSnUAPq+qJqXkUSzvX0R8IT6?=
 =?us-ascii?Q?rAX+acLlC9oyvCo7Ey2+NsCkb/D2UGpd7ikHTj5hfiRSvyNlnYk980UOu532?=
 =?us-ascii?Q?m3XUZibMpFuMrQ7sFcemP97y69g46EtZ4evEvLtM3uFNN2k/hT9KL2fU++zA?=
 =?us-ascii?Q?VxiXg6P2vi+stI9M2os7bgm0KhJchKi7NGlllgb8hCZCVMCOHCgZE6TKLFub?=
 =?us-ascii?Q?uDEnLWA/3W0bAdOdTTevin6C59MRmW2aMiHh1vaMwlnV9gP+yfulX42XWEmc?=
 =?us-ascii?Q?44T2UzLz5SzGwlpjJIZbxWiPlEWqSsJ8AqPPOu0FlkmA1kh+7kIBi9Vba9S1?=
 =?us-ascii?Q?I0cYzSKsHG1c7EHmZHkSmcMui9iRR5g9FfI0GWO6lbZ9KIGsFXEbnkde0yJ6?=
 =?us-ascii?Q?vKg1035XiEAqIzbGUH2MfMksVZz72X5CGSCoMcCohn0Dmjlnpb6JvgppzDBs?=
 =?us-ascii?Q?rXk7zBQ7xH+R5arsINpuBTlvfb+o6s8a8XuueeIpv7cmch3kwjiMSIrhwYiQ?=
 =?us-ascii?Q?JxRhlZU2uVJlhtOpRAznkj4SLrPdSiFKB2wsY4mLg/a2FMvlc04ILO9dpGQW?=
 =?us-ascii?Q?ovhFXnnDj+9gyU12N9ep5RF13QtKHqxUjGBxyFb/N38p/V3elczbyni9I5iy?=
 =?us-ascii?Q?Tkm2Sxq8icgbj4sWOEglBCCpao3KajaF8vYj8i5TKUHb35FkjrbS3ZFvrLFv?=
 =?us-ascii?Q?vXLoL8SUAsmY2K+djbDzYWjG+jz0LF0tlj6yb8XTpWZEu5c7BvNzwchP+zmx?=
 =?us-ascii?Q?xUcUWeY6XSQD0oUUnTKYQ42kPDgR899dyt1RduLOR9NaFTHboyuxE2SkcyIG?=
 =?us-ascii?Q?0hajPxvrWreEt/b7ia0m9JkKgHQ92yMHqMil2O8VbBkbWzfDFkfpSTasZsq0?=
 =?us-ascii?Q?AhSMuZcBk/FIHpKmMW5qT3AEqdsrukCtBZyWZ/sP49nWyJl/ReTsrlGjyGKx?=
 =?us-ascii?Q?sXkzQWj6jnkfaY3H36b62/+Ue1RYyqqijjvsLkRcg8DY3PywZVZb+9Z3S8yy?=
 =?us-ascii?Q?Tr6jVBVPg2qknQH6SjDVAMz8FCHzk1gToadIr22sLssAv0FJrrnvNA5R5NRb?=
 =?us-ascii?Q?W7JYZlijZs8VkENkGkoWhwcXReX2SUroqEMLh3Nxs17WgDGIn+yGtSGa7lJs?=
 =?us-ascii?Q?SpASbtPyYXvEi61HBZCUOVzCOdSJTqtBHHM4jNagx/fB3sy/7czUfiz5IOFo?=
 =?us-ascii?Q?WmBHkcTcM8aeV2MB5WLO+nFdQbYghnPtO1QWHypeo4dzc8WamWPKyWQwNfeh?=
 =?us-ascii?Q?QRxvP0RtbHBFzp5rfKpMWfQj9e+I8keL6idYlzSba2FxVjCJUIb6812eW3E+?=
 =?us-ascii?Q?ALVA1rJIUvqfKI6MpdAJ4GL1H/+E9C0RvfwjXj9cPu60u0GCB3CuV3LnjVYI?=
 =?us-ascii?Q?17iBmFk7CJhMf3gaZkVD/wdhq2P4ZlbEWBpQ0/ki8Xw2Gx3H?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f615dc1a-76bc-49d9-37a2-08df0e902012
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 16:33:48.7790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qVlofowpyIhVdvEbDsOqhDttcwlw92eBVo1WNoqWl8DsYa6FGNDJ0gql+SImISJs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5832

On Wed, Sep 09, 2026 at 12:48:12AM +0300, Eva Kurchatova wrote:
> Both iommufd tests need the mock device the iommufd module registers
> under CONFIG_IOMMUFD_TEST, and they open /dev/iommu in every fixture
> without checking, so on a kernel that does not provide it every case
> fails on the open.
> 
> Checking the open is not enough on its own. /dev/iommu appears as soon
> as the iommufd module is loaded, which says nothing about the mock
> device: the release config here is CONFIG_IOMMUFD=m with
> CONFIG_IOMMUFD_TEST unset, so the open succeeds and the tests fail later
> in the ioctls that drive the mock device instead. Only the debug config
> sets CONFIG_IOMMUFD_TEST.
> 
> /sys/bus/iommufd_mock covers both, it exists only once the module is
> loaded and the kernel was built with CONFIG_IOMMUFD_TEST. Check for it
> once before handing over to the harness, rather than in each of the
> fixtures, and report a skip. test_harness_run() is what TEST_HARNESS_MAIN
> calls anyway, so the tests still run exactly as they did.
> 
> Signed-off-by: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
> ---
>  tools/testing/selftests/iommu/iommufd.c          | 15 ++++++++++++++-
>  tools/testing/selftests/iommu/iommufd_fail_nth.c | 15 ++++++++++++++-
>  2 files changed, 28 insertions(+), 2 deletions(-)

Applied thanks

Jason
