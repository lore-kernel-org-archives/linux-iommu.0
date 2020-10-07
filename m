Return-Path: <SRS0=58s/=DO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4BFC4363D
	for <iommu@archiver.kernel.org>; Wed,  7 Oct 2020 14:01:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E36D4205F4
	for <iommu@archiver.kernel.org>; Wed,  7 Oct 2020 14:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="KC9P+EoC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E36D4205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=semihalf.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 696A486356;
	Wed,  7 Oct 2020 14:01:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h4dxRmNeENHY; Wed,  7 Oct 2020 14:01:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A605D862FB;
	Wed,  7 Oct 2020 14:01:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8AB82C07FF;
	Wed,  7 Oct 2020 14:01:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49B40C0051
 for <iommu@lists.linux-foundation.org>; Wed,  7 Oct 2020 14:01:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 43A6786329
 for <iommu@lists.linux-foundation.org>; Wed,  7 Oct 2020 14:01:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H4WNE9qlyuLr for <iommu@lists.linux-foundation.org>;
 Wed,  7 Oct 2020 14:01:34 +0000 (UTC)
X-Greylist: delayed 00:06:10 by SQLgrey-1.7.6
Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com
 [209.85.219.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D0E0D862FB
 for <iommu@lists.linux-foundation.org>; Wed,  7 Oct 2020 14:01:33 +0000 (UTC)
Received: by mail-qv1-f65.google.com with SMTP id s17so1154925qvr.11
 for <iommu@lists.linux-foundation.org>; Wed, 07 Oct 2020 07:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=semihalf-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=QMj5Xs3AcMn+SJugShn3OP+lZCLx/hn0Ukl9O139KTw=;
 b=KC9P+EoCruIpIV+v+DapsON180SQ0hCh7OOQWdNFjQgTxktrrdab9O3vEMRarPeCuR
 9REwfePl5Kw2uui2sqj1PTkcOkyvnFIxagS0BblOk0lztEWCcDK0AlBRzyKDUBN/tJMG
 c41MbV6qqhMumg5cmt9bEMnbAevoypNzMADAhIoC9RB4fMOWIovHpsQ7Vin3irb2+ZEu
 mwKD/pSpQULyd12F/VSxg4pKqjs1ENux+uEbXrT+iOzXMQZaXJwsBXCMpzxZX7GGl4dH
 tp3T/sjlAoQ4k9ch6g2tcmLWRNDk90NKAD+id+xfjWT71Nd+kxRa6iKA8+6TDr8IXCLo
 YOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=QMj5Xs3AcMn+SJugShn3OP+lZCLx/hn0Ukl9O139KTw=;
 b=HrLagpnnltBJCaR/NCby1FWvmZNa4Lv4wqQTi997rfn8dyDK47gUCzSDdEc2a1GA8l
 0OW4ec7ymEwsMG1qyBTycC6DcNBpPrI16rM0XCKNV/+OOmzOq1KvEMorE05g73F9Fo0l
 wxPjQW0fgdWpxQauO4ObR1HFtBgCD45u2eUBrsfPMXIMcV1A9pY+yrkMmyHSEgU7Iyno
 yTq4HShZV9z+Ccj9Y5N94Vw3gjw22cRuYKmleTdhSraj4ye1lpR/EgC02IQsyOw8YG7h
 nqGGNk4qSyH/pS2f2Z2Qv3UVwKRNrzGkbm3ehoCA9+neqPJSshJ0oggJZW/g4L+fge67
 2Ngg==
X-Gm-Message-State: AOAM533ORw1UssLi+XnLoBK937yq8IeUGdA98MEBu/matdTmvi+iWQ4I
 0/e+x4bHtGAeZXO6wMDkIpuiq/fqRiBrDtlXo/29W4pMIpSdOg==
X-Google-Smtp-Source: ABdhPJwtaBnDn2/UIyN0jX+YcCE6dHNeZF5GxiQryPV1x0fJ0ruNxMHBEckT2fSaLd2hkvPPh1yJ59JurPTTHJ2kZ7A=
X-Received: by 2002:a0c:e054:: with SMTP id y20mr3439251qvk.30.1602078922225; 
 Wed, 07 Oct 2020 06:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200715070649.18733-1-tn@semihalf.com>
 <517BB937-1F18-4CCF-81BF-11777BB99779@traviangames.com>
In-Reply-To: <517BB937-1F18-4CCF-81BF-11777BB99779@traviangames.com>
From: Marcin Wojtas <mw@semihalf.com>
Date: Wed, 7 Oct 2020 15:55:09 +0200
Message-ID: <CAPv3WKe6jF5bMX-f3MacaOaOTVd_1ypZopm3uOynt4KL-VNQDw@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Add system mmu support for Armada-806
To: Denis Odintsov <d.odintsov@traviangames.com>
Cc: "hannah@marvell.com" <hannah@marvell.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "nadavh@marvell.com" <nadavh@marvell.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will@kernel.org" <will@kernel.org>,
 "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

SGkgRGVuaXMsCgpUaGFuayB5b3UgZm9yIHlvdXIgcmVwb3J0LgoKd3QuLCA2IHBhxbogMjAyMCBv
IDE3OjE3IERlbmlzIE9kaW50c292IDxkLm9kaW50c292QHRyYXZpYW5nYW1lcy5jb20+IG5hcGlz
YcWCKGEpOgo+Cj4gSGksCj4KPiA+IEFtIDE1LjA3LjIwMjAgdW0gMDk6MDYgc2NocmllYiBUb21h
c3ogTm93aWNraSA8dG5Ac2VtaWhhbGYuY29tPjoKPiA+Cj4gPiBUaGUgc2VyaWVzIGlzIG1lYW50
IHRvIHN1cHBvcnQgU01NVSBmb3IgQVA4MDYgYW5kIGEgd29ya2Fyb3VuZAo+ID4gZm9yIGFjY2Vz
c2luZyBBUk0gU01NVSA2NGJpdCByZWdpc3RlcnMgaXMgdGhlIGdpc3Qgb2YgaXQuCj4gPgo+ID4g
Rm9yIHRoZSByZWNvcmQsIEFQLTgwNiBjYW4ndCBhY2Nlc3MgU01NVSByZWdpc3RlcnMgd2l0aCA2
NGJpdCB3aWR0aC4KPiA+IFRoaXMgcGF0Y2hlcyBzcGxpdCB0aGUgcmVhZHEvd3JpdGVxIGludG8g
dHdvIDMyYml0IGFjY2Vzc2VzIGluc3RlYWQKPiA+IGFuZCB1cGRhdGUgRFQgYmluZGluZ3MuCj4g
Pgo+ID4gVGhlIHNlcmllcyB3YXMgc3VjY2Vzc2Z1bGx5IHRlc3RlZCBvbiBhIHZhbmlsbGEgdjUu
OC1yYzMga2VybmVsIGFuZAo+ID4gSW50ZWwgZTEwMDBlIFBDSWUgTklDLiBUaGUgc2FtZSBmb3Ig
cGxhdGZvcm0gZGV2aWNlcyBsaWtlIFNBVEEgYW5kIFVTQi4KPiA+Cj4gPiBGb3IgcmVmZXJlbmNl
LCBwcmV2aW91cyB2ZXJzaW9ucyBhcmUgbGlzdGVkIGJlbG93Ogo+ID4gVjE6IGh0dHBzOi8vbGtt
bC5vcmcvbGttbC8yMDE4LzEwLzE1LzM3Mwo+ID4gVjI6IGh0dHBzOi8vbGttbC5vcmcvbGttbC8y
MDE5LzcvMTEvNDI2Cj4gPiBWMzogaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMjAvNy8yLzExMTQK
PiA+Cj4KPiAxKSBBZnRlciBlbmFibGluZyBTTU1VIG9uIEFybWFkYSA4MDQwLCBhbmQgQVJNX1NN
TVVfRElTQUJMRV9CWVBBU1NfQllfREVGQVVMPXkgYnkgZGVmYXVsdCBpbiBrZXJuZWwgc2luY2Ug
OTU0YTAzYmUwMzNjN2NlZjgwZGRjMjMyZTdjYmRiMTdkZjczNTY2MywKPiBpbnRlcm5hbCBlTU1D
IGlzIHByZXZlbnRlZCBmcm9tIGJlaW5nIGluaXRpYWxpc2VkIChhcyB0aGVyZSBpcyBubyBpb21t
dXMgcHJvcGVydHkgZm9yIGFwX3NkaGNpMCkKPiBEaXNhYmxpbmcgIkRpc2FibGUgYnlwYXNzIGJ5
IGRlZmF1bHQiIG1ha2UgaXQgd29yaywgYnV0IHRoZSBwYXRjaCBoaWdobHkgc3VnZ2VzdCBkb2lu
ZyBpdCBwcm9wZXJseS4KPiBJIHdhc24ndCBhYmxlIHRvIGZpbmQgY29ycmVjdCBwYXRoIGZvciBh
cF9zZGhjaSBmb3IgaW9tbXVzIGluIGFueSBwdWJsaWNseSBhdmFpbGFibGUgZG9jdW1lbnRhdGlv
biwKPiB3b3VsZCBiZSBoaWdobHkgYXBwcmVjaWF0ZWQgYWRkcmVzc2VkIHByb3Blcmx5LCB0aGFu
ayB5b3UhCgpBY2NvcmRpbmcgdG8gbXkga25vd2xlZGdlIGFuZCB0aGUgZG9jcyBBUCBJTyBkZXZp
Y2VzIGNhbm5vdCBiZQp2aXJ0dWFsaXplZCwgb25seSBvbmVzIGNvbm5lY3RlZCB2aWEgQ1AxMTAv
Q1AxMTUuIFdlJ2QgbmVlZCB0byBjaGVjawp3aGF0IHNob3VsZCBiZSBkb25lIGluIHN1Y2ggY29u
ZmlndXJhdGlvbiBhbmQgZ2V0IGJhY2sgdG8geW91LgoKCj4KPiAyKSBTZWNvbmQgaXNzdWUgSSBn
b3QgKGJ0dyBJIGhhdmUgQ2xlYXJGb2cgR1QgOGsgYXJtYWRhLTgwNDAgYmFzZWQgYm9hcmQpIGlz
IG1wY2kgYXRoMTBrIGNhcmQuCj4gSXQgaXMgZm91bmQsIGl0IGlzIGVudW1lcmF0ZWQsIGl0IGlz
IHZpc2libGUgaW4gbHNwY2ksIGJ1dCBpdCBmYWlscyB0byBiZSBpbml0aWFsaXNlZC4gSGVyZSBp
cyB0aGUgbG9nOgo+Cj4gWyAgICAxLjc0Mzc1NF0gYXJtYWRhOGstcGNpZSBmMjYwMDAwMC5wY2ll
OiBob3N0IGJyaWRnZSAvY3AwL3BjaWVAZjI2MDAwMDAgcmFuZ2VzOgo+IFsgICAgMS43NTExMTZd
IGFybWFkYThrLXBjaWUgZjI2MDAwMDAucGNpZTogICAgICBNRU0gMHgwMGY2MDAwMDAwLi4weDAw
ZjZlZmZmZmYgLT4gMHgwMGY2MDAwMDAwCj4gWyAgICAxLjk2NDY5MF0gYXJtYWRhOGstcGNpZSBm
MjYwMDAwMC5wY2llOiBMaW5rIHVwCj4gWyAgICAxLjk2OTM3OV0gYXJtYWRhOGstcGNpZSBmMjYw
MDAwMC5wY2llOiBQQ0kgaG9zdCBicmlkZ2UgdG8gYnVzIDAwMDA6MDAKPiBbICAgIDEuOTc2MDI2
XSBwY2lfYnVzIDAwMDA6MDA6IHJvb3QgYnVzIHJlc291cmNlIFtidXMgMDAtZmZdCj4gWyAgICAx
Ljk4MTUzN10gcGNpX2J1cyAwMDAwOjAwOiByb290IGJ1cyByZXNvdXJjZSBbbWVtIDB4ZjYwMDAw
MDAtMHhmNmVmZmZmZl0KPiBbICAgIDEuOTg4NDYyXSBwY2kgMDAwMDowMDowMC4wOiBbMTFhYjow
MTEwXSB0eXBlIDAxIGNsYXNzIDB4MDYwNDAwCj4gWyAgICAxLjk5NDUwNF0gcGNpIDAwMDA6MDA6
MDAuMDogcmVnIDB4MTA6IFttZW0gMHgwMDAwMDAwMC0weDAwMGZmZmZmXQo+IFsgICAgMi4wMDA4
NDNdIHBjaSAwMDAwOjAwOjAwLjA6IHN1cHBvcnRzIEQxIEQyCj4gWyAgICAyLjAwNTEzMl0gcGNp
IDAwMDA6MDA6MDAuMDogUE1FIyBzdXBwb3J0ZWQgZnJvbSBEMCBEMSBEM2hvdAo+IFsgICAgMi4w
MTE4NTNdIHBjaSAwMDAwOjAxOjAwLjA6IFsxNjhjOjAwM2NdIHR5cGUgMDAgY2xhc3MgMHgwMjgw
MDAKPiBbICAgIDIuMDE4MDAxXSBwY2kgMDAwMDowMTowMC4wOiByZWcgMHgxMDogW21lbSAweDAw
MDAwMDAwLTB4MDAxZmZmZmYgNjRiaXRdCj4gWyAgICAyLjAyNTAwMl0gcGNpIDAwMDA6MDE6MDAu
MDogcmVnIDB4MzA6IFttZW0gMHgwMDAwMDAwMC0weDAwMDBmZmZmIHByZWZdCj4gWyAgICAyLjAz
MjExMV0gcGNpIDAwMDA6MDE6MDAuMDogc3VwcG9ydHMgRDEgRDIKPiBbICAgIDIuMDQ5NDA5XSBw
Y2kgMDAwMDowMDowMC4wOiBCQVIgMTQ6IGFzc2lnbmVkIFttZW0gMHhmNjAwMDAwMC0weGY2MWZm
ZmZmXQo+IFsgICAgMi4wNTYzMjJdIHBjaSAwMDAwOjAwOjAwLjA6IEJBUiAwOiBhc3NpZ25lZCBb
bWVtIDB4ZjYyMDAwMDAtMHhmNjJmZmZmZl0KPiBbICAgIDIuMDYzMTQyXSBwY2kgMDAwMDowMDow
MC4wOiBCQVIgMTU6IGFzc2lnbmVkIFttZW0gMHhmNjMwMDAwMC0weGY2M2ZmZmZmIHByZWZdCj4g
WyAgICAyLjA3MDQ4NF0gcGNpIDAwMDA6MDE6MDAuMDogQkFSIDA6IGFzc2lnbmVkIFttZW0gMHhm
NjAwMDAwMC0weGY2MWZmZmZmIDY0Yml0XQo+IFsgICAgMi4wNzc4ODBdIHBjaSAwMDAwOjAxOjAw
LjA6IEJBUiA2OiBhc3NpZ25lZCBbbWVtIDB4ZjYzMDAwMDAtMHhmNjMwZmZmZiBwcmVmXQo+IFsg
ICAgMi4wODUxMzVdIHBjaSAwMDAwOjAwOjAwLjA6IFBDSSBicmlkZ2UgdG8gW2J1cyAwMS1mZl0K
PiBbICAgIDIuMDkwMzg0XSBwY2kgMDAwMDowMDowMC4wOiAgIGJyaWRnZSB3aW5kb3cgW21lbSAw
eGY2MDAwMDAwLTB4ZjYxZmZmZmZdCj4gWyAgICAyLjA5NzIwMl0gcGNpIDAwMDA6MDA6MDAuMDog
ICBicmlkZ2Ugd2luZG93IFttZW0gMHhmNjMwMDAwMC0weGY2M2ZmZmZmIHByZWZdCj4gWyAgICAy
LjEwNDUzOV0gcGNpZXBvcnQgMDAwMDowMDowMC4wOiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgNAo+
IFsgICAgMi4xMTAyMzJdIHBjaWVwb3J0IDAwMDA6MDA6MDAuMDogUE1FOiBTaWduYWxpbmcgd2l0
aCBJUlEgMzgKPiBbICAgIDIuMTE2MTQxXSBwY2llcG9ydCAwMDAwOjAwOjAwLjA6IEFFUjogZW5h
YmxlZCB3aXRoIElSUSAzOAo+IFsgICAgOC4xMzExMzVdIGF0aDEwa19wY2kgMDAwMDowMTowMC4w
OiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgNAo+IFsgICAgOC4xMzE4NzRdIGF0aDEwa19wY2kgMDAw
MDowMTowMC4wOiBlbmFibGluZyBkZXZpY2UgKDAwMDAgLT4gMDAwMikKPiBbICAgIDguMTMyMjAz
XSBhdGgxMGtfcGNpIDAwMDA6MDE6MDAuMDogcGNpIGlycSBtc2kgb3Blcl9pcnFfbW9kZSAyIGly
cV9tb2RlIDAgcmVzZXRfbW9kZSAwCj4KPiB1cCB0byB0aGF0IHBvaW50IHRoZSBsb2cgaXMgdGhl
IHNhbWUgYXMgd2l0aG91dCBTTU1VIGVuYWJsZWQsIGV4Y2VwdCAiQWRkaW5nIHRvIGlvbW11IGdy
b3VwIE4iIGxpbmVzLCBhbmQgSVJRIGJlaW5nIDM3Cj4KPiBbICAgIDguMjIxMzI4XSBhdGgxMGtf
cGNpIDAwMDA6MDE6MDAuMDogZmFpbGVkIHRvIHBva2UgY29weSBlbmdpbmU6IC0xNgo+IFsgICAg
OC4zMTMzNjJdIGF0aDEwa19wY2kgMDAwMDowMTowMC4wOiBmYWlsZWQgdG8gcG9rZSBjb3B5IGVu
Z2luZTogLTE2Cj4gWyAgICA4LjQwOTM3M10gYXRoMTBrX3BjaSAwMDAwOjAxOjAwLjA6IGZhaWxl
ZCB0byBwb2tlIGNvcHkgZW5naW5lOiAtMTYKPiBbICAgIDguNTUzNDMzXSBhdGgxMGtfcGNpIDAw
MDA6MDE6MDAuMDogZmFpbGVkIHRvIHBva2UgY29weSBlbmdpbmU6IC0xNgo+IFsgICAgOC42NDEz
NzBdIGF0aDEwa19wY2kgMDAwMDowMTowMC4wOiBmYWlsZWQgdG8gcG9rZSBjb3B5IGVuZ2luZTog
LTE2Cj4gWyAgICA4LjczNzk3OV0gYXRoMTBrX3BjaSAwMDAwOjAxOjAwLjA6IGZhaWxlZCB0byBw
b2tlIGNvcHkgZW5naW5lOiAtMTYKPiBbICAgIDguODA3MzU2XSBhdGgxMGtfcGNpIDAwMDA6MDE6
MDAuMDogRmFpbGVkIHRvIGdldCBwY2llIHN0YXRlIGFkZHI6IC0xNgo+IFsgICAgOC44MTQwMzJd
IGF0aDEwa19wY2kgMDAwMDowMTowMC4wOiBmYWlsZWQgdG8gc2V0dXAgaW5pdCBjb25maWc6IC0x
Ngo+IFsgICAgOC44MjA2MDVdIGF0aDEwa19wY2kgMDAwMDowMTowMC4wOiBjb3VsZCBub3QgcG93
ZXIgb24gaGlmIGJ1cyAoLTE2KQo+IFsgICAgOC44MjcxMTFdIGF0aDEwa19wY2kgMDAwMDowMTow
MC4wOiBjb3VsZCBub3QgcHJvYmUgZncgKC0xNikKPgo+IFRoYW5rIHlvdSEKClRoZSBQQ0lFIHdh
cyB2YWxpZGF0ZWQgd2hlbiBib290aW5nIGZyb20gZWRrMiArIHVzaW5nIHBjaS1ob3N0LWdlbmVy
aWMKZHJpdmVyIGFuZCBzdGFuZGFyZCBpbnRlbCBOSUMuIE5vdCBzdXJlIGlmIGl0IG1ha2VzIGFu
eSBkaWZmZXJlbmNlIHZzCnRoZSBEZXNpZ253YXJlIGRyaXZlciAoIm1hcnZlbGwsYXJtYWRhOGst
cGNpZSIpLCBidXQgd2UgbmVlZCB0bwpkb3VibGUtY2hlY2sgdGhhdC4KCkJlc3QgcmVnYXJkcywK
TWFyY2luCgo+Cj4gPiB2MyAtPiB2NAo+ID4gLSBjYWxsIGNmZ19wcm9iZSgpIGltcGwgaG9vayBh
IGJpdCBlYXJsaWVyIHdoaWNoIHNpbXBsaWZpZXMgZXJyYXRhIGhhbmRsaW5nCj4gPiAtIHVzZSBo
aV9sb19yZWFkcV9yZWxheGVkKCkgYW5kIGhpX2xvX3dyaXRlcV9yZWxheGVkKCkgZm9yIHJlZ2lz
dGVyIGFjY2Vzc29ycwo+ID4gLSBrZWVwIFNNTVUgc3RhdHVzIGRpc2FibGVkIGJ5IGRlZmF1bHQg
YW5kIGVuYWJsZSB3aGVyZSBwb3NzaWJsZSAoRFRTIGNoYW5nZXMpCj4gPiAtIGNvbW1pdCBsb2dz
IGltcHJvdmVtZW50cyBhbmQgb3RoZXIgbWlub3IgZml4ZXMKPiA+Cj4gPiBIYW5uYSBIYXdhICgx
KToKPiA+ICBpb21tdS9hcm0tc21tdTogV29ya2Fyb3VuZCBmb3IgTWFydmVsbCBBcm1hZGEtQVA4
MDYgU29DIGVycmF0dW0KPiA+ICAgICM1ODI3NDMKPiA+Cj4gPiBNYXJjaW4gV29qdGFzICgxKToK
PiA+ICBhcm02NDogZHRzOiBtYXJ2ZWxsOiBhZGQgU01NVSBzdXBwb3J0Cj4gPgo+ID4gVG9tYXN6
IE5vd2lja2kgKDIpOgo+ID4gIGlvbW11L2FybS1zbW11OiBDYWxsIGNvbmZpZ3VyYXRpb24gaW1w
bCBob29rIGJlZm9yZSBjb25zdW1pbmcgZmVhdHVyZXMKPiA+ICBkdC1iaW5kaW5nczogYXJtLXNt
bXU6IGFkZCBjb21wYXRpYmxlIHN0cmluZyBmb3IgTWFydmVsbCBBcm1hZGEtQVA4MDYKPiA+ICAg
IFNNTVUtNTAwCj4gPgo+ID4gRG9jdW1lbnRhdGlvbi9hcm02NC9zaWxpY29uLWVycmF0YS5yc3Qg
ICAgICAgIHwgIDMgKysKPiA+IC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lvbW11L2FybSxzbW11
LnlhbWwgICB8ICA0ICsrCj4gPiBhcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLTcw
NDAuZHRzaSAgfCAyOCArKysrKysrKysrKysKPiA+IGFyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVs
bC9hcm1hZGEtODA0MC5kdHNpICB8IDQwICsrKysrKysrKysrKysrKysrCj4gPiBhcmNoL2FybTY0
L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLWFwODB4LmR0c2kgfCAxOCArKysrKysrKwo+ID4gZHJp
dmVycy9pb21tdS9hcm0tc21tdS1pbXBsLmMgICAgICAgICAgICAgICAgIHwgNDUgKysrKysrKysr
KysrKysrKysrKwo+ID4gZHJpdmVycy9pb21tdS9hcm0tc21tdS5jICAgICAgICAgICAgICAgICAg
ICAgIHwgMTEgKysrLS0KPiA+IDcgZmlsZXMgY2hhbmdlZCwgMTQ1IGluc2VydGlvbnMoKyksIDQg
ZGVsZXRpb25zKC0pCj4gPgo+ID4gLS0KPiA+IDIuMTcuMQo+ID4KPiA+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gPiBpb21tdSBtYWlsaW5nIGxpc3QK
PiA+IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCj4gPiBodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQo+ID4KPgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QK
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
