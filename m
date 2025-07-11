Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC00D1E1E1F
	for <iommu@lists.linux.dev>; Fri, 11 Jul 2025 07:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752217570; cv=fail; b=r+W0rURvSb3yn/QAAyuKRTnMM3+gua7IZQjrqFDW7dUawttFmSLbHBJLoxkT0xiLxLq3IMZPRRWknCaPPkscSZjnA/u7IS3xr1MqnFiHinJwb/tBTj8+JpGbVjV+Yn1EbPSS03gAFpzay9T2o9D78YjXM2AQ3AhqK1jd9ChLCqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752217570; c=relaxed/simple;
	bh=OzmsyhxwYZR/ok7r5QU79yUmou+WSWC51Vogwdzejco=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=Uumb82Htby9rkoU7fuvYbfnyXZ1DXzj6mKz66WjMEJ13D3pLyLhosLlRORbBx8su3R20gVxwjpo/hQBfhzVH1PFq23U2xdfL+bRhlevIq3FzjEPgsnBwwFOVL4phBNvcXAnMRAS4h0TFBKFsvcPsPDySxAtcZY1B89DmZ25eYoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jCBT/Qw5; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jCBT/Qw5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FlVt1s9oi76zU4gJ0O5IT71kkXAO/+9qy4lk1CAJdlooruWDDX4Ux11T2DGk9hPzKlUhaVNlSxTSgTQHNHcTtj7lTNI/guVn2uQJkiSIRgrfVqeVbm3w2PhWWhZdbKcLvvLItiGBjRCgWFN29Liu5sEiC7y0NfOg2pW+jnbMqXo+oqPMItReWBsc7IJa4oT6ALd7oj6+lXixXNtTjr3u2VH/CyZ/3MNMR+EELuTAabCzZdDZet6AhtU/HFgDpeaa7/MPkpAxE3yHbc0Cumfv6qcKuQvh7PQ60Wo1rGbVbicgytSMwT4EXKT01CBvbNslc+r5YSmZ+44XTbe34im1XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzmsyhxwYZR/ok7r5QU79yUmou+WSWC51Vogwdzejco=;
 b=o3p8JOZZF52Y8xHAFKWlqUzayR59E82IL32IIo5nn/vwQCdLOUCEaKDglM+jvsNDW7b/uXeiBuCFurT0qNEzhK6WE8yNzEGJCHhwJ28PK9akWb9WZfERqPxVr+KbZocjh4m+FHDIvdJP5yYY77zg4qfO+txqnF/lPXAt6um9+fk54aDLt8dVidbmQWtTW0+KetIR9qKubM3t+G1vyq+L2rpaLZObe4wOWTm6VuLfLoLqo56Qx9qpC4tI2kr71OennXyXKwEoYkpIRA+5NK+XILhsa0QF1jUak3DrGuxugd/rC6N6vVKuwsuRLYtNn/X8dt/xgbdI7VFi7i6PvPCSJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzmsyhxwYZR/ok7r5QU79yUmou+WSWC51Vogwdzejco=;
 b=jCBT/Qw5L3KBuxRb15YeA98CH8Od6KAOU/Zg7p5pQ8zzgw7JqyRfsgDtVxIrPeKVcbKcidr8N8qMZnEAE3z9waYpqmIre9cvDwPSDvAzbEM6Us2ECHwXT7v87pzyzg4Tn4pCc612ewvmJNklOgooifPt9su+Vq65aYjf0NEoKVSGHWdWirLCt8rFocX3GSNSJKyEaeYDLNPWBzoFRgOJMoNE+/jcMjCedHbi3+qEdkfHJp6z9t5FeK+9KOJ5Qmrv4BZ8NhXzwJ5gvSiL8q3MVSwbFn/8kRGkm2rW4Qzfpo4qAbSJCx9sRDRCrCtz2iLwkocWxgBp2S4bRYkgy2k9ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM6PR12MB4186.namprd12.prod.outlook.com (2603:10b6:5:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Fri, 11 Jul
 2025 07:06:05 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8901.021; Fri, 11 Jul 2025
 07:06:05 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Jul 2025 16:05:59 +0900
Message-Id: <DB91AA9OBJLO.34HG554WY12GX@nvidia.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Valentin Obst"
 <kernel@valentinobst.de>, "open list" <linux-kernel@vger.kernel.org>,
 "Marek Szyprowski" <m.szyprowski@samsung.com>, "Robin Murphy"
 <robin.murphy@arm.com>, <airlied@redhat.com>,
 <rust-for-linux@vger.kernel.org>, "open list:DMA MAPPING HELPERS"
 <iommu@lists.linux.dev>, "Petr Tesarik" <petr@tesarici.cz>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Herbert Xu" <herbert@gondor.apana.org.au>,
 "Sui Jingfeng" <sui.jingfeng@linux.dev>, "Randy Dunlap"
 <rdunlap@infradead.org>, "Michael Kelley" <mhklinux@outlook.com>
Subject: Re: [PATCH v2 1/2] rust: add initial scatterlist bindings
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Abdiel Janulgue" <abdiel.janulgue@gmail.com>, <jgg@ziepe.ca>,
 <lyude@redhat.com>, <dakr@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250626203247.816273-1-abdiel.janulgue@gmail.com>
 <20250626203247.816273-2-abdiel.janulgue@gmail.com>
 <DAZQ9OGC1648.2WWABTO7A7UU6@nvidia.com>
 <DAZVUN9N4GBT.38B6BX4CN516F@nvidia.com>
 <DB17XMDHU5M7.2M2KN9A8TJQOB@nvidia.com>
 <DB288AEQSBTC.63WK79TB77TW@nvidia.com>
 <0206a7fa-ce7f-46af-8f1d-f9dedbb0a3d8@gmail.com>
In-Reply-To: <0206a7fa-ce7f-46af-8f1d-f9dedbb0a3d8@gmail.com>
X-ClientProxiedBy: TYWP286CA0003.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::22) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM6PR12MB4186:EE_
X-MS-Office365-Filtering-Correlation-Id: d6641db2-19a7-4299-9588-08ddc04966be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUZ4Kzl6R0gyd2JZUlJSZmt0YUVLZlVMcU1MV1E3OUFsTHF4U3EyKzc0R2Vv?=
 =?utf-8?B?VmlwSzIrVGNWWEwzYWExUEZOMHovRVRXRkl2K2ZEMVlORHRyYkNWVS9ZK2VU?=
 =?utf-8?B?azYvMTE0aS9EbmZkaXRBSUNVamNzcW91WmhjRWpGd1Q1WmwvblFyeTd3Mlkw?=
 =?utf-8?B?cUVKeWhKTkRtTFRFcU1hMEZTMTBjc1drTmZIajN6RnExNXV2Nlcva1ArNW81?=
 =?utf-8?B?b2xla2pPSFdaWVVtWW53VzV1OUhEMTJnTElrMk1nMlhPL1RnQnBLVXlOUHNh?=
 =?utf-8?B?ejByMExOVjN6dHRrenhRK3c2TFdCMmNPNXVXQ2xCL1pZbXhKT3dqcGdQeUZx?=
 =?utf-8?B?bTFMOXdYN0hPR2hHRzhybysyMml3VW1Ca21QTjE0aUJLa2pwTXRpOWZPeE1w?=
 =?utf-8?B?Nk1adnNrdEVuVVUwZ3V1Z0VLYW56ZUpqVE5FMG8zRGcrUUsrblVLS1psY3Nx?=
 =?utf-8?B?UWJ6WFlLeHNyMU0rUE1BeE9ualc0NEZ2dnhtVHpXeTIxc28yRDg3MVhScFFS?=
 =?utf-8?B?dnhYT0dyM0dIb0ZpYUlhODlBdXR2MnROZUp0NXh0Q2hMSzJhRE1YQnJXd3FK?=
 =?utf-8?B?aTMvU0x1aGhWa2RsTUlVZEw4V3J1Y2NLMHR0Nlk0dVpHeHc3L1F0MzUvb25k?=
 =?utf-8?B?d1dqQXhYbXlhZ1dyMm14WHEvbXhSeEZFNVFPNzBRZ2o0cTRJU2lSWnlRKzFZ?=
 =?utf-8?B?SER3bTdMZHIvdWNnbFRscUhqNU9QNXo3TlFaM21jTWQ5VWJTOHU4Q2J2elll?=
 =?utf-8?B?WE5uNGNaQitJandRVFdDNDdkcG5mK0RZaGkyQVJ3VEJHMThpM1owTzhNd00r?=
 =?utf-8?B?OHJhUlBOZG9Bd3FsQTlkTjBhMFJ5VzgwR3Z3c2NwRmJQMDYyRStTSll5U0hl?=
 =?utf-8?B?TkVZajQvdmV1T2I3VXpGd3U1Z09MVldSZ2hzRWd2aVF6Nlpmc0ZEV1dncXhu?=
 =?utf-8?B?QnJvM3JWV2FDV2x0elp5TVdFMXA5U21FVWZGek1EZUZ4dHdvek8zL09STE4z?=
 =?utf-8?B?Nk9JQlFOaFNncVlTaFB6dlE5ODlDZWZkcjlGcWxUUXRLNE1JTEt0M2hlWjdi?=
 =?utf-8?B?ei93WHF4ZS9qejhPSGFKRk5lS04zL01ucm5hSnRubjN4UTNoU0g3T0liMGkr?=
 =?utf-8?B?eGp1RHk0TEltcUFKd1YwOEs2NytVTnB3YkNZMVAwWERCTHJESkdFWHU0L1Bl?=
 =?utf-8?B?ZFp3VXB3Z3pCVnB2Rjdmell6cWZFUXZYOG9XUng0N2RNWVUxVkp5ZjJmMFhS?=
 =?utf-8?B?S2xIMVNuS1JwUnY2Q1Y1SFV2TTNpcVo4L0hqVmg5NlYyV1VXcDlLcDFUb09V?=
 =?utf-8?B?a0RPcGxFMzA4ZzB2ZC9NZlluTTRyRU92WmYxZ0pxRnhrTGllR1NaSkVXdjJR?=
 =?utf-8?B?MmpuUmpjeDMvdTZaZTU5ZHYvdU1iS1JSS2RNVjJxUTY0RGVubG51d1BFckhY?=
 =?utf-8?B?R0JMbVpnUE5IRGNmTmRKRDhSaEpRSkQ0Y1BCQWZ6dlBDNzVXU0NFT0hQNnRW?=
 =?utf-8?B?TFNMWWtLVTNnT3l4Qi9lSU1XTVpUS2Z6R0s0bmpDOC9BY0JxSjdiRkxFWHJQ?=
 =?utf-8?B?VVJVMjNhSk1uc0pNOGpKaHFwTHc5UHlKTFQzL0I0WHhsLzBjS0JaVys3Tjl1?=
 =?utf-8?B?bE9XUkd6cHUyZDNoRmdLRlVBTGpnZElHNTBKTFNyUE95WDlQcHh0UzZIU0s2?=
 =?utf-8?B?TkJOY3R4UHljZ1BrczVsb1RteFhCcER6SUo2aGs4MDdrVTNDR1N2TEh0WFhs?=
 =?utf-8?B?dnBuMk5EMXo5VkxoMzRLWG5CV1p2TyszMUZpUmtjeFR4dmtVaUI3RjlUd0ZU?=
 =?utf-8?B?NWtrQndVUjJWeTBseFgwUllTSGJvRFUwOWNHS0RSOUl3U3pnZlAwLzlETm1K?=
 =?utf-8?B?SzJoSlZ3U2JqQkI3Z2pSdk1LaGtla21LS3h1Y05DdGxraGtxeTZkUzJhZUZ4?=
 =?utf-8?Q?3nagjIQ++dw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTBLWVZVYzd1VDdvQjdUWnN0QWZsUkJ1ZzhGUnJyZit4Q2dBK1VnRkhJQ1Ez?=
 =?utf-8?B?NjkwR3JjTHVSQnIwVFRWU3pJSEZCd1NaSVlOd2MvUGc2aHZ0U0NSdjlHNkNZ?=
 =?utf-8?B?RWo3djFmT25Nem1zVU92clk4dlh2ZVMvbUJRQ3NUbkpDeW5pRkUyYkwvVXZC?=
 =?utf-8?B?S2tWU3VFdElDamJoeDRLaHFqTTlFeDRWcjR4U1dNSGFlTlNKR1pXeG9WelI2?=
 =?utf-8?B?T1lkcStib3ZqeWFPWDFyWE9sVVMraWZhNzBXUkVjMm1GT1phMnhMNFRTc1lO?=
 =?utf-8?B?L01YNXFpVmhRZUdmTGZjYlVRYTNHVll6ZndiK2l5czdETEtBb29NRjZ5WFhw?=
 =?utf-8?B?YjJvZHFoa2k4L0lTWHlvY0FNVXJTMVFZczZDOTBhNXpra005aVpTbWN5eFVS?=
 =?utf-8?B?MmZkNktOb0tVS3N5aUcrRWRGcnJJVUlsVTJtVkVOUyt4RDFBRFhEYVJlYU1J?=
 =?utf-8?B?RWQ5WWFMUWFBMXZORmpUcDM0azlYR0JLMU9ZVGJjd3FpZWxETjRSUTV4dTFi?=
 =?utf-8?B?QytUMWUxa0JTYW5NQ2NNOUJMTStDTVZTWG85elMwOVI5V3dxaDQxVjNsU0JD?=
 =?utf-8?B?UENHaDFiZG9CK2srOFNmNjk4TnY4dEU0YkRRdTNnSmx5bHNOenZqWE93YTdX?=
 =?utf-8?B?TlJ1QU1oREZRaDhXWTNMc0VVTFZXSU5rUWlBYWtHWkMxRVNoRC84YjlDSHBQ?=
 =?utf-8?B?ZnNPMUErZmFGWE9lSHNHaWNCeXVPVzNkT293c2ZFcEFJSkxKNTg2T0hrenhI?=
 =?utf-8?B?ZmZSUGN0TWtBL3dWa3FhZmswSmNsdThncVYrNDY0OEpkQnNhODhtQkZtUnlr?=
 =?utf-8?B?UmVaMmJGR1dnYk1NZFhRYWQxTFVnSExHbVlRcE5VWFBGZnkvc0grTk1WcTNE?=
 =?utf-8?B?aWtVR0h3cFFPMVppdGRoa2xFKzV6ZlpsV1c2V0tsakhtRVdrcy9obGJ0ZUxN?=
 =?utf-8?B?ZUVvTjNadElyRG5jOEw3NlVDTG03aDdsYTZ5VkxpWUtnMTZ1K3JkMkhlYVZ5?=
 =?utf-8?B?b0ZXY0NDY2VrWDdGejdNVXdlQlMwc2RJWFBHbkZtNW5TaGNFUzdvMDBqRnAv?=
 =?utf-8?B?RW03TEZoS1ZPdTJwZ3RpVDhvU2NUTHd2MkV2cTVIUUhycjg4UmJuem5hc3dj?=
 =?utf-8?B?NjRXVDFyYmY3Ym1EZnZTbE5yWXNvMHAveG5tMHljdmVoY3BBaUJlMW1CWTVn?=
 =?utf-8?B?SmVjV1NqQ2dxUGh6VWp2b2U1SjZZRzgxbkFHZGVqMVBsNExETzUyRGdhL3d5?=
 =?utf-8?B?Z3NJZC9SbmF1bWhVR1lRY2o4dkFScHNkYmxTazROZWRFT2pIamFHNWNpWThI?=
 =?utf-8?B?cVhDMmNnQ3pDNVRaSWpmRFlSNjQxZXltNUF4K2tNYmVzZTJxbUkzeWRpTDZy?=
 =?utf-8?B?ZGRWRWVVeTVnUFRTbkxCOUdYM3BlYU40OGdxRnk5Z1BNTEtSdnpzMHJwMmV6?=
 =?utf-8?B?NjJWN0VUeHhHMU1NRUIyTE1ua1dPTXZ5OXpkMnczNFR4QjBLbDJXQUF1cUZz?=
 =?utf-8?B?QS9ncllUSWVvZ1BVMkw2Y0dVTnVVVUJXcDJYNlpTVVRsS21ScnJnTVNONURj?=
 =?utf-8?B?Q2NJd3NXbjRocXpYcUVVS0wzeml3SG9zKzBOUE9VMXJTeVdvaFMwRjdJZzdI?=
 =?utf-8?B?d0FxNlU5cmlGYTlZQ2lYYXUxbkRONkxqNTJQTmxhSzlIRGZ0UzEzaUExa1NG?=
 =?utf-8?B?bU1mOG1ON1ZUSHNpT2JpUHZZNjEyN0QwbitTVXdGUElhek9MNEpSYUlPeWZq?=
 =?utf-8?B?bnJ1Mmg4eG5JanowRUhOMlZ0S1J4alBZRDBUM2cycXBOQ3RSTjJjNFM5YzRR?=
 =?utf-8?B?bHFkckIyTU9ISldFYmpmV0UyeDRHS2VxZzRpdWFvTFpYM0dpWnlEdzllaWFJ?=
 =?utf-8?B?OG1TSmdKdkJ0czVXZm1IeTg5aGxaQUtabi9nNTRoRjh3bmlXMGU0RTUyQXc5?=
 =?utf-8?B?UlhsTXFMVFJHMEZocHRuc1U5RFlUc2ZVTmh5eWF4RXJNV0xacHhYZVRFWTN4?=
 =?utf-8?B?aEpjVXcvd3RQZEV1YmhkbXkxb2k1eWx4TCtudEFDN1BhTElyQnJVVE5mazI2?=
 =?utf-8?B?a2FmSEI3ZTdtZ3VXR3VDQ0RJUnlyRVFSQzNiNDFxa01kbUNWajN5SXZ4am9z?=
 =?utf-8?B?cGh4MzRVSlFMTjRudlpGT2FSUG84UkVjY2JRYTRzd1J5aXZwVmNOQzlzTHJk?=
 =?utf-8?Q?4btU6KgQVuj+1zcaPTaT2s2/Dgw79Dd1WrB0sO0Wuqm9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6641db2-19a7-4299-9588-08ddc04966be
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 07:06:05.2722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JRRWKxZkKn3lIq3EI95WWZMpB3v+dUKo80/R3yZIRhLZn4hRgTqePuSYAtkFhe4n1swn4WkgmcCmK73ijqRqRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4186

