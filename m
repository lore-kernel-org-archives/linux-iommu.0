Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012060.outbound.protection.outlook.com [40.107.209.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95404231845
	for <iommu@lists.linux.dev>; Thu, 18 Dec 2025 08:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766047725; cv=fail; b=R64ZDas3vOtzNFKoRlTdJ9VdZlz25WK7CXwe7R8CXw0s2cE7sh0zkROz3hcGt2loQ15Eu/OMVfe6cvew0AfHg/mdpgDGFo7jz4aIdvuyIIDLoxwV+0nnr3INuJRuJUTf+FXXXrsJOtMcY7M0W0LkyE7JOytjhyAfLYt9hMUUEug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766047725; c=relaxed/simple;
	bh=bCEemP6tZC1NZaBpi4jNiMwcUhTJ2cCNyqWrthbaCeg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S8R+nf0KdltnhXUgAlhDwAPaLfFx8TZc4YGu+9u5nVw21OsyPBIX7U9OlI9D6XahDaig1Ci8zT5GBb30YvUlzFC+vXblGd701LEl2FS/t09nkboaR7t7WxsGp+AfM3XgCYsX11UAoBiSqcWMFcJq+l4NUlg6sV2CUI73WrueXU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ob2ubfXQ; arc=fail smtp.client-ip=40.107.209.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ob2ubfXQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VdJtKZGD7XrImvRTxvm2n9VMfsAW7PgcW5AbBLBcS2fkXzzeCzIjB5Fk+DHmXoe8+WNyLoch5zFhwnltbNJ+xMlCApj3qHu0qrj/xvyHtABVivkMIfHSLNXo690/wMnoh2+AepNHm/6klXy9I1Hr0wfxahi7TxBM+pRAHqJZKFf17rrkZkpV96Pgl5AokL4TVPzYjAZn3gjlfvz3WW3mpJgOYZCp+We39aVUgZE6BEYoZIPZH9/UJ70bgcgqQG+c7Ae24pDLanXJCnEpEEV/y2lubt5YW3YPKf8BaY3Pd56317r5lpeP8qqMkz1rCSz6TU8k5mDvhY+AJMjfiH0KPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rf9QM0p0RNDLwrA92kQQ0YbGoXRVWmUF8CmnhPnRQAw=;
 b=laWyYQXVg8cL+esOLiVgUMN6HdlvnGmqzvIBFfJbCwYqy8gVQXUMFAtUOX/oL4VCgRimJy3yeL3Euz71Kq/s9ccStH8dcX5tRaCqA95HR6Jo3PiyE10k2OeFIc9MMb/3o7WG5y7UI+5sfmSRmPGFpvy5mAGshENLM1JOb49AfkVPJhBmEQd3iiCUOC9QN1v++N8F9GZdgDMU4PebFYBEnFg0NNvlna8c4XgnOO/dfv4D8svUiCdcUNv1VnGaWsck5lVF2E8LDRtILyE9Y1xvv9F5QMRAJwzVjhe/P/LFT+p+LPQaxT9vaBf84DrXyi/mItWtNYIaVD1WzaeNeU9qCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rf9QM0p0RNDLwrA92kQQ0YbGoXRVWmUF8CmnhPnRQAw=;
 b=Ob2ubfXQwN7pUiq0BxWNajhWATShhJZDC7aBFN1jtcBP9cP/RocrYCgF5eNByhpbZGkICoSiBdxP4Il5IQzF+d9I+hCdvitMAYS50KmCmvS6Crx6vIr25EwDinoZbCIUQMxfClklXuH/V6AeFAHS0POObAA4XQQu0g0Jyf/ulGUJ4HQy1/q7rt7QgEbBftAtkE51UjiqYMRVb9gnlK5mT488REgT4xaz/IBP7spt1dGH9/lqQzrT6EkV9gPQ5wW38cKUbRCbUsDkmggGsUx/r0h26W4JAF41bweiJc2s2h7n2jWI14unbCcod0t1wyHmRmolV6AdadK9I351i66UEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by DS2PR12MB9749.namprd12.prod.outlook.com (2603:10b6:8:2b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 08:48:39 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%7]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 08:48:38 +0000
Message-ID: <e7d3e95f-a885-4b13-ab4d-bc82793c5396@nvidia.com>
Date: Thu, 18 Dec 2025 08:48:32 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 2/4] iommu/arm-smmu-v3: Add device-tree support for
 CMDQV driver
