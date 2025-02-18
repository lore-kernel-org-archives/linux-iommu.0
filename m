Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382261D618E
	for <iommu@lists.linux.dev>; Tue, 18 Feb 2025 22:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739919369; cv=fail; b=kNYxwysnTyoYXe5nFXXE8dEt5w/x9HUzZ+dlioEEpvXfSTO8zVoMlc5/wL268Ili8D4T47IQs+FyXJJ8ViKamMQcX4/eMXhIkgJM3o3R7gf3WnnZT1WO0K/Ia2rGdI1lgSCSqkh3seT0Akq1oagz/IjBzTBo2O5MhaZsjJzWPVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739919369; c=relaxed/simple;
	bh=cKjKwYeeIFZePcUeQNc3bxeKy3C2RPLWqh1N9jtlPXg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h2qE3Gs6GrOss+4GNm2p7zhf89gzca1gcSMuxfccU7eg+Y1d/7HNJYLg9WAlaOs37E4gdmrWkVikr/R3JMbi9XtAczYKekTby+AwPwh2VAiWfCgUh2UL3lMNgZ26XPvrKRvt/chq3FN67GV4cn9nwGakrEV+x0C4OY+r/aXazRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qyvRYIjN; arc=fail smtp.client-ip=40.107.244.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qyvRYIjN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rDLxiIKarwt3cpaZ+tNeMN3RqYjG3c/8yvg/ABGFYK/WXCOxZ5X/m5gjUraRNJSLJ6X+/J+P/ntlPVQkzIhV4O/oyWGxdKZCqceU/iHMapVCdxMnxqM3Jjzi/fBAsqjmrXRyRJTuyUoRhGLt39aOK8i1GXRyZpY8zVVxxIullBDnMAPCCO/xjlJoCkfCfPR/bc61FQlqimZh1GaKkso9WtP/gErP6rPkDZP21sHU5M2Nn0HoBuA6TxPSUDWFTdCvdMbqKMOrtQfqrv9aCC9FqRj2o+hZrh6FaRQhuEGHXXfxSxMdVAScdDWJiMMQOJe6psHEkTZijxJ2QQW83Jo3bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stKeqAwqtTskc0sL4ZUl8qh2+DC2bQQPFFZ6QaX3dH8=;
 b=mM6h+JF2s17YSDJchi5YPF5wa/aPHFa7sR8ah1IHIarTt81tiJ+uKXKoWTWWw3lmUIKSdn8tBJ8my0gsxscsWdkXyStxco6myikN4onwGSiGSrtH/D8ynCMcM+JQQ8+U6HRP2H1snl5X54ENnE5uzDmjplwX1HYaaGLoGzuquCfWFN/GkTRYAO+FuQJ7Pq7zTonRTvzNmuRjPFLQGnf421f525uz0kV9HulzVx+mIPxJKImVk6ZPbhkizbTpOK8H6NzEkUUv7n5uvzPa178uZNbkEqv/M8VMzGLTTeU3gKQFaUAPbB2lM0EE9nnZajpMB6g6c3WnPLPRkBSd8SMPcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stKeqAwqtTskc0sL4ZUl8qh2+DC2bQQPFFZ6QaX3dH8=;
 b=qyvRYIjN5Fsb4uDsrbNhhp4/dVag7U3EIZJBSgu7kAeqp0trN+apLjt8ZRWpmpcLuxWxnVaRO3ZrxLuESXCwvmQ2PBqbbq9xelmiXNJvtdVf9zB3GwHDz0P2Da5MHmuuhtJ0w6E2FSnUynz5JgnWvTay1l1IhyN3zZDfW6iYpbp8ND89TY0fj7qQ4PmqqB/3PIAbM4cdnlrWjWFMGUnN7kmEW3SVoO187/Sj4fFMGtW6k1e8u6qVdpCccOrxLtJ9DqyQkZxgxOJKjYNoEjiwTKN7U8nk+0wq9Zsp2JvGS5Z6b9k/ZdG1Azwo2Gl7gurY3tbFkHVcHPJSHxmYINTo2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 MN0PR12MB6367.namprd12.prod.outlook.com (2603:10b6:208:3d3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 22:56:01 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8445.016; Tue, 18 Feb 2025
 22:56:00 +0000
Message-ID: <94b6f4fa-8a92-47a1-8938-b838ce19d122@nvidia.com>
Date: Tue, 18 Feb 2025 14:55:57 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] dmaengine: idxd: Remove unnecessary
 IOMMU_DEV_FEAT_IOPF
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Vinod Koul <vkoul@kernel.org>, Zhangfei Gao <zhangfei.gao@linaro.org>,
 Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
 <20250214061104.1959525-10-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250214061104.1959525-10-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0065.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::42) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|MN0PR12MB6367:EE_
