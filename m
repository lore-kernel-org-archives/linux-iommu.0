Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8FDC47083
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 02:37:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D438613F0
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 02:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D438613F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EFBD54056E;
	Thu,  3 Jun 2021 02:37:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a4mzUG7iylA2; Thu,  3 Jun 2021 02:37:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7168A4056C;
	Thu,  3 Jun 2021 02:37:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33ED1C000E;
	Thu,  3 Jun 2021 02:37:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98B15C0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 02:37:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8C00F4056E
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 02:37:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LFc-cRn3gPrp for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 02:37:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 55F024056C
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 02:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622687837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uxm0/+m5dcFG2sDWbRYCYBLYAMI7JPbdvwfiFb7Glz8=;
 b=jPUVQjCqHaVQqDqa33ItVh8ZmLjwc97mhnlftCiGf26RFpvXYkndxB+x1YPP2w3RiAAnLy
 Yi0HcLNfAlmc7So5YI22dqbSgA0Aim8+bqqkZL7OiTJXow2F3bjH2I+fllvIWtjwjbz8S2
 Hj6o9FBazMCA0+4UXT8yHRB4Vnc/hsU=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-RwfG4noUO4aFHCwIsoobjw-1; Wed, 02 Jun 2021 22:37:15 -0400
X-MC-Unique: RwfG4noUO4aFHCwIsoobjw-1
Received: by mail-pg1-f197.google.com with SMTP id
 15-20020a630c4f0000b029021a6da9af28so3017192pgm.22
 for <iommu@lists.linux-foundation.org>; Wed, 02 Jun 2021 19:37:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=uxm0/+m5dcFG2sDWbRYCYBLYAMI7JPbdvwfiFb7Glz8=;
 b=ekMPYnILXVrf379zkN9iKtVXEk7hjSLDf0uVfO6cLBVGqHDadnwZhgmFZn6FfB7BdT
 oevgih9xldL0U9hFweK4jOc6inuGEsmo7WPmu9EkUA30nZ86RupPNacd7IkykGK3XXd/
 sNdhC7COO/FhuDlCkXM8/+D07ojsAL9I9wuWP+78NTkH4qsG6TmCGHSUiQmBw23hC9mK
 tJERiktM+xGzbg03RXrnWgKbZRqAdKtNVHF1jWGUIGpUsmfuMdJIYFUfFBkqiw2VBidF
 u1OI4sRME3BXMV0pq0ql4GlSdiDEqsBijk8YxAt01Pea9kLghXly6uX/76VSa42q5gTu
 k8KQ==
X-Gm-Message-State: AOAM533etBNvPuNrrnC8AlYLHmKSlip4xfIEBETPdL28EeimQA+OMfii
 iHQt1ZWsBlvJ7FfXWJ4hblSib5+w55mMg7T1XrR4usWr95o+X7BBtqltvte//1fGprZcMAkhm5v
 SwedDkVA1L/v0mMN0sCy9E6m3zwf/Jw==
X-Received: by 2002:a63:7a01:: with SMTP id v1mr3478939pgc.307.1622687834778; 
 Wed, 02 Jun 2021 19:37:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztGLN1yD3vajwb+JLkpQMmH6Ptgg5CL3UiebwVquPa3KIGm5002XUJvK1+Nc1pzYyR5Kivcw==
X-Received: by 2002:a63:7a01:: with SMTP id v1mr3478922pgc.307.1622687834579; 
 Wed, 02 Jun 2021 19:37:14 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id x6sm767172pfd.173.2021.06.02.19.37.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jun 2021 19:37:14 -0700 (PDT)
Subject: Re: [PATCH v1 2/8] virtio: Add boundary checks to virtio ring
To: Andi Kleen <ak@linux.intel.com>, mst@redhat.com
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-3-ak@linux.intel.com>
 <4be00b3a-a15f-7fee-317b-ddabed3c1347@redhat.com>
 <ccf32bdc-a487-040b-5fe6-fcc8e71a57da@linux.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6a5cae8f-0a29-8401-34b9-d9c977d11513@redhat.com>
Date: Thu, 3 Jun 2021 10:36:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <ccf32bdc-a487-040b-5fe6-fcc8e71a57da@linux.intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 jpoimboe@redhat.com, robin.murphy@arm.com, hch@lst.de
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

CtTaIDIwMjEvNi8zIMnPzucxMDoxOCwgQW5kaSBLbGVlbiDQtLXAOgo+Cj4+IEl0IGxvb2tzIHRv
IG1lIGFsbCB0aGUgZXZpbHMgY2FtZSBmcm9tIHRoZSBmYWN0IHRoYXQgd2UgZGVwZW5kcyBvbiAK
Pj4gdGhlIGRlc2NyaXB0b3IgcmluZy4KPj4KPj4gU28gdGhlIGNoZWNrcyBpbiB0aGlzIHBhdGNo
IGNvdWxkIGlzIHVubmVjZXNzYXJ5IGlmIHdlIGRvbid0IGV2ZW4gCj4+IHJlYWQgZnJvbSB0aGUg
ZGVzY3JpcHRvciByaW5nIHdoaWNoIGNvdWxkIGJlIG1hbmlwdWxhdGVkIGJ5IHRoZSBkZXZpY2Uu
Cj4+Cj4+IFRoaXMgaXMgd2hhdCBteSBzZXJpZXMgdHJpZXMgdG8gYWNoaWV2ZToKPj4KPj4gaHR0
cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMva3ZtL21zZzI0MTgyNS5odG1sCj4KPiBJIHdvdWxk
IGFyZ3VlIHRoYXQgeW91IHNob3VsZCBib3VuZGFyeSBjaGVjayBpbiBhbnkgY2FzZS4gSXQgd2Fz
IAo+IGFsd2F5cyBhIGJ1ZyB0byBub3QgaGF2ZSBib3VuZGFyeSBjaGVja3MgaW4gc3VjaCBhIGRh
dGEgc3RydWN0dXJlIHdpdGggCj4gbXVsdGlwbGUgdXNlcnMsIHRydXN0IG9yIG5vdC4KPgo+IEJ1
dCB5ZXMgeW91ciBwYXRjaCBzZXJpZXMgaXMgaW50ZXJlc3RpbmcgYW5kIGRlZmluaXRlbHkgbWFr
ZXMgc2Vuc2UgCj4gZm9yIFREWCB0b28uCj4KPiBCZXN0IHdvdWxkIGJlIHRvIGhhdmUgYm90aCBJ
IGd1ZXNzLCBhbmQgYWx3YXlzIGNoZWNrIHRoZSBib3VuZGFyaWVzIAo+IGV2ZXJ5d2hlcmUuCgoK
SSBhZ3JlZSBidXQgc29tZSBvZiB0aGUgY2hlY2tzIGFyZSB1bm5lY2Vzc2FyeSBpbiB3ZSBkbyB0
aGlzIHNlcmllcyBvbiAKdG9wIG9mIG15IHNlcmllcy4KCgo+Cj4gU28gd2hhdCdzIHRoZSBtZXJn
ZSBzdGF0dXMgb2YgeW91ciBzZXJpZXM/CgoKSWYgSSB1bmRlcnN0YW5kIGNvcnJlY3RseSBmcm9t
IE1pY2hhZWwsIEkgd2lsbCBzZW5kIGEgZm9ybWFsIHNlcmllcyBhbmQgCmhlIHdpbGwgdHJ5IHRv
IG1lcmdlIGl0IGZvciB0aGUgNS4xNC4KClRoYW5rcwoKCj4KPiAtQW5kaQo+Cj4KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlz
dAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
