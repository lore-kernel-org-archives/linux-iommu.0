Return-Path: <SRS0=CJHf=KH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A6CC433ED
	for <iommu@archiver.kernel.org>; Wed, 12 May 2021 10:18:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28146613D3
	for <iommu@archiver.kernel.org>; Wed, 12 May 2021 10:18:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28146613D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B1E4B83DDD;
	Wed, 12 May 2021 10:18:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NKmJM_kINmlO; Wed, 12 May 2021 10:18:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E1A483CB7;
	Wed, 12 May 2021 10:18:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80946C000D;
	Wed, 12 May 2021 10:18:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B67C9C0001
 for <iommu@lists.linux-foundation.org>; Wed, 12 May 2021 10:18:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 96BEC60A88
 for <iommu@lists.linux-foundation.org>; Wed, 12 May 2021 10:18:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xU5gWUs_VOEF for <iommu@lists.linux-foundation.org>;
 Wed, 12 May 2021 10:18:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8BE8C60A82
 for <iommu@lists.linux-foundation.org>; Wed, 12 May 2021 10:18:28 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id b25so34111942eju.5
 for <iommu@lists.linux-foundation.org>; Wed, 12 May 2021 03:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=p1Lr28CPZICLNPKVShGVHig8w62YrScW8F9lGxncgd8=;
 b=dnfICAHmPiaeDLZmpGjgeEJJASHaXH0eJI3VC2Xmvidm5MC8C11XJNQ9k+17TxAJTo
 YRRrSBBWMypslM3Wk1tElPLgdgle1FPnAVfdvi66FcpihmPiTyQq6Ev8e6O3UQ+tzcPN
 wH6ZLacZcC2WqGpmOD8Dup9ppdjlknhakMSqabsf4UFWsqeVhK2ea8kr5YfDSiiuGGP9
 9KiChkJOetM1NXnSSs39YpucSFU/gDZkXuWuPfUevO1GLOuVIeaMjBjoEXalbfy7GTx6
 nxkmcrwFv9OakaFC5voS72gN+u1+wPfm8jOAupH1Lfn7O+5hKliGTLcHNcflhWxFzp5H
 bDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=p1Lr28CPZICLNPKVShGVHig8w62YrScW8F9lGxncgd8=;
 b=lC4+8eIsDXE6ADqWnY8sylOmFjaLp2KWPUhZH20yDWkHNY8VXVS5DEKusR9L3zZII0
 pRDl5/4afaPAZbxKrZEd7g0xW0SbqPlPuuiVZ4W+jzeA3e4qeVs8R3ArIZuvF9AGxJUk
 3a3OstcJp20WHVretnnZghOwP2wowc3b4srTJbYOlCFzdsKPTJ5KCw5H4ZkWRgaiQmoR
 mcvfpYsVFnQr8zah+GUlx0H9zX2CzWHXq1FdlJxGq9Lj8xXs2wpdhAwKgTK8F/vGDzJu
 mwfpxrl22nPvPZv0g4wbkIzIajFNdAYDnQiTlY66uAr0YqaAwXPIrmQHm++WsmEDOtwq
 78+A==
X-Gm-Message-State: AOAM5332Y0vp3+2LtqEa5YgFP3vyA4BdgKbynyKyU808V8YVsRWncGWY
 IPDqVj7jDPUtDkAnF42+ExDZKw==
X-Google-Smtp-Source: ABdhPJz/QcR7QJP2BPKNx82MqhkOWkhpOz7JP/5FjEVvCkPodnidDWx4wfZchbZQt9DrOwxbqThaGg==
X-Received: by 2002:a17:906:4e82:: with SMTP id
 v2mr37700482eju.278.1620814706833; 
 Wed, 12 May 2021 03:18:26 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id q18sm16781520edd.3.2021.05.12.03.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 May 2021 03:18:26 -0700 (PDT)
Date: Wed, 12 May 2021 12:18:08 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v4 1/2] iommu/sva: Tighten SVA bind API with explicit flags
Message-ID: <YJurYOz264HKm4Bz@myrica>
References: <1620653108-44901-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1620653108-44901-2-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1620653108-44901-2-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: vkoul@kernel.org, "Tian, Kevin" <kevin.tian@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, Jason Gunthorpe <jgg@nvidia.com>,
 zhangfei.gao@linaro.org, Jean-Philippe Brucker <jean-philippe@linaro.com>
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

