Return-Path: <SRS0=r5As=AO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C48C433DF
	for <iommu@archiver.kernel.org>; Fri,  3 Jul 2020 09:26:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 226AB20826
	for <iommu@archiver.kernel.org>; Fri,  3 Jul 2020 09:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="cvmjkqJe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 226AB20826
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=semihalf.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id EF36B8974E;
	Fri,  3 Jul 2020 09:26:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T97NuBwbmo+w; Fri,  3 Jul 2020 09:26:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5E83F8973A;
	Fri,  3 Jul 2020 09:26:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4FDA1C088E;
	Fri,  3 Jul 2020 09:26:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB0C8C0733
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 09:26:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A4711265F5
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 09:26:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R7munH-XQ6Ab for <iommu@lists.linux-foundation.org>;
 Fri,  3 Jul 2020 09:26:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com
 [209.85.167.67])
 by silver.osuosl.org (Postfix) with ESMTPS id 5A8F2265AA
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 09:26:36 +0000 (UTC)
Received: by mail-lf1-f67.google.com with SMTP id g2so18105005lfb.0
 for <iommu@lists.linux-foundation.org>; Fri, 03 Jul 2020 02:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=semihalf-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zO0GcSjV+DoJTBjOrWxT1/ANl2QKnx4z2PRw1DUFok4=;
 b=cvmjkqJen9Yiv5VkwBU8n4ik0P/2IHfyjUyCwY6lDqZFCgWfBHnT1yqGtbu8HM81vu
 OdBKPFPAy+952G0+bi12xVtvgBtLNmoP27Ow3P2by0VXShv7xGeyYZewK730kb7AiMyk
 YIwv4JtWVtKCtxQLlWxJJxgGkoHmssf41/A+qiKNmUrQxAB21CLMRuPmVHnHerziZE2x
 isew032rkp6Bm1wzOaiTERyzwtIyOhqct7lz0t7ATel5rUwXG5m6zP9fVDrHXxd3aqTy
 7wHIdpLOFRwt0qkEwan/O4mymPRLbNHxL/k0HLdsxtuRMtacVzyhOMs1Kf0TWTFhsbGh
 y19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zO0GcSjV+DoJTBjOrWxT1/ANl2QKnx4z2PRw1DUFok4=;
 b=cnL8BQqU/Jx9yl+kcrgSN1PQ0tagYmMXbagSWV8uEv4Jx7ShyIydTstb0meXFKw34q
 QDMB6quy6UvieXL6Lp3FJWqjH2n5quCvT/wtxxpvf+rPM0VxvkU19QKKViGG0V/eGGby
 tFyKBgcT+0UlscJR/6wMwAU6jr/aOsNUSw1R3hlIyERMGAtJZrhcni5y68LWjUL9mZH6
 2umhnElavvO3DmVfl86xHLtnEzga7FY7wab5JSwCsMm6MO8vpHA2DGBzz03Z8xc0Eo9b
 sh07NPvaahuwGM7MvOC1swl1ZxSrAVosRBfJ0/HzazDbA+YfwJSFGOpGFjuAde0qRrQH
 V7kA==
X-Gm-Message-State: AOAM532KLhVnADnpUBDwCyt3S6sTfa/tMI+ix808gb7KQLMA6D3MfPW8
 5QEJmty0z7G1dv5J+QyqHg/foQ==
X-Google-Smtp-Source: ABdhPJyIGppCefmxj8fTRRtxz2K/PWcGR2BmqZOk0LbePzJxgW7tKvDo9qI60CWqvjE7deprzGXjKg==
X-Received: by 2002:ac2:5e6c:: with SMTP id a12mr21462673lfr.35.1593768394546; 
 Fri, 03 Jul 2020 02:26:34 -0700 (PDT)
Received: from [192.168.1.9] ([83.68.95.66])
 by smtp.googlemail.com with ESMTPSA id j4sm4453721lfb.94.2020.07.03.02.26.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2020 02:26:33 -0700 (PDT)
Subject: Re: [PATCH v3 3/4] dt-bindings: arm-smmu: add compatible string for
 Marvell Armada-AP806 SMMU-500
