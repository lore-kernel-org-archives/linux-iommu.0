Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012024.outbound.protection.outlook.com [52.101.53.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649F12DECD3
	for <iommu@lists.linux.dev>; Fri, 21 Nov 2025 05:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763702527; cv=fail; b=Q9TdRMfq0G+ub858h+k7l1K8bdZlrz6vU05FW1F8aU99SoZjWaR1XiFn2WU/OBoLouHD6RrtQj7Q+Xw29NKDwNE8Yr5dBMlIJwTQdStlcCEExowKo/1nO16vW83raXcyxnIx8lSPIEw7TfeOIxAuccsKkxkSOg5/R4SA8kZ+Ct8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763702527; c=relaxed/simple;
	bh=I2XVSxqqkPLt8B4bFDqajFZVPmgXRZTumaV9CU5vnlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bM+tSI6sqwWLDhwFpcMgYv0vyppqUSngi/ELKFfV7QZIwHoq7vJmE9nzKl8bPTpoz+1sRdzsxiwnhDPWqSwRGhambd/Fz8i2mbwNaQHzvb/6QdkS6XV2HqZU09wegDe9x/7RcjY18QFWzc7FkPE9gQJja4NwnTBgOz4wE5owkUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iWDPybJk; arc=fail smtp.client-ip=52.101.53.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iWDPybJk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lenpsa1pDidDun7n1l38afSwU6gOtUNERwjL2fwGgZNCGnVRR9qfAen82SdeQ+6iJZrlNbkN2Fo7F2Ezw0vWBzWy4G0y6ZGEJOasqKvFMh/tCLgzuHmCBTHSm6WOJrOv8/Fw4CbH68UHzTA+dJ8M69iT5IlC6wx5KdUfPJP9hXiXfS1Msc4fQmmbWwWa4ojYfNoi1mQ2EpPH1xlIO8XLtNeJBjCoaP7PKY6OFfjrUCiAVNuLq+WqcqNUqIggxReiUys5tfzsUtmHWZhS31of5fwJwD5XIKezMSuX5S2Mbw8KJxgGxyBwPzNrGDL9O3VutKMkwNUkEtBTOXZsS/6gjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I2XVSxqqkPLt8B4bFDqajFZVPmgXRZTumaV9CU5vnlA=;
 b=bhz62YijbUqC0s+g19qi0ic6tP7Pn7hXkKu9juO1pYce/7K6SDiXM0kdKHr741WVOay9fT1TUpqJE5aqNR+uY7KXj/13bZfTrCHzrvYyaHdlsVbALW4jsXbFp8zQj7u2vUbIKkLfbNyvRiHB09xIbmOb3ELcy1dcXK2PSD/QrCnixyx0+BAq+xd6XjJi5M5nehix4gBltd4579KHg2z8iXEz+1Dl038Spz0TXdLqf7f3ImjuwEv6AGxzMyRvYZSjGv+Yf9vsimk7y15ZKBooX9CnYHfeIFiyyfJxQGOd2MOefFRBU3LZqo5my14l5vcHiTLCbg4cqNMTVL+KLol+ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2XVSxqqkPLt8B4bFDqajFZVPmgXRZTumaV9CU5vnlA=;
 b=iWDPybJkbDSpLNVXhqp2c8pNfew+tnkOXH8UWj90dQKuCr0zaS+FAdHmkBCvmUbneLTXNMusuEg9xUzjWBRqVi84oT0zXKRAkSmS/plIDegEoK3DHjhK3/BHLJ+bQCcuf8oXyf7q02iTsHfzYl2s4IjoxN0l9GO6yXFPY1rSOHk=
Received: from PH7PR02CA0018.namprd02.prod.outlook.com (2603:10b6:510:33d::19)
 by LV2PR12MB5725.namprd12.prod.outlook.com (2603:10b6:408:14c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 05:22:00 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:510:33d:cafe::d6) by PH7PR02CA0018.outlook.office365.com
 (2603:10b6:510:33d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Fri,
 21 Nov 2025 05:21:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 05:22:00 +0000
Received: from [10.136.41.133] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 21:21:57 -0800
Message-ID: <66a032df-d54f-471a-8219-5f41c2298b5f@amd.com>
Date: Fri, 21 Nov 2025 10:51:55 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] amd/iommu: Preserve domain ids inside the kdump
 kernel
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Vasant Hegde <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <ashish.kalra@amd.com>,
	<robin.murphy@arm.com>, <will@kernel.org>
References: <20251114104442.23296-1-sarunkod@amd.com>
 <20251114104442.23296-2-sarunkod@amd.com>
 <78a4598d-5d35-4fd0-a830-a740076aba41@amd.com>
 <20251119134351.GM120075@nvidia.com>
 <5167fc71-23e2-486e-b9f6-f11960725b19@amd.com>
 <20251120125634.GA153257@nvidia.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20251120125634.GA153257@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|LV2PR12MB5725:EE_
X-MS-Office365-Filtering-Correlation-Id: 6347c5f4-257d-435a-eaac-08de28bde5dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eE50ZFRGMmNoNkxkT3VuTWFISXVTRm9CWG8wWXNlTWVTYk1wV1Vwc3hmdmww?=
 =?utf-8?B?Ni9semk3QzVNOXI4MUg3TkFSaERsNHVZN09GcTFlMCszcVlkYWVpQmVHS1h6?=
 =?utf-8?B?RDlxc2YyQ09jUDlzVWhsK3pXZnhWMWl2QVcybDNtR2FXVjdJTUxkYTdLRGdH?=
 =?utf-8?B?ZG1oZjk3aVJUOGNtTklxbit6eThNNm5aVm41Zjc5YnBRMVlERndpaU81NmxC?=
 =?utf-8?B?Q2hpanhTa2lJU2s1Sk1HWE14WjZ0Z0h3dkVIMm1VNlRhYjRCOFd2Ty9VRGdU?=
 =?utf-8?B?RU53ZGgwRytVVzhkV285SnNRZGFNUXRBdDVSd051NGtSNkhOZUxlekRGejh4?=
 =?utf-8?B?TGFadlhrTmF4aE02bUtlSHdPZjRtaHRZc29sTnVKWHhidzEyaXlFR1ppQmMy?=
 =?utf-8?B?djU2TXk5amR4b00rZkorK2toY3FuOGJDSmkrUWsvMVlVY2JyQWxkT1ZydGRa?=
 =?utf-8?B?ZHloM0VhYnMweTZSREhPWjBWTGhjWWxVcXVvS0w5QnoxYzA1V0pHVHZPMUlt?=
 =?utf-8?B?MEMwRm1sME5nb09WVGZ3RmU2WjlLT0d1ZlRlTHFRRXdjSXNWT1hWNG5odGpB?=
 =?utf-8?B?MnFMdU16KzlxU1lPSG1RQVJXcHppaWtHZ0loQjNJVm9rVjlJYU1VYWwwcENl?=
 =?utf-8?B?TFJsL04xQ1NvNXAyMTdZem80amJRempZcC9LTmp6a0VQSU1FNDZaMWI5ZEln?=
 =?utf-8?B?dWR1ZElnSE1DSDJCTS9FbVFzcXBpUzV3Y3A1RGlsRWFYcmpxakJ3dE9lbU40?=
 =?utf-8?B?VGNuVnl1UjlvdlhORWtZWExwYUgzQW5lM3EwS3NkSFJhR0xJQSs0c1Z0NS85?=
 =?utf-8?B?bWxRSG1iNzg4Y01Za254TnBraXlWZURsWGFybFhVY3ZINFI3VDljVmFSK0w0?=
 =?utf-8?B?bWRyZnR3VWZySXhLd2F2dnRTVWRCUkxDbUlpc1NwYTA3a1Q2M1VBVTRTYjU5?=
 =?utf-8?B?enZJRUJ4dGRrWFp6MWJYdkZzZTI4YVJST013T1hQVkxOSmVLcjVPOVFsZ2VR?=
 =?utf-8?B?VUdZZTl6SXFiYWt0RTE5MEx4emFxQS9RQWVYaEpGU0N6YXYrSnc5Mkl1Sndp?=
 =?utf-8?B?T1gyS2g1TDM1K1FxZnl5R2FVNk1SUXYybGsyZzN1d093MFpUWmtYU0xZRzdU?=
 =?utf-8?B?enRuZDNoWEpDUkhFWmY0bVlzeTZjek1HSzZKOWRSRFFUR0l4L2FrWlBGaEdo?=
 =?utf-8?B?MUh6YUhTNWsxb25PbUtaWDJsbHJNT1VRRHVnRDhvZmlpbTZlYjJUV3F2dFdX?=
 =?utf-8?B?VVpmc2hnaHE2L2hVTVQ3cmpadGw2amVjYU12V2dqVXI0NVFtOFZJekh1UVFr?=
 =?utf-8?B?eHNGQzIyQjIzZk5LckNVeS9iVjVjUjV5a29VTndoRkQ5WktOZFhaU3JQY0pV?=
 =?utf-8?B?M01EU1BtZzB2cEpGdW8vZnhFK0g0UlliTG1WRlN4WXRmdmZEZlhXejF6bTYy?=
 =?utf-8?B?aTBaNWxPS1ZsRlh6WDJkNVZ1QnVOK3hIWW14WlExQVplWi91Mk1PS2xpYWxo?=
 =?utf-8?B?SEJDUXV6SDZSR2lNNk95U0dZU0ZoWmdYWitQaCszamwzSnY3dS84VzZPNW5E?=
 =?utf-8?B?a0FveHRjUzBXTlZsbW05ZjdNWkFUUVp2a1RPM1ppYnNBdGlPUGIxU0dWSHlG?=
 =?utf-8?B?RitIUVpLM0dBbEQvQ0o1elV3S0pTWnk2dWlaT2xsUjUzRXZibFl5VWpGeHBI?=
 =?utf-8?B?UVZSbCtUMDRPNW1la3I3YUxpaU9ZaG5Wd0V6UUU0Q3IyMTBrRzhOS1UzeWs3?=
 =?utf-8?B?d2FVVkFUNVhtVURBZVhSQzUxT3B0MUxmZEdXQVRVVm9WaUFlWU12dnl0dmYr?=
 =?utf-8?B?Z1QrM3VUM0laV0pHa21ZdmluaWtyc2hvL2t3NW5BM1RqN21qTmZIKzI1TUJS?=
 =?utf-8?B?NVlhcUNhUlg1MTdyZUJWR1E5dCt2Yks2TitLUzd4d1c5WHVGdlhkZUhlaGEy?=
 =?utf-8?B?NmVwbGdnQ25FTGN2L1hyanNhc1VocERGSExlcXBGTDJ2K05sb3UzYUo2Y1Js?=
 =?utf-8?B?cS9pVVltN0hYY0hnaHowQ1FXMlFCcnF2QmRwSDdaYWJ5b2ZEeWhKbEJYMGpM?=
 =?utf-8?B?RXllVkxwYmFmbXcrZnpmU3FHNmhSNVZuZFFuZWVMUnUrNS9WZ3lHaEZLbHRE?=
 =?utf-8?Q?IW5Y=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 05:22:00.2999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6347c5f4-257d-435a-eaac-08de28bde5dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5725



On 11/20/2025 6:26 PM, Jason Gunthorpe wrote:
> On Thu, Nov 20, 2025 at 10:32:32AM +0530, Sairaj Kodilkar wrote:
>
>> No, its not atomic context. My intension was to ensure that the
>> memory allocation succeeds. But I am not sure if it's the most
>> appropriate choice for this scenario
> This is early boot, it won't fail either way. Use GFP_KERNEL because
> it is clearer

Sure, Thanks for suggestion

-Sairaj
