Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA071DA53
	for <iommu@lists.linux.dev>; Sun, 15 Jun 2025 12:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749991911; cv=fail; b=BjKcxeyg2xBDTEEA+B+NOFvTh6XxHgjIFrMLmD5fgr7ioKuBK5DsnBIOH+C6RFRRY8uj5Y5XMAAB03z6DLT2CxOvva7IxJ+wjGpGSVCBH9X8qiLYHcdEmg/yzLiF7uvFqN4WnAXM1T5S/WXrWPG/iJgfin6dfRxNQWa7DwK6JFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749991911; c=relaxed/simple;
	bh=X9X+RZBoLY/sNgwB1954fjoLuhUUtJt90ra93lvlXfc=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=dd5Xch9hxe7tzrMrrjII6oLMMHDdaaxUSpsJJCTifQle3WesMsepniAboJkvRDsLNx8VeGu7eetPJHLCguASS0HABvGvzwUH4o4jaJLsS6YitVVzYfW8eWDOM8lYTjJlxJVUE1OVp3CFJt22iv4T4rhUrfhAvjLmK3e0vRTnbv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iFRQeOjT; arc=fail smtp.client-ip=40.107.95.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iFRQeOjT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wi1za/MGuLAL2SDIysi8U5FkDPoPdi3gykVuLThCJqHYpRhcNZ1OK2CNeou1gcjYOMiVz5ex6jBKbPe03LvvME4hryl2BK1/LPYfeP6jvhg//heoopwEzw4VuRo26WoWFvD9m8eX8+fw4pQrhrA8kbWmY6F/uz3uWWErALiuwfM5L09vRY4rLLyXv9baAJDJRLVj8xU7eeFlZTkfmSdRiEV7c2guME1jnKujKENxIlpn8Hey4AWZJhXAfNgJeSLrmnvewzP5150fVoJdzl6USnTDBYUY1TPAMVcQtXmXQ1Q0+WpQXeck6j0kUaH2x+0zF5UMURt/rpKt3s/S6G6czg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8SYkMbMyvLU2aA7HF7oJ5VBJzbbZBiRWkfaSmJqIPE=;
 b=JrEAEMQdqygWBWwXZQoXYf6crbsErggMuEeXSSrq36MfFspdC/Alhsk5Sy3xC48lGVvGNNhop0T7q4/wtRBmOonokjxDodxMY7eXE4a0d7/r0vgDUJexbpvII/Ls4clNxUzYSgsligkb3xXNoZYMx/2+WjRlDHL5d3v1SLmwefTTXZ7hoz3n/48IlZzDA3Jd/nOmHWpsn95OLKj6XYbtzNBnn8pgLzmExaC/MHjyetHqiqc02MJaGFe2sDn2+ZRjYplmVBU+A59DYqnUm4XX/bszjFoUOemD0mXRmjck8hBmtB9DObCVmvJq9lUcBj9isrX9JcqrA6XPngx0qAyLSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8SYkMbMyvLU2aA7HF7oJ5VBJzbbZBiRWkfaSmJqIPE=;
 b=iFRQeOjTNwomI9gUOBNO5Yj28cNJN7+I8XNatrSPFLaS0P3NAMLJ/C/N63LPD5l/Oa1eR8PcWecwNB4Mbiu9NUI5lN0w3wTs0f4zmJSJAlLiG9Nz5C7nkEnrmAez69zYfa7Fsr/2vUSEBKzboVVWMPYx6iLbzNOL5kNXKo9sM4OPN6znuLIRtW5ztckZhSDzwASWljaiN00OkOBlTfYqtj+Pav9wWSH0EtbIzt9PECW43aKIoeFXgoDdhSamuPufCjSexNdpKBZC5wXuyYjQwRRJF6CYT9JrltzC+Uuw3EsxsJ9I073Cvbx6qV6uB6MYCCoLGtsF21Olmp+WKzo/lA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by BN7PPF8FCE094C0.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Sun, 15 Jun
 2025 12:51:45 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8835.027; Sun, 15 Jun 2025
 12:51:45 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 15 Jun 2025 21:51:41 +0900
