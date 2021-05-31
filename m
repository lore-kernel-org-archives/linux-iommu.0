Return-Path: <SRS0=AF0h=K2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F9FC47082
	for <iommu@archiver.kernel.org>; Mon, 31 May 2021 04:39:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A72961009
	for <iommu@archiver.kernel.org>; Mon, 31 May 2021 04:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A72961009
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AE61E83B55;
	Mon, 31 May 2021 04:39:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5I1JX9N9c8io; Mon, 31 May 2021 04:39:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 646EE83506;
	Mon, 31 May 2021 04:39:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F651C000D;
	Mon, 31 May 2021 04:39:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0C33C0001
 for <iommu@lists.linux-foundation.org>; Mon, 31 May 2021 04:39:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CD2E540297
 for <iommu@lists.linux-foundation.org>; Mon, 31 May 2021 04:39:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EIMFrPw7x1he for <iommu@lists.linux-foundation.org>;
 Mon, 31 May 2021 04:39:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8957A40289
 for <iommu@lists.linux-foundation.org>; Mon, 31 May 2021 04:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622435942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0iOJFSk4M5fATpsyHla9pHiyIsvAdGUk+2E+QqouBgM=;
 b=VRcISGgZ1Y86TqoaS4YBDQbwr1LQKPFV5Nm+yyBiTCWvFwAD00U43zdEQ1XXK4iL5bBvdk
 PB+hsZqfjBl4UeT6IXOgldByqJAWSErXEN2mo8m/GB/bjwdhMGNqy2AQUrKsy8HiywJbEc
 715l4TbLPN+t1dQOKYAqYzFResRNeOQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-ZMdeTOmRMz6nWYLWonGfvg-1; Mon, 31 May 2021 00:39:00 -0400
X-MC-Unique: ZMdeTOmRMz6nWYLWonGfvg-1
Received: by mail-pj1-f71.google.com with SMTP id
 b23-20020a17090ae397b0290163949acb4dso2599492pjz.9
 for <iommu@lists.linux-foundation.org>; Sun, 30 May 2021 21:38:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=0iOJFSk4M5fATpsyHla9pHiyIsvAdGUk+2E+QqouBgM=;
 b=WZBx8ipu+9S4CCfeLMN+/bNE8lTRT8uEI1JitflS5hYEgnRey+d4Egq7HYVP+nICmT
 Y96lNWQ9aeQCoCEdlNUXiSSgC3Ha9wWavdD/h4cfizJbK/JgHvam8jmY9LSqY03yrIJI
 su6E6bXAgd+Kx1U0n5VtJHCo1J4g9lZgulXsjGuohPrtLRFNWEfPUFJAnU8O5ugDm0id
 yNZqK2Ul6xDKqUGE+nPH2miM3KvWU4zgjBhO/C+aFszn5jInwrGULWnHufUN6Pfz5wCL
 mTCfDYo4stF1+zcuqcuyKf9NITFkBeofJT2PXOGVxrghrEmZDad1fE38pSrQyOk+yjpm
 HppA==
X-Gm-Message-State: AOAM533ZWBP5nZuzcN4lS3OPNcvQ/Hn2PqY4Fcf64AQKs6atdEMx5lqD
 1CpGStilra9s/ryv6gs82Y99sdS7hOuTY0QHIdUDVxwajLxKmnE3y2x/VWLiE8bW8dRw0I7MBuG
 612QAinc79zMbevhGCAuosnaYQAUenQ==
X-Received: by 2002:a17:90b:1489:: with SMTP id
 js9mr8106326pjb.227.1622435939096; 
 Sun, 30 May 2021 21:38:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwECaFWqzow6NdzjEA/SPKPwRYy8BftnnINSbmAd0S9WQ6jOL+NhYjoGxK0mOczJ8jEV1I9Vg==
X-Received: by 2002:a17:90b:1489:: with SMTP id
 js9mr8106314pjb.227.1622435938816; 
 Sun, 30 May 2021 21:38:58 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id b20sm1398269pgm.30.2021.05.30.21.38.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 May 2021 21:38:58 -0700 (PDT)
