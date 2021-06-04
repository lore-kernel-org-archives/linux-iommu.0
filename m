Return-Path: <SRS0=eMD9=K6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF04C4743D
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 18:53:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72246610E5
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 18:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72246610E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3589983163;
	Fri,  4 Jun 2021 18:53:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wcx9QnxQnTgp; Fri,  4 Jun 2021 18:53:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id D626982AEF;
	Fri,  4 Jun 2021 18:53:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B42EBC000E;
	Fri,  4 Jun 2021 18:53:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92856C0001
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 18:53:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7EF72606F5
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 18:53:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bpaAVpdjJzwa for <iommu@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 18:53:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id B8F8960621
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 18:53:43 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFDE71063;
 Fri,  4 Jun 2021 11:53:37 -0700 (PDT)
Received: from [10.57.6.115] (unknown [10.57.6.115])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABB173F73D;
 Fri,  4 Jun 2021 11:53:36 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] iommu/amd: Enable page-selective flushes
To: Nadav Amit <nadav.amit@gmail.com>, Joerg Roedel <joro@8bytes.org>
References: <20210524224159.32807-1-namit@vmware.com>
 <YLpI7tKtsf4l5MlN@8bytes.org>
 <05098022-1ED6-44BE-931D-D16C2D0B2D09@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <2ea809ef-beb5-a2c9-0739-cb236cab196b@arm.com>
Date: Fri, 4 Jun 2021 19:53:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <05098022-1ED6-44BE-931D-D16C2D0B2D09@gmail.com>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
 Jiajun Cao <caojiajun@vmware.com>, linux-kernel@vger.kernel.org
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

