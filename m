Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011060.outbound.protection.outlook.com [40.93.194.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AEC39EF19
	for <iommu@lists.linux.dev>; Mon, 10 Aug 2026 07:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786345963; cv=fail; b=nZ2NVuOJxqqSJizebByE5b8VqldMKi/04mfmjpqXoD5QLbkQUd2ZRlPSZiBD2wW44e3c2QvjLBk61jX5I5avmNMCZd3ONZsVKwxp6Nma+/IvxufIdhpDmCmKp9HTqG3Ne2jEkrp2Nobnk1lT5LUkQ/R9k2iNniMbIA4UVjzAXuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786345963; c=relaxed/simple;
	bh=ZXIjD3pmUQwxumQNAp98ktZhlo7+Bj2fLylNkSTAn5c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QlAEI3acW/CcqjXsU7/wJaaLUGtJ1ZvMJLSzleXY6ArSljevHYrSKvjj90bRKBYNw4datRDxkWr6eqyxI/1A/TV8hDb0uKJDcMoLdowA23IiqpFexh0r+5wALfp8LNtrzI+Oo1idQoYmxMlACdisTF+Z0rdW5gInqhPu4s+YwTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=n2cVaUlv; arc=fail smtp.client-ip=40.93.194.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="n2cVaUlv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQJJAozJ+EqWb1PXPuiTielVs3Y0f4LIlN8/Zq7Kl/zNbWZiJSDk9zTvAyGQpP3/XZdbs1fjZJiU091qZ2cDJPTfRZlzNi1UbsNn7DNqKxE3aH87dXd++4PlTzxi9ZTaFxdm4i48DGZgFQDZWMfQhIABOG1B1Stg5pSOwLlJJUKRQ3EhnSDCXF0u9Pm5yBM94xoR7r3wSDczRc2bg4zPsNyl2PWSzHcSju2Go3dsWwA413XW6JjsTYUXyPDj+SyL5Kx/V3DOM+P2JKDevNfenH5eggz8PrccdgHFkm43ZaAbRn0W3boA/baAKc5Rv4bqK2dMVq4Il8P44GPOYKg2WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REzxbLme63nUei4+eYEIvKe6eQhsPnBRTY0MICCWMvE=;
 b=wduea1hpNTWS4e+nKUzX8O+h6AkrGpLG/Luzi3bQ45n/dvxzp7OPha9IWNUR4CKD2gQxcU72WFQzG26gcjEcwOCqKpF7lWU413v22BqBYCzt2LdJ9pgGKRyQHKxhCqzximRPuYxWBXoV5JXyS02nmZ/AttIEGZT44kal0KipINRy0+tSDCS5D/Hth0cLqDZBZPBvDvNAnymJW7Cj5FbvvirZSg/00W3MyDBfZYPlq/IDPi8eG3oi4MZN7+8enTBXXN4X+1yVhx1swwYTa0XZC7X3Zwnuq8pZN3rj1WWZ3Aq2doyx0r4dtwbZzxBOWTbGa0eT5bdcOmo4cP0PBVJ+TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REzxbLme63nUei4+eYEIvKe6eQhsPnBRTY0MICCWMvE=;
 b=n2cVaUlvfCS41N55dKQ+Fm3ks1OYawqtvLGQnlktp6eB9TOQtSldCzISi4Mv6FsmcE4Q7e2cUdk4lVAaVmQwH4ut9PIHQHgRMG3ms1A8/qr8WgCTA/qlCswltJVb0TPegvmRzPCPBV/leiVdLi0jqqmEy9yOxxcm3VzllkEwtsc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 SAVPR12MB999168.namprd12.prod.outlook.com (2603:10b6:806:4e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 07:12:38 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%3]) with mapi id 15.21.0292.018; Mon, 10 Aug 2026
 07:12:38 +0000
