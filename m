Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011068.outbound.protection.outlook.com [52.101.62.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03B23B841F
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 15:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778598890; cv=fail; b=R5c41rhYmdAwMvfq5CmYNPbTQPwPXAeKzPEzw4C9q56AADyxBkQGkBBB9ugHy51hovEK56GupDih+1U3SQPp4s1a2Tlf6esyBPyN6ZRfaNdEYyu1/F4lHdDg01UZtxacTXGZLTVvRsPxD3z16Kyt8X2tyVROq0IaXLisDSf5D7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778598890; c=relaxed/simple;
	bh=+cYGoMSx8O5dVfY5lAsHP5Z/gZOqrYdH1CqBjCtMKUE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KQf0ZjrEl04BWq+p50NoJmLA+pta0ec6P6rh5oyP9zoeOUX24ihdICF+zrsKr6cE9lvbOH14X90SYIYqqwDLAy+wt2nKcZJnNVTt1NAg1XbalznQSpBYJxynFxFoUYKigxrcMr053T7lTuELX+w5Ax+w67z4m6fMHSuk2d3vtJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g76N6GoG; arc=fail smtp.client-ip=52.101.62.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g76N6GoG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=utEDYTnUjG6Jitv4pSTOYuAnWCNX+6jTlEpFlMyxnw9u4rMUe3hoZ32d02YECTvbVKG3xgK97XnhZj/P7PAEm+k4KvGnc7wEMUEDXuLMvTuOYuuX+2ytDfIe43HcKXcK3oj+NLLzO5qv3EmCcmZCn/5AnxxBV3wPeD12m/w/2u38b8rVABocjRF2nuTZ7BYS4tD0etaHmPFUE8sd95aipzL/AKh85Btm4gWdmAcQ0TmCMwMsFVINXn4PX6/nHs/0YH9jodQCbENMLdt1drcQinNhCDOhCIoey6SDgTFR/gB8JJdcy3+09X4pLTFBKEDrQ2HsaaoWYK2pohGrkqyjdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEfSfQo2orw/4dvmhZTjNdVgg3uOElXz9iJO4nD+Ef4=;
 b=kd2eyC3WVniYO4ssTiRJu7QYb9ThdGuO6oJNS8SIHg6qXPBBdpBV36sNYIWHyjRaceevZtJ+/U24kIkvhOR8v7o4GEqwgxAtuiLCULNR/XCIEPjeT+U1LfThIHFPxv8kZirHm3GO5kbmQwr2x3d/yYuBSom0gg458K5W1Drb5KR+4ujR0nAeQEPGUF3O66LyJuU9MFhq0GDHBqFBbumEqgEIWsKP067sZiuMaMcqt9f41MBenWUR7etCvNDrgTywKrlUCnciu0ZVLTlV939sUyR8Q923BbADeifuJQMSU6OeYMsdr7582ThWPS4bXLcUkcHBrDCZudBPzGjRhi3eUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEfSfQo2orw/4dvmhZTjNdVgg3uOElXz9iJO4nD+Ef4=;
 b=g76N6GoGo1XEt7KBYSgHe2WH0zL7szya7qD3+Y2w8lMZVo2cz71itiZFSYyZqqKeaX/IQ+3atyAHE3QaYIqYCHIS46SPKDu20AGC3T/UXcmQcNkrCWCdA3RVYjXRRkUiPYelTOenBZA3wrZsNhwCxpf2uAdny+tiMkORSAjSKUI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DS7PR12MB8231.namprd12.prod.outlook.com (2603:10b6:8:db::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.11; Tue, 12 May 2026 15:14:41 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b5e5:12ea:9815:b7d4]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b5e5:12ea:9815:b7d4%3]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 15:14:40 +0000
Message-ID: <0433004e-b0d2-4ef4-b382-0d2b577362a7@amd.com>
Date: Tue, 12 May 2026 22:14:29 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/22] iommu/amd: Introduce IOMMUFD vIOMMU support for AMD
To: Weinan Liu <wnliu@google.com>
Cc: chriscli@google.com, dantuluris@google.com, iommu@lists.linux.dev,
 jay.chen@amd.com, jgg@nvidia.com, jon.grimm@amd.com, joro@8bytes.org,
 kevin.tian@intel.com, kpsingh@google.com, linux-kernel@vger.kernel.org,
 nicolinc@nvidia.com, sairaj.arunkodilkar@amd.com, santosh.shukla@amd.com,
 vasant.hegde@amd.com, wvw@google.com, yi.l.liu@intel.com
