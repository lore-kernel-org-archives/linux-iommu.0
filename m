Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010052.outbound.protection.outlook.com [52.101.46.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECC081ACA
	for <iommu@lists.linux.dev>; Mon,  8 Dec 2025 05:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765170688; cv=fail; b=NJO5EvHWFaSDEdvJShtI2YDSGXGA/5Guto7/Af+x5wDeDptGbaYADSvLEqP28R88kauIIFbp9UFw+5p5fT8T2asmEbmyifYbv+l7yv1a7aJETSO+KE+N3Cl93+oysNnP8Juv0tjUMw2uzjJMFpUdDQFgqVVdVIz4lP2ipRYMb7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765170688; c=relaxed/simple;
	bh=cpiHmnzeO+Nu8SHH/aGSgHpotDxP7bOv75tYTuw5Okk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A9HI2xHsD9NM5EDRmqik4bnMPVkzQGyJ3MdS5sYzPpzCfnhe5i3XUKLqf5Md4Y9Jih3sEycVRQTg4XLWTmYyrHW1VoFDAvfbyYC2z4SXohG2QGGXJV4W0ALNoVR8rMNudAZuJ80h1mSpJ2Dix/XVYOB9eGCrDTyr1qY58fNEmj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Is6/i3je; arc=fail smtp.client-ip=52.101.46.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Is6/i3je"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tST1cmoKKQDe894uU3C2cXppDoH6BMQrHVnxf+sstzOUw/34YAWoDZWzCU3OSZu7XAzPJeWBzOm2HTVfDMeyVt9tOZL4NnUmRb+ddLyPzL6xs+lHahV9qK3jwnvAj1vGPHpCKLUw1fDQxInHuexb4iA9ete44fWcSsxyzC4uM2F73gphyeyrnvokjWRtSjMEh9+UXnmzPzF8sDiF/v0uTClQnvzAOyYzHxAGkAkjcLNgKioQnRrD0Nf1E+mxu0APg1pxdzNvRknx9uTDaMYMeo1T6tBtLdfZhRr7Vj/77h37Dmi6kzgYQ6HPfig1iw89Y6tzNpchQ1cu1c/0wTR20g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8YezZs/LhDYfdftevKtQCTF0gGJpqM9+W1nY2XtHxzA=;
 b=YpVFf00Bp3fZAvyS/TGJNKLBhRGZpgYYQYUV7vDSOxP1Zu+UXhlMJ3EVHcyHfE2OOhZ/mROGaSELod4+wY3Ww5vLmU0SmbvlZ5AeCK3y4KPgqyhcGOMpQ34c335blmysc18dbcLEf8/hOlGEvsO6zxhUgnhQ7BIoo5cgENu5K0Pip4Tq8M00i2aBMi+Fkcf1CjzGtrBXx3jRkrq2H/G5t9xohiqwKVHP4RSZ5torSf7Bz/SQTT1zstPBltcTvbKFnK540aVM++RC2u4MexhSQW1+LNfQyx14UtJr5Q4xSRcTcVyV0P2kj/Hm/YVd7i7lCNwgbepUNrvJjWfHto4wkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YezZs/LhDYfdftevKtQCTF0gGJpqM9+W1nY2XtHxzA=;
 b=Is6/i3jekABRjf26F4c82PlliTET7G7/W2vQ0Ht4579t+Uruz/yAei1rJCcSXNk8OUKulhUwHIQ+fnzGbwyJqHBdU6fmEMkO5qxHRHjbR3IHH4PlOLbkC1Hu5p9g8RtwyLqkQ5e7fcoSBnliVOLYqYb98byg5bkx7abL/OIraMA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH7PR12MB7793.namprd12.prod.outlook.com (2603:10b6:510:270::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Mon, 8 Dec
 2025 05:11:23 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::a5e0:9d7e:d941:c74d]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::a5e0:9d7e:d941:c74d%7]) with mapi id 15.20.9388.003; Mon, 8 Dec 2025
 05:11:23 +0000
