Return-Path: <SRS0=qwh6=M2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9F7C4338F
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 08:03:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43940600D1
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 08:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 43940600D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D63F04016B;
	Tue,  3 Aug 2021 08:03:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ed7Ghc7l2xn6; Tue,  3 Aug 2021 08:03:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8954C400E6;
	Tue,  3 Aug 2021 08:03:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57930C000E;
	Tue,  3 Aug 2021 08:03:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69897C001F
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 08:03:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 56DE26FB5B
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 08:03:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n_dAYVhzDzJ8 for <iommu@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 08:03:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 93DF46FB59
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 08:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627977791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oX9W5hbn1aUW9052DFy7xT6UwniQgZiOlZ+YGM5fx0A=;
 b=Tgx2ZEDu05zwbwPZ/ol20vI4SZNe73u1nokrvBNpDEkJbIif4gl7HTNDhQxgQpnWXmth8S
 39Tg67GLeM4ZI0VtIZfSiPmVHEQD0GDLU5QQdy5pQAImP4SbAbomfwB25QpkAX4Bt059e+
 KCBc9Y38UfvKASoWbmJ4oOAdoCxqiEY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-9CYOYD2MOa6SlaFp2GaCqw-1; Tue, 03 Aug 2021 04:03:08 -0400
X-MC-Unique: 9CYOYD2MOa6SlaFp2GaCqw-1
Received: by mail-pj1-f71.google.com with SMTP id
 o38-20020a17090a0a29b02901772cd97277so1973126pjo.0
 for <iommu@lists.linux-foundation.org>; Tue, 03 Aug 2021 01:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=oX9W5hbn1aUW9052DFy7xT6UwniQgZiOlZ+YGM5fx0A=;
 b=a/cVCEj7CCED7txICBVBemHuGa+Lnw+pfl7F0YoaWowLMTSilTr6okcGaKZ2/aecDX
 rnQMUx0x21yuFLExjVKhkhjnkURCf0fdg74hQhmOog/aBC7jJZ4ABpflich0A+y9oFwS
 XCObRRCEAG2oYrB8VdRGQFV/LRzuS/ukadS7hPoiWSU5+8DyZji3X+jjitjPxYK/LMpO
 mUL723Xc1cGD8dGkea8EGLtO+L5MHCMYy3iLe4aY59hSdYkWFXVQ4a4lfSTY5OyTFI5l
 lrx42FEjLlWURpPMYldy2dRhbFzNK6u9boUZsy6WkjMWJES4L4ECxKPdlogdX/zHwWHk
 UpCw==
X-Gm-Message-State: AOAM530Ixzkd6yJuj11Ado+AJAotAWvYQmO7DiZseu5yZUbZ2c42rXJ/
 1C9FZLLR4SjfVGleJtsi+7k6ZhV/dORJu4EOEWQ1f6Q+5HyQURdKqeNbQ5Qeh2iMJp0mmq4G7Xx
 aQQzjezmcvQzdVqqOlcvIWqawKJPMzw==
X-Received: by 2002:a17:90a:784e:: with SMTP id
 y14mr5429387pjl.185.1627977787238; 
 Tue, 03 Aug 2021 01:03:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQ/4OMNA4Jyj5oD4cflZM/wOKB+qV8HVYA0Mg+fxcM5s95sTutq8PhHECERUYS65XO/92FRw==
X-Received: by 2002:a17:90a:784e:: with SMTP id
 y14mr5429356pjl.185.1627977786975; 
 Tue, 03 Aug 2021 01:03:06 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id n20sm7442877pfv.212.2021.08.03.01.02.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Aug 2021 01:03:06 -0700 (PDT)
Subject: Re: [PATCH v10 07/17] virtio: Don't set FAILED status bit on device
 index allocation failure
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
 hch@infradead.org, christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com, joe@perches.com
References: <20210729073503.187-1-xieyongji@bytedance.com>
 <20210729073503.187-8-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <487ed840-f417-e1b6-edb3-15f19969de51@redhat.com>
Date: Tue, 3 Aug 2021 16:02:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210729073503.187-8-xieyongji@bytedance.com>
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

CtTaIDIwMjEvNy8yOSDPws7nMzozNCwgWGllIFlvbmdqaSDQtLXAOgo+IFdlIGRvbid0IG5lZWQg
dG8gc2V0IEZBSUxFRCBzdGF0dXMgYml0IG9uIGRldmljZSBpbmRleCBhbGxvY2F0aW9uCj4gZmFp
bHVyZSBzaW5jZSB0aGUgZGV2aWNlIGluaXRpYWxpemF0aW9uIGhhc24ndCBiZWVuIHN0YXJ0ZWQg
eWV0Lgo+IFRoaXMgZG9lc24ndCBhZmZlY3QgcnVudGltZSwgZm91bmQgaW4gY29kZSByZXZpZXcu
Cj4KPiBTaWduZWQtb2ZmLWJ5OiBYaWUgWW9uZ2ppIDx4aWV5b25namlAYnl0ZWRhbmNlLmNvbT4K
CgpEb2VzIGl0IHJlYWxseSBoYXJtPwoKVGhhbmtzCgoKPiAtLS0KPiAgIGRyaXZlcnMvdmlydGlv
L3ZpcnRpby5jIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvLmMgYi9kcml2
ZXJzL3ZpcnRpby92aXJ0aW8uYwo+IGluZGV4IDRiMTVjMDBjMGEwYS4uYTE1YmViNmI1OTNiIDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpby5jCj4gKysrIGIvZHJpdmVycy92aXJ0
aW8vdmlydGlvLmMKPiBAQCAtMzM4LDcgKzMzOCw3IEBAIGludCByZWdpc3Rlcl92aXJ0aW9fZGV2
aWNlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICpkZXYpCj4gICAJLyogQXNzaWduIGEgdW5pcXVlIGRl
dmljZSBpbmRleCBhbmQgaGVuY2UgbmFtZS4gKi8KPiAgIAllcnIgPSBpZGFfc2ltcGxlX2dldCgm
dmlydGlvX2luZGV4X2lkYSwgMCwgMCwgR0ZQX0tFUk5FTCk7Cj4gICAJaWYgKGVyciA8IDApCj4g
LQkJZ290byBvdXQ7Cj4gKwkJcmV0dXJuIGVycjsKPiAgIAo+ICAgCWRldi0+aW5kZXggPSBlcnI7
Cj4gICAJZGV2X3NldF9uYW1lKCZkZXYtPmRldiwgInZpcnRpbyV1IiwgZGV2LT5pbmRleCk7Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWls
aW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
