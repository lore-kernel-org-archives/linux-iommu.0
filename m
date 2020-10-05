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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2A7C4363A
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 10:37:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3BFF2078E
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 10:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHgpEcUk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3BFF2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8D3D28638F;
	Mon,  5 Oct 2020 10:37:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZSPnurwgmDnr; Mon,  5 Oct 2020 10:37:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 21B9B85D26;
	Mon,  5 Oct 2020 10:37:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 164BDC016F;
	Mon,  5 Oct 2020 10:37:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D0B1C0051
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 10:36:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 194D685608
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 10:36:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UnJZlw9F0F9d for <iommu@lists.linux-foundation.org>;
 Mon,  5 Oct 2020 10:36:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com
 [209.85.167.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4AA88855C6
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 10:36:58 +0000 (UTC)
Received: by mail-lf1-f67.google.com with SMTP id 197so10192446lfo.11
 for <iommu@lists.linux-foundation.org>; Mon, 05 Oct 2020 03:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=kXGxjrOECHo9Yx49QGExKC9VMrc3WpIW0kWli+WP6Wc=;
 b=fHgpEcUk5a1h/ZYcayz+n0HgwtBBcLPVDH60MdlYmQ6q1uhKixndlzQykidqHB5mtc
 t7XUXd/3M0YfRU8TRKSXnGeHzqymcHGdb1kkyPyhdnpxwVjek93PKmlERJT4spxrSsML
 e+biqMhblP2vDC8cAxpMc8nsz/z6v3bi/eewYMM0Bc9Ny6ftNgynxoM/naeY49qKQVz1
 Ktlp94D90cRnpS1+z4iSVuSzTxrglQg71Jp4A2mFLyYW2yW7RPnvt9B1pXqGm/eRAGfD
 FhPkYwF9oFyvg4CFrmcpjP+1PK+iQI5FUhTSr7Jy25Czo1auDwZR79F2nQqqL8ZHr1wV
 jHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kXGxjrOECHo9Yx49QGExKC9VMrc3WpIW0kWli+WP6Wc=;
 b=bct+3pCBujqmmHkoTxFTOZfit+GxFxgY74OutZY/fnuaA9/eRUvUIgPb6rV38Df+Sf
 xiWDEsSYHAqQ1laS/0M/tJOUwH9J0p6DVRASgBPKOmm+YoAxY09NofLMfAftADB3jwF0
 DlkkaY+503ogkLyIJPTXydiTspElzW5Eaq5Q95EjuBLl1tj1zWPoWOKlQeCKGnLP5q/Q
 Q8qPuJqAs9sNDkSO/I1id7CWLGeHYe5GDL50bp/LEzr2IP162PmGlwuZWtXZ1CevCbQ/
 0ebBkIeAWUaWl1gfwIUZJIWssREZWokG2GthsMuLwz4Jc5fQNJyGDNnk4I61AgCaXNec
 X/1w==
X-Gm-Message-State: AOAM533IbjTFrABZxfIVt899QL/cJFuFQA4z9KJuJybxR1eqzdJXHCFH
 cmWuznQEi0NUMwgUxFPE4fQ=
X-Google-Smtp-Source: ABdhPJyJ9IH5yjJ1w3bo8h3abEOag+7Bnq7V9LkS3PO1PNhlyJ50gniAAz1mop6Ok01XMQ2/IMImiw==
X-Received: by 2002:a19:7e0d:: with SMTP id z13mr5049605lfc.455.1601894216462; 
 Mon, 05 Oct 2020 03:36:56 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.91.252])
 by smtp.googlemail.com with ESMTPSA id i18sm2561967lfo.243.2020.10.05.03.36.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2020 03:36:55 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] iommu/tegra-smmu: Rework tegra_smmu_probe_device()
To: Thierry Reding <thierry.reding@gmail.com>
References: <20201002060807.32138-1-nicoleotsuka@gmail.com>
 <20201002060807.32138-3-nicoleotsuka@gmail.com>
 <b1a195cf-0127-0531-f6d1-835367511f57@gmail.com>
 <0c66bab9-0132-d3fb-ea4e-de1278cf2b04@gmail.com>
 <20201005095351.GI425362@ulmo>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ae48aaaf-fe10-6de4-06bb-2afbde799168@gmail.com>
