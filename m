Return-Path: <SRS0=bNYQ=AE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFDDC433DF
	for <iommu@archiver.kernel.org>; Tue, 23 Jun 2020 07:48:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B0E42073E
	for <iommu@archiver.kernel.org>; Tue, 23 Jun 2020 07:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dvb9jWrW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B0E42073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2BE9D204C7;
	Tue, 23 Jun 2020 07:48:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZVM4yh+riqNs; Tue, 23 Jun 2020 07:48:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 62EE12010C;
	Tue, 23 Jun 2020 07:48:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 416F5C0891;
	Tue, 23 Jun 2020 07:48:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93CD6C016F
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 07:48:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 826BB88984
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 07:48:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wx1Cvp+jU7FW for <iommu@lists.linux-foundation.org>;
 Tue, 23 Jun 2020 07:48:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C0CB088923
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 07:48:49 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id 136so109219pfv.3
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 00:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=iXMHLbguntKcuTgr1nAq0fpxZctLmOVLPocRZ01HV1s=;
 b=Dvb9jWrWxYf0cUS7+mre8Ce7N6LCPCbgM4TfzIgO9x/j/Sz44QbFtHYcBvV6YcHykC
 /UOjUDAlRBaipXGhgPtfj5VOhd0MjmoLTxYmHS14ROKFa4k7B6adT6mjHgV2lQZYAb2L
 9lBtnjHKiulqZ7h6mF5QFFytTHA5SEJIAChcsfvKC0+xwvXLEhh4oJ/sXC4FDnOEad0q
 wFvAaXsf3se/vnfb3bW1sYXvPN+QVKdtP6yU8qG9ZHjQx6589ayIzIweyVGj7eNLSCdB
 qISGLxSJaNs+JUUvbM8FXzy2OTirEzU1whLCBwbJsuBLePOiMyrCufoYlY4bb/bJX8TB
 Kruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=iXMHLbguntKcuTgr1nAq0fpxZctLmOVLPocRZ01HV1s=;
 b=WhQuX3iI7jjLmSEQBgoMhTVQeutSIvEUvWbJjZqp9ymyLRfkJG0U0HrT7z2Ge3Dead
 SllvOnjt6uDebaGyPe7jyImv0BDLByY5ZHUNOieLfK+b2NlEAq/0SVIU8/VD2SGChHvd
 cmKBF5BGcO7S09g/dPVETxqoIe5SvOzgGCEe0+1dBxQeI+CXCzsW4rwq9175Q8tagT0U
 P8328tHDmudBtv/KNzf2qjrvIUjv3z9lJhplJ5PS0/lw66T2CMDlXGYe1tSHgz7BluZU
 LUD8frnatE3C7y77/+OBghL01qTb9VRXIAurdNUcLx/30LtEyKVXhz3jsCZT8cOc53Ee
 OVcQ==
X-Gm-Message-State: AOAM532zpyOqFzjbCnj/0L5g40ik2hXFYvsvbBER/7bhi5XZBnz1Ysrh
 rAXkUEbymS6YzeHQvAPK0uQJYw==
X-Google-Smtp-Source: ABdhPJxwJ+AW8uQAXY8Win57SIEKcys5G+XsLikqbv6KNfk0Z4v0oLWW7NunPD5K78dMacn0DXTtuQ==
X-Received: by 2002:a62:f201:: with SMTP id m1mr25533751pfh.198.1592898529334; 
 Tue, 23 Jun 2020 00:48:49 -0700 (PDT)
Received: from [10.37.1.30] ([45.135.186.125])
 by smtp.gmail.com with ESMTPSA id u6sm16409369pfc.83.2020.06.23.00.48.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2020 00:48:48 -0700 (PDT)
Subject: Re: [PATCH 0/2] Introduce PCI_FIXUP_IOMMU
To: Joerg Roedel <joro@8bytes.org>
References: <20200601174104.GA734973@bjorn-Precision-5520>
 <779f4044-cf6a-b0d3-916f-0274450c07d3@linaro.org>
 <20200622115536.GH3701@8bytes.org>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <d007cbea-85c0-6c75-fc4a-e2872ff59ea4@linaro.org>
