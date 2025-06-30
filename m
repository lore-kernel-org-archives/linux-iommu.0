Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1FB226165
	for <iommu@lists.linux.dev>; Mon, 30 Jun 2025 08:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751272450; cv=fail; b=gLhM+ki6Mm7bEOGqCHgwthNjz5OkELqpeHZFNjYo56VhLmfMdxGZ24idabSGYMK6jbQU8YFV3cDSL5lRYvX2TFvQdTeScnUIZTcNP0FLSvR1emg2LKG6HIK1ur1kl7iVBVAz4KLzKPdv4pBm/LZHO7cBmqgAdarTGhB8qiZXLw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751272450; c=relaxed/simple;
	bh=rfAR6CNfqlEdKp5uraMm7SJcmwH9Oud3uss8Rim2xME=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=a2g7hNJIMEJDzcNX6KFYyvuGK40ZBJ7wF9STsa2fd4CyPyO+L3RvgAva0AzgGazVRDJNialoj00YApx1oYEGVUgDSThgrmCsYi4McVQXL/0SfugQDU22Rn27QDfkWILHtsXUoqXEX/xkcZn1YFbfQ/3MHnFYWez1C8CIyKWpjMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IfLWt05o; arc=fail smtp.client-ip=40.107.223.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IfLWt05o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0TUmpXuGfMmV7kOdpIE5GwFBNkqLpH9hnYB6rcoMl1U/iLKs8ppVvhzoEqG+F3LfEnnz6w9l2Wcn9THkgtOPBhuYofNV6cVYF/j4zxQ/REpXQW6wns4Ahs6ktWD2lS95BPx6DjQxNiolbCxHxlmiooTjGnNssCzv6cjffepcpfrVWQ3ZtoLY2WKl2k+izXndz9jeMxyWAYDq+PsDqZOBgYzo6pHpv1dXwoGP6xQ5FpeopLwsG77kQpzTKi7/mCU8f6isDcfcgn5QwzNNYQ5ieLAbI45kpfSe6zqEU68drntZueHJbcvt30PLNEXqkIFiP+4JUGj0J6QTgzV7nYxUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8J2RbVyEOKwbzkgejXonOAkwIc+GVcNtAnnGmD2Jwk=;
 b=yqZjSctv5K1jVqxHyI1plbZszQUIXKkiSW6kpOuOithJBZtZA1HW67kHN6dSb9q4ad2Q6Qw99Bo80jedQL1DqH50xlQZOIsJoPjzsPSmVNRD7lOTMklB8TEI+QSNWpOUNMpQgeu0O6gPhG/ur9fsilwQ/GqxvhRPUB10KOZAYT8aunyeQscPIXhBqRe2AVqEbIVEHc0tvut88p5qnComA0zIHLjyLjiIuDIwJoWXMqVka0EhmmdK8lihPjbOH78jy9Tvbl65395Py1Tck8Q+Hiykt5/XIbnXvTu9YjhjDsEL2RuxIFQlkPziSRgGTQkN785HECXxFk/vLXVOMw8Ipg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8J2RbVyEOKwbzkgejXonOAkwIc+GVcNtAnnGmD2Jwk=;
 b=IfLWt05o3lFZS4kyEu85V6iZm4uu6bmsOIz8gMFZCWl0FPrBNm0kStinTJDXBvmc/fysRfaJZ21pQ416dboOt2S5Ml4D3s99+c/epT9qCqWtv30WGYf51TREH00h6XoS5a21LX8JUiaVngrH6OS78z+RpgN8ilhIxrwMKVllYLoppPvjCowq/kPZ0/hX3yeZeoS2A44uvXaxeI0HNP+IZPMUDX+3r4RSWWKq1cvsWMoLEtvZlVsWXi7y+apql/rODOoScZZNijrMunDvOfdujWRxLZEoad5TtZjT7/MFM5edx9PS5vBuJYEQAVQgYD2uwRK0u2ZkCSg+qa0zGi16fQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA1PR12MB7223.namprd12.prod.outlook.com (2603:10b6:806:2bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Mon, 30 Jun
 2025 08:34:04 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8880.021; Mon, 30 Jun 2025
 08:34:03 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 30 Jun 2025 17:34:00 +0900
Message-Id: <DAZQ9OGC1648.2WWABTO7A7UU6@nvidia.com>
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
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250626203247.816273-1-abdiel.janulgue@gmail.com>
 <20250626203247.816273-2-abdiel.janulgue@gmail.com>
In-Reply-To: <20250626203247.816273-2-abdiel.janulgue@gmail.com>
X-ClientProxiedBy: TY1PR01CA0189.jpnprd01.prod.outlook.com (2603:1096:403::19)
 To CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA1PR12MB7223:EE_
X-MS-Office365-Filtering-Correlation-Id: cb38edc7-bdcb-450c-d0e1-08ddb7b0dea7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RVVML1NBMFA0QW9JWUdNcHRIS2xMbzBhMXJEbVdNOTBzd2lTa3RTRDV6Uzhk?=
 =?utf-8?B?MUFWa0J5RlNiVlF3UXFiRlpuL050TVQ0M1g1NFF3eUFkRkVqd29CWXEvTzRC?=
 =?utf-8?B?VUcxUVlmaWJxZ2lUWFBraEtCeHF5NTBlL0w3QklVdjd1c0ZpU2N2dDhwaGwz?=
 =?utf-8?B?d2Q5MDRMZjhvK2NWcVU1N21YTE9ENUkwVzQ1QURPMWl1THFYcG1vcTJXVmRP?=
 =?utf-8?B?MDZwS2hlZjNTbzR1WTJnZVR6d0V1K3l5N1NpaUk1K1Ezdnc0K01mZ3c5Q3ZO?=
 =?utf-8?B?dFhTbi82eGtQSjN3SXVkMWpxMTRKdnJQNHo1dUhzQll4ZTlhaW54RXllbWpl?=
 =?utf-8?B?RHczUXBDU05GU3dpeHBEQ0lpcGtkWWNEamxGQVFJczNmWHNXbEtzMWdFYzNh?=
 =?utf-8?B?NkVKYTJIbGVKeU81ajJZTzJJNlRwV3dLVlR1YjRUUFdlRTJOUDd1RjNzbXBH?=
 =?utf-8?B?SjkrUkMwK2hqcWNYT24xNElxL3lSR0NsZGpCQ3gxR2Z6c29tUkxIaXVNYkw0?=
 =?utf-8?B?ZUFtdm9nNmpCa3BRTFl2SWJLeTFtM0JMVytwc08xdHUrK0o3b1ZOOW1GUXQx?=
 =?utf-8?B?WWVhZlBEY3M2UlN2WStuRGpyZmFuVGZVOXFGUnErSlJBZXo3cW93eFRVNGZv?=
 =?utf-8?B?YXlSc2NGVnA0Zk5sZjZBbGFMWGFkVmpsQ2hnbDBPWThCUDBQVnRmU0RtUFNQ?=
 =?utf-8?B?WWJXTFpGZ2VnVTd1MkJweXN1VUdaVTI4WkNSU25Ma1RHUjY4SHA1SHlZU1Uz?=
 =?utf-8?B?WW9CTnJPSG9BRHdlWkRVRFJ2RFBTWkFMZWd4NURHUzlLV0sxMHVZNzRrQ1lq?=
 =?utf-8?B?VFhGZldXcjZaUFlhTkRoc3hIZldlcWlyaGdmRTlwWWR5ZURSTnArb0dvS3lk?=
 =?utf-8?B?ak1iTjB4NGVlU0JCbXBXeHQyWmprZkxmN3lJQys3VEJtanZOOFQwYUJJT2ta?=
 =?utf-8?B?cVlXT0c2M0dGTGZBeGZkTGFtVnJwSDlSNnJqNkN2OGY2REpFNEtlRzZYS3Zj?=
 =?utf-8?B?WkN6aDVzSUx3VGk4Q1FkL1ZwV1NpOFBkNy8rb1FXN1hEWWJtUlFnai9MYTFr?=
 =?utf-8?B?bjBBN1VuNWw0eDZwY09HMnVNNlJ2L0RIM3h0bEdtdEhWQURJM1ZIRTk3cXI1?=
 =?utf-8?B?VVBXTnA0eDVLam9pb3MrZDJXN1YzM0ZLOTVXK0ZYWkxSYVFXS2hBdC9ZZGxo?=
 =?utf-8?B?bWUrdmJoV0ZIMytic0NORFB6SC9GMlphL1o4c3JTeFg4NXZUNGcxbHZlaTNL?=
 =?utf-8?B?ME9BYldUdUVXbGhpUmpPRnB2dGVZcTR2Wk9RenFtUkhwTmJBeE9FVmdkTkdK?=
 =?utf-8?B?STZLbXZ5cHlkOUIzTFBWZGo2aXpiRE44d2N0WG1UbkpSeTdCcFpvcE05cFJM?=
 =?utf-8?B?MlVHRkdTQkhzRC9EOStuQkZyMVJFbDAwZUhBNWlXa05EK2ZiSElEa0ZJTXJE?=
 =?utf-8?B?K1R0bzREdjlvaXloV0hHRjB6dEMvNXJkem9tTDFxRkxUYmtjc1k4eWxuaHNI?=
 =?utf-8?B?S0pCb3RFVDFrRE9KaFAyMmVKWk1yT2Jub3djZHVORUprMHF3dlMxM21kbzJC?=
 =?utf-8?B?NFdMWFN4Tjg5R09IUk0yU1lVczBwTXNJUjZxYTFzVVduVFJYU0FBb1VVeUJa?=
 =?utf-8?B?RzhHazZSZUR3RjFyMWVoSTRHRGQ0dktXNHFjWWNKeG5uKzlCQTV6SFlkc1hh?=
 =?utf-8?B?U1FiV3kvZU42VStUa3VoaTc0NHJPdTh0S3NWb3A3QUoybEhkWWIvSUJkZ0h4?=
 =?utf-8?B?M0tpdmlieDE1bFZ3UUdDVVN0Q2dWWkovTDMvY1hYR0RKeC9XU1J3eVNGK0I1?=
 =?utf-8?B?WmEwcVphVDZEWGI3ZWNsSWtSYXE5VXFKK1R2U0RsMkw1R0RDaUpML0lPcEVV?=
 =?utf-8?B?THZuWHZQbXRUanEzNS9aN0UydmVTYlZ4VWZKcXRONWwwMUpxbEQrRkx3ZzZk?=
 =?utf-8?Q?Eu5kuwcd5O4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUVOSnBLS1J0MnVSVUs1M3ZaUDhUd1pFaGRJZW42NlNkc2N0UGEyYUp5ckpv?=
 =?utf-8?B?angwQjdXc0tzU1k5cFBXWHRCb0dmTW1pcG9aL3JMUEMwUE9FRmNROWZ1Z1dV?=
 =?utf-8?B?U2pQelF2L2tmOThYOXBaOU5rVmVlSVB2YXEzRmg5ejRpZ29MQUNpcUpCVStv?=
 =?utf-8?B?MVpvenFLQklIenBDSkNCQ0pMVTFkSExqM2N5OW9qYjlSWll2S3ZTaktnTkph?=
 =?utf-8?B?Sk1wbWNEcUVjWU5tZ3BJeU1oM3REbjRyZ01xbEpZbFVlTEZvY1dGZWlTekhI?=
 =?utf-8?B?VGlFQ1Vsd1MzVVZCVi9MY0xGNm5zN3lSMXlnOWlLM3NrSk9URFZmSFdueGx3?=
 =?utf-8?B?UUdXLzl4b2oxOGhJcEFTNUNEN0t0YWdabjZNSU9sMUNBMGl4NUdRN01wbHV2?=
 =?utf-8?B?VCt2RUkzTjhtQXVuQ3hQckVDdXd3Nis5NG80VXlVekpWRDM2bC85NUIwY3o2?=
 =?utf-8?B?Ykl3dFhLZXhFc2JYZlJiRHNGUFRNZWlxdWVOSDVLTVYwMmgwdkJBcmpkSDJ1?=
 =?utf-8?B?RENmalVKdHFhdlViSFovZ3pIdGhIWU5KVmFWZ3FxTmZjM1FBM1VkVDcvYVR4?=
 =?utf-8?B?SjFHdlkzRVpsVmNkKzhiTGRkWVZNYlFMb1g2dHJpTGJrY2krQXBlMWp6elZX?=
 =?utf-8?B?R05NQzV5OS9iSlcrRWdxTmhrSHd5cnV5SDlYTUtWZ01KZWV1R3pXMWhqNTBT?=
 =?utf-8?B?eEdnUWtVOFVnMDB0ZnRhTUdqR3JYczNjcEJscG9VVTFQZTVyV1JuVGFhVmYz?=
 =?utf-8?B?MWg1RVVpdDJ3cnppbUxnc0twa1dPSWdQdzdCaDlFMVpJdk1FTmVUcXFSTTVk?=
 =?utf-8?B?dXliOGpTOUtmYTJXU3ErNS81M3l1SEVzZGNQMUNLcjVUdHdNR0pqM2FnNitR?=
 =?utf-8?B?dWFiVXJqczJRMFJ1U2E5TG5nSW92eXg3aUpoSmJaM3RpU3Zsc2t1ZGptWllh?=
 =?utf-8?B?UkliUTF4L293T095U0dCSjFIZWh5VEpwWGtXdVAwVmpqMkVnWklRcjdwb2dn?=
 =?utf-8?B?RVBpd29oN1pQWWd1MDhVWm5qZVk4YkpLVm04UjBoTnBpalpQYkV5UlJEa2pW?=
 =?utf-8?B?cjlpRXBkTm5yeXd0NzJMaXBOeVBndUlud2tLa1pGbWx4WEl0VjJkY2JYbWwx?=
 =?utf-8?B?WmFTcDV5bmV3VFVLTzdFZFllaVc3MHFiMVNkZW1iZFlRRjhPM2hwZzlmK09k?=
 =?utf-8?B?SE54N3hjL2dBNmJrUXo2eWY4bVFzOVVIYXZGcXpNMytPa01BZlJJRDI1T00v?=
 =?utf-8?B?UmlyZmRpVkJTazU3MEVZcVdWU05VNnp2UW82T3ZwQUY3ZndmZWRrSEpxZW1l?=
 =?utf-8?B?cHRxT3BqUmg2MDNrT0RGb0RMRGk4WjV5aEhnQjZRS2czYTN3ZVczTVc5aTEv?=
 =?utf-8?B?SmRiekFYYnArbkdIQlBwSTI3SDMwSWZnTkdUcjQ4d2cvSENaQlREOU1xUmRy?=
 =?utf-8?B?Vzgrc3JVcThFZjZJNmRBVjdoK25Ha1kxYmRJeHlYUkJ2c205SXpsNnBwN2pm?=
 =?utf-8?B?M2JQYURNakxOT0ltaDh0VFo5Wk1rMFpYdTJtOG45Q3B1YmZqcS85WGtGM0kr?=
 =?utf-8?B?MzRLMXpyVHBmb2E1cWZVWWNiL25ueGh4S3FCUUZMSmhjOVp2U1JtMzROWjlw?=
 =?utf-8?B?WWhoN2NMWlVURUtGbHVyck04cSs1SjBkZTZjdkhEbUpFVVhFeUJnTWExL3RF?=
 =?utf-8?B?Nm8yN2MrRVNKTzNESDhMdEw5V2cyd2FJWGIwMHpoT0ZYeU5PVG9McHJlUExl?=
 =?utf-8?B?ZjQ2ZFE2T1pWT0ZjU2xaMENPSjRQdlY4aHoySGVNVGF1Z0Z6UTI3NnZ0NzJx?=
 =?utf-8?B?ejBTVGN5OEJYR3dlMzdBZ0dsVzR1RXVhU0gwZG80RG5vczN2ZStjRjM0RmdT?=
 =?utf-8?B?RXFWdldyT0R5cWYyUzFsTlBIY3RacjV3UngwM2lPS1U5eWNIMjQxUUZoZlRO?=
 =?utf-8?B?cG13YlVuL3lTdXZLOU5DVGtaZFJFZkpKTWYyME4vWW10SktaRjNYZjFhbHh6?=
 =?utf-8?B?TmpFNXI1TXVmY284THYvMzJsTGtkOVp1ZCt3Yy9xcmx4Y1FjUUMxVitMbnEz?=
 =?utf-8?B?MTQ3YW5NZVlaQjRla1BmUHNMN3ozNytBQ3pGbTE2Y05PR3ROYnJ0RlhDTzk3?=
 =?utf-8?B?N0NtT2FPcy9wUklaY1JaRGx1UVhYa3NzRnNvc3ZOYVFIUXV0OEVwVWl3Y24x?=
 =?utf-8?Q?kyrixnwmLrRJeGwgA+A0pRMVebWlHi8aARbfH9P7smbE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb38edc7-bdcb-450c-d0e1-08ddb7b0dea7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 08:34:03.8812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JK3MeS2exnBqtB1Bwu+4LVhgUzXxjqgyredJN6uAcBlppUBbo6PqAPwqg7/2BeW3DbvowMs2R4WiAEMzhCqv9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7223

On Fri Jun 27, 2025 at 5:30 AM JST, Abdiel Janulgue wrote:
> Add the rust abstraction for scatterlist. This allows use of the C
> scatterlist within Rust code which the caller can allocate themselves
> or to wrap existing kernel sg_table objects.
>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> ---
<snip>
> diff --git a/rust/kernel/scatterlist.rs b/rust/kernel/scatterlist.rs
> new file mode 100644
> index 000000000000..2e17a56ea7c7
> --- /dev/null
> +++ b/rust/kernel/scatterlist.rs
> @@ -0,0 +1,390 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Scatterlist
> +//!
> +//! C header: [`include/linux/scatterlist.h`](srctree/include/linux/scat=
terlist.h)
> +
> +use crate::{
> +    bindings,
> +    device::{Bound, Device},
> +    dma::DmaDataDirection,
> +    error::{Error, Result},
> +    page::Page,
> +    types::{ARef, Opaque},
> +};
> +
> +/// A single scatter-gather entry, representing a span of pages in the d=
evice's DMA address space.
> +///
> +/// This interface is accessible only via the `SGTable` iterators. When =
using the API safely, certain
> +/// methods are only available depending on a specific state of operatio=
n of the scatter-gather table,
> +/// i.e. setting page entries is done internally only during constructio=
n while retrieving the DMA address
> +/// is only possible when the `SGTable` is already mapped for DMA via a =
device.
> +///
> +/// # Invariants
> +///
> +/// The `scatterlist` pointer is valid for the lifetime of an SGEntry in=
stance.
> +#[repr(transparent)]
> +pub struct SGEntry(Opaque<bindings::scatterlist>);

