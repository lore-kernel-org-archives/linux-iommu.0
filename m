Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A000618EFD2
	for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 10:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724928706; cv=fail; b=P/582ifirvdwOcjaix7IZgVlDQF6Qs4oFUqxUVxM1F2lOAYIN8LGV2l3P9MkByzKndGftFoCvqx/hlnqKgzRbffMDXgpjeIU5vEJXS+jt3l9PzlGDCqcFUBQRI2FSF1BB6ePPKvKVYgZco7Ye7D4f2UkVBznTKsYTaPMktJ4DO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724928706; c=relaxed/simple;
	bh=p5k4o5YMjZ5Yc9J0RfaGR6TeNbAS4fUkiEVN1GEqZOo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SeV+BLOKDBOd1ib7PLsQ8SgZP1WzS8tKJW7Z5MVOhcw1vndxwtxzwdy+jl+ciQL0hKbjWvMd4qiReIz5fQjaCO8uyZ0GmMecrVfBwEhd4ECmNf9jEdOe6G8mqHNMeAyH39DM1SYcMaIM30qy38k8JsMpvwosSFDq081ckfbW5iY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yl2NYjfg; arc=fail smtp.client-ip=40.107.237.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yl2NYjfg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BAfVxJFd88mJEJOKCtFl1dr2wLHrc80KAP64kqQHoDKljO94f3iP6xKDzXGR3xID8v9279WzE3JhL6Z9z0JdouphfAamu7gnaYhyBQHhjkneOYXI4OOSC5esFlGi1wfWMgUJXv14mVS+QnI/gOU4BQ7jiGx/8zSHKFXxCoEvkZJO0PzUW15t9pa8mEzVlRW7FjmFO0oA9idEzrNvPDAQC9dRBdyFEq6xuImRsUpTIz+dNrBm3DXxl/KK1FFkd7sllWpMM9FOWX26n8tGdCbGuDhVbhgvBPDwT3R62YW3g82YM6dp7ca30eFGpMdZTA80KUH4n7V1NudJU1cRlreZZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2d4yfftWw8scSfj0+Wi6TIctjw3aSpzmIbZU+HnRJQ=;
 b=pgJN2MyqSn0q1qCcyvCWqSGxSR5Dl0A1Lvtw2LNHtuzwHFSsbAj5OacW5H1vhaOtm8sHNxvxn4OEBd3XjLt/4v9GeffVt8DFoG51f66t3B/PAC2Nm4E2xu5XK9IRnbpsHWW4Fc8nXgyhlyKwnqIXQfkmd+PhaZjeAnId5NDJcz5l/N2HSGNNFWvu+PAM3N6GoF/ZyTBzspDzFvcNPtYIDDJJH8imH3EztrEssPoqehj5Jw0nZEj84WlC0cP/tRlhItaCvUUvS2aTcjxTWau3zcoGVNLYB1Hfw/BTFZlCkVVzVt9bbfEh8XirjcV7jPWiBACgxB4VdhfrXAnvyDWfZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2d4yfftWw8scSfj0+Wi6TIctjw3aSpzmIbZU+HnRJQ=;
 b=yl2NYjfgrc31ZSXi6XoKIiJU7TQhWOxSgSPo87Q66k7k9eKoPukmS2tZFCULpiZRD8Z9SLd5oFsLmPTtu1eXTDRePeH8IVdAi5TRTKQWn8kSBS1oo4gNpWMWB5/Kz4WHjBzaJL9x0uavEqblmaf4tAq55gQq1Qay6YgBVHEoe7A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM3PR12MB9434.namprd12.prod.outlook.com (2603:10b6:0:4b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25; Thu, 29 Aug 2024 10:51:41 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 10:51:41 +0000
Message-ID: <6741bdcc-d9ca-4090-805b-3a7f4a4d650a@amd.com>
Date: Thu, 29 Aug 2024 16:21:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] iommu: Enhance domain allocation code to take
 additional flags
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Yi Liu <yi.l.liu@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 baolu.lu@linux.intel.com, kevin.tian@intel.com
References: <20240821133554.7405-1-vasant.hegde@amd.com>
 <20240821133554.7405-2-vasant.hegde@amd.com>
 <20240821163147.GZ3468552@ziepe.ca>
 <67436cba-3d05-4528-9519-231b8396ed51@intel.com>
 <20240822124433.GD3468552@ziepe.ca>
 <0ca31cc6-1741-40d1-b8c1-20e6b4fc955a@intel.com>
 <8215e4d4-2077-4fca-a002-27ddbfc0ddf2@amd.com>
 <20240828145224.2e949806@DESKTOP-0403QTC.>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240828145224.2e949806@DESKTOP-0403QTC.>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0032.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::22) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM3PR12MB9434:EE_
