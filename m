Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792512041;
	b=vu5oV2ybJ60IpsZPpNu+wJWJlJXDkOP3KuUI2IWsKEXErOZWh79bG6mxt+mVF3wMXbtI
	 4qiYbMhI0hbcnxcBbIIepZDhFOrLtrKNhgaeQHb0hpAtodHcSscGyU8zLoOu3Ocn4iciG
	 02G149eS6lSDTRZ688nSS+E2hTQi9erViVPiJjBkAaP/hp8mN5ljy+ILFCbqJUfxeAZFs
	 YAwS0QeIg0eqJjw+M+bsiI5XvIyAgUz+Wi4f8/WvqhxTjwY9N/wt3mGDJTz8XR7HsOAW+
	 5bsS4X5Hu2VQh+aUJj8CvJ9/v08OX9HfVD98/vysb+ml3W0cU29j10UY0WIN6W4Hguw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792512041;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=UtZ7ioZBJ+/SVpSGZg6vG8bNIAUmtn7di7epGFJzacc=;
	b=xm6ubKq0KVygcxki/X3KJD0Ogf8Pb+Cyt6IIIf7theEUSz9QRuOTtIroLtZJ59OTIYab
	 5hLVFxCndIQgNhdCxz/JCOM8nGEfCrUc5EhuezCSPbNF31i5OKDswGqdSm6HXTx5pssUA
	 wkntS/3rer4irq1aZ52wYN0nPQHkL7Ad+7YUzvU5us2UWi7ir1DopQJ84S6Wul9riPuRF
	 h10Clh2V+qnLjz4FILdiM55UjEChC8/GDKzxO6zhUjBaTCYeNVUOWI5+e/u79S0rWSnDz
	 VyHODjozmRHPwJ93Dh65PsMs8MOYzOwtvAeOxMMh/CVjDeR/s7i2mEYYymKFMkDM5Sg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=idlbuKhS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.38
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010038.outbound.protection.outlook.com [52.101.46.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63546606A321
	for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 16:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63546606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=idlbuKhS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tA2IWzub53A8G8M+5iSPbEH6+EywK5aCI6b56Usxu+3BzJBPfhEleMx9jWE+Mr83KgzaMO7nXn2RoDK1r1zoJvMQHKbB+DVax50Oiob8AmZWRmMWCGeqWZ0E9GrKRop7ktqBCSNgK+TmLzWm+OMBNa6T6wS/8hZBdSi1eORX8YxwW97rDVwO7DdTkgNsZGa6wUA+V6RWSdngqv7Q83igihxo0QzYn0FgqvuvCylURc6WDWXiNeCip62OELLTk8tNwPUQFd4tJ9bXl0klgJGyf9NvrQ5KtS2qN/HIzV0C4G89UiC/DjxYmeA2vvkzydXKetJmT7TyB2pajmZ8FV/S0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UtZ7ioZBJ+/SVpSGZg6vG8bNIAUmtn7di7epGFJzacc=;
 b=UQbtrwxSW1op4rDO9/EasaR+A9TsqjVB0oe/sPFumyDvq782XUIqwF4cgIJ6QZAObjqaQBWeCkKxBWQ6ZqJiqRERvg2q0KtFhm1z0Xfft5L3K0uXaF0QAkk8QC9M6r+X5GaPR0L0UrGnkDcIBICbM+ehy9IobaCLet9OqxSKOYiQGtWNK3Mv3sQML6TCnSuHJddgb4KshalbPtb2G9CZ1gEt9c1CXkLvji2UDuH21PNWd/z+QgcQwg9dYzzCCHVqauRkTaJVMAZi8i5RK488JwRfO4ep05csRTkjlEsqGXdPQOrAIPOntIXkoimTDmZozOqK0eHLGF8og2Y22O9uog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtZ7ioZBJ+/SVpSGZg6vG8bNIAUmtn7di7epGFJzacc=;
 b=idlbuKhSIoy+2MtRFzb9kJVAFbpVllcyRbGRZZNrHKzJ24iaAGxDGTyasqwQXE8Bnfqp4gGlm5JCBYDSMerlz2Xl9LRhrA2UFxSvbb+ZJLUwjBXWENmLycDj1xM0ZUWhNtEOJjytaI9qYBPNHSXFRSjCrhGF2s5X0/ly7vcnERY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999171.namprd12.prod.outlook.com (2603:10b6:8:388::22)
 by IA1PR12MB9466.namprd12.prod.outlook.com (2603:10b6:208:595::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 20 Oct
 2026 16:00:36 +0000
Received: from DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19]) by DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19%6]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 16:00:35 +0000
Message-ID: <9043514a-932e-436a-805d-9694b88d9caf@amd.com>
Date: Tue, 20 Oct 2026 23:00:25 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 18/24] iommu/amd: Init and clear vIOMMU DevID and DomID
 maps
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 Sairaj.K@amd.com, jay.chen@amd.com, Ming.Shu@amd.com, SooJin.Tan@amd.com,
 chrisl@kernel.org, wvw@google.com, wnliu@google.com, dantuluris@google.com,
 kpsingh@google.com, alejandro.j.jimenez@oracle.com,
 joao.m.martins@oracle.com, guanghuifeng@linux.alibaba.com