Message-ID: <1f2011b3-350c-46dc-a21b-69baaf059af7@amd.com>
Date: Mon, 10 Aug 2026 12:42:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/24] iommu/amd: Introduce vIOMMU-specific events and
 event
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, Sairaj.K@amd.com,
 jay.chen@amd.com, wvw@google.com, wnliu@google.com, dantuluris@google.com,
 chriscli@google.com, kpsingh@google.com, alejandro.j.jimenez@oracle.com,
 joao.m.martins@oracle.com
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
 <20260727132913.22475-3-suravee.suthikulpanit@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260727132913.22475-3-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0034.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26f::9) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|SAVPR12MB999168:EE_
X-MS-Office365-Filtering-Correlation-Id: 52774d55-0b5e-4f15-1248-08def6aec23e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|4143699003|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	J5WCJ0ed3yssJrdVURbM5/yIwGMYaTyhldXvj8TeRnKxi4OgHP3bqgQmRMPbiGLb9NqD/8sysk4WiAhNmsDlY8Yfafpin6HQyrZiFZCGbFcfct3A0BvHj4xO1eyi6Quzo4qRSsHh7/z53vt5PAOAsJW4tdkFoiK7Hv8gWx+7QRtYqCo0p40qY885+F5xcT3Ic97EkLmRJPVmSDoqzVA7FG0Tw2SWDQyeDVJmOXtI7eAKNYwqxftEzZHZV5BlX8F3Edk+ViUB9CK3XCh+C2zj1M3upCy5t8xPCddnmA0stP1OXhNKkZoguOg96v9CwREAXCmRUPnTtIue9SpKczxEVg2kNIm4r8gB0a+R7J52D1RXHPGAqz/HzP9luIDXEtlDLhtcr5qqE5c6gEnDE/4sQgAYz2tIp2vMyiJA9vNop8TaTXWMsRdKMwm+W+zsnTF73FyHoDHJsFjA5/e2dGFsPYWp/23ik/pj0XmzFT+9/j0/QjJtfjd4XwUGpn0W3hyBmfe7c0omOAUiHt/bjxHLJp53If2K/D1m2TS1dzIXQYPscy6cR5+MDVLkHdKMY+qmbMcMlMVqr9NDA5kcLNhi10binEgYTaQDpzGh8ojV2Lnwsj2OYNhEpq8n3TX1Xs3YcrgYVs+MqKRvVmDXdMUAgegpx4D//uo9n1TPxbyfVBg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(4143699003)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWNrQVpZbWUxdXhYQ2R6N2UyYyttT253b0JBTzB6K1R4MDQrVjlDREpzWTNj?=
 =?utf-8?B?ME5oOUUzQXBVQUpsUUlBZUR2c0ZwQ0hnWG1md1FicFJNV3hBd3VPUjFQMmxl?=
 =?utf-8?B?eXEvUURrblYzU0RFTk1xMEVsQVo0U1lySUNqckNYV1FqOHFsZ3FCZlBNc0ow?=
 =?utf-8?B?dDE5TTNST3d6dHlRV3FDc1dvcUhaejY1ZFo1ZXRyd2lsVW8vOHBhVDIvMXhY?=
 =?utf-8?B?NlNYVFhrQjdodFloVkYxaVRXOWUreElxOHRtRm1aK0tCY0d2NW55QWNERkN0?=
 =?utf-8?B?b2wxZzEzT2Y5T2FQaHI0T1cvMHdoWEVKdEFDR0R4OTFxb0hsWXNHSGlDaU95?=
 =?utf-8?B?a1M4TTZISmJoeG1sL215Tm1vVTMvK0FKQXdrWE1SVmZveEFSV2QyejVuMStt?=
 =?utf-8?B?ZlNjeVJyeW90TFBnK2k1c0V1eXVpK3lWYnBwdlhVdEQ5TmRRU2VSQm5YZHV2?=
 =?utf-8?B?Z25qYzZsZlU2MTdxSHJxa091amZzTmZkRHlBNWRYL0JGdGttWmd0YjZXOG1x?=
 =?utf-8?B?SmI5M25UUlhlbVVPWGdyVzNoL1VFODhDWGFrMHIwWVlOSkNaNGQrWmJNTWpa?=
 =?utf-8?B?VDkyYStrNHpGUFl5Z2sxc3duTDlRV3pkNzJ5R1lCL215Ry84dHhFL3IyZFZ3?=
 =?utf-8?B?RHRDT1N5b1F1M0RGamJZZk5lQzlSRFpwdFIvTVlxK2hRaUpGeHNZK09EL2Jz?=
 =?utf-8?B?eklrRVExdnVvZ05oTmlNRG1TUlFCK2dVTkxHTHNXM2RoYy9pdmJodTU0OWR6?=
 =?utf-8?B?NUd3Wk1wc2RQa0l3by92N2ozTlRrN09lUVhCZ3c1bmpndkx4b3hXZWJrclNF?=
 =?utf-8?B?ZWowdTluejFQM1BSTEhubTFLejZEQlo1cFZRanZlY3JCb1NBbzRQUXMwcnRD?=
 =?utf-8?B?aVFSOVJlTS9kNThFYkttOFFMTFFqMG1zcFpTRkpJbWJHUi9RZDFMMGlnL3lF?=
 =?utf-8?B?Y0k1TW0vM203eEpDYlBiZGVRL0JkVEZpT1pqVlE1OW5vN3JVNC96aWdJbVRq?=
 =?utf-8?B?aTJwWTN2QWNBS2thclYyM1VWeW4zVlR1UUZBbWJRQk1jZ3l4MjV0c0xZUVdv?=
 =?utf-8?B?YlIrUGR2dXYwSmwxVm8vYVExTUV5OHBkeEhZL0lNSjJ2Mk54THMyV3VIS21Y?=
 =?utf-8?B?NFFIai9XdU5TcDFIeHdjNGFua1lWdzJ6c0F1Y3E2K3lYVWp3ek93TTRIQit4?=
 =?utf-8?B?TDVNUmh6RnhWWk40OWhabGtyc3dpRS9YMysveWZIdnlqekNkNG8vc0YzL2xi?=
 =?utf-8?B?RFB5dnkwM20wZmVBbkhTTEhydG1JMVhuYlJqbSs1MFc0MUl6WHpiUXVqS05P?=
 =?utf-8?B?ZXNVWTNMbndCelRoWW9taDAvYUNjWU5Qalgyb0w2Tys1dWxJNEF6SHBQdUlP?=
 =?utf-8?B?Z0d5MVFuZkNZMUcxZ0lZZktJbFRnWEZVT3RZd2ZIalVaaFZHYU5DY0pGeTlm?=
 =?utf-8?B?cHp6b0NMWnYrelcyTTFuVFE2UER2R3dSdjJINVB4MkltcDRqRnR0RTBRNjd1?=
 =?utf-8?B?WHo5dWpURUpNaVhPUy9mRm8rcy9OeWF2bHdWTUExWW1XYXRaYmE5NUgwNG9t?=
 =?utf-8?B?ZG80MEdJZVVYMUQzalUwbFowWjdlT0FqOUFUT1BsQ2ZZeUpkYk1XVGhvT2gw?=
 =?utf-8?B?WmFDN2NSSzE3NW5kVCtkTGNxSStSV0ZidTZKalNUMERRYWUyOUdpTklqVW4x?=
 =?utf-8?B?c2RMRElKNThjSUNLUU91eDAvRHhnRHNKU2FXa1YrSjhaSEpEcjJlQUI0eWNO?=
 =?utf-8?B?dXRoV1NVdURPKzc5R21CQnE5RVlmUFNrYlBqZm9QZ213aFhwcHF5cHJMT040?=
 =?utf-8?B?SjhiR3dRWVhjY05Qakh4bFRlZTlFMSt2NkFqV3lxd0dzMXJzdjVSMXZzV1Y3?=
 =?utf-8?B?U0lJUkVpVGlPVEhaNXVYS3QyQXpzcVF6TU82R2pidlQ2eVlmNW00VHFpb0lD?=
 =?utf-8?B?NDQyODhrVmg2Sk93RWFSVTI4WXFQSmppR0lTeWtpZ21DbkhORUgxd0FqWHo1?=
 =?utf-8?B?aEhXWlpacGRJZEVuVE1OcmhUZ2M2UmlZTUh0L2RYZ3FWMXkybkhjWk5zK2dt?=
 =?utf-8?B?R3Y0R0JWQzFPMFdoY0RvWHphZlNrUnBielVCN3A0aHQvYS92QnVQc1lhSGNa?=
 =?utf-8?B?Y3NycFNCUXJkS3dvUVVGOTMwczBRZ2EzZ0I0QnVkV2w1MERxK0RPaE5HOEdE?=
 =?utf-8?B?TEhzVkpMMjUxUFkvREtBOUg2MlVrQUdLOEZwODRQSnBFbjhOQ0EvZ0pZb0ZH?=
 =?utf-8?B?Q3FoYnZNMVpvNDZBOFRaWFVLbDJWNDZsT09XZm5mNUtscnBNM3B6d0hZUnBp?=
 =?utf-8?B?Z0NidzF3NmtTcVJOcFJ5UjFaQkJ2dTRnS3RPM0kydnVGRk1rbWxlUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52774d55-0b5e-4f15-1248-08def6aec23e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 07:12:38.0877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BuGYOpryXVe/ZvDUu4ZoXerlNnG32TZ65oHW3FTyroUjTc+rCJYKWEWSYimwjxXb4Bu6VDI81PsF6JJAvFiJHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999168