X-MS-Office365-Filtering-Correlation-Id: 69489982-1df9-4815-79f3-08dcc81890c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHV1Z2pseXU3dVJDMzNGcjFLQ2JCeHArUW15cWhsN3ZFcVFkeTBhYzBZbkpD?=
 =?utf-8?B?MGxYUlVEMENZV2h3WU1GZU96SVdWUXYvdHorWnpnTHRXQkk0VTBjMlFaQmxz?=
 =?utf-8?B?UWNtVlRpdzNwclBhb3lDTk9FSWYyemxwejN5RVZvcFFzUHo0ZldQNCt5UmVk?=
 =?utf-8?B?QmU4RnlkQ3RzQW5manFaWjRUOVB3dXg4Zm1WbDRxZWR6eHBHOHk2Y0pIUSs3?=
 =?utf-8?B?NUQvVjE0TlhocXZCWXpGK09HOURucTMrMGk0VHdRem02eS82bldETW1qSWVC?=
 =?utf-8?B?UWtjL0xnZnE5MkY2ckcyMmtQSkRXbTB3bXlnbk11M0MzUnFVVHdERHFMcGFN?=
 =?utf-8?B?RGRQTjlvR1plZlY3Y0Fack1laTczUGd1cTJ2QVAzbmtSVTFvekRtemtuSlVF?=
 =?utf-8?B?Sjl3R29OR0hrWjN6U2pSUVZPeG5iSi9UdzNnQXU2OUUzR2VCZSsyVXFPQ3p2?=
 =?utf-8?B?YzNIdHlYUjAwOGxSYXVxU2VuNmtlTmg1Y0FtMGdNbW9oSkd5VFIybGRhMEVw?=
 =?utf-8?B?RURMMVdub2E1Z2dJK3pBYjVrY2xsbjZwbWltTVVIcXRvVjF4Z0N4WW84a2VQ?=
 =?utf-8?B?VTNxOUpTUjBGR1pVUVdQR1kzVnIyQThxOHliVllaY3lFeG9Sb0VyOUNRdTRm?=
 =?utf-8?B?NWV1UUx0Y1Vxd0xRRzVtU0xUQitIS1JoRkg4TDhXaFB2bS9ycW1BdVM1YzZx?=
 =?utf-8?B?eGlNR1RTNTF5eVc5cXV2cmI1bjJON2poSXNZQktOdjFGRDVnWWtNYy9wN3Ay?=
 =?utf-8?B?cU5xenBLZ2ExREoyZ3JJdk9ZK0NjS002ZDR4ZzQ1R1FleUp1MmppdGMyRUR3?=
 =?utf-8?B?VzNQYkRpZU03bVB3UW9sNS9EYnlmSkdWYUZCNUVJdTh4SHpBSW50WjI4QWpj?=
 =?utf-8?B?czArMlZSRDRUc3RUYXg3dk5kTUlCZXZnc3ZXbkE4TnFCa1dVV2NYbjYyb280?=
 =?utf-8?B?M2hodHVIQXBFcHVGSFExME56bkZyTy96Q3ZRaXMzNHQ4OFEyTTJxbEloNnBO?=
 =?utf-8?B?Q3dFT0RNdFVmMm03S2lMZGxYSFAvWllUT2lMcXU1bnJkQlVKR3BtdXJxTlBp?=
 =?utf-8?B?MzNRUEpsOGg5VCtFd3BTdFQwdVRFTHBLc3BEbHJmcGppZ3pOWmJkVkxnM3g2?=
 =?utf-8?B?dVU4NGNFeTAvNTN2Rytmc0RoRWFaYTErOXpCbUJkNmt2bTRjMlRtNWRRVkk3?=
 =?utf-8?B?YWF4Z2JERGVlV01UWFl5ckxWL0Y5SjVoQldCS0t5VmtEbXBVK2VwSU1oOU1S?=
 =?utf-8?B?K0diR0Y1WmZJUXNnd1ppU3hlS0JNN09IMmJNTSt1amYyYlo3QVFSTStIdUhi?=
 =?utf-8?B?cHpDZ3NIRFlxWVpidWtBZDJaM0JuQzZISlYzVHRDbGhvVURxNVNNZzBIWDVT?=
 =?utf-8?B?K29uaUlXRlVJcDdLeWdjTVFySEVVbXRweElxSkZ5a29vZXhTL0gwaEptNVAz?=
 =?utf-8?B?b1NKMTkrU3pWV2dNY2krQ2w2WWYwOHNhZyt2bWhmREEwY0JnNmR3ZGhsN2lP?=
 =?utf-8?B?bGIyR1JibXk4ZHQraUFDN1ZkUUYreVNXZHpjWkRCR3B2WFRwakp4bnozaFFa?=
 =?utf-8?B?M3VzU09kdjkrd3BRTHlPb2h5dVkrd09wTy85U3BGNE5KY3d1MmhLYVFxbFUz?=
 =?utf-8?B?QlpCZms0c2x1bkVXSHZTSXY1VzBNR1E1TFR5UVFybWFwaTFLRXVpNU1YZUJ0?=
 =?utf-8?B?REV2Qks0TlBnaWJoVUo1RTlyb09LTUZhV01pWmRxOEw5cHRnOHZyOEpTWnVQ?=
 =?utf-8?B?SmNpeW9jSUtWalkwZmU3elJkQzFLVTVCaXVPZ2F3ZkNBN25zZ3BxOVRKbDRC?=
 =?utf-8?B?VVpSQktDZTIvN0pKWTZFUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZW9KNy9RSnlXV1Z6SGI3NUNpS0RWM2sxempSZ3IwajREeFVTS0tOSzIvMmp6?=
 =?utf-8?B?bUVBeTVTSHJsSmtISHpTTzZYWVRlU05qZFBsZlBZcnRMSEs2cE5tUVBtMDdW?=
 =?utf-8?B?d1p6QTJBZmg3MVdDTzVuYWVSazNVMk5wZHFpYzFHaU1NajZFdEM0OFM3SUor?=
 =?utf-8?B?QTlTOWdZZC9MSmtIak5wUDhISUxxOWhLTFFnN0crd0xYc2FaZlE4QU11ckI2?=
 =?utf-8?B?b3k2eDhjd1F3NU83ak5rRGVieW9zQmg2bGxuVkZ0WkcydUJsL1oxZnpidldB?=
 =?utf-8?B?YzJ0cEFsQlNSalVxRWJqWTBRbWFBYkk1aWZpNTBhR3RnTkNheS9iVm5IODR1?=
 =?utf-8?B?NHd2b3RTUU5wUDc5VEF0SFZsRU1KdjRuQnRzZktjU0lNTld3eXdSZVlwUjZr?=
 =?utf-8?B?bjViQ3VQUWdzT3hJTXl5dlcyUVhSTyt3SmVoNEpvc01RLzJVTlZ5T0hIQ1l2?=
 =?utf-8?B?VkJ6UGEvUk41UTl0RXRWK1VlTmE3SUJLMEhNY2c1cStxaWpJZDQ0T3dvTnUx?=
 =?utf-8?B?cklHUGdiMzVETkhVelZTU1FqMUdkRGw1R3RncDgzMGx1bmNVMW9XVXNlNzBM?=
 =?utf-8?B?cFRRMVZNRC9ubkRmT3lRSXFadUhiNEFrUXYwZFZ4dFBkVlUxV25TM1pNRFB4?=
 =?utf-8?B?T25iNE1kRHg2Z3NQMW9TdVNmMk1UUHB1UFJiKzJGcFgzVTNLcmR6UkJEV0x6?=
 =?utf-8?B?TExZYnlEL2w3WTh1OUR4OWM3MjBMWDFwL0h1MDZtN3pRNVRIcGRJNmtYN1Rx?=
 =?utf-8?B?d2tGN1BmZFdyaFdlNmlhQ1M3bDJsR0N2MGt6ZlNtZnlrMTJUcGR3N1V6V0N5?=
 =?utf-8?B?ZlNTZTh0NGpPY0VTT09zODFhUE1HcnJBV2t0R1FWeHFqa2ZTTHNnK1FWdE5D?=
 =?utf-8?B?T2ZOc2N4MzRxRXpHWXo3bjdMK0dZbUhCNVBkUXY4ZVdPNXNpR0lMcFJjMm9J?=
 =?utf-8?B?MkVUTkVUYzRURXVRamJxNnl4Tkx4VksvUVJpcjZaU3doQnRFcU02R3cxNG1n?=
 =?utf-8?B?T1piNzA1THdVcjNkQzlOTEFoeDFmRG9qMmtBQXhvMjhHN0t0YVNPNnVJTG00?=
 =?utf-8?B?aE9GQWx6NjI3T2ttZVV5bWRYalh2bUJPeDJtTzJ2VDZyR0thQkRscUVjclZv?=
 =?utf-8?B?U3dpV1ltbUN4YUJ2clYxaHhqeG9JRzFTOTZqaTM0MTdNY1FhbzU0Y1Y0c1Vy?=
 =?utf-8?B?Z29xTDdUaUtCVzRYRmIyN3ZvOEJMNHREa1ZGSTIxRThGK2F0OHhIN1V4ek5U?=
 =?utf-8?B?aWhXeUhZUTZWMlRrNlRubFFRNzFHdHdIVnpYKzBEY2dFY2VaRmJuT3NIMlc1?=
 =?utf-8?B?SktlV0RuQTNyMFlTK3BTR3NBVUlQTTFnVVIwQkZTSldnREhYUGdGVXlFZnJl?=
 =?utf-8?B?UjJ4WEdPUnVJeExnVFpBTUozSlNNb3Frc0UyZWowTXpRQVFBUlVBeTJFMmxH?=
 =?utf-8?B?QlJvV29xSFRvWkVINi9aSENJKzU2TUw0WEN0NkcrWjVLYzF3ZUNXYjJsNC9R?=
 =?utf-8?B?aGtSakVSQWRyVGx2YmFFRUpyemRnVUxQVm9iNXcyTDlzWkVmRWVFOFFRK3RW?=
 =?utf-8?B?VWZrakZ2dTh4VWowNVhHditycFlZZlJBZjQ1bGM5dXhWNUdkMHcvN3FhNTdj?=
 =?utf-8?B?SllEWEQ0cGlWREhyZFM0cmZrb3RIcCs2NTFQZmIzSDJzdTNNeHFyYUdCMDhL?=
 =?utf-8?B?M2huZitBSStFKzl3K3NQaEZ3NzV6ZXRwNjBqeHdPNkl1bklEOFdTek1aNUd6?=
 =?utf-8?B?bURicUxMOUpMMEhvellJZlI3eEZxQi8ybEdFYVh3bmw4dGJDUFFSZkV0OXU4?=
 =?utf-8?B?OS9VdFNTNGV6VUxJNlQ0NGE3SjJBeERTVm90R2hPNXB1dnVIQ09EL29maURo?=
 =?utf-8?B?aTdRb3c3RzFKN1V5Mm1QSUtqdzdpeU9aR004MjZRS1NpejFyUXo2Ym1oTTlQ?=
 =?utf-8?B?NVRJOEtzYmtySHNRV1VqYjhvREVaTVpXN1B2NFBCMDA4ZTF5V1BvYVR1SjVI?=
 =?utf-8?B?K2xHNDNHZEZzNXFUSWRIb2RlQ0hKRjh6dWNPZ25aNnQvQmNlQUZGSGwvbUpX?=
 =?utf-8?B?Y1gzSGJXQUVCelJERjFOOFNFSjhCUUhQVVoyQVNCWjVDYmsycFhiUmc0b0xs?=
 =?utf-8?Q?5oA8NBAbWtD6/EW8CInowOF5u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69489982-1df9-4815-79f3-08dcc81890c2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 10:51:41.6294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Efd2VM9b2jMrz3+bFm0R0hY3zymwBKI2hRY1cL29UVlLQHWxyx7ifYo4Yi/x1UE3ZNeWOjqvhvPw7icBH6N4ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9434

