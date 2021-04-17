Return-Path: <SRS0=S5kk=JO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB73C433ED
	for <iommu@archiver.kernel.org>; Sat, 17 Apr 2021 16:39:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA46C6120F
	for <iommu@archiver.kernel.org>; Sat, 17 Apr 2021 16:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA46C6120F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AEA4E40272;
	Sat, 17 Apr 2021 16:39:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kYWr03HDr3Iy; Sat, 17 Apr 2021 16:39:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7D0C840001;
	Sat, 17 Apr 2021 16:39:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 429A8C001A;
	Sat, 17 Apr 2021 16:39:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06556C0019
 for <iommu@lists.linux-foundation.org>; Sat, 17 Apr 2021 16:39:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DAF5E4047D
 for <iommu@lists.linux-foundation.org>; Sat, 17 Apr 2021 16:39:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x0NDxY6FgOES for <iommu@lists.linux-foundation.org>;
 Sat, 17 Apr 2021 16:39:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750083.outbound.protection.outlook.com [40.107.75.83])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D0C5E4047B
 for <iommu@lists.linux-foundation.org>; Sat, 17 Apr 2021 16:39:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khxElySUEluQqP2D7CPByFXt4UOhs898e51DK38tqSTM/Pcuj9yMKBQBhsHHzy0OfmX/3mecebOq5UYrH4ZZ9qXyD7YofDPBd9wPMSEEtuQNjGx4KWHZh9qJ6iAruJBWV57fGiLFi2Y+d+/CZnMAmuRxZhLiumud1zrgKsFSo8qj7mMhcekRAC5B3iVoP9YS9M0ruF3Ky+HN23kor1vANioQ8UiaaL+9LpEYoZRtWLpJCdRKlUdJ7jkZuVcWFQz1+Mp2ieAZpzoP35TvTBlvzHWWplNVVYjiqJLNLQ3i2DR4ZW6etyAPXBOH61MvwtiYfMXFtRVNIQYeiosGI3McYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GcdyVj41BYl03/aaPnzYLcCOx8MhOm28yR14v2uQR+w=;
 b=lrUHkoSYrhCM3NmHBP9O8JHXMyQHi4GsaC0wrMWL5dNlqvXOWwArLXIHpckispr2w51KIUdgS7budnpn05wqmIizZT59jN4DHq9GH6WInwegJ5oETU6jNe/Zk/nbkDzpY1Gwor+pVdk53nXScaPcBgl/efXEEembIYVE1LMhyaFq6nwf5LnosJ+Ti0uQSTSQV3/QhDM/kTRR4Ev2V3KtE9SqUMvaUNnApvxNWpCMDNxmxySgLmBY7DmND9yYmLKMkprta2vqSZbXVk7RsGROKpT0ZI7pPjL5kgnaqoyRGdg4QmKpHt6vo6zeDw2a5VGxeVCOY6EVCQjCOhSzaR16Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GcdyVj41BYl03/aaPnzYLcCOx8MhOm28yR14v2uQR+w=;
 b=badXPY9phegisUEBClssjYYohEaZz4yLl1n8SpbPn1ZJec+eFrD5I3qkf83iD7VZgeeUcmrlzvhPEfu2OyBtCbxiUrHl8kuqVhoi8zY80kLhc0rQoFrQXWRTb2TRmVehW2KRzlljC7R6BaoRAfjqeifKu4NfeRaCm9EZ5GpeN10=
Authentication-Results: lists.xenproject.org; dkim=none (message not signed)
 header.d=none;lists.xenproject.org; dmarc=none action=none
 header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB3689.namprd12.prod.outlook.com (2603:10b6:5:1c7::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16; Sat, 17 Apr 2021 16:39:25 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::b914:4704:ad6f:aba9]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::b914:4704:ad6f:aba9%12]) with mapi id 15.20.4042.023; Sat, 17 Apr
 2021 16:39:25 +0000
