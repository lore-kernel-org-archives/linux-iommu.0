Return-Path: <SRS0=eGnl=LK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4814DC48BE5
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 20:50:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9D0B6128C
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 20:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9D0B6128C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A1C6183CA3;
	Wed, 16 Jun 2021 20:50:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Llj6iIAl4paY; Wed, 16 Jun 2021 20:50:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E82F0839A4;
	Wed, 16 Jun 2021 20:50:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BCCC1C000E;
	Wed, 16 Jun 2021 20:50:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7DD22C000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 20:50:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6586C83C9F
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 20:50:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g8mcguncJkPH for <iommu@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 20:50:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 70C1F839A4
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 20:50:11 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 w23-20020a9d5a970000b02903d0ef989477so3874841oth.9
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 13:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=0e8lLquy/RoPIexchfl/Dy42UhNJgpKcJRp8OKOo2mw=;
 b=lREE4F/+u3tfPzBJr/PWSAFl0A5hPQXvj5qk3D3NfohfrrusmynYlYzihuvLTf1Ah6
 aAwPfXpzge+KtBAKPenQbhWZzF4JCVeiibIwoCHJYNkC+OQbPbkqGKXvzCn150+lTRX6
 OsuAMohC8wjnFK7rcH9pA6KG+8ss9IRUNaV85BDL05E7Ki0ZAU8nYHoYCdGliC6nCsZW
 PZ9BFkX68xitJHTXA0Jp7HYLLVJmsRxxrywbylFtfd1RcYfjB/LxlfaYfGuqo+1waUy6
 2LBOIu2pf/Y8Gu1DLg8FJPHALESWktoNesF4Sp5gt9X1JZnzpO6hy+WpViYcbTjEzjLy
 VmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0e8lLquy/RoPIexchfl/Dy42UhNJgpKcJRp8OKOo2mw=;
 b=Wl8SjPFINbHdx19+gaWFoRNjkEgkxEuZM6plkx7zBNpUBGzXgXSPAsHP/Z4w8MGBK/
 qjt1jaVSqRP85uT5vKmN+npxcY+lJcy34m3UBk8nev7mSY0BjAcyQhnaK1mw4wyGhM/3
 5IKI7yV95ls1gaidhlCmBp+jtpdXbWHy3IQ4DwIPnxvbcNoSi8gLAsAIqHKx3AzQ8iF2
 cHTkj8OKNHXuyLQV2nBB875fQVCl4tJ+2ua133gkeE0zTfCgyU9pvSJ0aXOa2CvC7q2Q
 Xy68YB3T8mRwW0LNaHwcXygo9cYI0Uhop9fMFWBDOiDMJ1Kk0RgPuTNVAC0BsgGM/dyu
 E4Rg==
X-Gm-Message-State: AOAM531MRx67euWC9ndU8iuPaRk44d4hUEDqdu2qBEQNCrpH+mfHu62O
 oOuEHYUYq5JThwjBmN4LDts0GOItnd6WTbqlBHxE1Q==
X-Google-Smtp-Source: ABdhPJxlW2IfgGoCEId2VA9mgQdRrEJsE5cGXrU6XetkrHInBTk/URpCE1qYtWk8Tfw45jq9OfaYsqrLxExbzsq1IsA=
X-Received: by 2002:a9d:1b41:: with SMTP id l59mr1541479otl.8.1623876605241;
 Wed, 16 Jun 2021 13:50:05 -0700 (PDT)
MIME-Version: 1.0
References: <YDkbCHHBUOmfI59K@Konrads-MacBook-Pro.local>
 <YL7XXNOnbaDgmTB9@atmark-techno.com>
 <2e899de2-4b69-c4b6-33a6-09fb8949d2fd@nxp.com> <20210611062153.GA30906@lst.de>
 <YMM8Ua0HMmErLIQg@0xbeefdead.lan>
