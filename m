Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB6218BC3B
	for <iommu@lists.linux.dev>; Wed,  2 Jul 2025 02:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751423845; cv=fail; b=uffdnjZZ/nfxoekReJwkmpWMkRYFVdm2wmE4Cm7z1OCqOjvPFaJSDlxdbjFwOtL9X7OHmj9XCIfLjEuhF7GTEmrXoylkM4PnRvFd11wc93tNcy/uKWdjAFcHcEH68vOuZuGayvknbEjEPE4eJZqKK8/tGOAvA+9a3hgIdSkKIm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751423845; c=relaxed/simple;
	bh=RHztQLax6JH1yH5bTjK/kFSSsVrsMNmRHNIrdqN0Fns=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=lmd/LFMIUXOVyQvEBMdjkSjaI+5gOePWsxR0Ij+Fq6ZFi4t2SlEnwydJl3vQipslOr4FKMIF/yOBdH9rUQidlfTN8hi+vBQC7VvuN0vEBROpWytET4fUHRoVXNxB7MjUT63lKKtz+K/TjLVCsqL3Pxnh0xnVo0sgme8iZXv4J5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U0JMM44a; arc=fail smtp.client-ip=40.107.237.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U0JMM44a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yAJFUM6ZktqhjUDT2BGcZ1ya4urrRiACgGKamIkd4NcwpqFWATqIA6KB/WvxtuCkfIfnXi/0pB+xXKR/dD61uaUJuh6k+AERC2W3kUz4t32k4FQ5h9rrOwfYfHjZsd8zUpRHbODkaLaHE/enhos1egPn6XdkNKU6HgO9stfxmsL9FTWDEgpzyiWPwK0xmRNYZJYMBxZRf2ZRzOrgYEuJrNeF8f76sEBGCAMK3diOnrCXXcXCcf0U0/rlUboVqMFOVobFhmCj3bEebUIIkCxg0tYv84GZrLqfoNzCKEMWnBCC/sncxHuG5APBQ4POih7EU4B82+NeHFO3Iq4p6AhNag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPaAWDd2infsYQ9GApnw3EpzgMGUP8T5V/D/vkyN0cQ=;
 b=w8IaZ9auSwa2oBV3fVho3ckW8B9udCOoUDAwjNML9u8VDMhanetxugGFQBSFPQ+4Z5eSiNCQBTusR5oHOAXA+VlWEo9p/ASPsd6oJAcs+efULBD3k5p8QG72HgRe0TjqjB3mv6UTmWyk5KluDEXpDCTnK9nE66NAIh2lN+tjS/w3Ikx+VOrekRwjnNvdk1Z4cLjKt2rnMhBSwLV5jZWdWcpaK6FRc6IyLmSJ1ESqN4W9xGEj+z6xuinqw7xqoDhEq+Cc3Z8mSdaF2up7iuaUvuxUOhk6uPIxfQ4kw5rAScvMABZXGU4scFUmRjwOrjpulM6WLY/D1vuAURFrWMnbsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPaAWDd2infsYQ9GApnw3EpzgMGUP8T5V/D/vkyN0cQ=;
 b=U0JMM44aPNph+d1aALRORBeG4ztRPo/iWEwMce4lydbJXgNAUID1qKIoVTAjrby2tftLGyVMLBp147c0bsVIV7BsSicTdiDQw1J7GjxwUcdC9SXkN0NuTLHIt1Yjs1CWPN0CPeXGyv7jxoyuHk9PRd93/M5uV1F/9FIDJalL4mLWw4Zcznf8pE5ZKnxr7WFUUgtMBAf8YCQhihoPHLaoCjS1sNMeWO9e9lX0PvOQhKs5u3CAE4CV10Tr7itAkRCrgVBhcMEgSL1X9sLG3NmG5RJdruDBfsvcmQ/iha52bP+RIkpNLrqaTWVxF1hbc58ddqfhYpfFOEh0oyM264Vjxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by SA1PR12MB7443.namprd12.prod.outlook.com (2603:10b6:806:2b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Wed, 2 Jul
 2025 02:37:20 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::d161:329:fdd3:e316]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::d161:329:fdd3:e316%7]) with mapi id 15.20.8880.026; Wed, 2 Jul 2025
 02:37:20 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 02 Jul 2025 11:37:15 +0900
