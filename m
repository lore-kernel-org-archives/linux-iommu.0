Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F4FC433EF
	for <iommu@archiver.kernel.org>; Tue, 14 Dec 2021 14:35:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 45E3C40132;
	Tue, 14 Dec 2021 14:35:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O8j5a-FpCd5A; Tue, 14 Dec 2021 14:35:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6DE534010C;
	Tue, 14 Dec 2021 14:35:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45356C001E;
	Tue, 14 Dec 2021 14:35:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16B7DC0012
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 14:35:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EB761600B5
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 14:35:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JynQraS36iHO for <iommu@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 14:35:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 53F4060BBF
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 14:35:42 +0000 (UTC)
Received: by mail-lj1-x234.google.com with SMTP id u22so28559858lju.7
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 06:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bTETz2h6nLGm7FFtGoJfUkWZ0HDEaBtcfd+0ZBKXMvc=;
 b=n/QGO+OnyCitcGbUPZx3Pj35kVxNPf9kyMvy5oC1xVP14DSmebuH3o1n1RLUTmhZNW
 jM6Hftd6+0Vw9w4QOrJtPqLzTr6Galg4yDzcKYkvVGep2YoWV8jo/pooFE9d3VXAsAeF
 yR8llmpsTF1yiyeK5dPv57cq4YatfdGdOUADCthaLZrBFNY+FGxjlBcyBM4UMIPgm1VE
 xO5mVpHRw1w/fsdZ80+HXEBsv3ylsxaYXCUIGJ3CbSYDXio9oI3K/lT2Gnio7jEzV6RB
 F/2VutcgJBnB2y0ChlsbRGZk0BEevFPcQuz/5M4fXccj1+qPIonzL3cgfU4xjqAc6dnv
 rUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bTETz2h6nLGm7FFtGoJfUkWZ0HDEaBtcfd+0ZBKXMvc=;
 b=CYVdfxsF/ZiTIyrvLmWIaO0fULGxu1xGvi1IYJZLmCp5sk6ZPiAJ6eEE3FDgp2CxuE
 35Nq20M4xaN7At+B7b2pK++MXzUIccp7KJZPyLnpBSzNXfCqUGnJ0q+gjCQY1VPM+EeW
 m/F6wp5qkqCLQ+/+IoRgNrKWiI4+KUqw0jRKEh1uIkKtDfRyDkfkhQEACBkwA2G1/UqG
 8cxasnYdEp5d1euveg4mgUkioATcnNWHgA/MLDm1NTdkOOCBMMw6jWZGE0b2pPTW3tIp
 ITmUZym3bDRA/PjO1ylxYQSENL3uF9XxlEikPql9p1VQ3xcaWB0uGzIeNSPXBP11ziAK
 trpA==
X-Gm-Message-State: AOAM533XBWB2An/yDFT+RT7P0xKMVsZ7YXaNbTq7KrWVhEZXoEj4Xf+J
 FGR+A9LIYDU70BaeR+khmqY=
X-Google-Smtp-Source: ABdhPJxqBfOFfSpR6YQ9B8RrJ36CJEZUGHdsdWYWe/w8s6TzwBrY0PsUZf7c0DtQQSei90WL5dPVtA==
X-Received: by 2002:a2e:91ca:: with SMTP id u10mr5429166ljg.414.1639492540268; 
 Tue, 14 Dec 2021 06:35:40 -0800 (PST)
Received: from [192.168.2.145] (94-29-63-156.dynamic.spd-mgts.ru.
 [94.29.63.156])
 by smtp.googlemail.com with ESMTPSA id g36sm1857154lfv.16.2021.12.14.06.35.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Dec 2021 06:35:39 -0800 (PST)
Subject: Re: [PATCH v2 0/8] Host1x context isolation support
To: Jon Hunter <jonathanh@nvidia.com>, joro@8bytes.org, will@kernel.org,
 robh+dt@kernel.org, robin.murphy@arm.com,
 Mikko Perttunen <mperttunen@nvidia.com>
References: <20210916143302.2024933-1-mperttunen@nvidia.com>
 <10de82cf-27a5-8890-93a5-0e58c74e5bcc@kapsi.fi>
 <c382fb0e-6b73-5ca0-7f63-d2843351325e@nvidia.com>
 <91dddccd-a6c1-21b3-34d6-6a8082a386e7@nvidia.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a507b10b-395b-1f6d-87b9-7c7c436cab0e@gmail.com>
Date: Tue, 14 Dec 2021 17:35:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <91dddccd-a6c1-21b3-34d6-6a8082a386e7@nvidia.com>
Content-Language: en-US
Cc: devicetree@vger.kernel.org, Mikko Perttunen <cyndis@kapsi.fi>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 iommu@lists.linux-foundation.org, thierry.reding@gmail.com,
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

MTQuMTIuMjAyMSAxMTowNSwgSm9uIEh1bnRlciDQv9C40YjQtdGCOgo+IEhpIGFsbCwKPiAKPiBT
dGlsbCBubyByZXNwb25zZSBvbiB0aGlzIDotKAoKSSBzZWUgb25seSB0d28gcGF0Y2hlcyBvbiBU
ZWdyYSBNTCBhbmQgb3RoZXJzIG9uIERSSSBNTC4gTWlnaHQgYmUgZ29vZAp0byBzdGFydCB3aXRo
IHJlLXNlbmRpbmcgdGhpcyB3aG9sZSBzZXJpZXMgYW5kIENDaW5nIE1McyBwcm9wZXJseS4KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxp
bmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
