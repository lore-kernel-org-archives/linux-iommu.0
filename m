Return-Path: <SRS0=Fz8+=DJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE40C4727E
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 01:55:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D8D320719
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 01:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdI/iOqz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D8D320719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B77AA86C5C;
	Fri,  2 Oct 2020 01:55:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5r6ut-X-ZyZb; Fri,  2 Oct 2020 01:55:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C8B1786C51;
	Fri,  2 Oct 2020 01:55:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9E86C016F;
	Fri,  2 Oct 2020 01:55:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 52037C0051
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 01:55:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 39FEF8658A
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 01:55:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FO5G1FlrTGwx for <iommu@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 01:55:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com
 [209.85.167.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 39C9286582
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 01:55:38 +0000 (UTC)
Received: by mail-lf1-f68.google.com with SMTP id z19so994141lfr.4
 for <iommu@lists.linux-foundation.org>; Thu, 01 Oct 2020 18:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=d/jfnZjmPSZbXLzxLJUrhHvktSEChDG0ruelVh2We8c=;
 b=LdI/iOqzsh13yR+VtuzO5yEQdwQy024GjCcCbyf+w2DbfWV7HQ+NR8DVHD23jb4u7x
 9aPYdNB0OzUjhYJHpUTiHpZaY0w2JyH8B7vu/CdpuGunG6i1bET8xz4DekLksx3I+2xJ
 55RTXzVIYJDwfSPL9+TpkRhXvnxlRHSWuoN+lM/0o/f8VqpT53dNetC4KMIwyk7ErCQz
 t/NMlDDH2MrTBCijVpD6LQZM1A/pii8sAwK3tALZ008ZeQck9ilF0f292vq0UNmHqsxy
 BB/GiJlHA7Bafhs5aUdiPGF62skA84mp6hlmfTViyM7MPTCbWl2jeMMFvNew1HXDynFZ
 D6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=d/jfnZjmPSZbXLzxLJUrhHvktSEChDG0ruelVh2We8c=;
 b=MyiCz6ODKU+DzR+g3Oj/y/FmAIrMWKN+p4HUl6XHEtS3O+3Zk7AeQQzShtF0vCq7zq
 RNdz4zpWpKbnmFmY6PGAu9iG5niKAMuN1BQUdMjJPbciY82s2J3pI2OqQnY5qYtaKk+p
 UOj5036oOWVm22IEigfPL/Pv0DKLSlAkcS+oiHf9RpF373506rWcxE9mN7zpjWaPZwcT
 Pf27yf38j4dlDfgHgng5mdJdAUmq8H93pNod7oCuS7fSWXh+gZ4F3THNhmJU2LDD+ajp
 5x6Ty/qUUxV9CoJGYVESICAGtkIrGXZMv9/EJuzSh6SLXGx2ZEviVxw1+P5nIjNMZphu
 GXlg==
X-Gm-Message-State: AOAM5305IGJr0fpLIlKHBw1+zUp1N2kIAxYRhJbTBLaW7lkx8k1m+wSo
 M/xPlSZDOA6ZKdAuIVoJL6k=
X-Google-Smtp-Source: ABdhPJxfEc+BUt81l+JJuVcWI5Lb0o0GFy5kc1x+mWl7WPZIkagzwp+mAGXufL5S8bLXzD9Sn03dzw==
X-Received: by 2002:a19:52:: with SMTP id 79mr979lfa.222.1601603736179;
 Thu, 01 Oct 2020 18:55:36 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-252.nat.spd-mgts.ru.
 [109.252.91.252])
 by smtp.googlemail.com with ESMTPSA id j7sm7661lfb.41.2020.10.01.18.55.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2020 18:55:35 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
To: Nicolin Chen <nicoleotsuka@gmail.com>
References: <20200930203618.GC2110@Asurada-Nvidia>
 <13746922-0253-cda7-e9ac-2bd20bf1a17f@gmail.com>
 <20200930213244.GA10573@Asurada-Nvidia>
 <5945a63e-79d8-e3ae-ab53-cee8c220ac7d@gmail.com>
 <20201001012630.GA28240@Asurada-Nvidia>
 <72b11925-5857-8ce5-d084-cab01ca1b396@gmail.com>
 <20201001024850.GA28456@Asurada-Nvidia> <20201001102316.GF3919720@ulmo>
 <20201001110425.GB1272@Asurada>
 <b966844e-4289-3ff0-9512-852f8419a664@gmail.com>
 <20201002010751.GA26971@Asurada-Nvidia>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1b621b9d-cdc3-c7aa-2fa2-d728ae2bbc5d@gmail.com>
