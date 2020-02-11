Return-Path: <SRS0=3qjS=37=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9579C3B187
	for <iommu@archiver.kernel.org>; Tue, 11 Feb 2020 07:59:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79213206CC
	for <iommu@archiver.kernel.org>; Tue, 11 Feb 2020 07:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ri9VQfWj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79213206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 43D3C87634;
	Tue, 11 Feb 2020 07:59:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wqBlqwSXHyL9; Tue, 11 Feb 2020 07:59:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id AE0C1875BC;
	Tue, 11 Feb 2020 07:59:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 942BCC1D80;
	Tue, 11 Feb 2020 07:59:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 52232C07FE
 for <iommu@lists.linux-foundation.org>; Tue, 11 Feb 2020 07:59:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 38DB4875CB
 for <iommu@lists.linux-foundation.org>; Tue, 11 Feb 2020 07:59:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RMQzRs1cvpzZ for <iommu@lists.linux-foundation.org>;
 Tue, 11 Feb 2020 07:59:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8A4F3875BC
 for <iommu@lists.linux-foundation.org>; Tue, 11 Feb 2020 07:59:26 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id q8so5088977pfh.7
 for <iommu@lists.linux-foundation.org>; Mon, 10 Feb 2020 23:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=vgfeWj4AjQyurf0xeK1Z635NiCQf4E21yKLT1OZCOxI=;
 b=ri9VQfWjEpKz6UthsEkXDqvnC/vLM4tNXqWeNUw5XE4gn0yaVJfZkwQx4Sur/04JIb
 dRI4HjhUXnEFs97ZzjuEffQhpy0By2DTATHsRhkAXqVliZZ4fHIwvWPO5TnQeWDUnLZg
 TRdgI1Ei0NaaMFLHz8RAGH1G/K0sLzpTYyeoHEtYXyoujCLG0HHwpVteQX1xyBgglG0+
 mB94kh5J+PtLDyeXSmXcseUkKQaf9div3/bJktotIn/0JC76R+oUZmJMIuHKE35UF3fF
 QxxODrdCPPoiz3b3F+66ptTJbFyHIjbsYgGQ9LW4NL086BNGPr2bgIO54+RBmMXNQJWz
 7MbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=vgfeWj4AjQyurf0xeK1Z635NiCQf4E21yKLT1OZCOxI=;
 b=PaoDHVhcZw81WG2Ox6wTw62zr5QYaAE9KI+VOjKksUMkIyROySCAGJOxcLO2hAFTKS
 Mys7kINw31sFCCi9ObSjoVzk6sZM2zmAGNqti1ISWj084ALfo+hSsfmL64uLKhRA401k
 g8hljhYL/NfEQOjyZHBY8i26PsersgiK5Y+O2zEF4ms875JVCbYZ0j5dx/GGvI2vyGe+
 3g0rHs0OKmobZ9Vwky5YhRYXzsj2mMmKC+YFEoXXp645LCOP/+ha/LHUMkJZHyj+FF0l
 VKe8ZTeIgUOjdoMNS/xjCloiFi3TdlYx4KAfkttkcnBPT9ZK7DoJ//wS0LXB7UYmeJT6
 zDAw==
X-Gm-Message-State: APjAAAUOnIg+HdeSqiRAKLI5x5WzdXlMZTd1/xgQIe/koZCMDrriBNGm
 XJVBxL739MNg6W0HAnzNPYGzPw==
X-Google-Smtp-Source: APXvYqxCnM2bUDEVK6wbp7oZd2Lj9/7Nk8QoUV2401OvplRSyHu/dvSNfD4xv8uaAlqj8fId4WKGtQ==
X-Received: by 2002:a63:8743:: with SMTP id i64mr1818578pge.243.1581407966063; 
 Mon, 10 Feb 2020 23:59:26 -0800 (PST)
Received: from [10.96.0.154] ([45.135.186.96])
 by smtp.gmail.com with ESMTPSA id s14sm2573821pgv.74.2020.02.10.23.59.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Feb 2020 23:59:25 -0800 (PST)
Subject: Re: [PATCH v12 2/4] uacce: add uacce driver
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1579097568-17542-1-git-send-email-zhangfei.gao@linaro.org>
 <1579097568-17542-3-git-send-email-zhangfei.gao@linaro.org>
 <20200210233711.GA1787983@kroah.com>
