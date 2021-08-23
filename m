Return-Path: <SRS0=Bvs7=NO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAA0C4338F
	for <iommu@archiver.kernel.org>; Mon, 23 Aug 2021 06:25:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC17A61356
	for <iommu@archiver.kernel.org>; Mon, 23 Aug 2021 06:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EC17A61356
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A361280C8B;
	Mon, 23 Aug 2021 06:25:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZoW1qloiP8Gf; Mon, 23 Aug 2021 06:25:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 88D0980C72;
	Mon, 23 Aug 2021 06:25:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60B0DC001A;
	Mon, 23 Aug 2021 06:25:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB4A6C000E
 for <iommu@lists.linux-foundation.org>; Mon, 23 Aug 2021 06:25:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AAD5680C8B
 for <iommu@lists.linux-foundation.org>; Mon, 23 Aug 2021 06:25:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ak8tMP0npgSb for <iommu@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 06:25:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CAEAD80C72
 for <iommu@lists.linux-foundation.org>; Mon, 23 Aug 2021 06:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629699898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fTBmg72UzrJzwwgyL0XX6MmGnq4XiN30FwOUg0WyeL8=;
 b=FP2I2eF6Vxj4C/mxETXrKldB7G93JIfxP2rg+iQuY6zkP7hxPWMnt/LYHoLJPesp5185TT
 2M2WmoRjIDg1DTPRbPilW/A8x+plT6ZweSyMVBOdwaOXI8PutPBFnfXl31D/yohln3perb
 4DnkMDSyWr8ktMsfO1ZigPp2uOdA4bU=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-SVr5zJX1Nn2gD8PGmEf7wg-1; Mon, 23 Aug 2021 02:24:56 -0400
X-MC-Unique: SVr5zJX1Nn2gD8PGmEf7wg-1
Received: by mail-pg1-f200.google.com with SMTP id
 t14-20020a635f0e000000b0024e7eb20fc3so5112918pgb.13
 for <iommu@lists.linux-foundation.org>; Sun, 22 Aug 2021 23:24:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=fTBmg72UzrJzwwgyL0XX6MmGnq4XiN30FwOUg0WyeL8=;
 b=uFAk6yhRq7L+WxESMsOq6HuhfGIMu8k5hnjBXU4FD2kx9dz6egcPJmlg4skFhTLCDE
 o1CPQgBYQowTA0gYXQJVF5XCy+DEUp2KQcta5GXoIkdIFeD9Vzo1GmiwxuZBFYOBULRI
 q+wculYNmt/rd5OPpKBQEl/jfFHgZPqTC+KKwikaQsF/qME4GFGiHeusFSY1+WBza/Sw
 twkglU8SBGbeur6dxUBnyMm0CifWKlr/DcLdEhkzGIp/A3L5vGgXbqkLLRZ6WxzGhMh8
 1FuDdauVFxMp3maOFebG7OFF+Bre3EXIHrbwj2tF8eA3b6kXyCuyboZ6GkKdbqvu539b
 3rTg==
X-Gm-Message-State: AOAM5316XSpmf+gHZdtPF4YbII2W9SYlRL954Vvp8xrxDpI6u3j6zqB7
 He7LVxAGhcHdJhTVxcBiTH7dHG5u1u31YfSAdubCzPvBWx50w00Z8wNxhjqYlvJWyypwIlc5JJi
 vbLChWPeY3ORx+/hyTu4GKGSnazn0ZQ==
X-Received: by 2002:a17:90a:b016:: with SMTP id
 x22mr7315307pjq.205.1629699895444; 
 Sun, 22 Aug 2021 23:24:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYnrO75usjjlrGCgZzdsLDtPE2dKORuqu4cQ6/SLHByjgTAawINCsTeerUMEDWc0TN8ooDAw==
X-Received: by 2002:a17:90a:b016:: with SMTP id
 x22mr7315281pjq.205.1629699895193; 
 Sun, 22 Aug 2021 23:24:55 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id g3sm14314416pfi.197.2021.08.22.23.24.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Aug 2021 23:24:54 -0700 (PDT)
