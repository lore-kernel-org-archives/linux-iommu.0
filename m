Return-Path: <SRS0=/53O=JI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BE1C433B4
	for <iommu@archiver.kernel.org>; Sun, 11 Apr 2021 12:12:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4A35610CB
	for <iommu@archiver.kernel.org>; Sun, 11 Apr 2021 12:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4A35610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 931E540326;
	Sun, 11 Apr 2021 12:12:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HP7_NRBzLkd0; Sun, 11 Apr 2021 12:12:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 439ED402F8;
	Sun, 11 Apr 2021 12:12:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17872C000B;
	Sun, 11 Apr 2021 12:12:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F2A4C000A
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 12:12:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6AD8C400E0
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 12:12:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eDb-Tu6cNPS7 for <iommu@lists.linux-foundation.org>;
 Sun, 11 Apr 2021 12:12:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C5B03400C2
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 12:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618143166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cd5a7MnBxaCycfDTV6DQTS58oQm03SFk+/qhnkSwHlw=;
 b=CIPfQv4udf2X1b7yCJPTtHGea6TEjO3MF//RveBRyXOaru4hvmf5WjU4VAnB8mAtqDbFNQ
 zx6aBQkb0HPGvlFMdzGuKwZpUwmV3jneD2H5wXTQBdsGXyo52vm/d4vWzTZFbN86X5C19T
 WNfES4J4VLAyDC7hNDB/YQ2oYj6RabU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-r9GIkX2eOQKuVWu8pninBQ-1; Sun, 11 Apr 2021 08:12:42 -0400
X-MC-Unique: r9GIkX2eOQKuVWu8pninBQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 141AD10053E6;
 Sun, 11 Apr 2021 12:12:40 +0000 (UTC)
Received: from [10.36.112.22] (ovpn-112-22.ams2.redhat.com [10.36.112.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 362465D6D3;
 Sun, 11 Apr 2021 12:12:29 +0000 (UTC)
Subject: Re: [PATCH v12 01/13] vfio: VFIO_IOMMU_SET_PASID_TABLE
To: Zenghui Yu <yuzenghui@huawei.com>
References: <20210223210625.604517-1-eric.auger@redhat.com>
 <20210223210625.604517-2-eric.auger@redhat.com>
 <d0f254c3-0b63-e4d3-1f58-8940adc7c0bf@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <513f8129-7ddc-f19f-e25a-e2a4b6cbe593@redhat.com>
Date: Sun, 11 Apr 2021 14:12:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <d0f254c3-0b63-e4d3-1f58-8940adc7c0bf@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: kvm@vger.kernel.org, vivek.gautam@arm.com, kvmarm@lists.cs.columbia.edu,
 eric.auger.pro@gmail.com, jean-philippe@linaro.org, wangxingang5@huawei.com,
 maz@kernel.org, jiangkunkun@huawei.com, vsethi@nvidia.com,
 zhangfei.gao@linaro.org, will@kernel.org, alex.williamson@redhat.com,
 wanghaibin.wang@huawei.com, linux-kernel@vger.kernel.org,
 lushenming@huawei.com, iommu@lists.linux-foundation.org, robin.murphy@arm.com
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGkgWmVuZ2h1aSwKCk9uIDQvNy8yMSAxMTozMyBBTSwgWmVuZ2h1aSBZdSB3cm90ZToKPiBIaSBF
cmljLAo+IAo+IE9uIDIwMjEvMi8yNCA1OjA2LCBFcmljIEF1Z2VyIHdyb3RlOgo+PiArLyoKPj4g
KyAqIFZGSU9fSU9NTVVfU0VUX1BBU0lEX1RBQkxFIC0gX0lPV1IoVkZJT19UWVBFLCBWRklPX0JB
U0UgKyAxOCwKPj4gKyAqwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgdmZpb19pb21tdV90
eXBlMV9zZXRfcGFzaWRfdGFibGUpCj4+ICsgKgo+PiArICogVGhlIFNFVCBvcGVyYXRpb24gcGFz
c2VzIGEgUEFTSUQgdGFibGUgdG8gdGhlIGhvc3Qgd2hpbGUgdGhlCj4+ICsgKiBVTlNFVCBvcGVy
YXRpb24gZGV0YWNoZXMgdGhlIG9uZSBjdXJyZW50bHkgcHJvZ3JhbW1lZC4gU2V0dGluZwo+PiAr
ICogYSB0YWJsZSB3aGlsZSBhbm90aGVyIGlzIGFscmVhZHkgcHJvZ3JhbW1lZCByZXBsYWNlcyB0
aGUgb2xkIHRhYmxlLgo+IAo+IEl0IGxvb2tzIHRvIG1lIHRoYXQgdGhpcyBkZXNjcmlwdGlvbiBk
b2Vzbid0IG1hdGNoIHRoZSBJT01NVSBwYXJ0LgoKWWVwIHRoYXQncyBtaXNsZWFuZGluZy4KCkkg
cmVwbGFjZWQgaXQgYnk6CgogSXQgaXMgYWxsb3dlZCB0byAiU0VUIiB0aGUgdGFibGUgc2V2ZXJh
bCB0aW1lcyB3aXRob3V0IHVuLXNldHRpbmcgYXMKIGxvbmcgYXMgdGhlIHRhYmxlIGNvbmZpZyBk
b2VzIG5vdCBzdGF5IElPTU1VX1BBU0lEX0NPTkZJR19UUkFOU0xBVEUuCgo+IAo+IFt2MTQsMDUv
MTNdIGlvbW11L3NtbXV2MzogSW1wbGVtZW50IGF0dGFjaC9kZXRhY2hfcGFzaWRfdGFibGUKPiAK
PiB8wqDCoMKgIGNhc2UgSU9NTVVfUEFTSURfQ09ORklHX1RSQU5TTEFURToKPiB8wqDCoMKgwqDC
oMKgwqAgLyogd2UgZG8gbm90IHN1cHBvcnQgUzEgPC0+IFMxIHRyYW5zaXRpb25zICovCj4gfMKg
wqDCoMKgwqDCoMKgIGlmIChzbW11X2RvbWFpbi0+czFfY2ZnLnNldCkKPiB8wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBnb3RvIG91dDsKPiAKPiBNYXliZSBJJ3ZlIG1pc3JlYWQgc29tZXRoaW5nPwo+
IAo+IAo+IFRoYW5rcywKPiBaZW5naHVpCj4gCgpUaGFua3MKCkVyaWMKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
