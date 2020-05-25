Return-Path: <SRS0=eEOj=7H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360A4C433E0
	for <iommu@archiver.kernel.org>; Mon, 25 May 2020 10:51:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F34092073B
	for <iommu@archiver.kernel.org>; Mon, 25 May 2020 10:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHyW8PrU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34092073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9AD0D20343;
	Mon, 25 May 2020 10:51:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B6Z31AX5zAia; Mon, 25 May 2020 10:51:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 818F920035;
	Mon, 25 May 2020 10:51:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F870C0865;
	Mon, 25 May 2020 10:51:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CCF9AC016F
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 10:51:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C618886A3C
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 10:51:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dTvsR0U4Q9RY for <iommu@lists.linux-foundation.org>;
 Mon, 25 May 2020 10:51:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
 [209.85.208.196])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A049886B0E
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 10:51:54 +0000 (UTC)
Received: by mail-lj1-f196.google.com with SMTP id z13so10600363ljn.7
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 03:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XQIdOLJRAwyJ5EbjAztcZMJDAH7v10sKhYh7WWEKDDE=;
 b=GHyW8PrU+iJwHOF0FEHSSkP/VUckZK2wd0Xtqn8bJs31enXxhzhcRZlAzA7f/ZkeHv
 Ri3reeQyEmZ/nTKF4ERTSWCysCRXejtvjTUC3p++uxs0d7ITrrLcN19BqqE9waRXTrwW
 voCBBClvZwgI26ap+9JIBEweeAH9RRCAXjIma1Ek6E+i6Jrwy2NxwKK2U1RUgUMGdnyh
 BuUFIgpfgvNlX5SKbiyiRsQTHXHdNlgGDyvK6OIJ2P4BDwL7kQeA9BB1yqUu3wqWNYev
 kHcj8YNDuujRpn9ovWCyIfgR9bUHhEPis5J6+8vIBxFuBPcGjWQJz2eq03d2iy4wR+ZG
 ZvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XQIdOLJRAwyJ5EbjAztcZMJDAH7v10sKhYh7WWEKDDE=;
 b=fFAlw/jYEnaJQlVVot8zgJfthzR+xhb20h0Q8+VMXtJchSPHlVStnaAPGPyHwrQEWq
 35/XAD2SjAImrOHPcHmegd6x9yyXp9WylZ8dzv/XKZFuPB4U2eFNt6gwkYvnV4WV8Sb8
 LbU8krvFvX9EBwMybbnmNHN69tZ8a16UGGqgud1UrfMlloEWYDyWTBobkPbb0t1ZONl1
 QdBmReVAmo3sms4nSly9PFoI97SjuuPR6Zfkt0qLDBKfHUvR2qUslHaZGNR+yO3dVXe3
 f0VOb/NmS/R12+QQyENiOFW76GA6t/KMWybUC0PzuzJdMml1REzg8qjPTML6bD6C3VqO
 KFEg==
X-Gm-Message-State: AOAM531abOGWCfPArt5LmDeZRYMMAs1nfvSkhEM+ZrP8JeIzmz09vSyY
 gb67xfg4W5U11eJa75mdoP8=
X-Google-Smtp-Source: ABdhPJzxEXhkUYgz7wB2wyVTUOtV+rStTtfu8v79n+/fusca3jSbZEbrqAfNoHeG47DgKC4rlRTt0Q==
X-Received: by 2002:a2e:6a11:: with SMTP id f17mr3222251ljc.328.1590403912651; 
 Mon, 25 May 2020 03:51:52 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-76-17-204.pppoe.mtu-net.ru.
 [91.76.17.204])
 by smtp.googlemail.com with ESMTPSA id i24sm4472114ljg.82.2020.05.25.03.51.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2020 03:51:51 -0700 (PDT)
Subject: Re: [PATCH v1] iommu/tegra-smmu: Add missing locks around mapping
 operations
To: Thierry Reding <thierry.reding@gmail.com>
References: <20200524183755.3774-1-digetx@gmail.com>
 <20200525083556.GA2382769@ulmo>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ffa2f98f-1809-e4f0-009e-d06dcde0ed49@gmail.com>
Date: Mon, 25 May 2020 13:51:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200525083556.GA2382769@ulmo>
Content-Language: en-US
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Jonathan Hunter <jonathanh@nvidia.com>
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

