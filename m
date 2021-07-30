Return-Path: <SRS0=GV0T=MW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1E5C4338F
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 02:53:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE36560FED
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 02:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CE36560FED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7C90F4022D;
	Fri, 30 Jul 2021 02:53:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id psK9uELlH2oB; Fri, 30 Jul 2021 02:53:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2392B400BE;
	Fri, 30 Jul 2021 02:53:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3ABCC001A;
	Fri, 30 Jul 2021 02:53:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1FE6C000E
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 02:53:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C8702406A9
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 02:53:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X_hpA7Q1nIyB for <iommu@lists.linux-foundation.org>;
 Fri, 30 Jul 2021 02:52:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AEE1D4067B
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 02:52:59 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id ca5so12994499pjb.5
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 19:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bmL4SQ8GAZJWK3xApvq+PZaab/7COKw/aR8FnJTkZ8A=;
 b=NAhocIP4f3vAt+HHEuF7oFkro+lh/6vEAuGcefhg6XueHZFW/VgAw1rUNxuPFA9NmR
 cmXx+ceLZex9nGJ0OyzZaxsYsT8tiRb1jRyPL71vgLtSWLPo0cCqvQ2qriDvy8CpQssj
 viNqrboexe+B/LVVnnduOrHj946GTrR2N6htuF3Da/GGsbOKkj/XSoD3hUHgJvjwaB5p
 T3Mh0d9xRtStBYG2xEqHf2hhw7W3QR/YGkGCbpjg9hYVaJSISM4slgqWraPF6pZEHZNm
 jukHYbtabQpZEinKjbGFHZgXMHh/LOo9XYtuFBdeFaYM0POV1AQF6Po3lzHo4DXqdZqC
 RNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bmL4SQ8GAZJWK3xApvq+PZaab/7COKw/aR8FnJTkZ8A=;
 b=nnW0Lmc1uUi76WW63PNoLBx8H6mWVHJBj+pWaj8WUhP2k2DceAjwMiAE0/OyQHVt5S
 T8xiYwXTMxhiHOUCsejl1qv7vE9fTa6cXbG2fxOoGnWz4GoMDJ1PZBrws/EykXmC1IO+
 ReKIdudcvMmBI8XFHX/eLd4JsZWq+UMHEG9etY8FmfMf5e2qinYUkQKbvyqmFrec5Wzx
 T/VWYxiklQRyXmOnWBUSYWF6b3zFz52GsyBkdcbKnKx7kzrfMq063pp8hEdVTs3ctkuq
 JgBUcidmRyvs1fUEEegVVd0+TWl58IvKQyI8mNPznDSRkP5ew/fg9sz6aTHoFGZL2WsD
 Up+g==
X-Gm-Message-State: AOAM530/q/9+libLg4THKnMW5jlIeLhiqE2RGAQlnywR8nSJE9YwU4o8
 Q6VMkbR51/kI8vPyBNMdglc=
X-Google-Smtp-Source: ABdhPJyyZoBDWV7ZCj8Ji9VpActKffc9EXcufc2IzXROiuNMi/ja4nm1BshkPIm0WrFthtY+V0e3wQ==
X-Received: by 2002:a17:90a:1109:: with SMTP id
 d9mr575516pja.183.1627613579170; 
 Thu, 29 Jul 2021 19:52:59 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::4b1? ([2404:f801:9000:18:efec::4b1])
 by smtp.gmail.com with ESMTPSA id
 l10sm154977pjg.11.2021.07.29.19.52.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jul 2021 19:52:58 -0700 (PDT)
Subject: Re: [PATCH 03/13] x86/HV: Add new hvcall guest address host
 visibility support
