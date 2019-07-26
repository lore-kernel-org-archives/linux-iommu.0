Return-Path: <SRS0=gbr8=VX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12288C7618B
	for <iommu@archiver.kernel.org>; Fri, 26 Jul 2019 12:01:08 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD470218DA
	for <iommu@archiver.kernel.org>; Fri, 26 Jul 2019 12:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD470218DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id AF09DC8F;
	Fri, 26 Jul 2019 12:01:07 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id EF62FAB9
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 12:01:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id E71F989C
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 12:01:04 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F185344;
	Fri, 26 Jul 2019 05:01:04 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2B983F694;
	Fri, 26 Jul 2019 05:01:03 -0700 (PDT)
Subject: Re: [PATCH] iommu: arm-smmu-v3: Mark expected switch fall-through
To: Anders Roxell <anders.roxell@linaro.org>, will@kernel.org, joro@8bytes.org
References: <20190726112821.19775-1-anders.roxell@linaro.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <522507e5-96e6-2bf4-cf91-73963a77358d@arm.com>
Date: Fri, 26 Jul 2019 13:01:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190726112821.19775-1-anders.roxell@linaro.org>
Content-Language: en-GB
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

T24gMjYvMDcvMjAxOSAxMjoyOCwgQW5kZXJzIFJveGVsbCB3cm90ZToKPiBXaGVuIGZhbGwtdGhy
b3VnaCB3YXJuaW5ncyB3YXMgZW5hYmxlZCBieSBkZWZhdWx0LCBjb21taXQgZDkzNTEyZWYwZjBl
CgpUaGF0IGNvbW1pdCBJRCBvbmx5IGV4aXN0cyBpbiBhIGhhbmRmdWwgb2Ygb2xkIGxpbnV4LW5l
eHQgdGFncy4KCj4gKCJNYWtlZmlsZTogR2xvYmFsbHkgZW5hYmxlIGZhbGwtdGhyb3VnaCB3YXJu
aW5nIiksIHRoZSBmb2xsb3dpbmcKPiB3YXJuaW5nIHdhcyBzdGFydGluZyB0byBzaG93IHVwOgo+
IAo+IC4uL2RyaXZlcnMvaW9tbXUvYXJtLXNtbXUtdjMuYzogSW4gZnVuY3Rpb24g4oCYYXJtX3Nt
bXVfd3JpdGVfc3RydGFiX2VudOKAmToKPiAuLi9kcml2ZXJzL2lvbW11L2FybS1zbW11LXYzLmM6
MTE4OTo3OiB3YXJuaW5nOiB0aGlzIHN0YXRlbWVudCBtYXkgZmFsbAo+ICAgdGhyb3VnaCBbLVdp
bXBsaWNpdC1mYWxsdGhyb3VnaD1dCj4gICAgICBpZiAoZGlzYWJsZV9ieXBhc3MpCj4gICAgICAg
ICBeCj4gLi4vZHJpdmVycy9pb21tdS9hcm0tc21tdS12My5jOjExOTE6Mzogbm90ZTogaGVyZQo+
ICAgICBkZWZhdWx0Ogo+ICAgICBefn5+fn5+Cj4gCj4gUmV3b3JrIHNvIHRoYXQgdGhlIGNvbXBp
bGVyIGRvZXNuJ3Qgd2FybiBhYm91dCBmYWxsLXRocm91Z2guIE1ha2UgaXQKPiBjbGVhcmVyIGJ5
IGNhbGxpbmcgJ0JVRygpJyB3aGVuIGRpc2FibGVfYnlwYXNzIGlzIHNldCwgYW5kIGFsd2F5cwo+
ICdicmVhazsnCj4gCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcgIyB2NC4yKwo+IEZpeGVz
OiA1YmMwYTExNjY0ZTEgKCJpb21tdS9hcm0tc21tdTogRG9uJ3QgQlVHKCkgaWYgd2UgZmluZCBh
Ym9ydGluZyBTVEVzIHdpdGggZGlzYWJsZV9ieXBhc3MiKQoKV2h5PyBUaGVyZSdzIG5vIGFjdHVh
bCBidWcsIGFuZCBub3QgZXZlbiBjdXJyZW50IGtlcm5lbHMgaGF2ZSB0aGF0IAp3YXJuaW5nIGVu
YWJsZWQuCgo+IFNpZ25lZC1vZmYtYnk6IEFuZGVycyBSb3hlbGwgPGFuZGVycy5yb3hlbGxAbGlu
YXJvLm9yZz4KPiAtLS0KPiAgIGRyaXZlcnMvaW9tbXUvYXJtLXNtbXUtdjMuYyB8IDUgKysrLS0K
PiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvYXJtLXNtbXUtdjMuYyBiL2RyaXZlcnMvaW9tbXUv
YXJtLXNtbXUtdjMuYwo+IGluZGV4IGE5YTlmYWJkMzk2OC4uOGU1ZjA1NjU5OTZkIDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvaW9tbXUvYXJtLXNtbXUtdjMuYwo+ICsrKyBiL2RyaXZlcnMvaW9tbXUv
YXJtLXNtbXUtdjMuYwo+IEBAIC0xMTg2LDggKzExODYsOSBAQCBzdGF0aWMgdm9pZCBhcm1fc21t
dV93cml0ZV9zdHJ0YWJfZW50KHN0cnVjdCBhcm1fc21tdV9tYXN0ZXIgKm1hc3RlciwgdTMyIHNp
ZCwKPiAgIAkJCXN0ZV9saXZlID0gdHJ1ZTsKPiAgIAkJCWJyZWFrOwo+ICAgCQljYXNlIFNUUlRB
Ql9TVEVfMF9DRkdfQUJPUlQ6Cj4gLQkJCWlmIChkaXNhYmxlX2J5cGFzcykKPiAtCQkJCWJyZWFr
Owo+ICsJCQlpZiAoIWRpc2FibGVfYnlwYXNzKQo+ICsJCQkJQlVHKCk7CgpZb3UgbWF5IGFzIHdl
bGwganVzdCB1c2UgQlVHX09OKCkuCgpSb2Jpbi4KCj4gKwkJCWJyZWFrOwo+ICAgCQlkZWZhdWx0
Ogo+ICAgCQkJQlVHKCk7IC8qIFNURSBjb3JydXB0aW9uICovCj4gICAJCX0KPiAKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0
CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
