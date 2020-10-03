Return-Path: <SRS0=7D56=DK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425A7C46466
	for <iommu@archiver.kernel.org>; Sat,  3 Oct 2020 04:01:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8B9A206C3
	for <iommu@archiver.kernel.org>; Sat,  3 Oct 2020 04:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdIKAi0j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B9A206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 530EE8625B;
	Sat,  3 Oct 2020 04:01:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dYxksryePBmj; Sat,  3 Oct 2020 04:01:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 488E485F87;
	Sat,  3 Oct 2020 04:01:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1CE27C0889;
	Sat,  3 Oct 2020 04:01:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2653FC0051
 for <iommu@lists.linux-foundation.org>; Sat,  3 Oct 2020 04:01:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0E3C18625B
 for <iommu@lists.linux-foundation.org>; Sat,  3 Oct 2020 04:01:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qmpu2xSzedVm for <iommu@lists.linux-foundation.org>;
 Sat,  3 Oct 2020 04:01:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com
 [209.85.167.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0D83E85F87
 for <iommu@lists.linux-foundation.org>; Sat,  3 Oct 2020 04:01:14 +0000 (UTC)
Received: by mail-lf1-f65.google.com with SMTP id z19so4314710lfr.4
 for <iommu@lists.linux-foundation.org>; Fri, 02 Oct 2020 21:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4/c66VVNK2fZAJCWWd//XYQrFuPfF7bPZFCOGDskZLA=;
 b=mdIKAi0jBk+gBPjsj69jEhbol1cZXK/qBB9/Mkh/UZktLcstFuefS7b3t0MJMDQkas
 e/1w4tha2Rra5oZOH36cSyeXPhb36mRvl0IyDsAQ2QAn0/uAnoWS3t21hIMCkzrNye90
 hxaRmEStuKQ6mDDC5sVxD9cmibghrb3++rfCXJJQdFxrSAC+AFj6fExIO9Bqj7YANeJV
 fwGMtYq2dQMsPe3kEsXvV+HCIl/LRZHsZG88kEkA7Bp+9IgzMRSBeczJ/ivsBvkchVKS
 2ZvH8NGOElXhx1BbOA1qfenw7i4Zv8jvr5X5EGW7iZhZHopYjhsCwiZH/GtV9kIpS+u6
 me+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4/c66VVNK2fZAJCWWd//XYQrFuPfF7bPZFCOGDskZLA=;
 b=IGu22whCcNwxEAIReXmh2svnKtYP9q6q4m5BtcKk3skZ1YRHyrczLS8g1xvCuwzFMM
 rtU4Xsk75zkOrjqdmmoo6/xW5CYgSD4JWAIl6qlyVpET20GOWgUPYtNJKUjmi2hoh+Ei
 nE0yTF4xgGBxkqZ1zgjFc+NmMiS0G6cIwagCSeGTuBvS32/fb+7e4WCKo+M1YzKh2AlR
 7xxu1lnEIeji9w/ev7xeSs8AHeoHUxvF3K84ZTYAot45SAvhAUTlD0BuLWk6bZNBa2ZW
 i4WHjS/j6XlYb/s9tUF+M5pGKi6EjEtZ4puM/xndFkjeLTaIsIP+CawozUmhsmTa1Hwv
 HzKQ==
X-Gm-Message-State: AOAM5335pEOYAXEPkUxZM/XQz38jK+4IhhVL+MUtZcPz5TsB+ZxUdS7+
 ITWyDyx2p5Nv9IDI1Tp9UzM=
X-Google-Smtp-Source: ABdhPJwqYUrBcIBR4L7qcbGhQA2/6ZFGelci0lcwwEoGBABBT77tRyIGIvMAojDM1i9m1c8LkS/juA==
X-Received: by 2002:a19:549:: with SMTP id 70mr2110110lff.529.1601697671885;
 Fri, 02 Oct 2020 21:01:11 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.91.252])
 by smtp.googlemail.com with ESMTPSA id y10sm996183lfj.271.2020.10.02.21.01.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2020 21:01:11 -0700 (PDT)
Subject: Re: [PATCH v4 1/3] iommu/tegra-smmu: Use fwspec in
 tegra_smmu_(de)attach_dev
To: Nicolin Chen <nicoleotsuka@gmail.com>
References: <20201002060807.32138-1-nicoleotsuka@gmail.com>
 <20201002060807.32138-2-nicoleotsuka@gmail.com>
 <de0b717f-af5c-8813-eb3e-07d19eff5271@gmail.com>
 <20201002194508.GD29706@Asurada-Nvidia>
 <e594374b-d701-fb6f-93f2-4efb9c5eb608@gmail.com>
 <20201002235329.GA11409@Asurada-Nvidia>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f61174fc-f8e2-5f2b-23ff-36642be62e87@gmail.com>
