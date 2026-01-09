Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012038.outbound.protection.outlook.com [40.93.195.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FDC33291A
	for <iommu@lists.linux.dev>; Fri,  9 Jan 2026 09:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767951914; cv=fail; b=oNXaCqrbU5S0MbIkRkjA3FkS7xe7kyaGML9EGFJWYftyAqu+SqpdWO7EfRSd4PFU5hn6lvXEKDPYV7pjXQJU4vehXWgoW0th3j+NmrgFHFeamBGS/WmgOgD2b1aHXa+NJR8tDQQAi5A5V7tbnWZizjyZ6vTCRO0sHXXDycy5UEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767951914; c=relaxed/simple;
	bh=E8+jBzKDT5Go1Hw1dNaD2+V6r+ncW6dZjX1YyG0Vl30=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kamIdNxpVg1T2Om9Q5887AQo1jtCZs61JlkzW8U8+fjAORuBi/ypMAzYOqCCry64Q9YgHStMUNxs5X2XjbhCNpunGf6TWKrOd7wAErmBA2/WasWrZY33sfJYLxOri+3yRULREbIDI4jayBUNVSjFeAkRkW5JXncCTVbcqbg665k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HdW4Z52z; arc=fail smtp.client-ip=40.93.195.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HdW4Z52z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xnn2ATF8D4/8HYTaIt5ELr2NEr3pbJ8mJmXK7ZEgc4ni85JqzbjXJD5a9leoO/T6a8Hl5YLzYlwVg1GTwBsnhsaWsgM+QW2nJthk8hUTNjj+LYH9rNCYkPT3+m81IPrslVaiONL85Ytvhz7Xy3IDW0iM9vbM6irCaqPCLQoC65GJeETETG7p096gvRw90W0dREKbjSg8TkIZVaJGHuVnbQJs2gqNlTwcjV3a73sIRXW3+/VhM2AWwEs44EJmuougNk+0SHSoKHbLfl2nWoHyIDGpdlRubp61H9KZPjF7K5XL8T0Ulfyfb8No7EuKhVwRxdrqI/6OD5UAouhUgayH8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJ1wm3jn41KNtM+aUWvPnVsSr2zZaoAKh8+/UoyOxvU=;
 b=cP78lFCKLplgDjDf/2pxB/qYcnSbGiPURZixIOPOxjI06SLRtVFQ3cv97+Vwj4eMac5EgixfaLmphIuUkgtvpkfdPde50mF9WLNCC51GZDV8BFF40+oqPZtHPzqsBK//X/lyBsA5SMAUzeUKLb2h5TPyvrmqBMfVobHD/3OttMJgdLF5iuCX8igCIpPQCbHmGeQQyl3W/GGRrFs3CchngtJ1QRmGKICLevBU0cu+Qv+HQMtnneG5RILqhVHDnGz83euOPbvO3MkWJDTj/5WX5bMJQ89WzBZq9ZcZzSoadytkskVTor6bbxrxyPI3DGJ82cTv3b1JGHCv6k7V+H6hTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJ1wm3jn41KNtM+aUWvPnVsSr2zZaoAKh8+/UoyOxvU=;
 b=HdW4Z52zY4Y07RBorcZutEaJEusmzaLiOrnuG3rTXoGVJZQ7e41jCyRVJOhxbQat7CduyXjHpimJiVsBVdPW5WXh25uYRy0iFWJLJRSpuzP3xEML+bmScdznzXKZRWnWqaTXAm4PiQF2VVa6vZwMmgipTzkyMw6tOB4dSmgyGWwM4fcmvptvlWubKiQ6Wo6R+QaiL7JY0L0CWnxFKepGzOeeYy7Em2GSqTWpJnYE80/FaBH9wbWF1Q7P5hNeKmks53QVoxO1rHSWgFV09MAW8DDa2yg3aVcf8lTDBK2RbPddgH+0PNm2e6xCI6y8QSIWwtmTpdh9MnOtQLEYdrW7AQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by CY8PR12MB8242.namprd12.prod.outlook.com (2603:10b6:930:77::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Fri, 9 Jan
 2026 09:45:09 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%7]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 09:45:09 +0000
Message-ID: <1a224921-1e67-4699-a91d-89930db6147f@nvidia.com>
Date: Fri, 9 Jan 2026 09:45:02 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 2/4] iommu/arm-smmu-v3: Add device-tree support for
 CMDQV driver
