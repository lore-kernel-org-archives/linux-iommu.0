Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9940224A054
	for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 12:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752497661; cv=fail; b=Zm9KTEB6rmGsX2IVRyESofhA+bkyG+KUefZZYSnGJRPO4YI8vXBgpuQoxdD90mnuirIxuf6HCrExcTXpJI+L1LFDq1XYNrBqQc9rF/ALhlJPUvgvIPqrtaTvtWoT4GvCAiDqgKq7ioZ4hf8/iqk2HOO8fn6i/HEduT3gCeMiofI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752497661; c=relaxed/simple;
	bh=NfUYLpOd83aoLV4bRkJOV5j6zsmfUgZoJaPFP8RdflA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A70xmJPjo/0+cpDc5uFs2uB66R/dqSOXJFFdF7JWf8PmbECdcgYvEjkI9XRCUS4p4cGlkEplZFgioNof3K0k3oSf5LEbaoGUPPSlXqJrThnzHHh2HbuuH5SdQQrszb4mgIeZymghSMlYvi9LM5w6n25jhVGt9/9yA7BZuR6TDnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B8htI7zx; arc=fail smtp.client-ip=40.107.223.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B8htI7zx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KIMsBmpmpeRl1kQIlM7z2AYE2o3+XPLrDWWUAhJXOXW/2GByvUY3OQt82CCecRvhi/Y+sHKABXe45GnpBcS2xV2nS9Q6Kwszbq/IVLYi0mMzYO60tzUTM93UM2DAeulxjBigIhvckvkL2sE5mjXeSuSFNFEyjWNCikD/+vjNpXwyO1omDTfplF1ZtFhNStonpyMLc8s1uC/otNumIJWt04zPCN4UfHqPFYCQ3J2RJJFaUy5x04FhCUiLmp4BJI/6HSY3JHcSydRICUOee41xry4WJWRyrDQ6JfsmHBPVWLP4jxomTJ3cP3w/wNkeyP+AXZTlaSi+vDFqwvZ2xe0J1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJ01h1vfpB2I2Srb/7vKrWaocCJD8Ggf9tKU1fA0TlQ=;
 b=oe1Od+pNSzvedZmg+I71HleyZHN/AqYfSpow75e1qIJ7CTCS/6kDqnB7HQ7bFQGgc8UWyXIMOb3novctPLbsu8NsMkUQuJrAcT/CQNJGhllcL60zFtSrvf5h4piNh/99Zh4coQ0GOAXhWctXbACfHMnvex2uly8kmZlHJDZWytZkxIpkOugJ531+yjqEr7SFV7sOGmtg1rJCA2Vq3dk6hwPcilIb/ubriPtGAQ2W1VH0MQn2ZSNNA6CEe3KoDXAhTamldiLbFpCaWGC1RuWUdy+K1/RXfMDsxp+cA4/CLQ+XiJ+91k/xd7fmg3T2cVsa111j2qJul0RTOFHq9odqow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJ01h1vfpB2I2Srb/7vKrWaocCJD8Ggf9tKU1fA0TlQ=;
 b=B8htI7zxy5mu5eO+TdHx4uX8pcrnieW9zpXxQG2PB5Mb/FvatccJWa6+t3zSIkgpfRbKmcrt6QX9zrl3NjMgOntiK/sT3Kunx2PbZOXQ1xj54NGLZZL8NbkT7GAzgVzQ6ONQhqteBQEc3EnKa/+O0plpFKZp3pZTGylkPSgAMXc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 BY5PR12MB4243.namprd12.prod.outlook.com (2603:10b6:a03:20f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 12:54:13 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8901.018; Mon, 14 Jul 2025
 12:54:13 +0000
Message-ID: <a75aaf31-43e2-4a48-b323-0322f24c3b0c@amd.com>
Date: Mon, 14 Jul 2025 18:24:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/8] Introduce debugfs support in IOMMU
To: Will Deacon <will@kernel.org>,
 Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>,
 suravee.suthikulpanit@amd.com
Cc: joro@8bytes.org, robin.murphy@arm.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <20250702093804.849-1-dheerajkumar.srivastava@amd.com>
 <aHT1YeC30-ZiyS8p@willie-the-truck>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <aHT1YeC30-ZiyS8p@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0092.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:268::17) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|BY5PR12MB4243:EE_
