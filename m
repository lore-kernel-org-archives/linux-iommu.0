Return-Path: <SRS0=+KdK=3D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD946C33CB1
	for <iommu@archiver.kernel.org>; Tue, 14 Jan 2020 14:59:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9615A222C4
	for <iommu@archiver.kernel.org>; Tue, 14 Jan 2020 14:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUh8clVt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9615A222C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5C59E838D9;
	Tue, 14 Jan 2020 14:59:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O4g4z5vyw8iw; Tue, 14 Jan 2020 14:59:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C4780826AC;
	Tue, 14 Jan 2020 14:59:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AFBB3C1D83;
	Tue, 14 Jan 2020 14:59:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A687C077D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jan 2020 14:59:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5797E83754
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jan 2020 14:59:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id INDZtsfq7klf for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jan 2020 14:59:38 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0112C83524
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jan 2020 14:59:37 +0000 (UTC)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 35DDA222C4;
 Tue, 14 Jan 2020 14:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579013977;
 bh=JsWfRq3X3gD6BI5Jjp77gShsE9xbLIe4k4ACCqlIDUs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jUh8clVtpbFL6PQgYE4wIm+2XEKpZn2NscpzUMxJZsQAdvIISnx5yHyocs6hXUN9C
 GGVkxtTHDzTHhgMuycAWt+4/A9wOFUGhZxM+JkceSC3lzD1GJovA1TP3c0IB6YMRP2
 dd736FW18wIbuSp2jizlxsiVLT0vY2P1Aq5uAsE0=
Date: Tue, 14 Jan 2020 15:59:34 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: zhangfei <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v11 2/4] uacce: add uacce driver
Message-ID: <20200114145934.GA1960403@kroah.com>
References: <1578710919-12141-1-git-send-email-zhangfei.gao@linaro.org>
 <1578710919-12141-3-git-send-email-zhangfei.gao@linaro.org>
 <20200111194006.GD435222@kroah.com>
 <053ccd05-4f11-5be6-47c2-eee5c2f1fdc4@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <053ccd05-4f11-5be6-47c2-eee5c2f1fdc4@linaro.org>
