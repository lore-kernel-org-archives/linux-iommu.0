Return-Path: <SRS0=+KRR=C3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32005C43464
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 03:59:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C543423772
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 03:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ggJ7wBI4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C543423772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 45731203E6;
	Fri, 18 Sep 2020 03:59:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8rn7uI7ktvwI; Fri, 18 Sep 2020 03:59:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1E60B20030;
	Fri, 18 Sep 2020 03:59:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01646C0888;
	Fri, 18 Sep 2020 03:59:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95732C0051
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 03:58:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 833258778E
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 03:58:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YVNrH67N-77S for <iommu@lists.linux-foundation.org>;
 Fri, 18 Sep 2020 03:58:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7F9BE8778D
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 03:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600401535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yvuOWRWNIiYpIWtybWCQWDV22wHbKAsOWIP2gscO7JY=;
 b=ggJ7wBI4cg6ZFB7eetla8Wqbr9dz9Z++fEYt9vuBAQorJhxS1Dl0202irDrOqVrSSvIxAo
 D8OEE5B7UFsugpTI9kr/QZRZFqWwRQPQC74m9yfCKdJR/gAJZQn2P8EKRz2aQDbGezlmA8
 J8XHjC7WbuTc2BUsX3kOvKJmxKt1ot4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-8o9i7UA2P7iBe0zuAxo_Hw-1; Thu, 17 Sep 2020 23:58:51 -0400
X-MC-Unique: 8o9i7UA2P7iBe0zuAxo_Hw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A1DA186DD40;
 Fri, 18 Sep 2020 03:58:48 +0000 (UTC)
Received: from [10.72.13.167] (ovpn-13-167.pek2.redhat.com [10.72.13.167])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E0B181C4;
 Fri, 18 Sep 2020 03:58:30 +0000 (UTC)
Subject: Re: [PATCH v7 00/16] vfio: expose virtual Shared Virtual Addressing
 to VMs
To: "Jacob Pan (Jun)" <jacob.jun.pan@intel.com>
References: <20200915113341.GW904879@nvidia.com>
 <20200915181154.GA70770@otc-nc-03> <20200915184510.GB1573713@nvidia.com>
 <20200915150851.76436ca1@jacob-builder> <20200915235126.GK1573713@nvidia.com>
 <20200915171319.00003f59@linux.intel.com> <20200916150754.GE6199@nvidia.com>
 <20200916163343.GA76252@otc-nc-03> <20200916170113.GD3699@nvidia.com>
 <20200916112110.000024ee@intel.com> <20200916183841.GI6199@nvidia.com>
 <20200916160901.000046ec@intel.com>
 <69ec9537-460f-2351-fa90-c31aaeef3c4b@redhat.com>
 <20200917111754.00006bcc@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ad909852-1201-6a4a-ffb0-9ad0df6c2e81@redhat.com>
Date: Fri, 18 Sep 2020 11:58:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200917111754.00006bcc@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 "Raj, Ashok" <ashok.raj@intel.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, stefanha@gmail.com, yi.y.sun@intel.com,
 Alex Williamson <alex.williamson@redhat.com>, iommu@lists.linux-foundation.org,
 Jason Gunthorpe <jgg@nvidia.com>, hao.wu@intel.com, jun.j.tian@intel.com
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

