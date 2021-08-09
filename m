Return-Path: <SRS0=YfIy=NA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AFDC4338F
	for <iommu@archiver.kernel.org>; Mon,  9 Aug 2021 21:56:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1DCC60F55
	for <iommu@archiver.kernel.org>; Mon,  9 Aug 2021 21:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E1DCC60F55
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8DEF360811;
	Mon,  9 Aug 2021 21:56:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3lzXOMQPbjEd; Mon,  9 Aug 2021 21:56:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3838A6080E;
	Mon,  9 Aug 2021 21:56:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B06AC001A;
	Mon,  9 Aug 2021 21:56:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21A14C000E
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 21:56:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 095DE40298
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 21:56:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qwoMlbg43IkT for <iommu@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 21:55:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::60a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 03CDA4028D
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 21:55:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nzg0JsJe3+u5NO7aRkKN43ICh00ZXDe+OW0A/RD+LlkuqiLbY1DiZIZ4GRoqcQ0HfrFjnlrql/9bLYpYcdcki+UkmR8suztzR8D7Ofvrs/qtBc0JEC2MLS8Uj9b+nysfWTlozzkLTBDZE+EuiXOt43VOWTTMe5u55Eqz/1pgAHj5iWrDsezF6QeAFuQOGQQHqyT2zq8opGmwl21gpHb7TeTSz+MAKWrcbiec8ze8ROsQ2/4qiOz/J8XJCQ96HGWfTGfw7LdXcq+5erG9O0JNlXONqoJ1gzXfXPJdu4RjEbSbavorWVnGzHtIJZEomBNICCA2fKXPQynPfVFe7WO5KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qjfqcuynl6MNwWd/ZCoVZg3ncqANglufLbMbDorr4IU=;
 b=Eb5d+tU/FMpC17fcA7BgpwhTd6835rEtKJcRmEEujF3wEqDplREPU+VwQi4GUQG/WInOQGQvrU6vcpNJ10PEYJs3Z8z9dXlsd01NMq3KVysnNHTW1f3hbDXYOnCcuM5naCStFg4Cq45qJnuHh1qNfZT2zZjNVCzQWiZRIvrGcItUqQgq3rB9QrndI2S3GhcaKOUoI7Mm47JXy3O+vdcSMbaOAmrffV8pjZxsZ9hdiu24b/LfeojqdICMK6OtkW6K7b9bmqTVczsOTqtAEcME66aGbdwR4AyqJ6BAmB88zxSQWptANlVu5PxJqpsqMR7QNc9u8hYxr5WkuziVd+fBUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qjfqcuynl6MNwWd/ZCoVZg3ncqANglufLbMbDorr4IU=;
 b=FSu0tPPV2gwlr3Lx/QgZ8K7q+i6UTH800vC3B/j13KkRO4q11lhf8CsgVCTAE1Afmq9X19QEvU7K86G5wtvIKaSvoxY4CZ83uzbbzyCtuC56huvJQ5jaWMywx+Hpitpemfmt19cEiO+rG0DC6Ea9WR61BFiGYd1louHCe8DLLxE=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5295.namprd12.prod.outlook.com (2603:10b6:5:39f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Mon, 9 Aug
 2021 21:55:56 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208%3]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 21:55:56 +0000
Subject: Re: [PATCH 07/11] treewide: Replace the use of mem_encrypt_active()
 with prot_guest_has()
To: Sean Christopherson <seanjc@google.com>
References: <cover.1627424773.git.thomas.lendacky@amd.com>
 <029791b24c6412f9427cfe6ec598156c64395964.1627424774.git.thomas.lendacky@amd.com>
 <YQR+ffO92gMfGDbs@google.com>
Message-ID: <a8a6a63e-3bb7-47a1-1427-55633f1bf211@amd.com>
Date: Mon, 9 Aug 2021 16:55:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YQR+ffO92gMfGDbs@google.com>
Content-Language: en-US
X-ClientProxiedBy: SN7P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::19) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.241] (165.204.77.1) by
 SN7P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.15 via Frontend Transport; Mon, 9 Aug 2021 21:55:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c9c3def-6ac3-4a7f-ad85-08d95b807723
