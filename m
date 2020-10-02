Return-Path: <SRS0=Fz8+=DJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5898EC4727E
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 03:00:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B39D1206DB
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 03:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oSpUgx3P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B39D1206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4992086BEA;
	Fri,  2 Oct 2020 03:00:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 90ovYUb1JM4g; Fri,  2 Oct 2020 03:00:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8BD0D86B94;
	Fri,  2 Oct 2020 03:00:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F46BC0889;
	Fri,  2 Oct 2020 03:00:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D351C0051
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 03:00:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 01B92204CB
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 03:00:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JXh68WIec7s5 for <iommu@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 03:00:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com
 [209.85.216.66])
 by silver.osuosl.org (Postfix) with ESMTPS id A834B20420
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 03:00:28 +0000 (UTC)
Received: by mail-pj1-f66.google.com with SMTP id t7so206203pjd.3
 for <iommu@lists.linux-foundation.org>; Thu, 01 Oct 2020 20:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=vxCBqrAPI4BpulMRUd2dHi3liznsJJT1GfUE4tz0DaA=;
 b=oSpUgx3PIvcCjJEXKh2OcdwU6+Gu8yhGSFSDnYxRQdH3rtA4+igTwHajMexafQqOYW
 VrLEKUFMZrfl33npsf3i+TUfQQcSQDNj1++MFzWbhvAFkAOUDB4VXzVxnbUs4hX5AtfZ
 BTBamC1L1/k0hKUy9Shg8LNdDVyQCwkYwunDN40usxKx/TRQT14t197JR9Mawg4fH7En
 OSGyHspZxE4tD8K4C/sOwq/YmxjJMByKchRTQB2uII+rjuFBnd1Op2oA4If6XkqNOcZO
 7f6RV90FRasAxaQAxSW90CDKXbn9+hkW+gJc0LoAt2EfvKU7W6KUhR3PkuqNxKmtMhaz
 viOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=vxCBqrAPI4BpulMRUd2dHi3liznsJJT1GfUE4tz0DaA=;
 b=UMqy/sRrpZFmdAW3gDmyqGWqz+VbccdzfftQYmI0kJeQX5H2p5zve/O+LL0ejL+oCX
 hv9+bsj6k50HOEi1QsCGRoRilPvk0YXW6DawqrYkMIBx5T53JwZntHuv06JB+xG3E6Un
 /hMFP8hWjxY8kjT5yKljA1mt+i8Vu6f2JOPoKnT7lygi0tV3Rg2lWjxbC3Prcdls0AWf
 9E1foS8UfthItWNkvuUBtGcv7oyhgb2ro2NownpUElNcudQ18eyAp73JQwtrIZi34Pua
 9+4kWk4ovtBRlk5MxT84wjOsJ4cfprc161Ujf4gRziNszRJKIWa3azH3a79D+Q8pbLMk
 tXUA==
X-Gm-Message-State: AOAM531QnVEAVqxBnYRpXX7hIAu5tL55yGNv2FuWbctju58zf3zW9Ci6
 ptJVFRDSnNjKjAyS49+8q8I=
X-Google-Smtp-Source: ABdhPJxxJ/72A/OmbDItHMGCvQ2xjK0xiOUvxS1AbALAf8vSAIoGtERKyAuNNz0J5ee4KjedSLx1Mw==
X-Received: by 2002:a17:90a:ad8b:: with SMTP id
 s11mr427971pjq.40.1601607628065; 
 Thu, 01 Oct 2020 20:00:28 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id a1sm13541pjh.2.2020.10.01.20.00.27
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 01 Oct 2020 20:00:27 -0700 (PDT)
Date: Thu, 1 Oct 2020 19:54:35 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v3 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
Message-ID: <20201002025434.GA9394@Asurada-Nvidia>
References: <20200930213244.GA10573@Asurada-Nvidia>
 <5945a63e-79d8-e3ae-ab53-cee8c220ac7d@gmail.com>
 <20201001012630.GA28240@Asurada-Nvidia>
 <72b11925-5857-8ce5-d084-cab01ca1b396@gmail.com>
 <20201001024850.GA28456@Asurada-Nvidia>
 <20201001102316.GF3919720@ulmo> <20201001110425.GB1272@Asurada>
 <b966844e-4289-3ff0-9512-852f8419a664@gmail.com>
 <20201002010751.GA26971@Asurada-Nvidia>
 <1b621b9d-cdc3-c7aa-2fa2-d728ae2bbc5d@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1b621b9d-cdc3-c7aa-2fa2-d728ae2bbc5d@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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

