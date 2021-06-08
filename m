Return-Path: <SRS0=69++=LC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1360BC47094
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 01:00:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A234D61059
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 01:00:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A234D61059
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6ADBA605DD;
	Tue,  8 Jun 2021 01:00:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G-TmC-gyFpZn; Tue,  8 Jun 2021 01:00:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6346260888;
	Tue,  8 Jun 2021 01:00:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25B13C000D;
	Tue,  8 Jun 2021 01:00:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F00F8C0001
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 01:00:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CEDE44029A
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 01:00:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W1dnSWF_DMem for <iommu@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 01:00:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6E40540281
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 01:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623114029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l9Hxnp9TzX1Qa0LPCbDI+r/Swgm1W5T0HqpzgDaMsIM=;
 b=cJCSUgDFNaKbpGVyueCsW9AsPJ87rUUNJ2uMBjgxXT2QJvdiZBdYfxXHP3+/3p6nGYzEWg
 tmD9Sw/ctpoL8CGN2Jao+RWPj6m+4UmOTw2ch+nQomfNLK+jYu4/ul7/uLSGdM5FMIH/GF
 Uck9AV0RXzwXaKJm07iuCruZvckdEOY=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-lUJb04c3MBaRWMVWiLSRTQ-1; Mon, 07 Jun 2021 21:00:28 -0400
X-MC-Unique: lUJb04c3MBaRWMVWiLSRTQ-1
Received: by mail-pg1-f199.google.com with SMTP id
 k9-20020a63d1090000b029021091ebb84cso11172569pgg.3
 for <iommu@lists.linux-foundation.org>; Mon, 07 Jun 2021 18:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=l9Hxnp9TzX1Qa0LPCbDI+r/Swgm1W5T0HqpzgDaMsIM=;
 b=PWWp463IkB075/lf51lba9NYCW14W2XC70oBkn9yzj6kKbsmFuNJRlB8UsQp+LOuX1
 7/ODQiguo0Z2dcF2BpNPPbfyk6yynmYZ0X/mf5EHfFu97jmAhxl5DEFaiF2j57PZUQFN
 0LIyRXLliyQVPpKGxC4v5XQWzaIt2tAm8QFNkcbSG9CpWXwQVaE2plnzUnDwR5NRreRu
 0RgABX6S5XuLHkPcpTVNuHZ5M9FZi4/RZGTWI4F7DXPAasWSHFk9MAdjbywRpkXr/aEX
 10AGlx42Jjpmpht/4ncCPdvmGaxElbihXGeDMjaWQnGoPzwPY3/h91jvc82dTS1wzpCo
 jyoA==
X-Gm-Message-State: AOAM533CUOvc9IXdjXv5qDg77AayvoRNC0823ov/xEmVIrFOvB5CbIcn
 wjzngGmH8a4SayKw3A3trDmDqZNXiRZNG6YYyBQJk7/rcUFOhre44a74v373j/1g1im9WKmcjl/
 skRl/dyJv6fYhaE7yjd43kacVVQ0HGw==
X-Received: by 2002:a17:90a:db0f:: with SMTP id
 g15mr1973151pjv.156.1623114027001; 
 Mon, 07 Jun 2021 18:00:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYWbmdIHR4JeIkPyMKnrD47V0fE4/gLC34oE2C1BXzJ6Yk+6wQV2cQXaOEH+lTIww5tPr8Pg==
X-Received: by 2002:a17:90a:db0f:: with SMTP id
 g15mr1973123pjv.156.1623114026742; 
 Mon, 07 Jun 2021 18:00:26 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id w142sm9258485pff.154.2021.06.07.18.00.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jun 2021 18:00:26 -0700 (PDT)
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20210602120111.5e5bcf93.alex.williamson@redhat.com>
 <20210602180925.GH1002214@nvidia.com>
 <20210602130053.615db578.alex.williamson@redhat.com>
 <20210602195404.GI1002214@nvidia.com>
 <20210602143734.72fb4fa4.alex.williamson@redhat.com>
 <6a9426d7-ed55-e006-9c4c-6b7c78142e39@redhat.com>
 <20210603130927.GZ1002214@nvidia.com>
 <65614634-1db4-7119-1a90-64ba5c6e9042@redhat.com>
 <20210604115805.GG1002214@nvidia.com>
 <895671cc-5ef8-bc1a-734c-e9e2fdf03652@redhat.com>
 <20210607141424.GF1002214@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1cf9651a-b8ee-11f1-1f70-db3492a76400@redhat.com>
