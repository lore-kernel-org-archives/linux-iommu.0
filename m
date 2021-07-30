Return-Path: <SRS0=GV0T=MW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35868C4338F
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 12:18:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCC4361077
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 12:18:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CCC4361077
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A07BF605ED;
	Fri, 30 Jul 2021 12:18:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5RMvriE0k570; Fri, 30 Jul 2021 12:18:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 84C6F605AB;
	Fri, 30 Jul 2021 12:18:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5EB37C0010;
	Fri, 30 Jul 2021 12:18:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34536C000E
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 12:18:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 23186605BE
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 12:18:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S4jY7wSzhx9E for <iommu@lists.linux-foundation.org>;
 Fri, 30 Jul 2021 12:18:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 538D0605AB
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 12:18:37 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 15BF261074;
 Fri, 30 Jul 2021 12:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627647516;
 bh=xfVOdRGPI0p8bvTjQzrdr1McYn1rjKDlbhisGOum8GE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LuF6zMJ6dfL7TMZBi73lFlpB+FdR+5ckY/pjV8WLSQ2/LyqHdWq0dvO70cpPMyZWI
 NSUbMoem02ehuRZWAWtbz81FG8UnrL5lfaHoicK6rUjZOzJHoQ7Wqwhr0Cx7QvEmce
 HXQ0i02aJvP/UUuMhJINZh9au6V4yWxQdZ4K6mP4B3ECxFtC/EW5neaKcc2p8JjHHk
 Xd6tXq4gIG84qm21e33ubyQ27r6f87nP22O90l7YawT3g2CooarltCyAMlvTB4t1Rw
 d7m/A0QJs2HhBukm4OZCnk6S0mcWK6o90ZiRIuW8V4GWfolJk/ROKaKrh3Id1h4uDh
 HRgkjLMKem9fA==
Date: Fri, 30 Jul 2021 13:18:31 +0100
From: Will Deacon <will@kernel.org>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v2 2/5] iommu: Implement of_iommu_get_resv_regions()
Message-ID: <20210730121831.GD23589@willie-the-truck>
References: <20210423163234.3651547-1-thierry.reding@gmail.com>
 <20210423163234.3651547-3-thierry.reding@gmail.com>
 <bdc42077-d1f3-f561-2e4d-647b5fceb7b6@gmail.com>
 <CAL_Jsq+jSY-OLau3gLPsDL02AYaE_TySOGrd9-tNLFaYvLHZ6A@mail.gmail.com>
 <7f5c8094-6e4f-5a94-2257-1003a78ba92f@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7f5c8094-6e4f-5a94-2257-1003a78ba92f@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 linux-tegra <linux-tegra@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>
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

