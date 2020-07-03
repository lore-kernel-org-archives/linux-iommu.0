Return-Path: <SRS0=r5As=AO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3882EC433E1
	for <iommu@archiver.kernel.org>; Fri,  3 Jul 2020 09:19:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07E9420836
	for <iommu@archiver.kernel.org>; Fri,  3 Jul 2020 09:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="iN+u8c82"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07E9420836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=semihalf.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9D22726604;
	Fri,  3 Jul 2020 09:19:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NrBxNbFvo+uV; Fri,  3 Jul 2020 09:19:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7113D265F4;
	Fri,  3 Jul 2020 09:19:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48978C088E;
	Fri,  3 Jul 2020 09:19:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34E7CC0733
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 09:19:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1F8F7265F4
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 09:19:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RzBwFv0+QdoV for <iommu@lists.linux-foundation.org>;
 Fri,  3 Jul 2020 09:19:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com
 [209.85.167.68])
 by silver.osuosl.org (Postfix) with ESMTPS id C04E2265AA
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 09:19:15 +0000 (UTC)
Received: by mail-lf1-f68.google.com with SMTP id c11so18065537lfh.8
 for <iommu@lists.linux-foundation.org>; Fri, 03 Jul 2020 02:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=semihalf-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nBEfPe/18tEPqv7wv+Zics2+xxXlbthMHh4xvAE4N6c=;
 b=iN+u8c82kyQTkD6qOwBzf2wXqDKCRPBKxcOCnTN1IP8NjDKNt1RvjFw39caeUdcQ9c
 MxdOcNt2hIZbdIIsX3Cfyjt1pXfZGJ3hpaHB8Eq01Oaa21f3Nd1QxMynf8ODKaZo59E5
 XB68y8p7PnSLi7Nuc9TTqR2Iwz3ijSDKD6Z/m3HouzfUicS2VOdfu2BSvHdGHWLRoPUw
 wjv4MNMR2Kt9UhPO6lHw+sjOdAtD5CryaNj3srQTkgnSzIunVzBb9F0qlhJFx8M633DG
 cMzS9Da/rgfWLG5kIOo9Mfq2FsYx0MflYn3yVMr5SoJhIFsOln3VYoYjmejdcc5lFWV2
 HC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nBEfPe/18tEPqv7wv+Zics2+xxXlbthMHh4xvAE4N6c=;
 b=luitHuv1Ue+6IdneG/+69B1KfLN6ZscYZFIqE9KOYpSOYwRfUUwZrtayQZtGi5ixOr
 mDGSIftS1YACtGAFp92wjorqm5VIL8y+fMVGvAtbQ4z9HdIllih1QxACEFu6950mn5Sl
 95RreSTbVfRLCaTkpFEi2/DLjBVlDWUG/4X4Sn9b45k0zoQmuQHifADropOHX8Kkm+SZ
 qS4hx8VNyJesOo4hPi5AgpmmwVudO3vpdQ3+LAqOZOaPgjl0188oPfWhdbsZFmOSg8mU
 O6IBraJKNFOkIU0pRlIpuZt0DQRsV1/GhJEk3m5hEXTgl7L9Orw0JHif4uFM/L+7RM1i
 v9mg==
X-Gm-Message-State: AOAM5318HMMmht0Lr0PPKCYein11VVF1/uvjaq6qlyoFJXMe97Wamxi6
 jGCuDXrv2Rhm8wpq1VVwjoZxiw==
X-Google-Smtp-Source: ABdhPJwv3Zh9Xqtx9KorLCkbf9g75bpoTeify56dMQego4mY0vfZGL/WPV7E3TjABV7tOwc1voofsQ==
X-Received: by 2002:ac2:5629:: with SMTP id b9mr21258845lff.208.1593767953441; 
 Fri, 03 Jul 2020 02:19:13 -0700 (PDT)
Received: from [192.168.1.9] ([83.68.95.66])
 by smtp.googlemail.com with ESMTPSA id u15sm3904281ljh.56.2020.07.03.02.19.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2020 02:19:12 -0700 (PDT)
Subject: Re: [PATCH v3 1/4] iommu/arm-smmu: Add SMMU ID2 register fixup hook
To: Robin Murphy <robin.murphy@arm.com>, will@kernel.org, joro@8bytes.org,
 gregory.clement@bootlin.com, robh+dt@kernel.org, hannah@marvell.com