Hi Jacob,


On 8/29/2024 3:22 AM, Jacob Pan wrote:
> Hi Vasant,
> 
> On Sat, 24 Aug 2024 20:17:45 +0530
> Vasant Hegde <vasant.hegde@amd.com> wrote:
> 
>> Yi,
>>
>>
>> On 8/23/2024 2:28 PM, Yi Liu wrote:
>>> On 2024/8/22 20:44, Jason Gunthorpe wrote:  
>>>> On Thu, Aug 22, 2024 at 07:27:39PM +0800, Yi Liu wrote:  
>>>>> On 2024/8/22 00:31, Jason Gunthorpe wrote:
>>>>>  
>>>>>>> @@ -359,11 +359,17 @@ struct iommu_vfio_ioas {
>>>>>>>     *                                   enforced on device
>>>>>>> attachment
>>>>>>>     * @IOMMU_HWPT_FAULT_ID_VALID: The fault_id field of hwpt
>>>>>>> allocation data is
>>>>>>>     *                             valid.
>>>>>>> + * @IOMMUFD_HWPT_ALLOC_PASID: When the domain is used on a
>>>>>>> device, with no
>>>>>>> + *                            PASID, the device will support
>>>>>>> later attaching
>>>>>>> + *                            a PASID as well. Some HW
>>>>>>> requires a specific
>>>>>>> + *                            domain format on the device to
>>>>>>> allow PASID to
>>>>>>> + *                            work.  
>>>>>>
>>>>>> Maybe:
>>>>>>
>>>>>>    Requests a domain that can be used with PASID. The domain can
>>>>>> be attached to any PASID on the device. Any domain attached to
>>>>>> the non-PASID part of the device must also be flaged, otherwise
>>>>>> attaching a PASID will blocked.
>>>>>>
>>>>>> Yi will need to add a check that IOMMUFD_HWPT_ALLOC_PASID was
>>>>>> specified on the RID domain while processing attach on the PASID
>>>>>> domain.  
>>>>>
>>>>> this means if userspace wants to user pasid on a device, it
>>>>> should allocate hwpt with this flag, no matter the hwpt is going
>>>>> to be attached to RID or pasid. is it?  
>>>>  
>>>> Yes>>  
>>>>> I still have a confusion. Say on AMD, is it a legitimate
>>>>> configuration that the RID is attached to a domain that uses V1
>>>>> page table while pasid is attached to domains that use V2 page
>>>>> table? From architecture p.o.v., it seems allowed.  
>>>>
>>>> I think that is exactly what they have been saying their design
>>>> cannot do.  
>>>
>>> ok. I don't think Intel has this limitation. RID/PASID is free to
>>> use s1 or s2 format page table. So such enforcement is nop on Intel
>>> platform. 
>>>>
>>>> If you want to use PASID you must install a GCR3 table full of V2
>>>> tables. Doing this denies use of the V1 format for anything except
>>>> a NESTING_PARENT.  
>>>
>>> thanks for the explanation. So if pasid is to be used, amd iommu
>>> driver just programs the GCR3 tables and the request without pasid
>>> would use the v2 page table installed at pasid#0. It does not use
>>> the DTE->host_page_table at all. I remember the
>>> DTE->host_page_table uses v1 format.  
>>
>>
>> Right. Only V2 page table supports PASID. So when user space requests
>> hwpt with PASID AMD driver will allocate V2 page table with GCR3
>> setup and updated DTE. So it can handle attaching Device ID (uses
>> PASID#0) and PASID (as GCR3 table is already setup).
>>
>> Note that when we use NESTED page table it will have both v1 (L2 /
>> stage 2 level) and v2 page table (L1 / stage 1 level). Even in this
>> setup V2 page table inside guest can support PASID.
>>
> Sorry I am still confused. So V2 can support both PASID and no PASID
> (untagged DMA). For the nested case, if the guest wants to allocate
> a UNMANAGED domain, would you use V1? If this code in [3/5] below runs
> in the guest:

In nested scenario, Guest will always use V2 page table (and host will use V1
page table).


> 
> static struct iommu_domain *amd_iommu_domain_alloc(unsigned int type)
> 
> 	/*
> 	 * Force IOMMU v1 page table when allocating
> 	 * domain for pass-through devices.
> 	 */
> 	if (type == IOMMU_DOMAIN_UNMANAGED)
> 		pgtable = AMD_IOMMU_V1;
> 
> Hardware-wise, in nested case, can V1 be used in L1/S1 for DMA w/o
> PASID?

Actually no. L1 (Guest) will use V2 page table. I am also implementing
domain_alloc_paging()... I believe that should be sufficient. If something is
still missing we should address that as part of nested support.


-Vasant