To: Ashish Mhetre <amhetre@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, thierry.reding@gmail.com,
 vdumpa@nvidia.com, jgg@ziepe.ca, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20251215064819.3345361-1-amhetre@nvidia.com>
 <20251215064819.3345361-3-amhetre@nvidia.com>
 <23df682e-6d08-4827-994e-1bbd89e5c903@nvidia.com>
 <5e9a0ce1-a0ba-4a31-be95-99f349ec6028@nvidia.com>
 <e7d3e95f-a885-4b13-ab4d-bc82793c5396@nvidia.com>
 <aUROk0jRQoLmBRo3@Asurada-Nvidia>
 <b2df8ce6-d336-457a-8169-f2eccec3c12e@nvidia.com>
 <aUWeUapsFo3KZP7i@Asurada-Nvidia>
 <69e11fa5-558f-4fbd-ab3e-e8f3b8197df6@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <69e11fa5-558f-4fbd-ab3e-e8f3b8197df6@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0421.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::12) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|CY8PR12MB8242:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a00afff-1fff-4095-bf16-08de4f63c6fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUpQZmY1WDQvTWlYYm4zSGF3VlZ5ZVlPZEtSRWd4c3FXVkh4WFY0aEJDRDFw?=
 =?utf-8?B?MkYvTUVmSjdxT014MVE3YnpxMTZGeGN0VkhLZ25TaFRvWFBVT1JiNFRHWkc3?=
 =?utf-8?B?amdkYWl1RkRwSEdQMkk5SDRkSVlkVm9WL3gvNGg1NGd1WWFJVm5VTzJOVEt1?=
 =?utf-8?B?VjMxeDFxVlFrS0lSMjVEc3psVXhkTTdGTVZMdDVwNERjeWU3bmJkWFVUdmxU?=
 =?utf-8?B?dzV5Njdua0c5bHRQd21FdEdVMTFKUzJHelNJbmR1UkJEYk1vUENzTFBhaTRW?=
 =?utf-8?B?ZHBiQW54cDlxcjV6VEQ4MlRQcmpZOXc3MUlESzBnRjNGYXBnN05BdGVVelVM?=
 =?utf-8?B?RGI4QVNOdVBxU0U3ekR0R1ZJZU1CMFZjU21HYzBxc3NiMFVsbXVjaHNTUmkx?=
 =?utf-8?B?NjgvU2dJYU8zdWVXRWgwejFROXM0dWpURy9PWVRaYU1XbGNaOUQ4Y29Gb0F4?=
 =?utf-8?B?VDhnN2tyNWFJVDR0RFhYbmtQQldnN3ppY1JOTHZDZCtGU2JLV3ZFejRUM1E4?=
 =?utf-8?B?QWQ4L2JOL3ArRlphb2NwYlRWczhYdlNBZTZFYlJGNUhqT2VhRWdIYzl1VzB4?=
 =?utf-8?B?NXdYN1psdnBveEtiK3pSVE5FbVdtUFdPM2pxSkd4bmkzRlhVT1B5cWRXcjJH?=
 =?utf-8?B?enFmc3FtZDZvdGJxdXJUQzhBSEJMdkNGRjhVaUp0Njd6a1JBbnVjMXRNMHRM?=
 =?utf-8?B?aDNsMk9ZZDc5VTlEM1BRREtraStza3V3QkwxWjUydENrQTVJZUY4ampJNGk0?=
 =?utf-8?B?SmcrRSs3aHdvTVlqTHQ5YU9sNEU2NTZ1YlppVGNLNXBGRkx4VzNYWXhQc3Y2?=
 =?utf-8?B?b0MwYU5GZzhmYndyR1ZUM0VGNHBLRUk2blNPOWZuNG1NY3M1dG5udmFIVUNM?=
 =?utf-8?B?RjZwdStZRWphSmFOQmlKSVlRbm9UYW1QM09nVldMSDVSdnpGbndSZC9uSFZn?=
 =?utf-8?B?Q1c3Z2kydWNBS2xCaGhDQXJONWhRN2VrVTZwZS92NTYza0tCcUZLZmtHbTVQ?=
 =?utf-8?B?a21taTZDckUwZ2MvYVVaTWFReDkyYVZhbkhQMFhpTWpaN2tVTENlUFR5TjNF?=
 =?utf-8?B?V3FLSzVKM1Q1NG94dmRhMEl3c0tpbWF4MFdoYW5DcDBOWGRhYWNqOEtiam5u?=
 =?utf-8?B?cDlPeWhQMU85TDdCdnZtTC9SbWpoVjFIaTJsSElLVmFhaGdQM2lzK1dYb3Rj?=
 =?utf-8?B?b2NRWWVOaDd0ZTBxNjhldnp2SXFGSlNZVFhVbTBHRnYyTDZoMlNveldSWUc2?=
 =?utf-8?B?UzFsbEV1RldMYjgrcHRlQ2RNRWtCeVJ4aTZsZXp1ZUJUdWJQRTFJaGpycVV4?=
 =?utf-8?B?SWdiSzNab0QxeXQzZ3lrVmJFclVzWFNjY2tYSElaT3p5MWdmMUJCN1ZrRjhy?=
 =?utf-8?B?MWlyVTk2OFRiaHRGN0RVMDArSDVIdXB6M3Z6UlFjVm1VWTcrakIwRVRJRjVR?=
 =?utf-8?B?MGZYTmlGM2VnQmkrYmttZXU2dEx1Zm8wdndMQW15Ym8rdXdmMzFMWlEvWDRC?=
 =?utf-8?B?d2czU0RmWi9lYlp6ZXJIeDhUYmFHYWlsTm9YM1kxaHdFclcyWEZxMlJyNnFk?=
 =?utf-8?B?YnVhQWtmNEkvbW1EUFUxN3RlQ3paZXdHUWh0RERLaHE4VEZJV09FZVdUbjJN?=
 =?utf-8?B?WTR1dmJ4WDhHUm9SNEd4Q0RDNk5kUHlkQXZWbGg1WThPNGh4dmJjalM3dnFG?=
 =?utf-8?B?NWN4YTNCelpwenRaRlRja0U2cG9TRXlFZVJTNGdNQkZnNWl0Z1pCTStKUzQw?=
 =?utf-8?B?cVgwY1BvdVNWKzIzaCtLNXREY1U4ZVhSak1GOFZ6dUpEUk5sb0FzMHpBbEpD?=
 =?utf-8?B?V0xzTmd5M0oyd2YzSlJsSldjSHhuam15RC91RnhiMWp6Zk9NVVpLVWlaem5j?=
 =?utf-8?B?dUdPZ0toVXE2TnlRMWdRV0VFdUJwa0swUVR6cEFCd1JVa3hXaFhQUFBSN1o1?=
 =?utf-8?Q?nAryqEpgZhQn+qp3PV5D/xpYuOyQTshQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QldLSnp1bzBmazVyeHNuMXMraGEvQmZKeE5wMVowZ3ZtcGhmVVRMaW1qMVgw?=
 =?utf-8?B?UXdHSURLOW5uTWx5YUFUclJUTnJ3L3dSTzFOTkhkekppTGJxYVcvN2R2L0x0?=
 =?utf-8?B?amN6ZDQydWx1bzQ1ZjJmUW1qTnFicGhSaDdralJkRHV3b3pMc3FWS0ZGb0ow?=
 =?utf-8?B?dlpXTk9kZXN1NnBDNlRzYmdaS29FWmE4UUFyMmllWjNCZkpWb2lTUE9vQWZ1?=
 =?utf-8?B?QkhyVnRqTGZ2dzI3TDJ2aTY1MjY5TGg3cndIM1NSWDIwL1hDcW1URFpqNSsy?=
 =?utf-8?B?Si9xYmNJQStrQUtGVi9keDBnN2s5aVI4dVhnZDFwdTJCUnJVSVFvemdLU29q?=
 =?utf-8?B?aUdzeE9iNnJYWFZFb2YzWlpLd3A1Kzg1ZERWTGtqeDF5YWROV3Z0cEtwUy8w?=
 =?utf-8?B?VlpLTkpwSUtCTGk1R0lmZE9CQkNidmIxYVhIL0xXc1RNYUpkQnNyckwrQkJV?=
 =?utf-8?B?RXFYMlpHS0ZqSk84SnNPaG5NMW9TMURDTlY3Mk9HbEcwTHdCN2x3NXZRd3Qz?=
 =?utf-8?B?b3RuL1l5SDV6cHBwOTlDKy9CRE5zU1ZkVll0YU0vR3o5VGQ1SHBiZmhpWVJ6?=
 =?utf-8?B?NGRLSHQzZDNIV1N0Nkt3ZFpkS1E3bXBqSnR2YlVhblF0Q2dvaUY3bmpSbFEv?=
 =?utf-8?B?M1QrYUdraHoxV01ycEJyNzJZRFU5NjRyQlNXc1FsVjVkYmY0VnppbmFQRHhz?=
 =?utf-8?B?NmVnOEJYZzVidjNBM0ZxRXlWS3QzTEkxMkxldDZ5RVRXZ05QNmtGWTliVGQx?=
 =?utf-8?B?WU1tMFFTUjlZUjlzdjRlbUphMWtBM1NiMTVkWkRhMW0wRElRWHg4SW1YVDl1?=
 =?utf-8?B?dUtLanZwRDl0SVVvT0FvNU8zQ1NZOTU4UEdKSzZtZjBObEQzNTY3MVdRUHJn?=
 =?utf-8?B?bW9yZGdvT2JCN3QyNExtQll1NGV3Y0FIODFiMXhOejlkUUZNNVJ4TVdrR0Fa?=
 =?utf-8?B?cHoyTTJBc0R0eGc0VTc5azl0NXNmSkttbW9uQjZkYmptUEY5bzF6VWZpaUJ1?=
 =?utf-8?B?SEI2K3pTY09nZUhPeDZCU3lsZVJlanBXSWRQaGo1SnBaTm1GY2FJSGFIYm00?=
 =?utf-8?B?K0NaeEZsNHVSVUVvNG5tN3M0NitZZEdGQWVrTFovYnhhaDA0bkNBV3pXcmx1?=
 =?utf-8?B?R3VCYzBiTXZCTWs3aGhFMkNpWUNUaHFUejduYnFBUzhnUDM1Yzg5QlFQcnJw?=
 =?utf-8?B?d2tOLzFUSjZrZmVubWxrb21jU29adWhxa1FDeDJuMkhJa0JPU01OQjl6bVV6?=
 =?utf-8?B?Mk00L1lUdDVUYjYvMVhDUkc2ZTREV0dPUHNmVmw3WUVKQldDOU1SemZlNHlG?=
 =?utf-8?B?UlhKRUkzYzVMQ2Fsc1VYZTF0b3pMdkEvdzNWVmJYcEliRVROMUdNdis1R3Aw?=
 =?utf-8?B?azRSZE8yZUhCbFB5Q0svY3I0YnlrdXdIK0diMFE5NzJSZG9PSnZkbEU5VG5L?=
 =?utf-8?B?eU5UMkpVaDdkTm5yUlNSQ052cVZaNVQ0K1NtZHZVUjhQcW5jUjFhVjBmaUVx?=
 =?utf-8?B?R0V1VTdsdzJuMjlINkRDU3M1WW5EZnVBWGhUdHhlTVRZaDRnazdDMWVhdkZl?=
 =?utf-8?B?S1g0K0lqSGpwdUUwclkrZjFUT3Ard3ZqZCtublNzYVVxakpkRFZhd3BoTllu?=
 =?utf-8?B?TXBvT0xqWXJQTzljUTBQYXZVUTFtZC81UW1RS0QvcWxtSjdRbjBaQkV4TFdm?=
 =?utf-8?B?MHZhNHp0RThqUFJNUDNSNGZoTEVkaVlTd2kzK1U2UjFhNGZFVWdVYWZYYi9o?=
 =?utf-8?B?cDQ2bGdjZG16VXhFVmdDc1VtbTZjaXBINnhtUUdVY01hN2JNN0ZuTDA1UnZD?=
 =?utf-8?B?Y0dHb3lBUmVmclNISzlKd2QxYm9mcmkweGNna0lJVkFzQjE0TlFjVWRoWnpz?=
 =?utf-8?B?S1l2K2lKZjNWUTduNU8wcjJtTWNtaG41a09TVElGMWdYQ2FHd1JQN0EzOXgw?=
 =?utf-8?B?ejh1SmJXVGVrZFVRMWUyM3BCZ0R0c3B2T3g0d3RVT3RBU0NvQ0RUY0RTL3BX?=
 =?utf-8?B?NUFXSExVOE14TGRZR1JZQ21EZVNQLzZCeG1JS1pObG5rOXhJbXM4VVNvNWZZ?=
 =?utf-8?B?bzAzMFpBS1BnaENZaWFLRjNpbFVEcXc3NTU3MFFtWDIzR0lMSWNzSHBBY0Zm?=
 =?utf-8?B?L3Zpb2dWYjBFN3IyNlZuNFhXdHZ6WTJPY2FpZmxQSXJ0OSthMjJVbGhoYWcv?=
 =?utf-8?B?WUd3WkpPNnBla1NzbkhVcFVMZnJKaFUyRm1aZlZMblNZT0I4VFErbEdhbmdI?=
 =?utf-8?B?VCsyMHRoNkZiTDBFc2VyRnpZWmFxd1g0d1NuT3p3OHRETkluSWxQYmNWdXc0?=
 =?utf-8?B?SDJPQU5JbWxyTUpxajd5eFJXNWJjL3ZvOFU4VllYRnpTc3Z6ekExSmRqZTBm?=
 =?utf-8?Q?FcRP9p9vA3TEvXySHKeCBWCKU4LROULmt3oCy5KBBY+WP?=
