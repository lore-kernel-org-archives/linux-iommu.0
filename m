Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2080.outbound.protection.outlook.com [40.107.102.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FF4D534
	for <iommu@lists.linux.dev>; Wed,  6 Mar 2024 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709743476; cv=fail; b=CDR8cs6GIKwLqlow5tu3R21hoj1+2KHIqkPN/Rvb0aO1L7r9mJy3VfjxuPfIUqhEf/0A6zI2UaKgK6Fs9QW/jb1gg5rX+wTuESQ8pB0bSmw2WzxTSdNF/DlbiKArvZw9Jbexvp6RypQduabui9LNlDt+c4SBz5ckRj13d/5d2gE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709743476; c=relaxed/simple;
	bh=3td0p1QosglwBf7mLWWpWYDBCc8ulAmShRT8bTt2+oU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nU2rcdsbM9SFFnbRzLXVIdwW/qddSA5L6IekJH7hSs8PtQx5k3b7tOqvjpa8b+Na86f8IOEKRmGX5IbEwP0FC7Kb0YG3H5Zat1kSZLJ3GWko8WHA2GuHPuMe9D09rRNae+bn1hX3lwTSx2g3vXWvY50SkCBnOCxJ4Y4ECXkuzSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Yl3TIIPH; arc=fail smtp.client-ip=40.107.102.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Yl3TIIPH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKtjKccC6UFMOU+6bKadTdO55sK39IVLoPZLZOWfHoyMcuYfM3PQuH06TFqXIWUtKHXbqeP9PlI2YFXdmC5EjCoJpgnRVJa4rZIMY6S4jybX8LGsdUnNHiPNd1ZGNDBgjXN41nGRnkPV9vRr7tcOO/FJ31lB6FyBdahx5pMLbFVloHsbGdMS1ZaPN7/zYK5Dvo9TUJGH8SYwZ6ArOO46GaL2tytmPVaaGQjbAIIIb2jSeADTW73g+JL/e2mSzqjlzVuUL/2vRn7keDiOauDkT7SMK4YXtPlZr14sDVDuvzz6enExhuKVRyxygJnBvjsO/W5gGGCWLExbalxXWdwSmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8LQt9iMGRVWS855TVhxJ3onQAVrt0TJSIsQKNdk1VA=;
 b=YxuhpO7D4Re4KM9ZEHSGwU0QyC+e6vtIDW9JG/pb0Pst04v5ciOBnUqrlnmw2Luzh4+zIQofwXVTksav6ykEOvEvBZe+TmQ+Jer90PGEoQJqHaBuHlYyQ2cAMdk44VfoODUegMDeip1IwLgb3Yrkx5KAd1GBy2h5TqVLDmgKZpETrowwQ5ZBRnL02coRQ3IemvbkCyp2DuL4ApcIrTcpHwGGuh0kfG0jKiZh8zHQAD5T+2OMiN0FQ1R7gBpldPL5Hwy4vjaC97gT5/zqK6e30Jrb1H0YKToHa5g5UkWp+1I9Jcg3/J2lx9Gqm+Qn3KN6a1Uq/BTgW+kKCVJpJVGvMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8LQt9iMGRVWS855TVhxJ3onQAVrt0TJSIsQKNdk1VA=;
 b=Yl3TIIPHFV99VIAWkjEEzQIzVb0NqTrKCH3LCoBDTLIFd36hDjNFMRqXDsP1KaijT+tHsISvr+URoVcp3Fbo8BqCHea6tuYyP/7pWB4wvIqp6NrMjiBPkPIdWAOmXrpCEtqj+8Geiq0nQWPSlmZhWrPTrLsiHxi81+pKe4DMr0A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SA1PR12MB8859.namprd12.prod.outlook.com (2603:10b6:806:37c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Wed, 6 Mar
 2024 16:44:32 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::d709:cb7d:2612:bb27]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::d709:cb7d:2612:bb27%5]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 16:44:31 +0000
