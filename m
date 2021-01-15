Return-Path: <SRS0=aa3U=GS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26012C433E0
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 17:17:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A343238EF
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 17:17:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A343238EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 0DBA020475;
	Fri, 15 Jan 2021 17:17:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dnp8QzlJ-vaU; Fri, 15 Jan 2021 17:17:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9B9DE20399;
	Fri, 15 Jan 2021 17:17:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B018C088B;
	Fri, 15 Jan 2021 17:17:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7237C013A
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 17:17:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D969186BC7
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 17:17:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JqG4UYXTIn9V for <iommu@lists.linux-foundation.org>;
 Fri, 15 Jan 2021 17:17:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 875C486B6E
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 17:17:35 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E1D1D6E;
 Fri, 15 Jan 2021 09:17:34 -0800 (PST)
Received: from [10.57.56.43] (unknown [10.57.56.43])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BE0E3F719;
 Fri, 15 Jan 2021 09:17:33 -0800 (PST)
Subject: Re: Consult on ARM SMMU debugfs
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
References: <cd9296f1-a3ea-d8d6-0e14-2cd6f19a17da@hisilicon.com>
 <9a23610f-e0b4-92e6-6da6-3182d481db92@arm.com>
 <20210115151403.GZ1551@shell.armlinux.org.uk>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <04eec942-39b9-6bdd-5399-ab23e42c232f@arm.com>
Date: Fri, 15 Jan 2021 17:17:32 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210115151403.GZ1551@shell.armlinux.org.uk>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, will@kernel.org,
 linux-arm-kernel@lists.infradead.org
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

