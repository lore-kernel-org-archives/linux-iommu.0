Return-Path: <SRS0=NWqd=2B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01917C2BD09
	for <iommu@archiver.kernel.org>; Wed, 11 Dec 2019 05:58:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA90E2077B
	for <iommu@archiver.kernel.org>; Wed, 11 Dec 2019 05:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mROG/HOX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA90E2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7796A85F8E;
	Wed, 11 Dec 2019 05:58:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bxx0FzgKg5MO; Wed, 11 Dec 2019 05:57:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0D8CE85E14;
	Wed, 11 Dec 2019 05:57:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D837CC1796;
	Wed, 11 Dec 2019 05:57:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5EE47C0881
 for <iommu@lists.linux-foundation.org>; Wed, 11 Dec 2019 05:57:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4D8B584C78
 for <iommu@lists.linux-foundation.org>; Wed, 11 Dec 2019 05:57:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VOd9kp2f8a-E for <iommu@lists.linux-foundation.org>;
 Wed, 11 Dec 2019 05:57:55 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
 [209.85.214.194])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4794F84993
 for <iommu@lists.linux-foundation.org>; Wed, 11 Dec 2019 05:57:55 +0000 (UTC)
Received: by mail-pl1-f194.google.com with SMTP id g6so969250plp.7
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 21:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=lLapnIIb6lVWR88dgYwHj0pEFw/ZzVii/Ej9vRXRHTM=;
 b=mROG/HOXnDdmgjbz5J5ouZ0n9b8BoMdcOxlbXxqEDlEjoAq7Dntbf93vu7bBjTHium
 kAR7DNGI1KuqmYjaldUi0+7gcE227rB4ZIq9u73q2ekVwwKsF7fNWMrljGVA3U8Cx2zc
 /3zNmHq33VSz2DEMoqccgdoWCigZiyKx+gaqz4PZJGFrGsrx+FqpUo0lT4gbAgDWjvRc
 8rkIqPoeMva5PCorMQUOOARnM7YrnvsEKcY2qShZwkBEyJCKOb7Glgv3iVJWE0hx+l4a
 oYR3satfkmDNaLOG4317KCiIXwzqulGwWmnW/YIK0rjquaVMKbN31pnBC43kBCFdelbQ
 40dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=lLapnIIb6lVWR88dgYwHj0pEFw/ZzVii/Ej9vRXRHTM=;
 b=JZ/P35SFLxn6qzy/qSc3BK/DKKFQHr7B64DZTzn1kNDhVWC+WZ/qExHseWoZa3zysA
 CESTRZ9ynuVeOszHr9+qXuXrcbhenzj6f5rMx3v2grLwzVkYWd8pwEmwL/lxHlMsAE/r
 aJuqW7SXf/dbTDbd243sr5PKW/oq3e6cU9YPEbkGzt36Cg0OKcdK3C1DKKqq5iVQOb0M
 YTS0KBCJTDneJjohk8hnEHoq0AS9FV8vSW5PKlA7f9wFHsLdTh9Nq1Y6YjQHtLFHy1xX
 Ofz/S+a/IrHaa3fINmRayyF8atpyW28eIaCaen1fuZe6/NZ1FkvUTf/BkkapUupDu0AR
 6w/Q==
X-Gm-Message-State: APjAAAXK83KLD5DPNy4Q97ZOoNFLuXLcngfrniHwD/Gj2VxmuvJFLJWa
 ji92GoZ4Ke1KgrZvZ57Xk0ooAw==
X-Google-Smtp-Source: APXvYqzb6DmUBn52QUZxXvhWxCspFS4mNZV2nAvBl5SaYNTj0HvIx72deigYfD3dWXLAJ2R1ktVXxg==
X-Received: by 2002:a17:90a:2808:: with SMTP id
 e8mr1537917pjd.63.1576043465746; 
 Tue, 10 Dec 2019 21:51:05 -0800 (PST)
