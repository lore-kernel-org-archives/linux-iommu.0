Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F636AA0
	for <iommu@lists.linux.dev>; Tue,  7 Nov 2023 06:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YG/5LjRm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXvpOEKHrZx7fhUI/K1PiSccg3aqavd5eovK3DIc1QVHGY6mnFP2KmWfDI1wpd/lIWj7+PtiN6QgED7xlj0UBhnNaxFuH6UTE4Cb/EvxUWJ/UKYqjxonn845uE81n4u+zdiKZcQoWOZNKbxs1beC6YxZBveNebtr8y9kmWxmu1vPy9era9pKTmjBj+4NaYHNDzgEj2x4ynBjyhVXPQIiKcSrRBu+BYTjMc8/BXWGag0KmLKEp123SXxp+c5g8PJ9eMIhwEYhms0LeKiBJesT5iWBwbeCRMQgdHDk/2YxfB6ljBhpKhlYdGp+KxTQy6DQzRqG1RpGl/8kUYFqKuEq5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cb89cendV2EfPcSRxIMLDPdKl3PjrDzt2MXWZTg1phg=;
 b=LV0GvDiV9X//7irqBsB8iVgtvhtlr4DPjAEhi5v1uUm+3CzO0Rxl7bAuDCeARhe5m8uu+V46TO4prK+MU4DjWNfoodCrbimVCXWrqVz/IdD6OxcMCVCXyj7nHDSY/XmN10Iv6eW2QklimSUwnH/luVJiggLTqEpN/t96Pf7+g8nXAMd9bDWSB3LfCB00/pk9pKEwq/fJrg+TubcjIVWEfsW8XmqRPLcGEvSk8i0bdtCviwDUU7y5Nv+5/3fHB/hQRcGyI0MuAeB2e6GJJvEDark65KFQQAttOxtDLSRptmHXB6EXtKak0CiGSxVbD/eOUeXeYoOFLvlEwyaXF4aRDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cb89cendV2EfPcSRxIMLDPdKl3PjrDzt2MXWZTg1phg=;
 b=YG/5LjRmjHHI2/LD92Tw4olMSpUlS/OicMlzS0U4UeEllkJOhDQXNsip5qpcfYyxieJf8NfX+eyhaeSq9tya4zly4uOAUufccJl2svFQOwwWFtbbRj3jNQdQ15KkriRfNb/R47cv+vWac5RAvGT2bSsj5YJOgF9GgF7gx60m3eg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA1PR12MB7733.namprd12.prod.outlook.com (2603:10b6:208:423::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 06:16:16 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af%3]) with mapi id 15.20.6954.029; Tue, 7 Nov 2023
 06:16:16 +0000
