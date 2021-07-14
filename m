Return-Path: <SRS0=i+j8=MG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFC0C07E96
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 02:54:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84F0D6138C
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 02:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84F0D6138C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4D3DC400AE;
	Wed, 14 Jul 2021 02:54:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UV2Evz2dgAWl; Wed, 14 Jul 2021 02:54:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3EE254022D;
	Wed, 14 Jul 2021 02:54:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0CC8EC0010;
	Wed, 14 Jul 2021 02:54:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE47CC000E
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 02:54:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AB728406A6
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 02:54:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dsep3iyxSFWh for <iommu@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 02:54:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D73F2406A3
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 02:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626231263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L8YuQd5Ts4JNGV6wtOAvCK5EPGDYCcnR+6g/ZGfnDJI=;
 b=BAyyWUmPNx1uQ/8+GV32/pc5x7Rumus9OvFX2Q7B90oCLYtPc44dll/3Z8x+mKKhLLZR50
 hR5Wi8i4IUDn4vg2V6DQfFOMeXfphdBlbGLSyU4mGiRjcs9gA7jgeikELD0nEgfHgRpOOP
 x+hR3SO36L31sP8e+CjakIO3APs1AuQ=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-YmOiKiwCOVi1KSHmQYIJfg-1; Tue, 13 Jul 2021 22:54:22 -0400
X-MC-Unique: YmOiKiwCOVi1KSHmQYIJfg-1
Received: by mail-pg1-f198.google.com with SMTP id
 z30-20020a630a5e0000b029022c78a7fc98so413954pgk.11
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 19:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=L8YuQd5Ts4JNGV6wtOAvCK5EPGDYCcnR+6g/ZGfnDJI=;
 b=qlKNdYuk2cFd9XUS//T0mjtaxWdQVGkm6M2F7wvHjeahcQQsrRlkPWtFs+vQSI50Rr
 IvICe1msFb2pn5ZjWLwkxqk+VcMtpZG7yuQitKQOmi+gsvJVfkk/kG5ginwuA6g4N63J
 RAfxlJalsUGjCxHgllSjBYR6CJQp3j+Flif7178CbhGbby1mucFguShJCdP1Oxi3WJ3Y
 ieA+wl/9nteZ3H9EdxVpWrWsH30loDSsXkhu2udY6BKBoMLxpC4op3xO2Wu+0alV9Bwp
 mh6cO888SElhtIsmbEzvtgVvUKn7nZpQNi8IOQ5gOceLefE5VuYSNybs6u6LHt9kx4S1
 0yAA==
X-Gm-Message-State: AOAM530yD/iu0/rt1RN3aHzYnHr+8bbgrfE+Rtg3M3wicQp5fMi2wHMx
 wBEWVMZiOSjZFBYgu5xN3b4VnkJigwF3wvdtpc5TNWWgnHXZtLLnhvkFiijBUny056Ke9peLOYY
 ZU/4T1yAjQ6TvNkufwAVaS+LIr+FzlQ==
X-Received: by 2002:aa7:93cd:0:b029:328:9d89:a790 with SMTP id
 y13-20020aa793cd0000b02903289d89a790mr7769419pff.71.1626231261375; 
 Tue, 13 Jul 2021 19:54:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVcvRFQIHUh/wToTzbSqcRq399rxXFtmmAr5rDXhIuYW/QN+SkST9rmMlarwJcwx/uWSDVUw==
X-Received: by 2002:aa7:93cd:0:b029:328:9d89:a790 with SMTP id
 y13-20020aa793cd0000b02903289d89a790mr7769384pff.71.1626231260928; 
 Tue, 13 Jul 2021 19:54:20 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id v11sm494452pjs.13.2021.07.13.19.54.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jul 2021 19:54:20 -0700 (PDT)
Subject: Re: [PATCH v9 16/17] vduse: Introduce VDUSE - vDPA Device in Userspace
To: Dan Carpenter <dan.carpenter@oracle.com>,
 Xie Yongji <xieyongji@bytedance.com>
References: <20210713084656.232-1-xieyongji@bytedance.com>
 <20210713084656.232-17-xieyongji@bytedance.com> <20210713132741.GM1954@kadam>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c42979dd-331f-4af5-fda6-18d80f22be2d@redhat.com>
