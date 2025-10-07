Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011065.outbound.protection.outlook.com [40.93.194.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875862CCC0
	for <iommu@lists.linux.dev>; Tue,  7 Oct 2025 19:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759864959; cv=fail; b=jpT0kIEodCNu2V2RLDWX3Qb0HdDCYe+R+g3Mr5Z9ktvoqXMatJQWt/HquCLueBiiB8sHjOA3Jz06CsjOu62Hc1FXL7dWBzeTw/fg6pNiw+T5lqi5K9nzDoSWtgId8YfvpoIrh6/7U1GV0xEdTe2d1D40B7JEp7ohBRg/upbrgHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759864959; c=relaxed/simple;
	bh=WqDwwFJdhLdKAne662AQ/4uFe04Rmyobi/w38OaxfEI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZAstqvO+AYW1CCmhxjNqrKh5n7aiYlcNCCZ/OWh0VBOOB0suGsUS+8oxrKVXId98bYk0rUVEZgVHrHeUC3yOTKQHoJ6YBh3dvUa8Bl5JRMI8vZbeM1QE/rzbIDohtqSrOHpA/HPaJq9T386iuhPP7nNnMl9Q8so0VXArMiGrJxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uJHLJ9d0; arc=fail smtp.client-ip=40.93.194.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uJHLJ9d0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MICr9pmi5gr2fMsgTj2nsN3OV368vfXgqmxI/Um4xGvK8+7IBgsUBrk4dQMwKzX2o/D1eyycRhCObfHf4pgLnGUKtij9amSxnpV/Z9naKE+4WCLg9+ThOhc0zqnWTiMjFEAWhSGNYuWXaQxm7PcMYKgwF7LOR8k5hAixRKBBq3aoxG9LX/RjJc+mh7nSz8vt8MFq/hu3LoZibFxp+R7ep1a0yTV0g7lIyLn+qHoXc2d1J7uR2Aj9Ns23erPUyQSV2OQYtRUXUO8IBYwx/f6FBOVLQYB9GBAWaUkXWeJ7hnKv8rxrbdSXnETRNpkbTPecjLUUYCbQ+rzKM66k7kR7QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cn+wgvto4vYTlR8X0NScM3xMcx3S0dUe4tZUFayYHJU=;
 b=TluITC2LueKHiSNz+yOzVaioA8ptjcNMy/7T6XSx+Pi5DYkEjj0of3aCv4X2S2f5R09cDpj4nGqJaWuZONNbVVfXj0uO71IIpipD90ZeuS1gnb3WqW8Bhuqa4R+B2ONn+BRNnRXJDzg4fowHVxmKAYT+kttrHED0kXD/qred/R4MgFujE+H5imzAO/JpQU+DGne1wRizjhZOd+yH2VeK7T1h5++We+WOQ3uFdCZyB8wKEsOwyDvDD73/7x1iRoayujxpby4nNRmiSmFFJQoRmditgABwDaFBPMz/4aNFvnypoBPd6/ra0xtxuNum1ruQD7ZshWcvUulwbussYNmhkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cn+wgvto4vYTlR8X0NScM3xMcx3S0dUe4tZUFayYHJU=;
 b=uJHLJ9d0QLNDD2w1lSuHxOIetTos4wRFC5IUd/hJWT4UmQulOT/MHSY5SKIFkNBvHdGn8pZZqyqf38xii9KlmsYwX9ILQFcHJdo5TJp6B2TOovEuAm9JpFA2EpummCM0wydM2aN/FZZQzVtwvUOWolGpsUTEotuKr1euV91T4Y8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 IA0PPF8FC6E1236.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bda) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 7 Oct
 2025 19:22:33 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%6]) with mapi id 15.20.9203.007; Tue, 7 Oct 2025
 19:22:33 +0000
Message-ID: <3e27de73-61a1-4977-b0a1-629ffaa81032@amd.com>
Date: Tue, 7 Oct 2025 14:22:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/12] iommu/amd: Add support for nested domain
 attach/detach
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: nicolinc@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
 will@kernel.org, joro@8bytes.org, kevin.tian@intel.com, jsnitsel@redhat.com,
 vasant.hegde@amd.com, iommu@lists.linux.dev, santosh.shukla@amd.com,
 sairaj.arunkodilkar@amd.com, jon.grimm@amd.com, prashanthpra@google.com,
 wvw@google.com, wnliu@google.com, gptran@google.com, kpsingh@google.com,
 joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
