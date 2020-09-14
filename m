Return-Path: <SRS0=C6HT=CX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60001C433E2
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 13:31:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88912206DC
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 13:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZaYn6MHu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88912206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id EFADB20767;
	Mon, 14 Sep 2020 13:31:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZGtd3-bqlH9Z; Mon, 14 Sep 2020 13:31:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id DC65520017;
	Mon, 14 Sep 2020 13:31:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB6C5C088B;
	Mon, 14 Sep 2020 13:31:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58C5BC0051
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 13:31:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 54E4985FC7
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 13:31:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Yqx2aj2On4Vl for <iommu@lists.linux-foundation.org>;
 Mon, 14 Sep 2020 13:31:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
 [209.85.208.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 597E285FC1
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 13:31:34 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id n13so17558856edo.10
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 06:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=8k1Ul9N6yxgiiVKnzmBtKrszd5xnz8Eh0Whyo1OuGQw=;
 b=ZaYn6MHuVYxyazEuEK6bRn+JWGOCZnlZjUO5qd3r42wZ+5WftoUJfEYnq5oXnCp7Zq
 hwakLnWXuKuISlNW+JT/dXHJ5iiHs+3a6drr77OQavfslAhOqxGRps3UtwLdjp7EQ2Gs
 8j+U7USi7pnztVxoNG+3bBC5Tyh7wcW6PXJxd53qPGz+AaxXKz4uAsJvxp/Vv9ldrdJf
 M4bs1sKk2OApbQyjDJBnosMpES/5MAm+yq+0vpx000AZWZkjXndUf0Y0vIC9nOw7iJ1J
 TOzcDNKkROrgXP/tmDuj0sE0AYpJ0EUpkz/wP+T7RDt1CmFqznE7uQLhMotJEWZpEJJL
 FIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=8k1Ul9N6yxgiiVKnzmBtKrszd5xnz8Eh0Whyo1OuGQw=;
 b=MRNr0IGMhOU/hOynnVB17pi1yhUhoiF1YNSqhcPiEdpvVIXungFt/Y8fsBdbOEYzdM
 EfuOffbpQq1mIspab9G+icUXwrOTQqSzuAYsQxzBidXy/PgkvODcGz6P2BFDL7vvrZXw
 Owi7stl10HAeswuWrVLxKuB8Kwui9QCjM17HaUOEpoPV3okbQy9dl0OPAHXXaTYosotp
 ZC3bdVBU1s4AsQ4t0EXtThBN6bba78UeyM1/XzJw0PkrlWk9smBH9sDcKvPd2h/uG8Dt
 s1J0dhIctfAR61XB/slI0niQqlL5wtEuHdxsGJtxFW3HvaF3d4CqdUSWuljzjmqOlVuU
 YD2Q==
X-Gm-Message-State: AOAM530Zp6lBN0ivI4B0R8CVzqcf3CowotRFgiXIoOskL3gCePeMLsKB
 WMlLnP6jJKAIuI7H6CH91SLPnw==
X-Google-Smtp-Source: ABdhPJyh8no06byky152jPguPl40S+TIzGDvt+3B4/OJzfXz8HbRjYVFN+Uag8ph0L05TMwdV+KXWA==
X-Received: by 2002:aa7:d144:: with SMTP id r4mr17325506edo.303.1600090292547; 
 Mon, 14 Sep 2020 06:31:32 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id u13sm7740891ejn.82.2020.09.14.06.31.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 06:31:31 -0700 (PDT)
Date: Mon, 14 Sep 2020 15:31:13 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v7 00/16] vfio: expose virtual Shared Virtual Addressing
 to VMs
Message-ID: <20200914133113.GB1375106@myrica>
References: <1599734733-6431-1-git-send-email-yi.l.liu@intel.com>
 <411c81c0-f13c-37cc-6c26-cafb42b46b15@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <411c81c0-f13c-37cc-6c26-cafb42b46b15@redhat.com>
Cc: kevin.tian@intel.com, ashok.raj@intel.com, kvm@vger.kernel.org,
 iommu@lists.linux-foundation.org, stefanha@gmail.com,
 "Michael S. Tsirkin" <mst@redhat.com>, yi.y.sun@intel.com,
 alex.williamson@redhat.com, Jason Gunthorpe <jgg@nvidia.com>, hao.wu@intel.com,
 jun.j.tian@intel.com
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