T24gMjAyMS0wNi0wNCAxODoxMCwgTmFkYXYgQW1pdCB3cm90ZToKPiAKPiAKPj4gT24gSnVuIDQs
IDIwMjEsIGF0IDg6MzggQU0sIEpvZXJnIFJvZWRlbCA8am9yb0A4Ynl0ZXMub3JnPiB3cm90ZToK
Pj4KPj4gSGkgTmFkYXYsCj4+Cj4+IFtBZGRpbmcgUm9iaW5dCj4+Cj4+IE9uIE1vbiwgTWF5IDI0
LCAyMDIxIGF0IDAzOjQxOjU1UE0gLTA3MDAsIE5hZGF2IEFtaXQgd3JvdGU6Cj4+PiBOYWRhdiBB
bWl0ICg0KToKPj4+ICAgaW9tbXUvYW1kOiBGaXggd3JvbmcgcGFyZW50aGVzZXMgb24gcGFnZS1z
cGVjaWZpYyBpbnZhbGlkYXRpb25zCj4+Cj4+IFRoaXMgcGF0Y2ggaXMgYWxyZWFkeSB1cHN0cmVh
bSBpbiB2NS4xMy1yYzQuIFBsZWFzZSByZWJhc2UgdG8gdGhhdAo+PiB2ZXJzaW9uLgo+IAo+IEkg
Z3Vlc3MgaXQgd291bGQgYmUgcmM1IGJ5IHRoZSB0aW1lIEkgc2VuZCBpdC4KPiAKPj4KPj4+ICAg
aW9tbXUvYW1kOiBTZWxlY3RpdmUgZmx1c2ggb24gdW5tYXAKPj4+ICAgaW9tbXUvYW1kOiBEbyBu
b3Qgc3luYyBvbiBwYWdlIHNpemUgY2hhbmdlcwo+Pj4gICBpb21tdS9hbWQ6IERvIG5vdCB1c2Ug
Zmx1c2gtcXVldWUgd2hlbiBOcENhY2hlIGlzIG9uCj4+Cj4+IEFuZCBJIHRoaW5rIHRoZXJlIGhh
dmUgYmVlbiBvYmplY3Rpb25zIGZyb20gUm9iaW4gTXVycGh5IG9uIFBhdGNoIDMsCj4+IGhhdmUg
dGhvc2UgYmVlbiB3b3JrZWQgb3V0Pwo+IAo+IEkgYW0gc3RpbGwgd2FpdGluZyBmb3IgUm9iaW7i
gJlzIGZlZWRiYWNrIG9uIG15IHByb3Bvc2VkIGNoYW5nZXMuIElmIGhlIGRvZXMgbm90IHJlc3Bv
bmQgc29vbiwgSSB3aWxsIGRyb3AgdGhpcyBwYXRjaCBmb3Igbm93LgoKQXBvbG9naWVzLCBpdCBm
ZWVscyBsaWtlIEkndmUgc3BlbnQgbW9zdCBvZiB0aGlzIHdlZWsgZmlnaHRpbmcgZmlyZXMsCmFu
ZCBhIGdyZWF0IGRlYWwgb2YgZW1haWwgZ290IHNraW1tZWQgYW5kIG1lbnRhbGx5IGZpbGVkIHVu
ZGVyICJub3RoaW5nCnNvIHdyb25nIHRoYXQgSSBuZWVkIHRvIHJlc3BvbmQgaW1tZWRpYXRlbHki
Li4uCgpGV0lXIEkgd291bGQgaGF2ZSB3cml0dGVuIHRoZSBzaW1wbGVyIHBhdGNoIGJlbG93LCBi
dXQgYmV5b25kIHRoYXQgSQp0aGluayBpdCBtaWdodCBzdGFydCBkZXNjZW5kaW5nIGludG8gYmlr
ZXNoZWRkaW5nIC0gaWYgeW91IHN0aWxsIHByZWZlcgp5b3VyIG1vcmUgY29tcHJlaGVuc2l2ZSBy
ZWZhY3RvcmluZywgb3Igc29tZXRoaW5nIGluIGJldHdlZW4sIHRoZW4gZG9uJ3QKbGV0IG15IHBl
cnNvbmFsIHByZWZlcmVuY2UgaW4gc3R5bGUvY29tcGxleGl0eSB0cmFkZS1vZmZzIHN0YW5kIGlu
IHRoZQp3YXkgb2YgZ2V0dGluZyBhIHVzZWZ1bCBmdW5jdGlvbmFsIGNoYW5nZSBpbnRvIHRoZSBB
TUQgZHJpdmVyLiBXaGljaGV2ZXIKd2F5LCB0aG91Z2gsIEkgKmFtKiBub3cgc29sZCBvbiB0aGUg
aWRlYSBvZiBoYXZpbmcgc29tZSBrZXJuZWxkb2MgdG8KY2xhcmlmeSB0aGVzZSB0aGluZ3MuCgpU
aGFua3MsClJvYmluLgoKLS0tLS0+OC0tLS0tCkZyb206IFJvYmluIE11cnBoeSA8cm9iaW4ubXVy
cGh5QGFybS5jb20+ClN1YmplY3Q6IFtQQVRDSF0gaW9tbXU6IEltcHJvdmUgaW9tbXVfaW90bGJf
Z2F0aGVyIGhlbHBlcnMKClRoZSBNZWRpYXRlayBkcml2ZXIgaXMgbm90IHRoZSBvbmx5IG9uZSB3
aGljaCBtaWdodCB3YW50IGEgYmFzaWMKYWRkcmVzcy1iYXNlZCBnYXRoZXJpbmcgYmVoYXZpb3Vy
LCBzbyBhbHRob3VnaCBpdCdzIGFyZ3VhYmx5IHNpbXBsZQplbm91Z2ggdG8gb3Blbi1jb2RlLCBs
ZXQncyBmYWN0b3IgaXQgb3V0IGZvciB0aGUgc2FrZSBvZiBjbGVhbmxpbmVzcy4KTGV0J3MgYWxz
byB0YWtlIHRoaXMgb3Bwb3J0dW5pdHkgdG8gZG9jdW1lbnQgdGhlIGludGVudCBvZiB0aGVzZQpo
ZWxwZXJzIGZvciBjbGFyaXR5LgoKU2lnbmVkLW9mZi1ieTogUm9iaW4gTXVycGh5IDxyb2Jpbi5t
dXJwaHlAYXJtLmNvbT4KLS0tCiAgZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyB8ICA2ICstLS0t
LQogIGluY2x1ZGUvbGludXgvaW9tbXUuaCAgICAgfCAzMiArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKwogIDIgZmlsZXMgY2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jIGIvZHJpdmVycy9p
b21tdS9tdGtfaW9tbXUuYwppbmRleCBlMDZiOGEwZTJiNTYuLmNkNDU3NDg3Y2U4MSAxMDA2NDQK
LS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYworKysgYi9kcml2ZXJzL2lvbW11L210a19p
b21tdS5jCkBAIC01MjEsMTIgKzUyMSw4IEBAIHN0YXRpYyBzaXplX3QgbXRrX2lvbW11X3VubWFw
KHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiwKICAJCQkgICAgICBzdHJ1Y3QgaW9tbXVfaW90
bGJfZ2F0aGVyICpnYXRoZXIpCiAgewogIAlzdHJ1Y3QgbXRrX2lvbW11X2RvbWFpbiAqZG9tID0g
dG9fbXRrX2RvbWFpbihkb21haW4pOwotCXVuc2lnbmVkIGxvbmcgZW5kID0gaW92YSArIHNpemUg
LSAxOwogIAotCWlmIChnYXRoZXItPnN0YXJ0ID4gaW92YSkKLQkJZ2F0aGVyLT5zdGFydCA9IGlv
dmE7Ci0JaWYgKGdhdGhlci0+ZW5kIDwgZW5kKQotCQlnYXRoZXItPmVuZCA9IGVuZDsKKwlpb21t
dV9pb3RsYl9nYXRoZXJfYWRkX3JhbmdlKGdhdGhlciwgaW92YSwgc2l6ZSk7CiAgCXJldHVybiBk
b20tPmlvcC0+dW5tYXAoZG9tLT5pb3AsIGlvdmEsIHNpemUsIGdhdGhlcik7CiAgfQogIApkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9saW51eC9pb21tdS5oIGIvaW5jbHVkZS9saW51eC9pb21tdS5oCmlu
ZGV4IDMyZDQ0ODA1MGJmNy4uNWYwMzZlOTkxOTM3IDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4
L2lvbW11LmgKKysrIGIvaW5jbHVkZS9saW51eC9pb21tdS5oCkBAIC00OTcsNiArNDk3LDM4IEBA
IHN0YXRpYyBpbmxpbmUgdm9pZCBpb21tdV9pb3RsYl9zeW5jKHN0cnVjdCBpb21tdV9kb21haW4g
KmRvbWFpbiwKICAJaW9tbXVfaW90bGJfZ2F0aGVyX2luaXQoaW90bGJfZ2F0aGVyKTsKICB9CiAg
CisvKioKKyAqIGlvbW11X2lvdGxiX2dhdGhlcl9hZGRfcmFuZ2UgLSBHYXRoZXIgZm9yIGFkZHJl
c3MtYmFzZWQgVExCIGludmFsaWRhdGlvbgorICogQGdhdGhlcjogVExCIGdhdGhlciBkYXRhCisg
KiBAaW92YTogc3RhcnQgb2YgcGFnZSB0byBpbnZhbGlkYXRlCisgKiBAc2l6ZTogc2l6ZSBvZiBw
YWdlIHRvIGludmFsaWRhdGUKKyAqCisgKiBIZWxwZXIgZm9yIElPTU1VIGRyaXZlcnMgdG8gYnVp
bGQgYXJiaXRyYXJpbHktc2l6ZWQgaW52YWxpZGF0aW9uIGNvbW1hbmRzCisgKiB3aGVyZSBvbmx5
IHRoZSBhZGRyZXNzIHJhbmdlIG1hdHRlcnMsIGFuZCBzaW1wbHkgbWluaW1pc2luZyBpbnRlcm1l
ZGlhdGUKKyAqIHN5bmNzIGlzIHByZWZlcnJlZC4KKyAqLworc3RhdGljIGlubGluZSB2b2lkIGlv
bW11X2lvdGxiX2dhdGhlcl9hZGRfcmFuZ2Uoc3RydWN0IGlvbW11X2lvdGxiX2dhdGhlciAqZ2F0
aGVyLAorCQkJCQkJdW5zaWduZWQgbG9uZyBpb3ZhLCBzaXplX3Qgc2l6ZSkKK3sKKwl1bnNpZ25l
ZCBsb25nIGVuZCA9IGlvdmEgKyBzaXplIC0gMTsKKworCWlmIChnYXRoZXItPnN0YXJ0ID4gaW92
YSkKKwkJZ2F0aGVyLT5zdGFydCA9IGlvdmE7CisJaWYgKGdhdGhlci0+ZW5kIDwgZW5kKQorCQln
YXRoZXItPmVuZCA9IGVuZDsKK30KKworLyoqCisgKiBpb21tdV9pb3RsYl9nYXRoZXJfYWRkX3Bh
Z2UgLSBHYXRoZXIgZm9yIHBhZ2UtYmFzZWQgVExCIGludmFsaWRhdGlvbgorICogQGRvbWFpbjog
SU9NTVUgZG9tYWluIHRvIGJlIGludmFsaWRhdGVkCisgKiBAZ2F0aGVyOiBUTEIgZ2F0aGVyIGRh
dGEKKyAqIEBpb3ZhOiBzdGFydCBvZiBwYWdlIHRvIGludmFsaWRhdGUKKyAqIEBzaXplOiBzaXpl
IG9mIHBhZ2UgdG8gaW52YWxpZGF0ZQorICoKKyAqIEhlbHBlciBmb3IgSU9NTVUgZHJpdmVycyB0
byBidWlsZCBpbnZhbGlkYXRpb24gY29tbWFuZHMgYmFzZWQgb24gaW5kaXZpZHVhbAorICogcGFn
ZXMsIG9yIHdpdGggcGFnZSBzaXplL3RhYmxlIGxldmVsIGhpbnRzIHdoaWNoIGNhbm5vdCBiZSBn
YXRoZXJlZCBpZiB0aGV5CisgKiBkaWZmZXIuCisgKi8KICBzdGF0aWMgaW5saW5lIHZvaWQgaW9t
bXVfaW90bGJfZ2F0aGVyX2FkZF9wYWdlKHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiwKICAJ
CQkJCSAgICAgICBzdHJ1Y3QgaW9tbXVfaW90bGJfZ2F0aGVyICpnYXRoZXIsCiAgCQkJCQkgICAg
ICAgdW5zaWduZWQgbG9uZyBpb3ZhLCBzaXplX3Qgc2l6ZSkKLS0gCjIuMjUuMQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QK
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
