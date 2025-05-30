Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABB723278D
	for <iommu@lists.linux.dev>; Fri, 30 May 2025 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748616276; cv=fail; b=r0QQxAhsHV02YgL+NcQmG0HbHWV98cF+ZPA2azhY+ILpvjjFYJwIFyiRxePulx0AzAF1i4pvC8deTkquSvmtbg4uVGdBimM/cGSLJBHIuNpajSljpVPfc45rO/jU8BY+TZNwydNuATPoH4yD8xCDQxou9Y7D8aAYvN8R8+MJu+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748616276; c=relaxed/simple;
	bh=xJUMOCV3Az9PB30lPD5KLvUQL7Mk0/NQ0seW/xl6lIE=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=pNwNy4B7BTrtww+lPAtspd/5BtAogl+WZ9DuKfEkswO71rrJzHVscAchS+IAUcLWTDQg4gDE6JvFT9uUPTKsEIocRrG5CzlL8nCJIGH6GVHokAEHlDOEspdThe8nLQDkgu1HdSB2S4S8MRpuICuTzw1Fc/Y7HTcUijLkLl3suZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SSGUyuGU; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SSGUyuGU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MlU2QmOM0E/52lL3KA//kEPE6diAsq3Mp9a0/BtiY5Lklc4g6dYY63XPjQiP39mXiFgVNluOWxskvQqwyTnVaIcv5rarB9kKOj+AoOIaaA79FDsidBd08pn0HBrzyI+P4/XbYqXSbBxp01JpW4McJ+IGWRguvJj1olpYl8UvMvAuNzL/7oWV35dNEfhrD+taMpwWU+5uWo1vfnNecNvI9EMEazghaDaD5YZBAO0L6r1kg99eW/ifLInhtwyui0zCPr+UIq44gzvQoArgdvsHYcYJrzMvHBlt344/ueUX2Jd6+dhJ0RlbFaUMuekNhRugSAPJxdU++3cvzEMpKFp21g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTC/Q+EEBbilTkRJJ9rdBNYyCSeRVuXNkFBvbbuM8PU=;
 b=fdS7c/DRZFdCBaKhIp6UFIBWHoViBmRxMfqWke6tbdrDkSfY9aQk29P5YIdgxdF2vfUrcZRTh+q9ak81zlxBgw+I6bsKV3jXQRRY3hBS3i71H4a+40TSmh7ZxGhglCWa4s1k/cRHY4dcxmbXDp2z8VUQ/BcWXovXrjYRRpvgVdFWH3JsHuZB4FICG08gxcE+xjJLMuIkYS4bnf7KZzv3Wc1Fo+DGgVfJ4ebQY+ULihm0crQX7B5xKkHaHPXRJh28BqVQBtlDTqiQ7Fwsg8BwezjVPtYguc8dQU9yKktWypsovAvEenIi6FCPv1jkK7I9/qp19DI1oMS4n4JFNlewTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTC/Q+EEBbilTkRJJ9rdBNYyCSeRVuXNkFBvbbuM8PU=;
 b=SSGUyuGUagSnCWVRWlpPCfA7oH71VRljE04YgCH82TLx/5hfpk1iHv/LHHXrDkEnBf2quJhthnBkno5XkfJE3G8rnAQVtkGwcZn2gtYVEeZzL5aSQVLHQWXLiE4aoBi2rzggyVfdc85OsKxNJ2gToF9dFlCZeavgYHWmTsc0SA1Vsnn2t0uTRyqCszVkAMXo5VhnSEPGkUGQZ69OxMhbMKywQn7rFydrWUP3Or5ZvWYA9Q+679rYF3FF10xoyDaQaqkpei07l/cgAg6/fVRXGpntgbXEbSaPhTrnlrxxkJFzxyo2KVxqWeAWnrreMEm+Mk+3GtOt23fNqCfdX8kL6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Fri, 30 May
 2025 14:44:30 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%5]) with mapi id 15.20.8769.029; Fri, 30 May 2025
 14:44:29 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 30 May 2025 23:44:26 +0900
