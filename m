Return-Path: <SRS0=mWlM=CR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC694C433E2
	for <iommu@archiver.kernel.org>; Tue,  8 Sep 2020 15:44:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31A1124837
	for <iommu@archiver.kernel.org>; Tue,  8 Sep 2020 15:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="dbg0PtMP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A1124837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C4F80872F5;
	Tue,  8 Sep 2020 15:44:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iTUPb1MQRM1t; Tue,  8 Sep 2020 15:44:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 02E86872F1;
	Tue,  8 Sep 2020 15:44:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5A87C0859;
	Tue,  8 Sep 2020 15:44:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2FECDC0051;
 Tue,  8 Sep 2020 15:44:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id EE5F0273A9;
 Tue,  8 Sep 2020 15:44:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9-D8tbqEquot; Tue,  8 Sep 2020 15:44:32 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by silver.osuosl.org (Postfix) with ESMTPS id 36D33203BF;
 Tue,  8 Sep 2020 15:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DvSiEr2JCy+2h9dy7CIecEenG2gQsa0A5OP2d9PI/p0=; b=dbg0PtMPK+HbvI6GMZzh/J5E8Z
 Q/TWc7UsDFhg1cOVJt/pysWKo3QQRWraF1mqHM6mdRGQ6y0rj+OXqZUSgbgyS5kW1MF22xpb3bm/M
 J9Rf7mpjgRlZVOcx1SZJ6EJp7lFy55R6nqk8PsS8AEsD0hf0g4vJC65mDtFEAYzf7cE0mQHAAVUlU
 S7bbDUQqTHtHsrq5f8RHYZU0yCa5rG3lpeqMLTKlNXStV+C6+vhM0UL/8Wjc5CgLnNZYF3jPybjc/
 ulyb1L7dumDVfTJQeMlSwf7IyaVvWKGWBe0b9ikUV9lDLMezAf5m+fY9DJk+AU+8aTTS01s/mCgwR
 I5zJe2Ew==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1kFfnI-0008Go-Gj; Tue, 08 Sep 2020 09:44:29 -0600
To: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Tom Murphy <murphyt7@tcd.ie>
References: <20191221150402.13868-1-murphyt7@tcd.ie>
 <465815ae-9292-f37a-59b9-03949cb68460@deltatee.com>
 <20200529124523.GA11817@infradead.org>
 <CGME20200529190523eucas1p2c086133e707257c0cdc002f502d4f51d@eucas1p2.samsung.com>
 <33137cfb-603c-86e8-1091-f36117ecfaf3@deltatee.com>
 <ef2150d5-7b6a-df25-c10d-e43316fe7812@samsung.com>
 <b9140772-0370-a858-578c-af503a06d8e9@deltatee.com>
 <CALQxJuutRaeX89k2o4ffTKYRMizmMu0XbRnzpFuSSrkQR02jKg@mail.gmail.com>
 <766525c3-4da9-6db7-cd90-fb4b82cd8083@deltatee.com>
 <60a82319-cbee-4cd1-0d5e-3c407cc51330@linux.intel.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e598fb31-ef7a-c2ee-8a54-bf62d50c480c@deltatee.com>
Date: Tue, 8 Sep 2020 09:44:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <60a82319-cbee-4cd1-0d5e-3c407cc51330@linux.intel.com>
Content-Language: en-US
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, kgene@kernel.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 cohuck@redhat.com, dwmw2@infradead.org, gerald.schaefer@de.ibm.com,
 virtualization@lists.linux-foundation.org, tglx@linutronix.de,
 matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
 intel-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 agross@kernel.org, linux-rockchip@lists.infradead.org, hch@infradead.org,
 jonathanh@nvidia.com, krzk@kernel.org, maz@kernel.org,
 linux-samsung-soc@vger.kernel.org, jean-philippe@linaro.org,
 m.szyprowski@samsung.com, will@kernel.org, julien.grall@arm.com,
 linux-tegra@vger.kernel.org, bjorn.andersson@linaro.org,
 dri-devel@lists.freedesktop.org, airlied@linux.ie, kvm@vger.kernel.org,
 murphyt7@tcd.ie, tvrtko.ursulin@linux.intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [Intel-gfx] [PATCH 0/8] Convert the intel iommu driver to the
 dma-iommu api
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: kvm@vger.kernel.org, David Airlie <airlied@linux.ie>,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 Julien Grall <julien.grall@arm.com>, Will Deacon <will@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-samsung-soc@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, linux-rockchip@lists.infradead.org,
 Andy Gross <agross@kernel.org>, Gerald Schaefer <gerald.schaefer@de.ibm.com>,
 linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 virtualization@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Kukjin Kim <kgene@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>
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

