Return-Path: <SRS0=jcR/=E5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239F1C2D0E4
	for <iommu@archiver.kernel.org>; Mon, 23 Nov 2020 23:06:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BAE9206D8
	for <iommu@archiver.kernel.org>; Mon, 23 Nov 2020 23:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TeYWzVWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BAE9206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A06A68605E;
	Mon, 23 Nov 2020 23:06:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SVP_3FQU3XpG; Mon, 23 Nov 2020 23:06:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BF04685F45;
	Mon, 23 Nov 2020 23:06:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B01D3C163C;
	Mon, 23 Nov 2020 23:06:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33A5BC0052
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 23:06:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id DE93920555
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 23:06:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KOqifoQNK2cd for <iommu@lists.linux-foundation.org>;
 Mon, 23 Nov 2020 23:06:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by silver.osuosl.org (Postfix) with ESMTPS id 900E320553
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 23:06:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fslUJj10EcnEqJJmk9cuqZbVdvaakovN2GoH+qTaOfWa0U6GQ+PyRw+GCVZf28vgIzVZTgWdkVOzPr370fOLjU4FyG4WC+3BviSDsDYOiy7LpoERGHCAhzOAMpMMjdWWuCuODjbXcYmB4Il4EW+TqZRpSFr9RH7pe1zh2E3dG1B2m8Cg0cbb6kSXBSpeSAqMjCCwx4dixg5K//kcRNx4EWFSpU3sf31E83pM5kkL4Droo01s+t9JwL49Hj3zevW5OEgu0mXdheAErxCmIl3VbUVnONUvzmmouwp/EB9vIb7jOIlP4cdtstIO0EGuiYgJEBuZv/xSj+YHap8hWy1hIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJ5oX/gM57euXN94QblKpTjwqNAfLreegM7OqiUpZpo=;
 b=WdcepFp9ovvf4+N90xe5s2sbsTp142SOQy7+f7/cO6KtmGS00J7eYPSOwq6AgsucQvwKPSJZom3+LQxZFYlamcHbHF48lZXMorY+DGgOs+jBA3lgIlKIdklc9IynfMOHIRDQy401qa5nKa2DTwlo1BZ14RtVa+X4JWgbJmLpnZBy5DIkxsx7HyvEiM5feeFz/Kc9/y7zOFJvtoqls2Q5/jbbMP12Nzfb6dcEoIFBg4GY+80kZLOOTm7agbXr59mnyFwq4om0aQBXIfkeAfvnGvjYTO+5azrdGY9NN8jcZRdt01lspHPVvZKT0eIsuK82vzlrr16PiJL555vKVzH7Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJ5oX/gM57euXN94QblKpTjwqNAfLreegM7OqiUpZpo=;
 b=TeYWzVWPAegEVVvcc49PhKKvFFBGqxwjbJMCH47yHwZoKUKnl32wlLdFl3w0ZQOTthAgt3iKCXm8Gca8hJmhL3trbKb0gHTdo6fSOEy9wmDQ+sR0reJrS7bw+1ucCN3R+Ml25HO3tJQdclJrqqLiEe3bAb3tkJR/Au6SXiO0rmk=
Authentication-Results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4111.namprd12.prod.outlook.com (2603:10b6:208:1de::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Mon, 23 Nov
 2020 22:51:13 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8%8]) with mapi id 15.20.3589.030; Mon, 23 Nov 2020
 22:51:13 +0000
Subject: Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as broken
To: Will Deacon <will@kernel.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Huang, Ray" <Ray.Huang@amd.com>
References: <20201123134410.10648-1-will@kernel.org>
 <MN2PR12MB4488308D26DB50C18EA3BE0FF7FC0@MN2PR12MB4488.namprd12.prod.outlook.com>
 <20201123223356.GC12069@willie-the-truck>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <218017ab-defd-c77d-9055-286bf49bee86@amd.com>
