Return-Path: <SRS0=qwh6=M2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F4FC4338F
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 07:41:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AF0460F8F
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 07:41:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1AF0460F8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C646840261;
	Tue,  3 Aug 2021 07:41:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B2UzvSfUbMiA; Tue,  3 Aug 2021 07:41:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7A7D940101;
	Tue,  3 Aug 2021 07:41:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B3C2C0010;
	Tue,  3 Aug 2021 07:41:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 526F5C000E
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 07:41:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 48B4C82FC9
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 07:41:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CRqsFo3AF6wx for <iommu@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 07:41:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 944ED82F4F
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 07:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627976493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XXZLExcEITdntTYG0Of03HReF9Mx2BfGVrCdJE4PA5o=;
 b=RzlkaVP2qrY+gOIVDFD5YgPKSKbSFlV1pSOiyhp/I8RIJ0n5nT+QAcQqIS6yRm0wt0rb+m
 s+JXql5tYOssfxKd0XU2crb2+Jkxrp8/KcU0B+l6VK7toF/EnHk2CgnOMizBdoShXF5a12
 4hNSjC/EnFxiyRguFpWO3eMv5uBNNlQ=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-kS-Yd3T5Onqx6ctoOLZJ5A-1; Tue, 03 Aug 2021 03:41:30 -0400
X-MC-Unique: kS-Yd3T5Onqx6ctoOLZJ5A-1
Received: by mail-pl1-f197.google.com with SMTP id
 z1-20020a1709030181b029012c775d35e1so12733306plg.20
 for <iommu@lists.linux-foundation.org>; Tue, 03 Aug 2021 00:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=XXZLExcEITdntTYG0Of03HReF9Mx2BfGVrCdJE4PA5o=;
 b=VdOw0qtbJGQbkwgJP7evbZbL65y/b2b8e6bYf3s/7K4KqGdsDDxNQ+bZgemgHmZPIt
 3T1tW9re1FsT3JIGYocM6JXQFN1JT/M+e5NqlSbxxTHop9G9fRvXGG66wK0iO+3evkvG
 tAwmYFVUgfmnsoPS8QZ3+G40PVczh427LsIVMW1MpBcg7kwMo8coYVu6FF8lV4Ggeiqv
 ckA6brEuNA9YHjGPYDbB2YbrUCkxOgC5/Ah4wQpME2jDyyrcVxm+IGOEY15HXWTf9PAm
 H0kx4BnAaPxtg8gAlZ09lZ8RzT93HuGKEX9mgSCG25B9PBv/Z8RvLUrfhOyXAnSqN3OW
 t0qw==
X-Gm-Message-State: AOAM531hy68F8h0gY1YJoKXLZAWwsZ36BL68ZcMIzgJgDanEDNVGUahH
 +Irp6C3++WkjBr/NBcsTQT60qqwKjToONhPTkSwRSqJPwFAcSdyDGTuUUngdhG2EIRLWJ3qfNyY
 GEwFR11u74R6tklPe7wfXOItttkvIcA==
X-Received: by 2002:aa7:961d:0:b029:3bc:dbdd:7a9b with SMTP id
 q29-20020aa7961d0000b02903bcdbdd7a9bmr9608179pfg.32.1627976489057; 
 Tue, 03 Aug 2021 00:41:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwjX4aE2G2A/KT25YRVhvLPWveCcGvZhYValWvnC/74smyorfbkjI1EnjKESaebAF3OLAkpg==
X-Received: by 2002:aa7:961d:0:b029:3bc:dbdd:7a9b with SMTP id
 q29-20020aa7961d0000b02903bcdbdd7a9bmr9608133pfg.32.1627976488686; 
 Tue, 03 Aug 2021 00:41:28 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id j6sm16132108pgq.0.2021.08.03.00.41.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Aug 2021 00:41:28 -0700 (PDT)
Subject: Re: [PATCH v10 01/17] iova: Export alloc_iova_fast() and
 free_iova_fast()
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
 hch@infradead.org, christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com, joe@perches.com
References: <20210729073503.187-1-xieyongji@bytedance.com>
 <20210729073503.187-2-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4eb84e87-21ef-608f-ae15-3e9bc442971c@redhat.com>
Date: Tue, 3 Aug 2021 15:41:18 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210729073503.187-2-xieyongji@bytedance.com>
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

CtTaIDIwMjEvNy8yOSDPws7nMzozNCwgWGllIFlvbmdqaSDQtLXAOgo+IEV4cG9ydCBhbGxvY19p
b3ZhX2Zhc3QoKSBhbmQgZnJlZV9pb3ZhX2Zhc3QoKSBzbyB0aGF0Cj4gc29tZSBtb2R1bGVzIGNh
biB1c2UgaXQgdG8gaW1wcm92ZSBpb3ZhIGFsbG9jYXRpb24gZWZmaWNpZW5jeS4KCgpJdCdzIGJl
dHRlciB0byBleHBsYWluIHdoaWNoIGFsbG9jX2lvdmEoKSBpcyBub3Qgc3VmZmljaWVudCBoZXJl
LgoKVGhhbmtzCgoKPgo+IFNpZ25lZC1vZmYtYnk6IFhpZSBZb25namkgPHhpZXlvbmdqaUBieXRl
ZGFuY2UuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9pb21tdS9pb3ZhLmMgfCAyICsrCj4gICAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21t
dS9pb3ZhLmMgYi9kcml2ZXJzL2lvbW11L2lvdmEuYwo+IGluZGV4IGI2Y2Y1ZjE2MTIzYi4uMzk0
MWVkNmJiOTliIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW92YS5jCj4gKysrIGIvZHJp
dmVycy9pb21tdS9pb3ZhLmMKPiBAQCAtNTIxLDYgKzUyMSw3IEBAIGFsbG9jX2lvdmFfZmFzdChz
dHJ1Y3QgaW92YV9kb21haW4gKmlvdmFkLCB1bnNpZ25lZCBsb25nIHNpemUsCj4gICAKPiAgIAly
ZXR1cm4gbmV3X2lvdmEtPnBmbl9sbzsKPiAgIH0KPiArRVhQT1JUX1NZTUJPTF9HUEwoYWxsb2Nf
aW92YV9mYXN0KTsKPiAgIAo+ICAgLyoqCj4gICAgKiBmcmVlX2lvdmFfZmFzdCAtIGZyZWUgaW92
YSBwZm4gcmFuZ2UgaW50byByY2FjaGUKPiBAQCAtNTM4LDYgKzUzOSw3IEBAIGZyZWVfaW92YV9m
YXN0KHN0cnVjdCBpb3ZhX2RvbWFpbiAqaW92YWQsIHVuc2lnbmVkIGxvbmcgcGZuLCB1bnNpZ25l
ZCBsb25nIHNpemUpCj4gICAKPiAgIAlmcmVlX2lvdmEoaW92YWQsIHBmbik7Cj4gICB9Cj4gK0VY
UE9SVF9TWU1CT0xfR1BMKGZyZWVfaW92YV9mYXN0KTsKPiAgIAo+ICAgI2RlZmluZSBmcV9yaW5n
X2Zvcl9lYWNoKGksIGZxKSBcCj4gICAJZm9yICgoaSkgPSAoZnEpLT5oZWFkOyAoaSkgIT0gKGZx
KS0+dGFpbDsgKGkpID0gKChpKSArIDEpICUgSU9WQV9GUV9TSVpFKQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
