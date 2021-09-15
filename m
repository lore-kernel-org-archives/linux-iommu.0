Return-Path: <SRS0=KP5g=OF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05793C433F5
	for <iommu@archiver.kernel.org>; Wed, 15 Sep 2021 04:46:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A5216121E
	for <iommu@archiver.kernel.org>; Wed, 15 Sep 2021 04:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8A5216121E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4F8D1404A5;
	Wed, 15 Sep 2021 04:46:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QEYSWVtv2D-R; Wed, 15 Sep 2021 04:46:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2C01E404A7;
	Wed, 15 Sep 2021 04:46:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02BB7C000F;
	Wed, 15 Sep 2021 04:46:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F612C000D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 04:46:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0B0418258A
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 04:46:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wkVNwGPf-ILR for <iommu@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 04:45:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EC1EF82572
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 04:45:58 +0000 (UTC)
Received: by mail-pf1-x42d.google.com with SMTP id q22so1649103pfu.0
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 21:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=yYShYH6c0JsEIbmuevIokeH+p63SJCkzU1KxDMZrMRU=;
 b=aVR0vKEEBl2GkFmYWgRMWkkIFywwAeHQ0uBq8YJMAzsGLSKzr8YECn3UeO9udZCnXh
 aPLZiHwVMZM6Or8t1xICwUm8hzLMnfakbvKdtm7bms2+tKnfez98inzHo8axZhR3VXcx
 XcWQYlgeZBpOyO2dWdRSM3GDk0ookjU3pcLyzDmq7+Oh0gGSzeB0hS0wSxumGreJZhin
 dEv/Qj404C0H2XXci+wjczU5GId2LIHpCskxHSX2JJK+pLGNvMlqJ3OkDhtUQDGuric2
 7SfrAMjjz8J/PLU2FVBQfESAmdfPXs+eSS/EQm+WRDo9NILTFLiAsOE69KlWR9WP+fJo
 XmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=yYShYH6c0JsEIbmuevIokeH+p63SJCkzU1KxDMZrMRU=;
 b=JmJ5pkXrFVWjf21cbh7LtnUNlEsqz2lbv0a7IecpMim5R+lhJnAW2VYmYHgIHkKbqg
 FJ/R+0QG3e71gNrB5HGNwDRfPnDn3ynnJKExpaxna37PPI3EI3PQmUkMnWsXPRdetR0h
 73ybhw5/865BlbdfnZsq85mtqKz3CI9zcAYo14Gp0Oxkfm80oo3gR6iHQjiK1jgdsTco
 FBnxcjEkyp59daWZ+giBnBUutGyzL3RZIqL5X7foSHDWh6s0oXoVKgwTxqn7ww9uzXm7
 2y6lfkx3XrB7IRmF2UGUTjfzkq73oPBeJmX15e47e8W4d10hAb8D7KxHwa6hP+vETs39
 Y27w==
X-Gm-Message-State: AOAM532l2E/GSMwfaajYDatg3qKCFcxOprRsCue1UyO8DVJl2CVqkedH
 fmauXMR5Ocgx56yGcNUEi7k=
X-Google-Smtp-Source: ABdhPJyqFB4fVQvokDCtCWklgerVzTHYVn9Fge2j83Lu7zNRFhIjFFh4VRitlCs91WHLWNkIFeAAUQ==
X-Received: by 2002:a05:6a00:2184:b0:3f4:cac4:cf41 with SMTP id
 h4-20020a056a00218400b003f4cac4cf41mr8442290pfi.6.1631681158262; 
 Tue, 14 Sep 2021 21:45:58 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id 132sm11758750pfy.190.2021.09.14.21.45.57
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 14 Sep 2021 21:45:58 -0700 (PDT)
Date: Tue, 14 Sep 2021 21:38:06 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v6 6/6] iommu/tegra-smmu: Add pagetable mappings to debugfs
Message-ID: <20210915043806.GA19185@Asurada-Nvidia>
References: <20210914013858.31192-1-nicoleotsuka@gmail.com>
 <20210914013858.31192-7-nicoleotsuka@gmail.com>
 <31501a62-3312-9f04-3bb8-790d0481746c@gmail.com>
 <20210914184933.GA32705@Asurada-Nvidia>
 <25d68aff-323a-df54-45f9-55b22f3089e0@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <25d68aff-323a-df54-45f9-55b22f3089e0@gmail.com>
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