T24gMjAyMS0wMS0xNSAxNToxNCwgUnVzc2VsbCBLaW5nIC0gQVJNIExpbnV4IGFkbWluIHdyb3Rl
Ogo+IE9uIE1vbiwgSmFuIDExLCAyMDIxIGF0IDA4OjAxOjQ4UE0gKzAwMDAsIFJvYmluIE11cnBo
eSB3cm90ZToKPj4gT24gMjAyMS0wMS0wNyAwMjo0NSwgY2hlbnhpYW5nIChNKSB3cm90ZToKPj4+
IEhpIFdpbGwsw6/Cv8K9IFJvYmluIG9yIG90aGVyIGd1eXMsCj4+Pgo+Pj4gV2hlbiBkZWJ1Z2dp
bmcgU01NVS9TVkEgaXNzdWUgb24gaHVhd2VpIEFSTTY0IGJvYXJkLCB3ZSBmaW5kIHRoYXQgaXQK
Pj4+IGxhY2tzIG9mIGVub3VnaCBkZWJ1Z2ZzIGZvciBBUk0gU01NVSBkcml2ZXIgKHN1Y2ggYXMK
Pj4+Cj4+PiB0aGUgdmFsdWUgb2YgU1RFL0NEIHdoaWNoIHdlIG5lZWQgdG8gY2hlY2sgc29tZXRp
bWVzKS4gQ3VycmVudGx5IGl0Cj4+PiBjcmVhdGVzIHRvcC1sZXZlbCBpb21tdSBkaXJlY3Rvcnkg
aW4gZGVidWdmcywgYnV0IHRoZXJlIGlzIG5vIGRlYnVnZnMKPj4+Cj4+PiBmb3IgQVJNIFNNTVUg
ZHJpdmVyIHNwZWNpYWxseS4gRG8geW91IGtub3cgd2hldGhlciBBUk0gaGF2ZSB0aGUgcGxhbiB0
bwo+Pj4gZG8gdGhhdCByZWNlbnRseT8KPj4KPj4gRldJVyBJIGRvbid0IHRoaW5rIEkndmUgZXZl
ciBmZWx0IHRoZSBuZWVkIHRvIG5lZWQgdG8gaW5zcGVjdCB0aGUgU3RyZWFtCj4+IFRhYmxlIG9u
IGEgbGl2ZSBzeXN0ZW0uIFNvIGZhciB0aGUgbmF0dXJlIG9mIHRoZSBTVEUgY29kZSBoYXMgYmVl
biBzaW1wbGUKPj4gZW5vdWdoIHRoYXQgaXQncyB2ZXJ5IGhhcmQgZm9yIGFueSBnaXZlbiBTVEUg
dG8gYmUgKndyb25nKiAtIGVpdGhlciBpdCdzIHNldAo+PiB1cCBhcyBleHBlY3RlZCBhbmQgdGh1
cyB3b3JrcyBmaW5lLCBvciBpdCdzIG5vdCBpbml0aWFsaXNlZCBhdCBhbGwgYW5kIHlvdQo+PiBn
ZXQgQ19CQURfU1RFLCB3aGVyZSA5OSUgb2YgdGhlIHRpbWUgeW91IHRoZW4ganVzdCBjcm9zcy1y
ZWZlcmVuY2UgdGhlCj4+IFN0cmVhbSBJRCBhZ2FpbnN0IHRoZSBmaXJtd2FyZSBhbmQgZmluZCB0
aGF0IHRoZSBEVC9JT1JUIGlzIHdyb25nLgo+Pgo+PiBTaW1pbGFybHkgSSBkb24ndCB0aGluayBJ
J3ZlIGV2ZW4gZXZlbiAqc2VlbiogYW4gaXNzdWUgdGhhdCBjb3VsZCBiZQo+PiBhdHRyaWJ1dGVk
IHRvIGEgY29udGV4dCBkZXNjcmlwdG9yLCBhbHRob3VnaCBJIGFwcHJlY2lhdGUgdGhhdCBhcyB3
ZSBzdGFydAo+PiBsYW5kaW5nIG1vcmUgUEFTSUQgYW5kIFNWQSBzdXBwb3J0IHRoZSBzY29wZSBm
b3IgdGhhdCBzdGFydHMgdG8gd2lkZW4KPj4gY29uc2lkZXJhYmx5Lgo+Pgo+PiBGZWVsIGZyZWUg
dG8gcHJvcG9zZSBhIHBhdGNoIGlmIHlvdSBiZWxpZXZlIGl0IHdvdWxkIGJlIGdlbnVpbmVseSB1
c2VmdWwgYW5kCj4+IHdvbid0IGp1c3QgYml0LXJvdCBpbnRvIGEgbWFpbnRlbmFuY2UgYnVyZGVu
LCBidXQgaXQncyBub3Qgc29tZXRoaW5nIHRoYXQncwo+PiBvbiBvdXIgcm9hZG1hcCBoZXJlLgo+
IAo+IEkgZG8gdGhpbmsgdGhhdCB0aGUgSU9NTVUgc3R1ZmYgbmVlZHMgYmV0dGVyIGRlYnVnZ2lu
Zy4gSSd2ZSBoaXQgdGhlCj4gV0FSTl9PTigpIGluIF9fYXJtX2xwYWVfbWFwKCksIGFuZCBpdCdz
IGJlZW4gcHJldHR5IG11Y2ggdW5kZWJ1Z2dhYmxlLAo+IHNvIEkndmUgcmVzb3J0ZWQgdG8gcHV0
dGluZyB0aGUgSU9NTVUgaW50byBieXBhc3MgbW9kZSBwZXJtYW5lbnRseSB0bwo+IHdvcmsgYXJv
dW5kIHRoZSBpc3N1ZS4KPiAKPiBUaGUgcmVhc29uIHRoYXQgaXQncyB1bmRlYnVnZ2FibGUgaXMg
aWYgb25lIHB1dHMgcHJpbnRrKCkgb3IgdHJhY2UKPiBzdGF0ZW1lbnRzIGluIHRoZSBjb2RlLCBi
b290cyB0aGUgcGxhdGZvcm0sIHlvdSBnZXQgZmxvb2RlZCB3aXRoIHRob3NlCj4gZGVidWdnaW5n
IG1lc3NhZ2VzLCBiZWNhdXNlIGV2ZXJ5IGFjY2VzcyB0byB0aGUgcm9vdGZzIGdlbmVyYXRlcyBh
bmQKPiB0ZWFycyBkb3duIGEgbWFwcGluZy4KPiAKPiBJdCB3b3VsZCBiZSBuaWNlIHRvIGJlIGFi
bGUgdG8gaW5zcGVjdCB0aGUgSU9NTVUgcGFnZSB0YWJsZXMgYW5kIHN0YXRlCj4gb2YgdGhlIElP
TU1VLCByYXRoZXIgdGhhbiBoYXZpbmcgdG8gcmVzb3J0IHRvIGVmZmVjdGl2ZWx5IGRpc2FibGlu
Zwo+IHRoZSBJT01NVS4KCkNlcnRhaW5seSBvbmNlIHdlIGdldCB0byBzdHVmZiBsaWtlIHVucGlu
bmVkIFZGSU8sIGhhdmluZyB0aGUgYWJpbGl0eSB0byAKaW5zcGVjdCBwYWdldGFibGVzIGZvciBh
cmJpdHJhcnkgSU9NTVUgQVBJIHVzYWdlIHdpbGwgaW5kZWVkIGJlIHVzZWZ1bC4gCiBGcm9tIHRo
ZSBETUEgbWFwcGluZyBwZXJzcGVjdGl2ZSwgdGhvdWdoLCB1bmxlc3MgeW91J3JlIHdvcmtpbmcg
b24gdGhlIAppby1wZ3RhYmxlIGNvZGUgaXRzZWxmIGl0J3Mgbm90IHJlYWxseSBnb2luZyB0byB0
ZWxsIHlvdSBtdWNoIHRoYXQgCmR1bXBpbmcgdGhlIG1hcHBpbmdzIGZyb20gZG1hLWRlYnVnIGNh
bid0IGFscmVhZHkuCgpGV0lXIHdoZW5ldmVyIEkgZW5jb3VudGVyIHRoYXQgcGFydGljdWxhciB3
YXJuaW5nIGluIGlvbW11LWRtYSBjb250ZXh0LCAKSSBkb24ndCBjYXJlIHdoZXJlIHRoZSBleGlz
dGluZyBtYXBwaW5nIGlzIHBvaW50aW5nLCBzaW5jZSBpdCdzIG1lcmVseSBhIApzeW1wdG9tIG9m
IHRoZSBkYW1hZ2UgYWxyZWFkeSBoYXZpbmcgYmVlbiBkb25lLiBBdCB0aGF0IHBvaW50IEknZCAK
dXN1YWxseSBnbyBvZmYgYW5kIGF1ZGl0IGFsbCB0aGUgRE1BIEFQSSBjYWxscyBpbiB0aGUgb2Zm
ZW5kaW5nIGRyaXZlciwgCnNpbmNlIGl0J3MgdHlwaWNhbGx5IGNhdXNlZCBieSBjb3JydXB0aW9u
IGluIHRoZSBJT1ZBIGFsbG9jYXRvciBmcm9tIApwYXNzaW5nIHRoZSB3cm9uZyBzaXplIGluIGEg
ZG1hX3VubWFwXyooKSBjYWxsLCBhbmQgdGhvc2UgY2FuIG9mdGVuIGJlIApzcG90dGVkIGJ5IGlu
c3BlY3Rpb24uIEZvciBhY3RpdmUgZGVidWdnaW5nLCB3aGF0IHlvdSByZWFsbHkgd2FudCB0byAK
a25vdyBpcyB0aGUgKmhpc3RvcnkqIG9mIG9wZXJhdGlvbnMgYXJvdW5kIHRoYXQgSU9WQSwgc2lu
Y2UgeW91J3JlIApwcmltYXJpbHkgaW50ZXJlc3RlZCBpbiB0aGUgcmVxdWVzdCB0aGF0IGxhc3Qg
bWFwcGVkIGl0LCB0aGVuIHRoZSAKY29ycmVzcG9uZGluZyB1bm1hcCByZXF1ZXN0IGZvciBub21p
bmFsbHkgdGhlIHNhbWUgYnVmZmVyICh3aGljaCBhbGxvd2VkIAp0aGUgSU9WQSByZWdpb24gdG8g
YmUgZnJlZWQgZm9yIHJldXNlKSB0aGF0IGZvciBzb21lIHJlYXNvbiBkaWRuJ3QgY292ZXIgCm9u
ZSBvciBtb3JlIHBhZ2VzIHRoYXQgaXQgc2hvdWxkIGhhdmUuIFRoZSBJT01NVSBBUEkgdHJhY2Vw
b2ludHMgY2FuIGJlIAphIGhhbmR5IHRvb2wgdGhlcmUuCgpSb2Jpbi4KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