Cc: jean-philippe <jean-philippe@linaro.org>, dave.jiang@intel.com,
 Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
 francois.ozog@linaro.org, linux-accelerators@lists.ozlabs.org,
 ilias.apalodimas@linaro.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
 grant.likely@arm.com, "haojian . zhuang" <haojian.zhuang@linaro.org>,
 linux-crypto@vger.kernel.org, Kenneth Lee <liguozhu@hisilicon.com>,
 guodong.xu@linaro.org, kenneth-lee-2012@foxmail.com
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gTW9uLCBKYW4gMTMsIDIwMjAgYXQgMTE6MzQ6NTVBTSArMDgwMCwgemhhbmdmZWkgd3JvdGU6
Cj4gSGksIEdyZWcKPiAKPiBUaGFua3MgZm9yIHRoZSByZXZpZXcuCj4gCj4gT24gMjAyMC8xLzEy
IOS4iuWNiDM6NDAsIEdyZWcgS3JvYWgtSGFydG1hbiB3cm90ZToKPiA+IE9uIFNhdCwgSmFuIDEx
LCAyMDIwIGF0IDEwOjQ4OjM3QU0gKzA4MDAsIFpoYW5nZmVpIEdhbyB3cm90ZToKPiA+ID4gK3N0
YXRpYyBpbnQgdWFjY2VfZm9wc19vcGVuKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxl
ICpmaWxlcCkKPiA+ID4gK3sKPiA+ID4gKwlzdHJ1Y3QgdWFjY2VfbW0gKnVhY2NlX21tID0gTlVM
TDsKPiA+ID4gKwlzdHJ1Y3QgdWFjY2VfZGV2aWNlICp1YWNjZTsKPiA+ID4gKwlzdHJ1Y3QgdWFj
Y2VfcXVldWUgKnE7Cj4gPiA+ICsJaW50IHJldCA9IDA7Cj4gPiA+ICsKPiA+ID4gKwl1YWNjZSA9
IHhhX2xvYWQoJnVhY2NlX3hhLCBpbWlub3IoaW5vZGUpKTsKPiA+ID4gKwlpZiAoIXVhY2NlKQo+
ID4gPiArCQlyZXR1cm4gLUVOT0RFVjsKPiA+ID4gKwo+ID4gPiArCWlmICghdHJ5X21vZHVsZV9n
ZXQodWFjY2UtPnBhcmVudC0+ZHJpdmVyLT5vd25lcikpCj4gPiA+ICsJCXJldHVybiAtRU5PREVW
Owo+ID4gV2h5IGFyZSB5b3UgdHJ5aW5nIHRvIGdyYWIgdGhlIG1vZHVsZSByZWZlcmVuY2Ugb2Yg
dGhlIHBhcmVudCBkZXZpY2U/Cj4gPiBXaHkgaXMgdGhhdCBuZWVkZWQgYW5kIHdoYXQgaXMgdGhh
dCBnb2luZyB0byBoZWxwIHdpdGggaGVyZT8KPiA+IAo+ID4gVGhpcyBzaG91bGRuJ3QgYmUgbmVl
ZGVkIGFzIHRoZSBtb2R1bGUgcmVmZXJlbmNlIG9mIHRoZSBvd25lciBvZiB0aGUKPiA+IGZpbGVv
cHMgZm9yIHRoaXMgbW9kdWxlIGlzIGluY3JlbWVudGVkLCBhbmQgdGhlICJwYXJlbnQiIG1vZHVs
ZSBkZXBlbmRzCj4gPiBvbiB0aGlzIG1vZHVsZSwgc28gaG93IGNvdWxkIGl0IGJlIHVubG9hZGVk
IHdpdGhvdXQgdGhpcyBjb2RlIGJlaW5nCj4gPiB1bmxvYWRlZD8KPiA+IAo+ID4gWWVzLCBpZiB5
b3UgYnVpbGQgdGhpcyBjb2RlIGludG8gdGhlIGtlcm5lbCBhbmQgdGhlICJwYXJlbnQiIGRyaXZl
ciBpcyBhCj4gPiBtb2R1bGUsIHRoZW4geW91IHdpbGwgbm90IGhhdmUgYSByZWZlcmVuY2UsIGJ1
dCB3aGVuIHlvdSByZW1vdmUgdGhhdAo+ID4gcGFyZW50IGRyaXZlciB0aGUgZGV2aWNlIHdpbGwg
YmUgcmVtb3ZlZCBhcyBpdCBoYXMgdG8gYmUgdW5yZWdpc3RlcmVkCj4gPiBiZWZvcmUgdGhhdCBw
YXJlbnQgZHJpdmVyIGNhbiBiZSByZW1vdmVkIGZyb20gdGhlIHN5c3RlbSwgcmlnaHQ/Cj4gPiAK
PiA+IE9yIHdoYXQgYW0gSSBtaXNzaW5nIGhlcmU/Cj4gVGhlIHJlZmNvdW50IGhlcmUgaXMgcHJl
dmVudGluZyBybW1vZCAicGFyZW50IiBtb2R1bGUgYWZ0ZXIgZmQgaXMgb3BlbmVkLAo+IHNpbmNl
IHVzZXIgZHJpdmVyIGhhcyBtbWFwIGtlcm5lbCBtZW1vcnkgdG8gdXNlciBzcGFjZSwgbGlrZSBt
bWlvLCB3aGljaCBtYXkKPiBzdGlsbCBpbi11c2UuCj4gCj4gV2l0aCB0aGUgcmVmY291bnQgcHJv
dGVjdGlvbiwgcm1tb2QgInBhcmVudCIgbW9kdWxlIHdpbGwgZmFpbCB1bnRpbAo+IGFwcGxpY2F0
aW9uIGZyZWUgdGhlIGZkLgo+IGxvZyBsaWtlOiBybW1vZDogRVJST1I6IE1vZHVsZSBoaXNpX3pp
cCBpcyBpbiB1c2UKCkJ1dCBpZiB0aGUgInBhcmVudCIgbW9kdWxlIGlzIHRvIGJlIHVubG9hZGVk
LCBpdCBoYXMgdG8gdW5yZWdpc3RlciB0aGUKImNoaWxkIiBkZXZpY2UgYW5kIHRoYXQgd2lsbCBj
YWxsIHRoZSBkZXN0cnVjdG9yIGluIGhlcmUgYW5kIHRoZW4geW91CndpbGwgdGVhciBldmVyeXRo
aW5nIGRvd24gYW5kIGFsbCBzaG91bGQgYmUgZ29vZC4KClRoZXJlJ3Mgbm8gbmVlZCB0byAiZm9y
YmlkIiBhIG1vZHVsZSBmcm9tIGJlaW5nIHVubG9hZGVkLCBldmVuIGlmIGl0IGlzCmJlaW5nIHVz
ZWQuICBMb29rIGF0IGFsbCBuZXR3b3JraW5nIGRyaXZlcnMsIHRoZXkgd29yayB0aGF0IHdheSwg
cmlnaHQ/Cgo+ID4gPiArc3RhdGljIHZvaWQgdWFjY2VfcmVsZWFzZShzdHJ1Y3QgZGV2aWNlICpk
ZXYpCj4gPiA+ICt7Cj4gPiA+ICsJc3RydWN0IHVhY2NlX2RldmljZSAqdWFjY2UgPSB0b191YWNj
ZV9kZXZpY2UoZGV2KTsKPiA+ID4gKwo+ID4gPiArCWtmcmVlKHVhY2NlKTsKPiA+ID4gKwl1YWNj
ZSA9IE5VTEw7Cj4gPiBUaGF0IGxpbmUgZGlkbid0IGRvIGFueXRoaW5nIDopCj4gWWVzLCB0aGlz
IGlzIGEgbWlzdGFrZS4KPiBJdCBpcyB1cCB0byBjYWxsZXIgdG8gc2V0IHRvIE5VTEwgdG8gcHJl
dmVudCByZWxlYXNlIG11bHRpIHRpbWVzLgoKUmVsZWFzZSBmdW5jdGlvbiBpcyBjYWxsZWQgYnkg
dGhlIGRyaXZlciBjb3JlIHdoaWNoIHdpbGwgbm90IHRvdWNoIHRoZQp2YWx1ZSBhZ2Fpbi4KCnRo
YW5rcywKCmdyZWcgay1oCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21t
dQ==
