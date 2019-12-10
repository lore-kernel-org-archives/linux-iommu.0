Return-Path: <SRS0=4E9V=2A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A560EC43603
	for <iommu@archiver.kernel.org>; Tue, 10 Dec 2019 07:45:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 699C620726
	for <iommu@archiver.kernel.org>; Tue, 10 Dec 2019 07:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUnBJOrj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 699C620726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0D96187BD9;
	Tue, 10 Dec 2019 07:45:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ejPlW+svaJDR; Tue, 10 Dec 2019 07:45:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 17A4B87BD7;
	Tue, 10 Dec 2019 07:45:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA82FC1796;
	Tue, 10 Dec 2019 07:45:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A622C0881
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 07:45:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2318B87BD9
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 07:45:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b9utqvaJ5aR5 for <iommu@lists.linux-foundation.org>;
 Tue, 10 Dec 2019 07:45:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3577487BD7
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 07:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575963900;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bDQjDwwFXrbqleSRbVwaaNvRDSA8qMnR7rQLQU2xHwI=;
 b=dUnBJOrja5XfIFpbD83AlaHOJe07B8pcs0OKCLXd35sLeeTBmoJfcdN24EaU0VJCPs0M2u
 RubKa2GzARI9Qfs6ei8phbi51C0EUfusozszWHVwsZhZUJAyLbMtI3xF79d5SgqUOio3Ld
 VOPsB1qwMQu6ZY+0rPEnNhwjhCwm49I=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-l1KBzcKWPcGcbOyhYlPVAA-1; Tue, 10 Dec 2019 02:44:58 -0500
Received: by mail-yb1-f200.google.com with SMTP id j133so13452266ybc.2
 for <iommu@lists.linux-foundation.org>; Mon, 09 Dec 2019 23:44:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to;
 bh=Do/8gcBqtFM6GbulHb5f4xePaJQ4efKBg1cRxhF30XI=;
 b=LlTFdbx7s/QmiTFJYmMaMmeo7yhQ6J+1gCrvXTGKFMEaoDZZaMRbatIiMpqoQDgdRK
 LCbDS97rN39VAuZtOHHDUTEGjQlnlmMKhf9LkBtxIOthmaCaWSlEDFSZPw5l+0yahHYR
 3ecQuYNNZtXuybeB2zpsqmHU64rEJDsb9tcahiwZ2v+LqwCaz0FnFpOmZYCoKrKhXJGO
 7h+tzz2+vw/E/UhmVC0EeSNaMhnHOvr16IF5iSOFmxIZIqCW4ojOyS3Ow3UM0kHGOUJx
 y7nUAO/KvU/krtZE9uEFiJh/jJx1CPho0w4Xgb33kRtY88KF+5kZjcOkp6FC/D76PbET
 QfGQ==
X-Gm-Message-State: APjAAAV2lYpfUkOxi9/XFfqPtcmwLXppgL6RpisfwlzwjDCdf1wJJ2GU
 K9g+kDPgG/Xw6ueFPCz4cGI2JH6Gn/dcyKmmY9rwy5ejaf2CCLANsDZIykqYgOdgUbWDKOxXrqr
 QzREt+1X+Zvo/jkY2f5poBVatbU+ELA==
X-Received: by 2002:a81:9a82:: with SMTP id
 r124mr21604799ywg.469.1575963898069; 
 Mon, 09 Dec 2019 23:44:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqw3PwUol1KF9EbWkUn064Hsyr9/fNbgr6C8o1+7doAdweZzgOsplg8DT30jzlIuKhph99uNCw==
X-Received: by 2002:a81:9a82:: with SMTP id
 r124mr21604786ywg.469.1575963897697; 
 Mon, 09 Dec 2019 23:44:57 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id p1sm1226341ywh.74.2019.12.09.23.44.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2019 23:44:56 -0800 (PST)
Date: Tue, 10 Dec 2019 00:44:55 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: dmar pte read access not set error messages on hp dl388 gen8
 systems
