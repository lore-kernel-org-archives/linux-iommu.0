Return-Path: <SRS0=qXOr=FH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8A2C4361A
	for <iommu@archiver.kernel.org>; Thu,  3 Dec 2020 14:55:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15D17206D6
	for <iommu@archiver.kernel.org>; Thu,  3 Dec 2020 14:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15D17206D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8421287B37;
	Thu,  3 Dec 2020 14:55:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GBdwXec5R8d6; Thu,  3 Dec 2020 14:55:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5B05D87B30;
	Thu,  3 Dec 2020 14:55:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43388C0FA8;
	Thu,  3 Dec 2020 14:55:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C90BC0FA7
 for <iommu@lists.linux-foundation.org>; Thu,  3 Dec 2020 14:55:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8B0D886DAF
 for <iommu@lists.linux-foundation.org>; Thu,  3 Dec 2020 14:55:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y1U7kXDZdWR7 for <iommu@lists.linux-foundation.org>;
 Thu,  3 Dec 2020 14:55:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5706B875A7
 for <iommu@lists.linux-foundation.org>; Thu,  3 Dec 2020 14:55:05 +0000 (UTC)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CmzND2Zsqz67LbF;
 Thu,  3 Dec 2020 22:53:00 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 3 Dec 2020 15:54:57 +0100
Received: from [10.47.8.200] (10.47.8.200) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 3 Dec 2020
 14:54:56 +0000
Subject: Re: [RESEND PATCH v3 0/4] iommu/iova: Solve longterm IOVA issue
To: Dmitry Safonov <0x7f454c46@gmail.com>, Will Deacon <will@kernel.org>
References: <1605608734-84416-1-git-send-email-john.garry@huawei.com>
 <160685669713.992935.17438167536143205811.b4-ty@kernel.org>
 <CAJwJo6YmF+tW2_it2BLCP6fLBrUR6kfx7jG0hsNy6uYG203Jfw@mail.gmail.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <6e09d847-fb7f-1ec1-02bf-f0c8b315845f@huawei.com>
Date: Thu, 3 Dec 2020 14:54:27 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAJwJo6YmF+tW2_it2BLCP6fLBrUR6kfx7jG0hsNy6uYG203Jfw@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [10.47.8.200]
X-ClientProxiedBy: lhreml734-chm.china.huawei.com (10.201.108.85) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: Catalin Marinas <catalin.marinas@arm.com>, robin.murphy@arm.com,
 linuxarm@huawei.com, iommu@lists.linux-foundation.org,
 xiyou.wangcong@gmail.com, kernel-team@android.com,
 open list <linux-kernel@vger.kernel.org>
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

T24gMDMvMTIvMjAyMCAwNjowNCwgRG1pdHJ5IFNhZm9ub3Ygd3JvdGU6Cj4gT24gVHVlLCAxIERl
YyAyMDIwIGF0IDIxOjUwLCBXaWxsIERlYWNvbjx3aWxsQGtlcm5lbC5vcmc+ICB3cm90ZToKPj4g
T24gVHVlLCAxNyBOb3YgMjAyMCAxODoyNTozMCArMDgwMCwgSm9obiBHYXJyeSB3cm90ZToKPj4+
IFRoaXMgc2VyaWVzIGNvbnRhaW5zIGEgcGF0Y2ggdG8gc29sdmUgdGhlIGxvbmd0ZXJtIElPVkEg
aXNzdWUgd2hpY2gKPj4+IGxlaXpoZW4gb3JpZ2luYWxseSB0cmllZCB0byBhZGRyZXNzIGF0IFsw
XS4KPj4+Cj4+PiBBIHNpZXZlZCBrZXJuZWwgbG9nIGlzIGF0IHRoZSBmb2xsb3dpbmcsIHNob3dp
bmcgcGVyaW9kaWMgZHVtcHMgb2YgSU9WQQo+Pj4gc2l6ZXMsIHBlciBDUFUgYW5kIHBlciBkZXBv
dCBiaW4sIHBlciBJT1ZBIHNpemUgZ3JhbnVsZToKPj4+IGh0dHBzOi8vcmF3LmdpdGh1YnVzZXJj
b250ZW50LmNvbS9oaXNpbGljb24va2VybmVsLWRldi90b3BpYy1pb21tdS01LjEwLWlvdmEtZGVi
dWctdjMvYWdpbmdfdGVzdAo+Pj4KPj4+IFsuLi5dCj4+IEFwcGxpZWQgdGhlIGZpbmFsIHBhdGNo
IHRvIGFybTY0IChmb3ItbmV4dC9pb21tdS9pb3ZhKSwgdGhhbmtzIQo+Pgo+PiBbNC80XSBpb21t
dTogYXZvaWQgdGFraW5nIGlvdmFfcmJ0cmVlX2xvY2sgdHdpY2UKPj4gICAgICAgIGh0dHBzOi8v
Z2l0Lmtlcm5lbC5vcmcvYXJtNjQvYy8zYTY1MWIzYTI3YTEKPiBHbGFkIGl0IG1hZGUgaW4gbmV4
dCwgMiB5ZWFycyBhZ28gSSBjb3VsZG4ndCBjb252aW5jZSBpb21tdSBtYWludGFpbmVyCj4gaXQn
cyB3b3J0aCBpdCAoYnV0IHdpdGggYSBkaWZmZXJlbnQganVzdGlmaWNhdGlvbik6Cj4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaW9tbXUvMjAxODA2MjExODA4MjMuODA1LTMtZGltYUBh
cmlzdGEuY29tLwoKSGkgRG1pdHJ5LAoKSSB3YXMgdW5hd2FyZSBvZiB5b3VyIHNlcmllcywgYW5k
IGl04oCZcyB1bmZvcnR1bmF0ZSB0aGF0IHlvdXIgCm9wdGltaXphdGlvbiBuZXZlciBtYWRlIGl0
LiBIb3dldmVyIEkgd2FzIGhhdmluZyBhIHF1aWNrIGxvb2sgdGhlcmUsIAphbmQsIGluIGNhc2Ug
eW91IGRpZCBub3Qgbm90aWNlLCB0aGF0IHRoZSBjb2RlIHdoaWNoIHlvdSB3ZXJlIHByb3Bvc2lu
ZyAKY2hhbmdpbmcgaW4gcGF0Y2ggIzEgZm9yIGludGVsLWlvbW11LmMgd2FzIHJlbW92ZWQgaW4g
ZTcwYjA4MWM2ZjM3IAooImlvbW11L3Z0LWQ6IFJlbW92ZSBJT1ZBIGhhbmRsaW5nIGNvZGUgZnJv
bSB0aGUgbm9uLWRtYV9vcHMgcGF0aCIpLgoKQlRXLCBzcGxpdF9hbmRfcmVtb3ZlX2lvdmEoKSBo
YXMgbm8gaW4tdHJlZSB1c2VycyBhbnltb3JlLCBzbyBJIGNhbiBzZW5kIAphIHBhdGNoIHRvIGRl
bGV0ZSBpZiBub2JvZHkgZWxzZSB3YW50cyB0by4KCkJUVzIsIHRoZXJlJ3Mgc29tZSBtb3JlIHBh
dGNoZXMgaW4gbXkgc2VyaWVzIHdoaWNoIGNvdWxkIHVzZSBhIHJldmlldyBpZiAKeW91J3JlIGZl
ZWxpbmcgdmVyeSBoZWxwZnVsIDopCgpDaGVlcnMsCkpvaG4KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2lvbW11
