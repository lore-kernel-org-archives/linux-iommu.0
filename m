Return-Path: <SRS0=/C+/=P4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE27AC433EF
	for <iommu@archiver.kernel.org>; Tue,  9 Nov 2021 23:10:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AB2061156
	for <iommu@archiver.kernel.org>; Tue,  9 Nov 2021 23:10:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8AB2061156
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2E947403D6;
	Tue,  9 Nov 2021 23:10:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v2HpiTimarZg; Tue,  9 Nov 2021 23:10:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CC64240166;
	Tue,  9 Nov 2021 23:10:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A148CC0019;
	Tue,  9 Nov 2021 23:10:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DCCDBC000E
 for <iommu@lists.linux-foundation.org>; Tue,  9 Nov 2021 23:10:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B717580F7C
 for <iommu@lists.linux-foundation.org>; Tue,  9 Nov 2021 23:10:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dexD79DBxM7i for <iommu@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 23:10:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com
 [209.85.167.45])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8684F80F73
 for <iommu@lists.linux-foundation.org>; Tue,  9 Nov 2021 23:10:29 +0000 (UTC)
Received: by mail-lf1-f45.google.com with SMTP id c32so1302459lfv.4
 for <iommu@lists.linux-foundation.org>; Tue, 09 Nov 2021 15:10:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=6/AawMmLvnrRM8qcoM5kX5zFFgfGx8/ds9DCBn/vpEk=;
 b=LBj3ooQaYPkqqWh042swn38HybGPjniI6eeZFHWC/4iuTiwbHqvlHhe63vtM66U8GB
 3MONDfyDY5WmXsqxoYQXPNEZMlxv/3Osfy1HTk50fL7BGiSr85BvVhICtZUY/tv/OstX
 w6cpMaVQW4WjKY7UF0H6uCWrmLDN1U1j1oa7Yis3LS4tHBhOMZSikG1xJGyRSFhhSiL9
 6+pxuQMDZqCdq8gp1DUNvmmi7I0RIgk+VPPuw2dWkt3XPIRIuZjaySCm754buDaB0BEX
 MRgaXxS9ChiWRpg3axTz4XW117hgq0S+j1FbXTocAmY9yawxHA25Imjm1lMUIvuAvsiN
 +mZA==
X-Gm-Message-State: AOAM532XkrHcMFvU3n30j1sQ3RKUJ/m4XY0SF/dd02trcJUa6vDbVBoO
 SdUCxvigRaSystqPLYHuz98=
X-Google-Smtp-Source: ABdhPJyJIbZ8sQ4c0SEaltAHCSWz9hftL19U9s5rl0bIZgifXijCztWDXBPCfOPaVtOP8Z8IhNaijw==
X-Received: by 2002:a05:6512:1051:: with SMTP id
 c17mr10667088lfb.35.1636499427526; 
 Tue, 09 Nov 2021 15:10:27 -0800 (PST)
Received: from rocinante ([95.155.85.46])
 by smtp.gmail.com with ESMTPSA id q5sm1921419ljb.125.2021.11.09.15.10.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Nov 2021 15:10:26 -0800 (PST)
Date: Wed, 10 Nov 2021 00:10:25 +0100
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: How to reduce PCI initialization from 5 s (1.5 s adding them to
 IOMMU groups)
Message-ID: <YYr/4VuaXXI0JCJU@rocinante>
References: <de6706b2-4ea5-ce68-6b72-02090b98630f@molgen.mpg.de>
 <YYlb2w1UVaiVYigW@rocinante>
 <4ec8db2c-295a-5060-1c0e-184ee072571e@molgen.mpg.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4ec8db2c-295a-5060-1c0e-184ee072571e@molgen.mpg.de>
Cc: linux-pci@vger.kernel.org, x86@kernel.org,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>
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

