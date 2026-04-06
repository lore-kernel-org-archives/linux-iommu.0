Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011064.outbound.protection.outlook.com [52.101.52.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7756B175A85
	for <iommu@lists.linux.dev>; Mon,  6 Apr 2026 03:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775447346; cv=fail; b=d3aBTfr5Ww9g9t8e749oj9jz7NjvLTxKea2I9ROReIUjrM2c6i7TznjcYZbhWzCd/qN5CTmAiRMP2THWtZtVXuhDp36a/9jfXCwmQhWD84K0zLVJqQU4hRO8jhlWuFsLjBcTvauTVLRl5ABAZQFllDE9l0Xoj7Q6OHewVEJ0gLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775447346; c=relaxed/simple;
	bh=WWcHHzPb4kOb/zuS2+nmhmSgfUBDxgTA8I8ds5tpkHs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=amJT6PxznXlN2LxbcVBsmW8u3+MrATUfk7io5QgcidvE3FtJUtnyndjX719kQ/EKatI/N8TXku1ABxSn9vSFvdYSBE6DocbadjzvbV9JN4Xh+CagbrgH1WvFn5XJEs/gbrHAEAu1TzKyd7E0Jo4ONpYXBHVnDrevuBcqHWyQcnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M3vGeUkI; arc=fail smtp.client-ip=52.101.52.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M3vGeUkI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y3u/hDhzRVf7Me+dK2BSI4Jd7aGfWHV4CjSrZeGR/0DgCaU7DF4436ahHuBbk4Moi0PO62vZ+G96CjAuERq9tbU4I4+qXQyXQOz9pW30Qy2rgDQ9TFKZVAht9TjBisH6YfJktrFdjn0dFbhh828usz0xXnC6kD8nQrC0b+LpN1JMn3yfMc2jK9YNZAdwGY3uAx0NqGsdkspBcKv/m2h7fPXA9M90KwJS/0bMvlU8jziGzs8WhQ+QnIVKKtwYJg1+wPeyRKXg3CW8Ia+47O7BQ/mDJY4XSqrBDxIhlXudCG0ZkX3YlksZ43jSg4dK5Sr8UbNrmDZEm5bHMwNaKZ0d3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJx7+MCc44huc1Kb8knryeG+/hOChId2TCiKRA6aay0=;
 b=p1LFFHqeuv1q4Y8hkCRT2mxhOVafUruKjUsUGGAetVKou4lPmRSSUtxoGGVPJxM6JE5khVKb0aW4F7s/1CNFQpODYZA8fojl5Mzz1T8vxAcCd/iZr/4V4PTUIyEf/ezUJa0ve9eAzWY6h5wHdY2O6zqXqZcbpdj7QkAQ9d5WS3h73Am1t/m3kpp2fHZiD0GiNDpHg3QkGcloU858g1PSOXo2gvW1E65VISY49ZYz5oPZTwjWv8CEJBxoHhAgLK0hze3/jWGt1tHwbYOC90T+P7Kbq3CnIWpjOWkF3MeUnf0CFl6ke+malG7Tp9TcYdyUH6rtcVq86nQan1Eg+tLt4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJx7+MCc44huc1Kb8knryeG+/hOChId2TCiKRA6aay0=;
 b=M3vGeUkIOvOIQyABIAsbyC1Ahd5OBr8iud31COHr8J+Sbl6CwdLIf/WWoEezZjae8dtIHj9nmCu25DYjnT7gpNB2a43zMMWb8rBnCY9alBcJxRW70GdAsO3/ybczqUF04aPYkIDYue87P83PSMa5yneaU6a4B4mcOCh8SuNsmKo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 LV3PR12MB9213.namprd12.prod.outlook.com (2603:10b6:408:1a6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Mon, 6 Apr
 2026 03:49:01 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b5e5:12ea:9815:b7d4]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b5e5:12ea:9815:b7d4%7]) with mapi id 15.20.9769.018; Mon, 6 Apr 2026
 03:49:01 +0000
Message-ID: <f31e2d60-046b-402d-b99b-ce7481a469f3@amd.com>
Date: Mon, 6 Apr 2026 10:48:51 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/22] iommu/amd: Introduce domain for IOMMU Private
 Address (IPA) region
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
 wnliu@google.com, dantuluris@google.com, chriscli@google.com,
 kpsingh@google.com
