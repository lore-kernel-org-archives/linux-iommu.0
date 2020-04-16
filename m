Return-Path: <SRS0=meaX=6A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371F4C352BE
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 17:44:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E962C2078B
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 17:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="HtfFFiu/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E962C2078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 803C287DB1;
	Thu, 16 Apr 2020 17:44:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id btfvcAwJn71F; Thu, 16 Apr 2020 17:44:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A2D718749A;
	Thu, 16 Apr 2020 17:44:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95369C089E;
	Thu, 16 Apr 2020 17:44:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 699F1C0172
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 17:44:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 54AFE86096
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 17:44:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IbAELne8XCdN for <iommu@lists.linux-foundation.org>;
 Thu, 16 Apr 2020 17:44:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail26.static.mailgun.info (mail26.static.mailgun.info
 [104.130.122.26])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4FEA885C3B
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 17:44:04 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1587059048; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=JC4ZwghNo+JEiak2hmqi7d8kddFUllqOr9vrtZr5HYE=;
 b=HtfFFiu/hExld+CefooChbbDpqi/ujJRZ/G3ZBmDODdaxKw3E7ajwun2kNfndZ4fPdITiFPs
 FTkRHUe0DigQUAF8Gx+SRJYfdzwbVUxXh/EDfYmHrP12Ckfv/aMKP/fg4WTo2cle7QENboH7
 hLRKutxnbnoFXRHkzXMbm7NxZJ4=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e989958.7efd1aae9260-smtp-out-n04;
 Thu, 16 Apr 2020 17:43:52 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 7FDBBC4478C; Thu, 16 Apr 2020 17:43:52 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 7D284C4478C;
 Thu, 16 Apr 2020 17:43:50 +0000 (UTC)
MIME-Version: 1.0
Date: Thu, 16 Apr 2020 23:13:50 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 2/2] iommu/arm-smmu: Allow client devices to select direct
 mapping
In-Reply-To: <fdc265e4-5a96-2def-df13-376249e16b49@arm.com>
References: <cover.1579692800.git.saiprakash.ranjan@codeaurora.org>
 <813cc5b2da10c27db982254b274bf26008a9e6da.1579692800.git.saiprakash.ranjan@codeaurora.org>
 <3f12cefb-3887-859c-ddf5-c7a0fc755152@arm.com>
 <540fc55811d0a60a929ff1f694d6d271@codeaurora.org>
 <fdc265e4-5a96-2def-df13-376249e16b49@arm.com>
Message-ID: <c84cf5debc171c0744e32049c70197e7@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
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

