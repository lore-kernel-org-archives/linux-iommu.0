Return-Path: <SRS0=p6pp=3K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F049C2D0DB
	for <iommu@archiver.kernel.org>; Tue, 21 Jan 2020 15:32:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2937624125
	for <iommu@archiver.kernel.org>; Tue, 21 Jan 2020 15:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L+6DmM/k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2937624125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 025F88660A;
	Tue, 21 Jan 2020 15:32:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3w7Bzbk9Is+9; Tue, 21 Jan 2020 15:32:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C69FF87327;
	Tue, 21 Jan 2020 15:32:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89404C1D80;
	Tue, 21 Jan 2020 15:32:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9093C0174
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jan 2020 15:32:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9155F87327
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jan 2020 15:32:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G7W2PRBiwDOi for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jan 2020 15:32:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-il1-f196.google.com (mail-il1-f196.google.com
 [209.85.166.196])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B36D18660A
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jan 2020 15:32:16 +0000 (UTC)
Received: by mail-il1-f196.google.com with SMTP id x5so2674434ila.6
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jan 2020 07:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QuY0WDhZX4kxz2cZdcfoWX6pS1PqJixvjT3hklrb4bg=;
 b=L+6DmM/kq/25mWwwyfuJL5puz+XC8sQxXxmq4SEsjcjIrwPeY2MlaTK+KdFs0tUjpx
 e9TsO6QoiGoo8N8SYntD/DxXCbi1YZvH7iN2RdjPK7Wc4cGsN53XBYakvS9cUL9SAqI/
 RwQuKwy2Lk20eL6NfyGHqSaKkBLw3YLyu6U7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QuY0WDhZX4kxz2cZdcfoWX6pS1PqJixvjT3hklrb4bg=;
 b=aZpZiqG/URo7lLfXFJ+k+8UcC1qfBHH+9LjchuvIBZGI29TJaBwmhYcAXD78pyaN2B
 jN17PXREOSR0JfwmngADWhquEVkC29X42NcadyKq+a6hiDADpofilAhV8hf+igfEd2Ye
 PRzlQOx1LUcervo/u25X/I4kReJEVG7/xyN8oJYY7FF3OUGU/gf4jc9FqgF+NJQvboZL
 nyGhl7namYoGiaCxmKcuQDMVAJfj6QphQJYCHhqS94WoH2ThQZbL/oGhgmv703+OAc8q
 0jDSwTq+6Pin7LsJXi3kBYvM87I9N7lk1l948LVxQamYOX2cdvs8uP9iYM0+gyuceDuV
 KnBg==
X-Gm-Message-State: APjAAAUujBALytbmdNa/0PabgCZDdoXT1+9hAdtYjtpiFxkpZRwM5NGj
 avjhea/IcBHoFLgvvTLmJmyauLFO
X-Google-Smtp-Source: APXvYqz1a7VeH+whoGCCHkXj0ItYcUpJAraf63WTQVy3Nt9rZk1Rr6eVt72xptU5ReCjjNvMp5HCSA==
X-Received: by 2002:a05:6e02:c83:: with SMTP id
 b3mr4035768ile.29.1579620735950; 
 Tue, 21 Jan 2020 07:32:15 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net.
 [24.9.64.241])
 by smtp.gmail.com with ESMTPSA id r14sm13344854ilg.59.2020.01.21.07.32.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2020 07:32:15 -0800 (PST)
Subject: Re: [PATCH] iommu: amd: Fix IOMMU perf counter clobbering during init
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Joerg Roedel <joro@8bytes.org>
References: <20200114151220.29578-1-skhan@linuxfoundation.org>
 <20200117100829.GE15760@8bytes.org>
 <42c0a806-9947-1401-9754-8aa88bd7062f@amd.com>
From: Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <24a46b0f-33d7-5f94-661a-80f035213892@linuxfoundation.org>
Date: Tue, 21 Jan 2020 08:32:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <42c0a806-9947-1401-9754-8aa88bd7062f@amd.com>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
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

