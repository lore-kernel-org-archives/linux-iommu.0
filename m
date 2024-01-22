Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95F41849
	for <iommu@lists.linux.dev>; Mon, 22 Jan 2024 03:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705895397; cv=fail; b=hJ7iJNqjFeCF4Ei1ippGx/N1ns4eF1maDhaJCXbddE+HFQvqiSK9HghLSM/PLO5jmUYqdLnzx2jpKsHLurpm4172mo7Yw+60+n9FtatbY9PPXFEXszARkaQUnbMRdGjOn5fKv8wgLoNxJLXFpUxLerMhpkMzWa/J6zbVamOKqp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705895397; c=relaxed/simple;
	bh=axthWMcAzg19eqYCO8Ip5o6OV2tpJsWX9hQUWnMci3w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F6D/FcABz8AodYMFkyvOeDdInsWQ47+FAsDnTIcuKJd6//0G5QGKLc0z25r+rGprzhL4hk9Xz4hHtqsWpeoqfKw6ePPRmhtF5PKl7B1HVYOILPKqewr6rE8w4IvrK4/qGLfvS+HcsZGxWANV3M9IbfXkotD6xk9h8s6F8y9Odmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XeSu8TQF; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XeSu8TQF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKTU8C4NGUPNLfKHYnm2JNcCGQRVSwyWj7u9FCe5F8Vm4YXt+aa8wIOjhvCsdd1VWpVYAC7ud8pj9UrwBe6I7QvxwHGvhERSw8iojCWWhVNO7TSVEST1Vx1A09CvrOMaXM/ndB0eCBaZEfSORuuZbjnPr6dThE99PsQE1G98SmZ7e7BLoze4xjAW4EvCUO7egENEyCjqFH17a2+aHNNf12lcyLf68Ztq7XO32rULpxlNW7dRhHfnyCRVJ5FDpv9jDtNJMpdyzjrXMao4PzeZjURcuEucJM7MrpvXrGRSV2mxLh9sQD7xFAewXDh87GCplIKKDgug/In6VbtjRC/A6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/cJG5aiUdI1L9v5Ha0IjzuqtlsgZzX44OG70ZZJhpE=;
 b=iK8VGFdRdlIUsukKI2Jb6tYfAvnzYz2sM5kw5iG5nkJOEM95i8RAVuzdoZiu4SSLpEhrYTsaD3oyqGHVFn2hLoTswMC9lYeN8cYFQlUNZxGSfdbA3KUX2ACaGcjEwgvhfr+RaGVwkPjtK/52uX31nntclykCUbJqHxPDOK6WFVGKJ1LkAPVnUZHblHf1nRmjzGdVEgxQuDvgpiFaiwa1Xfp4o7Ttl/BdK+6gqeAVgzNfEnCfL63K0SMeSngt3ot2i8i9N/i5Sq8EaKfZ1vM2NKrJo/YYyts19/pwd+qUDskF0oMrV7kWVwwkJQGFgrvxFEUWoAAFqf0on8UsDPFNCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/cJG5aiUdI1L9v5Ha0IjzuqtlsgZzX44OG70ZZJhpE=;
 b=XeSu8TQFzoCWAWt/V/I9OFdisY96hIEmbWM8lThceea2K7xaKoYaREtBfBYVlXoCsWvffbv5ullFd4r6yZMfn9IciNcVPQ51SEFi8WhUFiDmydz8ezx/oPol/eBKFLf3qm+v2W7Dl/Xa0BWMTu9LkRxWzDrol1NOC0WP/Sn2Pqc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA0PR12MB7627.namprd12.prod.outlook.com (2603:10b6:208:437::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 03:49:53 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb%2]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 03:49:53 +0000
