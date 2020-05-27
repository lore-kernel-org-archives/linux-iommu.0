Return-Path: <SRS0=MQAj=7J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61375C433E1
	for <iommu@archiver.kernel.org>; Wed, 27 May 2020 13:52:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 291602078C
	for <iommu@archiver.kernel.org>; Wed, 27 May 2020 13:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IQd9QRIu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 291602078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 01B0286AB0;
	Wed, 27 May 2020 13:52:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A7TVWnohQbfK; Wed, 27 May 2020 13:52:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 00F6E86505;
	Wed, 27 May 2020 13:52:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6093C088D;
	Wed, 27 May 2020 13:52:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D00C1C016F
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 13:52:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CB6BD87E30
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 13:52:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d2ukI1N3zlUP for <iommu@lists.linux-foundation.org>;
 Wed, 27 May 2020 13:52:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
 [209.85.214.194])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0772587E35
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 13:52:09 +0000 (UTC)
Received: by mail-pl1-f194.google.com with SMTP id t16so10141380plo.7
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 06:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=sVOrxsk18BnSFATyAjPbeo6+7yMbRqTwIElwDUYrAFk=;
 b=IQd9QRIugzIzBpTvp3+gDmqldfXigO2E49gsEa4gWjkW8zQ7okCePzzME85lMseCYp
 C6UogWhM76FwGK5GWiG8mRjoqMxQAiVMmmfU32mB1clNfA4oHsd9jNVbdkKq9iRLaZ6o
 /GSx8wknomZEweg/pRNTs5AEyhz2TlPsVfIh1FVWAsub3p7gsfYfKsWEW0GjuGLOSeH3
 JX/KrTERHguXCxqwKCC2l18gU5RD125PFLl4ooOSVZXxkfqWDt3XB8oULXtxbINGB7jy
 IZ+Ys2oL0/yBtqmoT9wOKg1LwOZXfABmxwNOY7WVGXRfz3jB/ahveiTxn+3ArAeBKNsp
 azNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=sVOrxsk18BnSFATyAjPbeo6+7yMbRqTwIElwDUYrAFk=;
 b=dEf/hu0nfWKezLuolqGP8VX5fMXiBg52EP5fS3+6U1gyz4pcngKF3GoRAbXszc1gkR
 UAzgynKiSa7f9xxPevT3jlCSCSWfz7doeTpEYmSm9aKT+2lSIZTjXw3WQ5eYXv/+aoTx
 SjWFDf9lXxMIcfNtY0b91efvk6XAia2E/jBWYb85DYOhJEvhrZiJzNPTCu5YS8/V0unF
 jD7QsaZZ5B+aBYhAEML+4bB/2o0YXJYyRn2RXMhuf50fYY+jA14rxRP7MCkCJ+K5o+sD
 GRzpz46QfWQnEZV55g+vPReZbo/Y5QRSIKjRyuUOol1CcA/F6GyjGBcQSUFk6ZVakikt
 9u0Q==
X-Gm-Message-State: AOAM533SifL3A3ivOOt8mkVNCpgMWglUBByNt9dDI1pCvrseETHKCGdv
 xHF16C+Ny7Df4tVd6Ndc39XbBg==
X-Google-Smtp-Source: ABdhPJyJEWrfFe5MlHVlgCY+nDX0MeA9yhMhsez39F2xUkBVmUD/N243xLXOBOeIAja47JbP7VfxPQ==
X-Received: by 2002:a17:90a:2ac2:: with SMTP id
 i2mr5055611pjg.80.1590587528565; 
 Wed, 27 May 2020 06:52:08 -0700 (PDT)
Received: from [192.168.11.133] (li1566-229.members.linode.com.
 [139.162.86.229])
 by smtp.gmail.com with ESMTPSA id s15sm2106775pgv.5.2020.05.27.06.51.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2020 06:52:07 -0700 (PDT)
Subject: Re: [PATCH 0/2] Introduce PCI_FIXUP_IOMMU
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1590493749-13823-1-git-send-email-zhangfei.gao@linaro.org>
 <20200527090007.GA179718@kroah.com>
 <CAK8P3a35fjXt1F2hJygup5gWfjPHZTuU+VD69K5uzrNhhgu0Pw@mail.gmail.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <ec994862-ac1c-bb6e-4fe6-ce5bf74f614a@linaro.org>
Date: Wed, 27 May 2020 21:51:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a35fjXt1F2hJygup5gWfjPHZTuU+VD69K5uzrNhhgu0Pw@mail.gmail.com>
Content-Language: en-US
Cc: jean-philippe <jean-philippe@linaro.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 linux-pci <linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, kenneth-lee-2012@foxmail.com,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, Len Brown <lenb@kernel.org>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

