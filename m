Return-Path: <SRS0=NW7i=JD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3046BC433B4
	for <iommu@archiver.kernel.org>; Tue,  6 Apr 2021 01:35:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9EAE613E5
	for <iommu@archiver.kernel.org>; Tue,  6 Apr 2021 01:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9EAE613E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F86F60B6C;
	Tue,  6 Apr 2021 01:35:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JYJqgQiLPjoM; Tue,  6 Apr 2021 01:35:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 22C1F60B68;
	Tue,  6 Apr 2021 01:35:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3054C000C;
	Tue,  6 Apr 2021 01:35:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77883C000A
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 01:35:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 58BF3848C2
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 01:35:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DfjSwQSE1Xwd for <iommu@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 01:35:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E76E3848C1
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 01:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617672938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kwZ8XyyzRZCBrGqzegCVhhjQ1Q2Ym617/sTrzH4w1XI=;
 b=byXv0wBgeKoPa1BWCNAXfxIERfEsfOqyFT0OZWsTnTkg3yTkyL8yWoOWO92DkZ46G4HAko
 vnFoH9bAJgA2C1QzdBMN3M4Bb11GhJ4Qt1jm/C5hKUWmjYN8jwIjTNJu6B9FkyUDb9ucRX
 s7pJJJkp1ODQ5MgnJ66A7hiLKJoEOng=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-M4zcdcyUNc24sYSeXmRvfQ-1; Mon, 05 Apr 2021 21:35:34 -0400
