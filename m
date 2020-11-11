Return-Path: <SRS0=hwFB=ER=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B60C388F7
	for <iommu@archiver.kernel.org>; Wed, 11 Nov 2020 03:10:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C9D72168B
	for <iommu@archiver.kernel.org>; Wed, 11 Nov 2020 03:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GPToxrUT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C9D72168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2D92086204;
	Wed, 11 Nov 2020 03:10:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qZmI3R9LYoDE; Wed, 11 Nov 2020 03:10:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5AB7D85E83;
	Wed, 11 Nov 2020 03:10:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A893C088B;
	Wed, 11 Nov 2020 03:10:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE436C016F
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 03:10:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C2D69274B3
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 03:10:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gPUvPzMT4eCq for <iommu@lists.linux-foundation.org>;
 Wed, 11 Nov 2020 03:10:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by silver.osuosl.org (Postfix) with ESMTPS id ADB612740C
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 03:10:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvVfy/9f8dP5OJGj97lL3QlCFCRVMSlfB1k6PLY4wyv/vXO0YzRax8FwVfM5ZZ2OA+ILWcarbYo2YG/+raslqPFT1tzuwq7i5uuIW7n8FUxyYED6NbFHoxeeFiEoHIIjht04EEJyAgeMiYHpaWU/nHhuUZR7uB6lDoJS6B4gzl6vx+SmKQVJaxwiuSKG0nQDvCxrLWjFPdE/vjNT0AIcFZ4P8i+lBBljt88Lj9BfZcTVam1EEj57/WiEexxMnQF5x59CumxUjoY7lq0ypgPSHmH3x0oDeJAhh651pMGEb0r1jvHObOcXJjKuYHy0dskoF0VtyeawakDjjXhFY3PHxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxlcvbBI2fob+ltg5VIzuEpiHYuAt2yrbzUpR/b895o=;
 b=FqJ+sNRq4iNq8qsYJZRd2kgPtuRGO/i+L+5i2Emwahxyj3spB5LJGjPMHk/5PeelJS21KLCljNXTrVH52ZthIfDklezojIJ6zBWiYwzf2iVENuvBMdyjDgiRxe7ktDjfer61jcSe34Im53f2iMbrW2PVSvH+BXwk+Wlrzca9oycChI6Zoqq1SuJIuHIyyAB2K8Dlrax8eD5uVu54QyCbqAbO9ZMhLWZaJ8n3jP+K4FDLYM4w01RcvsFC38tSkJPvC/6D1dGwGO/AFNjIhZ6ApNOlgwWlOwTqzESA34usZ9UCLwxjOe/46QNYiNbZwjt3cy8u4WnCQP/8xLgkNUK0TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxlcvbBI2fob+ltg5VIzuEpiHYuAt2yrbzUpR/b895o=;
 b=GPToxrUTpGiQ6qxYmKTW8P6uMIntGy/33D2ff5gTBSG05MlRwwRHJ/tUXWSHQAPP0L4Psm0iquqzOX9vKjeSoIjK3eFSStFf0NiEUQZsdCu6i9L+bCgq2skVCKicZuozYF0OnJ8czxyQQ9cszwlrcpHdVbznP0LpLDLEN5FUWxM=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BY5PR12MB4163.namprd12.prod.outlook.com (2603:10b6:a03:202::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Wed, 11 Nov
 2020 03:10:17 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7%3]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 03:10:17 +0000
Subject: Re: [PATCH v3 00/14] iommu/amd: Add Generic IO Page Table Framework
 Support
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
References: <20201004014549.16065-1-suravee.suthikulpanit@amd.com>
 <f28359ed-47dc-281f-7261-6320150ef906@amd.com>
Message-ID: <eb567d23-b63b-a10a-d0b1-c03281a1f602@amd.com>
Date: Wed, 11 Nov 2020 10:10:06 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.1
In-Reply-To: <f28359ed-47dc-281f-7261-6320150ef906@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.159.242]
X-ClientProxiedBy: BM1PR01CA0091.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::31) To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Suravees-MacBook-Pro.local (165.204.159.242) by
 BM1PR01CA0091.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:1::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21 via Frontend Transport; Wed, 11 Nov 2020 03:10:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: deb88366-577e-48f3-1027-08d885ef508d
