Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2079.outbound.protection.outlook.com [40.107.102.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE14A132C1B
	for <iommu@lists.linux.dev>; Tue,  6 Feb 2024 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707233979; cv=fail; b=up7sDZ7RrwGlcQraix6ZwBEseLyDi2kwl5wQpy0eWbRIfGeUz7sseswMFNQHfx2WTe5TVLA4+pW84yA5MSHdIbKUoqrr0edzl5kaCqFNMt5bzfTbzU9N0/du6VlZrkb4KzbA0ElH6Apr45Um8e1wPlXtvkjzM1bbn4KAKvzKQTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707233979; c=relaxed/simple;
	bh=s8c5v3YodofqNLSU0N9E4M3OIFbdY7ho/8YHrpUU30I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=co47SdgV2rnpD4tg2mblbt2xgwwo5s47B3ihlb4cTRiky6IyCCoyQACrYrKDIw+moof49qqOM9+q3xPen/H/cU6i8DJSvVOh/fHbE3oOn4I6IoPn73KkmPCcO073TfjGttL8QSqnZj2qY0H0T4/c9NxBsuv6kmw2iJhURcEFFY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dxzUHg46; arc=fail smtp.client-ip=40.107.102.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dxzUHg46"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHUXzmokCq/pGjCyco8bdQFIRnMoM6KtB1FUr/Kixbk3le7rht4YSXwk7/OxJp4f5LzP0p/VgD50Ev0YdCfq+hrL66J5a0s8RmNS2yIdQ7Sm5fQD9++GIIZccKdFAAMUOKAqozPX18Ib4EjGZmtf5yNDfCftMyp1cFinpVK306akGSeItuJts6j0osUC/wbA80LesONDHWuRZey3CHpHofNtmhAlhFejbO7DSlFgbDWMa5PwPP7Gcmn2uTNXbv/Iknj+z2l8QHHu585bLRoRav/daGsHetnNGCHzYcjRfUhCErvRyFKDLIUIIzyKnFXZaNgyTkWyC5iJRwk0NWcIDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QkXOdFA2YE8p8y4C/yNHAQBsxCN5dfy1xXWVFZUdCAk=;
 b=MwHHf+9RyNgcdWllz0iONbvtA+YqQBmr6MpwFiN7QyTMsulUZCpDn3L0zH2IzYA5PzZ2+XnbXXZId6CFrhdZr0YXIPP9cUiiqSQKgpydxhTskZHqcKzIoQt7tF84Che8g3Wvkg4UoKw3HKRR/UqCdFBB/+cLj1Y+sbtmXfLx4Odedcu8yi+1ljaWDvirYta1ZAJ51ociRVoi+9VFDxAnDS4fs3YuA1ps6cj8ArQBmYBA9crBkS6b4hqqJ3EvGhTID18S296NwQNTo+LRN5l/4pJf40a0lY+lrbyu+mX4HdmG1XOvq4sa99cVy7ii4YYjfeCD0aTf9oYvhW9O5hW+vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkXOdFA2YE8p8y4C/yNHAQBsxCN5dfy1xXWVFZUdCAk=;
 b=dxzUHg462GVCVc6t1MwYftgxQNb2e37MRiVUP5FF3dn3PhDTYD+LTHkoF5lDUZuNNAeROCTO+oIU3B1gd3iEymeB4kHBZgrzeKD2osk5li26ytQHzF1u9fsn5ILFv+3QDe438Kzxval9QQpw9nG2HlMhZxmtmMYo5VucPvoyFEE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SA1PR12MB8094.namprd12.prod.outlook.com (2603:10b6:806:336::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Tue, 6 Feb
 2024 15:39:35 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb%2]) with mapi id 15.20.7270.012; Tue, 6 Feb 2024
 15:39:34 +0000
