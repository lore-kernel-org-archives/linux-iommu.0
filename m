Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8623C47D
	for <iommu@lists.linux.dev>; Mon, 11 Mar 2024 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710163221; cv=fail; b=QXkifZiamIIRuUIMuBIT8UmbAeAMA8kLK3MKVEMXZ/UBCwBGayzWojW8+yUd6VOPlrz5G3D7gYRIz+yRE9GvrtyMYwzqfAMih6goqgV5reuBdC1WeFdEeRF118TJdSwlOiQewXlttAnjaPLZ8yDv96GXoGkbNhpmAZRi+1/vQOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710163221; c=relaxed/simple;
	bh=6SlUx9Cxc9RnUe+iAasSPweCrFE/RHwFIoZEHDHaYRw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DPNvKKLoCmz4B1u0H+nXlBTYH8Bf2h7tHcwTnnIgiEXNIDhPVkEgasbMhB/geTzx/zkSdINVSv/HZLkljeEt3fjNyUfw49XIq0y5BC6RZFfeb1aE2u2I/x0GYq6zvYT5IqIcRj4DrSOlqjMohjWEa3KIwGtAei/IYh/BRTt2c1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1SpnEoi3; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1SpnEoi3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2UQqplx7VrcrkkCb3cl8UjqYHlomEfGId5KRSqYyTjARk5/IQ/SaIMSOkSbCquYziE94r1E/HWlFT3Pu4GzGqbUJEMdOsu8BSEcZnY68H7kjIvDCNovjNTjEj/+RaoKeeaTngBrcANYXZVUGpjUoswB1IJ6pBbRiZq1anqtqI0LkC8d/Ca3zCc620S+mNLV/KQ8pGLcQUjjy9gbZX4jth1DCaOgvPRmMgI8MATtwd0Xa7zDzRbGAd3iYj6+OgW2OIwWWcOp4r8bS3Oh5vkJaC2EeeKDsRVwn/R/jm0mJ65FwZnase7SeBTMS+88xWS2Sz5Gwy0T7XG9+blkzMC2og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/tkh8owLin6FNHraE5WlgfedcBZVwqYvHasNcXd+vc=;
 b=N3TN0nJWVgPibUBmV0ePff5Th6uUwV50Qp/yhjkdYCVA9FKI8aArpAnmuz6mipD0LmlqHEspq4FbbwNQi/g/hprhVO7nIsOt9zJrtESzG+gxa5Wk97AGb0VLsLvf0aJeedxVidOb/6b2tELYAKnpAWJHi7ewjb8fBGXGzjF0FEbDlNhCce+Als4r4z7Beg4GJ3/6mSBEMxxP7oxin0xSsHLUGDT4FGAgg4KtfCywMbfciJz+nS8LJNqdQOydlXZ6yNIl+UJwwCDAlthu+vCfjix4TBvLSY5MO+IYB1r7mh8hf3ZCQejQSun4tjwsyG295IZjscIDcfZCtDmqdAUIwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/tkh8owLin6FNHraE5WlgfedcBZVwqYvHasNcXd+vc=;
 b=1SpnEoi3TXUGvwFWJiOFgsgGRg0S9FmewTsHrS5ue2rQ3rQ3bWixGzOJ6f/YZCisfHjQ3gJhp+GnxryoAIrWNvbBq+s/Qds1Ob8IEAnkKaOif20f20Ed48HIBDUwpLU3SFByRS9J3VZaqmg5k9tWJWRT2BDQ2pNXO6VjesfoOq8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SN7PR12MB7882.namprd12.prod.outlook.com (2603:10b6:806:348::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 13:20:16 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::d709:cb7d:2612:bb27]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::d709:cb7d:2612:bb27%5]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 13:20:16 +0000
Message-ID: <5d469b74-6a47-b478-3360-922e619f567e@amd.com>
Date: Mon, 11 Mar 2024 18:50:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: iommu ivhd0: AMD-Vi: Event logged [INVALID_DEVICE_REQUEST
 device=0000:00:00.0 pasid=0x00000 address=0xfffffffdf8000000 flags=0x0a00]
Content-Language: en-US
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, iommu@lists.linux.dev,
 it+linux-iommu@molgen.mpg.de
