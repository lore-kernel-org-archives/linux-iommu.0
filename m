Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8049171675
	for <iommu@lists.linux.dev>; Thu, 26 Sep 2024 10:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727346584; cv=fail; b=f7pmnKC72OgKJ4gHkg3gOPu3De0Sp3xTpkHbyNci+7aVKk6wfxtPu1XBjAjaLGJAnGI+r8i3sw5E/u564nqLG0hCHVs/e6DqN2gAqS8j7SC+VofDzGJEInjTbIt+lj1FJrsiy140JYuGWcEebHjGi8Na/RnYeBGiAwoR7VTO3Z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727346584; c=relaxed/simple;
	bh=mim1vTXVrFOoYYsS45Y/yLF0uDGLGZlQMnj+QbDLQ44=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XhVg2tVKNJ926Nq9oH3FnzjgsN+YzPsNLq+0TvAxAyvsYilRim41fBHgq/wKucv7/dLkhh9DD84WIsEicOAIQEPE0KyCgm7osWt6ceMDxqdM15Ohx7MiODYkKJ44mFabtnHmG3IWM6RMZ9Y/paJaveSUTYff8c3PPHdY2h8NzU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wxBXyefO; arc=fail smtp.client-ip=40.107.237.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wxBXyefO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mnv920VD5/i3HzJH9DsuKah69QuFiERZaeWPawO2Txx+PoV2qruCMnmkjkAtY52w414uNz1Ct+DuLj57glHCwBXHYWkoSbnnOMf05jxo4CaCnw5fbvehoMgt9osLaRullyb3xgleK9ZP97+CkU43vDcpdkHOOHG+UxRKOZndN6U6e67Lk2kUWDuOI7SD6hQNrR2HS7Mn4FfBsPOS0WJlbD0ZkOZZy8Vl0Q4kUv2DPOagH85OTQNLhchDP2eNEoxF9G41W6Cb5vqfHXl6eSKUr0sCNFExMTctwvM8y4SFpve5nWOO7u1aAePatpE3Z8aAWALgAp61WhPwQkC88iBPSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1NIdZIO5/c+Bmw6oXFmiugy2DhIx2ZeY8DPg4JAKGI=;
 b=dDEYhvUhr7Nc1uDjzhV/pEuNZo4DnEbSzJPg5AHtFtzKlcbD9N76x/+x5dXbAVnPNzF0IMoUOJg8fcs5/cAXPtWivcZaWBegBMS24vMn77dogAwuFVybOXfq666ixISWoverZS15JzWqN2s/w01XLIbTUhSZgcaXo+izbZV4iX58dG51cBs3bDLkNZ70XCK5hZeaEh1BPofN+IWkrE1xAwoTwojDh3mZOQT0g11zvKCVxHOug4ZqNLUqypzh6aCNKmSUpmQYrWA5Gq29saSPw5nqH0R4kTqj4h94Ypax+ZnPtQiWc7pcdoRfY5ZbpUr7JsBP1eOeSz1To6ouTTgsbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1NIdZIO5/c+Bmw6oXFmiugy2DhIx2ZeY8DPg4JAKGI=;
 b=wxBXyefOrDvgFTvVsOfzC2lAMhmzI0tYAs/OqSaZug1faQE95wPtjtKRnKm7wQo/IctuSdR01HFf+n26sLukbBv+JNchZfvG7mdM6dbdhae7kT2zuqpQ2b9a1q2DwVKZjVJcdat1pnR4twI3Ats7HBIEZrHu49SQGDaAmUFuVRU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS0PR12MB8443.namprd12.prod.outlook.com (2603:10b6:8:126::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.21; Thu, 26 Sep 2024 10:29:38 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 10:29:38 +0000
Message-ID: <dc29a3e4-04ba-4bfe-b06b-67c4d5bdb5a1@amd.com>
Date: Thu, 26 Sep 2024 15:59:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] iommu: Add new flag to explictly request PASID
 capable domain
