Return-Path: <SRS0=Bvs7=NO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114F6C432BE
	for <iommu@archiver.kernel.org>; Mon, 23 Aug 2021 06:31:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94E6F6127B
	for <iommu@archiver.kernel.org>; Mon, 23 Aug 2021 06:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 94E6F6127B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C09380D9F;
	Mon, 23 Aug 2021 06:31:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3vYshOaP2_Ah; Mon, 23 Aug 2021 06:31:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4A89E80DB0;
	Mon, 23 Aug 2021 06:31:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25B3CC001A;
	Mon, 23 Aug 2021 06:31:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3CAB2C000E
 for <iommu@lists.linux-foundation.org>; Mon, 23 Aug 2021 06:31:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1BBC660727
 for <iommu@lists.linux-foundation.org>; Mon, 23 Aug 2021 06:31:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ilBLdXGnrUYF for <iommu@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 06:31:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E705C606E6
 for <iommu@lists.linux-foundation.org>; Mon, 23 Aug 2021 06:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629700290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AUHa3Avm2+6fKkcYKeAqHdN474qgV/5/pGdz9tfcqgE=;
 b=KsrTGxScqxgHrvD9gwibNM8BRprAxQll/f5z8b+U6xo//EWPtKQELS7IOA5v3dNw4ElrBQ
 JMvxVPEqJZpOPe7LxJtjyQ24Re+cXqv2kDNUmzU508B8doukSkKNm7Zr0gRuXiwmaHfDVN
 SyXLqf7aX7pyRk21TJ3pRMzjrxjLnRk=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-AyO5775RML-7oW0Y_rWd9A-1; Mon, 23 Aug 2021 02:31:27 -0400
X-MC-Unique: AyO5775RML-7oW0Y_rWd9A-1
Received: by mail-pf1-f198.google.com with SMTP id
 x18-20020a056a000bd200b003e14701b71dso8178090pfu.21
 for <iommu@lists.linux-foundation.org>; Sun, 22 Aug 2021 23:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=AUHa3Avm2+6fKkcYKeAqHdN474qgV/5/pGdz9tfcqgE=;
 b=OdaOIKe+s8yOFtrR/my/QBpvGs1qwmcQ1jp/MstMoybRQ008DVCArtdBfEtkzkCcAn
 X2ZjtGKjJPGiAeXAsbocE4IfhdwQWLR77hf7EXIpP3NaVmgSBpPXj3H48UjSd3L+PV/X
 Bc8tGnihbfinbXWtryXzygA/NkPBw+psL2tA7h9jpctWE/VVo4OVE6vdBoIzMEsvz9kl
 SbSwTYSOOHj+ZP5UXw5M+wsCxCsbDSOnxN4grrfjdf4SK4XitSF+IxACTH2UUDHmWcMK
 F0kA4S2hvrIk7UERq7riLTXzMyY+yUC0atEt9pfCj60KK/kBUEjAmFfnFzeBItBnJWuz
 QkQQ==
X-Gm-Message-State: AOAM530HCNeaAPAwhDlkXFfbZ0bgytHMq3+y/VhY2jcYNoHNG9c5cH8B
 m7/0NprEl/dRH7lCZms9WGpOT6CPLuOq81O8kKPnrFJCT0OhU5FFEghjTfl45MtJ6O2yVNMWbLL
 JWN0ueB2PjreyeQ66WZcwjbrw0JMO4Q==
X-Received: by 2002:aa7:8b0a:0:b0:3e1:2df9:d827 with SMTP id
 f10-20020aa78b0a000000b003e12df9d827mr31726463pfd.67.1629700286611; 
 Sun, 22 Aug 2021 23:31:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyz38m1FHbtQPPoBW5Z1aB8WuAIQK8sTxgnijH4Tg0S/NrYwdHny5cJXtC/iUOPx4pNk0Ak/A==
X-Received: by 2002:aa7:8b0a:0:b0:3e1:2df9:d827 with SMTP id
 f10-20020aa78b0a000000b003e12df9d827mr31726432pfd.67.1629700286415; 
 Sun, 22 Aug 2021 23:31:26 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id g85sm6392736pfb.172.2021.08.22.23.31.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Aug 2021 23:31:25 -0700 (PDT)
Subject: Re: [PATCH v11 04/12] vdpa: Add reset callback in vdpa_config_ops
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
 hch@infradead.org, christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com, joe@perches.com,
 robin.murphy@arm.com
