Return-Path: <SRS0=qwh6=M2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E20C4320A
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 07:51:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9794460462
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 07:51:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9794460462
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6AD3A60759;
	Tue,  3 Aug 2021 07:51:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3Gjl-auRLuA4; Tue,  3 Aug 2021 07:51:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3646160749;
	Tue,  3 Aug 2021 07:51:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A75C4C0020;
	Tue,  3 Aug 2021 07:51:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85D0EC0010
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 07:51:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5FFE082FC9
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 07:51:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ia9GbuuSEYde for <iommu@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 07:51:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9DB8082BFD
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 07:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627977063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oYcam7agTFSd/2Q6NOTWlhklTs5e2KArUsWMeCcGGAM=;
 b=EMcXnNi7pseC2lWIAHprEpFXKWxoOZk7vy6t0tPfE2Nzu6nzePZAywdxrqDIF7POxN3DMd
 5FdNi/ZLTvQvj7lHslfDs9uMiLoYjaCDkB3MV+leAr0q1e8eaeiELUVWzLV8EGKBKBejM4
 BohK47Q3pMzqLaoUeO2I5H9XRscnMSo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-A0vXZmKrM-CbZgxwgsswMg-1; Tue, 03 Aug 2021 03:51:00 -0400
X-MC-Unique: A0vXZmKrM-CbZgxwgsswMg-1
Received: by mail-pj1-f69.google.com with SMTP id
 on10-20020a17090b1d0ab029017773c0b9aeso2211025pjb.1
 for <iommu@lists.linux-foundation.org>; Tue, 03 Aug 2021 00:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=oYcam7agTFSd/2Q6NOTWlhklTs5e2KArUsWMeCcGGAM=;
 b=FZ+h/5mZGBAjx2Z6t8lj0s8/FA5D8XFvG0Ue5dYvjf1ueXlqRVEeuJYseOvCIp8Nmo
 T2SMnljV85P9fMqvuCdjH0nwzBU/wyhbiJyAJMMLaDOwRqo7305GGTMcc2+/oZx6g786
 dGPd5hk/flkuhsaAbNjG11Iw5cfX7/hC8H0BKhn4wwKzoA2CigMG5TVt5VuDyF/wJG/a
 WmjMsEVsYOBs9QkgsrYnPKOc4JACgkYmwyuQmcqnDTDj8asjaA+byehbzDlLfP8uzTDk
 ZD86kpUvNUzC0cvMEyOEHnTspLJ8DQyEuWRMnSOGrHtUt1QnhRLgVmN8no2RXmK1e6Ux
 RoIA==
X-Gm-Message-State: AOAM531kr6KVQ+Xj62YvHEj+BdoO7vnqmZ/YxZ2/gZ766a6GSKgG2hzu
 QqyF/S5r1rCdH1oxY9J4SuG2bP4LkrkL9HBL4k/PGSO/6xFVtXX6n5URaeSkfkzLIOHnD7V77Zc
 R6VtzPr8QggLsRahsuhpxoBeL1XGgAw==
X-Received: by 2002:a05:6a00:a8a:b029:356:be61:7f18 with SMTP id
 b10-20020a056a000a8ab0290356be617f18mr20640885pfl.29.1627977059222; 
 Tue, 03 Aug 2021 00:50:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLduE7LXN7Wln37TgSE39sEWlhyZA9xOCP4JLoPOJrBqHBCOe6D/dpJAaC4v4en3vOIVKYWw==
X-Received: by 2002:a05:6a00:a8a:b029:356:be61:7f18 with SMTP id
 b10-20020a056a000a8ab0290356be617f18mr20640860pfl.29.1627977058989; 
 Tue, 03 Aug 2021 00:50:58 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 98sm13139744pjo.26.2021.08.03.00.50.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Aug 2021 00:50:58 -0700 (PDT)
Subject: Re: [PATCH v10 03/17] vdpa: Fix code indentation
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
 hch@infradead.org, christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com, joe@perches.com
