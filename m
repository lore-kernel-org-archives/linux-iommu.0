Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC24C4741F
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 16:06:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CC26207FB
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 16:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFSzWCe1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC26207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id EE05F2155B;
	Wed, 30 Sep 2020 16:06:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a0yOfVOFO8Kg; Wed, 30 Sep 2020 16:06:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E7740204BA;
	Wed, 30 Sep 2020 16:06:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4C65C0889;
	Wed, 30 Sep 2020 16:06:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A59FCC0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 16:06:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 94FB485567
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 16:06:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w8jHy5JfY+DH for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 16:06:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com
 [209.85.208.194])
 by whitealder.osuosl.org (Postfix) with ESMTPS id ACD9085381
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 16:06:30 +0000 (UTC)
Received: by mail-lj1-f194.google.com with SMTP id a22so2050803ljp.13
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 09:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4gz7hftu8wVBoM2xjJ8sNgXbJ69uPZrDK6qSgjMFO8I=;
 b=hFSzWCe1t/zf7VGo+FfqCZaoM/N2qY5YJVjPZrrragCSJ0GCR0wNhhr5u/xxo/tWTm
 NcgaqdHrXLERvv4almzK8/pq914nCnSiudPKBqkHHqSe5YmKUiPKLgOEH0UcpRMjCFZb
 ILpPyXIxobmb6CVlCLhWwB7qqDGBUvb6JmMV9CAfQ8latiICicceLFFrr/LSRbOFnBRz
 fOEFHGDu8XTrH+lUko8EgIv8aFEW/Me6673r1OR1PgGNtbQm4UguXXS6kdioPrTVUAdf
 v/OrZzPNbiiJ9bU22qt8XjdjfTed+eqe4P/3N/dqANE+FAYkrC93UjbEOKWIKopWSYXv
 DOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4gz7hftu8wVBoM2xjJ8sNgXbJ69uPZrDK6qSgjMFO8I=;
 b=ope/tLrbVq0Cj7B7mWcxM+K/WPiSPuc/Y+m1NedTIn/CEZ6yhCHeky5GJMH9jSpdLO
 A31yWN26FKzFJ1u3cHlST9q/3xgPNshjpW0caytvuBb80SuwAGNKCcbaKqVSrgeAvyJi
 A6l3nDdgAJW7mJnbqxq3usQ3gqwPBx2hxjOOeXXKMZb6v7L3Zgo5EBy+7SXZc+N37gA3
 n7dmzN9G/RudYvsfj1Z/STHIJta1PbNM7RdpcajODMG+LqHqT/67zVz+2IMktbRF6ZYK
 0QvGQeg2R35emya0d5g59YENGNaqRjVUXskqEdY6oGDe4Ycp7T1F1lV+vRRzDO2+ihLF
 fkzw==
X-Gm-Message-State: AOAM531yHQmtpOfpdxpheTFlVaUSiAuUP1c2uMlIhjeyVotWuO6F9IwP
 ednl1nAT+psOlzp7dqzLD3c=
X-Google-Smtp-Source: ABdhPJySEV3K0WwibW3y87Twid/De/fw/N9Cf01bPjdaok5d/TQT/lVjDYUNqNrOHN6liUWW/eo3Qg==
X-Received: by 2002:a2e:3511:: with SMTP id z17mr1000169ljz.58.1601481988722; 
 Wed, 30 Sep 2020 09:06:28 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.googlemail.com with ESMTPSA id l4sm236175lfg.296.2020.09.30.09.06.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2020 09:06:28 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] memory: tegra: Add
 devm_tegra_get_memory_controller()
To: Thierry Reding <thierry.reding@gmail.com>
References: <20200930084258.25493-1-nicoleotsuka@gmail.com>
 <20200930084258.25493-2-nicoleotsuka@gmail.com>
 <20200930152320.GA3833404@ulmo>
 <ed7b4375-d06e-2750-e6fa-603ef2b60d36@gmail.com>
 <20200930160355.GC3833404@ulmo>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <839df5d6-513f-3d77-ba5f-a1afe5d0883a@gmail.com>
Date: Wed, 30 Sep 2020 19:06:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930160355.GC3833404@ulmo>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 krzk@kernel.org, jonathanh@nvidia.com, linux-tegra@vger.kernel.org
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

