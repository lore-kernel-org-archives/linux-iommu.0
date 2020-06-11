Return-Path: <SRS0=H3NW=7Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28CBC433E0
	for <iommu@archiver.kernel.org>; Thu, 11 Jun 2020 02:55:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69932206A4
	for <iommu@archiver.kernel.org>; Thu, 11 Jun 2020 02:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YbaZTSS9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69932206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 13CAA25C9B;
	Thu, 11 Jun 2020 02:55:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XGh4m6mEdXzs; Thu, 11 Jun 2020 02:55:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A21732588A;
	Thu, 11 Jun 2020 02:55:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83EF3C0865;
	Thu, 11 Jun 2020 02:55:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62D80C016F
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 02:55:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 48DA7894A9
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 02:55:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IAhrWVUyP7DE for <iommu@lists.linux-foundation.org>;
 Thu, 11 Jun 2020 02:55:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com
 [209.85.216.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0DA7988C95
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 02:55:00 +0000 (UTC)
Received: by mail-pj1-f66.google.com with SMTP id i12so1646924pju.3
 for <iommu@lists.linux-foundation.org>; Wed, 10 Jun 2020 19:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=j30R0UZzrDd+0W4T3mjyr9hSWvrdW6CBf5sEGoGyfXI=;
 b=YbaZTSS93EP7PjECnua8oQ5ab7vBqk+ABuJX3e/qK8iuRB9AZboQWcjN9nOMr3LEbO
 Ic3FExHwmXhD8IBQDuvf7PFai5iqbX30bSunhs2TMSctm3jwu2Uzv76XGLvxka7YiNwP
 bq+7hOvVNy4n3/9jtpUQgXYOsSMEVQBHAJrUYqakK406cocI/KCCzcSLB4+ueA0JzKqs
 Buiehe3CYrBtuZdIAg4nRXYalSDn4FcRin/SU3b538yPpBy/RMKVFtRfxjP1BOW3HND4
 /VPgwJwonI+rVPBxtz/j8jsZ6O4mcvc2fzPJnUW6EshfwLCtM9V+VFfrn06vgaptR/YO
 6ORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=j30R0UZzrDd+0W4T3mjyr9hSWvrdW6CBf5sEGoGyfXI=;
 b=PSuAqpaV/7UMORG+TnmavLf9gsz5oPVagO0EfNiL3tsjVygy29SWXLUf0Gp7ZqwE0B
 qBO3LRSl9io1Qu0o498zErU6SdgWqgZKaBcaNckZqZv+EqXa5ZW8JFpqh3RygCqLnPQ6
 RCAf0fiwbkhwIbYxiN4DbkWQk9ZrNNrS8C7zCmn+lyt58w3kp0m027s7T1I5fCjdXMug
 zaeT9R2BdoQVNTJ2Cl0/xwDwZdnDaw216hwglUY7K4stN5o8VcFbJQ8tv3F4TNFjCi+5
 d1HHmMAP7Ppn00/C31KssFC9B/Ls6kahQACcmp4rPxvc9yg2o1nujSyMwj4jT1XfdMgw
 DY0Q==
X-Gm-Message-State: AOAM533/sEnEOGT3rC9cKSVbY2aOWX71WsyCJYC7bjgPK3qS4MvRTOor
 zZTIyEFM7nA75jAd8yFpz0mAoA==
X-Google-Smtp-Source: ABdhPJy13QPXB7ndCJTCJUZMyAvmhnKxmSP60f1ha+1dPVVCf9spfvGWBTpxKJ0hiwq4FFMTSLSh6Q==
X-Received: by 2002:a17:90a:c717:: with SMTP id
 o23mr5951320pjt.195.1591844100426; 
 Wed, 10 Jun 2020 19:55:00 -0700 (PDT)
Received: from [10.80.1.206] ([45.135.186.73])
 by smtp.gmail.com with ESMTPSA id 6sm1259143pfi.170.2020.06.10.19.54.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2020 19:54:59 -0700 (PDT)
Subject: Re: [PATCH 0/2] Introduce PCI_FIXUP_IOMMU
To: Bjorn Helgaas <helgaas@kernel.org>, Arnd Bergmann <arnd@arndb.de>
References: <20200609164926.GA1452092@bjorn-Precision-5520>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <1d8a7ec4-b578-a97a-7835-453806f4e3ef@linaro.org>
Date: Thu, 11 Jun 2020 10:54:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609164926.GA1452092@bjorn-Precision-5520>
Content-Language: en-US
Cc: Thanu Rangarajan <Thanu.Rangarajan@arm.com>,
 jean-philippe <jean-philippe@linaro.org>,
 Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 linux-pci <linux-pci@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hanjun Guo <guohanjun@huawei.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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

CgpPbiAyMDIwLzYvMTAg5LiK5Y2IMTI6NDksIEJqb3JuIEhlbGdhYXMgd3JvdGU6Cj4gT24gVHVl
LCBKdW4gMDksIDIwMjAgYXQgMTE6MTU6MDZBTSArMDIwMCwgQXJuZCBCZXJnbWFubiB3cm90ZToK
Pj4gT24gVHVlLCBKdW4gOSwgMjAyMCBhdCA2OjAyIEFNIFpoYW5nZmVpIEdhbyA8emhhbmdmZWku
Z2FvQGxpbmFyby5vcmc+IHdyb3RlOgo+Pj4gT24gMjAyMC82Lzkg5LiK5Y2IMTI6NDEsIEJqb3Ju
IEhlbGdhYXMgd3JvdGU6Cj4+Pj4gT24gTW9uLCBKdW4gMDgsIDIwMjAgYXQgMTA6NTQ6MTVBTSAr
MDgwMCwgWmhhbmdmZWkgR2FvIHdyb3RlOgo+Pj4+PiBPbiAyMDIwLzYvNiDkuIrljYg3OjE5LCBC
am9ybiBIZWxnYWFzIHdyb3RlOgo+Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW9tbXUuYwo+
Pj4+Pj4+IEBAIC0yNDE4LDYgKzI0MTgsMTAgQEAgaW50IGlvbW11X2Z3c3BlY19pbml0KHN0cnVj
dCBkZXZpY2UgKmRldiwgc3RydWN0Cj4+Pj4+Pj4gZndub2RlX2hhbmRsZSAqaW9tbXVfZndub2Rl
LAo+Pj4+Pj4+ICAgICAgICAgICAgZndzcGVjLT5pb21tdV9md25vZGUgPSBpb21tdV9md25vZGU7
Cj4+Pj4+Pj4gICAgICAgICAgICBmd3NwZWMtPm9wcyA9IG9wczsKPj4+Pj4+PiAgICAgICAgICAg
IGRldl9pb21tdV9md3NwZWNfc2V0KGRldiwgZndzcGVjKTsKPj4+Pj4+PiArCj4+Pj4+Pj4gKyAg
ICAgICBpZiAoZGV2X2lzX3BjaShkZXYpKQo+Pj4+Pj4+ICsgICAgICAgICAgICAgICBwY2lfZml4
dXBfZGV2aWNlKHBjaV9maXh1cF9maW5hbCwgdG9fcGNpX2RldihkZXYpKTsKPj4+Pj4+PiArCj4+
Pj4+Pj4KPj4+Pj4+PiBUaGVuIHBjaV9maXh1cF9maW5hbCB3aWxsIGJlIGNhbGxlZCB0d2ljZSwg
dGhlIGZpcnN0IGluIHBjaV9idXNfYWRkX2RldmljZS4KPj4+Pj4+PiBIZXJlIGluIGlvbW11X2Z3
c3BlY19pbml0IGlzIHRoZSBzZWNvbmQgdGltZSwgc3BlY2lmaWNhbGx5IGZvciBpb21tdV9md3Nw
ZWMuCj4+Pj4+Pj4gV2lsbCBzZW5kIHRoaXMgd2hlbiA1LjgtcmMxIGlzIG9wZW4uCj4+Pj4+PiBX
YWl0LCB0aGlzIHdob2xlIGZpeHVwIGFwcHJvYWNoIHNlZW1zIHdyb25nIHRvIG1lLiAgTm8gbWF0
dGVyIGhvdyB5b3UKPj4+Pj4+IGRvIHRoZSBmaXh1cCwgaXQncyBzdGlsbCBhIGZpeHVwLCB3aGlj
aCBtZWFucyBpdCByZXF1aXJlcyBvbmdvaW5nCj4+Pj4+PiBtYWludGVuYW5jZS4gIFN1cmVseSB3
ZSBkb24ndCB3YW50IHRvIGhhdmUgdG8gYWRkIHRoZSBWZW5kb3IvRGV2aWNlIElECj4+Pj4+PiBm
b3IgZXZlcnkgbmV3IEFNQkEgZGV2aWNlIHRoYXQgY29tZXMgYWxvbmcsIGRvIHdlPwo+Pj4+Pj4K
Pj4+Pj4gSGVyZSB0aGUgZmFrZSBwY2kgZGV2aWNlIGhhcyBzdGFuZGFyZCBQQ0kgY2ZnIHNwYWNl
LCBidXQgcGh5c2ljYWwKPj4+Pj4gaW1wbGVtZW50YXRpb24gaXMgYmFzZSBvbiBBTUJBCj4+Pj4+
IFRoZXkgY2FuIHByb3ZpZGUgcGFzaWQgZmVhdHVyZS4KPj4+Pj4gSG93ZXZlciwKPj4+Pj4gMSwg
ZG9lcyBub3Qgc3VwcG9ydCB0bHAgc2luY2UgdGhleSBhcmUgbm90IHJlYWwgcGNpIGRldmljZXMu
Cj4+Pj4+IDIuIGRvZXMgbm90IHN1cHBvcnQgcHJpLCBpbnN0ZWFkIHN1cHBvcnQgc3RhbGwgKHBy
b3ZpZGVkIGJ5IHNtbXUpCj4+Pj4+IEFuZCBzdGFsbCBpcyBub3QgYSBwY2kgZmVhdHVyZSwgc28g
aXQgaXMgbm90IGRlc2NyaWJlZCBpbiBzdHJ1Y3QgcGNpX2RldiwKPj4+Pj4gYnV0IGluIHN0cnVj
dCBpb21tdV9md3NwZWMuCj4+Pj4+IFNvIHdlIHVzZSB0aGlzIGZpeHVwIHRvIHRlbGwgcGNpIHN5
c3RlbSB0aGF0IHRoZSBkZXZpY2VzIGNhbiBzdXBwb3J0IHN0YWxsLAo+Pj4+PiBhbmQgaGVyZWJ5
IHN1cHBvcnQgcGFzaWQuCj4+Pj4gVGhpcyBkaWQgbm90IGFuc3dlciBteSBxdWVzdGlvbi4gIEFy
ZSB5b3UgcHJvcG9zaW5nIHRoYXQgd2UgdXBkYXRlIGEKPj4+PiBxdWlyayBldmVyeSB0aW1lIGEg
bmV3IEFNQkEgZGV2aWNlIGlzIHJlbGVhc2VkPyAgSSBkb24ndCB0aGluayB0aGF0Cj4+Pj4gd291
bGQgYmUgYSBnb29kIG1vZGVsLgo+Pj4gWWVzLCB5b3UgYXJlIHJpZ2h0LCBidXQgd2UgZG8gbm90
IGhhdmUgYW55IGJldHRlciBpZGVhIHlldC4KPj4+IEN1cnJlbnRseSB3ZSBoYXZlIHRocmVlIGZh
a2UgcGNpIGRldmljZXMsIHdoaWNoIHN1cHBvcnQgc3RhbGwgYW5kIHBhc2lkLgo+Pj4gV2UgaGF2
ZSB0byBsZXQgcGNpIHN5c3RlbSBrbm93IHRoZSBkZXZpY2UgY2FuIHN1cHBvcnQgcGFzaWQsIGJl
Y2F1c2Ugb2YKPj4+IHN0YWxsIGZlYXR1cmUsIHRob3VnaCBub3Qgc3VwcG9ydCBwcmkuCj4+PiBE
byB5b3UgaGF2ZSBhbnkgb3RoZXIgaWRlYXM/Cj4+IEl0IHNvdW5kcyBsaWtlIHRoZSBiZXN0IHdh
eSB3b3VsZCBiZSB0byBhbGxvY2F0ZSBhIFBDSSBjYXBhYmlsaXR5IGZvciBpdCwgc28KPj4gZGV0
ZWN0aW9uIGNhbiBiZSBkb25lIHRocm91Z2ggY29uZmlnIHNwYWNlLCBhdCBsZWFzdCBpbiBmdXR1
cmUgZGV2aWNlcywKPj4gb3IgcG9zc2libHkgYWZ0ZXIgYSBmaXJtd2FyZSB1cGRhdGUgaWYgdGhl
IGNvbmZpZyBzcGFjZSBpbiB5b3VyIHN5c3RlbQo+PiBpcyBjb250cm9sbGVkIGJ5IGZpcm13YXJl
IHNvbWV3aGVyZS4gIE9uY2UgdGhlcmUgaXMgYSBwcm9wZXIgbWVjaGFuaXNtCj4+IHRvIGRvIHRo
aXMsIHVzaW5nIGZpeHVwcyB0byBkZXRlY3QgdGhlIGVhcmx5IGRldmljZXMgdGhhdCBkb24ndCB1
c2UgdGhhdAo+PiBzaG91bGQgYmUgdW5jb250cm92ZXJzaWFsLiBJIGhhdmUgbm8gaWRlYSB3aGF0
IHRoZSBwcm9jZXNzIG9yIHRpbWVsaW5lCj4+IGlzIHRvIGFkZCBuZXcgY2FwYWJpbGl0aWVzIGlu
dG8gdGhlIFBDSWUgc3BlY2lmaWNhdGlvbiwgb3IgaWYgdGhpcyBvbmUKPj4gd291bGQgYmUgYWNj
ZXB0YWJsZSB0byB0aGUgUENJIFNJRyBhdCBhbGwuCj4gVGhhdCBzb3VuZHMgbGlrZSBhIHBvc3Np
YmlsaXR5LiAgVGhlIHNwZWMgYWxyZWFkeSBkZWZpbmVzIGEKPiBWZW5kb3ItU3BlY2lmaWMgRXh0
ZW5kZWQgQ2FwYWJpbGl0eSAoUENJZSByNS4wLCBzZWMgNy45LjUpIHRoYXQgbWlnaHQKPiBiZSBh
IGNhbmRpZGF0ZS4KV2lsbCBpbnZlc3RpZ2F0ZSB0aGlzLCB0aGFua3MgQmpvcm4KPgo+PiBJZiBk
ZXRlY3Rpb24gY2Fubm90IGJlIGRvbmUgdGhyb3VnaCBQQ0kgY29uZmlnIHNwYWNlLCB0aGUgbmV4
dCBiZXN0Cj4+IGFsdGVybmF0aXZlIGlzIHRvIHBhc3MgYXV4aWxpYXJ5IGRhdGEgdGhyb3VnaCBm
aXJtd2FyZS4gT24gRFQgYmFzZWQKPj4gbWFjaGluZXMsIHlvdSBjYW4gbGlzdCBub24taG90cGx1
Z2dhYmxlIFBDSWUgZGV2aWNlcyBhbmQgYWRkIGN1c3RvbQo+PiBwcm9wZXJ0aWVzIHRoYXQgY291
bGQgYmUgcmVhZCBkdXJpbmcgZGV2aWNlIGVudW1lcmF0aW9uLiBJIGFzc3VtZQo+PiBBQ1BJIGhh
cyBzb21ldGhpbmcgc2ltaWxhciwgYnV0IEkgaGF2ZSBub3QgZG9uZSB0aGF0LgpZZXMsIHRoYW5r
cyBBcm5kCj4gQUNQSSBoYXMgX0RTTSAoQUNQSSB2Ni4zLCBzZWMgOS4xLjEpLCB3aGljaCBtaWdo
dCBiZSBhIGNhbmRpZGF0ZS4gIEkKPiBsaWtlIHRoaXMgYmV0dGVyIHRoYW4gYSBQQ0kgY2FwYWJp
bGl0eSBiZWNhdXNlIHRoZSBwcm9wZXJ0eSB5b3UgbmVlZAo+IHRvIGV4cG9zZSBpcyBub3QgYSBQ
Q0kgcHJvcGVydHkuCl9EU00gbWF5IG5vdCB3b3JrYWJsZSwgc2luY2UgaXQgaXMgd29ya2luZyBp
biBydW50aW1lLgpXZSBuZWVkIHN0YWxsIGluZm9ybWF0aW9uIGluIGluaXQgc3RhZ2UsIG5laXRo
ZXIgdG9vIGVhcmx5IChhZnRlciAKYWxsb2NhdGlvbiBvZiBpb21tdV9md3NwZWMpCm5vciB0b28g
bGF0ZSAoYmVmb3JlIGFybV9zbW11X2FkZF9kZXZpY2UgKS4KCkJ5IHRoZSB3YXksCkl0IHdvdWxk
IGJlIGEgbG9uZyB0aW1lIGlmIHdlIG5lZWQgbW9kaWZ5IGVpdGhlciBwY2llIHNwZWMgb3IgYWNw
aSBzcGVjLgpDYW4gd2UgdXNlIHBjaV9maXh1cF9kZXZpY2UgaW4gaW9tbXVfZndzcGVjX2luaXQg
Zmlyc3QsIGl0IGlzIHJlbGF0aXZlbHkgCnNpbXBsZQphbmQgbWVldCB0aGUgcmVxdWlyZW1lbnQg
b2YgcGxhdGZvcm0gZGV2aWNlIHVzaW5nIHBhc2lkLCBhbmQgdGhleSBhcmUgCmFscmVhZHkgaW4g
cHJvZHVjdC4KClRoYW5rcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lv
bW11
