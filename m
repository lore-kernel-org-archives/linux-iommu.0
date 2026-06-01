Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013027.outbound.protection.outlook.com [40.93.196.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09AF27A47F
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 09:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780304689; cv=fail; b=uu2vvjvj6ytMn4ohRKYmQcq3PlUmwMjPNvMhzW/H3gGJs1wmneZ8AEIEb6anMf+5jZgr6upwAY+4dwrO3kjrSOR9zbFSLrJqpzWqWjHj5Nbq9+e1gnNk3u+/NB6PUYKyNDAFnXbj99qmzE0ngXoT4fe4R9+xIAktKgd9GHecA/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780304689; c=relaxed/simple;
	bh=BuOhiZbwnwad/+u/eGXQfHXWI5NfzU7WUNYe+EGZueo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pgeezYPUstacofZVvzxL47cAR+ztwP2qjibDPJ13YPRVp++6+m+1euB7/9cv4QXHI0F+d5bmQWyLlFCfl25Y6Q7MfipwIcgtiofBn09Kg+BY4b8uQ6YFHQM1SSwRq3u/s8pNLoVJxunfFFUeCev2NbAiI+UAMbDw7wP/3kaAjk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jhxu7BlY; arc=fail smtp.client-ip=40.93.196.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jhxu7BlY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qXDoDZ1zt9/MeZBh+QbQTGOzy3wR96YEGylNqFuzISi0yDaKYLo647nppmRSiywLQisrXV4fIVX/UpDi2QaB8PUIFq2aSdQxc6yVESV8MemEu0IlmdIWyfC7ETIkaQVLP3WSbEvSYHIjM13eqj6XaLH0klvzZbJvYk17Sff5LyLbVkxTURrmm1Hmi+/4177szZVeU3QKNjgIs/Swdxsllww6SRENevRsRro26/B7YVgspJqlYWKD2UooPjM39h+zlxBiV55oOEqLabQBhTwvjLBJnRZE52WYlQbA6oHzW2ttT2CGo+ytSTuhHKnVWKlUmV0OUH7srE2CNkOiuHr1bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BuOhiZbwnwad/+u/eGXQfHXWI5NfzU7WUNYe+EGZueo=;
 b=A1Z+bFzHki+vcdGgL4rbolbaHTA4Lu4NwJsj94WJ0NOxNUnbJfdGEnAvbHqByQPZ5XN9Zm7c5pZ5MoaTN0VwKEQJXngEgeMbSpco4g/clv3jz2t7JMFjHkFDOZJ671fHPZRXypX8q3vVbAx4iq7X4IDchvaj74V8BgaljvQa136d3qXaVWdS3m5mR5nPMFUkz1NUobfEapV5QxCDGygt6wQn70n9VrKKyzp4UcmTU4nlEOWz2dNHa1RpbmXLWb/c6LWkpi3Qw9+xVB/IRj4D6n2qyiTQPdijz6sY57oi+64or1cDlM0sq3ASPhZq48NoqVHY2cUwC44tzANrCAx3hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BuOhiZbwnwad/+u/eGXQfHXWI5NfzU7WUNYe+EGZueo=;
 b=jhxu7BlYmFYiZWFwRf4ID0ptKjAd85qrlfsfPNO21soh4cHrDBtwijw0nC3RK9jzGdObRW8virjR+y57xpwRKVUiNpO2FomBGvdnHY2BhV8CrA5wsHq187JQtJSGm99io1BxD1H+fuiD4JKXjWGuqyyWRge1se2IvbW4jVnRDRlcAVgROgMQ/nYkGk2HKC031HK4FAHZRKqZ6dW9e9UqzrnlfYZMNo2uWiYr0FvtBcbnU9SVIIJ2m34cvysZ1B1uKZUcaLfEZ+wKZgfuzPEpaJUjiblonNWMOH9EyRxJGz0DuplM6l4MzGNCPPv5WQZfa7EP4dZdDjbeKPzBDtNzMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14)
 by CH3PR12MB7523.namprd12.prod.outlook.com (2603:10b6:610:148::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 09:04:44 +0000
Received: from BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c]) by BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c%4]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 09:04:43 +0000
Message-ID: <ee6321cd-44f5-4ce7-aa32-27e1fb886238@nvidia.com>
Date: Mon, 1 Jun 2026 14:34:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] iommu/arm-smmu-v3: Detect Tegra264 erratum
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20260529140830.629738-1-amhetre@nvidia.com>
 <20260529140830.629738-2-amhetre@nvidia.com>
 <ahoFbo7KNHiHh+D6@Asurada-Nvidia>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <ahoFbo7KNHiHh+D6@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0172.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::27) To BN5PR12MB9511.namprd12.prod.outlook.com
 (2603:10b6:408:2a9::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PR12MB9511:EE_|CH3PR12MB7523:EE_
X-MS-Office365-Filtering-Correlation-Id: 64d7c581-43d8-46f8-3761-08debfbcd262
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|11063799006|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	aLAkNsDT4K1n6R60EURrvCB+tJqQC0B61i+uD8FwQKQxkuCIUwinc4Cr7+u69EVZS2ipXPsdt0yzqYouGbZuqT/gs9XrjUGi5O7BS5qo+HEr08qqsoCqB3iTCzY4NtFBwDwm0GrTT0BI6J9Eo00GJOb4QHl+M9D2KWK4nz9sZKsJUazlkqOaM4PeVdJpDhQmK1vqq4nToNTo8XnVZq1FGLPFuPd9W8xS4RqK15jgu6pEHefFvgzUhc+KwhhqeCOkXanFZAS6tKzKM4MyNERjTB0rpO4gm94j9Se3SPSlPHhZpa04qaFhnMwztf0oEq0YZdeToInKUWlGtgcO0KiwAYmO1YNb4ofAbSlGgUmeOmvqm8gU+6TmNwSTnPRGxGKWmJgCjn0cj8wNT3RR/nATh7gCAR9ENZhwqsCQyHXOCjcauSn/a/9rIRT/n0xuLhXb5NkdPqMrK8Et5x4ZWHJcSKvEXJBdNf+QpydSc7H9c95nIE4bb22UuSz36MLIpEHSB1JzGImwXORcqEjgYbcaQa0OsFYtl++5Q5swQ0dJz/PhflW7xl+SUKQ64p2k6A2GvEJ85zt2DqoJkrxyeuVVfjB3BNxpxaL/Sm+ycCXNV87o5lgHJTdBs8wLe9kukzK69wwE89Ce9waVMBIQH2kt5pnhkjDBy+u2GtMu57uJDsrDcfifgFy4zA2dApCAdT5i7535VVM+y07f1gZB6aj/+w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN5PR12MB9511.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(11063799006)(18002099003)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXlkYnJDd1lqRjREQVR6ZWJJZXk2RzJ2ditVT0N0RG81MThaaUNjSFNMeEZy?=
 =?utf-8?B?VG52ZGpVbTlpYTBMZmpOY1g0OXRTTHlldnB3SE5LNk5GQUFLOHhIZ2F4U200?=
 =?utf-8?B?N3VndWtQcjltaUdGaUhJMkVXNy9zaDJtbXNsZjYvZ29qR0FxekhBTUJoQVpO?=
 =?utf-8?B?QW1vUnNoa3BZRHJEbzZ6VTduUmIvMFZDWWNwY3BiVC9UWUlPelhOSG4xWWMv?=
 =?utf-8?B?U1dhN2Nhd0RDSUVyM3ptdVFIOVJnRitkMThTVTByd05kcVVSU2czMzVFQmxo?=
 =?utf-8?B?R0x0amtFRnNZL0hzNkRhMjA0SkRwbitaMnJnNFl2aExLeXhpM25CSi9DVy93?=
 =?utf-8?B?SVdqd2RkZE44aGhYWkhBMTkyVXlYVTVTdWlUVjBpMmRJU2d2bDcvSWoreFg5?=
 =?utf-8?B?bVZNZEtXRitCUFRzNTVUVzVpRzI0emxZckt5Ti9oUzQzY0xsajBuVVY2TElB?=
 =?utf-8?B?TVN2YURERTEvUTBicm9jWUxDYi9JeDBaaGFIYVVVVHZQZjExTy9zc29VdlhW?=
 =?utf-8?B?clZOYWpLRmtNUGgxT2VHdjgvVE1Hd0gvOEpKQytKSWplRzF1cjN4SThoNkZK?=
 =?utf-8?B?UUVmMUVYWGF5bUZSQzRXb2Q0cmRyQnU1SUhZRDJ0TFRsSkl5LzJUSFppcjhj?=
 =?utf-8?B?MGd0N0pkQ0hYcDhNSGM4Mm1DUnFnRDNDY25OdnM3OW5nZmVFVzVZaTBRQk56?=
 =?utf-8?B?Q2dWZ3R1dFcxenJqdnVKRjArVVVzZVRQeVNOcGFXcDAzMnNNRnZVWWhGMHBV?=
 =?utf-8?B?a0RwYW1WaDNSRWNxcmN3RlN1V2I2RU9PUUtKZ2ZSOFQ1d1dLbTdqV3JBZ2dT?=
 =?utf-8?B?WWpycStiQUlUTDU5bXduSko0NWdnS1VOZ2ljRHNnbnpVdFhTUndtNXo1dTJF?=
 =?utf-8?B?cURZL3l0REZRTFJRUnhNYmljbzJSSnEvNHdaVEhwZ1pUZ1dvdldZT29tLy9H?=
 =?utf-8?B?d3RXUzhBeityVWNmNEVhRUhuMzg2WHdaY1Q3V25RcVZHRjVRZERaU0g0VGNZ?=
 =?utf-8?B?TCtIeHNvWmgrRms4RHV0ODJ2UDJYOVBqQXZNM3pNWWp0UGR1WDZwRFA2VHNn?=
 =?utf-8?B?YVVCZnJsdlF1azNVWWlaQ0trRXZQenZUeUl4OWpNMWI4enM1WDFNSE1WU0Ez?=
 =?utf-8?B?d2dzWmtIM3JQb1pEOHFJa3lTbTFwL3gyNWVUR21IdE0vMnRSdXdKL0RJSGhx?=
 =?utf-8?B?bUZTZEpacjMyN2FZeGgrWnE1Mmo4Zis4RzllbVFGUVNCMVJTZVBzNTh2bnJj?=
 =?utf-8?B?eGNHUytUVk0vU2VwVEtoZDdRRGtqSkJrWnpUR3pTSjE0alV4bjUzblBtbDBh?=
 =?utf-8?B?ZWVSWThZRmgzazl6cWlaRExNRnZNTEZ1RHM3N2xmcytYVGZXN25nTWlSdytl?=
 =?utf-8?B?OHkxRzI0NVRaNkFKeWdvWkdFb1BLZ2xRSGUra1BGdm5UZkhkWXhzNTJOUXJT?=
 =?utf-8?B?QmhKKzdGYjBPVDByNWM1aWVSM1MzY3lTRVE1SUd3enlJWXlsQTZObk1pZjg4?=
 =?utf-8?B?UWFSalVKNHg4YkVtT0pBS0JXTm42WHhrcm9Ka0piQlFZY0ZjcjVrSW41b3ht?=
 =?utf-8?B?cjJaM0lGakZBVHhNWE1hTXJ2UloyeWJtSlBFRitvR0N5K0UxZDNRU2trRHZi?=
 =?utf-8?B?ME9TVFU1NlFrN2xxdGpoZlFKak9ldmd4OTVybUxUUmV4ZUVmeUE5cTY3RFhD?=
 =?utf-8?B?VDNqczJUZE5wRFN2WnRGVzg4TklwWFErWDVIQ0lHVGtranFCQTdEZ0M3Q0JV?=
 =?utf-8?B?MlJsWHR5eGNqQlVobm9UakRMclBZektpV1JCVHdyUU0zNVpzYWVmYUU3R2Y5?=
 =?utf-8?B?Rm1iM0t3clRzaXlVY2tycWhYUGlNaytPM25QdU80amFWaE9oVUlSOXZwS1d2?=
 =?utf-8?B?Y085TTJ2LzU1OVh5aXlGbS9ZdGhhaEJUSCtJdGR6UHp2clM0QjFQWDR1VlJO?=
 =?utf-8?B?WUxuMEYyRmZwR3JLYWZOSHIrVk5OeVBUUHpMdE02TmtDTEZONHBzdVBTQ0Ez?=
 =?utf-8?B?R3RKLzFvTUprK3dmZWhUTmhzV0oxNnpWTnV3WFl1cVpWUzMvcEtCSzZsaU0x?=
 =?utf-8?B?cnI0QVZmMkZGTE9DNGlKZ3RKT0VGSU5ra0lzZnlvWkR5UFZTSENPb1JrVFp2?=
 =?utf-8?B?SVRIWXBiSFZiRlU2LzhudjNvK3FxVnU5NFYyVXJSak5xRlJUWWZwZzdtcmtt?=
 =?utf-8?B?L2VFSjVwNWtNK3ZuR1g2Q1NWSHZ5bUJKYlhQUVBXdXNYOTBsZk00SVkxVVBi?=
 =?utf-8?B?T3haWkdZWE9wc3ZHTStCbTNPVDA4SDhhSmFzTXptYUtodHJIUk5Idzc3SGtU?=
 =?utf-8?B?K1lRazJpbGZlRU5sckhscStRbVBlbW90K0lqZW1OUC9zSTF2eUxFZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d7c581-43d8-46f8-3761-08debfbcd262
X-MS-Exchange-CrossTenant-AuthSource: BN5PR12MB9511.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 09:04:43.8580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YneRyTMW62EpPtq+b6GbngqJYNuKRaGHWG5mDGB2niiRGavbx76ADuQSk/SxIxb/b4Lm5kGH3umJ5aabEAlksA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7523



On 5/30/2026 3:00 AM, Nicolin Chen wrote:
> On Fri, May 29, 2026 at 02:08:29PM +0000, Ashish Mhetre wrote:
>> Tegra264 SMMU is affected by erratum where a TLB entry can survive an
>> invalidation that races with concurrent traffic targeting the same
>> entry. The hardware-recommended software workaround is to issue every
>> CFGI/TLBI command (each followed by CMD_SYNC) twice. The second issue is
>> guaranteed to evict the entry. ATC_INV is not affected and must not be
>> doubled.
>>
>> The erratum is not flagged by any SMMUv3 IDR/IIDR register, so it cannot
>> be detected from hardware register. Tegra264 boots from device tree only
>> and has no ACPI/IORT support, so detection is through device tree only.
>>
>> Add the ARM_SMMU_OPT_TLBI_TWICE option and set it on instances matching
>> the existing "nvidia,tegra264-smmu" compatible. No callers consume the
>> option yet, next patch wires the workaround into the CMDQ issue paths.
> I was told to avoid "patch": once a patch is applied it becomes
> a commit. So, maybe "a subsequent change will wire".

Sure, I'll update it in next version.

>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

Thanks Nicolin.
