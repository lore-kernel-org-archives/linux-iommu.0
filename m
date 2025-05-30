Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEE1FBF0
	for <iommu@lists.linux.dev>; Fri, 30 May 2025 14:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748613732; cv=fail; b=qTqgZZjjwJHSFscV+dFr7PbBhyQyKfD5WG6QGaqQytF6c8Rni9FtrjxazeJ8I/lka/yGlkdaVEaQS6hKFrAwONhoNiJdIsD64fVgHx6CrSRh+LiuTlFm0qPvLDfKQtgNuftFKPUc055LjOISosP3aJm6kpplSB4Rd04718HinYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748613732; c=relaxed/simple;
	bh=u+8jy58Ca8kgnhn6HHy35dBH29jfIfKdEm27lxgut20=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=PsluORX1yTAwR3Win2Ed39PRLUHAbbuiOiHqsihoxDLmnl2Id9qZnVvulpPFFA4Z/AyK8qvm8eNt3eDPImdlNq7lTSFr6Uir/bvPP1ffNb+pjEzjaA102DYUYgib4bHjGTJCdzcCN6IB9oCXcvLDfwaP5xHPGBEvNtDcZ+1EukA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e7ltP785; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e7ltP785"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0c4Z8mdDScDb8Gutr8pdDqkp+JojW2QNi8zgQv+mBS4F1GOOw5RpblVu/wDS9bGtBNBhdp5+5nHa2/U8R5+EcK0ZuimsQ39wQgt5ahJI9mTFsAep547bIodtME9eEVUyJq/rslJw1DcGVSaMWOg9NhvtMI5A77wtsqmGw3sGS8othJ9nnS3Si1ygUdWXjwae1SMX9PwcrpzAWIn+0NO1SaMAmc0GzafR2w+jUezuJ/2MCU7Nti5oiKaE732igl1+Xdkvrdp1WxPA4+enB6rus37nC/n7Xw2i0k2+ra3dBAj/qB3tBFNe36tA74kOerCV2O1Z52cUN323PJLyU1Bvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULcv/EYDGd93mYmVUK0Q5cJTAZBRmEGP0ARPkkLSU9M=;
 b=BFgBQExnr9y1gHsitfhoAZjBmubc6PH24ci4WVmLGwjCkGtJV6Vu5aFPIolpsGr+c9vfsZWkqAOOnhnTICgqH7id9K9MO0mlvEkA8lR8mwjqVgI+3vemQ2L52GWuTUWpF/qH75dhf9jxju815kswIBUMpyo+k1/v9EwePwyAnZrSaUN2ulAd9t5/1WCF62CAbcSrTObSGX+/5e2KVYcd0j33RvNs61fYXS9HxZXWa2jwYGqR3uUgZpzxFAlR5SCyIuKixAodiv9yGrsd1+kRTvjM7frLsnB2n+WGrCC6buGikmu3AbpcLaPgx2M/73zh0cGPhGsNOc20BDAngkGO+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULcv/EYDGd93mYmVUK0Q5cJTAZBRmEGP0ARPkkLSU9M=;
 b=e7ltP785oJfIt/B/iYgMS1uw5fFp035VEWdnjFzK/KYSGxyMGdfAtiFXTr+5Cls3BarBgBtrUGkog/7mbFruRtYZoJxvijXCrgLTpVUNWucPWIvBY9XJ0GDnIbss/QHW+EupEIZiH59M7aU9mqNteJLXaU2usMNrViDFfpwR8azsqb4OuMvdJWadoYwoprXny+kWGAxsRAwt3FkzNlW0RKTX1gZdFbGRFqwBUFJ2uZWMAcNiZTcxyHXM5l2JTXM/KCD4C7xj70y54Jfi7jzuRMBpV2KeujXFfUTDp3g4U29JmM+sKnhlOMGPc9kDXVldlskNoRyHiBP392ue4av1Aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CY8PR12MB8242.namprd12.prod.outlook.com (2603:10b6:930:77::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Fri, 30 May
 2025 14:02:07 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%5]) with mapi id 15.20.8769.029; Fri, 30 May 2025
 14:02:05 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 30 May 2025 23:02:02 +0900
Message-Id: <DA9JTYA0EQU8.26M0ZX80FOBWY@nvidia.com>
Subject: Re: [PATCH 1/2] rust: add initial scatterlist bindings
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Jason Gunthorpe" <jgg@ziepe.ca>, "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>
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
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250528221525.1705117-1-abdiel.janulgue@gmail.com>
 <20250528221525.1705117-2-abdiel.janulgue@gmail.com>
 <20250529004550.GB192517@ziepe.ca>
