Return-Path: <SRS0=7V87=LJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237B4C48BDF
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 08:03:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B85A5613FA
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 08:03:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B85A5613FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 82A76605A1;
	Tue, 15 Jun 2021 08:03:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7BaECpQFZf0H; Tue, 15 Jun 2021 08:03:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 451B3605A0;
	Tue, 15 Jun 2021 08:03:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 113E4C000E;
	Tue, 15 Jun 2021 08:03:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39F45C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 08:03:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1E06A605A0
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 08:03:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZBzES7w-eZ2N for <iommu@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 08:03:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 14031605A1
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 08:03:22 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id he7so20810372ejc.13
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 01:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wdI+I/lHUujwC+TG2fdDJeHoDIEtdGAbbt6V+XPJtuk=;
 b=w+uRwxflv4sk6WV3aTuO9qp0FbwtGw1hcMJ7HFwAVngxqPNxAFVh/CT96PRsj9WZMf
 N00VzbA5Kq0OgL64OdzL7UEG02m3NZc5lR0DO/q09tUx7kXpMy3uThdpaF6n3T/aoLkT
 a+3VB+bkrWAFM1p7czKoMmKHnmrwv5k27o03FVJe8ocMcs/sF4wiDbVl1GiKTQblr7wl
 sfWyFfFkfOQZzhXjA2sfLkMGfvdxl5jxjjEW8waEMED6b+kYaox1dLmiVTwPcnOXxGi0
 XmNMk11St7HZW9G4RlTSEORegRMjFuyPHRBSYADb2VNfx2o1uuCYgF+zsoU9TWSGCoQH
 lGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wdI+I/lHUujwC+TG2fdDJeHoDIEtdGAbbt6V+XPJtuk=;
 b=l2ry115LfPnr7O3FXMQJ9R9djC8nsDLwmVO0lqfvvOC9wFNgiZx5yCmnkximCx4JLS
 qt0sg5MmoyO1F8xOZ1e3w4g+RWv9hBKk5N7YsMnKdbU1r6AS/7oh+Z/7+82J79EC3NOL
 ma5oY/dRa5SL+SDvv0tobOKyNmxDuHiRzRzpfiep1m8ZcyvIk91a1qjPW6ZvkUJDEm9G
 e3jOotAGl6RmsKbkfw/QYUNXl29h2Jsjbpe3/EQBRBjyfYsJeVtbuLERpAshXx32n/kw
 aiG2aQscLYmZLrp8Aq6JWpCfR8pad6UoSqAm/E3cI/2U7yPQ068j1SXsC9TD/JP4BAtn
 hOaQ==
X-Gm-Message-State: AOAM532/NQ73XdZn08YclJo1qsdh8E4rCfoAxzBF+P4MFBLXNrJnqLaL
 koyNl0AR8keHqVPfTnB2t14hRcFjv7N6XLaR8y63yg==
X-Google-Smtp-Source: ABdhPJxuTet90M2NLgVYa3MYWkSjzYxkKWvjEVMnEKTQudT8ZIAhxX2gd53MZccjagmA6lzAaL4w8zUYb22bLlsq3Ok=
X-Received: by 2002:a17:906:3ed0:: with SMTP id
 d16mr18865640ejj.16.1623744201193; 
 Tue, 15 Jun 2021 01:03:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com>
 <20210524110222.2212-8-shameerali.kolothum.thodi@huawei.com>
 <2bc3ae21-f2af-ee2c-5e9d-d47633e0439e@arm.com>
 <9348e07e23db4522b79318b81937f221@huawei.com>
In-Reply-To: <9348e07e23db4522b79318b81937f221@huawei.com>
From: Jon Nettleton <jon@solid-run.com>
Date: Tue, 15 Jun 2021 10:02:44 +0200
Message-ID: <CABdtJHuEpg0+whCvQn2oHOVX9wqjS3LUDyaHJr6vf31Kuj+-Fg@mail.gmail.com>
Subject: Re: [PATCH v5 7/8] iommu/arm-smmu: Get associated RMR info and
 install bypass SMR
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Linuxarm <linuxarm@huawei.com>,
 "steven.price@arm.com" <steven.price@arm.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 wanghuiqiang <wanghuiqiang@huawei.com>,
 "Guohanjun \(Hanjun Guo\)" <guohanjun@huawei.com>,
 yangyicong <yangyicong@huawei.com>,
 "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
 Robin Murphy <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

