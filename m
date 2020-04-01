Return-Path: <SRS0=PWDw=5R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51551C2D0E7
	for <iommu@archiver.kernel.org>; Wed,  1 Apr 2020 07:32:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 135A320787
	for <iommu@archiver.kernel.org>; Wed,  1 Apr 2020 07:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XHbUf6mw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 135A320787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CEFA38902E;
	Wed,  1 Apr 2020 07:32:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xq9CVosGzcNZ; Wed,  1 Apr 2020 07:32:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 34F8489026;
	Wed,  1 Apr 2020 07:32:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27A47C1D7F;
	Wed,  1 Apr 2020 07:32:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 977BDC089F
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 07:32:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 924378902B
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 07:32:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MRjm4OF4ucmF for <iommu@lists.linux-foundation.org>;
 Wed,  1 Apr 2020 07:32:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9C22F89026
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 07:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585726371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=er5PhZKmj1VjxisaWzK7w2rQSjkemW6KF003piclXVY=;
 b=XHbUf6mwQwPfGY3QA55NlH4Xo/fBgHcWDBFhOXEhv5s/5/S76Tlpne4h8h6TNXrzcXnKZy
 5sVA9/MajfwLNGUNxSdu23HvplAGGawo7Iu0cFYrfRifAoBP5Wrq6bAHDzqPboPc7l/MMR
 SjWLKevsD7KkcEdML3FO1IiBCwZzYog=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-wzVRvjV2M9etq3cxccPC5g-1; Wed, 01 Apr 2020 03:32:47 -0400
X-MC-Unique: wzVRvjV2M9etq3cxccPC5g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BA841007269;
 Wed,  1 Apr 2020 07:32:45 +0000 (UTC)
