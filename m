Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66B2383B5
	for <iommu@lists.linux.dev>; Mon, 11 Mar 2024 11:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710155526; cv=fail; b=gQJJLW0ZCq1A/tfdh/Myw8XNdTJlzvgvElBbBfL816uH+5IoQ9B8K5u9J+A77f6FAlK7M7w/DGfA+gujKEePc1EaWdDsTHr3U3oyhN/474GKGtpWa1g+JdWGTCkGO2O1tOHtA0a48TTmizLC5Wn5DB1wU1VLhlrV1idEWztodNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710155526; c=relaxed/simple;
	bh=A3IVn0y5nbQufssBEigSYFgiqPF8K9dldN2jjPj87dI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EL4dqoTZW7jop/uxJ9Qay86l0U4+Mw7uSPcpkG1F9vpKpq0vTwja9L42VTi4QB8oec7izARr8rslsXyXsy0DsN1Kaufr1hZYoGzjboPJvZqPCkiKxLHU8sDcCTyQQa+80cti5BhGzJw50rpeDhfuT3VNnwXtdeeavny9kiritpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=spYP10BP; arc=fail smtp.client-ip=40.107.102.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="spYP10BP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIulJAVi0yc2VhqSswKgo6vo0v81mMnAvyUjuYQm26fqv02Cd0JPiNjRp82Vh95Zj//p23b4eH/i6vGT/1eCnzyDpXf9npKaEK4XTmNJXeMbrLLB5884eF+rPE3ZYhSfEKWeDICcmzqVokQBESIAXotmfKeslbyUMPFluoB/z8r06+TPBRtgkGFDwpNY1lBHAvemVIcRZYz59zeW9e0F8QtbshIsKG/yR644QtepaniQpaefT65L/ONp8eE4PlbClxFnRIG3vhHFUgFqhgTrUKzpZmXf27sV9QMqCArjXm9gZ1DA3ZRR2IBblVw+VIBO9xi6WJEKEla+sZGu2paWkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sby/ri3LNzWPqJ9U+gHmtAWykpAzMC3XxTFRxoe1aRw=;
 b=FpdOS8USpgXGuC7eQ9pQPe/YoVBcjgsIW70BQ35zBME6XIakNDzl1lyJS6rpgBx6llV5bhrs9utKy8e2hZBDLpquFa+C7vRaEQB6GHA1RXwN//IGITm2JPL87quRnpdZsZk4zkZxxMbkEb+qTEh6C3CLA8uJZCy2kiT/BQm87nYaQgDp21uxW5PqM2eXRpP+dIo4eH0vKneJzTVkyD1BRHSn8vkC/fiacEMHfFclng42Na9aUTfIxX/05dyM2gT8fI77+WGrhdHtelFgQ5Z60z+NCAKZn3+K75qgVCs110JnZW6f/F0RQLIXleOdNv1nUUPouuwRDgLUDlDKzp4zew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sby/ri3LNzWPqJ9U+gHmtAWykpAzMC3XxTFRxoe1aRw=;
 b=spYP10BP3r9TGBVJfxcEct9Ucyk/ic/EREh7D0k6tC2bHFM2blTpZkE9A0NqAUvamucf+9/FKq3N/Npb4xhL2WU/LvHvn/fX0ewhC3dnBvteSrap9PDm5BUcR5j9tofaDKfcg8cOdme6fHcQh76qfTbKwTN/uBhZq6qhsOZTqf4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS0PR12MB7511.namprd12.prod.outlook.com (2603:10b6:8:139::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.35; Mon, 11 Mar 2024 11:12:00 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::d709:cb7d:2612:bb27]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::d709:cb7d:2612:bb27%5]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 11:12:00 +0000
