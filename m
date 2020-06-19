Return-Path: <SRS0=CQHw=AA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AFEC433DF
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 02:34:51 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD2262080D
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 02:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iSB7ZTw+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD2262080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 49520868B4;
	Fri, 19 Jun 2020 02:34:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MeUeTebCz6Fm; Fri, 19 Jun 2020 02:34:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 63CE086546;
	Fri, 19 Jun 2020 02:34:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38EA1C07FF;
	Fri, 19 Jun 2020 02:34:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 52241C016E
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 02:34:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 44F4E88C2E
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 02:34:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L3kkTLNDtt3F for <iommu@lists.linux-foundation.org>;
 Fri, 19 Jun 2020 02:34:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-il1-f193.google.com (mail-il1-f193.google.com
 [209.85.166.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E13EE88B17
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 02:34:46 +0000 (UTC)
Received: by mail-il1-f193.google.com with SMTP id g3so7908540ilq.10
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 19:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=1NQyD9WrJsbI510glYgHlSP0TyLa8enW/S/MPeeFMi8=;
 b=iSB7ZTw+y0hCECv5tinmjWIPeUtBXssd1nCzvz4v0Ji07pHfe4hOOuinagdLEsBnl3
 1yvnOogYr4IdD4GKi+hlWXiXUcBp+mI1mL0rQnbc5LiAwqrSjyiV+ePIuyZGXynZj/kA
 MsOHM8PJTRRZfUNM9zxlB+rjPg44kU5qgB+H1jJ9cyDYvWo1c8ZmTgkKLupeID2Q/nHK
 KS2/2XoHlKRQXxal9WCrDhn7AYRQzNByypRXA3NWxWldotqEMAZIh6VkflS8HSQ21XgB
 KKf0sLNo8kZ+iQKLWmNZafoS1eN4KpmYVWogKmmLYWx36Y+RjG6YCMKZa0wgaqvm3cM5
 yX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=1NQyD9WrJsbI510glYgHlSP0TyLa8enW/S/MPeeFMi8=;
 b=rfyrD25IppqXV/auVJuWA72iKUtuJP2NuVqSVuKZR70hqPusuaP4uzr7ynkGejN948
 BfoGkfEr3w5s0FeJVh9aleejC8TjlRxH26L4+CHhl51VkguNG9bOAW8k+eQtqlBVdweX
 mISzJY9tYyaeCSK6rGTzEkAGOSb57fcf76QeRigGxie44ace2fpEFtZYikVp4BhyTcfo
 TfJvgqT19PfSZBzQwDciFknwWRu9B9IPnuLQ6865W2rpULBOpiri9yAwBSJA20DK3F7W
 h0sKMj0WQsv93grY8YZPXlxzvSDan4y2bMD+v8ENqSnGWvTaGwpor9Z23fuJCeP5D64q
 k3AQ==
X-Gm-Message-State: AOAM531R0J/OwftE3XxMUl4ZvuVWvy+s77Y/GGkLW1HULpgtifdXvLlF
 hBTl749SIMpMDfTPbRe7pAHiF7yBRNI=
X-Google-Smtp-Source: ABdhPJwPV/l1romnvuaB3bf+oXNo9TD61AfC0QGCLewyWOibz0ocQr1j4hIskA+JR5hNdLoitEbUKQ==
X-Received: by 2002:a65:6496:: with SMTP id e22mr1264866pgv.63.1592533652044; 
 Thu, 18 Jun 2020 19:27:32 -0700 (PDT)
Received: from ?IPv6:240e:362:4d1:900:683e:57c:525:a3cd?
 ([240e:362:4d1:900:683e:57c:525:a3cd])
 by smtp.gmail.com with ESMTPSA id a8sm1181029pga.64.2020.06.18.19.27.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2020 19:27:31 -0700 (PDT)
Subject: Re: [PATCH 0/2] Introduce PCI_FIXUP_IOMMU
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20200615235217.GA1921846@bjorn-Precision-5520>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <c5d7b2f1-6b32-d965-3b60-eb70a26e02b4@linaro.org>
Date: Fri, 19 Jun 2020 10:26:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200615235217.GA1921846@bjorn-Precision-5520>
Content-Language: en-US
Cc: linux-pci <linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
 jean-philippe <jean-philippe@linaro.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, Len Brown <lenb@kernel.org>,
 Thanu Rangarajan <Thanu.Rangarajan@arm.com>,
 Souvik Chakravarty <Souvik.Chakravarty@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Bjorn Helgaas <bhelgaas@google.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
 kenneth-lee-2012@foxmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>
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

SGksIEJqb3JuCgpPbiAyMDIwLzYvMTYg5LiK5Y2INzo1MiwgQmpvcm4gSGVsZ2FhcyB3cm90ZToK
PiBPbiBTYXQsIEp1biAxMywgMjAyMCBhdCAxMDozMDo1NlBNICswODAwLCBaaGFuZ2ZlaSBHYW8g
d3JvdGU6Cj4+IE9uIDIwMjAvNi8xMSDkuIvljYg5OjQ0LCBCam9ybiBIZWxnYWFzIHdyb3RlOgo+
Pj4gKysrIGIvZHJpdmVycy9pb21tdS9pb21tdS5jCj4+Pj4+Pj4+Pj4+IEBAIC0yNDE4LDYgKzI0
MTgsMTAgQEAgaW50IGlvbW11X2Z3c3BlY19pbml0KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0
Cj4+Pj4+Pj4+Pj4+IGZ3bm9kZV9oYW5kbGUgKmlvbW11X2Z3bm9kZSwKPj4+Pj4+Pj4+Pj4gICAg
ICAgICAgICAgIGZ3c3BlYy0+aW9tbXVfZndub2RlID0gaW9tbXVfZndub2RlOwo+Pj4+Pj4+Pj4+
PiAgICAgICAgICAgICAgZndzcGVjLT5vcHMgPSBvcHM7Cj4+Pj4+Pj4+Pj4+ICAgICAgICAgICAg
ICBkZXZfaW9tbXVfZndzcGVjX3NldChkZXYsIGZ3c3BlYyk7Cj4+Pj4+Pj4+Pj4+ICsKPj4+Pj4+
Pj4+Pj4gKyAgICAgICBpZiAoZGV2X2lzX3BjaShkZXYpKQo+Pj4+Pj4+Pj4+PiArICAgICAgICAg
ICAgICAgcGNpX2ZpeHVwX2RldmljZShwY2lfZml4dXBfZmluYWwsIHRvX3BjaV9kZXYoZGV2KSk7
Cj4+Pj4+Pj4+Pj4+ICsKPj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4gVGhlbiBwY2lfZml4dXBfZmlu
YWwgd2lsbCBiZSBjYWxsZWQgdHdpY2UsIHRoZSBmaXJzdCBpbiBwY2lfYnVzX2FkZF9kZXZpY2Uu
Cj4+Pj4+Pj4+Pj4+IEhlcmUgaW4gaW9tbXVfZndzcGVjX2luaXQgaXMgdGhlIHNlY29uZCB0aW1l
LCBzcGVjaWZpY2FsbHkgZm9yIGlvbW11X2Z3c3BlYy4KPj4+Pj4+Pj4+Pj4gV2lsbCBzZW5kIHRo
aXMgd2hlbiA1LjgtcmMxIGlzIG9wZW4uCj4+Pj4+Pj4+Pj4gV2FpdCwgdGhpcyB3aG9sZSBmaXh1
cCBhcHByb2FjaCBzZWVtcyB3cm9uZyB0byBtZS4gIE5vIG1hdHRlciBob3cgeW91Cj4+Pj4+Pj4+
Pj4gZG8gdGhlIGZpeHVwLCBpdCdzIHN0aWxsIGEgZml4dXAsIHdoaWNoIG1lYW5zIGl0IHJlcXVp
cmVzIG9uZ29pbmcKPj4+Pj4+Pj4+PiBtYWludGVuYW5jZS4gIFN1cmVseSB3ZSBkb24ndCB3YW50
IHRvIGhhdmUgdG8gYWRkIHRoZSBWZW5kb3IvRGV2aWNlIElECj4+Pj4+Pj4+Pj4gZm9yIGV2ZXJ5
IG5ldyBBTUJBIGRldmljZSB0aGF0IGNvbWVzIGFsb25nLCBkbyB3ZT8KPj4+Pj4+Pj4+Pgo+Pj4+
Pj4+Pj4gSGVyZSB0aGUgZmFrZSBwY2kgZGV2aWNlIGhhcyBzdGFuZGFyZCBQQ0kgY2ZnIHNwYWNl
LCBidXQgcGh5c2ljYWwKPj4+Pj4+Pj4+IGltcGxlbWVudGF0aW9uIGlzIGJhc2Ugb24gQU1CQQo+
Pj4+Pj4+Pj4gVGhleSBjYW4gcHJvdmlkZSBwYXNpZCBmZWF0dXJlLgo+Pj4+Pj4+Pj4gSG93ZXZl
ciwKPj4+Pj4+Pj4+IDEsIGRvZXMgbm90IHN1cHBvcnQgdGxwIHNpbmNlIHRoZXkgYXJlIG5vdCBy
ZWFsIHBjaSBkZXZpY2VzLgo+Pj4+Pj4+Pj4gMi4gZG9lcyBub3Qgc3VwcG9ydCBwcmksIGluc3Rl
YWQgc3VwcG9ydCBzdGFsbCAocHJvdmlkZWQgYnkgc21tdSkKPj4+Pj4+Pj4+IEFuZCBzdGFsbCBp
cyBub3QgYSBwY2kgZmVhdHVyZSwgc28gaXQgaXMgbm90IGRlc2NyaWJlZCBpbiBzdHJ1Y3QgcGNp
X2RldiwKPj4+Pj4+Pj4+IGJ1dCBpbiBzdHJ1Y3QgaW9tbXVfZndzcGVjLgo+Pj4+Pj4+Pj4gU28g
d2UgdXNlIHRoaXMgZml4dXAgdG8gdGVsbCBwY2kgc3lzdGVtIHRoYXQgdGhlIGRldmljZXMgY2Fu
IHN1cHBvcnQgc3RhbGwsCj4+Pj4+Pj4+PiBhbmQgaGVyZWJ5IHN1cHBvcnQgcGFzaWQuCj4+Pj4+
Pj4+IFRoaXMgZGlkIG5vdCBhbnN3ZXIgbXkgcXVlc3Rpb24uICBBcmUgeW91IHByb3Bvc2luZyB0
aGF0IHdlIHVwZGF0ZSBhCj4+Pj4+Pj4+IHF1aXJrIGV2ZXJ5IHRpbWUgYSBuZXcgQU1CQSBkZXZp
Y2UgaXMgcmVsZWFzZWQ/ICBJIGRvbid0IHRoaW5rIHRoYXQKPj4+Pj4+Pj4gd291bGQgYmUgYSBn
b29kIG1vZGVsLgo+Pj4+Pj4+IFllcywgeW91IGFyZSByaWdodCwgYnV0IHdlIGRvIG5vdCBoYXZl
IGFueSBiZXR0ZXIgaWRlYSB5ZXQuCj4+Pj4+Pj4gQ3VycmVudGx5IHdlIGhhdmUgdGhyZWUgZmFr
ZSBwY2kgZGV2aWNlcywgd2hpY2ggc3VwcG9ydCBzdGFsbCBhbmQgcGFzaWQuCj4+Pj4+Pj4gV2Ug
aGF2ZSB0byBsZXQgcGNpIHN5c3RlbSBrbm93IHRoZSBkZXZpY2UgY2FuIHN1cHBvcnQgcGFzaWQs
IGJlY2F1c2Ugb2YKPj4+Pj4+PiBzdGFsbCBmZWF0dXJlLCB0aG91Z2ggbm90IHN1cHBvcnQgcHJp
Lgo+Pj4+Pj4+IERvIHlvdSBoYXZlIGFueSBvdGhlciBpZGVhcz8KPj4+Pj4+IEl0IHNvdW5kcyBs
aWtlIHRoZSBiZXN0IHdheSB3b3VsZCBiZSB0byBhbGxvY2F0ZSBhIFBDSSBjYXBhYmlsaXR5IGZv
ciBpdCwgc28KPj4+Pj4+IGRldGVjdGlvbiBjYW4gYmUgZG9uZSB0aHJvdWdoIGNvbmZpZyBzcGFj
ZSwgYXQgbGVhc3QgaW4gZnV0dXJlIGRldmljZXMsCj4+Pj4+PiBvciBwb3NzaWJseSBhZnRlciBh
IGZpcm13YXJlIHVwZGF0ZSBpZiB0aGUgY29uZmlnIHNwYWNlIGluIHlvdXIgc3lzdGVtCj4+Pj4+
PiBpcyBjb250cm9sbGVkIGJ5IGZpcm13YXJlIHNvbWV3aGVyZS4gIE9uY2UgdGhlcmUgaXMgYSBw
cm9wZXIgbWVjaGFuaXNtCj4+Pj4+PiB0byBkbyB0aGlzLCB1c2luZyBmaXh1cHMgdG8gZGV0ZWN0
IHRoZSBlYXJseSBkZXZpY2VzIHRoYXQgZG9uJ3QgdXNlIHRoYXQKPj4+Pj4+IHNob3VsZCBiZSB1
bmNvbnRyb3ZlcnNpYWwuIEkgaGF2ZSBubyBpZGVhIHdoYXQgdGhlIHByb2Nlc3Mgb3IgdGltZWxp
bmUKPj4+Pj4+IGlzIHRvIGFkZCBuZXcgY2FwYWJpbGl0aWVzIGludG8gdGhlIFBDSWUgc3BlY2lm
aWNhdGlvbiwgb3IgaWYgdGhpcyBvbmUKPj4+Pj4+IHdvdWxkIGJlIGFjY2VwdGFibGUgdG8gdGhl
IFBDSSBTSUcgYXQgYWxsLgo+Pj4+PiBUaGF0IHNvdW5kcyBsaWtlIGEgcG9zc2liaWxpdHkuICBU
aGUgc3BlYyBhbHJlYWR5IGRlZmluZXMgYQo+Pj4+PiBWZW5kb3ItU3BlY2lmaWMgRXh0ZW5kZWQg
Q2FwYWJpbGl0eSAoUENJZSByNS4wLCBzZWMgNy45LjUpIHRoYXQgbWlnaHQKPj4+Pj4gYmUgYSBj
YW5kaWRhdGUuCj4+Pj4gV2lsbCBpbnZlc3RpZ2F0ZSB0aGlzLCB0aGFua3MgQmpvcm4KPj4+IEZX
SVcsIHRoZXJlJ3MgYWxzbyBhIFZlbmRvci1TcGVjaWZpYyBDYXBhYmlsaXR5IHRoYXQgY2FuIGFw
cGVhciBpbiB0aGUKPj4+IGZpcnN0IDI1NiBieXRlcyBvZiBjb25maWcgc3BhY2UgKHRoZSBWZW5k
b3ItU3BlY2lmaWMgRXh0ZW5kZWQKPj4+IENhcGFiaWxpdHkgbXVzdCBhcHBlYXIgaW4gdGhlICJF
eHRlbmRlZCBDb25maWd1cmF0aW9uIFNwYWNlIiBmcm9tCj4+PiAweDEwMC0weGZmZikuCj4+IFVu
Zm9ydHVuYXRlbHkgb3VyIHNpbGljb24gZG9lcyBub3QgaGF2ZSBlaXRoZXIgVmVuZG9yLVNwZWNp
ZmljwqBDYXBhYmlsaXR5IG9yCj4+IFZlbmRvci1TcGVjaWZpY8KgRXh0ZW5kZWQgQ2FwYWJpbGl0
eS4KPj4KPj4gU3R1ZGllZCBjb21taXQgODUzMWUyODNiZWU2NjA1MDczNGZiMGU4OWQ1M2U4NWZk
NWNlMjRhNAo+PiBMb29rcyB0aGlzIG1ldGhvZCByZXF1aXJlcyBhZGRpbmcgbWVtYmVyIChsaWtl
IGNhbl9zdGFsbCkgdG8gc3RydWN0IHBjaV9kZXYsCj4+IGxvb2tzIGRpZmZpY3VsdC4KPiBUaGUg
cHJvYmxlbSBpcyB0aGF0IHdlIGRvbid0IHdhbnQgdG8gYWRkIGRldmljZSBJRHMgZXZlcnkgdGlt
ZSBhIG5ldwo+IGNoaXAgY29tZXMgb3V0LiAgQWRkaW5nIG9uZSBvciB0d28gZGV2aWNlIElEcyBm
b3Igc2lsaWNvbiB0aGF0J3MKPiBhbHJlYWR5IHJlbGVhc2VkIGlzIG5vdCBhIHByb2JsZW0gYXMg
bG9uZyBhcyB5b3UgaGF2ZSBhIHN0cmF0ZWd5IGZvcgo+ICpmdXR1cmUqIGRldmljZXMgc28gdGhl
eSBkb24ndCByZXF1aXJlIGEgcXVpcmsuCj4KPj4+Pj4+IElmIGRldGVjdGlvbiBjYW5ub3QgYmUg
ZG9uZSB0aHJvdWdoIFBDSSBjb25maWcgc3BhY2UsIHRoZSBuZXh0IGJlc3QKPj4+Pj4+IGFsdGVy
bmF0aXZlIGlzIHRvIHBhc3MgYXV4aWxpYXJ5IGRhdGEgdGhyb3VnaCBmaXJtd2FyZS4gT24gRFQg
YmFzZWQKPj4+Pj4+IG1hY2hpbmVzLCB5b3UgY2FuIGxpc3Qgbm9uLWhvdHBsdWdnYWJsZSBQQ0ll
IGRldmljZXMgYW5kIGFkZCBjdXN0b20KPj4+Pj4+IHByb3BlcnRpZXMgdGhhdCBjb3VsZCBiZSBy
ZWFkIGR1cmluZyBkZXZpY2UgZW51bWVyYXRpb24uIEkgYXNzdW1lCj4+Pj4+PiBBQ1BJIGhhcyBz
b21ldGhpbmcgc2ltaWxhciwgYnV0IEkgaGF2ZSBub3QgZG9uZSB0aGF0Lgo+Pj4+IFllcywgdGhh
bmtzIEFybmQKPj4+Pj4gQUNQSSBoYXMgX0RTTSAoQUNQSSB2Ni4zLCBzZWMgOS4xLjEpLCB3aGlj
aCBtaWdodCBiZSBhIGNhbmRpZGF0ZS4gIEkKPj4+Pj4gbGlrZSB0aGlzIGJldHRlciB0aGFuIGEg
UENJIGNhcGFiaWxpdHkgYmVjYXVzZSB0aGUgcHJvcGVydHkgeW91IG5lZWQKPj4+Pj4gdG8gZXhw
b3NlIGlzIG5vdCBhIFBDSSBwcm9wZXJ0eS4KPj4+PiBfRFNNIG1heSBub3Qgd29ya2FibGUsIHNp
bmNlIGl0IGlzIHdvcmtpbmcgaW4gcnVudGltZS4KPj4+PiBXZSBuZWVkIHN0YWxsIGluZm9ybWF0
aW9uIGluIGluaXQgc3RhZ2UsIG5laXRoZXIgdG9vIGVhcmx5IChhZnRlciBhbGxvY2F0aW9uCj4+
Pj4gb2YgaW9tbXVfZndzcGVjKQo+Pj4+IG5vciB0b28gbGF0ZSAoYmVmb3JlIGFybV9zbW11X2Fk
ZF9kZXZpY2UgKS4KPj4+IEknbSBub3QgYXdhcmUgb2YgYSByZXN0cmljdGlvbiBvbiB3aGVuIF9E
U00gY2FuIGJlIGV2YWx1YXRlZC4gIEknbQo+Pj4gbG9va2luZyBhdCBBQ1BJIHY2LjMsIHNlYyA5
LjEuMS4gIEFyZSB5b3Ugc2VlaW5nIHNvbWV0aGluZyBkaWZmZXJlbnQ/Cj4+IERTTSBtZXRob2Qg
c2VlbXMgcmVxdWlyZXMgdmVuZG9yIHNwZWNpZmljIGd1aWQsIGFuZCBjb2RlIHdvdWxkIGJlIHZl
bmRvcgo+PiBzcGVjaWZpYy4KPiBfRFNNIGluZGVlZCByZXF1aXJlcyBhIHZlbmRvci1zcGVjaWZp
YyBVVUlELCBwcmVjaXNlbHkgKmJlY2F1c2UqCj4gdmVuZG9ycyBhcmUgZnJlZSB0byBkZWZpbmUg
dGhlaXIgb3duIGZ1bmN0aW9uYWxpdHkgd2l0aG91dCByZXF1aXJpbmcKPiBjaGFuZ2VzIHRvIHRo
ZSBBQ1BJIHNwZWMuICBGcm9tIHRoZSBzcGVjIChBQ1BJIHY2LjMsIHNlYyA5LjEuMSk6Cj4KPiAg
ICBOZXcgVVVJRHMgbWF5IGFsc28gYmUgY3JlYXRlZCBieSBPRU1zIGFuZCBJSFZzIGZvciBjdXN0
b20gZGV2aWNlcwo+ICAgIGFuZCBvdGhlciBpbnRlcmZhY2Ugb3IgZGV2aWNlIGdvdmVybmluZyBi
b2RpZXMgKGUuZy4gdGhlIFBDSSBTSUcpLAo+ICAgIGFzIGxvbmcgYXMgdGhlIFVVSUQgaXMgZGlm
ZmVyZW50IGZyb20gb3RoZXIgcHVibGlzaGVkIFVVSURzLgpIYXZlIHN0dWRpZWQgX0RTTSBtZXRo
b2QsIHR3byBpc3N1ZXMgd2UgbWV0IGNvbXBhcmluZyB1c2luZyBxdWlyay4KCjEuIE5lZWQgY2hh
bmdlIGRlZmluaXRpb24gb2YgZWl0aGVyIHBjaV9ob3N0X2JyaWRnZSBvciBwY2lfZGV2LCBsaWtl
IAphZGRpbmcgbWVtYmVyIGNhbl9zdGFsbCwKd2hpbGUgcGNpIHN5c3RlbSBkb2VzIG5vdCBrbm93
IHN0YWxsIG5vdy4KCmEsIHBjaSBkZXZpY2VzIGRvIG5vdCBoYXZlIHV1aWQ6IHV1aWQgbmVlZCBi
ZSBkZXNjcmliZWQgaW4gZHNkdCwgd2hpbGUgCnBjaSBkZXZpY2VzIGFyZSBub3QgZGVmaW5lZCBp
biBkc2R0LgogwqDCoMKgIHNvIHdlIGhhdmUgdG8gdXNlIGhvc3QgYnJpZGdlLgoKYizCoCBQYXJz
aW5nIGRzZHQgaXMgaW4gaW4gcGNpIHN1YnN5c3RlbS4KTGlrZSBkcml2ZXJzL2FjcGkvcGNpX3Jv
b3QuYzoKIMKgwqDCoMKgwqDCoCBvYmogPSBhY3BpX2V2YWx1YXRlX2RzbShBQ1BJX0hBTkRMRShi
dXMtPmJyaWRnZSksIAomcGNpX2FjcGlfZHNtX2d1aWQsIDEsCiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBJR05PUkVfUENJX0JP
T1RfQ09ORklHX0RTTSwgTlVMTCk7CgpBZnRlciBwYXJzaW5nIERTTSBpbiBwY2ksIHdlIG5lZWQg
cmVjb3JkIHRoaXMgaW5mby4KQ3VycmVudGx5LCBjYW5fc3RhbGwgaW5mbyBpcyByZWNvcmRlZCBp
biBpb21tdV9md3NwZWMsCndoaWNoIGlzIGFsbG9jYXRlZCBpbiBpb21tdV9md3NwZWNfaW5pdCBh
bmQgY2FsbGVkIGJ5IAppb3J0X2lvbW11X2NvbmZpZ3VyZSBmb3IgdWVmaS4KCjIuIEd1ZXN0IGtl
cm5lbCBhbHNvIG5lZWQgc3VwcG9ydCBzdmEuClVzaW5nIHF1aXJrLCB0aGUgZ3Vlc3QgY2FuIGJv
b3Qgd2l0aCBzdmEgZW5hYmxlZCwgc2luY2UgcXVpcmsgaXMgCnNlbGYtY29udGFpbmVkIGJ5IGtl
cm5lbC4KSWYgdXNpbmfCoCBfRFNNLCBhIHNwZWNpZmljIHVlZmkgb3IgZHRiIGhhcyB0byBiZSBw
cm92aWRlZCwKY3VycmVudGx5IHdlIGNhbiB1c2VRRU1VX0VGSS5mZCBmcm9tIGFwdCBpbnN0YWxs
IHFlbXUtZWZpCgoKVGhhbmtzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9p
b21tdQ==
