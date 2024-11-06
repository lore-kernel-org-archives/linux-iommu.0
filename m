Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2062.outbound.protection.outlook.com [40.107.95.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851C164D
	for <iommu@lists.linux.dev>; Wed,  6 Nov 2024 03:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730863117; cv=fail; b=U1o5F5s33WImGSiTEcmYboyQgIbuzs1MxGCAnXV+nbwSI4zXME+od0eke6IUcBgvUNgXuzo9p4uB3pAauNZdJnlpo5U+OqcmAbAe8FPgHM0rVVxBnt/8nhySPqGIrrE9PhpkLWJ5o8EeiPk9+6AZ7r7JW4LgspxsY0DnKYyMpcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730863117; c=relaxed/simple;
	bh=yvI3qwek6dZMqq72o7ZmvUFh8fYGBC5AF7fe+NDms1I=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZUl4W1m87Opcxp1A7MYLT8KF2/n9Vevmm2gwVUTmzc3Gt3VMa/t2snV2iEGpnbQJoOg0pjH/CVPh0cd6vHBYbvcCHLVu9J9zZIpCufp/6ik4R1DzXgCwn3epj+toNSlmmwAqT2GLPWwUZ4SpouU/cSedEg11xqcsP+0v1IaOzsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vHz7Q1cA; arc=fail smtp.client-ip=40.107.95.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vHz7Q1cA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ma5mCAWHZyjlgqm3a9hu6nDqKQa5pDYoIUlejt64NXXdqF7UXcnpFhDCBHw8Woj2dmfaNMIzHg2BIKSJ3LKJc+x8I3nOocj3cQ6kHFzH2jslezvriM4GyxN418Q4VGIcq+WzMALIL+8RsXW+okxwr4/cG0RLci1NuzUp6Xnyi13rxUCQloKOQs2yT3F6IkiwuPl54EJhFNRUvsEHuWf39mwm6nw9vbj6qwRqip6ZzoQeIHIN84hjaaBgxTi8EZIJx6f37tDmVjr5lZ1PeLb667RyZzCLVNH3njiXX0JbCIUdqewHPIdAMEz4eKwWvhwX4dNE/dI0QkLDdDb5kua5Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HtNQfKnRLrltyquhe91MepBaUR5/QeMXWYrFQfHfwA=;
 b=Xc9t6Q3gIP6cMrdnMhhyZVxXaAdpw2fyH4WfP9pcNiqif8YKYYat6Tk+OB4Qq3APWwiaxln0vEs8YJwsXADZR7EDn88A23Ig6BPHWnFEH5bkFUsKjkje1JEFVWt9J/rwKm+6Nj/z/rXC/QSrC6FaATiyT7A+2ZXaMKekrhz3GC5kGxms6kMMCmNU56w0RTL8dH7Blk/gtRUW0WVsmmB+1xM7PbLy1L4KS30FqKKReiZSh5Ujef+LuSKZNrf40GIrchAsxF+Lvd+Jafw1apuA7aVjxHa0ZRTSIbN80iMkCfm+7iqwMV/Wpg9MBAL75zfB55wSxSCUzISSBWWa4alRtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HtNQfKnRLrltyquhe91MepBaUR5/QeMXWYrFQfHfwA=;
 b=vHz7Q1cAwtDRgvcVneOKD3VpxOqAhMpV6qxGgABas3yj4jUbGh+TGQF8gNNm82Zh4Bmdqz29UmcjU6JZQVhSMUTlaRZbxmcOgFH3Vlnl/mzN8Lq+EuZzFhXTXB5xBSeXgUuHowrsiSzr7TlxucLtngPjkkngDnMYsxGS4cr2nis=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by IA0PR12MB7554.namprd12.prod.outlook.com (2603:10b6:208:43e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 03:18:32 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%6]) with mapi id 15.20.8114.028; Wed, 6 Nov 2024
 03:18:32 +0000
