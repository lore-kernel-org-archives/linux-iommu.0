Return-Path: <SRS0=1kRO=GO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F304DC433E0
	for <iommu@archiver.kernel.org>; Mon, 11 Jan 2021 03:29:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90F4922581
	for <iommu@archiver.kernel.org>; Mon, 11 Jan 2021 03:29:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F4922581
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 493BF86FCC;
	Mon, 11 Jan 2021 03:29:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eoAGdLBnk-EY; Mon, 11 Jan 2021 03:29:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9CA8586FC8;
	Mon, 11 Jan 2021 03:29:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8ED9EC088B;
	Mon, 11 Jan 2021 03:29:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68FCAC013A
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 03:29:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5CE7185BC4
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 03:29:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tFlClK2qD4xL for <iommu@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 03:29:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A9DCE85BB8
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 03:29:38 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id c22so11678730pgg.13
 for <iommu@lists.linux-foundation.org>; Sun, 10 Jan 2021 19:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=+190HtGxYGthJ3UarYG4jBGiYtQEc6153YIJJk+ijNY=;
 b=LuCgDnHErXxvO1PGQ6i/XYWWhYB3y1kt4JQrM24JWllHTTOymwP5NiRWkT8Yhg8jDk
 jEpoV5AWOIM5uezdU9++Df5S1ztN25zpvqbXVByw8NFrkzhpDhUwNRfK4OASGHK4/PXe
 85Zl4tSt7+xCs8ms+/2+NIyPvvFWnNFMzb67B/WbhT7Xsoaaf8TrGbCvion0tPWzPfre
 qwV0j0F4imd9ZUb1/zAJgtuEZEBQ8Xt0noWtPgEUDu9eEFCk+pIdOhL85YDm7aUzFVDl
 Pw/MUwJ9sDVp5feHXyt3Y346Ok1YcT+vC1kdI1KfcZFDsVFgZWNuAdg1gzzK//lqS9y9
 /G3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=+190HtGxYGthJ3UarYG4jBGiYtQEc6153YIJJk+ijNY=;
 b=pFRXOervPaEyQ4EfVOOwVe2Co1BGEm47WY9rHFfflGlzUhPskDfVAQrAYloUe1UND1
 wcxBf7VBrgKAW9LT9amYz9Q8Qjmw64cdbTeMz112QuDR9h2Ivnlog2/J8ny/Xox6Z1tp
 /0kBpYHlY/8hyJZra3LNHzogqMQBxugCQcWxWDSFNCqUTjTv/qDp86xB8nvUyU+rqN0V
 7YuvpQIjoJ4Ui9lyZfrqg15bb8xnu+iRtN7nhT9ko2PPCS2w/Opr7ERUgFZ0rUucaqzl
 Xn88vlaRHEPK3i/Enkp6kt37aim9FyfcgRvkbTvSfvycNA4I6gGEDsZU64HxVZ91Sphj
 944A==
X-Gm-Message-State: AOAM530eMmfogXGnKkYJoF57NS8UDPalZ2o4TSxdm80dAx8M+BXhRZcP
 KYSN6TaboWoIwXSxmxUNPImoRw==
X-Google-Smtp-Source: ABdhPJwwQFR7I7/0eiUTAGB7SUuXQ0WuUsz/4ODs/+uu4PeDeTMH0rlqowLXpZ/fV/xQ7w+hBPAYWg==
X-Received: by 2002:a63:fb49:: with SMTP id w9mr17867506pgj.403.1610335778268; 
 Sun, 10 Jan 2021 19:29:38 -0800 (PST)
Received: from ?IPv6:240e:362:4bf:e00:57d:5da4:e49:50d?
 ([240e:362:4bf:e00:57d:5da4:e49:50d])
 by smtp.gmail.com with ESMTPSA id k25sm16744621pfi.10.2021.01.10.19.29.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Jan 2021 19:29:37 -0800 (PST)
Subject: Re: [PATCH v9 05/10] uacce: Enable IOMMU_DEV_FEAT_IOPF
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, joro@8bytes.org,
 will@kernel.org
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
 <20210108145217.2254447-6-jean-philippe@linaro.org>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <2cef454d-d872-d306-ceca-c7ae1dbfea1e@linaro.org>
Date: Mon, 11 Jan 2021 11:29:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210108145217.2254447-6-jean-philippe@linaro.org>
Content-Language: en-US
Cc: devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-acpi@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 guohanjun@huawei.com, rjw@rjwysocki.net, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, linux-accelerators@lists.ozlabs.org, sudeep.holla@arm.com,
 vivek.gautam@arm.com, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, lenb@kernel.org
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

CgpPbiAyMDIxLzEvOCDkuIvljYgxMDo1MiwgSmVhbi1QaGlsaXBwZSBCcnVja2VyIHdyb3RlOgo+
IFRoZSBJT1BGIChJL08gUGFnZSBGYXVsdCkgZmVhdHVyZSBpcyBub3cgZW5hYmxlZCBpbmRlcGVu
ZGVudGx5IGZyb20gdGhlCj4gU1ZBIGZlYXR1cmUsIGJlY2F1c2Ugc29tZSBJT1BGIGltcGxlbWVu
dGF0aW9ucyBhcmUgZGV2aWNlLXNwZWNpZmljIGFuZAo+IGRvIG5vdCByZXF1aXJlIElPTU1VIHN1
cHBvcnQgZm9yIFBDSWUgUFJJIG9yIEFybSBTTU1VIHN0YWxsLgo+Cj4gRW5hYmxlIElPUEYgdW5j
b25kaXRpb25hbGx5IHdoZW4gZW5hYmxpbmcgU1ZBIGZvciBub3cuIEluIHRoZSBmdXR1cmUsIGlm
Cj4gYSBkZXZpY2UgZHJpdmVyIGltcGxlbWVudGluZyBhIHVhY2NlIGludGVyZmFjZSBkb2Vzbid0
IG5lZWQgSU9QRgo+IHN1cHBvcnQsIGl0IHdpbGwgbmVlZCB0byB0ZWxsIHRoZSB1YWNjZSBtb2R1
bGUsIGZvciBleGFtcGxlIHdpdGggYSBuZXcKPiBmbGFnLgo+Cj4gU2lnbmVkLW9mZi1ieTogSmVh
bi1QaGlsaXBwZSBCcnVja2VyIDxqZWFuLXBoaWxpcHBlQGxpbmFyby5vcmc+Cj4gLS0tCj4gQ2M6
IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+Cj4gQ2M6IEdyZWcgS3JvYWgtSGFydG1hbiA8
Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+Cj4gQ2M6IFpoYW5nZmVpIEdhbyA8emhhbmdmZWku
Z2FvQGxpbmFyby5vcmc+Cj4gQ2M6IFpob3UgV2FuZyA8d2FuZ3pob3UxQGhpc2lsaWNvbi5jb20+
ClRoYW5rcyBKZWFuCkFja2VkLWJ5OiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BsaW5hcm8u
b3JnPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9t
bXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