Message-ID: <97cf955a-d87e-16a4-c000-de87b79b9325@amd.com>
Date: Tue, 7 Nov 2023 11:46:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 09/13] iommu/amd: Refactor helper function for setting
 / clearing GCR3
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20231013151652.6008-1-vasant.hegde@amd.com>
 <20231013151652.6008-10-vasant.hegde@amd.com>
 <20231106165121.GL4634@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20231106165121.GL4634@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::18) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA1PR12MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: a75b6f31-a16f-45b5-f02c-08dbdf590cc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YzjfYb3mUGruD/XU8VDTtchANUdU2wKPivMIz5pLaeOx8de/IllzEHPo2l/9ZJUtw+t+Ov632A3hJa8dGy/Ys+JBBpzmwKXyv/6trhymrF0PywpeXoFMZ4ScSHX10zzulwpEGKG9zxk1+SUxH5hhq6SYHNOeGmHDda/q9VhFhWopfWIQo30m5NA1n4oRdIbZ3Uiiy5JsI32od5MoTZ9d6Wg4LGD415tG/br5wqh4oKXOuxL9eRkJAojlVHe3s06NfwNo1j9TJOdXXS9LBa6ZOAlHHjM6bGktWE2B+WhJaN8Gnxw2kr/Ivd1srzREDBtcloSnt8WlOuWcIkrkKl/7SXSDuMDFRbYG8BxMoBqHy7mFT1XKLwDzo481Ya+wEk+qHoW8bqKMvCbZHh5/kz2ukiH3JODXk9vNREUYTRd2REZiaIPAZ+GfO5KjsjUc0Vkb27Lvw2wigmlQ/oWb6pQv/vDPG9Z9eMgeFB2PcgsCr56QP1a2fpnJ0z/7mhYflsoe86G/bYH4nHqVoQmDMHtJuA47pjhgP/DVZqijSOYLaE7gvwYu5TmAJmd9JZE1vNmXtcjH/VljaJXzr8c5Ra6oNI+EW6h2OS3UoEiJAOfvn3R+mD8kXQ0QY09i6gCG/R+Nmfz/kt6HFcs2TUgxivB40A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(346002)(396003)(366004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(38100700002)(36756003)(5660300002)(41300700001)(2906002)(31696002)(86362001)(66946007)(26005)(66556008)(66476007)(316002)(6916009)(31686004)(6486002)(53546011)(6512007)(478600001)(2616005)(6506007)(44832011)(83380400001)(6666004)(8936002)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2VmTWJhN2wxZUxzUXhMOHJwM1lEdWRLSjNpdWZTUFRweDlWdUxlK0lROG5Z?=
 =?utf-8?B?Y1lKMFFMY09odkVNakF0S1FCUit0b1VYV3NVTkI4d0pZV24xRTBQTlc5bHd5?=
 =?utf-8?B?VmVYREUwVkx2Q3VvNEZ4ZVF4eCt3TTRFUTQ0NmlhLzFZWXZYR1VxNjRkblJn?=
 =?utf-8?B?dGdVMldKczhTUnhVTkYzZnl5U0xLaldrRktOYjIyNi9OQ2lsbHFtYWxuelh3?=
 =?utf-8?B?MzhMTE1jUktJMmpyWmkyNDRYbmhoVkVveFN6K1k4TFRzbWZ5QW9HRWZQdGlR?=
 =?utf-8?B?R1FMV3lkQnR6MmkxTkpjZ0Z2MjdLSkJLTms0WTRtcUVPU1ZsQ1U4a3oyS0w1?=
 =?utf-8?B?eWJLb0puUWlyK3hTS0RtRkUzeDd1Z2hYeGFsNHNwMVRTazc3R2I3emFCaE9w?=
 =?utf-8?B?R1JmTUUxc0dVRjFmWHE3TFcyeitkaEtxMEZFbTFndWdXOTBtUGNzcVhvWk9H?=
 =?utf-8?B?TFRFbm1HcXZGbzQ1NWxNTkEwcTZDOWw5dHlGSklFVk8zcnlFSzMrK0pDdnd0?=
 =?utf-8?B?SFA3aU0raXVQNEV1NUVMWFlsRXpMSUlxdXkrUkZYT0NzYzFpVXppQVk0OUVO?=
 =?utf-8?B?K2MwSHpLRVVCd2VQcG9MVlJxWGswWXhmTmx2eG5kWktFaC9pRzZLanVhQWZB?=
 =?utf-8?B?eW1TMm5mb3ZhaW5mVzdLak83alM0R21UWFBnY053TVpMOFpJNXIzNWx3d01m?=
 =?utf-8?B?aUVWclllb3o4VHNpRWg3OHRQbFdLenlxK21zRGNwaldGNnN5NWJYelArb0tI?=
 =?utf-8?B?SGpENmFiUUNpWEs0R01yd1hlNUhiY1ZIcllFT0RYNjhFOGsyMiszMzYwbmY5?=
 =?utf-8?B?RVpYQ0JvUFowRVI2QnRISEk4OHdlWUpCSWM1YmJxbHkzeVZxam9xYTVqRnBW?=
 =?utf-8?B?N1kzaGRkczA0U3h2MGxxVDJlU2kxVGZnSTNET1VnN3lubXNwWENJdjkyenk3?=
 =?utf-8?B?bUZNQ2tpM3h6a0NQcmxxam5uaHRaRXN1Mkt6anp3N0tYbjFuT2l5S2V5YkUr?=
 =?utf-8?B?emNvUUdjQlBSWEUyUWx1L0R1amtKY1NOMXVZS0pGdnhXU3RVZEFKNFV3T0px?=
 =?utf-8?B?ZTNTcklrZk9XR1cvaTVOeG4yOVhiOTI0dnJRdzhib0x1dEV4VTRUUXVjaXBU?=
 =?utf-8?B?SEthWEFhMENmUEdmdUpPRkJKKzBIRFhnUHZjbTlrZVFJckExVmVNdkt4V3hi?=
 =?utf-8?B?VTJXaEVIbUtZVEplU1VxakIzYVBiWFNIaGdBR1pnTUFsSUVKbWFxa3NIcXhF?=
 =?utf-8?B?c25XeVh2dHRwRk84OElGOFdNRjlxejk4U2ZJdkV4RVRJaXZtUkVFR05VbDFY?=
 =?utf-8?B?MWJabEkrOXZtS0VOVldQOWJqMHB4UzQ0dEpYZlM5cDBnTXJtNjI0TFNrS3FR?=
 =?utf-8?B?YnBrT3dOME1wUmF0ekh2bFdmYWgwWFY1Qi9abTF6dHNzWklSRlg2NkM1N2pp?=
 =?utf-8?B?UjlzdHBhVWpJTEZrb21sb2h4c3VSZG1Hc2toTVQ3TjRZbVhhSFJkUFN5QUYv?=
 =?utf-8?B?U01lRHpUS0l4WFMzMGRnalVHWTNuYnd5elQzMUJEb1g0L1E3V3MxSW05T0RM?=
 =?utf-8?B?RU16R2hCN3dLZ015UWlLRVZDaDVjd1QxajY2Y1gyZVdnMlVnMEJRYkZFL3BN?=
 =?utf-8?B?THJxUHVrWkkvclFpOGtUcGtIdzJVNXRWWVJtY3NRWm5ESFZTUzIyY3lCQVZV?=
 =?utf-8?B?MzdycDc5RXVnNCtzMHlVc0Jyb1dmTlFZd29BYk1CSXkxNzJ3N3h4OHBXRmNJ?=
 =?utf-8?B?bjNiV202UGtTUWhQdlFrRGhMRHlEcHZObm11VTRsMEJEcWFHSHNOR0VSQVRO?=
 =?utf-8?B?bUlpNTJjQzR6WmZ2aEpoN0o0WGp1TkZjN2JLUWdpK24xWkxJck1kakJzYkRu?=
 =?utf-8?B?eVRYU0JaVWY2NExNbzFHVGNHMlFrcGRXU2VvSzJQRzRwbWwxQXdjMm5EVXJH?=
 =?utf-8?B?dkRNR0xnVjl0dlYvdzVac1pVTGNQOGVJTG9CS0xxZjdZQkdJZkJHTm1jbnNs?=
 =?utf-8?B?UWdBQjFWZlJWTXlRb3cwb05ibDNUOWtuTk5EYysxZU5lTVNnTExTVjIzcGtO?=
 =?utf-8?B?UzBaRldXVmZzRmIyc2NZMWtFU1k0M1J6Q3hZenN6eEpOTmRoRTV4cWJNRkxm?=
 =?utf-8?Q?2Pq9M9AroaN7jkpV0jHVdx5Ay?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a75b6f31-a16f-45b5-f02c-08dbdf590cc9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 06:16:16.5944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MFg/zemWsyRRyiKvAMKZJwWoO9x/dzw37j81MsliFiTI0SwgxmiAAF9Mik5piX+45ads/+Dogd2Y2YKtB1OCjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7733



On 11/6/2023 10:21 PM, Jason Gunthorpe wrote:
> On Fri, Oct 13, 2023 at 03:16:48PM +0000, Vasant Hegde wrote:
>> +static int __set_gcr3(struct iommu_dev_data *dev_data,
>> +		      ioasid_t pasid, unsigned long gcr3)
>> +{
>> +	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
>> +	u64 *pte;
>> +
>> +	lockdep_assert_held(&dev_data->lock);
>> +
>> +	pte = __get_gcr3_pte(gcr3_info, pasid, true);
>> +	if (pte == NULL)
>> +		return -ENOMEM;
>> +
>> +	*pte = (gcr3 & PAGE_MASK) | GCR3_VALID;
>> +	amd_iommu_dev_flush_pasid_all(dev_data, pasid);
>> +
>> +	return 0;
>> +}
>> +
>> +int amd_iommu_set_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid,
>> +		       unsigned long gcr3)
>> +{
>> +	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
>> +	int ret;
>> +
>> +	spin_lock(&dev_data->lock);
>> +
>> +	ret = __set_gcr3(dev_data, pasid, gcr3);
>> +	if (!ret)
>> +		gcr3_info->pasid_cnt++;
>> +
>> +	spin_unlock(&dev_data->lock);
> 
> I didn't check carefully but most likely this lock is not needed.
> 
> All the attach/detach ops which are the only thing that should alter
> the GCR3 table are already called under the group->mutex.

Yeah. We can switch to group lock check when its exported.

-Vasant

> 
> I've been thinking about exporting a lockdep assertion for this, but
> drivers already rely on this propery.
> 
> Previously when the domain was holding the gcr3 it did need a
> dedicated lock.
> 
> Jason
