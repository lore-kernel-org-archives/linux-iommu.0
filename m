Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011051.outbound.protection.outlook.com [52.101.62.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACE544CF29
	for <iommu@lists.linux.dev>; Wed,  8 Jul 2026 14:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519953; cv=fail; b=k3hiryTXpE288Ewc9gXINJX9tHGdnM3H1bzanAJJmxScGlKflJ9q6GbiTBv5n6M84tuhkX2/lVy9zhaSR5CAFlhv/8w3EGZY0CwadGSz00NPlSczkVHH1ZxuBOvGfP6JZrElUlXQFWo2Q3PwC1ftV5KbXJ8LBIfz7r95Hx7itJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519953; c=relaxed/simple;
	bh=lb8y7C5NdxBeB7b1vA3OfSqDRfALPw4v2nmQjiUP5t4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BsDvXk1bZkxbeFs7ycSd+t3b6VT7NZJV6Rbj6+/lXY/yuBWprDUokna6xYwwHeiebESO0K+nqPqJJ5pBo5uP+CjplnG5FJYDFTMM4M1mWb8y+ONojCkQun3OGM8B+1OvUVsdAhc8m+mEzGnEgMfWfecm1oHR8SeaEuEm5dcZpMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G/Jd5h77; arc=fail smtp.client-ip=52.101.62.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G/Jd5h77"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uRk1Y0CqVgoL0oe/ATa+JUgX7YtYVpMQFFwIiKljmKyf/pjmUlrCQFOBtqkEJc3D5I5V4yeDbTFslA+jQs6+leFlYGx7pHcS5U8mCt0SuaL3476NMuIbmaNtiE5Rr9wvrE22ezg0SvZlyR+Z1u5Aa3uNrNaiDXs4ZuWJIeFzV/YGAW/Be67QajktnpPxJGuFTHNMTM+tRyEbg3bDfP7xRVN9oSiFBPSy+r7nc79SfGBBpgJbMfBh0/2jcuRPEsaPhBaXfYla5g9cLbn89qNZO6B++igpLZr3ak36yN7+h5A8qPyd1NJ4BVAyATfAeicCqNCH4DMJnULmOP5vWEiPPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mr2rRZbrqiZvM3P2Mbiv7Hhhh1gtLUGvzA4Eih0xk+o=;
 b=N9k3mr2TeFr53wbEGYGnQgKfcPId3kSyrj1FWiF8uooZI701wpdp1bbefjjb5WQTIHX79TP2p3nchejgDUXJLFtRJxzz8UeYxJKpq2sqTBxnIpoEWjcZkrxmxpN4RB9r/9S+i2xr2KqWNbFihukBYDrEAwM3BqRR2shODuHWz/KdEdTHovD5XvVwGO6iiUVWbSVAwg37O1KBMREFw9Hq+4hALQCNPpO56i7GAVUq0LERd8OTtpAuSSkZU5JEh40thCQG8vq5SqgfUHQoeHFWH4Kohx+iArt3bjdnBFMqvNeR2x5i4WIJlyOrPXH+2k8BH+OfOCGUlUbTzB+4F2+a/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mr2rRZbrqiZvM3P2Mbiv7Hhhh1gtLUGvzA4Eih0xk+o=;
 b=G/Jd5h77qh5imLSthgYp9HRjnMbbqCkaqw/1i9ZsKQRBvMcKcSuYDTmm3RiU7M79x4o7V2Zc+0SxuAtfDG6bBq5QTG3Yp5IA0cV/LIKlnjZZu39XVcYJ0zayS9/z6U7HsD5kaRSFTGW1OzjXSm1mKIj1ctGHOTam8dyvN4cLVYZefAxDTr/GdSDGtQyPI45PCnuySoXnsG/AM03UpbTTSebus85uijbfZLvkC+lv/fHcGTJz91AQqIwQSeBo30ZC1DyKdhZ8JI8bwMYcAs+ScIfU8/pdCs+nIHaOsWhpCnjIrE7mUS3MEFp157nafH70fWrSkIkpKpAGWY8mze3yKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14)
 by MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Wed, 8 Jul
 2026 14:12:27 +0000
