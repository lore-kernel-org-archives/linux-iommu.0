Return-Path: <SRS0=28v9=7V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B2AC433E0
	for <iommu@archiver.kernel.org>; Mon,  8 Jun 2020 11:27:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8488206C3
	for <iommu@archiver.kernel.org>; Mon,  8 Jun 2020 11:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8488206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 99B4320488;
	Mon,  8 Jun 2020 11:26:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q2kZUt+tpvAn; Mon,  8 Jun 2020 11:26:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 679BD2078B;
	Mon,  8 Jun 2020 11:26:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51B5BC0863;
	Mon,  8 Jun 2020 11:26:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9BB70C016F
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 11:26:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8A42C87EA0
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 11:26:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L0a7-8PNUxD8 for <iommu@lists.linux-foundation.org>;
 Mon,  8 Jun 2020 11:26:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 44AC987E8F
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 11:26:54 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 915C01FB;
 Mon,  8 Jun 2020 04:26:53 -0700 (PDT)
Received: from [10.57.9.113] (unknown [10.57.9.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FFEC3F73D;
 Mon,  8 Jun 2020 04:26:52 -0700 (PDT)
Subject: Re: [RFC PATCH] iommu/arm-smmu: Remove shutdown callback
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Will Deacon <will@kernel.org>
References: <20200607110918.1733-1-saiprakash.ranjan@codeaurora.org>
 <20200608081846.GA1542@willie-the-truck>
 <08c293eefc20bc2c67f2d2639b93f0a5@codeaurora.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <e072f61a-d6cf-2e34-efd5-c1db38c5c622@arm.com>
Date: Mon, 8 Jun 2020 12:26:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <08c293eefc20bc2c67f2d2639b93f0a5@codeaurora.org>
Content-Language: en-GB
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

T24gMjAyMC0wNi0wOCAxMDoxMywgU2FpIFByYWthc2ggUmFuamFuIHdyb3RlOgo+IEhpIFdpbGws
Cj4gCj4gT24gMjAyMC0wNi0wOCAxMzo0OCwgV2lsbCBEZWFjb24gd3JvdGU6Cj4+IE9uIFN1biwg
SnVuIDA3LCAyMDIwIGF0IDA0OjM5OjE4UE0gKzA1MzAsIFNhaSBQcmFrYXNoIFJhbmphbiB3cm90
ZToKPj4+IFJlbW92ZSBTTU1VIHNodXRkb3duIGNhbGxiYWNrIHNpbmNlIGl0IHNlZW1zIHRvIGNh
dXNlIG1vcmUKPj4+IHByb2JsZW1zIHRoYW4gYmVuZWZpdHMuIFdpdGggdGhpcyBjYWxsYmFjaywg
d2UgbmVlZCB0byBtYWtlCj4+PiBzdXJlIHRoYXQgYWxsIGNsaWVudHMvY29uc3VtZXJzIG9mIFNN
TVUgZG8gbm90IHBlcmZvcm0gYW55Cj4+PiBETUEgYWN0aXZpdHkgb25jZSB0aGUgU01NVSBpcyBz
aHV0ZG93biBhbmQgdHJhbnNsYXRpb24gaXMKPj4+IGRpc2FibGVkLiBJbiBvdGhlciB3b3JkcyB3
ZSBuZWVkIHRvIGFkZCBzaHV0ZG93biBjYWxsYmFja3MKPj4+IGZvciBhbGwgdGhvc2UgY2xpZW50
cyB0byBtYWtlIHN1cmUgdGhleSBkbyBub3QgcGVyZm9ybSBhbnkKPj4+IERNQSBvciBlbHNlIHdl
IHNlZSBhbGwga2luZHMgb2Ygd2VpcmQgY3Jhc2hlcyBkdXJpbmcgcmVib290Cj4+PiBvciBzaHV0
ZG93bi4gVGhpcyBpcyBjbGVhcmx5IG5vdCBzY2FsYWJsZSBhcyB0aGUgbnVtYmVyIG9mCj4+PiBj
bGllbnRzIG9mIFNNTVUgd291bGQgdmFyeSBhY3Jvc3MgU29DcyBhbmQgd2Ugd291bGQgbmVlZCB0
bwo+Pj4gYWRkIHNodXRkb3duIGNhbGxiYWNrcyB0byBhbG1vc3QgYWxsIGRyaXZlcnMgZXZlbnR1
YWxseS4KPj4+IFRoaXMgY2FsbGJhY2sgd2FzIGFkZGVkIGZvciBrZXhlYyB1c2VjYXNlIHdoZXJl
IGl0IHdhcyBrbm93bgo+Pj4gdG8gY2F1c2UgbWVtb3J5IGNvcnJ1cHRpb25zIHdoZW4gU01NVSB3
YXMgbm90IHNodXRkb3duIGJ1dAo+Pj4gdGhhdCBkb2VzIG5vdCBkaXJlY3RseSByZWxhdGUgdG8g
U01NVSBiZWNhdXNlIHRoZSBtZW1vcnkKPj4+IGNvcnJ1cHRpb24gY291bGQgYmUgYmVjYXVzZSBv
ZiB0aGUgY2xpZW50IG9mIFNNTVUgd2hpY2ggaXMKPj4+IG5vdCBzaHV0ZG93biBwcm9wZXJseSBi
ZWZvcmUgYm9vdGluZyBpbnRvIG5ldyBrZXJuZWwuIFNvIGluCj4+PiB0aGF0IGNhc2UsIHdlIG5l
ZWQgdG8gaWRlbnRpZnkgdGhlIGNsaWVudCBvZiBTTU1VIGNhdXNpbmcKPj4+IHRoZSBtZW1vcnkg
Y29ycnVwdGlvbiBhbmQgYWRkIGFwcHJvcHJpYXRlIHNodXRkb3duIGNhbGxiYWNrCj4+PiB0byB0
aGUgY2xpZW50IHJhdGhlciB0aGFuIHRvIHRoZSBTTU1VLgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6
IFNhaSBQcmFrYXNoIFJhbmphbiA8c2FpcHJha2FzaC5yYW5qYW5AY29kZWF1cm9yYS5vcmc+Cj4+
PiAtLS0KPj4+IMKgZHJpdmVycy9pb21tdS9hcm0tc21tdS12My5jIHwgNiAtLS0tLS0KPj4+IMKg
ZHJpdmVycy9pb21tdS9hcm0tc21tdS5jwqDCoMKgIHwgNiAtLS0tLS0KPj4+IMKgMiBmaWxlcyBj
aGFuZ2VkLCAxMiBkZWxldGlvbnMoLSkKPj4KPj4gVGhpcyBmZWVscyBsaWtlIGEgZ2lhbnQgYm9k
Z2UgdG8gbWUgYW5kIEkgdGhpbmsgdGhhdCBhbnkgZHJpdmVyIHdoaWNoCj4+IGNvbnRpbnVlcyB0
byBwZXJmb3JtIERNQSBhZnRlciBpdHMgLT5zaHV0ZG93bigpIGZ1bmN0aW9uIGhhcyBiZWVuIGlu
dm9rZWQKPj4gaXMgYnVnZ3kuIFdvdWxkbid0IHRoYXQgY2F1c2UgcHJvYmxlbXMgd2l0aCBrZXhl
YygpLCBmb3IgZXhhbXBsZT8KPj4KPiAKPiBZZXMgaXQgaXMgZGVmaW5pdGVseSBhIGJ1ZyBpbiB0
aGUgY2xpZW50IGRyaXZlciBpZiBETUEgaXMgcGVyZm9ybWVkCj4gYWZ0ZXIgc2h1dGRvd24gY2Fs
bGJhY2sgb2YgdGhhdCByZXNwZWN0aXZlIGRyaXZlciBpcyBpbnZva2VkIGFuZCBpdCBtdXN0Cj4g
YmUgZml4ZWQgaW4gdGhhdCBkcml2ZXIuIEJ1dCBoZXJlIHRoZSBwcm9ibGVtIEkgd2FzIGRlc2Ny
aWJpbmcgaXMgbm90IHRoYXQsCj4gbW9zdCBvZiB0aGUgZHJpdmVycyBkbyBub3QgaGF2ZSBhIHNo
dXRkb3duIGNhbGxiYWNrIHRvIGJlZ2luIHdpdGggYW5kIAo+IGFkZGluZwo+IGl0IGp1c3QgYmVj
YXVzZSBvZiBzaHV0ZG93biBkZXBlbmRlbmN5IG9uIFNNTVUgZG9lc24ndCBzZWVtIHNvIHdlbGwg
YmVjYXVzZQo+IHdlIGNhbiBoYXZlIG1hbnkgbW9yZSBzdWNoIGNsaWVudHMgaW4gdGhlIGZ1dHVy
ZSBhbmQgdGhlbiB3ZSBoYXZlIHRvIAo+IGp1c3QgZ28KPiBvbiBhZGRpbmcgdGhlIHNodXRkb3du
IGNhbGxiYWNrcyBldmVyeXdoZXJlLgoKWWVzLCBpbmRlZWQgd2UgZG8uIExpa2UgaXQgb3Igbm90
LCBrZXhlYyBpcyBhIHRoaW5nLCBhbmQgYWJvdXQgOTglIG9mIApkcml2ZXJzIHdpbGwgaGF2ZSBi
ZWVuIHdyaXR0ZW4gd2l0aG91dCBjb25zaWRlcmluZyBpdC4KCklmIGZpeGluZyBvbmUgcHJvYmxl
bSBleHBvc2VzIGxvdHMgb2Ygb3RoZXIgcHJvYmxlbXMsIGNhbiB5b3UgaG9uZXN0bHkgCnNheSB0
aGF0IHRoZSBiZXN0IHNvbHV0aW9uIGlzIHRvIGdvIGJhY2sgYW5kIHJlLWJyZWFrIHRoZSBvcmln
aW5hbCB0aGluZz8KCj4+IFRoZXJlJ3MgYSBjbGVhciBzaHV0ZG93biBkZXBlbmRlbmN5IG9yZGVy
aW5nLCB3aGVyZSB0aGUgY2xpZW50cyBvZiB0aGUKPj4gU01NVSBuZWVkIHRvIHNodXRkb3duIGJl
Zm9yZSB0aGUgU01NVSBpdHNlbGYsIGJ1dCB0aGF0J3Mgbm90IHJlYWxseQo+PiB0aGUgU01NVSBk
cml2ZXIncyBwcm9ibGVtIHRvIHNvbHZlLgo+Pgo+IAo+IFRoZSBwcm9ibGVtIHdpdGgga2V4ZWMg
bWF5IG5vdCBiZSBkaXJlY3RseSByZWxhdGVkIHRvIFNNTVUgYXMgeW91IHNhaWQKPiBhYm92ZSBp
ZiBETUEgaXMgcGVyZm9ybWVkIGFmdGVyIHRoZSBjbGllbnQgc2h1dGRvd24gY2FsbGJhY2ssIHRo
ZW4gaXRzIGEKPiBidWcgaW4gdGhlIGNsaWVudCBkcml2ZXIsIHNvIHRoYXQgbmVlZHMgdG8gYmUg
Zml4ZWQgaW4gdGhlIGNsaWVudCBkcml2ZXIsCj4gbm90IHRoZSBTTU1VLiBTbyBpcyB0aGVyZSBh
bnkgcG9pbnQgaW4gaGF2aW5nIHRoZSBTTU1VIHNodXRkb3duIGNhbGxiYWNrPwoKVGhlIHBvaW50
IGlzIHRoYXQga2V4ZWMgbmVlZHMgdG8gcmV0dXJuIHRoZSBzeXN0ZW0gdG8gYSBzdGF0ZSBhcyBj
bG9zZSAKdG8gcmVzZXQgYXMgcG9zc2libGUuIFRoZSBTTU1VIGlzIGF0IGxlYXN0IGFzIHJlbGV2
YW50IGFzIGFueSBvdGhlciAKZGV2aWNlIGluIHRoYXQgcmVnYXJkLCBpZiBub3QgZmFyIG1vcmUg
c28gLSBjb25zaWRlciBpZiB0aGUgZmlyc3Qga2VybmVsIAoqZGlkKiBsZWF2ZSBpdCBlbmFibGVk
IHdpdGggd2hhdGV2ZXIgbGVmdC1vdmVyIHRyYW5zbGF0aW9ucyBpbiBwbGFjZSwgCmFuZCBrZXhl
YydlZCBpbnRvIGFub3RoZXIgT1MgdGhhdCB3YXNuJ3QgU01NVS1hd2FyZS4uLgoKPiBBcyB5b3Ug
c2VlLCB3aXRoIHRoaXMgU01NVSBzaHV0ZG93biBjYWxsYmFjaywgd2UgbmVlZCB0byBhZGQgc2h1
dGRvd24KPiBjYWxsYmFja3MgaW4gYWxsIHRoZSBjbGllbnQgZHJpdmVycy4KClllcy4gQW5kIGlm
IHlvdSByZWFsbHkgd2FudCB0byBhcmd1ZSBhZ2FpbnN0IHRoYXQsIHRoZW4gYXQgbGVhc3QgYmUg
CmNvbnNpc3RlbnQgYW5kIHByb3Bvc2UgcmVtb3Zpbmcgc2h1dGRvd24gZnJvbSAqYWxsKiB0aGUg
SU9NTVUgZHJpdmVycy4gCkFuZCB0aGVuIHByb2JhYmx5IHByb3Bvc2UgcmVtb3Zpbmcga2V4ZWMg
c3VwcG9ydCBmcm9tIGFsbCB0aGVpciAKcmVzcGVjdGl2ZSBhcmNoaXRlY3R1cmVzLi4uIDspCgpS
b2Jpbi4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9t
bXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
