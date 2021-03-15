Return-Path: <SRS0=3mOG=IN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8919C433E0
	for <iommu@archiver.kernel.org>; Mon, 15 Mar 2021 20:02:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40AAA64E83
	for <iommu@archiver.kernel.org>; Mon, 15 Mar 2021 20:02:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40AAA64E83
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 031684313B;
	Mon, 15 Mar 2021 20:02:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nOXVNYIymBFa; Mon, 15 Mar 2021 20:02:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id EF82240003;
	Mon, 15 Mar 2021 20:02:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C115FC000A;
	Mon, 15 Mar 2021 20:02:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F15D8C0001
 for <iommu@lists.linux-foundation.org>; Mon, 15 Mar 2021 20:02:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CA1848344C
 for <iommu@lists.linux-foundation.org>; Mon, 15 Mar 2021 20:02:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sE4UAgDbCWaY for <iommu@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 20:02:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 44D22836EA
 for <iommu@lists.linux-foundation.org>; Mon, 15 Mar 2021 20:02:12 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id bt4so9398240pjb.5
 for <iommu@lists.linux-foundation.org>; Mon, 15 Mar 2021 13:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=rL3vKYH4+4i5CC0aVunrWlzK1wduuZG220EJ/vhziQw=;
 b=ELopI56GAtnJ9od1YG8FNmWchTUFYHQzQnDiLKLf6uFJ6rH401bfejAp18uGs91+1i
 GWgTfleCV6Uh5T2r2Pxj6Web9vw7JQJTQu2ly9AYPV7FqhK9lHHqPEwCmSFLrXt7xO75
 b7MBkKnfT2hK7IVL5qsXRpWHDJZz9q7PqyhnurW04j3isnCcgZt4m1zgzxGireYB/1MD
 AhUISweOYG+oDxLUgzuZceLwibRCeMZ50hM9Gq0o67b8ySWu5W+45c89PUleZR0VCE1K
 WiJ1orcF8r8PVYuF3sNOXmBrIltsrTZy9K2zlTsqmEG9jdkuJNhEhU/P44raIFgYXE/F
 BPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=rL3vKYH4+4i5CC0aVunrWlzK1wduuZG220EJ/vhziQw=;
 b=advtAbjY7Nc4FnaaZW6t/AjhHmq14LU9bPbsN8JZMukJrMRCHrASmKD+FJ7vWufT30
 9jSO/Eb3wxZCduNbBW4t3rcegPP+APjX3mZBcdf4RnGvvW5yP7YzGW+/PdPBZaeoCVwi
 F3+yeNIIvK5Day93Z4KydtQvFnKAbOnjaj1KYAUYcT23RPXInpdGFnMqQ4Thsbd7+vgu
 zTbVAnxIUgufgun+lSSiBezcD3e9MylvwYPpS2NUnDumkvvlaCSsJHxqjRnCYEtoztVF
 gglHpHrS/4siIgD8dDBw5DS4GeohKs5WNXgVjCqSLb9NU9RhS1gPA3V+OrULwPo/3GXS
 0w1Q==
X-Gm-Message-State: AOAM530/L7fowbl1d13Z6d+cFZ9WRzZU1/PhktiKW1mhBvo3scSCLYlk
 Cs/jQvFpSS+wVwGaLB+qvY4=
X-Google-Smtp-Source: ABdhPJybiLZqEI+XjPqVHFhLW3Gu6zqMwtmPntvElOc45gnu6cMWEQmVLZXXRngR/RiMCkr7ZNGVeQ==
X-Received: by 2002:a17:90a:9d82:: with SMTP id k2mr807500pjp.48.1615838531534; 
 Mon, 15 Mar 2021 13:02:11 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id 11sm4712300pfn.146.2021.03.15.13.02.10
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 15 Mar 2021 13:02:11 -0700 (PDT)
Date: Mon, 15 Mar 2021 12:59:57 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v4] iommu/tegra-smmu: Add pagetable mappings to debugfs
Message-ID: <20210315195956.GA16172@Asurada-Nvidia>
References: <20210315033504.23937-1-nicoleotsuka@gmail.com>
 <c57a805a-cf14-1d78-ae2a-dfce4f643db1@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c57a805a-cf14-1d78-ae2a-dfce4f643db1@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
 will@kernel.org
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

