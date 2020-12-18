Return-Path: <SRS0=kXp2=FW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AB6C4361B
	for <iommu@archiver.kernel.org>; Fri, 18 Dec 2020 06:48:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1CA623A5B
	for <iommu@archiver.kernel.org>; Fri, 18 Dec 2020 06:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1CA623A5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 29808879E9;
	Fri, 18 Dec 2020 06:48:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tnkgh0bgmB5C; Fri, 18 Dec 2020 06:48:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C6675879D2;
	Fri, 18 Dec 2020 06:48:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B32FBC1786;
	Fri, 18 Dec 2020 06:48:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F619C0893
 for <iommu@lists.linux-foundation.org>; Fri, 18 Dec 2020 06:48:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 266B1879AC
 for <iommu@lists.linux-foundation.org>; Fri, 18 Dec 2020 06:48:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fqzl4n955ZsN for <iommu@lists.linux-foundation.org>;
 Fri, 18 Dec 2020 06:48:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E93F087848
 for <iommu@lists.linux-foundation.org>; Fri, 18 Dec 2020 06:48:01 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id be12so899843plb.4
 for <iommu@lists.linux-foundation.org>; Thu, 17 Dec 2020 22:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=Nd22eKsSmk6waOLkekeVIJaN2h0vcQRGdExQuNh8r+o=;
 b=JV55w9RJHlNDrpbAs0KqCWm5jTeBirALv3OzEGNimJnmYPpOniRKISwjJZ99KwhMia
 LZ0cA/j4WGXRXImtf+x7TlBbmYI7cqTI/lNnoBocYvBqR78jTb5wkzTOE5fcLGIRCV54
 IJwjhcuUOQH2w+I7lEdNtGIM9ry2apQPMX4YimceNtL7qwHnAb1BSx4GOpcpCrkVUcgE
 8ItjJeUDB8wbN64mphSntnZpXnDtkrrdQKmSWbNcGYgUPqbPpb7IrGaaKwTg+PStjlIP
 LFy4K6txICy13Oly9GRbh2hxr0hNbKZ0STEFSLj1ymii+OWwgL6EI1gv9ZDgFpBEY8cM
 pSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Nd22eKsSmk6waOLkekeVIJaN2h0vcQRGdExQuNh8r+o=;
 b=rfTYPzWxTvh8kLCv9fnF0nTIJ+PyhL8tZ7FKdqEgI/WH6l/HRVSIqBXDx7W2u4A4ag
 xWO0e84TAOJD9trLy6U6SEUoNBjmyj7OG7e8IS2aTtjeLy6ViUecjBRAm7hs/jTmfYSB
 jPdUnWTRK5YpD1QZiD5o1PmX0d6L31tKfaON0a2NRjtGPxtMjqKVeZ+BGC9rCY0AfYk4
 ZronxSHFaOaTqF2WHROCEvLWjPLfHwpdDJK12Xq1iRRptwjQ//CpS7ppDWcfgJctGYoT
 J3BN3verfPwfTmxYlh6+y+GGZlAjl6M9rTiH9Hcpm6Kaa29dUb2lBsdHriV2eEE6uC5M
 +XNQ==
X-Gm-Message-State: AOAM531q5o//lJvdokVCZE/2/pXrpHHMDsdwURcqcwnxEr2dQWvKN/Yz
 8Os8AmMd+Q5jRnw1uvJOMp560w==
X-Google-Smtp-Source: ABdhPJxN+zyn/o5/ECghJrrBpTGxb9htIs8KNFZW3iJjEN2NNdnXvN4NN921DPcleas8TN59wDvxSg==
X-Received: by 2002:a17:90a:fe8e:: with SMTP id
 co14mr2998599pjb.105.1608274081410; 
 Thu, 17 Dec 2020 22:48:01 -0800 (PST)
Received: from ?IPv6:240e:362:421:6800:e481:5ceb:8cc4:e9ab?
 ([240e:362:421:6800:e481:5ceb:8cc4:e9ab])
 by smtp.gmail.com with ESMTPSA id j20sm7610772pfd.106.2020.12.17.22.47.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Dec 2020 22:48:00 -0800 (PST)