Message-Id: <DAN4CT3UVC8K.1EZOFGQDUDWZF@nvidia.com>
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
Subject: Re: [PATCH v4 3/3] rust: dma: add as_slice/write functions for
 CoherentAllocation
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Abdiel Janulgue" <abdiel.janulgue@gmail.com>, <dakr@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250602085444.1925053-1-abdiel.janulgue@gmail.com>
 <20250602085444.1925053-4-abdiel.janulgue@gmail.com>
 <DAC2ILD2DSIZ.3TF8W39X5DDH8@nvidia.com>
 <0b71832f-f3a9-4109-baa1-f29a8327d872@gmail.com>
In-Reply-To: <0b71832f-f3a9-4109-baa1-f29a8327d872@gmail.com>
X-ClientProxiedBy: TYAPR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:404:15::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|BN7PPF8FCE094C0:EE_
X-MS-Office365-Filtering-Correlation-Id: dd5cd2be-51e3-4032-bd4e-08ddac0b6258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aVBLSGg0ZGtqSlNNR2hkbjdvSjVGQlltQWcva3VRbDIxeUdNM0pscWR3RXBZ?=
 =?utf-8?B?YlEvNk1DRTN0QTVSV0J3NGlJRTdabm94VGZOOXdzZFJwM094b2dMTzM5Znl1?=
 =?utf-8?B?WEIxUGc1bDFad3psSFVtRmUxMW1FMGdkdWFvTG5HWTByLzY1Z0lKeEZNcHJU?=
 =?utf-8?B?T3BUOHVzVUVVakFHSmpxUm95aXJqMVB1SFZqMjlFTVJZdlgxZXZ0cENUcXhS?=
 =?utf-8?B?dmoyWW9ZSDVHYXc4d3FPc1MvY2ovUmIxMDZrNG1melllckJwam9wK3Y3NVAv?=
 =?utf-8?B?QUNkTFV4WFVsL2FqMXBYVktWc0N4ZG5CR29DckNTVWtTUXVoWHVUSElaNXlr?=
 =?utf-8?B?OFZDSis4OXlwM0JUbmRzTHhxWG9FTGd1SERsZHM3U0VLaVBmVGRSNlZmL3By?=
 =?utf-8?B?TFlXMXFXbHJvWHdZazdHbERLZHBmUmQxOXNjTW8xTlNLT2pjVG8wNkZjTC9q?=
 =?utf-8?B?cW4wcC9pRlpaMjYycUJDSGU3UGRRK3RuU0wreE5Ga3VLT2RBa3RYWG5GbVYy?=
 =?utf-8?B?eVByQ2xoMUpzSXd4WC9jN3QxaXViZlZ5eEFyc3M4eXFVQThKTHVKaFF1ZnBs?=
 =?utf-8?B?N3RBN2YxOFJWOG9lVXYzZlF6RnFLN0l4OTVlSUxkYld1Qm1BY0tOcGVncyt4?=
 =?utf-8?B?am41dEpabXF5eldFckVGTHlJbDd4QU1xTHR4dmlQdXBRa0JVRzdya3MzOGJV?=
 =?utf-8?B?dk9DUnFHdU00Ry82TUpxV1hSKzgxYU9iTTVhdXBvU3dWK1I5UGlEMTR2Z0pL?=
 =?utf-8?B?RXFJcTBnaU4raWRFbXVmR2J2YXhCOG5MZ3JOT1V4U2MzcGZZSklhUnpubHRX?=
 =?utf-8?B?YVN4OFozK3lLYm9ra0tHekczTk5DZ0V3ZUE0RnFLRyswcWVjdjZLVDFoeWJa?=
 =?utf-8?B?RHRXbG1KMUw2cnlsM1c4RElKcDFMRS9yNkhvWUhWUStaSmtSUWREa2FPMkhv?=
 =?utf-8?B?MFJ1Sk8vZG9wMzA3RitVYktNaW4yT09WWHUvUStiOTNLTlFROU9sTGFGRlF2?=
 =?utf-8?B?eVIzN2ZYSDd1Z3doRUw4ZDRMVC9JRjBocDc0SW5neGRXVTF3Zlg3bVRya1Jj?=
 =?utf-8?B?bE13UGEvT3o0bldMWGtHRldyQXdZM2g4cHlMbVNTWUU2MUZGNDVsa2xRZDFr?=
 =?utf-8?B?UlpRRmpUc1dLLys1UTZEV1dSS3JMSzJkMjJrNWc3Nk5DUDhOb1hUbXZ0bmgw?=
 =?utf-8?B?YWpNV1A1UGpGNXdvWmhpRW1la21Nb3F1TU5HelFOYm9RU3VrSE9qS3NFWUgy?=
 =?utf-8?B?ejZTU09PS3FvZGdQUForSitLUnFnb3RpSUpSaUlSTlpXcXJ6L2ZpK25vK1U5?=
 =?utf-8?B?Y29weVBJcHJMbUpSRkpHRldETkpXQTA3K25LeWlPNzRKczBLZms4UitNa2Rs?=
 =?utf-8?B?RlRXU0NLM25qM3JZSVNCZ3JWdW5iSE4wamcxaXNwZ0luc2tGN2JYNmtmTWQw?=
 =?utf-8?B?aDRndXZHOWVhUk5pMlA5QmdmZ2Vzc3U1dG5lV2RmTk1Md1JiVlp2S3N4NGhF?=
 =?utf-8?B?NldXZ1hEWm1IOW1xUzE3VmtBT21sU2VqeVdjY2FFVkpnZWtLM3FQZ2dBbm1s?=
 =?utf-8?B?Sk42U3ZkOGM4YVpEYUJXdWdQRTgvaHhOUkpmMnY2bUwxcGVScEt3NWJjOEx3?=
 =?utf-8?B?R05aeFRhcVdxWVV6a0xsWE9WeDhrRmszTkhoODZ1YkdyWmIrcDExSDlkcEp4?=
 =?utf-8?B?eXplekVMbitkVlprdFhGNnQveWdZbFR4R2FMVXk2SGE0NVlFYm05cTZVSjlo?=
 =?utf-8?B?SFdGNzIvODh5Q1EyRGdZTXZ1WHhNUnQvSEVkSVpxeFpEMnUrUjZNVHdYRnFp?=
 =?utf-8?B?a3RhOHNOQ2c5bFQxeWhCY3dXenJTa2tCTStrbzF0amIxMFBRWERDTTc4MTBt?=
 =?utf-8?B?dnR3UTBKekNCUHVrVHpEWTlHYlB5SjVSVmFBUTF0VUxsdzE4bktsc01CSUM4?=
 =?utf-8?Q?e9gqX0/AMzs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0lUWGxrazJZanBQc0lKaXVOaGNzNm5lVkVlWk1aZUZab2UrWmJ6aWhRZ0ts?=
 =?utf-8?B?NkNtVHNNZWlrL2l2M0lJN3N4amlSZkRya25BTW1lTDBReEZUMjFFaTcwVDJ2?=
 =?utf-8?B?L2RQd09VM0FjOTRLZWg1Y2lFQlI5b2xtVERQOXdOTkw3WmF0OU1maCt0YW9R?=
 =?utf-8?B?WGZnYlZxTk9iVHZCTTJFWVhjMmJsa3VFb1Q5d2xuVWRHK2VRQ3BCdjdUWmYy?=
 =?utf-8?B?K0ZsL2tDKy9za3VkNGxIK3B1OGhTL3BodlphRkZ6dzAzUFBvMFU2TUNPckFl?=
 =?utf-8?B?amhybmhCVzJtZzhzMTVjdEQrNS9CbStlTVowQXVzYmFxVE55OVJ2Uk9xWDVz?=
 =?utf-8?B?N200Q3dGOVFiRlVZVzQ2TWxPd2RWZlVxekJhbFFYYXhXaExTZWdnTTc1dk9E?=
 =?utf-8?B?dXZCdEV1U3ROaUJ5WXI3RmVjK2dmQXhoQ3RIdUVjZlU2NktDclE3dXpXVi8r?=
 =?utf-8?B?bHhEamc2cjRMaHBGNXdXS09xVUlKWWlrNHhQTkNaT3BxSERUSVYzdDgyTXJx?=
 =?utf-8?B?NCtsOTRFR1RPR0VFR3JaQlhubkJtZGJsckhHZUYxVEhhTmZhVnQ4YXJBbTZa?=
 =?utf-8?B?akhTbDZ2RnBzbUdyRytsN0Y4bTY0OG1pKzRuTjhTTWVFcFNHVGRSWllUaHVB?=
 =?utf-8?B?ZElzRGRKakh0NEV0ajR6dUp3YU1VM1cwMEg0eSs0OGhLbzdaTE4xQWM4ZVdw?=
 =?utf-8?B?ZlFnYk1LczdHaHBGenJPRnZJTUdEbVY5Zk8rbk9Da2lkaHJrYUI5WU5YcXZk?=
 =?utf-8?B?UnNVQ091RzlGZGJtT0JuREtnOU5IcVk5YnlzUEJjT1dMNitJWUJ5NW5tZ1J5?=
 =?utf-8?B?RUl4ckZRZXVZdUR4bkVqTnlWZmhnN1JTNWt5ZGFKekRDWlJNdlhQZFd0M1hv?=
 =?utf-8?B?MGU5ZHZ4WktlYWVFYVBFYjZzWEU2NE5nTTVGUlNkOWJoN012M0hUOEtEUE1u?=
 =?utf-8?B?aWxCNlUvaTdhdTVyUndkU2h1K2VQUFBwdm1ENTYvM09Id0hzTXgvVUdDTUdZ?=
 =?utf-8?B?R0tLckRXZHZ0ZzdUQzNqeVBQcnR1WlRHOEJRc1E4R1ZFdWoyWHNBdFkyV09D?=
 =?utf-8?B?K3hmdVpNUDh2dmVMZGVBeWNybFc1aGhCRXEvNGYxZWtxckRxK1huR1c1MXN3?=
 =?utf-8?B?RDQzRjBTM2tzSXp4NGVCN2JSMVFEWnMwMzhWRXpSRGpvQUZDMWhud0pZNkNW?=
 =?utf-8?B?aVpMU0RNN3ZtTWduTjJrdEtrVTl2MVpsSjczNnZqOGZ1U3d3MDYxRHVaNlFY?=
 =?utf-8?B?RHUvL3ZPUXNwbkdFQjM2SU9zRitRaGJqWHh2L1FlVW0yT3ArTVZPc3p6d2da?=
 =?utf-8?B?M1I4dlpBbzZOdUExV2V1bWxVYjdBRjRlYWxwL2RRcmNvQ3d1WGdnZ1k3MG96?=
 =?utf-8?B?Zlk1RlRJeXhaZnJEUWlSWjNrYmZ6K3ZvK3l2eUNNYWp4TTN0eGVidEI5VHV3?=
 =?utf-8?B?c1NJZVUzRnM0NS9IWXhXckx6QnpSNzJSR3BBYnRlRDkrK21sRFZYaE82Ujk2?=
 =?utf-8?B?dGxzeDJIRnVkYzBHSlBZYUs3bDFzamRNMnhQeGdJU3lnM0xMYzgzYXl2S29K?=
 =?utf-8?B?VkZ1aytjc2pyWGNldU0xcWtmQTgrWDRhZU03NnRtRUt3dDdoL0tqRlFia2J3?=
 =?utf-8?B?aXVlQ0oxMWptQ0xlTXFTUW1QUTB1S1FmVjdhelZvVXBmWEtLaHE2b0FxM2xt?=
 =?utf-8?B?bzh4QnRFVDBzSXQwb2x3M3FmMTI4RHNYL1RsRTEwNEJWM2tQWUxndE9lNWp2?=
 =?utf-8?B?K1JCQ1JwMXBIVWJUL1JoNWl6UHpxOWhudEx3NXQzT2M5WDJOampzU0ZXOHlY?=
 =?utf-8?B?SnlQSndXaE44RjRnam5qWTFjK3dSd3JQdjNoSmxYZzFjb3d5U1RmMzRlVXh1?=
 =?utf-8?B?VlVyR1M5TmRMTit2ZHJ4ZW1wZUI2L0FoOW1zL2ovOWlFc092T3ZscHFoMnVC?=
 =?utf-8?B?MitpL0xuU3BxNVdsRXNrdjYvalFySXhGTWZJMWZMVFErdDRVTnVYUkV5dldG?=
 =?utf-8?B?VGdHeXRVa3NUa1lYQjd1WVRNbzFSVW5wcmpPekhYV1BjQTdwN1RSTjRlczJQ?=
 =?utf-8?B?NlBKYTJaa3VMSXk3RXB6QXFaMlJvSWVQaHJMdTNLdFU0S3VPcVZkM0hvS0VG?=
 =?utf-8?B?dG9HUWZWRk9QaGJiSk5hL3NQdlV4djBSbFpjMEp6bzJZaDVVT3hXZ0JQd2V4?=
 =?utf-8?Q?8MHcD4DqB9K6kqobks3YDAcIUM2xxi0kFkQQ7NbqtmjP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd5cd2be-51e3-4032-bd4e-08ddac0b6258
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2025 12:51:45.2846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b34BjH0CUvsg+1HTHSdXkYYChmgZYybObM9jKTKQEcGmUsOcG3zOnaT5e0vSmI+0FrzyfMqJbqoX7QlsYGGBuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF8FCE094C0

