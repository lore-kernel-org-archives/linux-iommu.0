Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010013.outbound.protection.outlook.com [52.101.56.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7192D5932
	for <iommu@lists.linux.dev>; Thu, 20 Nov 2025 06:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763621818; cv=fail; b=FMYyjM3rMzWy73IXcahRx5Y3mpEZCXjzIEuQ3NRvglwt9mrBtWj1AIfvKtJ9XyYBtpMx8eXeVic5jiEniLO7ZdTPm/ExEfqH6Jbf38T39WnMpV2KIQr/K2xczB54Na4MFPhGCdXLpVE0UEiG7AGFfn8Qr9PcWMZkI8ksIraTxTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763621818; c=relaxed/simple;
	bh=JsJwekVMuDrt/vu3lHcCZ2zOAuuNggjHGxdS7I4LBIc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VboyXhcxcYo1PUsa69g3eNNr1epX+TEBycOwv+55KP69h90ASz3Aj2kAaufguJ3ex5ZtmQq5RdP0js6udAkmhRJWUXrxvFCoRhUlNCZ89E3Rx1RWBfxpTiUJkinOEsY5MKjeuFN5F4xA3pW1qK4/CwFuIIYVYI51/oA6Aw4Hh7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w3/oJO1r; arc=fail smtp.client-ip=52.101.56.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w3/oJO1r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfS+4EPR3uAhsVjQc4568w4mtsqDEB+2SAnK5kw8lU0KeiaV2YGroGCzmBRXJ0kYc8RVkGSC6MjpI3b7N7ZVmQCw3XE9Cdk1OPM4uiubZ9/l0J/jQyFfs+xWgqzcGyLzLduNPHnSAc4k5W46tWx8hMS9MWqzHBL8L/gKF6iv3ez2z/PSGWiM1R8BoN9uqEAnK1FhTc8KANyd3Mj0saoXYZjXIBPHDBYyhLC/W9FWdlec3Xs+cYFEZaQXRL8fECeQfUfts70ytafCdCd4wOn9fmE0mt6KjSd4QNq4HWujChGJseQC+u02QuoSFPHH6EHcDbxNQDrRgoA0kA0R7yLysQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWqXn52PZVynL5MpH/ggPo7qb49ohkVrlP62wDJWKRc=;
 b=Upk6scEskg7tEIBpDvdJjdkEcAB1e8zfOO5AZdLNjKptoo1gtcvme6RISAZ0IYiLxnI2GqPDOwz5rRvUnZsx+dgpFaYdmU8zkPAP5CeJtqMUt6qspHrBif8kH8zJF8BSYpO5FJ3H7x46bR7BB/uO9gw2C4wjVzc1R2qVIA44/FmFNFsf7R0fNC6weA9U06IO9GGKeYCUhebZlSvHhcoNKT+CV1JQqzf2R+xkXA4Ic42nd++2CauXpz1q2g3HUqCDx+lqkfG1VTANfwGUNbqwUjZtimgCk8mYF5BJnVlTYVZNJPGCJV0ON44y8anfF3OWgijP9A1ypdRzN2RILRQnxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWqXn52PZVynL5MpH/ggPo7qb49ohkVrlP62wDJWKRc=;
 b=w3/oJO1rwk82C/xIG1wcAJBKAgiw/9LkVlUF4AD6YHuQwtg0wVS8NppIzl+7ESOHvclOLJ7ccdtp2MRwUkBLwW1E1j5V28DvScoxojj8w1j72YOEn2gXwSEdJajFWYF8JA+RWQtfknGr4x1I62/FFuKFx09+d4Lm+9yRYDbiSOE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM4PR12MB6085.namprd12.prod.outlook.com (2603:10b6:8:b3::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.10; Thu, 20 Nov 2025 06:56:53 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::a5e0:9d7e:d941:c74d]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::a5e0:9d7e:d941:c74d%7]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 06:56:53 +0000
