Return-Path: <SRS0=YHJ+=6U=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA66C28CBC
	for <iommu@archiver.kernel.org>; Wed,  6 May 2020 16:11:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01213208DB
	for <iommu@archiver.kernel.org>; Wed,  6 May 2020 16:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E0nSX+bW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01213208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C98F788893;
	Wed,  6 May 2020 16:11:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bu16RT2Yqt4e; Wed,  6 May 2020 16:11:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 34F988888D;
	Wed,  6 May 2020 16:11:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 223C5C0863;
	Wed,  6 May 2020 16:11:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F6F2C0859
 for <iommu@lists.linux-foundation.org>; Wed,  6 May 2020 16:11:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 66DDE8888E
 for <iommu@lists.linux-foundation.org>; Wed,  6 May 2020 16:11:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oUwOU79Lo9vW for <iommu@lists.linux-foundation.org>;
 Wed,  6 May 2020 16:11:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6FE628888D
 for <iommu@lists.linux-foundation.org>; Wed,  6 May 2020 16:11:23 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id x17so2878972wrt.5
 for <iommu@lists.linux-foundation.org>; Wed, 06 May 2020 09:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=ccHp92st48Nd037ITInv0eAdbDDFis00uziuTe+q1ig=;
 b=E0nSX+bW00Ddp0psF0EByfyq8Ni2QAe5pChbjYo2gf+UT/8ZJtOBpIXzDN84y+c/mW
 SUAiVMlkKuJrN6721rsQo3Dt2Q6SeJq/m/pWZSoIajqLx9M2PbEATQmQxVJhIyrleym4
 HSM/59egAF3uD+x6UCA4c3sgAIBdgS1swCEfe5rK5ozv9yFAhJSv/vdwaePVOYk4HYM2
 mN9S2imVEyfCyScRycK9zXbVWaypXbF+Z4ibknJZh8uq41OYYhhZMQv4JKCeq0jkbhDN
 1K/hERkgxHfM23kWxoLzW1YPPLK5/NHIyv3mOQdrQakgJaVV1B4ZdxzqvPkPrAQcHXvn
 CSCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=ccHp92st48Nd037ITInv0eAdbDDFis00uziuTe+q1ig=;
 b=cXzh7WlbgK76+KyFMP3V71aN1M33N0brvVRwdSdPBKrPP/J0GfYjIPyh5HABKDqHbs
 iu57b5WuEeYtZYosJCqXOFurPJVQAZb+yxLtBvp79fU/47NSzIp2C24PJC+VFnsYG/wh
 J1RMuu5OHVPy1+K7T3o5n8ZjTNfRMobQ3YkAOqGccI6g+t9O2/6ZkTouTwIWGMDgSIPi
 VdwTO9bRuz9yQlltDEg++lPhIyfuBBH9EgcK902PFVtZp6p3aHhGedVKMZZjutvaxW6K
 0El5sz/iMqkrqZVW6HgNhGAFaQOWjf4ZnBFkXKKTEdF4R8jRv/qf2s8Jtnp+j+fVoAYa
 QS6A==
X-Gm-Message-State: AGi0Pualdm8XXRtIB1K2WAom/biyCjjZqhOgBkYoqm+08PeSssbmGI0l
 I0zV5ZnppvTN68hifEaHjUADBQ==
X-Google-Smtp-Source: APiQypJTpSAXsnLNWvEdXxkkOJ3qN+jMw/pd1MjvwcFOp53i5/p8QQNNvHzCa+8uFno2u1+sszi2Mg==
X-Received: by 2002:adf:eac6:: with SMTP id o6mr10160494wrn.297.1588781481916; 
 Wed, 06 May 2020 09:11:21 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id x18sm3434942wmi.29.2020.05.06.09.11.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 09:11:21 -0700 (PDT)
Date: Wed, 6 May 2020 18:11:12 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Tuan Phan <tuanphan@amperemail.onmicrosoft.com>
Subject: Re: [PATCH] perf/smmuv3: Allow sharing MMIO registers with the SMMU
 driver
Message-ID: <20200506161112.GA1197429@myrica>
References: <20200421155745.19815-1-jean-philippe@linaro.org>
 <F8C2FB7F-2D21-44AA-B41D-0D4555A63660@amperemail.onmicrosoft.com>
 <20200429072104.GA817954@myrica>
 <D4FCF21C-D514-44F0-82CF-4932C704117B@amperemail.onmicrosoft.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <D4FCF21C-D514-44F0-82CF-4932C704117B@amperemail.onmicrosoft.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gV2VkLCBBcHIgMjksIDIwMjAgYXQgMTE6MDE6MDVBTSAtMDcwMCwgVHVhbiBQaGFuIHdyb3Rl
