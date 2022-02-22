Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FB0C433F5
	for <iommu@archiver.kernel.org>; Tue, 22 Feb 2022 11:02:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C3D63813F6;
	Tue, 22 Feb 2022 11:02:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RC11gPFDZSyQ; Tue, 22 Feb 2022 11:02:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5E2818138A;
	Tue, 22 Feb 2022 11:02:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30E92C001A;
	Tue, 22 Feb 2022 11:02:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41961C0011
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 11:02:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2BA5E60EAE
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 11:02:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yyLlW5OIpTdK for <iommu@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 11:02:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6C28860EA5
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 11:02:12 +0000 (UTC)
Received: by mail-lf1-x132.google.com with SMTP id b9so23991087lfv.7
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 03:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=FEr1dmlBfqy5sXD3HLj/KlzbzoUju1Ng5vIhD2tYoCk=;
 b=hnSpJ/7MqXwGc38P5+/jVdY1t3pGZ2iHpclQ2/+v/rF/L2k4WCOAfMLf8/cccWVb1C
 s1vLWucOsp+uZ0Bzd4TlXCRx9udMGJ08XL8FouAPYYkxmfIlHGSP1KWHcCfcEWxkNBuy
 Q3YoOinDU0DsmWtZQ48CEp8uj3Lr+ooVWavekiL43/3ULiDOnJ19mI2kqxEmNn+CcmVh
 /3gZzTSQUW/NUOqiXMTWEIPQVdx5V95gysF/bdIyuvwZ6SVJWVJsY0dHBCQE7A1BvRJI
 9ZHPKHCa2oi+73iL8iBqRZ1O/1juwfISS3bKQe4uqFwKWpqi+PRj19RntWVziCX4T/oy
 D4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=FEr1dmlBfqy5sXD3HLj/KlzbzoUju1Ng5vIhD2tYoCk=;
 b=2GkYa5lXAO8CEcNN5CBNlYh7a7DqzjWGoGiiFiuYTjaFjL2p/RGIGXGB1klg8B7t4/
 pyqHKnHl49ogEnhA6F0ZQGHnIBZzr8pDJhm37ohnUUsXovkNvuM49tOXBmM4H+PHPnur
 N1ImgUvMQhAkc0jQIrdpphGUNgTRPWbmG+Ka+5/ZaGcrEWrYt4M+RqhVFGyBsI6Rm1TC
 acJqEkxXvy+qW8rh4ioabcvDDFTJtyQV2OhdCouAo6s1vVZA2QB0wR4gr6yaeRZqmZ2q
 jePkzD31W+AILzexI5qoNQUw1uQJQUqnS4qZZuFUH3XsltPRs+VmzMVQ6m052C/4Hrit
 PKwQ==
X-Gm-Message-State: AOAM531R/VI6JMWolqZUTBUyXgO2TJruxpHziG0EPgJ65/xanyUc2n40
 jEf6fialPZWXEocT492bdhU=
X-Google-Smtp-Source: ABdhPJynaoI+/XmYPUSX1yz2BgAVDgkX9V5kPsQkAvgnbnw1gWNWYK5gRqWCmMUOwD33fRqB/rj21A==
X-Received: by 2002:a05:6512:3748:b0:443:c3f0:6691 with SMTP id
 a8-20020a056512374800b00443c3f06691mr12238118lfs.603.1645527730316; 
 Tue, 22 Feb 2022 03:02:10 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru.
 [109.252.138.165])
 by smtp.googlemail.com with ESMTPSA id t1sm1360167lfr.8.2022.02.22.03.02.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Feb 2022 03:02:09 -0800 (PST)
Message-ID: <3b0b8b41-ddf0-3b83-5edd-8768393ad201@gmail.com>
Date: Tue, 22 Feb 2022 14:02:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 8/9] drm/tegra: vic: Implement get_streamid_offset
Content-Language: en-US
To: Mikko Perttunen <cyndis@kapsi.fi>, Mikko Perttunen
 <mperttunen@nvidia.com>, thierry.reding@gmail.com, jonathanh@nvidia.com,
 joro@8bytes.org, will@kernel.org, robh+dt@kernel.org, robin.murphy@arm.com
References: <20220218113952.3077606-1-mperttunen@nvidia.com>
 <20220218113952.3077606-9-mperttunen@nvidia.com>
 <b1df816b-6838-c435-1a23-5029144e4cfe@gmail.com>
 <7f4e4c47-59f1-1def-36bf-a2ded912f76d@gmail.com>
 <5d1b6e82-2c9d-8388-697f-0d7305a1206f@kapsi.fi>
 <ee648994-b296-2ac4-a676-ddcac463a428@gmail.com>
 <30033f5b-3fd1-22c7-896b-af034a4041df@kapsi.fi>
 <4352fda7-ecb6-4a5e-7d6c-a50537d8eaff@gmail.com>
 <b947e0b2-a78d-bacf-0d78-b5d57e821e6e@kapsi.fi>
From: Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <b947e0b2-a78d-bacf-0d78-b5d57e821e6e@kapsi.fi>
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

