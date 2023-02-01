Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A0E7F4
	for <iommu@lists.linux.dev>; Wed,  1 Feb 2023 05:20:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WpjAwdXbF3vmsozpTOxuhO0IikCHoWvbLR9jBk2miJIJymfTYWGxFjPFxwowV6ljkc3GqlLBJW04dmSLY9Cz+h+CHujEEBvfb1FROCEYOUEDKz0cNmOzkBZkuK9rvKzhAVl0b3E2G/zZ1P0SxaGAkxKTF7JA2dNoYQ10m1ti1xOWQJrqt5XauUpKf9whgwUoyTZUz7jgiZL3iOjOi6OouvXuLpNrHZlwMn4zp3M3v2w4O1iZXiZ4T1XYiIjptynv3OrI/Dx2mXTjW9+Jl7Lqm2iYHZuzs7SUdddFAwPxFq2gXWeRke+Lle+F/KbHvcaqq/uHcM0n/3bgpRSqB3AV0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LoasUMQIHN12AncWVdQIieZjoVdRTSNFaFMXHOOEcjA=;
 b=CaL/+P6Ke2T1llUZSU3I9QPub9OXObeVq3c+1ysRn11o0J4OM1rXl+0pu0n5GzES49Bfrc22WtWFeVXmWna2vmoks4+c0ZC0pJI3htszntCwpDexLxYPGQ+hNRQze6U4l36PWov8UzhIDviEmvoxGgv9TPPQ3gsGkUE4841Q0pfx0SrKGkUTEFgQ0Ino7IGoslJUJv0qTQRjasHrIxiUjG8g0ZvXHhVZjkg6bCG03JWkhInFMNuRtRVEYs1iGMvvqE690zJXIz+OWFthEQe+RnkCytxqSlOT8UqBhR+jSzdhbGp5CKx4Ohgi34Ns9km8HRYq0o/vnjsDaJdaVWiwZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoasUMQIHN12AncWVdQIieZjoVdRTSNFaFMXHOOEcjA=;
 b=pt4J5TeXJSeme4TXeZwzlGwA+/5RZbAIEuUlVoIZNk9oKVa3CLzPNlmZ8zOUDHReNLGtiCxlZIL75PzZxGyMW8hXjK6Awy2sot2P6poqWbSP4Ag6lpvLYc0GvY5pHRPmTDC7tMUJCRptdWsbYpUsCGs/6xi/RXvEJx92ivnl3xQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA0PR12MB8325.namprd12.prod.outlook.com (2603:10b6:208:407::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Wed, 1 Feb
 2023 05:20:06 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::4014:79ea:392b:b4f6]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::4014:79ea:392b:b4f6%3]) with mapi id 15.20.6043.038; Wed, 1 Feb 2023
 05:20:06 +0000
Message-ID: <4750852f-53ea-719a-cc03-e2da34e5782d@amd.com>
Date: Wed, 1 Feb 2023 10:49:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/3] iommu: Attach device group to old domain in error
 path
