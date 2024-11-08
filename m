Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8789338C
	for <iommu@lists.linux.dev>; Fri,  8 Nov 2024 00:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731024086; cv=fail; b=aR+feFNB8lJ/d51F+5yiEtsb7M7FJYWC+4NT15SYv4tQmX3jXBYD/nbiFj7LDNb+v6vA7XIC3iurePyjUGxWX0mPsyIvrH9Zv6dtTHla09hglalpc/Zc+usflwSSZ3yLeQkZ/MuBDukI0NXgej/ou3xRpkHogC3Ai21j6JRf+uE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731024086; c=relaxed/simple;
	bh=Pu5wB66xmXJbf/iNHIfqR9EEIsu6wMOLw7s7ZKLe5iw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sP9wnTbQXlcfVGXwOo3HxA92Df5ito6/4/hXiu+cxQLDoV8G2LfO3wm74j8kL9eSQvIWQUGNq1DRIjTqq3qfowJuwdIa/i1aoH/YQlcHicaR712iSdaCC1wK8LukqNQUshfz/egCedDq/KBNVriLBL9A38RV3l6yURrZg7rJRHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D21Piqwv; arc=fail smtp.client-ip=40.107.100.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D21Piqwv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvlWWyZHt586k4BPmVEgvse5cCzNSOTEkjrjPphpaH94v8F7D6MQBcxVUdsrTLxf2tFYtxA2uIL5Do8zUSQjcg+L4e10cQhByrA0kMB5BOL2wvV6ZBDdoEZ4XAIMcI8wqpeCk4X5KzxegXrwxGo/hKnkef/fzHmWpJi4RatrFJKyGUgRcp2wHujkcISSCR/WQrVIcPnwwVchCS0yRzgqyFuobo73f1bINdieq4utp5fjKW+tm4cOzN0NhE5Mq1FIVYu7vZVBb/ay/vbodHzUN0LL9Z6M3bYi9301qk1uezOaMX3He19/LrFwIsNyI/1mel93RHj3c2t7yPmzkkLmuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evepccoF8T7AnNq9rXQ9DxIUVAHMIuoZqpMRR/zn9IY=;
 b=A/cdPntwzxF/6+cMjMwuhTPl5btIZiwDhUwB9pWWOZ2peAm1PJfYrfdS8Uhoo5LuiW+S+sprWU28Q/tn7DjnxWk5lWtHghhizXBSgTe2e05+/ARTkRVteZwEPtuEl7wSph48xL0ctaCxZBlqOMmN4fijmOYxNpVtIo1KXSGDscjaSIgRGEF/OvyrEmTYLTiDC+DVNDl0UWmePsAYykAp/T5F8eg8zsEBhrigqWGeLbe5QLqikTlSrc0FVfFTLfa9R366+u/sV3DO/BjDno+BbpH7fSZhFYyFlnmeZIugVNzallM5xkGsMkfSQw4GpuIuz1Nxall3Vb6HAWQM+1UBiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evepccoF8T7AnNq9rXQ9DxIUVAHMIuoZqpMRR/zn9IY=;
 b=D21PiqwvD5mYasnpaHQuyt77sJcjPFRS/a17GdJv4kMiIKjGTdVBGQxZSj6yFTZk18Ie+GRU2MA+FRQdOcf43cO6BTrFmoq/28c5rOtDcmEuwO7dzEZ6ZkfT1nUgCjOm7SdjvuilJuoi1kmL8+UgnuHFxWLV+zX2VKH2VyDNmCw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by DS0PR12MB7558.namprd12.prod.outlook.com (2603:10b6:8:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 00:01:21 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%6]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 00:01:21 +0000
Message-ID: <987fe758-de45-44b1-843c-63f3f82fd864@amd.com>
Date: Fri, 8 Nov 2024 11:01:15 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH V7 6/9] iommufd: pfn reader for file mappings
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, iommu@lists.linux.dev,
 Kevin Tian <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>
References: <1729861919-234514-1-git-send-email-steven.sistare@oracle.com>
 <1729861919-234514-7-git-send-email-steven.sistare@oracle.com>
 <8f2fadc0-1872-49db-83aa-314352adbb6a@amd.com>
 <7788773d-471d-48ad-9f9c-ddd5671b26e5@amd.com>
 <2bbfb5fa-20e5-4935-b52d-73b5186c6123@oracle.com>
 <5ff5b402-95c4-408a-99f0-2f6ea4e617b8@amd.com>
 <20241107140821.GE520535@nvidia.com>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20241107140821.GE520535@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYBPR01CA0059.ausprd01.prod.outlook.com
 (2603:10c6:10:2::23) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|DS0PR12MB7558:EE_