Date: Wed, 14 Jul 2021 10:54:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210713132741.GM1954@kadam>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, mst@redhat.com,
 virtualization@lists.linux-foundation.org, christian.brauner@canonical.com,
 corbet@lwn.net, willy@infradead.org, hch@infradead.org, sgarzare@redhat.com,
 xiaodong.liu@intel.com, viro@zeniv.linux.org.uk, stefanha@redhat.com,
 songmuchun@bytedance.com, axboe@kernel.dk, zhe.he@windriver.com,
 gregkh@linuxfoundation.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, bcrl@kvack.org,
 netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 mika.penttila@nextfour.com
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

CtTaIDIwMjEvNy8xMyDPws7nOToyNywgRGFuIENhcnBlbnRlciDQtLXAOgo+IE9uIFR1ZSwgSnVs
IDEzLCAyMDIxIGF0IDA0OjQ2OjU1UE0gKzA4MDAsIFhpZSBZb25namkgd3JvdGU6Cj4+ICtzdGF0
aWMgaW50IHZkdXNlX2Rldl9pbml0X3ZkcGEoc3RydWN0IHZkdXNlX2RldiAqZGV2LCBjb25zdCBj
aGFyICpuYW1lKQo+PiArewo+PiArCXN0cnVjdCB2ZHVzZV92ZHBhICp2ZGV2Owo+PiArCWludCBy
ZXQ7Cj4+ICsKPj4gKwlpZiAoZGV2LT52ZGV2KQo+PiArCQlyZXR1cm4gLUVFWElTVDsKPj4gKwo+
PiArCXZkZXYgPSB2ZHBhX2FsbG9jX2RldmljZShzdHJ1Y3QgdmR1c2VfdmRwYSwgdmRwYSwgZGV2
LT5kZXYsCj4+ICsJCQkJICZ2ZHVzZV92ZHBhX2NvbmZpZ19vcHMsIG5hbWUsIHRydWUpOwo+PiAr
CWlmICghdmRldikKPj4gKwkJcmV0dXJuIC1FTk9NRU07Cj4gVGhpcyBzaG91bGQgYmUgYW4gSVNf
RVJSKCkgY2hlY2sgaW5zdGVhZCBvZiBhIE5VTEwgY2hlY2suCgoKWWVzLgoKCj4KPiBUaGUgdmRw
YV9hbGxvY19kZXZpY2UoKSBtYWNybyBpcyBkb2luZyBzb21ldGhpbmcgdmVyeSBjb21wbGljYXRl
ZCBidXQKPiBJJ20gbm90IHN1cmUgd2hhdC4gIEl0IGNhbGxzIGNvbnRhaW5lcl9vZigpIGFuZCB0
aGF0IGxvb2tzIGJ1Z2d5IHVudGlsCj4geW91IHNwb3QgdGhlIEJVSUxEX0JVR19PTl9aRVJPKCkg
Y29tcGlsZSB0aW1lIGFzc2VydCB3aGljaCBlbnN1cmVzIHRoYXQKPiB0aGUgY29udGFpbmVyX29m
KCkgaXMgYSBuby1vcC4KPgo+IE9ubHkgb25lIG9mIHRoZSBjYWxsZXJzIGNoZWNrcyBmb3IgZXJy
b3IgcG9pbnRlcnMgY29ycmVjdGx5IHNvIG1heWJlCj4gaXQncyB0b28gY29tcGxpY2F0ZWQgb3Ig
bWF5YmUgdGhlcmUgc2hvdWxkIGJlIGJldHRlciBkb2N1bWVudGF0aW9uLgoKCldlIG5lZWQgYmV0
dGVyIGRvY3VtZW50YXRpb24gZm9yIHRoaXMgbWFjcm8gYW5kIGZpeCBhbGwgdGhlIGJ1Z2d5IGNh
bGxlcnMuCgpZb25nIEppLCB3YW50IHRvIGRvIHRoYXQ/CgpUaGFua3MKCgo+Cj4gcmVnYXJkcywK
PiBkYW4gY2FycGVudGVyCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9p
b21tdQ==
