Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021091.outbound.protection.outlook.com [52.101.62.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52B6748D
	for <iommu@lists.linux.dev>; Thu,  3 Oct 2024 00:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727915782; cv=fail; b=ng8OH7C5f/LT+a9zVL7J4s37RYGX5ca4Co1L8ZmLYAIPNq9lwQAKBRo4pDF2JbYKOgeIhlNp3eMZ4H5tsLrTMqZfslfZYH/L6PuzOe8EhKfx6pBEcNTxGTsf/C9FD6uIXiHSPX2a8Rb0AMGuazFtMOsbV9gxsSAiMT7srVSvnio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727915782; c=relaxed/simple;
	bh=8XzmOpXbs8n8BiUK6N7NxmEdfr4hygEoSRNwPLjOxAc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jym1dB7rFujfFoqxMcxWEpgOhJSMforfI1qvk/bwmuTUjSlai1wIfu0kl8llo27Oo+ljno0LiQ4Fot/5psMgTG0ggS7LZ3m+osiZvfni5q+mqSpdJxgBe/G7TWOEX6ogKXjatD4X/mWJ4CC2+nbAHvrAfVs61/YAsLhLSdpk/xI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=T+aVO8Or; arc=fail smtp.client-ip=52.101.62.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="T+aVO8Or"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJJkdG0XoamTRSCAJwomErL6gbl5SUbo/RKGRBNkYAmIYF3OLnE+Bo8jM2WIMPw9x3iIg58YhN9ejk51WdDJ5uJgnJVa2NykuZEaonCW1MzkvWWlzKDt5Zu0+Fis35gEfFwKzChHpmUo5cqyTv5V1tYlHWmP3W9HljBLu1bPYG/vOOiBZPAxrShhLrXxurFEFDeBjc1WX/z7F9MAi0lJgiezUIb+FX5VEyjT+fafcmz+uwvtkZwtJ/mXxvjxq1dqhyclroBJzMuAVBYJlNyFyYjWgoA1H7ClUGkFzQq4LxfusdCAM7kEI4Ey+9rZXegxGtw+Cx1Dz0sUjSIsP7XqQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvFhxifQas3PIxol/jRidKFS2mtYQg7xzKflOG3dH+0=;
 b=DPA+lCjb1zSkoZ7/tw/b4+uR0mJuMZK7lFs22A05VT6ocCi/OpUlmch9fbXidcGww3Hs+wnAv3fgU/WqnnbLBrqerJ25qnGtbF7Z58HYHOyuAcM7SfQmBaq+pOdfeBV/2RgLdvfKD8Hzn1Rbqc3kO1mT9qVpilmA3ECY3wwa63awSdqsGjcmrKgKNJI0jz60EL83yZD8gq5mUops+/Tn2q0NEAyRpgs2HpeHsDy2H4nMECbWOrx3ZWXhXU9wxbCN7Gw42abkaIUFoL8LcwiBfOqrvlCyVT6C9eymFMe16ZytRvKcc5GM+lJRLfPy+LL0I6h+VvrUetRPiYUloTDmIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvFhxifQas3PIxol/jRidKFS2mtYQg7xzKflOG3dH+0=;
 b=T+aVO8OruJmDN1WPg9HWodSrlc8sUsDA9ptohDsf5ZuIB35goAd3d6vxjayvqBrGZDCVzac/WER7NS+gjzX0alV/O9aCAN0wofrHPGXZZs8q0TNxpKwKH1sGZe9thNJUakdQTkc09KL7l3j8MJRd59bBCcXzBYofyMWRcDzGrGY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 BL1PR01MB7697.prod.exchangelabs.com (2603:10b6:208:394::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.28; Thu, 3 Oct 2024 00:36:16 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%5]) with mapi id 15.20.7982.022; Thu, 3 Oct 2024
 00:36:16 +0000
Message-ID: <fd04bbc8-8ebb-4091-b56d-32072587fa99@os.amperecomputing.com>
Date: Wed, 2 Oct 2024 17:36:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix last_sid_idx calculation for
 sid_bits==32
