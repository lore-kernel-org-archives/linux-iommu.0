Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F05C43334
	for <iommu@archiver.kernel.org>; Fri, 17 Jun 2022 06:05:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2F84640606;
	Fri, 17 Jun 2022 06:05:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2F84640606
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=C9coYDLU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D7yNMOpIy3FK; Fri, 17 Jun 2022 06:05:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2DE0140136;
	Fri, 17 Jun 2022 06:05:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2DE0140136
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 040CCC0032;
	Fri, 17 Jun 2022 06:05:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0D38C002D
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jun 2022 06:05:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 812F64189D
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jun 2022 06:05:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 812F64189D
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=C9coYDLU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o4c1Y49N_QlH for <iommu@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 06:05:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B8F694188E
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B8F694188E
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jun 2022 06:05:29 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id d14so75018pjs.3
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 23:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=hr1DvHgRKVwFFs3GnYKSdW/r6E3KQ20avG9OQnOIekI=;
 b=C9coYDLUoKd71hlkBvzPkdaOsLrcAmU67cb+Wb/aq4db4IWuJ45WMqWpHTInqbaWeA
 geGjYU+Hjl6jShCVqNrAP2QBlICq6ApiSLWYvnLLRWR3m1RZtQEnG12AX88R16PR/Z0C
 JxBYVrAUJ5RPXMQnjh0fEUv+dDd/VZvhpWn196R8kWafbO+7PV0mFAqkptyqRCFqMzvE
 PUBYUCbD8YjvsaBjTuwfAaZx/z6Y9hHM3BgVq+tBCBG9MlGhVrsx4XTLsuy0KCgWByhr
 PRzC+tYKAYkObRlTmpSG6YF/Gmbh7xOIzOt7nJOceLLje2Wl6ZvEmRGtBHcMJzAX2arB
 JkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=hr1DvHgRKVwFFs3GnYKSdW/r6E3KQ20avG9OQnOIekI=;
 b=WJd7tmiWrUxWsP3/aexIIKOe3sCireLqe+wJ3BevQDX4s0uxefFscGJKowFHbkISAE
 mDi1qdod0bQwITAH46J9BlKTB+PkinEGeIeR2cCUSrpbu4nkxO9itknBUzYf3ZshZT9A
 2/2MZb/thBHG9bky3nPHca59NngpzL+4aai24XRUW3WsI0Ebz9F6fcyJRN8PBR7R9WEe
 EQmRwvBJjOwtOFxx5PF2x+Pe6FGZzGXSATSA7/m2uez9Co4Il0G5Td6Z7amSQPO0RKfs
 m+EHQ1/LcrzvCceOXx49ngF/CiIiPas+4uDlyAqFREK/B86tucEM95WpP12xEIDaZEF1
 QnSA==
X-Gm-Message-State: AJIora/3GR61LxeT+gGh6jQhGIC/CSqGcCPAzU4fH3NuAcT7UkBscXZG
 Vatr7o26cgJs4ohT8cOp3aLMaA==
X-Google-Smtp-Source: AGRyM1uiaMIGymdgFePwN95624WGlKC3MieAgDLn29xOGvCxCRUevfFmDABWgQ4fRn7G9pR0FV2CFw==
X-Received: by 2002:a17:90b:1986:b0:1ec:71f6:5fd9 with SMTP id
 mv6-20020a17090b198600b001ec71f65fd9mr2954395pjb.188.1655445928835; 
 Thu, 16 Jun 2022 23:05:28 -0700 (PDT)
Received: from [10.83.0.6] ([199.101.192.187])
 by smtp.gmail.com with ESMTPSA id
 y11-20020a170902d64b00b00161955fe0d5sm2606256plh.274.2022.06.16.23.05.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jun 2022 23:05:28 -0700 (PDT)
Subject: Re: [PATCH] uacce: fix concurrency of fops_open and uacce_remove
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220610123423.27496-1-zhangfei.gao@linaro.org>
 <Yqn3spLZHpAkQ9Us@myrica> <fdc8d8b0-4e04-78f5-1e8a-4cf44c89a37f@linaro.org>
 <YqrmdKNrYTCiS/MC@myrica>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <d90e8ea5-2f18-2eda-b4b2-711083aa7ecd@linaro.org>
