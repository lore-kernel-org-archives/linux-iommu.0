Return-Path: <SRS0=bugC=HJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053C7C433DB
	for <iommu@archiver.kernel.org>; Sun,  7 Feb 2021 22:30:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C3BE64E2E
	for <iommu@archiver.kernel.org>; Sun,  7 Feb 2021 22:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C3BE64E2E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 20CD620387;
	Sun,  7 Feb 2021 22:30:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tk8udhQLDQSn; Sun,  7 Feb 2021 22:30:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 38AA42001E;
	Sun,  7 Feb 2021 22:30:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D068C0174;
	Sun,  7 Feb 2021 22:30:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2B80C013A
 for <iommu@lists.linux-foundation.org>; Sun,  7 Feb 2021 22:30:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D973586864
 for <iommu@lists.linux-foundation.org>; Sun,  7 Feb 2021 22:30:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cIcZO1OydmAY for <iommu@lists.linux-foundation.org>;
 Sun,  7 Feb 2021 22:30:32 +0000 (UTC)
X-Greylist: delayed 00:19:45 by SQLgrey-1.7.6
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com
 [209.85.167.178])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E90C48667B
 for <iommu@lists.linux-foundation.org>; Sun,  7 Feb 2021 22:30:31 +0000 (UTC)
Received: by mail-oi1-f178.google.com with SMTP id v193so8356742oie.8
 for <iommu@lists.linux-foundation.org>; Sun, 07 Feb 2021 14:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amacapital-net.20150623.gappssmtp.com; s=20150623;
 h=content-transfer-encoding:from:mime-version:subject:date:message-id
 :references:cc:in-reply-to:to;
 bh=rF9rOEV9Q8WVIOH0rqIWO7EqANQSyBnp1ft+vyl9KF0=;
 b=QANXs0Ex159+byJKUEaE28kl3Xh1NJ9WQlAArBMiqR/LE0uHG9IpHhfqWrVmJbho7R
 zP1u0EqWhELbEmtTGccuSGqB1fhJqbp8L6ZAFLx9BsWQEpn7+9fUeq7ZlknoiHHfRYsV
 yCiSNhT/oz/MSrVIf+6C3avuFCznOmT2MIzTiHTudXkJ3md/uaNKYTp7OcY+zyFWUdx3
 t2hI93ykFPrRg/ziGbbX6FfZAddsJEzERu6Jadvk5KI3v/9ZrpWsV/zrUDO5Y59dlxde
 zHUljpHpBinHt9TpnJyq7p6CZXtVOCBYq6uXD8Si3ujOPNxK8fpJ1Q0naopg0iRuSxBm
 +jGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=rF9rOEV9Q8WVIOH0rqIWO7EqANQSyBnp1ft+vyl9KF0=;
 b=NGtcV3e3N30kykch2YjJLwmaUTHbR5T6bOooIYikKh9nSKeopH6lpE5jNMquQgzKRO
 sMW5gVwU/J3cDh2Aul9MoxqRJvOqSpNlRpopNzIhYEyLDZudD8G/qaZABPryggwwFxkL
 M5JUebVhmNXLua88bPhs0ylyxMZPYwtVSKq2fZsT8JGXJmEL127DMDfC1AkEoV/rb9zr
 LleMnN6V+sNVxRAxfkGAx9flVgXYCvopFAeK72E3WrH3PvjoH+ZWjmRZC3ulau1q3vgT
 y60Kk6KOmQecsB7MsMlGqHqOK2PtDKXQU4VNsdedZHRe1WwzOfctBozTSj8Ag/UTuDXT
 TKeQ==
X-Gm-Message-State: AOAM530XeB57jIx5syPDbHtOCeucEAaM6vhDoQqdZ8+EiyqIdJLfADGP
 kN+RDJBEh1+CndHJbnM18HLUQRhuv7PrzS+T
X-Google-Smtp-Source: ABdhPJzNR1bzv/JQhWJTt0CBbMKbJVt9xR9k8FE58XkDiaugfM9e0sPAPw9t+dZ9eAqufWWfnMqn+g==
X-Received: by 2002:a17:90a:184:: with SMTP id 4mr13919868pjc.87.1612735358046; 
 Sun, 07 Feb 2021 14:02:38 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:8e8:e217:43e7:e032?
 ([2601:646:c200:1ef2:8e8:e217:43e7:e032])
 by smtp.gmail.com with ESMTPSA id i25sm16435713pgb.33.2021.02.07.14.02.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Feb 2021 14:02:37 -0800 (PST)
From: Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory pin
Date: Sun, 7 Feb 2021 14:02:36 -0800
Message-Id: <ED58431F-5972-47D1-BF50-93A20AD86C46@amacapital.net>
References: <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
In-Reply-To: <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
To: Zhou Wang <wangzhou1@hisilicon.com>
X-Mailer: iPhone Mail (18D52)
Cc: jean-philippe@linaro.org, kevin.tian@intel.com,
 Sihang Chen <chensihang1@hisilicon.com>, jgg@ziepe.ca,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 gregkh@linuxfoundation.org, zhangfei.gao@linaro.org,
 Andrew Morton <akpm@linux-foundation.org>, liguozhu@hisilicon.com,
 linux-arm-kernel@lists.infradead.org
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

