Return-Path: <SRS0=MyXX=DI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573E4C47423
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 04:05:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D07C421D7D
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 04:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5xaEfBc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D07C421D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5810A228EB;
	Thu,  1 Oct 2020 04:05:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vxXqBhaK13FX; Thu,  1 Oct 2020 04:05:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C6768228DC;
	Thu,  1 Oct 2020 04:05:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B35DAC0889;
	Thu,  1 Oct 2020 04:05:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7F6DC0051
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 04:05:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9086587292
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 04:05:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ujnvNFgFuSuT for <iommu@lists.linux-foundation.org>;
 Thu,  1 Oct 2020 04:05:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
 [209.85.208.196])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1A44D87291
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 04:05:03 +0000 (UTC)
Received: by mail-lj1-f196.google.com with SMTP id v23so3431414ljd.1
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 21:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4qFJEZiPLmg9u9W5QYna2OZEUfz9MtyCy7mA+ICTo1g=;
 b=M5xaEfBcC9EtbINBwGw4i/0+Nw+ePBsBY7HpPZsmhZQSsUpvgm99fltKKaQsxwhGgV
 sxXJ72bYTlARe2QzjDpqpeIMSt5urFVIG2fe5YgbevVNO+UWS/CQyEJSAo8rmkRCYnXQ
 pZf7Mued90MklbHxfRJRrhsD4oUcwu+dFTYs6UjD9YKvQyMb38MS+nFecxp2koU9OnwY
 boAg4blzbqNIHuF3P6ty2CMMKTNsE81P5UPei/P+eEAbWUz2viAjzGYPs0Cd+poFoaap
 ITUNvvhsozRcIw0szsVf9aCTbTqPRz90Fk858piggd396svSaN7eNc6vT3Tno73BQ8Hr
 aVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4qFJEZiPLmg9u9W5QYna2OZEUfz9MtyCy7mA+ICTo1g=;
 b=EclfDSEIXfvTyR0Y0c2exkStWZEh6fN4S3bOdNS8F0UqWH+JMWqCn/xmsJo7wimbh0
 Krb4M7f2+BZ40w9CYnOcnB8/qL/FpzIQOMwY0Pu8HVin+E5XBpQeI5lJXIlHWIvxncKu
 XyVOWXMxUNaLgv8iKMSZWNXI0Xa5YkaREpt8VlpTV1E2KnqAedmg9nT6jbE6J3SlRNs1
 T59Zv0tIzQRM578WBOG+2vSoOaAPNh8/JLEi6K6jQi+oAHbi4D+eg2G1jKiQH1cGGtye
 FRa5hul+SYvVMFZKjKKmgYBMGVWwy6gL/CwEGfN6YtroQTl/D93mzpFfsj//uj2ECz8M
 Lcng==
X-Gm-Message-State: AOAM5338+5whugWXTomwQO4N94/ob8rK8gfd0IrMzBnRtMg0UR9AMitu
 moSnVdaPaxu+NbVjwVnFf6A=
X-Google-Smtp-Source: ABdhPJzh3h0DBGaC15b1cZr0yr5GTomERNHhtpdt3BwUAiX93aUCGOZ9lOBNc2GdME4cqxx5xQSQEQ==
X-Received: by 2002:a2e:9588:: with SMTP id w8mr1544467ljh.298.1601525101140; 
 Wed, 30 Sep 2020 21:05:01 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.91.252])
 by smtp.googlemail.com with ESMTPSA id i7sm314259ljb.44.2020.09.30.21.04.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2020 21:05:00 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
To: Nicolin Chen <nicoleotsuka@gmail.com>
References: <20200930084258.25493-1-nicoleotsuka@gmail.com>
 <20200930084258.25493-3-nicoleotsuka@gmail.com>
 <20200930153131.GB3833404@ulmo> <20200930203618.GC2110@Asurada-Nvidia>
 <13746922-0253-cda7-e9ac-2bd20bf1a17f@gmail.com>
 <20200930213244.GA10573@Asurada-Nvidia>
 <5945a63e-79d8-e3ae-ab53-cee8c220ac7d@gmail.com>
 <20201001012630.GA28240@Asurada-Nvidia>
 <72b11925-5857-8ce5-d084-cab01ca1b396@gmail.com>
 <20201001024850.GA28456@Asurada-Nvidia>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <aad6f530-6b62-b75d-44ad-0376650efc86@gmail.com>
