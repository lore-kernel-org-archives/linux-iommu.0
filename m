Return-Path: <SRS0=MyXX=DI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85A3C4363D
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 02:11:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42F512193E
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 02:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8imYH9R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F512193E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E4F978691C;
	Thu,  1 Oct 2020 02:11:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nTeWPRRttdLc; Thu,  1 Oct 2020 02:11:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 488B886910;
	Thu,  1 Oct 2020 02:11:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3625DC0891;
	Thu,  1 Oct 2020 02:11:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3EF8CC0051
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 02:11:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3A24A8625F
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 02:11:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NG9dGv-Oi6v5 for <iommu@lists.linux-foundation.org>;
 Thu,  1 Oct 2020 02:11:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com
 [209.85.167.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3BBA086256
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 02:11:34 +0000 (UTC)
Received: by mail-lf1-f67.google.com with SMTP id y2so4570972lfy.10
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 19:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2b8YJ/jVVR7JmlsGa7FjoHY0aps0ZebG9cV7sMoGxuM=;
 b=B8imYH9RcCeEdOmTlUlnev52Sz270GKuLllWU517V8pBJHqahNa9XWjov3tmmX6fP1
 dWfGwinkASFIxxmS5B9EsUhrlIXLNDKeTWWmMFK3WnuffX6XRuQNaQJKM+IrflrL0XL5
 Kfj38N/rW4KPdGlNEmUauhFW4WmdwxxrfKyLKl9U9blBFvUBj+6hBEkEID4QjUL09w/Z
 ng67npv0nUB8qsxjb7Yb2c/izGuY57asrEkrP/RrLl3IBr3HjTynacPIqW3ckJf/DgRf
 WI2QwGjSnzJ4U4vjWbJB3pK9LXx79pjYeHTWtBWtecZ06aQWkCS9NuXoHFRtYjr1cXbb
 1RkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2b8YJ/jVVR7JmlsGa7FjoHY0aps0ZebG9cV7sMoGxuM=;
 b=DD837jv74KuDT5twcLL9ifzuxI4qqeUfvmIsoaufWVA+UkMQfyzMZ5c2t0D8WdwtXw
 bmlK+AKHVraL5cXF/U5YXQvKQoh4CiK8+5TbPfWnO9zeFoSkdx0xZFeuTPLU6i3MjKxu
 kq4FK/bpDG5RGPMg0ByzOM1HWQfpoLA3z3dkQpN9EMAmEL4wsNOP+D0BVa7/Ldj2rCV4
 uJukad3qmnfgwPfOozlG8tRFbC8uZGeZBDf6B6WBurNJ19nMtQKaaOX4ru9TRPBVyR98
 0wfv3lqlVm7ymG8tHIpJh6Eq3LwSCoAHQl9NcWbsvaKKzuZAWGp4vG8yjdItzLXEtv7p
 +yaw==
X-Gm-Message-State: AOAM530GeQVjn/oelTkyiywnagP4TevwckjFU3XlmLg+Ac/C7KBHCkN1
 qhb8VzcBjiMDgl7bySbpPdY=
X-Google-Smtp-Source: ABdhPJwzkF/zX8i+aEADE+pp5Wl1aHNmiLSe9AZv5i60TKPO1ExNfB1hE9HpZELpWSIBfNYcGBcS4A==
X-Received: by 2002:a19:40c8:: with SMTP id n191mr1959843lfa.29.1601518292137; 
 Wed, 30 Sep 2020 19:11:32 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.91.252])
 by smtp.googlemail.com with ESMTPSA id e8sm303688ljk.25.2020.09.30.19.11.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2020 19:11:31 -0700 (PDT)
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
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <35115ac1-fb25-7226-7b50-61193669e696@gmail.com>
Date: Thu, 1 Oct 2020 05:11:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930164707.GB3852280@ulmo>
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

