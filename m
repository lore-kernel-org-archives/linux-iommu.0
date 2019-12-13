Return-Path: <SRS0=hFKH=2D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4270EC2D0C9
	for <iommu@archiver.kernel.org>; Fri, 13 Dec 2019 02:52:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AE942253D
	for <iommu@archiver.kernel.org>; Fri, 13 Dec 2019 02:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/fByj/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE942253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C83CB88416;
	Fri, 13 Dec 2019 02:52:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QMIzA+ykvy7J; Fri, 13 Dec 2019 02:52:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 00F05883D5;
	Fri, 13 Dec 2019 02:52:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1974C1796;
	Fri, 13 Dec 2019 02:52:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA586C0881
 for <iommu@lists.linux-foundation.org>; Fri, 13 Dec 2019 02:52:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 92C8387216
 for <iommu@lists.linux-foundation.org>; Fri, 13 Dec 2019 02:52:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bj-d-vfT9ghY for <iommu@lists.linux-foundation.org>;
 Fri, 13 Dec 2019 02:52:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6F652871EE
 for <iommu@lists.linux-foundation.org>; Fri, 13 Dec 2019 02:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576205540;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cD1L+8FREG+GUDcMz+uat68SlppNJ1ul4pAa2adOJms=;
 b=d/fByj/+frHklvwAW5AJTwO6KsnYJtYJnZ4uSVH2q7NWDIS61i6PIeqx9CrIbjwQRAOdT3
 SRLgD8itHTssM3MtMCEC01Nm9d5xilxxLz9KPm0oVzOQ5iGG4yAN1wxr7Bymhc14v1T4xf
 jNOR4spR3HbeTxFeVDkEIq1neYjUur8=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-dmJJS2qAMO2XLG6bzxfL_A-1; Thu, 12 Dec 2019 21:52:18 -0500
X-MC-Unique: dmJJS2qAMO2XLG6bzxfL_A-1
Received: by mail-yb1-f200.google.com with SMTP id r14so870969ybl.10
 for <iommu@lists.linux-foundation.org>; Thu, 12 Dec 2019 18:52:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :mail-followup-to:references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to;
 bh=cD1L+8FREG+GUDcMz+uat68SlppNJ1ul4pAa2adOJms=;
 b=RXTE7bWoqhC2BV0AaaMRigdDXK1cN167a/PTCivclECU2qXjloxQ6mGQWSquZBmlHw
 E029QRAhNmKny1ukJTSM798AnhzOTq/xCkqv2UkW4rv9eISGxhdJHO5XIduQf1QptSQm
 qZm+Z6vqwh+I8umg1+YQqMqi5fYIuig4dnmDCCaclSJ3d21m4+15dfTlQQpv0wZ9hx36
 FybqB1Wg00I4760EfNZ7qic7fScUdR1+KAsxBv3k7WF/072fKvuoJ13GAWxt3oFDE5aD
 s8CxPz+ipCcBooYdg/k76yQQ/Ry104BhNRZyE9KuOuYWHnpVE6K/pDErUmhdTtzlfBXm
 xDSw==
X-Gm-Message-State: APjAAAUc+Hr71MP6nFREzaR2KWcy12WcFLXRyi1vFBhAFY8RQI6kO6b6
 RabzOwZN9rT59IclRsmaoVhdizcWLcxycLK08UiEtZEC5jUqEHKkLkmiIZ134fpjz09GLlljUUP
 ge9RGtAfwu7CcUAKtQykZ3RYxPtkArQ==
X-Received: by 2002:a25:b814:: with SMTP id v20mr7059584ybj.108.1576205537843; 
 Thu, 12 Dec 2019 18:52:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqxKfbL8mDNB7zRISO5Uc+9Lbw1DKFRT8f3eUHKdf/Rvj+kSjJjTiPaM16CZsiJA82Bqiv70yQ==
X-Received: by 2002:a25:b814:: with SMTP id v20mr7059569ybj.108.1576205537478; 
 Thu, 12 Dec 2019 18:52:17 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id g64sm3548300ywa.20.2019.12.12.18.52.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2019 18:52:16 -0800 (PST)
