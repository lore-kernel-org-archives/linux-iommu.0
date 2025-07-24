Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2076.outbound.protection.outlook.com [40.107.100.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA37917332C
	for <iommu@lists.linux.dev>; Thu, 24 Jul 2025 05:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753335651; cv=fail; b=XR0PRPJxkIAL4sKV2JX2K+MPnGVEn9TBnnhFRwf9vQ912fa3Xgtci+WCi0B8kyv0VRfR31l0Mp/X1nfcsTLWotqD+XHg6lPUSd37qGLC9LC5bW/tzvNcPSUJn64o7iJo6jzYTxYJdimrV6y9uheEz+tPZFRmTnH7h1NRnFB3fEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753335651; c=relaxed/simple;
	bh=YeGFGfhH0uLDyC+zO06OQOHARJ2dgggd1JZXAkvuObM=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=Oj7lXtCUwUlPmX0STMyQSqTp94A/Fu5RVg0SqD1crOU9Lw0Lwd6yA30s4vYgx/xpCJDx0OTxKqsFxZltkBz5cn46J96ZEtpusaFWQz6gGUAchz/JTPtonPEqCQXZitjukgr/gpdYK+TTA4u0b1As0+GPYsHuzVAEqwVVZyqBF14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rzzT+gKv; arc=fail smtp.client-ip=40.107.100.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rzzT+gKv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PjbJUja4HClIU0n/UM9vWEOB+iv/IGhTD+HCCvGrJ9qpPwAUCMjuHXGyQ/EhS7fFttUakqu8d/T7OYf6rtzvRu2CXAHA/v4h7GRhDn0DU4e6k/V211fEu+w4OlO94PcWGGGkaTdS12kgthHB2kpBLNVU8+LO6e0P3IrMPmIDP9X8V9QrtItkIcbNJO5YYEEF4q1e7/80l13iR8N6Jgm/6q1piO9mn+NW0vwpTTC06pORhw+WJMXooZahWF5UX3xa/oc5h410Qqaj7dO6RFdCLUASKI+cNe7CQ/zI7uxNkwEcdruWips26FBjPB3UjB/kq8rMVBANNbLeB/YleDbvLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dvK3ZrjIiK5+clbp48R3V1hlW/Bfb1p7uBkxMDmxgU=;
 b=QbBF5Ejl4SbkHPnOHhXdfBbghAUOAjdzKvNOn4bOHpoO54zQ6y2h+H/INPIuLFx8n3DDw61xZzJg9gRsy7/Ga2ZYPyWU/0SdusFEx8JkBUXSP2jxjm5jv525h7EHdqCx9FNsZlk0P2Io9uGjZIl0QBNqpy329krNNHgIHdFr3V0JXaKsNBn+wCTP5Z3fVThiHNFGpDvMi74IFAy4q4MvFlyzwGAgSoeVnLuZS5FsxrdFnTf3T1NwIG66Qr3msmQvYJNDMVW34ik0lk61CVrR98rO/Sbcjl3Nh+bUE3uJdg231eilSOgywV2CWa6lz0ucmgDnVDqgMJa1aWolX5su/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dvK3ZrjIiK5+clbp48R3V1hlW/Bfb1p7uBkxMDmxgU=;
 b=rzzT+gKvK1NpMyujiwe1bUGgChqDUNWbH48HtbWH9m6kREEiVNqgaBagnj13sUvUAiBbhxlPqOL5WrBmJkcCrOAURzeoHPHMdX9e9/qHebwgETlin7tQjimfxMDjzNPmvd8NPGplsmmCcHyONTBNMIO3+bDwCkDobVBFio2Jrdfc4MG570ggYruCg7fInotPyBu+0noJJx0FBEvW7jttwZ1FZvvKV/kJMg1s30bL3PtUvAoQHKl0rC3KfXyzuZoUbhAYxNTOEXQ0NIywn44UQfK+dIBUU5xsOcNKWknpanNOOj8I7C5Ku3PvZb9CvTGQZfUH6IFEfjAYlfKkNARdbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ0PR12MB5610.namprd12.prod.outlook.com (2603:10b6:a03:423::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Thu, 24 Jul
 2025 05:40:42 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8964.019; Thu, 24 Jul 2025
 05:40:41 +0000
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Jul 2025 14:40:37 +0900
Message-Id: <DBK1M000P87N.2HJHDJN1LG5CA@nvidia.com>
To: "Abdiel Janulgue" <abdiel.janulgue@gmail.com>, <dakr@kernel.org>,
 <jgg@ziepe.ca>, <lyude@redhat.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@gmail.com>,
 "FUJITA Tomonori" <fujita.tomonori@gmail.com>, "open list"
 <linux-kernel@vger.kernel.org>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Randy Dunlap" <rdunlap@infradead.org>,
 "Herbert Xu" <herbert@gondor.apana.org.au>, "Caleb Sander Mateos"
 <csander@purestorage.com>, "Petr Tesarik" <petr@tesarici.cz>, "Sui
 Jingfeng" <sui.jingfeng@linux.dev>, "Marek Szyprowski"
 <m.szyprowski@samsung.com>, "Robin Murphy" <robin.murphy@arm.com>,
 <airlied@redhat.com>, "open list:DMA MAPPING HELPERS"
 <iommu@lists.linux.dev>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] rust: add initial scatterlist abstraction
From: "Alexandre Courbot" <acourbot@nvidia.com>
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250718103359.1026240-1-abdiel.janulgue@gmail.com>
 <20250718103359.1026240-2-abdiel.janulgue@gmail.com>
In-Reply-To: <20250718103359.1026240-2-abdiel.janulgue@gmail.com>
X-ClientProxiedBy: TYCP286CA0271.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::16) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ0PR12MB5610:EE_
X-MS-Office365-Filtering-Correlation-Id: e1a7471b-f1c0-4e0f-a0f8-08ddca74a041
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VndVWHVQOUZmM0V0bDRlZFBDbW5jUEhzZ3ZYMmhQMUtRTUsvdm9IN0UxWjhS?=
 =?utf-8?B?ZHpyUmxRMWFaMTZETVRJT1FUMXlDWDVXZkJnRFJRMU5VSXFLNWExK0ZRQTdT?=
 =?utf-8?B?MVYvRzlHNU1zR1VDUGQvaWhwMkFpTE5DQk85UDY2RzZ3ZTZMakRmTG4yL04x?=
 =?utf-8?B?bHZkZzVkRWpERW5lZktweFg4NUpQNUR4K2RrR2VRVjNPVFBsM0hrUHg3ZVN6?=
 =?utf-8?B?eHB5cVhjWnMrZ2lzOHltTURGN1RURTNPN0k4bm1UMkJDL3BKUHF3d3pxK0NY?=
 =?utf-8?B?eTl0YlA4Vnh2dXlKMVlkZ2FjaThadXB4RTA5QjVPa1dKNjJlWEowdDhFTUVN?=
 =?utf-8?B?NVNCclp1VTk4aGJlYXhiczl5cE1HWGZSN0Nmb1I4T2haZlAveHRUVS9PeU5i?=
 =?utf-8?B?MmRUUDhaZFZxNEdud2E5WkV5RnVteUF6R2pMUWd0SXpReUZxc0NRM3B5UFJT?=
 =?utf-8?B?STc0a0tkV01uMU5TUHV1Nk1qOUZNUSsyUjVVWmFuYXgyUEdERTVTMEd3S1FT?=
 =?utf-8?B?b1BlUm1PU21BOVdlVTk2NVc3MDFTNTJnK3BUUFBZTWY5T0dYWWtoL0c1N3o2?=
 =?utf-8?B?TFhWc0l2VmE1NXc0UEt6K2MzVFVteVN6bXkwN2FVR2N6M3N3d3l0eFRwS3dF?=
 =?utf-8?B?Ulk5aVkxU2xOTHhwdy9iaFVlK3BRV3h2cU0xcFQ4Y0tvL0Z1RXlvUTNJbUVt?=
 =?utf-8?B?cDFRQnpoL3lLTHNpYTIwbzZnTXJLRTM1dlJENHhlRUphdmlIM0FHU0JwTzcw?=
 =?utf-8?B?YkN5WWVKdlk5bmJZTFdPOXhTSVh3b3BoYWZLaGcrWnJKR3c4RU9LeVd5VnBJ?=
 =?utf-8?B?N3NWbFl2aDkvODd1S3dhK2JEWGJJcXhKZDVkSURsbVRKaDBPYXdaQ2NPSTZE?=
 =?utf-8?B?c1hnSm5TKzhjRFZTVTUwSzR6MkwwVlR1UngrbVM2dUNla0pPclhNWEZ2VFI2?=
 =?utf-8?B?TXR3L2RLRnpiMWlHdWQzNS90c1k1eTBreWFBTmNGUEd1aGJsUGxGeitFdFBY?=
 =?utf-8?B?SWNkcHlPa25hWUh4dGp6dXVIcmNzWUluM2RCMjJlVVh0RUJhUFZvRmk3aGJB?=
 =?utf-8?B?UTlBQzNoVWRxYXBlV1FkZkpRQzZWcHdnM0g3d3B1OE1ScVFCaWRDZFIrVHVF?=
 =?utf-8?B?djFiWWNIeTVZa09ZZ1IrSGwwZWhlNjhUVEZnNDVMMWNCS3VQT1dYTXNjMlFI?=
 =?utf-8?B?WGVPaGJNZzFocVR4MzdaSW9meFYxV1FnYnFnUEhkRU9SZnprV3dKZXdpTTR6?=
 =?utf-8?B?SG9mU0lYVkYvNmZkOEEzdDd3QWxDY2pyMUJ0ZERTS1pMOWhUY0FReG9yQVBl?=
 =?utf-8?B?c0JESUtkRHZWVmZLQTFXWWYvbXF0U2svUEZxM0U2Q0dMYUgybUx0T3VqNnFx?=
 =?utf-8?B?Z083aVkvcmo0U2xUVWtMMGM5ZVg5SWdmWGhjaWE2RXF6dFhzMTNBOVZFTkdl?=
 =?utf-8?B?SlllTUhobm01UTloV1JqUVFMVW5RbDYwL2NEOVVwUVhINFM1WC9Fbm81c2kw?=
 =?utf-8?B?UU5iTGdCRnlVN3RCNFdiR3c1ZVJ4TlVZQ0FQWUJJR3VrUmZ3ZTFabWtQNXZ6?=
 =?utf-8?B?K1JnaHllOE5ra0NTWXRBSHl4UVJWRm51b1FMVGZna1lqcTNBWUdjRWIvZ2x1?=
 =?utf-8?B?K2RxbHcyK2Z0Y1poOFZ6MThESldEZjJSNWJTVUdFVUY1U2dBN3IxeGgyZGlv?=
 =?utf-8?B?N2pOQUtOUDN4dWc1RDZ3L2VRVkI1bVl4Y1F3OUNBcStnRUNUZzRrYWtlSDZz?=
 =?utf-8?B?WXR0VkQ2ci81OEFvNGVYTXJRa0VkZ0NaZll5dDR3ZWZvTmk5VE5TUXZkMDdQ?=
 =?utf-8?B?ZmpZS0tSSmowbnllcTVMODIyTEx4QWorNkpOeXdGbjNDQitENitUMlUxV0Zv?=
 =?utf-8?B?UXZ0ekJpczZwS3NYZ2JuaXc3dk1hdnUvL05vK2VQVEhUSVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHk0TTNhbXJtR2FXa3hKQWY4ODhmaG5XMWhibWxraW1WTEpSTUh2ZDRPRzFn?=
 =?utf-8?B?ZmhDMG1ndG90SW9VVFcvVWpvczZOd3hWUmh5VFNQdHhTV29RS3R6N3J4Mi9I?=
 =?utf-8?B?SWZEcjNocHd2UUpjaEsxRmhubzBIbjE0THRXelp2aGtIcFhBWVY3SkdNb09B?=
 =?utf-8?B?eTk0NWpDMmFNYmlESFVQeGhoVjlrU0FhcGFPQ2JwbEhJOXBrelhUTnkrVHUx?=
 =?utf-8?B?WFRib1M1TW4zSVFaMGZYWitqc3J6c2RLcmRJRnI0cUVsRzdVSy9PdTdVVi9W?=
 =?utf-8?B?a3dPVnFxWUFnZjg4OVdDNGRsdm94cFlwRnNLb2NjM1pPempFeGpFVW9XV0lF?=
 =?utf-8?B?YmNSc05GcnloRU5RLzl2aUl6Yms4eFZKVUJyS3hzOWhzN01tVlUxZ2RlbjJM?=
 =?utf-8?B?VWhHTUVvRVhHQmR6eFplYzRWZUQ3T1I3eUtDalBVc3cyVFBIN29KQkgxK2Yv?=
 =?utf-8?B?eU5XbW4yMk9IN25mYk9YSXByODFabEdYSmVHZDIxaWFJL0s4VGE5dm0vM1dJ?=
 =?utf-8?B?d3JMTVVWZjNJU0dRd3gvNDhuUjFxM2V2SmEyQkJkb21nODZxMStJSHZjaGx2?=
 =?utf-8?B?SlhrVzJjMm11eUE2YmFyZE5MRlNWRzBnazJ2RjFOUXU1RFVvUk9JeWxwYXVm?=
 =?utf-8?B?U0tjM1d6Z0EzZ2lNSmtNSGpjYytmcDd2V1JJdHFxQ1VrMTRXT3dXTFhsNkFP?=
 =?utf-8?B?Z2JNWmd3bHdoOWh0SmNTWkZwb0w5QURIYnpJOGZpbitrSk9rTHVLL1VKWWJz?=
 =?utf-8?B?RDl3VmdOcmI3UDl0WHFvamkxc0dyeU05czV1VjFzdkpVZ21jVlN3TnhqTEJW?=
 =?utf-8?B?eGE5b1pFRUVtdXFFdmN5dGcrS1MvRVBDN20xZHFsTE85dUlDYUJLdUpRWVBK?=
 =?utf-8?B?UlZjZkFjSkNUVHBWSHNROVRTNjlCcTRkOEkwK0RzWmpRcllSRXk1WGRIT1NK?=
 =?utf-8?B?T1R2NjFFQURFZnJxL0pmMXcza2VjTlJ2QXAySFZZRmN0MmFXZ3pQTGVaSXlN?=
 =?utf-8?B?a3hwVTB1czh3d1ZLU2FxRkl6dlVvZFlhQm11b2ltY05YR2J4K2h2ZVFzZE9W?=
 =?utf-8?B?UVFEeFplVllxU213SzZDMXlQTmoremNJdUdpbld6OUNTNUlJajZ3eFNrTlhG?=
 =?utf-8?B?YklBVWJxSWs5YWNnUkdFTmNJVElJSFZDcDkxTUNWdUpESFBCUmFaT3hwVFZL?=
 =?utf-8?B?a0tudVFnd2UyZmlKVHd4UjN3YXRtRXNtbU9pVWJjbDVLNFQwdlo2S3lFUXhj?=
 =?utf-8?B?SERzYnJZdUF1T1pIUnQwQ2dlVlVwemp1eFdwOVZlekxYc1drOElFWVRFUTBD?=
 =?utf-8?B?RGpiODlMdEppcHBpaWVUZFpveVN1UHBXZUhidlNIc1pMUWxRZVNKUTlSOFVx?=
 =?utf-8?B?UnpKUmtoOTdVdlovV0haY3BadkFkcXZndjV4WlU5YjRTRVRyTWV0cXhRWTV2?=
 =?utf-8?B?TVpqSnhOeUcwRGVWSGtYcFpEdGpXck80Y001K2FjU0ZPNTdrc2JLdnNJTUFF?=
 =?utf-8?B?eGNNdTJLem1laWVlV2VoVUN5cDV2VlIwZFVKaWwwQU82dkhuNmNPZ3pWNzBw?=
 =?utf-8?B?ZmNFYTJ4WU9SeTM2ME1TV0puMXdKR1F5L1oyNUtmbTFoK0ZKYklLMndkc2Nu?=
 =?utf-8?B?SFdjTUdRMU9IWWo2Y0NIenVDNE9uVXNzTzc1THhrYzh0em9IMkVJRG5pR1g3?=
 =?utf-8?B?Y3NZYjZOZkpZZFhmS3lxVDllUWpWS3hMdzl5VU5LQzlYRHIxVjY1QVpyT2cx?=
 =?utf-8?B?aVU2cXRSQzZrUmRzWHZLYzJBWGhQVWlhdmNyNXlyeFpaL1V5S3UxWnBjRkJh?=
 =?utf-8?B?T1JOZWZJb0xiVVZpR0Y5elgrVzIxRDNXREdlQ2hWSkRwVExHMXlUNlluNzFh?=
 =?utf-8?B?V2NnaWNZZmw4Q2Zod0RxbjNsbW9rNjFhSjBzTkFUSXFqU29Wa2JxQWViUW40?=
 =?utf-8?B?UlRvS2pHakRYVUF2R2FvbndwQjczekxWYzVLeExaTlFqc0hTRUdMUGl1WEZt?=
 =?utf-8?B?T3ExTnlETzlnMW9yeU1pOFVHTG90OE8xaEMzQU1Ea2tWQWlRNzFQRVVlMEZy?=
 =?utf-8?B?cCs2RlppZE5KdnhGcGs2TUlyN0VXWlJ4SkxBQ1lwYUloblp1K1lRSHFiQUpK?=
 =?utf-8?B?L3JWeFEwUFV6NjI3cmMvK0RFZ2xlWlNDNThFbS9Ld3N2RGt4OFpabWpKTWJi?=
 =?utf-8?Q?ro9h6DelAB3tkCuWkxVMrGOn9UpyM8BoYFN7UkVdgxLp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a7471b-f1c0-4e0f-a0f8-08ddca74a041
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 05:40:41.4174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z6nTWTOLoI8MBRYZtxUF+KN9SiWmSYskSqENX8cBHz0nS/soWl5ttzApXt1da+SBcBVSdiBsGgmj1a9Wq+0Fiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5610

