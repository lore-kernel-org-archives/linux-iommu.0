Return-Path: <SRS0=RXoQ=ZB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F664C43331
	for <iommu@archiver.kernel.org>; Sat,  9 Nov 2019 03:59:06 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E262207FF
	for <iommu@archiver.kernel.org>; Sat,  9 Nov 2019 03:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="MzM8LadG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E262207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 06BACCC3;
	Sat,  9 Nov 2019 03:59:06 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 84733CBC
	for <iommu@lists.linux-foundation.org>;
	Sat,  9 Nov 2019 03:59:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com
	[209.85.222.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1B42DEC
	for <iommu@lists.linux-foundation.org>;
	Sat,  9 Nov 2019 03:59:04 +0000 (UTC)
Received: by mail-qk1-f195.google.com with SMTP id 71so6962994qkl.0
	for <iommu@lists.linux-foundation.org>;
	Fri, 08 Nov 2019 19:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
	h=mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=aROgLuqmyQMn6bQ3dkRZULLKhNypYtMoFctyPNExrr8=;
	b=MzM8LadGws9kVWYfucgsQOARwUxQ0v14BoSsETtO0VfLCIibmC6dR1dP87tTDPKUlk
	eFNhdrVFtqdad+YCvvDGiAsYzWVzJJMTyxPB0AKHXvN9sOY31st+DBlz8wjty9Xlp2jH
	wOPof/LWVH3M5TRHLjS+87Dj7v/tEvyjOcTesEAWFG/UKvVCZ1/WcHgPO8LHBTv1D78c
	Sr+8omFbTtQ6peGcGzTjT8JTlgBT/X6PtdNUC9uJw9QGuAU22ygXn2BQ8peVT1OWcOP0
	r419pcS9pTK7zB9DkuWTSQ9I+6gpnGesLFFEWKxTg7jekKuxHy/ca1BNweLNWjPBNXN2
	fXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=aROgLuqmyQMn6bQ3dkRZULLKhNypYtMoFctyPNExrr8=;
	b=d1RKkIynkjE4wDAYbM5zHhM0b3liSwIvzpSaPnXxDUr8eBS0/GLL5rp2pN1jMvOC9+
	POecXnfnP7IxiZ97ZPEYXZYeNSVmDBLA6z/GTQ4UnGoT2qvl68VIA4yY0kA/SdBXQouv
	DvK4pGv+FG5cyHLCUPzcH8XIr36U7H2e7UGgL79BQewzxzdiG3kX56FGvi00dzWNv0WV
	x4exxeix4bvxJSzZHOdLcBuA7nbLQZxo+OKFhUQYGxcWIBC+e+jcKZiRSPn1gQkSAgxP
	9YHLiZ88Xe4uB+nvrvy7HJhSBXMHlwE8UkXuEZ///UxGxfigyq9wpTy1R+KLwkfG4jIA
	OZjQ==
X-Gm-Message-State: APjAAAU6d82Wj+Eo+TB6ppXAJhScdPpaGM4rwlg5zWQiXxfahcdQlYYA
	aZmFi85+/vUc3rbSPyYiW3RZcA==
X-Google-Smtp-Source: APXvYqyJm/ueJQ86ESZKiEi2O0iWVfky5nDFQUUmL2RhwXagjqCuRNkA+VM2ExLU3ZBV76dbCqvABg==
X-Received: by 2002:a05:620a:a0e:: with SMTP id i14mr355330qka.3.1573271943010;
	Fri, 08 Nov 2019 19:59:03 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net.
	[71.184.117.43]) by smtp.gmail.com with ESMTPSA id
	x65sm4183104qkd.15.2019.11.08.19.59.01
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 08 Nov 2019 19:59:02 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Add Kconfig option to enable/disable
	scalable mode
From: Qian Cai <cai@lca.pw>
In-Reply-To: <20191109034039.27964-1-baolu.lu@linux.intel.com>
Date: Fri, 8 Nov 2019 22:59:01 -0500
Message-Id: <A85B5322-5DED-4E58-B3BC-4DA3783BB8A6@lca.pw>
References: <20191109034039.27964-1-baolu.lu@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
X-Mailer: Apple Mail (2.3601.0.10)
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com,
	David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Cgo+IE9uIE5vdiA4LCAyMDE5LCBhdCAxMDo0MCBQTSwgTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4