Date: Thu, 1 Oct 2020 07:04:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201001024850.GA28456@Asurada-Nvidia>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 krzk@kernel.org, jonathanh@nvidia.com,
 Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org
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

MDEuMTAuMjAyMCAwNTo0OCwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gT24gVGh1LCBPY3Qg
MDEsIDIwMjAgYXQgMDU6MDY6MTlBTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+PiAw
MS4xMC4yMDIwIDA0OjI2LCBOaWNvbGluIENoZW4g0L/QuNGI0LXRgjoKPj4+IE9uIFRodSwgT2N0
IDAxLCAyMDIwIGF0IDEyOjU2OjQ2QU0gKzAzMDAsIERtaXRyeSBPc2lwZW5rbyB3cm90ZToKPj4+
PiAwMS4xMC4yMDIwIDAwOjMyLCBOaWNvbGluIENoZW4g0L/QuNGI0LXRgjoKPj4+Pj4gT24gVGh1
LCBPY3QgMDEsIDIwMjAgYXQgMTI6MjQ6MjVBTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3Rl
Ogo+Pj4+Pj4gLi4uCj4+Pj4+Pj4+IEl0IGxvb2tzIHRvIG1lIGxpa2UgdGhlIG9ubHkgcmVhc29u
IHdoeSB5b3UgbmVlZCB0aGlzIG5ldyBnbG9iYWwgQVBJIGlzCj4+Pj4+Pj4+IGJlY2F1c2UgUENJ
IGRldmljZXMgbWF5IG5vdCBoYXZlIGEgZGV2aWNlIHRyZWUgbm9kZSB3aXRoIGEgcGhhbmRsZSB0
bwo+Pj4+Pj4+PiB0aGUgSU9NTVUuIEhvd2V2ZXIsIFNNTVUgc3VwcG9ydCBmb3IgUENJIHdpbGwg
b25seSBiZSBlbmFibGVkIGlmIHRoZQo+Pj4+Pj4+PiByb290IGNvbXBsZXggaGFzIGFuIGlvbW11
cyBwcm9wZXJ0eSwgcmlnaHQ/IEluIHRoYXQgY2FzZSwgY2FuJ3Qgd2UKPj4+Pj4+Pj4gc2ltcGx5
IGRvIHNvbWV0aGluZyBsaWtlIHRoaXM6Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+IAlpZiAoZGV2X2lzX3Bj
aShkZXYpKQo+Pj4+Pj4+PiAJCW5wID0gZmluZF9ob3N0X2JyaWRnZShkZXYpLT5vZl9ub2RlOwo+
Pj4+Pj4+PiAJZWxzZQo+Pj4+Pj4+PiAJCW5wID0gZGV2LT5vZl9ub2RlOwo+Pj4+Pj4+Pgo+Pj4+
Pj4+PiA/IEknbSBub3Qgc3VyZSBleGFjdGx5IHdoYXQgZmluZF9ob3N0X2JyaWRnZSgpIGlzIGNh
bGxlZCwgYnV0IEknbSBwcmV0dHkKPj4+Pj4+Pj4gc3VyZSB0aGF0IGV4aXN0cy4KPj4+Pj4+Pj4K
Pj4+Pj4+Pj4gT25jZSB3ZSBoYXZlIHRoYXQgd2UgY2FuIHN0aWxsIGl0ZXJhdGUgb3ZlciB0aGUg
aW9tbXVzIHByb3BlcnR5IGFuZCBkbwo+Pj4+Pj4+PiBub3QgbmVlZCB0byByZWx5IG9uIHRoaXMg
Z2xvYmFsIHZhcmlhYmxlLgo+Pj4+Pj4+Cj4+Pj4+Pj4gSSBhZ3JlZSB0aGF0IGl0J2Qgd29yay4g
QnV0IEkgd2FzIGhvcGluZyB0byBzaW1wbGlmeSB0aGUgY29kZQo+Pj4+Pj4+IGhlcmUgaWYgaXQn
cyBwb3NzaWJsZS4gTG9va3MgbGlrZSB3ZSBoYXZlIGFuIGFyZ3VtZW50IG9uIHRoaXMKPj4+Pj4+
PiBzbyBJIHdpbGwgY2hvb3NlIHRvIGdvIHdpdGggeW91ciBzdWdnZXN0aW9uIGFib3ZlIGZvciBu
b3cuCj4+Pj4+Pgo+Pj4+Pj4gVGhpcyBwYXRjaCByZW1vdmVkIG1vcmUgbGluZXMgdGhhbiB3ZXJl
IGFkZGVkLiBJZiB0aGlzIHdpbGwgYmUgb3Bwb3NpdGUKPj4+Pj4+IGZvciB0aGUgVGhpZXJyeSdz
IHN1Z2dlc3Rpb24sIHRoZW4gaXQncyBwcm9iYWJseSBub3QgYSBncmVhdCBzdWdnZXN0aW9uLgo+
Pj4+Pgo+Pj4+PiBTb3JyeSwgSSBkb24ndCBxdWl0ZSB1bmRlcnN0YW5kIHRoaXMgY29tbWVudHMu
IFdvdWxkIHlvdSBwbGVhc2UKPj4+Pj4gZWxhYm9yYXRlIHdoYXQncyB0aGlzICJpdCIgYmVpbmcg
Im5vdCBhIGdyZWF0IHN1Z2dlc3Rpb24iPwo+Pj4+Pgo+Pj4+Cj4+Pj4gSSBtZWFudCB0aGF0IHlv
dSBzaG91bGQgdHJ5IHRvIGltcGxlbWVudCBUaGllcnJ5J3Mgc29sdXRpb24sIGJ1dCBpZiB0aGUK
Pj4+PiBlbmQgcmVzdWx0IHdpbGwgYmUgd29yc2UgdGhhbiB0aGUgY3VycmVudCBwYXRjaCwgdGhl
biB5b3Ugc2hvdWxkbid0IG1ha2UKPj4+PiBhIHY0LCBidXQgZ2V0IGJhY2sgdG8gdGhpcyBkaXNj
dXNzaW9uIGluIG9yZGVyIHRvIGNob29zZSB0aGUgYmVzdCBvcHRpb24KPj4+PiBhbmQgbWFrZSBl
dmVyeW9uZSBhZ3JlZSBvbiBpdC4KPj4+Cj4+PiBJIHNlZS4gVGhhbmtzIGZvciB0aGUgcmVwbHku
IEFuZCBoZXJlIGlzIGEgc2FtcGxlIGltcGxlbWVudGF0aW9uOgo+Pgo+PiBUaGF0J3Mgd2hhdCBJ
IHN1cHBvc2VkIHRvIGhhcHBlbiA6KSBUaGUgbmV3IHZhcmlhbnQgYWRkcyBjb2RlIGFuZAo+PiBj
b21wbGV4aXR5LCB3aGlsZSBvbGQgZGlkIHRoZSBvcHBvc2l0ZS4gSGVuY2UgdGhlIG9sZCB2YXJp
YW50IGlzIGNsZWFybHkKPj4gbW9yZSBhdHRyYWN0aXZlLCBJTU8uCj4gCj4gSSBwZXJzb25hbGx5
IGFtIG5vdCBhIGZhbiBvZiBhZGRpbmcgYSBwYXRoIGZvciBQQ0kgZGV2aWNlIGVpdGhlciwKPiBz
aW5jZSBQQ0kvSU9NTVUgY29yZXMgY291bGQgaGF2ZSB0YWtlbiBjYXJlIG9mIGl0IHdoaWxlIHRo
ZSBzYW1lCj4gcGF0aCBjYW4ndCBiZSB1c2VkIGZvciBvdGhlciBidXNlcy4KPiAKPiBJZiB3ZSBj
YW4ndCBjb21lIHRvIGFuIGFncmVlbWVudCBvbiBnbG9iYWxpemluZyBtYyBwb2ludGVyLCB3b3Vs
ZAo+IGl0IGJlIHBvc3NpYmxlIHRvIHBhc3MgdGVncmFfbWNfZHJpdmVyIHRocm91Z2ggdGVncmFf
c21tdV9wcm9iZSgpCj4gc28gd2UgY2FuIGNvbnRpbnVlIHRvIHVzZSBkcml2ZXJfZmluZF9kZXZp
Y2VfYnlfZndub2RlKCkgYXMgdjE/Cj4gCj4gdjE6IGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDIw
LzkvMjYvNjgKPiAKCkkgdGhpbmsgd2UgYWxyZWFkeSBhZ3JlZWQgdGhhdCBpdCB3aWxsIGJlIGdv
b2QgdG8gaGF2ZSBhIGNvbW1vbiBoZWxwZXIuClNvIGZhciBUaGllcnJ5IG9ubHkgb2JqZWN0ZWQg
dGhhdCB0aGUgaW1wbGVtZW50YXRpb24gb2YgdGhlIGhlbHBlciBjb3VsZApiZSBpbXByb3ZlZC4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFp
bGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
