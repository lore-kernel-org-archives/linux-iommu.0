Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011068.outbound.protection.outlook.com [52.101.62.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19F85237BC
	for <iommu@lists.linux.dev>; Tue,  8 Sep 2026 09:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788860474; cv=fail; b=JfWP4+logkYfBrY6TmQWJ+IACFzz9QtNaLvbTwrfHGuAtkLaGZHRU8x2eku5xto475geWXOd9sK8CHATzBoEN7FBOYNq4ywTvtyTdubf+dtc3xO/R67NplrkQosEaBzaO20dQ18RhuRTrT/EwQdAi1hszv+FxehHNk3MuIsJZKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788860474; c=relaxed/simple;
	bh=RgVTFb4F8zdwwBhdYYY1Eb9W6S0LEHZ8c2xRyWzzggY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d0vrt/9DgNvuf6mONExGlRWRbOUdgt9hNWjDtHNC2nyfRG8+UXMOp4VSxvuJoDK6Gqr1yWybtBMc2GArkFkSuDhWHhoBKz9TSVbmWAQw6PlqVQ6QRBo0+QAM6NzmZRbKUrBTtMqNDhOAfog2bRKfjzbiBf5qNNImZ2CTEOqw11k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HAdtsmdO; arc=fail smtp.client-ip=52.101.62.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HAdtsmdO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VM607yTjagVTh46z/i7B0osDSY6Ku4Dm3Kp3c19Ez9kkkn5Cik7NgUEaLrWO37kNrHLg8BPKNKJCAN43Frh2d5LGBmmlDRPvned5tMaspWbhkXk9mHOrJvIIaQu2j9Hi9mlC91twkNm6sOy1HqQXTFk4DGEQ+GLN40vUKCxHoJLj730xVz22nnrg5DTYADdnySZWCI1zBWtd4v1Ala7zP94kl1MA8nSdIiCiuQ5RQyM+Ld/IJXiDwSycLSo9OabWCkg02WnqqhF4/Tft8nnb1nioKEXtET91F9QNnZ1/WSM4+it6LFQyRpg3hFkaYEtigN/+cOfpZ6+Gle0PuV2uuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hEU6m935A/jTKteJk+Q3MYthGj9bSucBtNdCB1qkcWw=;
 b=cmdUQbjuQgLttNWPws7YCqhaG03wPpFzJnWrLOeVui5L3donNIO0AL0yN0MyWzjG5OGjIxZYPXIwsDgUge4XnfPw35mZlj4P09gts8msxxTnSrbxI7S88eC7LnqFvs89b7OfUPtLGJAUGAlCez78+UkeGzZ7cKtyee81u9N5IY1+1/yfCNCIGfxXVFTckkqL9Gn2EYpov0hzBhhMvqGIKHFQx/dbUSZNi+o3yHK56DnOGx7XNS8OVhw4elPtuPOXCoBAy2wEfpG/Jn+dhTgkSAD97XCZEAlz9CxvfXMzVUlfbwoWMdKmOCMYvufz82VKxhFCuqylDo1OzYKbgvloVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEU6m935A/jTKteJk+Q3MYthGj9bSucBtNdCB1qkcWw=;
 b=HAdtsmdOFnFPSVubBNdJJxmSOiG56DOeCbY//j/cY8o2TrrqTI1wrR3aHde3E1mLB9OKaBEZY9MOqi0w/Dvqye2Uf1VKedPYqs20wHpC3QP6fWmMLY0xLbRc4+bl8N15gu5OjzDZOUX+6FMvy1+dc03iyMzqCr87vpTA6T7lpEA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999171.namprd12.prod.outlook.com (2603:10b6:8:388::22)
 by MW6PR12MB9020.namprd12.prod.outlook.com (2603:10b6:303:240::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 8 Sep
 2026 09:41:07 +0000
Received: from DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19]) by DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19%4]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 09:41:07 +0000
Message-ID: <38c051cb-3852-424b-8951-a9d40d44eb54@amd.com>
Date: Tue, 8 Sep 2026 16:40:57 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/24] iommu/amd: Introduce helper function for updating
 device ID mapping table