Hi Abdiel,

Thanks for this new revision! I think it is starting to take shape. I
have been able to use it (with a few changes) to replace my hacky DMA
mapping code in nova-core, and it seems to be working fine!

Some comments below.

On Fri Jul 18, 2025 at 7:33 PM JST, Abdiel Janulgue wrote:
<snip>
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

IIUC this method can be kept private.

<snip>
> +/// A scatter-gather table of DMA address spans.
> +///
> +/// This structure represents the Rust abstraction for a C `struct sg_ta=
ble`. This implementation
> +/// abstracts the usage of an already existing C `struct sg_table` withi=
n Rust code that we get
> +/// passed from the C side.
> +pub struct SGTable<T: Borrow<bindings::sg_table>, M: MappingState> {
> +    /// Mapping state of the underlying `struct sg_table`.
> +    ///
> +    /// This defines which methods of `SGTable` are available.
> +    ///
> +    /// Declared first so it is dropped before `table`, so we remove the=
 mapping before freeing the
> +    /// SG table if the latter is owned.
> +    _mapping: M,
> +
> +    /// Something that can borrow the underlying `struct sg_table`.
> +    table: T,
> +}

We will probably want an `impl AsRef<bindings::sg_table> for SGTable`, or a=
n `as_ptr()` method.

<snip>
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

I see a few issues with the `Item` type here.

The first one is that `Page` can only be created by allocating a new
page from scratch using `Page::alloc_page`. This doesn't cover the cases
where we want to map memory that is now allocated through this
mechanism, e.g. when mapping a `VVec`. So I think we have no choice but
return `*mut bindings::page`s.

The second one is that this `Item` type provides an offset and a length
for all pages, but in practice only the first page can have an offset,
and the length is only relevant for the last one. Providing these for
all pages is unneeded and risky.

So here I'd suggest to provide the following three methods:

pub trait SGTablePages {
    fn iter(&self) -> impl Iterator<Item =3D *mut bindings::page>;

    /// Returns the offset from the start of the first page to the start of=
 the buffer.
    fn offset(&self) -> usize;

    /// Returns the number of valid bytes in the buffer, after [`SGTablePag=
