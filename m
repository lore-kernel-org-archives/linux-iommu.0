Return-Path: <SRS0=Q5Oi=DP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCACC433E7
	for <iommu@archiver.kernel.org>; Thu,  8 Oct 2020 21:19:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9220922200
	for <iommu@archiver.kernel.org>; Thu,  8 Oct 2020 21:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jcfw/+Si"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9220922200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id DAC5C874FF;
	Thu,  8 Oct 2020 21:19:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3-uPhqQSe2hz; Thu,  8 Oct 2020 21:19:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2C53C874F1;
	Thu,  8 Oct 2020 21:19:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F5D2C016F;
	Thu,  8 Oct 2020 21:19:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95C9AC0051
 for <iommu@lists.linux-foundation.org>; Thu,  8 Oct 2020 21:19:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 782DC86B8E
 for <iommu@lists.linux-foundation.org>; Thu,  8 Oct 2020 21:19:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2rqj7QE19Asj for <iommu@lists.linux-foundation.org>;
 Thu,  8 Oct 2020 21:19:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A211B86ACC
 for <iommu@lists.linux-foundation.org>; Thu,  8 Oct 2020 21:19:13 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id d6so3376861plo.13
 for <iommu@lists.linux-foundation.org>; Thu, 08 Oct 2020 14:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=I4FFbIdibqfVfvGcOnZYh8MDx+ZE9b8VrGVYJfL3qB0=;
 b=Jcfw/+SiNQlmyBIt6FjxR5VkqooRo8Jyca8LYxYNUoP9rPsJPhuYQfaop/i/ajwbhC
 LMrr702EhiP5/PQBwUczJ8uOPWGOY8MDgYRdAv9ShKXeOwOGVhG0RzUF+2hxqIn0M6Oh
 MeXcrKO3dnO76LdNReUEbZSZ7gWfd3pW0NEQfOZeAbfQIII/hLS302ZbywOAuAfYmUpf
 UfTXyIWSpJIN98x0vpZPY8EUwPUywXHwZH9Wmf6r6i7KvmHKFuKTq/hT6sXkkOsQfbxk
 fr3aOV553dMSRGA4rxNqyuvnvvwLAN3/0rfAXrFgE5YqcKnfb78WAYyQ4tVNcgmjuTEl
 g8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=I4FFbIdibqfVfvGcOnZYh8MDx+ZE9b8VrGVYJfL3qB0=;
 b=bhPtObLiIxXOHFx2wzEDkyO5lrHnTqlYl5Aexxi1+vKcD01zQKfUxummigBXNycCez
 /Qm8VYrxjb3xCXHk4N879/qr2zsXQ2dGDTZN6ulScVeT8Dd+PLwSqWYBeKnnFOciEwD/
 DZN6ZnIbtmx5O2B+o5YGGnxujkg8CF322bdV6aCtwuP9gHkm4BF25HHYSeQ0BAn7Mo02
 K9+SX3Q2zxy/KWM41uKASF40lntk2WzSa67bvADxnNW8uvehpzVekOYX9mSL1oOVBpjW
 nQVz+gksM9l0dQy4k+95KR0JVfTVLqvGWFs5rCSsi3o3zNsnE9lHvGN7Ey2oI8z+auy3
 vFyg==
X-Gm-Message-State: AOAM530BTrszokAAZiRimLwR11iRXlP4uZJrrYsGPUotD6/DKdkWiFJT
 J57xP+ZQS+N3gtKN9Q2Dndo=
X-Google-Smtp-Source: ABdhPJzZEBrqiOk7r0C4DP7Vk9bmm2Fynjhkoj6Ts83lfd7bMAoyl4sMg8H825mxh1Odh3+tV8u74w==
X-Received: by 2002:a17:902:7c83:b029:d3:cc6e:6dae with SMTP id
 y3-20020a1709027c83b02900d3cc6e6daemr9395932pll.13.1602191953007; 
 Thu, 08 Oct 2020 14:19:13 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id r6sm3974279pfg.85.2020.10.08.14.19.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 08 Oct 2020 14:19:12 -0700 (PDT)
