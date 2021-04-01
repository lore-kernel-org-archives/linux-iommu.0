Return-Path: <SRS0=bVsO=I6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E39C433ED
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 12:06:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 629B4610E8
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 12:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 629B4610E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E637F414EA;
	Thu,  1 Apr 2021 12:06:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7yEbPFKqmJ7N; Thu,  1 Apr 2021 12:06:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9B22B40F78;
	Thu,  1 Apr 2021 12:06:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74CECC000B;
	Thu,  1 Apr 2021 12:06:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9C91C000A
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 12:06:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 943A840FA7
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 12:06:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d2PNOEzzb7iZ for <iommu@lists.linux-foundation.org>;
 Thu,  1 Apr 2021 12:06:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 841A440F78
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 12:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617278781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7sDTaVgWT9Uk0Jsav/2bWha3xiyU83b/ipUGLZIGqss=;
 b=dOTS7NrQtRTlTc7G97RlaFkXJ5/bjvGhNq1R3HKMfJ/RJHfXeeoBybQuWR0qbWC0CwYwjV
 RD4JTyT/remp5Lf9DsFm4XzUDpzr5P9cN8uurMY+5gqG/vQN+MOI/zXQtbyWoNxzhe0aiO
 LGvrkJkKEktFGZ9H0hNqtPfBEJEb04Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-8xDbHPHKMEmK88BxDa-lVA-1; Thu, 01 Apr 2021 08:06:17 -0400
X-MC-Unique: 8xDbHPHKMEmK88BxDa-lVA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E82FA1007478;
 Thu,  1 Apr 2021 12:06:13 +0000 (UTC)
