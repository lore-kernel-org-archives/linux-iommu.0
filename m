Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F104C433EF
	for <iommu@archiver.kernel.org>; Fri, 11 Mar 2022 08:19:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 315F140176;
	Fri, 11 Mar 2022 08:19:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zr5T6ioL_m_4; Fri, 11 Mar 2022 08:19:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 50C1C400E9;
	Fri, 11 Mar 2022 08:19:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C422C001D;
	Fri, 11 Mar 2022 08:19:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C78AC000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 08:19:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7619A84169
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 08:19:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VyvorZhWC4Zm for <iommu@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 08:19:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5D34E83EA1
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 08:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646986758;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8AGBOXeSleA1IuyfT69wuJp+6zvr7dHRVBmDnVZmB7g=;
 b=K+EcTfwga8QTg9QUCI1Jbadz4Xi4u4xIM0Wio2dFM++H4fGDiq3GTodBI6D+6wrKqftDuA
 ep8h7obMVtWUQMBTq934aP1p31dXi4DNhIFjOE21GtD0xXeLkcBocsGwKB7XagbRkt4TJq
 9OXEoGFettPKJ5LHpLcBYUyWppgiB6A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-197-jL2-KjLqODeJ6lk2etDNQw-1; Fri, 11 Mar 2022 03:19:16 -0500
X-MC-Unique: jL2-KjLqODeJ6lk2etDNQw-1
Received: by mail-wm1-f71.google.com with SMTP id
 7-20020a1c1907000000b003471d9bbe8dso3536722wmz.0
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 00:19:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=8AGBOXeSleA1IuyfT69wuJp+6zvr7dHRVBmDnVZmB7g=;
 b=bZ+6W4Q8xcYI/+GTfyYkgCEZSe6xzLOGHJKlHUSMJCg7zxpJzx6UyUz1J8XuYAC1pz
 FWL7uYyKmK7ZFtpIu+SumROUmGSLDONRyEY+4UKcZewBJ6cuX/yR4w6Yva7Qgnpsb7rT
 Gcw+STc5BbZmkW+sFiODwdiQ5O+6XqtvrC39FKZ38F6XAFsuwvdUWK1DwISlBD/NAfnh
 ff/j8v9rTxPMvVtIoD1TnJ2lGACkvfjX8NsZmmJNKB/P9lODhvEdKAGMs7sieQnr4ciZ
 8LJIM8PIzvQ8Ae3/8YwExgfKCt424UHpAA3i9ynqhjfWda3Rz6nA+guplDxByOqM6x1R
 5SKA==
X-Gm-Message-State: AOAM531//VPR3vEfSyaxPxV8FVfmPdFiVKpxQqPfffjKiDEUrukneuFz
 HYu8VRIFOa9COqclJtv/USkQEGtKtNoVmW0CYbk4bUvmO1nCEcJzsIjrL6vzqYRWz/QN1NWq6uw
 bekbLu4VbFK8vnpEZJHzkef3g0+KQ2g==
X-Received: by 2002:a5d:58d3:0:b0:1f1:dfb1:ab63 with SMTP id
 o19-20020a5d58d3000000b001f1dfb1ab63mr6559747wrf.326.1646986755632; 
 Fri, 11 Mar 2022 00:19:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwerKE4N1pKS+KaYDddjpq12y53SjIesUYPI8D5gzCRx+rCUaQVVVwdH//6D1UiLOzeAFP89w==
X-Received: by 2002:a5d:58d3:0:b0:1f1:dfb1:ab63 with SMTP id
 o19-20020a5d58d3000000b001f1dfb1ab63mr6559718wrf.326.1646986755349; 
 Fri, 11 Mar 2022 00:19:15 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a05600c4f8f00b003842f011bc5sm10353512wmq.2.2022.03.11.00.19.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Mar 2022 00:19:14 -0800 (PST)