X-MS-Office365-Filtering-Correlation-Id: 64dafce0-d35f-4306-560e-08dcff887a14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmFGaWNqUk02K2FLaVgvNnJzRGZIa0YwbGkrdFk2OC95cEpjL09CRkJFSnR4?=
 =?utf-8?B?SEdjWFFMUFVFa3NqaWd4M0M0NzZuWmtKUElJblNiRmJFR0hoL1VRTDdhbVpW?=
 =?utf-8?B?U285RVN0eGI5d3lvdmdoeDR5dEoxelV0bFkrVHJZdjh3TlFmVWlkcWN3Q3Zn?=
 =?utf-8?B?bE0xZTg2ejY1ZmI4VndrblVHazVaSUVWZnRHVloya0pONEU1N21qMlZxZTRH?=
 =?utf-8?B?dHIxM29qUE40VEpmV2R1eTN3ZUtzMzd4cnlBenFEUUpzOFMyMkxYLzNvUEVR?=
 =?utf-8?B?OUJVWFN5eU5IOEsvTVF3cnZScTJSSmxYU3dHYnh1UGhiYUd2VXJZK2w0NnJK?=
 =?utf-8?B?VGNNREo1dkZ5UXlUeFdTV05vKy9aOHpvRkI5TVNXYlZaUWxnazd4K3diL0sv?=
 =?utf-8?B?NzFOdlFBVDVqL2xNVWxESjV5cDh2RFRkZDlXekROMWo4dmVocnE4VkFCSno0?=
 =?utf-8?B?ZHMrZmU2VjZsVEV2ZjAxTkVVK0lsbmZWaVJiS3pEb3UvbXppSzVzR25rOHRS?=
 =?utf-8?B?ZFpiNUhaOHJKWkROUjMzT1Mxcyswb2tlMEFHN1FQSVNOSWtxNGh1VG9kOE5V?=
 =?utf-8?B?VGo3RWZmK2hva0NuVGdUR1kvaFRST1pNVDZSdDFwTmwvSUlYVEpXUlR3YWNT?=
 =?utf-8?B?Tk9QUGtaWkNpRzhBa0VucmI5MGIwMllxU08zQzEzNHp1cjdnOWViYW5mT2Nr?=
 =?utf-8?B?Q09UbkVPS3ZlKzhMcGRDZy9HWHNRemdFY25YSjJUSlQwV3k4T1VtTEdwR2kv?=
 =?utf-8?B?T055SlVNNnVITE9rblVua1NtbDhFSzEvdUs1WWJEZUI0bGp1RnRIOG1MK0RW?=
 =?utf-8?B?TzRGYUE1b0pSUW52M3FuR09ldnFzcFB3VUJVMGNiZjl1ZzJwUDR3d2krbm0z?=
 =?utf-8?B?dEpZdER5aU43NjJEUkVDR21nZjdKMWpsWXhaYWt4RTdoQ1NPTEwxdzc2NU5V?=
 =?utf-8?B?dHhMdWp3eHo5a0xlaDlRalhwSTBEa2Q2YWRkaGRHK2t0QXVJemxpby9HU1M5?=
 =?utf-8?B?dU5BdWdQTG4xQXhwYkRJcHhNR2QrTWgwcFhFRFl0Q1BsOFVablZiR0RWaUZz?=
 =?utf-8?B?K2RqVVFDcFF3UE1QeXYzb2luaU9UaHFHeE1KZHh2bFVPWlhNek43aGd3MUd1?=
 =?utf-8?B?OXl2OUNqRUp1L2ZiZ3QzQ2FlaStYR0RlOXArK1MvQldiMWROQWlQaTRTVEFy?=
 =?utf-8?B?VEJWZVlxVDd0Z2lVNW5Sbjh5RG42cVhvcHRRQXR4ZDRYcXUybkJWSVVtN0xE?=
 =?utf-8?B?UGVLY1lWL3dBNXU0QmhuZmdYcDRGOUEycjVLMWpUOUVldHdkb24yZHJpdE9q?=
 =?utf-8?B?R1BXb0NjMlBOMTZGUHdVTnRuSS9ZQWYvKzcyWm5TNUVNN3pMZkhrRHZobUlu?=
 =?utf-8?B?RU5SeVZsMTVsSGhPa0VxeFg4bU9EZGxRTlAyeFVMTnV2ekpOWExwRTFoVnZh?=
 =?utf-8?B?KzhLQ0YwQ3dRb2xsUzIrOUVrMEpKVEU4cjExZFFoM1pPQ3NNNklFRHBQdWdU?=
 =?utf-8?B?Nmd5UzduMDZpd3pCZXR2V3NoYnRQN29veGlwWENGbDIzMHhXQTREbVNtRW01?=
 =?utf-8?B?cFZQdXRZeFVZYkM1QUk3RFBNSHd6OFBlSVovT3hUdXNBUWgyVnpLcWNnOVhk?=
 =?utf-8?B?MnZGRGhoRkF2dXhUWDF4ZjYrUDF0WXNiVzQ0L1kySVJ1NDdBbHZZZ2tFV25U?=
 =?utf-8?B?ZTF3K2pMV0FIVzlqaDYyZW9OSTNER2drVFlYaHRBMDdqK0R3Nk44bktiMkNV?=
 =?utf-8?Q?AgPaDRYtGWRC1Xcs6M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVBCeUtJcWhrZHlUaU1MODlYbm1ia3gwMVBiU3Z3akppY0JCNlZDL1JyYWpP?=
 =?utf-8?B?Nm95eDM5WjYwTjQwbEJ0aXc2VTFwVGxOM2VFWDNnbjE4Mlh2OFMzWVg4WU5j?=
 =?utf-8?B?cnhPS3EzaWdIYjFqTVVkeGhhRGpSeXZySWhXSGdTNEVrSU5ncWlodWM0OFFH?=
 =?utf-8?B?UktKUmg1QndPZGFmeVdFcTltQ0N6R25HREhsQUV5cy8yZ0JiWmJ5UTVzNHp3?=
 =?utf-8?B?OHBtdHRrZ21wejA0enFvWlJIdTMveHdaNHRFMmd6U0NodkFvR0hlRUNWTXhI?=
 =?utf-8?B?OVo4YUJOakl2eHROblpPdTdWZGZoclVyZENZMTZXTWh1RWNERnk2MkowNytT?=
 =?utf-8?B?UGtiNDZtUitNODNtd2R0OVkwdWRYcDlTdnUzKzFjNlRmVmRNZkFFQm41K2gz?=
 =?utf-8?B?VzZlRmFXS0xRaGd3WTlhMkphZXJUSEhRNDlEUklkSjdHNm5nVTYrNTh2dnRQ?=
 =?utf-8?B?OWpuRGVGV0dGTERObXRGdG15S3RNYUpMTmVTK2xqNHNSL215VVpJNHNlRXFl?=
 =?utf-8?B?aXNkVnFJcGVJd2JzTVpIaGJXQlRqbnJyZ1phVDVpZVZLRTdaTnRleGo1VGNL?=
 =?utf-8?B?S1BscmtwaklGRXFVamdEVmtwalZuWjQzRjJiRElBT3k1MTd3R1h6MjY4ZlNE?=
 =?utf-8?B?VU5NenNHb29SS0NNZjRDS0JZMk1wZDNsYlRuZ2JTWUFldi9icWM3V0s2bG5h?=
 =?utf-8?B?QWFEVmVqc1BOcHBjSitVMzZ4bUlrV1lXOUZqKzVWR0d1a1JnS0xaeFd4UXB2?=
 =?utf-8?B?V1QxUG44RUhzcEI0bWFsVU9kSThsbE1LaXQ5TmJoNTVyQ0h1aWlNTVhVSGNs?=
 =?utf-8?B?QnhvdjRTVkplR2Q3WmJQcENYR2FjSlJ6Rmg2dXN4b0l0d1FjNk5lZGNnOXpX?=
 =?utf-8?B?TnlpdlFnbVJtNDU2Z1ZkSnV5N2tlbXFLSzRCZ2V5Z0JHK1dpWnY3WHV4aFVZ?=
 =?utf-8?B?eDN2UE9naEt6emVjSGt3cUFnclliYlR6QzZta013L2VSQTd3Umd5ejhaS1Vk?=
 =?utf-8?B?ZnMwNXNpVjhvbVA3SlQrZ0xESlBrdFhKUzM2bDU1NDQ2VVgxblJXWjFCcFB1?=
 =?utf-8?B?SmVudEd2a1pRNmFLYVp4OEFmc05wT21PUFpKMTlmYXdVd3RvSG85YWt4VEdE?=
 =?utf-8?B?djdiZFhYY0lLVlo5TnU2RzVCOUoyNlpveEphcUZqQm5sanp4YUJkU2ZOSlZP?=
 =?utf-8?B?T3V3TENwYnAwM1lXWmsxQVpCeEFtS2tUWHFsQTRYN1lvNkJMUUZTY0F3MXhJ?=
 =?utf-8?B?R2ZDZzZEaVUwcFBnQ2lCN0Rady8wRThHYVZpQ2JycTdkQ09TeUp3MzlhTjVF?=
 =?utf-8?B?allOR1dnRHV1aVB5NkRJM2FQY2NrMGErZFBBTFRwa0J4MjdFYWRsa203Rjdz?=
 =?utf-8?B?VUljTnBnbzBBWGR5Mlp1UXJtQ09ycXJxQ29mZFljcDlId3diT3RmSnhEVDVr?=
 =?utf-8?B?cjdtYVREMVVHZ1JQZFIrTnlBb2JOZGlNMzFwYkgzUW9hTllqN0lxaUh0blhu?=
 =?utf-8?B?c3U1MUNnS3pUbGtIaFVrTCtJMlBJRmxRRkN2TE1mZ0ppSmdZVWRDLzg3K3FL?=
 =?utf-8?B?YXVpbGRIT1d4WTJRdG9OZVM3MXIzVUhaWXArRE82K01XUmZDekp2L1Nqd0Rh?=
 =?utf-8?B?UEtiNEo3Z1VUdGlPdnFxaitycG4wMlN5empIUllHVVFFTmw4OVgyQVpqaUdr?=
 =?utf-8?B?dy8zd1pteUNwSUpBUjM1TS9SWmdtci9aOFREbjU3dWFWcS9SZGxJaUlYTGlu?=
 =?utf-8?B?K1NQOHpCRXpQZ0lrMzFYREVGNnIwR0p3ckZPWmpud1djN0lWWjl1Q0xBOTh3?=
 =?utf-8?B?NzVxdWs3R0t4MVRJK3cvem1KUnNmZ2NRb2p5SC94R2M3OTBiMFkxdDJlOWwy?=
 =?utf-8?B?VlVOOURRMjhqbE9rS3NFeHpndVY0YVlFei9NOGZ3QzNhR1F1dzVEZnExdkJi?=
 =?utf-8?B?OVlpY3pEdW1Hd0dQZmIrWmkxNFBad203ZDhNeVBpelpMb0Z1YkxMWFRWKzNO?=
 =?utf-8?B?STBUN0dDc3lDSWJETHl1dENHMjNUM3UzcE9raGZUZVh0ektiSTZ3ZnlYNnV1?=
 =?utf-8?B?Z0VxNXZKWWxZcFFpMTdvKzMxZHkxbVdHUlYrblBjMFlqK2tLQ0V3NzNoSnhV?=
 =?utf-8?Q?uWVymOSWTcM4D48FBPtN/tGKe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64dafce0-d35f-4306-560e-08dcff887a14
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 00:01:21.1631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rAg10umlfdmr+/+7unQbJJ3F9HWRCjUMHkxA3xI8lYJYcYy8O2OnelmFN+/CWpfc3OE6PjpSv0DpF1zYWhuNDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7558



On 8/11/24 01:08, Jason Gunthorpe wrote:
> On Thu, Nov 07, 2024 at 09:00:50PM +1100, Alexey Kardashevskiy wrote:
>> I was initially pointed at this patchset as an example of how my guest_memfd
>> pinning of private memory (CoCo VM) should look like. And so far it's been
>> good except the actual pinning part - memfd_pin_folios() - expects the file
>> to be shmem or hugetlbfs and guest_memfd is neither (well, last couple of
>> months). Is there any plan to add those? If none, I will then, just wanted
>> to check. At the moment I do what KVM does which is calling
>> filemap_grab_folio(). Thanks,
> 
> I understood that the guestmemfd folks really don't want typical
> pinning behavior, you'll probably have to negotiate with them on
> exactly what the interface is?

Yup I will, just checking the plans here.

> I though KVM had its own private interface to guestmemfd?

At the moment it is essentially this:

folio = filemap_grab_folio(file_inode(file)->i_mapping, index);

Thanks,

-- 
Alexey

