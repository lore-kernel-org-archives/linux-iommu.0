Return-Path: <SRS0=r5As=AO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5C9C433E1
	for <iommu@archiver.kernel.org>; Fri,  3 Jul 2020 11:24:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4AD7207FF
	for <iommu@archiver.kernel.org>; Fri,  3 Jul 2020 11:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="cNaVziwX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4AD7207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=semihalf.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6A61C204AE;
	Fri,  3 Jul 2020 11:24:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cdZY+4JniBzB; Fri,  3 Jul 2020 11:24:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 4AC302044F;
	Fri,  3 Jul 2020 11:24:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37D34C088E;
	Fri,  3 Jul 2020 11:24:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B6B3C0733
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 11:24:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 45ED587D61
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 11:24:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uQRn3C7AzaWS for <iommu@lists.linux-foundation.org>;
 Fri,  3 Jul 2020 11:24:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com
 [209.85.167.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B1A1181E54
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 11:24:30 +0000 (UTC)
Received: by mail-lf1-f67.google.com with SMTP id y18so18237345lfh.11
 for <iommu@lists.linux-foundation.org>; Fri, 03 Jul 2020 04:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=semihalf-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=oitMqipLEPO2Yj5xL/dlzZEeDLyWSmeeByxlVNYyd1g=;
 b=cNaVziwXP/FXl51uLD6P9SDqfM10xutFUrENHOk8xP7BmYZk+IWUPzeVhnaZQf9gvc
 vxjGSLQIWpuBQfzo3o5bSoGUxFVJoZJ+ddZCWpOZTdGDg4ZTM6iHWWpMIycrEdxDjLOA
 vmG5JZBPh8P6Kz+iwAHXiP4l9H8Z+T1SQpQa1c/s5/RCne8EgFXmQLHsH2L2jNGdkCz/
 CX59J9EmjTO1g7YeQqxM/A0p57k3gU5y0rpUgm+GyfXUFvWU+HQJ6C7AvsG1olSZ5Wf2
 RAH10ZnURTCqLtuTWy+hNEYQhv56R45INNiRlKhkTKPC2FJSuXDDeCOnYALAyOYuJ8NM
 9Flw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oitMqipLEPO2Yj5xL/dlzZEeDLyWSmeeByxlVNYyd1g=;
 b=P8mg4Dd642/kPqym5CCQpGi7Yks9CPr5QKXxSutW0jJAXgJLPUblWQaMvuiu06pn03
 q96hb9gtM6B1dCptV3Ua8u4p59j6S96HdPy1pzgrF2l0/77Eee/csTmZWip5rRtJQASJ
 MMbYLRygNavCFnXZR6ETZbGQhZQ7+VeMCHImgWnWfWMQTlL8FntHIIK9uc1LXlLLY1Ry
 0vzx0p0ssZn+VEIXzR0z2P5wY7Sn2TBoImg1Q6WyQVp07YVxVx41Dbk1oFHUCxPPjnb6
 rGjod5C0aL6t63urFJudLfAJHYtVQFBlG1i45vmb7XyEF7jmTLgUbcL7IC8Bw3WtgiI1
 00VA==
X-Gm-Message-State: AOAM530DD2fVgt0z3Jjghb2frJuu99XmWNJ8stNAVv3eEOzXTa8L/WjX
 1dzjixE0rBpioOQo8RpGT1IUGw==
X-Google-Smtp-Source: ABdhPJwSnB2E+9qDy3UvGZ3TOCAmeByNzVFr4FH7BTY3Q5sjfcRDicXgAigg7pUSQRkrPg0kxImDPQ==
X-Received: by 2002:ac2:5e29:: with SMTP id o9mr20757726lfg.196.1593775468529; 
 Fri, 03 Jul 2020 04:24:28 -0700 (PDT)
Received: from [192.168.1.9] ([83.68.95.66])
 by smtp.googlemail.com with ESMTPSA id g7sm4539921lfe.62.2020.07.03.04.24.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2020 04:24:27 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] iommu/arm-smmu: Workaround for Marvell
 Armada-AP806 SoC erratum #582743