To: Daniel Mentz <danielmentz@google.com>, Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Jason Gunthorpe <jgg@nvidia.com>, Ryan Huang <tzukui@google.com>,
 Will Deacon <will@kernel.org>, Mostafa Saleh <smostafa@google.com>
References: <20241002015357.1766934-1-danielmentz@google.com>
 <ZvzGg0P5Bj2sgNZm@Asurada-Nvidia>
 <CAE2F3rAQ8BpYcZZBS6BfFeZtMkH9LK7WZ7nniJSbTBW4xDq_rQ@mail.gmail.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <CAE2F3rAQ8BpYcZZBS6BfFeZtMkH9LK7WZ7nniJSbTBW4xDq_rQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0121.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::6) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|BL1PR01MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: ecb2d760-8f63-4bac-9cbf-08dce34363ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qkh0ZjJubGJLRStJdDJUUW05dHp2TjUrTElhUEVoNmV1ZUk1d29PTCt3dFVG?=
 =?utf-8?B?ajA4OTI4RHNBK1J3RS9HL1hHU0hpT21PSGk2L1B3eHFVaHVPdEZkVEdaTVpH?=
 =?utf-8?B?MWlqQi91UVpxUHBOU3RwVmwzdC9WcUw3OEFDdGFuamRSUGttbTh5enlvVk91?=
 =?utf-8?B?NWFrS2ljbktRZXROV1MxZkJNaUdkSi91S1IzUkxQeXZ5VjJIZmgxTlN5Yy9z?=
 =?utf-8?B?V2ZONy9tSFFJUm5ZaTI2OStIdklySHgxVHg1Y1pXL3NlLzUzRkRBSm5TMGJw?=
 =?utf-8?B?ejZUREpLaXhJWnFmdWUzSys0MnFyNlQ5ZGx3YWEwb2FGTnZMbnFGdURzcmxD?=
 =?utf-8?B?ellPN3RDZi94OXFYSDA2UCtWbkhPZmQ5WmE0SldWckhsY2FkVnp0MCthTWgw?=
 =?utf-8?B?anIrKzEyenZNaXk1cVp5YncrSGlnSFExSkNyakFQK2IybzFjZCtpczRhNWhJ?=
 =?utf-8?B?V0xBTmxrNjZQWTZkNDRkVXpjMURRSEVqaDM2QnNkMWZsNHF0c0FETGxvVE5u?=
 =?utf-8?B?dmFwYllMM0tLRkRBU3IyRkxOSWsrekpPaVI1YXh6TExVUDFCT2NvdzdMdkta?=
 =?utf-8?B?NUdIS3FqM1pKRGlTOXM2UTJkNmRkaTAvSTU0NnFGQ3Zsdk5YTVhpMkE0WmMx?=
 =?utf-8?B?MHVqWmhYODViSVFCQk1sWStCUXJ1OXlac2xqSlJ2cnQrdWVnQWR6UE8wdjE4?=
 =?utf-8?B?aWpsMmM2OE1vajJ6SVFnc2IyV2hRMThoMGNMb1J1ekYxVEQwRnBILzNJZjA3?=
 =?utf-8?B?dnFsQ1BicGpud2pObk9DYmxRbHQ4VDMvb3NiTGVHU0JiemlMQlJLdmROMEFn?=
 =?utf-8?B?T0Z2ZlhvelplYWJCZ0hzNFBSZUVlcEJGSlYxVGtKRlNxekZBeFlrSGxuMmVE?=
 =?utf-8?B?Y2JIcTZ5TnhLTzdJTkN5cyt3RkFjUXVTK0pNclRaNEJuMWZ1VVluYkZQNDlF?=
 =?utf-8?B?YVBFM2h2NHhuQUl0NWtoOTI3S0dyQnBZU0N2RklnYjBmcVd3ZHlSNzBEWEw2?=
 =?utf-8?B?enBENjlXRi93YXQ4YkNndkYyM1haVnpzT1oxb2VRNnNtbHh5SU9XQ2RHd0l3?=
 =?utf-8?B?QllaMTBEOXoxaXl0Wk1NdWJ1dzZIcWdHSlYwT3pHd05HTnBYVjlJZXFFQzk4?=
 =?utf-8?B?S01xSGZTdHBCS1pIK1YxUndPazVobjRYYXJBVkQ2MjV1Ym5ZYllmTWR6WmRU?=
 =?utf-8?B?U25VS2R6dzhvMTVjK0pKQlhOQmI5Z2duYzVqZlZZY1V4NlU5dmxUNjYrZFFL?=
 =?utf-8?B?bU9QL2xud0FraVF3a1FybFhmZ2dtMzArNjdhR2JJL1NvN1pUN3oxUHlCeWVK?=
 =?utf-8?B?OVhQVi9jSmtZVzN4TVE5Wmw5TWRSa2pPdDBhb1Y2RXBaN3kxZjcxVS90d1o4?=
 =?utf-8?B?bGVaS0lyNExXcFRHSU1wMWp4RHlOVllHUWJRcVUvL09mZUdjdGc2alA5S21W?=
 =?utf-8?B?WnJoazJ3VnJ0QWlYeUNJbGFncmdkYUJpaHJSTVRiNWIwSlZnNHVWQ0xCK1Fz?=
 =?utf-8?B?YUN4Mjg4cmNTQmtrTWNSZncwOHFOZmMrNWM1UUtXTXhEZE9lQnlCVithZjJj?=
 =?utf-8?B?dk53RExvV3lSWk5ST2NneU1hbGNrdnhmZmtLdHVuY1ljUWJ0UXYxYitCVUNw?=
 =?utf-8?B?bDlEbEZ5STVLcDByUGRvREh1RG80UTFlRytnVkdMdWFGNGo2dkpBWDMwdEoy?=
 =?utf-8?B?a256Y1NuamdpUjNkRGxRaTRNRThZSFVmLzM1MUI4VnJ1VUtJZ2JISFpRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWRhaGtnRjRBaFZNNS8vTlpidFNPQnV1Y2E1cWxSNmdDZWZieFVuQklaaWNR?=
 =?utf-8?B?SDV0aDFhZ2I4TFJCYldnaDkyQ2FXaHRkczJlTW1SV3lQSTd1a1VZSlV1VUI4?=
 =?utf-8?B?QmhLWVlLNUVLTDhrYWVNWjMzSFNhZVR3dWtLdW04a1FmbGVtWHZnTnV6Smh4?=
 =?utf-8?B?cHNnWmd0ZkpFRkV1MXhsRHBmZTBwbGpRZ21uVEhFN3Z1bGFRUzExb2Rpa2dK?=
 =?utf-8?B?MUd5c29kVy95MnVxVndPTFZJY3djSTcxVTNNcFJsTUQ2emxYZGZNUEF1Y21V?=
 =?utf-8?B?dGlQR29QdkVVQlZDZEdjWVk1eWtvQmxaTmh6S1U5cEVVRmlVWGxXemJiRHZS?=
 =?utf-8?B?b2dZdDVMVkdPV1R1aEY2MGVlVWJjdE9Td2wrdUNIVSs2QmVoQzduODU0alVn?=
 =?utf-8?B?VG9CcGFYMks5WUFqdkFOd0FVWlhsQ3ZDc1VicVhEcjF5SGU0WkV1L2RZam05?=
 =?utf-8?B?Z0lCdHdKODNEUStNaXllb1J4allnUVdoUjVqdm1tRTZkbFNCaEdYL08wNzAw?=
 =?utf-8?B?U1FuOGx2YkFkdHB4UWJYQTFyZTRBemdJdU1uWk1ybm5PZ25JNDh4dWpJaUFj?=
 =?utf-8?B?WFFqV3ZJOXlKeVRpUnBxbXFxYnpQUFc1eUxVaENKNzdEZzFJOUp4UFJTb0FP?=
 =?utf-8?B?WnJsa1Ara0s5SDlsS004UldGMjNCUUhDQUFlRnFTbThSeXZqclJZQ0tRS0E1?=
 =?utf-8?B?WEcvak93Sm0rcW1Mem1INGpSVWdtU1pFRHc5NUJQanltNDl4dWVvVUxqWGR3?=
 =?utf-8?B?a0hjcFZuREROeXl4ciswbnhSbHRLWlJ3STBYMDI3ZHNQZG93eTIvWkg3RW8z?=
 =?utf-8?B?OEdPbzJCcTQ5R2xna2I1MXRackFpSElqaVR6T0ltRkpDa3VTSXZPYlVvejF5?=
 =?utf-8?B?VXQ5Qks2Z0psWDhWNU9nNmpGZWRhTWg3enhxWVRZeGlwdnV0RkYwVkgySG9X?=
 =?utf-8?B?WWpGRzhOUkV4dEZjRjErQzk3Qnl5d2lyREsweWZkWWt0dGQ3bWcvaTREd21J?=
 =?utf-8?B?L0loYnNxR2t3dFF1WU9jVE9aYVRLOVFCcEdmTG5VdHpzbEZNUzVrYkRjcFR5?=
 =?utf-8?B?c2w4ZlJ3bUdHZG5YMEF6WFRTdG1hL3FlRUk2QWZBSEwzdHdiUVZGU1RZNDgz?=
 =?utf-8?B?Y1pTa3VXellJenduNWpzaHZpTjRBV0FKaDBYSDVsZkhONEE4SlRRSmpyaWEx?=
 =?utf-8?B?WFJzRWdFazhKWklpbGFGZFEyMTE2dFdPOHFwNFhWYTE1eCtreTNsMW12K1o3?=
 =?utf-8?B?R3ErMlhCS3BlNkFlV0M5YjdTMFFzSU9pNm9HREJzZW5HbGF4eTJiUG85MjVu?=
 =?utf-8?B?Qjl3UUhGYTlFMzhzcHBIbXJDN3dPL3RvNnBsTkZuKzdEcEtaYW9sU2ZlemFB?=
 =?utf-8?B?K1pwZ245WW5vVHNXUkgwclRLT1UzeXMxdFN1Q294OHdtdTFUUFAwK2NWbm1C?=
 =?utf-8?B?R1dTVFltTkZQVUVmcEdWT29wUk1oM3JhVG9LQnF6d2E3MHlrZXhhbnUwcU1p?=
 =?utf-8?B?cEJwRm5WVXlXODR6RUhRenRvcHFkSEoxUjA4bHA5M3ROc0dhcEtrSDIzeGZa?=
 =?utf-8?B?RW1UNFVacXZHYU9OWDR4QWNLWFQ3NG1vcjZoNDZ3OXYxSGhQWTJiYkh1ZXht?=
 =?utf-8?B?OWhkbmtOdFlZTGsvOWswU2xzWFpKdExKeDAwNlkxVHlPaXZKU3ZtWENtSVlq?=
 =?utf-8?B?MUVQeEM0ZEYrL0gwUThPK0xpK2doQ3lDK1JrbGx4WkxRL0x1SjZrK1pWTjJ6?=
 =?utf-8?B?QXkwaTJHcEpkbU9xdDhYSFFJeHVHTVVaRWIvTHhWK1crWGVhcmYrOGZCK2V0?=
 =?utf-8?B?WUxlbmxlS2F5Qkt4dDBlOGFmbEczUmJ2Qy9yNFFhYmlZUmNUR0xYcmlYZHl2?=
 =?utf-8?B?dGVJM2dNYUpWWVRYK290R2Nzb2U3R2p6MnYrQ3lqS2xHQXBjcllJUkU1ajNv?=
 =?utf-8?B?QTFFNTdFZ1AzUjRmQnFKWmhuL1hvTkduN1BYOFlFQjFUUE91dVdyQ09iN1A5?=
 =?utf-8?B?VXlCQlNPYmRScE56dFYrTUxoanVQNDFPbkFaTU9zSGhTdm9ZT2w3eHQ1RW9a?=
 =?utf-8?B?Wm4zU2VkcWtUTXZpeUkrUXNjQ3RyRnpGM3drQ2o0MUtPOUxLYVZZZjRNQnNx?=
 =?utf-8?B?cHBtV21STlFqZ2pKTEdoTk5raTVDWXV3ZGQ1Y2dBcGlqbnYwSEViSnJtZ21r?=
 =?utf-8?Q?5gcT4SQKKcrbY6MvDMMzVvc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb2d760-8f63-4bac-9cbf-08dce34363ed
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 00:36:16.2250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BYdSXBpiRPHb9gk88Qqz6poq8OQZp+baEon2FGfsUVFr+g/dyqepQaIqNpAQH5uWb5HhARfFPVhZS2pys2/nFQ9dqpZZL9Qg/HaWx71YJIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR01MB7697



