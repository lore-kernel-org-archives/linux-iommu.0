Return-Path: <SRS0=PnSl=7W=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D163DC433E0
	for <iommu@archiver.kernel.org>; Tue,  9 Jun 2020 04:02:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CA352078C
	for <iommu@archiver.kernel.org>; Tue,  9 Jun 2020 04:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EOIGmeR3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CA352078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 59F938729F;
	Tue,  9 Jun 2020 04:02:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3cul2FAKG6qX; Tue,  9 Jun 2020 04:02:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BB4CB8729E;
	Tue,  9 Jun 2020 04:02:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82A84C07FF;
	Tue,  9 Jun 2020 04:02:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C5D3C016F
 for <iommu@lists.linux-foundation.org>; Tue,  9 Jun 2020 04:02:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0EA1A8729F
 for <iommu@lists.linux-foundation.org>; Tue,  9 Jun 2020 04:02:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1uOZYeJep4A2 for <iommu@lists.linux-foundation.org>;
 Tue,  9 Jun 2020 04:02:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com
 [209.85.216.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id F3B448729E
 for <iommu@lists.linux-foundation.org>; Tue,  9 Jun 2020 04:02:10 +0000 (UTC)
Received: by mail-pj1-f68.google.com with SMTP id m2so804588pjv.2
 for <iommu@lists.linux-foundation.org>; Mon, 08 Jun 2020 21:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=HNzwmKC7EPXO6n3v52ZypjHWMqVja532n8n2Tl/XPzU=;
 b=EOIGmeR3il5DVPJCDg4teJziBsjPIErqvQL1NApVhk0fIsJZDquLbvnv9AzOPFDTyM
 0Td9tgAsoePC+8tWwHQb/vU9PYB6G/Oyp14FK2hqZEG9usC/15NBI+bjl7shOVkS9PTS
 doO5YZ3ay6n1fRr9qSicgDl1sKMnJOAKnbUGeudLGxamrgFpyJqMg7/hVpo77ptwayW9
 gKyrCeWWc3sisMbmchG7OqNyEieqbYZexGGErCFQFvIiSgU0duds+YBbyLJBINOegnCw
 yZ0gUZKM/VpvoDsNXIFSXtVpSlXS2LMjFDE0fUXYn6WfLpaSP3YHgKbbD3TgUmNi7e1F
 Z0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=HNzwmKC7EPXO6n3v52ZypjHWMqVja532n8n2Tl/XPzU=;
 b=b+mm8MJtEz6CdAKUeLqMcMOsZJ8iP8ISk/B8+9Px86pCKsCctAUuvoLXWPo4k72XSJ
 NmZYgrlTBXKiTkHtRrhNIxHNuYDcv0xjR3vFiK/ELV3+5jiNIN9BUNz40fwhB4vDHRLX
 e1/pdCgR2+VeImKT/VX0bkokizoQ/nb02dnrz61dtJP8dY5OwHEKpefjOtmz6pK5SrAR
 F1C+7bDKFlRfUxQ+WhOgAj//rNGhkNcSSLjECymrqlA7CWZ5FH0NG/jtUPkKkfKYN2XH
 mZK7wqTJObzpMr+rDIVuXW5bA3T6xvdRlhG66oM5rbHrzzkLB1oMhr/9uHHwI6CYsNuh
 AyGQ==
X-Gm-Message-State: AOAM531JiTZYFJIRkpKeW9tAx9tr6EMB/grSJ5lqC90ymt2huWiRycoM
 Mv57tzRhwllDe6lXS2rjXXbQ+g==
X-Google-Smtp-Source: ABdhPJyCOlAhj/JYQL1lnU7VkdOeuU3CmI3RIp+QFxWZE3BRnL4347U0JAtJdOIRBNQs52eLSw55aw==
X-Received: by 2002:a17:90a:36cf:: with SMTP id
 t73mr2680766pjb.100.1591675330529; 
 Mon, 08 Jun 2020 21:02:10 -0700 (PDT)
Received: from [10.175.1.166] ([45.135.186.20])
 by smtp.gmail.com with ESMTPSA id b24sm8402002pfo.112.2020.06.08.21.02.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2020 21:02:09 -0700 (PDT)
Subject: Re: [PATCH 0/2] Introduce PCI_FIXUP_IOMMU
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20200608164148.GA1394249@bjorn-Precision-5520>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <bcf0a327-87b5-01ff-2f9c-ec6a6bd6c738@linaro.org>
Date: Tue, 9 Jun 2020 12:01:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200608164148.GA1394249@bjorn-Precision-5520>
Content-Language: en-US
Cc: jean-philippe <jean-philippe@linaro.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
 linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hanjun Guo <guohanjun@huawei.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-acpi@vger.kernel.org, linux-crypto@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 kenneth-lee-2012@foxmail.com, linux-arm-kernel@lists.infradead.org,
 Len Brown <lenb@kernel.org>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGksIEJqb3JuCgpPbiAyMDIwLzYvOSDkuIrljYgxMjo0MSwgQmpvcm4gSGVsZ2FhcyB3cm90ZToK
PiBPbiBNb24sIEp1biAwOCwgMjAyMCBhdCAxMDo1NDoxNUFNICswODAwLCBaaGFuZ2ZlaSBHYW8g
d3JvdGU6Cj4+IE9uIDIwMjAvNi82IOS4iuWNiDc6MTksIEJqb3JuIEhlbGdhYXMgd3JvdGU6Cj4+
PiBPbiBUaHUsIEp1biAwNCwgMjAyMCBhdCAwOTozMzowN1BNICswODAwLCBaaGFuZ2ZlaSBHYW8g
d3JvdGU6Cj4+Pj4gT24gMjAyMC82LzIg5LiK5Y2IMTo0MSwgQmpvcm4gSGVsZ2FhcyB3cm90ZToK
Pj4+Pj4gT24gVGh1LCBNYXkgMjgsIDIwMjAgYXQgMDk6MzM6NDRBTSArMDIwMCwgSm9lcmcgUm9l
ZGVsIHdyb3RlOgo+Pj4+Pj4gT24gV2VkLCBNYXkgMjcsIDIwMjAgYXQgMDE6MTg6NDJQTSAtMDUw
MCwgQmpvcm4gSGVsZ2FhcyB3cm90ZToKPj4+Pj4+PiBJcyB0aGlzIHNsb3dkb3duIHNpZ25pZmlj
YW50PyAgV2UgYWxyZWFkeSBpdGVyYXRlIG92ZXIgZXZlcnkgZGV2aWNlCj4+Pj4+Pj4gd2hlbiBh
cHBseWluZyBQQ0lfRklYVVBfRklOQUwgcXVpcmtzLCBzbyBpZiB3ZSB1c2VkIHRoZSBleGlzdGlu
Zwo+Pj4+Pj4+IFBDSV9GSVhVUF9GSU5BTCwgd2Ugd291bGRuJ3QgYmUgYWRkaW5nIGEgbmV3IGxv
b3AuICBXZSB3b3VsZCBvbmx5IGJlCj4+Pj4+Pj4gYWRkaW5nIHR3byBtb3JlIGl0ZXJhdGlvbnMg
dG8gdGhlIGxvb3AgaW4gcGNpX2RvX2ZpeHVwcygpIHRoYXQgdHJpZXMKPj4+Pj4+PiB0byBtYXRj
aCBxdWlya3MgYWdhaW5zdCB0aGUgY3VycmVudCBkZXZpY2UuICBJIGRvdWJ0IHRoYXQgd291bGQg
YmUgYQo+Pj4+Pj4+IG1lYXN1cmFibGUgc2xvd2Rvd24uCj4+Pj4+PiBJIGRvbid0IGtub3cgaG93
IHNpZ25pZmljYW50IGl0IGlzLCBidXQgSSByZW1lbWJlciBwZW9wbGUgY29tcGxhaW5pbmcKPj4+
Pj4+IGFib3V0IGFkZGluZyBuZXcgUENJIHF1aXJrcyBiZWNhdXNlIGl0IHRha2VzIHRvbyBsb25n
IGZvciB0aGVtIHRvIHJ1bgo+Pj4+Pj4gdGhlbSBhbGwuIFRoYXQgd2FzIGluIHRoZSBkaXNjdXNz
aW9uIGFib3V0IHRoZSBxdWlyayBkaXNhYmxpbmcgQVRTIG9uCj4+Pj4+PiBBTUQgU3RvbmV5IHN5
c3RlbXMuCj4+Pj4+Pgo+Pj4+Pj4gU28gaXQgcHJvYmFibHkgZGVwZW5kcyBvbiBob3cgbWFueSBQ
Q0kgZGV2aWNlcyBhcmUgaW4gdGhlIHN5c3RlbSB3aGV0aGVyCj4+Pj4+PiBpdCBjYXVzZXMgYW55
IG1lYXN1cmVhYmxlIHNsb3dkb3duLgo+Pj4+PiBJIGZvdW5kIHRoaXMgWzFdIGZyb20gUGF1bCBN
ZW56ZWwsIHdoaWNoIHdhcyBhIHNsb3dkb3duIGNhdXNlZCBieQo+Pj4+PiBxdWlya191c2JfZWFy
bHlfaGFuZG9mZigpLiAgSSB0aGluayB0aGUgcmVhbCBwcm9ibGVtIGlzIGluZGl2aWR1YWwKPj4+
Pj4gcXVpcmtzIHRoYXQgdGFrZSBhIGxvbmcgdGltZS4KPj4+Pj4KPj4+Pj4gVGhlIFBDSV9GSVhV
UF9JT01NVSB0aGluZ3Mgd2UncmUgdGFsa2luZyBhYm91dCBzaG91bGQgYmUgZmFzdCwgYW5kIG9m
Cj4+Pj4+IGNvdXJzZSwgdGhleSdyZSBvbmx5IHJ1biBmb3IgbWF0Y2hpbmcgZGV2aWNlcyBhbnl3
YXkuICBTbyBJJ2QgcmF0aGVyCj4+Pj4+IGtlZXAgdGhlbSBhcyBQQ0lfRklYVVBfRklOQUwgdGhh
biBhZGQgYSB3aG9sZSBuZXcgcGhhc2UuCj4+Pj4+Cj4+Pj4gVGhhbmtzIEJqb3JuIGZvciB0YWtp
bmcgdGltZSBmb3IgdGhpcy4KPj4+PiBJZiBzbywgaXQgd291bGQgYmUgbXVjaCBzaW1wbGVyLgo+
Pj4+Cj4+Pj4gKysrIGIvZHJpdmVycy9pb21tdS9pb21tdS5jCj4+Pj4gQEAgLTI0MTgsNiArMjQx
OCwxMCBAQCBpbnQgaW9tbXVfZndzcGVjX2luaXQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QK
Pj4+PiBmd25vZGVfaGFuZGxlICppb21tdV9md25vZGUsCj4+Pj4gICDCoMKgwqDCoMKgwqDCoCBm
d3NwZWMtPmlvbW11X2Z3bm9kZSA9IGlvbW11X2Z3bm9kZTsKPj4+PiAgIMKgwqDCoMKgwqDCoMKg
IGZ3c3BlYy0+b3BzID0gb3BzOwo+Pj4+ICAgwqDCoMKgwqDCoMKgwqAgZGV2X2lvbW11X2Z3c3Bl
Y19zZXQoZGV2LCBmd3NwZWMpOwo+Pj4+ICsKPj4+PiArwqDCoMKgwqDCoMKgIGlmIChkZXZfaXNf
cGNpKGRldikpCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGNpX2ZpeHVwX2Rl
dmljZShwY2lfZml4dXBfZmluYWwsIHRvX3BjaV9kZXYoZGV2KSk7Cj4+Pj4gKwo+Pj4+Cj4+Pj4g
VGhlbiBwY2lfZml4dXBfZmluYWwgd2lsbCBiZSBjYWxsZWQgdHdpY2UsIHRoZSBmaXJzdCBpbiBw
Y2lfYnVzX2FkZF9kZXZpY2UuCj4+Pj4gSGVyZSBpbiBpb21tdV9md3NwZWNfaW5pdCBpcyB0aGUg
c2Vjb25kIHRpbWUsIHNwZWNpZmljYWxseSBmb3IgaW9tbXVfZndzcGVjLgo+Pj4+IFdpbGwgc2Vu
ZCB0aGlzIHdoZW4gNS44LXJjMSBpcyBvcGVuLgo+Pj4gV2FpdCwgdGhpcyB3aG9sZSBmaXh1cCBh
cHByb2FjaCBzZWVtcyB3cm9uZyB0byBtZS4gIE5vIG1hdHRlciBob3cgeW91Cj4+PiBkbyB0aGUg
Zml4dXAsIGl0J3Mgc3RpbGwgYSBmaXh1cCwgd2hpY2ggbWVhbnMgaXQgcmVxdWlyZXMgb25nb2lu
Zwo+Pj4gbWFpbnRlbmFuY2UuICBTdXJlbHkgd2UgZG9uJ3Qgd2FudCB0byBoYXZlIHRvIGFkZCB0
aGUgVmVuZG9yL0RldmljZSBJRAo+Pj4gZm9yIGV2ZXJ5IG5ldyBBTUJBIGRldmljZSB0aGF0IGNv
bWVzIGFsb25nLCBkbyB3ZT8KPj4+Cj4+IEhlcmUgdGhlIGZha2UgcGNpIGRldmljZSBoYXMgc3Rh
bmRhcmQgUENJIGNmZyBzcGFjZSwgYnV0IHBoeXNpY2FsCj4+IGltcGxlbWVudGF0aW9uIGlzIGJh
c2Ugb24gQU1CQQo+PiBUaGV5IGNhbiBwcm92aWRlIHBhc2lkIGZlYXR1cmUuCj4+IEhvd2V2ZXIs
Cj4+IDEsIGRvZXMgbm90IHN1cHBvcnQgdGxwIHNpbmNlIHRoZXkgYXJlIG5vdCByZWFsIHBjaSBk
ZXZpY2VzLgo+PiAyLiBkb2VzIG5vdCBzdXBwb3J0IHByaSwgaW5zdGVhZCBzdXBwb3J0IHN0YWxs
IChwcm92aWRlZCBieSBzbW11KQo+PiBBbmQgc3RhbGwgaXMgbm90IGEgcGNpIGZlYXR1cmUsIHNv
IGl0IGlzIG5vdCBkZXNjcmliZWQgaW4gc3RydWN0IHBjaV9kZXYsCj4+IGJ1dCBpbiBzdHJ1Y3Qg
aW9tbXVfZndzcGVjLgo+PiBTbyB3ZSB1c2UgdGhpcyBmaXh1cCB0byB0ZWxsIHBjaSBzeXN0ZW0g
dGhhdCB0aGUgZGV2aWNlcyBjYW4gc3VwcG9ydCBzdGFsbCwKPj4gYW5kIGhlcmVieSBzdXBwb3J0
IHBhc2lkLgo+IFRoaXMgZGlkIG5vdCBhbnN3ZXIgbXkgcXVlc3Rpb24uICBBcmUgeW91IHByb3Bv
c2luZyB0aGF0IHdlIHVwZGF0ZSBhCj4gcXVpcmsgZXZlcnkgdGltZSBhIG5ldyBBTUJBIGRldmlj
ZSBpcyByZWxlYXNlZD8gIEkgZG9uJ3QgdGhpbmsgdGhhdAo+IHdvdWxkIGJlIGEgZ29vZCBtb2Rl
bC4KWWVzLCB5b3UgYXJlIHJpZ2h0LCBidXQgd2UgZG8gbm90IGhhdmUgYW55IGJldHRlciBpZGVh
IHlldC4KQ3VycmVudGx5IHdlIGhhdmUgdGhyZWUgZmFrZSBwY2kgZGV2aWNlcywgd2hpY2ggc3Vw
cG9ydCBzdGFsbCBhbmQgcGFzaWQuCldlIGhhdmUgdG8gbGV0IHBjaSBzeXN0ZW0ga25vdyB0aGUg
ZGV2aWNlIGNhbiBzdXBwb3J0IHBhc2lkLCBiZWNhdXNlIG9mIApzdGFsbCBmZWF0dXJlLCB0aG91
Z2ggbm90IHN1cHBvcnQgcHJpLgpEbyB5b3UgaGF2ZSBhbnkgb3RoZXIgaWRlYXM/CgpUaGFua3MK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFp
bGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
