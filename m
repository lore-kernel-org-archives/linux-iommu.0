Return-Path: <SRS0=GPDh=E7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE79C5519F
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 10:09:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C14D32083E
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 10:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lw8YkB83"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14D32083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4638784426;
	Wed, 25 Nov 2020 10:09:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Te0OAU_yqRqY; Wed, 25 Nov 2020 10:09:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E831986B7B;
	Wed, 25 Nov 2020 10:09:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA4B5C0891;
	Wed, 25 Nov 2020 10:09:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2728C0052
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 10:09:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E653C203BD
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 10:09:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VT3+cnpfpz8M for <iommu@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 10:09:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com
 [209.85.215.196])
 by silver.osuosl.org (Postfix) with ESMTPS id 0C37020341
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 10:09:39 +0000 (UTC)
Received: by mail-pg1-f196.google.com with SMTP id t21so2044267pgl.3
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 02:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=7UB1VwfUNRdnhielmEFkYpUl+QJqWs5102vTTuwXUyw=;
 b=Lw8YkB83gM/PwTerYxcBiRNaOxNBetoyEavPznuzdB8scSAJDAfEiTtViswcQL9Naa
 pwi3RS2Xsda90l5qmGgsqCyUcIFnsht7yfQHKQS4JiDGskpvhcsUDv37SaZjbGv2iwaL
 IJ0nq7Cseu3m/OG3XtUF0K5ZFoOAj8jPSOG4DHQ0wnw2Gy+zRNtp0i39gDKJCkUr/zbF
 AupG+q2g00nKEgJIVKb0jo42S4bft4DlEM+c5aTeNLbvKT1ZBc23deWEIoqPYaQclqPo
 iANb8UnHqZmRVFLSH26POuHUPE6siKhWtNXdp3QrKzMD5cspDLDIAvnvTiqGPAvtgYvk
 kK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=7UB1VwfUNRdnhielmEFkYpUl+QJqWs5102vTTuwXUyw=;
 b=YVc7CjlzNkEu5SzA/rorHzHYt1aDCCQaeGyStCZHezQ1l+wqf3QzSm9HbzPRCHjEW/
 0/gfsdug9Yf9PAaCBTknVd12r9eWhC4GZRb3yx2s/8IaC0+KZa/TcihkApPeyDuI7m6b
 1IgDkZgrY3OCiJoq0ZbrIb3hxX3jNHbqZQ//NUxyj/8RSYYYX6kqAq41sR/EG8/gOH14
 2qdE0m64p8Pp4kXZ/veAtKuSn9+2ft086Wk+tlNO5ce3DBVRECnhhX5C7JrF+ibPqS+7
 yKhpVV/QYuNawenjgtDyDH2iAPHVheRBlwVszyPF9Wzlpw2t/xWjowq/3DUBHs8Bl9f2
 4FLg==
X-Gm-Message-State: AOAM531G6+zoiFKHFm7kBG6vmjHh3N20dXCZG21o3dXX+CIz3h5/aVb2
 l4HmOCnnQsYQb1smR3q6qWM=
X-Google-Smtp-Source: ABdhPJz7JWwX2J93K0LMh6QODhHit3hmgdw0k19rbXJ1Iuh3+c4jpfPXav0q+CckJ/heF1zGoD0now==
X-Received: by 2002:a17:90b:1490:: with SMTP id
 js16mr3266093pjb.215.1606298978581; 
 Wed, 25 Nov 2020 02:09:38 -0800 (PST)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id f134sm1615230pfa.208.2020.11.25.02.09.37
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 25 Nov 2020 02:09:38 -0800 (PST)
Date: Wed, 25 Nov 2020 02:08:06 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH RESEND 0/5] iommu/tegra-smmu: Some pending reviewed changes
Message-ID: <20201125100805.GA14856@Asurada-Nvidia>
References: <20201111222129.15736-1-nicoleotsuka@gmail.com>
 <20201124212100.GA32108@Asurada-Nvidia>
 <68237d7c-12f7-3053-2e79-75b7e95f0af3@gmail.com>
 <20201124231215.GA32405@Asurada-Nvidia>
 <20201125095509.GB15052@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201125095509.GB15052@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: linux-kernel@vger.kernel.org, jonathanh@nvidia.com,
 iommu@lists.linux-foundation.org, thierry.reding@gmail.com,
 linux-tegra@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>
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

T24gV2VkLCBOb3YgMjUsIDIwMjAgYXQgMDk6NTU6MTBBTSArMDAwMCwgV2lsbCBEZWFjb24gd3Jv
dGU6Cj4gT24gVHVlLCBOb3YgMjQsIDIwMjAgYXQgMDM6MTI6MTZQTSAtMDgwMCwgTmljb2xpbiBD
aGVuIHdyb3RlOgo+ID4gT24gV2VkLCBOb3YgMjUsIDIwMjAgYXQgMDI6MDU6MTRBTSArMDMwMCwg
RG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+ID4gPiAyNS4xMS4yMDIwIDAwOjIxLCBOaWNvbGluIENo
ZW4g0L/QuNGI0LXRgjoKPiA+ID4gPiBUaGVzZSBmaXZlIHBhdGNoZXMgd2VyZSBhY2tlZCBieSBU
aGllcnJ5IGFuZCBhY2tlZC1uLXRlc3RlZCBieQo+ID4gPiA+IERtaXRyeSBhIHdoaWxlIGFnby4g
V291bGQgaXQgYmUgcG9zc2libGUgZm9yIHlvdSB0byBhcHBseSB0aGVtPwo+ID4gPiA+IAo+ID4g
PiA+IFRoYW5rcyEKPiA+ID4gCj4gPiA+IFlvdSBwcm9iYWJseSBzaG91bGQgdHJ5IHRvIHBpbmcg
V2lsbCBEZWFjb24uCj4gPiA+IAo+ID4gPiBodHRwczovL2xrbWwub3JnL2xrbWwvMjAyMC8xMS8x
Ny8yNDMKPiA+IAo+ID4gVGhhbmsgeW91LCBEbWl0cnkuCj4gPiAtLQo+ID4gCj4gPiBXaWxsLCB3
b3VsZCBpdCBiZSBwb3NzaWJsZSBmb3IgeW91IHRvIHRha2UgdGhlc2UgY2hhbmdlcz8KPiA+IAo+
ID4gSSBzZW50IHRoZW0gb24gTm92IDExIHRvIHRoZSBmb2xsb3dpbmcgbGlzdHM6Cj4gPiBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCj4gPiBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwo+ID4gCj4gPiBJZiB5b3UgbmVlZCBtZSB0byByZXNlbmQgaXQgYWdhaW4gYnkgYWRkaW5n
IHlvdSBpbiBUbyBsaW5lLAo+ID4gcGxlYXNlIGtpbmRseSBsZXQgbWUga25vdy4KPiAKPiBXZWly
ZCwgdGhpcyBlbmRlZCB1cCBpbiBteSBzcGFtLiBJZiB5b3Ugd291bGRuJ3QgbWluZCByZXNlbmRp
bmcgd2l0aCBtZQo+IG9uIFRvOiB0aGVuIHBsZWFzZSBkbyB0aGF0LiBUaGVuIEkga25vdyBJJ20g
bG9va2luZyBhdCB0aGUgY29ycmVjdCB2ZXJzaW9uLgoKUmVzZW5kaW5nLgoKVGhhbmtzIQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5n
IGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
