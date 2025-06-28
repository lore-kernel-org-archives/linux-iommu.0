Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF4B238D54
	for <iommu@lists.linux.dev>; Sat, 28 Jun 2025 11:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751109492; cv=fail; b=LITj8nL4dF68bDF9zNrv8NC9zWZthkUo179cvWaWkmIxnKBD4GVHUruHnJwE+Y0qHSMBEUfZMpmIk0dJwOw33elggaS+WT7InP1JDaoW7J9OS5w+Gev6wn/41h5/s4lGGitURWlzp8wVYT+M/aaFTgQf5auW6G/z7pSLXI2/LYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751109492; c=relaxed/simple;
	bh=B7cHN3BGFn64WLkY7Yuq3bF5zQAkgKDQ1pkv0HGUaJ8=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=bIjBPvAzp1RfqFRCcn9PEPhuk50wKzfZZQf473EHWxzs2hoTHb8KqTs0C5QW3/PzeX4ce3kRZROM1EhLkMKLzSGpxaP5bhjNe75aCw+a1IzEmUdQOoVVE/fAqnwW6DNxMe3pd3yY//pQspmcf15seOLEieBYabUy/o+FrkPt64c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IBKz2Bx8; arc=fail smtp.client-ip=40.107.237.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IBKz2Bx8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hJ2Q1fEzh91+nENZqA26IwHyUnw3OxEiMwVuf9oPeKfR8sKpCfYCsnPM53z0EBLIyYMAHg3+8LKIr4vFbaowhBld6Jwip9ah7QDMr4e+yCHw/KDRFNVzcDEctCpMLpMHj4yt30JphmVzcEGQ565D4tz8TRMb3JxoHTRqLTzQ+AfAbdmfT+WgbyPHsRbezdp2TK8S1AkGxbkjch/8169umgPTw9yZ4qy8rX3VwMbP1nBe/5bebxK5dF2kODmhCUcnu0aGyYNhoOSJN+azK6tOi0u2jxqC0iLzd41Z9u9WScSQ5DvEUbP0Cpe5K5tvfe8H1L//Zocgu53oaCNdTRnbBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/dYjLOBEImwPLZE/d8jCJfqdqI9R7YMf57pBk7ALZc=;
 b=U64x397s/dZXBJCPPIe1lAh5ybbaGop2RuIFxkSdcB3Q/ISigXzojUUnv0J9jJObroUzQeIdeTZwoS2X3/7abhm8Ak/8KwGtWkbMTHQz+OJlsEDjOuDryX6F1P15/t/DUDng7TF3yb0WKT2RPRHbcjWwyq3vYfX9Q6cwjz0s4XurLM/FCfDt2a3MoxJo4BGsNIzel2o+G6eY1mNMR++nCFYmlNSyEPzdfgLSavz/1jEVmEpQKxZjJb7zIHuCCha2vE/HAILrN4wqQiP3aIPlRCE8j9xcaqR3zo5mbelDnHSKNmRPgGHrbj+/YS+PUyuRPR2bqWywpcUAXX2zpXzW2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/dYjLOBEImwPLZE/d8jCJfqdqI9R7YMf57pBk7ALZc=;
 b=IBKz2Bx86nFJExM1fUFAebBVloIVTCVF7zOSP5Ic8cKA4Bhbu8SoooHNWlnHsjX7HLmRSrECz5SIIbXJV9peUCXKQM7sL881NhmR9KsEZEj2TMWERpRzrebuL0Ty0AIX/SfrJyBNPOg+DJX30TXvwgqw0u4LvSJL6u1mTFxSrEuYeB9bWwKnHRaCOZ7gVFl8OEfWEf2QPWGkbnSQIf5NAawpcrTBpfRZGMeMuCNIUKT5xmJkYgqHU9mScZcxOM/Gz/YPAz+TRePQ1L3mhqDnGABxS7u0jAzDboaDhDnUeAQ/QIY4DEHOK8cmb3rPSXZY3mAoPXLnc9R/qVOUWBjJ8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH8PR12MB7159.namprd12.prod.outlook.com (2603:10b6:510:229::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.42; Sat, 28 Jun
 2025 11:18:04 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8880.021; Sat, 28 Jun 2025
 11:18:04 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 28 Jun 2025 20:18:00 +0900
Message-Id: <DAY4I5PUNEHR.3UBD2WCPS1ZBV@nvidia.com>
Cc: <dakr@kernel.org>, <lyude@redhat.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <benno.lossin@proton.me>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Valentin Obst" <kernel@valentinobst.de>, "open list"
 <linux-kernel@vger.kernel.org>, "Marek Szyprowski"
 <m.szyprowski@samsung.com>, "Robin Murphy" <robin.murphy@arm.com>,
 <airlied@redhat.com>, <rust-for-linux@vger.kernel.org>, "open list:DMA
 MAPPING HELPERS" <iommu@lists.linux.dev>, "Petr Tesarik"
 <petr@tesarici.cz>, "Andrew Morton" <akpm@linux-foundation.org>, "Herbert
 Xu" <herbert@gondor.apana.org.au>, "Sui Jingfeng" <sui.jingfeng@linux.dev>,
 "Randy Dunlap" <rdunlap@infradead.org>, "Michael Kelley"
 <mhklinux@outlook.com>
Subject: Re: [PATCH 1/2] rust: add initial scatterlist bindings
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Abdiel Janulgue" <abdiel.janulgue@gmail.com>, "Jason Gunthorpe"
 <jgg@ziepe.ca>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250528221525.1705117-1-abdiel.janulgue@gmail.com>
 <20250528221525.1705117-2-abdiel.janulgue@gmail.com>
 <20250529004550.GB192517@ziepe.ca> <DA9JTYA0EQU8.26M0ZX80FOBWY@nvidia.com>
 <5c72682a-ede9-4a48-a214-f1795115816b@gmail.com>
In-Reply-To: <5c72682a-ede9-4a48-a214-f1795115816b@gmail.com>
X-ClientProxiedBy: TYCP301CA0042.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH8PR12MB7159:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fe97840-7e7e-4090-94b0-08ddb63572e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zjc4TlUva01JWHJ1MXhGMlJHcFFiTTNLVnZBWmoxT1NicU9tWkt5NWhDamI1?=
 =?utf-8?B?RHZuSWJOTjBvTTRZa3lxanFySUlyVzhvaE1zMk53bDQydDlyWXB6SVEvRk9X?=
 =?utf-8?B?bG0yejlteVVUdk1jcXJQRnNHQ2tEcGtmSzhJRDh4MlNxQ3RvWVpiK1lBWkdD?=
 =?utf-8?B?emlVNjB5d2lqUE8wU2ZaWUg5TXpnOVVXVFdwbTZlMjJVRDZVdGdoNC85RWZp?=
 =?utf-8?B?aUFoR09xNEFEYzVLa096azJJdnBIeVpFTnlnWVVqK2RYQzBESE53NS9PV3pQ?=
 =?utf-8?B?T0g0MzJ4c1pnUmR0WVcydEVhQVhmYi8xemxVM2c0ZDFOSGZ4SFozdmZMbVlS?=
 =?utf-8?B?TnlXaU16ZXdDbzJhVEpqbUNjQ2E3eUpWamhBWGs0NDNXNkxMWiswRHpxaW1Z?=
 =?utf-8?B?ZzYrbExSOGJSWW5zSmE3dG4rYVJnTXZsdHRQWWRyb0tnU3RBQ0JoR3EvZHBD?=
 =?utf-8?B?Ky9EUlYwR2Z2bFp3VnJ5L1BsZHlNZE51VHQ4NDlDUU4rR0tEVGczN09iSjQ0?=
 =?utf-8?B?cWFaOUw1aGZNWWoxaHBaRTk3WkI1QTB1dGh0NndZVTQwNmFkQ1BzUzNhZFN2?=
 =?utf-8?B?dTMvT2lrOEluTW0yNXZKazZSaE9iWVl3TGplNXdCQWl2RzF0RFh1NmJnOVds?=
 =?utf-8?B?SE9uNFB1YTJIQzZCN2hTblZOeHZScmVZWXNvZElNQkZoUTIrNjFPQ0RTMVY1?=
 =?utf-8?B?Z0poOEM5TXFEbkdJVlRBMkw2QXpJKytkakF4c245V09RNlBPRm84Sm4xSVp4?=
 =?utf-8?B?dE5hOUlHelhZZi8xK0xyNllzajFpZE5Xa0VQNnVxYmp1bkdkRjBpd202L3o3?=
 =?utf-8?B?NFFHcEhiRUhWbE9FS0lxL0l0WDhKTVJRRDNLUFB5L0VRQk1MU0QwZldkczhz?=
 =?utf-8?B?N1ZKZFJGNk0yR0U4U0tvNUlTR3JDNUwzVjUwQXVlREwzSklSRTZ2QnpzMkpY?=
 =?utf-8?B?TEM2cHRlLzlsZmJHUjVOMEdvYTlwcy9IRnU2R0drOXJuWnNYWnkvQ1BxSElS?=
 =?utf-8?B?OUhWclg0OTAzNXBKUFZQdTYydjJ5RTNXa1JCM3JIUzZnM1l3TTB3dTZ6dHJp?=
 =?utf-8?B?WDBrWFo4UXFxeFQzb2t2LzlKNHJIVjd4bm5EUHcvamIzNmV6TEUvdG9DYytv?=
 =?utf-8?B?SHhKTlJ4M3B6WFlPRTkveDVBZHRzUkM0cGdUMndjYzNhK0ZOVmxXQ0F1TE9n?=
 =?utf-8?B?UDEvSFUyam5XMHpJYzFXUndja01zWXI0REVZRndwQTlhbTBMbUdrNWJ1OTZt?=
 =?utf-8?B?NUl3Sy9wcThoUWJFbHA3ZGJsVUtYZHpnbFVqc1VHWXlQbVNJVGtVeDZzaVBm?=
 =?utf-8?B?MXZ1Z0ZudnRSUTRRUnNQUVVyRHJhQVRxLzZoUGppQzQ3ekNIMllnbFFiaC9Z?=
 =?utf-8?B?cC9DTnFlZ0lMSWRXaWE5QkdqOXVhMW5mN0ZXc2dYNFJpQytNeFJyOUZsa3Bl?=
 =?utf-8?B?QWMxZWtTQkpsSGFNN0hFejV5V1dQdW5SZFRjaktUVTNYNDBYOTJ6TE1lQWtS?=
 =?utf-8?B?VGtjeXlKM3dRUElZbmpuTjkvcmpKSTNoYlhRNUNMc3RhK0lKZTJhT3YyMTVK?=
 =?utf-8?B?MWZPM1M1d1NxNk5tRWpmdlJFNzNOTWk1M0Z0Yk9NVitXNS9xWFV2by9KMVpR?=
 =?utf-8?B?ZGF4d2NTd1FSeWI3aTVMZTdMV0ZrTGJmYmVsekdydStqdTBzNEU4ck5ZdzAr?=
 =?utf-8?B?THBkcGNGMjJhODdwZ0RIZ3QzVndDU2gwMTZNcTg5NGFWTDZKbVFUMGdncExo?=
 =?utf-8?B?L21CanBBTGprcGVPV29hbUtiUzBGUU12cDNIQytCdm5mOUtEZ1RpRlF5YlA0?=
 =?utf-8?B?ckRQWGNaWFVCSEpqVUpNOGltc0JiMm13LzI4VVJwWFFyR2tMbFZMUHBucktk?=
 =?utf-8?B?UlVNVjkrQzlBTVhpUWhlRGl0RnNEdVgvdWZ3bXpPWnNwek4rTHJnVHVzWCtI?=
 =?utf-8?Q?45pZtB0ZWKs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZisyUXFacGt2bGlUUGkwd0FlaDZla2hPdnJaUjVDckRYUk9lM0lESHFIY0Qv?=
 =?utf-8?B?Qm1zdlJHTEVSaUpxb1FHY01LVFgvMXhsbVV1cTVIVWJtMFdJUHJVaW5FSGZR?=
 =?utf-8?B?VE5tZCtXUjVqbTBUamJDbTVVS2RUM0VmRU43eVErRmJncXdUdThnOUdOVzlF?=
 =?utf-8?B?ejh1RUFuNW9BWnNEU0l1TXR1QXpNTThNTHNXem4xRTdrMmplc1o2TE52a1Vh?=
 =?utf-8?B?VDZVckpqaXVDdzZsMWtwN2tvQmJLSjRYb0lsSnpuMGh5bXRmbm9qTURRbHNQ?=
 =?utf-8?B?Um50QUdLcGtMbEp0SjMyMGtUcmFYUGxlTmtpd2FmdlRpVU52aWVvY3BvR0Nz?=
 =?utf-8?B?d2dpNG1peUF5ZEpQaEkxazAyN1VqVG16WUFiLyttbVZBdUJrREFyOUQ1TjFN?=
 =?utf-8?B?c2c1NXpKU1JrajExTmdyQVhObVZTZjdKZnlYdHdYd052MStBb3U2NWI0Mm9p?=
 =?utf-8?B?ZExGRmNab2dHY2pDY0twNHcyZ2dXOWFPNmIxVGlCL2lqT1V4YSs0Nldic21C?=
 =?utf-8?B?WXVNOHFuNUtURHlWM1JnN0ltRGlaQWIyZW5mbUpOeXpxMW04QjZZaUpyZGpC?=
 =?utf-8?B?WUJFK28xcHByZExoaStWOWtLVlU2VXh6bnVNcyt4ZVJKRnc3OGl4SGdQeEVF?=
 =?utf-8?B?cDY3VDY1cEhldG5pR3NmeXFjQ3c1T3I1WjB3QnE4QW9STVk2N1k1VVBNemxD?=
 =?utf-8?B?akU0WmIwVnNHRU5NTGhvbFpubUNrMFJEQlhXZzRoUXNxQlhVTFVQTmZtcWNE?=
 =?utf-8?B?cjFFZ04xZExGanNwVVA5a2cvSmNLNEdjYWk2dzhDVG5FY2xLSlRxWnFVOFk4?=
 =?utf-8?B?MGhVanh5c21vNVRjalVtNDFneE9XamhjMEdlVHNWU2drd014bXY3ZEJkNnVt?=
 =?utf-8?B?c1JlWWpGbWh5ekRsV3U2enB5djU2aXhZdnJRRThMcUl0VjRUYlZGb2VCME9y?=
 =?utf-8?B?TDFZRDVKNC8zaE9hMFNpNkxnTE01aGM5K1dVZVFBTHYyMmpIQTlTZjJHSi9l?=
 =?utf-8?B?QnZNdG9VUExlK1o0L2ZyUmtUUUxvNjlHTFJsNVRBVlFMaE9mbVU5SGdvMEE5?=
 =?utf-8?B?djJ6ejE3ZWR0M1NzUHo1MGdGenVqSm5jTWlxTWZVZU0xU0pxVmk0d1lmQTh6?=
 =?utf-8?B?bTUxeWFzekhJajJkVXJZaTVQV015YU1NVWNqL3NzQ0hxaGxZRlcrUUxSQ0VB?=
 =?utf-8?B?cjBGeWIxSUlUTWczOUdDU05GUUNFS0pDakN4bmxKTlFVRkxIT0hPR2s2TDFn?=
 =?utf-8?B?M1JscFRwTVlEb2Q4c0hjQmtheWJpYUxXalY5VTNhY0F1aUp4WUR6L3Q0Rko3?=
 =?utf-8?B?MjRJMGRxY0NpZUdURnhzTklaWEp6YkN0enNUWkRNM3hMaXkxclRmTjFNeC9o?=
 =?utf-8?B?U1dmNjQ2SzZ6TEZSVTZmZkE5OUJxREJMd2hjUEZtd09GUlByTmxsTDI2L1RM?=
 =?utf-8?B?Njdkeks1ZTFtdFM0dEVWeUZBMlB4TWliWkNYajQyS3ZSYTBZT1FiZFRENlc2?=
 =?utf-8?B?OFE1bktoMTFYQVpQaGhJUjJjbXN0TWx6aTd0OVh5YU9UMzBhVU1WWmo2V3Jl?=
 =?utf-8?B?dTAzV0MvUXh0c1g0OGlJaGltUjhwQ2tqYy9ScFUxWEJQS3dKaHIvaklVa25q?=
 =?utf-8?B?c2dLYWRkSEVpOGJXTjQ0aDlDbXQxVUpGQ0tCVjI3WUhpT3NPOHkvN3lER1Qw?=
 =?utf-8?B?bWZLd0l6Z1kvc2g5aVA1S2dQZThKdElicm5UU3EwblE3RjkxOW83R2w2NE1N?=
 =?utf-8?B?Z0drL0Uvclh2NmdTMGRUWmVrSG5EUm9WY1I2Z3FUKzFMYkJwR0Urbnk1MlZm?=
 =?utf-8?B?SnVZVjdFd1JGa0NPREs4NnUwazdKZ2JXT0NmMGZHdEtJelN6ZEFiRExPdjMv?=
 =?utf-8?B?VlF1QXlkREFyNVp1Ym1NRkpaZ3hyMW9ya0U2eUVjTG5CMXdXZWV1aFJtRE4v?=
 =?utf-8?B?Um1mbENDL3oxekp4d1VOQ2V4cVd1Vm1OMXllQ05qU3BFalQxa1dFMVpVTHY0?=
 =?utf-8?B?NTIxVVAwK1ZRT3o3N2dlTFVpNHgvOXNpZEdiOStHREhuODZjV0tXM2ZveitH?=
 =?utf-8?B?S0kxaWJtRGtoclE3djJLOVRNdFJNZG83YUFrblBobFNmQ0RTZVB2Rk1ROTVS?=
 =?utf-8?B?S2FxZS9PVlduVGljSHNDMlkvL2kwNjBGMEMrWERaVHdBd0xuTGxxcUw5SnEy?=
 =?utf-8?Q?BLkaXWApevPjliQ3LAYHdFpqb0mmIyXq/1iqnQpqS2k2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe97840-7e7e-4090-94b0-08ddb63572e8
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2025 11:18:04.2885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2t0L1UB4Pa3i2feqcDkxu9DYfnWIfFSjAV9Q0+eb0cYssQjwEB1w5q5idQ5xawlBZ6GYnrS27U1OIdxyMoh1JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7159

On Thu Jun 5, 2025 at 10:22 PM JST, Abdiel Janulgue wrote:
>
>
> On 30/05/2025 17:02, Alexandre Courbot wrote:
>> On Thu May 29, 2025 at 9:45 AM JST, Jason Gunthorpe wrote:
>>> On Thu, May 29, 2025 at 01:14:05AM +0300, Abdiel Janulgue wrote:
>>>> +impl SGEntry<Unmapped> {
>>>> +    /// Set this entry to point at a given page.
>>>> +    pub fn set_page(&mut self, page: &Page, length: u32, offset: u32)=
 {
>>>> +        let c: *mut bindings::scatterlist =3D self.0.get();
>>>> +        // SAFETY: according to the `SGEntry` invariant, the scatterl=
ist pointer is valid.
>>>> +        // `Page` invariant also ensures the pointer is valid.
>>>> +        unsafe { bindings::sg_set_page(c, page.as_ptr(), length, offs=
et) };
>>>> +    }
>>>> +}
>>>
>>> Wrong safety statement. sg_set_page captures the page.as_ptr() inside
>>> the C datastructure so the caller must ensure it holds a reference on
>>> the page while it is contained within the scatterlist.
>>>
>>> Which this API doesn't force to happen.
>>>
>>> Most likely for this to work for rust you have to take a page
>>> reference here and ensure the page reference is put back during sg
>>> destruction. A typical normal pattern would 'move' the reference from
>>> the caller into the scatterlist.
>>=20
>> As Jason mentioned, we need to make sure that the backing pages don't ge=
t
>> dropped while the `SGTable` is alive. The example provided unfortunately=
 fails
>> to do that:
>>=20
>>      let sgt =3D SGTable::alloc_table(4, GFP_KERNEL)?;
>>      let sgt =3D sgt.init(|iter| {
>>          for sg in iter {
>>              sg.set_page(&Page::alloc_page(GFP_KERNEL)?, PAGE_SIZE as u3=
2, 0);
>>          }
>>          Ok(())
>>      })?;
>>=20
>> Here the allocated `Page`s are dropped immediately after their address i=
s
>> written by `set_page`, giving the device access to memory that may now b=
e used
>> for completely different purposes. As long as the `SGTable` exists, the =
memory
>> it points to must not be released or reallocated in any way.
>
>
> Hi just a silly observation while trying to think about other ways to=20
> tie the page lifetime to the sgtable. Why can't we just use a lifetime=20
> bound annotation?
>
> It's simpler and it seems to work:
>
>
> impl<'b> SGEntry<'b, Unmapped> {
>      pub fn set_page<'a: 'b> (&mut self, page: &'a Page, length: u32,=20
> offset: u32)
>
> So with this, my erroneous example fails to compile. Here the compiler=20
> enforces the use  of the api so that the page of the lifetime is always=20
> tied to the sgtable:
>
>
> let sgt =3D sgt.init(|iter| {
>     |                             ---- has type=20
> `kernel::scatterlist::SGTableIterMut<'1>`
> 71 |             for sg in iter {
>     |                 -- assignment requires that borrow lasts for `'1`
> 72 |                 sg.set_page(&Page::alloc_page(GFP_KERNEL)?,=20
> PAGE_SIZE as u32, 0);
>     |                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=20
>               - temporary value is freed at the end of this statement
>     |                              |
>     |                              creates a temporary value which is=20
> freed while still in use

That would work for this example, but IIUC the bound lifetime will also
prevent you from doing any sort of dynamic lifetime management using a
smart pointer, meaning you cannot store the SGTable into another object?

Whereas storing any generic owner lets use pass a regular reference
(which lifetime will thus propagate to the SGTable) to serve your
example, but also works with any smart pointer.