Ogo+IAo+IAo+ID4gT24gQXByIDI5LCAyMDIwLCBhdCAxMjoyMSBBTSwgSmVhbi1QaGlsaXBwZSBC
cnVja2VyIDxqZWFuLXBoaWxpcHBlQGxpbmFyby5vcmc+IHdyb3RlOgo+ID4gCj4gPiBPbiBUdWUs
IEFwciAyOCwgMjAyMCBhdCAxMToxMDowOUFNIC0wNzAwLCBUdWFuIFBoYW4gd3JvdGU6Cj4gPj4g
SSB0ZXN0ZWQgdGhpcyBwYXRjaCBvbiBIVywgaG93ZXZlciBJIG5lZWQgdG8gYWRkIG9uZSBtb3Jl
IGZvbGxvd2luZyBjaGFuZ2UgdG8gbWFrZSBpdCB3b3Jrcwo+ID4gCj4gPiBUaGFua3MgZm9yIHRl
c3RpbmcuIEkgZG9uJ3QgdW5kZXJzdGFuZCB3aHkgeW91IG5lZWQgdGhlIGNoYW5nZSBiZWxvdwo+
ID4gdGhvdWdoLCBkbyB5b3Uga25vdyB3aGljaCBvdGhlciByZWdpb24gaXMgY29uZmxpY3Rpbmcg
d2l0aCB0aGUgU01NVT8KPiA+IEl0IHNob3VsZCBiZSBkaXNwbGF5ZWQgaW4gdGhlIGVycm9yIG1l
c3NhZ2UgYW5kIC9wcm9jL2lvbWVtLgo+ID4gCj4gPiBUaGFua3MsCj4gPiBKZWFuCj4gCj4gVGhl
IGVycm9yIGlmIEkgZG9u4oCZdCBhcHBseSB0aGF0IHBhdGNoOgo+IFsgICAgNC45NDM2NTVdIGFy
bS1zbW11LXYzIGFybS1zbW11LXYzLjAuYXV0bzogY2FuJ3QgcmVxdWVzdCByZWdpb24gZm9yIHJl
c291cmNlIFttZW0gMHgzYmZmZTAwMDAwMDAtMHgzYmZmZTAwMWZmZmZdCj4gCj4gVGhlIG91dHB1
dCBvZiAvcHJvYy9pb21lbSBmb3IgdGhhdCByZWdpb246Cj4gM2JmZmUwMDAwMDAwLTNiZmZlMDAx
ZmZmZiA6IGFybS1zbW11LXYzLjAuYXV0byAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAKPiAgIDNiZmZlMDAwMjAwMC0zYmZmZTAwMDJmZmYgOiBh
cm0tc21tdS12My1wbWNnLjE3LmF1dG8gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIAo+ICAgM2JmZmUwMDEyMDAwLTNiZmZlMDAxMmZmZiA6IGFybS1zbW11LXYz
LXBtY2cuMTcuYXV0byAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgCgpUaGFua3MgZm9yIHRoaXMuIEl0IGxvb2tzIGxpa2UgdGhlIHJlZ2lvbnMgYXJlIGFkZGVk
IHRvIHRoZSByZXNvdXJjZSB0cmVlCnR3aWNlLCB3aGVuIGJvb3Rpbmcgd2l0aCBBQ1BJOgoKV2hl
biB0aGUgSU9SVCBjcmVhdGVzIHRoZSBwbGF0Zm9ybSBkZXZpY2VzLCBwbGF0Zm9ybV9kZXZpY2Vf
YWRkKCkgaW5zZXJ0cwp0aGVzZSByZXNvdXJjZXMgYnV0IGRvZXNuJ3QgbWFyayB0aGVtIGJ1c3ku
IEFzIEkgd2FzIHRlc3Rpbmcgd2l0aApkZXZpY2V0cmVlIEkgd2FzIG1pc3NpbmcgdGhpcyBzdGVw
LgoKVGhlbiB0aGUgU01NVSBwcm9iZSBjYWxscyBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoKSwgd2hp
Y2ggdHJpZXMgdG8gcmVzZXJ2ZQp0aGUgcmVzb3VyY2VzIGFuZCBtYXJrIHRoZW0gYnVzeSB0aGlz
IHRpbWUuIElmIHRoZXJlIG9ubHkgd2FzIHRoZSBub24tYnVzeQpTTU1VIHJlZ2lvbiBpbnNlcnRl
ZCBhYm92ZSwgdGhlbiBfX3JlcXVlc3RfcmVnaW9uKCkgd291bGQgYWRkcyB0aGUKcmVzZXJ2ZWQg
cmVnaW9uIGFzIGEgY2hpbGQuIEhvd2V2ZXIgc2luY2UgdGhlcmUgYXJlIHNtYWxsZXIgUE1DRyBy
ZWdpb25zCmFzIGNoaWxkcmVuIG9mIHRoZSBTTU1VIHJlZ2lvbiwgX19yZXF1ZXN0X3JlZ2lvbigp
IGZhaWxzLgoKQW5vdGhlciBpZGVhIGlzIHRvIGF2b2lkIG1hcHBpbmcgdGhlIElNUERFRiByZWdp
c3RlcnMgaW4gdGhlIFNNTVUgZHJpdmVyLgpJIHRoaW5rIGl0J3MgbmljZXIsIGFuZCBJJ2xsIHBv
c3QgdGhhdCBwYXRjaCBzaG9ydGx5LgoKVGhhbmtzLApKZWFuCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vaW9tbXU=