Date: Mon, 5 Oct 2020 13:36:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201005095351.GI425362@ulmo>
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

MDUuMTAuMjAyMCAxMjo1MywgVGhpZXJyeSBSZWRpbmcg0L/QuNGI0LXRgjoKPiBPbiBGcmksIE9j
dCAwMiwgMjAyMCBhdCAwNTo1MDowOFBNICswMzAwLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6Cj4+
IDAyLjEwLjIwMjAgMTc6MjIsIERtaXRyeSBPc2lwZW5rbyDQv9C40YjQtdGCOgo+Pj4+ICBzdGF0
aWMgaW50IHRlZ3JhX3NtbXVfb2ZfeGxhdGUoc3RydWN0IGRldmljZSAqZGV2LAo+Pj4+ICAJCQkg
ICAgICAgc3RydWN0IG9mX3BoYW5kbGVfYXJncyAqYXJncykKPj4+PiAgewo+Pj4+ICsJc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqaW9tbXVfcGRldiA9IG9mX2ZpbmRfZGV2aWNlX2J5X25vZGUoYXJn
cy0+bnApOwo+Pj4+ICsJc3RydWN0IHRlZ3JhX21jICptYyA9IHBsYXRmb3JtX2dldF9kcnZkYXRh
KGlvbW11X3BkZXYpOwo+Pj4+ICAJdTMyIGlkID0gYXJncy0+YXJnc1swXTsKPj4+PiAgCj4+Pj4g
KwlvZl9ub2RlX3B1dChhcmdzLT5ucCk7Cj4+Pj4gKwo+Pj4+ICsJaWYgKCFtYyB8fCAhbWMtPnNt
bXUpCj4+Pj4gKwkJcmV0dXJuIC1FUFJPQkVfREVGRVI7Cj4+PiBwbGF0Zm9ybV9nZXRfZHJ2ZGF0
YShOVUxMKSB3aWxsIGNyYXNoLgo+Pj4KPj4KPj4gQWN0dWFsbHksIHBsYXRmb3JtX2dldF9kcnZk
YXRhKE5VTEwpIGNhbid0IGhhcHBlbi4gSSBvdmVybG9va2VkIHRoaXMuCj4gCj4gSG93IHNvPyBJ
dCdzIHRlY2huaWNhbGx5IHBvc3NpYmxlIGZvciB0aGUgaW9tbXVzIHByb3BlcnR5IHRvIHJlZmVy
ZW5jZSBhCj4gZGV2aWNlIHRyZWUgbm9kZSBmb3Igd2hpY2ggbm8gcGxhdGZvcm0gZGV2aWNlIHdp
bGwgZXZlciBiZSBjcmVhdGVkLCBpbgo+IHdoaWNoIGNhc2Ugb2ZfZmluZF9kZXZpY2VfYnlfbm9k
ZSgpIHdpbGwgcmV0dXJuIE5VTEwuIFRoYXQncyB2ZXJ5Cj4gdW5saWtlbHkgYW5kIHBlcmhhcHMg
d29ydGgganVzdCBjcmFzaGluZyBvbiB0byBtYWtlIHN1cmUgaXQgZ2V0cyBmaXhlZAo+IGltbWVk
aWF0ZWx5LgoKVGhlIHRlZ3JhX3NtbXVfb3BzIGFyZSByZWdpc3RlcmVkIGZyb20gdGhlIFNNTVUg
ZHJpdmVyIGl0c2VsZiBhbmQgTUMKZHJpdmVyIHNldHMgcGxhdGZvcm0gZGF0YSBiZWZvcmUgU01N
VSBpcyBpbml0aWFsaXplZCwgaGVuY2UgZGV2aWNlIGlzCmd1YXJhbnRlZWQgdG8gZXhpc3QgYW5k
IG1jIGNhbid0IGJlIE5VTEwuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9p
b21tdQ==
