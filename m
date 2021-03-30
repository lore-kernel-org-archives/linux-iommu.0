Return-Path: <SRS0=H7Zn=I4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713A2C433DB
	for <iommu@archiver.kernel.org>; Tue, 30 Mar 2021 10:55:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA6B561985
	for <iommu@archiver.kernel.org>; Tue, 30 Mar 2021 10:55:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA6B561985
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 94D3B83ABD;
	Tue, 30 Mar 2021 10:55:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oBhUf--G7Op4; Tue, 30 Mar 2021 10:55:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7329983A99;
	Tue, 30 Mar 2021 10:55:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4556FC000B;
	Tue, 30 Mar 2021 10:55:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5845C000A
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 10:55:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A55754018C
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 10:55:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vrizgrXuDZZx for <iommu@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 10:55:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 419D340146
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 10:55:02 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id j9so14063036wrx.12
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 03:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=iB/XAjZdFHkZl/iACi0mAuksGld1IxoQmVdZjpahmAg=;
 b=h18Zni9k7+vz60dNcr2w+azzcRRMDIiTc2Jsc3Q6e9IV86Z6WNwsPW/9D+ScSdrh2H
 ADA0P+RMGdrJhw4/N+bfQ+ZS+JkwEkpCvcDe/W0f2ktL1bFJrUuGwhNppxNeg+6KmeuY
 +7RWWd9vKYrGtF7XGOGyGsGOMD6UsxrtKrXyBtElmKejuE+s83ktQ/hKySDFKDuA04UQ
 G6ft51TPdQbIVTp8jC5qK9PSTrijtzj4ooeRfT2MvUp5Aa1MK62Zr3m/AAWB7j04Gd0O
 I9AQQ+Zum0TWLeU2qrOusV7kYB4xasO2lRuMNiumFTo+0e6gxmoiQeSpMc9lXd7cFdcR
 ejbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iB/XAjZdFHkZl/iACi0mAuksGld1IxoQmVdZjpahmAg=;
 b=uVO+aqRwlITseTzA1bUakKsneUW0UY2MSc3vAfOWgBup+5Zs1gWTYes2ruCCRMpE0k
 cAp2h1BHVb4i6bek+Z8R0+9I2GSnuwICSFT0J34SKel/H2bbo+bz2n/Tez9OwCXGsV1R
 tjuKtXSWXT+W9KaLJYOeTpNVTKsLBR46CTxRWgEQvjbltxXOjPXkgIFk+SN6F+oOVQt7
 6nkSrMHoJhtmNqE7HqOxybvLS2qrKz3Zn+ZbvMbJjl1+ODAbuYNuvrjcPqCEH0esyS0B
 mc11S3GyrOtYMwEaSpJMvPguA5EJXjw2NIWnV43FFv7Im2EpD0daCASU+qRhLYJoBc7m
 bldA==
X-Gm-Message-State: AOAM532mgE4sk3CjJo+2f0N2OdTOzAnuh1VESD4z+jhzGKg9ELFIZwi2
 4UlvyFnQncJr937bcKDpl/goiRLJlw/sZw==
X-Google-Smtp-Source: ABdhPJyoMgUB0R71G+u5LV6J9h/4rBrlrFDdtIrME9v4SVN9B0a/TURg9SYK/gIwrnC4jIxfhPqf5A==
X-Received: by 2002:adf:fa4e:: with SMTP id y14mr33660242wrr.170.1617101700227; 
 Tue, 30 Mar 2021 03:55:00 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f1f:bb00:9424:822a:45ae:b5bd?
 (p200300ea8f1fbb009424822a45aeb5bd.dip0.t-ipconnect.de.
 [2003:ea:8f1f:bb00:9424:822a:45ae:b5bd])
 by smtp.googlemail.com with ESMTPSA id y18sm34010488wrq.61.2021.03.30.03.54.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Mar 2021 03:54:59 -0700 (PDT)
Subject: Re: [PATCH] dma-mapping: add unlikely hint to error path in
 dma_mapping_error
To: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>
References: <78757abc-ef8f-9a29-9020-967370eec365@gmail.com>
 <d0bf2035-76d3-aea1-8867-8e6cf523e2fd@arm.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <53eacdf4-5184-217b-81f4-fec9e5eeb400@gmail.com>
