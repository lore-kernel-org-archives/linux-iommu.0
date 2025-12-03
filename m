Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010062.outbound.protection.outlook.com [52.101.61.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5D42FD678
	for <iommu@lists.linux.dev>; Wed,  3 Dec 2025 15:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764776084; cv=fail; b=FbKmvhPyMMnesfkiz+BRTjfmONQj3nvfCPpbjctGOJ6zL1lJePtC5S9DVhw2Xjl/jvyY0xbzKN6I6VUcEjArxGrgDNUd1OOXFJeI7tpNdym7CPTPLEBFR7qFuc0BPIozj7BWwpCzGeYND1ya2+Rk8hfvMz6Zr1paI+HPsb0Zitc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764776084; c=relaxed/simple;
	bh=DJ+a1yK0gVd9LNMa03b0Dcw1Oo2hla/iju7NR8DOX6M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aVC0+SxmcmNGV27I/5Ap+lBa2PTeR5lH5zDx7coUa8get0/TYsUdwXzoIywaU3JaqkI7xD6qJaW5FIPopO6JJjjs9utXlD3VhEKRwzgy+KFxN9T8ol4UO+q/SHOnL6bAmN3V3F7e/QhhfNZjZnu8ctJNI3f+uDKoVP32UJct32E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VYHfUOSk; arc=fail smtp.client-ip=52.101.61.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VYHfUOSk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jm9Qfaje3RQpbpkJj1BiV6ewMCPhKcDa4utxnC9ToJlRSAIZkEgS0WHp6uBKwzs1zICVabsJ/h2BBlMRRMFV7I/2nHJAEizujouO6KB8JOM0AjNIICd3h59woz7JRSjmc3bYtK06icMZXK3dV92Bx4FJMrdxzxO/PEbJNCgqc8m+QP0ZpaKo/xbcaWmDQYUyhnYKbqnjnRN/PWkQqXswaQA7bB1rOBip4fOEH1vZcyiAMhpRSDBxwDrKBbnE38+SDhtdwhwoV4FpKKt4suBy5J1ijYzlJ7uS4EceM6RtNFrfhEJi7eqnUc3bbjb1yMLVSHl+DXPRf0PXZ76PcNek2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UB1SLBBEe4BFX4RJPy+CEqozmUR47KSJLO0hJOhYlio=;
 b=gx543dSCpWWkFE8JMLJ8brs30POhc73vRZvFJ3jGKWmNaRjHTDO8KOAz97GGaGA5vd7MI6k5UsY4JBkQKcd8dQTElmrc6xXVhLpARUTH6NPNgQc1cTm2VO+ZwXu/qalaYjDh44XYzMfCNDPNN43RDdg38Z3vBEkqrt8bD9fY13HvGiSkcyL3QPISnRZ1Wf97etaxpChKTK6M1ulqimiQAbP0j9cLIXfIDLhZoCYY3qUNInoWz4L4cdUx6duDstOotisqO85PsdEP3qp1S7gtAlpg5ajHBSOwzTxXTNn484W8JMlFGBDAUxA9PLmabYowbxEhASvd4V1ptkuu1AenVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UB1SLBBEe4BFX4RJPy+CEqozmUR47KSJLO0hJOhYlio=;
 b=VYHfUOSkJ8X9EX64b+FT74SgsgyzjF7j/TM5HBb9mt8ZXei8cJxTMs6lnFlifdbGf3KVceIC65wHmf5YcFfKKkV2PKax2VVOmYB2dSYjIoWqYSSg87tTY6Iy0QeaIceuVbtOjoGa4dJf1LtdGD9O6bUbjSEatMS/oZ4cxCSuqYUOQVFWRDSKDoEz+YSxpxYmCCCxiyz2hY27OO2bkuo6c/O/mFVNA/PmmgJ124GTL1U731VIZlMSOakjOxnMNfZ19dJGQ/UKEHXO+912f7sWge1C76V4wCNGrlMdBrIo3SFrMNAvpwXjG1gENnTV+6tOco6VJqOzrlD2wai4oagQYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by SJ2PR12MB9137.namprd12.prod.outlook.com (2603:10b6:a03:562::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 15:34:33 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%7]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 15:34:33 +0000
Message-ID: <515c552a-2013-4c7e-a0fc-c9a8c7d40d69@nvidia.com>
Date: Wed, 3 Dec 2025 15:34:26 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/3] iommu/arm-smmu-v3: Add device-tree support for
 CMDQV driver
