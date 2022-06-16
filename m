Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC4ECCA47A
	for <iommu@archiver.kernel.org>; Thu, 16 Jun 2022 08:15:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 03B9340134;
	Thu, 16 Jun 2022 08:15:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gpDuKTlxGuMc; Thu, 16 Jun 2022 08:15:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D1C0040496;
	Thu, 16 Jun 2022 08:15:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA132C0032;
	Thu, 16 Jun 2022 08:15:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3929AC002D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 08:15:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 20C7C40496
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 08:15:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 12C1Y251vOoM for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jun 2022 08:15:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C4D2840134
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 08:15:09 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id cn20so1100162edb.6
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 01:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=NTbh4MI+QCwbcpkgIpo7198UESJ/mO1+VW3Q06LAB7c=;
 b=jaqw6FnWxB/5UThR+ZDWPxP3LWg0yS0YKOWgNceuoysE3QYfS+oCxZDmNCa3RDthiA
 nkA25n9Yi8JFYV85REMoUBn+G4y6pDSV2DxU42hO4xQRb7+rgdKay4JL4s8VmPBn1nC2
 yF85m7F7VZaH+V+s+cRL0dGTy2NlNoYtbSfZ1CPjfZrocAUyoNrf37+MCeIEcVKY9Mdz
 1i9VibVT2e/BJ4fdVSxoKa4OFM3U6ip5yjEZWjhIfkQsGUiBh6VjTAV2L2vDPEt837o3
 6rPCfBieZXhr+OtkAuMNYQbYzuIY8e5Vdeqa07pg+PV/0s2Uo8oR92+b05AsASWc2IXa
 l2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=NTbh4MI+QCwbcpkgIpo7198UESJ/mO1+VW3Q06LAB7c=;
 b=b9KcECPeYMG2zVg1xDow7sqblrNklw1/PM67lIW3QkIn9VMkLXAp6nNfm57JeJaXVJ
 TK1kGu/HDYGlobYAvYqBxAYlPep5oJ1vg4r4B6wqVQJFDAJ7Yy2rpGIwlK6Bd51viOms
 SsgpKGwoiV/AjJ5nAhUVAeOvMZYgCX2nYsqkboKZW7Izq1iY2Ruwao+ViQ+a3tdBiV8G
 /m1q9JGZ30W0RSAthvduVssBjndunp1hEfIgt7oU4Xf7Kht8K7tmuZgEzCsSWIAVUI6r
 AAf6OmljsARX7di4LcToy4no3uoxSbH1nL/qhQJl/nYedfFsPiq57CCxWw3F7lSZOAVd
 p+Aw==
X-Gm-Message-State: AJIora94YYIZeZFzWm4wSINCk3UY215RdQzjaw7w/1ZMWs9dH28XMbjJ
 fy5fjCt+3RUfY50nGO4SSde+xQ==
X-Google-Smtp-Source: AGRyM1tAV7ubqxgWT2Y3vDm33RYC1UL1k8VL4cdyLifra2KOoXTU0YbVtJhJ79SiTn0ipQMr4EiJtw==
X-Received: by 2002:a05:6402:100c:b0:42d:f407:b050 with SMTP id
 c12-20020a056402100c00b0042df407b050mr4735798edu.39.1655367307984; 
 Thu, 16 Jun 2022 01:15:07 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 s2-20020a1709060d6200b006f3ef214e2csm471585ejh.146.2022.06.16.01.15.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jun 2022 01:15:07 -0700 (PDT)
Date: Thu, 16 Jun 2022 09:14:44 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: Re: [PATCH] uacce: fix concurrency of fops_open and uacce_remove
Message-ID: <YqrmdKNrYTCiS/MC@myrica>
References: <20220610123423.27496-1-zhangfei.gao@linaro.org>
 <Yqn3spLZHpAkQ9Us@myrica>
 <fdc8d8b0-4e04-78f5-1e8a-4cf44c89a37f@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fdc8d8b0-4e04-78f5-1e8a-4cf44c89a37f@linaro.org>
Cc: Yang Shen <shenyang39@huawei.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-crypto@vger.kernel.org, linux-accelerators@lists.ozlabs.org
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

