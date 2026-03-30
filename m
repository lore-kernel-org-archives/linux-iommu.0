Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011048.outbound.protection.outlook.com [52.101.57.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0E3382362
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 10:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774864939; cv=fail; b=RmsJBAx3I+c9oIUAw5y+tKc4gH7xYFZ0iRH4iDGv/fwniWZKD3jg2IbpLKJnRVfSoTL1X07fQMk7Uyx9Cu4CEj0VQQrXdOfxBc2Lp+JuLbLg51Xi3V3JLfuRmoXNFD9Sl+030V4xVx+YDKnf5XKFtyoe0gGSqk2hfOzZxQ/OPdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774864939; c=relaxed/simple;
	bh=DZNUr7A5q0exLg2fmCYgBj8DLJy4JOF7i7nV4to9/b4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uWTI5XPemUdPbTrh3++zqL6cjF3S+yLuLpVIRuobXDfouRYw0mXdh4fqFhUNrmAx5mKRyN01YkTBOQjI8Z3to2vOZeZtO7CK/Tbrb9e0zFQWX9eZJGtn+cA3gnYH4kEDZBqdu8zqSnA7T4CjzFwCCJQlFX/VkGBHCsLPhKnc0E0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BpmXdKz0; arc=fail smtp.client-ip=52.101.57.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BpmXdKz0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQj36PK6JbBBHOS+9YbVoYp74qmhoCPKgbGJE12cwUZat4oqxkm1eF7NnFClxxr6Ndwg/NARjIG8unqh9GS/z0gITwW+1SuHcwrreWV5pycXGHmSB8ZxCAvGgmowveJi56SxrcBJ2SjEhSs8CFH2it7K9Q7w+GLt7r1cHSeUYVNEQnorrOcdcGEd2iPk8IYThenuqq/Xl4OHqubEuyZgUS80+FYGgCZ6aJ8oNEN1dLHBO9OS/ZL0l0qBsW1ahVWd2+8vY8TAsx1e0Q5m88CWlKSDbH+RnLy/pk5eM9/E+GOeQCTbeYqvaOwvb+3WCYWsyAnFDOp53jb5C97OHrmyGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sejk28YMtACCyPk3uAoTWEPHyoKXM9bcsDGfgdF2SQo=;
 b=nn4B0EAAsyH0lBTYJBpI0YEXaKf4Z2fxFFwXjH/xtb5Udk0xbRuY/jJfzap3MBD/3L8KIqBw/3zfQ/MG15pzYQYKNqMfZAkVsY3XDckGRM3ltAFTE27ADGN9kdpBpD0D7x/RLOyB5blmAoCnx5CLcGJ6gCKcNw0M3GnKRNcDYZ4gC5wLIMAzK24029ELiA1cnN9qietUXN+q9gYGATcx+W2AYqf1+8MetNV7Ud0JblcK+WekqtcDbPPo89DM7GBHSG04d9ElARXGVjXgwpFByjpatEddxY/6O5lVmFbAlZXLbffJLbSS0c5+5JyNYwXFQ0wFtDmlACn+3muN2O/kwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sejk28YMtACCyPk3uAoTWEPHyoKXM9bcsDGfgdF2SQo=;
 b=BpmXdKz0XIvSVZ8GqSdXDQs2455zL23OpKCIwLlr15wvkZ1QTlC65RXK7BrAo+LhgNrmKNbzwaY8SdkHfA2x0l7L0vx2wuU7HlVYjynQCbjLcByTdlC3134pNpdjteIbyYY4Qs/HP7YIEgqNvX8DRegfhhh8WLKELsqdu9eYtMs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5754.namprd12.prod.outlook.com (2603:10b6:208:391::20)
 by MN2PR12MB4304.namprd12.prod.outlook.com (2603:10b6:208:1d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 10:02:14 +0000
Received: from BL1PR12MB5754.namprd12.prod.outlook.com
 ([fe80::b080:4c1a:f6e5:4564]) by BL1PR12MB5754.namprd12.prod.outlook.com
 ([fe80::b080:4c1a:f6e5:4564%7]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 10:02:14 +0000
Message-ID: <294eb576-dcaf-45e2-bee5-558eaedc4a55@amd.com>
Date: Mon, 30 Mar 2026 15:32:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: add amd_iommu=relax_unity option for VFIO
 passthrough
To: Christos Longros <chris.longros@gmail.com>, Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 iommu@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260328213228.12084-1-chris.longros@gmail.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260328213228.12084-1-chris.longros@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0046.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:175::12) To BL1PR12MB5754.namprd12.prod.outlook.com
 (2603:10b6:208:391::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5754:EE_|MN2PR12MB4304:EE_
X-MS-Office365-Filtering-Correlation-Id: 415aa91b-3c83-4f44-2cd2-08de8e436abe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	j+i7TjSe0FqCAM88Z7J1WjUXRM2X+9kTFQ3Kysrk3IYRjbNocDkmoK7bZGh+4WSN2IgJn2vWrmHNkWz4z5fcVflYEiF4zSi8VOtDFg47xbYv5PVd7EuRjP+V652hRRxQBzIgQaHWEIZfWWnzKhVHvNB4v3HqqgkWWerKd6fCq7H6JJfn4xva7gzxFsoiY64hESLBjEkL2QrDsiJNAzEMmlKCIrxiD1zgft99CjS/xNErLA0SiHQ/zhd0uQnA/jN7iAHJsTaNi4IayM/TaV6rTRX6L7HQNna2Ymk1kS4IK1ChlzcT7wNcfO7Pogxr4niadSxH0WXa2xjdHphGlMDl7Z5/7UVpInAgzYtPLOl3wwaTOOm7np8wr/sx1JGIIWPUBrN2mv/q0ITNCFYAlumzXJhJOhfPZpYNuiPBQuYGIynw9m/kVBnoxQ1VCd3eRk5YzV/vHrr1CGCBUgzeVzS9RD0QdZwfXoN2HNUjrEAcVFj2wec1sgsO8hwnFO2JHhvgK+ms0ZreeD/K1V6cY7Ja+Gang0avJkoMSjhoGiVh4YkbyqD/X/TQHE8gFLDnjSCNvCdytxIIS4bMv/ONv10oQNZgZB+NCS4n3sABQzMBor+l8ibXHpbWJRIqZ6mrR+jQHRevBBKIMF2e750g1dYQ987Oybi6PtZSGXbjdD1eZUA0j8BNTQIjmL6r4/PnppDlvfVca6h7v/iToBYcXWbOKarN3JFTiKIFMhbMXOT0kws=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5754.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDdYV3Y3WEQ2LzdBaENFNWlBSjl3Z2svZCt1cW54c3I2STZMclFsNWEwMU1C?=
 =?utf-8?B?NTZiWHBodUwrT2lFa3FDeFRaZWkyV3MrMVhWa2JGN1loZmQrUHlTdEx3NzE0?=
 =?utf-8?B?YmJjdXVlWndPV2JuOVlFU3prYktwWnJ3NGJrV09tOC9XMmw0QUs1L29FMThm?=
 =?utf-8?B?UTZIbWxiZFVYdEFqNkNIY3Jaa2xnS1pIRXFXc1R6OXZ1enhFc0ZCVjJlc0FK?=
 =?utf-8?B?T251cVFDTkxCUFhyeWs5dGprS0pyTUI5L0pKTTJsSFovYWxRMlZQTXN6c3lN?=
 =?utf-8?B?aUExdVR4aml0ZmRWc2U2NmxndGRpa29EQk1tVEV4aFRQY0x0dUpGNzNacWxD?=
 =?utf-8?B?N2hLYlFXeUtvN1hjT3kxWFNYVU5SZGV1TnhEWmp2Vm44R1dsVHhVbTRvc1d2?=
 =?utf-8?B?YisrOHYzVkQzOGV3OTR2VFdTaWs4djN3bEpxdTdzNjlxdFhidmVvaVg4RVZO?=
 =?utf-8?B?N0pkZmY2TDc4bUEwbTJwamlhVFY3ZWptYlNoUllJOUxqVXhUREJZTHA5cGR6?=
 =?utf-8?B?YkR1L1N1cFo2aTg1WG9mUE5FOTRYWUV3SEt5akEzMmk1WmlhbUw2YllyTElz?=
 =?utf-8?B?aHBoVEJTM21LWVpkVy82QmsyR3ZLZE5BMVJzL0gyZ2FtNS9qZWhpT29iUmNu?=
 =?utf-8?B?V1VlSVJiRTlEdmEzMS9XWWRtbUFvcTBsNnlFMkYwMFEreTlxNXVETHBJYWxQ?=
 =?utf-8?B?Mmx6OXlaRWZXamszeEFhQ1hCa01UK0h6WS96Q1BjVWhCbGxFVE9nVllFZElM?=
 =?utf-8?B?OTBpLzR4c0N6WUxlN0tzcVJVMUNBRTZwNWhIMFV2Nm1aS0lSTElNT2hNS2kx?=
 =?utf-8?B?SFptTU04RlJFd2QrN3drOERpOGFpTm9VbDRySzliWjZ4bm5VSG43c2VGVG03?=
 =?utf-8?B?L0NFZmF1ZkVPLzlFV1VjSjlLWGZYNEgyUUlDcFJjS1MxN2FYNldzaHJwZWI1?=
 =?utf-8?B?alVReHhNY1NBSnFBaEFTNCtrUG9kZTN2L2E0cjdvOWJveFpiclkyS1N0emkr?=
 =?utf-8?B?clpkZ0FDVzFaS2JSZ0luQzR3YnZIRnNWNkdHUWJGaFowOTZNTGFkRlgrSnV1?=
 =?utf-8?B?OHdaTWdiUGpkNW5IRzlSR3pSeDFGZTdzSzJQaSs4UVo5MUFla2JKZk1VMTYr?=
 =?utf-8?B?WWlBRHpRWkJMMmh4eURwd1ZYSDNNR3gyOHA3cjBoMTZ1a0phVnZOR2E1ZFYr?=
 =?utf-8?B?TFZDMUMxbk8rdlYwMGYvQ211TE1qbEh5bnUwOWlhYXBZOGxBckdCUDRKYXUr?=
 =?utf-8?B?UDZsUXdQR3loTEdqendNWmZjK3lZMjhsOTZzd25ubW1sVnlpT2wrc2pqeVVq?=
 =?utf-8?B?aVRacWlWRTIwN0dNRkRXRXJ4L1I2dGZJZERpcXVkWHEwZm5ISmFSdjFlcExt?=
 =?utf-8?B?YTdzSW5MYVd1NWptK05MNFMrY1A5ellndDBPcVA3YUlvRFpXa2dSRXc2Y0hS?=
 =?utf-8?B?bWVYbmgrY3l4dnRJR2hXYWpuTDBPZkxER2R6UVJITzlTWXJlYnhZMzRGVTh0?=
 =?utf-8?B?ZG0zUFA4aEVTQ3l5d014aVBiUjhmcW9MRTNKOUlCQVBiTHRKR21URmt1RTdq?=
 =?utf-8?B?bFpTeGNMRFpaSllLV0V0T0IrSU9BYy9NZnYzSXc1aEZuL3FRUjhYbTZLT3du?=
 =?utf-8?B?aXFKMXN3WGs4dFRUZEVaQ3ZSZmwrakVjMmIwc1d1emUwWGtHaGJFTU1rZ1ZL?=
 =?utf-8?B?QjcrRWZNbXV5ZW9BaHZzdFFpNnc4WVZTQVVWYTZIL1FzZlRUQlcwZTFaanBF?=
 =?utf-8?B?bkRqYysxZUpIeGp3SXZ0Q0UvMzVKUHAzM3JRakJuZGFYeElRN3hCdDkzWG5k?=
 =?utf-8?B?QXZrRGhNWCt4Mit2R1RhOFo5dmRta3dqdyt1TkRaZnN0TUpUR0c4L3hmMVBa?=
 =?utf-8?B?RXFXMm5taVJaRmprUXk3VnJCYVY0cjZKN25Ua0REVEFWVVNPU1dJQXorb1dZ?=
 =?utf-8?B?YVZjVERTV2FJYWhHaHRMUE4zRXUyWUs3V09rSkhpcTlYYW1CN1FzK0h6c1hP?=
 =?utf-8?B?d3FsRlBadlJTUEFaNTd6bnFMQ1gxNGFsT0JaYjFuZHQyb0w1eHlxWXlJNnN5?=
 =?utf-8?B?eFYxc1JKYXN5Y2ZKRkEyaWh6K0xiZWtaNnVKdUQrVE9PNUlkeHZpNUJnRkdx?=
 =?utf-8?B?UFJNeXYrU0xNWHNLaHFlcUlqM3hvdk9LTVFyQ1ZSM1JuOGNreWwwZmZoTDVJ?=
 =?utf-8?B?YWhibm1xd1c5bnJJUFpBVmxQZjA1QjdCM3NlQ3pwWWgxRGt3MjhHQzlhRHJW?=
 =?utf-8?B?dGhUeVN6a1RpTjAzeW96STlXVHJoYS9HQ3A3dmwya1ZOeFRTcGVwQm9jcXlQ?=
 =?utf-8?B?UnZKTU5VT3I3MVZkTUlOSTE3MTJmYWROYkFHNUpTWVgzYWZDSTdFZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 415aa91b-3c83-4f44-2cd2-08de8e436abe
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 10:02:14.0430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oFgTiMnFSH2OQfXTmJAC2y/0kNrteIPMalPSpKJxRgWrkF71BxxmobrS5EjiuPAHmJAS3Bx2Hi2VL+30Dmpoqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4304

Hi Christos,


On 3/29/2026 3:02 AM, Christos Longros wrote:
> On some AMD motherboards (Gigabyte B650 Gaming X AX V2, X870E and
> others), VFIO passthrough of any PCI device fails with:
> 
>   "Firmware has requested this device have a 1:1 IOMMU mapping,
>    rejecting configuring the device without a 1:1 mapping."
> 
> These boards' IVRS tables include IVMD type 0x22 (range) entries
> spanning wide device ranges (e.g. devid 0x0000 to 0x0FFF, covering
> PCI buses 0-15).  The entries exist for platform devices like IOAPIC
> and HPET, but they get applied to nearly every IOMMU group on the
> system.  Since commit a48ce36e2786 ("iommu: Prevent RESV_DIRECT
> devices from blocking domains"), any device with IOMMU_RESV_DIRECT
> regions has require_direct=1 set, which prevents VFIO from claiming
> DMA ownership.

I don't have client system handy to verify. Do you have acpi dump?
I want to see IVMD flags are set.


> 
> No PCI device can be passed through on affected boards -- not just
> the platform devices that need the identity mappings, but also
> endpoint devices like network adapters and GPUs.
> 
> Intel handles a similar firmware over-specification with
> device_rmrr_is_relaxable(), which marks certain RMRR entries as
> IOMMU_RESV_DIRECT_RELAXABLE so VFIO can claim them.  AMD has no
> equivalent.

May be we can do similar for pci devices instead of command line option?

-Vasant