References: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
 <20251001060954.5030-12-suravee.suthikulpanit@amd.com>
 <20251006145900.GT3360665@nvidia.com>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20251006145900.GT3360665@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0088.namprd13.prod.outlook.com
 (2603:10b6:806:23::33) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|IA0PPF8FC6E1236:EE_
X-MS-Office365-Filtering-Correlation-Id: c7b8d353-f6d6-4c7e-9105-08de05d6dd66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVhZM1RxM2NlUmx2ejlWMHlORVNWV1hXempaeUtOWi9LQnA3dWJrTEhaUFgv?=
 =?utf-8?B?VFQ0NWQ5Y1hOSjJQS1c2aXNITG5rOENqc1VhR1Y2cWhWeDZRZ1dKZCtJZFha?=
 =?utf-8?B?WVVvTk5nei9aejdQTnJzWTRnU2NPTkd4dzJKVnlmZ2VDZ2xjeDV4MDFZazVh?=
 =?utf-8?B?LzdlR1BXZnJ2QlJSSGNQazRwRVN3dmcyY1NZK2RRWno0QzlpdG5TY3ZJYlVh?=
 =?utf-8?B?WHN4NmRSUGlVU3FoZWJkbWlPVkJ1QytkbTduUDNZb3RnUjBOZGx0OWVGVUI2?=
 =?utf-8?B?L1FQZnFVTGpFTWwvakJmdSs0czdEN1p0UkVOeDZzY0VWRFh1L3QvejZ3UUsx?=
 =?utf-8?B?YzdNS2xKM2ZGZHNaQTl2ODJJQTRFN2l4NFYybUhGV1I4LzZaaEZxV3lRd2dp?=
 =?utf-8?B?YzZGZENVNWNuSlIvYUh0N0p2eUtzb1F3Njhvb1BxbkRHSGwvUDYwVzVmVFRn?=
 =?utf-8?B?Z1hMZWI3SUUyaW45cWczS2ZTU01pRlNiY085T3hvdU1PNUp0alFlWjZ1WmZX?=
 =?utf-8?B?cVZoeFU2RU1xVE1iQkY2Sk1RSnJ2TEhaeTN2ckpITE5UWXVYQncvUVVGaXZE?=
 =?utf-8?B?RWNNMThkYUwxSTBZWkh3ZkRCMEhReGtXOEdiTnRFalArTXNHcnVhQWdDaUI4?=
 =?utf-8?B?M0pOMnYxb0hwbmU5cUxvbHFvOHVSV1A5K293akxIMkFzakcybTNmQlNuWTNE?=
 =?utf-8?B?K3pZQ2JLcm8yb1JiOTE0VU5DMEoxQlZxT1FVSHhFUDF6TStaT1QyRlAwVmpw?=
 =?utf-8?B?MExxU0ZrbVJDS3o2a1lRazB4Y1BNck9ocEVCZ1BLclVjaHE3SC9MRWVYUVNZ?=
 =?utf-8?B?WVVWVy9SMlR4VjlsUUVMWmdSMmNuOFVqWjFJMVJJZU9kbUo0NURiZlNkQVQz?=
 =?utf-8?B?bnBDbTJhK0VzMjlUTmdTRDZWWVB5ajBkaUJROW1zL3hSQmo0ZlpINlgrTEpn?=
 =?utf-8?B?bzVYY3BXR0hHRlVGSkdiaTVxNTZzc2wvUFJVczNrSG81M3dEM05reXJxNUwr?=
 =?utf-8?B?TzR6eVJHWmd3U29vS0RTbnh0MEd6dE1oNWJFaHZnMEZWMWpqZGNTMnUyWTJW?=
 =?utf-8?B?RmpEdFlMWTZxRE43ckphaFV1VU5UQkZXSG53QzRyRU5VZGh5am5yZWp5Z2Nh?=
 =?utf-8?B?MVlVNEw1a0pNRUdFREhnbjdEY3FDekJmbnZtMUNlSFRJYWQ4YjNoczR4b0Vk?=
 =?utf-8?B?bDMyWEFsV0YvdEdySmZxR3VDTExKaTZUMkRnenRBam5vYUNNWVU5dlRyZllL?=
 =?utf-8?B?a3piRnY4RTBpUFNmRWw0WEtLUm1CaEgyV0UwUFBJOUxjYXlZM3dKaFA5OTRB?=
 =?utf-8?B?Y1RPUzQxcHFBOWhRQ2FyS0FTd2pVUjZGYTZYWmxXQ1ArblBxSUxiSmd1a2VI?=
 =?utf-8?B?cUVRbXR6anUwcDlmS1BBWlZsM0tSSmpZSVBoS0Ira0N5WVJwaGVsYTkrMWEv?=
 =?utf-8?B?ZXcwRDc5R0JjaVJ5YW52eXRPa3R0emNabS9qOXNEbURoTmdjRjNvamhLRDFs?=
 =?utf-8?B?SUdpaklpUU96dGdPZWtrR0ZGR1ZpdU80QzU2cmtUVXIrL2RpM096VnBoVWlj?=
 =?utf-8?B?ZnZHNFNRMktDcWJPRHhabGRXUjVnQ3hIRnFPQjJaM2RQajNpRk9wWDNkc1Fl?=
 =?utf-8?B?THNiZG53T0wyd0ZobitBcFBlZVNrQ3M2Y1RuMEJ2ak5RNkdXVDJFdTZubGtV?=
 =?utf-8?B?aEM5ckFScWZuSlRUbXliRmVXbGdBcklIbnlla0JDeDdmcjBPR2VwdTYrYkNz?=
 =?utf-8?B?Q3Y5dTRreG5ueklMRXRnQVJnTXY3WFVHZExZNHpEYitlYTFMdTFxVDVaWEJ4?=
 =?utf-8?B?eDYwdDZEYkZBSk9uTGdQRThVWlg0ZURrQXlLaS9ReFY4bmV5aG5DNDhUZUpH?=
 =?utf-8?B?ajRDZVV2YU1MUlpPcUszeEEzV3dQY0dibU5ZMkdHTjlmM2VGc29UenlQY3VW?=
 =?utf-8?Q?8arpJPd9wvjoyMvyIdB9MM9XQkhH6XIr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUk2eGt2MDFBYzRQTlJ6d1kvWmVkcWN1TVR5MU4yYXFpTlRqYUx0cUtCTW0v?=
 =?utf-8?B?bkJkdGtPRGZodXhMRVNmVWJjTzJMVHRrQzN0RitXMm5nWWRuOXlna3RWTXJk?=
 =?utf-8?B?SjdJbE9WaHRTU1d0TFljaXhDTXN4SmlwajV3Yk5kVHpkbkRHY21PQU5FTkZU?=
 =?utf-8?B?R0tHUHRLalA3aDkxbDB0WS84N3VYWmZHNVEzUk1mTWo4MVVUanJib2FJcVVV?=
 =?utf-8?B?RjJpb2YrWWI4K3lwYktSRU1sTlByb2szOU5XUkpMODVLUFdlL2I1NXR6UWFk?=
 =?utf-8?B?STVQNGpLQmt2UmQ3ZnFZQm5VaUxib1owem5oT21raFhHdXowNXFIYWVOOXN3?=
 =?utf-8?B?SmR3RVN5MUkrUmQ4UHJnNm01R3hvTTZ3dHFqaGhiZTFIL0FDcXRDWnpnZzlj?=
 =?utf-8?B?T0cwazRycUwxRWFQSUV5ckRYUmkyQ3Vyclo3TWRuNzhMUnUyaVk2OGdlZTFl?=
 =?utf-8?B?MWcvMytzSWR0KzZtYkh4ZVZ6WW1kYXdGUU0wSWUyZkxpRVc5UVlhMmI2Zk5L?=
 =?utf-8?B?TVU1OWVuTmx5ZGJEbGRBcm5aYnRXRzl4N2FNdFVoOGVXMXVmNGZ0YjAxdXBv?=
 =?utf-8?B?dm1uRlhzQjBrRlJqMUJCS1N6RnVDTmZCSWcwSE4xWDB5bks4UXBuaU1EZUxm?=
 =?utf-8?B?VUdOamJ4Zyt3UGtIK016RGpoZGNCRWRLY0tpN1lwMXdTaXNaUUwvY0JlZEZk?=
 =?utf-8?B?SW5tWFhLczNmbkZqenJNVlNMR0NzQlgvdnJuNkpKalhrbk93NXFtUXR6RzVk?=
 =?utf-8?B?WXNLbFgrSkdDSmpiN1FRVmhWR1pEckUvRWdGTHdvVVgxVDB3MkhPN0RSWE11?=
 =?utf-8?B?bWpIUFBXRVJ0SkNJT0IzUlNHM0pDL0lNcFpORDN4VkZsNmRaRlFGSDNOQ2RP?=
 =?utf-8?B?bVhsVmhCSzlzVmtVR1FoVkRpYkdlajF6ZTl4a0hLUjArc2FJaXhScGExZUtW?=
 =?utf-8?B?S1EwSWY1cG5PMVlQalRIRkxlUFFxdHRuY3RrU3diaUFjaTBFdEliWUlFbXd3?=
 =?utf-8?B?YkRCNUlCZGhtR2tKdk81K2xWTjR2NHBxbWxnOHdWcHFkM1oxVWYrRW1BdlJQ?=
 =?utf-8?B?Sysyd1JSRGVQREI0VDF4YzRmK09kdEtqOXZIRUhvZjF6Y0I3VTVXZi9NcEk1?=
 =?utf-8?B?UkdudndQU2VCdWFlSEFJbU96cVNtWURickRlVXdrYWVlSTFTV1NtYXNMY29r?=
 =?utf-8?B?QXlIUkVJWHMxaEdieVMyZWIyVEhmU3ZKc1d6cTNlcUdWQWFuL1VodHpuOXlR?=
 =?utf-8?B?STlUTVVocUdQU1JFYjlSVnhzZE9RZTBFdTFORnd4cERHQXI5MGRCRm9Fbkdm?=
 =?utf-8?B?ck1ybkQ1b3ZEUnVVQ3M1NHJUck1lV3F6dnNINEZabnJaZHpXRi9ObS9FM2Er?=
 =?utf-8?B?YkdvdDJBZzhpdXJKNHRQK3czSTVINUtmek5wNTFMakNXeUFYdnZ2Y21jYjh1?=
 =?utf-8?B?NHovZGFQUGVDNnJJa0xneUcrMFVoek13MGxOMEI4TktVd3BEWTlMeDlJTEph?=
 =?utf-8?B?MXQ5STNUNDlKUnhjVjZCK0ZBZlQ0RjcyRFlvMyt3NVJXMDkvZEdqREljeVI5?=
 =?utf-8?B?RS9PSVNyMGovelFpVjVjYSt4cktzcis5NVI2N3oweitRaWxvVXUwY1krU0xo?=
 =?utf-8?B?K1NheDhLb0lMS3QyTXU2eTA5WURZdXJoanN5UE9IbW16dUE2YjBHU3ZOYVkz?=
 =?utf-8?B?SGt6OVV1UEhhNjlnQVNEN1NpWVR0a1lsQXpjd0R1R1JBNlVybUVJTFNGOWZR?=
 =?utf-8?B?VzRnVG1Rd1JUaFBpd2Faem5FTlAvMUtwNzg3UXBMMWFJYVlub3AxUHZWSjlx?=
 =?utf-8?B?UGI1T3pwY2lINGt5enV0WW5Ic0dHZUZoYzQ5eGlZVjJ5M29XNFNqM0gySlg1?=
 =?utf-8?B?NkpZK1E3bWdQckhHUmN6Tm82TWNseWd0RWRqdkVDWC95WGMya2Z3eFIvRWpx?=
 =?utf-8?B?dTJXNVYzTFowOEZpK3JXSHVaM2k3ZmZsUUZVcTFHY00zTDg1dmRJNHlEdnJ0?=
 =?utf-8?B?RUxtWDlKMWc3Mk52clU2R0ZLOVRXbXJwZ1JWSnNidUsrNEQ5eGFMb0VwZHRQ?=
 =?utf-8?B?dVhVaFNZZVlWVDdWNXRSTGYzYTJWa1oydHovRWRCVXVtMjRsK1pMVzZwYytF?=
 =?utf-8?Q?v38tWTC+6baipg/Oqkrkwbdhf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7b8d353-f6d6-4c7e-9105-08de05d6dd66
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 19:22:33.1054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dR7wNTN6UxGGBxlBNLEFuo7vDQrfXSagXRua3d2rjMorzv0hk4EcfGJGgpf4bzsMZW+qVP7pomu8pQ6YcxSPXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF8FC6E1236



