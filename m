Return-Path: <SRS0=MyXX=DI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2251FC4727E
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 20:33:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E6EC20739
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 20:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ss8dIJh6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6EC20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 11D8F84EDB;
	Thu,  1 Oct 2020 20:33:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ctV2xvqvLBve; Thu,  1 Oct 2020 20:33:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3E73484AA7;
	Thu,  1 Oct 2020 20:33:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2881DC0889;
	Thu,  1 Oct 2020 20:33:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38E3CC0051
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 20:33:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 21D5884EDB
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 20:33:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vy55GgN5T-JI for <iommu@lists.linux-foundation.org>;
 Thu,  1 Oct 2020 20:33:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com
 [209.85.167.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 96C7284AA7
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 20:33:42 +0000 (UTC)
Received: by mail-lf1-f65.google.com with SMTP id y2so188759lfy.10
 for <iommu@lists.linux-foundation.org>; Thu, 01 Oct 2020 13:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=HFskIQxSh3pcFkxZ3RI+nqtU31LBSYrV7T+aRIb+B54=;
 b=ss8dIJh6Gvzh5FabnueDMuIgWAM2w32VQ/xq+kK5CLOYOKw2OlM7XLIsQ0cYHnx5ES
 3BHVFeOTTpJgE2c3Y+V3nC7Gr/aHHuQ11LtIDJRGy2WTI2vZLZ7mkKeY2u3ZqoWLv5Dr
 lrb2tZsmmX2feonsncEhcrza8CMi+IHQL9/28Iz+9TS19gP8TIJMrB9Kcow9NAyjvWFd
 SKY3CU5jcl5YDlpVzxe8TRBPkM6DS97MnwlFKrgCSvVIFROKikpN7OeURpH51mUgrqfw
 9C4xEDaQJPzDvTvsf7BemRUrWsU/cGNvyF6e+3qR9KZ6H8s7UmOqTqIrjd3tIu1HEOmB
 hkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HFskIQxSh3pcFkxZ3RI+nqtU31LBSYrV7T+aRIb+B54=;
 b=VmjRxGsOCosyUoMwoxy5oKgzyQibpBp1F7L/Dq4LGfqbSoJtwyCeW2b/RQW87S98Q3
 ceqh0XYOovlbbeYCC6zDI2rx7MdM6BWCGRN2iAFN+ikKlzh+EvMPRM3MRNYpgEI3g34d
 GkHd6skvBk4FEvMUj8tuEsP6oiVtxMHBmXFQoUVX+Tb/imAB7KhYc7Ls86XDTNrLg6vN
 tiysSIuFqqkTtjtJwdqmpzNEL5CdCAvxnOlO4IK2u2K6Pjwj7HnEnvIh+w6CtaBSo3oH
 rjXLdDP6Slkh4/F3T3RX0CfKaAeZXAfucvhE8QIvc+JykBSJSfYo6sCVgoiZYsuqwR/j
 ullw==
X-Gm-Message-State: AOAM530CFBntLRXYrRbV9viJ8V11jBNGriPsjQDacRr2uAKUm+q4U05w
 n5GI69FS+mHGPfstrjxEhPg=
X-Google-Smtp-Source: ABdhPJyQOTivvirQ4d8xHsycKRqajTI4M3B2EKt9xsYhtahkMy7MbqjV7kf5VuIh77ZWMp3+IjXxLg==
X-Received: by 2002:ac2:4d8e:: with SMTP id g14mr3647566lfe.386.1601584420568; 
 Thu, 01 Oct 2020 13:33:40 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.91.252])
 by smtp.googlemail.com with ESMTPSA id a12sm551799ljk.109.2020.10.01.13.33.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2020 13:33:39 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
To: Nicolin Chen <nicoleotsuka@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>
References: <20200930084258.25493-3-nicoleotsuka@gmail.com>
 <20200930153131.GB3833404@ulmo> <20200930203618.GC2110@Asurada-Nvidia>
 <13746922-0253-cda7-e9ac-2bd20bf1a17f@gmail.com>
 <20200930213244.GA10573@Asurada-Nvidia>
 <5945a63e-79d8-e3ae-ab53-cee8c220ac7d@gmail.com>
 <20201001012630.GA28240@Asurada-Nvidia>
 <72b11925-5857-8ce5-d084-cab01ca1b396@gmail.com>
 <20201001024850.GA28456@Asurada-Nvidia> <20201001102316.GF3919720@ulmo>
 <20201001110425.GB1272@Asurada>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b966844e-4289-3ff0-9512-852f8419a664@gmail.com>