X-MS-TrafficTypeDiagnostic: DM4PR12MB5295:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5295F82C01BEDC78DB002AEAECF69@DM4PR12MB5295.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: va1GgnlgkQoGJwHV4u/vWPT7qTpos8azTAmvWS6mQTBalS5XDFQ7rPECEiFxbzhVX4g9ynz6AYUXHBRPGK/BG4lHF214foWL5qc8Ipuv0n5mmNDzMO6Hv31jefLDxr2WadSnaBSsjhcOlIOeTWLFx35539aLQslnZfOQcrR9HIQ/6Jd3qwyUn+WpQhxX+RMaadPnpPiWvT9tSAdv9jKY2wvGt+n0iyJAStAkjw27F0ml616aW8od/L4TyCN/Rsf541EY8pzky7JXzvLU7/IGPLbkS9Hvxze0OonQm7R88g9MhsEH3AoxCa1Dm0lfC8HR3hmxX1uEP24QfIQXKcPZfwRKBPLq0NW1sw827/Ze3N7ol42kAYvvUSlkfJ1fdqtgA1kGUUXPxnFYsMw2nJtU9v6jqjnhxQynBDVvxyErLtGxsYZAlEmTNvdX+nmrFLK4DICPDMozvwfe4Oj00+8tawhx77i/3HhvN/VZYNdWL+sJYOkHz2yNX+Lwy5LNmgFVKmK14mEy7WoQSf1Xy8xi5vf+Mxe7pordAYQihwWwnshQp3BI/u3xhBqUxlGblRIQPkCHfOBx98RbAX43hywnlXnNdkX/s+2X2x6Pi/xKfx8gAVBEPaD5OgvLqBbD091GXXkIopa3grc0gvtmehCybzehCkXBaWrV8m3OjyvmpEFoODxwI3Yf98qWX4ZcfLXnsmSKLIhNbAq0Hm0Db0p2zYqIPigk2iJAVqz1CHGYfUQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5229.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(956004)(16576012)(186003)(6486002)(8936002)(31696002)(86362001)(8676002)(53546011)(7406005)(54906003)(7416002)(478600001)(316002)(2906002)(4326008)(6916009)(26005)(2616005)(36756003)(66556008)(38100700002)(31686004)(4744005)(5660300002)(66476007)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmZMNW96ZEk2QzY2UndOajg2OTJLTVYzanlKMlhka2FENy9NeEFGRXJETkdQ?=
 =?utf-8?B?aWtaNU9oOCtFYkhVWnJpME9QQTdwT3Q2cXdlT1lxRzhuTHkwdmFaT2p1Y1NU?=
 =?utf-8?B?VFVveHVIdERHcXNDOGs3Rks1dXlGeUhsc2FqT1BDTlZkNFRuQndsQTl0OFo4?=
 =?utf-8?B?UllFdXU3RWVUOUFoSnkrOUE5SDVmVCs1YVV1SytqVHNEQW1zQnA1VnIwQW5Q?=
 =?utf-8?B?TGpld0lkSWZOWEw2OThaZlY3NGs5RG5vSTlKRkFlbUxveThTL2dEM0g3dVpv?=
 =?utf-8?B?TzZXWkl4WkRhZFViMTc5dk43UHVqRlNWTVdHRDM3N1BRelVrbHVhaDM4N09u?=
 =?utf-8?B?Rm0wcVRTYS9wSzRhZEdUUkVBRTAyb01zUkdsU1pNRlhPanpvdXlBd2RLV2NJ?=
 =?utf-8?B?RWN0YjRZTXVSVG1tK0k5cFRuRkd5Z1hiRFJ3dGNYQnU5dUtqVDl4aGtWemhz?=
 =?utf-8?B?czdBOG4zSzZhQ3ZhK2Z3R2Z3c2xDVnRqc0VyWFZIeThXR054LzF4QTlOMXg3?=
 =?utf-8?B?N1h2bDRieDB0VEczcXpTSjNyTUJkY3ZtNVB1amhjTmVGQXdUWlVVcVk0L0FF?=
 =?utf-8?B?N1Q0L1pxUHljbjBXZHY2TWNMZGpUSTlra3ZHV2NNdWE0bmNoVFNvWEtHanR5?=
 =?utf-8?B?Y3BsTUdwODJXSjhDMS9oNSt0WExzMDUyYkdzWFE3Mm9ZUmdsRy9BYnZjM2R0?=
 =?utf-8?B?RFVuWlBheFpWejN6S09HSVQwNnA0WVJGZUhkUnhIamhGN1dQajgwSWtLNlVO?=
 =?utf-8?B?a0JpbTNQWTZUZHRlRkZKWlg5TnpTcE9yN1BmZmN3WE01YXgwMjlJMSs1cXdx?=
 =?utf-8?B?QzVOMUtoeWN4bytkVjByd0drZlJBNmFtblluOEwvMEpMcGl2T3I4c2tYbERZ?=
 =?utf-8?B?U014OFVoRUVxSGl1RGo4YnhTSTFrcUQ4ZmYwMSszc2x3OFovZEhLUnFWSlRk?=
 =?utf-8?B?aDNJWnJwaFhTUTEvZitBMkZPRkZPNE1xc1Z6aC9JaFdrOFFQbUlkb2hJOGlH?=
 =?utf-8?B?MG9iL01CbERyeWtHRDJTd3pUVDlMS3hod2tNVW1qbTRJN2pzbzRIS0cxSXg3?=
 =?utf-8?B?cVhLZzdZbjAzMmIwL0VvcStiQkJVSEVuMmw3cFkwQmw0Yzh5Z0tSWlVQNXp6?=
 =?utf-8?B?cTM4bGx3cjVtV0ZBU1dOZlN3eEJNVk9NdDBaMG4wWEpPeU1mdmJrbmhVM2VJ?=
 =?utf-8?B?RkMvZ0M2TDkxQXdnbWxKbWN6UkdIaS8wdDFZS1hGRXdsZ2JRcU9PREhOMmp0?=
 =?utf-8?B?Wk9LcFk4eWQyV3BJTTNyMEl1Y2YrL0JPTDRWckd6OUFLbjBGZmFFbGdja2N5?=
 =?utf-8?B?KzQ3WE8rODBHSDRxLytmSXBFbDZVL3R1TStDM1ZicjVKOG9aU0tWZGVLb1Fa?=
 =?utf-8?B?Y1hjUGFscjNhUjRaV25ldllCdGthamREMVFiZ3Q2UThMTTNCbThLNlVnb0g1?=
 =?utf-8?B?ZXQ1R0tZWWZkL1RjTlYzY2J3NncvNXplQSttT3R1MjFrZDJXSDd2WFhNMUJx?=
 =?utf-8?B?VXlyQmNFSDR2VzhRVTFUK1V4M3h5L3l6WnNPZ0lteFprQkhNK1JTS3h2cmxq?=
 =?utf-8?B?YTdMVjd4Nm9zYkdiMit1bGF3VlJIdHdlQUdRMFVvQzlKWktFeWJ3bVFvVlhr?=
 =?utf-8?B?Y3E2dVFvK2NROUdqZXJmWEtWYStMTW42bWR5K2g2aERiOVRHZytIWGtqQ0tZ?=
 =?utf-8?B?clhaZVV3blo0L2dRbDJYMUM0QmVFTGQyRjVjenYrN0xoeVhYblUzcFJHb3lu?=
 =?utf-8?Q?hU5Nt3rVA6gzUChUx3/nd3C3z1WuFX1/ao0tSAJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c9c3def-6ac3-4a7f-ad85-08d95b807723
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 21:55:56.4514 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gVMUdJrJtSzpeS/OVG6KXOyXh5yqKz+0hfHnt6FLUw5aHfd3whCwKAMeR092Kk8k7apxnVxc1jIYxygM9OqnpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5295
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>,
 kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, dri-devel@lists.freedesktop.org,
 platform-driver-x86@vger.kernel.org, Will Deacon <will@kernel.org>,
 linux-s390@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
 amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 Ingo Molnar <mingo@redhat.com>, linux-graphics-maintainer@vmware.com,
 Dave Young <dyoung@redhat.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
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
From: Tom Lendacky via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 7/30/21 5:34 PM, Sean Christopherson wrote:
> On Tue, Jul 27, 2021, Tom Lendacky wrote:
>> @@ -451,7 +450,7 @@ void __init mem_encrypt_free_decrypted_mem(void)
>>  	 * The unused memory range was mapped decrypted, change the encryption
>>  	 * attribute from decrypted to encrypted before freeing it.
>>  	 */
>> -	if (mem_encrypt_active()) {
>> +	if (sme_me_mask) {
> 
> Any reason this uses sme_me_mask?  The helper it calls, __set_memory_enc_dec(),
> uses prot_guest_has(PATTR_MEM_ENCRYPT) so I assume it's available?

Probably just a slip on my part. I was debating at one point calling the
helper vs. referencing the variables/functions directly in the
mem_encrypt.c file.

Thanks,
Tom

> 
>>  		r = set_memory_encrypted(vaddr, npages);
>>  		if (r) {
>>  			pr_warn("failed to free unused decrypted pages\n");
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