Message-ID: <bf2cbca4-5b26-7c20-b961-b144076e06d6@amd.com>
Date: Tue, 6 Feb 2024 21:09:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 07/14] iommu/amd: Add support for page response
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20240118073339.6978-1-vasant.hegde@amd.com>
 <20240118073339.6978-8-vasant.hegde@amd.com>
 <20240201202007.GR50608@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240201202007.GR50608@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0175.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::20) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SA1PR12MB8094:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d1a2e17-3072-4ba8-d751-08dc2729d1b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8J2RpBCjVv+UD0OXqLvtLjX49pkIXp4f3pbr1tj/YzKkbz3Kn3NK6WEBb7uXqrrYv1VLo2gVpQkmc/377EifFOvZukYn0l0kMU1QZBK4U3Xm2ZL56l+r6ihBy98lpqb6em90xjyc3OQh6Ar9p9uB3oO6tcNSsgZZf9wcxo8+SL3X/Fvd04mVL99th0XChB4jNjCbMsAr2+wDN5SkN5Zb5eLgY7fe0FPpWD313EbxA4L6r4hQtuknsY91Ylk/csDCVpCp0FW+j9JxsHU81WgUN8yTd+6S32Br9mEU6u24o2PlYfY9TD2Z1TTiYqhXBCVFMlQPLq5GfYhGwsHuD9v0JZMFtyjvu691yGSR6oGJxHYEzQTmFrKVUB5NNk7iMtR2LSLa+QY6MUt5Gg5PPWdiF70cIhJuOgtGa/oyhTyBjGzw4oZ4jBRzL0maRabr/V4hvvLD8VbScKIVincoZWCqJCyUrqS1NSV9Z01PcGEJUSXJg6v0AOSGRHiOipRQtalrMPILa9267c7h7fnlkwsuaLnOhPLS6ZoBpKDeVZODbmkzMqNVhKEntImDfJTIQ1cZOlgiqC4qCPc7S6Gyi0WJSeb3Nn4bkF5h8fhCz3b8jxSKVTrbYe8/DXLch7PMuegojOcwP5PauS4GQcCHJqQWfg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(136003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(2616005)(6512007)(53546011)(86362001)(6666004)(6506007)(83380400001)(31696002)(38100700002)(41300700001)(26005)(36756003)(6486002)(478600001)(8676002)(4326008)(8936002)(2906002)(5660300002)(31686004)(44832011)(66476007)(66556008)(66946007)(316002)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWxqb2RnT3Nabk12ZlpQSnM2OEpoSVcwQ0ZDM1NRNjg4aVMyaGUxcE1IK0l1?=
 =?utf-8?B?cFpMaTRYeWxWcmVqNlgramRNN3BCNWN5T3RnY0NxVzdJenZBQU43Y2xYSUQ5?=
 =?utf-8?B?ZUhwZnRzQmNpMU5kbG9SY1FYSm5XR2tIVFZGSDVoYWdIaktuYzhCUEM1RXIz?=
 =?utf-8?B?aldSSkFuaGVDeTAxQ2dpY0w0WENVb3Job2lHL3huOXEwaTdmK2lPakNiOXlx?=
 =?utf-8?B?UXZneWI2Zk1aa1Zsbk5ibjF1bVNnQTRmQXEycE1xRWNmRXA2dVAyTXFoSTNX?=
 =?utf-8?B?TmNUdjVrQVkyRmJPRWZGVmpTVi9pWDF6bGxPencvUEJ2VHVNcWxGYUxiVGNJ?=
 =?utf-8?B?cnpaM2xKODVqdEJkUlV3NVZkQmdmRDlzR1VPRzlnZXRQRU05d2FkYXdDN0Qw?=
 =?utf-8?B?TTVnN1gwbnJyYlNReGZDVk02SFVyU0ZieVh4Mzh1SXR2V0tUYTk3cHZYMmZB?=
 =?utf-8?B?Z1dPb1VRQ25XSzFMSEFOa2hzWnplbHNCV0l3WDcwQUpNY044cVAvVUNzT1ZG?=
 =?utf-8?B?YzMrWldxSjFxYUJHM3piOEJUOUlqa3hwUU42dmZ5ZGcxSG1tWjROdUpldE04?=
 =?utf-8?B?OFRtTHd3N0ZEM1dwNDdUMDNOdHczc0JDcmVnOEwvVC9ubTBGZnp4c2U4YlNy?=
 =?utf-8?B?OUhVTXFBMmtRRS9CR2hndGh1bHlybTE5UVkra2FzM1VNZFhqVDV1K3F0ME1M?=
 =?utf-8?B?V2ZSVEpZVVdPS2pJNzFFZzNJdWN6b1FJQTZ5enV4dVR5SnhCNWlRTVc2VzRk?=
 =?utf-8?B?WnBDNmw3OHZUWGNNT3U0bEpNUVpRdm1ONnRsNUZQWUx3dzRMSTRrNnd5MUR1?=
 =?utf-8?B?V2UzVHFEQ1E4NXNYU29zTG5DZVVlUzR5ZE81MHR2ZFd0WmdTdjB3enl2MnI3?=
 =?utf-8?B?SU5KblBGV0VjZHZmd1dyaDVJSW90eEFCZXplb1MrYTV1ZEtvaDZLZmxuQ25P?=
 =?utf-8?B?MW5pYjJadzZYK1cwTXJyd3l0QzVVazZQUGk5YUFlcjF3M2ZXRHZXMGJYODY5?=
 =?utf-8?B?YzlHTncvSGpUK2x0NU5TU2VOalY1Mkd2WHl4QXdGbTM1eWI1NzZNcjJVd1lm?=
 =?utf-8?B?V0tLbnBjSmhLZFFac1VySGg2a3VQY3E4MWtOZ0pWcGw2SjRJMW5xS2xzcVht?=
 =?utf-8?B?ampBY3NpaytWT1VxQ0VjalZaWTc5UzNOMHlyZ1pqb2FtQzJuaW5CT1kvVllj?=
 =?utf-8?B?bGZoSXU1UENPYWRrWFJINVA5TnNLSW5HV3NGcDV6dXhqN0ZOVUtaSkJha2ZU?=
 =?utf-8?B?MmJzTnlEZGN3RVJBd2pvWWJ1Q3M0bE9GUVQ3bjJ5cmg4WlJjdTZYbWswVTRV?=
 =?utf-8?B?RXFyNk91NWIvcUdnMXczeE9DRGdHMEFPeTR0azJqUGkxV2JXd2ZINzBBQ0Zn?=
 =?utf-8?B?dVc0cU5YMXErVG1JL1p1VVZsS3lwVmVMbmpUVTRQN0dMQ2JuRUR1MDRaVnlV?=
 =?utf-8?B?bEMrdWordkRldlVLbDEvOWN5UW94ZVB5ZWRuRXJUM1pHblE5SEhXREgwODRC?=
 =?utf-8?B?dUVBMVN4WnFIVXlIc3AxOTAvM3hzK3RVcmRlbjZWV1FPMUVIZ3JPejZncFZ3?=
 =?utf-8?B?cTVNaHo1bWFLcHNQUWFKQWJIUTVWSk14d2VmYmd0R25vOHFWdjk2aTlQVjRG?=
 =?utf-8?B?NVFRTVZkdXNJbHdUb0FnQUpuVmxkMnVWWHBrSlpzaDByL0VJR3ZyMFlVNU9m?=
 =?utf-8?B?U3hQYUtXRUpxaXJRQnJFbU1qdE5VR1U2ZDcxNis2OWNRQU1wYjA4dUdUYTJX?=
 =?utf-8?B?ZnEvV09SOUlRMXk1ajBBMHhURUsrWlg5N3M0cVp2ekNrTUVRNW1IR3ZuUWoy?=
 =?utf-8?B?U29HdFZpWHVHdHQ5bUIzamdyVUlxU3IraWkvdDRhQWN1WDJwMGhaOWowejFv?=
 =?utf-8?B?MEFzOEtUUDZ3NXlua1BXL3RrendBWWx3OTA5ZHN1RGxhMWJLRzJ4bkJubDRC?=
 =?utf-8?B?MmswNnVhU290bkluRExKOUxFOXRqTFlybCt6SEhubVNwcEQrSG9qdGtnZWVt?=
 =?utf-8?B?TXI1NGpIa1h3R3l0SHVaTnltQTRrb3lUYVNqNEtsS3RlY3QyNkxFQUxxQzQ1?=
 =?utf-8?B?bHAvMjFmQ2xidmdCeHFpcVU5Nm9LTnM1ajRhbmg3L25LVlVLY3o5cXVRVXB0?=
 =?utf-8?Q?UjvfFawrAG7s/7h16O4J+l6SA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d1a2e17-3072-4ba8-d751-08dc2729d1b3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 15:39:34.8510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H4ruCei+u6WBjGlYMgqZQ9laDkBgsNXJhxoGHytLUgO2v+OcTVZI0LBqprH5Qbf50ITRxBg9BW82dyCyy924bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8094

Jason,


On 2/2/2024 1:50 AM, Jason Gunthorpe wrote:
> On Thu, Jan 18, 2024 at 07:33:32AM +0000, Vasant Hegde wrote:
> 
>> diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
>> index 1eb0b737afb5..b1751eb495fd 100644
>> --- a/drivers/iommu/amd/ppr.c
>> +++ b/drivers/iommu/amd/ppr.c
>> @@ -148,3 +148,18 @@ void amd_iommu_iopf_uninit(struct amd_iommu *iommu)
>>  
>>  	raw_spin_unlock_irqrestore(&iommu->lock, flags);
>>  }
>> +
>> +int amd_iommu_page_response(struct device *dev,
>> +			    struct iopf_fault *evt,
>> +			    struct iommu_page_response *resp)
>> +{
>> +	struct pci_dev *pdev;
>> +
>> +	if (!dev || !dev_is_pci(dev))
>> +		return -ENODEV;
>> +
>> +	pdev = to_pci_dev(dev);
>> +
>> +	return amd_iommu_complete_ppr(pdev, resp->pasid, resp->code,
>> +				      resp->grpid);
> 
> Converting this to a pci_dev seems pointless? Nothing reaches into the
> PCI struct. Why do it?

I can update amd_iommu_complete_ppr() to accept 'struct device' instead of pdev
as we don't need pdev reference inside amd_iommu_complete_ppr().

Will fix it in v6.

-Vasant

