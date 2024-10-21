Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C590C1E7C12
	for <iommu@lists.linux.dev>; Mon, 21 Oct 2024 10:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504972; cv=fail; b=YJSICrjbeyomK8n5LRPbaE67timQoGrdQ0jh2xg4sq0ILFecfyrKuFcbhl+RHK8/H2KRnDJK5dk1XEfyvv/jLgDFcCcKsvXDv7cUmsnm1KgSFFd1LixTk+zCxXi46tS0WU8rGh8YBWWLYebl8t/T0f+VGxDIAoiGqZc7TL30AfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504972; c=relaxed/simple;
	bh=4ZOZJ4q7Dp7YOXhvWZuwOOBOoEgLG+PPvhHq3LMAHq8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UJLEgMIxJlS9RKN9Ux/V2TVbsNJlCfPEMP0e6lvB1qepZdz7kBKVA9t1jMOUi7alrSEX14I364woxlOJr7qavHoZx7lvnavfapR1M8klhtLBUgUmFLP3J/xu2/9ee2IdAzdh6eKXvOG8L8I9ON8ot4ILPZLg2nzqiEshMGPZhlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OfzMbk/5; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OfzMbk/5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VOOV46ERoPHH/SCBqUaofQTIYa5xn9S180Hba+it5U559JN9tkDnrObrfDogSTk2LIlWksuiZzLL6ujKf0UCjfR4FgvzWE5pDSxuqwF25hN/YgScQzH3vcI8K9nPsEZ3OmOzT4UXsQk0cEIMRS07bE6b34+t6N3qCfCHLhEQ6vGVIwfPuUHi/nJZnSTGyVK7o7x4QCejWfxUVmhEfiEo21/HKja14LsnnkY3lbdsC+TFJiYinCMZK+E4hkq6SLg+QUkJArCPp3bv0bXaRCx5NAhziPjxoxavpyvkbgcD+6MRr3cksLHLDl1TpB3V4h1rDRZzouJw30eC6DUVhVZs1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sE5d+rcXCskKzHLfdzVsQWBlJI8Tkb3yEx+UtzJtShQ=;
 b=iLzc02iRXfjSL9sXOSzETGp3WfexCseupLfhbNeLi1G3W9ZLyTPrMTsdw7CpOVr26SZjQPj/0Bj8VT384LVb6vWW09dITOGKBxxL6/HUozvGYraWbSSlVuJXJGWSZdcBJaPX691SNgfo46Ve3ICyW9aSKbW5xW1iR2SBoTVSLHQFABin8Q2X+Dtujg0P2qwZeY5kpuQvxiDbJZhdAZkYtT82rxaoBiEhyi8RgUcHTAT8BQ+fADeWWfBcuzxk2VsQXv1oAqywWxilcd4oVZ/aCe2hjfhbY+6FODrffrSlT04GpE2bd9pPh2LqgkQ0QsUdNUtNfPapf9tPzY0J4dYEZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sE5d+rcXCskKzHLfdzVsQWBlJI8Tkb3yEx+UtzJtShQ=;
 b=OfzMbk/5raZF/zNmw+nU88FHwSlnBrVqqqWMQxJTrWEGrPTp0Cvon3n8BxaHvIO5EV57mXFkDB0tfxib1t8Ri/vR2QnHR/hQ9BULWVXzQl8A1AF1AHcmxBtN0QkOkJZOmFqQKNusmpdz9hq91PUIPEetEa+nkI/74yYDTZz8PIQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH7PR12MB6419.namprd12.prod.outlook.com (2603:10b6:510:1fd::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.28; Mon, 21 Oct 2024 10:02:48 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 10:02:47 +0000
Message-ID: <1ab6d727-d917-4f2f-be61-2487744a69a2@amd.com>
Date: Mon, 21 Oct 2024 15:32:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/12] iommu: Add new flag to explictly request PASID
 capable domain
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com, yi.l.liu@intel.com,
 baolu.lu@linux.intel.com, kevin.tian@intel.com, jacob.pan@linux.microsoft.com
References: <20241017140137.6028-1-vasant.hegde@amd.com>
 <20241017140137.6028-4-vasant.hegde@amd.com>
 <20241018141606.GG948948@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20241018141606.GG948948@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0080.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::25) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH7PR12MB6419:EE_
