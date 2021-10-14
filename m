Return-Path: <SRS0=rAFC=PC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A30AC433F5
	for <iommu@archiver.kernel.org>; Thu, 14 Oct 2021 16:17:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CB5660C41
	for <iommu@archiver.kernel.org>; Thu, 14 Oct 2021 16:17:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1CB5660C41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D351B60762;
	Thu, 14 Oct 2021 16:17:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5RdMWKPaT_lJ; Thu, 14 Oct 2021 16:17:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BFD58606E6;
	Thu, 14 Oct 2021 16:17:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84D27C0011;
	Thu, 14 Oct 2021 16:17:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D8F9FC000D
 for <iommu@lists.linux-foundation.org>; Thu, 14 Oct 2021 16:17:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B0122831E7
 for <iommu@lists.linux-foundation.org>; Thu, 14 Oct 2021 16:17:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3oSmUWlo0GP9 for <iommu@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 16:17:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 961B2831DA
 for <iommu@lists.linux-foundation.org>; Thu, 14 Oct 2021 16:17:28 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A378B11D4;
 Thu, 14 Oct 2021 09:17:27 -0700 (PDT)
Received: from [10.57.95.157] (unknown [10.57.95.157])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4AA8A3F66F;
 Thu, 14 Oct 2021 09:17:26 -0700 (PDT)
Subject: Re: [RFC] iommu: Use put_pages_list
To: John Garry <john.garry@huawei.com>, Matthew Wilcox <willy@infradead.org>, 
 Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210930162043.3111119-1-willy@infradead.org>
 <YV85dvlyj5LBdsro@casper.infradead.org>
 <YWgShKtp+89f1a/J@casper.infradead.org>
 <5e147b84-f048-b5ff-09d6-ceffe4c2364a@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <93425cf4-3027-940f-3bee-29c4ee61105f@arm.com>
Date: Thu, 14 Oct 2021 17:17:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <5e147b84-f048-b5ff-09d6-ceffe4c2364a@huawei.com>
Content-Language: en-GB
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

