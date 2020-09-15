Return-Path: <SRS0=AdPL=CY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB902C43461
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 12:30:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07A2D20731
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 12:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="a9bPpIzJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A2D20731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 93FD787132;
	Tue, 15 Sep 2020 12:30:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z2H2J7PXJoO5; Tue, 15 Sep 2020 12:30:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7DE3987130;
	Tue, 15 Sep 2020 12:30:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5EA6EC0859;
	Tue, 15 Sep 2020 12:30:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49452C0051
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 12:30:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 31531866B8
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 12:30:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CO+jRTflhpXH for <iommu@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 12:30:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0084986693
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 12:30:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSrd3V2WU5FtKWxQin4XgeoIh0p96YaJGeftzH0v0vk22UEthfp1zqQ+D204ENbqjlkImGJ1Bjqhp9WLh1ynquZx5sJJTn6CbLsy1+30Jm2loPZne1EPvbqSbrfZKK27OETOa8EUgBPKjQWAVD2yeNQrqo9iFyDHxgcWqqSLfSrs6OAYPNWuJqW7heoo96Jy+AjHRu/1CJqlup/KAwMiRJREzvYrW2NmnkH8GIVOKcXDYLGpHRAzu88PFr7Ik3EBD598j1P8/RmZQ0xa8qCrP0PhxhfXnAtPwJEsFp1lKKkyZHw5TVroOLC8k64kCFjaN7Pgl+iRvsWzHanlR+wrrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPdytxBffdiv8r9DXyTfJK09sMmLbzQISuPSE0oJLGo=;
 b=Jkjfel7YktE83ODNJ7JdmuttOXCvqc4TrdUl94ed41yGf2ch255cnqhrI5RhT7ZCbnmv0GS4OXjS2Bu4fN5lpqvf0EEUl1PHhag57q3JOJl05JkVmNL8I9iAWygZ0jLVE0pQSGVJtuqbBCEALwECX5B7FTM8wTBfI8kckv8yaC2PrL7R+eRJinos76d2Qwnxm6YE05PobIW6bmyuy9Jys8svCVuJ20n0es/C6NBkGKAYuvGYaYy5NVF0Yhd98eKOnihZBkb1Qse0Ewa4P4E3ZEC/CYr78pHQ/OJU3G1adzFDB9eMXaUNJ93pt59Rb+REaZfjIvKjJ0JwV93G9BSWbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPdytxBffdiv8r9DXyTfJK09sMmLbzQISuPSE0oJLGo=;
 b=a9bPpIzJcVapFaZ430qPK5qJbW1tsJxswvmVMaTIquWNCUZmda1qC+78Sz8PZkOtejSbNykmrYYs9maUf6viHNXBWeNTrNTCG8ICR4rkGloXm2bPCpzKugeJYheMZ6dRJp+PWdOB26ZqFMCpmE35Ci9UbvOyT2kjSJdx7H8CYGI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM6PR12MB4433.namprd12.prod.outlook.com (2603:10b6:5:2a1::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.17; Tue, 15 Sep 2020 12:30:47 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 12:30:47 +0000
Subject: Re: [PATCH] iommu/amd: fix interrupt remapping for avic
To: Maxim Levitsky <mlevitsk@redhat.com>, linux-kernel@vger.kernel.org
References: <20200913124211.6419-1-mlevitsk@redhat.com>
 <60856c61-062b-8d92-e565-38bd00855228@amd.com>
 <04a8ab5cb1f6662f72bcad856da3415d6d9b2593.camel@redhat.com>
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <dd0b9a98-149a-286c-2793-8ea0e8b60e2e@amd.com>
Date: Tue, 15 Sep 2020 19:30:38 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
In-Reply-To: <04a8ab5cb1f6662f72bcad856da3415d6d9b2593.camel@redhat.com>
Content-Language: en-US
X-ClientProxiedBy: SG2PR0302CA0017.apcprd03.prod.outlook.com
 (2603:1096:3:2::27) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Suravees-MacBook-Pro.local (110.169.70.5) by
 SG2PR0302CA0017.apcprd03.prod.outlook.com (2603:1096:3:2::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.5 via Frontend Transport; Tue, 15 Sep 2020 12:30:44 +0000
X-Originating-IP: [110.169.70.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 86a6f92c-a739-46fe-48ad-08d859732bff
X-MS-TrafficTypeDiagnostic: DM6PR12MB4433:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4433D4CCF0C0FEE02E9261C8F3200@DM6PR12MB4433.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: foxILmYQBX77+QcEY/nfAWEn5rtFOKPMYjscCxoxLtvcg9SAte9i/AvWrR7JzZ/X9Eqbz1xoG8+ReJGi+G9nreSzQjL+G0ZDs7hH9+OFNVfHSD60DUyyG8gQQ+EF9NNNTnIZA8GFIT0JmqrUJvuCpueVAVmrlZB2XJ4M/xWW+uoTLGArpHh6cv2viwxg4HiL1QaO6coLO8jTvssiXGu8LAmeOXlJeJXwoPZGlXciZKP1+//a+3GciAQRbaPNR79Yv56yeuzbPdJ3Sz2f50tOL5fhU4OJlJTp5t+3y3zRNuGm3bU8vizh7gzp+T/TbeNDiLCTKmq5wB7Uy/fvA3umYR/dEeMC6Rf+Dzo8p/M3cWgl3z8pOqIzkSauMEhoYYf5/jZBwkSuxB8iutYNeMx6WtE+jHLudC9gZJwweOs9B1gNsuMfP0RYCSiwqLd9iznJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(36756003)(52116002)(66556008)(66476007)(26005)(6486002)(66946007)(16526019)(186003)(6506007)(86362001)(53546011)(83380400001)(2906002)(31696002)(4326008)(31686004)(478600001)(316002)(8936002)(54906003)(44832011)(8676002)(2616005)(956004)(6512007)(5660300002)(6666004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: EuXDzseU8UqxQLhC2aBSPvgamjwIreRLToraX+SrEy1GRTEM8EpT4kM3GP6jjOaM1qaS1b1kgTD0f4cXWl240IdaFnjgni+pqEcIN5exkwZXUacU62/CFyqeH8IP1Qux3uBLQlAynn5LyDurYGxxHBqQw02S28RGZ6RNJipzoT89JKbYYfHBpsGFZVMPdvhkEWoUoNrfac8g+IGlbsm1zZ4/hyaMvImIV5tmjjMMyvGaphghlnJYNPhRzPjVgHtklFmT4w0xPxa6T/s9NUWBxRmlx+u6ky4Vso3x4RgJBBPlKAYen8x75fb3tfDvFbg67ejQwZ7iN5rbQw49b5w4ciH/Yjf0ad9oxrNacAnoDIJPNVNiesuigFVMnm/5ymjxmTZpF31ZWKpXRtjzCaA1kray7Ch8HoLbcju66XRcPCnZIXoy8Q6fXpfJWKFOxhRuWQA5CFjDfPdMqqgUxvfXovGvDAFDTbSDFB7L1OKh8/IipCLeBiMoRXzD2apYKqEkV3oK1vE/3cItJ2keY/pQjMpGub5h+BIKOGa40VO8ybPQNTVcIKQfOfEnOCYB2P7j6GHFAgI8OEhFAWrXptmX7sE/R4PBmkpz2yEbHALdEbPVVJ8pNHjWHiXeyCrk7Y4IepWrcT4R6Nak6qM0rSsVjw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a6f92c-a739-46fe-48ad-08d859732bff
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 12:30:46.9460 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+hqZi+QExl2OeNHUX2eV9SpHuzpHsXuMdNvU/ayO8zz3xy1+hKpVk+GhpKWVD5lY49bXBupFOgO7nCipD4OLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4433
Cc: "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>, "Grimm,
 Jon" <jon.grimm@amd.com>, Joao Martins <joao.m.martins@oracle.com>
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



On 9/15/20 6:25 PM, Maxim Levitsky wrote:
> On Mon, 2020-09-14 at 21:48 +0700, Suravee Suthikulpanit wrote:
>> Maxim,
>>
>> On 9/13/2020 7:42 PM, Maxim Levitsky wrote:
>>> Commit e52d58d54a32 ("iommu/amd: Use cmpxchg_double() when updating 128-bit IRTE")
>>> accidentally removed an assumption that modify_irte_ga always set the valid bit
>>> and amd_iommu_activate_guest_mode relied on that.
>>>
>>> Side effect of this is that on my machine, VFIO based VMs with AVIC enabled
>>> would eventually crash and show IOMMU errors like that:
>>>
>>> AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0055 address=0xfffffffdf8000000 flags=0x0008]
>>>
>>> Fixes: e52d58d54a321 ("iommu/amd: Use cmpxchg_double() when updating 128-bit IRTE")
>>> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
>>> ---
>>>    drivers/iommu/amd/iommu.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>>> index 07ae8b93887e5..aff4cc1869356 100644
>>> --- a/drivers/iommu/amd/iommu.c
>>> +++ b/drivers/iommu/amd/iommu.c
>>> @@ -3853,6 +3853,7 @@ int amd_iommu_activate_guest_mode(void *data)
>>>    	entry->hi.fields.ga_root_ptr       = ir_data->ga_root_ptr;
>>>    	entry->hi.fields.vector            = ir_data->ga_vector;
>>>    	entry->lo.fields_vapic.ga_tag      = ir_data->ga_tag;
>>> +	entry->lo.fields_remap.valid = 1;
>>>    
>>>    	return modify_irte_ga(ir_data->irq_2_irte.devid,
>>>    			      ir_data->irq_2_irte.index, entry, ir_data);
>>>
>>
>> Could you please try with the following patch instead?
>>
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -3840,14 +3840,18 @@ int amd_iommu_activate_guest_mode(void *data)
>>    {
>>           struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
>>           struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
>> +       u64 valid;
>>
>>           if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) ||
>>               !entry || entry->lo.fields_vapic.guest_mode)
>>                   return 0;
>>
>> +       valid = entry->lo.fields_vapic.valid;
>> +
>>           entry->lo.val = 0;
>>           entry->hi.val = 0;
>>
>> +       entry->lo.fields_vapic.valid       = valid;
>>           entry->lo.fields_vapic.guest_mode  = 1;
>>           entry->lo.fields_vapic.ga_log_intr = 1;
>>           entry->hi.fields.ga_root_ptr       = ir_data->ga_root_ptr;
>> @@ -3864,12 +3868,14 @@ int amd_iommu_deactivate_guest_mode(void *data)
>>           struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
>>           struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
>>           struct irq_cfg *cfg = ir_data->cfg;
>> -       u64 valid = entry->lo.fields_remap.valid;
>> +       u64 valid;
>>
>>           if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) ||
>>               !entry || !entry->lo.fields_vapic.guest_mode)
>>                   return 0;
>>
>> +       valid = entry->lo.fields_remap.valid;
>> +
>>           entry->lo.val = 0;
>>           entry->hi.val = 0;
> I see. I based my approach on the fact that valid bit was
> set always to true anyway before, plus that amd_iommu_activate_guest_mode
> should be really only called when someone activates a valid interrupt remapping
> entry, but IMHO the approach of preserving the valid bit is safer anyway.
> 
> It works on my system (I applied the patch manually, since either your or my email client,
> seems to mangle the patch)
> 
> Thanks,
> Best regards,
> 	Maxim Levitsky
> 
> 

Sorry for the mangled patch. I'll submit the patch w/ your information. Thanks for your help reporting, debugging, and 
testing the patch.

Sincerely,

Suravee
>> --
> 
>>
>> Thanks,
>> Suravee
>>
> 
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
