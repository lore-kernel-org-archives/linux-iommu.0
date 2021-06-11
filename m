Return-Path: <SRS0=1MD/=LF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F44EC4743D
	for <iommu@archiver.kernel.org>; Fri, 11 Jun 2021 05:44:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE2D961374
	for <iommu@archiver.kernel.org>; Fri, 11 Jun 2021 05:44:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE2D961374
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E28C83B58;
	Fri, 11 Jun 2021 05:44:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qCIO7pBcbyJo; Fri, 11 Jun 2021 05:44:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 916CD83B48;
	Fri, 11 Jun 2021 05:44:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64A1BC000E;
	Fri, 11 Jun 2021 05:44:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30AC2C000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 05:44:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0F2E0606A9
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 05:44:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0SXk9Od_2AWz for <iommu@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 05:44:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0478C6066A
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 05:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623390250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5nlidzY7vVox2ieeNTmLbeG44JwkLPe3MMhpIq19x6g=;
 b=LOiTUDx60R9wOz9sP1ZGZtlwFXZen6zjRQvWMitayuXLMNIcTLGlDvaUF3WVODXI8I35q7
 iC5GJros2ztPy4IZuHHeOWvIAZPoIshMuJIs4cISIPcMr8QCZIZeoMxJ19vNCCOGDXS0aU
 rlpnURci5sjJN8MvfCzJQE+fbqDvKZ0=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-gBzea7UvMyqBgwJUAzn97Q-1; Fri, 11 Jun 2021 01:44:09 -0400
X-MC-Unique: gBzea7UvMyqBgwJUAzn97Q-1
Received: by mail-pf1-f197.google.com with SMTP id
 j206-20020a6280d70000b02902e9e02e1654so2616940pfd.6
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 22:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=5nlidzY7vVox2ieeNTmLbeG44JwkLPe3MMhpIq19x6g=;
 b=YrOf2Y2dasRoMObSJvwmpQJjCNZEJBrVo0aW0iiYJ34hohiq75fy8AAE6PdrHyob6B
 Wm5x/yQZRnaig6LLGYabtfehayWWtSHaXs9Z2HW9MdX5LFoF40A/46Dcb0+4hFt3GRM9
 GhOOpjFlMFVREGkcYVZyt6JtGKRG9vDtQ1eES0Hth7hEWOlPNYsgvaN8QwOXG8PWFboo
 zbTugF2eyfkpfZnhQrS8yfl5DT6Jg9p8zy8pQWirWEMlA4ZQ4sYYa2miDnTX3mZGQxjN
 FkrofcW+fY4I5AlhMRcHK9Y+z9gs7bvRDsNWVEj3cb98c91JngGU+MG1ZWvwHNvwhOzk
 Z2Zg==
X-Gm-Message-State: AOAM532UEsJPZSmSukqlfJkWf75nLe+OIi7lyNhyuqpZrzq3Av6MSSQV
 TZcDNxY23DOxL90CfRqsWa+lMInj+VBDAFLqkLsWrbnLeo8EML25Q3oHEU7vnUYgYZv8oS0dz6I
 s1tgVUYdW+t1tRrygNAuUlRaDGwxtcw==
X-Received: by 2002:a63:6547:: with SMTP id z68mr1935897pgb.341.1623390248322; 
 Thu, 10 Jun 2021 22:44:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKB65M93ciDtRjp4dLL7boO1gINllpJ4guVwZKP5dhsZp4Ljb4TFphg7Htp0BodlrU9JnK0w==
X-Received: by 2002:a63:6547:: with SMTP id z68mr1935883pgb.341.1623390248048; 
 Thu, 10 Jun 2021 22:44:08 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id d8sm4085729pfq.198.2021.06.10.22.44.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jun 2021 22:44:07 -0700 (PDT)
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To: Jason Gunthorpe <jgg@nvidia.com>
References: <MWHPR11MB1886FC7A46837588254794048C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <05d7f790-870d-5551-1ced-86926a0aa1a6@redhat.com>
 <MWHPR11MB1886269E2B3DE471F1A9A7618C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <42a71462-1abc-0404-156c-60a7ee1ad333@redhat.com>
 <20210601173138.GM1002214@nvidia.com>
 <f69137e3-0f60-4f73-a0ff-8e57c79675d5@redhat.com>
 <20210602172154.GC1002214@nvidia.com>
 <c84787ec-9d8f-3198-e800-fe0dc8eb53c7@redhat.com>
 <20210608132039.GG1002214@nvidia.com>
 <f4d70f28-4bd6-5315-d7c7-0a509e4f1d1d@redhat.com>
 <20210610114751.GK1002214@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d2193dbd-0d55-7315-4e76-eea7f8cc8f5b@redhat.com>
Date: Fri, 11 Jun 2021 13:43:59 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210610114751.GK1002214@nvidia.com>
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

