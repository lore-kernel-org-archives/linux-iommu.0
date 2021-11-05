Return-Path: <SRS0=j10w=PY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB897C433F5
	for <iommu@archiver.kernel.org>; Fri,  5 Nov 2021 18:53:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70D1E6120D
	for <iommu@archiver.kernel.org>; Fri,  5 Nov 2021 18:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 70D1E6120D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 38CA6401B2;
	Fri,  5 Nov 2021 18:53:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3-Jv6FhDvnYX; Fri,  5 Nov 2021 18:53:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1A21240188;
	Fri,  5 Nov 2021 18:53:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EEE15C0012;
	Fri,  5 Nov 2021 18:53:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE742C000E
 for <iommu@lists.linux-foundation.org>; Fri,  5 Nov 2021 18:53:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9956E40190
 for <iommu@lists.linux-foundation.org>; Fri,  5 Nov 2021 18:53:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W-NKkB6ikLsg for <iommu@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 18:53:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D732440012
 for <iommu@lists.linux-foundation.org>; Fri,  5 Nov 2021 18:53:06 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0DA4861215;
 Fri,  5 Nov 2021 18:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636138386;
 bh=hV76Xvv6i74dZtaHM89S+SSEowZvftfggWJ/QqvgC9A=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=CWKwmniUzpPJBNFQqPVW84z1S1LeA9Ybf8lyPWOKfKteIJ/hJduQzc7aPDHTO9Xtu
 VgmaFnsGK2q0Q3NyhjpyjzImoy8AcZ67iCozwO35kfCVlJzxuNeCFMiBWhm+N1kFu7
 j9eNWuvKukTYliq0SGSdpe/IRRdHckZEPy7Foj7w9CsIM9dcy5b7N0Mh8ce77qauqr
 jh0EqjsyEPtUSqvckX2itIJXG6i/bKH2ygC2X6g/8qdvQzK0dXPyg1gslA0FFuh+RW
 lqzNKfqEJJ6/Bw/jcPokr12IGlU/85FUCO1zzDSxBxLyjq+QpH8x3xYaAZULuE2S+M
 433SIGs6Xb1uA==
Date: Fri, 5 Nov 2021 13:53:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: How to reduce PCI initialization from 5 s (1.5 s adding them to
 IOMMU groups)
Message-ID: <20211105185304.GA936068@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <de6706b2-4ea5-ce68-6b72-02090b98630f@molgen.mpg.de>
Cc: linux-pci@vger.kernel.org, x86@kernel.org,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>
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