MzAuMDkuMjAyMCAxOTo0NywgVGhpZXJyeSBSZWRpbmcg0L/QuNGI0LXRgjoKPiBPbiBXZWQsIFNl
cCAzMCwgMjAyMCBhdCAwNzoyNTo0MVBNICswMzAwLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6Cj4+
IDMwLjA5LjIwMjAgMTk6MDYsIFRoaWVycnkgUmVkaW5nINC/0LjRiNC10YI6Cj4+PiBPbiBXZWQs
IFNlcCAzMCwgMjAyMCBhdCAwNjozNjo1MlBNICswMzAwLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6
Cj4+Pj4gIEknLi4uCj4+Pj4+PiArCXN0cnVjdCB0ZWdyYV9tYyAqbWMgPSBkZXZtX3RlZ3JhX2dl
dF9tZW1vcnlfY29udHJvbGxlcihkZXYpOwo+Pj4+Pj4gKwlzdHJ1Y3QgaW9tbXVfZndzcGVjICpm
d3NwZWMgPSBkZXZfaW9tbXVfZndzcGVjX2dldChkZXYpOwo+Pj4+Pgo+Pj4+PiBJdCBsb29rcyB0
byBtZSBsaWtlIHRoZSBvbmx5IHJlYXNvbiB3aHkgeW91IG5lZWQgdGhpcyBuZXcgZ2xvYmFsIEFQ
SSBpcwo+Pj4+PiBiZWNhdXNlIFBDSSBkZXZpY2VzIG1heSBub3QgaGF2ZSBhIGRldmljZSB0cmVl
IG5vZGUgd2l0aCBhIHBoYW5kbGUgdG8KPj4+Pj4gdGhlIElPTU1VLiBIb3dldmVyLCBTTU1VIHN1
cHBvcnQgZm9yIFBDSSB3aWxsIG9ubHkgYmUgZW5hYmxlZCBpZiB0aGUKPj4+Pj4gcm9vdCBjb21w
bGV4IGhhcyBhbiBpb21tdXMgcHJvcGVydHksIHJpZ2h0PyBJbiB0aGF0IGNhc2UsIGNhbid0IHdl
Cj4+Pj4+IHNpbXBseSBkbyBzb21ldGhpbmcgbGlrZSB0aGlzOgo+Pj4+Pgo+Pj4+PiAJaWYgKGRl
dl9pc19wY2koZGV2KSkKPj4+Pj4gCQlucCA9IGZpbmRfaG9zdF9icmlkZ2UoZGV2KS0+b2Zfbm9k
ZTsKPj4+Pj4gCWVsc2UKPj4+Pj4gCQlucCA9IGRldi0+b2Zfbm9kZTsKPj4+Pj4KPj4+Pj4gPyBJ
J20gbm90IHN1cmUgZXhhY3RseSB3aGF0IGZpbmRfaG9zdF9icmlkZ2UoKSBpcyBjYWxsZWQsIGJ1
dCBJJ20gcHJldHR5Cj4+Pj4+IHN1cmUgdGhhdCBleGlzdHMuCj4+Pj4+Cj4+Pj4+IE9uY2Ugd2Ug
aGF2ZSB0aGF0IHdlIGNhbiBzdGlsbCBpdGVyYXRlIG92ZXIgdGhlIGlvbW11cyBwcm9wZXJ0eSBh
bmQgZG8KPj4+Pj4gbm90IG5lZWQgdG8gcmVseSBvbiB0aGlzIGdsb2JhbCB2YXJpYWJsZS4KPj4+
Pgo+Pj4+IFRoaXMgc291bmRzIG1vcmUgY29tcGxpY2F0ZWQgdGhhbiB0aGUgY3VycmVudCB2YXJp
YW50Lgo+Pj4+Cj4+Pj4gU2Vjb25kbHksIEknbSBhbHJlYWR5IGFib3V0IHRvIHVzZSB0aGUgbmV3
IHRlZ3JhX2dldF9tZW1vcnlfY29udHJvbGxlcigpCj4+Pj4gQVBJIGZvciBhbGwgdGhlIFQyMC8z
MC8xMjQvMjEwIEVNQyBhbmQgZGV2ZnJlcSBkcml2ZXJzLgo+Pj4KPj4+IFdoeSBkbyB3ZSBuZWVk
IGl0IHRoZXJlPyBUaGV5IHNlZW0gdG8gd29yayBmaW5lIHdpdGhvdXQgaXQgcmlnaHQgbm93Lgo+
Pgo+PiBBbGwgdGhlIFRlZ3JhMzAvMTI0LzIxMCBFTUMgZHJpdmVycyBhcmUgYWxyZWFkeSBkdXBs
aWNhdGluZyB0aGF0IE1DCj4+IGxvb2t1cCBjb2RlIGFuZCBvbmx5IHRoZSByZWNlbnQgVDIxMCBk
cml2ZXIgZG9lcyBpdCBwcm9wZXJseS4KPj4KPj4+IElmIGl0IGlzIHJlcXVpcmVkIGZvciBuZXcg
ZnVuY3Rpb25hbGl0eSwgd2UgY2FuIGFsd2F5cyBtYWtlIHRoZSBkZXBlbmRlbnQKPj4+IG9uIGEg
RFQgcmVmZXJlbmNlIHZpYSBwaGFuZGxlIHdpdGhvdXQgYnJlYWtpbmcgYW55IGV4aXN0aW5nIGNv
ZGUuCj4+Cj4+IFRoYXQncyBjb3JyZWN0LCBpdCB3aWxsIGJlIGFsc28gbmVlZGVkIGZvciB0aGUg
bmV3IGZ1bmN0aW9uYWxpdHkgYXMKPj4gd2VsbCwgaGVuY2UgZXZlbiBtb3JlIGRyaXZlcnMgd2ls
bCBuZWVkIHRvIHBlcmZvcm0gdGhlIE1DIGxvb2t1cC4KPiAKPiBJIGRvbid0IGhhdmUgYW55IGlz
c3VlcyB3aXRoIGFkZGluZyBhIGhlbHBlciBpZiB3ZSBuZWVkIGl0IGZyb20gc2V2ZXJhbAo+IGRp
ZmZlcmVudCBsb2NhdGlvbnMuIEJ1dCB0aGUgaGVscGVyIHNob3VsZCBiZSB3b3JraW5nIG9mZiBv
ZiBhIGdpdmVuCj4gZGV2aWNlIGFuZCBsb29rIHVwIHRoZSBkZXZpY2UgdmlhIHRoZSBkZXZpY2Ug
dHJlZSBub2RlIHJlZmVyZW5jZWQgYnkKPiBwaGFuZGxlLiBXZSBhbHJlYWR5IGhhdmUgdGhvc2Ug
cGhhbmRsZXMgaW4gcGxhY2UgZm9yIHRoZSBFTUMgZGV2aWNlcywKPiBhbmQgYW55IG90aGVyIGRl
dmljZSB0aGF0IG5lZWRzIHRvIGludGVyb3BlcmF0ZSB3aXRoIHRoZSBNQyBzaG91bGQgYWxzbwo+
IGdldCBzdWNoIGEgcmVmZXJlbmNlLgo+IAo+PiBJIGRvbid0IHF1aXRlIHVuZGVyc3RhbmQgd2h5
IHlvdSdyZSBhc2tpbmcgZm9yIHRoZSBwaGFuZGxlIHJlZmVyZW5jZSwKPj4gaXQncyBhYnNvbHV0
ZWx5IG5vdCBuZWVkZWQgZm9yIHRoZSBNQyBsb29rdXAgYW5kIHdvbid0IHdvcmsgZm9yIHRoZQo+
IAo+IFdlIG5lZWQgdGhhdCBwaGFuZGxlIGluIG9yZGVyIHRvIGVzdGFibGlzaCBhIGxpbmsgYmV0
d2VlbiB0aGUgZGV2aWNlcy4KPiBZZXMsIHlvdSBjYW4gcHJvYmFibHkgZG8gaXQgd2l0aG91dCB0
aGUgcGhhbmRsZSBhbmQganVzdCBtYXRjaCBieQo+IGNvbXBhdGlibGUgc3RyaW5nLiBCdXQgd2Ug
ZG9uJ3QgZG8gdGhhdCBmb3Igb3RoZXIgdHlwZXMgb2YgZGV2aWNlcwo+IGVpdGhlciwgcmlnaHQ/
IEZvciBhIGRpc3BsYXkgZHJpdmVyIHdlIHJlZmVyZW5jZSB0aGUgYXR0YWNoZWQgcGFuZWwgdmlh
Cj4gcGhhbmRsZSwgYnV0IHdlIGNvdWxkIGFsc28ganVzdCBsb29rIGl0IHVwIHZpYSBuYW1lIG9y
IGFic29sdXRlIHBhdGggb3IKPiBzb21lIG90aGVyIGhldXJpc3RpYy4gQnV0IGEgcGhhbmRsZSBp
cyBqdXN0IGEgbXVjaCBtb3JlIGV4cGxpY2l0IHdheSBvZgo+IGxpbmtpbmcgdGhlIGRldmljZXMs
IHNvIHdoeSBub3QgdXNlIGl0PwoKVGhlcmUgYXJlIGRvemVucyB2YXJpYW50cyBvZiB0aGUgcGFu
ZWxzIGFuZCBzeXN0ZW0gY291bGQgZWFzaWx5IGhhdmUKbW9yZSB0aGFuIG9uZSBwYW5lbCwgaGVu
Y2UgYSBkaXJlY3QgbG9va3VwIGJ5IHBoYW5kbGUgaXMgYSBuYXR1cmFsCmNob2ljZSBmb3IgdGhl
IHBhbmVscy4KCldoaWxlIGFsbCBUZWdyYSBTb0NzIGhhdmUgYSBzaW5nbGUgZml4ZWQgTUMgaW4g
dGhlIHN5c3RlbSwgYW5kIHRodXMsCnRoZXJlIGlzIG5vIHJlYWwgbmVlZCB0byB1c2UgcGhhbmRs
ZSBiZWNhdXNlIHdlIGNhbid0IG1peCB1cCBNQyB3aXRoCmFueXRoaW5nIGVsc2UuCgo+PiBvbGRl
ciBEVHMgaWYgRFQgY2hhbmdlIHdpbGwgYmUgbmVlZGVkLiBQbGVhc2UgZ2l2ZSBhIGRldGFpbGVk
IGV4cGxhbmF0aW9uLgo+IAo+IE5ldyBmdW5jdGlvbmFsaXR5IGRvZXNuJ3QgaGF2ZSB0byB3b3Jr
IHdpdGggb2xkZXIgRFRzLgoKVGhpcyBpcyBmaW5lIGluIGdlbmVyYWwsIGJ1dCBJJ20gYWZyYWlk
IHRoYXQgaW4gdGhpcyBwYXJ0aWN1bGFyIGNhc2Ugd2UKd2lsbCBuZWVkIHRvIGhhdmUgYSBmYWxs
IGJhY2sgYW55d2F5cyBiZWNhdXNlIG90aGVyd2lzZSBpdCBzaG91bGQgYnJlYWsKdGhlIG9sZCBm
dW5jdGlvbmFsaXR5LgoKU28gSSBkb24ndCB0aGluayB0aGF0IHVzaW5nIHBoYW5kbGUgZm9yIHRo
ZSBNQyBkZXZpY2UgZmluZGluZyBpcyByZWFsbHkKd2FycmFudC4KClBoYW5kbGUgaXMga2luZGEg
bW9yZSBhcHBsaWNhYmxlIGZvciB0aGUgY2FzZXMgd2hlcmUgb25seSB0aGUgRFQgbm9kZQpsb29r
dXAgaXMgbmVlZGVkIChub3QgdGhlIGxvb2t1cCBvZiB0aGUgTUMgZGV2aWNlIGRyaXZlciksIGJ1
dCBldmVuIHRoZW4KaXQgaXMgYWxzbyBub3QgbWFuZGF0b3J5LgoKSSBob3BlIHlvdSBhZ3JlZS4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFp
bGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