To: Robin Murphy <robin.murphy@arm.com>, will@kernel.org, joro@8bytes.org,
 gregory.clement@bootlin.com, robh+dt@kernel.org, hannah@marvell.com
References: <20200702201633.22693-1-tn@semihalf.com>
 <20200702201633.22693-4-tn@semihalf.com>
 <3172ec21-d773-7fcb-f1ee-f557f72f20c5@arm.com>
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <972f5cbd-705b-e18a-7477-5f6922804361@semihalf.com>
Date: Fri, 3 Jul 2020 11:26:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <3172ec21-d773-7fcb-f1ee-f557f72f20c5@arm.com>
Content-Language: en-US
Cc: devicetree@vger.kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, nadavh@marvell.com,
 iommu@lists.linux-foundation.org, mw@semihalf.com,
 linux-arm-kernel@lists.infradead.org
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

T24gMDMuMDcuMjAyMCAxMTowNSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjAtMDctMDIg
MjE6MTYsIFRvbWFzeiBOb3dpY2tpIHdyb3RlOgo+PiBBZGQgc3BlY2lmaWMgY29tcGF0aWJsZSBz
dHJpbmcgZm9yIE1hcnZlbGwgdXNhZ2UgZHVlIHRvIGVycmF0YSBvZgo+PiBhY2Nlc3NpbmcgNjRi
aXRzIHJlZ2lzdGVycyBvZiBBUk0gU01NVSwgaW4gQVA4MDYuCj4+Cj4+IEFQODA2IFNvQyB1c2Vz
IHRoZSBnZW5lcmljIEFSTS1NTVU1MDAsIGFuZCB0aGVyZSdzIG5vIHNwZWNpZmljCj4+IGltcGxl
bWVudGF0aW9uIG9mIE1hcnZlbGwsIHRoaXMgY29tcGF0aWJsZSBpcyB1c2VkIGZvciBlcnJhdGEg
b25seS4KPj4KPj4gU2lnbmVkLW9mZi1ieTogSGFubmEgSGF3YSA8aGFubmFoQG1hcnZlbGwuY29t
Pgo+PiBTaWduZWQtb2ZmLWJ5OiBHcmVnb3J5IENMRU1FTlQgPGdyZWdvcnkuY2xlbWVudEBib290
bGluLmNvbT4KPj4gU2lnbmVkLW9mZi1ieTogVG9tYXN6IE5vd2lja2kgPHRuQHNlbWloYWxmLmNv
bT4KPj4gLS0tCj4+IMKgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pb21tdS9h
cm0sc21tdS55YW1sIHwgNSArKysrKwo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25z
KCspCj4+Cj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
aW9tbXUvYXJtLHNtbXUueWFtbCAKPj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvaW9tbXUvYXJtLHNtbXUueWFtbAo+PiBpbmRleCBkN2NlYjRjMzQ0MjMuLjdiZWNhOWMwMGIx
MiAxMDA2NDQKPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lvbW11
L2FybSxzbW11LnlhbWwKPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2lvbW11L2FybSxzbW11LnlhbWwKPj4gQEAgLTM4LDYgKzM4LDExIEBAIHByb3BlcnRpZXM6Cj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIHFjb20sc2M3MTgwLXNtbXUtNTAwCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIHFjb20sc2RtODQ1LXNtbXUtNTAwCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLSBjb25zdDogYXJtLG1tdS01MDAKPj4gK8KgwqDCoMKg
wqAgLSBkZXNjcmlwdGlvbjogTWFydmVsbCBTb0NzIGltcGxlbWVudGluZyAiYXJtLG1tdS01MDAi
Cj4+ICvCoMKgwqDCoMKgwqDCoCBpdGVtczoKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoCAtIGVudW06
Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIG1hcnZlbGwsYXA4MDYtc21tdS01MDAK
PiAKPiBJc24ndCBhIHNpbmdsZS12YWx1ZWQgZW51bSBqdXN0IGEgY29uc3RhbnQ/IDpQCgpUaGF0
J3MgaG93IGNvcHktcGFzdGUgZW5naW5lZXJpbmcgZW5kcyB1cCA6KQoKVGhhbmtzLApUb21hc3oK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFp
bGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
