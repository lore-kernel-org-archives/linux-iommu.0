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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB8CC2D0A8
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 05:58:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D887B206B8
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 05:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1lY6Z8k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D887B206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 56169871B8;
	Wed, 30 Sep 2020 05:58:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B6REAV6RSVDF; Wed, 30 Sep 2020 05:58:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id DEB0D87174;
	Wed, 30 Sep 2020 05:58:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5443C0889;
	Wed, 30 Sep 2020 05:58:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1FC71C0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:58:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 07AB986709
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:58:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GFjVKcP9o8id for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 05:58:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
 [209.85.208.196])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 16BE4859EA
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:58:53 +0000 (UTC)
Received: by mail-lj1-f196.google.com with SMTP id k25so520274ljg.9
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 22:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=A07jU2fqPNriE7JlbjVVJctTqDJScAFyMSa09/qBUv0=;
 b=L1lY6Z8k4TVVtEgLMsoRnQXR4YsDfmlHB7D63jhrEfmJTuOGZYR3VKgVhu5m+GYfVa
 craHGNpoduK/2toDTG2Tvtjecw36hjOeq9gHozp97m+os2x2xfUOnYZObLFQ5W4k3ZnK
 lDI5ihwL3QeonI2bNkFO+2x1jYduhRNDjluYXm8+jo65mORHQXjPgV+SPddWE8vf1wDl
 kn/7hn3TGC53kSpcRUNEHTYBdPHmXDmhuRyCuCEF5wrPewpok5o8Z6Hlk0XVEky3UD5o
 oU8kEL76CjV8jXBovByst13qIn/OQRdRdgb+Dwvo9ByEEcCxU/Iha8f1aI2Kpkpq+d3n
 RzjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=A07jU2fqPNriE7JlbjVVJctTqDJScAFyMSa09/qBUv0=;
 b=Vd5RSv9l/R1Ciu4LSaDpJCiLgWqljrySjruuUhp5XgWLaX45yY5seJJ0LJqwX2Wigf
 6VE1v0rPePi6bgSFD2rknUmq7bmTqUpzFIPBc+eYXQqSXCSLFQh6p9P6Ny2VdU8FWAGl
 MLG25eP76luLD4C01UNl3trRfUmTnl3BONFQYeXWiYt+YxglS/zSB5b/lkxWJiBSR55I
 FhA8OtzWUhfi5O9B+xz6vULOPzHf6Xvct8KDwCnsjv8vhJEwGlmSgNfj6sjkEjedPzsO
 /AQR4g5CZ+X9RXhDb8gbAWBnHg04Gleh5o1iWbUJfhgSkgEr9P4iTtJKwLOOgGrpXGlI
 1Fbw==
X-Gm-Message-State: AOAM531knu/lPR9VdkqoaHMmNb/gKze9JPA6C7q1QBb4lJ14sQRH2e6u
 Dq3UtVbdT5XzNyr2WV/43XQ=
X-Google-Smtp-Source: ABdhPJxYDYoBve1aBYaWHrCG+fPFDN1UNSoZFfHrz97nddxSlqSfsLnEBI8pcwyVntBP7cmj+JFzFw==
X-Received: by 2002:a05:651c:1af:: with SMTP id
 c15mr363650ljn.347.1601445531354; 
 Tue, 29 Sep 2020 22:58:51 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.googlemail.com with ESMTPSA id p9sm57855ljj.52.2020.09.29.22.58.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 22:58:50 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] iommu/tegra-smmu: Add PCI support
To: Nicolin Chen <nicoleotsuka@gmail.com>
References: <20200930003013.31289-1-nicoleotsuka@gmail.com>
 <20200930003013.31289-4-nicoleotsuka@gmail.com>
 <f07d4fcc-ee19-874b-c542-0679660c3549@gmail.com>
 <20200930052952.GB31821@Asurada-Nvidia>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <96e71d38-5888-5b21-f0e1-9e6def50484e@gmail.com>
Date: Wed, 30 Sep 2020 08:58:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930052952.GB31821@Asurada-Nvidia>
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

MzAuMDkuMjAyMCAwODoyOSwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gSGkgRG1pdHJ5LAo+
IAo+IE9uIFdlZCwgU2VwIDMwLCAyMDIwIGF0IDA4OjEwOjA3QU0gKzAzMDAsIERtaXRyeSBPc2lw
ZW5rbyB3cm90ZToKPj4gMzAuMDkuMjAyMCAwMzozMCwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6
Cj4+PiAtCWdyb3VwLT5ncm91cCA9IGlvbW11X2dyb3VwX2FsbG9jKCk7Cj4+PiArCWdyb3VwLT5n
cm91cCA9IHBjaSA/IHBjaV9kZXZpY2VfZ3JvdXAoZGV2KSA6IGlvbW11X2dyb3VwX2FsbG9jKCk7
Cj4+Cj4+IFRoaXMgd2lsbCBiZSBuaWNlciB0byB3cml0ZSBhczoKPj4KPj4gaWYgKGRldl9pc19w
Y2koZGV2KSkKPj4gICAgIGdyb3VwLT5ncm91cCA9IHBjaV9kZXZpY2VfZ3JvdXAoZGV2KTsKPj4g
ZWxzZQo+PiAgICAgZ3JvdXAtPmdyb3VwID0gZ2VuZXJpY19kZXZpY2VfZ3JvdXAoZGV2KTsKPiAK
PiBXaHkgaXMgdGhhdCBuaWNlcj8gSSBkb24ndCBmZWVsIG1pbmUgaXMgaGFyZCB0byByZWFkIGF0
IGFsbC4uLgo+IAoKUHJldmlvdXNseSB5b3Ugc2FpZCB0aGF0IHlvdSdyZSBnb2luZyB0byBhZGQg
VVNCIHN1cHBvcnQsIHNvIEkgYXNzdW1lCnRoZXJlIHdpbGwgYmUgc29tZXRoaW5nIGFib3V0IFVT
Qi4KCkl0J3MgYWxzbyBhIGtpbmRhIGNvbW1vbiBzdHlsZSB0aGF0IG1ham9yaXR5IG9mIFRlZ3Jh
IGRyaXZlcnMgdXNlIGluCnVwc3RyZWFtIGtlcm5lbC4gQnV0IHlvdXJzIHZhcmlhbnQgaXMgZ29v
ZCB0b28gaWYgdGhlcmUgd29uJ3QgYmUgYSBuZWVkCnRvIGNoYW5nZSBpdCBsYXRlciBvbi4KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGlu
ZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
