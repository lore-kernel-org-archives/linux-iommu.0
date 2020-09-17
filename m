Return-Path: <SRS0=xf59=C2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7A8C43461
	for <iommu@archiver.kernel.org>; Thu, 17 Sep 2020 03:54:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B673620707
	for <iommu@archiver.kernel.org>; Thu, 17 Sep 2020 03:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H3M+6pXk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B673620707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5CC8187591;
	Thu, 17 Sep 2020 03:54:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3q9dPEWNTgwE; Thu, 17 Sep 2020 03:54:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6346D8758F;
	Thu, 17 Sep 2020 03:54:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4826AC0864;
	Thu, 17 Sep 2020 03:54:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CBC38C0051
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 03:54:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C18648771E
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 03:54:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6tFGURGgyN+J for <iommu@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 03:54:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 844D6877CE
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 03:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600314862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E1WZf9YMUb6/5XbKYk6oGkvxm0myYrBK4fT6wDWBTHU=;
 b=H3M+6pXkucVPnOh0/EMc4iIF5MTToo19l027C3BVqjfFx4YC6x22guwmbQAKQjDIt0ON14
 6jf8Fv6nRZ7qGwUyEQNz1jJUAIeEIqG0NY6JppSct6fxuqr217wVLSY0q1o732fU2s81Ed
 Isx97XGj+m2u+F2cKmTUpf/Hn3oZO3g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-AttH2l6fORKqBGY0lxfP4A-1; Wed, 16 Sep 2020 23:54:18 -0400
X-MC-Unique: AttH2l6fORKqBGY0lxfP4A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A3D7107464E;
 Thu, 17 Sep 2020 03:54:16 +0000 (UTC)
Received: from [10.72.13.123] (ovpn-13-123.pek2.redhat.com [10.72.13.123])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 518575DE84;
 Thu, 17 Sep 2020 03:53:50 +0000 (UTC)
Subject: Re: [PATCH v7 00/16] vfio: expose virtual Shared Virtual Addressing
 to VMs
To: "Jacob Pan (Jun)" <jacob.jun.pan@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20200915113341.GW904879@nvidia.com>
 <20200915181154.GA70770@otc-nc-03> <20200915184510.GB1573713@nvidia.com>
 <20200915150851.76436ca1@jacob-builder> <20200915235126.GK1573713@nvidia.com>
 <20200915171319.00003f59@linux.intel.com> <20200916150754.GE6199@nvidia.com>
 <20200916163343.GA76252@otc-nc-03> <20200916170113.GD3699@nvidia.com>
 <20200916112110.000024ee@intel.com> <20200916183841.GI6199@nvidia.com>
 <20200916160901.000046ec@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <69ec9537-460f-2351-fa90-c31aaeef3c4b@redhat.com>
Date: Thu, 17 Sep 2020 11:53:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200916160901.000046ec@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 "Raj, Ashok" <ashok.raj@intel.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, stefanha@gmail.com, yi.y.sun@intel.com,
 Alex Williamson <alex.williamson@redhat.com>, iommu@lists.linux-foundation.org,
 hao.wu@intel.com, jun.j.tian@intel.com
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

