Return-Path: <SRS0=900o=ON=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321BEC433EF
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 13:54:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBFC160FA0
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 13:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BBFC160FA0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 86C74606F7;
	Thu, 23 Sep 2021 13:54:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fbN5VNqFz2LJ; Thu, 23 Sep 2021 13:54:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6A084606DF;
	Thu, 23 Sep 2021 13:54:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C4F1C0011;
	Thu, 23 Sep 2021 13:54:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FC31C000D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 13:54:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1B965606F7
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 13:54:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LMo8FzAe55wQ for <iommu@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 13:54:53 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 084CD606DF
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 13:54:52 +0000 (UTC)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4HFc9P5sHPz9sV7;
 Thu, 23 Sep 2021 15:54:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xdm1Ouzf8XXu; Thu, 23 Sep 2021 15:54:49 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4HFc9P4lm1z9sV4;
 Thu, 23 Sep 2021 15:54:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8BA938B776;
 Thu, 23 Sep 2021 15:54:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id i24VgXHaAF2s; Thu, 23 Sep 2021 15:54:49 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.200])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id ACF658B763;
 Thu, 23 Sep 2021 15:54:47 +0200 (CEST)
Subject: Re: [PATCH 3/3] memblock: cleanup memblock_free interface
To: Mike Rapoport <rppt@linux.ibm.com>
References: <20210923074335.12583-1-rppt@kernel.org>
 <20210923074335.12583-4-rppt@kernel.org>
 <1101e3c7-fcb7-a632-8e22-47f4a01ea02e@csgroup.eu>
 <YUxsgN/uolhn1Ok+@linux.ibm.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <96e3da9f-70ff-e5c0-ef2e-cf0b636e5695@csgroup.eu>
Date: Thu, 23 Sep 2021 15:54:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YUxsgN/uolhn1Ok+@linux.ibm.com>
Content-Language: fr-FR
Cc: linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org, sparclinux@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 kasan-dev@googlegroups.com, xen-devel@lists.xenproject.org,
 linux-snps-arc@lists.infradead.org, devicetree@vger.kernel.org,
 linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-alpha@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, Mike Rapoport <rppt@kernel.org>
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