To: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
 joro@8bytes.org
Cc: will@kernel.org, robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 jgg@ziepe.ca, yi.l.liu@intel.com, kevin.tian@intel.com,
 jacob.pan@linux.microsoft.com
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <20240911101911.6269-4-vasant.hegde@amd.com>
 <a3e09a90-0b63-4332-9e25-a5832d5ec8b2@linux.intel.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <a3e09a90-0b63-4332-9e25-a5832d5ec8b2@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0145.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::30) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS0PR12MB8443:EE_
X-MS-Office365-Filtering-Correlation-Id: 355b4aaf-9340-48be-6034-08dcde161f72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1NsM2wzOGZ3MkhoWGRlb3N1SHJsWlJkdmJsNzBWdXowSnI5czRXMUxhNzF0?=
 =?utf-8?B?SnNGYWEreXZaN3JybDdxeG9ONG1wektHQ3ViY0JobXJZQTNkcDArVjlwZTNz?=
 =?utf-8?B?YlJ5N3g1V1RTQnBCeXFKQlZhMTVZUEMyL1g1aEw5ak0rT3MzT0FmSVdBWGNq?=
 =?utf-8?B?aDZhZVI3MjRJQkdhREFSTDdNemNtVGtwUk56TW5MUW5NSld2L2JBWGJXWUJH?=
 =?utf-8?B?U0JSTHN3cjVkYlBwSXh4WnBicU5TTVhqU25TVXN5T05DNVlxMEFNM2dCa0Jv?=
 =?utf-8?B?bnNXZ1hZcGVCd0cvUUxFWmpOL3NmV3R3S3hlc1pPZTErKzlCNCt3TkJXU3hm?=
 =?utf-8?B?WEZ0RytNY1MxdVR6bkFOL3UxVW5iWmFGSGNtTzdFckNMNkFlTDJPWllGSVU0?=
 =?utf-8?B?NHhMQlJLOFJaekUrYU5vb1RnQklzMEZ1alFZb3BRcW9JVnFNSGVmNkFMMFlL?=
 =?utf-8?B?M05JQW9ZUFBtUVhEU0d4ZnhMOVJwZUswRkFoQkh1M29zRlc1OU9yZG9TT2ow?=
 =?utf-8?B?OEtRZzNPamdjTlZiNkZCc25jb24zM3A4L1FXbERISXZLZ0d6aW42d25SbndC?=
 =?utf-8?B?WFh4MTFnU2VEV3dxK08xVEErZmFvejE3cHFiUnZBc2dQYnEzaU9pY2wxRTh2?=
 =?utf-8?B?RkRNRllCVlBDSzFFNVRDL05DTGpyMzhZN3Uya2JXL0xSKzZBVUlvS3VJbjVZ?=
 =?utf-8?B?QTlTWUZLdkNEVHhvV1JNWG5RMGJCR1Zha1JJZVZ0UGtlaWxUckxIcjVRRDYr?=
 =?utf-8?B?cC9YdlJuZ0pTck4xMm9qMXFCb21temVtN2c1SEFDMmRzSzMvcmRDZDZxd1F6?=
 =?utf-8?B?VURoWHFuVzQvenJRZUUzZXo2ZVNia2U3dGVYSG1GYyt0TXNRNU5OSitQZE9K?=
 =?utf-8?B?WEF6Wkl1anlJNjFsNlJRT0c4THlqWnJacjdmbm5saWFHSFhDS0VTZjdHaUNV?=
 =?utf-8?B?bWtQSHp4dWNTWVBET2FJaGxWcnlucndFcmR6OFQ0SHFQeng1WG5ReVJQY3pL?=
 =?utf-8?B?NUVZeTNIYVdIRXFrRzFmUnB6ZUhvSklHb21NT2hpOTlmNE00bVlzbmdoMjBZ?=
 =?utf-8?B?QlNxZDBPNVl3NlBSdVhrajJkdDJJRmo0MUNHTGJVbmk1SlBSQmpLemJZcnFp?=
 =?utf-8?B?d2x5NkVmWldSZmJkdzc1TUxleGlaYzcwTkd3c2FPQ1JFTEZTRXVYME9CbTRZ?=
 =?utf-8?B?Zk1Xbk5QakNqZk9Db1VRblpRc3Z1Nms1QVRoV1hYRnlIZGkralNJZEpzVHJi?=
 =?utf-8?B?VU15VlcvbjFTcm1WNEZTc2p0TlBGUHkwbWk5L3JFMlhVUHRTM3hkTk91S3po?=
 =?utf-8?B?R1NrT3J3N0ptYXFWc0huU3dVYXdxM1ZBbTVzaGNlWEszVDZOMFJ4cHEyV1Zr?=
 =?utf-8?B?T1B2ZncxUjh1VXRzWnpDd2FWQnZRRjM5MnFyaEVEcThEQ1JMYitJbVFWRk91?=
 =?utf-8?B?MFI4TDRsRHVSalQyMFliTjA0YmNjTlRCSnVXV1lzU2FWWXJmMHhVYXl0OTRS?=
 =?utf-8?B?OXV6NHBUN3NqNXFzVzNZQlROeVlHcHA2dllQSUJnQ3UrL0tLNWhjTXRqZDhs?=
 =?utf-8?B?WmdCZGh3bVJrandERlU2NjUwZnRxN1JsQnpETkhpdHAxU1pNMzhCRFNNZ0Nu?=
 =?utf-8?B?bCttQkVSNi81aXk4L3h4UTFLTEdWQUxITTBYd0Zibk1aS0lhR3RReG1qVm91?=
 =?utf-8?B?cGlVUkZ6Njk4d20yNm1rZElpbGY5MHl0UXFEY2hISFYrYkp6QTJrZWp3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzh1WjBJaGFmOXE1VWlBLzU0b0xwVDFZbXBxckJJMU9QU2hNaGhUeFROcHlX?=
 =?utf-8?B?emUyT04wSHV4WmhvYlRuYzRzSkozZTYyR0tQSUk1ZktJUy8rWWF3S2QwRFlN?=
 =?utf-8?B?cHJDdUxkWGRrYWkyc09lWGRLdm5KSWdieGNBVTBlWW9MdGM3bkVPdEQ1ZE9z?=
 =?utf-8?B?M01xRzgwV1RnTmNQSXNET0ZWTEF2bzFWQUNWdDBwdGkxb29qZHBvRFpRaW9B?=
 =?utf-8?B?ZnRxS0xKWkNoZWZTR0RIZHVpK1J4a3Y1SThoZ2lBaElqTEtvZFRMeFBKU1Fv?=
 =?utf-8?B?azBIYm8xVDBEa3pYU3owY3RLRzh2MTV0SHpwdEdPcWk0Z212NFpRTlk0bVBB?=
 =?utf-8?B?VERueWFPbklGYkx3T1J4aERrZ0JFU2RkNkw3blZEOW11N0hCbWd1VXh6RFE3?=
 =?utf-8?B?Zkl0dFpFcnRmZUJFOUIyU0xuQzJONXBOVXpNMFFYcXBDY0padG44SjdGRWdV?=
 =?utf-8?B?VWZMNWhxT3hRSFNFRFRmZzRUYXpZR2l0WTM0WFI0WFJCdG9lcUVqY0tNdWhx?=
 =?utf-8?B?ampydkZUdDRSRlVJTjZDSlRDSzBzUE1rTFRXZVlQTkdWOUtpK0RFRHh6bmlx?=
 =?utf-8?B?OVpzK1M5R0s1V3Q4TXdzSzgxYS9zOEMwTSt0TURwQ1lhQVNyZHNpWnQvd1FU?=
 =?utf-8?B?QTBjRms3aUR6eXhTckVDRWF2dkNpKzBtU1VIV1cvTmpaNTlDd0VGcjBsRUlG?=
 =?utf-8?B?aHpMbWxMRDdYNzZoMEh5ZEJGM3RmNStudHFNVnVtSmZ4dkVPUFpBTy81S1ZK?=
 =?utf-8?B?ODRMbHZ3bGVyNEJ4SXh1SHhYZUpnOU40UTBVbC84NUtwTlNUWFpuclgxWFEv?=
 =?utf-8?B?SnBDZjREakh0T2s3cTQwRjNLWkswczMrampSaWdDR3VscmZQOC9BZ2JjTkRZ?=
 =?utf-8?B?Q0hISStXWTlGSE5tMjF3T2wwUXNtbFAyMlhCVTNXcTVMQ0V4Qm9YRFB5b2VE?=
 =?utf-8?B?ZEQ3ZjFpMW1YSXpyemd4RGY3TGh2cDl4TktEckEvNnZVVUtKQ2ttMWRBU2Fm?=
 =?utf-8?B?d25uZW83VGNzNVBPWlExVlpybENjVVNwZmYwajIzdUlaekZmVnhGTEgxc0sx?=
 =?utf-8?B?TGxycGpFa2dTbFFRUFRRckgxemhlOTlOTzdJUUJJcEpEbHFmZnlBR0p0YWZt?=
 =?utf-8?B?OTNYVlV4MnFyK3E1VzFLdWFsblZMa1NLOE90VHJ6T3c3RmJTc0c0ellIYjBD?=
 =?utf-8?B?ZmgzWDI1ZEpyRkZ2OTdUOTR2SDVtM3lsamNENmhuTitFRVZNb2Zrd0U4T0pa?=
 =?utf-8?B?TXlQa1V6S0VOMld5TW1oSTllNmg0cS9aa0pIcmVJbzZMTDUrdWJTNUorRW95?=
 =?utf-8?B?ZkwwUE13em1qMGloak9qWGZSU1FWR3BEM0FiYjVzTU1FYUU4M0F1N3pXQmx5?=
 =?utf-8?B?ZHZOYmx4MnpTSXpTSkE0TjFXYWVjY0xqNHByMlQ1RVpoMHRtMnVsRUxIQmp1?=
 =?utf-8?B?cmI0NXBqcUNhVFBuWmd3czAwVCs5ekROWmFHa1BOdUduc3laVDZtcmdHbzZF?=
 =?utf-8?B?ZXN6Z2RYQ1dnTndMVEdVT3JQMk5hSTFreEZNcVRJclNrZStERUwydDhGd1RF?=
 =?utf-8?B?TnVrSkxyTjYwY2NhcURXdHNxUmdIUUxMVk1RVVBMeGxWKzdpTGJqdy8zcnlI?=
 =?utf-8?B?SUVvN3BRdG5iUmtRbjNaTE5ISEpNenBvZDJqY2Q2NVVYUHN1dnMxZi92ZDNw?=
 =?utf-8?B?V2ZQbVZzV20rNENIODN0QndtNmxIOHBXTkw2NXg1K3RJcXVJSlRad25uTlNt?=
 =?utf-8?B?OW02K24wdlY0NVBFLzkybi93OENlOU9rV0d1ZDNhU2VvMDZBK2czRlp5L1dY?=
 =?utf-8?B?dC85QUt1VVpPcWF6N2lwNEdUZ3VCU3BaS05FUFhtZ2t2dTZEUDZPUmdaM05m?=
 =?utf-8?B?VDlzYnJuZExTRVUxSTVycGNidzJTTGdTQnpaS3I2KysyMEJKZEx6ZFlEZ0Jh?=
 =?utf-8?B?STJVVkEvZXFIVERyN1NpbGtaY0NaRzlnUmtDYnJQeDc2SHB5WnZrdFpVTStu?=
 =?utf-8?B?WTRCZ0s4ZDU5NjhYMzhxd2N0WlNKNjk5Nmp3T3hPZzRLS29IMUlHTW1XeGkv?=
 =?utf-8?B?SXBOUE9FeGJxQVVuRGNQenpqeS9ubUxERFBXcldJbUE5UHJHTlFMdEQ3K1Ni?=
 =?utf-8?Q?h/VUa8mqquC6JVD2fOE5QIGYq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 355b4aaf-9340-48be-6034-08dcde161f72
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 10:29:38.1297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9sb4JzsozKQUW//0a3TwwTF3Zz48uhWjpW5BHwKOmcIv7C4Tbjy6UEGcLo6FLlmCL1hS2FE7sk04D+LlY+6VHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8443

