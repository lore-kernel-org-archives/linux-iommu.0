Return-Path: <SRS0=SOau=JM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708BFC433B4
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 14:40:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18A9E611F1
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 14:40:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18A9E611F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=live.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D913860605;
	Thu, 15 Apr 2021 14:40:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pPzym1TraIV1; Thu, 15 Apr 2021 14:40:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8EBFE600C6;
	Thu, 15 Apr 2021 14:40:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69E0BC000C;
	Thu, 15 Apr 2021 14:40:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47E87C000A
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 14:40:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 28DE060605
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 14:40:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cBUZMmdoCooE for <iommu@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 14:40:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-oln040092074050.outbound.protection.outlook.com [40.92.74.50])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8A482600C6
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 14:40:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cf5PQi+Vk/rmkrxlYPE8cruRUkesOJnDonOisDRiVvstq+Fms22hqN0hKAU0Frw2Sqcgc8Xf7Ar5qSRNYb8xBoQnFXUla9/WbTb9HlM4DzvDeF5KcvOroqrt1jWiG1MMwdKsd4AfTu8ZwnYL+tQ/FUpz1bkVXpTDd9jvO7r52/IL/V2YoHonTnQ0+/A4/CftMLdbAhY0q9OwBI8l9SVMleKfy2mEPxDXl9CBd5qAE8dJU+ohcK3aAvLU1bDkXJzfGxRLGK7VZc35KTKaI6sjeF/a21b5ouxYQL3s917HP71KAsjBr9WVzkssINGQU7gbROQRVyV5dHWSUQ2X1HwYnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLVkYDTXsyp7EH+tRXnWfX2QRt8xfF/J3aPHf/3+ap4=;
 b=licalVKeD0t7rCIP79JD8uCXJFOMILWg59bwCWhkdh+np35yvVY2MnIJtsgi0a5lryGKFG6MWugAaG2iWo5MfGvB3Z0errzFrCcqT+FTexKLYbl+WcZCAxElyAgdjTm8RtLKKy7lRn5O/UoeP9ZaokdRopvBAl1LM3bwXdNBUcWeT8f97wdZ9hD8C0/j8ufC5AdQRFpHjBWlS9Let9z4vQjh/FDPWYolhLENVPTGS1hGH2pNfwhWwGUd7bfEk3a/Acbx2meeU2au2HjyQF1fmb0lmnGkYQkeBH66GVDQ3Q1zg4SgmxArh/TotUdb0hqDSahLT/WY09wRHTH8otMsXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from VI1EUR04FT028.eop-eur04.prod.protection.outlook.com
 (2a01:111:e400:7e0e::4d) by
 VI1EUR04HT051.eop-eur04.prod.protection.outlook.com (2a01:111:e400:7e0e::116)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Thu, 15 Apr
 2021 14:39:57 +0000
Received: from VI1PR09MB2638.eurprd09.prod.outlook.com
 (2a01:111:e400:7e0e::40) by VI1EUR04FT028.mail.protection.outlook.com
 (2a01:111:e400:7e0e::316) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Thu, 15 Apr 2021 14:39:57 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:FE60C10E797D97C3FCCC1F075D5E52532CBF247A3FA64B9F650AD9585964C635;
 UpperCasedChecksum:1E41BFF004E9CF29BF4DF8689B0FF28E4EA1AED9216B182128FF4800B5557F06;
 SizeAsReceived:9313; Count:47
Received: from VI1PR09MB2638.eurprd09.prod.outlook.com
 ([fe80::948b:987c:566b:198e]) by VI1PR09MB2638.eurprd09.prod.outlook.com
 ([fe80::948b:987c:566b:198e%5]) with mapi id 15.20.4042.018; Thu, 15 Apr 2021
 14:39:56 +0000
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
Message-ID: <VI1PR09MB2638BB4B04BA50D0C7E71935C74D9@VI1PR09MB2638.eurprd09.prod.outlook.com>
Date: Thu, 15 Apr 2021 15:39:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <df6c8363-baac-5d97-5b06-4bcd3163f83d@amd.com>
Content-Type: multipart/mixed; boundary="------------0FF38B5D1F2E2C9E2B84D8DD"
Content-Language: en-GB
X-TMN: [pKcZWtV/9Afm+AjCBG2uRc2ziBahY/Co]
X-ClientProxiedBy: LO4P123CA0214.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::21) To VI1PR09MB2638.eurprd09.prod.outlook.com
 (2603:10a6:803:7b::27)
