Return-Path: <SRS0=GPww=FV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8D9C4361B
	for <iommu@archiver.kernel.org>; Thu, 17 Dec 2020 14:55:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6062A233E2
	for <iommu@archiver.kernel.org>; Thu, 17 Dec 2020 14:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6062A233E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 09082878C2;
	Thu, 17 Dec 2020 14:55:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 19mtGQsvlU0f; Thu, 17 Dec 2020 14:55:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2A18B878A2;
	Thu, 17 Dec 2020 14:55:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0520BC0893;
	Thu, 17 Dec 2020 14:55:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59E62C013B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Dec 2020 14:55:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 54AF8879F9
 for <iommu@lists.linux-foundation.org>; Thu, 17 Dec 2020 14:55:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id imUOijUpynSZ for <iommu@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 14:55:04 +0000 (UTC)
X-Greylist: delayed 00:06:40 by SQLgrey-1.7.6
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0A507878B0
 for <iommu@lists.linux-foundation.org>; Thu, 17 Dec 2020 14:55:04 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id g20so38316546ejb.1
 for <iommu@lists.linux-foundation.org>; Thu, 17 Dec 2020 06:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=zyeRkT/Tiedmv3c7h0oJAQ3zimAR+ezz/jtOsHPbNqA=;
 b=w4MxlMApj68HrZJ+wPYGW1aygTpQog6dpy+8wwNWjQ5N7ENAWbs7X8kFfhl72slqoe
 +SvC0z+j7raXt3Yx87ZB2BZ2kPZ36IX37QyYqwXhx7X5KVkHGrCb6idfAVuxhb57sBWc
 XnOckrdm7IVIkUfdSR9Y98N9SlpoLfrwIMtWtuhMvSQ7wNuC5bS0cVXdCke46qOHduNi
 XT7UJ6X/SV0M2Fq8CKTfnbi/9qM5pKu831NmrI3DhbGNxCqa9MWJIR3YxKBizaw/VHN9
 7pVnK9e09KhUzppMk8GO5JbIADayxR8PTf8TJpPpDrYTYVI4gbDRcfmeHRLEB1NduxTW
 y7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zyeRkT/Tiedmv3c7h0oJAQ3zimAR+ezz/jtOsHPbNqA=;
 b=sqK33c+4M7lUTdXZcl7QVNpVo/Rso8cD1uyH3K0cX5VLZQC4zPLG2nudWdzNS3ES3c
 Tch5V2fmnRyZy6PxuwatONTatE4KhqrbW/woogDzr6TwADgM+X1X5fNt0ONL/G48OM0F
 wiIlVmM0ovslLXNE3jAbWQ2zvm4gLY2Z9saGI5E+Hc1U/7nGD3VgL5RwrCaYSch87O+Q
 agxwH1DfvMB5mABH6fmqBAwbUTblYkspN7EcQUvZWZgIPrXHB58N96iAit/LNJMbGf8q
 j2O3w99E0V1tM3tLTpAZGI3RB2V907PzpjYi9m6C8eDc5tPJxyeTgAUIEEErDjnM5/2Y
 clkw==
X-Gm-Message-State: AOAM531lXo/75YH9aFC0mEHULvIydRKiDD7a55HrbJ1mmFvn31R+O28f
 0IDcFCqyGbOk3l5b+wkYvdiRrAM4+AxQ6i6DguN0j6apD6cscg==
X-Google-Smtp-Source: ABdhPJxglGkzGeLeHFoSoaR7wzOrrK1YMTmSAasoGs2HmfNFtnygGKC+eh76rdZcmH70kSVieSYhlaegaFGMX7I6qc4=
X-Received: by 2002:a17:906:17d0:: with SMTP id
 u16mr35171465eje.452.1608216503214; 
 Thu, 17 Dec 2020 06:48:23 -0800 (PST)
MIME-Version: 1.0
References: <20201119121150.3316-1-shameerali.kolothum.thodi@huawei.com>
 <e9837ba5-deeb-c64c-2261-d0ab82eebfac@arm.com>
 <67cb563d19114f609348dc9f8b4307e9@huawei.com>
 <8f92d0b3-360b-5d47-10a7-83d09e75d993@arm.com>
 <6dcf51b2-cad5-d377-a34c-4e64fd3acbb8@arm.com>
 <3d0a3ae81241474f91748dde0cdd4d39@huawei.com>
