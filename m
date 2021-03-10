Return-Path: <SRS0=kCyf=II=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A13C433E0
	for <iommu@archiver.kernel.org>; Wed, 10 Mar 2021 19:13:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9160C64F60
	for <iommu@archiver.kernel.org>; Wed, 10 Mar 2021 19:13:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9160C64F60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3EF964EC57;
	Wed, 10 Mar 2021 19:13:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jNUE-tKTalSZ; Wed, 10 Mar 2021 19:13:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F23146F1F;
	Wed, 10 Mar 2021 19:13:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 461C3C000B;
	Wed, 10 Mar 2021 19:13:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C27EEC0001
 for <iommu@lists.linux-foundation.org>; Wed, 10 Mar 2021 19:13:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A69CA4AC93
 for <iommu@lists.linux-foundation.org>; Wed, 10 Mar 2021 19:13:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BkhF48JaJUDf for <iommu@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 19:13:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6BC7B46F1F
 for <iommu@lists.linux-foundation.org>; Wed, 10 Mar 2021 19:13:46 +0000 (UTC)
Received: by mail-lf1-x135.google.com with SMTP id u4so35444228lfs.0
 for <iommu@lists.linux-foundation.org>; Wed, 10 Mar 2021 11:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TGVo84MkssIIGFaMlWeB/GdWruWqeKFsQWqj4qPbSMU=;
 b=HbsI8I4tO0QXv6SbFoersQnW7puDohAmS/pM6fJaJGkWRSDeZFhNtTCNZEeEzA6s+X
 w2Xp3MfPGHCIZI8D3kxV8emCwmZBLGtFVt9BJbPcvCb77qeFQqHINFY39+LXwMJz7YDo
 BH6NshzUCP5G985lVE7NGXKZQLR/bgCjoeUATpkxGHpSlnVKYealzTtrIgNiETrsJiag
 jkc4Yvb0+n6QSSBWBu82vYWbspP7U15YPQwg5glY//VxIi9WmTWSomUZulhKKFC8HbIj
 NGVjufjAZgw1q1Wu8EdF/QCZpEN3KeUo46kx0SdRb0bHdnsYa4uHvrBtck4Z7AHFa+Nz
 JnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TGVo84MkssIIGFaMlWeB/GdWruWqeKFsQWqj4qPbSMU=;
 b=s6snx/UNvKrbkO5NzxqO+Z8hE4HWEPugwO8PaFD0D1oZ1Af8JUPFZN1uEbbhTPemjP
 ckNYJN4zUsP/vC6PGnqFvAyeWeFhwYkcbxzUsU88vYkFQaeanWIjwJUYGmYSZCTiu7tK
 VmaZOojwKeFrT/pCh/Sl4pPtT44mKqXONJvOI//SomkTijtPhx2w62K6x5oPr1xf7fGw
 d04ut8DACHQX0/HBmkxNSeNPo5udBp6pk++z/4iLs/pJF43B7s8MfDk0rr6FDtYybt/L
 xDqRr+Hl44z/2i5oCv/QaCMJcKr6kIwWgyjPV0CBr2guO+KSo8FpuzHAz5ldedZp23EW
 OD+g==
X-Gm-Message-State: AOAM533sAPCk9iXqfl1kYaR+S7Bi/WoNzdqGrwvWNZsvosl7BUvwrhYy
 0pVr4BwUfLV7/s7s5geAAg8=
X-Google-Smtp-Source: ABdhPJxAxsuCKlrBzioldvdKtUXE1MFNfDCFzDMOqQfbX+L9cAYHE5rvNAvBmQKSPjyj37EoksplAw==
X-Received: by 2002:a05:6512:1156:: with SMTP id
 m22mr2808559lfg.637.1615403624284; 
 Wed, 10 Mar 2021 11:13:44 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-52.dynamic.spd-mgts.ru.
 [109.252.193.52])
 by smtp.googlemail.com with ESMTPSA id k6sm63089lfm.19.2021.03.10.11.13.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Mar 2021 11:13:43 -0800 (PST)
Subject: Re: [PATCH] iommu/tegra-smmu: Fix mc errors on tegra124-nyan
To: Nicolin Chen <nicoleotsuka@gmail.com>, joro@8bytes.org,
 thierry.reding@gmail.com, will@kernel.org, guillaume.tucker@collabora.com
References: <20210218220702.1962-1-nicoleotsuka@gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a8a7a0af-895f-9d79-410d-5dd03ebbd6dd@gmail.com>
Date: Wed, 10 Mar 2021 22:13:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210218220702.1962-1-nicoleotsuka@gmail.com>
Content-Language: en-US
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jonathanh@nvidia.com
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

