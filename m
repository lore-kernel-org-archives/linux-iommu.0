Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C205C47083
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 02:53:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4536613E9
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 02:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4536613E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 89741404E2;
	Thu,  3 Jun 2021 02:53:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3a9UwXWbSKkS; Thu,  3 Jun 2021 02:53:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 72CAC404D7;
	Thu,  3 Jun 2021 02:53:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C437C000E;
	Thu,  3 Jun 2021 02:53:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 610F0C0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 02:53:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5B24E404E2
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 02:53:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XjtvZ0RYmp3z for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 02:53:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 97F9A404D7
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 02:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622688785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rml3snF+8HtrCauMNf32U0cEH6eDUnFGeUKsyp+NXXo=;
 b=GLBbWnwzrgqctkbwhsFnI0PArKDiulyouAdoRiN+6H1DZ5bkHBCqE17/2KY9hVO0TI/JID
 9lC4XiX4r56r7uBDvGBUFNLZdPOpPq3PvhN4qTyYBLjAgO4Ae+ikWVCXFc1+fX+1j8+CEE
 CRpvaQ6XJP3K3jHzYUPsJcqXlFP3X50=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-nHaXADYpOhSKCs2os5028A-1; Wed, 02 Jun 2021 22:53:02 -0400
X-MC-Unique: nHaXADYpOhSKCs2os5028A-1
Received: by mail-pl1-f197.google.com with SMTP id
 t10-20020a1709027fcab02900fd1eb0b2e8so1975839plb.22
 for <iommu@lists.linux-foundation.org>; Wed, 02 Jun 2021 19:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=rml3snF+8HtrCauMNf32U0cEH6eDUnFGeUKsyp+NXXo=;
 b=qxHKA/wscqTuDhipTqegtr3Zym/Rcv92/oLs0mZLM2JY3Z1Kb0R1FnMH47vthly06O
 VMTXd1bfJrWWPV6CC5krSWDlT6fsJlK4KRL7TP18P+6Byh97w9EpCUPmxlKKrKxK8sMQ
 PHCAQltJsMCZiSHG8pL800Jxn45hJ6wSa2sUPh75m3EBgnmYxGkbb68HZzKoUdpsigZe
 sXw7nMZzmhDp7EMkbL5hrmuvJHQIOaYAHauOQbp6tgeKMK7tNO/2/UKfvWpZDthSurG1
 p6vTU6w7wS/rNCN3zc78o0i4wRVhbzoU9FvfMse8XZp/kP0838aKHne08zaZZVKPtaO9
 mRXw==
X-Gm-Message-State: AOAM530JKCZK/wxW4M4gu/0Dj/Vr4uroO5JRoGlTHQOmUbrZa8/nk6Nb
 kiSn9yOiU0xf6NjGtkVB028/mZ8q9ElJGVp/IQBrDJaLf2cta0UVwUL03NUvVotPQyXYjxf4lIr
 V9eEtaofQmyBRmOcQSJdhLwKBQERquQ==
X-Received: by 2002:a17:902:e74d:b029:10d:9cd0:2c69 with SMTP id
 p13-20020a170902e74db029010d9cd02c69mr2020517plf.82.1622688780894; 
 Wed, 02 Jun 2021 19:53:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGUUgfYG9dvW5sJE4TeEfDd6nGvhT7VXFCR8OU+oXimuG2T2IbG4AbopH90YZ4ENmXiBET0w==
X-Received: by 2002:a17:902:e74d:b029:10d:9cd0:2c69 with SMTP id
 p13-20020a170902e74db029010d9cd02c69mr2020503plf.82.1622688780610; 
 Wed, 02 Jun 2021 19:53:00 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id ls13sm609152pjb.23.2021.06.02.19.52.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jun 2021 19:53:00 -0700 (PDT)
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To: Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20210528200311.GP1002214@nvidia.com>
 <MWHPR11MB188685D57653827B566BF9B38C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210601162225.259923bc.alex.williamson@redhat.com>
 <MWHPR11MB1886E8454A58661DC2CDBA678C3D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210602160140.GV1002214@nvidia.com>
 <20210602111117.026d4a26.alex.williamson@redhat.com>
 <20210602173510.GE1002214@nvidia.com>
 <20210602120111.5e5bcf93.alex.williamson@redhat.com>
 <20210602180925.GH1002214@nvidia.com>
 <20210602130053.615db578.alex.williamson@redhat.com>
 <20210602195404.GI1002214@nvidia.com>
 <20210602143734.72fb4fa4.alex.williamson@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6a9426d7-ed55-e006-9c4c-6b7c78142e39@redhat.com>
Date: Thu, 3 Jun 2021 10:52:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210602143734.72fb4fa4.alex.williamson@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
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
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

