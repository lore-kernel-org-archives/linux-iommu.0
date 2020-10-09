Return-Path: <SRS0=yPDG=DQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9E3C433DF
	for <iommu@archiver.kernel.org>; Fri,  9 Oct 2020 16:01:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CB3122259
	for <iommu@archiver.kernel.org>; Fri,  9 Oct 2020 16:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYF903DC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB3122259
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E10458719F;
	Fri,  9 Oct 2020 16:01:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TbiO7Juycuma; Fri,  9 Oct 2020 16:01:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 452908718F;
	Fri,  9 Oct 2020 16:01:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36F2FC07FF;
	Fri,  9 Oct 2020 16:01:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C5E0C0051
 for <iommu@lists.linux-foundation.org>; Fri,  9 Oct 2020 16:01:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6E8522E2B2
 for <iommu@lists.linux-foundation.org>; Fri,  9 Oct 2020 16:01:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CRIkbbjIFH6h for <iommu@lists.linux-foundation.org>;
 Fri,  9 Oct 2020 16:01:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by silver.osuosl.org (Postfix) with ESMTPS id AEE822E2CA
 for <iommu@lists.linux-foundation.org>; Fri,  9 Oct 2020 16:01:20 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id 7so7500742pgm.11
 for <iommu@lists.linux-foundation.org>; Fri, 09 Oct 2020 09:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=ogwgS6emsTutEVsuDo9NXk+t34Gcwt4eKQ40PbYtC1c=;
 b=NYF903DCt0v/0+TYWAhT8yVHFpc1LbzufF2yMNmTi1tfWldwbX3OGrXXMMzu0+ah6w
 O4VImSJQYR+eL8tpr1o2xglMLUH95M0EpmuznxncmmIZydctgdReGIBVhwIqfvdCZAZa
 PJAZMZQxg0Geq4HPtOurxISai9zNB6tkI0X0JplR4hZcJxt46Qv/LTXtFdcPBTsMlEco
 zKoBbrzV9t14pztYOrGuKXxxHEg5oTANlYs+cMXdRFHkRxvcj+2nGD192YaAZMKVQf/9
 G27DQQZnCv++rJWhXHV0j/rdtvCyAZEzZBsP1e/8v/zHMYhJ2iAD3FR9doTstg0cJ4Fx
 Wxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=ogwgS6emsTutEVsuDo9NXk+t34Gcwt4eKQ40PbYtC1c=;
 b=LR/7+ZEpPhKwxlMgXdnYy3oGLYrbl4DTQ25W0x2I/nI9jvKsMJQBu+gUg2pJz6H03W
 bvStOTKAzp+r3v/SM9LQr2oh7CLLGbeIlDNIYFa7vJAq7boDuJflOH2RunnH9qpgOXRM
 6Qjdnwb4/iMiC3B+WV+osHA2aheXg7m0lSKdKvKzAacsLA94rsCeA2jPeIeXZ2Y15slM
 T83A4v1qH2CmUa3BA8XS/f3Fc9fK8d5j8nG4Vr18YC8JUpAjCEKWlx7g9HSJcn3cwUfG
 VW8HXQ9gfHv7JodIP81aLMMF1HSGTYZozi7KUrRVkIjsXEdX2+qzuizuCDqiVDWmfy57
 Yv1g==
X-Gm-Message-State: AOAM5314BcF+h1QhZ3OWvF8oSS2pzIXvRUXKsZUG8hpLC/U1prqDTliN
 XNBdveVTuzHvQBP/2HXNjeQ=
X-Google-Smtp-Source: ABdhPJxyWZNZ+iIn+p2zK8NKmccVn+8rmLdAh7DJeJV40gBUb3dGd00QTxs0o/lyEwHiEOfl3ivRmw==
X-Received: by 2002:a05:6a00:170a:b029:152:6881:5e2d with SMTP id
 h10-20020a056a00170ab029015268815e2dmr13122365pfc.20.1602259280021; 
 Fri, 09 Oct 2020 09:01:20 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id b1sm10805631pft.127.2020.10.09.09.01.19
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 09 Oct 2020 09:01:19 -0700 (PDT)
Date: Fri, 9 Oct 2020 08:54:09 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 2/3] iommu/tegra-smmu: Rework tegra_smmu_probe_device()
Message-ID: <20201009155409.GB4469@Asurada-Nvidia>
References: <20201002060807.32138-1-nicoleotsuka@gmail.com>
 <20201002060807.32138-3-nicoleotsuka@gmail.com>
 <5542b314-f414-1e83-8cf6-2bf22a41ae9c@gmail.com>
 <20201002185828.GC29706@Asurada-Nvidia>
 <20201005095754.GJ425362@ulmo>
 <20201006010546.GB28640@Asurada-Nvidia>
 <20201008095343.GA2349275@ulmo>
 <20201008211209.GC32140@Asurada-Nvidia>
 <20201009122556.GE458338@ulmo>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201009122556.GE458338@ulmo>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
 Dmitry Osipenko <digetx@gmail.com>
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