I am not sure to understand why you dropped the typestate here. Not all
members of `scatterlist` are valid at all times, and the typestate
allowed us to control which members could be accessed. Dropping it
forces you to define access rules using unsafe methods and invariants,
pushing the responsibility of writing valid code to the user while we
could very well use the compiler for this.

> +
> +impl SGEntry {
> +    /// Convert a raw `struct scatterlist *` to a `&'a SGEntry`.
> +    ///
> +    /// This is meant as a helper for other kernel subsystems and not to=
 be used by device drivers directly.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that the `struct scatterlist` pointed to by =
`ptr` is valid for the lifetime
> +    /// of the returned reference.
> +    pub(crate) unsafe fn as_ref<'a>(ptr: *mut bindings::scatterlist) -> =
&'a Self {
> +        // SAFETY: The pointer is valid and guaranteed by the safety req=
uirements of the function.
> +        unsafe { &*ptr.cast() }
> +    }
> +
> +    /// Convert a raw `struct scatterlist *` to a `&'a mut SGEntry`.
> +    ///
> +    /// This is meant as a helper for other kernel subsystems and not to=
 be used by device drivers directly.
> +    ///
> +    /// # Safety
> +    ///
> +    /// See safety requirements of [`SGEntry::as_ref`]. In addition, cal=
lers must ensure that only
> +    /// a single mutable reference can be taken from the same raw pointe=
r, i.e. for the lifetime of the
> +    /// returned reference, no other call to this function on the same `=
struct scatterlist *` should
> +    /// be permitted.
> +    pub(crate) unsafe fn as_mut<'a>(ptr: *mut bindings::scatterlist) -> =
&'a mut Self {
> +        // SAFETY: The pointer is valid and guaranteed by the safety req=
uirements of the function.
> +        unsafe { &mut *ptr.cast() }
> +    }
> +
> +    /// Obtain the raw `struct scatterlist *`.
> +    pub(crate) fn as_raw(&self) -> *mut bindings::scatterlist {
> +        self.0.get()
> +    }
> +
> +    /// Returns the DMA address of this SG entry.
> +    pub fn dma_address(&self) -> bindings::dma_addr_t {
> +        // SAFETY: By the type invariant of `SGEntry`, ptr is valid.
> +        unsafe { bindings::sg_dma_address(self.0.get()) }
> +    }
> +
> +    /// Returns the length of this SG entry.
> +    pub fn dma_len(&self) -> u32 {
> +        // SAFETY: By the type invariant of `SGEntry`, ptr is valid.
> +        unsafe { bindings::sg_dma_len(self.0.get()) }
> +    }
> +
> +    /// Internal constructor helper to set this entry to point at a give=
n page. Not to be used directly.
> +    fn set_page(&mut self, page: &Page, length: u32, offset: u32) {
> +        let c: *mut bindings::scatterlist =3D self.0.get();
> +        // SAFETY: according to the `SGEntry` invariant, the scatterlist=
 pointer is valid.
> +        // `Page` invariant also ensure the pointer is valid.
> +        unsafe { bindings::sg_set_page(c, page.as_ptr(), length, offset)=
 };
> +    }
> +}
> +
> +/// A scatter-gather table of DMA address spans.
> +///
> +/// This structure represents the Rust abstraction for a C `struct sg_ta=
ble`. This implementation
> +/// abstracts the usage of an already existing C `struct sg_table` withi=
n Rust code that we get
> +/// passed from the C side.
> +///
> +/// Note that constructing a new scatter-gather object using [`SGTable::=
alloc_table`] enforces safe
> +/// and proper use of the API.
> +///
> +/// # Invariants
> +///
> +/// The `sg_table` pointer is valid for the lifetime of an SGTable insta=
nce.
> +#[repr(transparent)]
> +pub struct SGTable(Opaque<bindings::sg_table>);
> +
> +impl SGTable {
> +    /// Convert a raw `struct sg_table *` to a `&'a SGTable`.
> +    ///
> +    /// This is meant as a helper for other kernel subsystems and not to=
 be used by device drivers directly.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that the `struct sg_table` pointed to by `pt=
r` is initialized and valid for
> +    /// the lifetime of the returned reference.
> +    #[allow(unused)]
> +    pub(crate) unsafe fn as_ref<'a>(ptr: *mut bindings::sg_table) -> &'a=
 Self {
> +        // SAFETY: Guaranteed by the safety requirements of the function=
.
> +        unsafe { &*ptr.cast() }
> +    }
> +
> +    /// Convert a raw `struct sg_table *` to a `&'a mut SGTable`.
> +    ///
> +    /// This is meant as a helper for other kernel subsystems and not to=
 be used by device drivers directly.