References: <f35330f7-ab03-4b27-b112-7a49eca3cd1e@molgen.mpg.de>
 <1c56ecac-496e-2b0a-a3b4-d9223a9924f0@amd.com>
 <dc1a5650-b23f-4aaa-97bf-14b33f367bda@molgen.mpg.de>
 <f6883c6b-86b1-9dfe-8ecf-4ae12c9352d0@amd.com>
 <2b424597-0a42-4e89-aacf-6c56b190c520@molgen.mpg.de>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <2b424597-0a42-4e89-aacf-6c56b190c520@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::15) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SN7PR12MB7882:EE_
X-MS-Office365-Filtering-Correlation-Id: 98eff82b-927a-443a-8097-08dc41cdfdbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zwJcKkJwJti084nZOwu2AM6sC7My7xYfrBV6IRYrVdivYv46wV6u3dZHoSwk9IPuhNaWpA1HOajpRVWNhypwa08IV7p8eCWRc0mHMhkAY+O4u2fGh43i6Pvxc1g7ZI2IfudTzwldL/+enK9a403EB3OIZ9vYW9L/8vYv9C6orZVjgaO2a4RXSEg+L/li4YPfL0JW2PMGEP6zJ6rA+CEceymc5KFNAgFkffh6RLsOctDNA3+5ExEgU8xp7KCdlDTOlfkeHPlcZedt8Sm9Wm48v8noYEj3iB1RhEmsrUNo/kDjx0v/j02P2DOy6YbX9tvJT+GcbxHYAP0rXfoZV9GPDRi/7De6P+hF+Rni0sUiIrNVjhYl7uvoc5wFC3Aj8AFYmeUZYsTfj0I8etcfOQKAJVA/TxY3FFPX6ZSIqh/oK9LQnff31EGofIcasELameXnzCJwOPw1/aVXRIB9GHyxk8gdADao67E+3zqQVr8eGUKVxiQagJf81XK1I/KxLcY/9i0/BZWqhT2hzuo8N22Y0l4d5eo2cC+AbV1THrbeWk60oxio3u144ryCSaGvwdMFcVxi2AcJr3kMlVov3vGbBvZ7VPpXsnt78nZNuuF7e069XozNXE44pu7kMRYiks/jZjQUMoW3L+dlZE/naJir2o7XfSoZMi0dzcsFTYDFx9M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dU40dTBFa01DOFpRWEE5L3AzWis1d2IzaG1LMHkwcmdUUUxXK3JXcDg3bkh3?=
 =?utf-8?B?am9FUHhzZ2VVTFBSVzU2OVlkRnFEUWpRdldpc3hmaTJSTE9mSVJTenZPNCti?=
 =?utf-8?B?QnBZYno4L2JxTnp3UnhKTHgwZzk2cmpQV3BLVUhFR2FuSUNMemI3b3FEOExk?=
 =?utf-8?B?WU4zT1JDN21jM25sM2JTN2d4VmZPSXBKeFhsa3RRVnRTMGdzbmRBM3lPeXY4?=
 =?utf-8?B?TXQ0R283MmxZNjdkSExSbG1jOUZxUHhLZ214SldLa1NlbGZhSDlEMlczTTZ4?=
 =?utf-8?B?cVhMSk00b3pyb2V2N05Ecml5U2NnSTd5YUZiUjI5SVpNVkR4NW84QW0wNDRR?=
 =?utf-8?B?ZS9hbld2bUlsU0dPVkljdFBQeSsxL1g2SXYzMllKeHVHaG8walhSUjRuNHov?=
 =?utf-8?B?WSttVkNZMGgvREI2SnVLUUtBMFhOT1g2R1F0blh3ZnpoREF4ZTJ1eThzdzBz?=
 =?utf-8?B?cnhvMVg5QjVzVXh6dDFzQXJ5d0MwNStyWXFVVnpXWEh4WWdkRU1zb3JOUUVz?=
 =?utf-8?B?R0dKbVdYNUNBaGwxcG5GdzhCcGNqRmZxMGUyeENOeG4yaUd0cmZxZXlUUWdT?=
 =?utf-8?B?K3Y2MlV4YXVFQTZPQm5JS1NpVXRjOWVQOEg0aWtwMEZvME9JTkRJSG9MVUNo?=
 =?utf-8?B?emI5eklUYnBsZCtyOFBDdWl2UWwwcUxTdVlvS1g1aVA3U3ZBeUROQUlpQ0tI?=
 =?utf-8?B?Ym1wcS9vampnWlJ5b1E0L21XbHFHZlNOVHdFSHJmWGMyUVF6WGlKc0lvZDN3?=
 =?utf-8?B?a015Yzc3TWU0clkvc3JxM0ZONFk5NlVKMjdxa1hKZFZpVHNkUUpYVEJ1anB4?=
 =?utf-8?B?QWZSaHMwS3plOFgvcm1KWXlyTnlUQjdkNS9BRFR3RFExVldWbGljQmlnMy96?=
 =?utf-8?B?VzhhL0Y2RkhiWFIvbWFiVG1DU09YU2wwM2dXeVNBcWM5UXYyVEJXbVV1V3Z0?=
 =?utf-8?B?VnY0QmhhZG04RHdla1dMMHI2RTBITWRVZEFNNEIvR3NnRUVWa0orK3NpTzVo?=
 =?utf-8?B?VllMVzl3UXNXamQyVm9yaEJlYkE0bmUyeUJ6TUJaUDBweHM0SVd1K2d6THc1?=
 =?utf-8?B?dEhzUXUwQ2Y0UVcrbTRmampOeVk3R1BxUWttN3d4SGx1NmYvRE5KSU80Vk8w?=
 =?utf-8?B?ZWc5Um50WE1NRWloa0d0aENmaHlPTHNsSEwzNHJURzMxeGwrQkVlWVNsSWJQ?=
 =?utf-8?B?UjExMEtCeXo5ejF6dU9vVzZsS05iVmtXU0xSYndhanB1bGpWTG4vT3Y4bGRW?=
 =?utf-8?B?OXEvbjlPbjRYaDZKZ1g0Sk0ycEtrSVBvTkV1Y1E3REV2NEk2ci9GUmd6dFVH?=
 =?utf-8?B?N3I5YnBrR1VwRGZCYnRXbWdqVlZHa2Y3ejRTTmlmWm55WmE2YjAxc2crclZK?=
 =?utf-8?B?SFJCMThsNTh5aWxuRVh3QlZZLzYzUGJkNmt5VDV0NER6YVdsa0VRaGxxQnlQ?=
 =?utf-8?B?K3JSVWE3SHlIcUp2dU5tUGM0aHB2cUhXV1RISE1UUldSSHRwWFlHUm5ONklF?=
 =?utf-8?B?Nlh2TURLM1FJM1pIcHFqNk5sd2VqYVZXR1pPY1FLcEVQTCs0YkVsc2ZmcnBV?=
 =?utf-8?B?aTN5dWJzdXUzbGtrenNLOFJwaVBhUkV5dWpCMXpLREYrcnp4MVNIOUl5U0hn?=
 =?utf-8?B?TVNTbHZidlZrU3B3WFhPaFA2YTlqeWVEVThrZlplWGpFL294SWV4cmJsSFVY?=
 =?utf-8?B?ei9yODl4aEtydzhNeVFDdWZzbWlsZTM4czdpT2pqMU5rem5xUVVsYnhnWEZC?=
 =?utf-8?B?bEhhTmNmZFFSalc5WTFkQm5sdDhPKzdZcVhUU3h6eTk1S3hHaVJBMXdyZUFr?=
 =?utf-8?B?NFNqS055U2p5WGo1alBTeEo5ek5Id3Q1MndvWUpkd2l0ZldHUjY3cTdwL3pi?=
 =?utf-8?B?QkN4SWliM0lPOTRONzJjQmVIREFZUldNbkFLeTJ3UjNOYkhIbnBXWjBGNVRW?=
 =?utf-8?B?bUpDRTdObFI1cmhWWGhRZnNjNWRlc2ZWeGZnM3lDVkV5NldFTzI4Q2w3VkMy?=
 =?utf-8?B?a2hFNU41Q1pGMUYwZWJncC9VV2Zna0xkSC9oTGtzb0JSSXJYSlIwZmJxYTF1?=
 =?utf-8?B?OGtnQlFoN0kxWXFoQTRLWkJyLzZVeW11ZzI4WEIxNUdoRjZSaUhsWXE2YUFM?=
 =?utf-8?Q?oq7SB/IuEWlqjGkiGrcaBgOIw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98eff82b-927a-443a-8097-08dc41cdfdbd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 13:20:16.4240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ynOdXaL19c3PgtJ0p6qdCEaVaRZf2YMrApDZHSAjrPFkSw8ZFegwG0SnfzMRrMC0gamyVx3+tGyc8hLlL2mtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7882