Received: from [10.36.112.13] (ovpn-112-13.ams2.redhat.com [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1577251DE2;
 Thu,  1 Apr 2021 12:06:07 +0000 (UTC)
Subject: Re: [PATCH v14 07/13] iommu/smmuv3: Implement cache_invalidate
To: Zenghui Yu <yuzenghui@huawei.com>
References: <20210223205634.604221-1-eric.auger@redhat.com>
 <20210223205634.604221-8-eric.auger@redhat.com>
 <95a178f0-fc84-b9a2-d824-c09ea91c9d30@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <86d5f9e9-1c84-91c4-75a8-770dd4c591a7@redhat.com>
Date: Thu, 1 Apr 2021 14:06:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <95a178f0-fc84-b9a2-d824-c09ea91c9d30@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

SGkgWmVuZ2h1aSwKCk9uIDQvMS8yMSA4OjExIEFNLCBaZW5naHVpIFl1IHdyb3RlOgo+IEhpIEVy
aWMsCj4gCj4gT24gMjAyMS8yLzI0IDQ6NTYsIEVyaWMgQXVnZXIgd3JvdGU6Cj4+ICtzdGF0aWMg
aW50Cj4+ICthcm1fc21tdV9jYWNoZV9pbnZhbGlkYXRlKHN0cnVjdCBpb21tdV9kb21haW4gKmRv
bWFpbiwgc3RydWN0IGRldmljZQo+PiAqZGV2LAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgc3RydWN0IGlvbW11X2NhY2hlX2ludmFsaWRhdGVfaW5mbyAqaW52X2luZm8pCj4+ICt7Cj4+
ICvCoMKgwqAgc3RydWN0IGFybV9zbW11X2NtZHFfZW50IGNtZCA9IHsub3Bjb2RlID0gQ01EUV9P
UF9UTEJJX05TTkhfQUxMfTsKPj4gK8KgwqDCoCBzdHJ1Y3QgYXJtX3NtbXVfZG9tYWluICpzbW11
X2RvbWFpbiA9IHRvX3NtbXVfZG9tYWluKGRvbWFpbik7Cj4+ICvCoMKgwqAgc3RydWN0IGFybV9z
bW11X2RldmljZSAqc21tdSA9IHNtbXVfZG9tYWluLT5zbW11Owo+PiArCj4+ICvCoMKgwqAgaWYg
KHNtbXVfZG9tYWluLT5zdGFnZSAhPSBBUk1fU01NVV9ET01BSU5fTkVTVEVEKQo+PiArwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7Cj4+ICsKPj4gK8KgwqDCoCBpZiAoIXNtbXUpCj4+ICvC
oMKgwqDCoMKgwqDCoCByZXR1cm4gLUVJTlZBTDsKPj4gKwo+PiArwqDCoMKgIGlmIChpbnZfaW5m
by0+dmVyc2lvbiAhPSBJT01NVV9DQUNIRV9JTlZBTElEQVRFX0lORk9fVkVSU0lPTl8xKQo+PiAr
wqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7Cj4+ICsKPj4gK8KgwqDCoCBpZiAoaW52X2lu
Zm8tPmNhY2hlICYgSU9NTVVfQ0FDSEVfSU5WX1RZUEVfUEFTSUQgfHwKPiAKPiBJIGRpZG4ndCBm
aW5kIGFueSBjb2RlIHdoZXJlIHdlIHdvdWxkIGVtdWxhdGUgdGhlIENGR0lfQ0R7X0FMTH0gY29t
bWFuZHMKPiBmb3IgZ3Vlc3QgYW5kIGludmFsaWRhdGUgdGhlIHN0YWxlIENEIGVudHJpZXMgb24g
dGhlIHBoeXNpY2FsIHNpZGUuIElzCj4gUEFTSUQtY2FjaGUgdHlwZSBkZXNpZ25lZCBmb3IgdGhh
dCBlZmZlY3Q/ClllcyBpdCBpcy4gUEFTSUQtY2FjaGUgbWF0Y2hlcyB0aGUgQ0QgdGFibGUuCj4g
Cj4+ICvCoMKgwqDCoMKgwqDCoCBpbnZfaW5mby0+Y2FjaGUgJiBJT01NVV9DQUNIRV9JTlZfVFlQ
RV9ERVZfSU9UTEIpIHsKPj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAtRU5PRU5UOwo+PiArwqDC
oMKgIH0KPj4gKwo+PiArwqDCoMKgIGlmICghKGludl9pbmZvLT5jYWNoZSAmIElPTU1VX0NBQ0hF
X0lOVl9UWVBFX0lPVExCKSkKPj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlOVkFMOwo+PiAr
Cj4+ICvCoMKgwqAgLyogSU9UTEIgaW52YWxpZGF0aW9uICovCj4+ICsKPj4gK8KgwqDCoCBzd2l0
Y2ggKGludl9pbmZvLT5ncmFudWxhcml0eSkgewo+PiArwqDCoMKgIGNhc2UgSU9NTVVfSU5WX0dS
QU5VX1BBU0lEOgo+PiArwqDCoMKgIHsKPj4gK8KgwqDCoMKgwqDCoMKgIHN0cnVjdCBpb21tdV9p
bnZfcGFzaWRfaW5mbyAqaW5mbyA9Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZpbnZfaW5m
by0+Z3JhbnUucGFzaWRfaW5mbzsKPj4gKwo+PiArwqDCoMKgwqDCoMKgwqAgaWYgKGluZm8tPmZs
YWdzICYgSU9NTVVfSU5WX0FERFJfRkxBR1NfUEFTSUQpCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHJldHVybiAtRU5PRU5UOwo+PiArwqDCoMKgwqDCoMKgwqAgaWYgKCEoaW5mby0+ZmxhZ3Mg
JiBJT01NVV9JTlZfUEFTSURfRkxBR1NfQVJDSElEKSkKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIC1FSU5WQUw7Cj4+ICsKPj4gK8KgwqDCoMKgwqDCoMKgIF9fYXJtX3NtbXVfdGxi
X2ludl9jb250ZXh0KHNtbXVfZG9tYWluLCBpbmZvLT5hcmNoaWQpOwo+PiArwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIDA7Cj4+ICvCoMKgwqAgfQo+PiArwqDCoMKgIGNhc2UgSU9NTVVfSU5WX0dSQU5V
X0FERFI6Cj4+ICvCoMKgwqAgewo+PiArwqDCoMKgwqDCoMKgwqAgc3RydWN0IGlvbW11X2ludl9h
ZGRyX2luZm8gKmluZm8gPSAmaW52X2luZm8tPmdyYW51LmFkZHJfaW5mbzsKPj4gK8KgwqDCoMKg
wqDCoMKgIHNpemVfdCBzaXplID0gaW5mby0+bmJfZ3JhbnVsZXMgKiBpbmZvLT5ncmFudWxlX3Np
emU7Cj4+ICvCoMKgwqDCoMKgwqDCoCBib29sIGxlYWYgPSBpbmZvLT5mbGFncyAmIElPTU1VX0lO
Vl9BRERSX0ZMQUdTX0xFQUY7Cj4+ICsKPj4gK8KgwqDCoMKgwqDCoMKgIGlmIChpbmZvLT5mbGFn
cyAmIElPTU1VX0lOVl9BRERSX0ZMQUdTX1BBU0lEKQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCByZXR1cm4gLUVOT0VOVDsKPj4gKwo+PiArwqDCoMKgwqDCoMKgwqAgaWYgKCEoaW5mby0+Zmxh
Z3MgJiBJT01NVV9JTlZfQUREUl9GTEFHU19BUkNISUQpKQo+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBicmVhazsKPj4gKwo+PiArwqDCoMKgwqDCoMKgwqAgYXJtX3NtbXVfdGxiX2ludl9yYW5n
ZV9kb21haW4oaW5mby0+YWRkciwgc2l6ZSwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGluZm8tPmdyYW51bGVfc2l6ZSwgbGVhZiwKPj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGluZm8tPmFy
Y2hpZCwgc21tdV9kb21haW4pOwo+PiArCj4+ICvCoMKgwqDCoMKgwqDCoCBhcm1fc21tdV9jbWRx
X2lzc3VlX3N5bmMoc21tdSk7Cj4gCj4gVGhlcmUgaXMgbm8gbmVlZCB0byBpc3N1ZSBvbmUgbW9y
ZSBTWU5DLgpIdW0geWVzIEkgZGlkIG5vdCBub3RpY2UgaXQgd2FzIG1hZGUgYnkgdGhlIGFybV9z
bW11X2NtZHFfaXNzdWVfY21kbGlzdCgpCgpUaGFua3MhCgpFcmljCj4gCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9t
bXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