X-MS-Exchange-AntiSpam-MessageData-1: pe7vH72529iwFQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a00afff-1fff-4095-bf16-08de4f63c6fb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 09:45:09.2967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xETnc9AkIofNQe9Vv2UVAGR4jmPHejyKqdX3u6pl2lDtr/N+dTC4Pc0NTjACwtIyk9Ntu4Bv8GezObUVWlBIGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8242


On 07/01/2026 06:44, Ashish Mhetre wrote:
> 
> 
> On 12/20/2025 12:19 AM, Nicolin Chen wrote:
>> On Fri, Dec 19, 2025 at 10:48:22AM +0000, Jon Hunter wrote:
>>> On 18/12/2025 18:57, Nicolin Chen wrote:
>>>> On Thu, Dec 18, 2025 at 08:48:32AM +0000, Jon Hunter wrote:
>>>>> On 18/12/2025 06:32, Ashish Mhetre wrote:
>>>>>> On 12/18/2025 2:13 AM, Jon Hunter wrote:
>>>>>>>> +    smmu->impl_dev = &pdev->dev;
>>>>>>>> +    smmu->options |= ARM_SMMU_OPT_TEGRA241_CMDQV;
>>>>>>>> +    dev_info(smmu->dev, "found companion CMDQV device: %s\n",
>>>>>>>> +         dev_name(smmu->impl_dev));
>>>>>>> This seems a bit noisy. dev_dbg?
>>>>>>>
>>>>>> This info print is similar to what is there in ACPI path as well.
>>>>>> It's only a single print per SMMU at boot time. Should I still change
>>>>>> it to dev_dbg?
>>>>> Yes, I would.
>>>> It's really not that bad IMHO, I am not against that though..
>>>>
>>>> If we have to change that, we'd need another patch changing the
>>>> one in the ACPI path as well to keep things aligned.
>>> Regardless of what is already present, does not mean we need add more 
>>> prints
>>> to just say everything is OK.
>> This is how it looks like for each instance probe():
>>
>> [    2.709269] arm-smmu-v3 arm-smmu-v3.10.auto: found companion CMDQV 
>> device: NVDA200C:00
>> [    2.709273] arm-smmu-v3 arm-smmu-v3.10.auto: option mask 0x10
>> [    2.709618] arm-smmu-v3 arm-smmu-v3.10.auto: ias 48-bit, oas 48-bit 
>> (features 0x001e1fbf)
>> [    2.716236] arm-smmu-v3 arm-smmu-v3.10.auto: allocated 524288 
>> entries for cmdq
>> [    2.719432] arm-smmu-v3 arm-smmu-v3.10.auto: allocated 524288 
>> entries for evtq
>> [    2.725898] arm-smmu-v3 arm-smmu-v3.10.auto: allocated 524288 
>> entries for priq
>> [    2.736051] arm-smmu-v3 arm-smmu-v3.10.auto: allocated 524288 
>> entries for vcmdq0
>> [    2.742553] arm-smmu-v3 arm-smmu-v3.10.auto: allocated 524288 
>> entries for vcmdq1
>> [    2.742586] arm-smmu-v3 arm-smmu-v3.10.auto: msi_domain absent - 
>> falling back to wired irqs
>> [    2.742759] arm-smmu-v3 arm-smmu-v3.10.auto: no priq irq - PRI will 
>> be broken
>>
>> On a second thought: The CMDQV device has a very unclear naming in
>> ACPI path: "NVDA200C:00". So, printing it gives us a hint for any
>> later warning/error tagged with "NVDA200C:00".
>>
>> Now, for DT, it might be okay to not print it. But making the two
>> paths asymmetric feels odd. So, is it really worth nitpicking here
>> given that each SMMU already prints quite a few lines on probe()?
>>
>> Nicolin
> 
> Hi Jon, Nic,
> 
> Shall I keep this print or send a new version removing it?

Make it dev_dbg() and you can always enable it if you want it. 99.9% of 
the time you will not need this.

Thanks!
Jon

-- 
nvpublic