Hi Paul,


On 3/7/2024 1:29 PM, Paul Menzel wrote:
> Dear Vasant,
> 
> 
> Thank you very much for the quick response.
> 
> 
> Am 07.03.24 um 06:33 schrieb Vasant Hegde:
> 
>> On 3/6/2024 11:39 PM, Paul Menzel wrote:
> 
>>> Am 06.03.24 um 17:24 schrieb Vasant Hegde:
>>>
>>>> On 3/5/2024 8:18 PM, Paul Menzel wrote:
>>>
>>>>> On a Dell OptiPlex 5055 Ryzen CPU/0P03DX, BIOS 1.1.20
>>>>> 05/31/2019, Linux 5.15.112, 5.15.131, 6.1.53, 6.6.12, 6.6.20,
>>>>> 6.8-rc6+ and 6.8-rc7+ log the error below:
>>>>>
>>>>> iommu ivhd0: AMD-Vi: Event logged [INVALID_DEVICE_REQUEST
>>>>> device=0000:00:00.0 pasid=0x00000 address=0xfffffffdf8000000 flags=0x0a00]
>>>>
>>>> I did look into attached dmesg. I see there is a mismatch in
>>>> IOMMU Feature bits. This is usually a BIOS bug.  Can you check
>>>> with FW folks? Specially I am not sure why they have enabled bit
>>>> 62.
>>>
>>> Unfortunately, this device is out of support, so Dell won’t look
>>> into it.
>>>
>>>> [    3.527391] AMD-Vi: [Firmware Warn]: EFR mismatch. Use IVHD EFR
>>>> (0xf77ef22294ada : 0x400f77ef22294ada), EFR2 (0x0 : 0x0).
>>>
>>> This is a known issue with the Dell firmware at least of this
>>> version [1].
>>>
>>>> You are hitting fault with device ID 00:00.0... I am not sure
>>>> whether this device is managed by IOMMU or not. Can you add
>>>> `amd_iommu_dump=1` to kernel command line and boot the system. It
>>>> should tell us which devices are managed by the IOMMU.
>>>
>>> Ah, thank you for the hint. Please find the Linux messages with
>>> this parameter attached.
>>
>> Thanks Paul. Looking into the attached dmesg, looks like 00:00.0 is
>> not managed by IOMMU. Hence we are getting above error in dmesg. This
>> needs FW side fix.
> 
> Interesting. Could you please share from what line in the dump you deduce your
> findings? 

