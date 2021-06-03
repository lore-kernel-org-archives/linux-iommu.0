Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5251C4708F
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 01:34:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71A20613BF
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 01:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71A20613BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3ECD682F41;
	Thu,  3 Jun 2021 01:34:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xF2PPcPkgXwZ; Thu,  3 Jun 2021 01:34:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2733F82F76;
	Thu,  3 Jun 2021 01:34:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4506C0001;
	Thu,  3 Jun 2021 01:34:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11BCBC0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 01:34:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E78F060AF6
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 01:34:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id clG3cEHTQXdq for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 01:34:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9175C60AE4
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 01:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622684062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ay34ayc0XC/WtKXXL+jwzIp+HQgsy2OJ9U8cZG5Fktk=;
 b=cxBF9wwfSOrPrM7soE/MAzChZ4MGm45vjkAFAUasdNdyjI4hZzGy99OiV4eBM004R3chfF
 ll+fP2OPd17sGuN2uobDzUXQjTGy7hMLVVXiTyRoSnIGzT15fCznQxmRBZWsOlkXqdG8Kr
 5xFQN3jERiUGE2v/ZLeA1GP7wmIvbdU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-AO25hUcXP-uejOWMOxvzVQ-1; Wed, 02 Jun 2021 21:34:19 -0400
X-MC-Unique: AO25hUcXP-uejOWMOxvzVQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 c13-20020a17090aa60db029015c73ea2ce5so2662986pjq.0
 for <iommu@lists.linux-foundation.org>; Wed, 02 Jun 2021 18:34:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Ay34ayc0XC/WtKXXL+jwzIp+HQgsy2OJ9U8cZG5Fktk=;
 b=ZqA2x7sQkijucOZsp4ZQOGDMqp4EvafyuawEY1RpiwxG+wqBhUs2psFv2BF9Mpp4JL
 nctpTFyvyABoDcxktPjj6UGFObhw3WkFCmvfS6GtpDevJDCmn4zAhqzXbfoXSUXPBEdX
 q0OWCGREgqSjpoN2bF9N03iN3rhLO69OykUhwSDmR5WeXVi4Qr4nGwqCsnpKX6gJx382
 ZoZkRW4Uq8YRMzTHj5R3g3wippuZ1tkvKLgEcp5OSU0vhDHvo0T6W1izSbnc/NJRMlkU
 tcogYorYBhnwow7hwLeXKHV4znGLwxyZNs7uVYZMAAIs2+XVUzBl8gHhhg3/5aaMsSXi
 /Xfw==
X-Gm-Message-State: AOAM533heiZEoS6rWQdoL8aTq7xjgGDgYMgp4BTBkyILbret3P0kJn5R
 rLU4u0TgkyUYZASuejGZUGDIqvgyAYe2W4BloaJ5vSzpUNUZHw4iNvYc6p+wVzYz/Ti56PLHMOq
 E5ko+Cu19fRsT4lEDaRk2ULvUm9dfhQ==
X-Received: by 2002:a63:cd16:: with SMTP id i22mr17954371pgg.251.1622684058137; 
 Wed, 02 Jun 2021 18:34:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJyXEZUAiaYZdr9WbuWSy8K0NWk52sC+zgmLSU88RNWlKo9NgUzTDhRO6ojpL1AFvITL5iKg==
X-Received: by 2002:a63:cd16:: with SMTP id i22mr17954351pgg.251.1622684057916; 
 Wed, 02 Jun 2021 18:34:17 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id c15sm884731pgt.68.2021.06.02.18.34.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jun 2021 18:34:17 -0700 (PDT)
Subject: Re: Virtio hardening for TDX
To: Andi Kleen <ak@linux.intel.com>, mst@redhat.com
References: <20210603004133.4079390-1-ak@linux.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <63d01084-68d2-a8d5-931d-541a22b5f231@redhat.com>
Date: Thu, 3 Jun 2021 09:34:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210603004133.4079390-1-ak@linux.intel.com>
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

