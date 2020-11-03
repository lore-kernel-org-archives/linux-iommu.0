Return-Path: <SRS0=TrXs=EJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CADC55178
	for <iommu@archiver.kernel.org>; Tue,  3 Nov 2020 16:00:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53F8722264
	for <iommu@archiver.kernel.org>; Tue,  3 Nov 2020 16:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F8722264
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E2579873AA;
	Tue,  3 Nov 2020 16:00:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sn4craaU1tIY; Tue,  3 Nov 2020 16:00:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 46D87873E6;
	Tue,  3 Nov 2020 16:00:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C14FC088B;
	Tue,  3 Nov 2020 16:00:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A586C0051
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 15:59:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 57DA086207
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 15:59:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hMu5unAzUzgL for <iommu@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 15:59:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4A35D861F1
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 15:59:57 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4E6B139F;
 Tue,  3 Nov 2020 07:59:56 -0800 (PST)
Received: from [10.57.54.223] (unknown [10.57.54.223])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A57E23F66E;
 Tue,  3 Nov 2020 07:59:55 -0800 (PST)
Subject: Re: [PATCH v5 2/2] iommu/iova: Free global iova rcache on iova alloc
 failure
To: John Garry <john.garry@huawei.com>, vjitta@codeaurora.org,
 joro@8bytes.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
References: <1601451864-5956-1-git-send-email-vjitta@codeaurora.org>
 <1601451864-5956-2-git-send-email-vjitta@codeaurora.org>
 <ff318311-77e8-b235-37dd-7b1b5f5d8ed9@arm.com>
 <e1e5b24a-512b-7279-8341-7f4495718ece@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <5293135b-3a28-4edc-0515-61e595600bba@arm.com>
Date: Tue, 3 Nov 2020 15:59:54 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <e1e5b24a-512b-7279-8341-7f4495718ece@huawei.com>
Content-Language: en-GB
Cc: vinmenon@codeaurora.org, kernel-team@android.com
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

