Return-Path: <SRS0=C6HT=CX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889A0C43461
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 04:21:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1035C20829
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 04:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJjnRllX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1035C20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5D6FA2051D;
	Mon, 14 Sep 2020 04:21:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YCHe+yTq5EXq; Mon, 14 Sep 2020 04:20:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id CC482204B2;
	Mon, 14 Sep 2020 04:20:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B13C5C0864;
	Mon, 14 Sep 2020 04:20:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EDC91C0051
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 04:20:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E593787175
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 04:20:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rXMvf2McXflg for <iommu@lists.linux-foundation.org>;
 Mon, 14 Sep 2020 04:20:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1AD9687174
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 04:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600057254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ij0YTaF6RiYno0x8sF/D5e5z9gxhF6aamWYdiKjdyYE=;
 b=MJjnRllXp0bZZMOBTtXM5CVDmenWWH6pGkSoO0TLk57zE2hjOPUNJbLSpwQ+kSyeC7efZ9
 0TgICmdgwvYcgCBef4SjuVbYXNQ2bAIKQof8rw4AAZv7qi833r3ku1IAosE9VtPNRH1SI+
 5QAmqiaJ+NLqz2P4RC0kyD7f4q3QUdQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-mnW_Qw2FPCe6DtMHLxgtzg-1; Mon, 14 Sep 2020 00:20:50 -0400
X-MC-Unique: mnW_Qw2FPCe6DtMHLxgtzg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A78F1074651;
 Mon, 14 Sep 2020 04:20:48 +0000 (UTC)