Message-Id: <DA9KQF9CY77R.77PBMU8Y1FPY@nvidia.com>
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
 <20250530141419.GA292183@ziepe.ca>
In-Reply-To: <20250530141419.GA292183@ziepe.ca>
X-ClientProxiedBy: TYCP286CA0347.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::7) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|BY5PR12MB4116:EE_
X-MS-Office365-Filtering-Correlation-Id: 2435b25d-c4d8-4338-b728-08dd9f887bad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WlJteEJra2ZNSEpMQklPbUpQWVo4RnQ4WmdPUUN4QVZJT3pQdEJtNkJYdGtP?=
 =?utf-8?B?L1FBQVdSWHpvWnZFalJhdlpoUG5FNnJ5ZHU0WlRKTi9JY3gyVVRDWlY2NkUr?=
 =?utf-8?B?QlFhUXFQMmxwMFFZUkpxOUk3anBDaUhQdHRwWHJvRFFycUpFQnFFSk5kL1hv?=
 =?utf-8?B?NlJEd1orNjRGdHc3ZkNwYkJLWkZsTmx4QlpBdFNyRC9MM0ZZejZWckE5eGh1?=
 =?utf-8?B?Qm1vVnJXQVFKMTROVkRUaDMxNFg3M3RIdnJzbzNiUjU4dFRGalhHOWEweFhB?=
 =?utf-8?B?cmxsUWhDZGxJaFVqYXZ2UVJBQmJheXowWWR0WVpNcklaQ3lpNTgyTnVhUXhm?=
 =?utf-8?B?RXpOTHJCUE01WUVUY2tWTDdaUlB4K0dGemNhTnNldVhPVUVKdDdIbXhZeUdq?=
 =?utf-8?B?aC9zNER5dHlWMlhZdVBCeUlaOXNKQXROaWJ6YnZqSVdzTzFPclJ5WHRmWUNM?=
 =?utf-8?B?dnNDcXlDeTBDajlYUFZZMWlvSUhHcjlMRE5ualptM0lJWGVrN2RxMGh2akxG?=
 =?utf-8?B?M0Z6THJzUlYwcEhIakVNZzBBUngwMndsd0lXTXdycG91VWhUUE8yL0pvdlN5?=
 =?utf-8?B?VTdQa3NLNXBrR0dDRGFtTm1Bb1ZEdEJzZTlYUlUwZVVJcTNZd3d0WjBBcSt3?=
 =?utf-8?B?cUNtNDlaeHdESHBNVDV6R2JHUGlQMmdHa0ZSTjlHd0UzZjVHdmxEcUxTRGFV?=
 =?utf-8?B?U3pycG4zd3ZmK1o2UGlNSTdBTHAybG9zcXFFN29xajN5cCtHZGNCc2xGY1BZ?=
 =?utf-8?B?anJmZDUxRUxpWjFoT0lvNXVjc25HT0JwSmpCU3JOV3RMVVFBSHlNZ3UxN3lC?=
 =?utf-8?B?UXIxbXppeXcrYkFYSjc2VWpERkV5Snd5RnUvUlRoTENXQU1EU2pJdnZ0N21n?=
 =?utf-8?B?M1k1TnI1dy9QSzBjTm9NVytwaExkS2g3eVhaR0RSMFFCUHRTTmQzYmkzVWsr?=
 =?utf-8?B?aGVLS3l4ZHh3clkwNzVnY2ZaTFpiU2pzYUVZUk1pdEZoMHpEd3FGVWwvU2pU?=
 =?utf-8?B?emhjRDI2blhwTVZtNkdMTGEzWExrL3lPMG5OTmVjd2pEOFFNbnV1V2x0dFY1?=
 =?utf-8?B?UjU4Zm5rUWxmelo1c1o3Ynp6OUU4ZXlKVUxDTUdMTEoxdFZSM0NvRDFJeWsv?=
 =?utf-8?B?Q0JJanp3TDVRZlNvNmF3QTlPY1A2K2tjRm0xMUVPUzdUYUtKMUdWajVYdzhL?=
 =?utf-8?B?d3cxOHZtcm0rbkdVdy96dmhNcUVYU2FIVlJndzIyNzMrN3dJTGtmR05DYmdq?=
 =?utf-8?B?NXQ4c2FsWEV2b2tMckwzUDRtSW1KNEhudjRCRWRjZy8yQmxrdE9rRit2RE0v?=
 =?utf-8?B?YUhRdHNzL3pSSkZwNm9YQTdGNHAxZ0Z6TnYzNlA2cDNhdC9RNVNXOHVJc2xS?=
 =?utf-8?B?ekNkT3hNSWZEMGZhM2RTSW5GczVLTXNIaXFkVzVRZkEvQnBuYXYvK2c0c1Va?=
 =?utf-8?B?dUlvY0RjNnh0OFhhazN3RHJLZURGWFhwc3V3YXl2SVp2Ni9vZFZFT1ZwWGx5?=
 =?utf-8?B?N1F5T0pzakN1eStSNXFMRERtVXBsdm8zUTFTc3hyejBJSTNUa3hYV2FTOGNm?=
 =?utf-8?B?VVVPKzZJdWlDeDFyRTZ6Z0J2czNqbnhxZlRLODZoNHJpTi9pWEkwektTeUdo?=
 =?utf-8?B?azBZMGxBMGI2U09XWFhjeXNSaG1jdUp2ckc0N2pyS1hEeGtFM3U2eU5KRmRo?=
 =?utf-8?B?ejkyS2FmOTM2ZFlxSVdBTEZXYm9zSmdWUU5KYXJNeVpQbGtrUW4zK1ZDeDNm?=
 =?utf-8?B?ZFhnclNDREpIYWZXUTdVa0RkdlFUWnlVVDZjVERjMzVUakd2dVc0d1hkSlA4?=
 =?utf-8?B?WFRobUpGRHFjL0kvWExoV0wwSXNRWmtrdEhSbjk0OUE1TENWRzVmTUNvRDRo?=
 =?utf-8?B?a0xGbEN4OExsU3NHbmRSU3owQkhmSXVucFBrTFRkTG9rSEt3Z3ByK2FLQUFh?=
 =?utf-8?Q?tGNwbW3v+Yc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3R4OHlwa0llRzBpTVNQYk5Tb0xwQkU5dVRKQW8yRHU1c0poZ2NFNjNiMG13?=
 =?utf-8?B?c1plU1BRYUloOHllWFVYT3pPSHBtOGpNbkhHNFNHUGJlSmltQ1FjTjZIL2xq?=
 =?utf-8?B?N1JWMTJhQU9aeFRXZ3F6ck94R0xybm51UUpZMFpEL3pZbTh4QUZsRmlLcUx3?=
 =?utf-8?B?TVEyb0ZDajI1Vy9Ra2NSYVl4eVdxUnJHK01rcHA2OERQY1prYjBzbHAxNnB5?=
 =?utf-8?B?YUU4cUxlQ3FtM3ZrdFhwb1B2T0tyb24zZCtnOEZyQ1Y4VFNCMnVUenhQbnpR?=
 =?utf-8?B?WklpRlZLMkZoYkovWDIzK1dSTzhrWGNJWGJ1d09QMVpkYWtTZkRkbHJqVzdr?=
 =?utf-8?B?dk8zeG9tTGFDRDN4S1Z5S2gySnpiOW4ydmNZb0Vsd1J3VGdrU1JMS1E5L2Ev?=
 =?utf-8?B?WUFTQmJuNUpYL3NzZUt2ZE1TT3RWVHo2U1NBTEV2S2VVUTZIUjNOeWVXaWdl?=
 =?utf-8?B?TnVhNC9jS0R2bmVLS3FPSG9ibHVwTGI5WC9Mby9seWY3bkVTZTZhczdLVEd0?=
 =?utf-8?B?aUY1cUxrMktXZEhFNkp0Z0ttMjRaQnhxQWVYR0FCMHRGOXRKNzRjWUdoMXZJ?=
 =?utf-8?B?enVCV3NXQzFBT0RqeVdodjQvSVA1T3NQaTZnMmd4RE51R1ZJUTkxWTZoOTZi?=
 =?utf-8?B?QWJvL2FlL2JwczF1V2dDQmlmMUoyWjlZcVlkMysxaUJoanNZQ1dpYmo3UHRR?=
 =?utf-8?B?Vjkzd0FQeEhwTVkvT2d5cUY0WWZjVUtiNlBWcjB3b3c4Smtodnc3TEtuaHls?=
 =?utf-8?B?OFlNUUVMRDlrYngzcGZzNDJSdnpNWjRjMVkyMW44bmQ2dTBydnZHZkhLSlFx?=
 =?utf-8?B?NXVQRGlsMVgxVjRqeWNwYzJSekQvNG9Kb2hMa0JrSk9NUW5jTjJQQXhIOEda?=
 =?utf-8?B?NitnNWcyWUNjUlhTMy83Wk55TVg3L3Jjam5OMXp3U0J2OGhXcjhaTFhvZXdN?=
 =?utf-8?B?cEhXNGhsdnNzMjBFUk5EVHRSeVFwZU5rTmRsdEU5MzhHNWN6L2l2VGtzRlJS?=
 =?utf-8?B?VUFrUStDVDFGSm8wVGtuWFFmaTZXWHZzMkdpR3RsMW1KK0FDQ053b1RtendR?=
 =?utf-8?B?bUovTlJVV09iaVZrOTVMVFQxNmlvb3M0Vjg4aFhQQjhCaFJuTXFhMi9uNVNa?=
 =?utf-8?B?STM0K05GeldtTXIvcGkvU1ZreHFpRGtTaS9rb2R5WFJBNHg0TFB6UXFuL0V6?=
 =?utf-8?B?T0RpTk1WR2NDL3lwSXhPclpRR3dBdFFzQ2M0QXdHTUpBc25LRGdhSzZ1NlZZ?=
 =?utf-8?B?NU9NYkkwWithemlZa0hpV3U4Um5uZ1JJRWYrWjZWRlk2cXRWc0hEbTEzblZN?=
 =?utf-8?B?MXZ0RTdZY29iNmNXQU93V3orMHFtMFNDVHdMa1RzdHVtVDNIbEdTUVFnNG9n?=
 =?utf-8?B?cTJJNFQ3SVh0UDBUbndhc01YbFcrblVJRTg5eURqOFhsQmRVTDJ3V2daczQz?=
 =?utf-8?B?ZUhNZ1JZMTUwa0pJNlpVUWkvVW5vUkIxNnhFZEVPRGQzZmtkNjNFUzM4bDZv?=
 =?utf-8?B?NXBDV2RCYVU4dkN2OWJma2JZTitBZk8wallEZ1kwa1dHRVdtbGNNbVRodENB?=
 =?utf-8?B?ZXFVQjEzUTN4Zkgva2RhQWVMVDl3MWZ6M3NzalZDVGRMcTFDRW93NE5obUhk?=
 =?utf-8?B?MzhLbExLeGsxTHBYaGFDQzlXQ0lWWlRzNXoyQkhSM2Q4RG0raHVueHYwdkw3?=
 =?utf-8?B?azhaTHdaU0lRb3RwNHRZeUc3VXdXUWhkbVpRN1R4T1FpRk95OGwzYUFnU3ov?=
 =?utf-8?B?WjY5d3hSSUtCc1ZDTUwxdENZcjNZd25LNWx6c2ZMNGZrMjZoRFEyZ25WODF4?=
 =?utf-8?B?WEsyTnphczRiTzBVNjZybDE4OFh0RzY3R08rV1RuUmc3K2hPaWZrNTVMNjY2?=
 =?utf-8?B?bmhncUQrN0dqZmRCY1BpV2hXa01xSWpTQ2NMSVdKRkxueHZFUkJXcUtWWWht?=
 =?utf-8?B?YVEyTkNkbzlFQTV6NjlDakhZNEZSZTY1UzJmMjNRbGRXNkZmT2Npd1VFVUp4?=
 =?utf-8?B?bGZvdjd2a1NidFlWMCtBbzZwc1hFNHJBRmIrS0NwVHRuWllCdHdhdUxQRmVp?=
 =?utf-8?B?M0dFRmtyZFhFNkhIdHR1TUZrQmh1N0NOcmV6NjZEOWpHRXNtUHlMK1VXK3B3?=
 =?utf-8?B?RVNFRHVVb2RBYUUwc3JhYklJYnNaeHQ4NHJEcEg1aGhzWkQxWHB2eUFXVGl2?=
 =?utf-8?Q?9ttO96Xol1Ds1yJlpR2wcVw9e3S8AYBqDbAcHSzKESkl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2435b25d-c4d8-4338-b728-08dd9f887bad
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 14:44:29.8279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: euYNajhGD/dcfoRW8797sIJ374edSGAQPSmAyTWYYVUynzl1RoJXshq44h+t5CesIXR1691HF4wdj4REiCdKyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4116

