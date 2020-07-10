Return-Path: <SRS0=wTTv=AV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09366C433E4
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 22:54:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7383206E2
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 22:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="a6gbiToy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7383206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 99E4988BC9;
	Fri, 10 Jul 2020 22:54:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YfG8fvERErrF; Fri, 10 Jul 2020 22:54:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E574188B6C;
	Fri, 10 Jul 2020 22:54:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB8F5C077B;
	Fri, 10 Jul 2020 22:54:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B8F5C016F
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 22:54:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6660C89FE7
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 22:54:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NRhm9+T2rW58 for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jul 2020 22:54:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com
 [209.85.208.194])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CDB1A89FE4
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 22:54:37 +0000 (UTC)
Received: by mail-lj1-f194.google.com with SMTP id z24so8150949ljn.8
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 15:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=U7Cna4GrnjdjT+b7GHMGh/kq7NJ5oQ1TUzK9PPX6KpA=;
 b=a6gbiToyPxUK3InfnvVZBU7oEbpYuMHbk6eqF+jMiyF6wPT/Z64eZPlf9V/Zaj1LP0
 kZkRbL0Saj2MSBonD6QOvJtpDCP2I9w4TiFF2V/ooWVigvgcrvNCYundCD09B2fhaRZC
 9fPoMp36q6NZg4kG4CICGp8zwK77O+Q8BzzEEVkx6GU9J8snKkF2O8x4zqunNyNJ4C1j
 OyJQQ9d6oHiaBsXbA+I2CBySWDPATgKnetYtFn0V5V8vPhQfKZrMg6MDD8ClpR3w7qev
 HSOD61JmBfoOD566JRe76F7tSyYg9i/0gen00XoPo7Cn5Pwb5VHMJvJgGb2KNuASs9ow
 7iNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=U7Cna4GrnjdjT+b7GHMGh/kq7NJ5oQ1TUzK9PPX6KpA=;
 b=Q/znRJzCxyTFSnlFH/yrMUvARs4Dg5AldLyFFe/Ptde/LD7CakFxHiqitCtYBXKEbu
 0wlNlaMr+DlELQibrCBgSNobSuc1CxIUwiWAOgVpKaBYoYBwjtOZtEVA58RDevtqKTZA
 ToZjGafsOUfgOBSs7+w6JMuL+btXQu+G390Osp1gG7/QdPThGwODC5W8Xhxa3ARL5l8Z
 ALarv26nr0cncfk12PwFxTBsitusQl4gcwB5fATirWyIMibrC0T5C+5FIBwGJ+Ss9BlV
 JVK0ju+UeYrQEFKcwofLTRd7raoZzCW5SIqfu1mU/m5cr2nRp4hok94boeUcX6x8a7GJ
 owRw==
X-Gm-Message-State: AOAM5317ipbpMZmtq+98oHfHZHisPrK5pDhX8PthQjUuw7+KfQ/A0Y1Z
 /0FAGpsZ3ZYh8vkdcZzmt6uwbwAt0XlrcUIm6AAk0w==
X-Google-Smtp-Source: ABdhPJxySBKefpD6GXqZmUhmKb2r0GA3lRRZwfUZbt1FM6SOa64Lc6mTaZPiKM9y79WZNi3Ps/gP+u3VrSXigyoFpm8=
X-Received: by 2002:a2e:9644:: with SMTP id z4mr12971597ljh.333.1594421675522; 
 Fri, 10 Jul 2020 15:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200707224604.3737893-4-rajatja@google.com>
 <20200710202922.GA77140@bjorn-Precision-5520>
 <20200710212853.GA328472@otc-nc-03>
In-Reply-To: <20200710212853.GA328472@otc-nc-03>
Date: Fri, 10 Jul 2020 15:53:59 -0700
Message-ID: <CACK8Z6F-8OZNJU8wqWuZq=moCaOi+3W=CzBeppfO31VZnkqBrg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] PCI/ACS: Enable PCI_ACS_TB for
 untrusted/external-facing devices
