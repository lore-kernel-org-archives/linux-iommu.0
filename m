Return-Path: <SRS0=3kXM=IU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05D5C433C1
	for <iommu@archiver.kernel.org>; Mon, 22 Mar 2021 04:25:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4137061930
	for <iommu@archiver.kernel.org>; Mon, 22 Mar 2021 04:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4137061930
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DEECA82F2D;
	Mon, 22 Mar 2021 04:25:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ygYzXAJaa7pT; Mon, 22 Mar 2021 04:25:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id B7A2B82DD9;
	Mon, 22 Mar 2021 04:24:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D24BC000B;
	Mon, 22 Mar 2021 04:24:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81C08C0001
 for <iommu@lists.linux-foundation.org>; Mon, 22 Mar 2021 04:24:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7CCCA82E66
 for <iommu@lists.linux-foundation.org>; Mon, 22 Mar 2021 04:24:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9kPVpyg4ywnB for <iommu@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 04:24:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690076.outbound.protection.outlook.com [40.107.69.76])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2854882DD9
 for <iommu@lists.linux-foundation.org>; Mon, 22 Mar 2021 04:24:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eolPOVxh1nalY431XSdkfN7tHeIHi7aA/AhNZgSphpZ3lYGwCqyJigUVH7wxoxEJb5cTj0haCgSLQ4TvncSQtfAKJB47VI0Ogs61Zouz/FFpMNF+Go/Ak+mvbSPpBBn1Nsv/lXrwNkqnV8LJ68BZwahn0EUZ4MFAMZdC77RpARVLksfLNGX4zNmSKN3KU4x1kxV/qej53nm8SDykrjn264wjnJht4fIrZUgNVg4ufWeC65hJdDTUdrMFHWD25DQOJVISKfgWwrch70OGNd1Lz2OZMLCRs+jux3atPtPG3X/n1FQ2fSMyKCEH+YFl1Yv7buMrHfUYhf5wKA/6ZHHM0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cx/ht4X5sltsWPSNei4BJfd73rZnK2yxgULEFdbD/6o=;
 b=iJXP9JuollpHeHFJaKIKM/JFtIFUa8qrkJ2TwuFswx8tRDS/5AB1p+F0uHJTwQSVuZ37LbI1hVJrJqSF7gcQH+ojyPu/54uIU/uWg8IRBCEAOc8KpqmtgbNV9aRYFxBw/fe6ZvyU3OFU5TyvI9xeiAn56ktEybDK6GcZQonHCukVqQi5jeoiRaOefWrTSj6bgJwdQkSwohKTyALEpa00S8+hbThYCFwB6roOFwD0tLNIad6/RmrBaTEgFRIFKvtSLSd/YtomypuR4ataSGASsLsl0KEps16g6sUeyFs5Ml0XDPZ8N6CdH7et2ejRFQUUYh9w183NEnPckdyZG9+hBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cx/ht4X5sltsWPSNei4BJfd73rZnK2yxgULEFdbD/6o=;
 b=YIQIx3x5q2/6K6JagvOC4EcQAoGx9oADtWZ6KmFe57Ym0O5wiu0AUPID6ATzMLhAAsgfgdR+nSYUU57kTkn0YLSjvdIiBCeDDvL5bL3RsYX08pLYMhBnfpE7hoFTfZI1/kTQ+DsV2+b/xf+IellbfOmc0g8Gfn9KtIbVp71QruI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BYAPR12MB2837.namprd12.prod.outlook.com (2603:10b6:a03:68::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 04:24:54 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::cc86:d78a:bb1d:5109]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::cc86:d78a:bb1d:5109%5]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 04:24:54 +0000
Subject: Re: [RFC PATCH 6/7] iommu/amd: Introduce amd_iommu_pgtable
 command-line option