Message-ID: <6c0710c3-cffb-48db-872d-96e2e836fbdd@amd.com>
Date: Thu, 20 Nov 2025 12:26:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] amd/iommu: Preserve domain ids inside the kdump
 kernel
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Sairaj Kodilkar <sarunkod@amd.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, joro@8bytes.org,
 suravee.suthikulpanit@amd.com, ashish.kalra@amd.com, robin.murphy@arm.com,
 will@kernel.org
References: <20251114104442.23296-1-sarunkod@amd.com>
 <20251114104442.23296-2-sarunkod@amd.com>
 <78a4598d-5d35-4fd0-a830-a740076aba41@amd.com>
 <20251119134351.GM120075@nvidia.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20251119134351.GM120075@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0126.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b2::9) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM4PR12MB6085:EE_
X-MS-Office365-Filtering-Correlation-Id: 415e1d25-280e-435c-873c-08de2801fca8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXZCdDhEcVUyNnFMUHJTNVJNNGk3MGtWVnBVKzlaTFdNLy9DNXE3Z1FwdDJW?=
 =?utf-8?B?VU9oT0h5aHlaeWxNM0ZCQlZlUjdTaTFDNFFONysxNDVHTC9UNWs4OHpGSUhY?=
 =?utf-8?B?QUZ4WFNwU1E5N1ZuUFU5cGpPdFFxbzdybFNURldoSDlva0VNbUgzZnh3RVRI?=
 =?utf-8?B?WThtZ1NEWCtYcmYwNWY0eElQdFFKeXU0cDZZR1FOZ1BuUFN1MUtXR0ZsQW5C?=
 =?utf-8?B?Y3pzdWdJaktRcmRHQkMrWXlJUzdGSGNnNTVqaVpDeS9LV1h0VUhuRm5GUEJL?=
 =?utf-8?B?Sm1vNXRFQloxTUFxMitKY1VBYUJFL3MzT2hKM0d6azlOZTNYU3crRDVzY3Rp?=
 =?utf-8?B?WUpwN3RSYW1HTDc2SkhGOXB0Y0MxV2NENnFZWjZhY2lrZDV4UEtiSk5PV1U2?=
 =?utf-8?B?MkF0ZEZ5TVIxaW1FQmpXYTFOKzkrYk1ad1k4SEdMY3UxelBPY2lzRGYvbjFG?=
 =?utf-8?B?UGt1MVVsTjB3Mnl3SlNhMklBclN2OVdJOVEyWkp3WW1yMEdQSVJVZ1FKUnVR?=
 =?utf-8?B?T3V3VWhQdGdrclowQUN6Ymd1aVZ6ZXVUY25hZCtHRHpRRGpOV3NlSVJpSnll?=
 =?utf-8?B?NFVrMDZMd3I0c05ndGxzdS8zd000MzFwSzFKWGEvV21iRkVETUp5cEZqWWVQ?=
 =?utf-8?B?OU41MDdRSHZ5OW5TVFIrRWVteWpPYlk2WEVERm9XeEFLUjJTYnd0bS9EdFp3?=
 =?utf-8?B?RUdWSCtNc1E0NFdUMGpxbGdLeE92SkZmbnNIVlh1cm03MmFraTJuRXlCaVhG?=
 =?utf-8?B?dmY1bWZPYzV1MnBFV3kwWDlzck5pQVFQeDZaWmVXL3E4L3J6UU5GQzdDcXYx?=
 =?utf-8?B?VG45dWNNT2VBRUFpUGIrc2gwQWcrWmNSMWZVbkZQemZKS3ZlMWtEUzFURVQv?=
 =?utf-8?B?cHFJNkQrK2F3NGZCWHVXNGZoZXlJSU1zRWNOOXlnSkorZlUyaW1XUTYvM2sr?=
 =?utf-8?B?SkVVRDlKYzVaNUNUTk9VL2NZR1NnTm8wU3A1dHlCVlBCV2VEbjA5ejlsM0RH?=
 =?utf-8?B?ZFRZYmJSMVRxVDRvejF2VGVvUHhieTV2QkRzRkFFVTBlRGFFVUdHYTh2dDRX?=
 =?utf-8?B?dGhHWTRRdFJDNmFGVnFtcjFBQWJMOGE0cG1JUUZnUGM0L0tIczQ0U3VhKzJU?=
 =?utf-8?B?MzdwQThsZGhwMG05UTRkQXhyUmhWTFFZcTdmTEVlVXRVeGZxU0ludVdBWU1O?=
 =?utf-8?B?UHdVMTBFbU45Zyt3UnNSMmxhcU56UFVHaHBndDJNaHJiK3pZbVNDUFFPWTBl?=
 =?utf-8?B?eXBrdzIrbzFHMTZ1Rkk3cmdqNUZKa1kyUTlYclBkbmJFUVpnbVlzbTJqR0xk?=
 =?utf-8?B?TERqKzJYVkZERUJmeDFUL2s3UHYrRmw2M2RjeDV6ZWVpdlpZbDk5a3RzYlhD?=
 =?utf-8?B?aldqSW44UklZRmNieWlaWGtreFZUamdYSDJ1bmtjQjMxQk9NeG9vaGZoZzBy?=
 =?utf-8?B?SHh3UWF4MzBha2tIYjVZM3RwV1lHZDBla3R5RnlOUkZuVzlINDQxNStpcjBz?=
 =?utf-8?B?QWk2TW03S2hFdmlEZy9GZGxHQVg5ZVplTmwzVkNSSUJVMm0zZ3J5ZFRDbTMy?=
 =?utf-8?B?RS9aTDV3bXI2SmVPM2lPMjVjbUtzc3JRMlIyb2pad21oSlh6SEVzM2VxQm1p?=
 =?utf-8?B?b255ZFdOclRJWE5VWVFSUzJ3a1VtRHkraFFFTEJjdGJyVGNRVmIreS82clJM?=
 =?utf-8?B?T0hJQ09UcS9keDdoZHhreURybzQrdmE4NDBaZUE3dHBNNWFoT2hFdmUyZ081?=
 =?utf-8?B?YlZqVzMrL1NxSEhwVzFBNjlITEFDcHBBeEhGa2hsWVNWVE50MW9SZXJFRW5a?=
 =?utf-8?B?NGM1QUlLWENJME5EcWhGQlppMmZyajVhVFcxMEg3VXo4UEZ2U29SK1JCV0F0?=
 =?utf-8?B?RXdhY3VPeWRXRUQxWFVmTG94b0liV081QmFPSHRaWHB4QWNNQVZwM1ZWYW0x?=
 =?utf-8?Q?wUJC4ZKa4wf25UXNiTg1Ik/BbSPcG6q6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjVUT3VOMWo3YWUwQ1pFcFlSOHo3NWpkVVV5Ukp1R3B1cFhoWjYxSVZ6NUxI?=
 =?utf-8?B?OE0vbnVHaTZzUW5QUmxkUFR3VHlzaUM1cWduZjZnU1hpbnVmWDk0YXczRGgw?=
 =?utf-8?B?NllMQ1BUa2tXYnptK0F6TWR5aDVMYW1iZ0U2SnZ3QlNtbnF3SUxXa1BVRGtK?=
 =?utf-8?B?WGsvSXJmNVlXM1NYMnJhWnVNSkFXOWo0b2t5YlpWUVpuZnRPZzVYSGlEeTdO?=
 =?utf-8?B?RjNFTktPekVVSjlUeUIxYmpsaFowOFVzR0lvb1VnYlZBOUF4TnRmZEV3ekxs?=
 =?utf-8?B?V1Q5djJ2VG43UHNJdDVtSXJ0ZUpjc3VMYjhxVDJ6MU50VVY4QVVicHJWcjI0?=
 =?utf-8?B?WkJtSkNZeUpsbjcwbHBERGxEMEhZMzJiQXNQUEZYdFFDNXg1dkN4Qm0rM1E4?=
 =?utf-8?B?NGk3WHBmVHlmQytvNGR1L1dyRHBrT1lRTmRKTUNSSVl2K0hxMEZoWmt1RWxF?=
 =?utf-8?B?UHppRE9XWXUwYkt2UFUraktrOHVXWWxjLzJ2TE1jb2lmV0p2Q0VkK1NzNkNO?=
 =?utf-8?B?dXBxbmdhcUgwbDRiVHdUZS9SVUx2QTRpTy9kdHp0U0d5VDRSQ1UvUE10OU5k?=
 =?utf-8?B?d0VkUnhrZDVkcktEZHJrTUZSS3MrUms3bk5PSFk3UEpreE05aFNBL296ZUp6?=
 =?utf-8?B?RFBLaTB0M2o4cFMrZ21UWXdWLzFsdzFZRllhTXMyV1hvNFg4UFNGUjQ5L3dr?=
 =?utf-8?B?enZKT3kybzRKRzRsVVVaemxQWk9Rc1RxVWw2cFdmVU9Ibm5DUHMraU0yQXpk?=
 =?utf-8?B?OWlUcFVrbHp3bks4dUxnc1dYQ1VMMkVGZWFtT0VkQmlTUkp1ZWFQTHBHeEdI?=
 =?utf-8?B?WnpCVzRaR2tOSWN2QlBtQW9TSEh4NTh3eHJ4M2s3YTdsU2dHYzFIWWZDT0Ny?=
 =?utf-8?B?STN5VmlObUZiUE9HSkVBMElMc0cxNUpIRzVTbXlCVUxOZVZSUDZ6Z1pka25Q?=
 =?utf-8?B?NTZaclQ5TFpuYTdDVEtIWkhueXdpTUJzaEorSE5Jc0k1N0RqWTR0RGlZN3Np?=
 =?utf-8?B?Z211UUhVRjkyYjdMdmw0VVI2R012alcxNnE2c2pqRGdRaGh4RkdjakhSNHc3?=
 =?utf-8?B?RWZDZ3VBOHdqUnA5c21PVUJOTy9SMDYzSkl5R1hmZHNncjlPeTAxWVVsaEpq?=
 =?utf-8?B?VkY2YUg5SWhhQ25hWUFlbjZvMEpJOFFCTVk5ekQyTzR4d3phMXI5N3FjdlRR?=
 =?utf-8?B?ZUZQMmtJeks4NVh6Q3phZ0tnWmtTL0FNL21tc050Q2p4T0NZNGJJZ25oY0px?=
 =?utf-8?B?SEdKTm5UaFdQNjJVWUUzVnlQeW5IbEdpVDhvSmNMTng5cnFSQXAwWDErNUFx?=
 =?utf-8?B?MWNhWlhsQmQrSC9wQ3YvVEZyeS9pRjNMTlBkVHkzTGtSYVkyVEQ0MDdXMTB1?=
 =?utf-8?B?RDdHOVR6U1d1YmRoYnJMbG1TTUlmWkFMYWp1YzVPMHdnWDVGNW4raFp4eWFt?=
 =?utf-8?B?c1dwQUtSMHB2ZjNINkVITTFnNEc0aE92WWVKZUVYdEhXUnZTL29NSXpYWmNi?=
 =?utf-8?B?dGVvRHFRZWdJUXhERjZiQ3lDSW14MzNDdkExSHhVZDZEZFBaOVVmdXhUbDA0?=
 =?utf-8?B?OFd2OWNReVNhdVpPWjlpUjVvc0Jmc0kxaTNaKzQzcVdFQ3hpWmMzSmFFeGp4?=
 =?utf-8?B?c0JSZHQxTVlNbEtJcVlnbE16U1B4bGNqa3o3RUo3amdVL284Y29ZUHdXVEEy?=
 =?utf-8?B?K0VCWEdUbGxvbWVET015ZThNZFcybXpkQWZhWit6YkpnemtKRHlUSkFNZ3dD?=
 =?utf-8?B?cDRiWDA1NGVIVjJMZkZGckdZdkZncEQ5NmpOUDEwdnNqRWpDVVI2LzVtUVdZ?=
 =?utf-8?B?M3MxNDZqNU5HNDNrSGptRTg3UVQ4L2ZxUzZab1Uxd29QQ1k5NzZRVUQ2VU54?=
 =?utf-8?B?SjVseGRYcWdEMmpWNGxSUHVvV2t3cFBlcXpHbGVwM0xjY3hmYzBtRjJPV3Vo?=
 =?utf-8?B?Z2h5OGZROWtmcS9SdUxJUWQwZ0Z1Q2lqbG1wdmNSWmYxRUF4TjZNUzZmSVZM?=
 =?utf-8?B?RXBiTXJFYW94OGsxSWl4WDF0Z1N5U3lmTEc4bC9zZ3Z6UzhMditqd09WOHEw?=
 =?utf-8?B?YUJVQlk2enE1b1lkOGFGVy9Vd0wwVmhPUEFrSmw0MDE2RElCbW5JTDJscFVM?=
 =?utf-8?Q?8viiV5VQFDAsOpHJ5vzISRKFL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 415e1d25-280e-435c-873c-08de2801fca8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 06:56:53.4682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: baSGDsZ4I/XVTNx/YT6y7hyWTwYHPQeqMZ+N0oqhjstJmgpIk3tJAO+bjJwNoQtMbGUEzMESwGtoNNIoB0/+Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6085