T24gTW9uLCBKdW4gMTQsIDIwMjEgYXQgNjo1MSBQTSBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2Rp
CjxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+IHdyb3RlOgo+Cj4KPgo+ID4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPiA+IEZyb206IFJvYmluIE11cnBoeSBbbWFpbHRv
OnJvYmluLm11cnBoeUBhcm0uY29tXQo+ID4gU2VudDogMTQgSnVuZSAyMDIxIDExOjA2Cj4gPiBU
bzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaSA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBo
dWF3ZWkuY29tPjsKPiA+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGlu
dXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc7Cj4gPiBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwo+ID4gQ2M6IGpvbkBzb2xpZC1ydW4uY29tOyBMaW51eGFybSA8bGludXhhcm1AaHVhd2Vp
LmNvbT47Cj4gPiBzdGV2ZW4ucHJpY2VAYXJtLmNvbTsgR3VvaGFuanVuIChIYW5qdW4gR3VvKSA8
Z3VvaGFuanVuQGh1YXdlaS5jb20+Owo+ID4geWFuZ3lpY29uZyA8eWFuZ3lpY29uZ0BodWF3ZWku
Y29tPjsgU2FtaS5NdWphd2FyQGFybS5jb207Cj4gPiB3YW5naHVpcWlhbmcgPHdhbmdodWlxaWFu
Z0BodWF3ZWkuY29tPgo+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSA3LzhdIGlvbW11L2FybS1z
bW11OiBHZXQgYXNzb2NpYXRlZCBSTVIgaW5mbyBhbmQKPiA+IGluc3RhbGwgYnlwYXNzIFNNUgo+
ID4KPiA+IE9uIDIwMjEtMDUtMjQgMTI6MDIsIFNoYW1lZXIgS29sb3RodW0gd3JvdGU6Cj4gPiA+
IEZyb206IEpvbiBOZXR0bGV0b24gPGpvbkBzb2xpZC1ydW4uY29tPgo+ID4gPgo+ID4gPiBDaGVj
ayBpZiB0aGVyZSBpcyBhbnkgUk1SIGluZm8gYXNzb2NpYXRlZCB3aXRoIHRoZSBkZXZpY2VzIGJl
aGluZAo+ID4gPiB0aGUgU01NVSBhbmQgaWYgYW55LCBpbnN0YWxsIGJ5cGFzcyBTTVJzIGZvciB0
aGVtLiBUaGlzIGlzIHRvCj4gPiA+IGtlZXAgYW55IG9uZ29pbmcgdHJhZmZpYyBhc3NvY2lhdGVk
IHdpdGggdGhlc2UgZGV2aWNlcyBhbGl2ZQo+ID4gPiB3aGVuIHdlIGVuYWJsZS9yZXNldCBTTU1V
IGR1cmluZyBwcm9iZSgpLgo+ID4gPgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKb24gTmV0dGxldG9u
IDxqb25Ac29saWQtcnVuLmNvbT4KPiA+ID4gU2lnbmVkLW9mZi1ieTogU3RldmVuIFByaWNlIDxz
dGV2ZW4ucHJpY2VAYXJtLmNvbT4KPiA+ID4gU2lnbmVkLW9mZi1ieTogU2hhbWVlciBLb2xvdGh1
bQo+ID4gPHNoYW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNvbT4KPiA+ID4gLS0tCj4g
PiA+ICAgZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUvYXJtLXNtbXUuYyB8IDY1Cj4gPiArKysr
KysrKysrKysrKysrKysrKysrKysrKysKPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwgNjUgaW5zZXJ0
aW9ucygrKQo+ID4gPgo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNt
bXUvYXJtLXNtbXUuYwo+ID4gYi9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS9hcm0tc21tdS5j
Cj4gPiA+IGluZGV4IDZmNzJjNGQyMDhjYS4uNTZkYjNkMzIzOGZjIDEwMDY0NAo+ID4gPiAtLS0g
YS9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS9hcm0tc21tdS5jCj4gPiA+ICsrKyBiL2RyaXZl
cnMvaW9tbXUvYXJtL2FybS1zbW11L2FybS1zbW11LmMKPiA+ID4gQEAgLTIwNDIsNiArMjA0Miw2
NyBAQCBlcnJfcmVzZXRfcGxhdGZvcm1fb3BzOiBfX21heWJlX3VudXNlZDsKPiA+ID4gICAgIHJl
dHVybiBlcnI7Cj4gPiA+ICAgfQo+ID4gPgo+ID4gPiArc3RhdGljIHZvaWQgYXJtX3NtbXVfcm1y
X2luc3RhbGxfYnlwYXNzX3NtcihzdHJ1Y3QgYXJtX3NtbXVfZGV2aWNlCj4gPiAqc21tdSkKPiA+
ID4gK3sKPiA+ID4gKyAgIHN0cnVjdCBsaXN0X2hlYWQgcm1yX2xpc3Q7Cj4gPiA+ICsgICBzdHJ1
Y3QgaW9tbXVfcmVzdl9yZWdpb24gKmU7Cj4gPiA+ICsgICBpbnQgaSwgY250ID0gMDsKPiA+ID4g
KyAgIHUzMiBzbXI7Cj4gPiA+ICsgICB1MzIgcmVnOwo+ID4gPiArCj4gPiA+ICsgICBJTklUX0xJ
U1RfSEVBRCgmcm1yX2xpc3QpOwo+ID4gPiArICAgaWYgKGlvbW11X2RtYV9nZXRfcm1ycyhkZXZf
Zndub2RlKHNtbXUtPmRldiksICZybXJfbGlzdCkpCj4gPiA+ICsgICAgICAgICAgIHJldHVybjsK
PiA+ID4gKwo+ID4gPiArICAgcmVnID0gYXJtX3NtbXVfZ3IwX3JlYWQoc21tdSwgQVJNX1NNTVVf
R1IwX3NDUjApOwo+ID4gPiArCj4gPiA+ICsgICBpZiAoKHJlZyAmIEFSTV9TTU1VX3NDUjBfVVNG
Q0ZHKSAmJiAhKHJlZyAmCj4gPiBBUk1fU01NVV9zQ1IwX0NMSUVOVFBEKSkgewo+ID4gPiArICAg
ICAgICAgICAvKgo+ID4gPiArICAgICAgICAgICAgKiBTTU1VIGlzIGFscmVhZHkgZW5hYmxlZCBh
bmQgZGlzYWxsb3dpbmcgYnlwYXNzLCBzbyBwcmVzZXJ2ZQo+ID4gPiArICAgICAgICAgICAgKiB0
aGUgZXhpc3RpbmcgU01Scwo+ID4gPiArICAgICAgICAgICAgKi8KPiA+ID4gKyAgICAgICAgICAg
Zm9yIChpID0gMDsgaSA8IHNtbXUtPm51bV9tYXBwaW5nX2dyb3VwczsgaSsrKSB7Cj4gPiA+ICsg
ICAgICAgICAgICAgICAgICAgc21yID0gYXJtX3NtbXVfZ3IwX3JlYWQoc21tdSwgQVJNX1NNTVVf
R1IwX1NNUihpKSk7Cj4gPgo+ID4gVG8gcmVpdGVyYXRlLCBqdXN0IGJlY2F1c2UgYSBib290bG9h
ZGVyL2NyYXNoZWQga2VybmVsL3doYXRldmVyIG1heSBoYXZlCj4gPiBsZWZ0IHNvbWUgY29uZmln
dXJhdGlvbiBiZWhpbmQgZG9lc24ndCBtZWFuIHRoYXQgaXQgbWF0dGVycyAoZS5nLiB3aGF0Cj4g
PiBpZiB0aGVzZSBTTVJzIGFyZSBwb2ludGluZyBhdCB0cmFuc2xhdGlvbiBjb250ZXh0cz8pLiBB
bGwgd2Ugc2hvdWxkIGJlCj4gPiBkb2luZyBoZXJlIGlzIHNldHRpbmcgdGhlIHJlbGV2YW50IFJN
UiBhY2NvbW1vZGF0aW9ucyBpbiBvdXIgImNsZWFuCj4gPiBzbGF0ZSIgc29mdHdhcmUgc3RhdGUg
YmVmb3JlIHRoZSByZXNldCByb3V0aW5lIGFwcGxpZXMgaXQgdG8gdGhlCj4gPiBoYXJkd2FyZSwg
anVzdCBsaWtlIHBhdGNoICM1IGRvZXMgZm9yIFNNTVV2My4KPiA+Cj4gPiBUcnlpbmcgdG8gc2Fm
ZWx5IHJlc2V0IGFuIFNNTVUgd2hlbiB3ZSBkaXNjb3ZlciBpdCB3aXRoIENMSUVOVFBEPTAgaXMK
PiA+IHJlYWxseSBhbm90aGVyIGlzc3VlIGVudGlyZWx5LCBhbmQgSSdkIHNheSBpcyBiZXlvbmQg
dGhlIHNjb3BlIG9mIHRoaXMKPiA+IHNlcmllcwo+ID4KPiA+ID4gKyAgICAgICAgICAgICAgICAg
ICBpZiAoIUZJRUxEX0dFVChBUk1fU01NVV9TTVJfVkFMSUQsIHNtcikpCj4gPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsKPiA+Cj4gPiBOb3RlIHRoYXQgdGhhdCdzIG5v
dCBldmVuIG5lY2Vzc2FyaWx5IGNvcnJlY3QgKHRoYW5rcyB0byBFWElEUykuCj4gPgo+ID4gPiAr
ICAgICAgICAgICAgICAgICAgIHNtbXUtPnNtcnNbaV0uaWQgPSBGSUVMRF9HRVQoQVJNX1NNTVVf
U01SX0lELCBzbXIpOwo+ID4gPiArICAgICAgICAgICAgICAgICAgIHNtbXUtPnNtcnNbaV0ubWFz
ayA9IEZJRUxEX0dFVChBUk1fU01NVV9TTVJfTUFTSywKPiA+IHNtcik7Cj4gPiA+ICsgICAgICAg
ICAgICAgICAgICAgc21tdS0+c21yc1tpXS52YWxpZCA9IHRydWU7Cj4gPiA+ICsgICAgICAgICAg
IH0KPiA+ID4gKyAgIH0KPiA+ID4gKwo+ID4gPiArICAgbGlzdF9mb3JfZWFjaF9lbnRyeShlLCAm
cm1yX2xpc3QsIGxpc3QpIHsKPiA+ID4gKyAgICAgICAgICAgdTMyIHNpZCA9IGUtPmZ3X2RhdGEu
cm1yLnNpZDsKPiA+ID4gKwo+ID4gPiArICAgICAgICAgICBpID0gYXJtX3NtbXVfZmluZF9zbWUo
c21tdSwgc2lkLCB+MCk7Cj4gPiA+ICsgICAgICAgICAgIGlmIChpIDwgMCkKPiA+ID4gKyAgICAg
ICAgICAgICAgICAgICBjb250aW51ZTsKPiA+ID4gKyAgICAgICAgICAgaWYgKHNtbXUtPnMyY3Jz
W2ldLmNvdW50ID09IDApIHsKPiA+ID4gKyAgICAgICAgICAgICAgICAgICBzbW11LT5zbXJzW2ld
LmlkID0gc2lkOwo+ID4gPiArICAgICAgICAgICAgICAgICAgIHNtbXUtPnNtcnNbaV0ubWFzayA9
IH4wOwo+ID4KPiA+IFRoaXMgaXMgdmVyeSB3cm9uZyAoYXMgaGFzIG5vdyBhbHJlYWR5IGJlZW4g
cG9pbnRlZCBvdXQpLgo+ID4KPiA+ID4gKyAgICAgICAgICAgICAgICAgICBzbW11LT5zbXJzW2ld
LnZhbGlkID0gdHJ1ZTsKPiA+ID4gKyAgICAgICAgICAgfQo+ID4gPiArICAgICAgICAgICBzbW11
LT5zMmNyc1tpXS5jb3VudCsrOwo+ID4gPiArICAgICAgICAgICBzbW11LT5zMmNyc1tpXS50eXBl
ID0gUzJDUl9UWVBFX0JZUEFTUzsKPiA+ID4gKyAgICAgICAgICAgc21tdS0+czJjcnNbaV0ucHJp
dmNmZyA9IFMyQ1JfUFJJVkNGR19ERUZBVUxUOwo+ID4gPiArICAgICAgICAgICBzbW11LT5zMmNy
c1tpXS5jYm5keCA9IDB4ZmY7Cj4gPgo+ID4gTml0OiBjYm5keCBpcyBsZWZ0IHVuaW5pdGlhbGlz
ZWQgZm9yIGJ5cGFzcy9mYXVsdCBlbnRyaWVzIGVsc2V3aGVyZSwgc28KPiA+IHRoZXJlJ3MgbGl0
dGxlIHBvaW50IHRvdWNoaW5nIGl0IGhlcmUuCj4gPgo+ID4gPiArCj4gPiA+ICsgICAgICAgICAg
IGNudCsrOwo+ID4gPiArICAgfQo+ID4gPiArCj4gPiA+ICsgICBpZiAoKHJlZyAmIEFSTV9TTU1V
X3NDUjBfVVNGQ0ZHKSAmJiAhKHJlZyAmCj4gPiBBUk1fU01NVV9zQ1IwX0NMSUVOVFBEKSkgewo+
ID4gPiArICAgICAgICAgICAvKiBSZW1vdmUgdGhlIHZhbGlkIGJpdCBmb3IgdW51c2VkIFNNUnMg
Ki8KPiA+ID4gKyAgICAgICAgICAgZm9yIChpID0gMDsgaSA8IHNtbXUtPm51bV9tYXBwaW5nX2dy
b3VwczsgaSsrKSB7Cj4gPiA+ICsgICAgICAgICAgICAgICAgICAgaWYgKHNtbXUtPnMyY3JzW2ld
LmNvdW50ID09IDApCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBzbW11LT5zbXJz
W2ldLnZhbGlkID0gZmFsc2U7Cj4gPiA+ICsgICAgICAgICAgIH0KPiA+Cj4gPiBJZiB0aGlzIGRh
bmNlIGlzIG9ubHkgYWJvdXQgYXZvaWRpbmcgc3RyZWFtIG1hdGNoIGNvbmZsaWN0cyB3aGVuIHRy
eWluZwo+ID4gdG8gcmVwcm9ncmFtIGxpdmUgU01Scywgc2ltcGx5IHR1cm5pbmcgdGhlIFNNTVUg
b2ZmIGJlZm9yZWhhbmQgd291bGQgYmUKPiA+IGEgbG90IHNpbXBsZXIuCj4KPiBIaSBTdGV2ZS9K
b24sCj4KPiBTaW5jZSBJIGRvbuKAmXQgaGF2ZSBhY2Nlc3MgdG8gYW4gU01NVXYyIHNldHVwLCBy
ZWFsbHkgYXBwcmVjaWF0ZSBpZiBvbmUgb2YgeW91Cj4gY291bGQgcGxlYXNlIHRha2UgYSBsb29r
IGF0IHRoZSBhYm92ZSBjb21tZW50cyBhbmQgcHJvdmlkZSBtZSB3aXRoIGEgdGVzdGVkCj4gY29k
ZSBzbyB0aGF0IEkgY2FuIGluY2x1ZGUgaXQgaW4gdGhlIHY2IHRoYXQgSSBhbSBwbGFubmluZyB0
byBzZW5kIG91dCBzb29uLgoKV2lsbCBkby4gIFRoYW5rcy4KSm9uCgo+Cj4gVGhhbmtzLAo+IFNo
YW1lZXIKPgo+ID4gUm9iaW4uCj4gPgo+ID4gPiArICAgfQo+ID4gPiArCj4gPiA+ICsgICBkZXZf
bm90aWNlKHNtbXUtPmRldiwgIlx0cHJlc2VydmVkICVkIGJvb3QgbWFwcGluZyVzXG4iLCBjbnQs
Cj4gPiA+ICsgICAgICAgICAgICAgIGNudCA9PSAxID8gIiIgOiAicyIpOwo+ID4gPiArICAgaW9t
bXVfZG1hX3B1dF9ybXJzKGRldl9md25vZGUoc21tdS0+ZGV2KSwgJnJtcl9saXN0KTsKPiA+ID4g
K30KPiA+ID4gKwo+ID4gPiAgIHN0YXRpYyBpbnQgYXJtX3NtbXVfZGV2aWNlX3Byb2JlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4gPiA+ICAgewo+ID4gPiAgICAgc3RydWN0IHJlc291
cmNlICpyZXM7Cj4gPiA+IEBAIC0yMTY4LDYgKzIyMjksMTAgQEAgc3RhdGljIGludCBhcm1fc21t
dV9kZXZpY2VfcHJvYmUoc3RydWN0Cj4gPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4gPiA+ICAg
ICB9Cj4gPiA+Cj4gPiA+ICAgICBwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBzbW11KTsKPiA+
ID4gKwo+ID4gPiArICAgLyogQ2hlY2sgZm9yIFJNUnMgYW5kIGluc3RhbGwgYnlwYXNzIFNNUnMg
aWYgYW55ICovCj4gPiA+ICsgICBhcm1fc21tdV9ybXJfaW5zdGFsbF9ieXBhc3Nfc21yKHNtbXUp
Owo+ID4gPiArCj4gPiA+ICAgICBhcm1fc21tdV9kZXZpY2VfcmVzZXQoc21tdSk7Cj4gPiA+ICAg
ICBhcm1fc21tdV90ZXN0X3Ntcl9tYXNrcyhzbW11KTsKPiA+ID4KPiA+ID4KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0Cmlv
bW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
