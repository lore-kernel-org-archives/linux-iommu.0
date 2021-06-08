Return-Path: <SRS0=69++=LC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF910C47082
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 01:11:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61E6361263
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 01:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E6361263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2AFEE605DD;
	Tue,  8 Jun 2021 01:11:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RDGvqT54WrAa; Tue,  8 Jun 2021 01:10:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1EA5D60872;
	Tue,  8 Jun 2021 01:10:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F04C3C000D;
	Tue,  8 Jun 2021 01:10:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA329C0001
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 01:10:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CB4B6402AB
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 01:10:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yDAb3Hh48UhZ for <iommu@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 01:10:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0EF9F400E0
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 01:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623114654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ble1OdVWSdUFgnj3SJybSz6FbcPfrGdp/yR5UPi1dnM=;
 b=AGe7Fw91N1N6Q9oa+tcu78UcGYNg4ht+CpaAlYW6REyw25JrB4NW5BROsVqDwwDz/9IJOz
 yLyftKoO3r/Egxi1AP0jiqPYh7Y/1kQ4//ag0tQ2BFNXKn+Hq13IYaZD7Fi/IL3W1BNF+A
 UaCtiVFLanXtrmgMoPLhqrFYl8Cfe7E=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-8ZRJdysLM4KDyu7H7e_g3A-1; Mon, 07 Jun 2021 21:10:53 -0400
X-MC-Unique: 8ZRJdysLM4KDyu7H7e_g3A-1
Received: by mail-pg1-f197.google.com with SMTP id
 r5-20020a635d050000b0290220f78694c8so5325059pgb.0
 for <iommu@lists.linux-foundation.org>; Mon, 07 Jun 2021 18:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Ble1OdVWSdUFgnj3SJybSz6FbcPfrGdp/yR5UPi1dnM=;
 b=f6z8tvCnW6KdE5mJiQZmP9j56lRmIybsXNd26uiPTeGwNJnIig8NnxhycYROvHgoXi
 +WSW8FQOACflJNz78In/ajUltTu1GXaotbTOXdAbI/KKVB4pO2ipGhFFymYCYZVA4ayg
 JYuuEDGVUJvCfNleI9YBqVh+iSjQuX7Vl2w3VTL/4+My1bBO0L2vQoapJUpL48mR5kTx
 FXLhMbqb4rmi01OtaEgw9sgzVvlZT0qM3TjFqfaEsRo5Zyhg36aNcSnLppQyAOPWrceL
 qSLVxsjayCX5SVJOoVap7yinVGtDOSKolFRyJBSpFiamMUvSBvZfqY0NdmtXQaTsJsoM
 zC1g==
X-Gm-Message-State: AOAM530G20vSc8PzoJ15pvwZI+7f+Sq175gFkvaap5srmwUtXstJh//g
 RyAtb99ekaIq6f8bs4DfGzTQymlk0CuEAln1ReP+zb12ZdvyOSMy/z3KeWjSwXXhBFkQT5vjAfY
 3ZG9/mI1Urd3H+oMceAaFrJIjqe+07Q==
X-Received: by 2002:a17:90b:318:: with SMTP id
 ay24mr23612460pjb.175.1623114652570; 
 Mon, 07 Jun 2021 18:10:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx253KrivISywGLROa5WGmZPzIUrrh3/ViJVkQze+aUvfxcfFXPOZCDpYA7zhgges937Rhj+Q==
X-Received: by 2002:a17:90b:318:: with SMTP id
 ay24mr23612437pjb.175.1623114652306; 
 Mon, 07 Jun 2021 18:10:52 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id c5sm6947662pfn.144.2021.06.07.18.10.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jun 2021 18:10:51 -0700 (PDT)
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20210601113152.6d09e47b@yiliu-dev>
 <164ee532-17b0-e180-81d3-12d49b82ac9f@redhat.com>
 <64898584-a482-e6ac-fd71-23549368c508@linux.intel.com>
 <429d9c2f-3597-eb29-7764-fad3ec9a934f@redhat.com>
 <MWHPR11MB1886FC7A46837588254794048C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <05d7f790-870d-5551-1ced-86926a0aa1a6@redhat.com>
 <MWHPR11MB1886269E2B3DE471F1A9A7618C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <42a71462-1abc-0404-156c-60a7ee1ad333@redhat.com>
 <20210601173138.GM1002214@nvidia.com>
 <f69137e3-0f60-4f73-a0ff-8e57c79675d5@redhat.com>
 <20210602172154.GC1002214@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c84787ec-9d8f-3198-e800-fe0dc8eb53c7@redhat.com>
