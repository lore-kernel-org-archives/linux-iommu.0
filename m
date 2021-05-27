Return-Path: <SRS0=nChL=KW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1855DC4707F
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 08:43:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8A61613D1
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 08:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A61613D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7DFA76059B;
	Thu, 27 May 2021 08:43:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J0W3yhzmRQ_5; Thu, 27 May 2021 08:43:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C26E600D1;
	Thu, 27 May 2021 08:43:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31985C000D;
	Thu, 27 May 2021 08:43:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2FA73C0001
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 08:43:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 04DB340286
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 08:43:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XxDbUX3QXxVJ for <iommu@lists.linux-foundation.org>;
 Thu, 27 May 2021 08:43:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 944954028B
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 08:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622105031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q4kOVJ8GB+3GLW+q/BipT5oGozNfefpPrW2ucSt2yL8=;
 b=d0ofvWbwb+F/Zhcxkyd5PrL6Z8KIhhsGVIx1i7G+4IQyJ2lzwF7piwtyUVKnr1yYhpexoQ
 Sw6jydP4FvGWpk6Q26qvdAjvVSfw8DXTLDsiEdDBhVl27jrL9YYsCZia/aUcR5RUxjGev/
 EErwR1WML7J+YzBrRuTbT9f+Z+RDGD4=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-UB9vCMdkM8KDbUQ4IUdMYA-1; Thu, 27 May 2021 04:43:50 -0400
X-MC-Unique: UB9vCMdkM8KDbUQ4IUdMYA-1
Received: by mail-pl1-f198.google.com with SMTP id
 o19-20020a170902e293b02900ef869214f9so1966498plc.18
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 01:43:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Q4kOVJ8GB+3GLW+q/BipT5oGozNfefpPrW2ucSt2yL8=;
 b=NUgilcVeS1IUZLpJQ5rL1jWnjkQ28HWpYoHzjjIzatpBbGPPqmARI6VJxuUJICPgJQ
 UgqeZWbP41t58xAkuQtLAaOQRANi7r7pGseP1hzhRZUp/wvtgmCZa/kAXk1tuO5hHzQv
 I4qTWC4peCz+t236qpHYS0ry4uOaQvKta3aPKCtdS47O0g+gKh8R0Rjb/qc34/jre2PO
 OcRZAc8yu/1FGDenXiksteRG3rm2ZdOFdweZMxOQ/7p66fe9VsNAp+a/l+U/Gtw+5OV/
 JabV1qCx0FXhp8nScFcIlaY+CbMdbLyhBJAqKJYhhIZ82aWwycCE9uEBFz4cwzrVknDm
 1kXw==
X-Gm-Message-State: AOAM530MAfY7/bBPuwcTUIHlbHLj/3wZ8h9ioHW7GOBvHVQuPMUEPH31
 kj9QCi4LxsqzsoapCWREdjxw2UpnzeeAzRB5CgTxOwteWgbJd31NVL9jHAwzm2H+ABvtONCnJLH
 jPMOxzNAZ1OOh6btdqt0nzOpC13CnCg==
X-Received: by 2002:a17:902:aa42:b029:ee:f55a:b2c1 with SMTP id
 c2-20020a170902aa42b02900eef55ab2c1mr2283381plr.15.1622105028987; 
 Thu, 27 May 2021 01:43:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSObctLvNp4FosLHglZe975VrI39ki5xw8bXJ8rCFLiK5AHUwDmp+dxI3a8RKS9e1DfhzunA==
X-Received: by 2002:a17:902:aa42:b029:ee:f55a:b2c1 with SMTP id
 c2-20020a170902aa42b02900eef55ab2c1mr2283358plr.15.1622105028736; 
 Thu, 27 May 2021 01:43:48 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id e29sm1364517pfm.110.2021.05.27.01.43.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 May 2021 01:43:48 -0700 (PDT)
Subject: Re: [PATCH v7 11/12] vduse: Introduce VDUSE - vDPA Device in Userspace
From: Jason Wang <jasowang@redhat.com>
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
Message-ID: <3cc7407d-9637-227e-9afa-402b6894d8ac@redhat.com>
Date: Thu, 27 May 2021 16:43:40 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <00ded99f-91b6-ba92-5d92-2366b163f129@redhat.com>
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

