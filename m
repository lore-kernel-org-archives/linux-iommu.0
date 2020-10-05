Return-Path: <SRS0=BXsX=DM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A4FC4363A
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 09:38:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C35E2078E
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 09:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pgk0M12g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C35E2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 18B27203DB;
	Mon,  5 Oct 2020 09:38:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ToIxZa6ueG0Q; Mon,  5 Oct 2020 09:38:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id BA6F32002A;
	Mon,  5 Oct 2020 09:38:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA9F1C07FF;
	Mon,  5 Oct 2020 09:38:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58C5BC0051
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 09:38:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 46B1B83F66
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 09:38:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cwajhnmJdJWs for <iommu@lists.linux-foundation.org>;
 Mon,  5 Oct 2020 09:38:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com
 [209.85.167.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 44A8183DC2
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 09:38:24 +0000 (UTC)
Received: by mail-lf1-f65.google.com with SMTP id b22so9993321lfs.13
 for <iommu@lists.linux-foundation.org>; Mon, 05 Oct 2020 02:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QsaBfZFa2dvXngI+qikBeYVIehcnUn/8wXHfmURCQEA=;
 b=Pgk0M12g2DtRJ1kAa1PGSelgbsxYQlS2lso0eKSxlD4N1cVf5e20H+glqExrxAqrUI
 9Nf6vAtoA4YEhEfnQnopMNWK72mArJ5RrpqbeYqVmC6P3cX5k744sYEV/PS5FqaLm7OA
 +wiU38Q3ioB+Hm6EiKqGBN9sGquqVgdGhu4XY7IEDQE6DZnfkat7Pt7hrcf+7xAJet9n
 MlATvl5Cj2DSe+EVz0BzED9ODORqqYSsjRWGTATd2sLePQt+qYY4A14HXi1mX07cXfrL
 umwgYoAWFk7Nm+x7gWS7G8Z2sS/3sxzTuNxWDEu1qQNknleKhir7JYA2xNJNWoXbxVID
 uCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QsaBfZFa2dvXngI+qikBeYVIehcnUn/8wXHfmURCQEA=;
 b=WUwUAfjMUFzuVL8Bl+pny8DWOxI0Nghz9u/ZjBAXgsAmNT7lzsFnda1CZkHkXxZ3M3
 pzAifeKxuwctRUZHWfWo0a8GN2h1yxjchzYOhWnKWPI7uznatchMjiRPkVyEKLNJ2To7
 PlSrX8FkbdZOMw+8M95fc/OjnIv9VBbnxeZ21KeAorMJyWAGJLuEOxtYsgqFJyHdYsaf
 DJEvWKndWxOhVjKJcrJ0KO5R7+NzNIJk16hhV1NECzxEHzyl7DsMpCslwlS1uPq3QbdD
 WN8puMu8NVYsH7aLu5KwDn5kw2bWLlyGHnItdnN2sS5TfHrjvoaCEtqTstGX3MVW6wtl
 9yNg==
X-Gm-Message-State: AOAM533P75ViS/YEDPNmfpbPT+XOjqlRs0ULtdp1Ah5eM4RmyFlPGQes
 2JMxigxaPYScoG2flvxords=
X-Google-Smtp-Source: ABdhPJw9nOUB2K6tl/E249a5ebviDASlcj91s9oVh68i6PWqDc7YsQuI0RDXL8DV8yyicewQ2Gaj0w==
X-Received: by 2002:ac2:4c88:: with SMTP id d8mr5071687lfl.428.1601890702324; 
 Mon, 05 Oct 2020 02:38:22 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.91.252])
 by smtp.googlemail.com with ESMTPSA id n3sm2627012lfq.274.2020.10.05.02.38.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2020 02:38:21 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
To: Thierry Reding <thierry.reding@gmail.com>
References: <20200930084258.25493-1-nicoleotsuka@gmail.com>
 <20200930084258.25493-3-nicoleotsuka@gmail.com>
 <20200930153131.GB3833404@ulmo>
 <ece615ad-8d6b-96ae-d8b4-9667aef17281@gmail.com>
 <20200930160626.GD3833404@ulmo>
 <f11d7d8a-8ce6-a53c-6219-ceec05432002@gmail.com>
 <20200930164707.GB3852280@ulmo>
 <35115ac1-fb25-7226-7b50-61193669e696@gmail.com>
 <20201001075811.GA3919720@ulmo>
 <4dbf5bcb-76af-53c5-31cf-880debbcebf3@gmail.com>
 <20201005091610.GC425362@ulmo>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1adede6e-ecbd-eea4-bd40-4969cd8719cc@gmail.com>
