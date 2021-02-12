Return-Path: <SRS0=FWOh=HO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6787DC433DB
	for <iommu@archiver.kernel.org>; Fri, 12 Feb 2021 09:58:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD2ED64E6C
	for <iommu@archiver.kernel.org>; Fri, 12 Feb 2021 09:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD2ED64E6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 82A788743A;
	Fri, 12 Feb 2021 09:58:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 27iD1UdAupdU; Fri, 12 Feb 2021 09:58:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C7FA1872FE;
	Fri, 12 Feb 2021 09:58:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B85D1C0891;
	Fri, 12 Feb 2021 09:58:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E582C013A
 for <iommu@lists.linux-foundation.org>; Fri, 12 Feb 2021 09:58:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 185678740B
 for <iommu@lists.linux-foundation.org>; Fri, 12 Feb 2021 09:58:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zGOa7E+xVcQA for <iommu@lists.linux-foundation.org>;
 Fri, 12 Feb 2021 09:58:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 59961872FE
 for <iommu@lists.linux-foundation.org>; Fri, 12 Feb 2021 09:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613123893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R2tD4mIs1UmiwLo4/LxlJpBgP6Pe688tzWKdKjHlFi0=;
 b=Aaj+uyeiyONVcJOhf2tZUbuGeKa852r2nv6QUP15ZJuWXUSvis/2nsjRSZ16NC0ESaDbhk
 odvclQLeaezTEFoOx/bMM6YJwYJNhAkFVpACdMHd2NwvHuNJlQldNN66HAn9BCCBM3I/To
 +wJa8CgXcYY0rTRyyNJ3TM+mTLxcJOk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-xyISVEXbOSO_KKe5qlVzsw-1; Fri, 12 Feb 2021 04:58:11 -0500
X-MC-Unique: xyISVEXbOSO_KKe5qlVzsw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE0681009618;
 Fri, 12 Feb 2021 09:58:09 +0000 (UTC)
