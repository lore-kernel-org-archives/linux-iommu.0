Return-Path: <SRS0=1UcA=JV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED06DC433B4
	for <iommu@archiver.kernel.org>; Sat, 24 Apr 2021 07:26:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70C9461474
	for <iommu@archiver.kernel.org>; Sat, 24 Apr 2021 07:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70C9461474
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 388D7607A8;
	Sat, 24 Apr 2021 07:26:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5CX8hGtgbEvB; Sat, 24 Apr 2021 07:26:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 358BF607A3;
	Sat, 24 Apr 2021 07:26:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0BC80C000F;
	Sat, 24 Apr 2021 07:26:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6E7FC000B
 for <iommu@lists.linux-foundation.org>; Sat, 24 Apr 2021 07:26:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BA55D607A7
 for <iommu@lists.linux-foundation.org>; Sat, 24 Apr 2021 07:26:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PLQI-_pFjdpS for <iommu@lists.linux-foundation.org>;
 Sat, 24 Apr 2021 07:26:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B5C00607A3
 for <iommu@lists.linux-foundation.org>; Sat, 24 Apr 2021 07:26:23 +0000 (UTC)
Received: by mail-lj1-x22f.google.com with SMTP id a5so21142213ljk.0
 for <iommu@lists.linux-foundation.org>; Sat, 24 Apr 2021 00:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/pJRpObwgC760iXpBExu4yIVJmUUKVTuscTwMhK6LQU=;
 b=ufNx7c9rAdtARmP9/JGD2i8irzKzBRSUyNH+9fvRN92zRA0OBFhfjptFeAgu+DuB3q
 yfX+4Igr2ZTDK9BRrc56DlEvUt+BBNnplt01tCzit9YLV863swcxCrDFmUCr2AxIGVcC
 CA1deu2tXBGXlYmES7M4hHClqef3U0Z9Cc/5ESgmSCPAuPP+bV0Ejsxuz3yVgliRBNhq
 l5BHr8X0Lv0ae2Tcj/rgHxe19zUdxI6ucYdDvEo2Cgcmnq1RoX2WrGx7Zp+88tFQ+DRS
 iiC+cWOgjjaQN4BtP4v067DB6fjKQN6kZkQzdUOd2FMGfmB9Pv2H9LF2GfnYd4Oe/pkg
 jxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/pJRpObwgC760iXpBExu4yIVJmUUKVTuscTwMhK6LQU=;
 b=JLq87V3Xc4o/XEeXQh0sIVJ5FXzXwNTqiiQUXqum9w+W+fj0yZH5Zk4mu8Ngdylx1x
 xFsYbsYJgJxZEk/EJWXnB18q/E79iv+PiTpG5NlFfod2L2/Z6/gydmMclqLOtIGtIzn5
 MpMpjRSmxF+Imtmukc+dDnymVD5NKndkAm4xJ6OhCY4BEGWqTrj8FRpLqQwLO33qjZK6
 QZJplD6z+voYcwTRD32QkSTiDZqkjXCqTE90DUgIcQek6asblKBwDoXo6PRCj42GO/tX
 /xDXtxg/+NVkUNtoKL1SCnU++a1uM7eLvwZjpIUjA3DYdfEgGdfWjQNaAFcwpA68fxww
 VF1g==
X-Gm-Message-State: AOAM530ObOa6gdXUOyt4wiUnDG9sm0kr5ASEg+wqCVjuVmxx6yFnKjkQ
 6C24sgXxrOXhTP525P7BraU=
X-Google-Smtp-Source: ABdhPJx3Cw5Vif+11oahK6V5zTzAwV00Iy/2ZrdiZkutRiszn4jYJ2cW57uWFklKK5dsA9oi5EN2hA==
X-Received: by 2002:a2e:8054:: with SMTP id p20mr5032381ljg.439.1619249181690; 
 Sat, 24 Apr 2021 00:26:21 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-103.dynamic.spd-mgts.ru.
 [109.252.193.103])
 by smtp.googlemail.com with ESMTPSA id t17sm749859ljd.35.2021.04.24.00.26.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Apr 2021 00:26:21 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] iommu: Support identity mappings of
 reserved-memory regions
To: Thierry Reding <thierry.reding@gmail.com>, Joerg Roedel
 <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>
References: <20210423163234.3651547-1-thierry.reding@gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <869ec3a2-26df-2ce8-bd21-b681d6ef3985@gmail.com>
Date: Sat, 24 Apr 2021 10:26:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210423163234.3651547-1-thierry.reding@gmail.com>
Content-Language: en-US
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, Nicolin Chen <nicolinc@nvidia.com>,
 linux-tegra@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
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

MjMuMDQuMjAyMSAxOTozMiwgVGhpZXJyeSBSZWRpbmcg0L/QuNGI0LXRgjoKPiBIaSwKPiAKPiB0
aGlzIGlzIGFuIHVwZGF0ZWQgcHJvcG9zYWwgdG8gc29sdmUgdGhlIHByb2JsZW0gb2YgcGFzc2lu
ZyBtZW1vcnkKPiByZWdpb25zIHRoYXQgYXJlIGFjdGl2ZWx5IGJlaW5nIGFjY2Vzc2VkIGR1cmlu
ZyBib290LiBUaGUgcGFydGljdWxhcgo+IHVzZS1jYXNlIHRoYXQgSSBuZWVkIHRoaXMgZm9yIGlz
IHdoZW4gdGhlIGJvb3Rsb2FkZXIgaGFzIHNldCB1cCB0aGUKPiBkaXNwbGF5IGNvbnRyb2xsZXIg
dG8gc2NhbiBvdXQgYSBib290IHNwbGFzaCBzY3JlZW4uIER1cmluZyBib290IHRoZQo+IERNQS9J
T01NVSBnbHVlIGNvZGUgd2lsbCBhdHRhY2ggZGV2aWNlcyB0byBhbiBJT01NVSBkb21haW4gYW5k
IGJ5Cj4gZG9pbmcgc28gZW5hYmxlIElPTU1VIHRyYW5zbGF0aW9ucy4gVHlwaWNhbGx5IHRoaXMg
d2lsbCBiZSBiZWZvcmUgYQo+IGRldmljZSBkcml2ZXIgaGFzIGhhZCBhIGNoYW5jZSB0byBlaXRo
ZXIgZGlzYWJsZSB0aGUgZGlzcGxheQo+IGNvbnRyb2xsZXIgb3Igc2V0IHVwIGEgbmV3IGZyYW1l
YnVmZmVyIGFuZCBtYXAgaXQgdG8gdGhlIElPTU1VLgoKSGVsbG8gVGhpZXJyeSwKCklzIGl0IGFs
d2F5cyBzYWZlIHRvIGVuYWJsZSBTTU1VIEFTSUQgaW4gYSBtaWRkbGUgb2YgYSBETUEgcmVxdWVz
dCBtYWRlCmJ5IGEgbWVtb3J5IGNsaWVudD8KClRoZSBtZW1vcnkgY29udHJvbGxlciBzdXBwb3J0
cyBibG9ja2luZyBETUEgcmVxdWVzdHMsIHdoaWNoIHdlIGFyZQphbHJlYWR5IHVzaW5nIGZvciB0
aGUgbWVtb3J5IGhvdC1yZXNldHRpbmcuIEEgYmxvY2sgY291bGQgYmUgbmVlZGVkCmJlZm9yZSBB
U0lEIGlzIHRvZ2dsZWQuIFRoaXMgbmVlZHMgdG8gYmUgY2xhcmlmaWVkLgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9t
bXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
