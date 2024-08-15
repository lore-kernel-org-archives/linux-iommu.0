Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E24112B94
	for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 23:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723763104; cv=fail; b=Zve2JRx7wh6BO8+g5s6sTZF5XOEEL29J3nkeqQbNlW9U1Xm6HOROUvCTsNQUQUkTKrDkmDqdyEGmH6cNDBckMsTyVIPULG24MfxzwhdrU6GyOLuLLepPPGQ1T7F7sTqhUgNVlE3k9Ug6QNaKbvLkeqxBDletx7qYu4rZxNroLHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723763104; c=relaxed/simple;
	bh=pD/AafAzLS0clgk0qLKr6BITcgFlOZZVd35yIYghQI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DXq3xpvvohAF5gul4TdjSpIOfgxmAeCZHKhb58ObEVZ1TuUgf2pixfAb1pnG7k+Y0g6o9Eh/EaxL4LHTrlQq1dikU5MUCdahPVWBbKE4XYXa6hk4uqTpqJQtutAcUk9tD5zS0A9VfO9Q8Sy44an3NCAbBklXAVE42X0S0AJnklQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KkWD7U3n; arc=fail smtp.client-ip=40.107.243.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KkWD7U3n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iycejGTu6cE/bJVeZGvoGi38taIo2uinwFfGd5Lx+dlQRbB2OQQQ2zF7RPsbswbVW6fqsjGrkOQJ8unjW921kKjnqSUKDrmZ9ZYrEzqXVbgWQQoR0Cq+yBcj0V68BwK8JjVUcww+wxLUnCHjojxhTIH7ADkYrcmuxqNzeY3aOI0US3TmL3wDpIKwj5ZUatgVSxxZXZd4gn0QCu72ttiTtlBgwxyk1E3KISa3NP6br7laxQ1ifp8gHBIpjFYa3IepB9pIKIq6lE6gklJLHx+pt7L5gUsMwfidHn2yfgy0fBlMzInX9SlcuiKWmSnSbe1SZRCkscXz++My6ratflgkEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YMnFT07uwzxveC/yeXzZPuJR9zD0DJsOXSDJ5SsvPg=;
 b=R/bEo/jvz/+IDytk4iQuZpL3vHIGIGMK6dq0gogYMsOI8sYJvAA1jG1vj/EDvyFxZLyTEWyEHQ6ndQyonft6Hw1TC6GK+D7E9GwHsig90eIBtUqIVxJYq/eEyYON2AKTrwNOUyWudBfJTEUztnMm+awkacQJlPwCt8LuoCDPXVa/xzeotgHe2cOKXMaPSiAaDLzC1yi4aeRrJDt5dq4qYP9hllJ48MygiGEtJrnHz1IQ2YbuSzp1WJX1LYGyH3k4G8hCDYqF3X6s+Sg5rroXeRpDGtAr5e9793wU99UhLYT5P7g0N70cHmWzi65qR2PCPAl8kKEb0NK/AuKoLMSaSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YMnFT07uwzxveC/yeXzZPuJR9zD0DJsOXSDJ5SsvPg=;
 b=KkWD7U3nu0AJoKQDHQCGtHtfGnEnXWC1Y1YFNk8eDSVDyN6sNHUpKi+RJEe7Z0t/7N41rbyMKH79539G3rAKhhsmcI5k5TXoQIItmAfjbPqiVzp2tyznIGf87vE+QxRSCDP8BY4cOyhtCiviJQgbtBxfgs5OTUz9LyMam4NovJnCc967BUVUbvA1oBdaXe4nQRHuaBtOn/xd1qzgzgDHsAI0llILu6bswXsfu+OSef9ObvyuZtLyc08Qzdz0KqbfiomGBnwG41Yiu+nXSov3er3kTVgf1SvaQ+6RO9nkVK4XQ7p65FpjH0j8JGlPBV5fjMrbHiTkZ59bmdRp7avN3w==