T24gMjAyMS0xMC0xNCAxMjo1MiwgSm9obiBHYXJyeSB3cm90ZToKPiBPbiAxNC8xMC8yMDIxIDEy
OjIwLCBNYXR0aGV3IFdpbGNveCB3cm90ZToKPj4gSSdtIGdvaW5nIHRvIGtlZXAgcGluZ2luZyB0
aGlzIHBhdGNoIHdlZWtseS4KPj4KPj4gT24gVGh1LCBPY3QgMDcsIDIwMjEgYXQgMDc6MTc6MDJQ
TSArMDEwMCwgTWF0dGhldyBXaWxjb3ggd3JvdGU6Cj4+PiBwaW5nPwo+IAo+IFJvYmluLCBXZXJl
IHlvdSBjaGVja2luZyB0aGlzPyBZb3UgbWVudGlvbmVkICJJIGdvdAo+IHNpZGUtdHJhY2tlZCB0
cnlpbmcgdG8gbWFrZSBpby1wZ3RhYmxlIHVzZSB0aGF0IGZyZWVsaXN0IHByb3Blcmx5IiBpbiAK
PiBhbm90aGVyIHRocmVhZCwgd2hpY2ggc2VlbXMgcmVsYXRlZC4KCk9vaCwgdGhhbmtzIGZvciB0
aGUgaGVhZHMtdXAgSm9obiAtIEknbSBzdGlsbCBvbmx5IGp1c3Qgc3RhcnRpbmcgdG8gCmNhdGNo
IHVwIG9uIG15IG1haWxpbmcgbGlzdCBmb2xkZXJzIHNpbmNlIEkgZ290IGJhY2sgb2ZmIGhvbGlk
YXkuCgpJbmRlZWQgSSBhbHJlYWR5IHN0YXJ0ZWQgdW50YW5nbGluZyB0aGUgZnJlZWxpc3QgaGFu
ZGxpbmcgaW4gdGhlIGZsdXNoIApxdWV1ZSBjb2RlICh0byBtYWtlIHRoZSBtb3ZlIGludG8gaW9t
bXUtZG1hIHNtYWxsZXIpLiBPbmNlIEknZCBmaWd1cmVkIApvdXQgaG93IGl0IHdvcmtlZCBJIGRp
ZCB3b25kZXIgd2hldGhlciB0aGVyZSB3YXMgYW55IG1vcmUgInN0YW5kYXJkIiAKZmllbGQgdG8g
Ym9ycm93LCBzaW5jZSBwYWdlLT5mcmVlbGlzdCBkaWQgc2VlbSB2ZXJ5IG11Y2ggaW4gdGhlIApt
aW5vcml0eS4gSWYgcGFnZS0+bHJ1IGlzIGl0IHRoZW4gZ3JlYXQhIEZyb20gYSBxdWljayBza2lt
IG9mIHRoZSBwYXRjaCAKSSB0aGluayBJJ2Qgb25seSBoYXZlIGEgZmV3IHRyaXZpYWwgcmV2aWV3
IGNvbW1lbnRzIHRvIG1ha2UgLSBjZXJ0YWlubHkgCm5vIG9iamVjdGlvbiB0byB0aGUgZnVuZGFt
ZW50YWwgY2hhbmdlIGl0c2VsZiAoaW5kZWVkIEkgaGl0IGEgcG9pbnQgaW4gCmlvLXBndGFibGUt
YXJtIHdoZXJlIGFkZGluZyB0byB0aGUgcG9pbnRlciBjaGFpbiBnb3QgcmF0aGVyIGF3a3dhcmQs
IHNvIApoYXZpbmcgcHJvcGVyIGxpc3RzIHRvIHNwbGljZSB3b3VsZCBiZSBsb3ZlbHkpLgoKTWF0
dGhldyAtIGlzIHRoaXMgc29tZXRoaW5nIGdldHRpbmcgaW4gdGhlIHdheSBvZiBtbSBkZXZlbG9w
bWVudCwgb3IgCmp1c3QgYSBuaWNlIGNsZWFudXA/IEknZCBiZSBoYXBweSBlaXRoZXIgdG8gcHVy
c3VlIG1lcmdpbmcgaXQgb24gaXRzIApvd24sIG9yIHRvIHBpY2sgaXQgdXAgYW5kIHdvcmsgaXQg
aW50byBhIHNlcmllcyB3aXRoIG15IHN0dWZmLgoKQ2hlZXJzLApSb2Jpbi4KCj4gCj4gVGhhbmtz
LAo+IEpvaG4KPiAKPj4+Cj4+PiBPbiBUaHUsIFNlcCAzMCwgMjAyMSBhdCAwNToyMDo0MlBNICsw
MTAwLCBNYXR0aGV3IFdpbGNveCAoT3JhY2xlKSB3cm90ZToKPj4+PiBwYWdlLT5mcmVlbGlzdCBp
cyBmb3IgdGhlIHVzZSBvZiBzbGFiLsKgIFdlIGFscmVhZHkgaGF2ZSB0aGUgYWJpbGl0eQo+Pj4+
IHRvIGZyZWUgYSBsaXN0IG9mIHBhZ2VzIGluIHRoZSBjb3JlIG1tLCBidXQgaXQgcmVxdWlyZXMg
dGhlIHVzZSBvZiBhCj4+Pj4gbGlzdF9oZWFkIGFuZCBmb3IgdGhlIHBhZ2VzIHRvIGJlIGNoYWlu
ZWQgdG9nZXRoZXIgdGhyb3VnaCBwYWdlLT5scnUuCj4+Pj4gU3dpdGNoIHRoZSBpb21tdSBjb2Rl
IG92ZXIgdG8gdXNpbmcgZnJlZV9wYWdlc19saXN0KCkuCj4+Pj4KPj4+PiBTaWduZWQtb2ZmLWJ5
OiBNYXR0aGV3IFdpbGNveCAoT3JhY2xlKSA8d2lsbHlAaW5mcmFkZWFkLm9yZz4KPj4+PiAtLS0K
Pj4+PiDCoCBkcml2ZXJzL2lvbW11L2FtZC9pb19wZ3RhYmxlLmMgfCA5OSAKPj4+PiArKysrKysr
KysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tCj4+Pj4gwqAgZHJpdmVycy9pb21tdS9kbWEtaW9t
bXUuY8KgwqDCoMKgwqAgfCAxMSArLS0tCj4+Pj4gwqAgZHJpdmVycy9pb21tdS9pbnRlbC9pb21t
dS5jwqDCoMKgIHwgODkgKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tCj4+Pj4gwqAgaW5j
bHVkZS9saW51eC9pb21tdS5owqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAzICstCj4+Pj4gwqAgNCBm
aWxlcyBjaGFuZ2VkLCA3NyBpbnNlcnRpb25zKCspLCAxMjUgZGVsZXRpb25zKC0pCj4+Pj4KPiBf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGlvbW11IG1h
aWxpbmcgbGlzdAo+IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCj4gaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXUKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0
CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