X-Microsoft-Original-Message-ID: <4e23e4be-eaae-8fb9-7dd0-9559f8c8e418@live.co.uk>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.6] (90.246.218.100) by
 LO4P123CA0214.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:1a5::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.21 via Frontend Transport; Thu, 15 Apr 2021 14:39:55 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 47
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 243d7741-d31e-4a7b-9f0a-08d9001c56c5
X-MS-TrafficTypeDiagnostic: VI1EUR04HT051:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qHljnYMWThyPbsdpnKsGVHOyRIgQvGCbPFsiHQJxLgnQJ8lVamsyY6aMoN9tcwfHu+NP1HAG6MUfuc4hrIn9EsGplJ/RSW4B8PoXLogzuoehvr3ogAsybLiYaM/g20rz4UTgrcJJBAUWQM0g1Ifzvn9/ABDgu2knc2yoyZ4VzmMemyzdD271zAOBSBYIh9b+NEMRJf77q24koP4d5rGgYXfZVP3LUwyk55JrnsknspFO1bLC5qnXK7i8N+vZsU7CvFkcqIbSftJTE/b4OHllxKarKLL//NEuWG8vQpT6Oe41spm9zv+RsrNtu0NxHDGONuZojBdvRM1HhV2G3KziTmPNVduGuB+fsSqw1lBovk2JE4ENXO3USJ6CUr2DKu8CCPEQWIJSp/mwPkkPViMRRA==
X-MS-Exchange-AntiSpam-MessageData: Q9BSEvm/A0AETy5uwh57l3UynYkgOA1qGFHAV0ltLLnHWF1Zy4L/J99ZzVNChvfa6SSu/mf3kSq0hJZNCyy9pKCemN10vG/c1f+rHCuPkwyP3esG3m34Ez676cOZ4aBMMgCgVoqaN3RuxOcPqow9uQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 243d7741-d31e-4a7b-9f0a-08d9001c56c5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2021 14:39:56.7940 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR04FT028.eop-eur04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1EUR04HT051
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

--------------0FF38B5D1F2E2C9E2B84D8DD
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

I think you've put your finger on it, Suravee!

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

Attached are the results you requested for the 2400G along with a tiny 
shell-script.

One event at a time and various batches of less than 8 events produce 
unexceptionable data. One final batch of 10 events and (hoopla) up go 
the counter stats.

Will you be doing something in mitigation or does this just go with the 
patch? Is there anything further you need from me? I'll run the script 
on the 4700U but I don't expect surprises :-).

All most appreciated,

-- 
David

--------------0FF38B5D1F2E2C9E2B84D8DD
Content-Type: application/x-shellscript;
 name="iommu_list.sh"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="iommu_list.sh"

