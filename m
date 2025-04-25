Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2014424BC1A
	for <iommu@lists.linux.dev>; Fri, 25 Apr 2025 13:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745588568; cv=fail; b=L9of0MKQSyahV5Blgf0xiYc7Kzz7i0FD+/f+IEVQMF5KxDGNz8SxJKYMhJRaCZrcLI1R7JFrt3/vkV8FarnnA+deM78rv787/7CXZ0h/W9Ey70FgYtLceApvFe58e4faQHPJ8XLtMLsJv/4xPQKXnwlrZykwJLiMe13NCVumjLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745588568; c=relaxed/simple;
	bh=D2lbipY7SQYln1K2mR/0yiWGtt3XixfnnygwAcsA9rI=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=PUY+euN2zS3T6oIkFVXf0jspQuavaQOV8R9U7w3EGiZrREtsZHtphiop9RrQEBaRHnbGS2K6pXd7hhLWFYhZvqgi74xIm40OWF60sZxkf2AYauW+4tM1+1NEvo+XLIxedf95tD8TJebEH6yz0kgXrxWPyrQuPpwBwt8f5OqC1iM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ixIyuEax; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ixIyuEax"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UulVeGNq7nSubGi7Kx9REUegOJGpDlBGE0yBIUoYkkeXCACc2H0b6UyyJBdATKmAkyHllc5MEecsHZe9HyD4/RmWm8jlzqAk8Q8mayWhhiIAYaQR6m9EpIirLma2Ky7izNHE8/v3mTjPa5hQTjuSQxkWGBtC3SQy19sbaNh1RQXks7kw6znUUB3SVBWzAF9SiQrfdM3t6jwl255qbc6KzRFs39gCAxbEOuqM4rekZ1Fd1+CV2FffTUBN+gVCx8rR7fJDBaOUAGz1i2/+FUVFXmnhx4exVnDMvXQyZwcIEaWkvrd7Z3kAjA0N+wyeEeUrJDkjhz91M7P56XBVPk719A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3oz69+hglxSJeYlzyXeEsg9BIqvaPX8+MQuaU3RcZQ=;
 b=l/ytJoDldZ/VS1qUA3sFtrDii4whnTI08JnkbDEHwOg/Pyoqx+kfE0K7+2W8K+D9FvhEUbbu60h6OswJ2fQ9YmAipRzzJuWt1SevPTKBVWStO6m3w5xE6tDGudo2dlMaTvKQ7dR23mPxV6bfhyiukl5V2EhjHXzpOdFFafMvIff9yoz4Bo3GCN2ZwKYGpiloIFMssICtv5t0YdtiZI4A7rGtinHdHJpqDMyI/UWNIEQKtEeodPX5yuKWFcbHUJkxRa/K4u93tuxcjxjfiFPnohp6j+NVpYdmgVMwi1PTk6MVzyRksoAI4DFhNQrObtKnrucSM8arIMUP7NQRv+8wOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3oz69+hglxSJeYlzyXeEsg9BIqvaPX8+MQuaU3RcZQ=;
 b=ixIyuEaxZ5jeMXw/Y54Q6jHimi5MmRcXzOgyq02x6mQE1S9giI9Io7FzANet7C9WGvhjVV4yyLNX4M+wuCZKvBYsF/PRzpcTUolBxoLSs5ed2LAI7XpZRwWIsU7Oio3Aw5GhqsAx9iiS100NF6LytW7s5K5t9OvVPlCun6qnhhVKAMNPvaGGHTjNwoqalU/QtTSexv88auG+lH3iAjZaQKFPVI8g3tnc/f0rC5BYuJ3eMz+R4VDs3SZGkv8jfJ2wqyG6xuY3FYA6ImGkCYLAlGHuVNF207AnO9G2y5H9+wZtodQaXCxwVp0DX71Gm22gU4XAJUH1ucUq3rZWJOQmdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW4PR12MB7240.namprd12.prod.outlook.com (2603:10b6:303:226::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 13:42:42 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 13:42:42 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Apr 2025 22:42:38 +0900
Message-Id: <D9FRI153JFV3.2GQMZK8FCEV3C@nvidia.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Valentin Obst"
 <kernel@valentinobst.de>, "open list" <linux-kernel@vger.kernel.org>,
 "Marek Szyprowski" <m.szyprowski@samsung.com>, "Robin Murphy"
 <robin.murphy@arm.com>, <airlied@redhat.com>, "open list:DMA MAPPING
 HELPERS" <iommu@lists.linux.dev>
Subject: Re: [PATCH v3 3/3] rust: dma: add as_slice/write functions for
 CoherentAllocation
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Abdiel Janulgue" <abdiel.janulgue@gmail.com>, <dakr@kernel.org>,
 <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250425073726.1027068-1-abdiel.janulgue@gmail.com>
 <20250425073726.1027068-4-abdiel.janulgue@gmail.com>
In-Reply-To: <20250425073726.1027068-4-abdiel.janulgue@gmail.com>
X-ClientProxiedBy: TYCPR01CA0069.jpnprd01.prod.outlook.com
 (2603:1096:405:2::33) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW4PR12MB7240:EE_
X-MS-Office365-Filtering-Correlation-Id: 33136813-9168-44c4-e28d-08dd83ff0cf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzEyNTJNOUhHK3h0Qk9jZll0RVcyYlQ3Q3FOS1U2Y1FENEp2M0dxRDZCcFM5?=
 =?utf-8?B?bHJjWFkzZ2xyVWFuOFRvdjVwbzFsaDVxNjVUVytGTkJkRVVyVGM3UWpwdG03?=
 =?utf-8?B?NnppaTdXWHlQS01vS2JkTzF0c1F5cmtEZ1FsVTVTNU1SUHBZU0RDSUZjdVdI?=
 =?utf-8?B?QTNzK0UzY1Z1anViUzU1MVVJbkVoTHBzdldQblYrVGR6aS92d3N2NU5zNlZM?=
 =?utf-8?B?QzRXMjlOZGc3enRuYTJpaVoyUHdReFlmRVp3S1Uyb1daZTdNWCtJeGFmRHNp?=
 =?utf-8?B?eG5WbU10ZGlmUy9tcTJ5ME5OWWRlaUZ5V0hQbWt3a0NieEQ0QmpVUTNHOCtt?=
 =?utf-8?B?c2JMQmJvd1A4YXZENFpxcHAwZXZMb2xoT2ZQclZncndRdFpwUldvTU52LzIz?=
 =?utf-8?B?RWRSaTB0Nk03ZEJKRHFOVm5BTnVhWnREcSszOERHNlFQQnVLVThnWWZWWksr?=
 =?utf-8?B?Z2ZKbzRYRHdlVHpPQmdHNGRUR1NQY0wwVHJDZFo2aCtuczVZcERXUEZxU3ha?=
 =?utf-8?B?bldoeENOZ0ZCMW9ZcDdyaEVIT0x4UkhISE12SDk3Uk9WbXFIZXZEODZJS1ND?=
 =?utf-8?B?bmJ1MkdmOTBQYUMwRTBCQmRHWUdmN0JYMkp5ZGgvSHBlQnBkUERRZE9IcXRY?=
 =?utf-8?B?NmNKQlZaM2FaazZKWWUrK09QaFpHbG9zNVF2M2RyaUVCTjJ4cVVld2Fna3lz?=
 =?utf-8?B?ZFNKTjUrY0JJUjJlcHpSMXZ0THArNXMxUmx6QS9HSFNUYlhxcnNVdXF0NFQy?=
 =?utf-8?B?aEdDY2RsdTErUHpITW9lNUJ5TjZuSWVUeUtqNVNxbENQK3p5WUtXTEtKbmZH?=
 =?utf-8?B?OVpSUDREdjk3THNuSytBc2hXSHFXSmk5RS9jdFZvelBkdVhYQUNpc1p0Ykh6?=
 =?utf-8?B?SnhWd1dLWWlhOVdsVjFDK0IyVXJTRjRDa1E1K0hST0h1aW11VFZ3KytmY0FH?=
 =?utf-8?B?elI4a2RzTDgvL2xOTDNSUXlwd2IxTlhQTkFTNUFFU2QyaFNXUDU3N0JnY1Nh?=
 =?utf-8?B?V0tETXVwWUpzY2RxRTl1WFBpaWxTekQzYlY4dEh3QWkyVW9tOElTZzV1UXpn?=
 =?utf-8?B?Um96b0I2T0NJK2F6TVNEZG12SGJ3UUhXVDZrbjViYlFINSttZFhjU29JaWtG?=
 =?utf-8?B?TXNkelhEME50bjByMTJFeG5pR040Z0FUWnIvbW5ZTitBM1BSUzEyWUxhOE1U?=
 =?utf-8?B?SEJwdXFzdlptU05xVStEL1pLZmVVQUoxdlYvWW8zV2tPR1VGU21wK3FYZWN0?=
 =?utf-8?B?SWt0RnZzZlFES05LSlpmUEVHZTRKSTlXS3pGcnFHUXo4b1hJNjdyYUo3WE1J?=
 =?utf-8?B?SGQxNUduWHVGZnNpd1VQQndvVExpS0ZKN2I1VmFXbzNjSUcvNjM0VkpzcFph?=
 =?utf-8?B?V1VhNHFIbWJzelUwWkowZHdoWjJ2a01BMEFoQ01UU21JcFBjWnJqQWJTSlFY?=
 =?utf-8?B?Yy9udmRIQ2JMS2ZjdzRRbjdoUkxSSURhNUMySlhWRnUyNXRzT2lPdS8vd1Bi?=
 =?utf-8?B?Y0d4NUpQQjdaTjJOYzVSVEk3dUNJN3Iya2RoZ2xHajZMWU45OElKYzJGVHBi?=
 =?utf-8?B?ZDZweTBKd3AxQzN1WHZnVTl2N0xDazhzTjRXeng3bXVGa3MyVEZCU2I3MmRn?=
 =?utf-8?B?U2h3cjZ1c2lBT0V5MjBSRzFSSTVBcWw3cTRYcmp4bkttQzZnZmxIQ2lBRnkv?=
 =?utf-8?B?RFRrS3dQMkMxZmlCbjZxdE5wWnNGNjRQczJYQnl3TGNSUWdMNmt6eXExc0Zk?=
 =?utf-8?B?U3Y5a2cwL2ZYOXNxd0JaUDdzVFRabHJ6Q3c5N2JRZ1RwdmNjUGxOUFoycGdv?=
 =?utf-8?B?eEVmdlBFSjhybDdWeENGUG1PemR5dUhiUnNESzkwcmVOSlZiNnRwMG5nSlVL?=
 =?utf-8?B?QzBvN0hzQndUaGM0cmF1ZEJoU1hOV1lQUWJXZjAvVWNxaXo4TCt0L0VKWFls?=
 =?utf-8?Q?mJHPLmos+QE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akJWcnpZaE1ZaHVLaWl6bHJpY2srRi8rc0lDYlpzQ25nSWtrSHArd3I4ODlM?=
 =?utf-8?B?QWxMSHp2WmI3eTZ5ck5rNHl2dTRwbGpFc293dlRtR1JpNEo1d0NtM2hRMzg1?=
 =?utf-8?B?bU1QNGtuUGRhM1AvNVBRMGxOTDVZRzRscUh2QVMwL0lndlNQTEFvbFZ3M3Er?=
 =?utf-8?B?cHViUmxGUnFWUEtmSmt6T3JqUldMMk9FbWtuVEU0OWc0SG9MZy85YThIaUk0?=
 =?utf-8?B?U2EycmRzWFhESEVJQUs4cmkwYWVGU20vR0ZmRWtsWWExeitUc0pEYnpmZG15?=
 =?utf-8?B?bXFVUE9kNjBxeVh0NlZaVGRXNnFveUFZZ2xVUHZNSjErNHIxVURXczRTaDBT?=
 =?utf-8?B?Y3pmcTFwSkJPeE9wMTdDRURObFZNTWMzeWx6SlA2NjZ3NDFoTkVJd0hQNTVi?=
 =?utf-8?B?N2phd3FLQjJLNTdrVWREZGdlTWh3TnNLOTZDQkVSSG5EclR5elVJd2tsSEdH?=
 =?utf-8?B?eTZLR3dXUFpsY2toL2dOVmpOVzViTkR6cm5YdFdlQkEyOW9Xcy9kbUNzUmpP?=
 =?utf-8?B?NUZFbE5URHVqUGdxMTBMR3ZxVjBONlJ6MGMxb1RWbStQcU9lMWt5b2VBNGdx?=
 =?utf-8?B?QU1vNGdlMnRUNjEwNjdBREhrRkYrK3YxbDZsVms4OHpuRDNxbkVLeW5WbkVt?=
 =?utf-8?B?dFRHakJwL1kxVWdJbTZROXRxYkJKajFscys0STRyaUJaOEN6M1NMbkRFTDM5?=
 =?utf-8?B?dUNRQXk2a0RVcU0wUkMwM29TeWVSb3BaSWYxb0dxVGVNNjZuNk53OUt4Y2Y4?=
 =?utf-8?B?dUxMMGRPcEZSSnZKL3ZIMzRMUWdwMTZ1aUxFY1JydDZTYnRpbGdTSWc3NmRY?=
 =?utf-8?B?SGJhYWtjMTlyR25YUVpSWlhrY0UxUE1KNkRrVlBVRFRQUFB6Y1RGbVdWSnA4?=
 =?utf-8?B?Y2VvaVJCaGFSYytCMWtNa2NrcTQ3SGM3MWxnN21QVkEvYVJwdCtpR052M2l5?=
 =?utf-8?B?ZnVPd2xUZk02MU1TaUtGVWtYTTdLYktYZnBDdU9IeVhrSDRwQ3pwSjN6NitN?=
 =?utf-8?B?QXlyUGhUNW1HeUM0eW8rQkhJM3RKVmw3ZmJhTnhaV01GZFNpSjlTZEZDVDlJ?=
 =?utf-8?B?RGlEL1YyZVNXclRtWVNaZ0M1VFJYQkVaQzdQT3RxQXRielBwOVJqaFBmYXZZ?=
 =?utf-8?B?MWJZeGJOQlRodW1CV3UzSFY5RTFKRFAvaGw0cUdUVUwwNXo2akdJSDQ3a01y?=
 =?utf-8?B?cG1PZDlhUFdIMzAzd1k1TkJURzFiaEJCL25VS0ljWkJReUYwNWpiSWNjWUl1?=
 =?utf-8?B?SjBZdCtyMHZXbjJVTGtTckpPZ0daUTA0VGlkZUc4N1VucVJTb3VOSWxsZmRZ?=
 =?utf-8?B?VXlFVG9UU2ZrbG1KRXNLYzR4R2puOExMaGlrcE5uc0xjWHVRUUJEdFQya3Nq?=
 =?utf-8?B?bGw1ZkVOM1M3bXdMUFhHclR5bitWOC9pSUJIaG5qRXJVVnpMeWFaWVZYWFpz?=
 =?utf-8?B?VFE3Z0NYZHMzSHplN0tudy9sNEY5d1lWTFJBaFpSNEY4bTZXZzZXQWw0US95?=
 =?utf-8?B?dHVaZ1pGc0ZKSlZBbHpLRnI3WkcyYmtsUUR1R2JUaVVIbXIyVGNkb2krd2hq?=
 =?utf-8?B?a29MQkFNQXNaeloyUWR2RHNBRFd0akdCQk5NUHFyWXNqZmVVcHRybWhPTzFF?=
 =?utf-8?B?MGYyT01JcHF0OHVCOWpGRUxGNWlsbG90ZFVQM1RGQUF1R1F3RXh5UGZlbjZX?=
 =?utf-8?B?Y1lIaGkyT3A1eE5WR21lRG1xT0k2N2Ird0RLOGtGdC9XZTNCajNNbzJqZ0hQ?=
 =?utf-8?B?dVYyYUhwbTBPNDBaN0kya3ZLMEdHdWNVdkNPL3FWVHF0cEl1MEptaXBxY2Ns?=
 =?utf-8?B?TGNYejBrKzVPZFoyWmV5cTFYb2pORGFvUkF3Ym1QMUhFb0pRdEJjcGkzaXh4?=
 =?utf-8?B?L2pScmE5Y0E4NVdVK0hIOC9wRFNQeEdSWk80SSt4SFk5dEM0T3k3M2dHNXo1?=
 =?utf-8?B?bHBQdGxkand0Mm1RQW8yZXRYTXFRZ3lveE5SZVFtNFJReStFRkN6T2hTSi9h?=
 =?utf-8?B?VXN5VTc5Um8xWFdZVXlPRjBjNEQzejJiZlBtV29jbUpIcmo4QmdOcmlBdlIv?=
 =?utf-8?B?cVNucFRRVDU4cUlqU3JiTVl4STYvVWE5RmhNZ1VyaTB0RjMvS1F2WXBaMElh?=
 =?utf-8?B?dVlmUGhUeGJsd3NUKzRmTy9QYWhCVXJmaHE3S0ZqaW5tYVlmVWQ4c0k4cXl1?=
 =?utf-8?Q?KlJS+sHo9ZeXud0g9OcjPyIQ+dw9Zz4KAGLsr7KN1xMJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33136813-9168-44c4-e28d-08dd83ff0cf3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 13:42:42.0983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b0c7U+JCswrcScopLxu6sCXQmB2n391o+nYRyjFraYgjxhIvCUcREWp4ep6UmT/6nFXyxK3CaDeroYHhfVWDLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7240

Hi Abdiel,

On Fri Apr 25, 2025 at 4:35 PM JST, Abdiel Janulgue wrote:
> Add unsafe accessors for the region for reading or writing large
> blocks of data.
>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> ---
>  rust/kernel/dma.rs | 85 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
>
> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index a61da5eeb017..e01bb7e7c440 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs
> @@ -218,6 +218,91 @@ pub fn dma_handle(&self) -> bindings::dma_addr_t {
>          self.dma_handle
>      }
> =20
> +    /// Returns the data from the region starting from `offset` as a sli=
ce.
> +    /// `offset` and `count` are in units of `T`, not the number of byte=
s.
> +    ///
> +    /// For ringbuffer type of r/w access or use-cases where the pointer=
 to the live data is needed,
> +    /// [`CoherentAllocation::start_ptr`] or [`CoherentAllocation::start=
_ptr_mut`] could be used instead.
> +    ///
> +    /// # Safety
> +    ///
> +    /// * Callers must ensure that the device does not read/write to/fro=
m memory while the returned
> +    ///   slice is live.
> +    /// * Callers must ensure that this call does not race with a write =
to the same region while
> +    ///   while the returned slice is live.

"while" is repeated twice in the second bullet point.

> +    pub unsafe fn as_slice(&self, offset: usize, count: usize) -> Result=
<&[T]> {
> +        let end =3D offset.checked_add(count).ok_or(EOVERFLOW)?;
> +        if end > self.count {
> +            return Err(EINVAL);
> +        }

Since `end` is not subsequently used, how about reworking this to avoid
declaring it as a variable that is visible for the whole method:

    offset.checked_add(count)
      .ok_or(EOVERFLOW)
      .and_then(|end| if end > self.count { Err(EINVAL) } else { Ok(()) })?=
;

Or maybe better, move this into a private helper method:

    fn validate_range(&self, offset: usize, count: usize) -> Result<()>

that you can call from all three methods requiring it instead of
duplicating the same code snippet (in that case, you can declare `end`
if you prefer this style as it will be useful for the entirety of the
method).

> +        // SAFETY:
> +        // - The pointer is valid due to type invariant on `CoherentAllo=
cation`,
> +        //   we've just checked that the range and index is within bound=
s. The immutability of the
> +        //   of data is also guaranteed by the safety requirements of th=
e function.

"of the of data" sounds like a typo.

> +        // - `offset` can't overflow since it is smaller than `self.coun=
t` and we've checked
> +        //   that `self.count` won't overflow early in the constructor.

IIUC you rather need to state that `offset + count` (not just `offset`)
is smaller than `self.count`?

Same comments apply to `as_slice_mut` and `write`.

Cheers,
Alex.

