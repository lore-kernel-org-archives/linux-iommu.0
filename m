Return-Path: <SRS0=smho=GI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02B3C433DB
	for <iommu@archiver.kernel.org>; Tue,  5 Jan 2021 07:52:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 651BC21973
	for <iommu@archiver.kernel.org>; Tue,  5 Jan 2021 07:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 651BC21973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id F010B8706D;
	Tue,  5 Jan 2021 07:52:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xNhezdPskIbR; Tue,  5 Jan 2021 07:52:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 14F0787068;
	Tue,  5 Jan 2021 07:52:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC092C0891;
	Tue,  5 Jan 2021 07:52:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E302C013A
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 07:52:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3487285ABB
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 07:52:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 10o7mkVSxiBh for <iommu@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 07:52:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0FA04858DD
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 07:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609833136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=igdDX6nTf4cbA39W1H+W8RdNCNfFYs684pcl8DlTBJY=;
 b=LASJhgSlmwIG9iwoIkzL06R/hMZu3anQBIFyTQTnvhEnfz7LsoEsaTr48sz9XEtemYRqf9
 CIRKytR3YiaaS0nwNaZ+VuWtZHxikuzDfWClXyfFEQWbBSfR525eKrH8WIpEC/Er5sROA3
 eRgtdmA+iwzRvbgtztQ8H5v5VqGLz0w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-uovIrgZqNJWO4xmv1igrsg-1; Tue, 05 Jan 2021 02:52:12 -0500
X-MC-Unique: uovIrgZqNJWO4xmv1igrsg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4A9015720;
 Tue,  5 Jan 2021 07:52:11 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-214.pek2.redhat.com
 [10.72.12.214])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2FF7971CA1;
 Tue,  5 Jan 2021 07:52:08 +0000 (UTC)
Subject: Re: [PATCH] iommu: check for the deferred attach when attaching a
 device
From: lijiang <lijiang@redhat.com>
To: linux-kernel@vger.kernel.org
References: <20201226053959.4222-1-lijiang@redhat.com>
 <33b6f925-71e6-5d9e-74c3-3e1eaf13398e@redhat.com>
Message-ID: <b385db3b-4506-6d75-49e1-e11064e65d6a@redhat.com>
Date: Tue, 5 Jan 2021 15:52:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <33b6f925-71e6-5d9e-74c3-3e1eaf13398e@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: "Lendacky, Thomas" <thomas.lendacky@amd.com>, jroedel@suse.de,
 iommu@lists.linux-foundation.org, will@kernel.org
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

