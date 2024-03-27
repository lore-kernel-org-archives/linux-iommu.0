Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2095.outbound.protection.outlook.com [40.107.100.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7A81CA9C
	for <iommu@lists.linux.dev>; Wed, 27 Mar 2024 06:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711520137; cv=fail; b=RpRRxeTBUA/4F64MyzaOGzelIh8QIAVWRcIViwOQ8ZVMQjTXX5OmWQSkCO8Fxlrp7yoWm02OAsj5Sj7oAXQ9RNdBEMaeQRi+UHbkzsrnk0Rl76iG/VjLJCA9Qc3Ii1E6ZgvYhfXX2eZqO3sSvBklAteIRa5J+bT/2v2+nzLMjZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711520137; c=relaxed/simple;
	bh=WaXdBDMrybV9kTR6qhJes95lxzIEap8hpeXbFrIbpCQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CGWjy0URQhS6qqgV/un/elObmMkDIyM35ZB7TEIvEMVpb3LrEJN2njHqKHWSB8NISqGIFax2O1DfJI19XA1Njt9nVkUNx5FKYXz8/YKBJT/oJkHkZYSdUHl2/TrrxKATigGqZpAR0/kfPc55C7zNyKyvhYyYSslV44yqbsCZsSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E2gpIo0n; arc=fail smtp.client-ip=40.107.100.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E2gpIo0n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdfK67KNHwvD+kcywBboF3Df0WJxyrdibQfUleB3R8/TTBGPihX0/mBsOg9+KE/JDD9vyxhjtD08uCAm7G1cqYcM4RFEuHl/S2ARrr8+iXO/QAaiOnVAS4PQnlhh26UXttKGpAt+eTQmSkCpn9ZRrpr2y6lSOomZucAwJJ/ihri9ZvpUV+N3qHx+cb2ZmqpPXMKWatGfvWA3YYyEhSo7NxGn4kiN212LkrxrgF6j50aYPIGb846ZbIiioHqrJx23xT/aKHba78tb1Ev+B6dQZNMeCRd1FxXdkO+L2YbCT92yUFKsgZch9ZN98LnFehPSNGDVx3mAZGrYDOGTg12oLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vBlCNb2h+sZ800WZS4CZabDRrlVK/NHq7B+8MGVANk=;
 b=hdDVVKmjIZFC5qFahJZiazwTz/t/Z00WJ0/39vKwh/KEDN3AkG250ymVJLxlAlyiXmx1g5N5Nf6PQkeDN0s4L+SIH2xF2xadWbYl//4O9oLBh+3AYyecTnVNnasZur/ixvgjQ3a2jgC2yaBGbeal85yGuxt+ROLoxV8q8Ogu/9luNZYVClAMIxjltgBUFFQui8XziyVJMh8vS+PxiARtcObr7+ABc3O911wnGiyu0D86BsYuzr8Yf0QpYJMhfm3toxtHD/fwBFjjse/KgF8Ph/d28k8uoHr3OYoitsma1doDYGSKFmaN/BlZ6yZWTsgt2FZKRcK66PSsxGj71+9xiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vBlCNb2h+sZ800WZS4CZabDRrlVK/NHq7B+8MGVANk=;
 b=E2gpIo0nVwrW+jpomExnTXZBzvtKasxZxgEPv7/qcUtIYtfAKkn7B6X3T3xMoBqWkChS8+uPkx6kJ3iw45WXjlLN3O21v+T7c7W5zbQTMUslZcD83t5iPaufACNAW4mXR8EzaJ74C3zXVnuU7MbPuaPQ0CbWrIEgbA7QuZd8zS0=
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM6PR12MB4402.namprd12.prod.outlook.com (2603:10b6:5:2a5::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.33; Wed, 27 Mar 2024 06:15:32 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::af7d:5f4f:2139:ebd1]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::af7d:5f4f:2139:ebd1%4]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 06:15:32 +0000
Message-ID: <32fa8731-75f6-2b2b-a091-ddd6d5398a3f@amd.com>
Date: Wed, 27 Mar 2024 11:45:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v6 13/15] iommu/amd: Initial SVA support for AMD IOMMU
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20240209112930.63663-1-vasant.hegde@amd.com>
 <20240209112930.63663-14-vasant.hegde@amd.com>
 <20240305005053.GH9225@ziepe.ca>
 <0ee69ffa-564f-c298-2a66-b4d7d4440856@amd.com>
 <20240319175650.GE66976@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240319175650.GE66976@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::6) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM6PR12MB4402:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vQpaDDBdtlQi5ztc8AEZ70+EP6RUeuCFruRA9V0QbHkq02HWqRaxC7zbZ/hZbWAC0h/VZptf3pyPWTrkxipsuaSistXiGnz9u06aOblLd2H7iz8LFm+cSD9DzysHdWHXwp/D5vm+ip0ciI//LyCd3u+SohUBv5Ua2DQj0RI0USmxbMJw7ZjK2jUDJV6cCh1zuIKbdu7I9D1l1F2DVXQ3lgP1SvIVKA/cLZBhwkTUfLrOsiWaAQn0W2AWSddSQUKUWvgo6UBA1PiSbe3L3M6YXA9bUkW3At/rtVZscvlAEMDO6fbXTTIimDycuxoo8GiFbREzuIYJeLL0Ilbn9Zo/ojHvBoir/aAYPUNRTMzPsAYD/Ox/ENfRKqr1qpeZDso+WHpme4/8o76/vPZaJoZxmOSfdmX9K96EyCIvL+1SL2x60/NB72mMuoW12IQ3/NZqddxgssn9IvKLd23+5CIyhnNq+TbnVOY3p8jaNf+dd7hsQUQ4jJaD67bzobT1MfvNnbdPid5Idwk1Pet3eZJr6zscuAa7zQDLIYl1kYKw5DTOtubkzGMQosdiRe+DId70sivf9UcbglYXHu35Lm9HLajWCtqRMhpL10DhOhoRgZfp182deB0g3Aq5tQ+txQZ5X1nb3IyVkA/eCtMX1JSazy3YHMnyxSa37vc8PO9A0x4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1RJaStxR2FLdDE0QnBzTlI0QjlMM3d0WldzdGVxMTNaQUJkS0x5QllHYXpo?=
 =?utf-8?B?dEtjbllOeGliNWJLTVN5Z2ZCSVpOcVFNbkhUTk00S000OVVmZTBaYkRWUWtV?=
 =?utf-8?B?OVRRcFFWMjlML2c0MnRnN01YdUszeWIzQnVYMEFPZllpWHJkLzVvUHlEMnda?=
 =?utf-8?B?WEhRdW96elM1VW1JakJMSVZUVFVPRVNuVUcrZjJ2VjFZMWZkakxzN2ZrOElL?=
 =?utf-8?B?cStQVmV6VzdHc2VYb0dXTklIKytRWlVZcDZkbHNrRUtoNEswT0VQTEs4UTBT?=
 =?utf-8?B?RzFMT0FqNm5HaE80V3ZaWG15ZWhOQldVM0h6QzJqeVVDSmQzb3ltQjd1amR0?=
 =?utf-8?B?NktQTDJVbHkyQWNJbHVhTmdVazAwTUJuMXhDU3FzZEo4dGJGb1JBZzByVUpY?=
 =?utf-8?B?eS9YVlpTdnVHdzcvbUF6ZEU1THN3bzBnbTdnQ1EwTGhkdS96QnhKcVY1SFlm?=
 =?utf-8?B?YlpJd0ppUUlkTytEeitScU9CWjNJN1FtK1RpR2pVYVVZYXJMNUIvOGtTUVJG?=
 =?utf-8?B?SzdYTTk0REp1MThZS2Q0ZUVPcVE4d0YyN1NabGxxZjBtQWtQMXpkZXlQbUhT?=
 =?utf-8?B?VGRBckhNTnRsaDVkUForajFxZEh0cGkxdXkxUU9oSWFJcnE1bUg0cWdudHV0?=
 =?utf-8?B?TmVjcFgzazAyeW9KYWdSOTg2S0g2YncvMUFyb0I1cDdVSFZ5c1laR1lvVmlD?=
 =?utf-8?B?UmVnRURDY1BlN3RhVDFQL252YU1DbDZscVE1SXgxRVE4ZVE4QzlLdjlJQUFE?=
 =?utf-8?B?ZGt3M2tGYUVidmVPMVVjd1ZZZWd6aHNsb3RPa3FjT2gvQVl5aXI4SVZySldr?=
 =?utf-8?B?MHlpL3dERVdUVkRDanoyRndNVlU0Ym9XUUQ4VE52K1ZPdERwWWYvWmg2Kzc0?=
 =?utf-8?B?MFBOUEpVV3ZVdFl1anZIM0tkMjBIdWhRK3ozNWhiZkpaRWJVaHdOMjhZVE11?=
 =?utf-8?B?VUNLSVRHaHJ0VHJPb2F0TXNVTGFNMUx4a2lhY1V0VHZGL1Z0YjdoaTA0U2hi?=
 =?utf-8?B?cTZsenpHeEQ4Y0pjdWZpWlBkU0hSME85OUxLb2JFVTMvelRnKytFOFBNTTdr?=
 =?utf-8?B?V0x4S3piQTFTNUlFZ1lIZXhtdGZXZHp4RlpRaFpCOEVZYy9CM04rbUtZelRM?=
 =?utf-8?B?R21XZWJGNnNsVmxMc0prRnNKenRQeG10YW5UZ1pRenFCczVyNEUxMXM5cDhI?=
 =?utf-8?B?bWpCS1puaGc1TXVSZlNZUHRiclNZRC9JN3dxTkFVQ09uQzc5MUZyZUhSMk9x?=
 =?utf-8?B?cW1zWXcwWlBvUytwQjRvMDhtZEJBNzlNdFNMejhoaHEwZ1JxZE1sbXdOb2ds?=
 =?utf-8?B?RFJpVTR1NzZob094WDdOZXRXSkhRYnRLQ1ZjaHBXS0tSY2NJRVpKSXJOM0w0?=
 =?utf-8?B?eVliUUcyTXlxTkhIVGxXUzdrZXQ3d2h3SmFSOXN0bW92OHBNVnZnSWRoL3JY?=
 =?utf-8?B?Z1BKMEtJdlA5VVRMODVkOVRacDl0MkhjWFNVUmpiZnJmaW0wbFpLVStQRG5I?=
 =?utf-8?B?dlQrSWRPSXNEbW1NSkNYYVlMa0I5b1lwVFcwaHVWeno3dW53WjJ6QUt4dGMw?=
 =?utf-8?B?Q0dvWkZSNmF6UU1MMURyZU5CeU9TTHloR1B1T3d0dW9DYVdYZXc4MzJuZ0hW?=
 =?utf-8?B?cmQyaHk3VlZycFhrMTJkeVpmYUVYRUFvYXBTeHlhS1NFdWVOZlFYc2pYMkc1?=
 =?utf-8?B?WnlxcTU0aGJVU2NCbkhRa2F0by9vOXlIbnJPbkJqc08zSVhDaUxjc2haU0RG?=
 =?utf-8?B?dTdISCt3K0plZWhPNGVVYUltSys3dGhlU01JWVlBWWozR240N2pleUlyWC9j?=
 =?utf-8?B?SE1pbDlrOXp6aHdCZjRHNWN6ZldFUC83ZldyZGlWN2ZtL2hFZ2h1S2ZMSjVP?=
 =?utf-8?B?N2FvNnYvV3I3bG1ESkdhSGY3M0grTXhvV2hHWjBvNnVVbXdGWXRhckZKWmdk?=
 =?utf-8?B?a3JQSXl6TEFKRVkwNC9uNWtqNVh5aTVlOWxvVkJlV2FQQ2R4aWlVU0FIQUs3?=
 =?utf-8?B?aEk2Zk9uSk15cG5CL3Bxd2tORTV4bTY2TnJ4KzJDK2ViTkNmbGNGVitBNzcv?=
 =?utf-8?B?RmVHOXFiVzFoSnZDNjhFVHN4bUJkcll6bmxKRDR0SnlGNklUeTdZdkJJU3NO?=
 =?utf-8?Q?PZKSERKf+WF2u9FFgKQTPsPCJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33cab56b-7557-476f-5099-08dc4e254e8c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 06:15:32.1982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/N8ebjmDR/ulB8rQylA+NtqKZzT6QyQWrNPxOJtmDDHSWfZOdQ8JW21j5GKtYbB+X/IxQWHvijmYH07zk5Qdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4402

