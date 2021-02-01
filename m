Return-Path: <SRS0=Rmex=HD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46208C433E0
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 11:13:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADCC164D7F
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 11:13:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADCC164D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6D3352043D;
	Mon,  1 Feb 2021 11:13:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cnAALAzX74a2; Mon,  1 Feb 2021 11:12:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5512920000;
	Mon,  1 Feb 2021 11:12:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A078C0FA7;
	Mon,  1 Feb 2021 11:12:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66A6EC013A
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 11:12:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5FC45859BA
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 11:12:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 063gBrt9w0iX for <iommu@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 11:12:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id DC869858FC
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 11:12:56 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id y187so12822681wmd.3
 for <iommu@lists.linux-foundation.org>; Mon, 01 Feb 2021 03:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=AdJJsztSa/PfLkxaK9hi3wgOAf3rWJfVmETfVbPhDQM=;
 b=BJZkUaVlvArotMj35gc4Ryn1jzYpJODmz4BeBqXzrXY8uWYM5d/12aV/f7BgcY6I96
 Sz6IrQvhl4kgb1SpJ5/bNviOzCPmpquY54HzywVEmd6hLl0TdDy/tpVkg5EphHmkgaBh
 t8P55uFMT3rvXvz8DVI44pagXmLgXNXbAq1DIZBYF8TG2YbVC+COX6RmQ2GL3woWeq57
 FpWICNVRpruje4QN6AUBZyTEq7ciqt+XUhg00r4CJGPi1Gp4cHMcGh4Tx6or9Jwc0OMV
 75G38yLv2UNNalUAfk/h+NfjYgTJo8EO6E1Lr9T4EysKvQ+2BDYaBsJqXEDGw5WaJUn/
 u4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=AdJJsztSa/PfLkxaK9hi3wgOAf3rWJfVmETfVbPhDQM=;
 b=H8yOolguuS8ybp4zhP5a7IjcDS8qkyFUdJfJgyzRzvEr+sYQlPUsm+eOi4q4X4dRzn
 5JCt9Gek3QY4lQy95L9ZGVRp66w5tueSzrJTJxNB3BFDjcV51izyU5SVvLK5JiWftgau
 TDr0XZ1ozO7JRPuHW2FQFERMwOtkJAAWZOQ9bT4m4CUZx8wXv6k0l7kK26EUn8/dhuyn
 X7YObE2aFKUHL6Cc59tHi9B4L6xhwnLZohGcMgpseV4cMlHBgjtXj0GEOe1lPY8sng8h
 F8Ddz3pkSK1c6IPqZuY1Ua5IpuTtlxw6y9XQkn328T/74qDRkMybO5Az8AxCkbF5KgXC
 PXHg==
X-Gm-Message-State: AOAM532kYZ7+sG96tLJqEYudWkfkc1SDoV/BeAEEW78P9USj24KdMgKt
 1ieyKNFjKDneBrxKmuyqPL2VMw==
X-Google-Smtp-Source: ABdhPJzbSmxDnOHXTAtKhAr3owNj0X97Hbyhk6zyvU9cBi4RZpPy0aY0Qw5qlS8+s51rHeesopHFbA==
X-Received: by 2002:a05:600c:228c:: with SMTP id
 12mr14691553wmf.101.1612177975252; 
 Mon, 01 Feb 2021 03:12:55 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id v25sm21276665wmh.4.2021.02.01.03.12.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Feb 2021 03:12:54 -0800 (PST)
Date: Mon, 1 Feb 2021 12:12:35 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v12 10/10] iommu/arm-smmu-v3: Add stall support for
 platform devices
Message-ID: <YBfiIwdVP1dXg7Yt@myrica>
References: <20210127154322.3959196-1-jean-philippe@linaro.org>
 <20210127154322.3959196-11-jean-philippe@linaro.org>
 <0c609eeb-00b0-7573-fed7-5bc1e6c0b0d1@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0c609eeb-00b0-7573-fed7-5bc1e6c0b0d1@redhat.com>
Cc: vivek.gautam@arm.com, guohanjun@huawei.com, will@kernel.org,
 linux-acpi@vger.kernel.org, zhangfei.gao@linaro.org, lenb@kernel.org,
 devicetree@vger.kernel.org, kevin.tian@intel.com, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net,
 iommu@lists.linux-foundation.org, sudeep.holla@arm.com, robin.murphy@arm.com,
 linux-accelerators@lists.ozlabs.org
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

