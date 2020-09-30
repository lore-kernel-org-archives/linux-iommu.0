Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E03C2D0A8
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 06:10:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 227F520754
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 06:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="srdnNQg2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 227F520754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B87B520462;
	Wed, 30 Sep 2020 06:10:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HnFYuEr3umwe; Wed, 30 Sep 2020 06:10:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B6EA42041E;
	Wed, 30 Sep 2020 06:10:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89284C016F;
	Wed, 30 Sep 2020 06:10:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E04C6C0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 06:10:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C6CBA85E09
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 06:10:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id flWGmruBi_cQ for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 06:10:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com
 [209.85.208.194])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 070BC8502A
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 06:10:42 +0000 (UTC)
Received: by mail-lj1-f194.google.com with SMTP id u4so538803ljd.10
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 23:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tF1+/MycUx+KyCDTvsvj5n8w93b7S9PxVTTODrbJLlQ=;
 b=srdnNQg2feKgQJzm9RAwg47hsQoXa0Hg/Q3ues2KB66TP8x8y/5A3LJCtSuayucJbD
 VBaWOcAD68TRSQvWDlG605UftlLRtya4qHG2obIaz64msOSgSGsbGnoKlqxgjeDctpaN
 G0+e+LmR1IeSvoLVsE+68lLoYFw97769Mb+ZSLkToZ6kD5FM4TRt/jpe0S5J2cLHs8P8
 U7s1lXwu01mPPV7GlfREG12eBepSCdePirmn9d1LqlcJQ08CebrEpsNtM/DC/Q2oK/7R
 vPhUVkrrfuPYfFGKMHLZEzOre3MnxfNiiw6KXOIamClZZZz6z1DOw87Mgm8yhmlVTmpr
 4UIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tF1+/MycUx+KyCDTvsvj5n8w93b7S9PxVTTODrbJLlQ=;
 b=JwsVCpPfplZ5Squ9d3SKeAVG8CwP2FlbdvcoTNrCR6Xtr6fADBaHpPlJaZJevKo6D4
 W/NbCLI8DsfhKaB0oVFZ0gwIuUJDRa32fh0iRqGz7ysrlWl0FvPdx8EkCnrVKAsJiUgs
 AbHdJw+dk08EPeEZ2cbdZsHaiA8gzzxvebdqWW8mqsh2i4ts6rHwkD8HBTTpaSLCcSsm
 giACFT4knen88C8yWeo4zSvsO/cf5xRI73HWagjaRRF5zEQRUCCcCqQJYTD4TSA/bHOf
 m08hkMwNYeffoiAuLy4n8a8TQ6ZZR7Sr2Ff+Xa7EpxlBBL7JeAgfYLa49cgrSa8GhnJG
 Dbhw==
X-Gm-Message-State: AOAM531ib+HD1OKkJRxC0Yz0b4QG5Iiam3PhJxz68k99IWqHQqHvO1lN
 PouMc8drfPZyaw8SukbemYg=
X-Google-Smtp-Source: ABdhPJwQtAdUuITXXpykkxgwWFhu2CUYJjNGKst4ciCzx9dSlJJoZPdAALZZNafTQuN9U8PB3hKmcA==
X-Received: by 2002:a05:651c:227:: with SMTP id z7mr352115ljn.99.1601446239924; 
 Tue, 29 Sep 2020 23:10:39 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.googlemail.com with ESMTPSA id t13sm61057ljc.70.2020.09.29.23.10.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 23:10:39 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
To: Nicolin Chen <nicoleotsuka@gmail.com>
References: <20200930003013.31289-1-nicoleotsuka@gmail.com>
 <20200930003013.31289-3-nicoleotsuka@gmail.com>
 <75514da5-e63a-9e51-8376-abbd12c324d1@gmail.com>
 <20200930054900.GG31821@Asurada-Nvidia>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b74f96cf-0edc-c7f2-3a0e-2a4fe51e3b2e@gmail.com>
Date: Wed, 30 Sep 2020 09:10:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930054900.GG31821@Asurada-Nvidia>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 krzk@kernel.org, jonathanh@nvidia.com, thierry.reding@gmail.com,
 linux-tegra@vger.kernel.org
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

MzAuMDkuMjAyMCAwODo0OSwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gT24gV2VkLCBTZXAg
MzAsIDIwMjAgYXQgMDg6MTE6NTJBTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+PiAz
MC4wOS4yMDIwIDAzOjMwLCBOaWNvbGluIENoZW4g0L/QuNGI0LXRgjoKPj4+ICsJLyogQW4gaW52
YWxpZCBtYyBwb2ludGVyIG1lYW5zIG1jIGFuZCBzbW11IGRyaXZlcnMgYXJlIG5vdCByZWFkeSAq
Lwo+Pj4gKwlpZiAoSVNfRVJSX09SX05VTEwobWMpKQo+Pgo+PiB0ZWdyYV9nZXRfbWVtb3J5X2Nv
bnRyb2xsZXIoKSBkb2Vzbid0IHJldHVybiBOVUxMLgo+IAo+IFdlbGwsIEkgZG9uJ3Qgd2FudCB0
byBhc3N1bWUgdGhhdCBpdCdkIGRvIHRoYXQgZm9yZXZlciwgYW5kIHRoZQo+IE5VTEwgY2hlY2sg
b2YgSVNfRVJSX09SX05VTEwgaXMgbWFya2VkICJ1bmxpa2VseSIgc28gaXQgZG9lc24ndAo+IGh1
cnQgdG8gaGF2ZS4KPiAKCkkgZG9uJ3Qgc2VlIGFueSByZWFzb25zIHdoeSBpdCB3b24ndCBkbyB0
aGF0IGZvcmV2ZXIuCgpTZWNvbmRseSwgcHVibGljIGZ1bmN0aW9uIGNhbid0IGJlIGNoYW5nZWQg
cmFuZG9tbHkgd2l0aG91dCB1cGRhdGluZyBhbGwKdGhlIGNhbGxlcnMuCgpIZW5jZSB0aGVyZSBp
cyBubyBuZWVkIHRvIGhhbmRsZSBjYXNlcyB0aGF0IGNhbid0IGV2ZXIgaGFwcGVuIGFuZCBpdApo
dXJ0cyByZWFkYWJpbGl0eSBvZiB0aGUgY29kZSArIG9yaWdpbmFsIGVycm9yIGNvZGUgaXMgbWlz
c2VkLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21t
dSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