In-Reply-To: <YMM8Ua0HMmErLIQg@0xbeefdead.lan>
Date: Wed, 16 Jun 2021 13:49:54 -0700
Message-ID: <CAMGD6P1v2JoJoxSuAYL8UjdtCaLCc4K_7xzVkumspeb0qn=LBQ@mail.gmail.com>
Subject: Re: swiotlb/caamjr regression (Was: [GIT PULL] (swiotlb)
 stable/for-linus-5.12)
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Dominique MARTINET <dominique.martinet@atmark-techno.com>,
 Aymen Sghaier <aymen.sghaier@nxp.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
 Marc Orr <marcorr@google.com>, Lukas Hartmann <lukas@mntmn.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 Peter Gonda <pgonda@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>
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
From: Jianxiong Gao via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jianxiong Gao <jxgao@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gRnJpLCBKdW4gMTEsIDIwMjEgYXQgMzozNSBBTSBLb25yYWQgUnplc3p1dGVrIFdpbGsKPGtv
bnJhZC53aWxrQG9yYWNsZS5jb20+IHdyb3RlOgo+Cj4gT24gRnJpLCBKdW4gMTEsIDIwMjEgYXQg
MDg6MjE6NTNBTSArMDIwMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gPiBPbiBUaHUsIEp1
biAxMCwgMjAyMSBhdCAwNTo1MjowN1BNICswMzAwLCBIb3JpYSBHZWFudMSDIHdyb3RlOgo+ID4g
PiBJJ3ZlIG5vdGljZWQgdGhlIGZhaWx1cmUgYWxzbyBpbiB2NS4xMCBhbmQgdjUuMTEgc3RhYmxl
IGtlcm5lbHMsCj4gPiA+IHNpbmNlIHRoZSBwYXRjaCBzZXQgaGFzIGJlZW4gYmFja3BvcnRlZC4K
PiA+Cj4gPiBGWUksIHRoZXJlIGhhcyBiZWVuIGEgcGF0Y2ggb24gdGhlIGxpc3QgdGhhdCBzaG91
bGQgaGF2ZSBmaXhlZCB0aGlzCj4gPiBmb3IgYWJvdXQgYSBtb250aDoKPiA+Cj4gPiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9saW51eC1pb21tdS8yMDIxMDUxMDA5MTgxNi5HQTIwODRAbHN0LmRl
L1QvI20wZDBkZjY0OTAzNTBhMDhkY2MyNGM5MDg2YzhlZGMxNjViNDAyZDZmCj4gPgo+ID4gYnV0
IGl0IHNlZW1zIGxpa2UgaXQgbmV2ZXIgZ290IHBpY2tlZCB1cC4KPgo+IEppYW54aW9uZywKPiBX
b3VsZCB5b3UgYmUgdXAgZm9yIHRlc3RpbmcgdGhpcyBwYXRjaCBvbiB5b3VyIE5WTWUgcmlnIHBs
ZWFzZT8gSSBkb24ndAo+IGZvcnNlZSBhIHByb2JsZW0uLiBidXQganVzdCBpbiBjYXNlCj4KSSBo
YXZlIHRlc3RlZCB0aGUgYXR0YWNoZWQgcGF0Y2ggYW5kIGl0IGdlbmVyYXRlcyBhbiBlcnJvciB3
aGVuCmZvcm1hdHRpbmcgYSBkaXNrIHRvIHhmcyBmb3JtYXQgaW4gUmhlbCA4IGVudmlyb25tZW50
OgoKc3VkbyBta2ZzLnhmcyAtZiAvZGV2L252bWUwbjIKbWV0YS1kYXRhPS9kZXYvbnZtZTBuMiAg
ICAgICAgICAgaXNpemU9NTEyICAgIGFnY291bnQ9NCwgYWdzaXplPTMyNzY4MDAwIGJsa3MKICAg
ICAgICAgPSAgICAgICAgICAgICAgICAgICAgICAgc2VjdHN6PTUxMiAgIGF0dHI9MiwgcHJvamlk
MzJiaXQ9MQogICAgICAgICA9ICAgICAgICAgICAgICAgICAgICAgICBjcmM9MSAgICAgICAgZmlu
b2J0PTEsIHNwYXJzZT0xLCBybWFwYnQ9MAogICAgICAgICA9ICAgICAgICAgICAgICAgICAgICAg
ICByZWZsaW5rPTEKZGF0YSAgICAgPSAgICAgICAgICAgICAgICAgICAgICAgYnNpemU9NDA5NiAg
IGJsb2Nrcz0xMzEwNzIwMDAsIGltYXhwY3Q9MjUKICAgICAgICAgPSAgICAgICAgICAgICAgICAg
ICAgICAgc3VuaXQ9MCAgICAgIHN3aWR0aD0wIGJsa3MKbmFtaW5nICAgPXZlcnNpb24gMiAgICAg
ICAgICAgICAgYnNpemU9NDA5NiAgIGFzY2lpLWNpPTAsIGZ0eXBlPTEKbG9nICAgICAgPWludGVy
bmFsIGxvZyAgICAgICAgICAgYnNpemU9NDA5NiAgIGJsb2Nrcz02NDAwMCwgdmVyc2lvbj0yCiAg
ICAgICAgID0gICAgICAgICAgICAgICAgICAgICAgIHNlY3Rzej01MTIgICBzdW5pdD0wIGJsa3Ms
IGxhenktY291bnQ9MQpyZWFsdGltZSA9bm9uZSAgICAgICAgICAgICAgICAgICBleHRzej00MDk2
ICAgYmxvY2tzPTAsIHJ0ZXh0ZW50cz0wCkRpc2NhcmRpbmcgYmxvY2tzLi4uRG9uZS4KYmFkIG1h
Z2ljIG51bWJlcgpiYWQgbWFnaWMgbnVtYmVyCk1ldGFkYXRhIGNvcnJ1cHRpb24gZGV0ZWN0ZWQg
YXQgMHg1NjIxMWRlNGMwYzgsIHhmc19zYiBibG9jayAweDAvMHgyMDAKbGlieGZzX3dyaXRlYnVm
cjogd3JpdGUgdmVyaWZlciBmYWlsZWQgb24geGZzX3NiIGJubyAweDAvMHgyMDAKcmVsZWFzaW5n
IGRpcnR5IGJ1ZmZlciAoYnVsaykgdG8gZnJlZSBsaXN0IQoKSSBhcHBsaWVkIHRoZSBwYXRjaCBv
biBjb21taXQgMDZhZjg2Nzk0NDlkLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vaW9tbXU=
