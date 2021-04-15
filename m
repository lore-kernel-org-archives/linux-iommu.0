Return-Path: <SRS0=SOau=JM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE6EC433B4
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 16:20:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 473E16115B
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 16:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 473E16115B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=live.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 08DFF40531;
	Thu, 15 Apr 2021 16:20:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1FkWdIaIsCdl; Thu, 15 Apr 2021 16:20:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 939AD40F62;
	Thu, 15 Apr 2021 16:20:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7496FC000C;
	Thu, 15 Apr 2021 16:20:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28F1BC000A
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 16:20:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0A0CE84731
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 16:20:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Qm6ZFeiZugKM for <iommu@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 16:20:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-oln040092069041.outbound.protection.outlook.com [40.92.69.41])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5BB0C8471E
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 16:20:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImZUcBScwEyFxTEt+pTfKtiH8QsWWM/00X4H4JQWN7FvrBwg9/sdqU8AFzhi7du+asNTpsoZJZb5EQIzHMVfvFaobcNJnOjHjsBVdZH0ELJFSBftI1kFtBiOqZM6+6Imy/ySjeJIWFqMEWP8mM5TZVMRBsFEo4IFcWOVAVkqsFpb/t5zxoSvX6NQLOUeF40DKet23feja2zezHfW1CAHxTYcd2p1PdAsrh5D799y4dDY5ek7DKn/BFTmmIWSTW5nPWDrq9X9YtKryrSipdOQhKgO+LLb0odWWpUG1rmRx2RIo1nTyT9bV9DmnqVFbmg/ysyC7c+qyyVLPBn2ENUdlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIuLJZ7XV5TjiIvvu3lVXqfHraat0DL0M2nu1agTIt4=;
 b=gWwlGUVCJxkyGvEMUaXrzEGucr4SXTb/PqbgZbnLz5OHQ+Hw+0oyNHUJfyoiNN+QwXO94cDKdSRnBzVFOxJQpo/SqOzZ0qX8RjWXEsZ62cKhyV/B88x8rlEWCJDFu3KIvAbcXyMNQLWvjckstAxyeyJE6jXET7VHAUniUM9snxff8N+tetF4QeYAE38lsA183QrIOK1rIjhZ5rAbnn34SRafOnec8FSVDfqdTrNnymQz94Z2AuaECWIadkLjN8s92A9tQIn+nmQJk/gc0Vsw/rJtTWUxCLCJmf2Tw+UyovSZWG3fUmgF+v+N73RgVIJgE1w43UrOIJ4vIZGnN67FAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from HE1EUR02FT021.eop-EUR02.prod.protection.outlook.com
 (2a01:111:e400:7e1d::41) by
 HE1EUR02HT177.eop-EUR02.prod.protection.outlook.com (2a01:111:e400:7e1d::313)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Thu, 15 Apr
 2021 16:20:33 +0000
Received: from VI1PR09MB2638.eurprd09.prod.outlook.com
 (2a01:111:e400:7e1d::48) by HE1EUR02FT021.mail.protection.outlook.com
 (2a01:111:e400:7e1d::85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Thu, 15 Apr 2021 16:20:33 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:60BC0E75D4DF3670DDEAAB34453A56C734CE42EC89C4A05F535CA56D85B80BB7;
 UpperCasedChecksum:E59F7A8325767B4E5361DE438302F591EAAE056DABEB9EA15AA5E9C9C494F03D;
 SizeAsReceived:9327; Count:47
Received: from VI1PR09MB2638.eurprd09.prod.outlook.com
 ([fe80::948b:987c:566b:198e]) by VI1PR09MB2638.eurprd09.prod.outlook.com
 ([fe80::948b:987c:566b:198e%5]) with mapi id 15.20.4042.018; Thu, 15 Apr 2021
 16:20:33 +0000
Subject: Re: [PATCH 2/2] iommu/amd: Remove performance counter
 pre-initialization test
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
References: <20210409085848.3908-1-suravee.suthikulpanit@amd.com>
 <20210409085848.3908-3-suravee.suthikulpanit@amd.com>
 <VI1PR09MB26380EED406F2F08ACB6B5BBC7729@VI1PR09MB2638.eurprd09.prod.outlook.com>
 <add9d575-191e-d7a6-e3e1-dfc7ea7f35c8@amd.com>
 <VI1PR09MB2638289727E1854B5CE7A3AAC74E9@VI1PR09MB2638.eurprd09.prod.outlook.com>
 <df6c8363-baac-5d97-5b06-4bcd3163f83d@amd.com>
From: David Coe <david.coe@live.co.uk>
Message-ID: <VI1PR09MB263873B89C6CF4D557F811C5C74D9@VI1PR09MB2638.eurprd09.prod.outlook.com>
Date: Thu, 15 Apr 2021 17:20:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <df6c8363-baac-5d97-5b06-4bcd3163f83d@amd.com>
Content-Type: multipart/mixed; boundary="------------CB5AD4AEB418E0917C1357A3"
Content-Language: en-GB
X-TMN: [5iJitLheer6aWtdvmeyhYGACHOLNtcXc]
X-ClientProxiedBy: LO4P123CA0095.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::10) To VI1PR09MB2638.eurprd09.prod.outlook.com
 (2603:10a6:803:7b::27)
