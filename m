Return-Path: <SRS0=UGJ5=K3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA3EC4708F
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 05:09:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 327FD6136E
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 05:09:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 327FD6136E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0357B406B0;
	Tue,  1 Jun 2021 05:09:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PLTdiFmN-qHC; Tue,  1 Jun 2021 05:09:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id E043240659;
	Tue,  1 Jun 2021 05:09:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CACDBC000E;
	Tue,  1 Jun 2021 05:09:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A545DC0001
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 05:09:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8744840E4D
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 05:09:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sJJDF_rBAGab for <iommu@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 05:09:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DD46440659
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 05:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622524140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T0ge9eI66wPcsIxgT0s5YZb/3xhZpxQFY4I1oaBiwpo=;
 b=HQGSp9L1Aos7JKS8eUPFW1Q6ZURFTSjavQ0zgn3R2yxjIPlbWGbUQ0J+hDdylDoqh+3C6O
 1Xyjs9TPpuz/Qo7sOm1ZEmsws6fanbq0LPqxS1m5TfIvehtbmeAPbCR87AKdgfydR0BYFd
 wPraKeAGf74JJyGa+Iidyyjwkq9ISuk=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-AMFnUyrBOqS57GALaCL6XQ-1; Tue, 01 Jun 2021 01:08:37 -0400
X-MC-Unique: AMFnUyrBOqS57GALaCL6XQ-1
Received: by mail-pj1-f71.google.com with SMTP id
 w1-20020a17090a0281b0290156f7df20a0so8197683pja.8
 for <iommu@lists.linux-foundation.org>; Mon, 31 May 2021 22:08:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=T0ge9eI66wPcsIxgT0s5YZb/3xhZpxQFY4I1oaBiwpo=;
 b=TW/UhGMFcA642mcHQpG5t1HB6yrsXQkKS7Xt0FGGY7GE/WRL9IRVrcrNeFfhCo5Ebp
 8tRTIh+NhQo6hPPzo6bQ/wGFOS58WZ2cu8j+MQJ9cwZ6OuO+052TaY8FFBWyf7vQziQe
 8gwV/qW/7/ONIe/1RQMYO2EGnzf18DgWXGR//4c67D5QywUMVvyCxqgFnMP1UiAUEIHu
 R6MNScCcvKJ7NELb1tQWo0/KDdE+qWdktg3cG2QVsGwiFJMro78EGVI2e29fInNrrBDf
 +QFSTnmfgD+l7mhaAnH3fcDOadyDXfHHbHXvdaHjAPjpOS3ymRySIRcfWd91K13HBkVs
 jiBg==
X-Gm-Message-State: AOAM532wlQX092Qa+osHC1drFUdA6gEaTiavaxX/pTBEqeeCvALZIWUi
 cEP2B0LXV/ccVm7UkHGf/6Qm20j7EmQCQGHoDWeJpXhiAqhcmJMpRc66CIF1HYJ1+slv17Za9XI
 1kS9BxqkWeVbsSP8M7pR18eCm1wOj+g==
X-Received: by 2002:a17:902:6908:b029:f7:cbad:c07a with SMTP id
 j8-20020a1709026908b02900f7cbadc07amr24233001plk.2.1622524116011; 
 Mon, 31 May 2021 22:08:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOw8eLgbeF/Ld10BQ267ECPLF2AMYqOh2mlgGe5FRchSRMetTlx3IsfoCHw/xZOMqR2DD4kg==
X-Received: by 2002:a17:902:6908:b029:f7:cbad:c07a with SMTP id
 j8-20020a1709026908b02900f7cbadc07amr24232965plk.2.1622524115712; 
 Mon, 31 May 2021 22:08:35 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id x22sm4713384pfn.10.2021.05.31.22.08.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 May 2021 22:08:35 -0700 (PDT)
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To: Liu Yi L <yi.l.liu@linux.intel.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <f510f916-e91c-236d-e938-513a5992d3b5@redhat.com>
 <20210531164118.265789ee@yiliu-dev>
 <78ee2638-1a03-fcc8-50a5-81040f677e69@redhat.com>
 <20210601113152.6d09e47b@yiliu-dev>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <164ee532-17b0-e180-81d3-12d49b82ac9f@redhat.com>
Date: Tue, 1 Jun 2021 13:08:29 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210601113152.6d09e47b@yiliu-dev>
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
 Jason Gunthorpe <jgg@nvidia.com>, David Woodhouse <dwmw2@infradead.org>
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

