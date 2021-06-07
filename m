Return-Path: <SRS0=ynGH=LB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA012C4743E
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 03:18:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C8F76120D
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 03:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C8F76120D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 404C86077B;
	Mon,  7 Jun 2021 03:18:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1GiFx8Gi6Wym; Mon,  7 Jun 2021 03:18:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 35C6D6059C;
	Mon,  7 Jun 2021 03:18:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B5FAC000D;
	Mon,  7 Jun 2021 03:18:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2280EC0001
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 03:18:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F0BAC401E5
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 03:18:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EjcTYHdpu58q for <iommu@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 03:18:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7F847401D6
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 03:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623035927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ABnq2QuOpr7byvnRGusIkVvj+20PbgeaIPvM27YKhg4=;
 b=RlKy0mFJ0ws+WM7PDzzTfJL6uoHfrb8JWP7zB0M1mqRjLah1NBPS6E5vvgrZ6pukUb57V2
 sjgfj6Heb0tdkel15MrUFruxvHAv6TtMogUr/Z7vC3Go+MwbKexowH0YIeIKw7ufH+FFTy
 0bRH4DaMKFvvftxyT4Og4LL0FRJmE+w=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-42zt502UPjOMQhmPgSwS6w-1; Sun, 06 Jun 2021 23:18:43 -0400
X-MC-Unique: 42zt502UPjOMQhmPgSwS6w-1
Received: by mail-pg1-f197.google.com with SMTP id
 x188-20020a6363c50000b02902104a07607cso4031039pgb.1
 for <iommu@lists.linux-foundation.org>; Sun, 06 Jun 2021 20:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=ABnq2QuOpr7byvnRGusIkVvj+20PbgeaIPvM27YKhg4=;
 b=D/i47/NeXE18nqs4Gnty8gCIqXf+PFCgBBehsB+msYMp4izpQrXeyMCmVeOpoVT4qT
 e6UQXHKDEX21+v1CqHxX1zv9gxYuIlwE74X8v/3dlZ8gEM5hijhuYTQ+wIaRRbuoCT4j
 kO0lJqz38nRQbIcPR45RcbFVdSgl03GSaOT8lGQ69A9yJb9x+UlmezpPrjsYxuoUir6+
 qafi+6VGXlK4mJxXa5GJAWm0ca7oFnZN82gFtcxFC/heYTOpczRQOj5ezl5wrUxkbhpR
 OjDn7fiixFaGpj1/t4eXHnAD1pzN0+m4+14evB3j3oSYWHybkXyMRKPwBpRseQlrERIQ
 L9Nw==
X-Gm-Message-State: AOAM533L4y0vbzHXspu5GidI6Ey+Qmni+mp7MjDkubCgVAZfC7AWAv84
 obg8LCEJ4+1rNen+3qtqXEduqFb+rA9+L5gsInCzKeaOiwi+tRlVaXnX1e7kFV/yV7pGQuPtPsC
 nn1U36JRgg7GriK2TSyOjmcz5shrphg==
X-Received: by 2002:a17:90a:390d:: with SMTP id
 y13mr18291786pjb.52.1623035922898; 
 Sun, 06 Jun 2021 20:18:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxyhCGMAJgmD0wCDBmip4ixPdmhcn5mWCmYZELjB4tRm0TDYopxIzBxkopd2Rpl9Ugu+p2EA==
X-Received: by 2002:a17:90a:390d:: with SMTP id
 y13mr18291758pjb.52.1623035922656; 
 Sun, 06 Jun 2021 20:18:42 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id w10sm6719572pfg.196.2021.06.06.20.18.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Jun 2021 20:18:42 -0700 (PDT)
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20210602111117.026d4a26.alex.williamson@redhat.com>
 <20210602173510.GE1002214@nvidia.com>
 <20210602120111.5e5bcf93.alex.williamson@redhat.com>
 <20210602180925.GH1002214@nvidia.com>
 <20210602130053.615db578.alex.williamson@redhat.com>
 <20210602195404.GI1002214@nvidia.com>
 <20210602143734.72fb4fa4.alex.williamson@redhat.com>
 <6a9426d7-ed55-e006-9c4c-6b7c78142e39@redhat.com>
 <20210603130927.GZ1002214@nvidia.com>
 <65614634-1db4-7119-1a90-64ba5c6e9042@redhat.com>
 <20210604115805.GG1002214@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <895671cc-5ef8-bc1a-734c-e9e2fdf03652@redhat.com>