To: Ashish Mhetre <amhetre@nvidia.com>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolinc@nvidia.com
Cc: thierry.reding@gmail.com, vdumpa@nvidia.com, jgg@ziepe.ca,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20251201163219.3237266-1-amhetre@nvidia.com>
 <20251201163219.3237266-2-amhetre@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251201163219.3237266-2-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0037.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::11) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|SJ2PR12MB9137:EE_
X-MS-Office365-Filtering-Correlation-Id: b9ec7744-7cb4-46c0-5fb9-08de32817503
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RitGMlJmSklMMnNqSDUvRjdNZjNLeXptcUMwREpBNXY5V2JabHhrdm1NSXA1?=
 =?utf-8?B?YXVjaFRxd21WMFNVTDBPd1BpV0FCZWJxY2VVZUpDQzc3QlRBZFdrRTZEMmhN?=
 =?utf-8?B?SGdLSDhYbGpJTWl3WTVteEsvbUZQdnl5SWRsV3UyMFJESVR3TjZtaDA3TVpI?=
 =?utf-8?B?Ynk1Tlp2K1JDVjlsa3c0N0tVQ1FYby90ZnZIWVo0R21QOXF0Q3c5VzU0QlVh?=
 =?utf-8?B?SmdDVTRMZFNVUndMdk5OY3U1eVBtRFArZWN2RDk4S1JPUHBDdlFaeTdySnhq?=
 =?utf-8?B?aDZiRlNCYm9Udi8xM0N1MjBjeDd2RFhxNEoyWkY5MG1McW1ob0Q4cit4VFpU?=
 =?utf-8?B?aElXZ0V0K0hZWGlieldvR1I0TTJYZENMb0JRTnYxS2g4SEhFb3VRd1h4ZEI2?=
 =?utf-8?B?L0daSHp3czR4ck5DWlhXRjJ3RmNnTzVqSTVLVFdlOVdOODg4ZDFuTDZ1Rkhv?=
 =?utf-8?B?eXNpZDRha3crOWZYK2hDUk5sMjloSVlaTXA4bENmS0JRUFNOUFRmeFBka3Rp?=
 =?utf-8?B?Rm5ySVR2bWlIaTBqZCtYU0pQUzFoUzdGWlYvZC83dVpaNk9aaXlFUFdWQzVS?=
 =?utf-8?B?UnQ5MktSVzIzcGNGby96cmRFV0hhMXAwVDE1SWZpQ2RjU05oNklBQmVISGRC?=
 =?utf-8?B?U0M5c24zYjlNcDdNR1BaQXVWUCtaSnJWUXI0ZUhqeGRBRU9yaUpVRXpqck8x?=
 =?utf-8?B?MElIcDQ1cFFpOGZlK29waVJxMFNhQVp2YUVTTzJlaytBLzdiemVsSHVDYVNo?=
 =?utf-8?B?TzF6cG5KWnVoWmh0OXh6b0RTREFqOGxRWHJSSmtsWFhhOWJCTzZ3Zzk0blBO?=
 =?utf-8?B?MFFHeks1L0tvTXBXWDdSaCtyZWxNY0pueEFKOUhFamRqL3cxUkY2cVlwZ295?=
 =?utf-8?B?bEJmYVNKcURrbnR5bjVWZVorVkVFNWYzeWtZU3VlbjFxdGh2bTlzT1lUYTdW?=
 =?utf-8?B?U2c1dDRDOWYxU0gyVUVZUjZNOCtJZWVEQzFYV2JHN3BuclJIWndXckR1YzY0?=
 =?utf-8?B?bGNyTnhEZWxUTlBmOXMxYnpXdzBDRzVlSCtTRDE0ME5FTDdoVUVYK3lTU2Rs?=
 =?utf-8?B?dnZkL2pSWTdtaGs2UXVEenRRN2F5bXNhcTFIUzRER1VBMUplNFlTTWJ3SGlj?=
 =?utf-8?B?YnM2U3l4Q0dTRXk1TGdwazlBd0toa1liM3EvcVZzODUwZEh5c2xTM1RvMzYv?=
 =?utf-8?B?cjF4U0FabUdTR1ZqOURDM2sxeE9LaGlWaTBoMTFDWFVsUU4wZkVlb2dHT3Y2?=
 =?utf-8?B?N0d5OTY3aU9qUVBLU0hGdlhsUUtOWlJWb2tLNVBpZU9sVEVrSFRsbGgzNlpX?=
 =?utf-8?B?ZDJFUE0rY0kyV0RxSGFvaUg5TjQzbjRRUW1seVRlN3BsWlBsMHpzcjBCMDQv?=
 =?utf-8?B?ZGVwTzd2bUNJczh0QnlTMDlIaGVtTld6T3ZsM0c3SVluelg4K3ZCdXMralhR?=
 =?utf-8?B?SUczY3dqVkw4N1lCK3B4QXRrS1lpZys4YVl3UldGZjFGZkRUOThQNXNra1lt?=
 =?utf-8?B?YnhNSEdmMnNDQnh3OGhvcjlyMFJ2T3lNaVdNVFZOMEpscWpxdUcyUGhiRERy?=
 =?utf-8?B?QUtWUUJTZ0kvOVBoMnhmSVB0QXo4Zm1rQXdwSHZNUWtCK3Q2ZjhLLzVSNExD?=
 =?utf-8?B?Wmxqd0l0RVFucTQzTEVlMWtZRk5JbGxBWVVZa1Z5T0tzQzVyWUpFdjJtd1JK?=
 =?utf-8?B?bzhYRlM2NUdIWnhReCtvQ09TaytzRFNkRWowWU9IV2I2ZUFEV0FuVWxiWFor?=
 =?utf-8?B?ZENVdkJUTXN3c2RQdkNYM3JZSWFJNmo5US9OS0dJeC8wMnlYby9SMm9LeGd3?=
 =?utf-8?B?bHpRZlhUUTZ2VHVzT0FibFJoeE55TUZrSmRWYlY5Q1Z1dUlWZ1BydmNCQVdS?=
 =?utf-8?B?R1BmV1ZxVTdvMklON3ZpQitZMTV5ZkhpMUZhMFBtK2FEd0ViUWxocE03YWNt?=
 =?utf-8?Q?QIjImOSOp67D1eG8ehDRXQg23ZiDBK92?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2RGTGp0SEg2dlgwZk5JYVh6M2E5TlZXYThCYTRibnBZUzVkR0h2OHRNL3lP?=
 =?utf-8?B?UkREVU83c1IybFdUN20xQVlGTU5EVnpqMEJsUkJVRHoxMEpyOGQ3aGNvNklz?=
 =?utf-8?B?N3dqRnZ1SlBYeE93bmRHc3JpWHhHL01QV1NYRkprSURJNS9wcVZFWlBGaUJj?=
 =?utf-8?B?bzRqUjlnTE5JeWZJN1I5a3h1RFd3MEJBVmI2dWwvTDBrdTcxaFgzZ2NucWRW?=
 =?utf-8?B?bEJ1M09mWTlpSnppaEpzNHNVSlB3Z0hSaVc1OVBwMExnVmVCQ2tQQm1KWEpE?=
 =?utf-8?B?VVBqd3oxQmxyNG14ZE5IZjZES3pOK3BKajV6TnVsa0hlUG94SWJyOUFtOU1t?=
 =?utf-8?B?MWR3ZENjUWkzOG5XNVNaK3lyUzBveGQxc1F2SmRuTktDRmRCeUVZbTh6cjlU?=
 =?utf-8?B?NmxmMEtwMnFlL0ZqcTRBcEJpaDIvM2xWVXE3ZVFyTU1oWlBDMXluYVpkLzNB?=
 =?utf-8?B?azI4TXpKZ0ViTkxBV0dKek1aRGQ3bElmRlNHQi9jT3BJSU94TmxjTmlrYVF5?=
 =?utf-8?B?SHRja2ZUZXdiRU53UmNSdmRYclVReEdsTGZFcmRXMTQ0UXZ6Y2hqbkVJNnAv?=
 =?utf-8?B?Q2JBZ2x2cXNPTFM2YURPd1BmOEtjMWNNWFhFUkUxbDFjdnBFYmxGOXVJUDhj?=
 =?utf-8?B?b1dXODlrRE1aSVBrOStTcXpaT1YwcFdSSEpva3ovUnBNSW1CU0Z3ZHRtMFIz?=
 =?utf-8?B?SUVyemdpZy9seXExeEdvYkYwcGY3WGhWSGdGUG1EUnB6T1ExcVNmN3piZWpo?=
 =?utf-8?B?bUxveklUUXJaUlRDNHNHeHpWSXBnSGlTZWkrTGxHN0EwV1duUHBXTVZ6U0NB?=
 =?utf-8?B?S2hKTkFtSUdhZkZ4d2MyTzdZa3B6WXpLRmxRYXNMSllIdGZVeEF0bHgrbHIx?=
 =?utf-8?B?VDFZK3k1UjdCNmFjeGU5S2lKaUNvVU1NWWRnVlU3MDRpVkhVZ3BoSGw5Q0JS?=
 =?utf-8?B?WU9nZUNKQkNITXN3ZU1wZHZQMDhlMXpPZlZ1blJQQk0yMFFwU1ZYYjloZ001?=
 =?utf-8?B?S0plM2dZTjk5bGk0QkRCckJBdHdwNlkzN0Q5b3N4Nzd0N2FnK3o5a0oyTXZr?=
 =?utf-8?B?dm1OVGpabzU3aFUwaHNITjIwUVhYVlo5endCNGFVNWRTS0dXUlY0anlXZUNV?=
 =?utf-8?B?UEIyczR4eHZWWWRXaTl6elpyTFQrU1ArSHJhZkVSc3d5d1NsMnZmbW85R3F6?=
 =?utf-8?B?d1crMUx3bzVmUHVwdzJmQzBrbGJWckF4TEZOeC9nNm5JUTlQS2FYUFFlQTZo?=
 =?utf-8?B?N2tHeHdHRmRUbmZUQnU4Q1pWOG4wRy91dG5pak1qdURKcjZvb2VwWjQ1S1Z2?=
 =?utf-8?B?blcyTkpFWmsrUHZuVlVCRHpjempDdk0yQTVjakgweEtCZDdJS1hkUkhtN2Zm?=
 =?utf-8?B?ZFl3VWloMHNpSUFzL1pYdmdJMm5LeGMyNmM4SDVjOFVjSktXTTNXb3poRjNa?=
 =?utf-8?B?Q1B3Q0hqeHlGUmlLdFRFYmZFcUJvbSt4cjdRNFNkQWV6eHpsNGZSdGlORDdY?=
 =?utf-8?B?alA0Z0JVWmVqMnJYdUFGdEFLWGI3UTBnMFNobzQyK0FLdHBscjhaNlE0LzVk?=
 =?utf-8?B?bG11WUFzUkFDdWVuVjhsK1U3QVBUWWZ0YWwvbUJ1eUE3Q3RyWExMUzViZjBo?=
 =?utf-8?B?Zlh0MHRvNmFUemdlSVRqVENQODA0RzZZbi85bjI4U0tJTG9BYmRDdmlpbzlw?=
 =?utf-8?B?Vk5PZCtUcURMeGYzbmsrL1FWZzJYcGN4U2ZiaDViQmJKTkJTcUlHbElpMWhm?=
 =?utf-8?B?dWg2R1VPMWNYVjlaUHRaODVHelJZMzljeHFaRmZUbFVMTzFReUJrZUtWYUY0?=
 =?utf-8?B?U21xdnVRQzhMQS9GSTVBcVlUUWJ6b1J6TExpQThEdVNxN0tKRVU2WUYzOU1P?=
 =?utf-8?B?Z3J1RTJjS0NEbjBHdVEwTXFmOElVWGxkVk1TZEs3U3Axb0RYSVFuZlZseXVU?=
 =?utf-8?B?NTF3TUZPSjNwallxOHEyZzBXcisvait4RzFXb3JTc2pvUnFzOTV1SktGWmI3?=
 =?utf-8?B?TzRGZUFRMzIvTDlnQ2QyR01lbUhCc0J3SnlETHFUWXdjaFpxbENybDY0NW1T?=
 =?utf-8?B?dnZkV3lhVzBzTWFQSkQzek9kVU9GbTlWN05EeXdhaEJ5RnR5aVZzS3ZIcHJ1?=
 =?utf-8?B?OWpIWmY2dkJsVElzSk9iNEtmRDgvZnlGVlRZR2lhRWZ1MjFjbTg2ekNzZlJx?=
 =?utf-8?Q?2etP15hQu8OeaQG/cRRGlTm4k7T1UCeCVNamuDvstHI9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ec7744-7cb4-46c0-5fb9-08de32817503
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 15:34:33.1343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9u0zb5s1yS9ly9JQ5ufq4FGpySOlL+mgWPWiMYVsVX6N1Jw6pq9IvDJrpHOSSS4de/UAvXd9K05/8QYLkvuVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9137


