Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C089219E4
	for <iommu@lists.linux.dev>; Mon,  1 Jul 2024 10:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719830895; cv=fail; b=H1gP15I090fvpAbNof3BhfieELlPVaB77M6edGUAqcVK0Yn979QnQKStd64j/u0jX8ieNqLMCWaD7uiyrlaobeK58Ro0ZPcyaSVQE87C0CQaMVUYKbJiFZ0LePbmYruXFpj8uPEGu9BeNA/Kekr85VZJa0LRJCH4sIhKKgl+bQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719830895; c=relaxed/simple;
	bh=kvmPxOFEFiZtN3aIZCAEaBhcVa4s1SWLod8skv3sZeI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lu5pal1PEMAGHNCZex7440Jt9LiydU6+BVO6SdziY51JPmHMDrzDYEG4jQOftux3k4giw4ax7Fbfh9i0chfd7en0yzayrEQj5qcjNEhPuN1gMGiPac8j7XHkflbeLJx4gKwD7d6lNVceJe8exNoaFTDuGulfSNPFsgXOsbEHmI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1xLB9z6Z; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1xLB9z6Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwLS54ZXqdwLhoj3c8SBc6sCtHTDuzYe2bxm+itNdJo38kt8xenYaLqRylBDJ2EQkRWD58Vnqg/Fu1IpV3+zZmGy/mtXZzJSdPCgaKj44ZHdQh3qDnBgvt9sEywkny47ibBGh33XxKICIaZ31MP4It98w66CiPIr63BH4dp6jJbg5Wmtt0Jlnu1ybnkX+dlQWL6tDBLGzaK7ysfsZlLTpgwwtFGehCFBGDxVBTTHk9LKkCnAWgN7n364qPpeS8knCW++cMKMg6S6g5sMZ1fSyIhmMHPtcGEESf61hj4HFM7+BhCsaZHWKQq4WA+532JiKVc7nyKGdFbapOmuYl1vgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKe3Qe8nEgJvfAAefSFw3dhdUYPEcqAYaswsvqGAIFU=;
 b=ePI43VghqX86309GUD6rLHZnl8nLZvdNC6FRPRq5BjRBXbDvJD7lZMZe4SAaDIMq3QLXeAAVBQfktp7oBOXjsnCfmACb7Do2shY58jq0v6rj8GpYJREzqWMCqHW+ChbNWLy1S2ycZz4qwu2Tiz87tLL+NTA+cyISqLLKJtqBM3NDlBGUPfr/U3aEjnR5JlR3rhdVn0p5GCPjB6trowRfh8EyWCagL5IFJ1MsxH63+ue3Lgd7A1t5SpIyZTaeXaZrGTKsQ2f9KvfsCOiFuh8Ogu2t8Gk+e7cGE8bepn5t3qgmovLchHpobcMeYbrd4elGLSvxv2+iIajg7ORrze4qSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKe3Qe8nEgJvfAAefSFw3dhdUYPEcqAYaswsvqGAIFU=;
 b=1xLB9z6ZFjFRWP+mfsSw5GgLWXQkohGca4gByDN97SD30NUHmz8V9s1nnklMdwRTVgBubOOFqmi+1Ti84VsHqUgv5cna8pgqUoBuvoJQB1zscxN5Kf3U/n/pmJwP4NyreKCpdMBwPL7pDgCeHMtzKXUJQ8K+Vl+ZLOLFa0yumFk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CY8PR12MB8337.namprd12.prod.outlook.com (2603:10b6:930:7d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.26; Mon, 1 Jul 2024 10:48:10 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 10:48:10 +0000
Message-ID: <1f8f04e5-3b70-45de-bd93-e3c96fb0a555@amd.com>
Date: Mon, 1 Jul 2024 16:18:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] iommu_ops->domain_alloc_paging() enhancement to support AMD
 IOMMU driver
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <joro@8bytes.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Baolu Lu <baolu.lu@linux.intel.com>
References: <7e249bc6-c578-40f0-aca7-835149a0ad39@amd.com>
 <20240628130330.GY791043@ziepe.ca>
 <26524622-971f-47f5-936e-d0173d342288@amd.com> <Zn77FbsQWmByf16t@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <Zn77FbsQWmByf16t@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0014.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::29) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CY8PR12MB8337:EE_