Message-ID: <0ee69ffa-564f-c298-2a66-b4d7d4440856@amd.com>
Date: Mon, 11 Mar 2024 16:41:51 +0530
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
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240305005053.GH9225@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0024.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::30) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS0PR12MB7511:EE_
X-MS-Office365-Filtering-Correlation-Id: eab839d2-7214-4151-168b-08dc41bc12b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JF1e5ABWxZRVTGK6dVeqW22jlvALTUfXT38TQBd0llN+srK8PnWt2b4OMObpOMMnoOEm+hVUkbRxkAZafSoRUWUqGVnCKDUfLqoNsBjWOhsUmcJiufDNdvkyC+tk/ceO0B3SQzHyrw1zTeCCtoUk7VZ0XhmEZ5WriRLqzagSe3KdG7mTemtM7PUzggPz9qm72s48cUnNfnEMHX2zpxhu5uxz7h9G5o31AOt+B1pGtgEYhquYHi2TSKYsaFrx31yZlIumJqmKlpl69C55p6QJLCcQu5DALK2YCHFHMVIi/vX/gCmShUwTc2H1gWMzdBvDNY2cLcwnqlfWhdETrHu6Teg7SequPlkjumG33xcKQFahVDZYRwla9QKaKkWF8K5IMXmb+SWLg+F1ZZyKxg2A3kAVklhvyDEkCRyQWzMoKVa1XhFxPm7ejIen2dYbvpTddl58Mq8Zu96XWGieKgyADBuqjtUG4g4Vytlj5AEroh4v4SJoE7KaWAfkJpY2L1nP84F5zwxKOwlUVTlJ53oSefr8uLj+IP6fBW6jg+/Yi14nMHeKodDlwnuG0FZohJNSf27rR/Hfgp1bNffk/83Zflh89azVbU+PfEpWKcw5HX2PuUHDj8lOdRaKRRBjVKBhpozTxza9LuA8fv0LDvqlq6jU1SIVOWLtTFd2KOYQs0Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGJtMnJNWkhiY2VlMVVibzBxZTNsL3BqZ1RUUTFJME5PL3BhWUZrNzU3UWpw?=
 =?utf-8?B?K3JzQnpESHJoU3Q5RDNyWTN1bHRhQ0d4WklhUW80bmdub1gwMldWdkZ2TTJr?=
 =?utf-8?B?QzhJZFF4L2VDdm5lR3kxMVJYTk9zL3NpRzBSWHJvSHg2RkJKcVJPMlZHVHg2?=
 =?utf-8?B?VnpGTlNxNE0rL2ErNloyRGpCR0VXcGtIWnFYay82MGhENWVieTN6OTIxVHh0?=
 =?utf-8?B?eFRUa0pSWjRxUStIajNickZuZ0NsTU94NmNZQVlMaTdTRWhLdFVaaEhjUkhP?=
 =?utf-8?B?L2lrTWxQd0dmZTZtbjBvc29BMGYxUENTS29NRjFzY3lqZWI4MU1yS2MxTFp3?=
 =?utf-8?B?RkxENk5uRi9Xei85eWtIZFZwTkd5Zi96RzdDSDNRWmppOGl2WDJMazB3cjdv?=
 =?utf-8?B?Vzlzd042WVpNZms0ejhzVWVYSjU0YjU5dlVjdEl0cmtiQm1YRU45a1lKUlN1?=
 =?utf-8?B?M1FIVEdkOFF6Nmp2YWtEbDhnOHZCNUJWVCtJN3RROEMzRHBtdnZ3MjE0YUdS?=
 =?utf-8?B?QnJLbXd6KzB1S3IyVkNVOWVSWkNVcnZYajNEeEpmSkhhYVgreDNjR0UyWjlJ?=
 =?utf-8?B?TG1mZlREVTFNamlCTEpVbHpyWXlwZFBpZTUyZC9QRDlscVFiYXRrMFArQVRJ?=
 =?utf-8?B?SXFQMU1ZMmNMT3hBVjlMOUxwUURZZDloSE9xK3o2SmVXUm40OVlIeGFpTkl2?=
 =?utf-8?B?S0dFeDlKTG83bEVSNmEyZDVudzd6U3B6RnVpbm5nWHpXMTh1bmZvcm1LNmw5?=
 =?utf-8?B?dnozSXN1QXRQcEJ5SmpiZmR4bi9TWFR0TUdVSTRVaFJWN240VWZ4RjVWU0pt?=
 =?utf-8?B?S1F3M1dyQjRsNHZpcXJJcEZSY3BPczUvQUtiaWZsYlhSbzZMNGZIbm9tZDhu?=
 =?utf-8?B?Rk1EMUM4THVsTUNxdmZBVVNCdUpQbVpBalU5WGJ4alA0cElrNm8vSisxazc1?=
 =?utf-8?B?OFlCRWkvd0I1Z0V2OG9KNXdNcERCZEdTcSt0ZzBwVFFFVnByT2QwMnkzWlJ6?=
 =?utf-8?B?SUhLZVlHSFZwYkdsM2xRVENvVk16akhTK3IzTGhBTjdzcTJhd1BqY0ErNGxM?=
 =?utf-8?B?Q3JUeG55Q290SDVFb1REa3o1STEvaXlDRzI1anF1ZTVUclVkaEZnaVZ2MEk2?=
 =?utf-8?B?ZmpmNTFiYThFbHRaS3JrYld6bjNrUkJYRUxtNUpuRDFpcFloRzN4SmNsaDZ3?=
 =?utf-8?B?TUlqWThNOW00Y3NPQWlMUlBwNTNxZm52U01TYkFQSk85d2NyY1Y4d3l4NW9T?=
 =?utf-8?B?Wm1SL01UL01aajh3TENRTjdOUmJ3RnNDOVFWZDhWazdVa2E1WVA4Z29uR21U?=
 =?utf-8?B?MWxvelJ0emlQQWFFUXQrZkdDQkdCdjN6YzdrclRjaXBueEh1NHExdEcxcW9i?=
 =?utf-8?B?NWg1L3gwQjlZeTZBNy84Sk54TCtvYzdsLzlSQVBTUDlnbWZDUldPNnhhQ1Ru?=
 =?utf-8?B?Zkk2a1BNQ0ZUclgzVSt5VEhDaXdId1g2bWx3L25SRmVsVlhQc1BtbVgyMXZh?=
 =?utf-8?B?blZuZW9SM1hBQVE5ZWlvVk8xakg2YXMrZ2t6dGgyYWwzM2EzUGpSLzJZdVk0?=
 =?utf-8?B?dFFRRkZ3NEdwdWtiMlpuS0svMUdpUnV5LzlhTXJpenRBQXNXRnA5WU5JVysr?=
 =?utf-8?B?RmNJYjgzaFZVNVhlNzQ2TGZ1Vi9QdkRmdi84MytUK1Jxb04xaXg0enlHaHJn?=
 =?utf-8?B?bnRZV09JaWxsc3U0OGJuYVp1bVFvc0FIaHBNRDV0cTdKMWZ0YlRZeCt0Wk1N?=
 =?utf-8?B?Nm9WUnBhNEpEZHlFenFXbUhPMyt6dzd1SHVSNU5JRXU5bzVicjIycVdraXBC?=
 =?utf-8?B?dlBGS21FSFRLUE9aeHRIcjBwNThSNzFDS2w2UHlZUms0T3NwNjVFRWRZNDV3?=
 =?utf-8?B?bWhidkw4TllDdWhVa1RIQ01zV25wMHlscElQVitldVp2Z1NPYWpJZnFTQUdL?=
 =?utf-8?B?NHpTVHpNOFp4a3p2WnV0aWpUS1MrTXE1REUvbnlXanlJWVVtNzhCTHRMTzNX?=
 =?utf-8?B?QU1uZnFrZmRkbGtheUlYN3h5UEdRRW1ZVmpTYUxqZElweFhidkRaSjY3RGpm?=
 =?utf-8?B?K0VZdW9UNXM0eEkzcXRBdTVwK3pScWRXbUhwUGtPUURhL0k4QUFndktIRDFw?=
 =?utf-8?Q?szIQZ7r8t1EYEFOABJbKxDiIB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eab839d2-7214-4151-168b-08dc41bc12b2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 11:12:00.6885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6dWxqIneazM8T8nLwdDsWmXTZ5xXmIfVWUnijVCMYMsi9zUcw3WFCaxNaO8XaCFQEx9+50N1392trzhr72b0AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7511



