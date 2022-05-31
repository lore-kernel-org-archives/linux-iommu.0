Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81191C433EF
	for <iommu@archiver.kernel.org>; Tue, 31 May 2022 11:34:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1B9C241BD7;
	Tue, 31 May 2022 11:34:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hOGJ1FHN5qwJ; Tue, 31 May 2022 11:34:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 84EB341BD5;
	Tue, 31 May 2022 11:34:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6737DC0032;
	Tue, 31 May 2022 11:34:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81082C002D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 11:34:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5FC3082A95
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 11:34:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 07M0updI5Sz5 for <iommu@lists.linux-foundation.org>;
 Tue, 31 May 2022 11:34:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::620])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DE0AA82A5D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 11:34:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmMKKgPxrbS13fw/T1jUUKCPd/v1fkbe3f2b+P9uUAMdrRI9tG0YEhBY1vlqzrE/w1T0IWwQ09pZCtE9v9uwhJekSqFNS72ijdSxOQRvlfjawAlHdv5+hdnij+Hz8F28np3YoepgZSMQYLkhwgxp75PdJcf+7XfSy0TC0MNhI5Jjgsw+57WQh1P/Mj7wQf3D3tITFAiWhKwu828dMJ3ErR7jFQ/NJlPS/7UVybpZIfsfSv3NAIBD3W5YfyfMKdOPcOV5Re2THD1CUBN2xUjyoGmF/u44tgw2fJW33qcU0xOqVBW8p06ETxSMVBDcZNPB1GXmcXl114VDSnykBj8Qeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8eUf6vOp6I+nnVncWd4Fs1FFcZcdG5/kYdEnvCS/sE8=;
 b=fXwO6PbT7UNn7mhq3Mb0gWuDLQxrCuVMlbx/eXJQaBy4cX6Wcw2Z/jiLk8AU3Ifq/evKlF8eCzWF3m9OYgIRp9j2ADXDmgb3w2u9YiFVZNU5WFK081lsdWtkxkpxuVzDjx35gXqLhpVlk5gh2/LPRyEytQQmx0yjdzlT2p3c7+AcjHY8gNQTUqMtg7BfXA93QAYJUCiVHAsb/CBqcfv99Xad9c19sWLAgfXedUDu5wVg/26+UmqYT8ofNKZt3vE5G/j5ScC1eMoitgA7VYGJpKIUfpRjHNGcV5gQX+dC+6VXvSOoXp3zNTXHiEBKCbeAof6HHxL447jcZqsc+xUKYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eUf6vOp6I+nnVncWd4Fs1FFcZcdG5/kYdEnvCS/sE8=;
 b=dPeeMP7B85vc7+JlcB9DcsQiJoe+KP6UhPIXEUxw7kvL0efCy/8eJlNXnu9xwDdBh6nGfJr6gIIOVgMV4rlL1WGx/yjyWmeH5hM7dPVKytA0kZ7zRPYJzmBSDtO3tzkpjeloOCFbYUTvSCr4QicaFwEY6YXqMHugbM5lMG0OfYM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 PH0PR12MB5484.namprd12.prod.outlook.com (2603:10b6:510:eb::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13; Tue, 31 May 2022 11:34:48 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::8c27:b470:84f9:82b8]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::8c27:b470:84f9:82b8%7]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 11:34:48 +0000
Message-ID: <efd6a8ac-413c-f39e-e566-bb317ed77ac4@amd.com>
Date: Tue, 31 May 2022 18:34:34 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH RFC 09/19] iommu/amd: Access/Dirty bit support in IOPTEs
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, iommu@lists.linux-foundation.org
References: <20220428210933.3583-1-joao.m.martins@oracle.com>
 <20220428210933.3583-10-joao.m.martins@oracle.com>
In-Reply-To: <20220428210933.3583-10-joao.m.martins@oracle.com>
X-ClientProxiedBy: SGAP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::18)
 To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d95b8c1-231d-4eab-3e02-08da42f990ee
