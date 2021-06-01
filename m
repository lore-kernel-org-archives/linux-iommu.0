Return-Path: <SRS0=UGJ5=K3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A54AC4708F
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 05:10:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4002E6136E
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 05:10:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4002E6136E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 112874065E;
	Tue,  1 Jun 2021 05:10:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5PD54zfWw7Ik; Tue,  1 Jun 2021 05:10:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 07A3E4063C;
	Tue,  1 Jun 2021 05:10:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3949C000E;
	Tue,  1 Jun 2021 05:10:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB329C0001
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 05:10:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A4E4D843A1
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 05:10:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y-pYGAknaMJZ for <iommu@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 05:10:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E43D683DAF
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 05:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622524244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/e5q/5xjzsRkEDNz5ZxlpC3JGa3sYqjV3MHMYvl155U=;
 b=Y4nvsKtcf4MBWjXFMbUfn7QLGmZuWJxzckl0n4ef+oxtWWTZGyAQpcjbfdWWEhj4nTfVQl
 Cr2wpzMgGNeP+RROXScd2jKxBQeRPT9osQGSdkVkcTp5jB9CROXSj+xnRENvFwAofnoW30
 xgDeSkVwStyqYpu5nogq8o9VIQ+50Ac=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-Bo8asSGxMF6Q0bGo6NiEWQ-1; Tue, 01 Jun 2021 01:10:42 -0400
X-MC-Unique: Bo8asSGxMF6Q0bGo6NiEWQ-1
Received: by mail-pf1-f198.google.com with SMTP id
 s5-20020aa78d450000b02902ace63a7e93so6792339pfe.8
 for <iommu@lists.linux-foundation.org>; Mon, 31 May 2021 22:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=/e5q/5xjzsRkEDNz5ZxlpC3JGa3sYqjV3MHMYvl155U=;
 b=Lmbq1Ra1M4k+9onkM9rx4PjA7/iD/i8i+UNKT5YBou/AkGgUV48vQzNBvFijIYHCUG
 2jlQY/X3MGGQet9pWrrggrIuLvXGUmlZt6fucx5ft25fe3I/qfjEaldiQ9RPmYwyHFCE
 1MuCNmy1IBuOJUYnBHaZAxuYBLcPQ1CGqMEiSz1BAckjiHXEgGYSSGF3FQ/+sYYd9c5w
 LxG5tEq9Q1yXxGvF2sdMc+ioPIsNHcMobg2vQgvuHDT77Kd/bZvsCR9jnmV1TsSy3ErL
 zDA2cvIqwjhYa6B5XH4rZAXPKl5zV9wMJ9jd0g50P+PC9WVIJOV+1KA5Y2a58JACYRFI
 vh3A==
X-Gm-Message-State: AOAM533Qa5kbYzzxFN25a2jQp8ZfxLjAVEXLfux+UmTzQiyTuKnrZ5Mi
 cSZTFQVSLcrZc4nr93tE56Gz2kcavtPq0Zn3KJctJc9Ld0HzQipbVquBMA1Nuwuh1ULBJ5iqJyz
 MKCT+0fP89TwUUWmBfw+tl5+hyKM4WQ==
X-Received: by 2002:a62:e705:0:b029:2e0:3497:32d3 with SMTP id
 s5-20020a62e7050000b02902e0349732d3mr20356159pfh.8.1622524241676; 
 Mon, 31 May 2021 22:10:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytHxyR4BWmCRVtKpv5IYBYhq4d+/sKgZ9pMx4Js9IFNC7XvBhu73uGhDC20WcBEh8d9BaQzw==
X-Received: by 2002:a62:e705:0:b029:2e0:3497:32d3 with SMTP id
 s5-20020a62e7050000b02902e0349732d3mr20356134pfh.8.1622524241480; 
 Mon, 31 May 2021 22:10:41 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id j20sm11866560pfj.40.2021.05.31.22.10.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 May 2021 22:10:41 -0700 (PDT)
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To: Shenming Lu <lushenming@huawei.com>, Liu Yi L <yi.l.liu@linux.intel.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <f510f916-e91c-236d-e938-513a5992d3b5@redhat.com>
 <20210531164118.265789ee@yiliu-dev>
 <78ee2638-1a03-fcc8-50a5-81040f677e69@redhat.com>
 <1fedcd93-1a8a-884f-d0c8-3e2c21ed7654@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e95add68-7556-f8a3-695b-40389742a682@redhat.com>
Date: Tue, 1 Jun 2021 13:10:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <1fedcd93-1a8a-884f-d0c8-3e2c21ed7654@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)\""
 <alex.williamson@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>,
 "wanghaibin.wang@huawei.com" <wanghaibin.wang@huawei.com>,
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
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