es::offset`].
    fn size(&self) -> usize;

    /// Returns the number of pages in the list.
    fn num_pages(&self) -> usize {
        (self.offset() + self.size()).div_ceil(PAGE_SIZE)
    }
}

I have also renamed `entries` into `num_pages` and implemented it as a defa=
ult
method as it can be deduced from `offset` and `size`.

> +
> +    /// Returns the number of pages in the list.
> +    fn entries(&self) -> usize;
> +}
> +
> +/// An iterator through `SGTable` entries.

IIUC this is an iterator over mapped `SGTable` entries. We definitely don't
want to provide this for unmapped states, as the `dma_address` method of
`SGEntry` would be callable in a state where it returns an invalid value.

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

As per `sg_dma_address`'s documentation, we should also stop iterating on t=
he
first `sg_dma_len` that is zero. Integrating this condition, and reworking =
the
code a bit to be more idiomatic I came with this:

    fn next(&mut self) -> Option<Self::Item> {
        // SAFETY: `sg` is an immutable reference and is equivalent to `sca=
tterlist` via its type
        // invariants, so its safe to use with sg_next.
        let next =3D unsafe { bindings::sg_next(self.pos?.as_raw()) };

        // SAFETY: `sg_next` returns either a valid pointer to a `scatterli=
st`, or null if we
        // are at the end of the scatterlist.
        core::mem::replace(
            &mut self.pos,
            (!next.is_null())
                .then(|| unsafe { SGEntry::as_ref(next) })
                // As per `sg_dma_address` documentation, stop iterating on=
 the first `sg_dma_len`
                // which is `0`.
                .filter(|&e| e.dma_len() !=3D 0),
        )
    }

> +}
> +
> +impl<'a, T, M> IntoIterator for &'a SGTable<T, M>
> +where
> +    T: Borrow<bindings::sg_table>,
> +    M: MappedState,
> +{
> +    type Item =3D &'a SGEntry;
> +    type IntoIter =3D SGTableIter<'a>;
> +
> +    fn into_iter(self) -> Self::IntoIter {
> +        self.iter()
> +    }
> +}

I don't think we need this `IntoIterator` implementation?

<snip>
> +impl<P: SGTablePages> SGTable<OwnedSgt<P>, Unmapped> {
> +    /// Allocate and build a new `SGTable` from an existing list of `pag=
es`. This method moves the
> +    /// ownership of `pages` to the table.
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
> +    /// let sgt =3D SGTable::new_owned(PagesArray(pages), GFP_KERNEL)?;
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    pub fn new_owned(pages: P, flags: kernel::alloc::Flags) -> Result<Se=
lf> {
> +        // SAFETY: `sgt` is not a reference.
> +        let mut sgt: bindings::sg_table =3D unsafe { core::mem::zeroed()=
 };
> +
> +        // SAFETY: The sgt pointer is from the Opaque-wrapped `sg_table`=
 object hence is valid.
> +        let ret =3D
> +            unsafe { bindings::sg_alloc_table(&mut sgt, pages.entries() =
as u32, flags.as_raw()) };
> +        if ret !=3D 0 {
> +            return Err(Error::from_errno(ret));
> +        }
> +        // SAFETY: We just successfully allocated `sgt`, hence the point=
er is valid and have sole access to
> +        // it at this point.
> +        let sgentries =3D unsafe { core::slice::from_raw_parts_mut(sgt.s=
gl, pages.entries()) };
> +        for (entry, page) in sgentries
> +            .iter_mut()
> +            .map(|e|
> +                 // SAFETY: `SGEntry::as_mut` is called on the pointer o=
nly once, which is valid and non-NULL
> +                 // while inside the closure.
> +                 unsafe { SGEntry::as_mut(e) })
> +            .zip(pages.iter())
> +        {
> +            entry.set_page(page.0, page.1 as u32, page.2 as u32)
> +        }

Since we now have clear `offset` and `size` parameters provided by
SGTablePages, how about just using `sg_table_alloc_from_page_segments`?
It can merge nearby neighboring pages into a single entry, making it
more efficient than calling `set_page` repeatedly. And if we switch to
it we can remove `set_page` altogether.

The only drawback being that we would need to temporarily collect the
pages into a linear buffer in order to call it, but I think that's an
acceptable compromise. The code would look something like this:

    pub fn new_owned(pages: P, flags: kernel::alloc::Flags) -> Result<Self>=
 {
        // Collect of all the memory pages.
        let mut page_vec: KVec<*mut bindings::page> =3D
            KVec::with_capacity(pages.num_pages(), flags)?;
        for page in pages.iter() {
            page_vec.push(page, flags)?;
        }

        let mut sgt: bindings::sg_table =3D Default::default();
        error::to_result(unsafe {
            bindings::sg_alloc_table_from_pages_segment(
                &mut sgt,
                page_vec.as_mut_ptr(),
                page_vec.len() as u32,
                pages.offset() as u32,
                pages.size(),
                u32::MAX,
                bindings::GFP_KERNEL,
            )
        })?;

        Ok(Self {
            table: OwnedSgt { sgt, pages },
            _mapping: Unmapped,
        })
    }

I know `set_page` was frowned at a bit, so maybe that's a good opportunity =
to
just work around the problem by using a higher-level SG API (and we could a=
lso
remove `SGEntry::as_mut` as a bonus).

> +
> +        Ok(Self {
> +            // INVARIANT: We just successfully allocated and built the t=
able from the page entries.
> +            table: OwnedSgt { sgt, _pages: pages },
> +            _mapping: Unmapped,
> +        })
> +    }
> +}

There are also cases when the caller might want to access the inner object =
of
an `OwnedSgt` - I've had to add this for nova-core's needs:

    impl<P, M> SGTable<OwnedSgt<P>, M>
    where
        P: SGTablePages,
        M: MappingState,
    {
        /// Returns a reference to the object backing the memory for this S=
G table.
        pub fn borrow(&self) -> &P {
            &self.table.pages
        }
    }

