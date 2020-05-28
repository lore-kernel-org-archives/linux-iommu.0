Return-Path: <SRS0=4TkS=7K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBABC433DF
	for <iommu@archiver.kernel.org>; Thu, 28 May 2020 07:22:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E94B207BC
	for <iommu@archiver.kernel.org>; Thu, 28 May 2020 07:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UkueWRj7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E94B207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E76C6889CA;
	Thu, 28 May 2020 07:22:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v7pzVtezs3Pn; Thu, 28 May 2020 07:22:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3D94088888;
	Thu, 28 May 2020 07:22:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 223C8C07FF;
	Thu, 28 May 2020 07:22:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 468F7C016F
 for <iommu@lists.linux-foundation.org>; Thu, 28 May 2020 07:22:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3E879888F8
 for <iommu@lists.linux-foundation.org>; Thu, 28 May 2020 07:22:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CDMMf9wgUe6t for <iommu@lists.linux-foundation.org>;
 Thu, 28 May 2020 07:22:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4186388888
 for <iommu@lists.linux-foundation.org>; Thu, 28 May 2020 07:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590650519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zEBM0q4fZKyfjw7D1kyoHM1xb9sriIyKbIiYsNtDAYk=;
 b=UkueWRj7YHIxLvaz11ZyjhAJXikivu4+C4al5kopX4kyrEP9h9b9q7UzuUi4WkHe2aiutG
 sxn/+OC73k24yFDBfDfOkDFurk+s03wz1whhjDCyxt9+sCEtocczrExW6m6Hk8D/WyCimL
 oGnQva+gunXGVQbqan1fZ7f53aVeZ3w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-coeiy8M4OwqtVw4hX2GvfQ-1; Thu, 28 May 2020 03:21:55 -0400
X-MC-Unique: coeiy8M4OwqtVw4hX2GvfQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCF0C107ACCD;
 Thu, 28 May 2020 07:21:53 +0000 (UTC)
