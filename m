Return-Path: <SRS0=4TkS=7K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7429DC433DF
	for <iommu@archiver.kernel.org>; Thu, 28 May 2020 06:47:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3588621531
	for <iommu@archiver.kernel.org>; Thu, 28 May 2020 06:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i9zZJ+TN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3588621531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 09BED8882F;
	Thu, 28 May 2020 06:47:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e1CLBSe-jIRq; Thu, 28 May 2020 06:47:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 037DF885CB;
	Thu, 28 May 2020 06:47:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE98FC088D;
	Thu, 28 May 2020 06:47:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF6BDC016F
 for <iommu@lists.linux-foundation.org>; Thu, 28 May 2020 06:47:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9391E2044F
 for <iommu@lists.linux-foundation.org>; Thu, 28 May 2020 06:47:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QO-JiY9V1HO0 for <iommu@lists.linux-foundation.org>;
 Thu, 28 May 2020 06:47:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com
 [209.85.216.67])
 by silver.osuosl.org (Postfix) with ESMTPS id 577CC20398
 for <iommu@lists.linux-foundation.org>; Thu, 28 May 2020 06:47:10 +0000 (UTC)
Received: by mail-pj1-f67.google.com with SMTP id n15so2587008pjt.4
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 23:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=bofUGbEFbdnCpZWFs8DHvdOjPGm9ZoW5dSffBdf+/48=;
 b=i9zZJ+TNeNvRcNidmG6piUlVvLM12Ql3gwyE+1zs9+dJy5yzwRheejuryIIdaoZ4Oy
 PpqV4KZbIEBAopt3QeSB7kIlzfJ/gbWqRtjQdJUqsTEvr+QSDb1MpiutTS4mt27VJCUT
 wGolKhdBUMCO/4xP7K+wFV4wv+9gh0GtSNTZB22oVGKXEuXTwgUf3S6zOwCFXqSedPwS
 YFXT5ssn5iSuHWecgXg/mm3uDYHzC4v6XDBneViordfQVzOqzgDXeZa++mqrl38Mj+tu
 hrnxug4U/nOg29Qjc/NWFC05jy+tQ7In0/wAskn4wZvpS2yEdT1qW9PePMneSuSNMFTS
 bNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=bofUGbEFbdnCpZWFs8DHvdOjPGm9ZoW5dSffBdf+/48=;
 b=KX8fgUaW8bTKXlCNM6dZA+b0YxNA4iYURM8oXFoEep/dlmF61ngUMVP6WRcbDXHXGI
 xGUUdxQVvNljGIsdeMQRjgUf4r+FQL04kEaQDTVctuQ+c4/FvFapwze0PYI0DjtdQWxK
 Mdliio4F4lSrMZZY+SOux6NETLrFtnAhI0UNz+SYgZFmA66MPK2AKcBrxULt+9ivMMTn
 E979Gvl/KURw8GY3OPh2si7bf2vjQqif5vHCEgc5wTVO0PFrzuGK+rcCHiGlErOwJSfm
 SqugycQDPtD+ov3GKghIaK00OxqaxuGNsdeAHxVllwl2jCkvKTBHv9MryO2yFIEaeH4y
 RHew==
X-Gm-Message-State: AOAM531fhb/799PNeCKuvrXQb73y/oxtI42vuLfzWHOV87OnxaoA1NJE
 4Hs91eytX8bd3A+WI9AS76lVhg==
X-Google-Smtp-Source: ABdhPJxLtsDA5liLh4kIqfAgfwRAV1r9YEZbncwuClIEToyTcjpXKMtzdNc0SaVnvBbQN+Q0kn7IoQ==
X-Received: by 2002:a17:90a:de8b:: with SMTP id
 n11mr2312350pjv.87.1590648429749; 
 Wed, 27 May 2020 23:47:09 -0700 (PDT)
Received: from [10.140.6.42] ([45.135.186.12])
 by smtp.gmail.com with ESMTPSA id 188sm3707241pfu.165.2020.05.27.23.46.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2020 23:47:09 -0700 (PDT)
Subject: Re: [PATCH 0/2] Introduce PCI_FIXUP_IOMMU
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20200527181842.GA256680@bjorn-Precision-5520>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <83bd3d72-3a0c-d9b6-54ad-5bc0dbc5be7d@linaro.org>
Date: Thu, 28 May 2020 14:46:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200527181842.GA256680@bjorn-Precision-5520>
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