T24gU2F0LCBKdWwgMTcsIDIwMjEgYXQgMDI6MDc6MTJQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+IDE2LjA3LjIwMjEgMTc6NDEsIFJvYiBIZXJyaW5nINC/0LjRiNC10YI6Cj4gPiBP
biBGcmksIEp1bCAyLCAyMDIxIGF0IDg6MDUgQU0gRG1pdHJ5IE9zaXBlbmtvIDxkaWdldHhAZ21h
aWwuY29tPiB3cm90ZToKPiA+Pgo+ID4+IDIzLjA0LjIwMjEgMTk6MzIsIFRoaWVycnkgUmVkaW5n
INC/0LjRiNC10YI6Cj4gPj4+ICt2b2lkIG9mX2lvbW11X2dldF9yZXN2X3JlZ2lvbnMoc3RydWN0
IGRldmljZSAqZGV2LCBzdHJ1Y3QgbGlzdF9oZWFkICpsaXN0KQo+ID4+PiArewo+ID4+PiArICAg
ICBzdHJ1Y3Qgb2ZfcGhhbmRsZV9pdGVyYXRvciBpdDsKPiA+Pj4gKyAgICAgaW50IGVycjsKPiA+
Pj4gKwo+ID4+PiArICAgICBvZl9mb3JfZWFjaF9waGFuZGxlKCZpdCwgZXJyLCBkZXYtPm9mX25v
ZGUsICJtZW1vcnktcmVnaW9uIiwgIiNtZW1vcnktcmVnaW9uLWNlbGxzIiwgMCkgewo+ID4+PiAr
ICAgICAgICAgICAgIHN0cnVjdCBpb21tdV9yZXN2X3JlZ2lvbiAqcmVnaW9uOwo+ID4+PiArICAg
ICAgICAgICAgIHN0cnVjdCBvZl9waGFuZGxlX2FyZ3MgYXJnczsKPiA+Pj4gKyAgICAgICAgICAg
ICBzdHJ1Y3QgcmVzb3VyY2UgcmVzOwo+ID4+PiArCj4gPj4+ICsgICAgICAgICAgICAgYXJncy5h
cmdzX2NvdW50ID0gb2ZfcGhhbmRsZV9pdGVyYXRvcl9hcmdzKCZpdCwgYXJncy5hcmdzLCBNQVhf
UEhBTkRMRV9BUkdTKTsKPiA+Pj4gKwo+ID4+PiArICAgICAgICAgICAgIGVyciA9IG9mX2FkZHJl
c3NfdG9fcmVzb3VyY2UoaXQubm9kZSwgMCwgJnJlcyk7Cj4gPj4+ICsgICAgICAgICAgICAgaWYg
KGVyciA8IDApIHsKPiA+Pj4gKyAgICAgICAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiZmFp
bGVkIHRvIHBhcnNlIG1lbW9yeSByZWdpb24gJXBPRjogJWRcbiIsCj4gPj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGl0Lm5vZGUsIGVycik7Cj4gPj4+ICsgICAgICAgICAgICAgICAg
ICAgICBjb250aW51ZTsKPiA+Pj4gKyAgICAgICAgICAgICB9Cj4gPj4+ICsKPiA+Pj4gKyAgICAg
ICAgICAgICBpZiAoYXJncy5hcmdzX2NvdW50ID4gMCkgewo+ID4+PiArICAgICAgICAgICAgICAg
ICAgICAgLyoKPiA+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAqIEFjdGl2ZSBtZW1vcnkgcmVn
aW9ucyBhcmUgZXhwZWN0ZWQgdG8gYmUgYWNjZXNzZWQgYnkgaGFyZHdhcmUgZHVyaW5nCj4gPj4+
ICsgICAgICAgICAgICAgICAgICAgICAgKiBib290IGFuZCBtdXN0IHRoZXJlZm9yZSBoYXZlIGFu
IGlkZW50aXR5IG1hcHBpbmcgY3JlYXRlZCBwcmlvciB0byB0aGUKPiA+Pj4gKyAgICAgICAgICAg
ICAgICAgICAgICAqIGRyaXZlciB0YWtpbmcgY29udHJvbCBvZiB0aGUgaGFyZHdhcmUuIFRoaXMg
ZW5zdXJlcyB0aGF0IG5vbi1xdWllc2NlbnQKPiA+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAq
IGhhcmR3YXJlIGRvZXNuJ3QgY2F1c2UgSU9NTVUgZmF1bHRzIGR1cmluZyBib290Lgo+ID4+PiAr
ICAgICAgICAgICAgICAgICAgICAgICovCj4gPj4+ICsgICAgICAgICAgICAgICAgICAgICBpZiAo
YXJncy5hcmdzWzBdICYgTUVNT1JZX1JFR0lPTl9JREVOVElUWV9NQVBQSU5HKSB7Cj4gPj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlZ2lvbiA9IGlvbW11X2FsbG9jX3Jlc3ZfcmVn
aW9uKHJlcy5zdGFydCwgcmVzb3VyY2Vfc2l6ZSgmcmVzKSwKPiA+Pj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSU9NTVVfUkVB
RCB8IElPTU1VX1dSSVRFLAo+ID4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJT01NVV9SRVNWX0RJUkVDVF9SRUxBWEFCTEUp
Owo+ID4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoIXJlZ2lvbikKPiA+Pj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsKPiA+Pj4gKwo+
ID4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsaXN0X2FkZF90YWlsKCZyZWdpb24t
Pmxpc3QsIGxpc3QpOwo+ID4+PiArICAgICAgICAgICAgICAgICAgICAgfQo+ID4+PiArICAgICAg
ICAgICAgIH0KPiA+Pj4gKyAgICAgfQo+ID4+PiArfQo+ID4+PiArRVhQT1JUX1NZTUJPTChvZl9p
b21tdV9nZXRfcmVzdl9yZWdpb25zKTsKPiA+Pgo+ID4+IEFueSByZWFzb24gd2h5IHRoaXMgaXMg
bm90IEVYUE9SVF9TWU1CT0xfR1BMPyBJJ20gY3VyaW91cyB3aGF0IGlzIHRoZQo+ID4+IGxvZ2lj
IGJlaGluZCB0aGUgT0Ygc3ltYm9scyBpbiBnZW5lcmFsIHNpbmNlIGl0IGxvb2tzIGxpa2UgaGFs
ZiBvZiB0aGVtCj4gPj4gYXJlIEdQTC4KPiA+IAo+ID4gR2VuZXJhbGx5LCBuZXcgb25lcyBhcmUg
X0dQTC4gT2xkIG9uZXMgcHJvYmFibHkgcHJlZGF0ZSBfR1BMLgo+ID4gCj4gPiBUaGlzIG9uZSBp
cyB1cCB0byB0aGUgSU9NTVUgbWFpbnRhaW5lcnMuCj4gCj4gVGhhbmsgeW91LgoKSSBwcmVmZXIg
RVhQT1JUX1NZTUJPTF9HUEwoKS4gVGhhdCdzIGFsaWduZWQgd2l0aCB0aGUgc3ltYm9scyBleHBv
cnRlZCBieQppb21tdS5jLCB3aXRoIHRoZSAqc2luZ2xlKiBleGNlcHRpb24gb2YgZ2VuZXJpY19p
b21tdV9wdXRfcmVzdl9yZWdpb25zKCksCndoaWNoIEkgdGhpbmsgc2hvdWxkIGJlIGNoYW5nZWQg
dG8gX0dQTCgpIGFzIHdlbGwuCgpXaWxsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby9pb21tdQ==
