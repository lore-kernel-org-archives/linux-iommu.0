Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3755620ED
	for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 12:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855120; cv=fail; b=PGefw0eAZPORaGJI37VkJYFnMhhPp+s9b02EfcF79vfHgcaGD+H4KsDhEBgi94yHmUD7Evn+0rsVbxM5rzYQs5DFmN6bm6FqJV+7idDJs//SEgs5Pq0/jGAj1sMl3sd5plhzac11BsEL4qDzuP/xiEbU7XHZzLcd6cYeRIDLnaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855120; c=relaxed/simple;
	bh=4a0JKPEbEsnJJmr1Nc3K5n1N4pk8jfhGOO8FdTMwNrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bJZCF2MzvPvY5gLMCwMQz4eoEfT5R1jKhqDkSgbMG0FDR/QO8Ita77SespEOyeUOaVmf2YKKSP9p2FvchpOmw1I5Qe5dmBe6zKwPO2XV/zBnfRvWw2jfUh3MPlHb+YA0gv5TXhPQJVFLzn55zV6Iak6XE7riDMr9r0Ym6qpaHKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HrLUQltp; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HrLUQltp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v4GM8sRHmOtvhdA2HH6UalCUbHztU6yYpsZ/vAa2WhZ6fSf1wAMggKAVUhNb4BNI4AhX7vVWCLYFs5FZ5erYmZO5pfuqpcoRpKJOp447WIST6wLoyp4ohoXRx06IWfok6+KjOteb5o3mK2bVNSPsKfsyaKTASWG+6C02uSlCKuR5JiZCk1w35bAtND5R/F/tfrBWdriv3nYvnnWdwiOCHI00SBq4o04toAa7aGg4T3Qx+eMSOw4mPJiqbejQS738i0F55HDzr/f66DHb7oscI8Ky0oDlQKA/yXbF+AuVRYBOqwg+7ZysRePP2rWVak6UwmDc70eiI2/olokydTt6MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=maRNFH6eT33xdVok5UXyKWljw2OQsXqSCHtqd2Hhk4M=;
 b=lpkyg4fSW7zQCve3/kF6uMJZuUmKWtuEwuCbJ+TcopfTNM3aMASpBV01Vz3jiE0JfFk5eG93Gv9JBV6PK1O3xWsU0Xjk2T+2V6Ep6q0FywsVliEKw1C7VaURExIGocuX7/DOEvYrN8NEons5c6gFtwPFXRtMtcQt1QWwiDzECS47LrmHep4qwFeNm1MEsEStWVSxXZz1y0ZUMY5/AhXSSL+ypfSaeib/lDeqCcCV7xLmXXjeFeTou5o51dczmBkuSQnw5slm/4eaxlUQBiikwPOHK74QoGqya3v6L60vYxYQqvoTjt5N9ZnQuaxwKdLk5Ghbpie4bwueEFrutU4UPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maRNFH6eT33xdVok5UXyKWljw2OQsXqSCHtqd2Hhk4M=;
 b=HrLUQltpYlG417D/j09GYxtSiPa0bvVN7JTI2VB5i+pjgQePX4SjE096rDnHEnG3Mrs865UrsVCar3g8BKPbmGRkx2Vm6EF8lZA3B/f+PQgTQOHJO5MKRIsjEuA//LN/tEcuXaPg7ITDVNQ54JrRDNDZPSqzXL/aXxdcwLASlEBRFAn1M+hmWgsbdXfil60KR9DHXwaWUN8oQ/Rd48ewVURROcd7tokbC5w1rSrluD4S//v8hpJCAslsH9Q8s9IreA/Q+2mFKA13FAfjr7vniBzQWx1qsSjJS4RA2l4kDkr2On3n5PPLdxoeeYxmMUX1oqZqaoSRGbYtzk2m9HZx5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY5PR12MB6131.namprd12.prod.outlook.com (2603:10b6:930:25::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Wed, 25 Jun
 2025 12:38:34 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.027; Wed, 25 Jun 2025
 12:38:34 +0000