Date: Tue, 23 Jun 2020 15:48:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200622115536.GH3701@8bytes.org>
Content-Language: en-US
Cc: jean-philippe <jean-philippe@linaro.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
 linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hanjun Guo <guohanjun@huawei.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-acpi@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
 linux-crypto@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, kenneth-lee-2012@foxmail.com,
 linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
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

SGksIEpvZXJnCgpPbiAyMDIwLzYvMjIg5LiL5Y2INzo1NSwgSm9lcmcgUm9lZGVsIHdyb3RlOgo+
IE9uIFRodSwgSnVuIDA0LCAyMDIwIGF0IDA5OjMzOjA3UE0gKzA4MDAsIFpoYW5nZmVpIEdhbyB3
cm90ZToKPj4gKysrIGIvZHJpdmVycy9pb21tdS9pb21tdS5jCj4+IEBAIC0yNDE4LDYgKzI0MTgs
MTAgQEAgaW50IGlvbW11X2Z3c3BlY19pbml0KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0Cj4+
IGZ3bm9kZV9oYW5kbGUgKmlvbW11X2Z3bm9kZSwKPj4gIMKgwqDCoMKgwqDCoMKgIGZ3c3BlYy0+
aW9tbXVfZndub2RlID0gaW9tbXVfZndub2RlOwo+PiAgwqDCoMKgwqDCoMKgwqAgZndzcGVjLT5v
cHMgPSBvcHM7Cj4+ICDCoMKgwqDCoMKgwqDCoCBkZXZfaW9tbXVfZndzcGVjX3NldChkZXYsIGZ3
c3BlYyk7Cj4+ICsKPj4gK8KgwqDCoMKgwqDCoCBpZiAoZGV2X2lzX3BjaShkZXYpKQo+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwY2lfZml4dXBfZGV2aWNlKHBjaV9maXh1cF9maW5h
bCwgdG9fcGNpX2RldihkZXYpKTsKPj4gKwo+IFRoYXQncyBub3QgZ29pbmcgdG8gZmx5LCBJIGRv
bid0IHRoaW5rIHdlIHNob3VsZCBydW4gdGhlIGZpeHVwcyB0d2ljZSwKPiBhbmQgdGhleSBzaG91
bGQgbm90IGJlIHJ1biBmcm9tIElPTU1VIGNvZGUuIElzIHRoZSBvbmx5IHJlYXNvbiBmb3IgdGhp
cwo+IHNlY29uZCBwYXNzIHRoYXQgaW9tbXVfZndzcGVjIGlzIG5vdCB5ZXQgYWxsb2NhdGVkIHdo
ZW4gaXQgcnVucyB0aGUKPiBmaXJzdCB0aW1lPyBJIGFzayBiZWNhdXNlIGl0IG1pZ2h0IGJlIGVh
c2llciB0byBqdXN0IGFsbG9jYXRlIHRoZSBzdHJ1Y3QKPiBlYXJsaWVyIHRoZW4uClRoYW5rcyBm
b3IgbG9va2luZyB0aGlzLgoKWWVzLCBpdCBpcyB0aGUgb25seSByZWFzb24gY2FsbGluZyBmaXh1
cCBzZWNvbmRseSBhZnRlciBpb21tdV9md3NwZWMgaXMgCmFsbG9jYXRlZC4KClRoZSBmaXJzdCB0
aW1lIGZpeHVwIGZpbmFsIGlzIHZlcnkgZWFybHkgaW4gcGNpX2J1c19hZGRfZGV2aWNlLgpJZiBh
bGxvY2F0aW5nIGlvbW11X2Z3c3BlYyBlYXJsaWVyLCBpdCBtYXliZSBpbiBwY2lfYWxsb2NfZGV2
LgpBbmQgYXNzaWduaW5nIG9wcyBzdGlsbCBpbiBpb21tdV9md3NwZWNfaW5pdC4KSGF2ZSB0ZXN0
ZWQgaXQgd29ya3MuCk5vdCBzdXJlIGlzIGl0IGFjY2VwdGFibGU/CgpBbHRlcm5hdGl2ZWx5LCBh
ZGRpbmcgY2FuX3N0YWxsIHRvIHN0cnVjdCBwY2lfZGV2IGlzIHNpbXBsZSBidXQgdWdseSB0b28s
CnNpbmNlIHBjaSBkb2VzIG5vdCBrbm93IHN0YWxsIG5vdy4KCgpUaGFua3MKCgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0
CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