On 10/6/2025 9:59 AM, Jason Gunthorpe wrote:
> On Wed, Oct 01, 2025 at 06:09:53AM +0000, Suravee Suthikulpanit wrote:
>> ....
>> +	if (WARN_ON(!ndom || !pdom || (pdom->iop.mode == PAGE_MODE_NONE)))
>> +		return;
>> +
>> +	amd_iommu_make_clear_dte(dev_data, &new);
>> +
>> +	new.data[0] |= iommu_virt_to_phys(pdom->iop.root);
>> +	new.data[0] |= FIELD_PREP(DTE_MODE_MASK, pdom->iop.mode);
>> +	new.data[0] |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_TV;
>> +	new.data[0] |= (DTE_FLAG_PPR & gdte->data[0]);
> 
>> +	if (pdom->dirty_tracking)
>> +		new.data[0] |= DTE_FLAG_HAD;
>> +
>> +	if (dev_data->ats_enabled)
>> +		new.data[1] |= DTE_FLAG_IOTLB;
> 
> This sequence should be in some set_dte_gcr3() ??

Not sure what you mean. This logic was in set_dte_entry(), and 
duplicated here in the set_dte_nested() since we no longer calling 
set_dte_entry() from the nested path. Also, it's not really related to 
GCR3 table.