Hi Baolu,


On 9/12/2024 9:44 AM, Baolu Lu wrote:
> On 9/11/24 6:19 PM, Vasant Hegde wrote:
>> From: Jason Gunthorpe<jgg@ziepe.ca>
>>
>> Introduce new flag (IOMMU_HWPT_ALLOC_PASID) to domain_alloc_users() ops.
>> If both IOMMU and device supports PASID it will allocate domain.
>> Otherwise return error.
>>
>> Also modify __iommu_group_alloc_default_domain() to call
>> iommu_paging_domain_alloc_flags() with appropriate flag when allocating
>> paging domain.
>>
>> Signed-off-by: Jason Gunthorpe<jgg@ziepe.ca>
>> [Added __iommu_paging_domain_alloc_flags() and description - Vasant]
>> Signed-off-by: Vasant Hegde<vasant.hegde@amd.com>
>> ---
>>   drivers/iommu/iommu.c        | 45 +++++++++++++++++++++++++++---------
>>   include/uapi/linux/iommufd.h |  6 +++++
>>   2 files changed, 40 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 5d1cef36f633..f3f1244fe90a 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -32,6 +32,7 @@
>>   #include <trace/events/iommu.h>
>>   #include <linux/sched/mm.h>
>>   #include <linux/msi.h>
>> +#include <uapi/linux/iommufd.h>
>>     #include "dma-iommu.h"
>>   #include "iommu-priv.h"
>> @@ -99,6 +100,9 @@ static int __iommu_attach_device(struct iommu_domain *domain,
>>                    struct device *dev);
>>   static int __iommu_attach_group(struct iommu_domain *domain,
>>                   struct iommu_group *group);
>> +static struct iommu_domain *__iommu_paging_domain_alloc_flags(struct device
>> *dev,
>> +                               unsigned int type,
>> +                               unsigned int flags);
>>     enum {
>>       IOMMU_SET_DOMAIN_MUST_SUCCEED = 1 << 0,
>> @@ -1589,8 +1593,19 @@ EXPORT_SYMBOL_GPL(fsl_mc_device_group);
>>   static struct iommu_domain *
>>   __iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
>>   {
>> +    struct device *dev = iommu_group_first_dev(group);
>> +
>>       if (group->default_domain && group->default_domain->type == req_type)
>>           return group->default_domain;
>> +
>> +    /*
>> +     * When allocating the DMA API domain assume that the driver is going to
>> +     * use PASID and make sure the RID's domain is PASID compatible.
>> +     */
>> +    if (req_type & __IOMMU_DOMAIN_PAGING)
>> +        return __iommu_paging_domain_alloc_flags(dev, req_type,
>> +                dev->iommu->max_pasids ? IOMMU_HWPT_ALLOC_PASID : 0);
> 
> This changes default domain allocation paths.
> 
> Previously, the default domain was allocated by domain_alloc_paging or
> domain_alloc. Now, it will be allocated through domain_alloc_user,
> which, based on my understanding, is intended for user domain
> allocation.

Right. This was discussed in during v1 [1] and Jason suggested to rename this
API to domain_alloc_paging_extended() after everything settles.

That's why in cover letter I asked you and Jason whether we need any changes to
intel and ARM SMM3 driver.

-Vasant
