Return-Path: <SRS0=Vfdp=LE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF869C47094
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 04:04:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 895DA60232
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 04:04:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 895DA60232
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 57642606DE;
	Thu, 10 Jun 2021 04:04:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y0fAbV7IelsH; Thu, 10 Jun 2021 04:04:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 472B2606D4;
	Thu, 10 Jun 2021 04:04:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20DC0C000E;
	Thu, 10 Jun 2021 04:04:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49FA4C000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 04:04:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2B4894058B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 04:04:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pmKDOUl_9EOf for <iommu@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 04:04:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4C2D040530
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 04:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623297840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=19S4V0oFIhYTEmjCi3wnOG6CCDqJn4GFX2fH4afLaKA=;
 b=P7OmA0kTxagkieW5Zt9yOQsoDKq2Z7bhg5HmpZgCxhtJrbAUVNhPnWQW7B191ray7uxKQe
 beb6aY6du44gIJYFxQhHUZ5vfTCfUqLVD15758itaL+pC7RBkk6w3raxyo8QzX+njunR4c
 1z1O/m3kt/hGBCIp37wpyKO1128d2ls=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-P0LLnt7fNu6IsTwQTaAR3Q-1; Thu, 10 Jun 2021 00:03:58 -0400
X-MC-Unique: P0LLnt7fNu6IsTwQTaAR3Q-1
Received: by mail-pg1-f199.google.com with SMTP id
 4-20020a6317440000b029021689797ccaso15573559pgx.4
 for <iommu@lists.linux-foundation.org>; Wed, 09 Jun 2021 21:03:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=19S4V0oFIhYTEmjCi3wnOG6CCDqJn4GFX2fH4afLaKA=;
 b=gbqJ14rfXMcOBNcJKoR+O3BL2CrH/oFnjSIZnVnOXMJmksH79Rl6bcgl65zFwtxFhU
 5JYnlgKFgBgvn+jW8HkVq5VNplzrOpE6zQdo4MR7Emz82YreOmBR6OnXpDUOvU2ywoAQ
 5CQXJ2OlVqc8JqDU6/SCoU3HFhWLNSlQonU2Dcue7fmWvvsr7FYZHoRCDw41zIbdCD1u
 IhzySsPi0Io6Bs0GRFHIkK2zp8866/9dqyHQCLTWvUcYajAE4Y0Fe+RXA0rfaTuNNZMj
 01DKD7RQ1FyOthhGkFYJ5gMovShy7TICGO0PNgsU4KkkMDDiYDu8Km0aVgW0rMFZvjJ3
 OBsg==
X-Gm-Message-State: AOAM5319l9AuIS22JBUTehUYSbd50xQihqSfKp4ibX8LSPeOm+Qtipsw
 l9Vfq0B7WBpuf6U1jhAcLthrNSmyNCUYI30+ps2lR4hKFDoMGLzDLX1wAmmDA9dw6aCqSccO9nI
 PbetXQAnVcnew37fwj431NvCuZDuW8w==
X-Received: by 2002:a63:3fc6:: with SMTP id m189mr2985877pga.239.1623297837853; 
 Wed, 09 Jun 2021 21:03:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVMH4GRlTNZgCb4SGiAzZbg0vm86YmdxLIXUVjkXzrgfxl13LW9u+XyYW03LglmHfkfEaonA==
X-Received: by 2002:a63:3fc6:: with SMTP id m189mr2985870pga.239.1623297837705; 
 Wed, 09 Jun 2021 21:03:57 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id j16sm1136234pgh.69.2021.06.09.21.03.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jun 2021 21:03:57 -0700 (PDT)
Subject: Re: [RFC] /dev/ioasid uAPI proposal
From: Jason Wang <jasowang@redhat.com>
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
 <f4d70f28-4bd6-5315-d7c7-0a509e4f1d1d@redhat.com>
Message-ID: <3af22408-f0f1-7e04-48ab-852619d28ef6@redhat.com>
Date: Thu, 10 Jun 2021 12:03:52 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f4d70f28-4bd6-5315-d7c7-0a509e4f1d1d@redhat.com>
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

CtTaIDIwMjEvNi8xMCDJz87nMTA6MDAsIEphc29uIFdhbmcg0LS1wDoKPgo+INTaIDIwMjEvNi84
IM/Czuc5OjIwLCBKYXNvbiBHdW50aG9ycGUg0LS1wDoKPj4gT24gVHVlLCBKdW4gMDgsIDIwMjEg
YXQgMDk6MTA6NDJBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4KPj4+IFdlbGwsIHRoaXMg
c291bmRzIGxpa2UgYSByZS1pbnZlbnRpb24gb2YgaW9fdXJpbmcgd2hpY2ggaGFzIGFscmVhZHkg
Cj4+PiB3b3JrZWQKPj4+IGZvciBtdWx0aWZkcy4KPj4gSG93IHNvPyBpb191cmluZyBpcyBhYm91
dCBzZW5kaW5nIHdvcmsgdG8gdGhlIGtlcm5lbCwgbm90IGdldHRpbmcKPj4gc3RydWN0dWVkIGV2
ZW50cyBiYWNrPwo+Cj4KPiBBY3R1YWxseSBpdCBjYW4uIFVzZXJzcGFjZSBjYW4gcG9sbCBtdWx0
aXBsZSBmZHMgdmlhIHByZXBhcmluZyAKPiBtdWx0aXBsZSBzcWVzIHdpdGggSU9SSU5HX09QX0FE
RCBmbGFnLgoKCklPUklOR19PUF9QT0xMX0FERCBhY3R1YWxseS4KClRoYW5rcwoKCj4KPgo+Pgo+
PiBJdCBpcyBtb3JlIGxpa2Ugb25lIG9mIHRoZSBwZXJmIHJpbmdzCj4KPgo+IFRoaXMgbWVhbnMg
YW5vdGhlciByaW5nIGFuZCB3ZSBuZWVkIGludHJvZHVjZSBpb2N0bCgpIHRvIGFkZCBvciByZW1v
dmUgCj4gaW9hc2lkcyBmcm9tIHRoZSBwb2xsLiBBbmQgaXQgc3RpbGwgbmVlZCBhIGtpbmQgb2Yg
ZmFsbGJhY2sgbGlrZSBhIAo+IGxpc3QgaWYgdGhlIHJpbmcgaXMgZnVsbC4KPgo+IFRoYW5rcwo+
Cj4KPj4KPj4gSmFzb24KPj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9p
b21tdQ==
