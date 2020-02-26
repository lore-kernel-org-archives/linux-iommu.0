Return-Path: <SRS0=g0Sk=4O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34248C4BA0A
	for <iommu@archiver.kernel.org>; Wed, 26 Feb 2020 01:11:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB78722464
	for <iommu@archiver.kernel.org>; Wed, 26 Feb 2020 01:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o80oA2ww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB78722464
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BE40B203C4;
	Wed, 26 Feb 2020 01:11:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SnLjqS6tseOD; Wed, 26 Feb 2020 01:11:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id EB2912010C;
	Wed, 26 Feb 2020 01:11:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D994CC18DA;
	Wed, 26 Feb 2020 01:11:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A295C0177
 for <iommu@lists.linux-foundation.org>; Wed, 26 Feb 2020 01:11:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 68D7A84B6A
 for <iommu@lists.linux-foundation.org>; Wed, 26 Feb 2020 01:11:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QBI7Il7GAVmU for <iommu@lists.linux-foundation.org>;
 Wed, 26 Feb 2020 01:11:37 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A5E948266F
 for <iommu@lists.linux-foundation.org>; Wed, 26 Feb 2020 01:11:37 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id y5so507904pfb.11
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 17:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=p+ckrLz3LRCoSFrfiU30gmbNyc8j6wjK1s1RA2TWajk=;
 b=o80oA2wwqENPftna7/zKRVKoL3DudW8CJuoNGJhKQurPflg4m7wY+s5rdqW1b+zdpW
 LoZWVXYuj2kyYWbb2fGxrBwXJpDzoAR7jwOjWCAh/sMSzynLVtPA7Jitj9iy3uJZeokJ
 BVZn+tnxjRxDXBaXScRBqhEb0zR8BnO6rSER1IyfwRTrfcHXbJ8p3T+zM9czSbbr4SMo
 0F5uag648+xMEEUTw6hyV+t66j69cLVziSXZ+qdsWweHC2VOPCrXrEGbUo6GZYMxVzvY
 aUIj/DiaWh8dZVW91xEsFwPIn1D4mAJUmGxxLjyYMHaRlpQYDeUO5fPrKkyqgjV55xXz
 l9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=p+ckrLz3LRCoSFrfiU30gmbNyc8j6wjK1s1RA2TWajk=;
 b=kEzAzGnVsqo4bXl0lH+QbxcEeolph2nppKRTw5QNE9A5oIkYwI9DGnQ7mGpBGhusfo
 itCmaT4P5kdv/iWpUTfyi9WpDBOYC73aOxudTGrGoWST3s1Gn3fr8Jl4Rgq30YElFAAf
 VtZtZ8T+8MYSl44Bd0qCs+frjdv0G8u6wlwVHTJKvpPngB4ijDJwwXje0nDZUKJNiOWJ
 RDyAKF1j9W74s9lftzRF1fMKmG8/fgsp4D8P0Q7Fk4jyJB5FIXVpxuA5/GBXiNb817s8
 emQxPxiX5heMURPfHwULYZoKp/r9Ilvvw9rY43o57ku5mfrKoxCYccL2GWRKUwz6CZqR
 lYcA==
X-Gm-Message-State: APjAAAUu2RB+cUG/ltNDkNl21bA0fCVwN7zfwAO51WjYZQMoVjmtg4KA
 GZlqdq9bJXqYs95Tjxktd1fZPPZxCaM=
X-Google-Smtp-Source: APXvYqwBrVhiEx4l0romklhpTH+y+CgXMko1VU+ZOxfZOJLkAj7ZLDO3KH4v0RJodC8aSrvfaOpG6g==
X-Received: by 2002:a62:19d1:: with SMTP id 200mr1501438pfz.26.1582679497101; 
 Tue, 25 Feb 2020 17:11:37 -0800 (PST)
Received: from ?IPv6:240e:362:4c3:8800:a057:bb7f:18d7:2e?
 ([240e:362:4c3:8800:a057:bb7f:18d7:2e])
 by smtp.gmail.com with ESMTPSA id z10sm204892pgz.88.2020.02.25.17.11.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 17:11:36 -0800 (PST)