LmludGVsLmNvbT4gd3JvdGU6Cj4gCj4gVGhpcyBhZGRzIEtjb25maWcgb3B0aW9uIElOVEVMX0lP
TU1VX1NDQUxBQkxFX01PREVfREVGQVVMVF9PTgo+IHRvIG1ha2UgaXQgZWFzaWVyIGZvciBkaXN0
cmlidXRpb25zIHRvIGVuYWJsZSBvciBkaXNhYmxlIHRoZQo+IEludGVsIElPTU1VIHNjYWxhYmxl
IG1vZGUgYnkgZGVmYXVsdCBkdXJpbmcga2VybmVsIGJ1aWxkLgo+IAo+IFNpZ25lZC1vZmYtYnk6
IEx1IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+Cj4gLS0tCj4gZHJpdmVycy9pb21t
dS9LY29uZmlnICAgICAgIHwgOSArKysrKysrKysKPiBkcml2ZXJzL2lvbW11L2ludGVsLWlvbW11
LmMgfCA3ICsrKysrKy0KPiAyIGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9LY29uZmlnIGIvZHJpdmVy
cy9pb21tdS9LY29uZmlnCj4gaW5kZXggZTM4NDJlYWJjZmRkLi5mYmRmM2ZkMjkxZDkgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9pb21tdS9LY29uZmlnCj4gKysrIGIvZHJpdmVycy9pb21tdS9LY29u
ZmlnCj4gQEAgLTI0Miw2ICsyNDIsMTUgQEAgY29uZmlnIElOVEVMX0lPTU1VX0ZMT1BQWV9XQQo+
IAkgIHdvcmthcm91bmQgd2lsbCBzZXR1cCBhIDE6MSBtYXBwaW5nIGZvciB0aGUgZmlyc3QKPiAJ
ICAxNk1pQiB0byBtYWtlIGZsb3BweSAoYW4gSVNBIGRldmljZSkgd29yay4KPiAKPiArY29uZmln
IElOVEVMX0lPTU1VX1NDQUxBQkxFX01PREVfREVGQVVMVF9PTgo+ICsJcHJvbXB0ICJFbmFibGUg
SW50ZWwgSU9NTVUgc2NhbGFibGUgbW9kZSBieSBkZWZhdWx0Igo+ICsJZGVwZW5kcyBvbiBJTlRF
TF9JT01NVQo+ICsJaGVscAo+ICsJICBTZWxlY3RpbmcgdGhpcyBvcHRpb24gd2lsbCBlbmFibGUg
dGhlIHNjYWxhYmxlIG1vZGUgaWYKPiArCSAgaGFyZHdhcmUgcHJlc2VudHMgdGhlIGNhcGFiaWxp
dHkuIElmIHRoaXMgb3B0aW9uIGlzIG5vdAo+ICsJICBzZWxlY3RlZCwgc2NhbGFibGUgbW9kZSBz
dXBwb3J0IGNvdWxkIGFsc28gYmUgZW5hYmxlZAo+ICsJICBieSBwYXNzaW5nIGludGVsX2lvbW11
PXNtX29uIHRvIHRoZSBrZXJuZWwuCgoKTWF5YmUgYSBzZW50ZW5jZSBvciB0d28gdG8gZGVzY3Jp
YmUgd2hhdCB0aGUgc2NhbGFibGUgbW9kZSBpcyBpbiBsYXltYW4ncwp0ZXJtcyBjb3VsZCBiZSB1
c2VmdWwsIHNvIGRldmVsb3BlcnMgZG9u4oCZdCBuZWVkIHRvIHNlYXJjaCBhcm91bmQgZm9yIHRo
ZQpLY29uZmlnIHNlbGVjdGlvbj8KCj4gKwo+IGNvbmZpZyBJUlFfUkVNQVAKPiAJYm9vbCAiU3Vw
cG9ydCBmb3IgSW50ZXJydXB0IFJlbWFwcGluZyIKPiAJZGVwZW5kcyBvbiBYODZfNjQgJiYgWDg2
X0lPX0FQSUMgJiYgUENJX01TSSAmJiBBQ1BJCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUv
aW50ZWwtaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwtaW9tbXUuYwo+IGluZGV4IDZkYjZk
OTY5ZTMxYy4uNjA1MWZlNzkwYzYxIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwt
aW9tbXUuYwo+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwtaW9tbXUuYwo+IEBAIC0zNTUsOSAr
MzU1LDE0IEBAIHN0YXRpYyBwaHlzX2FkZHJfdCBpbnRlbF9pb21tdV9pb3ZhX3RvX3BoeXMoc3Ry
dWN0IGlvbW11X2RvbWFpbiAqZG9tYWluLAo+IGludCBkbWFyX2Rpc2FibGVkID0gMDsKPiAjZWxz
ZQo+IGludCBkbWFyX2Rpc2FibGVkID0gMTsKPiAtI2VuZGlmIC8qQ09ORklHX0lOVEVMX0lPTU1V
X0RFRkFVTFRfT04qLwo+ICsjZW5kaWYgLyogQ09ORklHX0lOVEVMX0lPTU1VX0RFRkFVTFRfT04g
Ki8KPiAKPiArI2lmZGVmIElOVEVMX0lPTU1VX1NDQUxBQkxFX01PREVfREVGQVVMVF9PTgo+ICtp
bnQgaW50ZWxfaW9tbXVfc20gPSAxOwo+ICsjZWxzZQo+IGludCBpbnRlbF9pb21tdV9zbTsKPiAr
I2VuZGlmIC8qIElOVEVMX0lPTU1VX1NDQUxBQkxFX01PREVfREVGQVVMVF9PTiAqLwo+ICsKPiBp
bnQgaW50ZWxfaW9tbXVfZW5hYmxlZCA9IDA7Cj4gRVhQT1JUX1NZTUJPTF9HUEwoaW50ZWxfaW9t
bXVfZW5hYmxlZCk7Cj4gCj4gLS0gCj4gMi4xNy4xCj4gCj4gX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KPiBpb21tdSBtYWlsaW5nIGxpc3QKPiBpb21tdUBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwo+IGh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vaW9tbXU=
