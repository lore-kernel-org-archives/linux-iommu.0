Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5890CC433EF
	for <iommu@archiver.kernel.org>; Fri, 29 Apr 2022 14:42:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 18342405D3;
	Fri, 29 Apr 2022 14:42:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w7jdoK5TOgVP; Fri, 29 Apr 2022 14:42:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EB8DC4000B;
	Fri, 29 Apr 2022 14:42:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C732CC0039;
	Fri, 29 Apr 2022 14:42:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A666AC002D
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 14:41:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 938A1405A6
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 14:41:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e_r9hdq9LgAI for <iommu@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 14:41:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::631])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A17F24031B
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 14:41:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7NIYM92Fvw/tMi34jzisnPI6Q2oTbVUpYfXknToD6NP5ZYjeWU7oEPUoxN4uv1ja03L2vWdK1k4xbjJ92yLmJ5xNQAqUAZJ099QcIMim0NSlj7AQRHKC01R+1iPnF1/vJ0I6VOVRT/enzSS9AyOej6d+2NSZhv1bLb0HJKyya7N9KciZ6x6BbYEbOg86+rW8hr+2kVoW8o4W1AvlCH0SZkkOoH2fHgTiMVVYcJ9VxKacS5hedKNjToBgl03YhvnQ1GKXeljQEVcogsqDURnRqCS8bLUJlvpVigSds02JII7WkeHGc53t2LLLHWeFu+a+6OOaaM8RI7OeEeU+MMbbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7iq/mlZx3D52b1eHpAODMe7RO+HxTb9jPs+Xu6bRWk=;
 b=TY5WQAHbQgvbuqjVfevgL4FllNK1j8PwbOBZA8edkJcAwJH86LGc+aPbjThbcJl6lo3eL4mnqdYw/moMvSjqzKzqvy3cv4A1nHjJf542vYbQl8Ln7oQx8oqD4XdXj6p5JlP8gVVzA4Sejkoalfa3YuJDMolIe2jdFMVnjOIib1wgDI648jHMYugMt7zTNDcUi9Mb/FNsSkhWZ4/MejR6x+5bdWcQP/p7ZEHGINDrBQEoXFK6Jl/eZtDHrRnuezxDdvTqcI3gasmZyGRjqgEgcT2vGrQeANJ0SpnpWAWKA7fa/GVSTDfybtcds2IJ/28SmiTeLhT22bxr2gaMLmSqPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7iq/mlZx3D52b1eHpAODMe7RO+HxTb9jPs+Xu6bRWk=;
 b=SH57fVI9NMNLCaMfoyeMiAMSQ/apVd546TPNoj4OMbbTk7TttLes6i9jBr+DFz+txkecDxv1yP2VhF7IwDaVWq9H5Kba0JrSyrZ1WagCNerfYwfPnO16lVTrKldzM5b+zUNIQhQPQG1pJ2rU/2F2R2cREEsWqkpF5YxNSbGwz9I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 BYAPR12MB2728.namprd12.prod.outlook.com (2603:10b6:a03:61::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.17; Fri, 29 Apr 2022 14:41:55 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::309b:a704:5e87:8ce1]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::309b:a704:5e87:8ce1%4]) with mapi id 15.20.5186.026; Fri, 29 Apr 2022
 14:41:55 +0000
Message-ID: <cacffb0d-04de-37f6-4152-a127c7ac6e5c@amd.com>
Date: Fri, 29 Apr 2022 20:11:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 02/37] iommu/amd: Introduce pci segment structure
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
 <20220425113415.24087-3-vasant.hegde@amd.com> <YmpkU4jvfd/1Sl6i@8bytes.org>
