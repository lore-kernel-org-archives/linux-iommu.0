Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058511B599
	for <iommu@lists.linux.dev>; Mon, 11 Mar 2024 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710154828; cv=fail; b=AsP+mH7XXB4wnwRJ/QRrN7jWXGC2BnKclSTAEjeeUyatPVxtRUFex9RqH+OXRXopwJWYRq1NN5u7ISFwDkvGI/Laz20dTpYEjNxCwhYmbRDpAAH5HyETgVhcOoIEOrxLg83pJH4pR8Z4xuVN0aMIzFu1CraTqHmFFWDx1rjHbZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710154828; c=relaxed/simple;
	bh=nJIy3qK1wmMGDUJ/YG2264oPqM3uLTI3N8tKreXsGCU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F8KeCaJ3fewTpNc3Y0umgtLI3yfY6ffoCVs7gz909E3F4P21/ZWpzjzT7g1g7eqSa+UMSbN8dEomeQJGdsDt5yU/YBKVvrzn0PekqiBUCAtLrGdjiq4nfg+O7Brd677dQ7+hQPtrk1HreVtdlLTbzAZiIVyylXGNwE0LObR9iHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KaxV7h/r; arc=fail smtp.client-ip=40.107.96.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KaxV7h/r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3GLV61Idy/6Qg9lTlpHHKf0hFPv6tfd/AzZDRI66g88E/XflBKpTgEwmkmtx1XWBDRyHgaTBGCEARqal41zZDKpdnrenpK9fRFpZLLlWawMG03XqGPrJbJ4kE+WBjjDMRGX1EnmqQRZz4xzCZQLlO8DbUXo/8cyaYDPOrnB45K0WcFBRtvi/4L0FpHfvR5pjFEGTF26gPzqvuO1b3X1sewGd3ZqUlzv9YR1SfBTUnR4vtCMPsWtDCFD+6lDtVSUhJm6HKq0uICFyMR/0z6iTYRx3MLOs9AOTxkDQ5HEwvyr6I3NbwgFuzBFpjx/H1HPxJWuHS2pyxcQq2UQLDmIFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hn82AHz1T9a+01yeZDvMwfUvlq21yGzQJOg5GibxBWU=;
 b=nZjg1ML1s5sY2tWxFBpIRYXdO4YWgkrYyFQVTbJZwvgNny1fXt3MRNkbczyT1NOn2hAr+WzHjVsaKlV4iCwf4HbmcWK1lM6fTc6PYdYGW4wQx3GNrtIEmBGeiNDAmL/iEapyvfQZivwtJORyak18n2eb/q7N16mn4HX39XedanOhAm4aw3j1SdcNWO2/IaSC7AY24+p04Wu66EiRxCF9evs2nc0KRZyPX3Q+wf8UIp/uIyQ5o5gkh0KFh1XpyAiPooAUdu8gCCbrmhBdcBFaYz9Vd0JxSyY+tDjgKCCRGZPYCDDrJbfw3KpHYi1FSFdHPR30aSng+EEQfXjUAuVeFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hn82AHz1T9a+01yeZDvMwfUvlq21yGzQJOg5GibxBWU=;
 b=KaxV7h/rva4zMhc78rZjTeOXywsfPhm9oYwv/i/o1QJLwmfGCR+j/ER9SdPYkRIi4f+GbZKOyRM0czVvbPAAgLsrYnAF1uOw0yWhLERvU4yY/U7IuJzvwj6JFP8CIme9tW9d3rCNUa/QVdfMdkYqquh0xe9dDpjvwz9fy+1wJkY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MW4PR12MB6826.namprd12.prod.outlook.com (2603:10b6:303:20c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.35; Mon, 11 Mar 2024 11:00:23 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::d709:cb7d:2612:bb27]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::d709:cb7d:2612:bb27%5]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 11:00:22 +0000
