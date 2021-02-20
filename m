Return-Path: <SRS0=gpVu=HW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43C8C433DB
	for <iommu@archiver.kernel.org>; Sat, 20 Feb 2021 05:16:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4081864E4E
	for <iommu@archiver.kernel.org>; Sat, 20 Feb 2021 05:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4081864E4E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BE1B183FA2
	for <iommu@archiver.kernel.org>; Sat, 20 Feb 2021 05:16:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7sJrVR2sOo9O for <iommu@archiver.kernel.org>;
	Sat, 20 Feb 2021 05:16:30 +0000 (UTC)
Received: by smtp1.osuosl.org (Postfix, from userid 1001)
	id 8BC3F83EA1; Sat, 20 Feb 2021 05:16:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id A79A883CB9;
	Sat, 20 Feb 2021 05:16:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B49FC000A;
	Sat, 20 Feb 2021 05:16:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83F1DC0001
 for <iommu@lists.linux-foundation.org>; Sat, 20 Feb 2021 05:16:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6AC2C87409
 for <iommu@lists.linux-foundation.org>; Sat, 20 Feb 2021 05:16:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cMJ2Ls5LkR0J for <iommu@lists.linux-foundation.org>;
 Sat, 20 Feb 2021 05:16:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com
 [209.85.208.173])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7C9D3873F4
 for <iommu@lists.linux-foundation.org>; Sat, 20 Feb 2021 05:16:25 +0000 (UTC)
Received: by mail-lj1-f173.google.com with SMTP id q14so35347253ljp.4
 for <iommu@lists.linux-foundation.org>; Fri, 19 Feb 2021 21:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=75WgM4j7TpcglCJIQaidtSvYuszmMtipi4ZJU85Xubs=;
 b=s+91Q/NxEOWWfiT2BbVxo3Htl8db0wjaq1enuCFCFswR75Spv5EtSIqCwZqc68F+iO
 Dy3RLT413GvOqNnrhKPD/Vg8AoZA2PRWZq6DXoJsO1VDHzsmp7UpveYPwRPCMfnNLVRd
 p/4Zt6sLr+G0bKCgBzhF5CUSOML3nCnLzfQDepoBJvdZ2vlgy3uQDWeQt1ajuMd1zE0B
 U5CRBES1msaKbgxJCpElsC9vYP2AV8szpwT6wlsoM6t4PbHIe7FG0UwkRYS9ynZ89v/9
 TDlmuP8IceGw3ja00kM9W1Krj26CbsF99tXj2Sh9P9RE1smQPG80GH5HZxCQkA+GcuAC
 VoTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=75WgM4j7TpcglCJIQaidtSvYuszmMtipi4ZJU85Xubs=;
 b=LYQpz6kUD+zZFAnoMZRJbIRkyq2+BsQD6nD5yDNq+9lAuXqWftG12szSJ0dPcDXSRW
 98U7la9hS/6D4jz5qO48w/OCZTnFCSh50PZzWfWDcYxqe7Iir7lWZAAO20rZhAiCOjCl
 rQPzwK360kiOu1N9hP5m+FQlly6AIUeCOr8Nda1wC/aCGBLlfTtReP/HtmC+5vYPD1sD
 DmfeaB0dT9hVq6EC5zbK4y52uwaFLKL7UpK+ej75Lp3BG9QYzTLRTP9yOgf/xEUnaMES
 jGzRJgCEVg8TLRZUea9yc1sl1ZBhh82hvSX3r2O/fXuXcd28TYIcK+HCr7IqInWaxBch
 OnkA==
X-Gm-Message-State: AOAM530/RLJrzMJVGcrzLiOy0swDdiSur+/3JcEay3FY5W/9xEkKvIU4
 scvSSXo8D2ZpEqR0zg+cQVQ=
X-Google-Smtp-Source: ABdhPJwjsq3TDQS5wEjqyDwFxuQJ5k1GaYHDBbikWFxv6QHUKfYn86ehN4RvF+ueagBaOHj5rxLwTQ==
X-Received: by 2002:a19:500a:: with SMTP id e10mr7503522lfb.241.1613798183645; 
 Fri, 19 Feb 2021 21:16:23 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-52.dynamic.spd-mgts.ru.
 [109.252.193.52])
 by smtp.googlemail.com with ESMTPSA id o16sm284804lfn.252.2021.02.19.21.16.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Feb 2021 21:16:23 -0800 (PST)
