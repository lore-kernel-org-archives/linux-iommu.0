Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010067.outbound.protection.outlook.com [40.93.198.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561FF145A05
	for <iommu@lists.linux.dev>; Tue, 16 Dec 2025 00:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765843798; cv=fail; b=EVELuZ5yhVeQQszlDHeQFg5j8jK91yvoe7YlqUWckIAAg+RN7aVm0iBKgM/gbgiE2Dg9D6OGTi4EtCYVNcsZ+bRbMm2CisAFmi8aPv2cl/e1AMErN+D2D0YWKejXzqJLVkvR43JV/oDlpS+TYGYu977moZ5ymw5VC4XVyNr3EYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765843798; c=relaxed/simple;
	bh=3bTvS8f1XAH2wacDuNd4Z+JBsJ7CSulklkDGe4ESqa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KqtT9bKfmDqihdVKpIjR25xRcYuyazgB1vkn8XWS7kaO36YdFBPi/ELbFVQZYlCKfJ3gbMYLSNLuNS+xJOktR8FnOzOif0kn+pNS/JKU7kRALKQhrHGnpUEuVZtkV2zXHsFKX3k6GNcJwrh5nNPqxIph8LDzVHYtvKfkZs7bpqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mQIzVrIq; arc=fail smtp.client-ip=40.93.198.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mQIzVrIq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KoTGS6hZ6VHLRPihJ3EBiR8UDS0Cc/gF0oFcKlNYBZbpmQcYA4Q1SMqFDyAYODPwJqYuXB2sjSU/bzARv0NcB3MmEKpBR+Cpl4GAavsFa9kDvcCKIYIWbLugtwQ7iZjbh6WuENruY76/9sca92S5ZiDOyMYRy48aG2iibSQzYTy0NLvfrsasVUKHLHscnQAB/q3BzD4k4VMWwi3DXKkrnqbTEPAMrAz8TgH/0bjGVw+EbmbSO/U2p4ULSGwn7vrHA6fp7/fML+vG2X4U/u9eWKOdhs+Uuv89b1J4E2dmMt/PUah3rhJ3Y7tS17OhDLn14kgMdENXX7L0rqsYWjNwmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQNAoH9GufuceIwZVOrGyTwknDgUbR+Pcp2xi8FelPY=;
 b=Vgaaw5ef5CZ4Gcjvzd2/Op7bX3ezlA9QPfAq9eZrOgC9Ba0ejAQQNsV+GmQeVJIAUt4a5r9CW9Yrq3EMiyh5xFBuyD3V7Cm9SuesX1wovYYM4e211YyX1ukqQD2o1gusNG9bkGTgJjmC0pAUHIa9M710SqPekBxiB/gnEdgtgfnv8v7TJB52Fc96d9kvP8JBGc+XEO0BTGhC1ioGj6fFwuw8EO9806h/uJ0nMmf3G56SCoL0/hQPNoh54HfxKicNXWgrV0fcP0fkkFAThOkNfDFSHJ71aOGic+Ba2BYQiH2tpvSpxjkYmvGFmG/EqvNuJurKze02t+NZ9k0XVq2C3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQNAoH9GufuceIwZVOrGyTwknDgUbR+Pcp2xi8FelPY=;
 b=mQIzVrIq5/MYPK5JWJpUwNicj5aYxK4YUbsv2gtbF4hh4Ederqe3bsqhEXqD9fWY8p0UQq5bw3Ca3lYSWgaLdd/mxDWqkApeqsxyb7HuueB+xnY4n1o1B6MMP2MNQ42Ev355Z7Vf1BN6waw1maJAlsZC/WYhroLUCAESXuHwlFlI9HzFdoAmEXyHxQVNE/u7HsluypNqghcz+6mFDjUVQ8j7SXBfiwc6VvlSgEnHdfq3LAcDQWj3cpS8rhYUn0DIHJze9iBkO4V+zshobZJ72O0dDxs0auUs41pk+FmBVeXvVxMD2J/XfD38EpzqC3wxTAD6nluKk3INesbL9RdKng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN6PR12MB8566.namprd12.prod.outlook.com (2603:10b6:208:47c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 00:09:53 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 00:09:53 +0000
Date: Mon, 15 Dec 2025 20:09:52 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, skolothumtho@nvidia.com,
	praan@google.com, xueshuai@linux.alibaba.com
Subject: Re: [PATCH rc v3 1/4] iommu/arm-smmu-v3: Add ignored bits to fix STE
 update sequence
Message-ID: <20251216000952.GA6079@nvidia.com>
References: <cover.1765334526.git.nicolinc@nvidia.com>
 <cc0d4ab571e2e789ee1cddfa035379dc54f0601b.1765334526.git.nicolinc@nvidia.com>
 <aT87A1ur4htPjM5T@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aT87A1ur4htPjM5T@google.com>
X-ClientProxiedBy: MN2PR10CA0029.namprd10.prod.outlook.com
 (2603:10b6:208:120::42) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN6PR12MB8566:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e4e46f6-9511-4238-1fc8-08de3c376faf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnZSTWZNWVZlSWNZODlQa1VlcHVkTmMzRGFzcDJ4L2RLZlgxNDZtUGpSNVNC?=
 =?utf-8?B?L1h4Mnp2RExvamJmWFg4clpHOU9Ca29aMFBBQ0JhdHIxeHQwM2ZYcW1FR1Zj?=
 =?utf-8?B?NmpTL2JQblRwWnNSUlBOTisrTWJPUHhLcFg3dU1oNVVRWEpKeTh0U1hvR3pt?=
 =?utf-8?B?M045UEJOakI0U2dwU1VaanhNYXA1VEdsclN6MW4vK0JuT1lYMnZJVit1UkNK?=
 =?utf-8?B?TmRwYW1ubGhBayt2MzVMRWE3RnZPd0Rmak5nV3FWU0RISDNkdW90bElNR3do?=
 =?utf-8?B?Zk9BRTY1NG1aMldEZkwxMWIyVnFCRS9xR1Y0M3Jkb0YwMjF0OTBYdVVMRkUr?=
 =?utf-8?B?NFpZUGZrUzFvbUJkU2xwRjUwME5pakpzNVVFazN1ODVXZDBpc1ZySXBnbnQ5?=
 =?utf-8?B?ZXFMSjhWWWtxUnVFcGdqMWhqekE5MFo4emhXUmNYbmpBZWdkQmhtQk9VbWRs?=
 =?utf-8?B?UmhVcXNod1R2WmN0NjJPNFkwMEkzajlWSVBQcVNrYTNLN2RxeURURmhMTGli?=
 =?utf-8?B?dzY3VTJJYzA5cFZJVFhnNlFnblRPRCthZU9YWXY0Wnk3UHROMEphVWV6cXlq?=
 =?utf-8?B?UHBlNGtDc0hQTjdHbmFtT1dXRnhxMm5GbWUwREkwMmpQM0RWeEUvUGNzVys2?=
 =?utf-8?B?UVJSaFJndGJoR3hCNFQ0aTYvLzFUSnh5cXpkMTQ5eWJzdDVtYWozYzhvWFJw?=
 =?utf-8?B?Y2dCS20wRFBWWkN5UTdFekpkNk9OZWNORGFNRDJ0NnN1SFNJUUpHbWZ6RFlz?=
 =?utf-8?B?L2NVbUlsT0tIUHBrYjhYNWl6VDVQajFzL0MwY1E3OHQvYUhKaVJXQnk1ZTA1?=
 =?utf-8?B?VFFESktYSytkRFhxVmFDbkNtTVdIbnRldno2Snd1RzNHZnVtQW9EK3lUVnM4?=
 =?utf-8?B?QUpCS0VINE5oQWFPZXp1N2VqR21nOVlNQkNsemg4cUthMmdzODhhL0hVVTdO?=
 =?utf-8?B?anIwUFdWUUJqOVI3N01hSmVOZTlaUEs0L0dnVE80Vi92dS9CVFc3SzR0Q3dj?=
 =?utf-8?B?UlZmUWdDeWs4NVplVUdyWFhxcDNvbDZxSDU5bU1BLzhlUmlkblE5Y3gwdXFZ?=
 =?utf-8?B?MWIxUU1YUitRcnVjdUV5WmVSQXFncGl3MWUvUWNiMWlmeHpUR29keGx5aTM0?=
 =?utf-8?B?VUlkM1JRUTlsbEZOZ1RDSGl6b21tL29BKzRzU0xYSkdvbStrOHVoVWxZTmRE?=
 =?utf-8?B?MUtKY3JVVmRkNnJKVGl6QjBVblM3TTZrajRtSStJTEcyRmRwZS92NHlZRTFj?=
 =?utf-8?B?cGlMYUZMcitIeUhMN1ZXaEtsSGpJOUpPVE53RkR2WHdsRzBIVEJRcndnTm03?=
 =?utf-8?B?ZlVmeEQxNzJGL0VEbWVFMGpOcE9JZ29EM2NHeDlFdDR2MVo3SUpVY0NQbFYx?=
 =?utf-8?B?emhwdC9UTGlZTXVrU0JQMmZvUFpWb2tKaFd3MjJNM0toQnFwRml6YXZ4QkVS?=
 =?utf-8?B?ekhTT1UrT1l4RVIvUGpYM2lnd1JCRFAxRXJIbmhtSFBTRjlORzRDYWptQ2tr?=
 =?utf-8?B?OXpmQlVHUnhFY0ZCRkY0cnlPekRSakppTkZxNHpjclBUdWcrSXN1REhZY1VU?=
 =?utf-8?B?blJ3WU1uTVJ4NHJicE1kVmJiU2t4eDBXVlh0MHRwQnBNZDRQMmRxRWw3TCtZ?=
 =?utf-8?B?ZnVldnVGUERpY2ppNVBzSjZjUzl4ZDJCcUI3bVNzb3grRkgxNGU2VEY1NUZw?=
 =?utf-8?B?YUUvZG1wRjRHVEEvTXBEZEhmUzZ0NmNyd2Q1OFhic2VWVlVyeWZSRjdObngr?=
 =?utf-8?B?a1FpeTUrOWk3SUkyR2d2ZThvUXlxWjlBcWlwVmIzMjd2ZUJKVDZrbDUwYmdL?=
 =?utf-8?B?ZGJ0TThZSVRnOU0vbU0yblVLL3NGUXZDUGUzSktCL3l1d0hENTd4UklyMDB3?=
 =?utf-8?B?TDM4cEh0RE96QUIydmN2bTJ1N05Wc0dIN1RNUnNndlVsTVBOYjBFVTlETTBE?=
 =?utf-8?Q?jDFUBiZihyKrNGUWEodxibcKVrOX7bX/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUlFZENKRFF6ZUc3aEdPdFZyV1ZsVGtwMDh3NGVCQmRtM1czcXNpQk5tMmx5?=
 =?utf-8?B?TEZIV3l3eG8wMDFNRWI5VjF1enFNMUJSVExMcmlDOW5HNlo1eEJ3WlhCRnFq?=
 =?utf-8?B?ZU44b0hjZFZlUjFadXNZTTlxYkpycHVrK3J6VE1TaVdxclVQTDZrRkN4V3k1?=
 =?utf-8?B?Y0pUMEhjY0JIbVJBblpyUDlFbnN2UGdpOUZDSmVVcE4vaGFrWEdyZ3lHT0Zi?=
 =?utf-8?B?bzV6WU9VNzBEWWpxcnhZNGlTd2gvMk9KRlBjYlUyNkM4YThhSk84Q0xCc242?=
 =?utf-8?B?QkNJckFub0kxSXJsRkdiT1VDazFhWGRXOHJocytxMFpPSnFDbFVub1RFYjNH?=
 =?utf-8?B?SzNqZnJZdjlDTTFtS2dDSE1vWUlVMmQ4RkNLYmJRYWhmZmFEaFY0TkFybUNJ?=
 =?utf-8?B?bG5lWVdKb1dwdzlCVzVPWFA3Rk83ZERKOGlQZDVXUThHaGI1akZGdVVzZGdw?=
 =?utf-8?B?bFRsNlpRa3gzdC9Ld1J2NDFpZlg5aDZyQkdQY3E2TWJpUzBMK3Y0Kzlydit3?=
 =?utf-8?B?c3pOUk1NMHkvdGhvZCs2alRYbzErZWZqam44YzNFSVJ2NmJXbzRFUnIvcGY4?=
 =?utf-8?B?N00wZXpvSkNLMk1OT0dFc25DM0dMZHFqY1V5eHloN2FYbTBwNGFGOVpidUta?=
 =?utf-8?B?cUhpM0pWdFFvWit2UTV3Y0JOVHJrUmV5NGNqODJyZzNiREUxeW1mRXJ1bUpG?=
 =?utf-8?B?UWx0V2ZEbUJqeGtobDI5aXNtbGxGWTFockJIY0pYbmxwbjBPR2tHZ2xKSWty?=
 =?utf-8?B?QmJ0MkVMMmJZSmQvM1RvNVJDRmJoUm9hTitDUTE3b3E3ak5MNTF2NHFibkhZ?=
 =?utf-8?B?S1RZaS9vN3RhaW1sVGx3aWRkZ1N1V3ZtbTBJQnZqQmxtU2g5UTlTK29DN1R6?=
 =?utf-8?B?ek8xM1hmSDVldkxMTEQxYm9EWjRoL1hwcm1rL1VnSXpxdlhMOXpBSHhUaHpB?=
 =?utf-8?B?VWUrdnpYbVk5cTc0SmNTRGE2eXpQRDBlTDJWNXQvU1lBTDEzb1BpL1JlcFRU?=
 =?utf-8?B?STh0bXROU1lHUDN6WGVxc0ZWSVhtSjA5NzhlcllGQjZLRHFsWEtpK3lNMkp4?=
 =?utf-8?B?NExaMzlucFVSTkg3UmRWbTIxTTVuaDlKbkF0NU9pdXlNckZlT3k3YWZ3SGJq?=
 =?utf-8?B?a0xXc25tZVhESTFiNDc0TXlWQ2VObFBUY2VIMFpYUUNnMGFnVUczRHBBU3R5?=
 =?utf-8?B?SkJHakUyYytjVnJtYU5KSUVSaEt6YlVieVJLcjBHb3Y0aTZsYjE3RkIzQUxD?=
 =?utf-8?B?VHNzRzNWMURnUGZrSFN6c2VFSWJKcEZ3Slk1U2tUUjVtdEZwd0Q0eTVMN3J4?=
 =?utf-8?B?QThLR09zWlRsOWx1WVVZMEpMQ0l6MDlyRlNFTHFwUStsRWhYTitsZHNTZ1Yr?=
 =?utf-8?B?UVVvMGxoZ3psUnlBL1RPRm04d3JpNVprakhnYVBVRW5kZlp1SG8wNW1nS05y?=
 =?utf-8?B?YWN4VDk5WGNnR0U1NHR5Q2JCa3pQN2l6dW9PK0pHd3hnNGs3cTlBRlBwQXBx?=
 =?utf-8?B?N1E4Z1d2dHk3YVJjTTNIV09wSkNTeC8rYmlaMlVDa1RHeXg2TXJPcjBycDR6?=
 =?utf-8?B?SVFyUDkyQU50Y1RxUHdRNDlUaTNjUk5CbDN2Q3V3TnRSaWJpWTZZZ09leGl0?=
 =?utf-8?B?WDh1OFVsbkpaM3VNUFlURUZ5Rmg1NUlZcFc2SzJUbTVad0E5bDBrVThRNDlj?=
 =?utf-8?B?VUlyTG41YWpManhPdmpJZUhQbFVZVFR5K3JGWnZPa1BpT3lPc29qVGtQQTV1?=
 =?utf-8?B?dWNiTzhIQlVCTzN6T2h4MjJKZGdaN1R6eTBjTWRsK2tEWEV6ZmZUbUUrQ21i?=
 =?utf-8?B?ZVM4aVRPMXQyTWdBeHk4emVFSitkODF5SW5RYWd5cm9SeituaGNxVmxzK29r?=
 =?utf-8?B?bXdyUUk0cmU0QkhyT21CL0VaanVldmozTG9vcFpkVytJazJHZWl6YlZsM1JR?=
 =?utf-8?B?bzNIc2IvUVRTNXpMR2EvL1JxaUE2Uy9XNzdZS2dpeGNDZ1FKYVpIMStzcmFZ?=
 =?utf-8?B?azhzVVlid3RhUmdQcnBHMTdKVFVtWm90djM4MnU2MjlPSWpnek4wTDdyUzAw?=
 =?utf-8?B?QmJvaUZnTzF1eDBpWVdKV2NJSEdNK3luQzhoZWVEMFlQN1Zsei93ai9qTVpR?=
 =?utf-8?Q?txbg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e4e46f6-9511-4238-1fc8-08de3c376faf
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 00:09:52.9365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qmMlz8C/1WP66xHuOhjVpvA/5Q6t9MfCUvLjukLCEAQ60bZ2KWTjKOv+4BVnoBMk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8566

On Sun, Dec 14, 2025 at 10:32:35PM +0000, Mostafa Saleh wrote:
> >   * Figure out if we can do a hitless update of entry to become target. Returns a
> >   * bit mask where 1 indicates that qword needs to be set disruptively.
> > @@ -1094,13 +1100,22 @@ static u8 arm_smmu_entry_qword_diff(struct arm_smmu_entry_writer *writer,
> >  {
> >  	__le64 target_used[NUM_ENTRY_QWORDS] = {};
> >  	__le64 cur_used[NUM_ENTRY_QWORDS] = {};
> > +	__le64 ignored[NUM_ENTRY_QWORDS] = {};
> 
> I think we can avoid extra stack allocation for another STE, if we make
> the function update cur_used directly, but no strong opinion.

It does more than just mask cur_used, it also adjusts ignored:

> > +		/*
> > +		 * Ignored is only used for bits that are used by both entries,
> > +		 * otherwise it is sequenced according to the unused entry.
> > +		 */
> > +		ignored[i] &= target_used[i] & cur_used[i];

Which also explains this:

> I have some mixed feelings about this, having get_used(), then get_ignored()
> with the same bits set seems confusing to me, specially the get_ignored()
> loops back to update cur_used, which is set from get_used()

The same bits are set because of the above - we need to know what the
actual used bits are to decide if we need to rely on the ignored rule
to do the update.
 
> My initial though was just to remove this bit from get_used() + some changes
> to checks setting bits that are not used would be enough, and the semantics
> of get_used() can be something as:
> “Return bits used by the updated translation regime that MUST be observed
> atomically” and in that case we can ignore things as MEV as it doesn’t
> impact the translation.

Aside from the above this would cause problems with the validation
assertions, so it is not a great idea.

> However, this approach makes it a bit explicit which bits are ignored, if we
> keep this logic, I think changing the name of get_ignored() might help, to
> something as "get_allowed_break()" or "get_update_safe()"?

update_safe sounds good to me

Jason