T24gMjAyMC0xMS0wMyAxNDozMSwgSm9obiBHYXJyeSB3cm90ZToKPiBPbiAwMy8xMS8yMDIwIDEy
OjM1LCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+IE9uIDIwMjAtMDktMzAgMDg6NDQsIHZqaXR0YUBj
b2RlYXVyb3JhLm9yZyB3cm90ZToKPj4+IEZyb206IFZpamF5YW5hbmQgSml0dGEgPHZqaXR0YUBj
b2RlYXVyb3JhLm9yZz4KPj4+Cj4+PiBXaGVuIGV2ZXIgYW4gaW92YSBhbGxvYyByZXF1ZXN0IGZh
aWxzIHdlIGZyZWUgdGhlIGlvdmEKPj4+IHJhbmdlcyBwcmVzZW50IGluIHRoZSBwZXJjcHUgaW92
YSByY2FjaGVzIGFuZCB0aGVuIHJldHJ5Cj4+PiBidXQgdGhlIGdsb2JhbCBpb3ZhIHJjYWNoZSBp
cyBub3QgZnJlZWQgYXMgYSByZXN1bHQgd2UgY291bGQKPj4+IHN0aWxsIHNlZSBpb3ZhIGFsbG9j
IGZhaWx1cmUgZXZlbiBhZnRlciByZXRyeSBhcyBnbG9iYWwKPj4+IHJjYWNoZSBpcyBob2xkaW5n
IHRoZSBpb3ZhJ3Mgd2hpY2ggY2FuIGNhdXNlIGZyYWdtZW50YXRpb24uCj4+PiBTbywgZnJlZSB0
aGUgZ2xvYmFsIGlvdmEgcmNhY2hlIGFzIHdlbGwgYW5kIHRoZW4gZ28gZm9yIHRoZQo+Pj4gcmV0
cnkuCj4+Cj4gCj4gSWYgd2UgZG8gY2xlYXIgYWxsIHRoZSBDUFUgcmNhY2hlcywgaXQgd291bGQg
bmljZSB0byBoYXZlIHNvbWV0aGluZyAKPiBpbW1lZGlhdGVseSBhdmFpbGFibGUgdG8gcmVwbGVu
aXNoLCBpLmUuIHVzZSB0aGUgZ2xvYmFsIHJjYWNoZSwgaW5zdGVhZCAKPiBvZiBmbHVzaGluZyBp
dCwgaWYgdGhhdCBpcyBub3QgcmVxdWlyZWQuLi4KCklmIHdlJ3ZlIHJlYWNoZWQgdGhlIHBvaW50
IG9mIGNsZWFyaW5nICphbnkqIGNhY2hlcywgdGhvdWdoLCBJIHRoaW5rIGFueSAKaG9wZSBvZiBt
YWludGFpbmluZyBwZXJmb3JtYW5jZSBpcyBhbHJlYWR5IGxvbmcgZ29uZS4gV2UndmUgd2Fsa2Vk
IHRoZSAKcmJ0cmVlIGZvciB0aGUgZW50aXJlIGFkZHJlc3Mgc3BhY2UgYW5kIGZvdW5kIHRoYXQg
aXQncyBzdGlsbCB0b28gZnVsbCAKdG8gYWxsb2NhdGUgZnJvbTsgd2UncmUgdGVldGVyaW5nIG9u
IHRoZSBicmluayBvZiBoYXJkIGZhaWx1cmUgYW5kIHRoaXMgCmlzIGEgbGFzdC1kaXRjaCBhdHRl
bXB0IHRvIGNsYXcgYmFjayBhcyBtdWNoIGFzIHBvc3NpYmxlIGluIHRoZSBob3BlIAp0aGF0IGl0
IGdpdmVzIHVzIGEgdXNhYmxlIHNwYWNlLgoKVEJIIEknbSBub3QgZW50aXJlbHkgc3VyZSB3aGF0
IGFsbG9jYXRpb24gcGF0dGVybiB3YXMgZXhwZWN0ZWQgYnkgdGhlIApvcmlnaW5hbCBjb2RlIHN1
Y2ggdGhhdCBwdXJnaW5nIG9ubHkgc29tZSBvZiB0aGUgY2FjaGVzIG1hZGUgc2Vuc2UsIG5vciAK
d2hhdCBraW5kIG9mIHBhdHRlcm4gbGVhZHMgdG8gbG90cyBvZiBzbWFsbGVyIElPVkFzIGJlaW5n
IGFsbG9jYXRlZCwgCmZyZWVkLCBhbmQgbmV2ZXIgcmV1c2VkIHRvIHRoZSBwb2ludCBvZiBibG9j
a2luZyBsYXJnZXIgYWxsb2NhdGlvbnMsIGJ1dCAKZWl0aGVyIHdheSB0aGUgcmVhc29uaW5nIGRv
ZXMgYXQgbGVhc3Qgc2VlbSB0byBob2xkIHVwIGluIGFic3RyYWN0LgoKPj4gVGhpcyBsb29rcyBy
ZWFzb25hYmxlIHRvIG1lIC0gaXQncyBtaWxkbHkgYW5ub3lpbmcgdGhhdCB3ZSBlbmQgdXAgd2l0
aCAKPj4gc28gbWFueSBzaW1pbGFyLWxvb2tpbmcgZnVuY3Rpb25zLAo+IAo+IFdlbGwgSSBkaWQg
YWRkIGEgZnVuY3Rpb24gdG8gY2xlYXIgYWxsIENQVSByY2FjaGVzIGhlcmUsIGlmIHlvdSB3b3Vs
ZCAKPiBsaWtlIHRvIGNoZWNrOgo+IAo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWlv
bW11LzE2MDM3MzM1MDEtMjExMDA0LTItZ2l0LXNlbmQtZW1haWwtam9obi5nYXJyeUBodWF3ZWku
Y29tLyAKCkkgd2FzIHRoaW5raW5nIG1vcmUgb2YgdGhlIHdheSBmcmVlX2lvdmFfcmNhY2hlcygp
LCAKZnJlZV9jcHVfY2FjaGVkX2lvdmFzKCksIGFuZCBmcmVlX2dsb2JhbF9jYWNoZWRfaW92YXMo
KSBhbGwgbG9vayBwcmV0dHkgCm11Y2ggdGhlIHNhbWUgc2hhcGUgYXQgYSBnbGFuY2UuCgo+PiBi
dXQgdGhlIG5lY2Vzc2FyeSBkaWZmZXJlbmNlcyBhcmUgcmlnaHQgZG93biBpbiB0aGUgbWlkZGxl
IG9mIHRoZSAKPj4gbG9vcHMgc28gbm90aGluZyBjYW4gcmVhc29uYWJseSBiZSBmYWN0b3JlZCBv
dXQgOigKPj4KPj4gUmV2aWV3ZWQtYnk6IFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5QGFybS5j
b20+Cj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBWaWpheWFuYW5kIEppdHRhIDx2aml0dGFAY29kZWF1
cm9yYS5vcmc+Cj4+PiAtLS0KPj4+IMKgIGRyaXZlcnMvaW9tbXUvaW92YS5jIHwgMjMgKysrKysr
KysrKysrKysrKysrKysrKysKPj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCsp
Cj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW92YS5jIGIvZHJpdmVycy9pb21t
dS9pb3ZhLmMKPj4+IGluZGV4IGMzYTFhOGUuLmZhZjliMTMgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2
ZXJzL2lvbW11L2lvdmEuYwo+Pj4gKysrIGIvZHJpdmVycy9pb21tdS9pb3ZhLmMKPj4+IEBAIC0y
NSw2ICsyNSw3IEBAIHN0YXRpYyB2b2lkIGluaXRfaW92YV9yY2FjaGVzKHN0cnVjdCBpb3ZhX2Rv
bWFpbiAKPj4+ICppb3ZhZCk7Cj4+PiDCoCBzdGF0aWMgdm9pZCBmcmVlX2lvdmFfcmNhY2hlcyhz
dHJ1Y3QgaW92YV9kb21haW4gKmlvdmFkKTsKPj4+IMKgIHN0YXRpYyB2b2lkIGZxX2Rlc3Ryb3lf
YWxsX2VudHJpZXMoc3RydWN0IGlvdmFfZG9tYWluICppb3ZhZCk7Cj4+PiDCoCBzdGF0aWMgdm9p
ZCBmcV9mbHVzaF90aW1lb3V0KHN0cnVjdCB0aW1lcl9saXN0ICp0KTsKPj4+ICtzdGF0aWMgdm9p
ZCBmcmVlX2dsb2JhbF9jYWNoZWRfaW92YXMoc3RydWN0IGlvdmFfZG9tYWluICppb3ZhZCk7Cj4g
Cj4gYSB0aG91Z2h0OiBJdCB3b3VsZCBiZSBncmVhdCBpZiB0aGUgZmlsZSBjb3VsZCBiZSByZWFy
cmFuZ2VkIGF0IHNvbWUgCj4gcG9pbnQgd2hlcmUgd2UgZG9uJ3QgcmVxdWlyZSBzbyBtYW55IGZv
cndhcmQgZGVjbGFyYXRpb25zLgo+IAo+Pj4gwqAgdm9pZAo+Pj4gwqAgaW5pdF9pb3ZhX2RvbWFp
bihzdHJ1Y3QgaW92YV9kb21haW4gKmlvdmFkLCB1bnNpZ25lZCBsb25nIGdyYW51bGUsCj4+PiBA
QCAtNDQyLDYgKzQ0Myw3IEBAIGFsbG9jX2lvdmFfZmFzdChzdHJ1Y3QgaW92YV9kb21haW4gKmlv
dmFkLCAKPj4+IHVuc2lnbmVkIGxvbmcgc2l6ZSwKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBmbHVz
aF9yY2FjaGUgPSBmYWxzZTsKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBmb3JfZWFjaF9vbmxpbmVf
Y3B1KGNwdSkKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZyZWVfY3B1X2NhY2hlZF9p
b3ZhcyhjcHUsIGlvdmFkKTsKPj4+ICvCoMKgwqDCoMKgwqDCoCBmcmVlX2dsb2JhbF9jYWNoZWRf
aW92YXMoaW92YWQpOwo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gcmV0cnk7Cj4+PiDCoMKg
wqDCoMKgIH0KPj4+IEBAIC0xMDU3LDUgKzEwNTksMjYgQEAgdm9pZCBmcmVlX2NwdV9jYWNoZWRf
aW92YXModW5zaWduZWQgaW50IGNwdSwgCj4+PiBzdHJ1Y3QgaW92YV9kb21haW4gKmlvdmFkKQo+
Pj4gwqDCoMKgwqDCoCB9Cj4+PiDCoCB9Cj4+PiArLyoKPj4+ICsgKiBmcmVlIGFsbCB0aGUgSU9W
QSByYW5nZXMgb2YgZ2xvYmFsIGNhY2hlCj4+PiArICovCj4+PiArc3RhdGljIHZvaWQgZnJlZV9n
bG9iYWxfY2FjaGVkX2lvdmFzKHN0cnVjdCBpb3ZhX2RvbWFpbiAqaW92YWQpCj4+PiArewo+Pj4g
K8KgwqDCoCBzdHJ1Y3QgaW92YV9yY2FjaGUgKnJjYWNoZTsKPj4+ICvCoMKgwqAgdW5zaWduZWQg
bG9uZyBmbGFnczsKPj4+ICvCoMKgwqAgaW50IGksIGo7Cj4+PiArCj4+PiArwqDCoMKgIGZvciAo
aSA9IDA7IGkgPCBJT1ZBX1JBTkdFX0NBQ0hFX01BWF9TSVpFOyArK2kpIHsKPj4+ICvCoMKgwqDC
oMKgwqDCoCByY2FjaGUgPSAmaW92YWQtPnJjYWNoZXNbaV07Cj4+PiArwqDCoMKgwqDCoMKgwqAg
c3Bpbl9sb2NrX2lycXNhdmUoJnJjYWNoZS0+bG9jaywgZmxhZ3MpOwo+Pj4gK8KgwqDCoMKgwqDC
oMKgIGZvciAoaiA9IDA7IGogPCByY2FjaGUtPmRlcG90X3NpemU7ICsraikgewo+Pj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgaW92YV9tYWdhemluZV9mcmVlX3BmbnMocmNhY2hlLT5kZXBvdFtq
XSwgaW92YWQpOwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW92YV9tYWdhemluZV9mcmVl
KHJjYWNoZS0+ZGVwb3Rbal0pOwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmNhY2hlLT5k
ZXBvdFtqXSA9IE5VTEw7Cj4gCj4gSSBkb24ndCB0aGluayB0aGF0IE5VTExpZnkgaXMgc3RyaWN0
bHkgbmVjZXNzYXJ5CgpUcnVlLCB3ZSBkb24ndCBleHBsaWNpdGx5IGNsZWFyIGRlcG90IGVudHJp
ZXMgaW4gX19pb3ZhX3JjYWNoZV9nZXQoKSBmb3IgCm5vcm1hbCBvcGVyYXRpb24sIHNvIHRoZXJl
J3Mgbm90IG11Y2ggcG9pbnQgaW4gZG9pbmcgc28gaGVyZS4KClJvYmluLgoKPj4+ICvCoMKgwqDC
oMKgwqDCoCB9Cj4+PiArwqDCoMKgwqDCoMKgwqAgcmNhY2hlLT5kZXBvdF9zaXplID0gMDsKPj4+
ICvCoMKgwqDCoMKgwqDCoCBzcGluX3VubG9ja19pcnFyZXN0b3JlKCZyY2FjaGUtPmxvY2ssIGZs
YWdzKTsKPj4+ICvCoMKgwqAgfQo+Pj4gK30KPj4+IMKgIE1PRFVMRV9BVVRIT1IoIkFuaWwgUyBL
ZXNoYXZhbXVydGh5IAo+Pj4gPGFuaWwucy5rZXNoYXZhbXVydGh5QGludGVsLmNvbT4iKTsKPj4+
IMKgIE1PRFVMRV9MSUNFTlNFKCJHUEwiKTsKPj4+Cj4+IF9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCj4+IGlvbW11IG1haWxpbmcgbGlzdAo+PiBpb21tdUBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwo+PiBodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQo+PiAuCj4gCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby9pb21tdQ==
