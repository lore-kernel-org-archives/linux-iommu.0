Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551742367C5
	for <iommu@lists.linux.dev>; Sat, 31 May 2025 12:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748696068; cv=fail; b=iiDD/KfuYylApHtuw2QiJU9/A28QSfdjxkbxKcy0aG37d+8Itn3bTPTCodmUxBIosvaKd8j4MR/4r0fk+YkxSR40cmOh7jF/1J/sI5BYA5Qk228NqLUFSAt920ZVfALHkSZ+zV/Yh1Z6tXQc8kPpalo96TRVUefUoDCqwYN/GwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748696068; c=relaxed/simple;
	bh=dC9iaYOtgUahTmQXtqSKDRdMkbsI9hr+VHCloU/Avz0=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=Tjq/arVMkRxvW605g1cqwapRmz2b9guhSPfj51hIlRIxJ+pWXxa62dbc7gMwV0qH+c6ApWCkntcLwT94+Hza5xUaTi0M1XM0cJ5vt6YQq3VnrRXpQ4axBozfWuXz/iEihUEz9jiLk59YqyuGECOJiFNWz8DcauLh8xhumdGBcCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iuzipejc; arc=fail smtp.client-ip=40.107.93.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iuzipejc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b+iuPKVHkqERUufIFGV1o3DCEcY+OYT9O0bjkCLVKIZa6q7NVlRnUqlalCCSe/SpMLDXjfcKtwC9a6BSKRJuJjM7yX3gKYXVl2A2ndELcEc8nzOB1eDDslGSrTDkBRzP6zFKfvf+4TX75e16yq/DSj6L+Ez6cv2oVPRNDqTqM6t5u1FSx7WCwhwGQtWijhzRsnpZVomPhv2IyTmZTNCyzehE3guu92yvrZiFahMXv5Eh+XvEMIHlI6hev+1S26fqj4q4OQHZyPPvDsaG3AXUgWmUJIo8GJJHQaX8t1pkF96ZpRl5KyNkhYZt76eaCI87GtgzMA0V7k6gyKWjOscUsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dC9iaYOtgUahTmQXtqSKDRdMkbsI9hr+VHCloU/Avz0=;
 b=LukF0FwxOKfzt1CspIxUtPXVlVNMdppcIDO+Bq34/+3HoFyM/+ekyDLZxoQEEBLJrYxXbMGOBzOfWKbXbwl6zpN/HC55AthlX7U1+r6F6MB2YUXb0pFmqK6bTZa49oSbxHu9s4f/Cg2+viHShrRWh6/RgBYh/WIWCM0t0/6r8FgbmH5kFTa6td7xBW91POXULoLUZb6chhmd8lRpomTtp0aicc03NQQ6A5xdith31MbwTKqqG9RdYhrsiP9GPfSDVyHfpsKrOU7ILlPU85xZHT5J6ar9EDyy1eRrA/TVgFyClcU8qjTHFh/oVm1WaXUFY/hL1x5bocRcmUgMy4g/Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dC9iaYOtgUahTmQXtqSKDRdMkbsI9hr+VHCloU/Avz0=;
 b=iuzipejcPVQqeyM8sy9Ll0j6LrrjHgpWqoQwjoSfzAJcuAkF1UfkiYFGwOxfFJMXhj8jTriWHDR+tJqssXQx+Xy09GaE0fCo+fulpPlgo30vZjAr6gQK1lIDKOkmRIGIX5lwPhGAi2IdB5bKfe+bsKwsFJTKub7/iRC0OgnkFCY3BtJdx64pYiY5cNSRaGy+H6MmzeUvlgkkc4SCulqozspubWFW+UWoGYDO1Y8+ZhznUAXSmUR7znCEJ+TnwZDqDr420a8YVCO1kSga22nACSC9JWNL342UlTcRiWaylAFgu5bkpawI9f58ud5/Z78nS1wAO/bm+rM64qeDOs+uZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB8219.namprd12.prod.outlook.com (2603:10b6:8:de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Sat, 31 May
 2025 12:54:24 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%5]) with mapi id 15.20.8769.029; Sat, 31 May 2025
 12:54:24 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 31 May 2025 21:54:20 +0900
Message-Id: <DAAD0NZOCHS5.9FTVJIOI12QI@nvidia.com>
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
 <20250530145026.GB293473@ziepe.ca>