References: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
 <20260930092344.5616-19-suravee.suthikulpanit@amd.com>
 <179210758994.4133959.6615374486960504749.b4-review@b4>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <179210758994.4133959.6615374486960504749.b4-review@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:4:197::7) To DSVPR12MB999171.namprd12.prod.outlook.com
 (2603:10b6:8:388::22)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999171:EE_|IA1PR12MB9466:EE_
X-MS-Office365-Filtering-Correlation-Id: e06963ff-fa33-4c59-1225-08df2ec346f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|6133799003|10067099003|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	wf4ZnHoksdg9iP8VBaDQ98JZ5d//YKjDPQVbqYiz0abdyY8lHGJ4d3rBUSx68U5VAwuOl9D/L9tAONyoSbQw1JNuvdRs58ShCQHxDHG3cD5VrK9og7AWl7+ulXyLHyMPnzFWJ8rLgq1fg8VU4xxnTO/nXDRneEbJ2oe0Vk5qKg4GBUqqHW3/wdNkaY91o+fKQWXJEMb/mHCtYwENqVpz+mcufftF2vY1qtJi6yv4Qkdk03L2DtOB8Ozzb5o+Avfhg3WdqCuEPb/V7CLCjYEP+qaXsgqx0E2Chjla1o7D22QHmZo2vF7JoziW87cuq+icMOcesNvvqhJ72zZzrWGzaeOYCpbhl87u6sP7VHxCosmZ+/P6avqQYtuorBcxO/CvxfUHI4f6ZwI6byK0tCIT6pvs3K+chV+rpDdZnvBw/lDXZRDWYLDAmfC439zATauANAAmY3GZDXV157b2K2iXWRYgqhQOvIwtwn777EXlnA4eT+gNkMct07coMXOdo0BoSZjuj7lVUAPY3s7P9N+PPbOCQz0SelFenxlTXerpDiDONFSOXOSbekTRfx4vbvfnLHgiTv/icM2l4tMpVVTQTW2YsGhwC8VTdwjw5bRPie8jD4bjSvnMtq9RLQDm3VZ8h9zQxT/JGuzgEV51e+uMIM6SOhLGkhTrliyEiMkKioY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB999171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(6133799003)(10067099003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3lsMHVMK1NwSzlNTHd3TTdrQUtpdkpnelZPNWJyWTNEOGJXRDZuNzJCcTJx?=
 =?utf-8?B?N2o1YjF5dEZWWHUvcytvbWxEUGJ1eUo0bDJDQWlNdjI0bEovWXQxNUR3NEZh?=
 =?utf-8?B?ZU9GeDdHNUF6dVAxV0F4SCsyaWtZajlSYTkyN1oyTDZhMlI5TFpqRnl2NEhx?=
 =?utf-8?B?Y3U3VHZhcTR4emJvWVZNS2NMZ296WktDZWUwSVdjQTdkNDU5K3dUa3c0UG82?=
 =?utf-8?B?eXAxK0RaWnY4QkRXVmVseTlmazMwd3dBakt3c3ZEbEp1ckovcFFBNWtaVVdK?=
 =?utf-8?B?OWhLak1Fd1hmeGZGaVlBQXJJbCtibVlRYlB3dXpSb0VWbzRZaHVyYndYYkNp?=
 =?utf-8?B?MkVhdzlnZXBtZ1NnUUx5SlIxbDR4ZzVXNHZaRzhQbFBSc24rVXVwdnE4MmRH?=
 =?utf-8?B?R3VrNk1ZelpIenVaUEMxaXFBemE1MVJSQU1sU205aXo3UUhzeHFtbGF6V2k3?=
 =?utf-8?B?THorN2wvSW1EL05rL0Z4YWhUZFZGSkc1OW85SFhlbGs4RTRrZCt1VFp5MTV6?=
 =?utf-8?B?Y0dncEhKMlN3TTl4c3ZSb1BvbVkyRnBYaVhxRnk3ZDArRUl6K3FZSUlnK05S?=
 =?utf-8?B?cnlrdWpGaXhDOTFJOFg0b1p0Z2RLN2FtL2RIOUFRcURvYTZNZHYzMWJWY1dB?=
 =?utf-8?B?YlFkSFl6SHh5YkJVS2xLcklUR3Z0WG82ZkwvOFFhbHJLZlBqQ3grM1dYVFNZ?=
 =?utf-8?B?dExmd3JNQXBZS2Nkdkg4eVI4ZDg0Wm5WUXRpcVRTWklWdlJEcFVCTVJNQ1BT?=
 =?utf-8?B?L1ZzdFk0eWphZmFMVDVOWlE0KzhhT3dKazAva0lZa29kMmwzZ1hFUkpBWEY0?=
 =?utf-8?B?cEQ2SVMyOGZGQkYzenJhZTdidUhBRkFzR1JsV2dlNjZoS2p6Nk5XQUl2bVhr?=
 =?utf-8?B?RUxLbEtJSk5uaW5GalgwdEhLTCtUOUVmYklHck9IMGgyRENLcFQ1OEdROHRL?=
 =?utf-8?B?ejRmTStyczIwcU9LRGgyWWZScXZoRlMyMU9wOUUvM3BsN2JsdWwyVXdVeVpG?=
 =?utf-8?B?Q3pLS2xOUnNFTUs1aitYMU5KYWpsKzlzblRrc29lcWtLeFpmd2wxNXIyOFhZ?=
 =?utf-8?B?UklGZlJwQW5XMFE0NHRlZEdlNlhkYlVrTnplVEFEM29YU0dTUWF6V2ZRbDZN?=
 =?utf-8?B?c0xITXZEQ0J1Sy9DdWtyUlQxdHdIazZYSnVubVpsS2xjRjZLQ1VKRCt3Y1o3?=
 =?utf-8?B?NW5WY2F2L1lHMTBmQ2RieWgwUjBFdHB5VmllM1lwOXpEazZ5OW5FQlVVTWl4?=
 =?utf-8?B?a2Fwc0xnOHp5YXRDNmtaaTd4OTAzWUtJVUJiS2NVaXpSNGJuNFlWWTBSMS84?=
 =?utf-8?B?T1ArcGVITG4wT3J6QW5ueXoxemxBdmU0OEZ0Mmk0VjNScENza0ZrSTVacDVv?=
 =?utf-8?B?ZDV1czVFbVhGcHZCQWlFSy9pVkxWajl6YW5ZdWlTTlNmbTNnKzZPbUxRc1NL?=
 =?utf-8?B?L3ZML3RrQXJWODlsbVQ2TVdBNFpsVzV5T1hlcGNTWkxWUEdPeDBUNGJRL2Rm?=
 =?utf-8?B?UnBkSTFVWTQ2eThaaFZ0M0pFbng4akI1VnpHZEFXc0xTY1E3UVJzR2pQbDhG?=
 =?utf-8?B?MXJuRERvdy92aFNid1piNjl2R3NEYTlnRGlNTCs4bWpXMEkwNEdrbU9RaDJp?=
 =?utf-8?B?R3hjM3ZLTGNadVBhT1BMT29DU0ZrSW8vNVBiQTdXQVgzU0JMOFhBbE1rOUVv?=
 =?utf-8?B?NEduT1JmeGdlZnV4OEw0VTJzT2RjZFljcE1DSmRZQmNOY3ZhUDgyNlZ4SnVh?=
 =?utf-8?B?dHBMcGVwd1p6cmh1QmlkTkt0OVZ2d0cwY1M1OHYyRzYvSnpYaUZrLy9lSkRS?=
 =?utf-8?B?YjVBSVRreVpvSlVlU0lTbEFqb1NmOTBVMitFYW1JMFlTMUZaTWhGTzdpR2xx?=
 =?utf-8?B?dUVCL2VDYzg3RlE2S2EydTY5LzN2VjNtdGluOWF3dXpzei9UbDhIZDY2R1pR?=
 =?utf-8?B?Y3lmdzFTMlA5cVUxTzU4OEptYkVUZFZrL0NEMlRIMUlkaUpNRk8rVklJUVJo?=
 =?utf-8?B?TXJCdUVWdmtaNTk3VXNBSXlJRk9JUnhZemxDdW9mT3BnK1ZIeW4xOXdnelov?=
 =?utf-8?B?cEVvb3JSSC85cFNGUU5jNmpQc2p3aVZTL1J6cHlwY0MyZE9WMHJMWVNkRm5j?=
 =?utf-8?B?SEZFOHo0R01sdUZVcUdhaUNQQk5xNlo3NFptMGtRVDJ5Z0NpbHN1SGZTczY3?=
 =?utf-8?B?eG96RWJWU0h1OWFkTW9TL3BZOVR2RjEzamJLdFdVNmNKako3dU4yM3hGY0ZV?=
 =?utf-8?B?cHNCVFdtOTFXSlJRWFMrTlgvOGw1TXpvbEJLSjBQUGtYNmRySkx5L0p3SmVQ?=
 =?utf-8?B?cWh0M2VYV2IrM294Y0QyMUFGRThtaElkem1hVW4yd2V5MnkxS2V5QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e06963ff-fa33-4c59-1225-08df2ec346f6
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 16:00:35.7687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rno/YW/23EL4mbi7h6tQcnDE/Bd6STp7jrnB1XUevEDfY10o36UFpIJa55rOZdF2GZj7semr2vv+p7q5QWWdHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9466