Message-ID: <1919c5c9-c8c9-45b5-9ea3-96499309c931@amd.com>
Date: Mon, 8 Dec 2025 10:41:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Seeking help on AMD IOMMU unmap logic
To: =?UTF-8?B?5byg5YWD54CaIFRpbyBaaGFuZw==?= <tiozhang@didiglobal.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "zyhtheonly@gmail.com" <zyhtheonly@gmail.com>
References: <ACD20C23-EAD7-413B-9B21-56FBC35EA5BF@didiglobal.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ACD20C23-EAD7-413B-9B21-56FBC35EA5BF@didiglobal.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::10) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH7PR12MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: 3265eda0-2bd1-4d15-53e1-08de36183acb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3AvRTJhREM2TzRjQmdGVFZzNGFHc0g1bWY2dGNIakZidk1kaWV3REFlMjBD?=
 =?utf-8?B?Qk1yR25QS3E2Yk5ORFFaTDFoa1pTaU1tUDNaVWRYdFhRYlorRGxOY2RGOEkv?=
 =?utf-8?B?RDh1d2w2UWdSWG93NzRvTUtTR0ZZZjRyUEQwa2lWbDJlMkVlQTducTFNWG9R?=
 =?utf-8?B?OHhzTlJuTS9GZWJudkExL2ZsYWdVNFJOK1Y4eG5DeTdLMk9UamJRdEVPVkZC?=
 =?utf-8?B?ck4ycFhoT25FUG1sUHRuM1FpM2MzbHVjTHp2TGRadEp5dTBrSTZ2M2pMT0kx?=
 =?utf-8?B?bE1aaXY3UmFySGpVWFFzbVJoL1BVdW9lTXBqSE5La29WNkdDZzRYSDVIUzN3?=
 =?utf-8?B?Y1FnZUg2YnNla3Z5Zm94TmZOcmtVT3lJR08ySFRjenJnVjE4WllEbUdVbzhH?=
 =?utf-8?B?QWhwZ05FUnlDL1BxVWVpRG95RjhJQyt5Vzg0azUwbVNGZzgxNXoxcGxQbjZo?=
 =?utf-8?B?QXpHZXF6K04vdmRpZWJBQTVPMmtLRDNlb0RGamNndnNsemNSWXU5MG9iTkJj?=
 =?utf-8?B?WXJ6RVZkTW90UU1EbGtQak53cUdHVTNTeHYwL0R0QnpTOG9ETUlUeDJWeHB4?=
 =?utf-8?B?WlhFNHFlRkhvR2ZHa3FEZXlPTFZNdVpVeERwcGxURElCUDlKbnc0cWNZK2Q1?=
 =?utf-8?B?WkV4RnpFV3UxazhpVjVOWkRNRW5HYkVhUXN2dERZbmxENTg4ZUVpaFRYSGNI?=
 =?utf-8?B?QkxJTlNnTSs4aUNJanhBQ0tsV2FYRUhhZ1JNbm5LNFpaK3EzUG9XcHZmVHFO?=
 =?utf-8?B?alNGSXhHZ2tqbDdNMmNGZlZxVHdUaVpYRnBwTmNVODcraDR3dlZHMTlOd2lV?=
 =?utf-8?B?MC93Y3l4YUJmUXdSUHRIYWMyb3NjVW1aU2VqaDJ0eXJTbWE4ZHRKMm9yTEZ1?=
 =?utf-8?B?dzdTcXJUc0plTUh3dHFuL0dneDMrc1pYbVZDem95VjlCY0FINXZtTTBHRy9R?=
 =?utf-8?B?aWs1TlZuSU1LQnJwUVcwdGJzMHBDMlBpVWg3djNxUlo2cTcvRFk1LzBGWXh1?=
 =?utf-8?B?WWdWa25OVGdiclVkam1SNjU3Q2NOamFDeGw4TjliYzJJNXdGSHl3ZnRoMWN0?=
 =?utf-8?B?Nm5ZRVAwNHloRjNiVTdiZVFFVGpnVnZ1a3Zuc1BHNHF5ZVVkZmE1ODFDeHh2?=
 =?utf-8?B?TGZ6SUcrL3Nqc2ZiRjRkdUh3YzZEQXZCemxIaVUvNXlabGtQd0tlWjQzQVRM?=
 =?utf-8?B?YUpqcXVpUytneTFlZFVpRzN4VHc3RytyWnREOG10VVdYaTB3OGI1eHAwWEZw?=
 =?utf-8?B?LzFpOEJsZDVxcmJQbzg1Yld2Y0ZsYXpPcGErdzBpQ0J1dDMzTUhRVjlPZ1ZQ?=
 =?utf-8?B?WU9BWXVEaFUrMlBwbGFyZW5CNTVlUEZ1VldmQWppM3crblRqRmc1TkxTYlBk?=
 =?utf-8?B?dC96N2xFZHRrNU8vS3hzWHF3SkJJYWRNRGRFZE1nSG84bEhITWloZTI5Zit5?=
 =?utf-8?B?ejN0dFM3b09oTVMySXZvWXRJVG9PcGpQWDI5QzkzRlJYdWh4cUYvWnl0Y09C?=
 =?utf-8?B?d1BneDh6dzV1QXJhMjNrb1JqTFNidys4NVkzZE9JOVNCcDVoN0w1Ly9BVmlF?=
 =?utf-8?B?bUZ3amZJMTA4QnFBTE9DVUpTd1JBY2JIUEpMUWF0bEZpV2poeU5xc2xqUGlV?=
 =?utf-8?B?cllaSGNZVElNM3JXYmlaSEFCUksyZjU1eWVPRUdITm1RMDdCVGE1RHg5bmR4?=
 =?utf-8?B?WWdMK2R4ZjhRaXdHOUZFWjNNNXg3TytxRDJXd2lPNWhpSUh5WS9wNlBZK0Zl?=
 =?utf-8?B?R0s1WkxwZEFLNFpSV0FOeERGd3Q3eXdRcDVOR2ZteWIvOHp5MEF6SFl4YXFN?=
 =?utf-8?B?RkNRQXF3RENFWUs2bysxU3BQcXZoSE5rZmk0TVZrRVJiRkxvZ1lkc01nb2V5?=
 =?utf-8?B?WkVhRXhObnRmMzhXVHJjMGJmeURsdmpCeWEyYjlXbzNPS2dFSTYyL2dtc3I3?=
 =?utf-8?Q?qulZRayQkk/WsaXF9ML+N9PMCzON+jzl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzdKbWZoTkRlUVhKcDdIOXZ6MlBhRDF5Zk4zTmtWU3lnS2RUNGVHNEVSbDhK?=
 =?utf-8?B?a0ZpNWFyWmNRWTJ2b08yR0FQaHhjeHZzeDViNXgwa0ticGU0VTlNNW8xQkVZ?=
 =?utf-8?B?L3V4U053V3g3NU5vL1hMZHVaOFQ5dmtjVWZFWklIR1FVT2NzVWNnVFFQekVW?=
 =?utf-8?B?UGV1R0RLSlZqZ2dySDUrc3UyTDZkc3AwNjFsZnBFY3A2emx2c09hTlREc0lv?=
 =?utf-8?B?ZkhjeWt4Rm5lZXVMcTNOeEg4V0hGT3ZraGtkMWtIcy9lK3J6bk96bmpUMC9v?=
 =?utf-8?B?Zkdack1DbmtieUR2YTJlemNiV2QzdHA5YlpLN09yWDJNMVU3NHhKOUhJN3Nk?=
 =?utf-8?B?SUhBSzR5Z3hVTzZJNjd0RExJZkVWaEtwd1cxeTBTTm5zR0svZzdQOEU2Yy9j?=
 =?utf-8?B?Zm05OHUyd2dpbWJYYW14SGdYOXc1SlZtOUJwQnJxb3lCTXJRUUh1YTJSclE3?=
 =?utf-8?B?dkRLWGppUGgyVnp1bC8yM0xoQ2ZoWngwMWhPMGlJaDY3NFMvZE1JYlA5cCt4?=
 =?utf-8?B?eWtvVW9RVDM0NTdZdzZ0OEFTUHNVMnptSmhmZ0RxT1FxOVhFZlBRT2pwV2dS?=
 =?utf-8?B?S0YrMGlvUy9ybHRSRmJaaW1QTWdnYWRTaWhBb1RDVUVJVHhkWHlkS3g1c2RD?=
 =?utf-8?B?OE9wemdBekhScGhMTHBILzFGb2RLb0JpZUNaVU05UDc0TzZZR0FLNlIvNjZl?=
 =?utf-8?B?Nmg5VGY2RzIrY2NVN2FLNWVhSU1DNjQrNExnclVXRThEbmpwalhJalIwQ05l?=
 =?utf-8?B?SmdNTUxGRE15M1dHeU5RcFhtVWdWblh3UDJhZDZvaGI5N3RsamFnYzgwMjdo?=
 =?utf-8?B?Z3R1VEdYRFkzYkNWZW5PVnBtemVheVErUkthWlVTZGt0VlBad0pVT1gydlNl?=
 =?utf-8?B?UlJxQ3dSdU1PQjIzVGhjVE5FajQzMTczYmtkcXdpMyttZGFFRkVIQUFBaVRq?=
 =?utf-8?B?Z0piUlNpK3d5akNxZ0F5Q2xTcG1WajNvTmkxU1RtNXR6NjdFeDkwUkIxeUZp?=
 =?utf-8?B?aU9OTWZmNk5GWmROOE5ZamU5V1hMdGtBTWljcjZrSVE1S0JWTnNDZDM5ODN6?=
 =?utf-8?B?VTBsSzZzb0VRV0drKzJLMWFKKzUvNWV1ZjNJcVhvamJaTmMrZXBnRVRwYnVY?=
 =?utf-8?B?MjJHeDM1RDY3Q2ROM3pXODYrc0hHTmJIemZ4SHpyN3JEb0JYOHFaLzd0K0Zs?=
 =?utf-8?B?N2hUS1c2UFJpdUhGVkNFREszb1lTRE5KaUxSQk9IbmpCYjBiN1FBUkNpWnNO?=
 =?utf-8?B?bjRhK2JzZmh5TDU4OGZYQjhFVEhPdlN0WkVaSEhsUER2OGFlam5TaVJ2L2ZR?=
 =?utf-8?B?WmlpMHBlREpUSzdKTTBDc1paZVh6UEk2ZlQ4UjhYUFhEZGp0ZmJBYllQQnRn?=
 =?utf-8?B?UVlramh5RnViRlROWnBHcnVEVmFPR0RadkFjSWU3RXVuaXF1cnV1NkY5Nndz?=
 =?utf-8?B?dGVHTk1XMzYwU2FoemFXdkNJR1dHeXRLWlJnVDNXTTZHbGRvYlFkUzYySU5F?=
 =?utf-8?B?dlgvTWtMaHZvT2lTSWlLSlpralJUNFVtUXliL3JuRkpKQjNkZEF0WGlJS2lK?=
 =?utf-8?B?WTJjNFVSUVVMSnVqSThaYUQyWnhhQ2NPVHNYcC9rMHBheXp1U3JSSnl5Qi9a?=
 =?utf-8?B?TjMwWDdWZy9NYmNRV3VXbStiUnFhelJhTjFMOHczK3NJMFluOHlrL0I2K3g4?=
 =?utf-8?B?b1lQSE9FODJ0L0RSQUhnbGlhY1BXUjdnRDY3WUtkWTZWeEZxMUV4bzZvTzB3?=
 =?utf-8?B?Y0ZNQ1JyQUJwSDh4d2xaNXoxc1d5YUZ5VlVwYURLYjMrK1ZkTjAvWXFLQWta?=
 =?utf-8?B?ZEI0VW8yd0VWUHBWN1lMZC9NUDVFaTdtT01MdzE5TUxBSGIvT3UzVkZHVElz?=
 =?utf-8?B?d1g5bWZTL095bTBXWDNEbS9IMTExSEdhemtzNkhnellMeStpdkZ4MEhRRmdw?=
 =?utf-8?B?WVB5emQwOEVYV3dqTzAwWWFEZjh3VWY5bHU3YnB4UDNzdHZULzlmK0JocjNp?=
 =?utf-8?B?ODdNcVgvQzRROXA5Y3d1S3ZZZWtwSURwQ0Z1elY0aEQzWmp3RzMyeFJuNnNY?=
 =?utf-8?B?NG1HbW5GaUljdFJrdVRIMlJzME5TeGNzSzh5azFob3M2OEZNTnh5K2xteVRI?=
 =?utf-8?Q?ZZQquinrm5rPIZWogh2IWVTVa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3265eda0-2bd1-4d15-53e1-08de36183acb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 05:11:23.0842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ccPU421qvO1eKnpD7Pefg/WPjXA6XYjmUFt6arB0cx//eGr2PHLvDjX+9VxVFALD4zJXHLYERjPzN+tiWoZ6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7793