X-MS-TrafficTypeDiagnostic: PH0PR12MB5484:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB5484CE28B9E2FCED8EDBEBE4F3DC9@PH0PR12MB5484.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tGJJgiEJ5ZF++AemzWAyAq11/BeuKBX3DA+OvR/TQ3FkANC23SWo3cl24bnmC95+4guP/72O0oMRGZ6++Uk4ZSf3SIb1QbKgWUaXMGaHSg47QEGH9aaJYX3jStq0keN9xbcMbvjMvLpTcIceGniBUi0x4lhVejhPfd42dozWoIc1bdXMolvI9850moVBG9jpILjE5upefEN/YmIpH3IVjivGsBPrsHEtFvAHkB/luso2LAOA06+Y7CkLEsy1oi/93SgW8pp3g7nNmT3+EPIhMxvQJOxXFq/5fxZFw/AA7663NN6MarSQwpoDtG9mOcpLN3EpYjk2jW+RLHc6f6DM9had8ZgzKH+54dm7AA9rpbwBh+WAc7nTLXg4QDD/ImuWMBwaQg5+z2mbydMaED0fQ4PxFF0z3irTgDJbdKNikkBLv0as1y8VE8i8HVaREsrdmEBW6bKe9hvlc+9ib0+mABhYiyqU0I/Ra7VB+3C5K/DYjLUWfKbnhvLht7/mnBoPWfXyT353w5HLKMBeYcb/bVuFZ4Hh5g15u2RI5KZfIVKdwl/aKylckGkv5xScL+SoLJBnyi+saS1jVs0xp/4ysRra8PwOK7yARXuww22TN1LQ3iilhkKU8s02a3YT404pu4xCKlFVHFEG0JgqBgVJPuuBJYTfm8HKGuCG6231/EpArZRzpWteJJQ2VrXkPhePQgpMIufpWrjRmedWZ3kXVeClv5QwQZZLslxqZWrC9RG7Gt2MCmgwCdbJzNF3utwJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6666004)(2906002)(508600001)(8936002)(7416002)(5660300002)(2616005)(44832011)(6486002)(6512007)(86362001)(31696002)(4326008)(66476007)(6506007)(66946007)(53546011)(66556008)(8676002)(54906003)(83380400001)(316002)(38100700002)(36756003)(186003)(31686004)(14143004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVRWNWVtYktXM0N6UGt2cmJQS040Z0FEeGorOFpZOEpHMGpVQUxScUFRVlY4?=
 =?utf-8?B?aFNwUVM4UFRyN2RZakhGSjFsajBqcStCVTVSZkdDV0p5TU8rRFJTdnhGM1dH?=
 =?utf-8?B?c3lzQnVTMlhtNjJrTzZvbWgrR29GOXZ0WitYbDhsOGxhWCtNTHBuUzJ0L1hV?=
 =?utf-8?B?M1AvbWUyTm9KN3VObW4xYXg0NUhrM1hGamVBMStDM1J0RnJwcVg0QW9jbjZJ?=
 =?utf-8?B?a0hUVnFqb0k0NGkvcCs4U2liMjVUc29RVVRxVnNMbUpZMTk3N2JVcDRaNThH?=
 =?utf-8?B?ZTh1aHhRR2s2NlRNUGdPNFU3b1pUWFd3aXdTKzYrSTIyYVFqd3RtaUtxaWtK?=
 =?utf-8?B?eXdKdExXSWhDeFpYSGk3NmdVa3daUVNWR2VEQndPd3grZ3NaaktDaG5nZnAz?=
 =?utf-8?B?VTBOeDR0QkV0dEY5TkxlOWxDaDBSVy9mbWp0aEJ4N1JWRXFLRmhFUnlBR3pz?=
 =?utf-8?B?NUpoZjZKck1zcVl2N0FQRHlVaG9Vbms1d2FwNkQ3MTN4SG00V0hjUUZ4My9v?=
 =?utf-8?B?dkhacjdCWWxXc085Qk9heEpBTHVTdWk4ckN4VDhCMWlMQTRZYXFIQ1R1aXZa?=
 =?utf-8?B?TFF3WndJakZKWmRDNzF0c0JzVEZGSVhWZ3dCRVB5OVZCQXFoK0l6cmxybGVa?=
 =?utf-8?B?YW9ScncrVHlyZHJZY3dPdUl1QnU3bU1RK080NW9DM0xJSVY3RkVzMy9HYkpV?=
 =?utf-8?B?ckRZdUhLVmZTS3ZrSkNrVmZEYmNsanFBNzlMRDF5QkdKWE4ya2V5eFRlc2FL?=
 =?utf-8?B?bDZWbC9uVy80bzZsMnlZUmNFRTZOUDF4a0FtVUN1T3NHZTlCaHd4dlpmTlRm?=
 =?utf-8?B?cGdTYzBITDlJS2MrZDMyMnRmRUx1VmpnRUIyT0VzdXRyY2xudGNCY3lOYnA3?=
 =?utf-8?B?SXI2NTFRQVNoR0pYWHJ3NGZCeUJGckFvMS9HZSsxZlVOK2g3dWFpTEp4NmJH?=
 =?utf-8?B?YTNPNk85d2dMRGVpRUtkRWhtL1Vtd3E5V1pPQ0VWUHE4dkcwaXM3R3o4YlNH?=
 =?utf-8?B?WWR3MHkxckt1NGsvb3VmN1FlSUlFcEtsY0JOSmphZFFJMmk1SVJtWHBVdGMr?=
 =?utf-8?B?SXA5TGdDbEs2ZGxubXZndzBrVUthUTBIUWViSmFUUWZqeUVEc2Voby9lYzlU?=
 =?utf-8?B?anBhS0hYSHNwdXBQRWo1NlRIWkJpSDdyQmYxTFpUY2IzekE2UWRpbXBOSVNQ?=
 =?utf-8?B?cGZ2Vk1IUTdFZ0FpK1BFeC9MN0xWdkZqQ05LOFhCMy9GOUxRc2NwbS9rNkhm?=
 =?utf-8?B?clhtSHZCaXZqZEp2cEQ4M1NGdmxZVG52VUFTNjRNWXUvcnhpZGluVWRMUUg1?=
 =?utf-8?B?UGEzUUdva200YzZkVEFDWGhqSm9LWk5SVDdyWTUwa0lXbjAwdHdTY0hPSDVY?=
 =?utf-8?B?bVN1TjhMWnM1T0NwRFNTVjRNcEREMTUxdnkybWxoZC9yaEtYcithOTRiWnVF?=
 =?utf-8?B?VHI5aGpLSkN2ZThWR2lrRFd4d2d5RU5MN1NxSmhtRElmL254aHFjR0puTUw3?=
 =?utf-8?B?U21nYWhiUG5zUWUrcjdzM2lORFlLeDdhZnFDWE55bUt6a0dVeDU4WDk4MmtT?=
 =?utf-8?B?b1hndFh1aDdrSStEK3NiYTZCSmg4Wm90dGlFRU1BNjNrU01uN0JPTnl4RXpo?=
 =?utf-8?B?MnBRck1qc1JxY2wzQkpudkhqMU9ZR3d5SEg3aTlpOWZBRXAvS1hlTzA5aFgy?=
 =?utf-8?B?Sjc2RzIxeCtERG9QNWVSem9GYmFWOEd2cUNUYTFSMWZyNzVFN3hHRnJXWE9Z?=
 =?utf-8?B?RUpyUkgrZ0NiODN3TU9STGJVbjRyQnF2VHh1QjZzVU0yK2JhQXl4anN5S1Vj?=
 =?utf-8?B?OHpyVHQyV2FEWFRzcDZMQW1nQmc5cjQ2T0tGejRweVluN21iSCs2TDZ0UzlJ?=
 =?utf-8?B?ams2eTNzUUxOY20zaDNQdWc5WG41ckpjUDBxSHlwaXlzWElrU0g4L3ptRkJO?=
 =?utf-8?B?Y2NvVnUwcGlUMXZiekNMU0pPTms3cTgyMHh1ZTRaOUJidkFCYU9HdTNWUzhy?=
 =?utf-8?B?SjBVU2pJM25pdGk0dkphTmRYTHN4NC9EK3YrOTNudW8wZnFZc25OYjl1QTFr?=
 =?utf-8?B?Y1JtMDNFWndGZzJodUdBdEh3L0lwcG11bTBQQWo5NlJyRFhmZzF6UWprYzlp?=
 =?utf-8?B?WVhJbUtISUo1QVVMSmZmcmRyNmNPbmpLaTNnamxiVldLTCthcldZMytCMDhF?=
 =?utf-8?B?Rm84ei84MytmUEppaSsxRFRqMC81ZXFKa2liTm1YRy9kZ29TeDVwejVKTk5i?=
 =?utf-8?B?UkdqcHJTWmdwMzZRZ3hUVERVNnYzOUtldk5VNGxaREtlV1ZKQXdCbkV5ejMw?=
 =?utf-8?B?OW14Q0YxcnQ0Nm9LSFFGQ2Y0T0M3SjJjeDBVNTVvN25pOFR6Mk5PK0tTdFNr?=
 =?utf-8?Q?qXmpe+w60iO5oExdaL5lcBO9T9jtOI+2B64FL1ZCjf6VF?=
X-MS-Exchange-AntiSpam-MessageData-1: Y9KhjB5cBKM4jw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d95b8c1-231d-4eab-3e02-08da42f990ee
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 11:34:48.1087 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C1kzZ3CF/OgC18ZYXIzbxjZ4D/WUpGUhTs7Er9Vv5KUtFsyCa3757jXqibRrBTbQ+01+HP2Y7w+9pdHYO8oj4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5484
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Yishai Hadas <yishaih@nvidia.com>,
 kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 David Woodhouse <dwmw2@infradead.org>, Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Suravee Suthikulpanit via iommu <iommu@lists.linux-foundation.org>
Reply-To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Joao,

On 4/29/22 4:09 AM, Joao Martins wrote:
> .....
> +static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
> +					bool enable)
> +{
> +	struct protection_domain *pdomain = to_pdomain(domain);
> +	struct iommu_dev_data *dev_data;
> +	bool dom_flush = false;
> +
> +	if (!amd_iommu_had_support)
> +		return -EOPNOTSUPP;
> +
> +	list_for_each_entry(dev_data, &pdomain->dev_list, list) {

Since we iterate through device list for the domain, we would need to
call spin_lock_irqsave(&pdomain->lock, flags) here.

> +		struct amd_iommu *iommu;
> +		u64 pte_root;
> +
> +		iommu = amd_iommu_rlookup_table[dev_data->devid];
> +		pte_root = amd_iommu_dev_table[dev_data->devid].data[0];
> +
> +		/* No change? */
> +		if (!(enable ^ !!(pte_root & DTE_FLAG_HAD)))
> +			continue;
> +
> +		pte_root = (enable ?
> +			pte_root | DTE_FLAG_HAD : pte_root & ~DTE_FLAG_HAD);
> +
> +		/* Flush device DTE */
> +		amd_iommu_dev_table[dev_data->devid].data[0] = pte_root;
> +		device_flush_dte(dev_data);
> +		dom_flush = true;
> +	}
> +
> +	/* Flush IOTLB to mark IOPTE dirty on the next translation(s) */
> +	if (dom_flush) {
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&pdomain->lock, flags);
> +		amd_iommu_domain_flush_tlb_pde(pdomain);
> +		amd_iommu_domain_flush_complete(pdomain);
> +		spin_unlock_irqrestore(&pdomain->lock, flags);
> +	}