T24gVHVlLCBTZXAgMTQsIDIwMjEgYXQgMTA6MjA6MzBQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+IDE0LjA5LjIwMjEgMjE6NDksIE5pY29saW4gQ2hlbiDQv9C40YjQtdGCOgo+ID4g
T24gVHVlLCBTZXAgMTQsIDIwMjEgYXQgMDQ6Mjk6MTVQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+ID4+IDE0LjA5LjIwMjEgMDQ6MzgsIE5pY29saW4gQ2hlbiDQv9C40YjQtdGCOgo+
ID4+PiArc3RhdGljIHVuc2lnbmVkIGxvbmcgcGRfcHRfaW5kZXhfaW92YSh1bnNpZ25lZCBpbnQg
cGRfaW5kZXgsIHVuc2lnbmVkIGludCBwdF9pbmRleCkKPiA+Pj4gK3sKPiA+Pj4gKwlyZXR1cm4g
KChkbWFfYWRkcl90KXBkX2luZGV4ICYgKFNNTVVfTlVNX1BERSAtIDEpKSA8PCBTTU1VX1BERV9T
SElGVCB8Cj4gPj4+ICsJICAgICAgICgoZG1hX2FkZHJfdClwdF9pbmRleCAmIChTTU1VX05VTV9Q
VEUgLSAxKSkgPDwgU01NVV9QVEVfU0hJRlQ7Cj4gPj4+ICt9Cj4gPj4KPiA+PiBXZSBrbm93IHRo
YXQgSU9WQSBpcyBmaXhlZCB0byB1MzIgZm9yIHRoaXMgY29udHJvbGxlci4gQ2FuIHdlIGF2b2lk
IGFsbAo+ID4+IHRoZXNlIGRtYV9hZGRyX3QgY2FzdGluZ3M/IEl0IHNob3VsZCBtYWtlIGNvZGUg
Y2xlYW5lciBhIHRhZCwgSU1PLgo+ID4gCj4gPiBUZWdyYTIxMCBhY3R1YWxseSBzdXBwb3J0cyAz
NC1iaXQgSU9WQS4uLgo+ID4gCj4gCj4gSXQgZG9lc24ndC4gMzQtYml0IGlzIFBBLCAzMi1iaXQg
aXMgVkEuCj4gCj4gUXVvdGUgZnJvbSBUMjEwIFRSTToKPiAKPiAiVGhlIFNNTVUgaXMgYSBjZW50
cmFsaXplZCB2aXJ0dWFsLXRvLXBoeXNpY2FsIHRyYW5zbGF0aW9uIGZvciBNU1MuIEl0Cj4gbWFw
cyBhIDMyLWJpdCB2aXJ0dWFsIGFkZHJlc3MgdG8gYSAzNC1iaXQgcGh5c2ljYWwgYWRkcmVzcy4g
SWYgdGhlCj4gY2xpZW50IGFkZHJlc3MgaXMgNDAgYml0cyB0aGVuIGJpdHMgMzk6MzIgYXJlIGln
bm9yZWQuIgoKSWYgeW91IHNjcm9sbCBkb3duIGJ5IGEgY291cGxlIG9mIHNlY3Rpb25zLCB5b3Ug
Y2FuIHNlZSAzNC1iaXQKdmlydHVhbCBhZGRyZXNzZXMgaW4gc2VjdGlvbiAxOC42LjEuMjsgYW5k
IGlmIGNoZWNraW5nIG9uZSBBU0lECnJlZ2lzdGVyLCB5b3UgY2FuIHNlZSBpdCBtZW50aW9uIHRo
ZSBleHRyYSB0d28gYml0cyB2YVszMzozMl0uCgpIb3dldmVyLCB0aGUgZHJpdmVyIGN1cnJlbnRs
eSBzZXRzIGl0cyBnZW9tZXRyeS5hcGVydHVyZV9lbmQgdG8KMzItYml0LCBhbmQgd2UgY2FuIG9u
bHkgZ2V0IDMyLWJpdCBJT1ZBcyB1c2luZyBQREUgYW5kIFBURSBvbmx5LApzbyBJIHRoaW5rIGl0
IHNob3VsZCBiZSBzYWZlIHRvIHJlbW92ZSB0aGUgY2FzdGluZ3MgaGVyZS4gSSdsbAp3YWl0IGZv
ciBhIGNvdXBsZSBvZiBkYXlzIGFuZCBzZWUgaWYgdGhlcmUnZCBiZSBvdGhlciBjb21tZW50cwpm
b3IgbWUgdG8gYWRkcmVzcyBpbiBuZXh0IHZlcnNpb24uCgo+IEV2ZW4gaWYgaXQgc3VwcG9ydGVk
IG1vcmUgdGhhbiAzMmJpdCwgdGhlbiB0aGUgcmV0dXJuZWQgdWxvbmcgaXMgMzJiaXQsCj4gd2hp
Y2ggZG9lc24ndCBtYWtlIHNlbnNlLgoKT24gQVJNNjQgKFRlZ3JhMjEwKSwgaXNuJ3QgdWxvbmcg
NjQtYml0PwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpp
b21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
