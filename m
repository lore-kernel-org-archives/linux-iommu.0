Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B02D2F3
	for <iommu@lists.linux.dev>; Fri, 15 Sep 2023 08:15:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHIkzjj4LSfAzkq7vGPXoVtOPacrfVZvBlAClVG9ORrsjuv8lr2CzVHBGACLnchZ//VOsRiAaBVBZ0mg8m92LfI3p/qky9EhZt3wofJRi1zKOcZ7UC6aV4Dsw4JTyCutJOpROamYdmGENWb5kTlHT0U1XR+JRnfF2xAQ6mvf23+fO1q4vYsewJ+w9qzHfh9sgmSF1wUGy4Pci21lUd2h1hQZrc6yNho6RoaTOyRSpSrkPT1yEHqdgF607mUtRRSEugLCtGCGrPAwORaSX29GXYTft92+DZ7lOxA8DQuIEVFO6oWL+B31uBDsWMJGkR6zOQkVPndDNJr5NfWo4bK/EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0lQYtzTkOZv5CLJbNuK+/zTlBeavqTuEocTsj5Jzx8=;
 b=dosvwvIOUuSkWQe/gNxJG7CYCAkC4xI89V8Tq6cfsRxFp4ADQ3BvzLJG6dRyhHJRfQm++i5qJti8bGvDx62ja1vqcoOPmoZSDsRVMhZo2Qg9PlODn88Vu+VUeDTFbN5g6MBzInXAfhjphHcgEYV2UzVObHzEbAbxdwXcdOTop1B2zMROXJLaqOzG53Tw03UhSDn899kUCYy+0TVYaFyMiNnS5JJcqsNGk3Q/3dbu8UXqDZQEIhU+i1NVzRE3Y5RH/Nxegy/BUQZHcsFjWQt41bGF7oxxEwqv0dyH4qRLaRc9fG/Qaqw+jKQIuEE2aqiUuFLywOkQK59CCWJ7o/WjSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0lQYtzTkOZv5CLJbNuK+/zTlBeavqTuEocTsj5Jzx8=;
 b=XeAYGIp/yiUThws0Q648mNLueCdBaygtw7JV12cdeRPLWHPJ81Ivt3SmKEv1g/xB32JrJseYCbm358a/uLW0Pb193rd3ayh2N8DIxxge4q90pGTpxMQft7u+PMVerJYLu4leGvjBO701h3CF0MCKIzAz4+ZPXoEDu6+H0cYQ8+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SA1PR12MB5657.namprd12.prod.outlook.com (2603:10b6:806:234::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Fri, 15 Sep
 2023 08:15:15 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::cb74:f20e:dd21:d763]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::cb74:f20e:dd21:d763%6]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 08:15:15 +0000
Message-ID: <e913c24e-91fe-8961-5054-cef3fc589cd1@amd.com>
Date: Fri, 15 Sep 2023 13:45:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 10/11] iommu/amd: Add IO page fault notifier handler
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>, Baolu Lu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230911121046.1025732-1-vasant.hegde@amd.com>
 <20230911121046.1025732-11-vasant.hegde@amd.com> <ZQCyHS9VFXZyAK4P@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZQCyHS9VFXZyAK4P@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0184.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::13) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SA1PR12MB5657:EE_