References: <20210729073503.187-1-xieyongji@bytedance.com>
 <20210729073503.187-4-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <aaf82d3f-05e3-13d5-3a63-52cd8045b4c6@redhat.com>
Date: Tue, 3 Aug 2021 15:50:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210729073503.187-4-xieyongji@bytedance.com>
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

CtTaIDIwMjEvNy8yOSDPws7nMzozNCwgWGllIFlvbmdqaSDQtLXAOgo+IFVzZSB0YWJzIHRvIGlu
ZGVudCB0aGUgY29kZSBpbnN0ZWFkIG9mIHNwYWNlcy4KPgo+IFNpZ25lZC1vZmYtYnk6IFhpZSBZ
b25namkgPHhpZXlvbmdqaUBieXRlZGFuY2UuY29tPgo+IC0tLQo+ICAgaW5jbHVkZS9saW51eC92
ZHBhLmggfCAyOSArKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDE0IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQoKCkl0IGxvb2tzIHRvIG1lIG5v
dCBhbGwgdGhlIHdhcm5pbmdzIGFyZSBhZGRyZXNzZWQuCgpPciBkaWQgeW91IHNpbGVudCBjaGVj
a3BhdGNoLnBsIC1mPwoKVGhhbmtzCgoKPgo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3Zk
cGEuaCBiL2luY2x1ZGUvbGludXgvdmRwYS5oCj4gaW5kZXggN2M0OWJjNWEyYjcxLi40MDZkNTNh
NjA2YWMgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9saW51eC92ZHBhLmgKPiArKysgYi9pbmNsdWRl
L2xpbnV4L3ZkcGEuaAo+IEBAIC00MywxNyArNDMsMTcgQEAgc3RydWN0IHZkcGFfdnFfc3RhdGVf
c3BsaXQgewo+ICAgICogQGxhc3RfdXNlZF9pZHg6IHVzZWQgaW5kZXgKPiAgICAqLwo+ICAgc3Ry
dWN0IHZkcGFfdnFfc3RhdGVfcGFja2VkIHsKPiAtICAgICAgICB1MTYJbGFzdF9hdmFpbF9jb3Vu
dGVyOjE7Cj4gLSAgICAgICAgdTE2CWxhc3RfYXZhaWxfaWR4OjE1Owo+IC0gICAgICAgIHUxNgls
YXN0X3VzZWRfY291bnRlcjoxOwo+IC0gICAgICAgIHUxNglsYXN0X3VzZWRfaWR4OjE1Owo+ICsJ
dTE2CWxhc3RfYXZhaWxfY291bnRlcjoxOwo+ICsJdTE2CWxhc3RfYXZhaWxfaWR4OjE1Owo+ICsJ
dTE2CWxhc3RfdXNlZF9jb3VudGVyOjE7Cj4gKwl1MTYJbGFzdF91c2VkX2lkeDoxNTsKPiAgIH07
Cj4gICAKPiAgIHN0cnVjdCB2ZHBhX3ZxX3N0YXRlIHsKPiAtICAgICB1bmlvbiB7Cj4gLSAgICAg
ICAgICBzdHJ1Y3QgdmRwYV92cV9zdGF0ZV9zcGxpdCBzcGxpdDsKPiAtICAgICAgICAgIHN0cnVj
dCB2ZHBhX3ZxX3N0YXRlX3BhY2tlZCBwYWNrZWQ7Cj4gLSAgICAgfTsKPiArCXVuaW9uIHsKPiAr
CQlzdHJ1Y3QgdmRwYV92cV9zdGF0ZV9zcGxpdCBzcGxpdDsKPiArCQlzdHJ1Y3QgdmRwYV92cV9z
dGF0ZV9wYWNrZWQgcGFja2VkOwo+ICsJfTsKPiAgIH07Cj4gICAKPiAgIHN0cnVjdCB2ZHBhX21n
bXRfZGV2Owo+IEBAIC0xMzEsNyArMTMxLDcgQEAgc3RydWN0IHZkcGFfaW92YV9yYW5nZSB7Cj4g
ICAgKgkJCQlAdmRldjogdmRwYSBkZXZpY2UKPiAgICAqCQkJCUBpZHg6IHZpcnRxdWV1ZSBpbmRl
eAo+ICAgICoJCQkJQHN0YXRlOiBwb2ludGVyIHRvIHJldHVybmVkIHN0YXRlIChsYXN0X2F2YWls
X2lkeCkKPiAtICogQGdldF92cV9ub3RpZmljYXRpb246IAlHZXQgdGhlIG5vdGlmaWNhdGlvbiBh
cmVhIGZvciBhIHZpcnRxdWV1ZQo+ICsgKiBAZ2V0X3ZxX25vdGlmaWNhdGlvbjoJR2V0IHRoZSBu
b3RpZmljYXRpb24gYXJlYSBmb3IgYSB2aXJ0cXVldWUKPiAgICAqCQkJCUB2ZGV2OiB2ZHBhIGRl
dmljZQo+ICAgICoJCQkJQGlkeDogdmlydHF1ZXVlIGluZGV4Cj4gICAgKgkJCQlSZXR1cm5zIHRo
ZSBub3RpZmNhdGlvbiBhcmVhCj4gQEAgLTM0MiwyNSArMzQyLDI0IEBAIHN0YXRpYyBpbmxpbmUg
c3RydWN0IGRldmljZSAqdmRwYV9nZXRfZG1hX2RldihzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYp
Cj4gICAKPiAgIHN0YXRpYyBpbmxpbmUgdm9pZCB2ZHBhX3Jlc2V0KHN0cnVjdCB2ZHBhX2Rldmlj
ZSAqdmRldikKPiAgIHsKPiAtICAgICAgICBjb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzICpv
cHMgPSB2ZGV2LT5jb25maWc7Cj4gKwljb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzICpvcHMg
PSB2ZGV2LT5jb25maWc7Cj4gICAKPiAgIAl2ZGV2LT5mZWF0dXJlc192YWxpZCA9IGZhbHNlOwo+
IC0gICAgICAgIG9wcy0+c2V0X3N0YXR1cyh2ZGV2LCAwKTsKPiArCW9wcy0+c2V0X3N0YXR1cyh2
ZGV2LCAwKTsKPiAgIH0KPiAgIAo+ICAgc3RhdGljIGlubGluZSBpbnQgdmRwYV9zZXRfZmVhdHVy
ZXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1NjQgZmVhdHVyZXMpCj4gICB7Cj4gLSAgICAg
ICAgY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyAqb3BzID0gdmRldi0+Y29uZmlnOwo+ICsJ
Y29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyAqb3BzID0gdmRldi0+Y29uZmlnOwo+ICAgCj4g
ICAJdmRldi0+ZmVhdHVyZXNfdmFsaWQgPSB0cnVlOwo+IC0gICAgICAgIHJldHVybiBvcHMtPnNl
dF9mZWF0dXJlcyh2ZGV2LCBmZWF0dXJlcyk7Cj4gKwlyZXR1cm4gb3BzLT5zZXRfZmVhdHVyZXMo
dmRldiwgZmVhdHVyZXMpOwo+ICAgfQo+ICAgCj4gLQo+ICAgc3RhdGljIGlubGluZSB2b2lkIHZk
cGFfZ2V0X2NvbmZpZyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHVuc2lnbmVkIG9mZnNldCwK
PiAgIAkJCQkgICB2b2lkICpidWYsIHVuc2lnbmVkIGludCBsZW4pCj4gICB7Cj4gLSAgICAgICAg
Y29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyAqb3BzID0gdmRldi0+Y29uZmlnOwo+ICsJY29u
c3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyAqb3BzID0gdmRldi0+Y29uZmlnOwo+ICAgCj4gICAJ
LyoKPiAgIAkgKiBDb25maWcgYWNjZXNzZXMgYXJlbid0IHN1cHBvc2VkIHRvIHRyaWdnZXIgYmVm
b3JlIGZlYXR1cmVzIGFyZSBzZXQuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vaW9tbXU=
