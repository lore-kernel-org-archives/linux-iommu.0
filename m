Return-Path: <SRS0=DRkM=JE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977BBC433B4
	for <iommu@archiver.kernel.org>; Wed,  7 Apr 2021 02:07:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33CEC611C1
	for <iommu@archiver.kernel.org>; Wed,  7 Apr 2021 02:07:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33CEC611C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E901E405A6;
	Wed,  7 Apr 2021 02:06:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u6ZwiZUwWZcz; Wed,  7 Apr 2021 02:06:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id C4F464017B;
	Wed,  7 Apr 2021 02:06:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E4F8C000B;
	Wed,  7 Apr 2021 02:06:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A264C000A
 for <iommu@lists.linux-foundation.org>; Wed,  7 Apr 2021 02:06:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 526A540338
 for <iommu@lists.linux-foundation.org>; Wed,  7 Apr 2021 02:06:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 88fs_8A-SStu for <iommu@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 02:06:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 901BD40332
 for <iommu@lists.linux-foundation.org>; Wed,  7 Apr 2021 02:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617761214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eTZmJYI/IOE6eZrevZtsuKN2bM+b1mDhI0WPZSfz0LQ=;
 b=G3TZXjtlMrQ82v2jOE3+uJ4bYtpNVTECX0od4JC59dB8MJNy9wmOHeqZgyM6VNQpZzQN5g
 vd/A5ApgpUmc4wnoMHJfWU4afwjWOIzIDzHX474Mjo85xkk53yB32Q+teTB3UP2iq+rwrp
 cL/Tm7f3qjZ5JngN6gNFkJU1bRpCM50=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-QSgasZZhPcmqG8yYOFuXrA-1; Tue, 06 Apr 2021 22:06:50 -0400
