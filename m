Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010028.outbound.protection.outlook.com [52.101.46.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2A6379C38
	for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 16:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785257346; cv=fail; b=F/8fDujYo/Q93SQhEgOMpOQWs7K/8Kg4y8RNttk1vLwGAe5wQfvF1KuUgljLpQT/EnG9mT3zBK60O7mYcK+XSI9nqD9Mo0ItTJwU/K3iOt0/s9Ncb+1BIgPjWq9PGmnTfdIX3uar+bRXcJk73JsWEbJsK4pbQnfo2j1FwHwUW7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785257346; c=relaxed/simple;
	bh=+YG1hAPQ5yecT43idajx88+xT4ruP8+kbWrpUdAnPT4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QppJ4/HvPiCCsL97bvWrCvuMamjxeB0ERkdI0FLLCqHi8rX8Lsm3UrB2KdHFH1RsE08lanJuSdVFqgVBywhuA0kOCwP7FmpG/hTUHHYedYm+hf64ZAn67xQENDVZTxFRl8zJfrkNpBHKfnkkr7sG8oSdxdkxsBy7IXNfv885FRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O7oODyw2; arc=fail smtp.client-ip=52.101.46.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O7oODyw2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IlkcadiSLHMK1Kj8Kk1utK3Crz74VekV8XFRrplo06FraihvFqwYOPnbp5Sfo5I3JQP5hjaa4owZwaw5ZJoIEp/pMjmOsAkO6dkgTqvWbUXhuGPDZocOMOQoDwTXYERmQnSzRy7FaN+bZBLs0dEKEBoNhGPamnJOuW0SXZMbKy5cIRi05W2rJV3VJldtygLxqorOa5ayDVxVd2eJv40lStM+W4jfAgK08bsZYSKBp8dNKorgnjxzMQR1gWGiRARm9DzobGEKpHfp+4D8CdkCu44D3cE13N2kY77lUH/bSO/6/Htjjsj39op4V/9I+oiP1i9p5pj4jJqW9lML7sJvvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bh146brJyxVw8BlF0By3FJnRwmQd4DEWshuzyMNUS2g=;
 b=XW9SXig/eUpPIXzl7qcD2L/6HuXMWwErm9ek/t8Vo9Kr/ze6NBz/McFr3AAuAOWPSZ+h6uzPtiPv+zPzjiToFCa2H67PWkisAKtl9Ga0LVcmo5HpD104xRWHqYROvLDZUrWl9Hv/CRgChK61H5e27yoKzAV92/VliDJLKPi4yV0KAz4Cgo2uIfdzjUClIo7iX0AEqCUUiOGXPriIK0VDKnbAuxqWNXYIIhWIBzB6+wUdME/2eSSLJ+7cOzjXph5CHsEfrcPsofCzIOWTTiNij9u/IIJcsWk0VGlubYQopTkhMnl492HBU/rEpx84CS61CwifKKDIWN3WCUFa30Ti4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bh146brJyxVw8BlF0By3FJnRwmQd4DEWshuzyMNUS2g=;
 b=O7oODyw2asdEblaXjYjFuwbleuL4NLszSZBfs43NMmOY0Wl3UWPqvNaf8Hlz4CidAmi1YWrlk80UWerABs0FVn1EC/QFPxL1tuMQXqnHRP7TQ1x5EU5h3po9C1CqSVIORew6CPDNjh3UMA8oFYaFAJ7J+Vdkv52n7zmJmT2isUa3+xl7ReqyUdyhgpCujIcgubb1HLlclG3fQ/YNWiFsn4w6FwZE+Iclpz29FVJwnqASGlCknzNY/myTW52ygUhObFPEzikMOShosJJOckBgrty3SMFat9kKDOh+TAwalP28fuMSzpP2ctFc1A9aN8psFdJkpHz53mzehVPhRMFBhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14)
 by SA3PR12MB7831.namprd12.prod.outlook.com (2603:10b6:806:311::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 16:48:57 +0000
Received: from BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c]) by BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c%4]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 16:48:57 +0000
Message-ID: <6ad7030d-2f19-425c-ab1a-b96a91ce9974@nvidia.com>
Date: Tue, 28 Jul 2026 22:18:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/4] iommu/arm-smmu-v3: Tegra264 invalidation
 workaround