>> +	/*
>> +	 * Restore cached persistent DTE bits, which can be set by information
>> +	 * in IVRS table. See set_dev_entry_from_acpi().
>> +	 */
>> +	initial_dte = amd_iommu_get_ivhd_dte_flags(iommu->pci_seg->id, dev_data->devid);
>> +	if (initial_dte) {
>> +		new.data128[0] |= initial_dte->data128[0];
>> +		new.data128[1] |= initial_dte->data128[1];
>> +	}
> 
> This should go into amd_iommu_make_clear_dte() I think, and refactor
> it out of iommu_update_dte256() ?
> Every created DTE needs these bits set, right?

Currently, the amd_iommu_make_clear_dte() clears all the DTE bits and 
set the DTE[V] (valid) bit. This is used when preparing the DTE for 
programming, detaching domain, and when setting the blocking domain. 
Putting this logic in the function would change the behavior.

These bits affect Interrupt remapping (Lint0/Lint1/NMI/INIT/ExtInt 
interrupt pass-through) and System management message behavior. It 
should be okay to set these up for the specified devices in the current 
implementation.

>> +
>> +	/* Guest translation stuff */
>> +	new.data[0] |= (gdte->data[0] &
>> +		       (DTE_GLX | DTE_FLAG_GV | DTE_FLAG_GIOV));
>> +
>> +	/* GCR3 table */
>> +	new.data[0] |= (gdte->data[0] & DTE_GCR3_14_12);
>> +	new.data[1] |= (gdte->data[1] & (DTE_GCR3_30_15 | DTE_GCR3_51_31));
>> +
>> +	/* Guest paging mode */
>> +	new.data[2] |= (gdte->data[2] & DTE_GPT_LEVEL_MASK);
> 
> I didn't see anything validating gdte has only permitted set bits in
> the prior patch?

Not sure which on are you referring to.

> If this is goint to decode array item by item then why not use struct
> iommu_hwpt_amd_guest in the nested_domain ?

The struct dev_table_entry *gdte is basically the same information as in 
the struct iommu_hwpt_amd_guest.dte that we copied from the userspace 
into the more appropriate in-kernel data structure type, which is used 
within the driver.

Here, we just select only what we needed for configuring guest page 
table specifically to be programmed onto the host DTE.

Thanks,
Suravee