Date: Thu, 8 Oct 2020 14:12:10 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 2/3] iommu/tegra-smmu: Rework tegra_smmu_probe_device()
Message-ID: <20201008211209.GC32140@Asurada-Nvidia>
References: <20201002060807.32138-1-nicoleotsuka@gmail.com>
 <20201002060807.32138-3-nicoleotsuka@gmail.com>
 <5542b314-f414-1e83-8cf6-2bf22a41ae9c@gmail.com>
 <20201002185828.GC29706@Asurada-Nvidia>
 <20201005095754.GJ425362@ulmo>
 <20201006010546.GB28640@Asurada-Nvidia>
 <20201008095343.GA2349275@ulmo>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201008095343.GA2349275@ulmo>
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

T24gVGh1LCBPY3QgMDgsIDIwMjAgYXQgMTE6NTM6NDNBTSArMDIwMCwgVGhpZXJyeSBSZWRpbmcg
d3JvdGU6Cj4gT24gTW9uLCBPY3QgMDUsIDIwMjAgYXQgMDY6MDU6NDZQTSAtMDcwMCwgTmljb2xp
biBDaGVuIHdyb3RlOgo+ID4gT24gTW9uLCBPY3QgMDUsIDIwMjAgYXQgMTE6NTc6NTRBTSArMDIw
MCwgVGhpZXJyeSBSZWRpbmcgd3JvdGU6Cj4gPiA+IE9uIEZyaSwgT2N0IDAyLCAyMDIwIGF0IDEx
OjU4OjI5QU0gLTA3MDAsIE5pY29saW4gQ2hlbiB3cm90ZToKPiA+ID4gPiBPbiBGcmksIE9jdCAw
MiwgMjAyMCBhdCAwNjowMjoxOFBNICswMzAwLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6Cj4gPiA+
ID4gPiAwMi4xMC4yMDIwIDA5OjA4LCBOaWNvbGluIENoZW4g0L/QuNGI0LXRgjoKPiA+ID4gPiA+
ID4gIHN0YXRpYyBpbnQgdGVncmFfc21tdV9vZl94bGF0ZShzdHJ1Y3QgZGV2aWNlICpkZXYsCj4g
PiA+ID4gPiA+ICAJCQkgICAgICAgc3RydWN0IG9mX3BoYW5kbGVfYXJncyAqYXJncykKPiA+ID4g
PiA+ID4gIHsKPiA+ID4gPiA+ID4gKwlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICppb21tdV9wZGV2
ID0gb2ZfZmluZF9kZXZpY2VfYnlfbm9kZShhcmdzLT5ucCk7Cj4gPiA+ID4gPiA+ICsJc3RydWN0
IHRlZ3JhX21jICptYyA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKGlvbW11X3BkZXYpOwo+ID4gPiA+
ID4gPiAgCXUzMiBpZCA9IGFyZ3MtPmFyZ3NbMF07Cj4gPiA+ID4gPiA+ICAKPiA+ID4gPiA+ID4g
KwlvZl9ub2RlX3B1dChhcmdzLT5ucCk7Cj4gPiA+ID4gPiAKPiA+ID4gPiA+IG9mX2ZpbmRfZGV2
aWNlX2J5X25vZGUoKSB0YWtlcyBkZXZpY2UgcmVmZXJlbmNlIGFuZCBub3QgdGhlIG5wCj4gPiA+
ID4gPiByZWZlcmVuY2UuIFRoaXMgaXMgYSBidWcsIHBsZWFzZSByZW1vdmUgb2Zfbm9kZV9wdXQo
KS4KPiA+ID4gPiAKPiA+ID4gPiBMb29rcyBsaWtlIHNvLiBSZXBsYWNpbmcgaXQgd2l0aCBwdXRf
ZGV2aWNlKCZpb21tdV9wZGV2LT5kZXYpOwo+ID4gPiAKPiA+ID4gUHV0dGluZyB0aGUgcHV0X2Rl
dmljZSgpIGhlcmUgaXMgd3JvbmcsIHRob3VnaC4gWW91IG5lZWQgdG8gbWFrZSBzdXJlCj4gPiA+
IHlvdSBrZWVwIGEgcmVmZXJlbmNlIHRvIGl0IGFzIGxvbmcgYXMgeW91IGtlZXAgYWNjZXNzaW5n
IHRoZSBkYXRhIHRoYXQKPiA+ID4gaXMgb3duZWQgYnkgaXQuCj4gPiAKPiA+IEkgYW0gY29uZnVz
ZWQuIFlvdSBzYWlkIGluIHRoZSBvdGhlciByZXBseSAodG8gRG1pdHJ5KSB0aGF0IHdlIGRvCj4g
PiBuZWVkIHRvIHB1dF9kZXZpY2UobWMtPmRldiksIHdoZXJlIG1jLT5kZXYgc2hvdWxkIGJlIHRo
ZSBzYW1lIGFzCj4gPiBpb21tdV9wZGV2LT5kZXYuIEJ1dCBoZXJlIHlvdXIgY29tbWVudHMgc291
bmRzIHRoYXQgd2Ugc2hvdWxkIG5vdAo+ID4gcHV0X2RldmljZSBhdCBhbGwgc2luY2UgLT5wcm9i
ZV9kZXZpY2UvZ3JvdXBfZGV2aWNlL2F0dGFjaF9kZXYoKQo+ID4gd2lsbCB1c2UgaXQgbGF0ZXIu
Cj4gCj4gWW91IG5lZWQgdG8gY2FsbCBwdXRfZGV2aWNlKCkgYXQgc29tZSBwb2ludCB0byByZWxl
YXNlIHRoZSByZWZlcmVuY2UKPiB0aGF0IHlvdSBhY3F1aXJlZCBieSBjYWxsaW5nIG9mX2ZpbmRf
ZGV2aWNlX2J5X25vZGUoKS4gSWYgeW91IGRvbid0Cj4gcmVsZWFzZSBpdCwgeW91J3JlIGxlYWtp
bmcgdGhlIHJlZmVyZW5jZSBhbmQgdGhlIGtlcm5lbCBpc24ndCBnb2luZyB0bwo+IGtub3cgd2hl
biBpdCdzIHNhZmUgdG8gZGVsZXRlIHRoZSBkZXZpY2UuCj4gCj4gU28gd2hhdCBJJ20gc2F5aW5n
IGlzIHRoYXQgd2UgZWl0aGVyIHJlbGVhc2UgaXQgaGVyZSwgd2hpY2ggaXNuJ3QgcXVpdGUKPiBy
aWdodCBiZWNhdXNlIHdlIGRvIHJlZmVyZW5jZSBkYXRhIHJlbGF0aW5nIHRvIHRoZSBkZXZpY2Ug
bGF0ZXIgb24uIEFuZAoKSSBzZWUuIEEgc21hbGwgcXVlc3Rpb24gaGVyZSBieSB0aGUgd2F5OiBC
eSBsb29raW5nIGF0IG90aGVyIElPTU1VCmRyaXZlcnMgdGhhdCBhcmUgY2FsbGluZyBkcml2ZXJf
ZmluZF9kZXZpY2VfYnlfZndub2RlKCkgZnVuY3Rpb24sCkkgZm91bmQgdGhhdCBtb3N0IG9mIHRo
ZW0gcHV0X2RldmljZSByaWdodCBhZnRlciB0aGUgZnVuY3Rpb24gY2FsbCwKYW5kIGRldl9nZXRf
ZHJ2ZGF0YSgpIGFmdGVyIHB1dHRpbmcgdGhlIGRldmljZS4uCgpGZWVscyBsaWtlIHRoZXkgYXJl
IGRvaW5nIGl0IHdyb25nbHk/Cgo+IGJlY2F1c2UgaXQgaXNuJ3QgcXVpdGUgcmlnaHQgdGhlcmUg
c2hvdWxkIGJlIGEgcmVhc29uIHRvIGp1c3RpZnkgaXQsCj4gd2hpY2ggaXMgdGhhdCB0aGUgU01N
VSBwYXJlbnQgZGV2aWNlIGlzIHRoZSBzYW1lIGFzIHRoZSBNQywgc28gdGhlCj4gcmVmZXJlbmNl
IGNvdW50IGlzbid0IHN0cmljdGx5IG5lY2Vzc2FyeS4gQnV0IHRoYXQncyBub3QgcXVpdGUgb2J2
aW91cywKPiBzbyBoaWdobGlnaHRpbmcgaXQgaW4gYSBjb21tZW50IG1ha2VzIHNlbnNlLgo+IAo+
IFRoZSBvdGhlciBhbHRlcm5hdGl2ZSBpcyB0byBub3QgY2FsbCBwdXRfZGV2aWNlKCkgaGVyZSBh
bmQga2VlcCBvbiB0bwo+IHRoZSByZWZlcmVuY2UgYXMgbG9uZyBhcyB5b3Uga2VlcCB1c2luZyAi
bWMiLiBUaGlzIG1pZ2h0IGJlIGRpZmZpY3VsdCB0bwo+IGltcGxlbWVudCBiZWNhdXNlIGl0IG1h
eSBub3QgYmUgb2J2aW91cyB3aGVyZSB0byByZWxlYXNlIGl0LiBJIHRoaW5rCj4gdGhpcyBpcyB0
aGUgYmV0dGVyIGFsdGVybmF0aXZlLCBidXQgaWYgaXQncyB0b28gY29tcGxpY2F0ZWQgdG8gaW1w
bGVtZW50Cj4gaXQgbWlnaHQgbm90IGJlIHdvcnRoIGl0LgoKSSBmZWVsIHNvIHRvby4gVGhlIGRl
diBpcyBnb3QgYXQgb2ZfeGxhdGUoKSB0aGF0IGRvZXMgbm90IGhhdmUgYW4Kb2J2aW91cyBjb3Vu
dGVycGFydCBmdW5jdGlvbi4gU28gSSdsbCBqdXN0IHJlbW92ZSBwdXRfZGV2aWNlKCkgYW5kCnB1
dCBhIGxpbmUgb2YgY29tbWVudHMsIGFzIHlvdSBzdWdnZXN0ZWQuCgo+ID4gPiBMaWtlIEkgc2Fp
ZCBlYXJsaWVyLCB0aGlzIGlzIGEgYml0IHdlaXJkIGluIHRoaXMgY2FzZSBiZWNhdXNlIHdlJ3Jl
Cj4gPiA+IHNlbGYtcmVmZXJlbmNpbmcsIHNvIGlvbW11X3BkZXYtPmRldiBpcyBnb2luZyB0byBz
dGF5IGFyb3VuZCBhcyBsb25nIGFzCj4gPiA+IHRoZSBTTU1VIGlzLiBIb3dldmVyLCBpdCBtaWdo
dCBiZSB3b3J0aCB0byBwcm9wZXJseSB0cmFjayB0aGUgbGlmZXRpbWUKPiA+ID4gYW55d2F5IGp1
c3Qgc28gdGhhdCB0aGUgY29kZSBjYW4gc2VydmUgYXMgYSBnb29kIGV4YW1wbGUgb2YgaG93IHRv
IGRvCj4gPiA+IHRoaW5ncy4KPiA+IAo+ID4gV2hhdCdzIHRoaXMgInRyYWNrLXRoZS1saWZldGlt
ZSI/Cj4gCj4gVGhpcyBiYXNpY2FsbHkganVzdCBtZWFucyB0aGF0IFNNTVUgbmVlZHMgdG8gZW5z
dXJlIHRoYXQgTUMgc3RheXMgYWxpdmUKPiAoYnkgaG9sZGluZyBhIHJlZmVyZW5jZSB0byBpdCkg
YXMgbG9uZyBhcyBTTU1VIHVzZXMgaXQuIElmIHRoZSBsYXN0Cj4gcmVmZXJlbmNlIHRvIE1DIGlz
IGRyb3BwZWQsIHRoZW4gdGhlIG1jIHBvaW50ZXIgYW5kIHBvdGVudGlhbGx5IGFueXRoaW5nCj4g
dGhhdCBpdCBwb2ludHMgdG8gd2lsbCBiZWNvbWUgZGFuZ2xpbmcuIElmIHlvdSB3ZXJlIHRvIGRy
b3AgdGhlIGxhc3QKPiByZWZlcmVuY2UgYXQgdGhpcyBwb2ludCwgdGhlbiBvbiB0aGUgbmV4dCBs
aW5lIHRoZSBtYyBwb2ludGVyIGNvdWxkCj4gYWxyZWFkeSBiZSBpbnZhbGlkLgo+IAo+IFRoYXQn
cyBob3cgaXQgZ2VuZXJhbGx5IHdvcmtzLCBhbnl3YXkuIFdoYXQncyBzcGVjaWFsIGFib3V0IHRo
aXMgdXNlLQo+IGNhc2UgaXMgdGhhdCB0aGUgU01NVSBhbmQgTUMgYXJlIHRoZSBzYW1lIGRldmlj
ZSwgc28gaXQgc2hvdWxkIGJlIHNhZmUKPiB0byBvbWl0IHRoaXMgYWRkaXRpb25hbCB0cmFja2lu
ZyBiZWNhdXNlIHRoZSBJT01NVSB0cmFja2luZyBzaG91bGQgdGFrZQo+IGNhcmUgb2YgdGhhdCBh
bHJlYWR5LgoKT2theS4KCj4gPiA+IElmIHlvdSBkZWNpZGUgdG8gZ28gZm9yIHRoZSBzaG9ydGN1
dCBhbmQgbm90IHRyYWNrIHRoaXMgcmVmZXJlbmNlCj4gPiA+IHByb3Blcmx5LCB0aGVuIGF0IGxl
YXN0IHlvdSBuZWVkIHRvIGFkZCBhIGNvbW1lbnQgYXMgdG8gd2h5IGl0IGlzIHNhZmUKPiA+ID4g
dG8gZG8gaW4gdGhpcyBjYXNlLiBUaGlzIGVuc3VyZXMgdGhhdCByZWFkZXJzIGFyZSBhd2F5IG9m
IHRoZQo+ID4gPiBjaXJjdW1zdGFuY2VzIGFuZCBkb24ndCBjb3B5IHRoaXMgYmFkIGNvZGUgaW50
byBhIGNvbnRleHQgd2hlcmUgdGhlCj4gPiA+IGNpcmN1bXN0YW5jZXMgYXJlIGRpZmZlcmVudC4K
PiA+IAo+ID4gSSBkb24ndCBxdWl0ZSBnZXQgdGhpcyAic2hvcnRjdXQiIGhlcmUgZWl0aGVyLi4u
bWluZCBlbGFib3JhdGluZz8KPiAKPiBUaGUgc2hvcnRjdXQgaXMgdGFraW5nIGFkdmFudGFnZSBv
ZiB0aGUga25vd2xlZGdlIHRoYXQgdGhlIFNNTVUgYW5kIHRoZQo+IE1DIGFyZSB0aGUgc2FtZSBk
ZXZpY2UgYW5kIHRoZXJlZm9yZSBub3QgcHJvcGVybHkgdHJhY2sgdGhlIE1DIG9iamVjdC4KPiBH
aXZlbiB0aGF0IHRoZWlyIGNvZGUgaXMgbG9jYXRlZCBpbiBkaWZmZXJlbnQgbG9jYXRpb25zLCB0
aGlzIGlzbid0Cj4gb2J2aW91cyB0byB0aGUgY2FzdWFsIHJlYWRlciBvZiB0aGUgY29kZSwgc28g
dGhleSBtYXkgYXNzdW1lIHRoYXQgdGhpcwo+IGlzIHRoZSBub3JtYWwgd2F5IHRvIGRvIHRoaW5n
cy4gVG8gYXZvaWQgdGhhdCwgdGhlIGNvZGUgc2hvdWxkIGhhdmUgYQo+IGNvbW1lbnQgZXhwbGFp
bmluZyB3aHkgdGhhdCBpcy4KCkdvdCBpdC4gVGhhbmtzIQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vaW9tbXU=
