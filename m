Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010037.outbound.protection.outlook.com [52.101.201.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FFC37D113
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 03:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782703514; cv=fail; b=RBzq0FD0x0BEBeIH/IMO/2kX0Qn2a+IgeqbzaZlhb0aC5pedRO5jv+qcQCsct7/0KIvAx5/o0R31TWjb2ERDnMPNEbl+PZ+GRCSWzkHH+a9jFLQEPVw7U2P1t7grwsWkHQQIwsmp4mSCO/aKbhsISN9zA0SAb9U9AWAt5Nowt88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782703514; c=relaxed/simple;
	bh=SHnyH/JxOEB0UzWWrvIX94b17kI34UcrVsFGCzbXzGs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s5yIeXBt8Mj1GM1XCivpCxF18E+Fh+DWT3HiLwPK8aS7lOfDIQAou/85HCcsEoPk1z6Kvfrc7Wcy11CerwPnfBxDoZ22ZvZ1GuOfE2rn+Sx90VZE+T062/ZVpGKUnlJH1727n1S4j6CiQWNkVNZ26/iIssb2OWWnEQD9ujLGtaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a0XvHa8d; arc=fail smtp.client-ip=52.101.201.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a0XvHa8d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZveW9y/wQ3nVfK0P6DYFLXtPr0z0EjjT6jx6AOdEnT57D+ULiakrIwMIuDW5jjVY2MQzsTcFSQXPBqbiikO72rlqPxted06WMhR/MqcrSSg4SVkKze6vOl6EB2FA94cg6KMAjRYCLPiqzCRitEqF0LxJ1EUhHlM/RRMQks5hXwkDcjxk3hiAICatu5buj+s4p/l0m3BEWUHfiPSv/J8EgTK3pYEmtzGqhEEcUPKfoi4ZRPnwqHQ3dLz4UG84tm/ccSlUhqq9rstohzNGjxB2xEcjdYcTXHvBod33ImPHg14rHivVGv35b/3j/+26Of9teycGAwArVVeZHahrVtA0zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19XmpVCmE+gi/ajOtUvRoyTzlLLtArAARONqpKdJ5+w=;
 b=val0FWLUqsv0HRrzz2MvwvNmcPYajaulkd2hI7f55poRSWkhI+MStyCwaPoBmGCQuAknvPQuVrZH8VABCNf2QxMQXVzIfsbm+GxUbSB1BKm1M7iVTZDNih4vbPBmCzfSgyZ0NlxO9gtmG3Hnuo4rY1COwTjouqc6cUzGTKw7Evsvk5kK0L/x6sD2D+UXUKPi1I4Ghjl+sMs8r9bAz2Xv7D9gaH1iTDP+u0VfhAtS01ZZKuNVsegGbjbIu4e4P9L5aDKtvmlEZqUtTBha/zipntqzpjEA71d+5L9mG/mDPROzoKHIzBkHS6u0Xmph47/nRLcr80PGwRXL1OFft6F28w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19XmpVCmE+gi/ajOtUvRoyTzlLLtArAARONqpKdJ5+w=;
 b=a0XvHa8dGy5i++3RFEbAMvf/MVk2f6nLfm4iY8taJqQLzMVjRazeu2WT/kpxJEZaAHUM17zXmTWV918gfoP2nwatkZJEwQ7xKoEwSxspryVRT+UDtASpIceQRT7CkDP7bB8ECA0mMLd+5p+qQdEtDHfJqQn8Y7lBmqdXMWQGDxM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999171.namprd12.prod.outlook.com (2603:10b6:8:388::22)
 by DS0PR12MB7608.namprd12.prod.outlook.com (2603:10b6:8:13b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 03:25:07 +0000
Received: from DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19]) by DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 03:25:07 +0000
Message-ID: <85294a0c-bb07-4987-a5f3-e8d2a97e3f37@amd.com>
Date: Mon, 29 Jun 2026 10:24:58 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/26] iommu/amd: Add helper functions to manage DevID
 / DomID mapping tables
