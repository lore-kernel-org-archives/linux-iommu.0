Return-Path: <SRS0=AdPL=CY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F933C433E2
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 13:19:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAE4E20872
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 13:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="x0k7jC2m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE4E20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 779D6866C3;
	Tue, 15 Sep 2020 13:19:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eq88z5ItdVGK; Tue, 15 Sep 2020 13:19:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BEF158669E;
	Tue, 15 Sep 2020 13:19:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8967BC0864;
	Tue, 15 Sep 2020 13:19:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4FA5DC0051
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 13:19:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3E7A88700A
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 13:19:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ev5Spdra7+7E for <iommu@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 13:19:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1B82687006
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 13:19:21 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FDEdTu122411;
 Tue, 15 Sep 2020 13:19:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=RYbxDNTa5lwzeibU2kkR56jnbMBOY0TQQhnSf7Q2dlI=;
 b=x0k7jC2mXY4mzvwUhbECTgKDOhehkh7hhFT7d18HyH9c9zKyrIZpTOws/gspglZUSoFo
 KwyJT5P6FPJhYGcsn0hvrfTunwhXiJ/b4NfgfRbZjsZBw3bvZ7iZaTE12UVNViyV2lFF
 J1hVUTvopvjHXOxkIoyUPxUUIxlOdndAU22tBvrS0rzvDfZDXsMiQMSvoQ3BKp1eIp15
 aBb0bdhm/dnMLD2CW+HAzwzGryjd9kNJHZ4NPi9tw8qg91IxBxOF5qkCRteQbRpCEaKD
 FX+7cya7dq1e1/VI7oPqCbJXKInBikuTVKYm8uARQDYOYwjIDZz7ODGUGoeUjK7kfnVN 6g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 33j91dehgr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 15 Sep 2020 13:19:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FDFP4g121829;
 Tue, 15 Sep 2020 13:19:11 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 33h884uygc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Sep 2020 13:19:11 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08FDJ9lq026071;
 Tue, 15 Sep 2020 13:19:10 GMT
Received: from [10.175.214.104] (/10.175.214.104)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 15 Sep 2020 13:19:09 +0000
Subject: Re: [PATCH] iommu/amd: fix interrupt remapping for avic
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <20200913124211.6419-1-mlevitsk@redhat.com>
 <60856c61-062b-8d92-e565-38bd00855228@amd.com>
 <04a8ab5cb1f6662f72bcad856da3415d6d9b2593.camel@redhat.com>
 <dd0b9a98-149a-286c-2793-8ea0e8b60e2e@amd.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <b323b9d5-8149-5e6f-c24e-43b64bc6f2f6@oracle.com>
Date: Tue, 15 Sep 2020 14:19:06 +0100
MIME-Version: 1.0
In-Reply-To: <dd0b9a98-149a-286c-2793-8ea0e8b60e2e@amd.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9744
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009150111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9744
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 impostorscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 mlxlogscore=999
 clxscore=1011 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150111
Cc: iommu@lists.linux-foundation.org, "Grimm, Jon" <jon.grimm@amd.com>,
 linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>
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

On 9/15/20 1:30 PM, Suravee Suthikulpanit wrote:
> On 9/15/20 6:25 PM, Maxim Levitsky wrote:
>> On Mon, 2020-09-14 at 21:48 +0700, Suravee Suthikulpanit wrote:
>>> Could you please try with the following patch instead?
>>>
>>> --- a/drivers/iommu/amd/iommu.c
>>> +++ b/drivers/iommu/amd/iommu.c
>>> @@ -3840,14 +3840,18 @@ int amd_iommu_activate_guest_mode(void *data)
>>>    {
>>>           struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
>>>           struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
>>> +       u64 valid;
>>>
>>>           if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) ||
>>>               !entry || entry->lo.fields_vapic.guest_mode)
>>>                   return 0;
>>>
>>> +       valid = entry->lo.fields_vapic.valid;
>>> +
>>>           entry->lo.val = 0;
>>>           entry->hi.val = 0;
>>>
>>> +       entry->lo.fields_vapic.valid       = valid;
>>>           entry->lo.fields_vapic.guest_mode  = 1;
>>>           entry->lo.fields_vapic.ga_log_intr = 1;
>>>           entry->hi.fields.ga_root_ptr       = ir_data->ga_root_ptr;
>>> @@ -3864,12 +3868,14 @@ int amd_iommu_deactivate_guest_mode(void *data)
>>>           struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
>>>           struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
>>>           struct irq_cfg *cfg = ir_data->cfg;
>>> -       u64 valid = entry->lo.fields_remap.valid;
>>> +       u64 valid;
>>>
>>>           if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) ||
>>>               !entry || !entry->lo.fields_vapic.guest_mode)
>>>                   return 0;
>>>
>>> +       valid = entry->lo.fields_remap.valid;
>>> +
>>>           entry->lo.val = 0;
>>>           entry->hi.val = 0;
>> I see. I based my approach on the fact that valid bit was
>> set always to true anyway before, plus that amd_iommu_activate_guest_mode
>> should be really only called when someone activates a valid interrupt remapping
>> entry, but IMHO the approach of preserving the valid bit is safer anyway.
>>
>> It works on my system (I applied the patch manually, since either your or my email client,
>> seems to mangle the patch)
>>
> 
> Sorry for the mangled patch. I'll submit the patch w/ your information. Thanks for your help reporting, debugging, and 
> testing the patch.
> 
I assume you're only doing the valid bit preservation in amd_iommu_activate_guest_mode() ?
The null deref fix in amd_iommu_deactivate_guest_mode() was fixed elsewhere[0], or are you
planning on merging both changes like the diff you attached?

Asking also because commit 26e495f341 ("iommu/amd: Restore IRTE.RemapEn bit after
programming IRTE") was added in v5.4 and v5.8 stable trees but the v5.4 backport didn't
include e52d58d54a321 ("iommu/amd: Use cmpxchg_double() when updating 128-bit IRTE").

	Joao

[0] https://lore.kernel.org/linux-iommu/20200910171621.12879-1-joao.m.martins@oracle.com/
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
