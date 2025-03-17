Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C112B21A436
	for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 11:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742210672; cv=fail; b=YLVuixjUhRJBJTq+s4iP3NwEOKgUxE3yLY6Zaq/zX8atdVPQWJfm/8JipS8IgC0+MydGPsZRlUtWESb/ss91TkfQdxUzDGf98bbIpbf46C9xkX9vDwRmrWat91V0XIxMl/MdnfagnaVpQNFWArTUSJNa+A0zvO0qTAfl4UQrmJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742210672; c=relaxed/simple;
	bh=opwQ+mwMbIOcg4bcR2Ttg8j02HLBPavDRfzIPmE5u30=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dsTRUe4yX4I1/DaanK1MawV6TCtU4Pmo4RNlfwLJBty1LgpUAWO4aDqg6xrM60nwR10w7bh25KGNcnlequYwDb2Me/me4z2/pSSnv68qBWZ6dGDLDIt3bbRG2QQ7HPC59ajSQjb1gxL5iTMPTsleZKZ0/5WDwdgVDrqBz6MsYuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H7oCv7dD; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H7oCv7dD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CdXB/8f8sqmS2WiPGnzKoWXgNNP5ITg0d9Xx35dhnvGPgyeggwVKoRoYu/h/UOsmY+3Jzpq6NK7sCjMgLZKMsszRmN+vS/8L46J0lZCu0NM/XiS/6rtE+JUJT9ojAGYPhNr6VWcakyBdOIiOGe9at0O3BpjwqomJ1Pnbk+xiAW4x3UIXF1/Xz59BAkRw3Hatb8mX+W9ZyF8Qo2wYVsfgrSmcGgKGQjGdiVnPZeGnJRxkj7b/qS9yfJFqFaLxENRqMAqWZ3lElWWD/CJq1B6xwIZ+MbYqN2R88YnjPwKyUCIpab/8fmY13cKy7o/sW4NfxndJg6sExr+V/czALsuq8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ImU5hGWxts4yPuCqDw4e644yljQ254AAK2J5VQx1GX0=;
 b=T/IjbzfiRXKUKK0tmn+uS9Fb3tt6N9nBpob/5zCkKQ+RkDhv/7+D2IK9AVwJ4po5nVbwqrNsTY8wNoCeo02OmzrVx1MEiQECoshv/PLJD7F4sVBzFlwlw6JsgzMn/TmkHIh+zHvASmv12mIPWxA43+iXIRlgp+oUTUdtCzy+LKsU/Bw+ZGduHv5SWp2JuKnQFmYNLksXXWeQ9tS8uZ0aE3UKV9IyBLbNN67V72aaUHcJndAlvDBnwy4ztvQxMfGI+9BkM3/ONjHRm2/CepI6Q1Cpdvz0Ze10RE+e9ZUIFUbxMTzKGF07lL9mZ9XlQ+V8DfO8YejQNj7eBaqC6cN0iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImU5hGWxts4yPuCqDw4e644yljQ254AAK2J5VQx1GX0=;
 b=H7oCv7dDjOKf8XOZkANFRn9t1Y7690OuzgGruY6+lS77U+hSS5s5K+wYpgqgrKjZ2BDrqqR9W7VUMMnVU9CXYmyXE1zTLFSHbjQXgbpV4n6HnCKcEiXFktRK8Cf6Rnn/gQPyRTipSP/FePWO2qqC5wevbMcY05dbuS4QaGOCVNs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5163.namprd12.prod.outlook.com (2603:10b6:408:11c::7)
 by CYYPR12MB8964.namprd12.prod.outlook.com (2603:10b6:930:bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 11:24:27 +0000
Received: from BN9PR12MB5163.namprd12.prod.outlook.com
 ([fe80::61ca:6d43:a98d:3b7f]) by BN9PR12MB5163.namprd12.prod.outlook.com
 ([fe80::61ca:6d43:a98d:3b7f%6]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 11:24:27 +0000
Message-ID: <4ebbf7c1-c3ee-4375-b65a-a242f1c5e75c@amd.com>
Date: Mon, 17 Mar 2025 16:54:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] iommu/amd: Add debugfs support to dump IOMMU
 command buffer
To: Vasant Hegde <vasant.hegde@amd.com>, joro@8bytes.org,
 suravee.suthikulpanit@amd.com, will@kernel.org, robin.murphy@arm.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20250206060003.685-1-dheerajkumar.srivastava@amd.com>
 <20250206060003.685-5-dheerajkumar.srivastava@amd.com>
 <014da701-dc74-4082-98b0-378da8ebbfd0@amd.com>
Content-Language: en-US
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
In-Reply-To: <014da701-dc74-4082-98b0-378da8ebbfd0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0245.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::10) To BN9PR12MB5163.namprd12.prod.outlook.com
 (2603:10b6:408:11c::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5163:EE_|CYYPR12MB8964:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f041b81-beb0-4a82-ffe4-08dd6546472b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFZuTUxqdkhzd0o2WUJFMEMvUTdKcFhtWm9UMnc4TElPQkEzZFRhVFhxSnRV?=
 =?utf-8?B?SzZBa051VVpCWUR6VE9QVEtIVTJjQ0l1c0VSdzN4aTFYRkRzeXdLNHR5Y2lE?=
 =?utf-8?B?UTIrNlIwbjhsSlhmcWdWWXZNbjZHUk9sYWR4OEliVHNBeTJYbUhCWXF1RnBr?=
 =?utf-8?B?R0xwWTZ1dmxkR21VSjA0VisvZEY1eGRJR0dNT3dveWZvZXJiYmVTa3BHQ211?=
 =?utf-8?B?cmo0ZjlFSEFJdU9BamdYWjA1MWdidFgwK3BEcnZMMHFjcm01bVhhREh0WWJR?=
 =?utf-8?B?QTBkT3pHdGE2UHhzbmdKS2hNa29lSlZCTGlodWZuZ1prajY3MGZRWmRIVEtl?=
 =?utf-8?B?Z2I2LytFZU9TbUNWRmk0aFhZanJzODNCVllBTnNpbHE5RFRBMk5NSElSSy8y?=
 =?utf-8?B?UTFzbHpIK1kwaGdyc3ZheFlBMjg5VVdXQ3BJSGt6bVlwME5OUS9kRSt0eXJ4?=
 =?utf-8?B?K2FsTFNPTEtmd3ZwS0RQZmJrWjhNdjgrVlZsRk1DZkh2ZXJUcVFLMXpTYVhs?=
 =?utf-8?B?ZGFCaks2bWNGejNkaHpRK1gwWHJWVXBTNDAvSXdwN0lYL2t0bnIrTzRHWlhZ?=
 =?utf-8?B?ZE9Qb0FHWVJmNmNCazZwdnlKbXE4eEhyNmJ1RVBhUlplQVlNNC9iU0MwOHpL?=
 =?utf-8?B?YWQ3WjEwWVZVK1lFR0FOUzd3VzNZSTB5K3ViUE41dHg1dzJmM1NuM1czQXNh?=
 =?utf-8?B?WkhZVkJEY214S2pha1I2aTFFN29PNEs1clJ1K0tDbWpma2krb3BqRVNaTkVS?=
 =?utf-8?B?MnI0cDhhVG9LaFppWjNpeGdpNkpKd1RrYXllWVZpVVBneEtWSnN5Vm5DWitJ?=
 =?utf-8?B?ekpMZ3NHWHFVT0poMkRsOHg0dFkxTGNsK2lhWlZaZ2VGOVc0dTdNaEZpb2tY?=
 =?utf-8?B?NjF4MVIrS2NPTHNjUkU0VVd1QWZVT25VcUNsTjNXR2g2NmIzSU9xY2NOWmYr?=
 =?utf-8?B?T0lIWTFqQ0Z0YW16YkFGRXlOZDBaME50bXM0LzBTL21ydVZhSlNWa1lJOWJL?=
 =?utf-8?B?QTNqSWg4USswV2hYd2E4NmNhOHhpVkwrdjdwNTcxbFB2K25TVUJnZnJKUCtO?=
 =?utf-8?B?N0dCZUtwNUtKZC9HZGFyWmdlc3Y1bkZNL2JESmxMNTdqQ0RpTVF1UlkxSFpu?=
 =?utf-8?B?cnd2eHhMUitVOWc1ZzdQVUt1UWVBUm5SUHlSaERHZUcrWm1TZnBKQWhLNStD?=
 =?utf-8?B?ekxVYTRwODFBV0I4Qi9XcnJEaFlQVkhvc2VuOFJ2ZDdnT1kyK3Boakp5V2dk?=
 =?utf-8?B?d1RNWmZJMTA4VzYxVEJwVStZRDNVYW9JcTUvMVhGMUorSll3OExEdWQydXZT?=
 =?utf-8?B?aTlBVnBzbEh2NmpLMEJGQm1iUG5rYUtaYzJ2TEZ5aldDMzRvMDhKdm5uRDRi?=
 =?utf-8?B?S3ExZFdEQSt2aUJNRzcrZFZvczZnUlJDVFVOZEN0WmdzVjJLSWdsVEdYN0d4?=
 =?utf-8?B?N1pUam1salJSOWx0eDhlTFpSd0VHdXVmbG9pdDdGOGx0ajE0YmxzRDdDQ0hC?=
 =?utf-8?B?aGJWU1J2QlRja1F1dkp2ZHNBNUgrR2sxYVlZb2ZCVkVTTjRUeG1BQ3QwaVFn?=
 =?utf-8?B?bnArRjV4enk0WUgxNHdIWGk0aUJ1cE1mVUN6MG1zbFFMak1ESFo1cWwrRUoz?=
 =?utf-8?B?WFBlRGZ0MDJNYVZaaEJNeldsWFdCV3d2dm9MaVk3V2Frb04wQWprbkFzMENl?=
 =?utf-8?B?SzRTSVhQcnpmRWRXUGV3ZzN0YlcxT2lxdEc0aU9ray9Eczc2MUx5aDE5aEhW?=
 =?utf-8?B?UHFCYnNtTXg0TUdKNGtKSGdJMjh3SEdpSkgvaHBSc2ptM1M0VVRpWWRrcFRq?=
 =?utf-8?B?b1JlOWh4bEVXcTJYTmRqNU5yNlBvNzdsNUtXVjl2NExOcy9QdlMzYXFldW1h?=
 =?utf-8?Q?IEiBfdG1hlxga?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTY5RDVuR3p0cjJSVWlGTTF2WFVVaVJ0Q0tJbk1ibW9valVCRUc1Mlo0Sm05?=
 =?utf-8?B?QjJOclFzcVcrcVF0dWpiOXFBY2JucmNKOXRERW95WmI0U29HQmgzbE94V0ty?=
 =?utf-8?B?TTFZQmQvWFEvMXNlVDZNT3JzNzBiUzgrbWpibXJFRllBenRoMW1zTUc1NjNs?=
 =?utf-8?B?cGhXVUM2dk9rMEZFL01UdTNLU0g3eTJ3ejhsRHpGNVZQWkJlYXRSZTlWcXNK?=
 =?utf-8?B?VHRJT2FuOURGaTNHTDRJNXFmSHRJTnpVZnhLOUI5YXYrVTZHM3U3TUdkaTlr?=
 =?utf-8?B?aEhLR2FCWGo5dnRaVHFCSjk1WDdKS2RlWVR3bXBkSlprUnZTczFDR0NObFZ2?=
 =?utf-8?B?MUV2SzBOeDNLSEdzcWhvZ3FxaWtxNjQwTTA3blFGRkJQQjNpUkFsNEU3R3BF?=
 =?utf-8?B?UGFZMERYQmMvRGdHdEFuMThvNGtPVWtObGdCQkR0cHE2bU1EUUNZbDNLRWZH?=
 =?utf-8?B?NWRaaEpvVE1JSTdtUDRLMzJtL2w1MmtTQVJCbkNWVllDVkp0c2pZUkdvVFNO?=
 =?utf-8?B?UW9zNFRpazgrZ3IrSTk4ODE1aWpiVEZ1SDFEdldVM1ZveUtVeUVpYm93b3Ux?=
 =?utf-8?B?Y2hhQ29DSGFNMW1YeXpUQjNNa21ZT1ZPS0djTEErS3REbXNyYUlmeDg4alBH?=
 =?utf-8?B?cGhlOG5jRndYdkRhSGFreFc2SXlLUWh1eFk0MHoydklYaHB2cTJQc3llcTVm?=
 =?utf-8?B?KzFFTUhSeVBlNkpsT0dSbWJEZjVVQzVyazc4alZ0WmJ2VTg3V2hVaS9UQzEy?=
 =?utf-8?B?ckwzejdRVXA3UkIyTWhNd0ZJUHRSWDZIYngzQ0Q0Qks2ei9HOStQQlBQQy9y?=
 =?utf-8?B?a2VTL1UyNXlnVGtMMzkyM2FxbEJkTEp5R3p0VjBPU0pqcnlQWWFicXU4OTBQ?=
 =?utf-8?B?cmlSUEpLNk1xRWNmaGpod2VsbUpEQ3IvT1I1N096OWhHVC92Q2ZMUkNMVjRz?=
 =?utf-8?B?eTZpNi8wUU0rR2ZDbnJiVWhnRkQ5OTIyc3dLOGZ5NW1UTG9jWG96YVNlb0h0?=
 =?utf-8?B?Z2dKdXNsRzZBKzdvNVI2YXhsYzl5TGh2Y0JaWmJVN3QyV1Z0aEo4UDlaVE4y?=
 =?utf-8?B?eTd6OWxyazBIZkxEYW9ZUFhsOFhGeDNVcjlBb0gwQ1ZyelE5WFEyT3FtWkxG?=
 =?utf-8?B?dUFnSW1FcGZ2RmJLQmMrM2dVUlRUN2p5RW5LYkIvRWJjTGpPcUhRcW1jVDNT?=
 =?utf-8?B?cGpoaXN4NXBuZ011eEFYWXRqZjkvbEluSEI5aWR5VFB3ZXdHaFdldjN4Tzdz?=
 =?utf-8?B?cU94c0pKcVc2WVZhczdlVDNiMGtTNHBDZlhKdnNPd2tkQnVROWZFSmoxYWNI?=
 =?utf-8?B?LzZjazNITDhVVkE2Y0I2by9GcE9kVlBaUXF5TEE2QjFWSlArZC8yQXRwSVZU?=
 =?utf-8?B?bFBxZFNpOHNZWHRlY0NnMU80bWNhYUFaSEYyTmVydFhCT2VHaVZFMGMyekNJ?=
 =?utf-8?B?QTFubVplYzFHdVlxYVY4MzQ4b0FSMGF4SDYxWEd4K2NoTDl3YjA0WWVoNzZZ?=
 =?utf-8?B?TU52N1BzTmFHU09taEJ1NkRVVUpVWW15WWpDMWFmSWd5cW9qU2hsb1JMVUZI?=
 =?utf-8?B?cHNuVXRDTjdtWThkTTlEZkpiVVRjYlZNV1Rmb1RUWEVjVmlNaytBMjZ6NUM0?=
 =?utf-8?B?cnRIdldiZE1YdWRXQTBhR0k5dE9qZ1ptZ08yUkYwT2lBdHFJOFpFNzVNbzZx?=
 =?utf-8?B?RGtlNkFjaCtyMnZEVTk4a0Z2VEp3cnR1bnVhUUJ6UWxZU2dUZlQxbU9yY016?=
 =?utf-8?B?N3ZUNElza085eEtxUUU2L0xITkZXVXMxREJIMXV2emVyRkc4SFBwL1hJdnMr?=
 =?utf-8?B?L3lmY1JicS93ZkljNHJnQWcxYlFYMkhaVmhuaHJ1MXZMTmxRaS9xRXdIdnhU?=
 =?utf-8?B?UHBkbGNiajVFbDZ0YVNjd2hxbjI3bDQ3TE1wYTRFK2w0OWFmN0tMeTFiWG5u?=
 =?utf-8?B?UElGaHBsTTBxbXJvNHdLdEVnbjd0aXgzVjRVQys4UG9HU2JKSDZVZ1ZlQnNv?=
 =?utf-8?B?bWU3NkxDS1FCWnhGVzBZTkFRbnNFOFozWVNZUU1SZlc5dkg4RTdVQy9Vek5S?=
 =?utf-8?B?ZjRMd2x0V001YWdtNHVEYUpyNnNxb1RJbUdUdE9FUEEyZGZZcWVFNmNKV0RF?=
 =?utf-8?Q?r16oLpxdx7wRxIrDcH5VPg/NX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f041b81-beb0-4a82-ffe4-08dd6546472b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 11:24:27.5728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ZRGrcd8yGmTtyH7cU+Eleftkroz9g2clpmco8OdCI1e+oEhNftc2Dh2DdkLmDzFY9U92In8YqOP1TferLqcuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8964

Hi Vasant,

On 3/13/2025 4:08 PM, Vasant Hegde wrote:
> Dheeraj,
> 
> 
> On 2/6/2025 11:29 AM, Dheeraj Kumar Srivastava wrote:
>> IOMMU driver sends command to IOMMU hardware via command buffer. In cases
>> where IOMMU hardware fails to process commands in command buffer, dumping
>> it is a valuable input to debug the issue.
>>
>> IOMMU hardware processes command buffer entry at offset equals to the head
>> pointer. Dumping just the entry at the head pointer may not always be
>> useful. The current head may not be pointing to the entry of the command
>> buffer which is causing the issue. IOMMU Hardware may have processed the
>> entry and updated the head pointer. So dumping the entire command buffer
>> gives a broad understanding of what hardware was/is doing. The command
>> buffer dump will have all entries from start to end of the command buffer.
>> Along with that, it will have a head and tail command buffer pointer
>> register dump to facilitate where the IOMMU driver and hardware are in
>> the command buffer for injecting and processing the entries respectively.
>>
>> Command buffer is a per IOMMU data structure. So dumping on per IOMMU
>> basis.
>> eg. To get command buffer dump for iommu<x>
>>      #cat /sys/kernel/debug/iommu/amd/iommu<x>/cmdbuf
>>
>> Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
>> ---
>>   drivers/iommu/amd/amd_iommu_types.h |  7 +++++++
>>   drivers/iommu/amd/debugfs.c         | 26 ++++++++++++++++++++++++++
>>   drivers/iommu/amd/iommu.c           |  7 -------
>>   3 files changed, 33 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
>> index 0bbda60d3cdc..c4ca6d9c6b51 100644
>> --- a/drivers/iommu/amd/amd_iommu_types.h
>> +++ b/drivers/iommu/amd/amd_iommu_types.h
>> @@ -892,6 +892,13 @@ struct dev_table_entry {
>>   	};
>>   };
>>   
>> +/*
>> + * Structure defining one entry in the command buffer
>> + */
>> +struct iommu_cmd {
>> +	u32 data[4];
>> +};
>> +
>>   /*
>>    * Structure to sture persistent DTE flags from IVHD
>>    */
>> diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
>> index dc5fdc905754..bf718e7258c5 100644
>> --- a/drivers/iommu/amd/debugfs.c
>> +++ b/drivers/iommu/amd/debugfs.c
>> @@ -103,6 +103,30 @@ static int iommu_capability_show(struct seq_file *m, void *unused)
>>   }
>>   DEFINE_SHOW_STORE_ATTRIBUTE(iommu_capability);
>>   
>> +static int iommu_cmdbuf_show(struct seq_file *m, void *unused)
>> +{
>> +	struct amd_iommu *iommu = m->private;
>> +	struct iommu_cmd *cmd;
>> +	unsigned long flag;
>> +	u32 head, tail;
>> +	int i;
>> +
>> +	raw_spin_lock_irqsave(&iommu->lock, flag);
>> +	head = readl(iommu->mmio_base + MMIO_CMD_HEAD_OFFSET);
>> +	tail = readl(iommu->mmio_base + MMIO_CMD_TAIL_OFFSET);
>> +	seq_printf(m, "CMD Buffer Head Offset:%d Tail Offset:%d\n",
>> +		   (head >> 4) & 0x7fff, (tail >> 4) & 0x7fff);
>> +	for (i = 0; i < CMD_BUFFER_ENTRIES; i++) {
>> +		cmd = (struct iommu_cmd *)(iommu->cmd_buf + i * sizeof(*cmd));
>> +		seq_printf(m, "%3d: %08x%08x%08x%08x\n", i, cmd->data[0],
> 
> Can you give space between words so that its easy to read?
> 

Sure. Will update in v4.

Thanks
Dheeraj

> -Vasant
> 
> 