Message-Id: <DB17XMDHU5M7.2M2KN9A8TJQOB@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>, <jgg@ziepe.ca>, <lyude@redhat.com>,
 <dakr@kernel.org>
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
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250626203247.816273-1-abdiel.janulgue@gmail.com>
 <20250626203247.816273-2-abdiel.janulgue@gmail.com>
 <DAZQ9OGC1648.2WWABTO7A7UU6@nvidia.com>
 <DAZVUN9N4GBT.38B6BX4CN516F@nvidia.com>
In-Reply-To: <DAZVUN9N4GBT.38B6BX4CN516F@nvidia.com>
X-ClientProxiedBy: TYAPR01CA0004.jpnprd01.prod.outlook.com (2603:1096:404::16)
 To MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|SA1PR12MB7443:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bb9a6c5-3650-4830-6f2b-08ddb9115d33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGpLSWdXdU9QRVhuM1Fsa1dhYzV6VDVOcHc4aXpiK2VxZUlIVU54bUh0M0kr?=
 =?utf-8?B?bERUSkZPTCtJSTlQRDBNTFZiYWJsMkE1U0xzbkpxQTFKdFRSRTJnaGtJYkYz?=
 =?utf-8?B?V2pGVzJUUU1IcjA3cEEybU1iNzA3NXVCa0FiaUVidForVFlKcDlkZzFTS0Qx?=
 =?utf-8?B?cjlMdGRvcHBBekhkY2FXK3cvVTBqMGYydmRmRFNlZTdZMTZLRnVna1RyK3R5?=
 =?utf-8?B?c25ndVJGY2tmT2krUS90Y2U4RVBuY3Mzb2dibVZhZVN0TmRoSVBka051QXpJ?=
 =?utf-8?B?WVBpZyt5MDhiZmxlazl3TGJUQnVoLzJCT3pWUjAyVHFyQUdaVFB3TWs2Nmxh?=
 =?utf-8?B?dmRDVm9wUXdoNnY2NGRCU3ZVakhlTm9kWHMwaGpGUEhjWnpHK0lQelpkNFN4?=
 =?utf-8?B?RGJIaUNiRVJ1OG1LUmpRR3ZFRDZIejJIeVYrREJmcWI5N1hwU2kxRFkxREtt?=
 =?utf-8?B?K2xNU0UrSE52MGVXYWdUeDVtU3JSR0M5QmRoYmJSK2FKRHpydXp3eENqVUNh?=
 =?utf-8?B?R3hWejFxMEV0ejZjNUdUZ3JFM0VMQzlTcGhPcXlROUZHMUROeXd2Mm9zbDhj?=
 =?utf-8?B?L3hrT2Z5M0k5UWFXZTk2WEZ1NGQzU2p4cnJnV0NUUEhRREJ2dzVxT1hMMkxn?=
 =?utf-8?B?MXFhOWFuOGpSSDVPNGQwK095QTlGMTBBN0xqQ1gwbThjeEJGbnNGOGVOanNh?=
 =?utf-8?B?TXRJenZVeWhucjJnZmpBeFEwcE55TEU1UG9uUFFCTUxYL0lVOEdyeTNaMjJp?=
 =?utf-8?B?V1JRTjZTWU5tK1E3b3ZmOWtub0NpYW1ZOWlpb3pNT1M1TllYZnBqU2d3R2U3?=
 =?utf-8?B?dloyZEx2Zzh5QUFXb3JSVzRWZE03aG1RS0RLcEp0TktnK1FPQlV6Q3BSekVy?=
 =?utf-8?B?RXFzS2ZpQXc0Sm9td0ZOSStjOXhROGcyOFlYUWc2VFVQRm5NMXpPa0tFYktP?=
 =?utf-8?B?QURJM3NWVHhaK0VBdWFaQWJMZ1dlUTY2L3VROTJjWCtyRWZ2T2ZkdXlpekNz?=
 =?utf-8?B?MDRiamZGT1I3anp6UXlCKy9ic0hldjBNOXhVSTdyS2hGa1E1bHM3ZTNrZkFV?=
 =?utf-8?B?NDFML2lFTVE4UzhocGhyeit0NGw4WEphN0JyWUZvSHovZENDeDRadXBYUHhq?=
 =?utf-8?B?UU56VDh5dUNpSytzbUZtYi9WUkFhdmJYRVNYcUxyUmhkTEZDdXoybUJNWHNk?=
 =?utf-8?B?VisvbG9GS1hpVVY1dksvY2ZVZWhvUk9YNlRGRGtQbVZkY2pudnlsU2tlcW9B?=
 =?utf-8?B?UjFWdm13eW9UVVpiZEFQbmdoTlJBVE9XWTk1NDdXYmpQMjhmbHhDNndqYzdN?=
 =?utf-8?B?OUJ1TDZyM3ZIUnBYOWJCeVRHM0JGYUg3L0FVR1BrMmpQRS9USUNkRzNPbTBh?=
 =?utf-8?B?WWlhdFNuMUNJMWwwbzk5WVRSbU9uRDJZOFRZdllaLzA0UUNROWMzQ3ZyNHFJ?=
 =?utf-8?B?TExHaFNLd2FiRzZ6SnVqOEs0VFBFNmR2M3pWQUZkMmU2ZzcvZnBla2taT1Rs?=
 =?utf-8?B?U2QyQ1kxbmFMV3lBckhLSDFZTjloZlNDNUFhUHUvdzVncXAwdGQ0T215Wllx?=
 =?utf-8?B?OWp2cnFWekxTeTRLTlgzRElyb1BoUS9FVlp2dXNGVFdxMmNwc3E1ak1qeG55?=
 =?utf-8?B?bjVYL2c4d091Y0x2ZUEwc3czc2VEQ2g0Ui8ySmYxSlg1b1Y0TFBqM2J3bXFi?=
 =?utf-8?B?WmpzZE1RVXlkeFVSWmFzL1grSUN3T0ROR0ZDbklsMXFNeDZTcm1pbFV2ZE81?=
 =?utf-8?B?K1VkMXhBSi9mcUNLdUhOQk0zZktBYUloN2IxNDVRNjVzM1FiVmRtbHd6K2wy?=
 =?utf-8?B?K0RSWE9ET2ZQYzVoUFdGYmV5RCtKTUNnTVRteEhyK0FIUUllbTQwUlB0SWNK?=
 =?utf-8?B?TWxvaFhRL3RDQnhGNGVZWTcrWVNXMTdnOVlZZWwzZ3VWb1puRzVJNEc3cUh2?=
 =?utf-8?Q?OUgIkmD/oQI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3997.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0dreXYrV2JKay96dWJhL2I5R2E3aDMrbnNVaElVMUEyUEw0UWd5aHUxWUFZ?=
 =?utf-8?B?eldaeEVXVEUyWFlET29qTlNJME81dHFESHJ4d0Y0QlArMmE1SGlWcUlDWDN2?=
 =?utf-8?B?NTk1Rjloby9yRnVnNlFjK2FFL2NJb3FhS1ZKaW1lWjZpMkdYaEpUUGFCMzVv?=
 =?utf-8?B?OGlhV1pEUmpvVEpmOU1LOUwyVVQ4dllZTnNTN3M4UUdRQ0t5aTJ1OGFVckN6?=
 =?utf-8?B?RGNLMkpsV0N3SFRidFhjdUVWbTd1dXh3OVpqYm1UUWxFSzhWSmdLcFpLRjUx?=
 =?utf-8?B?UmhaOHJkOUQrY3JKODA0MzJ5eUR5ckNiMGtnK3NIRytGbnQvU21VSFNyWjd6?=
 =?utf-8?B?d2pKa1Vsb1lzc25YRExUTHFIc2t3cHRsOCtwb3BIUzBEdUVTamw4OHF2ZFV1?=
 =?utf-8?B?QVNJZm0wMkZhZUNXRmVwWEd3SDVudFN3SE5xdzFmOWpQUkxULzdpOERRdldU?=
 =?utf-8?B?Y2F2Tklva3U4MzBvelkwMjFmcDA3NXoxdERBUE44cDJZbmliOUxkUG1TTUp1?=
 =?utf-8?B?Ymd6cjFBNXl5enVSczQ0OVpZS0FUaC9TSERsdFNVdGdjNEhUbSs5WnVuc2lo?=
 =?utf-8?B?VU4zTWpDcFozTFBwOFc4L3oySG5Hd3dIb29PaCtZelFIMmYxMVpjN0hxWGpm?=
 =?utf-8?B?ZENLZlB2SlVkSTFtdlVRTzIvbnFGRHRRZGRsSWk5K29Td0psanI2bmpuZzIr?=
 =?utf-8?B?c0tDSEFPOVM1Q0ptVGR3R1RxWDFKVFhXVkxPUW5IbGN4U2V4TjArLzJQSDZj?=
 =?utf-8?B?azE3SGd6M3ZXVGNnMHE4NS9TYlBHTW55QTB0K0ZVbW1TRkdtVUlRMVhaUFVh?=
 =?utf-8?B?WnhGQm1IUWlnMHlrakVNNDcyaHkzM3dIQm5TRWQ2MWpRTjZlbUNIQytqRThn?=
 =?utf-8?B?VmV4NkJYZG1XWExjV2Q1Z3pzSXRsRGVIc2pGTE45UDJHZUhsZm9XMytvZzlG?=
 =?utf-8?B?ZDFVNk55cXBrbm1XdlVmeHhYMlhJdEdkV2JaRHlqZXQyTXFQSDRMcFR2UGVj?=
 =?utf-8?B?UkpodkhTV25CNUY2Y0ZYdGhhKzBjdkNEUW1qSzlmKzh0MHNrTVlnTHN6NUNE?=
 =?utf-8?B?RG1NbFduU1dZOVREbWdKamFzZ0psVEkwZkk5Y1F3Nnl4OWxjUEJ2ZHo1M1R1?=
 =?utf-8?B?M3NHMDZ1UVdka3M3SUR1S2hQcXpkczBGVEMrL3MxVWZYakFXVjFuTjRxNGxZ?=
 =?utf-8?B?WkIyUVNhVWVFVytndEVCNExXUTlrcEZ6SzRqbTNiT20wYkVQUDBXRjl3KzlX?=
 =?utf-8?B?SDlFVnpCUUVpY3VBVWp4M3A5NzE5YTNRNThuUE1Db0tWQ0Vyem5ENitpS0U2?=
 =?utf-8?B?YjNqU1hUMTN6bUxjOUkrdFBiaUV3OUFzbU1NMGVvWUtjNmp4Q2h4YXVjRFVo?=
 =?utf-8?B?THN2c0FyQndCOXNnZDladGpwZTBTdzI0R1lqM2c2OExhTXhjVkxDUGFYZzBt?=
 =?utf-8?B?L3YvbmF2YW95bjhoc21JSnZTTnNpWkJwVmJhUTBaaFdwSTZ4aHpBeHZhN1E2?=
 =?utf-8?B?OGRYVkUzTjJDcFh1bFN0MUdDOHRlOG9rZjNTZnZjR3dLZk54Z3hnUVpuSFB4?=
 =?utf-8?B?KzZQTHlNUXlpQ2hSNjN1WGVEQU5PTVJEUTBhT1FaOFdvbUR5WCt4UWxtamxV?=
 =?utf-8?B?Zk8ycHhZVGZkQVJaSittbGlMc1ZUTHpGVlpLeUg5MFVoQUZ3K01PRFJYYjJC?=
 =?utf-8?B?SlplSEV3WDBqMENoT0orcUgwNHY4QlQ4eFNWNXZCRXhMOFhzcEs0MzA5Rmh4?=
 =?utf-8?B?Q1dSdnBGS1lySCtnSXd5WWZGRHRKN21COUlNQzRMdE4zQlF3MWJlN08zTnNN?=
 =?utf-8?B?di9tNkV2Z1VmVU9Nakpacjczby8rOWZOY2ZyV1FXZ1YyTjRFaFZ1NnNTRm9u?=
 =?utf-8?B?ajRjTjF4UWtlWGt1aEp4SERjbWZFbERuYzRvTktidGx5Wm1DNlBWV2kxYWJK?=
 =?utf-8?B?RngvL3l3b0FUeXRYbW1NWlB2dGczcGN4Q0ZsM0QxSDB1VjhnOWNGMWtDb2g5?=
 =?utf-8?B?cGxTdldkNHhkcXNxeGF6WlFLQVpjWFlzSUcxTWVDTk9sbWdmdXp5NE0yaDRv?=
 =?utf-8?B?UlVpLzdWbDRybGFwRHo4SXZGc1FJcXBGM09vMlhFZTl2Yk8rNHc3eW8xTi9Q?=
 =?utf-8?B?WUs0ZWdhdkwrMFUwK3hDdHBleUxpdUxhc2pMZmZqVDhQeVlyM0xHUWxteXpv?=
 =?utf-8?Q?ycmAEFyumcp92DO8yQP/TTm0cvznvvZv2aPhg4FlmCKW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb9a6c5-3650-4830-6f2b-08ddb9115d33
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 02:37:20.2920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WYFjca3QVUQJVp595NT9ppM0S6F2sgWZTrK0bDbgEqhW32IbawAcXXNbQ+ItPPM3z8vKvrH4ncGb9panAMRl8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7443

