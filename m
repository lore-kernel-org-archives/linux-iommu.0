Return-Path: <SRS0=kThj=K4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFCDC47092
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 08:52:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 766B5613AA
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 08:52:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 766B5613AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 352FF60891;
	Wed,  2 Jun 2021 08:52:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UvfmN412mvDI; Wed,  2 Jun 2021 08:52:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5D1D760596;
	Wed,  2 Jun 2021 08:52:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35991C000E;
	Wed,  2 Jun 2021 08:52:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC51BC0001
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 08:52:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AA50D401FA
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 08:52:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Le5vbxLrQ0ab for <iommu@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 08:52:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A1B93401D2
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 08:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622623952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ArZvpLSAQuv5CBVhrYmEmSDRDRVYj1zP8TVHlpX3nA=;
 b=N55LO5U0fXUOlaO9UnIcoWZRiSWPlkXx8Cw+gqb5N9nrDIPH7EgVFXzwvtGiTUKPMNGejA
 XZtBzIRGuEHWbz19ff45X2nnFCWgA/fhWwOIGZEdUCRucmCd3LhzeqC8KRqaUj62dWjUzd
 2gKKEZ+5g3yCM7qMiJSnm8GuFPDtL9s=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-JbikS86kPGSVQ-05riBjnA-1; Wed, 02 Jun 2021 04:52:30 -0400
X-MC-Unique: JbikS86kPGSVQ-05riBjnA-1
Received: by mail-pf1-f197.google.com with SMTP id
 d17-20020aa781510000b02902e921bdea05so1089840pfn.21
 for <iommu@lists.linux-foundation.org>; Wed, 02 Jun 2021 01:52:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=9ArZvpLSAQuv5CBVhrYmEmSDRDRVYj1zP8TVHlpX3nA=;
 b=kGQGme0nttSfpHn0ybajss/3+mM/xibm7p8dYUA88UvggzIhjpEt+Rt9RffLpx/NRO
 FoC54pJPcWUtCuvqGhk5YmyXI78TnGHnWHOGFg+vMKJKz8KV02d8UaPM2uspGoWp/qEf
 DWZcpDGSuG5+MPk0OOubafOXI1hPiuWhQNT0apv5UQkw0OxyIzV8B0UjHfbqIVoTdJxP
 TV1l9ZJRVbzr1+zu9/AAofGCQK8j3XBW0H8O9l3fSyp+aB7zKDfBAhqhQ6x7LRf988dm
 2yAIm2mA4D3mUlxefKPP5CeclOellHotlbZAIVS8bI5dDDi1LjKgbu3wp5pp+pKNpRqv
 5RCg==
X-Gm-Message-State: AOAM532VVz0qYweVvlNeF4DJi7qUhdb7kd8SatifFJLtsHjwei0e9CJe
 mRpSdNQ2Af8JgvS9sh/dIXZV6z3aPecRyNC8Xt5md/lAYp5pQHkEVEOLAe71Z2RhX90SUA/BB0H
 zpF5/UDEi9VYjTkauP0zD2I/emy2kiw==
X-Received: by 2002:a05:6a00:856:b029:28e:e5d2:9a62 with SMTP id
 q22-20020a056a000856b029028ee5d29a62mr25918418pfk.17.1622623949417; 
 Wed, 02 Jun 2021 01:52:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6352chW2w8JBVfW8qE6tyLLdIANPog+tIL9JC4Kxa2bdk25eLDpPcxihKlfwVlgGmyGjSHg==
X-Received: by 2002:a05:6a00:856:b029:28e:e5d2:9a62 with SMTP id
 q22-20020a056a000856b029028ee5d29a62mr25918402pfk.17.1622623949178; 
 Wed, 02 Jun 2021 01:52:29 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id a20sm6829660pfk.145.2021.06.02.01.52.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jun 2021 01:52:28 -0700 (PDT)
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To: Jason Gunthorpe <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528200311.GP1002214@nvidia.com>
 <MWHPR11MB188685D57653827B566BF9B38C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210601202834.GR1002214@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1a3b4cf2-f511-640b-6c8c-a85f94a9536d@redhat.com>
Date: Wed, 2 Jun 2021 16:52:02 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210601202834.GR1002214@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "Alex Williamson \(alex.williamson@redhat.com\)"
 <alex.williamson@redhat.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Gibson <david@gibson.dropbear.id.au>, "Jiang,
 Dave" <dave.jiang@intel.com>, David Woodhouse <dwmw2@infradead.org>
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