CgpPbiAyMDIwLzUvMjcg5LiL5Y2INTo1MywgQXJuZCBCZXJnbWFubiB3cm90ZToKPiBPbiBXZWQs
IE1heSAyNywgMjAyMCBhdCAxMTowMCBBTSBHcmVnIEtyb2FoLUhhcnRtYW4KPiA8Z3JlZ2toQGxp
bnV4Zm91bmRhdGlvbi5vcmc+IHdyb3RlOgo+PiBPbiBUdWUsIE1heSAyNiwgMjAyMCBhdCAwNzo0
OTowN1BNICswODAwLCBaaGFuZ2ZlaSBHYW8gd3JvdGU6Cj4+PiBTb21lIHBsYXRmb3JtIGRldmlj
ZXMgYXBwZWFyIGFzIFBDSSBidXQgYXJlIGFjdHVhbGx5IG9uIHRoZSBBTUJBIGJ1cywKPj4gV2h5
IHdvdWxkIHRoZXNlIGRldmljZXMgbm90IGp1c3Qgc2hvdyB1cCBvbiB0aGUgQU1CQSBidXMgYW5k
IHVzZSBhbGwgb2YKPj4gdGhhdCBsb2dpYyBpbnN0ZWFkIG9mIGJlaW5nIGEgUENJIGRldmljZSBh
bmQgaGF2aW5nIHRvIGdvIHRocm91Z2ggb2RkCj4+IGZpeGVzIGxpa2UgdGhpcz8KPiBUaGVyZSBp
cyBhIGdlbmVyYWwgbW92ZSB0byBoYXZpbmcgaGFyZHdhcmUgYmUgZGlzY292ZXJhYmxlIGV2ZW4g
d2l0aAo+IEFSTSBwcm9jZXNzb3JzLiBIYXZpbmcgb24tY2hpcCBkZXZpY2VzIGJlIGRpc2NvdmVy
YWJsZSB1c2luZyBQQ0kgY29uZmlnCj4gc3BhY2UgaXMgaG93IHg4NiBTb0NzIHVzdWFsbHkgZG8g
aXQsIGFuZCB0aGF0IGlzIGdlbmVyYWxseSBhIGdvb2QgdGhpbmcKPiBhcyBpdCBtZWFucyB3ZSBk
b24ndCBuZWVkIHRvIGRlc2NyaWJlIHRoZW0gaW4gRFQKPgo+IEkgZ3Vlc3MgYXMgdGhlIGhhcmR3
YXJlIGRlc2lnbmVycyBhcmUgc3RpbGwgbGVhcm5pbmcgYWJvdXQgaXQsIHRoaXMgaXMgbm90Cj4g
YWx3YXlzIGRvbmUgY29ycmVjdGx5LiBJbiBnZW5lcmFsLCB3ZSBjYW4gYWxzbyBkZXNjcmliZSBQ
Q0kgZGV2aWNlcyBvbgo+IERUIGFuZCBkbyBmaXh1cHMgZHVyaW5nIHRoZSBwcm9iaW5nIHRoZXJl
LCBidXQgSSBzdXNwZWN0IHRoYXQgd29uJ3Qgd29yawo+IGFzIGVhc2lseSB1c2luZyBBQ1BJIHBy
b2JpbmcsIHNvIHRoZSBmaXh1cCBpcyBrZXllZCBvZmYgdGhlIGhhcmR3YXJlIElELAo+IGFnYWlu
IGFzIGlzIGNvbW1vbiBmb3IgeDg2IG9uLWNoaXAgZGV2aWNlcy4KPgo+ICAgClllcywgdGhhbmtz
IEFybmQgOikKCkluIG9yZGVyIHRvIHVzZSBwYXNpZCwgaW8gcGFnZSBmYXVsdCBoYXMgdG8gYmUg
c3VwcG9ydGVkLAplaXRoZXIgYnkgUENJIFBSSSBmZWF0dXJlIChmcm9tIHBjaSBkZXZpY2UpIG9y
IHN0YWxsIG1vZGUgZnJvbSBzbW11IAoocGxhdGZvcm0gZGV2aWNlKS4KSGVyZSBpcyBsZXR0aW5n
IHN5c3RlbSBrbm93IHRoZSBwbGF0Zm9ybSBkZXZpY2UgY2FuIHN1cHBvcnQgc21tdSBzdGFsbCAK
bW9kZSwgYXMgYSByZXN1bHQgc3VwcG9ydCBwYXNpZC4KV2hpbGUgc3RhbGwgaXMgbm90IGEgcGNp
IGNhcGFiaWxpdHksIHNvIHdlIHVzZSBhIGZpeHVwIGhlcmUuCgpUaGFua3MKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdApp
b21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