SGksIEJqb3JuCgpPbiAyMDIwLzUvMjgg5LiK5Y2IMjoxOCwgQmpvcm4gSGVsZ2FhcyB3cm90ZToK
PiBPbiBUdWUsIE1heSAyNiwgMjAyMCBhdCAwNzo0OTowN1BNICswODAwLCBaaGFuZ2ZlaSBHYW8g
d3JvdGU6Cj4+IFNvbWUgcGxhdGZvcm0gZGV2aWNlcyBhcHBlYXIgYXMgUENJIGJ1dCBhcmUgYWN0
dWFsbHkgb24gdGhlIEFNQkEgYnVzLAo+PiBhbmQgdGhleSBuZWVkIGZpeHVwIGluIGRyaXZlcnMv
cGNpL3F1aXJrcy5jIGhhbmRsaW5nIGlvbW11X2Z3bm9kZS4KPj4gSGVyZSBpbnRyb2R1Y2luZyBQ
Q0lfRklYVVBfSU9NTVUsIHdoaWNoIGlzIGNhbGxlZCBhZnRlciBpb21tdV9md25vZGUKPj4gaXMg
YWxsb2NhdGVkLCBpbnN0ZWFkIG9mIHJldXNpbmcgUENJX0ZJWFVQX0ZJTkFMIHNpbmNlIGl0IHdp
bGwgc2xvdwo+PiBkb3duIGlvbW11IHByb2JpbmcgYXMgYWxsIGRldmljZXMgaW4gZml4dXAgZmlu
YWwgbGlzdCB3aWxsIGJlCj4+IHJlcHJvY2Vzc2VkLCBzdWdnZXN0ZWQgYnkgSm9lcmcsIFsxXQo+
IElzIHRoaXMgc2xvd2Rvd24gc2lnbmlmaWNhbnQ/ICBXZSBhbHJlYWR5IGl0ZXJhdGUgb3ZlciBl
dmVyeSBkZXZpY2UKPiB3aGVuIGFwcGx5aW5nIFBDSV9GSVhVUF9GSU5BTCBxdWlya3MsIHNvIGlm
IHdlIHVzZWQgdGhlIGV4aXN0aW5nCj4gUENJX0ZJWFVQX0ZJTkFMLCB3ZSB3b3VsZG4ndCBiZSBh
ZGRpbmcgYSBuZXcgbG9vcC4gIFdlIHdvdWxkIG9ubHkgYmUKPiBhZGRpbmcgdHdvIG1vcmUgaXRl
cmF0aW9ucyB0byB0aGUgbG9vcCBpbiBwY2lfZG9fZml4dXBzKCkgdGhhdCB0cmllcwo+IHRvIG1h
dGNoIHF1aXJrcyBhZ2FpbnN0IHRoZSBjdXJyZW50IGRldmljZS4gIEkgZG91YnQgdGhhdCB3b3Vs
ZCBiZSBhCj4gbWVhc3VyYWJsZSBzbG93ZG93bi4KSSBkbyBub3Qgbm90aWNlIHRoZSBkaWZmZXJl
bmNlIHdoZW4gY29tcGFyZWQgZml4dXBfaW9tbXUgYW5kIGZpeHVwX2ZpbmFsIAp2aWEgZ2V0X2pp
ZmZpZXNfNjQsCnNpbmNlIGluIG91ciBwbGF0Zm9ybSBubyBvdGhlciBwY2kgZml4dXAgaXMgcmVn
aXN0ZXJlZC4KCkhlcmUgdGhlIHBsYW4gaXMgYWRkaW5nIHBjaV9maXh1cF9kZXZpY2UgaW4gaW9t
bXVfZndzcGVjX2luaXQsCnNvIGlmIHVzaW5nIGZpeHVwX2ZpbmFsIHRoZSBpdGVyYXRpb24gd2ls
bCBiZSBkb25lIGFnYWluIGhlcmUuCgo+Cj4+IEZvciBleGFtcGxlOgo+PiBIaXNpbGljb24gcGxh
dGZvcm0gZGV2aWNlIG5lZWQgZml4dXAgaW4KPj4gZHJpdmVycy9wY2kvcXVpcmtzLmMgaGFuZGxp
bmcgZndzcGVjLT5jYW5fc3RhbGwsIHdoaWNoIGlzIGludHJvZHVjZWQgaW4gWzJdCj4+Cj4+ICtz
dGF0aWMgdm9pZCBxdWlya19odWF3ZWlfcGNpZV9zdmEoc3RydWN0IHBjaV9kZXYgKnBkZXYpCj4+
ICt7Cj4+ICsgICAgc3RydWN0IGlvbW11X2Z3c3BlYyAqZndzcGVjOwo+PiArCj4+ICsgICAgcGRl
di0+ZWV0bHBfcHJlZml4X3BhdGggPSAxOwo+PiArICAgIGZ3c3BlYyA9IGRldl9pb21tdV9md3Nw
ZWNfZ2V0KCZwZGV2LT5kZXYpOwo+PiArICAgIGlmIChmd3NwZWMpCj4+ICsgICAgICAgIGZ3c3Bl
Yy0+Y2FuX3N0YWxsID0gMTsKPj4gK30KPj4gKwo+PiArREVDTEFSRV9QQ0lfRklYVVBfSU9NTVUo
UENJX1ZFTkRPUl9JRF9IVUFXRUksIDB4YTI1MCwgcXVpcmtfaHVhd2VpX3BjaWVfc3ZhKTsKPj4g
K0RFQ0xBUkVfUENJX2lGSVhVUF9JT01NVShQQ0lfVkVORE9SX0lEX0hVQVdFSSwgMHhhMjUxLCBx
dWlya19odWF3ZWlfcGNpZV9zdmEpOwo+Pgo+PiBbMV0gaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQv
bGlzdHMvaW9tbXUvbXNnNDQ1OTEuaHRtbAo+PiBbMl0gaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQv
bGlzdHMvbGludXgtcGNpL21zZzk0NTU5Lmh0bWwKPiBJZiB5b3UgcmVmZXJlbmNlIHRoZXNlIGlu
IHRoZSBjb21taXQgbG9ncywgcGxlYXNlIHVzZSBsb3JlLmtlcm5lbC5vcmcKPiBsaW5rcyBpbnN0
ZWFkIG9mIHNwaW5pY3MuCkdvdCBpdCwgdGhhbmtzIEJqb3JuLgoKCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