In-Reply-To: <3d0a3ae81241474f91748dde0cdd4d39@huawei.com>
From: Jon Nettleton <jon@solid-run.com>
Date: Thu, 17 Dec 2020 15:47:45 +0100
Message-ID: <CABdtJHvoWCE4Zd5gTf4wbAKtriWRFx6y1CSH0taVxMmEf7tweg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/8] ACPI/IORT: Support for IORT RMR node
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Linuxarm <linuxarm@huawei.com>, Steven Price <steven.price@arm.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 wanghuiqiang <wanghuiqiang@huawei.com>,
 "Guohanjun \(Hanjun Guo\)" <guohanjun@huawei.com>,
 "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
 Robin Murphy <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "devel@acpica.org" <devel@acpica.org>
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

T24gTW9uLCBEZWMgMTQsIDIwMjAgYXQgMzo0OCBQTSBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2Rp
CjxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+IHdyb3RlOgo+Cj4KPgo+ID4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPiA+IEZyb206IFN0ZXZlbiBQcmljZSBbbWFpbHRv
OnN0ZXZlbi5wcmljZUBhcm0uY29tXQo+ID4gU2VudDogMTQgRGVjZW1iZXIgMjAyMCAxMzo0Mwo+
ID4gVG86IFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5QGFybS5jb20+OyBTaGFtZWVyYWxpIEtv
bG90aHVtIFRob2RpCj4gPiA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPjsK
PiA+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtYWNwaUB2Z2Vy
Lmtlcm5lbC5vcmc7Cj4gPiBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZzsgZGV2ZWxA
YWNwaWNhLm9yZwo+ID4gQ2M6IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWkuY29tPjsgbG9yZW56
by5waWVyYWxpc2lAYXJtLmNvbTsKPiA+IGpvcm9AOGJ5dGVzLm9yZzsgd2FuZ2h1aXFpYW5nIDx3
YW5naHVpcWlhbmdAaHVhd2VpLmNvbT47IEd1b2hhbmp1bgo+ID4gKEhhbmp1biBHdW8pIDxndW9o
YW5qdW5AaHVhd2VpLmNvbT47IEpvbmF0aGFuIENhbWVyb24KPiA+IDxqb25hdGhhbi5jYW1lcm9u
QGh1YXdlaS5jb20+OyBTYW1pLk11amF3YXJAYXJtLmNvbQo+ID4gU3ViamVjdDogUmU6IFtSRkMg
UEFUQ0ggdjIgMC84XSBBQ1BJL0lPUlQ6IFN1cHBvcnQgZm9yIElPUlQgUk1SIG5vZGUKPiA+Cj4g
PiBPbiAxNC8xMi8yMDIwIDEyOjMzLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4gPiA+IE9uIDIwMjAt
MTItMTQgMTA6NTUsIFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkgd3JvdGU6Cj4gPiA+PiBIaSBT
dGV2ZSwKPiA+ID4+Cj4gPiA+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPiA+ID4+PiBG
cm9tOiBTdGV2ZW4gUHJpY2UgW21haWx0bzpzdGV2ZW4ucHJpY2VAYXJtLmNvbV0KPiA+ID4+PiBT
ZW50OiAxMCBEZWNlbWJlciAyMDIwIDEwOjI2Cj4gPiA+Pj4gVG86IFNoYW1lZXJhbGkgS29sb3Ro
dW0gVGhvZGkKPiA+IDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+Owo+ID4g
Pj4+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtYWNwaUB2Z2Vy
Lmtlcm5lbC5vcmc7Cj4gPiA+Pj4gaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IGRl
dmVsQGFjcGljYS5vcmcKPiA+ID4+PiBDYzogTGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+
OyBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOwo+ID4gPj4+IGpvcm9AOGJ5dGVzLm9yZzsgcm9i
aW4ubXVycGh5QGFybS5jb207IHdhbmdodWlxaWFuZwo+ID4gPj4+IDx3YW5naHVpcWlhbmdAaHVh
d2VpLmNvbT47IEd1b2hhbmp1biAoSGFuanVuIEd1bykKPiA+ID4+PiA8Z3VvaGFuanVuQGh1YXdl
aS5jb20+OyBKb25hdGhhbiBDYW1lcm9uCj4gPiA+Pj4gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2Vp
LmNvbT47IFNhbWkuTXVqYXdhckBhcm0uY29tCj4gPiA+Pj4gU3ViamVjdDogUmU6IFtSRkMgUEFU
Q0ggdjIgMC84XSBBQ1BJL0lPUlQ6IFN1cHBvcnQgZm9yIElPUlQgUk1SIG5vZGUKPiA+ID4+Pgo+
ID4gPj4+IE9uIDE5LzExLzIwMjAgMTI6MTEsIFNoYW1lZXIgS29sb3RodW0gd3JvdGU6Cj4gPiA+
Pj4+IFJGQyB2MSAtLT4gdjI6Cj4gPiA+Pj4+ICAgIC0gQWRkZWQgYSBnZW5lcmljIGludGVyZmFj
ZSBmb3IgSU9NTVUgZHJpdmVycyB0byByZXRyaWV2ZSBhbGwgdGhlCj4gPiA+Pj4+ICAgICAgUk1S
IGluZm8gYXNzb2NpYXRlZCB3aXRoIGEgZ2l2ZW4gSU9NTVUuCj4gPiA+Pj4+ICAgIC0gU01NVXYz
IGRyaXZlciBnZXRzIHRoZSBSTVIgbGlzdCBkdXJpbmcgcHJvYmUoKSBhbmQgaW5zdGFsbHMKPiA+
ID4+Pj4gICAgICBieXBhc3MgU1RFcyBmb3IgYWxsIHRoZSBTSURzIGluIHRoZSBSTVIgbGlzdC4g
VGhpcyBpcyB0byBrZWVwCj4gPiA+Pj4+ICAgICAgdGhlIG9uZ29pbmcgdHJhZmZpYyBhbGl2ZShp
ZiBhbnkpIGR1cmluZyBTTU1VdjMgcmVzZXQuIFRoaXMgaXMKPiA+ID4+Pj4gICAgICBiYXNlZCBv
biB0aGUgc3VnZ2VzdGlvbnMgcmVjZWl2ZWQgZm9yIHYxIHRvIHRha2UgY2FyZSBvZiB0aGUKPiA+
ID4+Pj4gICAgICBFRkkgZnJhbWVidWZmZXIgdXNlIGNhc2UuIE9ubHkgc2FuaXR5IHRlc3RlZCBm
b3Igbm93Lgo+ID4gPj4+Cj4gPiA+Pj4gSGkgU2hhbWVlciwKPiA+ID4+Pgo+ID4gPj4+IFNvcnJ5
IGZvciBub3QgbG9va2luZyBhdCB0aGlzIGJlZm9yZS4KPiA+ID4+Pgo+ID4gPj4+IERvIHlvdSBo
YXZlIGFueSBwbGFucyB0byBpbXBsZW1lbnQgc3VwcG9ydCBpbiB0aGUgU01NVXYyIGRyaXZlcj8g
VGhlCj4gPiA+Pj4gcGxhdGZvcm0gSSd2ZSBiZWVuIHRlc3RpbmcgdGhlIEVGSSBmcmFtZWJ1ZmZl
ciBzdXBwb3J0IG9uIGhhcyB0aGUKPiA+ID4+PiBkaXNwbGF5IGNvbnRyb2xsZXIgYmVoaW5kIFNN
TVV2Miwgc28gYXMgaXQgc3RhbmRzIHRoaXMgc2VyaWVzIGRvZXNuJ3QKPiA+ID4+PiB3b3JrLiBJ
IGRpZCBoYWNrIHNvbWV0aGluZyB1cCBmb3IgU01NVXYyIHNvIEkgd2FzIGFibGUgdG8gdGVzdCB0
aGUgZmlyc3QKPiA+ID4+PiA0IHBhdGNoZXMuCj4gPiA+Pgo+ID4gPj4gVGhhbmtzIGZvciB0YWtp
bmcgYSBsb29rLiBTdXJlLCBJIGNhbiBsb29rIGludG8gYWRkaW5nIHRoZSBzdXBwb3J0IGZvcgo+
ID4gPj4gU01NVXYyLgo+ID4KPiA+IEdyZWF0LCB0aGFua3MhCj4gPgo+ID4gPj4+Cj4gPiA+Pj4+
ICAgIC0gRHVyaW5nIHRoZSBwcm9iZS9hdHRhY2ggZGV2aWNlLCBTTU1VdjMgZHJpdmVyIHJlc2Vy
dmVzIGFueQo+ID4gPj4+PiAgICAgIFJNUiByZWdpb24gYXNzb2NpYXRlZCB3aXRoIHRoZSBkZXZp
Y2Ugc3VjaCB0aGF0IHRoZXJlIGlzIGEgdW5pdHkKPiA+ID4+Pj4gICAgICBtYXBwaW5nIGZvciB0
aGVtIGluIFNNTVUuCj4gPiA+Pj4KPiA+ID4+PiBGb3IgdGhlIEVGSSBmcmFtZWJ1ZmZlciB1c2Ug
Y2FzZSB0aGVyZSBpcyBubyBkZXZpY2UgdG8gYXR0YWNoIHNvIEkKPiA+ID4+PiBiZWxpZXZlIHdl
IGFyZSBsZWZ0IHdpdGgganVzdCB0aGUgc3RyZWFtIElEIGluIGJ5cGFzcyBtb2RlIC0gd2hpY2gg
aXMKPiA+ID4+PiBkZWZpbml0ZWx5IGFuIGltcHJvdmVtZW50ICh0aGUgZGlzcGxheSB3b3JrcyEp
Cj4gPiA+Pgo+ID4gPj4gQ29vbC4gVGhhdOKAmXMgZ29vZCB0byBrbm93Lgo+ID4gPj4KPiA+ID4+
ICAgYnV0IG5vdCBhY3R1YWxseSBhIHVuaXR5Cj4gPiA+Pj4gbWFwcGluZyBvZiB0aGUgUk1SIHJh
bmdlLiBJJ20gbm90IHN1cmUgd2hldGhlciBpdCdzIHdvcnRoIGZpeGluZyB0aGlzIG9yCj4gPiA+
Pj4gbm90LCBidXQgSSBqdXN0IHdhbnRlZCB0byBwb2ludCBvdXQgdGhlcmUncyBzdGlsbCBhIG5l
ZWQgZm9yIGEgZHJpdmVyCj4gPiA+Pj4gZm9yIHRoZSBkZXZpY2UgYmVmb3JlIHRoZSBieXBhc3Mg
bW9kZSBpcyByZXBsYWNlZCB3aXRoIHRoZSB1bml0eQo+ID4gPj4+IG1hcHBpbmcuCj4gPiA+Pgo+
ID4gPj4gSSBhbSBub3Qgc3VyZSBlaXRoZXIuIE15IGlkZWEgd2FzIHdlIHdpbGwgaGF2ZSBieXBh
c3MgU1RFIHNldHVwIGZvcgo+ID4gPj4gYWxsIGRldmljZXMKPiA+ID4+IHdpdGggUk1SIGluaXRp
YWxseSBhbmQgd2hlbiB0aGUgY29ycmVzcG9uZGluZyBkcml2ZXIgdGFrZXMgb3ZlcihpZgo+ID4g
Pj4gdGhhdCBoYXBwZW5zKQo+ID4gPj4gd2Ugd2lsbCBoYXZlIHRoZSB1bml0eSBtYXBwaW5nIHNl
dHVwIHByb3Blcmx5IGZvciB0aGUgUk1SIHJlZ2lvbnMuIEFuZAo+ID4gPj4gZm9yIGNhc2VzCj4g
PiA+PiBsaWtlIHRoZSBhYm92ZSwgaXQgd2lsbCByZW1haW4gaW4gdGhlIGJ5cGFzcyBtb2RlLgo+
ID4gPj4KPiA+ID4+IERvIHlvdSBzZWUgYW55IHByb2JsZW0oc2VjdXJpdHk/KSBpZiB0aGUgZGV2
IHN0cmVhbXMgcmVtYWluIGluIGJ5cGFzcwo+ID4gPj4gbW9kZSBmb3IKPiA+ID4+IHRoaXMgZGV2
PyBPciBpcyBpdCBwb3NzaWJsZSB0byBoYXZlIGEgc3R1YiBkcml2ZXIgZm9yIHRoaXMgZGV2LCBz
bwo+ID4gPj4gdGhhdCB3ZSB3aWxsIGhhdmUKPiA+ID4+IHRoZSBwcm9iZS9hdHRhY2ggaW52b2tl
ZCBhbmQgZXZlcnl0aGluZyB3aWxsIGZhbGwgaW4gcGxhY2U/Cj4gPiA+Cj4gPiA+IFRoZSBkb3du
c2lkZSBpcyB0aGF0IGlmIGEgZHJpdmVyIG5ldmVyIGJpbmRzIHRvIHRoYXQgZGV2aWNlLCBpdCBy
ZW1haW5zCj4gPiA+IGJ5cGFzc2VkLiBJZiBzb21lIG90aGVyIGV4dGVybmFsbHktY29udHJvbGxl
ZCBtYWxpY2lvdXMgZGV2aWNlIGNvdWxkCj4gPiA+IG1hbmFnZSB0byBzcG9vZiB0aGF0IGRldmlj
ZSdzIHJlcXVlc3RlciBJRCwgdGhhdCBjb3VsZCBwb3RlbnRpYWxseSBiZQo+ID4gPiBleHBsb2l0
ZWQuCj4gPiA+Cj4gPiA+PiBUQkgsIEkgaGF2ZW4ndCBsb29rZWQgaW50byBjcmVhdGluZyBhIHRl
bXAgZG9tYWluIGZvciB0aGVzZSB0eXBlcyBvZgo+ID4gPj4gdGhlIGRldmljZXMKPiA+ID4+IGFu
ZCBhbHNvIG5vdCBzdXJlIGhvdyB3ZSBiZW5lZml0IGZyb20gdGhhdCBjb21wYXJlZCB0byB0aGUg
U1RFIGJ5cGFzcwo+ID4gPj4gbW9kZS4KPiA+ID4KPiA+ID4gVGhhdCBzYWlkLCBzZXR0aW5nIHVw
IHRlbXBvcmFyeSB0cmFuc2xhdGlvbiBjb250ZXh0cyB0aGF0IGVuc3VyZSBhbnkKPiA+ID4gYWNj
ZXNzIGNhbiAqb25seSogYmUgdG8gUk1SIHJlZ2lvbnMgdW50aWwgYSBkcml2ZXIgdGFrZXMgb3Zl
ciBpcyBhbgo+ID4gPiBhd2Z1bCBsb3QgbW9yZSB3b3JrLiBJJ20gaW5jbGluZWQgdG8gYmUgcHJh
Z21hdGljIGhlcmUgYW5kIHNheSB3ZSBzaG91bGQKPiA+ID4gZ2V0IHRoaW5ncyB3b3JraW5nIGF0
IGFsbCB3aXRoIHRoZSBzaW1wbGUgYnlwYXNzIFNURS9TMkNSIG1ldGhvZCwgdGhlbgo+ID4gPiBs
b29rIGF0IGFkZGluZyB0aGUgaGlnaGVyLXNlY3VyaXR5IGVmZm9ydCBvbiB0b3AuCj4gPiA+Cj4g
PiA+IFJpZ2h0IG5vdyBzeXN0ZW1zIHRoYXQgbmVlZCB0aGlzIGFyZSBlaXRoZXIgYnJva2VuIChi
dXQgZWZmZWN0aXZlbHkKPiA+ID4gc2VjdXJlKSBvciB1c2luZyBkZWZhdWx0IGJ5cGFzcyB3aXRo
IFNNTVV2Mi4gUGVvcGxlIHdobyBwcmVmZXIgdG8KPiA+ID4gbWFpbnRhaW4gc2VjdXJpdHkgb3Zl
ciBmdW5jdGlvbmFsaXR5IGluIHRoZSBpbnRlcmltIGNhbiBtYWludGFpbiB0aGF0Cj4gPiA+IHN0
YXR1cyBxdW8gYnkgc2ltcGx5IGNvbnRpbnVpbmcgdG8gbm90IGRlc2NyaWJlIGFueSBSTVJzLgo+
ID4KPiA+IEkgYWdyZWUgd2l0aCBSb2JpbiwgbGV0J3MgZ2V0IHRoaXMgd29ya2luZyB3aXRoIHRo
ZSBieXBhc3MgbW9kZSAodW50aWwKPiA+IHRoZSBkZXZpY2UgYmluZHMpIGxpa2UgeW91J3ZlIGN1
cnJlbnRseSBnb3QuIEl0J3MgbXVjaCBiZXR0ZXIgdGhhbiB3aGF0Cj4gPiB3ZSBoYXZlIG90aGVy
d2lzZS4gVGhlbiBvbmNlIHRoYXQgaXMgbWVyZ2VkIHdlIGNhbiBsb29rIGF0IHRoZSB0ZW1wb3Jh
cnkKPiA+IHRyYW5zbGF0aW9uIGNvbnRleHQgb3Igc3R1YiBkcml2ZXIuIFRoZSB0ZW1wb3Jhcnkg
dHJhbnNsYXRpb24gY29udGV4dAo+ID4gd291bGQgYmUgJ25lYXRlc3QnLCBidXQgSSdtIG9ubHkg
YXdhcmUgb2YgdGhlIEVGSSBmcmFtZWJ1ZmZlciB1c2UgY2FzZQo+ID4gYW5kIGZvciB0aGF0IGl0
IG1pZ2h0IGJlIHBvc3NpYmxlIHRvIGRvIHNvbWV0aGluZyBzaW1wbGVyIC0gaWYgaW5kZWVkCj4g
PiBhbnl0aGluZyBpcyBuZWVkZWQgYXQgYWxsLiBJJ20gbm90IHN1cmUgaG93IG11Y2ggd2UgbmVl
ZCB0byBiZSB3b3JyaWVkCj4gPiBhYm91dCBtYWxpY2lvdXMgZGV2aWNlcyBzcG9vZmluZyByZXF1
ZXN0ZXIgSURzLgo+Cj4gUGVyZmVjdC4gSSB3aWxsIGtlZXAgdGhlIFNURSBieXBhc3MgYW5kIHJl
c3BpbiB0aGUgc2VyaWVzIG9uY2UgdGhlIHVwZGF0ZQo+IHRvIHRoZSBJT1JUIHJldiBFIGlzIG1h
ZGUgcHVibGljKGhvcGUgdGhhdCB3aWxsIGhhcHBlbiBzb29uKS4gSW4gdGhlCj4gbWVhbnRpbWUs
IGFwcHJlY2lhdGUgYW55IGZlZWRiYWNrIG9uIHRoZSByZXN0IG9mIHRoZSBwYXRjaGVzIGluIHRo
aXMgc2VyaWVzLgoKU2hhbWVlciwKCkkgYW0gcHJldHR5IHN1cmUgcmV2IEUgaXMgYWxyZWFkeSBw
dWJsaWMuICBZb3UgY2FuIGZpbmQgaXQgaGVyZS4KCmh0dHBzOi8vZGV2ZWxvcGVyLmFybS5jb20v
ZG9jdW1lbnRhdGlvbi9kZW4wMDQ5L2xhdGVzdC8KCkl0IGlzIGFsc28gbWFya2VkIG5vbi1jb25m
aWRlbnRpYWwuCgpJIGFsc28gaGF2ZSBpbml0aWFsIHBhdGNoZXMgZm9yIGVkazIgYW5kIHRoZSBI
b25leUNvbWIgTFgyMTYwYQpBQ1BJIHRhYmxlcyBhZGRpbmcgUk1SIG5vZGVzIHRoYXQgcGFydGlh
bGx5IHdvcmsgd2l0aCB5b3VyIHBhdGNoZXMuClRoaXMgaXMgd2l0aCBiYXNpYyBTTU1VdjIgc3Vw
cG9ydCBidXQgc2luY2UgeW91IGhhdmUgbW9yZSBleHBlcmllbmNlCnRoaXMgdGhpcyBJIGFtIG1v
cmUgdGhhbiBoYXBweSB0byB3b3JrIHdpdGggeW91IG9uIHlvdXIgcGF0Y2hzZXQuCgotSm9uCgoK
Pgo+IFRoYW5rcywKPiBTaGFtZWVyCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KPiBsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdAo+IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbApfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vaW9tbXU=
