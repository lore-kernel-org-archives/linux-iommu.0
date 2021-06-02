Return-Path: <SRS0=kThj=K4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF692C47092
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 08:54:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F057613D7
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 08:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F057613D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6706E40250;
	Wed,  2 Jun 2021 08:54:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z1mFes15kw0b; Wed,  2 Jun 2021 08:54:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id AAF8A401C8;
	Wed,  2 Jun 2021 08:54:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D13BC000E;
	Wed,  2 Jun 2021 08:54:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D3EAC0001
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 08:54:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6B12E401FA
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 08:54:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ICNI0TOhWm02 for <iommu@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 08:54:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8DD4B401D2
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 08:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622624074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TOI6E9j/kLUqqLzfWVG9w8giJlysUj5C+KWef8bCQ8I=;
 b=iey3U79HA+VvTZDpvn1WzZuVy5l3v5TtkaaFIzHe2il5HHOOGPHzbDXGtiQDNBsOFN19sO
 mNTCWKrpE+y6XmGPFu41oA/AWk/aqGo8VO6vkp0q+3NJdCwM6Iezl+7WPJ+YfRIsxQXClb
 E0mOrFzHtGAgKY6sPrOW8RlG6yeWu6k=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-kles00gNOkikS-vfHWI6sQ-1; Wed, 02 Jun 2021 04:54:33 -0400
X-MC-Unique: kles00gNOkikS-vfHWI6sQ-1
Received: by mail-pj1-f71.google.com with SMTP id
 a11-20020a17090a70cbb029015d3e996884so3025773pjm.4
 for <iommu@lists.linux-foundation.org>; Wed, 02 Jun 2021 01:54:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=TOI6E9j/kLUqqLzfWVG9w8giJlysUj5C+KWef8bCQ8I=;
 b=d4TEjMV5IqUD1xL0zhxkBJWx5tiqfP9zbMwiuzQhy98+LLDJQ8f1mUsJJtzXWhi3t4
 HQXv6KRiNPe/mJlunijsWqfvi7rhLY0j/l25vcOYmI3qSABYAk7pC0tvol1HyCdie1P4
 FSO0ZvozA3L252CVnm5lrprDGc7PsO8F99Uz1wlLzAjPNQXtsdxb+2ypNkZfhPV6C8ch
 17n5GmfgBHyCdHQsobCmM0muE8LJa5w/s4HIN0jgXYgZ98vk7xiWuigJw77t30R32Im9
 TpUFCWc8700PRT0QrQlco6JzdlBfOAF6KUoi+b4Ss2eeS0oyClD5Mr6qsD7GuPk3tfU9
 6MCQ==
X-Gm-Message-State: AOAM533w9lL8QJXIPklAEjPb5J9PsXcoCuyAx8XqGQN9YsQf5c2FEUMC
 dgoaY/tmCuEStyjuWUSebjeqbzUA3rCugvS6JU5DLvNPD/qjWSQIgKQd4uEYI8rjhdDwSJgHHb9
 r58XD5I8Drte+tsYghzAncy9BCCf4zg==
X-Received: by 2002:a17:90a:7306:: with SMTP id
 m6mr4486583pjk.217.1622624072029; 
 Wed, 02 Jun 2021 01:54:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQ9jinHicYAMXd7FQEuh3El0Ofh9v6RECp7TK6Os2FVDpLb1bDFUCefzQjoGn2stvAL6/t8g==
X-Received: by 2002:a17:90a:7306:: with SMTP id
 m6mr4486565pjk.217.1622624071836; 
 Wed, 02 Jun 2021 01:54:31 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id w2sm4060045pfc.126.2021.06.02.01.54.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jun 2021 01:54:31 -0700 (PDT)
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20210531164118.265789ee@yiliu-dev>
 <78ee2638-1a03-fcc8-50a5-81040f677e69@redhat.com>
 <20210601113152.6d09e47b@yiliu-dev>
 <164ee532-17b0-e180-81d3-12d49b82ac9f@redhat.com>
 <64898584-a482-e6ac-fd71-23549368c508@linux.intel.com>
 <429d9c2f-3597-eb29-7764-fad3ec9a934f@redhat.com>
 <MWHPR11MB1886FC7A46837588254794048C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <05d7f790-870d-5551-1ced-86926a0aa1a6@redhat.com>
 <MWHPR11MB1886269E2B3DE471F1A9A7618C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <42a71462-1abc-0404-156c-60a7ee1ad333@redhat.com>
 <20210601173138.GM1002214@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f69137e3-0f60-4f73-a0ff-8e57c79675d5@redhat.com>
Date: Wed, 2 Jun 2021 16:54:26 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210601173138.GM1002214@nvidia.com>
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

CtTaIDIwMjEvNi8yIMnPzucxOjMxLCBKYXNvbiBHdW50aG9ycGUg0LS1wDoKPiBPbiBUdWUsIEp1
biAwMSwgMjAyMSBhdCAwNDo0NzoxNVBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ICAgCj4+
IFdlIGNhbiBvcGVuIHVwIHRvIH4wVSBmaWxlIGRlc2NyaXB0b3JzLCBJIGRvbid0IHNlZSB3aHkg
d2UgbmVlZCB0byByZXN0cmljdAo+PiBpdCBpbiB1QVBJLgo+IFRoZXJlIGFyZSBzaWduaWZpY2Fu
dCBwcm9ibGVtcyB3aXRoIHN1Y2ggbGFyZ2UgZmlsZSBkZXNjcmlwdG9yCj4gdGFibGVzLiBIaWdo
IEZEIG51bWJlcnMgbWFuIHRoaW5ncyBsaWtlIHNlbGVjdCBkb24ndCB3b3JrIGF0IGFsbAo+IGFu
eW1vcmUgYW5kIElJUkMgdGhlcmUgYXJlIG1vcmUgY29tcGxpY2F0aW9ucy4KCgpJIGRvbid0IHNl
ZSBob3cgbXVjaCBkaWZmZXJlbmNlIGZvciBJT0FTSUQgYW5kIG90aGVyIHR5cGUgb2YgZmRzLiBQ
ZW9wbGUgCmNhbiBjaG9vc2UgdG8gdXNlIHBvbGwgb3IgZXBvbGwuCgpBbmQgd2l0aCB0aGUgY3Vy
cmVudCBwcm9wb3NhbCwgKGFzc3VtaW5nIHRoZXJlJ3MgYSBOOjEgaW9hc2lkIHRvIAppb2FzaWQp
LiBJIHdvbmRlciBob3cgc2VsZWN0IGNhbiB3b3JrIGZvciB0aGUgc3BlY2lmaWMgaW9hc2lkLgoK
VGhhbmtzCgoKPgo+IEEgaHVnZSBudW1iZXIgb2YgRkRzIGZvciB0eXBpY2FsIHVzYWdlcyBzaG91
bGQgYmUgYXZvaWRlZC4KPgo+IEphc29uCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby9pb21tdQ==
