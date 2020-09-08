Return-Path: <SRS0=mWlM=CR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C915BC433E2
	for <iommu@archiver.kernel.org>; Tue,  8 Sep 2020 15:56:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66FFD22AAE
	for <iommu@archiver.kernel.org>; Tue,  8 Sep 2020 15:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66FFD22AAE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1797787323;
	Tue,  8 Sep 2020 15:56:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L160fGRnUHP1; Tue,  8 Sep 2020 15:56:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 69EFE872E1;
	Tue,  8 Sep 2020 15:56:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4FF6AC0859;
	Tue,  8 Sep 2020 15:56:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C547C0051;
 Tue,  8 Sep 2020 15:56:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4776186BCF;
 Tue,  8 Sep 2020 15:56:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Uevf-nF8caup; Tue,  8 Sep 2020 15:56:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7762286BCB;
 Tue,  8 Sep 2020 15:56:45 +0000 (UTC)
IronPort-SDR: KrOG8BAZFAMEa6AgYm1PumUY7qePRoF+ZhV8zewoQRdfRQmS2fDiHAu/G2c2wqe+N3wxr49B+D
 RYIRnV7onZaA==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="158187797"
X-IronPort-AV: E=Sophos;i="5.76,406,1592895600"; d="scan'208";a="158187797"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2020 08:56:44 -0700
IronPort-SDR: YANWrMkTd1FugPil6mGFdkv+qxckXVy2g77AMKPVdK9t3wgN+0Qrzn6R1YfAuSUaMlLZ8RRpTW
 oW//U4NX6FBg==
X-IronPort-AV: E=Sophos;i="5.76,406,1592895600"; d="scan'208";a="480079848"
Received: from sderix-mobl1.ger.corp.intel.com (HELO [10.214.213.131])
 ([10.214.213.131])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2020 08:56:33 -0700
Subject: Re: [Intel-gfx] [PATCH 0/8] Convert the intel iommu driver to the
 dma-iommu api
To: Logan Gunthorpe <logang@deltatee.com>, Tom Murphy <murphyt7@tcd.ie>
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
 <e598fb31-ef7a-c2ee-8a54-bf62d50c480c@deltatee.com>
From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
Message-ID: <b27cae1f-07ff-bef2-f125-a5f0d968016d@linux.intel.com>
Date: Tue, 8 Sep 2020 16:56:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e598fb31-ef7a-c2ee-8a54-bf62d50c480c@deltatee.com>
Content-Language: en-US
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Ck9uIDA4LzA5LzIwMjAgMTY6NDQsIExvZ2FuIEd1bnRob3JwZSB3cm90ZToKPiBPbiAyMDIwLTA5
LTA4IDk6MjggYS5tLiwgVHZydGtvIFVyc3VsaW4gd3JvdGU6Cj4+Pgo+Pj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9pOTE1L2k5MTVfc2NhdHRlcmxpc3QuaAo+Pj4gYi9kcml2ZXJzL2dw
dS9kcm0vaTkxNS9pOTE1Cj4+PiBpbmRleCBiN2I1OTMyOGNiNzYuLjkzNjdhYzgwMWYwYyAxMDA2
NDQKPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2k5MTVfc2NhdHRlcmxpc3QuaAo+Pj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvaTkxNV9zY2F0dGVybGlzdC5oCj4+PiBAQCAtMjcs
MTMgKzI3LDE5IEBAIHN0YXRpYyBfX2Fsd2F5c19pbmxpbmUgc3RydWN0IHNndF9pdGVyIHsKPj4+
ICDCoCB9IF9fc2d0X2l0ZXIoc3RydWN0IHNjYXR0ZXJsaXN0ICpzZ2wsIGJvb2wgZG1hKSB7Cj4+
PiAgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3Qgc2d0X2l0ZXIgcyA9IHsgLnNncCA9IHNnbCB9Owo+
Pj4KPj4+ICvCoMKgwqDCoMKgwqAgaWYgKHNnbCAmJiAhc2dfZG1hX2xlbihzLnNncCkpCj4+Cj4+
IEknZCBleHRlbmQgdGhlIGNvbmRpdGlvbiB0byBiZSwganVzdCB0byBiZSBzYWZlOgo+PiAgwqDC
oMKgwqBpZiAoZG1hICYmIHNnbCAmJiAhc2dfZG1hX2xlbihzLnNncCkpCj4+Cj4gCj4gUmlnaHQs
IGdvb2QgY2F0Y2gsIHRoYXQncyBkZWZpbml0ZWx5IG5lY2Vzc2FyeS4KPiAKPj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHMuc2dwID0gTlVMTDsKPj4+ICsKPj4+ICDCoMKgwqDCoMKg
wqDCoMKgIGlmIChzLnNncCkgewo+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHMubWF4ID0gcy5jdXJyID0gcy5zZ3AtPm9mZnNldDsKPj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHMubWF4ICs9IHMuc2dwLT5sZW5ndGg7Cj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBpZiAoZG1hKQo+Pj4gKwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgaWYgKGRtYSkgewo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHMubWF4ICs9IHNnX2RtYV9sZW4ocy5zZ3ApOwo+Pj4gIMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzLmRtYSA9IHNnX2RtYV9hZGRyZXNzKHMu
c2dwKTsKPj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVsc2UKPj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0gZWxzZSB7Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcy5tYXggKz0gcy5zZ3AtPmxlbmd0aDsKPj4+ICDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcy5wZm4gPSBwYWdl
X3RvX3BmbihzZ19wYWdlKHMuc2dwKSk7Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB9Cj4+Cj4+IE90aGVyd2lzZSBoYXMgdGhpcyBiZWVuIHRlc3RlZCBvciBhbHRlcm5hdGl2ZWx5
IGhvdyB0byB0ZXN0IGl0PyAoSG93IHRvCj4+IHJlcHJvIHRoZSBpc3N1ZS4pCj4gCj4gSXQgaGFz
IG5vdCBiZWVuIHRlc3RlZC4gVG8gdGVzdCBpdCwgeW91IG5lZWQgVG9tJ3MgcGF0Y2ggc2V0IHdp
dGhvdXQgdGhlCj4gbGFzdCAiRE8gTk9UIE1FUkdFIiBwYXRjaDoKPiAKPiBodHRwczovL2xrbWwu
a2VybmVsLm9yZy9sa21sLzIwMjAwOTA3MDcwMDM1LkdBMjUxMTRAaW5mcmFkZWFkLm9yZy9ULwoK
VG9tLCBkbyB5b3UgaGF2ZSBhIGJyYW5jaCBzb21ld2hlcmUgSSBjb3VsZCBwdWxsIGZyb20/IChK
dXN0IGJlaW5nIGxhenkgCmFib3V0IGRvd25sb2FkaW5nIGEgYnVuY2ggb2YgbWVzc2FnZXMgZnJv
bSB0aGUgYXJjaGl2ZXMuKQoKV2hhdCBHUFUgaXMgaW4geW91ciBMZW5vdm8geDEgY2FyYm9uIDV0
aCBnZW5lcmF0aW9uIGFuZCB3aGF0IApncmFwaGljYWwvZGVza3RvcCBzZXR1cCBJIG5lZWQgdG8g
cmVwcm8/CgpSZWdhcmRzLAoKVHZydGtvCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby9pb21tdQ==