Hi Suravee,


On 7/27/2026 6:58 PM, Suravee Suthikulpanit wrote:
> Adding support for new vIOMMU events:
>   * Guest Event Fault event
>   * vIOMMU Hardware Error event
> 
> Also, adding support for the additional vIOMMU related flags
> in existing events.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h |  7 ++++
>  drivers/iommu/amd/iommu.c           | 58 ++++++++++++++++++++++-------
>  2 files changed, 52 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index d2c64e2e9f05..4df6a50128de 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -149,6 +149,9 @@
>  #define EVENT_TYPE_IOTLB_INV_TO	0x7
>  #define EVENT_TYPE_INV_DEV_REQ	0x8
>  #define EVENT_TYPE_INV_PPR_REQ	0x9
> +#define EVENT_TYPE_GUEST_EVENT_FAULT	0xb

Better `EVENT_TYPE_GUEST_FAULT` ?

> +#define EVENT_TYPE_VIOMMU_HW_ERR	0xc
> +
>  #define EVENT_TYPE_RMP_FAULT	0xd
>  #define EVENT_TYPE_RMP_HW_ERR	0xe
>  #define EVENT_DEVID_MASK	0xffff
> @@ -261,6 +264,10 @@
>  #define EVTLOG_SIZE_MAX		SZ_512K /* 32K entries */
>  #define EVTLOG_LEN_MASK_MAX	(0xFULL << EVTLOG_SIZE_SHIFT)
>  
> +/* Constants for IO_PAGE_FAULT event */
> +#define IO_PAGE_FAULT_VFLAGS_SHIFT	27
> +#define IO_PAGE_FAULT_VFLAGS_MASK	GENMASK_ULL(27, 23)

