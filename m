Return-Path: <SRS0=eMD9=K6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633E6C47096
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 02:30:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DEF16140B
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 02:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DEF16140B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC1FC6F945;
	Fri,  4 Jun 2021 02:30:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NVE2aQmNaUBP; Fri,  4 Jun 2021 02:30:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id C81DB6F94B;
	Fri,  4 Jun 2021 02:30:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2CCFC000D;
	Fri,  4 Jun 2021 02:30:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62E35C0001
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 02:29:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4103540697
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 02:29:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LD8PL-3jhVGB for <iommu@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 02:29:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 68F0940698
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 02:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622773796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gt8hnOglaRtAhIBG091MfWOvOxMu+M8wqRg4Wjd74ow=;
 b=QnMTKsb1Pd2ABhZVIYGLDuTQIBYbja9rF4vDsQwsvj5KVip1HlqMVMOgDuTkDcBHzZPFBd
 M1igUcXdD5HBfOvPL7BvFXPcOB+fc7ecR+BsD2BGp2qdpyipjEU1StJa+Ta44lULVTe23r
 xRbQwPAaELyzLqQ4abhIiO/P/K8DYUU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-e2f2NiQLPBCGqlCr0gdeJg-1; Thu, 03 Jun 2021 22:29:54 -0400
X-MC-Unique: e2f2NiQLPBCGqlCr0gdeJg-1
Received: by mail-pj1-f69.google.com with SMTP id
 pf14-20020a17090b1d8eb029015c31e36747so4310061pjb.2
 for <iommu@lists.linux-foundation.org>; Thu, 03 Jun 2021 19:29:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=gt8hnOglaRtAhIBG091MfWOvOxMu+M8wqRg4Wjd74ow=;
 b=mCbVmoREJiFv84OeXWzNYaujwSB6POG71BVG7g91GJKdybnwwaToSz6Na+fIUtwqaD
 02EB7Xz9TEEPxKpk6hNLs1AWUnpLn+rp/dUQyV+4bJI2nEouUQubXzhRw8zccGu3SsVp
 M2e2rZaT2ixlW7eEN0xTdEXQ34VZ3FBIylZ9LAcYgiFEz2owlxyggjI067LiQd4FsztU
 Pz6V5YQHa5Lz6jNmuwI3pHXFUdfovDz0Vp8iJaHTQQz1BxYHJYTKkUIJlv/GpZoT5e9S
 t3WrB1yNQL1jusFFG9248kzimGBT64FvSQHaEvLD10pCtlUG3u6tQEc157vd3l/rXGId
 ZLow==
X-Gm-Message-State: AOAM5309OScrOHXzluZrejWjCwOHaV34WIuU70T9d2vkIfTwzcnMSth5
 mycPkPN27f8aasawJRFYGZpojn5Qvt+56PatDqSZJzbSSnBzmvFEFkfd+5t8hHSz9bcdmynJhp6
 EHxdVRZ+DA3z0+KkMo1KZDNJVbdHQeQ==
X-Received: by 2002:a17:90a:c20b:: with SMTP id
 e11mr14312028pjt.67.1622773793514; 
 Thu, 03 Jun 2021 19:29:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXfTmOi+wnH/roCuXQXvi+QWyoA9G2ErBsIgSWukz95apd75Y4VLg30EaPsmmCzT9f8zvJ3w==
X-Received: by 2002:a17:90a:c20b:: with SMTP id
 e11mr14312013pjt.67.1622773793313; 
 Thu, 03 Jun 2021 19:29:53 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id s11sm325912pfm.95.2021.06.03.19.29.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jun 2021 19:29:52 -0700 (PDT)
Subject: Re: [PATCH v1 1/8] virtio: Force only split mode with protected guest
To: Andi Kleen <ak@linux.intel.com>, mst@redhat.com
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-2-ak@linux.intel.com>
 <28c8302b-6833-10b4-c0eb-67456e7c4069@redhat.com>
 <09e17c7f-ce51-1a46-72c4-12223bee4e3a@linux.intel.com>
 <1c08bc42-7448-351e-78bf-fcf68d2b2561@redhat.com>
 <5a2d0d70-fa6b-f08d-f222-5c00cf5f9d44@linux.intel.com>
 <9b10bb24-eb27-510e-cf0d-7818ab9166ef@redhat.com>
 <9d6bc785-9613-a2e8-f78f-4547747a331d@linux.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <93f58cfd-be59-1ea6-e0d0-6840c14d6980@redhat.com>
Date: Fri, 4 Jun 2021 10:29:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <9d6bc785-9613-a2e8-f78f-4547747a331d@linux.intel.com>
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
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

CuWcqCAyMDIxLzYvMyDkuIvljYg5OjU1LCBBbmRpIEtsZWVuIOWGmemBkzoKPgo+PiBPaywgYnV0
IHdoYXQgSSBtZWFudCBpcyB0aGlzLCBpZiB3ZSBkb24ndCByZWFkIGZyb20gdGhlIGRlc2NyaXB0
b3IgCj4+IHJpbmcsIGFuZCB2YWxpZGF0ZSBhbGwgdGhlIG90aGVyIG1ldGFkYXRhIHN1cHBsaWVk
IGJ5IHRoZSBkZXZpY2UgCj4+ICh1c2VkIGlkIGFuZCBsZW4pLiBUaGVuIHRoZXJlIHNob3VsZCBi
ZSBubyB3YXkgZm9yIHRoZSBkZXZpY2UgdG8gCj4+IHN1cHByZXNzIHRoZSBkbWEgZmxhZ3MgdG8g
d3JpdGUgdG8gdGhlIGluZGlyZWN0IGRlc2NyaXB0b3IgdGFibGUuCj4+Cj4+IE9yIGRvIHlvdSBo
YXZlIGFuIGV4YW1wbGUgaG93IGl0IGNhbiBkbyB0aGF0Pwo+Cj4gSSBkb24ndC4gSWYgeW91IGNh
biB2YWxpZGF0ZSBldmVyeXRoaW5nIGl0J3MgcHJvYmFibHkgb2sKPgo+IFRoZSBvbmx5IGRyYXdi
YWNrIGlzIGV2ZW4gbW9yZSBjb2RlIHRvIGF1ZGl0IGFuZCB0ZXN0Lgo+Cj4gLUFuZGkKPgo+CgpP
aywgdGhlbiBJJ20gZ29pbmcgdG8gcG9zdCBhIGZvcm1hbCBzZXJpZXMsIHBsZWFzZSBoYXZlIGEg
bG9vayBhbmQgd2UgCmNhbiBzdGFydCBmcm9tIHRoZXJlLgoKVGhhbmtzCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9t
bXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