CuWcqCAyMDIxLzYvMSDkuIrljYgxMTozMSwgTGl1IFlpIEwg5YaZ6YGTOgo+IE9uIFR1ZSwgMSBK
dW4gMjAyMSAxMDozNjozNiArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPgo+PiDlnKggMjAyMS81
LzMxIOS4i+WNiDQ6NDEsIExpdSBZaSBMIOWGmemBkzoKPj4+PiBJIGd1ZXNzIFZGSU9fQVRUQUNI
X0lPQVNJRCB3aWxsIGZhaWwgaWYgdGhlIHVuZGVybGF5ZXIgZG9lc24ndCBzdXBwb3J0Cj4+Pj4g
aGFyZHdhcmUgbmVzdGluZy4gT3IgaXMgdGhlcmUgd2F5IHRvIGRldGVjdCB0aGUgY2FwYWJpbGl0
eSBiZWZvcmU/Cj4+PiBJIHRoaW5rIGl0IGNvdWxkIGZhaWwgaW4gdGhlIElPQVNJRF9DUkVBVEVf
TkVTVElORy4gSWYgdGhlIGdwYV9pb2FzaWQKPj4+IGlzIG5vdCBhYmxlIHRvIHN1cHBvcnQgbmVz
dGluZywgdGhlbiBzaG91bGQgZmFpbCBpdC4KPj4+ICAgCj4+Pj4gSSB0aGluayBHRVRfSU5GTyBv
bmx5IHdvcmtzIGFmdGVyIHRoZSBBVFRBQ0guCj4+PiB5ZXMuIEFmdGVyIGF0dGFjaGluZyB0byBn
cGFfaW9hc2lkLCB1c2Vyc3BhY2UgY291bGQgR0VUX0lORk8gb24gdGhlCj4+PiBncGFfaW9hc2lk
IGFuZCBjaGVjayBpZiBuZXN0aW5nIGlzIHN1cHBvcnRlZCBvciBub3QuIHJpZ2h0Pwo+Pgo+PiBT
b21lIG1vcmUgcXVlc3Rpb25zOgo+Pgo+PiAxKSBJcyB0aGUgaGFuZGxlIHJldHVybmVkIGJ5IElP
QVNJRF9BTExPQyBhbiBmZD8KPiBpdCdzIGFuIElEIHNvIGZhciBpbiB0aGlzIHByb3Bvc2FsLgoK
Ck9rLgoKCj4KPj4gMikgSWYgeWVzLCB3aGF0J3MgdGhlIHJlYXNvbiBmb3Igbm90IHNpbXBseSB1
c2UgdGhlIGZkIG9wZW5lZCBmcm9tCj4+IC9kZXYvaW9hcy4gKFRoaXMgaXMgdGhlIHF1ZXN0aW9u
IHRoYXQgaXMgbm90IGFuc3dlcmVkKSBhbmQgd2hhdCBoYXBwZW5zCj4+IGlmIHdlIGNhbGwgR0VU
X0lORk8gZm9yIHRoZSBpb2FzaWRfZmQ/Cj4+IDMpIElmIG5vdCwgaG93IEdFVF9JTkZPIHdvcms/
Cj4gb2gsIG1pc3NlZCB0aGlzIHF1ZXN0aW9uIGluIHByaW9yIHJlcGx5LiBQZXJzb25hbGx5LCBu
byBzcGVjaWFsIHJlYXNvbgo+IHlldC4gQnV0IHVzaW5nIElEIG1heSBnaXZlIHVzIG9wcG9ydHVu
aXR5IHRvIGN1c3RvbWl6ZSB0aGUgbWFuYWdlbWVudAo+IG9mIHRoZSBoYW5kbGUuIEZvciBvbmUs
IGJldHRlciBsb29rdXAgZWZmaWNpZW5jeSBieSB1c2luZyB4YXJyYXkgdG8KPiBzdG9yZSB0aGUg
YWxsb2NhdGVkIElEcy4gRm9yIHR3bywgY291bGQgY2F0ZWdvcml6ZSB0aGUgYWxsb2NhdGVkIElE
cwo+IChwYXJlbnQgb3IgbmVzdGVkKS4gR0VUX0lORk8ganVzdCB3b3JrcyB3aXRoIGFuIGlucHV0
IEZEIGFuZCBhbiBJRC4KCgpJJ20gbm90IHN1cmUgSSBnZXQgdGhpcywgZm9yIG5lc3RpbmcgY2Fz
ZXMgeW91IGNhbiBzdGlsbCBtYWtlIHRoZSBjaGlsZCAKYW4gZmQuCgpBbmQgYSBxdWVzdGlvbiBz
dGlsbCwgdW5kZXIgd2hhdCBjYXNlIHdlIG5lZWQgdG8gY3JlYXRlIG11bHRpcGxlIGlvYXNpZHMg
Cm9uIGEgc2luZ2xlIGlvYXNpZCBmZD8KCihUaGlzIGNhc2UgaXMgbm90IGRlbW9uc3RyYXRlZCBp
biB5b3VyIGV4YW1wbGVzKS4KClRoYW5rcwoKCj4KPj4+ICAgCj4+Pj4+IAkvKiBCaW5kIGd1ZXN0
IEkvTyBwYWdlIHRhYmxlICAqLwo+Pj4+PiAJYmluZF9kYXRhID0gewo+Pj4+PiAJCS5pb2FzaWQJ
PSBnaW92YV9pb2FzaWQ7Cj4+Pj4+IAkJLmFkZHIJPSBnaW92YV9wZ3RhYmxlOwo+Pj4+PiAJCS8v
IGFuZCBmb3JtYXQgaW5mb3JtYXRpb24KPj4+Pj4gCX07Cj4+Pj4+IAlpb2N0bChpb2FzaWRfZmQs
IElPQVNJRF9CSU5EX1BHVEFCTEUsICZiaW5kX2RhdGEpOwo+Pj4+Pgo+Pj4+PiAJLyogSW52YWxp
ZGF0ZSBJT1RMQiB3aGVuIHJlcXVpcmVkICovCj4+Pj4+IAlpbnZfZGF0YSA9IHsKPj4+Pj4gCQku
aW9hc2lkCT0gZ2lvdmFfaW9hc2lkOwo+Pj4+PiAJCS8vIGdyYW51bGFyIGluZm9ybWF0aW9uCj4+
Pj4+IAl9Owo+Pj4+PiAJaW9jdGwoaW9hc2lkX2ZkLCBJT0FTSURfSU5WQUxJREFURV9DQUNIRSwg
Jmludl9kYXRhKTsKPj4+Pj4KPj4+Pj4gCS8qIFNlZSA1LjYgZm9yIEkvTyBwYWdlIGZhdWx0IGhh
bmRsaW5nICovCj4+Pj4+IAkKPj4+Pj4gNS41LiBHdWVzdCBTVkEgKHZTVkEpCj4+Pj4+ICsrKysr
KysrKysrKysrKysrKwo+Pj4+Pgo+Pj4+PiBBZnRlciBib290cyB0aGUgZ3Vlc3QgZnVydGhlciBj
cmVhdGUgYSBHVkEgYWRkcmVzcyBzcGFjZXMgKGdwYXNpZDEpIG9uCj4+Pj4+IGRldjEuIERldjIg
aXMgbm90IGFmZmVjdGVkIChzdGlsbCBhdHRhY2hlZCB0byBnaW92YV9pb2FzaWQpLgo+Pj4+Pgo+
Pj4+PiBBcyBleHBsYWluZWQgaW4gc2VjdGlvbiA0LCB1c2VyIHNob3VsZCBhdm9pZCBleHBvc2Ug
RU5RQ01EIG9uIGJvdGgKPj4+Pj4gcGRldiBhbmQgbWRldi4KPj4+Pj4KPj4+Pj4gVGhlIHNlcXVl
bmNlIGFwcGxpZXMgdG8gYWxsIGRldmljZSB0eXBlcyAoYmVpbmcgcGRldiBvciBtZGV2KSwgZXhj
ZXB0Cj4+Pj4+IG9uZSBhZGRpdGlvbmFsIHN0ZXAgdG8gY2FsbCBLVk0gZm9yIEVOUUNNRC1jYXBh
YmxlIG1kZXY6Cj4+Pj4gTXkgdW5kZXJzdGFuZGluZyBpcyBFTlFDTUQgaXMgSW50ZWwgc3BlY2lm
aWMgYW5kIG5vdCBhIHJlcXVpcmVtZW50IGZvcgo+Pj4+IGhhdmluZyB2U1ZBLgo+Pj4gRU5RQ01E
IGlzIG5vdCByZWFsbHkgSW50ZWwgc3BlY2lmaWMgYWx0aG91Z2ggb25seSBJbnRlbCBzdXBwb3J0
cyBpdCB0b2RheS4KPj4+IFRoZSBQQ0llIERNV3IgY2FwYWJpbGl0eSBpcyB0aGUgY2FwYWJpbGl0
eSBmb3Igc29mdHdhcmUgdG8gZW51bWVyYXRlIHRoZQo+Pj4gRU5RQ01EIHN1cHBvcnQgaW4gZGV2
aWNlIHNpZGUuIHllcywgaXQgaXMgbm90IGEgcmVxdWlyZW1lbnQgZm9yIHZTVkEuIFRoZXkKPj4+
IGFyZSBvcnRob2dvbmFsLgo+Pgo+PiBSaWdodCwgdGhlbiBpdCdzIGJldHRlciB0byBtZW50aW9u
IERNV3IgaW5zdGVhZCBvZiBhIHZlbmRvciBzcGVjaWZpYwo+PiBpbnN0cnVjdGlvbiBpbiBhIGdl
bmVyYWwgZnJhbWV3b3JrIGxpa2UgaW9hc2lkLgo+IGdvb2Qgc3VnZ2VzdGlvbi4gOikKPgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGlu
ZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