Message-ID: <45a509a3-6a6d-7662-47e5-181bca1e55b1@amd.com>
Date: Wed, 6 Mar 2024 22:14:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [bug report] iommu/amd: Refactor attaching / detaching device
 functions
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>, suravee.suthikulpanit@amd.com
Cc: iommu@lists.linux.dev
References: <41bd6e9a-19c1-43f4-8251-cc9e83737a31@moroto.mountain>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <41bd6e9a-19c1-43f4-8251-cc9e83737a31@moroto.mountain>
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
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SA1PR12MB8859:EE_
X-MS-Office365-Filtering-Correlation-Id: 42111056-08a8-4939-0830-08dc3dfcb277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wmhSrvwhJhKsO3Df0UTapxB/KtEst76DzyHAEK9nqtfDO/1qflGsm5ktFKkLwIhX2V5y7+D49QWSjnCjnn+8lkpwyyLrUWukNdozEDq8zxQbDrV5tqkWK+bwQJ01Ddwy180aTezJVvxBN+PhvnW8wS84R/7uMChbttwrMegIyXJ9QX+Eofo+cHF2K3nF4eGEFS89b8bMZBt911mLqksJ+TVTWKJ9WchDFIeskdYCsQNl2n6Fye22DHF17N+gQgf6vMOwkrk0qRM9INIdfbHHnN/yNDT4xr6JqGUPQy/07+EtHbHq+Fg3VYrjzDYHd3NGDCIDZjpNBEYbS2orU0xVjSy28zuyaetWNqCh5BP6euIOfoAKdm5mdiBXewi2QieifTFebiXB7BTQBUO0fE4eSQjzJKOaTJcDDxw5lQ7NOw3SGKU/Ygwx4fLgt4BlDRq83vIK+n7JlHwtEqT3676t0/J53Y4yZXKINhfW5qs/BuFrPlTZLYNv5u4YqAOK5QKP1peFMcOk9jtrCQsdjlWA14oGKf5btksXoFGoG8WT/50m2feR+4KoZrcFO9tBt4yDrE64MurMgD4i4CPwDr9SVnVdVkIpcMWbeVXqeEOcHTSG0YBjd59gusbP7HHYuDN/JKQWpP6asQaEevzNOXA0f3iERYaIQCfEjb78Jrvm59Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QktGUW5EUXNLNnFKd2h5TytwK1lTMGtTR3V3U0NnWWlVU1cyYVRXWWNyVUtJ?=
 =?utf-8?B?SGNrU09mZ2c3U2FUWUZBdVR2eFhDK1Z0YmRDSGpDYml3Q05ISHVPOHk5Nmkv?=
 =?utf-8?B?UVUwNkNkSDJYWWI3WUdYeEtjaEpBUVFPQlJMeGNLZnFrLzVHZWFaVU1OQjBZ?=
 =?utf-8?B?TFZJQzFYbTAwbE1aTzBQeGNrK2hCRUpuaVl5enUrUjVMUEJyUG9iWlEzZm5P?=
 =?utf-8?B?ams5dW1tdmVwWGthRHU4SEtmWTZZME1KZE54OGtja2w4RWhCQU1mTHNTVThS?=
 =?utf-8?B?WG1iZmV5SmIyR1hUeTZNeVhTWDU1QUl5cWxkVHJLUklBaW02OEN1V0xrTjVO?=
 =?utf-8?B?L1JNQTlINlQxVWdTTHNMOTJnVm5EMERIR1RQalBYU0lmTFBGQkc0Z1FKMUtm?=
 =?utf-8?B?TXJiY0FIak9TSnY5WU9wbXUrY0lURHNpUi95YThydmJlSnBHRitWdVpBdUpW?=
 =?utf-8?B?RWtZU2d1Nk1PWjZHZk93Y01DMmcxWHN2eHJZdVoxei9NazdjNTdwSDR4WGZU?=
 =?utf-8?B?RFNQeUlmWGVURFluUWpRbzZGNGZTakdwS3U1YWh2QXB6QjJjWnRpNXMrTWFV?=
 =?utf-8?B?TW1NOEsxSy9qL2pvVkp4T3pheGYxYkNVbEdtelFsbmkzR2ZHa0pka0V3Y2d0?=
 =?utf-8?B?dEQrM2VTZVlFL2ZDalBYWU1WMTJBOVZ2ZFRQYzQ4SmZ5NnRTOHVJWmJzOGsz?=
 =?utf-8?B?NjA1a1Z6WWJpV1lwaHFDcXIybUhRLzNzaE4yVlg3d29OMlpMejNDOUo0c1ZS?=
 =?utf-8?B?ZGF2NWdPUDgrT1JlUGp4L3NrUnZReUQ5bWswVHFxOHBRMjBGdVhMSWZoa2Ja?=
 =?utf-8?B?L0dLYmdncjVaYkVTUFhOdXp1RE5MbVYvYjMzMUJGd2pscVJaSUw0R0VqUVdH?=
 =?utf-8?B?UGMyNFBpQ3dOemRwY0tkaVJwdWF0M05mdThuR1RLZ1BTOXl4OTdPQ2F3bmtE?=
 =?utf-8?B?QkowclVibmhPejdXN2s2VjJkNS82cFRqZkpzdDh3blIyRXhDeFVtMjU0czIx?=
 =?utf-8?B?YnZWVmFXQWc0MjBSNUxqSWJVOXhiUTJ1VlR2cEhRQklOSlR1RjNDSGNBcjY5?=
 =?utf-8?B?QjNPRlF0a2M3N3lkVTVnVG1NanZEejdROGhTeStsZFZvM0ZZb0hmNndoMk45?=
 =?utf-8?B?UCtVNmlaQmxRSExFOXY3bHdVZG1ET1A2dXVtakdqVitkQTIxQmdCL3RqN25t?=
 =?utf-8?B?OUpXQ3QrbFRkbFBTL05jYjM0cHN3UEVKVnBRNmFiNXBOamN6ekp2NzdOQ3JW?=
 =?utf-8?B?VU5ReENoV2haSHQxbk9EU1lqVHJySXZoT3JKMzlJSU5kUk41akF1WFJSKy94?=
 =?utf-8?B?RGtPK2pwNWI2eStUQ29pYnhTb3hCcUdlMytoUzMvZTluVVhSbXdOS2ErblpP?=
 =?utf-8?B?UW9DMDV2VjBXdnI2c0xpQ240MXJnRzd5Y1grSUM2MTVSaW1xL1RDSW9ZQXFW?=
 =?utf-8?B?a1ZobEo5V1Z6cityM0UxMGJneUh3bXdDNGhtRm1LSE5MYzVqMlFkU3RlTkl0?=
 =?utf-8?B?VDQ5MWN3ZXJ3eS90am5DNXdOV3BlRG5wTU92eDhzeG9ML1F0aXV3UWZpbHdD?=
 =?utf-8?B?NU1penVaWkhUaFUydk50RmFxK3lGUWJsVG4wQ1FRNUZqSEVNTTNGdEZGUnhM?=
 =?utf-8?B?RTVrdTh2d1NmL1Z3VFk1SkRBYnBaVlhSMjdYMjVXRGx0Y09TaDZVT0twd3Iy?=
 =?utf-8?B?bnFWakFVQWJVcG5UZXV0SHp0Qlk1YzNYd1hOeTlvSXpUWHI1RE44dkVFUHFE?=
 =?utf-8?B?a3NScCtQVUpwZlBtV3VJVGdsbWlGNDgzS1pNL1RvUjBtQXl5MG8yODlBbUFY?=
 =?utf-8?B?Q25GbHNHWE5yMXU3OHAzQlVHbHRGSGpzYTNEUkQ2TWp3RTNQVG11Y0xxRExx?=
 =?utf-8?B?bGg0QXVjWkVpVmVESFRnTDgvWXJuZE9nYkliNUpXcW8xYVJXS3NkV1dDV05n?=
 =?utf-8?B?Z1FRS1JrL0E3NHZwZ0dlMnl2YW9rRFN1enlWdFBIVExSRFhnSmZqVHl2eEtN?=
 =?utf-8?B?UjBpMy9NaVpPS2hQcjVKZE43bnk1eFg4a29weXk5UkVGU1FqNjRnSFZSWmtn?=
 =?utf-8?B?eElLSGxjNTB6cEhUTTAvODZtREZ4S0JPNE5iaVJNT0YwL2NsL1gxbFNLVEYy?=
 =?utf-8?Q?6LBRmvTay0/qzXyvaAQCVtLqU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42111056-08a8-4939-0830-08dc3dfcb277
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 16:44:31.8600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N4G6homPZvKFe5iYu3YvwjQDQmrFj6+KpVeg2I/I6ootLw5hs10cr4XVgl7i7ILak8ZcTUQnjOHmbIpgqaGesA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8859