Date: Fri, 2 Oct 2020 04:55:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201002010751.GA26971@Asurada-Nvidia>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 krzk@kernel.org, jonathanh@nvidia.com,
 Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org
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

MDIuMTAuMjAyMCAwNDowNywgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gT24gVGh1LCBPY3Qg
MDEsIDIwMjAgYXQgMTE6MzM6MzhQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+Pj4+
PiBJZiB3ZSBjYW4ndCBjb21lIHRvIGFuIGFncmVlbWVudCBvbiBnbG9iYWxpemluZyBtYyBwb2lu
dGVyLCB3b3VsZAo+Pj4+PiBpdCBiZSBwb3NzaWJsZSB0byBwYXNzIHRlZ3JhX21jX2RyaXZlciB0
aHJvdWdoIHRlZ3JhX3NtbXVfcHJvYmUoKQo+Pj4+PiBzbyB3ZSBjYW4gY29udGludWUgdG8gdXNl
IGRyaXZlcl9maW5kX2RldmljZV9ieV9md25vZGUoKSBhcyB2MT8KPj4+Pj4KPj4+Pj4gdjE6IGh0
dHBzOi8vbGttbC5vcmcvbGttbC8yMDIwLzkvMjYvNjgKPj4+Pgo+Pj4+IHRlZ3JhX3NtbXVfcHJv
YmUoKSBhbHJlYWR5IHRha2VzIGEgc3RydWN0IHRlZ3JhX21jICouIERpZCB5b3UgbWVhbgo+Pj4+
IHRlZ3JhX3NtbXVfcHJvYmVfZGV2aWNlKCk/IEkgZG9uJ3QgdGhpbmsgd2UgY2FuIGRvIHRoYXQg
YmVjYXVzZSBpdCBpc24ndAo+Pj4KPj4+IEkgd2FzIHNheWluZyB0byBoYXZlIGEgZ2xvYmFsIHBh
cmVudF9kcml2ZXIgcG9pbnRlcjogc2ltaWxhciB0bwo+Pj4gbXkgdjEsIHlldCByYXRoZXIgdGhh
biAiZXh0ZXJuIiB0aGUgdGVncmFfbWNfZHJpdmVyLCB3ZSBwYXNzIGl0Cj4+PiB0aHJvdWdoIGVn
cmFfc21tdV9wcm9iZSgpIGFuZCBzdG9yZSBpdCBpbiBhIHN0YXRpYyBnbG9iYWwgdmFsdWUKPj4+
IHNvIGFzIHRvIGNhbGwgdGVncmFfc21tdV9nZXRfYnlfZndub2RlKCkgaW4gLT5wcm9iZV9kZXZp
Y2UoKS4KPj4+Cj4+PiBUaG91Z2ggSSBhZ3JlZSB0aGF0IGNyZWF0aW5nIGEgZ2xvYmFsIGRldmlj
ZSBwb2ludGVyIChtYykgbWlnaHQKPj4+IGJlIGNvbnRyb3ZlcnNpYWwsIHlldCBoYXZpbmcgYSBn
bG9iYWwgcGFyZW50X2RyaXZlciBwb2ludGVyIG1heQo+Pj4gbm90IGJlIGFnYWluc3QgdGhlIHJ1
bGUsIGNvbnNpZGVyaW5nIHRoYXQgaXQgaXMgY29tbW9uIGluIGlvbW11Cj4+PiBkcml2ZXJzIHRv
IGNhbGwgZHJpdmVyX2ZpbmRfZGV2aWNlX2J5X2Z3bm9kZSBpbiBwcm9iZV9kZXZpY2UoKS4KPj4K
Pj4gWW91IGRvbid0IG5lZWQgdGhlIGdsb2JhbCBwb2ludGVyIGlmIHlvdSBoYXZlIFNNTVUgT0Yg
bm9kZS4KPj4KPj4gWW91IGNvdWxkIGFsc28gZ2V0IGRyaXZlciBwb2ludGVyIGZyb20gbWMtPmRl
di0+ZHJpdmVyLgo+Pgo+PiBCdXQgSSBkb24ndCB0aGluayB5b3UgbmVlZCB0byBkbyB0aGlzIGF0
IGFsbC4gVGhlIHByb2JlX2RldmljZSgpIGNvdWxkCj4+IGJlIGludm9rZWQgb25seSBmb3IgdGhl
IHRlZ3JhX3NtbXVfb3BzIGFuZCB0aGVuIHNlZW1zIHlvdSBjb3VsZCB1c2UKPj4gZGV2X2lvbW11
X3ByaXZfc2V0KCkgaW4gdGVncmFfc21tdV9vZl94bGF0ZSgpLCBsaWtlIHN1bjUwaS1pb21tdSBk
cml2ZXIKPj4gZG9lcy4KPiAKPiBHZXR0aW5nIGlvbW11IGRldmljZSBwb2ludGVyIHVzaW5nIGRy
aXZlcl9maW5kX2RldmljZV9ieV9md25vZGUoKQo+IGlzIGEgY29tbW9uIHByYWN0aWNlIGluIC0+
cHJvYmVfZGV2aWNlKCkgb2Ygb3RoZXIgaW9tbXUgZHJpdmVycy4KClBsZWFzZSBnaXZlIG1lIGEg
ZnVsbCBsaXN0IG9mIHRoZSBJT01NVSBkcml2ZXJzIHdoaWNoIHVzZSB0aGlzIG1ldGhvZC4KCj4g
QnV0IHRoaXMgcmVxdWlyZXMgYSBkZXZpY2VfZHJpdmVyIHBvaW50ZXIgdGhhdCB0ZWdyYS1zbW11
IGRvZXNuJ3QKPiBoYXZlLiBTbyBwYXNzaW5nIHRlZ3JhX21jX2RyaXZlciB0aHJvdWdoIHRlZ3Jh
X3NtbXVfcHJvYmUoKSB3aWxsCj4gYWRkcmVzcyBpdC4KPiAKCklmIHlvdSdyZSBib3Jyb3dpbmcg
Y29kZSBhbmQgaWRlYXMgZnJvbSBvdGhlciBkcml2ZXJzLCB0aGVuIGF0IGxlYXN0CnBsZWFzZSBi
b3Jyb3cgdGhlbSBmcm9tIGEgbW9kZXJuIGdvb2QtbG9va2luZyBkcml2ZXJzLiBBbmQgSSBhbHJl
YWR5CnBvaW50ZWQgb3V0IHRoYXQgZm9sbG93aW5nIGNhcmdvIGN1bHQgaXMgbm90IGFsd2F5cyBh
IGdvb2QgaWRlYS4KCkFSTS1TTU1VIGlzbid0IGEgbW9kZXJuIGRyaXZlciBhbmQgaXQgaGFzIGxl
Z2FjeSBjb2RlLiBZb3Ugc2hvdWxkbid0CmNvcHkgaXQgYmxpbmRseS4gVGhlIHN1bjUwaS1pb21t
dSBkcml2ZXIgd2FzIGFkZGVkIGhhbGYgeWVhciBhZ28sIHlvdQptYXkgdXNlIGl0IGFzIGEgcmVm
ZXJlbmNlLgoKQWx3YXlzIGNvbnN1bHQgdGhlIElPTU1VIGNvcmUgY29kZS4gSWYgeW91J3JlIHRv
byB1bnN1cmUgYWJvdXQKc29tZXRoaW5nLCB0aGVuIG1heWJlIGJldHRlciB0byBzdGFydCBhIG5l
dyB0aHJlYWQgYW5kIGFzayBKb2VyZyBhYm91dAp0aGUgYmVzdCBtb2Rlcm4gcHJhY3RpY2VzIHRo
YXQgSU9NTVUgZHJpdmVycyBzaG91bGQgdXNlLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vaW9tbXU=