Date: Fri, 17 Jun 2022 14:05:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YqrmdKNrYTCiS/MC@myrica>
Content-Language: en-US
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

CgpPbiAyMDIyLzYvMTYg5LiL5Y2INDoxNCwgSmVhbi1QaGlsaXBwZSBCcnVja2VyIHdyb3RlOgo+
IE9uIFRodSwgSnVuIDE2LCAyMDIyIGF0IDEyOjEwOjE4UE0gKzA4MDAsIFpoYW5nZmVpIEdhbyB3
cm90ZToKPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9taXNjL3VhY2NlL3VhY2NlLmMgYi9kcml2
ZXJzL21pc2MvdWFjY2UvdWFjY2UuYwo+Pj4+IGluZGV4IDI4MWM1NDAwM2VkYy4uYjYyMTljNmJm
YjQ4IDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMvbWlzYy91YWNjZS91YWNjZS5jCj4+Pj4gKysr
IGIvZHJpdmVycy9taXNjL3VhY2NlL3VhY2NlLmMKPj4+PiBAQCAtMTM2LDkgKzEzNiwxNiBAQCBz
dGF0aWMgaW50IHVhY2NlX2ZvcHNfb3BlbihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmls
ZSAqZmlsZXApCj4+Pj4gICAgCWlmICghcSkKPj4+PiAgICAJCXJldHVybiAtRU5PTUVNOwo+Pj4+
ICsJbXV0ZXhfbG9jaygmdWFjY2UtPnF1ZXVlc19sb2NrKTsKPj4+PiArCj4+Pj4gKwlpZiAoIXVh
Y2NlLT5wYXJlbnQtPmRyaXZlcikgewo+Pj4gSSBkb24ndCB0aGluayB0aGlzIGlzIHVzZWZ1bCwg
YmVjYXVzZSB0aGUgY29yZSBjbGVhcnMgcGFyZW50LT5kcml2ZXIgYWZ0ZXIKPj4+IGhhdmluZyBy
dW4gdWFjY2VfcmVtb3ZlKCk6Cj4+Pgo+Pj4gICAgIHJtbW9kIGhpc2lfemlwCQlvcGVuKCkKPj4+
ICAgICAgLi4uCQkJCSB1YWNjZV9mb3BzX29wZW4oKQo+Pj4gICAgICBfX2RldmljZV9yZWxlYXNl
X2RyaXZlcigpCSAgLi4uCj4+PiAgICAgICBwY2lfZGV2aWNlX3JlbW92ZSgpCj4+PiAgICAgICAg
aGlzaV96aXBfcmVtb3ZlKCkKPj4+ICAgICAgICAgaGlzaV9xbV91bmluaXQoKQo+Pj4gICAgICAg
ICAgdWFjY2VfcmVtb3ZlKCkKPj4+ICAgICAgICAgICAuLi4JCQkgIC4uLgo+Pj4gICAgICAJCQkJ
ICBtdXRleF9sb2NrKHVhY2NlLT5xdWV1ZXNfbG9jaykKPj4+ICAgICAgIC4uLgkJCQkgIGlmICgh
dWFjY2UtPnBhcmVudC0+ZHJpdmVyKQo+Pj4gICAgICAgZGV2aWNlX3VuYmluZF9jbGVhbnVwKCkJ
ICAvKiBkcml2ZXIgc3RpbGwgdmFsaWQsIHByb2NlZWQgKi8KPj4+ICAgICAgICBkZXYtPmRyaXZl
ciA9IE5VTEwKPj4gVGhlIGNoZWNrwqAgaWYgKCF1YWNjZS0+cGFyZW50LT5kcml2ZXIpIGlzIHJl
cXVpcmVkLCBvdGhlcndpc2UgTlVMTCBwb2ludGVyCj4+IG1heSBoYXBwZW4uCj4gSSBhZ3JlZSB3
ZSBuZWVkIHNvbWV0aGluZywgd2hhdCBJIG1lYW4gaXMgdGhhdCB0aGlzIGNoZWNrIGlzIG5vdAo+
IHN1ZmZpY2llbnQuCj4KPj4gaW9tbXVfc3ZhX2JpbmRfZGV2aWNlCj4+IGNvbnN0IHN0cnVjdCBp
b21tdV9vcHMgKm9wcyA9IGRldl9pb21tdV9vcHMoZGV2KTvCoCAtPgo+PiBkZXYtPmlvbW11LT5p
b21tdV9kZXYtPm9wcwo+Pgo+PiBybW1vZCBoYXMgbm8gaXNzdWUsIGJ1dCByZW1vdmUgcGFyZW50
IHBjaSBkZXZpY2UgaGFzIHRoZSBpc3N1ZS4KPiBBaCByaWdodCwgcmVseWluZyBvbiB0aGUgcmV0
dXJuIHZhbHVlIG9mIGJpbmQoKSB3b3VsZG4ndCBiZSBlbm91Z2ggZXZlbiBpZgo+IHdlIG1hbmRh
dGVkIFNWQS4KPgo+IFsuLi5dCj4+PiBJIHRoaW5rIHdlIG5lZWQgdGhlIGdsb2JhbCB1YWNjZV9t
dXRleCB0byBzZXJpYWxpemUgdWFjY2VfcmVtb3ZlKCkgYW5kCj4+PiB1YWNjZV9mb3BzX29wZW4o
KS4gdWFjY2VfcmVtb3ZlKCkgd291bGQgZG8gZXZlcnl0aGluZywgaW5jbHVkaW5nCj4+PiB4YV9l
cmFzZSgpLCB3aGlsZSBob2xkaW5nIHRoYXQgbXV0ZXguIEFuZCB1YWNjZV9mb3BzX29wZW4oKSB3
b3VsZCB0cnkgdG8KPj4+IG9idGFpbiB0aGUgdWFjY2Ugb2JqZWN0IGZyb20gdGhlIHhhcnJheSB3
aGlsZSBob2xkaW5nIHRoZSBtdXRleCwgd2hpY2gKPj4+IGZhaWxzIGlmIHRoZSB1YWNjZSBvYmpl
Y3QgaXMgYmVpbmcgcmVtb3ZlZC4KPj4gU2luY2UgZm9wc19vcGVuIGdldCBjaGFyIGRldmljZSBy
ZWZjb3VudCwgdWFjY2VfcmVsZWFzZSB3aWxsIG5vdCBoYXBwZW4KPj4gdW50aWwgb3BlbiByZXR1
cm5zLgo+IFRoZSByZWZjb3VudCBvbmx5IGVuc3VyZXMgdGhhdCB0aGUgdWFjY2VfZGV2aWNlIG9i
amVjdCBpcyBub3QgZnJlZWQgYXMKPiBsb25nIGFzIHRoZXJlIGFyZSBvcGVuIGZkcy4gQnV0IHVh
Y2NlX3JlbW92ZSgpIGNhbiBydW4gd2hpbGUgdGhlcmUgYXJlCj4gb3BlbiBmZHMsIG9yIGZkcyBp
biB0aGUgcHJvY2VzcyBvZiBiZWluZyBvcGVuZWQuIEFuZCBhdGZlciB1YWNjZV9yZW1vdmUoKQo+
IHJ1bnMsIHRoZSB1YWNjZV9kZXZpY2Ugb2JqZWN0IHN0aWxsIGV4aXN0cyBidXQgaXMgbW9zdGx5
IHVudXNhYmxlLiBGb3IKPiBleGFtcGxlIG9uY2UgdGhlIG1vZHVsZSBpcyBmcmVlZCwgdWFjY2Ut
Pm9wcyBpcyBub3QgdmFsaWQgYW55bW9yZS4gQnV0Cj4gY3VycmVudGx5IHVhY2NlX2ZvcHNfb3Bl
bigpIG1heSBkZXJlZmVyZW5jZSB0aGUgb3BzIGluIHRoaXMgY2FzZToKPgo+IAl1YWNjZV9mb3Bz
X29wZW4oKQo+IAkgaWYgKCF1YWNjZS0+cGFyZW50LT5kcml2ZXIpCj4gCSAvKiBTdGlsbCB2YWxp
ZCwga2VlcCBnb2luZyAqLwkJCj4gCSAuLi4JCQkJCXJtbW9kCj4gCQkJCQkJIHVhY2NlX3JlbW92
ZSgpCj4gCSAuLi4JCQkJCSBmcmVlX21vZHVsZSgpCj4gCSB1YWNjZS0+b3BzLT5nZXRfcXVldWUo
KSAvKiBCVUcgKi8KCnVhY2NlX3JlbW92ZSBzaG91bGQgd2FpdCBmb3IgdWFjY2UtPnF1ZXVlc19s
b2NrLCB1bnRpbCBmb3BzX29wZW4gcmVsZWFzZSAKdGhlIGxvY2suCklmIG9wZW4gaGFwcGVuIGp1
c3QgYWZ0ZXIgdGhlIHVhY2NlX3JlbW92ZTogdW5sb2NrLCB1YWNjZV9iaW5kX3F1ZXVlIGluIApv
cGVuIHNob3VsZCBmYWlsLgoKPiBBY2Nlc3NpbmcgdWFjY2UtPm9wcyBhZnRlciBmcmVlX21vZHVs
ZSgpIGlzIGEgdXNlLWFmdGVyLWZyZWUuIFdlIG5lZWQgYWxsCnlvdSBtZW4gcGFyZW50IHJlbGVh
c2UgdGhlIHJlc291cmNlcy4KPiB0aGUgZm9wcyB0byBzeW5jaHJvbml6ZSB3aXRoIHVhY2NlX3Jl
bW92ZSgpIHRvIGVuc3VyZSB0aGV5IGRvbid0IHVzZSBhbnkKPiByZXNvdXJjZSBvZiB0aGUgcGFy
ZW50IGFmdGVyIGl0J3MgYmVlbiBmcmVlZC4KQWZ0ZXIgZm9wc19vcGVuLCBjdXJyZW50bHkgd2Ug
YXJlIGNvdW50aW5nIG9uIHBhcmVudCBkcml2ZXIgc3RvcCBhbGwgZG1hIApmaXJzdCwgdGhlbiBj
YWxsIHVhY2NlX3JlbW92ZSwgd2hpY2ggaXMgYXNzdW1wdGlvbi4KTGlrZSBkcml2ZXJzL2NyeXB0
by9oaXNpbGljb24vemlwL3ppcF9tYWluLmM6IGhpc2lfcW1fd2FpdF90YXNrX2ZpbmlzaCwgCndo
aWNoIHdpbGwgd2FpdCB1YWNjZV9yZWxlYXNlLgpJZiBjb21tZW50cyB0aGlzICwgdGhlcmUgbWF5
IG90aGVyIGlzc3VlLApVbmFibGUgdG8gaGFuZGxlIGtlcm5lbCBwYWdpbmcgcmVxdWVzdCBhdCB2
aXJ0dWFsIGFkZHJlc3MgZmZmZjgwMDAwYjcwMDIwNApwYyA6IGhpc2lfcW1fY2FjaGVfd2IucGFy
dC4wKzB4MmMvMHhhMAoKPiBJIHNlZSB1YWNjZV9mb3BzX3BvbGwoKSBtYXkgaGF2ZSB0aGUgc2Ft
ZSBwcm9ibGVtLCBhbmQgc2hvdWxkIGJlIGluc2lkZQo+IHVhY2NlX211dGV4LgpEbyB3ZSBuZWVk
IGNvbnNpZGVyIHRoaXMsIHVhY2NlX3JlbW92ZSBjYW4gaGFwcGVuIGFueXRpbWUgYnV0IG5vdCAK
d2FpdGluZyBkbWEgc3RvcD8KCk5vdCBzdXJlIHVhY2NlX211dGV4IGNhbiBkbyB0aGlzLgpDdXJy
ZW50bHkgdGhlIHNlcXVlbmNlIGlzCm11dGV4X2xvY2soJnVhY2NlLT5xdWV1ZXNfbG9jayk7Cm11
dGV4X2xvY2soJnVhY2NlX211dGV4KTsKCk9yIHdlIHNldCBhbGwgdGhlIGNhbGxiYWNrcyBvZiB1
YWNjZV9vcHMgdG8gTlVMTD8KTW9kdWxlX2dldC9wdXQgb25seSB3b3JrcyBmb3IgbW9kdWxlLCBi
dXQgbm90IGZvciByZW1vdmluZyBkZXZpY2UuCgpUaGFua3MKCj4KPiBUaGFua3MsCj4gSmVhbgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFp
bGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
