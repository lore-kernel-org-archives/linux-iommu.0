Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B05ECCA479
	for <iommu@archiver.kernel.org>; Fri,  1 Jul 2022 06:24:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D6A04600B8;
	Fri,  1 Jul 2022 06:24:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D6A04600B8
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20210112.gappssmtp.com header.i=@ozlabs-ru.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=kwTAIBLf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E1f96uc0H12i; Fri,  1 Jul 2022 06:24:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A05CF6000A;
	Fri,  1 Jul 2022 06:24:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A05CF6000A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D82EC0035;
	Fri,  1 Jul 2022 06:24:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E67F5C002D
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 06:24:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B18DB410D2
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 06:24:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B18DB410D2
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=ozlabs-ru.20210112.gappssmtp.com
 header.i=@ozlabs-ru.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=kwTAIBLf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id avVRdlo5jBTU for <iommu@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 06:24:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 48E6841821
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 48E6841821
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 06:24:43 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id l2so1699568pjf.1
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 23:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=OX5Xg3nmvuN3ZdgvoyCzaDoFDJ+1KDxFWAEkKaBYDxA=;
 b=kwTAIBLfu5raJ2HbD/ZxE2raE9aoUqz4c+H0tSDw7q549JL1Y9wrPrS6IUVoysBAFb
 5BqtFQOTPInNj9M/sAcwbzzRXOuH/kap72enUcF99tXSFuIoZagmb8uk192yXfT+4PuI
 JsoIYKQm6sbtamcyExbGcOBvnlzZe4vPVtAXpro/jhOYzKnSxc/htmXip+DY4XEBCoZr
 LoP04yz/kkQB/bSOwX5jO6EQGvO89UrP8bHYZGktQx1+uK6WNnMqpBk+Cgr+y+hHVMlC
 wkxDBUk4mcMNK72a+Q1rBTAfug0ZaNEKL1qzfnWIsdDE4x7daRrljx4clOanu3N9E+QS
 N+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=OX5Xg3nmvuN3ZdgvoyCzaDoFDJ+1KDxFWAEkKaBYDxA=;
 b=kx+Hn8iVZ7EekM+qANJV0sE+A3GdOBGfMlWOeMvBqXHRuVnLDNcYZ0O9YEMDk1rLPJ
 FkDfKvcEvflm7B5mM9P2a6XSzHgMI2BLXr+4bn4TpXj1uhR6dcTxRThYkemnqQW76roH
 gXQcHcQ5BHLvcl4vvB/AEGOQ5HmnBO++52f0id6TXRe8A9s7waFLevtan8HLQCAihul2
 y/J3DvP7xVidYWW44INB5KIM1NTsD4MxCQ5w+Z+fQZDm9D43rWKbBM0Vyc8r6VN02ucM
 ZLYeJVKzbi26nHp/W2Qyd+Q3xYmThsTlxJdogqlxM21Au5rTauokWcZ7lX0wcV6Ppp15
 xg0Q==
X-Gm-Message-State: AJIora84xLWLNYaL7uIydNJrQLAsZ/IIjUAMDYbD5JdIChnV7OQQuHRA
 zlRpF9C9D2nD23aiPH32T9ObFg==
X-Google-Smtp-Source: AGRyM1vRd0ySk+kAbx1QptbeAO9Bkw32uc/JUMymtxGRnvcUoujckfrV9HqzCtVKRNewU+f39JWr/g==
X-Received: by 2002:a17:90b:4c92:b0:1ec:ea7c:89af with SMTP id
 my18-20020a17090b4c9200b001ecea7c89afmr16712408pjb.195.1656656682607; 
 Thu, 30 Jun 2022 23:24:42 -0700 (PDT)
Received: from [10.61.2.177] (110-175-254-242.static.tpgi.com.au.
 [110.175.254.242]) by smtp.gmail.com with ESMTPSA id
 y3-20020a170902ed4300b0016a1c216b73sm14685102plb.9.2022.06.30.23.24.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jun 2022 23:24:41 -0700 (PDT)
Message-ID: <28ccf234-926a-2338-6d97-68225f6e3559@ozlabs.ru>
Date: Fri, 1 Jul 2022 16:24:35 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH v2 4/4] vfio: Require that devices support DMA cache
 coherence
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, Cornelia Huck <cohuck@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>
References: <4-v2-f090ae795824+6ad-intel_no_snoop_jgg@nvidia.com>
 <b39e78e4-05d3-8e83-cf40-be6de3a41909@ozlabs.ru>
 <BN9PR11MB5276EBBA17A869C7489B41C98CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <BN9PR11MB5276EBBA17A869C7489B41C98CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