Ck9uIDIwMjAvOS8xOCDkuIrljYgyOjE3LCBKYWNvYiBQYW4gKEp1bikgd3JvdGU6Cj4gSGkgSmFz
b24sCj4gT24gVGh1LCAxNyBTZXAgMjAyMCAxMTo1Mzo0OSArMDgwMCwgSmFzb24gV2FuZyA8amFz
b3dhbmdAcmVkaGF0LmNvbT4KPiB3cm90ZToKPgo+PiBPbiAyMDIwLzkvMTcg5LiK5Y2INzowOSwg
SmFjb2IgUGFuIChKdW4pIHdyb3RlOgo+Pj4gSGkgSmFzb24sCj4+PiBPbiBXZWQsIDE2IFNlcCAy
MDIwIDE1OjM4OjQxIC0wMzAwLCBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPgo+Pj4g
d3JvdGU6Cj4+PiAgIAo+Pj4+IE9uIFdlZCwgU2VwIDE2LCAyMDIwIGF0IDExOjIxOjEwQU0gLTA3
MDAsIEphY29iIFBhbiAoSnVuKSB3cm90ZToKPj4+Pj4gSGkgSmFzb24sCj4+Pj4+IE9uIFdlZCwg
MTYgU2VwIDIwMjAgMTQ6MDE6MTMgLTAzMDAsIEphc29uIEd1bnRob3JwZQo+Pj4+PiA8amdnQG52
aWRpYS5jb20+IHdyb3RlOgo+Pj4+PiAgICAgICAKPj4+Pj4+IE9uIFdlZCwgU2VwIDE2LCAyMDIw
IGF0IDA5OjMzOjQzQU0gLTA3MDAsIFJhaiwgQXNob2sgd3JvdGU6Cj4+Pj4+Pj4gT24gV2VkLCBT
ZXAgMTYsIDIwMjAgYXQgMTI6MDc6NTRQTSAtMDMwMCwgSmFzb24gR3VudGhvcnBlCj4+Pj4+Pj4g
d3JvdGU6Cj4+Pj4+Pj4+IE9uIFR1ZSwgU2VwIDE1LCAyMDIwIGF0IDA1OjIyOjI2UE0gLTA3MDAs
IEphY29iIFBhbiAoSnVuKQo+Pj4+Pj4+PiB3cm90ZToKPj4+Pj4+Pj4+PiBJZiB1c2VyIHNwYWNl
IHdhbnRzIHRvIGJpbmQgcGFnZSB0YWJsZXMsIGNyZWF0ZSB0aGUgUEFTSUQKPj4+Pj4+Pj4+PiB3
aXRoIC9kZXYvc3ZhLCB1c2UgaW9jdGxzIHRoZXJlIHRvIHNldHVwIHRoZSBwYWdlIHRhYmxlCj4+
Pj4+Pj4+Pj4gdGhlIHdheSBpdCB3YW50cywgdGhlbiBwYXNzIHRoZSBub3cgY29uZmlndXJlZCBQ
QVNJRCB0byBhCj4+Pj4+Pj4+Pj4gZHJpdmVyIHRoYXQgY2FuIHVzZSBpdC4KPj4+Pj4+Pj4+IEFy
ZSB3ZSB0YWxraW5nIGFib3V0IGJhcmUgbWV0YWwgU1ZBPwo+Pj4+Pj4+PiBXaGF0IGEgd2VpcmQg
dGVybS4KPj4+Pj4+PiBHbGFkIHlvdSBub3RpY2VkIGl0IGF0IHY3IDotKQo+Pj4+Pj4+Cj4+Pj4+
Pj4gQW55IHN1Z2dlc3Rpb25zIG9uIHNvbWV0aGluZyBsZXNzIHdlaXJkIHRoYW4KPj4+Pj4+PiBT
aGFyZWQgVmlydHVhbCBBZGRyZXNzaW5nPyBUaGVyZSBpcyBhIHJlYXNvbiB3aHkgd2UgbW92ZWQg
ZnJvbQo+Pj4+Pj4+IFNWTSB0byBTVkEuCj4+Pj4+PiBTVkEgaXMgZmluZSwgd2hhdCBpcyAiYmFy
ZSBtZXRhbCIgc3VwcG9zZWQgdG8gbWVhbj8KPj4+Pj4+ICAgICAgIAo+Pj4+PiBXaGF0IEkgbWVh
bnQgaGVyZSBpcyBzaGFyaW5nIHZpcnR1YWwgYWRkcmVzcyBiZXR3ZWVuIERNQSBhbmQgaG9zdAo+
Pj4+PiBwcm9jZXNzLiBUaGlzIHJlcXVpcmVzIGRldmljZXMgcGVyZm9ybSBETUEgcmVxdWVzdCB3
aXRoIFBBU0lEIGFuZAo+Pj4+PiB1c2UgSU9NTVUgZmlyc3QgbGV2ZWwvc3RhZ2UgMSBwYWdlIHRh
Ymxlcy4KPj4+Pj4gVGhpcyBjYW4gYmUgZnVydGhlciBkaXZpZGVkIGludG8gMSkgdXNlciBTVkEg
Mikgc3VwZXJ2aXNvciBTVkEKPj4+Pj4gKHNoYXJpbmcgaW5pdF9tbSkKPj4+Pj4KPj4+Pj4gTXkg
cG9pbnQgaXMgdGhhdCAvZGV2L3N2YSBpcyBub3QgdXNlZnVsIGhlcmUgc2luY2UgdGhlIGRyaXZl
ciBjYW4KPj4+Pj4gcGVyZm9ybSBQQVNJRCBhbGxvY2F0aW9uIHdoaWxlIGRvaW5nIFNWQSBiaW5k
Lgo+Pj4+IE5vLCB5b3UgYXJlIHRoaW5raW5nIHRvbyBzbWFsbC4KPj4+Pgo+Pj4+IExvb2sgYXQg
VkRQQSwgaXQgaGFzIGEgU1ZBIHVBUEkuIFNvbWUgSFcgbWlnaHQgdXNlIFBBU0lEIGZvciB0aGUK
Pj4+PiBTVkEuCj4+PiBDb3VsZCB5b3UgcG9pbnQgdG8gbWUgdGhlIFNWQSBVQVBJPyBJIGNvdWxk
bid0IGZpbmQgaXQgaW4gdGhlCj4+PiBtYWlubGluZS4gU2VlbXMgVkRQQSB1c2VzIFZIT1NUIGlu
dGVyZmFjZT8KPj4KPj4gSXQncyB0aGUgdmhvc3RfaW90bGJfbXNnIGRlZmluZWQgaW4gdWFwaS9s
aW51eC92aG9zdF90eXBlcy5oLgo+Pgo+IFRoYW5rcyBmb3IgdGhlIHBvaW50ZXIsIGZvciBjb21w
bGV0ZSB2U1ZBIGZ1bmN0aW9uYWxpdHkgd2Ugd291bGQgbmVlZAo+IDEgVExCIGZsdXNoIChJT1RM
QiBhbmQgUEFTSUQgY2FjaGUgZXRjLikKPiAyIFBBU0lEIGFsbG9jL2ZyZWUKPiAzIGJpbmQvdW5i
aW5kIHBhZ2UgdGFibGVzIG9yIFBBU0lEIHRhYmxlcwo+IDQgUGFnZSByZXF1ZXN0IHNlcnZpY2UK
Pgo+IFNlZW1zIHZob3N0X2lvdGxiX21zZyBjYW4gYmUgdXNlZCBmb3IgIzEgcGFydGlhbGx5LiBB
bmQgdGhlCj4gcHJvcG9zYWwgaXMgdG8gcGx1Y2sgb3V0IHRoZSByZXN0IGludG8gL2Rldi9zZGE/
IFNlZW1zIGF3a3dhcmQgYXMgQWxleAo+IHBvaW50ZWQgb3V0IGVhcmxpZXIgZm9yIHNpbWlsYXIg
c2l0dWF0aW9uIGluIFZGSU8uCgoKQ29uc2lkZXIgaXQgZG9lc24ndCBoYXZlIGFueSBQQVNJRCBz
dXBwb3J0IHlldCwgbXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IAppZiB3ZSBnbyB3aXRoIC9kZXYv
c3ZhOgoKLSB2aG9zdCB1QVBJIHdpbGwgc3RpbGwga2VlcCB0aGUgdUFQSSBmb3IgYXNzb2NpYXRp
bmcgYW4gQVNJRCB0byBhIApzcGVjaWZpYyB2aXJ0cXVldWUKLSBleGNlcHQgZm9yIHRoaXMsIHdl
IGNhbiB1c2UgL2Rldi9zdmEgZm9yIGFsbCB0aGUgcmVzdCAoUClBU0lEIG9wZXJhdGlvbnMKCgo+
Cj4+PiAgIAo+Pj4+IFdoZW4gVkRQQSBpcyB1c2VkIGJ5IERQREsgaXQgbWFrZXMgc2Vuc2UgdGhh
dCB0aGUgUEFTSUQgd2lsbCBiZSBTVkEKPj4+PiBhbmQgMToxIHdpdGggdGhlIG1tX3N0cnVjdC4K
Pj4+PiAgIAo+Pj4gSSBzdGlsbCBkb24ndCBzZWUgd2h5IGJhcmUgbWV0YWwgRFBESyBuZWVkcyB0
byBnZXQgYSBoYW5kbGUgb2YgdGhlCj4+PiBQQVNJRC4KPj4KPj4gTXkgdW5kZXJzdGFuZGluZyBp
cyB0aGF0IGl0IG1heToKPj4KPj4gLSBoYXZlIGEgdW5pZmllZCB1QVBJIHdpdGggdlNWQTogYWxs
b2MsIGJpbmQsIHVuYmluZCwgZnJlZQo+IEdvdCB5b3VyIHBvaW50LCBidXQgdlNWQSBuZWVkcyBt
b3JlIHRoYW4gdGhlc2UKCgpZZXMgaXQncyBqdXN0IGEgc3Vic2V0IG9mIHdoYXQgdlNWQSByZXF1
aXJlZC4KCgo+Cj4+IC0gbGVhdmUgdGhlIGJpbmRpbmcgcG9saWN5IHRvIHVzZXJzcGFjZSBpbnN0
ZWFkIG9mIHRoZSB1c2luZyBhCj4+IGltcGxpZWQgb25lIGluIHRoZSBrZW5yZWwKPj4KPiBPbmx5
IGlmIG5lY2Vzc2FyeS4KCgpZZXMsIEkgdGhpbmsgaXQncyBhbGwgYWJvdXQgdmlzaWJpbGl0eShm
bGV4aWJpbGl0eSkgYW5kKiptYW5hZ2VhYmlsaXR5LgoKQ29uc2lkZXIgZGV2aWNlIGhhcyBxdWV1
ZSBBLCBCLCBDLiBXZSB3aWxsIG9ubHkgZGVkaWNhdGVkIHF1ZXVlIEEsIEIgZm9yIApvbmUgUEFT
SUQoZm9yIHZTVkEpIGFuZCBDIHdpdGggYW5vdGhlciBQQVNJRChmb3IgU1ZBKS4gSXQgbG9va3Mg
dG8gbWUgCnRoZSBjdXJyZW50IHN2YV9iaW5kKCkgQVBJIGRvZXNuJ3Qgc3VwcG9ydCB0aGlzLiBX
ZSBzdGlsbCBuZWVkIGFuIEFQSSAKZm9yIGFsbG9jYXRpbmcgYSBQQVNJRCBmb3IgU1ZBIGFuZCBh
c3NpZ24gaXQgdG8gdGhlIChtZWRpYXRlZCkgZGV2aWNlLsKgIApUaGlzIGNhc2UgaXMgcHJldHR5
IGNvbW1vbiBmb3IgaW1wbGVtZW50aW5nIGEgc2hhZG93IHF1ZXVlIGZvciBhIGd1ZXN0LgoKCj4K
Pj4+IFBlcmhhcHMgdGhlIFNWQSBwYXRjaCB3b3VsZCBleHBsYWluLiBPciBhcmUgeW91IHRhbGtp
bmcgYWJvdXQKPj4+IHZEUEEgRFBESyBwcm9jZXNzIHRoYXQgaXMgdXNlZCB0byBzdXBwb3J0IHZp
cnRpby1uZXQtcG1kIGluIHRoZQo+Pj4gZ3Vlc3Q/Cj4+Pj4gV2hlbiBWRFBBIGlzIHVzZWQgYnkg
cWVtdSBpdCBtYWtlcyBzZW5zZSB0aGF0IHRoZSBQQVNJRCB3aWxsIGJlIGFuCj4+Pj4gYXJiaXRh
cnkgSU9WQSBtYXAgY29uc3RydWN0ZWQgdG8gYmUgMToxIHdpdGggdGhlIGd1ZXN0IHZDUFUKPj4+
PiBwaHlzaWNhbCBtYXAuIC9kZXYvc3ZhIGFsbG93cyBhIHNpbmdsZSB1QVBJIHRvIGRvIHRoaXMg
a2luZCBvZgo+Pj4+IHNldHVwLCBhbmQgcWVtdSBjYW4gc3VwcG9ydCBpdCB3aGlsZSBzdXBwb3J0
aW5nIGEgcmFuZ2Ugb2YgU1ZBCj4+Pj4ga2VybmVsIGRyaXZlcnMuIFZEUEEgYW5kIHZmaW8tbWRl
diBhcmUgb2J2aW91cyBpbml0aWFsIHRhcmdldHMuCj4+Pj4KPj4+PiAqQk9USCogYXJlIG5lZWRl
ZC4KPj4+Pgo+Pj4+IEluIGdlbmVyYWwgYW55IHVBUEkgZm9yIFBBU0lEIHNob3VsZCBoYXZlIHRo
ZSBvcHRpb24gdG8gdXNlIGVpdGhlcgo+Pj4+IHRoZSBtbV9zdHJ1Y3QgU1ZBIFBBU0lEICpPUiog
YSBQQVNJRCBmcm9tIC9kZXYvc3ZhLiBJdCBjb3N0cwo+Pj4+IHZpcnR1YWxseSBub3RoaW5nIHRv
IGltcGxlbWVudCB0aGlzIGluIHRoZSBkcml2ZXIgYXMgUEFTSUQgaXMganVzdAo+Pj4+IGEgbnVt
YmVyLCBhbmQgZ2l2ZXMgc28gbXVjaCBtb3JlIGZsZXhhYmlsaXR5Lgo+Pj4+ICAgCj4+PiBOb3Qg
cmVhbGx5IG5vdGhpbmcgaW4gdGVybXMgb2YgUEFTSUQgbGlmZSBjeWNsZXMuIEZvciBleGFtcGxl
LCBpZgo+Pj4gdXNlciB1c2VzIHVhY2NlIGludGVyZmFjZSB0byBvcGVuIGFuIGFjY2VsZXJhdG9y
LCBpdCBnZXRzIGFuCj4+PiBGRF9hY2MuIFRoZW4gaXQgb3BlbnMgL2Rldi9zdmEgdG8gYWxsb2Nh
dGUgUEFTSUQgdGhlbiBnZXQgYW5vdGhlcgo+Pj4gRkRfcGFzaWQuIFRoZW4gd2UgcGFzcyBGRF9w
YXNpZCB0byB0aGUgZHJpdmVyIHRvIGJpbmQgcGFnZSB0YWJsZXMsCj4+PiBwZXJoYXBzIG11bHRp
cGxlIGRyaXZlcnMuIE5vdyB3ZSBoYXZlIHRvIHdvcnJ5IGFib3V0IElmIEZEX3Bhc2lkCj4+PiBn
ZXRzIGNsb3NlZCBiZWZvcmUgRkRfYWNjKHMpIGNsb3NlZCBhbmQgYWxsIHRoZXNlIHJhY2UgY29u
ZGl0aW9ucy4KPj4KPj4gSSdtIG5vdCBzdXJlIEkgdW5kZXJzdGFuZCB0aGlzLiBCdXQgdGhpcyBk
ZW1vbnN0cmF0ZXMgdGhlIGZsZXhpYmlsaXR5Cj4+IG9mIGFuIHVuaWZpZWQgdUFQSS4gRS5nIGl0
IGFsbG93cyB2RFBBIGFuZCBWRklPIGRldmljZSB0byB1c2UgdGhlCj4+IHNhbWUgUEFJU0Qgd2hp
Y2ggY2FuIGJlIHNoYXJlZCB3aXRoIGEgcHJvY2VzcyBpbiB0aGUgZ3Vlc3QuCj4+Cj4gVGhpcyBp
cyBmb3IgdXNlciBETUEgbm90IGZvciB2U1ZBLiBJIHdhcyBjb250ZW5kaW5nIHRoYXQgL2Rldi9z
dmEKPiBjcmVhdGVzIHVubmVjZXNzYXJ5IHN0ZXBzIGZvciBzdWNoIHVzYWdlLgoKCkEgcXVlc3Rp
b24gaGVyZSBpcyB3aGVyZSB0aGUgUEFTSUQgbWFuYWdlbWVudCBpcyBleHBlY3RlZCB0byBiZSBk
b25lLiAKSSdtIG5vdCBxdWl0ZSBzdXJlIHRoZSBzaWxlbnQgMToxIGJpbmRpbmcgZG9uZSBpbiBp
bnRlbF9zdm1fYmluZF9tbSgpIApjYW4gc2F0aXNmeSB0aGUgcmVxdWlyZW1lbnQgZm9yIG1hbmFn
ZW1lbnQgbGF5ZXIuCgoKPgo+IEZvciB2U1ZBLCBJIHRoaW5rIHZEUEEgYW5kIFZGSU8gY2FuIHBv
dGVudGlhbGx5IHNoYXJlIGJ1dCBJIGFtIG5vdAo+IHNlZWluZyBjb252aW5jaW5nIGJlbmVmaXRz
Lgo+Cj4gSWYgYSBndWVzdCBwcm9jZXNzIHdhbnRzIHRvIGRvIFNWQSB3aXRoIGEgVkZJTyBhc3Np
Z25lZCBkZXZpY2UgYW5kIGEKPiB2RFBBLWJhY2tlZCB2aXJ0aW8tbmV0IGF0IHRoZSBzYW1lIHRp
bWUsIGl0IG1pZ2h0IGJlIGEgbGltaXRhdGlvbiBpZgo+IFBBU0lEIGlzIG5vdCBtYW5hZ2VkIHZp
YSBhIGNvbW1vbiBpbnRlcmZhY2UuCgoKWWVzLgoKCj4gQnV0IEkgYW0gbm90IHN1cmUgaG93IHZE
UEEKPiBTVkEgc3VwcG9ydCB3aWxsIGxvb2sgbGlrZSwgZG9lcyBpdCBzdXBwb3J0IGdJT1ZBPyBu
ZWVkIHZpcnRpbyBJT01NVT8KCgpZZXMsIGl0IHN1cHBvcnRzIGdJT1ZBIGFuZCBpdCBzaG91bGQg
d29yayB3aXRoIGFueSB0eXBlIG9mIHZJT01NVS4gSSAKdGhpbmsgdkRQQSB3aWxsIHN0YXJ0IGZy
b20gSW50ZWwgdklPTU1VIHN1cHBvcnQgaW4gUWVtdS4KCkZvciB2aXJ0aW8gSU9NTVUsIHdlIHdp
bGwgcHJvYmFibHkgc3VwcG9ydCBpdCBpbiB0aGUgZnV0dXJlIGNvbnNpZGVyIGl0IApkb2Vzbid0
IGhhdmUgYW55IFNWQSBjYXBhYmlsaXR5LCBhbmQgaXQgZG9lc24ndCB1c2UgYSBwYWdlIHRhYmxl
IHRoYXQgCmNhbiBiZSBuZXN0ZWQgdmlhIGEgaGFyZHdhcmUgSU9NTVUuCgoKPj4gRm9yIHRoZSBy
YWNlIGNvbmRpdGlvbiwgaXQgY291bGQgYmUgcHJvYmFibHkgc29sdmVkIHdpdGggcmVmY250Lgo+
Pgo+IEFncmVlZCBidXQgdGhlIGJlc3Qgc29sdXRpb24gbWlnaHQgYmUgbm90IHRvIGhhdmUgdGhl
IHByb2JsZW0gaW4gdGhlCj4gZmlyc3QgcGxhY2UgOikKCgpJIGFncmVlLCBpdCdzIG9ubHkgd29y
dGggdG8gYm90aGVyIGlmIGl0IGhhcyByZWFsIGJlbmVmaXRzLgoKVGhhbmtzCgoKPgo+PiBUaGFu
a3MKPj4KPj4KPj4+IElmIHdlIGRvIG5vdCBleHBvc2UgRkRfcGFzaWQgdG8gdGhlIHVzZXIsIHRo
ZSB0ZWFyZG93biBpcyBtdWNoCj4+PiBzaW1wbGVyIGFuZCBzdHJlYW1saW5lZC4gRm9sbG93aW5n
IGVhY2ggRkRfYWNjIGNsb3NlLCBQQVNJRCB1bmJpbmQKPj4+IGlzIHBlcmZvcm1lZC4KPj4+Pj4g
WWkgY2FuIGNvcnJlY3QgbWUgYnV0IHRoaXMgc2V0IGlzIGlzIGFib3V0IFZGSU8tUENJLCBWRklP
LW1kZXYKPj4+Pj4gd2lsbCBiZSBpbnRyb2R1Y2VkIGxhdGVyLgo+Pj4+IExhc3QgcGF0Y2ggaXM6
Cj4+Pj4KPj4+PiAgICAgdmZpby90eXBlMTogQWRkIHZTVkEgc3VwcG9ydCBmb3IgSU9NTVUtYmFj
a2VkIG1kZXZzCj4+Pj4KPj4+PiBTbyBwcmV0dHkgaGFyZCB0byBzZWUgaG93IHRoaXMgaXMgbm90
IGFib3V0IHZmaW8tbWRldiwgYXQgbGVhc3QgYQo+Pj4+IGxpdHRsZS4uCj4+Pj4KPj4+PiBKYXNv
bgo+Pj4gVGhhbmtzLAo+Pj4KPj4+IEphY29iCj4+PiAgIAo+Cj4gVGhhbmtzLAo+Cj4gSmFjb2IK
PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUg
bWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