To: Joerg Roedel <joro@8bytes.org>
References: <20210312090411.6030-1-suravee.suthikulpanit@amd.com>
 <20210312090411.6030-7-suravee.suthikulpanit@amd.com>
 <YFNy0LbQAreu64lt@8bytes.org>
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <a6c856c9-fad3-b7a4-6f2b-1b4566767f63@amd.com>
Date: Mon, 22 Mar 2021 11:24:31 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
In-Reply-To: <YFNy0LbQAreu64lt@8bytes.org>
Content-Language: en-US
X-Originating-IP: [27.55.95.156]
X-ClientProxiedBy: KU1PR03CA0042.apcprd03.prod.outlook.com
 (2603:1096:802:19::30) To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Suravees-MacBook-Pro.local (27.55.95.156) by
 KU1PR03CA0042.apcprd03.prod.outlook.com (2603:1096:802:19::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.10 via Frontend Transport; Mon, 22 Mar 2021 04:24:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a75de296-bda4-4684-c152-08d8ecea710e
X-MS-TrafficTypeDiagnostic: BYAPR12MB2837:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2837A4F6B8E86871F0235684F3659@BYAPR12MB2837.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cvJ8+IVOFqU8eGWa40Brek+KPla8k0wf6zQySGZRopR/F8A/NWATkwZuvLenNhClWZzWi5sfrxQiPnS3YAc7v2k34T0AGd4mgkhu5TyYkOKAsJGE27BDLJmaslB5fVyOpLgoHkRTc+Cyy5R4xIQTcTXwdOjhVDwSzEKjaSHGR07OINIF30cfis3Wox3edJg4xbXcd2Gb/LWGYFgKRCtf1ej3KOGcRGOLc791mwnnevT1IDpyhyg4oWkrdhqJydedgYMse1N4tTRMRVpPANOLYpjVaMB9inK+LjG6/6wyYhNDyHi1ylHsbQCGo4aprI8U8yqzesVaBmO3tXUyhkou6C3+VsHQvo/aC0FtPfnQXoN153DW3IgVJRkUE0KVxZt0OtKh8ael+oSYGh2IHVkRaMBLPvFJdmKGD+0IUffiG8hE8onV8mF4fve6ga/8tHNkIVTuijhfqwqO0dVjylLLZb9ABrQdqyhQmAgRCk+/fip7X3FPkVHurFGKeJa2gADeZG1vE2A8Iqw/A47peQ+DexNJG7KOARJ7VqmgEDUzSR9itDG/hpHE6xsvApTKH+hZ2X9g2Zof1wUpUD6S+UtYF6IaKaqedPljo8kC2lnF//tZdHHxb+vBmTf8B/w89xFuYNY99S0/be6LeTHLKz+PnxqnMXzI/Mg024vacEz+781tO+gbFU7P+UPivQnivt+nhWXwo08Q5tMzIvZUtjYaFMNZbf67A0m7M610vE8L0qg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4597.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(66946007)(31686004)(2906002)(66556008)(86362001)(66476007)(31696002)(4326008)(36756003)(8936002)(186003)(16526019)(26005)(83380400001)(8676002)(316002)(478600001)(6666004)(956004)(6512007)(2616005)(38100700001)(6506007)(53546011)(6486002)(5660300002)(44832011)(52116002)(6916009)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?emZnSEpVTjNlU3JNNndHV24zbDJxVVRaTUs1bTJsMmpNa1dqNXk0aXJ3ajZU?=
 =?utf-8?B?WU9mb2tYM1VTNk1iN01KcEZvVU16YWhjd2h4NmZPeUI1NEI2V2dQUjllUmxz?=
 =?utf-8?B?ckFCNHZOU3NlZ1NLNEpiRUtuRkhPVHNsMXlpY2pNa1NoK3d2TmVKaUFmdDhz?=
 =?utf-8?B?bDhqMGtxUjNwK1RlMWN0ZGJFNGplQlluVlFGTkFFZ05xY0hqOVJUQlBNMmlX?=
 =?utf-8?B?ZDRLS0lleTM3SCt4b2YwN1N6TFhnYUlvOW5xdU1VVFBFRFEzQ25rM3ZLM0xu?=
 =?utf-8?B?SUZlQlJtZU5ZZkU0eXkwa2xnU1VYQ2oyVmw5WjU3cDFpTlhuQ3R1dzJQTVo3?=
 =?utf-8?B?VXVINks2cVM4YXJDaVFKSzVkU2FGVUpieC9OMmZKWlRBQmV1ZG5NRFZKWHZ1?=
 =?utf-8?B?V3JpRWYybk01WGtYaC83anI3aEQ2VVFxWldVWGx2OUU1bjcwWnY5RGRzbEJv?=
 =?utf-8?B?d25CT09nTUw2RndnRzNmMFlMUFltQ2xpRHRYQ2NWK1hRVHV2SlQxeGtHOGVk?=
 =?utf-8?B?NWV2Y3VoOHhpK25PZnFqVldPQjJKRzZURnQ0RVVkWDV4ME9sY3lQeDNKYVpt?=
 =?utf-8?B?dUdyeTBiaHJ1OFdYa1dVTzZISytrUlpKaFpwY2pPbUtLM2dNcWtTYXNYZEw5?=
 =?utf-8?B?NDNjQWt5YVlIWDBsS05ndm5HOGhFMXBkMnZNYXlPakVnLy9yNUpVdDBWWjNT?=
 =?utf-8?B?djJBYXZjczQyYnlsVkE1STVobklqMDNRTVB4TXYxWElORUV2N0lLNFdQcnUx?=
 =?utf-8?B?bzZiNnVmY0VmRW9SYnRjbDBKcTVXSHcyOE1ueHNqY0ljTU5jMzYyTGR5UjAz?=
 =?utf-8?B?ZndlUW1ZM3VhRERGRnNFS3RqQktsbGg5b1FheFp6QkY3L2g0Wmc5SUpNNHhS?=
 =?utf-8?B?SVQ5U1ZFOVNpVjBpVmVBS2U1TGlxRVIyak9ZdzhLVVdVdzk0QVpVMU5ZVU5m?=
 =?utf-8?B?dG5VNVBieEpScytIbDJ3TWp2TlF2RmtTd2FNaVJlTkJEMUdOcTRYcks4VlZs?=
 =?utf-8?B?bXBoemV6c2tNcldQYUxiNFpKQStGQ2sxSHpselVlTmo2STdhLy95RXJFdzhy?=
 =?utf-8?B?VzNoVnp1aVRYZWE5d0RWOWFLdDhKTUVHUDhNZ1BIQWhwbVR2V3FPdHM1YzRs?=
 =?utf-8?B?b0N1R1JuaS9pSXhXUDlZSVZFWTJ5eno3RFlucHlsZzlheHptZHFvbkdNMW9V?=
 =?utf-8?B?SGlLTUwrVjhmNjY4T2VpdDBVbk9rc3J6SWU0cnFuV3R6allxN2l5RGFwN0dD?=
 =?utf-8?B?L2JZK2N3ZE15akxZcGp0NEd3Z3BKUHFNcUxYcUp1d04xVW1CandMZkR3b0sr?=
 =?utf-8?B?d092VkhvdnZ1dFh2RFBHUVVKczJ6SzhEczcvNWRkbGR0Yk9zTTZWWkg0cmNJ?=
 =?utf-8?B?RkIzcVFlQlpnMEowUkpHN1ZtaEpkei9QamJSRkJSNmpEM0ZXSW8rck1wajFq?=
 =?utf-8?B?djd0emY0MVRIbkgwVDhuZVV1K3pRN0xBV1N4cEt1bVdlYTJuaUxuZnlLNTJu?=
 =?utf-8?B?ZUwwWUxzVndxT2F6MklyeWxYbkJKS3hlQzlodkV2S0NqZjFQR2RqYUJ0aTBk?=
 =?utf-8?B?eWUxUnhIVEluOHVObDdIYkpRU1VjNFAxWHpvOTFES09ZWEtpMXNVWFh2cWxo?=
 =?utf-8?B?NkF4NGV2TXEvTmRiR0J4RFFqdWt6eDFVSHZ6WlZkUDFJWENTWjNmT1hiUnFF?=
 =?utf-8?B?K3grZDQ4U2Q4RzUwY2RJcExjSWxXRUg2dk85bkpiN0piL2FlbmtDQ0wzOGJk?=
 =?utf-8?Q?BuJDoCboB4xtHeomOr4ljreE4ZzvaJWtapDsxey?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a75de296-bda4-4684-c152-08d8ecea710e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 04:24:53.9238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: foYDrOsRK6RFokWgLglvMM186uSY0C34nV31NaoJQBSSZpkgFAX2cefafLd37w+Nz256FkU/2SSziX8OgZfpiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2837
Cc: iommu@lists.linux-foundation.org, Jon.Grimm@amd.com,
 linux-kernel@vger.kernel.org, Wei.Huang2@amd.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Joerg,

On 3/18/21 10:33 PM, Joerg Roedel wrote:
> On Fri, Mar 12, 2021 at 03:04:10AM -0600, Suravee Suthikulpanit wrote:
>> To allow specification whether to use v1 or v2 IOMMU pagetable for
>> DMA remapping when calling kernel DMA-API.
>>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> ---
>>   Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
>>   drivers/iommu/amd/init.c                        | 15 +++++++++++++++
>>   2 files changed, 21 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 04545725f187..466e807369ea 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -319,6 +319,12 @@
>>   			             This mode requires kvm-amd.avic=1.
>>   			             (Default when IOMMU HW support is present.)
>>   
>> +	amd_iommu_pgtable= [HW,X86-64]
>> +			Specifies one of the following AMD IOMMU page table to
>> +			be used for DMA remapping for DMA-API:
>> +			v1         - Use v1 page table (Default)
>> +			v2         - Use v2 page table
> 
> Any reason v2 can not be the default when it is supported by the IOMMU?
> 

Eventually, we should be able to default to v2. However, we will need to make sure that
the v2 implementation will have comparable performance as currently used v1.

FYI: I'm also looking into adding support for SVA as well.

Thanks,
Suravee
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