Received: from [10.72.13.25] (ovpn-13-25.pek2.redhat.com [10.72.13.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DAE371A837;
 Mon, 14 Sep 2020 04:20:11 +0000 (UTC)
Subject: Re: [PATCH v7 00/16] vfio: expose virtual Shared Virtual Addressing
 to VMs
To: Liu Yi L <yi.l.liu@intel.com>, alex.williamson@redhat.com,
 eric.auger@redhat.com, baolu.lu@linux.intel.com, joro@8bytes.org
References: <1599734733-6431-1-git-send-email-yi.l.liu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <411c81c0-f13c-37cc-6c26-cafb42b46b15@redhat.com>
Date: Mon, 14 Sep 2020 12:20:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1599734733-6431-1-git-send-email-yi.l.liu@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, ashok.raj@intel.com,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, stefanha@gmail.com,
 jun.j.tian@intel.com, iommu@lists.linux-foundation.org, yi.y.sun@intel.com,
 Jason Gunthorpe <jgg@nvidia.com>, hao.wu@intel.com
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

Ck9uIDIwMjAvOS8xMCDkuIvljYg2OjQ1LCBMaXUgWWkgTCB3cm90ZToKPiBTaGFyZWQgVmlydHVh
bCBBZGRyZXNzaW5nIChTVkEpLCBhLmsuYSwgU2hhcmVkIFZpcnR1YWwgTWVtb3J5IChTVk0pIG9u
Cj4gSW50ZWwgcGxhdGZvcm1zIGFsbG93cyBhZGRyZXNzIHNwYWNlIHNoYXJpbmcgYmV0d2VlbiBk
ZXZpY2UgRE1BIGFuZAo+IGFwcGxpY2F0aW9ucy4gU1ZBIGNhbiByZWR1Y2UgcHJvZ3JhbW1pbmcg
Y29tcGxleGl0eSBhbmQgZW5oYW5jZSBzZWN1cml0eS4KPgo+IFRoaXMgVkZJTyBzZXJpZXMgaXMg
aW50ZW5kZWQgdG8gZXhwb3NlIFNWQSB1c2FnZSB0byBWTXMuIGkuZS4gU2hhcmluZwo+IGd1ZXN0
IGFwcGxpY2F0aW9uIGFkZHJlc3Mgc3BhY2Ugd2l0aCBwYXNzdGhydSBkZXZpY2VzLiBUaGlzIGlz
IGNhbGxlZAo+IHZTVkEgaW4gdGhpcyBzZXJpZXMuIFRoZSB3aG9sZSB2U1ZBIGVuYWJsaW5nIHJl
cXVpcmVzIFFFTVUvVkZJTy9JT01NVQo+IGNoYW5nZXMuIEZvciBJT01NVSBhbmQgUUVNVSBjaGFu
Z2VzLCB0aGV5IGFyZSBpbiBzZXBhcmF0ZSBzZXJpZXMgKGxpc3RlZAo+IGluIHRoZSAiUmVsYXRl
ZCBzZXJpZXMiKS4KPgo+IFRoZSBoaWdoLWxldmVsIGFyY2hpdGVjdHVyZSBmb3IgU1ZBIHZpcnR1
YWxpemF0aW9uIGlzIGFzIGJlbG93LCB0aGUga2V5Cj4gZGVzaWduIG9mIHZTVkEgc3VwcG9ydCBp
cyB0byB1dGlsaXplIHRoZSBkdWFsLXN0YWdlIElPTU1VIHRyYW5zbGF0aW9uICgKPiBhbHNvIGtu
b3duIGFzIElPTU1VIG5lc3RpbmcgdHJhbnNsYXRpb24pIGNhcGFiaWxpdHkgaW4gaG9zdCBJT01N
VS4KPgo+Cj4gICAgICAuLS0tLS0tLS0tLS0tLS4gIC4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0uCj4gICAgICB8ICAgdklPTU1VICAgIHwgIHwgR3Vlc3QgcHJvY2VzcyBDUjMsIEZMIG9ubHl8
Cj4gICAgICB8ICAgICAgICAgICAgIHwgICctLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0nCj4g
ICAgICAuLS0tLS0tLS0tLS0tLS0tLS8KPiAgICAgIHwgUEFTSUQgRW50cnkgfC0tLSBQQVNJRCBj
YWNoZSBmbHVzaCAtCj4gICAgICAnLS0tLS0tLS0tLS0tLScgICAgICAgICAgICAgICAgICAgICAg
IHwKPiAgICAgIHwgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgVgo+ICAgICAg
fCAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgIENSMyBpbiBHUEEKPiAgICAgICctLS0tLS0t
LS0tLS0tJwo+IEd1ZXN0Cj4gLS0tLS0tfCBTaGFkb3cgfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tfC0tLS0tLS0tCj4gICAgICAgIHYgICAgICAgIHYgICAgICAgICAgICAgICAgICAgICAgICAg
IHYKPiBIb3N0Cj4gICAgICAuLS0tLS0tLS0tLS0tLS4gIC4tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
Lgo+ICAgICAgfCAgIHBJT01NVSAgICB8ICB8IEJpbmQgRkwgZm9yIEdWQS1HUEEgIHwKPiAgICAg
IHwgICAgICAgICAgICAgfCAgJy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0nCj4gICAgICAuLS0tLS0t
LS0tLS0tLS0tLS8gIHwKPiAgICAgIHwgUEFTSUQgRW50cnkgfCAgICAgViAoTmVzdGVkIHhsYXRl
KQo+ICAgICAgJy0tLS0tLS0tLS0tLS0tLS1cLi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS4KPiAgICAgIHwgICAgICAgICAgICAgfHxTTCBmb3IgR1BBLUhQQSwgZGVmYXVsdCBkb21haW58
Cj4gICAgICB8ICAgICAgICAgICAgIHwgICAnLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
Jwo+ICAgICAgJy0tLS0tLS0tLS0tLS0nCj4gV2hlcmU6Cj4gICAtIEZMID0gRmlyc3QgbGV2ZWwv
c3RhZ2Ugb25lIHBhZ2UgdGFibGVzCj4gICAtIFNMID0gU2Vjb25kIGxldmVsL3N0YWdlIHR3byBw
YWdlIHRhYmxlcwo+Cj4gUGF0Y2ggT3ZlcnZpZXc6Cj4gICAxLiByZXBvcnRzIElPTU1VIG5lc3Rp
bmcgaW5mbyB0byB1c2Vyc3BhY2UgKCBwYXRjaCAwMDAxLCAwMDAyLCAwMDAzLCAwMDE1ICwgMDAx
NikKPiAgIDIuIHZmaW8gc3VwcG9ydCBmb3IgUEFTSUQgYWxsb2NhdGlvbiBhbmQgZnJlZSBmb3Ig
Vk1zIChwYXRjaCAwMDA0LCAwMDA1LCAwMDA3KQo+ICAgMy4gYSBmaXggdG8gYSByZXZpc2l0IGlu
IGludGVsIGlvbW11IGRyaXZlciAocGF0Y2ggMDAwNikKPiAgIDQuIHZmaW8gc3VwcG9ydCBmb3Ig
YmluZGluZyBndWVzdCBwYWdlIHRhYmxlIHRvIGhvc3QgKHBhdGNoIDAwMDgsIDAwMDksIDAwMTAp
Cj4gICA1LiB2ZmlvIHN1cHBvcnQgZm9yIElPTU1VIGNhY2hlIGludmFsaWRhdGlvbiBmcm9tIFZN
cyAocGF0Y2ggMDAxMSkKPiAgIDYuIHZmaW8gc3VwcG9ydCBmb3IgdlNWQSB1c2FnZSBvbiBJT01N
VS1iYWNrZWQgbWRldnMgKHBhdGNoIDAwMTIpCj4gICA3LiBleHBvc2UgUEFTSUQgY2FwYWJpbGl0
eSB0byBWTSAocGF0Y2ggMDAxMykKPiAgIDguIGFkZCBkb2MgZm9yIFZGSU8gZHVhbCBzdGFnZSBj
b250cm9sIChwYXRjaCAwMDE0KQoKCklmIGl0J3MgcG9zc2libGUsIEkgd291bGQgc3VnZ2VzdCBh
IGdlbmVyaWMgdUFQSSBpbnN0ZWFkIG9mIGEgVkZJTyAKc3BlY2lmaWMgb25lLgoKSmFzb24gc3Vn
Z2VzdCBzb21ldGhpbmcgbGlrZSAvZGV2L3N2YS4gVGhlcmUgd2lsbCBiZSBhIGxvdCBvZiBvdGhl
ciAKc3Vic3lzdGVtcyB0aGF0IGNvdWxkIGJlbmVmaXQgZnJvbSB0aGlzIChlLmcgdkRQQSkuCgpI
YXZlIHlvdSBldmVyIGNvbnNpZGVyZWQgdGhpcyBhcHByb2FjaD8KClRoYW5rcwoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0
CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
