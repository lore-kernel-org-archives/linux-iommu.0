Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF08C433FE
	for <iommu@archiver.kernel.org>; Fri, 25 Feb 2022 14:29:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DAD8540A54;
	Fri, 25 Feb 2022 14:29:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7hw8sC3W41Eh; Fri, 25 Feb 2022 14:29:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4FEA54047C;
	Fri, 25 Feb 2022 14:29:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24601C007A;
	Fri, 25 Feb 2022 14:29:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5161CC001A
 for <iommu@lists.linux-foundation.org>; Fri, 25 Feb 2022 14:29:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 300C7404B4
 for <iommu@lists.linux-foundation.org>; Fri, 25 Feb 2022 14:29:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cs2pZGGF4ags for <iommu@lists.linux-foundation.org>;
 Fri, 25 Feb 2022 14:29:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6C74D4047C
 for <iommu@lists.linux-foundation.org>; Fri, 25 Feb 2022 14:29:03 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 cp23-20020a17090afb9700b001bbfe0fbe94so4930476pjb.3
 for <iommu@lists.linux-foundation.org>; Fri, 25 Feb 2022 06:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language
 :from:to:cc:references:in-reply-to:content-transfer-encoding;
 bh=t5YAbD7vQEX4bsWhAei3DxtoVuv5IKfWxA+u2Ae9wAc=;
 b=NP47JcMNbHTMaUVy2mFxwWKAGJCIZ5XI3xAKbinOX0FQzqETFGEAcGIzKvoDi0UG6W
 HZP3q4+jxZCHBNlcy8v9M7OHMswMZT+GtnAqmjrOVZiINQh8soFHCFPirFR90K62IElR
 lCCB5VWl2SgVc2wDrNuGdgPEOHwDiRY7TRbt0qzE17Yx61PAVKkesmm5fxkskIFz5y6Y
 GiUcyvTh5f5NIN0FbZpeoTM16xTsGSx+VjPRP+OLtzbz5EOuXBSXXPS8fkkixD9Ss5RO
 IIzb1nDTqfBZ4seDQeDXZs/L9GMzxm7/II5xNHNMKAn6db2MYSsUmM6cmDI1TCpcloq2
 NaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:from:to:cc:references:in-reply-to
 :content-transfer-encoding;
 bh=t5YAbD7vQEX4bsWhAei3DxtoVuv5IKfWxA+u2Ae9wAc=;
 b=0duj3LtYSEuJjd91NCB3MdPdZ8CmNexn2+sRX3dob1987rKDvMKT/feaOoFH2v3iGa
 7fEhvgzVt7YXtk2zNmKdvxCY6vEiPRrdm3cUWVT3ClvDUqVjg++hYiZM5bnX/xcL2MZt
 UV4OHtoLFveAN2m++7KmP8ZX7w+XqMJArffZdssnIBQC3aOHKcxyOMbJnF9h9Kxgj7Zy
 jXX1mRCdUptJm0ZrOwIwXQKKfb+4p5ytc8n/Mkx+jbROSzA4afjuOmMiErJsvsFx60hu
 sH9kxntwC3mqhiZAiF7w9704JLw0vJ0N/EQu8g56oZtiYH+R6+Y6V997xkP7xVbKazdp
 3P0g==
X-Gm-Message-State: AOAM533E3b7KageWbjgJi9aZmJ745Y2SOfe+wCeGQhNBOVcmkUjhthZc
 ea7pPX2W+Qjr2WYxsXyv0nw=
X-Google-Smtp-Source: ABdhPJy1vgdWztGWyuXhqHpDnH/bi2diPYr1uqAWpxAf+YpS6SsZOmGBIXvXpz8SCpBBcZGUV9yxRg==
X-Received: by 2002:a17:902:db01:b0:150:274a:d314 with SMTP id
 m1-20020a170902db0100b00150274ad314mr3890912plx.52.1645799342814; 
 Fri, 25 Feb 2022 06:29:02 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::754? ([2404:f801:9000:18:efec::754])
 by smtp.gmail.com with ESMTPSA id
 b17-20020a056a000a9100b004e1b7cdb8fdsm3751492pfl.70.2022.02.25.06.28.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Feb 2022 06:29:02 -0800 (PST)
Message-ID: <a80a7efa-f15d-3649-f39f-c24820f9ef2b@gmail.com>
Date: Fri, 25 Feb 2022 22:28:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH V2 1/2] Swiotlb: Add swiotlb_alloc_from_low_pages switch
Content-Language: en-US
From: Tianyu Lan <ltykernel@gmail.com>
To: Christoph Hellwig <hch@lst.de>
References: <20220209122302.213882-1-ltykernel@gmail.com>
 <20220209122302.213882-2-ltykernel@gmail.com> <20220214081919.GA18337@lst.de>
 <4f433f07-05be-f81f-43e8-55c3f1af23b3@gmail.com>
 <20220214135834.GA30150@lst.de>
 <8d052867-ccff-f00f-7c89-cc26a4bfa347@gmail.com>
 <23f4a64d-5977-1816-8faa-fe7691ace2ff@gmail.com>
 <20220222080543.GA5412@lst.de>
 <00112505-4999-ac41-877e-49c4cc45312e@gmail.com>
 <20220222160039.GA13380@lst.de>
 <40f91949-58fa-4be2-5b01-ea34dda58670@gmail.com>