Date: Mon, 23 Nov 2020 17:51:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201123223356.GC12069@willie-the-truck>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: CH2PR15CA0015.namprd15.prod.outlook.com
 (2603:10b6:610:51::25) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.80] (165.204.55.251) by
 CH2PR15CA0015.namprd15.prod.outlook.com (2603:10b6:610:51::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20 via Frontend Transport; Mon, 23 Nov 2020 22:51:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 18853704-df28-4727-678f-08d890024743
X-MS-TrafficTypeDiagnostic: MN2PR12MB4111:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4111DED35B8A9959913C4B9F92FC0@MN2PR12MB4111.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 011lQo37cTgq4n+fptQGhB4QroJLQXSTXLGED55hSnjm0PyqvgwTyhIAHeTIzSGyuo/Wv6ee4wcMDrK1RHkdH8V+twx7bL2rXZTbXlDNK8tggFyjbJS2l4agJ5HAZcZ3OFFqkwMlzaHIh+BIvPc30Y0MELyqJd6yN7yv88rULxofhG0p8XhB5VasgvVivhbD2BVh5RFtd72I/odNJJZZ0Yt11rENc7f3RJ2Tcg2ijyQGFMDorQkXH106Es5RtArJzc7ZeN5w3fFsokuiRxylH+lWQ16u/kKND6hiiizIhjCt0RO0vnmp+mT9XPEcES/T4NXnXRf0jCHgU/NbmSaDHmpODTNXd7YJSO7TFhrvGPpnD28G+syziYO9mA5H4HhQgsiHo7+wsNgEWtxWDQrVyczWc7NQ+bw+fBuiq57OVA3atmsLZoi15dbcxl+NyONXJchbmpxkLev51drjaCd8AA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(2906002)(86362001)(6636002)(66476007)(4001150100001)(316002)(66556008)(54906003)(44832011)(110136005)(83380400001)(45080400002)(5660300002)(53546011)(16576012)(16526019)(52116002)(36916002)(8676002)(186003)(4326008)(6486002)(36756003)(966005)(8936002)(31696002)(31686004)(2616005)(26005)(66946007)(956004)(478600001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 4CAaQY+B8HWYs9FCPsm9JmoSzsimFE/oPC7/xC52NBwTxTE5OqX4iTpIB2hA63ZXn0zMrd4+qv2UtVa10venzr2DtFXChsdI4CK+AkWe+5fFVhRc86VgXGwkZOWLQea1rC9TQaYUfMHTj/iGrAudX29uzBrRtv22zeegBMw5QACxh73EVYZeEImx/3fawSjoxSVWb8CHiE4vfxHXeRDE4Vp5O1Rhp5QNS+X+bDD8uzEm2lrTpe93fg7Gu6jIN1ekgcMbVh42KGUaHy9qf3SVqpg1yXEWk9MJctrAOCwJJONpF9WSd3FHhDuSR/rHGoStCkjtraB/7PVGVU1eFgUGc2BUMCexHSqJLuSTK63l1zXx3HpCsAKwjI3nwgBUa8h2AE/uYiPmpO4+azlJ1tvw5mBvauACyecRx/cxKF0OrGDgyJuDTub8qG3mvIWnabponGK4dxGnG85rwQQTRYzK2iliFuM+BO5D7dVEBDZ6lE/zjwLai/Chjx+C7gPweKXTtOdAC89NgH8P1Fr/P9UcaFp0QjHhh/qAEO4RsCdXCjynu7Q5g71Zm0viCgZR6YG9kk6OnPqlZcMzWqNZC1+OTorqWW1sAsliWiW2sHAqDiIW7snxECJlq/TuVLirA0oaxoy75QYwMZk/z8NgcYB2s0VFbGPabDO4gSy25eor2dmbv7hCAd+1w/oSmy2DNiO13g/EB+Z87SCXGt55OTu7SJfW2wqhwF+jW54aUW3pU+Awz4Gul9C9m9BASznsB6k/Ig6chzaXMC0mb8GxVJfRytM05fiteCZx9z5CgFqBhnZz2mknzA+v45ygSkljSIiIOOvKFxVPFKrdXPuIEo4SB/mCGxiV0wX9gfImj/E4cjk2owRcQz60knkkyUWPQmd03uJpQCzvHOylHIX/Uz7ENQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18853704-df28-4727-678f-08d890024743
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2020 22:51:13.4621 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7yFvMrrF5PN9Oa3HxhpUHuhomZf15d1JF/8dvN63Q+WNAsjflvn+E1kpGBiOQXReSkUhF3AkVGrG8K9ZO8rwtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4111
Cc: Edgar Merger <Edgar.Merger@emerson.com>, Joerg Roedel <jroedel@suse.de>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>
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

T24gMjAyMC0xMS0yMyA1OjMzIHAubS4sIFdpbGwgRGVhY29uIHdyb3RlOgo+IE9uIE1vbiwgTm92
IDIzLCAyMDIwIGF0IDA5OjA0OjE0UE0gKzAwMDAsIERldWNoZXIsIEFsZXhhbmRlciB3cm90ZToK
Pj4gW0FNRCBQdWJsaWMgVXNlXQo+Pgo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPj4+
IEZyb206IFdpbGwgRGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+Cj4+PiBTZW50OiBNb25kYXksIE5v
dmVtYmVyIDIzLCAyMDIwIDg6NDQgQU0KPj4+IFRvOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnCj4+PiBDYzogbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgaW9tbXVAbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmc7IFdpbGwKPj4+IERlYWNvbiA8d2lsbEBrZXJuZWwub3JnPjsgQmpvcm4g
SGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT47Cj4+PiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFs
ZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBFZGdhciBNZXJnZXIKPj4+IDxFZGdhci5NZXJnZXJA
ZW1lcnNvbi5jb20+OyBKb2VyZyBSb2VkZWwgPGpyb2VkZWxAc3VzZS5kZT4KPj4+IFN1YmplY3Q6
IFtQQVRDSF0gUENJOiBNYXJrIEFNRCBSYXZlbiBpR1BVIEFUUyBhcyBicm9rZW4KPj4+Cj4+PiBF
ZGdhciBNZXJnZXIgcmVwb3J0cyB0aGF0IHRoZSBBTUQgUmF2ZW4gR1BVIGRvZXMgbm90IHdvcmsg
cmVsaWFibHkgb24gaGlzCj4+PiBzeXN0ZW0gd2hlbiB0aGUgSU9NTVUgaXMgZW5hYmxlZDoKPj4+
Cj4+PiAgICB8IFtkcm06YW1kZ3B1X2pvYl90aW1lZG91dCBbYW1kZ3B1XV0gKkVSUk9SKiByaW5n
IGdmeCB0aW1lb3V0LAo+Pj4gc2lnbmFsZWQgc2VxPTEsIGVtaXR0ZWQgc2VxPTMKPj4+ICAgIHwg
Wy4uLl0KPj4+ICAgIHwgYW1kZ3B1IDAwMDA6MGI6MDAuMDogR1BVIHJlc2V0IGJlZ2luIQo+Pj4g
ICAgfCBBTUQtVmk6IENvbXBsZXRpb24tV2FpdCBsb29wIHRpbWVkIG91dAo+Pj4gICAgfCBpb21t
dSBpdmhkMDogQU1ELVZpOiBFdmVudCBsb2dnZWQgW0lPVExCX0lOVl9USU1FT1VUCj4+PiBkZXZp
Y2U9MGI6MDAuMCBhZGRyZXNzPTB4MzhlZGMwOTcwXQo+Pj4KPj4+IFRoaXMgaXMgaW5kaWNhdGl2
ZSBvZiBhIGhhcmR3YXJlL3BsYXRmb3JtIGNvbmZpZ3VyYXRpb24gaXNzdWUgc28sIHNpbmNlCj4+
PiBkaXNhYmxpbmcgQVRTIGhhcyBiZWVuIHNob3duIHRvIHJlc29sdmUgdGhlIHByb2JsZW0sIGFk
ZCBhIHF1aXJrIHRvIG1hdGNoCj4+PiB0aGlzIHBhcnRpY3VsYXIgZGV2aWNlIHdoaWxlIEVkZ2Fy
IGZvbGxvd3MtdXAgd2l0aCBBTUQgZm9yIG1vcmUgaW5mb3JtYXRpb24uCj4+Pgo+Pj4gQ2M6IEJq
b3JuIEhlbGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+Cj4+PiBDYzogQWxleCBEZXVjaGVyIDxh
bGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+Pj4gUmVwb3J0ZWQtYnk6IEVkZ2FyIE1lcmdlciA8
RWRnYXIuTWVyZ2VyQGVtZXJzb24uY29tPgo+Pj4gU3VnZ2VzdGVkLWJ5OiBKb2VyZyBSb2VkZWwg
PGpyb2VkZWxAc3VzZS5kZT4KPj4+IExpbms6Cj4+PiBodHRwczovL2xvcmUuCj4+PiBrZXJuZWwu
b3JnL2xpbnV4LQo+Pj4gaW9tbXUvTVdIUFIxME1CMTMxMEYwNDJBMzA2NjFENDE1ODUyMEI1ODlG
QzBATVdIUFIxME0KPj4+IEIxMzEwLm5hbXByZDEwLnByb2Qub3V0bG9vay5jb20KPj4+IGhlciU0
MGFtZC5jb20lN0MxYTg4M2ZlMTRkMGM0MDhlN2Q5NTA4ZDg4ZmI1ZGY0ZSU3QzNkZDg5NjFmZTQ4
OAo+Pj4gNGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzQxNzM1ODU5MzYyOTY5OSU3
Q1Vua25vd24lNwo+Pj4gQ1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lW
Mmx1TXpJaUxDSkJUaUk2SWsxaGFXd2kKPj4+IExDSlhWQ0k2TW4wJTNEJTdDMTAwMCZhbXA7c2Rh
dGE9VE1nS2xkV3pzWDhYWjBsN3EzJTJCc3pEV1hRSkoKPj4+IExPVWZYNW9HYW9MTjhuJTJCOCUz
RCZhbXA7cmVzZXJ2ZWQ9MAo+Pj4gU2lnbmVkLW9mZi1ieTogV2lsbCBEZWFjb24gPHdpbGxAa2Vy
bmVsLm9yZz4KPj4+IC0tLQo+Pj4KPj4+IEhpIGFsbCwKPj4+Cj4+PiBTaW5jZSBKb2VyZyBpcyBh
d2F5IGF0IHRoZSBtb21lbnQsIEknbSBwb3N0aW5nIHRoaXMgdG8gdHJ5IHRvIG1ha2Ugc29tZQo+
Pj4gcHJvZ3Jlc3Mgd2l0aCB0aGUgdGhyZWFkIGluIHRoZSBMaW5rOiB0YWcuCj4+ICsgRmVsaXgK
Pj4KPj4gV2hhdCBzeXN0ZW0gaXMgdGhpcz8gIENhbiB5b3UgcHJvdmlkZSBtb3JlIGRldGFpbHM/
ICBEb2VzIGEgc2Jpb3MgdXBkYXRlCj4+IGZpeCB0aGlzPyAgRGlzYWJsaW5nIEFUUyBmb3IgYWxs
IFJhdmVucyB3aWxsIGJyZWFrIEdQVSBjb21wdXRlIGZvciBhIGxvdAo+PiBvZiBwZW9wbGUuICBJ
J2QgcHJlZmVyIHRvIGp1c3QgYmxhY2sgbGlzdCB0aGlzIHBhcnRpY3VsYXIgc3lzdGVtIChlLmcu
LAo+PiBqdXN0IFNTSURzIG9yIHJldmlzaW9uKSBpZiBwb3NzaWJsZS4KCitSYXkKClRoZXJlIGFy
ZSBhbHJlYWR5IG1hbnkgc3lzdGVtcyB3aGVyZSB0aGUgSU9NTVUgaXMgZGlzYWJsZWQgaW4gdGhl
IEJJT1MsIApvciB0aGUgQ1JBVCB0YWJsZSByZXBvcnRpbmcgdGhlIEFQVSBjb21wdXRlIGNhcGFi
aWxpdGllcyBpcyBicm9rZW4uIFJheSAKaGFzIGJlZW4gd29ya2luZyBvbiBhIGZhbGxiYWNrIHRv
IG1ha2UgQVBVcyBiZWhhdmUgbGlrZSBkR1BVcyBvbiBzdWNoIApzeXN0ZW1zLiBUaGF0IHNob3Vs
ZCBhbHNvIGNvdmVyIHRoaXMgY2FzZSB3aGVyZSBBVFMgaXMgYmxhY2tsaXN0ZWQuIFRoYXQgCnNh
aWQsIGl0IGFmZmVjdHMgdGhlIHByb2dyYW1taW5nIG1vZGVsLCBiZWNhdXNlIHdlIGRvbid0IHN1
cHBvcnQgdGhlIAp1bmlmaWVkIGFuZCBjb2hlcmVudCBtZW1vcnkgbW9kZWwgb24gZEdQVXMgbGlr
ZSB3ZSBkbyBvbiBBUFVzIHdpdGggCklPTU1VdjIuIFNvIGl0IHdvdWxkIGJlIGdvb2QgdG8gbWFr
ZSB0aGUgY29uZGl0aW9ucyBmb3IgdGhpcyB3b3JrYXJvdW5kIAphcyBuYXJyb3cgYXMgcG9zc2li
bGUuCgpUaGVzZSBhcmUgdGhlIHJlbGV2YW50IGNoYW5nZXMgaW4gS0ZEIGFuZCBUaHVuayBmb3Ig
cmVmZXJlbmNlOgoKIyMjIEtGRCAjIyMKCmNvbW1pdCA5MTQ5MTNhYjA0ZGZiY2QwMjI2ZWNiNmJj
OTlkMjc2ODMyZWEyOTA4CkF1dGhvcjogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KRGF0
ZTrCoMKgIFR1ZSBBdWcgMTggMTQ6NTQ6MjMgMjAyMCArMDgwMAoKIMKgwqDCoCBkcm0vYW1ka2Zk
OiBpbXBsZW1lbnQgdGhlIGRHUFUgZmFsbGJhY2sgcGF0aCBmb3IgYXB1ICh2NikKCiDCoMKgwqAg
V2Ugc3RpbGwgaGF2ZSBhIGZldyBpb21tdSBpc3N1ZXMgd2hpY2ggbmVlZCB0byBhZGRyZXNzLCBz
byBmb3JjZSByYXZlbgogwqDCoMKgIGFzICJkZ3B1IiBwYXRoIGZvciB0aGUgbW9tZW50LgoKIMKg
wqDCoCBUaGlzIGlzIHRvIGFkZCB0aGUgZmFsbGJhY2sgcGF0aCB0byBieXBhc3MgSU9NTVUgaWYg
SU9NTVUgdjIgaXMgCmRpc2FibGVkCiDCoMKgwqAgb3IgQUNQSSBDUkFUIHRhYmxlIG5vdCBjb3Jy
ZWN0LgoKIMKgwqDCoCB2MjogVXNlIGlnbm9yZV9jcmF0IHBhcmFtZXRlciB0byBkZWNpZGUgd2hl
dGhlciBpdCB3aWxsIGdvIHdpdGggCklPTU1VdjIuCiDCoMKgwqAgdjM6IEFsaWduIHdpdGggZXhp
c3RlZCB0aHVuaywgZG9uJ3QgY2hhbmdlIHRoZSB3YXkgb2YgcmF2ZW4sIG9ubHkgCnJlbm9pcgog
wqDCoMKgwqDCoMKgwqAgd2lsbCB1c2UgImRncHUiIHBhdGggYnkgZGVmYXVsdC4KIMKgwqDCoCB2
NDogZG9uJ3QgdXBkYXRlIGdsb2JhbCBpZ25vcmVfY3JhdCBpbiB0aGUgZHJpdmVyLCBhbmQgcmV2
aXNlIGZhbGxiYWNrCiDCoMKgwqDCoMKgwqDCoCBmdW5jdGlvbiBpZiBDUkFUIGlzIGJyb2tlbi4K
IMKgwqDCoCB2NTogcmVmaW5lIGFjcGkgY3JhdCBnb29kIGJ1dCBubyBpb21tdSBzdXBwb3J0IGNh
c2UsIGFuZCByZW5hbWUgdGhlCiDCoMKgwqDCoMKgwqDCoCB0aXRsZS4KIMKgwqDCoCB2NjogZml4
IHRoZSBpc3N1ZSBvZiBkR1BVIGluaXRpYWxpemVkIGZpcnN0bHksIGp1c3QgbW9kaWZ5IHRoZSBy
ZXBvcnQKIMKgwqDCoMKgwqDCoMKgIHZhbHVlIGluIHRoZSBub2RlX3Nob3coKS4KCiDCoMKgwqAg
U2lnbmVkLW9mZi1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KIMKgwqDCoCBSZXZp
ZXdlZC1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+CiDCoMKgwqAg
U2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgoK
IyMjIFRodW5rICMjIwoKY29tbWl0IGUzMjQ4MmZhNGI5Y2EzOThjOGJkYzMwMzkyMGFiZmQ2NzI1
OTI3NjQKQXV0aG9yOiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPgpEYXRlOsKgwqAgVHVl
IEF1ZyAxOCAxODo1NDowNSAyMDIwICswODAwCgogwqDCoMKgIGxpYmhzYWttdDogcmVtb3ZlIGlz
X2RncHUgZmxhZyBpbiB0aGUgaHNhX2dmeGlwX3RhYmxlCgogwqDCoMKgIFdoZXRoZXIgdXNlIGRn
cHUgcGF0aCB3aWxsIGNoZWNrIHRoZSBwcm9wcyB3aGljaCBleHBvc2VkIGZyb20ga2VybmVsLgog
wqDCoMKgIFdlIHdvbid0IG5lZWQgaGFyZCBjb2RlIGluIHRoZSBBU0lDIHRhYmxlLgoKIMKgwqDC
oCBTaWduZWQtb2ZmLWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPgogwqDCoMKgIENo
YW5nZS1JZDogSTBjMDE4YTI2YjIxOTkxNGE0MTE5N2ZmMzZkYmVjN2E3NTk0NWQ0NTIKCmNvbW1p
dCA3YzYwZjZkOTEyMDM0YWE2N2VkMjdiNDdhMjkyMjE0MjI0MjNmNWNjCkF1dGhvcjogSHVhbmcg
UnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KRGF0ZTrCoMKgIFRodSBKdWwgMzAgMTA6MjI6MjMgMjAy
MCArMDgwMAoKIMKgwqDCoCBsaWJoc2FrbXQ6IGltcGxlbWVudCB0aGUgbWV0aG9kIHRoYXQgdXNp
bmcgZmxhZyB3aGljaCBleHBvc2VkIGJ5IAprZmQgdG8gY29uZmlndXJlIGlzX2RncHUKCiDCoMKg
wqAgS0ZEIGFscmVhZHkgaW1wbGVtZW50ZWQgdGhlIGZhbGxiYWNrIHBhdGggZm9yIEFQVS4gVGh1
bmsgd2lsbCB1c2UgZmxhZwogwqDCoMKgIHdoaWNoIGV4cG9zZWQgYnkga2ZkIHRvIGNvbmZpZ3Vy
ZSBpc19kZ3B1IGluc3RlYWQgb2YgaGFyZGNvZGUgYmVmb3JlLgoKIMKgwqDCoCBTaWduZWQtb2Zm
LWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPgogwqDCoMKgIENoYW5nZS1JZDogSTQ0
NWY2Y2Y2NjhmOTQ4NGRkMDZjZDlhZTFiYjNjZmU3NDI4ZWM3ZWIKClJlZ2FyZHMsCiDCoCBGZWxp
eAoKCj4gQ2hlZXJzLCBBbGV4LiBJJ2xsIGhhdmUgdG8gZGVmZXIgdG8gRWRnYXIgZm9yIHRoZSBk
ZXRhaWxzLCBhcyBteQo+IHVuZGVyc3RhbmRpbmcgZnJvbSB0aGUgb3JpZ2luYWwgdGhyZWFkIG92
ZXIgYXQ6Cj4KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1pb21tdS9NV0hQUjEwTUIx
MzEwQ0RCNjgyOUREQ0Y1RUE4NEExNDY4OTE1MEBNV0hQUjEwTUIxMzEwLm5hbXByZDEwLnByb2Qu
b3V0bG9vay5jb20vCj4KPiBpcyB0aGF0IHRoaXMgaXMgYSBib2FyZCBkZXZlbG9wZWQgYnkgaGlz
IGNvbXBhbnkuCj4KPiBFZGdhciAtLSBwbGVhc2UgY2FuIHlvdSBhbnN3ZXIgQWxleCdzIHF1ZXN0
aW9ucz8KPgo+IFdpbGwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
