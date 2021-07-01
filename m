Return-Path: <SRS0=acbz=LZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A76C11F69
	for <iommu@archiver.kernel.org>; Thu,  1 Jul 2021 10:26:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB2246148E
	for <iommu@archiver.kernel.org>; Thu,  1 Jul 2021 10:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB2246148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B246B83C4C;
	Thu,  1 Jul 2021 10:26:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jkhEISUqW_ud; Thu,  1 Jul 2021 10:26:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 916A88280E;
	Thu,  1 Jul 2021 10:26:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 648ECC0010;
	Thu,  1 Jul 2021 10:26:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D639C000E
 for <iommu@lists.linux-foundation.org>; Thu,  1 Jul 2021 10:26:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4B6D64013A
 for <iommu@lists.linux-foundation.org>; Thu,  1 Jul 2021 10:26:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EX8Kr2MCPCnE for <iommu@lists.linux-foundation.org>;
 Thu,  1 Jul 2021 10:26:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C9E4C400CD
 for <iommu@lists.linux-foundation.org>; Thu,  1 Jul 2021 10:26:34 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id i5so7703417eds.1
 for <iommu@lists.linux-foundation.org>; Thu, 01 Jul 2021 03:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=a9K4jyXYx47Q8btyuDKrrTrq0PEaaUA3+QP6HJIrGos=;
 b=UbsrHWUQ+mj/292xk46YRGIEWdXS7+QUOxq+6nNb3yIUs4zHYJrkuHGgQOce8DFrQe
 md9AW7iO+3I2/Gy/0pAB4ksC45W+234IMOkL++jK9Ut5s1vRLJE3bHdXjN761/r4oe2f
 rrENVsppo3Jrt+VvPkoj8uviilfOhQYD1fLZsSYmxlaq+oX/ZAl36g/kjQIzB82UT/ci
 MsYhbtWrw18oEv5eBIolntsiKHP3qi59dFbBWXD2KwR7OAOnPaSBv5xvF7/vHO2gDnY9
 DYJCzMg6LY4GJsFkzIZYE13B6X8/NPbpnEh/pX4mSS3+UYLngtGXoFLSkaU2VGZ/3SUB
 VdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=a9K4jyXYx47Q8btyuDKrrTrq0PEaaUA3+QP6HJIrGos=;
 b=YCkv/L0sRkffq/EGex7xHCsojoXVDjvJZGgyMGvgoyg4hSlKs3HZxuGpkzEueLzqX/
 rCyV9R7zNF0BQvMZL5m7tYl+wwis9ovvesi31jTGTSkqfPmsTs+bzEYgdyooiP8NX22N
 n4jrAH7/+uYHpB5qZDhxtDC3TtJbKrO/PAsDK+TmR7A35dxnwzNWpJyr6C5eRasa1UP/
 kDae6DIOJyRmtNbkt2IZAHrgNU1D1tlQZMxoOWgW3zqQuWrzhWMw0ooOaZ1FqNskatg3
 ir4oKGj1JsSOUeVPo2TGGbus0wzr8AX14PNq9UCt+sVjRSHsjc/cG4tbPT2tcmJtteRn
 jkfA==
X-Gm-Message-State: AOAM533v/27czPc8i5cZftBJ5DRfjId7iUO5LlX+6nZc7A6bnj0XUdHf
 iUJNZaEVI7uC+eTv5QalsGsyC+8L9zxn7q7KI3QF
X-Google-Smtp-Source: ABdhPJz1/meMgJS0CbGomq08efo6oPox9DOh/ZiqfZwarY0z7LVGZFk2nW7ff1FIg7dKAGvVHmDMMOZVK5XkBCN2Y10=
X-Received: by 2002:a50:ff01:: with SMTP id a1mr52286665edu.253.1625135192829; 
 Thu, 01 Jul 2021 03:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210615141331.407-1-xieyongji@bytedance.com>
 <20210615141331.407-10-xieyongji@bytedance.com>
 <YNSatrDFsg+4VvH4@stefanha-x1.localdomain>
 <CACycT3vaXQ4dxC9QUzXXJs7og6TVqqVGa8uHZnTStacsYAiFwQ@mail.gmail.com>
 <YNw+q/ADMPviZi6S@stefanha-x1.localdomain>
 <CACycT3t6M5i0gznABm52v=rdmeeLZu8smXAOLg+WsM3WY1fgTw@mail.gmail.com>
 <7264cb0b-7072-098e-3d22-2b7e89216545@redhat.com>
