Return-Path: <SRS0=R7pc=2N=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20417C2D0C0
	for <iommu@archiver.kernel.org>; Mon, 23 Dec 2019 20:28:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD771206CB
	for <iommu@archiver.kernel.org>; Mon, 23 Dec 2019 20:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="WdhTbqUD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD771206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B280A847B3;
	Mon, 23 Dec 2019 20:28:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LySi6DA72Uz5; Mon, 23 Dec 2019 20:28:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2B05184778;
	Mon, 23 Dec 2019 20:28:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B2F0C1D80;
	Mon, 23 Dec 2019 20:28:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96EF0C0881
 for <iommu@lists.linux-foundation.org>; Mon, 23 Dec 2019 20:27:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7FAF720509
 for <iommu@lists.linux-foundation.org>; Mon, 23 Dec 2019 20:27:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8fWD-+zn3Vk9 for <iommu@lists.linux-foundation.org>;
 Mon, 23 Dec 2019 20:27:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
 [209.85.214.193])
 by silver.osuosl.org (Postfix) with ESMTPS id 98B6E204FE
 for <iommu@lists.linux-foundation.org>; Mon, 23 Dec 2019 20:27:58 +0000 (UTC)
Received: by mail-pl1-f193.google.com with SMTP id g6so4651946plp.6
 for <iommu@lists.linux-foundation.org>; Mon, 23 Dec 2019 12:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0CpDSOHl4OB3Bl/8MPwGobF9HXf9d9LqUIFLz9HC5Pg=;
 b=WdhTbqUDds7nyFaC9p71RME7G0VwPZ9ZDH6V0nR6o0rqKzuerooiAls4fT/9Ui5t4x
 wqS8AZCEr60/tsFY+EP6KnlDlbpM7Ye/QWsI9YZ2CDiGa/AhTR2lk6KjF0FkwJu6EiA8
 tn7W8fxAFagZMlpEKbUVSCsIJdos/MnZvsA78QX1wer/aITw7vIE6qxGUvq9gJpG8zk3
 OYykfoWDypbvlEn6Uq6U9DLEGtUwaWcwEHgFXUeNq9klbkCGfpHGfazk+qeJESdOTu3A
 RilDvmQCO+nmvJ0BDvSyQvvqP7kPvmF3uKs8It21GkuvazsDqx+h6uHJoESP1noQXx8d
 3bEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0CpDSOHl4OB3Bl/8MPwGobF9HXf9d9LqUIFLz9HC5Pg=;
 b=jkG7jFmvXOOn/nSR0Yr6uYEagMeyy6tQBwMy8kxkvIsPWTyPaIhE8xRY1sfLUh7Uwg
 3FH53V6PiQ/5gs2UMGED4HY6rWqekGPndg3PMOlSDKWm6bPMFamI8KI0gEEN/Ft1WqRT
 4abLbMvPGsT3prszyTCVsOPUpMddNIm9cr/qFrfBPhXyaCFL6u27aH/EvGbGkp0A9FCR
 4CBQvN33oUeekI1/o9DEdG6wtnLGSmpQuELmWrkaqVvKp5SKCbcBR4kHWgyGy3QqsmN8
 0xj44VOlFIYjOVnViEIObSADdWD6Eam6WhqBAA3zdLMp7SR7BpDpMnfqFY5CfXdmYiBJ
 Li4w==
X-Gm-Message-State: APjAAAVCSps929hJJYZOpwmbDK01xbBRe5g+CnACwVoQv7odSaAaR7io
 kl3bKEUzf3ecVsrnfkkfObhI8g==
X-Google-Smtp-Source: APXvYqxbImqtxcivG20ioyyeelsS5eDCA5kPWmfhNdOu+pRVWG/5srb/+ywEPdeZXOlh7WPZS+T52Q==
X-Received: by 2002:a17:90b:3115:: with SMTP id
 gc21mr1095410pjb.54.1577132877922; 
 Mon, 23 Dec 2019 12:27:57 -0800 (PST)
