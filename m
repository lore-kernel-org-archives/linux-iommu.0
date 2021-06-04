Return-Path: <SRS0=eMD9=K6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4341BC47096
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 01:30:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E65E8613FF
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 01:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E65E8613FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7E7FD40691;
	Fri,  4 Jun 2021 01:30:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RCr-1wa95iHZ; Fri,  4 Jun 2021 01:30:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3B4454068F;
	Fri,  4 Jun 2021 01:30:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F65EC000E;
	Fri,  4 Jun 2021 01:30:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E84E4C0001
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 01:30:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E2F5B6F931
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 01:30:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mzcAGT-ZOOSX for <iommu@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 01:30:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3DADA60689
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 01:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622770248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jD0SrrifrVAIWI7R1gZoaTn69EV68xZixLKv5uzjFb0=;
 b=LMBoFqc44DOArA0RxhZDRCpNYIRKtOjHtRTf9+0oDj5qumjjiYyTznNL0O+1WtmWe3JPUi
 OQa4ICPKWYN8rQ4UzTXu9woMyBx6ItojTaXMr/GveL/Ngtl6vMY8iTrNiCulIAoTy5N7wL
 JQuQ5WP1FwCq9DJkS1WfBLTVKpgdSVA=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-LHpgfRI7PO6R-2TF4uSC2A-1; Thu, 03 Jun 2021 21:30:47 -0400
X-MC-Unique: LHpgfRI7PO6R-2TF4uSC2A-1
Received: by mail-pf1-f200.google.com with SMTP id
 t20-20020aa793940000b02902e8f588ec26so4425380pfe.17
 for <iommu@lists.linux-foundation.org>; Thu, 03 Jun 2021 18:30:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=jD0SrrifrVAIWI7R1gZoaTn69EV68xZixLKv5uzjFb0=;
 b=Lkd54KzXKse24afPgE2uY7T9XZqUxH8UnsD1Svn09pLlSoEsYHDbzcs6/THrcKTJsB
 Ax1QnVaen6Vf4mbviGV/qUnwsS8yPvNN4fK91P4mrRwS/KWM/J4XwVE+tAcjYURyPee7
 x4QPL6upccAwRs4waIWTbNXSYjjtM802vs7QHa/welhCSQ/MauATgsyXVcdQ1JuqkJUt
 iYPVr0uxheuT7w8sdeaLABbyrSPLbnWqIlGYu5qpILNH8UpV/EMh5QQq3QiuL2ehbsrx
 a31LvRCCnKww6RURMGGIE95HPZW6/LT2w7Z/iZQt7YyxZ1LpBnnBuNrc0iy4Ta8cxSDI
 aPhg==
X-Gm-Message-State: AOAM530UTJOBeIhGAgvSMTLFM5NzYa3xaYpKNe/l8eFRmnUhxYoeZyGJ
 x5rtxaHVCONYbvVBXmlLz5FoCfS204OsyD3I3yBby8z4lwFYaYF3ZooPy/Zxa9GJrGs9c09pP1B
 /bP4hsLVFruV1MW2OJFAnZ7a9wIXFQg==
X-Received: by 2002:a63:6e87:: with SMTP id j129mr2331160pgc.45.1622770245927; 
 Thu, 03 Jun 2021 18:30:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPvvTcrHVuEjSyMsuOtnGOtgpMffrms7oNztTWuUcXduMPhSu1xCuPg2j+GGQkXnPef6d2rw==
X-Received: by 2002:a63:6e87:: with SMTP id j129mr2331134pgc.45.1622770245745; 
 Thu, 03 Jun 2021 18:30:45 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id d3sm3177937pjk.16.2021.06.03.18.30.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jun 2021 18:30:45 -0700 (PDT)
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Shenming Lu <lushenming@huawei.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <c9c066ae-2a25-0799-51a7-0ca47fff41a1@huawei.com>
 <aa1624bf-e472-2b66-1d20-54ca23c19fd2@linux.intel.com>
 <ed4f6e57-4847-3ed2-75de-cea80b2fbdb8@huawei.com>
 <01fe5034-42c8-6923-32f1-e287cc36bccc@linux.intel.com>
 <20210601173323.GN1002214@nvidia.com>
 <23a482f9-b88a-da98-3800-f3fd9ea85fbd@huawei.com>
 <20210603111914.653c4f61@jacob-builder>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1175ebd5-9d8e-2000-6d05-baa93e960915@redhat.com>
Date: Fri, 4 Jun 2021 09:30:37 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210603111914.653c4f61@jacob-builder>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Gibson <david@gibson.dropbear.id.au>, Jason Gunthorpe <jgg@nvidia.com>,
 "wanghaibin.wang@huawei.com" <wanghaibin.wang@huawei.com>, "Jiang,
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