In-Reply-To: <7264cb0b-7072-098e-3d22-2b7e89216545@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Thu, 1 Jul 2021 18:26:21 +0800
Message-ID: <CACycT3v7pYXAFtijPgWCMZ2WXxjT2Y-DUwS3hN_T7dhfE5o_6g@mail.gmail.com>
Subject: Re: Re: [PATCH v8 09/10] vduse: Introduce VDUSE - vDPA Device in
 Userspace
To: Jason Wang <jasowang@redhat.com>
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christian Brauner <christian.brauner@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Stefan Hajnoczi <stefanha@redhat.com>, songmuchun@bytedance.com,
 Jens Axboe <axboe@kernel.dk>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 bcrl@kvack.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>
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

T24gVGh1LCBKdWwgMSwgMjAyMSBhdCAzOjU1IFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhh
dC5jb20+IHdyb3RlOgo+Cj4KPiDlnKggMjAyMS83LzEg5LiL5Y2IMjo1MCwgWW9uZ2ppIFhpZSDl
hpnpgZM6Cj4gPiBPbiBXZWQsIEp1biAzMCwgMjAyMSBhdCA1OjUxIFBNIFN0ZWZhbiBIYWpub2N6
aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPj4gT24gVHVlLCBKdW4gMjksIDIwMjEg
YXQgMTA6NTk6NTFBTSArMDgwMCwgWW9uZ2ppIFhpZSB3cm90ZToKPiA+Pj4gT24gTW9uLCBKdW4g
MjgsIDIwMjEgYXQgOTowMiBQTSBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+
IHdyb3RlOgo+ID4+Pj4gT24gVHVlLCBKdW4gMTUsIDIwMjEgYXQgMTA6MTM6MzBQTSArMDgwMCwg
WGllIFlvbmdqaSB3cm90ZToKPiA+Pj4+PiArLyogaW9jdGxzICovCj4gPj4+Pj4gKwo+ID4+Pj4+
ICtzdHJ1Y3QgdmR1c2VfZGV2X2NvbmZpZyB7Cj4gPj4+Pj4gKyAgICAgY2hhciBuYW1lW1ZEVVNF
X05BTUVfTUFYXTsgLyogdmR1c2UgZGV2aWNlIG5hbWUgKi8KPiA+Pj4+PiArICAgICBfX3UzMiB2
ZW5kb3JfaWQ7IC8qIHZpcnRpbyB2ZW5kb3IgaWQgKi8KPiA+Pj4+PiArICAgICBfX3UzMiBkZXZp
Y2VfaWQ7IC8qIHZpcnRpbyBkZXZpY2UgaWQgKi8KPiA+Pj4+PiArICAgICBfX3U2NCBmZWF0dXJl
czsgLyogZGV2aWNlIGZlYXR1cmVzICovCj4gPj4+Pj4gKyAgICAgX191NjQgYm91bmNlX3NpemU7
IC8qIGJvdW5jZSBidWZmZXIgc2l6ZSBmb3IgaW9tbXUgKi8KPiA+Pj4+PiArICAgICBfX3UxNiB2
cV9zaXplX21heDsgLyogdGhlIG1heCBzaXplIG9mIHZpcnRxdWV1ZSAqLwo+ID4+Pj4gVGhlIFZJ
UlRJTyBzcGVjaWZpY2F0aW9uIGFsbG93cyBwZXItdmlydHF1ZXVlIHNpemVzLiBBIGRldmljZSBj
YW4gaGF2ZQo+ID4+Pj4gdHdvIHZpcnRxdWV1ZXMsIHdoZXJlIHRoZSBmaXJzdCBvbmUgYWxsb3dz
IHVwIHRvIDEwMjQgZGVzY3JpcHRvcnMgYW5kCj4gPj4+PiB0aGUgc2Vjb25kIG9uZSBhbGxvd3Mg
b25seSAxMjggZGVzY3JpcHRvcnMsIGZvciBleGFtcGxlLgo+ID4+Pj4KPiA+Pj4gR29vZCBwb2lu
dCEgQnV0IGl0IGxvb2tzIGxpa2UgdmlydGlvLXZkcGEvdmlydGlvLXBjaSBkb2Vzbid0IHN1cHBv
cnQKPiA+Pj4gdGhhdCBub3cuIEFsbCB2aXJ0cXVldWVzIGhhdmUgdGhlIHNhbWUgbWF4aW11bSBz
aXplLgo+ID4+IEkgc2VlIHN0cnVjdCB2cGRhX2NvbmZpZ19vcHMgb25seSBzdXBwb3J0cyBhIHBl
ci1kZXZpY2UgbWF4IHZxIHNpemU6Cj4gPj4gdTE2ICgqZ2V0X3ZxX251bV9tYXgpKHN0cnVjdCB2
ZHBhX2RldmljZSAqdmRldik7Cj4gPj4KPiA+PiB2aXJ0aW8tcGNpIHN1cHBvcnRzIHBlci12aXJ0
cXVldWUgc2l6ZXMgYmVjYXVzZSB0aGUgc3RydWN0Cj4gPj4gdmlydGlvX3BjaV9jb21tb25fY2Zn
LT5xdWV1ZV9zaXplIHJlZ2lzdGVyIGlzIHBlci1xdWV1ZSAoY29udHJvbGxlZCBieQo+ID4+IHF1
ZXVlX3NlbGVjdCkuCj4gPj4KPiA+IE9oLCB5ZXMuIEkgbWlzcyBxdWV1ZV9zZWxlY3QuCj4gPgo+
ID4+IEkgZ3Vlc3MgdGhpcyBpcyBhIHF1ZXN0aW9uIGZvciBKYXNvbjogd2lsbCB2ZHBhIHdpbGwg
a2VlcCB0aGlzIGxpbWl0YXRpb24/Cj4gPj4gSWYgeWVzLCB0aGVuIFZEVVNFIGNhbiBzdGljayB0
byBpdCB0b28gd2l0aG91dCBydW5uaW5nIGludG8gcHJvYmxlbXMgaW4KPiA+PiB0aGUgZnV0dXJl
Lgo+Cj4KPiBJIHRoaW5rIGl0J3MgYmV0dGVyIHRvIGV4dGVuZCB0aGUgZ2V0X3ZxX251bV9tYXgo
KSBwZXIgdmlydHF1ZXVlLgo+Cj4gQ3VycmVudGx5LCB2RFBBIGFzc3VtZXMgdGhlIHBhcmVudCB0
byBoYXZlIGEgZ2xvYmFsIG1heCBzaXplLiBUaGlzIHNlZW1zCj4gdG8gd29yayBvbiBtb3N0IG9m
IHRoZSBwYXJlbnRzIGJ1dCBub3QgdnAtdkRQQSAod2hpY2ggY291bGQgYmUgYmFja2VkIGJ5Cj4g
UUVNVSwgaW4gdGhhdCBjYXNlIGN2cSdzIHNpemUgaXMgc21hbGxlcikuCj4KPiBGb3J0dW5hdGVs
eSwgd2UgaGF2ZW4ndCBlbmFibGVkIGhhZCBjdnEgc3VwcG9ydCBpbiB0aGUgdXNlcnNwYWNlIG5v
dy4KPgo+IEkgY2FuIHBvc3QgdGhlIGZpeGVzLgo+CgpPSy4gSWYgc28sIGl0IGxvb2tzIGxpa2Ug
d2UgbmVlZCB0byBzdXBwb3J0IHRoZSBwZXItdnEgY29uZmlndXJhdGlvbi4KSSB3b25kZXIgaWYg
aXQncyBiZXR0ZXIgdG8gdXNlIHNvbWV0aGluZyBsaWtlOiBWRFVTRV9DUkVBVEVfREVWSUNFIC0+
ClZEVVNFX1NFVFVQX1ZRIC0+IFZEVVNFX1NFVFVQX1ZRIC0+IC4uLiAtPiBWRFVTRV9FTkFCTEVf
REVWSUNFIHRvIGRvCmluaXRpYWxpemF0aW9uIHJhdGhlciB0aGFuIG9ubHkgdXNlIFZEVVNFX0NS
RUFURV9ERVZJQ0UuCgpUaGFua3MsCllvbmdqaQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vaW9tbXU=
