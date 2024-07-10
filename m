Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA98215D1
	for <iommu@lists.linux.dev>; Wed, 10 Jul 2024 04:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720584806; cv=fail; b=L0V2qVc+TJ3revoglrVs+c5i+jrfzi4WRaKQyWMVppCM1z2+dKZzhqHB2YXxs3i5FB6G81sXYgFbW8hdwU05BIKqn9txtMS7snpddDLM8kZ+8nmKqRTkvx3gibRS3HZbLMs62gQ23x+XhXWTmxERGVW7Gka7+hgzW3WOK+H1JBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720584806; c=relaxed/simple;
	bh=m2MHDCq9IJzwZvFB+n2kn+ltT1mnScgVKsMFSfh7/Aw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LTsz60e846+AwvoP/mGr53Emx3U2x5cep+zkIythtEjdhDKoP1Bk6vB8yi+GTOh4CwSCkiv+PoYsG8gWdjD5+gRtxs1RhuCrIdXUBKLudloq73BgTHS0hfJ6nhkbAUSszb9rQGN+LYoEx9ciXZqNSJ40ZbYS893u/sTO6bk6nv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jPNv1omM; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jPNv1omM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720584805; x=1752120805;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=m2MHDCq9IJzwZvFB+n2kn+ltT1mnScgVKsMFSfh7/Aw=;
  b=jPNv1omMPaWovcq6gRqhzVwzB3czMCupeykG6L+fGC+FzfgtNFGBh8T5
   8itq3YEUfot4XwHT9Ej+obpaGB3dHj/wPgcZmBBAv9Yn3XXB7xamwN6eR
   +9k2mZCw+8xOSlqxCbR5re5QR9a0V032Ef41XbhWyBCaTbvwd+U8ZJrAv
   zIDkbXslzJjWaH84Yi/02eYaomFEb3LHHwSWH9cmKb/pfYaQJbwEcNhVG
   y06tbo1+/zpD4fkp0dZXd46dkZIkj1i28D6Vf5w6JX6fHRbBT4MVgcKlQ
   b3UfzDjKESmTLuNucm24jkNPwVbsUK+GQ5YY/lEMrk1d0zDCt0dPYytEj
   g==;
X-CSE-ConnectionGUID: WAiVEihsRwuOmUMRO7UUog==
X-CSE-MsgGUID: UvIUuEu4ThedgvrotjhpoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="43301406"
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="43301406"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 21:13:24 -0700
X-CSE-ConnectionGUID: MJPi7jW9SlKagooeU6DqfA==
X-CSE-MsgGUID: gGfWKOqfRZiVhPYo62mDbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="85594184"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jul 2024 21:13:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 21:13:22 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 9 Jul 2024 21:13:22 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 21:13:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKVyBKvTOsmZ/X2Oazb/zHWOesa4LZ1MjMbJIy8JcQ7julbN6obEuWE3FA1Nc6pPxCD71l3kKmfmnDOVFL3uF+9O2WgABAi6xSkWtvPkYt9UpN26voIb4QSYb5ejpvMWoDyjFNUgGK6navlioO3rHUrWU1cvm+/nZc5lK22W+okEcFeYpRJWxIQwcQilSItp28jYQlKlEqljbJr39bMRBDv6b6mstKBQNaPDt3WgM23cfmMurmqqW9uFd/MAj8UgHgRDYF7f++vQeK1vLvEXwoytAJn6f2AlEBhUxyB8Wrub6oB4eWRv1chrbj1aV1Ru59GQ5aB9iHfyQ2LQWUnibw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8e906Z+cTM1BUwkWOIbL7NX3Y+ireYuI9TW8tMjZams=;
 b=WxVyaEJ74+e61YfbTxvRl2qbdv0J/QPRnt8T99IfGCynW2P1CE8XFXDF6B1/OJV06mTFz2q81w2dljE8l2Fnf9CfF/olelq41qxmOdZAcRKHcU/zLgKfrRxFdMonyjWTn5vwTG1aXKg9poHuO5Xpo+o5VAl8J3epS9Th0DhMxlSZzk28CSUE/5s4smOm3kkUbsp9b3ksvUt+xxHzjSqDucs1IaHGW693R+LY+RoW0XRbVRY91QtzNePkQn93JPXuRJloSWa1zPhp2+a9F5OMUrqwdLG6j6B7vV/aG65n0Zv8AQgbavKF2yFWEtEUrrrM2MVVnfVoioUxvgMcil5gfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MW4PR11MB7101.namprd11.prod.outlook.com (2603:10b6:303:219::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.33; Wed, 10 Jul
 2024 04:13:21 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 04:13:20 +0000
Message-ID: <3eff5c86-8b5d-491a-955e-794198350ec3@intel.com>
Date: Wed, 10 Jul 2024 12:17:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] iommu_ops->domain_alloc_paging() enhancement to support AMD
 IOMMU driver
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Vasant Hegde <vasant.hegde@amd.com>, Joerg Roedel <joro@8bytes.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Baolu Lu <baolu.lu@linux.intel.com>
References: <7e249bc6-c578-40f0-aca7-835149a0ad39@amd.com>
 <20240628130330.GY791043@ziepe.ca>
 <26524622-971f-47f5-936e-d0173d342288@amd.com> <Zn77FbsQWmByf16t@ziepe.ca>
 <1f8f04e5-3b70-45de-bd93-e3c96fb0a555@amd.com> <ZoLmyOzOVYGLKjmn@ziepe.ca>
 <68d300af-4d3d-497e-9338-d99dbf88dd21@amd.com>
 <8bfc6cb7-d2d7-4d4c-9970-f4f207fb54b4@intel.com>
 <20240709182303.GK14050@ziepe.ca>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240709182303.GK14050@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:3:18::17) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MW4PR11MB7101:EE_
