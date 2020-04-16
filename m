Return-Path: <SRS0=meaX=6A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AA7C352BE
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 17:17:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E61D92076D
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 17:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E61D92076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BF67B875A1;
	Thu, 16 Apr 2020 17:17:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QfyN5aMkYgyQ; Thu, 16 Apr 2020 17:17:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9C1A587591;
	Thu, 16 Apr 2020 17:17:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 906BAC089E;
	Thu, 16 Apr 2020 17:17:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74DD8C0172
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 17:17:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5AC22861EE
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 17:17:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0l_IqbRyNk6W for <iommu@lists.linux-foundation.org>;
 Thu, 16 Apr 2020 17:17:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 428B985D95
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 17:17:38 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7287730E;
 Thu, 16 Apr 2020 10:17:37 -0700 (PDT)
Received: from [10.57.59.184] (unknown [10.57.59.184])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CBA23F73D;
 Thu, 16 Apr 2020 10:17:35 -0700 (PDT)
Subject: Re: [PATCH 2/2] iommu/arm-smmu: Allow client devices to select direct
 mapping
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
References: <cover.1579692800.git.saiprakash.ranjan@codeaurora.org>
 <813cc5b2da10c27db982254b274bf26008a9e6da.1579692800.git.saiprakash.ranjan@codeaurora.org>
 <3f12cefb-3887-859c-ddf5-c7a0fc755152@arm.com>
 <540fc55811d0a60a929ff1f694d6d271@codeaurora.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <fdc265e4-5a96-2def-df13-376249e16b49@arm.com>
Date: Thu, 16 Apr 2020 18:17:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <540fc55811d0a60a929ff1f694d6d271@codeaurora.org>
Content-Language: en-GB
Cc: Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux-foundation.org, Matthias Kaehlcke <mka@chromium.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 linux-arm-kernel@lists.infradead.org, Stephen Boyd <swboyd@chromium.org>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
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