In-Reply-To: <20250530145026.GB293473@ziepe.ca>
X-ClientProxiedBy: TYAPR01CA0040.jpnprd01.prod.outlook.com
 (2603:1096:404:28::28) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB8219:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ce8dfd6-4858-4b8f-b162-08dda042449e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3FrbEh2TWk4OFFqdmVEbEJtcTRQdlBpR2Y2c0I4TExaOVIvQVY5c2VVTEFC?=
 =?utf-8?B?MTloam1aM2YrNE5ac08rY3FiT3RvZjQycFBUUG0xUzlrdDkzT2tyeWorNTAy?=
 =?utf-8?B?QXNmMlZ5UWlTTWZER0d1SW8yUWJBWkYvVWMybDh0TE5ITWM5UnNaWHEvUk5h?=
 =?utf-8?B?ZWFzd29JaUtqOGdGNk1RM0ZWbmtpSzF5MXB0djlYRXNoaW5ZWnErV2JxQ0NP?=
 =?utf-8?B?Vkk1ck5OaDM4VlJ1eVhITlpUbHptdmJrUFJpSFdPdUdMMHN4VDFIVWNDYkpN?=
 =?utf-8?B?cnJSekFzMll0VTlFSlZaN3FTUFBmeUs4Szd3MXNRK0tuM3M5SVZYS0ZuZWJn?=
 =?utf-8?B?K0tQT0xCb25ZTkxTK3lYVWZBQ3J0dmQ1dHVITTRLTTdBWkkrWHB4Y0R5MUtW?=
 =?utf-8?B?d1BRcmY5UWRlblUzcWZsYVpTcGtSMzVHajZxeDh1bzQ2MmhOell2eDlKRCtQ?=
 =?utf-8?B?Y1VHdjcvTFV4UTJSaDZ6QTJ1dW1zM0J6ZHU5WUFyYW1TWEx2L2M1YXF1UytD?=
 =?utf-8?B?ZWd2TlFwYzRRMTI3ZWZGa2E5OEZ5Q0UzWUE4OUxVYzV6VjJFalhiNEVLTHBU?=
 =?utf-8?B?b25HblhXaVJWSklRajdEcitTZHk4M0NFYnZBU24yL0FZZXV1UnMwbS9TYnFr?=
 =?utf-8?B?QWhoVmxEVDZ3Ly9Wdy9vbnNWRHpTZDc2Zksvd2t2ZDNzUHVJU3BVYmI3WkhX?=
 =?utf-8?B?Q0J0ejBwaXJoZXk4K0E1ZEd5U3VXUUdNeVlWSUhEa0JjYW9sdm5lVXNTWE9q?=
 =?utf-8?B?Zjk0Y3FEVklGaG9EQU5ycTE5bUZmY2NaNFhJMEZjU0tiRTdySjVnVUVaSEU0?=
 =?utf-8?B?d29KeUhqcDZhVXBydEhtNU1nZFhWTlFxN3p0RXhWdE0ydURXYmx1dmdLaXlU?=
 =?utf-8?B?SjhuOUJvMDhKRWo2OUFKY29KTHFSTkwzMFpsdTk2dTEyOUZaQnVyV3VoWTJ1?=
 =?utf-8?B?NHQwc2FMaW5kQ0VITFlwQmlGdlFFZDlmMC90YWRpT1dOaUErNXdHL2tvRWFG?=
 =?utf-8?B?WkxBUWpmaUNIK3psbTZZZ0EwRnZrLzQ5UTYwcEthYjNmNlVaMktIdEFzU2JZ?=
 =?utf-8?B?b2F3Z1NMNVAyVTJZaThKaEhuZjN0TldEOWJ0MUUzTjR0Z0d3ZU9KUTlCMDc4?=
 =?utf-8?B?cXNWcHh6RWVUeWxMWTE2ODc1S0hmOUovS1lyTndUcTVkWWFxT0xLQVpLYXRX?=
 =?utf-8?B?VmVteFFsNkpXMlliY2VHZWNSTGhVZG5sKzh5eFU0L3VsVDBhaW9hR2o5dWw4?=
 =?utf-8?B?R29SMjFMSjZWOGhqbHgwMU9paDF0eDhqOS9MNnJIWE9GZFliVWVkSVluRXFW?=
 =?utf-8?B?NlNnWXRWZzkzeDlQRjZSMTBkVVhhSmkrYWJOOVlyOVBSaDBiT2xPWlVpanBG?=
 =?utf-8?B?UTZqaWg1Z21LZDE0a0NZWDdaay8rUHZzb2ZXMWJ2bkFYUzA4eHVKcmE5QURo?=
 =?utf-8?B?ZTMrZVRTaFliam53NCtUcjU1NWYxMjRhdTU2OUJ0RnpjMzJLWnFvejFkNHhC?=
 =?utf-8?B?bEU0RTFSY0kxOUVJSExPZWNPWGI0WFNJSm5Db1dBWjFTVTg3NmNqRFZ2VzFv?=
 =?utf-8?B?UHRaUkVhTWhtSXVrdVRXT2FTMk5UZlB2K0tqNmNvZEljYStlUzRyK3lPSTVN?=
 =?utf-8?B?dnd1SGdxQ3JzWUdpbk55MEkrbjdXSHluUGxoNE9ha1Focm4ycytkeUlEbDAx?=
 =?utf-8?B?bWQ4VzdXTXVWVWVIMHJlekdRMDVPSk9keUJVSzNrTDFTTUE5bk02Zm9PUUhp?=
 =?utf-8?B?OHRRVm1xYlgvckVzMUtWK0VRRXlxbmMxSzZaMWphSWdNd1ppUlVDeUNhTTZv?=
 =?utf-8?B?MlJKMTh1VlZ3bmZ2TzBHYlhLR1lmR2hwcmMrN0twc3pXNnNQQ3lFVGpBZ2xB?=
 =?utf-8?B?MkdkYUFOUWtqUFJkWVQwaDlQS0lXSnptUTY5dWpwYmR2VWhWMm01bUM2UnBE?=
 =?utf-8?Q?u5i6TTPhC3w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWppZUJ5RGFydGpZV3cvRm9CVVNTRjl0QmZiVXlVVDIyRW5BZGhXdFJHY0Rh?=
 =?utf-8?B?NllkenozOFZ3OWowaWdUS1ljcm9mM215MDdHZEJhNE9oZ2lZdVJ1ajZPU0dq?=
 =?utf-8?B?QnJ1QnpqL2hvMDU4c0h2bFRCUzB1Y0crUDBQSGYvMS9RNENzSzRwQzNoaiti?=
 =?utf-8?B?bWVVNHRYdDNKdElGNlJtcGxTeHhldVJpTFhCQ2J6RWhySlJldXlJckxtOENV?=
 =?utf-8?B?QVphWkZKZEFnSy9mYTJhbFB6K1JpL1VpY1ZoYzFIbHRDbUJiV0dRNlNEV1Ni?=
 =?utf-8?B?cjhQZHZnbzV4b3hFS3gvMHA0VTJjNjI4RDlYYXY1RzFES2tZVEh2T1dZQXNa?=
 =?utf-8?B?ZnZyY083bzc3Y3ExbHF2S2pKUmdhK2FWY2doM1JjN0xVKzZkdnFIZXJMNzB2?=
 =?utf-8?B?MzNCKzNiSnRwY1RuVFE0TkN0T0RIc1V6czYzd3dSMmc5VmMwaEtFckVLYVNB?=
 =?utf-8?B?S0lwZVdTa3VCMEdXWnE4QmdNTU5GTGorMjFYZi82V003eVp5WnVxWUticU9U?=
 =?utf-8?B?MGZWL29ZNzVVS3lNY1I3bWRvUEtyU0ltM1l5WnJTRDUxM2M0MUFnb3pkNHEz?=
 =?utf-8?B?YU9tTU9jaTlzYlhhNzc0eUZFUHNDeURnZVhqa2FHQnRFUTY0NXR3VnoxRkwy?=
 =?utf-8?B?UTQ3dXpxUk5DWG8xT3hhYzlPR1ltMnRYeUtJczlucDJTbGxHQ2NuUzQ4d21S?=
 =?utf-8?B?MmNPL01iMTdZdjVXMjNtTFFROGVaNDdaS3RRNWdTRkQrMlc3eTRpUVBLRnRm?=
 =?utf-8?B?NVl2aGFrcUxuRG9BQjNLYlZURnhNb2R4YXVjUll4MkJtZjQyQ3pKVG4xUkVs?=
 =?utf-8?B?NmhTYlY2Z0ZRSk1IWkdxZ1NaR2twTlNKVGlRdy9KM2NScXRaWFNPdmpTd3lZ?=
 =?utf-8?B?WHErb1crVlh2V1BEVGlNRVdGRGZyaGVnazZsVzc3S2UrRE8zSVpJYUh2Y3Q1?=
 =?utf-8?B?a1paTFlBOGtDZjJCcldaODNlazU5L3c3L2N0YkErWjR5TXVJM3ZReEN4bXRj?=
 =?utf-8?B?VXNUeU1UUEFJYW9sMWtOamZzMC9hNGRIT3Z5TlpVQzNqN3FuazYvK1I1Nkdo?=
 =?utf-8?B?dmxvVnpMRzl1WEFyWEFOQnBsYTJrSG1CbkhEelViMXc3Yk5pV25rdjQ4cGhB?=
 =?utf-8?B?NGQ4a1JmWmt5bi9KVjYzMXhVM2txVGhuZ2VFb0hIblQ1M1ByVDBJeXc2L0hi?=
 =?utf-8?B?K3RCWVhZU2FjYWVCUENLY1VXRkZYUy9IQXJad1oyblNrT0h4aEszRjdBNmwv?=
 =?utf-8?B?cDNIay9LdU1QMUowNXQyUTlNekY4Y2VYVVN5K2ZsalpXUnBkTFJ6TFQrcm9l?=
 =?utf-8?B?UTNObHJzYWFFNHM1WWloZmhxeWczNXZnQjdwK2VadnlMVndYLzh1ZzFnM1Bk?=
 =?utf-8?B?U08zaDFnWlBnamdSSjJSSWtvMmpaL0hJT1EyTTJYTS9RL1ArSXI1ZkNDbG5D?=
 =?utf-8?B?MEdBS1I3U1R3U1o1WWdNUmlTYkpUSUo2VlFOOGNPNnV4bGdsUUNGYzE4N2g4?=
 =?utf-8?B?S2FGMDhZNjNFL2RqTXZyMHZ5RFFNcmlVWk1ZeUpIQjVSdlRaR2JQZ0RHMXR4?=
 =?utf-8?B?SXllODJnaG9jbk9QcnA4ZDk1STJjY3FyMXc2K0tIR0ZyOUloZXN0eno0NzZC?=
 =?utf-8?B?dDNQZVR4a3lCcEJHL2g2NnVFWjRNQ0tJWUlnWC9HV2NhQk1WYWdNQkJRcWxF?=
 =?utf-8?B?VkZYMytWNTZWOHYxdUNMTkZOa2gyUDMrNUhHemZPejJkOHMzNmkyaXRpN2V0?=
 =?utf-8?B?Y2dpdFZGUWVnME01a2pSaFpiYUhYVk1kTDBuY0tGV1FON2tDTEhtRURzcmlD?=
 =?utf-8?B?OXQzcS9wcDUyZ3R5eHJWYzFYTnVkMy9ia3N3ODF5M2svbmFNenhNOXVWTGU2?=
 =?utf-8?B?RHlESm9MTlB0RDhGQXdWMGJYd0lHckY5aEh5Y1VoTkx4S0YxSlRpT0pIZFd3?=
 =?utf-8?B?Zk9EMHpXSVhPT3V0U3dyYzFMbGZSZjczdzZDa3BYR0ZvMVdOaGkzTUFGWXkr?=
 =?utf-8?B?cTZWS3RkYmx5T0hBZ2FwVnFhVjlpVHg5ZFpOMkNVUFg5SWZPL3VPWWVwR0tw?=
 =?utf-8?B?SmZaQ0UrN2w3RUtZZGlON1h2OExzbGhsNGNtZVg1YXZLU1hGMlEzSzVsdFJt?=
 =?utf-8?B?aXZ0ZXBFYjFrNTRscm5Xd0hiZElYV1c5dnl5cUxadUcxTDdEWnNlbDZPLzBI?=
 =?utf-8?Q?SqgaDnjZ1PS3z4beEtr4BKZV6KNA5xWlRpFVxldPetNl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce8dfd6-4858-4b8f-b162-08dda042449e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2025 12:54:23.9496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YdWtojJdx96ekxukuZx53EAyX6CmxoptSFFYc4E24Bfst5YJ+n2cSUriN0tudTe0tae/CKQb4qQWfFwovg76qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8219