In-Reply-To: <40f91949-58fa-4be2-5b01-ea34dda58670@gmail.com>
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 dave.hansen@linux.intel.com, hpa@zytor.com, kys@microsoft.com,
 hch@infradead.org, wei.liu@kernel.org, sthemmin@microsoft.com, x86@kernel.org,
 decui@microsoft.com, michael.h.kelley@microsoft.com, mingo@redhat.com,
 parri.andrea@gmail.com, thomas.lendacky@amd.com,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, konrad.wilk@oracle.com,
 haiyangz@microsoft.com, bp@alien8.de,
 "krish.sadhukhan@oracle.com" <krish.sadhukhan@oracle.com>, tglx@linutronix.de,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 vkuznets@redhat.com, robin.murphy@arm.com,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
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

T24gMi8yMy8yMDIyIDU6NDYgUE0sIFRpYW55dSBMYW4gd3JvdGU6Cj4gCj4gCj4gT24gMi8yMy8y
MDIyIDEyOjAwIEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPj4gT24gVHVlLCBGZWIgMjIs
IDIwMjIgYXQgMTE6MDc6MTlQTSArMDgwMCwgVGlhbnl1IExhbiB3cm90ZToKPj4+IFRoYW5rcyBm
b3IgeW91ciBjb21tZW50LiBUaGF0IG1lYW5zIHdlIG5lZWQgdG8gZXhwb3NlIGFuCj4+PiBzd2lv
dGxiX2RldmljZV9pbml0KCkgaW50ZXJmYWNlIHRvIGFsbG9jYXRlIGJvdW5jZSBidWZmZXIgYW5k
IGluaXRpYWxpemUKPj4+IGlvIHRsYiBtZW0gZW50cnkuIERNQSBBUEkgQ3VycmVudMKgIHJtZW1f
c3dpb3RsYl9kZXZpY2VfaW5pdCgpIG9ubHkgd29ya3MKPj4+IGZvciBwbGF0Zm9ybSB3aXRoIGRl
dmljZSB0cmVlLiBUaGUgbmV3IEFQSSBzaG91bGQgYmUgY2FsbGVkIGluIHRoZSBidXMKPj4+IGRy
aXZlciBvciBuZXcgRE1BIEFQSS4gQ291bGQgeW91IGNoZWNrIHdoZXRoZXIgdGhpcyBpcyBhIHJp
Z2h0IHdheSAKPj4+IGJlZm9yZQo+Pj4gd2Ugc3RhcnQgdGhlIHdvcmsuCj4+Cj4+IERvIHRoZXNl
IFZNcyB1c2UgQUNQST/CoCBXZSdkIHByb2JhYmx5IHJlYWxseSB3YW50IHNvbWUga2luZCBvZiBo
aWdoZXIKPj4gbGV2ZWwgY29uZmlndXJhdGlvbiBhbmQgbm90IGhhdmUgdGhlIGRyaXZlcnMgcmVx
dWVzdCBpdCB0aGVtc2VsdmVzLgo+IAo+IFllcywgSHlwZXItViBpc29sYXRpb24gVk0gdXNlcyBB
Q1BJLiBEZXZpY2VzIGFyZSBlbnVtZXJhdGVkIHZpYSB2bWJ1cyAKPiBob3N0IGFuZCB0aGVyZSBp
cyBubyBjaGlsZCBkZXZpY2UgaW5mb3JtYXRpb24gaW4gQUNQSSB0YWJsZS4gVGhlIGhvc3QgCj4g
ZHJpdmVyIHNlZW1zIHRvIGJlIHRoZSByaWdodCBwbGFjZSB0byBjYWxsIG5ldyBBUEkuCgpIaSBD
aHJpc3RvcGg6CiAgICAgIE9uZSBtb3JlIHBlcnNwZWN0aXZlIGlzIHRoYXQgb25lIGRldmljZSBt
YXkgaGF2ZSBtdWx0aXBsZSBxdWV1ZXMgCmFuZCBlYWNoIHF1ZXVlcyBzaG91bGQgaGF2ZSBpbmRl
cGVuZGVudCBzd2lvdGxiIGJvdW5jZSBidWZmZXIgdG8gYXZvaWQgCnNwaW4gbG9jayBvdmVyaGVh
ZC4gVGhlIG51bWJlciBvZiBxdWV1ZXMgaXMgb25seSBhdmFpbGFibGUgaW4gdGhlIGRldmljZQpk
cml2ZXIuIFRoaXMgbWVhbnMgbmV3IEFQSSBuZWVkcyB0byBiZSBjYWxsZWQgaW4gdGhlIGRldmlj
ZSBkcml2ZXIgCmFjY29yZGluZyB0byBxdWV1ZSBudW1iZXIuCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby9pb21tdQ==
