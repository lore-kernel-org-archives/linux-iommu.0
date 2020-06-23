Return-Path: <SRS0=bNYQ=AE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C54AC433E0
	for <iommu@archiver.kernel.org>; Tue, 23 Jun 2020 10:21:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3E3D20702
	for <iommu@archiver.kernel.org>; Tue, 23 Jun 2020 10:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3E3D20702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id CACE2884B4;
	Tue, 23 Jun 2020 10:21:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wAAzwSj5AhM1; Tue, 23 Jun 2020 10:21:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 062158815F;
	Tue, 23 Jun 2020 10:21:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB807C088E;
	Tue, 23 Jun 2020 10:21:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED4E1C016F
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 10:21:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E9F9586C5E
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 10:21:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VUfYMbcp904s for <iommu@lists.linux-foundation.org>;
 Tue, 23 Jun 2020 10:21:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0A48B86C08
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 10:21:18 +0000 (UTC)
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
 by Forcepoint Email with ESMTP id E5BDFB336F6AE3172B42;
 Tue, 23 Jun 2020 11:21:16 +0100 (IST)
Received: from [127.0.0.1] (10.47.2.88) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 23 Jun
 2020 11:21:15 +0100
Subject: Re: [PATCH 4/4] iommu/arm-smmu-v3: Remove cmpxchg() in
 arm_smmu_cmdq_issue_cmdlist()
To: Rikard Falkeborn <rikard.falkeborn@gmail.com>, "joro@8bytes.org"
 <joro@8bytes.org>
References: <1592846920-45338-5-git-send-email-john.garry@huawei.com>
 <202006230905.3HpPgtSC%lkp@intel.com>
 <5ba2e240-b324-d316-c00c-38c03ee49baa@huawei.com>
 <CADRDgG4=uD3Ni6r7D3kHdSo=ketaXKGririHfFvPYq4qz8KjfQ@mail.gmail.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <ee2d7a1e-3e22-f25a-ced9-82ccced28f8c@huawei.com>
Date: Tue, 23 Jun 2020 11:19:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CADRDgG4=uD3Ni6r7D3kHdSo=ketaXKGririHfFvPYq4qz8KjfQ@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [10.47.2.88]
X-ClientProxiedBy: lhreml730-chm.china.huawei.com (10.201.108.81) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: "trivial@kernel.org" <trivial@kernel.org>,
 kernel test robot <lkp@intel.com>, will@kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linuxarm <linuxarm@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "maz@kernel.org" <maz@kernel.org>,
 "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

T24gMjMvMDYvMjAyMCAxMDozNSwgUmlrYXJkIEZhbGtlYm9ybiB3cm90ZToKPiAKPiAgICAgSSdk
IHNheSB0aGF0IEdFTk1BU0tfSU5QVVRfQ0hFQ0soKSBzaG91bGQgYmUgYWJsZSB0byBoYW5kbGUg
YSBsPTAgYW5kCj4gICAgIGg9dW5zaWduZWQgdmFsdWUsIHNvIEkgZG91YnQgdGhpcyB3YXJuLgo+
IAo+ICAgICBVc2luZyBHRU5NQVNLKChpbnQpY21kcS0+cS5sbHEubWF4X25fc2hpZnQsIDApIHJl
c29sdmVzIGl0LCBidXQgaXQKPiAgICAgbG9va3MKPiAgICAgbGlrZSBHRU5NQVNLX0lOUFVUX0NI
RUNLKCkgY291bGQgYmUgaW1wcm92ZWQuCj4gCj4gCj4gSW5kZWVkIGl0IGNvdWxkLCBpdCBpcyBm
aXhlZCBpbiAtbmV4dC4KCm9rLCB0aGFua3MgZm9yIHRoZSBwb2ludGVyLCBidXQgSSBzdGlsbCBz
ZWUgdGhpcyBvbiB0b2RheSdzIC1uZXh0IHdpdGggCnRoaXMgcGF0Y2g6CgptYWtlIFc9MSBkcml2
ZXJzL2lvbW11L2FybS1zbW11LXYzLm8KCkluIGZpbGUgaW5jbHVkZWQgZnJvbSAuL2luY2x1ZGUv
bGludXgvYml0cy5oOjIzOjAsCiAgICAgICAgICAgICAgICAgZnJvbSAuL2luY2x1ZGUvbGludXgv
aW9wb3J0Lmg6MTUsCiAgICAgICAgICAgICAgICAgZnJvbSAuL2luY2x1ZGUvbGludXgvYWNwaS5o
OjEyLAogICAgICAgICAgICAgICAgIGZyb20gZHJpdmVycy9pb21tdS9hcm0tc21tdS12My5jOjEy
Ogpkcml2ZXJzL2lvbW11L2FybS1zbW11LXYzLmM6IEluIGZ1bmN0aW9uIOKAmGFybV9zbW11X2Nt
ZHFfaXNzdWVfY21kbGlzdOKAmToKLi9pbmNsdWRlL2xpbnV4L2JpdHMuaDoyNzo3OiB3YXJuaW5n
OiBjb21wYXJpc29uIG9mIHVuc2lnbmVkIGV4cHJlc3Npb24gCjwgMCBpcyBhbHdheXMgZmFsc2Ug
Wy1XdHlwZS1saW1pdHNdCiAgIChsKSA+IChoKSwgMCkpKQogICAgICAgXgouL2luY2x1ZGUvbGlu
dXgvYnVpbGRfYnVnLmg6MTY6NjI6IG5vdGU6IGluIGRlZmluaXRpb24gb2YgbWFjcm8gCuKAmEJV
SUxEX0JVR19PTl9aRVJP4oCZCiNkZWZpbmUgQlVJTERfQlVHX09OX1pFUk8oZSkgKChpbnQpKHNp
emVvZihzdHJ1Y3QgeyBpbnQ6KC0hIShlKSk7IH0pKSkKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCi4vaW5jbHVkZS9saW51eC9i
aXRzLmg6NDA6Mzogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIArigJhHRU5NQVNLX0lOUFVU
X0NIRUNL4oCZCiAgKEdFTk1BU0tfSU5QVVRfQ0hFQ0soaCwgbCkgKyBfX0dFTk1BU0soaCwgbCkp
CiAgIF5+fn5+fn5+fn5+fn5+fn5+fn4KZHJpdmVycy9pb21tdS9hcm0tc21tdS12My5jOjE0MDQ6
MTg6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhHRU5NQVNL4oCZCiAgdTMyIHByb2Rf
bWFzayA9IEdFTk1BU0soY21kcS0+cS5sbHEubWF4X25fc2hpZnQsIDApOwoKVGhhdCdzIGdjYyA3
LjUuMCAuCgpDaGVlcnMsCkpvaG4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by9pb21tdQ==
