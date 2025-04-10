Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66C1268684
	for <iommu@lists.linux.dev>; Thu, 10 Apr 2025 09:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744278766; cv=fail; b=p9ER9wNqRGeo2tO4yUqqkvU2LQxOXKbBOS4pvhMrd+dRsPfQS2OfNsyau+J1wMT55wTxIewcwmt+N1k8LEPLVpAxvPToCgr+Jh0byyrSsQUju6fc0LjUqlN3tN7+pAhi4fvfBL5cW9eW8KTiJKR/AP2ACl8sHJyWlqTBpTdO0MI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744278766; c=relaxed/simple;
	bh=fWwIA9A2VpAwJScbMgsI1aGUB3+Ic/3je3Unnmxonuk=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=BXBrZwRhEVdUUXPHy/q8tf+AisIEDeDHm8QWq9BPWkuWkeoYMYv8K6cfzbTzpnXZydOgEfKRClv8Qlh6ceaawHCWhrs+I2UN+2t0YNQpBai7NryyN108yCNgHJjH6NDJYe2qxjvBGOFMWAVrJhbW815Qf2f1RXNgxx8ECVjD4rM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mVpCgoEL; arc=fail smtp.client-ip=40.107.244.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mVpCgoEL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=erW0IIdG2AMN+CuwzHgxAC7qRz64Mx3jFTosI7h4AjvjUHNx4e1WNtxUXb6gnTtjg4atYgf2Ac5+kYmGxEE1k9j9bpmgeSfcXWGUbGumQOEBo3jMw8/PFsx6umYm/tgnExeKm5Kfrp+nPPQR3uhg0bPy99H7asR897YNRVaz40jcIfhXQfHRofra00dsiDEfGfAEsp0KXMLmaGkcRfOO7SVLLqRZchOM15KODMJIuL4fFlJ8OZxaKZs3t+vM9HVMYWM4bThMzShSsq96oHTI39BG8QHRchhpfn0DnadVk/3fGA1Lba2O8glmDS+3Y+qtq4ts+/KFTCzbSNm98vV/WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSWs2Xv/Zdt4TFVGU9dE+t3UhdLga/Z+3P4sMzNUkxY=;
 b=rMSfizn+EKSbpZrDqUPevUOeXQaJ0kxJOwosaJ9XStSodHgQeM4/LUMOJXFqiHMTQwXE1rHVBU04UqXxUkJCVY/yIQUd7509BmQxQ251I2vSXkageIB/pCfVVE35dkSz4GpA4LDEpkz6MM217MRcGwZj1jrkPUAraoA6ibVd+3y6TU5faGTmmTC5BQ4GNFWp3KwFSqPB8fzBWuuHrvbpdiQYnLfX4pYfcG0Ef+zGJO14w/lI6O23UJSJeZb+UIO30tWCpA+DLs1gCYMyYUe0rR1qGYh5m+3Vmj8O/W+exP4qXBJXfRkB/H14pFuawrL8UpUuUx52j3ObD8dplYcRIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSWs2Xv/Zdt4TFVGU9dE+t3UhdLga/Z+3P4sMzNUkxY=;
 b=mVpCgoELtHFwfQljz+RbvVF2klhvZgRgpLxFV0MTrqtgjYw+NgSMhpr6zKsapn/7m7MYJBOfe9WRDnyMgKYX+2SpBFd5a3gqzKr18kAZfMOQkhZuEnwxbJjYMZiq/zNTRQNFAnNXQJ+iFIIE4vPasYqGPoQGqBmmQQSA5dI3uqP6O7od/6/Jd2CYOESnTSPtSXjNLDP/wmz/Oqr6HkwmcLZoJ5ngIpLwiVuU8wJN15bccDrIGp0Bw/g2caW9D0FNKfsHQjtilOpGp74FFsA88/RjqzB4c7XeURg+/ErBv06kONi/J6tRVNcc/p5p/FwkpAgiZxnPl6VefcIMR+7SzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by BL4PR12MB9534.namprd12.prod.outlook.com (2603:10b6:208:58f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Thu, 10 Apr
 2025 09:52:42 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%6]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 09:52:41 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Apr 2025 18:52:34 +0900
Message-Id: <D92V7PTBE3YP.2RFJGJS619NZN@nvidia.com>
To: "Abdiel Janulgue" <abdiel.janulgue@gmail.com>, <a.hindborg@kernel.org>,
 <ojeda@kernel.org>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Robin Murphy" <robin.murphy@arm.com>,
 "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <benno.lossin@proton.me>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "open
 list:DMA MAPPING HELPERS DEVICE DRIVER API [RUST]"
 <rust-for-linux@vger.kernel.org>, "Marek Szyprowski"
 <m.szyprowski@samsung.com>, "open list:DMA MAPPING HELPERS"
 <iommu@lists.linux.dev>, "open list" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] rust: dma: add as_slice/write functions for
 CoherentAllocation