X-MS-Office365-Filtering-Correlation-Id: bc8b6d69-e62f-4bf9-a3d5-08dc99bb4ca7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTBTNXRGTE9IZ1VhcDhoZ2Z0bWdlU3haaWtrK2JWck5iM2QrMFVHMDEwSkFn?=
 =?utf-8?B?SHoxS24xSnBDeXN1MDlmcTF4MGxoZUtjeTdhM3BSY0JveFdvbWdFRUtYUis0?=
 =?utf-8?B?WitBQWh6Z0piOERNNmxwV2I5d3FjcVR6dXdGMkEyakJHbTZIZXROTnJSRWpH?=
 =?utf-8?B?SlhzVXRtZ0REcDdxMzZkQngwU0prVm5nenZXdXBjbi9ockZ5bGZGZVcySmZ5?=
 =?utf-8?B?dWRjek9aV0RmSS8vbTVYRm12T3orc1l5Ni9EaEd0UGpBNjVseWY5UkhDYWRF?=
 =?utf-8?B?UlFvYXRMaEFEajVjQ3ZvNzhLeWh6Vnh3RUhTSnNZZHZWZWl2elZQQnlBenlP?=
 =?utf-8?B?VXNENXc0eFNiMk05OFFRVVpEaVdqMXNkU0xtaXlpMmtIRTd6T1Voa2F3eFlG?=
 =?utf-8?B?RERwNWlSSzUvMHA3OTJ0OTF0OFhUeUJ2RTA5bC92cjY4T0NMRmlMZDhFYnJE?=
 =?utf-8?B?aDY3d3N2YjFFbmhZVGpYdjdkRW16NTBDQXQwdi9nemdTUmdUWG03dWtrNlZP?=
 =?utf-8?B?Si9RbGlmVkwrTnNhRHhyVzNWbFVBaWtHc3ppeHFld1JzVzZDM1ZsY2t6UEtu?=
 =?utf-8?B?dmE0aEJ2NjFTdjBYSzd5RXdYNnhzTXN3MHJTcGtIQWc3dUIrTk5iTk1mVDFX?=
 =?utf-8?B?ZlhtSVdjRjZpMVFrUXhURmFBcVZuUS9vM0E0SFN0cEZsaXBOZGxpcDZQSFdy?=
 =?utf-8?B?YWxadUJtd1M1cjBRVi9ValB1cG1sUzJNTjB1SDZwUlRva2xGVlRIODBoZ0Vq?=
 =?utf-8?B?K3NxTFYrZlViZFdaZTBSanA4ZXE2VFYxWHM3cHNjMW1BSWgvcXJPSW44cSt0?=
 =?utf-8?B?Ulk0NWNIbFg0S3FDc29XNXErU215SHVENmdtNnJFMllvYzlZREZjckdhVlpn?=
 =?utf-8?B?ZHFWcksrWitGS0FHdzVGSkEzMStuQkd4c1VOWW01V3VCY00rdVNCWHRVd1Bo?=
 =?utf-8?B?cjVXcmVjQSt0a3JTc3lLbVJkOUlNRGZpb1lIR3Q2NDErWXZuSkh1ZWV2L1Bt?=
 =?utf-8?B?S2pFbzllWXdYa1BUSDdyMGtISXo1TU1admFTK3J3aFMzOHRTSSt1Tk1ad3Nz?=
 =?utf-8?B?cDZma3pJU0NqeXFvR0RBQmhWeWtUYjdpZUVIOHRQdTRuWFRTY2Z0OGYyam9q?=
 =?utf-8?B?NUxmZjlndWM5QnliOEJxZW5ZamMrVmwvdzRXVk1mZ0VKek5QRGNoallRT0hC?=
 =?utf-8?B?L0c4QTltVmFhUndrc0tjQXB6YWpxN1lFWnk1eDRlNU01RFY2ejhqWnVRK0Mw?=
 =?utf-8?B?K0huK1BCbXZtT3ZzaERXcnRWY28rMUtLSzEyaVB2VmNlSDU3ZWpNRXdLKzFK?=
 =?utf-8?B?M3VLR1hYWWJ1YkI3KzFxUzBGZTRXektqcHpwTXYxZURFUWtXeVg1b2tYQklQ?=
 =?utf-8?B?VEc2MzVjYWo5K2JyYnJvZXpyb1dpTHhhUlR5VzJnZEFYWDZNR3pSWDdIem1C?=
 =?utf-8?B?WklGeHpqZGxMSXhuUTN4RlphWFErd0NkVC9qdXUwOXlTSnoyOE84ZWdyTmhV?=
 =?utf-8?B?dE5mejQ0WExOSURVamh5QWZyNzdCUWx0TmFTeXhtVWZaOXQvcmkxMUJYS1Zr?=
 =?utf-8?B?VGdKa2pPOE5QTllWQnBZbTVweVQyR1VnOU11dE5QclJNM1RNRC9QUE9EMitz?=
 =?utf-8?B?d09vZktGaXJyN2RvRWcxNGY4SXJBTG9uSHd6YVhFSSsrNEZ0Q3FFcWdwWnIx?=
 =?utf-8?B?YmsxQy9DamVYd09STm5iZUUydURZUVBxSE5GdFA1UWFOcTFscXpmY2hBb2pC?=
 =?utf-8?Q?VeoUe49rrTl4FfleZ0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEJjd210cHdGQ3ptMEpRYVZhSHhwQjAyaHpYOWtFeFdlZGxseDh2RlBBMGR0?=
 =?utf-8?B?ck9EZys2NEhmWER5eWlvZ1QvN2QxelVxZGxUUEdUUUZwcDc3bExqWHRCUGlk?=
 =?utf-8?B?MU1vWnBwYmdJYnRiSHNHTkFHYSttQXdoZllMSnRIZ1VhUjlFb1dQN2JRUmN6?=
 =?utf-8?B?V0hwNy83MzV2eGpaaFhqcFdjQmdWUGRMUG5HTmJhclFaZXdXUmRnTnlZcXdt?=
 =?utf-8?B?TVA2K3NNTXBCRTZzcVlMOGdwaDVPaVVtdjIzNldyaktsZFZhdjM0Zk5YblFJ?=
 =?utf-8?B?cTh3S3ArKzZUOUU2QnRXdUk3UnFzclRTWk90bFJBbWgrREQ2V0dXdDdFbXpY?=
 =?utf-8?B?aG1kRjlLemlFK2Z2TlpUYTdUUVdSYnhyL2Jzd0gvQm05bUl4WWFaNmVsZ2E1?=
 =?utf-8?B?QkRIQkFlNHp0RFBGdCs4K242UlFPUjFoZEtuMEkyTjg4L3ZkZlVDZFVFS0JJ?=
 =?utf-8?B?RXljdjBsTG94NkNTUk9lbkdjYTZjRklTeGVPSlAzZWQxbUNpaTJQUERPWE1p?=
 =?utf-8?B?d1lUQ0VWdllIZkRDcDN1akVQUlM0d0tUV3NjTVFGRE5WbzhjWjhjUlh5UE1i?=
 =?utf-8?B?L25LVER5WTYvOEN5V1NQeVhJYUpock1OUWJiUEdRTEp3aENqTE0zT3A1RDNP?=
 =?utf-8?B?bUF3WHlXVnRObjU1ZHdoTWVyTmxjcjdPSHc4L01rWWpBS3NzUVIwR1N6ck9s?=
 =?utf-8?B?aS9jUU9SVWwxQ0hkc1dYcU8vOURUTS9sTWhYRHBYbjNxTG5USGtMbUFERjEw?=
 =?utf-8?B?UnkyaVEwb2p1Q1R1bEJaMGNLR0ZlK1pSKzdGSzVIVUszM3dicGxVNDlENDQv?=
 =?utf-8?B?R2RvOEduMGtzN3E3TEJiK2xyZ1Vya3NIeVlQR1RsYThIV3lzUmNoM1ExdEJC?=
 =?utf-8?B?Uk0rdmZ2bDVCWmY2NEczTzgvR3JkbFozWHFPR0hvc3lCaW0wWmt2ODZqcGtO?=
 =?utf-8?B?Tm5Fcys1RG5lOTJYK3hQa1YxK2VqUnJDa3pTMUIwNmtyZWc3cXg1bCtMRkNH?=
 =?utf-8?B?VC9WOU5XSHF2NzdNR3YySDJ1U1RhZ3V2WXpIWUJYUk9rRUdMM0JncjZ6MUY4?=
 =?utf-8?B?TEx6bTN3Yk9iZmd0TFlWbEgrMTNVOUwxMUVVeHNJZEFqMGpmcWJZVklmRVBT?=
 =?utf-8?B?N3pRcnFjTnVHdTdLNU9wMXRHUEJiVkVNRSthc2JTSGV3bldseVdqNFBJeldK?=
 =?utf-8?B?Z3N2K1ZiZjkyRDExQzUvTnFlNHZPbG9Cb0V0UUFBdXBIbmtOSkl6L2k4Ym9U?=
 =?utf-8?B?QjNlRkFmUEw2cXpUS3k3cWxSRlUvK092RWFEZHVQcGRYRzFlbG5DdVdkZGNa?=
 =?utf-8?B?VXFtMzkvQTRRNWQ2RHlOMTZKMGhuSThPYU03Rk41Mjk0ZGxRS2lCRnprZ21t?=
 =?utf-8?B?S2plS3BSZFJtd05pNmZ3bzdlQWJFSWplSmJxZkRaNU4xV0VhNSsxRHJYRzRS?=
 =?utf-8?B?S1dFTzk4TEgveEhndlNkcmZ0WktrdHNMNlQxM1JidVlpbDU1N1l2SHZhSEZQ?=
 =?utf-8?B?cnVaaHQwZXI0eVBBZXZJWnhNNmJRb3JoT1RVZFI1dzBGRnRWd1V0YTlBN3hp?=
 =?utf-8?B?Y3dEUkhteVlvM2J5YzRvUytPYlE0MUVSQkR1WmFsOGNVQ1lVRCtIL0lBUmds?=
 =?utf-8?B?K21WVUZtYUxQck5ETGpqVHAyZkRWU3hhZDFtVXpkM0RWWU1MM21KbzJCblpY?=
 =?utf-8?B?cVZPTmF0MWwyUlR6NlBrOVVnNTF3WWRuOWVpSGJTQVdBQzh2ZkNLRzJENFh5?=
 =?utf-8?B?UVRBUkN4V0F0NFBoTEh5UVo2OGZpZHdtUUU0UnM1NzA5SE1QU0plQXk4S2tF?=
 =?utf-8?B?NHgxZHRBajBWWDJCVVhmQU9MVG5mSUd0SWJwUnhaRWJ3K2RST3FqVktwd3Fj?=
 =?utf-8?B?aHBNNzJ5N1ZJaHJQY0gvSmZ4d3UvVjVqRHlIVnJSeUVad3hJc0FmalJPTytj?=
 =?utf-8?B?dFdHM1hOR21UN2R3V0ZHY0k4OHZ6dSs0bERvZVppRDl4emN2UDJhQmtJNzgv?=
 =?utf-8?B?dDFEbTV6MjV0ZlBFbGJvRUN2RG9nUmtwK2tQZVVHRitGV1RpQUtTL1VzUDFx?=
 =?utf-8?B?YjZQbS9ac0llelUrWFlmNXpTZVpnZFVpVjFvK1huVElzaHlOZktNU3hnNDdo?=
 =?utf-8?Q?Ikwbes0SFMtSY5u6hy5rB4njg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc8b6d69-e62f-4bf9-a3d5-08dc99bb4ca7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 10:48:10.7423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oWY+Kj+0AoUhIlWs1h3uvqO8Bf7ELtVltaCuk0dAg1YO/Kf/B7UpMCeNKAf5wJ50aV4ssYJrbEWpVMOkTplxaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8337