CtTaIDIwMjEvNi8yIMnPzuc0OjI4LCBKYXNvbiBHdW50aG9ycGUg0LS1wDoKPj4gSSBzdW1tYXJp
emVkIGZpdmUgb3BlbnMgaGVyZSwgYWJvdXQ6Cj4+Cj4+IDEpICBGaW5hbGl6aW5nIHRoZSBuYW1l
IHRvIHJlcGxhY2UgL2Rldi9pb2FzaWQ7Cj4+IDIpICBXaGV0aGVyIG9uZSBkZXZpY2UgaXMgYWxs
b3dlZCB0byBiaW5kIHRvIG11bHRpcGxlIElPQVNJRCBmZCdzOwo+PiAzKSAgQ2FycnkgZGV2aWNl
IGluZm9ybWF0aW9uIGluIGludmFsaWRhdGlvbi9mYXVsdCByZXBvcnRpbmcgdUFQSTsKPj4gNCkg
IFdoYXQgc2hvdWxkL2NvdWxkIGJlIHNwZWNpZmllZCB3aGVuIGFsbG9jYXRpbmcgYW4gSU9BU0lE
Owo+PiA1KSAgVGhlIHByb3RvY29sIGJldHdlZW4gdmZpbyBncm91cCBhbmQga3ZtOwo+Pgo+PiBG
b3IgMSksIHR3byBhbHRlcm5hdGl2ZSBuYW1lcyBhcmUgbWVudGlvbmVkOiAvZGV2L2lvbW11IGFu
ZAo+PiAvZGV2L2lvYXMuIEkgZG9uJ3QgaGF2ZSBhIHN0cm9uZyBwcmVmZXJlbmNlIGFuZCB3b3Vs
ZCBsaWtlIHRvIGhlYXIKPj4gdm90ZXMgZnJvbSBhbGwgc3Rha2Vob2xkZXJzLiAvZGV2L2lvbW11
IGlzIHNsaWdodGx5IGJldHRlciBpbWhvIGZvcgo+PiB0d28gcmVhc29ucy4gRmlyc3QsIHBlciBB
TUQncyBwcmVzZW50YXRpb24gaW4gbGFzdCBLVk0gZm9ydW0gdGhleQo+PiBpbXBsZW1lbnQgdklP
TU1VIGluIGhhcmR3YXJlIHRodXMgbmVlZCB0byBzdXBwb3J0IHVzZXItbWFuYWdlZAo+PiBkb21h
aW5zLiBBbiBpb21tdSB1QVBJIG5vdGF0aW9uIG1pZ2h0IG1ha2UgbW9yZSBzZW5zZSBtb3ZpbmcK
Pj4gZm9yd2FyZC4gU2Vjb25kLCBpdCBtYWtlcyBsYXRlciB1QVBJIG5hbWluZyBlYXNpZXIgYXMg
J0lPQVNJRCcgY2FuCj4+IGJlIGFsd2F5cyBwdXQgYXMgYW4gb2JqZWN0LCBlLmcuIElPTU1VX0FM
TE9DX0lPQVNJRCBpbnN0ZWFkIG9mCj4+IElPQVNJRF9BTExPQ19JT0FTSUQuOikKPiBJIHRoaW5r
IHR3byB5ZWFycyBhZ28gSSBzdWdnZXN0ZWQgL2Rldi9pb21tdSBhbmQgaXQgZGlkbid0IGdvIHZl
cnkgZmFyCj4gYXQgdGhlIHRpbWUuCgoKSXQgbG9va3MgdG8gbWUgdXNpbmcgIi9kZXYvaW9tbXUi
IGV4Y2x1ZGVzIHRoZSBwb3NzaWJpbGl0eSBvZiAKaW1wbGVtZW50aW5nIElPQVNJRCBpbiBhIGRl
dmljZSBzcGVjaWZpYyB3YXkgKGUuZyB0aHJvdWdoIHRoZSAKY28tb3BlcmF0aW9uIHdpdGggZGV2
aWNlIE1NVSArIHBsYXRmb3JtIElPTU1VKT8KCldoYXQncyBtb3JlLCBBVFMgc3BlYyBkb2Vzbid0
IGZvcmJpZCB0aGUgZGV2aWNlICNQRiB0byBiZSByZXBvcnRlZCB2aWEgYSAKZGV2aWNlIHNwZWNp
ZmljIHdheS4KClRoYW5rcwoKCj4gV2UndmUgYWxzbyB0YWxrZWQgYWJvdXQgdGhpcyBhcyAvZGV2
L3N2YSBmb3IgYSB3aGlsZSBhbmQKPiBub3cgL2Rldi9pb2FzaWQKPgo+IEkgdGhpbmsgL2Rldi9p
b21tdSBpcyBmaW5lLCBhbmQgY2FsbCB0aGUgdGhpbmdzIGluc2lkZSB0aGVtIElPQVMKPiBvYmpl
Y3RzLgo+Cj4gVGhlbiB3ZSBkb24ndCBoYXZlIG5hbWluZyBhbGlhc2luZyB3aXRoIGtlcm5lbCBj
b25zdHJ1Y3RzLgo+ICAgCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9t
bXU=
