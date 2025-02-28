Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2107.outbound.protection.outlook.com [40.107.220.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEBB23F365
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 21:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740777419; cv=fail; b=ORmPpHeZ0fh1VPxVpbImpMKuGUxGDcmKp6JCLHBpJcWBzo0aR5yg7R9Ri0DGj/ewJeFLLLQ0gnhiczSVaFaw4Dsf5B75fR7shU5arq/GH7ya5X0rVGTPj4SCuICK1wzKhb1Jf7Lw83d3J22YKqPtYQNpSkyHaaN7VAibcwuS3To=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740777419; c=relaxed/simple;
	bh=JWRnYY7TQ5x/EfJlv7NX4JdwpXx8Wci8WnAjoLo7oSs=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fhCwVzRZI8EPYDfZ520v1XIlGFMiQuP9ErIO3he7r0Q3spuyhTMINyGWzjnOg76opmUxmHaNZboq/PqOfUKxRg/qMOVwvmOHwFJfv/3MGmHIoKIGCjmnsOoxq6/XmU+HBHybcCJivbMJErax2eEfLWISPaWl0dOUCIN9T3r6MLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=FAy5gMoQ; arc=fail smtp.client-ip=40.107.220.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="FAy5gMoQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=joR+N9xAcaD2IiGWMVLC0uqHxP+Zf/xoNCCdvBKHSOcxxo2Nelw6d3k319ADFeKRtCaT6LCQ8EJsahN9NBfnNC4CaAyaecf54Gc6bTpMn1N/ZYuJRdtP9KNeDqiAYmbfH5QZ/tDTf1IFMGWJ9gNBl+8gH24d5AYCePidACfc/z4T+5bL0VIp783LpUoa6veTFOA6qI00bBYIh8wpCSiK0KVgOyLbtdISMyUbvU22we0I6RgKKQ66UnKalPACzCO5eIXOaLRYvFurSkrh5qt8Ng7Skd0b6JD0yHJWnXeLS6M+oFn5/qniLRwn7+sMaxJek+tcZjT1HqBwiciBcpii4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4CXr19UlZUOTrQDnDK5A0ss8HeTEX1QoFu5sDWTj6M=;
 b=gLfbkdgaE4ZAGCN81sxyStoaXCRfzjhJSmjHZUAlPBHgXERTyHWTdy4Iifl+kNv5UiS1XXNsCytDEADB7uCxXu7RtypOJ5i6nAjcdFQgv0Jwk29sUMs04FgLpA8F7ed0hri6SUVlU8ZViuAPl8Ae6L8WFHmocfe6gSTc47UmRKZQmX19gmYQgoE/0drU8Ga1XoZ41sMQ6bmrYNP1XjYRdHKhhPXx1B0T91EIh1M2cpzYb+t14pl40GnHxWHDJLqcJFIdG1FrRGHQvoQ2IaM9LCh6UoQ3348F707g0dqPImN8bAvLcIRMe/FwiGm0dxhqVPlnm8k/qxV2AnLAN6aOMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4CXr19UlZUOTrQDnDK5A0ss8HeTEX1QoFu5sDWTj6M=;
 b=FAy5gMoQRsOKOZXIxE20F0JgGMiqOzGZUwrTSCkjp2UfBz2EaRqbNgrNA/h+t1KmNKKqeHeV1KiNw04AZNasI6oDnfo3Z48W3BSjbg2J5huiNekCF2P1orTip2HeUbR/vPF9JX0bM3p2pauqG6gAfzm/T0v0b+BS/psD3rYsCLk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 CO1PR01MB8939.prod.exchangelabs.com (2603:10b6:303:275::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.22; Fri, 28 Feb 2025 21:16:54 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%2]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 21:16:53 +0000
Message-ID: <0f77cc7d-9bcb-449e-b34f-ad7a4523552f@os.amperecomputing.com>
Date: Fri, 28 Feb 2025 13:16:48 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] arm64: Add BBM Level 2 cpu feature
To: =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>,
 ryan.roberts@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com,
 will@kernel.org, joro@8bytes.org, jean-philippe@linaro.org,
 mark.rutland@arm.com, joey.gouly@arm.com, oliver.upton@linux.dev,
 james.morse@arm.com, broonie@kernel.org, maz@kernel.org, david@redhat.com,
 akpm@linux-foundation.org, jgg@ziepe.ca, nicolinc@nvidia.com,
 mshavit@google.com, jsnitsel@redhat.com, smostafa@google.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <20250228182403.6269-2-miko.lenczewski@arm.com>
 <20250228182403.6269-3-miko.lenczewski@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20250228182403.6269-3-miko.lenczewski@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::13) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|CO1PR01MB8939:EE_