Hi Dan,

On 2/14/2024 1:33 PM, Dan Carpenter wrote:
> Hello Suravee Suthikulpanit,
> 
> The patch 4ebd4c7f2501: "iommu/amd: Refactor attaching / detaching
> device functions" from Feb 5, 2024 (linux-next), leads to the
> following Smatch static checker warning:
> 
> 	drivers/iommu/amd/iommu.c:1796 setup_gcr3_table()
> 	warn: sleeping in atomic context

Somehow I missed this one.

Thanks for the bug report. I was thinking of moving allocation out of lock and
use GPF_KERNEL. But we decided to rework attach_device() code path later. I
missed to revert this change. I will post the fix soon.

-Vasant


> 
> drivers/iommu/amd/iommu.c
>     1781 static int setup_gcr3_table(struct gcr3_tbl_info *gcr3_info,
>     1782                             struct amd_iommu *iommu, int pasids)
>     1783 {
>     1784         int levels = get_gcr3_levels(pasids);
>     1785         int nid = iommu ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
>     1786 
>     1787         if (levels > amd_iommu_max_glx_val)
>     1788                 return -EINVAL;
>     1789 
>     1790         if (gcr3_info->gcr3_tbl)
>     1791                 return -EBUSY;
>     1792 
>     1793         /* Allocate per device domain ID */
>     1794         gcr3_info->domid = domain_id_alloc();
>     1795 
> --> 1796         gcr3_info->gcr3_tbl = alloc_pgtable_page(nid, GFP_KERNEL);
>                                                                ^^^^^^^^^^
> 
>     1797         if (gcr3_info->gcr3_tbl == NULL) {
>     1798                 domain_id_free(gcr3_info->domid);
>     1799                 return -ENOMEM;
>     1800         }
>     1801 
>     1802         gcr3_info->glx = levels;
>     1803 
>     1804         return 0;
>     1805 }
> 
> The call tree is:
> 
> attach_device() <- disables preempt
> -> do_attach()
>    -> setup_gcr3_table()
> 
> attach_device() is holding spin_lock(&dev_data->lock);
> 
> regards,
> dan carpenter

