Return-Path: <SRS0=Mf8z=KM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A016C433ED
	for <iommu@archiver.kernel.org>; Mon, 17 May 2021 12:45:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D09D6101B
	for <iommu@archiver.kernel.org>; Mon, 17 May 2021 12:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D09D6101B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0167583C49;
	Mon, 17 May 2021 12:45:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kKL46wHLl120; Mon, 17 May 2021 12:45:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E14983BE1;
	Mon, 17 May 2021 12:45:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9E1EC000D;
	Mon, 17 May 2021 12:45:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B259FC0001
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 12:45:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 93E254050B
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 12:45:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tfK1vBqG2eJE for <iommu@lists.linux-foundation.org>;
 Mon, 17 May 2021 12:45:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BCAAD40501
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 12:45:12 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id h9so6360064oih.4
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 05:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=bBBm+WeHyz4lkqmetRMun1w+G5fl+4ObKMk21jjZXDo=;
 b=fDbCmPvV4q2OS4aLWE1KQwF12pUd3FlZ3XEq5OSfSnQWLygroXQAxUjkaWInH4JTW+
 czwfirUH+JmeQHhesZIDvZ5f06eI/+ixi3b+52hLFDXTZCU8SSQ0JZuoiT+p4h5v859y
 76D5BEpAZu6CFEkO8CXJ6yTXCzZ3eKnyEBS/4CHBt4ftJh2h+X83Wx7isDL65AtTDX8n
 XxVahAFSD+ZQsTU3W0VCwPUsPRO5NAYOb5LSG6ShoT0U43PnrWA3sFdDzizrj21VtEnM
 dSBbS61q+LPDIHTIRfZdaHCGmzwOCuEo6Rd9xx650MSncVMwy/zXjf2YN6YLeL4/FuWb
 ZRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bBBm+WeHyz4lkqmetRMun1w+G5fl+4ObKMk21jjZXDo=;
 b=Baio2K3STZAVOy+WVXUBCO1GAKyoxhq/CQFSgK4kDnTSzfEeY1K/P8Yxt4GoUQd0i2
 sX7dPMbiAR5ufZKChrR345MM8VkpVxliwGu1arm98oLx5U/TXt2u37jPTLcWRSeNCNo6
 buzoP9CQ0a4LRPQOmW9RpiPhLwj85aVRHChJGDDDFB4nq5est/nULyiFfe00I+dCC5k6
 G2ioH33hS7TCSuzkfmXGeRtrkJsgY1UxHIdo76N0Ev2ON4mxTMBAAo/DC6B2MJf7/7NP
 5nB1deUlS4EfnfxZcN00wtHSskv0AYpW1afFsotbgCSfY0JT/bGVaI16LF7R09Lo1XBV
 O41Q==
X-Gm-Message-State: AOAM5320LjZ1wnNTuVBbO3yqcrcNvfy5+QM4QDazbnoTeARfPY35WGrM
 HkqtHrOvNwusCdjJizFlt3EZ8cqNk3imqFNSUzQ=
X-Google-Smtp-Source: ABdhPJxzJP4HwiriiP7w14de/Kr5lE657Tw5IZx4On2XQ3FQGHiwAjvO0FlwLXQfh0ttqKMd8IExwVUxrfsx02NYRbw=
X-Received: by 2002:aca:f156:: with SMTP id p83mr42943541oih.91.1621255511852; 
 Mon, 17 May 2021 05:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <e0e9ecf4-cfd7-b31a-29b0-ead4a6c0ee40@charleswright.co>
 <1621180418@msgid.manchmal.in-ulm.de> <YKI/D64ODBUEHO9M@kroah.com>
 <1621251453@msgid.manchmal.in-ulm.de> <1621251685@msgid.manchmal.in-ulm.de>
 <CA+res+RHyF22T-sGwCG5zA6EBrk_gWbnZETX_iAgdRdWaPLbfw@mail.gmail.com>
 <1621254246@msgid.manchmal.in-ulm.de>