In-Reply-To: <YmpkU4jvfd/1Sl6i@8bytes.org>
X-ClientProxiedBy: PN2PR01CA0124.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::9) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15723491-66bc-41b9-58f0-08da29ee67fe
X-MS-TrafficTypeDiagnostic: BYAPR12MB2728:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB27288BF3746BEC90CCAF611B87FC9@BYAPR12MB2728.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qO1yVW1ic19Y2760FCbocSb6sZ+0+6anwFhbIuOVSDHrpDyUm8Vg/E9vlPcaL/i/PazIwymvllJ7JVoSLIbAX8FgsjnFgLsaP8xvvVnlz4urd3swp3faeg4uNXnoysKI0ql5HGufCXR2n+YUo5KJhocqiVpVsLaqGmmzHFNiLpm91vebBnENyRp0nI5kdSd2kTEnqxOYF8O2TdsoBdArr/7jw7DriLlQ3dGatkB0Lel63o+Ey4XJ0+V7q69ZHD+FbYY/hdLJW/J/k/+j8c9uB+o5k7Nqi3uCUyLvFbpKE0IjB0apvIzdJz2UuDol0JpJ8MFD4cX5mtMCH3g+VqxNylXr6OiwNKbj1ZR+SS6oVVODb7P0WxHMGr0SrDOOf6MwDIEXqc4cN2U/mjTOLBbVrkXT1IfZBEn5ZjWfmh4gF34zRg7ZRlzocXwLeYsyrVKf4OGGNFIj4E7961rNiqacF+Ao4JDhQs2mkxrf+V3jq14CB/ziAbCUMVsba8SEp2AZ+oZcK09JHT0emmQuZ6dsDpFMek2u2fHGO335tqcEtUuYjJxj18+2U0jjf5YSFapu7d2aa7ynY26LrR5lVITxBJHIYb5RNW+XLY9aHCb9c3yewlf7sYMETyB4TOmIM2LY4lajvSStztL6Iexdrxk+1XLqt2GwVxhL6FfIBGhKFgMumuzPkOzz6AtonUe4+SLyGgXt4Z6o19rFMMyopv+l+1/QVlWLPKXlI+DrI16kvBE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(508600001)(26005)(6916009)(31696002)(66476007)(83380400001)(6666004)(6512007)(86362001)(316002)(66946007)(66556008)(53546011)(38100700002)(8676002)(4326008)(6486002)(5660300002)(4744005)(44832011)(36756003)(2616005)(2906002)(8936002)(186003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTdkZVhVZ2NmaEZyY2p1amU4WXh2ZTRLbUhDYjVjWFVzYkJCaFNqUDdyVEtQ?=
 =?utf-8?B?b2ZUUlpxM2Vlem1aRnlqa1BXODJOOHJ5SWFjb1RkN0JSUlIrb1BOVzJiNnFK?=
 =?utf-8?B?R3hTMXIySFdoTVZEWTJocjJlcTUwYVlyV1dOOEFuS3pERTRrYWhrNW83Nk1S?=
 =?utf-8?B?MjR0emhXZUlOVm5XM1hKcFlMYlVqakhEMTBESW4yK2xWYzRORWlmeUE3bWc3?=
 =?utf-8?B?LzZPSitFL25Dc2pKS0F4bkxhZWMwa0VzQmg4N1hVSlkrUWM3cnJ1c0ZtUG1L?=
 =?utf-8?B?SVR5Q1JqMWZkYXZacEFIcEdNdzVFeFlERWl1cHowTnJPTG54aWQ3clBsY3Z3?=
 =?utf-8?B?TUZKdHdLRnBXamFlRzZNQ2daZ3UyY0h3Sk1LV0JxOUtEaGpyUE9UY2VmbkNW?=
 =?utf-8?B?aXgzUmlwS01EcWJieEJWSjZQYlhnZzI0RXJlanl1NHJVc0t5K043aVArTXcy?=
 =?utf-8?B?WWpCZk9tVG9Yak9VMmJ3dzUwczB3R2lIMU5RM3BoeEZuTjg3UjhicDdxTWxt?=
 =?utf-8?B?Z1ZHdnlaaUpNTUhtaGFSL1VQNjBhUmhCVGJIcTJQRzhnbXh5YmxWcGZ4NzZH?=
 =?utf-8?B?ZTVMNHBnODBja25pMnEvN0N2ckg0MmlRc0dJYkRIZjZ2bjhRT2c4UmhzYzg5?=
 =?utf-8?B?M21Bb0NNT0dTeVBSeUkvS00wV1JCUTdyQWZwR0RiNGRGOVZ1NGVjQzhyYlgw?=
 =?utf-8?B?KzhMUEN4eVN0bEcwTXRtN0pac05vSkVUWDVKTUk0RCttM25tQ3FkWGZPaFpY?=
 =?utf-8?B?VUU0Z1dtNzJDRHFjQ0Q0WHNORXhYT0pFeGx5TWhlQUdFcjZDTm05VFZVZkV3?=
 =?utf-8?B?clR3ZHlNZlpKZ0VvUWxvRjE3aWYxbnlyUXlnMXJvWXlxMjZQcXZHNXNuNjlh?=
 =?utf-8?B?ZGxmaTgzdW9RdVFyS0hmdVpmN08yaHJxYng0QXlJajV2aHRaWWNVdUE2TTFr?=
 =?utf-8?B?SWxWYWw3dWlMZGJBMmQ5L3pRaFpLRG5DbUdpbWxRaEgxTHVOVGJzeTRoQjRr?=
 =?utf-8?B?MFFtN21SM0lTZDg3QzlZcHVJMXNpZjcxL1VRYVZmczZjTm1aWlBmVzVzMXBJ?=
 =?utf-8?B?a3VCVkJwNkROMnNRQ1BEVnB4Z2VxSkFoTXVlWXNDVFIrZlowNStHcjJJTVJ6?=
 =?utf-8?B?UkcwdVpMbDRLalVXUmJQUFVzU0lNSEs3Q01zMDVObnBxUU5VQm9lUzRWYjlQ?=
 =?utf-8?B?WnEyOXA0NXdmQ0pkcG05cUhiNjZlM3oyemZqSDVhUFl2MEhZbVNPbEZld3p1?=
 =?utf-8?B?cFo3MVZNNlpVV3BkYUIvZll4T2hRdDE0VmUrSjBLc3VBM0RiUk80cHZNR2M3?=
 =?utf-8?B?dXlvNVlnb1ZLempwY3RLMFVzQXljVkNQMEpRdEtoY3ppckVpcEFVMkQzZHV4?=
 =?utf-8?B?QTFNYnVwbGV3NjFsOWRSeWphVUROdVZOWDY4UXdKNjl1MjMyT2gxR1UrOVcr?=
 =?utf-8?B?RTFlclE4bmpzSTNDSjlpVVVPa2NTdjlVSldLaXo2THpSWWFLZCt2VGI4Y3VU?=
 =?utf-8?B?cUhqUGZvdUZxUzJpUTYyYmg5TlVFTHMyT1M4T3RqMmZVaDZWQ0drbzJaLzYy?=
 =?utf-8?B?K1dNSTZMOXdXdU04dk9tUGI1SU53M29HWUE4UHlLYVRhbVozeWZKUHVFWTNE?=
 =?utf-8?B?dU5sT2VkUHNRVTQ3M2ZUbk9xNUhHOXpQQytSZXdSekFIY1RNVlI5dmZTSXpN?=
 =?utf-8?B?UUNxaDdWZ01vUml0YXdqRUw5cEdRU1EwS0ZJbDlnVDQzdklMSFpCSUFwbklo?=
 =?utf-8?B?MmFRVXNKRWh4ZnNvQ29VZmNWTFlxMTN3SndBYWVUK0hVZDY1cDVvVjdIQnBj?=
 =?utf-8?B?Yjg3Vnc2QURlZVNsbFYyRGYrQ25MU1hkTysxVVlKaVM5SEllVSs0Ykc2cHV1?=
 =?utf-8?B?Y2JlL1MyMzhoWEtOZCtCcm5uSENKcHIxS3JRbnFuRkFBYUNRNmtvZVk2bytw?=
 =?utf-8?B?UXhWcnM1UTRzVEQ4UVlYdEpFNXRPTk5QMkM2ZVZGaHZaZlRQQitwYStob1VM?=
 =?utf-8?B?YThRUDlnK2JrcitrSm1aS1hhNTBZUnpmS0h1L0pIbzJVNkxvc3hsdFpNMmk2?=
 =?utf-8?B?c3lSZlZ4V2h1MDBVb0xEcm1YanRMbWdBK0VOT2o5bVhwNVI1SXdKbXdtcnhN?=
 =?utf-8?B?UHhrWGUwZXBaYTYyd1YxSVpSd2pUVnNyU0lXV2kyWUg4RUkreEtXd2ZEb1M4?=
 =?utf-8?B?RE9icWJGdnBLOEQxOGRZckN3T0xrcHlmelNFcys3VkQzbnNQcUdicW1hR0Iy?=
 =?utf-8?B?NWIrOW1QOW1HZnQ4WnZoQk1tYXNOYnJZNDIyUVl3eHM0YXFxazJFcVJ3YWJH?=
 =?utf-8?B?ejU3aGtsRG9TcVlwU2hQMUVTS0RCK2NjSlNTTXdmUmFFbThpOFpCZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15723491-66bc-41b9-58f0-08da29ee67fe
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 14:41:55.2836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DL1WXkguJf9NRq9vTAnH5JKdQdoOGe5H2/VAU36/rc5wzz9zAli/Qg5VgdyZDGkEDTj3TSHPswYuq7h3DM9CKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2728
Cc: iommu@lists.linux-foundation.org
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
From: Vasant Hegde via iommu <iommu@lists.linux-foundation.org>
Reply-To: Vasant Hegde <vasant.hegde@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Joerg,

On 4/28/2022 3:24 PM, Joerg Roedel wrote:
> Hi Vasant,
> 
> On Mon, Apr 25, 2022 at 05:03:40PM +0530, Vasant Hegde wrote:
>> +/*
>> + * This structure contains information about one PCI segment in the system.
>> + */
>> +struct amd_iommu_pci_seg {
>> +	struct list_head list;
> 
> The purpose of this list_head needs a comment.

Sure.

> 
>> +
>> +	/* PCI segment number */
>> +	u16 id;
>> +};
>> +/*
>> + * List with all PCI segments in the system. This list is not locked because
>> + * it is only written at driver initialization time
>> + */
>> +extern struct list_head amd_iommu_pci_seg_list;
> 
> So there will never be hotplug of a PCI segment? Say together with
> hotplugging a CPU?

As I understood currently we don't support hotplugging.

> 
>> +static void __init free_pci_segment(void)
> 
> This needs plural: free_pci_segments(), as it frees all segments.
> 

Sure. Will fix it in v3.

-Vasant

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