To: Dave Hansen <dave.hansen@intel.com>, kys@microsoft.com,
 haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 x86@kernel.org, hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
 peterz@infradead.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
 jgross@suse.com, sstabellini@kernel.org, joro@8bytes.org, will@kernel.org,
 davem@davemloft.net, kuba@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com, arnd@arndb.de, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com, thomas.lendacky@amd.com,
 brijesh.singh@amd.com, ardb@kernel.org, Tianyu.Lan@microsoft.com,
 rientjes@google.com, martin.b.radev@gmail.com, akpm@linux-foundation.org,
 rppt@kernel.org, kirill.shutemov@linux.intel.com,
 aneesh.kumar@linux.ibm.com, krish.sadhukhan@oracle.com, saravanand@fb.com,
 xen-devel@lists.xenproject.org, pgonda@google.com, david@redhat.com,
 keescook@chromium.org, hannes@cmpxchg.org, sfr@canb.auug.org.au,
 michael.h.kelley@microsoft.com
References: <20210728145232.285861-1-ltykernel@gmail.com>
 <20210728145232.285861-4-ltykernel@gmail.com>
 <a2444c36-0103-8e1c-7005-d97f77f90e85@intel.com>
 <0d956a05-7d24-57a0-f4a9-dccc849b52fc@gmail.com>
 <ec1d4cfd-bbbc-e27a-7589-e85d9f0438f4@intel.com>
 <8df2845d-ee90-56d0-1228-adebb103ec37@gmail.com>
 <7a2ddcca-e249-ba63-8709-e355fcef2d41@intel.com>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <fa6cf8b6-7da0-dadf-b137-d90ce3513d5e@gmail.com>
Date: Fri, 30 Jul 2021 10:52:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <7a2ddcca-e249-ba63-8709-e355fcef2d41@intel.com>
Content-Language: en-US
Cc: linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 anparri@microsoft.com, vkuznets@redhat.com
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

T24gNy8zMC8yMDIxIDEyOjA1IEFNLCBEYXZlIEhhbnNlbiB3cm90ZToKPiBPbiA3LzI5LzIxIDg6
MDIgQU0sIFRpYW55dSBMYW4gd3JvdGU6Cj4+Pgo+Pgo+PiBUaGVyZSBpcyB4ODZfaHlwZXJfdHlw
ZSB0byBpZGVudGlmeSBoeXBlcnZpc29yIHR5cGUgYW5kIHdlIG1heSBjaGVjawo+PiB0aGlzIHZh
cmlhYmxlIGFmdGVyIGNoZWNraW5nIFg4Nl9GRUFUVVJFX0hZUEVSVklTT1IuCj4+Cj4+IHN0YXRp
YyBpbmxpbmUgYm9vbCBodl9pc19pc29sYXRpb25fc3VwcG9ydGVkKHZvaWQpCj4+IHsKPj4gIMKg
wqDCoMKgaWYgKCFjcHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJFX0hZUEVSVklTT1IpKQo+
PiAgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+Cj4+ICDCoMKgwqDCoMKgwqDCoCBpZiAoeDg2
X2h5cGVyX3R5cGUgIT0gWDg2X0hZUEVSX01TX0hZUEVSVikKPj4gIMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4KPj4gIMKgwqDCoMKgLy8gb3V0IG9mIGxpbmUgZnVu
Y3Rpb24gY2FsbDoKPj4gIMKgwqDCoMKgcmV0dXJuIF9faHZfaXNfaXNvbGF0aW9uX3N1cHBvcnRl
ZCgpOwo+PiB9Cj4gCj4gTG9va3MgZmluZS4gIFlvdSBqdXN0IG1pZ2h0IHdhbnQgdG8gdXNlIHRo
aXMgZXhpc3RpbmcgaGVscGVyOgo+IAo+IHN0YXRpYyBpbmxpbmUgYm9vbCBoeXBlcnZpc29yX2lz
X3R5cGUoZW51bSB4ODZfaHlwZXJ2aXNvcl90eXBlIHR5cGUpCj4gewo+ICAgICAgICAgIHJldHVy
biB4ODZfaHlwZXJfdHlwZSA9PSB0eXBlOwo+IH0KPiAKClllcyx0aGFua3MgZm9yIHN1Z2dlc3Rp
b24gYW5kIHdpbGwgdXBkYXRlIGluIHRoZSBuZXh0IHZlcnNpb24uCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