X-MS-TrafficTypeDiagnostic: BY5PR12MB4163:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4163F1EA48864EB7D6CA4F2EF3E80@BY5PR12MB4163.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eUeQPU0RuyZhiRQF/KIfcuPXaShnWkFazdC14dEYTSezbW1kmMTtxleUhxJRjLPNhNVRMuOIZkOkbFTBAnT4+OoKZhecTI4DF9PJRkm3eckQZhjM7lGIvH0xGpYeubwyQDGmH9lGDsmznPYUaFbMLbMxba06l+3u6tgsP8i4hrct+025Yroo73UA1+11eDld5Vnlpsp9n9pAPGvh9SlhRK+riBOY2ylSnyoVP5kku1n73Rq5qFjwBIhqH8O7nycyfcqNO/+JdIXzSPQnlU+DPPsW4qL6Y1Fv74lzABJdo0iR0JygfO5JmM2dcuyn7ubrySXdAnsyi8666s8m4Wk16bb5J1FyIy++qcrJuwiiCFZ6FOH3X1qW19xUt+X1y8w6MF/Xqfd1023V5I7lcMRUVD6Xk3a2gcLtxu2dndzAWcKuMmYIo1zYlPlXhvC7kLhEUfplybx7eNytRxAponCFdaM//jywGop3v4sSWL/e1xo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4597.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(53546011)(6506007)(8676002)(44832011)(52116002)(66476007)(66946007)(5660300002)(2906002)(16526019)(31686004)(8936002)(186003)(66556008)(26005)(2616005)(86362001)(83380400001)(316002)(956004)(6666004)(6486002)(36756003)(4326008)(478600001)(6512007)(31696002)(41533002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: OJlpwtqQWNA/7tgilhfb91JUm3plNJoqe8XLsbu6hqy/5lr1rSNFzm900W8cpCfFEvIo9qmIpQuXNAiMkpwzVUIcPWohqGb88BsiirfdAVbWO0OYf2FjxKBCHvi8teLE2ZDL4ww3riOTshIGVBXTUw9dBbMocVzhZt3G/owjtYk0ocTfk+vM20hz+ACicuUmo37SwjCxJMdZuqCDX/7MOeMD8BM1IWSOrf0hVSkPwBzB0HYOdAOyEtvbg2IJpKczQq6bb5RtXx0i4XVI0lN3b4f+hMTdKTbQ92QWg1ApN/zsa4sZGqbzNxBeNSPtfzb55b51GtMvsEYLSW0Ql3FTqCgyK/VNbM0MetN/G9Fb8Bj2wobfOOC++2YYFpRf2Gw/HfnDTWws2G5MC77oeFDZPbntwpVDC9Hs9S/vfNkluslafeXaFCq1XuAmjgLViJ+DrgyhWELYSKY9q5VeG33hSGSZD084qbQh7vIW/1U/ERBQ2FZ4kp2ttE4HzoXeszySnv1XaxgCHc8DhliQRKTohKq4Nes78XqHUpvieoMO5q+OSHsbOBj0x4UGkYrTKy6LJPu6o5hJl9VGmZG7Ps06/9A1gaITyLZZAMTZprvzmdLD+2ED82pDDVJBnGoPz5Ujv6nmPOgrx77k7DyetkeyaQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deb88366-577e-48f3-1027-08d885ef508d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2020 03:10:17.2162 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w1zZwsED/uMqbW8x5U1Tci3dCcRm/VFopBRYFoZ8DInAifepnSdD/+aAQKCD40lb8Zv6vZOi2u2dRlJ/pC58VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4163
Cc: robin.murphy@arm.com
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

