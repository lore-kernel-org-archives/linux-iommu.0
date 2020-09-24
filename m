Return-Path: <SRS0=ygJE=DB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7334C4363D
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 13:24:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32C962344C
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 13:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uiKhmE03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C962344C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id AF75A86BD5;
	Thu, 24 Sep 2020 13:24:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sTvpMcJOx2EO; Thu, 24 Sep 2020 13:24:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id F41B2869F3;
	Thu, 24 Sep 2020 13:24:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DAE67C0889;
	Thu, 24 Sep 2020 13:24:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94C8BC0051
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 13:24:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 894702E0DB
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 13:24:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pA7WMkwQL6XE for <iommu@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 13:24:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com
 [209.85.167.67])
 by silver.osuosl.org (Postfix) with ESMTPS id 2B8B920367
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 13:24:03 +0000 (UTC)
Received: by mail-lf1-f67.google.com with SMTP id d15so3859399lfq.11
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 06:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=a0b44wmpZAXdgeDz+6AK6vON8+BKifKjFQX2DgcijBs=;
 b=uiKhmE03qTIQPzUGVAGU134Ra6j4F1ArLNVD3F1+grmfz/UW6vh16eI2PuXn2azn2+
 CAz2NfhFYwnzsfBULM+8MpH0Zw5yul8BucieVzM6jRoe3gsKTCGoTu7zDPf3IqER+n4Q
 piq0PzFH7uw29W4/gy6Z9Aw2kHRaYmwInX1A2Ku39VSn2VjNUga8mCcVLNfbZEvpihG+
 aSm6OWBA+8Aeh1FKex8ddsJHnQUIWRugbs5SF7MiO3taXCCI75sKGCtbpNzothYu0vKq
 nw2v4sz5gKFb+nJW1ZHvPKfLL3tIHQAgCc0q89LXr6+t1ZUiPkNhDrn0AuDt6Gd9qLES
 Q7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=a0b44wmpZAXdgeDz+6AK6vON8+BKifKjFQX2DgcijBs=;
 b=Ueb4oQ5fZ74/2WKtWrvcM9XS9NxjnIjK00ZTzGccrO/EuzDcq0bNYJjOZaJfuaFmoz
 T+5Bw32qQKfG4CZsm2U3ojpHtjvtgbY+GnAceGuygo1xGPynwjLASoS/+WKJe61iuLMR
 8OipCOXTLW9M9yoXytXWnXCtVpngtA1PPXXKKlRG4X0MgpvlgvF4T5cyUU0RU3LP/STE
 p0QJfC3efQwjvFDGerwIf84JGXR4XRXk92MuLbPnHr1UIq3MCcPh7liUv7AqeKMdyhgs
 xtFwn5ZYMr74LwvVjlpqibJnBeqRCL60nxSRzyEsjGg7BJXxP2UHRehO3AUxXp8AXR9B
 7HZw==
X-Gm-Message-State: AOAM532Sdd0bSNUEorwIQ3wP3e0nvmx7BwY4ZCwJEw0BvKf3DD/wC1hu
 p+ZKW/j/4QHKA/3FwdaPWIM=
X-Google-Smtp-Source: ABdhPJy1/jtedJafAGvfV5TWDSggzg+bBR8DWYMNwqmNUQtEsFh6DZbgCrxVeJaOg429gUgVx2xKPQ==
X-Received: by 2002:a19:f00e:: with SMTP id p14mr290166lfc.69.1600953841401;
 Thu, 24 Sep 2020 06:24:01 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.googlemail.com with ESMTPSA id j20sm2035934lfe.132.2020.09.24.06.24.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2020 06:24:00 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] dt-bindings: reserved-memory: Document "active"
 property
To: Thierry Reding <thierry.reding@gmail.com>, Joerg Roedel <joro@8bytes.org>
References: <20200904130000.691933-1-thierry.reding@gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <d3d69cb4-b0f9-40b0-b526-52fdc1a4b876@gmail.com>
Date: Thu, 24 Sep 2020 16:23:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200904130000.691933-1-thierry.reding@gmail.com>
Content-Language: en-US
Cc: devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Will Deacon <will@kernel.org>
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

