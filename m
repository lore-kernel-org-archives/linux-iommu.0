Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE6F7C43217
	for <iommu@archiver.kernel.org>; Fri, 25 Mar 2022 16:45:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 595C984309;
	Fri, 25 Mar 2022 16:45:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LzYykUQIsi23; Fri, 25 Mar 2022 16:45:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 37524842E2;
	Fri, 25 Mar 2022 16:45:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16B0AC002C;
	Fri, 25 Mar 2022 16:45:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE4CFC0012
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 16:45:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CB4D841D22
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 16:45:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id viEv8hOnNLhZ for <iommu@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 16:45:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0C7FE41D21
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 16:45:46 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06F6C12FC;
 Fri, 25 Mar 2022 09:45:46 -0700 (PDT)
Received: from [10.57.41.19] (unknown [10.57.41.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 495323F73D;
 Fri, 25 Mar 2022 09:45:43 -0700 (PDT)
Message-ID: <f4224721-4578-61d3-69a7-9a3a76c50529@arm.com>
Date: Fri, 25 Mar 2022 16:45:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
Content-Language: en-GB
To: =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@toke.dk>,
 mbizon@freebox.fr, Linus Torvalds <torvalds@linux-foundation.org>
References: <1812355.tdWV9SEqCh@natalenko.name>
 <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
 <20220324055732.GB12078@lst.de> <4386660.LvFx2qVVIh@natalenko.name>
 <81ffc753-72aa-6327-b87b-3f11915f2549@arm.com> <878rsza0ih.fsf@toke.dk>
 <4be26f5d8725cdb016c6fdd9d05cfeb69cdd9e09.camel@freebox.fr>
 <20220324163132.GB26098@lst.de>
 <d8a1cbf4-a521-78ec-1560-28d855e0913e@arm.com> <871qyr9t4e.fsf@toke.dk>
 <CAHk-=whUQCCaQXJt3KUeQ8mtnLeVXEScNXCp+_DYh2SNY7EcEA@mail.gmail.com>
 <31434708dcad126a8334c99ee056dcce93e507f1.camel@freebox.fr>
 <87a6de80em.fsf@toke.dk>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <87a6de80em.fsf@toke.dk>
Cc: Netdev <netdev@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 stable <stable@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Halil Pasic <pasic@linux.ibm.com>, iommu <iommu@lists.linux-foundation.org>,
 Olha Cherevyk <olha.cherevyk@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Christoph Hellwig <hch@lst.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

T24gMjAyMi0wMy0yNSAxNjoyNSwgVG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIHdyb3RlOgo+IE1h
eGltZSBCaXpvbiA8bWJpem9uQGZyZWVib3guZnI+IHdyaXRlczoKPiAKPj4gT24gVGh1LCAyMDIy
LTAzLTI0IGF0IDEyOjI2IC0wNzAwLCBMaW51cyBUb3J2YWxkcyB3cm90ZToKPj4KPj4+Cj4+PiBJ
dCdzIGFjdHVhbGx5IHZlcnkgbmF0dXJhbCBpbiB0aGF0IHNpdHVhdGlvbiB0byBmbHVzaCB0aGUg
Y2FjaGVzIGZyb20KPj4+IHRoZSBDUFUgc2lkZSBhZ2Fpbi4gQW5kIHNvIGRtYV9zeW5jX3Npbmds
ZV9mb3JfZGV2aWNlKCkgaXMgYSBmYWlybHkKPj4+IHJlYXNvbmFibGUgdGhpbmcgdG8gZG8gaW4g
dGhhdCBzaXR1YXRpb24uCj4+Pgo+Pgo+PiBJbiB0aGUgbm9uLWNhY2hlLWNvaGVyZW50IHNjZW5h
cmlvLCBhbmQgYXNzdW1pbmcgZG1hX21hcCgpIGRpZCBhbgo+PiBpbml0aWFsIGNhY2hlIGludmFs
aWRhdGlvbiwgeW91IGNhbiB3cml0ZSB0aGlzOgo+Pgo+PiByeF9idWZmZXJfY29tcGxldGVfMShi
dWYpCj4+IHsKPj4gCWludmFsaWRhdGVfY2FjaGUoYnVmLCBzaXplKQo+PiAJaWYgKCFpc19yZWFk
eShidWYpKQo+PiAJCXJldHVybjsKPj4gCTxwcm9jZWVkIHdpdGggcmVjZWl2ZT4KPj4gfQo+Pgo+
PiBvcgo+Pgo+PiByeF9idWZmZXJfY29tcGxldGVfMihidWYpCj4+IHsKPj4gCWlmICghaXNfcmVh
ZHkoYnVmKSkgewo+PiAJCWludmFsaWRhdGVfY2FjaGUoYnVmLCBzaXplKQo+PiAJCXJldHVybjsK
Pj4gCX0KPj4gCTxwcm9jZWVkIHdpdGggcmVjZWl2ZT4KPj4gfQo+Pgo+PiBUaGUgbGF0dGVyIGlz
IHByZWZlcnJlZCBmb3IgcGVyZm9ybWFuY2UgYmVjYXVzZSBkbWFfbWFwKCkgZGlkIHRoZQo+PiBp
bml0aWFsIGludmFsaWRhdGUuCj4+Cj4+IE9mIGNvdXJzZSB5b3UgY291bGQgd3JpdGU6Cj4+Cj4+
IHJ4X2J1ZmZlcl9jb21wbGV0ZV8zKGJ1ZikKPj4gewo+PiAJaW52YWxpZGF0ZV9jYWNoZShidWYs
IHNpemUpCj4+IAlpZgo+PiAoIWlzX3JlYWR5KGJ1ZikpIHsKPj4gCQlpbnZhbGlkYXRlX2NhY2hl
KGJ1Ziwgc2l6ZSkKPj4gCQlyZXR1cm47Cj4+IAl9Cj4+IAkKPj4gPHByb2NlZWQgd2l0aCByZWNl
aXZlPgo+PiB9Cj4+Cj4+Cj4+IGJ1dCBpdCdzIGEgd2FzdGUgb2YgQ1BVIGN5Y2xlcwo+Pgo+PiBT
byBJJ2QgYmUgdmVyeSBjYXV0aW91cyBhc3N1bWluZyBzeW5jX2Zvcl9jcHUoKSBhbmQgc3luY19m
b3JfZGV2aWNlKCkKPj4gYXJlIGJvdGggZG9pbmcgaW52YWxpZGF0aW9uIGluIGV4aXN0aW5nIGlt
cGxlbWVudGF0aW9uIG9mIGFyY2ggRE1BIG9wcywKPj4gaW1wbGVtZW50ZXJzIG1heSBoYXZlIHRh
a2VuIHNvbWUgbGliZXJ0eSBhcm91bmQgRE1BLUFQSSB0byBhdm9pZAo+PiB1bm5lY2Vzc2FyeSBj
YWNoZSBvcGVyYXRpb24gKG5vdCB0byBibGFtZSB0aGVtKS4KPiAKPiBJIHNlbnNlIGFuIGltcGxp
Y2l0ICJhbmQgdGhlIGRyaXZlciBjYW4ndCAob3Igc2hvdWxkbid0KSBpbmZsdWVuY2UKPiB0aGlz
IiBoZXJlLCByaWdodD8KClJpZ2h0LCBkcml2ZXJzIGRvbid0IGdldCBhIGNob2ljZSBvZiBob3cg
YSBnaXZlbiBETUEgQVBJIGltcGxlbWVudGF0aW9uIAp3b3Jrcy4KCj4+IEZvciBleGFtcGxlIGxv
b2tpbmcgYXQgYXJjaC9hcm0vbW0vZG1hLW1hcHBpbmcuYywgZm9yIERNQV9GUk9NX0RFVklDRQo+
Pgo+PiBzeW5jX3NpbmdsZV9mb3JfZGV2aWNlKCkKPj4gICAgPT4gX19kbWFfcGFnZV9jcHVfdG9f
ZGV2KCkKPj4gICAgICA9PiBkbWFfY2FjaGVfbWFpbnRfcGFnZShvcD1kbWFjX21hcF9hcmVhKQo+
PiAgICAgICAgPT4gY3B1X2NhY2hlLmRtYV9tYXBfYXJlYSgpCj4+Cj4+IHN5bmNfc2luZ2xlX2Zv
cl9jcHUoKQo+PiAgICA9PiBfX2RtYV9wYWdlX2Rldl90b19jcHUoKQo+PiAgICAgID0+Cj4+IF9f
ZG1hX3BhZ2VfY3B1X3RvX2RldihvcD1kbWFjX3VubWFwX2FyZWEpCj4+ICAgICAgICA9Pgo+PiBj
cHVfY2FjaGUuZG1hX3VubWFwX2FyZWEoKQo+Pgo+PiBkbWFfbWFwX2FyZWEoKSBhbHdheXMgZG9l
cyBjYWNoZSBpbnZhbGlkYXRlLgo+Pgo+PiBCdXQgZm9yIGEgY291cGxlIG9mIENQVSB2YXJpYW50
LCBkbWFfdW5tYXBfYXJlYSgpIGlzIGEgbm9vcCwgc28KPj4gc3luY19mb3JfY3B1KCkgZG9lcyBu
b3RoaW5nLgo+Pgo+PiBUb2tlJ3MgcGF0Y2ggd2lsbCBicmVhayBhdGg5ayBvbiB0aG9zZSBwbGF0
Zm9ybXMgKG1vc3RseSBzaWxlbnQKPj4gYnJlYWthZ2UsIHJ4IGNvcnJ1cHRpb24gbGVhZGluZyB0
byBiYWQgcGVyZm9ybWFuY2UpCj4gCj4gT2theSwgc28gdGhhdCB3b3VsZCBiZSBiYWQgb2J2aW91
c2x5LiBTbyBpZiBJJ20gcmVhZGluZyB5b3UgY29ycmVjdGx5Cj4gKGNmIG15IHF1ZXN0aW9uIGFi
b3ZlKSwgd2UgY2FuJ3QgZml4IHRoaXMgcHJvcGVybHkgZnJvbSB0aGUgZHJpdmVyIHNpZGUsCj4g
YW5kIHdlIHNob3VsZCBnbyB3aXRoIHRoZSBwYXJ0aWFsIFNXSU9UTEIgcmV2ZXJ0IGluc3RlYWQ/
CgpEbyB5b3UgaGF2ZSBhbnkgb3RoZXIgd2F5IG9mIHRlbGxpbmcgaWYgRE1BIGlzIGlkbGUsIG9y
IHRlbXBvcmFyaWx5IApwYXVzaW5nIGl0IGJlZm9yZSB0aGUgc3luY19mb3JfY3B1LCBzdWNoIHRo
YXQgeW91IGNvdWxkIGhvbm91ciB0aGUgCm5vdGlvbiBvZiBvd25lcnNoaXAgdHJhbnNmZXIgcHJv
cGVybHk/IEFzIG1lbnRpb25lZCBlbHNld2hlcmUgSSBzdXNwZWN0IAp0aGUgb25seSAicmVhbCIg
Zml4IGlmIHlvdSByZWFsbHkgZG8gbmVlZCB0byBhbGxvdyBjb25jdXJyZW50IGFjY2VzcyBpcyAK
dG8gdXNlIHRoZSBjb2hlcmVudCBETUEgQVBJIGZvciBidWZmZXJzIHJhdGhlciB0aGFuIHN0cmVh
bWluZyBtYXBwaW5ncywgCmJ1dCB0aGF0J3Mgb2J2aW91c2x5IHNvbWUgZmFyIG1vcmUgc2lnbmlm
aWNhbnQgc3VyZ2VyeS4KClJvYmluLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vaW9tbXU=