T24gTW9uLCBTZXAgMTQsIDIwMjAgYXQgMTI6MjA6MTBQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIwLzkvMTAg5LiL5Y2INjo0NSwgTGl1IFlpIEwgd3JvdGU6Cj4gPiBTaGFy
ZWQgVmlydHVhbCBBZGRyZXNzaW5nIChTVkEpLCBhLmsuYSwgU2hhcmVkIFZpcnR1YWwgTWVtb3J5
IChTVk0pIG9uCj4gPiBJbnRlbCBwbGF0Zm9ybXMgYWxsb3dzIGFkZHJlc3Mgc3BhY2Ugc2hhcmlu
ZyBiZXR3ZWVuIGRldmljZSBETUEgYW5kCj4gPiBhcHBsaWNhdGlvbnMuIFNWQSBjYW4gcmVkdWNl
IHByb2dyYW1taW5nIGNvbXBsZXhpdHkgYW5kIGVuaGFuY2Ugc2VjdXJpdHkuCj4gPiAKPiA+IFRo
aXMgVkZJTyBzZXJpZXMgaXMgaW50ZW5kZWQgdG8gZXhwb3NlIFNWQSB1c2FnZSB0byBWTXMuIGku
ZS4gU2hhcmluZwo+ID4gZ3Vlc3QgYXBwbGljYXRpb24gYWRkcmVzcyBzcGFjZSB3aXRoIHBhc3N0
aHJ1IGRldmljZXMuIFRoaXMgaXMgY2FsbGVkCj4gPiB2U1ZBIGluIHRoaXMgc2VyaWVzLiBUaGUg
d2hvbGUgdlNWQSBlbmFibGluZyByZXF1aXJlcyBRRU1VL1ZGSU8vSU9NTVUKPiA+IGNoYW5nZXMu
IEZvciBJT01NVSBhbmQgUUVNVSBjaGFuZ2VzLCB0aGV5IGFyZSBpbiBzZXBhcmF0ZSBzZXJpZXMg
KGxpc3RlZAo+ID4gaW4gdGhlICJSZWxhdGVkIHNlcmllcyIpLgo+ID4gCj4gPiBUaGUgaGlnaC1s
ZXZlbCBhcmNoaXRlY3R1cmUgZm9yIFNWQSB2aXJ0dWFsaXphdGlvbiBpcyBhcyBiZWxvdywgdGhl
IGtleQo+ID4gZGVzaWduIG9mIHZTVkEgc3VwcG9ydCBpcyB0byB1dGlsaXplIHRoZSBkdWFsLXN0
YWdlIElPTU1VIHRyYW5zbGF0aW9uICgKPiA+IGFsc28ga25vd24gYXMgSU9NTVUgbmVzdGluZyB0
cmFuc2xhdGlvbikgY2FwYWJpbGl0eSBpbiBob3N0IElPTU1VLgo+ID4gCj4gPiAKPiA+ICAgICAg
Li0tLS0tLS0tLS0tLS0uICAuLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLgo+ID4gICAgICB8
ICAgdklPTU1VICAgIHwgIHwgR3Vlc3QgcHJvY2VzcyBDUjMsIEZMIG9ubHl8Cj4gPiAgICAgIHwg
ICAgICAgICAgICAgfCAgJy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLScKPiA+ICAgICAgLi0t
LS0tLS0tLS0tLS0tLS0vCj4gPiAgICAgIHwgUEFTSUQgRW50cnkgfC0tLSBQQVNJRCBjYWNoZSBm
bHVzaCAtCj4gPiAgICAgICctLS0tLS0tLS0tLS0tJyAgICAgICAgICAgICAgICAgICAgICAgfAo+
ID4gICAgICB8ICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgIFYKPiA+ICAgICAg
fCAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgIENSMyBpbiBHUEEKPiA+ICAgICAgJy0tLS0t
LS0tLS0tLS0nCj4gPiBHdWVzdAo+ID4gLS0tLS0tfCBTaGFkb3cgfC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tfC0tLS0tLS0tCj4gPiAgICAgICAgdiAgICAgICAgdiAgICAgICAgICAgICAgICAg
ICAgICAgICAgdgo+ID4gSG9zdAo+ID4gICAgICAuLS0tLS0tLS0tLS0tLS4gIC4tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLgo+ID4gICAgICB8ICAgcElPTU1VICAgIHwgIHwgQmluZCBGTCBmb3IgR1ZB
LUdQQSAgfAo+ID4gICAgICB8ICAgICAgICAgICAgIHwgICctLS0tLS0tLS0tLS0tLS0tLS0tLS0t
Jwo+ID4gICAgICAuLS0tLS0tLS0tLS0tLS0tLS8gIHwKPiA+ICAgICAgfCBQQVNJRCBFbnRyeSB8
ICAgICBWIChOZXN0ZWQgeGxhdGUpCj4gPiAgICAgICctLS0tLS0tLS0tLS0tLS0tXC4tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0uCj4gPiAgICAgIHwgICAgICAgICAgICAgfHxTTCBmb3Ig
R1BBLUhQQSwgZGVmYXVsdCBkb21haW58Cj4gPiAgICAgIHwgICAgICAgICAgICAgfCAgICctLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0nCj4gPiAgICAgICctLS0tLS0tLS0tLS0tJwo+ID4g
V2hlcmU6Cj4gPiAgIC0gRkwgPSBGaXJzdCBsZXZlbC9zdGFnZSBvbmUgcGFnZSB0YWJsZXMKPiA+
ICAgLSBTTCA9IFNlY29uZCBsZXZlbC9zdGFnZSB0d28gcGFnZSB0YWJsZXMKPiA+IAo+ID4gUGF0
Y2ggT3ZlcnZpZXc6Cj4gPiAgIDEuIHJlcG9ydHMgSU9NTVUgbmVzdGluZyBpbmZvIHRvIHVzZXJz
cGFjZSAoIHBhdGNoIDAwMDEsIDAwMDIsIDAwMDMsIDAwMTUgLCAwMDE2KQo+ID4gICAyLiB2Zmlv
IHN1cHBvcnQgZm9yIFBBU0lEIGFsbG9jYXRpb24gYW5kIGZyZWUgZm9yIFZNcyAocGF0Y2ggMDAw
NCwgMDAwNSwgMDAwNykKPiA+ICAgMy4gYSBmaXggdG8gYSByZXZpc2l0IGluIGludGVsIGlvbW11
IGRyaXZlciAocGF0Y2ggMDAwNikKPiA+ICAgNC4gdmZpbyBzdXBwb3J0IGZvciBiaW5kaW5nIGd1
ZXN0IHBhZ2UgdGFibGUgdG8gaG9zdCAocGF0Y2ggMDAwOCwgMDAwOSwgMDAxMCkKPiA+ICAgNS4g
dmZpbyBzdXBwb3J0IGZvciBJT01NVSBjYWNoZSBpbnZhbGlkYXRpb24gZnJvbSBWTXMgKHBhdGNo
IDAwMTEpCj4gPiAgIDYuIHZmaW8gc3VwcG9ydCBmb3IgdlNWQSB1c2FnZSBvbiBJT01NVS1iYWNr
ZWQgbWRldnMgKHBhdGNoIDAwMTIpCj4gPiAgIDcuIGV4cG9zZSBQQVNJRCBjYXBhYmlsaXR5IHRv
IFZNIChwYXRjaCAwMDEzKQo+ID4gICA4LiBhZGQgZG9jIGZvciBWRklPIGR1YWwgc3RhZ2UgY29u
dHJvbCAocGF0Y2ggMDAxNCkKPiAKPiAKPiBJZiBpdCdzIHBvc3NpYmxlLCBJIHdvdWxkIHN1Z2dl
c3QgYSBnZW5lcmljIHVBUEkgaW5zdGVhZCBvZiBhIFZGSU8gc3BlY2lmaWMKPiBvbmUuCgpBIGxh
cmdlIHBhcnQgb2YgdGhpcyB3b3JrIGlzIGFscmVhZHkgZ2VuZXJpYyB1QVBJLCBpbgppbmNsdWRl
L3VhcGkvbGludXgvaW9tbXUuaC4gVGhpcyBwYXRjaHNldCBjb25uZWN0cyB0aGF0IGdlbmVyaWMg
aW50ZXJmYWNlCnRvIHRoZSBwcmUtZXhpc3RpbmcgVkZJTyB1QVBJIHRoYXQgZGVhbHMgd2l0aCBJ
T01NVSBtYXBwaW5ncyBvZiBhbgphc3NpZ25lZCBkZXZpY2UuIEJ1dCB0aGUgYnVsayBvZiB0aGUg
d29yayBpcyBkb25lIGJ5IHRoZSBJT01NVSBzdWJzeXN0ZW0sCmFuZCBpcyBhdmFpbGFibGUgdG8g
YWxsIGRldmljZSBkcml2ZXJzLgoKPiBKYXNvbiBzdWdnZXN0IHNvbWV0aGluZyBsaWtlIC9kZXYv
c3ZhLiBUaGVyZSB3aWxsIGJlIGEgbG90IG9mIG90aGVyCj4gc3Vic3lzdGVtcyB0aGF0IGNvdWxk
IGJlbmVmaXQgZnJvbSB0aGlzIChlLmcgdkRQQSkuCgpEbyB5b3UgaGF2ZSBhIG1vcmUgcHJlY2lz
ZSBpZGVhIG9mIHRoZSBpbnRlcmZhY2UgL2Rldi9zdmEgd291bGQgcHJvdmlkZSwKaG93IGl0IHdv
dWxkIGludGVyYWN0IHdpdGggVkZJTyBhbmQgb3RoZXJzPyAgdkRQQSBjb3VsZCB0cmFuc3BvcnQg
dGhlCmdlbmVyaWMgaW9tbXUuaCBzdHJ1Y3R1cmVzIHZpYSBpdHMgb3duIHVBUEksIGFuZCBjYWxs
IHRoZSBJT01NVSBBUEkKZGlyZWN0bHkgd2l0aG91dCBnb2luZyB0aHJvdWdoIGFuIGludGVybWVk
aWF0ZSAvZGV2L3N2YSBoYW5kbGUuCgpUaGFua3MsCkplYW4KCj4gSGF2ZSB5b3UgZXZlciBjb25z
aWRlcmVkIHRoaXMgYXBwcm9hY2g/Cj4gCj4gVGhhbmtzCj4gCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby9pb21tdQ==