MDQuMDkuMjAyMCAxNTo1OSwgVGhpZXJyeSBSZWRpbmcg0L/QuNGI0LXRgjoKPiBGcm9tOiBUaGll
cnJ5IFJlZGluZyA8dHJlZGluZ0BudmlkaWEuY29tPgo+IAo+IFJlc2VydmVkIG1lbW9yeSByZWdp
b25zIGNhbiBiZSBtYXJrZWQgYXMgImFjdGl2ZSIgaWYgaGFyZHdhcmUgaXMKPiBleHBlY3RlZCB0
byBhY2Nlc3MgdGhlIHJlZ2lvbnMgZHVyaW5nIGJvb3QgYW5kIGJlZm9yZSB0aGUgb3BlcmF0aW5n
Cj4gc3lzdGVtIGNhbiB0YWtlIGNvbnRyb2wuIE9uZSBleGFtcGxlIHdoZXJlIHRoaXMgaXMgdXNl
ZnVsIGlzIGZvciB0aGUKPiBvcGVyYXRpbmcgc3lzdGVtIHRvIGluZmVyIHdoZXRoZXIgdGhlIHJl
Z2lvbiBuZWVkcyB0byBiZSBpZGVudGl0eS0KPiBtYXBwZWQgdGhyb3VnaCBhbiBJT01NVS4KPiAK
PiBTaWduZWQtb2ZmLWJ5OiBUaGllcnJ5IFJlZGluZyA8dHJlZGluZ0BudmlkaWEuY29tPgo+IC0t
LQo+ICAuLi4vYmluZGluZ3MvcmVzZXJ2ZWQtbWVtb3J5L3Jlc2VydmVkLW1lbW9yeS50eHQgICAg
ICAgICAgIHwgNyArKysrKysrCj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykKPiAK
PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jlc2VydmVk
LW1lbW9yeS9yZXNlcnZlZC1tZW1vcnkudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3Jlc2VydmVkLW1lbW9yeS9yZXNlcnZlZC1tZW1vcnkudHh0Cj4gaW5kZXggNGRkMjBk
ZTY5NzdmLi4xNjNkMjkyN2U0ZmMgMTAwNjQ0Cj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3Jlc2VydmVkLW1lbW9yeS9yZXNlcnZlZC1tZW1vcnkudHh0Cj4gKysrIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jlc2VydmVkLW1lbW9yeS9yZXNlcnZl
ZC1tZW1vcnkudHh0Cj4gQEAgLTYzLDYgKzYzLDEzIEBAIHJldXNhYmxlIChvcHRpb25hbCkgLSBl
bXB0eSBwcm9wZXJ0eQo+ICAgICAgICBhYmxlIHRvIHJlY2xhaW0gaXQgYmFjay4gVHlwaWNhbGx5
IHRoYXQgbWVhbnMgdGhhdCB0aGUgb3BlcmF0aW5nCj4gICAgICAgIHN5c3RlbSBjYW4gdXNlIHRo
YXQgcmVnaW9uIHRvIHN0b3JlIHZvbGF0aWxlIG9yIGNhY2hlZCBkYXRhIHRoYXQKPiAgICAgICAg
Y2FuIGJlIG90aGVyd2lzZSByZWdlbmVyYXRlZCBvciBtaWdyYXRlZCBlbHNld2hlcmUuCj4gK2Fj
dGl2ZSAob3B0aW9uYWwpIC0gZW1wdHkgcHJvcGVydHkKPiArICAgIC0gSWYgdGhpcyBwcm9wZXJ0
eSBpcyBzZXQgZm9yIGEgcmVzZXJ2ZWQgbWVtb3J5IHJlZ2lvbiwgaXQgaW5kaWNhdGVzCj4gKyAg
ICAgIHRoYXQgc29tZSBwaWVjZSBvZiBoYXJkd2FyZSBtYXkgYmUgYWN0aXZlbHkgYWNjZXNzaW5n
IHRoaXMgcmVnaW9uLgo+ICsgICAgICBTaG91bGQgdGhlIG9wZXJhdGluZyBzeXN0ZW0gd2FudCB0
byBlbmFibGUgSU9NTVUgcHJvdGVjdGlvbiBmb3IgYQo+ICsgICAgICBkZXZpY2UsIGFsbCBhY3Rp
dmUgbWVtb3J5IHJlZ2lvbnMgbXVzdCBoYXZlIGJlZW4gaWRlbnRpdHktbWFwcGVkCj4gKyAgICAg
IGluIG9yZGVyIHRvIGVuc3VyZSB0aGF0IG5vbi1xdWllc2NlbnQgaGFyZHdhcmUgZHVyaW5nIGJv
b3QgY2FuCj4gKyAgICAgIGNvbnRpbnVlIHRvIGFjY2VzcyB0aGUgbWVtb3J5Lgo+ICAKPiAgTGlu
dXggaW1wbGVtZW50YXRpb24gbm90ZToKPiAgLSBJZiBhICJsaW51eCxjbWEtZGVmYXVsdCIgcHJv
cGVydHkgaXMgcHJlc2VudCwgdGhlbiBMaW51eCB3aWxsIHVzZSB0aGUKPiAKCkhpLAoKQ291bGQg
eW91IHBsZWFzZSBleHBsYWluIHdoYXQgZGV2aWNlcyBuZWVkIHRoaXMgcXVpcms/IEkgc2VlIHRo
YXQgeW91J3JlCnRhcmdldGluZyBUZWdyYSBTTU1VIGRyaXZlciwgd2hpY2ggbWVhbnMgdGhhdCBp
dCBzaG91bGQgYmUgc29tZSBwcmUtVDE4NgpkZXZpY2UuIElzIHRoaXMgcmVzZXJ2YXRpb24gbmVl
ZGVkIGZvciBzb21lIGRldmljZSB0aGF0IGhhcyBkaXNwbGF5CmhhcmR3aXJlZCB0byBhIHZlcnkg
c3BlY2lmaWMgSU9NTVUgZG9tYWluIGF0IHRoZSBib290IHRpbWU/CgpJZiB5b3UncmUgdGFyZ2V0
aW5nIGRldmljZXMgdGhhdCBkb24ndCBoYXZlIElPTU1VIGVuYWJsZWQgYnkgZGVmYXVsdCBhdAp0
aGUgYm9vdCB0aW1lLCB0aGVuIHRoaXMgYXBwcm9hY2ggd29uJ3Qgd29yayBmb3IgdGhlIGV4aXN0
aW5nIGRldmljZXMKd2hpY2ggd29uJ3QgZXZlciBnZXQgYW4gdXBkYXRlZCBib290bG9hZGVyLiBJ
IHRoaW5rIFJvYmluIE11cnBoeSBhbHJlYWR5CnN1Z2dlc3RlZCB0aGF0IHdlIHNob3VsZCBzaW1w
bHkgY3JlYXRlIGEgZHVtbXkgImlkZW50aXR5IiBJT01NVSBkb21haW4KYnkgZGVmYXVsdCBmb3Ig
dGhlIERSTS9WREUgZGV2aWNlcyBhbmQgdGhlbiByZXBsYWNlIGl0IHdpdGggYW4KZXhwbGljaXRs
eSBjcmVhdGVkIGRvbWFpbiB3aXRoaW4gdGhlIGRyaXZlcnMuCgpTZWNvbmRseSwgYWxsIE5WSURJ
QSBib290bG9hZGVycyBhcmUgcGFzc2luZyB0ZWdyYV9mYm1lbT0uLi4gdmlhCmtlcm5lbCdzIGNt
ZGxpbmUgd2l0aCB0aGUgcGh5c2ljYWwgbG9jYXRpb24gb2YgdGhlIGZyYW1lYnVmZmVyIGluCm1l
bW9yeS4gTWF5YmUgd2UgY291bGQgc3VwcG9ydCB0aGlzIG9wdGlvbj8KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