T24gVGh1LCBKdW4gMTYsIDIwMjIgYXQgMTI6MTA6MThQTSArMDgwMCwgWmhhbmdmZWkgR2FvIHdy
b3RlOgo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9taXNjL3VhY2NlL3VhY2NlLmMgYi9kcml2
ZXJzL21pc2MvdWFjY2UvdWFjY2UuYwo+ID4gPiBpbmRleCAyODFjNTQwMDNlZGMuLmI2MjE5YzZi
ZmI0OCAxMDA2NDQKPiA+ID4gLS0tIGEvZHJpdmVycy9taXNjL3VhY2NlL3VhY2NlLmMKPiA+ID4g
KysrIGIvZHJpdmVycy9taXNjL3VhY2NlL3VhY2NlLmMKPiA+ID4gQEAgLTEzNiw5ICsxMzYsMTYg
QEAgc3RhdGljIGludCB1YWNjZV9mb3BzX29wZW4oc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0
IGZpbGUgKmZpbGVwKQo+ID4gPiAgIAlpZiAoIXEpCj4gPiA+ICAgCQlyZXR1cm4gLUVOT01FTTsK
PiA+ID4gKwltdXRleF9sb2NrKCZ1YWNjZS0+cXVldWVzX2xvY2spOwo+ID4gPiArCj4gPiA+ICsJ
aWYgKCF1YWNjZS0+cGFyZW50LT5kcml2ZXIpIHsKPiA+IEkgZG9uJ3QgdGhpbmsgdGhpcyBpcyB1
c2VmdWwsIGJlY2F1c2UgdGhlIGNvcmUgY2xlYXJzIHBhcmVudC0+ZHJpdmVyIGFmdGVyCj4gPiBo
YXZpbmcgcnVuIHVhY2NlX3JlbW92ZSgpOgo+ID4gCj4gPiAgICBybW1vZCBoaXNpX3ppcAkJb3Bl
bigpCj4gPiAgICAgLi4uCQkJCSB1YWNjZV9mb3BzX29wZW4oKQo+ID4gICAgIF9fZGV2aWNlX3Jl
bGVhc2VfZHJpdmVyKCkJICAuLi4KPiA+ICAgICAgcGNpX2RldmljZV9yZW1vdmUoKQo+ID4gICAg
ICAgaGlzaV96aXBfcmVtb3ZlKCkKPiA+ICAgICAgICBoaXNpX3FtX3VuaW5pdCgpCj4gPiAgICAg
ICAgIHVhY2NlX3JlbW92ZSgpCj4gPiAgICAgICAgICAuLi4JCQkgIC4uLgo+ID4gICAgIAkJCQkg
IG11dGV4X2xvY2sodWFjY2UtPnF1ZXVlc19sb2NrKQo+ID4gICAgICAuLi4JCQkJICBpZiAoIXVh
Y2NlLT5wYXJlbnQtPmRyaXZlcikKPiA+ICAgICAgZGV2aWNlX3VuYmluZF9jbGVhbnVwKCkJICAv
KiBkcml2ZXIgc3RpbGwgdmFsaWQsIHByb2NlZWQgKi8KPiA+ICAgICAgIGRldi0+ZHJpdmVyID0g
TlVMTAo+IAo+IFRoZSBjaGVja8KgIGlmICghdWFjY2UtPnBhcmVudC0+ZHJpdmVyKSBpcyByZXF1
aXJlZCwgb3RoZXJ3aXNlIE5VTEwgcG9pbnRlcgo+IG1heSBoYXBwZW4uCgpJIGFncmVlIHdlIG5l
ZWQgc29tZXRoaW5nLCB3aGF0IEkgbWVhbiBpcyB0aGF0IHRoaXMgY2hlY2sgaXMgbm90CnN1ZmZp
Y2llbnQuCgo+IGlvbW11X3N2YV9iaW5kX2RldmljZQo+IGNvbnN0IHN0cnVjdCBpb21tdV9vcHMg
Km9wcyA9IGRldl9pb21tdV9vcHMoZGV2KTvCoCAtPgo+IGRldi0+aW9tbXUtPmlvbW11X2Rldi0+
b3BzCj4gCj4gcm1tb2QgaGFzIG5vIGlzc3VlLCBidXQgcmVtb3ZlIHBhcmVudCBwY2kgZGV2aWNl
IGhhcyB0aGUgaXNzdWUuCgpBaCByaWdodCwgcmVseWluZyBvbiB0aGUgcmV0dXJuIHZhbHVlIG9m
IGJpbmQoKSB3b3VsZG4ndCBiZSBlbm91Z2ggZXZlbiBpZgp3ZSBtYW5kYXRlZCBTVkEuCgpbLi4u
XQo+ID4gCj4gPiBJIHRoaW5rIHdlIG5lZWQgdGhlIGdsb2JhbCB1YWNjZV9tdXRleCB0byBzZXJp
YWxpemUgdWFjY2VfcmVtb3ZlKCkgYW5kCj4gPiB1YWNjZV9mb3BzX29wZW4oKS4gdWFjY2VfcmVt
b3ZlKCkgd291bGQgZG8gZXZlcnl0aGluZywgaW5jbHVkaW5nCj4gPiB4YV9lcmFzZSgpLCB3aGls
ZSBob2xkaW5nIHRoYXQgbXV0ZXguIEFuZCB1YWNjZV9mb3BzX29wZW4oKSB3b3VsZCB0cnkgdG8K
PiA+IG9idGFpbiB0aGUgdWFjY2Ugb2JqZWN0IGZyb20gdGhlIHhhcnJheSB3aGlsZSBob2xkaW5n
IHRoZSBtdXRleCwgd2hpY2gKPiA+IGZhaWxzIGlmIHRoZSB1YWNjZSBvYmplY3QgaXMgYmVpbmcg
cmVtb3ZlZC4KPiAKPiBTaW5jZSBmb3BzX29wZW4gZ2V0IGNoYXIgZGV2aWNlIHJlZmNvdW50LCB1
YWNjZV9yZWxlYXNlIHdpbGwgbm90IGhhcHBlbgo+IHVudGlsIG9wZW4gcmV0dXJucy4KClRoZSBy
ZWZjb3VudCBvbmx5IGVuc3VyZXMgdGhhdCB0aGUgdWFjY2VfZGV2aWNlIG9iamVjdCBpcyBub3Qg
ZnJlZWQgYXMKbG9uZyBhcyB0aGVyZSBhcmUgb3BlbiBmZHMuIEJ1dCB1YWNjZV9yZW1vdmUoKSBj
YW4gcnVuIHdoaWxlIHRoZXJlIGFyZQpvcGVuIGZkcywgb3IgZmRzIGluIHRoZSBwcm9jZXNzIG9m
IGJlaW5nIG9wZW5lZC4gQW5kIGF0ZmVyIHVhY2NlX3JlbW92ZSgpCnJ1bnMsIHRoZSB1YWNjZV9k
ZXZpY2Ugb2JqZWN0IHN0aWxsIGV4aXN0cyBidXQgaXMgbW9zdGx5IHVudXNhYmxlLiBGb3IKZXhh
bXBsZSBvbmNlIHRoZSBtb2R1bGUgaXMgZnJlZWQsIHVhY2NlLT5vcHMgaXMgbm90IHZhbGlkIGFu
eW1vcmUuIEJ1dApjdXJyZW50bHkgdWFjY2VfZm9wc19vcGVuKCkgbWF5IGRlcmVmZXJlbmNlIHRo
ZSBvcHMgaW4gdGhpcyBjYXNlOgoKCXVhY2NlX2ZvcHNfb3BlbigpCgkgaWYgKCF1YWNjZS0+cGFy
ZW50LT5kcml2ZXIpCgkgLyogU3RpbGwgdmFsaWQsIGtlZXAgZ29pbmcgKi8JCQoJIC4uLgkJCQkJ
cm1tb2QKCQkJCQkJIHVhY2NlX3JlbW92ZSgpCgkgLi4uCQkJCQkgZnJlZV9tb2R1bGUoKQoJIHVh
Y2NlLT5vcHMtPmdldF9xdWV1ZSgpIC8qIEJVRyAqLwoKQWNjZXNzaW5nIHVhY2NlLT5vcHMgYWZ0
ZXIgZnJlZV9tb2R1bGUoKSBpcyBhIHVzZS1hZnRlci1mcmVlLiBXZSBuZWVkIGFsbAp0aGUgZm9w
cyB0byBzeW5jaHJvbml6ZSB3aXRoIHVhY2NlX3JlbW92ZSgpIHRvIGVuc3VyZSB0aGV5IGRvbid0
IHVzZSBhbnkKcmVzb3VyY2Ugb2YgdGhlIHBhcmVudCBhZnRlciBpdCdzIGJlZW4gZnJlZWQuIAoK
SSBzZWUgdWFjY2VfZm9wc19wb2xsKCkgbWF5IGhhdmUgdGhlIHNhbWUgcHJvYmxlbSwgYW5kIHNo
b3VsZCBiZSBpbnNpZGUKdWFjY2VfbXV0ZXguCgpUaGFua3MsCkplYW4KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
