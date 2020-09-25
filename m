Return-Path: <SRS0=3fVv=DC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B58EC4363D
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 09:59:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E392E2087D
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 09:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="se0Y8Lp+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E392E2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A791282494;
	Fri, 25 Sep 2020 09:59:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NanokdBSt69Y; Fri, 25 Sep 2020 09:59:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EFE5884439;
	Fri, 25 Sep 2020 09:59:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB850C0890;
	Fri, 25 Sep 2020 09:59:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A74DC0859
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 09:59:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5422886860
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 09:59:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hr5yOWIIxnuY for <iommu@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 09:59:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D90B3868F0
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 09:59:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7jwqbovKAVCVp9a4BbtQ3k2U6860YlHJEha7EsSj52QAwI0d/dgNCiWjpHKND/WEfNOAHp526AnYBJz3+hUpimQo5DV3LiuWy6XfZ4cMgED2TnT6dOmTRsqka+++idho+IkmbH6WMkVJYgmAbT4Z3xF8euY9t8BdSmtQ1YHqBTUP/QpHG3Ka7a6ovt35F2LhRm9b6/sWgNvIUg2kvcHcOO71iUQKKD1Jim7CQ0RNONRwUeVV3PbbrWfyxlCSUXjmq3uu2rX1aB1Wf/OxCnZCvaqfBZ7lCaLRqH245GIB73U8EayTaSKRsIHNN7mN+pJqvG5UkR0f+9LJrpj17ZJ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCRHQVW0zDwQ+WT+4LCafY+uSCXYvjBkOIiCiAUSFB4=;
 b=TOzQEZ1OmyzEGCOIUL4nhQdTMx5MZJFa96708V2qqDW1TJvFJ0vtd/skBkSkaSVUPS6pk3gOSKXN4K1SaljceFTxkEx/v5mDhMy4nNkl7oNUGljioJAIoiX5iJSq5r4TbZckmD40+bAlmMCTDC4WJJxBEQ5uIipQXUerRImuwVDFKRkiVTSu3kzoQxVoR9gHFmu6mu/DIme0lC+OjNuv3GChFI/EW8bYcbTHNkPcnJn7ynTICqjShIpn8F2A/J+tq+jNvgvv3lSFFnJ3j34igyuArTTeN3WXol1pARATiOFa0plfmPbYV02w+84LdnFtpC0s8nH5TGh5aMEYcofqvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCRHQVW0zDwQ+WT+4LCafY+uSCXYvjBkOIiCiAUSFB4=;
 b=se0Y8Lp+DxUsqUEb9VdeJDkt7/Illo3ExRB7KUNL6eA5aE6CO6uTuO6fHO0Gqi0fpFsNsQzUUVlCGcbVgKNRBLViFdTvja49zIZtYqJropRSKgMxTm0PVlgjEqnvyYB0KhzC5fQzx3aJZFA4PXzJi1vXzIN+VmvaSdPAX23GIBM=
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR1201MB0220.namprd12.prod.outlook.com (2603:10b6:4:4e::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14; Fri, 25 Sep 2020 09:59:14 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3412.024; Fri, 25 Sep 2020
 09:59:14 +0000
Subject: Re: [PATCH 02/13] iommu: amd: Prepare for generic IO page table
 framework
To: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org
References: <20200923101442.73157-1-suravee.suthikulpanit@amd.com>
 <20200923101442.73157-3-suravee.suthikulpanit@amd.com>
 <a2e28845-d162-281a-c762-698d1750bbea@arm.com>
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <af467992-8b37-0900-a0cf-cbfbfc948d0d@amd.com>
Date: Fri, 25 Sep 2020 16:58:53 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
In-Reply-To: <a2e28845-d162-281a-c762-698d1750bbea@arm.com>
Content-Language: en-US
X-Originating-IP: [165.204.80.7]
X-ClientProxiedBy: KL1PR01CA0127.apcprd01.prod.exchangelabs.com
 (2603:1096:820:4::19) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Suravees-MacBook-Pro.local (165.204.80.7) by
 KL1PR01CA0127.apcprd01.prod.exchangelabs.com (2603:1096:820:4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Fri, 25 Sep 2020 09:59:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b292f264-6e62-4dc9-b4cc-08d86139a88e
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0220:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0220EEA7AF30A65093186CD6F3360@DM5PR1201MB0220.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9jwL9wRR46mwBoZY3tt1zS/Ilqq8ix1+gA2x8efZ6uzzYo7PLOAVEuE1/FnN7aAusRlYFUgr6IB9RfM2NE4g+p7OU8A1WyVm6I45xvdxFga3zOhVUGZ8kLapdecE4wq8fx05QUf5KNhq4AzPjcqFWUHYJ5j0kRdNNx7rVGcaJIFiNB4spSsIHyEXajAISZZbZE2ft8sEd5DbWu1yfY5tPIaXHlGf0Kvc7mchnU4ZvWGrH8GXmWykNGKltDg8TNAsaFZLy1jdY25arNX4gZ246pymMAxYalfx54dzmybXbwnDDA4rEKXDaG23WPs+vN+8a3SS03N5V+7V/HdEJf1/ErTmQ9Y33Jv9t8rsikHqTD9L8W9KVwbWyWDMUSvwjiUrr0XQEB7lHBZGflgYR2+CeYAP7+BXnEBDolt5xsm2kGbs/8daK9TtXyoo7gh/vVjdyDDCB3PSKGEvkKPyMLM1QQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(86362001)(8936002)(66946007)(6666004)(2906002)(6512007)(26005)(31696002)(66476007)(31686004)(186003)(8676002)(66556008)(5660300002)(53546011)(956004)(6486002)(478600001)(16526019)(44832011)(316002)(2616005)(36756003)(52116002)(6506007)(41533002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: weNmVd7+tgoO/3e15SRcTVSCmy2OtQw8j81L6dIhYheHMSnsxOkaBnKar/0VGWrKHRBxjgsF45tvM3OGcMmSq+fFZzg0ZpZYWpO2lgwPDNvAIo2PmS4OKV9d1jkJAeXsCWkMKUbpeVLLgTrLR3KnQa61y6CcfXIYto8AsweDXHK8kuQS/7dIx5RoTTKyiWVCSy43BblBfyH78fDq+H+d4cm8jmFZKBH2gpQ/nkksfBBC9vRpGkpv2Srf3nrk3okcUStxlVbkmu8AdhpLqnhVKIs2A/c609/1cNWcWSOlwF5BBlHZLK5VTnMnvDZ1/Xv2qW17eyMu3E0SSd4QO0MvqkdMfA3j2hyMFs1F0W7nOi6pEdP2WNJS6sySwG3O7JYpFOLLwB15N7P2V7/tHNvOzrQLThDfrFVbUt+jB526hUh8Az4zxQmsyxn9wKPWmy2fAj+HfRr+dRv8SvXVFi11EQ+FBpTu/AV6QMOg8vHyAdf7OgkqaMhg2iYkdKhzReiJ/G2h1rwBntq1PHtEZhJYMMwHpqvaa1AgdFIhMHkVH7lw4FuK9sNgbwxpfSu1Bg62wYCsTtXz4XUBZJzRbfreRfdgtMoQ32fw9BEORcaBT2HGeKxceW+oUzGUsumIoopr3jNd+eBJrFHCj3DhbOOv3g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b292f264-6e62-4dc9-b4cc-08d86139a88e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 09:59:14.3479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h2zJFh3YN7EeBMEBE31dfwKGyo9GCwoFvkhXFMm29CE4UveqzQPFCni3qSvCoVqJNBmRC6Ly3bnlAL1+5arpHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0220
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Um9iaW4sCgpPbiA5LzI0LzIwIDc6MjUgUE0sIFJvYmluIE11cnBoeSB3cm90ZToKPj4gK3N0cnVj
dMKgaW9fcGd0YWJsZV9vcHPCoCphbWRfaW9tbXVfc2V0dXBfaW9fcGd0YWJsZV9vcHMoc3RydWN0
wqBpb21tdV9kZXZfZGF0YcKgKmRldl9kYXRhLAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3TCoHByb3RlY3Rpb25fZG9tYWluwqAqZG9t
YWluKQo+PiArewo+PiArwqDCoMKgwqDCoMKgwqDCoGRvbWFpbi0+aW9wLnBndGJsX2NmZ8KgPcKg
KHN0cnVjdMKgaW9fcGd0YWJsZV9jZmcpwqB7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgLnBnc2l6ZV9i
aXRtYXDCoMKgwqDCoD3CoEFNRF9JT01NVV9QR1NJWkVTLAo+PiArwqDCoMKgwqDCoMKgwqDCoC5p
YXPCoMKgwqDCoMKgwqDCoMKgPcKgSU9NTVVfSU5fQUREUl9CSVRfU0laRSwKPj4gK8KgwqDCoMKg
wqDCoMKgwqAub2FzwqDCoMKgwqDCoMKgwqDCoD3CoElPTU1VX09VVF9BRERSX0JJVF9TSVpFLAo+
PiArwqDCoMKgwqDCoMKgwqDCoC5jb2hlcmVudF93YWxrwqDCoMKgwqA9wqBmYWxzZSwKPiAKPiBJ
cyB0aGF0IHJpZ2h0PyBHaXZlbiB0aGF0IHlvdSBzZWVtIHRvIHVzZSByZWd1bGFyIGtlcm5lbCBh
ZGRyZXNzZXMgZm9yIHBhZ2V0YWJsZSBwYWdlcyBhbmQgZG9uJ3QgaGF2ZSBhbnkgb2J2aW91cyBj
YWNoZSAKPiBtYWludGVuYW5jZSBhcm91bmQgUFRFIG1hbmlwdWxhdGlvbizCoEnCoHN1c3BlY3TC
oG5vdCA7KQo+ID4gSXQncyBmYWlyIGVub3VnaCBpZiB5b3VyIGltcGxlbWVudGF0aW9uIGRvZXNu
J3QgdXNlIHRoaXMgYW5kIHNpbXBseSBhc3N1bWVzIGNvaGVyZW5jeSwgYnV0IGluIHRoYXQgY2Fz
ZSBpdCB3b3VsZCBiZSBsZXNzCj4gY29uZnVzaW5nIHRvIGhhdmUgdGhlIGRyaXZlciBzZXQgaXQg
dG8gdHJ1ZSBmb3IgdGhlIHNha2Ugb2YgaG9uZXN0eSwgb3IganVzdCBsZWF2ZSBpdCBvdXQgCj4g
ZW50aXJlbHnCoC3CoGV4cGxpY2l0bHnCoHNldHRpbmfCoGZhbHNlwqBnaXZlc8KgdGhlwqBpbGx1
c2lvbsKgb2bCoGJlaW5nwqBtZWFuaW5nZnVsLgoKQU1EIElPTU1VIGNhbiBiZSBjb25maWd1cmVk
IHRvIGRpc2FibGUgc25vb3AgZm9yIHBhZ2UgdGFibGUgd2FsayBvZiBhIHBhcnRpY3VsYXIgZGV2
aWNlIChEVEVbU0RdPTEpLiBIb3dldmVyLCB0aGUgCmN1cnJlbnQgTGludXggZHJpdmVyIGRvZXMg
bm90IHNldCB0aGlzIGJpdCwgd2hpY2ggc2hvdWxkIGFzc3VtZSBjb2hlcmVuY3kuIFdlIGNhbiBq
dXN0IGxlYXZpbmcgdGhpcyBvdXQgZm9yIG5vdy4gSSBjYW4gCnJlbW92ZSB0aGlzIHdoZW4gSSBz
ZW5kIG91dCBWMiBhbG9uZyB3LyBvdGhlciBjaGFuZ2VzLgoKPiBPdGhlcndpc2UsIHRoZSBpby1w
Z3RhYmxlIHBhcnRzIGFsbCBsb29rIE9LIHRvIG1lIC0gaXQncyBuaWNlIHRvIGZpbmFsbHkgCj4g
ZnVsZmlswqB0aGXCoG9yaWdpbmFswqBpbnRlbnTCoG9mwqBub3TCoGJlaW5nwqBhbsKgQXJtLXNw
ZWNpZmljwqB0aGluZ8KgOkQKPiAKPiBSb2Jpbi4KClRoYW5rcywKU3VyYXZlZQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QK
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