X-MS-Office365-Filtering-Correlation-Id: aa7981db-6cc9-42c4-18c0-08dca096a22f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjRuQ0lVVjFvcVVTQmYzZ0loZGlkTVZFSDh4aVAwd3Nmd1VNcHFHN2xVbERX?=
 =?utf-8?B?a1R5dDJJaUFEVkkrZzYrWW8zWDAzaWhDSXJ1bzV3ZTFYNmhteWhFeW5NNVV2?=
 =?utf-8?B?eGlJeFRCUTFvbElhbzk0c0NqSUxmS0JjMHZYVElhR245REVsenhNT0d2UFZs?=
 =?utf-8?B?Z1hRMCtXSVBBSjNuZUtDZDNBOHp2UjN3dkVxY09PK0taK1ZNT3BzZ3VQem1p?=
 =?utf-8?B?NFYrVHljQVFqVGJWNEZlcUN2WnhZK3BWNVZiS3MzcHFxa1dzL0o5MmozSXJs?=
 =?utf-8?B?VnFuZjVNbXBNbUJRM2hBTkNGaS9DWXhNMHZjVXdrQnF2Tll6NllZNlBvbTNo?=
 =?utf-8?B?RkVtZ0FjTVR4RGM4UDhtQVd3czczOXZwTXBwMlQwQUtTT2tDZUxJZkxDckUz?=
 =?utf-8?B?YnZTaC9hY3NCL1lYaFh4eDF0R2d2ckNiVzlzeWJZU1JqNnBxWE9HWWF4ci9y?=
 =?utf-8?B?T1hXazNmbjF4Wk41aXNQUlNnajVndGxYWnUyUWx6NnRtY0NNSnVvWkxRa1Bo?=
 =?utf-8?B?K0pRT0UvY1J3cDNQUDZUdWtraDQ0NzNLUjFjUm1hUzJmMHJGcGp4L21HdGYx?=
 =?utf-8?B?NnZ0WDJZMWhwUzczSWN4Ritycm12RlF6MzZaNEdBVEFiNFg3Z1NKRXZCOVVk?=
 =?utf-8?B?eUI4RHRiRDNEUkZyUGMxOFN6OFJxUm8vZ3JDazJVV29BMHRCMS9JOG9wZVlK?=
 =?utf-8?B?OFcrcGVSaHB1aHk4SGdBMlg3RXdQbHdNMC9BYWhsdXFNY09OWTA4YWV1d2ZV?=
 =?utf-8?B?MHY5SkRQNzAvUjFTb3RucFJmTXljcGVBUnFyeUVoVHY0ZHFxYzBQV2Q3ZmYy?=
 =?utf-8?B?YjJyNkE5dS9weWsrcjk5N3cyK3pkVkZldHlIa29zTEVEZWN1dW5QLzNCeDZw?=
 =?utf-8?B?eVhaajFnUWpVZTZMaXF1V2RZdG1JWSsrQ2xGWHh1MmRrdDFtVXpjUzFhckkz?=
 =?utf-8?B?V3dPTDFYYUNZTTBQRERoeWh2Sjc1MTBJTHZtSm92QkVydC9pc011NU9wZ3BW?=
 =?utf-8?B?UXcrNzNkVjBuaDM5Sk8zckRMWURkdFErQjZpeGRrL2g5Q2ovcFVSMjVxcStG?=
 =?utf-8?B?cGFSUWNHRVBrVnBIRGFTbjgxOUVDb3pzNEE2R05wTzNGVWhQUjYxZ1ZSSmdz?=
 =?utf-8?B?NDZEWlJ5cnROUW0wVDRKeGlFL2RvakZaQ3N0UEpwblJZeE9ueDRXY1BKTnpw?=
 =?utf-8?B?cjZCR2hYcEFiMkxHdGJ0Z1JjcTBBRUxaZ0EzaUtQWnJGQXdDbmh5Ulp5UlNK?=
 =?utf-8?B?MFR4RFdsenRpbFJLQm0raUpBNGhScnJqcGVQK1REd0NpRWlIa0dEODJ2Wjhm?=
 =?utf-8?B?L2gyZE9JTldxMDZ2UUN6TG1yUUdvcFBQd3kyYmRhM2dmaG5UQ01HSkhqNWQr?=
 =?utf-8?B?Tk0zd3FDWGpnS2d4OVhmcm5hcHg4eWVyTXNEQUx5YXQ4cTZMWkVEdEQ0M1kw?=
 =?utf-8?B?Mys0azQ1WlJRS2VIWjhwOXhzUDBwSnlOUC9zQjhxeDg3dEFqRW1wdWgyODJj?=
 =?utf-8?B?Wk5vZU5lZHlzb2t2aWJzWEx1b1pXOVhrR1BySG91eWVTMGZnNTJHdU5raUFX?=
 =?utf-8?B?SU1VaTNIdmRSWXlLWnZPZzNyRjZFWm4rUFJyeWZKOUZKK2RRZDlYY3VnTWdz?=
 =?utf-8?B?SWxHTFFMRGRIN0MvV0NjYVlrYmlJTTc5N3lIZ0NaNkVjTjZpeTQxOVlUc2VM?=
 =?utf-8?B?L1Q1K1lLdS9rWjhYN3pYbHFzYU5ubFg2T3orSC9qYm1KeVNwNnpVOEtMbVFF?=
 =?utf-8?B?OENGNDlsNkdReWloS3JGT2IweXBic1R4Ti9IeEYxeFFmbElaMElzMDJHb09O?=
 =?utf-8?B?eFNIMFpzQnRJYzVwNHBJZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tkl1SGJ3MTVoWGx1ZlB6a1VhUndFemc5L2g5bDVkZzZ2SDZnK0lQcXZWVnBj?=
 =?utf-8?B?T3VFTy9hQ00zaG13SFJzMjRiSEg3c3B0bXM0dFZUdGMyckhEZlZ1QVhiWEdX?=
 =?utf-8?B?aDVRdWphS3c3aXVHVnZZOFB0U1NOTXAvRGlvK05PRlJjWjRpU2ZEQUxKN1Rl?=
 =?utf-8?B?eDNlZUladnRYU2prVlVMM3FXandXcmJMaE4zVFZhVWkvQU1zN2hLRWQ4TnVz?=
 =?utf-8?B?bjJvTGN1SkFTdVBDcW5hSXZCZUVrTGUwbENLeGRVbkV4aDE1dU96RVZuSFVu?=
 =?utf-8?B?MXE1LytYMC9wbFc3cFdxRWtmalJ3aXBxcXlvYmpKUVZwOXJmK1p4M0dreUJt?=
 =?utf-8?B?UVhFTE9LZHJGbUlFYjgyWGRxaXZoTFNKZ0FCRkQ3L0ZSMU1kM0xmSXcyS3Zs?=
 =?utf-8?B?UzRiVlJlV1AzZEFrZVRRdkhuODFSajh0NFd3dFFxVmhpa2RQVXZScndCcGpo?=
 =?utf-8?B?REh1N09UbTVpeHM3TjFYTks4OEpLWm1uZ0lIbkwrMEthVmg2ZXliWjFoUXpp?=
 =?utf-8?B?M3E2dTE2NGxpRFRlQUNOY0x1SiswdlZSL050N0k3eGJaWDUyM3loZXZCcVpm?=
 =?utf-8?B?eWliNUM1MWdrNjdwSElxZVpmTVk2dmViUmpJaVNkcXFxMkJVQktqTlZ5U0pX?=
 =?utf-8?B?dXNocDNWSTJqQTk2UFJySFpFTHNWQXdrYmNBUGMrakxZTHlpMXNwdFhoTW5X?=
 =?utf-8?B?LzZXTURIK1hjSkxFL28vQWdaZE5wSzlZVEk3WThaMG1lZ1R0WEhJQ1pnbkNL?=
 =?utf-8?B?bm1iYy9xWks4TnRYL09UTjhucXptMEw5Y0h3VWJZUE03Yjdua1QyWHkvSTg0?=
 =?utf-8?B?SGc4NUFtQnpQQ3JndmcrazRWWU9rSFRSK1d3ZUF2NVNaUzladU9FRHhER0lL?=
 =?utf-8?B?K0Q4VVJOSC95OGVObHRHRVE3S2svczlUejVhSzlPc1U4L09OcklndzdWbE9D?=
 =?utf-8?B?UDVRZWZ0dmhEWVlHSDllS3huQW5RWGhQNVFUamh4aXRpdWhaVlVqdkxBRi9D?=
 =?utf-8?B?bWp1dFBmanpKeitCbENrNERwVnFwK1ZzUHlIRm5mR3kvVEZPelNZVDJwZHBx?=
 =?utf-8?B?eElWRVY4OHhlUFUzQUFJeE1uTVhFTGFXTGdHMGt5b25NcExLRmcvWVZRcUFU?=
 =?utf-8?B?b1c4VXgzRGFwUFJJZllLTDEwYWRySnFPcWxTZG1CYi91cWlBN2lKUUtMVzM5?=
 =?utf-8?B?Wk9QS05maUFrTDdJbnJ1K3R1ZEhwdUdwYVlibnRjdmdUNmppT3prK2pTdnJF?=
 =?utf-8?B?TDdXOEFTSFh5OHAyMXNGbXJnSlk1bzZORXpYM29OK1U1Zkx4WGczSDBsdzVh?=
 =?utf-8?B?NlkyeW92S2QxYlYxbzk3M2k5RzM3TlhQU1R1dkxKaDIvR2V3N1V6bGtkTU5x?=
 =?utf-8?B?eWVSclh3TGZPNWpqZlJ1emZkSVdZV0dKQjFtY28rbVpEOGt4Q1dHWDRxQjRi?=
 =?utf-8?B?OUtQRG9IeUhsT0pTY2NhZGptcVhDVUFoQm9GWnAxcjV3ejdwaFV2dnFiNndJ?=
 =?utf-8?B?cDNVR1FtM2dSV1JITWd4QlNzdlRYT1pLVUdlWDlnaC82VkpDWGVvQnhRL1ZM?=
 =?utf-8?B?dm8wT0JtdDdMbWhUUTJNNThPdldDNTBXMFVHdHZQbjJVYmIvZ3NBSnlnSFRT?=
 =?utf-8?B?dXh0Q2YwT05CU1k2b3Q2djE3aHgvaW1qdUFBTmYwMjB3UmVqekNXakp3Q1ZO?=
 =?utf-8?B?KzdTODBUS21yNFZUb1RLekFxZFNseHJlVnVrSnV4ZXZpRWdFZHZMcHVWOWN4?=
 =?utf-8?B?UEJodE9pcWw5dWxQcDIxNjRpSXdMOGVuMzhmbXBJOUxUSVVwMkY3Rk8wK2dk?=
 =?utf-8?B?RFk0SlNGaXpCK3hVa3dLcEpzY1dTcFdvOFcwd2pVQmxWMlZRb29HSjB0RHlx?=
 =?utf-8?B?enpid0Vhdkd2aGU2bkNvb0xwTEpnNVBUeWRiTkRHV1V0R3pLSlRGY3V5UUJ4?=
 =?utf-8?B?dW5kMkNsSU41TUIwcERnenEwS0xyVDdJSStTVktvbHJMQkVJWjFRN1F5ZE4r?=
 =?utf-8?B?Ym9DV0lmM0txeTY2amtlWFF0VUVscWhZR0QxZDRlbzVQNTVtOTQyVmtxNGhK?=
 =?utf-8?B?aWh2aHUyWXk5b3NtRVd1R3ZhSXQwNVBMd0t0RUM4STVuUkM1TUFVNzdQL3RW?=
 =?utf-8?Q?ESru+YCE8LnoQjcpzViUBIVvp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa7981db-6cc9-42c4-18c0-08dca096a22f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 04:13:20.9082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jSXrpt/spcopSAglaQZK6lecXcQFucUKLXBIVVRgymswwU3W9DgUVE9iE28Ml2dphXnaDs3Aj+qS217NFnmJqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7101
X-OriginatorOrg: intel.com

On 2024/7/10 02:23, Jason Gunthorpe wrote:
> On Wed, Jul 03, 2024 at 02:57:51PM +0800, Yi Liu wrote:
> 
>> BTW. For AMD, can a single device be attached to multiple V1 page table?
>> IIRC. looks like AMD has only one V1 page table pointer per BDF. But there
>> is a PASID table which has multiple cr3 page table pointers.
> 
> Yes, ARM and AMD both have kinds of iommu_domains that cannot be
> attached to a PASID.

I see. VT-d does not have such a limitation AFAIK. BTW. SVA domain shall
not be attached to RID I suppose. This should be a common restriction
across vendors. Do you think it is valuable to let iommu core block such
an attempt?

> We are going to have to deal with that as well at some
> point. Currently ARM is always creating PASID compatible iommu
> domains.
> 
> While AMD would like to use a RID-only type by default.

thanks for the explanation.

-- 
Regards,
Yi Liu
