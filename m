Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88B33D7C
	for <iommu@lists.linux.dev>; Wed, 30 Aug 2023 14:34:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QgP9sgyTzgQ4gODBvLMAOFG/iO7WMd5h8DLi5++dGRIB1JCPHxLE2QMnnaUaGsPU3PgvcS+9EF9nty2COZqESc+QDH7re37rbSkSlgCWSOkpX41gy63goTWhztR6mQocMC+IAA7bTD1/j2k4lexe5JFHqDdcg7JyvUuC11JYrEtuqf/p3Vu0vDIemJc+T2BeDOjHAB2tKgHqYNegUMYL8dZv+4e5vWc+GQl9veu2Ipi4D6rzFJ4ApO+0f7SkvxPF+J9JCtHphIKjvHYR+BP1SClqbDeWgMMP4qhJ+mmp0xOjUtVlffTC5os2Kc2Y6rj7oCXykzxl7GpBE28VQ/UD1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+3b/ZGKE1DhfHC+/4J2deKOkA4MdJ8/Eda+IoWw/ns=;
 b=YXt6fR9S9pzo3r+Lbwox0/5iaskp0+tLaJSraWJ+zNkvuCUI/3oQ1Wrii7db6FLuos1FaugqPgq6NdnAuUGTcOsdqkqAwZS/sijbwOKoNZkLttj0epqe96vZLW3n+mXDWcX7oAccrZHC66NABw2vBefTX1/loFRu6bEznzozgS4fptCBO7scuMETmqFRZfDUgRbktnjc6XIQGwCD6S28H6nGfiibTzltERnsPHgAMlYx97GYu72D3SqRZiRebNnhRqyYXiWFP3uy/P8TOwcf8e2SbIjNcWK8OfNmTpOKX6VzP+REn4ApRw1TEXB8yDyPCaA/51S+MMsDwGR0yCjOOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+3b/ZGKE1DhfHC+/4J2deKOkA4MdJ8/Eda+IoWw/ns=;
 b=JXoVOVM3YTQtlk1X+/SDQvdORLdtnviCtiVkEiFn1p3BSPODxAdSKov6y6zLuLFfHPPAbmq/ErsA+ovpIzC7K+pswPmkZRLj+a7SpkVTWooWWFeGZ8iXnt9Ny9BJ+b5NJDL7AgceVwKymgNAx8C8gFQOsmFmJW0sMyg9gcpxdQw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SN7PR12MB8130.namprd12.prod.outlook.com (2603:10b6:806:32e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Wed, 30 Aug
 2023 14:34:14 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 14:34:13 +0000
Message-ID: <af157bc3-e3b8-3969-fb53-b81f4b24d76b@amd.com>
Date: Wed, 30 Aug 2023 20:04:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH RESEND 08/10] iommu/amd: Add support for add/remove device
 for IOPF
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230823140415.729050-1-vasant.hegde@amd.com>
 <20230823140415.729050-9-vasant.hegde@amd.com> <ZOYmtQiwsodtm/Eu@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZOYmtQiwsodtm/Eu@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::11) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SN7PR12MB8130:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d3ef434-2cff-448c-d7dd-08dba9662e87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	t7aI/ikcFIFtKNT7jjujzl8kHhtOdOSt4BmxudpEDcH1wV1hQMN88sPGk91s4nknk4NBkX8WhtF6pE+SrqzpUbyrecPUPUtvsDJnAXSYfr7Kchv6CR28cryu0jrmVeMovVS6auYtA4Xl6R67RuU+qifrUAg8OhYZyf3kQPfkqjL2TcIyHkz3op6wzx8AHGfCwx8U3p2IR44yHPtlaeUpJoqkP5qWHz1Y/YXUSDUhu4bpaiiHYqdp0aTjEIJz8/ZLt8L+8ARTP7DwFRaSPQJa800GIZRGuuMxnMMvVCTdS6G2vj2RMLyvgpORU3NJu2g6Xl0zlxNIBnKUc8grKCzWFm9Yhp48DBNmeYR62++N0Fnp25NoBVKwM+XLMIy4JZl0aTtqubfCBHy2cj0FN385Mvv/39UlJPugoQupzkevxX6WzJG3UYpwogGWhwsIzXrma6w5SRhXkBZuAKHTS1YEQx6rU60VUhTvFtVMeL2Mxb3Xboz+j9FIuwteX0RxK2DPmhCKq8pyDXwmorDYire11dtG17QvlvWF+sHvZjRSgXMZUjjRG3uV51koDB/Tp19MAfUoATRg/9XJxEH4nBPi/qOubH6ymJUWbIbF7mzDj8up6Whv7WLtkKbfhJrvWjzBCa5CT+/H5aEL6hx3ttK6KA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(396003)(136003)(346002)(451199024)(186009)(1800799009)(31696002)(6506007)(6512007)(6666004)(53546011)(2616005)(6486002)(8936002)(66556008)(5660300002)(2906002)(86362001)(36756003)(6916009)(4326008)(66946007)(316002)(41300700001)(66476007)(38100700002)(8676002)(44832011)(83380400001)(478600001)(966005)(26005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGpjSnJBK1Z1K0lXeW1TbUZYeUY0cDkyaXVGK0hwSFFzUHpqUFppaXh1Ujla?=
 =?utf-8?B?QU0yTktJSkkyZ3h0TXlHTFFnRGdoc1d3S2hQZHYrWDRMb2QyWFQvZ3FCd0xS?=
 =?utf-8?B?R3RKM25SdEZrb29ndzd2TCsvRngyUEhoYVE5NU83c0ZLVnI1bktFZEhBZ1Nu?=
 =?utf-8?B?ZWx5NzdKejJJQmQ3aGFMekY4QTlHbjlDWVFVL0RGY3UwL3V6Z2R6TGlSVDlx?=
 =?utf-8?B?OGFFcmZTYkRJWW1keEVSSWtxNHZZL1c4Y3VEemYvaHdmSHJnTUJHbDZZTUMw?=
 =?utf-8?B?V2JFamYrVGVEdGJtYkFzS0RhWjI1RU00dzB5K2pqdjR6bXoydUFFUkN0K281?=
 =?utf-8?B?M05ubU1yMU1FcVk4Y01nYXBCZk90OHBwdEJ1clgycXpwUVZsK1NYenhyck1V?=
 =?utf-8?B?WDFWbUczZjN5U3hCVEFYMGQvNlc0Vkp5d1MwT0xiNzkrUkFMMDJHdk95cVVk?=
 =?utf-8?B?UjBxMGVyU1Y2Sjk4NFpEK3JXUjlSSk1uRmJVcktJVlNsOUZjL2dNNFNnczA0?=
 =?utf-8?B?YTJ2bTZQWGNpbVhVS0lKR0xHN3Z1RFUrOVRGTUhiYjNnTjNrZWJBZnBhTkxl?=
 =?utf-8?B?eHJkSWFDZWxKNzFjR0ZZT2YwcXJaeEpoR0xDNXlsdnVOWkd4eVpvUEcrK01i?=
 =?utf-8?B?UXNxSklLeXBPdENYRG5lOTVpMHJUdE5GU2gxcWluQkpON0JkL0pzemRmd2x5?=
 =?utf-8?B?N2poRFBPVnd0VmNzU2VqY0NZVGFKeVVXQmtOZ3FIWkV5dmt4bWpzbGt5eXFn?=
 =?utf-8?B?L05NT3pmOHdyM3laLzV5R0UzQS9UZzMzUVZXY0MzYW9WNTdLVGErTE9GY2No?=
 =?utf-8?B?cG4rTUcwZlVmRnNadHhlU1VHa2ZESUpTVTkvS1hScjVEUUl5NHRrRC93TW5v?=
 =?utf-8?B?YjE2Qldqb0dBOHNzdEd6L2JLbjZiVXQ0UjMwdU5wSEU5U3A5ZndXWXJRT2ZN?=
 =?utf-8?B?czdQdWwyY24yTHV4dWhVRjg2T3hFL0tjcm1POVA5dVVKZ294Vm5xbWFVZlN1?=
 =?utf-8?B?K0FvaksxRHhEZlFwR0lOOTdoWnBuVEpNT1U1L3p4blpCekRpUko3Wlhqa3FY?=
 =?utf-8?B?eW95SnZ5dU5UV2tPa0l6MnpQdUdkWithYTk1dGhNeXg0OU53aW5sVmw4dzJR?=
 =?utf-8?B?SDJxYUN3THhpejAxZEpUejZ0SFpjS1AxZDdwb1JnQ3dRZG1PZzJYcEdYVzY1?=
 =?utf-8?B?amxHRlpLTVl6ZmlaM0VvaHRTMkdxb292dXRQR2U3aVFrMlFzYmJ4TStiM2ht?=
 =?utf-8?B?TisrM0s5L3RWaFdUUEhnSWt5SU9qNnRFTFhPRkpzM2MrR00xdU1RekdLOERa?=
 =?utf-8?B?RDl0ODdvU1d4NW1jNFhEWnZYUFFTMHZWakNIeWI4RkxpYWpwSEcwYXQxa0RB?=
 =?utf-8?B?Ly9kOGZMTWRtVjRZY1RWRmhyMVRPM3RBS1FNNDhUSGtjOG45VktDZzFDV3Bj?=
 =?utf-8?B?aUtyNGRScE03dXVrOWZtWmVwUzdpb3dLK2M2K2RhdDNoeTFCdUZHOXFzK3JL?=
 =?utf-8?B?eThEZHBCUzdYNzB5NGhqKzd6dU8zam5LVkZpTFVhcSt4VnphYlFKREtvTFdl?=
 =?utf-8?B?LzloZmRRM2s4TE5CUDFMMUJjcldpWHZOS3JjTnBVWm43N08wYWFVK3lHOU5D?=
 =?utf-8?B?YzZVRHRya0tQdnhFbm9kN2JmOUxZT1lkOTBDNmZZUjNaazZSMzZQRm9aak5X?=
 =?utf-8?B?Uy9odlpTRmpFcE4rN3JxNFlrV2MrR3hDZUVuei9zZGJMTWtmRkpZYXljUkFp?=
 =?utf-8?B?YWl6SGtIN3BDVU5IS3ZkVkFlMjdaRlRmVDNvUFhBdHRwNWdIV0VyenhHVEtO?=
 =?utf-8?B?RkJTUDJFcUZRWkZaV2M3VmZMN29hekpPakUxNmJNTFd6WndJSHVjNklFeFY5?=
 =?utf-8?B?R0ZmL3M4V1g4UW5VZFFlelNhMXh6OVdLeGRMRnBoNVlzc01namFEQWZvaDdn?=
 =?utf-8?B?dXRpbk1ncCtGQkRsV3NCUjVVZG9YWEg0QktkL2o1bHZMMkkveWV0b2RnU3By?=
 =?utf-8?B?ak1CQStINnhUajBTL1MvOGFUUTdmUm9taUFFekZXakk1Yk1qQ21Bd0NaUnpY?=
 =?utf-8?B?djFUNE8rSDNOSEFmREpyWUd5YWN3MmgrZ2FVUmh0aDFRdUkraFR1ZW1kVGxC?=
 =?utf-8?Q?jxFjtq5Z1CQ2n1rgaNlKDibZQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3ef434-2cff-448c-d7dd-08dba9662e87
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 14:34:13.7593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VQFLFnGLwY7vUXqyZ9pH1/CNQWuRlR8mgwFy72gTNyzsVrZkUZ4FYqAZmgQ5yck6+qBfEz/e0swVyHa9fw1dfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8130

Jason,

On 8/23/2023 9:03 PM, Jason Gunthorpe wrote:
> On Wed, Aug 23, 2023 at 02:04:13PM +0000, Vasant Hegde wrote:
> 
>> diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
>> index 8cbcdb9c1669..2e5ca4847eda 100644
>> --- a/drivers/iommu/amd/ppr.c
>> +++ b/drivers/iommu/amd/ppr.c
>> @@ -168,3 +168,53 @@ int amd_iommu_page_response(struct device *dev,
>>  	return amd_iommu_complete_ppr(pdev, resp->pasid, resp->code,
>>  				      resp->grpid);
>>  }
>> +
>> +int amd_iommu_iopf_add_device(struct amd_iommu *iommu, struct device *dev)
>> +{
>> +	unsigned long flags;
>> +	int ret = -EINVAL;
>> +
>> +	raw_spin_lock_irqsave(&iommu->lock, flags);
>> +
>> +	if (!iommu->iopf_queue)
>> +		goto out;
>> +
>> +	ret = iopf_queue_add_device(iommu->iopf_queue, dev);
>> +	if (ret)
>> +		goto out;
>> +
>> +	ret = iommu_register_device_fault_handler(dev, iommu_queue_iopf, dev);
>> +	if (ret)
>> +		iopf_queue_remove_device(iommu->iopf_queue, dev);
>> +
>> +out:
>> +	raw_spin_unlock_irqrestore(&iommu->lock, flags);
>> +	return ret;
>> +}
> 
> Please assume the iopf rework will arrive before your series:
> 
> https://lore.kernel.org/linux-iommu/20230817234047.195194-1-baolu.lu@linux.intel.com/

Sure. I will rebase/rework patches on top of this series.

-Vasant
