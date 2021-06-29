Return-Path: <SRS0=I0uF=LX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205E2C11F65
	for <iommu@archiver.kernel.org>; Tue, 29 Jun 2021 03:29:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B557361D1C
	for <iommu@archiver.kernel.org>; Tue, 29 Jun 2021 03:29:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B557361D1C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7EA4340276;
	Tue, 29 Jun 2021 03:29:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g9JyFxs377Zk; Tue, 29 Jun 2021 03:29:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6DAD340376;
	Tue, 29 Jun 2021 03:29:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2740CC0010;
	Tue, 29 Jun 2021 03:29:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E28EC000E
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 03:29:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8D3CF8318C
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 03:29:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x_2hHtPQzbEm for <iommu@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 03:29:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7063E830DE
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 03:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624937381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Pa1pOlVAvZjnb70QATIYkocaWNNRWiFDRdCDmMIsd8=;
 b=gDqfj9rX8rqZCojYY0oHCfBhS/e0zviI0vG5ixXtKXz9pa09e3jgiY93XCagKHEM9BwBvh
 LbJ+bSCFYjIsDMqIBjGafHHTTklf+NHwX4DKd4K9pdoePlVZeEqSngYs31FekOusBPMmV+
 rYqOLxQs0cHhMLR5XvXT3HssUYfLrmY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-42ihc7qPMeG9IhYGiKQKhA-1; Mon, 28 Jun 2021 23:29:39 -0400
X-MC-Unique: 42ihc7qPMeG9IhYGiKQKhA-1
Received: by mail-pj1-f70.google.com with SMTP id
 u8-20020a17090a8908b029016f79b38655so1306789pjn.8
 for <iommu@lists.linux-foundation.org>; Mon, 28 Jun 2021 20:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=2Pa1pOlVAvZjnb70QATIYkocaWNNRWiFDRdCDmMIsd8=;
 b=qCt8YXb5yrfZeMw0+TK/bzobpYRde5ir6ZqATmq5gkSnnO61w+aQ5VExCd4ozpgwst
 qYoZLy9YXfYS2PU1kYyxFOJPi2hohgtTppBIxj7bvoEvc8BCB6UFV3zwObBlGuyZpCTp
 wMuXpuEMhRKUXUm9l9ySNtqEvTLogqSfBmqD3Ci+1PU5q1B3fNbEENgmzu9h32RscSMI
 tw0R8PLRqocGDiAHTH95eCkfZCsOPY5lgQ3GXO1hn/T+EnryylOhVOuMkhgLc53wcjFE
 HtAa8zFME/UQVAyPDLY9XQcEMLdXaPJomF8jbl3cbFITKqew6y8EHmLIt1ZNMyND/nXg
 5uVw==
X-Gm-Message-State: AOAM5324YADZJt/Anxa2c9Z0ireC4ryaka7pN5iCGXkVvn1aJkOXH5li
 cmdLCZCcSxWFjjOfzn0kcokJHYI9NcMvktkU3VZ4nzFsKb7WI7z7qxDp0je5zWABJUXMiG+YAmK
 Y3QavGBySi6iIFteW+VHwj9JrWDpxXA==
X-Received: by 2002:a05:6a00:1742:b029:308:add4:e844 with SMTP id
 j2-20020a056a001742b0290308add4e844mr24162942pfc.18.1624937378600; 
 Mon, 28 Jun 2021 20:29:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwry9N+QCFjvNGydIUFQnfZliYwOwU3q6M/FQals9i/JHLqA6RP5KnmC4UjhvxUQDox0iXaLQ==
X-Received: by 2002:a05:6a00:1742:b029:308:add4:e844 with SMTP id
 j2-20020a056a001742b0290308add4e844mr24162907pfc.18.1624937378357; 
 Mon, 28 Jun 2021 20:29:38 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id w21sm1920153pge.30.2021.06.28.20.29.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jun 2021 20:29:37 -0700 (PDT)
Subject: Re: [PATCH v8 09/10] vduse: Introduce VDUSE - vDPA Device in Userspace
To: Yongji Xie <xieyongji@bytedance.com>
References: <20210615141331.407-1-xieyongji@bytedance.com>
 <CACycT3tAON+-qZev+9EqyL2XbgH5HDspOqNt3ohQLQ8GqVK=EA@mail.gmail.com>
 <1bba439f-ffc8-c20e-e8a4-ac73e890c592@redhat.com>
 <CACycT3uzMJS7vw6MVMOgY4rb=SPfT2srV+8DPdwUVeELEiJgbA@mail.gmail.com>
 <0aeb7cb7-58e5-1a95-d830-68edd7e8ec2e@redhat.com>
 <CACycT3uuooKLNnpPHewGZ=q46Fap2P4XCFirdxxn=FxK+X1ECg@mail.gmail.com>
 <e4cdee72-b6b4-d055-9aac-3beae0e5e3e1@redhat.com>
 <CACycT3u8=_D3hCtJR+d5BgeUQMce6S7c_6P3CVfvWfYhCQeXFA@mail.gmail.com>
 <d2334f66-907c-2e9c-ea4f-f912008e9be8@redhat.com>
 <CACycT3uCSLUDVpQHdrmuxSuoBDg-4n22t+N-Jm2GoNNp9JYB2w@mail.gmail.com>
 <48cab125-093b-2299-ff9c-3de8c7c5ed3d@redhat.com>
 <CACycT3tS=10kcUCNGYm=dUZsK+vrHzDvB3FSwAzuJCu3t+QuUQ@mail.gmail.com>
 <b10b3916-74d4-3171-db92-be0afb479a1c@redhat.com>
 <CACycT3vpMFbc9Fzuo9oksMaA-pVb1dEVTEgjNoft16voryPSWQ@mail.gmail.com>
 <d7e42109-0ba6-3e1a-c42a-898b6f33c089@redhat.com>
 <CACycT3u9-id2DxPpuVLtyg4tzrUF9xCAGr7nBm=21HfUJJasaQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e82766ff-dc6b-2cbb-3504-0ef618d538e2@redhat.com>