X-MS-Office365-Filtering-Correlation-Id: ac7f62f9-dc9a-4ffb-d1ac-08ddc2d588c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2JHbHVac0tld3AvUEVhaVJMTEJWSUxYVzY2MG11aGp6S1ZuajlUOHVINGNJ?=
 =?utf-8?B?TTBYTzBJbXBIYlc4VEt2UE14M1VEWnpDdXdySG1jOUhLS2hpa2dvR1VJbzhI?=
 =?utf-8?B?RnJidHV4OWZBRm5td3R0dkYzQUIyNVptd0tLOEppMDFXVXdqUU43L2hhOTgx?=
 =?utf-8?B?S2F4OW1nYjFKSXpEb2pkTjQ2YVNTNHF6aWFWN096TzVodW5VU3RnbTBxdy9W?=
 =?utf-8?B?TnNlVlBwdWpUNEJhMVNkcGlrQ3dWeFBBYnV0NGVOcXFzK29SL3N4dUtHV1dw?=
 =?utf-8?B?Rjk5ZUp3Sjl1R05LVHAwUVVOUVdRS2dtVkR4SXo3MmR1WWpvbThGQ0hiczly?=
 =?utf-8?B?Wm1xa1haamNTS2diNTJGNmhvMzdRRDhjRDZ5enpMTm9oVjZpTEpOSjdaVUNL?=
 =?utf-8?B?Z2tqSThXZWJFQUhaaXMwS0lKWDB2LzNoVi9BRWl3M2Q4VTNuMGJ4eEJFYmp5?=
 =?utf-8?B?T3BabGhDY1BwcktBanNMQk8xQjVsVEp4NW54cnhRREJQK2hHQ3crcjJzeWtB?=
 =?utf-8?B?S1ZhRGRCcUlOU0lLOEhVZHNGK0dOYWlNNUIyTG95a0RNV2pvSWxlcVB3U3o2?=
 =?utf-8?B?ZlZjZE1LZmpvVnBlNDlWL1dPZktteHRjTnY0blBxcnIvQ1NWR3pmMnJtVGda?=
 =?utf-8?B?OEYyZkVvV1R1ZnRnbU5ndDkxVk1WVlpNOTRYWWJVSmRHVHRsdVlvMUE1SW0v?=
 =?utf-8?B?b2ZsT0RNdHdYTzk1cDBvdkNaVVNwT0VuRmdnb3ZDNUpuVm1ScDlLY2V0NDNQ?=
 =?utf-8?B?d0FZUUZSQUoveXpBZTA4NmNkODVXdk40ekhsR04rNE9jVEJyQlk1TkFWa21K?=
 =?utf-8?B?UmJ2NTlMbDFXYVlpd29hZlV1VjFmOVd0SzBDQ3VPUHpzU3ZmTXR0NjF4SEQv?=
 =?utf-8?B?bWhMMGpMRXpmcXcyU09MTmRreWMwMitOWk9INjdqUStyODI2MGs1WlZlUEts?=
 =?utf-8?B?eVVrd0g5QnFxWUFMaWxYMnBrVEJmVGI3Z2hlaFZWeGN1Z3k1NVM1MlJVK2dF?=
 =?utf-8?B?cG1Jd2pUZE5DaWpvVDZSdGYzSW56MTZ3NFFicGdScmM3cmN2ME11MkQvK0dQ?=
 =?utf-8?B?V1dkSXZzYWh1WDhSbWpBSmU1VUhDRXBGRUhtQXVIYWQ2dHVWQ2dEalJRMEFt?=
 =?utf-8?B?b1VlNTNnY1FFbkcyS0lJMjVrSERGNXZwaTJvYnp1M1Q5VFRIUmJNYVhnZk5q?=
 =?utf-8?B?Qzh1Mm95aEpKeGwwS0sxOXBjOFFjSy9oU25FRzB4ZFhvZEdSVjJJdEhnMko4?=
 =?utf-8?B?SE9aWUtVQ08yYUlPUjFLVVhVbFlKUHVRdUJSTmVMT0hVN1dFMENOSWY1VTUw?=
 =?utf-8?B?cDhtR05GaXgwbERWa1htZUJKOVI3ME9XN0ZpUkU3TnRnVW1GU2VCMHkvalRm?=
 =?utf-8?B?SFdQblJRcHZIN2NuNFRlYmdMZDZJWDdVQUdMbk80UE8wa1RkeGxQZlQxb0Ny?=
 =?utf-8?B?eXVKbWIzOWsva3l3VnZab1plbWhBQktXRFcwWmJTQ0FaTXNUWVR4WW1DMGtB?=
 =?utf-8?B?UGc5V1c1VWpxSXZKTXpDMGovZU9hdnBzOS9XYzZwVU1rVnIvd09GNElYZkgz?=
 =?utf-8?B?aUYrN3B2dk1ONUxjS1NJVnJEb203VmdzUGg3dXVuOGw3OTJCcE5LdEZJYW1l?=
 =?utf-8?B?ZEc4dmVLUS9pZ2luVXNGYllNTUZaZEVYL0FHVitlYlBHRWpFSkg5eUY4MWZi?=
 =?utf-8?B?Zk5TVEhONjVVeWhDbGdKRlE4YjV1MEx2VmJISkdkSzF0eUVBTnJhd29xdEFh?=
 =?utf-8?B?bmRrbE5jWGZTb3RkbGRkSkNNc2Z1MGlGcmV6L0hCSVREaGYvUFVjRThtWXVJ?=
 =?utf-8?B?QnVUN3ViMXNteHZ1TEZBd1F5Tnd3RzY3Tkt6bW9XM2xvWWhYRTVka3Q5US9i?=
 =?utf-8?B?U0N2UGo1elUrS1d2RnVvckF3eHRjSE1ld2ZZTVh1cjJtOVRTaUo2VHJ2N1hG?=
 =?utf-8?Q?gBgiedMWQEs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEZKVHdLQ3Vld1hUTzdpUm41RGZDUFIxYnJ4ZWNydEE3OFM3WG0wN0lsUnA0?=
 =?utf-8?B?aituc2dGeWdiUFZsTlRYYkcvbEVua1dXbUxCejZzVjN1VzdTSXlTdFRXTzZo?=
 =?utf-8?B?UWtEVzhBck9TemhlV2N4MTNsV0NYay9pK005OVRoQUM3bDFhazQ3Smk1ZGFK?=
 =?utf-8?B?aUU4eWoybWZId0JXUVdCNUxoelRhMTdrM0ZYRG1kbll5elp5K0hiaWpSYytK?=
 =?utf-8?B?N3pxckZtWTJoVzRwUHNPN2U2MlJCaHdwYXY4eVdJUzBHMkRaNEcydWk0UlFV?=
 =?utf-8?B?dE9IUXdwVUdjN2pnTjNxQW04cG1lSFpIZkxwcnM0U3BDc0I2Z3JaOE50OEY1?=
 =?utf-8?B?OUdLaUxyTkU5R01ZSG5IMnc0dEw1ajF3bHNpaVJJdWs3bm44elFub3lLMFVZ?=
 =?utf-8?B?WVp3eXYvbkd3TXpZMlllQisyekQySDFRb3RLOVByYzVHazFZdURYT1dSQXJm?=
 =?utf-8?B?RWNiamhVQUtkUXFRb3NtR0V5UFVhNWpjQnIrQWkxdjYzTnllOUZGbnJmbnZU?=
 =?utf-8?B?U1V5TVByNlh6Q2JUQ1RvN0QvNDJzZDVyMXRTYjh4RHdVOEFEYjZmMTU4b0VK?=
 =?utf-8?B?ZWlLdWttYlpTV0lneFpSU3pCSFRlbGZGVjU5TmczclVIb25OcFo4amF0U1VI?=
 =?utf-8?B?UlRhYmtMRU1SOFg4dVJJUCtIcmFHbDhSdGZRWVJZa1BleWdMWGFZdEtQSExY?=
 =?utf-8?B?elRJNSs2TU5XNXl5M0VrWS9LZEVWdHVXbDNJY0o2SzAzVUFuR1JnZ2x1MUl6?=
 =?utf-8?B?QWxUQVBKdERQR2VpWGhLYlpWNDdQZXFKMHJiS0lRUE93WWFLcnQ4UEgxbzND?=
 =?utf-8?B?dVlEUEViWE84NWZNK2NTYWc0VWVJa1dabE5MNW9ZZVgzRHJnVGZuMUJnSnZj?=
 =?utf-8?B?T2Qza3loZWM5bmR6b21CQmw2Y2ZDUjdqa01vZnA1QktQSEVTK2lrTklsWFdj?=
 =?utf-8?B?MmZoeW9yWlRHalhCU0Y2LzFSSzFNMUF3UjJ6dTNzNUMxVlRpOStJa3hWT2ZH?=
 =?utf-8?B?RlpRcmQ1NTJxQk9VL25vck55bDZCZytYcCs5aTFwRUJubThJRVhhandxN1lq?=
 =?utf-8?B?andLbHR5cFRwYnpSbTlkYjU4UUJYckhTY1FCQm9yMUlBZmwrdkxDamgrWHQr?=
 =?utf-8?B?K2hMZnhxUkdGTFdEV0lPbVRFTUE0ZmpNUHkrYXBjd2Fsd2g4WmJ6eEhpWTJn?=
 =?utf-8?B?K3hyNVh6RVBLZjRrSmYyMzU0RkxWbjIxaEYxTzYwOXdpdzh1ZnRvQ3BOdDUr?=
 =?utf-8?B?QTljSmpiQWhsdnROYStvM1I3bVBySHFxeE1VaDZ0czdKUzhMVXpXN2ZSSzIx?=
 =?utf-8?B?Tmw4WXp3c2NsMDhsWWhlVmh1NkE0WEtHRW9SQjYyUENGWlFNOEVGMEk0NFZl?=
 =?utf-8?B?SXU3YUdST0YyRGZmTTlyWUdSZ2Y4M3dEQmhUVmsxWXlzVXJXZ1JzUm5CZng1?=
 =?utf-8?B?K2dLckdPMndaZzBNcHNhMG1wVmYwNlYyWFNpZDZCbEQvUmszZWd6aUg3TmZs?=
 =?utf-8?B?Z1FGWmdwK2p4RHpWVFp4WmhseXU5c0x2azR2U2NOYUVJNG55dUdjODJ1M1VH?=
 =?utf-8?B?YVVpS0xCMjJkbUVaNlNsV2Nyai8xdHRlSmVSMC9qbmgvSWdESWNkUU1MRkd6?=
 =?utf-8?B?SVAxa1U0cGNFaVVhcm1SeTM2cnFidGtUcS9aUHlubktPc3dENlZzaWNpeGha?=
 =?utf-8?B?WW1WM3lpYnc3ME16N3FjY1ZHM0dyQUcyaDVzTVZXcFhOSEthUTF4S25sOW5B?=
 =?utf-8?B?WE5xNUh0TTZuek9EL0dGYUJsbXl4Y2RmNmpKeElHQjIvWGRaOGlLbklGcnE0?=
 =?utf-8?B?UlgzWFZRYzRmNUhUSzhlY3FXclRPYWdTY05rNnhKa3Y0b1ZuVFRZQWNGTHRK?=
 =?utf-8?B?RmdVNGRIRStnemFZODA4cU1yWmNKejNzTW5DOUl3MHd5czhsRytMQXY5aUVF?=
 =?utf-8?B?Wlc3Q29PQ0hZY3k1Y3dFUHg1N2VMZUVEMi9QUXBVWG1SY3lxa2ZPa3k3NVRM?=
 =?utf-8?B?VWRYOWRpWWJqMmJ0SVhlNFFTaDFPN2tIRnZpRGo3UWRpd3Jwak9wdjNxc3Fj?=
 =?utf-8?B?Z2h3eFRTeHU3YXVVVm9yU3k4N2M2aGlUZmUrSVd0d3VjUi9HUk1LWVowWHd5?=
 =?utf-8?Q?X7Shn40TBFUeYdXc3Nd9CJRYa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7f62f9-dc9a-4ffb-d1ac-08ddc2d588c3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 12:54:13.6373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s9jiTcBHAeM3dTIbCdQcLxW5k0dLvNA73hSTb792lvm0uD8czgScAYmkaV+L/0cVN5J64RUVimhjAovNP/lwGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4243

Hi Will,

On 7/14/2025 5:47 PM, Will Deacon wrote:
> On Wed, Jul 02, 2025 at 03:07:56PM +0530, Dheeraj Kumar Srivastava wrote:
>> Introducing debugfs support in AMD/IOMMU driver that will allow
>> userspace to dump below IOMMU information
>> 1) MMIO and Capability register per IOMMU
>> 2) Command buffer
>> 3) Device table entry
>> 4) Interrupt remapping table entry
> 
> Suravee, Vasant -- are you happy with this series now? I'll be closing
> the IOMMU tree for 6.17 shortly and it would be a shame for this to
> miss the cut given that it's got to v7 and Dheeraj has been receptive to
> all the feedback so far.

Ack. This is mostly ready. Give me a day. I will review/test this series.

-Vasant


> 
> Of course, if it's not ready then it's not ready, but I wanted to make
> sure you had a chance to look at it before I switch to fixes-only.
> 
> Cheers,
> 
> Will

