Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10289157472
	for <iommu@lists.linux.dev>; Wed, 15 Jan 2025 05:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736918522; cv=fail; b=ImA3dzVbnI8Zs9wECyp5RxzYocR9rGfshRwWsXgqVRxlE3dwKtA+aVQtjDhRocZDwYrhpy3og1zlS3OGTX88fsU1kC59iOIF1226twSyYSUAbegQEcQZ3bhn2xl12aHrKnTx3EoNLvuRN/Btm0YQH1RozLszxMzeB+gA6S0hbao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736918522; c=relaxed/simple;
	bh=rdN79WzF69AFnBhqdmfZYUfdMJFYXk+e3u+0X1IfT7I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c0aGTJpdlJ3U/elGW8yIw/kxdEr/paL6uqP1alvF/HQ5xqljAAXYObxvCnDtoVoA9bMqnCNgsnyFwL0WAA4e+3GeAcyuRtFTcZFMC5S2hJEjdwfcks0vKOtgvXNHoybfcuuL+ZlQ7ecXmSOZGExw2tEyQDSLrM8170NSgpZ4XZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J+Q2Wo53; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J+Q2Wo53"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hYOh7Ev8wZsa3UqXmPTp1DdSKJwU8kxmXv7uRqX0yC0Xe3EVaOvQu0YiLWhgJlNKdfofXUKilzc2P9A+RI2T8+WRaWUqeAx9uFo05GaX8Kbc2xRJnZdBnaIR08oEpQNOp1dvM3msvMucg0bYUZ82lO9YumHKlfd0jze6jRfqMqqr++TfNkcdjAJC2DBTe1fdRDVcMUjBcu+Bqm5af01Ucsq+8aCykWXdWX5eSeFP9tWsDx3OAlIZN1xLN0XXE5rjgLF+CR1YlBWt9jNmpJWtaaNAKPo5od9lL1A/CTZQQH/bsiUsUvTxoPTGQj3bMfCdXhlef0rXbfttaYLSr4vlOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bk8l0sJesAJ5J1b9++arXpiFpsfIRIIPGcS/Los9jiM=;
 b=cmPLJD2W85PuIaKnHNpyEdvaeAEG1EJ83cqUTNXB2TvM0c7izUwglqDPIKYQPQ9L5WD9t0YaSjJMpLzknJCvzH/nWH61+VROc1dRNcYJV7gXi8ojnOYgtOCnSO7yS8VjHkKbKpKZzWJINlJUKStznCq6/TcCdKuhM4EJjEJwZqOZawRcN+BXVY0kMLcL3AnJiI4CpTvzYV7G+iRGG6NbneH7++NYk0uQxvmT+M7oM9ZN2r+0ChwtR10fMiNYFjWCPMSiOfpMjmwwK3ZsUwumdqz1XnUISqSHIgG+2vfWOPO+7wfNVXNRuvhrwDX7c5RuSeTHs0Vag+VDg+B5dljOQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bk8l0sJesAJ5J1b9++arXpiFpsfIRIIPGcS/Los9jiM=;
 b=J+Q2Wo53ALg97UVACUL2/P+F02o1gdYRetyaz4PJ9pWh6gqAXpz8/+V6jIMPhDkRq8sOPgAuq3B4kZm2bw+ESXhUIWPi2hzDCx/fyt3NXggi90lM1Kmm2LglC6t4RrlKk5A+gnv0Gz5CUZiXjkPoBjNvVI21YD93/g6WZ+/seqk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5163.namprd12.prod.outlook.com (2603:10b6:408:11c::7)
 by DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 05:21:58 +0000
Received: from BN9PR12MB5163.namprd12.prod.outlook.com
 ([fe80::61ca:6d43:a98d:3b7f]) by BN9PR12MB5163.namprd12.prod.outlook.com
 ([fe80::61ca:6d43:a98d:3b7f%6]) with mapi id 15.20.8335.011; Wed, 15 Jan 2025
 05:21:58 +0000