From: zhangfei <zhangfei.gao@linaro.org>
Message-ID: <837da172-1ec7-d077-bf54-18d620b1d3bb@linaro.org>
Date: Tue, 11 Feb 2020 15:59:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200210233711.GA1787983@kroah.com>
Content-Language: en-US
Cc: jean-philippe <jean-philippe@linaro.org>, dave.jiang@intel.com,
 Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
 francois.ozog@linaro.org, linux-accelerators@lists.ozlabs.org,
 ilias.apalodimas@linaro.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
 grant.likely@arm.com, "haojian . zhuang" <haojian.zhuang@linaro.org>,
 linux-crypto@vger.kernel.org, Kenneth Lee <liguozhu@hisilicon.com>,
 guodong.xu@linaro.org, kenneth-lee-2012@foxmail.com
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

CgpPbiAyMDIwLzIvMTEg5LiK5Y2INzozNywgR3JlZyBLcm9haC1IYXJ0bWFuIHdyb3RlOgo+IE9u
IFdlZCwgSmFuIDE1LCAyMDIwIGF0IDEwOjEyOjQ2UE0gKzA4MDAsIFpoYW5nZmVpIEdhbyB3cm90
ZToKPj4gRnJvbTogS2VubmV0aCBMZWUgPGxpZ3Vvemh1QGhpc2lsaWNvbi5jb20+Cj4+Cj4+IFVh
Y2NlIChVbmlmaWVkL1VzZXItc3BhY2UtYWNjZXNzLWludGVuZGVkIEFjY2VsZXJhdG9yIEZyYW1l
d29yaykgdGFyZ2V0cyB0bwo+PiBwcm92aWRlIFNoYXJlZCBWaXJ0dWFsIEFkZHJlc3NpbmcgKFNW
QSkgYmV0d2VlbiBhY2NlbGVyYXRvcnMgYW5kIHByb2Nlc3Nlcy4KPj4gU28gYWNjZWxlcmF0b3Ig
Y2FuIGFjY2VzcyBhbnkgZGF0YSBzdHJ1Y3R1cmUgb2YgdGhlIG1haW4gY3B1Lgo+PiBUaGlzIGRp
ZmZlcnMgZnJvbSB0aGUgZGF0YSBzaGFyaW5nIGJldHdlZW4gY3B1IGFuZCBpbyBkZXZpY2UsIHdo
aWNoIHNoYXJlCj4+IG9ubHkgZGF0YSBjb250ZW50IHJhdGhlciB0aGFuIGFkZHJlc3MuCj4+IFNp
bmNlIHVuaWZpZWQgYWRkcmVzcywgaGFyZHdhcmUgYW5kIHVzZXIgc3BhY2Ugb2YgcHJvY2VzcyBj
YW4gc2hhcmUgdGhlCj4+IHNhbWUgdmlydHVhbCBhZGRyZXNzIGluIHRoZSBjb21tdW5pY2F0aW9u
Lgo+Pgo+PiBVYWNjZSBjcmVhdGUgYSBjaHJkZXYgZm9yIGV2ZXJ5IHJlZ2lzdHJhdGlvbiwgdGhl
IHF1ZXVlIGlzIGFsbG9jYXRlZCB0bwo+PiB0aGUgcHJvY2VzcyB3aGVuIHRoZSBjaHJkZXYgaXMg
b3BlbmVkLiBUaGVuIHRoZSBwcm9jZXNzIGNhbiBhY2Nlc3MgdGhlCj4+IGhhcmR3YXJlIHJlc291
cmNlIGJ5IGludGVyYWN0IHdpdGggdGhlIHF1ZXVlIGZpbGUuIEJ5IG1tYXAgdGhlIHF1ZXVlCj4+
IGZpbGUgc3BhY2UgdG8gdXNlciBzcGFjZSwgdGhlIHByb2Nlc3MgY2FuIGRpcmVjdGx5IHB1dCBy
ZXF1ZXN0cyB0byB0aGUKPj4gaGFyZHdhcmUgd2l0aG91dCBzeXNjYWxsIHRvIHRoZSBrZXJuZWwg
c3BhY2UuCj4+Cj4+IFRoZSBJT01NVSBjb3JlIG9ubHkgdHJhY2tzIG1tPC0+ZGV2aWNlIGJvbmRz
IGF0IHRoZSBtb21lbnQsIGJlY2F1c2UgaXQKPj4gb25seSBuZWVkcyB0byBoYW5kbGUgSU9UTEIg
aW52YWxpZGF0aW9uIGFuZCBQQVNJRCB0YWJsZSBlbnRyaWVzLiBIb3dldmVyCj4+IHVhY2NlIG5l
ZWRzIGEgZmluZXIgZ3JhbnVsYXJpdHkgc2luY2UgbXVsdGlwbGUgcXVldWVzIGZyb20gdGhlIHNh
bWUKPj4gZGV2aWNlIGNhbiBiZSBib3VuZCB0byBhbiBtbS4gV2hlbiB0aGUgbW0gZXhpdHMsIGFs
bCBib3VuZCBxdWV1ZXMgbXVzdAo+PiBiZSBzdG9wcGVkIHNvIHRoYXQgdGhlIElPTU1VIGNhbiBz
YWZlbHkgY2xlYXIgdGhlIFBBU0lEIHRhYmxlIGVudHJ5IGFuZAo+PiByZWFsbG9jYXRlIHRoZSBQ
QVNJRC4KPj4KPj4gQW4gaW50ZXJtZWRpYXRlIHN0cnVjdCB1YWNjZV9tbSBsaW5rcyB1YWNjZSBk
ZXZpY2VzIGFuZCBxdWV1ZXMuCj4+IE5vdGUgdGhhdCBhbiBtbSBtYXkgYmUgYm91bmQgdG8gbXVs
dGlwbGUgZGV2aWNlcyBidXQgYW4gdWFjY2VfbW0KPj4gc3RydWN0dXJlIG9ubHkgZXZlciBiZWxv
bmdzIHRvIGEgc2luZ2xlIGRldmljZSwgYmVjYXVzZSB3ZSBkb24ndCBuZWVkCj4+IGFueXRoaW5n
IG1vcmUgY29tcGxleCAoaWYgbXVsdGlwbGUgZGV2aWNlcyBhcmUgYm91bmQgdG8gb25lIG1tLCB0
aGVuCj4+IHdlJ2xsIGNyZWF0ZSBvbmUgdWFjY2VfbW0gZm9yIGVhY2ggYm9uZCkuCj4+Cj4+ICAg
ICAgICAgIHVhY2NlX2RldmljZSAtLSstLSB1YWNjZV9tbSAtLSstLSB1YWNjZV9xdWV1ZQo+PiAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAnLS0gdWFjY2VfcXVldWUKPj4g
ICAgICAgICAgICAgICAgICAgICAgICAgfAo+PiAgICAgICAgICAgICAgICAgICAgICAgICAnLS0g
dWFjY2VfbW0gLS0rLS0gdWFjY2VfcXVldWUKPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgKy0tIHVhY2NlX3F1ZXVlCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICctLSB1YWNjZV9xdWV1ZQo+Pgo+PiBSZXZpZXdlZC1ieTogSm9uYXRoYW4g
Q2FtZXJvbiA8Sm9uYXRoYW4uQ2FtZXJvbkBodWF3ZWkuY29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBL
ZW5uZXRoIExlZSA8bGlndW96aHVAaGlzaWxpY29uLmNvbT4KPj4gU2lnbmVkLW9mZi1ieTogWmFp
Ym8gWHUgPHh1emFpYm9AaHVhd2VpLmNvbT4KPj4gU2lnbmVkLW9mZi1ieTogWmhvdSBXYW5nIDx3
YW5nemhvdTFAaGlzaWxpY29uLmNvbT4KPj4gU2lnbmVkLW9mZi1ieTogSmVhbi1QaGlsaXBwZSBC
cnVja2VyIDxqZWFuLXBoaWxpcHBlQGxpbmFyby5vcmc+Cj4+IFNpZ25lZC1vZmYtYnk6IFpoYW5n
ZmVpIEdhbyA8emhhbmdmZWkuZ2FvQGxpbmFyby5vcmc+Cj4gTG9va3MgbXVjaCBzYW5lciBub3cs
IHRoYW5rcyBmb3IgYWxsIG9mIHRoZSB3b3JrIG9uIHRoaXM6Cj4KPiBSZXZpZXdlZC1ieTogR3Jl
ZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4KPgo+IE9yIGFtIEkg
c3VwcG9zZWQgdG8gdGFrZSB0aGlzIGluIG15IHRyZWU/ICBJZiBzbywgSSBjYW4sIGJ1dCBJIG5l
ZWQgYW4KPiBhY2sgZm9yIHRoZSBjcnlwdG8gcGFydHMuCj4KPgpUaGF0J3MgR3JlYXQsIHRoYW5r
cyBHcmVnLgoKRm9yIHRoZSBjb252ZW5pZW5jZSwgSSByZWJhc2UgdGhlIHBhdGNoc2V0IG9uIDUu
Ni1yYzEuCk5vdCBzdXJlIGlzIHRoZXJlIGFueSBjb25mbGljdCB0byBjcnlwdG8gdHJlZS4KSG93
IGFib3V0IGp1c3QgcGljayB0aGUgdWFjY2UgcGFydCwgcGF0Y2ggMSAsIDIuCldlIGNhbiByZXNl
bmQgdGhlIGNyeXB0byBwYXJ0IHRvIGNyeXB0byB0cmVlLgoKVGhhbmtzCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9t
bXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
