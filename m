Return-Path: <SRS0=tixU=6C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0EAC38A2F
	for <iommu@archiver.kernel.org>; Sat, 18 Apr 2020 13:08:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4940F2051A
	for <iommu@archiver.kernel.org>; Sat, 18 Apr 2020 13:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="sRR3q8ll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4940F2051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0E2BE88246;
	Sat, 18 Apr 2020 13:08:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t2pWMVQj75Ay; Sat, 18 Apr 2020 13:08:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4B5C28823A;
	Sat, 18 Apr 2020 13:08:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 291D6C1D7E;
	Sat, 18 Apr 2020 13:08:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A28EC0172
 for <iommu@lists.linux-foundation.org>; Sat, 18 Apr 2020 13:08:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1904186914
 for <iommu@lists.linux-foundation.org>; Sat, 18 Apr 2020 13:08:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Sn795_5Ni4kW for <iommu@lists.linux-foundation.org>;
 Sat, 18 Apr 2020 13:08:51 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com
 [209.85.160.194])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4054786088
 for <iommu@lists.linux-foundation.org>; Sat, 18 Apr 2020 13:08:51 +0000 (UTC)
Received: by mail-qt1-f194.google.com with SMTP id f13so4475955qti.5
 for <iommu@lists.linux-foundation.org>; Sat, 18 Apr 2020 06:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=content-transfer-encoding:from:mime-version:subject:date:message-id
 :references:cc:in-reply-to:to;
 bh=yTjNxrSOgcyuq+6eZ9Gw7+GF3CnNW6GYqtu3CqLSbFk=;
 b=sRR3q8llUmWoiuLGukaAvAd8ViBMaW0dyX5Og+bGaC42zmPYb/ZW6zWdIgPScBt0ds
 zpLlsfOzDRrviKxJxEAdf9cG1QnTXxZ4Kj0eX41qVbEg0T42+q2aD+6jXoeOwSjlvGMR
 jwENh72TZLCM9mRN0kqJWbQUn04Xh2Sdb0QdGzTUx98aX4efZ5NwsQdVdXRq8XQhz+Un
 7SXQHQq+ooXENYwFRJsQ2vysSgqrqhGZ3dZryMSmgZ2sopKC9KhQ35Y/77EmCFYbUmDQ
 r+WT0AqwRkaBkUfpwO697ie2Q3ILmUT9vpLhXE6UgUYaKnYNfx4xQT7dIXdYTIIHbxqK
 FNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=yTjNxrSOgcyuq+6eZ9Gw7+GF3CnNW6GYqtu3CqLSbFk=;
 b=RWP87dTIs60lRX7o6q5CDif0ryBUAWBkp3HbLqT2ObyCcjVs8rrrdYBeLfidspD+QB
 Qdf7WtF3B6S4wup2Gi/QCbIz3f/o7uIA8djms8wEuAEA18OP7QxKWfm9qNRTc/4d7n/M
 LrZcxda++euS4YV1DRdnJ/o7A8uBMuQ9Kp40QdHpsqFfvs+vsxufV67leLPvo2BIBIa2
 RpoSBcVtN8Y70Q6OwdWewXGkggMP0v6nTOg/kgZbYdeY7l7ZqK5OcnA0Y0ObpbbfOfYq
 r19kh6JE1p3oxC9ON2u/Y7oUyiIY6G9mPo64ZkXdH/iClsnd6JEwEDqzZa1PuMu2aDL/
 yi/A==
X-Gm-Message-State: AGi0Pub4lbSdv8YLnYbqBgSnvSFUvYdlN23U6GMm4C+xAXZ2+bd7uhTW
 CVgTU3hJ5UcrOi2sDj9aNxFLssgB9nf0Dw==
X-Google-Smtp-Source: APiQypIspR2qhGzlW2OI6PuNYwZwwXUdXzmx1HzknFwwaTPdiVUaZkDU0LHydRgegDMwl+ENDrnfYg==
X-Received: by 2002:a37:3d4:: with SMTP id 203mr7653513qkd.306.1587214896901; 
 Sat, 18 Apr 2020 06:01:36 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net.
 [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id b126sm18827100qkc.119.2020.04.18.06.01.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Apr 2020 06:01:36 -0700 (PDT)
From: Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH] iommu/amd: fix a race in fetch_pte()
Date: Sat, 18 Apr 2020 09:01:35 -0400
Message-Id: <57CBF6B2-4745-4E36-9AA5-7E0876E3DA8F@lca.pw>
References: <20200418121022.GA6113@8bytes.org>
In-Reply-To: <20200418121022.GA6113@8bytes.org>
To: Joerg Roedel <joro@8bytes.org>
X-Mailer: iPhone Mail (17D50)
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

Cgo+IE9uIEFwciAxOCwgMjAyMCwgYXQgODoxMCBBTSwgSm9lcmcgUm9lZGVsIDxqb3JvQDhieXRl
cy5vcmc+IHdyb3RlOgo+IAo+IFllcywgeW91ciBwYXRjaCBzdGlsbCBsb29rcyByYWN5LiBZb3Ug
bmVlZCB0byBhdG9taWNhbGx5IHJlYWQKPiBkb21haW4tPnB0X3Jvb3QgdG8gYSBzdGFjayB2YXJp
YWJsZSBhbmQgZGVyaXZlIHRoZSBwdF9yb290IHBvaW50ZXIgYW5kCj4gdGhlIG1vZGUgZnJvbSB0
aGF0IHZhcmlhYmxlIGluc3RlYWQgb2YgZG9tYWluLT5wdF9yb290IGRpcmVjdGx5LiBJZiB5b3UK
PiByZWFkIHRoZSBkb21haW4tPnB0X3Jvb3QgdHdpY2UgdGhlcmUgY291bGQgc3RpbGwgYmUgYW4g
dXBkYXRlIGJldHdlZW4KPiB0aGUgdHdvIHJlYWRzLgo+IFByb2JhYmx5IHRoZSBsb2NrIGluIGlu
Y3JlYXNlX2FkZHJlc3Nfc3BhY2UoKSBjYW4gYWxzbyBiZSBhdm9pZGVkIGlmCj4gcHRfcm9vdCBp
cyB1cGRhdGVkIHVzaW5nIGNtcHhjaGcoKT8KCkhhcmQgdG8gdGVsbCB3aXRob3V0IHRlc3Rpbmcg
ZnVydGhlci4gSeKAmWxsIGxlYXZlIHRoYXQgb3B0aW1pemF0aW9uIGluIHRoZSBmdXR1cmUsIGFu
ZCBmb2N1cyBvbiBmaXhpbmcgdGhvc2UgcmFjZXMgZmlyc3QuCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby9pb21tdQ==