On 10/2/24 10:58 AM, Daniel Mentz wrote:
> On Tue, Oct 1, 2024 at 9:05 PM Nicolin Chen <nicolinc@nvidia.com> wrote:
>> On Tue, Oct 01, 2024 at 06:53:57PM -0700, Daniel Mentz wrote:
>>> The function arm_smmu_init_strtab_2lvl uses the expression
>>>
>>> ((1 << smmu->sid_bits) - 1)
>>>
>>> to calculate the largest StreamID value. However, this fails for the
>>> maximum allowed value of SMMU_IDR1.SIDSIZE which is 32. The C standard
>>> states:
>>>
>>> "If the value of the right operand is negative or is greater than or
>>> equal to the width of the promoted left operand, the behavior is
>>> undefined."
>>>
>>> With smmu->sid_bits being 32, the prerequisites for undefined behavior
>>> are met.  We observed that the value of (1 << 32) is 1 and not 0 as we
>>> initially expected.
>>>
>>> Similar bit shift operations in arm_smmu_init_strtab_linear seem to not
>>> be affected, because it appears to be unlikely for an SMMU to have
>>> SMMU_IDR1.SIDSIZE set to 32 but then not support 2-level Stream tables
>>>
>>> This issue was found by Ryan Huang <tzukui@google.com> on our team.
>> There is a patch that's sent a few hours earlier :)
>> https://lore.kernel.org/linux-arm-kernel/20241001180346.1485194-1-yang@os.amperecomputing.com/
> Thanks Nicolin.
>
> Yang, in your change, I believe you are arguing based on the Arm spec
> ("dest = src << (shift % 32)"). Consider mentioning that the C
> standard states that this behavior is undefined.

OK, I will add this info to the commit log too.

>
>> Thanks
>> Nicolin
>>
>>> Fixes: ce410410f1a7 ("iommu/arm-smmu-v3: Add arm_smmu_strtab_l1/2_idx()")
>>> Signed-off-by: Daniel Mentz <danielmentz@google.com>
>>> ---
>>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> index 737c5b882355..b55327d6058e 100644
>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> @@ -3625,7 +3625,7 @@ static int arm_smmu_init_strtab_2lvl(struct arm_smmu_device *smmu)
>>>          u32 l1size;
>>>          struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
>>>          unsigned int last_sid_idx =
>>> -               arm_smmu_strtab_l1_idx((1 << smmu->sid_bits) - 1);
>>> +               arm_smmu_strtab_l1_idx((1ULL << smmu->sid_bits) - 1);
>>>
>>>          /* Calculate the L1 size, capped to the SIDSIZE. */
>>>          cfg->l2.num_l1_ents = min(last_sid_idx + 1, STRTAB_MAX_L1_ENTRIES);
>>> --
>>> 2.46.1.824.gd892dcdcdd-goog
>>>