Message-ID: <7788773d-471d-48ad-9f9c-ddd5671b26e5@amd.com>
Date: Wed, 6 Nov 2024 14:18:27 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH V7 6/9] iommufd: pfn reader for file mappings
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
To: Steve Sistare <steven.sistare@oracle.com>, iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <1729861919-234514-1-git-send-email-steven.sistare@oracle.com>
 <1729861919-234514-7-git-send-email-steven.sistare@oracle.com>
 <8f2fadc0-1872-49db-83aa-314352adbb6a@amd.com>
In-Reply-To: <8f2fadc0-1872-49db-83aa-314352adbb6a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SY5P282CA0013.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:208::8) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|IA0PR12MB7554:EE_
X-MS-Office365-Filtering-Correlation-Id: 3862d2ce-9703-4ad7-9fe1-08dcfe11b168
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?andwQko0eklvZ3ZiVytST1dHeENSZnJyalZrZlgwTVpCRkJwbGRHN0ZLUzdu?=
 =?utf-8?B?b3VNdmFEU1BPdjQyWjN0Qk5tbkt2OXBUNngwa3Z0RTBvaVJOVkZsMWMxNi9h?=
 =?utf-8?B?SE5hbUFLQVhjWXRkNENhWUNLdjJnazhEZ0wyVG1Ba1NVMDRlWEkwdGttZVRx?=
 =?utf-8?B?bjhOZUFib3RreUFVcXdvT2tPU2p5SjB6dEtEbTRvZXo4UjYvTmtES3hQZFpQ?=
 =?utf-8?B?TzNvd2JsaEJrOW5YREFHcXVIc2NWV1NRV0Z6YWRwZCsxYmkwZXM1YnJoTmNX?=
 =?utf-8?B?YVp0UHZnOFhickgyQVR0T2JzNURhYjF6aUdBZ2srNm5KbjN2MWJzS3E2cEN6?=
 =?utf-8?B?STBVUFNaaEYxWEJkRlFKOWxOZ2kxUXlPM3ZJa3dhRGNPQXV6SFZaWHl2R3Z3?=
 =?utf-8?B?OHhSM3c5dEdaVFhNVE9hVVlzazJaN0ZQUGpCdFJHaElPQ2pIcldrSU1SWkhu?=
 =?utf-8?B?ZDlhayt2eHFoc3hNb2FrUFgraUtBVHZjYWN2VXIvT3RUUWdMZmdneUw5d0VK?=
 =?utf-8?B?Q1dvQnplNVNUQ2Q1K1M0RHQwME5aS2d2a1ZsSTBnUnpsdmpCSXpwenBNN3VY?=
 =?utf-8?B?cEQ1Tm5lZXlTZ0xxaUdEWG1ieVB6Ykw1RVNscS9KMTRTVFRtVys1aU1kUUQw?=
 =?utf-8?B?MmZvcUJhTENaR2JiMXA5aFVkUm5keFlyWjNTQXlKTk1BTmhPdlYxQ0VybFQ2?=
 =?utf-8?B?b24xZjIwSC9IejVERUEwcnl5TU1qSyt2bW52anNsOFZWZkxEdlBZVEszSHhO?=
 =?utf-8?B?TTF4TzhlL2xGbHg1VXZvZ3NleTJyL3BrN3VWQmFuaEZVK0ZzVnB1OGJEdW9q?=
 =?utf-8?B?d1hVUWQrbCtJOC9EcEVIU2RkV25ySFd0c242cTd1NFUxS3NOcUdUUkJveW1l?=
 =?utf-8?B?WHUwZldodWJ6MENxSzhUS2ZkK3VCRUVsUnQxMEtyL3hwMFM5WHNqbkdiNWJE?=
 =?utf-8?B?bFRkQTE5ZDFJYVBsZnViK3lTbGc4cUhsK2VQV1JOWUp2dDRuUDk5U0p6RUo0?=
 =?utf-8?B?bnkzYmlYczZXV25qS2RjaEt4Z1FUcGxRK2JYdTlPL3ZaRmdVS1c0MDd4ZlJJ?=
 =?utf-8?B?aC9VWVA4a292OVlhMndjTTlOaUd0STJ5WWVZWTNEL0ZsbFN0cXJJN3dxSkVy?=
 =?utf-8?B?U0lSeHN6dUFkbVlTZ0dLQ3ZOUzlHOHVRdTk1dFVWeW5YbGVJZk1LV1JaWWp6?=
 =?utf-8?B?bkYrY0dYOUVoMHpZei9iczlPNU01VzdWejkrSHlBdVBuZGV4NlFUdWVGMnNR?=
 =?utf-8?B?OVhmR2NsT25rSkppNFNKempWeEFlajE1WlJ6NVZwTTdPcEd4cldpNHFjYVN6?=
 =?utf-8?B?dWU2cXFtcllQRGp1Sk4rWnFKMUhoUEl2bDdiSklENm1OQ1Rnck05SlNWZjlI?=
 =?utf-8?B?QnNSKzMvckVmTVdOR1lTT2o3MlVhZU5qOXhOYkNHaEtIa0xtYXQrelo2R0t4?=
 =?utf-8?B?TWRsOWltcWFjYVhVaEdSZ0NFemM3UEE2a05kcHVkdEVOZWlFdFYzZjlyOWpB?=
 =?utf-8?B?aHhnUUJ4czJSOCs0WFBBRHhyY0U5SnNQak9UbklYbk94RUJnOGZJbmdVMlVQ?=
 =?utf-8?B?R2FEOWJWdG9nMDd2QVJkVTRsRlR6b0F1MUFhdGJpeVNPeEg3cW5qZ0QySXJJ?=
 =?utf-8?B?WlQ2UVVsd3FsWGxWMkhTd3MvSkZEKy9LUXgvMk1BQzc1T1NIRFU2Z0thN2F0?=
 =?utf-8?B?Q1EyaVVtd1BtbXI4Y2wzMGxvQ29TMXBaTjZmdlZhUlFuTHp5dFcxZU1kNGVz?=
 =?utf-8?Q?ERxAyUYkXH03ddK9CVDIIckJE4CF5RbtLtHZJ7e?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dk5Dc2oyWko2S0oySWtOL0hyQkdMTDdjU2l0N2dkaG5zV3o1MUhyaW9mNzdi?=
 =?utf-8?B?RlRCZWVnL3QwdklMU1ZlcndSeng4L2h4aFhpVEh2eFBCaG02QlF1TWdoNzB2?=
 =?utf-8?B?bWxXQ0plN2Z4R2xOYXluYjBlUE1RdVhyekxrUTRLYzdocVlaRkZpeDZyUUlN?=
 =?utf-8?B?UEpkYWRGMVU3VEpIaXRFdGhwanlhUjJjVUJnTmIwZzU5S3B5bVNuQnVJRUxE?=
 =?utf-8?B?TEQxVGJ6V3JJSWYxY3VYc0xqU090TnNZdVhCaWl3TlYwazZMTzhCQk8rRlVS?=
 =?utf-8?B?S3ozTmZJY3p6WE1BcnVtQzBaMzl1c0xWc0p0eW0yWDNlMjNKZ2hZY3lyMkVt?=
 =?utf-8?B?L1BkcVNOYk9UT0pyU284VEo1dmhrRWVvZmlxcktwSHMzODJ6RDRhdFlwYkFK?=
 =?utf-8?B?SzE1RDBVbmFiTlhYOUxIazBiRlVSL3RYWmlwQUxZcGRRYWdHSlFCNkFxeTZi?=
 =?utf-8?B?Q3p3elVRNWdtOVg5Rm1OR0NQZGRTbTZycUdkZ0srblVxeTljdmtGa3NtS2V0?=
 =?utf-8?B?Y0JudlJqakNiUmlDZE9Ub2RYZzV6TG4zVkFPbGsrellaNXdTY01xZi8xSDl5?=
 =?utf-8?B?bHBZM3ZaODE0ZXUyTDVMd2NiSEZOSXJMeDhLc3BLbm0yVE5YaTd1dzQxQ3ly?=
 =?utf-8?B?bnRUeFVKV0dJK0RCNFZlcFlRcHdGdnZhOXBxQnVHcEVJUHkza3N0VDdTbTRN?=
 =?utf-8?B?cTlTSVp1TkV6QzhyT2MrYWxqRlBwcTNZSk1KcFZ6ZG5RQTFWbDRaNU11Q2I5?=
 =?utf-8?B?V0F1MXBvUWdsLzZUUnArREkxZEhQMUp5ajBaTWFoM3NYZUxreFZhNC9EckV3?=
 =?utf-8?B?SE0vdFduVURWK3B4ZzU4anVndmxFeW4xdWhhMStOdEhnUTB0ZVRGRDdoc0M5?=
 =?utf-8?B?NUh5RUx0RVM4dmIzd2FEaHJqZjFHYWhDeEpUYWpZa0hjOUwwVUs1ZjhiYll4?=
 =?utf-8?B?MFE4YTBHOElJSHNFK3h0YlhqV2crWU83R1RpaHlEUzdObDZ2cmpNTW83VkNR?=
 =?utf-8?B?cjJMODhOYURnV0p0alc1K1VpQ3VTcm5JcVd4VWVxZ2xaU1lRMjBjSVgyZUtw?=
 =?utf-8?B?ZlVIdnphM3RYMXN5UmhZWExRYm5Pd3JqYnk5VmgyTnFLSDRiMTFnOGp1NGFt?=
 =?utf-8?B?b1E3ekNUZ3hVM2hPU0QxczhyTXBrWFhRVmdEd0ZPSUNFTTl0NzRLb3JrbkZj?=
 =?utf-8?B?bTVxSGxPUXZaOEFRT2JDUDAvY1duWHVHV1pUbXRDbUs4NTVIeHE3cWVIYVJ2?=
 =?utf-8?B?Q2NnZkRjSm9laUhCZUk0VHg1UGZ6NVJ5TXM4VEVkZWhJOHJSODF5UDladUd4?=
 =?utf-8?B?NkdUL2UxQmZoTXFqem5aZnpDWm1iZ3FvVUgzQy9jS0NhSCtlQ1kzek5CYmRR?=
 =?utf-8?B?OEg0Q21kTUpXQXZQQ3NOYy9GWUNQWjBEWVZTMWNWUkR4cGlZVUVWYnEwTU9h?=
 =?utf-8?B?WmtwNFBhaDlIU29HSFhRbGlMYUg4SUVmOUxpRUMwaG1KaGUxSjJ0eW5QbFR5?=
 =?utf-8?B?bGtGQzlkeGZuK1VVYzBwS0Vvd2hUWWxQdkwyS3RndjJKc3l5TDc1Z3ZRUTlW?=
 =?utf-8?B?d2crUEJnNXZ4ck44RzBDb1JOWkYrVXAxWFV0cGNGaW5ycXdQMlJKSjRsdmpn?=
 =?utf-8?B?bWlCRHVFVTVONVZibnFOcEM5VXJDOWMzVXJvTUJvcjc2T25IdXdrbFFJUVJ0?=
 =?utf-8?B?ZXVKNk1xWTJMZndrRUtvYUdlOGpINS8xc2FvWFI3eWlVaWdKTndHcGI4UnNn?=
 =?utf-8?B?czlUdnBxRWViSisrQ2drWTdZaHozbWNpN3dCYmhIVCtVRmR2amNOTkljcVdU?=
 =?utf-8?B?K3hjOEgycWNZOCt1QmNyaVRZbk85alJtcDNKZGpzcXB3Vnk0VGNyR0VwL3Fl?=
 =?utf-8?B?MEtoV2kwVEdXdmp5WnAyV1VoTi9jQ1JMT3NvM1FHMEcxN3d3V2gvaURpZUdh?=
 =?utf-8?B?RnBRY3kxcllDUmFNcmFDOWNxQm1QWEFUZ3lrVUg5cGs4cUhTNm01eU82ZWxY?=
 =?utf-8?B?L1RHaUhHMTV1Mjh2RVlVcXFSd1RHRTV0VTRNOTZFQ01kZEJ5UmExSEdmNmI5?=
 =?utf-8?B?ZDNVMjVkMXVPQy9BTDFKWHJqZXBYTU1wWnZzTTJzTzBIcEpacEpYQktJMGRr?=
 =?utf-8?Q?xSt1lBwGXMf7LOVXFxUDEZbte?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3862d2ce-9703-4ad7-9fe1-08dcfe11b168
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 03:18:32.7566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z+Ciw2vfDCQ2o/vcz0qDLshV4eTBkqYhkfjGb3zB3QhPWQyT+MMKFetAZOcxmfsKIzxRSCKYnCj5RFwDu/5rTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7554