Received: from [10.36.113.56] (ovpn-113-56.ams2.redhat.com [10.36.113.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B8AA410013DB;
 Thu, 28 May 2020 07:21:48 +0000 (UTC)
Subject: Re: [RFC PATCH] iommu/arm-smmu: Add module parameter to set msi iova
 address
To: Robin Murphy <robin.murphy@arm.com>,
 Srinath Mannam <srinath.mannam@broadcom.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>
References: <1590595398-4217-1-git-send-email-srinath.mannam@broadcom.com>
 <f9b221cf-1c7f-9f95-133b-dca65197b6c2@arm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <8de9d9dd-16f9-482b-0ecf-f2f103ede86b@redhat.com>
Date: Thu, 28 May 2020 09:21:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <f9b221cf-1c7f-9f95-133b-dca65197b6c2@arm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org
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

SGksCgpPbiA1LzI3LzIwIDc6MzAgUE0sIFJvYmluIE11cnBoeSB3cm90ZToKPiBPbiAyMDIwLTA1
LTI3IDE3OjAzLCBTcmluYXRoIE1hbm5hbSB3cm90ZToKPj4gVGhpcyBwYXRjaCBnaXZlcyB0aGUg
cHJvdmlzaW9uIHRvIGNoYW5nZSBkZWZhdWx0IHZhbHVlIG9mIE1TSSBJT1ZBIGJhc2UKPj4gdG8g
cGxhdGZvcm0ncyBzdWl0YWJsZSBJT1ZBIHVzaW5nIG1vZHVsZSBwYXJhbWV0ZXIuIFRoZSBwcmVz
ZW50Cj4+IGhhcmRjb2RlZCBNU0kgSU9WQSBiYXNlIG1heSBub3QgYmUgdGhlIGFjY2Vzc2libGUg
SU9WQSByYW5nZXMgb2YKPj4gcGxhdGZvcm0uCj4gCj4gVGhhdCBpbiBpdHNlbGYgZG9lc24ndCBz
ZWVtIGVudGlyZWx5IHVucmVhc29uYWJsZTsgSUlSQyB0aGUgY3VycmVudAo+IGFkZHJlc3MgaXMg
anVzdCBhbiBhcmJpdHJhcnkgY2hvaWNlIHRvIGZpdCBuaWNlbHkgaW50byBRZW11J3MgbWVtb3J5
Cj4gbWFwLApjb3JyZWN0CiBhbmQgdGhlcmUgd2FzIGFsd2F5cyB0aGUgcG9zc2liaWxpdHkgdGhh
dCBpdCB3b3VsZG4ndCBzdWl0IGV2ZXJ5dGhpbmcuCgpJbmRlZWQgSSBhbHNvIHJlY2VudGx5IGhh
ZCB0aGlzIGNhc2Ugb2YgUENJIGhvc3QgYnJpZGdlIGNvbGxpc2lvbiB3aXRoCnRoZSBTVyBNU0kg
cmVzZXJ2ZWQgd2luZG93IC0gbWF5YmUgdGhhdCdzIHRoZSBzYW1lIDstKSAtLgo+IAo+PiBTaW5j
ZSBjb21taXQgYWFkYWQwOTdjZDQ2ICgiaW9tbXUvZG1hOiBSZXNlcnZlIElPVkEgZm9yIFBDSWUg
aW5hY2Nlc3NpYmxlCj4+IERNQSBhZGRyZXNzIiksIGluYWNjZXNzaWJsZSBJT1ZBIGFkZHJlc3Mg
cmFuZ2VzIHBhcnNlZCBmcm9tIGRtYS1yYW5nZXMKPj4gcHJvcGVydHkgYXJlIHJlc2VydmVkLgo+
IAo+IFRoYXQsIGhvd2V2ZXIsIGRvZXNuJ3Qgc2VlbSB0byBmaXQgaGVyZTsgaW9tbXUtZG1hIG1h
cHMgTVNJIGRvb3JiZWxscwo+IGR5bmFtaWNhbGx5LCBzbyB0aGV5IGFyZW4ndCBhZmZlY3RlZCBi
eSByZXNlcnZlZCByZWdpb25zIGFueSBtb3JlIHRoYW4KPiByZWd1bGFyIERNQSBwYWdlcyBhcmUu
IEluIGZhY3QsIGl0IGV4cGxpY2l0bHkgaWdub3JlcyB0aGUgc29mdHdhcmUgTVNJCj4gcmVnaW9u
LCBzaW5jZSBhcyB0aGUgY29tbWVudCBzYXlzLCBpdCAqaXMqIHRoZSBzb2Z0d2FyZSB0aGF0IG1h
bmFnZXMgdGhvc2UuCj4gCj4gVGhlIE1TSV9JT1ZBX0JBU0UgcmVnaW9uIGV4aXN0cyBmb3IgVkZJ
TywgcHJlY2lzZWx5IGJlY2F1c2UgaW4gdGhhdCBjYXNlCj4gdGhlIGtlcm5lbCAqZG9lc24ndCog
Y29udHJvbCB0aGUgYWRkcmVzcyBzcGFjZSwgYnV0IHN0aWxsIG5lZWRzIHNvbWUgd2F5Cj4gdG8g
c3RlYWwgYSBiaXQgb2YgaXQgZm9yIE1TSXMgdGhhdCB0aGUgZ3Vlc3QgZG9lc24ndCBuZWNlc3Nh
cmlseSBrbm93Cj4gYWJvdXQsIGFuZCBnaXZlIHVzZXJzcGFjZSBhIGZpZ2h0aW5nIGNoYW5jZSBv
ZiBrbm93aW5nIHdoYXQgaXQncyB0YWtlbi4KPiBJIHRoaW5rIGF0IHRoZSB0aW1lIHdlIGRpc2N1
c3NlZCB0aGUgaWRlYSBvZiBhZGRpbmcgc29tZXRoaW5nIHRvIHRoZQo+IFZGSU8gdWFwaSBzdWNo
IHRoYXQgdXNlcnNwYWNlIGNvdWxkIG1vdmUgdGhpcyBhcm91bmQgaWYgaXQgd2FudGVkIG9yCj4g
bmVlZGVkIHRvLCBidXQgZGVjaWRlZCB3ZSBjb3VsZCBsaXZlIHdpdGhvdXQgdGhhdCBpbml0aWFs
bHkuCgpZZXMgaW5kZWVkIDstKQoKIFBlcmhhcHMgbm93Cj4gdGhlIHRpbWUgaGFzIGNvbWU/CgpE
byB5b3UgbWVhbiB5b3Ugd291bGQgd2VsY29tZSBhIFZGSU8gYmFzZWQgYXBwcm9hY2ggb3Igd291
bGQgYSBkcml2ZXIKcGFyYW1ldGVyIGJlIHN1ZmZpY2llbnQ/CgpUaGFua3MKCkVyaWMKCgo+IAo+
IFJvYmluLgo+IAo+PiBJZiBhbnkgcGxhdGZvcm0gaGFzIHRoZSBsaW1pdGFpb24gdG8gYWNjZXNz
IGRlZmF1bHQgTVNJIElPVkEsIHRoZW4gaXQgY2FuCj4+IGJlIGNoYW5nZWQgdXNpbmcgImFybS1z
bW11Lm1zaV9pb3ZhX2Jhc2U9MHhhMDAwMDAwMCIgY29tbWFuZCBsaW5lCj4+IGFyZ3VtZW50Lgo+
Pgo+PiBTaWduZWQtb2ZmLWJ5OiBTcmluYXRoIE1hbm5hbSA8c3JpbmF0aC5tYW5uYW1AYnJvYWRj
b20uY29tPgo+PiAtLS0KPj4gwqAgZHJpdmVycy9pb21tdS9hcm0tc21tdS5jIHwgNSArKysrLQo+
PiDCoCAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Cj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2FybS1zbW11LmMgYi9kcml2ZXJzL2lvbW11L2Fy
bS1zbW11LmMKPj4gaW5kZXggNGYxYTM1MC4uNWU1OWM5ZCAxMDA2NDQKPj4gLS0tIGEvZHJpdmVy
cy9pb21tdS9hcm0tc21tdS5jCj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvYXJtLXNtbXUuYwo+PiBA
QCAtNzIsNiArNzIsOSBAQCBzdGF0aWMgYm9vbCBkaXNhYmxlX2J5cGFzcyA9Cj4+IMKgIG1vZHVs
ZV9wYXJhbShkaXNhYmxlX2J5cGFzcywgYm9vbCwgU19JUlVHTyk7Cj4+IMKgIE1PRFVMRV9QQVJN
X0RFU0MoZGlzYWJsZV9ieXBhc3MsCj4+IMKgwqDCoMKgwqAgIkRpc2FibGUgYnlwYXNzIHN0cmVh
bXMgc3VjaCB0aGF0IGluY29taW5nIHRyYW5zYWN0aW9ucyBmcm9tCj4+IGRldmljZXMgdGhhdCBh
cmUgbm90IGF0dGFjaGVkIHRvIGFuIGlvbW11IGRvbWFpbiB3aWxsIHJlcG9ydCBhbiBhYm9ydAo+
PiBiYWNrIHRvIHRoZSBkZXZpY2UgYW5kIHdpbGwgbm90IGJlIGFsbG93ZWQgdG8gcGFzcyB0aHJv
dWdoIHRoZSBTTU1VLiIpOwo+PiArc3RhdGljIHVuc2lnbmVkIGxvbmcgbXNpX2lvdmFfYmFzZSA9
IE1TSV9JT1ZBX0JBU0U7Cj4+ICttb2R1bGVfcGFyYW0obXNpX2lvdmFfYmFzZSwgdWxvbmcsIFNf
SVJVR08pOwo+PiArTU9EVUxFX1BBUk1fREVTQyhtc2lfaW92YV9iYXNlLCAibXNpIGlvdmEgYmFz
ZSBhZGRyZXNzLiIpOwo+PiDCoCDCoCBzdHJ1Y3QgYXJtX3NtbXVfczJjciB7Cj4+IMKgwqDCoMKg
wqAgc3RydWN0IGlvbW11X2dyb3VwwqDCoMKgwqDCoMKgwqAgKmdyb3VwOwo+PiBAQCAtMTU2Niw3
ICsxNTY5LDcgQEAgc3RhdGljIHZvaWQgYXJtX3NtbXVfZ2V0X3Jlc3ZfcmVnaW9ucyhzdHJ1Y3QK
Pj4gZGV2aWNlICpkZXYsCj4+IMKgwqDCoMKgwqAgc3RydWN0IGlvbW11X3Jlc3ZfcmVnaW9uICpy
ZWdpb247Cj4+IMKgwqDCoMKgwqAgaW50IHByb3QgPSBJT01NVV9XUklURSB8IElPTU1VX05PRVhF
QyB8IElPTU1VX01NSU87Cj4+IMKgIC3CoMKgwqAgcmVnaW9uID0gaW9tbXVfYWxsb2NfcmVzdl9y
ZWdpb24oTVNJX0lPVkFfQkFTRSwgTVNJX0lPVkFfTEVOR1RILAo+PiArwqDCoMKgIHJlZ2lvbiA9
IGlvbW11X2FsbG9jX3Jlc3ZfcmVnaW9uKG1zaV9pb3ZhX2Jhc2UsIE1TSV9JT1ZBX0xFTkdUSCwK
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHJvdCwgSU9N
TVVfUkVTVl9TV19NU0kpOwo+PiDCoMKgwqDCoMKgIGlmICghcmVnaW9uKQo+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuOwo+Pgo+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2lvbW11
