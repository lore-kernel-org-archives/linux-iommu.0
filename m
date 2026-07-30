Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012004.outbound.protection.outlook.com [40.107.209.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9560C410D0F
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 11:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785411169; cv=fail; b=A4GPurSX7yxfU2EWg3A6oBylNR82W+aSAeIS/mok77vG+IBCk6qwrcK782RwUEgIfC8YvSixL4EEVL9Th2h0XTL0g5HCiGogYIvP+u3N3PerhdJGFQq+C4R5LvJ6ehmkatTu+Gdnb6KexspO0YbkWRB8Rz7OQGI5lFbNoAjpWAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785411169; c=relaxed/simple;
	bh=QgEJNlGBYG45C1dnKFhgWtcobfI607ATxDLpkiQ2GFI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OBS/Yl5CxQsKT0+KARogj+wlf2Y2bsr4jW7gsoQ3cOsOLruTXThFdsJbhuKZx7S1PwbYemwr2ePvvQ07zWCEaaBBCAOoWD40JrH/e6vqMlg2eLaFzwKl+/PFaREvVn99ldF8TeLKwSlKDLCrKrugnsVbPYUEqluWObvcP2gnAMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3y6hhyOn; arc=fail smtp.client-ip=40.107.209.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3y6hhyOn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sI9MXHr/JwFrCO1hYWEbv7kC7vMLfcXJxv3ADJgdLdqJg/2NA9jxMzCUcLSFsMomvgAoRX+rP5LQ7y/Kd0rpWpdgG/GvXOkLvczAagFKtciX+eiQ5wefqysicJ5Xza77OAt1EwneSup0Le5U2nZF+MtG5d3Jxpw6+vM2bh/svP6Lyf4vxiFaQ4b38ONWg5z3aexq5aU6nJRvxKyuOi3zHr22lW4bjUbDtVm2HZA48EajXHJ6rJS1RUBEvFVi/lt1dexWIWh6sl6JmW0DDPYUS7FAgcS+H9kg48iYAZE+mLNahtmvgKT8geMPA6RcfSQlOY7Tabpdla3qDvV9pRLAag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XjpYUT73NC2PWR/9eZ8YADUrtxIBnjj9vVjux3SHy6Q=;
 b=prAEkxCzov7iBQXwD/GJ3DE2CWauxamK6g5NvTQOqitSvqmGTaBpwNOXEMsAbsl6I1Thi/Y5EwUSf2pLbVSyUqVaXf+dkDtoqVuCr0gkhr+S6m9/OYuDiSd6Mn3h72JcvDnL1uCcamaosdd4MjQy6Lo7pmYrBsOXovF9jBdcpjYg0+UcHvy2wfk0fPZgnN+1LYeu+L7OM42RhsWpiAH8tUw9mG1nFV+TpqoByseDa/EvqCsxaxQGIyahk2a5gO1aS6I+O5vbYkpIT625lJVfG1t3yHJ4BtUhKGIP/nduJGlT++4DWLLM5LG1p53JId3FIVg0pb+ZzhEXTe9sAbgESA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjpYUT73NC2PWR/9eZ8YADUrtxIBnjj9vVjux3SHy6Q=;
 b=3y6hhyOny2ETeDd2DxO13waPMWc1UgOd6xeH1/5xGbEycJe2o5GCtpDGNmltdi+vPReEBZ4gYjI7Mp3FHhkwa4uEqelkEbnRNStrFUVm5habk/lFyKWUD8kfatDa0nCIPQeVG4ZbzD+6DmLkJQSo9leaDdtRJ3BTl6nfnZaOheg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 CH2PR12MB4119.namprd12.prod.outlook.com (2603:10b6:610:aa::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.15; Thu, 30 Jul 2026 11:32:45 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%3]) with mapi id 15.21.0270.009; Thu, 30 Jul 2026
 11:32:45 +0000