Date: Tue, 8 Jun 2021 09:10:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210602172154.GC1002214@nvidia.com>
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

CuWcqCAyMDIxLzYvMyDkuIrljYgxOjIxLCBKYXNvbiBHdW50aG9ycGUg5YaZ6YGTOgo+IE9uIFdl
ZCwgSnVuIDAyLCAyMDIxIGF0IDA0OjU0OjI2UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+
IOWcqCAyMDIxLzYvMiDkuIrljYgxOjMxLCBKYXNvbiBHdW50aG9ycGUg5YaZ6YGTOgo+Pj4gT24g
VHVlLCBKdW4gMDEsIDIwMjEgYXQgMDQ6NDc6MTVQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToK
Pj4+PiBXZSBjYW4gb3BlbiB1cCB0byB+MFUgZmlsZSBkZXNjcmlwdG9ycywgSSBkb24ndCBzZWUg
d2h5IHdlIG5lZWQgdG8gcmVzdHJpY3QKPj4+PiBpdCBpbiB1QVBJLgo+Pj4gVGhlcmUgYXJlIHNp
Z25pZmljYW50IHByb2JsZW1zIHdpdGggc3VjaCBsYXJnZSBmaWxlIGRlc2NyaXB0b3IKPj4+IHRh
Ymxlcy4gSGlnaCBGRCBudW1iZXJzIG1hbiB0aGluZ3MgbGlrZSBzZWxlY3QgZG9uJ3Qgd29yayBh
dCBhbGwKPj4+IGFueW1vcmUgYW5kIElJUkMgdGhlcmUgYXJlIG1vcmUgY29tcGxpY2F0aW9ucy4K
Pj4KPj4gSSBkb24ndCBzZWUgaG93IG11Y2ggZGlmZmVyZW5jZSBmb3IgSU9BU0lEIGFuZCBvdGhl
ciB0eXBlIG9mIGZkcy4gUGVvcGxlIGNhbgo+PiBjaG9vc2UgdG8gdXNlIHBvbGwgb3IgZXBvbGwu
Cj4gTm90IHJlYWxseSwgb25jZSBvbmUgdGhpbmcgaW4gYW4gYXBwbGljYXRlIHVzZXMgYSBsYXJn
ZSBudW1iZXIgRkRzIHRoZQo+IGVudGlyZSBhcHBsaWNhdGlvbiBpcyBlZmZlY3RlZC4gSWYgYW55
IG9wZW4oKSBjYW4gcmV0dXJuICd2ZXJ5IGJpZwo+IG51bWJlcicgdGhlbiBub3RoaW5nIGluIHRo
ZSBwcm9jZXNzIGlzIGFsbG93ZWQgdG8gZXZlciB1c2Ugc2VsZWN0Lgo+Cj4gSXQgaXMgbm90IGEg
dHJpdmlhbCB0aGluZyB0byBhc2sgZm9yCj4KPj4gQW5kIHdpdGggdGhlIGN1cnJlbnQgcHJvcG9z
YWwsIChhc3N1bWluZyB0aGVyZSdzIGEgTjoxIGlvYXNpZCB0byBpb2FzaWQpLiBJCj4+IHdvbmRl
ciBob3cgc2VsZWN0IGNhbiB3b3JrIGZvciB0aGUgc3BlY2lmaWMgaW9hc2lkLgo+IHBhZ2VmYXVs
dCBldmVudHMgYXJlIG9uZSB0aGluZyB0aGF0IGNvbWVzIHRvIG1pbmQuIEJ1bmRsaW5nIHRoZW0g
YWxsCj4gdG9nZXRoZXIgaW50byBhIHNpbmdsZSByaW5nIGJ1ZmZlciBpcyBnb2luZyB0byBiZSBu
ZWNlc3NhcnkuIE11bHRpZmRzCj4ganVzdCBjb21wbGljYXRlIHRoaXMgdG9vCj4KPiBKYXNvbgoK
CldlbGwsIHRoaXMgc291bmRzIGxpa2UgYSByZS1pbnZlbnRpb24gb2YgaW9fdXJpbmcgd2hpY2gg
aGFzIGFscmVhZHkgCndvcmtlZCBmb3IgbXVsdGlmZHMuCgpUaGFua3MKCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9t
bXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
