Return-Path: <SRS0=BXsX=DM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8619EC4363A
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 13:29:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E86CB20756
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 13:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHwHZs6I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E86CB20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 731B620447;
	Mon,  5 Oct 2020 13:29:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HKeobhl5mGzk; Mon,  5 Oct 2020 13:28:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8C7FA203D0;
	Mon,  5 Oct 2020 13:28:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C9EFC07FF;
	Mon,  5 Oct 2020 13:28:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87206C0051
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 13:28:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7CA84835F2
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 13:28:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DF-bsHJZUXQg for <iommu@lists.linux-foundation.org>;
 Mon,  5 Oct 2020 13:28:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com
 [209.85.167.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 77432835DF
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 13:28:56 +0000 (UTC)
Received: by mail-lf1-f68.google.com with SMTP id a9so1479353lfc.7
 for <iommu@lists.linux-foundation.org>; Mon, 05 Oct 2020 06:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=pDfp+8jOaUeqI88f58G9d3pgrodgYrD29BLFi8aPWHs=;
 b=XHwHZs6I/CK3sd9jDKPmF1UqwJYJ53JBn2m9d89uwdZVrxeYSUI3vD9v3uiGWcVgkt
 RKn1CcbnELQ+4OV9z8d+pGkmSiC9QrGQrVfhjSloGJ30C6vd+dUjVO/GIpewsP6DGNsl
 3nbBPzeg37N3K/MoLJoHyTJ4JcND13yAFqvwPPqIdbNFKEzZ55mNQl2cOHQLjsF0ePK/
 OD7X3ca/9b0qE2AS2CYKlvLGNphlCTFilptvxGFYRnvAicaP56jSFGSZgOgX618WjQbp
 UmMqzFm2umphzrt7unSi5tv1Vqqv96QPiseiYX9RZOLrkOzIj+no+ELeZCSGlGd24KWv
 nGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pDfp+8jOaUeqI88f58G9d3pgrodgYrD29BLFi8aPWHs=;
 b=F5pvxd6xo1gUt4yXfHirvex0yuFBFjX6DwSti/Ol7PjUO1tqLSDyjLupMOqRH2NwPl
 /78Ci3khHvURuW1s8YeMe6WRaacmW+iLkFfYCPQJ2wV30ZJorqajaaDi5YlI4KqWv05Q
 o+H2N61vw1qn6j0M0DaUuE1IXjJfVltTzLhwGT/NKYYwj2c5Ck5+R07XgC5lTfknro9X
 RxGOyjhWmDmXsLswp/qG7YvaWkwS3o9ACQLHnk5QD5ipYvD/c6hZ+GDeExERUUMcJ5Ys
 Gmpe/A97PhVgiWfMqQXD9ykf/tN3VU+D2kJL6wliouj+4VgxS1syl9hza9h6LW2lCLKd
 4VCA==
X-Gm-Message-State: AOAM531/gGnOzaJeAiRLzgO3iFYpv+JzTqFO70ZbTdzy1c33hCLeOQrB
 J4QzVUuw3otu7RraZVPhKjQ=
X-Google-Smtp-Source: ABdhPJzYnCEZuOgmvTnVXNmuhQidi8+UND8HD9ZaURgVJOb85YF35KkKZhBGO5IvLcC/lQpRq4nEiA==
X-Received: by 2002:a19:b4b:: with SMTP id 72mr5295868lfl.590.1601904534662;
 Mon, 05 Oct 2020 06:28:54 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-252.nat.spd-mgts.ru.
 [109.252.91.252])
 by smtp.googlemail.com with ESMTPSA id b16sm2594099ljh.34.2020.10.05.06.28.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2020 06:28:54 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] iommu/tegra-smmu: Rework tegra_smmu_probe_device()
To: Thierry Reding <thierry.reding@gmail.com>
References: <20201002060807.32138-1-nicoleotsuka@gmail.com>
 <20201002060807.32138-3-nicoleotsuka@gmail.com>
 <b1a195cf-0127-0531-f6d1-835367511f57@gmail.com>
 <0c66bab9-0132-d3fb-ea4e-de1278cf2b04@gmail.com>
 <20201005095351.GI425362@ulmo>
 <ae48aaaf-fe10-6de4-06bb-2afbde799168@gmail.com>
 <20201005111547.GQ425362@ulmo>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <39cb0056-1447-2232-d33c-adb17114740a@gmail.com>
Date: Mon, 5 Oct 2020 16:28:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201005111547.GQ425362@ulmo>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, linux-tegra@vger.kernel.org
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