X-MS-Office365-Filtering-Correlation-Id: d1b54936-2cc1-4f75-dbdc-08dcf1b783e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmJuWVhMNEdacVp3ZXk2RVdFWU82TW9BSmQrVnBSVVNBUVcwbzN6dWsxRnM5?=
 =?utf-8?B?UjF1bmQ5dTNQSUp3dk0zQ2lyYkIxcElxYVBNQmF1dE9iblFRWEVDVEI3b2J1?=
 =?utf-8?B?a0twV0VEdDNYcTdsOEVjQ0ozTmFNYkhQY2ZQcWgzckYzQ2xzd2RhcVZkNHoy?=
 =?utf-8?B?cUlNUGRXU0dXL0QvZjBJZEJsWGZpbW1kcVhoOEZpRndhWkYyc1FEWWcwMWlT?=
 =?utf-8?B?akxDSkllakt6UmdkMGlSd2VHOE56bG8xSjdZSTRtU0s5ejRFNkwyVGhsMVdI?=
 =?utf-8?B?a0M0ZnBYelRWNktYbmtRR1N5bTNjUTJQT1BQS1hDRkVMU0x3VU5IOTBYTERI?=
 =?utf-8?B?Y1YxV2pwK0JoZ1d6WTVQM3lna1VxOTN6cE5pZTBvRWk1dUY2aTF1WWNqV1BB?=
 =?utf-8?B?VDBGMVdyNmpFb2lJdXFEbWJIdFpPckYzd0ZkZ2RTZFJ1eVJxTTBnakxIaldh?=
 =?utf-8?B?Z1dDMi9pRXpCQnFWTzlXU1F1OWR1bFcycGF4WmJ4elJUR1dkWklvaDRKRlBm?=
 =?utf-8?B?QnpFcnNNci9KTXZwU0hwZUs4Y0N6SW56WWpneGNyU1VIblY2d0xONUd4VSti?=
 =?utf-8?B?WDd0Y3hqZnNlUHA1KzFXR0lFTTVPcHdIck9KY3l5WGQwWkRoS2NuaUliMFFl?=
 =?utf-8?B?dHp6bCtIRHhQMnl0YmxOd2RydlhLN21rSGQ0Tm5tSG55ZHFVOWlYT2VsZW5J?=
 =?utf-8?B?V0FDNHhjeWtaNGRRcngvL0FRMEt2c0x1MFJMRDl2QWQ0THArUzRnOXl3cSth?=
 =?utf-8?B?bFFYYk1qaHNyM0lidE80dlcvaVNCT2RVOURRZjVtRXlqS0tIeWNLN0wyUitP?=
 =?utf-8?B?OFBTc29GZm1ZWlBxQ1BKRFVOUlBwSEIvbjYxK0p3ZUg4Ui92UWlPb3lML2Vs?=
 =?utf-8?B?VktybFFNVGRseCt5b2hRNDR5N29RNjRFVDE5ZFN1NWkxMk1PUmZXVk1FWWVo?=
 =?utf-8?B?OEFrZTVjWi9rbmYzcTRBMk01MktkN3FyanFRTTV6UWVIRGc5enpld0EwVFFG?=
 =?utf-8?B?U0RVQXdBNGZURjF0T2R3czVXazArWlBUci95c2RmeUNNbC9VS0ZmcTFnV3pW?=
 =?utf-8?B?OXQ5WWtndFQvN3pRVTZOTzdtd3BtYjJ5YXdMQzdnV3d3Qlg3UWRsWjVzQkZW?=
 =?utf-8?B?NkZ3SUFSR1lBajlpOHVOU0c1ZWZTQjVVSlJHL1BkVUtUMGUrV3NNSWg0VzVn?=
 =?utf-8?B?QUphV3BuMUlPQWlUL0VraDRSV2ZKa3dIaDFYZDFiQTFFUFlDblJETUNVeTFz?=
 =?utf-8?B?OENrVk84aFhwV2UyUDR0ZUcxL2JBV3p1Y1REVXFXUXdIWkJyQnAyTVJxKzJB?=
 =?utf-8?B?QUdXY1hPRFFXWWpKR2pqbGV6YVBGYlcvMkk1eTdJby9pTHNzL0tSTUVZZHdq?=
 =?utf-8?B?QTJMT0IxT3A4eVlNVkY1cUZONklKSFN6N0J1bGpxdXBlWDNsVHZLK0paQW5j?=
 =?utf-8?B?dHpFZU1BNEd0dzlZS0hJOU9tSVFuMEQybmFndEs1ck8zNHZLLzN6a1p5bHNW?=
 =?utf-8?B?Q2xCMEZXR3JDM0Fvd1JXVEZqVEloY2Uzcm4xbE9MZjBWdnBCTHZWZXB4SU10?=
 =?utf-8?B?eGU3OHViM3ZsSW9TVXBRbmlDeGVzL3BtQnlsRFkzcVJHUmtPQlRiVTVjdWNi?=
 =?utf-8?B?SVFRaS9DUnYrSjBPQUZOMTFqTHhTZkRrZ0tPYlZnVGYrVWxHNDlUNjNIQitl?=
 =?utf-8?B?WnBUY09DMENFcjlrMjA5SzgyaFdhcXFwUW5iR3I3cHRpNkpGS0dzNW93dDh3?=
 =?utf-8?Q?sz1cMfKj0Id1T2Zw9ZOMXezIH15GI0OynrHjzHq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2JQQStkcTZqRVhYam80UUxvYjliWUdDaFo3TUVJeWxObXlwYm9MOVRUSEJR?=
 =?utf-8?B?UFNjazAwOUt6VWJhMEtQc0l6V25Ya2ZBZnZrU0pVekZQRUgrRGZWb0krTjho?=
 =?utf-8?B?RmpleDE2b2cwenVnNjZ1TWlyRTNwTnI5VEFxZWtjUjltbnJOZDFJSUowV1Jw?=
 =?utf-8?B?ci81WlZmNXZIczMzT3VqWk1uTGlSS1M3ZzFyR3A1eUQ5R3hHNyt2R0VqQ0FC?=
 =?utf-8?B?QUNSbDdsajdjNVZXSXZlbHcrTWhHaUN5L0lpaUp5T29KdFBQME5EMDRUdWFO?=
 =?utf-8?B?TklyRytUYU9MQ0FwRml1MjNMWWZsclFFN0MwSEdoV0ZXbUx4STlsUUdML1Jl?=
 =?utf-8?B?ZmY2RUhrTE8xNUhreFF1SnJGRmNJUVhOV25nTkdFZ3VsazBDbFFuWXB0ZGtv?=
 =?utf-8?B?K2t2Nlo5ekJYa0pWYXBMK2JONWdkMEhGZndjU2tFbm1YaHJTbnBYMjdKVlAz?=
 =?utf-8?B?N2ZiSjREOXBHRHd2Z09mdXd2eVBjR1RBTnJrRlZoNUU0WDJLK3diR0VSdndO?=
 =?utf-8?B?NUk1ei9qa2FiYlViNE1lbzcwaFpaUkd1N2lac1lvcTByWDR5cXhybmp6akxP?=
 =?utf-8?B?VFlSOFUxUTB0aWhNNWwvMStyOHBsZTRLUTNTL1BVZjJSaUlhZHE2RHRMNVIx?=
 =?utf-8?B?U2JRbjlScXVudTlWc2tmWWtMOTQ5SWo3cmY1VngxalQ4V28rRmxnZGFzekZG?=
 =?utf-8?B?S0pDNDdEZ2hicENYZlF6S3JtdmtTM3FBUXl5bGVNVXhqRUUxM3VQNjk4QVgz?=
 =?utf-8?B?VElzZkpBZmVLTEtPZ0tIQkJweERxeTNINktJRWNGSm8ydFRHSlB0T294YnVI?=
 =?utf-8?B?RkhRMm1sTk5jQ1cvMVd4SnFGYmtaL2UxRTV3V29oN3pWUkJ2TEpNVGtsVnJt?=
 =?utf-8?B?enU4Z2xmckRENEZySG80WHVxWUdLcHJTQTNUb2JZUWRSekdzQkRNTklkSnRK?=
 =?utf-8?B?dmY1VENLTUdKR21QemRFNG5Ed1ZyTVJLejR0QW91WWJqWndWWXlMQ1UrWDJz?=
 =?utf-8?B?NSt4TUN6QkREM0hGMXRnZjdFYUtqTDQzUXNFWjRJVGhoMkRkREllK2hGb08r?=
 =?utf-8?B?TWJyZkdURCtGTXYrcE95RjVWZ2MzNFJ4dHZpVnY5TXl5UEc1Y3lxeE94L1Nv?=
 =?utf-8?B?ejhZWU9zMDlYZmtmaUZTaHR2YUVsV3lEMHZnTkwweHNHbWk3T00zSHhkNWl4?=
 =?utf-8?B?QnRJbTVRYUJhV001QmVuVjkwZ09nU1I4WGp5eVgyaFBGU2pBcmFqTUVaQmpG?=
 =?utf-8?B?b28ySDlKV0hwc2VIa3pjVGpnVU5YUTdKeWxyamdRVTVES0tBWDVIZWZsSUJP?=
 =?utf-8?B?OXdTY2FQYnU4Wjg4bVpCa2ZQSWdmUW1QSlpUOVFMRzk2bEFJUHRCTGNiMlIy?=
 =?utf-8?B?NUtVYWoxNXpDR0NVWDJMTjdwY2xKYWVPKzVtK2RlRTJzQnFCcjU0SUtEOVV1?=
 =?utf-8?B?YXhJblZldG82VmRhbVVGRnhUbWlpZTkxTjlSNTRvTzNvRDhVcVZRelhqQWs5?=
 =?utf-8?B?aHRmY3JYK0dieFo2US9OUGN2R0ZQbGkyMzRrTTMzNUkxSFFoaGJNM21oRUtP?=
 =?utf-8?B?bEc4bVFVMHZ4MFA2N2toR2t0UXkzOHptN1BVMUJCeUdSbDR0MkVaMDc2Tkgy?=
 =?utf-8?B?SEFhYXYvWmw4aWRzb09tZm5WbHVmUi9ieVY1RUFEcWNmOU81alVIdFh1Y2lw?=
 =?utf-8?B?U1J3ZHROODlmcG5BVGptZ3ZtSW5ncGdoTVk0WmVEK2pNMnFkMUNGM1d4NktH?=
 =?utf-8?B?OXNnemllL2FEaUlyRXRDR1F0eXk3Y3JHaDNpR0FDb2paWStKSzE0QnVWSU9p?=
 =?utf-8?B?T3JZcTY3bDI1NUI3R256ejI1aWxncDNrNG4vVDA3L05KL3JMV1g5RGhmZXB6?=
 =?utf-8?B?T0xBSEhIMTlSZ2lScVMrbEQ0ZDJtUTBaa003Sk44aW5obzBDbzJKTFc2bzg0?=
 =?utf-8?B?Z3hSNXhHek1iMmNRbkNNTFNaVVJJYStzN2h1MUdZQ1owcTFYU29DRkVVUWpp?=
 =?utf-8?B?WjMrMTBaeDBZVDIxc0oxMjF3NjJtRUJjYXh4amV0WDdBYzVwa1hjM3pnOWkz?=
 =?utf-8?B?bFdNY1J2TEd6Mk1mbHN3L0ZCYmMxRUZKYmxjMFJTcjlJVjlVdWlyOVdoOU9W?=
 =?utf-8?Q?81/4O20mfaIIEAhBoGn1mJOio?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b54936-2cc1-4f75-dbdc-08dcf1b783e0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 10:02:47.6977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cb+w7z3H4qpo4geRFEb8X1Aw6F7DGbfUqRMpMXmAqrVacq52qGvHAiUtjKjHsYrVnGpI5qqg1rXu/PIINupG1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6419