Subject: Re: [PATCH v7 11/12] vduse: Introduce VDUSE - vDPA Device in Userspace
To: Yongji Xie <xieyongji@bytedance.com>
References: <20210517095513.850-1-xieyongji@bytedance.com>
 <20210517095513.850-12-xieyongji@bytedance.com>
 <3740c7eb-e457-07f3-5048-917c8606275d@redhat.com>
 <CACycT3uAqa6azso_8MGreh+quj-JXO1piuGnrV8k2kTfc34N2g@mail.gmail.com>
 <5a68bb7c-fd05-ce02-cd61-8a601055c604@redhat.com>
 <CACycT3ve7YvKF+F+AnTQoJZMPua+jDvGMs_ox8GQe_=SGdeCMA@mail.gmail.com>
 <ee00efca-b26d-c1be-68d2-f9e34a735515@redhat.com>
 <CACycT3ufok97cKpk47NjUBTc0QAyfauFUyuFvhWKmuqCGJ7zZw@mail.gmail.com>
 <00ded99f-91b6-ba92-5d92-2366b163f129@redhat.com>
 <CACycT3uK_Fuade-b8FVYkGCKZnne_UGGbYRFwv7WOH2oKCsXSg@mail.gmail.com>
 <f20edd55-20cb-c016-b347-dd71c5406ed8@redhat.com>
 <CACycT3tLj6a7-tbqO9SzCLStwYrOALdkfnt1jxQBv3s0VzD6AQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ea9fd2d2-870f-c4e2-d7a5-af759985c462@redhat.com>
Date: Mon, 31 May 2021 12:38:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CACycT3tLj6a7-tbqO9SzCLStwYrOALdkfnt1jxQBv3s0VzD6AQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>, iommu@lists.linux-foundation.org,
 Matthew Wilcox <willy@infradead.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christoph Hellwig <hch@infradead.org>,
 Christian Brauner <christian.brauner@canonical.com>, bcrl@kvack.org,
 Al Viro <viro@zeniv.linux.org.uk>, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
 =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>,
 Stefano Garzarella <sgarzare@redhat.com>
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