Subject: Re: [PATCH v8 00/11] ACPI/IORT: Support for IORT RMR node
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, Ard Biesheuvel <ardb@kernel.org>
References: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
Message-ID: <bb3688c7-8f42-039e-e22f-6529078da97d@redhat.com>
Date: Fri, 11 Mar 2022 09:19:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: robin.murphy@arm.com, jon@solid-run.com, linuxarm@huawei.com,
 steven.price@arm.com, guohanjun@huawei.com, yangyicong@huawei.com,
 Sami.Mujawar@arm.com, will@kernel.org, wanghuiqiang@huawei.com
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
Reply-To: eric.auger@redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGkgZ3V5cywKCk9uIDIvMjEvMjIgNDo0MyBQTSwgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToKPiBI
aSwKPgo+IFNpbmNlIHdlIG5vdyBoYXZlIGFuIHVwZGF0ZWQgdmVyaW9uWzBdIG9mIElPUlQgc3Bl
YyhFLmQpIHdoaWNoCj4gYWRkcmVzc2VzIHRoZSBtZW1vcnkgYXR0cmlidXRlcyBpc3N1ZXMgZGlz
Y3Vzc2VkIGhlcmUgWzFdLAo+IHRoaXMgc2VyaWVzIG5vdyBtYWtlIHVzZSBvZiBpdC4KPgo+IFRo
ZSBwdWxsIHJlcXVlc3QgZm9yIEFDUElDQSBFLmQgcmVsYXRlZCBjaGFuZ2VzIGFyZSBhbHJlYWR5
Cj4gcmFpc2VkIGFuZCBjYW4gYmUgZm91bmQgaGVyZSwKPiBodHRwczovL2dpdGh1Yi5jb20vYWNw
aWNhL2FjcGljYS9wdWxsLzc1Mgo+Cj4gdjcgLS0+IHY4Cj4gICAtIFBhdGNoICMxIGhhcyB0ZW1w
IGRlZmluaXRpb25zIGZvciBSTVIgcmVsYXRlZCBjaGFuZ2VzIHRpbGwKPiAgICAgdGhlIEFDUElD
QSBoZWFkZXIgY2hhbmdlcyBhcmUgcGFydCBvZiBrZXJuZWwuCj4gICAtIE5vIGVhcmx5IHBhcnNp
bmcgb2YgUk1SIG5vZGUgaW5mbyBhbmQgaXMgb25seSBwYXJzZWQgYXQgdGhlCj4gICAgIHRpbWUg
b2YgdXNlLgo+ICAgLSBDaGFuZ2VzIHRvIHRoZSBSTVIgZ2V0L3B1dCBBUEkgZm9ybWF0IGNvbXBh
cmVkIHRvIHRoZQo+ICAgICBwcmV2aW91cyB2ZXJzaW9uLgo+ICAgLSBTdXBwb3J0IGZvciBSTVIg
ZGVzY3JpcHRvciBzaGFyZWQgYnkgbXVsdGlwbGUgc3RyZWFtIElEcy4KPgo+IFBsZWFzZSB0YWtl
IGEgbG9vayBhbmQgbGV0IG1lIGtub3cgeW91ciB0aG91Z2h0cy4KPgo+IFRoYW5rcywKPiBTaGFt
ZWVyCj4gWzBdIGh0dHBzOi8vZGV2ZWxvcGVyLmFybS5jb20vZG9jdW1lbnRhdGlvbi9kZW4wMDQ5
L2VkLwpJIHN0aWxsIGhhdmUgYSBxdWVzdGlvbiBvbiB0aGUgSU9SVCBFLmQgc3BlYyAodW5yZWxh
dGVkIHRvIHRoaXMgc2VyaWVzKS4KClRoZSBzcGVjIG1hbmRhdGVzIHRoYXQgaWYgUk1SIG5vZGVz
IGFyZSBwcmVzZW50ZWQgaW4gdGhlIElPUlQsCl9EU00gZnVuY3Rpb24gIzUgZm9yIHRoZSBQQ0ll
IGhvc3QgYnJpZGdlIEFDUEkgZGV2aWNlIG9iamVjdCBtdXN0IHJldHVybgowLCBpbmRpY2F0aW5n
IHRoZSBPUyBtdXN0IGhvbm91ciB0aGUgUENJIGNvbmZpZyB0aGF0IHRoZSBGVyBjb21wdXRlZCBh
dApib290IHRpbWUuCgpIb3dldmVyIGltcGxlbWVudGluZyB0aGlzIF9EU00gIzUgYXMgYWJvdmUg
aXMga25vd24gdG8gcHJldmVudCBQQ0kKZGV2aWNlcyB3aXRoIElPIHBvcnRzIGZyb20gd29ya2lu
Zywgb24gYWFyY2g2NCBsaW51eC4KCiIKVGhlIHJlYXNvbiBpcyB0aGF0IEVGSSBjcmVhdGVzIEkv
TyBwb3J0IG1hcHBpbmdzIGJlbG93CsKgwqDCoCAweDEwMDAgKGluIGZhY3QsIGF0IDApLiBIb3dl
dmVyIExpbnV4LCBmb3IgbGVnYWN5IHJlYXNvbnMsIGRvZXMgbm90CsKgwqDCoCBzdXBwb3J0IEkv
TyBwb3J0cyA8PSAweDEwMDAgb24gUENJLCBzbyB0aGUgSS9PIGFzc2lnbm1lbnQgY3JlYXRlZCBi
eSBFRkkKwqDCoMKgIGlzIHJlamVjdGVkLgrCoMKgwqAKwqDCoMKgIEVGSSBjcmVhdGVzIHRoZSBt
YXBwaW5ncyBwcmltYXJpbHkgZm9yIGl0c2VsZiwgYW5kIHVwIHVudGlsIERTTSAjNQrCoMKgwqAg
c3RhcnRlZCB0byBiZSBlbmZvcmNlZCwgYWxsIFBDSSByZXNvdXJjZSBhbGxvY2F0aW9ucyB0aGF0
IGV4aXN0ZWQgYXQKwqDCoMKgIGJvb3Qgd2VyZSBpZ25vcmVkIGJ5IExpbnV4IGFuZCByZWNyZWF0
ZWQgZnJvbSBzY3JhdGNoLgoiCgpUaGlzIGlzIGFuIGV4Y2VycHQgb2YgYSBxZW11IGNvbW1pdCBt
ZXNzYWdlIHRoYXQgcmV2ZXJ0ZWQgdGhlIF9ETVMgIzUKY2hhbmdlIChSZXZlcnQgImFjcGkvZ3Bl
eDogSW5mb3JtIG9zIHRvIGtlZXAgZmlybXdhcmUgcmVzb3VyY2UgbWFwIikuCkhhcyB0aGUgc2l0
dWF0aW9uIGNoYW5nZWQgc2luY2UgSnVseSAyMDIxIChpZS4gaGFzIFVFRkkgYmVlbiByZXdvcmtl
ZD8pLgpbKyBBcmRdCgpUaGFuayB5b3UgaW4gYWR2YW5jZQoKUmVnYXJkcwoKRXJpYwoKCgoKPiBb
MV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtYWNwaS8yMDIxMDgwNTE2MDMxOS5HQjIz
MDg1QGxwaWVyYWxpc2kvCj4KPiBGcm9tIG9sZDoKPiBXZSBoYXZlIGZhY2VkIGlzc3VlcyB3aXRo
IDM0MDhpTVIgUkFJRCBjb250cm9sbGVyIGNhcmRzIHdoaWNoCj4gZmFpbCB0byBib290IHdoZW4g
U01NVSBpcyBlbmFibGVkLiBUaGlzIGlzIGJlY2F1c2UgdGhlc2UKPiBjb250cm9sbGVycyBtYWtl
IHVzZSBvZiBob3N0IG1lbW9yeSBmb3IgdmFyaW91cyBjYWNoaW5nIHJlbGF0ZWQKPiBwdXJwb3Nl
cyBhbmQgd2hlbiBTTU1VIGlzIGVuYWJsZWQgdGhlIGlNUiBmaXJtd2FyZSBmYWlscyB0bwo+IGFj
Y2VzcyB0aGVzZSBtZW1vcnkgcmVnaW9ucyBhcyB0aGVyZSBpcyBubyBtYXBwaW5nIGZvciB0aGVt
Lgo+IElPUlQgUk1SIHByb3ZpZGVzIGEgd2F5IGZvciBVRUZJIHRvIGRlc2NyaWJlIGFuZCByZXBv
cnQgdGhlc2UKPiBtZW1vcnkgcmVnaW9ucyBzbyB0aGF0IHRoZSBrZXJuZWwgY2FuIG1ha2UgYSB1
bml0eSBtYXBwaW5nIGZvcgo+IHRoZXNlIGluIFNNTVUuCj4KPiBDaGFuZ2UgSGlzdG9yeToKPgo+
IHY2IC0tPiB2Nwo+ICAtZml4IHBvaW50ZWQgb3V0IGJ5IFN0ZXZlIHRvIHRoZSBTTU1VdjIgU01S
IGJ5cGFzcyBpbnN0YWxsIGluIHBhdGNoICM4Lgo+Cj4gdjUgLS0+IHY2Cj4gLSBBZGRyZXNzZWQg
Y29tbWVudHMgZnJvbSBSb2JpbiAmIExvcmVuem8uCj4gICA6IE1vdmVkIGlvcnRfcGFyc2Vfcm1y
KCkgdG8gYWNwaV9pb3J0X2luaXQoKSBmcm9tCj4gICAgIGlvcnRfaW5pdF9wbGF0Zm9ybV9kZXZp
Y2VzKCkuCj4gICA6IFJlbW92ZWQgdXNlIG9mIHN0cnVjdCBpb3J0X3Jtcl9lbnRyeSBkdXJpbmcg
dGhlIGluaXRpYWwKPiAgICAgcGFyc2UuIFVzaW5nIHN0cnVjdCBpb21tdV9yZXN2X3JlZ2lvbiBp
bnN0ZWFkLgo+ICAgOiBSZXBvcnQgUk1SIGFkZHJlc3MgYWxpZ25tZW50IGFuZCBvdmVybGFwIGVy
cm9ycywgYnV0IGNvbnRpbnVlLgo+ICAgOiBSZXdvcmtlZCBhcm1fc21tdV9pbml0X2J5cGFzc19z
dGVzKCkgKHBhdGNoICMgNikuCj4gLSBVcGRhdGVkIFNNTVV2MiBieXBhc3MgU01SIGNvZGUuIFRo
YW5rcyB0byBKb24gTiAocGF0Y2ggIzgpLgo+IC0gU2V0IElPTU1VIHByb3RlY3Rpb24gZmxhZ3Mo
SU9NTVVfQ0FDSEUsIElPTU1VX01NSU8pIGJhc2VkCj4gICBvbiBUeXBlIG9mIFJNUiByZWdpb24u
IFN1Z2dlc3RlZCBieSBKb24gTi4KPgo+IHY0IC0tPiB2NQo+ICAtQWRkZWQgYSBmd19kYXRhIHVu
aW9uIHRvIHN0cnVjdCBpb21tdV9yZXN2X3JlZ2lvbiBhbmQgcmVtb3ZlZAo+ICAgc3RydWN0IGlv
bW11X3JtciAoQmFzZWQgb24gY29tbWVudHMgZnJvbSBKb2VyZy9Sb2JpbikuCj4gIC1BZGRlZCBp
b21tdV9wdXRfcm1ycygpIHRvIHJlbGVhc2UgbWVtLgo+ICAtVGhhbmtzIHRvIFN0ZXZlIGZvciB2
ZXJpZnlpbmcgb24gU01NVXYyLCBidXQgbm90IGFkZGVkIHRoZSBUZXN0ZWQtYnkKPiAgIHlldCBi
ZWNhdXNlIG9mIHRoZSBhYm92ZSBjaGFuZ2VzLgo+Cj4gdjMgLS0+djQKPiAtSW5jbHVkZWQgdGhl
IFNNTVV2MiBTTVIgYnlwYXNzIGluc3RhbGwgY2hhbmdlcyBzdWdnZXN0ZWQgYnkKPiAgU3RldmUo
cGF0Y2ggIzcpCj4gLUFzIHBlciBSb2JpbidzIGNvbW1lbnRzLCBSTVIgcmVzZXJ2ZSBpbXBsZW1l
bnRhdGlvbiBpcyBub3cKPiAgbW9yZSBnZW5lcmljICAocGF0Y2ggIzgpIGFuZCBkcm9wcGVkIHYz
IHBhdGNoZXMgOCBhbmQgMTAuCj4gLVJlYmFzZSB0byA1LjEzLXJjMQo+Cj4gUkZDIHYyIC0tPiB2
Mwo+ICAtRHJvcHBlZCBSRkMgdGFnIGFzIHRoZSBBQ1BJQ0EgaGVhZGVyIGNoYW5nZXMgYXJlIG5v
dyByZWFkeSB0byBiZQo+ICAgcGFydCBvZiA1LjEzWzBdLiBCdXQgdGhpcyBzZXJpZXMgc3RpbGwg
aGFzIGEgZGVwZW5kZW5jeSBvbiB0aGF0IHBhdGNoLgo+ICAtQWRkZWQgSU9SVCBFLmIgcmVsYXRl
ZCBjaGFuZ2VzKG5vZGUgZmxhZ3MsIF9EU00gZnVuY3Rpb24gNSBjaGVja3MgZm9yCj4gICBQQ0ll
KS4KPiAgLUNoYW5nZWQgUk1SIHRvIHN0cmVhbSBpZCBtYXBwaW5nIGZyb20gTTpOIHRvIE06MSBh
cyBwZXIgdGhlIHNwZWMgYW5kCj4gICBkaXNjdXNzaW9uIGhlcmVbMV0uCj4gIC1MYXN0IHR3byBw
YXRjaGVzIGFkZCBzdXBwb3J0IGZvciBTTU1VdjIoVGhhbmtzIHRvIEpvbiBOZXR0bGV0b24hKQo+
Cj4gSm9uIE5ldHRsZXRvbiAoMSk6Cj4gICBpb21tdS9hcm0tc21tdTogR2V0IGFzc29jaWF0ZWQg
Uk1SIGluZm8gYW5kIGluc3RhbGwgYnlwYXNzIFNNUgo+Cj4gU2hhbWVlciBLb2xvdGh1bSAoMTAp
Ogo+ICAgQUNQSS9JT1JUOiBBZGQgdGVtcG9yYXJ5IFJNUiBub2RlIGZsYWcgZGVmaW5pdGlvbnMK
PiAgIGlvbW11OiBJbnRyb2R1Y2UgYSB1bmlvbiB0byBzdHJ1Y3QgaW9tbXVfcmVzdl9yZWdpb24K
PiAgIEFDUEkvSU9SVDogQWRkIGhlbHBlciBmdW5jdGlvbnMgdG8gcGFyc2UgUk1SIG5vZGVzCj4g
ICBpb21tdS9kbWE6IEludHJvZHVjZSBnZW5lcmljIGhlbHBlciB0byByZXRyaWV2ZSBSTVIgaW5m
bwo+ICAgQUNQSS9JT1JUOiBBZGQgYSBoZWxwZXIgdG8gcmV0cmlldmUgUk1SIG1lbW9yeSByZWdp
b25zCj4gICBpb21tdS9hcm0tc21tdS12MzogSW50cm9kdWNlIHN0cnRhYiBpbml0IGhlbHBlcgo+
ICAgaW9tbXUvYXJtLXNtbXUtdjM6IFJlZmFjdG9yIGFybV9zbW11X2luaXRfYnlwYXNzX3N0ZXMo
KSB0byBmb3JjZQo+ICAgICBieXBhc3MKPiAgIGlvbW11L2FybS1zbW11LXYzOiBHZXQgYXNzb2Np
YXRlZCBSTVIgaW5mbyBhbmQgaW5zdGFsbCBieXBhc3MgU1RFCj4gICBpb21tdS9hcm0tc21tdS12
MzogUmVzZXJ2ZSBhbnkgUk1SIHJlZ2lvbnMgYXNzb2NpYXRlZCB3aXRoIGEgZGV2Cj4gICBpb21t
dS9hcm0tc21tdTogUmVzZXJ2ZSBhbnkgUk1SIHJlZ2lvbnMgYXNzb2NpYXRlZCB3aXRoIGEgZGV2
Cj4KPiAgZHJpdmVycy9hY3BpL2FybTY0L2lvcnQuYyAgICAgICAgICAgICAgICAgICB8IDMwNSAr
KysrKysrKysrKysrKysrKysrKwo+ICBkcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0t
c21tdS12My5jIHwgIDkxICsrKystLQo+ICBkcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS9hcm0t
c21tdS5jICAgICAgIHwgIDY1ICsrKystCj4gIGRyaXZlcnMvaW9tbXUvZG1hLWlvbW11LmMgICAg
ICAgICAgICAgICAgICAgfCAgMjUgKysKPiAgaW5jbHVkZS9saW51eC9hY3BpX2lvcnQuaCAgICAg
ICAgICAgICAgICAgICB8ICAxNCArCj4gIGluY2x1ZGUvbGludXgvZG1hLWlvbW11LmggICAgICAg
ICAgICAgICAgICAgfCAgMTQgKwo+ICBpbmNsdWRlL2xpbnV4L2lvbW11LmggICAgICAgICAgICAg
ICAgICAgICAgIHwgICA5ICsKPiAgNyBmaWxlcyBjaGFuZ2VkLCA1MDQgaW5zZXJ0aW9ucygrKSwg
MTkgZGVsZXRpb25zKC0pCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9p
b21tdQ==
