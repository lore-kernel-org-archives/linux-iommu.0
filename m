Return-Path: <SRS0=Fz8+=DJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F144C4363C
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 23:59:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 260E6206B7
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 23:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uV51v3n2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 260E6206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A47B486D10;
	Fri,  2 Oct 2020 23:59:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hcjkmI8+i7Fe; Fri,  2 Oct 2020 23:59:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BBFB586D46;
	Fri,  2 Oct 2020 23:59:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9176C0889;
	Fri,  2 Oct 2020 23:59:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF905C0051
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 23:59:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C4D1B20406
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 23:59:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1iyxHfo6uZCc for <iommu@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 23:59:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by silver.osuosl.org (Postfix) with ESMTPS id 7F30220382
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 23:59:32 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id q18so1877138pgk.7
 for <iommu@lists.linux-foundation.org>; Fri, 02 Oct 2020 16:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=cEwMT8zhmCOTK4dn4wJHnutFKvkcPru3sg5M5Ou9uiQ=;
 b=uV51v3n2ao+EwdBPLJkXHu/VhIwvBHMFZOSMkL+r9h5h+g274KejT08OjfQL7We0m9
 Uw0QBu/jr9QMu1eOOv462dhyLHHg060jPWfyiq19WRnOCRZ/ELwmDGoxWzEalm9r/6SE
 KbIVX8T2SV1FxezmpWLedTryoK9HL2aWhme5O6GWoPKTFZRuwPJlcl+oloVUM7NoLW6a
 r4CDmPofaYOgrBuVER3otbXC/aAag6zaooih893H/nmfQvy11fAmgeCD/sxu10/JZbo7
 Ucnsc/8peSOS+WbzdqeA65q6aWJIl+2EV5yTr+wb4s/vm/0N8Y5UfBpaI62D9GXsRi4H
 tF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=cEwMT8zhmCOTK4dn4wJHnutFKvkcPru3sg5M5Ou9uiQ=;
 b=euBnw9lx4LevuDVK7AZkXm7rprivGz7NEciVtKZoimMJjdY9nuPmDWXHIfN3FrCTIm
 UaXHMdxBTQDJFp1/3Cinl9ptElu2RoOJmk7OKiKVts5dQal7mnNuFHNLWcOW5q+zjCDR
 ziUyBILsA4nisonCENJNnjDXTrPn6A6+1OD8KiWClk0PGOkvWid5oV75EAW811W/e2M9
 h2b2zkhbs5BbdnkROt7aLmhxHr1JGkHjFcQ1pYpuDDDXt1VOw3QB8jqg4SmJIzSXA4fg
 o0yX1piF/oQBdaPoHUHBiM4gwfClTV4IGjLscyrJiiNCNd1mFgnzhnYSzfO9vCNLvmUp
 oPhA==
X-Gm-Message-State: AOAM531iFSiKTUshUaMKkP7TLMHAqWLUt5PRFnV90wcfNbaQueVlrq0n
 kMkp9ZvJ8m1GqMycWfluu/Q=
X-Google-Smtp-Source: ABdhPJwAQRO8CGixT56i5K6YcLkU40fsKQ1AdlA/xQtYW8SDhWeD6964MtOOPLb5Vz4J0S+BkHIf9A==
X-Received: by 2002:a05:6a00:174a:b029:152:2bb6:4877 with SMTP id
 j10-20020a056a00174ab02901522bb64877mr4848736pfc.29.1601683171943; 
 Fri, 02 Oct 2020 16:59:31 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id i62sm3405092pfe.140.2020.10.02.16.59.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 02 Oct 2020 16:59:31 -0700 (PDT)
Date: Fri, 2 Oct 2020 16:53:30 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v4 1/3] iommu/tegra-smmu: Use fwspec in
 tegra_smmu_(de)attach_dev
Message-ID: <20201002235329.GA11409@Asurada-Nvidia>
References: <20201002060807.32138-1-nicoleotsuka@gmail.com>
 <20201002060807.32138-2-nicoleotsuka@gmail.com>
 <de0b717f-af5c-8813-eb3e-07d19eff5271@gmail.com>
 <20201002194508.GD29706@Asurada-Nvidia>
 <e594374b-d701-fb6f-93f2-4efb9c5eb608@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e594374b-d701-fb6f-93f2-4efb9c5eb608@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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

