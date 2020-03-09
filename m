Return-Path: <SRS0=J+1i=42=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823D5C10F27
	for <iommu@archiver.kernel.org>; Mon,  9 Mar 2020 16:17:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C960246D3
	for <iommu@archiver.kernel.org>; Mon,  9 Mar 2020 16:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="LYPWRY99"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C960246D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 138F225A0C;
	Mon,  9 Mar 2020 16:17:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wNnihX1Cpkcp; Mon,  9 Mar 2020 16:17:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1527B250BF;
	Mon,  9 Mar 2020 16:17:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EFCFFC18D3;
	Mon,  9 Mar 2020 16:17:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38D83C0177
 for <iommu@lists.linux-foundation.org>; Mon,  9 Mar 2020 16:17:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2325C87278
 for <iommu@lists.linux-foundation.org>; Mon,  9 Mar 2020 16:17:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RypTOHUPGvnW for <iommu@lists.linux-foundation.org>;
 Mon,  9 Mar 2020 16:17:21 +0000 (UTC)
X-Greylist: delayed 00:06:07 by SQLgrey-1.7.6
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com
 [209.85.160.196])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5A8BA87270
 for <iommu@lists.linux-foundation.org>; Mon,  9 Mar 2020 16:17:21 +0000 (UTC)
Received: by mail-qt1-f196.google.com with SMTP id a4so7374795qto.12
 for <iommu@lists.linux-foundation.org>; Mon, 09 Mar 2020 09:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ew+9jb+HqObcwrpB1jo+N23u3azkJKqgAtqlD3vrYB8=;
 b=LYPWRY99d4H4yaijPuGOKyG2ZlW8bjaZs0R8HfR2Tm2HxCxhZbpXmO7sXj7SvlTyf8
 eP1cG6ye54QGKo9R24IRuZXcYork3hKwzFFEh9AYH10UYRu4zPwuQZY/hOjNxjDZ7At2
 RVU2YKvShTLi57tsYTkOFXzMOSSeGAoKjUW3g1qHFIhwZdmn0X33sAiZ6haOr0SbijHi
 bcj3rarTGlBkDotByj/7ZqTanCuBV6IRkv5wbojHt9y8od+GeCgT3cxY8EjoCbd01Lcl
 nJ7QU92Z5Q7yeq7UcfyxmTtJXr0buAMDdaKXt+5YRbjAW4ezyo3byp0W9uED0wRrdHIt
 qWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ew+9jb+HqObcwrpB1jo+N23u3azkJKqgAtqlD3vrYB8=;
 b=RA59vhdGJNQwPnM7sEwjWmfizJaK4BYjarpF4KXo9SaLB5R4wEyeoFGkgllcfDAx7R
 zRdhcvi9lSMmi4eqoBOpZNPHzTF52WXgdCXpdYP80/9M7YlRiRQPXzc0nWcbyeY6c2Yr
 Dk4+KLdvAsYVxWNm+9cRedKcNdCHciT6XPL6uHfq7oyk7tuO9s0odPZeSEvx4H0AT6X4
 YKJsGtOz/rTMKHDlH7VAO5g+WUNsfRP857XfFHYCmDjh6+2RSyv8Gno+nHjx3vTmRIzH
 fWJM2aSnAZ7pUxPfDyBuhGTZi59IMjPtiO5Nu4wDR8mWCvLdLsDwaTzwHa2qnpVRVXtF
 g1AA==
X-Gm-Message-State: ANhLgQ1AEmk6VDQVwMx8ZCRgX7ruZZzwST20L8ZZkQVB2QiTzDfWopid
 nzIhh9uX3PhYLTgARgDTOQhpym+7QZw=
X-Google-Smtp-Source: ADFU+vuUGa0WUW110kKCdVUiGT+d0DJEeWs3zMYxxel4r284ptQ572AX3hJOEZLAftzXo3aH9lY/SA==
X-Received: by 2002:ac8:710a:: with SMTP id z10mr12112943qto.181.1583770273196; 
 Mon, 09 Mar 2020 09:11:13 -0700 (PDT)
Received: from [192.168.1.10] (c-66-30-119-151.hsd1.ma.comcast.net.
 [66.30.119.151])
 by smtp.gmail.com with ESMTPSA id w21sm23983251qth.17.2020.03.09.09.11.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2020 09:11:12 -0700 (PDT)
Subject: Re: [PATCH 2/2] iommu/vt-d: dmar_parse_one_rmrr: replace WARN_TAINT
 with pr_warn + add_taint
