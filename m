Return-Path: <SRS0=N4Nm=5B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5154CC0044D
	for <iommu@archiver.kernel.org>; Mon, 16 Mar 2020 08:59:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 152F620658
	for <iommu@archiver.kernel.org>; Mon, 16 Mar 2020 08:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aHsdOfgD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 152F620658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D6DF52010C;
	Mon, 16 Mar 2020 08:59:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h9+vuNVnhVyE; Mon, 16 Mar 2020 08:59:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9B8E72035C;
	Mon, 16 Mar 2020 08:59:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B296C18DA;
	Mon, 16 Mar 2020 08:59:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9067BC013E
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 08:59:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7EA3686672
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 08:59:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id haib_mLdM-XY for <iommu@lists.linux-foundation.org>;
 Mon, 16 Mar 2020 08:59:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B392786463
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 08:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584349152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Yb6X1nf1afqu1woqOPhFH/C7hFOIBFvA8rMXchYAn8=;
 b=aHsdOfgDAN+Za8eHX7rxeICiZQU76vOaXLWIqazZ5EES2ru7nZFr5xD93C8+aKfbumNyS2
 6fRNzWEoOchz8QjiVZuQ7uM5o5dENt4W7dqjmk8K+RIVwFBwio+k/r3XhAeORT6YqftbiM
 Eq5EuLD3kCMksJnx4xzQHd1qZ+g0Q+o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-EL-lcsolPh2hO--2MdBz_A-1; Mon, 16 Mar 2020 04:59:10 -0400
X-MC-Unique: EL-lcsolPh2hO--2MdBz_A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E51298017CC;
 Mon, 16 Mar 2020 08:59:08 +0000 (UTC)