References: <20260330084206.9251-1-suravee.suthikulpanit@amd.com>
 <20260330084206.9251-10-suravee.suthikulpanit@amd.com>
 <20260330122012.GG310919@nvidia.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20260330122012.GG310919@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|LV3PR12MB9213:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eaf7290-e4d3-4f0c-33d8-08de938f7081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	2a5XDspZnB8aoLUulRfTeOpCqbY5HHmWxbEXQwE1WpKoTIkltstN+XJow4mTqjz7CWhp/8lQfGaT4SYC0gu73A7W1bAf4nUWtIbrAGtaWbaaJP0uZUhXyFD95Dyc0hEmpURmwJIWcCNI10rbWGZ7zURi9SGDbCVS7ywPhgNxRkT6JZuWWgRS5jfpNjW/njyuhjHXv9XDdQxlCdkb8uG4mSCM6fJmM9hWUTewy2sfhUijERcn22nmL9k+jo6nji1rPoMtJyDxrYhd9WDBOwcix4qU1himrAJhlraC1y2VZ+Mjsy75rH8ZOpTRe9ko4HpnyBtxH5qrTw7dPbaBiVfgxJNMvTmJuoM/u2Kr9dbJg5fglZ2ymJm7GNDfPJggy2wvynE4UWM4HijnAS1+3yt9uWz/ttdOAAaYb7cBIN4qhGwlA9fgj2q4E2SeadhEULwL2YhDTyEdcmecKeDO7FuWIti4rt6dPfXEwSzfoK+tqFtHLpS8UTEvAH7hzvCnLtR8eN120gpj/7uuumN6M8bW4jit/jVditWve3vCsfvgdEuRT1Goe+Yjqwd0sNEfmn6YkNW5Uk2ieEva8xQvZlizJxAulDX2e01DgKgQG2OuibAWZ0Opcf2CAzX29mFlB0BNx/tbIdNBVuoe4pCALi2ymYIL9l68nT1jqHuZzRV/Li9SoUkR92equsSHKvLZhJzeqyKUfRdaTmmoHwoFm31Q5Dle/iiTHzRBbtyd1Urz6WM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXFUeit5bTVNN2lyaDk4eTdDd0xlM0NiTEd6WmF6cWhJYXoxUWg5K0JVMUw1?=
 =?utf-8?B?NjQ2VERYUE1LaFhKdFJTSVRCYXFpWDRpTjRCRm9zQkJMVDlWVmJCTktMWHg0?=
 =?utf-8?B?bGZ0SEtEaFREOWF2N0pYZFR5bTRNYmxhZG84eG5JU0xpaUVBSnJxVXdNUXNk?=
 =?utf-8?B?TnVaVmNrZXRESDdyWnorbGVqS1RyVWVQSGh5ZWNsc25YQjUyVnFLa1JDeHlL?=
 =?utf-8?B?eVZ0UWFNUWViVlY1RlVxYmNmV1ZnaGZjcEh5SEt3cTVFQUI4bHJkOFpPWVRR?=
 =?utf-8?B?U1M3M2pJVnI0WlVsYklydTFwWVF2cmd6akE5cURGRGV0SUplQXFVamx4ZC9K?=
 =?utf-8?B?Y0lFY1ppd3pWMTlSTytBV1FPNG9lVWRGQ2x2TklvOGpRVkV1dWsxbzMxT1hq?=
 =?utf-8?B?QlhDNlExcHFNMGpSY0YzN2JKVnRoRjdkdkFscHc3dVhLM3g0OUxEd2x0ekZN?=
 =?utf-8?B?ZkJYbDY0bHNKYjNtUVNXUEhweVMxeGJYYXdUQThNR0EvMjN1ZFpVWG04Y3dT?=
 =?utf-8?B?UGFoN0M4QktsS05MZWF3SjQ0Q2xUVXFKYzREdkR5NVk4a3YxV0l0Um0zUDdT?=
 =?utf-8?B?b3ZxT3JDQkdnTXRYckl6SEs0elVOMURsbkJLREZGd3BhejNHVjB6VWFVVUpQ?=
 =?utf-8?B?Ykt3Wm1GajVYTmFEeTVCRVJocmZTcmlUbUR4d0ExeUJ0Uk5jZGpxdGZoYk1I?=
 =?utf-8?B?SmpuU0ViS3loMjZpbktYRC9iWXNBM2NNWDkraHlKbjZES1pMWTR6Q1RleXZY?=
 =?utf-8?B?Mk1NWWtISGhmN0JCUFVSWG4weW9pajIyOExQMVcra0hFbGFGbmpZMmJzK0VQ?=
 =?utf-8?B?Qm9YS1luSWNnemRUNUlMNXA1UERYVVZPSHBPNDNFNHQvUVFQZFdXUmNDRW5J?=
 =?utf-8?B?T0M2VkZraHNHS2JoZ2x5RDZENldUQ3pCUG83a2Q1b0tpQTV1bi93YllsSG1G?=
 =?utf-8?B?b2NtbzNQUXRrQUZjZDB3VngxRXUzUzFLUGozOFF0eS91alZ1S28vNUhDT0gr?=
 =?utf-8?B?L1FRUVUxaGNhQ0RXZzVYYmNOcTFCZzVWZE5zL1ZLM0VqUzJXbGo0WHFhMy9V?=
 =?utf-8?B?VUNwemRhcm1BeC9SeG9JSGRiL0JSVForMVpCdGVoak02WjhwMVRSVEIwQUdO?=
 =?utf-8?B?UW9zSGh1d2MwSHBKVzFHRmx6WlN0ZUZjM0VmLzJuQ2luazVyQWFpWXV1RGVD?=
 =?utf-8?B?UCtFc3BUVzBLSWRHTFpCc3dKYVVQYTZ3cVhScm4ya2g1YmZWUG5nbHRSMjNC?=
 =?utf-8?B?REpXQ1NEZTIySE5TdVA1dCtWSFFnMjJGVGZEWmNETUM3d2FQb2k3UmlJYnl4?=
 =?utf-8?B?aHYwdHNwMnZWTUZtemhoVkkxMnJJbTd1WU9qRllPaDQxT2czcEpldHBDcjE4?=
 =?utf-8?B?cm5neXlyRG1nRzBMZkZpNGk2bTZUUHVjcnEzRmpXQkdYSzFVUzErOGRmWkth?=
 =?utf-8?B?RkplYkJZRFBualVRbEQ1SFdoOWJjWE9vUXYvNGkrdHlzVjgwUzJwSHo2R3Ew?=
 =?utf-8?B?MTB1d1pMd1pSYmJvN0s1UE12ZXpPZ0xCejFwei85cUxPazVxSXdlb2JDZUEw?=
 =?utf-8?B?UU1lbVY2MEFNck9UelRNeTArbUxReDRxMDhZc0RSb05mTnpIU2UxeDVaVHFR?=
 =?utf-8?B?QlFJVGNhQmNiamFSWGlhZlgzRDZaeU80SldwTmUwbFBGWFdaOTNySmRUNE5S?=
 =?utf-8?B?WU5yVVFwTG00Z2hWeEx5ZlZEUXhSUTZQQUVPMmk1TTNENmVXUlZxN3FManQy?=
 =?utf-8?B?bW1kUVQ4M2dUeWQ4dVNNUDkzZzRvZGM2ZUphVURLdU4vaUJlRDAwNk90K055?=
 =?utf-8?B?MVV5Sk4wMXd1eEllUE1wd29uNGc5a3hQZEpRb2F3emdLUGJ1NmpWWXdQcFZZ?=
 =?utf-8?B?UDZzalV2L3hDNDhTZTAxYXJUcmxtMFFRM21TM1pLOVQzWDl5aHNQdHVlNDdi?=
 =?utf-8?B?V0h3Z29TTWZBcDl1cUJTWm5NODlVMWJhMkVIZHBKejJLbTJyN0NqaWRPL2xx?=
 =?utf-8?B?L2x1MlFlU2JhY1EvRnpSMjVIVm9lMmFjRWozSVdtRWJ5YUpkZk5EWXFSNXh6?=
 =?utf-8?B?TlZNN1hLS3VUL0JyMGhDQzZub0ljbjFZamNRdTQxbzdDK3VXZnlRemRocTBE?=
 =?utf-8?B?YktZQlJuc2pKK1VLMUEzUE1UU3hVSW56VExDMnlDeFVTN2tDR1ZBNlY0dEE1?=
 =?utf-8?B?c3p2RDV2ZzBjTWU0eENKZmh0eC9JaDh4TEFxbzl2QnROV001dWpMNXk0ZzVH?=
 =?utf-8?B?RFU2MHJ0YS9iem9zdDVtcXp3RFBvR1UyNnpyNFU4dFZhaVVQQUY1aHIrL1Nx?=
 =?utf-8?B?TFR5ZjdYQyt1THg1OWd0aXJSR2dXaVQwS3NyaFRxbnAyR2pUWFA4dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eaf7290-e4d3-4f0c-33d8-08de938f7081
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 03:49:01.3899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AAf6iES4/HAdHQTFRisbcoyhs/xGmMAwqJLIFD1QWPfPkrPSHshIOdVX2cpUP2c3YyWlxvsWQ5ArUiglyDPoIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9213



