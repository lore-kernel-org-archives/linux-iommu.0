Return-Path: <SRS0=DplC=LI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE85C4743C
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 12:47:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89F1E61241
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 12:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89F1E61241
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 429BE605F8;
	Mon, 14 Jun 2021 12:47:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qW2uvZfxxQ4c; Mon, 14 Jun 2021 12:47:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 23A8D60654;
	Mon, 14 Jun 2021 12:47:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC3D7C000E;
	Mon, 14 Jun 2021 12:47:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3350EC000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 12:47:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1E56860654
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 12:47:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JV2g7gAPpoDH for <iommu@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 12:47:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 43EB9605F8
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 12:47:38 +0000 (UTC)
Received: by mail-lj1-x229.google.com with SMTP id 131so20040458ljj.3
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 05:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=QUObwUNWvgk8Ic1w7m2h32Aq1YfuXrxksajQxqaMrIs=;
 b=rj6ZqtY0hWRNdi47dSpXnG5VlOgr15kVbYhmu6VWU8u6FjoktZ8tvzKvzlkPnDP+pV
 XO3nhrT0y6qyTJZjPH5sSQnLiK2So2RyVxzuj8bZTSrohk/KJTgF8P077y+Fvbm3p3MS
 adrMOeNBlgRIAQ8M4JksRyHAk91ctiTVHRxKE+Ysd4cv7fxq0GrTjF2zot+++owhWgOZ
 akrE4+2kZBZEEm5a4N3TOZdjIGXh/Ipfb6XTfSeGKR/mE8wojx+WFi//AUD6f13s38T+
 dh0ynmjkc4C4o/Er1BLAEQaXeS2zTdDzm++TKc2dXCS2gvmp9hROmv+KiK5rYRK9W/Lu
 mMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=QUObwUNWvgk8Ic1w7m2h32Aq1YfuXrxksajQxqaMrIs=;
 b=KvXJY5SgMrd8//CrRsFW56M5vv/KAEdYqCeq0albuSFFdky2nV7sqVwfRtv4eYiWvn
 Fu/lUcoROuDvIyPrToKNgEvg2QoZqz+u2tHGYM2+tIo3K7shPnxJDXQu57eNZkMUpLc2
 9wk9mMg0BbQDZy+6d1jEyvbz7dLM8E5TsFxta/i+OXawox3SMBmOKl65Yz/R9Fh4QVDY
 FNohMyZt2OG2AC7VjTn8iEds1S3T7W3Hxdo69fipF0P7trZ1AEU10XGQyZDbev65s7/9
 aB3B5lqYyJkykiQ5ONCvSUAYDqHK9s8kN07uKBunwKoBZOx1aJX1kIqPqP6XaLWVU96w
 NkmA==
X-Gm-Message-State: AOAM532A4RizK3dSW9VXPaIQq6zO9tybopkkVFL0giTWAr9RxSTYVCWl
 MBvz6bdGxRGyWjPG9pVbBun+a8q1x/HQP4s8Tgs=
X-Google-Smtp-Source: ABdhPJxC86d8VXC4py9RRymEPfI5ESRE2fKe8HepltlfpWhz75a3A3JMLKsQJcx2NkZi9XGq2Uggz8yzDs460UQlrTk=
X-Received: by 2002:a2e:b8cc:: with SMTP id s12mr13710166ljp.66.1623674855928; 
 Mon, 14 Jun 2021 05:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210611095528.9230-1-roman_skakun@epam.com>
 <855a58e2-1e03-4763-cb56-81367b73762c@oracle.com>
In-Reply-To: <855a58e2-1e03-4763-cb56-81367b73762c@oracle.com>
From: Roman Skakun <rm.skakun@gmail.com>
Date: Mon, 14 Jun 2021 15:47:25 +0300
Message-ID: <CADu_u-MqALJkG8RJHrr65vC_sHu-UyvCGwwUfaBong0eir5+hQ@mail.gmail.com>
Subject: Re: [PATCH] swiotlb-xen: override common mmap and get_sgtable dma ops
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Andrii Anisov <andrii_anisov@epam.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 linux-kernel@vger.kernel.org,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 iommu@lists.linux-foundation.org, Roman Skakun <roman_skakun@epam.com>,
 xen-devel@lists.xenproject.org, Volodymyr Babchuk <volodymyr_babchuk@epam.com>
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