On Fri May 30, 2025 at 11:50 PM JST, Jason Gunthorpe wrote:
> On Fri, May 30, 2025 at 11:44:26PM +0900, Alexandre Courbot wrote:
>
>> I would be fully on board with a simpler design, definitely. The reason
>> why I've tried to keep some doors open is that as you mentioned
>> scatterlist is used in many different ways, and I am not familiar enough
>> with all these uses to draw a line and say "we will never ever need to
>> do that".
>
> I think it would be better to grow as needed. It is hard to speculate.
>
> We also have the new two step DMA API, so it may very well be the only
> use for this stuff is very simple mappings of VVec like things for
> DMA, and maybe this all gets rewritten to use the new DMA API and not
> scatterlist.
>
> Having a rust user facing API that allows for that would be a great
> thing.
>
> IOW I would maybe reframe the task here, it is not to create simple
> naive wrappers around scatterlist but to provide a nice rust API to go
> from VVec/etc to DMA mapping of that VVec/etc.

I like this focus on the practical instead of abstracting the C APIs as
closely as possible. Maybe we have been too focused on the tool rather
than the goal.

So if I understood your idea correctly, this would mean creating the
SGTable and mapping it in one call, eschewing the typestate entirely?
And the `SGTable` would own the backing data, and only release it upon
destruction and unmapping?

I guess the `SGTablePages` (or some renamed variant) would still be useful
to build the list and make sure the core types (e.g. `VVec`) are
ready-to-use with this new API.

One interesting thing to look at after a first version is available
would be a mechanism to ensure only one device (or only the CPU) can
access a buffer that has multiple mappings at any given time, with the
required synchronization performed transparently.

But for now I agree the simple use-case of single-device mapping is a
good way to get started.
