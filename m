Return-Path: <SRS0=la/L=VW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB50C76194
	for <iommu@archiver.kernel.org>; Thu, 25 Jul 2019 07:19:20 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7549821734
	for <iommu@archiver.kernel.org>; Thu, 25 Jul 2019 07:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDS+98o9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7549821734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2E7981644;
	Thu, 25 Jul 2019 07:19:20 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3CF3E1615
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Jul 2019 07:19:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com
	[209.85.208.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8F6687C
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Jul 2019 07:19:17 +0000 (UTC)
Received: by mail-lj1-f195.google.com with SMTP id z28so47055878ljn.4
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Jul 2019 00:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=DwIfRA6fcW2oe7CbnwGUIqq7af18U05Jyy+yWqYqM5c=;
	b=fDS+98o9oalApKwxVG4RF/dDFVdI9yPmoz5I/YflcP8OTzLCsqj2s/Lw7gaK0ZlgzE
	YT2QDp+xw78giiso+t9s9p/uQmOwlXpwbJXXZdLif3T0KVGo86suj2LbKnKzfPaDOnKZ
	OxiBxBkuwoibEeO9CMWm6usPAJ4t9/BC1/jq/JAZq9T3AzogJ0dOl6vL7rspjXuFKNuP
	YujnoqZsKobRZkeGBKUM81yZF/AMDtbkJ94t1+xOlJvYaRKaCwD1wYYu8GdfJbXBy0iK
	Mr/SfnBladD45nbmVG2ov2H0mNdGpkR6IxIyJog58mRHdV5B4VB/xaIiaU/trnnzsOmy
	2ncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=DwIfRA6fcW2oe7CbnwGUIqq7af18U05Jyy+yWqYqM5c=;
	b=kAryxmx3qRlckJuB9Orbyg3t5YQAetFi2JDb99AqmhPfb6Smp2BV1r7zvmeY7DfEOO
	UGWEx+FinIXSP7MTO6ndQepbIR4Ul591nvxI6ihj1tmHAjrAdSJNkD6iuXuGB0gDF/Ag
	rnwqlFx6HoMqXhIl2qeomhT/L9YaXLw6p+kiT2krVBO3caGPK5eW7TZYN2qI+JjeXwDw
	rCHEPWhEIcZZjfwcHIUmMGSFwJYvsjFcXAsYdh9POcsAE5+3mE55U45jxPGp+Out0+k8
	5h7dld4zMg0pC97foW9PADNKtCgd5tmjqDlodHQoWtousSDji215CRF927ihM/VRImZq
	fykw==
X-Gm-Message-State: APjAAAVbfoieQnSGOZvcIAJ7iOc2LVG4u6PjgDbOj8pgOe2zHat/Vl7k
	J5lmCkoL+yvawFw/HSfh913Q6apN
X-Google-Smtp-Source: APXvYqxprjXpA4VtptPUsVGzv6lssMvOez7iIOSBw530C47pRhsph33mQPMj4q73tDMwTwnr11zYqQ==
X-Received: by 2002:a2e:63cd:: with SMTP id s74mr44547114lje.164.1564039155632;
	Thu, 25 Jul 2019 00:19:15 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-220-99.pppoe.mtu-net.ru.
	[91.78.220.99]) by smtp.googlemail.com with ESMTPSA id
	q21sm7370835lfc.96.2019.07.25.00.19.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Jul 2019 00:19:14 -0700 (PDT)
Subject: Re: [PATCH] media: staging: tegra-vde: Fix build error
To: YueHaibing <yuehaibing@huawei.com>, mchehab@kernel.org,
	gregkh@linuxfoundation.org, thierry.reding@gmail.com,
	jonathanh@nvidia.com, robin.murphy@arm.com, sakari.ailus@linux.intel.com
References: <dc354ede-5963-cd7f-ee53-f3df3061d39a@gmail.com>
	<20190725024129.22664-1-yuehaibing@huawei.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <dd547b44-7abb-371f-aeee-a82b96f824e2@gmail.com>
Date: Thu, 25 Jul 2019 10:19:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190725024129.22664-1-yuehaibing@huawei.com>
Content-Language: en-US
Cc: devel@driverdev.osuosl.org, linux-tegra@vger.kernel.org,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
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