To: "Raj, Ashok" <ashok.raj@intel.com>
Cc: Todd Broch <tbroch@google.com>, linux-pci <linux-pci@vger.kernel.org>,
 "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Diego Rivas <diegorivas@google.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Furquan Shaikh <furquan@google.com>, Arnd Bergmann <arnd@arndb.de>,
 Saravana Kannan <saravanak@google.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>, Christian Kellner <christian@kellner.me>,
 Mattias Nissler <mnissler@google.com>, Jesse Barnes <jsbarnes@google.com>,
 Len Brown <lenb@kernel.org>, Rajat Jain <rajatxjain@gmail.com>,
 Prashant Malani <pmalani@google.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Aaron Durbin <adurbin@google.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Bernie Keany <bernie.keany@intel.com>, Duncan Laurie <dlaurie@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 Oliver O'Halloran <oohall@gmail.com>, Benson Leung <bleung@google.com>,
 David Woodhouse <dwmw2@infradead.org>, Alex Levin <levinale@google.com>
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
From: Rajat Jain via iommu <iommu@lists.linux-foundation.org>
Reply-To: Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGVsbG8sCgpPbiBGcmksIEp1bCAxMCwgMjAyMCBhdCAyOjI5IFBNIFJhaiwgQXNob2sgPGFzaG9r
LnJhakBpbnRlbC5jb20+IHdyb3RlOgo+Cj4gSGkgQmpvcm4KPgo+Cj4gT24gRnJpLCBKdWwgMTAs
IDIwMjAgYXQgMDM6Mjk6MjJQTSAtMDUwMCwgQmpvcm4gSGVsZ2FhcyB3cm90ZToKPiA+IE9uIFR1
ZSwgSnVsIDA3LCAyMDIwIGF0IDAzOjQ2OjA0UE0gLTA3MDAsIFJhamF0IEphaW4gd3JvdGU6Cj4g
PiA+IFdoZW4gZW5hYmxpbmcgQUNTLCBlbmFibGUgdHJhbnNsYXRpb24gYmxvY2tpbmcgZm9yIGV4
dGVybmFsIGZhY2luZyBwb3J0cwo+ID4gPiBhbmQgdW50cnVzdGVkIGRldmljZXMuCj4gPiA+Cj4g
PiA+IFNpZ25lZC1vZmYtYnk6IFJhamF0IEphaW4gPHJhamF0amFAZ29vZ2xlLmNvbT4KPiA+ID4g
LS0tCj4gPiA+IHY0OiBBZGQgYnJhY2VzIHRvIGF2b2lkIHdhcm5pbmcgZnJvbSBrZXJuZWwgcm9i
b3QKPiA+ID4gICAgIHByaW50IHdhcm5pbmcgZm9yIG9ubHkgZXh0ZXJuYWwtZmFjaW5nIGRldmlj
ZXMuCj4gPiA+IHYzOiBwcmludCB3YXJuaW5nIGlmIEFDU19UQiBub3Qgc3VwcG9ydGVkIG9uIGV4
dGVybmFsLWZhY2luZy91bnRydXN0ZWQgcG9ydHMuCj4gPiA+ICAgICBNaW5vciBjb2RlIGNvbW1l
bnRzIGZpeGVzLgo+ID4gPiB2MjogQ29tbWl0IGxvZyBjaGFuZ2UKPiA+ID4KPiA+ID4gIGRyaXZl
cnMvcGNpL3BjaS5jICAgIHwgIDggKysrKysrKysKPiA+ID4gIGRyaXZlcnMvcGNpL3F1aXJrcy5j
IHwgMTUgKysrKysrKysrKysrKysrCj4gPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDIzIGluc2VydGlv
bnMoKykKPiA+ID4KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3BjaS5jIGIvZHJpdmVy
cy9wY2kvcGNpLmMKPiA+ID4gaW5kZXggNzNhODYyNzgyMjE0MC4uYTVhNmJlYTdhZjdjZSAxMDA2
NDQKPiA+ID4gLS0tIGEvZHJpdmVycy9wY2kvcGNpLmMKPiA+ID4gKysrIGIvZHJpdmVycy9wY2kv
cGNpLmMKPiA+ID4gQEAgLTg3Niw2ICs4NzYsMTQgQEAgc3RhdGljIHZvaWQgcGNpX3N0ZF9lbmFi
bGVfYWNzKHN0cnVjdCBwY2lfZGV2ICpkZXYpCj4gPiA+ICAgICAvKiBVcHN0cmVhbSBGb3J3YXJk
aW5nICovCj4gPiA+ICAgICBjdHJsIHw9IChjYXAgJiBQQ0lfQUNTX1VGKTsKPiA+ID4KPiA+ID4g
KyAgIC8qIEVuYWJsZSBUcmFuc2xhdGlvbiBCbG9ja2luZyBmb3IgZXh0ZXJuYWwgZGV2aWNlcyAq
Lwo+ID4gPiArICAgaWYgKGRldi0+ZXh0ZXJuYWxfZmFjaW5nIHx8IGRldi0+dW50cnVzdGVkKSB7
Cj4gPiA+ICsgICAgICAgICAgIGlmIChjYXAgJiBQQ0lfQUNTX1RCKQo+ID4gPiArICAgICAgICAg
ICAgICAgICAgIGN0cmwgfD0gUENJX0FDU19UQjsKPiA+ID4gKyAgICAgICAgICAgZWxzZSBpZiAo
ZGV2LT5leHRlcm5hbF9mYWNpbmcpCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgcGNpX3dhcm4o
ZGV2LCAiQUNTOiBObyBUcmFuc2xhdGlvbiBCbG9ja2luZyBvbiBleHRlcm5hbC1mYWNpbmcgZGV2
XG4iKTsKPiA+ID4gKyAgIH0KPiA+Cj4gPiBJSVVDLCB0aGlzIG1lYW5zIHRoYXQgZXh0ZXJuYWwg
ZGV2aWNlcyBjYW4gKm5ldmVyKiB1c2UgQVRTCj4gYW5kIGNhbgo+ID4gbmV2ZXIgY2FjaGUgdHJh
bnNsYXRpb25zLgoKWWVzLCBidXQgaXQgYWxyZWFkeSBleGlzdHMgdG9kYXkgKGFuZCB0aGlzIHBh
dGNoIGRvZXNuJ3QgY2hhbmdlIHRoYXQpOgo1MjEzNzY3NDFiMmMyICJQQ0kvQVRTOiBPbmx5IGVu
YWJsZSBBVFMgZm9yIHRydXN0ZWQgZGV2aWNlcyIKCklNSE8gYW55IGV4dGVybmFsIGRldmljZSB0
cnlpbmcgdG8gc2VuZCBBVFMgdHJhZmZpYyBkZXNwaXRlIGhhdmluZyBBVFMKZGlzYWJsZWQgc2hv
dWxkIGNvdW50IGFzIGEgYmFkIGludGVudC4gQW5kIHRoaXMgcGF0Y2ggaXMgdHJ5aW5nIHRvCnBs
dWcgdGhhdCBsb29waG9sZSwgYnkgYmxvY2tpbmcgdGhlIEFUIHRyYWZmaWMgZnJvbSBkZXZpY2Vz
IHRoYXQgd2UgZG8Kbm90IGV4cGVjdCB0byBzZWUgQVQgZnJvbSBhbnl3YXkuCgpEbyB5b3Ugc2Vl
IGFueSBjYXNlIHdoZXJlIHRoaXMgaXMgbm90IHRydWU/Cgo+ICBBbmQgKEkgZ3Vlc3MsIEknbSBu
b3QgYW4gZXhwZXJ0KSBpdCBjYW4KPiA+IGFsc28gbmV2ZXIgdXNlIHRoZSBQYWdlIFJlcXVlc3Qg
U2VydmljZXM/Cj4KPiBZZXAsIHNvdW5kcyBsaWtlIGl0LgoKWWVzLCBmcm9tIHNwZWMgIkFkZHJl
c3MgVHJhbnNsYXRpb24gU2VydmljZXMiIFJldiAxLjE6CiIuLi5hIGRldmljZSB0aGF0IHN1cHBv
cnRzIEFUUyBuZWVkIG5vdCBzdXBwb3J0IFBSSSwgYnV0IFBSSSBpcwpkZXBlbmRlbnQgb24gQVRT
4oCZcyBjYXBhYmlsaXRpZXMuIgooU28gbm8gQVRTID0gTm8gUFJJKS4KCj4KPiA+Cj4gPiBJcyB0
aGlzIHdoYXQgd2Ugd2FudD8gIERvIHdlIGhhdmUgYW55IGlkZWEgaG93IG1hbnkgZXh0ZXJuYWwg
ZGV2aWNlcwo+ID4gdGhpcyB3aWxsIGFmZmVjdCBvciBob3cgbXVjaCBvZiBhIHBlcmZvcm1hbmNl
IGltcGFjdCB0aGV5IHdpbGwgc2VlPwo+ID4KPiA+IERvIHdlIG5lZWQgc29tZSBraW5kIG9mIG92
ZXJyaWRlIG9yIG1lY2hhbmlzbSB0byBhdXRoZW50aWNhdGUgY2VydGFpbgo+ID4gZGV2aWNlcyBz
byB0aGV5IGNhbiB1c2UgQVRTIGFuZCBQUkk/Cj4KPiBTb3VuZHMgbGlrZSB3ZSB3b3VsZCBuZWVk
IHNvbWUgZm9ybSBvZiBhbiBhbGxvdy1saXN0IHRvIHN0YXJ0IHdpdGggc28gd2UKPiBjYW4gaGF2
ZSBzb21ldGhpbmcgaW4gdGhlIGludGVyaW0uCgpJIGFzc3VtZSB3aGF0IGlzIGJlaW5nIHJlZmVy
cmVkIHRvLCBpcyBhbiBlc2NhcGUgaGF0Y2ggdG8gZW5hYmxlIEFUUwpvbiBjZXJ0YWluIGdpdmVu
ICJleHRlcm5hbC1mYWNpbmciIHBvcnRzIChhbmQgZGV2aWNlcyBkb3duc3RyZWFtIG9uCnRoYXQg
cG9ydCkuIERvIHdlIHJlYWxseSB0aGluayBhICpwZXItcG9ydCogY29udHJvbCBmb3IgQVRTIG1h
eSBiZQpuZWVkZWQ/IEkgY2FuIGFkZCBpZiB0aGVyZSBpcyBjb25zZW5zdXMgYWJvdXQgdGhpcy4K
Cj4KPiBJIHN1cHBvc2UgYSBmdXR1cmUgcGxhdGZvcm0gbWlnaHQgaGF2ZSBhIGZhY2lsdHkgdG8g
ZW5zdXJlIEFUUyBpcyBzZWN1cmUgYW5kCj4gYXV0aGVudGljYXRlZCB3ZSBjb3VsZCBlbmFibGUg
Zm9yIGFsbCBvZiBkZXZpY2VzIGluIHRoZSBzeXN0ZW0sIGluIGFkZGl0aW9uCj4gdG8gUENJIENN
QS9JREUuCj4KPiBJIHRoaW5rIGhhdmluZyBhIGdsb2JhbCBvdmVycmlkZSB0byBlbmFibGUgYWxs
IGRldmljZXMgc28gcGxhdGZvcm0gY2FuCj4gc3dpdGNoIHRvIGN1cnJlbnQgYmVoYXZpb3IsIG9y
IG1heWJlIHZpYSBhIGNtZGxpbmUgc3dpdGNoLi4gYXMgbXVjaCBhcyB3ZQo+IGhhdmUgYSBiaWxs
aW9uIG9mIHRob3NlLCBpdCBzdGlsbCBnaXZlcyBhbiBvcHRpb24gaW4gY2FzZSBzb21lb25lIG5l
ZWRzIGl0LgoKQ3VycmVudGx5OgoKcGNpLm5vYXRzID0+IE5vIEFUUyBvbiBhbGwgUENJIGRldmlj
ZXMuCihBYnNlbnNlIG9mIHBjaS5ub2F0cyk6IEFUUyBvbiBhbGwgUENJIGRldmljZXMsIEVYQ0VQ
VCBleHRlcm5hbCBkZXZpY2VzLgoKSSBjYW4gbG9vayB0byBhZGQgYW5vdGhlciBwYXJhbWV0ZXIg
dGhhdCBpcyBzeW5vbnltb3VzIHRvCiJ0cnVzdC1leHRlcm5hbC1wY2ktZGV2aWNlcyIgdGhhdCBj
YW4ga2VlcCBBVFMgZW5hYmxlZCBvbiBleHRlcm5hbApwb3J0cyBhcyB3ZWxsLiBJIHRoaW5rIHRo
aXMgaXMgYmV0dGVyIHRoYW4gYW4gYWxsb3ctbGlzdCBvZiBvbmx5CmNlcnRhaW4gcG9ydHMsIGJl
Y2F1c2UgbW9zdCBsaWtlbHkgYW4gYWRtaW4gd2lsbCB0cnVzdCBhbGwgaXRzCmV4dGVybmFsIHBv
cnRzLCBvciBub3QuIEFsc28sIHdlIGNhbiBhZGQgdGhpcyBnbG9iYWwgb3ZlcnJpZGUgYW5kIG1h
eQpiZSBhZGQgYSBtb3JlIGdyYW51bGFyIGNvbnRyb2wgbGF0ZXIsIGlmIGFuZCB3aGVuIHJlYWxs
eSBuZWVkZWQuCgpUaGFua3MsCgpSYWphdAoKPgo+Cj4KPiA+Cj4gPiBJZiB3ZSBkbyBkZWNpZGUg
dGhpcyBpcyB0aGUgcmlnaHQgdGhpbmcgdG8gZG8sIEkgdGhpbmsgd2UgbmVlZCB0bwo+ID4gZXhw
YW5kIHRoZSBjb21taXQgbG9nIGEgYml0LCBiZWNhdXNlIHRoaXMgaXMgcG90ZW50aWFsbHkgYSBz
aWduaWZpY2FudAo+ID4gdXNlci12aXNpYmxlIGNoYW5nZS4KPiA+Cj4gPiA+ICAgICBwY2lfd3Jp
dGVfY29uZmlnX3dvcmQoZGV2LCBwb3MgKyBQQ0lfQUNTX0NUUkwsIGN0cmwpOwo+ID4gPiAgfQo+
ID4gPgo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvcXVpcmtzLmMgYi9kcml2ZXJzL3Bj
aS9xdWlya3MuYwo+ID4gPiBpbmRleCBiMzQxNjI4ZTQ3NTI3Li5iYjIyYjQ2YzFkNzE5IDEwMDY0
NAo+ID4gPiAtLS0gYS9kcml2ZXJzL3BjaS9xdWlya3MuYwo+ID4gPiArKysgYi9kcml2ZXJzL3Bj
aS9xdWlya3MuYwo+ID4gPiBAQCAtNDkzNCw2ICs0OTM0LDEzIEBAIHN0YXRpYyB2b2lkIHBjaV9x
dWlya19lbmFibGVfaW50ZWxfcnBfbXBjX2FjcyhzdHJ1Y3QgcGNpX2RldiAqZGV2KQo+ID4gPiAg
ICAgfQo+ID4gPiAgfQo+ID4gPgo+ID4gPiArLyoKPiA+ID4gKyAqIEN1cnJlbnRseSB0aGlzIHF1
aXJrIGRvZXMgdGhlIGVxdWl2YWxlbnQgb2YKPiA+ID4gKyAqIFBDSV9BQ1NfU1YgfCBQQ0lfQUNT
X1JSIHwgUENJX0FDU19DUiB8IFBDSV9BQ1NfVUYKPiA+ID4gKyAqCj4gPiA+ICsgKiBUT0RPOiBU
aGlzIHF1aXJrIGFsc28gbmVlZHMgdG8gZG8gZXF1aXZhbGVudCBvZiBQQ0lfQUNTX1RCLAo+ID4g
PiArICogaWYgZGV2LT5leHRlcm5hbF9mYWNpbmcgfHwgZGV2LT51bnRydXN0ZWQKPiA+ID4gKyAq
Lwo+ID4gPiAgc3RhdGljIGludCBwY2lfcXVpcmtfZW5hYmxlX2ludGVsX3BjaF9hY3Moc3RydWN0
IHBjaV9kZXYgKmRldikKPiA+ID4gIHsKPiA+ID4gICAgIGlmICghcGNpX3F1aXJrX2ludGVsX3Bj
aF9hY3NfbWF0Y2goZGV2KSkKPiA+ID4gQEAgLTQ5NzMsNiArNDk4MCwxNCBAQCBzdGF0aWMgaW50
IHBjaV9xdWlya19lbmFibGVfaW50ZWxfc3B0X3BjaF9hY3Moc3RydWN0IHBjaV9kZXYgKmRldikK
PiA+ID4gICAgIGN0cmwgfD0gKGNhcCAmIFBDSV9BQ1NfQ1IpOwo+ID4gPiAgICAgY3RybCB8PSAo
Y2FwICYgUENJX0FDU19VRik7Cj4gPiA+Cj4gPiA+ICsgICAvKiBFbmFibGUgVHJhbnNsYXRpb24g
QmxvY2tpbmcgZm9yIGV4dGVybmFsIGRldmljZXMgKi8KPiA+ID4gKyAgIGlmIChkZXYtPmV4dGVy
bmFsX2ZhY2luZyB8fCBkZXYtPnVudHJ1c3RlZCkgewo+ID4gPiArICAgICAgICAgICBpZiAoY2Fw
ICYgUENJX0FDU19UQikKPiA+ID4gKyAgICAgICAgICAgICAgICAgICBjdHJsIHw9IFBDSV9BQ1Nf
VEI7Cj4gPiA+ICsgICAgICAgICAgIGVsc2UgaWYgKGRldi0+ZXh0ZXJuYWxfZmFjaW5nKQo+ID4g
PiArICAgICAgICAgICAgICAgICAgIHBjaV93YXJuKGRldiwgIkFDUzogTm8gVHJhbnNsYXRpb24g
QmxvY2tpbmcgb24gZXh0ZXJuYWwtZmFjaW5nIGRldlxuIik7Cj4gPiA+ICsgICB9Cj4gPiA+ICsK
PiA+ID4gICAgIHBjaV93cml0ZV9jb25maWdfZHdvcmQoZGV2LCBwb3MgKyBJTlRFTF9TUFRfQUNT
X0NUUkwsIGN0cmwpOwo+ID4gPgo+ID4gPiAgICAgcGNpX2luZm8oZGV2LCAiSW50ZWwgU1BUIFBD
SCByb290IHBvcnQgQUNTIHdvcmthcm91bmQgZW5hYmxlZFxuIik7Cj4gPiA+IC0tCj4gPiA+IDIu
MjcuMC4yMTIuZ2U4YmExY2M5ODgtZ29vZwo+ID4gPgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vaW9tbXU=
