Return-Path: <SRS0=Ithz=52=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06204C2BB86
	for <iommu@archiver.kernel.org>; Fri, 10 Apr 2020 14:31:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6DF2206C1
	for <iommu@archiver.kernel.org>; Fri, 10 Apr 2020 14:31:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6DF2206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B98D422668;
	Fri, 10 Apr 2020 14:31:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i-sM9qRBgaX4; Fri, 10 Apr 2020 14:31:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 4497820768;
	Fri, 10 Apr 2020 14:31:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3253BC1D74;
	Fri, 10 Apr 2020 14:31:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62F3BC0177
 for <iommu@lists.linux-foundation.org>; Fri, 10 Apr 2020 14:31:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 49D032153B
 for <iommu@lists.linux-foundation.org>; Fri, 10 Apr 2020 14:31:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QB8Id3ogSGky for <iommu@lists.linux-foundation.org>;
 Fri, 10 Apr 2020 14:31:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 by silver.osuosl.org (Postfix) with ESMTPS id 8656E20768
 for <iommu@lists.linux-foundation.org>; Fri, 10 Apr 2020 14:31:27 +0000 (UTC)
Received: by mail-oi1-f196.google.com with SMTP id e4so1509518oig.9
 for <iommu@lists.linux-foundation.org>; Fri, 10 Apr 2020 07:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=KmPT0kqXRKOHeqpvmmMJlgFcmC7GqFpKeaTOCrQ8Wtg=;
 b=MVspORT2EKWhlLZhhgkQCBn1P0bQyCTXaB8ofTUZMb+UX52tO0lmJxh1sOlT7wWAj1
 u3TeymKwIvZFHh8otEgEKbjc9GAzpuWeHwetwCEUrjeeS4uduXTfFiw1E7yk50K+DL1H
 AJPoeG11HaJqXbuRk/RQH/14MqK51PpaqSxUrCHGW7Z9wfNXLmXM0w2nwzSHr5vqhlBM
 Pbo+hT4eL32JCBiWQx7gI7+yHS9sKcvUBSCErfOlZRiIMx1/x+ssREBYyUgVNSpzJepn
 odfyxrfcaUm1VuO7nJxzUn+qDF/ArPiYYhkrIjvHHwsMh0wv96QjLC7ffLQZAdbL/Z/b
 +GLw==
X-Gm-Message-State: AGi0PuZiylTzc18wcEfbcPXlPcdXJU1E4OrimKSB4jTkWd9MbCqKLloq
 1nuFBmKskfanISIA4B2MARillj5h2biAGaZ55rU=
X-Google-Smtp-Source: APiQypLr/SVeq2mdMekyoC1fUcboiqejAedCf/X8jFVX6LIVAyFSHTCwj5yNU/ZuaKgxmeqtpp5acBArep16IQooSIY=
X-Received: by 2002:aca:ac09:: with SMTP id v9mr3407739oie.148.1586529086780; 
 Fri, 10 Apr 2020 07:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200410142648.18599-1-geert@linux-m68k.org>
In-Reply-To: <20200410142648.18599-1-geert@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 10 Apr 2020 16:31:15 +0200
Message-ID: <CAMuHMdUghCZuh1zGbi=_9s7pMB34TuawMQ-b6N+f+hDdPOAs0Q@mail.gmail.com>
Subject: Re: [PATCH] netfilter: nft_fwd_netdev: Fix CONFIG_NET_CLS_ACT=n build
To: Joerg Roedel <joro@8bytes.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Linux IOMMU <iommu@lists.linux-foundation.org>,
 linux-mediatek@lists.infradead.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

T24gRnJpLCBBcHIgMTAsIDIwMjAgYXQgNDoyNiBQTSBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0
QGxpbnV4LW02OGsub3JnPiB3cm90ZToKPiBJZiBDT05GSUdfTkVUX0NMU19BQ1Q9bjoKPgo+ICAg
ICBuZXQvbmV0ZmlsdGVyL25mdF9md2RfbmV0ZGV2LmM6IEluIGZ1bmN0aW9uIOKAmG5mdF9md2Rf
bmV0ZGV2X2V2YWzigJk6Cj4gICAgIG5ldC9uZXRmaWx0ZXIvbmZ0X2Z3ZF9uZXRkZXYuYzozMjox
MDogZXJyb3I6IOKAmHN0cnVjdCBza19idWZm4oCZIGhhcyBubyBtZW1iZXIgbmFtZWQg4oCYdGNf
cmVkaXJlY3RlZOKAmQo+ICAgICAgIHBrdC0+c2tiLT50Y19yZWRpcmVjdGVkID0gMTsKPiAgICAg
ICAgICAgICAgIF5+Cj4gICAgIG5ldC9uZXRmaWx0ZXIvbmZ0X2Z3ZF9uZXRkZXYuYzozMzoxMDog
ZXJyb3I6IOKAmHN0cnVjdCBza19idWZm4oCZIGhhcyBubyBtZW1iZXIgbmFtZWQg4oCYdGNfZnJv
bV9pbmdyZXNz4oCZCj4gICAgICAgcGt0LT5za2ItPnRjX2Zyb21faW5ncmVzcyA9IDE7Cj4gICAg
ICAgICAgICAgICBefgo+Cj4gRml4IHRoaXMgYnkgcHJvdGVjdGluZyB0aGlzIGNvZGUgaHVuayB3
aXRoIHRoZSBhcHByb3ByaWF0ZSAjaWZkZWYuCj4KPiBSZXBvcnRlZC1ieTogbm9yZXBseUBlbGxl
cm1hbi5pZC5hdQo+IEZpeGVzOiBiY2ZhYmVlMWFmZDk5NDg0ICgibmV0ZmlsdGVyOiBuZnRfZndk
X25ldGRldjogYWxsb3cgdG8gcmVkaXJlY3QgdG8gaWZiIHZpYSBpbmdyZXNzIikKPiBTaWduZWQt
b2ZmLWJ5OiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPgoKUGxlYXNl
IGlnbm9yZSwgd3JvbmcgcGF0Y2guClNvcnJ5IGZvciB0aGUgbWVzcy4KCkdye29ldGplLGVldGlu
Z31zLAoKICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQKCi0tIApHZWVydCBVeXR0ZXJob2V2
ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02
OGsub3JnCgpJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwg
SSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0CndoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlz
dHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcwpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9t
bXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