T24gTW9uLCBNYXIgMTUsIDIwMjEgYXQgMDk6NTM6MDlQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+IDE1LjAzLjIwMjEgMDY6MzUsIE5pY29saW4gQ2hlbiDQv9C40YjQtdGCOgo+ID4g
VGhpcyBwYXRjaCBkdW1wcyBhbGwgYWN0aXZlIG1hcHBpbmcgZW50cmllcyBmcm9tIHBhZ2V0YWJs
ZQo+ID4gdG8gYSBkZWJ1Z2ZzIGRpcmVjdG9yeSBuYW1lZCAibWFwcGluZ3MiLgo+ID4gCj4gPiBB
dGFjaGluZyBhbiBleGFtcGxlOgo+IAo+IEF0dGFjaGluZwo+IAo+ID4gCj4gPiBTV0dST1VQOiBo
Ywo+ID4gQVNJRDogMAo+ID4gcmVnOiAweDI1MAo+ID4gUFRCX0FTSUQ6IDB4ZTAwODAwMDQKPiA+
IGFzLT5wZF9kbWE6IDB4ODAwMDQwMDAKPiA+IHsKPiA+ICAgICAgICAgWzEwMjNdIDB4ZjAwODAw
MGIgKDEpCj4gPiAgICAgICAgIHsKPiA+ICAgICAgICAgICAgICAgICBQVEUgUkFOR0UgICAgICB8
IEFUVFIgfCBQSFlTICAgICAgICAgICAgICAgfCBJT1ZBICAgICAgICAgICAgICAgfCBTSVpFCj4g
PiAgICAgICAgICAgICAgICAgWyMxMDIzLCAjMTAyM10gfCAweDUgIHwgMHgwMDAwMDAwMTExYThk
MDAwIHwgMHgwMDAwMDAwMGZmZmZmMDAwIHwgMHgxMDAwCj4gPiAgICAgICAgIH0KPiA+IH0KPiA+
IFRvdGFsIFBERSBjb3VudDogMQo+ID4gVG90YWwgUFRFIGNvdW50OiAxCj4gPiAKPiA+IFNpZ25l
ZC1vZmYtYnk6IE5pY29saW4gQ2hlbiA8bmljb2xlb3RzdWthQGdtYWlsLmNvbT4KPiA+IC0tLQo+
IAo+IEdvb2QgdG8gbWUsIHRoYW5rcy4KPiAKPiBUZXN0ZWQtYnk6IERtaXRyeSBPc2lwZW5rbyA8
ZGlnZXR4QGdtYWlsLmNvbT4KPiBSZXZpZXdlZC1ieTogRG1pdHJ5IE9zaXBlbmtvIDxkaWdldHhA
Z21haWwuY29tPgo+IAo+ID4gKwlmb3IgKHBkX2luZGV4ID0gMDsgcGRfaW5kZXggPCBTTU1VX05V
TV9QREU7IHBkX2luZGV4KyspIHsKPiA+ICsJCXN0cnVjdCBwYWdlICpwdF9wYWdlOwo+ID4gKwkJ
dTMyICphZGRyOwo+ID4gKwkJdW5zaWduZWQgaW50IGk7Cj4gCj4gVW5pbXBvcnRhbnQgbml0OiBJ
J2Qga2VlcCBsaW5lcyBhcnJhbmdlZCBieSBsZW5ndGggZm9yIGNvbnNpc3RlbmN5IHdpdGgKPiB0
aGUgcmVzdCBvZiB0aGUgY29kZS4KPiAKPiAuLi4KPiA+ICsJZ3JvdXBfZGVidWcgPSBkZXZtX2tj
YWxsb2MoZGV2LCBzb2MtPm51bV9zd2dyb3Vwcywgc2l6ZW9mKCpncm91cF9kZWJ1ZyksIEdGUF9L
RVJORUwpOwo+IAo+IEFub3RoZXIgbml0OiB0aGlzIGlzIGEgbG9uZyBsaW5lLCBJJ2Qgc3BsaXQg
aXQgaW50byB0d28gbGluZXMgdG8ga2VlcAo+IGNvZGluZyBzdHlsZSBjb25zaXN0ZW50IGFuZCB0
byBpbXByb3ZlIHJlYWRhYmlsaXR5IGZvciB0aG9zZSB3aG8gaGF2ZSBhCj4gc2lkZS1ieS1zaWRl
IGNvZGUgdmlld2luZyBzZXR1cC4KClNlbmRpbmcgdjUuIFdpbGwgYWRkIHlvdXIgVGVzdGVkLWJ5
IGFuZCBSZXZpZXdlZC1ieSBzaW5jZSB0aGVyZSdkCmJlIG5vIGZ1bmN0aW9uYWwgY2hhbmdlcy4g
VGhhbmtzIQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpp
b21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
