Return-Path: <SRS0=9Lhb=MH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1653C47E48
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 07:31:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65C8961370
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 07:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C8961370
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2F2564060A;
	Thu, 15 Jul 2021 07:31:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bnUp2FhTOTxB; Thu, 15 Jul 2021 07:31:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 032BC400CC;
	Thu, 15 Jul 2021 07:31:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9AAEC0010;
	Thu, 15 Jul 2021 07:31:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE265C000E
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 07:31:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CD2884021D
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 07:31:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sQXHd7bGYDec for <iommu@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 07:31:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CD773400CC
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 07:31:48 +0000 (UTC)
Received: by mail-lj1-x233.google.com with SMTP id 141so7417016ljj.2
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 00:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=K8osTs2DVP81bWLnJgqBO39HigXBsHyE99jXtdAy7Ck=;
 b=e4thDoip3So+zUGXVuZ3czCNeKnmxTKncBRIpcHknmPV8HmNATF4XWuTZzz9r2P7qj
 2EPDtObBuadoHf5lkQYiQGTjXgj9eU5PKQIwtzUmjGsNEhw2crz3FNvxzGWM36a5WFKL
 r/DC7AAvzNPsFJyaLu+Y1J3d35p96DpuLmFcLkMH4GUBDFLRaddIs+BL6WO7wkFx9wyn
 WSGHhacaCcXD8DaGVpauURNumQe/WfKvCWr7+TwOCCgTSFBzYsKuUuvDVsL39YKcsU3R
 yQIeO3QmLwxQ80Hj3WLoCcuTwEdJT+DIg4fUwqORrKuhRyP5VXsInrcgJrBaCU5wffBl
 1NRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=K8osTs2DVP81bWLnJgqBO39HigXBsHyE99jXtdAy7Ck=;
 b=qpcz5+tmW30weVHKr1wFphDqvRSabLAHCASROOqHcDVEI5i+vehmZIVtLg3X69hsrN
 PolJFLGqm7vgAa5sWukBoJBR5t/VduseePjS81bzfDySVDOaKmqkEog3OzPs/Xh8J7Vp
 0mtr8SM3OTmox5FL8Q273bj+RSyGaTPfepnnv6FeFUZBMwjX3y0yauX9Be+C7AuaJl6Z
 q0pufJ/Cyh18J9pTeE9QKQBfpGq7wirApfFYfSMHRm1ij0/PmL3cIW2xytg53iC4F891
 tctzeIe4xXxX/OrSahSDG5/xW8YQiw6ZNwoHiI4S1T+vCsbAtJ401pHYtMqZ73fbpPyp
 T8sg==
X-Gm-Message-State: AOAM532D5xzY0FCcfpyLM6YyGJDsq6br4t2ZZw9Tojc9opFEyflB5OjJ
 Bnj8ku5qIaMf1pJSAh2HyyyiDAoaVEOPFScZLI8=
X-Google-Smtp-Source: ABdhPJzmxqtsUzwbzYkDtsTr2HSTMIkMdacfOEcefezuZ+ZE8STiIZEEO5Kf66+xThd7iXoX0lnDercSzytDWl7FGJY=
X-Received: by 2002:a05:651c:1587:: with SMTP id
 h7mr2639334ljq.285.1626334306805; 
 Thu, 15 Jul 2021 00:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210616154436.GA7619@lst.de>
 <20210622133414.132754-1-rm.skakun@gmail.com>
 <alpine.DEB.2.21.2107131822040.23286@sstabellini-ThinkPad-T480s>
In-Reply-To: <alpine.DEB.2.21.2107131822040.23286@sstabellini-ThinkPad-T480s>
From: Roman Skakun <rm.skakun@gmail.com>
Date: Thu, 15 Jul 2021 10:31:36 +0300
Message-ID: <CADu_u-MxpRVm92yL_d0mWS06KBv_dv6jJ+OHt8KdjsSup_0j5g@mail.gmail.com>
Subject: Re: [PATCH v2] dma-mapping: use vmalloc_to_page for vmalloc addresses
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Juergen Gross <jgross@suse.com>, Andrii Anisov <andrii_anisov@epam.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 linux-kernel@vger.kernel.org,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 iommu@lists.linux-foundation.org, Roman Skakun <roman_skakun@epam.com>,
 xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>
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