CuWcqCAyMDIxLzYvMSDkuIvljYgxMjoyNywgU2hlbm1pbmcgTHUg5YaZ6YGTOgo+IE9uIDIwMjEv
Ni8xIDEwOjM2LCBKYXNvbiBXYW5nIHdyb3RlOgo+PiDDpcWTwqggMjAyMS81LzMxIMOkwrjigLnD
pe+/vcuGNDo0MSwgTGl1IFlpIEwgw6XigKDihKLDqe+/veKAnDoKPj4+PiBJIGd1ZXNzIFZGSU9f
QVRUQUNIX0lPQVNJRCB3aWxsIGZhaWwgaWYgdGhlIHVuZGVybGF5ZXIgZG9lc24ndCBzdXBwb3J0
Cj4+Pj4gaGFyZHdhcmUgbmVzdGluZy4gT3IgaXMgdGhlcmUgd2F5IHRvIGRldGVjdCB0aGUgY2Fw
YWJpbGl0eSBiZWZvcmU/Cj4+PiBJIHRoaW5rIGl0IGNvdWxkIGZhaWwgaW4gdGhlIElPQVNJRF9D
UkVBVEVfTkVTVElORy4gSWYgdGhlIGdwYV9pb2FzaWQKPj4+IGlzIG5vdCBhYmxlIHRvIHN1cHBv
cnQgbmVzdGluZywgdGhlbiBzaG91bGQgZmFpbCBpdC4KPj4+Cj4+Pj4gSSB0aGluayBHRVRfSU5G
TyBvbmx5IHdvcmtzIGFmdGVyIHRoZSBBVFRBQ0guCj4+PiB5ZXMuIEFmdGVyIGF0dGFjaGluZyB0
byBncGFfaW9hc2lkLCB1c2Vyc3BhY2UgY291bGQgR0VUX0lORk8gb24gdGhlCj4+PiBncGFfaW9h
c2lkIGFuZCBjaGVjayBpZiBuZXN0aW5nIGlzIHN1cHBvcnRlZCBvciBub3QuIHJpZ2h0Pwo+Pgo+
PiBTb21lIG1vcmUgcXVlc3Rpb25zOgo+Pgo+PiAxKSBJcyB0aGUgaGFuZGxlIHJldHVybmVkIGJ5
IElPQVNJRF9BTExPQyBhbiBmZD8KPj4gMikgSWYgeWVzLCB3aGF0J3MgdGhlIHJlYXNvbiBmb3Ig
bm90IHNpbXBseSB1c2UgdGhlIGZkIG9wZW5lZCBmcm9tIC9kZXYvaW9hcy4gKFRoaXMgaXMgdGhl
IHF1ZXN0aW9uIHRoYXQgaXMgbm90IGFuc3dlcmVkKSBhbmQgd2hhdCBoYXBwZW5zIGlmIHdlIGNh
bGwgR0VUX0lORk8gZm9yIHRoZSBpb2FzaWRfZmQ/Cj4+IDMpIElmIG5vdCwgaG93IEdFVF9JTkZP
IHdvcms/Cj4gSXQgc2VlbXMgdGhhdCB0aGUgcmV0dXJuIHZhbHVlIGZyb20gSU9BU0lEX0FMTE9D
IGlzIGFuIElPQVNJRCBudW1iZXIgaW4gdGhlCj4gaW9hc2lkX2RhdGEgc3RydWN0LCB0aGVuIHdo
ZW4gY2FsbGluZyBHRVRfSU5GTywgd2Ugc2hvdWxkIGNvbnZleSB0aGlzIElPQVNJRAo+IG51bWJl
ciB0byBnZXQgdGhlIGFzc29jaWF0ZWQgSS9PIGFkZHJlc3Mgc3BhY2UgYXR0cmlidXRlcyAoZGVw
ZW5kIG9uIHRoZQo+IHBoeXNpY2FsIElPTU1VLCB3aGljaCBjb3VsZCBiZSBkaXNjb3ZlcmVkIHdo
ZW4gYXR0YWNoaW5nIGEgZGV2aWNlIHRvIHRoZQo+IElPQVNJRCBmZCBvciBudW1iZXIpLCByaWdo
dD8KCgpSaWdodCwgYnV0IHRoZSBxdWVzdGlvbiBpcyB3aHkgbmVlZCBzdWNoIGluZGlyZWN0aW9u
PyBVbmxlc3MgdGhlcmUncyBhIApjYXNlIHRoYXQgeW91IG5lZWQgdG8gY3JlYXRlIG11bHRpcGxl
IElPQVNJRHMgcGVyIGlvYXNpZCBmZC4gSXQncyBtb3JlIApzaW1wbGVyIHRvIGF0dGFjaCB0aGUg
bWV0YWRhdGEgaW50byB0aGUgaW9hc2lkIGZkIGl0c2VsZi4KClRoYW5rcwoKCj4KPiBUaGFua3Ms
Cj4gU2hlbm1pbmcKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