To: Ashish Mhetre <amhetre@nvidia.com>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolinc@nvidia.com
Cc: thierry.reding@gmail.com, vdumpa@nvidia.com, jgg@ziepe.ca,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20251215064819.3345361-1-amhetre@nvidia.com>
 <20251215064819.3345361-3-amhetre@nvidia.com>
 <23df682e-6d08-4827-994e-1bbd89e5c903@nvidia.com>
 <5e9a0ce1-a0ba-4a31-be95-99f349ec6028@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <5e9a0ce1-a0ba-4a31-be95-99f349ec6028@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0404.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::13) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|DS2PR12MB9749:EE_
X-MS-Office365-Filtering-Correlation-Id: 7523bc53-5609-4cba-1603-08de3e123cf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWhlSUVueVorVU1HZmpJL0hoUTROVDBOWllja0RZNk9yMDJ4MVZnRE1aU2l3?=
 =?utf-8?B?dDRsSTZ6Mm9JckdGbnRhTEZRRVgxTmFLcFBqbmY2by95dEh5NW9kU29uUHgr?=
 =?utf-8?B?RE4xWktNOFpIWUJMUUI3QnUwZjc2d1JFeWtMT0FxZTFGL3hUSGdsNmtTK29w?=
 =?utf-8?B?aTUzVmRDTk14bjArWWM1VnpIZDhIcThhYXNTb0U2L3l1K1lhM2JmZDNIYWdR?=
 =?utf-8?B?ZmlUQ0wzNzQwTUhoL3YwaDJhRnIwQ2hVVDVmR0g4RzFKVmxYcWQvRzBLY3lx?=
 =?utf-8?B?K3I1UnlaVW0veXJxUWpyUjRBUUhOZ0tjM2sybzdvMWdwc2oyaEZqVmo2aFlC?=
 =?utf-8?B?TUorVitBaEE4YlNPU0lWeFphZ1YwQU9XUE1hbGh1Y2taUUU1bFdKVTVsdEVH?=
 =?utf-8?B?YzdlUFRzRUZ4QkpZUzZNZTRGNTdldjRSdmpOZnR1K0tyTjNhQUNBcEJvaUxB?=
 =?utf-8?B?K0xXKzhiSGZjVTNnQWNOdkxOOEVHZUErVnVRZlNZRFVIYzZZbkVWNGFNTW5p?=
 =?utf-8?B?RUdxNm5Db2FSd0draVdkdVAvazJ1TlJVem1sRHI1Vk9QdXJUK2Nqa3pPUWYr?=
 =?utf-8?B?V3M4NlU5ZG01THorV1lneTYwZWNKUnBDSjZ3clUwSmV4R01nTUdBUFkzM3VQ?=
 =?utf-8?B?TjIzK3crQmJLSFUwWFM0TlJodHFBRWZvZVJEd1U4YzlKK2lzbEhpNCtOaFhu?=
 =?utf-8?B?ekRlSXNXbXFtU3BZWUdWS29VUjZDaHlWT1NkQjM3c241dHlwRkFMTFRmbTMx?=
 =?utf-8?B?Z2hHRG1ORFNEKzZsVG12WlU3dUdzeDRJU1BVTjhyaUEzblAza2g4Q3hjVmZV?=
 =?utf-8?B?dG1kVUdRWi9ucS9ISk93Q3p5d3JRcFJEVFJha1ltOTNJdkhFN3BXeW5FWUJC?=
 =?utf-8?B?MDY5cSswZUdBZmFKZkVrTzRYc0U2S012Y2IvSVFDOVpSeXVGcC9RT2twbTFY?=
 =?utf-8?B?eC9OZEJZUVVzTmlqb3FYOTJQdmxqRWlZVEFnK010Z0U5YVpIUHpiYS9ScTN0?=
 =?utf-8?B?MFlDYXBPTHpHdlBON0hrZzY0bTRoMDZKSlFSanFSUzVnMU9QdVVnbmxFL25p?=
 =?utf-8?B?WmNWeVp3UGxYQTZxMjFkSlU0VU1UL0ltU1B1T29FdXZ4RlA1RXErZUZHdWJR?=
 =?utf-8?B?MTd6SC96SzM3NUxIUmY2R2JIblkxWFlxbUpoU2U2Qll1djlvTHA2K3prc0k5?=
 =?utf-8?B?UnYzYUJITUg5ek1aQlIyQjlYeWtGL21EZms5Wnc1UHBzT1c1R05nV2FsaFRQ?=
 =?utf-8?B?aUhNQU50QURRK2l4Wk1jUzRZbDllVzdGT1Z5Smx0WG1GcktveDhBT3NZSWFS?=
 =?utf-8?B?Ky9FQnBhK2NzemdaRy9KMWJ4WTlibkVGdExYNEF3cTZEU3BnZVVMbzJVL2NR?=
 =?utf-8?B?aDRaYTRSdXNOa25Jelh4L0xmWUxoMEFUMzkxampORGhUN2k2RXdyTVZSMG5l?=
 =?utf-8?B?QlUzeXZqRGxEQ1hZNmQ2Um9IYXl0b2srWnZwUnpGYTYvV3I4ZmpnL3ZtVlg3?=
 =?utf-8?B?aW0vYUVpQnVOeGw4aE1BU0NuZEdsM1doZzhDY1FqUW1lZ2R0TExxRVV0aS9m?=
 =?utf-8?B?c2NCRUszRElyQ0xSZ3UxejFDcVhnaWRtM05EeEc3QTNLVm1KTmZkNTdmcGVL?=
 =?utf-8?B?RzFDZjB2L2xYQ1BtU1hnVWZCUkNRM3hsb1RnQkRXaFU0U25JRGpSbERxYVF1?=
 =?utf-8?B?RVJ4Z0dJSG0wcDBBUmdKNXNpa1l2emk5ZGlXbXBmaXVxVmZRWTUwbEZDUlZn?=
 =?utf-8?B?SCtGWGxaNGo0dG1ZZ3ltY2ZqOW5vT3N0VzJkYlhGM2VSckNIS0VyTGZTZzMv?=
 =?utf-8?B?OE9HcEtlU2tUQTg3YWxnVXozbjQvSGFKck5ZVW0zRFRERm9PSWF2WVJ6OU5Y?=
 =?utf-8?B?eVFNZjJZZlZsVFh5elR5Nm5FUXBENjk0eVYwR2RBR1Z1cFZpTkVpVkNlNHFt?=
 =?utf-8?Q?xG4StJSdM82Cz++Zlv7GILteKajaRpgM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1p1M2VnN3orb3FwR0p1RFlaZTVKNTJiaU90VmRmRWlEeGdmU1oxeSt4dEJs?=
 =?utf-8?B?OGhXbUtaZmViclBSTVRHeWNucFpxbTB3ZWo4R1N1SU8wSmhPN28xVE9vT3U0?=
 =?utf-8?B?MkxDbkxLKzBTMGVaNjNoU2cyRjVHSS9QVkVxNXJGTjkvY2VLMzNKa3l5SzNF?=
 =?utf-8?B?SXh1TFVmZkkzYmFXZXM0ZDB4c1Q4eFVyLzRWdDNqa1VrVFFEMEl6OUNjR2cz?=
 =?utf-8?B?bEU0blEvY3Y2UDVwMmlTUVNQNXNWTnFxeERLSUpvMXpKRWo1eDY1ZkN2YVFJ?=
 =?utf-8?B?blVSTXlhbHE5MmdEV25RZWFaSENRTW9HUTlGSFoyb0hteW1INjNjMngrdnB4?=
 =?utf-8?B?OWxuUDg5UWJSbzdiVDQ5U1ppYTFjalBtNW85NWlWbzJqSDJ0bCsxei82cS9K?=
 =?utf-8?B?SERWNEVVOExlUitMZXR3dlRWRk9jWmxiZm52b0Fpckw2Z0FQSEQreE94Nmla?=
 =?utf-8?B?Rlk0aGNESHZ6UmwyRFh6T05ZYWpEMWhoY3ZRRGUvNjV4ODE4dlRnT281d21T?=
 =?utf-8?B?TTdTSHVXTm1MVTNtcElWaFNnTFErZUxNQzZFZ0Q3MlE2VHBxY2dwckVMelBr?=
 =?utf-8?B?UVUzaGhWSmdVbGt5cXpuSEQzNEpmMENrcE8xU0JRaHU4SERaVXkwUGlPaDIy?=
 =?utf-8?B?bzBPemw3VGc0bGRBV3Q2WE9PMmZTcGlwRzBYNzIrdDhyNFJYUjlmVElPVkxt?=
 =?utf-8?B?dERTUC9oVXJFL1Z4citzcURxYXNrS05YanlhVmdCV01jSnlqNjBLc09tSWZy?=
 =?utf-8?B?cmVXZm1OTXQ3Y3JmWUxEQzlUS2VJSkEwTXVKZ0EyZ2JjVDJsU1ZSSkEzSFBU?=
 =?utf-8?B?MUFuQ20yTHlPcW1NTXZrOW9LT0tnMmxEaWhOMW9SdEt5MkNiWk50Mlc4anR1?=
 =?utf-8?B?VXNtaXNQYnlTS1lDUGd3OVk0Z0NMWTJ3NjdHWEFkTStzd0RVNHNWcUlLM0E4?=
 =?utf-8?B?SnpKbVRWaUJwd0tQVllpd2hzK0N3dm94WStWRXM2MFpkdHBXaFQ2YjFhcGFF?=
 =?utf-8?B?ZmZnWDZXclNvTEZNZEN5U3AyM05mUTdKVHFtT2xYV3REeEUzSTVZTG9FSnUr?=
 =?utf-8?B?K3dQK1Y3UXdJcjZINndzYUx3MytqNUE2eE1IVVRKU1AyZDV3aDZxd1FEVFpP?=
 =?utf-8?B?RGVNcC9VejVlTWgwK0lJWjdFUE0xdzdzL3c5WVplYkZlNDEzd3pGV2dDdDJy?=
 =?utf-8?B?WEFVb1BsUlp5K2pweWliSkswVUJGeGQvUHJpUFJoRnp5WUEzV3h5TWFoOENt?=
 =?utf-8?B?eC94dnhSSWYxRmszeTQ2K1lHdVh3VUc3QXZrdHRWYWRXSGthZ2RTbVpHUjBH?=
 =?utf-8?B?UXNOc3dibndwbWNYRmRmbjUwY3N1bUtsenAyMEZEdzVEQlBXSk96eVgyclV6?=
 =?utf-8?B?cE1qV0ZGUTlwZGVKU1JZd0JJSS83eVJ0STVEOTgzS3BPUThEVExFOWZwT0ZR?=
 =?utf-8?B?U1FuU2hhNXY2Uy9qMDIwNDZCbnlVUDlyZXJPazJIMGR5ZXRQcVBRNUlSb2hZ?=
 =?utf-8?B?TlRGOHU0ejBwbDZxVWhxZm1qUTdhU1IzR05sNFFFazZ6cENHWHFYMzZ5QjJI?=
 =?utf-8?B?S1U4eXdwSTNaeGFWcW9hbjBNMytGUDUzOWFhOWRZVlhQQmhvQkthS00xTGNR?=
 =?utf-8?B?VFcxSVdpYnNkc3MvazNxcWhtRG1nNUovd1ovMVVXUVoxVm1YVUxCbGhieGhr?=
 =?utf-8?B?azQ5cGNVbElpZDIycmY0SHI5QlhYZ0tvSjNaVFJlKzVINE5oZ1M4ekhzbE9M?=
 =?utf-8?B?c1lXWVF6UDA4c3MwUkEwSmNnQ1lhV3Q0b3JaSWV3QlVtQjc5N3NlWHRSSXBk?=
 =?utf-8?B?Z1RtUHpzMmNHWFBzSE5NU1FqVko3bGo3WkZYK0NWVDd1UVYzUEl5MnQrUWdh?=
 =?utf-8?B?Y0s4MkN4WkhZWDVyYUswdFRJV3hFSmtsU1NCQWxJcVR1REhpRkdXVmpyU2Zp?=
 =?utf-8?B?T0YyOXFRa3RoR3hnSk95UFgvSlJvMWF6R0pScFVCMW0rbkJVdFAxK09odEo2?=
 =?utf-8?B?ZEF5bWc1YmlKbklwcC9pbEZ4WkdITXo3UnpEOFFZZk1rd3l3Vkt4b3lBYlov?=
 =?utf-8?B?RGo5V1BXRmtiMitYa0xiRXRLNSt2eDJNM1EzMnhaOUZ6ZVltV2JlZGxuTnhl?=
 =?utf-8?Q?RAM9q9wUjuFOqFVEWu1udQdGc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7523bc53-5609-4cba-1603-08de3e123cf7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 08:48:38.8733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 042zJbOVTM9RL/uw0+wWIlkVs1FSv6WlKj/Ip+6EYvbeEbvDT1x37tSVnFl0gGVYM7uqWEHDoeHPxWPRo3kpPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9749


