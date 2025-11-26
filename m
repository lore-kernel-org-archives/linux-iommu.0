Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013064.outbound.protection.outlook.com [40.107.201.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302CB31BCB6
	for <iommu@lists.linux.dev>; Wed, 26 Nov 2025 05:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764133695; cv=fail; b=gwu8AAeqSfI5MmCxquPxKC5gr/dZQN7/7S4dzHsu+vIGhJKPwe5oD4IJcBWtEtsU9q+8zfL/4/fE6kmQ2aKaGkUyOqOtUbz8nLr6Ytisbi5X4bMr3kHF7k3pfcSbxRaj7/YB0EQSRX1yVPNYt6CP8gkHOGCPlG6GPHcsYH7EMW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764133695; c=relaxed/simple;
	bh=kmYiZ0q6K6ppy+i803rgZsLbBkFw8lpncf6CxCAedLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DVQ5ji0N3UCVfJkjuoXnKtEji5VMC2DwYCY7h7XG4FFGAVJkY2yAT8ZeIcTxPwBySf846bx4XUOccvaQLZG9wtouMbheN+3WkTvS+RU0uV4/JWXqRt2BG/Oksegzo3CY2ij3n+0x87W5dSWefiO0hnXKWZHKJCBgNBkX6IU4FJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uIGfvMG/; arc=fail smtp.client-ip=40.107.201.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uIGfvMG/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DHIsDHr4RA1AN3+7pRe9zxjZmpyOFHNqwWzwhVnh0ugZODYy5lcmKSigCTevkRr74godDKeBQKx4h4BfeExOUm5YuyY4VIWpHkUlaVuWmgljo+XaGLXAwNL1LaFicLl3l8Mz/w4iw0+H8PApKLCVe19OdN5y8OBr3bvqhxmwtNSXxy65YilwtPZvtOaPn7OvOQod+cFz/i6mLWuy0Le4psFNYw+pE+vGfVcKv5a6rtZ6agMN2AWPDQ0qNwx69a8MkXavtn55MZDgREI/eTRxj+C36t3aDwm6anPsA+mEclcbc5VeBfvGEUkOaPTFVi41c8QnnMWwODisqWBHuUQHXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJ6yjlUdjLC4pwH7E/mdanx5QFfLaMZsR3ixXaxhhK8=;
 b=TIwpi6dPjwws4VqoAzLYbPEw559x2Rh3f3FUAZFzm5to+XFHH7ApVm51f7vFBJfme/Bk/sCBQhVWne1nTU5sZ9M+ETcyNmt/NS+5tTDQN8vcFaO5Bxo41hUQCftuZc4RglCkIIzBSVOfSjcs00kOp6FvLXeoeWfUjj6sZOLL5thSfT8fjjl6IXLVTKed0uZpVS1mzf1FnxXdFhx9dBZ2of1IRi7uP62hZGTa8xfUgH9te3D9hAc77/ceX7+TkQvvVj/eMLOOon6a23ovX+7Pk2ZXBCVS+0++jWKpIOAqco1k/QkeG6hGyqCADlw5dYK8Z1qz0/Hu7dZs6PAWsK8zlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJ6yjlUdjLC4pwH7E/mdanx5QFfLaMZsR3ixXaxhhK8=;
 b=uIGfvMG/gBQIYlmxyXGYfIBTGTRSBr07FC7GfUvbmz5EDl/4Z8YuSDoGcKo1xa6/E6eOZEbqipzPVey0T6k1pcV58ODMqXcfDQAeeFy3YVRQ8xG0vutzIBz0n9W3fRp0SB9K+RMePlsIT+YE46JRIx1tvVrGWArB8k7BC3OH4jE=
Received: from BN9PR03CA0674.namprd03.prod.outlook.com (2603:10b6:408:10e::19)
 by BN7PPFD91879A44.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 05:08:01 +0000
Received: from BN2PEPF000055E0.namprd21.prod.outlook.com
 (2603:10b6:408:10e:cafe::2d) by BN9PR03CA0674.outlook.office365.com
 (2603:10b6:408:10e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Wed,
 26 Nov 2025 05:07:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055E0.mail.protection.outlook.com (10.167.245.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.0 via Frontend Transport; Wed, 26 Nov 2025 05:08:00 +0000
Received: from [10.85.40.187] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 25 Nov
 2025 23:07:58 -0600
Message-ID: <f4bff460-f4c6-4a4d-8ea6-b3c0c8965f0a@amd.com>
Date: Wed, 26 Nov 2025 10:37:56 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] iommu/amd: Add control register in `struct
 iommu_hw_info_amd`
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <kevin.tian@intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <vasant.hegde@amd.com>
References: <20251029095846.4486-1-sarunkod@amd.com>
 <20251121233545.GJ233636@ziepe.ca>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20251121233545.GJ233636@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E0:EE_|BN7PPFD91879A44:EE_
X-MS-Office365-Filtering-Correlation-Id: 8738c969-f149-4680-2345-08de2ca9c594
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d0tXbVdsUXBOcnIrSlVyWm1PdnhxRHBkejRvS3J4b2RwWEpZblZLOE14aGNz?=
 =?utf-8?B?UW1TL0NSUW93RnhPdUE1UWk2QktYdyt5SVNnS3R3V0lwNWVEemJ6OVg1NUYw?=
 =?utf-8?B?UGY3VFA2NmpOa2hVSVBNYUVQRjBiUEErWG9BR0dqQ3E3d3R2cURpTE1kYUsr?=
 =?utf-8?B?WlVNdUFBaFlkOE9sM1d1SVhnZG1VZS9YUzNTMGpoZlFBQnEySjZpVEozeGQx?=
 =?utf-8?B?RDRTVkVjanlDbUovaDkrRktSaUNaVytLMVF3UjhSTXZFR3lxelZqQzI5VXMy?=
 =?utf-8?B?VkxEMitlREIrWVRXNytaZUljMCtLaXlaOS9ralVGbXVPSUdxU3NrNThCYTht?=
 =?utf-8?B?ZkRsMTZWWVJDZWljV1hkdWdNMWM5MHFQVFdjS0FGVGJuQ3hqb2RFSDlGWlZI?=
 =?utf-8?B?YVNIQ0NFUzRVSUt4THNrOERzbVRocDlDSXZkMkNRMXJ3WHNrcmZ1Y01LSmw4?=
 =?utf-8?B?MkpFdUZNYTBGWkJEakRqUlNqUjNUb1ZYTENvbS9oelJFbC9ZWllLM2JLdDhK?=
 =?utf-8?B?ZUFwbzJ2Q0s5TUVVcE9LNjVvUDlMckE1RzR4Z1Roblp1TlZLQjhTVVRBKzNt?=
 =?utf-8?B?NVJ2cDhtRXhyZjg0eXhpRlNHNWxHVSs4bTliSkNhWFpTU1RYQU0yWDJWa2Zs?=
 =?utf-8?B?by82ck0yWDVOSTEvbkVNQjR0SVk1eDh2dFJZSnJvUjhQd2dxMThuNXA5czdy?=
 =?utf-8?B?WUNpQy9nTXBQWnRDd296bkJHVXBGcU9HeFJrZWFQT1FTMFEvME10bHp0QlNx?=
 =?utf-8?B?ek8reTQ5eE1meVlaUFdvd0R2YVNSWmt2SmV1SDZyL2ZxZVU1T3diMXJjaXh4?=
 =?utf-8?B?TFZPNlpEUTZwVHg1Sm1XbHh0aDZkNVpHY09CV0ZSdUlCWkErb29zTTVaK3h1?=
 =?utf-8?B?cnRJNWlUOVZ4ekJRbEVoY2g1ZXoxQ1RhVjh5c1BhTlloOGQ1d25qdTY3WC9F?=
 =?utf-8?B?d09IdDV6U255WC8rUXZraHRkZjZUWjV6Rm9ZdlBBcmh1eW9mVDY3bFFGWEsr?=
 =?utf-8?B?WDNTN2RuU3RwWTBJTWpxZXZ4S0xsVktLRnIyUEMvUWVsbW9DbzB4eG9PT05D?=
 =?utf-8?B?UlgwUjN5cUZrbjlDS1QwZ1MvM2k4Wmwzc2xtc3ZydFVicVpBdTZGK0ZJQS9q?=
 =?utf-8?B?RWRMajZyMWZpazQrR3pPZk9mWTBxRWprVmpzZUxPVFRhUHkyc3FHOVJDSHZF?=
 =?utf-8?B?SlpsSVJWSEwrbDJ6T0xlRjcrc3pRRFJsSHRuQjNOd1F2TjROLzFoUm5vMVl3?=
 =?utf-8?B?a3hWTmxITU9LSldoU2Rhc29ibnkvNFV2U1cxSnQvMUViQ3J6R2U3Z2RrT1Nj?=
 =?utf-8?B?Z0ExUy9vc05GWDdiQVQ2allHZlFMNEVpaFpmWWtnVXpyQjdBMWxRcG5tK3dp?=
 =?utf-8?B?bUtOQVB0V3ZsZ3NuOGwzd1BxakFlbTVzaG1sM1RLZnhOdHJmZ2tnbFFhM0cx?=
 =?utf-8?B?M282WEtia1BkOFB4UkwvQkdNOWZWZHU4bnhVQjFrd1YycUdJM0pFQkhhMllN?=
 =?utf-8?B?WnBiYS83bmlVY3RQd0NORlFSTmo5VmlVL251R1hITUx0MmZkUHpBZC9pYkZr?=
 =?utf-8?B?Qnd3bDdHcTNTR1dkQ2lnMEZ2ekRyVldiK1RPMVA0ZjZOQ01sb0pyaXcybCt2?=
 =?utf-8?B?blFQVXJ2YWhEaUVlT3VUa3V4eHhGL3VRQklKTzBjUmkyRUFLdGxRc3l4MUdU?=
 =?utf-8?B?UlVCc0M2REM2SXhvd0M4ejFKQUgrZVR6Z2o3d1BzdGUwenpDN2lpWGdlU1VD?=
 =?utf-8?B?M3dWcnc2SzMwK1RzcncvZ3hxTmpYSzQ5bFNSaEI0clMwTUlMSU9YVjlYbDJt?=
 =?utf-8?B?Q2NObngrSVA5SzdXRnFURnoraEd1TW5iNkdUb2tuRiszT3VJMjVLRHAzWWhT?=
 =?utf-8?B?QzdyMTc3QzMrQndYSEc1L1hYckI3V3RQdmVQVUViSldJdS9yUFBST1RpY3BR?=
 =?utf-8?B?cXpqWVdJd3hEVEpNREJGVGhNRnZZa1Vidmk5dGQ3WDRhREwxWmRZb3VLK1cx?=
 =?utf-8?B?aVc4WXBZd1NnZmE2QlpJMHA2aEtPZk1obVBWZkd5MTI5Q3I4ZFVBSTl5cHIv?=
 =?utf-8?B?UmRIMWRGNTlGNmhKendudUJ4UGFmYklWM25sZVJydE90YmxIVm1yeFpFNXNG?=
 =?utf-8?Q?JCUc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 05:08:00.8679
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8738c969-f149-4680-2345-08de2ca9c594
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055E0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFD91879A44



On 11/22/2025 5:05 AM, Jason Gunthorpe wrote:
> On Wed, Oct 29, 2025 at 03:28:46PM +0530, Sairaj Kodilkar wrote:
>> When user does IOMMU_GET_HW_INFO ioctl, read the IOMMU control
>> register (MMIO offset 0x0018) and return it as part of
>> `struct iommu_hw_info_amd`.
>>
>> Userspace can use this information to determine the features
>> supported by the underlying host kernel.
>>
>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>> ---
>>
>> The patch exposes the control register to the user space so that QEMU
>> can determine the list of features enabled by the host IOMMU driver
>> when there are passthrough devices. QEMU can use this information to
>> selectively enable the guest feature. One example of such feature is
>> enabling upto 2048 MSIs for passthrough devices. QEMU must not enable
>> this feature for passthrough devices when host IOMMU driver has not
>> enabled it.
> Please document in the uapi header what bits are meaningful and
> userspace can safely access..
>
> You are OK that a 0 register means the kernel is old?

Yes. That's fine.
Please see 
https://lore.kernel.org/qemu-devel/20251118101532.4315-1-sarunkod@amd.com/
Here qemu uses the control register only to determine the 2K interrupt 
support and sets
corrosponding bits inside the virtual control register. Other bits in 
the virtual control
register are predefined and do not change even if the hardware control 
register is
returned as 0.

Thanks
Sairaj
