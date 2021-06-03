Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D939C47096
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 15:37:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC1FB6100B
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 15:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC1FB6100B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 701A5405C2;
	Thu,  3 Jun 2021 15:37:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QHEf6U-HP-7N; Thu,  3 Jun 2021 15:37:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 57700405CE;
	Thu,  3 Jun 2021 15:37:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3555EC0011;
	Thu,  3 Jun 2021 15:37:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2C61C0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 15:37:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E106B83F15
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 15:37:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B36--qJk9wQr for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 15:37:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F3A7883F4B
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 15:37:20 +0000 (UTC)
Received: by mail-pf1-x435.google.com with SMTP id d16so5128744pfn.12
 for <iommu@lists.linux-foundation.org>; Thu, 03 Jun 2021 08:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BVYx1tfLGUQhuXKxLmm7FvDthvCK68hj9EtKYIRIQHQ=;
 b=miB2ljSk1RA9tY/uYJGQ9mMwA4UDMc4OP5R2SPNH1XSMN+zppyZP3Jc++5YNxmzOby
 kALkMRui/3t9gSuqF33Vb3xRJqf9zGMvEy1ThQuUuoC56/3xsrdMaI/j4lWWgNSF2sTJ
 COY0x0gCbiM503+Xvvp9Nsgl9aAqJhwkWUkCuJddQ5kBPKpL6maIzV4Esr2iyVTK2nDK
 TGTOiLPti6ZFCSfL7YPGf1T/ifO0Td+1Cseob26JVYcCljKap3dtfQjqMVk0i9iDWAeR
 pRTkE5bQUe239zrqx8ZeVhOf2I48ijf3+Yv7Odtm6yW32eQYlYwHea3YOPPmHlNYafZU
 cDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BVYx1tfLGUQhuXKxLmm7FvDthvCK68hj9EtKYIRIQHQ=;
 b=KvE1jFXiix5fm1528GFHOVwI3tHyr+45o0jPegAy8EoKhY7pga6Uswe1hs5HDqk8BS
 r52oG5YaWmjYmiK4jpG7DfyZFYcHwabqfauD9ytZ8s7XGohKKng7B8bLA/Vj3W5ZsG5I
 IjTf97mx/H+AG4l42a+a8EkFLZK59BIetR9yb6L4YmVbbtv0eCuFA2z4EhqrRT4L5/r8
 sqPEwATrfUa+bJWDekSP3LIAyTbScAeNsOkwwaUhrKnxApjscV9myYxkjpaCt2Y23Rxm
 f4tLeiSVNE0Ea/fn/5gaCVXB3djJtJZ/247pQ3FeyPcmsRBylI6eiqtRxzLjU21fLRbY
 E4Gg==
X-Gm-Message-State: AOAM531wyGyI99Xa6JVahNqXOg+xHmnqAycVDXF6PZaS9iDTAG4n6/nz
 P8JrBVptGRIDS/Bktz3zlgU=
X-Google-Smtp-Source: ABdhPJyuSSLvdEikeh+Nq/zhDPHcKBsCeWjVlIXCtWnktcvNT96pyk1AlIWziUacbt3mBXpwaDz9WA==
X-Received: by 2002:aa7:8755:0:b029:2eb:8c8f:d1f1 with SMTP id
 g21-20020aa787550000b02902eb8c8fd1f1mr271415pfo.11.1622734640422; 
 Thu, 03 Jun 2021 08:37:20 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::4b1? ([2404:f801:9000:18:efec::4b1])
 by smtp.gmail.com with ESMTPSA id
 r10sm3237979pga.48.2021.06.03.08.37.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jun 2021 08:37:19 -0700 (PDT)
Subject: Re: [RFC PATCH V3 09/11] HV/IOMMU: Enable swiotlb bounce buffer for
 Isolation VM
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>, kys@microsoft.com,
 haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 x86@kernel.org, hpa@zytor.com, arnd@arndb.de, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
 kirill.shutemov@linux.intel.com, rppt@kernel.org, hannes@cmpxchg.org,
 cai@lca.pw, krish.sadhukhan@oracle.com, saravanand@fb.com,
 Tianyu.Lan@microsoft.com, konrad.wilk@oracle.com, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com, jgross@suse.com,
 sstabellini@kernel.org, joro@8bytes.org, will@kernel.org,
 xen-devel@lists.xenproject.org, davem@davemloft.net, kuba@kernel.org,
 jejb@linux.ibm.com, martin.petersen@oracle.com
References: <20210530150628.2063957-1-ltykernel@gmail.com>
 <20210530150628.2063957-10-ltykernel@gmail.com>
 <9488c114-81ad-eb67-79c0-5ed319703d3e@oracle.com>
 <a023ee3f-ce85-b54f-79c3-146926bf3279@gmail.com>
 <d6714e8b-dcb6-798b-59a4-5bb68f789564@oracle.com>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <1cdf4e6e-6499-e209-d499-7ab82992040b@gmail.com>
Date: Thu, 3 Jun 2021 23:37:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <d6714e8b-dcb6-798b-59a4-5bb68f789564@oracle.com>
Content-Language: en-US
Cc: linux-arch@vger.kernel.org, thomas.lendacky@amd.com,
 linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 vkuznets@redhat.com, sunilmut@microsoft.com
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