Jason,


On 10/18/2024 7:46 PM, Jason Gunthorpe wrote:
> On Thu, Oct 17, 2024 at 02:01:28PM +0000, Vasant Hegde wrote:
>> From: Jason Gunthorpe <jgg@ziepe.ca>
>>
>> Introduce new flag (IOMMU_HWPT_ALLOC_PASID) to domain_alloc_users() ops.
>> If both IOMMU and device supports PASID it will allocate domain.
>> Otherwise return error.
> 
> Do we want the "and device" language here?

Yeah. Forgot to update the description. I have dropped "and device" part.

Based on discussion in cover letter thread, expectation is if driver doesn't
support PASID it will return -EOPNOTSUPP.

In DMA-API mode core will check for above error and requests driver to allocate
domain without `flags`

> 
> I guess we need to decide and make it consistent.
> 
> This is if the iommu driver/core code should fail the flag if the
> device doesn't have a PCI PASID cap.
> 
>> @@ -359,11 +359,17 @@ struct iommu_vfio_ioas {
>>   *                                   enforced on device attachment
>>   * @IOMMU_HWPT_FAULT_ID_VALID: The fault_id field of hwpt allocation data is
>>   *                             valid.
>> + * @IOMMU_HWPT_ALLOC_PASID: Requests a domain that can be used with PASID. The
>> + *                          domain can be attached to any PASID on the device.
>> + *                          Any domain attached to the non-PASID part of the
>> + *                          device must also be flaged, otherwise attaching a
>> + *                          PASID will blocked.
>>   */
> 
> And the choice needs to be documented here

Yes.

-Vasant
