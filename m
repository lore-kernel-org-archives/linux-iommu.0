Return-Path: <SRS0=vtxH=ET=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66534C388F9
	for <iommu@archiver.kernel.org>; Fri, 13 Nov 2020 06:12:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A595B2085B
	for <iommu@archiver.kernel.org>; Fri, 13 Nov 2020 06:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="T3oqWwxo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A595B2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 261B5877A6;
	Fri, 13 Nov 2020 06:12:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hCzxCvPo+rba; Fri, 13 Nov 2020 06:12:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2D9648769E;
	Fri, 13 Nov 2020 06:12:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 112E9C1833;
	Fri, 13 Nov 2020 06:12:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69CFFC0FAA
 for <iommu@lists.linux-foundation.org>; Fri, 13 Nov 2020 06:12:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4B1072033E
 for <iommu@lists.linux-foundation.org>; Fri, 13 Nov 2020 06:12:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7ktbNaw75YbA for <iommu@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 06:12:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by silver.osuosl.org (Postfix) with ESMTPS id E4DAB2012D
 for <iommu@lists.linux-foundation.org>; Fri, 13 Nov 2020 06:12:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjtsk7lebcUzVDB9WwAGZnPMpm/jfuKoflcXNDwgBty4fWNGTTLGIjvIFEReiYhT+WKxNSnZmOqyExwSpSYmlQ1OfqcRqj/eMHQBcXSOaEf+jOKU36YecB7Dp624uWP3MQmGtV1etYkrUwRo/jgEvFRMpCczwijM+0/ShQfbuaZBzIWVbfmAG6/zt0h1BkJJ1pDeoqNZkxs1GuGCaYHIv3W2RcNcQx+ifj62n6HEKDHJMQS90LOsUT+9tSUNOB98VLlu1LHtmuSGGdqdvywI7l+Yh7l0xe87LD9siAKwhT3llUFKZAMxla9QnBffE4tpnoCR2zuaOYrY/POQntfCnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xwf7sPOuSMEIO4yUZCKr3VKhR8AXaKIKUEr/RMAzAY=;
 b=ljv3aVJVxHGQYE//8gte8CbcP71sFqpB4Z8zVdrHy8oJmyiaEp1U1yz93leAGpK+A/z60y41QFadFl5VShLbYDAhbX/i9cMraFGJwoQoBHTp8ZYt1v1oDZnmb36bRwv1rBTcRQRs3RmzzEpudg+rJaHqezwAJ38cKWraNOb8jsF1zAguuJjxUY2e7bOxDmmB4lkPbbu9QLuewDkWry9SYNK0zCHVoNKdjchD60Ijej0SfWpeWoVi/pRIwZTStdVY+zuDZq1BsoFQly/tTNOY9XPs5wgLAeq8wJIJHJJyPgbxtTlDwQiGd1C0U6tOyYUlM16Gnk9Ie21DjD9DYqxdLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xwf7sPOuSMEIO4yUZCKr3VKhR8AXaKIKUEr/RMAzAY=;
 b=T3oqWwxonB6adzW+86co+0JWRDP+//iHXnm36/rZr4LDyb9X9kqGA3YotPwDUUjUCcpBxzWJU2rV3ZSg5FqMAKpytBLAAlOeKhGWvqXhI7tRPzM1MPjX+EOAWrbHLe2jwiycw41ZvhibIYw2QKXa04QmcgdmM/Z5To1R5LGdD9c=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BY5PR12MB4818.namprd12.prod.outlook.com (2603:10b6:a03:1b4::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.24; Fri, 13 Nov
 2020 05:57:30 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7%3]) with mapi id 15.20.3541.025; Fri, 13 Nov 2020
 05:57:30 +0000
Subject: Re: [PATCH v3 00/14] iommu/amd: Add Generic IO Page Table Framework
 Support
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
References: <20201004014549.16065-1-suravee.suthikulpanit@amd.com>
 <f28359ed-47dc-281f-7261-6320150ef906@amd.com>
 <eb567d23-b63b-a10a-d0b1-c03281a1f602@amd.com>
