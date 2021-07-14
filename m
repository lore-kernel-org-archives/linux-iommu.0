Return-Path: <SRS0=i+j8=MG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868F9C11F66
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 08:57:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 419B761363
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 08:57:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 419B761363
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 064434069D;
	Wed, 14 Jul 2021 08:57:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LSzHM8E-VLJ9; Wed, 14 Jul 2021 08:57:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A502B40531;
	Wed, 14 Jul 2021 08:57:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7960FC001A;
	Wed, 14 Jul 2021 08:57:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E543C000E
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 08:57:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1AA3640699
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 08:57:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nwmCn0BhD0hR for <iommu@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 08:57:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AF46540531
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 08:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626253027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b67pj1XjCFcb4vjOC6L9gEcYmcQccLEDJzYb3n+c66I=;
 b=NbM7RsWJIkcbd7Zf5cmO5p7jU5A/21B5nXMLmMABf2kzFBvklDuZeVVCndeSpoPxUfe/QZ
 iu6ZRkJiVpc/afy5fVIVMD4+qqAe008dFOJV9uW6MyXqTj16gc5cL45GSZyjxGq4fZoCr+
 c7NOxY6Tmua2w6uieEJKMkk4qz1OLHg=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167--Ws65vHXNny6nH2pd0hEeg-1; Wed, 14 Jul 2021 04:57:06 -0400
X-MC-Unique: -Ws65vHXNny6nH2pd0hEeg-1
Received: by mail-pf1-f199.google.com with SMTP id
 w191-20020a62ddc80000b0290318fa423788so1138932pff.11
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 01:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=b67pj1XjCFcb4vjOC6L9gEcYmcQccLEDJzYb3n+c66I=;
 b=hNbSdPH43oU+aTqjoA4VDw07sCoSJnoeCUXKXjkLofTGCE/5Avcy4cSezga/NV1rNP
 R21mN7aLRePgA/mRjaRqXoppRPqWmbjbMAsJ45mZ6bMqXjh8TR2ryycb2jXVONOBC1UI
 EqvE1YIsA93YxPEErRp8mSJP1l6bwZFYK7ZYpx8924nJAPkWjrB8dRy3QN6nL3tFI1Pe
 AFRO759PBwLfvhMxE9eUgKs0cWowyLciA8EthkxgQ995ASN5Q/qc0SQbcxvm0tes5clO
 VAdk4bwLWpLtpAAG4+OXP/9PvsY6jGwc+kUCB/KxDAAPt09yVHfzBZarUHlIQYaYemTv
 fJDg==
X-Gm-Message-State: AOAM5319Qc1eMh4hZFvsadGbbL/ZkCQTH8x7KaBlyiyvvGfxNVhDw4Cz
 VUJN84GpB29ttxxdt2IHt62KIo90cNrv3LuzQkrjRGYHjHUd6vUMEXICIGGzBvgEihTF8oq3lUI
 /QQ+Nh2tCP3uKW1R28P5A8IY7svilwA==
X-Received: by 2002:a17:90a:af90:: with SMTP id
 w16mr2814482pjq.129.1626253025290; 
 Wed, 14 Jul 2021 01:57:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzI/UxSDMVXZBsCbO/ysTuOL+td5Krg49S3x+yII+Nt1pi43Zbgr08iKwIXB4LRw/hvEMwy1w==
X-Received: by 2002:a17:90a:af90:: with SMTP id
 w16mr2814452pjq.129.1626253024987; 
 Wed, 14 Jul 2021 01:57:04 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id d2sm2127796pgh.59.2021.07.14.01.56.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jul 2021 01:57:04 -0700 (PDT)
Subject: Re: [PATCH v9 16/17] vduse: Introduce VDUSE - vDPA Device in Userspace
To: Greg KH <gregkh@linuxfoundation.org>
References: <20210713084656.232-1-xieyongji@bytedance.com>
 <20210713084656.232-17-xieyongji@bytedance.com>
 <26116714-f485-eeab-4939-71c4c10c30de@redhat.com>
 <20210714014817-mutt-send-email-mst@kernel.org>
 <0565ed6c-88e2-6d93-7cc6-7b4afaab599c@redhat.com>
 <YO6IiDIMUjQsA2LS@kroah.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a493bc51-9a5c-05f1-2eac-54cb9e6c9d9b@redhat.com>
Date: Wed, 14 Jul 2021 16:56:55 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YO6IiDIMUjQsA2LS@kroah.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, christian.brauner@canonical.com,
 corbet@lwn.net, willy@infradead.org, hch@infradead.org,
 Xie Yongji <xieyongji@bytedance.com>, dan.carpenter@oracle.com,
 sgarzare@redhat.com, xiaodong.liu@intel.com, viro@zeniv.linux.org.uk,
 stefanha@redhat.com, songmuchun@bytedance.com, axboe@kernel.dk,
 zhe.he@windriver.com, netdev@vger.kernel.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, bcrl@kvack.org,
 linux-fsdevel@vger.kernel.org, mika.penttila@nextfour.com
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

