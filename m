Return-Path: <SRS0=UGJ5=K3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A520EC47093
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 17:27:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EBFC613D2
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 17:27:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EBFC613D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1615E400F4;
	Tue,  1 Jun 2021 17:27:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OHYHiE2LdImx; Tue,  1 Jun 2021 17:27:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0335E402A9;
	Tue,  1 Jun 2021 17:27:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D63BEC000E;
	Tue,  1 Jun 2021 17:27:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 452F2C0001
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 17:27:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 336AA605D2
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 17:27:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dHis3IlSdZ91 for <iommu@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 17:27:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 674DE605AE
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 17:27:36 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B8336D;
 Tue,  1 Jun 2021 10:27:35 -0700 (PDT)
Received: from [10.57.73.64] (unknown [10.57.73.64])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C82713F719;
 Tue,  1 Jun 2021 10:27:34 -0700 (PDT)
Subject: Re: [PATCH 3/4] iommu/amd: Do not sync on page size changes
To: Nadav Amit <namit@vmware.com>
References: <20210502070001.1559127-1-namit@vmware.com>
 <20210502070001.1559127-5-namit@vmware.com>
 <f00bd0ce-e4a7-93c6-39ae-db19779b9331@arm.com>
 <F5D25BE7-FA34-4017-AA22-DDAB24F634BC@vmware.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <7e0b4b12-c68a-ff90-5d86-4ab88ddd7991@arm.com>
Date: Tue, 1 Jun 2021 18:27:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <F5D25BE7-FA34-4017-AA22-DDAB24F634BC@vmware.com>
Content-Language: en-GB
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Will Deacon <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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