> +    ///
> +    /// # Safety
> +    ///
> +    /// See safety requirements of [`SGTable::as_ref`]. In addition, cal=
lers must ensure that only
> +    /// a single mutable reference can be taken from the same raw pointe=
r, i.e. for the lifetime of the
> +    /// returned reference, no other call to this function on the same `=
struct sg_table *` should
> +    /// be permitted.
> +    #[allow(unused)]
> +    pub(crate) unsafe fn as_mut<'a>(ptr: *mut bindings::sg_table) -> &'a=
 mut Self {
> +        // SAFETY: Guaranteed by the safety requirements of the function=
.
> +        unsafe { &mut *ptr.cast() }
> +    }
> +
> +    /// Obtain the raw `struct sg_table *`.
> +    pub(crate) fn as_raw(&self) -> *mut bindings::sg_table {
> +        self.0.get()
> +    }
> +
> +    /// Allocate and build a new scatter-gather table from an existing l=
ist of `pages`. This method
> +    /// moves the ownership of `pages` to the table.
> +    ///
> +    /// To build a scatter-gather table, provide the `pages` object whic=
h must implement the
> +    /// `SGTablePages` trait.
> +    ///
> +    ///# Examples
> +    ///
> +    /// ```
> +    /// use kernel::{device::Device, scatterlist::*, page::*, prelude::*=
};
> +    ///
> +    /// struct PagesArray(KVec<Page>);
> +    /// impl SGTablePages for PagesArray {
> +    ///     fn iter<'a>(&'a self) -> impl Iterator<Item =3D (&'a Page, u=
size, usize)> {
> +    ///         self.0.iter().map(|page| (page, kernel::page::PAGE_SIZE,=
 0))
