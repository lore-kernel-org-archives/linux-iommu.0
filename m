Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8343721ABCB
	for <iommu@lists.linux.dev>; Mon,  2 Jun 2025 12:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748868132; cv=fail; b=W2H3Z7JHCbfIma7U/cnXfH57JTPoDXKhuJUL33VmpKYpsSY+3tJfglAdtL9ctY+v+RAr+qx5og8zIlfv1TASRdxNdKCH+0hIUJ6aI4CVw+qOexrdPWZZ8oXSfIBtOl8n3c7aiI4Id6KXpUYnk/814ojf9/rvLuGdWL9CBgN1cxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748868132; c=relaxed/simple;
	bh=o19kDZ/5lbDOG+xQItLHswA5uCFHnp+HBrwO5NGS5Yg=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=RZLRve6NNDeyYptwfB0e0tVGvvCfSkoQYxaI6+LZMK7uOvrHZJpZ7aGqx+SZv2HpFt2rdckpAyBA3ELQd0jQYq2MP/UxHdvPJuNSR4JTmHtjuwFn+a3Poq8BUytS97m/GhoALhqc73AT2RRhT4bJFLCfOqDEDssW8DfTVWHScS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Zc8EOsfb; arc=fail smtp.client-ip=40.107.237.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Zc8EOsfb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tmxmPVHZwSeUouL9K5tfl3lUBZXmLMK/TAw+g6ubvdbB/mxrp4JaxNdLblbRSBOlPmDEwn2rmfMtT5fhBJNtntzaNj4ukrVT2F5Y+Z0DsEfGuq/qIHCJDyFdP9EYfnrUcpFgRyqGxqsfv//EuUeI7AODdGHs/uWw6fUBxwbrREACW8Q2xn4kh40Sh5xh7Us6+/IA6LeAXI/ctr37MNWEJ5pqk2GwODBmdoyDwHPRItMijqb72opQnw6I7mS0uAjsOoKaoiXMZWonCDfPaNo7wmEAG0vtLMBvCFx0sv+pwX11BRbF9j33ZU0WntKPZMYDJKGQbKz9CsMx96DcN2BxMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o19kDZ/5lbDOG+xQItLHswA5uCFHnp+HBrwO5NGS5Yg=;
 b=bcLJX2jtJxKI8tMHnwPrTei67zGP0kAMDm2UVXD1wtmck7JbHaWwJE9upQlCec00tFdwxADUJ4341oBYR6m2w6GjNPgmyt0L5UpMQzeQJrx5cGQXWfEV7hhE2aascab6YizXpzgMzwIarNjHjLc4kgej9TA38TdtEPZji31VXLrBZLlQ+jJLzcAWuXF8dIgt/pVDG9IRRzfjl+U7TAreE5nDeMf1xhiFYz5Zy/t4vYWafCj6ForKM1LeENn38slDqYuajzWJNdoEZ53L+5ZwVG3ALHihUw5VD7SXeQMrHI19qTBoQiR7TQi3OeSGqVs30HGUVxjG3nAL4+tq2wGj6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o19kDZ/5lbDOG+xQItLHswA5uCFHnp+HBrwO5NGS5Yg=;
 b=Zc8EOsfbNFtZNAc7ivwrVwgiadKE0bed1ivp9H2wfEPAXXVHsxQLb1aS98Qs7ypWb1Hcx0fMPYO4ZBut20PJ8OJ4TiRqbWn/F/C7cMMiyjaEAz2T0TsTrcKXS1L8zOIu1sDtA5gtc0NhQjfmXsrLPUIRRHPfp7K2Chm/KpqnANVTTrB8N616NRVhlMJNDMR629n2O0VbuFFLX3A8iCUu89+6AQhNtFly+6q+C8b1bMkbOnBdLKmlAtQgafQesTYJcvQv279rGT1llOyK1nxSLZujUgJ/X7WKCq4P2GnoAbAREGQ3NpcfxQZ2gEV1DwRwtdr0lEs4AUBjdYqs4jLPhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA1PR12MB8965.namprd12.prod.outlook.com (2603:10b6:806:38d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Mon, 2 Jun
 2025 12:42:05 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8769.037; Mon, 2 Jun 2025
 12:42:05 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Jun 2025 21:41:59 +0900
Message-Id: <DAC20AXGABW2.X147X4JPMRBS@nvidia.com>
Cc: "Abdiel Janulgue" <abdiel.janulgue@gmail.com>, <dakr@kernel.org>,
 <lyude@redhat.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
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
Subject: Re: [PATCH 1/2] rust: add initial scatterlist bindings
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Jason Gunthorpe" <jgg@ziepe.ca>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250528221525.1705117-1-abdiel.janulgue@gmail.com>
 <20250528221525.1705117-2-abdiel.janulgue@gmail.com>
 <20250529004550.GB192517@ziepe.ca> <DA9JTYA0EQU8.26M0ZX80FOBWY@nvidia.com>
 <20250530141419.GA292183@ziepe.ca> <DA9KQF9CY77R.77PBMU8Y1FPY@nvidia.com>
 <20250530145026.GB293473@ziepe.ca> <DAAD0NZOCHS5.9FTVJIOI12QI@nvidia.com>
 <20250602114047.GA298147@ziepe.ca>
In-Reply-To: <20250602114047.GA298147@ziepe.ca>
X-ClientProxiedBy: TY2PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:404:e2::21) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA1PR12MB8965:EE_
X-MS-Office365-Filtering-Correlation-Id: 101a0403-45a0-4d38-a120-08dda1d2e168
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGxjTmJEZjlGT0Q2ckR5OGZEVXB0a0ppM0hGa1QxNlJUZnNlaklFckc4WUJ2?=
 =?utf-8?B?WFFMQUVOQ3luS2t5bVBGQU5Wc2dJY29iL2E2Q1BWdHZDMlZ6Q1JreFdSNFFH?=
 =?utf-8?B?ZkRSZndRWXh2Vm1Oc2dQcHdPL1BCTE9lZDhXczVvUlRkcXZ5aGc1USt1K2Er?=
 =?utf-8?B?R1NxMHJGSWdHK2tpbUdwaUVpczBpTnFoYmpRS1BWNmJ5MmlVZlpJQS9QYTNG?=
 =?utf-8?B?ZUsvSUROY0hXZXJJcTdEYW5nSFJEYmJwTnhsRjg0L2ZwQm5TdloxWUxCWkFX?=
 =?utf-8?B?aFBybDVzYXdRelJEUktEZTdtazcrYUdoakt1cE40QnZxeWhZTHhIKzhSZjk1?=
 =?utf-8?B?ZmQ1WWhIYWdRMWtzcXFKaFUxZ1hzZDNhUDByOUtESzc2YTNmbzl2S0syWDBU?=
 =?utf-8?B?ZHFmN2NwQVlNbjkzcURjazlPcm5hcnFDa0hyOGxGTmwrUG45WjNuWURJSzk5?=
 =?utf-8?B?aWtuekdDWmNyaEJxOGVvU1QxOWRCc0JxdzMyZUNoaGdUeXBPTVpHdGxCZHBY?=
 =?utf-8?B?eHptR0I1NVJyTW5BdXQ4bndkNmswMVovWU1xbGtHNTczcSt1ZFZ5MjlQWHM4?=
 =?utf-8?B?Qkl2RDdIZWYvNjkvZVJkZVN0UmFJcU8ySEZSeXlWczY2MWtiM0tYWjVsb3M1?=
 =?utf-8?B?Q1ZNalI3ZmwzcXgrQjJkK2pwMXlFYXBXVU1CaHc0UDVzN1d4QUszUWFoR2t1?=
 =?utf-8?B?QlphTElDTk0zby9YTmcrT2phaG51dTRzd1lyU2hKYStNeTRMLzRIazdaT0pL?=
 =?utf-8?B?OGMxNndYS1FndnczMXhlb1dxbEJpVEdYRXV3V0c1Q0JwOHdBREpHdUM4bXlI?=
 =?utf-8?B?NGEvTWd5YU5jeUVYSzU0NjI4VUlJcThtcmUwQ3Q3MVZ5VjdIRU9mZ1ZNQnl2?=
 =?utf-8?B?MXozRjBpdFRmSlM1cDRSSlhnNWEvakFObFc3Uldpd1ZvdVNjUFlQU0N4OWxr?=
 =?utf-8?B?dHc3MUY4TlU2YVllY0pzZ1Fvc2JLZUV4d1NyV3R3U05saGlwRjJPdkM3SGNW?=
 =?utf-8?B?OFpnUmdrTTBDTDJEZGhQV3ZhbjVTQ1Bxb3lSTXhPNCtGS3h2TFZEZjZGZU9Q?=
 =?utf-8?B?TGtCeUxHYUxaUXJzYXhZNlFZYmtrQUJaWk9mYmZXWllqalZVSnlJUzQ2dklI?=
 =?utf-8?B?eHFwL3Rkb09LR2hodXNzZlJTZGJSYWl1VlZpMTAwUVl4MExhaUc3VXFsdkdB?=
 =?utf-8?B?S1l2bHNoNDBQS0g4aWp0TXcyWDJYZEtRRzZRRnlreStXTWUzaGtUMVVUT3Bh?=
 =?utf-8?B?OW91eXFnVkFDMnRqaWhHeS84ZTVtb3kzemNUaDVIRzd2eVQzV0Q2azN5UFdF?=
 =?utf-8?B?dHlDQlBKY2pFeVRDNHI1cWRXT1R4dUNmbkJKQWNBeHFLcmZWdWRhbzBLUms2?=
 =?utf-8?B?RUhGVStCdjFRb25yWExPWG5jQjloM28zSENIWDMrNnU0NGNMMW0waDdmaVZj?=
 =?utf-8?B?TmRkSU4yNit1UmZISmhCTU4yWElpZGJpNkFYandrcEx3M1lUTncyOXZlb3Y2?=
 =?utf-8?B?VTNXT3VITmtBMGNnQ1ZETFpjeksrZ1E4TGVBckdUQTE5MXJPNmxDdnBjR1Zq?=
 =?utf-8?B?V2xuclFWSWh0Rk5IbVZYT1grMlZkVURNT2ROSysxUy9UYkRpNnY2L3JFYlZP?=
 =?utf-8?B?SXZWaHY1UmozdDBrRWNMTThYR1RldXNHaVpnbjQvMW9SVDhMRFg1eEJxQTJC?=
 =?utf-8?B?eGVtWmcxRU5BMnJVLzhsR0FMdjRUQllpV0J6Uko4eThkOUt0RmVLMlExV3Qz?=
 =?utf-8?B?ODFFdTdGcTJzOGVZUklyRWdKekRTSWFjTm50S1pIYjNUeUozWVRTYXN2Um5y?=
 =?utf-8?B?alFCMHNZVVZ5NzJYalNuSTdSbnQ2bjd4RUhidXpBWG1RUEM1aVprTy9WZWRw?=
 =?utf-8?B?K3U5Nm9DUEJCckZVOUg4QVFrK01DWS9QTWgrYmxRaFJmcllTVzBlNEpkRDB3?=
 =?utf-8?Q?y0QR1bgdKAI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(10070799003)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTBjMFA2T0NKdHlWcXZXTTFDckFSWDlVMnV1ZnNuajhwUTltQ05sbDFiRGdI?=
 =?utf-8?B?cGpGRzZwSWl3QUxlQUN3Rmo1R09ickJyQ293amlnamsyZkdQRVNGT1lXZlAv?=
 =?utf-8?B?UlpnOHhNaEljVDhWMG0zN1F5c0ZnN0pYVnN0cVBUa2IxNnh5V3VJb0ZlbjR0?=
 =?utf-8?B?N2s0R0JVakFUTlRlUU9GM042QVNBQ2FKZ0VOeGhsckdJc1p3K3o2UisyWk5w?=
 =?utf-8?B?T1haekFLaXdSTHpaczlweEx5ZElZMGNpY1dTZmdKMzNxQUpCVVdpZkdqcENx?=
 =?utf-8?B?ZjBhTlpJbEN4cFZhcURwM0ZNU2QyQmJHeURYZDliTUNhMHR2TVNDQVlLUWoy?=
 =?utf-8?B?WU9icTRaSzlTVkhLU1VmclZZQ1VMTWxLbUZKYUFtNEJSdGdXLytmckpSRjU4?=
 =?utf-8?B?N0ZDVzFQUGg4Yy9Sdk1PaXU3cjZ6NkRsSWIwZy9NcEdTZWdRMmxxa1NnZXZx?=
 =?utf-8?B?azQ0Q243UU1zNHV2Q2ZKQ1I0VlZUM0ExNFJOMExOTVY2R3dqbVFTZG9qYTVE?=
 =?utf-8?B?SXBNb1FpSXFhVW1Wb0JJTmJvT1QxS05PcWNVN2RNZjZKekh5QTcrQ0RvVk9a?=
 =?utf-8?B?TFQ5MEdUeitrNHlPVy9TbndMZUJ0QTd0QW5rMmxqcjVyb2xYZ29mWW9XZVNN?=
 =?utf-8?B?aGE4cUhJYlh1Z05zRWh1RmRuSTlqNFBkZzUxY1NzQXEybG9od2hseHRtWE40?=
 =?utf-8?B?VnlOd015S0wzb00rVDNubmxDQ1RmVk9RMDlhekJHUWJRb3FpVHBpb1VrU09o?=
 =?utf-8?B?R05iaURidHkvT084TzU3TkVnMThMNU9CZDVBQ3lnZmJFcGpQd3Q2QWN2cStZ?=
 =?utf-8?B?bm53S251OExvVW5VMFh2RHFaQnFkMWtVZW1kdFRCL04rSzYvcFhRaDlGcXVh?=
 =?utf-8?B?dUdzeFZtUTJYQVdzcCtiTzhDSjZQQ0lqVzNERDBjZWxURE1TSGtOVTNaN2Vl?=
 =?utf-8?B?RE1DS2Y5UXMrelNXcTVYbWl3T1BERGp0bXg3dzRvc2dmSWNBWTZtd0sxcjgv?=
 =?utf-8?B?QkRzTHFFdmZyQXkyNFh6bmxJSHd1V1d5a1pHTEc2eW1XTGZmRjE1aldRVzRs?=
 =?utf-8?B?VkUreGJTTUdNUEZtTkhiWHNKQjhxMTZTSG5EcTdYQ1I4TVNwMGN2SE8wRjd5?=
 =?utf-8?B?NUlvS0JlaEtYMTdIUFphMkZ2UVczVXNiWUorZktUUEdveHd6TDZQL0ljQ1kr?=
 =?utf-8?B?TWQwelA2MzJQVGtmZDhZcHlBaGlHS08yaXEzMkZxMWZweml0akdFNVkvYVpB?=
 =?utf-8?B?VEpsRkFNd1IyQWd2TWZzZG5IdnV0ejlySEJvY1V1SUJoZ0hsSk54ZER6eGhY?=
 =?utf-8?B?UHBKWUg5YVBKNkRIcGpOVys2QnV5eDE4bFRwWU9aYmxIek53enUwSkgraUho?=
 =?utf-8?B?b0dmMFNtVHhYMkptQTEyazcrTU5pM1duU0FOSzNZRVlCb3o5Q0ZMUDhWU0t2?=
 =?utf-8?B?b2JGeXR4TUQ4eVF3bHRINW41T01LRDUyeFJ4WEtkdDFsbmwwWEpTOTlsblQ0?=
 =?utf-8?B?US9qVFVpUWRXZS9iQ21iZHRxNElJVU1ZS3MwMWcxcHFOK0FadDZ6NW4vaTJ2?=
 =?utf-8?B?dEsxejk1WFZyUTRKV2dvWkZBU2JNZlorTWoxaUdGZEkyWlhOdHRGUlBZWXI4?=
 =?utf-8?B?aDl2N1VIWmtiNm8xL1NDMU1xN1RSVXFNVm9hV2RCRERkYXpnV2xyYUxSQlZp?=
 =?utf-8?B?TXlMT3NLYTNoYm9saFRSWFdndms5K3doZEJnWWVTQ3FxRW85UENLbWJvUUwv?=
 =?utf-8?B?Smh2VUFSVjZ5c1k0bG41ekpBK1JNNHkxTVRHZHBOUXdrVEgweitvbGN0YWdq?=
 =?utf-8?B?dXIvZitBamt6ZDlSb3REczFFUmpINGxSZkc4ZGZWeEIxMWhsN1RZdjZ1RGw2?=
 =?utf-8?B?ek5KREkzNGx0bG5WZWl2WFZ4NXZPUm1RL1lWd3RkQis1VzNINWxaSHFQSGpH?=
 =?utf-8?B?NlNNb01VNVNzK09peW0wSU40SWJjaU95QjdRSHNmTkkyaGdpWWJvM0Y1U2s0?=
 =?utf-8?B?Z1dEK3RoSWFibzdPaTFBb2R6YWVPWjI4QmFkMEFic2pZQVNsR2hpRlBCZ3lH?=
 =?utf-8?B?RFl6V1ZRc1dneENPMEw5NjJSa2VVdE9Zc2RCR3Z1TWU5alY0d0FEaDhXbWho?=
 =?utf-8?B?NStPVy9aMStVZ05Pb3RPMTg1SHRLWC81MU5LOHBRSzA4djN4WUZ1Q3lrZFZK?=
 =?utf-8?Q?dfBCa9LflvnpQmoYxXqEQbExPpyVKwnDRNI4PTAKpUMC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 101a0403-45a0-4d38-a120-08dda1d2e168
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 12:42:05.4960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6f4hfunPWioM8QXJ0r0DCWGlI6lzhMZLYPL3+44B/cs4UvYbJySiNbX/V2/inau8SRdw4QT0WmoqlZTqrHQyNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8965

On Mon Jun 2, 2025 at 8:40 PM JST, Jason Gunthorpe wrote:
> On Sat, May 31, 2025 at 09:54:20PM +0900, Alexandre Courbot wrote:
>
>> So if I understood your idea correctly, this would mean creating the
>> SGTable and mapping it in one call, eschewing the typestate entirely?
>
> Probably no need for a type state

No need indeed, nice and simple.

>
>> And the `SGTable` would own the backing data, and only release it upon
>> destruction and unmapping?
>
> But I don't think you can do this, it is not allowed to pin kmalloc
> memory for instance so you have to do something as you showed to tie
> the lifetime to the kmalloc across the sgtable lifetime.

The caller would have to pass already-pinned memory. And to allow both
the owner and borrowed patterns we could leverage the `Borrow` trait I
think.