CuWcqCAyMDIxLzUvMzEg5LiL5Y2IMTI6MjcsIFlvbmdqaSBYaWUg5YaZ6YGTOgo+IE9uIEZyaSwg
TWF5IDI4LCAyMDIxIGF0IDEwOjMxIEFNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+
IHdyb3RlOgo+Pgo+PiDlnKggMjAyMS81LzI3IOS4i+WNiDk6MTcsIFlvbmdqaSBYaWUg5YaZ6YGT
Ogo+Pj4gT24gVGh1LCBNYXkgMjcsIDIwMjEgYXQgNDo0MSBQTSBKYXNvbiBXYW5nIDxqYXNvd2Fu
Z0ByZWRoYXQuY29tPiB3cm90ZToKPj4+PiDlnKggMjAyMS81LzI3IOS4i+WNiDM6MzQsIFlvbmdq
aSBYaWUg5YaZ6YGTOgo+Pj4+PiBPbiBUaHUsIE1heSAyNywgMjAyMSBhdCAxOjQwIFBNIEphc29u
IFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+Pj4+Pj4g5ZyoIDIwMjEvNS8yNyDk
uIvljYgxOjA4LCBZb25namkgWGllIOWGmemBkzoKPj4+Pj4+PiBPbiBUaHUsIE1heSAyNywgMjAy
MSBhdCAxOjAwIFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+Pj4+
Pj4+PiDlnKggMjAyMS81LzI3IOS4i+WNiDEyOjU3LCBZb25namkgWGllIOWGmemBkzoKPj4+Pj4+
Pj4+IE9uIFRodSwgTWF5IDI3LCAyMDIxIGF0IDEyOjEzIFBNIEphc29uIFdhbmcgPGphc293YW5n
QHJlZGhhdC5jb20+IHdyb3RlOgo+Pj4+Pj4+Pj4+IOWcqCAyMDIxLzUvMTcg5LiL5Y2INTo1NSwg
WGllIFlvbmdqaSDlhpnpgZM6Cj4+Pj4+Pj4+Pj4+ICsKPj4+Pj4+Pj4+Pj4gK3N0YXRpYyBpbnQg
dmR1c2VfZGV2X21zZ19zeW5jKHN0cnVjdCB2ZHVzZV9kZXYgKmRldiwKPj4+Pj4+Pj4+Pj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2ZHVzZV9kZXZfbXNnICptc2cpCj4+Pj4+
Pj4+Pj4+ICt7Cj4+Pj4+Pj4+Pj4+ICsgICAgIGluaXRfd2FpdHF1ZXVlX2hlYWQoJm1zZy0+d2Fp
dHEpOwo+Pj4+Pj4+Pj4+PiArICAgICBzcGluX2xvY2soJmRldi0+bXNnX2xvY2spOwo+Pj4+Pj4+
Pj4+PiArICAgICB2ZHVzZV9lbnF1ZXVlX21zZygmZGV2LT5zZW5kX2xpc3QsIG1zZyk7Cj4+Pj4+
Pj4+Pj4+ICsgICAgIHdha2VfdXAoJmRldi0+d2FpdHEpOwo+Pj4+Pj4+Pj4+PiArICAgICBzcGlu
X3VubG9jaygmZGV2LT5tc2dfbG9jayk7Cj4+Pj4+Pj4+Pj4+ICsgICAgIHdhaXRfZXZlbnRfa2ls
bGFibGUobXNnLT53YWl0cSwgbXNnLT5jb21wbGV0ZWQpOwo+Pj4+Pj4+Pj4+IFdoYXQgaGFwcGVu
cyBpZiB0aGUgdXNlcnNwYWNlKG1hbGljb3VzKSBkb2Vzbid0IGdpdmUgYSByZXNwb25zZSBmb3Jl
dmVyPwo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4gSXQgbG9va3MgbGlrZSBhIERPUy4gSWYgeWVzLCB3
ZSBuZWVkIHRvIGNvbnNpZGVyIGEgd2F5IHRvIGZpeCB0aGF0Lgo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+
PiBIb3cgYWJvdXQgdXNpbmcgd2FpdF9ldmVudF9raWxsYWJsZV90aW1lb3V0KCkgaW5zdGVhZD8K
Pj4+Pj4+Pj4gUHJvYmFibHksIGFuZCB0aGVuIHdlIG5lZWQgY2hvb3NlIGEgc3VpdGFibGUgdGlt
ZW91dCBhbmQgbW9yZSBpbXBvcnRhbnQsCj4+Pj4+Pj4+IG5lZWQgdG8gcmVwb3J0IHRoZSBmYWls
dXJlIHRvIHZpcnRpby4KPj4+Pj4+Pj4KPj4+Pj4+PiBNYWtlcyBzZW5zZSB0byBtZS4gQnV0IGl0
IGxvb2tzIGxpa2Ugc29tZQo+Pj4+Pj4+IHZkcGFfY29uZmlnX29wcy92aXJ0aW9fY29uZmlnX29w
cyBzdWNoIGFzIHNldF9zdGF0dXMoKSBkaWRuJ3QgaGF2ZSBhCj4+Pj4+Pj4gcmV0dXJuIHZhbHVl
LiAgTm93IEkgYWRkIGEgV0FSTl9PTigpIGZvciB0aGUgZmFpbHVyZS4gRG8geW91IG1lYW4gd2UK
Pj4+Pj4+PiBuZWVkIHRvIGFkZCBzb21lIGNoYW5nZSBmb3IgdmlydGlvIGNvcmUgdG8gaGFuZGxl
IHRoZSBmYWlsdXJlPwo+Pj4+Pj4gTWF5YmUsIGJ1dCBJJ20gbm90IHN1cmUgaG93IGhhcmQgd2Ug
Y2FuIGRvIHRoYXQuCj4+Pj4+Pgo+Pj4+PiBXZSBuZWVkIHRvIGNoYW5nZSBhbGwgdmlydGlvIGRl
dmljZSBkcml2ZXJzIGluIHRoaXMgd2F5Lgo+Pj4+IFByb2JhYmx5Lgo+Pj4+Cj4+Pj4KPj4+Pj4+
IFdlIGhhZCBORUVEU19SRVNFVCBidXQgaXQgbG9va3Mgd2UgZG9uJ3QgaW1wbGVtZW50IGl0Lgo+
Pj4+Pj4KPj4+Pj4gQ291bGQgaXQgaGFuZGxlIHRoZSBmYWlsdXJlIG9mIGdldF9mZWF0dXJlKCkg
YW5kIGdldC9zZXRfY29uZmlnKCk/Cj4+Pj4gTG9va3Mgbm90Ogo+Pj4+Cj4+Pj4gIgo+Pj4+Cj4+
Pj4gVGhlIGRldmljZSBTSE9VTEQgc2V0IERFVklDRV9ORUVEU19SRVNFVCB3aGVuIGl0IGVudGVy
cyBhbiBlcnJvciBzdGF0ZQo+Pj4+IHRoYXQgYSByZXNldCBpcyBuZWVkZWQuIElmIERSSVZFUl9P
SyBpcyBzZXQsIGFmdGVyIGl0IHNldHMKPj4+PiBERVZJQ0VfTkVFRFNfUkVTRVQsIHRoZSBkZXZp
Y2UgTVVTVCBzZW5kIGEgZGV2aWNlIGNvbmZpZ3VyYXRpb24gY2hhbmdlCj4+Pj4gbm90aWZpY2F0
aW9uIHRvIHRoZSBkcml2ZXIuCj4+Pj4KPj4+PiAiCj4+Pj4KPj4+PiBUaGlzIGxvb2tzIGltcGxp
ZXMgdGhhdCBORUVEU19SRVNFVCBtYXkgb25seSB3b3JrIGFmdGVyIGRldmljZSBpcwo+Pj4+IHBy
b2JlZC4gQnV0IGluIHRoZSBjdXJyZW50IGRlc2lnbiwgZXZlbiB0aGUgcmVzZXQoKSBpcyBub3Qg
cmVsaWFibGUuCj4+Pj4KPj4+Pgo+Pj4+Pj4gT3IgYSByb3VnaCBpZGVhIGlzIHRoYXQgbWF5YmUg
bmVlZCBzb21lIHJlbGF4aW5nIHRvIGJlIGNvdXBsZWQgbG9vc2VseQo+Pj4+Pj4gd2l0aCB1c2Vy
c3BhY2UuIEUuZyB0aGUgZGV2aWNlIChjb250cm9sIHBhdGgpIGlzIGltcGxlbWVudGVkIGluIHRo
ZQo+Pj4+Pj4ga2VybmVsIGJ1dCB0aGUgZGF0YXBhdGggaXMgaW1wbGVtZW50ZWQgaW4gdGhlIHVz
ZXJzcGFjZSBsaWtlIFRVTi9UQVAuCj4+Pj4+Pgo+Pj4+PiBJIHRoaW5rIGl0IGNhbiB3b3JrIGZv
ciBtb3N0IGNhc2VzLiBPbmUgcHJvYmxlbSBpcyB0aGF0IHRoZSBzZXRfY29uZmlnCj4+Pj4+IG1p
Z2h0IGNoYW5nZSB0aGUgYmVoYXZpb3Igb2YgdGhlIGRhdGEgcGF0aCBhdCBydW50aW1lLCBlLmcu
Cj4+Pj4+IHZpcnRuZXRfc2V0X21hY19hZGRyZXNzKCkgaW4gdGhlIHZpcnRpby1uZXQgZHJpdmVy
IGFuZAo+Pj4+PiBjYWNoZV90eXBlX3N0b3JlKCkgaW4gdGhlIHZpcnRpby1ibGsgZHJpdmVyLiBO
b3Qgc3VyZSBpZiB0aGlzIHBhdGggaXMKPj4+Pj4gYWJsZSB0byByZXR1cm4gYmVmb3JlIHRoZSBk
YXRhcGF0aCBpcyBhd2FyZSBvZiB0aGlzIGNoYW5nZS4KPj4+PiBHb29kIHBvaW50Lgo+Pj4+Cj4+
Pj4gQnV0IHNldF9jb25maWcoKSBzaG91bGQgYmUgcmFyZToKPj4+Pgo+Pj4+IEUuZyBpbiB0aGUg
Y2FzZSBvZiB2aXJ0aW8tbmV0IHdpdGggVkVSU0lPTl8xLCBjb25maWcgc3BhY2UgaXMgcmVhZCBv
bmx5LAo+Pj4+IGFuZCBpdCB3YXMgc2V0IHZpYSBjb250cm9sIHZxLgo+Pj4+Cj4+Pj4gRm9yIGJs
b2NrLCB3ZSBjYW4KPj4+Pgo+Pj4+IDEpIHN0YXJ0IGZyb20gd2l0aG91dCBXQ0Ugb3IKPj4+PiAy
KSB3ZSBhZGQgYSBjb25maWcgY2hhbmdlIG5vdGlmaWNhdGlvbiB0byB1c2Vyc3BhY2Ugb3IKPj4+
IEkgcHJlZmVyIHRoaXMgd2F5LiBBbmQgSSB0aGluayB3ZSBhbHNvIG5lZWQgdG8gZG8gc2ltaWxh
ciB0aGluZ3MgZm9yCj4+PiBzZXQvZ2V0X3ZxX3N0YXRlKCkuCj4+Cj4+IFllcywgSSBhZ3JlZS4K
Pj4KPiBIaSBKYXNvbiwKPgo+IE5vdyBJJ20gd29ya2luZyBvbiB0aGlzLiBCdXQgSSBmb3VuZCB0
aGUgY29uZmlnIGNoYW5nZSBub3RpZmljYXRpb24KPiBtdXN0IGJlIHN5bmNocm9ub3VzIGluIHRo
ZSB2aXJ0aW8tYmxrIGNhc2UsIHdoaWNoIG1lYW5zIHRoZSBrZXJuZWwKPiBzdGlsbCBuZWVkcyB0
byB3YWl0IGZvciB0aGUgcmVzcG9uc2UgZnJvbSB1c2Vyc3BhY2UgaW4gc2V0X2NvbmZpZygpLgo+
IE90aGVyd2lzZSwgc29tZSBJL09zIG1pZ2h0IHN0aWxsIHJ1biB0aGUgb2xkIHdheSBhZnRlciB3
ZSBjaGFuZ2UgdGhlCj4gY2FjaGVfdHlwZSBpbiBzeXNmcy4KPgo+IFRoZSBzaW1wbGUgd2F5cyB0
byBzb2x2ZSB0aGlzIHByb2JsZW0gYXJlOgo+Cj4gMS4gT25seSBzdXBwb3J0IHJlYWQtb25seSBj
b25maWcgc3BhY2UsIGRpc2FibGUgV0NFIGFzIHlvdSBzdWdnZXN0ZWQKPiAyLiBBZGQgYSByZXR1
cm4gdmFsdWUgdG8gc2V0X2NvbmZpZygpIGFuZCBoYW5kbGUgdGhlIGZhaWx1cmUgb25seSBpbgo+
IHZpcnRpby1ibGsgZHJpdmVyCj4gMy4gUHJpbnQgc29tZSB3YXJuaW5ncyBhZnRlciB0aW1lb3V0
IHNpbmNlIGl0IG9ubHkgYWZmZWN0cyB0aGUKPiBkYXRhcGxhbmUgd2hpY2ggaXMgdW5kZXIgdXNl
cnNwYWNlJ3MgY29udHJvbAo+Cj4gQW55IHN1Z2dlc3Rpb25zPwoKCkxldCdzIGdvIHdpdGhvdXQg
V0NFIGZpcnN0IGFuZCBtYWtlIFZEVVNFIHdvcmsgZmlyc3QuIFdlIGNhbiB0aGVuIHRoaW5rIApv
ZiBhIHNvbHV0aW9uIGZvciBXQ0Ugb24gdG9wLgoKVGhhbmtzCgoKPgo+IFRoYW5rcywKPiBZb25n
amkKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9t
bXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