Date: Thu, 1 Oct 2020 23:33:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201001110425.GB1272@Asurada>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, krzk@kernel.org, jonathanh@nvidia.com,
 iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org
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

MDEuMTAuMjAyMCAxNDowNCwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gT24gVGh1LCBPY3Qg
MDEsIDIwMjAgYXQgMTI6MjM6MTZQTSArMDIwMCwgVGhpZXJyeSBSZWRpbmcgd3JvdGU6Cj4gID4g
PiA+Pj4+Pj4gSXQgbG9va3MgdG8gbWUgbGlrZSB0aGUgb25seSByZWFzb24gd2h5IHlvdSBuZWVk
IHRoaXMgbmV3IGdsb2JhbCBBUEkgaXMKPj4+Pj4+Pj4+PiBiZWNhdXNlIFBDSSBkZXZpY2VzIG1h
eSBub3QgaGF2ZSBhIGRldmljZSB0cmVlIG5vZGUgd2l0aCBhIHBoYW5kbGUgdG8KPj4+Pj4+Pj4+
PiB0aGUgSU9NTVUuIEhvd2V2ZXIsIFNNTVUgc3VwcG9ydCBmb3IgUENJIHdpbGwgb25seSBiZSBl
bmFibGVkIGlmIHRoZQo+Pj4+Pj4+Pj4+IHJvb3QgY29tcGxleCBoYXMgYW4gaW9tbXVzIHByb3Bl
cnR5LCByaWdodD8gSW4gdGhhdCBjYXNlLCBjYW4ndCB3ZQo+Pj4+Pj4+Pj4+IHNpbXBseSBkbyBz
b21ldGhpbmcgbGlrZSB0aGlzOgo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4gCWlmIChkZXZfaXNfcGNp
KGRldikpCj4+Pj4+Pj4+Pj4gCQlucCA9IGZpbmRfaG9zdF9icmlkZ2UoZGV2KS0+b2Zfbm9kZTsK
Pj4+Pj4+Pj4+PiAJZWxzZQo+Pj4+Pj4+Pj4+IAkJbnAgPSBkZXYtPm9mX25vZGU7Cj4gCj4+PiBJ
IHBlcnNvbmFsbHkgYW0gbm90IGEgZmFuIG9mIGFkZGluZyBhIHBhdGggZm9yIFBDSSBkZXZpY2Ug
ZWl0aGVyLAo+Pj4gc2luY2UgUENJL0lPTU1VIGNvcmVzIGNvdWxkIGhhdmUgdGFrZW4gY2FyZSBv
ZiBpdCB3aGlsZSB0aGUgc2FtZQo+Pj4gcGF0aCBjYW4ndCBiZSB1c2VkIGZvciBvdGhlciBidXNl
cy4KPj4KPj4gVGhlcmUncyBhbHJlYWR5IHBsZW50eSBvZiBvdGhlciBkcml2ZXJzIHRoYXQgZG8g
c29tZXRoaW5nIHNpbWlsYXIgdG8KPj4gdGhpcy4gVGFrZSBhIGxvb2sgYXQgdGhlIGFybS1zbW11
IGRyaXZlciwgZm9yIGV4YW1wbGUsIHdoaWNoIHNlZW1zIHRvIGJlCj4+IGRvaW5nIGV4YWN0bHkg
dGhlIHNhbWUgdGhpbmcgdG8gZmluZGluZyB0aGUgcmlnaHQgZGV2aWNlIHRyZWUgbm9kZSB0bwo+
PiBsb29rIGF0IChzZWUgZGV2X2dldF9kZXZfbm9kZSgpIGluIGRyaXZlcnMvaW9tbXUvYXJtLXNt
bXUvYXJtLXNtbXUuYykuCj4gCj4gSG1tLi5va2F5Li50aGF0IGlzIHF1aXRlIGNvbnZpbmNpbmcg
dGhlbi4uLgoKTm90IHZlcnkgY29udmluY2luZyB0byBtZS4gSSBkb24ndCBzZWUgYSAicGxlbnR5
IG9mIG90aGVyIGRyaXZlcnMiLAp0aGVyZSBpcyBvbmx5IG9uZSBhcm0tc21tdSBkcml2ZXIuCgpU
aGUgZGV2X2dldF9kZXZfbm9kZSgpIGlzIHVuZGVyIENPTkZJR19BUk1fU01NVV9MRUdBQ1lfRFRf
QklORElOR1MgKCEpLgpHdXlzLCBkb2Vzbid0IGl0IGxvb2sgc3RyYW5nZSB0byB5b3U/IDopCgpU
aGUgYXJtLXNtbXUgZHJpdmVyIGRvZXMgYSBzaW1pbGFyIHRoaW5nIGZvciB0aGUgbW9kZXJuIGJp
bmRpbmdzIHRvIHdoYXQKTmljb2xpbidzIHYzIGlzIGRvaW5nLgoKPj4+IElmIHdlIGNhbid0IGNv
bWUgdG8gYW4gYWdyZWVtZW50IG9uIGdsb2JhbGl6aW5nIG1jIHBvaW50ZXIsIHdvdWxkCj4+PiBp
dCBiZSBwb3NzaWJsZSB0byBwYXNzIHRlZ3JhX21jX2RyaXZlciB0aHJvdWdoIHRlZ3JhX3NtbXVf
cHJvYmUoKQo+Pj4gc28gd2UgY2FuIGNvbnRpbnVlIHRvIHVzZSBkcml2ZXJfZmluZF9kZXZpY2Vf
YnlfZndub2RlKCkgYXMgdjE/Cj4+Pgo+Pj4gdjE6IGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDIw
LzkvMjYvNjgKPj4KPj4gdGVncmFfc21tdV9wcm9iZSgpIGFscmVhZHkgdGFrZXMgYSBzdHJ1Y3Qg
dGVncmFfbWMgKi4gRGlkIHlvdSBtZWFuCj4+IHRlZ3JhX3NtbXVfcHJvYmVfZGV2aWNlKCk/IEkg
ZG9uJ3QgdGhpbmsgd2UgY2FuIGRvIHRoYXQgYmVjYXVzZSBpdCBpc24ndAo+IAo+IEkgd2FzIHNh
eWluZyB0byBoYXZlIGEgZ2xvYmFsIHBhcmVudF9kcml2ZXIgcG9pbnRlcjogc2ltaWxhciB0bwo+
IG15IHYxLCB5ZXQgcmF0aGVyIHRoYW4gImV4dGVybiIgdGhlIHRlZ3JhX21jX2RyaXZlciwgd2Ug
cGFzcyBpdAo+IHRocm91Z2ggZWdyYV9zbW11X3Byb2JlKCkgYW5kIHN0b3JlIGl0IGluIGEgc3Rh
dGljIGdsb2JhbCB2YWx1ZQo+IHNvIGFzIHRvIGNhbGwgdGVncmFfc21tdV9nZXRfYnlfZndub2Rl
KCkgaW4gLT5wcm9iZV9kZXZpY2UoKS4KPiAKPiBUaG91Z2ggSSBhZ3JlZSB0aGF0IGNyZWF0aW5n
IGEgZ2xvYmFsIGRldmljZSBwb2ludGVyIChtYykgbWlnaHQKPiBiZSBjb250cm92ZXJzaWFsLCB5
ZXQgaGF2aW5nIGEgZ2xvYmFsIHBhcmVudF9kcml2ZXIgcG9pbnRlciBtYXkKPiBub3QgYmUgYWdh
aW5zdCB0aGUgcnVsZSwgY29uc2lkZXJpbmcgdGhhdCBpdCBpcyBjb21tb24gaW4gaW9tbXUKPiBk
cml2ZXJzIHRvIGNhbGwgZHJpdmVyX2ZpbmRfZGV2aWNlX2J5X2Z3bm9kZSBpbiBwcm9iZV9kZXZp
Y2UoKS4KCllvdSBkb24ndCBuZWVkIHRoZSBnbG9iYWwgcG9pbnRlciBpZiB5b3UgaGF2ZSBTTU1V
IE9GIG5vZGUuCgpZb3UgY291bGQgYWxzbyBnZXQgZHJpdmVyIHBvaW50ZXIgZnJvbSBtYy0+ZGV2
LT5kcml2ZXIuCgpCdXQgSSBkb24ndCB0aGluayB5b3UgbmVlZCB0byBkbyB0aGlzIGF0IGFsbC4g
VGhlIHByb2JlX2RldmljZSgpIGNvdWxkCmJlIGludm9rZWQgb25seSBmb3IgdGhlIHRlZ3JhX3Nt
bXVfb3BzIGFuZCB0aGVuIHNlZW1zIHlvdSBjb3VsZCB1c2UKZGV2X2lvbW11X3ByaXZfc2V0KCkg
aW4gdGVncmFfc21tdV9vZl94bGF0ZSgpLCBsaWtlIHN1bjUwaS1pb21tdSBkcml2ZXIKZG9lcy4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFp
bGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