MjIuMDIuMjAyMiAxMzo1NCwgTWlra28gUGVydHR1bmVuINC/0LjRiNC10YI6Cj4gT24gMi8yMi8y
MiAxMjo0NiwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+PiAyMi4wMi4yMDIyIDExOjI3LCBNaWtr
byBQZXJ0dHVuZW4g0L/QuNGI0LXRgjoKPj4+IE9uIDIvMjEvMjIgMjI6MTAsIERtaXRyeSBPc2lw
ZW5rbyB3cm90ZToKPj4+PiAyMS4wMi4yMDIyIDE0OjQ0LCBNaWtrbyBQZXJ0dHVuZW4g0L/QuNGI
0LXRgjoKPj4+Pj4gT24gMi8xOS8yMiAyMDo1NCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+Pj4+
Pj4gMTkuMDIuMjAyMiAyMTo0OSwgRG1pdHJ5IE9zaXBlbmtvINC/0LjRiNC10YI6Cj4+Pj4+Pj4g
MTguMDIuMjAyMiAxNDozOSwgTWlra28gUGVydHR1bmVuINC/0LjRiNC10YI6Cj4+Pj4+Pj4+ICtz
dGF0aWMgaW50IHZpY19nZXRfc3RyZWFtaWRfb2Zmc2V0KHN0cnVjdCB0ZWdyYV9kcm1fY2xpZW50
Cj4+Pj4+Pj4+ICpjbGllbnQpCj4+Pj4+Pj4+ICt7Cj4+Pj4+Pj4+ICvCoMKgwqAgc3RydWN0IHZp
YyAqdmljID0gdG9fdmljKGNsaWVudCk7Cj4+Pj4+Pj4+ICvCoMKgwqAgaW50IGVycjsKPj4+Pj4+
Pj4gKwo+Pj4+Pj4+PiArwqDCoMKgIGVyciA9IHZpY19sb2FkX2Zpcm13YXJlKHZpYyk7Cj4+Pj4+
Pj4KPj4+Pj4+PiBZb3UgY2FuJ3QgaW52b2tlIHZpY19sb2FkX2Zpcm13YXJlKCkgd2hpbGUgUlBN
IGlzIHN1c3BlbmRlZC4gRWl0aGVyCj4+Pj4+Pj4gcmVwbGFjZSB0aGlzIHdpdGggUlBNIGdldC9w
dXQgb3IgZG8gc29tZXRoaW5nIGVsc2UuCj4+Pj4+Cj4+Pj4+IFdoeSBub3QsIEknbSBub3Qgc2Vl
aW5nIGFueSBIVyBhY2Nlc3NlcyBpbiB2aWNfbG9hZF9maXJtd2FyZT8gQWx0aG91Z2gKPj4+Pj4g
aXQgbG9va3MgbGlrZSBpdCBtaWdodCByYWNlIHdpdGggdGhlIHZpY19sb2FkX2Zpcm13YXJlIGNh
bGwgaW4KPj4+Pj4gdmljX3J1bnRpbWVfcmVzdW1lIHdoaWNoIHByb2JhYmx5IG5lZWRzIHRvIGJl
IGZpeGVkLgo+Pj4+Cj4+Pj4gSXQgd2FzIG5vdCBjbGVhciBmcm9tIHRoZSBmdW5jdGlvbidzIG5h
bWUgdGhhdCBoL3cgaXMgdW50b3VjaGVkLCBJIHJlYWQKPj4+PiAibG9hZCIgYXMgInVwbG9hZCIg
YW5kIHRoZW4gbG9va2VkIGF0IHZpY19ydW50aW1lX3Jlc3VtZSgpLiBJJ2QgcmVuYW1lCj4+Pj4g
dmljX2xvYWRfZmlybXdhcmUoKSB0byB2aWNfcHJlcGFyZV9maXJtd2FyZV9pbWFnZSgpLgo+Pj4+
Cj4+Pj4gQW5kIHllcywgdGVjaG5pY2FsbHkgbG9jayBpcyBuZWVkZWQuCj4+Pgo+Pj4gWWVwLCBJ
J2xsIGNvbnNpZGVyIHJlbmFtaW5nIGl0Lgo+Pgo+PiBMb29raW5nIGF0IHRoaXMgYWxsIGFnYWlu
LCBJJ2Qgc3VnZ2VzdCB0byBjaGFuZ2U6Cj4+Cj4+IGludCBnZXRfc3RyZWFtaWRfb2Zmc2V0KGNs
aWVudCkKPj4KPj4gdG86Cj4+Cj4+IGludCBnZXRfc3RyZWFtaWRfb2Zmc2V0KGNsaWVudCwgKm9m
ZnNldCkKPj4KPj4gYW5kIGJhaWwgb3V0IGlmIGdldF9zdHJlYW1pZF9vZmZzZXQoKSByZXR1cm5z
IGVycm9yLiBJdCdzIG5ldmVyIG9rYXkgdG8KPj4gaWdub3JlIGVycm9ycy4KPiAKPiBTdXJlLCBz
ZWVtcyByZWFzb25hYmxlLiBXZSdsbCBzdGlsbCBuZWVkIHNvbWUgZXJyb3IgY29kZSB0byBpbmRp
Y2F0ZQo+IHRoYXQgY29udGV4dCBpc29sYXRpb24gaXNuJ3QgYXZhaWxhYmxlIGZvciB0aGUgZW5n
aW5lIGFuZCBjb250aW51ZSBvbiBpbgo+IHRoYXQgY2FzZSBidXQgdGhhdCdzIGJldHRlciB0aGFu
IGp1c3QgaWdub3JpbmcgYWxsIG9mIHRoZW0uCgpZZXMsIGNoZWNrIGZvciAtRU9QTk9UU1VQUCBh
bmQgc2tpcCBpdC4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
