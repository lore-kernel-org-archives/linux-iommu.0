Return-Path: <SRS0=kL4S=ZE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3318AC17448
	for <iommu@archiver.kernel.org>; Tue, 12 Nov 2019 10:02:35 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0B5D2084F
	for <iommu@archiver.kernel.org>; Tue, 12 Nov 2019 10:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oVIDt4Yt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0B5D2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C152D156C;
	Tue, 12 Nov 2019 10:02:34 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 463F81567
	for <iommu@lists.linux-foundation.org>;
	Tue, 12 Nov 2019 10:02:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
	[209.85.128.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id AA416DF
	for <iommu@lists.linux-foundation.org>;
	Tue, 12 Nov 2019 10:02:32 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id z26so2381412wmi.4
	for <iommu@lists.linux-foundation.org>;
	Tue, 12 Nov 2019 02:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding:content-language;
	bh=ZV0/xI1cDNWDAAg48JcA6ok2jrNXH3VpcMDZqiMr7I0=;
	b=oVIDt4YtXTKXNM9krSx7RMkK8r+fjJ35bJ8lpRBRuYXC410u/er0oxn8R73DvegE97
	eSSvdbU5bMDRSD5zu58Reg5Iyi2uOh4GMZ/gzsx/atLCDjtSfi/4+xaaplQ4iX9h+Fzi
	5sHfscuNeDiG+pZUgrx05j3rugfj23QMzhNgcwY+FjyxqoXzye3c9AAiUsZXxBFU3yXS
	9YT57qpqCIcdrMNP1on1kK481clziXxRXujGjtt5YdJroPVhO+746HlezpHoatBeNFIQ
	7LKqJ+bOxki1Ow8W5F+unwBVD9Wmi9Rh1g2sey4IWFR1W7LUlWof8eKD2YIjSGJShXlZ
	WFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=ZV0/xI1cDNWDAAg48JcA6ok2jrNXH3VpcMDZqiMr7I0=;
	b=HKYZvMdgKFyS8POUlCuUgTgX9xC8gzPSogCyBA0Av0dnTVrtL5WSLybStF2wo3ammb
	BqA8d9tlc6JaUuyQoQagGOYLpgetevWNfJX5ZDH6q56mEa4GOLA87niWrYn4ICbqzRLr
	lfnwr70uhneIm1c+XGeCcBzzgkyzMFUWdWvcEUAdQDqkU+agXQ1Jd++CO5zap2gLKZk3
	s3htPL6kVBBERN6OeO/euxUZlI34qv6oP2kk5zmXy3XyLm2JgmT5egwX6EE4QGeMmWHC
	I8oq5IY2WArxBgpPK4Z/3TA9bPBNcazAKjwvdB9yY+gdNuCgkuxYWlP/IUHHstd8fEjU
	HhcA==
X-Gm-Message-State: APjAAAWEZPBQyOOo5FPCFVMvGqbJslFGidHZu3XSrMNUFhEdvoZamWck
	+RZ7WFC74acUvei1VAyt/6MIXQ==
X-Google-Smtp-Source: APXvYqzLCvkm7qvFyXa0u7U5lfFZDS5G4zvBKLQqPGTW83KJwLuQTVwDbiqILJp0uaQwb4ST+KcByA==
X-Received: by 2002:a1c:4e1a:: with SMTP id g26mr3232608wmh.138.1573552951206; 
	Tue, 12 Nov 2019 02:02:31 -0800 (PST)
Received: from [10.57.1.46] ([45.135.186.94])
	by smtp.gmail.com with ESMTPSA id w81sm4138966wmg.5.2019.11.12.02.02.16
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 12 Nov 2019 02:02:30 -0800 (PST)
Subject: Re: [PATCH v2 0/8] iommu: Add PASID support to Arm SMMUv3
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20191108152508.4039168-1-jean-philippe@linaro.org>
From: zhangfei <zhangfei.gao@linaro.org>
Message-ID: <8a23f064-129a-02c3-4e14-63db45d7f851@linaro.org>
Date: Tue, 12 Nov 2019 18:02:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191108152508.4039168-1-jean-philippe@linaro.org>
Content-Language: en-US
Cc: mark.rutland@arm.com, robin.murphy@arm.com, guohanjun@huawei.com,
	rjw@rjwysocki.net, robh+dt@kernel.org, sudeep.holla@arm.com,
	zhangfei.gao@linaro.org, will@kernel.org, lenb@kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

CgpPbiAyMDE5LzExLzgg5LiL5Y2IMTE6MjUsIEplYW4tUGhpbGlwcGUgQnJ1Y2tlciB3cm90ZToK
PiBUaGlzIGlzIHZlcnNpb24gMiBvZiB0aGUgc2VyaWVzIEkgc2VudCBhIHdoaWxlIGFnbyBbMV0s
IGFkZGluZyBQQVNJRAo+IHN1cHBvcnQgdG8gdGhlIEFybSBTTU1VdjMgZHJpdmVyLgo+Cj4gQ2hh
bmdlcyBzaW5jZSB2MToKPiAqIERyb3BwZWQgdGhlIHBhdGNoIGFkZGluZyBhdXhpbGlhcnkgZG9t
YWluIHN1cHBvcnQuIEl0J3MgYW4gZWFzeSB3YXkgdG8KPiAgICB0ZXN0IFBBU0lELCBieSBwb3B1
bGF0aW5nIFBBU0lEIGNvbnRleHRzIHVzaW5nIGlvbW11X21hcC91bm1hcCgpLCBidXQKPiAgICBJ
IGRvbid0IGtub3cgaWYgaXQgd2lsbCBldmVyIGhhdmUgcmVhbCB1c2Vycy4KPgo+ICAgIFNpbmNl
IHYxIEkgY2hhbmdlZCBteSB0ZXN0aW5nIGdlYXIsIGFuZCBhbSB1c2luZyB0aGUgemlwIGFjY2Vs
ZXJhdG9yCj4gICAgWzJdIGluc3RlYWQgb2YgYSBzb2Z0d2FyZSBtb2RlbC4gSXQgb25seSB1c2Vz
IFNWQSBhbmQgdGVzdGluZwo+ICAgIGF1eGlsaWFyeSBkb21haW5zIHdvdWxkIHJlcXVpcmUgYWRk
aXRpb25hbCBjaGFuZ2VzIHRoYXQgd291bGQgbmV2ZXIgZ28KPiAgICB1cHN0cmVhbS4gU1ZBIHJl
cXVpcmVzIGFub3RoZXIgMjAgcGF0Y2hlcyAoaW5jbHVkaW5nIEkvTyBwYWdlIGZhdWx0cykKPiAg
ICB0aGF0IEkgd2lsbCBzZW5kIGxhdGVyLCBidXQgYXQgbGVhc3QgSSBrbm93IHRoYXQgdGhpcyB3
aWxsIGdldCB1c2VkLgo+Cj4gKiBpb2FzaWQgcGF0Y2ggaGFzIGJlZW4gY2FycmllZCBieSBKYWNv
YiBhbmQgc2hvdWxkIGJlIG1lcmdlZCBmb3IgdjUuNSBbM10KPgo+ICogU3BsaXQgcGF0Y2ggIkFk
ZCBzdXBwb3J0IGZvciBTdWJzdHJlYW0gSURzIiBpbnRvIHBhdGNoZXMgNCBhbmQgNS4KPgo+ICog
QWRkZWQgSU9SVCBzdXBwb3J0IChwYXRjaCAzKSBhbmQgYWRkcmVzc2VkIG90aGVyIGNvbW1lbnRz
Lgo+Cj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWlvbW11LzIwMTkwNjEwMTg0
NzE0LjY3ODYtMS1qZWFuLXBoaWxpcHBlLmJydWNrZXJAYXJtLmNvbS8KPiBbMl0gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGludXgtaW9tbXUvMTU3MjMzMTIxNi05NTAzLTEtZ2l0LXNlbmQtZW1h
aWwtemhhbmdmZWkuZ2FvQGxpbmFyby5vcmcvCj4gWzNdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xpbnV4LWlvbW11LzE1NzAwNDUzNjMtMjQ4NTYtMS1naXQtc2VuZC1lbWFpbC1qYWNvYi5qdW4u
cGFuQGxpbnV4LmludGVsLmNvbS8KPgo+IEplYW4tUGhpbGlwcGUgQnJ1Y2tlciAoOCk6Cj4gICAg
ZHQtYmluZGluZ3M6IGRvY3VtZW50IFBBU0lEIHByb3BlcnR5IGZvciBJT01NVSBtYXN0ZXJzCj4g
ICAgaW9tbXUvYXJtLXNtbXUtdjM6IFN1cHBvcnQgcGxhdGZvcm0gU1NJRAo+ICAgIEFDUEkvSU9S
VDogU3VwcG9ydCBQQVNJRCBmb3IgcGxhdGZvcm0gZGV2aWNlcwo+ICAgIGlvbW11L2FybS1zbW11
LXYzOiBQcmVwYXJlIGZvciBTU0lEIHN1cHBvcnQKPiAgICBpb21tdS9hcm0tc21tdS12MzogQWRk
IHN1cHBvcnQgZm9yIFN1YnN0cmVhbSBJRHMKPiAgICBpb21tdS9hcm0tc21tdS12MzogQWRkIHNl
Y29uZCBsZXZlbCBvZiBjb250ZXh0IGRlc2NyaXB0b3IgdGFibGUKPiAgICBpb21tdS9hcm0tc21t
dS12MzogSW1wcm92ZSBhZGRfZGV2aWNlKCkgZXJyb3IgaGFuZGxpbmcKPiAgICBpb21tdS9hcm0t
c21tdS12MzogQWRkIHN1cHBvcnQgZm9yIFBDSSBQQVNJRApUaGFua3MgSmVhbiBmb3IgdGhlIHBh
dGNoClRoZSBzZXJpZXMgdGVzdGVkIHdlbGwgb24gSGlzaWxpY29uIHBsYXRmb3JtIEt1blBlbmc5
MjAKVGVzdGVkLWJ5OiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BsaW5hcm8ub3JnPgoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxp
bmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
