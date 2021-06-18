Return-Path: <SRS0=sMz+=LM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BE4C48BDF
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 07:42:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 784886120A
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 07:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 784886120A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 334114022D;
	Fri, 18 Jun 2021 07:42:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BlFFWZHhjM8I; Fri, 18 Jun 2021 07:42:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0E1DC401F2;
	Fri, 18 Jun 2021 07:42:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3D1FC000D;
	Fri, 18 Jun 2021 07:42:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09CE0C000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 07:42:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D6438605F6
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 07:42:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QYaDbvBKGFa8 for <iommu@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 07:42:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B26BC605F4
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 07:42:08 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id w21so7334637edv.3
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 00:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=v52H1DGhwEBbToMjprp5OIYmxTHaBZzbygv2ty6zyTA=;
 b=dDj24zSRZV8EKE1Zp5M2dp1HZFeICLy7YE63TfpDkIVzJZ3FoLPsFddFh34nqv4QP2
 PFD9Ui270iQuK0zRwTOO4pOnL7P8YOPTpL3GAjDMCrZQsJvqZAHVhoMjz/TTdRgt3wgG
 A0PCgJpU8RqU0ZEc0RK2TE6Ehk3W87VKdkB+QlxLecfy5oBkUOr67zlULx0LW7V7VMZ2
 RHk4FDYAuvEiO5g7Bn+hBd9COd/bHu1i8c0qYLGm3ZXlo761c0LOSFBaXroaWNm3zXvL
 M5/5OVmWLndb68QIRJdLdgw67BpWLd7NhXDYappZvvUk+wpD1T5NQh+6Ok5rHTWGUYST
 qvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=v52H1DGhwEBbToMjprp5OIYmxTHaBZzbygv2ty6zyTA=;
 b=tI23ug610DuT6sMOMWsoo1EnglD13PEJ2MC82e0rY6RSQXKWfV6PAH3m4Eiby3n+i4
 VjmJDdJdsVPS9hBSRZKr+a212xtqfFMrBln2UmkjzhF7TR9KbCt4GnvV3OmGp6YjDZMG
 sg4Pj7scu3ynTS3GBNx1oJa+2KNgVEGDA183B5DQmqg1TIz5pmqnb7JXd08q+Pha9A4T
 HwdeepsDkPcxiJS3L9sTj6mRllgDgKYe3tRSpHmOmdkV5v6NLwmHEgAg5NTMiLOg9/7Z
 danX5g5JLvdWTlfRyGNQk7LBuzmscKUIJ8556pZE53uaX7s1ZsCAC8MtbqiRiIUnaznN
 S+bw==
X-Gm-Message-State: AOAM533pW8kcFXG36IcrnMKpWk6KPDHXI3KCeCHHImGFfeHVZPucW9rT
 fhtFeSH3TE7D2dk6SlHpiAhrUw==
X-Google-Smtp-Source: ABdhPJwIMcxh29slWUpqVvymbEU7IrUGEPStgx5v5WFVtHmmlxhiXwp4hieNxZEXP8fTg0+HhYxHlw==
X-Received: by 2002:a05:6402:b76:: with SMTP id
 cb22mr3227635edb.112.1624002126744; 
 Fri, 18 Jun 2021 00:42:06 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
 by smtp.gmail.com with ESMTPSA id br24sm683484ejb.55.2021.06.18.00.42.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jun 2021 00:42:06 -0700 (PDT)
Date: Fri, 18 Jun 2021 09:41:46 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v4 2/6] ACPI: Move IOMMU setup code out of IORT
Message-ID: <YMxOOq8YIBhRhzQM@myrica>
References: <20210610075130.67517-1-jean-philippe@linaro.org>
 <20210610075130.67517-3-jean-philippe@linaro.org>
 <2c53c9cf-43e6-11c2-6ee3-530ad1f87aec@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2c53c9cf-43e6-11c2-6ee3-530ad1f87aec@redhat.com>
Cc: kevin.tian@intel.com, mst@redhat.com, catalin.marinas@arm.com,
 sudeep.holla@arm.com, rjw@rjwysocki.net, robin.murphy@arm.com,
 virtualization@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, sebastien.boeuf@intel.com,
 guohanjun@huawei.com, will@kernel.org, dwmw2@infradead.org,
 linux-arm-kernel@lists.infradead.org, lenb@kernel.org
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

