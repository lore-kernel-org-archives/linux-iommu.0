Return-Path: <SRS0=ytjs=7R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8253C433DF
	for <iommu@archiver.kernel.org>; Thu,  4 Jun 2020 13:33:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BA5420772
	for <iommu@archiver.kernel.org>; Thu,  4 Jun 2020 13:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zPMPr/Yx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BA5420772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 0CC0924723;
	Thu,  4 Jun 2020 13:33:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l68LYjl7zING; Thu,  4 Jun 2020 13:33:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 374B52442C;
	Thu,  4 Jun 2020 13:33:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15A14C0881;
	Thu,  4 Jun 2020 13:33:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42903C016E
 for <iommu@lists.linux-foundation.org>; Thu,  4 Jun 2020 13:33:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 276DC86F66
 for <iommu@lists.linux-foundation.org>; Thu,  4 Jun 2020 13:33:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id twZ9p4UsYw57 for <iommu@lists.linux-foundation.org>;
 Thu,  4 Jun 2020 13:33:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
 [209.85.214.193])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 027BB86F53
 for <iommu@lists.linux-foundation.org>; Thu,  4 Jun 2020 13:33:32 +0000 (UTC)
Received: by mail-pl1-f193.google.com with SMTP id t16so2186090plo.7
 for <iommu@lists.linux-foundation.org>; Thu, 04 Jun 2020 06:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=RAV9/dNL++xiGiHR5A9Oc9TEhWA76VZjoAgyK161SVY=;
 b=zPMPr/YxyP3965QTpRI2+WUxZFPPhZUrUCBk07JsMf7SI3dYonyONF/w0DXsy+H5hG
 o/oJJjSdmpLtc+dJQvwp1leBctiT2Vq3wT+tqHFjb6xHMsfoWEaS9zvqmiv6i6Kypmcz
 NuPrUukPkRrFI2m5XEndHGed2uTmcHb8pnRTofbn4DegJcnfjQFGe7zPoyuv2QGsXbWh
 HH8bumkNPHc1m7ilS8Jcj/cIvN+irGawDlQl1LsOKy9ICdejCXO3r2FVOYnWv/nVXOPx
 WfGKGP7iB52c9x+wjbCYhrs/rUdGBBvxGsKjhZBtuKFDffKB+jr+YPAY9FHogJdNolMo
 B2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=RAV9/dNL++xiGiHR5A9Oc9TEhWA76VZjoAgyK161SVY=;
 b=AfOI6WohVr0iR635dc5Baz6RpC4CqQ4i0t10ZFP1TDdLMfmybEHNgZbAVOg4NHOsAl
 1X77TeFLtsKE6G2frHiSqX/bLCn5o62OfnTCJSZ4jLiRYUO3JiqMs7ykdAMcHFsxa0Hh
 aOBEzbwLc9Eq6FZ8tp0F641UzYR9i2JTjJGKvKMjBJ5uHHkKyH2rJmjGhRYFmi7Tsnev
 kHZ+hbsm5LEyhMHXYJUWsZzmiFk3lRlya/kOmRQ2oHkxf8vtOcsrL7gZdKwXeKLyZMdH
 uNfxvwXdCvwqwpToSLykRi5sqHFHRp8DfHMHmmvj40vIP56nQU5MW0/5O4ZadUKoKt6c
 UD4w==
X-Gm-Message-State: AOAM5309yJcd7IR3Ao5rcx9UTjZnVCet/EuuFwtrE1qwIFjOPMQe/Hvt
 hP5y3tO5EQxMOkv92l0mf2Qmmg==
X-Google-Smtp-Source: ABdhPJyHAP7hdkjk0QRqpIxnyq/8FeJd16IwaXCeqaVfm7NZUPFQxKr/IxN2WFjd4DugkV/BUTo0Ew==
X-Received: by 2002:a17:902:7d85:: with SMTP id
 a5mr4997837plm.106.1591277612461; 
 Thu, 04 Jun 2020 06:33:32 -0700 (PDT)
Received: from [10.158.2.42] ([45.135.186.31])
 by smtp.gmail.com with ESMTPSA id y6sm5569040pjw.15.2020.06.04.06.33.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2020 06:33:31 -0700 (PDT)
Subject: Re: [PATCH 0/2] Introduce PCI_FIXUP_IOMMU
To: Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>
References: <20200601174104.GA734973@bjorn-Precision-5520>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <779f4044-cf6a-b0d3-916f-0274450c07d3@linaro.org>
Date: Thu, 4 Jun 2020 21:33:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200601174104.GA734973@bjorn-Precision-5520>
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