To: hch@lst.de
References: <20210318161424.489045-1-hch@lst.de>
Subject: Re: swiotlb cleanups v3
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <0349082c-59c5-20d7-f324-279981c3f6ea@amd.com>
Date: Sat, 17 Apr 2021 11:39:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210318161424.489045-1-hch@lst.de>
Content-Language: en-US
X-Originating-IP: [67.79.209.213]
X-ClientProxiedBy: SA9PR13CA0116.namprd13.prod.outlook.com
 (2603:10b6:806:24::31) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-linux.texastahm.com (67.79.209.213) by
 SA9PR13CA0116.namprd13.prod.outlook.com (2603:10b6:806:24::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.7 via Frontend Transport; Sat, 17 Apr 2021 16:39:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92959cdb-4aa4-4f89-cbe2-08d901bf5c3b
X-MS-TrafficTypeDiagnostic: DM6PR12MB3689:
X-Microsoft-Antispam-PRVS: <DM6PR12MB36895F1CD908FB2E40C5D8B4EC4B9@DM6PR12MB3689.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: huVjYoaOSJHa7Ew0HZyYelFBkCIyFN1oRgWpSLIsN3F2QYYHlMCURlZJu5IjmdujzWyAG4w64pCjaMIY8RaFA6E0+7fDXI/tmvXKAc6C9rg8f3Ip7ONBb7d4ynYZEba6DZw2Q+wwuPcRoqxeL9TTCBpo16blNIA4bWunSMUkiB2xW6dreiy6xYsu8S9zUpqZ7rhDc1FVe+PkS3JfOVoL/FyDGPr07adJW/6GckvGFKKdEzC6mDMgoN6tIqOC80JhSRLKcBIBctOxjhEehjh5G7A+lxZX/SAx86itVjBD2GFDOVqMJUf5hDfVYt1vNDYVEwCEg3HKFqh/uV0hVJHG4eG+r+InRzI76oOhfSHANiOPqBuz5RHYHtC5/BoYliQQIVjF/puKAQIqzT3QdH56BBAq2HhyDha/+/g1te+oeQApa9DeDvMGtFC4ENcSHOrV/1Jq6JMr0yrZ1JjR3SHxXjoQn0KB8F5jpeLL3gZbDf8kZSDRPE7VHqeg6DMJk6yyIfFtobDklMbWbyI8Kgrew8kzt90y7cWOphmFZz8oIfCU4IDOOxG6iCzuum48tZF0+Wqw9/VqtVmOFXSttReq7pV2JQisSnhNbgdggIhJz0fitu1srm/pZKHB0ecWA0U6EAzq87iD34lp79IPN/EP9wbuLziJhW93k0zBLKrIkwnhhruIXpgiUuJ8g0OkbRuR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1355.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(31686004)(6512007)(6916009)(5660300002)(31696002)(7116003)(316002)(36756003)(2906002)(86362001)(6506007)(38100700002)(478600001)(66946007)(66476007)(66556008)(2616005)(956004)(8676002)(6486002)(186003)(26005)(4326008)(16526019)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?azh2SFhGOWpOb0QyZGdBbkd1RUxTVGFxbFZFZzRzM3dTRDJvcm4za2N2aVBq?=
 =?utf-8?B?QjNoUDE2WVJLTWZ2ckNOdjFlbFh5VmhGZyt4UnUyYnliMXh1ZStrMW51cmlB?=
 =?utf-8?B?ZTVvKzBEMndWWmhaTmxWdDdicjl3Z3pMSjlZOXB0YkNHcjhBK05hNkx1NC9a?=
 =?utf-8?B?Y0JsTmk4ZUovQ3NnRmoxMXY5bjh3dUtoYTF6Z1pwUmtQVFRXN05WNU1RZElD?=
 =?utf-8?B?a2FhM2pTMlpRMStmbW5LNmRCR0duSFBIdFlHSjNmSTk4UVZQWkJoaWhVRUJX?=
 =?utf-8?B?cFNOdHNZWTcyeUhhZFpzbllwdmRDdnd1R3NubkorRGx1b25lTlc3VXFJREho?=
 =?utf-8?B?NCtzOUxkRUxVa0l6dWxFYWVhWlpEN3RtSGx4Yk5ENUdDeFV6MFQzNG9CWXNX?=
 =?utf-8?B?cWhGZVo1ZFY3K3IybXd6TlpoVXhaU1d5TmRkSlJtaUUxRzBBbnZkZVBLWmtq?=
 =?utf-8?B?aUpZdm5Cam9qSk9lYVBRaFRmL1Jldm1VNCtSbGRxWTREd3grRXdzL0F0NzI2?=
 =?utf-8?B?NkZJZlNTaGZZa21DL2pad01ZS2VGTzRnWnRJc2hTU2h2WFdPUWNmN09GMmc5?=
 =?utf-8?B?ZVg4aHZMSFM1UEpiL1hWVGtZZWZtTzNVMy9uTWZYZm5NaU5kaGcvNkFYRnpq?=
 =?utf-8?B?MHdkVUFQN00wR05LZzQ5bjRJYUxHVGFtSzRmYzNGQzY0a0lzQ0lsUjNEZmlE?=
 =?utf-8?B?M0NuelAzRXJOWEg4OU9ieko0OUFMM0l5eFc0QTBzdDQwQkZZSklWYzFQLzFL?=
 =?utf-8?B?c1hGQUlXN0FFN0E4V0tUVXRpZDJlMnZPWDVCdms2RUZGMEtGelNoQmdJaWhS?=
 =?utf-8?B?WUFmVmtkR0ZuSmNVVHpxdzRPakdjbjZDbXlHK1oyNzBLSUdkNGoyV2h5dDlq?=
 =?utf-8?B?bmJTUFNXNkZPc3FHaWNDVTYxeEN3YkR6RUVyUTMyYTA5aEdYenM4U2I4bi9P?=
 =?utf-8?B?YjBoQlZnQkt6V0tibjZScjBUeW5kb3JoSk9WeVlZVFBabzUyY3AwcUFOOG5y?=
 =?utf-8?B?djJDWmdpZmJHL2NnY3VhUnRBMU9QVStkSTA1Q2t2eXZHL3BzYXFCZ1Ricmlq?=
 =?utf-8?B?VGw5T3lGOWtodHFEZE54RjFraGtFaWNuRFBNVlR0NzFCNi83V2duMDVZVGg4?=
 =?utf-8?B?UjhBZ0JSMFo0ajRTSnRnUVpWVVVIb05ENkI4OGNuS04xalV1UEZUOEgwdFgz?=
 =?utf-8?B?a21vQmg2eXF6NkZQeUttVEtNTUczRXVpbDgwa2Q5U0taYnBSWTFTNkhxV3VE?=
 =?utf-8?B?c1ZhM2RkbmM1WTNxaFVlemJKMlhyeDkwcXNENWV0MU9ESk84Z3FKalZQSnZv?=
 =?utf-8?B?cXJMWURIRW9ZbE9RVUZmVit1S2hBM2RjM1N3dmZGTW1tTWt5MjdScWVWRkdD?=
 =?utf-8?B?cUZzU1RheEMremhVU3VFTWppTHlSU3RRMDBSMWhxWkdNNUVNWlNYVkorKzBq?=
 =?utf-8?B?R3U2ZEtFcUd3VkVQRkh1QjdCay9HZTlSRWpzNjZCdVgrUVhFbit3M3hvcTR1?=
 =?utf-8?B?RkE0eVlCQW1LOTVjSVUwS2o1MnVJcHByeFBhMW1SSXkzOVVaQmg0REY3UnNm?=
 =?utf-8?B?eExNLyt2eUE3TmdJM0J3Y2pQUnVaSFdaY2gvNmRrSjIvTFBSMDFuVkcrM3hL?=
 =?utf-8?B?dHQxVXc3Nmt0WGFvMnNEMTVick85QU1zbnhWK1N1Z08yd3l1RSsyYVZHQzZj?=
 =?utf-8?B?cmtWWVZ4WHVIYUk0cGV4TW84Q09iMWhPVnliRm1Ceit2clY5NnZMWjh6YWo3?=
 =?utf-8?Q?k7atTw7QtBoKAdU6+XTzTFwsVqx3t7maBmIaIoa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92959cdb-4aa4-4f89-cbe2-08d901bf5c3b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2021 16:39:25.1018 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IinspRQYFEhv3YVR8hU+E9fVUc8XqNu2pACwTe9i9GThqegGjDyTSh5NPY9xJTR/A309b/Mw6U5jxyxWt1TWWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3689
Cc: xen-devel@lists.xenproject.org, konrad.wilk@oracle.com,
 dongli.zhang@oracle.com, iommu@lists.linux-foundation.org, mpe@ellerman.id.au,
 tientzu@chromium.org, linuxppc-dev@lists.ozlabs.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

> Hi Konrad,
>
> this series contains a bunch of swiotlb cleanups, mostly to reduce the
> amount of internals exposed to code outside of swiotlb.c, which should
> helper to prepare for supporting multiple different bounce buffer pools.

Somewhere between the 1st and 2nd patch, specifying a specific swiotlb
for an SEV guest is no longer honored. For example, if I start an SEV
guest with 16GB of memory and specify swiotlb=131072 I used to get a
256MB SWIOTLB. However, after the 2nd patch, the swiotlb=131072 is no
longer honored and I get a 982MB SWIOTLB (as set via sev_setup_arch() in
arch/x86/mm/mem_encrypt.c).

I can't be sure which patch caused the issue since an SEV guest fails to
boot with the 1st patch but can boot with the 2nd patch, at which point
the SWIOTLB comes in at 982MB (I haven't had a chance to debug it and so
I'm hoping you might be able to quickly spot what's going on).

Thanks,
Tom

>
> Changes since v2:
>  - fix a bisetion hazard that did not allocate the alloc_size array
>  - dropped all patches already merged
>
> Changes since v1:
>  - rebased to v5.12-rc1
>  - a few more cleanups
>  - merge and forward port the patch from Claire to move all the global
>    variables into a struct to prepare for multiple instances

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