X-Microsoft-Original-Message-ID: <add3aca3-e1dc-1857-3759-649f2de92f8f@live.co.uk>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.6] (90.246.218.100) by
 LO4P123CA0095.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:191::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.21 via Frontend Transport; Thu, 15 Apr 2021 16:20:32 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 47
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 748bd631-a517-457f-c19c-08d9002a64d6
X-MS-TrafficTypeDiagnostic: HE1EUR02HT177:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7fospyAG0/2FS1w99ZxlWQKTEEo3DCPFlir95ZcwXdqAZbx+QcadTBsQ6J+PXf3np84mlrx5cvbxbsENlT/cR5YuyiqPD/0pBp6oCfrBegGlVAxjTjL5Z6/uYI/luxlxAqpe8RCIoxR/fEvLAAaIO4Cs8ESlYf02436zlvt6mSqSz3idyKAGEwld9n9JazkebpxoGgkGVinLkRg0Bcuj3gAungbfP5zXpLu9TPqnab+hJmsfVw4vnpHt5fYBhwtgCrigBn5h8jj94nzNOp+Bq1NQslCd6yKsv3aXYX2w1XwOaScuAKipTpvVPiJHIbdBglT/y5KyJRCBtI3N8ni5aTOyyebVvFw+pC0V9vKL/xUZVNFU7BsJFH2McA5cLFAXaUt+i228Ry5KDqQMj301pw==
X-MS-Exchange-AntiSpam-MessageData: 2qvKofWRLGqeeiVev6hlxJBIr6Q3jef8CQndYjbBTFezOXEzy2vfLa3EwTpmC/Cwe9aWMvKDfKc0aguv60HemHaVcqiV+vB4/axTd5yR7bk6dhS2C+lEGsorCVA9KeIWw838i7iND3CfGBx/JCzHwA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 748bd631-a517-457f-c19c-08d9002a64d6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2021 16:20:33.1887 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT021.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1EUR02HT177
Cc: pmenzel@molgen.mpg.de, Alexander Monakov <amonakov@ispras.ru>,
 Alex Hung <1917203@bugs.launchpad.net>, Jon.Grimm@amd.com,
 Shuah Khan <skhan@linuxfoundation.org>, Tj <ml.linux@elloe.vision>,
 will@kernel.org
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--------------CB5AD4AEB418E0917C1357A3
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Suravee!

On 15/04/2021 10:28, Suthikulpanit, Suravee wrote:
> David,
> 
> On 4/14/2021 10:33 PM, David Coe wrote:
>> Hi Suravee!
>>
>> I've re-run your revert+update patch on Ubuntu's latest kernel 
>> 5.11.0-14 partly to check my mailer's 'mangling' hadn't also reached 
>> the code!
>>
>> There are 3 sets of results in the attachment, all for the Ryzen 
>> 2400G. The as-distributed kernel already incorporates your IOMMU RFCv3 
>> patch.
>>
>> A. As-distributed kernel (cold boot)
>>     >5 retries, so no IOMMU read/write capability, no amd_iommu events.
>>
>> B. As-distributed kernel (warm boot)
>>     <5 retries, amd_iommu running stats show large numbers as before.
>>
>> C. Revert+Update kernel
>>     amd_iommu events listed and also show large hit/miss numbers.
>>
>> In due course, I'll load the new (revert+update) kernel on the 4700G 
>> but won't overload your mail-box unless something unusual turns up.
>>
>> Best regards,
>>
> 
> For the Ryzen 2400G, could you please try with:
> - 1 event at a time
> - Not more than 8 events (On your system, it has 2 banks x 4 counters/bank.
> I am trying to see if this issue might be related to the counters 
> multiplexing).
> 
> Thanks,