CuWcqCAyMDIxLzYvMyDkuIrljYg0OjM3LCBBbGV4IFdpbGxpYW1zb24g5YaZ6YGTOgo+IE9uIFdl
ZCwgMiBKdW4gMjAyMSAxNjo1NDowNCAtMDMwMAo+IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRp
YS5jb20+IHdyb3RlOgo+Cj4+IE9uIFdlZCwgSnVuIDAyLCAyMDIxIGF0IDAxOjAwOjUzUE0gLTA2
MDAsIEFsZXggV2lsbGlhbXNvbiB3cm90ZToKPj4+IFJpZ2h0LCB0aGUgZGV2aWNlIGNhbiBnZW5l
cmF0ZSB0aGUgbm8tc25vb3AgdHJhbnNhY3Rpb25zLCBidXQgaXQncyB0aGUKPj4+IElPTU1VIHRo
YXQgZXNzZW50aWFsbHkgZGV0ZXJtaW5lcyB3aGV0aGVyIHRob3NlIHRyYW5zYWN0aW9ucyBhcmUK
Pj4+IGFjdHVhbGx5IHN0aWxsIGNhY2hlIGNvaGVyZW50LCBBSVVJLgo+PiBXb3csIHRoaXMgaXMg
cmVhbGx5IGNvbmZ1c2luZyBzdHVmZiBpbiB0aGUgY29kZS4KPj4KPj4gQXQgdGhlIFBDSSBsZXZl
bCB0aGVyZSBpcyBhIFRMUCBiaXQgY2FsbGVkIG5vLXNub29wIHRoYXQgaXMgcGxhdGZvcm0KPj4g
c3BlY2lmaWMuIFRoZSBnZW5lcmFsIGludGVudGlvbiBpcyB0byBhbGxvdyBkZXZpY2VzIHRvIHNl
bGVjdGl2ZWx5Cj4+IGJ5cGFzcyB0aGUgQ1BVIGNhY2hpbmcgZm9yIERNQXMuIEdQVXMgbGlrZSB0
byB1c2UgdGhpcyBmZWF0dXJlIGZvcgo+PiBwZXJmb3JtYW5jZS4KPiBZZXMKPgo+PiBJIGFzc3Vt
ZSB0aGVyZSBpcyBzb21lIGV4Y2l0aW5nIHNlY3VyaXR5IGlzc3VlcyBoZXJlLiBMb29rcyBsaWtl
Cj4+IGFsbG93aW5nIGNhY2hlIGJ5cGFzcyBkb2VzIHNvbWV0aGluZyBiYWQgaW5zaWRlIFZNcz8g
TG9va3MgbGlrZQo+PiBhbGxvd2luZyB0aGUgVk0gdG8gdXNlIHRoZSBjYWNoZSBjbGVhciBpbnN0
cnVjdGlvbiB0aGF0IGlzIG1hbmRhdG9yeQo+PiB3aXRoIGNhY2hlIGJ5cGFzcyBETUEgY2F1c2Vz
IHNvbWUgUU9TIGlzc3Vlcz8gT0suCj4gSUlSQywgbGFyZ2VseSBhIERvUyBpc3N1ZSBpZiB1c2Vy
c3BhY2UgZ2V0cyB0byBjaG9vc2Ugd2hlbiB0byBlbXVsYXRlCj4gd2JpbnZkIHJhdGhlciB0aGFu
IGl0IGJlaW5nIGRlbWFuZGVkIGZvciBjb3JyZWN0IG9wZXJhdGlvbi4KPgo+PiBTbyBob3cgZG9l
cyBpdCB3b3JrPwo+Pgo+PiBXaGF0IEkgc2VlIGluIHRoZSBpbnRlbC9pb21tdS5jIGlzIHRoYXQg
c29tZSBkb21haW5zIHN1cHBvcnQgInNub29wCj4+IGNvbnRyb2wiIG9yIG5vdCwgYmFzZWQgb24g
c29tZSBIVyBmbGFnLiBUaGlzIGluZGljYXRlcyBpZiB0aGUKPj4gRE1BX1BURV9TTlAgYml0IGlz
IHN1cHBvcnRlZCBvbiBhIHBhZ2UgYnkgcGFnZSBiYXNpcyBvciBub3QuCj4+Cj4+IFNpbmNlIHg4
NiBhbHdheXMgbGVhbnMgdG93YXJkICJETUEgY2FjaGUgY29oZXJlbnQiIEknbSByZWFkaW5nIHNv
bWUKPj4gdGVhIGxlYXZlcyBoZXJlOgo+Pgo+PiAJSU9NTVVfQ0FQX0NBQ0hFX0NPSEVSRU5DWSwJ
LyogSU9NTVUgY2FuIGVuZm9yY2UgY2FjaGUgY29oZXJlbnQgRE1BCj4+IAkJCQkJICAgdHJhbnNh
Y3Rpb25zICovCj4+Cj4+IEFuZCBndWVzc2luZyB0aGF0IElPTU1VcyB0aGF0IGltcGxlbWVudCBE
TUFfUFRFX1NOUCB3aWxsIGlnbm9yZSB0aGUKPj4gc25vb3AgYml0IGluIFRMUHMgZm9yIElPVkEn
cyB0aGF0IGhhdmUgRE1BX1BURV9TTlAgc2V0Pwo+IFRoYXQncyBteSB1bmRlcnN0YW5kaW5nIGFz
IHdlbGwuCj4KPj4gRnVydGhlciwgSSBndWVzcyBJT01NVXMgdGhhdCBkb24ndCBzdXBwb3J0IFBU
RV9TTlAsIG9yIGhhdmUKPj4gRE1BX1BURV9TTlAgY2xlYXIgd2lsbCBhbHdheXMgaG9ub3VyIHRo
ZSBzbm9vcCBiaXQuIChiYWNrd2FyZHMgY29tcGF0Cj4+IGFuZCBhbGwpCj4gWWVzLgo+Cj4+IFNv
LCBJT01NVV9DQVBfQ0FDSEVfQ09IRVJFTkNZIGRvZXMgbm90IG1lYW4gdGhlIElPTU1VIGlzIERN
QQo+PiBpbmNvaGVyZW50IHdpdGggdGhlIENQVSBjYWNoZXMsIGl0IGp1c3QgbWVhbnMgdGhhdCB0
aGF0IHNub29wIGJpdCBpbgo+PiB0aGUgVExQIGNhbm5vdCBiZSBlbmZvcmNlZC4gaWUgdGhlIGRl
dmljZSAqY291bGQqIGRvIG5vLXNob29wIERNQQo+PiBpZiBpdCB3YW50cy4gRGV2aWNlcyB0aGF0
IG5ldmVyIGRvIG5vLXNub29wIHJlbWFpbiBETUEgY29oZXJlbnQgb24KPj4geDg2LCBhcyB0aGV5
IGFsd2F5cyBoYXZlIGJlZW4uCj4gWWVzLCBJT01NVV9DQVBfQ0FDSEVfQ09IRVJFTkNZPWZhbHNl
IG1lYW5zIHdlIGNhbm5vdCBmb3JjZSB0aGUgZGV2aWNlCj4gRE1BIHRvIGJlIGNvaGVyZW50IHZp
YSB0aGUgSU9NTVUuCj4KPj4gSU9NTVVfQ0FDSEUgZG9lcyBub3QgbWVhbiB0aGUgSU9NTVUgaXMg
RE1BIGNhY2hlIGNvaGVyZW50LCBpdCBtZWFucwo+PiB0aGUgUENJIGRldmljZSBpcyBibG9ja2Vk
IGZyb20gdXNpbmcgbm8tc25vb3AgaW4gaXRzIFRMUHMuCj4+Cj4+IEkgd29uZGVyIGlmIEFSTSBp
bXBsZW1lbnRlZCB0aGlzIGNvbnNpc3RlbnRseT8gSSBzZWUgVkRQQSBpcwo+PiBjb25mdXNlZC4u
CgoKQmFzaWNhbGx5LCB3ZSBkb24ndCB3YW50IHRvIGJvdGhlciB3aXRoIHBzZXVkbyBLVk0gZGV2
aWNlIGxpa2Ugd2hhdCBWRklPIApkaWQuIFNvIGZvciBzaW1wbGljaXR5LCB3ZSBydWxlcyBvdXQg
dGhlIElPTU1VIHRoYXQgY2FuJ3QgZW5mb3JjZSAKY29oZXJlbmN5IGluIHZob3N0LXZEUEEgaWYg
dGhlIHBhcmVudCBwdXJlbHkgZGVwZW5kcyBvbiB0aGUgcGxhdGZvcm0gSU9NTVU6CgoKIMKgwqDC
oMKgwqDCoMKgIGlmICghaW9tbXVfY2FwYWJsZShidXMsIElPTU1VX0NBUF9DQUNIRV9DT0hFUkVO
Q1kpKQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRU5PVFNVUFA7CgpG
b3IgdGhlIHBhcmVudHMgdGhhdCB1c2UgaXRzIG93biB0cmFuc2xhdGlvbnMgbG9naWMsIGFuIGlt
cGxpY2l0IAphc3N1bXB0aW9uIGlzIHRoYXQgdGhlIGhhcmR3YXJlIHdpbGwgYWx3YXlzIHBlcmZv
cm0gY2FjaGUgY29oZXJlbnQgRE1BLgoKVGhhbmtzCgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2lvbW11
