Return-Path: <SRS0=/Eks=4X=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44462C3F2D7
	for <iommu@archiver.kernel.org>; Fri,  6 Mar 2020 02:37:09 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CB0A206D7
	for <iommu@archiver.kernel.org>; Fri,  6 Mar 2020 02:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ziG/FPpC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CB0A206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C02982262F;
	Fri,  6 Mar 2020 02:37:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RHnyoz3SDA44; Fri,  6 Mar 2020 02:37:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id EF3CA22613;
	Fri,  6 Mar 2020 02:37:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DEBFEC1AE2;
	Fri,  6 Mar 2020 02:37:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B410FC013E
 for <iommu@lists.linux-foundation.org>; Fri,  6 Mar 2020 02:37:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A8F7C880C4
 for <iommu@lists.linux-foundation.org>; Fri,  6 Mar 2020 02:37:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fed8o7m6s-fB for <iommu@lists.linux-foundation.org>;
 Fri,  6 Mar 2020 02:37:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com
 [209.85.216.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E2EB9880C3
 for <iommu@lists.linux-foundation.org>; Fri,  6 Mar 2020 02:37:05 +0000 (UTC)
Received: by mail-pj1-f66.google.com with SMTP id o2so428524pjp.2
 for <iommu@lists.linux-foundation.org>; Thu, 05 Mar 2020 18:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=2QSQagBk8OSnwRoBTGse7P63wd/qKZn7zPPbs//Oq18=;
 b=ziG/FPpCvypm9vY7+OruvzJjZaHOkQ6Eqw6zf29DKAe7vl+dxC6DjySoy81waLuRgU
 F8/iWLM1GOUxPpQwuSubo32CEJ3sNddl+YfG9Cnh6fjJZ9HaJ0y/dvI7+TAMlfsfaRwf
 /0aO9rXEtpaSWFhT8O+mZdaUQ3vsSlsSQhd/HH5z9n46t0cIgcIItD/lfkrJmxK3s0TY
 eblmwLLXevrdSYrh8nc9NZIcwkfJprINCsY+mB7oYDUPkhjv1zh5sOB8VBtbkGe5l5/F
 ReNuico5Mb5TXINCKnMB5CJVvh0dEUAHsDx/iDxV89jpXeeAUPlsB+Sx+nPUqpFHXzhe
 a1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=2QSQagBk8OSnwRoBTGse7P63wd/qKZn7zPPbs//Oq18=;
 b=scA8hEh7qCYwQI2hGDFgjkHoA0E0I1SFcbY9WS9Yd91ZbZzXlvSm9D8OoWCiL9dbRT
 SlmcK7WQ+eqX7wAWFFVFEZtulsD70imITeqdXxYFtaf3EXT/JpEpXCjoixB1UcFHc27U
 GKk6Avn3iG/X0B3CPMZMWsGayalQR1yOncueSvz+T/pEM+efKJpvvpKAChSqWJRLu98Y
 Km90lDOe0oIYc1UNPpal6Haj70Wyy52rS5TetEoXwyNw2HWSyqAG7MQqm5HvHmY0bIVm
 Xsj+gcQ+835marpgChuwaetTlEKTuK6nrucyHhyye8PiJZDDo1b0bvW+08UTmum088zQ
 l+7w==
X-Gm-Message-State: ANhLgQ2L9UclEgA49qpNBb2wL/6kIHpu1konQI0CO9krJT/NQu4syLY+
 QasjtUKPaxdF2USJsY2frH9mIDdHMOA=
X-Google-Smtp-Source: ADFU+vubEpW42LJ68zq8890hphioBy3lQwPFQH72OCR1cxYvfmto8q1733nBuyqMtZUKUkcvRrJWQQ==
X-Received: by 2002:a17:902:61:: with SMTP id 88mr827724pla.17.1583462225267; 
 Thu, 05 Mar 2020 18:37:05 -0800 (PST)
Received: from [10.191.0.78] ([45.135.186.118])
 by smtp.gmail.com with ESMTPSA id f127sm34474687pfa.112.2020.03.05.18.36.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 05 Mar 2020 18:37:04 -0800 (PST)
Subject: Re: [PATCH v2] uacce: unmap remaining mmapping from user space
To: Herbert Xu <herbert@gondor.apana.org.au>
References: <1582701126-5312-1-git-send-email-zhangfei.gao@linaro.org>
 <20200306015121.GH30653@gondor.apana.org.au>
From: zhangfei <zhangfei.gao@linaro.org>
Message-ID: <a8beaf1f-a510-7fca-d048-1327c87226fa@linaro.org>
Date: Fri, 6 Mar 2020 10:36:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200306015121.GH30653@gondor.apana.org.au>
Content-Language: en-US
Cc: jean-philippe <jean-philippe@linaro.org>, dave.jiang@intel.com,
 kenneth-lee-2012@foxmail.com, Arnd Bergmann <arnd@arndb.de>,
 francois.ozog@linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 ilias.apalodimas@linaro.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
 grant.likely@arm.com, "haojian . zhuang" <haojian.zhuang@linaro.org>,
 linux-accelerators@lists.ozlabs.org, guodong.xu@linaro.org,
 linux-crypto@vger.kernel.org
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

CgpPbiAyMDIwLzMvNiDkuIrljYg5OjUxLCBIZXJiZXJ0IFh1IHdyb3RlOgo+IE9uIFdlZCwgRmVi
IDI2LCAyMDIwIGF0IDAzOjEyOjA2UE0gKzA4MDAsIFpoYW5nZmVpIEdhbyB3cm90ZToKPj4gV2hl
biB1YWNjZSBwYXJlbnQgZGV2aWNlIG1vZHVsZSBpcyByZW1vdmVkLCB1c2VyIGFwcCBtYXkKPj4g
c3RpbGwga2VlcCB0aGUgbW1hcGVkIGFyZWEsIHdoaWNoIGNhbiBiZSBhY2Nlc3NlZCB1bnNhZmVs
eS4KPj4gV2hlbiBybW1vZCwgUGFyZW50IGRldmljZSBkcml2ZXIgd2lsbCBjYWxsIHVhY2NlX3Jl
bW92ZSwKPj4gd2hpY2ggdW5tYXAgYWxsIHJlbWFpbmluZyBtYXBwaW5nIGZyb20gdXNlciBzcGFj
ZSBmb3Igc2FmZXR5Lgo+PiBWTV9GQVVMVF9TSUdCVVMgaXMgYWxzbyByZXBvcnRlZCB0byB1c2Vy
IHNwYWNlIGFjY29yZGluZ2x5Lgo+Pgo+PiBTdWdnZXN0ZWQtYnk6IERhdmUgSmlhbmcgPGRhdmUu
amlhbmdAaW50ZWwuY29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVp
Lmdhb0BsaW5hcm8ub3JnPgo+PiAtLS0KPj4gICB2MjogVW5tYXAgYmVmb3JlIHB1dF9xdWV1ZSwg
d2hlcmUgbWVtb3J5IGlzIGZyZWVkLCBjb21tZW50ZWQgZnJvbSBaYWliby4KPj4KPj4gICBkcml2
ZXJzL21pc2MvdWFjY2UvdWFjY2UuYyB8IDE2ICsrKysrKysrKysrKysrKysKPj4gICBpbmNsdWRl
L2xpbnV4L3VhY2NlLmggICAgICB8ICAyICsrCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxOCBpbnNl
cnRpb25zKCspCj4gUGF0Y2ggYXBwbGllZC4gIFRoYW5rcy4KVGhhbmtzIEhlcmJlcnQgZm9yIHRo
ZSBoZWxwLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpp
b21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
