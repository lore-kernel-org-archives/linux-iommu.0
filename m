Return-Path: <SRS0=56b4=IQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC14C433E0
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 21:31:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFC6E64F04
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 21:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFC6E64F04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9ABA1432C3;
	Thu, 18 Mar 2021 21:31:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id taTtj707ggl0; Thu, 18 Mar 2021 21:31:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6BF48400D5;
	Thu, 18 Mar 2021 21:31:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3ED84C000B;
	Thu, 18 Mar 2021 21:31:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 770BFC0001
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 21:31:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4DF066FAF3
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 21:31:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ir6k7IiaL8kZ for <iommu@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 21:31:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4F84F6FAFB
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 21:31:20 +0000 (UTC)
Received: by mail-pl1-x62c.google.com with SMTP id g1so1949035plg.7
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 14:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=urs31C1oCCeprVuwl2xS/PR4GaFAJl/+dTB9iEb63mU=;
 b=KZbC1ubJfdJSCMLlYSsz53FpXhle0Z79REbw0h4uYlS+NaKZD+4i06PhYx8XcW3OEm
 S24OKPOUpysAb9kFqBIh4omlHLsQ4K5+3GWlbW1LDCjNASBOzZbDcugMWxGt718SO2aF
 bvh+g72bGJSm89bwqurmoPeSF+7QMLcyvSE+otVFWljC2/jgyAzz5H8L6D1EMSA0BypU
 /q9TLEuSCO6ecJSoPnnq9IZfbVdHX8KWf6R+pP+i3oS5qjo0QtxTMQeeVVH19WYZ/Ml+
 C+X7WLD3lMfI7KfY3yLzro7oLvlcWVCv2JDrk9EktIzaOwgXbeFibEbeuCDFJ43HWImo
 Drcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=urs31C1oCCeprVuwl2xS/PR4GaFAJl/+dTB9iEb63mU=;
 b=V+rQ7/iC+8cjppeG2OAQpew7bgP3UxWe6hiJ0RsejdpZRjBVYoughNNqkHabAWDKpA
 Isn3BUYNUmRHZAcjhX1DK8xBreMwK+IUureBjY0zc51fI3PP4bl0rGt44LNiLJW1RoLq
 LrAnHeBTjLAK6pxqzPs7vJm5L/Y2axZiz0b4yUWeYH0I+h5yXj1TUeIh2wtLNamGXyZW
 lB0P2G7D3+Qdl2mbXGP/Lnr4GQRqr3rG8jwAiVgGvcV/ac3/HTckx83vHqU8znChQqlI
 VpFRowJDsaMQD0x4jcc6OpL2nhZcxZRSzgZeUvbRzdvgcEQg35dkCg0fApl1w+1KiALg
 OI0Q==
X-Gm-Message-State: AOAM531WQwDJRorrAO+yCUEewvtsY6Ndg2qDova3DuyIiGkwwTOvp6Oo
 s2uI3BhGiw6xBnupWm2x0IE=
X-Google-Smtp-Source: ABdhPJwZynkHFeh94Ggvq5VKM7xZxZxokfdCvK0mYjOVVb3AS6xB6y2N36hJoyMG2e42huOSBG8I5g==
X-Received: by 2002:a17:90a:bf04:: with SMTP id
 c4mr6268131pjs.170.1616103079707; 
 Thu, 18 Mar 2021 14:31:19 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id j35sm3220312pgj.45.2021.03.18.14.31.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Mar 2021 14:31:19 -0700 (PDT)
Subject: Re: [PATCH] swiotlb: Add swiotlb=off to disable SWIOTLB
To: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
References: <20210318191816.4185226-1-f.fainelli@gmail.com>
 <bbd44c42-cedc-7bd6-a443-c991fd080298@gmail.com>
 <e7850feb-b7cd-e279-e3fc-a9bdba162423@arm.com>
 <f0940ea7-79f6-af57-aa7d-d121abb99012@gmail.com>
 <16d1c66f-5451-2515-af73-a6b44d996e92@arm.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <a8a05321-3fd0-d1c4-9d76-ec2e79e310ec@gmail.com>