CgpMZSAyMy8wOS8yMDIxIMOgIDE0OjAxLCBNaWtlIFJhcG9wb3J0IGEgw6ljcml0wqA6Cj4gT24g
VGh1LCBTZXAgMjMsIDIwMjEgYXQgMTE6NDc6NDhBTSArMDIwMCwgQ2hyaXN0b3BoZSBMZXJveSB3
cm90ZToKPj4KPj4KPj4gTGUgMjMvMDkvMjAyMSDDoCAwOTo0MywgTWlrZSBSYXBvcG9ydCBhIMOp
Y3JpdMKgOgo+Pj4gRnJvbTogTWlrZSBSYXBvcG9ydCA8cnBwdEBsaW51eC5pYm0uY29tPgo+Pj4K
Pj4+IEZvciBhZ2VzIG1lbWJsb2NrX2ZyZWUoKSBpbnRlcmZhY2UgZGVhbHQgd2l0aCBwaHlzaWNh
bCBhZGRyZXNzZXMgZXZlbgo+Pj4gZGVzcGl0ZSB0aGUgZXhpc3RlbmNlIG9mIG1lbWJsb2NrX2Fs
bG9jX3h4KCkgZnVuY3Rpb25zIHRoYXQgcmV0dXJuIGEKPj4+IHZpcnR1YWwgcG9pbnRlci4KPj4+
Cj4+PiBJbnRyb2R1Y2UgbWVtYmxvY2tfcGh5c19mcmVlKCkgZm9yIGZyZWVpbmcgcGh5c2ljYWwg
cmFuZ2VzIGFuZCByZXB1cnBvc2UKPj4+IG1lbWJsb2NrX2ZyZWUoKSB0byBmcmVlIHZpcnR1YWwg
cG9pbnRlcnMgdG8gbWFrZSB0aGUgZm9sbG93aW5nIHBhaXJpbmcKPj4+IGFidW5kYW50bHkgY2xl
YXI6Cj4+Pgo+Pj4gCWludCBtZW1ibG9ja19waHlzX2ZyZWUocGh5c19hZGRyX3QgYmFzZSwgcGh5
c19hZGRyX3Qgc2l6ZSk7Cj4+PiAJcGh5c19hZGRyX3QgbWVtYmxvY2tfcGh5c19hbGxvYyhwaHlz
X2FkZHJfdCBiYXNlLCBwaHlzX2FkZHJfdCBzaXplKTsKPj4+Cj4+PiAJdm9pZCAqbWVtYmxvY2tf
YWxsb2MocGh5c19hZGRyX3Qgc2l6ZSwgcGh5c19hZGRyX3QgYWxpZ24pOwo+Pj4gCXZvaWQgbWVt
YmxvY2tfZnJlZSh2b2lkICpwdHIsIHNpemVfdCBzaXplKTsKPj4+Cj4+PiBSZXBsYWNlIGludGVy
bWVkaWF0ZSBtZW1ibG9ja19mcmVlX3B0cigpIHdpdGggbWVtYmxvY2tfZnJlZSgpIGFuZCBkcm9w
Cj4+PiB1bm5lY2Vzc2FyeSBhbGlhc2VzIG1lbWJsb2NrX2ZyZWVfZWFybHkoKSBhbmQgbWVtYmxv
Y2tfZnJlZV9lYXJseV9uaWQoKS4KPj4+Cj4+PiBTdWdnZXN0ZWQtYnk6IExpbnVzIFRvcnZhbGRz
IDx0b3J2YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz4KPj4+IFNpZ25lZC1vZmYtYnk6IE1pa2Ug
UmFwb3BvcnQgPHJwcHRAbGludXguaWJtLmNvbT4KPj4+IC0tLQo+Pgo+Pj4gZGlmZiAtLWdpdCBh
L2FyY2gvczM5MC9rZXJuZWwvc21wLmMgYi9hcmNoL3MzOTAva2VybmVsL3NtcC5jCj4+PiBpbmRl
eCAxYTA0ZTViZGY2NTUuLjM3ODI2ZDhjNGY3NCAxMDA2NDQKPj4+IC0tLSBhL2FyY2gvczM5MC9r
ZXJuZWwvc21wLmMKPj4+ICsrKyBiL2FyY2gvczM5MC9rZXJuZWwvc21wLmMKPj4+IEBAIC03MjMs
NyArNzIzLDcgQEAgdm9pZCBfX2luaXQgc21wX3NhdmVfZHVtcF9jcHVzKHZvaWQpCj4+PiAgICAJ
CQkvKiBHZXQgdGhlIENQVSByZWdpc3RlcnMgKi8KPj4+ICAgIAkJCXNtcF9zYXZlX2NwdV9yZWdz
KHNhLCBhZGRyLCBpc19ib290X2NwdSwgcGFnZSk7Cj4+PiAgICAJfQo+Pj4gLQltZW1ibG9ja19m
cmVlKHBhZ2UsIFBBR0VfU0laRSk7Cj4+PiArCW1lbWJsb2NrX3BoeXNfZnJlZShwYWdlLCBQQUdF
X1NJWkUpOwo+Pj4gICAgCWRpYWdfYW1vZGUzMV9vcHMuZGlhZzMwOF9yZXNldCgpOwo+Pj4gICAg
CXBjcHVfc2V0X3NtdCgwKTsKPj4+ICAgIH0KPj4+IEBAIC04ODAsNyArODgwLDcgQEAgdm9pZCBf
X2luaXQgc21wX2RldGVjdF9jcHVzKHZvaWQpCj4+PiAgICAJLyogQWRkIENQVXMgcHJlc2VudCBh
dCBib290ICovCj4+PiAgICAJX19zbXBfcmVzY2FuX2NwdXMoaW5mbywgdHJ1ZSk7Cj4+PiAtCW1l
bWJsb2NrX2ZyZWVfZWFybHkoKHVuc2lnbmVkIGxvbmcpaW5mbywgc2l6ZW9mKCppbmZvKSk7Cj4+
PiArCW1lbWJsb2NrX2ZyZWUoaW5mbywgc2l6ZW9mKCppbmZvKSk7Cj4+PiAgICB9Cj4+PiAgICAv
Kgo+Pgo+PiBJJ20gYSBiaXQgbG9zdC4gSUlVQyBtZW1ibG9ja19mcmVlX2Vhcmx5KCkgYW5kIG1l
bWJsb2NrX2ZyZWUoKSB3aGVyZQo+PiBpZGVudGljYWwuCj4gCj4gWWVzLCB0aGV5IHdlcmUsIGJ1
dCBhbGwgY2FsbHMgdG8gbWVtYmxvY2tfZnJlZV9lYXJseSgpIHdlcmUgdXNpbmcKPiBfX3BhKHZh
ZGRyKSBiZWNhdXNlIHRoZXkgaGFkIGEgdmlydHVhbCBhZGRyZXNzIGF0IGhhbmQuCgpJJ20gc3Rp
bGwgbm90IGZvbGxvd2luZy4gSW4gdGhlIGFib3ZlIG1lbWJsb2NrX2ZyZWVfZWFybHkoKSB3YXMg
dGFraW5nIAoodW5zaWduZWQgbG9uZylpbmZvIC4gV2FzIGl0IGEgYnVnID8gSXQgbG9va3Mgb2Rk
IHRvIGhpZGUgYnVnIGZpeGVzIGluIApzdWNoIGEgYmlnIHBhdGNoLCBzaG91bGQgdGhhdCBidWcg
Zml4IGdvIGluIHBhdGNoIDIgPwoKPiAKPj4gSW4gdGhlIGZpcnN0IGh1bmsgbWVtYmxvY2tfZnJl
ZSgpIGdldHMgcmVwbGFjZWQgYnkgbWVtYmxvY2tfcGh5c19mcmVlKCkKPj4gSW4gdGhlIHNlY29u
ZCBodW5rIG1lbWJsb2NrX2ZyZWVfZWFybHkoKSBnZXRzIHJlcGxhY2VkIGJ5IG1lbWJsb2NrX2Zy
ZWUoKQo+IAo+IEluIHRoZSBmaXJzdCBodW5rIHRoZSBtZW1vcnkgaXMgYWxsb2NhdGVkIHdpdGgg
bWVtYmxvY2tfcGh5c19hbGxvYygpIGFuZCB3ZQo+IGhhdmUgYSBwaHlzaWNhbCByYW5nZSB0byBm
cmVlLiBJbiB0aGUgc2Vjb25kIGh1bmsgdGhlIG1lbW9yeSBpcyBhbGxvY2F0ZWQKPiB3aXRoIG1l
bWJsb2NrX2FsbG9jKCkgYW5kIHdlIGFyZSBmcmVlaW5nIGEgdmlydHVhbCBwb2ludGVyLgo+ICAg
Cj4+IEkgdGhpbmsgaXQgd291bGQgYmUgZWFzaWVyIHRvIGZvbGxvdyBpZiB5b3UgY291bGQgc3Bs
aXQgaXQgaW4gc2V2ZXJhbAo+PiBwYXRjaGVzOgo+IAo+IEl0IHdhcyBhbiBleHBsaWNpdCByZXF1
ZXN0IGZyb20gTGludXMgdG8gbWFrZSBpdCBhIHNpbmdsZSBjb21taXQ6Cj4gCj4gICAgYnV0IHRo
ZSBhY3R1YWwgY29tbWl0IGNhbiBhbmQgc2hvdWxkIGJlIGp1c3QgYSBzaW5nbGUgY29tbWl0IHRo
YXQganVzdAo+ICAgIGZpeGVzICdtZW1ibG9ja19mcmVlKCknIHRvIGhhdmUgc2FuZSBpbnRlcmZh
Y2VzLgo+IAo+IEkgZG9uJ3QgZmVlbCBzdHJvbmdseSBhYm91dCBzcGxpdHRpbmcgaXQgKGV4Y2Vw
dCBteSBsYXppbmVzcyByZWFsbHkKPiBvYmplY3RzKSwgYnV0IEkgZG9uJ3QgdGhpbmsgZG9pbmcg
dGhlIGNvbnZlcnNpb24gaW4gc2V2ZXJhbCBzdGVwcyB3b3J0aCB0aGUKPiBjaHVybi4KClRoZSBj
b21taXQgaXMgcXVpdGUgYmlnICg1NSBmaWxlcyBjaGFuZ2VkLCBhcHByb3ggMTAwIGxpbmVzIG1v
ZGlmaWVkKS4KCklmIGRvbmUgaW4gdGhlIHJpZ2h0IG9yZGVyIHRoZSBjaGFuZ2Ugc2hvdWxkIGJl
IG1pbmltYWwuCgpJdCBpcyByYXRoZXIgbm90LWVhc3kgdG8gZm9sbG93IGFuZCByZXZpZXcgd2hl
biBhIGZ1bmN0aW9uIHRoYXQgd2FzIApleGlzdGluZyAobmFtZWx5IG1lbWJsb2NrX2ZyZWUoKSAp
IGRpc2FwcGVhcnMgYW5kIHJlLWFwcGVhcnMgaW4gdGhlIHNhbWUgCmNvbW1pdCBidXQgdG8gZG8g
c29tZXRoaW5nIGRpZmZlcmVudC4KCllvdSBkbzoKLSBtZW1ibG9ja19mcmVlKCkgPT0+IG1lbWJs
b2NrX3BoeXNfZnJlZSgpCi0gbWVtYmxvY2tfZnJlZV9wdHIoKSA9PT4gbWVtYmxvY2tfZnJlZSgp
CgpBdCBsZWFzdCB5b3UgY291bGQgc3BsaXQgaW4gdHdvIHBhdGNoZXMsIHRoZSBhZHZhbnRhZ2Ug
d291bGQgYmUgdGhhdCAKYmV0d2VlbiBmaXJzdCBhbmQgc2Vjb25kIHBhdGNoIG1lbWJsb2NrKCkg
ZG9lc24ndCBleGlzdCBhbnltb3JlIHNvIHlvdSAKY2FuIGNoZWNrIHlvdSByZWFsbHkgZG9uJ3Qg
aGF2ZSBhbnltb3JlIHVzZXIuCgo+IAo+PiAtIEZpcnN0IHBhdGNoOiBDcmVhdGUgbWVtYmxvY2tf
cGh5c19mcmVlKCkgYW5kIGNoYW5nZSBhbGwgcmVsZXZhbnQKPj4gbWVtYmxvY2tfZnJlZSgpIHRv
IG1lbWJsb2NrX3BoeXNfZnJlZSgpIC0gT3IgY2hhbmdlIG1lbWJsb2NrX2ZyZWUoKSB0bwo+PiBt
ZW1ibG9ja19waHlzX2ZyZWUoKSBhbmQgbWFrZSBtZW1ibG9ja19mcmVlKCkgYW4gYWxpYXMgb2Yg
aXQuCj4+IC0gU2Vjb25kIHBhdGNoOiBNYWtlIG1lbWJsb2NrX2ZyZWVfcHRyKCkgYmVjb21lIG1l
bWJsb2NrX2ZyZWUoKSBhbmQgY2hhbmdlCj4+IGFsbCByZW1haW5pbmcgY2FsbGVycyB0byB0aGUg
bmV3IHNlbWFudGljcyAoSUlVQyBtZW1ibG9ja19mcmVlKF9fcGEocHRyKSkKPj4gYmVjb21lcyBt
ZW1ibG9ja19mcmVlKHB0cikgYW5kIG1ha2UgbWVtYmxvY2tfZnJlZV9wdHIoKSBhbiBhbGlhcyBv
Zgo+PiBtZW1ibG9ja19mcmVlKCkKPj4gLSBGb3VydGggcGF0Y2g6IFJlcGxhY2UgYW5kIGRyb3Ag
bWVtYmxvY2tfZnJlZV9wdHIoKQo+PiAtIEZpZnRoIHBhdGNoOiBEcm9wIG1lbWJsb2NrX2ZyZWVf
ZWFybHkoKSBhbmQgbWVtYmxvY2tfZnJlZV9lYXJseV9uaWQoKSAoQWxsCj4+IHVzZXJzIHNob3Vs
ZCBoYXZlIGJlZW4gdXBncmFkZWQgdG8gbWVtYmxvY2tfZnJlZV9waHlzKCkgaW4gcGF0Y2ggMSBv
cgo+PiBtZW1ibG9ja19mcmVlKCkgaW4gcGF0Y2ggMikKPj4KPj4gQ2hyaXN0b3BoZQo+IApfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5n
IGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