Date: Tue, 8 Jun 2021 09:00:15 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210607141424.GF1002214@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Robin Murphy <robin.murphy@arm.com>,
 David Gibson <david@gibson.dropbear.id.au>
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNi83IM/CzucxMDoxNCwgSmFzb24gR3VudGhvcnBlINC0tcA6Cj4gT24gTW9uLCBK
dW4gMDcsIDIwMjEgYXQgMTE6MTg6MzNBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPgo+PiBO
b3RlIHRoYXQgbm8gZHJpdmVycyBjYWxsIHRoZXNlIHRoaW5ncyBkb2Vzbid0IG1lYW50IGl0IHdh
cyBub3QKPj4gc3VwcG9ydGVkIGJ5IHRoZSBzcGVjLgo+IE9mIGNvdXJzZSBpdCBkb2VzLiBJZiB0
aGUgc3BlYyBkb2Vzbid0IGRlZmluZSBleGFjdGx5IHdoZW4gdGhlIGRyaXZlcgo+IHNob3VsZCBj
YWxsIHRoZSBjYWNoZSBmbHVzaGVzIGZvciBuby1zbm9vcCB0cmFuc2FjdGlvbnMgdGhlbiB0aGUK
PiBwcm90b2NvbCBkb2Vzbid0IHN1cHBvcnQgbm8tc29vcC4KCgpKdXN0IHRvIG1ha2Ugc3VyZSB3
ZSBhcmUgaW4gdGhlIHNhbWUgcGFnZS4gV2hhdCBJIG1lYW50IGlzLCBpZiB0aGUgRE1BIApiZWhh
dmlvciBsaWtlIChuby1zbm9vcCkgaXMgZGV2aWNlIHNwZWNpZmljLiBUaGVyZSdzIG5vIG5lZWQg
dG8gbWFuZGF0ZSAKYSB2aXJ0aW8gZ2VuZXJhbCBhdHRyaWJ1dGVzLiBXZSBjYW4gZGVzY3JpYmUg
aXQgcGVyIGRldmljZS4gVGhlIGRldmljZXMgCmltcGxlbWVudGVkIGluIHRoZSBjdXJyZW50IHNw
ZWMgZG9lcyBub3QgdXNlIG5vbi1jb2hlcmVudCBETUEgZG9lc24ndCAKbWVhbiBhbnkgZnV0dXJl
IGRldmljZXMgd29uJ3QgZG8gdGhhdC4gVGhlIGRyaXZlciBjb3VsZCBjaG9vc2UgdG8gdXNlIAp0
cmFuc3BvcnQgKGUuZyBQQ0kpLCBwbGF0Zm9ybSAoQUNQSSkgb3IgZGV2aWNlIHNwZWNpZmljIChn
ZW5lcmFsIHZpcnRpbyAKY29tbWFuZCkgd2F5IHRvIGRldGVjdCBhbmQgZmx1c2ggY2FjaGUgd2hl
biBuZWNlc3NhcnkuCgoKPgo+IG5vLXNub29wIGlzIG9ubHkgdXNlZCBpbiB2ZXJ5IHNwZWNpZmlj
IHNlcXVlbmNlcyBvZiBvcGVyYXRpb25zLCBsaWtlCj4gY2VydGFpbiBHUFUgdXNhZ2VzLCBiZWNh
dXNlIHJlZ2FpbmluZyBjb2hlcmVuY2Ugb24geDg2IGlzIGluY3JlZGlibHkKPiBleHBlbnNpdmUu
Cj4KPiBpZSBJIHdvdWxkbid0IGV2ZXIgZXhwZWN0IGEgTklDIHRvIHVzZSBuby1zbm9vcCBiZWNh
dXNlIE5JQydzIGV4cGVjdAo+IHBhY2tldHMgdG8gYmUgcHJvY2Vzc2VkIGJ5IHRoZSBDUFUuCgoK
Rm9yIE5JQyB5ZXMuIEJ1dCB2aXJ0aW8gaXMgbW9yZSB0aGF0IGp1c3QgTklDLiBXZSd2ZSBhbHJl
YWR5IHN1cHBvcnRlZCAKR1BVIGFuZCBjcnlwdG8gZGV2aWNlcy4gSW4gdGhpcyBjYXNlLCBuby1z
bm9vcCB3aWxsIGJlIHVzZWZ1bCBzaW5jZSB0aGUgCmRhdGEgaXMgbm90IG5lY2Vzc2FyaWx5IGV4
cGVjdGVkIHRvIGJlIHByb2Nlc3NlZCBieSBDUFUuCgpBbmQgYSBsb3Qgb2Ygb3RoZXIgdHlwZSBv
ZiBkZXZpY2VzIGFyZSBiZWluZyBwcm9wb3NlZC4KClRoYW5rcwoKCj4KPiAibm9uLWNvaGVyZW50
IERNQSIgaXMgc29tZSBnZW5lcmFsIGV1cGhlbWlzbSB0aGF0IGV2b2tlcyBpbWFnZXMgb2YKPiBl
bWJlZGRlZCBwbGF0Zm9ybXMgdGhhdCBkb24ndCBoYXZlIGNvaGVyZW50IERNQSBhdCBhbGwgYW5k
IGhhdmUgbG93Cj4gY29zdCB3YXlzIHRvIHJlZ2FpbiBjb2hlcmVuY2UuIFRoaXMgaXMgbm90IGF0
IGFsbCB3aGF0IHdlIGFyZSB0YWxraW5nCj4gYWJvdXQgaGVyZSBhdCBhbGwuCj4gICAKPiBKYXNv
bgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21t
dSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
