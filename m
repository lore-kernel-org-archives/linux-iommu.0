Return-Path: <SRS0=Fz8+=DJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D60C4363D
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 18:04:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F08BA20758
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 18:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqToHEGu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F08BA20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 902DA868C5;
	Fri,  2 Oct 2020 18:04:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZeBIRfR-PEEk; Fri,  2 Oct 2020 18:04:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A7A0686739;
	Fri,  2 Oct 2020 18:04:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C009C0889;
	Fri,  2 Oct 2020 18:04:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0393C0051
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 18:04:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B841B86A11
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 18:04:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ppoKDDkz3NVX for <iommu@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 18:04:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
 [209.85.208.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B8FD986A07
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 18:04:09 +0000 (UTC)
Received: by mail-lj1-f193.google.com with SMTP id w3so1903417ljo.5
 for <iommu@lists.linux-foundation.org>; Fri, 02 Oct 2020 11:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=X7scSAYBn2RRuTNSpT50v9O4203tRjoSiVCg2al9x3c=;
 b=PqToHEGu23DgdZ2llKdlNz3ZnXVa4N0F9hZj5tE+Lt9BmBznCQkbGKrS+3ZAgwLiTQ
 z8Uepf2oXiTPK0szzztUkNBiXYQboC/0JTR2l9O9/KyKai1XQMrckYjXo4IQd6opxd08
 F1IZ9UqH/nIj4+Ptb8ZZ8YFHe+qbysgZ0dNBltffrONxrJslUIzC0WZC3PfETDkWQrIO
 8VnHOrzPW4KW7u6iz7VDoOv1mv1bQBAkGSG+81ZufuwpY4TaTbTb+EJhMZBKW46palov
 zip602g9OLFY8lu/hMb6VfhDvn59v8ykZvs85RXKhC373rvz0oyi8KoIz1zHU903VQqt
 NBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=X7scSAYBn2RRuTNSpT50v9O4203tRjoSiVCg2al9x3c=;
 b=HPD78EJiN2Acpt/nGiuFuy8eDnjK9JtP/dL2Ub3fwojWDIx2/4qkqB8NbUwmq9Eamu
 QeTMHie5IBrU5rMbDSH7S+VoKqyXf72H7CQPoG3nCnchN3odY24VJkC0okBaa5tnbKHE
 5gVMEqt72KsujM+4UF6b1RtPKFtJtdqes9CpXEIbz0fP5JV0Hs22bpTErbLBTdNhM1n2
 pou2wWPo8ZpMYrvv0bOa8vg5gX1KHUPbUlL+WpYd9iRNlnHUPzk8G/r48CMxRTy9Dcuw
 cS94FpRnZCFfHiAizykD+fCqkx3uLNa1E93iQhaski4V8p20j+M6OEDZUojCWFidTaC/
 kRAw==
X-Gm-Message-State: AOAM533JcHULN3rBvplYE4KI+JtpuzrJ8vd53A90pB+oof6HtXcO96yD
 T70iD8lklPljllDtP7lHeWM=
X-Google-Smtp-Source: ABdhPJzMyBnyO4z0Vl+YiIYyNkKiOVb7lX/eB2stEZmEd3qHRupKVS8BM81+BfaTwu0T6e9Cub4tUw==
X-Received: by 2002:a2e:91c5:: with SMTP id u5mr1087333ljg.278.1601661847827; 
 Fri, 02 Oct 2020 11:04:07 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-252.nat.spd-mgts.ru.
 [109.252.91.252])
 by smtp.googlemail.com with ESMTPSA id c22sm454850lff.202.2020.10.02.11.04.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2020 11:04:06 -0700 (PDT)
Subject: Re: [PATCH v4 3/3] iommu/tegra-smmu: Add PCI support
To: Nicolin Chen <nicoleotsuka@gmail.com>
References: <20201002060807.32138-1-nicoleotsuka@gmail.com>
 <20201002060807.32138-4-nicoleotsuka@gmail.com>
 <eba0d5ff-dfb2-7c17-50c2-5709c506f62e@gmail.com>
 <20201002174532.GA29706@Asurada-Nvidia>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <6e4e3cb8-a71b-40b4-7ab6-b3f0d2ec6e0c@gmail.com>
Date: Fri, 2 Oct 2020 21:04:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201002174532.GA29706@Asurada-Nvidia>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, thierry.reding@gmail.com, linux-tegra@vger.kernel.org
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

