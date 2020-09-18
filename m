Return-Path: <SRS0=+KRR=C3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD51C43463
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 15:23:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F04AF20717
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 15:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="AKWoUKld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F04AF20717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B01D82E21C;
	Fri, 18 Sep 2020 15:23:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hiPsnn25FSYm; Fri, 18 Sep 2020 15:23:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id AED6B2E217;
	Fri, 18 Sep 2020 15:23:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91135C0859;
	Fri, 18 Sep 2020 15:23:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3318C0051
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 15:23:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C28AC873AA
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 15:23:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8t_mjq7m9_Gv for <iommu@lists.linux-foundation.org>;
 Fri, 18 Sep 2020 15:23:14 +0000 (UTC)
X-Greylist: delayed 00:05:20 by SQLgrey-1.7.6
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 59F3D8739F
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 15:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1600442592;
 bh=6Dqe4qnGoW/eGQKkDHFS4dwGn8CgS5CwAggEChH/0hA=;
 h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
 b=AKWoUKldFe0zegeZpFOCjev8phqanpyYPCnbpBBow/7c/ad+CY71YlKTecE0p1qkn
 pfxEba4CnP8tSuGnVHZSizXfBfg90oJ3V9i5xxWANifYXnXJY//USpHlz3xonKx3QG
 P1OvXiuuNe/w7kGYnN1pgdZ8nWKmMSqgoU++5eQ8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.155.216]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mdf8F-1ksct43AA5-00ZEOC; Fri, 18
 Sep 2020 17:17:19 +0200
To: Yu Kuai <yukuai3@huawei.com>, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] iommu/qcom: add missing put_device() call in
 qcom_iommu_of_xlate()
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c68bed0d-3ddc-c8d4-2345-9edff917522b@web.de>
Date: Fri, 18 Sep 2020 17:17:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:IHAlxB32X1qDCFUDh9lWsBw21g/6j3UZ2DNx5xY0HeHelk8Af5M
 5w4ryRRS8sm/HIXuSiGTjYO4wX/cSKxpSzZrS334HnRDCG65FSGXOjsgKG5MdEfrVzQj+fj
 cwHlLRsiKQgQFh8baqW5xx4SuexZvJVErXLna65YSUtTybhJsYqhxxfLjmGHoC8uBA3O3bQ
 kgQAQ8FEwZvtDCYJLzhqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LhO/O+F7qHc=:/q/POM4y2D6/dVaK/jkqwh
 he4eEfPydMjfu3Up7U2W2QZ10JJlgaZcz2k26AgXnmc6GG+DZ/0DCX6lI/YIrjcMVggGdrcid
 IpDY1TdT0OmCaK9xkG09UtrZMHOy4FdaF3JKAWE4fi3dU2NRVbQeT6hdlk5SyjpDym3OBSoLr
 aiZsBSkJP6pF5HjMhrsq9DelY9QKR9MVDZi6+ef6vQO0BnTn0p08FkRRiow7Wr7iHK6cwNLeC
 48tGAhEx7bxPjkDB8AuD+TjF5P/fUjAFdSz7y6MvQ1W+zyTibBUqgAfoD63iqEAuHMy9qpMLo
 0fiAQnD/ahRD/5hxinoaMgtmKvZ6vx6lTS2YCMkIqId5KtdEx0Z74tNUfGUDpxTsgsHiFL60T
 62TEvc5GYATAYgpN3jdPJgNvgBxgGkJsFd8VEYGeG9OVqoQGnewBq5mu9pomCoEHtXkG0DB64
 eJAVO6l8L3QFJmngLFb0rND1JYS3UmoidOcojLxStPUQKiHYw1hhH6kj9DBsucOYNeLw8PXHA
 go4LsmmPy3LoqPuj6Box1DwBmcjDL0Yypi1fFGmjzk0GDp+WBFcgcnSTq3yulAYzf4qTzlBKT
 9fxX7JYQHj/k8BJjTQVAdvc19EaLZBBsSchLtcBDCac2G1Hr9KFPMSTV/H5EUj1he2qZfDS/9
 uqwPA3qCLf/N1OgWs6YYEA7UbOLaZXSoFODwBXaHQTqdKo4oSV8yG1876Q+eV+phCWY7GaXzw
 LMqY9gLILzITiiYfShTdsR9Q8HNbZPpqzxJj5jbPDFEDe0EpEpqBABZOxhvDMKE5ppJ+iHeMm
 Ddw0qsufCBNdH3JKtsLatJlD/lUlm2WqUdZ/0TFyCvN+4G7AwZVi3T2Sl47VI19yfeUEhT6rP
 OlZBK6bj6UFN54P//uVG3MgG3WnLJiMN/P34wHK86HrkdVat/aecMH+1DrorK1wuzKfzj/jzC
 nNcrb2bqHUTI50WzkTEnh3c+rp9//2E5M3D6XCZ7ajF6CSHWEjWh17+W+l6Z+H/EJd7/NlHxr
 ok00RGi2jOvFbjfWm3XHeckLpN13QlYjcfad+k4Zj3X3/E/JPKIV8bAmp7XmSu9gmNvcPIRe7
 lZACB7o+ENq9DvtusPjvCxoB4N+wQKzQrh/Fi6Pz107p4eqhqb4tVET+haetRXq/X/Sfec1sT
 YgllDmkXydZYt00txNENs1RfLdsi53h3K1nX6nE00vMgcqQYx69HlaCyKSvVbIfsPyzPZa3EG
 xOn+TN0gx7oP68q9KFvxnEOfN/GjILEiN8AeYlQ==
Cc: Yi Zhang <yi.zhang@huawei.com>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>
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

4oCmCj4gKysrIGIvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUvcWNvbV9pb21tdS5jCuKApgo+
IEBAIC01OTUsNiArNTk3LDcgQEAgc3RhdGljIGludCBxY29tX2lvbW11X29mX3hsYXRlKHN0cnVj
dCBkZXZpY2UgKmRldiwgc3RydWN0IG9mX3BoYW5kbGVfYXJncyAqYXJncykKPiAgCQkgKiBiYW5r
cyBhcmUgb2ssIGJ1dCBtdWx0aXBsZSBkZXZpY2VzIGFyZSBub3Q6Cj4gIAkJICovCj4gIAkJaWYg
KFdBUk5fT04ocWNvbV9pb21tdSAhPSBkZXZfaW9tbXVfcHJpdl9nZXQoZGV2KSkpCj4gKwkJCXB1
dF9kZXZpY2UoJmlvbW11X3BkZXYtPmRldik7Cj4gIAkJCXJldHVybiAtRUlOVkFMOwo+ICAJfQoK
KiBXb3VsZCB0aGVyZSBiZSBhIG5lZWQgdG8gdXNlIGN1cmx5IGJyYWNrZXRzIGZvciBzdWNoIGFu
IGlmIGJyYW5jaD8KCiogSSBzdWdnZXN0IHRvIGFkZCBhIGp1bXAgdGFyZ2V0IHNvIHRoYXQgYSBi
aXQgb2YgY29tbW9uIGV4Y2VwdGlvbiBoYW5kbGluZyBjb2RlCiAgY2FuIGJlIGJldHRlciByZXVz
ZWQgZm9yIHRoaXMgZnVuY3Rpb24gaW1wbGVtZW50YXRpb24uCgpSZWdhcmRzLApNYXJrdXMKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGlu
ZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
