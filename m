Return-Path: <SRS0=kThj=K4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBC3C4708F
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 08:58:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F3DE613D6
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 08:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F3DE613D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A4F1838C0;
	Wed,  2 Jun 2021 08:58:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ysnEx-l8RnuQ; Wed,  2 Jun 2021 08:58:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id E381E836A7;
	Wed,  2 Jun 2021 08:58:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C945BC000E;
	Wed,  2 Jun 2021 08:58:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 877A4C0001
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 08:58:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 758E5838C0
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 08:58:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cbjLP855LqSx for <iommu@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 08:58:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BD30C836A7
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 08:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622624303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HgwV7ft+Ln03MaD+qvV/AkL0B+iArPbUA9ahbhF+wVg=;
 b=QTSJnx4QZANKC2MFrXYT9euhRrVNbgeSmtWvBezvt4xanvqdTbszjudM7O+/7kwlZwQKhu
 ZfF8PrfdX554kqW/3QLQEGWVq+PdH4BWVXPGoqJuKJGvIJsqnmT4qzyfvpsZLuX2peDUEZ
 4Zr2KHhthRE/SX9KmS85ZL9S/H5qtHo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-MJ1yBlXlPNu0D5gJssRNzw-1; Wed, 02 Jun 2021 04:58:22 -0400
X-MC-Unique: MJ1yBlXlPNu0D5gJssRNzw-1
Received: by mail-pj1-f69.google.com with SMTP id
 j8-20020a17090a8408b02901651fe80217so1043227pjn.1
 for <iommu@lists.linux-foundation.org>; Wed, 02 Jun 2021 01:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=HgwV7ft+Ln03MaD+qvV/AkL0B+iArPbUA9ahbhF+wVg=;
 b=Z4M5RwWuHnS06LJnLL47czU2oaxWzIGmnfhyjOezihcSVeGMuA1GURVQwFhcQGtEFm
 420WVy/dLQgE2UkmLBNapRV/RQE65P4bik5+hlzCv3kW+97rDseDo4rZglV+79mJcJ+q
 8OUVlkpaGPmahokcH3TNxSSOfaOF634mt/gHrPIIja5dy74cN64dZRIAcOfgRA8NGYJw
 5swQIzWS1IdLJsshPeld29DDILjLtlempbC7gp+z4Eokx7GIr9S9Y6UkXPsm+1tO+34O
 7lTjNxXir774XuJ4a1/GvJd+y1XMURqVXsNTnY/68PHT76qExmm0OhRHmbcsscxORLn/
 aceg==
X-Gm-Message-State: AOAM532M/arcvpml6BJmWvdK9KNbT+ce2uM5QqbV6+vFb+76+VcISxsz
 d6TgqSesRQoKUdqOzYrz8NJnSyFCdzoAQQCu7mDCQ7ofUEy2R5fE5X60RyZsmUMfjLPsQgKwslb
 zfJPQ1kIfp35QzWco+f4+A2/ZVm1DvQ==
X-Received: by 2002:a63:e642:: with SMTP id p2mr31912921pgj.316.1622624301197; 
 Wed, 02 Jun 2021 01:58:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/hC2DUGaHASQJ2eBIgS4POmbF/OU0iTy4EElTI9I8lf554Diw4PoXXYk+RPG+3MuIoH1a7g==
X-Received: by 2002:a63:e642:: with SMTP id p2mr31912901pgj.316.1622624301050; 
 Wed, 02 Jun 2021 01:58:21 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id m134sm4163818pfd.148.2021.06.02.01.58.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jun 2021 01:58:20 -0700 (PDT)
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To: Jason Gunthorpe <jgg@nvidia.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <f510f916-e91c-236d-e938-513a5992d3b5@redhat.com>
 <20210531164118.265789ee@yiliu-dev>
 <78ee2638-1a03-fcc8-50a5-81040f677e69@redhat.com>
 <20210601113152.6d09e47b@yiliu-dev>
 <164ee532-17b0-e180-81d3-12d49b82ac9f@redhat.com>
 <64898584-a482-e6ac-fd71-23549368c508@linux.intel.com>
 <429d9c2f-3597-eb29-7764-fad3ec9a934f@redhat.com>
 <MWHPR11MB1886FC7A46837588254794048C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <05d7f790-870d-5551-1ced-86926a0aa1a6@redhat.com>
 <20210601172956.GL1002214@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d8bb795f-8d73-e9a5-a4b1-8d9c563dffbd@redhat.com>
