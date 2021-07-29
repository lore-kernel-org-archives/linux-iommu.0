Return-Path: <SRS0=dGrv=MV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FFFC4320E
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 15:02:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D100560EC0
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 15:02:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D100560EC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8C4154058C;
	Thu, 29 Jul 2021 15:02:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WBXcZ7aXOwTq; Thu, 29 Jul 2021 15:02:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 643AD4058A;
	Thu, 29 Jul 2021 15:02:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34A3EC001A;
	Thu, 29 Jul 2021 15:02:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72655C000E
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 15:02:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5235C400AE
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 15:02:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fpI25OLkO4pj for <iommu@lists.linux-foundation.org>;
 Thu, 29 Jul 2021 15:02:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7A2A740171
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 15:02:34 +0000 (UTC)
Received: by mail-pl1-x633.google.com with SMTP id f13so7346778plj.2
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 08:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+bK/E9hMSXhFLJuYffyy4lnGRV/WQf1v1wRicssH11c=;
 b=FwB6x7B4iG0F7MUs9/9F6Dg/9PoCSP7gVTcOX0ocOJU41g4H+lOYYpyql4IyYVFcQY
 /jR2vjQ8vXFjFKbHbASRXdJemRdLMW21jXT3DV06qcoHuzHkTjYfMvskkaAemBRPzjTP
 h4JIu0oy0kK8PPRWkGWT9A0ZMN37pPHspf8nHPV3REyaJvIq/2bRvESuNsbdqOhCVZps
 wVNuJN0Wcl6YgLLFJnGARAl2uxPd4PQ0Gk5oTKljpXKFW8Dd8N4UiP1kBqxQ7w9zRhD8
 K8YjAuIKZcJf6XeOYfYrcl4FxeujnfCoH+ST0WDAmJ9l2jF1cG2dsUQ3hNCcIAs2tXUI
 dquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+bK/E9hMSXhFLJuYffyy4lnGRV/WQf1v1wRicssH11c=;
 b=qVayri/HlF9F4lCICzNfomue1DfTidaGaf/H1blg45TgxNCLtkyXITZ6kPYGTOjcEM
 49mvAn4i8lUvePKiuSHpJSkW6AWNZQHW4zSW9Qr034z7aGVcyIYmcr7DIEbvpyAt7zfE
 KLCAvsJlhKVASgH+7kblbM0iZOswHfMgh6uEQuo1XN1Xm/KnSWjTq4D6hkVtlUFUCGUn
 AvL217pBi/pnK6QVFwYnRa3wqMQcoFsN7zAB7gsFnRRgJZaEB30QoxnufT/jhHLRWeYq
 8IXt6+hB0MleIjwfI5RZgQ9qgsmUw0aW3X1NhkwPdLAOXkB2WcX8eePEM2bRjGGU0qZM
 4dnA==
X-Gm-Message-State: AOAM531Q3Nj0risIKCGxQI4FrAjHlgKZMDtmo9IUgRY+YPH0H7DQvCw3
 XMCZSeUQJX/u0zoF8IY+Gj8=
X-Google-Smtp-Source: ABdhPJzBGI9zTfesOKkMJXLKPI10+fN42IwNJPZiUXGYmFrvx/nDBD1B0BKa0HCMXpw5NCSATnP3lw==
X-Received: by 2002:a17:90a:e651:: with SMTP id
 ep17mr5748786pjb.85.1627570953940; 
 Thu, 29 Jul 2021 08:02:33 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::4b1? ([2404:f801:9000:1a:efea::4b1])
 by smtp.gmail.com with ESMTPSA id
 h30sm4026153pfr.191.2021.07.29.08.02.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jul 2021 08:02:33 -0700 (PDT)
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
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <8df2845d-ee90-56d0-1228-adebb103ec37@gmail.com>
Date: Thu, 29 Jul 2021 23:02:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <ec1d4cfd-bbbc-e27a-7589-e85d9f0438f4@intel.com>
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

