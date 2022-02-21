Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29C6C433F5
	for <iommu@archiver.kernel.org>; Mon, 21 Feb 2022 20:10:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5683C408AF;
	Mon, 21 Feb 2022 20:10:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N2uCz9kSqW1N; Mon, 21 Feb 2022 20:10:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2F73F4089B;
	Mon, 21 Feb 2022 20:10:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16484C0021;
	Mon, 21 Feb 2022 20:10:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7BF61C0011
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 20:10:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5C8E2408A1
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 20:10:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sDiePGDrZGEt for <iommu@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 20:10:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 93E7E4089B
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 20:10:40 +0000 (UTC)
Received: by mail-lj1-x22e.google.com with SMTP id r20so16276928ljj.1
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 12:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=HGhrkRGOxLTFPp0IvWu9pw9Pr8JdXDbThJB0IGV8xLU=;
 b=q05VbA/LdGRm9JI5iCC7R/6MHFp+p8hZ7hUIYwm0rPqadyc6l2odkS+knjxOCpTps0
 0sn6JFA9ssyLAbfwEVZ7ciYQOPIbSQ5yOe2TxD9CT6N5+syqrdhqYpD45OLJlzm2Aphn
 JWMIYoq2bZI7jWflq8ftt8dKRu1/j97aYVkHlpXv9D4YNke2C7SeuCm/eunLAQ7tRsFX
 sdu2IEu6ZBpIU7OOJF8SAqn4ekdM35Sj9w3AsMIJ1E8b90sR9SghHLRPb23kBgivNu5P
 ePh2N/IYToJOAe6+2X5tRaUkLZuxsHNHOHXQq/T8/dXPZRg2PsASzqtkod4GY6XwfNYk
 i1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=HGhrkRGOxLTFPp0IvWu9pw9Pr8JdXDbThJB0IGV8xLU=;
 b=Lr8kG6wTMbMiogamgNV0afYyp2fRgYN0Ho8qnUst3Q6XMOKJ21cFMTIBdUlI15NhDL
 ck+uczMe8Kld4+XgBpFl4nKD6V3XYELOaxMt8RCzx8hnbe9NsZT3uo/ccw7aDOtgvJmF
 klcLEPEimGxpYIh7MzIyYF9mHa8ua1PkNBYgHRh/HZIU8KkGeJweh5SaohUs703qlcey
 oB13E437uHqUlU+UIzALDGA8//1sEXE8uUX0IXmspc7PKnP6hjH6IQaZHkdqWASe9OAW
 IN1EysV4YQNUSpS1pa67jLfSyC8MTm96YKPMPj68i7waFo2dagqFdJ9abE4KDL1zGlX7
 z7wA==
X-Gm-Message-State: AOAM530IRt3tfAAujQ8sQfpKmjVlaf3NTAZGse65CtjF4iD4o76EeWfw
 JVNPSkfEvn8/MW6ahZp3hlo=
X-Google-Smtp-Source: ABdhPJyavA3z3RaF8eqkB6PeyyaK9TqvSWUKI3hfCkhd0iA6vw0WQYVeElevA+YsmAf57wtOSnmtSg==
X-Received: by 2002:a2e:a4d6:0:b0:246:e66:90ed with SMTP id
 p22-20020a2ea4d6000000b002460e6690edmr15896034ljm.389.1645474238315; 
 Mon, 21 Feb 2022 12:10:38 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru.
 [109.252.138.165])
 by smtp.googlemail.com with ESMTPSA id d13sm813294lji.26.2022.02.21.12.10.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Feb 2022 12:10:37 -0800 (PST)
Message-ID: <ee648994-b296-2ac4-a676-ddcac463a428@gmail.com>
Date: Mon, 21 Feb 2022 23:10:37 +0300
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
From: Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <5d1b6e82-2c9d-8388-697f-0d7305a1206f@kapsi.fi>
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

MjEuMDIuMjAyMiAxNDo0NCwgTWlra28gUGVydHR1bmVuINC/0LjRiNC10YI6Cj4gT24gMi8xOS8y
MiAyMDo1NCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+PiAxOS4wMi4yMDIyIDIxOjQ5LCBEbWl0
cnkgT3NpcGVua28g0L/QuNGI0LXRgjoKPj4+IDE4LjAyLjIwMjIgMTQ6MzksIE1pa2tvIFBlcnR0
dW5lbiDQv9C40YjQtdGCOgo+Pj4+ICtzdGF0aWMgaW50IHZpY19nZXRfc3RyZWFtaWRfb2Zmc2V0
KHN0cnVjdCB0ZWdyYV9kcm1fY2xpZW50ICpjbGllbnQpCj4+Pj4gK3sKPj4+PiArwqDCoMKgIHN0
cnVjdCB2aWMgKnZpYyA9IHRvX3ZpYyhjbGllbnQpOwo+Pj4+ICvCoMKgwqAgaW50IGVycjsKPj4+
PiArCj4+Pj4gK8KgwqDCoCBlcnIgPSB2aWNfbG9hZF9maXJtd2FyZSh2aWMpOwo+Pj4KPj4+IFlv
dSBjYW4ndCBpbnZva2UgdmljX2xvYWRfZmlybXdhcmUoKSB3aGlsZSBSUE0gaXMgc3VzcGVuZGVk
LiBFaXRoZXIKPj4+IHJlcGxhY2UgdGhpcyB3aXRoIFJQTSBnZXQvcHV0IG9yIGRvIHNvbWV0aGlu
ZyBlbHNlLgo+IAo+IFdoeSBub3QsIEknbSBub3Qgc2VlaW5nIGFueSBIVyBhY2Nlc3NlcyBpbiB2
aWNfbG9hZF9maXJtd2FyZT8gQWx0aG91Z2gKPiBpdCBsb29rcyBsaWtlIGl0IG1pZ2h0IHJhY2Ug
d2l0aCB0aGUgdmljX2xvYWRfZmlybXdhcmUgY2FsbCBpbgo+IHZpY19ydW50aW1lX3Jlc3VtZSB3
aGljaCBwcm9iYWJseSBuZWVkcyB0byBiZSBmaXhlZC4KCkl0IHdhcyBub3QgY2xlYXIgZnJvbSB0
aGUgZnVuY3Rpb24ncyBuYW1lIHRoYXQgaC93IGlzIHVudG91Y2hlZCwgSSByZWFkCiJsb2FkIiBh
cyAidXBsb2FkIiBhbmQgdGhlbiBsb29rZWQgYXQgdmljX3J1bnRpbWVfcmVzdW1lKCkuIEknZCBy
ZW5hbWUKdmljX2xvYWRfZmlybXdhcmUoKSB0byB2aWNfcHJlcGFyZV9maXJtd2FyZV9pbWFnZSgp
LgoKQW5kIHllcywgdGVjaG5pY2FsbHkgbG9jayBpcyBuZWVkZWQuCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
