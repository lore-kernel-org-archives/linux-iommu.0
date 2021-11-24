Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 209D2C433FE
	for <iommu@archiver.kernel.org>; Wed, 24 Nov 2021 14:07:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9818461B90;
	Wed, 24 Nov 2021 14:07:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0Pe141uwEsBu; Wed, 24 Nov 2021 14:07:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5F3A36009C;
	Wed, 24 Nov 2021 14:07:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 309BAC001E;
	Wed, 24 Nov 2021 14:07:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 819D7C0012
 for <iommu@lists.linux-foundation.org>; Wed, 24 Nov 2021 14:07:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 624F3400D1
 for <iommu@lists.linux-foundation.org>; Wed, 24 Nov 2021 14:07:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PZPh78LbJP_7 for <iommu@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 14:07:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 760434006F
 for <iommu@lists.linux-foundation.org>; Wed, 24 Nov 2021 14:07:52 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 w33-20020a17090a6ba400b001a722a06212so4361073pjj.0
 for <iommu@lists.linux-foundation.org>; Wed, 24 Nov 2021 06:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=syp/sAx1WBqbnIsfqrbBbnU7pLQsZBgXpQdqrXqrl38=;
 b=iecLeo1CCg8zt+sCXUOh364DhRhAV/Ar/v0CTPnIw92trVIyH4qvDLyLNdAiBMXH4T
 y+0BfWQ61+rOjIQbdKy9swqEYsMOae4eIFV1313ZNnDT1Lbv+aQO2IbYTdrbWOvmPEQu
 KlSl5yD8YP31w1z8kq/HaASDcSvcnIEnzDtL5YgUuswZfXpPxYfhz71mw789p88NP4MI
 rs74u4gMJh8nMwRq/chOwPKzLo9eH4bM7b5lm+1o85GlnoBeIlU+U2qG0z31u0KruJlF
 tO4ST89te9GQQvoWvoAHX2ms15JvNlQ1QJuyCl7nZWEUc1aTjDEBcKPhZNHdIMGNmbVg
 pbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=syp/sAx1WBqbnIsfqrbBbnU7pLQsZBgXpQdqrXqrl38=;
 b=y8FRAeAyONA77drlzHNAiNc9KEbwQmwMiRcWcbEgoE9F4BSXk/yLicUYiijIGWHPaW
 gRcupiQNDOocMTdcD6BxgBrLpxId7HPUwDVZUi0wajPbkOlEbwKx9Z02MOtPWQ82Xnml
 en4N+FZI9SLjeSfYty/n2sr1ZVZup/9ZPtHcLy2nByIo7ja2RRRmczWfvJum9tF8yACp
 UatwJW0LqQUj7DUAaTi6Uc22MN/cm/JCKRjodrl0B6carnEdloXzp+rsM1FQYLjbfNcF
 cTNdNSeaRvHM0kn34mfzG0qRn0GtNNd/P1z3181/55XY21mZEStq8VOXSpOY4AHNo1wN
 8ZVQ==
X-Gm-Message-State: AOAM532mCYdPet3Ary7R9yhsGirmdTUkCTgJ4h4At4CslIj1/Y/ol/qO
 RZo4qB+8dehvnKPJ2U8qRcg=
X-Google-Smtp-Source: ABdhPJxcvy1hEASS+ae7P9Zr40fMPVIge5ooMequB2zH2fg19BpSdiMXmZRAmprhgB5OLHpbaYCO2A==
X-Received: by 2002:a17:902:b581:b0:144:e601:de7 with SMTP id
 a1-20020a170902b58100b00144e6010de7mr19054433pls.71.1637762871786; 
 Wed, 24 Nov 2021 06:07:51 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::50b? ([2404:f801:9000:18:efec::50b])
 by smtp.gmail.com with ESMTPSA id
 g5sm4694513pjt.15.2021.11.24.06.07.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Nov 2021 06:07:51 -0800 (PST)
Message-ID: <887d57bc-8b1a-48ab-be72-17144791334a@gmail.com>
Date: Wed, 24 Nov 2021 22:07:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH V2 1/6] Swiotlb: Add Swiotlb bounce buffer remap function
 for HV IVM
Content-Language: en-US
To: "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
 Christoph Hellwig <hch@lst.de>
References: <20211123143039.331929-1-ltykernel@gmail.com>
 <20211123143039.331929-2-ltykernel@gmail.com>
 <MWHPR21MB1593169593AD833A91DF553FD7609@MWHPR21MB1593.namprd21.prod.outlook.com>