CtTaIDIwMjEvNi80IMnPzucyOjE5LCBKYWNvYiBQYW4g0LS1wDoKPiBIaSBTaGVubWluZywKPgo+
IE9uIFdlZCwgMiBKdW4gMjAyMSAxMjo1MDoyNiArMDgwMCwgU2hlbm1pbmcgTHUgPGx1c2hlbm1p
bmdAaHVhd2VpLmNvbT4KPiB3cm90ZToKPgo+PiBPbiAyMDIxLzYvMiAxOjMzLCBKYXNvbiBHdW50
aG9ycGUgd3JvdGU6Cj4+PiBPbiBUdWUsIEp1biAwMSwgMjAyMSBhdCAwODozMDozNVBNICswODAw
LCBMdSBCYW9sdSB3cm90ZToKPj4+ICAgIAo+Pj4+IFRoZSBkcml2ZXJzIHJlZ2lzdGVyIHBlciBw
YWdlIHRhYmxlIGZhdWx0IGhhbmRsZXJzIHRvIC9kZXYvaW9hc2lkIHdoaWNoCj4+Pj4gd2lsbCB0
aGVuIHJlZ2lzdGVyIGl0c2VsZiB0byBpb21tdSBjb3JlIHRvIGxpc3RlbiBhbmQgcm91dGUgdGhl
IHBlci0KPj4+PiBkZXZpY2UgSS9PIHBhZ2UgZmF1bHRzLgo+Pj4gSSdtIHN0aWxsIGNvbmZ1c2Vk
IHdoeSBkcml2ZXJzIG5lZWQgZmF1bHQgaGFuZGxlcnMgYXQgYWxsPwo+PiBFc3NlbnRpYWxseSBp
dCBpcyB0aGUgdXNlcnNwYWNlIHRoYXQgbmVlZHMgdGhlIGZhdWx0IGhhbmRsZXJzLAo+PiBvbmUg
Y2FzZSBpcyB0byBkZWxpdmVyIHRoZSBmYXVsdHMgdG8gdGhlIHZJT01NVSwgYW5kIGFub3RoZXIK
Pj4gY2FzZSBpcyB0byBlbmFibGUgSU9QRiBvbiB0aGUgR1BBIGFkZHJlc3Mgc3BhY2UgZm9yIG9u
LWRlbWFuZAo+PiBwYWdpbmcsIGl0IHNlZW1zIHRoYXQgYm90aCBjb3VsZCBiZSBzcGVjaWZpZWQg
aW4vdGhyb3VnaCB0aGUKPj4gSU9BU0lEX0FMTE9DIGlvY3RsPwo+Pgo+IEkgd291bGQgdGhpbmsg
SU9BU0lEX0JJTkRfUEdUQUJMRSBpcyB3aGVyZSBmYXVsdCBoYW5kbGVyIHNob3VsZCBiZQo+IHJl
Z2lzdGVyZWQuIFRoZXJlIHdvdWxkbid0IGJlIGFueSBJTyBwYWdlIGZhdWx0IHdpdGhvdXQgdGhl
IGJpbmRpbmcgYW55d2F5Lgo+Cj4gSSBhbHNvIGRvbid0IHVuZGVyc3RhbmQgd2h5IGRldmljZSBk
cml2ZXJzIHNob3VsZCByZWdpc3RlciB0aGUgZmF1bHQKPiBoYW5kbGVyLCB0aGUgZmF1bHQgaXMg
ZGV0ZWN0ZWQgYnkgdGhlIHBJT01NVSBhbmQgaW5qZWN0ZWQgdG8gdGhlIHZJT01NVS4gU28KPiBJ
IHRoaW5rIGl0IHNob3VsZCBiZSB0aGUgSU9BU0lEIGl0c2VsZiByZWdpc3RlciB0aGUgaGFuZGxl
ci4KCgpBcyBkaXNjdXNzZWQgaW4gYW5vdGhlciB0aHJlYWQuCgpJIHRoaW5rIHRoZSByZWFzb24g
aXMgdGhhdCBBVFMgZG9lc24ndCBmb3JiaWQgdGhlICNQRiB0byBiZSByZXBvcnRlZCB2aWEgCmEg
ZGV2aWNlIHNwZWNpZmljIHdheS4KClRoYW5rcwoKCj4KPj4gVGhhbmtzLAo+PiBTaGVubWluZwo+
Pgo+Cj4gVGhhbmtzLAo+Cj4gSmFjb2IKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2lvbW11