References: <20200702201633.22693-1-tn@semihalf.com>
 <20200702201633.22693-2-tn@semihalf.com>
 <d3540512-09c7-0fa5-2b35-6f1112a575a9@arm.com>
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <8758046a-9e11-8d21-26ff-2f02a315f3d4@semihalf.com>
Date: Fri, 3 Jul 2020 11:19:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <d3540512-09c7-0fa5-2b35-6f1112a575a9@arm.com>
Content-Language: en-US
Cc: devicetree@vger.kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, nadavh@marvell.com,
 iommu@lists.linux-foundation.org, mw@semihalf.com,
 linux-arm-kernel@lists.infradead.org
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

T24gMDMuMDcuMjAyMCAxMDoyNCwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjAtMDctMDIg
MjE6MTYsIFRvbWFzeiBOb3dpY2tpIHdyb3RlOgo+PiBXZSBhbHJlYWR5IGhhdmUgJ2NmZ19wcm9i
ZScgaG9vayB3aGljaCBtZWFudCB0byBvdmVycmlkZSBhbmQgYXBwbHkKPj4gd29ya2Fyb3VuZHMg
d2hpbGUgcHJvYmluZyBJRCByZWdpc3RlcnMuIEhvd2V2ZXIsICdjZmdfcHJvYmUnIGlzIGNhbGxl
ZAo+PiBhdCB0aGUgdmVyeSBlbmQgYW5kIHRoZXJlZm9yZSBmb3Igc29tZSBjYXNlcyBmaXhpbmcg
dXAgdGhpbmdzIGJlY29tZXMgCj4+IGNvbXBsZXgKPj4gb3IgcmVxdWlyZXMgZXhwb3J0aW5nIG9m
IFNNTVUgZHJpdmVyIHN0cnVjdHVyZXMuIEhlbmNlLCBzZWVtcyBpdCBpcyAKPj4gYmV0dGVyIGFu
ZAo+PiBjbGVhbmVyIHRvIGRvIElEIGZpeHVwIHJpZ2h0IGF3YXkuIEluIHByZXBhcmF0aW9uIGZv
ciBhZGRpbmcgTWFydmVsbAo+PiBlcnJhdGEgYWRkIGFuIGV4dHJhIElEMiBmaXh1cCBob29rLgo+
IAo+IEhtbSwgdGhlIGludGVudCBvZiAtPmNmZ19wcm9iZSB3YXMgdmVyeSBtdWNoIHRvIGdpdmUg
aW1wbCBhIGNoYW5jZSB0byAKPiBhZGp1c3QgdGhlIGRldGVjdGVkIGZlYXR1cmVzIGJlZm9yZSB3
ZSBzdGFydCBjb25zdW1pbmcgdGhlbSwgd2l0aCB0aGlzIAo+IGV4YWN0IGNhc2UgaW4gbWluZC4g
U2luY2UgdGhlIENhdml1bSBxdWlyayBpc24ndCBhY3R1YWxseSBkb2luZyB0aGF0IC0gCj4gaXQg
anVzdCBuZWVkcyB0byBydW4gKmFueXdoZXJlKiBpbiB0aGUgd2hvbGUgcHJvYmUgcHJvY2VzcyAt
IEknbSB1bmRlciAKPiBubyBpbGx1c2lvbiB0aGF0IEkgcHV0IHRoZSBob29rIGluIGV4YWN0bHkg
dGhlIHJpZ2h0IHBsYWNlIGZpcnN0IHRpbWUgCj4gYXJvdW5kIDspCj4gCj4gVGhlIGRpZmYgYmVs
b3cgc2hvdWxkIGJlIG1vcmUgb24gdGhlIG1hcmsuLi4KPiAKPiBSb2Jpbi4KPiAKPiAtLS0tLT44
LS0tLS0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9hcm0tc21tdS5jIGIvZHJpdmVycy9p
b21tdS9hcm0tc21tdS5jCj4gaW5kZXggMjQzYmM0Y2IyNzA1Li44ODRmZmNhNWIxZWIgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9pb21tdS9hcm0tc21tdS5jCj4gKysrIGIvZHJpdmVycy9pb21tdS9h
cm0tc21tdS5jCj4gQEAgLTE4OTEsNiArMTg5MSw5IEBAIHN0YXRpYyBpbnQgYXJtX3NtbXVfZGV2
aWNlX2NmZ19wcm9iZShzdHJ1Y3QgCj4gYXJtX3NtbXVfZGV2aWNlICpzbW11KQo+ICDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgc21tdS0+ZmVhdHVyZXMgfD0gQVJNX1NNTVVfRkVBVF9GTVRfQUFS
Q0g2NF82NEs7Cj4gIMKgwqDCoMKgIH0KPiAKPiArwqDCoMKgIGlmIChzbW11LT5pbXBsICYmIHNt
bXUtPmltcGwtPmNmZ19wcm9iZSkKPiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHNtbXUtPmltcGwt
PmNmZ19wcm9iZShzbW11KTsKPiArCj4gIMKgwqDCoMKgIC8qIE5vdyB3ZSd2ZSBjb3JyYWxsZWQg
dGhlIHZhcmlvdXMgZm9ybWF0cywgd2hhdCdsbCBpdCBkbz8gKi8KPiAgwqDCoMKgwqAgaWYgKHNt
bXUtPmZlYXR1cmVzICYgQVJNX1NNTVVfRkVBVF9GTVRfQUFSQ0gzMl9TKQo+ICDCoMKgwqDCoMKg
wqDCoMKgIHNtbXUtPnBnc2l6ZV9iaXRtYXAgfD0gU1pfNEsgfCBTWl82NEsgfCBTWl8xTSB8IFNa
XzE2TTsKPiBAQCAtMTkwOSw3ICsxOTEyLDYgQEAgc3RhdGljIGludCBhcm1fc21tdV9kZXZpY2Vf
Y2ZnX3Byb2JlKHN0cnVjdCAKPiBhcm1fc21tdV9kZXZpY2UgKnNtbXUpCj4gIMKgwqDCoMKgIGRl
dl9ub3RpY2Uoc21tdS0+ZGV2LCAiXHRTdXBwb3J0ZWQgcGFnZSBzaXplczogMHglMDhseFxuIiwK
PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzbW11LT5wZ3NpemVfYml0bWFwKTsKPiAKPiAtCj4g
IMKgwqDCoMKgIGlmIChzbW11LT5mZWF0dXJlcyAmIEFSTV9TTU1VX0ZFQVRfVFJBTlNfUzEpCj4g
IMKgwqDCoMKgwqDCoMKgwqAgZGV2X25vdGljZShzbW11LT5kZXYsICJcdFN0YWdlLTE6ICVsdS1i
aXQgVkEgLT4gJWx1LWJpdCBJUEFcbiIsCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBzbW11LT52YV9zaXplLCBzbW11LT5pcGFfc2l6ZSk7Cj4gQEAgLTE5MTgsOSArMTkyMCw2IEBA
IHN0YXRpYyBpbnQgYXJtX3NtbXVfZGV2aWNlX2NmZ19wcm9iZShzdHJ1Y3QgCj4gYXJtX3NtbXVf
ZGV2aWNlICpzbW11KQo+ICDCoMKgwqDCoMKgwqDCoMKgIGRldl9ub3RpY2Uoc21tdS0+ZGV2LCAi
XHRTdGFnZS0yOiAlbHUtYml0IElQQSAtPiAlbHUtYml0IFBBXG4iLAo+ICDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgc21tdS0+aXBhX3NpemUsIHNtbXUtPnBhX3NpemUpOwo+IAo+IC3C
oMKgwqAgaWYgKHNtbXUtPmltcGwgJiYgc21tdS0+aW1wbC0+Y2ZnX3Byb2JlKQo+IC3CoMKgwqDC
oMKgwqDCoCByZXR1cm4gc21tdS0+aW1wbC0+Y2ZnX3Byb2JlKHNtbXUpOwo+IC0KPiAgwqDCoMKg
wqAgcmV0dXJuIDA7Cj4gIMKgfQo+IAoKSSB3YXMgdW5kZXIgaW1wcmVzc2lvbiB0aGF0IC0+Y2Zn
X3Byb2JlIHdhcyBtZWFudCBmb3IgQ2F2aXVtIGFsaWtlIAplcnJhdGEgKHBvc2l0aW9uIGluZGVw
ZW5kZW50KS4gVGhlbiBJIHdpbGwgbW92ZSAtPmNmZ19wcm9iZSBhcyB5b3UgCnN1Z2dlc3RlZC4g
SSBwcmVmZXIgbm90IHRvIGFkZCB5ZXQgYW5vdGhlciBpbXBsIGhvb2sgdG9vIDopCgpUaGFua3Ms
ClRvbWFzegpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpp
b21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