IyEgIC9iaW4vYmFzaApFdmVudExpc3Q9ImFtZF9pb21tdV8wL2NtZF9wcm9jZXNzZWQvLCBhbWRf
aW9tbXVfMC9jbWRfcHJvY2Vzc2VkX2ludi8sIGFtZF9pb21tdV8wL2lnbl9yZF93cl9tbWlvXzFm
ZjhoLywgYW1kX2lvbW11XzAvaW50X2R0ZV9oaXQvLCBhbWRfaW9tbXVfMC9pbnRfZHRlX21pcy8s
IGFtZF9pb21tdV8wL21lbV9kdGVfaGl0LywgYW1kX2lvbW11XzAvbWVtX2R0ZV9taXMvLCBhbWRf
aW9tbXVfMC9tZW1faW9tbXVfdGxiX3BkZV9oaXQvLCBhbWRfaW9tbXVfMC9tZW1faW9tbXVfdGxi
X3BkZV9taXMvLCBhbWRfaW9tbXVfMC9tZW1faW9tbXVfdGxiX3B0ZV9oaXQvLCBhbWRfaW9tbXVf
MC9tZW1faW9tbXVfdGxiX3B0ZV9taXMvLCBhbWRfaW9tbXVfMC9tZW1fcGFzc19leGNsLywgYW1k
X2lvbW11XzAvbWVtX3Bhc3NfcHJldHJhbnMvLCBhbWRfaW9tbXVfMC9tZW1fcGFzc191bnRyYW5z
LywgYW1kX2lvbW11XzAvbWVtX3RhcmdldF9hYm9ydC8sIGFtZF9pb21tdV8wL21lbV90cmFuc190
b3RhbC8sIGFtZF9pb21tdV8wL3BhZ2VfdGJsX3JlYWRfZ3N0LywgYW1kX2lvbW11XzAvcGFnZV90
YmxfcmVhZF9uc3QvLCBhbWRfaW9tbXVfMC9wYWdlX3RibF9yZWFkX3RvdC8sIGFtZF9pb21tdV8w
L3NtaV9ibGsvLCBhbWRfaW9tbXVfMC9zbWlfcmVjdi8sIGFtZF9pb21tdV8wL3RsYl9pbnYvLCBh
bWRfaW9tbXVfMC92YXBpY19pbnRfZ3Vlc3QvLCBhbWRfaW9tbXVfMC92YXBpY19pbnRfbm9uX2d1
ZXN0LyIKU2VwYXJhdG9yPSRJRlMKCklGUz0sCmZvciBldmVudCBpbiAkRXZlbnRMaXN0Owpkbwog
IHBlcmYgc3RhdCAtZSAkZXZlbnQgc2xlZXAgMTAKZG9uZQoKSUZTPSRTZXBhcmF0b3IK

--------------0FF38B5D1F2E2C9E2B84D8DD
Content-Type: text/plain; charset=UTF-8;
 name="EventList.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="EventList.txt"