MTkuMDIuMjAyMSAwMTowNywgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gQ29tbWl0IDI1OTM4
YzczY2Q3OSAoImlvbW11L3RlZ3JhLXNtbXU6IFJld29yayB0ZWdyYV9zbW11X3Byb2JlX2Rldmlj
ZSgpIikKPiByZW1vdmVkIGNlcnRhaW4gaGFjayBpbiB0aGUgdGVncmFfc21tdV9wcm9iZSgpIGJ5
IHJlbHlpbmcgb24gSU9NTVUgY29yZSB0bwo+IG9mX3hsYXRlIFNNTVUncyBTSUQgcGVyIGRldmlj
ZSwgc28gYXMgdG8gZ2V0IHJpZCBvZiB0ZWdyYV9zbW11X2ZpbmQoKSBhbmQKPiB0ZWdyYV9zbW11
X2NvbmZpZ3VyZSgpIHRoYXQgYXJlIHR5cGljYWxseSBkb25lIGluIHRoZSBJT01NVSBjb3JlIGFs
c28uCj4gCj4gVGhpcyBhcHByb2FjaCB3b3JrcyBmb3IgYm90aCBleGlzdGluZyBkZXZpY2VzIHRo
YXQgaGF2ZSBEVCBub2RlcyBhbmQgb3RoZXIKPiBkZXZpY2VzIChsaWtlIFBDSSBkZXZpY2UpIHRo
YXQgZG9uJ3QgZXhpc3QgaW4gRFQsIG9uIFRlZ3JhMjEwIGFuZCBUZWdyYTMKPiB1cG9uIHRlc3Rp
bmcuIEhvd2V2ZXIsIFBhZ2UgRmF1bHQgZXJyb3JzIGFyZSByZXBvcnRlZCBvbiB0ZWdyYTEyNC1O
eWFuOgo+IAo+ICAgdGVncmEtbWMgNzAwMTkwMDAubWVtb3J5LWNvbnRyb2xsZXI6IGRpc3BsYXkw
YTogcmVhZCBAMHhmZTA1NmI0MDoKPiAJIEVNRU0gYWRkcmVzcyBkZWNvZGUgZXJyb3IgKFNNTVUg
dHJhbnNsYXRpb24gZXJyb3IgWy0tU10pCj4gICB0ZWdyYS1tYyA3MDAxOTAwMC5tZW1vcnktY29u
dHJvbGxlcjogZGlzcGxheTBhOiByZWFkIEAweGZlMDU2YjQwOgo+IAkgUGFnZSBmYXVsdCAoU01N
VSB0cmFuc2xhdGlvbiBlcnJvciBbLS1TXSkKPiAKPiBBZnRlciBkZWJ1Z2dpbmcsIEkgZm91bmQg
dGhhdCB0aGUgbWVudGlvbmVkIGNvbW1pdCBjaGFuZ2VkIHNvbWUgZnVuY3Rpb24KPiBjYWxsYmFj
ayBzZXF1ZW5jZSBvZiB0ZWdyYS1zbW11J3MsIHJlc3VsdGluZyBpbiBlbmFibGluZyBTTU1VIGZv
ciBkaXNwbGF5Cj4gY2xpZW50IGJlZm9yZSBkaXNwbGF5IGRyaXZlciBnZXRzIGluaXRpYWxpemVk
LiBJIGNvdWxkbid0IHJlcHJvZHVjZSBleGFjdAo+IHNhbWUgaXNzdWUgb24gVGVncmEyMTAgYXMg
VGVncmExMjQgKGFybS0zMikgZGlmZmVycyBhdCBhcmNoLWxldmVsIGNvZGUuCj4gCj4gQWN0dWFs
bHkgdGhpcyBQYWdlIEZhdWx0IGlzIGEga25vd24gaXNzdWUsIGFzIG9uIG1vc3Qgb2YgVGVncmEg
cGxhdGZvcm1zLAo+IGRpc3BsYXkgZ2V0cyBlbmFibGVkIGJ5IHRoZSBib290bG9hZGVyIGZvciB0
aGUgc3BsYXNoIHNjcmVlbiBmZWF0dXJlLCBzbwo+IGl0IGtlZXBzIGZpbGxpbmcgdGhlIGZyYW1l
YnVmZmVyIG1lbW9yeS4gQSBwcm9wZXIgZml4IHRvIHRoaXMgaXNzdWUgaXMgdG8KPiAxOjEgbGlu
ZWFyIG1hcCB0aGUgZnJhbWVidWZmZXIgbWVtb3J5IHRvIElPVkEgc3BhY2Ugc28gdGhlIFNNTVUg
d2lsbCBoYXZlCj4gdGhlIHNhbWUgYWRkcmVzcyBhcyB0aGUgcGh5c2ljYWwgYWRkcmVzcyBpbiBp
dHMgcGFnZSB0YWJsZS4gWWV0LCBUaGllcnJ5Cj4gaGFzIGJlZW4gd29ya2luZyBvbiB0aGUgc29s
dXRpb24gYWJvdmUgZm9yIGEgeWVhciwgYW5kIGl0IGhhc24ndCBtZXJnZWQuCj4gCj4gVGhlcmVm
b3JlLCBsZXQncyBwYXJ0aWFsbHkgcmV2ZXJ0IHRoZSBtZW50aW9uZWQgY29tbWl0IHRvIGZpeCB0
aGUgZXJyb3JzLgo+IAo+IFRoZSByZWFzb24gd2h5IHdlIGRvIGEgcGFydGlhbCByZXZlcnQgaGVy
ZSBpcyB0aGF0IHdlIGNhbiBzdGlsbCBzZXQgcHJpdgo+IGluIC0+b2ZfeGxhdGUoKSBjYWxsYmFj
ayBmb3IgUENJIGRldmljZXMuIE1lYW53aGlsZSwgZGV2aWNlcyBleGlzdGluZyBpbgo+IERULCBs
aWtlIGRpc3BsYXksIHdpbGwgZ28gdGhyb3VnaCB0ZWdyYV9zbW11X2NvbmZpZ3VyZSgpIGF0IHRo
ZSBzdGFnZSBvZgo+IGJ1c19zZXRfaW9tbXUoKSB3aGVuIFNNTVUgZ2V0cyBwcm9iZWQoKSwgYXMg
d2hhdCBpdCBkaWQgYmVmb3JlIHdlIG1lcmdlZAo+IHRoZSBtZW50aW9uZWQgY29tbWl0Lgo+IAo+
IE9uY2Ugd2UgaGF2ZSB0aGUgbGluZWFyIG1hcCBzb2x1dGlvbiBmb3IgZnJhbWVidWZmZXIgbWVt
b3J5LCB0aGlzIGNoYW5nZQo+IGNhbiBiZSBjbGVhbmVkIGF3YXkuCj4gCj4gW0JpZyB0aGFuayB0
byBHdWlsbGF1bWUgd2hvIHJlcG9ydGVkIGFuZCBoZWxwZWQgZGVidWdnaW5nL3ZlcmlmaWNhdGlv
bl0KPiAKPiBGaXhlczogMjU5MzhjNzNjZDc5ICgiaW9tbXUvdGVncmEtc21tdTogUmV3b3JrIHRl
Z3JhX3NtbXVfcHJvYmVfZGV2aWNlKCkiKQo+IFJlcG9ydGVkLWJ5OiBHdWlsbGF1bWUgVHVja2Vy
IDxndWlsbGF1bWUudHVja2VyQGNvbGxhYm9yYS5jb20+Cj4gU2lnbmVkLW9mZi1ieTogTmljb2xp
biBDaGVuIDxuaWNvbGVvdHN1a2FAZ21haWwuY29tPgo+IC0tLQo+IAo+IEd1aWxsYXVtZSwgd291
bGQgeW91IHBsZWFzZSBnaXZlIGEgIlRlc3RlZC1ieSIgdG8gdGhpcyBjaGFuZ2U/IFRoYW5rcyEK
PiAKPiAgZHJpdmVycy9pb21tdS90ZWdyYS1zbW11LmMgfCA3MiArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLQo+ICAxIGZpbGUgY2hhbmdlZCwgNzEgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L3RlZ3JhLXNtbXUu
YyBiL2RyaXZlcnMvaW9tbXUvdGVncmEtc21tdS5jCj4gaW5kZXggNGEzZjA5NWExYzI2Li45N2Vi
NjJmNjY3ZDIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9pb21tdS90ZWdyYS1zbW11LmMKPiArKysg
Yi9kcml2ZXJzL2lvbW11L3RlZ3JhLXNtbXUuYwo+IEBAIC03OTgsMTAgKzc5OCw3MCBAQCBzdGF0
aWMgcGh5c19hZGRyX3QgdGVncmFfc21tdV9pb3ZhX3RvX3BoeXMoc3RydWN0IGlvbW11X2RvbWFp
biAqZG9tYWluLAo+ICAJcmV0dXJuIFNNTVVfUEZOX1BIWVMocGZuKSArIFNNTVVfT0ZGU0VUX0lO
X1BBR0UoaW92YSk7Cj4gIH0KPiAgCj4gK3N0YXRpYyBzdHJ1Y3QgdGVncmFfc21tdSAqdGVncmFf
c21tdV9maW5kKHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnApCj4gK3sKPiArCXN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXY7Cj4gKwlzdHJ1Y3QgdGVncmFfbWMgKm1jOwo+ICsKPiArCXBkZXYgPSBv
Zl9maW5kX2RldmljZV9ieV9ub2RlKG5wKTsKPiArCWlmICghcGRldikKPiArCQlyZXR1cm4gTlVM
TDsKPiArCj4gKwltYyA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpOwo+ICsJaWYgKCFtYykK
PiArCQlyZXR1cm4gTlVMTDsKPiArCj4gKwlyZXR1cm4gbWMtPnNtbXU7Cj4gK30KPiArCj4gK3N0
YXRpYyBpbnQgdGVncmFfc21tdV9jb25maWd1cmUoc3RydWN0IHRlZ3JhX3NtbXUgKnNtbXUsIHN0
cnVjdCBkZXZpY2UgKmRldiwKPiArCQkJCXN0cnVjdCBvZl9waGFuZGxlX2FyZ3MgKmFyZ3MpCj4g
K3sKPiArCWNvbnN0IHN0cnVjdCBpb21tdV9vcHMgKm9wcyA9IHNtbXUtPmlvbW11Lm9wczsKPiAr
CWludCBlcnI7Cj4gKwo+ICsJZXJyID0gaW9tbXVfZndzcGVjX2luaXQoZGV2LCAmZGV2LT5vZl9u
b2RlLT5md25vZGUsIG9wcyk7Cj4gKwlpZiAoZXJyIDwgMCkgewo+ICsJCWRldl9lcnIoZGV2LCAi
ZmFpbGVkIHRvIGluaXRpYWxpemUgZndzcGVjOiAlZFxuIiwgZXJyKTsKPiArCQlyZXR1cm4gZXJy
Owo+ICsJfQo+ICsKPiArCWVyciA9IG9wcy0+b2ZfeGxhdGUoZGV2LCBhcmdzKTsKPiArCWlmIChl
cnIgPCAwKSB7Cj4gKwkJZGV2X2VycihkZXYsICJmYWlsZWQgdG8gcGFyc2UgU1cgZ3JvdXAgSUQ6
ICVkXG4iLCBlcnIpOwo+ICsJCWlvbW11X2Z3c3BlY19mcmVlKGRldik7Cj4gKwkJcmV0dXJuIGVy
cjsKPiArCX0KPiArCj4gKwlyZXR1cm4gMDsKPiArfQo+ICsKPiAgc3RhdGljIHN0cnVjdCBpb21t
dV9kZXZpY2UgKnRlZ3JhX3NtbXVfcHJvYmVfZGV2aWNlKHN0cnVjdCBkZXZpY2UgKmRldikKPiAg
ewo+IC0Jc3RydWN0IHRlZ3JhX3NtbXUgKnNtbXUgPSBkZXZfaW9tbXVfcHJpdl9nZXQoZGV2KTsK
PiArCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAgPSBkZXYtPm9mX25vZGU7Cj4gKwlzdHJ1Y3QgdGVn
cmFfc21tdSAqc21tdSA9IE5VTEw7Cj4gKwlzdHJ1Y3Qgb2ZfcGhhbmRsZV9hcmdzIGFyZ3M7Cj4g
Kwl1bnNpZ25lZCBpbnQgaW5kZXggPSAwOwo+ICsJaW50IGVycjsKPiArCj4gKwl3aGlsZSAob2Zf
cGFyc2VfcGhhbmRsZV93aXRoX2FyZ3MobnAsICJpb21tdXMiLCAiI2lvbW11LWNlbGxzIiwgaW5k
ZXgsCj4gKwkJCQkJICAmYXJncykgPT0gMCkgewo+ICsJCXNtbXUgPSB0ZWdyYV9zbW11X2ZpbmQo
YXJncy5ucCk7Cj4gKwkJaWYgKHNtbXUpIHsKPiArCQkJZXJyID0gdGVncmFfc21tdV9jb25maWd1
cmUoc21tdSwgZGV2LCAmYXJncyk7Cj4gKwkJCW9mX25vZGVfcHV0KGFyZ3MubnApOwo+ICAKPiAr
CQkJaWYgKGVyciA8IDApCj4gKwkJCQlyZXR1cm4gRVJSX1BUUihlcnIpOwo+ICsKPiArCQkJYnJl
YWs7Cj4gKwkJfQo+ICsKPiArCQlvZl9ub2RlX3B1dChhcmdzLm5wKTsKPiArCQlpbmRleCsrOwo+
ICsJfQo+ICsKPiArCXNtbXUgPSBkZXZfaW9tbXVfcHJpdl9nZXQoZGV2KTsKPiAgCWlmICghc21t
dSkKPiAgCQlyZXR1cm4gRVJSX1BUUigtRU5PREVWKTsKPiAgCj4gQEAgLTEwMjgsNiArMTA4OCwx
NiBAQCBzdHJ1Y3QgdGVncmFfc21tdSAqdGVncmFfc21tdV9wcm9iZShzdHJ1Y3QgZGV2aWNlICpk
ZXYsCj4gIAlpZiAoIXNtbXUpCj4gIAkJcmV0dXJuIEVSUl9QVFIoLUVOT01FTSk7Cj4gIAo+ICsJ
LyoKPiArCSAqIFRoaXMgaXMgYSBiaXQgb2YgYSBoYWNrLiBJZGVhbGx5IHdlJ2Qgd2FudCB0byBz
aW1wbHkgcmV0dXJuIHRoaXMKPiArCSAqIHZhbHVlLiBIb3dldmVyIHRoZSBJT01NVSByZWdpc3Ry
YXRpb24gcHJvY2VzcyB3aWxsIGF0dGVtcHQgdG8gYWRkCj4gKwkgKiBhbGwgZGV2aWNlcyB0byB0
aGUgSU9NTVUgd2hlbiBidXNfc2V0X2lvbW11KCkgaXMgY2FsbGVkLiBJbiBvcmRlcgo+ICsJICog
bm90IHRvIHJlbHkgb24gZ2xvYmFsIHZhcmlhYmxlcyB0byB0cmFjayB0aGUgSU9NTVUgaW5zdGFu
Y2UsIHdlCj4gKwkgKiBzZXQgaXQgaGVyZSBzbyB0aGF0IGl0IGNhbiBiZSBsb29rZWQgdXAgZnJv
bSB0aGUgLnByb2JlX2RldmljZSgpCj4gKwkgKiBjYWxsYmFjayB2aWEgdGhlIElPTU1VIGRldmlj
ZSdzIC5kcnZkYXRhIGZpZWxkLgo+ICsJICovCj4gKwltYy0+c21tdSA9IHNtbXU7Cj4gKwo+ICAJ
c2l6ZSA9IEJJVFNfVE9fTE9OR1Moc29jLT5udW1fYXNpZHMpICogc2l6ZW9mKGxvbmcpOwo+ICAK
PiAgCXNtbXUtPmFzaWRzID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZSwgR0ZQX0tFUk5FTCk7Cj4g
CgpJIGZvdW5kIHRoYXQgdGhpcyBwYXRjaCBpbnRyb2R1Y2VkIGEgc2VyaW91cyByZWdyZXNzaW9u
IG9uIFRlZ3JhMzAgdXNpbmcKdG9kYXkncyBsaW51eC1uZXh0LiBUZWdyYTMwIGhhcyB0d28gM2Qg
aC93IGJsb2NrcyBjb25uZWN0ZWQgaW4gU0xJIGFuZApvbmx5IG9uZSBvZiB0aGUgYmxvY2tzIGlz
IG5vdyBhdHRhY2hlZCB0byBJT01NVSBkb21haW4sIG1lYW5pbmcgdGhhdCBHUFUKaXMgdW51c2Fi
bGUgbm93LiBBbGwgM2QsIDJkIGFuZCBkaXNwbGF5IGRldmljZXMgc2hhcmUgdGhlIHNhbWUgIkRS
TSIKZ3JvdXAgb24gVGVncmEzMC4KCk5pY29saW4sIHBsZWFzZSBsZXQgbWUga25vdyBpZiBoYXZl
IGFueSBzdWdnZXN0aW9ucy4gSSBtYXkgdGFrZSBhIGNsb3Nlcgpsb29rIGEgZGF5IGxhdGVyLCBm
b3Igbm93IEknbGwganVzdCByZXZlcnQgdGhpcyBwYXRjaCBsb2NhbGx5LiBUaGFua3MgaW4KYWR2
YW5jZS4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9t
bXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