CuWcqCAyMDIxLzUvMjcg5LiL5Y2INDo0MSwgSmFzb24gV2FuZyDlhpnpgZM6Cj4KPiDlnKggMjAy
MS81LzI3IOS4i+WNiDM6MzQsIFlvbmdqaSBYaWUg5YaZ6YGTOgo+PiBPbiBUaHUsIE1heSAyNywg
MjAyMSBhdCAxOjQwIFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+
Pj4KPj4+IOWcqCAyMDIxLzUvMjcg5LiL5Y2IMTowOCwgWW9uZ2ppIFhpZSDlhpnpgZM6Cj4+Pj4g
T24gVGh1LCBNYXkgMjcsIDIwMjEgYXQgMTowMCBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiAKPj4+PiB3cm90ZToKPj4+Pj4g5ZyoIDIwMjEvNS8yNyDkuIvljYgxMjo1NywgWW9u
Z2ppIFhpZSDlhpnpgZM6Cj4+Pj4+PiBPbiBUaHUsIE1heSAyNywgMjAyMSBhdCAxMjoxMyBQTSBK
YXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiAKPj4+Pj4+IHdyb3RlOgo+Pj4+Pj4+IOWc
qCAyMDIxLzUvMTcg5LiL5Y2INTo1NSwgWGllIFlvbmdqaSDlhpnpgZM6Cj4+Pj4+Pj4+ICsKPj4+
Pj4+Pj4gK3N0YXRpYyBpbnQgdmR1c2VfZGV2X21zZ19zeW5jKHN0cnVjdCB2ZHVzZV9kZXYgKmRl
diwKPj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgc3RydWN0IHZkdXNlX2Rldl9tc2cgKm1zZykKPj4+Pj4+Pj4gK3sKPj4+Pj4+Pj4g
K8KgwqDCoMKgIGluaXRfd2FpdHF1ZXVlX2hlYWQoJm1zZy0+d2FpdHEpOwo+Pj4+Pj4+PiArwqDC
oMKgwqAgc3Bpbl9sb2NrKCZkZXYtPm1zZ19sb2NrKTsKPj4+Pj4+Pj4gK8KgwqDCoMKgIHZkdXNl
X2VucXVldWVfbXNnKCZkZXYtPnNlbmRfbGlzdCwgbXNnKTsKPj4+Pj4+Pj4gK8KgwqDCoMKgIHdh
a2VfdXAoJmRldi0+d2FpdHEpOwo+Pj4+Pj4+PiArwqDCoMKgwqAgc3Bpbl91bmxvY2soJmRldi0+
bXNnX2xvY2spOwo+Pj4+Pj4+PiArwqDCoMKgwqAgd2FpdF9ldmVudF9raWxsYWJsZShtc2ctPndh
aXRxLCBtc2ctPmNvbXBsZXRlZCk7Cj4+Pj4+Pj4gV2hhdCBoYXBwZW5zIGlmIHRoZSB1c2Vyc3Bh
Y2UobWFsaWNvdXMpIGRvZXNuJ3QgZ2l2ZSBhIHJlc3BvbnNlIAo+Pj4+Pj4+IGZvcmV2ZXI/Cj4+
Pj4+Pj4KPj4+Pj4+PiBJdCBsb29rcyBsaWtlIGEgRE9TLiBJZiB5ZXMsIHdlIG5lZWQgdG8gY29u
c2lkZXIgYSB3YXkgdG8gZml4IHRoYXQuCj4+Pj4+Pj4KPj4+Pj4+IEhvdyBhYm91dCB1c2luZyB3
YWl0X2V2ZW50X2tpbGxhYmxlX3RpbWVvdXQoKSBpbnN0ZWFkPwo+Pj4+PiBQcm9iYWJseSwgYW5k
IHRoZW4gd2UgbmVlZCBjaG9vc2UgYSBzdWl0YWJsZSB0aW1lb3V0IGFuZCBtb3JlIAo+Pj4+PiBp
bXBvcnRhbnQsCj4+Pj4+IG5lZWQgdG8gcmVwb3J0IHRoZSBmYWlsdXJlIHRvIHZpcnRpby4KPj4+
Pj4KPj4+PiBNYWtlcyBzZW5zZSB0byBtZS4gQnV0IGl0IGxvb2tzIGxpa2Ugc29tZQo+Pj4+IHZk
cGFfY29uZmlnX29wcy92aXJ0aW9fY29uZmlnX29wcyBzdWNoIGFzIHNldF9zdGF0dXMoKSBkaWRu
J3QgaGF2ZSBhCj4+Pj4gcmV0dXJuIHZhbHVlLsKgIE5vdyBJIGFkZCBhIFdBUk5fT04oKSBmb3Ig
dGhlIGZhaWx1cmUuIERvIHlvdSBtZWFuIHdlCj4+Pj4gbmVlZCB0byBhZGQgc29tZSBjaGFuZ2Ug
Zm9yIHZpcnRpbyBjb3JlIHRvIGhhbmRsZSB0aGUgZmFpbHVyZT8KPj4+Cj4+PiBNYXliZSwgYnV0
IEknbSBub3Qgc3VyZSBob3cgaGFyZCB3ZSBjYW4gZG8gdGhhdC4KPj4+Cj4+IFdlIG5lZWQgdG8g
Y2hhbmdlIGFsbCB2aXJ0aW8gZGV2aWNlIGRyaXZlcnMgaW4gdGhpcyB3YXkuCj4KPgo+IFByb2Jh
Ymx5Lgo+Cj4KPj4KPj4+IFdlIGhhZCBORUVEU19SRVNFVCBidXQgaXQgbG9va3Mgd2UgZG9uJ3Qg
aW1wbGVtZW50IGl0Lgo+Pj4KPj4gQ291bGQgaXQgaGFuZGxlIHRoZSBmYWlsdXJlIG9mIGdldF9m
ZWF0dXJlKCkgYW5kIGdldC9zZXRfY29uZmlnKCk/Cj4KPgo+IExvb2tzIG5vdDoKPgo+ICIKPgo+
IFRoZSBkZXZpY2UgU0hPVUxEIHNldCBERVZJQ0VfTkVFRFNfUkVTRVQgd2hlbiBpdCBlbnRlcnMg
YW4gZXJyb3Igc3RhdGUgCj4gdGhhdCBhIHJlc2V0IGlzIG5lZWRlZC4gSWYgRFJJVkVSX09LIGlz
IHNldCwgYWZ0ZXIgaXQgc2V0cyAKPiBERVZJQ0VfTkVFRFNfUkVTRVQsIHRoZSBkZXZpY2UgTVVT
VCBzZW5kIGEgZGV2aWNlIGNvbmZpZ3VyYXRpb24gY2hhbmdlIAo+IG5vdGlmaWNhdGlvbiB0byB0
aGUgZHJpdmVyLgo+Cj4gIgo+Cj4gVGhpcyBsb29rcyBpbXBsaWVzIHRoYXQgTkVFRFNfUkVTRVQg
bWF5IG9ubHkgd29yayBhZnRlciBkZXZpY2UgaXMgCj4gcHJvYmVkLiBCdXQgaW4gdGhlIGN1cnJl
bnQgZGVzaWduLCBldmVuIHRoZSByZXNldCgpIGlzIG5vdCByZWxpYWJsZS4KPgo+Cj4+Cj4+PiBP
ciBhIHJvdWdoIGlkZWEgaXMgdGhhdCBtYXliZSBuZWVkIHNvbWUgcmVsYXhpbmcgdG8gYmUgY291
cGxlZCBsb29zZWx5Cj4+PiB3aXRoIHVzZXJzcGFjZS4gRS5nIHRoZSBkZXZpY2UgKGNvbnRyb2wg
cGF0aCkgaXMgaW1wbGVtZW50ZWQgaW4gdGhlCj4+PiBrZXJuZWwgYnV0IHRoZSBkYXRhcGF0aCBp
cyBpbXBsZW1lbnRlZCBpbiB0aGUgdXNlcnNwYWNlIGxpa2UgVFVOL1RBUC4KPj4+Cj4+IEkgdGhp
bmsgaXQgY2FuIHdvcmsgZm9yIG1vc3QgY2FzZXMuIE9uZSBwcm9ibGVtIGlzIHRoYXQgdGhlIHNl
dF9jb25maWcKPj4gbWlnaHQgY2hhbmdlIHRoZSBiZWhhdmlvciBvZiB0aGUgZGF0YSBwYXRoIGF0
IHJ1bnRpbWUsIGUuZy4KPj4gdmlydG5ldF9zZXRfbWFjX2FkZHJlc3MoKSBpbiB0aGUgdmlydGlv
LW5ldCBkcml2ZXIgYW5kCj4+IGNhY2hlX3R5cGVfc3RvcmUoKSBpbiB0aGUgdmlydGlvLWJsayBk
cml2ZXIuIE5vdCBzdXJlIGlmIHRoaXMgcGF0aCBpcwo+PiBhYmxlIHRvIHJldHVybiBiZWZvcmUg
dGhlIGRhdGFwYXRoIGlzIGF3YXJlIG9mIHRoaXMgY2hhbmdlLgo+Cj4KPiBHb29kIHBvaW50Lgo+
Cj4gQnV0IHNldF9jb25maWcoKSBzaG91bGQgYmUgcmFyZToKPgo+IEUuZyBpbiB0aGUgY2FzZSBv
ZiB2aXJ0aW8tbmV0IHdpdGggVkVSU0lPTl8xLCBjb25maWcgc3BhY2UgaXMgcmVhZCAKPiBvbmx5
LCBhbmQgaXQgd2FzIHNldCB2aWEgY29udHJvbCB2cS4KPgo+IEZvciBibG9jaywgd2UgY2FuCj4K
PiAxKSBzdGFydCBmcm9tIHdpdGhvdXQgV0NFIG9yCj4gMikgd2UgYWRkIGEgY29uZmlnIGNoYW5n
ZSBub3RpZmljYXRpb24gdG8gdXNlcnNwYWNlIG9yCj4gMykgZXh0ZW5kIHRoZSBzcGVjIHRvIHVz
ZSB2cSBpbnN0ZWFkIG9mIGNvbmZpZyBzcGFjZQo+Cj4gVGhhbmtzCgoKQW5vdGhlciB0aGluZyBp
ZiB3ZSB3YW50IHRvIGdvIHRoaXMgd2F5OgoKV2UgbmVlZCBmaW5kIGEgd2F5IHRvIHRlcm1pbmF0
ZSB0aGUgZGF0YSBwYXRoIGZyb20gdGhlIGtlcm5lbCBzaWRlLCB0byAKaW1wbGVtZW50IHRvIHJl
c2V0IHNlbWFudGljLgoKVGhhbmtzCgoKPgo+Cj4+Cj4+IFRoYW5rcywKPj4gWW9uZ2ppCj4+Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWls
aW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
