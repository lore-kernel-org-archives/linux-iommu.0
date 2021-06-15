Return-Path: <SRS0=7V87=LJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590B3C48BDF
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 19:21:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00CD46128B
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 19:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00CD46128B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B54BE40650;
	Tue, 15 Jun 2021 19:21:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BKd6y_SH1y9m; Tue, 15 Jun 2021 19:21:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5667240651;
	Tue, 15 Jun 2021 19:21:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2812BC000E;
	Tue, 15 Jun 2021 19:21:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26842C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 19:21:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0043240186
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 19:21:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3UMkOBWNZnuR for <iommu@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 19:21:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0B4E6400F3
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 19:21:03 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20A9CED1;
 Tue, 15 Jun 2021 12:21:03 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21FC73F694;
 Tue, 15 Jun 2021 12:21:02 -0700 (PDT)
Subject: Re: [PATCH v3 5/6] iommu/amd: Tailored gather logic for AMD
To: Nadav Amit <namit@vmware.com>
References: <20210607182541.119756-1-namit@vmware.com>
 <20210607182541.119756-6-namit@vmware.com>
 <1913c012-e6c0-1d5e-01b3-5f6da367c6bd@arm.com>
 <7549686F-1F53-475D-950C-8F44A2165475@vmware.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <4343ee2f-896f-e8cc-0c63-31c7e98467f2@arm.com>
Date: Tue, 15 Jun 2021 20:20:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <7549686F-1F53-475D-950C-8F44A2165475@vmware.com>
Content-Language: en-GB
Cc: Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Jiajun Cao <caojiajun@vmware.com>
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

