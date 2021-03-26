Return-Path: <SRS0=A+5j=IY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED3EC433C1
	for <iommu@archiver.kernel.org>; Fri, 26 Mar 2021 22:05:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15C1561953
	for <iommu@archiver.kernel.org>; Fri, 26 Mar 2021 22:05:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15C1561953
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A25BC60D62;
	Fri, 26 Mar 2021 22:05:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1HQx2HofWPPt; Fri, 26 Mar 2021 22:05:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F9DB605EC;
	Fri, 26 Mar 2021 22:05:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34C26C000C;
	Fri, 26 Mar 2021 22:05:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8BCDC000A
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 22:05:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AEA0840619
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 22:05:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z5O-U_VRd-Uq for <iommu@lists.linux-foundation.org>;
 Fri, 26 Mar 2021 22:05:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 993DC40618
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 22:05:15 +0000 (UTC)
Received: by mail-lf1-x131.google.com with SMTP id i26so9796284lfl.1
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 15:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=G5yzMCApy6O7S/RSlef+ZgO2MSUdSYoxvQuorExVMKg=;
 b=F74pKwCJoCGxE9l7Uq0FgU8kb13gxXZeD/+EcUlhaq/UvxbpCgrQh610hH0pVbRpqD
 l9v5UTYeutdVz0fviNnu3DdRdktD/TqObA/qJo/00JeGhsh6WSyLFx5qswRPKyyN4RbU
 9cIA+wdrjYBbsGYYs5jHadfl4v1c6zoHCRQmRNtue2YncLpd/zR6/qSDrYabp1AMN0XK
 ReKNONyIhRMNawlWhm3FMraUo47vRBv296xn0QUEIb5/v2uND85AMQj6/W8mtJqYz6bH
 n3OWfPfq3iQDlmu9uaveJE7gs8uRb5bbB0/lE3HTUiVAaGHwNI31DXPcVzmep6drHNdi
 HogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G5yzMCApy6O7S/RSlef+ZgO2MSUdSYoxvQuorExVMKg=;
 b=oqBlHDCy2lf5/J4r17aHdC8qovUn6pYfJ0Yf/D/fyV47+CaOZWjva1f+ldzfaC3DDA
 n95b+lMg09Oo0y/YnYRViMgtpNv80eonksEh11e6NX+LAsF0EFJVKZXTG/4n0MO4aFEi
 DVuSlUH5WRFcLDPCLpjaTVnzP5/sAiwI4c6wkOGZjnC1k5ruQgP8M+mNEr6hbWQMREjI
 IQFD19ZOeI9pQfHpVijynY+pvaXLyyCboKFT4eKzbFofNXW9wX8mYkIW4gY/wzjrxhOi
 mVx1bfO9HwHC7wdnLadyKYSKdwAMnXklwITE6FJ3TpVcjfHrMo+uNM5HKzzOpZpLqm8w
 otvQ==
X-Gm-Message-State: AOAM532MXhbh/VNxn+nz1qiGT4bF4Z5/A8aeeXjrHFKcPluNHypBRPKc
 2zJUEp70k+VU14NBjQNnFB4=
X-Google-Smtp-Source: ABdhPJwMzGhKFlOsQPSHtlb9KsLIs4Sw19Bk7S4L7KHJR+ZKz6h00VjoCZ0514xBbyeAXN8ElDBF8Q==
X-Received: by 2002:ac2:41d4:: with SMTP id d20mr9001216lfi.213.1616796313096; 
 Fri, 26 Mar 2021 15:05:13 -0700 (PDT)
Received: from ?IPv6:2a00:1370:814d:99a9:a10:76ff:fe69:21b6?
 ([2a00:1370:814d:99a9:a10:76ff:fe69:21b6])
 by smtp.googlemail.com with ESMTPSA id v18sm1310844ljg.85.2021.03.26.15.05.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Mar 2021 15:05:12 -0700 (PDT)
Subject: Re: [PATCH 0/9] arm64: tegra: Prevent early SMMU faults
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
References: <20210325130332.778208-1-thierry.reding@gmail.com>
 <197876d1-0046-f673-5d3e-818d1002542b@gmail.com>
 <YF4NQPee+/Qi6zVd@orome.fritz.box>
 <9f1a8455-f7a6-1f66-f36c-032abacf71f5@gmail.com>