In-Reply-To: <1621254246@msgid.manchmal.in-ulm.de>
From: Jack Wang <jack.wang.usish@gmail.com>
Date: Mon, 17 May 2021 14:45:01 +0200
Message-ID: <CA+res+QRm3VyJSjMaKLYm=KY5+T5nX+6-QhOgrgBcP+d2Ganag@mail.gmail.com>
Subject: Re: 5.10.37 won't boot on my system, but 5.10.36 with same config does
To: Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
Cc: iommu@lists.linux-foundation.org, stable <stable@vger.kernel.org>
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

Q2hyaXN0b3BoIEJpZWRsIDxsaW51eC1rZXJuZWwuYmZyekBtYW5jaG1hbC5pbi11bG0uZGU+IOS6
jjIwMjHlubQ15pyIMTfml6XlkajkuIAg5LiL5Y2IMjoyNeWGmemBk++8mgo+Cj4gSmFjayBXYW5n
IHdyb3RlLi4uCj4KPiA+IENocmlzdG9waCBCaWVkbCA8bGludXgta2VybmVsLmJmcnpAbWFuY2ht
YWwuaW4tdWxtLmRlPiDkuo4yMDIx5bm0NeaciDE35pel5ZGo5LiAIOS4i+WNiDE6NTLlhpnpgZPv
vJoKPiA+ID4KPiA+ID4gQ2hyaXN0b3BoIEJpZWRsIHdyb3RlLi4uCj4gPiA+Cj4gPiA+ID4gVGhh
bmtzIGZvciB0YWtpbmcgY2FyZSwgdW5mb3J0dW5hdGVseSBubyBpbXByb3ZlbWVudCB3aXRoIDUu
MTAuMzgtcmMxIGhlcmUuCj4gPiA+Cj4gPiA+IFNvIGluIGNhc2UgdGhpcyBpcyByZWxhdGVkIHRv
IHRoZSAuY29uZmlnLCBJJ20gYXR0YWNoaW5nIGl0LiBIYXJkd2FyZSBpcywKPiA+ID4gYXMgc2Fp
ZCBiZWZvcmUsIGFuIG9sZCBUaGlua3BhZCB4MjAwLCB2ZW5kb3IgQklPUyBhbmQgbm8gcGFydGlj
dWxhciBtb2RpZmljYXRpb25zLgo+ID4gPiBBZnRlciBkaXNhYmxpbmcgYWxsIHZnYS92aWRlby9m
YmNvbiBwYXJhbWV0ZXJzIEkgc2VlIHRoZSBzeXN0ZW0gc3VmZmVycwo+ID4gPiBhIGtlcm5lbCBw
YW5pYyBidXQgdW5mb3J0dW5hdGVseSBvbmx5IHRoZSBsYXN0IDI1IGxpbmVzIGFyZSB2aXNpYmxl
Lgo+ID4gPiBQb3NzaWJseSAodHlwb3MgYXJlIG1pbmUpCj4gPiA+Cj4gPiA+ICAgICBSSVA6IDAw
MTA6X19kb21haW5fbWFwcGluZysweGE3LzB4M2EwCj4gPiA+Cj4gPiA+IGlzIGEgaGludCBpbnRv
IHRoZSByaWdodCBkaXJlY3Rpb24/Cj4gPiBUaGlzIGxvb2tzIGludGVsX2lvbW11IHJlbGF0ZWQs
IGNhbiB5b3UgdHJ5IGJvb3Qgd2l0aAo+ID4gImludGVsX2lvbW11PW9mZiIgaW4ga2VybmVsIHBh
cmFtZXRlcj8KPgo+IEdvdGNoYS4gU3lzdGVtIGJvb3RzIHVwIGZpbmUgdGhlbi4KPgo+ICAgICBD
aHJpc3RvcGgKU28gaXQncyBjYXVzZWQgYnkgdGhpcyBjb21taXRbMV0sIGFuZCBpdCBzaG91bGQg
YmUgZml4ZWQgYnkgbGF0ZXN0CjUuMTAuMzgtcmMxIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHVi
L3NjbS9saW51eC9rZXJuZWwvZ2l0L3N0YWJsZS9saW51eC1zdGFibGUtcmMuZ2l0L2xvZy8/aD1s
aW51eC01LjEwLnkKWzFdaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvc3RhYmxlLzIwMjEwNTE1MTMy
ODU1LjRibjd2ZTJvenZkaHBuajRAbmFib2tvdi5mcml0ei5ib3gvCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