T24gRnJpLCBPY3QgMDksIDIwMjAgYXQgMDI6MjU6NTZQTSArMDIwMCwgVGhpZXJyeSBSZWRpbmcg
d3JvdGU6Cj4gT24gVGh1LCBPY3QgMDgsIDIwMjAgYXQgMDI6MTI6MTBQTSAtMDcwMCwgTmljb2xp
biBDaGVuIHdyb3RlOgo+ID4gT24gVGh1LCBPY3QgMDgsIDIwMjAgYXQgMTE6NTM6NDNBTSArMDIw
MCwgVGhpZXJyeSBSZWRpbmcgd3JvdGU6Cj4gPiA+IE9uIE1vbiwgT2N0IDA1LCAyMDIwIGF0IDA2
OjA1OjQ2UE0gLTA3MDAsIE5pY29saW4gQ2hlbiB3cm90ZToKPiA+ID4gPiBPbiBNb24sIE9jdCAw
NSwgMjAyMCBhdCAxMTo1Nzo1NEFNICswMjAwLCBUaGllcnJ5IFJlZGluZyB3cm90ZToKPiA+ID4g
PiA+IE9uIEZyaSwgT2N0IDAyLCAyMDIwIGF0IDExOjU4OjI5QU0gLTA3MDAsIE5pY29saW4gQ2hl
biB3cm90ZToKPiA+ID4gPiA+ID4gT24gRnJpLCBPY3QgMDIsIDIwMjAgYXQgMDY6MDI6MThQTSAr
MDMwMCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+ID4gPiA+ID4gPiA+IDAyLjEwLjIwMjAgMDk6
MDgsIE5pY29saW4gQ2hlbiDQv9C40YjQtdGCOgo+ID4gPiA+ID4gPiA+ID4gIHN0YXRpYyBpbnQg
dGVncmFfc21tdV9vZl94bGF0ZShzdHJ1Y3QgZGV2aWNlICpkZXYsCj4gPiA+ID4gPiA+ID4gPiAg
CQkJICAgICAgIHN0cnVjdCBvZl9waGFuZGxlX2FyZ3MgKmFyZ3MpCj4gPiA+ID4gPiA+ID4gPiAg
ewo+ID4gPiA+ID4gPiA+ID4gKwlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICppb21tdV9wZGV2ID0g
b2ZfZmluZF9kZXZpY2VfYnlfbm9kZShhcmdzLT5ucCk7Cj4gPiA+ID4gPiA+ID4gPiArCXN0cnVj
dCB0ZWdyYV9tYyAqbWMgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShpb21tdV9wZGV2KTsKPiA+ID4g
PiA+ID4gPiA+ICAJdTMyIGlkID0gYXJncy0+YXJnc1swXTsKPiA+ID4gPiA+ID4gPiA+ICAKPiA+
ID4gPiA+ID4gPiA+ICsJb2Zfbm9kZV9wdXQoYXJncy0+bnApOwo+ID4gPiA+ID4gPiA+IAo+ID4g
PiA+ID4gPiA+IG9mX2ZpbmRfZGV2aWNlX2J5X25vZGUoKSB0YWtlcyBkZXZpY2UgcmVmZXJlbmNl
IGFuZCBub3QgdGhlIG5wCj4gPiA+ID4gPiA+ID4gcmVmZXJlbmNlLiBUaGlzIGlzIGEgYnVnLCBw
bGVhc2UgcmVtb3ZlIG9mX25vZGVfcHV0KCkuCj4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiBMb29r
cyBsaWtlIHNvLiBSZXBsYWNpbmcgaXQgd2l0aCBwdXRfZGV2aWNlKCZpb21tdV9wZGV2LT5kZXYp
Owo+ID4gPiA+ID4gCj4gPiA+ID4gPiBQdXR0aW5nIHRoZSBwdXRfZGV2aWNlKCkgaGVyZSBpcyB3
cm9uZywgdGhvdWdoLiBZb3UgbmVlZCB0byBtYWtlIHN1cmUKPiA+ID4gPiA+IHlvdSBrZWVwIGEg
cmVmZXJlbmNlIHRvIGl0IGFzIGxvbmcgYXMgeW91IGtlZXAgYWNjZXNzaW5nIHRoZSBkYXRhIHRo
YXQKPiA+ID4gPiA+IGlzIG93bmVkIGJ5IGl0Lgo+ID4gPiA+IAo+ID4gPiA+IEkgYW0gY29uZnVz
ZWQuIFlvdSBzYWlkIGluIHRoZSBvdGhlciByZXBseSAodG8gRG1pdHJ5KSB0aGF0IHdlIGRvCj4g
PiA+ID4gbmVlZCB0byBwdXRfZGV2aWNlKG1jLT5kZXYpLCB3aGVyZSBtYy0+ZGV2IHNob3VsZCBi
ZSB0aGUgc2FtZSBhcwo+ID4gPiA+IGlvbW11X3BkZXYtPmRldi4gQnV0IGhlcmUgeW91ciBjb21t
ZW50cyBzb3VuZHMgdGhhdCB3ZSBzaG91bGQgbm90Cj4gPiA+ID4gcHV0X2RldmljZSBhdCBhbGwg
c2luY2UgLT5wcm9iZV9kZXZpY2UvZ3JvdXBfZGV2aWNlL2F0dGFjaF9kZXYoKQo+ID4gPiA+IHdp
bGwgdXNlIGl0IGxhdGVyLgo+ID4gPiAKPiA+ID4gWW91IG5lZWQgdG8gY2FsbCBwdXRfZGV2aWNl
KCkgYXQgc29tZSBwb2ludCB0byByZWxlYXNlIHRoZSByZWZlcmVuY2UKPiA+ID4gdGhhdCB5b3Ug
YWNxdWlyZWQgYnkgY2FsbGluZyBvZl9maW5kX2RldmljZV9ieV9ub2RlKCkuIElmIHlvdSBkb24n
dAo+ID4gPiByZWxlYXNlIGl0LCB5b3UncmUgbGVha2luZyB0aGUgcmVmZXJlbmNlIGFuZCB0aGUg
a2VybmVsIGlzbid0IGdvaW5nIHRvCj4gPiA+IGtub3cgd2hlbiBpdCdzIHNhZmUgdG8gZGVsZXRl
IHRoZSBkZXZpY2UuCj4gPiA+IAo+ID4gPiBTbyB3aGF0IEknbSBzYXlpbmcgaXMgdGhhdCB3ZSBl
aXRoZXIgcmVsZWFzZSBpdCBoZXJlLCB3aGljaCBpc24ndCBxdWl0ZQo+ID4gPiByaWdodCBiZWNh
dXNlIHdlIGRvIHJlZmVyZW5jZSBkYXRhIHJlbGF0aW5nIHRvIHRoZSBkZXZpY2UgbGF0ZXIgb24u
IEFuZAo+ID4gCj4gPiBJIHNlZS4gQSBzbWFsbCBxdWVzdGlvbiBoZXJlIGJ5IHRoZSB3YXk6IEJ5
IGxvb2tpbmcgYXQgb3RoZXIgSU9NTVUKPiA+IGRyaXZlcnMgdGhhdCBhcmUgY2FsbGluZyBkcml2
ZXJfZmluZF9kZXZpY2VfYnlfZndub2RlKCkgZnVuY3Rpb24sCj4gPiBJIGZvdW5kIHRoYXQgbW9z
dCBvZiB0aGVtIHB1dF9kZXZpY2UgcmlnaHQgYWZ0ZXIgdGhlIGZ1bmN0aW9uIGNhbGwsCj4gPiBh
bmQgZGV2X2dldF9kcnZkYXRhKCkgYWZ0ZXIgcHV0dGluZyB0aGUgZGV2aWNlLi4KPiA+IAo+ID4g
RmVlbHMgbGlrZSB0aGV5IGFyZSBkb2luZyBpdCB3cm9uZ2x5Pwo+IAo+IFdlbGwsIGxpa2UgSSBz
YWlkIHRoaXMgaXMgc29tZXdoYXQgYWNhZGVtaWMgYmVjYXVzZSB0aGVzZSBhcmUgYWxsCj4gcmVm
ZXJlbmNpbmcgdGhlIElPTU1VIHRoYXQgYnkgZGVmaW5pdGlvbiBzdGlsbCBuZWVkcyB0byBiZSBh
cm91bmQKPiB3aGVuIHRoaXMgY29kZSBpcyBjYWxsZWQsIGFuZCB0aGVyZSdzIGxvY2tzIGluIHBs
YWNlIHRvIGVuc3VyZQo+IHRoZXNlIGRvbid0IGdvIGF3YXkuIFNvIGl0J3Mgbm90IGxpa2UgdGhl
c2UgZHJpdmVycyBhcmUgZG9pbmcgaXQKPiB3cm9uZywgdGhleSdyZSBqdXN0IG5vdCBkb2luZyBp
dCBwZWRhbnRpY2FsbHkgcmlnaHQuCj4gCj4gPiAKPiA+ID4gYmVjYXVzZSBpdCBpc24ndCBxdWl0
ZSByaWdodCB0aGVyZSBzaG91bGQgYmUgYSByZWFzb24gdG8ganVzdGlmeSBpdCwKPiA+ID4gd2hp
Y2ggaXMgdGhhdCB0aGUgU01NVSBwYXJlbnQgZGV2aWNlIGlzIHRoZSBzYW1lIGFzIHRoZSBNQywg
c28gdGhlCj4gPiA+IHJlZmVyZW5jZSBjb3VudCBpc24ndCBzdHJpY3RseSBuZWNlc3NhcnkuIEJ1
dCB0aGF0J3Mgbm90IHF1aXRlIG9idmlvdXMsCj4gPiA+IHNvIGhpZ2hsaWdodGluZyBpdCBpbiBh
IGNvbW1lbnQgbWFrZXMgc2Vuc2UuCj4gPiA+IAo+ID4gPiBUaGUgb3RoZXIgYWx0ZXJuYXRpdmUg
aXMgdG8gbm90IGNhbGwgcHV0X2RldmljZSgpIGhlcmUgYW5kIGtlZXAgb24gdG8KPiA+ID4gdGhl
IHJlZmVyZW5jZSBhcyBsb25nIGFzIHlvdSBrZWVwIHVzaW5nICJtYyIuIFRoaXMgbWlnaHQgYmUg
ZGlmZmljdWx0IHRvCj4gPiA+IGltcGxlbWVudCBiZWNhdXNlIGl0IG1heSBub3QgYmUgb2J2aW91
cyB3aGVyZSB0byByZWxlYXNlIGl0LiBJIHRoaW5rCj4gPiA+IHRoaXMgaXMgdGhlIGJldHRlciBh
bHRlcm5hdGl2ZSwgYnV0IGlmIGl0J3MgdG9vIGNvbXBsaWNhdGVkIHRvIGltcGxlbWVudAo+ID4g
PiBpdCBtaWdodCBub3QgYmUgd29ydGggaXQuCj4gPiAKPiA+IEkgZmVlbCBzbyB0b28uIFRoZSBk
ZXYgaXMgZ290IGF0IG9mX3hsYXRlKCkgdGhhdCBkb2VzIG5vdCBoYXZlIGFuCj4gPiBvYnZpb3Vz
IGNvdW50ZXJwYXJ0IGZ1bmN0aW9uLiBTbyBJJ2xsIGp1c3QgcmVtb3ZlIHB1dF9kZXZpY2UoKSBh
bmQKPiA+IHB1dCBhIGxpbmUgb2YgY29tbWVudHMsIGFzIHlvdSBzdWdnZXN0ZWQuCj4gCj4gSSB0
aGluayB5b3UgbWlzdW5kZXJzdG9vZC4gTm90IGNhbGxpbmcgcHV0X2RldmljZSgpIHdvdWxkIGJl
IHdyb25nCj4gYmVjYXVzZSB0aGF0IGxlYWtzIGEgcmVmZXJlbmNlIHRvIHRoZSBTTU1VIHRoYXQg
eW91IGNhbid0IGdldCBiYWNrLiBNeQo+IHN1Z2dlc3Rpb24gd2FzIHJhdGhlciB0byBrZWVwIHB1
dF9kZXZpY2UoKSBoZXJlLCBidXQgYWRkIGEgY29tbWVudCBhcyB0bwo+IHdoeSBpdCdzIG9rYXkg
dG8gY2FsbCB0aGUgcHV0X2RldmljZSgpIGhlcmUsIGV2ZW4gdGhvdWdoIHlvdSBrZWVwIHVzaW5n
Cj4gaXRzIHByaXZhdGUgZGF0YSBsYXRlciBiZXlvbmQgdGhpcyBwb2ludCwgd2hpY2ggdHlwaWNh
bGx5IHdvdWxkIGJlIHdyb25nCj4gdG8gZG8uCgpJIHNlZS4gVGhhbmtzIGZvciBjbGFyaWZpY2F0
aW9uISBXaWxsIHNlbmQgdjYgc29vbi4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2lvbW11