Received: from [10.36.118.12] (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 34F9060BF3;
 Mon, 16 Mar 2020 08:58:59 +0000 (UTC)
Subject: Re: [RFC PATCH] vfio: Ignore -ENODEV when getting MSI cookie
To: Robin Murphy <robin.murphy@arm.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Will Deacon <will@kernel.org>
References: <20200312181950.60664-1-andre.przywara@arm.com>
 <c9e00735-9673-2016-b274-d5290b648a06@arm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <1db62a9a-feb4-e717-53c7-65431fd6c6c1@redhat.com>
Date: Mon, 16 Mar 2020 09:58:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <c9e00735-9673-2016-b274-d5290b648a06@arm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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

SGkgQW5kcmUsCgpPbiAzLzEzLzIwIDM6MDggUE0sIFJvYmluIE11cnBoeSB3cm90ZToKPiBPbiAy
MDIwLTAzLTEyIDY6MTkgcG0sIEFuZHJlIFByenl3YXJhIHdyb3RlOgo+PiBXaGVuIHdlIHRyeSB0
byBnZXQgYW4gTVNJIGNvb2tpZSBmb3IgYSBWRklPIGRldmljZSwgdGhhdCBjYW4gZmFpbCBpZgo+
PiBDT05GSUdfSU9NTVVfRE1BIGlzIG5vdCBzZXQuIEluIHRoaXMgY2FzZSBpb21tdV9nZXRfbXNp
X2Nvb2tpZSgpIHJldHVybnMKPj4gLUVOT0RFViwgYW5kIHRoYXQgc2hvdWxkIG5vdCBiZSBmYXRh
bC4KPj4KPj4gSWdub3JlIHRoYXQgY2FzZSBhbmQgcHJvY2VlZCB3aXRoIHRoZSBpbml0aWFsaXNh
dGlvbi4KPj4KPj4gVGhpcyBmaXhlcyBWRklPIHdpdGggYSBwbGF0Zm9ybSBkZXZpY2Ugb24gdGhl
IENhbHhlZGEgTWlkd2F5IChubyBNU0lzKS4KPj4KPj4gU2lnbmVkLW9mZi1ieTogQW5kcmUgUHJ6
eXdhcmEgPGFuZHJlLnByenl3YXJhQGFybS5jb20+Cj4+IC0tLQo+PiBIaSwKPj4KPj4gbm90IHN1
cmUgdGhpcyBpcyB0aGUgcmlnaHQgZml4LCBvciB3ZSBzaG91bGQgcmF0aGVyIGNoZWNrIGlmIHRo
ZQo+PiBwbGF0Zm9ybSBkb2Vzbid0IHN1cHBvcnQgTVNJcyBhdCBhbGwgKHdoaWNoIGRvZXNuJ3Qg
c2VlbSB0byBiZSBlYXN5Cj4+IHRvIGRvKS4KPj4gT3IgaXMgdGhpcyBiZWNhdXNlIGFybS1zbW11
LmMgYWx3YXlzIHJlc2VydmVzIGFuIElPTU1VX1JFU1ZfU1dfTVNJCj4+IHJlZ2lvbj8KPiAKPiBC
b3RoLCByZWFsbHkgLSBpZGVhbGx5IFZGSU8gc2hvdWxkIGJlIGFibGUgdG8gc2tpcCBhbGwgTVNJ
X3JlbGF0ZWQgc2V0dXAKPiBpZiB0aGUgc3lzdGVtIGRvZXNuJ3Qgc3VwcG9ydCBNU0lzLCBidXQg
ZXF1YWxseSB0aGUgU01NVSBkcml2ZXJzIHdvdWxkCj4gYWxzbyBpZGVhbGx5IG5vdCBleHBvc2Ug
YSBwb2ludGxlc3MgU1dfTVNJIHJlZ2lvbiBpbiB0aGUgc2FtZSBzaXR1YXRpb24uCj4gCj4gSW4g
bGlldSBvZiBhICduaWNlJyB3YXkgb2YgYWNoZWl2aW5nIHRoYXQsIEkgdGhpbmsgdGhpcyBwYXRj
aCBzZWVtcwo+IHJlYXNvbmFibGUgLSBFTk9ERVYgZG9lc24ndCBjbGFzaCB3aXRoIGFueSByZWFs
IGVycm9yIHRoYXQgY2FuIG9jY3VyCj4gd2hlbiBpb21tdS1kbWEgaXMgcHJlc2VudCwgYW5kIGNh
cnJ5aW5nIG9uIHdpdGhvdXQgYSBjb29raWUgc2hvdWxkIGJlCj4gZmluZSBzaW5jZSB0aGUgTVNJ
IGhvb2tzIHRoYXQgd291bGQgb3RoZXJ3aXNlIGRlcmVmZXJlbmNlIGl0IHdpbGwgYWxzbwo+IGJl
IG5vLW9wcy4KCkxvb2tzIE9LIHRvIG1lIGFzIHdlbGwuCgpBYm91dCBsb29raW5nIGF0IHdoZXRo
ZXIgTVNJIGlzIGluIHVzZSBJIHdvbmRlciB3aGV0aGVyIHdlIGNvdWxkIGRvIGxpa2UKaXJxX2Rv
bWFpbl9jaGVja19tc2lfcmVtYXAoKSBpbiBrZXJuZWwvaXJxL2lycWRvbWFpbi5jIHdpdGhvdXQg
Y2hlY2tpbmcKSVJRX0RPTUFJTl9GTEFHX01TSV9SRU1BUC4KCkJ1dCBpZiB0aGlzIHNpbXBsZSBw
YXRjaCBmaXhlcyB0aGlzIG1hcmdpbmFsIE1pZHdheSB2ZmlvLXBsYXRmb3JtIHVzZQpjYXNlLCB0
aGF0IHNob3VsZCBiZSBnb29kIGVub3VnaC4KClJldmlld2VkLWJ5OiBFcmljIEF1Z2VyIDxlcmlj
LmF1Z2VyQHJlZGhhdC5jb20+CgpUaGFua3MKCkVyaWMKPiAKPiBQZXJoYXBzIGl0IG1pZ2h0IGJl
IHdvcnRoIGEgY29tbWVudCB0byBjbGFyaWZ5IHRoYXQgdGhpcyBpcyBzcGVjaWZpY2FsbHkKPiB0
byBhbGxvdyB2ZmlvLXBsYXRmb3JtIHRvIHdvcmsgd2l0aCBpb21tdS1kbWEgZGlzYWJsZWQsIGJ1
dCBlaXRoZXIgd2F5LAo+IAo+IEFja2VkLWJ5OiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBh
cm0uY29tPgo+IAo+PiBBbHNvIHRoaXMgc2VlbXMgdG8gYmUgbG9uZyBicm9rZW4sIGFjdHVhbGx5
IHNpbmNlIEVyaWMgaW50cm9kdWNlZCBNU0kKPj4gc3VwcG9ydCBpbiA0LjEwLXJjMywgYnV0IGF0
IGxlYXN0IHNpbmNlIHRoZSBpbml0aWFsaXNhdGlvbiBvcmRlciB3YXMKPj4gZml4ZWQgd2l0aCBm
NjgxMGMxNWNmOS4KPiAKPiBJJ20gc3VyZSB0aGUgZW50aXJlIE1pZHdheSB1c2VyYmFzZSBoYXZl
IGJlZW4gdXAtaW4tYXJtcyB0aGUgd2hvbGUKPiB0aW1lLi4uIDpQCj4gCj4gUm9iaW4uCj4gCj4+
Cj4+IEdyYXRlZnVsIGZvciBhbnkgaW5zaWdodC4KPj4KPj4gQ2hlZXJzLAo+PiBBbmRyZQo+Pgo+
PiDCoCBkcml2ZXJzL3ZmaW8vdmZpb19pb21tdV90eXBlMS5jIHwgMiArLQo+PiDCoCAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdmZpby92ZmlvX2lvbW11X3R5cGUxLmMKPj4gYi9kcml2ZXJzL3ZmaW8vdmZpb19p
b21tdV90eXBlMS5jCj4+IGluZGV4IGExNzdiZjJjNjY4My4uNDY3ZTIxN2VmMDlhIDEwMDY0NAo+
PiAtLS0gYS9kcml2ZXJzL3ZmaW8vdmZpb19pb21tdV90eXBlMS5jCj4+ICsrKyBiL2RyaXZlcnMv
dmZpby92ZmlvX2lvbW11X3R5cGUxLmMKPj4gQEAgLTE3ODYsNyArMTc4Niw3IEBAIHN0YXRpYyBp
bnQgdmZpb19pb21tdV90eXBlMV9hdHRhY2hfZ3JvdXAodm9pZAo+PiAqaW9tbXVfZGF0YSwKPj4g
wqAgwqDCoMKgwqDCoCBpZiAocmVzdl9tc2kpIHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9
IGlvbW11X2dldF9tc2lfY29va2llKGRvbWFpbi0+ZG9tYWluLCByZXN2X21zaV9iYXNlKTsKPj4g
LcKgwqDCoMKgwqDCoMKgIGlmIChyZXQpCj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAocmV0ICYmIHJl
dCAhPSAtRU5PREVWKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91dF9kZXRh
Y2g7Cj4+IMKgwqDCoMKgwqAgfQo+PiDCoAo+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2lvbW11
