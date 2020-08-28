Return-Path: <SRS0=8RI2=CG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36144C433E2
	for <iommu@archiver.kernel.org>; Fri, 28 Aug 2020 13:55:09 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E178920776
	for <iommu@archiver.kernel.org>; Fri, 28 Aug 2020 13:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pNzrLO6H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E178920776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 98E4F203DD;
	Fri, 28 Aug 2020 13:55:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v2Y8wdgDA4rr; Fri, 28 Aug 2020 13:55:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id EC9C12038B;
	Fri, 28 Aug 2020 13:55:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D06BEC016F;
	Fri, 28 Aug 2020 13:55:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33F4BC0051
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 13:55:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1BD8787F00
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 13:55:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h8vzEQWFhtt8 for <iommu@lists.linux-foundation.org>;
 Fri, 28 Aug 2020 13:55:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750047.outbound.protection.outlook.com [40.107.75.47])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2E61B87EEC
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 13:55:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJDYwCzQsbBRDBhPoxV9wAGsP2FwrN884/Wwhk2YsbKR6Q4zfl/2EpA6+4oxGBIhqtVEhDqhnP1ifP6ow9dqIY/YPzI4uiIsGf7LEKsBKQs83kD484yE+JwVt7klU2fX2NyqWZm/9c9cgdRO3+L/TxqyL/By3I86t+mzD8fT8J6MNum2PuDVqeWBzdy0eoTXBxoQXyVp6KRqige0S49BuE7mL+VxOChGslnIYrREFKrxcQBIe4ejli6UXonazUT4fhW/eHUivbVqMFJM72H3UDtEHPg0wR6yp+OSc6PsFxftDDR/5cu5/WI9iCSsY988MZfVcfU6KFQ2M4TN8IY3Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVETvbDFxpyJpuX0ZFtDqkCPWbmnH/kf6w9EDg9Q9Hc=;
 b=g9leZqfXXZxhbVnEkVe1Px8qNJUrUR3OtIR7D7z1nSo3kW9okjHAOxYlSl2RflVDorRIt0t4M9gxs6H++XT3iHkhcZA+MB0Mtk57NKajFw3qTxbL3yHICdA+qp7qMZK/+5cb6wh1h1Ff5MMR39hFm5YfWboALiveEraMez1o2hJCuyIdobUo9EJdVqAJJgJQ5nRchJvsGPNu9LMvMpRvcO9oRo7IZg/I2gtrTqdPr9J3VLWvw9r2LDANyiqOpWCHAdoIfQhv95xTy6OT+jH5yh6wwjyvYW/IGj7IqWhd3l/VYr7ldLmGpA+QIYaPi1O7nlHNNa5Gx1bRXGiY8dvltg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVETvbDFxpyJpuX0ZFtDqkCPWbmnH/kf6w9EDg9Q9Hc=;
 b=pNzrLO6H8tEvzxgr7B9gVgMMR14th+qscJJIJorJ4Y6geTdBmcZ1dNIRFGMYpUE+6Kt4kAafQACi1RUhq/dg700gvwUyuVtxMpJri7WK5ZgIAatcPKZ72uOEkI8ODuH9q17cHr0v1C5VZrA3LP0hrZWmp4mh8WblxptkUIn1GKQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Fri, 28 Aug
 2020 13:55:01 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9%7]) with mapi id 15.20.3305.032; Fri, 28 Aug 2020
 13:55:01 +0000
Subject: Re: [PATCH 0/2] iommu/amd: Fix IOMMUv2 devices when SME is active
To: "jroedel@suse.de" <jroedel@suse.de>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20200824105415.21000-1-joro@8bytes.org>
 <MN2PR12MB4488D6B7BBF98845DF796E0BF7540@MN2PR12MB4488.namprd12.prod.outlook.com>
 <34db343f-cd23-09af-3bc5-29b9d385f85d@amd.com>
 <MN2PR12MB4488BF7DDE700378F7B2776CF7540@MN2PR12MB4488.namprd12.prod.outlook.com>
 <20200828134639.GW3354@suse.de>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <60067932-dbf4-d67b-cf11-4dd2b016ed63@amd.com>