X-MS-Office365-Filtering-Correlation-Id: 66645076-e87d-46e2-a9e2-08dd506f69a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGxpUEN2Y2hNNzB1eG1tcnRTaDN6aVNHa0g3N0tYS1hDelp4MEZTd3ZCZzV5?=
 =?utf-8?B?aXF3ZU03UnhRblN1alNVN1oyN2pJVmphbjFxU0prL2hXVlBPcWlyb1FaUXRv?=
 =?utf-8?B?cWR2VjhnVlRaQ09rSk91MjBwY0ZidFpLT0xzSnR2RVZWeU83dC9EMmZNOW1Y?=
 =?utf-8?B?cmFxbm5aUFBFLzQ5YVk1QjZxYUZ5S2FjVkNkNlN4Wm00dUpTelA4SUdsUGd5?=
 =?utf-8?B?Sy9Kcjl2MSszMlBybzFKUDZNamsvSTRLNWFVdytxOWVZeE5Xc1dRZExUdHNS?=
 =?utf-8?B?Y2VrUVlMSTVhSnZWTVVWb3Y0dkVaMEJBMGJyM2RrK29HOXlKTlIxNXoyU3BD?=
 =?utf-8?B?cWZoemJyaGZiNjRURElDbWtPRjVadEtwTXgvRmZnNG1lc011UXlJK1VJWVl4?=
 =?utf-8?B?WjRDY2pFZ3lSa002NlVYc29NWW5mWjhIU2tBeER5SEozOHJ2TWhiRXBzdXRm?=
 =?utf-8?B?Uzd5ZExjQzAvNWd6MlBFajRPNS96ellNRFFHUjRtUElYT0xZMmdxNVdZcnZU?=
 =?utf-8?B?SUM5SXI2ME5lcGJDcWs4amF6Nmh6cXRtenpGYnF2SWxmZWlPMlNhNEtxZXdm?=
 =?utf-8?B?NE13UkQxaTBHbW0xUm5Qb3U0Z3RucXRDbllBWi8zUWZBclBacWI4NE9rbUFN?=
 =?utf-8?B?ZzVvZ1BSeFRsM21EWENocXo3bGZ2MFNWQTl2bXlPUXQ5QXBhd010M0wxb0kv?=
 =?utf-8?B?Q3Qxb016UXFpZUZoVGF3cGZlaitUNEJ3UXkwUEpzMkJNbFhDZTNDR0VFWG82?=
 =?utf-8?B?R0J2WC9BSk9GaXFnbDMyeTIwMmhKYUpPd08rck4yTHZvMHFiYUVXVWlzT3ZP?=
 =?utf-8?B?eU41dXp2SU9OZHhOS1JxZ2crSDRXVTFIWGRVSVFkYm43N0k2VXVOc3dsZHh3?=
 =?utf-8?B?RDVMQ04zb3BsWWcwVy85QVpRQ3A5N1BUYml3TXlmejEvVmk2MlBBdjN4cWF1?=
 =?utf-8?B?VWp1WWxGazBISEMwcm5OMmRXYWtnNzNmNzI0VzJmbysrZkNCQlFNdTJxcW9S?=
 =?utf-8?B?MXdzMGlFT2ZvdEdTekJvY0RtdmcweXpPMFNBMW5aOVEwQzhNaW9tWHozU1NU?=
 =?utf-8?B?c3c2WU1NM3BBZHYxOHF3U2ZSV3QrOE16SUFyRGVTdlRrbWpHVUhvVGV2T2tt?=
 =?utf-8?B?VHlMM1A2UVJ3dHNqeTVpVWdTdHRsUzlwVjlsMit5bzdkVnl0T1RuVlRnVGtZ?=
 =?utf-8?B?UndxWE1lSDBTbVJwN0MwSFhuOW94cTBNbE1iKzRFSFZSZnBPVzZsRzJOQk9q?=
 =?utf-8?B?NWNZVTdGVyt0VzJqaXgxVDc0dXVNTFR0WERqN3lQUGg4NzB6UzR6eWE2Z25I?=
 =?utf-8?B?NWJaVkc3cVJwYTVqVmpuMmw2YzNwLzBXY0hjNlk4ZlUzZ3plU0VaUkRjcGV3?=
 =?utf-8?B?Vlo0WVBCNDRhekZxSU9CQUdIRThTTCs1anFyMndyK2E4ZnpwWnVhaHZkRlE4?=
 =?utf-8?B?SVZSSndvYm5PVzZBY3RZbWxwMitnZzRFbUtYRTNGZG5KUWY4REh4QUV5d3Nm?=
 =?utf-8?B?YnBvOHd1WjJrR282TkJucmRSWlBaZ0xJMFNybk04aU9DdHorRkxnZ0twRXFn?=
 =?utf-8?B?Y3QzeGdsVm0wc2MxTDJEaDRhc2IwRi95RUNRanhhSnpHMFJEV255Y0c5Y1lo?=
 =?utf-8?B?RkxNT3FkQytGYUF2N3lKRExGRTliWTRFcE9YeGwwMTN4M1lKd1ZvcG9vOXBF?=
 =?utf-8?B?YnE5ckdMWXlhd3RwZHRvUnpCVjVURitBNngvbEcwWDdaV0pCQjZtUy8vWmYw?=
 =?utf-8?B?VnhCaHZBZHRsalpPNno0MGpHMGpUWU9mRUltbmQxclljZzdhdDd2U2w2U0tI?=
 =?utf-8?B?U1lKd1JBNG1vZzVMNElUY2NKRXBlYldFL1JtZGoxK0YrU1lKVjdKdDVObW15?=
 =?utf-8?Q?FfDBBnW+If0f8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dG9KNm9zbkl0b2F4U1NEMW14RFMxUXZvUHltLzV3U3ljMm5YUUU1eWNGQzBE?=
 =?utf-8?B?NVVXaUlOelV2eUc1T0JTWVN1eDZybmdLT2FoRE04ZEYzV2JGM2dkaW1tS1lo?=
 =?utf-8?B?TEpFaDE2QTV5MVBYYWtQQnNidUpZbEdIc0dwZ0YvK0dydHNzdUdMb2tsSzE0?=
 =?utf-8?B?Um9oZ0ZYK0luK2xUcW9RWXM1TTlnSktkM2tYZCswVWRsV3VhY3BUOE5Ga3VC?=
 =?utf-8?B?b3VrTUcwaUVaUTNPZnAxS2ZwN0NZZFZLWW1zZmxGSzhOUDJCcWs1VW1XTzk4?=
 =?utf-8?B?UnZOMTNtMjROMFd0b01USUc1VzdhbFd2QnVEd01VOEpDWkI1NU5nRm5Ua1Jj?=
 =?utf-8?B?SldYMXhLbkFBT2ZOT0dtLzFYZmVzOUxpR2l1TXV3R1dQblcyTU4yOU5BYWN1?=
 =?utf-8?B?bE5JNjRTTUhVZElXaGMycVJtWXV3MUdmdmtnTGN1L0VmSVc5VWZ1R0FSc25w?=
 =?utf-8?B?L2JFbVZNckZCZ1ZvaHA5NU9GZkl0ekhKcGdFa3lQMCs5S1pyNmhRdm1PMGRx?=
 =?utf-8?B?Y3dzMHdhazNTRXRBRzMwcTR6Ym1EK3VQMW9JQWUvS2h2SDJPR3ZwUWtpMGhi?=
 =?utf-8?B?NDBTdGprNVFHRTMvTFQrNXkwUEs2T0xUdmoyTFJJcmU1RUhFd2RLNTZtTERx?=
 =?utf-8?B?a0UyNkdlb0RyNEdIQWZmbkhpSUw0Mk1nSzd0MGxwandwaUZ0K0hBa0NXZjMr?=
 =?utf-8?B?VTVxRVNkS0plRGhtNDBTVkNLOXhKT2R3RHdycW1EbWZRU3pwNnhraVZQWmZo?=
 =?utf-8?B?ZFFGekJzcXFJMEd1R1FNOWxtSk5URVhXY1ZCRUs2eTRydGl5L2k5cjJka2Jo?=
 =?utf-8?B?WnljeVZINTZxMHExNGc0ZHQyNnY3ODRUMHVXNFZLREg0YU9kVzFSa1NoRjg3?=
 =?utf-8?B?ZFIvYzV6Wkd1MjFpRzVLU3ZMQ1ZNTkV5K0Vxem9SSiswUG9wUnBWdnhIQldG?=
 =?utf-8?B?ZWdZTFp3OVRLNzNXTTVtMWFrYk82UmhCdGdleWp6SFloUERrZ0YwZVgwc2RC?=
 =?utf-8?B?MHJQN3RFNjJ1NVhNVk9BOU1tR0hYUXdaK3Ayam4rSzRZb1JnUjMzMklVVlk2?=
 =?utf-8?B?WStnQXU2OFNBNXh6Ykdrenl1ZHdxam9NR3lOUVMrOTdwalNxUTd3NmVoZWJv?=
 =?utf-8?B?ZEtBZ1FnMmlDaTExVy9ZSXpselFwMWZtVE95SFptL3AvNE84c0tnb2lVcnNs?=
 =?utf-8?B?VlVLdHdvbzR2ZzNLcWwyeWtERCtnNHVMRllPRlpwellwSS9ueWNpbUNodURh?=
 =?utf-8?B?UmRFK09IclgyblB2bHB5NDF2cDZIb211bFpUUysyd3hBa3hQSWlyeGdRSjR1?=
 =?utf-8?B?OUFmbHplQ1ZzOUJsSFZiUEhMRnFiOWxKQXlsLzdEMXNVbzZKMzhBT3ZONHJj?=
 =?utf-8?B?MERWY0ZFbUVVNWpiQkxuaDlXK0xQV0FYeTNBR1pieUZ5SmQxaExQc1BjYlJQ?=
 =?utf-8?B?R3gyaEorSnJFOWdubmV2cXF1MzNsR1JRd1NyS3VkREZZVEtkbWQ2UTZ2SGFn?=
 =?utf-8?B?bFVVdGJ3ajFydWVNRVFING95NEVIUkt0OW5CbzlnSWZFcmxKWURDZTM5TGtm?=
 =?utf-8?B?ZDZ4akp2UlhodEJENXF4cHVuQkF2NjRsNWhTU1pFUW52bzdJVmdma2x1Z0tO?=
 =?utf-8?B?VStUK2RVVkR1Uy9OdFd4RU05QXRsWG9ScllaK1FwZmJCY1k4Mm14TlpwWlls?=
 =?utf-8?B?alN6N01maVNscmZ3YlBnSk40SGtaTUhUNnN2V0pMTHhEUzlZcDFXSCtRQkd4?=
 =?utf-8?B?bkdFUElNeDZzYVlSUTFmcTJiSlczZkpoR0FWVkU2ME1Sd1kzSlROeXk5NENV?=
 =?utf-8?B?a1hMYUhNcEFvcGgrV2xLM2l3dzV1OWRMK3hvQU1GQnBrQlJwMEpHQXVhMVdu?=
 =?utf-8?B?VHdIVnZCWUw4eENhN2NySFlMQWRPV3hjYzlPS1NsN2FDZncwQzZLWFQ3cWY4?=
 =?utf-8?B?aWltbUV3RHdxYVRXbHRLMFN0NHJwM0E0QmM0UjFCa2RVMUVKbFRFWUl1THM3?=
 =?utf-8?B?UjI3bU8wRmdiMVgzS3kzT1BUZlZsZm5wZHNkWWUyTUtmeVRkOUQvdVJFblky?=
 =?utf-8?B?RnZEVXZPT093N1hUWkJWQVJMdXE3T2dUSTBheVQxVThhREx3Z2xYL2FFM2Rl?=
 =?utf-8?Q?ndQfQSDO3zwXk1GoYNjnAB3hP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66645076-e87d-46e2-a9e2-08dd506f69a4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 22:56:00.3088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mcnk+BM4jWgSVQPoBZJN2z3dz50jZoz5t3VCjqa1gB6hiu5nfLQ3qe3VCIlwxxs090ZjyagdWmE+AtCzhRcdOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6367