To: Robin Murphy <robin.murphy@arm.com>, will@kernel.org, joro@8bytes.org,
 gregory.clement@bootlin.com, robh+dt@kernel.org, hannah@marvell.com
References: <20200702201633.22693-1-tn@semihalf.com>
 <20200702201633.22693-3-tn@semihalf.com>
 <f8c3fea9-2bd7-e776-447e-54886cd61568@arm.com>
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <8fb0f73f-35ca-d8ec-43b8-ae89e9a21d0c@semihalf.com>
Date: Fri, 3 Jul 2020 13:24:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <f8c3fea9-2bd7-e776-447e-54886cd61568@arm.com>
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

CgpPbiAwMy4wNy4yMDIwIDExOjAzLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4gT24gMjAyMC0wNy0w
MiAyMToxNiwgVG9tYXN6IE5vd2lja2kgd3JvdGU6Cj4+IEZyb206IEhhbm5hIEhhd2EgPGhhbm5h
aEBtYXJ2ZWxsLmNvbT4KPj4KPj4gRHVlIHRvIGVycmF0dW0gIzU4Mjc0MywgdGhlIE1hcnZlbGwg
QXJtYWRhLUFQODA2IGNhbid0IGFjY2VzcyA2NGJpdCB0bwo+PiBBUk0gU01NVXYyIHJlZ2lzdGVy
cy4KPj4KPj4gUHJvdmlkZSBpbXBsZW1lbnRhdGlvbiByZWxldmFudCBob29rczoKPj4gLSBzcGxp
dCB0aGUgd3JpdGVxL3JlYWRxIHRvIHR3byBhY2Nlc3NlcyBvZiB3cml0ZWwvcmVhZGwuCj4+IC0g
bWFzayB0aGUgTU1VX0lEUjIuUFRGU3Y4IGZpZWxkcyB0byBub3QgdXNlIEFBcmNoNjQgZm9ybWF0
IChidXQKPj4gb25seSBBQVJDSDMyX0wpIHNpbmNlIHdpdGggQUFyY2g2NCBmb3JtYXQgMzIgYml0
cyBhY2Nlc3MgaXMgbm90IAo+PiBzdXBwb3J0ZWQuCj4+Cj4+IE5vdGUgdGhhdCBzZXBhcmF0ZSB3
cml0ZXMvcmVhZHMgdG8gMiBpcyBub3QgcHJvYmxlbSByZWdhcmRzIHRvCj4+IGF0b21pY2l0eSwg
YmVjYXVzZSB0aGUgZHJpdmVyIHVzZSB0aGUgcmVhZHEvd3JpdGVxIHdoaWxlIGluaXRpYWxpemUK
Pj4gdGhlIFNNTVUsIHJlcG9ydCBmb3IgU01NVSBmYXVsdCwgYW5kIHVzZSBzcGlubG9jayBpbiBv
bmUKPj4gY2FzZSAoaW92YV90b19waHlzKS4KPiAKPiBUaGUgY29tbWVudCBhYm91dCB0aGUgc3Bp
bmxvY2sgc2VlbXMgdG8gYmUgb3V0IG9mIGRhdGUsIGFuZCBUQkggdGhhdCAKPiB3aG9sZSBzZW50
ZW5jZSBpcyBhIGJpdCB1bmNsZWFyIC0gaG93IGFib3V0IHNvbWV0aGluZyBsaWtlOgo+IAo+ICJO
b3RlIHRoYXQgbW9zdCA2NC1iaXQgcmVnaXN0ZXJzIGxpa2UgVFRCUm4gY2FuIGJlIGFjY2Vzc2Vk
IGFzIHR3byAKPiAzMi1iaXQgaGFsdmVzIHdpdGhvdXQgaXNzdWUsIGFuZCBBQXJjaDMyIGZvcm1h
dCBlbnN1cmVzIHRoYXQgdGhlIAo+IHJlZ2lzdGVyIHdyaXRlcyB3aGljaCBtdXN0IGJlIGF0b21p
YyAoZm9yIFRMQkkgZXRjLikgbmVlZCBvbmx5IGJlIDMyLWJpdC4iCj4gCj4+IFNpZ25lZC1vZmYt
Ynk6IEhhbm5hIEhhd2EgPGhhbm5haEBtYXJ2ZWxsLmNvbT4KPj4gU2lnbmVkLW9mZi1ieTogR3Jl
Z29yeSBDTEVNRU5UIDxncmVnb3J5LmNsZW1lbnRAYm9vdGxpbi5jb20+Cj4+IFNpZ25lZC1vZmYt
Ynk6IFRvbWFzeiBOb3dpY2tpIDx0bkBzZW1paGFsZi5jb20+Cj4+IC0tLQo+PiDCoCBEb2N1bWVu
dGF0aW9uL2FybTY0L3NpbGljb24tZXJyYXRhLnJzdCB8wqAgMyArKwo+PiDCoCBkcml2ZXJzL2lv
bW11L2FybS1zbW11LWltcGwuY8KgwqDCoMKgwqDCoMKgwqDCoCB8IDUyICsrKysrKysrKysrKysr
KysrKysrKysrKysrCj4+IMKgIDIgZmlsZXMgY2hhbmdlZCwgNTUgaW5zZXJ0aW9ucygrKQo+Pgo+
PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9hcm02NC9zaWxpY29uLWVycmF0YS5yc3QgCj4+
IGIvRG9jdW1lbnRhdGlvbi9hcm02NC9zaWxpY29uLWVycmF0YS5yc3QKPj4gaW5kZXggOTM2Y2Yy
YTU5Y2E0Li4xNTcyMTRkM2FiZTEgMTAwNjQ0Cj4+IC0tLSBhL0RvY3VtZW50YXRpb24vYXJtNjQv
c2lsaWNvbi1lcnJhdGEucnN0Cj4+ICsrKyBiL0RvY3VtZW50YXRpb24vYXJtNjQvc2lsaWNvbi1l
cnJhdGEucnN0Cj4+IEBAIC0xMjUsNiArMTI1LDkgQEAgc3RhYmxlIGtlcm5lbHMuCj4+IMKgIHwg
Q2F2aXVtwqDCoMKgwqDCoMKgwqDCoCB8IFRodW5kZXJYMiBDb3JlwqAgfCAjMjE5wqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB8IAo+PiBDQVZJVU1fVFgyX0VSUkFUVU1fMjE5wqDCoMKgwqDCoCB8Cj4+
ICAgCj4+ICstLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0t
LS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKyAKPj4KPj4gICAKPj4gKy0tLS0tLS0t
LS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0rIAo+Pgo+PiArfCBNYXJ2ZWxswqDCoMKgwqDCoMKgwqAgfCBBUk0t
TU1VLTUwMMKgwqDCoMKgIHwgIzU4Mjc0M8KgwqDCoMKgwqDCoMKgwqAgfCAKPj4gTi9BwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwKPj4gKystLS0tLS0t
LS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tKyAKPj4KPj4gKystLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0t
LS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKyAK
Pj4KPj4gwqAgfCBGcmVlc2NhbGUvTlhQwqAgfCBMUzIwODBBL0xTMTA0M0EgfCBBLTAwODU4NcKg
wqDCoMKgwqDCoMKgIHwgCj4+IEZTTF9FUlJBVFVNX0EwMDg1ODXCoMKgwqDCoMKgwqDCoMKgIHwK
Pj4gICAKPj4gKy0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0t
LS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rIAo+Pgo+PiAgIAo+PiArLS0tLS0t
LS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLSsgCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2Fy
bS1zbW11LWltcGwuYyAKPj4gYi9kcml2ZXJzL2lvbW11L2FybS1zbW11LWltcGwuYwo+PiBpbmRl
eCBjNzViOWQ5NTdiNzAuLmMxZmM1ZTFiODE5MyAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9pb21t
dS9hcm0tc21tdS1pbXBsLmMKPj4gKysrIGIvZHJpdmVycy9pb21tdS9hcm0tc21tdS1pbXBsLmMK
Pj4gQEAgLTE0Nyw2ICsxNDcsNTMgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhcm1fc21tdV9pbXBs
IGFybV9tbXU1MDBfaW1wbCAKPj4gPSB7Cj4+IMKgwqDCoMKgwqAgLnJlc2V0ID0gYXJtX21tdTUw
MF9yZXNldCwKPj4gwqAgfTsKPj4gK3N0YXRpYyB1NjQgbXJ2bF9tbXU1MDBfcmVhZHEoc3RydWN0
IGFybV9zbW11X2RldmljZSAqc21tdSwgaW50IHBhZ2UsIAo+PiBpbnQgb2ZmKQo+PiArewo+PiAr
wqDCoMKgIHU2NCB2YWw7Cj4+ICsKPj4gK8KgwqDCoCAvKgo+PiArwqDCoMKgwqAgKiBNYXJ2ZWxs
IEFybWFkYS1BUDgwNiBlcnJhdHVtICM1ODI3NDMuCj4+ICvCoMKgwqDCoCAqIFNwbGl0IGFsbCB0
aGUgcmVhZHEgdG8gZG91YmxlIHJlYWRsCj4+ICvCoMKgwqDCoCAqLwo+PiArwqDCoMKgIHZhbCA9
ICh1NjQpcmVhZGxfcmVsYXhlZChhcm1fc21tdV9wYWdlKHNtbXUsIHBhZ2UpICsgb2ZmICsgNCkg
PDwgMzI7Cj4+ICvCoMKgwqAgdmFsIHw9IHJlYWRsX3JlbGF4ZWQoYXJtX3NtbXVfcGFnZShzbW11
LCBwYWdlKSArIG9mZik7Cj4gCj4gRXZlbiB0aG91Z2ggaW8tNjQtbm9uYXRvbWljLWhpLWxvLmgg
ZG9lc24ndCBvdmVycmlkZSByZWFkcSgpIGV0Yy4gZm9yIAo+IDY0LWJpdCBidWlsZHMsIHlvdSBj
YW4gc3RpbGwgdXNlIGhpX2xvX3JlYWRxX3JlbGF4ZWQoKSBkaXJlY3RseS4KPiAKPj4gKwo+PiAr
wqDCoMKgIHJldHVybiB2YWw7Cj4+ICt9Cj4+ICsKPj4gK3N0YXRpYyB2b2lkIG1ydmxfbW11NTAw
X3dyaXRlcShzdHJ1Y3QgYXJtX3NtbXVfZGV2aWNlICpzbW11LCBpbnQgCj4+IHBhZ2UsIGludCBv
ZmYsCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdTY0IHZhbCkKPj4g
K3sKPj4gK8KgwqDCoCAvKgo+PiArwqDCoMKgwqAgKiBNYXJ2ZWxsIEFybWFkYS1BUDgwNiBlcnJh
dHVtICM1ODI3NDMuCj4+ICvCoMKgwqDCoCAqIFNwbGl0IGFsbCB0aGUgd3JpdGVxIHRvIGRvdWJs
ZSB3cml0ZWwKPj4gK8KgwqDCoMKgICovCj4+ICvCoMKgwqAgd3JpdGVsX3JlbGF4ZWQodXBwZXJf
MzJfYml0cyh2YWwpLCBhcm1fc21tdV9wYWdlKHNtbXUsIHBhZ2UpICsgCj4+IG9mZiArIDQpOwo+
PiArwqDCoMKgIHdyaXRlbF9yZWxheGVkKGxvd2VyXzMyX2JpdHModmFsKSwgYXJtX3NtbXVfcGFn
ZShzbW11LCBwYWdlKSArIG9mZik7Cj4gCj4gU2ltaWxhcmx5LCBoaV9sb193cml0ZXFfcmVsYXhl
ZCgpLgo+IAo+PiArfQo+PiArCj4+ICtzdGF0aWMgdTMyIG1ydmxfbW11NTAwX2NmZ19pZDJfZml4
dXAodTMyIGlkKQo+PiArewo+PiArCj4+ICvCoMKgwqAgLyoKPj4gK8KgwqDCoMKgICogQXJtYWRh
LUFQODA2IGVycmF0dW0gIzU4Mjc0My4KPj4gK8KgwqDCoMKgICogSGlkZSB0aGUgU01NVV9JRFIy
LlBURlN2OCBmaWVsZHMgdG8gc2lkZXN0ZXAgdGhlIEFBcmNoNjQKPj4gK8KgwqDCoMKgICogZm9y
bWF0cyBhbHRvZ2V0aGVyIGFuZCBhbGxvdyB1c2luZyAzMiBiaXRzIGFjY2VzcyBvbiB0aGUKPj4g
K8KgwqDCoMKgICogaW50ZXJjb25uZWN0Lgo+PiArwqDCoMKgwqAgKi8KPj4gK8KgwqDCoCBpZCAm
PSB+KEFSTV9TTU1VX0lEMl9QVEZTXzRLIHwgQVJNX1NNTVVfSUQyX1BURlNfMTZLIHwKPj4gK8Kg
wqDCoMKgwqDCoMKgIEFSTV9TTU1VX0lEMl9QVEZTXzY0Syk7Cj4+ICsKPj4gK8KgwqDCoCByZXR1
cm4gaWQ7Cj4+ICt9Cj4+ICsKPj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgYXJtX3NtbXVfaW1wbCBt
cnZsX21tdTUwMF9pbXBsID0gewo+PiArwqDCoMKgIC5yZWFkX3JlZzY0ID0gbXJ2bF9tbXU1MDBf
cmVhZHEsCj4+ICvCoMKgwqAgLndyaXRlX3JlZzY0ID0gbXJ2bF9tbXU1MDBfd3JpdGVxLAo+PiAr
wqDCoMKgIC5jZmdfaWQyX2ZpeHVwID0gbXJ2bF9tbXU1MDBfY2ZnX2lkMl9maXh1cCwKPj4gK8Kg
wqDCoCAucmVzZXQgPSBhcm1fbW11NTAwX3Jlc2V0LAo+PiArfTsKPj4gKwo+PiDCoCBzdHJ1Y3Qg
YXJtX3NtbXVfZGV2aWNlICphcm1fc21tdV9pbXBsX2luaXQoc3RydWN0IGFybV9zbW11X2Rldmlj
ZSAKPj4gKnNtbXUpCj4+IMKgIHsKPj4gQEAgLTE2MCw2ICsyMDcsMTEgQEAgc3RydWN0IGFybV9z
bW11X2RldmljZSAqYXJtX3NtbXVfaW1wbF9pbml0KHN0cnVjdCAKPj4gYXJtX3NtbXVfZGV2aWNl
ICpzbW11KQo+PiDCoMKgwqDCoMKgwqAgKi8KPj4gwqDCoMKgwqDCoCBzd2l0Y2ggKHNtbXUtPm1v
ZGVsKSB7Cj4+IMKgwqDCoMKgwqAgY2FzZSBBUk1fTU1VNTAwOgo+PiArwqDCoMKgwqDCoMKgwqAg
aWYgKG9mX2RldmljZV9pc19jb21wYXRpYmxlKHNtbXUtPmRldi0+b2Zfbm9kZSwKPiAKPiBOaXQ6
IHRoZXJlJ3MgYSBsb2NhbCAibnAiIHZhcmlhYmxlIG5vdy4KPiAKPj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIm1hcnZlbGwsYXA4MDYtc21tdS01MDAi
KSkgewo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzbW11LT5pbXBsID0gJm1ydmxfbW11NTAw
X2ltcGw7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBzbW11Owo+PiArwqDCoMKg
wqDCoMKgwqAgfQo+IAo+IFBsZWFzZSBwdXQgdGhpcyB3aXRoIHRoZSBvdGhlciBpbnRlZ3JhdGlv
biBjaGVja3MgYmVsb3cgdGhlIHN3aXRjaCAKPiBzdGF0ZW1lbnQuIFllcywgaXQgbWVhbnMgd2Un
bGwgZW5kIHVwIGFzc2lnbmluZyBzbW11LT5pbXBsIHR3aWNlIGZvciAKPiB0aGlzIHBhcnRpY3Vs
YXIgY2FzZSwgYnV0IHRoYXQncyB0aGUgaW50ZW5kZWQgcGF0dGVybi4KPiAKClRoYW5rcywgYWxs
IGFib3ZlIGNvbW1lbnRzIGRvIG1ha2Ugc2Vuc2UgYW5kIHdpbGwgYmUgZml4ZWQgaW4gbmV4dCBz
cGluLgoKVGhhbmtzLApUb21hc3oKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2lvbW11