Received: from ?IPv6:240e:362:417:e00:d1ed:4eb5:7aae:41c8?
 ([240e:362:417:e00:d1ed:4eb5:7aae:41c8])
 by smtp.gmail.com with ESMTPSA id u1sm988461pfn.133.2019.12.10.21.50.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 10 Dec 2019 21:51:04 -0800 (PST)
Subject: Re: [RESEND PATCH v9 2/4] uacce: add uacce driver
To: kbuild test robot <lkp@intel.com>
References: <1575945755-27380-3-git-send-email-zhangfei.gao@linaro.org>
 <201912110600.7K87vvu4%lkp@intel.com>
From: zhangfei <zhangfei.gao@linaro.org>
Message-ID: <9aa3ec9b-6ca3-c8cc-a381-5445d34d0ed5@linaro.org>
Date: Wed, 11 Dec 2019 13:50:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <201912110600.7K87vvu4%lkp@intel.com>
Content-Language: en-US
Cc: jean-philippe <jean-philippe@linaro.org>, kbuild-all@lists.01.org,
 Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
 francois.ozog@linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 ilias.apalodimas@linaro.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
 grant.likely@arm.com, "haojian . zhuang" <haojian.zhuang@linaro.org>,
 linux-accelerators@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 Kenneth Lee <liguozhu@hisilicon.com>, guodong.xu@linaro.org,
 kenneth-lee-2012@foxmail.com
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

