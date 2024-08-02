Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9700122EE4
	for <iommu@lists.linux.dev>; Fri,  2 Aug 2024 05:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722578045; cv=fail; b=GgqP51gbCCXwHRvIAYpi6Eh4TFhNVkWFWFO9UvrL+LZK1jy0w4obOIcGkAIYbiHVwKckmz0bVjz+hN8kg74W/76pwcDlrbdwY6J0uWFM9RXmmByrtXRyNUWmoO8COrOXEbmA0cFTs5niTfwTjb9tr5xvjwQjKJ79JPghpa5ClqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722578045; c=relaxed/simple;
	bh=3wATOOywTagfSXbPZaDPj4Y+gvzhV/LEWQI6EXk0tx4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fJtu5TGtwTb4y9Dubf5qB+RM1vcGEx23L9tFQ8s6gJiXTnVNcfzLAlcvGMZqK1W6qDOQtWmiHw29HrLH7MJscR4fDitLif21zEKTMBFF7M+V+mUQExkRM3eFSs50e19XjI6AQ2wUeircdQfYLnojXfeQtfBAN546KbM+XDnaG/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pIhWn3Bn; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pIhWn3Bn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dB1MM28uICuCAO+6wWMpswTEmXALORqzK7jJ8rkT8USggfwOFT60mq2J1RRUCV6CdPPTNGuBfMNhnL4xjg1c3WRD8cmm0dYEq0+Q3RRicdYlS0OVEM9Xb/M6nb0lcyknJS6Vj2LIUOD8QSqMCRcJIALWHGwN49RtNj3Xi+1L5TKBc4BUaulC4QXQ2sGxaFHUlPjPOYsuhlDbval4WHJKcTZxTyRzBDUqw7Vqw1nMw/cGJZZrBPrqvcj9Tkd3PTWR5FMbd2goPkZsykoJCww55zvIlD1qkc/3reUBoFZHqv478lzo5aJLeTH+z2BnPXWRAXGrpy+/TFxpaTiOA85S4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dS5C/ZOgy4hS8sc816tPvNeTnMIlmyYQ5ao38640e34=;
 b=o+FFCR1H3dlb842+AEQqV5YXX4sK/ZLDOvdZKi8L1l5IEgLyPrM1KpJaCvOiDcMQ8V/xG6Tep/uqDj3jg0S0eaw8JkDhF4Z3NlImQocEUbQf2zG+kMbkYiQAEpTHhXGndS/xXbC1+ok2JoRsqqHIh/E9pkjsWKXi5icAZ7a5W3Kd9z9fFdjJOuUnwxmJ4jidtu7wL8Obl7unqhsllrGN+obKkhhgMQolsycuTzPk93EWBB4mOYJhbAdI5i8/yBBgBPyeTc6KAXEb+snkJngsIscfi4zFJc4UvoCuxyuiwoI37KeJA34A9wRYskwQUYL4Pyu0YmpUZZvcMwqjD6SUVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dS5C/ZOgy4hS8sc816tPvNeTnMIlmyYQ5ao38640e34=;
 b=pIhWn3BnEUb5nS6esyiTNFE2vkkoSLu0XqKSIYWb1ek8TpoWMjdocGcXGPoEMQ0iOllee8MwOYxB0bbQZm2yBMJzUuJ5/n7LnGpYMtfIzsM5c6iTFma7dmYtzmoYC2bj4W4gv866TLYQQKf6lYxpXWii5pmtiRTZDHQ0ixxAmbc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS0PR12MB6557.namprd12.prod.outlook.com (2603:10b6:8:d3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.22; Fri, 2 Aug 2024 05:54:00 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.7828.021; Fri, 2 Aug 2024
 05:54:00 +0000
Message-ID: <098008f7-2b3e-405a-a096-947e5df560e6@amd.com>
Date: Fri, 2 Aug 2024 11:23:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv2] iommu: Add domain type and flag to
 domain_alloc_paging()
To: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com
Cc: suravee.suthikulpanit@amd.com, jgg@ziepe.ca, yi.l.liu@intel.com
References: <20240801144523.11803-1-vasant.hegde@amd.com>
 <8e531f39-9d14-4d3b-8a52-c2e8ca026f9e@linux.intel.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <8e531f39-9d14-4d3b-8a52-c2e8ca026f9e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0251.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::17) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS0PR12MB6557:EE_