X-MS-Office365-Filtering-Correlation-Id: c809cc44-0a66-4ab8-e921-08dd583d3947
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1BEZkRZbllUblV4OGMyUDE4M2dJdHdHTkh3cnUwVURzNXdtRUphNVRRbzBi?=
 =?utf-8?B?anR2Nk5UUlN0NUtoOWxjbTJwWG1odXIwaWtUNGVtWFBqTGxHVWkwYzhBWit0?=
 =?utf-8?B?WlNpRTBEdGtnbzBRdWgwZzJGZWlmQkhCYjRvWnArZnY4UTloaXdSQjBuZTNp?=
 =?utf-8?B?SmVZaHVOUzZtQ2VnOFo0RVFEZ1JFRkdGMVdKMUhBTlkvajNBTGxKcldkNUFJ?=
 =?utf-8?B?Wm1aNWhOVjNxU2JtVEZCbDh1dUhxQk1Ha05vNk9ER3o5eU5CUTdBZjBKbTBs?=
 =?utf-8?B?V0lVdlpGakptYkhqZTBTM2JYVGRLYWpuRmpadU95WmVCN1ZzNG1HT2dBYk9i?=
 =?utf-8?B?MU5oMVpmYXlQL3dXeUs2UWZURzRnVUkyMzFYSlA4T2JoRjR0T1NaRWd0dXZT?=
 =?utf-8?B?bEZlMmJCS2FjVmQzaXg4dzFoSCtxNFU3WUphbG1sUVU4Q0xnbGovRlZzZ1pC?=
 =?utf-8?B?THFnTG5qWno1bjBhT1NVNE5xMitNOU5CR2ZrcWVva2hpV1krYmxYRGNPdWYw?=
 =?utf-8?B?cGNWc1dUM3oxdXhMUTErdnBSNmI4MU1GZlJsV0dEdmdYSzJxZ21nNGhBNFMr?=
 =?utf-8?B?T0g3dG9Ob0E1eUt3U2s2T0N2RzA1aWpsZVcxNHF5YW9maUo2Qnh4OFpKSXVk?=
 =?utf-8?B?d3d5RjNkVFBVVzVPWjZYaDNKSjlpUVV3eERqTktVejh1Wjh2QUxFZ1l6NUhZ?=
 =?utf-8?B?REJMNm1iQnh6UGJHUlBPdlA5OExaK2c4L3NJdjJnWXVIUkw0Rkw1MUk3c0NX?=
 =?utf-8?B?dUllYlVubGUvMCtpdmVYTVlOQXdMUUwyZlRFRkxmQmhCQ3F4VjVMdVpxK2dn?=
 =?utf-8?B?a09iS0krYzZtWDkyMXhsQ2xOVTBTbHdVY2Jib21ZbzRnYTNtRkpVNkVhTXJT?=
 =?utf-8?B?bE1reUQrZzFUams3RUxud1RlTHlIOTl4MWFDSVVQeGkyN3VYZi9nUXluWm01?=
 =?utf-8?B?SDNUb21BMWZFWmxjcTQyQXNxYktsR0kyUDhPMS9ycGhZNzVBa1hUMlZzV2s2?=
 =?utf-8?B?MERWb2tNdWdWdHZheGcrS1JiWXR5a1U1ZDZ6and3K3BuWnNsU0JqSUg2VDJZ?=
 =?utf-8?B?dEwwbXhDUVBreENqN1dQK3ZNWGlEVis2NWNTV2p0Nmp3Y01XSVg1L3VCZmpx?=
 =?utf-8?B?ZGc5QmVwM0xtRmxoSldHSE03VUE2TGZ2c1R5TzRqd2duWkRNR3Vaczl3eWNS?=
 =?utf-8?B?UmVrTGtlSEgrejdTUW1jcDdEcFBMUXJMK2JOYS9iK1haUFgzZ1JZblNDTGVm?=
 =?utf-8?B?Z296ZHo3YllHZmJVS0FIM1pCT1F2VjIzZndGUTdhdW5XOVA3aGY1V05zUGtK?=
 =?utf-8?B?Y2doN2NGVlNZa3dmMHlJbmticjNMK0FWMnZjRkc4VHFacFMxY2s3SEFwdUxh?=
 =?utf-8?B?TUlOQzhOeU1Gd1dlR0Y4SGhFNlFMNlNVejBXaE90SzcxamxkVXlrUGxtWWdr?=
 =?utf-8?B?NVRBT1RWSDArT0R6bWphZ0d3TGtiRmlqNTdDK0taSXhiSjczajZYdG1mczJD?=
 =?utf-8?B?KzZqck1mMzJWZGJjbXNZVHRacHRTUkFSenpYT3RLR1d2UDVGZGU1MmxDbisw?=
 =?utf-8?B?ZGRqd3VjQ20vNWZlckNVWS9NaEZqUTdDZ0tXQ3JCVmw2cFJNQ1NsUTlhcnli?=
 =?utf-8?B?YlRkZ2ZScUk1Q2xFZ2RLK1VreEFHNWlzdWdTQUY2L2p4SDhPL0UramFhTEpw?=
 =?utf-8?B?MTdJZnhGMjlOdFcxQThvYTlFcWFPSERPa2p4Q0tiZmx5WDQxeXdBdzFRUVFy?=
 =?utf-8?B?aUhGenRxblVoWHd6YkVaY1VYaGZta1E1Z3RKRE92UGpVa0JhSXhySGRwbith?=
 =?utf-8?B?RGxuTVNqZzBvUVBzQ1l4OE5Xb3hHb2hJUnFqMzZLanB6UHV4U2NldFRHS1ZZ?=
 =?utf-8?B?eG4vS3ZyODk1NVkvK28zRC9odWZacHU1dHJnUGgvaXdCUGVNeC9pMjJjZm1U?=
 =?utf-8?Q?u0vFsOa5Wmk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDBCWmljcXpIMXVTK2Q0M0Y2VSt4aEpEYis1M3pXZ0NiaFRYNWp4YTJMTzAw?=
 =?utf-8?B?M1FqeVB2REY2NElDM2xUeVloc01Jb1REUUc3LzB2TzRkd0xVaHRVWm9lbloy?=
 =?utf-8?B?eUFTVWluWG9iamNGR2NxdnkrWmw5eHJ4eDNxTjVWdHcxd1VDZXJiSWRQazF1?=
 =?utf-8?B?UzAvak9mYnd3QVBjZWpLU1FWc0FEMCt2bXA3LzlDQk53bDdEbDd3dXFyY1ZJ?=
 =?utf-8?B?cUlwTW42Nzk3V081bHQ5cTdwU2pBWFJESCt0KzJzTjRZUlMwbWhMOHZGWGxQ?=
 =?utf-8?B?YnBEeUlHdFNqMXBjanNGYUFYSGNaUUxpUlR6cSs3b0ZmNDFYdTI1clhTZVJQ?=
 =?utf-8?B?Zlo1c2pUNTB1ZmNqVDBZQjNROExaTFhXcTJMR2lJTExpQXBPaVRmVTdpcktH?=
 =?utf-8?B?dXZXNWNqa2Y1U2ZJUHFUM3hyZnBDdFVYZUFLek1FUUhKNklRODk1TmloeGdM?=
 =?utf-8?B?dGxGMDRuR1N2UzdPcW9qQU92Z05pbVVsMk5OYTBlSmY0Z1phRU96SVoxcExZ?=
 =?utf-8?B?cDZSdkFKM0FWeVlURTVYNU5WZ0RhRnh5dHNBcVdMNkw4Rlo5aGhLSGNPQTIx?=
 =?utf-8?B?VUNmQWZtWHE2SHFjK05vcElqV2cvT1FsQU9kaEdJeXQyaGdOdGNrTmJxbHFo?=
 =?utf-8?B?elBHK3o3RHNRTDROci9iQ0tMS0Q2OEZKSmh6M1NwTlZ5cjUrVnh2VllhUmJy?=
 =?utf-8?B?WCtJTElaK2p6Z3hxcTRwdUFERW5UNjlpRjFxOHkwWGEzZVA1ZE9oSUtHd1hL?=
 =?utf-8?B?bEZBMVpSa0ZOOWxjb3JDY2ZrNXNydUlOWFIzSnZqTldHbW1qZG5Fc0VKbjFT?=
 =?utf-8?B?Y1lCeWVBckpKYTBablIzbDlpWmFrakxyRm1CdmFpK1M1dVRvNmd5QmdHNU91?=
 =?utf-8?B?SW1QZnp0YllPR0JmUExRNnA4NVBjQUZSNFBKcHkyNC9ZdE96aHZRY0ZzU3JV?=
 =?utf-8?B?NEZlNDNlRk9hWW14NGYwZHBDMGU5a3ZXbU5STHNmUnRnK1V5ZXNnb0xNRWxJ?=
 =?utf-8?B?ekI1NlVuVUQrUVJBME11Mmo1WDZOd0FkRXB3T0VHa1ZUM0JnY1hRTy8vM2k4?=
 =?utf-8?B?LzhXckxzQWZ5VU5tL29zK1I5dXZrM1BBdTBGamUxOFdBY1BUQTlaNW5uYmhZ?=
 =?utf-8?B?YVpONmJHRG1NZXg0WHJXbmI2Z3gvZEs3MVd5MEpZRHNWRTZuazJpOFg3OVFy?=
 =?utf-8?B?TmlXRkY5anFTL3VQQ2Z6UEJKakRNTWxxN0J3cHZlS2h6OTR4TlkvY1ptU0JM?=
 =?utf-8?B?NWJoeUcvR0JmYXpwbzY5MTNLZjZlOTZYUFkrekx4OFJYdWRHVVFDWkhZTGVl?=
 =?utf-8?B?N2Y2ejd2UjAvZ3hiZldFNjJqQ2I4MEtqUUNvdXdOUVo1aEFhZWppZmhwYXFQ?=
 =?utf-8?B?RzJrZHRiMmk5VWJ6dnBXcGpSK0dvRXBkdXNVdHAzWWFTZi9vTTJmUzlJY0lz?=
 =?utf-8?B?NXlIN3M1aVprQWFrRTdJU2FUMld3d05RSllSaTlYT2d3K0g3OVlhajJvdm9n?=
 =?utf-8?B?VlNYSTV2a2ZBUnhzVkplOTlKMDFTZkpzVXRteWhXc1BYb0tQWjZIM3h2dXR2?=
 =?utf-8?B?U2FiUDNmaERUbVlmOGwzU1N2eSthempoeEJ4WFRtUW05TjBMVkZ3d3pFSy9Y?=
 =?utf-8?B?MXEvMUdTRGZqQXlCeEYwdmliNkU4RVF2dlRQMlZhZG5kUEUwTjJuMUpRSDVZ?=
 =?utf-8?B?Mnc1VHJOeEVIYkowbGRaenBlaWtkRzN2dGUxOGxMcjdYQllBVE10Q2VPS1Ra?=
 =?utf-8?B?RTVaU1pyencyYkR1a2tCbGVGaENvNHFPeFRxbzVyTWJPZE5YZnNNRkVMNG41?=
 =?utf-8?B?RmQzbEhndjlxK2liYUNUMWVxUmZvRys4eDJzL2NwQjF6eVhZKzR0S1IyZERs?=
 =?utf-8?B?eGFaK090Rk9tZDBYNUJpYUhxbDgwNEN1TnJ5S01LUklVRndXYllreUdkdXlX?=
 =?utf-8?B?bVM1QVROVDJ2QnhCMHNobEQ2OHNIVkYzYndPSnpCMUczbk1TNUhsVTMwakZS?=
 =?utf-8?B?Y1hSR0UxY1ZLenppKzlxSjAzSnNvSFdFSWF1bjh0ZFJTdXNMNDhHNnprc2NM?=
 =?utf-8?B?T3doajJpTzZGRDVZV1Q4NjFPNTRmSHE4K2dpUGpRbTI3NnVpTFd3U1RJdjZ2?=
 =?utf-8?B?dHNYazFYdXBaRW8xQ0ZNMndja2Q2QzR6UXc4WjU1VU15MnV1TlBVRDg5d3N2?=
 =?utf-8?Q?VBOLpJjWd0a6lFKuB1K31EA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c809cc44-0a66-4ab8-e921-08dd583d3947
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 21:16:53.5309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i02ierIlsL7LtIDfs9WMtT9VbUXlA0vRo5zkXHN+KMamxsmf8t/iB06IboeuKzkDyMmRxFbxyNy2bSrDRLiqM5XUnht3Jw7vQx+UXsVjLJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB8939

