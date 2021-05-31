Return-Path: <SRS0=AF0h=K2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4305AC47095
	for <iommu@archiver.kernel.org>; Mon, 31 May 2021 06:24:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B72F461377
	for <iommu@archiver.kernel.org>; Mon, 31 May 2021 06:24:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B72F461377
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C30E83396;
	Mon, 31 May 2021 06:24:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PzyZvzluTI_e; Mon, 31 May 2021 06:24:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 75E89832E6;
	Mon, 31 May 2021 06:24:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53B39C000E;
	Mon, 31 May 2021 06:24:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9050C0001
 for <iommu@lists.linux-foundation.org>; Mon, 31 May 2021 06:24:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A76F0608A4
 for <iommu@lists.linux-foundation.org>; Mon, 31 May 2021 06:24:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hB9frzOkBTjW for <iommu@lists.linux-foundation.org>;
 Mon, 31 May 2021 06:24:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9CC4860629
 for <iommu@lists.linux-foundation.org>; Mon, 31 May 2021 06:24:42 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id u24so2647390edy.11
 for <iommu@lists.linux-foundation.org>; Sun, 30 May 2021 23:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=0hJJlqD132Gd7EhaPbNawTUnqR5c6+hfcFXnrzFsVn8=;
 b=FKwFOp8ttm3sshCHVWJF3mXce1SkYUyCTdpubyXfVw4Vdxd9zSRbWxl2VbemEftOqC
 4a7bZaFVxg0xV1GjttoXXwCpKmHsflUna4ZBhRLjy6a+ufEt5wSAUNa8yXMPFUAlq2Od
 nt9CTEta328XTYb9lHNHZmIXYFPO95YCqwKlDlhTqlbucuu6u8OtsnDPPUVWzb7wwdZp
 /0Q9S3H8r68Hs0axjzJISSXBu9M1voTx+4FOBRxgctyRanv7C+XJu6kGMKo/DKYptPFi
 ulr6qY2e2i1VKtWopRtIP/SZv5TPurKLn9ugSDMcdmbjNEbv570LIUH+uD/dNYx6rvKl
 Be1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0hJJlqD132Gd7EhaPbNawTUnqR5c6+hfcFXnrzFsVn8=;
 b=oWSGl6v/gglDBrnF1viylgp4o5kpg4RfAjrSVmKAzVdhIp5ya4ba36nRM5lnmjHq0a
 xD/KPcayZrPvickZAs88gdn2tNYG4P4kIAHg/5SlEQNNUMdQM4pMo8HEWDZWp/SVa4xn
 otj+ygrQaDZcUTrdCtcaGhRr6D/7rdP4Rbbc6M5eT0j6ll2RrtssakxkOlUZrhWynji6
 Q+hPXYrXeA47aylmMhO/hY+eBiMomuf30P9QYxGXLnZ58s+HMvDsF530WdFS/8dlnvHY
 A6m2i5NEVePa9oV/qNUYx4XPy7Sw71fnf5PNYboJnVBuLtqlQMrfqiWArI0BjheAxMLD
 YXlQ==
X-Gm-Message-State: AOAM533+FBt5XBW+VT31kp+jbasmn0LjlXyqIwfXvK+JumSca2fvI3YY
 ZfQsFCZ3/T2sTncEWSIBTpIaZAwVvGUIjx6fcMT+
X-Google-Smtp-Source: ABdhPJzr9U6IJxkX3CjW6XL3YRmAlPx7Z1RYgpf9NqF6B8TujBwb5JRcKa7caDMlSPK4EFfPI854o9/vK3kdjzVU40o=
X-Received: by 2002:a05:6402:4252:: with SMTP id
 g18mr23281321edb.195.1622442280586; 
 Sun, 30 May 2021 23:24:40 -0700 (PDT)
MIME-Version: 1.0
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
 <ea9fd2d2-870f-c4e2-d7a5-af759985c462@redhat.com>