T24gU3VuLCBKYW4gMzEsIDIwMjEgYXQgMDc6Mjk6MDlQTSArMDEwMCwgQXVnZXIgRXJpYyB3cm90
ZToKPiBIaSBKZWFuLAo+IAo+IFNvbWUgcmF0aGVyIG1pbm9yIGNvbW1lbnRzwqdxdWVzdGlvbnMg
YmVsb3cgdGhhdCBtYXkgbm90IGp1c3RpZnkgYSByZXNwaW4uCj4gCj4gT24gMS8yNy8yMSA0OjQz
IFBNLCBKZWFuLVBoaWxpcHBlIEJydWNrZXIgd3JvdGU6Cj4gPiAtc3RhdGljIGJvb2wgYXJtX3Nt
bXVfaW9wZl9zdXBwb3J0ZWQoc3RydWN0IGFybV9zbW11X21hc3RlciAqbWFzdGVyKQo+ID4gK2Jv
b2wgYXJtX3NtbXVfbWFzdGVyX2lvcGZfc3VwcG9ydGVkKHN0cnVjdCBhcm1fc21tdV9tYXN0ZXIg
Km1hc3RlcikKPiA+ICB7Cj4gPiAtCXJldHVybiBmYWxzZTsKPiA+ICsJLyogV2UncmUgbm90IGtl
ZXBpbmcgdHJhY2sgb2YgU0lEcyBpbiBmYXVsdCBldmVudHMgKi8KPiBzaGFsbCB3ZT8gWypdIGJl
bG93CgpUaGF0IHdvdWxkIHJlcXVpcmUgc3RvcmluZyB0aGUgaW5jb21pbmcgU0lEIGludG8gdGhl
IGlvbW11X2ZhdWx0X2V2ZW50CnN0cnVjdCwgYW5kIHJldHJpZXZlIGl0IGluIGFybV9zbW11X3Bh
Z2VfcmVzcG9uc2UoKS4gRWFzeSBlbm91Z2gsIGJ1dCBJCmRvbid0IHRoaW5rIGl0J3MgbmVlZGVk
IGZvciBleGlzdGluZyBkZXZpY2VzLgoKPiA+ICsJaWYgKG1hc3Rlci0+bnVtX3N0cmVhbXMgIT0g
MSkKPiA+ICsJCXJldHVybiBmYWxzZTsKWy4uLl0KPiA+ICtzdGF0aWMgaW50IGFybV9zbW11X3Bh
Z2VfcmVzcG9uc2Uoc3RydWN0IGRldmljZSAqZGV2LAo+ID4gKwkJCQkgIHN0cnVjdCBpb21tdV9m
YXVsdF9ldmVudCAqdW51c2VkLAo+ID4gKwkJCQkgIHN0cnVjdCBpb21tdV9wYWdlX3Jlc3BvbnNl
ICpyZXNwKQo+ID4gK3sKPiA+ICsJc3RydWN0IGFybV9zbW11X2NtZHFfZW50IGNtZCA9IHswfTsK
PiA+ICsJc3RydWN0IGFybV9zbW11X21hc3RlciAqbWFzdGVyID0gZGV2X2lvbW11X3ByaXZfZ2V0
KGRldik7Cj4gPiArCWludCBzaWQgPSBtYXN0ZXItPnN0cmVhbXNbMF0uaWQ7Cj4gWypdCj4gPiAr
Cj4gPiArCWlmIChtYXN0ZXItPnN0YWxsX2VuYWJsZWQpIHsKPiA+ICsJCWNtZC5vcGNvZGUJCT0g
Q01EUV9PUF9SRVNVTUU7Cj4gPiArCQljbWQucmVzdW1lLnNpZAkJPSBzaWQ7Cj4gPiArCQljbWQu
cmVzdW1lLnN0YWcJCT0gcmVzcC0+Z3JwaWQ7Cj4gPiArCQlzd2l0Y2ggKHJlc3AtPmNvZGUpIHsK
PiA+ICsJCWNhc2UgSU9NTVVfUEFHRV9SRVNQX0lOVkFMSUQ6Cj4gYWRkIGZhbGx0aHJvdWdoPwoK
SSB0aGluayBmYWxsdGhyb3VnaCBpcyBtYWlubHkgdXNlZnVsIHRvIHRlbGwgcmVhZGVyIGFuZCBj
b21waWxlciB0aGF0IGEKYnJlYWsgd2FzIG9taXR0ZWQgb24gcHVycG9zZS4gV2hlbiB0d28gY2Fz
ZXMgYXJlIHN0dWNrIHRvZ2V0aGVyIHRoZSBpbnRlbnQKdG8gbWVyZ2UgdGhlIGZsb3cgaXMgY2xl
YXIgZW5vdWdoIGluIG15IG9waW5pb24uIEdDQydzCi1XaW1wbGljaXQtZmFsbHRocm91Z2ggZG9l
c24ndCB3YXJuIGluIHRoaXMgY2FzZS4KCj4gPiArCQljYXNlIElPTU1VX1BBR0VfUkVTUF9GQUlM
VVJFOgo+ID4gKwkJCWNtZC5yZXN1bWUucmVzcCA9IENNRFFfUkVTVU1FXzBfUkVTUF9BQk9SVDsK
PiA+ICsJCQlicmVhazsKWy4uLl0KPiA+ICtzdGF0aWMgaW50IGFybV9zbW11X2hhbmRsZV9ldnQo
c3RydWN0IGFybV9zbW11X2RldmljZSAqc21tdSwgdTY0ICpldnQpCj4gPiArewo+ID4gKwlpbnQg
cmV0Owo+ID4gKwl1MzIgcmVhc29uOwo+ID4gKwl1MzIgcGVybSA9IDA7Cj4gPiArCXN0cnVjdCBh
cm1fc21tdV9tYXN0ZXIgKm1hc3RlcjsKPiA+ICsJYm9vbCBzc2lkX3ZhbGlkID0gZXZ0WzBdICYg
RVZUUV8wX1NTVjsKPiA+ICsJdTMyIHNpZCA9IEZJRUxEX0dFVChFVlRRXzBfU0lELCBldnRbMF0p
Owo+ID4gKwlzdHJ1Y3QgaW9tbXVfZmF1bHRfZXZlbnQgZmF1bHRfZXZ0ID0geyB9Owo+ID4gKwlz
dHJ1Y3QgaW9tbXVfZmF1bHQgKmZsdCA9ICZmYXVsdF9ldnQuZmF1bHQ7Cj4gPiArCj4gPiArCS8q
IFN0YWdlLTIgaXMgYWx3YXlzIHBpbm5lZCBhdCB0aGUgbW9tZW50ICovCj4gPiArCWlmIChldnRb
MV0gJiBFVlRRXzFfUzIpCj4gPiArCQlyZXR1cm4gLUVGQVVMVDsKPiA+ICsKPiA+ICsJbWFzdGVy
ID0gYXJtX3NtbXVfZmluZF9tYXN0ZXIoc21tdSwgc2lkKTsKPiA+ICsJaWYgKCFtYXN0ZXIpCj4g
PiArCQlyZXR1cm4gLUVJTlZBTDsKPiA+ICsKPiA+ICsJaWYgKGV2dFsxXSAmIEVWVFFfMV9Sblcp
Cj4gPiArCQlwZXJtIHw9IElPTU1VX0ZBVUxUX1BFUk1fUkVBRDsKPiA+ICsJZWxzZQo+ID4gKwkJ
cGVybSB8PSBJT01NVV9GQVVMVF9QRVJNX1dSSVRFOwo+ID4gKwo+ID4gKwlpZiAoZXZ0WzFdICYg
RVZUUV8xX0luRCkKPiA+ICsJCXBlcm0gfD0gSU9NTVVfRkFVTFRfUEVSTV9FWEVDOwo+ID4gKwo+
ID4gKwlpZiAoZXZ0WzFdICYgRVZUUV8xX1BuVSkKPiA+ICsJCXBlcm0gfD0gSU9NTVVfRkFVTFRf
UEVSTV9QUklWOwo+ID4gKwo+ID4gKwlzd2l0Y2ggKEZJRUxEX0dFVChFVlRRXzBfSUQsIGV2dFsw
XSkpIHsKPiA+ICsJY2FzZSBFVlRfSURfVFJBTlNMQVRJT05fRkFVTFQ6Cj4gPiArCWNhc2UgRVZU
X0lEX0FERFJfU0laRV9GQVVMVDoKPiA+ICsJY2FzZSBFVlRfSURfQUNDRVNTX0ZBVUxUOgo+ID4g
KwkJcmVhc29uID0gSU9NTVVfRkFVTFRfUkVBU09OX1BURV9GRVRDSDsKPiBEb2Vzbid0IGl0IHJh
dGhlciBtYXAgdG8gSU9NTVVfRkFVTFRfUkVBU09OX0FDQ0VTUz8KPiAvKiBhY2Nlc3MgZmxhZyBj
aGVjayBmYWlsZWQgKi8iCgpHb29kIHBvaW50LCBJIGd1ZXNzIGl0IGRpZG4ndCBleGlzdCB3aGVu
IEkgd3JvdGUgdGhpcy4gQW5kIEFERFJfU0laRV9GQVVMVApjb3JyZXNwb25kcyB0byBJT01NVV9G
QVVMVF9SRUFTT05fT09SX0FERFJFU1Mgbm93LCByaWdodD8KCkJ5IHRoZSB3YXkgdGhlIHdvcmRp
bmcgb24gdGhvc2UgdHdvIGZhdWx0IHJlYXNvbnMsICJhY2Nlc3MgZmxhZyIgYW5kCiJzdGFnZSIs
IHNlZW1zIGFyY2gtc3BlY2lmaWMgLSB4ODYgbmFtZXMgYXJlICJhY2Nlc3NlZCBmbGFnIiBhbmQg
ImxldmVsIi4KCj4gPiArCQlicmVhazsKPiA+ICsJY2FzZSBFVlRfSURfUEVSTUlTU0lPTl9GQVVM
VDoKPiA+ICsJCXJlYXNvbiA9IElPTU1VX0ZBVUxUX1JFQVNPTl9QRVJNSVNTSU9OOwo+ID4gKwkJ
YnJlYWs7Cj4gPiArCWRlZmF1bHQ6Cj4gPiArCQlyZXR1cm4gLUVPUE5PVFNVUFA7Cj4gPiArCX0K
PiA+ICsKPiA+ICsJaWYgKGV2dFsxXSAmIEVWVFFfMV9TVEFMTCkgewo+ID4gKwkJZmx0LT50eXBl
ID0gSU9NTVVfRkFVTFRfUEFHRV9SRVE7Cj4gPiArCQlmbHQtPnBybSA9IChzdHJ1Y3QgaW9tbXVf
ZmF1bHRfcGFnZV9yZXF1ZXN0KSB7Cj4gPiArCQkJLmZsYWdzID0gSU9NTVVfRkFVTFRfUEFHRV9S
RVFVRVNUX0xBU1RfUEFHRSwKPiA+ICsJCQkuZ3JwaWQgPSBGSUVMRF9HRVQoRVZUUV8xX1NUQUcs
IGV2dFsxXSksCj4gPiArCQkJLnBlcm0gPSBwZXJtLAo+ID4gKwkJCS5hZGRyID0gRklFTERfR0VU
KEVWVFFfMl9BRERSLCBldnRbMl0pLAo+ID4gKwkJfTsKPiA+ICsKPiA+ICsJCWlmIChzc2lkX3Zh
bGlkKSB7Cj4gPiArCQkJZmx0LT5wcm0uZmxhZ3MgfD0gSU9NTVVfRkFVTFRfUEFHRV9SRVFVRVNU
X1BBU0lEX1ZBTElEOwo+ID4gKwkJCWZsdC0+cHJtLnBhc2lkID0gRklFTERfR0VUKEVWVFFfMF9T
U0lELCBldnRbMF0pOwo+ID4gKwkJfQo+ID4gKwl9IGVsc2Ugewo+ID4gKwkJZmx0LT50eXBlID0g
SU9NTVVfRkFVTFRfRE1BX1VOUkVDT1Y7Cj4gPiArCQlmbHQtPmV2ZW50ID0gKHN0cnVjdCBpb21t
dV9mYXVsdF91bnJlY292ZXJhYmxlKSB7Cj4gPiArCQkJLnJlYXNvbiA9IHJlYXNvbiwKPiA+ICsJ
CQkuZmxhZ3MgPSBJT01NVV9GQVVMVF9VTlJFQ09WX0FERFJfVkFMSUQgfAo+ID4gKwkJCQkgSU9N
TVVfRkFVTFRfVU5SRUNPVl9GRVRDSF9BRERSX1ZBTElELAo+IG5pdDogc2hhbGwgSU9NTVVfRkFV
TFRfVU5SRUNPVl9GRVRDSF9BRERSX1ZBTElEIGJlIHNldCBoZXJlPyBTdXBwb3J0ZWQKPiB1bnJl
Y292ZXJhYmxlIGZhdWx0cyBmZWF0dXJlIHRoZSBJUEEgZmllbGQgd2hpY2ggaXMgVU5LTk9XTiBm
b3IgUzEKPiB0cmFuc2xhdGlvbnMuIGZldGNoX2FkZHIgcmF0aGVyIHdhcwo+IGNvcnJlc3BvbmRp
bmcgdG8gV0FMS19FQUJULkZldGNoX2FkZHIgdG8gbWUuCgpSaWdodCBJIHNob3VsZCBkcm9wIHRo
ZSBJUEEgcGFydCBlbnRpcmVseSwgc2luY2Ugd2UgZG9uJ3QgcmVwb3J0IFMyIGZhdWx0cwppbiB0
aGlzIHBhdGNoLgoKVGhhbmtzLApKZWFuCgo+ID4gKwkJCS5wZXJtID0gcGVybSwKPiA+ICsJCQku
YWRkciA9IEZJRUxEX0dFVChFVlRRXzJfQUREUiwgZXZ0WzJdKSwKPiA+ICsJCQkuZmV0Y2hfYWRk
ciA9IEZJRUxEX0dFVChFVlRRXzNfSVBBLCBldnRbM10pLAo+ID4gKwkJfTsKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdApp
b21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