To: Hans de Goede <hdegoede@redhat.com>, David Woodhouse
 <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>
References: <20200309140138.3753-1-hdegoede@redhat.com>
 <20200309140138.3753-3-hdegoede@redhat.com>
 <34b13929-cbea-9906-0169-8f274bd40377@google.com>
 <ef22beeb-fd9c-ead9-496f-e7466edc94f9@redhat.com>
Message-ID: <096ec150-f7f4-1136-0627-92c7b1e49f0f@google.com>
Date: Mon, 9 Mar 2020 12:11:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <ef22beeb-fd9c-ead9-496f-e7466edc94f9@redhat.com>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, stable@vger.kernel.org
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
From: Barret Rhoden via iommu <iommu@lists.linux-foundation.org>
Reply-To: Barret Rhoden <brho@google.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gMy85LzIwIDEyOjAxIFBNLCBIYW5zIGRlIEdvZWRlIHdyb3RlOgo+IEhpLAo+IAo+IE9uIDMv
OS8yMCA0OjU3IFBNLCBCYXJyZXQgUmhvZGVuIHdyb3RlOgo+PiBPbiAzLzkvMjAgMTA6MDEgQU0s
IEhhbnMgZGUgR29lZGUgd3JvdGU6Cj4+PiBRdW90aW5nIGZyb20gdGhlIGNvbW1lbnQgZGVzY3Jp
YmluZyB0aGUgV0FSTiBmdW5jdGlvbnMgaW4KPj4+IGluY2x1ZGUvYXNtLWdlbmVyaWMvYnVnLmg6
Cj4+Pgo+Pj4gIMKgICogV0FSTigpLCBXQVJOX09OKCksIFdBUk5fT05fT05DRSwgYW5kIHNvIG9u
IGNhbiBiZSB1c2VkIHRvIHJlcG9ydAo+Pj4gIMKgICogc2lnbmlmaWNhbnQga2VybmVsIGlzc3Vl
cyB0aGF0IG5lZWQgcHJvbXB0IGF0dGVudGlvbiBpZiB0aGV5IHNob3VsZCBldmVyCj4+PiAgwqAg
KiBhcHBlYXIgYXQgcnVudGltZS4KPj4+ICDCoCAqCj4+PiAgwqAgKiBEbyBub3QgdXNlIHRoZXNl
IG1hY3JvcyB3aGVuIGNoZWNraW5nIGZvciBpbnZhbGlkIGV4dGVybmFsIGlucHV0cwo+Pj4KPj4+
IFRoZSAoYnVnZ3kpIGZpcm13YXJlIHRhYmxlcyB3aGljaCB0aGUgZG1hciBjb2RlIHdhcyBjYWxs
aW5nIFdBUk5fVEFJTlQKPj4+IGZvciByZWFsbHkgYXJlIGludmFsaWQgZXh0ZXJuYWwgaW5wdXRz
LiBUaGV5IGFyZSBub3QgdW5kZXIgdGhlIGtlcm5lbCdzCj4+PiBjb250cm9sIGFuZCB0aGUgaXNz
dWVzIGluIHRoZW0gY2Fubm90IGJlIGZpeGVkIGJ5IGEga2VybmVsIHVwZGF0ZS4KPj4KPj4gVGhp
cyBwYXRjaCBzb3VuZHMgZ29vZCB0byBtZS4KPiAKPiBDYW4gd2UgaGF2ZSB5b3VyIEFja2VkLWJ5
IHRoZW4gPwoKQWNrZWQtYnkgQmFycmV0IFJob2RlbiA8YnJob0Bnb29nbGUuY29tPgoKPj4gR2l2
ZW4gdGhlIHJ1bGVzIHdpdGggV0FSTiBhbmQgZXh0ZXJuYWwgaW5wdXRzLCBpdCBzb3VuZHMgbGlr
ZSAqYWxsKiB1c2VzIG9mIFdBUk5fVEFJTlQgd2l0aCBUQUlOVF9GSVJNV0FSRV9XT1JLQVJPVU5E
IGFyZSBiYWQ6IFdBUk5zIHRoYXQgYXJlIGxpa2VseSBiYXNlZCBvbiBpbnZhbGlkIGV4dGVybmFs
IGlucHV0LsKgIFByZXN1bWFibHkgd2UncmUgd29ya2luZyBhcm91bmQgRlcgYnVncy4KPiAKPiBS
aWdodCwgYXMgSSBtZW50aW9uZWQgaW4gdGhlIGNvdmVyIGxldHRlciBJJ20gd29ya2luZyBvbiBh
IGZvbGxvdy11cAo+IHNlcmllcyBmaXhpbmcgdGhlIG90aGVyIGNhc2VzLgoKR3JlYXQhCgpUaGFu
a3MsCgpCYXJyZXQKCgogIEkgd2FudGVkIHRvIGdldCB0aGVzZSAyIG91dCB0aGVyZSAoYW5kCj4g
aG9wZWZ1bGx5IGludG8gNS42LXJjIyBzb29uKSBhcyB0aGV5IGFyZSBjYXVzaW5nIGFwcm94IDEt
MiBuZXcKPiBidWctcmVwb3J0cyB0byBiZSBmaWxlZCBldmVyeSBkYXkgZm9yIGp1c3QgRmVkb3Jh
Lgo+IAo+PiBXaGlsZSB3ZSdyZSBvbiB0aGUgc3ViamVjdCwgaXMgV0FSTl9UQUlOVCgpIGV2ZXIg
d29ydGggdGhlIGJhY2t0cmFjZSArIGJ1ZyByZXBvcnQ/wqAgR2l2ZW4gdGhlIGNyaXRlcmlhIGlz
ICJwcm9tcHQgYXR0ZW50aW9uIiwgaXQgc2hvdWxkIGJlIHNvbWV0aGluZyBsaWtlICJuaWNlIHRv
IGtub3cgYWJvdXQgd2hlbiBkZWJ1Z2dpbmcuIgo+IAo+IEkgaGF2ZSBub3QgbG9va2VkIGF0IFdB
Uk5fVEFJTlQgdXNhZ2VzIG90aGVyIHRoZW4gdGhvc2Ugd2l0aCB0aGUKPiBUQUlOVF9GSVJNV0FS
RV9XT1JLQVJPVU5EIGZsYWc7IGFuZCBhcyBtZW50aW9uZWQgSSBkbyBwbGFuIHRvIGZpeAo+IHRo
b3NlLiBGZWVsIGZyZWUgdG8gdGFrZSBhIGxvb2sgYXQgYW55IG90aGVyIGNhbGxlcnMgOikKPiAK
PiBSZWdhcmRzLAo+IAo+IEhhbnMKPiAKPiAKPiAKPj4+IFNvIGxvZ2dpbmcgYSBiYWNrdHJhY2Us
IHdoaWNoIGludml0ZXMgYnVnIHJlcG9ydHMgdG8gYmUgZmlsZWQgYWJvdXQgdGhpcywKPj4+IGlz
IG5vdCBoZWxwZnVsLgo+Pj4KPj4+IFNvbWUgZGlzdHJvcywgZS5nLiBGZWRvcmEsIGhhdmUgdG9v
bHMgd2F0Y2hpbmcgZm9yIHRoZSBrZXJuZWwgYmFja3RyYWNlcwo+Pj4gbG9nZ2VkIGJ5IHRoZSBX
QVJOIG1hY3JvcyBhbmQgb2ZmZXIgdGhlIHVzZXIgYW4gb3B0aW9uIHRvIGZpbGUgYSBidWcgZm9y
Cj4+PiB0aGlzIHdoZW4gdGhlc2UgYXJlIGVuY291bnRlcmVkLiBUaGUgV0FSTl9UQUlOVCBpbiBk
bWFyX3BhcnNlX29uZV9ybXJyCj4+PiArIGFub3RoZXIgaW9tbXUgV0FSTl9UQUlOVCwgYWRkcmVz
c2VkIGluIGFub3RoZXIgcGF0Y2gsIGhhdmUgbGVhZCB0byBvdmVyCj4+PiBhIDEwMCBidWdzIGJl
aW5nIGZpbGVkIHRoaXMgd2F5Lgo+Pj4KPj4+IFRoaXMgY29tbWl0IHJlcGxhY2VzIHRoZSBXQVJO
X1RBSU5UKCIuLi4iKSBjYWxsLCB3aXRoIGEKPj4+IHByX3dhcm4oRldfQlVHICIuLi4iKSArIGFk
ZF90YWludChUQUlOVF9GSVJNV0FSRV9XT1JLQVJPVU5ELCAuLi4pIGNhbGwKPj4+IGF2b2lkaW5n
IHRoZSBiYWNrdHJhY2UgYW5kIHRodXMgYWxzbyBhdm9pZGluZyBidWctcmVwb3J0cyBiZWluZyBm
aWxlZAo+Pj4gYWJvdXQgdGhpcyBhZ2FpbnN0IHRoZSBrZXJuZWwuCj4+Pgo+Pj4gQnVnTGluazog
aHR0cHM6Ly9idWd6aWxsYS5yZWRoYXQuY29tL3Nob3dfYnVnLmNnaT9pZD0xODA4ODc0Cj4+PiBG
aXhlczogZjVhNjhiYjA3NTJlICgiaW9tbXUvdnQtZDogTWFyayBmaXJtd2FyZSB0YWludGVkIGlm
IFJNUlIgZmFpbHMgc2FuaXR5IGNoZWNrIikKPj4+IENjOiBCYXJyZXQgUmhvZGVuIDxicmhvQGdv
b2dsZS5jb20+Cj4+PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwo+Pj4gU2lnbmVkLW9mZi1i
eTogSGFucyBkZSBHb2VkZSA8aGRlZ29lZGVAcmVkaGF0LmNvbT4KPj4+IC0tLQo+Pj4gIMKgIGRy
aXZlcnMvaW9tbXUvaW50ZWwtaW9tbXUuYyB8IDYgKysrKy0tCj4+PiAgwqAgMSBmaWxlIGNoYW5n
ZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9pb21tdS9pbnRlbC1pb21tdS5jIGIvZHJpdmVycy9pb21tdS9pbnRlbC1pb21tdS5j
Cj4+PiBpbmRleCA2ZmE2ZGUyYjZhZDUuLjM4NTdhNWNkMWE3NSAxMDA2NDQKPj4+IC0tLSBhL2Ry
aXZlcnMvaW9tbXUvaW50ZWwtaW9tbXUuYwo+Pj4gKysrIGIvZHJpdmVycy9pb21tdS9pbnRlbC1p
b21tdS5jCj4+PiBAQCAtNDQ2MCwxNCArNDQ2MCwxNiBAQCBpbnQgX19pbml0IGRtYXJfcGFyc2Vf
b25lX3JtcnIoc3RydWN0IGFjcGlfZG1hcl9oZWFkZXIgKmhlYWRlciwgdm9pZCAqYXJnKQo+Pj4g
IMKgwqDCoMKgwqAgc3RydWN0IGRtYXJfcm1ycl91bml0ICpybXJydTsKPj4+ICDCoMKgwqDCoMKg
IHJtcnIgPSAoc3RydWN0IGFjcGlfZG1hcl9yZXNlcnZlZF9tZW1vcnkgKiloZWFkZXI7Cj4+PiAt
wqDCoMKgIGlmIChybXJyX3Nhbml0eV9jaGVjayhybXJyKSkKPj4+IC3CoMKgwqDCoMKgwqDCoCBX
QVJOX1RBSU5UKDEsIFRBSU5UX0ZJUk1XQVJFX1dPUktBUk9VTkQsCj4+PiArwqDCoMKgIGlmIChy
bXJyX3Nhbml0eV9jaGVjayhybXJyKSkgewo+Pj4gK8KgwqDCoMKgwqDCoMKgIHByX3dhcm4oRldf
QlVHCj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIllvdXIgQklPUyBpcyBi
cm9rZW47IGJhZCBSTVJSIFslIzAxOEx4LSUjMDE4THhdXG4iCj4+PiAgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgIkJJT1MgdmVuZG9yOiAlczsgVmVyOiAlczsgUHJvZHVjdCBWZXJz
aW9uOiAlc1xuIiwKPj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBybXJyLT5i
YXNlX2FkZHJlc3MsIHJtcnItPmVuZF9hZGRyZXNzLAo+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGRtaV9nZXRfc3lzdGVtX2luZm8oRE1JX0JJT1NfVkVORE9SKSwKPj4+ICDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkbWlfZ2V0X3N5c3RlbV9pbmZvKERNSV9C
SU9TX1ZFUlNJT04pLAo+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRtaV9n
ZXRfc3lzdGVtX2luZm8oRE1JX1BST0RVQ1RfVkVSU0lPTikpOwo+Pj4gK8KgwqDCoMKgwqDCoMKg
IGFkZF90YWludChUQUlOVF9GSVJNV0FSRV9XT1JLQVJPVU5ELCBMT0NLREVQX1NUSUxMX09LKTsK
Pj4+ICvCoMKgwqAgfQo+Pj4gIMKgwqDCoMKgwqAgcm1ycnUgPSBremFsbG9jKHNpemVvZigqcm1y
cnUpLCBHRlBfS0VSTkVMKTsKPj4+ICDCoMKgwqDCoMKgIGlmICghcm1ycnUpCj4+Pgo+Pgo+IAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFp
bGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