> +    ///     }
> +    ///
> +    ///     fn entries(&self) -> usize {
> +    ///         self.0.len()
> +    ///     }
> +    /// }
> +    ///
> +    /// let mut pages =3D KVec::new();
> +    /// let _ =3D pages.push(Page::alloc_page(GFP_KERNEL)?, GFP_KERNEL);
> +    /// let _ =3D pages.push(Page::alloc_page(GFP_KERNEL)?, GFP_KERNEL);
> +    /// let sgt =3D SGTable::alloc_table(PagesArray(pages), GFP_KERNEL)?=
;
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    pub fn alloc_table<P: SGTablePages>(
> +        pages: P,
> +        flags: kernel::alloc::Flags,
> +    ) -> Result<SGTablePageList<P>> {

This returns a `SGTablePageList`, so why is this a method of `SGTable`?

> +        let sgt: Opaque<bindings::sg_table> =3D Opaque::uninit();
> +
> +        // SAFETY: The sgt pointer is from the Opaque-wrapped `sg_table`=
 object hence is valid.
> +        let ret =3D
> +            unsafe { bindings::sg_alloc_table(sgt.get(), pages.entries()=
 as u32, flags.as_raw()) };
> +        if ret !=3D 0 {
> +            return Err(Error::from_errno(ret));
> +        }
> +        let mut sgtable =3D Self(sgt);
> +        let sgentries =3D sgtable.iter_mut().zip(pages.iter());
> +        for entry in sgentries {
> +            let page =3D entry.1;
> +            entry.0.set_page(page.0, page.1 as u32, page.2 as u32)
> +        }
> +
> +        // INVARIANT: We just successfully allocated and built the table=
 from the page entries.
> +        Ok(SGTablePageList { sg: sgtable, pages })
> +    }
> +
> +    /// Map this scatter-gather table describing a buffer for DMA by the=
 `Device`.