On 01/12/2025 16:32, Ashish Mhetre wrote:
> Add device tree support to the CMDQV driver to enable usage on Tegra264
> SoCs. The implementation parses the nvidia,cmdqv phandle from the SMMU
> device tree node to associate each SMMU with its corresponding CMDQV
> instance based on compatible string.
> 
> Remove the dependency from Kconfig as the driver now supports both ACPI
> and device tree initialization through conditional compilation and
> ARM_SMMU_V3 depends on ARM64 which implies at least OF.
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>   drivers/iommu/arm/Kconfig                     |  1 -
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 32 ++++++++++++++
>   .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 43 ++++++++++++++++++-
>   3 files changed, 74 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm/Kconfig b/drivers/iommu/arm/Kconfig
> index ef42bbe07dbe..5fac08b89dee 100644
> --- a/drivers/iommu/arm/Kconfig
> +++ b/drivers/iommu/arm/Kconfig
> @@ -121,7 +121,6 @@ config ARM_SMMU_V3_KUNIT_TEST
>   
>   config TEGRA241_CMDQV
>   	bool "NVIDIA Tegra241 CMDQ-V extension support for ARM SMMUv3"
> -	depends on ACPI
>   	help
>   	  Support for NVIDIA CMDQ-Virtualization extension for ARM SMMUv3. The
>   	  CMDQ-V extension is similar to v3.3 ECMDQ for multi command queues
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index a33fbd12a0dd..206dffabc9c0 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -4530,6 +4530,35 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>   	return 0;
>   }
>   
> +#ifdef CONFIG_TEGRA241_CMDQV
> +static void tegra_cmdqv_dt_probe(struct device_node *smmu_node,
> +				 struct arm_smmu_device *smmu)
> +{
> +	struct platform_device *pdev;
> +	struct device_node *np;
> +
> +	np = of_parse_phandle(smmu_node, "nvidia,cmdqv", 0);
> +	if (!np)
> +		return;
> +
> +	pdev = of_find_device_by_node(np);
> +	of_node_put(np);
> +	if (!pdev)
> +		return;
> +
> +	smmu->impl_dev = &pdev->dev;
> +	smmu->options |= ARM_SMMU_OPT_TEGRA241_CMDQV;
> +	dev_info(smmu->dev, "found companion CMDQV device: %s\n",
> +		 dev_name(smmu->impl_dev));
> +	put_device(&pdev->dev);
> +}
> +#else
> +static void tegra_cmdqv_dt_probe(struct device_node *smmu_node,
> +				 struct arm_smmu_device *smmu)
> +{
> +}
> +#endif
> +
>   #ifdef CONFIG_ACPI
>   #ifdef CONFIG_TEGRA241_CMDQV
>   static void acpi_smmu_dsdt_probe_tegra241_cmdqv(struct acpi_iort_node *node,
> @@ -4634,6 +4663,9 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
>   	if (of_dma_is_coherent(dev->of_node))
>   		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
>   
> +	if (of_device_is_compatible(dev->of_node, "nvidia,tegra264-smmu"))
> +		tegra_cmdqv_dt_probe(dev->of_node, smmu);
> +
>   	return ret;
>   }
>   
> diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> index 378104cd395e..2608bf6518b4 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> @@ -11,6 +11,8 @@
>   #include <linux/iommufd.h>
>   #include <linux/iopoll.h>
>   #include <uapi/linux/iommufd.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
>   
>   #include <acpi/acpixf.h>
>   
> @@ -917,6 +919,26 @@ tegra241_cmdqv_find_acpi_resource(struct device *dev, int *irq)
>   	return res;
>   }
>   
> +static struct resource *
> +tegra241_cmdqv_find_dt_resource(struct device *dev, int *irq)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct resource *res;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(dev, "no memory resource found for CMDQV\n");
> +		return NULL;
> +	}
> +
> +	if (irq)
> +		*irq = platform_get_irq_optional(pdev, 0);
> +	if (!irq || *irq <= 0)
> +		dev_warn(dev, "no interrupt. errors will not be reported\n");
> +
> +	return res;
> +}
> +
>   static int tegra241_cmdqv_init_structures(struct arm_smmu_device *smmu)
>   {
>   	struct tegra241_cmdqv *cmdqv =
> @@ -1048,11 +1070,14 @@ struct arm_smmu_device *tegra241_cmdqv_probe(struct arm_smmu_device *smmu)
>   
>   	if (!smmu->dev->of_node)
>   		res = tegra241_cmdqv_find_acpi_resource(smmu->impl_dev, &irq);
> +	else
> +		res = tegra241_cmdqv_find_dt_resource(smmu->impl_dev, &irq);
>   	if (!res)
>   		goto out_fallback;
>   
>   	new_smmu = __tegra241_cmdqv_probe(smmu, res, irq);
> -	kfree(res);
> +	if (!smmu->dev->of_node)
> +		kfree(res);
>   
>   	if (new_smmu)
>   		return new_smmu;
> @@ -1346,4 +1371,20 @@ tegra241_cmdqv_init_vintf_user(struct arm_vsmmu *vsmmu,
>   	return ret;
>   }
>   
> +static const struct of_device_id tegra241_cmdqv_of_match[] = {
> +	{ .compatible = "nvidia,tegra264-cmdqv" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, tegra241_cmdqv_of_match);
> +
> +static struct platform_driver tegra241_cmdqv_driver = {
> +	.driver = {
> +		.name = "tegra241-cmdqv",
> +		.of_match_table = tegra241_cmdqv_of_match,
> +	},
> +};
> +module_platform_driver(tegra241_cmdqv_driver);

This part looks a bit weird, because it appears to do nothing. The 
compatible string is not used at all in the driver AFAICT. Have you 
tried this bit out because this is not a proper driver?

Jon

-- 
nvpublic