Message-ID: <4dce5bdb-1a08-75ad-fd41-a1686521fef1@amd.com>
Date: Fri, 13 Nov 2020 12:57:18 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.1
In-Reply-To: <eb567d23-b63b-a10a-d0b1-c03281a1f602@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.80.7]
X-ClientProxiedBy: KL1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:820:d::14) To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Suravees-MacBook-Pro.local (165.204.80.7) by
 KL1PR02CA0027.apcprd02.prod.outlook.com (2603:1096:820:d::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.25 via Frontend Transport; Fri, 13 Nov 2020 05:57:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e863f8dc-c632-44a2-b620-08d88799010b
X-MS-TrafficTypeDiagnostic: BY5PR12MB4818:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4818A9B206F0C392F71E142CF3E60@BY5PR12MB4818.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oKyAwohJolNPLAaqeXlEsDBKxFkR4E58EKmUs7OwUwVioXwOTxih5ctV0lfBpVZzpLbq5mMeNOCgJSj7me8XU9TonOHwC35kYepKcvlfu/J+rA3Ky4K0sPkQxeV0MwYcsnX+MFviZ+/RMHU0Wa29SZJgvL1FCFYClSolChEXvB+BPdehiDACKp81INaee0vFezXmpizSa0AieSvyokYmXzb7Ei66UcQWviMufHolAtlGZkI1kAoYlhXiOLoSGqWRSQkiqaco1fJw4DrQCN0ygSUT8CIsJxS20DiSA7YKI+8J7aA14+VChB5FrCYgy0PxZjXC2vyWNQTdSz83zrgBnKYldy6qRgsKY2+IXCar/z2KtsAf5RG8giG9BSWcnrbrA6ZOl82/d/rYY8oVeoHQPJzT0EnQfRZrpkPg52nd9GtukRMJAC6utQsHOt187N+j8fgZx+RyhSNCqL3K3SYDT9xuS4Kq9aQPxxfzWpAcX3Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4597.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(956004)(2616005)(478600001)(8676002)(6666004)(6506007)(26005)(53546011)(186003)(83380400001)(52116002)(2906002)(66556008)(6486002)(8936002)(66476007)(16526019)(36756003)(6512007)(86362001)(66946007)(5660300002)(44832011)(31696002)(31686004)(4326008)(316002)(41533002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: elFTTc67wxV3/bRkZWkyXj2JmqXcrAnx7Ix2Nr9XNewALXxh+pLiYt2Wy1UrJDRjiSp2ewZvKNAG5UGFDKG6abmfEmzePuxWaq+0BpKPirxoBVjwIbhicHQPdA5D1q7KrXNkI3T21vCDHydEd2spMVH4zQlInUaad5jKZOvrJxCkIgf48wewlhrzp4Bu2Bw6mRzHLDxQuQDvAlHH9dzQpfowg15HrUHMyYlI2gxW1ql3watnImoAVJfNf5tACX7kERP7fh9olX0mp9e+4fcDPGMKw1ErWQShppiIFrgbRwJQZGaqrRzSqAe2ZeMEpuGjx+BgGVuKh7R+jfha6BPVa0xQqv2ymFdu4X0KsVthyoOEls8jKK+cBvCPno4UNGn7r1OaTLrMUEQjpYi2hmnuQyBVYT1hvUp3h58NCqId04f1DvF1rhbsv0cWNfkxKTPeMXgtrferdgBoR55Z1pUJEQmK1uJimhMq1Usjdw/dRQvAVZekrgQxhqQriMLoMkv+ulbKl+2vaBbGtAv4oW1pq9eghMYnyL0DSFEFIa1wTWeBX60VL8CaiKJTe7Ny9vdf31wceb8yaGX0IR/MtLH3RGzHVzU9YfVGNde/wiqPOoADnNJsOypthrUpo+9MUtyeBEIkJ6S5hZYv5TFxJVOgfw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e863f8dc-c632-44a2-b620-08d88799010b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 05:57:29.9520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3mIxihMj0bsTt4FNhZaX7KqsmS+TXg9dNL0GP0YmiqPXhT9D0DWWdOVxV8cw0+5Bf+ZQjAHETeTQHJ3rxkCq4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4818
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

Sm9lcmcsCgpQbGVhc2UgaWdub3JlIHRvIGluY2x1ZGUgdGhlIFYzLiBJIGFtIHdvcmtpbmcgb24g
VjQgdG8gcmVzdWJtaXQuCgpUaGFuayB5b3UsClN1cmF2ZWUKCk9uIDExLzExLzIwIDEwOjEwIEFN
LCBTdXJhdmVlIFN1dGhpa3VscGFuaXQgd3JvdGU6Cj4gSGkgSm9lcmcsCj4gCj4gRG8geW91IGhh
dmUgYW55IHVwZGF0ZSBvbiB0aGlzIHNlcmllcz8KPiAKPiBUaGFua3MsCj4gU3VyYXZlZQo+IAo+
IE9uIDExLzIvMjAgMTA6MTYgQU0sIFN1cmF2ZWUgU3V0aGlrdWxwYW5pdCB3cm90ZToKPj4gSm9l
cmcsCj4+Cj4+IFlvdSBtZW50aW9uZWQgdG8gcmVtaW5kIHlvdSB0byBwdWxsIHRoaXMgaW4gdG8g
bGludXgtbmV4dC4KPj4KPj4gVGhhbmtzLAo+PiBTdXJhdmVlCj4+Cj4+IE9uIDEwLzQvMjAgODo0
NSBBTSwgU3VyYXZlZSBTdXRoaWt1bHBhbml0IHdyb3RlOgo+Pj4gVGhlIGZyYW1ld29yayBhbGxv
d3MgY2FsbGFibGUgaW1wbGVtZW50YXRpb24gb2YgSU8gcGFnZSB0YWJsZS4KPj4+IFRoaXMgYWxs
b3dzIEFNRCBJT01NVSBkcml2ZXIgdG8gc3dpdGNoIGJldHdlZW4gZGlmZmVyZW50IHR5cGVzCj4+
PiBvZiBBTUQgSU9NTVUgcGFnZSB0YWJsZXMgKGUuZy4gdjEgdnMuIHYyKS4KPj4+Cj4+PiBUaGlz
IHNlcmllcyByZWZhY3RvcnMgdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gb2YgQU1EIElPTU1V
IHYxIHBhZ2UgdGFibGUKPj4+IHRvIGFkb3B0IHRoZSBmcmFtZXdvcmsuIFRoZXJlIHNob3VsZCBi
ZSBubyBmdW5jdGlvbmFsIGNoYW5nZS4KPj4+IFN1YnNlcXVlbnQgc2VyaWVzIHdpbGwgaW50cm9k
dWNlIHN1cHBvcnQgZm9yIHRoZSBBTUQgSU9NTVUgdjIgcGFnZSB0YWJsZS4KPj4+Cj4+PiBUaGFu
a3MsCj4+PiBTdXJhdmVlCj4+Pgo+Pj4gQ2hhbmdlIGZyb20gVjIgKGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xrbWwvODM1YzBkNDYtZWQ5Ni05ZmJlLTg1NmEtNzc3ZGNmZmFjOTY3QGFtZC5jb20v
VC8jdCkKPj4+IMKgwqAgLSBQYXRjaCAyLzE0OiBJbnRyb2R1Y2UgaGVscGVyIGZ1bmN0aW9uIGlv
X3BndGFibGVfY2ZnX3RvX2RhdGEuCj4+PiDCoMKgIC0gUGF0Y2ggMTMvMTQ6IFB1dCBiYWNrIHRo
ZSBzdHJ1Y3QgaW9tbXVfZmx1c2hfb3BzIHNpbmNlIHBhdGNoIHYyIHdvdWxkIHJ1biBpbnRvCj4+
PiDCoMKgwqDCoCBOVUxMIHBvaW50ZXIgYnVnIHdoZW4gY2FsbGluZyBmcmVlX2lvX3BndGFibGVf
b3BzIGlmIG5vdCBkZWZpbmVkLgo+Pj4KPj4+IENoYW5nZSBmcm9tIFYxIChodHRwczovL2xrbWwu
b3JnL2xrbWwvMjAyMC85LzIzLzI1MSkKPj4+IMKgwqAgLSBEbyBub3Qgc3BlY2lmeSBzdHJ1Y3Qg
aW9fcGd0YWJsZV9jZmcuY29oZXJlbnRfd2Fsaywgc2luY2UgaXQgaXMKPj4+IMKgwqDCoMKgIG5v
dCBjdXJyZW50bHkgdXNlZC4gKHBlciBSb2JpbikKPj4+IMKgwqAgLSBSZW1vdmUgdW51c2VkIHN0
cnVjdCBpb21tdV9mbHVzaF9vcHMuwqAgKHBhdGNoIDIvMTMpCj4+PiDCoMKgIC0gTW92ZSBhbWRf
aW9tbXVfc2V0dXBfaW9fcGd0YWJsZV9vcHMgdG8gaW9tbXUuYyBpbnN0ZWFkIG9mIGlvX3BndGFi
bGUuYwo+Pj4gwqDCoMKgwqAgcGF0Y2ggMTMvMTMpCj4+Pgo+Pj4gU3VyYXZlZSBTdXRoaWt1bHBh
bml0ICgxNCk6Cj4+PiDCoMKgIGlvbW11L2FtZDogUmUtZGVmaW5lIGFtZF9pb21tdV9kb21haW5f
ZW5jb2RlX3BndGFibGUgYXMgaW5saW5lCj4+PiDCoMKgIGlvbW11L2FtZDogUHJlcGFyZSBmb3Ig
Z2VuZXJpYyBJTyBwYWdlIHRhYmxlIGZyYW1ld29yawo+Pj4gwqDCoCBpb21tdS9hbWQ6IE1vdmUg
cHRfcm9vdCB0byB0byBzdHJ1Y3QgYW1kX2lvX3BndGFibGUKPj4+IMKgwqAgaW9tbXUvYW1kOiBD
b252ZXJ0IHRvIHVzaW5nIGFtZF9pb19wZ3RhYmxlCj4+PiDCoMKgIGlvbW11L2FtZDogRGVjbGFy
ZSBmdW5jdGlvbnMgYXMgZXh0ZXJuCj4+PiDCoMKgIGlvbW11L2FtZDogTW92ZSBJTyBwYWdlIHRh
YmxlIHJlbGF0ZWQgZnVuY3Rpb25zCj4+PiDCoMKgIGlvbW11L2FtZDogUmVzdHJ1Y3R1cmUgY29k
ZSBmb3IgZnJlZWluZyBwYWdlIHRhYmxlCj4+PiDCoMKgIGlvbW11L2FtZDogUmVtb3ZlIGFtZF9p
b21tdV9kb21haW5fZ2V0X3BndGFibGUKPj4+IMKgwqAgaW9tbXUvYW1kOiBSZW5hbWUgdmFyaWFi
bGVzIHRvIGJlIGNvbnNpc3RlbnQgd2l0aCBzdHJ1Y3QKPj4+IMKgwqDCoMKgIGlvX3BndGFibGVf
b3BzCj4+PiDCoMKgIGlvbW11L2FtZDogUmVmYWN0b3IgZmV0Y2hfcHRlIHRvIHVzZSBzdHJ1Y3Qg
YW1kX2lvX3BndGFibGUKPj4+IMKgwqAgaW9tbXUvYW1kOiBJbnRyb2R1Y2UgaW9tbXVfdjFfaW92
YV90b19waHlzCj4+PiDCoMKgIGlvbW11L2FtZDogSW50cm9kdWNlIGlvbW11X3YxX21hcF9wYWdl
IGFuZCBpb21tdV92MV91bm1hcF9wYWdlCj4+PiDCoMKgIGlvbW11L2FtZDogSW50cm9kdWNlIElP
TU1VIGZsdXNoIGNhbGxiYWNrcwo+Pj4gwqDCoCBpb21tdS9hbWQ6IEFkb3B0IElPIHBhZ2UgdGFi
bGUgZnJhbWV3b3JrCj4+Pgo+Pj4gwqAgZHJpdmVycy9pb21tdS9hbWQvS2NvbmZpZ8KgwqDCoMKg
wqDCoMKgwqDCoMKgIHzCoMKgIDEgKwo+Pj4gwqAgZHJpdmVycy9pb21tdS9hbWQvTWFrZWZpbGXC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMiArLQo+Pj4gwqAgZHJpdmVycy9pb21tdS9hbWQvYW1k
X2lvbW11LmjCoMKgwqDCoMKgwqAgfMKgIDIyICsKPj4+IMKgIGRyaXZlcnMvaW9tbXUvYW1kL2Ft
ZF9pb21tdV90eXBlcy5oIHzCoCA0MyArLQo+Pj4gwqAgZHJpdmVycy9pb21tdS9hbWQvaW9fcGd0
YWJsZS5jwqDCoMKgwqDCoCB8IDU2NCArKysrKysrKysrKysrKysrKysrKysrKysKPj4+IMKgIGRy
aXZlcnMvaW9tbXUvYW1kL2lvbW11LmPCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDY0NiArKystLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4+PiDCoCBkcml2ZXJzL2lvbW11L2lvLXBndGFibGUuY8Kg
wqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAzICsKPj4+IMKgIGluY2x1ZGUvbGludXgvaW8tcGd0YWJs
ZS5owqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDIgKwo+Pj4gwqAgOCBmaWxlcyBjaGFuZ2VkLCA2
OTEgaW5zZXJ0aW9ucygrKSwgNTkyIGRlbGV0aW9ucygtKQo+Pj4gwqAgY3JlYXRlIG1vZGUgMTAw
NjQ0IGRyaXZlcnMvaW9tbXUvYW1kL2lvX3BndGFibGUuYwo+Pj4KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