You mean  (31, 27) ?

> +
>  /* Constants for PPR Log handling */
>  #define PPRLOG_ENTRY_SIZE	0x10
>  #define PPRLOG_SIZE_SHIFT	56
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 4b4dd20ebec6..50f26c8123f3 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -854,7 +854,7 @@ static void amd_iommu_report_rmp_fault(struct amd_iommu *iommu, volatile u32 *ev
>  
>  static void amd_iommu_report_page_fault(struct amd_iommu *iommu,
>  					u16 devid, u16 domain_id,
> -					u64 address, int flags)
> +					u64 address, int flags, u8 vflags)
>  {
>  	struct iommu_dev_data *dev_data = NULL;
>  	struct pci_dev *pdev;
> @@ -889,13 +889,13 @@ static void amd_iommu_report_page_fault(struct amd_iommu *iommu,
>  		}
>  
>  		if (__ratelimit(&dev_data->rs)) {
> -			pci_err(pdev, "Event logged [IO_PAGE_FAULT domain=0x%04x address=0x%llx flags=0x%04x]\n",
> -				domain_id, address, flags);
> +			pci_err(pdev, "Event logged [IO_PAGE_FAULT domain=0x%04x address=0x%llx flags=0x%04x vflags=%#x]\n",
> +				domain_id, address, flags, vflags);
>  		}
>  	} else {
> -		pr_err_ratelimited("Event logged [IO_PAGE_FAULT device=%04x:%02x:%02x.%x domain=0x%04x address=0x%llx flags=0x%04x]\n",
> +		pr_err_ratelimited("Event logged [IO_PAGE_FAULT device=%04x:%02x:%02x.%x domain=0x%04x address=0x%llx flags=0x%04x vflags=%#x]\n",
>  			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
> -			domain_id, address, flags);
> +			domain_id, address, flags, vflags);
>  	}
>  
>  out:
> @@ -932,29 +932,42 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
>  	}
>  
>  	if (type == EVENT_TYPE_IO_FAULT) {
> -		amd_iommu_report_page_fault(iommu, devid, pasid, address, flags);
> +		u8 vflags = FIELD_GET(IO_PAGE_FAULT_VFLAGS_MASK, event[0]);

Move this assignment to up where we extract all other fields from event so that
we don't need to repeat multiple times?

> +
> +		amd_iommu_report_page_fault(iommu, devid, pasid, address, flags, vflags);
>  		return;
>  	}
>  
>  	switch (type) {
>  	case EVENT_TYPE_ILL_DEV:
> -		dev_err(dev, "Event logged [ILLEGAL_DEV_TABLE_ENTRY device=%04x:%02x:%02x.%x pasid=0x%05x address=0x%llx flags=0x%04x]\n",
> +	{
> +		u8 vflags = FIELD_GET(IO_PAGE_FAULT_VFLAGS_MASK, event[0]);
> +
> +		dev_err(dev, "Event logged [ILLEGAL_DEV_TABLE_ENTRY deice=%04x:%02x:%02x.%x pasid=0x%05x address=0x%llx flags=0x%04x vflags=%#x]\n",
>  			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
> -			pasid, address, flags);
> +			pasid, address, flags, vflags);
>  		dev_err(dev, "Control Reg : 0x%llx\n", ctrl);
>  		dump_dte_entry(iommu, devid);
>  		break;
> +	}
>  	case EVENT_TYPE_DEV_TAB_ERR:
> -		dev_err(dev, "Event logged [DEV_TAB_HARDWARE_ERROR device=%04x:%02x:%02x.%x "
> -			"address=0x%llx flags=0x%04x]\n",
> +	{
> +		u8 vflags = FIELD_GET(IO_PAGE_FAULT_VFLAGS_MASK, event[0]);
> +
> +		dev_err(dev, "Event logged [DEV_TAB_HARDWARE_ERROR device=%04x:%02x:%02x.%x address=%#llx flags=%#04x vlfags=%#x]\n",
>  			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
> -			address, flags);
> +			address, flags, vflags);
>  		break;
> +	}
>  	case EVENT_TYPE_PAGE_TAB_ERR:
> -		dev_err(dev, "Event logged [PAGE_TAB_HARDWARE_ERROR device=%04x:%02x:%02x.%x pasid=0x%04x address=0x%llx flags=0x%04x]\n",
> +	{
> +		u8 vflags = FIELD_GET(IO_PAGE_FAULT_VFLAGS_MASK, event[0]);
> +
> +		dev_err(dev, "Event logged [PAGE_TAB_HARDWARE_ERROR device=%04x:%02x:%02x.%x pasid=0x%04x address=0x%llx flags=0x%04x vflags=%#x]\n",
>  			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
> -			pasid, address, flags);
> +			pasid, address, flags, vflags);
>  		break;
> +	}
>  	case EVENT_TYPE_ILL_CMD:
>  		dev_err(dev, "Event logged [ILLEGAL_COMMAND_ERROR address=0x%llx]\n", address);
>  		dump_command(address);
> @@ -986,6 +999,25 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
>  			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
>  			pasid, address, flags, tag);
>  		break;
> +	case EVENT_TYPE_GUEST_EVENT_FAULT:
> +	{
> +		u8 gid = event[1] & 0xFFFF;

As discussed offline, s/u8/u16/. Also may be add a macro to get the gid from event?


-Vasant