To: Weinan Liu <wnliu@google.com>
Cc: chriscli@google.com, dantuluris@google.com, iommu@lists.linux.dev,
 jay.chen@amd.com, jgg@nvidia.com, jon.grimm@amd.com, joro@8bytes.org,
 kevin.tian@intel.com, kpsingh@google.com, linux-kernel@vger.kernel.org,
 nicolinc@nvidia.com, sairaj.arunkodilkar@amd.com, santosh.shukla@amd.com,
 vasant.hegde@amd.com, wvw@google.com, yi.l.liu@intel.com
References: <20260528051738.596013-14-suravee.suthikulpanit@amd.com>
 <20260530212613.3060363-1-wnliu@google.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20260530212613.3060363-1-wnliu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: JH0PR01CA0109.apcprd01.prod.exchangelabs.com
 (2603:1096:990:59::8) To DSVPR12MB999171.namprd12.prod.outlook.com
 (2603:10b6:8:388::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999171:EE_|DS0PR12MB7608:EE_
X-MS-Office365-Filtering-Correlation-Id: de82cb87-712a-45d7-5631-08ded58e04c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|4143699003|6133799003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	9MKinTB2yu+uDidXI7LSZFnyAOiaUzkE86yLHX1pZqenxD0b9NyaHEOAnNGRs+e6FRwn5XRpuS9ws8qY83+SvqdDA2308lsNu2TUYItTIoKkKOIbk1e8r+cn+ho1KtnMxDluD89WV8Nq/pXaQjFMzpChaYcuz6wAjzeUakyeVs4o/pbH9EN3FWBZ+nU4AmlGUmcYm8RBXqNix8QfPMbXyLZ3lD7Ktd/fz66Ouv0zQ9FIZbko1au8dIiGXT7ZBbzOIkibrKz8m0AJo+2XODyCRLBOCS6u8fY8WWPwTnxChF+qsS3amyEl9FAHh9hnG6zPg51rZtfaavjjnAp8jePY24r/72zmh7Gr29mhFcdRp3eyMwTcbG1plOPspWoGBihP/1AbuDUa786+UpyWWFXNNIXQEV2EKkdMkmfCpJG0oWp1d/YHAZ4saqaFBOtyXbnaTQZgzV3oVIIQ1ytO6Ep/96H73hSbHoopGOQL+2dUIGKbYR0+FAxMWIDtZHMdh9h6jEnNe56mNEHJSqyf2NOxNxRtY1xvbAThLD2tL4902r2+0qMjxDJgd3qTHI7tovf+r3rTqoNYl8gvzh2iF+7iLkDWfTZ3qEG6mwUksueXLvArde4qYUqhJh5rGz/ocU/o+A1y8jf53dMbcmN7jeY7B5EfccRJp8Ty5zKQlxNrzik=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB999171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(4143699003)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmRGSERKbVFTcGlhWm1JanNTSzdBTmlQRXl4N1QvYVdMVHo4S3pDRzJhak1n?=
 =?utf-8?B?MUtqNVFaZjhjMW5PU3A5QXlGTThzektxUEc2VFYxU0tLK1Z0MjF4a3JhaW9V?=
 =?utf-8?B?SEhvTXpxTEFJbWJ5NnJrSUdKQjRlUUxVb1JrWFN6WElCSnNiMUxnT2doTmpx?=
 =?utf-8?B?YTE4Lzk5cDJRNUdCb1NWcExEWkZDMU5WSEhaNHRBd2UxQk9hL2J0RlJPckNJ?=
 =?utf-8?B?bTFKZEJQVkl4V1BhcDNNM1h2bnhpV2puMEhCYXpuZ3hTOXo4L045dGZNOThu?=
 =?utf-8?B?MHgwZ0xWZjRFc1I5dzhWdEJFY0dsV0xMbk1WZUFCekhzMVVsOXYxdXN2NUpl?=
 =?utf-8?B?UnNvQ00xR0tFbmdSTHhGSUhzb0NxRzlUM3RtZ2s1aWZZTVZFakNkOENCR1VW?=
 =?utf-8?B?VWV6Wk5KNmlHcXV5SjUrL0Z6Qmp5VWtZZEV2THpjYkJrbmFZQzl6VFN1ajd4?=
 =?utf-8?B?YUFMckM5b0syYW8ydC9MWE5JQlFMNis4MElrYWpsSlBING0rOUdKZXhJYisx?=
 =?utf-8?B?bnlpcUFoR1o3RmIwNzhFNW9rbXl2YTZnRWp2SElFYVYvY3NhN3prSm5NcGxG?=
 =?utf-8?B?WFZtelN1V3pNK1N3clZ1UzZWNlI1Ui9pU1lJM3JTV0tsVjJRdHkybG9LZEln?=
 =?utf-8?B?SWR6L1cvaFBFOXpIcCtxckJCUGtJZDZkK3FodEZTbVFEem0xNXRPekMyUHl3?=
 =?utf-8?B?Um0wZk53VWxHL01KNjYyNnJnRXdFelRXTVk3UHErdkpXWXV5R0FoTU9JVjFR?=
 =?utf-8?B?dXNYYlFqN0pEb1NuWTlxY2JnNzdJSnpkRmxuaEZqbFduNDdPaVFYWUlBT3hQ?=
 =?utf-8?B?N1NwSU5uQ2NaVnpwZUZYV3N2MGhCVzkzbFhxM0ZIVSt3VnpCRGxZMW5mZ3E0?=
 =?utf-8?B?YjE4R3hBWUFWRkxFZ2Y4NE1LL0RQQlhpWVZIQzgyRE5sb0RSNytOSFQ3Tlcw?=
 =?utf-8?B?VE1ta1FGL0dkNFFNcnJibHRJbUdEK1ZtTFBSMGV3VG8wS0dQMHJxZWk0SDEv?=
 =?utf-8?B?MlpOcjlaZFNpUzh1cmJ4NVMvKzQ4ZkdPMGF1TUxyZGF6RDhmTUpjSnBveGhV?=
 =?utf-8?B?eG9HZDBMV0xvSHFxM0NQdlNjV3lVcVMrZWhkZEJNRzJvWHBadXhnanMrTjVC?=
 =?utf-8?B?TGhudVFIUjNQdDFMVWNYN29MSTV4OVJLV1JBQmpLM3dMZG5pczVLN0RXc2Ri?=
 =?utf-8?B?VW9hS0srWFhOTUJ1bEM1R1ZFWDFUWVJkWXpwRmlJREtadkpRT1pOdzFxMFVv?=
 =?utf-8?B?MnE4ZEZYcmJaRVFBMkRtcGYydmNuY3lYOGhpMHdLMjVUOWYyVE9NbTA5OXRN?=
 =?utf-8?B?cmExKzQ4MmNaa1RsdnY1TVdwc3F6YUswQzhJSEZ4d25XaXFRb0d6UjNFVWc2?=
 =?utf-8?B?ODJKNXdXSitBR2tEcE91clIrRWwxSUw0alBib255ZWlSNnFERVdidXk1Qytt?=
 =?utf-8?B?em1ZMDk1M09uWDdCWjBNOVc5bUdHdm1jQXk1R0dBVXRhYVNBZWYxR0lVYkJZ?=
 =?utf-8?B?bmFvZEhKWXNoMjdBRXlNNTdzMkVvRnB3Z0NyL3FtelBiUFAxNVpid2hzMnVL?=
 =?utf-8?B?Rjk2bmI1VVg4NlRxeUtGUWhPNEpuUmtNOElBNGk5U3czZFd6WVdIT1RaR2Zy?=
 =?utf-8?B?b05xYXNmNzNXbDFTNzRPenFNa1FuSlVsbEVUM2JVeEFUN0RPOUFTc0JtcU5n?=
 =?utf-8?B?TUhTbjVYanRGbXlmWTV2TFJldTViTjlOMmIzbmhqSis3ODJ6TkUxLzhwV0tX?=
 =?utf-8?B?V0piZjlKSnlVM3NqMmVUOFVKc0cwU25nUXc5dlM4NlNXNUlYVHNlbGNSVms0?=
 =?utf-8?B?T0xvbHlBVUsxUDZJRzg2WVNwRUFoKzA0VHlvTExZWmtkQmNsbWVuZm9RRUov?=
 =?utf-8?B?bldSV2xQbGpkYXVBVmJIeWlUaU9sa0RORlRnSG51OHJmMDdkRHBCaWdOeFNE?=
 =?utf-8?B?NHVONTQ0Z1k1ZzdDYm5acnpaSEw3RlprZ2IvZTFlRU1vdFZFcHNqazhjREJR?=
 =?utf-8?B?cytpUVdkWkN3Nk5rR000UWVrMm9CS05iT2IySWMyMFVFWU91RzNuTlRwNmh6?=
 =?utf-8?B?VzQyQVphYTdPMGtvSVhhVjVOa1pSM0VyVXhTbWlSM2FEbmI4NXdzdTBxUkYw?=
 =?utf-8?B?RkY5cGJjUzlCYTRINGFOT2N5Unk0M05JQVovd1JpS01OWEpNRXZTaVdsSU4v?=
 =?utf-8?B?SmtVWUNrRFdpa0ljVSsybFdGSVM5QVVlMGwvcERGUDlYQzhKYzdBT2pUdUpI?=
 =?utf-8?B?WnhVZHZjY2F0MlJmMGlwWkwzMTV1bEUxSnlaWk9pSThTSVZyZEVEM29BSkFC?=
 =?utf-8?B?TFJHLzY0WkkzMDVFS0t0YlFtMDI0TEEzcU1yck5McXdrL092VWVlQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de82cb87-712a-45d7-5631-08ded58e04c8
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 03:25:07.6772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pu6TMipNcc6Ahfu2AhSGsjgsB3i14W9eVJIkpEus2i4tcly3utlLyqKaugD7AqVe/H1SPQ4ZQnqDGOuwwLoeBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7608



On 5/31/2026 4:26 AM, Weinan Liu wrote:
> On Wed, May 27, 2026 at 10:19 PM Suravee Suthikulpanit <suravee.suthikulpanit@amd.com> wrote:
> 
>> diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
>> index 42307ae71b24..efa9e1f49550 100644
>> --- a/drivers/iommu/amd/iommufd.c
>> +++ b/drivers/iommu/amd/iommufd.c
>> @@ -83,6 +83,10 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
>>          /* Reset vIOMMU MMIOs to initialize the vIOMMU */
>>          iommu_reset_vmmio(iommu, aviommu->gid);
>>
>> +       ret = amd_viommu_init_one(iommu, aviommu);
>> +       if (ret)
>> +               goto err_init;
>> +
>>          ret = iommu_copy_struct_to_user(user_data, &data,
>>                                          IOMMU_VIOMMU_TYPE_AMD,
>>                                          reserved);
>> @@ -120,6 +124,7 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
>>          if (aviommu->vfmmio_mmap_offset)
>>                  iommufd_viommu_destroy_mmap(&aviommu->core, aviommu->vfmmio_mmap_offset);
>>          amd_iommu_gid_free(iommu, aviommu->gid);
>> +       amd_viommu_uninit_one(iommu, aviommu);
>>   }
>>
> The finalization order should be the reverse of the initialization order.
> 
> If amd_iommu_gid_free() is called before amd_viommu_uninit_one(), the gid could be reallocated to a new
> vIOMMU instance before the cleanup is complete.
> Please consider moving amd_viommu_uninit_one() before the GID free call.
> 

Thanks. I'll take care of this in V3.
Suravee