Hi Miko,

Thanks for getting this work. It is perfect timing. I'm going to have my 
series build on top of this patch.

Yang



On 2/28/25 10:24 AM, Mikołaj Lenczewski wrote:
> The Break-Before-Make cpu feature supports multiple levels (levels 0-2),
> and this commit adds a dedicated BBML2 cpufeature to test against
> support for.
>
> This is a system feature as we might have a big.LITTLE architecture
> where some cores support BBML2 and some don't, but we want all cores to
> be available and BBM to default to level 0 (as opposed to having cores
> without BBML2 not coming online).
>
> To support BBML2 in as wide a range of contexts as we can, we want not
> only the architectural guarantees that BBML2 makes, but additionally
> want BBML2 to not create TLB conflict aborts. Not causing aborts avoids
> us having to prove that no recursive faults can be induced in any path
> that uses BBML2, allowing its use for arbitrary kernel mappings.
> Support detection of such CPUs.
>
> Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
> ---
>   arch/arm64/Kconfig                  | 11 +++++
>   arch/arm64/include/asm/cpucaps.h    |  2 +
>   arch/arm64/include/asm/cpufeature.h |  5 +++
>   arch/arm64/kernel/cpufeature.c      | 69 +++++++++++++++++++++++++++++
>   arch/arm64/tools/cpucaps            |  1 +
>   5 files changed, 88 insertions(+)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 940343beb3d4..baae6d458996 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2057,6 +2057,17 @@ config ARM64_TLB_RANGE
>   	  The feature introduces new assembly instructions, and they were
>   	  support when binutils >= 2.30.
>   
> +config ARM64_ENABLE_BBML2_NOABORT
> +	bool "Enable support for Break-Before-Make Level 2 detection and usage"
> +	default y
> +	help
> +	  FEAT_BBM provides detection of support levels for break-before-make
> +	  sequences. If BBM level 2 is supported, some TLB maintenance requirements
> +	  can be relaxed to improve performance. We additonally require the
> +	  property that the implementation cannot ever raise TLB Conflict Aborts.
> +	  Selecting N causes the kernel to fallback to BBM level 0 behaviour
> +	  even if the system supports BBM level 2.
> +
>   endmenu # "ARMv8.4 architectural features"
>   
>   menu "ARMv8.5 architectural features"
> diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
> index 0b5ca6e0eb09..2d6db33d4e45 100644
> --- a/arch/arm64/include/asm/cpucaps.h
> +++ b/arch/arm64/include/asm/cpucaps.h
> @@ -23,6 +23,8 @@ cpucap_is_possible(const unsigned int cap)
>   		return IS_ENABLED(CONFIG_ARM64_PAN);
>   	case ARM64_HAS_EPAN:
>   		return IS_ENABLED(CONFIG_ARM64_EPAN);
> +	case ARM64_HAS_BBML2_NOABORT:
> +		return IS_ENABLED(CONFIG_ARM64_BBML2_NOABORT);
>   	case ARM64_SVE:
>   		return IS_ENABLED(CONFIG_ARM64_SVE);
>   	case ARM64_SME:
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index e0e4478f5fb5..108ef3fbbc00 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -866,6 +866,11 @@ static __always_inline bool system_supports_mpam_hcr(void)
>   	return alternative_has_cap_unlikely(ARM64_MPAM_HCR);
>   }
>   
> +static inline bool system_supports_bbml2_noabort(void)
> +{
> +	return alternative_has_cap_unlikely(ARM64_HAS_BBML2_NOABORT);
> +}
> +
>   int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
>   bool try_emulate_mrs(struct pt_regs *regs, u32 isn);
>   
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index d561cf3b8ac7..63f6d356dc77 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2176,6 +2176,68 @@ static bool hvhe_possible(const struct arm64_cpu_capabilities *entry,
>   	return arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_HVHE);
>   }
>   
> +static bool cpu_has_bbml2_noabort(unsigned int cpu_midr)
> +{
> +	/* We want to allow usage of bbml2 in as wide a range of kernel contexts
> +	 * as possible. This list is therefore an allow-list of known-good
> +	 * implementations that both support bbml2 and additionally, fulfill the
> +	 * extra constraint of never generating TLB conflict aborts when using
> +	 * the relaxed bbml2 semantics (such aborts make use of bbml2 in certain
> +	 * kernel contexts difficult to prove safe against recursive aborts).
> +	 *
> +	 * Note that implementations can only be considered "known-good" if their
> +	 * implementors attest to the fact that the implementation never raises
> +	 * TLBI conflict aborts for bbml2 mapping granularity changes.
> +	 */
> +	static const struct midr_range supports_bbml2_noabort_list[] = {
> +		MIDR_REV_RANGE(MIDR_CORTEX_X4, 0, 3, 0xf),
> +		MIDR_REV_RANGE(MIDR_NEOVERSE_V3, 0, 2, 0xf),
> +		{}
> +	};
> +
> +	return is_midr_in_range_list(cpu_midr, supports_bbml2_noabort_list);
> +}
> +
> +static inline unsigned int __cpu_read_midr(int cpu)
> +{
> +	WARN_ON_ONCE(!cpu_online(cpu));
> +
> +	return per_cpu(cpu_data, cpu).reg_midr;
> +}
> +
> +static bool has_bbml2_noabort(const struct arm64_cpu_capabilities *caps, int scope)
> +{
> +	if (!IS_ENABLED(CONFIG_ARM64_ENABLE_BBML2_NOABORT))
> +		return false;
> +
> +	if (scope & SCOPE_SYSTEM) {
> +		int cpu;
> +
> +		/* We are a boot CPU, and must verify that all enumerated boot
> +		 * CPUs have MIDR values within our allowlist. Otherwise, we do
> +		 * not allow the BBML2 feature to avoid potential faults when
> +		 * the insufficient CPUs access memory regions using BBML2
> +		 * semantics.
> +		 */
> +		for_each_online_cpu(cpu) {
> +			if (!cpu_has_bbml2_noabort(__cpu_read_midr(cpu)))
> +				return false;
> +		}
> +
> +		return true;
> +	} else if (scope & SCOPE_LOCAL_CPU) {
> +		/* We are a hot-plugged CPU, so only need to check our MIDR.
> +		 * If we have the correct MIDR, but the kernel booted on an
> +		 * insufficient CPU, we will not use BBML2 (this is safe). If
> +		 * we have an incorrect MIDR, but the kernel booted on a
> +		 * sufficient CPU, we will not bring up this CPU.
> +		 */
> +		return cpu_has_bbml2_noabort(read_cpuid_id());
> +	}
> +
> +	return false;
> +}
> +
>   #ifdef CONFIG_ARM64_PAN
>   static void cpu_enable_pan(const struct arm64_cpu_capabilities *__unused)
>   {
> @@ -2926,6 +2988,13 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>   		.matches = has_cpuid_feature,
>   		ARM64_CPUID_FIELDS(ID_AA64MMFR2_EL1, EVT, IMP)
>   	},
> +	{
> +		.desc = "BBM Level 2 without conflict abort",
> +		.capability = ARM64_HAS_BBML2_NOABORT,
> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> +		.matches = has_bbml2_noabort,
> +		ARM64_CPUID_FIELDS(ID_AA64MMFR2_EL1, BBM, 2)
> +	},
>   	{
>   		.desc = "52-bit Virtual Addressing for KVM (LPA2)",
>   		.capability = ARM64_HAS_LPA2,
> diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
> index 1e65f2fb45bd..b03a375e5507 100644
> --- a/arch/arm64/tools/cpucaps
> +++ b/arch/arm64/tools/cpucaps
> @@ -14,6 +14,7 @@ HAS_ADDRESS_AUTH_ARCH_QARMA5
>   HAS_ADDRESS_AUTH_IMP_DEF
>   HAS_AMU_EXTN
>   HAS_ARMv8_4_TTL
> +HAS_BBML2_NOABORT
>   HAS_CACHE_DIC
>   HAS_CACHE_IDC
>   HAS_CNP