Date: Sat, 3 Oct 2020 07:01:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201002235329.GA11409@Asurada-Nvidia>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, thierry.reding@gmail.com, linux-tegra@vger.kernel.org
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

MDMuMTAuMjAyMCAwMjo1MywgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gT24gRnJpLCBPY3Qg
MDIsIDIwMjAgYXQgMTE6MTI6MThQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+PiAw
Mi4xMC4yMDIwIDIyOjQ1LCBOaWNvbGluIENoZW4g0L/QuNGI0LXRgjoKPj4+IE9uIEZyaSwgT2N0
IDAyLCAyMDIwIGF0IDA1OjQxOjUwUE0gKzAzMDAsIERtaXRyeSBPc2lwZW5rbyB3cm90ZToKPj4+
PiAwMi4xMC4yMDIwIDA5OjA4LCBOaWNvbGluIENoZW4g0L/QuNGI0LXRgjoKPj4+Pj4gIHN0YXRp
YyBpbnQgdGVncmFfc21tdV9hdHRhY2hfZGV2KHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiwK
Pj4+Pj4gIAkJCQkgc3RydWN0IGRldmljZSAqZGV2KQo+Pj4+PiAgewo+Pj4+PiArCXN0cnVjdCBp
b21tdV9md3NwZWMgKmZ3c3BlYyA9IGRldl9pb21tdV9md3NwZWNfZ2V0KGRldik7Cj4+Pj4+ICAJ
c3RydWN0IHRlZ3JhX3NtbXUgKnNtbXUgPSBkZXZfaW9tbXVfcHJpdl9nZXQoZGV2KTsKPj4+Pj4g
IAlzdHJ1Y3QgdGVncmFfc21tdV9hcyAqYXMgPSB0b19zbW11X2FzKGRvbWFpbik7Cj4+Pj4+IC0J
c3RydWN0IGRldmljZV9ub2RlICpucCA9IGRldi0+b2Zfbm9kZTsKPj4+Pj4gLQlzdHJ1Y3Qgb2Zf
cGhhbmRsZV9hcmdzIGFyZ3M7Cj4+Pj4+ICAJdW5zaWduZWQgaW50IGluZGV4ID0gMDsKPj4+Pj4g
IAlpbnQgZXJyID0gMDsKPj4+Pj4gIAo+Pj4+PiAtCXdoaWxlICghb2ZfcGFyc2VfcGhhbmRsZV93
aXRoX2FyZ3MobnAsICJpb21tdXMiLCAiI2lvbW11LWNlbGxzIiwgaW5kZXgsCj4+Pj4+IC0JCQkJ
CSAgICZhcmdzKSkgewo+Pj4+PiAtCQl1bnNpZ25lZCBpbnQgc3dncm91cCA9IGFyZ3MuYXJnc1sw
XTsKPj4+Pj4gLQo+Pj4+PiAtCQlpZiAoYXJncy5ucCAhPSBzbW11LT5kZXYtPm9mX25vZGUpIHsK
Pj4+Pj4gLQkJCW9mX25vZGVfcHV0KGFyZ3MubnApOwo+Pj4+PiAtCQkJY29udGludWU7Cj4+Pj4+
IC0JCX0KPj4+Pj4gLQo+Pj4+PiAtCQlvZl9ub2RlX3B1dChhcmdzLm5wKTsKPj4+Pj4gKwlpZiAo
IWZ3c3BlYykKPj4+Pj4gKwkJcmV0dXJuIC1FTk9FTlQ7Cj4+Pj4KPj4+PiBDb3VsZCB0aGUgIWZ3
c3BlYyBldmVyIGJlIHRydWUgaGVyZSBhcyB3ZWxsPwo+Pj4KPj4+IFRoZXJlIGFyZSBtdWx0aXBs
ZSBjYWxsZXJzIG9mIHRoaXMgZnVuY3Rpb24uIEl0J3MgcmVhbGx5IG5vdCB0aGF0Cj4+PiBzdHJh
aWdodGZvcndhcmQgdG8gdHJhY2sgZXZlcnkgb25lIG9mIHRoZW0uIFNvIEknZCByYXRoZXIgaGF2
ZSBpdAo+Pj4gaGVyZSBhcyBvdGhlciBpb21tdSBkcml2ZXJzIGRvLiBXZSBhcmUgaHVtYW4gYmVp
bmdzLCBzbyB3ZSBjb3VsZAo+Pj4gaGF2ZSBtaXNzZWQgc29tZXRoaW5nIHNvbWV3aGVyZSwgZXNw
ZWNpYWxseSBjYWxsZXJzIGFyZSBub3QgZnJvbQo+Pj4gdGVncmEtKiBkcml2ZXJzLgo+Pj4KPj4K
Pj4gSSdtIGxvb2tpbmcgYXQgdGhlIElPTU1VIGNvcmUgYW5kIGl0IHJlcXVpcmVzIGRldmljZSB0
byBiZSBpbiBJT01NVQo+PiBncm91cCBiZWZvcmUgYXR0YWNoX2RldigpIGNvdWxkIGJlIGNhbGxl
ZC4KPj4KPj4gVGhlIGdyb3VwIGNhbid0IGJlIGFzc2lnbmVkIHRvIGRldmljZSB3aXRob3V0IHRo
ZSBmd3NwZWMsIHNlZQo+PiB0ZWdyYV9zbW11X2RldmljZV9ncm91cCgpLgo+Pgo+PiBTZWVtcyBt
YWpvcml0eSBvZiBJT01NVSBkcml2ZXJzIGFyZSBjaGVja2luZyBkZXZfaW9tbXVfcHJpdl9nZXQo
KSBmb3IKPj4gTlVMTCBpbiBhdHRhY2hfZGV2KCksIHNvbWUgbm90IGNoZWNraW5nIGFueXRoaW5n
LCBzb21lIGNoZWNrIGJvdGggYW5kCj4+IG9ubHkgYXJtLXNtbXUgY2hlY2tzIHRoZSBmd3NwZWMu
Cj4gCj4gQXMgSSBzYWlkIGEgY291cGxlIG9mIGRheXMgYWdvLCBJIGRvbid0IGxpa2UgdG8gYXNz
dW1lIHRoYXQgdGhlCj4gY2FsbGVycyB3b24ndCBjaGFuZ2UuIEFuZCB0aGlzIHRpbWUsIGl0J3Mg
ZnJvbSBvcGVuIGNvZGUuIFNvIEkKPiBkb24ndCB3YW50IHRvIGFzc3VtZSB0aGF0IHRoZXJlIHdv
bid0IGJlIGEgY2hhbmdlLgo+IAo+IElmIHlvdSBhcmUgY29uZmlkZW50IHRoYXQgdGhlcmUgaXMg
bm8gbmVlZCB0byBhZGQgc3VjaCBhIGNoZWNrLAo+IHBsZWFzZSBzZW5kIHBhdGNoZXMgdG8gcmVt
b3ZlIHRob3NlIGNoZWNrcyBpbiB0aG9zZSBkcml2ZXJzIHRvCj4gc2VlIGlmIG90aGVycyB3b3Vs
ZCBhZ3JlZS4gSSB3b3VsZCBiZSB3aWxsaW5nIHRvIHJlbW92ZSBpdCBhZnRlcgo+IHRoYXQuIE90
aGVyd2lzZSwgSSdkIGxpa2UgdG8ga2VlcCB0aGlzLgo+IAo+IFRoYW5rcyBmb3IgdGhlIHJldmll
dy4KPiAKCkkgaGF2ZW4ndCB0cmllZCB0byBjaGVjayBldmVyeSBjb2RlIHBhdGggdmVyeSB0aG9y
b3VnaGx5LCBleHBlY3RpbmcgeW91CnRvIGRvIGl0IHNpbmNlIHlvdSdyZSBtYWtpbmcgdGhpcyBw
YXRjaC4gTWF5YmUgdGhlcmUgaXMgYSByZWFsIHJlYXNvbgp3aHkgbWFqb3JpdHkgb2YgZHJpdmVy
cyBkbyB0aGUgY2hlY2tzIGFuZCBpdCB3b3VsZCBiZSBnb29kIHRvIGtub3cgd2h5LgpBbHRob3Vn
aCwgaXQncyBub3QgY3JpdGljYWwgaW4gdGhpcyBwYXJ0aWN1bGFyIGNhc2UgYW5kIGluZGVlZCB0
aGUKY2hlY2tzIGNvdWxkIGJlIGltcHJvdmVkIGxhdGVyIG9uLgoKSXQgbG9va3MgdG8gbWUgdGhh
dCBhdCBsZWFzdCB3aWxsIGJlIGEgYml0IGJldHRlci9jbGVhbmVyIHRvIGNoZWNrIHRoZQpkZXZf
aW9tbXVfcHJpdl9nZXQoKSBmb3IgTlVMTCBpbnN0ZWFkIG9mIGZ3c3BlYyBiZWNhdXNlIHRoZSBw
cml2YXRlCnZhcmlhYmxlIGRlcGVuZHMgb24gdGhlIGZ3c3BlYyBwcmVzZW5jZSBhbmQgdGhlcmUg
aXMgYSBzaW1pbGFyIGNoZWNrIGluCnByb2JlX2RldmljZSwgaGVuY2UgY2hlY2tzIHdpbGwgYmUg
bW9yZSBjb25zaXN0ZW50LgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lv
bW11