In-Reply-To: <20250529004550.GB192517@ziepe.ca>
X-ClientProxiedBy: TYCP301CA0069.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CY8PR12MB8242:EE_
X-MS-Office365-Filtering-Correlation-Id: 3be40a78-f85d-45e0-4e02-08dd9f828f18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2RobnA5aU4yYVJtUzREMmRCbCtvVUVrNXRzejg2bWtFamlvTU1FUkJzSDB5?=
 =?utf-8?B?NWJqZFFHWVRTRU1tZjNTZldxVUk4eWU1bTJ3WDJRQmpSMTNDNWhsa1ppSnlH?=
 =?utf-8?B?N3prMFBUZDFqRW91d1NJRE9pUVB3Tml6MlVDamVqMmJBbVF2RGlUQWNjdkN4?=
 =?utf-8?B?bVEyK3lCUDZleWNEVU9FVjBONjEyMXlML1RFLzBTSWxxUTkrY0lSRkZjNFFt?=
 =?utf-8?B?SUR4MWR5QlFrTlE4dUhlRXdpSXRtU3lCcVdmYlR2QWMvc210ZkhMWFdYanRw?=
 =?utf-8?B?cmtRRnpDM2tPUnRpTXNCN3NmOHZzanRMUFBtQlFraUZ1TVFuajdYV0VuSDAy?=
 =?utf-8?B?aTlqcndDaDNYSkFnQ05iWGw2Zi9GWlErakJaNXJOYXplcTRwS0dxdXQ2OUFK?=
 =?utf-8?B?Ym5DWlNtNmFCdXBReXF0dG5keU8zYVllT1lyRVBRODN0YzE5MzA4NjRaeXZ1?=
 =?utf-8?B?bjlYMW5RaEViMUpDaXNqc0xNVXp0Rm9GbXp0N1ByWGpLRE0yZkxnL2prWFVM?=
 =?utf-8?B?d1B2VmZhTDhkTlJuZG4xMG91YnA5cVdJaDBYZ25CbzZhN3lYdlBrYWtCV2Mx?=
 =?utf-8?B?ekl1dHRLd2lLdk5QTzB1Q0c3ZktoOTRJWE9nRHh1cVBJb2wvQkV3TDhRaFVt?=
 =?utf-8?B?MlRGYVZMM2lyUUFlZ0JybHNHMGVDTkw3eEQ4aHptY2g1ZnhyZXR5bUN2a1Jn?=
 =?utf-8?B?Nmhhc2hiRDlhMm9yVHFjdCt6T3B4dUVNbnQyWFNnaEpua29FbWJVMkEybDdL?=
 =?utf-8?B?bDNGU1dGcGVZOWh4cGs2UkN1Uko2eEtBZmxJUkhTbmpFZWtZUU1NaVpSOTQw?=
 =?utf-8?B?Z01RM2F4MTNHNlJtdUVxeWtmSTNPUlJtWlJwNld6OTFwSEh3NTVTcjNOVG41?=
 =?utf-8?B?WEplZUtNQkt2MitZYkticmRXMWo1MnJraUN1WHhjTm5oQi9WclhaT3Q4VURa?=
 =?utf-8?B?NDVJZ1JtUlBmeHd1YkNDWnZGVHJZVmZLdTBKQ0gxLy9qSEtVRER4SGQrTVhL?=
 =?utf-8?B?T1pucTB0YmJiR1VvMSttYTQrZTJ0UjAxVzlBbkl3b2puOGlQcDFwNVBaaTRT?=
 =?utf-8?B?Uys2bnNyVE5lM0pIY0F0bHgva21DVndkTGVVOGVuaUs0QVFkb3hXMk92MjM4?=
 =?utf-8?B?eldKMEovdlc1Q3V4NDlFZVFVbWNGcWk5UTRKdTM2WFh1Y01Eb0s2MTRDOXp2?=
 =?utf-8?B?aWZWZENZdCtJZUI0bjlhWXpCSGdtYWxQRE42bjFCWkZPTElzYTc3OHczQ2lY?=
 =?utf-8?B?ZDQ5Vjk0djhhRWRTVUc3c3BvdFl0SWFxMzc1RHhqdjhxb3dJSVNXNUFRYzU2?=
 =?utf-8?B?aU5nS2hoczBTNFI1M3hzN1JsMG1Wb0ZybFpjR3BaSmJvUllSU0hUUnRUQmFz?=
 =?utf-8?B?eC9mbHlKY2E5SSttUkg5S2pCSE1rTVpuUE43ejliUnBOb1pJbjZFdmRUOXNh?=
 =?utf-8?B?a25JQndPRE5udHY5enN0TUh2eVI1cE9yejhvTmpjWFJKR0h5cWdWdC9zNmhV?=
 =?utf-8?B?MjlRVDBxbzZ2b3VPSnYwWS81VFdjZVRlV0hkQ25BSEd4cDZOZ0h5Z0g2elRz?=
 =?utf-8?B?TDR5SnNZa05JbDlUZFBxbEt5YlRpZHBFUkdLTmcycE55aWVkUVJPY2VLY010?=
 =?utf-8?B?R1lCMHRtbFU2eGVHSnorTDJmU3VMQ3dPRlQ4U2JPMm80L2paZisxQlR1TlBB?=
 =?utf-8?B?TFYvbXMzZnFCUk9ZTXc3dS9lcEVHbjFkalpNWmJSeUo4cGFSZGZzZEUxNGV2?=
 =?utf-8?B?aG0xQkhoSTdCTzdqTFV2OUpybmRLSFpzZ3lJdGNoYkl5RkFRNW9pMUR6WG1a?=
 =?utf-8?B?WTRISzlqdHRDeVAyTFJyWk9zSTgwLzg0RDgvNXFnT00vTE95T1ZuWXd6bmdB?=
 =?utf-8?B?RnhwMm1kWklNVEJwb1RtNG42cVlLb2JuZk1hakZzT01iREFrR3g2WlFQOTY2?=
 =?utf-8?Q?Uwra8iXEzuE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3gxUi9UOGpBZkNvS1gvdTVxcEdSV1FrWC9aZ2ZOZ2VSYlpHVmF1Q1FaT1R6?=
 =?utf-8?B?L0VmaUJnYmtPbTJ1STlhTnZKNkVYTEVrVTV4TDJkV0w5bE4rNHlIKzJNbXRo?=
 =?utf-8?B?a0tLUVhyVkQzd1RVYlhDRC9lREttK2Y0MlNDZWlGZCtIaXVvN2ZZY09XZ1RK?=
 =?utf-8?B?ZGVpdzdQU0NRSUVIZ29vTEZzd002ekdNZUhjRU16ZktMSWxwZUNrQ2pjNW5k?=
 =?utf-8?B?YmFyVDdtdTQxVjZwTkZBdCsrMk9leDNiU0h6TktKNDBHTWt2ZjZQNnZJeklh?=
 =?utf-8?B?MjBzYVNGZkxwY0M2dmIzR0krYysvaEpoL1RJQzhQdFZYOVdrVTFzeExxVzdT?=
 =?utf-8?B?WVN0TEIwRTJYNnFJQW81aVFWZHg3blFMOTJqcGY1ZVFkcHZuTXpyTEdpMHd1?=
 =?utf-8?B?MG1aWWxleFJLamZId2cxSUx4aVJmVUhWcVZ2dTU1Y2ZyMHh1bllUUWQwS0s5?=
 =?utf-8?B?cGhsSXhUZlFoU1VDcTZ0T2pvRE9RVktGc3JVYUZJTFFBYm8xVVdFU0ZCbzJz?=
 =?utf-8?B?SmZsK1lWYWJWeUZuemVRYlpwL1dVbFpsK1BIaXJISHhCVklIWWpzdXA3UEk2?=
 =?utf-8?B?aUwwM2ltTEttZGNlNEsrSEtLczlHVkd3bUdjUUhTNi9WOGtUaTl1QXRsRDVL?=
 =?utf-8?B?ZmNSS1o1UUlwd2VGVjJsUTBhZlA2OHo3VUFxNHpZR1UwQjdqcUoyUnd4blc2?=
 =?utf-8?B?SUVUcXQ0b3plUE1xNGp6SkZRZUVDR2pBdkVkWmgwaWVoUWR5VCtnQ1MyMDBw?=
 =?utf-8?B?Y25CR1VCRDB0aCtTWEE5VTNKWkZmWEcyOFNBcEI5cU1KTUtkMVhHN2pSZVl6?=
 =?utf-8?B?VytHdUV2T2kzaTcvY08rVDY5SVd4blFweDVSYU03bjVvci9zSHFweEVQd2kz?=
 =?utf-8?B?UFZZd3EybEhWS002dzRHRVVZOGpQTlV6UDNDdDhMWENGejZVSWs3SEZhZzEx?=
 =?utf-8?B?aW9MWWZ4bGhlY2dtZEhlcCtxcmdFdEdiNGRwV2ZkRCtVKzhwVHEzR3Y4bHNx?=
 =?utf-8?B?YnlhSDI0Slp2M1RUNVphRURKWi9BdGJZeU9BeGtCSlAwVnBDSnVLbGVVdHdj?=
 =?utf-8?B?WXNrZmNnRHMvbFYwK200VEtUN0Z6K3V3Z3JQRnRDakU3dFpjcGhVTHh4MXpp?=
 =?utf-8?B?R3hTc3RRRVVUajN4TmZCazYyZzN2VFpvSTRkVnR3K0MzWnpycUJXNG93ZUEv?=
 =?utf-8?B?cytpQitTT0MvZHV4U2lYNXdBZmU3aW5jcmhzaVlZci9FdzYrcmUxYmFGVHJ0?=
 =?utf-8?B?KzdVZytIYWo2L0JNK1Vkd1RDaE9BY0Nob2p2R3R2SGNBMU5IR1AzYjNpVDVt?=
 =?utf-8?B?eC9CT3ptUDM0elEvb3hSdU1LVHhjVk5mVzlZWkdHVEtscjh5dkIwTjZjWTZD?=
 =?utf-8?B?eEhHOXNKQnc0MkxPRlZGYVZOMytNU0NmODQzMDhuS04xKzNSUGcvYVRzc2Jt?=
 =?utf-8?B?QXhaUGlUSW9BRWRob21iOTBGS2pOSnFoZWV1bUlrUkNEUEIrbUVOamY4YnlH?=
 =?utf-8?B?eEx3WjhQc0hkcTNHZHpHT0plMTc2N2haZ0VoLzE0QitZNk9OYWVlVlZsSEM5?=
 =?utf-8?B?UzBOc2NSTGtjQkFvUnU5akNhVkhsNEF5NGVWOS9OWEt4cFBUcnZxTXlRWWNK?=
 =?utf-8?B?SkRxWXNQbGxUU3czMklmem84d04xVE85L29kc0ZlaFF6WDFRZkVwdU9aeWJh?=
 =?utf-8?B?ZS8vQ2JMa1Y0RDd6S0V5VnRlUDJLWFBoRnNneDBoNjIzRWVid2g3Y3N3eWNh?=
 =?utf-8?B?Y2oyUFNQMUZtb2x6bDhOZnE3TFpaTXA4NEZYQnV3NzAyUEtDcTQ5OGNiM0dG?=
 =?utf-8?B?V3NrZkZkY1NxbGpITkxvZERCVHdIeHYyWVN1ZHBSVng1UlU4aWE2ZEVTNXdT?=
 =?utf-8?B?d01wbDN4QlRZVEJlSkIxUDVST3gvcjhTNGJiQlh6eEhTaldGbURzWVQyQ0pK?=
 =?utf-8?B?KzduVFp6OUx3OUtSSTJ3WUxwMWF4TmVwUDh6bEd0Y0VyRkJIbmgvWHd1STdh?=
 =?utf-8?B?WldkU28zaGJaR01xR213bE50WjYrTWk4WXY3RU9ZejB1WUFsaEFrYzRwaFRl?=
 =?utf-8?B?Szk5S3Y5ajVReHByMW1sZEdZYUlFS0NnWTAvYXZyS0J0MTJqT3VVMmx2cGdq?=
 =?utf-8?B?MEtEQ3RXR2VVOWlPK2VpR1VPTU91T25ZSVlGTzcrd0IrRXJaQmxnRkZweDVB?=
 =?utf-8?Q?9JRBs2rPHDhGk9VOgg6HkdHA06oettxl6MIMwyZvbcR0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be40a78-f85d-45e0-4e02-08dd9f828f18
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 14:02:05.5891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ee9C5MhHw3w0jtliUlyNVsps7EWt3AeQRO91q0E8qoG5FEIY7IYb2NqP/vUVJ1cgwE7UY0y2P1Gk9Ih3v7BviQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8242