References: <20260330084206.9251-5-suravee.suthikulpanit@amd.com>
 <20260407064607.611771-1-wnliu@google.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20260407064607.611771-1-wnliu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0001.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26a::8) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|DS7PR12MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: 1900e779-671f-4b51-95e7-08deb0393066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	T9qL/n70fZxakr+4VngOp98rl3A9Te+lUFY3JKLXEA0W8EZgFEHAhXR5TSZj5jWp4XjYDFyZUgEutBEKE75KYIGKaYyk4yeFKWHkOM36WV9M9T+2N2+zFIEnonK1NaI5vF19q52oMswmftdcoHrI1zJNAmJMIPXfTFcHOxlhGyyq82mgvLnhpba3zEeupKkiPmPVsiBNdi32qQ7GedcvQJM1UQDNTQ+MyefTCPmH91YV9EkjkHid4tVeGuJdPslFFREajgODOwgOZfvfY74nL5elw9dUJwxE0ofUTej2zSEx2uA/0sdkP9a4oWEuxqdy/bhAP/IFToVxW8GL72a8UWmRAqMgp56zxtg14AiLRBRY3EvMFMs7JnuT75scE7bHFZ9xDK0rK23dJ6zYu123CL344NzVFZBlVhYA/e3sRqvARpVQLSLp8KDi95mYUwqbQwED1GLGq/fVfBmQZfSwdgiEZQbkisUwdO29DdFVCx+C1jtHntbacL+W9fV4tf+cOmTEe9Jjj9UjG+jP2kHjQ9+sijPCooHhx3WIXSmBi/QnrmfIEk7pwlWZgndUZu+dhQP8infWcrkAVATizzzdxQM/0cDPcqyd9ezhbaRpglynw/4ra5AARwUk3LqBCyTRitjqWKW6/EWuX51PmxknYJv19OgESjU+gRjcGF6+24j0Tim/jsTqrDp/YrQvzO1W
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3g2MzY2cHlrRkhTVkhmbFhjRFhkcDd6a3RPSFZuKzdQdE9Yalc2MXBGR05v?=
 =?utf-8?B?Q29HanBJR0kyMklmNks5TmZvQVdyMVNXbHhDVUtxNTNzcmhTS05UMVBSWmsw?=
 =?utf-8?B?L2lwUWJFUkhUUTVBSHYrV1NpRzkycUxEVDVaZE80bVcyK09vQ2NwU0VPSjJK?=
 =?utf-8?B?MWw4VWRvV0dhMCsvNEJCUHdHS0pSenRqNkhCbGdCc2JwWWFrVVpleVhIRXo4?=
 =?utf-8?B?dlRNalJraThNZElGSnQ2YWw0Q2oxTjVvZFEyUkh3Yi9GQ0tRWGppdGo4bDZr?=
 =?utf-8?B?ZHE3ZWZTQUtrcmUrOHc5R0NTL1dvVFRFSm1PNDRPQTNWbEdJeU1SeHVoUzR2?=
 =?utf-8?B?cU9ITG9yNjZxcnVIMjNkVVR0cHpiYzBCUzZDeEhJeldYN21XT05tTFNxeHhN?=
 =?utf-8?B?VVgrbnd5ZlBybHZHMDh1T3JlMG8xenI2VTVGSUZZc1JlcUd4YnZ6T1UzV1N2?=
 =?utf-8?B?WVptdlkxRnpmMGR0STdGV3lrV1JMQlM1azBXeHRlOXBma2l4Yi80MkVUZjJI?=
 =?utf-8?B?cVF1SjBCS2lwZm1za1VyU0lHS1VTVWJtbGRWdUJSeEJlVHNpRnhCbFNHckNX?=
 =?utf-8?B?RFlnd1pYUUFETVFNb29Md0VLU0ZtQXoxVDV5S1JSK1h4c3d2dDBnTk0vZFoy?=
 =?utf-8?B?TFNIWkpNazNBWDNXVU5DNDVUSkJpcDI2a3ozdGxZY2Z0R3ErVzY5Y1lnVXFU?=
 =?utf-8?B?TlQ0WXh1VTZpdVAwQmhVMWhqTUdIRG5tQXNKdVpuNm9pYUM3SmhEMm5TYzVw?=
 =?utf-8?B?WEQ2cmlURGdHZytyOHg4VXhtcUIwUVFpV0FNWmx0SzRieXhnaG5aY245alhG?=
 =?utf-8?B?dDJPOHlmY0dTYUVCU2FkVUV2S25xaWN5MExneWVua0xvQU5jSExWVWd5ZFhN?=
 =?utf-8?B?cUNMTllaQkNEMXZsM0ZSQVVhZTl4eFZwNHJ4WDdtVjh0aHhTVjdWcm5pZkox?=
 =?utf-8?B?Y2N3U0VhbGlEdEVkZ1dueE14YzkyT2RCaXMyTVNFMWRPNVByNFJFZFR0V3Q3?=
 =?utf-8?B?ZFZxZHZoOHhFOE5BaWZ1RnZtV1NBWHlZb1lqYURTZ0Q2ZDZYRlVyWlUvKzUy?=
 =?utf-8?B?MU5Eb2p4VDhYclJ2T3FiMklFZlg4Nis4OG5CTlQxNFliTEFwblhsU3UvMFBZ?=
 =?utf-8?B?NnFJK3ZOWFJZTzI0ZStlczB0bDR0Slh4TXd1Q0NkZkZGbFpaUjBNVDBoTmdW?=
 =?utf-8?B?OC9lWlNMSXJnUzdyRXB1WW5aMlBPZVZvSFpCTlpqUEpLTTN5bHdSVUZQamsy?=
 =?utf-8?B?b0tiamg5RkUvUWx1Uzc0U2NRTWROUXZFT1huRWQ5N0FwYjczR0tKN3h0czF4?=
 =?utf-8?B?SEUrQ0RCN2NxcVg0YzNsN3MxTFlGM3pzaU5FNGdnRnRESSszRzZjR0Y0Mm5s?=
 =?utf-8?B?ZUVwRnZZcDdqV1NNdjhJYkNDdzM0dGxpdDhYTWhGT1g1MmJBdVNWYnI2eStx?=
 =?utf-8?B?c3ljdjB2LzI1bmg0c0lkRjEwQkhKK1VleHNJcGk3NW85SnpnSDNnekk2dDR1?=
 =?utf-8?B?dlc2MlFpdEpnYmhQZThya2RoNmZLQXN2bDU0Q09OTjlhL2NFVWxIQ28zY240?=
 =?utf-8?B?ZkRBQmYraTJpbThlVVA5YlZvMGd2MktlZFVPeUVUV1ZYVDF4TDdBZkZrZ3pW?=
 =?utf-8?B?L2xVeUZaMEFkN2V6MlhjK2N4UFRsZ2I4OU13Nk4vY01XTU1LUlZFWnNCVG81?=
 =?utf-8?B?VmRKL3MxNTd5SnlwQyt4bGFqQzE3MjRYQUx0YzMwMmFaL3RJb2ZWVytXTStq?=
 =?utf-8?B?WkQ0Y0ZYU3NmSndGQlVaNUJXbDhSV1NlVmdJc0U3aDE1eE40YW9UU2V1TENp?=
 =?utf-8?B?dkp2QTRpTXNtZ3dNVlZTQVVWazc5RWVUUmp2T2tzdzZia1VEcDZCclNDWFM2?=
 =?utf-8?B?enNBOWhEd0I5YnhncjRmS2tWNldxNjcwRVpqbDRUWFJJWGs3MlptdlJrUWFa?=
 =?utf-8?B?ZTZWZGNFTmlSRE5OSS9EaDZJRmpacVlvTU9kOWNtN0p6WW92czVBS3hiSHNi?=
 =?utf-8?B?V2pYYjJlU0VPdjJQdzFtTGRkRzFVQTNoaEp1V3RVT1FyeWtjcUptYlpSSGFk?=
 =?utf-8?B?MjB6U0phMkJ4Wkt5OVVWWW44UkJVQWVNQXBLdmxncXpraUxJeTRDVitKNUJp?=
 =?utf-8?B?enZoUXBqT0F0NXFGRmZrY0NqZlB0aHBFVkVwL25iVnlORXcyeFVYWkJxQUty?=
 =?utf-8?B?akxBZFBnNTltaGJOd2JZK3FjaU1zbTVMTmdpRmdXNXpVWWYwWHNKWE1TcHlG?=
 =?utf-8?B?TFZrT1h0WnkxZk9aOFJVM2NNOXhxS0xSQkplci80c1VEQ1pIWHlUVkNIelNQ?=
 =?utf-8?Q?lkfGN0WKS+Xo63KYDU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1900e779-671f-4b51-95e7-08deb0393066
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 15:14:40.9029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJz3dOmyH8qUDzlpF5Ud37t2Byv3taVex8S7kAYQDRCgVZbP5OK9zaSw1SPAfF/A9u7+UfpCFwjBGXjCG2H3XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8231



On 4/7/2026 1:46 PM, Weinan Liu wrote:
> On Mon, Mar 30, 2026 at 1:43 AM Suravee Suthikulpanit <suravee.suthikulpanit@amd.com> wrote:
> 
>> diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
>> index ad627fd5ccc7..e7ffa7e8915b 100644
>> --- a/drivers/iommu/amd/iommufd.c
>> +++ b/drivers/iommu/amd/iommufd.c
>> @@ -34,6 +34,9 @@ void *amd_iommufd_hw_info(struct device *dev, u32 *length, u32 *type)
>>
>>   size_t amd_iommufd_get_viommu_size(struct device *dev, enum iommu_viommu_type viommu_type)
>>   {
>> +       if (viommu_type != IOMMU_VIOMMU_TYPE_AMD)
>> +               return 0;
>> +
> 
> It should also return 0 here if amd_viommu_init() fails or if amd_iommu_viommu is false.

I'll fix this in V2.

Thanks,
Suravee