T24gNi8zLzIwMjEgMTI6MDIgQU0sIEJvcmlzIE9zdHJvdnNreSB3cm90ZToKPiAKPiBPbiA2LzIv
MjEgMTE6MDEgQU0sIFRpYW55dSBMYW4gd3JvdGU6Cj4+IEhpIEJvcmlzOgo+PiAgwqDCoMKgwqBU
aGFua3MgZm9yIHlvdXIgcmV2aWV3Lgo+Pgo+PiBPbiA2LzIvMjAyMSA5OjE2IEFNLCBCb3JpcyBP
c3Ryb3Zza3kgd3JvdGU6Cj4+Pgo+Pj4gT24gNS8zMC8yMSAxMTowNiBBTSwgVGlhbnl1IExhbiB3
cm90ZToKPj4+PiBAQCAtOTEsNiArOTIsNiBAQCBpbnQgcGNpX3hlbl9zd2lvdGxiX2luaXRfbGF0
ZSh2b2lkKQo+Pj4+ICDCoCBFWFBPUlRfU1lNQk9MX0dQTChwY2lfeGVuX3N3aW90bGJfaW5pdF9s
YXRlKTsKPj4+PiAgwqAgwqAgSU9NTVVfSU5JVF9GSU5JU0goMiwKPj4+PiAtwqDCoMKgwqDCoMKg
wqDCoMKgIE5VTEwsCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoCBoeXBlcnZfc3dpb3RsYl9kZXRl
Y3QsCj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGNpX3hlbl9zd2lvdGxiX2luaXQsCj4+
Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTlVMTCk7Cj4+Pgo+Pj4KPj4+IENvdWxkIHlvdSBl
eHBsYWluIHRoaXMgY2hhbmdlPwo+Pgo+PiBIeXBlci1WIGFsbG9jYXRlcyBpdHMgb3duIHN3aW90
bGIgYm91bmNlIGJ1ZmZlciBhbmQgdGhlIGRlZmF1bHQKPj4gc3dpb3RsYiBidWZmZXIgc2hvdWxk
IG5vdCBiZSBhbGxvY2F0ZWQuIHN3aW90bGJfaW5pdCgpIGluIHBjaV9zd2lvdGxiX2luaXQoKSBp
cyB0byBhbGxvY2F0ZSBkZWZhdWx0IHN3aW90bGIgYnVmZmVyLgo+PiBUbyBhY2hpZXZlIHRoaXMs
IHB1dCBoeXBlcnZfc3dpb3RsYl9kZXRlY3QoKSBhcyB0aGUgZmlyc3QgZW50cnkgaW4gdGhlIGlv
bW11X3RhYmxlX2VudHJ5IGxpc3QuIFRoZSBkZXRlY3QgbG9vcCBpbiB0aGUgcGNpX2lvbW11X2Fs
bG9jKCkgd2lsbCBleGl0IG9uY2UgaHlwZXJ2X3N3aW90bGJfZGV0ZWN0KCkgaXMgY2FsbGVkIGlu
IEh5cGVyLVYgVk0gYW5kIG90aGVyIGlvbW11X3RhYmxlX2VudHJ5IGNhbGxiYWNrIHdpbGwgbm90
IGJlIGNhbGxlZC4KPiAKPiAKPiAKPiBSaWdodC4gQnV0IHBjaV94ZW5fc3dpb3RsYl9kZXRlY3Qo
KSB3aWxsIG9ubHkgZG8gc29tZXRoaW5nIGZvciBYZW4gUFYgZ3Vlc3RzLCBhbmQgdGhvc2UgZ3Vl
c3RzIGRvbid0IHJ1biBvbiBoeXBlclYuIEl0J3MgZWl0aGVyIHhlbl9wdl9kb21haW4oKSAoaS5l
LiBoeXBlcnZpc29yX2lzX3R5cGUoWDg2X0hZUEVSX1hFTl9QVikpIG9yIGh5cGVydmlzb3JfaXNf
dHlwZShYODZfSFlQRVJfTVNfSFlQRVJWKSBidXQgbmV2ZXIgYm90aC4gU28gSSBkb24ndCB0aGlu
ayB0aGVyZSBuZWVkcyB0byBiZSBhIGRlcGVuZGVuY3kgYmV0d2VlbiB0aGUgdHdvIGNhbGxiYWNr
cy4KClllcywgdGhlIGRlcGVuZGVuY3kgaXMgYmV0d2VlbiBoeXBlcnZfc3dpb3RsYl9kZXRlY3Qo
KSBhbmQKcGNpX3N3aW90bGJfZGV0ZWN0X292ZXJyaWRlKCkvcGNpX3N3aW90bGJfZGV0ZWN0XzRn
YigpLiBOb3cKcGNpX3N3aW90bGJfZGV0ZWN0X292ZXJyaWRlKCkgYW5kIHBjaV9zd2lvdGxiX2Rl
dGVjdF80Z2IoKSBkZXBlbmRzIG9uCnBjaV94ZW5fc3dpb3RsYl9kZXRlY3QoKS4gVG8ga2VlcCBk
ZXBlbmRlbmN5IGJldHdlZW4KaHlwZXJ2X3N3aW90bGJfZGV0ZWN0KCkgYW5kIHBjaV9zd2lvdGxi
X2RldGVjdF9vdmVycmlkZS80Z2IoKSwgbWFrZSAKcGNpX3hlbl9zd2lvdGxiX2RldGVjdCgpIGRl
cGVuZHMgb24gaHlwZXJ2X3N3aW90bGJfZGV0ZWN0KCkgYW5kIGp1c3QgdG8Ka2VlcCBvcmRlciBp
biB0aGUgSU9NTVUgdGFibGUuIEN1cnJlbnQgaW9tbXVfdGFibGVfZW50cnkgb25seSBoYXMgb25l
CmRlcGVuZCBjYWxsYmFjayBhbmQgdGhpcyBpcyB3aHkgSSBwdXQgeGVuIGRlcGVuZHMgb24gaHlw
ZXJ2IGRldGVjdCBmdW5jdGlvbi4KClRoYW5rcy4KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2lvbW11