Message-ID: <4007d5e6-c76d-d869-9e0d-5a25251db98f@amd.com>
Date: Mon, 11 Mar 2024 16:30:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v6 11/15] iommu/amd: Add IO page fault notifier handler
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20240209112930.63663-1-vasant.hegde@amd.com>
 <20240209112930.63663-12-vasant.hegde@amd.com>
 <20240305004001.GF9225@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240305004001.GF9225@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0022.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::33) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|MW4PR12MB6826:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d5adf94-9593-44f9-8832-08dc41ba72c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SQWIBmiVVzOvaEkIXBzNKfV2Fqb4j0QM4sZUkD1yyb2KD9MLhZ5/CmfWReO38v2QETSXoexDanH7b5dxTbZSZG8MT5aVG0wQ1S3ImAnkkTc+LUHCiGvcGHSRh3BeQDTRAfXfGsO1p1ktRgGIFVjiG9eaB3p2pt616v6uQtzH3hVlOBX3pwjC5oawkd3b9xKNNTc1AgPWN7O0w/K47boBSsFj/Wu40eZ92sp4IvTvZ+Y+0zyPvpxL3vZfdUlJ8COnpixSmLpULg/1VwPRKmz5vaFcgfF7BWvf2hvhLfwUgt0/cH/3gNBrTF2t55migm9GRvCw69FPoUi/NDbusoY0UGUyVpCGisb/vZ5XYYO5ArDJBB4LyGAgLoYAAh11zD+Vef/Pv9HlpF9a0rBL2IMEolBAlYpiGhc5Bi7miKNhv5DxSBsO0y+9D7lFYf9MBcCJv8Z470I+IsUjUMYnN4VWUWZdTmu/K7WUAKAvYfBpLGV1CKmKSN7LSpBEnVBygYzchk8B7kDNuD1iwjxlJ6Yj0EPmsba2EeujKO8rMRKDYv7ti2RpA+htBmXgq9WuNiPGCzg+2tnSWfFXeQncUGnELQfFJcj+8agsfPXu0Hvr5VyDF1ilXwLkWu/gZbLoU+hxKS6Q7PDYFolMQC1G46/KRO9ppU4rUnLB8f7YOX4KPAc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVplczVwclNGZjgvbzZOeno1SmdlaGxZS1k0L0o1UmRFQmgrS2RxbFA1RTR6?=
 =?utf-8?B?alM3bnliYVcvbFR3VkVOWWowd1R3TGF6aXV4YjhQam0yUllLRDNkYnNpeEhT?=
 =?utf-8?B?WkFMODN2VEdqdlpWQStUSlB2eUw5MnAwZWxQU1dvRXppeCs1WWIvYzM5cGVa?=
 =?utf-8?B?cjFQeFlWT2dQdzVlYzFZM3VTOUUzRStrMytyYnJscGVnZmJPNEM2bTlYdVNo?=
 =?utf-8?B?MVQ4L083a05ZU1drQVhSdHVWK2NKN0x6Z0pLR3RtbjRESnRmWlMxNWlxcU4v?=
 =?utf-8?B?REptNzFlZ1hta3JqMUNFZ2RheDZMdGZuM0FFRlRQVnQ0VlpTUVEzRUdPOGdW?=
 =?utf-8?B?aWYrS3YrK2lEbGk2SE1yQnJaTzZ4SW96RzdVVDdtSDBId0NVeG1uYTdJQUxV?=
 =?utf-8?B?b3ZaZFJKamNyVUhCTVVjTHN1R0dMYU1jZm1NUks3NnZFbmtSODQyTVpvYis4?=
 =?utf-8?B?U0psM2hacTFvVDZzMXk1RlNTOW00ZHpHNWJMdFBhQVEvR0x4WkxRTHgzR2E4?=
 =?utf-8?B?YXkyZmhTWkVOWWFKTGpjS0VmbmdDMjBpb3B6MFhxaTZXa2NZK1dBeUZjNjVY?=
 =?utf-8?B?c3Q4RyszV3VpaVB2cEJiejB4UnBYZXBsZXkyaUcvRmtXK0x2OExEZzQvT3Zj?=
 =?utf-8?B?dFhTcllVVnZHaXJITEp6cTF5TFRWTkxydS9oZEwzeG9RRXA2RUZ6UjhOb1FG?=
 =?utf-8?B?T1NrZkVpTWNqOUdneUMwMUlEbzMvZTI3T0JBcWZCN05NcDZPN3FFUWxxK1dC?=
 =?utf-8?B?OXZWSC93NUdYTERrbTU4Zm1GVzVySTN1OTNjTStLWmJuQW82clpsNWFCZm1t?=
 =?utf-8?B?cnE1R1dZRTRuY2lSemlZM1RqNnR6dlRRSzdSdlJvcmtSWkVnKzl2S0o1aitX?=
 =?utf-8?B?TU9rZnJGd2UxcXMvWXI4eVNqZHpmcW9HZHp5cG1JYmpqN1cxMjBScnkxNnRt?=
 =?utf-8?B?ZFl3N2JZNHpXaEZqeURRQU1rTnZneWs3azBoeEdFTG9iRjNGUmJjWmlzMVdw?=
 =?utf-8?B?eFVCRlVlNnZyaEtRNkovazFwYzBJc2VNRm9FYlYzcmhFYWMrOTg4aGlCTGZ4?=
 =?utf-8?B?d0pjQ3hmTTVOOWcybGk0M0haRWxKTXkxWTFYUU1XaDVRQW9CZ0l0TUZDNG5Y?=
 =?utf-8?B?TkhwdWZmMTR5Q0M5d1NmQks0VjNoZWZJcCtTYTBHWEpIMWtlR21jM1FnMTVy?=
 =?utf-8?B?R3IvVGs3K0h6alZIYTBxY1hxcHphZW1EZWJ6T244cVB5UXdraWRiMHZ1WGtD?=
 =?utf-8?B?ZlN1UVRGeVl6cTkwMzNUNWp3ZkNVbk1wNmxUNTEwOXZSOG5PTVdSTUhkeW9P?=
 =?utf-8?B?TDVZZ2xTODNYNmpzMWE5Tlg0OEZFRHM3dFArSVhmK0NwZGtIaGQ1QmhoT0ox?=
 =?utf-8?B?U3RSUFpBVS9jSkxDbm44andNVVpQR3BQRng4SkFxNXY4MlRVRHB2QTNBZHYz?=
 =?utf-8?B?akVMa2Juc0llK3hmN1F4K0NkcjJpLzBvcWc2WjdqaTdUYWc4MzVnOVFuMTY4?=
 =?utf-8?B?cXlDM3NVTE1zeU9EYUJwWlpxUlpSUk8vVkRQU2dESUp4OFFkeEFZVGZIYW4z?=
 =?utf-8?B?NndwNVBRNVJrWGpycDB6NmYzaTRDQTdXRkxYZnpWeDhLTzNBWTVGMW0zVUp0?=
 =?utf-8?B?bEZGQzMzc3g3UHJJNkVwVmxyT0p4MUdvOG9YQnhSUlNQSSt4VkFrcXVIZ0to?=
 =?utf-8?B?bW5zSFBWMklRcE0vSzZ3aUFSRitUYnZZNWg4cTluZFBFMmZBazIwTjVJcDFF?=
 =?utf-8?B?c2NJejRkRlVYamx2UWRBeCtFOHRaVktkYXcrdXBHSTFjNkhPVC9wMUJEYWY0?=
 =?utf-8?B?Ty9jclZRd2h5N2NrNW1VdGljcE9DMzZ3bFNyRXpkQ1o5d0hnQW9sV3JNcDlZ?=
 =?utf-8?B?L01tZ00vWnpLa0FEQ0srRnlpT2swbkwxamVTY1VnaWlNd0pOazlrZmVzeU1U?=
 =?utf-8?B?Z0lnM1pBTWdYQ28vWk1WSENXeGpseFltb21Uek5Vb2czRXFVRkZvdGJ3VVpp?=
 =?utf-8?B?MENGTWR1ay9ORll1QkNITWkzVjBxSittN2hxVjZDWGlDQk93VVdEcnU0aG9W?=
 =?utf-8?B?WVpLdGpScUh5bHVGUUkrb0YyTklNdjlOZjhvemYzUnZhY3lWREhiY1h5WkxW?=
 =?utf-8?Q?SpqwB2rdMX0a5rfs7qEEc/dJN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d5adf94-9593-44f9-8832-08dc41ba72c9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 11:00:22.8684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2WbLrkwRfDj3XtpshWqyb3zPGqKdrOAEx7VxplW0f7G2pradsf9+ZS2VlFdzqfwbXoNGBfBtNkLDrQimBftlzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6826

