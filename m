Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010023.outbound.protection.outlook.com [52.101.201.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F24A32D0D4
	for <iommu@lists.linux.dev>; Fri,  6 Feb 2026 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770372659; cv=fail; b=snnq/ouyhT5oiJT5dFhfMxhzkUcXyW5i5Eqhig8l8uOjAHXUjdEEp5jdocIfKOW6DufjmWOBXbsxsaRfqvh848hYM30WzK4E0PKdJMNTtm3Y1yDEpoqnTeZRq8RP5XX+gJizjkzDnYRpf5cohxBWC0+5yH+jgxZFe2+mjJNHDLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770372659; c=relaxed/simple;
	bh=WsCR68OWL6nnne3gJ5mUe2xL4wk+52NxNXe94ybebtw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ix5bQGIO0wMTFTxKf2XlNLCgPxBpPfZlY54WQ0nsV3AYEVbsKUvGqQxi/X8oNzIvkN5KEOe6w5fYwhOWXvua84eTPI3Ouq1dQSjk8LUwOKT0yI0Zq7piv9nT4WgLpxLrRMvgXbH+bWlswKxz4C+xPo7/20uIwNT2b4Z8yD02L0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Vvs6VX+X; arc=fail smtp.client-ip=52.101.201.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Vvs6VX+X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=drx1Xx8PP4yGvfEcDAU/vlBE/BdeNjzrwJIbadj3QOIsZIUadvcTNR2o+3apMXe2WIe9GgeAjGsBc+Ps5wHZCHn6BhltEmnh/PKnCjifCOx/i2dnWtDovfBfrm/qQcHI0jTzWd16/UW/ybA+jEZkDmdPOG8WVmIzTJ8TcPShMrOpISHPtoN5vYpDq/NmCEzLQJ331bj0Rg21LsAvx4JUvaIB1Qzr4rqZzztbdEuquApo03iS+NzMSnIJdSRN7/1aOcRLZuJcuBy8lOuyBUEbLtiO0IZ6VYTaHIZCP+ock3nUnR7clT8HPkZ4+mIs8h8RubPjeKFNyCcxAkRqgXEavA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdHXb2OSJBnSO2d2wD0eMaQrQBJHoWS2cgsvx8Z8kz8=;
 b=GdLN7jrPbRXGzF9ZvPW2yN2OuMOSBebfb7z4eozJtW3RP3JzksiS2BsuyT3nAN/kIK8lQr25qXuUxyl2iQiaq3t/fhmrwewU0iCqXVX+k2vRylnOeeW0utKr6EYPiGUQvEbieTqqdAzni6c7aEOMiNWQ11HwnBIYAC4k4Z7gUXZKHJuwNnT1P/m2qRXx48vZeFgwieux7fBbkNP3ObdOLZCo2BR/+epw+ARhOg8hS5Uwey7rcawT98S16DbqVFg//5EbjgjvnV9xUpddFcPmba5j4OYhzaDpuJvc4cPKP2y8zzqPhgpU1iBJXWtzDATvoe8ZlzVakT96lBpCN8dlDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdHXb2OSJBnSO2d2wD0eMaQrQBJHoWS2cgsvx8Z8kz8=;
 b=Vvs6VX+XXOIA4lNeKRlvFktVdexFVuW2DrFSdHmyR/wjr77oV+zEovePq6JkSCDfojA7rPh7lsDBFeTnalv4raiNlMXrdm3wU2VUbM4+rPOXVSLtZK6r653nWgCa1/zURPAn2AtbFScWiKJbCtWCuTU4IC83i+1xUb+3pQWo3iU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 DS4PR12MB999076.namprd12.prod.outlook.com (2603:10b6:8:2fa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Fri, 6 Feb
 2026 10:10:57 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%4]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 10:10:57 +0000
Message-ID: <dbd9903e-a2fe-4090-aa68-1bb31fc846d3@amd.com>
Date: Fri, 6 Feb 2026 15:40:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/amd: Invalidate IRT cache for DMA aliases
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 Magnus Kalland <magnus@dolphinics.com>
Cc: iommu@lists.linux.dev, jonas@dolphinics.com, larsk@dolphinics.com,
 linux-kernel@vger.kernel.org, suravee.suthikulpanit@amd.com, torel@simula.no
References: <fwtqfdk3m7qrazj4bfutl4grac46agtxztc3p2lqnejt2wyexu@lztyomxrm3pk>
 <20260205140059.11857-2-magnus@dolphinics.com>
 <blunl44eynudctpiqrlp4czdohmet7spwu4c7svc2pdmauaves@vfzpu55vtv25>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <blunl44eynudctpiqrlp4czdohmet7spwu4c7svc2pdmauaves@vfzpu55vtv25>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0065.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b7::17) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|DS4PR12MB999076:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c3ca66a-9bc1-4ca7-56a7-08de656804ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFZsdWUxaG45bFpXSTlsdTZkOUJLOUZ2Y1Z1OUVRanFpZngxdWs3UTVjUk41?=
 =?utf-8?B?MlJGbXJJNDArSHFhckJ1MldRMWVNM21PSTRSLzdGWjl5OGVGa3NXU0xQZGlN?=
 =?utf-8?B?KzdZbVgvVTRVQzFoUURCWUxOTHJncWd3aGpUZ3lGMGRyMElwbHhiZlhJUmRX?=
 =?utf-8?B?RS9neFZheUs5OGlDb01ud1N2VEFVTWROeGZreE9MdEtMdi9qTTUySXQ2K2lJ?=
 =?utf-8?B?KzBzOXRDSVM3b2hrc2VpaWswSGF1bWx4MTNGNDZiWWpyYmozbzd0cnNoVnRj?=
 =?utf-8?B?amNBT0E3MTkvUTlIQnFLVlljdnpoOW9ndkZXS1c4bGZhNkR5a3hzMXR1aDFR?=
 =?utf-8?B?S3huMmRuRkZjNGxNRW9sN0pLdEN2RnR1WDRzd3Vjcll4TVRIdk9TZW1oODB3?=
 =?utf-8?B?bUMxY2J5YWk4cU5QbWJpeGI4a1JWTldjYXNmY1FmeFJqYThIaUY4eThSd2NY?=
 =?utf-8?B?bzZPK01mQnZmTEhIcmwrMUlYUWtpYUg0U214RHYxaUQ2dGFyaDVqYmtzV1hq?=
 =?utf-8?B?YTh1cG50M3kwSStKYkhQR0s4bTMrQXZOaWdzaFFPbm1CWWJPb0p3U2NBbGJM?=
 =?utf-8?B?eFkxVnpRdXJlbUh2WU5tdjJaN05CYk5JR1MwV2JXM0pYQWtRZGxVeHpRc3Zw?=
 =?utf-8?B?MnU2TnhsOHo3RGd2VndZK0Y5S3NWdXB6djlSelA2N3lGMDhqT2VsdHFqY1Vu?=
 =?utf-8?B?N1NxaGhhbXY5S3RxSXZ5UlduL1I4WWxOdzQ3VEVTTmZWYXQwRDFQQjVSMXc4?=
 =?utf-8?B?SlpvbUxGc05vOHhYdHRuRjdvUExaR1M2RFhBcGQ5STl4WkFpWnRzT3Q3UWRh?=
 =?utf-8?B?MkNsTHUxSTE4dEZWdEYzSGNISEhueTF4bXZ4bkVLK09MSCtCMFFaY21DeWI1?=
 =?utf-8?B?OHowSnlEc2phTjdPUUFnelA1Z1B1KzZYOU16RUlKd1F6cjlScDNrRUdJRUIr?=
 =?utf-8?B?K2xVUm84aXlDWENjVEtVMnhyVWhkekVieWhYV3NCMTIzM0NmTS9ZTTBkRHRP?=
 =?utf-8?B?ZGJqVWFESmJtb0lqY2UvakxYQVhrajJJMlNwWWNHcWR4MEJoMG90VVVkWXJS?=
 =?utf-8?B?VElwdFoyMjQwWUlhNEI0MFp3Wk0rWTJpN0FESGxuT0FKcERPakxTaGEyYytZ?=
 =?utf-8?B?NEIyU2E0NGlkZDJOSGMraUEyV1V6RXZHaTloVHJCLzJweHc0R2xicFk4NldD?=
 =?utf-8?B?Wnk1bS9ZNFFlWFFUd3ZCb3BYRUIxSnFpZkRPdUZucTRJeU9LdmhIRVErYVZr?=
 =?utf-8?B?c0o1eGhSS3V2Wk55dVk4UElNeDI4WGtmSlVnTmNmK2hyVEQ4bzYrODQwMmVH?=
 =?utf-8?B?SEorSUxyWXlHZkZabzc2dWhxSjNXblVWSTdGNmwwa1NnWGEyVjZVV292ODZy?=
 =?utf-8?B?TGZqU0NKb3ROY2dYRlZPVSs1UTR5UG81YTJxc3M3ci9xL3ZvOXdjU0R1bnNI?=
 =?utf-8?B?cTNaQlM2ZUFWV2dBQThyRkovcVNqR1NDNFJ5T2NUa2hmWlpmSEcwYWNVaUpj?=
 =?utf-8?B?cjNTcGRGQ2YzaDlhYzFKeFdPRldTL0YycGIwWlk0Y2lZUFlqNjcwZFhOa1Yr?=
 =?utf-8?B?SmJnVmttenV0cUlLUmFucXdHcUM0dG5OWmlVRVliNUlNdjRsaXRFakFZMHcv?=
 =?utf-8?B?YW80QUUrNmJlUUZmU2VHc0xvejY4NmZmNk15VmJINm9nTFBtdEd1eDdmc1ZK?=
 =?utf-8?B?cmc2d09ZTFh4WERMY3IrMWR3V2pQUDVrV01KeFFMa2VFS3ZIM29JY2J0L2Yy?=
 =?utf-8?B?amlOU3hscjZOdU56dFJMUElFSkpIUWpHdlUyckJVMnJmRjZvbjRGT2dneFk0?=
 =?utf-8?B?ZWpybHRkYTNhRHJ4MUFjYU8wSi8zSlA3Zmo5LzhUOW1YcXFKTWZKd0xJdlhk?=
 =?utf-8?B?R1BaOUZmTWI5MmVrQjZ0L2FORnpUdjZsUkczd0RkUWk1WUJIajNIWkpTYUVH?=
 =?utf-8?B?S0lZN1JLMUh1UkdiWkt5U2xkN2N2N3RrUzV0cFoxc3lObno5ZzBaRTVCMEFT?=
 =?utf-8?B?RCtRUWpYSHNSOThzc0JQbzFRakhlRWpOSDVqV1lwVmNVOVloVWR0MWFKNWgw?=
 =?utf-8?B?M3lYNTdZZE9YbXRjWDhmeWx0anVZK1BZSlpCOHFia1NyZ3RjS1daZVRHa04r?=
 =?utf-8?Q?BJ5E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjNxOWw2ZXl5T25qR0JKVWdNVzd6NjBOYjRLL1hGS1VWUjYyQ0I0dFFoSFdS?=
 =?utf-8?B?dDkxWU5Ib0NvaWE2M21haXNzVUVQRXQzL2t4cjZRY0VaWWVtWVVYRXdNdnZ4?=
 =?utf-8?B?Kzh2N0E0NGlqV0NPcHZRZlQxVkZlaG96cXZUQnF1Mk5PVjhPSmNsRHhYdjRt?=
 =?utf-8?B?RXNPWHRxeDNySjJYZXFLV0s4RHBRdVBEajJXWlM1NW9NdWZQb3RXVXBSc0M1?=
 =?utf-8?B?aWpnL1htWVlyRlVMc0dNQ2J5SU96TVFJUjVGR3lKVGlMV081VVF2TWhsUUFB?=
 =?utf-8?B?SmVaNFVsTFB2bEFiOEtFUWJDWHFuanBDcXBCVEVQZUJGSjVlZnZYa1p4YUsr?=
 =?utf-8?B?eVhaY2dLVmpGWU1QdjdyMkdUdXVpdTVFUStrYk9tNjZKOTZvRVdkV1pNdXFa?=
 =?utf-8?B?V3VGYmh5ZEpDbTZQOG5YZlpySDB0eHJ4SXRnL2F5U09FYVdrYVk1UUMvaFY5?=
 =?utf-8?B?ZVRuUXEzdVdSTGdIelNzWnNnY2lyTzhxSFdES09HaGFMVTVrdVhuVm5nbDdO?=
 =?utf-8?B?blZZaURnNEdvaHhKM3N6M1prYmZBcmVuTUNGdUxYTGF1SU5rN3ZVOVczemk4?=
 =?utf-8?B?cmpvRXpOUG84ZWJsaTE4MkIxNTBieGVvZnJSdFBDcDFPb0dNQUl5Uk1Kdy9H?=
 =?utf-8?B?czlFbEtuMDBrWWh3T1N5MnljSlRMSlZtbzgxc1VMb3FCOUZ5bFY0eVJZMHFn?=
 =?utf-8?B?WitsaW80a1p6ajJWZHQ5N0hQUmltbTJEVzFJUzlXK3JpbXd3RENyNkI3anFL?=
 =?utf-8?B?TytMKzhKZjA3RGtRc1JKSVpWRWF3cXVJeDhpT0NqdXA3YkwxNEdFc21uMVE0?=
 =?utf-8?B?clhlVlI2ajdKVnRzOHMzWUUrMG54TmZSZVRjcXRkbDlZaXhGVWZlbzFhWWN3?=
 =?utf-8?B?cHl5dUFRb0xkRmVva3p1b1ZsZUp4eVhvaVdkOG5IU0FRZUY3MlNUVTNJdlZ0?=
 =?utf-8?B?NExmd0pQZ0xRMFlhWTMydFQzbW9LMVhCZ1BzL1ZTUEhHOFY2eEJmSmk5VDlB?=
 =?utf-8?B?TzY5bExLNGpObG9RcnNLZndNSW90NmxiOW5RU0I0RlJQdndyYTJCM2pWQWE1?=
 =?utf-8?B?Z3ZhNnlFRDVTcTZmaDE5a1ZLNTZOTEk3ejB0eW4xNmhkV3EzdGF4T05kYWxR?=
 =?utf-8?B?QktSTlIxaHNkZlFvMG5TQ21HMVFUSk42NzZkUGpoekhLclJrOFB6UlRiS2tT?=
 =?utf-8?B?bHhNSkwxQXgzRERWZllPL2EwNmZQcFYrenZZZDRPTUR2bTNTcFozNWJKMzE1?=
 =?utf-8?B?aXFmZzNBY0VOSUVGdFBXajFHZmU5U0ZBRlRncXAvOVExYWlvUlUyZzRtRHJ1?=
 =?utf-8?B?VUJ0OGoyT3Zzazk2V1hUcHVOeng4bEwydC9NNmZuRStHRmdoUmhXRDJRR2d2?=
 =?utf-8?B?K2ZOeFFtSk93N0xqRmduZnlZMnFvZi8rTUhjWVQzOUtueERZUExpK0pnTURh?=
 =?utf-8?B?NWU2ZUxUa3pTUWd0VERRS1J3Q0hGcDFvSXZrK3l0eU4vZzN5ekU2VHp6TjM2?=
 =?utf-8?B?N25KbE55Vi9vcXQ0OGtlTWZCZUJLeVgxYlNZSit0ZzQ4M1VjQ2RQUW1vYWkr?=
 =?utf-8?B?U096STNBTHI5L2N6ODFTZmFKb1JDYjdPeEZxdUl4a3VGRTgvUHZTWmZlT1ZP?=
 =?utf-8?B?aEJ2Qmk5RDI5OFBDc0g3ZE9kQWV3T1VNTFVxblhOUjFZMzJEUzVMWVF4OCtO?=
 =?utf-8?B?aHJjRzJnOUhYNjAzSVoraTkzbCtkYS9Bb1RUZldJK0F3LzZuMHJXc0R5MEdu?=
 =?utf-8?B?QVd1ZzhxZkhBWGZrRk5SeGY0UVFwOGsxYVI0MXd6bTQvZGpvYkhUQnNieW9B?=
 =?utf-8?B?UnZuYUh2eThQOFFteDNCNzczY0hXOGFlZ2dZbTRtSjd4TVNPNlFSaE9Yb3dW?=
 =?utf-8?B?ZW5wMGExR2x3TTZCVy9PS1A5ZVVTRk1ZaG9SampiY2JEY2VCVlBoZkFDR0h3?=
 =?utf-8?B?aGZhMjVkVW9HdHd2OHdBUGhyYXZTWGtqbVdEMEJiRXRuTXpkc1RUWGpUYVZM?=
 =?utf-8?B?V1F1blV2WkdFcEpTMDNXa0xYcG9jNXVNTjR6OWwrbExLUHpTaWU1Z3JYWVc2?=
 =?utf-8?B?VFZJeE1VWTg1OWlZckRud2M2WklVRGZKZ3lkTW1BbGhKQ1h3am9lQlNQTncw?=
 =?utf-8?B?YnN4VVBWWnVLS1hIcU84bzZvTjVKNmdRdWYvOGZBb2h5WDZaTVV4VC8yV2Z0?=
 =?utf-8?B?aTg1Tzh5Y1lVQWp4RnQ1NSt5VVlqY0FBVmhsSGREUmdRbEtBVlNTd0d1b0lo?=
 =?utf-8?B?UVRXV3BJVE9NRjgxclFMMzlYaGVkTDlUMmdmVlhUK1lsanUrcnViakZRQTVP?=
 =?utf-8?B?RXNmYlJwcU8wSFA0enkra3BmZWprWlIxV3AvUmI0Y0w4dXNjcWh6UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c3ca66a-9bc1-4ca7-56a7-08de656804ac
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 10:10:56.4345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0+sZRu6+GC6bwsV88SNUfxHzAaWqs4CXK+Gchm+1E1Kpjpw7z2LUU1mqGD1WwxXqt7tLbOCZuKQaMHr06+dCcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB999076

Joerg,

On 2/6/2026 3:36 PM, Jörg Rödel wrote:
> On Thu, Feb 05, 2026 at 03:01:00PM +0100, Magnus Kalland wrote:
>>  drivers/iommu/amd/iommu.c | 32 +++++++++++++++++++++++++++-----
>>  1 file changed, 27 insertions(+), 5 deletions(-)
> 
> This does not apply cleanly on the iommu/next branch or the iommu/amd/amd-vi
> branch. Please rebase to the next -rc1 when it comes out and re-send.

Sorry. I had missed this one. Patch looks fine. Can you wait until Monday? We
want to test it internally and make sure it looks fine.

-Vasant