SGksIFN0ZWZhbm8hCgo+IFdlIGhhdmUgdGhlIHNhbWUgdGhpbmcgaW4geGVuX3N3aW90bGJfZnJl
ZV9jb2hlcmVudC4gQ2FuIHdlIGZpbmQgYSB3YXkKPiB0byBjYWxsIGNwdV9hZGRyX3RvX3BhZ2Uo
KSBmcm9tIHhlbl9zd2lvdGxiX2ZyZWVfY29oZXJlbnQ/Cj4gTWF5YmUgd2UgY2FuIG1ha2UgY3B1
X2FkZHJfdG9fcGFnZSBub24tc3RhdGljPwoKWWVzLCByaWdodCwgSWYgd2Ugd2FudCB0byByZXVz
ZSB0aGlzIGhlbHBlciBpbnN0ZWFkIG9mIHRoZSBzYW1lIGNvZGUKYmxvY2sgaW4geGVuX3N3aW90
bGJfZnJlZV9jb2hlcmVudCgpIG5lZWQgdG8gbWFrZSBjcHVfYWRkcl90b19wYWdlKCkgYXMKZ2xv
YmFsIGFuZCBhZGQgYSBuZXcgZGVjbGFyYXRpb24gZm9yIHRoaXMgaGVscGVyIGluIGluY2x1ZGUv
bGludXgvZG1hLW1hcC1vcHMuaC4KV2hhdCBkbyB5b3UgdGhpbms/CgpDaGVlcnMhCgrRgdGALCAx
NCDQuNGO0LsuIDIwMjEg0LMuINCyIDA0OjIzLCBTdGVmYW5vIFN0YWJlbGxpbmkgPHNzdGFiZWxs
aW5pQGtlcm5lbC5vcmc+Ogo+Cj4gT24gVHVlLCAyMiBKdW4gMjAyMSwgUm9tYW4gU2tha3VuIHdy
b3RlOgo+ID4gVGhpcyBjb21taXQgaXMgZGVkaWNhdGVkIHRvIGZpeCBpbmNvcnJlY3QgY29udmVy
c2lvbiBmcm9tCj4gPiBjcHVfYWRkciB0byBwYWdlIGFkZHJlc3MgaW4gY2FzZXMgd2hlbiB3ZSBn
ZXQgdmlydHVhbAo+ID4gYWRkcmVzcyB3aGljaCBhbGxvY2F0ZWQgaW4gdGhlIHZtYWxsb2MgcmFu
Z2UuCj4gPiBBcyB0aGUgcmVzdWx0LCB2aXJ0X3RvX3BhZ2UoKSBjYW5ub3QgY29udmVydCB0aGlz
IGFkZHJlc3MKPiA+IHByb3Blcmx5IGFuZCByZXR1cm4gaW5jb3JyZWN0IHBhZ2UgYWRkcmVzcy4K
PiA+Cj4gPiBOZWVkIHRvIGRldGVjdCBzdWNoIGNhc2VzIGFuZCBvYnRhaW5zIHRoZSBwYWdlIGFk
ZHJlc3MgdXNpbmcKPiA+IHZtYWxsb2NfdG9fcGFnZSgpIGluc3RlYWQuCj4gPgo+ID4gU2lnbmVk
LW9mZi1ieTogUm9tYW4gU2tha3VuIDxyb21hbl9za2FrdW5AZXBhbS5jb20+Cj4gPiBSZXZpZXdl
ZC1ieTogQW5kcmlpIEFuaXNvdiA8YW5kcmlpX2FuaXNvdkBlcGFtLmNvbT4KPiA+IC0tLQo+ID4g
SGV5IQo+ID4gVGhhbmtzIGZvciBzdWdnZXN0aW9ucywgQ2hyaXN0b3BoIQo+ID4gSSB1cGRhdGVk
IHRoZSBwYXRjaCBhY2NvcmRpbmcgdG8geW91ciBhZHZpY2UuCj4gPiBCdXQsIEknbSBzbyBzdXJw
cmlzZWQgYmVjYXVzZSBub2JvZHkgY2F0Y2hlcyB0aGlzIHByb2JsZW0KPiA+IGluIHRoZSBjb21t
b24gY29kZSBiZWZvcmUuIEl0IGxvb2tzIGEgYml0IHN0cmFuZ2UgYXMgZm9yIG1lLgo+ID4KPiA+
Cj4gPiAga2VybmVsL2RtYS9vcHNfaGVscGVycy5jIHwgMTIgKysrKysrKysrKy0tCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gPgo+ID4gZGlm
ZiAtLWdpdCBhL2tlcm5lbC9kbWEvb3BzX2hlbHBlcnMuYyBiL2tlcm5lbC9kbWEvb3BzX2hlbHBl
cnMuYwo+ID4gaW5kZXggOTEwYWU2OWNhZTc3Li43ODI3MjhkOGEzOTMgMTAwNjQ0Cj4gPiAtLS0g
YS9rZXJuZWwvZG1hL29wc19oZWxwZXJzLmMKPiA+ICsrKyBiL2tlcm5lbC9kbWEvb3BzX2hlbHBl
cnMuYwo+ID4gQEAgLTUsNiArNSwxNCBAQAo+ID4gICAqLwo+ID4gICNpbmNsdWRlIDxsaW51eC9k
bWEtbWFwLW9wcy5oPgo+ID4KPiA+ICtzdGF0aWMgc3RydWN0IHBhZ2UgKmNwdV9hZGRyX3RvX3Bh
Z2Uodm9pZCAqY3B1X2FkZHIpCj4gPiArewo+ID4gKyAgICAgaWYgKGlzX3ZtYWxsb2NfYWRkcihj
cHVfYWRkcikpCj4gPiArICAgICAgICAgICAgIHJldHVybiB2bWFsbG9jX3RvX3BhZ2UoY3B1X2Fk
ZHIpOwo+ID4gKyAgICAgZWxzZQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gdmlydF90b19wYWdl
KGNwdV9hZGRyKTsKPiA+ICt9Cj4KPiBXZSBoYXZlIHRoZSBzYW1lIHRoaW5nIGluIHhlbl9zd2lv
dGxiX2ZyZWVfY29oZXJlbnQuIENhbiB3ZSBmaW5kIGEgd2F5Cj4gdG8gY2FsbCBjcHVfYWRkcl90
b19wYWdlKCkgZnJvbSB4ZW5fc3dpb3RsYl9mcmVlX2NvaGVyZW50PyBNYXliZSB3ZSBjYW4KPiBt
YWtlIGNwdV9hZGRyX3RvX3BhZ2Ugbm9uLXN0YXRpYz8gTm8gcHJvYmxlbSBpZiBpdCBpcyB0b28g
bXVjaCB0cm91YmxlLgo+Cj4KPiA+ICAvKgo+ID4gICAqIENyZWF0ZSBzY2F0dGVyLWxpc3QgZm9y
IHRoZSBhbHJlYWR5IGFsbG9jYXRlZCBETUEgYnVmZmVyLgo+ID4gICAqLwo+ID4gQEAgLTEyLDcg
KzIwLDcgQEAgaW50IGRtYV9jb21tb25fZ2V0X3NndGFibGUoc3RydWN0IGRldmljZSAqZGV2LCBz
dHJ1Y3Qgc2dfdGFibGUgKnNndCwKPiA+ICAgICAgICAgICAgICAgIHZvaWQgKmNwdV9hZGRyLCBk
bWFfYWRkcl90IGRtYV9hZGRyLCBzaXplX3Qgc2l6ZSwKPiA+ICAgICAgICAgICAgICAgIHVuc2ln
bmVkIGxvbmcgYXR0cnMpCj4gPiAgewo+ID4gLSAgICAgc3RydWN0IHBhZ2UgKnBhZ2UgPSB2aXJ0
X3RvX3BhZ2UoY3B1X2FkZHIpOwo+ID4gKyAgICAgc3RydWN0IHBhZ2UgKnBhZ2UgPSBjcHVfYWRk
cl90b19wYWdlKGNwdV9hZGRyKTsKPiA+ICAgICAgIGludCByZXQ7Cj4gPgo+ID4gICAgICAgcmV0
ID0gc2dfYWxsb2NfdGFibGUoc2d0LCAxLCBHRlBfS0VSTkVMKTsKPiA+IEBAIC00Myw3ICs1MSw3
IEBAIGludCBkbWFfY29tbW9uX21tYXAoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3Qgdm1fYXJl
YV9zdHJ1Y3QgKnZtYSwKPiA+ICAgICAgICAgICAgICAgcmV0dXJuIC1FTlhJTzsKPiA+Cj4gPiAg
ICAgICByZXR1cm4gcmVtYXBfcGZuX3JhbmdlKHZtYSwgdm1hLT52bV9zdGFydCwKPiA+IC0gICAg
ICAgICAgICAgICAgICAgICBwYWdlX3RvX3Bmbih2aXJ0X3RvX3BhZ2UoY3B1X2FkZHIpKSArIHZt
YS0+dm1fcGdvZmYsCj4gPiArICAgICAgICAgICAgICAgICAgICAgcGFnZV90b19wZm4oY3B1X2Fk
ZHJfdG9fcGFnZShjcHVfYWRkcikpICsgdm1hLT52bV9wZ29mZiwKPiA+ICAgICAgICAgICAgICAg
ICAgICAgICB1c2VyX2NvdW50IDw8IFBBR0VfU0hJRlQsIHZtYS0+dm1fcGFnZV9wcm90KTsKPiA+
ICAjZWxzZQo+ID4gICAgICAgcmV0dXJuIC1FTlhJTzsKPiA+IC0tCj4gPiAyLjI1LjEKPiA+CgoK
Ci0tIApCZXN0IFJlZ2FyZHMsIFJvbWFuLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vaW9tbXU=