> +    ///
> +    /// This is meant as a helper for other kernel subsystems and not to=
 be used by device drivers directly.
> +    /// See also the safe version [`SGTablePageList::dma_map`] which enf=
orces the safety requirements below.
> +    ///
> +    /// # Safety
> +    ///
> +    /// * The caller takes responsibility that the sg entries in the sca=
tter-gather table object are
> +    ///   already populated beforehand.
> +    /// * The caller takes responsibility that the table does not get ma=
pped more than once to prevent UB.

These safety requirements would not be needed if you had a typestate in
`SGTable`. :)

> +    pub(crate) unsafe fn dma_map_raw(&self, dev: &Device<Bound>, dir: Dm=
aDataDirection) -> Result {
> +        // SAFETY: Invariants on `Device` and `SGTable` ensures that the=
 pointers are valid.
> +        let ret =3D unsafe {
> +            bindings::dma_map_sgtable(
> +                dev.as_raw(),
> +                self.as_raw(),
> +                dir as i32,
> +                bindings::DMA_ATTR_NO_WARN as usize,
> +            )
> +        };
> +        if ret !=3D 0 {
> +            return Err(Error::from_errno(ret));
> +        }
> +        Ok(())
> +    }
> +
> +    /// Returns an immutable iterator over the scatter-gather table that=
 is mapped for DMA. The iterator