On Fri Jun 13, 2025 at 6:45 PM JST, Abdiel Janulgue wrote:
> On 02/06/2025 16:05, Alexandre Courbot wrote:
>> On Mon Jun 2, 2025 at 5:53 PM JST, Abdiel Janulgue wrote:
>>> Add unsafe accessors for the region for reading or writing large
>>> blocks of data.
>>>
>>> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
>>> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
>>=20
>> A couple remaining nits/questions below, but FWIW:
>>=20
>> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
>>> +
>>> +    /// Writes data to the region starting from `offset`. `offset` is =
in units of `T`, not the
>>> +    /// number of bytes.
>>=20
>> Reading this sentence it occured to me that `offset` may be ambiguous
>> here, as in my mind it rings as being in bytes unit. How about using
>> `index` throughout the file?
>
> Thanks! I don't have any strong opinion about this, I think it's enough=20
> that the subsequent paragraph makes it clear that the unit is in bytes=20
> unit? In any case, this could this be updated later after the merge?

I agree this can be its own follow-up change, especially since `offset`
is already used elsewhere in the code and this patch is consistent with
the existing nomenclature - let's fix them all together as a separate
patch.

>
>>> +    /// ```
>>> +    pub unsafe fn write(&self, src: &[T], offset: usize) -> Result {
>>=20
>> Can this function be written by leveraging `as_slice_mut` and
>> `clone_from_slice`?
>
> using `slice::clone_from_slice` would enforce the length of the coherent=
=20
> allocation to be always the same as src data. Not sure if that is what=20
> we want. Also, instead of just a straight memcpy, this would go through=20
> a 2-step layer (a call to `slice::from_raw_parts_mut` and then the=20
> `slice::clone_from_slice` itself)?.

Ack, thanks for the explanation!