On 2/13/25 22:11, Lu Baolu wrote:
> The IOMMU_DEV_FEAT_IOPF implementation in the iommu driver is just a no-op.
> It will also be removed from the iommu driver in the subsequent patch.
> Remove it to avoid dead code.
>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> ---
>   drivers/dma/idxd/init.c | 37 ++++++-------------------------------
>   1 file changed, 6 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 1e5038cca22c..d44944195807 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -626,21 +626,6 @@ static void idxd_disable_system_pasid(struct idxd_device *idxd)
>   	idxd->pasid = IOMMU_PASID_INVALID;
>   }
>   
> -static int idxd_enable_sva(struct pci_dev *pdev)
> -{
> -	int ret;
> -
> -	ret = iommu_dev_enable_feature(&pdev->dev, IOMMU_DEV_FEAT_IOPF);
> -	if (ret)
> -		return ret;
> -	return 0;
> -}
> -
> -static void idxd_disable_sva(struct pci_dev *pdev)
> -{
> -	iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_IOPF);
> -}
> -
>   static int idxd_probe(struct idxd_device *idxd)
>   {
>   	struct pci_dev *pdev = idxd->pdev;
> @@ -655,17 +640,13 @@ static int idxd_probe(struct idxd_device *idxd)
>   	dev_dbg(dev, "IDXD reset complete\n");
>   
>   	if (IS_ENABLED(CONFIG_INTEL_IDXD_SVM) && sva) {
> -		if (idxd_enable_sva(pdev)) {
> -			dev_warn(dev, "Unable to turn on user SVA feature.\n");
> -		} else {
> -			set_bit(IDXD_FLAG_USER_PASID_ENABLED, &idxd->flags);
> +		set_bit(IDXD_FLAG_USER_PASID_ENABLED, &idxd->flags);
>   
> -			rc = idxd_enable_system_pasid(idxd);
> -			if (rc)
> -				dev_warn(dev, "No in-kernel DMA with PASID. %d\n", rc);
> -			else
> -				set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
> -		}
> +		rc = idxd_enable_system_pasid(idxd);
> +		if (rc)
> +			dev_warn(dev, "No in-kernel DMA with PASID. %d\n", rc);
> +		else
> +			set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
>   	} else if (!sva) {
>   		dev_warn(dev, "User forced SVA off via module param.\n");
>   	}
> @@ -703,8 +684,6 @@ static int idxd_probe(struct idxd_device *idxd)
>    err:
>   	if (device_pasid_enabled(idxd))
>   		idxd_disable_system_pasid(idxd);
> -	if (device_user_pasid_enabled(idxd))
> -		idxd_disable_sva(pdev);
>   	return rc;
>   }
>   
> @@ -715,8 +694,6 @@ static void idxd_cleanup(struct idxd_device *idxd)
>   	idxd_cleanup_internals(idxd);
>   	if (device_pasid_enabled(idxd))
>   		idxd_disable_system_pasid(idxd);
> -	if (device_user_pasid_enabled(idxd))
> -		idxd_disable_sva(idxd->pdev);
>   }
>   
>   /*
> @@ -1248,8 +1225,6 @@ static void idxd_remove(struct pci_dev *pdev)
>   	free_irq(irq_entry->vector, irq_entry);
>   	pci_free_irq_vectors(pdev);
>   	pci_iounmap(pdev, idxd->reg_base);
> -	if (device_user_pasid_enabled(idxd))
> -		idxd_disable_sva(pdev);
>   	pci_disable_device(pdev);
>   	destroy_workqueue(idxd->wq);
>   	perfmon_pmu_remove(idxd);


Thanks.


-Fenghua

