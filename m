Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C667C47420
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 00:37:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D06E20754
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 00:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P47UtA2v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D06E20754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4438F860AE;
	Wed, 30 Sep 2020 00:37:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SNK0WtlbfkB9; Wed, 30 Sep 2020 00:36:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D4CF3860C8;
	Wed, 30 Sep 2020 00:36:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C250BC0889;
	Wed, 30 Sep 2020 00:36:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2528C0889
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 00:36:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CCE4B86843
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 00:36:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o2sUEerqaX10 for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 00:36:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2024A86849
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 00:36:58 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id d6so6540646pfn.9
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 17:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=/XM/k7ZAi/BqVvVYF0L63/UmQsPEgJkkXUJGypFWKDU=;
 b=P47UtA2v2KZFC8OmtrYRr+RubNI8j0poiQBEl27RUSlqIZHvxvXNaZJrOgUAt3/rWy
 /DrUlRu5ajujzTy0QpXVoLjbs2pOC0qhJd653+erbItYweTiAKAnQB8KKlMn4SFVekMk
 1Z7bmEmGI3lWhJNa9nnlVv5ZnONiRgJtdr8ska/of3UrsFUIq8qoHWUiyEUf7T1Y2/Rl
 ge/fmwFRy/8aPHgtq99cltj7Ozh1bZ69w9dOrtzODGETl+Dn2WXyKY6PWaKvpR7CIYUN
 jCoBB0//a8qx2Z0WH3B6FPIIzX5Wl1onxeB/XUmRchXFN2/ZQnJnIdd6o/07215abDG8
 c9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=/XM/k7ZAi/BqVvVYF0L63/UmQsPEgJkkXUJGypFWKDU=;
 b=EmQkQfxPbARWTPM4HDxAK0xZIDq27FOLJ2ew7Nf9/7haMAiytbYPKNnnU9kozKar5J
 GJ5o2EGhecKVVhar/biaNVJ8STunP2LhzEqsR9kOCIhGZ9Rq9wpXz0qj4s/MLgAo56GB
 7aV+0M4mgiw6/2w3+QmZsP69FaCrpZ/QNaaHOqKHUn3c75H5dqSl78sOKLsTkROunQbS
 dcTT17FHzBwh0Kla4GxBIoItZcl/qYVp5f6yzAIiSVtcIRKlg2w4/IQfYz4F82F1T7l1
 TuxYb1BTJDnmTkYZ8PTEENqkXzmvNims9eNLA61WKMcN1hPAmOtl0AO2SV4rMQKjswFn
 GEXQ==
X-Gm-Message-State: AOAM533v31GC1ZKWZ6g1IDJnfpsNfPYyqH97oGoJqUpgbH67Sa/orA8A
 z0tbP4iHh8xAaDOAVl0dx5w=
X-Google-Smtp-Source: ABdhPJwtlJ5IyFYYsulqOxLUs9xgA8O8lmGoTtkpvPfrVi3PJDI3ugbs1A/OyAlKFTrYWeSawD1Bog==
X-Received: by 2002:a62:6044:0:b029:151:1a04:895 with SMTP id
 u65-20020a6260440000b02901511a040895mr249217pfb.34.1601426217687; 
 Tue, 29 Sep 2020 17:36:57 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id v205sm7268836pfc.110.2020.09.29.17.36.56
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 29 Sep 2020 17:36:57 -0700 (PDT)
Date: Tue, 29 Sep 2020 17:31:27 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v4 2/2] iommu/tegra-smmu: Expand mutex protection range
Message-ID: <20200930003126.GA31332@Asurada-Nvidia>
References: <20200929061325.10197-1-nicoleotsuka@gmail.com>
 <20200929061325.10197-3-nicoleotsuka@gmail.com>
 <184163e9-01d4-dcc5-0adf-a3d175e56f16@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <184163e9-01d4-dcc5-0adf-a3d175e56f16@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, hch@infradead.org, thierry.reding@gmail.com,
 linux-tegra@vger.kernel.org
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

T24gVHVlLCBTZXAgMjksIDIwMjAgYXQgMDg6NDI6NTJQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+IDI5LjA5LjIwMjAgMDk6MTMsIE5pY29saW4gQ2hlbiDQv9C40YjQtdGCOgo+ID4g
VGhpcyBpcyB1c2VkIHRvIHByb3RlY3QgcG90ZW50aWFsIHJhY2UgY29uZGl0aW9uIGF0IHVzZV9j
b3VudC4KPiA+IHNpbmNlIHByb2JlcyBvZiBjbGllbnQgZHJpdmVycywgY2FsbGluZyBhdHRhY2hf
ZGV2KCksIG1heSBydW4KPiA+IGNvbmN1cnJlbnRseS4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTog
Tmljb2xpbiBDaGVuIDxuaWNvbGVvdHN1a2FAZ21haWwuY29tPgo+ID4gLS0tCj4gCj4gSXQncyBh
bHdheXMgYmV0dGVyIG5vdCB0byBtaXggc3VjY2VzcyBhbmQgZXJyb3IgY29kZSBwYXRocyBpbiBv
cmRlciB0bwo+IGtlZXAgY29kZSByZWFkYWJsZSwgYnV0IG5vdCBhIGJpZyBkZWFsIGluIHRoZSBj
YXNlIG9mIHRoaXMgcGFydGljdWxhcgo+IHBhdGNoIHNpbmNlIHRoZSBjaGFuZ2VkIGNvZGUgaXMg
cXVpdGUgc2ltcGxlLiBQbGVhc2UgdHJ5IHRvIGF2b2lkIGRvaW5nCj4gdGhpcyBpbiB0aGUgZnV0
dXJlIHBhdGNoZXMuCj4gCj4gQWxzbywgcGxlYXNlIG5vdGUgdGhhdCBpbiBnZW5lcmFsIGl0J3Mg
YmV0dGVyIHRvIHVzZSBsb2NrZWQvdW5sb2NrZWQKPiB2ZXJzaW9ucyBmb3IgdGhlIGZ1bmN0aW9u
cyBsaWtlIGl0J3MgYWxyZWFkeSBkb25lIGZvcgo+IHRlZ3JhX3NtbXVfbWFwL3VubWFwLCB0aGlz
IHdpbGwgcmVtb3ZlIHRoZSBuZWVkIHRvIG1haW50YWluIGxvY2tpbmdzIGluCj4gdGhlIGNvZGUu
IFRoZSBjb2RlIHRvdWNoZWQgYnkgdGhpcyBwYXRjaCBkb2Vzbid0IGhhdmUgY29tcGxpY2F0ZWQg
Y29kZQo+IHBhdGhzLCBzbyBpdCdzIGdvb2QgZW5vdWdoIHRvIG1lLgo+IAo+IFJldmlld2VkLWJ5
OiBEbWl0cnkgT3NpcGVua28gPGRpZ2V0eEBnbWFpbC5jb20+CgpPa2F5LiBUaGFua3MgZm9yIHRo
ZSByZXZpZXchCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