From: "Alexandre Courbot" <acourbot@nvidia.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250326201230.3193329-1-abdiel.janulgue@gmail.com>
 <20250326201230.3193329-4-abdiel.janulgue@gmail.com>
 <D90XDHJWABTC.1VM2A3KYOT0UL@nvidia.com>
 <4a48338e-64a1-4740-ae1f-7458507a009e@gmail.com>
In-Reply-To: <4a48338e-64a1-4740-ae1f-7458507a009e@gmail.com>
X-ClientProxiedBy: TYCPR01CA0115.jpnprd01.prod.outlook.com
 (2603:1096:405:4::31) To MN2PR12MB3997.namprd12.prod.outlook.com
 (2603:10b6:208:161::11)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|BL4PR12MB9534:EE_
X-MS-Office365-Filtering-Correlation-Id: 29ab138a-4e99-46a1-a930-08dd78156ed6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZksybUQwZVphaUMrYStZditIZlZ2S2d2ZlV6bmpGYXcvQTE2eWVMd0JPNVFK?=
 =?utf-8?B?SWVoMjgzcnZhRkpXKzRoTi9aaVZkWTBtWmpNTTQ1VEI4YmhON3l2T3ZOeThZ?=
 =?utf-8?B?VzdTNzVPUkJRbEJlQ3pGQzlQRGlpVGlSWGFEYUkxYUNHL3dsbEVncHF1dy92?=
 =?utf-8?B?Z3RwMHN6bEpiNGhEUk1qcWJkWjFCUjRndHA4Uy80cGFTQzdqTTR0eEpoZjV3?=
 =?utf-8?B?SFRYM0lEVm9SNEV4clJpOWF0VTc5T3ZJTDNGOTF2b2w5YU9lZldvQjFHTWhB?=
 =?utf-8?B?NFR6dDZlTHFzb045OWZWYTd3Q2FUL0M4a01DRGp1ZSs2UmxiMHFCN29UOEFr?=
 =?utf-8?B?T2N0WTNZK1FNamFwenFyblBkYTdYeGpmNWtyMGZKT0s0WEVUUTU5cktWUXFV?=
 =?utf-8?B?aUZTV1JFT3pUVjZOQUlGSlZTZDVRc1BlRGt2WHp2NVpYQ0VENkxQZHVXVHFX?=
 =?utf-8?B?THRZc3prT0hUeVJLM1R2V0pWb1JuQmt0dDVWZm43Y2JJWkhhdWJMdGpCWER2?=
 =?utf-8?B?Nmx0bVhnaWFFTTVkazRKbUJCcUZzejRDQkkzMFZmMHNzZ3hoS0p3VE0ycTBu?=
 =?utf-8?B?Vm9mSFN2emluMXBwL29aTXVnR2JOTGhKa2szZFI2eElpVktUVm8zMGlrRnpE?=
 =?utf-8?B?NndESmMzWFI2QjY5TXAvaUNMNWNpZkZxaVBnNEdGZHk2OElqaE5Ib2dvSDQz?=
 =?utf-8?B?akhOakNya2Z1eEhZNWQvL0ZYMDFwcHYzNnF6NWFzRHdyR21Yd0Y3OTcwMytu?=
 =?utf-8?B?bWpxeXRPcUl0VWdiMUhQamFZOFlxK3cyZ1lsamRSakRVZSt3RHh3ZVBHS3px?=
 =?utf-8?B?eFpYQVh6bm9Va28rN3dmZ1NQcm9WRk5KMU5MRjk0QjFVaU1MNmJnV3gycGQz?=
 =?utf-8?B?b2hDK1ZYc2RJb202MEl2TTdtLzdUZjN6RXB4UisxZnljdElSSDgzeWVwWnN3?=
 =?utf-8?B?UXFZS2JKVXo1VWttYWxMSHYveVp5WEZwUVZXRWNDZWNvT05nbEdxWGxYQUhN?=
 =?utf-8?B?dlZHNjhVSU5aZDVrblFyaFhiYk1zdzlYZDkvVitubGVDK3MrNGVjVVBjQVdK?=
 =?utf-8?B?Rmtoc3dEZGRyeFg2bzB2OUJydHNmRmJ4UGljVkllR0JPSUc0dVB2NFU2cWhN?=
 =?utf-8?B?K1ByY1NZYVhMRGJEOGRlNG5oZDc2QWU3cUFiUTBvaTZyelNqOUFmTVpXdjZN?=
 =?utf-8?B?YkJjaXdpTUpoRjhaKzErR2ZON1ZodU9VcVRZVTdPRS9IUDJyUHNsK1R4Rm1K?=
 =?utf-8?B?MDhuVmE2MlgvY3JTdi9DQ2picmZvYjdaNHBmb012SUp1L0FUV2hZRHNxRFZr?=
 =?utf-8?B?Y29laWhQeWVmTWhTdUE2eUFHeEVldTNiVmd5ZDJRVWJvbUpCZDlwdndBV2du?=
 =?utf-8?B?bTgrZFRRUGRnVGh2Z2MrU1dhbFlCaVZhU29wdEVtQU84anBqSFh6dHNmcG11?=
 =?utf-8?B?NE5yK3M1RXBWWWhyTHVlQWR2MWVCMjZjTzZVNlErTWlFOG1QeEhDbTgwMitP?=
 =?utf-8?B?TENrS3pPNHdQNnFRUS8rd2xiU3YwQ000VENEYWlrSk9lWUdDcmtrbnNkOVJp?=
 =?utf-8?B?MXdhSUhORTM0RlBiaTBQaFoyd0htYU1GdmFzZHdtY0VSemFZSjZ3dVJaanBN?=
 =?utf-8?B?ZDlxNFRBajFVZThhcjk0SFh3YnlhWGExRlhDMkp5TEw2MGEyT0FGNFliWVZN?=
 =?utf-8?B?c3FERTZrSG5aV3BKMThVbWxHRmV5b1F2dUJrcnB1V0F2bm4zNi9KUEFNK0hG?=
 =?utf-8?B?djA5TGdyWnVpZC82aWZXRnhXUys5bm5MVzdFMUd6L3VHU0F6MzRSWUpYdkQ0?=
 =?utf-8?B?Vy9lQ1Zlc3dmRUhITkliTnlDK2xnOTNqR0x1OVRjWjJSUFJlSUpJOHBhMnNP?=
 =?utf-8?Q?vciYSzhP1JVpE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXFQaDJvdStJVWR1QzMrc3F0djV5YThiMVRjZ1dqUlRhWkUzRzc0R0xmeXYv?=
 =?utf-8?B?ZDFpbHRHVTV2WS81TU5RbkZLdGxiZmxXUEJ6aHl4dFN5WUpMaVNqZlczWW03?=
 =?utf-8?B?bHBkTisyYWxSdER4OC9reERQclRnSm93MkRBWkdYSzZOTkdVekJuSm53elFQ?=
 =?utf-8?B?TWRLWndzYUhhVnhQN1hxQnBqdzE2NU5hbTFwWDFXWlpXOTNuSnZId3hNczh2?=
 =?utf-8?B?VnAzRHNHbXZxSkdWcDBocTVQdUpncWdjc3Y5VVhBSUNNRnJuU01uUmk4L3FN?=
 =?utf-8?B?QUlWdzk0Y29mR3BFS3V0eTJMeFY4cHl0VUNHeWVsYjh3QVlnTVVFVENzOXFh?=
 =?utf-8?B?QnpzQ1BLNWNUakQxTU1kUFVQZG1ORStPMXU3K2xtZGhDWFU4UDhnOVd0MUEx?=
 =?utf-8?B?ZHpnbW5IOVJYM2VDMUxNTHJDdjVONUt0U1JxTytLK3JoUlVpaENRTUlVdmIv?=
 =?utf-8?B?SnhqbUpXSEtCSFlRck90U3VVVTFmMlpSSFNCdjNGMVc3ZTdEQ3N2VW4wNTh4?=
 =?utf-8?B?VXA3dUZqdHJzMkdCOWErcCtIUC9vVVpEVkNBeWRtaEdFQU1ZM0dTWGdHQjhi?=
 =?utf-8?B?NXZXd2txazFEMkRvTlZvSzhpaFhoZWEycE85ZG9ocTZ4aWFPc1NkZG93Vnhr?=
 =?utf-8?B?LzNrOGpSbEQxcStTU1haRERVMWQ5WmRVTjFPcWw3SGhjTUVjYWdUS2phVU5D?=
 =?utf-8?B?YXZWc3VFbjlNd29pdlp4KzN4WmIyWVlvMVo1RU1DSzlpOEV4NEg1VmFnVk9B?=
 =?utf-8?B?WkZaWXhWbldyM0M0NUFqeDZuUnBva3oyKzdDOUVvYTBuWStBMUtESmk4SUly?=
 =?utf-8?B?RmhremhsaUZIdG5OaWs2OWxRbTVSQTkwdGJJdlBXaHc5aW5qb2d6K1R3OE5B?=
 =?utf-8?B?a21YM1MvTVNKRG1TNlo5NzM2azFoYnc0QmhGbURJZFhrKy8va2d4NGlSOExT?=
 =?utf-8?B?blEwY2RTS3JlZmJCUGQ1Z1RqRSs3UmltYUMvL01GdGNheVgzNHcwSVdzc3cy?=
 =?utf-8?B?YWF6aVRuUWhiL2NKeWJ6L1pseG5lWm5LNlZqYmE5QzdCdEdYRVRQWTJyeHMw?=
 =?utf-8?B?aUhqL1dlSzVHaEVFbWNZQStGRmxkeG5VRHJobmtsWVgrRjNlT0I0UXp2ZFBv?=
 =?utf-8?B?d1E5ckJFVGJBcytRcCsweGI4TGhiQVJkQlp4M2hyb0E0aE04Vi9Sem9pckVV?=
 =?utf-8?B?c1NvUm9SdEpoRTZ4RmMxeUJlN00vZkRsR3lqL0NaSUVQam9xMzB6dU42U291?=
 =?utf-8?B?MHdoelFoRy9mNHNPbm9nQ0dDaytOQVZ5TDV4SkZpeXpWK0NaTmVvbjMzNWlu?=
 =?utf-8?B?ckJrOGRlMjdoYXUyKzZSN1dkM0sxckF4T2hwQXU2QUJpeGlkV0dwTHdxKy9r?=
 =?utf-8?B?VFBORmI0Z3NuYUtDVnRHeStDNWIrWDdtY2tFYmJWWC9WNmNTRE5wZmhNcFV6?=
 =?utf-8?B?TlkzMTlhVjdueWpBY0tlL2FuL2p0Y3BoWktXZGhNb2dTdEdrVWE4aXBqdnl1?=
 =?utf-8?B?NWR0R2l6WHRzQjE2R1RvOTN6MmliK2ppYy95ZGNSS2k0REhiZ1AxbW5mRjR2?=
 =?utf-8?B?Ly90RE9XVXZhVWpRb2xHZHZWSjVQbXYrY3dKL3hCWjJwY2ZoVUNCNXE4M2w2?=
 =?utf-8?B?M2piZzdXWFhMZnJOaUlGbE9ibVpzK0tEY25yRHRIcDZzTTFibHNQTzg3dHBp?=
 =?utf-8?B?ZmVzYUxnNHVPRm5xM3hBekVuTWwxTlRJQzE5NWM1WUJ3SU10YnR3TWQ0cHJZ?=
 =?utf-8?B?TUx1MTdaRnN3UXo4SUtvYkIwMFQ5am5hZU41MzFZNm9DaDNreUlGdWxOLzZR?=
 =?utf-8?B?MU5FQWZJWEV5U0ZLaHdBNWtOSm9ReklkNzVCd1lsTkd1R240WmJHM3R4VWhB?=
 =?utf-8?B?d0tOWDQvWXdTWjNmQzlRczhlS1BQZzNsanhiSWlxYXU0c2U3TmgrckpQYk9F?=
 =?utf-8?B?RFd1dmt0LzV3UUZIMTRic24zbWtaRmlweERwQk9JK3RNUkl0WThqREtPYmxJ?=
 =?utf-8?B?d1M3ODZNTmhMZzdSaitIMXZwTEt4UCs3bzBPRmtiMzFSbFhsY3NzNjNrYnJt?=
 =?utf-8?B?UUhONEhIZnBGNERxOFE3SHYrTWJDSUZWTWtvSnhFTzh4Z3JlNW5lNjFVRVdz?=
 =?utf-8?B?Zk5DSWxzcmpScUJsLyt1L1hFTW9JMnFlR0pROFVHR0sxRFhKWUUzeTU2QXQ3?=
 =?utf-8?Q?BqgbuTlwxVy659ROKf6nZ4zt2crhFDruxaJUaFDox/ZO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ab138a-4e99-46a1-a930-08dd78156ed6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 09:52:41.3625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CRFt4uKeWIbC6K9gBX60KIrGKMV3arxy5xTwzJGFvQewZKWez8uPGDbC9cJ7Dwa4kf2ChXKdjn8ZTgieafhflA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9534

On Thu Apr 10, 2025 at 6:02 PM JST, Abdiel Janulgue wrote:
> Hi Alex,
>
> On 08/04/2025 06:08, Alexandre Courbot wrote:
>>> +        }
>>> +        // SAFETY:
>>> +        // - The pointer is valid due to type invariant on `CoherentAl=
location`
>>> +        // and we've just checked that the range and index is within b=
ounds.
>>> +        // - `offset` can't overflow since it is smaller than `self.co=
unt` and we've checked
>>> +        // that `self.count` won't overflow early in the constructor.
>>> +        unsafe {
>>> +            core::ptr::copy_nonoverlapping(src.as_ptr(), self.cpu_addr=
.add(offset), src.len())
>>> +        };
>>=20
>> How about leveraging as_slice_mut() so this unsafe block can be removed?
>
> as_slice_mut is still unsafe, no? So we couldn't remove unsafe block stil=
l?

Ah, that's right. In that case it would at least factorize the bound
check and make the method a bit shorter, unless I missed something else.
