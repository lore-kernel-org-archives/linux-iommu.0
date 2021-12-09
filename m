Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E5E2C433F5
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 19:44:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BA94C42948;
	Thu,  9 Dec 2021 19:44:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n5zGttsGLy-c; Thu,  9 Dec 2021 19:44:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BE74C4287E;
	Thu,  9 Dec 2021 19:44:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7BC8DC001E;
	Thu,  9 Dec 2021 19:44:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 152B7C0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 19:44:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E39B761C67
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 19:44:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OsHp4JPlrN6G for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 19:44:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1F7F361BDD
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 19:44:28 +0000 (UTC)
Received: by mail-lf1-x134.google.com with SMTP id k37so14110641lfv.3
 for <iommu@lists.linux-foundation.org>; Thu, 09 Dec 2021 11:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=W3M3FLz1taxe7b+77mKr7ESR2sB6VgJaCSXT4PXYVl4=;
 b=eGY5CV7vI95Jbczr3qe0LqFbn9/PcXqSI7y6DZgHP6wPgwipojVAfRBYzqigkthVZn
 UazITCDN++Y8asH79fyndNPjkk/6rBqV0rySptjAHGRUfCNqs1V4y0nQZgQk26xo86q6
 y7FyGluxEZn5US6qjR8aA22SF2oJ2YTaz0qXNyZupPrUefcplDPGrPNJqbCuDbfJV+O0
 6LDqlL3/v5Xbwnh0HzoSzhImVspE/D1jSZ2zC1KXgeTBj8SgfNojnHx9p6i3D11Dm/j7
 u4S/zhpVPbcd3ApJS+gOLyf/xU50tLIfNYOPrwGR+u4kKdcdu+w5KHx2TXoIj4tB4xbw
 wepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=W3M3FLz1taxe7b+77mKr7ESR2sB6VgJaCSXT4PXYVl4=;
 b=JD6oHSLhzbu6F8R8d/WIxcHge43LwJDEyXrDpeYSiWqm08lnvFfDoG1lJJpncE30Np
 CXndZ9VW8oMSLiqgAjX1PPizK2/R04d/sbqUtZQ/GpClzrOkT+tOnIHRbIThtQNaEJwS
 GFxCVHu5Au18hsI7ITRq2bbjmnMv17BaNHAZdiFDUPZQd3ikyZv5och/EWrZcFwpxFVZ
 +RII8xmXd4AtWMjCMzpsmv0JY8BXxUf27SAZvWkgVFFrYWHQxD8uAPKVubEN3D60qAAe
 OZTPd1tieEe6928/npI+GCym78GftALF76lWTCWpWixoN0zhrPq3YmoKm5t+ZaP8A8Ct
 jg7Q==
X-Gm-Message-State: AOAM531N70A8c3ALjPs/3Oamf/YjHaUUe6QdNhFGJ6U3JE0+rFhPQU3U
 AW5ukUnV7GvJ3WINlFpvKnc=
X-Google-Smtp-Source: ABdhPJzmRqO8K8YP9qOB01q2ejoBUkmaK+Jj+SXh/lFFavAM6lm2pmNJsA/4TI8gdc+EQ2+mgufg2Q==
X-Received: by 2002:ac2:5fca:: with SMTP id q10mr8032056lfg.281.1639079066185; 
 Thu, 09 Dec 2021 11:44:26 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru.
 [94.29.46.111])
 by smtp.googlemail.com with ESMTPSA id s25sm74065ljd.39.2021.12.09.11.44.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Dec 2021 11:44:25 -0800 (PST)
Subject: Re: [PATCH v8 6/6] iommu/tegra-smmu: Add pagetable mappings to debugfs
To: Nicolin Chen <nicolinc@nvidia.com>
References: <20211209073822.26728-1-nicolinc@nvidia.com>
 <20211209073822.26728-7-nicolinc@nvidia.com>
 <63b4c2e2-0e55-5701-4c45-70684c7e058e@gmail.com>
 <20211209192450.GA34762@Asurada-Nvidia>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <fab11209-a579-bbfb-a701-e613cecabd56@gmail.com>
Date: Thu, 9 Dec 2021 22:44:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211209192450.GA34762@Asurada-Nvidia>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
 will@kernel.org
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

MDkuMTIuMjAyMSAyMjoyNCwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gT24gVGh1LCBEZWMg
MDksIDIwMjEgYXQgMDU6NDk6MDlQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+PiBF
eHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cwo+
Pgo+Pgo+PiAwOS4xMi4yMDIxIDEwOjM4LCBOaWNvbGluIENoZW4g0L/QuNGI0LXRgjoKPj4+ICtz
dGF0aWMgdW5zaWduZWQgbG9uZyBwZF9wdF9pbmRleF9pb3ZhKHVuc2lnbmVkIGludCBwZF9pbmRl
eCwgdW5zaWduZWQgaW50IHB0X2luZGV4KQo+Pj4gK3sKPj4+ICsgICAgIHJldHVybiAocGRfaW5k
ZXggJiAoU01NVV9OVU1fUERFIC0gMSkpIDw8IFNNTVVfUERFX1NISUZUIHwKPj4+ICsgICAgICAg
ICAgICAocHRfaW5kZXggJiAoU01NVV9OVU1fUFRFIC0gMSkpIDw8IFNNTVVfUFRFX1NISUZUOwo+
Pj4gK30KPj4KPj4gSSdkIGNoYW5nZSB0aGUgcmV0dXJuIHR5cGUgdG8gdTMyIGhlcmUsIGZvciBj
b25zaXN0ZW5jeS4KPiAKPiBUaGUgd2hvbGUgZmlsZSBkZWZpbmVzIGlvdmEgdXNpbmcgInVuc2ln
bmVkIGxvbmciLCB3aGljaCBJIHNlZQo+IGFzIHRoZSBjb25zaXN0ZW5jeS4uLiBJZiB3ZSBjaGFu
Z2UgaXQgdG8gdTMyLCBpdCdkIGJlIHByb2JhYmx5Cj4gbmVjZXNzYXJ5IHRvIGNoYW5nZSBhbGwg
aW92YSB0eXBlcyB0byB1MzIgdG9vLi4uIFNvIEknZCByYXRoZXIKPiBrZWVwIGl0ICJ1bnNpZ25l
ZCBsb25nIiBoZXJlLiBJZiB5b3Ugc2VlIGEgYmlnIG5lY2Vzc2l0eSB0byBkbwo+IHRoYXQsIGFu
IGFkZGl0aW9uYWwgcGF0Y2ggd291bGQgYmUgbmljZXIgSU1ITy4KPiAKCkluIGdlbmVyYWwgSU9W
QSBpcyAidW5zaWduZWQgbG9uZyIsIG9mIGNvdXJzZS4gQnV0IGluIGNhc2Ugb2YgVGVncmEKU01N
VSwgd2Uga25vdyB0aGF0IGlzIGFsd2F5cyB1MzIuCgpBbHJpZ2h0LCBJIHNlZSBub3cgdGhhdCB0
aGVyZSBhcmUgb3RoZXIgcGxhY2VzIGluIHRoZSBkcml2ZXIgY29kZSB0aGF0CnVzZSAidW5zaWdu
ZWQgbG9uZyIsIHNvIG5lZWQgdG8gY2hhbmdlIGl0IGluIHRoaXMgcGF0Y2guCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdApp
b21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