T24gRnJpLCBPY3QgMDIsIDIwMjAgYXQgMDQ6NTU6MzRBTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+IDAyLjEwLjIwMjAgMDQ6MDcsIE5pY29saW4gQ2hlbiDQv9C40YjQtdGCOgo+ID4g
T24gVGh1LCBPY3QgMDEsIDIwMjAgYXQgMTE6MzM6MzhQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+ID4+Pj4+IElmIHdlIGNhbid0IGNvbWUgdG8gYW4gYWdyZWVtZW50IG9uIGdsb2Jh
bGl6aW5nIG1jIHBvaW50ZXIsIHdvdWxkCj4gPj4+Pj4gaXQgYmUgcG9zc2libGUgdG8gcGFzcyB0
ZWdyYV9tY19kcml2ZXIgdGhyb3VnaCB0ZWdyYV9zbW11X3Byb2JlKCkKPiA+Pj4+PiBzbyB3ZSBj
YW4gY29udGludWUgdG8gdXNlIGRyaXZlcl9maW5kX2RldmljZV9ieV9md25vZGUoKSBhcyB2MT8K
PiA+Pj4+Pgo+ID4+Pj4+IHYxOiBodHRwczovL2xrbWwub3JnL2xrbWwvMjAyMC85LzI2LzY4Cj4g
Pj4+Pgo+ID4+Pj4gdGVncmFfc21tdV9wcm9iZSgpIGFscmVhZHkgdGFrZXMgYSBzdHJ1Y3QgdGVn
cmFfbWMgKi4gRGlkIHlvdSBtZWFuCj4gPj4+PiB0ZWdyYV9zbW11X3Byb2JlX2RldmljZSgpPyBJ
IGRvbid0IHRoaW5rIHdlIGNhbiBkbyB0aGF0IGJlY2F1c2UgaXQgaXNuJ3QKPiA+Pj4KPiA+Pj4g
SSB3YXMgc2F5aW5nIHRvIGhhdmUgYSBnbG9iYWwgcGFyZW50X2RyaXZlciBwb2ludGVyOiBzaW1p
bGFyIHRvCj4gPj4+IG15IHYxLCB5ZXQgcmF0aGVyIHRoYW4gImV4dGVybiIgdGhlIHRlZ3JhX21j
X2RyaXZlciwgd2UgcGFzcyBpdAo+ID4+PiB0aHJvdWdoIGVncmFfc21tdV9wcm9iZSgpIGFuZCBz
dG9yZSBpdCBpbiBhIHN0YXRpYyBnbG9iYWwgdmFsdWUKPiA+Pj4gc28gYXMgdG8gY2FsbCB0ZWdy
YV9zbW11X2dldF9ieV9md25vZGUoKSBpbiAtPnByb2JlX2RldmljZSgpLgo+ID4+Pgo+ID4+PiBU
aG91Z2ggSSBhZ3JlZSB0aGF0IGNyZWF0aW5nIGEgZ2xvYmFsIGRldmljZSBwb2ludGVyIChtYykg
bWlnaHQKPiA+Pj4gYmUgY29udHJvdmVyc2lhbCwgeWV0IGhhdmluZyBhIGdsb2JhbCBwYXJlbnRf
ZHJpdmVyIHBvaW50ZXIgbWF5Cj4gPj4+IG5vdCBiZSBhZ2FpbnN0IHRoZSBydWxlLCBjb25zaWRl
cmluZyB0aGF0IGl0IGlzIGNvbW1vbiBpbiBpb21tdQo+ID4+PiBkcml2ZXJzIHRvIGNhbGwgZHJp
dmVyX2ZpbmRfZGV2aWNlX2J5X2Z3bm9kZSBpbiBwcm9iZV9kZXZpY2UoKS4KPiA+Pgo+ID4+IFlv
dSBkb24ndCBuZWVkIHRoZSBnbG9iYWwgcG9pbnRlciBpZiB5b3UgaGF2ZSBTTU1VIE9GIG5vZGUu
Cj4gPj4KPiA+PiBZb3UgY291bGQgYWxzbyBnZXQgZHJpdmVyIHBvaW50ZXIgZnJvbSBtYy0+ZGV2
LT5kcml2ZXIuCj4gPj4KPiA+PiBCdXQgSSBkb24ndCB0aGluayB5b3UgbmVlZCB0byBkbyB0aGlz
IGF0IGFsbC4gVGhlIHByb2JlX2RldmljZSgpIGNvdWxkCj4gPj4gYmUgaW52b2tlZCBvbmx5IGZv
ciB0aGUgdGVncmFfc21tdV9vcHMgYW5kIHRoZW4gc2VlbXMgeW91IGNvdWxkIHVzZQo+ID4+IGRl
dl9pb21tdV9wcml2X3NldCgpIGluIHRlZ3JhX3NtbXVfb2ZfeGxhdGUoKSwgbGlrZSBzdW41MGkt
aW9tbXUgZHJpdmVyCj4gPj4gZG9lcy4KPiA+IAo+ID4gR2V0dGluZyBpb21tdSBkZXZpY2UgcG9p
bnRlciB1c2luZyBkcml2ZXJfZmluZF9kZXZpY2VfYnlfZndub2RlKCkKPiA+IGlzIGEgY29tbW9u
IHByYWN0aWNlIGluIC0+cHJvYmVfZGV2aWNlKCkgb2Ygb3RoZXIgaW9tbXUgZHJpdmVycy4KPiAK
PiBQbGVhc2UgZ2l2ZSBtZSBhIGZ1bGwgbGlzdCBvZiB0aGUgSU9NTVUgZHJpdmVycyB3aGljaCB1
c2UgdGhpcyBtZXRob2QuCj4gCj4gPiBCdXQgdGhpcyByZXF1aXJlcyBhIGRldmljZV9kcml2ZXIg
cG9pbnRlciB0aGF0IHRlZ3JhLXNtbXUgZG9lc24ndAo+ID4gaGF2ZS4gU28gcGFzc2luZyB0ZWdy
YV9tY19kcml2ZXIgdGhyb3VnaCB0ZWdyYV9zbW11X3Byb2JlKCkgd2lsbAo+ID4gYWRkcmVzcyBp
dC4KPiA+IAo+IAo+IElmIHlvdSdyZSBib3Jyb3dpbmcgY29kZSBhbmQgaWRlYXMgZnJvbSBvdGhl
ciBkcml2ZXJzLCB0aGVuIGF0IGxlYXN0Cj4gcGxlYXNlIGJvcnJvdyB0aGVtIGZyb20gYSBtb2Rl
cm4gZ29vZC1sb29raW5nIGRyaXZlcnMuIEFuZCBJIGFscmVhZHkKPiBwb2ludGVkIG91dCB0aGF0
IGZvbGxvd2luZyBjYXJnbyBjdWx0IGlzIG5vdCBhbHdheXMgYSBnb29kIGlkZWEuCj4gCj4gQVJN
LVNNTVUgaXNuJ3QgYSBtb2Rlcm4gZHJpdmVyIGFuZCBpdCBoYXMgbGVnYWN5IGNvZGUuIFlvdSBz
aG91bGRuJ3QKPiBjb3B5IGl0IGJsaW5kbHkuIFRoZSBzdW41MGktaW9tbXUgZHJpdmVyIHdhcyBh
ZGRlZCBoYWxmIHllYXIgYWdvLCB5b3UKPiBtYXkgdXNlIGl0IGFzIGEgcmVmZXJlbmNlLgoKSSB0
b29rIGEgY2xvc2VyIGxvb2sgYXQgc3VuNTBpLWlvbW11IGRyaXZlci4gSXQncyBhIGdvb2QgaWRl
YS4KSSB0aGluayBJIGNhbiBjb21lIHVwIHdpdGggYSBjbGVhbmVyIG9uZS4gV2lsbCBzZW5kIHY0
LgoKVGhhbmtzIGZvciB0aGUgYWR2aWNlLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vaW9tbXU=
