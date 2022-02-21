Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B662BC43217
	for <iommu@archiver.kernel.org>; Mon, 21 Feb 2022 20:02:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4EDC660B79;
	Mon, 21 Feb 2022 20:02:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gw7Slt2kDKp9; Mon, 21 Feb 2022 20:02:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1766D60B44;
	Mon, 21 Feb 2022 20:02:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED0B5C001A;
	Mon, 21 Feb 2022 20:02:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67ABCC0011
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 20:02:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4CE52408B2
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 20:02:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ri6jWNth1mEy for <iommu@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 20:02:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 51B10408AF
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 20:02:32 +0000 (UTC)
Received: by mail-lf1-x12f.google.com with SMTP id e5so20595114lfr.9
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 12:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=fb+j2sk074uBhHwnP84qNW+Wlx2FB7d28dJPNkXMgrg=;
 b=gfZpsarTMe8zv8kNNuq658hFcX165O74Khr5ONbccSUuNk9HZplFmoclpWHVjrtTP1
 CjB0a7K9VEof0eheFxjkWmb1/BJ3TM3xpxUE8qpaHHfjK/lcJcWQL5+0e/YMOOi57TQO
 tOFQzm9J531Nfysi9H9SFHqFRDal61VkFMN/61bQ7LPvsbWiac7qjr47Wf39nzwi6rhC
 s8R5VqTz32sZJQlodkO5eG4h9VI/ZjdRqH7NP1+wSYeGx6QTtg4yzJheiIvIbKCFzm2v
 CWtpbzNUrZzSH+r8xrS+4iuIcDsucGpyTcRgV33dFhy7Kgyk2V5uOa6YjBXMKz03AvYb
 +6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=fb+j2sk074uBhHwnP84qNW+Wlx2FB7d28dJPNkXMgrg=;
 b=WpxLuSmcx+TFU7QRF1PjCVwZXPotuIiw3i29FHJ7ILpdsN0UzoRSKthij77AdpknXb
 Pa3YGreMuaFQml+4+Ck8JoxRHWGmj7d4Jd5EARwTdxldegpnL9m4HnaML3JOcT+siH6f
 gDznZ1CoeBzfHWLPCdbIXNa7PMGw95J6IG7ze/0s2jWwcFWkXStsjRzGbRmrlk9gNUJ3
 R4+8XxOVQWDfd70rUUTBXg08jU31OuKTPF/kd8jq1JQY1T6h24raqTFwm/u7U0CRV+Lx
 /gfX7b0fLZCqOiLTpxtObbSX8fB5r5wYftAphrKbBVIejp3lY+dMPS3WWCxFJ9wJ3ag3
 Sapw==
X-Gm-Message-State: AOAM531vd611G9cqxP4JjN80IswlbHyNGULMUSzMb1Ej8IC+c2iAhY/f
 fD6r9bqUCfz7xOivwhbBN6o=
X-Google-Smtp-Source: ABdhPJy4/bripNm193lusUsi4gc6siiKT+oZ6eEPNsLASVQRtAyZf8khtnW/p16T4mOlUK/g6+a8vQ==
X-Received: by 2002:a05:6512:3310:b0:443:4c51:6b60 with SMTP id
 k16-20020a056512331000b004434c516b60mr14689786lfe.398.1645473750057; 
 Mon, 21 Feb 2022 12:02:30 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru.
 [109.252.138.165])
 by smtp.googlemail.com with ESMTPSA id v6sm1451504ljd.86.2022.02.21.12.02.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Feb 2022 12:02:29 -0800 (PST)
Message-ID: <bb533634-6cde-3835-db11-7b6191385294@gmail.com>
Date: Mon, 21 Feb 2022 23:02:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 9/9] drm/tegra: Support context isolation
Content-Language: en-US
To: Mikko Perttunen <cyndis@kapsi.fi>, Mikko Perttunen
 <mperttunen@nvidia.com>, thierry.reding@gmail.com, jonathanh@nvidia.com,
 joro@8bytes.org, will@kernel.org, robh+dt@kernel.org, robin.murphy@arm.com
References: <20220218113952.3077606-1-mperttunen@nvidia.com>
 <20220218113952.3077606-10-mperttunen@nvidia.com>
 <2b4dd244-f918-4d26-2322-00a0bb226ccf@gmail.com>
 <ea65fcd6-9451-7f5b-f4a9-57b8575f09ff@kapsi.fi>
From: Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <ea65fcd6-9451-7f5b-f4a9-57b8575f09ff@kapsi.fi>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