CgpPbiAyMDE5LzEyLzExIOS4iuWNiDg6MDksIGtidWlsZCB0ZXN0IHJvYm90IHdyb3RlOgo+IEhp
IFpoYW5nZmVpLAo+Cj4gVGhhbmsgeW91IGZvciB0aGUgcGF0Y2ghIFlldCBzb21ldGhpbmcgdG8g
aW1wcm92ZToKPgo+IFthdXRvIGJ1aWxkIHRlc3QgRVJST1Igb24gY3J5cHRvZGV2L21hc3Rlcl0K
PiBbYWxzbyBidWlsZCB0ZXN0IEVSUk9SIG9uIGNyeXB0by9tYXN0ZXIgY2hhci1taXNjL2NoYXIt
bWlzYy10ZXN0aW5nIHY1LjUtcmMxIG5leHQtMjAxOTEyMTBdCj4gW2lmIHlvdXIgcGF0Y2ggaXMg
YXBwbGllZCB0byB0aGUgd3JvbmcgZ2l0IHRyZWUsIHBsZWFzZSBkcm9wIHVzIGEgbm90ZSB0byBo
ZWxwCj4gaW1wcm92ZSB0aGUgc3lzdGVtLiBCVFcsIHdlIGFsc28gc3VnZ2VzdCB0byB1c2UgJy0t
YmFzZScgb3B0aW9uIHRvIHNwZWNpZnkgdGhlCj4gYmFzZSB0cmVlIGluIGdpdCBmb3JtYXQtcGF0
Y2gsIHBsZWFzZSBzZWUgaHR0cHM6Ly9zdGFja292ZXJmbG93LmNvbS9hLzM3NDA2OTgyXQo+Cj4g
dXJsOiAgICBodHRwczovL2dpdGh1Yi5jb20vMGRheS1jaS9saW51eC9jb21taXRzL1poYW5nZmVp
LUdhby9BZGQtdWFjY2UtbW9kdWxlLWZvci1BY2NlbGVyYXRvci8yMDE5MTIxMC0xNjAyMTAKPiBi
YXNlOiAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2hl
cmJlcnQvY3J5cHRvZGV2LTIuNi5naXQgbWFzdGVyCj4gY29uZmlnOiBzcGFyYzY0LWFsbG1vZGNv
bmZpZyAoYXR0YWNoZWQgYXMgLmNvbmZpZykKPiBjb21waWxlcjogc3BhcmM2NC1saW51eC1nY2Mg
KEdDQykgNy41LjAKPiByZXByb2R1Y2U6Cj4gICAgICAgICAgd2dldCBodHRwczovL3Jhdy5naXRo
dWJ1c2VyY29udGVudC5jb20vaW50ZWwvbGtwLXRlc3RzL21hc3Rlci9zYmluL21ha2UuY3Jvc3Mg
LU8gfi9iaW4vbWFrZS5jcm9zcwo+ICAgICAgICAgIGNobW9kICt4IH4vYmluL21ha2UuY3Jvc3MK
PiAgICAgICAgICAjIHNhdmUgdGhlIGF0dGFjaGVkIC5jb25maWcgdG8gbGludXggYnVpbGQgdHJl
ZQo+ICAgICAgICAgIEdDQ19WRVJTSU9OPTcuNS4wIG1ha2UuY3Jvc3MgQVJDSD1zcGFyYzY0Cj4K
PiBJZiB5b3UgZml4IHRoZSBpc3N1ZSwga2luZGx5IGFkZCBmb2xsb3dpbmcgdGFnCj4gUmVwb3J0
ZWQtYnk6IGtidWlsZCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPgo+Cj4gQWxsIGVycm9ycyAo
bmV3IG9uZXMgcHJlZml4ZWQgYnkgPj4pOgo+Cj4gICAgIGRyaXZlcnMvbWlzYy91YWNjZS91YWNj
ZS5jOjExMjoxNTogZXJyb3I6IHZhcmlhYmxlICd1YWNjZV9zdmFfb3BzJyBoYXMgaW5pdGlhbGl6
ZXIgYnV0IGluY29tcGxldGUgdHlwZQo+ICAgICAgc3RhdGljIHN0cnVjdCBpb21tdV9zdmFfb3Bz
IHVhY2NlX3N2YV9vcHMgPSB7Cj4gICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn4KPiAg
ICAgZHJpdmVycy9taXNjL3VhY2NlL3VhY2NlLmM6MTEzOjM6IGVycm9yOiAnc3RydWN0IGlvbW11
X3N2YV9vcHMnIGhhcyBubyBtZW1iZXIgbmFtZWQgJ21tX2V4aXQnCj4gICAgICAgLm1tX2V4aXQg
PSB1YWNjZV9zdmFfZXhpdCwKPiAgICAgICAgXn5+fn5+fgo+ICAgICBkcml2ZXJzL21pc2MvdWFj
Y2UvdWFjY2UuYzoxMTM6MTM6IHdhcm5pbmc6IGV4Y2VzcyBlbGVtZW50cyBpbiBzdHJ1Y3QgaW5p
dGlhbGl6ZXIKPiAgICAgICAubW1fZXhpdCA9IHVhY2NlX3N2YV9leGl0LAo+ICAgICAgICAgICAg
ICAgICAgXn5+fn5+fn5+fn5+fn4KPiAgICAgZHJpdmVycy9taXNjL3VhY2NlL3VhY2NlLmM6MTEz
OjEzOiBub3RlOiAobmVhciBpbml0aWFsaXphdGlvbiBmb3IgJ3VhY2NlX3N2YV9vcHMnKQo+ICAg
ICBkcml2ZXJzL21pc2MvdWFjY2UvdWFjY2UuYzogSW4gZnVuY3Rpb24gJ3VhY2NlX21tX2dldCc6
Cj4gICAgIGRyaXZlcnMvbWlzYy91YWNjZS91YWNjZS5jOjE0NDoxMjogZXJyb3I6IGltcGxpY2l0
IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uICdpb21tdV9zdmFfYmluZF9kZXZpY2UnOyBkaWQgeW91
IG1lYW4gJ2J1c19maW5kX2RldmljZSc/IFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xh
cmF0aW9uXQo+ICAgICAgICBoYW5kbGUgPSBpb21tdV9zdmFfYmluZF9kZXZpY2UodWFjY2UtPnBh
cmVudCwgbW0sIHVhY2NlX21tKTsKPiAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+
fn5+Cj4gICAgICAgICAgICAgICAgIGJ1c19maW5kX2RldmljZQo+ICAgICBkcml2ZXJzL21pc2Mv
dWFjY2UvdWFjY2UuYzoxNDQ6MTA6IHdhcm5pbmc6IGFzc2lnbm1lbnQgbWFrZXMgcG9pbnRlciBm
cm9tIGludGVnZXIgd2l0aG91dCBhIGNhc3QgWy1XaW50LWNvbnZlcnNpb25dCj4gICAgICAgIGhh
bmRsZSA9IGlvbW11X3N2YV9iaW5kX2RldmljZSh1YWNjZS0+cGFyZW50LCBtbSwgdWFjY2VfbW0p
Owo+ICAgICAgICAgICAgICAgXgo+ICAgICBkcml2ZXJzL21pc2MvdWFjY2UvdWFjY2UuYzoxNDg6
OTogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uICdpb21tdV9zdmFfc2V0
X29wcyc7IGRpZCB5b3UgbWVhbiAnaW9tbXVfc2V0dXBfZG1hX29wcyc/IFstV2Vycm9yPWltcGxp
Y2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQo+ICAgICAgICByZXQgPSBpb21tdV9zdmFfc2V0X29w
cyhoYW5kbGUsICZ1YWNjZV9zdmFfb3BzKTsKPiAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+
fn4KPiAgICAgICAgICAgICAgaW9tbXVfc2V0dXBfZG1hX29wcwo+ICAgICBkcml2ZXJzL21pc2Mv
dWFjY2UvdWFjY2UuYzoxNTI6MjE6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5j
dGlvbiAnaW9tbXVfc3ZhX2dldF9wYXNpZCcgWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVj
bGFyYXRpb25dCj4gICAgICAgIHVhY2NlX21tLT5wYXNpZCA9IGlvbW11X3N2YV9nZXRfcGFzaWQo
aGFuZGxlKTsKPiAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fgo+
Pj4gZHJpdmVycy9taXNjL3VhY2NlL3VhY2NlLmM6MTUzOjI2OiBlcnJvcjogJ0lPTU1VX1BBU0lE
X0lOVkFMSUQnIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKTsgZGlkIHlv
dSBtZWFuICdIVl9NU0lWQUxJRF9JTlZBTElEJz8KPiAgICAgICAgaWYgKHVhY2NlX21tLT5wYXNp
ZCA9PSBJT01NVV9QQVNJRF9JTlZBTElEKQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IF5+fn5+fn5+fn5+fn5+fn5+fn4KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBIVl9N
U0lWQUxJRF9JTlZBTElECj4gICAgIGRyaXZlcnMvbWlzYy91YWNjZS91YWNjZS5jOjE1MzoyNjog
bm90ZTogZWFjaCB1bmRlY2xhcmVkIGlkZW50aWZpZXIgaXMgcmVwb3J0ZWQgb25seSBvbmNlIGZv
ciBlYWNoIGZ1bmN0aW9uIGl0IGFwcGVhcnMgaW4KPiAgICAgZHJpdmVycy9taXNjL3VhY2NlL3Vh
Y2NlLmM6MTY4OjM6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiAnaW9t
bXVfc3ZhX3VuYmluZF9kZXZpY2UnOyBkaWQgeW91IG1lYW4gJ2J1c19maW5kX2RldmljZSc/IFst
V2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQo+ICAgICAgICBpb21tdV9zdmFf
dW5iaW5kX2RldmljZShoYW5kbGUpOwo+ICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fgo+
ICAgICAgICBidXNfZmluZF9kZXZpY2UKPiAgICAgZHJpdmVycy9taXNjL3VhY2NlL3VhY2NlLmM6
IEF0IHRvcCBsZXZlbDoKPj4+IGRyaXZlcnMvbWlzYy91YWNjZS91YWNjZS5jOjI3NDoyMTogZXJy
b3I6IHZhcmlhYmxlICd1YWNjZV92bV9vcHMnIGhhcyBpbml0aWFsaXplciBidXQgaW5jb21wbGV0
ZSB0eXBlCj4gICAgICBzdGF0aWMgY29uc3Qgc3RydWN0IHZtX29wZXJhdGlvbnNfc3RydWN0IHVh
Y2NlX3ZtX29wcyA9IHsKPiAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+
fn5+fn4KPj4+IGRyaXZlcnMvbWlzYy91YWNjZS91YWNjZS5jOjI3NTozOiBlcnJvcjogJ2NvbnN0
IHN0cnVjdCB2bV9vcGVyYXRpb25zX3N0cnVjdCcgaGFzIG5vIG1lbWJlciBuYW1lZCAnY2xvc2Un
Cj4gICAgICAgLmNsb3NlID0gdWFjY2Vfdm1hX2Nsb3NlLAo+ICAgICAgICBefn5+fgo+ICAgICBk
cml2ZXJzL21pc2MvdWFjY2UvdWFjY2UuYzoyNzU6MTE6IHdhcm5pbmc6IGV4Y2VzcyBlbGVtZW50
cyBpbiBzdHJ1Y3QgaW5pdGlhbGl6ZXIKPiAgICAgICAuY2xvc2UgPSB1YWNjZV92bWFfY2xvc2Us
Cj4gICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+Cj4gICAgIGRyaXZlcnMvbWlzYy91YWNj
ZS91YWNjZS5jOjI3NToxMTogbm90ZTogKG5lYXIgaW5pdGlhbGl6YXRpb24gZm9yICd1YWNjZV92
bV9vcHMnKQo+ICAgICBkcml2ZXJzL21pc2MvdWFjY2UvdWFjY2UuYzogSW4gZnVuY3Rpb24gJ3Vh
Y2NlX2ZvcHNfbW1hcCc6Cj4+PiBkcml2ZXJzL21pc2MvdWFjY2UvdWFjY2UuYzoyOTU6MTk6IGVy
cm9yOiAnVk1fRE9OVENPUFknIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9u
KQo+ICAgICAgIHZtYS0+dm1fZmxhZ3MgfD0gVk1fRE9OVENPUFkgfCBWTV9ET05URVhQQU5EIHwg
Vk1fV0lQRU9ORk9SSzsKPiAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+Cj4+PiBk
cml2ZXJzL21pc2MvdWFjY2UvdWFjY2UuYzoyOTU6MzM6IGVycm9yOiAnVk1fRE9OVEVYUEFORCcg
dW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pOyBkaWQgeW91IG1lYW4gJ1ZN
X0RPTlRDT1BZJz8KPiAgICAgICB2bWEtPnZtX2ZsYWdzIHw9IFZNX0RPTlRDT1BZIHwgVk1fRE9O
VEVYUEFORCB8IFZNX1dJUEVPTkZPUks7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIF5+fn5+fn5+fn5+fn4KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgVk1fRE9OVENPUFkKPj4+IGRyaXZlcnMvbWlzYy91YWNjZS91YWNjZS5jOjI5NTo0OTogZXJy
b3I6ICdWTV9XSVBFT05GT1JLJyB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlv
bikKPiAgICAgICB2bWEtPnZtX2ZsYWdzIHw9IFZNX0RPTlRDT1BZIHwgVk1fRE9OVEVYUEFORCB8
IFZNX1dJUEVPTkZPUks7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+Cj4gICAgIGRyaXZlcnMvbWlzYy91YWNjZS91YWNj
ZS5jOiBJbiBmdW5jdGlvbiAndWFjY2VfYWxsb2MnOgo+ICAgICBkcml2ZXJzL21pc2MvdWFjY2Uv
dWFjY2UuYzo1MDI6OTogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uICdp
b21tdV9kZXZfZW5hYmxlX2ZlYXR1cmUnOyBkaWQgeW91IG1lYW4gJ21vZHVsZV9lbmFibGVfcm8n
PyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0KPiAgICAgICAgcmV0ID0g
aW9tbXVfZGV2X2VuYWJsZV9mZWF0dXJlKHBhcmVudCwgSU9NTVVfREVWX0ZFQVRfU1ZBKTsKPiAg
ICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+Cj4gICAgICAgICAgICAgIG1vZHVs
ZV9lbmFibGVfcm8KPiAgICAgZHJpdmVycy9taXNjL3VhY2NlL3VhY2NlLmM6NTAyOjQyOiBlcnJv
cjogJ0lPTU1VX0RFVl9GRUFUX1NWQScgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVu
Y3Rpb24pOyBkaWQgeW91IG1lYW4gJ05PTU1VX1ZNRkxBR1MnPwo+ICAgICAgICByZXQgPSBpb21t
dV9kZXZfZW5hYmxlX2ZlYXR1cmUocGFyZW50LCBJT01NVV9ERVZfRkVBVF9TVkEpOwo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+
fn4KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTk9NTVVf
Vk1GTEFHUwo+ICAgICBkcml2ZXJzL21pc2MvdWFjY2UvdWFjY2UuYzo1MzA6MzogZXJyb3I6IGlt
cGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uICdpb21tdV9kZXZfZGlzYWJsZV9mZWF0dXJl
JzsgZGlkIHlvdSBtZWFuICdtb2R1bGVfZGlzYWJsZV9ybyc/IFstV2Vycm9yPWltcGxpY2l0LWZ1
bmN0aW9uLWRlY2xhcmF0aW9uXQo+ICAgICAgICBpb21tdV9kZXZfZGlzYWJsZV9mZWF0dXJlKHVh
Y2NlLT5wYXJlbnQsIElPTU1VX0RFVl9GRUFUX1NWQSk7Cj4gICAgICAgIF5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn4KPiAgICAgICAgbW9kdWxlX2Rpc2FibGVfcm8KPiAgICAgZHJpdmVycy9taXNj
L3VhY2NlL3VhY2NlLmM6IEluIGZ1bmN0aW9uICd1YWNjZV9yZW1vdmUnOgo+ICAgICBkcml2ZXJz
L21pc2MvdWFjY2UvdWFjY2UuYzo1OTI6NDQ6IGVycm9yOiAnSU9NTVVfREVWX0ZFQVRfU1ZBJyB1
bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbik7IGRpZCB5b3UgbWVhbiAnTk9N
TVVfVk1GTEFHUyc/Cj4gICAgICAgIGlvbW11X2Rldl9kaXNhYmxlX2ZlYXR1cmUodWFjY2UtPnBh
cmVudCwgSU9NTVVfREVWX0ZFQVRfU1ZBKTsKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn4KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBOT01NVV9WTUZMQUdTCj4gICAgIGRyaXZl
cnMvbWlzYy91YWNjZS91YWNjZS5jOiBBdCB0b3AgbGV2ZWw6Cj4gICAgIGRyaXZlcnMvbWlzYy91
YWNjZS91YWNjZS5jOjExMjoyOTogZXJyb3I6IHN0b3JhZ2Ugc2l6ZSBvZiAndWFjY2Vfc3ZhX29w
cycgaXNuJ3Qga25vd24KPiAgICAgIHN0YXRpYyBzdHJ1Y3QgaW9tbXVfc3ZhX29wcyB1YWNjZV9z
dmFfb3BzID0gewo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+
fn4KPj4+IGRyaXZlcnMvbWlzYy91YWNjZS91YWNjZS5jOjI3NDo0MjogZXJyb3I6IHN0b3JhZ2Ug
c2l6ZSBvZiAndWFjY2Vfdm1fb3BzJyBpc24ndCBrbm93bgo+ClRoZSBidWlsZCBpc3N1ZSBjYW4g
YmUgc29sdmVkIGJ5Ci0jaW5jbHVkZSA8bGludXgvZG1hLWlvbW11Lmg+CisjaW5jbHVkZSA8bGlu
dXgvZG1hLW1hcHBpbmcuaD4KKyNpbmNsdWRlIDxsaW51eC9pb21tdS5oPgoKU2luY2UgQ09ORklH
X0lPTU1VX0RNQSBpcyBub3QgZGVmaW5lZCBpbiB0aGUgYXJjaC4KaW5jbHVkZS9saW51eC9kbWEt
aW9tbXUuaAojaWZkZWYgQ09ORklHX0lPTU1VX0RNQQojaW5jbHVkZSA8bGludXgvZG1hLW1hcHBp
bmcuaD4KI2luY2x1ZGUgPGxpbnV4L2lvbW11Lmg+CgpXaWxsIHVwZGF0ZSBsYXRlci4KClRoYW5r
cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBt
YWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