On Fri May 30, 2025 at 11:14 PM JST, Jason Gunthorpe wrote:
> On Fri, May 30, 2025 at 11:02:02PM +0900, Alexandre Courbot wrote:
>> You would have a trait for providing the pages and their range:
>>=20
>>     /// Provides a list of pages that can be used to build a `SGTable`.
>>     trait SGTablePages {
>>         /// Returns an iterator to the pages providing the backing memor=
y of `self`.
>>         fn pages_iter<'a>(&'a self) -> impl Iterator<Item =3D &'a bindin=
gs::page>;
>>         /// Returns the effective range of the mapping.
>>         fn range(&self) -> Range<usize>;
>>     }
>>
>> The `SGTable` becomes something like:
>>=20
>>     struct SGTable<P: SGTablePages, T: MapState>
>>     {
>>         table: Opaque<bindings::sg_table>,
>>         pages: P,
>>         _s: PhantomData<T>,
>>     }
>
> At this point it isn't exactly a sgtable anymore, it is some rust
> specific way to get a dma mapped scatterlist. Most of the actual ways
> to use a sgtable's cpu side would become unavailable for safety
> reasons.
>
> That seems fine to me, and is what I was suggesting when I said not to
> expose set_page at all.
>
> But I would maybe lean into it a bit more, why have the type state at
> all anymore if the flow is SGTablePages -> SgTable -> Dma Mapped?
> There isn't really a reason to expose the CPU populated but not yet
> mapped state to the user at all. They can't do anything with it. Just
> directly create the DMA mapped scatterlist and only expose the DMA
> list through the rust API in a single step.
>
> So much simpler to understand and doesn't leak the bad decisions of
> the scatterlist design.

I would be fully on board with a simpler design, definitely. The reason
why I've tried to keep some doors open is that as you mentioned
scatterlist is used in many different ways, and I am not familiar enough
with all these uses to draw a line and say "we will never ever need to
do that".

Like unmapping a buffer and remapping it later sounds like a plausible
use (say, if the device's own DMA space is limited), so preserving at
least 2 states sounds sensible.

> Certainly the initial uses of scatterlist don't need to ever know
> about or touch the CPU side of the scatterlist, and it would be great
> if Rust could stay that way..

Yeah I am also more and more convinced we don't need to expose that part
and should just write it at initialization time and never touch it
afterwards.