Jason,


On 3/5/2024 6:10 AM, Jason Gunthorpe wrote:
> On Fri, Feb 09, 2024 at 11:29:26AM +0000, Vasant Hegde wrote:
> 
>> +static bool ppr_is_valid(struct amd_iommu *iommu, u64 *raw)
>> +{
>> +	struct device *dev = iommu->iommu.dev;
>> +	u16 devid = PPR_DEVID(raw[0]);
>> +
>> +	if (!(PPR_FLAGS(raw[0]) & PPR_FLAG_GN)) {
>> +		dev_dbg(dev, "PPR logged [Request ignored due to GN=0 (device=%04x:%02x:%02x.%x "
>> +			"pasid=0x%05llx address=0x%llx flags=0x%04llx tag=0x%03llx]\n",
>> +			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
>> +			PPR_PASID(raw[0]), raw[1], PPR_FLAGS(raw[0]), PPR_TAG(raw[0]));
>> +		return false;
> 
> Someday this will not be an error..

Ok.

> 
>> +static void iommu_call_iopf_notifier(struct amd_iommu *iommu, u64 *raw)
>> +{
>> +	struct iommu_dev_data *dev_data;
>> +	struct iopf_fault event;
>> +	struct pci_dev *pdev;
>> +	u16 devid = PPR_DEVID(raw[0]);
>> +
>> +	if (PPR_REQ_TYPE(raw[0]) != PPR_REQ_FAULT) {
>> +		pr_info_ratelimited("Unknown PPR request received\n");
>> +		return;
>> +	}
>> +
>> +	pdev = pci_get_domain_bus_and_slot(iommu->pci_seg->id,
>> +					   PCI_BUS_NUM(devid), devid & 0xff);
>> +	if (!pdev)
>> +		return;
>> +
>> +	if (!ppr_is_valid(iommu, raw))
>> +		goto out;
>> +
>> +	memset(&event, 0, sizeof(struct iopf_fault));
>> +
>> +	event.fault.type = IOMMU_FAULT_PAGE_REQ;
>> +	event.fault.prm.perm = ppr_flag_to_fault_perm(PPR_FLAGS(raw[0]));
>> +	event.fault.prm.addr = (u64)(raw[1] & PAGE_MASK);
>> +	event.fault.prm.pasid = PPR_PASID(raw[0]);
>> +	event.fault.prm.grpid = PPR_TAG(raw[0]) & 0x1FF;
>> +
>> +	/*
>> +	 * PASID zero is used for requests from the I/O device without
>> +	 * a PASID
>> +	 */
>> +	dev_data = dev_iommu_priv_get(&pdev->dev);
>> +	if (event.fault.prm.pasid == 0 ||
>> +	    event.fault.prm.pasid >= dev_data->max_pasids) {
>> +		pr_info_ratelimited("Invalid PASID : 0x%x, device : 0x%x\n",
>> +				    event.fault.prm.pasid, pdev->dev.id);
>> +		goto out;
>> +	}
> 
> Why even do this check? The core code is perfectly fine to take in a
> big pasid value, it will not match anything in the xarray and just be
> completed with error anyhow.

We just wanted to make sure device/IOMMU can handle PASID or not before passing
it to iommu_report_device_fault().



> 
> Looks fine otherwise
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks
-Vasant