T24gNy8yOS8yMDIxIDEwOjA5IFBNLCBEYXZlIEhhbnNlbiB3cm90ZToKPiBPbiA3LzI5LzIxIDY6
MDEgQU0sIFRpYW55dSBMYW4gd3JvdGU6Cj4+IE9uIDcvMjkvMjAyMSAxOjA2IEFNLCBEYXZlIEhh
bnNlbiB3cm90ZToKPj4+IE9uIDcvMjgvMjEgNzo1MiBBTSwgVGlhbnl1IExhbiB3cm90ZToKPj4+
PiBAQCAtMTk4Niw3ICsxOTg4LDkgQEAgc3RhdGljIGludCBfX3NldF9tZW1vcnlfZW5jX2RlYyh1
bnNpZ25lZCBsb25nCj4+Pj4gYWRkciwgaW50IG51bXBhZ2VzLCBib29sIGVuYykKPj4+PiAgwqDC
oMKgwqDCoCBpbnQgcmV0Owo+Pj4+ICDCoCDCoMKgwqDCoMKgIC8qIE5vdGhpbmcgdG8gZG8gaWYg
bWVtb3J5IGVuY3J5cHRpb24gaXMgbm90IGFjdGl2ZSAqLwo+Pj4+IC3CoMKgwqAgaWYgKCFtZW1f
ZW5jcnlwdF9hY3RpdmUoKSkKPj4+PiArwqDCoMKgIGlmIChodl9pc19pc29sYXRpb25fc3VwcG9y
dGVkKCkpCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiBodl9zZXRfbWVtX2VuYyhhZGRyLCBu
dW1wYWdlcywgZW5jKTsKPj4+PiArwqDCoMKgIGVsc2UgaWYgKCFtZW1fZW5jcnlwdF9hY3RpdmUo
KSkKPj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAwOwo+Pj4KPj4+IE9uZSBtb3JlIHRo
aW5nLsKgIElmIHlvdSdyZSBnb2luZyB0byBiZSBwYXRjaGluZyBnZW5lcmljIGNvZGUsIHBsZWFz
ZQo+Pj4gc3RhcnQgdXNpbmcgZmVhdHVyZSBjaGVja3MgdGhhdCBjYW4gZ2V0IG9wdGltaXplZCBh
d2F5IGF0IHJ1bnRpbWUuCj4+PiBodl9pc19pc29sYXRpb25fc3VwcG9ydGVkKCkgZG9lc24ndCBs
b29rIGxpa2UgdGhlIHdvcmxkJ3MgY2hlYXBlc3QKPj4+IGNoZWNrLsKgIEl0IGNhbid0IGJlIGlu
bGluZWQgYW5kIGNvc3RzIGF0IGxlYXN0IGEgZnVuY3Rpb24gY2FsbC4KPj4KPj4gWWVzLCB5b3Ug
YXJlIHJpZ2h0LiBIb3cgYWJvdXQgYWRkaW5nIGEgc3RhdGljIGJyYW5jaCBrZXkgZm9yIHRoZSBj
aGVjawo+PiBvZiBpc29sYXRpb24gVk0/IFRoaXMgbWF5IHJlZHVjZSB0aGUgY2hlY2sgY29zdC4K
PiAKPiBJIGRvbid0IHRoaW5rIHlvdSBuZWVkIGEgc3RhdGljIGtleS4KPiAKPiBUaGVyZSBhcmUg
YmFzaWNhbGx5IHRocmVlIGNob2ljZXM6Cj4gMS4gVXNlIGFuIGV4aXN0aW5nIFg4Nl9GRUFUVVJF
IGJpdC4gIEkgdGhpbmsgdGhlcmUncyBhbHJlYWR5IG9uZSBmb3IKPiAgICAgd2hlbiB5b3UgYXJl
IHJ1bm5pbmcgdW5kZXIgYSBoeXBlcnZpc29yLiAgSXQncyBub3Qgc3VwZXIgcHJlY2lzZSwKPiAg
ICAgYnV0IGl0J3MgYmV0dGVyIHRoYW4gd2hhdCB5b3UgaGF2ZS4KPiAyLiBEZWZpbmUgYSBuZXcg
WDg2X0ZFQVRVUkUgYml0IGZvciB3aGVuIHlvdSBhcmUgcnVubmluZyB1bmRlcgo+ICAgICBIeXBl
ci1WLgo+IDMuIERlZmluZSBhIG5ldyBYODZfRkVBVFVSRSBiaXQgc3BlY2lmaWNhbGx5IGZvciBI
eXBlci1WIGlzb2xhdGlvbiBWTQo+ICAgICBzdXBwb3J0LiAgVGhpcyBwYXJ0aWN1bGFyIGZlYXR1
cmUgbWlnaHQgYmUgYSBsaXR0bGUgdW5jb21tb24gdG8KPiAgICAgZGVzZXJ2ZSBpdHMgb3duIGJp
dC4KPiAKPiBJJ2QgcHJvYmFibHkganVzdCBkbyAjMi4KPiAKClRoZXJlIGlzIHg4Nl9oeXBlcl90
eXBlIHRvIGlkZW50aWZ5IGh5cGVydmlzb3IgdHlwZSBhbmQgd2UgbWF5IGNoZWNrIAp0aGlzIHZh
cmlhYmxlIGFmdGVyIGNoZWNraW5nIFg4Nl9GRUFUVVJFX0hZUEVSVklTT1IuCgpzdGF0aWMgaW5s
aW5lIGJvb2wgaHZfaXNfaXNvbGF0aW9uX3N1cHBvcnRlZCh2b2lkKQp7CglpZiAoIWNwdV9mZWF0
dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVfSFlQRVJWSVNPUikpCgkJcmV0dXJuIDA7CgogICAgICAg
ICBpZiAoeDg2X2h5cGVyX3R5cGUgIT0gWDg2X0hZUEVSX01TX0hZUEVSVikKICAgICAgICAgICAg
ICAgICByZXR1cm4gMDsKCgkvLyBvdXQgb2YgbGluZSBmdW5jdGlvbiBjYWxsOgoJcmV0dXJuIF9f
aHZfaXNfaXNvbGF0aW9uX3N1cHBvcnRlZCgpOwp9CQpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vaW9tbXU=