Cgo+IE9uIEZlYiA3LCAyMDIxLCBhdCAxMjozMSBBTSwgWmhvdSBXYW5nIDx3YW5nemhvdTFAaGlz
aWxpY29uLmNvbT4gd3JvdGU6Cj4gCj4g77u/U1ZBKHNoYXJlIHZpcnR1YWwgYWRkcmVzcykgb2Zm
ZXJzIGEgd2F5IGZvciBkZXZpY2UgdG8gc2hhcmUgcHJvY2VzcyB2aXJ0dWFsCj4gYWRkcmVzcyBz
cGFjZSBzYWZlbHksIHdoaWNoIG1ha2VzIG1vcmUgY29udmVuaWVudCBmb3IgdXNlciBzcGFjZSBk
ZXZpY2UKPiBkcml2ZXIgY29kaW5nLiBIb3dldmVyLCBJTyBwYWdlIGZhdWx0cyBtYXkgaGFwcGVu
IHdoZW4gZG9pbmcgRE1BCj4gb3BlcmF0aW9ucy4gQXMgdGhlIGxhdGVuY3kgb2YgSU8gcGFnZSBm
YXVsdCBpcyByZWxhdGl2ZWx5IGJpZywgRE1BCj4gcGVyZm9ybWFuY2Ugd2lsbCBiZSBhZmZlY3Rl
ZCBzZXZlcmVseSB3aGVuIHRoZXJlIGFyZSBJTyBwYWdlIGZhdWx0cy4KPiBGcm9tIGEgbG9uZyB0
ZXJtIHZpZXcsIERNQSBwZXJmb3JtYW5jZSB3aWxsIGJlIG5vdCBzdGFibGUuCj4gCj4gSW4gaGln
aC1wZXJmb3JtYW5jZSBJL08gY2FzZXMsIGFjY2VsZXJhdG9ycyBtaWdodCB3YW50IHRvIHBlcmZv
cm0KPiBJL08gb24gYSBtZW1vcnkgd2l0aG91dCBJTyBwYWdlIGZhdWx0cyB3aGljaCBjYW4gcmVz
dWx0IGluIGRyYW1hdGljYWxseQo+IGluY3JlYXNlZCBsYXRlbmN5LiBDdXJyZW50IG1lbW9yeSBy
ZWxhdGVkIEFQSXMgY291bGQgbm90IGFjaGlldmUgdGhpcwo+IHJlcXVpcmVtZW50LCBlLmcuIG1s
b2NrIGNhbiBvbmx5IGF2b2lkIG1lbW9yeSB0byBzd2FwIHRvIGJhY2t1cCBkZXZpY2UsCj4gcGFn
ZSBtaWdyYXRpb24gY2FuIHN0aWxsIHRyaWdnZXIgSU8gcGFnZSBmYXVsdC4KPiAKPiBWYXJpb3Vz
IGRyaXZlcnMgd29ya2luZyB1bmRlciB0cmFkaXRpb25hbCBub24tU1ZBIG1vZGUgYXJlIHVzaW5n
Cj4gdGhlaXIgb3duIHNwZWNpZmljIGlvY3RsIHRvIGRvIHBpbi4gU3VjaCBpb2N0bCBjYW4gYmUg
c2VlbiBpbiB2NGwyLAo+IGdwdSwgaW5maW5pYmFuZCwgbWVkaWEsIHZmaW8sIGV0Yy4gRHJpdmVy
cyBhcmUgdXN1YWxseSBkb2luZyBkbWEKPiBtYXBwaW5nIHdoaWxlIGRvaW5nIHBpbi4KPiAKPiBC
dXQsIGluIFNWQSBtb2RlLCBwaW4gY291bGQgYmUgYSBjb21tb24gbmVlZCB3aGljaCBpc24ndCBu
ZWNlc3NhcmlseQo+IGJvdW5kIHdpdGggYW55IGRyaXZlcnMsIGFuZCBuZWl0aGVyIGlzIGRtYSBt
YXBwaW5nIG5lZWRlZCBieSBkcml2ZXJzCj4gc2luY2UgZGV2aWNlcyBhcmUgdXNpbmcgdGhlIHZp
cnR1YWwgYWRkcmVzcyBvZiBDUFUuIFRodXMsIEl0IGlzIGJldHRlcgo+IHRvIGludHJvZHVjZSBh
IG5ldyBjb21tb24gc3lzY2FsbCBmb3IgaXQuCj4gCj4gVGhpcyBwYXRjaCBsZXZlcmFnZXMgdGhl
IGRlc2lnbiBvZiB1c2VyZmF1bHRmZCBhbmQgYWRkcyBtZW1waW5mZCBmb3IgcGluCj4gdG8gYXZv
aWQgbWVzc2luZyB1cCBtbV9zdHJ1Y3QuIEEgZmQgd2lsbCBiZSBnb3QgYnkgbWVtcGluZmQsIHRo
ZW4gdXNlcgo+IHNwYWNlIGNhbiBkbyBwaW4vdW5waW4gcGFnZXMgYnkgaW9jdGxzIG9mIHRoaXMg
ZmQsIGFsbCBwaW5uZWQgcGFnZXMgdW5kZXIKPiBvbmUgZmlsZSB3aWxsIGJlIHVucGlubmVkIGlu
IGZpbGUgcmVsZWFzZSBwcm9jZXNzLiBMaWtlIHBpbiBwYWdlIGNhc2VzIGluCj4gb3RoZXIgcGxh
Y2VzLCBjYW5fZG9fbWxvY2sgaXMgdXNlZCB0byBjaGVjayBwZXJtaXNzaW9uIGFuZCBpbnB1dAo+
IHBhcmFtZXRlcnMuCgoKQ2FuIHlvdSBkb2N1bWVudCB3aGF0IHRoZSBzeXNjYWxsIGRvZXM/CgpV
c2VyZmF1bHRmZCBpcyBhbiBmZCBiZWNhdXNlIG9uZSBwcm9ncmFtIGNvbnRyb2xzIGFub3RoZXIu
ICBJcyBtZW1waW5mZCBsaWtlIHRoaXM/Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby9pb21tdQ==
