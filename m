Return-Path: <SRS0=Vfdp=LE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA62C48BCF
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 02:00:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72914613E7
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 02:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72914613E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 245B940537;
	Thu, 10 Jun 2021 02:00:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M0zPse4A-x7s; Thu, 10 Jun 2021 02:00:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EEA4C404E0;
	Thu, 10 Jun 2021 02:00:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C09E6C000E;
	Thu, 10 Jun 2021 02:00:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91FAFC000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 02:00:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 74291401BC
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 02:00:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VA4PYzAii61y for <iommu@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 02:00:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BFC3640170
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 02:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623290410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+xQmp7fuwVh279E0Cth1KC9j6h3TM0sEtu/caMbRU18=;
 b=a5+CDxhG0+JHuvNib3mWW+zJ/qdjIWa+q9d+Rzw3uOOnUR5fhwZm31ZrvawGxyIjKcpc1q
 Ysx7FvqPcC8sGd8QZYqjVDi+1UVcNfeQ2V+eS7L74WbDxFkvYPW9gp7PUD7y6bjiPUHOd9
 se3AzCL84qRvihJctxIXTDpLv3GbNxg=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-ronFGf64PpmsUXaS4eG7HA-1; Wed, 09 Jun 2021 22:00:09 -0400
X-MC-Unique: ronFGf64PpmsUXaS4eG7HA-1
Received: by mail-pl1-f197.google.com with SMTP id
 62-20020a1709020544b0290116739a77a4so196270plf.7
 for <iommu@lists.linux-foundation.org>; Wed, 09 Jun 2021 19:00:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=+xQmp7fuwVh279E0Cth1KC9j6h3TM0sEtu/caMbRU18=;
 b=Me8y3aHjPFE84yr+68q/dEF0VikEJYLwy5BdSKPcMiS8BCPR7z6PW1NiZMuwWdhjA5
 E91Q8Fhb/XpyXze4i21m4ofknLHzQ2LFybEtGwG3f4AHJOfN0OhT6CDjiCOclKkicU05
 Klk9COsg2uMzow7GGA3MY+xo8MOL6kvHAmBC74Mpr4F3InKEUWV9ZgtITkjjUJiXTpF3
 9RzLPTmUvUxrCkSAtgH7ioqDkpp0ET8daGfjbbkDEWreQY2+qXKUjmbyJBJGuvz3xOao
 +ZyD+HHiu6lCwTRXZbt/uvi7791czP2z0+cyRCQq6onRJaFcIkoW9TF4BIUTsUkUHiHF
 is6w==
X-Gm-Message-State: AOAM530LXGdlPo2CNWans5YSvrP6eEjccAMcVSzUWywNREAcHLzfs8Yv
 ZoHlfkyuQXHstQYCeQuM0DKJXhDCT1LFj+x1vkVD6jwueHHq+KSTCI/edoZbUfbv0AFct06gaC0
 ivAFDHL8OaIwgz2xeWj4PWdgKXrR/Gw==
X-Received: by 2002:a17:90a:2f22:: with SMTP id
 s31mr743834pjd.62.1623290407727; 
 Wed, 09 Jun 2021 19:00:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw65n4JwUpdZlyhZQm9k41Hm7KYINbBHKELAjIO4WceQeGIBYZlAZLwBtr5XPeJivWvj8g7kQ==
X-Received: by 2002:a17:90a:2f22:: with SMTP id
 s31mr743805pjd.62.1623290407512; 
 Wed, 09 Jun 2021 19:00:07 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 11sm884327pge.57.2021.06.09.19.00.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jun 2021 19:00:06 -0700 (PDT)
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To: Jason Gunthorpe <jgg@nvidia.com>
References: <64898584-a482-e6ac-fd71-23549368c508@linux.intel.com>
 <429d9c2f-3597-eb29-7764-fad3ec9a934f@redhat.com>
 <MWHPR11MB1886FC7A46837588254794048C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <05d7f790-870d-5551-1ced-86926a0aa1a6@redhat.com>
 <MWHPR11MB1886269E2B3DE471F1A9A7618C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <42a71462-1abc-0404-156c-60a7ee1ad333@redhat.com>
 <20210601173138.GM1002214@nvidia.com>
 <f69137e3-0f60-4f73-a0ff-8e57c79675d5@redhat.com>
 <20210602172154.GC1002214@nvidia.com>
 <c84787ec-9d8f-3198-e800-fe0dc8eb53c7@redhat.com>
 <20210608132039.GG1002214@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f4d70f28-4bd6-5315-d7c7-0a509e4f1d1d@redhat.com>
Date: Thu, 10 Jun 2021 10:00:01 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210608132039.GG1002214@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)\"\""
 <alex.williamson@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Woodhouse <dwmw2@infradead.org>
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNi84IM/Czuc5OjIwLCBKYXNvbiBHdW50aG9ycGUg0LS1wDoKPiBPbiBUdWUsIEp1
biAwOCwgMjAyMSBhdCAwOToxMDo0MkFNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+Cj4+IFdl
bGwsIHRoaXMgc291bmRzIGxpa2UgYSByZS1pbnZlbnRpb24gb2YgaW9fdXJpbmcgd2hpY2ggaGFz
IGFscmVhZHkgd29ya2VkCj4+IGZvciBtdWx0aWZkcy4KPiBIb3cgc28/IGlvX3VyaW5nIGlzIGFi
b3V0IHNlbmRpbmcgd29yayB0byB0aGUga2VybmVsLCBub3QgZ2V0dGluZwo+IHN0cnVjdHVlZCBl
dmVudHMgYmFjaz8KCgpBY3R1YWxseSBpdCBjYW4uIFVzZXJzcGFjZSBjYW4gcG9sbCBtdWx0aXBs
ZSBmZHMgdmlhIHByZXBhcmluZyBtdWx0aXBsZSAKc3FlcyB3aXRoIElPUklOR19PUF9BREQgZmxh
Zy4KCgo+Cj4gSXQgaXMgbW9yZSBsaWtlIG9uZSBvZiB0aGUgcGVyZiByaW5ncwoKClRoaXMgbWVh
bnMgYW5vdGhlciByaW5nIGFuZCB3ZSBuZWVkIGludHJvZHVjZSBpb2N0bCgpIHRvIGFkZCBvciBy
ZW1vdmUgCmlvYXNpZHMgZnJvbSB0aGUgcG9sbC4gQW5kIGl0IHN0aWxsIG5lZWQgYSBraW5kIG9m
IGZhbGxiYWNrIGxpa2UgYSBsaXN0IAppZiB0aGUgcmluZyBpcyBmdWxsLgoKVGhhbmtzCgoKPgo+
IEphc29uCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