Content-Language: en-US
To: iommu@lists.linux.dev, joro@8bytes.org
Cc: robin.murphy@arm.com, will@kernel.org, suravee.suthikulpanit@amd.com
References: <20230113135956.5788-1-vasant.hegde@amd.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20230113135956.5788-1-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0157.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::12) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA0PR12MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: dd765142-f7d5-4fd4-285d-08db0413fac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TkAXvWYyodFhG4L7m4kxyVEORQ0t0dAPNoIqqy6VMQFVBhfjibt2Ar1Dczl3U0iYJA71aZbmnuFkxtGhazdegpswQ7r/ldFQ2VDESdp8GeAYQUrDgOXh+k8JRV8ZNsIcR+XcF100rJ/fBO5RrT+yZq6AKvZJJSq9FvzqdnHEfaewrGd0y0qC0sHxsqlDvKRzvuCwDgngz1DkebYJ4D6rhZkEvAmX7U4503EBbMTrOP9luiNUngm7mh+LAhBHGVPMAiN2OAQZoUZbg6TDBMrA9U227R7EYdicHWQm/n3GQLKPtsepKknkbf/9aogXqpi99pJte8/3gwYudnLiUz88enjrXmlfHN9mFdcuoGvCIXrRLdyKcQc9Fxyin1uOrAPr/lroRpg0PDWmZvXYblGgURwFkoxVq+ANLK4+O5syglFCL+nP3IAndyLAKcj/Zv+YVDQG1v20hs6WEPeRPQ5+UgCR1MX5hjkayE5R9hV6GTiqbetyZM0DlRZlz/IPgRF2U2QqptSC7P+p1FcC8vkS8kfShqaNCMuWc4AH5io4CfxhvXRKA083EdXWYxTxoQiBEGA/98M1M76Ao4vUrRnC7OpBHdKb3i8nFXIE2q1wlLDPgVvrbnkZxdNEsTl8rJE5ZJOWBr9IWoo8LBzP742aQrivFy+f2ohw1M0x3cyAWg+BUpnI9dE0xmPVXh2B7Wi1kAKlfERY3YxJHfshlDeMQ8oR6cttDiGoBBYjdH7LxYE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199018)(86362001)(31696002)(38100700002)(478600001)(2906002)(41300700001)(6666004)(6486002)(26005)(44832011)(2616005)(5660300002)(4326008)(8936002)(66946007)(83380400001)(6512007)(66476007)(66556008)(53546011)(8676002)(186003)(316002)(6506007)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXJtUUhSTFlCTE95VHpVaTBGcmxBQjlUV1p4OFRYQnFFaVRYbkRqT3dzVm1J?=
 =?utf-8?B?OWRCVWJyUmVIdnBhcmRaRWx5czVVenMyT2FzZGY2UVhSczVvSHY4RGxkQjlJ?=
 =?utf-8?B?SE40cVZxTDBIN3Y3YVg0RXVBMVNJNkxyQWJrRU1XUldOSVZJVkVuZ1hZN0Fh?=
 =?utf-8?B?emVNc3VnaC8wZE1oNTRFT0VNL2IrZEttYk9kYURaTEFWMFpLVmROVDEzMXNk?=
 =?utf-8?B?T1JDQXBDaVFLc0xJaVZMYWdsTG5zSk5hakJCNmd3bGlEZUhMVXkyNHkrc2kz?=
 =?utf-8?B?Q3F5cTFOMEZ5bVJrcWM4bDVjV3l4cDVhY09oT3BST1huc2JnMElTckoxc2Y1?=
 =?utf-8?B?YnFVN2RCL0dZUC9TU2hUZzdUUlZUSE9yZDlJU2pUQy96U2Q5S2hVYnNFNEx3?=
 =?utf-8?B?MDFPY2pJSXRjNThLVldtUWVPd29MUEZ0akk5emR1ek1qUWdxOWZucG0wUG9r?=
 =?utf-8?B?NkJKOUtNNk53TVJSVHNaWC9Ta25FR0xKWWM5NFU4V0NwSDQvUFFCV3EvQ3RQ?=
 =?utf-8?B?VEo3MlExbkppajNEYzlLYlNXeHV5UjBJeFcrZW9VN1ZHRVFHeHpYcEQxUGho?=
 =?utf-8?B?aXhNb1BZOVA0N0J0RFBaMXhEY1pJRzhXaXU3UnlZS3pobENzOEFtUWdGSWpj?=
 =?utf-8?B?ZUYza09YWmhwT3FheE9Td1pHNmVzYlFmK3FJaTA5Q1ZhNWNzVDRVL0tqT1lL?=
 =?utf-8?B?UlVuRGcwNm1SSDZ6d2ZhWXVzY1IrMFFDOUpLMlpSZGRSaUY2NmVDa0hLSDV5?=
 =?utf-8?B?WDRkaHkrL210TzNoQ2VoMG9Wd0tFbjc4aExQL0V3alJzc1NWZGR6QlNPdUlZ?=
 =?utf-8?B?bVV3WlN4N29UbUhXOW5EQStRcTV3b2c0QXpsVEoyak93bzFrRnZnejZib1hP?=
 =?utf-8?B?YzJpWFNpQlhxeGFITkJYSVJRYnozWXdiS0VvOTAreFlGYndQbUZlMXQrL0Nv?=
 =?utf-8?B?UU1iZGRWQWpaN1RsUlg2NFkvNDZwaFRIMFB3bHVoWHJGMG4rdS9SN2l4ZEIz?=
 =?utf-8?B?cVdEblRwaHp2VVZXR3V2NjRBVkp6SFFSYmtEblJGbVpjbjNRMUpucE1ycTU1?=
 =?utf-8?B?YjBhdE5rWCtQK1hiTU9FQW85em5sNFoxZ3RDN2l6RjJDalZMZnl5Y2NPUE5T?=
 =?utf-8?B?YjRrS0F6cmxZeUEwL2s5cElmOEhjd0JPb2p2TVBPZHlNeVJlSHdramtKRWpy?=
 =?utf-8?B?QTVOeEdEWkFVdXFhMzMvbGErZFJ4bi80bk14NDkyenNIRGpsdW8weWhMZjhV?=
 =?utf-8?B?VzdkYlRTVEEvdFJOMytwUEl1OTNsSTF2ZG1xYkUxdlc1bjdsaEN6TkNlSW54?=
 =?utf-8?B?bC90QWJWNDROUjJ6Q3ZHbkRnUXNlS0o0eE9tQzdmSFZMV1VoakllUnBEWDQr?=
 =?utf-8?B?TVQ4bUVSUExFUGdjTkxnZk9OLzF2UEJIYmxVNEVhZ3dDNmVXdmpPZVZESHZs?=
 =?utf-8?B?Rk96bDdUeGpaUk41MWNJMzl4YVU2cG8vNUhlSjlXTzlweWJnb3BCT3NqeVpk?=
 =?utf-8?B?dnk0VU1tdFEzUEhkZXluOFh4b0lXMDdFRnNZblEyOGFaQWRlV0Y0aWhMK2xZ?=
 =?utf-8?B?V05VL0V1OW5ucjlCMkc3QmNoZXZVRWhjMnFLZTZOT0lnakhqYXBncUhFZ0Fn?=
 =?utf-8?B?VkhrbFJWM1cxck5iU082MFRKbXhOSnl0OWxGSkRwWTRXSkU5ak9sYUlWNmd2?=
 =?utf-8?B?VHF5bXdIa1ZHdTJ4SVFGSVd3U255dllmS3Uvbms1U2YzUGJ2VVdkVE5YSmgy?=
 =?utf-8?B?Z3pQdUJDQjA5bUUrNjQ2MVM0dXJXNWp0eXczazJOb2VxeHFoV3pScDhpMmtG?=
 =?utf-8?B?N29LV0ROaXhDeGFpVysxeEx5V0xnd0Y1U05Bc3JLQy9XQXJvdUhyRmhCWDh4?=
 =?utf-8?B?cm10cjFxcUxTYmpYUFBWcTM2aXIzQXpyTnNvZiswNmlUUlI1ektHMDNSbzVx?=
 =?utf-8?B?QzF6b1hWTmxmMzA5N0phdEFWak5rRXIvbnc4WmZ6enVFak9OakUxSGhzSmp2?=
 =?utf-8?B?OTVlWlA2QWtvUUx1MVpMSmIrejZsK2o5K1U3LzgrejNRQUphb2crL3czcVFX?=
 =?utf-8?B?RktHaGpwaEhBbmJRWTAzUHJDd3orOHU1eXJlS3dQUTdBK1JEckl2UVM3WE5p?=
 =?utf-8?Q?64fB4U7damfFbKSdn06zNjiXG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd765142-f7d5-4fd4-285d-08db0413fac8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 05:20:06.5273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: guSOawKysNM/yoMA1Z6lxKHdR3eHQi/j9lE5lxezM4dDYVs77vnAj0J1Y9BvlhWKJ3Lqkm986PBT97OqDMFe/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8325