CuWcqCAyMDIxLzYvMTAg5LiL5Y2INzo0NywgSmFzb24gR3VudGhvcnBlIOWGmemBkzoKPiBPbiBU
aHUsIEp1biAxMCwgMjAyMSBhdCAxMDowMDowMUFNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+
PiDlnKggMjAyMS82Lzgg5LiL5Y2IOToyMCwgSmFzb24gR3VudGhvcnBlIOWGmemBkzoKPj4+IE9u
IFR1ZSwgSnVuIDA4LCAyMDIxIGF0IDA5OjEwOjQyQU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6
Cj4+Pgo+Pj4+IFdlbGwsIHRoaXMgc291bmRzIGxpa2UgYSByZS1pbnZlbnRpb24gb2YgaW9fdXJp
bmcgd2hpY2ggaGFzIGFscmVhZHkgd29ya2VkCj4+Pj4gZm9yIG11bHRpZmRzLgo+Pj4gSG93IHNv
PyBpb191cmluZyBpcyBhYm91dCBzZW5kaW5nIHdvcmsgdG8gdGhlIGtlcm5lbCwgbm90IGdldHRp
bmcKPj4+IHN0cnVjdHVlZCBldmVudHMgYmFjaz8KPj4KPj4gQWN0dWFsbHkgaXQgY2FuLiBVc2Vy
c3BhY2UgY2FuIHBvbGwgbXVsdGlwbGUgZmRzIHZpYSBwcmVwYXJpbmcgbXVsdGlwbGUgc3Flcwo+
PiB3aXRoIElPUklOR19PUF9BREQgZmxhZy4KPiBQb2xsIGlzIG9ubHkgYSBwYXJ0IG9mIHdoYXQg
aXMgbmVlZGVkIGhlcmUsIHRoZSBtYWluIGlzc3VlIGlzCj4gdHJhbnNmZXJpbmcgdGhlIFBSSSBl
dmVudHMgdG8gdXNlcnNwYWNlIHF1aWNrbHkuCgoKRG8gd2UgcmVhbGx5IGNhcmUgZS5nIGF0IG1v
c3Qgb25lIG1vcmUgc3lzY2FsbCBpbiB0aGlzIGNhc2U/IEkgdGhpbmsgdGhlIAp0aW1lIHNwZW50
IG9uIGRlbWFuZCBwYWdpbmcgaXMgbXVjaCBtb3JlIHRoYW4gdHJhbnNmZXJyaW5nICNQRiB0byAK
dXNlcnNwYWNlLiBXaGF0J3MgbW9yZSwgYSB3ZWxsIGRlc2lnbmVkIHZJT01NVSBjYXBhYmxlIElP
TU1VIGhhcmR3YXJlIApzaG91bGQgaGF2ZSB0aGUgYWJpbGl0eSB0byBpbmplY3Qgc3VjaCBldmVu
dCBkaXJlY3RseSB0byBndWVzdCBpZiAjUEYgCmhhcHBlbnMgb24gTDEuCgoKPgo+PiBUaGlzIG1l
YW5zIGFub3RoZXIgcmluZyBhbmQgd2UgbmVlZCBpbnRyb2R1Y2UgaW9jdGwoKSB0byBhZGQgb3Ig
cmVtb3ZlCj4+IGlvYXNpZHMgZnJvbSB0aGUgcG9sbC4gQW5kIGl0IHN0aWxsIG5lZWQgYSBraW5k
IG9mIGZhbGxiYWNrIGxpa2UgYSBsaXN0IGlmCj4+IHRoZSByaW5nIGlzIGZ1bGwuCj4gVGhlIG1h
eCBzaXplIG9mIHRoZSByaW5nIHNob3VsZCBiZSBkZXRlcm1pbmFibGUgYmFzZWQgb24gdGhlIFBS
SQo+IGNvbmN1cnJhbmNlIG9mIGVhY2ggZGV2aWNlIGFuZCB0aGUgbnVtYmVyIG9mIGRldmljZXMg
c2hhcmluZyB0aGUgcmluZwoKClRoaXMgaGFzIGF0IGxlYXN0IG9uZSBhc3N1bXB0aW9uLCAjUEYg
ZXZlbnQgaXMgdGhlIG9ubHkgZXZlbnQgZm9yIHRoZSAKcmluZywgSSdtIG5vdCBzdXJlIHRoaXMg
aXMgdGhlIGNhc2UuCgpUaGFua3MKCgo+Cj4gSW4gYW55IGV2ZW50LCBJJ20gbm90IGVudGlyZWx5
IGNvbnZpbmNlZCBlbGlkaW5nIHRoZSBQUkkgdXNlci9rZXJuZWwKPiBjb3B5IGlzIHRoZSBtYWlu
IGlzc3VlIGhlcmUuLiBJZiB3ZSB3YW50IHRoaXMgdG8gYmUgbG93IGxhdGVuY3kgSQo+IHRoaW5r
IGl0IGVuZHMgdXAgd2l0aCBzb21lIGtlcm5lbCBkcml2ZXIgY29tcG9uZW50IGFzc2lzdGluZyB0
aGUKPiB2SU9NTVUgZW11bGF0aW9uIGFuZCBhdm9pZGluZyB0aGUgcm91bmQgdHJpcCB0byB1c2Vy
c3BhY2UKPgo+IEphc29uCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9p
b21tdQ==