Message-ID: <b649f7fe-e520-4638-a437-af0bfeec331b@amd.com>
Date: Mon, 22 Jan 2024 09:19:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 0/6] iommu/amd: Misc cleanup
Content-Language: en-US
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 iommu@lists.linux.dev, joro@8bytes.org
Cc: suravee.suthikulpanit@amd.com
References: <20240118090105.5864-1-vasant.hegde@amd.com>
 <dc37c9cf-8c4b-4437-8596-b3e7e34d288f@oracle.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <dc37c9cf-8c4b-4437-8596-b3e7e34d288f@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0174.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::29) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA0PR12MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f56d686-dce8-4b6d-c2c6-08dc1afd30dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TaF5TnC5jTboEbVOjvolA39Njw2iw7HW6G5igw1Yzmga+AZPlQaD7qtSUAgSixUVKzhEBHhBH+xwb2WryVhOhvjKXgZFefslelpYMB0EufUx65JdzobQo55rpfy3wPuLHanU5rHJYrUH6izYMes9mA4idGwiEmMxduvwWaXtH3TEL2YT/cP8XEQEkUdqrKTFhsPEeCptqw3MeMpoDMKANHHm/JlbYRnbKG8tNeDJrJG3lH8yuDCveSOEpmARl0mzugrUWJQ0Vi3HpdYKuuoYouSzDvwter9ZsB2LJgIRYsPMZ68rgIXknABZe0dN3fWfSgJNCah7l4h/Y6VGngWeO/NAisSQoeUoYNbsnUyjLW6ATfGpmbse6Bz+LKQ2OpaBkn1mosKSRgIcJR7ea+S8Vl4ucje7q+5TeHCF1/THNaybUN31uEipT3DqBS1JFkXzq6a8cjKm1t/9nGWqpK1vHLNpKYnjSRnJSa1VqDGQr3maBsY7xQTE8YqweGg68xJtuo2cWktlAdZiYHo6bqlCPdJkG8VJ14EGoupi5tWO7d+SjYN03wZ47qJsHGGbQ7ZdpHoRnFg+RVi6Ql29fGmiJQnoi2ZX1mvVNdIGUxWF09LlPdx8DA6kAW5QW7/lUJgkebye0XIpo05VnHN1/27w6A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(366004)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(31686004)(66556008)(66476007)(966005)(66946007)(2906002)(4744005)(26005)(6666004)(8676002)(6512007)(478600001)(6486002)(4326008)(8936002)(5660300002)(6506007)(316002)(44832011)(53546011)(2616005)(38100700002)(83380400001)(86362001)(31696002)(36756003)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlNxNEEybnlieU1Ud2pyWTRSdVJwSTJVdjExb1BVcXp3czJOWE5vQ1daTkRT?=
 =?utf-8?B?QTVPZVE3a2Fja2VabFJwcXN0MDBZTzlBTnZLT1Z1dzdnTHZ2MHM4SS9LcU1n?=
 =?utf-8?B?SFluV1IxK0dGbzljUjVMVjhQYjY3SS9WMmJFMnZ0eUdhRmREOXY4U3dPZVBh?=
 =?utf-8?B?NFBDbldiZU1ROXNqM2FxeTU5alhsN01DNkxpT2Q1aGIwY2hpSVBnUVhaRWxn?=
 =?utf-8?B?TkIwbGhxdmZGUlkxdHQydWRlS0wzTG1LMlB5ckV0ZlNmM090ckdkSjN4Uy9L?=
 =?utf-8?B?WDEzamkvbzF1TnovcUpaZ3BhUUpsdTNmZm9PbmxhQlRTNWRrU3NscnNUK3Fz?=
 =?utf-8?B?dlZZN2xKY0RKUTZrTEJsWmsreGsyVW5haU5nMFFSbVNzZ282Y3RnOVk2ZCto?=
 =?utf-8?B?SGRPWXdmOHRuanRwbFkyZExDTzYvbndhRmpWNWI0c1ZFZEdIMGV1QUxjUkNC?=
 =?utf-8?B?T0toc1IwS3lWYXZxa0VGL2JmVi9DL1gxR2hnUmFhbHhoOU5OWmw5MHV2eXhv?=
 =?utf-8?B?bWhTUWRZZjVKUEQ2eVR6VzFmQld4dFo5SGlydzVWQjNHUW5ZWlRmNi9oWVBr?=
 =?utf-8?B?SjRPeVhqUDZMSXJLWTJmemQ4Y3BNLzRvMENwd2VCa2pZSnJiMkVaUDd2aXpO?=
 =?utf-8?B?YnVHSTVuU3hhOERRbVBGQVNuNE9wbFMzV2V0YkZxTnAxS3Y2amJkUkdQK2ta?=
 =?utf-8?B?NDFOZmk1azZ5WGJaTnREMlNHU1RKek9STDBVZVFPbUdDN1prYTlmMkZET1FU?=
 =?utf-8?B?MWlEY0FQczlGUGlaS05lbHZvbjlaeW0yeVY5ekpTUVFhMjJCbHhFbFM5TzlU?=
 =?utf-8?B?MkdpVkVDNHNicXN3ZUdYV1ZNek5WaHRnZDlyOXRidzZtQzNJTmEzcS9OVEtI?=
 =?utf-8?B?SVl3cHlMTHptNFhIZnlBd1FWa3BhMng4azJqK082R3NBcTdtZURPSk9rOUtF?=
 =?utf-8?B?akZMWFc3NjMxUUFXSzYwdUJGS2ZxVVVsWmRTaUNjTVc2RVduK2RUQzBkczdW?=
 =?utf-8?B?Qm1JRWZVTGNuamJGMWcwaWs3Z3VVUmQ1WlB5QjJrZ20xYTFQUlMycllVdTQv?=
 =?utf-8?B?ZThhVkVDS3VBU3J1Q2Q1anY1aFMyVmlIaEx2WmVrSlBNVE5XbkNiYmFrbEpT?=
 =?utf-8?B?N1QvdXdvWUJ0TXBROGNHTjJkcVUwSE41eXFtcVE2bDNFN1JzbHk3ODh3aGlY?=
 =?utf-8?B?OEF4emoyZDhBcXZVc2xvb1BGd1Q2Nm9kTk40OXZ1aWhBczRoVDEyR2FLaVkw?=
 =?utf-8?B?NC9hSTI2SUxZL0x0bUtxLzJ4ZjhnOUNUSkNmaVlXWGNPU1lBRTEyc2lqUEVz?=
 =?utf-8?B?T2NzbCtBVjF4L0JqdmpQVHpDVEl4aUk4bmRRNklmTlB5b3dSeEUzTVlHRlZy?=
 =?utf-8?B?RUIyNGk0MUwyN05jeENLQzNGQi8yR2hzU0wvNnM0ZTZuZWVuQ0RMVGhIZHFQ?=
 =?utf-8?B?Nmx1dVdGNEVXMWhKNmI4S0pnMGRQZEJwYWFVcTBwVVRmZlpBWmxuZEdFeGM5?=
 =?utf-8?B?TGZlSURYV1RaZ0lLRUd1VWpUVlR1SENoc0hMakVXY0FFTmxiM0tWaHhmczVi?=
 =?utf-8?B?NUMwd2xkV3hXWGgzS09ZWXdpVmxTdkpTVGNQb2JUQ2VrRnM0dW5CRTJRWlQv?=
 =?utf-8?B?WlJmV2tpdS91Vkp2dEdNNlJjWWFJWGlUcWNQQXVHOWk1YS9rZFJIMzVYTXBa?=
 =?utf-8?B?TXQvTW11Y004em4wZXJFTy9wZEtFRERLYmd4cjF0TUNYTmtuUEN5OCtVRkNw?=
 =?utf-8?B?ZW5yOEpUaGs4RUpWR013WktIVGRCUFdYc0dqblh3VDA4NWJXeG1PUUlMMVlZ?=
 =?utf-8?B?VkNtbVM5TFU3OXB4N012N1h1d1lWK053TVg2TTdMb3BpdmFqZGdDY1ZvRlhy?=
 =?utf-8?B?OUN4dTBBVWZ0aFNYVnFVQXhEdnFRcE1Lamt6YWo0NDB5dllUNXkzd0JXSVpt?=
 =?utf-8?B?QlozRElUWlVCTW9XeFEwajNnalJhV0daMFphSlFsWTlTTjlnTHhBbFF4VGtR?=
 =?utf-8?B?RXZZQ2dTK1doTDFKWGNQcXpYNVd5TmpuZTkydXpyakZQNmRDUlZ6V1krQzhr?=
 =?utf-8?B?aWI4MWVmTk9POXBKYU5LbVZQNTNOY2g1S1h6Tnoxd1lvTVJ0RVplNE9TMytP?=
 =?utf-8?Q?5Nou4h7U+zik6cdaYxA3SM9ZA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f56d686-dce8-4b6d-c2c6-08dc1afd30dd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 03:49:53.1907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ik0nr0XQ2TxWHxXKh4Vq+IhTyQTPE62w4fpp5udsME7AZLtUGNZ/7X1vH56QbJWljiWNJ7sMYHqRqEUgAvjKFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7627

Hi Alejandro,


On 1/20/2024 1:07 AM, Alejandro Jimenez wrote:
> Hi Vasant,
> 
> I had issues applying the series to the topic branch, and realized it is based
> on top of your SVA Support patchset. If these patches are merged before the SVA
> changes, the minor conflicts are simple enough to resolve I suppose..

Sorry for the trouble. I forgot to update the cover letter.
You are right. This series is based on top of SVA Part 4 V5 [1].

[5]
https://lore.kernel.org/linux-iommu/20240116165335.6043-1-vasant.hegde@amd.com/T/#t

> 
> On 1/18/24 04:00, Vasant Hegde wrote:
>> This patch series removes unused macros, redundant check and
>> unncessary EXPORT_SYMBOLS. No major functional changes intended.
> 
> For the series:
> 
> Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

Thanks for the review.

-Vasant