In-Reply-To: <ea9fd2d2-870f-c4e2-d7a5-af759985c462@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Mon, 31 May 2021 14:24:29 +0800
Message-ID: <CACycT3ucaY-QYq14BHf5oqLjQ0Nc9ZTQ0DA0ATu8=-KkaU5b3Q@mail.gmail.com>
Subject: Re: Re: [PATCH v7 11/12] vduse: Introduce VDUSE - vDPA Device in
 Userspace
To: Jason Wang <jasowang@redhat.com>
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
 =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gTW9uLCBNYXkgMzEsIDIwMjEgYXQgMTI6MzkgUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4KPgo+IOWcqCAyMDIxLzUvMzEg5LiL5Y2IMTI6MjcsIFlvbmdqaSBY
aWUg5YaZ6YGTOgo+ID4gT24gRnJpLCBNYXkgMjgsIDIwMjEgYXQgMTA6MzEgQU0gSmFzb24gV2Fu
ZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPj4KPiA+PiDlnKggMjAyMS81LzI3IOS4
i+WNiDk6MTcsIFlvbmdqaSBYaWUg5YaZ6YGTOgo+ID4+PiBPbiBUaHUsIE1heSAyNywgMjAyMSBh
dCA0OjQxIFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4+Pj4g
5ZyoIDIwMjEvNS8yNyDkuIvljYgzOjM0LCBZb25namkgWGllIOWGmemBkzoKPiA+Pj4+PiBPbiBU
aHUsIE1heSAyNywgMjAyMSBhdCAxOjQwIFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5j
b20+IHdyb3RlOgo+ID4+Pj4+PiDlnKggMjAyMS81LzI3IOS4i+WNiDE6MDgsIFlvbmdqaSBYaWUg
5YaZ6YGTOgo+ID4+Pj4+Pj4gT24gVGh1LCBNYXkgMjcsIDIwMjEgYXQgMTowMCBQTSBKYXNvbiBX
YW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+Pj4+Pj4+PiDlnKggMjAyMS81LzI3
IOS4i+WNiDEyOjU3LCBZb25namkgWGllIOWGmemBkzoKPiA+Pj4+Pj4+Pj4gT24gVGh1LCBNYXkg
MjcsIDIwMjEgYXQgMTI6MTMgUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3Jv
dGU6Cj4gPj4+Pj4+Pj4+PiDlnKggMjAyMS81LzE3IOS4i+WNiDU6NTUsIFhpZSBZb25namkg5YaZ
6YGTOgo+ID4+Pj4+Pj4+Pj4+ICsKPiA+Pj4+Pj4+Pj4+PiArc3RhdGljIGludCB2ZHVzZV9kZXZf
bXNnX3N5bmMoc3RydWN0IHZkdXNlX2RldiAqZGV2LAo+ID4+Pj4+Pj4+Pj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICBzdHJ1Y3QgdmR1c2VfZGV2X21zZyAqbXNnKQo+ID4+Pj4+Pj4+Pj4+
ICt7Cj4gPj4+Pj4+Pj4+Pj4gKyAgICAgaW5pdF93YWl0cXVldWVfaGVhZCgmbXNnLT53YWl0cSk7
Cj4gPj4+Pj4+Pj4+Pj4gKyAgICAgc3Bpbl9sb2NrKCZkZXYtPm1zZ19sb2NrKTsKPiA+Pj4+Pj4+
Pj4+PiArICAgICB2ZHVzZV9lbnF1ZXVlX21zZygmZGV2LT5zZW5kX2xpc3QsIG1zZyk7Cj4gPj4+
Pj4+Pj4+Pj4gKyAgICAgd2FrZV91cCgmZGV2LT53YWl0cSk7Cj4gPj4+Pj4+Pj4+Pj4gKyAgICAg
c3Bpbl91bmxvY2soJmRldi0+bXNnX2xvY2spOwo+ID4+Pj4+Pj4+Pj4+ICsgICAgIHdhaXRfZXZl
bnRfa2lsbGFibGUobXNnLT53YWl0cSwgbXNnLT5jb21wbGV0ZWQpOwo+ID4+Pj4+Pj4+Pj4gV2hh
dCBoYXBwZW5zIGlmIHRoZSB1c2Vyc3BhY2UobWFsaWNvdXMpIGRvZXNuJ3QgZ2l2ZSBhIHJlc3Bv
bnNlIGZvcmV2ZXI/Cj4gPj4+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+Pj4gSXQgbG9va3MgbGlrZSBhIERP
Uy4gSWYgeWVzLCB3ZSBuZWVkIHRvIGNvbnNpZGVyIGEgd2F5IHRvIGZpeCB0aGF0Lgo+ID4+Pj4+
Pj4+Pj4KPiA+Pj4+Pj4+Pj4gSG93IGFib3V0IHVzaW5nIHdhaXRfZXZlbnRfa2lsbGFibGVfdGlt
ZW91dCgpIGluc3RlYWQ/Cj4gPj4+Pj4+Pj4gUHJvYmFibHksIGFuZCB0aGVuIHdlIG5lZWQgY2hv
b3NlIGEgc3VpdGFibGUgdGltZW91dCBhbmQgbW9yZSBpbXBvcnRhbnQsCj4gPj4+Pj4+Pj4gbmVl
ZCB0byByZXBvcnQgdGhlIGZhaWx1cmUgdG8gdmlydGlvLgo+ID4+Pj4+Pj4+Cj4gPj4+Pj4+PiBN
YWtlcyBzZW5zZSB0byBtZS4gQnV0IGl0IGxvb2tzIGxpa2Ugc29tZQo+ID4+Pj4+Pj4gdmRwYV9j
b25maWdfb3BzL3ZpcnRpb19jb25maWdfb3BzIHN1Y2ggYXMgc2V0X3N0YXR1cygpIGRpZG4ndCBo
YXZlIGEKPiA+Pj4+Pj4+IHJldHVybiB2YWx1ZS4gIE5vdyBJIGFkZCBhIFdBUk5fT04oKSBmb3Ig
dGhlIGZhaWx1cmUuIERvIHlvdSBtZWFuIHdlCj4gPj4+Pj4+PiBuZWVkIHRvIGFkZCBzb21lIGNo
YW5nZSBmb3IgdmlydGlvIGNvcmUgdG8gaGFuZGxlIHRoZSBmYWlsdXJlPwo+ID4+Pj4+PiBNYXli
ZSwgYnV0IEknbSBub3Qgc3VyZSBob3cgaGFyZCB3ZSBjYW4gZG8gdGhhdC4KPiA+Pj4+Pj4KPiA+
Pj4+PiBXZSBuZWVkIHRvIGNoYW5nZSBhbGwgdmlydGlvIGRldmljZSBkcml2ZXJzIGluIHRoaXMg
d2F5Lgo+ID4+Pj4gUHJvYmFibHkuCj4gPj4+Pgo+ID4+Pj4KPiA+Pj4+Pj4gV2UgaGFkIE5FRURT
X1JFU0VUIGJ1dCBpdCBsb29rcyB3ZSBkb24ndCBpbXBsZW1lbnQgaXQuCj4gPj4+Pj4+Cj4gPj4+
Pj4gQ291bGQgaXQgaGFuZGxlIHRoZSBmYWlsdXJlIG9mIGdldF9mZWF0dXJlKCkgYW5kIGdldC9z
ZXRfY29uZmlnKCk/Cj4gPj4+PiBMb29rcyBub3Q6Cj4gPj4+Pgo+ID4+Pj4gIgo+ID4+Pj4KPiA+
Pj4+IFRoZSBkZXZpY2UgU0hPVUxEIHNldCBERVZJQ0VfTkVFRFNfUkVTRVQgd2hlbiBpdCBlbnRl
cnMgYW4gZXJyb3Igc3RhdGUKPiA+Pj4+IHRoYXQgYSByZXNldCBpcyBuZWVkZWQuIElmIERSSVZF
Ul9PSyBpcyBzZXQsIGFmdGVyIGl0IHNldHMKPiA+Pj4+IERFVklDRV9ORUVEU19SRVNFVCwgdGhl
IGRldmljZSBNVVNUIHNlbmQgYSBkZXZpY2UgY29uZmlndXJhdGlvbiBjaGFuZ2UKPiA+Pj4+IG5v
dGlmaWNhdGlvbiB0byB0aGUgZHJpdmVyLgo+ID4+Pj4KPiA+Pj4+ICIKPiA+Pj4+Cj4gPj4+PiBU
aGlzIGxvb2tzIGltcGxpZXMgdGhhdCBORUVEU19SRVNFVCBtYXkgb25seSB3b3JrIGFmdGVyIGRl
dmljZSBpcwo+ID4+Pj4gcHJvYmVkLiBCdXQgaW4gdGhlIGN1cnJlbnQgZGVzaWduLCBldmVuIHRo
ZSByZXNldCgpIGlzIG5vdCByZWxpYWJsZS4KPiA+Pj4+Cj4gPj4+Pgo+ID4+Pj4+PiBPciBhIHJv
dWdoIGlkZWEgaXMgdGhhdCBtYXliZSBuZWVkIHNvbWUgcmVsYXhpbmcgdG8gYmUgY291cGxlZCBs
b29zZWx5Cj4gPj4+Pj4+IHdpdGggdXNlcnNwYWNlLiBFLmcgdGhlIGRldmljZSAoY29udHJvbCBw
YXRoKSBpcyBpbXBsZW1lbnRlZCBpbiB0aGUKPiA+Pj4+Pj4ga2VybmVsIGJ1dCB0aGUgZGF0YXBh
dGggaXMgaW1wbGVtZW50ZWQgaW4gdGhlIHVzZXJzcGFjZSBsaWtlIFRVTi9UQVAuCj4gPj4+Pj4+
Cj4gPj4+Pj4gSSB0aGluayBpdCBjYW4gd29yayBmb3IgbW9zdCBjYXNlcy4gT25lIHByb2JsZW0g
aXMgdGhhdCB0aGUgc2V0X2NvbmZpZwo+ID4+Pj4+IG1pZ2h0IGNoYW5nZSB0aGUgYmVoYXZpb3Ig
b2YgdGhlIGRhdGEgcGF0aCBhdCBydW50aW1lLCBlLmcuCj4gPj4+Pj4gdmlydG5ldF9zZXRfbWFj
X2FkZHJlc3MoKSBpbiB0aGUgdmlydGlvLW5ldCBkcml2ZXIgYW5kCj4gPj4+Pj4gY2FjaGVfdHlw
ZV9zdG9yZSgpIGluIHRoZSB2aXJ0aW8tYmxrIGRyaXZlci4gTm90IHN1cmUgaWYgdGhpcyBwYXRo
IGlzCj4gPj4+Pj4gYWJsZSB0byByZXR1cm4gYmVmb3JlIHRoZSBkYXRhcGF0aCBpcyBhd2FyZSBv
ZiB0aGlzIGNoYW5nZS4KPiA+Pj4+IEdvb2QgcG9pbnQuCj4gPj4+Pgo+ID4+Pj4gQnV0IHNldF9j
b25maWcoKSBzaG91bGQgYmUgcmFyZToKPiA+Pj4+Cj4gPj4+PiBFLmcgaW4gdGhlIGNhc2Ugb2Yg
dmlydGlvLW5ldCB3aXRoIFZFUlNJT05fMSwgY29uZmlnIHNwYWNlIGlzIHJlYWQgb25seSwKPiA+
Pj4+IGFuZCBpdCB3YXMgc2V0IHZpYSBjb250cm9sIHZxLgo+ID4+Pj4KPiA+Pj4+IEZvciBibG9j
aywgd2UgY2FuCj4gPj4+Pgo+ID4+Pj4gMSkgc3RhcnQgZnJvbSB3aXRob3V0IFdDRSBvcgo+ID4+
Pj4gMikgd2UgYWRkIGEgY29uZmlnIGNoYW5nZSBub3RpZmljYXRpb24gdG8gdXNlcnNwYWNlIG9y
Cj4gPj4+IEkgcHJlZmVyIHRoaXMgd2F5LiBBbmQgSSB0aGluayB3ZSBhbHNvIG5lZWQgdG8gZG8g
c2ltaWxhciB0aGluZ3MgZm9yCj4gPj4+IHNldC9nZXRfdnFfc3RhdGUoKS4KPiA+Pgo+ID4+IFll
cywgSSBhZ3JlZS4KPiA+Pgo+ID4gSGkgSmFzb24sCj4gPgo+ID4gTm93IEknbSB3b3JraW5nIG9u
IHRoaXMuIEJ1dCBJIGZvdW5kIHRoZSBjb25maWcgY2hhbmdlIG5vdGlmaWNhdGlvbgo+ID4gbXVz
dCBiZSBzeW5jaHJvbm91cyBpbiB0aGUgdmlydGlvLWJsayBjYXNlLCB3aGljaCBtZWFucyB0aGUg
a2VybmVsCj4gPiBzdGlsbCBuZWVkcyB0byB3YWl0IGZvciB0aGUgcmVzcG9uc2UgZnJvbSB1c2Vy
c3BhY2UgaW4gc2V0X2NvbmZpZygpLgo+ID4gT3RoZXJ3aXNlLCBzb21lIEkvT3MgbWlnaHQgc3Rp
bGwgcnVuIHRoZSBvbGQgd2F5IGFmdGVyIHdlIGNoYW5nZSB0aGUKPiA+IGNhY2hlX3R5cGUgaW4g
c3lzZnMuCj4gPgo+ID4gVGhlIHNpbXBsZSB3YXlzIHRvIHNvbHZlIHRoaXMgcHJvYmxlbSBhcmU6
Cj4gPgo+ID4gMS4gT25seSBzdXBwb3J0IHJlYWQtb25seSBjb25maWcgc3BhY2UsIGRpc2FibGUg
V0NFIGFzIHlvdSBzdWdnZXN0ZWQKPiA+IDIuIEFkZCBhIHJldHVybiB2YWx1ZSB0byBzZXRfY29u
ZmlnKCkgYW5kIGhhbmRsZSB0aGUgZmFpbHVyZSBvbmx5IGluCj4gPiB2aXJ0aW8tYmxrIGRyaXZl
cgo+ID4gMy4gUHJpbnQgc29tZSB3YXJuaW5ncyBhZnRlciB0aW1lb3V0IHNpbmNlIGl0IG9ubHkg
YWZmZWN0cyB0aGUKPiA+IGRhdGFwbGFuZSB3aGljaCBpcyB1bmRlciB1c2Vyc3BhY2UncyBjb250
cm9sCj4gPgo+ID4gQW55IHN1Z2dlc3Rpb25zPwo+Cj4KPiBMZXQncyBnbyB3aXRob3V0IFdDRSBm
aXJzdCBhbmQgbWFrZSBWRFVTRSB3b3JrIGZpcnN0LiBXZSBjYW4gdGhlbiB0aGluawo+IG9mIGEg
c29sdXRpb24gZm9yIFdDRSBvbiB0b3AuCj4KCkl0J3MgZmluZSB3aXRoIG1lLgoKVGhhbmtzLApZ
b25namkKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9t
bXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
