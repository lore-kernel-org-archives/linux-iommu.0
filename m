Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C36CC433EF
	for <iommu@archiver.kernel.org>; Fri, 17 Jun 2022 08:20:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C003883EC9;
	Fri, 17 Jun 2022 08:20:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C003883EC9
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PS7hc574
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cP9IyuDVBc7s; Fri, 17 Jun 2022 08:20:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6EA7A83ED2;
	Fri, 17 Jun 2022 08:20:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6EA7A83ED2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 398FBC0032;
	Fri, 17 Jun 2022 08:20:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5B4BC002D
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jun 2022 08:20:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 799CE403BF
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jun 2022 08:20:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 799CE403BF
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=PS7hc574
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FzKVsLjdaISH for <iommu@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 08:20:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8D3FD40185
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8D3FD40185
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jun 2022 08:20:39 +0000 (UTC)
Received: by mail-pl1-x632.google.com with SMTP id d13so3269329plh.13
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jun 2022 01:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=OdNhNfoqdC0FVLit2cDZSs2L6y6qr7vA7s4OIwUXg9k=;
 b=PS7hc574OxdHYQVtA0Z6It9mhv0nnSGL7KhN1FWmFGS4vEhL+Aoql8zsGAu4Vm8gtU
 K67X59H+flFBydVsHR5Myn+4g/p4BgEAE5I3ISsM1Gp0xV8UEsvSeMd0lVT1od526AFX
 AduJhFxXFdSeSYUIkGLiw2HUKABu5y/JUmc0HS8PkC9CsvECgz5h6DR31f4r+n9MC28I
 Ogoh0YMfwvuh4Nbs1S8uaAaaNObhgA8GHoG/eWDxAVbGPdSUIarUqBVacCAwOkA5VIrm
 qgeDRm5ew8uCK0FR+4Vv3xkVLrSy4vGaZh3OI+D+YYfxRIVEIdb0YlUALc7eOJD5ApX+
 4bew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=OdNhNfoqdC0FVLit2cDZSs2L6y6qr7vA7s4OIwUXg9k=;
 b=givKEKBu2bTY6aFeiMSvh4gnKywOmETPUCvWHGcgMpCCDg0TiPqMh8mYoo4uU3f/LM
 nHuPTc6ICJse3TofGWKGQkn1sANgXhzepVpY8RUfsMe+BpkQc2Qj8jvCOZ4jAmEOmps3
 KX0DzRXnbntZFNFqGh8ROxggi5Ok1zds5rDkPpoNrdN6fsG7kSrpE/FN73bmNXfF6Tb7
 sWpJk6E+i3qzd4MNv2335krwLDJmQ/j6xQcB9lXGviOliZJBP+fZd7EvTTLP0NxBeMCX
 DulkX7cP2rwA7/Uu1zXy4iR5IpVszwCWWb1obucvGO0M1YXef7K5h0RFemSFp3+4m33y
 IM6w==
X-Gm-Message-State: AJIora95a4yr2rVwax9GRqgLSC98EuMZwASvP7+4HdlvlroXTe5JSiJw
 xiepOKcgleSWEwtGeSOQp1WHJA==
X-Google-Smtp-Source: AGRyM1uAbkIkSICeQYdBSNboTTqudBkUwBrYaUDh/Hk0+dlw2DMRWzxjJ9PGhUg9G4uOAEBePL0oBA==
X-Received: by 2002:a17:902:b598:b0:168:b0b2:f05a with SMTP id
 a24-20020a170902b59800b00168b0b2f05amr8377071pls.0.1655454038736; 
 Fri, 17 Jun 2022 01:20:38 -0700 (PDT)
Received: from [10.83.0.6] ([199.101.192.187])
 by smtp.gmail.com with ESMTPSA id
 x19-20020a637c13000000b00408c56d3379sm3121430pgc.74.2022.06.17.01.20.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jun 2022 01:20:38 -0700 (PDT)
Subject: Re: [PATCH] uacce: fix concurrency of fops_open and uacce_remove
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220610123423.27496-1-zhangfei.gao@linaro.org>
 <Yqn3spLZHpAkQ9Us@myrica> <fdc8d8b0-4e04-78f5-1e8a-4cf44c89a37f@linaro.org>
 <YqrmdKNrYTCiS/MC@myrica> <d90e8ea5-2f18-2eda-b4b2-711083aa7ecd@linaro.org>
Message-ID: <53b9acef-ad32-d0aa-fa1b-a7cb77a0d088@linaro.org>
Date: Fri, 17 Jun 2022 16:20:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d90e8ea5-2f18-2eda-b4b2-711083aa7ecd@linaro.org>
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