On Thu May 29, 2025 at 9:45 AM JST, Jason Gunthorpe wrote:
> On Thu, May 29, 2025 at 01:14:05AM +0300, Abdiel Janulgue wrote:
>> +impl SGEntry<Unmapped> {
>> +    /// Set this entry to point at a given page.
>> +    pub fn set_page(&mut self, page: &Page, length: u32, offset: u32) {
>> +        let c: *mut bindings::scatterlist =3D self.0.get();
>> +        // SAFETY: according to the `SGEntry` invariant, the scatterlis=
t pointer is valid.
>> +        // `Page` invariant also ensures the pointer is valid.
>> +        unsafe { bindings::sg_set_page(c, page.as_ptr(), length, offset=
) };
>> +    }
>> +}
>
> Wrong safety statement. sg_set_page captures the page.as_ptr() inside
> the C datastructure so the caller must ensure it holds a reference on
> the page while it is contained within the scatterlist.
>
> Which this API doesn't force to happen.
>
> Most likely for this to work for rust you have to take a page
> reference here and ensure the page reference is put back during sg
> destruction. A typical normal pattern would 'move' the reference from
> the caller into the scatterlist.

As Jason mentioned, we need to make sure that the backing pages don't get
dropped while the `SGTable` is alive. The example provided unfortunately fa=
ils
to do that:

    let sgt =3D SGTable::alloc_table(4, GFP_KERNEL)?;
    let sgt =3D sgt.init(|iter| {
        for sg in iter {
            sg.set_page(&Page::alloc_page(GFP_KERNEL)?, PAGE_SIZE as u32, 0=
);
        }
        Ok(())
    })?;