X-MC-Unique: QSgasZZhPcmqG8yYOFuXrA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB315107ACCD;
 Wed,  7 Apr 2021 02:06:47 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-182.pek2.redhat.com
 [10.72.13.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9838910023B5;
 Wed,  7 Apr 2021 02:06:33 +0000 (UTC)
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20210319135432.GT2356281@nvidia.com>
 <20210319112221.5123b984@jacob-builder> <20210322120300.GU2356281@nvidia.com>
 <20210324120528.24d82dbd@jacob-builder> <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132830.GO2356281@nvidia.com>
 <MWHPR11MB1886CAD48AFC156BFC7C1D398C7A9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210405234230.GF7405@nvidia.com>
 <fa57bde5-472f-6e66-3521-bfac7d6e4f8d@redhat.com>
 <20210406124251.GO7405@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <acbd03f2-5c7e-d38e-92b6-cedc02429889@redhat.com>
Date: Wed, 7 Apr 2021 10:06:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210406124251.GO7405@nvidia.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Alex Williamson <alex.williamson@redhat.com>,
 "Raj, Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
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

CtTaIDIwMjEvNC82IM/Czuc4OjQyLCBKYXNvbiBHdW50aG9ycGUg0LS1wDoKPiBPbiBUdWUsIEFw
ciAwNiwgMjAyMSBhdCAwOTozNToxN0FNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+Cj4+PiBW
RklPIGFuZCBWRFBBIGhhcyBubyBidWlzbmVzcyBoYXZpbmcgbWFwL3VubWFwIGludGVyZmFjZXMg
b25jZSB3ZSBoYXZlCj4+PiAvZGV2L2lvYXNpZC4gVGhhdCBhbGwgYmVsb25ncyBpbiB0aGUgaW9z
YWlkIHNpZGUuCj4+Pgo+Pj4gSSBrbm93IHRoZXkgaGF2ZSB0aG9zZSBpbnRlcmZhY2VzIHRvZGF5
LCBidXQgdGhhdCBkb2Vzbid0IG1lYW4gd2UgaGF2ZQo+Pj4gdG8ga2VlcCB1c2luZyB0aGVtIGZv
ciBQQVNJRCB1c2UgY2FzZXMsIHRoZXkgc2hvdWxkIGJlIHJlcGxhY2VkIHdpdGggYQo+Pj4gJ2Rv
IGRtYSBmcm9tIHRoaXMgcGFzaWQgb24gL2Rldi9pb2FzaWQnIGludGVyZmFjZSBjZXJ0YWlubHkg
bm90IGEKPj4+ICdoZXJlIGlzIGEgcGFzaWQgZnJvbSAvZGV2L2lvYXNpZCwgZ28gYWhlYWQgYW5k
IGNvbmZpZ3VyZSBpdCB5b3VzZWxmJwo+Pj4gaW50ZXJmYWNlCj4+ICAgCj4+IFNvIGl0IGxvb2tz
IGxpa2UgdGhlIFBBU0lEIHdhcyBib3VuZCB0byBTVkEgaW4gdGhpcyBkZXNpZ24uIEkgdGhpbmsg
aXQncyBub3QKPj4gbmVjZXNzYWlybHkgdGhlIGNhc2U6Cj4gTm8sIEkgd2lzaCBwZW9wbGUgd291
bGQgc3RvcCB0YWxraW5nIGFib3V0IFNWQS4KPgo+IFNWQSBhbmQgdlNWQSBhcmUgYSB2ZXJ5IHNw
ZWNpYWwgbmFycm93IGNvbmZpZ3VyYXRpb24gb2YgYSBQQVNJRC4gVGhlcmUKPiBhcmUgbG90cyBv
ZiBvdGhlciBQQVNJRCBjb25maWd1cmF0aW9ucyEgVGhhdCBpcyB0aGUgd2hvbGUgcG9pbnQsIGEK
PiBQQVNJRCBpcyBjb21wbGljYXRlZCwgdGhlcmUgYXJlIG1hbnkgY29uZmlndXJhdGlvbiBzY2Vu
YXJpb3MsIHRoZXkKPiBuZWVkIHRvIGJlIGluIG9uZSBwbGFjZSB3aXRoIGEgdmVyeSBjbGVhcmx5
IGRlZmluZWQgdUFQSQoKClJpZ2h0LCB0aGF0J3MgbXkgdW5kZXJzdGFuZGluZyBhcyB3ZWxsLgoK
Cj4KPj4gMSkgUEFTSUQgY2FuIGJlIGltcGxlbWVudGVkIHdpdGhvdXQgU1ZBLCBpbiB0aGlzIGNh
c2UgYSBtYXAvdW5tYXAgaW50ZXJmYWNlCj4+IGlzIHN0aWxsIHJlcXVpcmVkCj4gQW55IGludGVy
ZmFjZSB0byBtYW5pcHVsYXRlIGEgUEFTSUQgc2hvdWxkIGJlIHVuZGVyIC9kZXYvaW9hc2lkLiBX
ZSBkbwo+IG5vdCB3YW50IHRvIGR1cGxpY2F0ZSB0aGlzIGludG8gZXZlcnkgc3Vic3lzdGVtLgoK
Clllcy4KCgo+Cj4+IDIpIEZvciB0aGUgY2FzZSB0aGF0IGh5cGVydmlzb3Igd2FudCB0byBkbyBz
b21lIG1lZGlhdGlvbiBpbiB0aGUgbWlkZGxlIGZvcgo+PiBhIHZpcnRxdWV1ZS4gZS5nIGluIHRo
ZSBjYXNlIG9mIGNvbnRyb2wgdnEgdGhhdCBpcyBpbXBsZW1lbnRlZCBpbiB0aGUKPj4gVkYvQURJ
L1NGIGl0c2VsZiwgdGhlIGhhcmR3YXJlIHZpcnRxdWV1ZSBuZWVkcyB0byBiZSBjb250cm9sbGVk
IGJ5IFFlbXUsCj4+IFRob3VnaCBiaW5kaW5nIHFlbXUncyBwYWdlIHRhYmxlIHRvIGN2cSBjYW4g
d29yayBidXQgaXQgbG9va3MgbGlrZSBhCj4+IG92ZXJraWxsLCBhIHNtYWxsIGRlZGljYXRlZCBi
dWZmZXJzIHRoYXQgaXMgbWFwcGVkIGZvciB0aGlzIFBBU0lEIHNlZW1zIG1vcmUKPj4gc3VpdGFs
YmUuCj4gL2Rldi9pb2FzaWQgc2hvdWxkIGFsbG93IHVzZXJzcGFjZSB0byBzZXR1cCBhbnkgUEFT
SUQgY29uZmlndXJhdGlvbiBpdAo+IHdhbnRzLiBUaGVyZSBhcmUgbWFueSBjaG9pY2VzLiBUaGF0
IGlzIHRoZSB3aG9sZSBwb2ludCwgaW5zdGVhZCBvZgo+IGNvcHlpbmcmcGFzdGluZyBhbGwgdGhl
IFBBU0lEIGNvbmZpZ3VyYXRpb24gb3B0aW9uIGludG8gZXZlcnkKPiBzdWJzeXN0ZW0gd2UgaGF2
ZSBvbiBwbGFjZSB0byBjb25maWd1cmUgaXQuCj4KPiBJZiB5b3Ugd2FudCBhIFBBU0lEIChvciBn
ZW5lcmljIGlvYXNpZCkgdGhhdCBoYXMgdGhlIGd1ZXN0IHBoeXNpY2FsCj4gbWFwLCB3aGljaCBp
cyBwcm9iYWJseSBhbGwgdGhhdCBWRFBBIHdvdWxkIGV2ZXIgd2FudCwgdGhlbiAvZGV2L2lvYXNp
ZAo+IHNob3VsZCBiZSBhYmxlIHRvIHByZXBhcmUgdGhhdC4KPgo+IElmIHlvdSBqdXN0IHdhbnQg
dG8gbWFwIGEgZmV3IGJ1ZmZlcnMgaW50byBhIFBBU0lEIHRoZW4gaXQgc2hvdWxkIGJlCj4gYWJs
ZSB0byBkbyB0aGF0IHRvby4KPgo+PiBTbyBkbyB5b3UgbWVhbiB0aGUgZGV2aWNlIHNob3VsZCBu
b3QgZXhwb3NlIHRoZSBQQVNJRCBjb25maXVncmF0aW9uIEFQSSB0bwo+PiBndWVzdD8gSSB0aGlu
ayBpdCBjb3VsZCBoYXBwZW4gaWYgd2UgYXNzaWduIHRoZSB3aG9sZSBkZXZpY2UgYW5kIGxldCBn
dWVzdAo+PiB0byBjb25maWd1cmUgaXQgZm9yIG5lc3RlZCBWTXMuCj4gVGhpcyBhbHdheXMgbmVl
ZHMgY28tb3BlcmF0aW5nIHdpdGggdGhlIHZJT01NVSBkcml2ZXIuIFdlIGNhbid0IGhhdmUKPiBu
ZXN0ZWQgUEFTSUQgdXNlIHdpdGhvdXQgYm90aCBwYXJ0cyB3b3JraW5nIHRvZ2V0aGVyLgo+Cj4g
VGhlIHZJT01NVSBkcml2ZXIgY29uZmlndXJlcyB0aGUgUEFTSUQgYW5kIGFzc2lnbnMgdGhlIG1h
cHBpbmdzCj4gKGhvd2V2ZXIgY29tcGxpY2F0ZWQgdGhhdCB0dXJucyBvdXQgdG8gYmUpCj4KPiBU
aGUgVkRQQS9tZGV2IGRyaXZlciBhdXRob3JpemVzIHRoZSBIVyB0byB1c2UgdGhlIGlvYXNpZCBt
YXBwaW5nLCBlZwo+IGJ5IGF1dGhvcml6aW5nIGEgcXVldWUgdG8gaXNzdWUgUENJZSBUTFBzIHdp
dGggYSBzcGVjaWZpYyBQQVNJRC4KPgo+IFRoZSBhdXRob3JpemF0aW9uIGlzIHRyaWdnZXJlZCBi
eSB0aGUgZ3Vlc3QgdGVsbGluZyB0aGUgdklPTU1VIHRvCj4gYWxsb3cgYSB2UklEIHRvIHRhbGsg
dG8gYSBQQVNJRCwgd2hpY2ggcWVtdSB3b3VsZCBoYXZlIHRvIHRyYW5zbGF0ZSB0bwo+IHRlbGxp
bmcgc29tZXRoaW5nIGxpa2UgdGhlIFZEUEEgZHJpdmVyIHVuZGVyIHRoZSB2UklEIHRoYXQgaXQg
Y2FuIHVzZQo+IGEgUEFTSUQgZnJvbSAvZGV2L2lvYXNpZAo+Cj4gRm9yIHNlY3VyaXR5IGEgVkRQ
QS9tZGV2IGRldmljZSBNVVNUIE5PVCBpc3N1ZSBQQVNJRHMgdGhhdCB0aGUgdklPTU1VCj4gaGFz
IG5vdCBhdXRob3JpemVkIGl0cyB2UklEIHRvIHVzZS4gT3RoZXJ3aXNlIHRoZSBzZWN1cml0eSBt
b2RlbCBvZgo+IHNvbWV0aGluZyBsaWtlIFZGSU8gaW4gdGhlIGd1ZXN0IGJlY29tZXMgY29tcGxl
dGVseSBicm9rZW4uCgoKWWVzLCB0aGF0J3MgaG93IGl0IHNob3VsZCB3b3JrLgoKVGhhbmtzCgoK
Pgo+IEphc29uCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
