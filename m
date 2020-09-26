Return-Path: <SRS0=cnVx=DD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C571C4741F
	for <iommu@archiver.kernel.org>; Sat, 26 Sep 2020 14:49:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CDDC2184D
	for <iommu@archiver.kernel.org>; Sat, 26 Sep 2020 14:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVVIaVs4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CDDC2184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C537E87165;
	Sat, 26 Sep 2020 14:48:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sA-glbuQmN-j; Sat, 26 Sep 2020 14:48:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3D6A887163;
	Sat, 26 Sep 2020 14:48:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29C85C0859;
	Sat, 26 Sep 2020 14:48:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37444C0051
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 14:48:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2FD1D86826
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 14:48:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q9rprYmxUIn4 for <iommu@lists.linux-foundation.org>;
 Sat, 26 Sep 2020 14:48:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
 [209.85.208.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id F2DAA868AC
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 14:48:56 +0000 (UTC)
Received: by mail-lj1-f193.google.com with SMTP id v23so4831170ljd.1
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 07:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4OSLoIvgTYKgG5y/bcFbwHMYscpnTNwdnsVBcUysUWY=;
 b=mVVIaVs4BacQs0AQgvwyFqke2v36x9e78QGTTUtogy5RKUpiKsJGuXDe/sZEYFq2fw
 sK8dP1/moJH16zAvN+ntaQtyqwSQyqN02mDwNi5qtKf7YEqwAIuQ1REHOwkG3Hib8pAH
 EUXGRhjopioQQBM7yKWE4iIdnSpGKZe2Lfg4BAhLMDPqT6dlCggEhZfj+RudZHBgBKyO
 AmpGHQVJURH9X3NSoJEQKBCHLGczyfvDCw1FEOXzGhZu0cTyuFTYtL4+1e4G+9NjpktI
 ISFGuXdGGpdjLIHgHqeNHArXIsYSHRiHqDHNP7TwfwRnLNvzwIH0cVglL1Dc5EHlNvKp
 R7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4OSLoIvgTYKgG5y/bcFbwHMYscpnTNwdnsVBcUysUWY=;
 b=ElZRwd4vUsDYy3EYSQIh1rvf4EZ3iIJ4eH2Z6iwUc1aOhZzydva2Gw4QjwmsV667k7
 IT+wcdFwNQmy+KyLMsmy9uSr6ayChydHfkHA9gr3cyX4c3yLq6acJnPHxw4zma512E02
 AQjKhDjrl7nY5Mal2K2SClKUQJdzLieMDqAifqzR+XDLaOStVDYkCi12ZVkpPmUbAspb
 p75yNQVHv2HBCtD7Z3/xeilzuAsLwz0uA+eDvJcfrINM9G8UsYG0txhtNCcCqL5h2L8D
 3v8ZV83oe6bH/6FNUqBJLEG9MIL2KTcYubghObBVjZBEsy8jPGwhCVRyolcqQYvwildW
 Zmwg==
X-Gm-Message-State: AOAM530VDzjFjTDdkhDMR4nbgvGzgNJYJvxU8H6WWV8TAPJBcMrG22xS
 g9VE1BotypC97W8Aj6vroWxfUcBQlKk=
X-Google-Smtp-Source: ABdhPJwY7G8FOMBEhZy5FRZ4mUUuXJU3s9VtwvIaDkRDccOb3pX1z+sZkkSo10SkAsacRQDjGD13hQ==
X-Received: by 2002:a2e:814c:: with SMTP id t12mr2858344ljg.362.1601131735096; 
 Sat, 26 Sep 2020 07:48:55 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.googlemail.com with ESMTPSA id 191sm1744043lfa.131.2020.09.26.07.48.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Sep 2020 07:48:54 -0700 (PDT)
Subject: Re: [PATCH 5/5] iommu/tegra-smmu: Add pagetable mappings to debugfs
To: Nicolin Chen <nicoleotsuka@gmail.com>, thierry.reding@gmail.com,
 joro@8bytes.org, krzk@kernel.org
References: <20200926080719.6822-1-nicoleotsuka@gmail.com>
 <20200926080719.6822-6-nicoleotsuka@gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0c9ca297-d656-59a5-eefd-00e0c0542c29@gmail.com>
Date: Sat, 26 Sep 2020 17:48:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200926080719.6822-6-nicoleotsuka@gmail.com>
Content-Language: en-US
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, jonathanh@nvidia.com
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

MjYuMDkuMjAyMCAxMTowNywgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Ci4uLgo+ICtzdGF0aWMg
aW50IHRlZ3JhX3NtbXVfbWFwcGluZ3Nfc2hvdyhzdHJ1Y3Qgc2VxX2ZpbGUgKnMsIHZvaWQgKmRh
dGEpCj4gK3sKPiArCXN0cnVjdCB0ZWdyYV9zbW11X2dyb3VwX2RlYnVnICpncm91cF9kZWJ1ZyA9
IHMtPnByaXZhdGU7Cj4gKwljb25zdCBzdHJ1Y3QgdGVncmFfc21tdV9zd2dyb3VwICpncm91cDsK
PiArCXN0cnVjdCB0ZWdyYV9zbW11X2FzICphczsKPiArCXN0cnVjdCB0ZWdyYV9zbW11ICpzbW11
Owo+ICsJaW50IHBkX2luZGV4LCBwdF9pbmRleDsKPiArCXU2NCBwdGVfY291bnQgPSAwOwo+ICsJ
dTMyIHBkZV9jb3VudCA9IDA7Cj4gKwl1MzIgdmFsLCBwdGJfcmVnOwo+ICsJdTMyICpwZDsKPiAr
Cj4gKwlpZiAoIWdyb3VwX2RlYnVnIHx8ICFncm91cF9kZWJ1Zy0+cHJpdiB8fCAhZ3JvdXBfZGVi
dWctPmdyb3VwKQo+ICsJCXJldHVybiAwOwo+ICsKPiArCWdyb3VwID0gZ3JvdXBfZGVidWctPmdy
b3VwOwo+ICsJYXMgPSBncm91cF9kZWJ1Zy0+cHJpdjsKPiArCXNtbXUgPSBhcy0+c21tdTsKPiAr
Cj4gKwl2YWwgPSBzbW11X3JlYWRsKHNtbXUsIGdyb3VwLT5yZWcpICYgU01NVV9BU0lEX0VOQUJM
RTsKPiArCWlmICghdmFsKQo+ICsJCXJldHVybiAwOwo+ICsKPiArCXBkID0gcGFnZV9hZGRyZXNz
KGFzLT5wZCk7Cj4gKwlpZiAoIXBkKQo+ICsJCXJldHVybiAwOwo+ICsKPiArCXNlcV9wcmludGYo
cywgIlxuU1dHUk9VUDogJXNcbkFTSUQ6ICVkXG5yZWc6IDB4JXhcbiIsIGdyb3VwLT5uYW1lLAo+
ICsJCQlhcy0+aWQsIGdyb3VwLT5yZWcpOwo+ICsKPiArCW11dGV4X2xvY2soJnNtbXUtPmxvY2sp
Owo+ICsJc21tdV93cml0ZWwoc21tdSwgYXMtPmlkICYgMHg3ZiwgU01NVV9QVEJfQVNJRCk7Cj4g
KwlwdGJfcmVnID0gc21tdV9yZWFkbChzbW11LCBTTU1VX1BUQl9EQVRBKTsKCkkgdGhpbmsgdGhl
IHdob2xlIHRyYXZlcnNlIG5lZWRzIGEgbG9ja2luZyBwcm90ZWN0aW9uLCBkb2Vzbid0IGl0PwoK
PiArCW11dGV4X3VubG9jaygmc21tdS0+bG9jayk7Cj4gKwo+ICsJc2VxX3ByaW50ZihzLCAiUFRC
X0FTSUQ6IDB4JXhcbmFzLT5wZF9kbWE6IDB4JWxseFxuIiwgcHRiX3JlZywgYXMtPnBkX2RtYSk7
Cj4gKwlzZXFfcHV0cyhzLCAie1xuIik7Cj4gKwo+ICsJZm9yIChwZF9pbmRleCA9IDA7IHBkX2lu
ZGV4IDwgU01NVV9OVU1fUERFOyBwZF9pbmRleCsrKSB7Cj4gKwkJc3RydWN0IHBhZ2UgKnB0Owo+
ICsJCXUzMiAqYWRkcjsKPiArCj4gKwkJaWYgKCFhcy0+Y291bnRbcGRfaW5kZXhdIHx8ICFwZFtw
ZF9pbmRleF0pCj4gKwkJCWNvbnRpbnVlOwo+ICsKPiArCQlwZGVfY291bnQrKzsKPiArCQlwdGVf
Y291bnQgKz0gYXMtPmNvdW50W3BkX2luZGV4XTsKPiArCQlzZXFfcHJpbnRmKHMsICJcdFslZF0g
MHgleCAoJWQpXG4iLAo+ICsJCQkgICBwZF9pbmRleCwgcGRbcGRfaW5kZXhdLCBhcy0+Y291bnRb
cGRfaW5kZXhdKTsKPiArCQlwdCA9IGFzLT5wdHNbcGRfaW5kZXhdOwo+ICsJCWFkZHIgPSBwYWdl
X2FkZHJlc3MocHQpOwoKVGhpcyBuZWVkcyBhcy0+bG9jayBwcm90ZWN0aW9uLgoKPiArCQlzZXFf
cHV0cyhzLCAiXHR7XG4iKTsKPiArCQlzZXFfcHJpbnRmKHMsICJcdFx0JS01cyAlLTRzICUxMnMg
JTEyc1xuIiwgIlBERSIsICJBVFRSIiwgIlBIWVMiLCAiSU9WQSIpOwo+ICsJCWZvciAocHRfaW5k
ZXggPSAwOyBwdF9pbmRleCA8IFNNTVVfTlVNX1BURTsgcHRfaW5kZXgrKykgewo+ICsJCQl1NjQg
aW92YTsKPiArCj4gKwkJCWlmICghYWRkcltwdF9pbmRleF0pCj4gKwkJCQljb250aW51ZTsKPiAr
Cj4gKwkJCWlvdmEgPSAoKGRtYV9hZGRyX3QpcGRfaW5kZXggJiAoU01NVV9OVU1fUERFIC0gMSkp
IDw8IFNNTVVfUERFX1NISUZUOwo+ICsJCQlpb3ZhIHw9ICgoZG1hX2FkZHJfdClwdF9pbmRleCAm
IChTTU1VX05VTV9QVEUgLSAxKSkgPDwgU01NVV9QVEVfU0hJRlQ7Cj4gKwo+ICsJCQlzZXFfcHJp
bnRmKHMsICJcdFx0IyUtNGQgMHglLTR4IDB4JS0xMmxseCAweCUtMTJsbHhcbiIsCj4gKwkJCQkg
ICBwdF9pbmRleCwgYWRkcltwdF9pbmRleF0gPj4gU01NVV9QVEVfQVRUUl9TSElGVCwKPiArCQkJ
CSAgIFNNTVVfUEZOX1BIWVMoYWRkcltwdF9pbmRleF0gJiB+U01NVV9QVEVfQVRUUiksIGlvdmEp
Owo+ICsJCX0KPiArCQlzZXFfcHV0cyhzLCAiXHR9XG4iKTsKPiArCX0KPiArCXNlcV9wdXRzKHMs
ICJ9XG4iKTsKPiArCXNlcV9wcmludGYocywgIlRvdGFsIFBERSBjb3VudDogJWRcbiIsIHBkZV9j
b3VudCk7Cj4gKwlzZXFfcHJpbnRmKHMsICJUb3RhbCBQVEUgY291bnQ6ICVsbGRcbiIsIHB0ZV9j
b3VudCk7Cj4gKwo+ICsJcmV0dXJuIDA7Cj4gK30KPiArCj4gK0RFRklORV9TSE9XX0FUVFJJQlVU
RSh0ZWdyYV9zbW11X21hcHBpbmdzKTsKPiArCj4gIHN0YXRpYyB2b2lkIHRlZ3JhX3NtbXVfZGVi
dWdmc19pbml0KHN0cnVjdCB0ZWdyYV9zbW11ICpzbW11KQo+ICB7Cj4gKwljb25zdCBzdHJ1Y3Qg
dGVncmFfc21tdV9zb2MgKnNvYyA9IHNtbXUtPnNvYzsKPiArCXN0cnVjdCB0ZWdyYV9zbW11X2dy
b3VwX2RlYnVnICpncm91cF9kZWJ1ZzsKPiArCXN0cnVjdCBkZXZpY2UgKmRldiA9IHNtbXUtPmRl
djsKPiArCXN0cnVjdCBkZW50cnkgKmQ7Cj4gKwlpbnQgaTsKPiArCj4gKwlncm91cF9kZWJ1ZyA9
IGRldm1fa3phbGxvYyhkZXYsIHNpemVvZigqZ3JvdXBfZGVidWcpICogc29jLT5udW1fc3dncm91
cHMsIEdGUF9LRVJORUwpOwoKZGV2bV9rY2FsbG9jKCkKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2lvbW11