On 3/30/2026 7:20 PM, Jason Gunthorpe wrote:
> On Mon, Mar 30, 2026 at 08:41:53AM +0000, Suravee Suthikulpanit wrote:
>> AMD vIOMMU introduces the IOMMU Private Address (IPA) region, which is
>> used to manage data structures necessary for IOMMU virtualization within
>> the guest.
>>
>> Introduce a new domain specifically for IPA region for each IOMMU, which
>> is stored in struct amd_iommu.viommu_pdom. This domain uses AMD IOMMU v1
>> page table.
> 
> Why can't you use a normal v1 domain with all the normal existing code?
> 
> Afaict it is not special at all other than it has a specific dte index?
> 
> Jason

Actually, this is quite different from the normal GPA->SPA, but rather 
IPA->SPA (for case GstBufferTRPMode=1). It is used specifically for vIOMMU.

The current mapping is:

IOMMU General Backing Storatge: IPA = 0x0 - 0x80_0000 (8MB)
Domain ID Mapping Table: IPA = 0x10_0000_0000 - 0x1F_FFFF_FFFF (64GB)
Device ID Mapping Table: IPA = 0x20_0000_0000 - 0x27_FFFF_FFFF (32GB)

The v1 table containing this mapping is programmed onto the Device Table 
Entry index of the IOMMU device ID.

Thanks,
Suravee