Subject: Re: [PATCH v8 4/9] of/iommu: Support dma-can-stall property
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Robin Murphy <robin.murphy@arm.com>
References: <20201112125519.3987595-1-jean-philippe@linaro.org>
 <20201112125519.3987595-5-jean-philippe@linaro.org>
 <d0a61d79-82fc-3af8-570e-e2ae3d485455@arm.com> <X9dS9H9PrOZbND9E@myrica>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <e4dd8876-efe9-d7d9-955e-cadb9e4ef4f7@linaro.org>
Date: Fri, 18 Dec 2020 14:47:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <X9dS9H9PrOZbND9E@myrica>
Content-Language: en-US
Cc: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, guohanjun@huawei.com, rjw@rjwysocki.net,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org, sudeep.holla@arm.com,
 bhelgaas@google.com, vivek.gautam@arm.com, will@kernel.org,
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

CgpPbiAyMDIwLzEyLzE0IOS4i+WNiDg6NTEsIEplYW4tUGhpbGlwcGUgQnJ1Y2tlciB3cm90ZToK
PiBPbiBUaHUsIE5vdiAyNiwgMjAyMCBhdCAwNjowOToyNlBNICswMDAwLCBSb2JpbiBNdXJwaHkg
d3JvdGU6Cj4+IE9uIDIwMjAtMTEtMTIgMTI6NTUsIEplYW4tUGhpbGlwcGUgQnJ1Y2tlciB3cm90
ZToKPj4+IENvcHkgdGhlIGRtYS1jYW4tc3RhbGwgcHJvcGVydHkgaW50byB0aGUgZndzcGVjIHN0
cnVjdHVyZS4KPj4gQ2FuJ3Qgd2UganVzdCBoYW5kbGUgdGhpcyBhcyBhIHJlZ3VsYXIgZGV2aWNl
IHByb3BlcnR5PyBJdCdzIG5vdCBwYXJ0IG9mIHRoZQo+PiBhY3R1YWwgSU9NTVUgc3BlY2lmaWVy
LCBpdCBkb2Vzbid0IG5lZWQgdG8gYmUgdHJhbnNsYXRlZCBpbiBhbnkgd2F5LCBhbmQKPj4gQUZB
SUNTIGl0J3MgdXNlZCBhIGdyYW5kIHRvdGFsIG9mIG9uY2UsIGluIGEgc2xvdyBwYXRoLiBTaW1w
bHkgdHJlYXRpbmcgaXQKPj4gYXMgdGhlIHBlci1kZXZpY2UgcHJvcGVydHkgdGhhdCBpdCBpcyBz
aG91bGQgcmVxdWlyZSB6ZXJvIGFkZGl0aW9uYWwgY29kZQo+PiBmb3IgRFQsIGFuZCBhIHNpbXBs
ZSBkZXZpY2VfYWRkX3Byb3BlcnRpZXMoKSBjYWxsIGZvciBJT1JULgo+Pgo+PiBUQkggdGhhdCBh
cHBlYXJzIHRvIGJlIHRydWUgb2YgcGFzaWQtbnVtLWJpdHMgYXMgd2VsbC4KPiBSaWdodCBJIHRo
aW5rIHRoYXQncyBiZXR0ZXIsIHRoYW5rcyBmb3IgdGhlIHBvaW50ZXIuIEknbGwgdGFrZSBjYXJl
IG9mCj4gcGFzaWQtbnVtLWJpdHMgdG9vLiBUaGUgSHVhd2VpIHF1aXJrIChmYWtlIFBDSWUgc3Vw
cG9ydGluZyBzdGFsbCkgaXMgYQo+IGxpdHRsZSB3b3JzZSB0aGlzIHdheSwgYnV0IGl0IHNob3Vs
ZCB3b3JrLgoKVGhhbmtzIEplYW4sIEkgdGVzdGVkIHRoZSBmb2xsb3dpbmcgZGlmZiwgaXQgd29y
a3Mgd2l0aCBIdWF3ZWkgcXVpcmsuCgpUaGFua3MKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2lvbW11