Here the allocated `Page`s are dropped immediately after their address is
written by `set_page`, giving the device access to memory that may now be u=
sed
for completely different purposes. As long as the `SGTable` exists, the mem=
ory
it points to must not be released or reallocated in any way.

To that effect, we could simply store the `Page`s into the `SGTable`, but t=
hat
would cover only one of the many ways they can be constructed. For instance=
 we
may want to share a `VVec` with a device and this just won't allow doing it=
.

So we need a way to keep the provider of the pages alive into the `SGTable`=
,
while also having a convenient way to get its list of pages. Here is rough =
idea
for doing this, it is very crude and probably not bulletproof but hopefully=
 it
can constitute a start.

You would have a trait for providing the pages and their range:

    /// Provides a list of pages that can be used to build a `SGTable`.
    trait SGTablePages {
        /// Returns an iterator to the pages providing the backing memory o=
f `self`.
        fn pages_iter<'a>(&'a self) -> impl Iterator<Item =3D &'a bindings:=
:page>;
        /// Returns the effective range of the mapping.
        fn range(&self) -> Range<usize>;
    }

The `SGTable` becomes something like:

    struct SGTable<P: SGTablePages, T: MapState>
    {
        table: Opaque<bindings::sg_table>,
        pages: P,
        _s: PhantomData<T>,
    }