JCBzdWRvIC4vaW9tbXVfbGlzdC5zaAoKIFBlcmZvcm1hbmNlIGNvdW50ZXIgc3RhdHMgZm9yICdz
eXN0ZW0gd2lkZSc6CgogICAgICAgICAgICAgICAgMTIgICAgICBhbWRfaW9tbXVfMC9jbWRfcHJv
Y2Vzc2VkLwoKICAgICAgMTAuMDAxMjY2ODUxIHNlY29uZHMgdGltZSBlbGFwc2VkCgoKIFBlcmZv
cm1hbmNlIGNvdW50ZXIgc3RhdHMgZm9yICdzeXN0ZW0gd2lkZSc6CgogICAgICAgICAgICAgICAg
MTEgICAgICAgYW1kX2lvbW11XzAvY21kX3Byb2Nlc3NlZF9pbnYvCgogICAgICAxMC4wMDEyNTkw
NDkgc2Vjb25kcyB0aW1lIGVsYXBzZWQKCgogUGVyZm9ybWFuY2UgY291bnRlciBzdGF0cyBmb3Ig
J3N5c3RlbSB3aWRlJzoKCiAgICAgICAgICAgICAgICAgMCAgICAgICBhbWRfaW9tbXVfMC9pZ25f
cmRfd3JfbW1pb18xZmY4aC8KCiAgICAgIDEwLjAwMDc5MTgxMCBzZWNvbmRzIHRpbWUgZWxhcHNl
ZAoKCiBQZXJmb3JtYW5jZSBjb3VudGVyIHN0YXRzIGZvciAnc3lzdGVtIHdpZGUnOgoKICAgICAg
ICAgICAgICAgMzUwICAgICAgIGFtZF9pb21tdV8wL2ludF9kdGVfaGl0LwoKICAgICAgMTAuMDAw
ODQ4NDM3IHNlY29uZHMgdGltZSBlbGFwc2VkCgoKIFBlcmZvcm1hbmNlIGNvdW50ZXIgc3RhdHMg
Zm9yICdzeXN0ZW0gd2lkZSc6CgogICAgICAgICAgICAgICAgMTYgICAgICAgYW1kX2lvbW11XzAv
aW50X2R0ZV9taXMvCgogICAgICAxMC4wMDEyNzE5ODkgc2Vjb25kcyB0aW1lIGVsYXBzZWQKCgog
UGVyZm9ybWFuY2UgY291bnRlciBzdGF0cyBmb3IgJ3N5c3RlbSB3aWRlJzoKCiAgICAgICAgICAg
ICAgIDM0OCAgICAgICBhbWRfaW9tbXVfMC9tZW1fZHRlX2hpdC8KCiAgICAgIDEwLjAwMDgwODA3
NCBzZWNvbmRzIHRpbWUgZWxhcHNlZAoKCiBQZXJmb3JtYW5jZSBjb3VudGVyIHN0YXRzIGZvciAn
c3lzdGVtIHdpZGUnOgoKICAgICAgICAgICAyMTEsOTI1ICAgICAgIGFtZF9pb21tdV8wL21lbV9k
dGVfbWlzLwoKICAgICAgMTAuMDAwOTE1MzYyIHNlY29uZHMgdGltZSBlbGFwc2VkCgoKIFBlcmZv
cm1hbmNlIGNvdW50ZXIgc3RhdHMgZm9yICdzeXN0ZW0gd2lkZSc6CgogICAgICAgICAgICAgICAg
MzAgICAgICAgYW1kX2lvbW11XzAvbWVtX2lvbW11X3RsYl9wZGVfaGl0LwoKICAgICAgMTAuMDAx
NTIwNTk3IHNlY29uZHMgdGltZSBlbGFwc2VkCgoKIFBlcmZvcm1hbmNlIGNvdW50ZXIgc3RhdHMg
Zm9yICdzeXN0ZW0gd2lkZSc6CgogICAgICAgICAgICAgICA0NTAgICAgICAgYW1kX2lvbW11XzAv
bWVtX2lvbW11X3RsYl9wZGVfbWlzLwoKICAgICAgMTAuMDAwODc3NDkzIHNlY29uZHMgdGltZSBl
bGFwc2VkCgoKIFBlcmZvcm1hbmNlIGNvdW50ZXIgc3RhdHMgZm9yICdzeXN0ZW0gd2lkZSc6Cgog
ICAgICAgICAgICAxMCw5NTMgICAgICAgYW1kX2lvbW11XzAvbWVtX2lvbW11X3RsYl9wdGVfaGl0
LwoKICAgICAgMTAuMDAwODMxODAyIHNlY29uZHMgdGltZSBlbGFwc2VkCgoKIFBlcmZvcm1hbmNl
IGNvdW50ZXIgc3RhdHMgZm9yICdzeXN0ZW0gd2lkZSc6CgogICAgICAgICAgICAxMywyMzUgICAg
ICAgYW1kX2lvbW11XzAvbWVtX2lvbW11X3RsYl9wdGVfbWlzLwoKICAgICAgMTAuMDAxMjkyMDAz
IHNlY29uZHMgdGltZSBlbGFwc2VkCgoKIFBlcmZvcm1hbmNlIGNvdW50ZXIgc3RhdHMgZm9yICdz
eXN0ZW0gd2lkZSc6CgogICAgICAgICAgICAgICAgIDAgICAgICAgYW1kX2lvbW11XzAvbWVtX3Bh
c3NfZXhjbC8KCiAgICAgIDEwLjAwMDgzNjAwMCBzZWNvbmRzIHRpbWUgZWxhcHNlZAoKCiBQZXJm
b3JtYW5jZSBjb3VudGVyIHN0YXRzIGZvciAnc3lzdGVtIHdpZGUnOgoKICAgICAgICAgICAgICAg
ICAwICAgICAgIGFtZF9pb21tdV8wL21lbV9wYXNzX3ByZXRyYW5zLwoKICAgICAgMTAuMDAwNzk5
ODg3IHNlY29uZHMgdGltZSBlbGFwc2VkCgoKIFBlcmZvcm1hbmNlIGNvdW50ZXIgc3RhdHMgZm9y
ICdzeXN0ZW0gd2lkZSc6CgogICAgICAgICAgICAxMiwyODMgICAgICAgYW1kX2lvbW11XzAvbWVt
X3Bhc3NfdW50cmFucy8KCiAgICAgIDEwLjAwMDgxNTMzOSBzZWNvbmRzIHRpbWUgZWxhcHNlZAoK
CiBQZXJmb3JtYW5jZSBjb3VudGVyIHN0YXRzIGZvciAnc3lzdGVtIHdpZGUnOgoKICAgICAgICAg
ICAgICAgICAwICAgICAgIGFtZF9pb21tdV8wL21lbV90YXJnZXRfYWJvcnQvCgogICAgICAxMC4w
MDEyMDUxNjggc2Vjb25kcyB0aW1lIGVsYXBzZWQKCgogUGVyZm9ybWFuY2UgY291bnRlciBzdGF0
cyBmb3IgJ3N5c3RlbSB3aWRlJzoKCiAgICAgICAgICAgICAxLDMzMyAgICAgICBhbWRfaW9tbXVf
MC9tZW1fdHJhbnNfdG90YWwvCgogICAgICAxMC4wMDA5MTUzNTkgc2Vjb25kcyB0aW1lIGVsYXBz
ZWQKCgogUGVyZm9ybWFuY2UgY291bnRlciBzdGF0cyBmb3IgJ3N5c3RlbSB3aWRlJzoKCiAgICAg
ICAgICAgICAgICAgMCAgICAgICBhbWRfaW9tbXVfMC9wYWdlX3RibF9yZWFkX2dzdC8KCiAgICAg
IDEwLjAwMTI0ODIzNSBzZWNvbmRzIHRpbWUgZWxhcHNlZAoKCiBQZXJmb3JtYW5jZSBjb3VudGVy
IHN0YXRzIGZvciAnc3lzdGVtIHdpZGUnOgoKICAgICAgICAgICAgICAgIDY1ICAgICAgIGFtZF9p
b21tdV8wL3BhZ2VfdGJsX3JlYWRfbnN0LwoKICAgICAgMTAuMDAxMjY2NDExIHNlY29uZHMgdGlt
ZSBlbGFwc2VkCgoKIFBlcmZvcm1hbmNlIGNvdW50ZXIgc3RhdHMgZm9yICdzeXN0ZW0gd2lkZSc6
CgogICAgICAgICAgICAgICAgNzggICAgICAgYW1kX2lvbW11XzAvcGFnZV90YmxfcmVhZF90b3Qv
CgogICAgICAxMC4wMDEyNzI0MDYgc2Vjb25kcyB0aW1lIGVsYXBzZWQKCgogUGVyZm9ybWFuY2Ug
Y291bnRlciBzdGF0cyBmb3IgJ3N5c3RlbSB3aWRlJzoKCiAgICAgICAgICAgICAgICAgMCAgICAg
ICBhbWRfaW9tbXVfMC9zbWlfYmxrLwoKICAgICAgMTAuMDAxMjgyOTEyIHNlY29uZHMgdGltZSBl
bGFwc2VkCgoKIFBlcmZvcm1hbmNlIGNvdW50ZXIgc3RhdHMgZm9yICdzeXN0ZW0gd2lkZSc6Cgog
ICAgICAgICAgICAgICAgIDAgICAgICAgYW1kX2lvbW11XzAvc21pX3JlY3YvCgogICAgICAxMC4w
MDEyMjMxOTMgc2Vjb25kcyB0aW1lIGVsYXBzZWQKCgogUGVyZm9ybWFuY2UgY291bnRlciBzdGF0
cyBmb3IgJ3N5c3RlbSB3aWRlJzoKCiAgICAgICAgICAgICAgICAgMCAgICAgICBhbWRfaW9tbXVf
MC90bGJfaW52LwoKICAgICAgMTAuMDAxMjM0ODUzIHNlY29uZHMgdGltZSBlbGFwc2VkCgoKIFBl
cmZvcm1hbmNlIGNvdW50ZXIgc3RhdHMgZm9yICdzeXN0ZW0gd2lkZSc6CgogICAgICAgICAgICAg
ICAgIDAgICAgICAgYW1kX2lvbW11XzAvdmFwaWNfaW50X2d1ZXN0LwoKICAgICAgMTAuMDAwODQ4
MDgxIHNlY29uZHMgdGltZSBlbGFwc2VkCgoKIFBlcmZvcm1hbmNlIGNvdW50ZXIgc3RhdHMgZm9y
ICdzeXN0ZW0gd2lkZSc6CgogICAgICAgICAgICAgICA0MjggICAgICAgYW1kX2lvbW11XzAvdmFw
aWNfaW50X25vbl9ndWVzdC8KCiAgICAgIDEwLjAwMDgwNjA0MSBzZWNvbmRzIHRpbWUgZWxhcHNl
ZAoKCiQgc3VkbyBwZXJmIHN0YXQgLWUgJ2FtZF9pb21tdV8wL2NtZF9wcm9jZXNzZWQvLCBhbWRf
aW9tbXVfMC9jbWRfcHJvY2Vzc2VkX2ludi8sIGFtZF9pb21tdV8wL2lnbl9yZF93cl9tbWlvXzFm
ZjhoLywgYW1kX2lvbW11XzAvaW50X2R0ZV9oaXQvLCBhbWRfaW9tbXVfMC9pbnRfZHRlX21pcy8s
IGFtZF9pb21tdV8wL21lbV9kdGVfaGl0LywgYW1kX2lvbW11XzAvbWVtX2R0ZV9taXMvJyBzbGVl
cCAxMAogClBlcmZvcm1hbmNlIGNvdW50ZXIgc3RhdHMgZm9yICdzeXN0ZW0gd2lkZSc6CgogICAg
ICAgICAgICAgICAgMTYgICAgICAgYW1kX2lvbW11XzAvY21kX3Byb2Nlc3NlZC8gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgIDggICAgICAgYW1kX2lv
bW11XzAvY21kX3Byb2Nlc3NlZF9pbnYvICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAKICAgICAgICAgICAgICAgICAwICAgICAgIGFtZF9pb21tdV8wL2lnbl9yZF93cl9tbWlvXzFm
ZjhoLyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgIDM1
OCAgICAgICBhbWRfaW9tbXVfMC9pbnRfZHRlX2hpdC8gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIAogICAgICAgICAgICAgICAgMTAgICAgICAgYW1kX2lvbW11XzAvaW50X2R0ZV9t
aXMvICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgNDY1
ICAgICAgIGFtZF9pb21tdV8wL21lbV9kdGVfaGl0LyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgCiAgICAgICAgICAgICA0LDI5NiAgICAgICBhbWRfaW9tbXVfMC9tZW1fZHRlX21p
cy8gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAoKICAgICAgMTAuMDAxMjk3NTcw
IHNlY29uZHMgdGltZSBlbGFwc2VkCgoKJCBzdWRvIHBlcmYgc3RhdCAtZSAnYW1kX2lvbW11XzAv
bWVtX2lvbW11X3RsYl9wZGVfaGl0LywgYW1kX2lvbW11XzAvbWVtX2lvbW11X3RsYl9wZGVfbWlz
LywgYW1kX2lvbW11XzAvbWVtX2lvbW11X3RsYl9wdGVfaGl0LywgYW1kX2lvbW11XzAvbWVtX2lv
bW11X3RsYl9wdGVfbWlzLywgYW1kX2lvbW11XzAvbWVtX3Bhc3NfZXhjbC8sIGFtZF9pb21tdV8w
L21lbV9wYXNzX3ByZXRyYW5zLywgYW1kX2lvbW11XzAvbWVtX3Bhc3NfdW50cmFucy8nIHNsZWVw
IDEwCgpQZXJmb3JtYW5jZSBjb3VudGVyIHN0YXRzIGZvciAnc3lzdGVtIHdpZGUnOgoKICAgICAg
ICAgICAgICAgIDI0ICAgICAgIGFtZF9pb21tdV8wL21lbV9pb21tdV90bGJfcGRlX2hpdC8gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICA0MDcgICAgICAg
YW1kX2lvbW11XzAvbWVtX2lvbW11X3RsYl9wZGVfbWlzLyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgCiAgICAgICAgICAgICAgIDQ3OCAgICAgICBhbWRfaW9tbXVfMC9tZW1faW9t
bXVfdGxiX3B0ZV9oaXQvICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAg
ICAgICAgIDcsMTEzICAgICAgIGFtZF9pb21tdV8wL21lbV9pb21tdV90bGJfcHRlX21pcy8gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgIDAgICAgICAg
YW1kX2lvbW11XzAvbWVtX3Bhc3NfZXhjbC8gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIAogICAgICAgICAgICAgICAgIDAgICAgICAgYW1kX2lvbW11XzAvbWVtX3Bhc3NfcHJldHJh
bnMvICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgIDcsMDQw
ICAgICAgIGFtZF9pb21tdV8wL21lbV9wYXNzX3VudHJhbnMvICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAKCiAgICAgIDEwLjAwMTI0NjQ4OSBzZWNvbmRzIHRpbWUgZWxhcHNlZAoK
JCBzdWRvIHBlcmYgc3RhdCAtZSAnYW1kX2lvbW11XzAvbWVtX3RhcmdldF9hYm9ydC8sIGFtZF9p
b21tdV8wL21lbV90cmFuc190b3RhbC8sIGFtZF9pb21tdV8wL3BhZ2VfdGJsX3JlYWRfZ3N0Lywg
YW1kX2lvbW11XzAvcGFnZV90YmxfcmVhZF9uc3QvLCBhbWRfaW9tbXVfMC9wYWdlX3RibF9yZWFk
X3RvdC8nIHNsZWVwIDEwCgpQZXJmb3JtYW5jZSBjb3VudGVyIHN0YXRzIGZvciAnc3lzdGVtIHdp
ZGUnOgoKICAgICAgICAgICAgICAgICAwICAgICAgIGFtZF9pb21tdV8wL21lbV90YXJnZXRfYWJv
cnQvICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgIDEsODk4
ICAgICAgIGFtZF9pb21tdV8wL21lbV90cmFuc190b3RhbC8gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgIDAgICAgICAgYW1kX2lvbW11XzAvcGFnZV90
YmxfcmVhZF9nc3QvICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAg
ICAgICAgMTQwICAgICAgIGFtZF9pb21tdV8wL3BhZ2VfdGJsX3JlYWRfbnN0LyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgIDE0MCAgICAgICBhbWRfaW9t
bXVfMC9wYWdlX3RibF9yZWFkX3RvdC8gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IAoKICAgICAgMTAuMDAxMjk1NTI2IHNlY29uZHMgdGltZSBlbGFwc2VkCgoKJCBzdWRvIHBlcmYg
c3RhdCAtZSAnYW1kX2lvbW11XzAvc21pX2Jsay8sIGFtZF9pb21tdV8wL3NtaV9yZWN2LywgYW1k
X2lvbW11XzAvdGxiX2ludi8sIGFtZF9pb21tdV8wL3ZhcGljX2ludF9ndWVzdC8sIGFtZF9pb21t
dV8wL3ZhcGljX2ludF9ub25fZ3Vlc3QvJyBzbGVlcCAxMAoKUGVyZm9ybWFuY2UgY291bnRlciBz
dGF0cyBmb3IgJ3N5c3RlbSB3aWRlJzoKCiAgICAgICAgICAgICAgICAgMCAgICAgICBhbWRfaW9t
bXVfMC9zbWlfYmxrLyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAg
ICAgICAgICAgICAgICAwICAgICAgIGFtZF9pb21tdV8wL3NtaV9yZWN2LyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgMCAgICAgICBhbWRfaW9t
bXVfMC90bGJfaW52LyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAg
ICAgICAgICAgICAgIDAgICAgICAgYW1kX2lvbW11XzAvdmFwaWNfaW50X2d1ZXN0LyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgIDQzMyAgICAgICBhbWRf
aW9tbXVfMC92YXBpY19pbnRfbm9uX2d1ZXN0LyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgCgogICAgICAxMC4wMDEyODY1MTUgc2Vjb25kcyB0aW1lIGVsYXBzZWQKCgokIHN1ZG8g
cGVyZiBzdGF0IC1lICdhbWRfaW9tbXVfMC9tZW1fdGFyZ2V0X2Fib3J0LywgYW1kX2lvbW11XzAv
bWVtX3RyYW5zX3RvdGFsLywgYW1kX2lvbW11XzAvcGFnZV90YmxfcmVhZF9nc3QvLCBhbWRfaW9t
bXVfMC9wYWdlX3RibF9yZWFkX25zdC8sIGFtZF9pb21tdV8wL3BhZ2VfdGJsX3JlYWRfdG90Lywg
YW1kX2lvbW11XzAvc21pX2Jsay8sIGFtZF9pb21tdV8wL3NtaV9yZWN2LywgYW1kX2lvbW11XzAv
dGxiX2ludi8sIGFtZF9pb21tdV8wL3ZhcGljX2ludF9ndWVzdC8sIGFtZF9pb21tdV8wL3ZhcGlj
X2ludF9ub25fZ3Vlc3QvJyBzbGVlcCAxMCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAoKUGVyZm9ybWFuY2UgY291
bnRlciBzdGF0cyBmb3IgJ3N5c3RlbSB3aWRlJzoKCiAgICAgICAgICAgICAgICAgIDAgICAgICAg
YW1kX2lvbW11XzAvbWVtX3RhcmdldF9hYm9ydC8gICAgICAgICAoODAuMDAlKQo3MDMsNjUwLDM0
Miw1MTAsODEwICAgICAgIGFtZF9pb21tdV8wL21lbV90cmFuc190b3RhbC8gICAgICAgICAgKDgw
LjAwJSkKICAgICAgICAgICAgICAgICAgMCAgICAgICBhbWRfaW9tbXVfMC9wYWdlX3RibF9yZWFk
X2dzdC8gICAgICAgICg4MC4wMCUpCjM1MSw4MzksNTcyLDg1Nyw4NDIgICAgICAgYW1kX2lvbW11
XzAvcGFnZV90YmxfcmVhZF9uc3QvICAgICAgICAoODAuMDAlKQozNTEsODQ5LDk3MywzMzIsMzA5
ICAgICAgIGFtZF9pb21tdV8wL3BhZ2VfdGJsX3JlYWRfdG90LyAgICAgICAgKDgwLjAwJSkKICAg
ICAgICAgICAgICAgICAgMCAgICAgICBhbWRfaW9tbXVfMC9zbWlfYmxrLyAgICAgICAgICAgICAg
ICAgICg4MC4wMCUpCiAgICAgICAgICAgICAgICAgIDAgICAgICAgYW1kX2lvbW11XzAvc21pX3Jl
Y3YvICAgICAgICAgICAgICAgICAoODAuMDAlKQogICAgICAgICAgICAgICAgICAwICAgICAgIGFt
ZF9pb21tdV8wL3RsYl9pbnYvICAgICAgICAgICAgICAgICAgKDgwLjAwJSkKICAgICAgICAgICAg
ICAgICAgMCAgICAgICBhbWRfaW9tbXVfMC92YXBpY19pbnRfZ3Vlc3QvICAgICAgICAgICg4MC4w
MCUpCjcwMyw3MjAsNzYzLDcyMiwyODggICAgICAgYW1kX2lvbW11XzAvdmFwaWNfaW50X25vbl9n
dWVzdC8gICAgICAoODAuMDAlKQoKICAgICAgMTAuMDAwNzkwNzYyIHNlY29uZHMgdGltZSBlbGFw
c2VkCg==

--------------0FF38B5D1F2E2C9E2B84D8DD
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--------------0FF38B5D1F2E2C9E2B84D8DD--