5ZyoIDIwMjHlubQwMeaciDA15pelIDExOjU1LCBsaWppYW5nIOWGmemBkzoKPiBIaSwKPiAKPiBB
bHNvIGFkZCBKb2VyZyB0byBjYyBsaXN0Lgo+IAoKQWxzbyBhZGQgbW9yZSBwZW9wbGUgdG8gY2Mg
bGlzdCwgSmVycnkgU25pdHNlbGFhciBhbmQgVG9tIExlbmRhY2t5LgoKVGhhbmtzLgoKPiBUaGFu
a3MuCj4gTGlhbmJvCj4g5ZyoIDIwMjDlubQxMuaciDI25pelIDEzOjM5LCBMaWFuYm8gSmlhbmcg
5YaZ6YGTOgo+PiBDdXJyZW50bHksIGJlY2F1c2UgZG9tYWluIGF0dGFjaCBhbGxvd3MgdG8gYmUg
ZGVmZXJyZWQgZnJvbSBpb21tdQo+PiBkcml2ZXIgdG8gZGV2aWNlIGRyaXZlciwgYW5kIHdoZW4g
aW9tbXUgaW5pdGlhbGl6ZXMsIHRoZSBkZXZpY2VzCj4+IG9uIHRoZSBidXMgd2lsbCBiZSBzY2Fu
bmVkIGFuZCB0aGUgZGVmYXVsdCBncm91cHMgd2lsbCBiZSBhbGxvY2F0ZWQuCj4+Cj4+IER1ZSB0
byB0aGUgYWJvdmUgY2hhbmdlcywgc29tZSBkZXZpY2VzIGNvdWxkIGJlIGFkZGVkIHRvIHRoZSBz
YW1lCj4+IGdyb3VwIGFzIGJlbG93Ogo+Pgo+PiBbICAgIDMuODU5NDE3XSBwY2kgMDAwMDowMTow
MC4wOiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgMTYKPj4gWyAgICAzLjg2NDU3Ml0gcGNpIDAwMDA6
MDE6MDAuMTogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDE2Cj4+IFsgICAgMy44Njk3MzhdIHBjaSAw
MDAwOjAyOjAwLjA6IEFkZGluZyB0byBpb21tdSBncm91cCAxNwo+PiBbICAgIDMuODc0ODkyXSBw
Y2kgMDAwMDowMjowMC4xOiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgMTcKPj4KPj4gQnV0IHdoZW4g
YXR0YWNoaW5nIHRoZXNlIGRldmljZXMsIGl0IGRvZXNuJ3QgYWxsb3cgdGhhdCBhIGdyb3VwIGhh
cwo+PiBtb3JlIHRoYW4gb25lIGRldmljZSwgb3RoZXJ3aXNlIGl0IHdpbGwgcmV0dXJuIGFuIGVy
cm9yLiBUaGlzIGNvbmZsaWN0cwo+PiB3aXRoIHRoZSBkZWZlcnJlZCBhdHRhY2hpbmcuIFVuZm9y
dHVuYXRlbHksIGl0IGhhcyB0d28gZGV2aWNlcyBpbiB0aGUKPj4gc2FtZSBncm91cCBmb3IgbXkg
c2lkZSwgZm9yIGV4YW1wbGU6Cj4+Cj4+IFsgICAgOS42MjcwMTRdIGlvbW11X2dyb3VwX2Rldmlj
ZV9jb3VudCgpOiBkZXZpY2UgbmFtZVswXTowMDAwOjAxOjAwLjAKPj4gWyAgICA5LjYzMzU0NV0g
aW9tbXVfZ3JvdXBfZGV2aWNlX2NvdW50KCk6IGRldmljZSBuYW1lWzFdOjAwMDA6MDE6MDAuMQo+
PiAuLi4KPj4gWyAgIDEwLjI1NTYwOV0gaW9tbXVfZ3JvdXBfZGV2aWNlX2NvdW50KCk6IGRldmlj
ZSBuYW1lWzBdOjAwMDA6MDI6MDAuMAo+PiBbICAgMTAuMjYyMTQ0XSBpb21tdV9ncm91cF9kZXZp
Y2VfY291bnQoKTogZGV2aWNlIG5hbWVbMV06MDAwMDowMjowMC4xCj4+Cj4+IEZpbmFsbHksIHdo
aWNoIGNhdXNlZCB0aGUgZmFpbHVyZSBvZiB0ZzMgZHJpdmVyIHdoZW4gdGczIGRyaXZlciBjYWxs
cwo+PiB0aGUgZG1hX2FsbG9jX2NvaGVyZW50KCkgdG8gYWxsb2NhdGUgY29oZXJlbnQgbWVtb3J5
IGluIHRoZSB0ZzNfdGVzdF9kbWEoKS4KPj4KPj4gWyAgICA5LjY2MDMxMF0gdGczIDAwMDA6MDE6
MDAuMDogRE1BIGVuZ2luZSB0ZXN0IGZhaWxlZCwgYWJvcnRpbmcKPj4gWyAgICA5Ljc1NDA4NV0g
dGczOiBwcm9iZSBvZiAwMDAwOjAxOjAwLjAgZmFpbGVkIHdpdGggZXJyb3IgLTEyCj4+IFsgICAg
OS45OTc1MTJdIHRnMyAwMDAwOjAxOjAwLjE6IERNQSBlbmdpbmUgdGVzdCBmYWlsZWQsIGFib3J0
aW5nCj4+IFsgICAxMC4wNDMwNTNdIHRnMzogcHJvYmUgb2YgMDAwMDowMTowMC4xIGZhaWxlZCB3
aXRoIGVycm9yIC0xMgo+PiBbICAgMTAuMjg4OTA1XSB0ZzMgMDAwMDowMjowMC4wOiBETUEgZW5n
aW5lIHRlc3QgZmFpbGVkLCBhYm9ydGluZwo+PiBbICAgMTAuMzM0MDcwXSB0ZzM6IHByb2JlIG9m
IDAwMDA6MDI6MDAuMCBmYWlsZWQgd2l0aCBlcnJvciAtMTIKPj4gWyAgIDEwLjU3ODMwM10gdGcz
IDAwMDA6MDI6MDAuMTogRE1BIGVuZ2luZSB0ZXN0IGZhaWxlZCwgYWJvcnRpbmcKPj4gWyAgIDEw
LjYyMjYyOV0gdGczOiBwcm9iZSBvZiAwMDAwOjAyOjAwLjEgZmFpbGVkIHdpdGggZXJyb3IgLTEy
Cj4+Cj4+IEluIGFkZGl0aW9uLCB0aGUgc2ltaWxhciBzaXR1YXRpb25zIGFsc28gb2NjdXIgaW4g
b3RoZXIgZHJpdmVycyBzdWNoCj4+IGFzIHRoZSBibnh0X2VuIGRyaXZlci4gVGhhdCBjYW4gYmUg
cmVwcm9kdWNlZCBlYXNpbHkgaW4ga2R1bXAga2VybmVsCj4+IHdoZW4gU01FIGlzIGFjdGl2ZS4K
Pj4KPj4gQWRkIGEgY2hlY2sgZm9yIHRoZSBkZWZlcnJlZCBhdHRhY2ggaW4gdGhlIGlvbW11X2F0
dGFjaF9kZXZpY2UoKSBhbmQKPj4gYWxsb3cgdG8gYXR0YWNoIHRoZSBkZWZlcnJlZCBkZXZpY2Ug
cmVnYXJkbGVzcyBvZiBob3cgbWFueSBkZXZpY2VzCj4+IGFyZSBpbiBhIGdyb3VwLgo+Pgo+PiBT
aWduZWQtb2ZmLWJ5OiBMaWFuYm8gSmlhbmcgPGxpamlhbmdAcmVkaGF0LmNvbT4KPj4gLS0tCj4+
ICBkcml2ZXJzL2lvbW11L2lvbW11LmMgfCA1ICsrKystCj4+ICAxIGZpbGUgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lv
bW11L2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L2lvbW11LmMKPj4gaW5kZXggZmZlZWJkYThkNmRl
Li5kY2NhYjdiMTMzZmIgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW9tbXUuYwo+PiAr
KysgYi9kcml2ZXJzL2lvbW11L2lvbW11LmMKPj4gQEAgLTE5NjcsOCArMTk2NywxMSBAQCBpbnQg
aW9tbXVfYXR0YWNoX2RldmljZShzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW4sIHN0cnVjdCBk
ZXZpY2UgKmRldikKPj4gIAkgKi8KPj4gIAltdXRleF9sb2NrKCZncm91cC0+bXV0ZXgpOwo+PiAg
CXJldCA9IC1FSU5WQUw7Cj4+IC0JaWYgKGlvbW11X2dyb3VwX2RldmljZV9jb3VudChncm91cCkg
IT0gMSkKPj4gKwlpZiAoIWlvbW11X2lzX2F0dGFjaF9kZWZlcnJlZChkb21haW4sIGRldikgJiYK
Pj4gKwkgICAgaW9tbXVfZ3JvdXBfZGV2aWNlX2NvdW50KGdyb3VwKSAhPSAxKSB7Cj4+ICsJCWRl
dl9lcnJfcmF0ZWxpbWl0ZWQoZGV2LCAiR3JvdXAgaGFzIG1vcmUgdGhhbiBvbmUgZGV2aWNlXG4i
KTsKPj4gIAkJZ290byBvdXRfdW5sb2NrOwo+PiArCX0KPj4gIAo+PiAgCXJldCA9IF9faW9tbXVf
YXR0YWNoX2dyb3VwKGRvbWFpbiwgZ3JvdXApOwo+PiAgCj4+CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vaW9tbXU=