X-MC-Unique: M4zcdcyUNc24sYSeXmRvfQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D2DB81744F;
 Tue,  6 Apr 2021 01:35:32 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-96.pek2.redhat.com
 [10.72.13.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 35FB519C78;
 Tue,  6 Apr 2021 01:35:18 +0000 (UTC)
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
To: Jason Gunthorpe <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>
References: <20210319124645.GP2356281@nvidia.com> <YFSqDNJ5yagk4eO+@myrica>
 <20210319135432.GT2356281@nvidia.com> <20210319112221.5123b984@jacob-builder>
 <20210322120300.GU2356281@nvidia.com> <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132830.GO2356281@nvidia.com>
 <MWHPR11MB1886CAD48AFC156BFC7C1D398C7A9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210405234230.GF7405@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <fa57bde5-472f-6e66-3521-bfac7d6e4f8d@redhat.com>
Date: Tue, 6 Apr 2021 09:35:17 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210405234230.GF7405@nvidia.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, "Jiang, Dave" <dave.jiang@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>, "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 "Wu, Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNC82IMnPzuc3OjQyLCBKYXNvbiBHdW50aG9ycGUg0LS1wDoKPiBPbiBGcmksIEFw
ciAwMiwgMjAyMSBhdCAwODoyMjoyOEFNICswMDAwLCBUaWFuLCBLZXZpbiB3cm90ZToKPj4+IEZy
b206IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+Cj4+PiBTZW50OiBUdWVzZGF5LCBN
YXJjaCAzMCwgMjAyMSA5OjI5IFBNCj4+Pgo+Pj4+IEZpcnN0LCB1c2Vyc3BhY2UgbWF5IHVzZSBp
b2FzaWQgaW4gYSBub24tU1ZBIHNjZW5hcmlvIHdoZXJlIGlvYXNpZCBpcwo+Pj4+IGJvdW5kIHRv
IHNwZWNpZmljIHNlY3VyaXR5IGNvbnRleHQgKGUuZy4gYSBjb250cm9sIHZxIGluIHZEUEEpIGlu
c3RlYWQgb2YKPj4+PiB0eWluZyB0byBtbS4gSW4gdGhpcyBjYXNlIHRoZXJlIGlzIG5vIHBndGFi
bGUgYmluZGluZyBpbml0aWF0ZWQgZnJvbSB1c2VyCj4+Pj4gc3BhY2UuIEluc3RlYWQsIGlvYXNp
ZCBpcyBhbGxvY2F0ZWQgZnJvbSAvZGV2L2lvYXNpZCBhbmQgdGhlbiBwcm9ncmFtbWVkCj4+Pj4g
dG8gdGhlIGludGVuZGVkIHNlY3VyaXR5IGNvbnRleHQgdGhyb3VnaCBzcGVjaWZpYyBwYXNzdGhy
b3VnaCBmcmFtZXdvcmsKPj4+PiB3aGljaCBtYW5hZ2VzIHRoYXQgY29udGV4dC4KPj4+IFRoaXMg
c291bmRzIGxpa2UgdGhlIGV4YWN0IG9wcG9zaXRlIG9mIHdoYXQgSSdkIGxpa2UgdG8gc2VlLgo+
Pj4KPj4+IEkgZG8gbm90IHdhbnQgdG8gc2VlIGV2ZXJ5IHN1YnN5c3RlbSBnYWluaW5nIEFQSXMg
dG8gcHJvZ3JhbSBhCj4+PiBQQVNJRC4gQWxsIG9mIHRoYXQgc2hvdWxkIGJlIGNvbnNvbGlkYXRl
ZCBpbiAqb25lIHBsYWNlKi4KPj4+Cj4+PiBJIGRvIG5vdCB3YW50IHRvIHNlZSBWRFBBIGFuZCBW
RklPIGhhdmUgdHdvIG5lYXJseSBpZGVudGljYWwgc2V0cyBvZgo+Pj4gQVBJcyB0byBjb250cm9s
IHRoZSBQQVNJRC4KPj4+Cj4+PiBEcml2ZXJzIGNvbnN1bWluZyBhIFBBU0lELCBsaWtlIFZEUEEs
IHNob3VsZCBjb25zdW1lIHRoZSBQQVNJRCBhbmQgZG8KPj4+IG5vdGhpbmcgbW9yZSB0aGFuIGF1
dGhvcml6ZSB0aGUgSFcgdG8gdXNlIGl0Lgo+Pj4KPj4+IHF1ZW11IHNob3VsZCBoYXZlIGdlbmVy
YWwgY29kZSB1bmRlciB0aGUgdmlvbW11IGRyaXZlciB0aGF0IGRyaXZlcwo+Pj4gL2Rldi9pb2Fz
aWQgdG8gY3JlYXRlIFBBU0lEJ3MgYW5kIG1hbmFnZSB0aGUgSU8gbWFwcGluZyBhY2NvcmRpbmcg
dG8KPj4+IHRoZSBndWVzdCdzIG5lZWRzLgo+Pj4KPj4+IERyaXZlcnMgbGlrZSBWRFBBIGFuZCBW
RklPIHNob3VsZCBzaW1wbHkgYWNjZXB0IHRoYXQgUEFTSUQgYW5kCj4+PiBjb25maWd1cmUvYXV0
aG9yaXplIHRoZWlyIEhXIHRvIGRvIERNQSdzIHdpdGggaXRzIHRhZy4KPj4+Cj4+IEkgYWdyZWUg
d2l0aCB5b3Ugb24gY29uc29saWRhdGluZyB0aGluZ3MgaW4gb25lIHBsYWNlIChlc3BlY2lhbGx5
IGZvciB0aGUKPj4gZ2VuZXJhbCBTVkEgc3VwcG9ydCkuIEJ1dCBoZXJlIEkgd2FzIHJlZmVycmlu
ZyB0byBhbiB1c2FnZSB3aXRob3V0Cj4+IHBndGFibGUgYmluZGluZyAoUG9zc2libHkgSmFzb24u
IFcgY2FuIHNheSBtb3JlIGhlcmUpLCB3aGVyZSB0aGUKPj4gdXNlcnNwYWNlIGp1c3Qgd2FudHMg
dG8gYWxsb2NhdGUgUEFTSURzLCBwcm9ncmFtL2FjY2VwdCBQQVNJRHMgdG8KPj4gdmFyaW91cyB3
b3JrcXVldWVzIChkZXZpY2Ugc3BlY2lmaWMpLCBhbmQgdGhlbiB1c2UgTUFQL1VOTUFQCj4+IGlu
dGVyZmFjZSB0byBtYW5hZ2UgYWRkcmVzcyBzcGFjZXMgYXNzb2NpYXRlZCB3aXRoIGVhY2ggUEFT
SUQuCj4+IEkganVzdCB3YW50ZWQgdG8gcG9pbnQgb3V0IHRoYXQgdGhlIGxhdHRlciB0d28gc3Rl
cHMgYXJlIHRocm91Z2gKPj4gVkZJTy9WRFBBIHNwZWNpZmljIGludGVyZmFjZXMuCj4gTm8sIGRv
bid0IGRvIHRoYXQuCj4KPiBWRklPIGFuZCBWRFBBIGhhcyBubyBidWlzbmVzcyBoYXZpbmcgbWFw
L3VubWFwIGludGVyZmFjZXMgb25jZSB3ZSBoYXZlCj4gL2Rldi9pb2FzaWQuIFRoYXQgYWxsIGJl
bG9uZ3MgaW4gdGhlIGlvc2FpZCBzaWRlLgo+Cj4gSSBrbm93IHRoZXkgaGF2ZSB0aG9zZSBpbnRl
cmZhY2VzIHRvZGF5LCBidXQgdGhhdCBkb2Vzbid0IG1lYW4gd2UgaGF2ZQo+IHRvIGtlZXAgdXNp
bmcgdGhlbSBmb3IgUEFTSUQgdXNlIGNhc2VzLCB0aGV5IHNob3VsZCBiZSByZXBsYWNlZCB3aXRo
IGEKPiAnZG8gZG1hIGZyb20gdGhpcyBwYXNpZCBvbiAvZGV2L2lvYXNpZCcgaW50ZXJmYWNlIGNl
cnRhaW5seSBub3QgYQo+ICdoZXJlIGlzIGEgcGFzaWQgZnJvbSAvZGV2L2lvYXNpZCwgZ28gYWhl
YWQgYW5kIGNvbmZpZ3VyZSBpdCB5b3VzZWxmJwo+IGludGVyZmFjZQoKClNvIGl0IGxvb2tzIGxp
a2UgdGhlIFBBU0lEIHdhcyBib3VuZCB0byBTVkEgaW4gdGhpcyBkZXNpZ24uIEkgdGhpbmsgaXQn
cyAKbm90IG5lY2Vzc2Fpcmx5IHRoZSBjYXNlOgoKMSkgUEFTSUQgY2FuIGJlIGltcGxlbWVudGVk
IHdpdGhvdXQgU1ZBLCBpbiB0aGlzIGNhc2UgYSBtYXAvdW5tYXAgCmludGVyZmFjZSBpcyBzdGls
bCByZXF1aXJlZAoyKSBGb3IgdGhlIGNhc2UgdGhhdCBoeXBlcnZpc29yIHdhbnQgdG8gZG8gc29t
ZSBtZWRpYXRpb24gaW4gdGhlIG1pZGRsZSAKZm9yIGEgdmlydHF1ZXVlLiBlLmcgaW4gdGhlIGNh
c2Ugb2YgY29udHJvbCB2cSB0aGF0IGlzIGltcGxlbWVudGVkIGluIAp0aGUgVkYvQURJL1NGIGl0
c2VsZiwgdGhlIGhhcmR3YXJlIHZpcnRxdWV1ZSBuZWVkcyB0byBiZSBjb250cm9sbGVkIGJ5IApR
ZW11LCBUaG91Z2ggYmluZGluZyBxZW11J3MgcGFnZSB0YWJsZSB0byBjdnEgY2FuIHdvcmsgYnV0
IGl0IGxvb2tzIGxpa2UgCmEgb3ZlcmtpbGwsIGEgc21hbGwgZGVkaWNhdGVkIGJ1ZmZlcnMgdGhh
dCBpcyBtYXBwZWQgZm9yIHRoaXMgUEFTSUQgCnNlZW1zIG1vcmUgc3VpdGFsYmUuCgoKPgo+IFRo
aXMgaXMgYmVjYXVzZSBQQVNJRCBpcyAqY29tcGxpY2F0ZWQqIGluIHRoZSBnZW5lcmFsIGNhc2Uh
IEZvcgo+IGluc3RhbmNlIGFsbCB0aGUgdHdvIGxldmVsIHN0dWZmIHlvdSBhcmUgdGFsa2luZyBh
Ym91dCBtdXN0IG5vdCBsZWFrCj4gaW50byBldmVyeSB1c2VyIQo+Cj4gSmFzb24KCgpTbyBkbyB5
b3UgbWVhbiB0aGUgZGV2aWNlIHNob3VsZCBub3QgZXhwb3NlIHRoZSBQQVNJRCBjb25maXVncmF0
aW9uIEFQSSAKdG8gZ3Vlc3Q/IEkgdGhpbmsgaXQgY291bGQgaGFwcGVuIGlmIHdlIGFzc2lnbiB0
aGUgd2hvbGUgZGV2aWNlIGFuZCBsZXQgCmd1ZXN0IHRvIGNvbmZpZ3VyZSBpdCBmb3IgbmVzdGVk
IFZNcy4KClRoYW5rcwoKCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9p
b21tdQ==