Received: from gnomeregan.cam.corp.google.com
 ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
 by smtp.googlemail.com with ESMTPSA id m6sm328478pjv.23.2019.12.23.12.27.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Dec 2019 12:27:57 -0800 (PST)
Subject: Re: [PATCH 1/3] iommu/vt-d: skip RMRR entries that fail the sanity
 check
To: "Chen, Yian" <yian.chen@intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, Sohil Mehta <sohil.mehta@intel.com>
References: <20191211194606.87940-1-brho@google.com>
 <20191211194606.87940-2-brho@google.com>
 <99a294a0-444e-81f9-19a2-216aef03f356@intel.com>
 <93820c21-8a37-d8f0-dacb-29cee694a91d@google.com>
 <4c24f2d2-03fd-a6cb-f950-391f3f7837cb@intel.com>
Message-ID: <14ccbc00-7451-bd2e-d861-01c422cad53a@google.com>
Date: Mon, 23 Dec 2019 15:27:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <4c24f2d2-03fd-a6cb-f950-391f3f7837cb@intel.com>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
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

T24gMTIvMTcvMTkgMjoxOSBQTSwgQ2hlbiwgWWlhbiB3cm90ZToKPj4gUmVnYXJkbGVzcywgSSBo
YXZlIHR3byBvdGhlciBwYXRjaGVzIGluIHRoaXMgc2VyaWVzIHRoYXQgY291bGQgcmVzb2x2ZSAK
Pj4gdGhlIHByb2JsZW0gZm9yIG1lIGFuZCBwcm9iYWJseSBvdGhlciBwZW9wbGUuwqAgSSdkIGp1
c3QgbGlrZSBhdCBsZWFzdCAKPj4gb25lIG9mIHRoZSB0aHJlZSBwYXRjaGVzIHRvIGdldCBtZXJn
ZWQgc28gdGhhdCBteSBtYWNoaW5lIGJvb3RzIHdoZW4gCj4+IHRoZSBvcmlnaW5hbCBjb21taXQg
ZjAzNmM3ZmEwYWI2ICgiaW9tbXUvdnQtZDogQ2hlY2sgVlQtZCBSTVJSIHJlZ2lvbiAKPj4gaW4g
QklPUyBpcyByZXBvcnRlZCBhcyByZXNlcnZlZCIpIGdldHMgcmVsZWFzZWQuCj4+Cj4gd2hlbiBh
IGZpcm13YXJlIGJ1ZyBhcHBlYXJzLCB0aGUgcG90ZW50aWFsIHByb2JsZW0gbWF5IGJleW9uZCB0
aGUgc2NvcGUgCj4gb2YgaXRzIHZpc2libGUgaW1wYWN0cyBzbyB0aGF0IGludHJvZHVjaW5nIGEg
d29ya2Fyb3VuZCBpbiBvZmZpY2lhbCAKPiBpbXBsZW1lbnRhdGlvbiBzaG91bGQgYmUgY29uc2lk
ZXJlZCB2ZXJ5IGNhcmVmdWxseS4KCkFncmVlZC4gIEkgdGhpbmsgdGhhdCBpbiB0aGUgUk1SUiBj
YXNlLCBpdCB3b3VsZG4ndCBzdXJwcmlzZSBtZSBpZiB0aGVzZSAKcHJvYmxlbXMgYXJlIGFscmVh
ZHkgb2NjdXJyaW5nLCBhbmQgd2UganVzdCBkaWRuJ3Qga25vdyBhYm91dCBpdCwgc28gSSdkIAps
aWtlIHRvIHRoaW5rIGFib3V0IHNhbmUgd29ya2Fyb3VuZHMuICBJIG9ubHkgbm90aWNlZCBpdCBv
biBhIGtleGVjLiAKTm90IHN1cmUgaG93IG1hbnkgcGVvcGxlIHdpdGggc2ltaWxhcmx5LWJyb2tl
biBmaXJtd2FyZSBhcmUga2V4ZWNpbmcgCmtlcm5lbHMgb24gbGludXMvbWFzdGVyIGtlcm5lbHMg
eWV0LgoKU3BlY2lmaWNhbGx5LCBteSBmaXJtd2FyZSByZXBvcnRzIGFuIFJNUlIgd2l0aCBzdGFy
dCA9PSAwIGFuZCBlbmQgPT0gMCAKKGVuZCBzaG91bGQgYmUgcGFnZS1hbGlnbmVkLW1pbnVzLW9u
ZSkuICBUaGUgb25seSByZWFzb24gY29tbWl0IApmMDM2YzdmYTBhYjYgZGlkbid0IGNhdGNoIGl0
IG9uIGEgZnVsbCByZWJvb3QgaXMgdGhhdCB0cmltX2Jpb3NfcmFuZ2UoKSAKcmVzZXJ2ZWQgdGhl
IGZpcnN0IHBhZ2UsIGFzc3VtaW5nIHRoYXQgdGhlIEJJT1MgbWVhbnQgdG8gcmVzZXJ2ZSBpdCBi
dXQgCmp1c3QgZGlkbid0IHRlbGwgdXMgaW4gdGhlIGU4MjAgbWFwLiAgTXkgZmlybXdhcmUgZGlk
bid0IG1hcmsgdGhhdCBmaXJzdCAKcGFnZSBFODIwX1JFU0VSVkVELiAgT24gYSBrZXhlYywgdGhl
IHJhbmdlIHRoYXQgZ290IHRyaW1tZWQgd2FzIAoweDEwMC0weGZmZiBpbnN0ZWFkIG9mIDB4MDAw
LTB4ZmZmLiAgSW4gYm90aCBjYXNlcywgdGhlIGtlcm5lbCB3b24ndCB1c2UgCnRoZSByZWdpb24g
dGhlIGJyb2tlbiBSTVJSIHBvaW50cyB0bywgYnV0IGluIHRoZSBrZXhlYyBjYXNlLCBpdCB3YXNu
J3QgCkU4MjBfUkVTRVJWRUQsIHNvIHRoZSBuZXcgY29tbWl0IGFib3J0ZWQgdGhlIERNQVIgc2V0
dXAuCgo+IElmIHRoZSB3b3JrYXJvdW5kIGlzIHJlYWxseSBuZWVkZWQgYXQgdGhpcyBwb2ludCwg
SSB3b3VsZCByZWNvbW1lbmQgCj4gYWRkaW5nIGEgV0FSTl9UQUlOVCB3aXRoIFRBSU5UX0ZJUk1X
QVJFX1dPUktBUk9VTkQsIHRvIHRlbGwgdGhlIAo+IHdvcmthcm91bmQgaXMgaW4gdGhlIHBsYWNl
LgoKU291bmRzIGdvb2QuICBJIGNhbiByZXdvcmsgdGhlIHBhdGNoc2V0IHNvIHRoYXQgd2hlbmV2
ZXIgSSBza2lwIGFuIFJNUlIgCmVudHJ5IG9yIHdoYXRub3QsIEknbGwgcHV0IGluIGEgV0FSTl9U
QUlOVC4gIEkgc2VlIGEgZmV3IG90aGVyIGV4YW1wbGVzIAppbiBkbWFyLmMgdG8gd29yayBmcm9t
LgoKSWYgYW55IG9mIHRoZSB0aHJlZSBjaGFuZ2VzIGFyZSB0b28gYWdncmVzc2l2ZSwgSSdtIE9L
IHdpdGggeW91IGFsbCAKdGFraW5nIGp1c3Qgb25lIG9mIHRoZW0uICBJJ2QgbGlrZSB0byBiZSBh
YmxlIHRvIGtleGVjIHdpdGggdGhlIG5ldyAKa2VybmVsLiAgSSdtIGxpa2VseSBub3QgdGhlIG9u
bHkgb25lIHdpdGggYmFkIGZpcm13YXJlLCBhbmQgYW55IGJ1ZyB0aGF0IApvbmx5IHNob3dzIHVw
IG9uIGEga2V4ZWMgb2Z0ZW4gYSBwYWluIHRvIGRldGVjdC4KClRoYW5rcywKCkJhcnJldAoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGlu
ZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
