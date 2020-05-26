Return-Path: <SRS0=1lY2=7I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C92C433E1
	for <iommu@archiver.kernel.org>; Tue, 26 May 2020 15:10:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDC4E2070A
	for <iommu@archiver.kernel.org>; Tue, 26 May 2020 15:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D+4nQ0vW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC4E2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B7337232D7;
	Tue, 26 May 2020 15:10:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G7zvO7JFY63L; Tue, 26 May 2020 15:10:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 18268204E7;
	Tue, 26 May 2020 15:10:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE4EEC088D;
	Tue, 26 May 2020 15:10:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26C4FC016F
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 15:10:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 12D1F877FD
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 15:10:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FK8bGX6x76H7 for <iommu@lists.linux-foundation.org>;
 Tue, 26 May 2020 15:10:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com
 [209.85.216.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7C307876EE
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 15:10:40 +0000 (UTC)
Received: by mail-pj1-f65.google.com with SMTP id cx22so1549205pjb.1
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 08:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=zuN1PH7d2dfCgGQO7mbhwyoBsWzuZEv+CGEfJv0Zw+c=;
 b=D+4nQ0vWQOUObnvWLE2c2rqZVSpP4vHdMdjPbiYho4sYugLqtt6WRlJ+HEBBjO+1lQ
 2eR7eboY09he7DRe3bVtn422CDYVxb587PRQ/F+XM06FycTChxmMLph4uSQfy6rrhj88
 Uj/F+naAfokobOjg7tIBJp6aRXQKGJrWwM0M5NQhdl2IHrzkJZx4YN7V8c4YmU5AiA4m
 2klNrqpTzCwkPVLI9ZrzKuMoCf/oP8Y0Egww1cMRgelz+NygXiJoljRrWYfv9E+KnDQ2
 1VULYXUIQtH0XM1HRyfnK3yn7EbRcnN61uIfb9jjlWUJ7wTomFrOFYUYdUmZtFvN1GcP
 jAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=zuN1PH7d2dfCgGQO7mbhwyoBsWzuZEv+CGEfJv0Zw+c=;
 b=WTAP6ohSaTQKxbVwPmtdrQysk0PiHoHVKMCT89q+9HsgkujM5E/cij503AytsIvC/C
 qkPho9y5OPg9zBTDgjga608ccXqn+KWIVa/M4ne0TNVMC67wUv4pjiR/xz5RRoA/OI7x
 i7MVOy3ENR6uLbPm5nyg26uEr5VRuS/42GfF4iEyLSM8XL2Enx8nuhpkDRRsgp4DNoga
 UyrHfufkzF/4mFzUjn3xqjiFG1JlzWpLzZNLu7vTyRZnfNwVXMNqz6GnxAiDIE1okaHi
 hgqQoUuKKn5vWUKRN3Seyfsvuy90/Rr5u6nVxAbBsW2YjJ2uPBh8EKcrsmV7XDJVHefO
 oRqg==
X-Gm-Message-State: AOAM530NRWAJRsZJl2/w19DR/2efZ39YtridYPryVv5TYpGiVuTVv2Ez
 F2bcLF0b5NkNaV+rWfsCsZOxwQ==
X-Google-Smtp-Source: ABdhPJwe+1sgmh2OwBptymAExtulFHEpnY96Q4RDulxomLppHnhiwFUYKKMDqrVR8wVFmvAPxb4eUQ==
X-Received: by 2002:a17:90a:1a17:: with SMTP id
 23mr27507707pjk.198.1590505839978; 
 Tue, 26 May 2020 08:10:39 -0700 (PDT)
Received: from [10.140.0.202] ([45.135.186.12])
 by smtp.gmail.com with ESMTPSA id i197sm3623225pfe.30.2020.05.26.08.10.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 08:10:39 -0700 (PDT)
Subject: Re: [PATCH 1/2] PCI: Introduce PCI_FIXUP_IOMMU
To: Christoph Hellwig <hch@infradead.org>
References: <1590493749-13823-1-git-send-email-zhangfei.gao@linaro.org>
 <1590493749-13823-2-git-send-email-zhangfei.gao@linaro.org>
 <20200526144644.GA20784@infradead.org>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <39144dc0-3b04-3127-978b-bd8487dd06e0@linaro.org>
Date: Tue, 26 May 2020 23:09:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200526144644.GA20784@infradead.org>
Content-Language: en-US
Cc: jean-philippe <jean-philippe@linaro.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
 linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hanjun Guo <guohanjun@huawei.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-acpi@vger.kernel.org, linux-crypto@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 kenneth-lee-2012@foxmail.com, linux-arm-kernel@lists.infradead.org,
 Len Brown <lenb@kernel.org>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGksIENocmlzdG9waAoKT24gMjAyMC81LzI2IOS4i+WNiDEwOjQ2LCBDaHJpc3RvcGggSGVsbHdp
ZyB3cm90ZToKPiBPbiBUdWUsIE1heSAyNiwgMjAyMCBhdCAwNzo0OTowOFBNICswODAwLCBaaGFu
Z2ZlaSBHYW8gd3JvdGU6Cj4+IFNvbWUgcGxhdGZvcm0gZGV2aWNlcyBhcHBlYXIgYXMgUENJIGJ1
dCBhcmUgYWN0dWFsbHkgb24gdGhlIEFNQkEgYnVzLAo+PiBhbmQgdGhleSBuZWVkIGZpeHVwIGlu
IGRyaXZlcnMvcGNpL3F1aXJrcy5jIGhhbmRsaW5nIGlvbW11X2Z3bm9kZS4KPj4gSGVyZSBpbnRy
b2R1Y2luZyBQQ0lfRklYVVBfSU9NTVUsIHdoaWNoIGlzIGNhbGxlZCBhZnRlciBpb21tdV9md25v
ZGUKPj4gaXMgYWxsb2NhdGVkLCBpbnN0ZWFkIG9mIHJldXNpbmcgUENJX0ZJWFVQX0ZJTkFMIHNp
bmNlIGl0IHdpbGwgc2xvdwo+PiBkb3duIGlvbW11IHByb2JpbmcgYXMgYWxsIGRldmljZXMgaW4g
Zml4dXAgZmluYWwgbGlzdCB3aWxsIGJlCj4+IHJlcHJvY2Vzc2VkLgo+IFdobyBpcyBnb2luZyB0
byB1c2UgdGhpcz8gIEkgZG9uJ3Qgc2VlIGEgc2luZ2xlIHVzZXIgaW4gdGhlIHNlcmllcy4KV2Ug
d2lsbCBhZGQgaW9tbXUgZml4dXAgaW4gZHJpdmVycy9wY2kvcXVpcmtzLmMsIGhhbmRsaW5nCgpm
d3NwZWMtPmNhbl9zdGFsbCwgd2hpY2ggaXMgaW50cm9kdWNlZCBpbgoKaHR0cHM6Ly93d3cuc3Bp
bmljcy5uZXQvbGlzdHMvbGludXgtcGNpL21zZzk0NTU5Lmh0bWwKClVuZm9ydHVuYXRlbHksIHRo
ZSBwYXRjaCBkb2VzIG5vdCBjYXRjaCB2NS44LCBzbyB3ZSBoYXZlIHRvIHdhaXQuCkFuZCB3ZSB3
YW50IHRvIGNoZWNrIHdoZXRoZXIgdGhpcyBpcyBhIHJpZ2h0IG1ldGhvZCB0byBzb2x2ZSB0aGlz
IGlzc3VlLgoKVGhhbmtzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9t
bXU=
