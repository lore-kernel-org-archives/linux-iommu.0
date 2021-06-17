Return-Path: <SRS0=K0Me=LL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D027AC49361
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 03:13:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71797613BF
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 03:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71797613BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3A7E8402FB;
	Thu, 17 Jun 2021 03:13:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xwcG8lZHtj78; Thu, 17 Jun 2021 03:13:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0024E402F2;
	Thu, 17 Jun 2021 03:13:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3C47C000D;
	Thu, 17 Jun 2021 03:13:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05EEAC000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 03:13:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DFB8F402FB
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 03:13:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iPAWVs73ZoRz for <iommu@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 03:13:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EF33F402F2
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 03:13:44 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id ei4so2944749pjb.3
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 20:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=LK0e/zXqoa92GHXVSM0nWPMcz/Pqo2k+ojs5vodEUNo=;
 b=k08oZqD00VNpqV2sYzG8HhNVj8HSDIXjmJI7jiHkB6BaozzME7UksUN90Bkps3NBty
 xGWesecQOqC/kddOKK0kP0zFZ+EYV3y/xlfig1cqT6Dc6OFWCNq3RtXZ/XyNXaxERuo1
 BIkgTw6z+lWkHyq+xL/Im3JYdyONwwGqDA7KO+2R1DLY2BBA3mgj8hg7bgMJy8vUabdW
 tGYUrcsfdTCVY+vKbRkaNQ/Nk3rsWQ89H8ytu4nFXk8+zNw/YPj2E8mmpW8elQ42VXJC
 6k/gXjpe3pvThOrgRwGpi6fSIHkE3l2tVHvEvDf0RggZ6R7d1zjQGsOccE8x7aWHXEtw
 DtJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=LK0e/zXqoa92GHXVSM0nWPMcz/Pqo2k+ojs5vodEUNo=;
 b=tV8VS3bm+vYZJgUiVWGrCu1WwmG3hw9Ja4r9wIGZOqEeCb2Qj3HQ8pN/K4qSg/uEGO
 z4bPXA8YdZRRnuhIEXDFo7jAkY7qopRGwLq7Nhk1zU4IdbmBFE/q8b7+UwZK/vYIFceB
 yuWaYz9upzWY4/yhTtfOe5W9A5KSHdjWJWQ8If0nLt0MxpAPbQ9rbiIizGUw7u8mYxkC
 +0glSUnKulAGjdrBkkG3pkPqOiYR+tBq0z7sh166OxlNDK6LJJ7kcCEdUQivLqMyh7m2
 fJ+4oHwaIYTPGGhtNAS7qATpYFTZT6/ColHtmx8JrkZWqBhojVe+qEHun/VqK+ItzXmt
 zS4w==
X-Gm-Message-State: AOAM530ieZFq327MRcuKCjZu+c1kM73z3Y+JnODMau0ROLMhvHv1RhyS
 j5p/9BSMk5b+YV+h5px9KE6sgA==
X-Google-Smtp-Source: ABdhPJzuLbquYGicD0qoCPTNLZWheR3sXEQ/O/UiJZ2kc+sCO6VqH8LMNsLGRx1QvfeO7GuOp4hR1g==
X-Received: by 2002:a17:903:49:b029:118:5d88:32ce with SMTP id
 l9-20020a1709030049b02901185d8832cemr2572224pla.10.1623899624378; 
 Wed, 16 Jun 2021 20:13:44 -0700 (PDT)
Received: from [10.11.0.58] ([45.135.186.132])
 by smtp.gmail.com with ESMTPSA id m18sm3431466pff.88.2021.06.16.20.13.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jun 2021 20:13:43 -0700 (PDT)
Subject: Re: [RFC PATCH] iommu: add domain->nested
To: Christoph Hellwig <hch@lst.de>
References: <1623854282-26121-1-git-send-email-zhangfei.gao@linaro.org>
 <20210616144413.GA2593@lst.de>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <ba504241-0442-e76d-8b46-77b686551d80@linaro.org>
Date: Thu, 17 Jun 2021 11:13:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210616144413.GA2593@lst.de>
Content-Language: en-US
Cc: jean-philippe <jean-philippe@linaro.org>, kvm@vger.kernel.org,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>
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

CgpPbiAyMDIxLzYvMTYg5LiL5Y2IMTA6NDQsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+IE9u
IFdlZCwgSnVuIDE2LCAyMDIxIGF0IDEwOjM4OjAyUE0gKzA4MDAsIFpoYW5nZmVpIEdhbyB3cm90
ZToKPj4gKysrIGIvaW5jbHVkZS9saW51eC9pb21tdS5oCj4+IEBAIC04Nyw2ICs4Nyw3IEBAIHN0
cnVjdCBpb21tdV9kb21haW4gewo+PiAgIAl2b2lkICpoYW5kbGVyX3Rva2VuOwo+PiAgIAlzdHJ1
Y3QgaW9tbXVfZG9tYWluX2dlb21ldHJ5IGdlb21ldHJ5Owo+PiAgIAl2b2lkICppb3ZhX2Nvb2tp
ZTsKPj4gKwlpbnQgbmVzdGVkOwo+IFRoaXMgc2hvdWxkIHByb2JhYmx5IGJlIGEgYm9vbCA6IDE7
Cj4KPiBBbHNvIHRoaXMgbmVlZHMgYSB1c2VyLCBzbyBwbGVhc2UganVzdCBxdWV1ZSB1cCBhIHZh
cmlhbnQgb2YgdGhpcyBmb3IKPiB0aGUgY29kZSB0aGF0IGV2ZW50dWFsbHkgcmVsaWVzIG9uIHRo
aXMgaW5mb3JtYXRpb24uClRoYW5rcyBDaHJpc3RvcGgKCkdvdCBpdCwgd2lsbCBkbyB0aGlzLgoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1h
aWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