Date: Mon, 7 Jun 2021 11:18:33 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210604115805.GG1002214@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
 David Gibson <david@gibson.dropbear.id.au>
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

CtTaIDIwMjEvNi80IM/Czuc3OjU4LCBKYXNvbiBHdW50aG9ycGUg0LS1wDoKPiBPbiBGcmksIEp1
biAwNCwgMjAyMSBhdCAwOToxMTowM0FNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4gbm9y
IGRvIGFueSB2aXJ0aW8gZHJpdmVycyBpbXBsZW1lbnQgdGhlIHJlcXVpcmVkIHBsYXRmb3JtIHNw
ZWNpZmljCj4+PiBjYWNoZSBmbHVzaGluZyB0byBtYWtlIG5vLXNub29wIFRMUHMgd29yay4KPj4g
SSBkb24ndCBnZXQgd2h5IHZpcnRpbyBkcml2ZXJzIG5lZWRzIHRvIGRvIHRoYXQuIEkgdGhpbmsg
RE1BIEFQSSBzaG91bGQgaGlkZQo+PiB0aG9zZSBhcmNoL3BsYXRmb3JtIHNwZWNpZmljIHN0dWZm
cyBmcm9tIHVzLgo+IEl0IGlzIG5vdCBhcmNoL3BsYXRmb3JtIHN0dWZmLiBJZiB0aGUgZGV2aWNl
IHVzZXMgbm8tc25vb3AgdGhlbiBhCj4gdmVyeSBwbGF0Zm9ybSBzcGVjaWZpYyByZWNvdmVyeSBp
cyByZXF1aXJlZCBpbiB0aGUgZGV2aWNlIGRyaXZlci4KPgo+IEl0IGlzIG5vdCBwYXJ0IG9mIHRo
ZSBub3JtYWwgRE1BIEFQSSwgaXQgaXMgc2lkZSBBUElzIGxpa2UKPiBmbHVzaF9hZ3BfY2FjaGUo
KSBvciB3YmludmQoKSB0aGF0IGFyZSB1c2VkIGJ5IEdQVSBkcml2ZXJzIG9ubHkuCgoKWWVzIGFu
ZCB2aXJ0aW8gZG9lc24ndCBzdXBwb3J0IEFHUC4KCgo+Cj4gSWYgZHJpdmVycy92aXJ0aW8gZG9l
c24ndCBleHBsaWNpdGx5IGNhbGwgdGhlc2UgdGhpbmdzIGl0IGRvZXNuJ3QKPiBzdXBwb3J0IG5v
LXNub29wIC0gaGVuY2Ugbm8gVkRQQSBkZXZpY2UgY2FuIGV2ZXIgdXNlIG5vLXNub29wLgoKCk5v
dGUgdGhhdCBubyBkcml2ZXJzIGNhbGwgdGhlc2UgdGhpbmdzIGRvZXNuJ3QgbWVhbnQgaXQgd2Fz
IG5vdCAKc3VwcG9ydGVkIGJ5IHRoZSBzcGVjLgoKQWN0dWFsbHksIHNwZWMgZG9lc24ndCBmb3Ji
aWQgdGhlIG5vbiBjb2hlcmVudCBETUEsIGFueXdheSB3ZSBjYW4gcmFpc2UgCmEgbmV3IHRocmVh
ZCBpbiB0aGUgdmlydGlvIG1haWxpbmcgbGlzdCB0byBkaXNjdXNzIGFib3V0IHRoYXQuCgpCdXQg
Y29uc2lkZXIgdmlydGlvIGhhcyBhbHJlYWR5IHN1cHBvcnRlZCBHUFUsIGNyeXB0byBhbmQgc291
bmQgZGV2aWNlLCAKYW5kIHRoZSBkZXZpY2VzIGxpa2UgY29kZWMgYW5kIHZpZGVvIGFyZSBiZWlu
ZyBwcm9wb3NlZC4gSXQgZG9lc24ndCBoZWxwIAppZiB3ZSBtYW5kYXRlIGNvaGVyZW50IERNQSBu
b3cuCgpUaGFua3MKCgo+Cj4gU2luY2UgVklSVElPX0ZfQUNDRVNTX1BMQVRGT1JNIGRvZXNuJ3Qg
dHJpZ2dlciB3YmludmQgb24geDg2IGl0IGhhcwo+IG5vdGhpbmcgdG8gZG8gd2l0aCBuby1zbm9v
cC4KPgo+IEphc29uCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21t
dQ==