> +    /// serves as an interface to retrieve the DMA address of the entrie=
s
> +    ///
> +    /// This is meant as a helper for other kernel subsystems and not to=
 be used by device drivers directly.
> +    /// See also the safe version [`DeviceSGTable::iter`] which enforces=
 the safety requirement below.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers take responsibility that `self` is already mapped for DM=
A by a device.
> +    pub(crate) unsafe fn iter_raw(&self) -> SGTableIter<'_> {
> +        SGTableIter {
> +            // SAFETY: dereferenced pointer is valid due to the type inv=
ariants on `SGTable`.
> +            pos: Some(unsafe { SGEntry::as_ref((*self.0.get()).sgl) }),
> +        }
> +    }
> +
> +    /// Internal helper to create a mutable iterator for the constructor=
 when building the table. Not
> +    /// to be used directly.
> +    fn iter_mut(&mut self) -> SGTableIterMut<'_> {

Just because it is private does not dispense this method from being
unsafe, as `iter_raw` is.

> +        SGTableIterMut {
> +            // SAFETY: dereferenced pointer is valid due to the type inv=
ariants on `SGTable`. This call
> +            // is within a private method called only within the `[SGTab=
le::alloc_table]` constructor
> +            // ensuring that the mutable reference can only be obtained =
once for this object.
> +            pos: Some(unsafe { SGEntry::as_mut((*self.0.get()).sgl) }),
> +        }
> +    }
> +}
> +
> +/// Provides a list of pages that can be used to build a `SGTable`.
> +pub trait SGTablePages {
> +    /// Returns an iterator to the pages providing the backing memory of=
 `self`.
> +    ///
> +    /// Implementers should return an iterator which provides informatio=
n regarding each page entry to
> +    /// build the `SGTable`. The first element in the tuple is a referen=
ce to the Page, the second element
> +    /// as the offset into the page, and the third as the length of data=
. The fields correspond to the
> +    /// first three fields of the C `struct scatterlist`.
> +    fn iter<'a>(&'a self) -> impl Iterator<Item =3D (&'a Page, usize, us=
ize)>;

How about using a `Range<usize>` instead of an (offset, length) tuple?

> +
> +    /// Returns the number of pages in the list.
> +    fn entries(&self) -> usize;

Maybe `num_entries` or `len`? The current name suggests that the entries
themselves are going to be returned, which is not the case.

> +}
> +
> +/// A scatter-gather table that owns the page entries.
> +///
> +/// # Invariants
> +///
> +/// The scatter-gather table is valid and initialized with sg entries.
> +pub struct SGTablePageList<P: SGTablePages> {
> +    sg: SGTable,
> +    pages: P,
> +}
> +
> +impl<P: SGTablePages> SGTablePageList<P> {
> +    /// Map this scatter-gather table describing a buffer for DMA by the=
 `Device`.
> +    ///
> +    /// To prevent the table from being mapped more than once, this call=
 consumes `self` and transfers
> +    /// ownership of resources to the new `DeviceSGTable` object.
> +    pub fn dma_map(self, dev: &Device<Bound>, dir: DmaDataDirection) -> =
Result<DeviceSGTable<P>> {
> +        // SAFETY: By the type invariant, `self.sg` is already built wit=
h valid sg entries. Since we are
> +        // in a method that consumes self, it also ensures that dma_map_=
raw is only called once for
> +        // this `SGTable`.
> +        unsafe {
> +            self.sg.dma_map_raw(dev, dir)?;
> +        }
> +
> +        // INVARIANT: We just successfully mapped the table for DMA.
> +        Ok(DeviceSGTable {
> +            sg: self.sg,
> +            dir,
> +            dev: dev.into(),
> +            _pages: self.pages,
> +        })
> +    }
> +}
> +
> +/// A scatter-gather table that is mapped for DMA operation.
> +///
> +/// # Invariants
> +///
> +/// The scatter-gather table is mapped for DMA operation.
> +pub struct DeviceSGTable<P: SGTablePages> {
> +    sg: SGTable,
> +    dir: DmaDataDirection,
> +    dev: ARef<Device>,
> +    _pages: P,
> +}
> +
> +impl<P: SGTablePages> DeviceSGTable<P> {
> +    /// Returns an immutable iterator over the scather-gather table that=
 is mapped for DMA. The iterator
> +    /// serves as an interface to retrieve the DMA address of the entrie=
s
> +    pub fn iter(&self) -> SGTableIter<'_> {
> +        // SAFETY: By the type invariant, `self.sg` is already mapped fo=
r DMA.
> +        unsafe { self.sg.iter_raw() }
> +    }
> +}
> +
> +impl<P: SGTablePages> Drop for DeviceSGTable<P> {
> +    fn drop(&mut self) {
> +        // SAFETY: Invariants on `Device<Bound>` and `SGTable` ensures t=
hat the `self.dev` and `self.sg`
> +        // pointers are valid.
> +        unsafe {
> +            bindings::dma_unmap_sgtable(self.dev.as_raw(), self.sg.as_ra=
w(), self.dir as i32, 0)
> +        };
> +    }
> +}
> +
> +/// SAFETY: A `SGTable<Mapped>` is an immutable interface and should be =
safe to `Send` across threads.
> +unsafe impl Send for SGTable {}
> +
> +/// A mutable iterator through `SGTable` entries.
> +pub struct SGTableIterMut<'a> {
> +    pos: Option<&'a mut SGEntry>,
> +}
> +
> +impl<'a> Iterator for SGTableIterMut<'a> {
> +    type Item =3D &'a mut SGEntry;
> +
> +    fn next(&mut self) -> Option<Self::Item> {
> +        self.pos.take().map(|entry| {
> +            let sg =3D entry.as_raw();
> +            // SAFETY: `sg` is guaranteed to be valid and non-NULL while=
 inside this closure.
> +            let next =3D unsafe { bindings::sg_next(sg) };
> +            self.pos =3D (!next.is_null()).then(||
> +                                              // SAFETY: `SGEntry::as_mu=
t` is called on `next` only once,
> +                                              // which is valid and non-=
NULL
> +                                              // inside the closure.
> +                                              unsafe { SGEntry::as_mut(n=
ext) });
> +            // SAFETY: `SGEntry::as_mut` is called on `sg` only once, wh=
ich is valid and non-NULL
> +            // inside the closure.
> +            unsafe { SGEntry::as_mut(sg) }
> +        })
> +    }
> +}
> +
> +impl<'a> IntoIterator for &'a mut SGTable {
> +    type Item =3D &'a mut SGEntry;
> +    type IntoIter =3D SGTableIterMut<'a>;
> +
> +    fn into_iter(self) -> Self::IntoIter {
> +        self.iter_mut()
> +    }
> +}

Why is this so far from `SGTable` compared to its other impl blocks?

The fact that this calls the above-mentioned `iter_mut`, which should be
unsafe, is worrying. Basically one can just=20

> +
> +/// An iterator through `SGTable` entries.
> +pub struct SGTableIter<'a> {
> +    pos: Option<&'a SGEntry>,
> +}
> +
> +impl<'a> Iterator for SGTableIter<'a> {
> +    type Item =3D &'a SGEntry;
> +
> +    fn next(&mut self) -> Option<Self::Item> {
> +        let entry =3D self.pos;
> +        // SAFETY: `sg` is an immutable reference and is equivalent to `=
scatterlist` via its type
> +        // invariants, so its safe to use with sg_next.
> +        let next =3D unsafe { bindings::sg_next(self.pos?.as_raw()) };
> +
> +        // SAFETY: `sg_next` returns either a valid pointer to a `scatte=
rlist`, or null if we
> +        // are at the end of the scatterlist.
> +        self.pos =3D (!next.is_null()).then(|| unsafe { SGEntry::as_ref(=
next) });
> +        entry
> +    }
> +}
> +
> +impl<'a, P: SGTablePages> IntoIterator for &'a DeviceSGTable<P> {
> +    type Item =3D &'a SGEntry;
> +    type IntoIter =3D SGTableIter<'a>;
> +
> +    fn into_iter(self) -> Self::IntoIter {
> +        self.iter()
> +    }
> +}
> +
> +impl Drop for SGTable {
> +    fn drop(&mut self) {
> +        // SAFETY: Invariant on `SGTable` ensures that the sg_table is v=
alid.
> +        unsafe { bindings::sg_free_table(self.as_raw()) };
> +    }
> +}

Ditto.

I actually have some more comments, but I'd like to understasnd first
why you decided to drop the typestate. If there is no good reason, I
think I can provide a more detailed explanation about the design I had
in mind when thinking about Lyude's usecase - basically, a two-stages
typestate SGTable type where the first stage is unsafe, but the second
one leverages SGTablePages and is safe. But going into that explanation
now would be pointless if the typestate cannot be used for some reason.