Joson,


On 6/28/2024 11:34 PM, Jason Gunthorpe wrote:
> On Fri, Jun 28, 2024 at 11:19:23PM +0530, Vasant Hegde wrote:
>> Hi Jason,
>>
>> On 6/28/2024 6:33 PM, Jason Gunthorpe wrote:
>>> On Fri, Jun 28, 2024 at 12:13:43PM +0530, Vasant Hegde wrote:
>>>> Hi All,
>>>>
>>>> We are working on adding domain_alloc_paging() support in AMD driver and came
>>>> across below issue.
>>>>
>>>> BACKGROUND:
>>>> ============
>>>> - AMD IOMMU HW has two different page tables : V1 (host page table) and V2
>>>> (guest page table). Only V2 page table supports PASID and PRI features.
>>>>
>>>> - With V2 page table we have an aliasing issue. Hence we added
>>>> per-device-domain-id when domain is configured with v2 page table. See upstream
>>>> commit 87a6f1f22c97 ("iommu/amd: Introduce per-device domain ID to fix potential
>>>> TLB aliasing issue")
>>>
>>> Yes, but IIRC this is a shortcut to developing a proper packing
>>> algorithm to optimize the IOTLB. HW like this that has aliasing issues
>>> needs some more complex SW support to get optimal usage.
>>>
>>> ie you can share DIDs if devices have a logically equivilant GCR3
>>> table. Optimizing this is a SW problem inside the driver and should
>>> not leak out to API.
>>
>> Its not just SW issue. With V1 page table HW supports variable page size. (not
>> just fixed 4k, 2M and 1G). So in terms of HW cache management, V1 page table is
>> better.
> 
> Okay, that does make alot of sense.
> 
>> Another issue is with VFIO device passthrough and mixed device passthrough (few
>> w/ PASID and few w/o PASID), type of domain we endup allocating is depends on
>> the order in which VFIO requested for domain allocation. So its not deterministic.
> 
> Yes, VFIO is not good about optimizing disjoint domain types to
> minimize domain requirements. This probably does need some more
> work. You have the other problem too where if you attach the non-pasid
> device first then pasid will be blocked and this is not expected
> either.

Right. If we solve the domain allocation issue, then we can fix our attach
device path to solve this (Yes. It needs code change. But its doable).

> 
>> By the way, can you point me to your series please?
> 
> https://lore.kernel.org/linux-iommu/0-v9-5cd718286059+79186-smmuv3_newapi_p2b_jgg@nvidia.com/

Thanks.

>  
>>>
>>>> Please let us know which one is preferred -OR- is there any other better way to
>>>> handle this.
>>>
>>> Neither is really going to work. VFIO will have to assume the user
>>> will want to use the PASID API and will always request a PASID capable
>>> domain anyhow.
>>
>> Even to make PASID support with VFIO, some way it should communicate the driver
>> saying like "I need PASID capable domain". So that driver can allocate with
>> right page table type.
> 
> Well, that is already implicit in the fact it asked for the domain from a
> PASID capable device.

All we need a explicit indication in domain_alloc_paging() saying allocate
*PASID* capable domain.

> 
> What we perhaps need is for VFIO to have some way to evaluate a lot of
> devices together and decide on the best domain configuration for the
> full set. It prpbably makes little sense to have a v1 page table and
> then a copy with a v2 page table, for the PASID device.
> 
>>> We already have a path where the VFIO userspace can request a v1
>>> domain by using the NESTING_PARENT flags during user domain
>>> allocation.
>>
>> That's with domain_alloc_user() API right? As I understand that should work fine
>> for AMD driver.
> 
> Yes I expect so.

Thanks.

>  
>>> But I don't see any option here that doesn't involve userspace itself
>>> making a request and indicating it wants a degrated VFIO
>>> functionality.
>>
>> That's along an option. We can explore it later.
> 
> But there is no later.
> 
> Your said your desire is to get a v1 domain even if the device
> supports PASID, and VFIO will get PASID support likely before you post
> your patches for this. Yi's work looks almost done to me.
> 
> Then VFIO will just request the V2 domain anyhow and you are right
> back to the starting problem again.

Let me see if I can put together here.


- Basically we want domain_alloc_paging() to explicitly tell domain requirement
(ex: allocate PASID capable UNMANAGED domain)
  If we do that then we will fix ordering issue I described earlier.
- Fix attach device path so that for 'PASID capable UNMANAGED domain' :
  non-PASID capable device will use AMD V2 page table with GCR3[0]
  PASID capable device will setup its GCR3 table as well and it should work fine.

Net we need a enhancement to domain_alloc_paging(). Otherwise I don't see a way
to reliable implement things.

Regarding performance impact: Thanks for pointing out. I will start discussion
in that thread. Lets see if we can come up with something.

But these two can go independently?

-Vasant

> 
> Given your remarks it may make sense that VIFO disable PASID support
> by default so that by default AMD does not have a performance
> regression. You should start discussing this with Alex in Yi's series
> to come to a decision. It makes sense to me at least.
> 
> If that is the choice then the idea of adding some flags/etc would
> work well.
> 
> Jason