MjEuMDIuMjAyMiAxNTowNiwgTWlra28gUGVydHR1bmVuINC/0LjRiNC10YI6Cj4gT24gMi8xOS8y
MiAyMDozNSwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+PiAxOC4wMi4yMDIyIDE0OjM5LCBNaWtr
byBQZXJ0dHVuZW4g0L/QuNGI0LXRgjoKPj4+ICvCoMKgwqAgaWYgKGNvbnRleHQtPm1lbW9yeV9j
b250ZXh0ICYmCj4+PiBjb250ZXh0LT5jbGllbnQtPm9wcy0+Z2V0X3N0cmVhbWlkX29mZnNldCkg
ewo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXl5eCj4+PiArwqDCoMKgwqDCoMKgwqAgaW50
IG9mZnNldCA9Cj4+PiBjb250ZXh0LT5jbGllbnQtPm9wcy0+Z2V0X3N0cmVhbWlkX29mZnNldChj
b250ZXh0LT5jbGllbnQpOwo+Pj4gKwo+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmIChvZmZzZXQgPj0g
MCkgewo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgam9iLT5jb250ZXh0ID0gY29udGV4dC0+
bWVtb3J5X2NvbnRleHQ7Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBqb2ItPmVuZ2luZV9z
dHJlYW1pZF9vZmZzZXQgPSBvZmZzZXQ7Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBob3N0
MXhfY29udGV4dF9nZXQoam9iLT5jb250ZXh0KTsKPj4+ICvCoMKgwqDCoMKgwqDCoCB9Cj4+Cj4+
IFlvdSBzaG91bGQgYnVtcCByZWZjb3VudCB1bmNvbmRpdGlvbmFsbHkgb3IgeW91J2xsIGdldCBy
ZWZjbnQgdW5kZXJmbG93Cj4+IG9uIHB1dCwgd2hlbiBvZmZzZXQgPCAwLgo+IAo+IFRoaXMgcmVm
Y291bnQgaXMgaW50ZW5kZWQgdG8gYmUgZHJvcHBlZCBmcm9tICdyZWxlYXNlX2pvYicsIHdoZXJl
IGl0J3MKPiBkcm9wcGVkIGlmIGpvYi0+Y29udGV4dCBpcyBzZXQsIHdoaWNoIGl0IGlzIGZyb20g
dGhpcyBwYXRoLgo+IAo+Pgo+Pj4gK8KgwqDCoCB9Cj4+PiArCj4+PiDCoMKgwqDCoMKgIC8qCj4+
PiDCoMKgwqDCoMKgwqAgKiBqb2JfZGF0YSBpcyBub3cgcGFydCBvZiBqb2IgcmVmZXJlbmNlIGNv
dW50aW5nLCBzbyBkb24ndAo+Pj4gcmVsZWFzZQo+Pj4gwqDCoMKgwqDCoMKgICogaXQgZnJvbSBo
ZXJlLgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS90ZWdyYS91YXBpLmMgYi9kcml2
ZXJzL2dwdS9kcm0vdGVncmEvdWFwaS5jCj4+PiBpbmRleCA5YWI5MTc5ZDIwMjYuLmJlMzNkYTU0
ZDEyYyAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS90ZWdyYS91YXBpLmMKPj4+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS90ZWdyYS91YXBpLmMKPj4+IEBAIC0zMyw2ICszMyw5IEBAIHN0
YXRpYyB2b2lkIHRlZ3JhX2RybV9jaGFubmVsX2NvbnRleHRfY2xvc2Uoc3RydWN0Cj4+PiB0ZWdy
YV9kcm1fY29udGV4dCAqY29udGV4dCkKPj4+IMKgwqDCoMKgwqAgc3RydWN0IHRlZ3JhX2RybV9t
YXBwaW5nICptYXBwaW5nOwo+Pj4gwqDCoMKgwqDCoCB1bnNpZ25lZCBsb25nIGlkOwo+Pj4gwqAg
K8KgwqDCoCBpZiAoY29udGV4dC0+bWVtb3J5X2NvbnRleHQpCj4+PiArwqDCoMKgwqDCoMKgwqAg
aG9zdDF4X2NvbnRleHRfcHV0KGNvbnRleHQtPm1lbW9yeV9jb250ZXh0KTsKPj4KPj4gVGhlICJp
ZiAoY29udGV4dC0+bWVtb3J5X2NvbnRleHQgJiYKPj4gY29udGV4dC0+Y2xpZW50LT5vcHMtPmdl
dF9zdHJlYW1pZF9vZmZzZXQpIiBhYm92ZSBkb2Vzbid0IG1hdGNoIHRoZSAiaWYKPj4gKGNvbnRl
eHQtPm1lbW9yeV9jb250ZXh0KSIuIFlvdSdsbCBnZXQgcmVmY291bnQgdW5kZXJmbG93Lgo+IAo+
IEFuZCB0aGlzIGRyb3AgaXMgZm9yIHRoZSByZWZjb3VudCBpbXBsaWNpdGx5IGFkZGVkIHdoZW4g
YWxsb2NhdGluZyB0aGUKPiBtZW1vcnkgY29udGV4dCB0aHJvdWdoIGhvc3QxeF9jb250ZXh0X2Fs
bG9jOyBzbyB0aGVzZSB0d28gcGxhY2VzIHNob3VsZAo+IGJlIGluZGVwZW5kZW50Lgo+IAo+IFBs
ZWFzZSBlbGFib3JhdGUgaWYgSSBtaXNzZWQgc29tZXRoaW5nLgoKWW91IG5hbWVkIGNvbnRleHQg
YXMgbWVtb3J5X2NvbnRleHQgYW5kIHRoZW4gaGF2ZQpjb250ZXh0PWNvbnRleHQtPm1lbW9yeV9j
b250ZXh0LiBQbGVhc2UgdHJ5IHRvIGltcHJvdmUgdGhlIHZhcmlhYmxlCm5hbWVzLCBsaWtlIGRy
bV9jdHgtPmhvc3QxeF9jdHggZm9yIGV4YW1wbGUuCgpJJ20gYWxzbyBub3QgYSBiaWcgZmFuIG9m
IHRoZSAiaWYgKHJlZikgcHV0KHJlZikiIHBhdHRlcm4uIFdvbid0IGJlCmJldHRlciB0byBtb3Zl
IGFsbCB0aGUgImlmICghTlVMTCkiIGNoZWNrcyBpbnNpZGUgb2YgZ2V0KCkvcHV0KCkgYW5kCm1h
a2UgdGhlIGludm9jYXRpb25zIHVuY29uZGl0aW9uYWw/Cl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby9pb21tdQ==
