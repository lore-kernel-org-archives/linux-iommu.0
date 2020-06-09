Return-Path: <SRS0=PnSl=7W=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF4DC433E0
	for <iommu@archiver.kernel.org>; Tue,  9 Jun 2020 09:15:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9063A207ED
	for <iommu@archiver.kernel.org>; Tue,  9 Jun 2020 09:15:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9063A207ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 613848869E;
	Tue,  9 Jun 2020 09:15:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MZGQ+NSCnUhU; Tue,  9 Jun 2020 09:15:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3CE3388622;
	Tue,  9 Jun 2020 09:15:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E00DC0863;
	Tue,  9 Jun 2020 09:15:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4869AC016F
 for <iommu@lists.linux-foundation.org>; Tue,  9 Jun 2020 09:15:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 36970878A4
 for <iommu@lists.linux-foundation.org>; Tue,  9 Jun 2020 09:15:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XNOdfyAll1+s for <iommu@lists.linux-foundation.org>;
 Tue,  9 Jun 2020 09:15:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BB46B87899
 for <iommu@lists.linux-foundation.org>; Tue,  9 Jun 2020 09:15:27 +0000 (UTC)
Received: from mail-qt1-f176.google.com ([209.85.160.176]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MrPRB-1jC1DX27F9-00oWT1 for <iommu@lists.linux-foundation.org>; Tue, 09
 Jun 2020 11:15:24 +0200
Received: by mail-qt1-f176.google.com with SMTP id g62so13484869qtd.5
 for <iommu@lists.linux-foundation.org>; Tue, 09 Jun 2020 02:15:24 -0700 (PDT)
X-Gm-Message-State: AOAM533motmXgHAG/SnKNF8oU5X4KDfkMVPSAlV9IMbI7jgRieWOMpi9
 LlHtfBGSAn+8wfdzhFQg1WHwOnzotx8zvmckPtI=
X-Google-Smtp-Source: ABdhPJwLEIiew7LT85XJ7YMwfJX7yhLUFVtBnCDqoIKOxdCKDHjqNlOaWp8DLPqmET9skm0FQ81wStwRswqY7BJG62c=
X-Received: by 2002:ac8:4742:: with SMTP id k2mr27989059qtp.304.1591694122865; 
 Tue, 09 Jun 2020 02:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200608164148.GA1394249@bjorn-Precision-5520>
 <bcf0a327-87b5-01ff-2f9c-ec6a6bd6c738@linaro.org>
In-Reply-To: <bcf0a327-87b5-01ff-2f9c-ec6a6bd6c738@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 9 Jun 2020 11:15:06 +0200
X-Gmail-Original-Message-ID: <CAK8P3a38bhE_VO_eVcsfsGKgED=gmSEntQmrhwbLkeA6Si0qaw@mail.gmail.com>
Message-ID: <CAK8P3a38bhE_VO_eVcsfsGKgED=gmSEntQmrhwbLkeA6Si0qaw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Introduce PCI_FIXUP_IOMMU
To: Zhangfei Gao <zhangfei.gao@linaro.org>
X-Provags-ID: V03:K1:Z7QDHkjtvTeWRlAca7ZNzesocwpIy6CNSrWwKfwAfBCh8/o2gPc
 3RVLi3AnZxd4tNYL52EiN55b24LEDzF20Iu8RNAZuSvYSG2BMlZPvPAYQzC0SzOoWhPLvVU
 iM1begJdoYS2jEkQPg2SLunBC8hkIF19Q0liY8y56R9BDX4IjlKvcmBYkHatP9Pe21mjaWb
 57+/xJN765DOipG2Azoow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bGZ4/34oayk=:4QFv0pd412jYEvVxJEIGhJ
 bASZiOjviRZF0ILvOOtX97mQUfftF8zSPL2Mo6AmL96okQkLNNLp2x0UsZDW37y7Mbs7OP+yI
 Omy/O/VxCLJBRaxb8yP+Nkxi+tKc+1s6e3qSBTUPEbUT2/JnGaGG1HAGIzfd3cNdwvuZiHL+h
 U/fWVfPVLe5Canqtbqfl/0u2UqS46WWT2PEogNPHNX4Q35sMbu2BZlhaUz7I2uAZtO65LIqlL
 nanPuSeWxQd17YHp7ArBjWCdtG1yK6p/2JHHocLV6tFWqaWTPVXxUxCv3XXIIhaOmBIdagWT0
 D7T9V6r3sl/hfw9cajKR7iclMmFO9tXdM11s+G4zZWAFkImRB6UWFYNuTN6Pf3JRtYQWIBXqt
 RCiRcx10EwxoHiYZlO9kSIYnefUDeZII/TYJePzuKQYojokIs10mDNONWbzFln8OGEuVMb2Om
 JR8scL2E4gwdRO7NXgdDoEFWBEcGe2HMZUBnP0JQ7Wz4BYuRq06/s329O1d1TYDWzRZifuiWT
 bzznB4ReAWQ0SZoz7+4hve0NxcjQCpA0ROdruKraiGwhMSP1faJ42KvVbP/yf+MqgkFwlmAPl
 CkUozjVIAyJYFwyqEuzwhMl8pedwz3vnyXq4n5/QSVtUSA2eJDJXQha1zapHLhi1VcSavfX2s
 tZEZIduFmQMDuDb1tULEUoI1ZalVIpWz7Eml1Ib1WBPJo2cFJBUf4y9G7Vfj7lmtdGtR0aoHT
 6cVgv+43ktILfGC9n/5VzgUFllKYW+8smNDUOd2ZIuSF0IHzZuGy23NfgvN4E5VE61HzRZJWT
 20sOo+ZFptKbl41hr/pu+lswZqZKifwhSkPayRBgLnCfWnBk/k=
Cc: jean-philippe <jean-philippe@linaro.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 linux-pci <linux-pci@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hanjun Guo <guohanjun@huawei.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, kenneth-lee-2012@foxmail.com,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, Len Brown <lenb@kernel.org>
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

T24gVHVlLCBKdW4gOSwgMjAyMCBhdCA2OjAyIEFNIFpoYW5nZmVpIEdhbyA8emhhbmdmZWkuZ2Fv
QGxpbmFyby5vcmc+IHdyb3RlOgo+IE9uIDIwMjAvNi85IOS4iuWNiDEyOjQxLCBCam9ybiBIZWxn
YWFzIHdyb3RlOgo+ID4gT24gTW9uLCBKdW4gMDgsIDIwMjAgYXQgMTA6NTQ6MTVBTSArMDgwMCwg
WmhhbmdmZWkgR2FvIHdyb3RlOgo+ID4+IE9uIDIwMjAvNi82IOS4iuWNiDc6MTksIEJqb3JuIEhl
bGdhYXMgd3JvdGU6Cj4gPj4+PiArKysgYi9kcml2ZXJzL2lvbW11L2lvbW11LmMKPiA+Pj4+IEBA
IC0yNDE4LDYgKzI0MTgsMTAgQEAgaW50IGlvbW11X2Z3c3BlY19pbml0KHN0cnVjdCBkZXZpY2Ug
KmRldiwgc3RydWN0Cj4gPj4+PiBmd25vZGVfaGFuZGxlICppb21tdV9md25vZGUsCj4gPj4+PiAg
ICAgICAgICAgZndzcGVjLT5pb21tdV9md25vZGUgPSBpb21tdV9md25vZGU7Cj4gPj4+PiAgICAg
ICAgICAgZndzcGVjLT5vcHMgPSBvcHM7Cj4gPj4+PiAgICAgICAgICAgZGV2X2lvbW11X2Z3c3Bl
Y19zZXQoZGV2LCBmd3NwZWMpOwo+ID4+Pj4gKwo+ID4+Pj4gKyAgICAgICBpZiAoZGV2X2lzX3Bj
aShkZXYpKQo+ID4+Pj4gKyAgICAgICAgICAgICAgIHBjaV9maXh1cF9kZXZpY2UocGNpX2ZpeHVw
X2ZpbmFsLCB0b19wY2lfZGV2KGRldikpOwo+ID4+Pj4gKwo+ID4+Pj4KPiA+Pj4+IFRoZW4gcGNp
X2ZpeHVwX2ZpbmFsIHdpbGwgYmUgY2FsbGVkIHR3aWNlLCB0aGUgZmlyc3QgaW4gcGNpX2J1c19h
ZGRfZGV2aWNlLgo+ID4+Pj4gSGVyZSBpbiBpb21tdV9md3NwZWNfaW5pdCBpcyB0aGUgc2Vjb25k
IHRpbWUsIHNwZWNpZmljYWxseSBmb3IgaW9tbXVfZndzcGVjLgo+ID4+Pj4gV2lsbCBzZW5kIHRo
aXMgd2hlbiA1LjgtcmMxIGlzIG9wZW4uCj4gPj4+IFdhaXQsIHRoaXMgd2hvbGUgZml4dXAgYXBw
cm9hY2ggc2VlbXMgd3JvbmcgdG8gbWUuICBObyBtYXR0ZXIgaG93IHlvdQo+ID4+PiBkbyB0aGUg
Zml4dXAsIGl0J3Mgc3RpbGwgYSBmaXh1cCwgd2hpY2ggbWVhbnMgaXQgcmVxdWlyZXMgb25nb2lu
Zwo+ID4+PiBtYWludGVuYW5jZS4gIFN1cmVseSB3ZSBkb24ndCB3YW50IHRvIGhhdmUgdG8gYWRk
IHRoZSBWZW5kb3IvRGV2aWNlIElECj4gPj4+IGZvciBldmVyeSBuZXcgQU1CQSBkZXZpY2UgdGhh
dCBjb21lcyBhbG9uZywgZG8gd2U/Cj4gPj4+Cj4gPj4gSGVyZSB0aGUgZmFrZSBwY2kgZGV2aWNl
IGhhcyBzdGFuZGFyZCBQQ0kgY2ZnIHNwYWNlLCBidXQgcGh5c2ljYWwKPiA+PiBpbXBsZW1lbnRh
dGlvbiBpcyBiYXNlIG9uIEFNQkEKPiA+PiBUaGV5IGNhbiBwcm92aWRlIHBhc2lkIGZlYXR1cmUu
Cj4gPj4gSG93ZXZlciwKPiA+PiAxLCBkb2VzIG5vdCBzdXBwb3J0IHRscCBzaW5jZSB0aGV5IGFy
ZSBub3QgcmVhbCBwY2kgZGV2aWNlcy4KPiA+PiAyLiBkb2VzIG5vdCBzdXBwb3J0IHByaSwgaW5z
dGVhZCBzdXBwb3J0IHN0YWxsIChwcm92aWRlZCBieSBzbW11KQo+ID4+IEFuZCBzdGFsbCBpcyBu
b3QgYSBwY2kgZmVhdHVyZSwgc28gaXQgaXMgbm90IGRlc2NyaWJlZCBpbiBzdHJ1Y3QgcGNpX2Rl
diwKPiA+PiBidXQgaW4gc3RydWN0IGlvbW11X2Z3c3BlYy4KPiA+PiBTbyB3ZSB1c2UgdGhpcyBm
aXh1cCB0byB0ZWxsIHBjaSBzeXN0ZW0gdGhhdCB0aGUgZGV2aWNlcyBjYW4gc3VwcG9ydCBzdGFs
bCwKPiA+PiBhbmQgaGVyZWJ5IHN1cHBvcnQgcGFzaWQuCj4gPiBUaGlzIGRpZCBub3QgYW5zd2Vy
IG15IHF1ZXN0aW9uLiAgQXJlIHlvdSBwcm9wb3NpbmcgdGhhdCB3ZSB1cGRhdGUgYQo+ID4gcXVp
cmsgZXZlcnkgdGltZSBhIG5ldyBBTUJBIGRldmljZSBpcyByZWxlYXNlZD8gIEkgZG9uJ3QgdGhp
bmsgdGhhdAo+ID4gd291bGQgYmUgYSBnb29kIG1vZGVsLgo+Cj4gWWVzLCB5b3UgYXJlIHJpZ2h0
LCBidXQgd2UgZG8gbm90IGhhdmUgYW55IGJldHRlciBpZGVhIHlldC4KPiBDdXJyZW50bHkgd2Ug
aGF2ZSB0aHJlZSBmYWtlIHBjaSBkZXZpY2VzLCB3aGljaCBzdXBwb3J0IHN0YWxsIGFuZCBwYXNp
ZC4KPiBXZSBoYXZlIHRvIGxldCBwY2kgc3lzdGVtIGtub3cgdGhlIGRldmljZSBjYW4gc3VwcG9y
dCBwYXNpZCwgYmVjYXVzZSBvZgo+IHN0YWxsIGZlYXR1cmUsIHRob3VnaCBub3Qgc3VwcG9ydCBw
cmkuCj4gRG8geW91IGhhdmUgYW55IG90aGVyIGlkZWFzPwoKSXQgc291bmRzIGxpa2UgdGhlIGJl
c3Qgd2F5IHdvdWxkIGJlIHRvIGFsbG9jYXRlIGEgUENJIGNhcGFiaWxpdHkgZm9yIGl0LCBzbwpk
ZXRlY3Rpb24gY2FuIGJlIGRvbmUgdGhyb3VnaCBjb25maWcgc3BhY2UsIGF0IGxlYXN0IGluIGZ1
dHVyZSBkZXZpY2VzLApvciBwb3NzaWJseSBhZnRlciBhIGZpcm13YXJlIHVwZGF0ZSBpZiB0aGUg
Y29uZmlnIHNwYWNlIGluIHlvdXIgc3lzdGVtCmlzIGNvbnRyb2xsZWQgYnkgZmlybXdhcmUgc29t
ZXdoZXJlLiAgT25jZSB0aGVyZSBpcyBhIHByb3BlciBtZWNoYW5pc20KdG8gZG8gdGhpcywgdXNp
bmcgZml4dXBzIHRvIGRldGVjdCB0aGUgZWFybHkgZGV2aWNlcyB0aGF0IGRvbid0IHVzZSB0aGF0
CnNob3VsZCBiZSB1bmNvbnRyb3ZlcnNpYWwuIEkgaGF2ZSBubyBpZGVhIHdoYXQgdGhlIHByb2Nl
c3Mgb3IgdGltZWxpbmUKaXMgdG8gYWRkIG5ldyBjYXBhYmlsaXRpZXMgaW50byB0aGUgUENJZSBz
cGVjaWZpY2F0aW9uLCBvciBpZiB0aGlzIG9uZQp3b3VsZCBiZSBhY2NlcHRhYmxlIHRvIHRoZSBQ
Q0kgU0lHIGF0IGFsbC4KCklmIGRldGVjdGlvbiBjYW5ub3QgYmUgZG9uZSB0aHJvdWdoIFBDSSBj
b25maWcgc3BhY2UsIHRoZSBuZXh0IGJlc3QKYWx0ZXJuYXRpdmUgaXMgdG8gcGFzcyBhdXhpbGlh
cnkgZGF0YSB0aHJvdWdoIGZpcm13YXJlLiBPbiBEVCBiYXNlZAptYWNoaW5lcywgeW91IGNhbiBs
aXN0IG5vbi1ob3RwbHVnZ2FibGUgUENJZSBkZXZpY2VzIGFuZCBhZGQgY3VzdG9tCnByb3BlcnRp
ZXMgdGhhdCBjb3VsZCBiZSByZWFkIGR1cmluZyBkZXZpY2UgZW51bWVyYXRpb24uIEkgYXNzdW1l
CkFDUEkgaGFzIHNvbWV0aGluZyBzaW1pbGFyLCBidXQgSSBoYXZlIG5vdCBkb25lIHRoYXQuCgog
ICAgICBBcm5kCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