Subject: Re: [PATCH] MAINTAINERS: add maintainers for uacce
To: Dave Jiang <dave.jiang@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Herbert Xu <herbert@gondor.apana.org.au>,
 jonathan.cameron@huawei.com, grant.likely@arm.com,
 jean-philippe <jean-philippe@linaro.org>, Jerome Glisse
 <jglisse@redhat.com>, ilias.apalodimas@linaro.org, francois.ozog@linaro.org,
 kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
 "haojian . zhuang" <haojian.zhuang@linaro.org>, guodong.xu@linaro.org
References: <1582611475-32691-1-git-send-email-zhangfei.gao@linaro.org>
 <b424d911-7293-0048-3270-0f7c1502c928@intel.com>
From: zhangfei <zhangfei.gao@linaro.org>
Message-ID: <0ed68faa-63f1-2bcb-6044-11629a610b9b@linaro.org>
Date: Wed, 26 Feb 2020 09:11:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b424d911-7293-0048-3270-0f7c1502c928@intel.com>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-accelerators@lists.ozlabs.org, linux-crypto@vger.kernel.org
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

CgpPbiAyMDIwLzIvMjYg5LiK5Y2IMTI6MDIsIERhdmUgSmlhbmcgd3JvdGU6Cj4KPgo+IE9uIDIv
MjQvMjAgMTE6MTcgUE0sIFpoYW5nZmVpIEdhbyB3cm90ZToKPj4gQWRkIFpoYW5nZmVpIEdhbyBh
bmQgWmhvdSBXYW5nIGFzIG1haW50YWluZXJzIGZvciB1YWNjZQo+Pgo+PiBTaWduZWQtb2ZmLWJ5
OiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BsaW5hcm8ub3JnPgo+PiBTaWduZWQtb2ZmLWJ5
OiBaaG91IFdhbmcgPHdhbmd6aG91MUBoaXNpbGljb24uY29tPgo+PiAtLS0KPj4gwqAgTUFJTlRB
SU5FUlMgfCAxMCArKysrKysrKysrCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25z
KCspCj4+Cj4+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTCj4+IGluZGV4
IDM4ZmUyZjMuLjIyZTY0N2YgMTAwNjQ0Cj4+IC0tLSBhL01BSU5UQUlORVJTCj4+ICsrKyBiL01B
SU5UQUlORVJTCj4+IEBAIC0xNzAzOSw2ICsxNzAzOSwxNiBAQCBXOsKgwqDCoCBodHRwOi8vbGlu
dXh0di5vcmcKPj4gwqAgUzrCoMKgwqAgTWFpbnRhaW5lZAo+PiDCoCBGOsKgwqDCoCBkcml2ZXJz
L21lZGlhL3BjaS90dzY4NngvCj4+IMKgICtVQUNDRSBBQ0NFTEVSQVRPUiBGUkFNRVdPUksKPj4g
K006wqDCoMKgIFpoYW5nZmVpIEdhbyA8emhhbmdmZWkuZ2FvQGxpbmFyby5vcmc+Cj4+ICtNOsKg
wqDCoCBaaG91IFdhbmcgPHdhbmd6aG91MUBoaXNpbGljb24uY29tPgo+PiArUzrCoMKgwqAgTWFp
bnRhaW5lZAo+PiArRjrCoMKgwqAgRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1kcml2
ZXItdWFjY2UKPj4gK0Y6wqDCoMKgIERvY3VtZW50YXRpb24vbWlzYy1kZXZpY2VzL3VhY2NlLnJz
dAo+PiArRjrCoMKgwqAgZHJpdmVycy9taXNjL3VhY2NlLwo+PiArRjrCoMKgwqAgaW5jbHVkZS9s
aW51eC91YWNjZS5oCj4+ICtGOsKgwqDCoCBpbmNsdWRlL3VhcGkvbWlzYy91YWNjZS8KPgo+IE1h
aWxpbmcgbGlzdCBmb3IgcGF0Y2ggc3VibWlzc2lvbj8KPiArTDogbGludXgtYWNjZWxlcmF0b3Jz
QGxpc3RzLm96bGFicy5vcmcgPwoKVGhhbmtzIERhdmUKCkhvdyBhYm91dCBhZGRpbmcgYm90aAps
aW51eC1hY2NlbGVyYXRvcnNAbGlzdHMub3psYWJzLm9yZwpsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnClNpbmNlIHRoZSBwYXRjaGVzIHdpbGwgZ28gdG8gbWlzYyB0cmVlLgoKVGhhbmtzCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxp
bmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