MDIuMTAuMjAyMCAyMDo0NSwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gT24gRnJpLCBPY3Qg
MDIsIDIwMjAgYXQgMDU6MzU6MjRQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+PiAw
Mi4xMC4yMDIwIDA5OjA4LCBOaWNvbGluIENoZW4g0L/QuNGI0LXRgjoKPj4+IEBAIC04NjUsNyAr
ODY2LDExIEBAIHN0YXRpYyBzdHJ1Y3QgaW9tbXVfZ3JvdXAgKnRlZ3JhX3NtbXVfZGV2aWNlX2dy
b3VwKHN0cnVjdCBkZXZpY2UgKmRldikKPj4+ICAJZ3JvdXAtPnNtbXUgPSBzbW11Owo+Pj4gIAln
cm91cC0+c29jID0gc29jOwo+Pj4gIAo+Pj4gLQlncm91cC0+Z3JvdXAgPSBpb21tdV9ncm91cF9h
bGxvYygpOwo+Pj4gKwlpZiAoZGV2X2lzX3BjaShkZXYpKQo+Pj4gKwkJZ3JvdXAtPmdyb3VwID0g
cGNpX2RldmljZV9ncm91cChkZXYpOwo+Pj4gKwllbHNlCj4+PiArCQlncm91cC0+Z3JvdXAgPSBn
ZW5lcmljX2RldmljZV9ncm91cChkZXYpOwo+Pj4gKwo+Pj4gIAlpZiAoSVNfRVJSKGdyb3VwLT5n
cm91cCkpIHsKPj4+ICAJCWRldm1fa2ZyZWUoc21tdS0+ZGV2LCBncm91cCk7Cj4+PiAgCQltdXRl
eF91bmxvY2soJnNtbXUtPmxvY2spOwo+Pj4gQEAgLTEwNjksMjIgKzEwNzQsMzIgQEAgc3RydWN0
IHRlZ3JhX3NtbXUgKnRlZ3JhX3NtbXVfcHJvYmUoc3RydWN0IGRldmljZSAqZGV2LAo+Pj4gIAlp
b21tdV9kZXZpY2Vfc2V0X2Z3bm9kZSgmc21tdS0+aW9tbXUsIGRldi0+Zndub2RlKTsKPj4+ICAK
Pj4+ICAJZXJyID0gaW9tbXVfZGV2aWNlX3JlZ2lzdGVyKCZzbW11LT5pb21tdSk7Cj4+PiAtCWlm
IChlcnIpIHsKPj4+IC0JCWlvbW11X2RldmljZV9zeXNmc19yZW1vdmUoJnNtbXUtPmlvbW11KTsK
Pj4+IC0JCXJldHVybiBFUlJfUFRSKGVycik7Cj4+PiAtCX0KPj4+ICsJaWYgKGVycikKPj4+ICsJ
CWdvdG8gZXJyX3N5c2ZzOwo+Pj4gIAo+Pj4gIAllcnIgPSBidXNfc2V0X2lvbW11KCZwbGF0Zm9y
bV9idXNfdHlwZSwgJnRlZ3JhX3NtbXVfb3BzKTsKPj4+IC0JaWYgKGVyciA8IDApIHsKPj4+IC0J
CWlvbW11X2RldmljZV91bnJlZ2lzdGVyKCZzbW11LT5pb21tdSk7Cj4+PiAtCQlpb21tdV9kZXZp
Y2Vfc3lzZnNfcmVtb3ZlKCZzbW11LT5pb21tdSk7Cj4+PiAtCQlyZXR1cm4gRVJSX1BUUihlcnIp
Owo+Pj4gLQl9Cj4+PiArCWlmIChlcnIgPCAwKQo+Pj4gKwkJZ290byBlcnJfdW5yZWdpc3RlcjsK
Pj4+ICsKPj4+ICsjaWZkZWYgQ09ORklHX1BDSQo+Pj4gKwllcnIgPSBidXNfc2V0X2lvbW11KCZw
Y2lfYnVzX3R5cGUsICZ0ZWdyYV9zbW11X29wcyk7Cj4+PiArCWlmIChlcnIgPCAwKQo+Pj4gKwkJ
Z290byBlcnJfYnVzX3NldDsKPj4+ICsjZW5kaWYKPj4+ICAKPj4+ICAJaWYgKElTX0VOQUJMRUQo
Q09ORklHX0RFQlVHX0ZTKSkKPj4+ICAJCXRlZ3JhX3NtbXVfZGVidWdmc19pbml0KHNtbXUpOwo+
Pj4gIAo+Pj4gIAlyZXR1cm4gc21tdTsKPj4+ICsKPj4+ICtlcnJfYnVzX3NldDogX19tYXliZV91
bnVzZWQ7Cj4+Cj4+IF9fbWF5YmVfdW51c2VkPwo+IAo+IEluIG9yZGVyIHRvIG11dGUgYSBidWls
ZCB3YXJuaW5nIHdoZW4gQ09ORklHX1BDST1uLi4uCj4gCgpva2F5Cl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