On Mon Jun 30, 2025 at 9:56 PM JST, Alexandre Courbot wrote:
> On Mon Jun 30, 2025 at 5:34 PM JST, Alexandre Courbot wrote:
>> I actually have some more comments, but I'd like to understasnd first
>> why you decided to drop the typestate. If there is no good reason, I
>> think I can provide a more detailed explanation about the design I had
>> in mind when thinking about Lyude's usecase - basically, a two-stages
>> typestate SGTable type where the first stage is unsafe, but the second
>> one leverages SGTablePages and is safe. But going into that explanation
>> now would be pointless if the typestate cannot be used for some reason.
>
> After thinking some more about it, I think I can verbalize better my
> expectations for this interface (and my problems with this version):
>
> Basically, I believe we should (and can) only need unsafe methods when
> using one of the constructors for a SG table. Once the SG table object
> is built, nothing in the interface should need to be unsafe, and we
> should have access to exactly the features that are safe to use
> according to the construction-time invariants. This implies that we have
> several constructors, and several types for SG tables - possibly
> typestates or completely distinct types as you did in this version.
>
> I wrote a bit of test code trying to match both the requirements of GEM
> SHMEM objects (work with an already-existing `sg_table`), and of owned
> SG tables ; and I *think* I got something that works by leveraging
> `Borrow`. Let me clean up my code after a good night of sleep and I'll
> try to elaborate a bit.