References: <20210818120642.165-1-xieyongji@bytedance.com>
 <20210818120642.165-5-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4470fdac-89fb-1216-78d7-6335c3bfeb22@redhat.com>
Date: Mon, 23 Aug 2021 14:31:16 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210818120642.165-5-xieyongji@bytedance.com>
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

CtTaIDIwMjEvOC8xOCDPws7nODowNiwgWGllIFlvbmdqaSDQtLXAOgo+IFRoaXMgYWRkcyBhIG5l
dyBjYWxsYmFjayB0byBzdXBwb3J0IGRldmljZSBzcGVjaWZpYyByZXNldAo+IGJlaGF2aW9yLiBU
aGUgdmRwYSBidXMgZHJpdmVyIHdpbGwgY2FsbCB0aGUgcmVzZXQgZnVuY3Rpb24KPiBpbnN0ZWFk
IG9mIHNldHRpbmcgc3RhdHVzIHRvIHplcm8gZHVyaW5nIHJlc2V0dGluZyBpZiBkZXZpY2UKPiBk
cml2ZXIgc3VwcG9ydHMgdGhlIG5ldyBjYWxsYmFjay4KPgo+IFNpZ25lZC1vZmYtYnk6IFhpZSBZ
b25namkgPHhpZXlvbmdqaUBieXRlZGFuY2UuY29tPgo+IC0tLQo+ICAgZHJpdmVycy92aG9zdC92
ZHBhLmMgfCAgOSArKysrKysrLS0KPiAgIGluY2x1ZGUvbGludXgvdmRwYS5oIHwgMTEgKysrKysr
KysrKy0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMo
LSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhvc3Qv
dmRwYS5jCj4gaW5kZXggYjA3YWExNjFmN2FkLi5iMWM5MWI0ZGIwYmEgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy92aG9zdC92ZHBhLmMKPiArKysgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+IEBAIC0x
NTcsNyArMTU3LDcgQEAgc3RhdGljIGxvbmcgdmhvc3RfdmRwYV9zZXRfc3RhdHVzKHN0cnVjdCB2
aG9zdF92ZHBhICp2LCB1OCBfX3VzZXIgKnN0YXR1c3ApCj4gICAJc3RydWN0IHZkcGFfZGV2aWNl
ICp2ZHBhID0gdi0+dmRwYTsKPiAgIAljb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzICpvcHMg
PSB2ZHBhLT5jb25maWc7Cj4gICAJdTggc3RhdHVzLCBzdGF0dXNfb2xkOwo+IC0JaW50IG52cXMg
PSB2LT5udnFzOwo+ICsJaW50IHJldCwgbnZxcyA9IHYtPm52cXM7Cj4gICAJdTE2IGk7Cj4gICAK
PiAgIAlpZiAoY29weV9mcm9tX3VzZXIoJnN0YXR1cywgc3RhdHVzcCwgc2l6ZW9mKHN0YXR1cykp
KQo+IEBAIC0xNzIsNyArMTcyLDEyIEBAIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfc2V0X3N0YXR1
cyhzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwgdTggX191c2VyICpzdGF0dXNwKQo+ICAgCWlmIChzdGF0
dXMgIT0gMCAmJiAob3BzLT5nZXRfc3RhdHVzKHZkcGEpICYgfnN0YXR1cykgIT0gMCkKPiAgIAkJ
cmV0dXJuIC1FSU5WQUw7Cj4gICAKPiAtCW9wcy0+c2V0X3N0YXR1cyh2ZHBhLCBzdGF0dXMpOwo+
ICsJaWYgKHN0YXR1cyA9PSAwICYmIG9wcy0+cmVzZXQpIHsKPiArCQlyZXQgPSBvcHMtPnJlc2V0
KHZkcGEpOwo+ICsJCWlmIChyZXQpCj4gKwkJCXJldHVybiByZXQ7Cj4gKwl9IGVsc2UKPiArCQlv
cHMtPnNldF9zdGF0dXModmRwYSwgc3RhdHVzKTsKPiAgIAo+ICAgCWlmICgoc3RhdHVzICYgVklS
VElPX0NPTkZJR19TX0RSSVZFUl9PSykgJiYgIShzdGF0dXNfb2xkICYgVklSVElPX0NPTkZJR19T
X0RSSVZFUl9PSykpCj4gICAJCWZvciAoaSA9IDA7IGkgPCBudnFzOyBpKyspCj4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgvdmRwYS5oIGIvaW5jbHVkZS9saW51eC92ZHBhLmgKPiBpbmRleCA4
YTY0NWY4ZjQ0NzYuLmFmN2VhNWFkNzk1ZiAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3Zk
cGEuaAo+ICsrKyBiL2luY2x1ZGUvbGludXgvdmRwYS5oCj4gQEAgLTE5Niw2ICsxOTYsOSBAQCBz
dHJ1Y3QgdmRwYV9pb3ZhX3JhbmdlIHsKPiAgICAqCQkJCUB2ZGV2OiB2ZHBhIGRldmljZQo+ICAg
ICoJCQkJUmV0dXJucyB0aGUgaW92YSByYW5nZSBzdXBwb3J0ZWQgYnkKPiAgICAqCQkJCXRoZSBk
ZXZpY2UuCj4gKyAqIEByZXNldDoJCQlSZXNldCBkZXZpY2UgKG9wdGlvbmFsKQo+ICsgKgkJCQlA
dmRldjogdmRwYSBkZXZpY2UKPiArICoJCQkJUmV0dXJucyBpbnRlZ2VyOiBzdWNjZXNzICgwKSBv
ciBlcnJvciAoPCAwKQoKCkl0IGxvb2tzIHRvIG1lIHdlJ2QgYmV0dGVyIG1ha2UgdGhpcyBtYW5k
YXRvcnkuIFRoaXMgaGVscCB0byByZWR1Y2UgdGhlIApjb25mdXNpb24gZm9yIHRoZSBwYXJlbnQg
ZHJpdmVyLgoKVGhhbmtzCgoKPiAgICAqIEBzZXRfbWFwOgkJCVNldCBkZXZpY2UgbWVtb3J5IG1h
cHBpbmcgKG9wdGlvbmFsKQo+ICAgICoJCQkJTmVlZGVkIGZvciBkZXZpY2UgdGhhdCB1c2luZyBk
ZXZpY2UKPiAgICAqCQkJCXNwZWNpZmljIERNQSB0cmFuc2xhdGlvbiAob24tY2hpcCBJT01NVSkK
PiBAQCAtMjYzLDYgKzI2Niw3IEBAIHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgewo+ICAgCQkJICAg
Y29uc3Qgdm9pZCAqYnVmLCB1bnNpZ25lZCBpbnQgbGVuKTsKPiAgIAl1MzIgKCpnZXRfZ2VuZXJh
dGlvbikoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2KTsKPiAgIAlzdHJ1Y3QgdmRwYV9pb3ZhX3Jh
bmdlICgqZ2V0X2lvdmFfcmFuZ2UpKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldik7Cj4gKwlpbnQg
KCpyZXNldCkoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2KTsKPiAgIAo+ICAgCS8qIERNQSBvcHMg
Ki8KPiAgIAlpbnQgKCpzZXRfbWFwKShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHN0cnVjdCB2
aG9zdF9pb3RsYiAqaW90bGIpOwo+IEBAIC0zNTEsMTIgKzM1NSwxNyBAQCBzdGF0aWMgaW5saW5l
IHN0cnVjdCBkZXZpY2UgKnZkcGFfZ2V0X2RtYV9kZXYoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2
KQo+ICAgCXJldHVybiB2ZGV2LT5kbWFfZGV2Owo+ICAgfQo+ICAgCj4gLXN0YXRpYyBpbmxpbmUg
dm9pZCB2ZHBhX3Jlc2V0KHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldikKPiArc3RhdGljIGlubGlu
ZSBpbnQgdmRwYV9yZXNldChzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYpCj4gICB7Cj4gICAJY29u
c3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyAqb3BzID0gdmRldi0+Y29uZmlnOwo+ICAgCj4gICAJ
dmRldi0+ZmVhdHVyZXNfdmFsaWQgPSBmYWxzZTsKPiArCWlmIChvcHMtPnJlc2V0KQo+ICsJCXJl
dHVybiBvcHMtPnJlc2V0KHZkZXYpOwo+ICsKPiAgIAlvcHMtPnNldF9zdGF0dXModmRldiwgMCk7
Cj4gKwo+ICsJcmV0dXJuIDA7Cj4gICB9Cj4gICAKPiAgIHN0YXRpYyBpbmxpbmUgaW50IHZkcGFf
c2V0X2ZlYXR1cmVzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTY0IGZlYXR1cmVzKQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGlu
ZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
