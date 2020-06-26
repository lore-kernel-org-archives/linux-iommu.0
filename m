Return-Path: <SRS0=GrUw=AH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3320EC433DF
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 12:30:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01C44204EA
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 12:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="b5WY5hmn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01C44204EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B95E320117;
	Fri, 26 Jun 2020 12:30:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vjpxvLa0kfsU; Fri, 26 Jun 2020 12:30:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 29ACF204B6;
	Fri, 26 Jun 2020 12:30:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 112FEC0863;
	Fri, 26 Jun 2020 12:30:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75374C016F
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 12:30:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6946E87E9E
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 12:30:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wPhd4MwY6iN6 for <iommu@lists.linux-foundation.org>;
 Fri, 26 Jun 2020 12:30:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com
 [209.85.219.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 43B8287E5F
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 12:30:24 +0000 (UTC)
Received: by mail-qv1-f68.google.com with SMTP id m9so4384436qvx.5
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 05:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=content-transfer-encoding:from:mime-version:subject:date:message-id
 :references:cc:in-reply-to:to;
 bh=S0udzLIXNsb1pKVpquCqjhEjdkaBQJ9k9wIcZym0NIY=;
 b=b5WY5hmnBkDE3y2XYtD/XNpCJ64rCr6ywqQ0bplXtpcbBuu1NpQ0Trxyg8UIEeb6qP
 lUYQmRe+baCZRuv8dJ6XPXMBDpzyvPsqfIlGPyC0J7bH+oebIxSOOH/+rHSLPlB3NGlT
 racuLirYwlt4f5Ryxila0pI30g1Bp6xBsAPqJFqYsKmpM3trQt68IZATbehlz607I+dv
 IoIfHdROxwuq/JBedny89gA/ttl9oSi3f9BTG92t88Ymt/1dwKgLKoB5jf3GTWYE5g7s
 S88ARLcPPw0prcPSqlkbkn8s/m9gj383nzG5OyxtU7w7RdgRXU3OoTO8x1VxfoKjoBsD
 oMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=S0udzLIXNsb1pKVpquCqjhEjdkaBQJ9k9wIcZym0NIY=;
 b=O+46lAq49kk/TB/BCPzH/XK6BngEKNkPQCEZzq5L0h9kUCOQjGKTFeKmhJ560wAH6I
 vpfG6bI41iT5F0hGZuKOQJLHj4Otx4QYh3YrLMq/JvWNTBT3Fq1kJbt7QUp0bwT/1EJj
 mLZB4fkvcd5bX+5jBJB0XN4e0DvWZ82vATnzSvsJuE34HqT9zIpSEQDrNONumZkPDBxG
 OBC9cfouE8WZchdE3GtyROzCfVxyAMMNGcdBZ7muBVh4zffwu5R7BCm2DdYae409RgKD
 v42No8CwKSnvoJSsKbSPiWs71gWe0HEI6AOS5BK8v7kyo45oq2hs5cW9i2XEHzYoFuqw
 aTSQ==
X-Gm-Message-State: AOAM531xpfoGSMHnSU6JGwelYKXtgDCZYOd5SFUTpm8bgSvGZcoktSPs
 UXF6vQUnkdPxX8VD8iusGW1eYg==
X-Google-Smtp-Source: ABdhPJzluXudaRNW5mQfKaLZBkHXd8Fo5a1PihnTT29QwORZ08On9+BQlkXaNj4UJJUksc7io6PA9w==
X-Received: by 2002:ad4:5a46:: with SMTP id ej6mr2895574qvb.52.1593174623247; 
 Fri, 26 Jun 2020 05:30:23 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net.
 [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id l3sm8723087qtn.69.2020.06.26.05.30.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2020 05:30:22 -0700 (PDT)
From: Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 0/2] iommu/amd: Don't use atomic64_t for domain->pt_root
Date: Fri, 26 Jun 2020 08:30:21 -0400
Message-Id: <63D91069-6A2E-4C05-8409-76A56D1E0FCA@lca.pw>
References: <20200626080547.24865-1-joro@8bytes.org>
In-Reply-To: <20200626080547.24865-1-joro@8bytes.org>
To: Joerg Roedel <joro@8bytes.org>
X-Mailer: iPhone Mail (17F80)
Cc: iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Cgo+IE9uIEp1biAyNiwgMjAyMCwgYXQgNDowNSBBTSwgSm9lcmcgUm9lZGVsIDxqb3JvQDhieXRl
cy5vcmc+IHdyb3RlOgo+IAo+IGEgcHJldmlvdXMgZGlzY3Vzc2lvbiBwb2ludGVkIG91dCB0aGF0
IHVzaW5nIGF0b21pYzY0X3QgZm9yIHRoYXQKPiBwdXJwb3NlIGlzIGEgYml0IG9mIG92ZXJraWxs
LiBUaGlzIHBhdGNoLXNldCByZXBsYWNlcyBpdCB3aXRoIHVuc2lnbmVkCj4gbG9uZyBhbmQgaW50
cm9kdWNlcyBzb21lIGhlbHBlcnMgZmlyc3QgdG8gbWFrZSB0aGUgY2hhbmdlIG1vcmUgZWFzeS4K
CkJUVywgZnJvbSB0aGUgcHJldmlvdXMgZGlzY3Vzc2lvbiwgTGludXMgbWVudGlvbmVkLAogCuKA
nApUaGUgdGhpbmcgaXMsIHRoZSA2NC1iaXQgYXRvbWljIHJlYWRzL3dyaXRlcyBhcmUgdmVyeSBl
eHBlbnNpdmUgb24KMzItYml0IHg4Ni4gSWYgaXQgd2FzIGp1c3QgYSBuYXRpdmUgcG9pbnRlciwg
aXQgd291bGQgYmUgbXVjaCBjaGVhcGVyCnRoYW4gYW4gImF0b21pYzY0X3QiLgrigJwKCkhvd2V2
ZXIsIGhlcmUgd2UgaGF2ZSBBTURfSU9NTVUgZGVwZW5kIG9uIHg4Nl82NCwgc28gSSBhbSB3b25k
ZXJpbmcgaWYgaXQgbWFrZXMgYW55IHNlbnNlIHRvIHJ1biB0aGlzIGNvZGUgb24gMzItYml0IHg4
NiBhdCBhbGw/Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