MzAuMDkuMjAyMCAxOTowMywgVGhpZXJyeSBSZWRpbmcg0L/QuNGI0LXRgjoKPiBPbiBXZWQsIFNl
cCAzMCwgMjAyMCBhdCAwNjo1MzowNlBNICswMzAwLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6Cj4+
IDMwLjA5LjIwMjAgMTg6MjMsIFRoaWVycnkgUmVkaW5nINC/0LjRiNC10YI6Cj4+PiBPbiBXZWQs
IFNlcCAzMCwgMjAyMCBhdCAwMTo0Mjo1NkFNIC0wNzAwLCBOaWNvbGluIENoZW4gd3JvdGU6Cj4+
Pj4gRnJvbTogRG1pdHJ5IE9zaXBlbmtvIDxkaWdldHhAZ21haWwuY29tPgo+Pj4+Cj4+Pj4gTXVs
dGlwbGUgVGVncmEgZHJpdmVycyBuZWVkIHRvIHJldHJpZXZlIE1lbW9yeSBDb250cm9sbGVyIGFu
ZCBoZW5jZSB0aGVyZQo+Pj4+IGlzIHF1aXRlIHNvbWUgZHVwbGljYXRpb24gb2YgdGhlIHJldHJp
ZXZhbCBjb2RlIGFtb25nIHRoZSBkcml2ZXJzLiBMZXQncwo+Pj4+IGFkZCBhIG5ldyBjb21tb24g
aGVscGVyIGZvciB0aGUgcmV0cmlldmFsIG9mIHRoZSBNQy4KPj4+Pgo+Pj4+IFNpZ25lZC1vZmYt
Ynk6IERtaXRyeSBPc2lwZW5rbyA8ZGlnZXR4QGdtYWlsLmNvbT4KPj4+PiBTaWduZWQtb2ZmLWJ5
OiBOaWNvbGluIENoZW4gPG5pY29sZW90c3VrYUBnbWFpbC5jb20+Cj4+Pj4gLS0tCj4+Pj4KPj4+
PiBDaGFuZ2Vsb2cKPj4+PiB2Mi0+djM6Cj4+Pj4gICogUmVwbGFjZWQgd2l0aCBEaW10cnkncyBk
ZXZtX3RlZ3JhX2dldF9tZW1vcnlfY29udHJvbGxlcigpCj4+Pj4gdjEtPnYyOgo+Pj4+ICAqIE4v
QQo+Pj4+Cj4+Pj4gIGRyaXZlcnMvbWVtb3J5L3RlZ3JhL21jLmMgfCAzOSArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysKPj4+PiAgaW5jbHVkZS9zb2MvdGVncmEvbWMuaCAg
ICB8IDE3ICsrKysrKysrKysrKysrKysrCj4+Pj4gIDIgZmlsZXMgY2hhbmdlZCwgNTYgaW5zZXJ0
aW9ucygrKQo+Pj4KPj4+IExldCdzIG5vdCBhZGQgdGhpcyBoZWxwZXIsIHBsZWFzZS4gSWYgYSBk
ZXZpY2UgbmVlZHMgYSByZWZlcmVuY2UgdG8gdGhlCj4+PiBtZW1vcnkgY29udHJvbGxlciwgaXQg
c2hvdWxkIGhhdmUgYSBwaGFuZGxlIHRvIHRoZSBtZW1vcnkgY29udHJvbGxlciBpbgo+Pj4gZGV2
aWNlIHRyZWUgc28gdGhhdCBpdCBjYW4gYmUgbG9va2VkIHVwIGV4cGxpY2l0bHkuCj4+Pgo+Pj4g
QWRkaW5nIHRoaXMgaGVscGVyIGlzIG9mZmljaWFsbHkgc2FuY3Rpb25pbmcgdGhhdCBpdCdzIG9r
YXkgbm90IHRvIGhhdmUKPj4+IHRoYXQgcmVmZXJlbmNlIGFuZCB0aGF0J3MgYSBiYWQgaWRlYS4K
Pj4KPj4gQW5kIHBsZWFzZSBleHBsYWluIHdoeSBpdCdzIGEgYmFkIGlkZWEsIEkgZG9uJ3Qgc2Vl
IGFueXRoaW5nIGJhZCBoZXJlIGF0Cj4+IGFsbC4KPiAKPiBXZWxsLCB5b3Ugc2FpZCB5b3Vyc2Vs
ZiBpbiBhIHJlY2VudCBjb21tZW50IHRoYXQgd2Ugc2hvdWxkIGF2b2lkIGdsb2JhbAo+IHZhcmlh
Ymxlcy4gZGV2bV90ZWdyYV9nZXRfbWVtb3J5X2NvbnRyb2xsZXIoKSBpcyBub3RoaW5nIGJ1dCBh
IGdsb3JpZmllZAo+IGdsb2JhbCB2YXJpYWJsZS4KClRoaXMgaXMgbm90IGEgdmFyaWFibGUsIGJ1
dCBhIGNvbW1vbiBoZWxwZXIgZnVuY3Rpb24gd2hpY2ggd2lsbCByZW1vdmUKdGhlIGR1cGxpY2F0
ZWQgY29kZSBhbmQgd2lsbCBoZWxwIHRvIGF2b2lkIGNvbW1vbiBtaXN0YWtlcyBsaWtlIGEgbWlz
c2VkCnB1dF9kZXZpY2UoKS4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lv
bW11