To: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 Sairaj.K@amd.com, jay.chen@amd.com, wvw@google.com, wnliu@google.com,
 dantuluris@google.com, chriscli@google.com, kpsingh@google.com,
 alejandro.j.jimenez@oracle.com, joao.m.martins@oracle.com
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
 <20260727132913.22475-19-suravee.suthikulpanit@amd.com>
 <fbfc7a4a-3108-4cc0-b6d4-d89f56393aba@linux.alibaba.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <fbfc7a4a-3108-4cc0-b6d4-d89f56393aba@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1P15301CA0065.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:3d::12) To DSVPR12MB999171.namprd12.prod.outlook.com
 (2603:10b6:8:388::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999171:EE_|MW6PR12MB9020:EE_
X-MS-Office365-Filtering-Correlation-Id: c464be82-e3b2-4a01-78bc-08df0d8d4e8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|6133799003|10067099003|4143699003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	A42HHC6XjK32AkS0m7Obk0fVm/bmQ8JSCqnsil/pCEClfmvWJeIOymRQCnRrTuNav5Cx6U17qYSqh8rcVxm4o8TjUMGqbp8k0IbO941WffjllQpQSt2yYHuicm1VmG2yNKMAKLoy5g+jisRjAOgnMBIOUbiJXnzqofSgHhz3C0/hoAIdhEgsAe2a0uqIv1QAG+lMWva9nb7dbSXtYxwhCWBUqFwVYZyWFCpuk+Jw09hRSs0tgAcZL7G+jBf3aoCW8jckOCMGaqhnYKZT5p9kveHHhffMrI3I3gi5FUSpv+FTmqBDY0GlJ9CPf8su5LpG9klmQaztRRDKw/uaSJMG0vXOLqJjyQmdQUspKE2vj3Ixb+PVSXFSsLjv/gIuAff0fj3sCHBOqMefMvzNX6BM+LzMANZoCkEh/Tx+Mqefe6blv1r84nhBTLoxoWVqwYDfMjt9f03RUy4Q6VxCHW+QnABQgBmWBxcorU8/ZdxN3rkubYur771nHSBbgmmAECvWiwOLCXql+yO5RZtUVeyS/omixJHKiMJT+KIKw+M3/v1v35XTSYYJZTycTbrehieetG/+KeLLxNjEsBIcK6mN+5uig+Slr/PsfTXiL9UP4RbxIKDzObm+6BqwSial7KRqlkM7Loqi6xRk4e8UWQ1iWsU61LB3/HuF46mSUw6/QLM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB999171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFZRdEtsZFpQdlRWdVBoby8rRmEyVlMyY2NLMWQxN1NQcUtvRkVDL1dxUXRB?=
 =?utf-8?B?WDJwODhpSW5DTDUvQ0pXQU9aSjUzd1dQclRpRThWdlNBWURmVkpqbmc1SHdK?=
 =?utf-8?B?b1paS2loOXVBTTR4QVlGTmF5dkZhcFQwQldZb0dmMEpUbGovNVFsS2tIS0pI?=
 =?utf-8?B?UXVDdmVMLy9MdTR5ZGVlWnVLTTkzZnNOWEhGNTRXMkhxaTdPZmtLTUxjYU9p?=
 =?utf-8?B?ZE1BNDRMMXpFcU90cDdEZEo0dS9NbVRmM1NaS0hYVjBQQktNWFR6cGRXSlN5?=
 =?utf-8?B?cU9RSEtna2Y2ODhRdGlPR3hKaytWSXFON2xrcmdzWHNQeWJsTE5KVkpLSkEr?=
 =?utf-8?B?ZDVHOXhheEJmdXBjbTlWMDAvTks3MHpqTkppSktVQ2dZYnRoZWp0blJSNGNB?=
 =?utf-8?B?S0twOStjUkJnSzErMjVYbWRaWnZ4ZkZ1eHJ5MFhsZDIzbnJlbG05UEpvRG1r?=
 =?utf-8?B?RGxqL3NlTG8wTjFVRlVTa0ZtRnd5dDFWMk9mUmI0d0VIa2ZNSmloT1ZTYzRt?=
 =?utf-8?B?SE9ra0RZbDRid2Z4TEZoZ090VElXU0IvbDJlQml1UmxzZUZidElxVlBsNWdP?=
 =?utf-8?B?REZRZUJ1OU5aTGNVWXNuSVlheWZ4ME1mbHNNekwyU2szU1B1TmxxN3R0eWtO?=
 =?utf-8?B?emdvYXd0K1R3Mk5POVBYZXdKcGtrTEl2OHZ2OW1McWFHd05pTTZ2WXdxckVB?=
 =?utf-8?B?NUVBcElRcGphcDRyVXlCL3U5aEU3NmJrNTZnclBtdDI1aGN5Wi9nTlZNT0hD?=
 =?utf-8?B?T2NoWlhHOGlneTg3NFpsNzR5SWtDVTRxSGE0Y0hTK3dNcWQ5Sm1CWE9xWkxh?=
 =?utf-8?B?WnB1NDVtRnV1M09UMGtXbUxjMk9qOXhqOTQ1a2czeTh1R0tCYUVIamZEMmRa?=
 =?utf-8?B?djA4OTBHTlBpQWRrTGhDNXNuRFRKemNZeXp2RzBXZzJtamljNlhGSGV2cXVC?=
 =?utf-8?B?Q2FmbTdIQzdObTBXRHdjKzl4SVRzcGd2Y3pERURRTlpjYm5ZZGxjUEFpbnds?=
 =?utf-8?B?NzdVTUI0eDV3NjcwaWJUY1RackRvUWJyQzJpaGtHbEhJRHdaVTNyMndFQllm?=
 =?utf-8?B?M2FXZGF1V01hYWRldW0ydWNtTGNrSFZlYi9aa2dtTy9PVmdTTUpTTlU0N0tQ?=
 =?utf-8?B?S2hscUdxa3ZYMUFiMU5raFpxbTZDNGtxUmVDdWJGNXV2OVY1eit6dEFKeGtN?=
 =?utf-8?B?cnl5Ri9GSDV3R01ZYUUwYU83ZUVSKzgremFpdFR4UnNBbnpNZEtxV2RPWFJ1?=
 =?utf-8?B?YmhKYVBXcGRJVzJHWWNjSTZDRGF5VU1GWUcxaEVVa1V6aHNmMkVrNnFiSno3?=
 =?utf-8?B?S1dld1Y0b2FjWmh1TU5najUyTGpla2ljOUEyOTQyNWxpeS82RSt0b2huUEpU?=
 =?utf-8?B?VTZadkRGaDFLVkc4NzVLN3NFWDFhdkxqU2ZOUHdxY3pPYUE2VDd0QmlpQS85?=
 =?utf-8?B?YWZ4OXNMN0t1c3lWS1dic2gwMkJpOEt0SG1hKzVYdm1wOThnVUZYOUI1cmJi?=
 =?utf-8?B?aDlJNHpPVElqQ3ZMTnhKNUNOSndPVXorQVNpSHZkVzJPMC95Skc0R1pTL2tY?=
 =?utf-8?B?M2F2eXh3NHlNRnhkVW9OZVZJTHpoMDd4TDcweE4rdlJ5NHhqYlZ3VC9OcHBj?=
 =?utf-8?B?TWpjbm5Sd2FvN1RNRkloRGRPRVhQSFFNZTBYWXdBNWs3ZXphTmtLUkVHaTFI?=
 =?utf-8?B?LzYrN0tXcnp2NUQ1cjFzL1N5MnVNWUNpL0RQbnFSYS8wUXYzRWtYdFVOMDg0?=
 =?utf-8?B?TGk0VGx3T0Z0TnpnVTA1Z0psWk5uUE9LVWRlcUZPMUlLc0dUOXdrcE5VOHA4?=
 =?utf-8?B?dGh6NVBiQVhpaTJFcXJBRk5NckppNzY3czJNaE5XemFQTEhuM0tmWWpibk5L?=
 =?utf-8?B?SGlYalZENWIyTzhHS04vU2w0K1d1bnd0Q0NDZkN1QzRLK0o5SnVDZ05tbUtp?=
 =?utf-8?B?b1YreUloRVNlTTZWUi9BaUpBRUlyM3pCVHExcDRNR3F5R2JGekVEcUFvd3BC?=
 =?utf-8?B?RjNTdUFmWDB3SFpkMWpUU3c5ZGVhY1U4bXB0UVNicWhzZ1JYWC9HRlFZaGFV?=
 =?utf-8?B?WktZN2srY3VpVUQzVEhBdlZ4RG1rcW9oUU9oRWJHbE1SQm1QaWhDVFhJbVRm?=
 =?utf-8?B?QXBEVitRcE5SSUVzY0lkT1pKNEc5K1JWemFSYXl4d3RlUEQxZWZBRkdFM2RZ?=
 =?utf-8?B?czhhbVNsM2NXNExMUGFFcVFvRWkzQWRNd0hnU283RkVMbzhIdDBDYnlEWDNF?=
 =?utf-8?B?aDNteGthZ2xsMUN5eStKTGVDdkNlemxvREdUY3JOdXVLbTlGNDNPNGorZ0xL?=
 =?utf-8?B?aHh0VXlDWWJCNzJNako3Yjd3SmlEU0NYNWdab3BYVENmRnJaYjY4UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c464be82-e3b2-4a01-78bc-08df0d8d4e8d
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 09:41:07.0846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RllNSzXtOGV8BG5YcHwwj17yxQ1FYz/lPyTKIFL+XYzb7V1grzp/LQ/0MXFM2cBqwzHRV9Ir1qbtbjeGygBZ/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9020



On 8/19/2026 5:26 PM, guanghuifeng@linux.alibaba.com wrote:
>> +static void clear_device_mapping(struct amd_iommu *iommu, u16 
>> guestId, u16 gDevId)
>> +{
>> +    u64 val;
>> +    u8 __iomem *vfctrl;
>> +
>> +    /*
>> +     * Clear the DevID in VFCTRL registers
>> +     */
>> +    val = FIELD_PREP(DEVID_ENTRY_GDEVID_MASK, gDevId) |
>> +          FIELD_PREP(DEVID_ENTRY_HDEVID_MASK, 0) |
>> +          DEVID_ENTRY_WRITE | DEVID_ENTRY_VALID;
>> +
>> +    vfctrl = VIOMMU_VFCTRL_MMIO_BASE(iommu, guestId);
>> +    writeq(val, vfctrl + VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL0_OFFSET);
>> +}
> 
> 
> The clear path sets Vld=1 with hDevID=0. This semantics is ambiguous:
> Vld=1 marks the entry as a *valid* mapping, and hDevID=0 is a legal PCI
> BDF (Bus 0, Dev 0, Func 0), instead of treating the entry as invalid. To 
> actually invalidate the mapping,
> please use Vld=0
> 
>      val = FIELD_PREP(DEVID_ENTRY_GDEVID_MASK, gDevId) |
>            FIELD_PREP(DEVID_ENTRY_HDEVID_MASK, 0) |
>            DEVID_ENTRY_WRITE;
> 
> Alternatively, during the clear dev mapping process, you might directly 
> specify the original hdevid being used.

Based on the IOMMU implementation, it requires the valid bit to be set 
to 1. Otherwise, guest command INVALIDATE_IOMMU_ALL would trigger error 
ILLEGAL_COMMAND_ERROR event.

Generally, host device id BDF 0:00.0 is the host bridge, which is not 
part of the list of devices managed by IOMMU. So, it is safe.

Thanks,
Suravee


