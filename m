Return-Path: <SRS0=hFKH=2D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E97C2D0C9
	for <iommu@archiver.kernel.org>; Fri, 13 Dec 2019 03:16:51 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5712227BF
	for <iommu@archiver.kernel.org>; Fri, 13 Dec 2019 03:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YE0J8WCv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5712227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 42A5487270;
	Fri, 13 Dec 2019 03:16:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7QTKRr0Wru2g; Fri, 13 Dec 2019 03:16:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 417AC87268;
	Fri, 13 Dec 2019 03:16:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15411C1D81;
	Fri, 13 Dec 2019 03:16:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45168C0881
 for <iommu@lists.linux-foundation.org>; Fri, 13 Dec 2019 03:16:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2F56388236
 for <iommu@lists.linux-foundation.org>; Fri, 13 Dec 2019 03:16:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8d8bMMrmr9g8 for <iommu@lists.linux-foundation.org>;
 Fri, 13 Dec 2019 03:16:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 429C288231
 for <iommu@lists.linux-foundation.org>; Fri, 13 Dec 2019 03:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576207004;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OF6N4wqiULHnhkx+2DOIL/HDlPx6E4fjY6FKxous7Io=;
 b=YE0J8WCvDyBXPwsD20zWgVSUi1p18Z2V8tfQF1ZS8Bkou3QuuG1S5J5qjE37O1PqpKgWWO
 tuoRoOk6BesdPPsgkf0CnvzmJeI5TqX3N4fr1Q35zhYKYD44F9tMOzKJrjn1lCUprqNlFT
 nCiY8lFN3KIRc//bMw6s5qLeoOXFueo=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-fATtfDAhNrOr882rZKPQLw-1; Thu, 12 Dec 2019 22:16:43 -0500
X-MC-Unique: fATtfDAhNrOr882rZKPQLw-1
Received: by mail-yb1-f199.google.com with SMTP id v186so927331ybc.4
 for <iommu@lists.linux-foundation.org>; Thu, 12 Dec 2019 19:16:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:reply-to
 :mail-followup-to:references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to;
 bh=OF6N4wqiULHnhkx+2DOIL/HDlPx6E4fjY6FKxous7Io=;
 b=Uu/mEJkzyrQ+pCZUila6B6+wfWZlcIRppDaweRnqMCcczbk6UlYmJE/FEubm/cPar2
 ijPOsMZ0bfsNxFDTeq50wTKMst54FGIrlh+4Jm/+ktF8oFhxN8vwfm2awuwmoz9td2TO
 kQlwC0jdImDh+dyIX6t+me/UZKP1f00wR++DuwGIdf0pvT5SK7Pvw+KgMFCkxuqiM8Yw
 RmA7dQh5uhrZn0YQ7vZm3s2SuqKB1gcR6oRD6tSxPrbp8yhKfceGGsgyzuTWDcIiltQL
 o7AMKCejrXXEJCMZN86cfg+4KenrJ6D8SKUmsJ2hokzBst5My7sKH4XQt92YyvJrctaC
 vsnQ==
X-Gm-Message-State: APjAAAXsUDbzbujwURCErL5NhecUySMtoyO2u9qATn3tdMFC8bzaJFJ/
 vQdm+6gCTmEk3NWTiBfUq0Dj3hQaXKEH0b0pKwYra9eQ3ywymHQq2pr7xxRqe7vtBQb7chVKgd6
 XBXiM96ImnwVMAtyxys3co9MiyxZEiw==
X-Received: by 2002:a81:550c:: with SMTP id j12mr6975265ywb.38.1576207002595; 
 Thu, 12 Dec 2019 19:16:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqw4yUmpywtUmKkrwEdg58T33LVtLlFVUkyGqlU+wk4uepLmvOkbc5t04OHTCnhGMELRjb1LzA==
X-Received: by 2002:a81:550c:: with SMTP id j12mr6975255ywb.38.1576207002317; 
 Thu, 12 Dec 2019 19:16:42 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id j129sm3468145ywf.99.2019.12.12.19.16.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2019 19:16:41 -0800 (PST)
Date: Thu, 12 Dec 2019 20:16:33 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
 jacob.jun.pan@intel.com, kevin.tian@intel.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix dmar pte read access not set error