Date: Fri, 28 Aug 2020 09:54:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200828134639.GW3354@suse.de>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0027.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::40)
 To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YT1PR01CA0027.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Fri, 28 Aug 2020 13:55:00 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8add559c-0cf7-498b-ff2a-08d84b59f526
X-MS-TrafficTypeDiagnostic: SA0PR12MB4349:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB43495555B40062481AECA00592520@SA0PR12MB4349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mpFO6IxtGk9Io6fS5/mLSptj9A/sEWnj71rmPWmdiuIE6xhVtesSydAtp8ev4uz1aEHBaPCX+BZw0WVNw9ch092i29hJgcuaPfu168V1a1TX+E4HG7sqxBEj8irXW92aePSUrDdieWMoBRnFKdK/ZHqSX3H5dLim2OeX08Um96NSZABv2IE4TXlOAwYfbtsOQ+QPyIpk27DzVCEE+Xf1W+DGBkCKmD5K0fG39z43tH65rQkvbTL8r4J0MFYuHs4sCLhWke/xhhWelQ7ET0VXPVfNRtF4f/00LyqeyPQKdWlcV+FsneQH4hdApWm0K+5N1sWxivACtn5ApZRwKg0jgT9Xj1ndeCf2niJZWiOUbU6284KtSzOVX9LKRr7WmLR5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(5660300002)(2616005)(956004)(36756003)(31686004)(6636002)(66476007)(478600001)(186003)(66556008)(66946007)(44832011)(316002)(110136005)(52116002)(8936002)(8676002)(31696002)(6486002)(4326008)(2906002)(26005)(86362001)(16576012)(54906003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: yLI+/64fGgD829zrblcmFs2vKMVYgCR11wnRgxECSHLp7+xruWYUdQSRFsKKHspGu4LArjo9aWbIHcS4uzwmiBVk2CERAejX9glUMtOhObhRiA7BClgCirC9n3KVXlwxqFNKi/a9+8SaEqCTI6yLK/NZfAEqQzx6MRIdsJvajLa4d7XPYlezShV8EK9VctYcpYGyCMb1o42nfRLXkblPd9pwVrzxjSIijJohAVg6dNynPUazAzU4Sf0Elr0pp+sAKad/bf7jAO3pXIO80sTYP3/4r7VLW6RrKGS2Rl6AYHiw95aypzmrM2018iDHxBCyFY2Y+q7OcILCv1y/EI6J/0ACcsCIS3/j/2enpE8o0Gf/Khz/I9BIJFXqMI6Ui2eKQtTUNyUnxC55njJx7d0SfGYRx4nloh/toiKSwkVLrj7ubQRpzGfxd53hDEfY8SP2ItY38U4hJyNrg5UoIEReDHzqwxgM4ZE8cNx6XAPIzBf8LhP42mZhZMigJs4ddSFViPYVKy3qkyEBhYT3a4vUfX+Bkdna3g7R+Aru39KMYJln5R+Ry+7laI1OQKviz63QVrrQ0ejh+sdYcEQSRh2uJlNoF1dHtSZuc34hFqnI5/dkxsTYLDTTfhICgFDqOlTxAAmcg20wGVXHGuMey6UdAQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8add559c-0cf7-498b-ff2a-08d84b59f526
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 13:55:01.3139 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HAutWahBAUUNCQRiCxN99qjb5ErYahnEQBEyjkOK7Bs09GVHvZJzZhIN78UyoYmQnvvCoJYwl3t9460Zyf49Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4349
Cc: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Huang,
 Ray" <Ray.Huang@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

QW0gMjAyMC0wOC0yOCB1bSA5OjQ2IGEubS4gc2NocmllYiBqcm9lZGVsQHN1c2UuZGU6Cj4gT24g
V2VkLCBBdWcgMjYsIDIwMjAgYXQgMDM6MjU6NThQTSArMDAwMCwgRGV1Y2hlciwgQWxleGFuZGVy
IHdyb3RlOgo+Pj4gQWxleCwgZG8geW91IGtub3cgaWYgYW55b25lIGhhcyB0ZXN0ZWQgYW1kZ3B1
IG9uIGFuIEFQVSB3aXRoIFNNRQo+Pj4gZW5hYmxlZD8gSXMgdGhpcyBjb25zaWRlcmVkIHNvbWV0
aGluZyB3ZSBzdXBwb3J0Pwo+PiBJdCdzIG5vdCBzb21ldGhpbmcgd2UndmUgdGVzdGVkLiAgSSdt
IG5vdCBldmVuIHN1cmUgdGhlIEdQVSBwb3J0aW9uIG9mCj4+IEFQVXMgd2lsbCB3b3JrIHByb3Bl
cmx5IHdpdGhvdXQgYW4gaWRlbnRpdHkgbWFwcGluZy4gIFNNRSBzaG91bGQgd29yawo+PiBwcm9w
ZXJseSB3aXRoIGRHUFVzIGhvd2V2ZXIsIHNvIHRoaXMgaXMgYSBwcm9wZXIgZml4IGZvciB0aGVt
LiAgV2UKPj4gZG9uJ3QgdXNlIHRoZSBJT01NVXYyIHBhdGggb24gZEdQVXMgYXQgYWxsLgo+IElz
IGl0IHBvc3NpYmxlIHRvIG1ha2UgdGhlIElPTU1VdjIgcGF0aHMgb3B0aW9uYWwgb24gaUdQVXMg
YXMgd2VsbCB3aGVuCj4gU01FIGlzIGFjdGl2ZSAob3IgYmV0dGVyLCB3aGVuIHRoZSBHUFUgaXMg
bm90IGlkZW50aXR5IG1hcHBlZCk/CgpZZXMsIHdlJ3JlIHdvcmtpbmcgb24gdGhpcy4gSU9NTVV2
MiBpcyBvbmx5IG5lZWRlZCBmb3IgS0ZELiBJdCdzIG5vdApuZWVkZWQgZm9yIGdyYXBoaWNzLiBB
bmQgd2UncmUgbWFraW5nIGl0IG9wdGlvbmFsIGZvciBLRkQgYXMgd2VsbC4KClRoZSBxdWVzdGlv
biBBbGV4IGFuZCBJIHJhaXNlZCBoZXJlIGlzIG1vcmUgZ2VuZXJhbC4gV2UgbWF5IGhhdmUgc29t
ZQphc3N1bXB0aW9ucyBpbiB0aGUgYW1kZ3B1IGRyaXZlciB0aGF0IGFyZSBicm9rZW4gd2hlbiB0
aGUgZnJhbWVidWZmZXIgaXMKbm90IGlkZW50aXR5IG1hcHBlZC4gVGhpcyB3b3VsZCBicmVhayB0
aGUgaUdQVSBpbiBhIG1vcmUgZ2VuZXJhbCBzZW5zZSwKcmVnYXJkbGVzcyBvZiBLRkQgYW5kIElP
TU1VdjIuIEluIHRoYXQgY2FzZSwgd2UgZG9uJ3QgcmVhbGx5IG5lZWQgdG8Kd29ycnkgYWJvdXQg
YnJlYWtpbmcgS0ZEIGJlY2F1c2Ugd2UgaGF2ZSBhIG11Y2ggYmlnZ2VyIHByb2JsZW0uCgpSZWdh
cmRzLArCoCBGZWxpeAoKCj4KPiBSZWdhcmRzLAo+Cj4gCUpvZXJnCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