Ck9uIDIwMjAvOS8xNyDkuIrljYg3OjA5LCBKYWNvYiBQYW4gKEp1bikgd3JvdGU6Cj4gSGkgSmFz
b24sCj4gT24gV2VkLCAxNiBTZXAgMjAyMCAxNTozODo0MSAtMDMwMCwgSmFzb24gR3VudGhvcnBl
IDxqZ2dAbnZpZGlhLmNvbT4KPiB3cm90ZToKPgo+PiBPbiBXZWQsIFNlcCAxNiwgMjAyMCBhdCAx
MToyMToxMEFNIC0wNzAwLCBKYWNvYiBQYW4gKEp1bikgd3JvdGU6Cj4+PiBIaSBKYXNvbiwKPj4+
IE9uIFdlZCwgMTYgU2VwIDIwMjAgMTQ6MDE6MTMgLTAzMDAsIEphc29uIEd1bnRob3JwZSA8amdn
QG52aWRpYS5jb20+Cj4+PiB3cm90ZToKPj4+ICAgIAo+Pj4+IE9uIFdlZCwgU2VwIDE2LCAyMDIw
IGF0IDA5OjMzOjQzQU0gLTA3MDAsIFJhaiwgQXNob2sgd3JvdGU6Cj4+Pj4+IE9uIFdlZCwgU2Vw
IDE2LCAyMDIwIGF0IDEyOjA3OjU0UE0gLTAzMDAsIEphc29uIEd1bnRob3JwZQo+Pj4+PiB3cm90
ZToKPj4+Pj4+IE9uIFR1ZSwgU2VwIDE1LCAyMDIwIGF0IDA1OjIyOjI2UE0gLTA3MDAsIEphY29i
IFBhbiAoSnVuKQo+Pj4+Pj4gd3JvdGU6Cj4+Pj4+Pj4+IElmIHVzZXIgc3BhY2Ugd2FudHMgdG8g
YmluZCBwYWdlIHRhYmxlcywgY3JlYXRlIHRoZSBQQVNJRAo+Pj4+Pj4+PiB3aXRoIC9kZXYvc3Zh
LCB1c2UgaW9jdGxzIHRoZXJlIHRvIHNldHVwIHRoZSBwYWdlIHRhYmxlCj4+Pj4+Pj4+IHRoZSB3
YXkgaXQgd2FudHMsIHRoZW4gcGFzcyB0aGUgbm93IGNvbmZpZ3VyZWQgUEFTSUQgdG8gYQo+Pj4+
Pj4+PiBkcml2ZXIgdGhhdCBjYW4gdXNlIGl0Lgo+Pj4+Pj4+IEFyZSB3ZSB0YWxraW5nIGFib3V0
IGJhcmUgbWV0YWwgU1ZBPwo+Pj4+Pj4gV2hhdCBhIHdlaXJkIHRlcm0uCj4+Pj4+IEdsYWQgeW91
IG5vdGljZWQgaXQgYXQgdjcgOi0pCj4+Pj4+Cj4+Pj4+IEFueSBzdWdnZXN0aW9ucyBvbiBzb21l
dGhpbmcgbGVzcyB3ZWlyZCB0aGFuCj4+Pj4+IFNoYXJlZCBWaXJ0dWFsIEFkZHJlc3Npbmc/IFRo
ZXJlIGlzIGEgcmVhc29uIHdoeSB3ZSBtb3ZlZCBmcm9tCj4+Pj4+IFNWTSB0byBTVkEuCj4+Pj4g
U1ZBIGlzIGZpbmUsIHdoYXQgaXMgImJhcmUgbWV0YWwiIHN1cHBvc2VkIHRvIG1lYW4/Cj4+Pj4g
ICAgCj4+PiBXaGF0IEkgbWVhbnQgaGVyZSBpcyBzaGFyaW5nIHZpcnR1YWwgYWRkcmVzcyBiZXR3
ZWVuIERNQSBhbmQgaG9zdAo+Pj4gcHJvY2Vzcy4gVGhpcyByZXF1aXJlcyBkZXZpY2VzIHBlcmZv
cm0gRE1BIHJlcXVlc3Qgd2l0aCBQQVNJRCBhbmQKPj4+IHVzZSBJT01NVSBmaXJzdCBsZXZlbC9z
dGFnZSAxIHBhZ2UgdGFibGVzLgo+Pj4gVGhpcyBjYW4gYmUgZnVydGhlciBkaXZpZGVkIGludG8g
MSkgdXNlciBTVkEgMikgc3VwZXJ2aXNvciBTVkEKPj4+IChzaGFyaW5nIGluaXRfbW0pCj4+Pgo+
Pj4gTXkgcG9pbnQgaXMgdGhhdCAvZGV2L3N2YSBpcyBub3QgdXNlZnVsIGhlcmUgc2luY2UgdGhl
IGRyaXZlciBjYW4KPj4+IHBlcmZvcm0gUEFTSUQgYWxsb2NhdGlvbiB3aGlsZSBkb2luZyBTVkEg
YmluZC4KPj4gTm8sIHlvdSBhcmUgdGhpbmtpbmcgdG9vIHNtYWxsLgo+Pgo+PiBMb29rIGF0IFZE
UEEsIGl0IGhhcyBhIFNWQSB1QVBJLiBTb21lIEhXIG1pZ2h0IHVzZSBQQVNJRCBmb3IgdGhlIFNW
QS4KPj4KPiBDb3VsZCB5b3UgcG9pbnQgdG8gbWUgdGhlIFNWQSBVQVBJPyBJIGNvdWxkbid0IGZp
bmQgaXQgaW4gdGhlIG1haW5saW5lLgo+IFNlZW1zIFZEUEEgdXNlcyBWSE9TVCBpbnRlcmZhY2U/
CgoKSXQncyB0aGUgdmhvc3RfaW90bGJfbXNnIGRlZmluZWQgaW4gdWFwaS9saW51eC92aG9zdF90
eXBlcy5oLgoKCj4KPj4gV2hlbiBWRFBBIGlzIHVzZWQgYnkgRFBESyBpdCBtYWtlcyBzZW5zZSB0
aGF0IHRoZSBQQVNJRCB3aWxsIGJlIFNWQQo+PiBhbmQgMToxIHdpdGggdGhlIG1tX3N0cnVjdC4K
Pj4KPiBJIHN0aWxsIGRvbid0IHNlZSB3aHkgYmFyZSBtZXRhbCBEUERLIG5lZWRzIHRvIGdldCBh
IGhhbmRsZSBvZiB0aGUKPiBQQVNJRC4KCgpNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgaXQgbWF5
OgoKLSBoYXZlIGEgdW5pZmllZCB1QVBJIHdpdGggdlNWQTogYWxsb2MsIGJpbmQsIHVuYmluZCwg
ZnJlZQotIGxlYXZlIHRoZSBiaW5kaW5nIHBvbGljeSB0byB1c2Vyc3BhY2UgaW5zdGVhZCBvZiB0
aGUgdXNpbmcgYSBpbXBsaWVkIApvbmUgaW4gdGhlIGtlbnJlbAoKCj4gUGVyaGFwcyB0aGUgU1ZB
IHBhdGNoIHdvdWxkIGV4cGxhaW4uIE9yIGFyZSB5b3UgdGFsa2luZyBhYm91dAo+IHZEUEEgRFBE
SyBwcm9jZXNzIHRoYXQgaXMgdXNlZCB0byBzdXBwb3J0IHZpcnRpby1uZXQtcG1kIGluIHRoZSBn
dWVzdD8KPgo+PiBXaGVuIFZEUEEgaXMgdXNlZCBieSBxZW11IGl0IG1ha2VzIHNlbnNlIHRoYXQg
dGhlIFBBU0lEIHdpbGwgYmUgYW4KPj4gYXJiaXRhcnkgSU9WQSBtYXAgY29uc3RydWN0ZWQgdG8g
YmUgMToxIHdpdGggdGhlIGd1ZXN0IHZDUFUgcGh5c2ljYWwKPj4gbWFwLiAvZGV2L3N2YSBhbGxv
d3MgYSBzaW5nbGUgdUFQSSB0byBkbyB0aGlzIGtpbmQgb2Ygc2V0dXAsIGFuZCBxZW11Cj4+IGNh
biBzdXBwb3J0IGl0IHdoaWxlIHN1cHBvcnRpbmcgYSByYW5nZSBvZiBTVkEga2VybmVsIGRyaXZl
cnMuIFZEUEEKPj4gYW5kIHZmaW8tbWRldiBhcmUgb2J2aW91cyBpbml0aWFsIHRhcmdldHMuCj4+
Cj4+ICpCT1RIKiBhcmUgbmVlZGVkLgo+Pgo+PiBJbiBnZW5lcmFsIGFueSB1QVBJIGZvciBQQVNJ
RCBzaG91bGQgaGF2ZSB0aGUgb3B0aW9uIHRvIHVzZSBlaXRoZXIgdGhlCj4+IG1tX3N0cnVjdCBT
VkEgUEFTSUQgKk9SKiBhIFBBU0lEIGZyb20gL2Rldi9zdmEuIEl0IGNvc3RzIHZpcnR1YWxseQo+
PiBub3RoaW5nIHRvIGltcGxlbWVudCB0aGlzIGluIHRoZSBkcml2ZXIgYXMgUEFTSUQgaXMganVz
dCBhIG51bWJlciwgYW5kCj4+IGdpdmVzIHNvIG11Y2ggbW9yZSBmbGV4YWJpbGl0eS4KPj4KPiBO
b3QgcmVhbGx5IG5vdGhpbmcgaW4gdGVybXMgb2YgUEFTSUQgbGlmZSBjeWNsZXMuIEZvciBleGFt
cGxlLCBpZiB1c2VyCj4gdXNlcyB1YWNjZSBpbnRlcmZhY2UgdG8gb3BlbiBhbiBhY2NlbGVyYXRv
ciwgaXQgZ2V0cyBhbiBGRF9hY2MuIFRoZW4gaXQKPiBvcGVucyAvZGV2L3N2YSB0byBhbGxvY2F0
ZSBQQVNJRCB0aGVuIGdldCBhbm90aGVyIEZEX3Bhc2lkLiBUaGVuIHdlCj4gcGFzcyBGRF9wYXNp
ZCB0byB0aGUgZHJpdmVyIHRvIGJpbmQgcGFnZSB0YWJsZXMsIHBlcmhhcHMgbXVsdGlwbGUKPiBk
cml2ZXJzLiBOb3cgd2UgaGF2ZSB0byB3b3JyeSBhYm91dCBJZiBGRF9wYXNpZCBnZXRzIGNsb3Nl
ZCBiZWZvcmUKPiBGRF9hY2MocykgY2xvc2VkIGFuZCBhbGwgdGhlc2UgcmFjZSBjb25kaXRpb25z
LgoKCkknbSBub3Qgc3VyZSBJIHVuZGVyc3RhbmQgdGhpcy4gQnV0IHRoaXMgZGVtb25zdHJhdGVz
IHRoZSBmbGV4aWJpbGl0eSBvZiAKYW4gdW5pZmllZCB1QVBJLiBFLmcgaXQgYWxsb3dzIHZEUEEg
YW5kIFZGSU8gZGV2aWNlIHRvIHVzZSB0aGUgc2FtZSAKUEFJU0Qgd2hpY2ggY2FuIGJlIHNoYXJl
ZCB3aXRoIGEgcHJvY2VzcyBpbiB0aGUgZ3Vlc3QuCgpGb3IgdGhlIHJhY2UgY29uZGl0aW9uLCBp
dCBjb3VsZCBiZSBwcm9iYWJseSBzb2x2ZWQgd2l0aCByZWZjbnQuCgpUaGFua3MKCgo+Cj4gSWYg
d2UgZG8gbm90IGV4cG9zZSBGRF9wYXNpZCB0byB0aGUgdXNlciwgdGhlIHRlYXJkb3duIGlzIG11
Y2ggc2ltcGxlcgo+IGFuZCBzdHJlYW1saW5lZC4gRm9sbG93aW5nIGVhY2ggRkRfYWNjIGNsb3Nl
LCBQQVNJRCB1bmJpbmQgaXMgcGVyZm9ybWVkLgo+Cj4+PiBZaSBjYW4gY29ycmVjdCBtZSBidXQg
dGhpcyBzZXQgaXMgaXMgYWJvdXQgVkZJTy1QQ0ksIFZGSU8tbWRldiB3aWxsCj4+PiBiZSBpbnRy
b2R1Y2VkIGxhdGVyLgo+PiBMYXN0IHBhdGNoIGlzOgo+Pgo+PiAgICB2ZmlvL3R5cGUxOiBBZGQg
dlNWQSBzdXBwb3J0IGZvciBJT01NVS1iYWNrZWQgbWRldnMKPj4KPj4gU28gcHJldHR5IGhhcmQg
dG8gc2VlIGhvdyB0aGlzIGlzIG5vdCBhYm91dCB2ZmlvLW1kZXYsIGF0IGxlYXN0IGEKPj4gbGl0
dGxlLi4KPj4KPj4gSmFzb24KPgo+IFRoYW5rcywKPgo+IEphY29iCj4KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