Message-ID: <20191213031633.zxccz5t5yyillxsb@cantor>
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
 <20191213025159.kwf6f6zjmcjecamp@cantor>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191213025159.kwf6f6zjmcjecamp@cantor>
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

T24gVGh1IERlYyAxMiAxOSwgSmVycnkgU25pdHNlbGFhciB3cm90ZToKPk9uIEZyaSBEZWMgMTMg
MTksIEx1IEJhb2x1IHdyb3RlOgo+PkhpLAo+Pgo+Pk9uIDEyLzEzLzE5IDg6MzAgQU0sIEplcnJ5
IFNuaXRzZWxhYXIgd3JvdGU6Cj4+Pk9uIFRodSBEZWMgMTIgMTksIEx1IEJhb2x1IHdyb3RlOgo+
Pj4+SGksCj4+Pj4KPj4+Pk9uIDEyLzEyLzE5IDk6NDkgQU0sIEplcnJ5IFNuaXRzZWxhYXIgd3Jv
dGU6Cj4+Pj4+T24gV2VkIERlYyAxMSAxOSwgTHUgQmFvbHUgd3JvdGU6Cj4+Pj4+PklmIHRoZSBk
ZWZhdWx0IERNQSBkb21haW4gb2YgYSBncm91cCBkb2Vzbid0IGZpdCBhIGRldmljZSwgaXQKPj4+
Pj4+d2lsbCBzdGlsbCBzaXQgaW4gdGhlIGdyb3VwIGJ1dCB1c2UgYSBwcml2YXRlIGlkZW50aXR5
IGRvbWFpbi4KPj4+Pj4+V2hlbiBtYXAvdW5tYXAvaW92YV90b19waHlzIGNvbWUgdGhyb3VnaCBp
b21tdSBBUEksIHRoZSBkcml2ZXIKPj4+Pj4+c2hvdWxkIHN0aWxsIHNlcnZlIHRoZW0sIG90aGVy
d2lzZSwgb3RoZXIgZGV2aWNlcyBpbiB0aGUgc2FtZQo+Pj4+Pj5ncm91cCB3aWxsIGJlIGltcGFj
dGVkLiBTaW5jZSBpZGVudGl0eSBkb21haW4gaGFzIGJlZW4gbWFwcGVkCj4+Pj4+PndpdGggdGhl
IHdob2xlIGF2YWlsYWJsZSBtZW1vcnkgc3BhY2UgYW5kIFJNUlJzLCB3ZSBkb24ndCBuZWVkCj4+
Pj4+PnRvIHdvcnJ5IGFib3V0IHRoZSBpbXBhY3Qgb24gaXQuCj4+Pj4+Pgo+Pj4+Pj5MaW5rOiBo
dHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9pb21tdS9tc2c0MDQxNi5odG1sCj4+Pj4+PkNj
OiBKZXJyeSBTbml0c2VsYWFyIDxqc25pdHNlbEByZWRoYXQuY29tPgo+Pj4+Pj5SZXBvcnRlZC1i
eTogSmVycnkgU25pdHNlbGFhciA8anNuaXRzZWxAcmVkaGF0LmNvbT4KPj4+Pj4+Rml4ZXM6IDk0
MjA2N2YxYjZiOTcgKCJpb21tdS92dC1kOiBJZGVudGlmeSBkZWZhdWx0IGRvbWFpbnMgCj4+Pj4+
PnJlcGxhY2VkIHdpdGggcHJpdmF0ZSIpCj4+Pj4+PkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3Jn
ICMgdjUuMysKPj4+Pj4+U2lnbmVkLW9mZi1ieTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4Lmlu
dGVsLmNvbT4KPj4+Pj4KPj4+Pj5SZXZpZXdlZC1ieTogSmVycnkgU25pdHNlbGFhciA8anNuaXRz
ZWxAcmVkaGF0LmNvbT4KPj4+Pgo+Pj4+Q2FuIHlvdSBwbGVhc2UgdHJ5IHRoaXMgZml4IGFuZCBj
aGVjayB3aGV0aGVyIGl0IGNhbiBmaXggeW91ciBwcm9ibGVtPwo+Pj4+SWYgaXQgaGVscHMsIGRv
IHlvdSBtaW5kIGFkZGluZyBhIFRlc3RlZC1ieT8KPj4+Pgo+Pj4+QmVzdCByZWdhcmRzLAo+Pj4+
YmFvbHUKPj4+Pgo+Pj4KPj4+SSdtIHRlc3Rpbmcgd2l0aCB0aGlzIHBhdGNoLCBteSBwYXRjaCB0
aGF0IG1vdmVzIHRoZSBkaXJlY3QgbWFwcGluZyBjYWxsLAo+Pj5hbmQgQWxleCdzIHBhdGNoIGZv
ciB0aGUgSVNBIGJyaWRnZS4gSXQgc29sdmVkIHRoZSAyIGlvbW11IG1hcHBpbmcgZXJyb3JzCj4+
Pkkgd2FzIHNlZWluZyB3aXRoIGRlZmF1bHQgcGFzc3Rocm91Z2gsIEkgbm8gbG9uZ2VyIHNlZSBh
bGwgdGhlIGRtYXIgcHRlCj4+PnJlYWQgYWNjZXNzIGVycm9ycywgYW5kIHRoZSBzeXN0ZW0gYm9v
dHMgYWxsb3dpbmcgbWUgdG8gbG9naW4uIEknbSB0cmFja2luZwo+Pj5kb3duIDIgaXNzdWVzIGF0
IHRoZSBtb21lbnQuIFdpdGggcGFzc3Rocm91Z2ggSSBzZWUgYSBwcm9ibGVtIHdpdGggMDE6MDAu
NAo+Pj50aGF0IEkgbWVudGlvbmVkIGluIHRoZSBlYXJsaWVyIGVtYWlsOgo+Pj4KPj4+W8KgwqAg
NzguOTc4NTczXSB1aGNpX2hjZDogVVNCIFVuaXZlcnNhbCBIb3N0IENvbnRyb2xsZXIgSW50ZXJm
YWNlIGRyaXZlcgo+Pj5bwqDCoCA3OC45ODA4NDJdIHVoY2lfaGNkIDAwMDA6MDE6MDAuNDogVUhD
SSBIb3N0IENvbnRyb2xsZXIKPj4+W8KgwqAgNzguOTgyNzM4XSB1aGNpX2hjZCAwMDAwOjAxOjAw
LjQ6IG5ldyBVU0IgYnVzIHJlZ2lzdGVyZWQsIAo+Pj5hc3NpZ25lZCBidXMgbnVtYmVyIDMKPj4+
W8KgwqAgNzguOTg1MjIyXSB1aGNpX2hjZCAwMDAwOjAxOjAwLjQ6IGRldGVjdGVkIDggcG9ydHMK
Pj4+W8KgwqAgNzguOTg2OTA3XSB1aGNpX2hjZCAwMDAwOjAxOjAwLjQ6IHBvcnQgY291bnQgbWlz
ZGV0ZWN0ZWQ/IAo+Pj5mb3JjaW5nIHRvIDIgcG9ydHMKPj4+W8KgwqAgNzguOTg5MzE2XSB1aGNp
X2hjZCAwMDAwOjAxOjAwLjQ6IGlycSAxNiwgaW8gYmFzZSAweDAwMDAzYzAwCj4+PlvCoMKgIDc4
Ljk5NDYzNF0gdWhjaV9oY2QgMDAwMDowMTowMC40OiBETUFSOiAzMmJpdCBETUEgdXNlcyAKPj4+
bm9uLWlkZW50aXR5IG1hcHBpbmcKPj4+W8KgwqAgNyAwMDAwOjAxOjAwLjQ6IHVuYWJsZSB0byBh
bGxvY2F0ZSBjb25zaXN0ZW50IG1lbW9yeSBmb3IgZnJhbWUgbGlzdAo+Pj5bwqDCoCA3OS40OTk4
OTFdIHVoY2lfaGNkIDAwMDA6MDE6MDAuNDogc3RhcnR1cCBlcnJvciAtMTYKPj4+W8KgwqAgNzku
NTAxNTg4XSB1aGNpX2hjZCAwMDAwOjAxOjAwLjQ6IFVTQiBidXMgMyBkZXJlZ2lzdGVyZWQKPj4+
W8KgwqAgNzkuNTAzNDk0XSB1aGNpX2hjZCAwMDAwOjAxOjAwLjQ6IGluaXQgMDAwMDowMTowMC40
IGZhaWwsIC0xNgo+Pj5bwqDCoCA3OS41MDU0OTddIHVoY2lfaGNkOiBwcm9iZSBvZiAwMDAwOjAx
OjAwLjQgZmFpbGVkIHdpdGggZXJyb3IgLTE2Cj4+Pgo+Pj5JZiBJIGJvb3QgdGhlIHN5c3RlbSB3
aXRoIGlvbW11PW5vcHQgSSBzZWUgYW4gaW9tbXUgbWFwIGZhaWx1cmUgZHVlIHRvCj4+PnRoZSBw
cm90IGNoZWNrIGluIF9fZG9tYWluX21hcHBpbmc6Cj4+Pgo+Pj5bwqDCoCA0MC45NDA1ODldIHBj
aSAwMDAwOjAwOjFmLjA6IGlvbW11X2dyb3VwX2FkZF9kZXZpY2U6IGNhbGxpbmcgCj4+PmlvbW11
X2dyb3VwX2NyZWF0ZV9kaXJlY3RfbWFwcGluZ3MKPj4+W8KgwqAgNDAuOTQzNTU4XSBwY2kgMDAw
MDowMDoxZi4wOiAKPj4+aW9tbXVfZ3JvdXBfY3JlYXRlX2RpcmVjdF9tYXBwaW5nczogaXRlcmF0
aW5nIHRocm91Z2ggbWFwcGluZ3MKPj4+W8KgwqAgNDAuOTQ2NDAyXSBwY2kgMDAwMDowMDoxZi4w
OiAKPj4+aW9tbXVfZ3JvdXBfY3JlYXRlX2RpcmVjdF9tYXBwaW5nczogY2FsbGluZyBhcHBseV9y
ZXN2X3JlZ2lvbgo+Pj5bwqDCoCA0MC45NDkxODRdIHBjaSAwMDAwOjAwOjFmLjA6IAo+Pj5pb21t
dV9ncm91cF9jcmVhdGVfZGlyZWN0X21hcHBpbmdzOiBlbnRyeSB0eXBlIGlzIGRpcmVjdAo+Pj5b
wqDCoCA0MC45NTE4MTldIERNQVI6IGludGVsX2lvbW11X21hcDogZW50ZXIKPj4+W8KgwqAgNDAu
OTUzMTI4XSBETUFSOiBfX2RvbWFpbl9tYXBwaW5nOiBwcm90ICYgCj4+PihETUFfUFRFX1JFQUR8
RE1BX1BURV9XUklURSkgPT0gMAo+Pj5bwqDCoCA0MC45NTU0ODZdIERNQVI6IGRvbWFpbl9tYXBw
aW5nOiBfX2RvbWFpbl9tYXBwaW5nIGZhaWxlZAo+Pj5bwqDCoCA0MC45NTczNDhdIERNQVI6IGlu
dGVsX2lvbW11X21hcDogZG9tYWluX3Bmbl9tYXBwaW5nIHJldHVybmVkIC0yMgo+Pj5bwqDCoCA0
MC45NTk0NjZdIERNQVI6IGludGVsX2lvbW11X21hcDogbGVhdmUKPj4+W8KgwqAgNDAuOTU5NDY4
XSBpb21tdTogaW9tbXVfbWFwOiBvcHMtPm1hcCBmYWlsZWQgaW92YSAweDAgcGEgCj4+PjB4MDAw
MDAwMDAwMDAwMDAwMCBwZ3NpemUgMHgxMDAwCj4+PlvCoMKgIDQwLjk2MzUxMV0gcGNpIDAwMDA6
MDA6MWYuMDogCj4+PmlvbW11X2dyb3VwX2NyZWF0ZV9kaXJlY3RfbWFwcGluZ3M6IGlvbW11X21h
cCBmYWlsZWQKPj4+W8KgwqAgNDAuOTY2MDI2XSBwY2kgMDAwMDowMDoxZi4wOiAKPj4+aW9tbXVf
Z3JvdXBfY3JlYXRlX2RpcmVjdF9tYXBwaW5nczogbGVhdmluZyBmdW5jCj4+PlvCoMKgIDQwLjk2
ODQ4N10gcGNpIDAwMDA6MDA6MWYuMDogaW9tbXVfZ3JvdXBfYWRkX2RldmljZTogY2FsbGluZyAK
Pj4+X19pb21tdV9hdHRhY2hfZGV2aWNlCj4+PlvCoMKgIDQwLjk3MTAxNl0gcGNpIDAwMDA6MDA6
MWYuMDogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDE5Cj4+PlvCoMKgIDQwLjk3MjczMV0gcGNpIDAw
MDA6MDA6MWYuMDogRE1BUjogZG9tYWluLT50eXBlIGlzIGRtYQo+Pj4KPj4+L3N5cy9rZXJuZWwv
aW9tbXVfZ3JvdXBzLzE5Cj4+Pltyb290QGhwLWRsMzg4ZzgtMDcgMTldIyBjYXQgcmVzZXJ2ZWRf
cmVnaW9ucyAweDAwMDAwMDAwMDAwMDAwMDAgCj4+PjB4MDAwMDAwMDAwMGZmZmZmZiBkaXJlY3QK
Pj4+MHgwMDAwMDAwMGJkZjZlMDAwIDB4MDAwMDAwMDBiZGY4NGZmZiBkaXJlY3QKPj4+MHgwMDAw
MDAwMGZlZTAwMDAwIDB4MDAwMDAwMDBmZWVmZmZmZiBtc2kKPj4+Cj4+PjAwOjFmLjAgSVNBIGJy
aWRnZTogSW50ZWwgQ29ycG9yYXRpb24gQzYwMC9YNzkgc2VyaWVzIGNoaXBzZXQgTFBDIAo+Pj5D
b250cm9sbGVyCj4+Cj4+VGhpcyBzZWVtcyB0byBiZSBhbm90aGVyIGlzc3VlPwo+Pgo+PkJlc3Qg
cmVnYXJkcywKPj5iYW9sdQo+Cj5JbiBpbnRlbF9pb21tdV9nZXRfcmVzdl9yZWdpb25zIHRoaXMg
aW9tbXVfYWxsb2NfcmVzdl9yZWdpb24gaXMgY2FsbGVkCj53aXRoIHByb3Qgc2V0IHRvIDA6Cj4K
PiAgICAgICAgICAgICAgICBpZiAoKHBkZXYtPmNsYXNzID4+IDgpID09IFBDSV9DTEFTU19CUklE
R0VfSVNBKSB7Cj4gICAgICAgICAgICAgICAgICAgICAgICByZWcgPSBpb21tdV9hbGxvY19yZXN2
X3JlZ2lvbigwLCAxVUwgPDwgMjQsIDAsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBJT01NVV9SRVNWX0RJUkVDVF9SRUxBWEFCTEUpOwo+ICAg
ICAgICAgICAgICAgICAgICAgICAgaWYgKHJlZykKPgoKTG9va2luZyBhdCB0aGUgb2xkZXIgY29k
ZSBmb3IgdGhlIElTQSBicmlkZ2UgaXQgbG9va3MgbGlrZSBpdCBjYWxsZWQKaW9tbXVfcHJlcGFy
ZV9pZGVudGl0eV9tYXAgLT4gZG9tYWluX3ByZXBhcmVfaWRlbnRpdHlfbWFwIC0+CmlvbW11X2Rv
bWFpbl9pZGVudGl0eV9tYXAgLT4gYW5kIGZpbmFsbHkgX19kb21haW5fbWFwcGluZyB3aXRoIERN
QV9QVEVfUkVBRHxETUFfUFRFX1dSSVRFPwoKPkkgd29uZGVyIGlmIHRoaXMgaXMgYW4gaXNzdWUg
d2l0aCB0aGUgcmVnaW9uIHN0YXJ0aW5nIGF0IDB4MCBhbmQgdGhpcwo+Yml0IGluIGlvbW11X2dy
b3VwX2NyZWF0ZV9tYXBwaW5nczoKPgo+CQkJcGh5c19hZGRyID0gaW9tbXVfaW92YV90b19waHlz
KGRvbWFpbiwgYWRkcik7Cj4JCQlpZiAocGh5c19hZGRyKQo+CQkJCWNvbnRpbnVlOwoKRGlzcmVn
YXJkIHRoaXMKCj4KPk9mZiB0byBzdGljayBpbiBzb21lIG1vcmUgZGVidWdnaW5nIHN0YXRlbWVu
dHMuCj4KPlJlZ2FyZHMsCj5KZXJyeQo+Cj4+X19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KPj5pb21tdSBtYWlsaW5nIGxpc3QKPj5pb21tdUBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwo+Pmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2lvbW11CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
aW9tbXU=