Message-ID: <1c26ea42-43f7-4b0f-a4c2-7c1edbf664a1@amd.com>
Date: Wed, 15 Jan 2025 10:51:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] iommu/amd: Add support for device id user input
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 vasant.hegde@amd.com
References: <20241126210237.GA2656401@bhelgaas>
Content-Language: en-US
From: "Srivastava, Dheeraj Kumar" <dheerajkumar.srivastava@amd.com>
In-Reply-To: <20241126210237.GA2656401@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0010.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::15) To BN9PR12MB5163.namprd12.prod.outlook.com
 (2603:10b6:408:11c::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5163:EE_|DM4PR12MB6280:EE_
X-MS-Office365-Filtering-Correlation-Id: a9912fcb-0f87-4ce4-3e83-08dd3524883a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkZHMXg0ODVmUjc3WWhVM2R2UjhwZHI0SGpJdVlXcnYvdFVnNlNrd3Yybjlo?=
 =?utf-8?B?d25kcFdRTURubDJRY0s3THUxNXhKdGY4QjZiRnF6VTdnOS9BN1NGNVROMzAv?=
 =?utf-8?B?azBtaTJFNmJraWxoa3QxdkNmRTZWVVM0d0VoSWxIVlR3L3hZK3kzWkZ2REJ6?=
 =?utf-8?B?QTFtTTljL3R6SHB1ZUdyKzI2QUozdDEwR0lKdm5Ta1VRcUtuKzRRYkRMbE5H?=
 =?utf-8?B?UWJyZ3ppVzZta3hlOCtVbEVDeUtoMmsyNkY0MDVncWlWMDhsTXREUm1mSEdY?=
 =?utf-8?B?QlVlTVdHbFhSN3Qvd1k2eDJIRGszZUxLekVhZGJld1R5K1VSbzQ0Q1VvamhI?=
 =?utf-8?B?TUQrbWlXdnRIeE0vRGRNQU5yMERjd0ZXb3Uzelg0NHJkWXNxUnYvRjJXNWs0?=
 =?utf-8?B?aHZvS1VWSGlqelA5a2dZb0pEU1BKQUpOaXE5NnpmT3gydkl5SFNHZjdGaVpy?=
 =?utf-8?B?RTFqbVJubjl0UkVOOVFvdVEwUzJmRFVjYldzSFE3Skx1V1k1YlppZ1NiRjls?=
 =?utf-8?B?SXRqTlhHTWNyM1ZtcHU3TFg4MzI3ODIzRENjZVA1MDgvS1BLVmdYRzdiMDc5?=
 =?utf-8?B?NmxGMk44R1dJNjdNUi84VjlFV1pzM21DclBZUW5saGxYZ1dScEFqUElvTC84?=
 =?utf-8?B?WlVTZHBIVzByNFN2c3ZVWUNyaVd2RVBmR0g5U0U1VjlDblVwT2d0K05XaklB?=
 =?utf-8?B?LzNDWjkxeS9QMXZJZlNJRXVkQTFZKzNWWFpoWVgzc1JJaFhXTy9YTVgweGUv?=
 =?utf-8?B?cVR2QUw3bU5relBuL2ZWbFNsSFZ3RWxOUXRQeUpscEVnOGdTMzUwN2VlQzR2?=
 =?utf-8?B?R09VaXhaQjk2SHdSdmZ6aGYrNTdRRCtoUHpseEs1UHNjVHBnSHpmMklGc0la?=
 =?utf-8?B?dC81N0RweU4rMmpXcG5LaDNObVcxMTRCNHUwNkE0cG1mNFJlVVRoZ21RWWR4?=
 =?utf-8?B?REJFa091emhuS1A3RStJamNWY1ZlOHFldlIyNVdDNjZsQ3NVaFR1ZEI4Ymx5?=
 =?utf-8?B?MUNHU0lsd01UZFFRWnRFQVNFbnBKUFVoUUVQT08yaUxYRkJXODA5YnlPSDNu?=
 =?utf-8?B?ajM1TFJ0ckhNUHkvRTh0TUtMS3NjSVl4YThwcy9IU3d5R2wzTEFzT1p3YUFk?=
 =?utf-8?B?UzNuUFd5K1EwaHN4QWFwSzQrSlkyWFJJbjRxeWRXUG4wRW5IRDR0VzNoSmo5?=
 =?utf-8?B?engzQkoxalVWYzRoME9sZlVWcG93cElPWG5ZcWcwWFFOZnJ2MERaSmRqY3FZ?=
 =?utf-8?B?U05RMGhld0FmTUZzcDJQWlN2SllCc1VVaFdFUmJ3MmQ3dHczTVIwK3VUWThS?=
 =?utf-8?B?K1R6bC92dEE5NEdxbVdzbHVwREYwMEVoaEE2UUhCcEhCN0MvRHFvZlBjaXdu?=
 =?utf-8?B?Zi9Pd1FXblJyNkFFdVRkQi84VndhUTJpaHdrQ3lJL1FNWDhQbm81TzRjUlRD?=
 =?utf-8?B?U2dvU0cyTXJ0VDR4VmpXY2ZsNis3SlR4YnRYYnpwaGV0bTZPMlJSR0Z1RzQ5?=
 =?utf-8?B?WDdiS0Q0aWtDNGtOTXhoU0wrWHhZUWNFTklGeVlyeGV0cUtyUENCeVphQ0RH?=
 =?utf-8?B?TUNFZFRWTmdoTGcrd3BMS21KdEdXSjlmUk9oTW1hcUI3eXRNT1d0WW9FZkRy?=
 =?utf-8?B?YzBId2ZtOFZ2ejNteVZwTjRWQ3ZZQVRKazdMSTNoNGFFby9xMTdsUmdzYWQz?=
 =?utf-8?B?R1VqbjMyQzh5clZrOE5uUDJCWkhLNkYwbTFaU1loZ3I4Z2laR0NqNnZnN000?=
 =?utf-8?B?Qk1QRjltS0pBSTBPRXdRK0NYRjhNMElONGhJVDdLa1ZwTVd4K0l2SzMwZmti?=
 =?utf-8?B?Sk1Tc0xucHhVSTF6SC9kRVlYd0t6bGg1WG40SGRaWjJZZXc4UnVRcExOTmJp?=
 =?utf-8?Q?i6x0yUSkwoTrd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnZ1em8xd2thVjBHTnZ0N1ZlUjNBNDExeDlIVDhsTnp1ZGtqM2RkM2gvYnU3?=
 =?utf-8?B?RDliVnp0UU1Kb0ZlUG04QWR6aHlrWTdJOExudHUrY2w3b3hwUmgra2xzQ0tx?=
 =?utf-8?B?T1dPNkNPL25lS013SC84eUxJOThVVG9zNTVtclQyOG1SOGdTaFIzSWRQUmVh?=
 =?utf-8?B?Und0cGZ6MEJCYSttS3AvdmFzTXhxTnpxRnVRQ214UmJnU0MySFpMZlhhS3Nu?=
 =?utf-8?B?R0g2QXdzUHRsR3FoZjNKSmVKMjBNaXJOOTJlTXJqR0ZJMWluVEszTXdQY2tt?=
 =?utf-8?B?cWNTZEljMlFLQitucEo1OXVtVXpzWUFUT2V2Qm9USHVGNHVBQkpJU0RiR2hO?=
 =?utf-8?B?bTczUDJLOHkvVkZDTGN0ODRWS2d4cEZIS24raTZ3NnZMc2NhSzhjWkpSMzJW?=
 =?utf-8?B?THBrTHNLSGlyVnRmT0dTT0VVblRPSDVBSHQwbUZ6SnZENWNjcjRNczFEd2pu?=
 =?utf-8?B?Qzg1VU5kUFdNdmxiSE9sL1RFQWV4ekZoWUJDZzZwMWMycnNaQVhtWGZCa2pV?=
 =?utf-8?B?THpjby9TRXdFcmhWOTl3Myt5UVd4TnNEa2ZZZ2FCMkE4dTZtc2JuTFBDRUkv?=
 =?utf-8?B?Z2lGSk00WWlGRGR2S0MxdEp2dWF2L28rT2dQMXBVNXhleERpeWRDTXkzY241?=
 =?utf-8?B?ODRwaitBUE9DVWJFclRkSE90anJXQ2JKMFB5VlV6VTRZeEl2YlhuRnNIMHpB?=
 =?utf-8?B?L3RwUThHQldTckFDMGUyd0JMaVQ5Sy9hYW10RklUOUR4TENGa0FEOGw2UDJT?=
 =?utf-8?B?b3ZWZk5zbkVjbEF5Z1VrcmVOOWZkODQ0ZW4veFF1QlFManpOcCsydzVublRJ?=
 =?utf-8?B?TGlVWW5hSWorOUZmQ3RJSEVKRTBCSktBNDdqSHp3djhUTHAwamJSb21xNHJS?=
 =?utf-8?B?OFB2Umc4OUFBSkdCSG5lK2FFejg0eUU0K3oxWm01U2FTc3RCSmIveElndnVQ?=
 =?utf-8?B?QW9DdHIyNmkyL0hsdk85Y1RCSjVxQ2lpQWJ5S25COHNTOTJBWk1rdlY4Wjcy?=
 =?utf-8?B?bTBJS1FPaXdBeUx3QVV5enJaY09SRW4xVVZRd0lkSDZoUGViUGVtcjhaQ21I?=
 =?utf-8?B?NFkySU1pMEdvaHYyVTlvU0M2US93eThIdEJPSHJyeEk2ZmhFbE0zbFFUWElH?=
 =?utf-8?B?ZkdTK2F1VGlRd2s4OTlCU0ZZV09WZnVUSGVCa2gyN3dsK3hUNzJoRWNmblAy?=
 =?utf-8?B?ZUEvWjFxbHV6Y3dmTmFsK3NQYUhwK2J1UVh4ZTlrMTdDQjdKUmNzUTM3cW0x?=
 =?utf-8?B?Y3RtMmc1MkJxUWh3SEpPclQvZ2g4bld4bGM1SVlxWDNXRkVwUFdZcit0VlB0?=
 =?utf-8?B?UUVySjFDNitodzRxWkFIKzZoUmhxR2RRSUdoejJnZnZiMklKQm5hdllmbVRi?=
 =?utf-8?B?OEhLZHo2dktDNVpDK21Ga3g1bThTLzBmbll1SWN4QUtzYWZEREFIOHJWZ2lW?=
 =?utf-8?B?bnRVRVg1Zlgxb2FPU2plS1ZCR1Aya0V0NmRvRTVKZmJPeWs1bUZYeCtBbVRO?=
 =?utf-8?B?Y0VSSklvVldUanJOUGdtS0dqUDBabVRndnljbmJ2bElwK2dBWHhaT2VWdWFk?=
 =?utf-8?B?azBEZW96UUhmUEtnNy9QMWJUT2wzOEJuSlUrb3ZtdlVUYngvU3NCV2p5Kzla?=
 =?utf-8?B?OElQK1NGYUlVbG1TQ2JzenNJYXc4NGRteXNydXRMT2syMmExbHBTek5NRHFY?=
 =?utf-8?B?VXVhWjYzY2pRZW8rem00c3M2WGtxc0orZmw3YWZRQXl3WjFMNklYMTQvK1hw?=
 =?utf-8?B?U3ZpV0FZMzNLcGFybE9xSUFmMERpYVUrekd5STlzZk56b0d6ZVNiSUgxOUUv?=
 =?utf-8?B?UGhZY2dYeG5tUVNsaElybWFseElEZCtpQWhBNytJK2pFekh4cjJ2UmRHTU9E?=
 =?utf-8?B?UVBBMWUreE9NcUxBSFhqKzdtbitNSU94Tzl3NTBpWjl0aFdGSGpYMW92NFdG?=
 =?utf-8?B?b2ExaGZGTGhocWkxSitTL2JxODNrcGFQQ3NEa3lhUG16QkxWRHBwd1E2SGVn?=
 =?utf-8?B?N1RvOG03VGl4MnkxTndQMzVBMllNSjltdVlmUk0yNG56TmdyZ0VuVlVlYzE4?=
 =?utf-8?B?cEtSRnRvMmI2VlUwMTVBdkJLOFhsYyt6TUFpd2lQb2ptQml1RVpjN2ZhREhj?=
 =?utf-8?Q?AF+WXbeJkGYnjLgk9mKcTMw5m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9912fcb-0f87-4ce4-3e83-08dd3524883a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 05:21:57.9823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FVCR0i8HGu0xKTM1NUcVxvjhCeIh9uqhvrSKj2N8NYKSTkfPR/6XeL6ZlEB7OSIDC1KsTgvTZOn0aojWWQd6Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6280

On 11/27/2024 2:32 AM, Bjorn Helgaas wrote:
> On Wed, Nov 06, 2024 at 01:16:36PM +0530, Dheeraj Kumar Srivastava wrote:
>> Device id user input is needed for dumping IOMMU data structures like
>> device table, IRT etc in AMD IOMMU debugfs.
>>
>> eg.
>> 1. # echo 0000:01:00.0 > /sys/kernel/debug/iommu/amd/devid
>>     # cat /sys/kernel/debug/iommu/amd/devid
>>     Output : 0000:01:00.0
>>
>> 2. # echo 01:00.0 > /sys/kernel/debug/iommu/amd/devid
>>     # cat /sys/kernel/debug/iommu/amd/devid
>>     Output : 0000:01:00.0
> 
> The corresponding Intel IOMMU debugfs support encodes the BDF in the
> pathname, e.g.,
> 
>    /sys/kernel/debug/iommu/intel/<bdf>/domain_translation_struct
> 
> Can you do the same?  I think it would be nicer to use a similar
> style, and it would also make the code simpler.
> 

Hi, Yeah i do agree with your suggestion. But lets keep this as open 
question about how we want the interface to be and get more suggestions 
on this one. Will reiterate with all other changes suggested.


Regards
Dheeraj

> Bjorn

