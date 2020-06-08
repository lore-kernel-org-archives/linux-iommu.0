Return-Path: <SRS0=28v9=7V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2298FC433E0
	for <iommu@archiver.kernel.org>; Mon,  8 Jun 2020 02:54:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC7BA2075A
	for <iommu@archiver.kernel.org>; Mon,  8 Jun 2020 02:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="izDTLbNF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC7BA2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9357A85BB8;
	Mon,  8 Jun 2020 02:54:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9ZW0IgPAmXEO; Mon,  8 Jun 2020 02:54:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 723868559B;
	Mon,  8 Jun 2020 02:54:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4EF85C0890;
	Mon,  8 Jun 2020 02:54:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7CF0C016F
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 02:54:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CA607855A1
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 02:54:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bI1BhJf_vpED for <iommu@lists.linux-foundation.org>;
 Mon,  8 Jun 2020 02:54:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 727448559B
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 02:54:30 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id n9so6091606plk.1
 for <iommu@lists.linux-foundation.org>; Sun, 07 Jun 2020 19:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=TNiiby0GhibJHmG02ytGWtb3GrXv/h2IE3SFE6qK8wY=;
 b=izDTLbNFapAPFawYa8bP5L1UpCxlkSTCCzx2ye/9STM1DqXymdysNnGkX12FV0/OIo
 tKcjXEIEuxSNO572pWS545T9DoQqGqTM8DmMcj/pjObZb/s4KuucXPV8lxnGJsPOEWOP
 creFxg4Q8lnO5UPN6FiY9AkscKdJteM1nKY+Qmci5RctGzZp1Lm8RhpxAeqkzQiUCQxI
 Gn/htYffz0hnLWeWv7zjKwwzU0TiNbE2IVaAoUldJmQdAcEGN9qicP3+rskQKiUOfzQ9
 T1+IF9bYkLx6QP/gZ6BWN651hoOpft0Cc6Lq2cjMJoEoVussc3m5Gv9e47HSM5NkG+Yl
 PSSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=TNiiby0GhibJHmG02ytGWtb3GrXv/h2IE3SFE6qK8wY=;
 b=rAI/pNflj5y/TM+VICnEWGhYYrjCC6Q7uBPEtrQLzvZ6Nq2Yuej3JL+PsfvMXprVcV
 Q2zlFpZLvQdwSQKOF4ZAqyNQ+rVh5uTmooCueRqJ5YzxT4lAhLHKkDv3BDZFqEij2OS8
 Svf1WqEngyZc+Fpb9hb8e/MPhFSvlqTY+cz4VpmxPPLoMl/SYeTN6fx2T0aL6KfXVjXh
 qpRa1my/MEbm16EqJhHyuz+AoxKKk5Dk6SJVKpA480jgjPDiIwkXvxeMa+LnmSwPuH3l
 A6t1moOUOmmG0l2xrYszoSklwKwlsl/m0bL377Kvkx/Y5f5HKpdvi2s6He/UGlZUpJMI
 9ZOw==
X-Gm-Message-State: AOAM530TR/Dy5u1o67YE2FA1RA/2XttHtQ4YaRhIZDy1Kv/hyjmozRQI
 0xHPsCJYhxbiMI2R0/iDIKmtAg==
X-Google-Smtp-Source: ABdhPJxkqD1zFPHkx/wch8a4hS4Dcd7qZB1Ug7k+ig+u/wKNnkcnbqH/JdvGWQP6MIHxl1bz+Ni7fQ==
X-Received: by 2002:a17:90a:f3c4:: with SMTP id
 ha4mr15260604pjb.18.1591584870012; 
 Sun, 07 Jun 2020 19:54:30 -0700 (PDT)
Received: from [10.80.2.98] ([45.135.186.73])
 by smtp.gmail.com with ESMTPSA id t9sm9533489pjs.16.2020.06.07.19.54.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Jun 2020 19:54:29 -0700 (PDT)
Subject: Re: [PATCH 0/2] Introduce PCI_FIXUP_IOMMU
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20200605231909.GA1155454@bjorn-Precision-5520>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <be91b0f0-c685-789d-6868-1c8ebd62b770@linaro.org>
Date: Mon, 8 Jun 2020 10:54:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200605231909.GA1155454@bjorn-Precision-5520>
Content-Language: en-US
Cc: jean-philippe <jean-philippe@linaro.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
 linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hanjun Guo <guohanjun@huawei.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-acpi@vger.kernel.org, linux-crypto@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 kenneth-lee-2012@foxmail.com, linux-arm-kernel@lists.infradead.org,
 Len Brown <lenb@kernel.org>
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