Received: from BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c]) by BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c%4]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 14:12:27 +0000
Message-ID: <d4307831-7634-4b43-a909-1f7e8664e852@nvidia.com>
Date: Wed, 8 Jul 2026 19:42:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] iommu/arm-smmu-v3: Detect Tegra264 erratum
To: Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: robin.murphy@arm.com, joro@8bytes.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20260609073204.1760077-1-amhetre@nvidia.com>
 <20260609073204.1760077-3-amhetre@nvidia.com>
 <ak2K2vhIQSTNAPto@Asurada-Nvidia>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <ak2K2vhIQSTNAPto@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0069.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26c::8) To BN5PR12MB9511.namprd12.prod.outlook.com
 (2603:10b6:408:2a9::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PR12MB9511:EE_|MN2PR12MB4159:EE_
X-MS-Office365-Filtering-Correlation-Id: a8a4baba-2461-4225-2a1d-08dedcfaf0f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|4143699003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	NGsTSiwxp22g4frAwT6DaxW1UR1lxSYPUw8vnQkCZ8G0rUaSjBu82KPTiiQI5Sq6X0Fn5Vyp8BBnJv/jY9RRXWbQhqQbm5EPrnDXgftbQz/UgaM/4Yj/shBuXRVgKYTDYngLyYjS6U+GDPoimwGXcgIBCalqCp8k9cI+FUdF6vqyH+lZVQS7jBw6WwHVwhEt+hGcQuxYj4WljYvNrd99V0HjGVwg+BYhZDmTlmkozctgVlU6VUmtwCnv2OfZYmLm7IcygyEnNn/2K1uzcMXAFP9WOt2B5ghmq2yIUb6TbxIcCd2moJLDQFR0UTzQdTJg0aH/g4884mKFa+WU8gKQhY6KK4EF+uyB7HLPLPiJobza5q+K7idMwmzMaxu2U6onnfi3Nt6Y5dtDl5Rd8GPcee4FJxWKzp0PTrLMfyXxdp+d29Vfu+KXqPVccE6zn3v11oeAe0Vdsq6WzpFbGfTQwLOwduxauBDSDY/GQ4a2/eZ2bgMNc2lBtmS4+dX60lcTa7iXCDyccIScRpM2XEcVejgDUnIezy7Vez3TpvMMA8InPhVEE4+h0AaGxiQMN4Qu6S95dTH8+G2Xh7qQiYCl+n20THWNghxVW0eCBuFw9A07c6GAynnt2o1yJs33Qp5wpeSBulfsO9HpKdIUmvE8Y/GlGrHVYVlEt0d6FxGEonQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN5PR12MB9511.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(4143699003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enBGclh3c1pXcThlbHRxbGdpZFNmZG5EWG9mYW9Iczd3ZEZZR3ppQmxlSDlB?=
 =?utf-8?B?RllOTUVKbU9MWDZCWmFrMllOTFoxdWFkRFdMU3paaEI5RTBwTUtVTHdDeGty?=
 =?utf-8?B?OE1iTG5Nd3dSUWFoanFjdU1aZTlFUEV5d3lVc1dJcjgrekxnWXRWeWkvN2No?=
 =?utf-8?B?Wmw3ckJ4MENVSE1EZ0VtRld1THNZcUNRRiswRlcyTWRGOE9LTzdqeTkvZzgr?=
 =?utf-8?B?d3VpR1NEKzJNWXh3VVN5M1JuMVFzd0YzSnB5RlJlU3Z2bnh6OXlONEYxajZk?=
 =?utf-8?B?UlNramJtUWZWVUxpak1qSmlhY0ZuR1EyUitpNDFDQXZ0SGVoZVFPYXZEbVZ2?=
 =?utf-8?B?NDBsL2JaLzRkR2hYT0JlRFJWQUQrYi9GQnlzR0Faczdia3NrWjVhM2Z4YUV0?=
 =?utf-8?B?YStIeG41ZXluVW5SVU1sNDVCQlhlcEZCRjByczhnRFZkZ2pKQkdLaWFTdk5C?=
 =?utf-8?B?dXpRR0krdGFCOWFUNjhvUTM2K1lIRXZQNXFwSlFHTTRQK2Y5Z0Yrak5Dbnhk?=
 =?utf-8?B?bG5uRXRXM0pUS0pERGdodXh2YjBYTFIzTmpPRnJLR243QkcxQ2lFQkdhSEpO?=
 =?utf-8?B?UVA2ekx0Z3pYU09WSmpTcTNQMVlkdmlNOVFhdjhCc29CVHM3ZCt0UTdyWksr?=
 =?utf-8?B?ZEV5WC94N2UwcjNVb2t1VHlhN3pFSlovZGR2NnczYzdtcGtaSzEwNUJZMi92?=
 =?utf-8?B?SVZ5SEUwdHM0QWVVd1ZoM2RoMVZIdWVuMXJ2ZHJpZVNRdGY0K2g5VEhFY2ow?=
 =?utf-8?B?ZXJwQlpvWGdnWm1IWVJWYTBvaEdPMU9TSlpzTlM5dnkrWTVRRFZ3SWM3czVS?=
 =?utf-8?B?NlpyaGorQ2plUkdQK25qc2YvQmpxcHVxTXZPM09MLzkxT29DQTlRTC9PQ3Uv?=
 =?utf-8?B?Q0tQd3lwQ2pXWi9sMmVpNlVMem9uYng0RE9jTEZtcUVpdHk3UWZQakk1Zm1H?=
 =?utf-8?B?cDN5N25YMlFsbldDMDA0dWNKcER5elhKUVorUkMxa1BqNWFjTmRwZklmL0xE?=
 =?utf-8?B?VFBKNi9zMDB3YnVJWFdNelhUaTExWXNGTUpSL1pRSUwzQ3RtMFdBNW1Vejhv?=
 =?utf-8?B?cXlMSUwwZGVuQnl3Tlp3SnNCUjBucENxODNDS0d0ZHV3Z0FYWTZnWWJWMXRY?=
 =?utf-8?B?TnFRbHpnN0FLYmpYR0xqbXZ1YlB2MVRhS055RWp3VUMyQ3V0YkJ6aEV3N1dX?=
 =?utf-8?B?UXJhSml6T3BUelRSNU52SnlJQk5xYWZwZStGTU9SRlU0L00rNGtKb1J0YTJp?=
 =?utf-8?B?QXpGcmQveDRhRnFVN2dRTHBvZ3hPSHlDNGRFNHdVbjFMT1hpOFphei9ROFBL?=
 =?utf-8?B?VHZBR3I0b3pFREI0V25iTXVubVVUWGgzVWduNkZsMXMwY3pZVEk4bWh3MjNW?=
 =?utf-8?B?SE5INWJoWm4xNVFaTGhNZ3RkSzZlZE9uR2NqZ2ZGamk2ZEF6ZU9hQzVQbE1V?=
 =?utf-8?B?YVlwcmEySXlGTFhqYldNSmZTdzZwTmhnME5NeGlDQm95dFdqR1RZcmR0V0JT?=
 =?utf-8?B?R2dKVDY1MUVKVnpXbGdlZjBtTDZDcDQvQ3JNSmJtR2lUeS8xTU9SUFUrWDVE?=
 =?utf-8?B?N05OK0pPQ09BUlhHU2poZE9NUUNyVGxsMFdRdnlLS2xZeSs2OE9yR0Zua0VE?=
 =?utf-8?B?cXFCZTM3L3FWNmN2RS9QOWhGTmhxZ1lzU2kwa0dZdkpJWnY2NVoxd1hrallE?=
 =?utf-8?B?LzV3VGxRZUdTb056Z05FUGRIa2VuT1lHdUhibkdpOURCV1BIRVFJeGlNY0hQ?=
 =?utf-8?B?bWMyRUZaWkpicElPRkc3MlhQeitZWEl6WE02YXl3bjJycmpJRXFTdUREb2Uz?=
 =?utf-8?B?TXhhbEFMTXlpU2E2K1VFN2IwNUI0aVJCaGdpMC9oTitlVlEzVnJhdGJZUnpK?=
 =?utf-8?B?T25MVEdVYTlLcjhTVUU5aXR4RlZLQkNSMy9FcEsybXFWNjlEdEhnTStrT0RG?=
 =?utf-8?B?Sk91NlpBWDdvTnV4S0dXYUxlL280eVplVmcxYWVTUHhVUnRDOUVKZGN4RkM4?=
 =?utf-8?B?azVlM3I3LzZmZitCUDZJSDMrOFBRdDhpZTR5OFMxcTBmSlB3TXR3QjRobnQy?=
 =?utf-8?B?SzloVXY1WEU4SDZyOEtOVDVIVHlLdklLQUlhTVVPbUJWb2YzZFFQaDdraTFD?=
 =?utf-8?B?TlhMWlpqbUdNVHZrK0ZMeGVENXVnMVh5d1VnOE1YMDBLbThmSGwzNU83TXRs?=
 =?utf-8?B?SVBXaENiSXhZZERtTGdzTHZkckJEUEU5bEFMdWlheW5FY2V5M1pjSVRQeDVu?=
 =?utf-8?B?S0REU3lIUWR4Slk4MmlwVWRtdzFYVlE2K0tSZy8vTEtFTCtiU1FQVTUxbVhp?=
 =?utf-8?B?MWFnMjJORnJmbnpUY1RFaUtvVUhTVDZ3V3FobnhSeFpzRkwycVU2UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a4baba-2461-4225-2a1d-08dedcfaf0f7
X-MS-Exchange-CrossTenant-AuthSource: BN5PR12MB9511.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 14:12:27.7217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8rwkXwfSdXs0wxd/TwchJeCDk+LuL+HgyLqgQWlHL6CLwDtR3WhtzXBh/cZmD6abMBAjHjQQAkgQYd/ylCUDPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4159



On 7/8/2026 4:55 AM, Nicolin Chen wrote:
> On Tue, Jun 09, 2026 at 07:32:03AM +0000, Ashish Mhetre wrote:
>> +arm_smmu_erratum_cmd_needs_repeating(struct arm_smmu_device *smmu,
>> +				     struct arm_smmu_cmd *cmd)
>> +{
> [...]
>> +	if (!static_branch_unlikely(&arm_smmu_erratum_repeat_tlbi_cfgi_key))
>> +		return false;
>> +	if (!(smmu->options & ARM_SMMU_OPT_REPEAT_TLBI_CFGI))
>> +		return false;
> Are they redundant?

Yes, both are set together in exactly one place, arm_smmu_device_dt_probe(),
guarded by the same "nvidia,tegra264-smmu" compatible check.
If we want to go with static key, then that makes option bit completely 
useless.
Shall I respin v5 that uses only static key and drops the option bit 
completely?

Thanks,
Ashish Mhetre

> Nicolin