Alright, that was an interesting rabbit hole, but I think we're closing in.
Apologies, for this is a long post.

Let's first summarize the use-cases we want to support:

- The GEM use-case, where we need to work with `sg_tables` that already exi=
st
  and are owned by some existing entity. We want to "wrap" these into a Rus=
t
  type that provides methods that are always safe to call. In this case the
  Rust `SGTable` does not allocate or free the underlying `sg_table` ; thus
  it is primordial to ensure that it 1) doesn't outlive the `sg_table` and
  2) that the `sg_table` is not modified while we are using it. Let's call =
it
  the "borrowed" case.

- The Nova use-case, where we want to make an bit of memory (e.g. a `VVec`)
  available to a device. In this case, the Rust `SGTable` DOES own the
  `sg_table` and can even mutate it. However, it shall not outlive the
  backing memory, which must be pinned for as long as the `SGTable` exists.
  Let's call it the "owned" case.

For the borrowed case, there is not much choice but to use an `unsafe`
constructor, with the caller guaranteeing that the expected properties of t=
he
`sg_table` are respected. Conversely, the owned case can be built safely fo=
r
any type that provides an implementation of the `SGTablePages` trait (we ne=
ed
to find a more explicit name for this trait).

So, with this in mind, there are two dimensions around which a `SGTable` ca=
n be
built:

1. The ownership or not of the underlying `sg_table`,
2. Whether the `sg_table` is DMA-mapped or not.

For 1., the `Borrow` and `BorrowMut` traits have us covered. If we access t=
he
`sg_table` through them, we can support both the borrowed and owned scenari=
os.

For 2., a typestate can ensure that only methods that are valid for the giv=
en
mapped state of the `SGTable` are visible.

Which makes our `SGTable` look something like this:

  pub struct SGTable<T: Borrow<bindings::sg_table>, M: MappingState> {
      // Declared first so it is dropped first, as we want to unmap before
      // freeing the `sg_table` if we own it.
      mapping: M,
      table: T,
  }

With the mapping typestate being:

  pub trait MappingState {}

  // For sg_tables that are not mapped.
  pub struct Unmapped;
  impl MappingState for Unmapped {}

  // For sg_tables that are mapped, but not managed by us.
  pub struct BorrowedMapping;
  impl MappingState for BorrowedMapping {}

This lets us have constructors to cover the case where we want to wrap an
existing `sg_table`:

  impl<T> SGTable<T, Unmapped>
  where
      T: Borrow<bindings::sg_table>,
  {
      // Safety: 'r' must borrow a sg_table that is unmapped, and which
      // does not change as long as the returned object exists.
      pub unsafe fn new_unmapped(r: T) -> Self {
          Self {
              table: r,
              mapping: Unmapped,
          }
      }
  }

  impl<T> SGTable<T, BorrowedMapping>
  where
      T: Borrow<bindings::sg_table>,
  {
      // Safety: 'r' must borrow a sg_table that is DMA-mapped, and which
      // does not change as long as the returned object exists.
      pub unsafe fn new_mapped(r: T) -> Self {
          Self {
              table: r,
              mapping: BorrowedMapping,
          }
      }
  }

