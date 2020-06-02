Return-Path: <SRS0=royy=7P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8839C433DF
	for <iommu@archiver.kernel.org>; Tue,  2 Jun 2020 09:39:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BDCC20679
	for <iommu@archiver.kernel.org>; Tue,  2 Jun 2020 09:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="D9s99Khu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BDCC20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 68399882EB;
	Tue,  2 Jun 2020 09:39:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qPJ88G12QcKM; Tue,  2 Jun 2020 09:39:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E363D882CC;
	Tue,  2 Jun 2020 09:39:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF6D3C0178;
	Tue,  2 Jun 2020 09:39:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3592DC016E
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 09:39:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1F04A22011
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 09:39:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FksOn7TdKwY5 for <iommu@lists.linux-foundation.org>;
 Tue,  2 Jun 2020 09:39:35 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 by silver.osuosl.org (Postfix) with ESMTPS id 4200A2078B
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 09:39:33 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1591090775; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=IekPtOjoRZDjZaNDXgKSitUXOmu6PIOrWvgVXoQjNic=;
 b=D9s99KhucRBuqzD62xRF3Mz+OAq9xYYVfGF39+HcnjVQdqzTLvbwGQoksm0npXQW/QXTYQGf
 qzGaG8blhYfF4vrvvNkh88v7pET6z/w3VSJf5uVEBalAVADiuk9A5YtCm1i+SlZug2u1yNI7
 2auJ+/pmyFe8SFm08xBRMBKjFBU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-west-2.postgun.com with SMTP id
 5ed61e5246d39fc0a2cc1a6e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 02 Jun 2020 09:39:30
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id E0BDBC4339C; Tue,  2 Jun 2020 09:39:29 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested) (Authenticated sender: guptap)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 22DF2C433CA;
 Tue,  2 Jun 2020 09:39:29 +0000 (UTC)
MIME-Version: 1.0
Date: Tue, 02 Jun 2020 15:09:29 +0530
From: guptap@codeaurora.org
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/dma: limit iova free size to unmmaped iova
In-Reply-To: <4ba082d3bb965524157704ea1ffb1ff4@codeaurora.org>
References: <20200521113004.12438-1-guptap@codeaurora.org>
 <7aaa8dcc-6a47-f256-431d-2a1b034b4076@arm.com>
 <90662ef3123dbf2e93f9718ee5cc14a7@codeaurora.org>
 <2d873ab9-ebb9-3c2d-f129-55a036ab47d0@arm.com>
 <4ba082d3bb965524157704ea1ffb1ff4@codeaurora.org>
Message-ID: <2bfb4ce3a2dfeb2d585f0308a9002feb@codeaurora.org>
X-Sender: guptap@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: mhocko@suse.com, owner-linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Andrew Morton <akpm@linux-foundation.org>
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