Date: Mon, 5 Oct 2020 12:38:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201005091610.GC425362@ulmo>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 krzk@kernel.org, jonathanh@nvidia.com, linux-tegra@vger.kernel.org
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

MDUuMTAuMjAyMCAxMjoxNiwgVGhpZXJyeSBSZWRpbmcg0L/QuNGI0LXRgjoKLi4uCj4+IEkgdGhp
bmsgeW91IG1lYW50IHJlZ21hcCBpbiByZWdhcmRzIHRvIHByb3RlY3RpbmcgSU8gYWNjZXNzZXMs
IGJ1dCB0aGlzCj4+IGlzIG5vdCB3aGF0IHJlZ21hcCBpcyBhYm91dCBpZiBJTyBhY2Nlc3NlcyBh
cmUgYXRvbWljIGJ5IG5hdHVyZS4KPiAKPiBUaGVuIHdoeSBpcyB0aGVyZSByZWdtYXAtbW1pbz8K
ClRvIHByb3RlY3QgcHJvZ3JhbW1pbmcgc2VxdWVuY2VzIGZvciBleGFtcGxlLCBhY3R1YWxseSB0
aGF0J3MgdGhlIG9ubHkKcmVhbCB1c2UtY2FzZSBJIHNhdyBpbiBrZXJuZWwgZHJpdmVycyBvbmNl
LiBJbiBvdXIgY2FzZSB0aGVyZSBhcmUgbm8Kc2VxdWVuY2VzIHRoYXQgcmVxdWlyZSBwcm90ZWN0
aW9uLCBhdCBsZWFzdCBJJ20gbm90IGF3YXJlIGFib3V0IHRoYXQuCgo+PiBTZWNvbmRseSwgeW91
J3JlIG1pc3NpbmcgdGhhdCB0ZWdyYTMwLWRldmZyZXEgZHJpdmVyIHdpbGwgYWxzbyBuZWVkIHRv
Cj4+IHBlcmZvcm0gdGhlIE1DIGxvb2t1cCBbM10gYW5kIHRoZW4gZHJpdmVyIHdpbGwgbm8gbG9u
Z2VyIHdvcmsgZm9yIHRoZQo+PiBvbGRlciBEVHMgaWYgcGhhbmRsZSBiZWNvbWVzIG1hbmRhdG9y
eSBiZWNhdXNlIHRoZXNlIERUcyBkbyBub3QgaGF2ZSB0aGUKPj4gTUMgcGhhbmRsZSBpbiB0aGUg
QUNUTU9OIG5vZGUuCj4+Cj4+IFszXQo+PiBodHRwczovL2dpdGh1Yi5jb20vZ3JhdGUtZHJpdmVy
L2xpbnV4L2NvbW1pdC80NDFkMTkyODFmOWIzNDI4YTRkYjFlY2IzYTAyZTFlYzAyYThhZDdmCj4+
Cj4+IFNvIHdlIHdpbGwgbmVlZCB0aGUgZmFsbCBiYWNrIGZvciBUMzAvMTI0IGFzIHdlbGwuCj4g
Cj4gTm8sIHdlIGRvbid0IG5lZWQgdGhlIGZhbGxiYWNrIGJlY2F1c2UgdGhpcyBpcyBuZXcgZnVu
Y3Rpb25hbGl0eSB3aGljaAo+IGNhbiBhbmQgc2hvdWxkIGJlIGdhdGVkIG9uIHRoZSBleGlzdGVu
Y2Ugb2YgdGhlIG5ldyBwaGFuZGxlLiBJZiB0aGVyZSdzCj4gbm8gcGhhbmRsZSB0aGVuIHdlIGhh
dmUgbm8gY2hvaWNlIGJ1dCB0byB1c2UgdGhlIG9sZCBjb2RlIHRvIGVuc3VyZSBvbGQKPiBiZWhh
dmlvdXIuCgpZb3UganVzdCByZXBlYXRlZCB3aGF0IEkgd2FzIHRyeWluZyB0byBzYXk6KQoKUGVy
aGFwcyBJIHNwZW50IGEgYml0IHRvbyBtdWNoIHRpbWUgdG91Y2hpbmcgdGhhdCBjb2RlIHRvIHRo
ZSBwb2ludCB0aGF0Cmxvc3QgZmVlbGluZyB0aGF0IHRoZXJlIGlzIGEgbmVlZCB0byBjbGFyaWZ5
IGV2ZXJ5dGhpbmcgaW4gZGV0YWlscy4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2lvbW11
