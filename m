Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEC214278
	for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 05:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="anzUNLlC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbnWXDXg1x1MLR3v0JpVhKY+qGQMdlLonhizriRFwnFYjT0ADBFlzxpGQGUbb/hhGPUE2UW0dwBv+vDOa2zFi8p9x5CKMg9qU+zXzHDN0XDqBoAWxbWJCeHKmNmevgrHGb3QUOFRhGf4rPu54XZV29IvhmZdmvX8xuuZLhRzcCNwwLA/u+pvmm8Dj/KOmsWhYFqpWESZMF6cpOTtNlxiRbozQPkJ2ovE3LZDygSngUEYfHj+SZTADon3RKyHd45EehTAW050oL4c0JpKk7nYUMDIZgHR177m94NjJL5me86UYCzB0o8K6R+7/YHcUxbO0z7woy50PFmF3yYmx7I0Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rI6kJQTzA8WJRYF5VL5L/iwKpHqNOGExGKBXhCcEpmg=;
 b=nF5cVHTDvQ3uigxVRwY31bK/9X4bWI3wzAHImSgb9X3j22S4cagBsbXnnQmqJJAycQx8psogZzdMRKuLKZLuO/H7vY24T0IolRi/CkcBWhKBAcUoxIY8vCwJ5V7dCVZCVjotYBDL0tlJqqE8MufbFBFv4gDTOxgy4EDbis0u6TF7cEOh6MEs5d8VoUawhiAlGvhm9G34/Hgpqw4KCjw3QXY3h/1FOzy+GPdlB4ZNoi2qm+UEeC1mD1YCza0WuQbUrxZ7zu6t916nl2f+SsNsz2YRKt/InChLUyYtafb3nG6iNMJlxi4mPbgiCyJQvPdDc+rjZZSLPZlqdCdSNf6fQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rI6kJQTzA8WJRYF5VL5L/iwKpHqNOGExGKBXhCcEpmg=;
 b=anzUNLlCVzpgS0nmATDJm6WBLD0ftURo35XSuKe4HSdYyVCFBAZc6omYI0yxzYJHl1PZut7esOJLcxgL6iupce1mQ/23W+xyLup6UgqQBX56mh9yDXA7hK2i0b41n2XwOI4FEkSETiMmMkzzRVx9M85YPyELVOOk8E4TrEPhPEQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH3PR12MB9251.namprd12.prod.outlook.com (2603:10b6:610:1bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 05:41:32 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af%3]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 05:41:32 +0000
Message-ID: <246e909b-e020-f1f5-deb0-f48d68cad537@amd.com>
Date: Tue, 12 Dec 2023 11:11:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 10/13] iommu/amd: Refactor helper function for
 attaching / detaching device
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20231013151652.6008-1-vasant.hegde@amd.com>
 <20231013151652.6008-11-vasant.hegde@amd.com>
 <20231106172931.GM4634@ziepe.ca>
 <f23aaa41-b22e-b274-5774-6317ba643e8a@amd.com>
 <20231107132827.GY4634@ziepe.ca>
 <d99a1d56-6b29-53e8-1d2b-564a56548009@amd.com>
 <20231130175523.GH1394392@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20231130175523.GH1394392@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0117.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::21) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH3PR12MB9251:EE_