Date: Wed, 25 Jun 2025 09:38:32 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: kevin.tian@intel.com, will@kernel.org, aneesh.kumar@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	joro@8bytes.org, robin.murphy@arm.com, shuah@kernel.org,
	nicolinc@nvidia.com, aik@amd.com, dan.j.williams@intel.com,
	baolu.lu@linux.intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v2 3/4] iommufd: Destroy vdevice on idevice destroy
Message-ID: <20250625123832.GF167785@nvidia.com>
References: <20250623094946.1714996-1-yilun.xu@linux.intel.com>
 <20250623094946.1714996-4-yilun.xu@linux.intel.com>
 <20250624145346.GC150753@nvidia.com>
 <aFvKCEt6FadGtYr+@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFvKCEt6FadGtYr+@yilunxu-OptiPlex-7050>
X-ClientProxiedBy: MN0PR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:208:530::11) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY5PR12MB6131:EE_
X-MS-Office365-Filtering-Correlation-Id: a56df63e-5967-4d57-4622-08ddb3e532d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EbmskxVKel9OBTQDJXKO9PNWd9scHracgB3vgl4pgGGtoL26/gBMnaEsX2kJ?=
 =?us-ascii?Q?28fInHC3LD6fOJduEAZnEuzxk+9LDu7wK6sF6UyzVpluNIIXGDEm6LFgJZOg?=
 =?us-ascii?Q?6M/vNwi1TeLbd1C4yEkPfBZ9jla3IL8dNQbba1VG2z0ugwUEvcwx6Jo5aSmy?=
 =?us-ascii?Q?fXJN32l7oUILFTbu43OLsF1VeOUkaFJedQnIBxY70Ogee825OO61K4uHtkki?=
 =?us-ascii?Q?Rfec8kR5AREd81rvadNaTzfQZ9cJHhM4qGkVSgO4sQTOy+bn0Yw2njBcbmlF?=
 =?us-ascii?Q?/S9FERxPzr89ceNWv3OURx8rCx2NnAoqZP5ozEweoLum6IcymDVsCGdUWiHD?=
 =?us-ascii?Q?2a1MWw78k6rOMWACvNOrMCF4Kh/KdWySHC7ehV/UzHVFGDoIbeuIa5jq5E0h?=
 =?us-ascii?Q?jH3ShlCijzmY2kLVnDIMnPNBnUpkhx9VJDrH10KNpNMQdIQIhdKoNloXfb8i?=
 =?us-ascii?Q?0qJ01EQHoFFX88FqsSCuVGxXyjJehAYOMQDrih4khq0vlfa+rh9Jak/9zGox?=
 =?us-ascii?Q?6/TTmJ9nD8WqfOSMliEjJALVGMRctv4NJy1eG2p0ZEt4ET/3JUvOjgHrGlFN?=
 =?us-ascii?Q?GT1xt7rol5OgFIdadR/8FURRtBmxdL2h5E8uV1edjVwppLftdx1RAo9OEGIW?=
 =?us-ascii?Q?ZrWARu6FsqFhVk3GFo4xl8foaM2/xqfmrQiUS2b7e5utcz94PDvN/O9+JFwO?=
 =?us-ascii?Q?FxFUp1kXKWYsd8a4hFGBXOTb0A9wg2bMEYqVn+FL31xt94cKBY/dze29GyHe?=
 =?us-ascii?Q?Ruas1A4AukYJKCi5Y25hfSRQLrjsG+vWrqMEs+GyS6xXs3WNqNLGYdKa4Qsl?=
 =?us-ascii?Q?uaO0THvlJqutVBTFdouSit6mQQxXvnCIaaLXKlIZt3ZXvtGmeFLBPX5TDGXf?=
 =?us-ascii?Q?Djq9CkMRkBiWt0L/yYpgGPNbo4X0AQgs5F2nIR2gYjgVfcSQTy6GN/879uoy?=
 =?us-ascii?Q?QfP42e9LZ4zBavLw8HbqsgJg3kaL9m61WRHccrxilP8h8sb7+wApvsqrdPhL?=
 =?us-ascii?Q?3J1yQ1yHz7uAszR0lDzE0DdEk23mIYR9H87YzrMvqtePgkO8AJqrofA1DnwC?=
 =?us-ascii?Q?1ljr53ZEu6WVpnHvhhYyQRzcmEdi35TM1Rf0bRwx0nyLTzxShZkg18BlxPfE?=
 =?us-ascii?Q?Bi+s92sCRBSy9LWmU4fGgRy5mZF5FXXL2OJA6HG1DXKE0gicV/vIXrErAXW+?=
 =?us-ascii?Q?ur+a5dJFdxpkmrgy8NowIy/gRW/99VXVX2tVH5Y7o83xdcYnoJxol7iyXPdz?=
 =?us-ascii?Q?GyjJaxl8se+PXdaDW2D2TVbYZyisg0zaA+Knr9gd3sEFmwXoYqkXR6dqSO3p?=
 =?us-ascii?Q?l9it1CJG5MhznebI9Fi9yTgFNDAVmt/Mor1OwgqKAnfUNCKKfT8/V1umqze0?=
 =?us-ascii?Q?yOegId+F9oesaMXlBje31DKa8L8hfq25Hpyeg1pvy9kKUFe420vJaxpts0/k?=
 =?us-ascii?Q?mQdFpbfXkYY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5SOi82V7Vbz0+N6YhjMakH/jm5BwvQdQvgBhNHhpk6ISwCXhoCvvhE2zPKTF?=
 =?us-ascii?Q?MqHZx5LCh2E6Yl2DcN1OB5Q6S5XAB4PU3B1JNQeiaRLK7F2hx+QtYZGjCun6?=
 =?us-ascii?Q?S1YP9aXLig54ZW0eajTi6DgPTq7ibf7r2l0BgYK1AC7d0KJCKnvB0pmRk53g?=
 =?us-ascii?Q?9wJVcKTzHy9NBQojttyjllyoVxWCz2srVvfh/zrLPIktJN9gY3n61Nh3hQXb?=
 =?us-ascii?Q?esIe/ZM/UJRu0fR+QHLPbG7W7l9C1txYzwTXYFC4bg8nXRHUVQ2sjE7IlCbd?=
 =?us-ascii?Q?MTjbiFfo+NMlKUcO09Rq6pL/Gv/v8bEqWa86pnEyOArlrj3W5tyss95OdZPM?=
 =?us-ascii?Q?WVrmMRbxn1vEsHGi03qzVGKaN8LtJJFQf3x84MPx0BpAntrktml+LGLpfDVo?=
 =?us-ascii?Q?2hUB8a/urofEwoCI9Wyxir1Bdo6EfPtIgfHThxxGOUQCOXPI3WPA4T1CQU1m?=
 =?us-ascii?Q?GuG9bMVpW7YMlikpijqQ0McU5Dx2KVX/+oZjYgCHMbKnpV3pG5LeZTE7XiLf?=
 =?us-ascii?Q?eRFM0winhaGMFjqQHLklqRXOtZ2cNzXIYKIKeIw3FD0euiyTpE4gInCWUS6U?=
 =?us-ascii?Q?f2TEo9Xka36SzcS3r521cmj3CwYetoyc+xfLNgKXob0zmbCeAOhFIhOiQl0u?=
 =?us-ascii?Q?lxTZL7F37CeTz7azuWOnhiKbSpbFnNs8p+gSrt+S6Uu1c5tGWFR8cydSfnEx?=
 =?us-ascii?Q?Z4Lv3XSKC8Cg2BsxLNUsVtZhe4UgVZxiAzqaFqImXVNDJwf4oVpiX8hSaRNx?=
 =?us-ascii?Q?juY80rT1nRCAtpujq3sSEarJbhsHZWZPwt90X6KfVy62BQu7mzYcvWfJlX4Y?=
 =?us-ascii?Q?0bQ6i/85vaEuCun9ud6RqQhyotseuHeTg3mCtp8y0WxmWGaoowQFk4Tt5igW?=
 =?us-ascii?Q?ZmQGefXTy9RMeoYowejlyNIBk7FzSpMEpoD5L37N36rymH8JurJdSvrn4XY/?=
 =?us-ascii?Q?ACbMA8YI1rDYvQrBJ/5f+hvfYEElPKmJqhEs+XfSsFktDxZuPpBudDvpqrkv?=
 =?us-ascii?Q?SBRhHjUrav7wP1sZOUeK3VN+PftdP3tdq9L3ygI4GUnXhX1JNYLQIPIqqK5t?=
 =?us-ascii?Q?CKN5HhEDvc1YPp4XNKecwV04PWljs8aPqMYOyVBFA4bdhY8G1bYdAI48EZ9D?=
 =?us-ascii?Q?aaQTqeKAZJu+TihDHEBtop76X//ndoqFb3fZIjnPUbbnw2wUKp/zgVzwlerK?=
 =?us-ascii?Q?7MlOV8R/lqbzKG04MdtrUyBjiZnDNWVCWy2kslPASbm1fSf5xOKHYKqAFr7u?=
 =?us-ascii?Q?YwVvDrMVZXxz43nmWP5nE1hUCSGDz6XU4iJpIV8dwjXvX9/3xcnPnzIQWTPV?=
 =?us-ascii?Q?tOoL4+tQghccp96nJ2DA5jOQGVe9Hjk4oh4tXctVesRkC6ikRNU1a34yLm2g?=
 =?us-ascii?Q?uR+wB8EEA4VRoNUC3WA+V443a/weJDLHF9ORJtVfbfpIBxzRdACj2X/YB7Xk?=
 =?us-ascii?Q?l/JCPqitp5vkI1aTmHD+WjVStiad4hZP3whbkk2Bvv2ngq3biQRkSbkiD1Gj?=
 =?us-ascii?Q?1WQuGfICOwoBcjEGsMYxsfBpG7jBYqBriBxtHpxxTbeZtrHQ4ywysvjaDsch?=
 =?us-ascii?Q?MAkkEwQr2HzGr/GcFM0oS2VSWgigJYvKxQ3BSpXU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a56df63e-5967-4d57-4622-08ddb3e532d1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 12:38:34.1129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UAE7Lw546P04S/aBFKkctGmAnzgDTzWZqxi5VTJNQFlGfykbHJ6u45vzFhyY80sh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6131

