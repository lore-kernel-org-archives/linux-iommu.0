Return-Path: <SRS0=CVo8=5Z=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D9FC352B6
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 09:54:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 918262083E
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 09:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pPOs1I9W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 918262083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5AD19242F3;
	Thu,  9 Apr 2020 09:45:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 97DTUnZ+OVbb; Thu,  9 Apr 2020 09:45:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1B71820015;
	Thu,  9 Apr 2020 09:45:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0790C1D7E;
	Thu,  9 Apr 2020 09:45:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F87EC0177
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 09:45:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4A12B854D0
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 09:45:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MOroKUzXN0lw for <iommu@lists.linux-foundation.org>;
 Thu,  9 Apr 2020 09:45:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id CBAC5853D3
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 09:44:59 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id h2so3228436wmb.4
 for <iommu@lists.linux-foundation.org>; Thu, 09 Apr 2020 02:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=PesRHogudULc4/x9yhdrVQgI67Y/2LGQZWmhimPv3t4=;
 b=pPOs1I9W3kE0K0EX32bKoAS7AYeVXe/ym1tzYg00fJ1JDUmSPicjSIVRZkZ7tr403a
 Hn17sphcjZjxUHxDMHrcZYBwZcHOkCQpBHJWEHLF72kAyR95pS45Ua1yguLyI74N+BR+
 uD9wHsMyKQrzFG19X0J3ZGmKhQ9sGhQx0d7dCPmr59w3yWlzvZLXH9S7Uyd1sPCe+9tA
 7lN+YtMD1q8vcrccr8rCM96+DB13c5XsBsatyYRP64GXCF6RN8JXpLLiQnCAINtrC3aZ
 1S6cvDKFr2Xd4o5yOSKoAoH4Mzb1prXSGfPxBCmkJ2OQYEg9PQpScVHFCK0+EPR5a/ix
 LF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=PesRHogudULc4/x9yhdrVQgI67Y/2LGQZWmhimPv3t4=;
 b=B0oiv2x7Y2GhLMCe8vJy6UtXUPV465PWE9E9WWV2gNQUkwKSF2ETk2WakVvNxJyW++
 1vPidlP/XbUwsYz/yianXMnCid3hwYL8xGA4lQjYGYmrdPh5mByEPROwK+gdkku6xDd+
 wQzF0a02wL9jV5KSZObVS9Iyaz78tDEcfNve9EB/RrO8eSrdpNhGnGONknikNGGL2UB6
 WVByX7i+4+faqAoBsfU4Eqobz4lIpFEAxCW/Z2gSoluhbDdFnk3lFRhUGHIWFfXHZyRD
 4BmLLNyzZqy9CgGFVaY/Iwg5EOT+X1RuFzJN8MNhUMRHO2fYCQDytYHb3HbI2GeBFlga
 mN1Q==
X-Gm-Message-State: AGi0Puaw2SR3ntizllEKKpwmA6Nbl3liyVQVagf4B19uidyGAQZgwfM9
 WYOvo2KQRgxLnUgv0m2hCxsOVw==
X-Google-Smtp-Source: APiQypLIUrIgM2XxQKdDqHVNyQcqogr57r2ycGCfdl5Lf1OXr2lVGgFDaKqXk4q7eve0zFW7IYgvLg==
X-Received: by 2002:a1c:4c10:: with SMTP id z16mr9291034wmf.77.1586425498203; 
 Thu, 09 Apr 2020 02:44:58 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id n6sm2998144wmc.28.2020.04.09.02.44.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2020 02:44:57 -0700 (PDT)
Date: Thu, 9 Apr 2020 11:44:50 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: Re: [PATCH 1/2] uacce: Remove mm_exit() op
Message-ID: <20200409094450.GI2435@myrica>
References: <20200408140427.212807-1-jean-philippe@linaro.org>
 <20200408140427.212807-2-jean-philippe@linaro.org>
 <5741a4d9-c3ae-f0d6-27f9-550bbeaa4c4a@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5741a4d9-c3ae-f0d6-27f9-550bbeaa4c4a@linaro.org>
Cc: gregkh@linuxfoundation.org, iommu@lists.linux-foundation.org, arnd@arndb.de,
 linux-accelerators@lists.ozlabs.org, jgg@ziepe.ca
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