SGkgRXJpYywKCk9uIFdlZCwgSnVuIDE2LCAyMDIxIGF0IDExOjM1OjEzQU0gKzAyMDAsIEVyaWMg
QXVnZXIgd3JvdGU6Cj4gPiAtY29uc3Qgc3RydWN0IGlvbW11X29wcyAqaW9ydF9pb21tdV9jb25m
aWd1cmVfaWQoc3RydWN0IGRldmljZSAqZGV2LAo+ID4gLQkJCQkJCWNvbnN0IHUzMiAqaWRfaW4p
Cj4gPiAraW50IGlvcnRfaW9tbXVfY29uZmlndXJlX2lkKHN0cnVjdCBkZXZpY2UgKmRldiwgY29u
c3QgdTMyICppZF9pbikKPiA+ICB7Cj4gPiAgCXN0cnVjdCBhY3BpX2lvcnRfbm9kZSAqbm9kZTsK
PiA+IC0JY29uc3Qgc3RydWN0IGlvbW11X29wcyAqb3BzOwo+ID4gKwljb25zdCBzdHJ1Y3QgaW9t
bXVfb3BzICpvcHMgPSBOVUxMOwoKT29wcywgSSBuZWVkIHRvIHJlbW92ZSB0aGlzIChhbmQgYWRk
IC1XZXJyb3IgdG8gbXkgdGVzdHMuKQoKCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBpb21tdV9v
cHMgKmFjcGlfaW9tbXVfY29uZmlndXJlX2lkKHN0cnVjdCBkZXZpY2UgKmRldiwKPiA+ICsJCQkJ
CQkgICAgICAgY29uc3QgdTMyICppZF9pbikKPiA+ICt7Cj4gPiArCWludCBlcnI7Cj4gPiArCWNv
bnN0IHN0cnVjdCBpb21tdV9vcHMgKm9wczsKPiA+ICsKPiA+ICsJLyoKPiA+ICsJICogSWYgd2Ug
YWxyZWFkeSB0cmFuc2xhdGVkIHRoZSBmd3NwZWMgdGhlcmUgaXMgbm90aGluZyBsZWZ0IHRvIGRv
LAo+ID4gKwkgKiByZXR1cm4gdGhlIGlvbW11X29wcy4KPiA+ICsJICovCj4gPiArCW9wcyA9IGFj
cGlfaW9tbXVfZndzcGVjX29wcyhkZXYpOwo+ID4gKwlpZiAob3BzKQo+ID4gKwkJcmV0dXJuIG9w
czsKPiA+ICsKPiA+ICsJZXJyID0gaW9ydF9pb21tdV9jb25maWd1cmVfaWQoZGV2LCBpZF9pbik7
Cj4gPiArCj4gPiArCS8qCj4gPiArCSAqIElmIHdlIGhhdmUgcmVhc29uIHRvIGJlbGlldmUgdGhl
IElPTU1VIGRyaXZlciBtaXNzZWQgdGhlIGluaXRpYWwKPiA+ICsJICogYWRkX2RldmljZSBjYWxs
YmFjayBmb3IgZGV2LCByZXBsYXkgaXQgdG8gZ2V0IHRoaW5ncyBpbiBvcmRlci4KPiA+ICsJICov
Cj4gPiArCWlmICghZXJyICYmIGRldi0+YnVzICYmICFkZXZpY2VfaW9tbXVfbWFwcGVkKGRldikp
Cj4gPiArCQllcnIgPSBpb21tdV9wcm9iZV9kZXZpY2UoZGV2KTsKPiBQcmV2aW91c2x5IHdlIGhh
ZDoKPiDCoMKgwqAgaWYgKCFlcnIpIHsKPiDCoMKgwqAgwqDCoMKgIG9wcyA9IGlvcnRfZndzcGVj
X2lvbW11X29wcyhkZXYpOwo+IMKgwqDCoCDCoMKgwqAgZXJyID0gaW9ydF9hZGRfZGV2aWNlX3Jl
cGxheShkZXYpOwo+IMKgwqDCoCB9Cj4gCj4gUGxlYXNlIGNhbiB5b3UgZXhwbGFpbiB0aGUgdHJh
bnNmb3JtPyBJIHNlZSB0aGUKPiAKPiBhY3BpX2lvbW11X2Z3c3BlY19vcHMgY2FsbCBiZWxvdyBi
dXQgaXMgaXQgbm90IHN0cmFpZ2h0Zm9yd2FyZCB0byBtZS4KCkkgZmlndXJlZCB0aGF0IGlvcnRf
YWRkX2RldmljZV9yZXBsYXkoKSBpcyBvbmx5IHVzZWQgb25jZSBhbmQgaXMKc3VmZmljaWVudGx5
IHNpbXBsZSB0byBiZSBpbmxpbmVkIG1hbnVhbGx5IChzYXZpbmcgMTAgbGluZXMpLiBUaGVuIEkK
cmVwbGFjZWQgdGhlIG9wcyBhc3NpZ25tZW50IHdpdGggcmV0dXJucywgd2hpY2ggc2F2ZXMgYW5v
dGhlciBsaW5lIGFuZCBtYXkKYmUgc2xpZ2h0bHkgY2xlYXJlcj8gIEkgZ3Vlc3MgaXQncyBtb3N0
bHkgYSBtYXR0ZXIgb2YgdGFzdGUsIHRoZSBiZWhhdmlvcgpzaG91bGQgYmUgZXhhY3RseSB0aGUg
c2FtZS4KCj4gQWxzbyB0aGUgY29tbWVudCBtZW50aW9ucyByZXBsYXkuIFVuc3VyZSBpZiBpdCBp
cyBzdGlsbCBPSy4KClRoZSAicmVwbGF5IiBwYXJ0IGlzLCBidXQgImFkZF9kZXZpY2UiIGlzbid0
IGFjY3VyYXRlIGJlY2F1c2UgaXQgaGFzIHNpbmNlCmJlZW4gcmVwbGFjZWQgYnkgcHJvYmVfZGV2
aWNlLiBJJ2xsIHJlZnJlc2ggdGhlIGNvbW1lbnQuCgpUaGFua3MsCkplYW4KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0Cmlv
bW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