MjUuMDUuMjAyMCAxMTozNSwgVGhpZXJyeSBSZWRpbmcg0L/QuNGI0LXRgjoKPiBPbiBTdW4sIE1h
eSAyNCwgMjAyMCBhdCAwOTozNzo1NVBNICswMzAwLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6Cj4+
IFRoZSBtYXBwaW5nIG9wZXJhdGlvbnMgb2YgdGhlIFRlZ3JhIFNNTVUgZHJpdmVyIGFyZSBzdWJq
ZWN0ZWQgdG8gYSByYWNlCj4+IGNvbmRpdGlvbiBpc3N1ZXMgYmVjYXVzZSBTTU1VIEFkZHJlc3Mg
U3BhY2UgaXNuJ3QgYWxsb2NhdGVkIGFuZCBmcmVlZAo+PiBhdG9taWNhbGx5LCB3aGlsZSBpdCBz
aG91bGQgYmUuIFRoaXMgcGF0Y2ggbWFrZXMgdGhlIG1hcHBpbmcgb3BlcmF0aW9ucwo+PiBhdG9t
aWMsIGl0IGZpeGVzIGFuIGFjY2lkZW50YWxseSByZWxlYXNlZCBIb3N0MXggQWRkcmVzcyBTcGFj
ZSBwcm9ibGVtCj4+IHdoaWNoIGhhcHBlbnMgd2hpbGUgcnVubmluZyBtdWx0aXBsZSBncmFwaGlj
cyB0ZXN0cyBpbiBwYXJhbGxlbCBvbgo+PiBUZWdyYTMwLCBpLmUuIGJ5IGhhdmluZyBtdWx0aXBs
ZSB0aHJlYWRzIHJhY2luZyB3aXRoIGVhY2ggb3RoZXIgaW4gdGhlCj4+IEhvc3QxeCdzIHN1Ym1p
c3Npb24gYW5kIGNvbXBsZXRpb24gY29kZSBwYXRocywgcGVyZm9ybWluZyBJT1ZBIG1hcHBpbmdz
Cj4+IGFuZCB1bm1hcHBpbmdzIGluIHBhcmFsbGVsLgo+Pgo+PiBDYzogPHN0YWJsZUB2Z2VyLmtl
cm5lbC5vcmc+Cj4+IFNpZ25lZC1vZmYtYnk6IERtaXRyeSBPc2lwZW5rbyA8ZGlnZXR4QGdtYWls
LmNvbT4KPj4gLS0tCj4+ICBkcml2ZXJzL2lvbW11L3RlZ3JhLXNtbXUuYyB8IDQzICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tCj4+ICAxIGZpbGUgY2hhbmdlZCwgMzggaW5z
ZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9t
bXUvdGVncmEtc21tdS5jIGIvZHJpdmVycy9pb21tdS90ZWdyYS1zbW11LmMKPj4gaW5kZXggNzQy
NmI3NjY2ZTJiLi40Zjk1NmE3OTc4MzggMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvdGVn
cmEtc21tdS5jCj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvdGVncmEtc21tdS5jCj4+IEBAIC0xMiw2
ICsxMiw3IEBACj4+ICAjaW5jbHVkZSA8bGludXgvb2ZfZGV2aWNlLmg+Cj4+ICAjaW5jbHVkZSA8
bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+Cj4+ICAjaW5jbHVkZSA8bGludXgvc2xhYi5oPgo+PiAr
I2luY2x1ZGUgPGxpbnV4L3NwaW5sb2NrLmg+Cj4+ICAjaW5jbHVkZSA8bGludXgvZG1hLW1hcHBp
bmcuaD4KPj4gIAo+PiAgI2luY2x1ZGUgPHNvYy90ZWdyYS9haGIuaD4KPj4gQEAgLTQ5LDYgKzUw
LDcgQEAgc3RydWN0IHRlZ3JhX3NtbXVfYXMgewo+PiAgCXN0cnVjdCBpb21tdV9kb21haW4gZG9t
YWluOwo+PiAgCXN0cnVjdCB0ZWdyYV9zbW11ICpzbW11Owo+PiAgCXVuc2lnbmVkIGludCB1c2Vf
Y291bnQ7Cj4+ICsJc3BpbmxvY2tfdCBsb2NrOwo+PiAgCXUzMiAqY291bnQ7Cj4+ICAJc3RydWN0
IHBhZ2UgKipwdHM7Cj4+ICAJc3RydWN0IHBhZ2UgKnBkOwo+PiBAQCAtMzA4LDYgKzMxMCw4IEBA
IHN0YXRpYyBzdHJ1Y3QgaW9tbXVfZG9tYWluICp0ZWdyYV9zbW11X2RvbWFpbl9hbGxvYyh1bnNp
Z25lZCB0eXBlKQo+PiAgCQlyZXR1cm4gTlVMTDsKPj4gIAl9Cj4+ICAKPj4gKwlzcGluX2xvY2tf
aW5pdCgmYXMtPmxvY2spOwo+PiArCj4+ICAJLyogc2V0dXAgYXBlcnR1cmUgKi8KPj4gIAlhcy0+
ZG9tYWluLmdlb21ldHJ5LmFwZXJ0dXJlX3N0YXJ0ID0gMDsKPj4gIAlhcy0+ZG9tYWluLmdlb21l
dHJ5LmFwZXJ0dXJlX2VuZCA9IDB4ZmZmZmZmZmY7Cj4+IEBAIC01NzgsNyArNTgyLDcgQEAgc3Rh
dGljIHUzMiAqYXNfZ2V0X3B0ZShzdHJ1Y3QgdGVncmFfc21tdV9hcyAqYXMsIGRtYV9hZGRyX3Qg
aW92YSwKPj4gIAkJc3RydWN0IHBhZ2UgKnBhZ2U7Cj4+ICAJCWRtYV9hZGRyX3QgZG1hOwo+PiAg
Cj4+IC0JCXBhZ2UgPSBhbGxvY19wYWdlKEdGUF9LRVJORUwgfCBfX0dGUF9ETUEgfCBfX0dGUF9a
RVJPKTsKPj4gKwkJcGFnZSA9IGFsbG9jX3BhZ2UoR0ZQX0FUT01JQyB8IF9fR0ZQX0RNQSB8IF9f
R0ZQX1pFUk8pOwo+IAo+IEknbSBub3Qgc3VyZSB0aGlzIGlzIGEgZ29vZCBpZGVhLiBNeSByZWNv
bGxlY3Rpb24gaXMgdGhhdCBHRlBfQVRPTUlDCj4gd2lsbCBhbGxvY2F0ZSBmcm9tIGEgc3BlY2lh
bCByZXNlcnZlZCByZWdpb24gb2YgbWVtb3J5LCB3aGljaCBtYXkgYmUKPiBlYXNpbHkgZXhoYXVz
dGVkLgoKU28gZmFyIEkgaGF2ZW4ndCBub3RpY2VkIGFueSBwcm9ibGVtcy4gV2lsbCBiZSBncmVh
dCBpZiB5b3UgY291bGQKcHJvdmlkZSBtb3JlIGRldGFpbHMgYWJvdXQgdGhlIHBvb2wgc2l6ZSBh
bmQgaG93IHRoaXMgZXhoYXVzdGlvbiBwcm9ibGVtCmNvdWxkIGJlIHJlcHJvZHVjZWQgaW4gcHJh
Y3RpY2UuCgo+IElzIHRoZXJlIGFueSByZWFzb24gd2h5IHdlIG5lZWQgdGhlIHNwaW5sb2NrPyBD
YW4ndCB3ZSB1c2UgYSBtdXRleAo+IGluc3RlYWQ/CgpUaGlzIGlzIHdoYXQgb3RoZXIgSU9NTVUg
ZHJpdmVycyBkby4gSSBndWVzcyBtdXRleCBtaWdodCBiZSB0b28KZXhwZW5zaXZlLCBpdCBtYXkg
Y3JlYXRlIGEgbm90aWNlYWJsZSBjb250ZW50aW9uIHdoaWNoIHlvdSBkb24ndCB3YW50IHRvCmhh
dmUgaW4gYSBjYXNlIG9mIGEgR1BVIHN1Ym1pc3Npb24gY29kZSBwYXRoLgoKSSBhbHNvIHN1c3Bl
Y3QgdGhhdCBkcml2ZXJzIG9mIG90aGVyIHBsYXRmb3JtcyBhcmUgdXNpbmcgSU9NTVUgQVBJIGlu
CmludGVycnVwdCBjb250ZXh0LCBhbHRob3VnaCB0b2RheSB0aGlzIGlzIG5vdCBuZWVkZWQgZm9y
IFRlZ3JhLgoKPj4gIAkJaWYgKCFwYWdlKQo+PiAgCQkJcmV0dXJuIE5VTEw7Cj4+ICAKPj4gQEAg
LTY1NSw4ICs2NTksOSBAQCBzdGF0aWMgdm9pZCB0ZWdyYV9zbW11X3NldF9wdGUoc3RydWN0IHRl
Z3JhX3NtbXVfYXMgKmFzLCB1bnNpZ25lZCBsb25nIGlvdmEsCj4+ICAJc21tdV9mbHVzaChzbW11
KTsKPj4gIH0KPj4gIAo+PiAtc3RhdGljIGludCB0ZWdyYV9zbW11X21hcChzdHJ1Y3QgaW9tbXVf
ZG9tYWluICpkb21haW4sIHVuc2lnbmVkIGxvbmcgaW92YSwKPj4gLQkJCSAgcGh5c19hZGRyX3Qg
cGFkZHIsIHNpemVfdCBzaXplLCBpbnQgcHJvdCwgZ2ZwX3QgZ2ZwKQo+PiArc3RhdGljIGludAo+
PiArdGVncmFfc21tdV9tYXBfbG9ja2VkKHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiwgdW5z
aWduZWQgbG9uZyBpb3ZhLAo+PiArCQkgICAgICBwaHlzX2FkZHJfdCBwYWRkciwgc2l6ZV90IHNp
emUsIGludCBwcm90LCBnZnBfdCBnZnApCj4gCj4gSSB0aGluayBpdCdzIG1vcmUgdHlwaWNhbCB0
byB1c2UgdGhlIF91bmxvY2tlZCBzdWZmaXggZm9yIGZ1bmN0aW9ucyB0aGF0Cj4gZG9uJ3QgdGFr
ZSBhIGxvY2sgdGhlbXNlbHZlcy4KClBlcnNvbmFsbHkgSSBjYW4ndCBmZWVsIHRoZSBkaWZmZXJl
bmNlLiBCb3RoIHZhcmlhbnRzIGFyZSBnb29kIHRvIG1lLiBJCmNhbiByZXBsYWNlIHRoZSBsaXRl
cmFsIHBvc3RmaXggd2l0aCBhIF9fdGVncmFfc21tdSBwcmVmaXgsIHNpbWlsYXJseSB0bwp3aGF0
IHdlIGhhdmUgaW4gdGhlIEdBUlQgZHJpdmVyLCB0byBhdm9pZCBiaWtlc2hlZGRpbmcuCgo+PiAg
ewo+PiAgCXN0cnVjdCB0ZWdyYV9zbW11X2FzICphcyA9IHRvX3NtbXVfYXMoZG9tYWluKTsKPj4g
IAlkbWFfYWRkcl90IHB0ZV9kbWE7Cj4+IEBAIC02ODUsOCArNjkwLDkgQEAgc3RhdGljIGludCB0
ZWdyYV9zbW11X21hcChzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW4sIHVuc2lnbmVkIGxvbmcg
aW92YSwKPj4gIAlyZXR1cm4gMDsKPj4gIH0KPj4gIAo+PiAtc3RhdGljIHNpemVfdCB0ZWdyYV9z
bW11X3VubWFwKHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiwgdW5zaWduZWQgbG9uZyBpb3Zh
LAo+PiAtCQkJICAgICAgIHNpemVfdCBzaXplLCBzdHJ1Y3QgaW9tbXVfaW90bGJfZ2F0aGVyICpn
YXRoZXIpCj4+ICtzdGF0aWMgc2l6ZV90Cj4+ICt0ZWdyYV9zbW11X3VubWFwX2xvY2tlZChzdHJ1
Y3QgaW9tbXVfZG9tYWluICpkb21haW4sIHVuc2lnbmVkIGxvbmcgaW92YSwKPj4gKwkJCXNpemVf
dCBzaXplLCBzdHJ1Y3QgaW9tbXVfaW90bGJfZ2F0aGVyICpnYXRoZXIpCj4+ICB7Cj4+ICAJc3Ry
dWN0IHRlZ3JhX3NtbXVfYXMgKmFzID0gdG9fc21tdV9hcyhkb21haW4pOwo+PiAgCWRtYV9hZGRy
X3QgcHRlX2RtYTsKPj4gQEAgLTcwMiw2ICs3MDgsMzMgQEAgc3RhdGljIHNpemVfdCB0ZWdyYV9z
bW11X3VubWFwKHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiwgdW5zaWduZWQgbG9uZyBpb3Zh
LAo+PiAgCXJldHVybiBzaXplOwo+PiAgfQo+PiAgCj4+ICtzdGF0aWMgaW50IHRlZ3JhX3NtbXVf
bWFwKHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiwgdW5zaWduZWQgbG9uZyBpb3ZhLAo+PiAr
CQkJICBwaHlzX2FkZHJfdCBwYWRkciwgc2l6ZV90IHNpemUsIGludCBwcm90LCBnZnBfdCBnZnAp
Cj4+ICt7Cj4+ICsJc3RydWN0IHRlZ3JhX3NtbXVfYXMgKmFzID0gdG9fc21tdV9hcyhkb21haW4p
Owo+PiArCXVuc2lnbmVkIGxvbmcgZmxhZ3M7Cj4+ICsJaW50IHJldDsKPj4gKwo+PiArCXNwaW5f
bG9ja19pcnFzYXZlKCZhcy0+bG9jaywgZmxhZ3MpOwo+PiArCXJldCA9IHRlZ3JhX3NtbXVfbWFw
X2xvY2tlZChkb21haW4sIGlvdmEsIHBhZGRyLCBzaXplLCBwcm90LCBnZnApOwo+PiArCXNwaW5f
dW5sb2NrX2lycXJlc3RvcmUoJmFzLT5sb2NrLCBmbGFncyk7Cj4+ICsKPj4gKwlyZXR1cm4gcmV0
Owo+PiArfQo+PiArCj4+ICtzdGF0aWMgc2l6ZV90IHRlZ3JhX3NtbXVfdW5tYXAoc3RydWN0IGlv
bW11X2RvbWFpbiAqZG9tYWluLCB1bnNpZ25lZCBsb25nIGlvdmEsCj4+ICsJCQkgICAgICAgc2l6
ZV90IHNpemUsIHN0cnVjdCBpb21tdV9pb3RsYl9nYXRoZXIgKmdhdGhlcikKPj4gK3sKPj4gKwlz
dHJ1Y3QgdGVncmFfc21tdV9hcyAqYXMgPSB0b19zbW11X2FzKGRvbWFpbik7Cj4+ICsJdW5zaWdu
ZWQgbG9uZyBmbGFnczsKPj4gKwo+PiArCXNwaW5fbG9ja19pcnFzYXZlKCZhcy0+bG9jaywgZmxh
Z3MpOwo+PiArCXNpemUgPSB0ZWdyYV9zbW11X3VubWFwX2xvY2tlZChkb21haW4sIGlvdmEsIHNp
emUsIGdhdGhlcik7Cj4+ICsJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmYXMtPmxvY2ssIGZsYWdz
KTsKPj4gKwo+PiArCXJldHVybiBzaXplOwo+PiArfQo+IAo+IFdoeSB0aGUgZXh0cmEgZnVuY3Rp
b25zIGhlcmU/IFdlIG5ldmVyIGNhbGwgbG9ja2VkIHZzLiB1bmxvY2tlZCB2YXJpYW50cwo+IGlu
IHRoZSBkcml2ZXIgYW5kIHRoZSBJT01NVSBmcmFtZXdvcmsgb25seSBoYXMgYSBzaW5nbGUgY2Fs
bGJhY2ssIHNvIEkKPiB0aGluayB0aGUgbG9ja2luZyBjYW4ganVzdCBtb3ZlIGludG8gdGhlIG1h
aW4gaW1wbGVtZW50YXRpb24uCgpCZWNhdXNlIHRoaXMgbWFrZXMgY29kZSBjbGVhbmVyLCBlYXNp
ZXIgdG8gcmVhZCBhbmQgZm9sbG93LiBZb3UgZG9uJ3QKbmVlZCB0byBjYXJlIGFib3V0IGhhbmRs
aW5nIGVycm9yIGNvZGUgcGF0aHMuIFRoaXMgaXMgdGhlIHNhbWUgd2hhdCB3ZQpkbyBpbiB0aGUg
R0FSVCBkcml2ZXIuIFByZXR0eSBtdWNoIGV2ZXJ5IG90aGVyIElPTU1VIGRyaXZlciB1c2UgdGhp
cwpjb2RlIHBhdHRlcm4gYXMgd2VsbC4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2lvbW11