T24gMjAyMS0wNi0wMSAxNzozOSwgTmFkYXYgQW1pdCB3cm90ZToKPiAKPiAKPj4gT24gSnVuIDEs
IDIwMjEsIGF0IDg6NTkgQU0sIFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5QGFybS5jb20+IHdy
b3RlOgo+Pgo+PiBPbiAyMDIxLTA1LTAyIDA3OjU5LCBOYWRhdiBBbWl0IHdyb3RlOgo+Pj4gRnJv
bTogTmFkYXYgQW1pdCA8bmFtaXRAdm13YXJlLmNvbT4KPj4+IFNvbWUgSU9NTVUgYXJjaGl0ZWN0
dXJlcyBwZXJmb3JtIGludmFsaWRhdGlvbnMgcmVnYXJkbGVzcyBvZiB0aGUgcGFnZQo+Pj4gc2l6
ZS4gSW4gc3VjaCBhcmNoaXRlY3R1cmVzIHRoZXJlIGlzIG5vIG5lZWQgdG8gc3luYyB3aGVuIHRo
ZSBwYWdlIHNpemUKPj4+IGNoYW5nZXMgb3IgdG8gcmVnYXJkIHBnc2l6ZSB3aGVuIG1ha2luZyBp
bnRlcmltIGZsdXNoIGluCj4+PiBpb21tdV9pb3RsYl9nYXRoZXJfYWRkX3BhZ2UoKS4KPj4+IEFk
ZCBhICJpZ25vcmVfZ2F0aGVyX3Bnc2l6ZSIgcHJvcGVydHkgZm9yIGVhY2ggSU9NTVUtb3BzIHRv
IGRlY2lkZQo+Pj4gd2hldGhlciBnYXRoZXIncyBwZ3NpemUgaXMgdHJhY2tlZCBhbmQgdHJpZ2dl
cnMgYSBmbHVzaC4KPj4KPj4gSSd2ZSBvYmplY3RlZCBiZWZvcmVbMV0sIGFuZCBJJ2xsIHJlYWRp
bHkgb2JqZWN0IGFnYWluIDspCj4+Cj4+IEkgc3RpbGwgdGhpbmsgaXQncyB2ZXJ5IHNpbGx5IHRv
IGFkZCBhIGJ1bmNoIG9mIGluZGlyZWN0aW9uIGFsbCBvdmVyIHRoZSBwbGFjZSB0byBtYWtlIGEg
aGVscGVyIGZ1bmN0aW9uIG5vdCBkbyB0aGUgbWFpbiB0aGluZyBpdCdzIGludGVuZGVkIHRvIGhl
bHAgd2l0aC4gSWYgeW91IG9ubHkgbmVlZCB0cml2aWFsIGFkZHJlc3MgZ2F0aGVyaW5nIHRoZW4g
aXQncyBmYXIgc2ltcGxlciB0byBqdXN0IGltcGxlbWVudCB0cml2aWFsIGFkZHJlc3MgZ2F0aGVy
aW5nLiBJIHN1cHBvc2UgaWYgeW91IHJlYWxseSB3YW50IHRvIHlvdSBjb3VsZCBmYWN0b3Igb3V0
IGFub3RoZXIgaGVscGVyIHRvIHNoYXJlIHRoZSA1IGxpbmVzIG9mIGNvZGUgd2hpY2ggZW5kZWQg
dXAgaW4gbXRrLWlvbW11IChzZWUgY29tbWl0IGYyMWFlM2IxMDA4NCkuCj4gCj4gVGhhbmtzLCBS
b2Jpbi4KPiAKPiBJIHJlYWQgeW91ciBjb21tZW50cyBidXQgSSBjYW5ub3QgZnVsbHkgdW5kZXJz
dGFuZCB0aGUgYWx0ZXJuYXRpdmUgdGhhdCB5b3UgcHJvcG9zZSwgYWx0aG91Z2ggSSBkbyB1bmRl
cnN0YW5kIHlvdXIgb2JqZWN0aW9uIHRvIHRoZSBpbmRpcmVjdGlvbiDigJxpZ25vcmVfZ2F0aGVy
X3Bnc2l6ZeKAnS4gV291bGQgaXQgYmUgb2sgaWYg4oCcaWdub3JlX2dhdGhlcl9wZ3NpemUiIHdh
cyBwcm92aWRlZCBhcyBhbiBhcmd1bWVudCBmb3IgaW9tbXVfaW90bGJfZ2F0aGVyX2FkZF9wYWdl
KCk/CgpObywgSSBtZWFuIGlmIGlvbW11X2lvdGxiX2dhdGhlcl9hZGRfcGFnZSgpIGRvZXNuJ3Qg
aGF2ZSB0aGUgYmVoYXZpb3VyIAp5b3VyIGRyaXZlciB3YW50cywganVzdCBkb24ndCBjYWxsIGl0
LiBXcml0ZSBvciBmYWN0b3Igb3V0IGEgc3VpdGFibGUgCmhlbHBlciB0aGF0ICpkb2VzKiBkbyB3
aGF0IHlvdSB3YW50IGFuZCBjYWxsIHRoYXQsIG9yIGp1c3QgaW1wbGVtZW50IHRoZSAKbG9naWMg
ZGlyZWN0bHkgaW5saW5lLiBJbmRpcmVjdCBhcmd1bWVudCBvciBub3QsIGl0IGp1c3QgZG9lc24n
dCBtYWtlIAptdWNoIHNlbnNlIHRvIGhhdmUgYSBoZWxwZXIgZnVuY3Rpb24gY2FsbCB3aGljaCBz
YXlzICJkbyB0aGlzIGV4Y2VwdCAKZG9uJ3QgZG8gbW9zdCBvZiBpdCIuCgo+IEluIGdlbmVyYWws
IEkgY2FuIGxpdmUgd2l0aG91dCB0aGlzIHBhdGNoLiBJdCBwcm9iYWJseSB3b3VsZCBoYXZlIG5l
Z2xpZ2VudCBpbXBhY3Qgb24gcGVyZm9ybWFuY2UgYW55aG93LgoKQXMgSSBpbXBsaWVkLCBpdCBz
b3VuZHMgbGlrZSB5b3VyIG5lZWRzIGFyZSB0aGUgc2FtZSBhcyB0aGUgTWVkaWF0ZWsgCmRyaXZl
ciBoYWQsIHNvIHlvdSBjb3VsZCByZWFkaWx5IGZhY3RvciBvdXQgYSBuZXcgcGFnZS1zaXplLWFn
bm9zdGljIApnYXRoZXIgaGVscGVyIGZyb20gdGhhdC4gSSBmdWxseSBzdXBwb3J0IG1ha2luZyB0
aGUgZnVuY3Rpb25hbCBjaGFuZ2UgdG8gCmFtZC1pb21tdSAqc29tZWhvdyogLSBub2JvZHkgbGlr
ZXMgdW5uZWNlc3Nhcnkgc3luY3MgLSBqdXN0IG5vdCB3aXRoIAp0aGlzIHBhcnRpY3VsYXIgaW1w
bGVtZW50YXRpb24gOikKClJvYmluLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vaW9tbXU=