CgpPbiA3LzEvMjIgMTY6MDcsIFRpYW4sIEtldmluIHdyb3RlOgo+PiBGcm9tOiBBbGV4ZXkgS2Fy
ZGFzaGV2c2tpeSA8YWlrQG96bGFicy5ydT4KPj4gU2VudDogRnJpZGF5LCBKdWx5IDEsIDIwMjIg
MTI6NTggUE0KPj4KPj4gT24gNC84LzIyIDAxOjIzLCBKYXNvbiBHdW50aG9ycGUgdmlhIGlvbW11
IHdyb3RlOgo+Pj4gSU9NTVVfQ0FDSEUgbWVhbnMgdGhhdCBub3JtYWwgRE1BcyBkbyBub3QgcmVx
dWlyZSBhbnkgYWRkaXRpb25hbAo+PiBjb2hlcmVuY3kKPj4+IG1lY2hhbmlzbSBhbmQgaXMgdGhl
IGJhc2ljIHVBUEkgdGhhdCBWRklPIGV4cG9zZXMgdG8gdXNlcnNwYWNlLiBGb3IKPj4+IGluc3Rh
bmNlIFZGSU8gYXBwbGljYXRpb25zIGxpa2UgRFBESyB3aWxsIG5vdCB3b3JrIGlmIGFkZGl0aW9u
YWwgY29oZXJlbmN5Cj4+PiBvcGVyYXRpb25zIGFyZSByZXF1aXJlZC4KPj4+Cj4+PiBUaGVyZWZv
cmUgY2hlY2sgSU9NTVVfQ0FQX0NBQ0hFX0NPSEVSRU5DWSBsaWtlIHZkcGEgJiB1c25pYyBkbwo+
PiBiZWZvcmUKPj4+IGFsbG93aW5nIGFuIElPTU1VIGJhY2tlZCBWRklPIGRldmljZSB0byBiZSBj
cmVhdGVkLgo+Pgo+Pgo+PiBUaGlzIGp1c3QgYnJva2UgVkZJTyBvbiBQT1dFUiB3aGljaCBkb2Vz
IG5vdCB1c2UgaW9tbXVfb3BzLgo+IAo+IEluIHRoaXMgY2FzZSBiZWxvdyBjaGVjayBpcyBtb3Jl
IHJlYXNvbmFibGUgdG8gYmUgcHV0IGluIHR5cGUxCj4gYXR0YWNoX2dyb3VwKCkuIERvIGEgaW9t
bXVfZ3JvdXBfZm9yX2VhY2hfZGV2KCkgdG8gdmVyaWZ5Cj4gQ0FDSEVfQ09IRVJFTkNZIHNpbWls
YXIgdG8gd2hhdCBSb2JpbiBkaWQgZm9yIElOVFJfUkVNQVAuCgoKYWggbWFrZXMgc2Vuc2UuIEkn
dmUgcG9zdGVkIGFuIFJGQyB3aXRoIGFub3RoZXIgcHJvYmxlbSAtICJbUkZDIFBBVENIIAprZXJu
ZWxdIHZmaW86IFNraXAgY2hlY2tpbmcgZm9yIElPTU1VX0NBUF9DQUNIRV9DT0hFUkVOQ1kgb24g
UE9XRVIgYW5kIAptb3JlIiwgd291bGQgYmUgZ3JlYXQgaWYgYm90aCBhZGRyZXNzZWQsIG9yIEkg
dHJ5IG1vdmluZyB0aG9zZSBuZXh0IHdlZWsgCjopIFRoYW5rcywKCgo+IAo+IChzb3JyeSBubyBh
Y2Nlc3MgdG8gbXkgYnVpbGQgbWFjaGluZSBub3cgYnV0IEkgc3VwcG9zZSBKYXNvbgo+IGNhbiBz
b29uIHdvcmsgb3V0IGEgZml4IG9uY2UgaGUgc2VlcyB0aGlzLiDwn5iKKQo+IAo+Pgo+Pgo+Pj4K
Pj4+IFNpZ25lZC1vZmYtYnk6IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+Cj4+PiAt
LS0KPj4+ICAgIGRyaXZlcnMvdmZpby92ZmlvLmMgfCA3ICsrKysrKysKPj4+ICAgIDEgZmlsZSBj
aGFuZ2VkLCA3IGluc2VydGlvbnMoKykKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92Zmlv
L3ZmaW8uYyBiL2RyaXZlcnMvdmZpby92ZmlvLmMKPj4+IGluZGV4IGE0NTU1MDE0YmQxZTcyLi45
ZWRhZDc2N2NmZGFkMyAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvdmZpby92ZmlvLmMKPj4+ICsr
KyBiL2RyaXZlcnMvdmZpby92ZmlvLmMKPj4+IEBAIC04MTUsNiArODE1LDEzIEBAIHN0YXRpYyBp
bnQgX192ZmlvX3JlZ2lzdGVyX2RldihzdHJ1Y3QgdmZpb19kZXZpY2UKPj4gKmRldmljZSwKPj4+
Cj4+PiAgICBpbnQgdmZpb19yZWdpc3Rlcl9ncm91cF9kZXYoc3RydWN0IHZmaW9fZGV2aWNlICpk
ZXZpY2UpCj4+PiAgICB7Cj4+PiArCS8qCj4+PiArCSAqIFZGSU8gYWx3YXlzIHNldHMgSU9NTVVf
Q0FDSEUgYmVjYXVzZSB3ZSBvZmZlciBubyB3YXkgZm9yCj4+IHVzZXJzcGFjZSB0bwo+Pj4gKwkg
KiByZXN0b3JlIGNhY2hlIGNvaGVyZW5jeS4KPj4+ICsJICovCj4+PiArCWlmICghaW9tbXVfY2Fw
YWJsZShkZXZpY2UtPmRldi0+YnVzLAo+PiBJT01NVV9DQVBfQ0FDSEVfQ09IRVJFTkNZKSkKPj4+
ICsJCXJldHVybiAtRUlOVkFMOwo+Pj4gKwo+Pj4gICAgCXJldHVybiBfX3ZmaW9fcmVnaXN0ZXJf
ZGV2KGRldmljZSwKPj4+ICAgIAkJdmZpb19ncm91cF9maW5kX29yX2FsbG9jKGRldmljZS0+ZGV2
KSk7Cj4+PiAgICB9Cj4+Cj4+IC0tCj4+IEFsZXhleQoKLS0gCkFsZXhleQpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9t
bXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
