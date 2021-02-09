Return-Path: <SRS0=nJTY=HL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92265C433E6
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 12:02:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EE2E64EBC
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 12:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EE2E64EBC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B3A16862DB;
	Tue,  9 Feb 2021 12:02:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1Rvk1aC2yjii; Tue,  9 Feb 2021 12:02:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 375F48629C;
	Tue,  9 Feb 2021 12:02:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22846C0891;
	Tue,  9 Feb 2021 12:02:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94AF9C013A
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 12:01:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 90E5C87363
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 12:01:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 105ugXsL-BaA for <iommu@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 12:01:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 02B1F86B80
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 12:01:58 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2DDC64E16;
 Tue,  9 Feb 2021 12:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1612872117;
 bh=KXnFUWkeE3RzAL45lDxdFx/y1wzKceAzbuyX52i4TsI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DOTJHzzs0FAsJ9XZl1aGZ5cH8m8J6FlrUnzLTsv+HQsJPyoVjmCXhXEjUCceVUmNA
 mm29z79OAsLiQ013RWN+KhCvGh3r5fqgAyfLkqw+sPpEldf1l3bGpk7z8NvUTcBD9x
 gD47PEY6W2LOY6R2YitBTaNoniiO/UE5cclIXM40=
Date: Tue, 9 Feb 2021 13:01:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory pin
Message-ID: <YCJ5k/Bxxkg3BNNj@kroah.com>
References: <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
 <ED58431F-5972-47D1-BF50-93A20AD86C46@amacapital.net>
 <2e6cf99f-beb6-9bef-1316-5e58fb0aa86e@hisilicon.com>
 <YCJX6QFQ4hsNRrFj@kroah.com>
 <f73951ba-84be-b7f8-8c79-db84bc9081f3@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f73951ba-84be-b7f8-8c79-db84bc9081f3@hisilicon.com>
Cc: jean-philippe@linaro.org, kevin.tian@intel.com,
 Sihang Chen <chensihang1@hisilicon.com>, jgg@ziepe.ca,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 zhangfei.gao@linaro.org, Andrew Morton <akpm@linux-foundation.org>,
 liguozhu@hisilicon.com, linux-arm-kernel@lists.infradead.org
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