Received: from [10.36.114.34] (ovpn-114-34.ams2.redhat.com [10.36.114.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 33DEA72F88;
 Fri, 12 Feb 2021 09:57:47 +0000 (UTC)
Subject: Re: [PATCH v7 02/16] iommu/smmu: Report empty domain nesting info
To: Vivek Gautam <vivek.gautam@arm.com>, "Liu, Yi L" <yi.l.liu@intel.com>
References: <1599734733-6431-1-git-send-email-yi.l.liu@intel.com>
 <1599734733-6431-3-git-send-email-yi.l.liu@intel.com>
 <CAFp+6iFob_fy1cTgcEv0FOXBo70AEf3Z1UvXgPep62XXnLG9Gw@mail.gmail.com>
 <DM5PR11MB14356D5688CA7DC346AA32DBC3AA0@DM5PR11MB1435.namprd11.prod.outlook.com>
 <CAFp+6iEnh6Tce26F0RHYCrQfiHrkf-W3_tXpx+ysGiQz6AWpEw@mail.gmail.com>
 <DM5PR11MB1435D9ED79B2BE9C8F235428C3A90@DM5PR11MB1435.namprd11.prod.outlook.com>
 <6bcd5229-9cd3-a78c-ccb2-be92f2add373@redhat.com>
 <DM5PR11MB143531EA8BD997A18F0A7671C3BF9@DM5PR11MB1435.namprd11.prod.outlook.com>
 <CAFp+6iGZZ9fANN_0-NFb31kHfiytD5=vcsk1_Q8gp-_6L7xQVw@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <9b6d409b-266b-230a-800a-24b8e6b5cd09@redhat.com>
Date: Fri, 12 Feb 2021 10:57:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAFp+6iGZZ9fANN_0-NFb31kHfiytD5=vcsk1_Q8gp-_6L7xQVw@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: "Sun, Yi Y" <yi.y.sun@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, Will Deacon <will@kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, "Tian, Jun J" <jun.j.tian@intel.com>, "Wu,
 Hao" <hao.wu@intel.com>
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

SGkgVml2ZWssIFlpLAoKT24gMi8xMi8yMSA4OjE0IEFNLCBWaXZlayBHYXV0YW0gd3JvdGU6Cj4g
SGkgWWksCj4gCj4gCj4gT24gU2F0LCBKYW4gMjMsIDIwMjEgYXQgMjoyOSBQTSBMaXUsIFlpIEwg
PHlpLmwubGl1QGludGVsLmNvbT4gd3JvdGU6Cj4+Cj4+IEhpIEVyaWMsCj4+Cj4+PiBGcm9tOiBB
dWdlciBFcmljIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+Cj4+PiBTZW50OiBUdWVzZGF5LCBKYW51
YXJ5IDE5LCAyMDIxIDY6MDMgUE0KPj4+Cj4+PiBIaSBZaSwgVml2ZWssCj4+Pgo+PiBbLi4uXQo+
Pj4+IEkgc2VlLiBJIHRoaW5rIHRoZXJlIG5lZWRzIGEgY2hhbmdlIGluIHRoZSBjb2RlIHRoZXJl
LiBTaG91bGQgYWxzbyBleHBlY3QKPj4+PiBhIG5lc3RpbmdfaW5mbyByZXR1cm5lZCBpbnN0ZWFk
IG9mIGFuIGludCBhbnltb3JlLiBARXJpYywgaG93IGFib3V0IHlvdXIKPj4+PiBvcGluaW9uPwo+
Pj4+Cj4+Pj4gICAgIGRvbWFpbiA9IGlvbW11X2dldF9kb21haW5fZm9yX2RldigmdmRldi0+cGRl
di0+ZGV2KTsKPj4+PiAgICAgcmV0ID0gaW9tbXVfZG9tYWluX2dldF9hdHRyKGRvbWFpbiwgRE9N
QUlOX0FUVFJfTkVTVElORywKPj4+ICZpbmZvKTsKPj4+PiAgICAgaWYgKHJldCB8fCAhKGluZm8u
ZmVhdHVyZXMgJiBJT01NVV9ORVNUSU5HX0ZFQVRfUEFHRV9SRVNQKSkgewo+Pj4+ICAgICAgICAg
ICAgIC8qCj4+Pj4gICAgICAgICAgICAgICogTm8gbmVlZCBnbyBmdXRoZXIgYXMgbm8gcGFnZSBy
ZXF1ZXN0IHNlcnZpY2Ugc3VwcG9ydC4KPj4+PiAgICAgICAgICAgICAgKi8KPj4+PiAgICAgICAg
ICAgICByZXR1cm4gMDsKPj4+PiAgICAgfQo+Pj4gU3VyZSBJIHRoaW5rIGl0IGlzICJqdXN0IiBh
IG1hdHRlciBvZiBzeW5jaHJvIGJldHdlZW4gdGhlIDIgc2VyaWVzLiBZaSwKPj4KPj4gZXhhY3Rs
eS4KPj4KPj4+IGRvIHlvdSBoYXZlIHBsYW5zIHRvIHJlc3BpbiBwYXJ0IG9mCj4+PiBbUEFUQ0gg
djcgMDAvMTZdIHZmaW86IGV4cG9zZSB2aXJ0dWFsIFNoYXJlZCBWaXJ0dWFsIEFkZHJlc3Npbmcg
dG8gVk1zCj4+PiBvciB3b3VsZCB5b3UgYWxsb3cgbWUgdG8gZW1iZWQgdGhpcyBwYXRjaCBpbiBt
eSBzZXJpZXMuCj4+Cj4+IE15IHY3IGhhc27igJl0IHRvdWNoIHRoZSBwcnEgY2hhbmdlIHlldC4g
U28gSSB0aGluayBpdCdzIGJldHRlciBmb3IgeW91IHRvCj4+IGVtYmVkIGl0IHRvICB5b3VyIHNl
cmllcy4gXl9ePj4KPiAKPiBDYW4geW91IHBsZWFzZSBsZXQgbWUga25vdyBpZiB5b3UgaGF2ZSBh
biB1cGRhdGVkIHNlcmllcyBvZiB0aGVzZQo+IHBhdGNoZXM/IEl0IHdpbGwgaGVscCBtZSB0byB3
b3JrIHdpdGggdmlydGlvLWlvbW11L2FybSBzaWRlIGNoYW5nZXMuCgpBcyBwZXIgdGhlIHByZXZp
b3VzIGRpc2N1c3Npb24sIEkgcGxhbiB0byB0YWtlIHRob3NlIDIgcGF0Y2hlcyBpbiBteQpTTU1V
djMgbmVzdGVkIHN0YWdlIHNlcmllczoKCltQQVRDSCB2NyAwMS8xNl0gaW9tbXU6IFJlcG9ydCBk
b21haW4gbmVzdGluZyBpbmZvCltQQVRDSCB2NyAwMi8xNl0gaW9tbXUvc21tdTogUmVwb3J0IGVt
cHR5IGRvbWFpbiBuZXN0aW5nIGluZm8KCndlIG5lZWQgdG8gdXBncmFkZSBib3RoIHNpbmNlIHdl
IGRvIG5vdCB3YW50IHRvIHJlcG9ydCBhbiBlbXB0eSBuZXN0aW5nCmluZm8gYW55bW9yZSwgZm9y
IGFybS4KClRoYW5rcwoKRXJpYwo+IAo+IFRoYW5rcyAmIHJlZ2FyZHMKPiBWaXZlawo+IAoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGlu
ZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