From: Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <MWHPR21MB1593169593AD833A91DF553FD7609@MWHPR21MB1593.namprd21.prod.outlook.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "dave.hansen@intel.com" <dave.hansen@intel.com>,
 "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>,
 "will@kernel.org" <will@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "sstabellini@kernel.org" <sstabellini@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 "hch@lst.de" <hch@lst.de>, "mingo@redhat.com" <mingo@redhat.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
 "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, "bp@alien8.de" <bp@alien8.de>,
 "luto@kernel.org" <luto@kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
 "jgross@suse.com" <jgross@suse.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 vkuznets <vkuznets@redhat.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "davem@davemloft.net" <davem@davemloft.net>
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

SGkgTWljaGFlbDoKCVRoYW5rcyBmb3IgeW91ciByZXZpZXcuCgpPbiAxMS8yNC8yMDIxIDE6MTUg
QU0sIE1pY2hhZWwgS2VsbGV5IChMSU5VWCkgd3JvdGU6Cj4+IEBAIC0xNzIsNyArMjAwLDE0IEBA
IHZvaWQgX19pbml0IHN3aW90bGJfdXBkYXRlX21lbV9hdHRyaWJ1dGVzKHZvaWQpCj4+ICAgCXZh
ZGRyID0gcGh5c190b192aXJ0KG1lbS0+c3RhcnQpOwo+PiAgIAlieXRlcyA9IFBBR0VfQUxJR04o
bWVtLT5uc2xhYnMgPDwgSU9fVExCX1NISUZUKTsKPj4gICAJc2V0X21lbW9yeV9kZWNyeXB0ZWQo
KHVuc2lnbmVkIGxvbmcpdmFkZHIsIGJ5dGVzID4+IFBBR0VfU0hJRlQpOwo+PiAtCW1lbXNldCh2
YWRkciwgMCwgYnl0ZXMpOwo+PiArCj4+ICsJbWVtLT52YWRkciA9IHN3aW90bGJfbWVtX3JlbWFw
KG1lbSwgYnl0ZXMpOwo+PiArCWlmICghbWVtLT52YWRkcikgewo+PiArCQlwcl9lcnIoIkZhaWwg
dG8gcmVtYXAgc3dpb3RsYiBtZW0uXG4iKTsKPj4gKwkJcmV0dXJuOwo+PiArCX0KPj4gKwo+PiAr
CW1lbXNldChtZW0tPnZhZGRyLCAwLCBieXRlcyk7Cj4+ICAgfQoKCj4gSW4gdGhlIGVycm9yIGNh
c2UsIGRvIHlvdSB3YW50IHRvIGxlYXZlIG1lbS0+dmFkZHIgYXMgTlVMTD8gIE9yIGlzIGl0Cj4g
YmV0dGVyIHRvIGxlYXZlIGl0IGFzIHRoZSB2aXJ0dWFsIGFkZHJlc3Mgb2YgbWVtLXN0YXJ0PyAg
WW91ciBjb2RlIGxlYXZlcyBpdAo+IGFzIE5VTEwuCj4gCj4gVGhlIGludGVyYWN0aW9uIGJldHdl
ZW4gc3dpb3RsYl91cGRhdGVfbWVtX2F0dHJpYnV0ZXMoKSBhbmQgdGhlIGhlbHBlcgo+IGZ1bmN0
aW9uIHN3aW90bGJfbWVtb19yZW1hcCgpIHNlZW1zIGtpbmQgb2YgY2x1bmt5LiAgcGh5c190b192
aXJ0KCkgZ2V0cyBjYWxsZWQKPiB0d2ljZSwgZm9yIGV4YW1wbGUsIGFuZCB0d28gZXJyb3IgbWVz
c2FnZXMgYXJlIHByaW50ZWQuICBUaGUgY29kZSB3b3VsZCBiZQo+IG1vcmUgc3RyYWlnaHRmb3J3
YXJkIGJ5IGp1c3QgcHV0dGluZyB0aGUgaGVscGVyIGZ1bmN0aW9uIGlubGluZToKPiAKPiBtZW0t
PnZhZGRyID0gcGh5c190b192aXJ0KG1lbS0+c3RhcnQpOwo+IGJ5dGVzID0gUEFHRV9BTElHTiht
ZW0tPm5zbGFicyA8PCBJT19UTEJfU0hJRlQpOwo+IHNldF9tZW1vcnlfZGVjcnlwdGVkKCh1bnNp
Z25lZCBsb25nKShtZW0tPnZhZGRyKSwgYnl0ZXMgPj4gUEFHRV9TSElGVCk7Cj4gCj4gaWYgKHN3
aW90bGJfdW5lbmNyeXB0ZWRfYmFzZSkgewo+IAlwaHlzX2FkZHJfdCBwYWRkciA9IG1lbS0+c3Rh
cnQgKyBzd2lvdGxiX3VuZW5jcnlwdGVkX2Jhc2U7Cj4gCj4gCW1lbS0+dmFkZHIgPSBtZW1yZW1h
cChwYWRkciwgYnl0ZXMsIE1FTVJFTUFQX1dCKTsKPiAJaWYgKCFtZW0tPnZhZGRyKSB7Cj4gCQlw
cl9lcnIoIkZhaWxlZCB0byBtYXAgdGhlIHVuZW5jcnlwdGVkIG1lbW9yeSAlbGx4IHNpemUgJWx4
LlxuIiwKPiAJCQkgICAgICAgcGFkZHIsIGJ5dGVzKTsKPiAJCXJldHVybjsKPiAJfQo+IH0KPiAK
PiBtZW1zZXQobWVtLT52YWRkciwgMCwgYnl0ZXMpOwo+IAo+IChUaGlzIHZlcnNpb24gYWxzbyBs
ZWF2ZXMgbWVtLT52YWRkciBhcyBOVUxMIGluIHRoZSBlcnJvciBjYXNlLikKCiBGcm9tIENocmlz
dG9waCdzIHByZXZpb3VzIHN1Z2dlc3Rpb24sIHRoZXJlIHNob3VsZCBiZSBhIHdlbGwtZG9jdW1l
bnRlZCAKd3JhcHBlciB0byBleHBsYWluIHRoZSByZW1hcCBvcHRpb24gYW5kIHNvIEkgc3BsaXQg
dGhlIGNvZGUuIGxlYXZpbmcgdGhlIAp2aXJ0dWFsIGFkZHJlc3Mgb2YgbWVtLXN0YXJ0IGlzIGJl
dHRlci4KCmh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDIxLzkvMjgvNTEKCj4gCj4+ICAgc3RhdGlj
IHZvaWQgc3dpb3RsYl9pbml0X2lvX3RsYl9tZW0oc3RydWN0IGlvX3RsYl9tZW0gKm1lbSwgcGh5
c19hZGRyX3Qgc3RhcnQsCj4+IEBAIC0xOTYsNyArMjMxLDE4IEBAIHN0YXRpYyB2b2lkIHN3aW90
bGJfaW5pdF9pb190bGJfbWVtKHN0cnVjdCBpb190bGJfbWVtICptZW0sIHBoeXNfYWRkcl90IHN0
YXJ0LAo+PiAgIAkJbWVtLT5zbG90c1tpXS5vcmlnX2FkZHIgPSBJTlZBTElEX1BIWVNfQUREUjsK
Pj4gICAJCW1lbS0+c2xvdHNbaV0uYWxsb2Nfc2l6ZSA9IDA7Cj4+ICAgCX0KPj4gKwo+PiArCS8q
Cj4+ICsJICogSWYgc3dpb3RsYl91bmVuY3J5cHRlZF9iYXNlIGlzIHNldCwgdGhlIGJvdW5jZSBi
dWZmZXIgbWVtb3J5IHdpbGwKPj4gKwkgKiBiZSByZW1hcHBlZCBhbmQgY2xlYXJlZCBpbiBzd2lv
dGxiX3VwZGF0ZV9tZW1fYXR0cmlidXRlcy4KPj4gKwkgKi8KPj4gKwlpZiAoc3dpb3RsYl91bmVu
Y3J5cHRlZF9iYXNlKQo+PiArCQlyZXR1cm47Cj4+ICsKPj4gKwlzZXRfbWVtb3J5X2RlY3J5cHRl
ZCgodW5zaWduZWQgbG9uZyl2YWRkciwgYnl0ZXMgPj4gUEFHRV9TSElGVCk7Cj4gUHJpb3IgdG8g
dGhpcyBwYXRjaCwgYW5kIGhlcmUgaW4gdGhlIG5ldyB2ZXJzaW9uIGFzIHdlbGwsIHRoZSByZXR1
cm4gdmFsdWUgZnJvbQo+IHNldF9tZW1vcnlfZGVjcnlwdGVkKCkgaXMgaWdub3JlZCBpbiBzZXZl
cmFsIHBsYWNlcyBpbiB0aGlzIGZpbGUuICBBcyBwcmV2aW91c2x5Cj4gZGlzY3Vzc2VkLCBzd2lv
dGxiX2luaXRfaW9fdGxiX21lbSgpIGlzIGEgdm9pZCBmdW5jdGlvbiwgc28gdGhlcmUncyBubyBw
bGFjZSB0bwo+IHJldHVybiBhbiBlcnJvci4gSXMgdGhhdCBPSz8KClllcywgdGhlIG9yaWdpbmFs
IGNvZGUgZG9lc24ndCBjaGVjayB0aGUgcmV0dXJuIHZhbHVlIGFuZCBzbyBrZWVwIHRoZSAKcnVs
ZeOAggoKQ2hyaXN0b3BoLCBDb3VsZCB5b3UgaGVscCB0byBjaGVjayB3aGljaCB3YXkgZG8geW91
IHByZWZlcj8KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