On 3/5/2024 6:20 AM, Jason Gunthorpe wrote:
> On Fri, Feb 09, 2024 at 11:29:28AM +0000, Vasant Hegde wrote:
>> @@ -560,6 +567,16 @@ enum protection_domain_mode {
>>  	PD_MODE_V2,
>>  };
>>  
>> +/* Track dev_data/PASID list for the protection domain */
>> +struct pdom_dev_data {
>> +	/* Points to attached device data */
>> +	struct iommu_dev_data *dev_data;
>> +	/* PASID attached to the protection domain */
>> +	ioasid_t pasid;
>> +	/* For protection_domain->dev_data_list */
>> +	struct list_head list;
> 
> 'item' is a much better name than 'list'

We have been using 'list' in all structures. So I just kept it same.

> 
>> +int iommu_sva_set_dev_pasid(struct iommu_domain *domain,
>> +			    struct device *dev, ioasid_t pasid)
>> +{
>> +	struct pdom_dev_data *pdom_dev_data;
>> +	struct protection_domain *sva_pdom = to_pdomain(domain);
>> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
>> +	unsigned long flags;
>> +	int ret = -EINVAL;
>> +
>> +	/* PASID zero is used for requests from the I/O device without PASID */
>> +	if (!is_pasid_valid(dev_data, pasid))
>> +		return ret;
>> +
>> +	/* Make sure PASID is enabled */
>> +	if (!is_pasid_enabled(dev_data))
>> +		return ret;
>> +
>> +	/* Add PASID to protection domain pasid list */
>> +	pdom_dev_data = kzalloc(sizeof(*pdom_dev_data), GFP_KERNEL);
>> +	if (pdom_dev_data == NULL)
>> +		return ret;
>> +
>> +	pdom_dev_data->pasid = pasid;
>> +	pdom_dev_data->dev_data = dev_data;
>> +
>> +	spin_lock_irqsave(&sva_pdom->lock, flags);
>> +
>> +	/* Setup GCR3 table */
>> +	ret = amd_iommu_set_gcr3(dev_data, pasid,
>> +				 iommu_virt_to_phys(domain->mm->pgd));
>> +	if (ret) {
>> +		kfree(pdom_dev_data);
>> +		goto out_unlock;
> 
> BTW, I'm not confident in any of the error unwinds around command
> execution failure. The sync failed, it doesn't mean the HW didn't
> already load the new CD table entry. The driver is basically totally
> wrecked at this point as it can't assume the new entry hasn't been
> read and it can't assume the old entry is flushed out. :|

Yep. This is tricky path.

But for now this particular one just adding PASID to GCR3 table. So if we enter
error path means we didn't add PASID to gcr3 table. So it should work fine.

> 
> Otherwise looks good:
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks.
-Vasant

> 
> Jason