Herewith similar one-at-a-time perf stat results for the Ryzen 4700U. As 
before, more than 8 events displays the third (%) column and (sometimes) 
'silly' numbers in the first column.

-- 
David

--------------CB5AD4AEB418E0917C1357A3
Content-Type: text/plain; charset=UTF-8;
 name="EventList-4700U.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="EventList-4700U.txt"

JCBzdWRvIC4vaW9tbXVfbGlzdC5zaAoKIFBlcmZvcm1hbmNlIGNvdW50ZXIgc3RhdHMgZm9yICdz
eXN0ZW0gd2lkZSc6CgogICAgICAgICAgICAgICAgMjAgICAgICBhbWRfaW9tbXVfMC9jbWRfcHJv
Y2Vzc2VkLwoKICAgICAgMTAuMDAzMDEwNjY2IHNlY29uZHMgdGltZSBlbGFwc2VkCgoKIFBlcmZv
cm1hbmNlIGNvdW50ZXIgc3RhdHMgZm9yICdzeXN0ZW0gd2lkZSc6CgogICAgICAgICAgICAgICAg
IDUgICAgICAgYW1kX2lvbW11XzAvY21kX3Byb2Nlc3NlZF9pbnYvCgogICAgICAxMC4wMDIzNDk0
NjQgc2Vjb25kcyB0aW1lIGVsYXBzZWQKCgogUGVyZm9ybWFuY2UgY291bnRlciBzdGF0cyBmb3Ig
J3N5c3RlbSB3aWRlJzoKCiAgICAgICAgICAgICAgICAgMCAgICAgICBhbWRfaW9tbXVfMC9pZ25f
cmRfd3JfbW1pb18xZmY4aC8KCiAgICAgIDEwLjAwMjM4NjEyOSBzZWNvbmRzIHRpbWUgZWxhcHNl
ZAoKCiBQZXJmb3JtYW5jZSBjb3VudGVyIHN0YXRzIGZvciAnc3lzdGVtIHdpZGUnOgoKICAgICAg
ICAgICAgICAgMzI1ICAgICAgIGFtZF9pb21tdV8wL2ludF9kdGVfaGl0LwoKICAgICAgMTAuMDAy
MzQ2NjMwIHNlY29uZHMgdGltZSBlbGFwc2VkCgoKIFBlcmZvcm1hbmNlIGNvdW50ZXIgc3RhdHMg
Zm9yICdzeXN0ZW0gd2lkZSc6CgogICAgICAgICAgICAgICAgIDIgICAgICAgYW1kX2lvbW11XzAv
aW50X2R0ZV9taXMvCgogICAgICAxMC4wMDIzNjU2NTYgc2Vjb25kcyB0aW1lIGVsYXBzZWQKCgog
UGVyZm9ybWFuY2UgY291bnRlciBzdGF0cyBmb3IgJ3N5c3RlbSB3aWRlJzoKCiAgICAgICAgICAg
ICAgIDM1NiAgICAgICBhbWRfaW9tbXVfMC9tZW1fZHRlX2hpdC8KCiAgICAgIDEwLjAwMjQyNjg2
NiBzZWNvbmRzIHRpbWUgZWxhcHNlZAoKCiBQZXJmb3JtYW5jZSBjb3VudGVyIHN0YXRzIGZvciAn
c3lzdGVtIHdpZGUnOgoKICAgICAgICAgICAgIDMsOTU1ICAgICAgIGFtZF9pb21tdV8wL21lbV9k
dGVfbWlzLwoKICAgICAgMTAuMDAyNzI5MDU4IHNlY29uZHMgdGltZSBlbGFwc2VkCgoKIFBlcmZv
cm1hbmNlIGNvdW50ZXIgc3RhdHMgZm9yICdzeXN0ZW0gd2lkZSc6CgogICAgICAgICAgICAgICAg
IDQgICAgICAgYW1kX2lvbW11XzAvbWVtX2lvbW11X3RsYl9wZGVfaGl0LwoKICAgICAgMTAuMDAy
NDIyNjEwIHNlY29uZHMgdGltZSBlbGFwc2VkCgoKIFBlcmZvcm1hbmNlIGNvdW50ZXIgc3RhdHMg
Zm9yICdzeXN0ZW0gd2lkZSc6CgogICAgICAgICAgICAgMSwzMjYgICAgICAgYW1kX2lvbW11XzAv
bWVtX2lvbW11X3RsYl9wZGVfbWlzLwoKICAgICAgMTAuMDAyMzk3MDQ1IHNlY29uZHMgdGltZSBl
bGFwc2VkCgoKIFBlcmZvcm1hbmNlIGNvdW50ZXIgc3RhdHMgZm9yICdzeXN0ZW0gd2lkZSc6Cgog
ICAgICAgICAgICAgMSwwMDkgICAgICAgYW1kX2lvbW11XzAvbWVtX2lvbW11X3RsYl9wdGVfaGl0
LwoKICAgICAgMTAuMDAyNDQ1MzQ3IHNlY29uZHMgdGltZSBlbGFwc2VkCgoKIFBlcmZvcm1hbmNl
IGNvdW50ZXIgc3RhdHMgZm9yICdzeXN0ZW0gd2lkZSc6CgogICAgICAgICAgICAgMSwwNzIgICAg
ICAgYW1kX2lvbW11XzAvbWVtX2lvbW11X3RsYl9wdGVfbWlzLwoKICAgICAgMTAuMDAyNDE0NzM0
IHNlY29uZHMgdGltZSBlbGFwc2VkCgoKIFBlcmZvcm1hbmNlIGNvdW50ZXIgc3RhdHMgZm9yICdz
eXN0ZW0gd2lkZSc6CgogICAgICAgICAgICAgICAgIDAgICAgICAgYW1kX2lvbW11XzAvbWVtX3Bh
c3NfZXhjbC8KCiAgICAgIDEwLjAwMjQzNTQ4MiBzZWNvbmRzIHRpbWUgZWxhcHNlZAoKCiBQZXJm
b3JtYW5jZSBjb3VudGVyIHN0YXRzIGZvciAnc3lzdGVtIHdpZGUnOgoKICAgICAgICAgICAgICAg
ICAwICAgICAgIGFtZF9pb21tdV8wL21lbV9wYXNzX3ByZXRyYW5zLwoKICAgICAgMTAuMDAyNDA5
OTU2IHNlY29uZHMgdGltZSBlbGFwc2VkCgoKIFBlcmZvcm1hbmNlIGNvdW50ZXIgc3RhdHMgZm9y
ICdzeXN0ZW0gd2lkZSc6CgogICAgICAgICAgICAgMyw0MDUgICAgICAgYW1kX2lvbW11XzAvbWVt
X3Bhc3NfdW50cmFucy8KCiAgICAgIDEwLjAwMjU2MzgxMiBzZWNvbmRzIHRpbWUgZWxhcHNlZAoK
CiBQZXJmb3JtYW5jZSBjb3VudGVyIHN0YXRzIGZvciAnc3lzdGVtIHdpZGUnOgoKICAgICAgICAg
ICAgICAgICAwICAgICAgIGFtZF9pb21tdV8wL21lbV90YXJnZXRfYWJvcnQvCgogICAgICAxMC4w
MDI0NzM2NTcgc2Vjb25kcyB0aW1lIGVsYXBzZWQKCgogUGVyZm9ybWFuY2UgY291bnRlciBzdGF0
cyBmb3IgJ3N5c3RlbSB3aWRlJzoKCiAgICAgICAgICAgICAxLDMxMSAgICAgICBhbWRfaW9tbXVf
MC9tZW1fdHJhbnNfdG90YWwvCgogICAgICAxMC4wMDI0NzE3ODcgc2Vjb25kcyB0aW1lIGVsYXBz
ZWQKCgogUGVyZm9ybWFuY2UgY291bnRlciBzdGF0cyBmb3IgJ3N5c3RlbSB3aWRlJzoKCiAgICAg
ICAgICAgICAgICAgMCAgICAgICBhbWRfaW9tbXVfMC9wYWdlX3RibF9yZWFkX2dzdC8KCiAgICAg
IDEwLjAwMjIxNjAzMyBzZWNvbmRzIHRpbWUgZWxhcHNlZAoKCiBQZXJmb3JtYW5jZSBjb3VudGVy
IHN0YXRzIGZvciAnc3lzdGVtIHdpZGUnOgoKICAgICAgICAgICAyNzYsNjA5ICAgICAgIGFtZF9p
b21tdV8wL3BhZ2VfdGJsX3JlYWRfbnN0LwoKICAgICAgMTAuMDAyMDI5MjYxIHNlY29uZHMgdGlt
ZSBlbGFwc2VkCgoKIFBlcmZvcm1hbmNlIGNvdW50ZXIgc3RhdHMgZm9yICdzeXN0ZW0gd2lkZSc6
CgogICAgICAgICAgIDEyNiwxNjEgICAgICAgYW1kX2lvbW11XzAvcGFnZV90YmxfcmVhZF90b3Qv
CgogICAgICAxMC4wMDM1NjkwMjkgc2Vjb25kcyB0aW1lIGVsYXBzZWQKCgogUGVyZm9ybWFuY2Ug
Y291bnRlciBzdGF0cyBmb3IgJ3N5c3RlbSB3aWRlJzoKCiAgICAgICAgICAgICAgICAgMCAgICAg
ICBhbWRfaW9tbXVfMC9zbWlfYmxrLwoKICAgICAgMTAuMDAxODcxODE4IHNlY29uZHMgdGltZSBl
bGFwc2VkCgoKIFBlcmZvcm1hbmNlIGNvdW50ZXIgc3RhdHMgZm9yICdzeXN0ZW0gd2lkZSc6Cgog
ICAgICAgICAgICAgICAgIDAgICAgICAgYW1kX2lvbW11XzAvc21pX3JlY3YvCgogICAgICAxMC4w
MDIyMTI4OTEgc2Vjb25kcyB0aW1lIGVsYXBzZWQKCgogUGVyZm9ybWFuY2UgY291bnRlciBzdGF0
cyBmb3IgJ3N5c3RlbSB3aWRlJzoKCiAgICAgICAgICAgICAgICAgMCAgICAgICBhbWRfaW9tbXVf
MC90bGJfaW52LwoKICAgICAgMTAuMDAyMzk2NjA2IHNlY29uZHMgdGltZSBlbGFwc2VkCgoKIFBl
cmZvcm1hbmNlIGNvdW50ZXIgc3RhdHMgZm9yICdzeXN0ZW0gd2lkZSc6CgogICAgICAgICAgICAg
ICAgIDAgICAgICAgYW1kX2lvbW11XzAvdmFwaWNfaW50X2d1ZXN0LwoKICAgICAgMTAuMDAyNDM1
MzA4IHNlY29uZHMgdGltZSBlbGFwc2VkCgoKIFBlcmZvcm1hbmNlIGNvdW50ZXIgc3RhdHMgZm9y
ICdzeXN0ZW0gd2lkZSc6CgogICAgICAgICAgICAgICAzNDAgICAgICAgYW1kX2lvbW11XzAvdmFw
aWNfaW50X25vbl9ndWVzdC8KCiAgICAgIDEwLjAwMjQwNTg2OCBzZWNvbmRzIHRpbWUgZWxhcHNl
ZAoKCiQgc3VkbyBwZXJmIHN0YXQgLWUgJ2FtZF9pb21tdV8wL21lbV9kdGVfaGl0LywgYW1kX2lv
bW11XzAvbWVtX2R0ZV9taXMvLCBhbWRfaW9tbXVfMC9tZW1faW9tbXVfdGxiX3BkZV9oaXQvLCBh
bWRfaW9tbXVfMC9tZW1faW9tbXVfdGxiX3BkZV9taXMvLCBhbWRfaW9tbXVfMC9tZW1faW9tbXVf
dGxiX3B0ZV9oaXQvLCBhbWRfaW9tbXVfMC9tZW1faW9tbXVfdGxiX3B0ZV9taXMvJyBzbGVlcCAx
MAoKIFBlcmZvcm1hbmNlIGNvdW50ZXIgc3RhdHMgZm9yICdzeXN0ZW0gd2lkZSc6CgogICAgICAg
ICAgICAgICAzNDUgICAgICAgYW1kX2lvbW11XzAvbWVtX2R0ZV9oaXQvCiAgICAgICAgICAgICAg
IDYwNiAgICAgICBhbWRfaW9tbXVfMC9tZW1fZHRlX21pcy8KICAgICAgICAgICAgICAgIDEwICAg
ICAgIGFtZF9pb21tdV8wL21lbV9pb21tdV90bGJfcGRlX2hpdC8KICAgICAgICAgICAgICAgOTEw
ICAgICAgIGFtZF9pb21tdV8wL21lbV9pb21tdV90bGJfcGRlX21pcy8KICAgICAgICAgICAgICAg
MTQwICAgICAgIGFtZF9pb21tdV8wL21lbV9pb21tdV90bGJfcHRlX2hpdC8KICAgICAgICAgICAg
ICAgNzk3ICAgICAgIGFtZF9pb21tdV8wL21lbV9pb21tdV90bGJfcHRlX21pcy8KCiAgICAgIDEw
LjAwMjU1Mzk2NiBzZWNvbmRzIHRpbWUgZWxhcHNlZAoKCiQgc3VkbyBwZXJmIHN0YXQgLWUgJ2Ft
ZF9pb21tdV8wL21lbV9kdGVfaGl0LywgYW1kX2lvbW11XzAvbWVtX2R0ZV9taXMvLCBhbWRfaW9t
bXVfMC9tZW1faW9tbXVfdGxiX3BkZV9oaXQvLCBhbWRfaW9tbXVfMC9tZW1faW9tbXVfdGxiX3Bk
ZV9taXMvLCBhbWRfaW9tbXVfMC9tZW1faW9tbXVfdGxiX3B0ZV9oaXQvLCBhbWRfaW9tbXVfMC9t
ZW1faW9tbXVfdGxiX3B0ZV9taXMvLCBhbWRfaW9tbXVfMC9tZW1fcGFzc19leGNsLywgYW1kX2lv
bW11XzAvbWVtX3Bhc3NfcHJldHJhbnMvLCBhbWRfaW9tbXVfMC9tZW1fcGFzc191bnRyYW5zLywg
YW1kX2lvbW11XzAvbWVtX3RhcmdldF9hYm9ydC8sIGFtZF9pb21tdV8wL21lbV90cmFuc190b3Rh
bC8nIHNsZWVwIDEwCgogUGVyZm9ybWFuY2UgY291bnRlciBzdGF0cyBmb3IgJ3N5c3RlbSB3aWRl
JzoKCiAgICAgICAgICAgICAgIDM0MCAgICAgICBhbWRfaW9tbXVfMC9tZW1fZHRlX2hpdC8gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKDcyLjY1JSkKICAgICAgICAgICAgICAg
Mzg5ICAgICAgIGFtZF9pb21tdV8wL21lbV9kdGVfbWlzLyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAoNzIuNjclKQogICAgICAgICAgICAgICAgIDggICAgICAgYW1kX2lvbW11
XzAvbWVtX2lvbW11X3RsYl9wZGVfaGl0LyAgICAgICAgICAgICAgICAgICAgICAgICAgICg3Mi43
MSUpCiAgICAgICAgICAgICAgIDg0OSAgICAgICBhbWRfaW9tbXVfMC9tZW1faW9tbXVfdGxiX3Bk
ZV9taXMvICAgICAgICAgICAgICAgICAgICAgICAgICAgKDcyLjc2JSkKICAgICAgICAgICAgICAg
IDk2ICAgICAgIGFtZF9pb21tdV8wL21lbV9pb21tdV90bGJfcHRlX2hpdC8gICAgICAgICAgICAg
ICAgICAgICAgICAgICAoNzIuNzglKQogICAgICAgICAgICAgICA3NDIgICAgICAgYW1kX2lvbW11
XzAvbWVtX2lvbW11X3RsYl9wdGVfbWlzLyAgICAgICAgICAgICAgICAgICAgICAgICAgICg3Mi43
NSUpCiAgICAgICAgICAgICAgICAgMCAgICAgICBhbWRfaW9tbXVfMC9tZW1fcGFzc19leGNsLyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKDcyLjc2JSkKICAgICAgICAgICAgICAg
ICAwICAgICAgIGFtZF9pb21tdV8wL21lbV9wYXNzX3ByZXRyYW5zLyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAoNzIuNzYlKQogICAgICAgICAgICAgICAgIDYgICAgICAgYW1kX2lvbW11
XzAvbWVtX3Bhc3NfdW50cmFucy8gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICg3Mi43
NyUpCiAgICAgICAgICAgICAgICAgMCAgICAgICBhbWRfaW9tbXVfMC9tZW1fdGFyZ2V0X2Fib3J0
LyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKDcyLjcxJSkKICAgICAgICAgICAgIDEs
MTIyICAgICAgIGFtZF9pb21tdV8wL21lbV90cmFuc190b3RhbC8gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAoNzIuNjklKQoKICAgICAgMTAuMDAyNDcxNDgwIHNlY29uZHMgdGltZSBl
bGFwc2VkCg==

--------------CB5AD4AEB418E0917C1357A3
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--------------CB5AD4AEB418E0917C1357A3--