MDUuMTAuMjAyMCAxNDoxNSwgVGhpZXJyeSBSZWRpbmcg0L/QuNGI0LXRgjoKPiBPbiBNb24sIE9j
dCAwNSwgMjAyMCBhdCAwMTozNjo1NVBNICswMzAwLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6Cj4+
IDA1LjEwLjIwMjAgMTI6NTMsIFRoaWVycnkgUmVkaW5nINC/0LjRiNC10YI6Cj4+PiBPbiBGcmks
IE9jdCAwMiwgMjAyMCBhdCAwNTo1MDowOFBNICswMzAwLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6
Cj4+Pj4gMDIuMTAuMjAyMCAxNzoyMiwgRG1pdHJ5IE9zaXBlbmtvINC/0LjRiNC10YI6Cj4+Pj4+
PiAgc3RhdGljIGludCB0ZWdyYV9zbW11X29mX3hsYXRlKHN0cnVjdCBkZXZpY2UgKmRldiwKPj4+
Pj4+ICAJCQkgICAgICAgc3RydWN0IG9mX3BoYW5kbGVfYXJncyAqYXJncykKPj4+Pj4+ICB7Cj4+
Pj4+PiArCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKmlvbW11X3BkZXYgPSBvZl9maW5kX2Rldmlj
ZV9ieV9ub2RlKGFyZ3MtPm5wKTsKPj4+Pj4+ICsJc3RydWN0IHRlZ3JhX21jICptYyA9IHBsYXRm
b3JtX2dldF9kcnZkYXRhKGlvbW11X3BkZXYpOwo+Pj4+Pj4gIAl1MzIgaWQgPSBhcmdzLT5hcmdz
WzBdOwo+Pj4+Pj4gIAo+Pj4+Pj4gKwlvZl9ub2RlX3B1dChhcmdzLT5ucCk7Cj4+Pj4+PiArCj4+
Pj4+PiArCWlmICghbWMgfHwgIW1jLT5zbW11KQo+Pj4+Pj4gKwkJcmV0dXJuIC1FUFJPQkVfREVG
RVI7Cj4+Pj4+IHBsYXRmb3JtX2dldF9kcnZkYXRhKE5VTEwpIHdpbGwgY3Jhc2guCj4+Pj4+Cj4+
Pj4KPj4+PiBBY3R1YWxseSwgcGxhdGZvcm1fZ2V0X2RydmRhdGEoTlVMTCkgY2FuJ3QgaGFwcGVu
LiBJIG92ZXJsb29rZWQgdGhpcy4KPj4+Cj4+PiBIb3cgc28/IEl0J3MgdGVjaG5pY2FsbHkgcG9z
c2libGUgZm9yIHRoZSBpb21tdXMgcHJvcGVydHkgdG8gcmVmZXJlbmNlIGEKPj4+IGRldmljZSB0
cmVlIG5vZGUgZm9yIHdoaWNoIG5vIHBsYXRmb3JtIGRldmljZSB3aWxsIGV2ZXIgYmUgY3JlYXRl
ZCwgaW4KPj4+IHdoaWNoIGNhc2Ugb2ZfZmluZF9kZXZpY2VfYnlfbm9kZSgpIHdpbGwgcmV0dXJu
IE5VTEwuIFRoYXQncyB2ZXJ5Cj4+PiB1bmxpa2VseSBhbmQgcGVyaGFwcyB3b3J0aCBqdXN0IGNy
YXNoaW5nIG9uIHRvIG1ha2Ugc3VyZSBpdCBnZXRzIGZpeGVkCj4+PiBpbW1lZGlhdGVseS4KPj4K
Pj4gVGhlIHRlZ3JhX3NtbXVfb3BzIGFyZSByZWdpc3RlcmVkIGZyb20gdGhlIFNNTVUgZHJpdmVy
IGl0c2VsZiBhbmQgTUMKPj4gZHJpdmVyIHNldHMgcGxhdGZvcm0gZGF0YSBiZWZvcmUgU01NVSBp
cyBpbml0aWFsaXplZCwgaGVuY2UgZGV2aWNlIGlzCj4+IGd1YXJhbnRlZWQgdG8gZXhpc3QgYW5k
IG1jIGNhbid0IGJlIE5VTEwuCj4gCj4gWWVzLCBidXQgdGhhdCBhc3N1bWVzIHRoYXQgYXJncy0+
bnAgcG9pbnRzIHRvIHRoZSBtZW1vcnkgY29udHJvbGxlcidzCj4gZGV2aWNlIHRyZWUgbm9kZS4g
SXQncyBvYnZpb3VzbHkgYSBtaXN0YWtlIHRvIGRvIHRoaXMsIGJ1dCBJIGRvbid0IHRoaW5rCj4g
YW55b25lIHdpbGwgcHJldmVudCB5b3UgZnJvbSBkb2luZyB0aGlzOgo+IAo+IAlpb21tdXMgPSA8
JnsvY2hvc2VufSAwPjsKPiAKPiBJbiB0aGF0IGNhc2UsIHNpbmNlIG5vIHBsYXRmb3JtIGRldmlj
ZSBpcyBjcmVhdGVkIGZvciB0aGUgL2Nob3NlbiBub2RlLAo+IGlvbW11X3BkZXYgd2lsbCBlbmQg
dXAgYmVpbmcgTlVMTCBhbmQgcGxhdGZvcm1fZ2V0X2RydmRhdGEoKSB3aWxsIGNyYXNoLgoKQnV0
IHRoZW4gVGVncmEgU01NVSBpc24ndCBhc3NvY2lhdGVkIHdpdGggdGhlIGRldmljZSdzIElPTU1V
IHBhdGgsIGFuZAp0aHVzLCB0ZWdyYV9zbW11X29mX3hsYXRlKCkgd29uJ3QgYmUgaW52b2tlZCBm
b3IgdGhpcyBkZXZpY2UuCgo+IFRoYXQgc2FpZCwgSSdtIGZpbmUgd2l0aCBub3QgYWRkaW5nIGEg
Y2hlY2sgZm9yIHRoYXQuIElmIGFueW9uZSByZWFsbHkKPiBkb2VzIGVuZCB1cCBtZXNzaW5nIHRo
aXMgdXAgdGhleSBkZXNlcnZlIHRoZSBjcmFzaC4KPiAKPiBJJ20gc3RpbGwgYSBiaXQgdW5kZWNp
ZGVkIGFib3V0IHRoZSBtYy0+c21tdSBjaGVjayBiZWNhdXNlIEkgaGF2ZW4ndAo+IGNvbnZpbmNl
ZCBteXNlbGYgeWV0IHRoYXQgaXQgY2FuJ3QgaGFwcGVuLgoKRm9yIG5vdyBJIGNhbid0IHNlZSBh
bnkgcmVhbGlzdGljIHNpdHVhdGlvbiB3aGVyZSBtYy0+c21tdSBjb3VsZCBiZSBOVUxMLgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5n
IGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
