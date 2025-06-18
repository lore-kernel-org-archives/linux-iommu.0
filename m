Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291EEF9C1
	for <iommu@lists.linux.dev>; Wed, 18 Jun 2025 01:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750208636; cv=fail; b=KVOFmsvoVa4i2Xi1uMA1to7yLXmNOY//nSAzZ6wg7lW83SFJJNfqeUZtBQlbF/ZT+8X/0T271dz8LWr9a5Q6ndwQctkBrAmaa4149gTbwY7dw9cs62xA27LwTURY9AaxPhnr+1A44rGnEUzVcAICgfgUPDWqsJwLRRK035zCdmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750208636; c=relaxed/simple;
	bh=txOzhlk+4eeI95yZX+aHu9OP7NZYyMEVoiE9wLzTGDY=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=YvQ+gRQLoD2TTaZVUmZiwlAHIfBRwHHRTc+8ucM0fDB0PGHvMXyDXWnhU5CDNPvR0IdA5+YEf2G1lYK4wzvgv3h3DFWH04E6u7itdaffENwnCpYjcFAYtCI3wnn5RaXlceLuHbweI1Tq1E4ibxTl0eQNHQd87MzOJZti3i4+uQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ocCA6afw; arc=fail smtp.client-ip=40.107.237.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ocCA6afw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HksMkVNtr9odrvVD6herKzQwhBpr4BogMz9LPsYZduxaFF/bb51qaWLUWvI1lk+NTQYAOp/C7mgRbHcbfrDol6w1w3gJ3bD138tNCbUlYYuzKC4QWVOXD0DzNZDDAq6hzoM+JTJK3aAbr93a639YoNzQUpNZsQGba0q5/LxLL6w5KlrW0cFKiNiY0V1Qw5uj3OLJwzhy4UbbZqs4u3QeFDkiryIjICoF6mvyvIg3FbhXXcVB9arE1hY+TFlA5nEJg7flhrI076p9WRyyM90mXGkcYNC9mqftmXEtxEVgbDTNcsN2k2b7P7/QRPlNsyg7P4wuDQKvSjVlz1JrlcYE4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgMTgAI7fABnHHcikfFJgq8yFVlPcFL5YN+MMtYp40c=;
 b=uDNz0YaHcEAnL4aAtn32n1vXGkgORM2JCb57bjQ70oFMrlqrfRHJKLqAHYDYGxZ1W24kXPls2P61eGqjRQCXtr1ZRmzBFIc25Eg7yylP1H6KnXoqAsotxOC9as6lzsx4H7jlirXO9USJSSnIDnSQbAM+EqGKSj8hrjAgZ2GcK7i1UlUjyI7BldDh7bL132bulki05awS9jbDHXzD/n1et3xWb3JPo9i9JgfNzskEfFk9Q+epxRkwRgFP6D1ITGoM5xdHyc0HNZXQKz4z6q19QIah8QKDMg+CzR1/sBzCoLf5qLJyC8TlvqWP1NIyPYO98hbtAQMo5Wq/1AQpKCt1cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgMTgAI7fABnHHcikfFJgq8yFVlPcFL5YN+MMtYp40c=;
 b=ocCA6afwI1ou47OM4RXJ1zMMAM3e+WzEZid2vlGIJd4MIFNDV8Ig5aqpUy9AFMf048hwpacww757ff+MJ+VTSgEFn5kwPaFJicw4I65swHMVRovml8XRmt9RFx3gdMENvFzD3Kf4uuNKYRyU1oMfQiLeCqYL5IO7dad525jc9a5k6p6ZZIn5MYEGihhZgxzrVqKHYFpoeL+NO+QfSNj1T1GTJHxF7sO04Pnn8pQN7WikDdpk8zL2fvuOhAocmdmqUhqw3+LM3N4p8MEEXUwLoffDZtLx+PwToZPMiWhKn/KiiSYq2kqnaOv+2lrJ+45+fxF4zGLRQnAOSrpG1UbrYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB9151.namprd12.prod.outlook.com (2603:10b6:510:2e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Wed, 18 Jun
 2025 01:03:51 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 01:03:50 +0000
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Jun 2025 10:03:46 +0900
Message-Id: <DAP96FEJ0XWT.PWYMIE8IJAVQ@nvidia.com>
To: "Lyude Paul" <lyude@redhat.com>, "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>, "Jason Gunthorpe" <jgg@ziepe.ca>
Cc: <dakr@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
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
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250528221525.1705117-1-abdiel.janulgue@gmail.com>
 <20250528221525.1705117-2-abdiel.janulgue@gmail.com>
 <20250529004550.GB192517@ziepe.ca> <DA9JTYA0EQU8.26M0ZX80FOBWY@nvidia.com>
 <95ff963ddabf7c3cd2cfd07d0231a0073ff6847e.camel@redhat.com>
 <DAED5BUK7TUQ.4JRHFMWZ99W3@nvidia.com>
 <27e17dbf-df6a-48fc-a652-ad48a776f668@gmail.com>
 <DAENGORNRVZH.2KIGKFV5C5G3L@nvidia.com>
 <f787046921fd608c385dc5c559883c5d70839507.camel@redhat.com>
In-Reply-To: <f787046921fd608c385dc5c559883c5d70839507.camel@redhat.com>
X-ClientProxiedBy: TYCP286CA0046.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB9151:EE_
X-MS-Office365-Filtering-Correlation-Id: 304d5a10-6326-4fd9-c351-08ddae03fc83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmU5ZzZhQ2hKbStXalk0bEx6SDI2RUdxZWVSVXZBVVFWSGtxeXgzY3lxUFEv?=
 =?utf-8?B?Y0tZVGtRWlUwZE1QRkd1ZzhGdlVMTUQxUlp0OUZhV2gzT1p3VHhmU01xNXIx?=
 =?utf-8?B?VnB0dGR5VVFOS3p0WjNQenlhL2drdm56UWlKUi9mYVVvMzl5QVF1R3BiYkNl?=
 =?utf-8?B?SnZ6UmxLZGgxeDA4TlVNRVR5V1ByczVrN1VReUlhdGtzMFgrZzJqUndUN2Qr?=
 =?utf-8?B?TzRvM2JSQnRVTW02K0ZNMFhYMlc2ZFhobUxDOFBqVVlnMWhpQkpPQTdtdHli?=
 =?utf-8?B?VElvZERBWksvS0Y5ZEhGeXhsMlhIUGRKdDE4cWI2SFFDQzA1SzRkcms5WTd2?=
 =?utf-8?B?SUtZb0tvTUdjd2FESVFEL3I4enFjc01peXVBaGRBQVM0Z2FFZEFYSFk3aS95?=
 =?utf-8?B?ODZDNGY1RGE3aGo4WWxBUks4RDUvRUNmLzVzam5hR3VrMWZNeVpPaHJCVWpD?=
 =?utf-8?B?ZXhMNEJsVXdSV043VFdrL2E4aWVjeHBFMzgxMDcrZkVNWjE0NjJySnFBSmU1?=
 =?utf-8?B?U0g1OERWdVYydTI0d0NLeUdhcy9oTEZUSGF1UlNZNFordVY3bThNNFBCOXgx?=
 =?utf-8?B?aUd1dExzMVhwYlF1NU9Za3FyOHdzcE91UVJxdWNiaHdwTkx4RDdiSnA4QVk4?=
 =?utf-8?B?Yk5YSnFkQlFkWEhPSjJmeWhpZ0NhekNkWDFoaDNGRnJ0MWo4ZXgwNmFhamN4?=
 =?utf-8?B?QThlZDBldStacDFwQVF4VzB0TnFTTXY0T2ZBWHVRV3o2dUtOc1JJdG9pVk5p?=
 =?utf-8?B?aWhBV2t6Rk5FZ3FYUEVUekF3eHAzSkd1bUJSbGZTQng0bDRkYkZzWVBXeEtq?=
 =?utf-8?B?STBiS1RONEtMVnM4Ymx5L0FGTk1RVzh1WUY2TThLcGp0ZVVtbTA3YjBlMmNj?=
 =?utf-8?B?NVhHYVMzZDRyUU9XMlNxRGUyMjhaQTh0VUh3MjZKbUpEdUhwK2lkRGdTMDg4?=
 =?utf-8?B?anZYQWN3bUxzcjJtdWNFOWRvSnVWWGU2N2ZvSUZZREJKY2ptQ0MwMk05UHR3?=
 =?utf-8?B?K3lEVkVQMzN0bUlsUmhJM1NFaGV2WWFmNWRIWnhkVC9LN21tTzhqTWNZSHFR?=
 =?utf-8?B?eEZzcEZkRGVkYWVGMDFLL0RTMUJWVmhxZExxRHZ6ZysvaXNsT3F0VjhGZDV0?=
 =?utf-8?B?SkYrU2RnNDBIYUliZUo5QXovOUk3d2p2SW5EQXhzT1A3WjBVTjBvcUhtQmVO?=
 =?utf-8?B?TXNESUJ5WHBZQlRWMzUrcnFGNkV1NWlZNVp5YTFXNHNpcGxOMUJmem5uNkJF?=
 =?utf-8?B?eWd5Nld1eU9KbHZtekdwWktsUnNSZVArWmpiSVNrVFdFYjlCMEQyWk0yK2ZS?=
 =?utf-8?B?ZmJEMmVjU1FBSkxFVUJoWDkrRzFnTXozcTFGbHgyS1RIYnV3T0J1SThZdkY3?=
 =?utf-8?B?cW9XWDgwZUFiZFRvWTdiQ25FMjg1OGdPRkxEMWNFTVhCZTBybEh0bDE5ekxo?=
 =?utf-8?B?amhrQnM5djRZSURyM0x4UStiWmNFNDNtZnNaZnIzWk1zUnYzazUvYjBNdkpp?=
 =?utf-8?B?Z1diUUhraTBrek82aFBlMTkyVXpUQ2x3K3hDUWZBRTgrQmRtN1VCbGZIc2Vz?=
 =?utf-8?B?b21GVmkwemx3dG94SDhab1ZYV0JXSlY1WDkwUG15Z3BpUWxXSEQwakJIM21E?=
 =?utf-8?B?WTQrQm1HU1pMVmtleXd6dnF2WUt1SmRLVUpodHdTZ1pCVTg0Y0JvWUpyTFRK?=
 =?utf-8?B?K2dCMUMwcUxOa1hZMEJSc1BnWHNlY1VwM3g5UmI4ZUtMU215Y1paS2dtcnRJ?=
 =?utf-8?B?Yk8xQm1oK2xtNGFONmcyUjFFNndOQTNmWDB0clZIUUxwMGhzSDRjSytiVWFa?=
 =?utf-8?B?Q0lvSC9VVTZCNldBamhSU245T08xSy9CMEJoU1FBSVVKaEM3ZTZEYnFBVkFa?=
 =?utf-8?B?a1dwdXhLTDBtc1lZOEZydWZnTWxDSGVYRjNnR1hoVkhBTDZZTmNtTFpKRUVW?=
 =?utf-8?Q?VC0qrVQ+lEc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2RHS1laSXFFY1V5Vzh5ZWdTZXNUS1VHMEppRzlRTEJPOERKREM4ZHJoUlE3?=
 =?utf-8?B?Qi9TeHZCVEE3L2hybjNWRWUvanZMOG55SWNYVjJURkFNcFVLODVWQ0NjQmFz?=
 =?utf-8?B?NUZjdkkxOHY4ZVJMNm10M0FwanNMR0tjR0wrSFZsVHRiQWV5b1FWMHpuR0tz?=
 =?utf-8?B?em9qWk02U3AxalBWSzBHTE53OTY5VS9pTmpNR0JqMndwUmh2RmlYelBZKzh5?=
 =?utf-8?B?LzA2a2hsZVd4MlFzS1lmaXNkWFF0SmdmUk9pVVVXZUlVenhOalU2eFBvQjJr?=
 =?utf-8?B?eEFNZjVEd0RseXNSNU5tTVBJT25CUzRaUnZMWXN1aXVFTlY1MnRndTQwdWxj?=
 =?utf-8?B?VEg4MFhQeFpQVkIvYUZDQkh2SGZYTWQxKzNoNUh1ZWtqYzREOFFQNUdEVTZB?=
 =?utf-8?B?a1IwcVBPVldzZ3lpK0FpMmR1TC9HMFZCZjFoVjVIdThKSGtuUGV1a3VnbG9w?=
 =?utf-8?B?amJaRFJHV0lXa0pSVlBwamlzd2lyS1BBaDN2WE1LMG93T1ZRZE5Hdm1tdkM1?=
 =?utf-8?B?d2pmemNMNDNNQ1Evb3dXYjJsbXRuU3NTakx1Z0VmMitVaEo0S0FyWCsxRy9Q?=
 =?utf-8?B?NGR5ZzZteWUva01qOXpadXUrZktIRzlNS21sV2RpTXM4R1BvUkl4UFhmQndm?=
 =?utf-8?B?MFdrbmltOEdTS0ZuM3MyZW1YZ3dHNTlMdHpHcTFucnRKYmRyNldLZ1lEQ2dX?=
 =?utf-8?B?SDFQalpjL2JDTUFkZnRqRTZwR0QzNGtXS0p4SlFzRTF0ZU9QaHFOWHIzQnRp?=
 =?utf-8?B?alJlRFBTLzFUTGtQZ1J4MGhIeThnQ00yeW1wODlwV3MvbVY1QWtyRTVPNXdq?=
 =?utf-8?B?QTRCVmdYSzJ3K2JEc0F5MGtuWmNNMFZxWmM2VFA5UXdld25sY0xTZjIydXFx?=
 =?utf-8?B?VHdFMDhhYVdvREFXZ2MraXJxSDR2YUlYWlJ6ZThJUFd6QnhCUWhiU0lOWUdE?=
 =?utf-8?B?VW5SZVdFV1NqTVM0RlhDV2xBR2xwWi9hOFRMK2Mrc0pkZEU4SU9ucE5ydno5?=
 =?utf-8?B?QU5xMFhKVWxsVnpqOFNOWDJTMDhwdFplUlN3QkRSdkhXd3JPamw5VmR1V0h0?=
 =?utf-8?B?WnBaT3gzdUhuU2Z5NzAvSHpBRVo4YmpvcytCK3I1WWh4RFNEbGJmY1pIOU5x?=
 =?utf-8?B?YVJqSlN1aVQ2cHVnOERvTzJvVlpmZ2d6N2RIQm53djZwQ1ROc21jZ1EzV0NV?=
 =?utf-8?B?a0MvRnpvemlBRER6aUdqc1NFNFM1ZWc3WEZqMFd4OWVGS0daU0NYM01xcDBR?=
 =?utf-8?B?VHJjekptZVc2cFg2QTFIMmltVmZLSXcxWTNDL25OcGk0bFpFTXgxTktEb25L?=
 =?utf-8?B?TVMxOXoySk5MU1ZzNjZWZGNzQzZ0b0N5bTgyTm9rdU0xYUF4NkRQMy9pczVE?=
 =?utf-8?B?RHJpOFp3eFhCVVkrdGNMWEhFYVJldnJ6akRORFkrR2dlUVR3WlZmOFQrUXI1?=
 =?utf-8?B?QjJFcUQ4bUNDZ1FRbWRvQS8wdjdiMzU1Sis3RTFuZkQvbVAvektLOUFaMHBU?=
 =?utf-8?B?VmJHUTc5QTl2U0hkQUhQQ1VEOTFFdUhZT2JDeGxhM2hWNDVPbWdzKzZicGQz?=
 =?utf-8?B?N0d4UTVVOWF4N0FNNGpxK0pBeWY0bzh0VzFjVWpMYkloNVhCNSt2cHhSRnQv?=
 =?utf-8?B?S3IvQUxlanNac054WnJRdTRJM0cwZDRvTUNpYmRyK0hWWXRUOGlKVGl3VTBt?=
 =?utf-8?B?clJ1Sk9uRzhYM1ZLb0RId2JkTnpEWG5BODltakp3a3JCYkp6NzdDR3lQMjln?=
 =?utf-8?B?RE5RdCtJMzQ3V1BXQzNUMWNxTVZ4UkVXMlNPRDZENHcycGV6NUllalVhUWYx?=
 =?utf-8?B?VVU3TUNHSlBPYVliN3hVZFRkVUdwbWhDSlczMytoVGlRRlR6dXlaNDJ0TjY5?=
 =?utf-8?B?Q3VNa3pZMHJNa1luTjA1SlZDSXR3N1hBMXRnVGtlWGhHdVl6c09WMzMxN1BM?=
 =?utf-8?B?SVl4Z0ZCVUozbGFhMUNNMUJGSm03elVoeDYrc0lJZG1zVDdERVhEcTJkMENp?=
 =?utf-8?B?cUhNNFZEbDVmQ2ovNUMzWHFod1NtZWljb2dxL1FwdU42RDNTY1E4ZXBYeWJl?=
 =?utf-8?B?R0tRTjFDU3JJWVc3WWZCTjdWUFJENEk4aGJCOWlsM2xyUHBQZzFUaERjK0kx?=
 =?utf-8?B?UGF3LzdFbW1GU25FNkYzdFRNL1FNdjZiT0p2SkJrZGxkWTd2SUNxTGFhT1RM?=
 =?utf-8?Q?rLV5wTKs9fj7icIp0Q5px7GA1KKXhqWSUhy/tSizyMyw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 304d5a10-6326-4fd9-c351-08ddae03fc83
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 01:03:50.4776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gooqjEPRyg+iaE3yfsPARxHmgYLGQHaThepgoiNiU41K2SWnq5r07DqqEYklb1lPf1/wNhlGW14WkEC+8+1eug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9151

Hi Lyude, sorry for taking so long to come back to this!

On Tue Jun 10, 2025 at 2:44 AM JST, Lyude Paul wrote:
> On Thu, 2025-06-05 at 22:56 +0900, Alexandre Courbot wrote:
>> On Thu Jun 5, 2025 at 10:30 PM JST, Abdiel Janulgue wrote:
>> >=20
>> >=20
>> > On 05/06/2025 08:51, Alexandre Courbot wrote:
>> > > Maybe I need more context to understand your problem, but the point =
of
>> > > this design is precisely that it doesn't make any assumption about t=
he
>> > > memory layout - all `P` needs to do is provide the pages describing =
the
>> > > memory backing.
>> > >=20
>> > > Assuming that `_owner` here is the owner of the memory, couldn't you
>> > > flip your data layout and pass `_owner` (or rather a newtype wrappin=
g
>> > > it) to `SGTable`, thus removing the need for a custom type?
>> >=20
>> > I think what Lyude has in mind here (Lyude, correct me if I'm wrong) i=
s=20
>> > for cases where we need to have a rust SGTable instances for those=20
>> > struct sg_table that we didn't allocate ourselves for instance in the=
=20
>> > gem shmem bindings. So memory layout needs to match for
>> > #[repr(transparent)] to work
>>=20
>> Thanks, I think I am starting to understand and this is a problem
>> indeed. I should probably take a look at the DRM code to get my answers,
>> but IIUC in `OwnedSGTable`, `sg_table` is already provided by the C side
>> and is backed by `_owner`?
>
> Correct. You generally create a gem shmem object, and then you can call a
> function to ask gem to create an sg_table and hand it back to you. I shou=
ld
> note my priorities have shifted a bit from trying to get shmem bindings
> upstream, but currently it's still the best example I have of this usecas=
e.
>
> So, for gem shmem this means we can operate with an SGTable in two ways:
>
>  * gem_shmem_object.sg_table() -> Result<&kernel::scatterlist::SGTable>
>  * gem_shmem_object.owned_sg_table() ->
>    Result<kernel::drm::gem::shmem::OwnedSGTable<T: DriverObject>
>
> I'm going to call the first return type SGTable and the second one
> OwnedSGTable, just so I can type a bit less.
>
> The first, sg_table(), quite literally just calls drm_gem_shmem_get_pages=
_sgt
> which attempts to allocate the table and return a pointer to it on succes=
s. We
> then cast that to &SGTable and return it to the user. This can be good fo=
r

Mmm but if you cast the returned C pointer into a `&SGTable`, then who
owns (and is responsible for freeing) the `SGTable` it refers to? If the
pointer is just turned into a reference then this might leak the `struct
sg_table`.

> usecases where we might only want to look up the SGTable once or twice, a=
nd
> only need it for the duration of the & reference for the gem object. This=
 also
> skips needing to take a reference on the gem object as a result, so it's =
a bit
> cheaper.
>
> The second, owned_sg_table(), just calls .sg_table(), and then takes a
> reference to the gem object on success and returns both as an OwnedSGTabl=
e.
> This is for situations where we might be using the SGTable rather frequen=
tly,
> e.g. beyond the lifetime of the & reference to the gem object, and we wan=
t to
> avoid having to handle a fallible operation for initializing the sg_table=
 each
> time we use it. OwnedSGTable then just implements Deref<SGTable>, which l=
ets
> us use it pretty much identically to a raw SGTable.
>
> With all of this being said though, I think this means we really have two
> classes of operations around sg_table:
>
>    1. Operations that are reasonable to make available on anything that
>       provide a pointer to an sg_table, embedded or not. (iterating throu=
gh
>       pages immutably, checking the size of the table, etc.).
>    2. Operations that are context-specific. For example: manually assigni=
ng
>       pages would be context-specific since it relies on the context that
>       we're the ones creating and allocating the table from scratch.
>
> My reason for leaning towards having SGTable be a barebones wrapper that =
other
> types can embed or point to is because I think that for any interface tha=
t
> handles sg_table creation for the user, the most common class 2 behavior
> across these interfaces is what the SGTable's lifetime is actually tied t=
o and
> where it comes from. For all of these interfaces, `P` (like in your examp=
le)
> would be nearly identical implementations that just read from the embedde=
d
> sg_table anyhow. And we'd also have to have separate SGTable implementors=
 for
> each interface even if the majority of them don't introduce much/any
> specialized behavior. It's probably worth noting as well: if getting the
> SGTable from gem shmem wasn't fallible then I likely wouldn't have even a=
dded
> the OwnedSGTable type and simply stuck with an & reference to SGTable ins=
tead.

I guess what this highlights is that we need one additional layer
between the `SGTable` and the (now optional) `SGTablePages` trait.

The only way I can think of to satisfy your use-case is to have an
unsafe constructor for `SGTable` that takes an already-existing `struct
sg_table` and fully manages it. IMHO it should still store a second
parameter, which ensures that the backing memory of the passed `struct
sg_table` is still there and doesn't move. In your first case, this
second parameter could be a reference to `gem_shmem_object`; in the
second case, an `ARef`. It is the responsibility of the caller to ensure
that the second parameter is indeed tied to the lifetime of the pages
described by the `struct sg_table`.

Then on top of that, we would have a safe constructor for anything that
implements `SGTablePages`, so we can cover common use-cases like `VVec`
at ease. This trait would become a helper instead of being the only way
to create a `SGTable`.

WDYT? I don't think we can provide something that is safe to use without
also storing a "guarantor" for the backing memory of the `struct
sg_table`. And IIUC the casting of the C pointer into a Rust reference
means that there is no owner to eventually free the `struct sg_table` so
it cannot be done anyway - but please correct me if I misunderstood.

>
> I think that this design also doesn't prevent us from abstracting more co=
mplex
> behavior through traits anyway. If we had a DeviceSGTable and CpuSGTable,=
 both
> can easily embed a basic SGTable and then implement additional behavior l=
ike
> mutable iteration through pages either through a trait that each type
> implements or just through implementing such methods on the types themsel=
ves.
> And behavior in type 1 can just be exposed simply through implementing
> Deref<SGTable> again.
>
> Hopefully that makes sense? Let me know if I made any mistakes or need to
> clarify anything though :)

It makes a lot of sense and I clearly overlooked this case, so thank
you. I might still be missing a few details of your explanation, so
would appreciate if we can keep iterating until we reach something that
fully covers what you described. :)
