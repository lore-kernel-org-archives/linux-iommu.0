Return-Path: <SRS0=fY2N=J5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22D2C433B4
	for <iommu@archiver.kernel.org>; Sun,  2 May 2021 22:34:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F8DB61245
	for <iommu@archiver.kernel.org>; Sun,  2 May 2021 22:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F8DB61245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 002ED8444E;
	Sun,  2 May 2021 22:34:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vEHEHT78O3cy; Sun,  2 May 2021 22:34:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E9028444B;
	Sun,  2 May 2021 22:34:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79B86C000E;
	Sun,  2 May 2021 22:34:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E187C0001
 for <iommu@lists.linux-foundation.org>; Sun,  2 May 2021 22:34:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 624C040265
 for <iommu@lists.linux-foundation.org>; Sun,  2 May 2021 22:34:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WaMFx_AYJieJ for <iommu@lists.linux-foundation.org>;
 Sun,  2 May 2021 22:34:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DA87F400A6
 for <iommu@lists.linux-foundation.org>; Sun,  2 May 2021 22:34:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bwx2JECd34Rm6FLQEtzbggXzH78hUgyrEwarbqt4287MUNbpeO34n0U8dJtqiveZA7dD7qGxfHBQ+iPvqv99SRy90ftWHM2850eoOXnQs3tWx7/ic6pYkiuvx37Khvkj1xM4X/JR82wSYbjWN+w7RPfQ34/CwcXlZ0yUgRw+fXgE66tWcTqFz0/J7Z8tvGzOH5Li5FQhcVBLjjhQLbG3X0Gb23OtBRO78Vl0+Kqowd6t5eQpJMok/Mqtu4LeT6+Wt4y4QiySWNSZNk/YondZL4KKxkZqcxpPliK++8fiFGn9iXjvK1dZE6BQQEcnHct5ui7ujy7fG1puem1rct90hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUS8/hzdI2bLakxsX4eraydP/gCVYGt1jijU0nshQWk=;
 b=C9acdelkoWWzqI+HA8BoVsoWUb1lPTW97G6WReZp/zXkw69Sffre4eBbgOUDaxn8orh6glFc03TFXdSHDYf30ikz5iIDhxuFTlPBLS/6zF1qv8PpNOdZrj5qAl/Ke6LY9AmDSPPq3PxV2lNOSwFmywMC6WurBAf276pd22x2Yz5VRAxXzXCpFqfbrT1cuW+kOTYLRv3pR6Sv1wuQ/nvH0Y7/M2t2NCGKt77vLDm6wrAbfCvyzrEtArUY/XJxsx6Jaz2KbHy/UWUHxdt64Rk8CgcSxC1ywdsS2OzR+1u7PsSNWY6Y+NBOSN3w+DV8aEJ25c9RsiGXYWtPA+GQYGzT9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=raithlin.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUS8/hzdI2bLakxsX4eraydP/gCVYGt1jijU0nshQWk=;
 b=Vfe31iAYGh3R5qzX3EJs3Es0yGgin/zujM97KIyfIG4lUpSzRtIT3Rn3MIyOvBZrc2AYw+L1RilPYVrUJhPLuiy01v9oKGFQKdrhWL5CFu30oXFiGK9tV2QvmkGPN8RfPO4f+d4VaDhwDvSmBcyGdd92qghLIkOCrzJkOVQObLlviz1KEodGVPGTMNnT2U7SWGRxxUNamdjF1t4iaJ6RHHMnmLotUXP5ITsi0acARifuyWCMn/zzzhRH3Tk2+niZG9QrCIhLvTApHXxB49HaM4SuoitS/2STdf0maT4FJvU1PceMLPIfOpVyW+saMU+Erwy3/FxwS1fteMofxV3EQw==