T24gVHVlLCBGZWIgMDksIDIwMjEgYXQgMDc6NTg6MTVQTSArMDgwMCwgWmhvdSBXYW5nIHdyb3Rl
Ogo+IE9uIDIwMjEvMi85IDE3OjM3LCBHcmVnIEtIIHdyb3RlOgo+ID4gT24gVHVlLCBGZWIgMDks
IDIwMjEgYXQgMDU6MTc6NDZQTSArMDgwMCwgWmhvdSBXYW5nIHdyb3RlOgo+ID4+IE9uIDIwMjEv
Mi84IDY6MDIsIEFuZHkgTHV0b21pcnNraSB3cm90ZToKPiA+Pj4KPiA+Pj4KPiA+Pj4+IE9uIEZl
YiA3LCAyMDIxLCBhdCAxMjozMSBBTSwgWmhvdSBXYW5nIDx3YW5nemhvdTFAaGlzaWxpY29uLmNv
bT4gd3JvdGU6Cj4gPj4+Pgo+ID4+Pj4g77u/U1ZBKHNoYXJlIHZpcnR1YWwgYWRkcmVzcykgb2Zm
ZXJzIGEgd2F5IGZvciBkZXZpY2UgdG8gc2hhcmUgcHJvY2VzcyB2aXJ0dWFsCj4gPj4+PiBhZGRy
ZXNzIHNwYWNlIHNhZmVseSwgd2hpY2ggbWFrZXMgbW9yZSBjb252ZW5pZW50IGZvciB1c2VyIHNw
YWNlIGRldmljZQo+ID4+Pj4gZHJpdmVyIGNvZGluZy4gSG93ZXZlciwgSU8gcGFnZSBmYXVsdHMg
bWF5IGhhcHBlbiB3aGVuIGRvaW5nIERNQQo+ID4+Pj4gb3BlcmF0aW9ucy4gQXMgdGhlIGxhdGVu
Y3kgb2YgSU8gcGFnZSBmYXVsdCBpcyByZWxhdGl2ZWx5IGJpZywgRE1BCj4gPj4+PiBwZXJmb3Jt
YW5jZSB3aWxsIGJlIGFmZmVjdGVkIHNldmVyZWx5IHdoZW4gdGhlcmUgYXJlIElPIHBhZ2UgZmF1
bHRzLgo+ID4+Pj4gRnJvbSBhIGxvbmcgdGVybSB2aWV3LCBETUEgcGVyZm9ybWFuY2Ugd2lsbCBi
ZSBub3Qgc3RhYmxlLgo+ID4+Pj4KPiA+Pj4+IEluIGhpZ2gtcGVyZm9ybWFuY2UgSS9PIGNhc2Vz
LCBhY2NlbGVyYXRvcnMgbWlnaHQgd2FudCB0byBwZXJmb3JtCj4gPj4+PiBJL08gb24gYSBtZW1v
cnkgd2l0aG91dCBJTyBwYWdlIGZhdWx0cyB3aGljaCBjYW4gcmVzdWx0IGluIGRyYW1hdGljYWxs
eQo+ID4+Pj4gaW5jcmVhc2VkIGxhdGVuY3kuIEN1cnJlbnQgbWVtb3J5IHJlbGF0ZWQgQVBJcyBj
b3VsZCBub3QgYWNoaWV2ZSB0aGlzCj4gPj4+PiByZXF1aXJlbWVudCwgZS5nLiBtbG9jayBjYW4g
b25seSBhdm9pZCBtZW1vcnkgdG8gc3dhcCB0byBiYWNrdXAgZGV2aWNlLAo+ID4+Pj4gcGFnZSBt
aWdyYXRpb24gY2FuIHN0aWxsIHRyaWdnZXIgSU8gcGFnZSBmYXVsdC4KPiA+Pj4+Cj4gPj4+PiBW
YXJpb3VzIGRyaXZlcnMgd29ya2luZyB1bmRlciB0cmFkaXRpb25hbCBub24tU1ZBIG1vZGUgYXJl
IHVzaW5nCj4gPj4+PiB0aGVpciBvd24gc3BlY2lmaWMgaW9jdGwgdG8gZG8gcGluLiBTdWNoIGlv
Y3RsIGNhbiBiZSBzZWVuIGluIHY0bDIsCj4gPj4+PiBncHUsIGluZmluaWJhbmQsIG1lZGlhLCB2
ZmlvLCBldGMuIERyaXZlcnMgYXJlIHVzdWFsbHkgZG9pbmcgZG1hCj4gPj4+PiBtYXBwaW5nIHdo
aWxlIGRvaW5nIHBpbi4KPiA+Pj4+Cj4gPj4+PiBCdXQsIGluIFNWQSBtb2RlLCBwaW4gY291bGQg
YmUgYSBjb21tb24gbmVlZCB3aGljaCBpc24ndCBuZWNlc3NhcmlseQo+ID4+Pj4gYm91bmQgd2l0
aCBhbnkgZHJpdmVycywgYW5kIG5laXRoZXIgaXMgZG1hIG1hcHBpbmcgbmVlZGVkIGJ5IGRyaXZl
cnMKPiA+Pj4+IHNpbmNlIGRldmljZXMgYXJlIHVzaW5nIHRoZSB2aXJ0dWFsIGFkZHJlc3Mgb2Yg
Q1BVLiBUaHVzLCBJdCBpcyBiZXR0ZXIKPiA+Pj4+IHRvIGludHJvZHVjZSBhIG5ldyBjb21tb24g
c3lzY2FsbCBmb3IgaXQuCj4gPj4+Pgo+ID4+Pj4gVGhpcyBwYXRjaCBsZXZlcmFnZXMgdGhlIGRl
c2lnbiBvZiB1c2VyZmF1bHRmZCBhbmQgYWRkcyBtZW1waW5mZCBmb3IgcGluCj4gPj4+PiB0byBh
dm9pZCBtZXNzaW5nIHVwIG1tX3N0cnVjdC4gQSBmZCB3aWxsIGJlIGdvdCBieSBtZW1waW5mZCwg
dGhlbiB1c2VyCj4gPj4+PiBzcGFjZSBjYW4gZG8gcGluL3VucGluIHBhZ2VzIGJ5IGlvY3RscyBv
ZiB0aGlzIGZkLCBhbGwgcGlubmVkIHBhZ2VzIHVuZGVyCj4gPj4+PiBvbmUgZmlsZSB3aWxsIGJl
IHVucGlubmVkIGluIGZpbGUgcmVsZWFzZSBwcm9jZXNzLiBMaWtlIHBpbiBwYWdlIGNhc2VzIGlu
Cj4gPj4+PiBvdGhlciBwbGFjZXMsIGNhbl9kb19tbG9jayBpcyB1c2VkIHRvIGNoZWNrIHBlcm1p
c3Npb24gYW5kIGlucHV0Cj4gPj4+PiBwYXJhbWV0ZXJzLgo+ID4+Pgo+ID4+Pgo+ID4+PiBDYW4g
eW91IGRvY3VtZW50IHdoYXQgdGhlIHN5c2NhbGwgZG9lcz8KPiA+Pgo+ID4+IFdpbGwgYWRkIHJl
bGF0ZWQgZG9jdW1lbnQgaW4gRG9jdW1lbnRhdGlvbi92bS4KPiA+IAo+ID4gQSBtYW5wYWdlIGlz
IGFsd2F5cyBnb29kLCBhbmQgd2lsbCBiZSByZXF1aXJlZCBldmVudHVhbGx5IDopCj4gCj4gbWFu
cGFnZSBpcyBtYWludGFpbmVkIGluIGFub3RoZXIgcmVwby4gRG8geW91IG1lYW4gYWRkIGEgbWFu
cGFnZQo+IHBhdGNoIGluIHRoaXMgc2VyaWVzPwoKSXQncyBnb29kIHRvIHNob3cgaG93IGl0IHdp
bGwgYmUgdXNlZCwgZG9uJ3QgeW91IHRoaW5rPwoKdGhhbmtzLAoKZ3JlZyBrLWgKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0
CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