Jason,


On 3/19/2024 11:26 PM, Jason Gunthorpe wrote:
> On Mon, Mar 11, 2024 at 04:41:51PM +0530, Vasant Hegde wrote:
> 
>>>> +	/* Setup GCR3 table */
>>>> +	ret = amd_iommu_set_gcr3(dev_data, pasid,
>>>> +				 iommu_virt_to_phys(domain->mm->pgd));
>>>> +	if (ret) {
>>>> +		kfree(pdom_dev_data);
>>>> +		goto out_unlock;
>>>
>>> BTW, I'm not confident in any of the error unwinds around command
>>> execution failure. The sync failed, it doesn't mean the HW didn't
>>> already load the new CD table entry. The driver is basically totally
>>> wrecked at this point as it can't assume the new entry hasn't been
>>> read and it can't assume the old entry is flushed out. :|
>>
>> Yep. This is tricky path.
>>
>> But for now this particular one just adding PASID to GCR3 table. So if we enter
>> error path means we didn't add PASID to gcr3 table. So it should work fine.
> 
> Not quite. The HW could have cached the new GCR3 table entry even
> though the invalidation failed.
> 
> So on the failure path you have to assume the HW is still using the
> GCR3 which the failure path is busy freeing..
> 
> There is no way to make this work right. Either kill the kernel on
> invalidate failures (ie try forever) or assume that the HW will
> eventually become consistent and continue forward..

Currently we ignore invalidation return value. So we go to failure path only if
we fail to add PASID to GCR3 table.

-Vasant