SGkgUGF1bCwKCj4gVGhhbmsgeW91IGZvciB5b3VyIHJlcGx5LgoKVGhhbmsgeW91IGZvciBnZXR0
aW5nIGJhY2sgdG8gdXMgd2l0aCBhIGdvb2QgaW5zaWdodC4KClsuLi5dCj4gPiBJIGFtIGN1cmlv
dXMgLSB3aHkgaXMgdGhpcyBhIHByb2JsZW0/ICBBcmUgeW91IHBvd2VyLWN5Y2xpbmcgeW91ciBz
ZXJ2ZXJzCj4gPiBzbyBvZnRlbiB0byB0aGUgcG9pbnQgd2hlcmUgdGhlIGN1bXVsYXRpdmUgdGlt
ZSBzcGVudCBpbiBlbnVtZXJhdGluZyBQQ0kKPiA+IGRldmljZXMgYW5kIGFkZGluZyB0aGVtIGxh
dGVyIHRvIElPTU1VIGdyb3VwcyBpcyBhIHByb2JsZW0/Cj4gPiAKPiA+IEkgYW0gc2ltcGx5IHdv
bmRlcmluZyB3aHkgeW91IGRlY2lkZWQgdG8gc2lnbmFsIG91dCB0aGUgUENJIGVudW1lcmF0aW9u
IGFzCj4gPiBzbG93IGluIHBhcnRpY3VsYXIsIGVzcGVjaWFsbHkgZ2l2ZW4gdGhhdCBhIGxhcmdl
IHNlcnZlciBoYXJkd2FyZSB0ZW5kcyB0bwo+ID4gaGF2ZSAobW9zdCBvZiB0aGUgdGltZSwgYXMg
cGVyIG15IGV4cGVyaWVuY2UpIHJhdGhlciBsb25nIGluaXRpYWxpc2F0aW9uCj4gPiB0aW1lIGVp
dGhlciBmcm9tIGJlaW5nIHBvd2VyZWQgb2ZmIG9yIGFmdGVyIGJlaW5nIHBvd2VyIGN5Y2xlZC4g
IEkgY2FuIHRha2UKPiA+IGEgd2hpbGUgYmVmb3JlIHRoZSBhY3R1YWwgb3BlcmF0aW5nIHN5c3Rl
bSBpdHNlbGYgd2lsbCBzdGFydC4KPiAKPiBJdOKAmXMgbm90IGEgcHJvYmxlbSBwZXIgc2UsIGFu
ZCBtb3JlIGEgcGV0IHBlZXZlIG9mIG1pbmUuIFN5c3RlbXMgZ2V0IGZhc3Rlcgo+IGFuZCBmYXN0
ZXIsIGFuZCBib290dGltZSBzbG93ZXIgYW5kIHNsb3dlci4gT24gZGVza3RvcCBzeXN0ZW1zLCBp
dOKAmXMgbXVjaAo+IG1vcmUgaW1wb3J0YW50IHdpdGggZmlybXdhcmUgbGlrZSBjb3JlYm9vdCB0
YWtpbmcgbGVzcyB0aGFuIG9uZSBzZWNvbmQgdG8KPiBpbml0aWFsaXplIHRoZSBoYXJkd2FyZSBh
bmQgcGFzc2luZyBjb250cm9sIHRvIHRoZSBwYXlsb2FkL29wZXJhdGluZyBzeXN0ZW0uCj4gSWYg
d2UgYXJlIGx1Y2t5LCB3ZSBhcmUgZ29pbmcgdG8gaGF2ZSBzZXJ2ZXJzIHdpdGggRkxPU1MgZmly
bXdhcmUuCj4gCj4gQnV0LCBhbHJlYWR5IG5vdywgdXNpbmcga2V4ZWMgdG8gcmVib290IGEgc3lz
dGVtLCBhdm9pZHMgdGhlIHByb2JsZW1zIHlvdQo+IHBvaW50ZWQgb3V0IG9uIHNlcnZlcnMsIGFu
ZCBiZWluZyBhYmxlIHRvIHJlYm9vdCBhIHN5c3RlbSBhcyBxdWlja2x5IGFzCj4gcG9zc2libGUs
IGxvd2VycyB0aGUgYmFyIGZvciBwZW9wbGUgdG8gcmVib290IHN5c3RlbXMgbW9yZSBvZnRlbiB0
bywgZm9yCj4gZXhhbXBsZSwgc28gdXBkYXRlcyB0YWtlIGVmZmVjdC4KCkEgdmVyeSBnb29kIHBv
aW50IGFib3V0IHRoZSBrZXhlYyB1c2FnZS4KClRoaXMgaXMgZGVmaW5pdGVseSBvZnRlbiBpbnZh
bHVhYmxlIHRvIGdldCBzZWN1cml0eSB1cGRhdGVzIG91dCBvZiB0aGUgZG9vcgpxdWlja2x5LCB1
cGRhdGUga2VybmVsIHZlcnNpb24sIG9yIHdoZW4geW91IHdhbnQgdG8gc3dpdGNoIG9wZXJhdGlu
ZyBzeXN0ZW0KcXVpY2tseSAoYSB0cmljayB0aGF0IGNvbXBhbmllcyBsaWtlIEVxdWluaXggTWV0
YWwgdXNlIHdoZW4gb2ZmZXJpbmcgdGhlaXIKYmFyZW1ldGFsIGFzIGEgc2VydmljZSkuCgo+ID4g
V2UgdGFsa2VkIGFib3V0IHRoaXMgYnJpZWZseSB3aXRoIEJqb3JuLCBhbmQgdGhlcmUgbWlnaHQg
YmUgYW4gb3B0aW9uIHRvCj4gPiBwZXJoYXBzIGFkZCBzb21lIGNhY2hpbmcsIGFzIHdlIHN1c3Bl
Y3QgdGhhdCB0aGUgY3VscHJpdCBoZXJlIGlzIGRvaW5nIFBDSQo+ID4gY29uZmlndXJhdGlvbiBz
cGFjZSByZWFkIGZvciBlYWNoIGRldmljZSwgd2hpY2ggY2FuIGJlIHNsb3cgb24gc29tZQo+ID4g
cGxhdGZvcm1zLgo+ID4gCj4gPiBIb3dldmVyLCB3ZSB3b3VsZCBuZWVkIHRvIHByb2ZpbGUgdGhp
cyB0byBnZXQgc29tZSBxdWFudGl0YXRpdmUgZGF0YSB0byBzZWUKPiA+IHdoZXRoZXIgZG9pbmcg
YW55dGhpbmcgd291bGQgZXZlbiBiZSB3b3J0aHdoaWxlLiAgSXQgd291bGQgZGVmaW5pdGVseSBo
ZWxwCj4gPiB1cyB1bmRlcnN0YW5kIGJldHRlciB3aGVyZSB0aGUgYm90dGxlbmVja3MgcmVhbGx5
IGFyZSBhbmQgb2Ygd2hhdCBtYWduaXR1ZGUuCj4gPiAKPiA+IEkgcGVyc29uYWxseSBkb24ndCBo
YXZlIGFjY2VzcyB0byBzdWNoIGEgbGFyZ2UgaGFyZHdhcmUgbGlrZSB0aGUgb25lIHlvdQo+ID4g
aGF2ZSBhY2Nlc3MgdG8sIHRodXMgSSB3YXMgd29uZGVyaW5nIHdoZXRoZXIgeW91IHdvdWxkIGhh
dmUgc29tZSB0aW1lLCBhbmQKPiA+IGJlIHdpbGxpbmcsIHRvIHByb2ZpbGUgdGhpcyBmb3IgdXMg
b24gdGhlIGhhcmR3YXJlIHlvdSBoYXZlLgo+ID4gCj4gPiBMZXQgbWUga25vdyB3aGF0IGRvIHlv
dSB0aGluaz8KPiAKPiBTb3VuZHMgZ29vZC4gSeKAmWQgYmUgd2lsbGluZyB0byBoZWxwLiBOb3Rl
LCB0aGF0IEkgd29u4oCZdCBoYXZlIHRpbWUgYmVmb3JlCj4gV2VkbmVzZGF5IG5leHQgd2VlayB0
aG91Z2guCgpOb3QgYSBwcm9ibGVtISAgSSBhbSB2ZXJ5IGdyYXRlZnVsIHlvdSBhcmUgd2lsbGlu
ZyB0byBkZXZvdGUgc29tZSBvZiB5b3UKdGltZSB0byBoZWxwIHdpdGggdGhpcy4KCkkgb25seSBo
YXZlIGFjY2VzcyB0byBhIGZldyBzeXN0ZW1zIHN1Y2ggYXMgc29tZSBjb21tb2RpdHkgaGFyZHdh
cmUgbGlrZQphIGRlc2t0b3AgUEMgYW5kIG5vdGVib29rcywgYW5kIHNvbWUgYXNzb3J0ZWQgU29D
cy4gIFRoZXNlIGFyZSBzYWRseSBub3QKZXZlbiBjbG9zZSB0byBhIHByb3BlciBzZXJ2ZXIgcGxh
dGZvcm1zLCBhbmQgdHJ5aW5nIHRvIG1lYXN1cmUgYW55dGhpbmcgb24KdGhlc2UgZG9lcyBub3Qg
cmVhbGx5IHlpZWxkIGFueSB1c2VmdWwgZGF0YSBhcyB0aGUgZGVsYXlzIHJlbGF0ZWQgdG8gUENJ
CmVudW1lcmF0aW9uIG9uIHN0YXJ0dXAgYXJlIHF1aXRlIGluc2lnbmlmaWNhbnQgaW4gY29tcGFy
aXNvbiAtIHRoZXJlIGlzCmp1c3Qgbm90IGVub3VnaCBoYXJkd2FyZSB0aGVyZSwgc28gdG8gc3Bl
YWsuCgpJIGFtIHJlYWxseSBsb29raW5nIGZvcndhcmQgdG8gdGhlIGRhdGEgeW91IGNhbiBnYXRo
ZXIgZm9yIHVzIGFuZCB3aGF0Cmluc2lnaHQgaXQgbWlnaHQgcHJvdmlkZSB1cyB3aXRoLgoKVGhh
bmsgeW91IGFnYWluIQoKCUtyenlzenRvZgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vaW9tbXU=