Message-ID: <20191210074455.skeeysdovozdfuqd@cantor>
References: <20191207022914.7uccwkmgadz4hvbf@cantor>
 <20191207024118.uwwzthqifh2dca5q@cantor>
 <7979b838-e2c5-4064-490c-8e0884909715@linux.intel.com>
 <20191210005234.kanygdcjgsgo7z6j@cantor>
 <77d3ca8e-cb8c-4392-fa99-c55daa263b8e@linux.intel.com>
 <20191210034753.wlmbqdvqpcnzfxyl@cantor>
 <20191210051830.n37dimvrrgtiuydk@cantor>
 <20191210054351.bswavli2z77zljvp@cantor>
 <20191210061620.gp3qe2ljq3hhbetx@cantor>
 <9b7297bd-fd26-8169-29c5-e662ef700051@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <9b7297bd-fd26-8169-29c5-e662ef700051@linux.intel.com>
X-MC-Unique: l1KBzcKWPcGcbOyhYlPVAA-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
Cc: iommu@lists.linux-foundation.org
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

T24gVHVlIERlYyAxMCAxOSwgTHUgQmFvbHUgd3JvdGU6Cj5IaSwKPgo+T24gMTIvMTAvMTkgMjox
NiBQTSwgSmVycnkgU25pdHNlbGFhciB3cm90ZToKPj5PbiBNb24gRGVjIDA5IDE5LCBKZXJyeSBT
bml0c2VsYWFyIHdyb3RlOgo+Pj5PbiBNb24gRGVjIDA5IDE5LCBKZXJyeSBTbml0c2VsYWFyIHdy
b3RlOgo+Pj4+T24gTW9uIERlYyAwOSAxOSwgSmVycnkgU25pdHNlbGFhciB3cm90ZToKPj4+Pltz
bmlwXQo+Pj4+Pgo+Pj4+PkEgY2FsbCB0byBpb21tdV9tYXAgaXMgZmFpbGluZy4KPj4+Pj4KPj4+
Pj5bwqDCoCAzNi42ODY4ODFdIHBjaSAwMDAwOjAxOjAwLjI6IGlvbW11X2dyb3VwX2FkZF9kZXZp
Y2U6IAo+Pj4+PmNhbGxpbmcgaW9tbXVfZ3JvdXBfY3JlYXRlX2RpcmVjdF9tYXBwaW5ncwo+Pj4+
PlvCoMKgIDM2LjY4OTg0M10gcGNpIDAwMDA6MDE6MDAuMjogCj4+Pj4+aW9tbXVfZ3JvdXBfY3Jl
YXRlX2RpcmVjdF9tYXBwaW5nczogaXRlcmF0aW5nIHRocm91Z2ggbWFwcGluZ3MKPj4+Pj5bwqDC
oCAzNi42OTI3NTddIHBjaSAwMDAwOjAxOjAwLjI6IAo+Pj4+PmlvbW11X2dyb3VwX2NyZWF0ZV9k
aXJlY3RfbWFwcGluZ3M6IGNhbGxpbmcgYXBwbHlfcmVzdl9yZWdpb24KPj4+Pj5bwqDCoCAzNi42
OTU1MjZdIHBjaSAwMDAwOjAxOjAwLjI6IGVfZGlyZWN0X21hcHBpbmdzOiBlbnRyeSB0eXBlIAo+
Pj4+PmlzIGRpcmVjdAo+Pj4+PlvCoMKgIDM3LjE5ODA1M10gaW9tbXU6IGlvbW11X21hcDogb3Bz
LT5tYXAgZmFpbGVkIGlvdmEgCj4+Pj4+MHhiZGRkZTAwMCBwYSAweDAwMDAwMDAwYmRkZGUwMDAg
cGdzaXplIDB4MTAwMAo+Pj4+PlvCoMKgIDM3LjIwMTM1N10gcGNpIDAwMDA6MDE6MDAuMjogCj4+
Pj4+aW9tbXVfZ3JvdXBfY3JlYXRlX2RpcmVjdF9tYXBwaW5nczogaW9tbXVfbWFwIGZhaWxlZAo+
Pj4+PlvCoMKgIDM3LjIwMzk3M10gcGNpIDAwMDA6MDE6MDAuMjogCj4+Pj4+aW9tbXVfZ3JvdXBf
Y3JlYXRlX2RpcmVjdF9tYXBwaW5nczogbGVhdmluZyBmdW5jCj4+Pj4+W8KgwqAgMzcuMjA2Mzg1
XSBwY2kgMDAwMDowMTowMC4yOiBpb21tdV9ncm91cF9hZGRfZGV2aWNlOiAKPj4+Pj5jYWxsaW5n
IF9faW9tbXVfYXR0YWNoX2RldmljZQo+Pj4+PlvCoMKgIDM3LjIwODk1MF0gcGNpIDAwMDA6MDE6
MDAuMjogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDI1Cj4+Pj4+W8KgwqAgMzcuMjEwNjYwXSBwY2kg
MDAwMDowMTowMC4yOiBETUFSOiBkb21haW4tPnR5cGUgaXMgZG1hCj4+Pj4+Cj4+Pj4KPj4+Pkl0
IGJhaWxzIGF0IHRoZSBkbWFyX2RvbWFpbi0+ZmxhZ3MgJiBET01BSU5fRkxBR19MT1NFX0NISUxE
UkVOIGNoZWNrCj4+Pj5hdCB0aGUgYmVnaW5uaW5nIG9mIGludGVsX2lvbW11X21hcC7CoCBJIHdp
bGwgdmVyaWZ5LCBidXQgaXQgbG9va3MgbGlrZQo+Pj4+dGhhdCBpcyBnZXR0aW5nIHNldCB3aGVu
IGludGVsX2lvbW11X2FkZF9kZXZpY2UgaXMgY2FsbGVkIGZvciAwMTowMC4xLgo+Pj4+cmVxdWVz
dF9kZWZhdWx0X2RvbWFpbl9mb3JfZGV2IGZvciAwMTowMC4xIHdpbGwgcmV0dXJuIC1FQlVTWSBi
ZWNhdXNlCj4+Pj5pb21tdV9ncm91cF9kZXZpY2VfY291bnQoZ3JvdXApICE9IDEuCj4+Pj4KPj4+
Cj4+PkFsc28gSSBzZWUgMDE6MDAuMCBhbmQgb3RoZXJzIHRoYXQgYXJlIHRoZSBmaXJzdCBpbiBh
IGdyb3VwIAo+Pj5leGl0aW5nIGlvbW11X2dyb3VwX2NyZWF0ZV9kaXJlY3RfbWFwcGluZ3MKPj4+
YXQgdGhlICghZG9tYWluIHx8IGRvbWFpbi0+dHlwZSAhPSBJT01NVV9ET01BSU5fRE1BKSBjaGVj
ay4gSW4gCj4+PnJlcXVlc3RfZGVmYXVsdF9kb21haW5fZm9yX2RldiBkZWZhdWx0X2RvbWFpbgo+
Pj5kb2Vzbid0IGdldHRpbmcgc2V0IHVudGlsIGFmdGVyIHRoYXQgY2FsbC4gU2hvdWxkIHRoZSAK
Pj4+aW9tbXVfZ3JvdXBfY3JlYXRlX2RpcmVjdF9tYXBwaW5ncyBjYWxsIGJlIG1vdmVkIGJlbG93
Cj4+PndoZXJlIGdyb3VwLT5kZWZhdWx0X2RvbWFpbiBnZXRzIHNldD8KPj4+Cj4+Cj4+RG9pbmcg
dGhpcyB0aGUgc3lzdGVtIGJvb3RzLCBhbmQgSSBkb24ndCBnZXQgYW55IGRtYXIgcHRlIHJlYWQg
Cj4+ZXJyb3JzLiBJIHN0aWxsIHNlZSB0aGUgbWFwIGZhaWxpbmcgYmVjYXVzZQo+Pm9mIHRoZSBE
T01BSU5fRkxBR19MT1NFX0NISUxEUkVOIGluIHRob3NlIGNhc2VzIG1lbnRpb25lZCBhYm92ZSwg
YnV0IAo+Pml0IG5vIGxvbmdlciBpcyBzcGl0dGluZyBvdXQgdG9ucyBvZgo+PmRtYXIgcHRlIHJl
YWQgZXJyb3JzLgo+Cj5Zb3UgY2FuIHBvc3QgYSBwYXRjaCBpZiB5b3UgdGhpbmsgdGhpcyBpcyB3
b3J0aCBvZi4KPgo+QmVzdCByZWdhcmRzLAo+YmFvbHUKPgoKSSB3aWxsIHNlbmQgYSBwYXRjaCB0
b21vcnJvdy4gSW4gdGhlIGNhc2Ugd2hlcmUgeW91IGhhdmUKZGVmYXVsdCBwYXNzdGhyb3VnaCBl
bmFibGVkLCBpZiB0aGUgZGVmYXVsdCBkb21haW4gdHlwZQpmb3IgdGhlIGZpcnN0IGRldmljZSBp
biBhIGdyb3VwIGlzIGRtYSB0aGUgY2FsbCB3aWxsIGZhaWwsIGJlY2F1c2UKaW9tbXVfZ3JvdXBf
Y3JlYXRlX2RpcmVjdF9tYXBwaW5ncyB1c2VzIGdyb3VwLT5kZWZhdWx0X2RvbWFpbiBhbmQKdGhh
dCB3aWxsIGhhdmUgYW4gaWRlbnRpdHkgdHlwZSB1bnRpbCBncm91cC0+ZGVmYXVsdF9kb21haW4g
Z2V0cwpzZXQgcmlnaHQgYWZ0ZXIgdGhlIGlvbW11X2dyb3VwX2NyZWF0ZV9kaXJlY3RfbWFwcGlu
Z3MgY2FsbC4KClJlZ2FyZHMsCkplcnJ5Cgo+Pgo+Pj4+PkFsc28gZmFpbHMgZm9yIDAxOjAwLjQ6
Cj4+Pj4+Cj4+Pj4+W8KgwqAgMzcuMjEyNDQ4XSBwY2kgMDAwMDowMTowMC40OiBpb21tdV9ncm91
cF9hZGRfZGV2aWNlOiAKPj4+Pj5jYWxsaW5nIGlvbW11X2dyb3VwX2NyZWF0ZV9kaXJlY3RfbWFw
cGluZ3MKPj4+Pj5bwqDCoCAzNy4yMTUzODJdIHBjaSAwMDAwOjAxOjAwLjQ6IAo+Pj4+PmlvbW11
X2dyb3VwX2NyZWF0ZV9kaXJlY3RfbWFwcGluZ3M6IGl0ZXJhdGluZyB0aHJvdWdoIG1hcHBpbmdz
Cj4+Pj4+W8KgwqAgMzcuMjE4MTcwXSBwY2kgMDAwMDowMTowMC40OiAKPj4+Pj5pb21tdV9ncm91
cF9jcmVhdGVfZGlyZWN0X21hcHBpbmdzOiBjYWxsaW5nIGFwcGx5X3Jlc3ZfcmVnaW9uCj4+Pj4+
W8KgwqAgMzcuMjIwOTMzXSBwY2kgMDAwMDowMTowMC40OiAKPj4+Pj5pb21tdV9ncm91cF9jcmVh
dGVfZGlyZWN0X21hcHBpbmdzOiBlbnRyeSB0eXBlIGlzIAo+Pj4+PmRpcmVjdC1yZWxheGFibGUK
Pj4+Pj5bwqDCoCAzNy4yMjM5MzJdIGlvbW11OiBpb21tdV9tYXA6IG9wcy0+bWFwIGZhaWxlZCBp
b3ZhIAo+Pj4+PjB4YmRkZGUwMDAgcGEgMHgwMDAwMDAwMGJkZGRlMDAwIHBnc2l6ZSAweDEwMDAK
Pj4+Pj5bwqDCoCAzNy4yMjY4NTddIHBjaSAwMDAwOjAxOjAwLjQ6IAo+Pj4+PmlvbW11X2dyb3Vw
X2NyZWF0ZV9kaXJlY3RfbWFwcGluZ3M6IGlvbW11X21hcCBmYWlsZWQKPj4+Pj5bwqDCoCAzNy4y
MjkzMDBdIHBjaSAwMDAwOjAxOjAwLjQ6IAo+Pj4+PmlvbW11X2dyb3VwX2NyZWF0ZV9kaXJlY3Rf
bWFwcGluZ3M6IGxlYXZpbmcgZnVuYwo+Pj4+PlvCoMKgIDM3LjIzMTY0OF0gcGNpIDAwMDA6MDE6
MDAuNDogaW9tbXVfZ3JvdXBfYWRkX2RldmljZTogCj4+Pj4+Y2FsbGluZyBfX2lvbW11X2F0dGFj
aF9kZXZpY2UKPj4+Pj5bwqDCoCAzNy4yMzQxOTRdIHBjaSAwMDAwOjAxOjAwLjQ6IEFkZGluZyB0
byBpb21tdSBncm91cCAyNQo+Pj4+PlvCoMKgIDM3LjIzNjE5Ml0gcGNpIDAwMDA6MDE6MDAuNDog
RE1BUjogZG9tYWluLT50eXBlIGlzIGRtYQo+Pj4+PlvCoMKgIDM3LjIzNzk1OF0gcGNpIDAwMDA6
MDE6MDAuNDogRE1BUjogZGV2aWNlIGRlZmF1bHQgZG9tYWluIAo+Pj4+PnR5cGUgaXMgaWRlbnRp
dHkuIHJlcXVlc3RpbmcgaWRlbnRpdHkgZG9tYWluCj4+Pj4+W8KgwqAgMzcuMjQxMDYxXSBwY2kg
MDAwMDowMTowMC40OiBkb24ndCBjaGFuZ2UgbWFwcGluZ3Mgb2YgCj4+Pj4+ZXhpc3RpbmcgZDM3
LjQ4OTg3MF0gcGNpIDAwMDA6MDE6MDAuNDogRE1BUjogRGV2aWNlIHVzZXMgYSAKPj4+Pj5wcml2
YXRlIGlkZW50aXR5IGRvbWFpbi4KPj4+Pj4KPj4+Pj5UaGVyZSBpcyBhbiBSTVJSIGZvciAweGJk
ZGRlMDAwLTB4ZGRkZGVmZmY6Cj4+Pj4+Cj4+Pj4+WzYzQWggMTU5NMKgwqAgMl3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgU3VidGFibGUgVHlwZSA6IDAwMDEgW1Jlc2VydmVkIAo+Pj4+
Pk1lbW9yeSBSZWdpb25dCj4+Pj4+WzYzQ2ggMTU5NsKgwqAgMl3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBMZW5ndGggOiAwMDM2Cj4+Pj4+Cj4+Pj4+WzYzRWgg
MTU5OMKgwqAgMl3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFJlc2Vy
dmVkIDogMDAwMAo+Pj4+Pls2NDBoIDE2MDDCoMKgIDJdwqDCoMKgwqDCoMKgwqDCoMKgwqAgUENJ
IFNlZ21lbnQgTnVtYmVyIDogMDAwMAo+Pj4+Pls2NDJoIDE2MDLCoMKgIDhdwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgQmFzZSBBZGRyZXNzIDogMDAwMDAwMDBCRERERTAwMAo+Pj4+
Pls2NEFoIDE2MTDCoMKgIDhdwqDCoMKgwqDCoMKgwqDCoMKgIEVuZCBBZGRyZXNzIChsaW1pdCkg
OiAwMDAwMDAwMEJERERFRkZGCj4+Pj4+Cj4+Pj4+WzY1MmggMTYxOMKgwqAgMV3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIERldmljZSBTY29wZSBUeXBlIDogMDEgW1BDSSBFbmRwb2ludCBEZXZpY2Vd
Cj4+Pj4+WzY1M2ggMTYxOcKgwqAgMV3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBF
bnRyeSBMZW5ndGggOiAwQQo+Pj4+Pls2NTRoIDE2MjDCoMKgIDJdwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBSZXNlcnZlZCA6IDAwMDAKPj4+Pj5bNjU2aCAxNjIywqDC
oCAxXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgRW51bWVyYXRpb24gSUQgOiAwMAo+Pj4+
Pls2NTdoIDE2MjPCoMKgIDFdwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBQQ0kgQnVzIE51
bWJlciA6IDAwCj4+Pj4+Cj4+Pj4+WzY1OGggMTYyNMKgwqAgMl3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIFBDSSBQYXRoIDogMUMsMDcKPj4+Pj4KPj4+Pj5bNjVBaCAx
NjI2wqDCoCAyXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUENJIFBh
dGggOiAwMCwwMAo+Pj4+Pgo+Pj4+Pgo+Pj4+Pls2NUNoIDE2MjjCoMKgIDFdwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBEZXZpY2UgU2NvcGUgVHlwZSA6IDAxIFtQQ0kgRW5kcG9pbnQgRGV2aWNlXQo+
Pj4+Pls2NURoIDE2MjnCoMKgIDFdwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgRW50
cnkgTGVuZ3RoIDogMEEKPj4+Pj5bNjVFaCAxNjMwwqDCoCAyXcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgUmVzZXJ2ZWQgOiAwMDAwCj4+Pj4+WzY2MGggMTYzMsKgwqAg
MV3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEVudW1lcmF0aW9uIElEIDogMDAKPj4+Pj5b
NjYxaCAxNjMzwqDCoCAxXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUENJIEJ1cyBOdW1i
ZXIgOiAwMAo+Pj4+Pgo+Pj4+Pls2NjJoIDE2MzTCoMKgIDJdwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBQQ0kgUGF0aCA6IDFDLDA3Cj4+Pj4+Cj4+Pj4+WzY2NGggMTYz
NsKgwqAgMl3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFBDSSBQYXRo
IDogMDAsMDIKPj4+Pj4KPj4+Pj4KPj4+Pj5bNjY2aCAxNjM4wqDCoCAxXcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgRGV2aWNlIFNjb3BlIFR5cGUgOiAwMSBbUENJIEVuZHBvaW50IERldmljZV0KPj4+
Pj5bNjY3aCAxNjM5wqDCoCAxXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEVudHJ5
IExlbmd0aCA6IDBBCj4+Pj4+WzY2OGggMTY0MMKgwqAgMl3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIFJlc2VydmVkIDogMDAwMAo+Pj4+Pls2NkFoIDE2NDLCoMKgIDFd
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBFbnVtZXJhdGlvbiBJRCA6IDAwCj4+Pj4+WzY2
QmggMTY0M8KgwqAgMV3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFBDSSBCdXMgTnVtYmVy
IDogMDAKPj4+Pj4KPj4+Pj5bNjZDaCAxNjQ0wqDCoCAyXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgUENJIFBhdGggOiAxQywwNwo+Pj4+Pgo+Pj4+Pls2NkVoIDE2NDbC
oMKgIDJdwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBQQ0kgUGF0aCA6
IDAwLDA0Cj4+Pj4+Cj4+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9p
b21tdQ==