Received: from PH7PR12MB5928.namprd12.prod.outlook.com (2603:10b6:510:1db::13)
 by MN0PR12MB6149.namprd12.prod.outlook.com (2603:10b6:208:3c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Thu, 15 Aug
 2024 23:04:56 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by PH7PR12MB5928.namprd12.prod.outlook.com (2603:10b6:510:1db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 23:04:55 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 23:04:48 +0000
Date: Thu, 15 Aug 2024 20:04:47 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	Kunkun Jiang <jiangkunkun@huawei.com>
Subject: Re: [PATCH rc v3] iommu: Handle iommu faults for a bad iopf setup
Message-ID: <20240815230447.GT2032816@nvidia.com>
References: <20240815182423.446137-1-praan@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815182423.446137-1-praan@google.com>
X-ClientProxiedBy: BL1PR13CA0222.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::17) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	CH3PR12MB7763:EE_|PH7PR12MB5928:EE_|MN0PR12MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: e8db4636-2332-4919-d273-08dcbd7ea981
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZREPVawbTlro1U6rXJUaIZX+aweZGoX4EfxxrMuA3i/S4vSLpiPyo3IQi4Hf?=
 =?us-ascii?Q?P7pMI/ryAZdII3xcpX8OuaQczX86kO/OrgcJZsebx31zvcWlfVcMUr/iq+0V?=
 =?us-ascii?Q?GRiGul8LcY+pXrj02bm2S1DLHDcjvVXmjHNadA61FjuUym3KIFve0T42Pcas?=
 =?us-ascii?Q?qw9ItD+d9Jzus9Afu6OO7S3G5kKMUooMUXc8n1of31uoNQNpUH7knGODGhXM?=
 =?us-ascii?Q?c2qsaV+ZRCW+fnbt3/8ev/zb9ZmUpHNij9Uo0qRkm4LFlYpqap68G4kJQcWK?=
 =?us-ascii?Q?MEvY3z3htHJaF470gAyXSTYmKzueHxqVR4xN/bDXZIs0uPXu70QHZlJ4kq0l?=
 =?us-ascii?Q?X/WU3L9OOVesE6G9B4ARVk4VUs/eXnUKTKteD65BW3aficexP6/90RcQJbMk?=
 =?us-ascii?Q?uEK5xBfoL/j/t/Tr3sxO1iPBGoq8kJ8Zjmov94wUceQVFp9W02bbzvSndYj3?=
 =?us-ascii?Q?AEuLlkJ4dkJJVQCbB0Gfmpl21GwrYKnz1ib4ReXjqOKskI8pPyqZeYsW7t+v?=
 =?us-ascii?Q?Vgdqui//NNfZOyJRsjbC7R67mCn7+jiuK6tMecfcF9bhkBbiPSwSM9AyoWeY?=
 =?us-ascii?Q?9dBOydox426zRI7ugl99HTJ4hVzTsaNunPEWSNAXPKAcUbM1jDn/fYMzL1iZ?=
 =?us-ascii?Q?hAgMnZIpz9DRW3zzb+/NV1zsO0U2EIjcGk8Q4aJB0KfpOGOJGY16AweAehsP?=
 =?us-ascii?Q?P9Mktm74MI5zZZ6LkMrtLiLxlZMOKmhJ0EG+axxFto3zKJL3TDkJXdPeRwE1?=
 =?us-ascii?Q?TmpXg9xgNivVmZXSR/ABVovwU36NhVwRhVtns2hIPzK4dzBXaJnUrSrT1M2g?=
 =?us-ascii?Q?3nmoaPm+W6Gbg3TO/GNIHOISzAvhThEiRxgir0UseUZMyjp74dxJW6Q8f/xX?=
 =?us-ascii?Q?EBarF8zXz/8gt40/z7aMcfx/2cpL2yxe+EIryv05wFNqaPrXC0DLf3gPhSus?=
 =?us-ascii?Q?n+K9gM54jeybOZySz74MJS/3amXLDC+iQDyA3nsZ//ClKwspHFdX9ByrAO/h?=
 =?us-ascii?Q?CwMAsPafNYkchoMlddunU42R/bQQlsNB3U1XCJwNSMVRvZVnZ9recYHR0z7/?=
 =?us-ascii?Q?CHbFtbZ/sBtj7Uv7jEDKNgcjmKNkBLH3gjcWzCJ6p0bo8+Uw++X6TG4497qb?=
 =?us-ascii?Q?NpoLfVKNAhmNtCBrQcbgkg0oUXqpUzbtwsciSonzjm8teDvKNnlz7QfBMLUG?=
 =?us-ascii?Q?YlSVdRAYKKeB28kk8opC/C5PT0yy0vdJo9YJproSsrdoopD80J/syy+9yyg5?=
 =?us-ascii?Q?OfT7My/vrEorKiq1veksHsAI9kfAmU158nwUKX36L3bBtbyl0jcc1F+aM+xm?=
 =?us-ascii?Q?gwc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5928.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IrRio2CmLFW1KCU7Fdo6u3ptqh1qiC9KVSTm/ZLiq/pymBmsZjUQc2wjoZy3?=
 =?us-ascii?Q?flAlalGn5TLM5udNk9GS1ui7RFUNIZaINDYG0ZPy3jB8MUqSLVJFJFo9s1RR?=
 =?us-ascii?Q?YACJ+MZLlVWYhfXBKjPQE58U59TybYaTSHBbsd/hRIgAoKm3I556YhfJYGuP?=
 =?us-ascii?Q?y8wnk6mGUxJlJokI2jovdpUWQEK1q4O6pEpNj5gbXLhRjIyEeVBFXrNiuNq6?=
 =?us-ascii?Q?1Kc/Zk2xT5+AZqxzzUMP5fWDjcCI9ursiPY1Hmhe3hG3dHAFl08e7OVrez3L?=
 =?us-ascii?Q?+KQofQx4A/4MZT9yYK5cPt5XQtkM27LLKDFT8YDWxC3QqlJB1G/hsx6zvDL8?=
 =?us-ascii?Q?sva4tVgUriWWyL/FKSrj8BORDoEbdqG+mW3JFjaB2fjgwOYmJGI9sVWeREVE?=
 =?us-ascii?Q?mHQ8LNlFEuSIkvWtRqCzCSW3yq/Q7wApPwiSIPihuVgeCitMDDMyUufF8Tlx?=
 =?us-ascii?Q?WcE8jYHvqXCsrxTL1Ie5ChFu8J5NaVn92N7zT9zeuobR58C7rKns6w7PS4gs?=
 =?us-ascii?Q?mN+BfhlzO5zdClyFA5DSMbEwNEkmpE/7fZlp8fYZ6406CP5AdEhmW5QroV9B?=
 =?us-ascii?Q?v3Xo0alKIIqDynVT18UrZbdD2FsxJJu+6/cYobdlJp0ajVC/7N1kT40yg0xS?=
 =?us-ascii?Q?kOB9IOM69AromqQTSM4UFfzowHd5YOD4yzWMwRH2fL/rCz/hEG2ssfQXwSLf?=
 =?us-ascii?Q?WfYBRapfZ1aMe7cvzORcvB3aajRF4dUGIhk4FAWr6R2kVlFkzYpBvsEZvOyy?=
 =?us-ascii?Q?+MORCTgWV6Llq4X3cyuddh6bPKVrmoHCTuRfSHkHYHCn9cXPAZtvCvh0JeYv?=
 =?us-ascii?Q?I+NTy24S11d5+EURlyt/qcgu0et7+OHI0/ymekFzOiwrhlAGmHl5DygiiYB0?=
 =?us-ascii?Q?ZD+sBeS0KZMVfPbe+xbmrRTMEwctMB/sjM+V/xz73aaALV75xaQT30YLgdQx?=
 =?us-ascii?Q?PWSssH2bA8qodkaIsMueIDtuM5v/UvzEOa9/5wqQtfCojqNeUI1jLSzz60Sh?=
 =?us-ascii?Q?viwnWlZnl231CMYKygC0mDzBnTc3o42HvGjsD89ejHljvOGwP0o4jSoA+zFH?=
 =?us-ascii?Q?jW3ejtKnxQj+X+Ngk3kJ44kEfZFODEM1ftnsSnm1G5P+OBNiK2BcGhFK9C7U?=
 =?us-ascii?Q?pUToYpi1GRxp+YG4sanW4gXSsfpmkUK0Z/rnvatIcKkCyowU0iLQXkbJPlaq?=
 =?us-ascii?Q?aAy/EpGhFNXK7PYBPypqP3W7HuhFCied72KTBcJKrEA7k6S4gCYz+gPL2CXd?=
 =?us-ascii?Q?Us4XYG/rEXcpq3QysxE1b5ye4TeBGEwyuH6jmOUGCDElc8gVAKjSE4uMmeep?=
 =?us-ascii?Q?aBJA55aM23TPZI11i+Iyyr938UtqU6egYtvpEhjkiUgDl5cbEM5RJ35+QY+H?=
 =?us-ascii?Q?ZI4JmB7fQVcqBaQCwF1fp+Ac5lD0aAi61q0BEAT4xeUrpSNfgS9bSaRLOO4n?=
 =?us-ascii?Q?09LS4wuPX+R5Y9xDN020uSgjj0iPpcPBcRDpGt7k/u5fnuIwhAmJwgNnjh9X?=
 =?us-ascii?Q?JXzaR0h4WlK9+h5v8QqmeFRwuChKTcA/+BUJDrFFFeoc7xFMQo14yx7U4s2b?=
 =?us-ascii?Q?749GnhvGE5YIPAU/GV8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8db4636-2332-4919-d273-08dcbd7ea981
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 23:04:48.8703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KoG6UFExAKCLrxzHf9IlQWEIByO93uYQwrUm9FhMrjJCW0AIJWugwIU6YpfYaGJy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6149

On Thu, Aug 15, 2024 at 06:24:23PM +0000, Pranjal Shrivastava wrote:
> The iommu_report_device_fault function was updated to return void while
> assuming that drivers only need to call iommu_report_device_fault() for
> reporting an iopf. This implementation causes following problems:
> 
> 1. The drivers rely on the core code to call it's page_reponse,
>    however, when a fault is received and no fault capable domain is
>    attached / iopf_param is NULL, the ops->page_response is NOT called
>    causing the device to stall in case the fault type was PAGE_REQ.
> 
> 2. The arm_smmu_v3 driver relies on the returned value to log errors
>    returning void from iommu_report_device_fault causes these events to
>    be missed while logging.
> 
> Modify the iommu_report_device_fault function to return -EINVAL for
> cases where no fault capable domain is attached or iopf_param was NULL
> and calls back to the driver (ops->page_response) in case the fault type
> was IOMMU_FAULT_PAGE_REQ. The returned value can be used by the drivers
> to log the fault/event as needed.
> 
> Reported-by: Kunkun Jiang <jiangkunkun@huawei.com>
> Closes: https://lore.kernel.org/all/6147caf0-b9a0-30ca-795e-a1aa502a5c51@huawei.com/
> Fixes: 3dfa64aecbaf ("iommu: Make iommu_report_device_fault() return void")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   2 +-
>  drivers/iommu/io-pgfault.c                  | 116 +++++++++++++-------
>  include/linux/iommu.h                       |   5 +-
>  3 files changed, 83 insertions(+), 40 deletions(-)

You can keep tags for minor changes like this:

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