T24gMjAyMS0wNi0xNSAxOToxNCwgTmFkYXYgQW1pdCB3cm90ZToKPiAKPiAKPj4gT24gSnVuIDE1
LCAyMDIxLCBhdCA1OjU1IEFNLCBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPiB3
cm90ZToKPj4KPj4gT24gMjAyMS0wNi0wNyAxOToyNSwgTmFkYXYgQW1pdCB3cm90ZToKPj4+IEZy
b206IE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+Cj4+PiBBTUQncyBJT01NVSBjYW4gZmx1
c2ggZWZmaWNpZW50bHkgKGkuZS4sIGluIGEgc2luZ2xlIGZsdXNoKSBhbnkgcmFuZ2UuCj4+PiBU
aGlzIGlzIGluIGNvbnRyYXN0LCBmb3IgaW5zdG5hY2UsIHRvIEludGVsIElPTU1VcyB0aGF0IGhh
dmUgYSBsaW1pdCBvbgo+Pj4gdGhlIG51bWJlciBvZiBwYWdlcyB0aGF0IGNhbiBiZSBmbHVzaGVk
IGluIGEgc2luZ2xlIGZsdXNoLiAgSW4gYWRkaXRpb24sCj4+PiBBTUQncyBJT01NVSBkbyBub3Qg
Y2FyZSBhYm91dCB0aGUgcGFnZS1zaXplLCBzbyBjaGFuZ2VzIG9mIHRoZSBwYWdlIHNpemUKPj4+
IGRvIG5vdCBuZWVkIHRvIHRyaWdnZXIgYSBUTEIgZmx1c2guCj4+PiBTbyBpbiBtb3N0IGNhc2Vz
LCBhIFRMQiBmbHVzaCBkdWUgdG8gZGlzam9pbnQgcmFuZ2Ugb3IgcGFnZS1zaXplIGNoYW5nZXMK
Pj4+IGFyZSBub3QgbmVlZGVkIGZvciBBTUQuIFlldCwgdklPTU1VcyByZXF1aXJlIHRoZSBoeXBl
cnZpc29yIHRvCj4+PiBzeW5jaHJvbml6ZSB0aGUgdmlydHVhbGl6ZWQgSU9NTVUncyBQVEVzIHdp
dGggdGhlIHBoeXNpY2FsIG9uZXMuIFRoaXMKPj4+IHByb2Nlc3MgaW5kdWNlIG92ZXJoZWFkcywg
c28gaXQgaXMgYmV0dGVyIG5vdCB0byBjYXVzZSB1bm5lY2Vzc2FyeQo+Pj4gZmx1c2hlcywgaS5l
LiwgZmx1c2hlcyBvZiBQVEVzIHRoYXQgd2VyZSBub3QgbW9kaWZpZWQuCj4+PiBJbXBsZW1lbnQg
YW5kIHVzZSBhbWRfaW9tbXVfaW90bGJfZ2F0aGVyX2FkZF9wYWdlKCkgYW5kIHVzZSBpdCBpbnN0
ZWFkCj4+PiBvZiB0aGUgZ2VuZXJpYyBpb21tdV9pb3RsYl9nYXRoZXJfYWRkX3BhZ2UoKS4gSWdu
b3JlIHBhZ2Utc2l6ZSBjaGFuZ2VzCj4+PiBhbmQgZGlzam9pbnQgcmVnaW9ucyB1bmxlc3MgIm5v
bi1wcmVzZW50IGNhY2hlIiBmZWF0dXJlIGlzIHJlcG9ydGVkIGJ5Cj4+PiB0aGUgSU9NTVUgY2Fw
YWJpbGl0aWVzLCBhcyB0aGlzIGlzIGFuIGluZGljYXRpb24gd2UgYXJlIHJ1bm5pbmcgb24gYQo+
Pj4gcGh5c2ljYWwgSU9NTVUuIEEgc2ltaWxhciBpbmRpY2F0aW9uIGlzIHVzZWQgYnkgVlQtZCAo
c2VlICJjYWNoaW5nCj4+PiBtb2RlIikuIFRoZSBuZXcgbG9naWMgcmV0YWlucyB0aGUgc2FtZSBm
bHVzaGluZyBiZWhhdmlvciB0aGF0IHdlIGhhZAo+Pj4gYmVmb3JlIHRoZSBpbnRyb2R1Y3Rpb24g
b2YgcGFnZS1zZWxlY3RpdmUgSU9UTEIgZmx1c2hlcyBmb3IgQU1ELgo+Pj4gT24gdmlydHVhbGl6
ZWQgZW52aXJvbm1lbnRzLCBjaGVjayBpZiB0aGUgbmV3bHkgZmx1c2hlZCByZWdpb24gYW5kIHRo
ZQo+Pj4gZ2F0aGVyZWQgb25lIGFyZSBkaXNqb2ludCBhbmQgZmx1c2ggaWYgaXQgaXMuIEFsc28g
Y2hlY2sgd2hldGhlciB0aGUgbmV3Cj4+PiByZWdpb24gd291bGQgY2F1c2UgSU9UTEIgaW52YWxp
ZGF0aW9uIG9mIGxhcmdlIHJlZ2lvbiB0aGF0IHdvdWxkIGluY2x1ZGUKPj4+IHVubW9kaWZpZWQg
UFRFLiBUaGUgbGF0dGVyIGNoZWNrIGlzIGRvbmUgYWNjb3JkaW5nIHRvIHRoZSAib3JkZXIiIG9m
IHRoZQo+Pj4gSU9UTEIgZmx1c2guCj4+Cj4+IElmIGl0IGhlbHBzLAo+Pgo+PiBSZXZpZXdlZC1i
eTogUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4KPiAKPiBUaGFua3MhCj4gCj4g
Cj4+IEkgd29uZGVyIGlmIGl0IG1pZ2h0IGJlIG1vcmUgZWZmZWN0aXZlIHRvIGRlZmVyIHRoZSBh
bGlnbm1lbnQtYmFzZWQgc3BsaXR0aW5nIHBhcnQgdG8gYW1kX2lvbW11X2lvdGxiX3N5bmMoKSBp
dHNlbGYsIGJ1dCB0aGF0IGNvdWxkIGJlIGludmVzdGlnYXRlZCBhcyBhbm90aGVyIGZvbGxvdy11
cC4KPiAKPiBOb3RlIHRoYXQgdGhlIGFsaWdubWVudC1iYXNlZCBzcGxpdHRpbmcgaXMgb25seSB1
c2VkIGZvciB2aXJ0dWFsaXplZCBBTUQgSU9NTVVzLCBzbyBpdCBoYXMgbm8gaW1wYWN0IGZvciBt
b3N0IHVzZXJzLgo+IAo+IFJpZ2h0IG5vdywgdGhlIHBlcmZvcm1hbmNlIGlzIGtpbmQgb2YgYmFk
IG9uIFZNcyBzaW5jZSBBTUTigJlzIElPTU1VIGRyaXZlciBkb2VzIGEgZnVsbCBJT1RMQiBmbHVz
aCB3aGVuZXZlciBpdCB1bm1hcHMgbW9yZSB0aGFuIGEgc2luZ2xlIHBhZ2UuIFNvLCBhbHRob3Vn
aCB5b3VyIGlkZWEgbWFrZXMgc2Vuc2UsIEkgZG8gbm90IGtub3cgZXhhY3RseSBob3cgdG8gaW1w
bGVtZW50IGl0IHJpZ2h0IG5vdywgYW5kIHJlZ2FyZGxlc3MgaXQgaXMgbGlrZWx5IHRvIHByb3Zp
ZGUgbXVjaCBsb3dlciBwZXJmb3JtYW5jZSBpbXByb3ZlbWVudHMgdGhhbiB0aG9zZSB0aGF0IGF2
b2lkaW5nIGZ1bGwgSU9UTEIgZmx1c2hlcyB3b3VsZC4KPiAKPiBIYXZpbmcgc2FpZCB0aGF0LCBp
ZiBJIGZpZ3VyZSBvdXQgYSB3YXkgdG8gaW1wbGVtZW50IGl0LCBJIHdvdWxkIGdpdmUgaXQgYSB0
cnkgKGFsdGhvdWdoIEkgYW0gYWRtaXR0ZWRseSBhZnJhaWQgb2YgYSBjb21wbGljYXRlZCBsb2dp
YyB0aGF0IG1pZ2h0IGNhdXNlIHN1YnRsZSwgbW9zdGx5IHVuZGV0ZWN0YWJsZSBidWdzKS4KCkkg
d2FzIG1haW5seSB0aGlua2luZyB0aGF0IHdoZW4geW91IG9ic2VydmUgYSBjaGFuZ2UgaW4gIm9y
ZGVyIiBhbmQgc3luYyAKdG8gYXZvaWQgb3Zlci1pbnZhbGlkYXRpbmcgYWRqYWNlbnQgcGFnZXMs
IHRob3NlIHBhZ2VzIG1heSBzdGlsbCBiZSBwYXJ0IApvZiB0aGUgY3VycmVudCB1bm1hcCBhbmQg
eW91J3ZlIGp1c3Qgbm90IHNlZW4gdGhlbSBhZGRlZCB5ZXQuIEhlbmNlIApzaW1wbHkgZ2F0aGVy
aW5nIGNvbnRpZ3VvdXMgcGFnZXMgcmVnYXJkbGVzcyBvZiBhbGlnbm1lbnQsIHRoZW4gYnJlYWtp
bmcgCnRoZSB0b3RhbCByYW5nZSBkb3duIGludG8gYXBwcm9wcmlhdGVseS1hbGlnbmVkIGNvbW1h
bmRzIGluIHRoZSBzeW5jIApvbmNlIHlvdSBrbm93IHlvdSd2ZSBzZWVuIGV2ZXJ5dGhpbmcsIHNl
ZW1zIGxpa2UgaXQgbWlnaHQgYWxsb3cgaXNzdWluZyAKZmV3ZXIgY29tbWFuZHMgb3ZlcmFsbC4g
QnV0IEkgaGF2ZW4ndCBxdWl0ZSBncmFzcGVkIHRoZSBhbGlnbm1lbnQgcnVsZXMgCmVpdGhlciwg
c28gcG9zc2libHkgdGhpcyBpcyBtb290IGFueXdheS4KClJvYmluLgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