Date: Tue, 30 Mar 2021 12:54:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <d0bf2035-76d3-aea1-8867-8e6cf523e2fd@arm.com>
Content-Language: en-US
Cc: "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>
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

T24gMzAuMDMuMjAyMSAxMjoyMSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjEtMDMtMjYg
MjE6MDMsIEhlaW5lciBLYWxsd2VpdCB3cm90ZToKPj4gWmlsbGlvbnMgb2YgZHJpdmVycyB1c2Ug
dGhlIHVubGlrZWx5KCkgaGludCB3aGVuIGNoZWNraW5nIHRoZSByZXN1bHQgb2YKPj4gZG1hX21h
cHBpbmdfZXJyb3IoKS4gVGhpcyBpcyBhbiBpbmxpbmUgZnVuY3Rpb24gYW55d2F5LCBzbyB3ZSBj
YW4gbW92ZQo+PiB0aGUgaGludCBpbnRvIHRoZSBmdW5jdGlvbiBhbmQgcmVtb3ZlIGl0IGZyb20g
ZHJpdmVycyBvdmVyIHRpbWUuCj4gCj4gSSdtIHByZXR0eSBzdXJlIEkgcmV2aWV3ZWQgdGhpcyBs
YXN0IHRpbWUgLSBwbGVhc2UgcmVtZW1iZXIgdG8gcGljayB1cCB0YWdzIGZyb20gcHJldmlvdXMg
dmVyc2lvbnMgd2hlbiByZXBvc3RpbmcuCj4gCgpSaWdodCwgeW91IGRpZC4gTXkgYmFkLgoKCj4g
VGhhbmtzLAo+IFJvYmluLgo+IAo+PiBTaWduZWQtb2ZmLWJ5OiBIZWluZXIgS2FsbHdlaXQgPGhr
YWxsd2VpdDFAZ21haWwuY29tPgo+PiAtLS0KPj4gVGhpcyBpcyBhIHJlc2VuZCBvZiBhIHBhdGNo
IGZyb20gRGVjIDIwMjAgd2hlbiBJIHRyaWVkIHRvIGRvIGl0Cj4+IHRyZWUtd2lkZS4gTm93IHN0
YXJ0IHdpdGggdGhlIGFjdHVhbCBjaGFuZ2UsIGRyaXZlcnMgY2FuIGJlIGNoYW5nZWQKPj4gYWZ0
ZXJ3YXJkcywgbWF5YmUgcGVyIHN1YnN5c3RlbS4KPj4gLS0tCj4+IMKgIGluY2x1ZGUvbGludXgv
ZG1hLW1hcHBpbmcuaCB8IDIgKy0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2RtYS1tYXBw
aW5nLmggYi9pbmNsdWRlL2xpbnV4L2RtYS1tYXBwaW5nLmgKPj4gaW5kZXggZTlkMTliOTc0Li4x
ODNlNzEwM2EgMTAwNjQ0Cj4+IC0tLSBhL2luY2x1ZGUvbGludXgvZG1hLW1hcHBpbmcuaAo+PiAr
KysgYi9pbmNsdWRlL2xpbnV4L2RtYS1tYXBwaW5nLmgKPj4gQEAgLTk1LDcgKzk1LDcgQEAgc3Rh
dGljIGlubGluZSBpbnQgZG1hX21hcHBpbmdfZXJyb3Ioc3RydWN0IGRldmljZSAqZGV2LCBkbWFf
YWRkcl90IGRtYV9hZGRyKQo+PiDCoCB7Cj4+IMKgwqDCoMKgwqAgZGVidWdfZG1hX21hcHBpbmdf
ZXJyb3IoZGV2LCBkbWFfYWRkcik7Cj4+IMKgIC3CoMKgwqAgaWYgKGRtYV9hZGRyID09IERNQV9N
QVBQSU5HX0VSUk9SKQo+PiArwqDCoMKgIGlmICh1bmxpa2VseShkbWFfYWRkciA9PSBETUFfTUFQ
UElOR19FUlJPUikpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVOT01FTTsKPj4gwqDC
oMKgwqDCoCByZXR1cm4gMDsKPj4gwqAgfQo+PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2lvbW11