On 18/12/2025 06:32, Ashish Mhetre wrote:
> 
> On 12/18/2025 2:13 AM, Jon Hunter wrote:
>>
>>
>> On 15/12/2025 06:48, Ashish Mhetre wrote:
>>> Add device tree support to the CMDQV driver to enable usage on Tegra264
>>> SoCs. The implementation parses the nvidia,cmdqv phandle from the SMMU
>>> device tree node to associate each SMMU with its corresponding CMDQV
>>> instance based on compatible string.
>>>
>>> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
>>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>>> ---
>>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 32 +++++++++++++++++++++
>>>   1 file changed, 32 insertions(+)
>>>
>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/ 
>>> iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> index dad3c0cb800b..0cd0013200f3 100644
>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> @@ -4530,6 +4530,35 @@ static int arm_smmu_device_hw_probe(struct 
>>> arm_smmu_device *smmu)
>>>       return 0;
>>>   }
>>>   +#ifdef CONFIG_TEGRA241_CMDQV
>>> +static void tegra_cmdqv_dt_probe(struct device_node *smmu_node,
>>> +                 struct arm_smmu_device *smmu)
>>> +{
>>> +    struct platform_device *pdev;
>>> +    struct device_node *np;
>>> +
>>> +    np = of_parse_phandle(smmu_node, "nvidia,cmdqv", 0);
>>> +    if (!np)
>>> +        return;
>>> +
>>> +    /* Tegra241 CMDQV driver is responsible for put_device() */
>>> +    pdev = of_find_device_by_node(np);
>>> +    of_node_put(np);
>>> +    if (!pdev)
>>> +        return;
>>> +
>>> +    smmu->impl_dev = &pdev->dev;
>>> +    smmu->options |= ARM_SMMU_OPT_TEGRA241_CMDQV;
>>> +    dev_info(smmu->dev, "found companion CMDQV device: %s\n",
>>> +         dev_name(smmu->impl_dev));
>>
>> This seems a bit noisy. dev_dbg?
>>
> 
> This info print is similar to what is there in ACPI path as well.
> It's only a single print per SMMU at boot time. Should I still change
> it to dev_dbg?

Yes, I would.

Jon

-- 
nvpublic