X-MS-Office365-Filtering-Correlation-Id: 182b4705-9ac0-460b-8dd5-08dbfad4feb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F7XBlyU+0sqNz0XnwP5Ltb2DF6U8z23OxA5PTAEyeQtVr13x42prssIkdNrJxVFj2eXR+25psClBcfdRIwT/olkElYqSBq6B6bFEUNJ3v4gGB0jRMGpTGLImIiknLYg0vnToZXxoJaTNztIESyXy0z/W3IhDCh0+xhiMzhBPTC8pOlr3PR7uAiBF0+eLQMhatIXFWBDhyfDPO4dPkrCpdztlN/HfwrYJgCkd5+hpsjbqxn4fv93p4eCS6BUrQ+F3HVwM5E/vngxtTHrXDNVhXd28N3mTAKcnjv5nevMAw3p3Muhjs7aaFCVN/RyjAgPvOt8tTh3c3IFv11CUkZTYHJF1/ECvbOJvRK25e2Zmkj5qPJps62kASvzPjObLLWfMQ8YlgBE99oyZXZiVUWMqshS6cN5bji6FRf61ouA/soaLUxz1j8x13jLzBADlYVASm8bR6v6Y7kBbAaOT4Ap+wOw+W3iUSP04xJtX46sGiXIWXvW+gjxxtrqKYT/blEDGmbRUFxaWk+WBmtLHEmAOJtchKfoQB5KGwpecVw2qJbBGF31f22DW3igs1FnRp5W/neXX63/u/yYbLihVuB3+TEes5XoOy+3mF6fNruHUN4LLSlSzL2InVhY8SmjQ5jj2J4QenwfFv89hySmnl3K4xg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(366004)(396003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(86362001)(38100700002)(31686004)(31696002)(316002)(66556008)(66476007)(41300700001)(26005)(6506007)(83380400001)(6486002)(2616005)(6512007)(53546011)(36756003)(6666004)(2906002)(478600001)(4744005)(66946007)(6916009)(8936002)(4326008)(44832011)(8676002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUNQSnFYUjZYS3hGMTVpSUw3RjNXd2F0RWQrS0ZLWEt1VENZTURBYTEyL0sz?=
 =?utf-8?B?bmtPMmpiL1dVL0JsUkw2ODUyWnJ1S2pZVXYxSEJ4TEt1M0tDM2dIT3gvMFlX?=
 =?utf-8?B?NDhtVnRkOFBuSVRKdnZ0ak43S0k2V085YWh5bzFtYWY4Z1g3K2lURVkveVZw?=
 =?utf-8?B?UU9MeXFIblByRHFXb2dnZ0VqbzArMTB2YkNwN0NlWmcvSjlzNEFyUlRPbGJO?=
 =?utf-8?B?cG0zRkxUbVdGWUVNTFFxcXU1L2RZelJOeCtLQXFOSHUzcUJTWkFybmkvRnp6?=
 =?utf-8?B?VUhqOWNGRlB0TGxoYU5kajlSd2J0eVBqUnNOQVlMazVONVZueEc4ODZNRWZO?=
 =?utf-8?B?ZXJiZjRUdUY5ZHhoeFNycGJmcjlkSEhnWTNCS0YyMG5Mc0swdzhYUEZYci8x?=
 =?utf-8?B?TDhXYXBNRmdDeFRiWlVMMXlyMVcxNm5lcWpBR2QxdDlWcnV4ZE1tYTR3MCt2?=
 =?utf-8?B?QVpzamxNb1BOTllTeXZIUGRDcHc3NnkwMWw3NEhYbGpLUTA5ZWZnbjNmYnJU?=
 =?utf-8?B?dHVoL2hCUlU3eGNPVHFOMFAwanVzNEY2UFVCTVoraHFjWmJGT2xqTG83K0pq?=
 =?utf-8?B?c2U4OVQ1Z0NxL01FckdFTW1NY0t1UkR2dFUzeDU0VHNiTUFVbE9KY2tiSnZ6?=
 =?utf-8?B?KzVDM3VHOExhZGVRK1BOeTZJa3BrSDBqcHVyU1p4MVFjcmtITUhlNWppQkl6?=
 =?utf-8?B?TFo4NWt1djV2aERnd0NEQncyS3Z5ZVZRZzdleEd1ZHF0ZHc4KzlPZkFEbzM5?=
 =?utf-8?B?QkthMnkrejRueEN1TkRYbk5mZEFLMDROWStkUVNsSVpWSE1NbDE2QWsyK0JS?=
 =?utf-8?B?Z1BjR1ZNbGIrK2oydUVINkdpTVVWK3NhazkrNDRJVEk4cmYwTGEzd2h3OHpx?=
 =?utf-8?B?UElkNVduVlZVWGVPQ3RsM2syUHNIZERiN3luRm9yVEE2Ynl6WktOZFpUcnVh?=
 =?utf-8?B?ekQ3MGJZR3lCZzlyeGNJbXowRVZ0L0dzMWR4cWpMY1laMXYzaWRlU1Y2c1dz?=
 =?utf-8?B?NG4yQlNiZ1loL1hSeEdITGtpdDFwZFNjNnZyYm02eXhkd1MwYjJIYTFJUExv?=
 =?utf-8?B?WHhXQWhGNW5ueWNkdlBkU2RSUDFvS21pWjA3TUtqNlVhMDJ6azBMQlNQMUg1?=
 =?utf-8?B?QUZzWklEaXZBU1dkZmxsODJlRkhGa011NnRFQXp1UTlMdFFhU3RBQ09rZGFl?=
 =?utf-8?B?VWFycnZjZlhKcEhFeTJyS0IrcUZtTisySXcrY0I2SURrR3o0eXpWRGkyV0Nw?=
 =?utf-8?B?UUx4MTQ1L0FqeVRRY0k0Q2tFUDI5VFdYQXpMcHdGUmRYeHBBVlMzaVVKQmNy?=
 =?utf-8?B?ZzBRb1ZnK0RPUnRqazdzeW0rb0xJVlk5NlFiakFOSlp0RDVBakVpRjNJTDlE?=
 =?utf-8?B?Mjdhak5tK0oycFlEa0R1OFlzNEU2VUM1V1poaVNGNHNSL21neHIzY3F6c3Mw?=
 =?utf-8?B?TlRPM2l4aWVTOWxTcm8wa1ZXVS94b0JoeVFmTG9qSjBaRnlzdkJJZWlNWWVQ?=
 =?utf-8?B?NDFKT0x6TDlyY1lpcUFQbVp3VExnOCtDSEM5WkRSR3VIeVhoQi9TbHBoMTlE?=
 =?utf-8?B?ZWl5Uy91L1lhVVcrRjNCZHN3Mk12WGQwYjVJWHliVzhiTUNnRWJVWmNwWVVH?=
 =?utf-8?B?NndBcG5VTXJYRXZ6UFBHazNtL3E3b2dOeG9oSTRuTHViWUdXWnJ3cFBZTTB0?=
 =?utf-8?B?bWJqeHExYXJ4b2htVlh3VDJVRWV1a20yZjkrUlJxOWNueHlsbHZERjRwUnFX?=
 =?utf-8?B?cUJ4dkFkZDM4ejgyRk50R3ZFSWdQUTczSmloUXhpZ0trN1VlOE1pVG1KUGlr?=
 =?utf-8?B?blpNUUhrbHNJN1FhVmh1OEkvZ0FwSFZSWnlrS2FnaFJKUmVRc0hWdDluRmIx?=
 =?utf-8?B?VDBJUllQcnFpSlNybUFseW5VUll5R1VlTEZaYzBOcFA2R08xbHAxdVdmRHZR?=
 =?utf-8?B?Z2NnZG1pT2Z5RHp5WmdlUWxYbis0K1BwamJHTDJ5RnNRNktPS2Z5QXZrc0Yx?=
 =?utf-8?B?dzVNTzdxcS9IMTUwNVNYWGNsUHFYWTRxWGs3WTRWdU5jNzBYMHQrRHJkeDFq?=
 =?utf-8?B?WHpSSDJ4M2o2dm0yL0NxS3JrY2JwN0lHaUIveEo4d001d0l0NWxLSEFGYlVl?=
 =?utf-8?Q?TFIyoENkdgh9hd/+ZMHroCj+2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 182b4705-9ac0-460b-8dd5-08dbfad4feb4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 05:41:32.0003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LHUaGFYl4F6togaHsGpsBbs6nTAPGgqbQYlrRLKnndOpYvuFa2t0c8ZAPbFyryTLja65cBO+k6QE5ZaoJJ6kdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9251

Jason,


On 11/30/2023 11:25 PM, Jason Gunthorpe wrote:
> On Thu, Nov 23, 2023 at 11:09:20PM +0530, Vasant Hegde wrote:
>>
>>
>> On 11/7/2023 6:58 PM, Jason Gunthorpe wrote:
>>> On Tue, Nov 07, 2023 at 11:25:49AM +0530, Vasant Hegde wrote:
>>>
>>>>>  RID domain=BLOCKED & PASID - ?? [V=1, TV=0, GV=1, GIOV=1 with GCR3 entry 0 being non-valid] 
>>>>
>>>> I haven't thought this scenario. Why do we even need this case?
>>>
>>> It is triggerable by iommufd, it has to be supported.
>>
>> You mean PASID support with BLOCKED domain?
> 
> Yes, that is API possible.

This will be tricky as we set DTE flags per device, not per PASID. This needs
more investigation. We will implement BLOCKING domain first then we can look
into PASID with BLOCKED domain support.

-Vasant