On 11/19/2025 7:13 PM, Jason Gunthorpe wrote:
> On Wed, Nov 19, 2025 at 04:20:28PM +0530, Vasant Hegde wrote:
>>> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
>>> index f2991c11867c..9375fba1071c 100644
>>> --- a/drivers/iommu/amd/init.c
>>> +++ b/drivers/iommu/amd/init.c
>>> @@ -1136,9 +1136,13 @@ static void set_dte_bit(struct dev_table_entry *dte, u8 bit)
>>>  static bool __reuse_device_table(struct amd_iommu *iommu)
>>>  {
>>>  	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
>>> -	u32 lo, hi, old_devtb_size;
>>> +	struct dev_table_entry *old_dev_tbl_entry;
>>> +	u32 lo, hi, old_devtb_size, devid;
>>>  	phys_addr_t old_devtb_phys;
>>> +	u16 dom_id;
>>> +	bool dte_v;
>>>  	u64 entry;
>>> +	int ret;
>>>  
>>>  	/* Each IOMMU use separate device table with the same size */
>>>  	lo = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET);
>>> @@ -1173,6 +1177,25 @@ static bool __reuse_device_table(struct amd_iommu *iommu)
>>>  		return false;
>>>  	}
>>>  
>>> +	for (devid = 0; devid <= pci_seg->last_bdf; devid++) {
>>> +		old_dev_tbl_entry = &pci_seg->old_dev_tbl_cpy[devid];
>>> +		dte_v = old_dev_tbl_entry->data[0] & DTE_FLAG_V;
>>> +		dom_id = old_dev_tbl_entry->data[1] & DEV_DOMID_MASK;
>>> +
>>> +		if (!dte_v || !dom_id)
>>> +			continue;
>>> +		/*
>>> +		 * ID reseveration can fail with -ENOSPC when there
>>> +		 * are multiple devices present in the same domain,
>>> +		 * hence check only for -ENOMEM.
>>> +		 */
>>> +		ret = ida_alloc_range(&pdom_ids, dom_id, dom_id, GFP_ATOMIC);
> 
> Is it really an atomic context? Why?


I had to dig git history to figureout why I used GFP_ATOMIC for ida allocator.

When we moved to ida allocator we used GPF_ATOMIC as there were paths were code
was holding spinlock before calling ida allocator.

Now that those paths are moved to mutex lock and remvoed redundant locks, I
think its fine to change it to GFP_KERNEL.

-Vasant