Date: Wed, 2 Jun 2021 16:58:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210601172956.GL1002214@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Alex Williamson \(alex.williamson@redhat.com\)\"\""
 <alex.williamson@redhat.com>, David Woodhouse <dwmw2@infradead.org>
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

CtTaIDIwMjEvNi8yIMnPzucxOjI5LCBKYXNvbiBHdW50aG9ycGUg0LS1wDoKPiBPbiBUdWUsIEp1
biAwMSwgMjAyMSBhdCAwMjowNzowNVBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+Cj4+IEZv
ciB0aGUgY2FzZSBvZiAxTSwgSSB3b3VsZCBsaWtlIHRvIGtub3cgd2hhdCdzIHRoZSB1c2UgY2Fz
ZSBmb3IgYSBzaW5nbGUKPj4gcHJvY2VzcyB0byBoYW5kbGUgMU0rIGFkZHJlc3Mgc3BhY2VzPwo+
IEZvciBzb21lIHNjZW5hcmlvcyBldmVyeSBndWVzdCBQQVNJRCB3aWxsIHJlcXVpcmUgYSBJT0FT
SUQgSUQgIyBzbwo+IHRoZXJlIGlzIGEgbGFyZ2UgZW5vdWdoIGRlbWFuZCB0aGF0IEZEcyBhbG9u
ZSBhcmUgbm90IGEgZ29vZCBmaXQuCj4KPiBGdXJ0aGVyIHRoZXJlIGFyZSBnbG9iYWwgY29udGFp
bmVyIHdpZGUgcHJvcGVydGllcyB0aGF0IGFyZSBoYXJkIHRvCj4gY2Fycnkgb3ZlciB0byBhIG11
bHRpLUZEIG1vZGVsLCBsaWtlIHRoZSBhdHRhY2htZW50IG9mIGRldmljZXMgdG8gdGhlCj4gY29u
dGFpbmVyIGF0IHRoZSBzdGFydHVwLgoKClNvIGlmIHdlIGltcGxlbWVudCBwZXIgZmQgbW9kZWwu
IFRoZSBnbG9iYWwgImNvbnRhaW5lciIgcHJvcGVydGllcyBjb3VsZCAKYmUgZG9uZSB2aWEgdGhl
IHBhcmVudCBmZC4gRS5nIGF0dGFjaGluZyB0aGUgcGFyZW50IHRvIHRoZSBkZXZpY2UgYXQgdGhl
IApzdGFydHVwLgoKCj4KPj4+IFNvIHRoaXMgUkZDIHRyZWF0cyBmZCBhcyBhIGNvbnRhaW5lciBv
ZiBhZGRyZXNzIHNwYWNlcyB3aGljaCBpcyBlYWNoCj4+PiB0YWdnZWQgYnkgYW4gSU9BU0lELgo+
PiBJZiB0aGUgY29udGFpbmVyIGFuZCBhZGRyZXNzIHNwYWNlIGlzIDE6MSB0aGVuIHRoZSBjb250
YWluZXIgc2VlbXMgdXNlbGVzcy4KPiBUaGUgZXhhbXBsZXMgYXQgdGhlIGJvdHRvbSBvZiB0aGUg
ZG9jdW1lbnQgc2hvdyBtdWx0aXBsZSBJT0FTSURzIGluCj4gdGhlIGNvbnRhaW5lciBmb3IgYSBw
YXJlbnQvY2hpbGQgdHlwZSByZWxhdGlvbnNoaXAKCgpUaGlzIGNhbiBhbHNvIGJlIGRvbmUgcGVy
IGZkPyBBIGZkIHBhcmVudCBjYW4gaGF2ZSBtdWx0aXBsZSBmZCBjaGlsZHMuCgpUaGFua3MKCgo+
Cj4gSmFzb24KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
