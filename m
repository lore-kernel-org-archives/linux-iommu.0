Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CFA18DF8D
	for <iommu@lists.linux.dev>; Sat, 12 Apr 2025 09:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744450882; cv=fail; b=iETtB7ETGK02e54eUHdl0oRVSC1e5o1WcIpglAZKZBIPyC/XUfkkk+xLj7vE3lIRYofQ7OkWCZruzvZt3sXhrrb3x+tCf1NPqlQlIwoZuLdDOfATCEgKCmXl/Snn1Bw3EQJTme0YjGG+Q8VJkgcispscoIcqEMALYBveVD6bN/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744450882; c=relaxed/simple;
	bh=DBPOVYlP874bKLuybTFWczk4F5yL+XzxdgsSiF+7gXg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fAdohpoUdUbf2iLVvOEI1dvo354vkLsJXzHZvjRpvkoVsDzO9Ca2YFE8Eu7J8Obv/BjiVLEYY+StpF+5zsUYb3rnPV28iL9Azr1ZRWQmRzRcdEunbv9fDDzPnheVZrcNyqoQVBkIs87pd9xPJNUIc5AdOvn2aC4P+rMsVYURz4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jjZ6OUoU; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jjZ6OUoU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yys65k1ewPafSouNt9kdFOcbDZW9b2qjOQr0N5ZNwFMSYd0coiSNO0nsDfXkJZ2791XLyHb1Jyijv3f724uQgLSH1BtXfGNOUnsbrJzlp79zH1RFh+NLd0dBHJV3nWj/9upr61QgHUu++9fXP92hm2A4lxG30pAGc44B6j833Q9x8lShVqvGOUw1a3Brxj/67h7gGoaJGhhgx2ULkNWg+u9U/KdnTaU16sAxKGoBuUPfRaCMYIn+MbPTubas+LmraHZQviRiVjwxwcq1IpdRwJuH5jVUui4kZpQi8jHMBED7jeVv7QApcIcgCUYC0q38S/utXWLf3SJq4MR8Q9NdQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/Im7ncPnAzNzypjrGk3pDb9XCKDkivpdSLT6IsUFGI=;
 b=sjpJsaVJLWRF000shJlfx0SAvyNQuLiB98QVD3DbPVeG91jDev//HUw9wF6X04Xhz+EGWSYfzJR0PnQEnhwQ/l7VhpIkd4/YeM4jU7S0d3Lw9bJrLEy4fOBVLeL90L7CeYE+0tZRML9VvijZxa797b1l2UPGWsZSlHDOyb+H7aMr8S4noYm4CeZRnlRMvgXrenruJaQLfe40UMu84nCh7A3AoS4FbvkkPpQVSvBX9kZJIw0w1/nRl523wJyIIjL6T/hf2vxmgvuaJx+I12MK34QkK4ZljBCqKhaBAWeu6uD+fM8dyjjqj8AxbDsemr5Otrq3yzWLjMCnIXh2GqCsdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/Im7ncPnAzNzypjrGk3pDb9XCKDkivpdSLT6IsUFGI=;
 b=jjZ6OUoUii1j8rRBNkmW4vOeaqL82qMucYcoRgIrwTTcaXeQoflv06zXxbrd4CJugmCSeKH9U8IqqiCr4MUk5HM5uEejNUd+R8TgqcPZHTcsfLiqtgOjWQqEWlAMsZEK5tdr2f1XG0GSbt4VGw9lKZkfT6w9XaUkh7V1tui7NwDAwl33QmjlR93aTHkXATWZ4iUXJ4rWhkeYqVVwOi8NxpAe6Yxeyd/aRFzMfdxFEpYY6V4mMEzahMr1gGNHnkXuMDZwJNOw5LNdN3NBBL8nJVrDOGHZaIvwPrJ7JtwZA1znJ+Nw1bKEKTmH3q2uRNzWOd0fUUdEHCdeHewI3FOSYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8SPRMB0035.namprd12.prod.outlook.com (2603:10b6:510:231::6)
 by DS7PR12MB6093.namprd12.prod.outlook.com (2603:10b6:8:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.29; Sat, 12 Apr
 2025 09:41:16 +0000
Received: from PH8SPRMB0035.namprd12.prod.outlook.com
 ([fe80::232b:2a40:c4e0:b4f0]) by PH8SPRMB0035.namprd12.prod.outlook.com
 ([fe80::232b:2a40:c4e0:b4f0%3]) with mapi id 15.20.8606.033; Sat, 12 Apr 2025
 09:41:16 +0000
From: Balbir Singh <balbirs@nvidia.com>
To: iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	Balbir Singh <balbirs@nvidia.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Ingo Molnar <mingo@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Bert Karwatzki <spasswolf@web.de>
Subject: [RFC] dma/mapping.c: WARN_ONCE on dma_addressing_limited() being true
Date: Sat, 12 Apr 2025 19:41:10 +1000
Message-ID: <20250412094110.3208838-1-balbirs@nvidia.com>
X-Mailer: git-send-email 2.49.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR17CA0037.namprd17.prod.outlook.com
 (2603:10b6:a03:167::14) To PH8SPRMB0035.namprd12.prod.outlook.com
 (2603:10b6:510:231::6)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8SPRMB0035:EE_|DS7PR12MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: e42671c5-3467-4c40-f4b4-08dd79a62bb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MnMrOGcyT2UydzlDcktzZTBDZEdNdnMzME5hclg2bkoyaW8vci80d1FoKzJn?=
 =?utf-8?B?a1dpcGRieTh2NldkWVRtMjVIK0d4eU84M3A0ZTdNblZkM3pVZHZYYm8xMUZp?=
 =?utf-8?B?V2h2dzdnUGZKN0dpMUdOaTR4OUdFZVBReEliMnREa2tnNU5ZZ2hZOEVjdnZU?=
 =?utf-8?B?d2J1NmhFWnVrK2txQVRKemVmcFBwcitvUUpoTDhydWl4MlVyckRzcFY2c0U0?=
 =?utf-8?B?UkpJbGgzTzU0Ymk0Sm5NQkNtT1pnakl3UXF5T2Rld2s1Wm41ck1iRStJUDBi?=
 =?utf-8?B?VWVsRS9keFY1SWtQUEJMTjRhTzBuZ1d0ZjE4Rnh5bjhyT2pncDFlSmttODNl?=
 =?utf-8?B?ZktlZ0oxSUp6NXpUaXJzNVJRcWQ3Q0ZLdlN0emFCcUx5YUpia3VpaGVGZHRG?=
 =?utf-8?B?TDFyWm4rSjZBOHBRSU1yVUFmZ2F0bUd1TWRybzI3ZWxhTU5DNHJaeTlIemFx?=
 =?utf-8?B?SDVqR1FWaXN4U2VPNXVpYWpBSDd0WHlnekFjM3k5OEJoVEpXS1V4bEdXTkho?=
 =?utf-8?B?dytTVlEwZ2xkdnE4b05WYmNWT055cTQrQjdZWk5yL3puTTEwNWJEdVlPUDFV?=
 =?utf-8?B?S0gxbHFLVWhkd1BGWXI2Q0NxYlBSTjRKOWdsbmlTTzhWNDdaZVA3OFhXa2J6?=
 =?utf-8?B?azFrSWdYaHhsUFc0SGpZMmRadjFDSDI0WnIvN05mL2RRV1RraUorM0paMlZL?=
 =?utf-8?B?aU1aUjhYclJDTnhtajg1bWMwL0JtZ0ZQS2wrUk96WnhnRjFoK1NpOGpmTzVk?=
 =?utf-8?B?OEJadkIxMlBFSytmdWxCU21aZHIxVnRrTzB0eVd4Z0tPWmJ4L2dvWnU4VTU5?=
 =?utf-8?B?NVFxb2x0VG9WbFlkdHNHbWpQSGZ6NGExMm9zaG9yNzNWU01pa0dETjNsRWl5?=
 =?utf-8?B?ZWF4SHcxRDBpVGtyNm5ycDI5cXY1ZThHbkgxWWhzLzJSSWJQd1BkQ1d3Ryta?=
 =?utf-8?B?VnpwTlB1Qm8vK09KWkRZWFFpWmF3WU9kSmhYb1VISXljUGdlaG9CV014VkhB?=
 =?utf-8?B?ZEkrYjFlVno1dGw4bGx1SDBQSENXTWJwajIrQndGdlllb3lnaEJzZGdQRldQ?=
 =?utf-8?B?b3h6eUk4STBqWXNqRklOSmZxeVhZYnZjc013MTJ3VVFvSzF1cGp2OEl4WDRO?=
 =?utf-8?B?K2lNT2hYc2luUHVocHhVU0tQaFQ0ZjRQWXlrZmJIbFZEYTBYSEU0V1BiQTI0?=
 =?utf-8?B?MHlsc2ZrYUJuM01LZkJhdytVWHJ1Nlh3ZUhTR2cyaVl5enZMTWFTa0hGNFUw?=
 =?utf-8?B?cHB5MFdTRHRIVlZHTEJ0MFh5REFleXB6UEEyVWJUSENtZmR4V2ZjOTQxUFRN?=
 =?utf-8?B?ZU9ES3lBYWgvT1ZlZWR2eTljTm5na2J1V1FVN0N3ejBxcVBvOHpvS1pCd0Fa?=
 =?utf-8?B?UlZpeVVkeUt5aGNHcmJaQ1RISk5qWVVGQVgvNlJPdEJEM0hYT1QwaHF0Rmpa?=
 =?utf-8?B?bk5ySTc2MHg4MlQ2SkM4VjV6OVZ4TmlVdDVEb3dRVUtOQThFSnlZZDhmUEhl?=
 =?utf-8?B?K3daOHhEYlBNVk11RGY2bzdRL0tGUDI1Yjdsc2ZLeUo5bDVRQkk5ckE5SWdw?=
 =?utf-8?B?bmhYTmRDQWIzalZvOGdKOUs1V2tQd2x0bEtLOWYvcGtSeERGajJSbERBNXgw?=
 =?utf-8?B?Ky9MSisrMlFyNjlZbWFMUFBRa29Nc1ZuQWhuRjIwUlZtWENQRzB2dEVFRWZP?=
 =?utf-8?B?VVh1MDNpY0gvZTFBZHIxMmlPVjhNTUFZcXJCc0pqeklpWkNtMHJmNEpKY1VW?=
 =?utf-8?B?UEEwUEpBaTFYbUw2bDdRSlBBbE5iZmxkTlVWNEd1WGpXbE5Yd0dYbHVvTWlC?=
 =?utf-8?B?c0pLSHB1aGRhcUkzenYzV21ST1ZNbFJzUTlLNkM5V2drRERWNTBId3dpcGtE?=
 =?utf-8?B?Z0J4T1luTTR1SE1jeWpVMFlBYTVVQlQxUTF0RVl5SzYxM09YZmlZN002Nmhl?=
 =?utf-8?Q?EhoDqnhb7mg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8SPRMB0035.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlUwaFYrN01WbzZwa0dESmU5d3phZm9vRGNTdXhJKzJqMDdxRDY0TjY3bkVJ?=
 =?utf-8?B?L1ZPbWJCTWtlUm1qYytLMlNjdWo5VlBtcEUvbHlvazlKekVzMHhhejNvVEtQ?=
 =?utf-8?B?eGpnMEhUazIxRE1WR3hHYnNXR2dJWi91NWdGV1RpaW1UWFcrSW1XY1ozeGo0?=
 =?utf-8?B?OGdSY2l5Q0ZJTk1XVjhEd3JpbjF0NUJ0NkpRbFJoUWJBVlNod0Y3d0RyaUJI?=
 =?utf-8?B?SDBwUFNZVzRHbU81MlVMU0Y4LzdvTFI4WCtSUmJwWVdqS1RnQXdqVUhLVFZV?=
 =?utf-8?B?a3lJdTRYUkZ0RkRSWVUrZG1OVGNZTSt0REY0cmpNcDA1UStBQnlKNzlrYU9E?=
 =?utf-8?B?c0RQN0RIQlJFUG1Ucjd6Q3A2WmdkTENRdmdqc3ZkQzhRNE1CZHhDbmdPemVC?=
 =?utf-8?B?MkNPRnFXUXp6MUZxb3FGQjUwanc1anNUSFNOWmxhdVFkOHZ5QWxXdXdkbFZ6?=
 =?utf-8?B?Wmc4cmNBbXFSbEUyOVhlblg0UFptQ0NnaWtxall2RWt3Y1AxSHlSNnJ4c2Zy?=
 =?utf-8?B?OG15ektYQytrZzJsWmZoZUxzcVE0WG9zenFXNWhSVFJQdFpubjFDNlY0ZlND?=
 =?utf-8?B?WmF3OVN6N3NEUlE4TGtWQTRhaHBGSm1iSU9JQlAzK05peERCcXUrL1lYZ29F?=
 =?utf-8?B?N3NjcDhrMnZSZG9QZ3FBcytXelZaOVh6Vm1nTS9mTFByWFcyTE1nWC9xTTc5?=
 =?utf-8?B?Wmt1Z2FpY1RkekhQVExEQWNCR1BHSDl1YlFrQm1sTHR5djRIUUl1VnVlNGhr?=
 =?utf-8?B?WHlpTkxJTDdlUVVXdG4wM0N3dEs5czQzeWw4bml5MEc5OVNBSnBxU0lCejlE?=
 =?utf-8?B?SWZyakJVZkY1OEl3MzFCSXgrZDM3emMrM0dKa0JEUGR0WkQ3WFRwWjRWanN2?=
 =?utf-8?B?bURvRHQveVIzdUsydWJLck1ZcGNiUmJacXpRSU1NNXpRNmF0YmdpYzFSc0g3?=
 =?utf-8?B?TzNMZElWa2E3UUFrdDV2SURsRjI3dlhQaVA2QzNZYTFNZlRlQWNneUdEYnN6?=
 =?utf-8?B?MEZNN2hsZmhnTU51V3JXaTdOd25XTnBDNjd3Rm1QWW1GTzB6RjVJdFhpY2Nh?=
 =?utf-8?B?M21uMWRSWGFDV0FWZkVBdEJFRzVZVVlKVjFqVS9ROVdrOVBSVHpCaXdTRXk3?=
 =?utf-8?B?ZzBicHV6c3M4MEJJZ2t1bG10TGhhQlgyd2psWUp0akJsOU5uSC9OdXhZYlcv?=
 =?utf-8?B?ZVRhWCs2c0ZybHNCaWZpcnF4M1ZGMnpWQS9WT0xUajJIdVIxN2NJVWZ5VWk4?=
 =?utf-8?B?OEVUbnhUL3hWb2R2bnA4czhQK2tlc09JNU9zYzVUNnhmTjE1NTBPQzBaZUty?=
 =?utf-8?B?MnNhc3pkV0t6SFhMdXlkZWt5ZlVRckNwRno3YklISW5PajAxODRJckk1M1hl?=
 =?utf-8?B?blZlc0FtZ1NjY3ZNWDg3djl6VlV0SXpDMCtXUUFxOCtvNlZSVlp2c3diandD?=
 =?utf-8?B?SnZFc3hSb2xhcFJKMzhOTkhZYjFhcVZQUnhnemxZMGVwNXg0UlRreHllcmJJ?=
 =?utf-8?B?d2QwMGdySHQrQ29iaGZCS1cyd3h5Lzhna1h2MEtIWS96Sjc5d1p4ZXllQVNx?=
 =?utf-8?B?TmwvcURCb3lxMjY2ODZvUVNFSVVWSFdqQ2d4dCs3VUtFU2M0K3FBL0hoekZ2?=
 =?utf-8?B?YURqcHluVnZPSitycUsxZHNpWis4WE1KU0pGeFRMR0J4L0NvckxWbWV2Ykg1?=
 =?utf-8?B?WitaRURSWk9qRDdJK0pWTWhGK2doenZ5UUNObTVpNVVOUnFuOFFJQWQxS0Zt?=
 =?utf-8?B?Q1JkbnFSQnVkZURLSVBjd3RYZUlKdTFFU2EvbWpPZEdxV0tJOUJzY29rN1FP?=
 =?utf-8?B?THFlRG43SlE3ZFRndUVEcXFaM04wckVNQ29mb241WjdTdEo1cHdBOG1ESHJm?=
 =?utf-8?B?a2RHRDB6Y3p1NHNoaVduQXZ5UHd0K1JNYUZpQVVVSHEraTVOUmRhLzBBV1kw?=
 =?utf-8?B?a1FhZ3Q5cWlEaDhmaHdXdVErWXdhTTJpaEpPZmJyNXNrY2xDOVdiL0hVS285?=
 =?utf-8?B?TVl6amhucHVLS1RZQXRiMjRqTGhZa0o3NVNwaUZKTWxGeldJTUNkbjNTOGJC?=
 =?utf-8?B?QjdIbkwrTzVFUHVHV21UZFFIa3luNUZPQXkvb2kyeklNenVGVjNLNkNzV2E4?=
 =?utf-8?Q?5buffGelcirphOQZ6NAD/EgcF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e42671c5-3467-4c40-f4b4-08dd79a62bb7
X-MS-Exchange-CrossTenant-AuthSource: PH8SPRMB0035.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2025 09:41:16.4064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: njaF4jSCOj29lX0mWPQ7y5TndWnZy1ZRHhvX7RLeaC+vdjy5snPjxmSJxUgmgWh9z0klKzJ0i/XjFO4mtUUOrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6093

In the debug and resolution of an issue involving forced use of bounce
buffers, 7170130e4c72 ("x86/mm/init: Handle the special case of device
private pages in add_pages(), to not increase max_pfn and trigger
dma_addressing_limited() bounce buffers"). It would have been easier
to debug the issue if dma_addressing_limited() had a warning about a
device not being able to address all of memory and thus forcing all
accesses through a bounce buffer. Please see[2].

A warning would have let the user of the system know that in their
particular case, use_dma32 is set due to the addressing limitation
and this would impact performance of the driver in use.

Implement a WARN_ONCE() to point to the potential use of bounce buffers
when we hit the condition. When swiotlb is used,
dma_addressing_limited() is used to determine the size of maximum dma
buffer size in dma_direct_max_mapping_size(). The warning could be
triggered in that check as well.

Link: https://lore.kernel.org/lkml/20250401000752.249348-1-balbirs@nvidia.com/ [1]
Link: https://lore.kernel.org/lkml/20250310112206.4168-1-spasswolf@web.de/ [2]

Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Kees Cook <kees@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Bert Karwatzki <spasswolf@web.de>

Signed-off-by: Balbir Singh <balbirs@nvidia.com>
---
Testing: Tested lightly with on a virtual machine, I do not have access
to a device where dma_addressing_limited() is true


 kernel/dma/mapping.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index cda127027e48..0f0455fa5bc8 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -918,7 +918,7 @@ EXPORT_SYMBOL(dma_set_coherent_mask);
  * the system, else %false.  Lack of addressing bits is the prime reason for
  * bounce buffering, but might not be the only one.
  */
-bool dma_addressing_limited(struct device *dev)
+static bool __dma_addressing_limited(struct device *dev)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
@@ -930,6 +930,17 @@ bool dma_addressing_limited(struct device *dev)
 		return false;
 	return !dma_direct_all_ram_mapped(dev);
 }
+
+bool dma_addressing_limited(struct device *dev)
+{
+	bool ret = __dma_addressing_limited(dev);
+
+	WARN_ONCE((ret == true),
+		"%s might have lower performance due to bounce buffering",
+		dev_name(dev));
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(dma_addressing_limited);
 
 size_t dma_max_mapping_size(struct device *dev)
-- 
2.49.0