T24gVGh1LCBBcHIgMDksIDIwMjAgYXQgMDU6MDc6MzRQTSArMDgwMCwgWmhhbmdmZWkgR2FvIHdy
b3RlOgo+IAo+IAo+IE9uIDIwMjAvNC84IOS4i+WNiDEwOjA0LCBKZWFuLVBoaWxpcHBlIEJydWNr
ZXIgd3JvdGU6Cj4gPiBUaGUgbW1fZXhpdCgpIG9wIHdpbGwgYmUgcmVtb3ZlZCBmcm9tIHRoZSBT
VkEgQVBJLiBXaGVuIGEgcHJvY2VzcyBkaWVzCj4gPiBhbmQgaXRzIG1tIGdvZXMgYXdheSwgdGhl
IElPTU1VIGRyaXZlciB3b24ndCBub3RpZnkgZGV2aWNlIGRyaXZlcnMKPiA+IGFueW1vcmUuIERy
aXZlcnMgc2hvdWxkIGV4cGVjdCB0byBoYW5kbGUgYSBsb3QgbW9yZSBhYm9ydGVkIERNQS4gT24g
dGhlCj4gPiB1cHNpZGUsIGl0IGRvZXMgZ3JlYXRseSBzaW1wbGlmeSB0aGUgcXVldWUgbWFuYWdl
bWVudC4KPiA+IAo+ID4gVGhlIHVhY2NlX21tIHN0cnVjdCwgdGhhdCB0cmFja3MgYWxsIHF1ZXVl
cyBib3VuZCB0byBhbiBtbSwgd2FzIG9ubHkKPiA+IHVzZWQgYnkgdGhlIG1tX2V4aXQoKSBjYWxs
YmFjay4gUmVtb3ZlIGl0Lgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBKZWFuLVBoaWxpcHBlIEJy
dWNrZXIgPGplYW4tcGhpbGlwcGVAbGluYXJvLm9yZz4KPiBUaGFua3MgSmVhbiBmb3IgZG9pbmcg
dGhpcy4KPiAKPiBUZXN0ZWQtYnk6IFpoYW5nZmVpIEdhbyA8emhhbmdmZWkuZ2FvQGxpbmFyby5v
cmc+Cj4gCj4gRXhjZXB0IG9uZSBsaW5lLgo+ID4gLXN0YXRpYyB2b2lkIHVhY2NlX21tX3B1dChz
dHJ1Y3QgdWFjY2VfcXVldWUgKnEpCj4gPiArc3RhdGljIHZvaWQgdWFjY2VfdW5iaW5kX3F1ZXVl
KHN0cnVjdCB1YWNjZV9xdWV1ZSAqcSkKPiA+ICAgewo+ID4gLQlzdHJ1Y3QgdWFjY2VfbW0gKnVh
Y2NlX21tID0gcS0+dWFjY2VfbW07Cj4gPiAtCj4gPiAtCWxvY2tkZXBfYXNzZXJ0X2hlbGQoJnEt
PnVhY2NlLT5tbV9sb2NrKTsKPiA+IC0KPiA+IC0JbXV0ZXhfbG9jaygmdWFjY2VfbW0tPmxvY2sp
Owo+ID4gLQlsaXN0X2RlbCgmcS0+bGlzdCk7Cj4gPiAtCW11dGV4X3VubG9jaygmdWFjY2VfbW0t
PmxvY2spOwo+ID4gLQo+ID4gLQlpZiAobGlzdF9lbXB0eSgmdWFjY2VfbW0tPnF1ZXVlcykpIHsK
PiA+IC0JCWlmICh1YWNjZV9tbS0+aGFuZGxlKQo+ID4gLQkJCWlvbW11X3N2YV91bmJpbmRfZGV2
aWNlKHVhY2NlX21tLT5oYW5kbGUpOwo+ID4gLQkJbGlzdF9kZWwoJnVhY2NlX21tLT5saXN0KTsK
PiA+IC0JCWtmcmVlKHVhY2NlX21tKTsKPiA+IC0JfQo+ID4gKwlpZiAoIXEtPmhhbmRsZSkKPiA+
ICsJCXJldHVybjsKPiA+ICsJaW9tbXVfc3ZhX3VuYmluZF9kZXZpY2UocS0+aGFuZGxlKTsKPiAr
IHEtPmhhbmRsZSA9IDA7Cj4gCj4gT3RoZXJ3aXNlIGlvbW11X3N2YV91bmJpbmRfZGV2aWNlIG1h
eWJlIGNhbGxlZCB0d2ljZS4KPiBTaW5jZSB1YWNjZV91bmJpbmRfcXVldWUgY2FuIGJlIGNhbGxl
ZCBieSB1YWNjZV9yZW1vdmUgYW5kIHVhY2NlX2ZvcHNfcmVsZWFzZS4KClRoYW5rcywgSSdsbCBh
ZGQgaXQgaW4gdjIKCkplYW4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lv
bW11