Subject: Re: [PATCH v11 01/12] iova: Export alloc_iova_fast() and
 free_iova_fast()
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
 hch@infradead.org, christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com, joe@perches.com,
 robin.murphy@arm.com
References: <20210818120642.165-1-xieyongji@bytedance.com>
 <20210818120642.165-2-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3ff77bab-8bb7-ae5b-4cf1-a90ebcc00118@redhat.com>
Date: Mon, 23 Aug 2021 14:24:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210818120642.165-2-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 songmuchun@bytedance.com, linux-fsdevel@vger.kernel.org
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

CtTaIDIwMjEvOC8xOCDPws7nODowNiwgWGllIFlvbmdqaSDQtLXAOgo+IEV4cG9ydCBhbGxvY19p
b3ZhX2Zhc3QoKSBhbmQgZnJlZV9pb3ZhX2Zhc3QoKSBzbyB0aGF0Cj4gc29tZSBtb2R1bGVzIGNh
biBtYWtlIHVzZSBvZiB0aGUgcGVyLUNQVSBjYWNoZSB0byBnZXQKPiByaWQgb2YgcmJ0cmVlIHNw
aW5sb2NrIGluIGFsbG9jX2lvdmEoKSBhbmQgZnJlZV9pb3ZhKCkKPiBkdXJpbmcgSU9WQSBhbGxv
Y2F0aW9uLgo+Cj4gU2lnbmVkLW9mZi1ieTogWGllIFlvbmdqaSA8eGlleW9uZ2ppQGJ5dGVkYW5j
ZS5jb20+CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgooSWYg
d2UgbmVlZCByZXNwaW4sIEknZCBzdWdnZXN0IHRvIHB1dCB0aGUgbnVtYmVycyB5b3UgbWVhc3Vy
ZWQgaGVyZSkKClRoYW5rcwoKCj4gLS0tCj4gICBkcml2ZXJzL2lvbW11L2lvdmEuYyB8IDIgKysK
PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2lvbW11L2lvdmEuYyBiL2RyaXZlcnMvaW9tbXUvaW92YS5jCj4gaW5kZXggYjZjZjVmMTYx
MjNiLi4zOTQxZWQ2YmI5OWIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9pb21tdS9pb3ZhLmMKPiAr
KysgYi9kcml2ZXJzL2lvbW11L2lvdmEuYwo+IEBAIC01MjEsNiArNTIxLDcgQEAgYWxsb2NfaW92
YV9mYXN0KHN0cnVjdCBpb3ZhX2RvbWFpbiAqaW92YWQsIHVuc2lnbmVkIGxvbmcgc2l6ZSwKPiAg
IAo+ICAgCXJldHVybiBuZXdfaW92YS0+cGZuX2xvOwo+ICAgfQo+ICtFWFBPUlRfU1lNQk9MX0dQ
TChhbGxvY19pb3ZhX2Zhc3QpOwo+ICAgCj4gICAvKioKPiAgICAqIGZyZWVfaW92YV9mYXN0IC0g
ZnJlZSBpb3ZhIHBmbiByYW5nZSBpbnRvIHJjYWNoZQo+IEBAIC01MzgsNiArNTM5LDcgQEAgZnJl
ZV9pb3ZhX2Zhc3Qoc3RydWN0IGlvdmFfZG9tYWluICppb3ZhZCwgdW5zaWduZWQgbG9uZyBwZm4s
IHVuc2lnbmVkIGxvbmcgc2l6ZSkKPiAgIAo+ICAgCWZyZWVfaW92YShpb3ZhZCwgcGZuKTsKPiAg
IH0KPiArRVhQT1JUX1NZTUJPTF9HUEwoZnJlZV9pb3ZhX2Zhc3QpOwo+ICAgCj4gICAjZGVmaW5l
IGZxX3JpbmdfZm9yX2VhY2goaSwgZnEpIFwKPiAgIAlmb3IgKChpKSA9IChmcSktPmhlYWQ7IChp
KSAhPSAoZnEpLT50YWlsOyAoaSkgPSAoKGkpICsgMSkgJSBJT1ZBX0ZRX1NJWkUpCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxp
c3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
