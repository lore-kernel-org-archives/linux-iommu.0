Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795433091;
	b=PHIKE2g80C74ZW4IIjQveRIbMiDMHXfLWAwBLB1TuTqKVW//k/WcnYAYt7cCAtXA1Nii
	 7449fMNvSV67N4aOZAJuzIOQdvEevtqZdz5Q6Y+xb+7iCDqJ50Oc/jgpGe4xQubfVY+cN
	 BnirTbMgI/f0QsaNvHZrHq+JVHdSmGdm57FMJr14LS9q82IszKvGsm56PUSp0/zi+6QWv
	 cEy0gcbHxj6tyKwjUJ85tZvv957wFGuhSc3GPHF1b6yVpGXZ5tqntQauExypLau6xwj/T
	 413oWc7Q6GxyoEeNZGStQnDtuBZ4RgGvd3iHu7KMbfe0msb33x8kojpRTv1w13593zw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795433091;
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
	bh=6NE66XRocJQiUfVQz7B8d+3ckM1joiB5qrv+h5U1x7M=;
	b=GP14AlsEfg/gabuQ26Z5GOoKiZqAxG3rN0PD2pWU/J/U5+QkGJByNI7K5QOvFQePPANe
	 +ntW/KhbSfAv4hXZMONskFyXtFXVIFG5GaEYMKkNzXOUoiEh578/vpXk6mfi8qK8qnBpp
	 uz42J2YTueanfSV+fZZBvXTYYmql03lonzEDPnHxx9+h8BO4P0Sxqa8ul22GFsFVNtjCh
	 maaqCRknvz2nCVk+6n0G69bHL89UHGJ5F+d39q9RZAHPRISgOlvOcAprAZGLPaTB5TTQM
	 B+Kq1hQ6nfRms2VSXaxFLI46FIG2O9bJgSqcSd+ezZirIjJxHT+FmSWGNMgEAKM+8ig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=odMAE6Ma;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.30
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012030.outbound.protection.outlook.com [52.101.53.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF8D606A31A
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 11:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADF8D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=odMAE6Ma
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GPsmcXGmxvIz/ZUAvfsChswxOSVxz/yEQ37oIR0oPSXz7kDp4as+8rEG2I6B80AFR8pvIfZUZW1sQ0BFRszr7Qm2CwO7vTx76IRf1Hvgpe1Oro417o7tqBs6Y812XkOdLWeLdzfb1Ek2OrKkxvPKR04/In8h31D65VNviwgewRnPeg2jYHTtgkuTTC1Ojpnte6vvbjzNw8ILAmyu6eqMPZcwNro4Narpp+uBE9cus6e8CcjE5O7rPaUPf9xhRKFEV04OTUepHSbFsBAJmCKjKn2EDXVGNrvMqrDs7asUQ69UuJpz1SCjVUwlgcIeIi1P3QHZqwH7eiKvFKQDYSduXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NE66XRocJQiUfVQz7B8d+3ckM1joiB5qrv+h5U1x7M=;
 b=eEHvDDOEYnXWaUVNmwTIMEK0VG6cW+gnC/LPp0l7xRUg+iXvqh/YzWHu+5C1bMhMg6oi1k6FijaVT2KbDS1IU4hsqPWeDUlcGUlvTwlWE3aUa9EGZkSxud1OAEGjBYkoNVMOd7XQtMvgLmIrFN3I0qsVL3n5+FyN5O/rAM+C9MAtTNX7XehLKQxvLEhJiQ9//6h7bz+sYqsBt77x57OtPHP5aCOJjgbocsybJkAP6pS1UCjctF69FxwXy1z3S0ab3gv/OnRqKB8OzAJiMB+nSsDLqxqcKCMZBmvoTXTuI/BjVEKBH2JL0TMEoU8jOgK9YLN6y1kU1lbPYTO3fusnCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NE66XRocJQiUfVQz7B8d+3ckM1joiB5qrv+h5U1x7M=;
 b=odMAE6MaWNC45bL07Srhibd+EqGwK/mTeDVvr00lxMkLnr83NWNfE8Dqb2vUjP5FYS7C5g9/4mA3acGk9VVjNpK/T767ni3n+vdOfA4z7Ka5rFC0/0Al0DXWj8O6vHeVTwEm7RSny2pi/Pi3eJaxxisdUT6vu7Vsj2SmZLBZwJA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by DS0PR12MB999263.namprd12.prod.outlook.com (2603:10b6:8:424::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 11:24:47 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 11:24:47 +0000
Message-ID: <ce52a6f1-bb8d-4a40-a500-1af32746cba6@amd.com>
Date: Mon, 23 Nov 2026 16:54:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Mark v2 page tables incoherent on Cezanne
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 Mario Limonciello <superm1@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Akshata V Unkal <Akshata.VUnkal@amd.com>,
 Nathan Blomquist <nblomquist@gmail.com>
References: <20261120152308.76894-1-vasant.hegde@amd.com>
 <20261120192653.GE1133597@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20261120192653.GE1133597@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0260.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21c::8) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
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
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|DS0PR12MB999263:EE_
X-MS-Office365-Filtering-Correlation-Id: cfbf2b7f-8554-4da0-5bbd-08df4954619f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|261021123027099003|261026121527099003|261026140227099003|261022105027099003|261022075727099003|261028144727099003|56012099006|10067099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	OH+zEIqOF8J1Vv0JZk2auVs3PkTl4Ak4Sst9bXCopwBApV0+0oMVSO6oR3v31+UrwGRtzbBdI2HnmEWEKvKTHii2qoc7KYUXM3qhCE4jGCVuyduxq4qoBArjE/dDyJlO3jaunBOqJjNJ4AJR5nNRAq1DDSieLV2xQDdZhZwtvD1ejxRnr5i56DUclJ1XAJw59/3GoYj8DVzfFpD3kGYYUr3s63+s7zZWkdZyMwubLe9vyMHdYL/IbT20RruIwEoWnEUlg6enA2IASbjy3l7vx0t0aR03XVrL7qM3omFq+rdBs9BsuCb/Wjtp3MblkErlWBn589C1wJgciJ79RKvkXz37PG+/N9peMQ38S4XLRErMeOWeHNcl8Atm5lHqd3HmnQIABIeU9/QNbaNegyo5V/Z33i9CjB1glwYZgel2yswL/K8LxD8fOj9ucCmY3nePr4wVzBTpsWVQru5ejhZ4pqJMi3u3eAa4YCSGX69/RZYlFLUxdC1yqTsDPLwmV0LkM+meTpJDffZuNibQBtPUFJNfm3q+YQRKhUDfBK0fbyV+vJ7eXCNrGxIwSkTJ6hNpGjqLsT9+lL20lSr6at5lzwXEt0e9z+FxvXgAJvxAPAMwkEMrTr6g1dMM40KPsUUstG9TR7eVYOKZRsarpMQHGF069HRIk40pZ4JiGna/b10=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(261021123027099003)(261026121527099003)(261026140227099003)(261022105027099003)(261022075727099003)(261028144727099003)(56012099006)(10067099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUxKL0Rjam9OQ215SDNHWGdnMjdFZnNIV0hVb2hiVzQveEZIS1Vwb3ExMTVq?=
 =?utf-8?B?bkdyRE5SZGdnNGNMbDR6SmxWa21EVll4MUVVem9kTm1ZRVB3L1h5T3JZN3gw?=
 =?utf-8?B?bktZbjhKckRjN2VWNEFHbFIwNzQwaG5OMGxZR2x2Y2xBSjJvVEllcjBjMVFT?=
 =?utf-8?B?dnpPeDVLRTlIY1F2TnRWbUpIS3NhVy9lY3poYTYrWTJYNUZSZGxXVGtNT1Zj?=
 =?utf-8?B?Zmwvc0t0dndVT2l6VlJwMmxSNWpKTEpVOTNuZ09BelNGenBzT1EyNWRKd3g0?=
 =?utf-8?B?WjlQaHo0OHVkMlAzYlNIZW0yTjkrTXVGY1BVbFlJQjNNTjlsRkF1dHMrVXpy?=
 =?utf-8?B?Mkt1NXplRHczUEhUeXpjNUFjbFdnUHRkVjBrdkUvdXYzNVlZSFNsV1cweGM4?=
 =?utf-8?B?aDlFOCtnSmFEUVRTMVNiNjJFZHl1YW5YTzd6M0NwenpjeGVhS3g4clJEejNO?=
 =?utf-8?B?WHV6NW5tUzROa2pIVzlpSXpRQnFKbW1mTjdkeiszejR6RnZDc3lwN3ZqMG9m?=
 =?utf-8?B?Z2hoOCtQMDZGdEhadnhtc1JwdHdpQ2FxSVB3ekVxU2FRNWtrYTJaUit4bVJI?=
 =?utf-8?B?MUlrMElPNlpORGV5QXZvWThkWlNPbksxTitMelhqcERONUxrMVlaUldQUzNl?=
 =?utf-8?B?WW9yN1A0QjI5WkdzaHpRTzFkSUtyb1JyanZMdkI2a1F1ZCszRDJpZ2hHMWVT?=
 =?utf-8?B?VGRiZVBMbmtoRXFGY01WaWJ1cG96TjREVUNFWStPUWhEMThzS25XUGdaWEta?=
 =?utf-8?B?MmhQbTFiR0lJYVhFRzNuNlBIbmRnQzZwc2EvbDEwc2tUWUZ2S2hvQ1gwTVRm?=
 =?utf-8?B?Ym0rKzRwb3hHSFpjWEtDZFhxQkJoV0lJYkNTbFhVNzNKeVpoNVhtSnJGTi9z?=
 =?utf-8?B?UkxYZVlkT2pWcWY4ZUNuZGsrMlY2UnlDM1pwV2VWaGdWSkhUU29VN1pRN0Mv?=
 =?utf-8?B?cUFGcHRKU21YWTBUM1U2VEhTaHBmeG8yd1hCQ2Y1RlZpMlY0V2RvY3BiRnNr?=
 =?utf-8?B?YS9leHRDZGdGUWtFTnZwaTFxT00zRFhIdW16eHN2Y1F3VWc2NTN4TnpsbW1C?=
 =?utf-8?B?cXppRjdKcHlYbzJNaTg3Y3hkR2NpOUdtRHNGUEZoSG1UeStPd1dyTEt6TnI3?=
 =?utf-8?B?V1BKaHBMYVBxc1ErMjZqQ1lpTGxZZVRzR0hEajdpM2F4anRRY0Z1bWl6YjE4?=
 =?utf-8?B?M2lCM0htZ2thQ2czSzlmN0lEbC9EREtwQzBaU1FyYlVwWmMyMCtjamhBMjly?=
 =?utf-8?B?bUFWa05MUjBTTW9XT0VXU0Z3Nmp5K3RucEVpcE9hRWR1UDdOSzhOdTRMbDNn?=
 =?utf-8?B?STNpWGRrOXFqaGZDVVZCSVpSYTF2OWxGQUZ1T05YRTNRVi92NDJYdHRMNnJV?=
 =?utf-8?B?NU1kTGVyYzBhb1kyU2kxKzV4WTc4czZwUU4ybmlMS1VwZWhJRXlZSkJoNU90?=
 =?utf-8?B?NXlhMC9jejFKRVdsZ3N1bDhqWFl1UVBvTWxRTVZYMjM0dVN4NzRCbEZlV2w4?=
 =?utf-8?B?M0c5VWEwWnIrUjI0MWszZ1J6Nmo4M01qTi9XdEU2TG1KekxOR0lqMmJSYUpr?=
 =?utf-8?B?YlRsOU90Ly95RGQrTXZuelBoSkxVUTYrb1NmcnJhaGtFQXpPWDRnSG9ESE41?=
 =?utf-8?B?T2hkL3RjWnhqSk9RNjlaVCtPYk9UMStmV1EzcC9xZnlMMVc4aGNTMFpTanFq?=
 =?utf-8?B?T1NIeXI5K0YvNFNqNlhxSFh4UWh0NjVKWVEzR0xpMnpnSUMrczhRaHAzeWNa?=
 =?utf-8?B?am5RdTd2SUg1ZWFkN0NVUEVmekVVTkJRdGQrQTJnMC9oa0lFRXZWWmNESXRa?=
 =?utf-8?B?cGRQSERFR1lTQm82cnhhSk44TjdkdUtSS0tMQUl2MnZ5amJGM3o5Vm9lczQ2?=
 =?utf-8?B?Zm9KVlcwK2lNRndwZ1VOQW9qWHN6ejJObEJpQWtnamVkRWlVdjdYdEV6TlQv?=
 =?utf-8?B?aGxnRWQwRjZPalN3TmhDVTdnbThUYjh3ZExMWkRBRzYzNHdxTEMwRDlDV3Az?=
 =?utf-8?B?L2tyUkVSYTlIVTNsT2pYUFFEYVNGcGlVREJybDhBWDE3WERxei9DNGxwSjJX?=
 =?utf-8?B?VzZCNEdMRUd0eVNqV0VDbG9aWldXTkprVHY1NkJMKzEraU42ZmdkVjRIZ1lI?=
 =?utf-8?B?dTdhSnFtUFpwNTN2Z1NKVnpOL0FjTGduTHJCcDF0eTZZRFVPS0dTallLM3ZR?=
 =?utf-8?B?azYzNjBIVWRJdXdLaEE0aHh6dWF5MVcwSlhnNDlveWh6RUFXc2kwOEc3Vysx?=
 =?utf-8?B?VGRKV2x1V2NCU3ZCYldFODNuTENGbTFsWnV3aXVZTE52SEZIY3RwblhZZ1BU?=
 =?utf-8?Q?pbWYQK4LP360DKWwHm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfbf2b7f-8554-4da0-5bbd-08df4954619f
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 11:24:47.7140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EEyKlLn6XGVN8CoMCn2NAGpanZdq2dphbaDrd80L312Baoab0JdfD6M0kfTnSBY4zZa/NWHVGePn217weyc2+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999263



On 11/21/2026 12:56 AM, Jason Gunthorpe wrote:
> On Fri, Nov 20, 2026 at 03:23:08PM +0000, Vasant Hegde wrote:
>> DMA fails on Cezanne (family 19h, model 50h) when a device is placed in
>> an IOMMU v2 paging domain due to missing coherency setting in IOMMU HW.
>> The IOMMU walks v2 page tables without observing CPU writes still held
>> in the cache. v1 PTEs have a Force Coherent bit, which the driver sets
>> on every entry, but the v2 format has no equivalent bit, so v2 walks
>> are not kept coherent.
> 
> That seems like an enormous obvious hardware bug? I'm shocked it was
> released like that..

I believe this is missing BIOS programming.

> 
> Is anything else non-coherent by accident?

We ran tests on as many variants we could get it. As we know this is the only
platform hit this bug.

-Vasant