T24gMS8yMC8yMCA3OjEwIFBNLCBTdXJhdmVlIFN1dGhpa3VscGFuaXQgd3JvdGU6Cj4gT24gMS8x
Ny8yMDIwIDU6MDggUE0sIEpvZXJnIFJvZWRlbCB3cm90ZToKPj4gQWRkaW5nIFN1cmF2ZWUsIHdo
byB3cm90ZSB0aGUgSU9NTVUgUGVyZiBDb3VudGVyIGNvZGUuCj4+Cj4+IE9uIFR1ZSwgSmFuIDE0
LCAyMDIwIGF0IDA4OjEyOjIwQU0gLTA3MDAsIFNodWFoIEtoYW4gd3JvdGU6Cj4+PiBpbml0X2lv
bW11X3BlcmZfY3RyKCkgY2xvYmJlcnMgdGhlIHJlZ2lzdGVyIHdoZW4gaXQgY2hlY2tzIHdyaXRl
IGFjY2Vzcwo+Pj4gdG8gSU9NTVUgcGVyZiBjb3VudGVycyBhbmQgZmFpbHMgdG8gcmVzdG9yZSB3
aGVuIHRoZXkgYXJlIHdyaXRhYmxlLgo+Pj4KPj4+IEFkZCBzYXZlIGFuZCByZXN0b3JlIHRvIGZp
eCBpdC4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBTaHVhaCBLaGFuPHNraGFuQGxpbnV4Zm91bmRh
dGlvbi5vcmc+Cj4+PiAtLS0KPj4+IMKgIGRyaXZlcnMvaW9tbXUvYW1kX2lvbW11X2luaXQuYyB8
IDIyICsrKysrKysrKysrKysrKystLS0tLS0KPj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNl
cnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQo+PiBTdXJhdmVlLCBjYW4geW91IHBsZWFzZSByZXZp
ZXcgdGhpcyBwYXRjaD8KPj4KPiAKPiBUaGlzIGxvb2tzIG9rLiBEb2VzIHRoaXMgZml4IGNlcnRh
aW4gaXNzdWVzPyBPciBpcyB0aGlzIGp1c3QgZm9yIHNhbml0eS4KCkkgZGlkbid0IG5vdGljZSBh
bnkgcHJvYmxlbXMuIENvdW50ZXJzIGFyZW4ndCB3cml0YWJsZSBvbiBteSBzeXN0ZW0uCkhvd2V2
ZXIsIGl0IGNlcnRhaW5seSBsb29rcyBsaWtlIGEgYm9nIHNpbmNlIHJlZ2lzdGVycyBhcmVuJ3Qg
cmVzdG9yZWQKbGlrZSBpbiBvdGhlciBwbGFjZXMgaW4gdGhpcyBmaWxlIHdoZXJlIHN1Y2ggY2hl
Y2tzIGFyZSBkb25lIG9uIG90aGVyCnJlZ2lzdGVycy4KCkkgc2VlIDIgYmFua3MgYW5kIDQgY291
bnRlcnMgb24gbXkgc3lzdGVtLiBJcyBpdCBzdWZmaWNpZW50IHRvIGNoZWNrCnRoZSBmaXJzdCBi
YW5rIGFuZCBmaXJzdCBjb3VudGVyPyBJbiBvdGhlciB3b3JkcywgaWYgdGhlIGZpcnN0IG9uZQpp
c24ndCB3cml0YWJsZSwgYXJlIGFsbCBjb3VudGVycyBub24td3JpdGFibGU/CgpTaG91bGQgd2Ug
cmVhZCB0aGUgY29uZmlnIGZpcnN0IGFuZCB0aGVuLCB0cnkgdG8gc2VlIGlmIGFueSBvZiB0aGUK
Y291bnRlcnMgYXJlIHdyaXRhYmxlPyBJIGhhdmUgYSBwYXRjaCB0aGF0IGRvZXMgdGhhdCwgSSBj
YW4gc2VuZCBpdApvdXQgZm9yIHJldmlldy4KCj4gCj4gUmV2aWV3ZWQtYnk6IFN1cmF2ZWUgU3V0
aGlrdWxwYW5pdCA8c3VyYXZlZS5zdXRoaWt1bHBhbml0QGFtZC5jb20+ClRoYW5rcyBmb3IgdGhl
IHJldmlldy4KCnRoYW5rcywKLS0gU2h1YWgKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2lvbW11