On Wed, Jun 25, 2025 at 06:06:00PM +0800, Xu Yilun wrote:
> > 	/*
> > 	 * We don't know what thread is actually going to destroy the vdev, but
> > 	 * once the vdev is destroyed the pointer is NULL'd. At this
> > 	 * point idev->users is 0 so no other thread can set a new vdev.
> > 	 */
> > 	if (!wait_event_timeout(idev->ictx->destroy_wait,
> > 				!READ_ONCE(idev->vdev),
> > 				msecs_to_jiffies(60000)))
> > 		pr_crit("Time out waiting for iommufd vdevice removed\n");
> > }
> > 
> > Though there is a cleaner option here, you could do:
> > 
> > 	mutex_lock(&idev->igroup->lock);
> > 	if (idev->vdev)
> > 		iommufd_vdevice_abort(&idev->vdev->obj);
> > 	mutex_unlock(&idev->igroup->lock);
> > 
> > And make it safe to call abort twice, eg by setting dev to NULL and
> > checking for that. First thread to get to the igroup lock, either via
> > iommufd_vdevice_destroy() or via the above will do the actual abort
> > synchronously without any wait_event_timeout. That seems better??
> 
> I'm good to both options, but slightly tend not to make vdevice so
> special from other objects, so still prefer the wait_event option.

The wait_event is a ugly hack though, even in its existing code. The
above version is better because it doesn't have any failure mode and
doesn't introduce any unlocked use of the idev->vdev which is easier
to reason about, no READ_ONCE/WRITE_ONCE/etc

It sounds like you should largely leave the existing other parts the
same as this v2, though can you try reorganize it to look a little
more like the version I shared?

Jason