T24gRnJpLCBPY3QgMDIsIDIwMjAgYXQgMTE6MTI6MThQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+IDAyLjEwLjIwMjAgMjI6NDUsIE5pY29saW4gQ2hlbiDQv9C40YjQtdGCOgo+ID4g
T24gRnJpLCBPY3QgMDIsIDIwMjAgYXQgMDU6NDE6NTBQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+ID4+IDAyLjEwLjIwMjAgMDk6MDgsIE5pY29saW4gQ2hlbiDQv9C40YjQtdGCOgo+
ID4+PiAgc3RhdGljIGludCB0ZWdyYV9zbW11X2F0dGFjaF9kZXYoc3RydWN0IGlvbW11X2RvbWFp
biAqZG9tYWluLAo+ID4+PiAgCQkJCSBzdHJ1Y3QgZGV2aWNlICpkZXYpCj4gPj4+ICB7Cj4gPj4+
ICsJc3RydWN0IGlvbW11X2Z3c3BlYyAqZndzcGVjID0gZGV2X2lvbW11X2Z3c3BlY19nZXQoZGV2
KTsKPiA+Pj4gIAlzdHJ1Y3QgdGVncmFfc21tdSAqc21tdSA9IGRldl9pb21tdV9wcml2X2dldChk
ZXYpOwo+ID4+PiAgCXN0cnVjdCB0ZWdyYV9zbW11X2FzICphcyA9IHRvX3NtbXVfYXMoZG9tYWlu
KTsKPiA+Pj4gLQlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gZGV2LT5vZl9ub2RlOwo+ID4+PiAt
CXN0cnVjdCBvZl9waGFuZGxlX2FyZ3MgYXJnczsKPiA+Pj4gIAl1bnNpZ25lZCBpbnQgaW5kZXgg
PSAwOwo+ID4+PiAgCWludCBlcnIgPSAwOwo+ID4+PiAgCj4gPj4+IC0Jd2hpbGUgKCFvZl9wYXJz
ZV9waGFuZGxlX3dpdGhfYXJncyhucCwgImlvbW11cyIsICIjaW9tbXUtY2VsbHMiLCBpbmRleCwK
PiA+Pj4gLQkJCQkJICAgJmFyZ3MpKSB7Cj4gPj4+IC0JCXVuc2lnbmVkIGludCBzd2dyb3VwID0g
YXJncy5hcmdzWzBdOwo+ID4+PiAtCj4gPj4+IC0JCWlmIChhcmdzLm5wICE9IHNtbXUtPmRldi0+
b2Zfbm9kZSkgewo+ID4+PiAtCQkJb2Zfbm9kZV9wdXQoYXJncy5ucCk7Cj4gPj4+IC0JCQljb250
aW51ZTsKPiA+Pj4gLQkJfQo+ID4+PiAtCj4gPj4+IC0JCW9mX25vZGVfcHV0KGFyZ3MubnApOwo+
ID4+PiArCWlmICghZndzcGVjKQo+ID4+PiArCQlyZXR1cm4gLUVOT0VOVDsKPiA+Pgo+ID4+IENv
dWxkIHRoZSAhZndzcGVjIGV2ZXIgYmUgdHJ1ZSBoZXJlIGFzIHdlbGw/Cj4gPiAKPiA+IFRoZXJl
IGFyZSBtdWx0aXBsZSBjYWxsZXJzIG9mIHRoaXMgZnVuY3Rpb24uIEl0J3MgcmVhbGx5IG5vdCB0
aGF0Cj4gPiBzdHJhaWdodGZvcndhcmQgdG8gdHJhY2sgZXZlcnkgb25lIG9mIHRoZW0uIFNvIEkn
ZCByYXRoZXIgaGF2ZSBpdAo+ID4gaGVyZSBhcyBvdGhlciBpb21tdSBkcml2ZXJzIGRvLiBXZSBh
cmUgaHVtYW4gYmVpbmdzLCBzbyB3ZSBjb3VsZAo+ID4gaGF2ZSBtaXNzZWQgc29tZXRoaW5nIHNv
bWV3aGVyZSwgZXNwZWNpYWxseSBjYWxsZXJzIGFyZSBub3QgZnJvbQo+ID4gdGVncmEtKiBkcml2
ZXJzLgo+ID4gCj4gCj4gSSdtIGxvb2tpbmcgYXQgdGhlIElPTU1VIGNvcmUgYW5kIGl0IHJlcXVp
cmVzIGRldmljZSB0byBiZSBpbiBJT01NVQo+IGdyb3VwIGJlZm9yZSBhdHRhY2hfZGV2KCkgY291
bGQgYmUgY2FsbGVkLgo+IAo+IFRoZSBncm91cCBjYW4ndCBiZSBhc3NpZ25lZCB0byBkZXZpY2Ug
d2l0aG91dCB0aGUgZndzcGVjLCBzZWUKPiB0ZWdyYV9zbW11X2RldmljZV9ncm91cCgpLgo+Cj4g
U2VlbXMgbWFqb3JpdHkgb2YgSU9NTVUgZHJpdmVycyBhcmUgY2hlY2tpbmcgZGV2X2lvbW11X3By
aXZfZ2V0KCkgZm9yCj4gTlVMTCBpbiBhdHRhY2hfZGV2KCksIHNvbWUgbm90IGNoZWNraW5nIGFu
eXRoaW5nLCBzb21lIGNoZWNrIGJvdGggYW5kCj4gb25seSBhcm0tc21tdSBjaGVja3MgdGhlIGZ3
c3BlYy4KCkFzIEkgc2FpZCBhIGNvdXBsZSBvZiBkYXlzIGFnbywgSSBkb24ndCBsaWtlIHRvIGFz
c3VtZSB0aGF0IHRoZQpjYWxsZXJzIHdvbid0IGNoYW5nZS4gQW5kIHRoaXMgdGltZSwgaXQncyBm
cm9tIG9wZW4gY29kZS4gU28gSQpkb24ndCB3YW50IHRvIGFzc3VtZSB0aGF0IHRoZXJlIHdvbid0
IGJlIGEgY2hhbmdlLgoKSWYgeW91IGFyZSBjb25maWRlbnQgdGhhdCB0aGVyZSBpcyBubyBuZWVk
IHRvIGFkZCBzdWNoIGEgY2hlY2ssCnBsZWFzZSBzZW5kIHBhdGNoZXMgdG8gcmVtb3ZlIHRob3Nl
IGNoZWNrcyBpbiB0aG9zZSBkcml2ZXJzIHRvCnNlZSBpZiBvdGhlcnMgd291bGQgYWdyZWUuIEkg
d291bGQgYmUgd2lsbGluZyB0byByZW1vdmUgaXQgYWZ0ZXIKdGhhdC4gT3RoZXJ3aXNlLCBJJ2Qg
bGlrZSB0byBrZWVwIHRoaXMuCgpUaGFua3MgZm9yIHRoZSByZXZpZXcuCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