X-MS-Office365-Filtering-Correlation-Id: 234b0a01-9d9e-427b-41a7-08dcb2b781b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXd0ZXpVNkQwNkpQY21HOXR1WE4zNm9xNit0T1JrV3VGQmJxdk1KOUNhKytx?=
 =?utf-8?B?WHg1ZnRRKzY5bU5Kb2IwUlFZRTFoNFQrbStRTkdmZGZnT3NoS0JNVXFjVGt5?=
 =?utf-8?B?bEZIVlN1eWZEZHZ4UWQxTFF3aEtxVmVNZzlJM2pWY0lkdnZhNGZlaHoyMElR?=
 =?utf-8?B?Sm1WeHhWUlVXUGZ0Ny81cFR2S1h2ZlJkT3ExMjRPV3liREpnNld4Unl0d2di?=
 =?utf-8?B?MFZLSS9GYmdVUmRkNWEvNUUxOFFPeC9TZERQSHRuWUZSNzdUVmNQajdwcHVq?=
 =?utf-8?B?dDd4UHpSQ2UrbkZ0dk9XdjlJeFRCMUlPZ1ZPU01WUld4ZnJubThyNlh2V1Jn?=
 =?utf-8?B?QjVHSmxuWmJTNUg0VGFaU1BOdDlZZW9iMkFUb2NkMkJvUGJmOWM1WWduV0RY?=
 =?utf-8?B?WmJPV2w5TFY1aHFBZFQ3N2QvQVZrZGY3WUhYZkNudlZoYzBhelJtUkZycXNv?=
 =?utf-8?B?SGVsZXFMVk1qNEJjanY1T1JTY2FkKzFyc0E1SVhuMGU3WXFBQ3hIbGhwNkdN?=
 =?utf-8?B?bkl5ZnBQcFE1VHBvbHJRZk1VUS9IM3FJbGNJeGVvYzczY0gxOWFDVUdKS01D?=
 =?utf-8?B?eTArWFhjcC9sNU9LRjRVUXVvZWJUWmdTMjlYL3NyMWt3ZmM5dnZmcVdUcks3?=
 =?utf-8?B?YnhZRGVQYUVJWmJJaEJVdWNCMjRXMjBHNlJNODM0T1hBY1dXeXg1ZW5VRzVT?=
 =?utf-8?B?YUFQcENta3BKOFpIT25xZlFTNzRabW1TWTNHSHhKakNPVVlQbTBoRUQ0bnkw?=
 =?utf-8?B?OGdQWTMvemNNZkp2M0FHQlJjajREWWlaV3VDb0pMYS9JZGMyYmpUZDdIM2Vi?=
 =?utf-8?B?bnN2bzZzRE1oTlVGUDlFYWdHZm92bmhpSnBVbDg4NU9VZHJHcWd5emNYb2dC?=
 =?utf-8?B?WXBsakN3TFpWN05HUWg5SW5QSWdXQ1hNNGZpaEVmMEFGNEtoeTZYa0I1L3k3?=
 =?utf-8?B?ejFWZkRxZGVrbFBPM2FxYi9UekNMVUo3S09qQllqRkp5eHFTWWFIOUd4S2o3?=
 =?utf-8?B?TkZmSTdiU21VT0EwU2dLY0FXWmtndHV4ZU96eHpVUTdDbFZqakJRZUdTZkx5?=
 =?utf-8?B?QlNuUGFwZmt1SGYwSzZYN25vbXB4K2tyRjVpNnkwQ3lCM1lpd0ttbWFncGJw?=
 =?utf-8?B?aDgvZlZaWlI0SHFndVBPMURYOVk4N1F0M0V6RlpOM24rMGtqZ29JN1U3RzBU?=
 =?utf-8?B?enlBLy9XYjVYQXRwZGVHWUo2RFlJSWpTL0VDVFFOZkZRUHZkM1VwODBkWUJi?=
 =?utf-8?B?MDJrL1JYZy9mNXVIcWRsNzJ6UG9qbFE2WGJmZkxMRkRoV1pFWi94eFgxVXlR?=
 =?utf-8?B?L1BseFUzTjlzdFhhWHVLSURkOFN4d2FnbVN4SWxlS3Fyck5HeU8zclRUVlNP?=
 =?utf-8?B?ZDhFTlJIeFRVL1hYdmJtY294Nm5IQ3JzLzVhOElFVEpJNDRFaGZrN0o5VXpX?=
 =?utf-8?B?VURFamZOU09mYi94L1BNc2MwcG5ZVkJ0cnRwWnZqOFNKTWovekhURlRoVWxr?=
 =?utf-8?B?clZCVzgxTGVtV0V3eU41T2N6S2lYK3h2Y1U4STlWcHpyTHJBOE9uZFhlRXY0?=
 =?utf-8?B?ZHgyVWJoUHcrMHNCc3ZVbUF6OElaYnBYQXRhZE1wQjdTU2Vwb0loSDVZRmJ6?=
 =?utf-8?B?UWtxTjBPd25zekZlRmxYM3h3ZlpxRUJOUjdmMHpmd0RYa3VUV3V6V2dvWEor?=
 =?utf-8?B?bTVKREErdWc1OGdGbFdteFlIOVd4T3c3NVE1N2lsOTRqV3NtbmpHak9VTzFD?=
 =?utf-8?Q?Eg9N8kT2mxs9EsJhtKyZXWtTf8KAfrhD6dNw2ZW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUM3a2lPUHd0eWlxQ09talMzdDd2OXBOQkNraFpFMGd3eDdDTWR1MDBHNzJE?=
 =?utf-8?B?bzhFQnhycWRGWVkvWHFvWE9rdFpvYU5hYWZHakV3SjROUzRzVmJST3lWRDNF?=
 =?utf-8?B?aGFxYnY2L2d2Z0I2cTkrUjkzdWFGZkFuTUQzRXhIWEtHRW5Rck5BcWtnMDd0?=
 =?utf-8?B?eCtGeGdtb0RyekI2YXBPdmJjVjZsZmk2bDZBb2RHMlR3VFBseFZYUVNKQ3cw?=
 =?utf-8?B?d3dhOXdvZFp6TkdBRms0OE0wTXZkNG5jYlhZZTVSczUwcTRGSTdBMm5HQVpw?=
 =?utf-8?B?QnA5dTJndmVmY1RyaDVwcWs5a29kWE5aeDN6dVQreXpZVDh2UW9JZkIzcDBr?=
 =?utf-8?B?YnpLSUV1VUM1ZVR4VzBORnRVQS84NFRyeFpmZEhib1BXV1BqalVaUU0yU3Ay?=
 =?utf-8?B?VVRVVy9zM2d1dE9LcTJvSmM3a1RXcE83TmZyVVNLVmUvSzlCNmVHdWRYbTZR?=
 =?utf-8?B?ZFN2QnFhdlVRVzJpVWRTcjUvdXBFRzRHZ1JJWEhtTUFqU1Nrd20yOFA1dTJL?=
 =?utf-8?B?WGgvTVdGcHdFbnFUVCt3S3RXc0lyaldIMXFXbWJ2S0s3NEdpZmQ3b3FWeWR1?=
 =?utf-8?B?SU9PYlg4b1hyd0d3clNiSys5S0JEMEx0VStuTlJqWXhoU1pDRmlXUGVDK3p1?=
 =?utf-8?B?RGs0U0NYcllhdmxnVWw1RzFsNFlxb1Evb3MvbmdEUTVsR3hqZDk3WVIxUVE1?=
 =?utf-8?B?QlNMK0hiTWxVbFBOeHhxWHNibVBNYTNpN0ROcjh2THUweDVVaHJDT2hVSlJi?=
 =?utf-8?B?WTBXYU9kRmxkdyt5ZGY4elFjcDJ6MXB1eklEayt1RmtnNjZiZVpENmhneXhP?=
 =?utf-8?B?R0oxMDUvK2F6ejUyZ2NWREFGRXhyTVRKeER6QlhPdHA3VFVsTE5hVDBlSzZC?=
 =?utf-8?B?UXdNMzFrWjFrc0Nja1lCei81Yk5ydUtoMVM5Z3RKNG9qNTRWeXhWMzZiRUxI?=
 =?utf-8?B?TUo4U0FyVGJsc1JJUitYU0NtSk9qZmVveWlUY1JBWUJPVko1R080R2hCREFL?=
 =?utf-8?B?SzU2dXlzMFcxWHBScTRsZnExM1BhcXBBVUtlQ0xnU1FaMy84ejVyRzFwTVd6?=
 =?utf-8?B?ODdjS3RBTjhZR1Z3ZDJHa1ZzUzJzWEtJVm1QellDNnlQK1EvYU1xbzN6eWtO?=
 =?utf-8?B?MjJ6RCtNOHRQTGtzWFk0cHJKY29XL2NCWGYrUTdZdllBWk5UWEtLSm1PUml0?=
 =?utf-8?B?cnBEb1dLU3dkb1VURTNLZGo0YVJ3eWZjZTNHc0NIclNpZ2pmNFUwei9VQXBU?=
 =?utf-8?B?d2x3TVVmT2M4Q1F5UWowZUc5VG5jUlZZWTROeGd6NlJ6bkpsOG8rY2xmSWdJ?=
 =?utf-8?B?Y3lMcUZTenM5eUZpMDNOTEF4TjF5Z3dRZFpnalUrSzVPYkIrNkdpdkZYNHlw?=
 =?utf-8?B?eXozVktHdzA5bWI1blN3b1BETFoxSUFiODBFeHV4Y1pwUzRvVFl5aStFUWRH?=
 =?utf-8?B?U2h1cVlJUVV2WXBlRTQwa2Q4RXVpNmxqR0xMNUdHdFk4UnpMZkxVWG11QjAz?=
 =?utf-8?B?SDlpYm00OUpkT1A1S1dlWUM2djJQNmxqaTlwVlk1RnFtMCtqWEU4VUxlVmJ2?=
 =?utf-8?B?Vjg5ZTZPaU82THFPOGltVVZrOWZFalQ3Y1htZlFtV2hZazNPNWNYWWxJOUlS?=
 =?utf-8?B?Q2E1R3dYT2hiSzBQMzFsZFF3eUdZZCtGa1J4cHFqOWFwT2ptK0o1Z1Z2dlVi?=
 =?utf-8?B?djErMjdtczUzMkw3VjRINDdRVHhoTk9ISWNnWFRaeXM5TmlmdzBkMGdZZnpw?=
 =?utf-8?B?YkNiajZLUGRtaGowa1AzUUhzWkxEakxCYVB2RG5nam5QVGE5cHIyR2xkWVNF?=
 =?utf-8?B?azBQK1p4ckUxYnB6d3FabUJha0d2Z25aY3ZSNG5aSTl1U3dpcTJsNUI3azcx?=
 =?utf-8?B?MG5RN2dSMHlmaEUxUlVZSk5zR3grVmJRNGhCTGtVbDJlZjlDZlBNOVEzcDd1?=
 =?utf-8?B?NEpjNUpQOEcyOWM4TFpQSlZCR3h0Qkd0NkNmNTdHbldZM0o2bjAzR1lUSjM5?=
 =?utf-8?B?V0FKNkd2TFZoemc0YjJ6c2ppVy82L2NPTUVtdndNekZOaUFhWlM0bkVzM1NK?=
 =?utf-8?B?bjNENlZsS09FMkhvNXh0TTlLQ1MwSkoxcWxaMU1JT1JMd1BlaFo5TzJTMHpw?=
 =?utf-8?Q?6P7pOMnREjtotFY2C5r/VPdTX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 234b0a01-9d9e-427b-41a7-08dcb2b781b3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 05:54:00.7841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: veJlUoSh/uerqtpxk2wkL3AaV6oIhl0Nin0Q9ayBdhSMB+pbyLCSNoNmqBBnJIU1dwSgHL1IX8nGw1w3WufOng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6557