Date: Thu, 12 Dec 2019 19:51:59 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix dmar pte read access not set error
Message-ID: <20191213025159.kwf6f6zjmcjecamp@cantor>
Mail-Followup-To: Lu Baolu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
 jacob.jun.pan@intel.com, kevin.tian@intel.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20191211014015.7898-1-baolu.lu@linux.intel.com>
 <20191212014952.vlrmxrk2cebwxjnp@cantor>
 <6f3bcad9-b9b3-b349-fdad-ce53a79a665b@linux.intel.com>
 <20191213003013.gc3zg3fpzpjntnzg@cantor>
 <7d58da5b-3f55-72b2-0638-ae561446d207@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7d58da5b-3f55-72b2-0638-ae561446d207@linux.intel.com>
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, iommu@lists.linux-foundation.org,
 jacob.jun.pan@intel.com, David Woodhouse <dwmw2@infradead.org>
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
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gRnJpIERlYyAxMyAxOSwgTHUgQmFvbHUgd3JvdGU6Cj5IaSwKPgo+T24gMTIvMTMvMTkgODoz
MCBBTSwgSmVycnkgU25pdHNlbGFhciB3cm90ZToKPj5PbiBUaHUgRGVjIDEyIDE5LCBMdSBCYW9s
dSB3cm90ZToKPj4+SGksCj4+Pgo+Pj5PbiAxMi8xMi8xOSA5OjQ5IEFNLCBKZXJyeSBTbml0c2Vs
YWFyIHdyb3RlOgo+Pj4+T24gV2VkIERlYyAxMSAxOSwgTHUgQmFvbHUgd3JvdGU6Cj4+Pj4+SWYg
dGhlIGRlZmF1bHQgRE1BIGRvbWFpbiBvZiBhIGdyb3VwIGRvZXNuJ3QgZml0IGEgZGV2aWNlLCBp
dAo+Pj4+PndpbGwgc3RpbGwgc2l0IGluIHRoZSBncm91cCBidXQgdXNlIGEgcHJpdmF0ZSBpZGVu
dGl0eSBkb21haW4uCj4+Pj4+V2hlbiBtYXAvdW5tYXAvaW92YV90b19waHlzIGNvbWUgdGhyb3Vn
aCBpb21tdSBBUEksIHRoZSBkcml2ZXIKPj4+Pj5zaG91bGQgc3RpbGwgc2VydmUgdGhlbSwgb3Ro
ZXJ3aXNlLCBvdGhlciBkZXZpY2VzIGluIHRoZSBzYW1lCj4+Pj4+Z3JvdXAgd2lsbCBiZSBpbXBh
Y3RlZC4gU2luY2UgaWRlbnRpdHkgZG9tYWluIGhhcyBiZWVuIG1hcHBlZAo+Pj4+PndpdGggdGhl
IHdob2xlIGF2YWlsYWJsZSBtZW1vcnkgc3BhY2UgYW5kIFJNUlJzLCB3ZSBkb24ndCBuZWVkCj4+
Pj4+dG8gd29ycnkgYWJvdXQgdGhlIGltcGFjdCBvbiBpdC4KPj4+Pj4KPj4+Pj5MaW5rOiBodHRw
czovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9pb21tdS9tc2c0MDQxNi5odG1sCj4+Pj4+Q2M6IEpl
cnJ5IFNuaXRzZWxhYXIgPGpzbml0c2VsQHJlZGhhdC5jb20+Cj4+Pj4+UmVwb3J0ZWQtYnk6IEpl
cnJ5IFNuaXRzZWxhYXIgPGpzbml0c2VsQHJlZGhhdC5jb20+Cj4+Pj4+Rml4ZXM6IDk0MjA2N2Yx
YjZiOTcgKCJpb21tdS92dC1kOiBJZGVudGlmeSBkZWZhdWx0IGRvbWFpbnMgCj4+Pj4+cmVwbGFj
ZWQgd2l0aCBwcml2YXRlIikKPj4+Pj5DYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZyAjIHY1LjMr
Cj4+Pj4+U2lnbmVkLW9mZi1ieTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4K
Pj4+Pgo+Pj4+UmV2aWV3ZWQtYnk6IEplcnJ5IFNuaXRzZWxhYXIgPGpzbml0c2VsQHJlZGhhdC5j
b20+Cj4+Pgo+Pj5DYW4geW91IHBsZWFzZSB0cnkgdGhpcyBmaXggYW5kIGNoZWNrIHdoZXRoZXIg
aXQgY2FuIGZpeCB5b3VyIHByb2JsZW0/Cj4+PklmIGl0IGhlbHBzLCBkbyB5b3UgbWluZCBhZGRp
bmcgYSBUZXN0ZWQtYnk/Cj4+Pgo+Pj5CZXN0IHJlZ2FyZHMsCj4+PmJhb2x1Cj4+Pgo+Pgo+Pkkn
bSB0ZXN0aW5nIHdpdGggdGhpcyBwYXRjaCwgbXkgcGF0Y2ggdGhhdCBtb3ZlcyB0aGUgZGlyZWN0
IG1hcHBpbmcgY2FsbCwKPj5hbmQgQWxleCdzIHBhdGNoIGZvciB0aGUgSVNBIGJyaWRnZS4gSXQg
c29sdmVkIHRoZSAyIGlvbW11IG1hcHBpbmcgZXJyb3JzCj4+SSB3YXMgc2VlaW5nIHdpdGggZGVm
YXVsdCBwYXNzdGhyb3VnaCwgSSBubyBsb25nZXIgc2VlIGFsbCB0aGUgZG1hciBwdGUKPj5yZWFk
IGFjY2VzcyBlcnJvcnMsIGFuZCB0aGUgc3lzdGVtIGJvb3RzIGFsbG93aW5nIG1lIHRvIGxvZ2lu
LiBJJ20gdHJhY2tpbmcKPj5kb3duIDIgaXNzdWVzIGF0IHRoZSBtb21lbnQuIFdpdGggcGFzc3Ro
cm91Z2ggSSBzZWUgYSBwcm9ibGVtIHdpdGggMDE6MDAuNAo+PnRoYXQgSSBtZW50aW9uZWQgaW4g
dGhlIGVhcmxpZXIgZW1haWw6Cj4+Cj4+W8KgwqAgNzguOTc4NTczXSB1aGNpX2hjZDogVVNCIFVu
aXZlcnNhbCBIb3N0IENvbnRyb2xsZXIgSW50ZXJmYWNlIGRyaXZlcgo+PlvCoMKgIDc4Ljk4MDg0
Ml0gdWhjaV9oY2QgMDAwMDowMTowMC40OiBVSENJIEhvc3QgQ29udHJvbGxlcgo+PlvCoMKgIDc4
Ljk4MjczOF0gdWhjaV9oY2QgMDAwMDowMTowMC40OiBuZXcgVVNCIGJ1cyByZWdpc3RlcmVkLCAK
Pj5hc3NpZ25lZCBidXMgbnVtYmVyIDMKPj5bwqDCoCA3OC45ODUyMjJdIHVoY2lfaGNkIDAwMDA6
MDE6MDAuNDogZGV0ZWN0ZWQgOCBwb3J0cwo+PlvCoMKgIDc4Ljk4NjkwN10gdWhjaV9oY2QgMDAw
MDowMTowMC40OiBwb3J0IGNvdW50IG1pc2RldGVjdGVkPyAKPj5mb3JjaW5nIHRvIDIgcG9ydHMK
Pj5bwqDCoCA3OC45ODkzMTZdIHVoY2lfaGNkIDAwMDA6MDE6MDAuNDogaXJxIDE2LCBpbyBiYXNl
IDB4MDAwMDNjMDAKPj5bwqDCoCA3OC45OTQ2MzRdIHVoY2lfaGNkIDAwMDA6MDE6MDAuNDogRE1B
UjogMzJiaXQgRE1BIHVzZXMgCj4+bm9uLWlkZW50aXR5IG1hcHBpbmcKPj5bwqDCoCA3IDAwMDA6
MDE6MDAuNDogdW5hYmxlIHRvIGFsbG9jYXRlIGNvbnNpc3RlbnQgbWVtb3J5IGZvciBmcmFtZSBs
aXN0Cj4+W8KgwqAgNzkuNDk5ODkxXSB1aGNpX2hjZCAwMDAwOjAxOjAwLjQ6IHN0YXJ0dXAgZXJy
b3IgLTE2Cj4+W8KgwqAgNzkuNTAxNTg4XSB1aGNpX2hjZCAwMDAwOjAxOjAwLjQ6IFVTQiBidXMg
MyBkZXJlZ2lzdGVyZWQKPj5bwqDCoCA3OS41MDM0OTRdIHVoY2lfaGNkIDAwMDA6MDE6MDAuNDog
aW5pdCAwMDAwOjAxOjAwLjQgZmFpbCwgLTE2Cj4+W8KgwqAgNzkuNTA1NDk3XSB1aGNpX2hjZDog
cHJvYmUgb2YgMDAwMDowMTowMC40IGZhaWxlZCB3aXRoIGVycm9yIC0xNgo+Pgo+PklmIEkgYm9v
dCB0aGUgc3lzdGVtIHdpdGggaW9tbXU9bm9wdCBJIHNlZSBhbiBpb21tdSBtYXAgZmFpbHVyZSBk
dWUgdG8KPj50aGUgcHJvdCBjaGVjayBpbiBfX2RvbWFpbl9tYXBwaW5nOgo+Pgo+PlvCoMKgIDQw
Ljk0MDU4OV0gcGNpIDAwMDA6MDA6MWYuMDogaW9tbXVfZ3JvdXBfYWRkX2RldmljZTogY2FsbGlu
ZyAKPj5pb21tdV9ncm91cF9jcmVhdGVfZGlyZWN0X21hcHBpbmdzCj4+W8KgwqAgNDAuOTQzNTU4
XSBwY2kgMDAwMDowMDoxZi4wOiBpb21tdV9ncm91cF9jcmVhdGVfZGlyZWN0X21hcHBpbmdzOiAK
Pj5pdGVyYXRpbmcgdGhyb3VnaCBtYXBwaW5ncwo+PlvCoMKgIDQwLjk0NjQwMl0gcGNpIDAwMDA6
MDA6MWYuMDogaW9tbXVfZ3JvdXBfY3JlYXRlX2RpcmVjdF9tYXBwaW5nczogCj4+Y2FsbGluZyBh
cHBseV9yZXN2X3JlZ2lvbgo+PlvCoMKgIDQwLjk0OTE4NF0gcGNpIDAwMDA6MDA6MWYuMDogaW9t
bXVfZ3JvdXBfY3JlYXRlX2RpcmVjdF9tYXBwaW5nczogCj4+ZW50cnkgdHlwZSBpcyBkaXJlY3QK
Pj5bwqDCoCA0MC45NTE4MTldIERNQVI6IGludGVsX2lvbW11X21hcDogZW50ZXIKPj5bwqDCoCA0
MC45NTMxMjhdIERNQVI6IF9fZG9tYWluX21hcHBpbmc6IHByb3QgJiAKPj4oRE1BX1BURV9SRUFE
fERNQV9QVEVfV1JJVEUpID09IDAKPj5bwqDCoCA0MC45NTU0ODZdIERNQVI6IGRvbWFpbl9tYXBw
aW5nOiBfX2RvbWFpbl9tYXBwaW5nIGZhaWxlZAo+PlvCoMKgIDQwLjk1NzM0OF0gRE1BUjogaW50
ZWxfaW9tbXVfbWFwOiBkb21haW5fcGZuX21hcHBpbmcgcmV0dXJuZWQgLTIyCj4+W8KgwqAgNDAu
OTU5NDY2XSBETUFSOiBpbnRlbF9pb21tdV9tYXA6IGxlYXZlCj4+W8KgwqAgNDAuOTU5NDY4XSBp
b21tdTogaW9tbXVfbWFwOiBvcHMtPm1hcCBmYWlsZWQgaW92YSAweDAgcGEgCj4+MHgwMDAwMDAw
MDAwMDAwMDAwIHBnc2l6ZSAweDEwMDAKPj5bwqDCoCA0MC45NjM1MTFdIHBjaSAwMDAwOjAwOjFm
LjA6IGlvbW11X2dyb3VwX2NyZWF0ZV9kaXJlY3RfbWFwcGluZ3M6IAo+PmlvbW11X21hcCBmYWls
ZWQKPj5bwqDCoCA0MC45NjYwMjZdIHBjaSAwMDAwOjAwOjFmLjA6IGlvbW11X2dyb3VwX2NyZWF0
ZV9kaXJlY3RfbWFwcGluZ3M6IAo+PmxlYXZpbmcgZnVuYwo+PlvCoMKgIDQwLjk2ODQ4N10gcGNp
IDAwMDA6MDA6MWYuMDogaW9tbXVfZ3JvdXBfYWRkX2RldmljZTogY2FsbGluZyAKPj5fX2lvbW11
X2F0dGFjaF9kZXZpY2UKPj5bwqDCoCA0MC45NzEwMTZdIHBjaSAwMDAwOjAwOjFmLjA6IEFkZGlu
ZyB0byBpb21tdSBncm91cCAxOQo+PlvCoMKgIDQwLjk3MjczMV0gcGNpIDAwMDA6MDA6MWYuMDog
RE1BUjogZG9tYWluLT50eXBlIGlzIGRtYQo+Pgo+Pi9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy8x
OQo+Pltyb290QGhwLWRsMzg4ZzgtMDcgMTldIyBjYXQgcmVzZXJ2ZWRfcmVnaW9ucyAweDAwMDAw
MDAwMDAwMDAwMDAgCj4+MHgwMDAwMDAwMDAwZmZmZmZmIGRpcmVjdAo+PjB4MDAwMDAwMDBiZGY2
ZTAwMCAweDAwMDAwMDAwYmRmODRmZmYgZGlyZWN0Cj4+MHgwMDAwMDAwMGZlZTAwMDAwIDB4MDAw
MDAwMDBmZWVmZmZmZiBtc2kKPj4KPj4wMDoxZi4wIElTQSBicmlkZ2U6IEludGVsIENvcnBvcmF0
aW9uIEM2MDAvWDc5IHNlcmllcyBjaGlwc2V0IExQQyAKPj5Db250cm9sbGVyCj4KPlRoaXMgc2Vl
bXMgdG8gYmUgYW5vdGhlciBpc3N1ZT8KPgo+QmVzdCByZWdhcmRzLAo+YmFvbHUKCkluIGludGVs
X2lvbW11X2dldF9yZXN2X3JlZ2lvbnMgdGhpcyBpb21tdV9hbGxvY19yZXN2X3JlZ2lvbiBpcyBj
YWxsZWQKd2l0aCBwcm90IHNldCB0byAwOgoKICAgICAgICAgICAgICAgICBpZiAoKHBkZXYtPmNs
YXNzID4+IDgpID09IFBDSV9DTEFTU19CUklER0VfSVNBKSB7CiAgICAgICAgICAgICAgICAgICAg
ICAgICByZWcgPSBpb21tdV9hbGxvY19yZXN2X3JlZ2lvbigwLCAxVUwgPDwgMjQsIDAsCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJT01NVV9S
RVNWX0RJUkVDVF9SRUxBWEFCTEUpOwogICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHJlZykK
Ckkgd29uZGVyIGlmIHRoaXMgaXMgYW4gaXNzdWUgd2l0aCB0aGUgcmVnaW9uIHN0YXJ0aW5nIGF0
IDB4MCBhbmQgdGhpcwpiaXQgaW4gaW9tbXVfZ3JvdXBfY3JlYXRlX21hcHBpbmdzOgoKCQkJcGh5
c19hZGRyID0gaW9tbXVfaW92YV90b19waHlzKGRvbWFpbiwgYWRkcik7CgkJCWlmIChwaHlzX2Fk
ZHIpCgkJCQljb250aW51ZTsKCk9mZiB0byBzdGljayBpbiBzb21lIG1vcmUgZGVidWdnaW5nIHN0
YXRlbWVudHMuCgpSZWdhcmRzLApKZXJyeQoKPl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCj5pb21tdSBtYWlsaW5nIGxpc3QKPmlvbW11QGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCj5odHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby9pb21tdQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lv
bW11