MjUuMDcuMjAxOSA1OjQxLCBZdWVIYWliaW5nINC/0LjRiNC10YI6Cj4gSWYgSU9NTVVfU1VQUE9S
VCBpcyBub3Qgc2V0LCBhbmQgQ09NUElMRV9URVNUIGlzIHksCj4gSU9NTVVfSU9WQSBtYXkgYmUg
c2V0IHRvIG0uIFNvIGJ1aWxkaW5nIHdpbGwgZmFpbHM6Cj4gCj4gZHJpdmVycy9zdGFnaW5nL21l
ZGlhL3RlZ3JhLXZkZS9pb21tdS5vOiBJbiBmdW5jdGlvbiBgdGVncmFfdmRlX2lvbW11X21hcCc6
Cj4gaW9tbXUuYzooLnRleHQrMHg0MSk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGFsbG9jX2lv
dmEnCj4gaW9tbXUuYzooLnRleHQrMHg1Nik6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYF9fZnJl
ZV9pb3ZhJwo+IAo+IFNlbGVjdCBJT01NVV9JT1ZBIHdoaWxlIENPTVBJTEVfVEVTVCBpcyBzZXQg
dG8gZml4IHRoaXMuCj4gCj4gUmVwb3J0ZWQtYnk6IEh1bGsgUm9ib3QgPGh1bGtjaUBodWF3ZWku
Y29tPgo+IFN1Z2dlc3RlZC1ieTogRG1pdHJ5IE9zaXBlbmtvIDxkaWdldHhAZ21haWwuY29tPgo+
IEZpeGVzOiBiMzAxZjhkZTE5MjUgKCJtZWRpYTogc3RhZ2luZzogbWVkaWE6IHRlZ3JhLXZkZTog
QWRkIElPTU1VIHN1cHBvcnQiKQo+IFNpZ25lZC1vZmYtYnk6IFl1ZUhhaWJpbmcgPHl1ZWhhaWJp
bmdAaHVhd2VpLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9zdGFnaW5nL21lZGlhL3RlZ3JhLXZkZS9L
Y29uZmlnIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL21lZGlhL3RlZ3JhLXZkZS9L
Y29uZmlnIGIvZHJpdmVycy9zdGFnaW5nL21lZGlhL3RlZ3JhLXZkZS9LY29uZmlnCj4gaW5kZXgg
MmU3ZjY0NC4uYmE0OWVhNSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3N0YWdpbmcvbWVkaWEvdGVn
cmEtdmRlL0tjb25maWcKPiArKysgYi9kcml2ZXJzL3N0YWdpbmcvbWVkaWEvdGVncmEtdmRlL0tj
b25maWcKPiBAQCAtMyw3ICszLDcgQEAgY29uZmlnIFRFR1JBX1ZERQo+ICAJdHJpc3RhdGUgIk5W
SURJQSBUZWdyYSBWaWRlbyBEZWNvZGVyIEVuZ2luZSBkcml2ZXIiCj4gIAlkZXBlbmRzIG9uIEFS
Q0hfVEVHUkEgfHwgQ09NUElMRV9URVNUCj4gIAlzZWxlY3QgRE1BX1NIQVJFRF9CVUZGRVIKPiAt
CXNlbGVjdCBJT01NVV9JT1ZBIGlmIElPTU1VX1NVUFBPUlQKPiArCXNlbGVjdCBJT01NVV9JT1ZB
IGlmIChJT01NVV9TVVBQT1JUIHx8IENPTVBJTEVfVEVTVCkKPiAgCXNlbGVjdCBTUkFNCj4gIAlo
ZWxwCj4gIAkgICAgU2F5IFkgaGVyZSB0byBlbmFibGUgc3VwcG9ydCBmb3IgdGhlIE5WSURJQSBU
ZWdyYSB2aWRlbyBkZWNvZGVyCj4gCgpUaGlzIHJlc3VsdHMgaW4gbWlzc2luZyB0aGUgY2FzZSBv
ZiBjb21waWxlLXRlc3RpbmcgIUlPTU1VX0lPVkEgZm9yIHRoZQpkcml2ZXIsIGJ1dCBwcm9iYWJs
eSB0aGF0J3Mgbm90IGEgYmlnIGRlYWwuCgpBY2tlZC1ieTogRG1pdHJ5IE9zaXBlbmtvIDxkaWdl
dHhAZ21haWwuY29tPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