X-MS-Office365-Filtering-Correlation-Id: 24f101c7-aa15-4cca-b71e-08dbb5c3e3e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	17ktsLko5JM19p35p+9q2brMzNuTmA0T6bbo67jLKxZ0LQd5z/ALFI7HtbpW9UgQj2L35BiS9G9BtYbi5I2yq3dYocCW20txgbZmIHbSA32u89OSSONKvsfhbCLr1ilaCIpb/c1jAdLX+NUei5r2GfFF8mXC0gTrPYaP36K+EVSJZ0fdtqsB9tMPsoBsFgx/lCJntrgpZy2FZQMOwbl5994uWsUBzWKV6ytFNpXc05u0kAifYydalpxnRbwaTBTt43Xx24WGljfZ48npOSr6cBSgEcHZTCallm90kcZa8iLIHM7LMVZ+Vh4FuwYVlUGZj5XHM12VmLzMl9D3QUw2YFwX9MzWjmTEAb3CXitDLTIwueUx8kJrCfDhxOovL7E/ZPU4fyO19kEA6/+MkJMvkZIlHeiGPXb+W2H1axXWZ2CA8++oY+aRcbHp5Efh6ak+xGW/BYyLwhUtS3iq+BFQodxM9esUBT4QFheJKlAz7WpE5LAgtJSbsYPwwLuSAXQ93Gr+naFxQqKl7SRzVE8HQrqxkIvRCy7KrMRKRrs+patEXo2pB+Gt6AzbldLTJEB2RK1qIa1LoYgND0L+UiIOapE/G111NmeCytptdnox9/VuDgYUt1W6hGLXvbg/8c4lb1YdkRvgeBCM07R7iyrFMg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199024)(1800799009)(186009)(26005)(66476007)(66946007)(316002)(41300700001)(66556008)(110136005)(44832011)(4326008)(31686004)(478600001)(5660300002)(2906002)(8676002)(8936002)(6666004)(6512007)(6506007)(6486002)(53546011)(36756003)(2616005)(86362001)(83380400001)(38100700002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGRHak5WYW1zK0htdnYwbmRhWWNmaXJsRWhKU0l2TnBFcnpubUR0T256QVYr?=
 =?utf-8?B?dnBjaS9NSityelhtRm1HRUFEWkpKQWdxNWZtbXhlL1RxdzZmemZPWXdZTk1o?=
 =?utf-8?B?UFZwMGI0SnVwZytNL0J3SktySzUwd3hIb2NlZDJ0UzFPOW9ZbFY1enpRNUFU?=
 =?utf-8?B?NEtmL3JtTThucndTeWlhTE8vRTFhekRlY2JmcW5CSDJ0S1h6K0pneDJJaG1k?=
 =?utf-8?B?OTlpa1ZtUXlrQnprK1ZMcjZBaFZkcGp0SVhDVFRBWEdISEV3RWN4eEtGZ1Bp?=
 =?utf-8?B?aFFXM05oYklXeFFlMUppa0dGS1E4YXRUR3pFQ2pGbms0eW5rTDl0cU5JWFVL?=
 =?utf-8?B?WVd2cWxUV21LRHY1Smw0ZkU5OEtFNkI4akVqdWtYcXFsYnV0SVpkM0pYZkU4?=
 =?utf-8?B?dWZFN2JMcHVFT29Ic1h5djFma2MxVEpzWk44RUpmaW5TYWE0YlJnT0pMQUVS?=
 =?utf-8?B?aWJjQnBoM3ZWUlM2WkJVQ1NVWGRvM0N1Ky9FVDVvWFpZTzlBUDFrSEUxR0Yz?=
 =?utf-8?B?b0NtTmtGa0N6RUxwS2NwZzJUSjRRNWZoRjl3OWVNajR3WXJHdnJ1UWNiZG51?=
 =?utf-8?B?ajhHWFdVY21FTldLKzNuSVB6UlRKeGZIWENXTS82YVNaUy9XVHNSb3dOUjdW?=
 =?utf-8?B?dGhZclJFUXpueTV6Q25CeVI3clJaYllMQjc4YmN2V2FBaDZTdVEwdUZQSitH?=
 =?utf-8?B?bldNRklITzdRM0FwSFdRdU5QZTI4cWxYNGpaWDlHWGpYWm9nTWpkWXpGWU14?=
 =?utf-8?B?TmVmWEJTeFM0eEhRZEUrVGNMNk54VTlPWER1cXFEczNXVk5wbHo2RWhmMzA0?=
 =?utf-8?B?L2pRNnNGZ3NyeGtsb0lnenZJeEV3N1E1RHQyckJXanBqalZsTURZUmtBQUVQ?=
 =?utf-8?B?TkF6V1Q5dXVZRzZ2UzRnSGZCTndBa1phWTFNNGhzQnllRERSczZvVSs4YzVh?=
 =?utf-8?B?cUVOd3ZQdEFHVThPZld5Tk9iTVFJMHR2NklPay8vRDZjMUkva0V2Q0UvRlcv?=
 =?utf-8?B?SVVkQklvL2ozMTVxbXQzKzNpSmlNd2poTW9RREs1dFFvSVIrSjNDSDkvOGo0?=
 =?utf-8?B?ZWtibURYanJEb0t6YnZyNEx3ajdaejdmQlVBcGgyRVo3NTZpVkFWcHZVaGha?=
 =?utf-8?B?U1drdXlqdXlpVDNkZHRuRU5FRnRLYUJYWkVJYjhZV2tVYk9ubFdRK05CL1pN?=
 =?utf-8?B?cHcxQVd5Z3BsTm90NWNoNlU1dHN4RlZaOTJmQTV1NUJUMzY0NmNxQ20yY0dm?=
 =?utf-8?B?YjRma2piNEJBQWtHSlk1V1RPYzE4OUkzdm9Tb25lWit1dFg3MzJBMlQ5WEYz?=
 =?utf-8?B?b3FXSmpjYTNxcU5BV2dKVTBKVUtBYTBtWkxURVZKZmhjU296bW5YYklnZ3lX?=
 =?utf-8?B?Nnp1ZVFsb3hwRk45bW5MZGlnR2JRZEdMYnhNQnhRSkg4QkptRHV1WERrNnVS?=
 =?utf-8?B?YUZoOVo4eG9sY0NqTzk3S3UyUjhBRG8ya2FjM2l6ZWNpM3ZOM1RiUnVMQWZ6?=
 =?utf-8?B?U0V1bjVIdzlVWSs0UkhiMlNHVVhsaWd0dXgvVzVtekJYcXdhSWU0elduR3VI?=
 =?utf-8?B?YkJVVHI4NSsyaUNtRkkrTERHdC8wblVMeERQUTM2UXFXdEdKNitRbTUxMHpE?=
 =?utf-8?B?Y3hpbE9tZXVNOG5iWG9HVU9wYm1XSGZqSEQydEpDNnI2UURsZ0FZd3dDRmxO?=
 =?utf-8?B?TEh3V2RhUTRLbGRITTdla1FtSTF3cTUyQ1F1TVZFOVVlQjhCM1NNcG94azQ0?=
 =?utf-8?B?T2YrTUVMOFk5NDdNa2U3UWhzaTVXM1MwSzJNc0hOSUlIR3pTazJieW5OZjNY?=
 =?utf-8?B?WE1vbExjR041c2JCVEFMWlZUSXVnYkpIaE1BblVCYVo4OUVPMG1CM3E2RHVi?=
 =?utf-8?B?aXNMdS9GWmtIUDdrMEFZZlQ4ZXQweTRqdTdOSHBoekl4UlM4Wm9YdDNpcUhm?=
 =?utf-8?B?L0N1TnByV0l4RTY1V0tieG1FaHhBc0doN1hHVlB0aHo4TTR0eHMraVY0cUEw?=
 =?utf-8?B?MENXUWs2eUd5bVZGQ3hZSTY2aVhtcTBmOTFGcXdYMXFUTWRyZ056elZmWHor?=
 =?utf-8?B?VVp4eWNDVnhFcEZIK2FOMm9KK0hXWWdobUZIU2xpYmhxSG9OS2FYS1RNcVU2?=
 =?utf-8?Q?5312YPlaDnC1DBozi7cvRCW4u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f101c7-aa15-4cca-b71e-08dbb5c3e3e9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 08:15:15.3752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aSHN6bJNQpBlIGum/Tq/WUt1MSf5MQTFSP6KGuN0iukk2Sy/LjYzmvJQXK5M1jMX4YZ+Kzw6go23G28j06hTnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5657

Jason,


On 9/13/2023 12:16 AM, Jason Gunthorpe wrote:
> On Mon, Sep 11, 2023 at 12:10:45PM +0000, Vasant Hegde wrote:
> 
>> @@ -285,7 +286,7 @@ static struct iommu_dev_data *find_dev_data(struct amd_iommu *iommu, u16 devid)
>>  {
>>  	struct iommu_dev_data *dev_data;
>>  
>> -	dev_data = search_dev_data(iommu, devid);
>> +	dev_data = amd_iommu_search_dev_data(iommu, devid);
> 
>> +static bool ppr_is_valid(struct amd_iommu *iommu, u64 *raw)
>> +{
>> +	struct device *dev = iommu->iommu.dev;
>> +	u16 devid = PPR_DEVID(raw[0]);
>> +
>> +	if (!(PPR_FLAGS(raw[0]) & PPR_FLAG_GN)) {
>> +		dev_warn(dev, "PPR logged [Request ignored due to GN=0 (device=%04x:%02x:%02x.%x "
>> +			 "pasid=0x%05llx address=0x%llx flags=0x%04llx tag=0x%03llx]\n",
>> +			 iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
>> +			 PPR_PASID(raw[0]), raw[1], PPR_FLAGS(raw[0]), PPR_TAG(raw[0]));
>> +		return false;
>> +	}
>> +
>> +	if (PPR_FLAGS(raw[0]) & PPR_FLAG_RVSD) {
>> +		dev_warn(dev, "PPR logged [Invalid request format (device=%04x:%02x:%02x.%x "
>> +			 "pasid=0x%05llx address=0x%llx flags=0x%04llx tag=0x%03llx]\n",
>> +			 iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
>> +			 PPR_PASID(raw[0]), raw[1], PPR_FLAGS(raw[0]), PPR_TAG(raw[0]));
>> +		return false;
>> +	}
> 
> Please be careful that no guest can trigger these warnings..

sure.

> 
>> +
>> +	return true;
>> +}
>> +
>> +static void iommu_call_iopf_notifier(struct amd_iommu *iommu, u64 *raw)
>> +{
>> +	struct iopf_fault event;
>> +	struct pci_dev *pdev;
>> +	int ret = -EINVAL;
>> +	u16 devid = PPR_DEVID(raw[0]);
>> +
>> +	if (PPR_REQ_TYPE(raw[0]) != PPR_REQ_FAULT) {
>> +		pr_err_ratelimited("Unknown PPR request received\n");
>> +		return;
>> +	}
>> +
>> +	if (!ppr_is_valid(iommu, raw))
>> +		goto out;
>> +
>> +	pdev = pci_get_domain_bus_and_slot(iommu->pci_seg->id, PCI_BUS_NUM(devid),
>> +					   devid & 0xff);
>> +	if (!pdev)
>> +		goto out;
> 
> Lu, here is another case where the core PRI code could make use of a
> core helper for a getting from the RID to the iommu world.
> 
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
>> +	if (event.fault.prm.pasid == 0 ||
>> +	    event.fault.prm.pasid >= pdev->dev.iommu->max_pasids) {
>> +		pr_info_ratelimited("Invalid PASID : 0x%x, device : 0x%x\n",
>> +				    event.fault.prm.pasid, pdev->dev.id);
>> +		goto out;
>> +	}
>> +
>> +
>> +	event.fault.prm.flags |= IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID;
>> +	event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
>> +	if (PPR_TAG(raw[0]) & 0x200)
>> +		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
>> +
>> +	/* Submit event */
>> +	ret = iommu_report_device_fault(&pdev->dev, &event);
>> +
>> +out:
>> +	if (ret) {
>> +		/* Nobody cared, abort */
>> +		struct iommu_page_response resp = {
>> +			.pasid = PPR_PASID(raw[0]),
>> +			.grpid = PPR_TAG(raw[0]) & 0x1FF,
>> +			.code = IOMMU_PAGE_RESP_FAILURE,
>> +		};
>> +		amd_iommu_page_response(&pdev->dev, &event, &resp);
> 
> Just to call amd_iommu_complete_ppr(), this already has the pci_dev,
> we don't need amd_iommu_page_response() to get it.

Makes sense. Will fix it.

-Vasant