Message-ID: <b40c28dd-3207-46ca-821d-6d7ab922365d@amd.com>
Date: Thu, 30 Jul 2026 17:02:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] iommu/amd: Fix missing CMD_COMPLETE_PPR response for
 invalid PPR requests
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 Gaultier Delbarre <Gaultier.Delbarre@amd.com>, Wei Huang <wei.huang2@amd.com>
References: <20260727053907.7622-1-vasant.hegde@amd.com>
 <20260727053907.7622-4-vasant.hegde@amd.com>
 <2vrgxaflcran6gwzkuku3qiyi3ivhav2lvolipiuyup4vgj7co@227rwb6s3u7o>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <2vrgxaflcran6gwzkuku3qiyi3ivhav2lvolipiuyup4vgj7co@227rwb6s3u7o>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0104.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:276::7) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|CH2PR12MB4119:EE_
X-MS-Office365-Filtering-Correlation-Id: 5063d1f8-723b-4303-2257-08deee2e4651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	aFO4hV/PvSCyrcTIORVVAUxnx4yz7DWMJNFyGZ5UcXjceFuFaiSJ6kLcuN3wIKARVQ8Ixp0M0SXOCVxYJSFJvGoRoeHgs0KPQhgEMg+iHs370OnEGmoZ+bcIe78mz0pbNKuMhkBv3Nq74ZsdzPFGS/XNjOTK6L5nIHzaZ56MpM2aICNsU8S6PziWunPHaG7/+An8iR1zluoCS73GmXqdRy+UR8vSeChX0cIH3S2DkguOks2RzAZyrC8JUKA+8AaQU2Umi/z8SC8Us6OmNuRmFZ/HJXcdx4fVBZ6cUhPIKM0CfREHQJSZhZuc4PN7t0f6yqGSVt/HYT7rqY2+APcpRkUYJ0Xmqfz4q/CQrIB7GGH7KmiqQaiV+PAzsrx09NKSMNTbjUggyaEaDLHEkrB0Qt001wDi/zjo4tFFGudaj1+q4yfl+qVsANvReZJ+ONoWT7txbz7Lqngv6iY4kNHxZUBJiLO085SULFHfYIBsxYYpPM28eDtuAhskF2AvtbJIwQEj8gTjSAP7chM1Vt6Vk++/FG58Crp/ngcDcSUY0TPyqcDSv+MAs50w+ZxPhkwg6m6RPUhV8XrOm1S+2BFiCmkuB2/lFaaZjAwlKP7QKeXYGWUEAOMzstAFP+ulULAxz4SjlwhPuU/u5BlSedGP5d9PBk0aHFpjaRsqWtZYPIc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkFINCtpamtxUEZpV0J3WGEvTDI2d2RvbnhBeDliTzRscnNxZVloNkRWODcv?=
 =?utf-8?B?R2lVT2c5WjV6bHJvRFp1WU8wbHNGQk9zMUZJNE9EWW5qcWFFZ2Y1RTVXNkhR?=
 =?utf-8?B?dTIxOVA4Unpka05qNDJ1ek9ybVpaelRWUGN4a3BJdzZuclA2RTdIT1hoMmI2?=
 =?utf-8?B?Y3Uwd1ZCb2NFZ2g2Q0lFQXUwRmhGMWNXVXBTeU1sSllLZVl6bDJZaE1hV1ZU?=
 =?utf-8?B?cWF5eEo4aHNvelRkamU4ZERTRkE5TVYwazJrYUJqc0EraGhHZFU4U1g3WGVD?=
 =?utf-8?B?ZEt0bFZCWWkwckVFUjYvdjl0TzdEQnZ2Q2NMbWd5T25PSTNLRnMzODAwUHVk?=
 =?utf-8?B?dFp1VzFlY2pQSWpVaWc4ZVVkVWQzWlNEZ1E3ZGJ5Z2pja2V3cGJ1bERqWXB3?=
 =?utf-8?B?eFpqNU1FMTNDWlU1MkkxRUJPaFlTbHQxcTM1dC9JY2ZoMjFCZyswWjBTUEtn?=
 =?utf-8?B?RlNXN0FsQXkzUGltYy91Zk9seDg4QkV2Q1JmWFVOM2RmaDBOOUNwZDNWb2wx?=
 =?utf-8?B?MGkwc2xML21haWdtRjA3WnZIQWlNSXhwKzByWForYzVvZTcycHo3aHBnSFRT?=
 =?utf-8?B?a3JabDFON2RHNjZ2UWhwY0o4cnM5NUg4dTRDUElGS0toQkVTT1FldnA3cFdh?=
 =?utf-8?B?MDdMTnpQTFR1eE14TEJEOHNKbElCRkorYXI1SjVxSGdZbS8yWmRhU2Y3NmRW?=
 =?utf-8?B?STR6L1Q4aG1kdld4NHFpb0p2YXVJSEVCTlRHN1AyOElTM0toY2QwMURwd0RE?=
 =?utf-8?B?cGtGOHROaC8vVSt2aUVyUnR0ejZPVkxIVFRINzBjRWZmWmZaVzhZYmR3NHI0?=
 =?utf-8?B?eThrMWxGYzJBQ0NCN3dUZkJQVllCVWxDb2RSUnhHZVRCaEw5SU5NcE9pR25H?=
 =?utf-8?B?UU5LUUJCamlDbGU3TU9QaVJVSjA5RUh0SzJuajIzeUlhTDVuNEt5MllBY25h?=
 =?utf-8?B?b3lFQmZSZkZhdVhQUlFuVlBCcjkwV0MyUEVDNUlFVXJEbnFzRklxa0VISERB?=
 =?utf-8?B?M3ZkbnJtNDBQU2Z0cFVwdmMyaEQyK0kwODNOSVc5b1F2UlU3dXVBQUhpV2hW?=
 =?utf-8?B?VFJFc3RxM2lhMWw1SDRrNmNuL2hyWTVhSSt2Qm9CeVZVOUZWdCtZMlhqT3B6?=
 =?utf-8?B?MnQyVlMyYnVOeWc5SytwRUVnV1pSOEN5M2xQZ2RDd3duVXRtM05YTTJ5NUth?=
 =?utf-8?B?TTNKMkRMSS9DUFZLVVZ3ZmozbGlpV3c5Z3ZxRElyL05LOGQzelRNRWdHd29o?=
 =?utf-8?B?VHg2Nlo2dDFxc1BBK2lWQ0hnQXF6MDlwbjBNY2JVaDVyVkhIemY0WWJxUDRC?=
 =?utf-8?B?d0VDSGJTOFBuZ083OWN1MERoRkRKd2s0U3N6VnlUVC9FWU5BNnlMeGc4TDRT?=
 =?utf-8?B?REFaTG5vVnc3YnFRKytyZEFKMFdqZVBKVDZFZ2NqMCtFTzdzcEJKOTE5clJ4?=
 =?utf-8?B?WnZuSWVUQ3lSam1pMlJQaUJFaVBjWUc4SHJ3TlVmcSsyZ0ROcU1Eb2J2YUZY?=
 =?utf-8?B?ckwvZDFRbnhxeHRoNm5Kbm1ZQlZBaWE5MS9zVVdRTnNLL2wvRVNNWnd3ajB4?=
 =?utf-8?B?Tk1OMVVVNldEMjJsMDBmbVN5QncxaWxMZWRrUy9sOVNBYUZIMUJqbVRCN1Vm?=
 =?utf-8?B?cTBRWkRHcVloN3BIeXVlaDJ1UVBmaDBrYWhhaDBWV1ovN1BERkVneGpLWDhQ?=
 =?utf-8?B?VlNrZzZMWVVYSWppNjN5MHQyMkNjbG93azhURHh2SjBQVGgrTzdWNEhTNXBi?=
 =?utf-8?B?YTZmUlVncjkzZndOMWZCNEFTdVJtNzFzMkhpUkUxSTZRbitiTzdxbG1Takl2?=
 =?utf-8?B?M0p0YUJqdW9YQUpYSDgwVDlnYW12NEI3UzRzOGo0R09pNjcrdW9ZUzZFRHQ2?=
 =?utf-8?B?WHdPcHd5VTkvZTc1dVA3Y3Nhc0JpM243VWIyTWlUMjBlOG1BcnpvK2NOeFZm?=
 =?utf-8?B?eVdlSjJzazhZQjZFcDJZWVpwWHZ1NDZiYW51NnFyTWZsOHZPdkozNjkwaVh4?=
 =?utf-8?B?dFNmR2E2anMxa1ZOQ3pWVW5mc0dTcVdpU1VCbHV5ZlEwUVNlU2ljcktxNjV0?=
 =?utf-8?B?V2Y1K2xjb0s5dktRYmVjeHUvd2l3SmozUHM2R3BiTUw5ZHdUM1p4d2ZFVFYr?=
 =?utf-8?B?MzdqZFhUS3RsQjFJd1BRZXlSdHVLOE1JYlZyVEpxb09jTW1QV0pwS05IZHA5?=
 =?utf-8?B?b2Uya2YxckdLYVVzT1hBSDBxM0J3YmlFTk5ESzdkbFpOWkNTZ3QzNkRkTWtX?=
 =?utf-8?B?bmxySlVGNlhneWhMN1BOc0R4SmxNNmtpcEdIQ0c4VWgxUEtsR1kvZk5YWHJF?=
 =?utf-8?B?bG90S2Q0MEFhUnN3N3hDQzlRM01iRXhGTmlYWUNOaTFMSlkwell3Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5063d1f8-723b-4303-2257-08deee2e4651
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 11:32:45.2232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 19CszRWW33NMKv5pHkkQl6aYwLWwxVXN7Sh/VkOTZxi7qrxb5apjgwDaoQBpo5bsitA6+nXabWW8pMMxtViuXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4119