Received: from BN8PR04CA0025.namprd04.prod.outlook.com (2603:10b6:408:70::38)
 by CY4PR12MB1750.namprd12.prod.outlook.com (2603:10b6:903:11c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26; Sun, 2 May
 2021 22:34:19 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::c1) by BN8PR04CA0025.outlook.office365.com
 (2603:10b6:408:70::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend
 Transport; Sun, 2 May 2021 22:34:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; raithlin.com; dkim=none (message not signed)
 header.d=none;raithlin.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4087.27 via Frontend Transport; Sun, 2 May 2021 22:34:18 +0000
Received: from [10.2.50.162] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 2 May
 2021 22:34:18 +0000
Subject: Re: [PATCH 06/16] lib/scatterlist: Add flag for indicating P2PDMA
 segments in an SGL
To: Logan Gunthorpe <logang@deltatee.com>, <linux-kernel@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-mm@kvack.org>,
 <iommu@lists.linux-foundation.org>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-7-logang@deltatee.com>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <4a1f06c2-a120-56f5-37a7-e4625a5f275c@nvidia.com>
Date: Sun, 2 May 2021 15:34:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210408170123.8788-7-logang@deltatee.com>
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7eee2504-ae3b-44d4-3dc8-08d90dba6cce
X-MS-TrafficTypeDiagnostic: CY4PR12MB1750:
X-Microsoft-Antispam-PRVS: <CY4PR12MB17505301FADB6367B8B6F6F4A85C9@CY4PR12MB1750.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dE4ZRi7+LyKRpCJxgyNwRThjOb79h03jQuxx/SBux5QEa3QdE8X6JsMJeE5GED/svyNNKvSssukE6HibHTxAngZh/jO0K9MmPLyIjMqYpGcG9cWAMuwg/UDUKrIypeIDCzyAY/JfKbRYdvdvFCwzkX5Mmujgc1e4Y5/1Zx3hiph1qCSXRnfeoneWOAkRQRZP+l6X4i56cZqI2KkclBGybOafPGhZri0YeIfFYAgKXfco2O6WmktW2VDCV2nCMbjAL9zKuiFNY52NUBgKJCBcYj7xm9gShNpdk+3i5WU7uHEF4OFoGFlYSFx1BDwlz6rEX2nQECHy/CMxdJDmlz2/mqiAwp+14D3dSb4mMFNksgKB8oxer21ZthGM1iOS9DiDvqm2268PTfi88t2lk43JWj7aLss5ndzMd0pP566FJ+A76voYkFrhspE8tIgt419jdFiqtxO5j4rnMn8/FpfuR9JIdOqNiphyCwAO35wtcZiF9kk5kh3Sk6BTYOAxuYsXw6F3eYkS+FmA+cV2GKO6fjB+avU+KkcmZH3tuPl34QXGjEhwzcVklMZeD84pWY1Gof3mgC1szIa7UNAYCfF506EskXeXUDISIkL+KwYLt/Sk36+oV98xa1WpA15sLx4aGVchZt8WlCAf3no0OpGJ4yZSWfnFrpFkN+bQkiEppxwUquGsOjY67NOcQ6ZylymLEAYCSEwFsoengXDXH+bU1g==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(36840700001)(46966006)(4326008)(31686004)(8676002)(16576012)(5660300002)(110136005)(86362001)(83380400001)(26005)(36906005)(316002)(16526019)(47076005)(8936002)(7636003)(82740400003)(2906002)(36756003)(54906003)(70586007)(53546011)(70206006)(2616005)(356005)(336012)(82310400003)(7416002)(478600001)(31696002)(36860700001)(186003)(426003)(43740500002)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2021 22:34:18.8330 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eee2504-ae3b-44d4-3dc8-08d90dba6cce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1750
Cc: Minturn Dave B <dave.b.minturn@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dave Hansen <dave.hansen@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jason Ekstrand <jason@jlekstrand.net>,
 Bjorn Helgaas <helgaas@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Stephen Bates <sbates@raithlin.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>, Christoph Hellwig <hch@lst.de>,
 Xiong Jianxin <jianxin.xiong@intel.com>
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

T24gNC84LzIxIDEwOjAxIEFNLCBMb2dhbiBHdW50aG9ycGUgd3JvdGU6Cj4gTWFrZSB1c2Ugb2Yg
dGhlIHRoaXJkIGZyZWUgTFNCIGluIHNjYXR0ZXJsaXN0J3MgcGFnZV9saW5rIG9uIDY0Yml0IHN5
c3RlbXMuCj4gCj4gVGhlIGV4dHJhIGJpdCB3aWxsIGJlIHVzZWQgYnkgZG1hX1t1bl1tYXBfc2df
cDJwZG1hKCkgdG8gZGV0ZXJtaW5lIHdoZW4gYQo+IGdpdmVuIFNHTCBzZWdtZW50cyBkbWFfYWRk
cmVzcyBwb2ludHMgdG8gYSBQQ0kgYnVzIGFkZHJlc3MuCj4gZG1hX3VubWFwX3NnX3AycGRtYSgp
IHdpbGwgbmVlZCB0byBwZXJmb3JtIGRpZmZlcmVudCBjbGVhbnVwIHdoZW4gYQo+IHNlZ21lbnQg
aXMgbWFya2VkIGFzIFAyUERNQS4KPiAKPiBVc2luZyB0aGlzIGJpdCByZXF1aXJlcyBhZGRpbmcg
YW4gYWRkaXRpb25hbCBkZXBlbmRlbmN5IG9uIENPTkZJR182NEJJVCB0bwo+IENPTkZJR19QQ0lf
UDJQRE1BLiBUaGlzIHNob3VsZCBiZSBhY2NlcHRhYmxlIGFzIHRoZSBtYWpvcml0eSBvZiBQMlBE
TUEKPiB1c2UgY2FzZXMgYXJlIHJlc3RyaWN0ZWQgdG8gbmV3ZXIgcm9vdCBjb21wbGV4ZXMgYW5k
IHJvdWdobHkgcmVxdWlyZSB0aGUKPiBleHRyYSBhZGRyZXNzIHNwYWNlIGZvciBtZW1vcnkgQkFS
cyB1c2VkIGluIHRoZSB0cmFuc2FjdGlvbnMuCgpUb3RhbGx5IGFncmVlIHdpdGggdGhlIENPTkZJ
R182NEJJVCBjYWxsLgoKQWxzbywgSSBoYXZlIGZhaWxlZCB0byBmaW5kIGFueXRoaW5nIHdyb25n
IHdpdGggdGhpcyBwYXRjaC4gOikKClJldmlld2VkLWJ5OiBKb2huIEh1YmJhcmQgPGpodWJiYXJk
QG52aWRpYS5jb20+Cgp0aGFua3MsCi0tIApKb2huIEh1YmJhcmQKTlZJRElBCgo+IAo+IFNpZ25l
ZC1vZmYtYnk6IExvZ2FuIEd1bnRob3JwZSA8bG9nYW5nQGRlbHRhdGVlLmNvbT4KPiAtLS0KPiAg
IGRyaXZlcnMvcGNpL0tjb25maWcgICAgICAgICB8ICAyICstCj4gICBpbmNsdWRlL2xpbnV4L3Nj
YXR0ZXJsaXN0LmggfCA0OSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tCj4g
ICAyIGZpbGVzIGNoYW5nZWQsIDQ2IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4gCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL0tjb25maWcgYi9kcml2ZXJzL3BjaS9LY29uZmlnCj4g
aW5kZXggMGM0NzNkNzVlNjI1Li45MGI0YmRkYjMzMDAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9w
Y2kvS2NvbmZpZwo+ICsrKyBiL2RyaXZlcnMvcGNpL0tjb25maWcKPiBAQCAtMTYzLDcgKzE2Myw3
IEBAIGNvbmZpZyBQQ0lfUEFTSUQKPiAgIAo+ICAgY29uZmlnIFBDSV9QMlBETUEKPiAgIAlib29s
ICJQQ0kgcGVlci10by1wZWVyIHRyYW5zZmVyIHN1cHBvcnQiCj4gLQlkZXBlbmRzIG9uIFpPTkVf
REVWSUNFCj4gKwlkZXBlbmRzIG9uIFpPTkVfREVWSUNFICYmIDY0QklUCj4gICAJc2VsZWN0IEdF
TkVSSUNfQUxMT0NBVE9SCj4gICAJaGVscAo+ICAgCSAgRW5hYmxl0ZUgZHJpdmVycyB0byBkbyBQ
Q0kgcGVlci10by1wZWVyIHRyYW5zYWN0aW9ucyB0byBhbmQgZnJvbQo+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL2xpbnV4L3NjYXR0ZXJsaXN0LmggYi9pbmNsdWRlL2xpbnV4L3NjYXR0ZXJsaXN0LmgK
PiBpbmRleCA2ZjcwNTcyYjI5MzguLjU1MjVkM2ViZjM2ZiAxMDA2NDQKPiAtLS0gYS9pbmNsdWRl
L2xpbnV4L3NjYXR0ZXJsaXN0LmgKPiArKysgYi9pbmNsdWRlL2xpbnV4L3NjYXR0ZXJsaXN0LmgK
PiBAQCAtNTgsNiArNTgsMjEgQEAgc3RydWN0IHNnX3RhYmxlIHsKPiAgICNkZWZpbmUgU0dfQ0hB
SU4JMHgwMVVMCj4gICAjZGVmaW5lIFNHX0VORAkJMHgwMlVMCj4gICAKPiArLyoKPiArICogYml0
IDIgaXMgdGhlIHRoaXJkIGZyZWUgYml0IGluIHRoZSBwYWdlX2xpbmsgb24gNjRiaXQgc3lzdGVt
cyB3aGljaAo+ICsgKiBpcyB1c2VkIGJ5IGRtYV91bm1hcF9zZygpIHRvIGRldGVybWluZSBpZiB0
aGUgZG1hX2FkZHJlc3MgaXMgYSBQQ0kKPiArICogYnVzIGFkZHJlc3Mgd2hlbiBkb2luZyBQMlBE
TUEuCj4gKyAqIE5vdGU6IENPTkZJR19QQ0lfUDJQRE1BIGRlcGVuZHMgb24gQ09ORklHXzY0QklU
IGJlY2F1c2Ugb2YgdGhpcy4KPiArICovCj4gKwo+ICsjaWZkZWYgQ09ORklHX1BDSV9QMlBETUEK
PiArI2RlZmluZSBTR19QQ0lfUDJQRE1BCTB4MDRVTAo+ICsjZWxzZQo+ICsjZGVmaW5lIFNHX1BD
SV9QMlBETUEJMHgwMFVMCj4gKyNlbmRpZgo+ICsKPiArI2RlZmluZSBTR19QQUdFX0xJTktfTUFT
SyAoU0dfQ0hBSU4gfCBTR19FTkQgfCBTR19QQ0lfUDJQRE1BKQo+ICsKPiAgIC8qCj4gICAgKiBX
ZSBvdmVybG9hZCB0aGUgTFNCIG9mIHRoZSBwYWdlIHBvaW50ZXIgdG8gaW5kaWNhdGUgd2hldGhl
ciBpdCdzCj4gICAgKiBhIHZhbGlkIHNnIGVudHJ5LCBvciB3aGV0aGVyIGl0IHBvaW50cyB0byB0
aGUgc3RhcnQgb2YgYSBuZXcgc2NhdHRlcmxpc3QuCj4gQEAgLTY1LDggKzgwLDkgQEAgc3RydWN0
IHNnX3RhYmxlIHsKPiAgICAqLwo+ICAgI2RlZmluZSBzZ19pc19jaGFpbihzZykJCSgoc2cpLT5w
YWdlX2xpbmsgJiBTR19DSEFJTikKPiAgICNkZWZpbmUgc2dfaXNfbGFzdChzZykJCSgoc2cpLT5w
YWdlX2xpbmsgJiBTR19FTkQpCj4gKyNkZWZpbmUgc2dfaXNfcGNpX3AycGRtYShzZykJKChzZykt
PnBhZ2VfbGluayAmIFNHX1BDSV9QMlBETUEpCj4gICAjZGVmaW5lIHNnX2NoYWluX3B0cihzZykJ
XAo+IC0JKChzdHJ1Y3Qgc2NhdHRlcmxpc3QgKikgKChzZyktPnBhZ2VfbGluayAmIH4oU0dfQ0hB
SU4gfCBTR19FTkQpKSkKPiArCSgoc3RydWN0IHNjYXR0ZXJsaXN0ICopICgoc2cpLT5wYWdlX2xp
bmsgJiB+U0dfUEFHRV9MSU5LX01BU0spKQo+ICAgCj4gICAvKioKPiAgICAqIHNnX2Fzc2lnbl9w
YWdlIC0gQXNzaWduIGEgZ2l2ZW4gcGFnZSB0byBhbiBTRyBlbnRyeQo+IEBAIC04MCwxMyArOTYs
MTMgQEAgc3RydWN0IHNnX3RhYmxlIHsKPiAgICAqKi8KPiAgIHN0YXRpYyBpbmxpbmUgdm9pZCBz
Z19hc3NpZ25fcGFnZShzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnLCBzdHJ1Y3QgcGFnZSAqcGFnZSkK
PiAgIHsKPiAtCXVuc2lnbmVkIGxvbmcgcGFnZV9saW5rID0gc2ctPnBhZ2VfbGluayAmIChTR19D
SEFJTiB8IFNHX0VORCk7Cj4gKwl1bnNpZ25lZCBsb25nIHBhZ2VfbGluayA9IHNnLT5wYWdlX2xp
bmsgJiBTR19QQUdFX0xJTktfTUFTSzsKPiAgIAo+ICAgCS8qCj4gICAJICogSW4gb3JkZXIgZm9y
IHRoZSBsb3cgYml0IHN0ZWFsaW5nIGFwcHJvYWNoIHRvIHdvcmssIHBhZ2VzCj4gICAJICogbXVz
dCBiZSBhbGlnbmVkIGF0IGEgMzItYml0IGJvdW5kYXJ5IGFzIGEgbWluaW11bS4KPiAgIAkgKi8K
PiAtCUJVR19PTigodW5zaWduZWQgbG9uZykgcGFnZSAmIChTR19DSEFJTiB8IFNHX0VORCkpOwo+
ICsJQlVHX09OKCh1bnNpZ25lZCBsb25nKSBwYWdlICYgU0dfUEFHRV9MSU5LX01BU0spOwo+ICAg
I2lmZGVmIENPTkZJR19ERUJVR19TRwo+ICAgCUJVR19PTihzZ19pc19jaGFpbihzZykpOwo+ICAg
I2VuZGlmCj4gQEAgLTEyMCw3ICsxMzYsNyBAQCBzdGF0aWMgaW5saW5lIHN0cnVjdCBwYWdlICpz
Z19wYWdlKHN0cnVjdCBzY2F0dGVybGlzdCAqc2cpCj4gICAjaWZkZWYgQ09ORklHX0RFQlVHX1NH
Cj4gICAJQlVHX09OKHNnX2lzX2NoYWluKHNnKSk7Cj4gICAjZW5kaWYKPiAtCXJldHVybiAoc3Ry
dWN0IHBhZ2UgKikoKHNnKS0+cGFnZV9saW5rICYgfihTR19DSEFJTiB8IFNHX0VORCkpOwo+ICsJ
cmV0dXJuIChzdHJ1Y3QgcGFnZSAqKSgoc2cpLT5wYWdlX2xpbmsgJiB+U0dfUEFHRV9MSU5LX01B
U0spOwo+ICAgfQo+ICAgCj4gICAvKioKPiBAQCAtMjIyLDYgKzIzOCwzMSBAQCBzdGF0aWMgaW5s
aW5lIHZvaWQgc2dfdW5tYXJrX2VuZChzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnKQo+ICAgCXNnLT5w
YWdlX2xpbmsgJj0gflNHX0VORDsKPiAgIH0KPiAgIAo+ICsvKioKPiArICogc2dfbWFya19wY2lf
cDJwZG1hIC0gTWFyayB0aGUgc2NhdHRlcmxpc3QgZW50cnkgZm9yIFBDSSBwMnBkbWEKPiArICog
QHNnOgkJIFNHIGVudHJ5U2NhdHRlcmxpc3QKPiArICoKPiArICogRGVzY3JpcHRpb246Cj4gKyAq
ICAgTWFya3MgdGhlIHBhc3NlZCBpbiBzZyBlbnRyeSB0byBpbmRpY2F0ZSB0aGF0IHRoZSBkbWFf
YWRkcmVzcyBpcwo+ICsgKiAgIGEgUENJIGJ1cyBhZGRyZXNzLgo+ICsgKiovCj4gK3N0YXRpYyBp
bmxpbmUgdm9pZCBzZ19tYXJrX3BjaV9wMnBkbWEoc3RydWN0IHNjYXR0ZXJsaXN0ICpzZykKPiAr
ewo+ICsJc2ctPnBhZ2VfbGluayB8PSBTR19QQ0lfUDJQRE1BOwo+ICt9Cj4gKwo+ICsvKioKPiAr
ICogc2dfdW5tYXJrX3BjaV9wMnBkbWEgLSBVbm1hcmsgdGhlIHNjYXR0ZXJsaXN0IGVudHJ5IGZv
ciBQQ0kgcDJwZG1hCj4gKyAqIEBzZzoJCSBTRyBlbnRyeVNjYXR0ZXJsaXN0Cj4gKyAqCj4gKyAq
IERlc2NyaXB0aW9uOgo+ICsgKiAgIENsZWFycyB0aGUgUENJIFAyUERNQSBtYXJrCj4gKyAqKi8K
PiArc3RhdGljIGlubGluZSB2b2lkIHNnX3VubWFya19wY2lfcDJwZG1hKHN0cnVjdCBzY2F0dGVy
bGlzdCAqc2cpCj4gK3sKPiArCXNnLT5wYWdlX2xpbmsgJj0gflNHX1BDSV9QMlBETUE7Cj4gK30K
PiArCj4gICAvKioKPiAgICAqIHNnX3BoeXMgLSBSZXR1cm4gcGh5c2ljYWwgYWRkcmVzcyBvZiBh
biBzZyBlbnRyeQo+ICAgICogQHNnOgkgICAgIFNHIGVudHJ5Cj4gCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