T24gMjAyMC0wNC0xNiA1OjIzIHBtLCBTYWkgUHJha2FzaCBSYW5qYW4gd3JvdGU6Cj4gSGkgUm9i
aW4sCj4gCj4gT24gMjAyMC0wNC0xNiAxOToyOCwgUm9iaW4gTXVycGh5IHdyb3RlOgo+PiBPbiAy
MDIwLTAxLTIyIDExOjQ4IGFtLCBTYWkgUHJha2FzaCBSYW5qYW4gd3JvdGU6Cj4+PiBGcm9tOiBK
b3JkYW4gQ3JvdXNlIDxqY3JvdXNlQGNvZGVhdXJvcmEub3JnPgo+Pj4KPj4+IFNvbWUgY2xpZW50
IGRldmljZXMgd2FudCB0byBkaXJlY3RseSBtYXAgdGhlIElPTU1VIHRoZW1zZWx2ZXMgaW5zdGVh
ZAo+Pj4gb2YgdXNpbmcgdGhlIERNQSBkb21haW4uIEFsbG93IHRob3NlIGRldmljZXMgdG8gb3B0
IGluIHRvIGRpcmVjdAo+Pj4gbWFwcGluZyBieSB3YXkgb2YgYSBsaXN0IG9mIGNvbXBhdGlibGUg
c3RyaW5ncy4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBKb3JkYW4gQ3JvdXNlIDxqY3JvdXNlQGNv
ZGVhdXJvcmEub3JnPgo+Pj4gQ28tZGV2ZWxvcGVkLWJ5OiBTYWkgUHJha2FzaCBSYW5qYW4gPHNh
aXByYWthc2gucmFuamFuQGNvZGVhdXJvcmEub3JnPgo+Pj4gU2lnbmVkLW9mZi1ieTogU2FpIFBy
YWthc2ggUmFuamFuIDxzYWlwcmFrYXNoLnJhbmphbkBjb2RlYXVyb3JhLm9yZz4KPj4+IC0tLQo+
Pj4gwqAgZHJpdmVycy9pb21tdS9hcm0tc21tdS1xY29tLmMgfCAzOSArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKwo+Pj4gwqAgZHJpdmVycy9pb21tdS9hcm0tc21tdS5jwqDCoMKg
wqDCoCB8wqAgMyArKysKPj4+IMKgIGRyaXZlcnMvaW9tbXUvYXJtLXNtbXUuaMKgwqDCoMKgwqAg
fMKgIDUgKysrKysKPj4+IMKgIDMgZmlsZXMgY2hhbmdlZCwgNDcgaW5zZXJ0aW9ucygrKQo+Pj4K
Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2FybS1zbW11LXFjb20uYyAKPj4+IGIvZHJp
dmVycy9pb21tdS9hcm0tc21tdS1xY29tLmMKPj4+IGluZGV4IDY0YTRhYjI3MGFiNy4uZmY3NDZh
Y2QxYzgxIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9pb21tdS9hcm0tc21tdS1xY29tLmMKPj4+
ICsrKyBiL2RyaXZlcnMvaW9tbXUvYXJtLXNtbXUtcWNvbS5jCj4+PiBAQCAtMyw2ICszLDcgQEAK
Pj4+IMKgwqAgKiBDb3B5cmlnaHQgKGMpIDIwMTksIFRoZSBMaW51eCBGb3VuZGF0aW9uLiBBbGwg
cmlnaHRzIHJlc2VydmVkLgo+Pj4gwqDCoCAqLwo+Pj4gwqAgKyNpbmNsdWRlIDxsaW51eC9vZl9k
ZXZpY2UuaD4KPj4+IMKgICNpbmNsdWRlIDxsaW51eC9xY29tX3NjbS5oPgo+Pj4gwqDCoMKgICNp
bmNsdWRlICJhcm0tc21tdS5oIgo+Pj4gQEAgLTExLDYgKzEyLDQzIEBAIHN0cnVjdCBxY29tX3Nt
bXUgewo+Pj4gwqDCoMKgwqDCoCBzdHJ1Y3QgYXJtX3NtbXVfZGV2aWNlIHNtbXU7Cj4+PiDCoCB9
Owo+Pj4gwqAgK3N0YXRpYyBjb25zdCBzdHJ1Y3QgYXJtX3NtbXVfY2xpZW50X21hdGNoX2RhdGEg
cWNvbV9hZHJlbm8gPSB7Cj4+PiArwqDCoMKgIC5kaXJlY3RfbWFwcGluZyA9IHRydWUsCj4+PiAr
fTsKPj4+ICsKPj4+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGFybV9zbW11X2NsaWVudF9tYXRjaF9k
YXRhIHFjb21fbWRzcyA9IHsKPj4+ICvCoMKgwqAgLmRpcmVjdF9tYXBwaW5nID0gdHJ1ZSwKPj4+
ICt9Owo+Pgo+PiBNaWdodCBpdCBtYWtlIHNlbnNlIHRvIGdyb3VwIHRoZXNlIGJ5IHRoZSBkZXNp
cmVkIFNNTVUgYmVoYXZpb3VyCj4+IHJhdGhlciB0aGFuIChhcHBhcmVudGx5KSB3aGF0IGtpbmQg
b2YgZGV2aWNlIHRoZSBjbGllbnQgaGFwcGVucyB0byBiZSwKPj4gd2hpY2ggc2VlbXMgbGlrZSBh
IGNvbXBsZXRlbHkgYXJiaXRyYXJ5IGRpc3RpbmN0aW9uIGZyb20gdGhlIFNNTVUKPj4gZHJpdmVy
J3MgUG9WPwo+Pgo+IAo+IFNvcnJ5LCBJIGRpZCBub3QgZ2V0IHRoZSAiZ3JvdXBpbmcgYnkgdGhl
IGRlc2lyZWQgU01NVSBiZWhhdmlvdXIiIHRoaW5nLgo+IENvdWxkIHlvdSBwbGVhc2UgZ2l2ZSBz
b21lIG1vcmUgZGV0YWlscz8KCkkgbWVhbiB0aGlzIHBhdHRlcm46CgpkZXZpY2VfYV9kYXRhIHsK
CS50aGluZyA9IHRoaXM7Cn0KCmRldmljZV9iX2RhdGEgewoJLnRoaW5nID0gdGhpczsKfQoKZGV2
aWNlX2NfZGF0YSB7CgkudGhpbmcgPSB0aGF0Owp9CgptYXRjaFtdID0gewoJeyAuY29tcGF0aWJs
ZSA9ICJBIiwgLmRhdGEgPSAmZGV2aWNlX2FfZGF0YSB9LAoJeyAuY29tcGF0aWJsZSA9ICJCIiwg
LmRhdGEgPSAmZGV2aWNlX2JfZGF0YSB9LAoJeyAuY29tcGF0aWJsZSA9ICJDIiwgLmRhdGEgPSAm
ZGV2aWNlX2NfZGF0YSB9LAp9OwoKLi4udnMuIHRoaXMgcGF0dGVybjoKCmRvX3RoaXMgewoJLnRo
aW5nID0gdGhpczsKfQoKZG9fdGhhdCB7CgkudGhpbmcgPSB0aGF0Owp9CgptYXRjaFtdID0gewoJ
eyAuY29tcGF0aWJsZSA9ICJBIiwgLmRhdGEgPSAmZG9fdGhpcyB9LAoJeyAuY29tcGF0aWJsZSA9
ICJCIiwgLmRhdGEgPSAmZG9fdGhpcyB9LAoJeyAuY29tcGF0aWJsZSA9ICJDIiwgLmRhdGEgPSAm
ZG9fdGhhdCB9LAp9OwoKIEZyb20gdGhlIHBlcnNwZWN0aXZlIG9mIHRoZSB0aGluZyBkb2luZyB0
aGUgdGhpbmcsIGdyb3VwaW5nIHRoZSBkYXRhIGJ5IApkZXZpY2UgaXMgbWVhbmluZ2xlc3MgaWYg
YWxsIHRoYXQgbWF0dGVycyBpcyB3aGV0aGVyIHRvIGRvIHRoaXMgb3IgdGhhdC4gClRoZSBzZWNv
bmQgcGF0dGVybiBleHByZXNzZXMgdGhhdCBtb3JlIG5hdHVyYWxseS4KCk9mIGNvdXJzZSBpZiBl
dmVyeSBkZXZpY2UgdHVybnMgb3V0IHRvIG5lZWQgYSB1bmlxdWUgY29tYmluYXRpb24gb2YgCnNl
dmVyYWwgYmVoYXZpb3VycywgdGhlbiB0aGVyZSBlbmRzIHVwIGJlaW5nIG5vIHByYWN0aWNhbCBk
aWZmZXJlbmNlIApleGNlcHQgdGhhdCBpdCdzIHByb2JhYmx5IGVhc2llciB0byBjb21lIHVwIHdp
dGggbmljZSBuYW1lcyB1bmRlciB0aGUgCmZpcnN0IHBhdHRlcm4uIEkgZ3Vlc3MgaXQncyB1cCB0
byBob3cgeW91IHNlZSB0aGlzIGRldmVsb3BpbmcgaW4gZnV0dXJlOyAKd2hldGhlciB5b3UncmUg
bGlrZWx5IHRvIG5lZWQgZmluZS1ncmFpbmVkIHBlci1kZXZpY2UgY29udHJvbCwgb3IgZG9uJ3Qg
CmV4cGVjdCBpdCB0byBnbyBtdWNoIGJleW9uZCBkb21haW4gdHlwZS4KClJvYmluLgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxp
c3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
