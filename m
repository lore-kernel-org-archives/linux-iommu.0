Return-Path: <SRS0=4upI=CB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED4FC433E1
	for <iommu@archiver.kernel.org>; Sun, 23 Aug 2020 21:42:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A1D9206BE
	for <iommu@archiver.kernel.org>; Sun, 23 Aug 2020 21:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bi3p+Cp3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A1D9206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 41BFC203BE;
	Sun, 23 Aug 2020 21:42:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d7WGGQJA0NWq; Sun, 23 Aug 2020 21:42:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0BAAE203D5;
	Sun, 23 Aug 2020 21:42:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4B77C016F;
	Sun, 23 Aug 2020 21:42:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD8F0C0051
 for <iommu@lists.linux-foundation.org>; Sun, 23 Aug 2020 21:42:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id AD5C285C1D
 for <iommu@lists.linux-foundation.org>; Sun, 23 Aug 2020 21:42:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m8hRPzZwhjmD for <iommu@lists.linux-foundation.org>;
 Sun, 23 Aug 2020 21:42:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com
 [209.85.167.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3169D85BE4
 for <iommu@lists.linux-foundation.org>; Sun, 23 Aug 2020 21:42:07 +0000 (UTC)
Received: by mail-lf1-f65.google.com with SMTP id k10so445872lfm.5
 for <iommu@lists.linux-foundation.org>; Sun, 23 Aug 2020 14:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wc4iGC6lUOkdFB1yl61K549g5r3SOsu5JHxiruFQCrg=;
 b=Bi3p+Cp3Oib9xYvfFtUZm0Uf4rS7f9RNyKsd3tWxxONpQQc3PTzptgnmmrY8S6kGoN
 MOvAz8xOUY9ngcOmmuv32FeGCODgI3+OG2C1ZfXRwC80bdmDQFHZhV0g8e/8gqYcSkMK
 VnOoZTXbShIC6Bch87KRpZNeDTivaN6dRe3bl07uV2weQcOSTlnP8PSnJSpTAz6UwHXh
 jfkfJtWP6VTM0IVwVX0tTJylC0DIYkRTaV1fnQyEsy7T5f3ySgDBw7pvJhI1XA7xov8H
 aaOCGtjqie8LdeYqkGUwj5n+Z1y9yL6cENlISNUIdyKKFk/8rZaF0QyYzMRltPEBVOw0
 WQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wc4iGC6lUOkdFB1yl61K549g5r3SOsu5JHxiruFQCrg=;
 b=DTurE3DOBI0leGdyBHUYM7CQop+Q1KUMX4WeYaajHfn71IqqriFs8AmflcMlOzx4IZ
 z5nqytUbSozThW4L0xhzC5lycSJQ7wz1h8yIs5Am4FVtNF3bGv1vxB7515F2rRmzl3gb
 g+cw6jPjzH9yaiDGwLcC9p7SzFrWYzUwDy45raw5WxZsii6D/VVjlpWPIEC1diBjTItc
 R5n1XtpTBdTqRwZgWpsslAKvFAXVirDYVYb4UfGdR47uXgDEI93Ydyz7VUULmijikuoq
 H19QHk+hpG10CWF2FGdmXGT3uRdUg6Lvrvuhft0OkI8pew68oxftDimzQ6NkyoU/lK0t
 LHFA==
X-Gm-Message-State: AOAM533rJrt/fewgvA0JcqYhz5ffV9jhf7Xd/a6AP3oFIr2nJR3DAPgF
 AGiOklxOh/WQOM4HXbeQLSM=
X-Google-Smtp-Source: ABdhPJzBkQVyR54HEK+tqk6nv9UaSdmG4fAbLjgLYrMh+ECOQvZhJQPh8Uzu3899cmc9YqmRioxiNg==
X-Received: by 2002:a19:4ace:: with SMTP id x197mr1185909lfa.70.1598218924740; 
 Sun, 23 Aug 2020 14:42:04 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.googlemail.com with ESMTPSA id w8sm1807687ljm.48.2020.08.23.14.42.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Aug 2020 14:42:03 -0700 (PDT)
Subject: Re: [PATCH 12/18] iommu/tegra-gart: Add IOMMU_DOMAIN_DMA support
To: Robin Murphy <robin.murphy@arm.com>, hch@lst.de, joro@8bytes.org,
 linux@armlinux.org.uk
References: <cover.1597931875.git.robin.murphy@arm.com>
 <516b33118d489e56499ff8c64c019709b744110c.1597931876.git.robin.murphy@arm.com>
 <081f7532-9ca0-0af3-35a1-cbaba0782237@gmail.com>
 <3a132bb0-f2e6-6f8d-6d0c-bc925dd23f06@arm.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ceccd3d1-2510-c289-c063-681ae005da85@gmail.com>
Date: Mon, 24 Aug 2020 00:42:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3a132bb0-f2e6-6f8d-6d0c-bc925dd23f06@arm.com>
Content-Language: en-US
Cc: geert+renesas@glider.be, dri-devel@lists.freedesktop.org,
 matthias.bgg@gmail.com, thierry.reding@gmail.com,
 laurent.pinchart@ideasonboard.com, will@kernel.org,
 linux-samsung-soc@vger.kernel.org, magnus.damm@gmail.com,
 kyungmin.park@samsung.com, jonathanh@nvidia.com, agross@kernel.org,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 inki.dae@samsung.com, linux-mediatek@lists.infradead.org,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 sw0312.kim@samsung.com, linux-kernel@vger.kernel.org, t-kristo@ti.com,
 iommu@lists.linux-foundation.org
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

MjEuMDguMjAyMCAwMzoyOCwgUm9iaW4gTXVycGh5INC/0LjRiNC10YI6Ci4uLgo+PiBXaWxsIGEg
cmV0dXJuZWQgTlVMTCB0ZWxsIHRvIElPTU1VIGNvcmUgdGhhdCBpbXBsaWNpdCBkb21haW4gc2hv
dWxkbid0Cj4+IGJlIHVzZWQ/IElzIGl0IHBvc3NpYmxlIHRvIGxlYXZlIHRoaXMgZHJpdmVyIGFz
LWlzPwo+IAo+IFRoZSBhaW0gb2YgdGhpcyBwYXRjaCB3YXMganVzdCB0byBtYWtlIHRoZSBjb252
ZXJzaW9uIHdpdGhvdXQgZnVuY3Rpb25hbAo+IGNoYW5nZXMgd2hlcmV2ZXIgcG9zc2libGUsIGku
ZS4gbWFpbnRhaW4gYW4gZXF1aXZhbGVudCB0byB0aGUgZXhpc3RpbmcKPiBBUk0gYmVoYXZpb3Vy
IG9mIGFsbG9jYXRpbmcgaXRzIG93biBpbXBsaWNpdCBkb21haW5zIGZvciBldmVyeXRoaW5nLiBJ
dAo+IGRvZXNuJ3QgcmVwcmVzZW50IGFueSBqdWRnZW1lbnQgb2Ygd2hldGhlciB0aGF0IHdhcyBl
dmVyIGFwcHJvcHJpYXRlIGZvcgo+IHRoaXMgZHJpdmVyIGluIHRoZSBmaXJzdCBwbGFjZSA7KQo+
IAo+IEhvcGVmdWxseSBteSBvdGhlciByZXBseSBhbHJlYWR5IGNvdmVyZWQgdGhlIGRlZ3JlZSBv
ZiBjb250cm9sIGRyaXZlcnMKPiBjYW4gaGF2ZSB3aXRoIHByb3BlciBkZWZhdWx0IGRvbWFpbnMs
IGJ1dCBkbyBzaG91dCBpZiBhbnl0aGluZyB3YXNuJ3QKPiBjbGVhci4KClRoYW5rIHlvdSBmb3Ig
dGhlIGRldGFpbGVkIGNvbW1lbnRzISBJIHdhc24ndCB3YXRjaGluZyBjbG9zZWx5IGFsbCB0aGUK
cmVjZW50IGlvbW11LyBjaGFuZ2VzIGFuZCB5b3VycyBjbGFyaWZpY2F0aW9uIGlzIHZlcnkgaGVs
cGZ1bCEKCk15IGN1cnJlbnQgdW5kZXJzdGFuZGluZyBpcyB0aGF0IHRoZSBHQVJUIGRyaXZlciB3
aWxsIG5lZWQgdG8gc3VwcG9ydAp0aGUgSU9NTVVfRE9NQUlOX0lERU5USVRZIGFuZCBzZXQgZGVm
X2RvbWFpbl90eXBlIHRvCklPTU1VX0RPTUFJTl9JREVOVElUWSBmb3IgYWxsIGRldmljZXMuCgpN
ZWFud2hpbGUsIHRvZGF5J3MgdXBzdHJlYW0gZHJpdmVycyBkb24ndCB1c2UgR0FSVCwgaGVuY2Ug
dGhpcyBwYXRjaApzaG91bGQgYmUgb2theS4gQWx0aG91Z2gsIGl0J3MgYSBiaXQgdW5saWtlbHkg
dGhhdCB0aGUgSU9NTVVfRE9NQUlOX0RNQQp0eXBlIHdpbGwgZXZlciBiZSB1c2VmdWwgZm9yIHRo
ZSBHQVJULCBhbmQgdGh1cywgSSdtIHN0aWxsIHRoaW5raW5nIHRoYXQKd2lsbCBiZSBhIGJpdCBu
aWNlciB0byBrZWVwIEdBUlQgZHJpdmVyIGFzLWlzIGZvciBub3cuCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