And this should be enough to cover the needs of GEM. Lyude mentioned buildi=
ng a
wrapper around a reference to a `sg_table`, which can be done as follows:

  // Obtain the reference from `gem_shmem_object` with the proper lifetime.
  let sg_table_ref: &bindings::sg_table =3D ...
  let sg_table =3D SGTable::new_mapped(sg_table_ref);

Here `SGTable` borrows a reference to `gem_shmem_object`, meaning it cannot
outlive it, and `gem_shmem_object` cannot be mutated for as long as we hold
that reference.

This also works to implement an equivalent of `OwnedSGTable`, if I understo=
od
it correctly:

  struct WrappedAref(ARef<gem::Object>);
  impl Borrow<bindings::sg_table> for WrapperARef ...

  // `self` is a `&gem::Object`.
  let wrapped_aref: WrapperAref =3D self.into();
  let sg_table =3D SGTable::new_mapped(wrapped_aref);

Here the fact that we are passing an `ARef` lets the GEM object's lifetime =
be
managed at runtime, just like `OwnedSGTable` does.

Now on to the Nova use-case. Here we want to allocate, manage, and eventual=
ly
free both the `struct sg_table` and its DMA mapping.

For the former, we can define a new struct that implements `Borrow` and tak=
es
care of freeing the `sg_table`:

  pub struct OwnedSgt<P: SGTablePages> {
        sgt: bindings::sg_table,
        pages: P,
  }

  impl<P> Drop for OwnedSgt<P>
    where
        P: SGTablePages,
  {
        fn drop(&mut self) {
          unsafe { bindings::sg_free_table(&mut self.sgt) };
      }
  }

  impl<P> Borrow<bindings::sg_table> for OwnedSgt<P>
    where
        P: SGTablePages,
  {
        fn borrow(&self) -> &bindings::sg_table {
          &self.sgt
      }
  }

This will be our first generic argument for `SGTable`. The mapping can then=
 be
handled similarly:

  pub struct ManagedMapping {
      dev: ARef<Device>,
      dir: DmaDataDirection,
      // This works because the `sgl` member of `struct sg_table` never mov=
es
      // after being allocated.
      sgl: *mut bindings::scatterlist,
      orig_nents: ffi::c_uint,
  }
  impl MappingState for ManagedMapping {}

  impl Drop for ManagedMapping {
      fn drop(&mut self) {
          unsafe {
              bindings::dma_unmap_sg_attrs(
                  self.dev.as_raw(),
                  self.sgl,
                  self.orig_nents as i32,
                  self.dir as i32,
                  0,
              )
          };
      }
  }

With this, and the `SGTablePages` trait, we can now provide a safe construc=
tor
for mapping existing memory into a device:

  impl<P: SGTablePages> SGTable<OwnedSgt<P>, ManagedMapping> {
        pub fn new_owned(pages: P, flags: kernel::alloc::Flags) -> Result<S=
elf> ...

The DMA mapping then remains in effect for as long as the returned object
lives.

You would then have `impl` blocks to provide the raw `sg_table` pointer as =
well
as DMA or CPU address iterators, made available or not depending on the map=
ping
typestate. And if the type borrowing the `sg_table` also implements
`BorrowMut`, we can even change the mapping state programmatically. I have
omitted it here for conciseness but have some code for this as well.

Although I remember a mention of the `Unmapped` state being unneeded in
discussion of the previous iteration - and indeed, so far both the GEM and =
Nova
use-cases do not really need it, so if that's confirmed we could remove the
`Unmapped` state and any kind of transition to simplify the interface.

Thoughts? If Abdiel is comfortable with this I can submit a v3 with this de=
sign
for review (putting myself as co-developer), on which Abdiel could then kee=
p
iterating, as I suspect this would be easier to understand than this long e=
mail
:).

