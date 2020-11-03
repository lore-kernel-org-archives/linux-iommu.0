Return-Path: <SRS0=TrXs=EJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC11C2D0A3
	for <iommu@archiver.kernel.org>; Tue,  3 Nov 2020 09:11:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9032022400
	for <iommu@archiver.kernel.org>; Tue,  3 Nov 2020 09:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAMGp/mk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9032022400
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B31A420518;
	Tue,  3 Nov 2020 09:11:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IDKhx9NW2lX9; Tue,  3 Nov 2020 09:11:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9715E20511;
	Tue,  3 Nov 2020 09:11:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B9A1C08A1;
	Tue,  3 Nov 2020 09:11:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7B56C0889
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 09:11:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A5EA686A6A
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 09:11:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DcfhUGwjFI4x for <iommu@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 09:11:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id EB7F0866A8
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 09:11:35 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5954A20756;
 Tue,  3 Nov 2020 09:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604394695;
 bh=dQIndgeTLK1wW9OhG7vuv+CmobIxjSeVOR2oEKxf3yY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GAMGp/mknNzSdHbit6sBOiTlzRo83dq3wBqosnQu0yRUx8T2cZ/iQ8YDQhOJXrUlT
 vC1fjUt5qLF8jlw9cNr0JT+z4sL/YdFtUJS6K3BA/J0bCxyswq8qugGossPOx209bq
 1zkdXyYvmdL773oOzDq6RCESYXXcOd74TyaNLtiM=
Date: Tue, 3 Nov 2020 09:11:30 +0000
From: Will Deacon <will@kernel.org>
To: Kunkun Jiang <jiangkunkun@huawei.com>
Subject: Re: Some questions about arm_lpae_install_table
Message-ID: <20201103091130.GA4403@willie-the-truck>
References: <6778678e-df81-f7e2-235d-6390ff6384ac@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6778678e-df81-f7e2-235d-6390ff6384ac@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: wanghaibin.wang@huawei.com, iommu@lists.linux-foundation.org,
 robin.murphy@arm.com, zhukeqian1@huawei.com
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