Hi Abdiel,

On Wed Jul 9, 2025 at 8:59 PM JST, Abdiel Janulgue wrote:
> Hi,
>
> On 03/07/2025 10:03, Alexandre Courbot wrote:
>> On Wed Jul 2, 2025 at 11:37 AM JST, Alexandre Courbot wrote:
>>> Thoughts? If Abdiel is comfortable with this I can submit a v3 with thi=
s design
>>> for review (putting myself as co-developer), on which Abdiel could then=
 keep
>>> iterating, as I suspect this would be easier to understand than this lo=
ng email
>>> :).
>>=20
>> Figured I could just as well share the code with you and save both of us
>> some time. ^_^;
>>=20
>> The top commit of this branch contains the proposal discussed:
>>=20
>> https://github.com/Gnurou/linux/tree/scatterlists
>>=20
>> The sample code has been updated to add dummy examples for the 3
>> use-cases discussed (reference to an existing `sg_table`, refcounted
>> reference, and owned data).
>>=20
>> There are still things missing, including the typestate on `SGEntry`, as
>> it wasn't necessary to demonstrate the basic idea.
>>=20
>> Note also that if we decide to only support DMA-mapped SG-entries, we
>> can remove a bunch of code, including the one that maps a `SGTable` if
>> the backing type implements `BorrowMut`.
>>=20
>> For your consideration. :) Please feel free to take and use anything you
>> find useful.
>
> Sorry for the delay, just came back from a week vacation.

Welcome back!

>
> Regarding your question regarding why I dropped type-state, I thought=20
> the general consensus here is to drop this approach:
>
> https://lore.kernel.org/lkml/DAC20AXGABW2.X147X4JPMRBS@nvidia.com/
>
> I think I might have misunderstood after re-reading it now. What you=20
> probably meant was to have no intermediate state from initialized to=20
> mapped to create the sg_table?

Sorry, that was poorly phrased - and yes this is what I meant. Since we
have no use for unmapped SG tables at the moment, let's start with this
simple and working approach. We can always add more states/stuff later
if the need arises.

>
> Anyways, thanks for the code above I'll look into this in detail and=20
> pick bits to integrate into v3 :)

Looking forward to it! Please don't hesitate to reach out if anything is
unclear.