SGksIEJqb3JuCgpPbiAyMDIwLzYvNiDkuIrljYg3OjE5LCBCam9ybiBIZWxnYWFzIHdyb3RlOgo+
IE9uIFRodSwgSnVuIDA0LCAyMDIwIGF0IDA5OjMzOjA3UE0gKzA4MDAsIFpoYW5nZmVpIEdhbyB3
cm90ZToKPj4gT24gMjAyMC82LzIg5LiK5Y2IMTo0MSwgQmpvcm4gSGVsZ2FhcyB3cm90ZToKPj4+
IE9uIFRodSwgTWF5IDI4LCAyMDIwIGF0IDA5OjMzOjQ0QU0gKzAyMDAsIEpvZXJnIFJvZWRlbCB3
cm90ZToKPj4+PiBPbiBXZWQsIE1heSAyNywgMjAyMCBhdCAwMToxODo0MlBNIC0wNTAwLCBCam9y
biBIZWxnYWFzIHdyb3RlOgo+Pj4+PiBJcyB0aGlzIHNsb3dkb3duIHNpZ25pZmljYW50PyAgV2Ug
YWxyZWFkeSBpdGVyYXRlIG92ZXIgZXZlcnkgZGV2aWNlCj4+Pj4+IHdoZW4gYXBwbHlpbmcgUENJ
X0ZJWFVQX0ZJTkFMIHF1aXJrcywgc28gaWYgd2UgdXNlZCB0aGUgZXhpc3RpbmcKPj4+Pj4gUENJ
X0ZJWFVQX0ZJTkFMLCB3ZSB3b3VsZG4ndCBiZSBhZGRpbmcgYSBuZXcgbG9vcC4gIFdlIHdvdWxk
IG9ubHkgYmUKPj4+Pj4gYWRkaW5nIHR3byBtb3JlIGl0ZXJhdGlvbnMgdG8gdGhlIGxvb3AgaW4g
cGNpX2RvX2ZpeHVwcygpIHRoYXQgdHJpZXMKPj4+Pj4gdG8gbWF0Y2ggcXVpcmtzIGFnYWluc3Qg
dGhlIGN1cnJlbnQgZGV2aWNlLiAgSSBkb3VidCB0aGF0IHdvdWxkIGJlIGEKPj4+Pj4gbWVhc3Vy
YWJsZSBzbG93ZG93bi4KPj4+PiBJIGRvbid0IGtub3cgaG93IHNpZ25pZmljYW50IGl0IGlzLCBi
dXQgSSByZW1lbWJlciBwZW9wbGUgY29tcGxhaW5pbmcKPj4+PiBhYm91dCBhZGRpbmcgbmV3IFBD
SSBxdWlya3MgYmVjYXVzZSBpdCB0YWtlcyB0b28gbG9uZyBmb3IgdGhlbSB0byBydW4KPj4+PiB0
aGVtIGFsbC4gVGhhdCB3YXMgaW4gdGhlIGRpc2N1c3Npb24gYWJvdXQgdGhlIHF1aXJrIGRpc2Fi
bGluZyBBVFMgb24KPj4+PiBBTUQgU3RvbmV5IHN5c3RlbXMuCj4+Pj4KPj4+PiBTbyBpdCBwcm9i
YWJseSBkZXBlbmRzIG9uIGhvdyBtYW55IFBDSSBkZXZpY2VzIGFyZSBpbiB0aGUgc3lzdGVtIHdo
ZXRoZXIKPj4+PiBpdCBjYXVzZXMgYW55IG1lYXN1cmVhYmxlIHNsb3dkb3duLgo+Pj4gSSBmb3Vu
ZCB0aGlzIFsxXSBmcm9tIFBhdWwgTWVuemVsLCB3aGljaCB3YXMgYSBzbG93ZG93biBjYXVzZWQg
YnkKPj4+IHF1aXJrX3VzYl9lYXJseV9oYW5kb2ZmKCkuICBJIHRoaW5rIHRoZSByZWFsIHByb2Js
ZW0gaXMgaW5kaXZpZHVhbAo+Pj4gcXVpcmtzIHRoYXQgdGFrZSBhIGxvbmcgdGltZS4KPj4+Cj4+
PiBUaGUgUENJX0ZJWFVQX0lPTU1VIHRoaW5ncyB3ZSdyZSB0YWxraW5nIGFib3V0IHNob3VsZCBi
ZSBmYXN0LCBhbmQgb2YKPj4+IGNvdXJzZSwgdGhleSdyZSBvbmx5IHJ1biBmb3IgbWF0Y2hpbmcg
ZGV2aWNlcyBhbnl3YXkuICBTbyBJJ2QgcmF0aGVyCj4+PiBrZWVwIHRoZW0gYXMgUENJX0ZJWFVQ
X0ZJTkFMIHRoYW4gYWRkIGEgd2hvbGUgbmV3IHBoYXNlLgo+Pj4KPj4gVGhhbmtzIEJqb3JuIGZv
ciB0YWtpbmcgdGltZSBmb3IgdGhpcy4KPj4gSWYgc28sIGl0IHdvdWxkIGJlIG11Y2ggc2ltcGxl
ci4KPj4KPj4gKysrIGIvZHJpdmVycy9pb21tdS9pb21tdS5jCj4+IEBAIC0yNDE4LDYgKzI0MTgs
MTAgQEAgaW50IGlvbW11X2Z3c3BlY19pbml0KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0Cj4+
IGZ3bm9kZV9oYW5kbGUgKmlvbW11X2Z3bm9kZSwKPj4gIMKgwqDCoMKgwqDCoMKgIGZ3c3BlYy0+
aW9tbXVfZndub2RlID0gaW9tbXVfZndub2RlOwo+PiAgwqDCoMKgwqDCoMKgwqAgZndzcGVjLT5v
cHMgPSBvcHM7Cj4+ICDCoMKgwqDCoMKgwqDCoCBkZXZfaW9tbXVfZndzcGVjX3NldChkZXYsIGZ3
c3BlYyk7Cj4+ICsKPj4gK8KgwqDCoMKgwqDCoCBpZiAoZGV2X2lzX3BjaShkZXYpKQo+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwY2lfZml4dXBfZGV2aWNlKHBjaV9maXh1cF9maW5h
bCwgdG9fcGNpX2RldihkZXYpKTsKPj4gKwo+Pgo+PiBUaGVuIHBjaV9maXh1cF9maW5hbCB3aWxs
IGJlIGNhbGxlZCB0d2ljZSwgdGhlIGZpcnN0IGluIHBjaV9idXNfYWRkX2RldmljZS4KPj4gSGVy
ZSBpbiBpb21tdV9md3NwZWNfaW5pdCBpcyB0aGUgc2Vjb25kIHRpbWUsIHNwZWNpZmljYWxseSBm
b3IgaW9tbXVfZndzcGVjLgo+PiBXaWxsIHNlbmQgdGhpcyB3aGVuIDUuOC1yYzEgaXMgb3Blbi4K
PiBXYWl0LCB0aGlzIHdob2xlIGZpeHVwIGFwcHJvYWNoIHNlZW1zIHdyb25nIHRvIG1lLiAgTm8g
bWF0dGVyIGhvdyB5b3UKPiBkbyB0aGUgZml4dXAsIGl0J3Mgc3RpbGwgYSBmaXh1cCwgd2hpY2gg
bWVhbnMgaXQgcmVxdWlyZXMgb25nb2luZwo+IG1haW50ZW5hbmNlLiAgU3VyZWx5IHdlIGRvbid0
IHdhbnQgdG8gaGF2ZSB0byBhZGQgdGhlIFZlbmRvci9EZXZpY2UgSUQKPiBmb3IgZXZlcnkgbmV3
IEFNQkEgZGV2aWNlIHRoYXQgY29tZXMgYWxvbmcsIGRvIHdlPwo+Cj4KSGVyZSB0aGUgZmFrZSBw
Y2kgZGV2aWNlIGhhcyBzdGFuZGFyZCBQQ0kgY2ZnIHNwYWNlLCBidXQgcGh5c2ljYWwgCmltcGxl
bWVudGF0aW9uIGlzIGJhc2Ugb24gQU1CQQpUaGV5IGNhbiBwcm92aWRlIHBhc2lkIGZlYXR1cmUu
Ckhvd2V2ZXIsCjEsIGRvZXMgbm90IHN1cHBvcnQgdGxwIHNpbmNlIHRoZXkgYXJlIG5vdCByZWFs
IHBjaSBkZXZpY2VzLgoyLiBkb2VzIG5vdCBzdXBwb3J0IHByaSwgaW5zdGVhZCBzdXBwb3J0IHN0
YWxsIChwcm92aWRlZCBieSBzbW11KQpBbmQgc3RhbGwgaXMgbm90IGEgcGNpIGZlYXR1cmUsIHNv
IGl0IGlzIG5vdCBkZXNjcmliZWQgaW4gc3RydWN0IApwY2lfZGV2LCBidXQgaW4gc3RydWN0IGlv
bW11X2Z3c3BlYy4KU28gd2UgdXNlIHRoaXMgZml4dXAgdG8gdGVsbCBwY2kgc3lzdGVtIHRoYXQg
dGhlIGRldmljZXMgY2FuIHN1cHBvcnQgCnN0YWxsLCBhbmQgaGVyZWJ5IHN1cHBvcnQgcGFzaWQu
CgpUaGFua3MKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
aW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