CgpPbiAyMDIyLzYvMTcg5LiL5Y2IMjowNSwgWmhhbmdmZWkgR2FvIHdyb3RlOgo+Cj4KPiBPbiAy
MDIyLzYvMTYg5LiL5Y2INDoxNCwgSmVhbi1QaGlsaXBwZSBCcnVja2VyIHdyb3RlOgo+PiBPbiBU
aHUsIEp1biAxNiwgMjAyMiBhdCAxMjoxMDoxOFBNICswODAwLCBaaGFuZ2ZlaSBHYW8gd3JvdGU6
Cj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21pc2MvdWFjY2UvdWFjY2UuYyBiL2RyaXZlcnMv
bWlzYy91YWNjZS91YWNjZS5jCj4+Pj4+IGluZGV4IDI4MWM1NDAwM2VkYy4uYjYyMTljNmJmYjQ4
IDEwMDY0NAo+Pj4+PiAtLS0gYS9kcml2ZXJzL21pc2MvdWFjY2UvdWFjY2UuYwo+Pj4+PiArKysg
Yi9kcml2ZXJzL21pc2MvdWFjY2UvdWFjY2UuYwo+Pj4+PiBAQCAtMTM2LDkgKzEzNiwxNiBAQCBz
dGF0aWMgaW50IHVhY2NlX2ZvcHNfb3BlbihzdHJ1Y3QgaW5vZGUgCj4+Pj4+ICppbm9kZSwgc3Ry
dWN0IGZpbGUgKmZpbGVwKQo+Pj4+PiDCoMKgwqDCoMKgwqAgaWYgKCFxKQo+Pj4+PiDCoMKgwqDC
oMKgwqDCoMKgwqDCoCByZXR1cm4gLUVOT01FTTsKPj4+Pj4gK8KgwqDCoCBtdXRleF9sb2NrKCZ1
YWNjZS0+cXVldWVzX2xvY2spOwo+Pj4+PiArCj4+Pj4+ICvCoMKgwqAgaWYgKCF1YWNjZS0+cGFy
ZW50LT5kcml2ZXIpIHsKPj4+PiBJIGRvbid0IHRoaW5rIHRoaXMgaXMgdXNlZnVsLCBiZWNhdXNl
IHRoZSBjb3JlIGNsZWFycyAKPj4+PiBwYXJlbnQtPmRyaXZlciBhZnRlcgo+Pj4+IGhhdmluZyBy
dW4gdWFjY2VfcmVtb3ZlKCk6Cj4+Pj4KPj4+PiDCoMKgwqAgcm1tb2QgaGlzaV96aXDCoMKgwqDC
oMKgwqDCoCBvcGVuKCkKPj4+PiDCoMKgwqDCoCAuLi7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB1YWNjZV9mb3BzX29wZW4oKQo+Pj4+IMKgwqDCoMKgIF9fZGV2aWNlX3JlbGVhc2Vf
ZHJpdmVyKCnCoMKgwqDCoMKgIC4uLgo+Pj4+IMKgwqDCoMKgwqAgcGNpX2RldmljZV9yZW1vdmUo
KQo+Pj4+IMKgwqDCoMKgwqDCoCBoaXNpX3ppcF9yZW1vdmUoKQo+Pj4+IMKgwqDCoMKgwqDCoMKg
IGhpc2lfcW1fdW5pbml0KCkKPj4+PiDCoMKgwqDCoMKgwqDCoMKgIHVhY2NlX3JlbW92ZSgpCj4+
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIC4uLsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC4uLgo+
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG11dGV4X2xv
Y2sodWFjY2UtPnF1ZXVlc19sb2NrKQo+Pj4+IMKgwqDCoMKgwqAgLi4uwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIXVhY2NlLT5wYXJlbnQtPmRyaXZlcikKPj4+PiDCoMKg
wqDCoMKgIGRldmljZV91bmJpbmRfY2xlYW51cCgpwqDCoMKgwqDCoCAvKiBkcml2ZXIgc3RpbGwg
dmFsaWQsIHByb2NlZWQgKi8KPj4+PiDCoMKgwqDCoMKgwqAgZGV2LT5kcml2ZXIgPSBOVUxMCj4+
PiBUaGUgY2hlY2vCoCBpZiAoIXVhY2NlLT5wYXJlbnQtPmRyaXZlcikgaXMgcmVxdWlyZWQsIG90
aGVyd2lzZSBOVUxMIAo+Pj4gcG9pbnRlcgo+Pj4gbWF5IGhhcHBlbi4KPj4gSSBhZ3JlZSB3ZSBu
ZWVkIHNvbWV0aGluZywgd2hhdCBJIG1lYW4gaXMgdGhhdCB0aGlzIGNoZWNrIGlzIG5vdAo+PiBz
dWZmaWNpZW50Lgo+Pgo+Pj4gaW9tbXVfc3ZhX2JpbmRfZGV2aWNlCj4+PiBjb25zdCBzdHJ1Y3Qg
aW9tbXVfb3BzICpvcHMgPSBkZXZfaW9tbXVfb3BzKGRldik7wqAgLT4KPj4+IGRldi0+aW9tbXUt
PmlvbW11X2Rldi0+b3BzCj4+Pgo+Pj4gcm1tb2QgaGFzIG5vIGlzc3VlLCBidXQgcmVtb3ZlIHBh
cmVudCBwY2kgZGV2aWNlIGhhcyB0aGUgaXNzdWUuCj4+IEFoIHJpZ2h0LCByZWx5aW5nIG9uIHRo
ZSByZXR1cm4gdmFsdWUgb2YgYmluZCgpIHdvdWxkbid0IGJlIGVub3VnaCAKPj4gZXZlbiBpZgo+
PiB3ZSBtYW5kYXRlZCBTVkEuCj4+Cj4+IFsuLi5dCj4+Pj4gSSB0aGluayB3ZSBuZWVkIHRoZSBn
bG9iYWwgdWFjY2VfbXV0ZXggdG8gc2VyaWFsaXplIHVhY2NlX3JlbW92ZSgpIGFuZAo+Pj4+IHVh
Y2NlX2ZvcHNfb3BlbigpLiB1YWNjZV9yZW1vdmUoKSB3b3VsZCBkbyBldmVyeXRoaW5nLCBpbmNs
dWRpbmcKPj4+PiB4YV9lcmFzZSgpLCB3aGlsZSBob2xkaW5nIHRoYXQgbXV0ZXguIEFuZCB1YWNj
ZV9mb3BzX29wZW4oKSB3b3VsZCAKPj4+PiB0cnkgdG8KPj4+PiBvYnRhaW4gdGhlIHVhY2NlIG9i
amVjdCBmcm9tIHRoZSB4YXJyYXkgd2hpbGUgaG9sZGluZyB0aGUgbXV0ZXgsIHdoaWNoCj4+Pj4g
ZmFpbHMgaWYgdGhlIHVhY2NlIG9iamVjdCBpcyBiZWluZyByZW1vdmVkLgo+Pj4gU2luY2UgZm9w
c19vcGVuIGdldCBjaGFyIGRldmljZSByZWZjb3VudCwgdWFjY2VfcmVsZWFzZSB3aWxsIG5vdCBo
YXBwZW4KPj4+IHVudGlsIG9wZW4gcmV0dXJucy4KPj4gVGhlIHJlZmNvdW50IG9ubHkgZW5zdXJl
cyB0aGF0IHRoZSB1YWNjZV9kZXZpY2Ugb2JqZWN0IGlzIG5vdCBmcmVlZCBhcwo+PiBsb25nIGFz
IHRoZXJlIGFyZSBvcGVuIGZkcy4gQnV0IHVhY2NlX3JlbW92ZSgpIGNhbiBydW4gd2hpbGUgdGhl
cmUgYXJlCj4+IG9wZW4gZmRzLCBvciBmZHMgaW4gdGhlIHByb2Nlc3Mgb2YgYmVpbmcgb3BlbmVk
LiBBbmQgYXRmZXIgCj4+IHVhY2NlX3JlbW92ZSgpCj4+IHJ1bnMsIHRoZSB1YWNjZV9kZXZpY2Ug
b2JqZWN0IHN0aWxsIGV4aXN0cyBidXQgaXMgbW9zdGx5IHVudXNhYmxlLiBGb3IKPj4gZXhhbXBs
ZSBvbmNlIHRoZSBtb2R1bGUgaXMgZnJlZWQsIHVhY2NlLT5vcHMgaXMgbm90IHZhbGlkIGFueW1v
cmUuIEJ1dAo+PiBjdXJyZW50bHkgdWFjY2VfZm9wc19vcGVuKCkgbWF5IGRlcmVmZXJlbmNlIHRo
ZSBvcHMgaW4gdGhpcyBjYXNlOgo+Pgo+PiDCoMKgwqDCoHVhY2NlX2ZvcHNfb3BlbigpCj4+IMKg
wqDCoMKgIGlmICghdWFjY2UtPnBhcmVudC0+ZHJpdmVyKQo+PiDCoMKgwqDCoCAvKiBTdGlsbCB2
YWxpZCwga2VlcCBnb2luZyAqLwo+PiDCoMKgwqDCoCAuLi7CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBybW1vZAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgdWFjY2VfcmVtb3ZlKCkKPj4gwqDCoMKgwqAgLi4uwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmcmVlX21vZHVsZSgpCj4+IMKgwqDCoMKg
IHVhY2NlLT5vcHMtPmdldF9xdWV1ZSgpIC8qIEJVRyAqLwo+Cj4gdWFjY2VfcmVtb3ZlIHNob3Vs
ZCB3YWl0IGZvciB1YWNjZS0+cXVldWVzX2xvY2ssIHVudGlsIGZvcHNfb3BlbiAKPiByZWxlYXNl
IHRoZSBsb2NrLgo+IElmIG9wZW4gaGFwcGVuIGp1c3QgYWZ0ZXIgdGhlIHVhY2NlX3JlbW92ZTog
dW5sb2NrLCB1YWNjZV9iaW5kX3F1ZXVlIAo+IGluIG9wZW4gc2hvdWxkIGZhaWwuCj4KPj4gQWNj
ZXNzaW5nIHVhY2NlLT5vcHMgYWZ0ZXIgZnJlZV9tb2R1bGUoKSBpcyBhIHVzZS1hZnRlci1mcmVl
LiBXZSBuZWVkIAo+PiBhbGwKPiB5b3UgbWVuIHBhcmVudCByZWxlYXNlIHRoZSByZXNvdXJjZXMu
Cj4+IHRoZSBmb3BzIHRvIHN5bmNocm9uaXplIHdpdGggdWFjY2VfcmVtb3ZlKCkgdG8gZW5zdXJl
IHRoZXkgZG9uJ3QgdXNlIGFueQo+PiByZXNvdXJjZSBvZiB0aGUgcGFyZW50IGFmdGVyIGl0J3Mg
YmVlbiBmcmVlZC4KPiBBZnRlciBmb3BzX29wZW4sIGN1cnJlbnRseSB3ZSBhcmUgY291bnRpbmcg
b24gcGFyZW50IGRyaXZlciBzdG9wIGFsbCAKPiBkbWEgZmlyc3QsIHRoZW4gY2FsbCB1YWNjZV9y
ZW1vdmUsIHdoaWNoIGlzIGFzc3VtcHRpb24uCj4gTGlrZSBkcml2ZXJzL2NyeXB0by9oaXNpbGlj
b24vemlwL3ppcF9tYWluLmM6IAo+IGhpc2lfcW1fd2FpdF90YXNrX2ZpbmlzaCwgd2hpY2ggd2ls
bCB3YWl0IHVhY2NlX3JlbGVhc2UuCj4gSWYgY29tbWVudHMgdGhpcyAsIHRoZXJlIG1heSBvdGhl
ciBpc3N1ZSwKPiBVbmFibGUgdG8gaGFuZGxlIGtlcm5lbCBwYWdpbmcgcmVxdWVzdCBhdCB2aXJ0
dWFsIGFkZHJlc3MgCj4gZmZmZjgwMDAwYjcwMDIwNAo+IHBjIDogaGlzaV9xbV9jYWNoZV93Yi5w
YXJ0LjArMHgyYy8weGEwCj4KPj4gSSBzZWUgdWFjY2VfZm9wc19wb2xsKCkgbWF5IGhhdmUgdGhl
IHNhbWUgcHJvYmxlbSwgYW5kIHNob3VsZCBiZSBpbnNpZGUKPj4gdWFjY2VfbXV0ZXguCj4gRG8g
d2UgbmVlZCBjb25zaWRlciB0aGlzLCB1YWNjZV9yZW1vdmUgY2FuIGhhcHBlbiBhbnl0aW1lIGJ1
dCBub3QgCj4gd2FpdGluZyBkbWEgc3RvcD8KPgo+IE5vdCBzdXJlIHVhY2NlX211dGV4IGNhbiBk
byB0aGlzLgo+IEN1cnJlbnRseSB0aGUgc2VxdWVuY2UgaXMKPiBtdXRleF9sb2NrKCZ1YWNjZS0+
cXVldWVzX2xvY2spOwo+IG11dGV4X2xvY2soJnVhY2NlX211dGV4KTsKPgo+IE9yIHdlIHNldCBh
bGwgdGhlIGNhbGxiYWNrcyBvZiB1YWNjZV9vcHMgdG8gTlVMTD8KSG93IGFib3V0IGluIHVhY2Nl
X3JlbW92ZQptdXRleF9sb2NrKCZ1YWNjZV9tdXRleCk7CnVhY2NlLT5vcHMgPSBOVUxMOwptdXRl
eF91bmxvY2soJnVhY2NlX211dGV4KTsKCkFuZCBjaGVjayB1YWNjZS0+b3BzwqAgZmlyc3Qgd2hl
biB1c2luZy4KCk9yIHNldCBhbGwgb3BzIG9mIHVhY2NlLT5vcHMgdG8gTlVMTC4KCj4gTW9kdWxl
X2dldC9wdXQgb25seSB3b3JrcyBmb3IgbW9kdWxlLCBidXQgbm90IGZvciByZW1vdmluZyBkZXZp
Y2UuCj4KPiBUaGFua3MKPgo+Pgo+PiBUaGFua3MsCj4+IEplYW4KPgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