CgpPbiAyMDIwLTA5LTA4IDk6MjggYS5tLiwgVHZydGtvIFVyc3VsaW4gd3JvdGU6Cj4+Cj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9pOTE1X3NjYXR0ZXJsaXN0LmgKPj4gYi9k
cml2ZXJzL2dwdS9kcm0vaTkxNS9pOTE1Cj4+IGluZGV4IGI3YjU5MzI4Y2I3Ni4uOTM2N2FjODAx
ZjBjIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9pOTE1X3NjYXR0ZXJsaXN0
LmgKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvaTkxNV9zY2F0dGVybGlzdC5oCj4+IEBA
IC0yNywxMyArMjcsMTkgQEAgc3RhdGljIF9fYWx3YXlzX2lubGluZSBzdHJ1Y3Qgc2d0X2l0ZXIg
ewo+PiDCoCB9IF9fc2d0X2l0ZXIoc3RydWN0IHNjYXR0ZXJsaXN0ICpzZ2wsIGJvb2wgZG1hKSB7
Cj4+IMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHNndF9pdGVyIHMgPSB7IC5zZ3AgPSBzZ2wgfTsK
Pj4KPj4gK8KgwqDCoMKgwqDCoCBpZiAoc2dsICYmICFzZ19kbWFfbGVuKHMuc2dwKSkKPiAKPiBJ
J2QgZXh0ZW5kIHRoZSBjb25kaXRpb24gdG8gYmUsIGp1c3QgdG8gYmUgc2FmZToKPiDCoMKgwqDC
oGlmIChkbWEgJiYgc2dsICYmICFzZ19kbWFfbGVuKHMuc2dwKSkKPgoKUmlnaHQsIGdvb2QgY2F0
Y2gsIHRoYXQncyBkZWZpbml0ZWx5IG5lY2Vzc2FyeS4KCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHMuc2dwID0gTlVMTDsKPj4gKwo+PiDCoMKgwqDCoMKgwqDCoMKgIGlmIChzLnNn
cCkgewo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzLm1heCA9IHMuY3VyciA9
IHMuc2dwLT5vZmZzZXQ7Cj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHMubWF4ICs9
IHMuc2dwLT5sZW5ndGg7Cj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChkbWEp
Cj4+ICsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGRtYSkgewo+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcy5tYXggKz0gc2dfZG1h
X2xlbihzLnNncCk7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBzLmRtYSA9IHNnX2RtYV9hZGRyZXNzKHMuc2dwKTsKPj4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgZWxzZQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9IGVs
c2Ugewo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcy5t
YXggKz0gcy5zZ3AtPmxlbmd0aDsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHMucGZuID0gcGFnZV90b19wZm4oc2dfcGFnZShzLnNncCkpOwo+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gCj4gT3RoZXJ3aXNlIGhhcyB0aGlzIGJl
ZW4gdGVzdGVkIG9yIGFsdGVybmF0aXZlbHkgaG93IHRvIHRlc3QgaXQ/IChIb3cgdG8KPiByZXBy
byB0aGUgaXNzdWUuKQoKSXQgaGFzIG5vdCBiZWVuIHRlc3RlZC4gVG8gdGVzdCBpdCwgeW91IG5l
ZWQgVG9tJ3MgcGF0Y2ggc2V0IHdpdGhvdXQgdGhlCmxhc3QgIkRPIE5PVCBNRVJHRSIgcGF0Y2g6
CgpodHRwczovL2xrbWwua2VybmVsLm9yZy9sa21sLzIwMjAwOTA3MDcwMDM1LkdBMjUxMTRAaW5m
cmFkZWFkLm9yZy9ULwoKVGhhbmtzLAoKTG9nYW4KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2lvbW11