Subject: Re: [PATCH] iommu/tegra-smmu: Fix mc errors on tegra124-nyan
To: Nicolin Chen <nicoleotsuka@gmail.com>, joro@8bytes.org,
 thierry.reding@gmail.com, will@kernel.org, guillaume.tucker@collabora.com
References: <20210218220702.1962-1-nicoleotsuka@gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9d6445c0-9574-1650-e327-32b11716f87e@gmail.com>
Date: Sat, 20 Feb 2021 08:16:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210218220702.1962-1-nicoleotsuka@gmail.com>
Content-Language: en-US
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jonathanh@nvidia.com
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

MTkuMDIuMjAyMSAwMTowNywgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gQ29tbWl0IDI1OTM4
YzczY2Q3OSAoImlvbW11L3RlZ3JhLXNtbXU6IFJld29yayB0ZWdyYV9zbW11X3Byb2JlX2Rldmlj
ZSgpIikKPiByZW1vdmVkIGNlcnRhaW4gaGFjayBpbiB0aGUgdGVncmFfc21tdV9wcm9iZSgpIGJ5
IHJlbHlpbmcgb24gSU9NTVUgY29yZSB0bwo+IG9mX3hsYXRlIFNNTVUncyBTSUQgcGVyIGRldmlj
ZSwgc28gYXMgdG8gZ2V0IHJpZCBvZiB0ZWdyYV9zbW11X2ZpbmQoKSBhbmQKPiB0ZWdyYV9zbW11
X2NvbmZpZ3VyZSgpIHRoYXQgYXJlIHR5cGljYWxseSBkb25lIGluIHRoZSBJT01NVSBjb3JlIGFs
c28uCj4gCj4gVGhpcyBhcHByb2FjaCB3b3JrcyBmb3IgYm90aCBleGlzdGluZyBkZXZpY2VzIHRo
YXQgaGF2ZSBEVCBub2RlcyBhbmQgb3RoZXIKPiBkZXZpY2VzIChsaWtlIFBDSSBkZXZpY2UpIHRo
YXQgZG9uJ3QgZXhpc3QgaW4gRFQsIG9uIFRlZ3JhMjEwIGFuZCBUZWdyYTMKPiB1cG9uIHRlc3Rp
bmcuIEhvd2V2ZXIsIFBhZ2UgRmF1bHQgZXJyb3JzIGFyZSByZXBvcnRlZCBvbiB0ZWdyYTEyNC1O
eWFuOgo+IAo+ICAgdGVncmEtbWMgNzAwMTkwMDAubWVtb3J5LWNvbnRyb2xsZXI6IGRpc3BsYXkw
YTogcmVhZCBAMHhmZTA1NmI0MDoKPiAJIEVNRU0gYWRkcmVzcyBkZWNvZGUgZXJyb3IgKFNNTVUg
dHJhbnNsYXRpb24gZXJyb3IgWy0tU10pCj4gICB0ZWdyYS1tYyA3MDAxOTAwMC5tZW1vcnktY29u
dHJvbGxlcjogZGlzcGxheTBhOiByZWFkIEAweGZlMDU2YjQwOgo+IAkgUGFnZSBmYXVsdCAoU01N
VSB0cmFuc2xhdGlvbiBlcnJvciBbLS1TXSkKPiAKPiBBZnRlciBkZWJ1Z2dpbmcsIEkgZm91bmQg
dGhhdCB0aGUgbWVudGlvbmVkIGNvbW1pdCBjaGFuZ2VkIHNvbWUgZnVuY3Rpb24KPiBjYWxsYmFj
ayBzZXF1ZW5jZSBvZiB0ZWdyYS1zbW11J3MsIHJlc3VsdGluZyBpbiBlbmFibGluZyBTTU1VIGZv
ciBkaXNwbGF5Cj4gY2xpZW50IGJlZm9yZSBkaXNwbGF5IGRyaXZlciBnZXRzIGluaXRpYWxpemVk
LiBJIGNvdWxkbid0IHJlcHJvZHVjZSBleGFjdAo+IHNhbWUgaXNzdWUgb24gVGVncmEyMTAgYXMg
VGVncmExMjQgKGFybS0zMikgZGlmZmVycyBhdCBhcmNoLWxldmVsIGNvZGUuCgpIZWxsbyBOaWNv
bGluLAoKQ291bGQgeW91IHBsZWFzZSBleHBsYWluIGluIGEgbW9yZSBkZXRhaWxzIHdoYXQgZXhh
Y3RseSBtYWtlcyB0aGUKZGlmZmVyZW5jZSBmb3IgdGhlIGNhbGxiYWNrIHNlcXVlbmNlPwpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5n
IGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