CuWcqCAyMDIxLzcvMTQg5LiL5Y2IMjo0NywgR3JlZyBLSCDlhpnpgZM6Cj4gT24gV2VkLCBKdWwg
MTQsIDIwMjEgYXQgMDI6MDI6NTBQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4g5ZyoIDIw
MjEvNy8xNCDkuIvljYgxOjU0LCBNaWNoYWVsIFMuIFRzaXJraW4g5YaZ6YGTOgo+Pj4gT24gV2Vk
LCBKdWwgMTQsIDIwMjEgYXQgMDE6NDU6MzlQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4+
Pj4gK3N0YXRpYyBpbnQgdmR1c2VfZGV2X21zZ19zeW5jKHN0cnVjdCB2ZHVzZV9kZXYgKmRldiwK
Pj4+Pj4gKwkJCSAgICAgIHN0cnVjdCB2ZHVzZV9kZXZfbXNnICptc2cpCj4+Pj4+ICt7Cj4+Pj4+
ICsJaW50IHJldDsKPj4+Pj4gKwo+Pj4+PiArCWluaXRfd2FpdHF1ZXVlX2hlYWQoJm1zZy0+d2Fp
dHEpOwo+Pj4+PiArCXNwaW5fbG9jaygmZGV2LT5tc2dfbG9jayk7Cj4+Pj4+ICsJbXNnLT5yZXEu
cmVxdWVzdF9pZCA9IGRldi0+bXNnX3VuaXF1ZSsrOwo+Pj4+PiArCXZkdXNlX2VucXVldWVfbXNn
KCZkZXYtPnNlbmRfbGlzdCwgbXNnKTsKPj4+Pj4gKwl3YWtlX3VwKCZkZXYtPndhaXRxKTsKPj4+
Pj4gKwlzcGluX3VubG9jaygmZGV2LT5tc2dfbG9jayk7Cj4+Pj4+ICsKPj4+Pj4gKwl3YWl0X2V2
ZW50X2tpbGxhYmxlX3RpbWVvdXQobXNnLT53YWl0cSwgbXNnLT5jb21wbGV0ZWQsCj4+Pj4+ICsJ
CQkJICAgIFZEVVNFX1JFUVVFU1RfVElNRU9VVCAqIEhaKTsKPj4+Pj4gKwlzcGluX2xvY2soJmRl
di0+bXNnX2xvY2spOwo+Pj4+PiArCWlmICghbXNnLT5jb21wbGV0ZWQpIHsKPj4+Pj4gKwkJbGlz
dF9kZWwoJm1zZy0+bGlzdCk7Cj4+Pj4+ICsJCW1zZy0+cmVzcC5yZXN1bHQgPSBWRFVTRV9SRVFf
UkVTVUxUX0ZBSUxFRDsKPj4+Pj4gKwl9Cj4+Pj4+ICsJcmV0ID0gKG1zZy0+cmVzcC5yZXN1bHQg
PT0gVkRVU0VfUkVRX1JFU1VMVF9PSykgPyAwIDogLUVJTzsKPj4+PiBJIHRoaW5rIHdlIHNob3Vs
ZCBtYXJrIHRoZSBkZXZpY2UgYXMgbWFsZnVuY3Rpb24gd2hlbiB0aGVyZSBpcyBhIHRpbWVvdXQg
YW5kCj4+Pj4gZm9yYmlkIGFueSB1c2Vyc3BhY2Ugb3BlcmF0aW9ucyBleGNlcHQgZm9yIHRoZSBk
ZXN0cm95IGFmdHdhcmRzIGZvciBzYWZldHkuCj4+PiBUaGlzIGxvb2tzIGxpa2UgaWYgb25lIHRy
aWVkIHRvIHJ1biBnZGIgb24gdGhlIHByb2dyYW0gdGhlIGJlaGF2aW91cgo+Pj4gd2lsbCBjaGFu
Z2UgY29tcGxldGVseSBiZWNhdXNlIGtlcm5lbCB3YW50cyBpdCB0byByZXNwb25kIHdpdGhpbgo+
Pj4gc3BlY2lmaWMgdGltZS4gTG9va3MgbGlrZSBhIHJlY2VpcGUgZm9yIGhlaXNlbmJ1Z3MuCj4+
Pgo+Pj4gTGV0J3Mgbm90IGJ1aWxkIGludGVyZmFjZXMgd2l0aCBhcmJpdHJhcnkgdGltZW91dHMg
bGlrZSB0aGF0Lgo+Pj4gSW50ZXJydXB0aWJsZSB3YWl0IGV4aXN0cyBmb3IgdGhpcyB2ZXJ5IHJl
YXNvbi4KPj4KPj4gVGhlIHByb2JsZW0gaXMuIERvIHdlIHdhbnQgdXNlcnNwYWNlIHByb2dyYW0g
bGlrZSBtb2Rwcm9iZSB0byBiZSBzdHVjayBmb3IKPj4gaW5kZWZpbml0ZSB0aW1lIGFuZCBleHBl
Y3QgdGhlIGFkbWluaXN0cmF0b3IgdG8ga2lsbCB0aGF0Pwo+IFdoeSB3b3VsZCBtb2Rwcm9iZSBi
ZSBzdHVjayBmb3IgZm9yZXZlcj8KPgo+IElzIHRoaXMgb24gdGhlIG1vZHVsZSBwcm9iZSBwYXRo
PwoKClllcywgaXQgaXMgY2FsbGVkIGluIHRoZSBkZXZpY2UgcHJvYmluZyBwYXRoIHdoZXJlIHRo
ZSBrZXJuZWwgZm9yd2FyZHMgCnRoZSBkZXZpY2UgY29uZmlndXJhdGlvbiByZXF1ZXN0IHRvIHVz
ZXJzcGFjZSBhbmQgd2FpdCBmb3IgaXRzIHJlc3BvbnNlLgoKSWYgaXQgdHVybnMgb3V0IHRvIGJl
IHRyaWNreSwgd2UgY2FuIGltcGxlbWVudCB0aGUgd2hvbGUgZGV2aWNlIGluc2lkZSAKdGhlIGtl
cm5lbCBhbmQgbGVhdmUgb25seSB0aGUgZGF0YXBhdGggaW4gdGhlIHVzZXJzcGFjZSAoYXMgd2hh
dCBUVU4gZGlkKS4KClRoYW5rcwoKCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby9pb21tdQ==