And call spin_unlock_irqrestore(&pdomain->lock, flags); here.
> +
> +	return 0;
> +}
> +
> +static bool amd_iommu_get_dirty_tracking(struct iommu_domain *domain)
> +{
> +	struct protection_domain *pdomain = to_pdomain(domain);
> +	struct iommu_dev_data *dev_data;
> +	u64 dte;
> +

Also call spin_lock_irqsave(&pdomain->lock, flags) here

> +	list_for_each_entry(dev_data, &pdomain->dev_list, list) {
> +		dte = amd_iommu_dev_table[dev_data->devid].data[0];
> +		if (!(dte & DTE_FLAG_HAD))
> +			return false;
> +	}
> +

And call spin_unlock_irqsave(&pdomain->lock, flags) here

> +	return true;
> +}
> +
> +static int amd_iommu_read_and_clear_dirty(struct iommu_domain *domain,
> +					  unsigned long iova, size_t size,
> +					  struct iommu_dirty_bitmap *dirty)
> +{
> +	struct protection_domain *pdomain = to_pdomain(domain);
> +	struct io_pgtable_ops *ops = &pdomain->iop.iop.ops;
> +
> +	if (!amd_iommu_get_dirty_tracking(domain))
> +		return -EOPNOTSUPP;
> +
> +	if (!ops || !ops->read_and_clear_dirty)
> +		return -ENODEV;

We move this check before the amd_iommu_get_dirty_tracking().

Best Regards,
Suravee

> +
> +	return ops->read_and_clear_dirty(ops, iova, size, dirty);
> +}
> +
> +
>   static void amd_iommu_get_resv_regions(struct device *dev,
>   				       struct list_head *head)
>   {
> @@ -2293,6 +2368,8 @@ const struct iommu_ops amd_iommu_ops = {
>   		.flush_iotlb_all = amd_iommu_flush_iotlb_all,
>   		.iotlb_sync	= amd_iommu_iotlb_sync,
>   		.free		= amd_iommu_domain_free,
> +		.set_dirty_tracking = amd_iommu_set_dirty_tracking,
> +		.read_and_clear_dirty = amd_iommu_read_and_clear_dirty,
>   	}
>   };
>   
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