T24gRnJpLCBOb3YgMDUsIDIwMjEgYXQgMTI6NTY6MDlQTSArMDEwMCwgUGF1bCBNZW56ZWwgd3Jv
dGU6Cj4gRGVhciBMaW51eCBmb2xrcywKPiAKPiAKPiBPbiBhIFBvd2VyRWRnZSBUNDQwLzAyMUtD
RCwgQklPUyAyLjExLjIgMDQvMjIvMjAyMSwgTGludXggNS4xMC43MCB0YWtlcwo+IGFsbW9zdCBm
aXZlIHNlY29uZHMgdG8gaW5pdGlhbGl6ZSBQQ0kuIEFjY29yZGluZyB0byB0aGUgdGltZXN0YW1w
cywgMS41IHMKPiBhcmUgZnJvbSBhc3NpZ25pbmcgdGhlIFBDSSBkZXZpY2VzIHRvIHRoZSAxNDIg
SU9NTVUgZ3JvdXBzLgo+IAo+IGBgYAo+ICQgbHNwY2kgfCB3YyAtbAo+IDI4MQo+ICQgZG1lc2cK
PiBb4oCmXQo+IFsgICAgMi45MTg0MTFdIFBDSTogVXNpbmcgaG9zdCBicmlkZ2Ugd2luZG93cyBm
cm9tIEFDUEk7IGlmIG5lY2Vzc2FyeSwgdXNlCj4gInBjaT1ub2NycyIgYW5kIHJlcG9ydCBhIGJ1
Zwo+IFsgICAgMi45MzM4NDFdIEFDUEk6IEVuYWJsZWQgNSBHUEVzIGluIGJsb2NrIDAwIHRvIDdG
Cj4gWyAgICAyLjk3MzczOV0gQUNQSTogUENJIFJvb3QgQnJpZGdlIFtQQzAwXSAoZG9tYWluIDAw
MDAgW2J1cyAwMC0xNl0pCj4gWyAgICAyLjk4MDM5OF0gYWNwaSBQTlAwQTA4OjAwOiBfT1NDOiBP
UyBzdXBwb3J0cyBbRXh0ZW5kZWRDb25maWcgQVNQTQo+IENsb2NrUE0gU2VnbWVudHMgTVNJIEhQ
WC1UeXBlM10KPiBbICAgIDIuOTg5NDU3XSBhY3BpIFBOUDBBMDg6MDA6IF9PU0M6IHBsYXRmb3Jt
IGRvZXMgbm90IHN1cHBvcnQgW0xUUl0KPiBbICAgIDIuOTk1NDUxXSBhY3BpIFBOUDBBMDg6MDA6
IF9PU0M6IE9TIG5vdyBjb250cm9scyBbUE1FIFBDSWVDYXBhYmlsaXR5XQo+IFsgICAgMy4wMDEz
OTRdIGFjcGkgUE5QMEEwODowMDogRkFEVCBpbmRpY2F0ZXMgQVNQTSBpcyB1bnN1cHBvcnRlZCwg
dXNpbmcKPiBCSU9TIGNvbmZpZ3VyYXRpb24KPiBbICAgIDMuMDEwNTExXSBQQ0kgaG9zdCBicmlk
Z2UgdG8gYnVzIDAwMDA6MDAKPiBb4oCmXQo+IFsgICAgNi4yMzM1MDhdIHN5c3RlbSAwMDowNTog
W2lvICAweDEwMDAtMHgxMGZlXSBoYXMgYmVlbiByZXNlcnZlZAo+IFsgICAgNi4yMzk0MjBdIHN5
c3RlbSAwMDowNTogUGx1ZyBhbmQgUGxheSBBQ1BJIGRldmljZSwgSURzIFBOUDBjMDIgKGFjdGl2
ZSkKPiBbICAgIDYuMjM5OTA2XSBwbnA6IFBuUCBBQ1BJOiBmb3VuZCA2IGRldmljZXMKCkZvciB+
MjgwIFBDSSBkZXZpY2VzLCAoNi4yNC0yLjkyKS8yODAgPSAwLjAxMiBzL2Rldi4gIE9uIG15IGxh
cHRvcCBJCmhhdmUgYWJvdXQgKC42Ni0uMzcpLzM2ID0gMC4wMDggcy9kZXYgKG9uIHY1LjQpLCBz
byBhYm91dCB0aGUgc2FtZQpiYWxscGFyay4KCkZhc3RlciB3b3VsZCBhbHdheXMgYmUgYmV0dGVy
LCBvZiBjb3Vyc2UuICBJIGFzc3VtZSB0aGlzIGlzIG5vdCByZWFsbHkKYSByZWdyZXNzaW9uPwoK
PiBbICAgIDYuOTg5MDE2XSBwY2kgMDAwMDpkNzowNS4wOiBkaXNhYmxlZCBib290IGludGVycnVw
dHMgb24gZGV2aWNlCj4gWzgwODY6MjAzNF0KPiBbICAgIDYuOTk2MDYzXSBQQ0k6IENMUyAwIGJ5
dGVzLCBkZWZhdWx0IDY0Cj4gWyAgICA3LjAwMDAwOF0gVHJ5aW5nIHRvIHVucGFjayByb290ZnMg
aW1hZ2UgYXMgaW5pdHJhbWZzLi4uCj4gWyAgICA3LjA2NTI4MV0gRnJlZWluZyBpbml0cmQgbWVt
b3J5OiA1MTM2Swo+IFvigKZdCj4gWyAgICA3LjA3OTA5OF0gRE1BUjogZG1hcjc6IFVzaW5nIFF1
ZXVlZCBpbnZhbGlkYXRpb24KPiBbICAgIDcuMDgzOTgzXSBwY2kgMDAwMDowMDowMC4wOiBBZGRp
bmcgdG8gaW9tbXUgZ3JvdXAgMAo+IFvigKZdCj4gWyAgICA4LjUzNzgwOF0gcGNpIDAwMDA6ZDc6
MTcuMTogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDE0MQoKSSBkb24ndCBoYXZlIHRoaXMgaW9tbXUg
c3R1ZmYgdHVybmVkIG9uIGFuZCBkb24ndCBrbm93IHdoYXQncwpoYXBwZW5pbmcgaGVyZS4KCj4g
SXMgdGhlcmUgYW55dGhpbmcgdGhhdCBjb3VsZCBiZSBkb25lIHRvIHJlZHVjZSB0aGUgdGltZT8K
PiAKPiAKPiBLaW5kIHJlZ2FyZHMsCj4gCj4gUGF1bApfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vaW9tbXU=