Received: from [10.36.112.58] (ovpn-112-58.ams2.redhat.com [10.36.112.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 33AB85D9CA;
 Wed,  1 Apr 2020 07:32:39 +0000 (UTC)
Subject: Re: [PATCH V10 08/11] iommu/vt-d: Add svm/sva invalidate function
To: "Liu, Yi L" <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <1584746861-76386-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1584746861-76386-9-git-send-email-jacob.jun.pan@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7FA0AB@SHSMSX104.ccr.corp.intel.com>
 <3215b83c-81f7-a30f-fe82-a51f29d7b874@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D800D67@SHSMSX104.ccr.corp.intel.com>
 <20200331135807.4e9976ab@jacob-builder>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D803C33@SHSMSX104.ccr.corp.intel.com>
 <A2975661238FB949B60364EF0F2C25743A21D52E@SHSMSX104.ccr.corp.intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <d1cd2852-876a-b072-8576-962a6e61b9a9@redhat.com>
Date: Wed, 1 Apr 2020 09:32:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A21D52E@SHSMSX104.ccr.corp.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Jonathan Cameron <jic23@kernel.org>
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

SGksCgpPbiA0LzEvMjAgOToxMyBBTSwgTGl1LCBZaSBMIHdyb3RlOgo+PiBGcm9tOiBUaWFuLCBL
ZXZpbiA8a2V2aW4udGlhbkBpbnRlbC5jb20+Cj4+IFNlbnQ6IFdlZG5lc2RheSwgQXByaWwgMSwg
MjAyMCAyOjMwIFBNCj4+IFRvOiBKYWNvYiBQYW4gPGphY29iLmp1bi5wYW5AbGludXguaW50ZWwu
Y29tPgo+PiBTdWJqZWN0OiBSRTogW1BBVENIIFYxMCAwOC8xMV0gaW9tbXUvdnQtZDogQWRkIHN2
bS9zdmEgaW52YWxpZGF0ZSBmdW5jdGlvbgo+Pgo+Pj4gRnJvbTogSmFjb2IgUGFuIDxqYWNvYi5q
dW4ucGFuQGxpbnV4LmludGVsLmNvbT4KPj4+IFNlbnQ6IFdlZG5lc2RheSwgQXByaWwgMSwgMjAy
MCA0OjU4IEFNCj4+Pgo+Pj4gT24gVHVlLCAzMSBNYXIgMjAyMCAwMjo0OToyMSArMDAwMAo+Pj4g
IlRpYW4sIEtldmluIiA8a2V2aW4udGlhbkBpbnRlbC5jb20+IHdyb3RlOgo+Pj4KPj4+Pj4gRnJv
bTogQXVnZXIgRXJpYyA8ZXJpYy5hdWdlckByZWRoYXQuY29tPgo+Pj4+PiBTZW50OiBTdW5kYXks
IE1hcmNoIDI5LCAyMDIwIDExOjM0IFBNCj4+Pj4+Cj4+Pj4+IEhpLAo+Pj4+Pgo+Pj4+PiBPbiAz
LzI4LzIwIDExOjAxIEFNLCBUaWFuLCBLZXZpbiB3cm90ZToKPj4+Pj4+PiBGcm9tOiBKYWNvYiBQ
YW4gPGphY29iLmp1bi5wYW5AbGludXguaW50ZWwuY29tPgo+Pj4+Pj4+IFNlbnQ6IFNhdHVyZGF5
LCBNYXJjaCAyMSwgMjAyMCA3OjI4IEFNCj4+Pj4+Pj4KPj4+Pj4+PiBXaGVuIFNoYXJlZCBWaXJ0
dWFsIEFkZHJlc3MgKFNWQSkgaXMgZW5hYmxlZCBmb3IgYSBndWVzdCBPUyB2aWEKPj4+Pj4+PiB2
SU9NTVUsIHdlIG5lZWQgdG8gcHJvdmlkZSBpbnZhbGlkYXRpb24gc3VwcG9ydCBhdCBJT01NVSBB
UEkKPj4+Pj4+PiBhbmQKPj4+Pj4gZHJpdmVyCj4+Pj4+Pj4gbGV2ZWwuIFRoaXMgcGF0Y2ggYWRk
cyBJbnRlbCBWVC1kIHNwZWNpZmljIGZ1bmN0aW9uIHRvCj4+Pj4+Pj4gaW1wbGVtZW50IGlvbW11
IHBhc3Nkb3duIGludmFsaWRhdGUgQVBJIGZvciBzaGFyZWQgdmlydHVhbCBhZGRyZXNzLgo+Pj4+
Pj4+Cj4+Pj4+Pj4gVGhlIHVzZSBjYXNlIGlzIGZvciBzdXBwb3J0aW5nIGNhY2hpbmcgc3RydWN0
dXJlIGludmFsaWRhdGlvbgo+Pj4+Pj4+IG9mIGFzc2lnbmVkIFNWTSBjYXBhYmxlIGRldmljZXMu
IEVtdWxhdGVkIElPTU1VIGV4cG9zZXMgcXVldWUKPj4+PiAgWy4uLl0KPj4+PiAgWy4uLl0KPj4+
Pj4gdG8KPj4+Pj4+PiArICogVlQtZCBncmFudWxhcml0eS4gSW52YWxpZGF0aW9uIGlzIHR5cGlj
YWxseSBpbmNsdWRlZCBpbiB0aGUKPj4+Pj4+PiB1bm1hcAo+Pj4+PiBvcGVyYXRpb24KPj4+Pj4+
PiArICogYXMgYSByZXN1bHQgb2YgRE1BIG9yIFZGSU8gdW5tYXAuIEhvd2V2ZXIsIGZvciBhc3Np
Z25lZAo+Pj4+Pj4+IGRldmljZXMKPj4+Pj4gZ3Vlc3QKPj4+Pj4+PiArICogb3ducyB0aGUgZmly
c3QgbGV2ZWwgcGFnZSB0YWJsZXMuIEludmFsaWRhdGlvbnMgb2YKPj4+Pj4+PiB0cmFuc2xhdGlv
biBjYWNoZXMgaW4KPj4+Pj4gdGhlCj4+Pj4gIFsuLi5dCj4+Pj4gIFsuLi5dCj4+Pj4gIFsuLi5d
Cj4+Pj4+Cj4+PiBpbnZfdHlwZV9ncmFudV9tYXBbSU9NTVVfQ0FDSEVfSU5WX1RZUEVfTlJdW0lP
TU1VX0lOVl9HUkFOVV8KPj4+Pj4+PiBOUl0gPSB7Cj4+Pj4+Pj4gKwkvKgo+Pj4+Pj4+ICsJICog
UEFTSUQgYmFzZWQgSU9UTEIgaW52YWxpZGF0aW9uOiBQQVNJRCBzZWxlY3RpdmUgKHBlcgo+Pj4+
Pj4+IFBBU0lEKSwKPj4+Pj4+PiArCSAqIHBhZ2Ugc2VsZWN0aXZlIChhZGRyZXNzIGdyYW51bGFy
aXR5KQo+Pj4+Pj4+ICsJICovCj4+Pj4+Pj4gKwl7MCwgMSwgMX0sCj4+Pj4+Pj4gKwkvKiBQQVNJ
RCBiYXNlZCBkZXYgVExCcywgb25seSBzdXBwb3J0IGFsbCBQQVNJRHMgb3IKPj4+Pj4+PiBzaW5n
bGUgUEFTSUQgKi8KPj4+Pj4+PiArCXsxLCAxLCAwfSwKPj4+Pj4+Cj4+Pj4+PiBJcyB0aGlzIGNv
bWJpbmF0aW9uIGNvcnJlY3Q/IHdoZW4gc2luZ2xlIFBBU0lEIGlzIGJlaW5nCj4+Pj4+PiBzcGVj
aWZpZWQsIGl0IGlzIGVzc2VudGlhbGx5IGEgcGFnZS1zZWxlY3RpdmUgaW52YWxpZGF0aW9uIHNp
bmNlCj4+Pj4+PiB5b3UgbmVlZCBwcm92aWRlIEFkZHJlc3MgYW5kIFNpemUuCj4+Pj4+IElzbid0
IGl0IHRoZSBzYW1lIHdoZW4gRz0xPyBTdGlsbCB0aGUgYWRkci9zaXplIGlzIHVzZWQuIERvZXNu
J3QKPj4+Pj4gaXQKPj4+Pgo+Pj4+IEkgdGhvdWdodCBhZGRyL3NpemUgaXMgbm90IHVzZWQgd2hl
biBHPTEsIGJ1dCBpdCBtaWdodCBiZSB3cm9uZy4gSSdtCj4+Pj4gY2hlY2tpbmcgd2l0aCBvdXIg
dnQtZCBzcGVjIG93bmVyLgo+Pj4+Cj4+Pgo+Pj4+PiBjb3JyZXNwb25kIHRvIElPTU1VX0lOVl9H
UkFOVV9BRERSIHdpdGgKPj4gSU9NTVVfSU5WX0FERFJfRkxBR1NfUEFTSUQKPj4+Pj4gZmxhZyB1
bnNldD8KPj4+Pj4KPj4+Pj4gc28gezAsIDAsIDF9Pwo+Pj4+Cj4+PiBJIGFtIG5vdCBzdXJlIEkg
Z290IHlvdXIgbG9naWMuIFRoZSB0aHJlZSBmaWVsZHMgY29ycmVzcG9uZCB0bwo+Pj4gCUlPTU1V
X0lOVl9HUkFOVV9ET01BSU4sCS8qIGRvbWFpbi1zZWxlY3RpdmUKPj4+IGludmFsaWRhdGlvbiAq
Lwo+Pj4gCUlPTU1VX0lOVl9HUkFOVV9QQVNJRCwJLyogUEFTSUQtc2VsZWN0aXZlIGludmFsaWRh
dGlvbiAqLwo+Pj4gCUlPTU1VX0lOVl9HUkFOVV9BRERSLAkvKiBwYWdlLXNlbGVjdGl2ZSBpbnZh
bGlkYXRpb24gKgo+Pj4KPj4+IEZvciBkZXZUTEIsIHdlIHVzZSBkb21haW4gYXMgZ2xvYmFsIHNp
bmNlIHRoZXJlIGlzIG5vIGRvbWFpbi4gVGhlbiBJCj4+PiBjYW1lIHVwIHdpdGggezEsIDEsIDB9
LCB3aGljaCBtZWFucyB3ZSBjb3VsZCBoYXZlIGdsb2JhbCBhbmQgcGFzaWQKPj4+IGdyYW51IGlu
dmFsaWRhdGlvbiBmb3IgUEFTSUQgYmFzZWQgZGV2VExCLgo+Pj4KPj4+IElmIHRoZSBjYWxsZXIg
YWxzbyBwcm92aWRlIGFkZHIgYW5kIFMgYml0LCB0aGUgZmx1c2ggcm91dGluZSB3aWxsIHB1dAo+
Pgo+PiAiYWxzbyIgLT4gIm11c3QiLCBiZWNhdXNlIHZ0LWQgcmVxdWlyZXMgYWRkci9zaXplIG11
c3QgYmUgcHJvdmlkZWQgaW4KPj4gZGV2dGxiCj4+IGRlc2NyaXB0b3IsIHRoYXQgaXMgd2h5IEVy
aWMgc3VnZ2VzdHMgezAsIDAsIDF9Lgo+IAo+IEkgdGhpbmsgaXQgc2hvdWxkIGJlIHswLCAwLCAx
fSA6LSkgYWRkciBmaWVsZCBhbmQgUyBmaWVsZCBhcmUgbXVzdCwgcGFzaWQKPiBmaWVsZCBkZXBl
bmRzIG9uIEcgYml0LgoKT24gbXkgc2lkZSwgSSB1bmRlcnN0b29kIGZyb20gdGhlIHNwZWMgdGhh
dCBhZGRyL1MgYXJlIGFsd2F5cyB1c2VkCndoYXRldmVyIHRoZSBncmFudWxhcml0eSwgaGVuY2Ug
dGhlIGFib3ZlIHN1Z2dlc3Rpb24uCgpBcyBhIGNvbXBhcmlzb24sIGZvciBQQVNJRCBiYXNlZCBJ
T1RMQiBpbnZhbGlkYXRpb24sIGl0IGlzIGNsZWFybHkKc3RhdGVkIHRoYXQgaWYgRyBtYXRjaGVz
IFBBU0lEIHNlbGVjdGl2ZSBpbnZhbGlkYXRpb24sIGFkZHJlc3MgZmllbGQgaXMKaWdub3JlZC4g
VGhpcyBpcyBub3Qgd3JpdHRlbiB0aGF0IHdheSBmb3IgUEFTSUQtYmFzZWQgZGV2aWNlIFRMQiBp
bnYuCj4gCj4gSSBkaWRu4oCZdCByZWFkIHRocm91Z2ggYWxsIGNvbW1lbnRzLiBIZXJlIGlzIGEg
Y29uY2VybiB3aXRoIHRoaXMgMi1EIHRhYmxlLAo+IHRoZSBpb21tdSBjYWNoZSB0eXBlIGlzIGRl
ZmluZWQgYXMgYmVsb3cuIEkgc3VwcG9zZSB0aGVyZSBpcyBhIHByb2JsZW0gaGVyZS4KPiBJZiBJ
J20gdXNpbmcgSU9NTVVfQ0FDSEVfSU5WX1RZUEVfUEFTSUQsIGl0IHdpbGwgYmV5b25kIHRoZSAy
LUQgdGFibGUuCj4gCj4gLyogSU9NTVUgcGFnaW5nIHN0cnVjdHVyZSBjYWNoZSAqLwo+ICNkZWZp
bmUgSU9NTVVfQ0FDSEVfSU5WX1RZUEVfSU9UTEIgICAgICAoMSA8PCAwKSAvKiBJT01NVSBJT1RM
QiAqLwo+ICNkZWZpbmUgSU9NTVVfQ0FDSEVfSU5WX1RZUEVfREVWX0lPVExCICAoMSA8PCAxKSAv
KiBEZXZpY2UgSU9UTEIgKi8KPiAjZGVmaW5lIElPTU1VX0NBQ0hFX0lOVl9UWVBFX1BBU0lEICAg
ICAgKDEgPDwgMikgLyogUEFTSUQgY2FjaGUgKi8KPiAjZGVmaW5lIElPTU1VX0NBQ0hFX0lOVl9U
WVBFX05SICAgICAgICAgKDMpCm91cHMgaW5kZWVkCgpUaGFua3MKCkVyaWMKPiAKPj4+Cj4+Pj4g
SSBoYXZlIG9uZSBtb3JlIG9wZW46Cj4+Pj4KPj4+PiBIb3cgZG9lcyB1c2Vyc3BhY2Uga25vdyB3
aGljaCBpbnZhbGlkYXRpb24gdHlwZS9ncmFuIGlzIHN1cHBvcnRlZD8KPj4+PiBJIGRpZG4ndCBz
ZWUgc3VjaCBjYXBhYmlsaXR5IHJlcG9ydGluZyBpbiBZaSdzIFZGSU8gdlNWQSBwYXRjaCBzZXQu
Cj4+Pj4gRG8gd2Ugd2FudCB0aGUgdXNlci9rZXJuZWwgYXNzdW1lIHRoZSBzYW1lIGNhcGFiaWxp
dHkgc2V0IGlmIHRoZXkKPj4+PiBhcmUgYXJjaGl0ZWN0dXJhbD8gSG93ZXZlciB0aGUga2VybmVs
IGNvdWxkIGFsc28gZG8gc29tZQo+Pj4+IG9wdGltaXphdGlvbiBlLmcuIGhpZGUgZGV2dGxiIGlu
dmFsaWRhdGlvbiBjYXBhYmlsaXR5IGdpdmVuIHRoYXQgdGhlCj4+Pj4ga2VybmVsIGFscmVhZHkg
aW52YWxpZGF0ZSBkZXZ0bGIgYXV0b21hdGljYWxseSB3aGVuIHNlcnZpbmcgaW90bGIKPj4+PiBp
bnZhbGlkYXRpb24uLi4KPj4+Pgo+Pj4gSW4gZ2VuZXJhbCwgd2UgYXJlIHRyZW5kaW5nIHRvIHVz
ZSBWRklPIGNhcGFiaWxpdHkgY2hhaW4gdG8gZXhwb3NlCj4+PiBpb21tdSBjYXBhYmlsaXRpZXMu
Cj4+Pgo+Pj4gQnV0IGZvciBhcmNoaXRlY3R1cmFsIGZlYXR1cmVzIHN1Y2ggYXMgdHlwZS9ncmFu
dSwgd2UgaGF2ZSB0byBhc3N1bWUKPj4+IHRoZSBzYW1lIGNhcGFiaWxpdHkgYmV0d2VlbiBob3N0
ICYgZ3Vlc3QuIEdyYW51IGFuZCB0eXBlcyBhcmUgbm90Cj4+PiBlbnVtZXJhdGVkIG9uIHRoZSBo
b3N0IElPTU1VIGVpdGhlci4KPj4+Cj4+PiBGb3IgZGV2VExCIG9wdGltaXphdGlvbiwgSSBhZ3Jl
ZSB3ZSBuZWVkIHRvIGV4cG9zZSBhIGNhcGFiaWxpdHkgdG8gdGhlCj4+PiBndWVzdCBzdGF0aW5n
IHRoYXQgaW1wbGljaXQgZGV2dGxiIGludmFsaWRhdGlvbiBpcyBzdXBwb3J0ZWQuCj4+PiBPdGhl
cndpc2UsIGlmIExpbnV4IGd1ZXN0IHJ1bnMgb24gb3RoZXIgT1NlcyBtYXkgbm90IHN1cHBvcnQg
aW1wbGljaXQKPj4+IGRldnRsYiBpbnZhbGlkYXRpb24uCj4+Pgo+Pj4gUmlnaHQgWWk/Cj4+Cj4+
IFRoYW5rcyBmb3IgZXhwbGFuYXRpb24uIFNvIHdlIGFyZSBhc3N1bWVkIHRvIHN1cHBvcnQgYWxs
IG9wZXJhdGlvbnMKPj4gZGVmaW5lZCBpbiBzcGVjLCBzbyBubyBuZWVkIHRvIGV4cG9zZSB0aGVt
IG9uZS1ieS1vbmUuIEZvciBvcHRpbWl6YXRpb24sCj4+IEknbSBmaW5lIHRvIGRvIGl0IGxhdGVy
Lgo+IAo+IHllcy4gOi0pCj4gCj4gUmVnYXJkcywKPiBZaSBMaXUKPiAKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