To: Will Deacon <will@kernel.org>, catalin.marinas@arm.com, corbet@lwn.net,
 skhan@linuxfoundation.org, robin.murphy@arm.com, joro@8bytes.org,
 nicolinc@nvidia.com, jgg@ziepe.ca
Cc: kernel-team@android.com, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-tegra@vger.kernel.org
References: <20260726081904.1408859-1-amhetre@nvidia.com>
 <178523218770.339148.16144926256012413621.b4-ty@kernel.org>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <178523218770.339148.16144926256012413621.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYP287CA0097.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b9::11) To BN5PR12MB9511.namprd12.prod.outlook.com
 (2603:10b6:408:2a9::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PR12MB9511:EE_|SA3PR12MB7831:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fdf2e04-ff87-4032-2615-08deecc81db6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|11063799006|56012099006|4143699003|10067099003|6133799003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	GCX2GLIDhFfhA45CRbenx+TX6cAAA/QNyHlsQ/inV3PAjjnwZx1b/QbR/PB5sIi8KaAPzCrf8Hnj9Uoo11CaEyN64NesVjuFHcspEbS7Q3QZlFXizJ1+yI2TljcimTcLzQaoVfFj/3gLh/46kc1/NE0s6HhsLH3Xa69uz/2COJU2Ug/rXtP5IBSWYp3NdfboW46y0SB3mQNK5nFOZ3JSacA/Xfjp7J27KvHsJJra7WHq/0esRkl7/OE/scAjwV3CxWRhEACN2IlBqgCFfjb/mzjjFKIq7eqSq0UhfjfmBSlyEQheC+f0ZIfUrIpEu5kKE5riPVb2cHMquE4WfgDXeghz9hxCLeEiVjsdQEzIsQ/lSjDGzHUZB8OJVMdckjCTv8yG6U4OCbWewuTk+P+Lu8hiLhn1BRWcJsl5EAQoM1Aj2dzkL6M2m9kRX6wFvjNQH55/Yh1dvgpv00DK8DYQsgPtul/BK0Q/63TPCfAy3vsdky+XoBVixi/10Uz1u03Y3RJpO81GLcLMAesEKBDEqyjgdHQrD2cX38oC8nLZuxB4yeLJLjribSh+Du2qO02VSRBVAvsFELBAN60ngivTclwVFPScua32EyMhgf8/Ubv7TrI1sE110HmVgaYnxPm2LzhO/o+yn8bUXaGvr8wZnEOquyMRPWumhiJFI4nXFio=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN5PR12MB9511.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(11063799006)(56012099006)(4143699003)(10067099003)(6133799003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEF0bTZSMnNRZ2VWeDB2TjVWdTZVWmRkZ05MeEJzYUViVHRUdkJSRXNUWGRk?=
 =?utf-8?B?Sm9xcGlEUEpKM0t6NjQ5N3pQbFRZY2R6Wm5ySnhQb0ZTRmcyZXlGdWRNZWkx?=
 =?utf-8?B?NUFNWlJ1VnpkNFd4SHV2SlFrQVlxV2dYVFFIYXYvSHA5MkVNSE55bElTMGRE?=
 =?utf-8?B?L0JyTVZNTmMwYVNqd1E5Qnh2V3hFT0RiVzNEaG9CMVYxL2w2MG1lZDloSFAx?=
 =?utf-8?B?UWFzR0ZDQkRjUWFTTEY2azVCYitZem9xNlVqSnhaejNmRWxqZ08xbEFQL01S?=
 =?utf-8?B?RkFDY0M2SjBzenRxRUZmZVh0V3BaUEZIaDI1Qy9PRnJxZmVTeTJaa203dUx2?=
 =?utf-8?B?T3NZNmxBeFYyaDJpNVdvYWdXU1c0bytySlYzbDNzdjdBMUN0S2o4N2hCUjgz?=
 =?utf-8?B?aktTTjRnV0J4Tlk4c1I4REZ2Sy92TlZTU24vemdlRUZNUWtMTkkwb2EvbTdZ?=
 =?utf-8?B?cEpqT3BJaW4zNE45S29acXZwNUhSUjYwQXllT1RWdlBYVU53MzdTbm1uQTZQ?=
 =?utf-8?B?ak9vNG9kZEhCQXpIeG9JTUNzV0t1U2o0L1lUdURnYkxQRXZrOEU0VjQzYmpK?=
 =?utf-8?B?d0pxTml0RWV2bGpSVk54OHltSUVETzZ1cUo5akNGUVQ2UWhXa0RaZVI2VkVu?=
 =?utf-8?B?WWZsTURONTg3Z2I0Rzl3UmVVdzR4cENuT0xIeUdPTlRwMjRQb1UwNGp2WEpi?=
 =?utf-8?B?bThVQjhXSXFVbWxlcHFKaWZjQkgyVE1xcWVLY1owdHFJZVRRd281U1VWUEtl?=
 =?utf-8?B?a0pjY0g2V09NL0FRNFduc0RTRzFSbzJjSXNhQVJmYUxCdG5lMVoxV1pEaWpC?=
 =?utf-8?B?ZTlPWTk1Z0UzZTgwenRDUEN4NC94OGFpZmNhKzN2YjBXTEVHM2d0amdRaENS?=
 =?utf-8?B?cWE4L3BEOWlKN2owZmlkMjRrcWNzUmlmSGl2K2NsaU0xT2RUMHBuSW4vNFBa?=
 =?utf-8?B?TGVWVGkzVTJ4cTRrbjVpanNDaEVuNk11VUVuZ2pObUZQaUpYYXdNWVJlMUVK?=
 =?utf-8?B?WTJybSsreVg0dlZLMFNOTEt0VXcxOFQzRTRGOXpybW1rUit3N29NaFpCRS9J?=
 =?utf-8?B?UkthZzZyZi8zUEZqeTg1d0IrUGhiUTBVVzRQUVhacEFyd0xkV2dZYmRrdGUr?=
 =?utf-8?B?cmsxZ0hqS2dpamRJMUI0aklyNlpCQmpyTHJJc21salJSOVJ1NnpOK0g4bnN2?=
 =?utf-8?B?OEV4WmtkUHhqK1VRUVAxd2pzRlAyalVXNlJ0N3JrSXhLdVdUeU1WNXFFUUEr?=
 =?utf-8?B?OTRvNDk3a3VWajA4cnZ3RVA2Y1N6VkRHY3QvTDExcDNRa3hOcmQ5NU53My82?=
 =?utf-8?B?SFdVdEpoQkFSYVdkUUx1T1dUdlJ3aUFvTlJYOXRMRVpUWm5DMHRWNW13Nlcx?=
 =?utf-8?B?MW11dlE1MERaMi9zN3lxSksyK0RhZnlyYmVSRzZGS051NE1DNWxHTkFjMzVN?=
 =?utf-8?B?SVNIUnhZWnB6Q0lwS0lhYmNQQVF1SjAwVFRHVWh0L0ZqRzVlOGlhTXVUVDg3?=
 =?utf-8?B?dWpQNDBxQ1BBdkxKU3NoWWUvdE9kM3N6VVNUMW1jZDZZK3l4UlRzTHpzazhX?=
 =?utf-8?B?TS9LQXRsZWZqbzV2azJpR2Y2N3NsS2drQ0dhd20zS2RrNEJoN0ptY3FnYlha?=
 =?utf-8?B?WXFhZFEzZGpBYWF2eWJiR1dHa05ybGQyYUlCMG1MVGEySXB5MUl0MnU2aG1n?=
 =?utf-8?B?czU0bk1icnhxRUtPOUpaSHVhSEJhUnIwR1FuRXk4RHhWY3ZvaVdJSUtoTFBQ?=
 =?utf-8?B?UnVXcXU3WkVoSFVBMm4xRldBTlRJQjJLOS81QWo0YWJVKzAvWXYzOXhlS3k2?=
 =?utf-8?B?N0I1UC9PWkR6U1BRRVp3MlE0d3FwM3gzUStUalVpVjJsY1BVMkJNUmxnZmty?=
 =?utf-8?B?eWloVSt5MjY3N05IWW11cTloWWtFR283VWFkTTZLZkY0ZnlBOFRhWGNRZ0p4?=
 =?utf-8?B?R3dzcEFQUkZkWWl4SDQ3dmdPRWdyVEp1Z1JsTklOeWJsRi9JTWsrSVBrUDk1?=
 =?utf-8?B?U1UzQkpNWWhXc0lOS1hyU29pbFNRWDh3NjUyZjVGYXJGb3l4Ym1UNjVDZ0hu?=
 =?utf-8?B?K2tDcXBFbitSYXlPQUhka1JqY1N2Z2FaYXhEa1hqbkR0RklPTy81OWZScDJI?=
 =?utf-8?B?OUE5YUpwQ2lhUkVBQTlub2tmQVFlYjJjSWYvNnlTSVJ1bjB0cmhURlhlS2dq?=
 =?utf-8?B?YUdEWXRtM1ZYQ0xvOVpEUk8zOThXdytkMHVzKzhEUFBWUDExMXIza0VOSmFu?=
 =?utf-8?B?QndBdDZMWGc0aVAzZVkrOWR3QXIyZmRQVUtFR2krbUtFMUZtNmQ3Z0xETW15?=
 =?utf-8?B?aUx3QnR2VWo1cCswTUZFU2xnbmVXYWhjWEhtblBwV0ZoSFZQRlRHdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fdf2e04-ff87-4032-2615-08deecc81db6
X-MS-Exchange-CrossTenant-AuthSource: BN5PR12MB9511.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 16:48:57.2303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Fyc7Y+i6Ng7yWHh4Dn8l6gtn2Wf8u1DYrXUEDCR1KeMSTsmEtdnw7XqaMOtNyDHuLV7Qf9lvvRljw0f3FFGcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7831



On 7/28/2026 4:45 PM, Will Deacon wrote:
> External email: Use caution opening links or attachments
>
>
> On Sun, 26 Jul 2026 08:19:00 +0000, Ashish Mhetre wrote:
>> Nvidia Tegra264 SMMUs are affected by an erratum where a TLB entry can
>> survive an invalidation that races with concurrent traffic targeting
>> the same entry. The hardware-recommended software workaround is to
>> issue every CFGI/TLBI command (each followed by CMD_SYNC) twice.
>> The second issue must execute only after the first issue's CMD_SYNC
>> has completed, giving the sequence:
>>
>> [...]
> Applied to iommu (arm/smmu/updates), thanks!
> But please check the comments from Sashiko if you get a chance:
>
> https://sashiko.dev/#/patchset/20260726081904.1408859-1-amhetre@nvidia.com

Both comments from Sashiko can be ignored.
Regarding comment on 2/4, it's false positive as at that point batches
won't have mix commands.
Regarding comment on 3/4, the erratum is exposed via hw_info. So, it
need to apply the WAR by checking the new flag else it's a bug in VMM.

> [1/4] iommu/arm-smmu-v3: Factor out CMDQ batch force-sync conditions
>        https://git.kernel.org/iommu/c/097bf4a02f2d
> [2/4] iommu/arm-smmu-v3: Add CFGI/TLBI-repeat workaround
>        https://git.kernel.org/iommu/c/95ed2da20283
> [3/4] iommu/arm-smmu-v3-iommufd: Report CFGI/TLBI-repeat erratum
>        https://git.kernel.org/iommu/c/d501d66815ee
> [4/4] iommu/arm-smmu-v3: Enable CFGI/TLBI-repeat workaround on Tegra264
>        https://git.kernel.org/iommu/c/06b15ddcfbc0
>
> Cheers,
> --
> Will
>
> https://fixes.arm64.dev
> https://next.arm64.dev
> https://will.arm64.dev