CuWcqCAyMDIxLzYvMyDkuIrljYg4OjQxLCBBbmRpIEtsZWVuIOWGmemBkzoKPiBbdjE6IEluaXRp
YWwgcG9zdF0KPgo+IFdpdGggY29uZmlkZW50aWFsIGNvbXB1dGluZyBsaWtlIFREWCB0aGUgZ3Vl
c3QgZG9lc24ndCB0cnVzdCB0aGUgaG9zdAo+IGFueW1vcmUuIFRoZSBob3N0IGlzIGFsbG93ZWQg
dG8gRE9TIG9mIGNvdXJzZSwgYnV0IGl0IGlzIG5vdCBhbGxvd2VkCj4gdG8gcmVhZCBvciB3cml0
ZSBhbnkgZ3Vlc3QgbWVtb3J5IG5vdCBleHBsaWNpdGVseSBzaGFyZWQgd2l0aCBpdC4KPgo+IFRo
aXMgaGFzIGltcGxpY2F0aW9uIGZvciB2aXJ0aW8uIFRyYWRpdGlvbmFsbHkgdmlydGlvIGRpZG4n
dCBhc3N1bWUKPiB0aGUgb3RoZXIgc2lkZSBvZiB0aGUgY29tbXVuaWNhdGlvbiBjaGFubmVsIGlz
IG1hbGljaW91cywgYW5kIHRoZXJlZm9yZQo+IGRpZG4ndCBkbyBhbnkgYm91bmRhcnkgY2hlY2tz
IGluIHZpcnRpbyByaW5nIGRhdGEgc3RydWN0dXJlcy4KPgo+IFRoaXMgcGF0Y2hraXQgZG9lcyBo
YXJkZW5pbmcgZm9yIHZpcnRpby4gIEluIGEgVERYIGxpa2UgbW9kZWwKPiB0aGUgb25seSBob3N0
IG1lbW9yeSBhY2Nlc3NlcyBhbGxvd2VkIGFyZSBpbiB0aGUgdmlydGlvIHJpbmcsCj4gYXMgd2Vs
bCBhcyB0aGUgKGZvcmNlZCkgc3dpb3RsYiBidWZmZXIuCj4KPiBUaGlzIHBhdGNoIGtpdCBkb2Vz
IHZhcmlvdXMgY2hhbmdlcyB0byBlbnN1cmUgdGhlcmUgY2FuIGJlIG5vCj4gYWNjZXNzIG91dHNp
ZGUgdGhlc2UgdHdvIGFyZWFzLiBJdCBpcyBwb3NzaWJsZSBmb3IgdGhlIGhvc3QKPiB0byBicmVh
ayB0aGUgY29tbXVuaWNhdGlvbiwgYnV0IHRoaXMgc2hvdWxkIHJlc3VsdCBpbiBhIElPCj4gZXJy
b3Igb24gdGhlIGd1ZXN0LCBidXQgbm8gbWVtb3J5IHNhZmV0eSB2aW9sYXRpb25zLgo+Cj4gdmly
dGlvIGlzIHF1aXRlIGNvbXBsaWNhdGVkIHdpdGggbWFueSBtb2Rlcy4gVG8gc2ltcGxpZnkKPiB0
aGUgdGFzayB3ZSBlbmZvcmNlIHRoYXQgdmlydGlvIGlzIG9ubHkgaW4gc3BsaXQgbW9kZSB3aXRo
b3V0Cj4gaW5kaXJlY3QgZGVzY3JpcHRvcnMsIHdoZW4gcnVubmluZyBhcyBhIFREWCBndWVzdC4g
V2UgYWxzbwo+IGVuZm9yY2UgdXNlIG9mIHRoZSBETUEgQVBJLgo+Cj4gVGhlbiB0aGVzZSBjb2Rl
IHBhdGhzIGFyZSBoYXJkZW5lZCBhZ2FpbnN0IGFueSBjb3JydXB0aW9ucwo+IG9uIHRoZSByaW5n
Lgo+Cj4gVGhpcyBwYXRjaGtpdCBoYXMgY29tcG9uZW50cyBpbiB0aHJlZSBzdWJzeXN0ZW1zOgo+
IC0gSGFyZGVuaW5nIGNoYW5nZXMgdG8gdmlydGlvLCBhbGwgaW4gdGhlIGdlbmVyaWMgdmlydGlv
LXJpbmcKPiAtIEhhcmRlbmluZyBjaGFuZ2VzIHRvIGtlcm5lbC9kbWEgc3dpb3RsYiB0byBoYXJk
ZW4gc3dpb3RsYiBhZ2FpbnN0Cj4gbWFsaWNpb3VzIHBvaW50ZXJzLiBJdCByZXF1aXJlcyBhbiBB
UEkgY2hhbmdlIHdoaWNoIG5lZWRlZCBhIHRyZWUgc3dlZXAuCj4gLSBBIHNpbmdsZSB4ODYgcGF0
Y2ggdG8gZW5hYmxlIHRoZSBhcmNoX2hhc19yZXN0cmljdGVkX21lbW9yeV9hY2Nlc3MKPiBmb3Ig
VERYCj4KPiBJdCBkZXBlbmRzIG9uIFNhdGh5YSdzIGVhcmxpZXIgcGF0Y2hraXQgdGhhdCBhZGRz
IHRoZSBiYXNpYyBpbmZyYXN0cnVjdHVyZQo+IGZvciBURFguIFRoaXMgaXMgb25seSBuZWVkZWQg
Zm9yIHRoZSAiYW0gSSBydW5uaW5nIGluIFREWCIgcGFydC4KCgpOb3RlIHRoYXQgaXQncyBwcm9i
YWJseSBuZWVkZWQgYnkgb3RoZXIgY2FzZXMgYXMgd2VsbDoKCjEpIE90aGVyIGVuY3J5cHRlZCBW
TSB0ZWNobm9sb2d5CjIpIFZEVVNFWzFdCjMpIFNtYXJ0IE5JQ3MKCldlIGhhdmUgYWxyZWFkeSBo
YWQgZGlzY3Vzc2lvbnMgYW5kIHNvbWUgcGF0Y2hlcyBoYXZlIGJlZW4gcG9zdGVkWzJdWzNdWzRd
LgoKSSB0aGluayB0aGUgYmFzaWMgaWRlYSBpcyBzaW1pbGFyLCBiYXNpY2FsbHkswqAgd2UgZG9u
J3QgdHJ1c3QgYW55IAptZXRhZGF0YSBwcm92aWRlZCBieSB0aGUgZGV2aWNlLgoKWzJdIGlzIHRo
ZSBzZXJpZXMgdGhhdCB1c2UgdGhlIG1ldGFkYXRhIHN0b3JlZCBpbiB0aGUgcHJpdmF0ZSBtZW1v
cnkgCndoaWNoIGNhbid0IGJlIGFjY2Vzc2VkIGJ5IHN3aW90bGIsIHRoaXMgc2VyaWVzIGFpbXMg
dG8gZWxpbWluYXRlIGFsbCAKdGhlIHBvc3NpYmxlIGF0dGFja3MgdmlhIHZpcnRxdWV1ZSBtZXRh
ZGF0YQpbM10gaXMgb25lIGV4YW1wbGUgZm9yIHRoZSB0aGUgdXNlZCBsZW5ndGggdmFsaWRhdGlv
bgpbNF0gaXMgdGhlIGZpeCBmb3IgdGhlIG1hbGljaW91cyBjb25maWcgc3BhY2UKClRoYW5rcwoK
WzFdIGh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL25ldGRldi9tc2c3NDMyNjQuaHRtbApb
Ml0gaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMva3ZtL21zZzI0MTgyNS5odG1sClszXSBo
dHRwczovL3BhdGNoZXMubGluYXJvLm9yZy9wYXRjaC80NTA3MzMvCls0XSBodHRwczovL2xrbWwu
b3JnL2xrbWwvMjAyMS81LzE3LzM3NgoKPgo+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby9pb21tdQ==