CgpPbiAyMDIwLzYvMiDkuIrljYgxOjQxLCBCam9ybiBIZWxnYWFzIHdyb3RlOgo+IE9uIFRodSwg
TWF5IDI4LCAyMDIwIGF0IDA5OjMzOjQ0QU0gKzAyMDAsIEpvZXJnIFJvZWRlbCB3cm90ZToKPj4g
T24gV2VkLCBNYXkgMjcsIDIwMjAgYXQgMDE6MTg6NDJQTSAtMDUwMCwgQmpvcm4gSGVsZ2FhcyB3
cm90ZToKPj4+IElzIHRoaXMgc2xvd2Rvd24gc2lnbmlmaWNhbnQ/ICBXZSBhbHJlYWR5IGl0ZXJh
dGUgb3ZlciBldmVyeSBkZXZpY2UKPj4+IHdoZW4gYXBwbHlpbmcgUENJX0ZJWFVQX0ZJTkFMIHF1
aXJrcywgc28gaWYgd2UgdXNlZCB0aGUgZXhpc3RpbmcKPj4+IFBDSV9GSVhVUF9GSU5BTCwgd2Ug
d291bGRuJ3QgYmUgYWRkaW5nIGEgbmV3IGxvb3AuICBXZSB3b3VsZCBvbmx5IGJlCj4+PiBhZGRp
bmcgdHdvIG1vcmUgaXRlcmF0aW9ucyB0byB0aGUgbG9vcCBpbiBwY2lfZG9fZml4dXBzKCkgdGhh
dCB0cmllcwo+Pj4gdG8gbWF0Y2ggcXVpcmtzIGFnYWluc3QgdGhlIGN1cnJlbnQgZGV2aWNlLiAg
SSBkb3VidCB0aGF0IHdvdWxkIGJlIGEKPj4+IG1lYXN1cmFibGUgc2xvd2Rvd24uCj4+IEkgZG9u
J3Qga25vdyBob3cgc2lnbmlmaWNhbnQgaXQgaXMsIGJ1dCBJIHJlbWVtYmVyIHBlb3BsZSBjb21w
bGFpbmluZwo+PiBhYm91dCBhZGRpbmcgbmV3IFBDSSBxdWlya3MgYmVjYXVzZSBpdCB0YWtlcyB0
b28gbG9uZyBmb3IgdGhlbSB0byBydW4KPj4gdGhlbSBhbGwuIFRoYXQgd2FzIGluIHRoZSBkaXNj
dXNzaW9uIGFib3V0IHRoZSBxdWlyayBkaXNhYmxpbmcgQVRTIG9uCj4+IEFNRCBTdG9uZXkgc3lz
dGVtcy4KPj4KPj4gU28gaXQgcHJvYmFibHkgZGVwZW5kcyBvbiBob3cgbWFueSBQQ0kgZGV2aWNl
cyBhcmUgaW4gdGhlIHN5c3RlbSB3aGV0aGVyCj4+IGl0IGNhdXNlcyBhbnkgbWVhc3VyZWFibGUg
c2xvd2Rvd24uCj4gSSBmb3VuZCB0aGlzIFsxXSBmcm9tIFBhdWwgTWVuemVsLCB3aGljaCB3YXMg
YSBzbG93ZG93biBjYXVzZWQgYnkKPiBxdWlya191c2JfZWFybHlfaGFuZG9mZigpLiAgSSB0aGlu
ayB0aGUgcmVhbCBwcm9ibGVtIGlzIGluZGl2aWR1YWwKPiBxdWlya3MgdGhhdCB0YWtlIGEgbG9u
ZyB0aW1lLgo+Cj4gVGhlIFBDSV9GSVhVUF9JT01NVSB0aGluZ3Mgd2UncmUgdGFsa2luZyBhYm91
dCBzaG91bGQgYmUgZmFzdCwgYW5kIG9mCj4gY291cnNlLCB0aGV5J3JlIG9ubHkgcnVuIGZvciBt
YXRjaGluZyBkZXZpY2VzIGFueXdheS4gIFNvIEknZCByYXRoZXIKPiBrZWVwIHRoZW0gYXMgUENJ
X0ZJWFVQX0ZJTkFMIHRoYW4gYWRkIGEgd2hvbGUgbmV3IHBoYXNlLgo+ClRoYW5rcyBCam9ybiBm
b3IgdGFraW5nIHRpbWUgZm9yIHRoaXMuCklmIHNvLCBpdCB3b3VsZCBiZSBtdWNoIHNpbXBsZXIu
CgorKysgYi9kcml2ZXJzL2lvbW11L2lvbW11LmMKQEAgLTI0MTgsNiArMjQxOCwxMCBAQCBpbnQg
aW9tbXVfZndzcGVjX2luaXQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgCmZ3bm9kZV9oYW5k
bGUgKmlvbW11X2Z3bm9kZSwKIMKgwqDCoMKgwqDCoMKgIGZ3c3BlYy0+aW9tbXVfZndub2RlID0g
aW9tbXVfZndub2RlOwogwqDCoMKgwqDCoMKgwqAgZndzcGVjLT5vcHMgPSBvcHM7CiDCoMKgwqDC
oMKgwqDCoCBkZXZfaW9tbXVfZndzcGVjX3NldChkZXYsIGZ3c3BlYyk7CisKK8KgwqDCoMKgwqDC
oCBpZiAoZGV2X2lzX3BjaShkZXYpKQorwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwY2lf
Zml4dXBfZGV2aWNlKHBjaV9maXh1cF9maW5hbCwgdG9fcGNpX2RldihkZXYpKTsKKwoKVGhlbiBw
Y2lfZml4dXBfZmluYWwgd2lsbCBiZSBjYWxsZWQgdHdpY2UsIHRoZSBmaXJzdCBpbiBwY2lfYnVz
X2FkZF9kZXZpY2UuCkhlcmUgaW4gaW9tbXVfZndzcGVjX2luaXQgaXMgdGhlIHNlY29uZCB0aW1l
LCBzcGVjaWZpY2FsbHkgZm9yIGlvbW11X2Z3c3BlYy4KV2lsbCBzZW5kIHRoaXMgd2hlbiA1Ljgt
cmMxIGlzIG9wZW4uCgpUaGFua3MKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2lvbW11