SGV5LCBCb3JpcyEKVGhhbmtzIGZvciB0aGUgcmV2aWV3LgoKSSBoYXZlIGFuIGFkZGl0aW9uYWwg
cXVlc3Rpb24gYWJvdXQgY3VycmVudCBpbXBsZW1lbnRhdGlvbiB0aGF0IGRpc3R1cmJlZCBtZS4K
SSB0aGluaywgdGhhdCB3ZSBjYW4gaGF2ZSBjYXNlcyB3aGVuIG1hcHBlZCBtZW1vcnkgY2FuIG5v
dCBiZQpwaHlzaWNhbGx5IGNvbnRpZ3VvdXMuCkluIG9yZGVyIHRvIHByb2NlZWQgdGhpcyBjb3Jy
ZWN0bHkgbmVlZCB0byBhcHBseSBzb21lIGFkZGl0aW9uYWwgc3RlcHMKdG8gY3VycmVudCBpbXBs
ZW1lbnRhdGlvbiBhcyB3ZWxsLgoKSW4gbW1hcCgpIDoKMS4gSXMgdGhlIG1lbW9yeSByZWdpb24g
cGh5c2ljYWxseSBjb250aWd1b3VzPwoyLiBSZW1hcCBtdWx0aXBsZSByYW5nZXMgaWYgaXQgaXMg
bm90LgoKSW4gZ2V0X3NndGFibGUoKSA6CjEuIElzIHRoZSBtZW1vcnkgcmVnaW9uIHBoeXNpY2Fs
bHkgY29udGlndW91cz8KMi4gQ3JlYXRlIHNndCB0aGF0IHdpbGwgYmUgaW5jbHVkZWQgbXVsdGlw
bGUgY29udGlndW91cyByYW5nZXMgaWYgaXQgaXMgbm90LgoKV2hhdCBkbyB5b3UgdGhpbmsgYWJv
dXQgaXQ/CgpDaGVlcnMhClJvbWFuCgoK0L/RgiwgMTEg0LjRjtC9LiAyMDIxINCzLiDQsiAxODoy
MCwgQm9yaXMgT3N0cm92c2t5IDxib3Jpcy5vc3Ryb3Zza3lAb3JhY2xlLmNvbT46Cj4KPgo+IE9u
IDYvMTEvMjEgNTo1NSBBTSwgUm9tYW4gU2tha3VuIHdyb3RlOgo+ID4KPiA+ICtzdGF0aWMgaW50
Cj4gPiAreGVuX3N3aW90bGJfZG1hX21tYXAoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3Qgdm1f
YXJlYV9zdHJ1Y3QgKnZtYSwKPiA+ICsgICAgICAgICAgICAgdm9pZCAqY3B1X2FkZHIsIGRtYV9h
ZGRyX3QgZG1hX2FkZHIsIHNpemVfdCBzaXplLAo+ID4gKyAgICAgICAgICAgICB1bnNpZ25lZCBs
b25nIGF0dHJzKQo+ID4gK3sKPiA+ICsgICAgIHVuc2lnbmVkIGxvbmcgdXNlcl9jb3VudCA9IHZt
YV9wYWdlcyh2bWEpOwo+ID4gKyAgICAgdW5zaWduZWQgbG9uZyBjb3VudCA9IFBBR0VfQUxJR04o
c2l6ZSkgPj4gUEFHRV9TSElGVDsKPiA+ICsgICAgIHVuc2lnbmVkIGxvbmcgb2ZmID0gdm1hLT52
bV9wZ29mZjsKPiA+ICsgICAgIHN0cnVjdCBwYWdlICpwYWdlOwo+ID4gKwo+ID4gKyAgICAgaWYg
KGlzX3ZtYWxsb2NfYWRkcihjcHVfYWRkcikpCj4gPiArICAgICAgICAgICAgIHBhZ2UgPSB2bWFs
bG9jX3RvX3BhZ2UoY3B1X2FkZHIpOwo+ID4gKyAgICAgZWxzZQo+ID4gKyAgICAgICAgICAgICBw
YWdlID0gdmlydF90b19wYWdlKGNwdV9hZGRyKTsKPiA+ICsKPiA+ICsgICAgIHZtYS0+dm1fcGFn
ZV9wcm90ID0gZG1hX3BncHJvdChkZXYsIHZtYS0+dm1fcGFnZV9wcm90LCBhdHRycyk7Cj4gPiAr
Cj4gPiArICAgICBpZiAoZG1hX21tYXBfZnJvbV9kZXZfY29oZXJlbnQoZGV2LCB2bWEsIGNwdV9h
ZGRyLCBzaXplLCAmcmV0KSkKPiA+ICsgICAgICAgICAgICAgcmV0dXJuIC1FTlhJTzsKPiA+ICsK
PiA+ICsgICAgIGlmIChvZmYgPj0gY291bnQgfHwgdXNlcl9jb3VudCA+IGNvdW50IC0gb2ZmKQo+
ID4gKyAgICAgICAgICAgICByZXR1cm4gLUVOWElPOwo+ID4gKwo+ID4gKyAgICAgcmV0dXJuIHJl
bWFwX3Bmbl9yYW5nZSh2bWEsIHZtYS0+dm1fc3RhcnQsCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgcGFnZV90b19wZm4ocGFnZSkgKyB2bWEtPnZtX3Bnb2ZmLAo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgIHVzZXJfY291bnQgPDwgUEFHRV9TSElGVCwgdm1hLT52bV9wYWdlX3Byb3QpOwo+ID4g
K30KPgo+Cj4gSSBzdWdnZXN0IHlvdSBjcmVhdGUgYSBoZWxwZXIgZm9yIGNvbXB1dGluZyBwYWdl
IHZhbHVlIGFuZCB0aGVuIHJldmVydCA5MjI2NTllYTc3MWIzZmQ3MjgxNDkyNjJjNWVhMTU2MDhm
YWI5NzE5IGFuZCBwYXNzIHJlc3VsdCBvZiB0aGUgaGVscGVyIGluc3RlYWQgb2YgY3B1X2FkZHIu
IEhlcmUgYW5kIGluIHhlbl9zd2lvdGxiX2RtYV9nZXRfc2d0YWJsZSgpLgo+Cj4KPiBBbmQgdXNl
IHRoaXMgbmV3IGhlbHBlciBpbiB4ZW5fc3dpb3RsYl9mcmVlX2NvaGVyZW50KCkgdG9vLiBJIGFt
IGN1cmlvdXMgdGhvdWdoIHdoeSB0aGlzIHdhcyBub3QgYSBwcm9ibGVtIHdoZW4gU3RlZmFubyB3
YXMgbG9va2luZyBhdCB0aGUgcHJvYmxlbSB0aGF0IGludHJvZHVjZWQgdGhpcyB2bWFsbG9jIGNo
ZWNrIChpLmUuIDhiMWU4NjhmNjYwNzY0OTAxODlhMzZkOTg0ZmNjZTI4NmNkZDYyOTUpLiBTdGVm
YW5vPwo+Cj4KPiAtYm9yaXMKCgoKLS0gCkJlc3QgUmVnYXJkcywgUm9tYW4uCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdApp
b21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