Hi Joerg,

Did you get chance to look into this series?

-Vasant


On 1/13/2023 7:29 PM, Vasant Hegde wrote:
> iommu_attach_group() attaches all devices in a group to domain and then
> sets group domain (group->domain). Current code (__iommu_attach_group())
> does not handle error path. This creates problem as devices to domain
> attachment is in inconsistent state.
> 
> To recover from this situation, we need force attaching all devices back
> to the old domain. This patch introduces `force` parameter to
> __iommu_group_set_domain() so that we can attach devices back to old
> domain.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/iommu.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index de91dd88705b..e58683cd3bf7 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -95,7 +95,8 @@ static int __iommu_attach_device(struct iommu_domain *domain,
>  static int __iommu_attach_group(struct iommu_domain *domain,
>  				struct iommu_group *group);
>  static int __iommu_group_set_domain(struct iommu_group *group,
> -				    struct iommu_domain *new_domain);
> +				    struct iommu_domain *new_domain,
> +				    bool force);
>  static int iommu_create_device_direct_mappings(struct iommu_group *group,
>  					       struct device *dev);
>  static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
> @@ -1974,7 +1975,7 @@ static void __iommu_group_set_core_domain(struct iommu_group *group)
>  	else
>  		new_domain = group->default_domain;
>  
> -	ret = __iommu_group_set_domain(group, new_domain);
> +	ret = __iommu_group_set_domain(group, new_domain, false);
>  	WARN(ret, "iommu driver failed to attach the default/blocking domain");
>  }
>  
> @@ -2124,8 +2125,16 @@ static int __iommu_attach_group(struct iommu_domain *domain,
>  
>  	ret = __iommu_group_for_each_dev(group, domain,
>  					 iommu_group_do_attach_device);
> -	if (ret == 0)
> +	if (ret == 0) {
>  		group->domain = domain;
> +	} else {
> +		/*
> +		 * To recover from the case when certain device within the
> +		 * group fails to attach to the new domain, we need force
> +		 * attaching all devices back to the old domain.
> +		 */
> +		__iommu_group_set_domain(group, group->domain, true);
> +	}
>  
>  	return ret;
>  }
> @@ -2164,11 +2173,12 @@ static int iommu_group_do_detach_device(struct device *dev, void *data)
>  }
>  
>  static int __iommu_group_set_domain(struct iommu_group *group,
> -				    struct iommu_domain *new_domain)
> +				    struct iommu_domain *new_domain,
> +				    bool force)
>  {
>  	int ret;
>  
> -	if (group->domain == new_domain)
> +	if (!force && group->domain == new_domain)
>  		return 0;
>  
>  	/*
> @@ -3135,7 +3145,7 @@ static int __iommu_take_dma_ownership(struct iommu_group *group, void *owner)
>  	ret = __iommu_group_alloc_blocking_domain(group);
>  	if (ret)
>  		return ret;
> -	ret = __iommu_group_set_domain(group, group->blocking_domain);
> +	ret = __iommu_group_set_domain(group, group->blocking_domain, false);
>  	if (ret)
>  		return ret;
>  
> @@ -3222,7 +3232,7 @@ static void __iommu_release_dma_ownership(struct iommu_group *group)
>  
>  	group->owner_cnt = 0;
>  	group->owner = NULL;
> -	ret = __iommu_group_set_domain(group, group->default_domain);
> +	ret = __iommu_group_set_domain(group, group->default_domain, false);
>  	WARN(ret, "iommu driver failed to attach the default domain");
>  }
>  