T24gMjAyMC0wNS0yNiAxMjo0OSwgZ3VwdGFwQGNvZGVhdXJvcmEub3JnIHdyb3RlOgo+IE9uIDIw
MjAtMDUtMjIgMTQ6NTQsIFJvYmluIE11cnBoeSB3cm90ZToKPj4gT24gMjAyMC0wNS0yMiAwNzoy
NSwgZ3VwdGFwQGNvZGVhdXJvcmEub3JnIHdyb3RlOgo+Pj4gT24gMjAyMC0wNS0yMiAwMTo0Niwg
Um9iaW4gTXVycGh5IHdyb3RlOgo+Pj4+IE9uIDIwMjAtMDUtMjEgMTI6MzAsIFByYWthc2ggR3Vw
dGEgd3JvdGU6Cj4+PiBJIGFncmVlLCB3ZSBzaG91bGRuJ3QgYmUgZnJlZWluZyB0aGUgcGFydGlh
bCBpb3ZhLiBJbnN0ZWFkIGp1c3QgCj4+PiBtYWtpbmcKPj4+IHN1cmUgaWYgdW5tYXAgd2FzIHN1
Y2Nlc3NmdWwgc2hvdWxkIGJlIHN1ZmZpY2llbnQgYmVmb3JlIGZyZWVpbmcgCj4+PiBpb3ZhLiBT
byBjaGFuZ2UKPj4+IGNhbiBpbnN0ZWFkIGJlIHNvbWV0aGluZyBsaWtlIHRoaXM6Cj4+PiAKPj4+
IC3CoMKgwqAgaW9tbXVfZG1hX2ZyZWVfaW92YShjb29raWUsIGRtYV9hZGRyLCBzaXplKTsKPj4+
ICvCoMKgwqAgaWYgKHVubWFwcGVkKQo+Pj4gK8KgwqDCoMKgwqDCoMKgIGlvbW11X2RtYV9mcmVl
X2lvdmEoY29va2llLCBkbWFfYWRkciwgc2l6ZSk7Cj4+PiAKPj4+PiBUQkggbXkgZ3V0IGZlZWxp
bmcgaGVyZSBpcyB0aGF0IHlvdSdyZSByZWFsbHkganVzdCB0cnlpbmcgdG8gdHJlYXQgYQo+Pj4+
IHN5bXB0b20gb2YgYW5vdGhlciBidWcgZWxzZXdoZXJlLCBuYW1lbHkgc29tZSBkcml2ZXIgY2Fs
bGluZwo+Pj4+IGRtYV91bm1hcF8qIG9yIGRtYV9mcmVlXyogd2l0aCB0aGUgd3JvbmcgYWRkcmVz
cyBvciBzaXplIGluIHRoZSAKPj4+PiBmaXJzdAo+Pj4+IHBsYWNlLgo+Pj4+IAo+Pj4gVGhpcyBj
b25kaXRpb24gd291bGQgYXJpc2Ugb25seSBpZiBkcml2ZXIgY2FsbGluZyBkbWFfdW5tYXAvZnJl
ZV8qIAo+Pj4gd2l0aCAwCj4+PiBpb3ZhX3Bmbi4gVGhpcyB3aWxsIGJlIGZsYWdnZWQgd2l0aCBh
IHdhcm5pbmcgZHVyaW5nIHVubWFwIGJ1dCB3aWxsIAo+Pj4gdHJpZ2dlcgo+Pj4gcGFuaWMgbGF0
ZXIgb24gd2hpbGUgZG9pbmcgdW5yZWxhdGVkIGRtYV9tYXAvdW5tYXBfKi4gSWYgdW5tYXBwZWQg
aGFzIAo+Pj4gYWxyZWFkeQo+Pj4gZmFpbGVkIGZvciBpbnZhbGlkIGlvdmEsIHRoZXJlIGlzIG5v
IHJlYXNvbiB3ZSBzaG91bGQgY29uc2lkZXIgdGhpcyAKPj4+IGFzIHZhbGlkCj4+PiBpb3ZhIGFu
ZCBmcmVlLiBUaGlzIHBhcnQgc2hvdWxkIGJlIGZpeGVkLgo+PiAKPj4gSSBkaXNhZ3JlZS4gSW4g
Z2VuZXJhbCwgaWYgZHJpdmVycyBjYWxsIHRoZSBETUEgQVBJIGluY29ycmVjdGx5IGl0IGlzCj4+
IGxpYWJsZSB0byBsZWFkIHRvIGRhdGEgbG9zcywgbWVtb3J5IGNvcnJ1cHRpb24sIGFuZCB2YXJp
b3VzIG90aGVyCj4+IHVucGxlYXNhbnQgbWlzYmVoYXZpb3VyIC0gaXQgaXMgbm90IHRoZSBETUEg
bGF5ZXIncyBqb2IgdG8gYXR0ZW1wdCB0bwo+PiBwYXBlciBvdmVyIGRyaXZlciBidWdzLgo+PiAK
Pj4gVGhlcmUgKmlzKiBhbiBhcmd1bWVudCBmb3IgZG93bmdyYWRpbmcgdGhlIEJVR19PTigpIGlu
Cj4+IGlvdmFfbWFnYXppbmVfZnJlZV9wZm5zKCkgdG8gYSBXQVJOX09OKCksIHNpbmNlIGZyYW5r
bHkgaXQgaXNuJ3QgYQo+PiBzdWZmaWNpZW50bHkgc2VyaW91cyBjb25kaXRpb24gdG8ganVzdGlm
eSBraWxsaW5nIHRoZSB3aG9sZSBtYWNoaW5lCj4+IGltbWVkaWF0ZWx5LCBidXQgTkFLIHRvIGJv
ZGdpbmcgdGhlIGlvbW11LWRtYSBtaWQtbGF5ZXIgdG8gImZpeCIgdGhhdC4KPj4gQSBzZXJpb3Vz
IGJ1ZyBhbHJlYWR5IGhhcHBlbmVkIGVsc2V3aGVyZSwgc28gdHJ5aW5nIHRvIGhpZGUgdGhlCj4+
IGZhbGxvdXQgcmVhbGx5IGRvZXNuJ3QgaGVscCBhbnlvbmUuCj4+IAo+IFNvcnJ5IGZvciBkZWxh
eWVkIHJlc3BvbnNlLCBpdCB3YXMgYSBsb25nIHdlZWtlbmQuCj4gSSBhZ3JlZSB0aGF0IGludmFs
aWQgRE1BIEFQSSBjYWxsIGNhbiByZXN1bHQgaW4gdW5leHBlY3RlZCBpc3N1ZXMgYW5kIAo+IGNs
aWVudAo+IHNob3VsZCBmaXggaXQsIGJ1dCB0aGVuIHRoZSBwcmVzZW50IGJlaGF2aW9yIG1ha2Vz
IGl0IGRpZmZpY3VsdCB0byAKPiBjYXRjaCBjYXNlcwo+IHdoZW4gZHJpdmVyIGlzIG1ha2luZyB3
cm9uZyBETUEgQVBJIGNhbGxzLiBXaGVuIGludmFsaWQgaW92YSBwZm4gaXMgCj4gcGFzc2VkIGl0
Cj4gZG9lc24ndCBmYWlsIHRoZW4gYW5kIHRoZXJlLCB0aG91Z2ggRE1BIGxheWVyIGlzIGF3YXJl
IG9mIGlvdmEgYmVpbmcgCj4gaW52YWxpZC4gSXQKPiBmYWlscyBtdWNoIGFmdGVyIHRoYXQgaW4g
dGhlIGNvbnRleHQgb2YgYW4gdmFsaWQgbWFwL3VubWFwLCB3aXRoIAo+IEJVR19PTigpLgo+IAo+
IERvd25ncmFkaW5nIEJVR19PTigpIHRvIFdBUk5fT04oKSBpbiBpb3ZhX21hZ2F6aW5lX2ZyZWVf
cGZucygpIHdpbGwgbm90IAo+IGhlbHAKPiBtdWNoIGFzIGludmFsaWQgaW92YSB3aWxsIGNhdXNl
IE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZS4KPiAKPiBJIHNlZSBubyByZWFzb24gd2h5IERNQSBs
YXllciB3YW50cyB0byBmcmVlIGFuIGlvdmEgZm9yIHdoaWNoIHVubWFwcGVkIAo+IGZhaWxlZC4K
PiBJTUhPIHF1ZXVpbmcgYW4gaW52YWxpZCBpb3ZhICh3aGljaCBhbHJlYWR5IGZhaWxlZCB1bm1h
cCkgdG8gcmNhY2hlIAo+IHdoaWNoCj4gZXZlbnR1YWxseSBnb2luZyB0byBjcmFzaCB0aGUgc3lz
dGVtIGxvb2tzIGxpa2UgaW9tbXUtZG1hIGxheWVyIGlzc3VlLgo+IAo+IFRoYW5rcywKPiBQcmFr
YXNoCgpwaW5nPwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