Date: Tue, 29 Jun 2021 11:29:25 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CACycT3u9-id2DxPpuVLtyg4tzrUF9xCAGr7nBm=21HfUJJasaQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christian Brauner <christian.brauner@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Stefan Hajnoczi <stefanha@redhat.com>, songmuchun@bytedance.com,
 Jens Axboe <axboe@kernel.dk>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 bcrl@kvack.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
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

CuWcqCAyMDIxLzYvMjkg5LiK5Y2IMTA6MjYsIFlvbmdqaSBYaWUg5YaZ6YGTOgo+IE9uIE1vbiwg
SnVuIDI4LCAyMDIxIGF0IDEyOjQwIFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+
IHdyb3RlOgo+Pgo+PiDlnKggMjAyMS82LzI1IOS4i+WNiDEyOjE5LCBZb25namkgWGllIOWGmemB
kzoKPj4+PiAyYikgZm9yIHNldF9zdGF0dXMoKTogc2ltcGx5IHJlbGF5IHRoZSBtZXNzYWdlIHRv
IHVzZXJzcGFjZSwgcmVwbHkgaXMgbm8KPj4+PiBuZWVkZWQuIFVzZXJzcGFjZSB3aWxsIHVzZSBh
IGNvbW1hbmQgdG8gdXBkYXRlIHRoZSBzdGF0dXMgd2hlbiB0aGUKPj4+PiBkYXRhcGF0aCBpcyBz
dG9wLiBUaGUgdGhlIHN0YXR1cyBjb3VsZCBiZSBmZXRjaGVkIHZpYSBnZXRfc3RhdHMoKS4KPj4+
Pgo+Pj4+IDJiIGxvb2tzIG1vcmUgc3BlYyBjb21wbGFpbnQuCj4+Pj4KPj4+IExvb2tzIGdvb2Qg
dG8gbWUuIEFuZCBJIHRoaW5rIHdlIGNhbiB1c2UgdGhlIHJlcGx5IG9mIHRoZSBtZXNzYWdlIHRv
Cj4+PiB1cGRhdGUgdGhlIHN0YXR1cyBpbnN0ZWFkIG9mIGludHJvZHVjaW5nIGEgbmV3IGNvbW1h
bmQuCj4+Pgo+PiBKdXN0IG5vdGljZSB0aGlzIHBhcnQgaW4gdmlydGlvX2ZpbmFsaXplX2ZlYXR1
cmVzKCk6Cj4+Cj4+ICAgICAgICAgICB2aXJ0aW9fYWRkX3N0YXR1cyhkZXYsIFZJUlRJT19DT05G
SUdfU19GRUFUVVJFU19PSyk7Cj4+ICAgICAgICAgICBzdGF0dXMgPSBkZXYtPmNvbmZpZy0+Z2V0
X3N0YXR1cyhkZXYpOwo+PiAgICAgICAgICAgaWYgKCEoc3RhdHVzICYgVklSVElPX0NPTkZJR19T
X0ZFQVRVUkVTX09LKSkgewo+Pgo+PiBTbyB3ZSBubyByZXBseSBkb2Vzbid0IHdvcmsgZm9yIEZF
QVRVUkVTX09LLgo+Pgo+PiBTbyBteSB1bmRlcnN0YW5kaW5nIGlzOgo+Pgo+PiAxKSBXZSBtdXN0
IG5vdCB1c2Ugbm9yZXBseSBmb3Igc2V0X3N0YXR1cygpCj4+IDIpIFdlIGNhbiB1c2Ugbm9yZXBs
eSBmb3IgZ2V0X3N0YXR1cygpLCBidXQgaXQgcmVxdWlyZXMgYSBuZXcgaW9jdGwgdG8KPj4gdXBk
YXRlIHRoZSBzdGF0dXMuCj4+Cj4+IFNvIGl0IGxvb2tzIHRvIG1lIHdlIG5lZWQgc3luY2hyb25p
emUgZm9yIGJvdGggZ2V0X3N0YXR1cygpIGFuZAo+PiBzZXRfc3RhdHVzKCkuCj4+Cj4gV2Ugc2hv
dWxkIG5vdCBzZW5kIG1lc3NhZ2VzIHRvIHVzZXJzcGFjZSBpbiB0aGUgRkVBVFVSRVNfT0sgY2Fz
ZS4gU28KPiB0aGUgc3luY2hyb25pemF0aW9uIGlzIG5vdCBuZWNlc3NhcnkuCgoKQXMgZGlzY3Vz
c2VkIHByZXZpb3VzbHksIHRoZXJlIGNvdWxkIGJlIGEgZGV2aWNlIHRoYXQgbWFuZGF0ZXMgc29t
ZSAKZmVhdHVyZXMgKFZJUlRJT19GX1JJTkdfUEFDS0VEKS4gU28gaXQgY2FuIGNob29zZSB0byBu
b3QgYWNjZXB0IApGRUFUVVJFU19PSyBpcyBwYWNrZWQgdmlydHF1ZXVlIGlzIG5vdCBuZWdvdGlh
dGVkLgoKSW4gdGhpcyBjYXNlIHdlIG5lZWQgdG8gcmVsYXkgdGhlIG1lc3NhZ2UgdG8gdXNlcnNw
YWNlLgoKVGhhbmtzCgoKPgo+IFRoYW5rcywKPiBZb25namkKPgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