T24gVHVlLCBOb3YgMDMsIDIwMjAgYXQgMTE6MDA6MjdBTSArMDgwMCwgS3Vua3VuIEppYW5nIHdy
b3RlOgo+IFJlY2VudGx5LCBJIGhhdmUgcmVhZCBhbmQgbGVhcm5lZCB0aGUgY29kZSByZWxhdGVk
IHRvIGlvLXBndGFibGUtYXJtLmMuCj4gVGhlcmUKPiBhcmUgdHdvIHF1ZXN0aW9uIG9uIGFybV9s
cGFlX2luc3RhbGxfdGFibGUuCj4gCj4gMeOAgXRoZSBmaXJzdAo+IAo+ID4gc3RhdGljIGFybV9s
cGFlX2lvcHRlIGFybV9scGFlX2luc3RhbGxfdGFibGUoYXJtX2xwYWVfaW9wdGUgKnRhYmxlLAo+
ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhcm1fbHBhZV9pb3B0ZSAqcHRlcCwK
PiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYXJtX2xwYWVfaW9wdGUgY3VyciwK
PiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGlvX3BndGFibGVfY2Zn
ICpjZmcpCj4gPiB7Cj4gPiDCoMKgwqDCoMKgwqDCoCBhcm1fbHBhZV9pb3B0ZSBvbGQsIG5ldzsK
PiA+IAo+ID4gwqDCoMKgwqDCoMKgwqAgbmV3ID0gX19wYSh0YWJsZSkgfCBBUk1fTFBBRV9QVEVf
VFlQRV9UQUJMRTsKPiA+IMKgwqDCoMKgwqDCoMKgIGlmIChjZmctPnF1aXJrcyAmIElPX1BHVEFC
TEVfUVVJUktfQVJNX05TKQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5ldyB8
PSBBUk1fTFBBRV9QVEVfTlNUQUJMRTsKPiA+IAo+ID4gwqDCoMKgwqDCoMKgIC8qCj4gPiDCoMKg
wqDCoMKgwqDCoMKgICogRW5zdXJlIHRoZSB0YWJsZSBpdHNlbGYgaXMgdmlzaWJsZSBiZWZvcmUg
aXRzIFBURSBjYW4gYmUuCj4gPiDCoMKgwqDCoMKgwqDCoMKgICogV2hpbHN0IHdlIGNvdWxkIGdl
dCBhd2F5IHdpdGggY21weGNoZzY0X3JlbGVhc2UgYmVsb3csIHRoaXMKPiA+IMKgwqDCoMKgwqDC
oMKgwqAgKiBkb2Vzbid0IGhhdmUgYW55IG9yZGVyaW5nIHNlbWFudGljcyB3aGVuICFDT05GSUdf
U01QLgo+ID4gwqDCoMKgwqDCoMKgwqDCoCAqLwo+ID4gwqDCoMKgwqDCoMKgwqAgZG1hX3dtYigp
Owo+ID4gCj4gPiDCoMKgwqDCoMKgwqDCoCBvbGQgPSBjbXB4Y2hnNjRfcmVsYXhlZChwdGVwLCBj
dXJyLCBuZXcpOwo+ID4gCj4gPiDCoMKgwqDCoMKgwqDCoCBpZiAoY2ZnLT5jb2hlcmVudF93YWxr
IHx8IChvbGQgJiBBUk1fTFBBRV9QVEVfU1dfU1lOQykpCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcmV0dXJuIG9sZDsKPiA+IAo+ID4gwqDCoMKgwqDCoMKgwqAgLyogRXZlbiBp
ZiBpdCdzIG5vdCBvdXJzLCB0aGVyZSdzIG5vIHBvaW50IHdhaXRpbmc7IGp1c3Qga2ljayBpdAo+
ID4gKi8KPiA+IMKgwqDCoMKgwqDCoMKgIF9fYXJtX2xwYWVfc3luY19wdGUocHRlcCwgY2ZnKTsK
PiA+IMKgwqDCoMKgwqDCoMKgIGlmIChvbGQgPT0gY3VycikKPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBXUklURV9PTkNFKCpwdGVwLCBuZXcgfCBBUk1fTFBBRV9QVEVfU1dfU1lO
Qyk7Cj4gPiAKPiA+IMKgwqDCoMKgwqDCoMKgIHJldHVybiBvbGQ7Cj4gPiB9Cj4gCj4gSWYgYW5v
dGhlciB0aHJlYWQgY2hhbmdlcyB0aGUgcHRlcCBiZXR3ZWVuIGNtcHhjaGc2NF9yZWxheGVkIGFu
ZAo+IFdSSVRFX09OQ0UoKnB0ZXAsIG5ldyB8IEFSTV9MUEFFX1BURV9TV19TWU5DKSwgdGhlIG9w
ZXJhdGlvbgo+IFdSSVRFX09OQ0Ugd2lsbCBvdmVyd3JpdGUgdGhlIGNoYW5nZS4KCkNhbiB5b3Ug
cGxlYXNlIHByb3ZpZGUgYW4gZXhhbXBsZSBvZiBhIGNvZGUgcGF0aCB3aGVyZSB0aGlzIGhhcHBl
bnM/IFRoZQppZGVhIGlzIHRoYXQgQ1BVcyBjYW4gcmFjZSBvbiB0aGUgY21weGNoZygpLCBidXQg
dGhlcmUgd2lsbCBvbmx5IGJlIG9uZQp3aW5uZXIuCgo+IDLjgIF0aGUgc2Vjb25kCj4gCj4gPiBm
b3IgKGkgPSAwOyBpIDwgdGFibGVzeiAvIHNpemVvZihwdGUpOyBpKyssIGJsa19wYWRkciArPSBz
cGxpdF9zeikgewo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIFVubWFwISAq
Lwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChpID09IHVubWFwX2lkeCkK
PiA+IGNvbnRpbnVlOwo+ID4gCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX19h
cm1fbHBhZV9pbml0X3B0ZShkYXRhLCBibGtfcGFkZHIsIHB0ZSwgbHZsLAo+ID4gJnRhYmxlcFtp
XSk7Cj4gPiB9Cj4gPiAKPiA+IHB0ZSA9IGFybV9scGFlX2luc3RhbGxfdGFibGUodGFibGVwLCBw
dGVwLCBibGtfcHRlLCBjZmcpOwo+IAo+IFdoZW4gYWx0ZXJpbmcgYSB0cmFuc2xhdGlvbiB0YWJs
ZSBkZXNjcmlwdG9yIGluY2x1ZGUgc3BsaXQgYSBibG9jayBpbnRvCj4gY29uc3RpdHVlbnQgZ3Jh
bnVsZXMsIHRoZSBBcm12OC1BIGFuZCBTTU1VdjMgYXJjaGl0ZWN0dXJlcyByZXF1aXJlCj4gYSBi
cmVhay1iZWZvcmUtbWFrZSBwcm9jZWR1cmUuIEJ1dCBpbiB0aGUgZnVuY3Rpb24gYXJtX2xwYWVf
c3BsaXRfYmxrX3VubWFwLAo+IGl0IGNoYW5nZXMgYSBibG9jayBkZXNjcmlwdG9yIHRvIGFuIGVx
dWl2YWxlbnQgc3BhbiBvZiBwYWdlIHRyYW5zbGF0aW9ucwo+IGRpcmVjdGx5LiBJcyBpdCBhcHBy
b3ByaWF0ZSB0byBkbyBzbz8KCkJyZWFrLWJlZm9yZS1tYWtlIGRvZXNuJ3QgcmVhbGx5IHdvcmsg
Zm9yIHRoZSBTTU1VIGJlY2F1c2UgZmF1bHRzIGFyZQpnZW5lcmFsbHkgZmF0YWwuCgpBcmUgeW91
IHNlZWluZyBwcm9ibGVtcyBpbiBwcmFjdGljZSB3aXRoIHRoaXMgY29kZT8KCldpbGwKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBs
aXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