SGkgSm9lcmcsCgpEbyB5b3UgaGF2ZSBhbnkgdXBkYXRlIG9uIHRoaXMgc2VyaWVzPwoKVGhhbmtz
LApTdXJhdmVlCgpPbiAxMS8yLzIwIDEwOjE2IEFNLCBTdXJhdmVlIFN1dGhpa3VscGFuaXQgd3Jv
dGU6Cj4gSm9lcmcsCj4gCj4gWW91IG1lbnRpb25lZCB0byByZW1pbmQgeW91IHRvIHB1bGwgdGhp
cyBpbiB0byBsaW51eC1uZXh0Lgo+IAo+IFRoYW5rcywKPiBTdXJhdmVlCj4gCj4gT24gMTAvNC8y
MCA4OjQ1IEFNLCBTdXJhdmVlIFN1dGhpa3VscGFuaXQgd3JvdGU6Cj4+IFRoZSBmcmFtZXdvcmsg
YWxsb3dzIGNhbGxhYmxlIGltcGxlbWVudGF0aW9uIG9mIElPIHBhZ2UgdGFibGUuCj4+IFRoaXMg
YWxsb3dzIEFNRCBJT01NVSBkcml2ZXIgdG8gc3dpdGNoIGJldHdlZW4gZGlmZmVyZW50IHR5cGVz
Cj4+IG9mIEFNRCBJT01NVSBwYWdlIHRhYmxlcyAoZS5nLiB2MSB2cy4gdjIpLgo+Pgo+PiBUaGlz
IHNlcmllcyByZWZhY3RvcnMgdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gb2YgQU1EIElPTU1V
IHYxIHBhZ2UgdGFibGUKPj4gdG8gYWRvcHQgdGhlIGZyYW1ld29yay4gVGhlcmUgc2hvdWxkIGJl
IG5vIGZ1bmN0aW9uYWwgY2hhbmdlLgo+PiBTdWJzZXF1ZW50IHNlcmllcyB3aWxsIGludHJvZHVj
ZSBzdXBwb3J0IGZvciB0aGUgQU1EIElPTU1VIHYyIHBhZ2UgdGFibGUuCj4+Cj4+IFRoYW5rcywK
Pj4gU3VyYXZlZQo+Pgo+PiBDaGFuZ2UgZnJvbSBWMiAoaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGttbC84MzVjMGQ0Ni1lZDk2LTlmYmUtODU2YS03NzdkY2ZmYWM5NjdAYW1kLmNvbS9ULyN0KQo+
PiDCoMKgIC0gUGF0Y2ggMi8xNDogSW50cm9kdWNlIGhlbHBlciBmdW5jdGlvbiBpb19wZ3RhYmxl
X2NmZ190b19kYXRhLgo+PiDCoMKgIC0gUGF0Y2ggMTMvMTQ6IFB1dCBiYWNrIHRoZSBzdHJ1Y3Qg
aW9tbXVfZmx1c2hfb3BzIHNpbmNlIHBhdGNoIHYyIHdvdWxkIHJ1biBpbnRvCj4+IMKgwqDCoMKg
IE5VTEwgcG9pbnRlciBidWcgd2hlbiBjYWxsaW5nIGZyZWVfaW9fcGd0YWJsZV9vcHMgaWYgbm90
IGRlZmluZWQuCj4+Cj4+IENoYW5nZSBmcm9tIFYxIChodHRwczovL2xrbWwub3JnL2xrbWwvMjAy
MC85LzIzLzI1MSkKPj4gwqDCoCAtIERvIG5vdCBzcGVjaWZ5IHN0cnVjdCBpb19wZ3RhYmxlX2Nm
Zy5jb2hlcmVudF93YWxrLCBzaW5jZSBpdCBpcwo+PiDCoMKgwqDCoCBub3QgY3VycmVudGx5IHVz
ZWQuIChwZXIgUm9iaW4pCj4+IMKgwqAgLSBSZW1vdmUgdW51c2VkIHN0cnVjdCBpb21tdV9mbHVz
aF9vcHMuwqAgKHBhdGNoIDIvMTMpCj4+IMKgwqAgLSBNb3ZlIGFtZF9pb21tdV9zZXR1cF9pb19w
Z3RhYmxlX29wcyB0byBpb21tdS5jIGluc3RlYWQgb2YgaW9fcGd0YWJsZS5jCj4+IMKgwqDCoMKg
IHBhdGNoIDEzLzEzKQo+Pgo+PiBTdXJhdmVlIFN1dGhpa3VscGFuaXQgKDE0KToKPj4gwqDCoCBp
b21tdS9hbWQ6IFJlLWRlZmluZSBhbWRfaW9tbXVfZG9tYWluX2VuY29kZV9wZ3RhYmxlIGFzIGlu
bGluZQo+PiDCoMKgIGlvbW11L2FtZDogUHJlcGFyZSBmb3IgZ2VuZXJpYyBJTyBwYWdlIHRhYmxl
IGZyYW1ld29yawo+PiDCoMKgIGlvbW11L2FtZDogTW92ZSBwdF9yb290IHRvIHRvIHN0cnVjdCBh
bWRfaW9fcGd0YWJsZQo+PiDCoMKgIGlvbW11L2FtZDogQ29udmVydCB0byB1c2luZyBhbWRfaW9f
cGd0YWJsZQo+PiDCoMKgIGlvbW11L2FtZDogRGVjbGFyZSBmdW5jdGlvbnMgYXMgZXh0ZXJuCj4+
IMKgwqAgaW9tbXUvYW1kOiBNb3ZlIElPIHBhZ2UgdGFibGUgcmVsYXRlZCBmdW5jdGlvbnMKPj4g
wqDCoCBpb21tdS9hbWQ6IFJlc3RydWN0dXJlIGNvZGUgZm9yIGZyZWVpbmcgcGFnZSB0YWJsZQo+
PiDCoMKgIGlvbW11L2FtZDogUmVtb3ZlIGFtZF9pb21tdV9kb21haW5fZ2V0X3BndGFibGUKPj4g
wqDCoCBpb21tdS9hbWQ6IFJlbmFtZSB2YXJpYWJsZXMgdG8gYmUgY29uc2lzdGVudCB3aXRoIHN0
cnVjdAo+PiDCoMKgwqDCoCBpb19wZ3RhYmxlX29wcwo+PiDCoMKgIGlvbW11L2FtZDogUmVmYWN0
b3IgZmV0Y2hfcHRlIHRvIHVzZSBzdHJ1Y3QgYW1kX2lvX3BndGFibGUKPj4gwqDCoCBpb21tdS9h
bWQ6IEludHJvZHVjZSBpb21tdV92MV9pb3ZhX3RvX3BoeXMKPj4gwqDCoCBpb21tdS9hbWQ6IElu
dHJvZHVjZSBpb21tdV92MV9tYXBfcGFnZSBhbmQgaW9tbXVfdjFfdW5tYXBfcGFnZQo+PiDCoMKg
IGlvbW11L2FtZDogSW50cm9kdWNlIElPTU1VIGZsdXNoIGNhbGxiYWNrcwo+PiDCoMKgIGlvbW11
L2FtZDogQWRvcHQgSU8gcGFnZSB0YWJsZSBmcmFtZXdvcmsKPj4KPj4gwqAgZHJpdmVycy9pb21t
dS9hbWQvS2NvbmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEgKwo+PiDCoCBkcml2ZXJz
L2lvbW11L2FtZC9NYWtlZmlsZcKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAyICstCj4+IMKgIGRy
aXZlcnMvaW9tbXUvYW1kL2FtZF9pb21tdS5owqDCoMKgwqDCoMKgIHzCoCAyMiArCj4+IMKgIGRy
aXZlcnMvaW9tbXUvYW1kL2FtZF9pb21tdV90eXBlcy5oIHzCoCA0MyArLQo+PiDCoCBkcml2ZXJz
L2lvbW11L2FtZC9pb19wZ3RhYmxlLmPCoMKgwqDCoMKgIHwgNTY0ICsrKysrKysrKysrKysrKysr
KysrKysrKwo+PiDCoCBkcml2ZXJzL2lvbW11L2FtZC9pb21tdS5jwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfCA2NDYgKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+PiDCoCBkcml2ZXJzL2lvbW11
L2lvLXBndGFibGUuY8KgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAzICsKPj4gwqAgaW5jbHVkZS9s
aW51eC9pby1wZ3RhYmxlLmjCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMiArCj4+IMKgIDggZmls
ZXMgY2hhbmdlZCwgNjkxIGluc2VydGlvbnMoKyksIDU5MiBkZWxldGlvbnMoLSkKPj4gwqAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvaW9tbXUvYW1kL2lvX3BndGFibGUuYwo+PgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxp
c3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
