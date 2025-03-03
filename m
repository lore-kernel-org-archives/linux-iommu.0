Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022128.outbound.protection.outlook.com [52.101.43.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666D1233128
	for <iommu@lists.linux.dev>; Mon,  3 Mar 2025 19:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741031738; cv=fail; b=OAZ5P44GGNpS5/OLjlWfoi57ofucxWhCSxVsLKC3xMfm/odiYpjGpXLkh5+wLu3qjhv9jvbnLmStp5VbIe8TeayxjThgHd1bDGqX1FipLzHXQWli2hPOMEBpovgcNgRv+kOMPhZ8KiZ3mJbe/EKKb6pxFq/DECceSXQiSCkZ+5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741031738; c=relaxed/simple;
	bh=lN0czpr78JyhDvpdtP3RfhrvmZU2LYC7wTh8q0uF+R4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WLCFLbSoDge4k//GGqVBuPS4dwWf9HWkbAeUjfNWB0RPKmGU2QVFIWbaUtBzduihiDHUs3tmXH9mF3hoZVy2dci7+74czP3mzGS1eXP0ErjurIstiJgmdzR9uQ69j8MtyolSlejcK3mDLHGFq4p2o4xzw1fObyHKqpWxyEH0PtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=JcMicN69; arc=fail smtp.client-ip=52.101.43.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="JcMicN69"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RFpADrNac2oFyN4Zkwa0omuYxU2xr/V2SnqmOpszF6jKTW0QTUoCiy2e1A7+wBgRYH24NX0reV7fGtU9dbEe3bPmkASSY6BtWbmR23ulaLZVWY1VGQIxJtZXdcGmDtPXUuQLu/ksGG1/gOiFC6rheSCn/n1AYe/wIlU4a2MyUeu487NyaSWeoeI2CGyV86jum756Arq2XmJKnAkS03iFGOZWbOfmpQc8XWPhfxo+11UCDZuw5WpKCt83fageblJNEqza1NEMroTnuGaNLNUNESfWC8XH5zNm8fSFB4/Zapr9Q987Kn1/ur/j6SIK54OSC1Mq+baAu9yT1t+egxMNIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHDom3rnMk0bhln+zgGx1XLmYDC3POyZRXoDcUpbYP0=;
 b=CaF8r6ZC9YYReYWq7nb1xs7JTxDyIqt+E6N7iGArYnkwB8YovS2R6j17i5BaF7/Xhceq7VGJ6vFDd15EVcaEZikR2nzicauWdhgCKap/15+nJM+KTb7NhHi8Xb6AoAky1NIb8RjVTyIODUTP/xjQfT9GzSaSbw53NEJ6ZBXblcgP+jrMc0uiRXyt0md9qpgrAvNRIjV5Fw/gH4pViZsvoC3wxSsOwHjxvHbpfDvQCtXp9mNewf3gW8NgyJMszuiFUsmOdHmWGNzGoPjim7bOnjHkHHtw5whP2N3HYBoFdkSpQnxVMHtVfrHUCVdwzz1NLEc3rDl0dlqhoez5hakrcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHDom3rnMk0bhln+zgGx1XLmYDC3POyZRXoDcUpbYP0=;
 b=JcMicN69HPtV4LUAU6QiY8kJizbtYFWGiwrbotG09rxzZLvC6LzAMq9t6SG2nyBmwmGcOZBV3yeAVwlwlEgXTFcDsiZpmRvQ2f0HWL0XZLAvtOSw0FNYWBn38mJtbZEZ7bd/jsYd+CZOJcEXoybc/m2Tcq6s+dP9fqVUeYz7plA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN0PR01MB6877.prod.exchangelabs.com (2603:10b6:408:161::22) by
 CO1PR01MB7387.prod.exchangelabs.com (2603:10b6:303:15a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.28; Mon, 3 Mar 2025 19:55:33 +0000
Received: from BN0PR01MB6877.prod.exchangelabs.com
 ([fe80::91fc:9877:8a2a:d4e0]) by BN0PR01MB6877.prod.exchangelabs.com
 ([fe80::91fc:9877:8a2a:d4e0%4]) with mapi id 15.20.8489.023; Mon, 3 Mar 2025
 19:55:32 +0000
Message-ID: <a382e902-6887-4880-a312-cf52defccaf5@os.amperecomputing.com>
Date: Mon, 3 Mar 2025 11:55:28 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] arm64: Add BBM Level 2 cpu feature
To: =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>
Cc: ryan.roberts@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com,
 will@kernel.org, joro@8bytes.org, jean-philippe@linaro.org,
 mark.rutland@arm.com, joey.gouly@arm.com, oliver.upton@linux.dev,
 james.morse@arm.com, broonie@kernel.org, maz@kernel.org, david@redhat.com,
 akpm@linux-foundation.org, jgg@ziepe.ca, nicolinc@nvidia.com,
 mshavit@google.com, jsnitsel@redhat.com, smostafa@google.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <20250228182403.6269-2-miko.lenczewski@arm.com>
 <20250228182403.6269-3-miko.lenczewski@arm.com>
 <c572a93f-0899-4fc7-9764-d3e76e9fe6d1@os.amperecomputing.com>
 <223a817b-66dd-4182-838f-a186b059fe41@os.amperecomputing.com>
 <20250303094022.GA13345@e133081.arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20250303094022.GA13345@e133081.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:610:4c::19) To BN0PR01MB6877.prod.exchangelabs.com
 (2603:10b6:408:161::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR01MB6877:EE_|CO1PR01MB7387:EE_
X-MS-Office365-Filtering-Correlation-Id: 121df901-ee72-4f5b-bd42-08dd5a8d5b58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aTl0TDY1eGtCV3JYM0N4NGs3dEx5dzcxcDZ1OWwyd1cwUTdld05EeklIcVJH?=
 =?utf-8?B?dVF0ZnZjR3JWUDlZQ2cwaHRwcHVXakxUZzgxMUpnYXJ3aFRqeUtaTzY5Rlc4?=
 =?utf-8?B?NSthMkhWMkQvdkJ1Z29uNWhDa3NiY2JaSTJqSzhRbHg3bmJ0c214bXhyQ2Qx?=
 =?utf-8?B?ZGVPR0tnSDhWWTB6UTBzSGF1U3E5SWpMcHcxdXdCdDROcXRWZjUwY0UrTVlM?=
 =?utf-8?B?TWFzMUwvLzJ2RmhUTGRFdVU5T1dxTno5TExIT0lPRy8wdFcrRG0vekRJNFg1?=
 =?utf-8?B?R20yOENBTFlBSGZDSTYvcDc5ZjJJakJRZmxWU0ZnTUgyVXZKY2xFd2tpZVlt?=
 =?utf-8?B?N2RFa1hlaHRRQlYrYWxuRnhBcnkxd2hNdWZiSzBJb05Cak5sQzV1QzZRclRD?=
 =?utf-8?B?eXVDYnBwUDdzMjVLeVUraHE5M3EwM3hBTm5jcm92bEJjdGxzcjZkdlprc0dW?=
 =?utf-8?B?Qmh5NEYxRWN0YlNFRmhHZkNGOGdDTUpkL25ZenlMWE5JVzV0bnViV2dKRDg0?=
 =?utf-8?B?SUhFTGZTRXd6ZDZ1dVViRnNDMXlKNkJ4UThwamVKUXV5ckVwK3JvQ3BEdEp5?=
 =?utf-8?B?WFREN2xxWmppeVFpMHlWMzZQa2lIWk0yWWg4dVM5NUQ2TjVLNUFnYlU0ZmEv?=
 =?utf-8?B?NWRPWFBZQXZoL0ZjQitnczBIdDZIQU56RlFHdHJSaHNIenJkN1RhREJhV2hQ?=
 =?utf-8?B?a2U2Z3pDWDNqcGdCWGtUWXAxbGo3TmFpYVd1RFNDMy95bCtMTGNScWtxOE41?=
 =?utf-8?B?RlB4OE02allUaloySmFuNUgzelB5aThHTWRXc0dvVndhSGh6N2kweGJpSHFu?=
 =?utf-8?B?bUptNHBBdGQwM2IvVlFtS3VCQ044cXZYbCtwaHQ3MHo2R1hqTjV5UXluaGw1?=
 =?utf-8?B?SmJKZU9nYW8vdmIyVFd4V25mblduYVJjeGl3ckFPR29GL0dzV1dXa05PY2Jh?=
 =?utf-8?B?QlFZYTgrQ1hSaHdjcTdpK1I2cG1rMGJJWDJFY29NOTc1TzVUck5ySnUyNVdm?=
 =?utf-8?B?SVJyR1VHRS9FY1grM1BwUWpMR0YrMXpDOTFDYklzcmg4c1lKc2d1RDVBTFIx?=
 =?utf-8?B?Rll3WUplNWc1UVkwZFRaWS9VVy9zYlNGUzVtRFNobnJ4aUJaQlF5RmM1bktM?=
 =?utf-8?B?ZTBHa1h2ZkJ5OFVEeDlvZUU1NE9zcWZHczFQOXFlcy9IUE9Lck5iQ2RuOTBO?=
 =?utf-8?B?cVlyUUtPRmEwUEZGUmhlL0dzU0JoK085VG0vemVNbDVNM3ZmQUhYeEN0MnR4?=
 =?utf-8?B?aVkyZzZyT1lqeU00T3NwcDZkNjErVEN4N2x0Qm5oM1VkSVQyai9BVUIvK3U5?=
 =?utf-8?B?M28ranBIcGNqRWE1cE1CZGRCakdKcTl2Lys3UlNUbWdDa0VlQU4rR3pxZ2RH?=
 =?utf-8?B?eW52SExBOUM2NDFCT3VSUGJ5WFR2bElTWkc1dmg2TVd4SldWR082cFNSNi96?=
 =?utf-8?B?SFp0MmlnUzdmSkJLeGliVkNpcTZkaE1neGpiRjY3TDBaQWlyQjluZjN0UTFw?=
 =?utf-8?B?NmtFZ2VYRVpJMEpyNTIxbElHOUpLdUN3SWV1RElNUVh6dXdNNG9VS09tMXdi?=
 =?utf-8?B?RUN6S2hzeUpZSFhZZ0toSSs3N212Uk1sd2UxR3VwOTNkcVYwWHVMamFXWEpw?=
 =?utf-8?B?Z0p0cHgvdkhuSS9Xa1hhR0M3bmNYQWJ3Y25YSUpOa203USszWVdCa2xwSGpr?=
 =?utf-8?B?VHdSQ01Da0l5OWhHVjZpTnlDcHk4WjlxY1lBOUtnZEtnU2dlYThWMHR2VVNt?=
 =?utf-8?B?bTFOUGJ2UjA3YnhuYUlDSUtlZUFVNHlZakZpZDZBbGg4YktTTHhlRlVmZE9V?=
 =?utf-8?B?clVadEtzWE9RQy92M20yWENsS2ZyM1JxODF5WXJyUWxUU1RhRkRRK1k4emhp?=
 =?utf-8?Q?/sz2+qGIvphbU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR01MB6877.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDZRaGpZaHF2UXdBR3JnajkyQjVDQjdzbzZFM04yU09LOXNNUHlEY1pHd2Ji?=
 =?utf-8?B?N1c0Qy9rVkFxbjMyanZuMWRVNkVsY3VGTXlibHdaVWlpd2Q1R1k2d3hHdXhC?=
 =?utf-8?B?WU5LQ09CamZ4RHd6Y3RpeWZodExPaE1mM0JjaXhsRkRRZmlDNk9rblY3V3VD?=
 =?utf-8?B?RFVMZlp3eHNoajRJeTlZYm1LVGZ3bkM0bGtFZi9TVEc3anJTWTUwenBzK2Z4?=
 =?utf-8?B?enhjZlVKd3NsOXVZQkdOdU9iRENiZmRZYm8weWV0VzUxblRvTHZIM2JDSHlT?=
 =?utf-8?B?UEpwZEl2MkpSRmVUc2JQaXhZakh2MEppMlZRVzRMb01sTEZLeTVYYVczRzVX?=
 =?utf-8?B?UmkyalMzRlRUZ1FNRjhRb1FKUCtFMndKL1RyVWEvM250eHlxcXp0MVNYV0g4?=
 =?utf-8?B?bkhxUFZQSlJ6UjhBdy9HYlptUDYyU2RxQlQ2MGJnVHVlc0x2bTFJMWFBVC9q?=
 =?utf-8?B?SFlaSGpQWmxFb2xNZWY2SXg1SkhsVlNBdlpNUGQxNlZTVXptZ1lMWndsVE1l?=
 =?utf-8?B?eWk3WUV3elB2SE95alNHTUZJeXJoS0dOYlZpeUQ0QmgzcDRlWDZkUlpNcVU3?=
 =?utf-8?B?Q3pMcUQzMjRGcmE0VkhubStOb0haZ1QyR2VSU3BBYzIybFhNYlFMcjU0QXJz?=
 =?utf-8?B?R3ZPQUhSZGlvSlFTRzRUOXdRNWlJdWdDK2pjeGdOMGRzUkZHZUxZOUhuSkN6?=
 =?utf-8?B?SlVaN3BDOUU5RXFhaFVQcTZwTVVmTjE0eUJUV3ZXSlo3TmpaOFd4OCtlZzl1?=
 =?utf-8?B?cFBlR3RSeUtOVWFsY09CUlRWb1BlR2pEYnkwRCtweFNBeHdZSjN1Z05HSXRt?=
 =?utf-8?B?L0NtQkc3STVjaXdNbHg2dkZFS0xaaTFjWTlPSnVhbVpidy9BTzB5QkVDQngw?=
 =?utf-8?B?ZDRhbmNPMkJ4eVdzYStqRmZpVmtDeEJ2bU5Lb3pqdXI2ejMvUXNVTGpRT2tz?=
 =?utf-8?B?am03dXRVbjkrTDhCY1hoMFRtUGtzRTI4RXI4WmVFakRMNUhvZVJ3bnlxWnMv?=
 =?utf-8?B?ZXFGc2tGcGxNNFRBeGw2ZGlFTGpYcHloNWJadFBQS2N6S0c4dkNPZWtUa3VN?=
 =?utf-8?B?Rm9hZnVNbGZwejg2Q2ZIYXNBMzRhQUNxRE1nVWdzRjdrVy9hTnVTdVFuU2Fy?=
 =?utf-8?B?YW0rYjdId1VrZFNoTlNxTUlnZktMSTJHNjJkRDRUMHAvSUFZbFBYRzN0WVdw?=
 =?utf-8?B?UHNTbm0rdmZqWDk2ZDhheWFEUGFoZXRieVFXbkw2R2JmeGV3cWVqQlNRSVd6?=
 =?utf-8?B?YjUvSDdSNXZUU0s0RmRva3gvNjFDNUsxOWJkU2pYYVZJeDlzTEl6WGJCLzhW?=
 =?utf-8?B?R1hWUjMyVUpPTlFqR2RmeHJwelZLREJGSFROR0I3LzVESlFsRkJFdkczd24z?=
 =?utf-8?B?anBJVGdpTnc1TjkwbTRtTVUwK3ZaS0VDVmQra3kxMFc5dzVYMVJWTmo1ZHBD?=
 =?utf-8?B?eXNJV3ZlS1pJd0NwaE9YazlSZVNHbkV6SGc4dGFUS0pJaUc3bldZQWM2NjU2?=
 =?utf-8?B?YXU5cnRTbzZOQU8zdE14L0NGWjgrbjYyWHYrRFNrd2xzMVBBN3k5dGd0MWRm?=
 =?utf-8?B?SU5aTWx3a3k0QXRHOVlEdkRtZzlkZ3pJZkxzcWxpalpreG9INnoxcXYrcE9G?=
 =?utf-8?B?amtPRVJ5d1lseHZReENmSktYVk5RMXNsdzdWWVRLMFYrYnRyTHhyT0N2bHBv?=
 =?utf-8?B?cU5XdEN1Z2JtSk4zSzRVbS9iTHZQMk16b2wzUmJnWFE1V0pKa1RQaGEwejhk?=
 =?utf-8?B?V3dhQU92OEhrOUNYdW9TWVppa1krRUQ0V2E4bHNaQ2hiKy92aVdpVFZyYU9r?=
 =?utf-8?B?YVFrbW9TVmxpT0cvWkVGcHZpUXgrUEI1OGFxMFhmUFU4R0hGWXlVb2tRVzFF?=
 =?utf-8?B?UTRLSzhPUGNCL0FsTXp1TUhHMGpEZWxPb0FEcE85UW53WlVVMlhISmhMakZy?=
 =?utf-8?B?dCsyczNkTUpuK3JyYWxLcUF5cUZUVi81aSt2MG5LUmZoWmV4N2RCQnRIelpF?=
 =?utf-8?B?UXVlNjRQdXJ4bjBzSmx2RFhSL1dNU1J6Z0RLbGt2QkROQVoxZmMvMzJFWitD?=
 =?utf-8?B?dVN6dndoQU55NkpFWkYrZ3E5RFFIOFUvbUd6TTlUNk55WGJzcGl2UUNDQlUy?=
 =?utf-8?B?UFFIUHNpc2JhUmQ2WHNrWklrZGRIcGQrU3RVS1pDb2NsbHExbnc3QlVwVWRG?=
 =?utf-8?Q?qgoQOHrsLTzw9L8wnTs9RUQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 121df901-ee72-4f5b-bd42-08dd5a8d5b58
X-MS-Exchange-CrossTenant-AuthSource: BN0PR01MB6877.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 19:55:32.7290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eyjEtxu90FQIvbM3Pf7rx0Xi11SX7fx+rDum/SBeMIexWRx0Q8CtTsMQMBPpMR4Gh75AAXnFVtnnu12cGCm2XdivRF9EiaOcVIwV0Xywiyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB7387



On 3/3/25 1:40 AM, Mikołaj Lenczewski wrote:
> On Fri, Feb 28, 2025 at 06:45:38PM -0800, Yang Shi wrote:
>>
>>
>> On 2/28/25 5:29 PM, Yang Shi wrote:
>>>
>>>
>>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>>> index 940343beb3d4..baae6d458996 100644
>>>> --- a/arch/arm64/Kconfig
>>>> +++ b/arch/arm64/Kconfig
>>>> @@ -2057,6 +2057,17 @@ config ARM64_TLB_RANGE
>>>>          The feature introduces new assembly instructions, and they were
>>>>          support when binutils >= 2.30.
>>>>    +config ARM64_ENABLE_BBML2_NOABORT
>>>> +    bool "Enable support for Break-Before-Make Level 2 detection
>>>> and usage"
>>>> +    default y
>>>> +    help
>>>> +      FEAT_BBM provides detection of support levels for
>>>> break-before-make
>>>> +      sequences. If BBM level 2 is supported, some TLB maintenance
>>>> requirements
>>>> +      can be relaxed to improve performance. We additonally require the
>>>> +      property that the implementation cannot ever raise TLB
>>>> Conflict Aborts.
>>>> +      Selecting N causes the kernel to fallback to BBM level 0
>>>> behaviour
>>>> +      even if the system supports BBM level 2.
>>>> +
>>>>    endmenu # "ARMv8.4 architectural features"
>>>>      menu "ARMv8.5 architectural features"
>>>> diff --git a/arch/arm64/include/asm/cpucaps.h
>>>> b/arch/arm64/include/asm/cpucaps.h
>>>> index 0b5ca6e0eb09..2d6db33d4e45 100644
>>>> --- a/arch/arm64/include/asm/cpucaps.h
>>>> +++ b/arch/arm64/include/asm/cpucaps.h
>>>> @@ -23,6 +23,8 @@ cpucap_is_possible(const unsigned int cap)
>>>>            return IS_ENABLED(CONFIG_ARM64_PAN);
>>>>        case ARM64_HAS_EPAN:
>>>>            return IS_ENABLED(CONFIG_ARM64_EPAN);
>>>> +    case ARM64_HAS_BBML2_NOABORT:
>>>> +        return IS_ENABLED(CONFIG_ARM64_BBML2_NOABORT);
>>>>        case ARM64_SVE:
>>>>            return IS_ENABLED(CONFIG_ARM64_SVE);
>>>>        case ARM64_SME:
>>>> diff --git a/arch/arm64/include/asm/cpufeature.h
>>>> b/arch/arm64/include/asm/cpufeature.h
>>>> index e0e4478f5fb5..108ef3fbbc00 100644
>>>> --- a/arch/arm64/include/asm/cpufeature.h
>>>> +++ b/arch/arm64/include/asm/cpufeature.h
>>>> @@ -866,6 +866,11 @@ static __always_inline bool
>>>> system_supports_mpam_hcr(void)
>>>>        return alternative_has_cap_unlikely(ARM64_MPAM_HCR);
>>>>    }
>>>>    +static inline bool system_supports_bbml2_noabort(void)
>>>> +{
>>>> +    return alternative_has_cap_unlikely(ARM64_HAS_BBML2_NOABORT);
>>>> +}
>>> Hi Miko,
>>>
>>> I added AmpereOne mdir on top of this patch. I can see BBML2 feature is
>>> detected via dmesg. But system_supports_bbml2_noabort() returns false.
>>> The warning in the below debug patch is triggered:
>>>
>>> diff --git a/arch/arm64/kernel/cpufeature.c
>>> b/arch/arm64/kernel/cpufeature.c
>>> index faa9094d97dd..a70829ae2bd0 100644
>>> --- a/arch/arm64/kernel/cpufeature.c
>>> +++ b/arch/arm64/kernel/cpufeature.c
>>> @@ -3814,6 +3814,9 @@ void __init setup_system_features(void)
>>>   {
>>>          setup_system_capabilities();
>>>
>>> +       if (!system_supports_bbml2_noabort())
>>> +               WARN_ON_ONCE(1);
>>> +
>>>          kpti_install_ng_mappings();
>>>
>>>          sve_setup();
>>>
>>> I thought it may be too early. But it seems other system features work
>>> well, for example, MPAM. I didn't figure out why. It is weird.
>> I just figured out the problem It is because the wrong kconfig name is used
>> in cpucaps.h. The code is:
>>
>> +    case ARM64_HAS_BBML2_NOABORT:
>> +        return IS_ENABLED(CONFIG_ARM64_BBML2_NOABORT);
>>
>> But the kconfig name actually is:
>>
>> +config ARM64_ENABLE_BBML2_NOABORT
>>
>> IMHO, the "ENABLE" in kconfig name sounds unnecessary.
>>
>> Thanks,
>> Yang
>>
>>
> Hi Yang,
>
> Thank you for the review, and apologies for the slight delay.
>
> Thanks again for the spot, I agree that `ENABLE` is probably redundant
> (and clearly, caused an issue here). Will remove this. Please let me
> know if there are any other issues with rebasing your patches on top of
> mine.

Thank you. I didn't spot any other problem on our machines. With this 
addressed, you can have Tested-by: Yang Shi <yang@amperecomputing.com>, 
although I can't test on asymmetric system.

Yang


>