On 10/16/2026 6:39 AM, Jason Gunthorpe wrote:
>> Before using a vIOMMU instance, prefill the mapping tables so hardware
>> never sees an unknown guest ID. Map every gdom_id to the nest parent
>> domain ID, and write every gdev_id with hdev_id 0. Init cannot be
>> scoped to IDs in use; INVALIDATE_IOMMU_ALL walks the HW table.
>>
>> Yield vfctrl_lock every 256 doorbells so the 128K MMIO loop can
>> resched. Attach cannot run until viommu->ops is set after init_one().
>>
>> On destroy, drain CONTROL0/CONTROL1 WRITE and unmap. Do not rewrite
>> the full tables: that would start 128K DMA writes into pages about
>> to be freed. vDevice destroy and nested_domain_free already restored
>> idle entries.
>>
>> Skip VFCTRL access when CONTROL_CMDBUF_EN is already clear, matching
>> viommu_priv_unmap_free() on the same uninit_one() path.
> I didn't see any explanation what happens if the guest issues an
> invalidate to a gdomid without a host domid?
> 
> This is related to my questions about when the IOTLB is cleaned. Given
> this patch I would expect that once the mapping is removed the hdomid
> is cleaned and any invalidations for the gdomid are NOPd
> 
> If the gdomis is used again it is assigned to a clean hdomid and those
> NOP'd invalidations don't matter.
> 
> Is this how it works?

When guest sends INVALIDATE_IOMMU_PAGES command with gDomID to vCmd 
buffer, IOMMU hardware uses the gDomID to index the DomainID mapping 
table to get the hDomID (from the entry w/ v=1). Then it uses the hDomID 
  for actual IOMMU TLB invalidation. If the mapping entry has v=0, it 
would generate hardware error in the host Event log.

If the hDomID does not match anything in the IOMMU TLB, it would be a 
NOP. This is the same as when host IOMMU driver submit 
INVALIDATE_IOMMU_PAGES command w/ an unused domainID.

For current implementation, the IOMMU driver prefills the DomainID 
mapping table with nest parent domain ID (hDomID), and restore the same 
ID when mapping is removed. This is to make sure that each mapping entry 
has valid hDomID and not just some random domain ID.

> I have to say the commit messages are no good in this series, do not
> summarize what the patch is doing, explain why this patch is necessary
> in the first place.

I'll update the commit message.

Regards,
Suravee