Hi Baolu,


On 8/2/2024 6:14 AM, Baolu Lu wrote:
> On 2024/8/1 22:45, Vasant Hegde wrote:
>> Currently domain_alloc_paging() passes device as param for domain
>> allocation. While this is sufficient for some HW vendor, its not
>> sufficent for others.
>>
>> AMD IOMMU has two different page tables (v1 and v2). For DMA API mode it
>> wants to allocate page table based on device capability. V2 for PASID
>> capable device and v1 for rest of the devices. For UNMANAGED domain, it
>> wants to continue to enforce v1 page table as its cache efficient. Hence
>> include 'domain type' as parameter to domain_alloc_paging().
>>
>> While at it also add 'flag' as additional parameter. So that any page
>> table specific quirks (like IO_PGTABLE_QUIRK_*) can be passed to vendor
>> driver. Once we have this we can remove ops->set_pgtable_quirks()
>> interface.
>>
>> Note:
>>    Intent of this patch is to discuss/finalize the domain_alloc_paging()
>>    ops. Once we agree on interfaces I will fix other drivers and send proper
>>    patch series. That means with vendor driver config this doesn't
>>    compile.
>>
>> @Robin,
>>    Once we have this patch and Baolu's series [1], we can enhance
>>    iommu_paging_domain_alloc() to include page table quirks and then we can
>>    remove ops->set_pgtable_quirks(). I hope this works for ARM driver
>>    (arm/arm-smmu/arm-smmu.c).
>>
>> RFC v1 :
>> https://lore.kernel.org/linux-iommu/7e249bc6-c578-40f0-aca7-835149a0ad39@amd.com/
>>
>> Thanks everyone for looking into RFC patch and giving valuable suggestions.
>>
>> [1]
>> https://lore.kernel.org/linux-iommu/20240610085555.88197-2-baolu.lu@linux.intel.com/
> 
> That patch has been merged for v6.11-rc1.