SGkgUm9iaW4sCgpPbiAyMDIwLTA0LTE2IDIyOjQ3LCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4gT24g
MjAyMC0wNC0xNiA1OjIzIHBtLCBTYWkgUHJha2FzaCBSYW5qYW4gd3JvdGU6Cj4+IEhpIFJvYmlu
LAo+PiAKPj4gT24gMjAyMC0wNC0xNiAxOToyOCwgUm9iaW4gTXVycGh5IHdyb3RlOgo+Pj4gT24g
MjAyMC0wMS0yMiAxMTo0OCBhbSwgU2FpIFByYWthc2ggUmFuamFuIHdyb3RlOgo+Pj4+IEZyb206
IEpvcmRhbiBDcm91c2UgPGpjcm91c2VAY29kZWF1cm9yYS5vcmc+Cj4+Pj4gCj4+Pj4gU29tZSBj
bGllbnQgZGV2aWNlcyB3YW50IHRvIGRpcmVjdGx5IG1hcCB0aGUgSU9NTVUgdGhlbXNlbHZlcyAK
Pj4+PiBpbnN0ZWFkCj4+Pj4gb2YgdXNpbmcgdGhlIERNQSBkb21haW4uIEFsbG93IHRob3NlIGRl
dmljZXMgdG8gb3B0IGluIHRvIGRpcmVjdAo+Pj4+IG1hcHBpbmcgYnkgd2F5IG9mIGEgbGlzdCBv
ZiBjb21wYXRpYmxlIHN0cmluZ3MuCj4+Pj4gCj4+Pj4gU2lnbmVkLW9mZi1ieTogSm9yZGFuIENy
b3VzZSA8amNyb3VzZUBjb2RlYXVyb3JhLm9yZz4KPj4+PiBDby1kZXZlbG9wZWQtYnk6IFNhaSBQ
cmFrYXNoIFJhbmphbiAKPj4+PiA8c2FpcHJha2FzaC5yYW5qYW5AY29kZWF1cm9yYS5vcmc+Cj4+
Pj4gU2lnbmVkLW9mZi1ieTogU2FpIFByYWthc2ggUmFuamFuIDxzYWlwcmFrYXNoLnJhbmphbkBj
b2RlYXVyb3JhLm9yZz4KPj4+PiAtLS0KPj4+PiDCoCBkcml2ZXJzL2lvbW11L2FybS1zbW11LXFj
b20uYyB8IDM5IAo+Pj4+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4+Pj4g
wqAgZHJpdmVycy9pb21tdS9hcm0tc21tdS5jwqDCoMKgwqDCoCB8wqAgMyArKysKPj4+PiDCoCBk
cml2ZXJzL2lvbW11L2FybS1zbW11LmjCoMKgwqDCoMKgIHzCoCA1ICsrKysrCj4+Pj4gwqAgMyBm
aWxlcyBjaGFuZ2VkLCA0NyBpbnNlcnRpb25zKCspCj4+Pj4gCj4+Pj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaW9tbXUvYXJtLXNtbXUtcWNvbS5jIAo+Pj4+IGIvZHJpdmVycy9pb21tdS9hcm0tc21t
dS1xY29tLmMKPj4+PiBpbmRleCA2NGE0YWIyNzBhYjcuLmZmNzQ2YWNkMWM4MSAxMDA2NDQKPj4+
PiAtLS0gYS9kcml2ZXJzL2lvbW11L2FybS1zbW11LXFjb20uYwo+Pj4+ICsrKyBiL2RyaXZlcnMv
aW9tbXUvYXJtLXNtbXUtcWNvbS5jCj4+Pj4gQEAgLTMsNiArMyw3IEBACj4+Pj4gwqDCoCAqIENv
cHlyaWdodCAoYykgMjAxOSwgVGhlIExpbnV4IEZvdW5kYXRpb24uIEFsbCByaWdodHMgcmVzZXJ2
ZWQuCj4+Pj4gwqDCoCAqLwo+Pj4+IMKgICsjaW5jbHVkZSA8bGludXgvb2ZfZGV2aWNlLmg+Cj4+
Pj4gwqAgI2luY2x1ZGUgPGxpbnV4L3Fjb21fc2NtLmg+Cj4+Pj4gwqDCoMKgICNpbmNsdWRlICJh
cm0tc21tdS5oIgo+Pj4+IEBAIC0xMSw2ICsxMiw0MyBAQCBzdHJ1Y3QgcWNvbV9zbW11IHsKPj4+
PiDCoMKgwqDCoMKgIHN0cnVjdCBhcm1fc21tdV9kZXZpY2Ugc21tdTsKPj4+PiDCoCB9Owo+Pj4+
IMKgICtzdGF0aWMgY29uc3Qgc3RydWN0IGFybV9zbW11X2NsaWVudF9tYXRjaF9kYXRhIHFjb21f
YWRyZW5vID0gewo+Pj4+ICvCoMKgwqAgLmRpcmVjdF9tYXBwaW5nID0gdHJ1ZSwKPj4+PiArfTsK
Pj4+PiArCj4+Pj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgYXJtX3NtbXVfY2xpZW50X21hdGNoX2Rh
dGEgcWNvbV9tZHNzID0gewo+Pj4+ICvCoMKgwqAgLmRpcmVjdF9tYXBwaW5nID0gdHJ1ZSwKPj4+
PiArfTsKPj4+IAo+Pj4gTWlnaHQgaXQgbWFrZSBzZW5zZSB0byBncm91cCB0aGVzZSBieSB0aGUg
ZGVzaXJlZCBTTU1VIGJlaGF2aW91cgo+Pj4gcmF0aGVyIHRoYW4gKGFwcGFyZW50bHkpIHdoYXQg
a2luZCBvZiBkZXZpY2UgdGhlIGNsaWVudCBoYXBwZW5zIHRvIAo+Pj4gYmUsCj4+PiB3aGljaCBz
ZWVtcyBsaWtlIGEgY29tcGxldGVseSBhcmJpdHJhcnkgZGlzdGluY3Rpb24gZnJvbSB0aGUgU01N
VQo+Pj4gZHJpdmVyJ3MgUG9WPwo+Pj4gCj4+IAo+PiBTb3JyeSwgSSBkaWQgbm90IGdldCB0aGUg
Imdyb3VwaW5nIGJ5IHRoZSBkZXNpcmVkIFNNTVUgYmVoYXZpb3VyIiAKPj4gdGhpbmcuCj4+IENv
dWxkIHlvdSBwbGVhc2UgZ2l2ZSBzb21lIG1vcmUgZGV0YWlscz8KPiAKPiBJIG1lYW4gdGhpcyBw
YXR0ZXJuOgo+IAo+IGRldmljZV9hX2RhdGEgewo+IAkudGhpbmcgPSB0aGlzOwo+IH0KPiAKPiBk
ZXZpY2VfYl9kYXRhIHsKPiAJLnRoaW5nID0gdGhpczsKPiB9Cj4gCj4gZGV2aWNlX2NfZGF0YSB7
Cj4gCS50aGluZyA9IHRoYXQ7Cj4gfQo+IAo+IG1hdGNoW10gPSB7Cj4gCXsgLmNvbXBhdGlibGUg
PSAiQSIsIC5kYXRhID0gJmRldmljZV9hX2RhdGEgfSwKPiAJeyAuY29tcGF0aWJsZSA9ICJCIiwg
LmRhdGEgPSAmZGV2aWNlX2JfZGF0YSB9LAo+IAl7IC5jb21wYXRpYmxlID0gIkMiLCAuZGF0YSA9
ICZkZXZpY2VfY19kYXRhIH0sCj4gfTsKPiAKPiAuLi52cy4gdGhpcyBwYXR0ZXJuOgo+IAo+IGRv
X3RoaXMgewo+IAkudGhpbmcgPSB0aGlzOwo+IH0KPiAKPiBkb190aGF0IHsKPiAJLnRoaW5nID0g
dGhhdDsKPiB9Cj4gCj4gbWF0Y2hbXSA9IHsKPiAJeyAuY29tcGF0aWJsZSA9ICJBIiwgLmRhdGEg
PSAmZG9fdGhpcyB9LAo+IAl7IC5jb21wYXRpYmxlID0gIkIiLCAuZGF0YSA9ICZkb190aGlzIH0s
Cj4gCXsgLmNvbXBhdGlibGUgPSAiQyIsIC5kYXRhID0gJmRvX3RoYXQgfSwKPiB9Owo+IAo+IEZy
b20gdGhlIHBlcnNwZWN0aXZlIG9mIHRoZSB0aGluZyBkb2luZyB0aGUgdGhpbmcsIGdyb3VwaW5n
IHRoZSBkYXRhCj4gYnkgZGV2aWNlIGlzIG1lYW5pbmdsZXNzIGlmIGFsbCB0aGF0IG1hdHRlcnMg
aXMgd2hldGhlciB0byBkbyB0aGlzIG9yCj4gdGhhdC4gVGhlIHNlY29uZCBwYXR0ZXJuIGV4cHJl
c3NlcyB0aGF0IG1vcmUgbmF0dXJhbGx5Lgo+IAo+IE9mIGNvdXJzZSBpZiBldmVyeSBkZXZpY2Ug
dHVybnMgb3V0IHRvIG5lZWQgYSB1bmlxdWUgY29tYmluYXRpb24gb2YKPiBzZXZlcmFsIGJlaGF2
aW91cnMsIHRoZW4gdGhlcmUgZW5kcyB1cCBiZWluZyBubyBwcmFjdGljYWwgZGlmZmVyZW5jZQo+
IGV4Y2VwdCB0aGF0IGl0J3MgcHJvYmFibHkgZWFzaWVyIHRvIGNvbWUgdXAgd2l0aCBuaWNlIG5h
bWVzIHVuZGVyIHRoZQo+IGZpcnN0IHBhdHRlcm4uIEkgZ3Vlc3MgaXQncyB1cCB0byBob3cgeW91
IHNlZSB0aGlzIGRldmVsb3BpbmcgaW4KPiBmdXR1cmU7IHdoZXRoZXIgeW91J3JlIGxpa2VseSB0
byBuZWVkIGZpbmUtZ3JhaW5lZCBwZXItZGV2aWNlIGNvbnRyb2wsCj4gb3IgZG9uJ3QgZXhwZWN0
IGl0IHRvIGdvIG11Y2ggYmV5b25kIGRvbWFpbiB0eXBlLgo+IAoKVGhhbmtzIGZvciBleHBsYWlu
aW5nICp0aGlzIHRoaW5nKiA6KQpJIHdpbGwgdXBkYXRlIHRoZSBwYXRjaCB0byBmb2xsb3cgdGhl
IDJuZCBwYXR0ZXJuIGFzIGl0IG1ha2VzIG1vcmUgc2Vuc2UKdG8gZG9fdGhpcyBvciBkb190aGF0
IGRpcmVjdGx5LiBJJ20gbm90IGV4cGVjdGluZyBhbnl0aGluZyBvdGhlciB0aGFuCmRvbWFpbiB0
eXBlIGF0bGVhc3QgZm9yIG5vdyBidXQgaGV5IHdlIGNhbiBhbHdheXMgYWRkIHRoZSBmdW5jdGlv
bmFsaXR5CmlmIHRoZSBuZWVkIGFyaXNlcy4KClRoYW5rcywKU2FpCgotLSAKUVVBTENPTU0gSU5E
SUEsIG9uIGJlaGFsZiBvZiBRdWFsY29tbSBJbm5vdmF0aW9uIENlbnRlciwgSW5jLiBpcyBhIApt
ZW1iZXIKb2YgQ29kZSBBdXJvcmEgRm9ydW0sIGhvc3RlZCBieSBUaGUgTGludXggRm91bmRhdGlv
bgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBt
YWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