You can then implement `SGTablePages` on anything you want to DMA map. Say =
a
list of pages (using newtype on purpose):

    struct PagesArray(KVec<Page>);

    impl SGTablePages for PagesArray {
        fn pages_iter<'a>(&'a self) -> impl Iterator<Item =3D &'a bindings:=
:page> {
            self.0.iter().map(|page| unsafe { &*page.as_ptr() })
        }

        fn range(&self) -> Range<usize> {
            0..(PAGE_SIZE * self.0.len())
        }
    }

Or a pinned `VVec`:

    impl<T> SGTablePages for Pin<VVec<T>> {
        fn pages_iter<'a>(&'a self) -> impl Iterator<Item =3D &'a bindings:=
:page> {
            // Number of pages covering `self`
            (0..self.len().next_multiple_of(PAGE_SIZE))
                .into_iter()
                // pointer to virtual address of page
                .map(|i| unsafe { self.as_ptr().add(PAGE_SIZE * i) } as *co=
nst c_void)
                // convert virtual address to page
                .map(|ptr| unsafe { &*bindings::vmalloc_to_page(ptr) })
        }

        fn range(&self) -> Range<usize> {
            0..self.len()
        }
    }

You can store these into `SGTable::pages` and ensure (unless I missed
something) that its memory stays valid, while providing the material to
initialize the `sg_table`.

`SGTable` could provide an accessor to `pages` so the CPU can read/write th=
e
data when DMA is not active (maybe also calling `dma_sync_*` as appropriate=
?).
Or maybe users could put the backing object behind a smart pointer for
concurrent accesses and pass that to `SGTable`.

One nice thing with this approach is that users don't have to figure out
themselves how to obtain the page list for their buffer if it already has a
`SGTablePages` implementation, like `VVec` does.

Note that although the code above builds for me, I probably got a few thing=
s
wrong - maybe `SGTablePages` should be `unsafe`, maybe also I am misusing
`Pin`, or overlooked a few usecases that would be impossible to implement u=
sing
this scheme. Hopefully we can get more feedback to validate or reject this
idea.

