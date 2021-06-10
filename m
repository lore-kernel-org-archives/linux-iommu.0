Return-Path: <SRS0=Vfdp=LE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722E7C48BCF
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 02:16:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21E9A613AA
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 02:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21E9A613AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E2F5E40552;
	Thu, 10 Jun 2021 02:16:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B7xn41OWz2Ja; Thu, 10 Jun 2021 02:16:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D36D040542;
	Thu, 10 Jun 2021 02:16:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8DA0CC000D;
	Thu, 10 Jun 2021 02:16:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86DD5C000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 02:16:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5A3C440552
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 02:16:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b986sZK7Q7Ge for <iommu@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 02:16:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4351C40542
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 02:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623291392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NnaUokRoNM6Q2FbT2TvIPzJXqmr5yWwj9gPCdPyZQmw=;
 b=TXT6zGzbkXDyBXG+5rPQtHv51pP8Mdg/w9GFrznaFb29eJw9SHEAgBvughh4G4SseoUvrc
 Nzdyd0KT44DvhwIat5B3D+3TjtcyJlRQYqRi485v2e1JAclYD/8VC0+mViGF8pU3O40wIG
 +dQDId/G6PHtwFx4b1nfszxc8Mmnyck=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-TFSosFIXPNiFiVYU-RiXHQ-1; Wed, 09 Jun 2021 22:16:30 -0400
X-MC-Unique: TFSosFIXPNiFiVYU-RiXHQ-1
Received: by mail-pj1-f70.google.com with SMTP id
 hf1-20020a17090aff81b02901630f822d2aso2848270pjb.6
 for <iommu@lists.linux-foundation.org>; Wed, 09 Jun 2021 19:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=NnaUokRoNM6Q2FbT2TvIPzJXqmr5yWwj9gPCdPyZQmw=;
 b=PKxmNbpM5bBAa8EfOkNYVlyfdhZADo+l8B601qVpv/hS3+cl5txxSYkwhbxfkOtG1F
 VGp8LB6GiBhQLxxq7Kf5742qn1d1fzrxc4Cgwk0OXGiMEQl8XlT1IoWRXyUKmvk5l+bg
 HcdLVFr7OngidExgVSAUPq1GbncBPRDyW9jd/tzs5Z3bjuGnOC1dk/EqZ8JH+MzMH5A+
 ek8dxoORD+V0XkTB+31eIJqWY1Eh1CqQbz9vKPSoNCZsGNah+wTwmtgwW0bGDzsirhY5
 g0t4nm5S6sjp0qLvoPeOZYW2raaailCvvIFEAOZX9mkFykc2kY85+0VqBIxJ1ARdXtVb
 BBSQ==
X-Gm-Message-State: AOAM533pbO+N6zkMOSAXo7oT1GG11jYt6qtNOwNvhaTtHTjiBdVEbgNQ
 k9yLPM0KIC8+qF4E+2yqzkMjsZ8eSGZ6SVzeLcT1sbUcnPg/irwL2gkCxgHf5pPnKPxoNkt0RV1
 OZB6NI/PLzE9V/2axVWJFPlY/QhCkAA==
X-Received: by 2002:a63:4814:: with SMTP id v20mr2691499pga.8.1623291389543;
 Wed, 09 Jun 2021 19:16:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGFH3+Zi1qg8fLvGeVh2H1tnJw2kTEQ1WuxGNYkVj+kLoxCEbUmdaVO29Ee6FLnMdfVVUCXA==
X-Received: by 2002:a63:4814:: with SMTP id v20mr2691486pga.8.1623291389293;
 Wed, 09 Jun 2021 19:16:29 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id b14sm889674pgl.52.2021.06.09.19.16.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jun 2021 19:16:28 -0700 (PDT)
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <64898584-a482-e6ac-fd71-23549368c508@linux.intel.com>
 <429d9c2f-3597-eb29-7764-fad3ec9a934f@redhat.com>
 <MWHPR11MB1886FC7A46837588254794048C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <05d7f790-870d-5551-1ced-86926a0aa1a6@redhat.com>
 <MWHPR11MB1886269E2B3DE471F1A9A7618C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <42a71462-1abc-0404-156c-60a7ee1ad333@redhat.com>
 <20210601173138.GM1002214@nvidia.com>
 <f69137e3-0f60-4f73-a0ff-8e57c79675d5@redhat.com>
 <20210602172154.GC1002214@nvidia.com>
 <51e060a3-fc59-0a13-5955-71692b14eed8@metux.net>
 <20210607180144.GL1002214@nvidia.com>
 <633b00c1-b388-856a-db71-8d74e52c2702@metux.net>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0f9224eb-2158-4769-f709-6e8f56c24bd3@redhat.com>
Date: Thu, 10 Jun 2021 10:16:17 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <633b00c1-b388-856a-db71-8d74e52c2702@metux.net>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)\"\""
 <alex.williamson@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Woodhouse <dwmw2@infradead.org>
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

CuWcqCAyMDIxLzYvOCDkuIvljYg2OjQ1LCBFbnJpY28gV2VpZ2VsdCwgbWV0dXggSVQgY29uc3Vs
dCDlhpnpgZM6Cj4gT24gMDcuMDYuMjEgMjA6MDEsIEphc29uIEd1bnRob3JwZSB3cm90ZToKPj4g
PHNocnVnPiBpdCBpcyB3aGF0IGl0IGlzLCBzZWxlY3QgaGFzIGEgZml4ZWQgc2l6ZSBiaXRtYXAg
b2YgRkQgI3MgYW5kCj4+IGEgaGFyZCB1cHBlciBib3VuZCBvbiB0aGF0IHNpemUgYXMgcGFydCBv
ZiB0aGUgZ2xpYmMgQUJJIC0gY2FuJ3QgYmUKPj4gZml4ZWQuCj4KPiBpbiBnbGliYyBBQkkgPyBV
dXV1aCEKPgoKTm90ZSB0aGF0IGRlYWxpbmcgd2l0aCBzZWxlY3QoKSBvciB0cnkgdG8gb3ZlcmNv
bWUgdGhlIGxpbWl0YXRpb24gdmlhIAplcG9sbCgpIGRpcmVjdGx5IHZpYSB0aGUgYXBwbGljYXRp
b24gaXMgbm90IGEgZ29vZCBwcmFjdGljZSAob3IgaXQncyBub3QgCnBvcnRhYmxlKS4KCkl0J3Mg
c3VnZ2VzdGVkIHRvIHVzZSBidWlsZGluZyBibG9ja3MgcHJvdmlkZWQgYnkgZ2xpYiwgZS5nIHRo
ZSBtYWluIApldmVudCBsb29wWzFdLiBUaGF0IGlzIGhvdyBRZW11IHNvbHZlIHRoZSBpc3N1ZXMg
b2YgZGVhbGluZyB3aXRoIGEgbG90IApvZiBmaWxlIGRlc2NyaXB0b3JzLgoKVGhhbmtzCgpbMV0g
aHR0cHM6Ly9kZXZlbG9wZXIuZ25vbWUub3JnL2dsaWIvc3RhYmxlL2dsaWItVGhlLU1haW4tRXZl
bnQtTG9vcC5odG1sCgoKPgo+IC0tbXR4Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby9pb21tdQ==