T24gTW9uLCBNYXkgMTAsIDIwMjEgYXQgMDY6MjU6MDdBTSAtMDcwMCwgSmFjb2IgUGFuIHdyb3Rl
Ogo+IFRoZSB2b2lkKiBkcnZkYXRhIHBhcmFtZXRlciBpc24ndCByZWFsbHkgdXNlZCBpbsKgaW9t
bXVfc3ZhX2JpbmRfZGV2aWNlKCkKPiBBUEksIHRoZSBjdXJyZW50IElEWEQgY29kZSAiYm9ycm93
cyIgdGhlIGRydmRhdGEgZm9yIGEgVlQtZCBwcml2YXRlIGZsYWcKPiBmb3Igc3VwZXJ2aXNvciBT
VkEgdXNhZ2UuCj4gCj4gU3VwZXJ2aXNvci9Qcml2aWxlZ2VkIG1vZGUgcmVxdWVzdCBpcyBhIGdl
bmVyaWMgZmVhdHVyZS4gSXQgc2hvdWxkIGJlCj4gcHJvbW90ZWQgZnJvbSB0aGUgVlQtZCB2ZW5k
b3IgZHJpdmVyIHRvIHRoZSBnZW5lcmljIGNvZGUuCj4gCj4gVGhpcyBwYXRjaCByZXBsYWNlcyB2
b2lkKiBkcnZkYXRhIHdpdGggYSB1bnNpZ25lZCBpbnQgZmxhZ3MgcGFyYW1ldGVyCj4gYW5kIGFk
anVzdHMgY2FsbGVycyBhY2NvcmRpbmdseS4KPiAKPiBMaW5rOiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9saW51eC1pb21tdS9ZRmhpTUxSMzVXV01XJTJGSHVAbXlyaWNhLwo+IFN1Z2dlc3RlZC1i
eTogSmVhbi1QaGlsaXBwZSBCcnVja2VyIDxqZWFuLXBoaWxpcHBlQGxpbmFyby5vcmc+Cj4gU2ln
bmVkLW9mZi1ieTogSmFjb2IgUGFuIDxqYWNvYi5qdW4ucGFuQGxpbnV4LmludGVsLmNvbT4KClRo
YW5rcyBmb3IgY2xlYW5pbmcgdGhpcyB1cC4gV2hldGhlciBWdC1kJ3Mgc3VwZXJ2aXNvciBtb2Rl
IHdpbGwgbmVlZApyZXdvcmsgb3Igbm90LCB0aGlzIGlzIHN0aWxsIGdvb2QgdG8gaGF2ZS4gT25l
IG5pdCBiZWxvdyBpZiB5b3UgcmVzZW5kCgpSZXZpZXdlZC1ieTogSmVhbi1QaGlsaXBwZSBCcnVj
a2VyIDxqZWFuLXBoaWxpcHBlQGxpbmFyby5vcmc+CgpbLi4uXQo+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL2xpbnV4L2lvbW11LmggYi9pbmNsdWRlL2xpbnV4L2lvbW11LmgKPiBpbmRleCAzMmQ0NDgw
NTBiZjcuLmZjYzlkMzZiNGIwMSAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2lvbW11LmgK
PiArKysgYi9pbmNsdWRlL2xpbnV4L2lvbW11LmgKPiBAQCAtMTUyLDYgKzE1MiwxOSBAQCBlbnVt
IGlvbW11X2Rldl9mZWF0dXJlcyB7Cj4gIAo+ICAjZGVmaW5lIElPTU1VX1BBU0lEX0lOVkFMSUQJ
KC0xVSkKPiAgCj4gKy8qCj4gKyAqIFRoZSBJT01NVV9TVkFfQklORF9TVVBFUlZJU09SIGZsYWcg
cmVxdWVzdHMgYSBQQVNJRCB3aGljaCBjYW4gYmUgdXNlZCBvbmx5Cj4gKyAqIGZvciBhY2Nlc3Mg
dG8ga2VybmVsIGFkZHJlc3Nlcy4gTm8gSU9UTEIgZmx1c2hlcyBhcmUgYXV0b21hdGljYWxseSBk
b25lCj4gKyAqIGZvciBrZXJuZWwgbWFwcGluZ3M7IGl0IGlzIHZhbGlkIG9ubHkgZm9yIGFjY2Vz
cyB0byB0aGUga2VybmVsJ3Mgc3RhdGljCj4gKyAqIDE6MSBtYXBwaW5nIG9mIHBoeXNpY2FsIG1l
bW9yeSDigJQgbm90IHRvIHZtYWxsb2Mgb3IgZXZlbiBtb2R1bGUgbWFwcGluZ3MuCj4gKyAqIEEg
ZnV0dXJlIEFQSSBhZGRpdGlvbiBtYXkgcGVybWl0IHRoZSB1c2Ugb2Ygc3VjaCByYW5nZXMsIGJ5
IG1lYW5zIG9mIGFuCj4gKyAqIGV4cGxpY2l0IElPVExCIGZsdXNoIGNhbGwgKGFraW4gdG8gdGhl
IERNQSBBUEkncyB1bm1hcCBtZXRob2QpLgo+ICsgKgo+ICsgKiBJdCBpcyB1bmxpa2VseSB0aGF0
IHdlIHdpbGwgZXZlciBob29rIGludG8gZmx1c2hfdGxiX2tlcm5lbF9yYW5nZSgpIHRvCj4gKyAq
IGRvIHN1Y2ggSU9UTEIgZmx1c2hlcyBhdXRvbWF0aWNhbGx5LgoKSSB3b3VsZCBhZGQgdGhhdCB0
aGlzIGlzIHBsYXRmb3JtIHNwZWNpZmljIGFuZCBub3QgYWxsIElPTU1VIGRyaXZlcnMKc3VwcG9y
dCB0aGUgZmVhdHVyZS4KClRoYW5rcywKSmVhbgoKPiArICovCj4gKyNkZWZpbmUgSU9NTVVfU1ZB
X0JJTkRfU1VQRVJWSVNPUiAgICAgICBCSVQoMCkKPiArCj4gICNpZmRlZiBDT05GSUdfSU9NTVVf
QVBJCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11
IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