Hi,

On 12/5/2025 3:07 PM, å¼ åç Tio Zhang wrote:
> Thank you all for replying this!
> 
>> On 12/2/25 11:48 PM, Vasant Hegde wrote:
>>> Hi,
>>>
>>>
>>> On 12/3/2025 8:19 AM, 张元瀚 Tio Zhang wrote:
>>>>
>>>>
>>>>> 在 12/3/25 上午10:25，“Vasant Hegde”<vasant.hegde@amd.com <mailto:vasant.hegde@amd.com>> 写入:
>>>>
>>>>
>>>>> Hi,
>>>>
>>>>
>>>>
>>>>

.../...

>>>>
>>>>> You mean BUG_ON ?
>>>>
>>>> BUG_ON and the logic of "Also if fetch_pte() returns NULL then return from unmap_mapages()
>>>> instead of trying to continue to unmap remaining pages." :)
>>>
>>> That's because there is no point in continuing if some unmap fails.
>>>
>>> Wild guess, you may want to backport Commit  1e56310b40fd2e7 as well.
>>>
>>
>> FWIW, recommending this backport was my initial reaction when I read
>> that the BUG_ON() on iommu_v1_unmap_page() was being hit.
>>
> 
> From my crash dumps, when the last "fetch_pte()" called in "iommu_v1_unmap_page()"
> values of "level" are 3 or 4
> and "pte" is NULL.
> 
> I'll give a try on this backport.

Yes. Backport previously mentioned commit and test it out. It should fix the
problem.

> 
>> The original message suggests that the issue is easily reproducible ("my
>> machines"), so I wonder what kind of workload/setup can trigger this,
> 
> It's our production machines, about algorithm for self-driving.
> Like I said above, both (cpu/mem/net/disk-io) have some load but none of them is especially heavy.
> 
> It reproduced / 3 times on different machines / in total 100+ machines / in about 4 months
> One is in module "usb" and the other two are in module "nvme".
> 
>> because the race should be quite rare given that it would only happen
>> during a call to increase_address_space().
> 
> I'll edit then hook "increase_address_space()" in some of machines and find out its calling frequency
> in returns later.


If you backport patches then I don't think you need to edit this code path. It
should fix the issue for you. Since its 5.15.x kernel, you may have to manually
apply the patch.

-Vasant