[    1.528983] AMD-Vi: AMD-Vi: Using IVHD type 0x11
[    1.533624] AMD-Vi: AMD-Vi: device: 0000:00:00.2 cap: 0040 flags: b0 info 0000
[    1.540874] AMD-Vi: AMD-Vi:        mmio-addr: 00000000fc000000
[    1.546728] AMD-Vi: AMD-Vi: PCI segment : 0x0, last bdf : 0xffff
[    1.553012] AMD-Vi: AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 0000:00:01.0
flags: 00
[    1.560690] AMD-Vi: AMD-Vi:   DEV_RANGE_END		 devid: 0000:ff:1f.6
[    1.567420] AMD-Vi: AMD-Vi:   DEV_ALIAS_RANGE		 devid: 0000:ff:00.0 flags: 00
devid_to: 0000:00:14.4
[    1.576574] AMD-Vi: AMD-Vi:   DEV_RANGE_END		 devid: 0000:ff:1f.7
[    1.582691] AMD-Vi: AMD-Vi:   DEV_SPECIAL(HPET[0])		devid: 0000:00:14.0
[    1.589330] AMD-Vi: AMD-Vi:   DEV_SPECIAL(IOAPIC[32])		devid: 0000:00:14.0
[    1.596225] AMD-Vi: AMD-Vi:   DEV_SPECIAL(IOAPIC[33])		devid: 0000:00:00.1

With this we will know what device ID ranges that IOMMU manages.

> Should 00:00.0 be normally managed by IOMMU? Also, excuse my IOMMU
> ignorance, but can you please elaborate, what is happening?



iommu ivhd0: AMD-Vi: Event logged [INVALID_DEVICE_REQUEST device=0000:00:00.0
pasid=0x00000 address=0xfffffffdf8000000 flags=0x0a00]


Basically 00:00.0 is not managed by IOMMU.. but it trying to send request. In
this case its posted interrupt write (I confirmed that based on flags). So IOMMU
logged INVALID_DEVICE_REQUEST.



> 
> The other interesting detail was, that it’s not happening when rebooting the
> system. The IOMMU dump in the attached log is the same, but the error is gone.

May be device is not sending any messages. So we didn't see any error message
from IOMMU.



-Vasant