Date: Thu, 18 Mar 2021 14:31:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <16d1c66f-5451-2515-af73-a6b44d996e92@arm.com>
Content-Language: en-US
Cc: opendmb@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 "open list:SWIOTLB SUBSYSTEM" <iommu@lists.linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Mike Kravetz <mike.kravetz@oracle.com>
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

CgpPbiAzLzE4LzIwMjEgMTI6NTMgUE0sIFJvYmluIE11cnBoeSB3cm90ZToKPiBPbiAyMDIxLTAz
LTE4IDE5OjQzLCBGbG9yaWFuIEZhaW5lbGxpIHdyb3RlOgo+Pgo+Pgo+PiBPbiAzLzE4LzIwMjEg
MTI6MzQgUE0sIFJvYmluIE11cnBoeSB3cm90ZToKPj4+IE9uIDIwMjEtMDMtMTggMTk6MjIsIEZs
b3JpYW4gRmFpbmVsbGkgd3JvdGU6Cj4+Pj4KPj4+Pgo+Pj4+IE9uIDMvMTgvMjAyMSAxMjoxOCBQ
TSwgRmxvcmlhbiBGYWluZWxsaSB3cm90ZToKPj4+Pj4gSXQgbWF5IGJlIHVzZWZ1bCB0byBkaXNh
YmxlIHRoZSBTV0lPVExCIGNvbXBsZXRlbHkgZm9yIHRlc3Rpbmcgb3IKPj4+Pj4gd2hlbiBhCj4+
Pj4+IHBsYXRmb3JtIGlzIGtub3duIG5vdCB0byBoYXZlIGFueSBEUkFNIGFkZHJlc3NpbmcgbGlt
aXRhdGlvbnMgd2hhdCBzbwo+Pj4+PiBldmVyLgo+Pj4KPj4+IElzbid0IHRoYXQgd2hhdCAic3dp
b3RsYj1ub2ZvcmNlIiBpcyBmb3I/IElmIHlvdSdyZSBjb25maWRlbnQgdGhhdCB3ZSd2ZQo+Pj4g
cmVhbGx5IGlyb25lZCBvdXQgKmFsbCogdGhlIGF3a3dhcmQgY29ybmVycyB0aGF0IHVzZWQgdG8g
YmxvdyB1cCBpZgo+Pj4gdmFyaW91cyBpbnRlcm5hbCBiaXRzIHdlcmUgbGVmdCB1bmluaXRpYWxp
c2VkLCB0aGVuIGl0IHdvdWxkIG1ha2Ugc2Vuc2UKPj4+IHRvIGp1c3QgdHdlYWsgdGhlIGltcGxl
bWVudGF0aW9uIG9mIHdoYXQgd2UgYWxyZWFkeSBoYXZlLgo+Pgo+PiBzd2lvdGxiPW5vZm9yY2Ug
ZG9lcyBwcmV2ZW50IGRtYV9kaXJlY3RfbWFwX3BhZ2UoKSBmcm9tIHJlc29ydGluZyB0byB0aGUK
Pj4gc3dpb3RsYiwgaG93ZXZlciB3aGF0IEkgYW0gYWxzbyBhZnRlciBpcyByZWNsYWltaW5nIHRo
ZXNlIDY0TUIgb2YKPj4gZGVmYXVsdCBTV0lPVExCIGJvdW5jZSBidWZmZXJpbmcgbWVtb3J5IGJl
Y2F1c2UgbXkgc3lzdGVtcyBydW4gd2l0aAo+PiBsYXJnZSBhbW91bnRzIG9mIHJlc2VydmVkIG1l
bW9yeSBpbnRvIFpPTkVfTU9WQUJMRSBhbmQgZXZlcnl0aGluZyBpbgo+PiBaT05FX05PUk1BTCBp
cyBwcmVjaW91cyBhdCB0aGF0IHBvaW50Lgo+IAo+IEl0IGFsc28gZm9yY2VzIGlvX3RsYl9uc2xh
YnMgdG8gdGhlIG1pbmltdW0sIHNvIGl0IHNob3VsZCBiZSBjbGFpbWluZwo+IGNvbnNpZGVyYWJs
eSBsZXNzIHRoYW4gNjRNQi4gSUlSQyB0aGUgb3JpZ2luYWwgcHJvcG9zYWwgKmRpZCogc2tpcAo+
IGluaXRpYWxpc2F0aW9uIGNvbXBsZXRlbHksIGJ1dCB0aGF0IHR1cm5lZCB1cCB0aGUgYWZvcmVt
ZW50aW9uZWQgaXNzdWVzLgoKQUZBSUNUIGluIHRoYXQgY2FzZSB3ZSB3aWxsIGhhdmUgaW90bGJf
bl9zbGFicyB3aWxsIHNldCB0byAxLCB3aGljaCB3aWxsCnN0aWxsIG1ha2UgdXMgYWxsb2NhdGUg
aW9fdGxiX25fc2xhYnMgPDwgSU9fVExCX1NISUZUIGJ5dGVzIGluCnN3aW90bGJfaW5pdCgpLCB3
aGljaCBzdGlsbCBnaXZlcyB1cyA2NE1CLgoKPiAKPj4+IEkgd291bGRuJ3QgbmVjZXNzYXJpbHkg
ZGlzYWdyZWUgd2l0aCBhZGRpbmcgIm9mZiIgYXMgYW4gYWRkaXRpb25hbCBhbGlhcwo+Pj4gZm9y
ICJub2ZvcmNlIiwgdGhvdWdoLCBzaW5jZSBpdCBkb2VzIGNvbWUgYWNyb3NzIGFzIGEgYml0IHdh
Y2t5IGZvcgo+Pj4gZ2VuZXJhbCB1c2UuCj4+Pgo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBGbG9yaWFu
IEZhaW5lbGxpIDxmLmZhaW5lbGxpQGdtYWlsLmNvbT4KPj4+Pgo+Pj4+IENocmlzdG9waCwgaW4g
YWRkaXRpb24gdG8gdGhpcyBjaGFuZ2UsIGhvdyB3b3VsZCB5b3UgZmVlbCBpZiB3ZQo+Pj4+IHF1
YWxpZmllZCB0aGUgc3dpb3RsYl9pbml0KCkgaW4gYXJjaC9hcm0vbW0vaW5pdC5jIHdpdGggYToK
Pj4+Pgo+Pj4+Cj4+Pj4gaWYgKG1lbWJsb2NrX2VuZF9vZl9EUkFNKCkgPj0gU1pfNEcpCj4+Pj4g
wqDCoMKgwqDCoHN3aW90bGJfaW5pdCgxKQo+Pj4KPj4+IE1vZHVsbyAic3dpb3RsYj1mb3JjZSIs
IG9mIGNvdXJzZSA7KQo+Pgo+PiBJbmRlZWQsIHdlIHdvdWxkIG5lZWQgdG8gaGFuZGxlIHRoYXQg
Y2FzZSBhcyB3ZWxsLiBEb2VzIGl0IHNvdW5kCj4+IHJlYXNvbmFibGUgdG8gZG8gdGhhdCB0byB5
b3UgYXMgd2VsbD8KPiAKPiBJIHdvdWxkbid0IGxpa2UgaXQgZG9uZSB0byBtZSBwZXJzb25hbGx5
LCBidXQgZm9yIGFybTY0LCBvYnNlcnZlIHdoYXQKPiBtZW1faW5pdCgpIGluIGFyY2gvYXJtNjQv
bW0vaW5pdC5jIGFscmVhZHkgZG9lcy4KPiAKPiBSb2Jpbi4KCi0tIApGbG9yaWFuCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlz
dAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