Message-ID: <06af34f8-19f4-97d1-d703-fd91dcdc6309@gmail.com>
Date: Sat, 27 Mar 2021 01:05:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <9f1a8455-f7a6-1f66-f36c-032abacf71f5@gmail.com>
Content-Language: en-US
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Will Deacon <will@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
 iommu@lists.linux-foundation.org, Nicolin Chen <nicolinc@nvidia.com>,
 linux-tegra@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
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

MjYuMDMuMjAyMSAxOTo1NSwgRG1pdHJ5IE9zaXBlbmtvINC/0LjRiNC10YI6Cj4gMjYuMDMuMjAy
MSAxOTozNSwgVGhpZXJyeSBSZWRpbmcg0L/QuNGI0LXRgjoKPj4gT24gRnJpLCBNYXIgMjYsIDIw
MjEgYXQgMDY6Mjk6MjhQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+Pj4gMjUuMDMu
MjAyMSAxNjowMywgVGhpZXJyeSBSZWRpbmcg0L/QuNGI0LXRgjoKPj4+PiBGcm9tOiBUaGllcnJ5
IFJlZGluZyA8dHJlZGluZ0BudmlkaWEuY29tPgo+Pj4+Cj4+Pj4gSGksCj4+Pj4KPj4+PiB0aGlz
IGlzIGEgc2V0IG9mIHBhdGNoZXMgdGhhdCBpcyB0aGUgcmVzdWx0IG9mIGVhcmxpZXIgZGlzY3Vz
c2lvbnMKPj4+PiByZWdhcmRpbmcgZWFybHkgaWRlbnRpdHkgbWFwcGluZ3MgdGhhdCBhcmUgbmVl
ZGVkIHRvIGF2b2lkIFNNTVUgZmF1bHRzCj4+Pj4gZHVyaW5nIGVhcmx5IGJvb3QuCj4+Pj4KPj4+
PiBUaGUgZ29hbCBoZXJlIGlzIHRvIGF2b2lkIGVhcmx5IGlkZW50aXR5IG1hcHBpbmdzIGFsdG9n
ZXRoZXIgYW5kIGluc3RlYWQKPj4+PiBwb3N0cG9uZSB0aGUgbmVlZCBmb3IgdGhlIGlkZW50aXR5
IG1hcHBpbmdzIHRvIHdoZW4gZGV2aWNlcyBhcmUgYXR0YWNoZWQKPj4+PiB0byB0aGUgU01NVS4g
VGhpcyB3b3JrcyBieSBtYWtpbmcgdGhlIFNNTVUgZHJpdmVyIGNvb3JkaW5hdGUgd2l0aCB0aGUK
Pj4+PiBtZW1vcnkgY29udHJvbGxlciBkcml2ZXIgb24gd2hlbiB0byBzdGFydCBlbmZvcmNpbmcg
U01NVSB0cmFuc2xhdGlvbnMuCj4+Pj4gVGhpcyBtYWtlcyBUZWdyYSBiZWhhdmUgaW4gYSBtb3Jl
IHN0YW5kYXJkIHdheSBhbmQgcHVzaGVzIHRoZSBjb2RlIHRvCj4+Pj4gZGVhbCB3aXRoIHRoZSBU
ZWdyYS1zcGVjaWZpYyBwcm9ncmFtbWluZyBpbnRvIHRoZSBOVklESUEgU01NVQo+Pj4+IGltcGxl
bWVudGF0aW9uLgo+Pj4KPj4+IEl0IGlzIGFuIGludGVyZXN0aW5nIGlkZWEgd2hpY2ggaW5zcGly
ZWQgbWUgdG8gdHJ5IHRvIGFwcGx5IGEgc29tZXdoYXQgc2ltaWxhciB0aGluZyB0byBUZWdyYSBT
TU1VIGRyaXZlciBieSBob2xkaW5nIHRoZSBTTU1VIEFTSUQgZW5hYmxlLWJpdCB1bnRpbCBkaXNw
bGF5IGRyaXZlciBhbGxvd3MgdG8gdG9nZ2xlIGl0LiBUaGlzIG1lYW5zIHRoYXQgd2Ugd2lsbCBu
ZWVkIGFuIGV4dHJhIHNtYWxsIHRlZ3JhLXNwZWNpZmljIFNNTVUgQVBJIGZ1bmN0aW9uLCBidXQg
aXQgc2hvdWxkIGJlIG9rYXkuCj4+Pgo+Pj4gSSB0eXBlZCBhIHBhdGNoIGFuZCBzZWVtcyBpdCdz
IHdvcmtpbmcgZ29vZCwgSSdsbCBwcmVwYXJlIGEgcHJvcGVyIHBhdGNoIGlmIHlvdSBsaWtlIGl0
Lgo+Pgo+PiBUaGF0IHdvdWxkIGFjdHVhbGx5IGJlIHdvcmtpbmcgYXJvdW5kIHRoZSBwcm9ibGVt
IHRoYXQgdGhpcyBwYXRjaCB3YXMKPj4gc3VwcG9zZWQgdG8gcHJlcGFyZSBmb3IuIFRoZSByZWFz
b24gZm9yIHRoaXMgY3VycmVudCBwYXRjaCBzZXJpZXMgaXMgdG8KPj4gbWFrZSBzdXJlIFNNTVUg
dHJhbnNsYXRpb24gaXNuJ3QgZW5hYmxlZCB1bnRpbCBhIGRldmljZSBoYXMgYWN0dWFsbHkKPj4g
YmVlbiBhdHRhY2hlZCB0byB0aGUgU01NVS4gT25jZSBpdCBoYXMgYmVlbiBhdHRhY2hlZCwgdGhl
IGFzc3VtcHRpb24gaXMKPj4gdGhhdCBhbnkgaWRlbnRpdHkgbWFwcGluZ3Mgd2lsbCBoYXZlIGJl
ZW4gY3JlYXRlZC4KPj4KPj4gT25lIFRlZ3JhIFNNTVUgdGhhdCBzaG91bGRuJ3QgYmUgYSBwcm9i
bGVtIGJlY2F1c2UgdHJhbnNsYXRpb25zIGFyZW4ndAo+PiBlbmFibGVkIHVudGlsIGRldmljZSBh
dHRhY2ggdGltZS4gU28gaW4gb3RoZXIgd29yZHMgdGhpcyBwYXRjaCBzZXQgaXMgdG8KPj4gZ2V0
IFRlZ3JhMTg2IGFuZCBsYXRlciB0byBwYXJpdHkgd2l0aCBlYXJsaWVyIGNoaXBzIGZyb20gdGhp
cyBwb2ludCBvZgo+PiB2aWV3Lgo+Pgo+PiBJIHRoaW5rIHRoZSBwcm9ibGVtIHRoYXQgeW91J3Jl
IHRyeWluZyB0byB3b3JrIGFyb3VuZCBpcyBiZXR0ZXIgc29sdmVkCj4+IGJ5IGVzdGFibGlzaGlu
ZyB0aGVzZSBpZGVudGl0eSBtYXBwaW5ncy4gSSBkbyBoYXZlIHBhdGNoZXMgdG8gaW1wbGVtZW50
Cj4+IHRoaXMgZm9yIFRlZ3JhMjEwIGFuZCBlYXJsaWVyLCB0aG91Z2ggdGhleSBtYXkgcmVxdWly
ZSBhZGRpdGlvbmFsIHdvcmsKPj4gaWYgeW91IGhhdmUgYm9vdGxvYWRlcnMgdGhhdCBkb24ndCB1
c2Ugc3RhbmRhcmQgRFQgYmluZGluZ3MgZm9yIHBhc3NpbmcKPj4gaW5mb3JtYXRpb24gYWJvdXQg
dGhlIGZyYW1lYnVmZmVyIHRvIHRoZSBrZXJuZWwuCj4gCj4gSSdtIG5vdCBzdXJlIHdoYXQgZWxz
ZSByZWFzb25hYmxlIGNvdWxkIGJlIGRvbmUgd2l0aG91dCB1cGdyYWRpbmcgdG8gYQo+IHZlcnkg
c3BlY2lmaWMgdmVyc2lvbiBvZiBmaXJtd2FyZSwgd2hpY2ggZGVmaW5pdGVseSBpc24ndCBhIHZh
cmlhbnQgZm9yCj4gb2xkZXIgZGV2aWNlcyB3aGljaCBoYXZlIGEgd2lsZCB2YXJpZXR5IG9mIGJv
b3Rsb2FkZXJzLCBjdXN0b21pemVkCj4gdXNlLWNhc2VzIGFuZCBldGMuCj4gCj4gV2UgY291bGQg
YWRkIGEga2x1ZGdlIHRoYXQgSSdtIHN1Z2dlc3RpbmcgYXMgYSB1bml2ZXJzYWwgZmFsbGJhY2sK
PiBzb2x1dGlvbiwgaXQgc2hvdWxkIHdvcmsgd2VsbCBmb3IgYWxsIGNhc2VzIHRoYXQgSSBjYXJl
IGFib3V0Lgo+IAo+IFNvIHdlIGNvdWxkIGhhdmUgdGhlIHZhcmlhbnQgd2l0aCBpZGVudGl0eSBt
YXBwaW5ncywgYW5kIGlmIG1hcHBpbmcKPiBpc24ndCBwcm92aWRlZCwgdGhlbiBmYWxsIGJhY2sg
dG8gdGhlIGtsdWRnZS4KPiAKCkkgdHJpZWQgYSBzbGlnaHRseSBkaWZmZXJlbnQgdmFyaWFudCBv
ZiB0aGUga2x1ZGdlIGJ5IGhvbGRpbmcgdGhlIEFTSUQncwplbmFibGUgdGlsbCB0aGUgZmlyc3Qg
bWFwcGluZyBpcyBjcmVhdGVkIGZvciB0aGUgZGlzcGxheSBjbGllbnRzIGFuZApJT01NVV9ET01B
SU5fRE1BIG5vdyB3b3JrcyBwcm9wZXJseSAobm8gRU1FTSBlcnJvcnMgb24gYm9vdCBhbmQgZXRj
KSBhbmQKd2l0aG91dCBhIG5lZWQgdG8gY2hhbmdlIHRoZSBEQyBkcml2ZXIuCgpJIGFsc28gdHJp
ZWQgdG8gcmVtb3ZlIHRoZSBhcm1faW9tbXVfZGV0YWNoX2RldmljZSgpIGZyb20gdGhlIFZERSBk
cml2ZXIKYW5kIHdlIG5vdyBoYXZlIDMgaW1wbGljaXQgZG9tYWlucyBpbiB1c2UgKERSTSwgSFgs
IFZERVt3YXN0ZWRdKSArIDEKZXhwbGljaXQgKFZERSkgb24gVDMwLCB3aGljaCB3b3JrcyBva2F5
IGZvciB0b2RheS4gU28gdGVjaG5pY2FsbHkgd2UKY291bGQgc3VwcG9ydCB0aGUgSU9NTVVfRE9N
QUlOX0RNQSB3aXRoIGEgY291cGxlIHNtYWxsIGNoYW5nZXMgcmlnaHQgbm93Cm9yIGF0IGxlYXN0
IHJldmVydCB0aGUgaGFja3MgdGhhdCB3ZXJlIG5lZWRlZCBmb3IgTnlhbi4KCkJ1dCBpbiBvcmRl
ciB0byBlbmFibGUgSU9NTVVfRE9NQUlOX0RNQSBwcm9wZXJseSwgd2Ugd2lsbCBuZWVkIHRvIGRv
CnNvbWV0aGluZyBhYm91dCB0aGUgRE1BIG1hcHBpbmdzIGZpcnN0IGluIHRoZSBEUk0gZHJpdmVy
IGFuZCBJIGFsc28KZm91bmQgdGhhdCBpbXBsaWNpdCBJT01NVSBzb21laG93IGRvZXNuJ3Qgd29y
ayBmb3IgaG9zdDF4IGRyaXZlciBhdCBhbGwsCnNvIHRoaXMgbmVlZHMgdG8gYmUgZml4ZWQgdG9v
LgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBt
YWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