On 7/28/2026 12:02 PM, Ankit Soni wrote:
> On Mon, Jul 27, 2026 at 05:39:05AM +0000, Vasant Hegde wrote:
>> The AMD IOMMU spec, requires the host to respond with a CMD_COMPLETE_PPR
>> command when an EVENT_TYPE_INV_PPR_REQ event is received with the RX bit
>> cleared. This response was missing in the current implementation, leaving
>> invalid PPR requests unacknowledged.
>>
>> Introduce amd_iommu_report_ppr_err() to handle EVENT_TYPE_INV_PPR_REQ
>> events. The new function logs the invalid PPR request and when the RX
>> bit is cleared, sends CMD_COMPLETE_PPR response.

.../...

>>  
>> +static void amd_iommu_report_ppr_err(struct amd_iommu *iommu, volatile u32 *event,
>> +				     u16 devid, u64 address, int flags)
>> +{
>> +	struct pci_dev *pdev;
>> +	struct device *dev = iommu->iommu.dev;
>> +	u32 pasid = PPR_PASID(*((u64 *)event));
>> +	int tag = event[1] & 0x03FF;
>> +
>> +	dev_err(dev, "Event logged [INVALID_PPR_REQUEST device=%04x:%02x:%02x.%x pasid=0x%05x address=0x%llx flags=0x%04x tag=0x%03x]\n",
>> +		iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
>> +		pasid, address, flags, tag);
>> +
>> +	/* Skip COMPLETE_PPR_REQUEST response if RX=1 */
>> +	if (flags & EVENT_FLAG_PPR_RX)
>> +		return;
>> +
>> +	pdev = pci_get_domain_bus_and_slot(iommu->pci_seg->id, PCI_BUS_NUM(devid),
>> +					   devid & 0xff);
>> +	if (!pdev)
>> +		return;
>> +
>> +	if (!dev_iommu_priv_get(&pdev->dev)) {
> 
> Hi Vasant,
> May be corener case, we return without sending COMPLETE_PPR. Since the 
> goal of this patch is to always respond when RX=0, and the completion only
> needs the devid (already available from the event) and iommu, should these
> paths still issue the completion directly via 
> build_complete_ppr()/iommu_queue_command() rather than just return?

That's even before the probe is complete. At that point we don't get these event
as interrupts are not configured. So its fine to return here.

-Vasant