Thanks!

> 
>>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>   drivers/iommu/amd/iommu.c | 26 ++++++++++++++++++++++++++
>>   drivers/iommu/iommu.c     |  2 +-
>>   include/linux/iommu.h     |  3 ++-
>>   3 files changed, 29 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index b19e8c0f48fa..240cca8bed21 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -2429,6 +2429,31 @@ static struct iommu_domain
>> *amd_iommu_domain_alloc(unsigned int type)
>>       return domain;
>>   }
>>   +static struct iommu_domain *amd_iommu_domain_alloc_paging(struct device
>> *dev, u32 type, u32 flags)
>> +{
>> +    struct iommu_dev_data *dev_data;
>> +    int pgtable = amd_iommu_pgtable;
>> +
>> +    if (dev)
>> +        dev_data = dev_iommu_priv_get(dev);
>> +
>> +    /*
>> +     * - Force V1 page table for UNMANAGED domain.
>> +     * - Use V2 page table for PASID capable device except when :
>> +     *   - SNP is enabled, because it prohibits DTE[Mode]=0
>> +     *   - amd_iommu=pgtbl_v[1/2] kernel command line is passed
>> +     */
>> +    if (type == IOMMU_DOMAIN_UNMANAGED) {
>> +        pgtable = AMD_IOMMU_V1;
>> +    } else if (dev && dev_is_pci(dev) && pdev_pasid_supported(dev_data) &&
>> +           !amd_iommu_force_isolation && !amd_iommu_snp_en) {
>> +        pgtable = AMD_IOMMU_V2;
>> +    }
>> +
>> +    /* TODO: Pass pgtable as param */
>> +    return do_iommu_domain_alloc(IOMMU_DOMAIN_DMA, dev, 0);
>> +}
>> +
>>   static struct iommu_domain *
>>   amd_iommu_domain_alloc_user(struct device *dev, u32 flags,
>>                   struct iommu_domain *parent,
>> @@ -2860,6 +2885,7 @@ static int amd_iommu_dev_disable_feature(struct device
>> *dev,
>>   const struct iommu_ops amd_iommu_ops = {
>>       .capable = amd_iommu_capable,
>>       .domain_alloc = amd_iommu_domain_alloc,
>> +    .domain_alloc_paging = amd_iommu_domain_alloc_paging,
>>       .domain_alloc_user = amd_iommu_domain_alloc_user,
>>       .domain_alloc_sva = amd_iommu_domain_alloc_sva,
>>       .probe_device = amd_iommu_probe_device,
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index ed6c5cb60c5a..d8a67b39a4cb 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -1946,7 +1946,7 @@ static struct iommu_domain *__iommu_domain_alloc(const
>> struct iommu_ops *ops,
>>       else if (alloc_type == IOMMU_DOMAIN_BLOCKED && ops->blocked_domain)
>>           return ops->blocked_domain;
>>       else if (type & __IOMMU_DOMAIN_PAGING && ops->domain_alloc_paging)
>> -        domain = ops->domain_alloc_paging(dev);
>> +        domain = ops->domain_alloc_paging(dev, type, 0);
>>       else if (ops->domain_alloc)
>>           domain = ops->domain_alloc(alloc_type);
>>       else
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 4d47f2c33311..72383f6bdd9f 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -565,7 +565,8 @@ struct iommu_ops {
>>       struct iommu_domain *(*domain_alloc_user)(
>>           struct device *dev, u32 flags, struct iommu_domain *parent,
>>           const struct iommu_user_data *user_data);
>> -    struct iommu_domain *(*domain_alloc_paging)(struct device *dev);
>> +    struct iommu_domain *(*domain_alloc_paging)(struct device *dev,
>> +                            u32 iommu_domain_type, u32 flags);
> 
> I still can't see a value to pass the domain type in this callback.
> Different domain could have different domain allocation callback, hence
> the domain type has already been implied.
> 
> For the paging domain, there should be no difference between DMA and
> UNMNANAGED from iommu driver's point of view.

That's true. Its all paging domain. But we need a way to indicate the desired
capability like PASID.

I thoughts we can use `type` for allocating domain and then `flag` to pass the
quirks. Otherwise we have to club everything in `flags` itself.

Something like below works ?

  - DMA-API domain : flag - DOMAIN_ALLOC_FLAG_PASID
    If both device and IOMMU supports PASID it will allocate PASID capable
    domain (Like AMD case domain with V2 page table). Else it will alloate
    non-pasid capable domain (In AMD case it will be domain with v1 page table).

  - UNMANAGED domain : Do not pass *_PASID support flag
    Since PASID flag is *not* passed, driver will decide best suitable page
    table (in AMD case, we will allocate V1 page table)


-Vasant