On 31/10/24 14:34, Alexey Kardashevskiy wrote:
> On 26/10/24 00:11, Steve Sistare wrote:
>> Extend pfn_reader_user to pin file mappings, by calling memfd_pin_folios.
>> Repin at small page granularity, and fill the batch from folios.  Expand
>> folios to upages for the iopt_pages_fill path.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>> ---
>>   drivers/iommu/iommufd/io_pagetable.h |   5 ++
>>   drivers/iommu/iommufd/pages.c        | 128 
>> ++++++++++++++++++++++++++++++-----
>>   2 files changed, 116 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/iommu/iommufd/io_pagetable.h 
>> b/drivers/iommu/iommufd/io_pagetable.h
>> index 8e48266..5ac4eed 100644
>> --- a/drivers/iommu/iommufd/io_pagetable.h
>> +++ b/drivers/iommu/iommufd/io_pagetable.h
>> @@ -177,6 +177,7 @@ enum {
>>   enum iopt_address_type {
>>       IOPT_ADDRESS_USER = 0,
>> +    IOPT_ADDRESS_FILE = 1,
>>   };
>>   /*
>> @@ -202,6 +203,10 @@ struct iopt_pages {
>>       enum iopt_address_type type;
>>       union {
>>           void __user *uptr;        /* IOPT_ADDRESS_USER */
>> +        struct {            /* IOPT_ADDRESS_FILE */
>> +            struct file *file;
>> +            unsigned long start;
>> +        };
>>       };
>>       bool writable:1;
>>       u8 account_mode;
>> diff --git a/drivers/iommu/iommufd/pages.c 
>> b/drivers/iommu/iommufd/pages.c
>> index aa79504..5f371fa 100644
>> --- a/drivers/iommu/iommufd/pages.c
>> +++ b/drivers/iommu/iommufd/pages.c
>> @@ -752,19 +752,32 @@ struct pfn_reader_user {
>>        * neither
>>        */
>>       int locked;
>> +
>> +    /* The following are only valid if file != NULL. */
> 
> 
> Are "struct page **upages" and "size_t upages_len" still valid in this 
> case? The code (kind of) suggests they are not... Thanks,


Ping?

Also does "user" in function names mean "userspace addresses" (as 
opposite to "file"? If so, the patchset makes many names misleading 
then. Thanks,


> 
> 
> 
>> +    struct file *file;
>> +    struct folio **ufolios;
>> +    size_t ufolios_len;
>> +    unsigned long ufolios_offset;
>> +    struct folio **ufolios_next;
>>   };
>>   static void pfn_reader_user_init(struct pfn_reader_user *user,
>>                    struct iopt_pages *pages)
>>   {
>>       user->upages = NULL;
>> +    user->upages_len = 0;
>>       user->upages_start = 0;
>>       user->upages_end = 0;
>>       user->locked = -1;
>> -
>>       user->gup_flags = FOLL_LONGTERM;
>>       if (pages->writable)
>>           user->gup_flags |= FOLL_WRITE;
>> +
>> +    user->file = (pages->type == IOPT_ADDRESS_FILE) ? pages->file : 
>> NULL;
>> +    user->ufolios = NULL;
>> +    user->ufolios_len = 0;
>> +    user->ufolios_next = NULL;
>> +    user->ufolios_offset = 0;
>>   }
>>   static void pfn_reader_user_destroy(struct pfn_reader_user *user,
>> @@ -773,13 +786,67 @@ static void pfn_reader_user_destroy(struct 
>> pfn_reader_user *user,
>>       if (user->locked != -1) {
>>           if (user->locked)
>>               mmap_read_unlock(pages->source_mm);
>> -        if (pages->source_mm != current->mm)
>> +        if (!user->file && pages->source_mm != current->mm)
>>               mmput(pages->source_mm);
>>           user->locked = -1;
>>       }
>>       kfree(user->upages);
>>       user->upages = NULL;
>> +    kfree(user->ufolios);
>> +    user->ufolios = NULL;
>> +}
>> +
>> +static long pin_memfd_pages(struct pfn_reader_user *user, unsigned 
>> long start,
>> +                unsigned long npages)
>> +{
>> +    unsigned long i;
>> +    unsigned long offset;
>> +    unsigned long npages_out = 0;
>> +    struct page **upages = user->upages;
>> +    unsigned long end = start + (npages << PAGE_SHIFT) - 1;
>> +    long nfolios = user->ufolios_len / sizeof(*user->ufolios);
>> +
>> +    /*
>> +     * todo: memfd_pin_folios should return the last pinned offset so
>> +     * we can compute npages pinned, and avoid looping over folios here
>> +     * if upages == NULL.
>> +     */
>> +    nfolios = memfd_pin_folios(user->file, start, end, user->ufolios,
>> +                   nfolios, &offset);
>> +    if (nfolios <= 0)
>> +        return nfolios;
>> +
>> +    offset >>= PAGE_SHIFT;
>> +    user->ufolios_next = user->ufolios;
>> +    user->ufolios_offset = offset;
>> +
>> +    for (i = 0; i < nfolios; i++) {
>> +        struct folio *folio = user->ufolios[i];
>> +        unsigned long nr = folio_nr_pages(folio);
>> +        unsigned long npin = min(nr - offset, npages);
>> +
>> +        npages -= npin;
>> +        npages_out += npin;
>> +
>> +        if (upages) {
>> +            if (npin == 1) {
>> +                *upages++ = folio_page(folio, offset);
>> +            } else {
>> +                int rc = folio_add_pins(folio, npin - 1);
>> +
>> +                if (rc)
>> +                    return rc;
>> +
>> +                while (npin--)
>> +                    *upages++ = folio_page(folio, offset++);
>> +            }
>> +        }
>> +
>> +        offset = 0;
>> +    }
>> +
>> +    return npages_out;
>>   }
>>   static int pfn_reader_user_pin(struct pfn_reader_user *user,
>> @@ -788,7 +855,9 @@ static int pfn_reader_user_pin(struct 
>> pfn_reader_user *user,
>>                      unsigned long last_index)
>>   {
>>       bool remote_mm = pages->source_mm != current->mm;
>> -    unsigned long npages;
>> +    unsigned long npages = last_index - start_index + 1;
>> +    unsigned long start;
>> +    unsigned long unum;
>>       uintptr_t uptr;
>>       long rc;
>> @@ -796,40 +865,50 @@ static int pfn_reader_user_pin(struct 
>> pfn_reader_user *user,
>>           WARN_ON(last_index < start_index))
>>           return -EINVAL;
>> -    if (!user->upages) {
>> +    if (!user->file && !user->upages) {
>>           /* All undone in pfn_reader_destroy() */
>> -        user->upages_len =
>> -            (last_index - start_index + 1) * sizeof(*user->upages);
>> +        user->upages_len = npages * sizeof(*user->upages);
>>           user->upages = temp_kmalloc(&user->upages_len, NULL, 0);
>>           if (!user->upages)
>>               return -ENOMEM;
>>       }
>> +    if (user->file && !user->ufolios) {
>> +        user->ufolios_len = npages * sizeof(*user->ufolios);
>> +        user->ufolios = temp_kmalloc(&user->ufolios_len, NULL, 0);
>> +        if (!user->ufolios)
>> +            return -ENOMEM;
>> +    }
>> +
>>       if (user->locked == -1) {
>>           /*
>>            * The majority of usages will run the map task within the mm
>>            * providing the pages, so we can optimize into
>>            * get_user_pages_fast()
>>            */
>> -        if (remote_mm) {
>> +        if (!user->file && remote_mm) {
>>               if (!mmget_not_zero(pages->source_mm))
>>                   return -EFAULT;
>>           }
>>           user->locked = 0;
>>       }
>> -    npages = min_t(unsigned long, last_index - start_index + 1,
>> -               user->upages_len / sizeof(*user->upages));
>> -
>> +    unum = user->file ? user->ufolios_len / sizeof(*user->ufolios) :
>> +                user->upages_len / sizeof(*user->upages);
>> +    npages = min_t(unsigned long, npages, unum);
>>       if (iommufd_should_fail())
>>           return -EFAULT;
>> -    uptr = (uintptr_t)(pages->uptr + start_index * PAGE_SIZE);
>> -    if (!remote_mm)
>> +    if (user->file) {
>> +        start = pages->start + (start_index * PAGE_SIZE);
>> +        rc = pin_memfd_pages(user, start, npages);
>> +    } else if (!remote_mm) {
>> +        uptr = (uintptr_t)(pages->uptr + start_index * PAGE_SIZE);
>>           rc = pin_user_pages_fast(uptr, npages, user->gup_flags,
>>                        user->upages);
>> -    else {
>> +    } else {
>> +        uptr = (uintptr_t)(pages->uptr + start_index * PAGE_SIZE);
>>           if (!user->locked) {
>>               mmap_read_lock(pages->source_mm);
>>               user->locked = 1;
>> @@ -887,7 +966,8 @@ static int update_mm_locked_vm(struct iopt_pages 
>> *pages, unsigned long npages,
>>           mmap_read_unlock(pages->source_mm);
>>           user->locked = 0;
>>           /* If we had the lock then we also have a get */
>> -    } else if ((!user || !user->upages) &&
>> +
>> +    } else if ((!user || (!user->upages && !user->ufolios)) &&
>>              pages->source_mm != current->mm) {
>>           if (!mmget_not_zero(pages->source_mm))
>>               return -EINVAL;
>> @@ -1068,8 +1148,15 @@ static int pfn_reader_fill_span(struct 
>> pfn_reader *pfns)
>>       npages = user->upages_end - start_index;
>>       start_index -= user->upages_start;
>> -    batch_from_pages(&pfns->batch, user->upages + start_index, npages);
>> -    return 0;
>> +    rc = 0;
>> +
>> +    if (!user->file)
>> +        batch_from_pages(&pfns->batch, user->upages + start_index,
>> +                 npages);
>> +    else
>> +        rc = batch_from_folios(&pfns->batch, &user->ufolios_next,
>> +                       &user->ufolios_offset, npages);
>> +    return rc;
>>   }
>>   static bool pfn_reader_done(struct pfn_reader *pfns)
>> @@ -1151,7 +1238,14 @@ static void pfn_reader_release_pins(struct 
>> pfn_reader *pfns)
>>           unsigned long start_index = pfns->batch_end_index -
>>                           user->upages_start;
>> -        unpin_user_pages(user->upages + start_index, npages);
>> +        if (!user->file) {
>> +            unpin_user_pages(user->upages + start_index, npages);
>> +        } else {
>> +            long n = user->ufolios_len / sizeof(*user->ufolios);
>> +
>> +            unpin_folios(user->ufolios_next,
>> +                     user->ufolios + n - user->ufolios_next);
>> +        }
>>           iopt_pages_sub_npinned(pages, npages);
>>           user->upages_end = pfns->batch_end_index;
>>       }
> 

-- 
Alexey

