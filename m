Return-Path: <SRS0=1/OX=IR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C2AC433DB
	for <iommu@archiver.kernel.org>; Fri, 19 Mar 2021 00:48:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CE2964E83
	for <iommu@archiver.kernel.org>; Fri, 19 Mar 2021 00:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE2964E83
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D026F605F7;
	Fri, 19 Mar 2021 00:48:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mpRTIUTXQT2P; Fri, 19 Mar 2021 00:48:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE6FD605D5;
	Fri, 19 Mar 2021 00:48:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88767C000A;
	Fri, 19 Mar 2021 00:48:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3103EC0001
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 00:48:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 07BDD400FE
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 00:48:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IPxw567U313e for <iommu@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 00:48:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DBDF8400F7
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 00:48:18 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 f2-20020a17090a4a82b02900c67bf8dc69so5878717pjh.1
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 17:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=eG1QzwIi3xEaakEPyWiwcIUMucRPcW0kIWxB+VdX0Ok=;
 b=RAJG3mFP99nhvmv/KZWxUCdFpGEmKA3rijSW/KwwIvPUb9UZQ6Jg0EyQveb7G4h9fU
 pkKdfJGMdcIm4HI8uAVUa5Nzv5Zg4BsnDy2d+JmuFQzST8gNpib1b6rpiGNtvsMPhPOC
 LuJikCi/pTxL5zf9qwXIeLEFzpgbaTtIx5lksikP75lA4DjNhVOHDtGblLuffgfQNSmG
 iftKfGmNegPkTPItGtRXgUJVFUVTSrMS/FWSdPOvaAyUNDzyCrYvqQgRk1G/AUC4p7UC
 x53i7x8hpHXAlhD+e1Wa/QaFLzV3EUGQP9EqVnhWX4iPJvyM6NevwDVaL7Kw5/iotfQp
 ujjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eG1QzwIi3xEaakEPyWiwcIUMucRPcW0kIWxB+VdX0Ok=;
 b=Og7X/N6FeLTuTdEhIGnc7XO9RIJE7S2347AYyiCL7GDoUdp9Jk1I0smOnkCal/YuqY
 dRrF+MhVgfHmM+9anyIILZcpg1QHhl3G1JQEXursr1W5z5UMNOBDdWNemE6SNpC5QEvR
 zQOeaMBegi0XHR7mlIlpeemEjKYkbvfpnXVQ1k9BH5LOrmKRzTk9u4a2bbQF+XltE9pI
 fZlK90fYrDNfVeAsftjAxR0Se9RPhuCJPnxrI1M4WKRMNtZqUZVVhvNgnLpTi+2u1MUn
 MtVXABVyU697mLeJu1i90oGWs2Z30FJK2Z5i+LGGw1Zo/PAYRyUd5ybHz6dLvc7BVoKD
 8w1Q==
X-Gm-Message-State: AOAM533Ed87JxNOig7jrCelUQ0HbzozYZ6uQ76WUXwV7iV1MM2dG010g
 TDtHSK8t/X7OGiBu+VqX3sg=
X-Google-Smtp-Source: ABdhPJytY1xkTdXpw1JPFJu5Rw5Dhn60wo+Djui6kIuuXt0aDtxR6iyqkWGn1AA/gx0cUCg8L8D8GA==
X-Received: by 2002:a17:902:bf92:b029:e6:bc0:25ac with SMTP id
 v18-20020a170902bf92b02900e60bc025acmr12452727pls.49.1616114898109; 
 Thu, 18 Mar 2021 17:48:18 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id g2sm3388274pfi.28.2021.03.18.17.48.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Mar 2021 17:48:17 -0700 (PDT)
Subject: Re: [PATCH] swiotlb: Add swiotlb=off to disable SWIOTLB
To: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
References: <20210318191816.4185226-1-f.fainelli@gmail.com>
 <bbd44c42-cedc-7bd6-a443-c991fd080298@gmail.com>
 <e7850feb-b7cd-e279-e3fc-a9bdba162423@arm.com>
 <f0940ea7-79f6-af57-aa7d-d121abb99012@gmail.com>
 <16d1c66f-5451-2515-af73-a6b44d996e92@arm.com>
 <a8a05321-3fd0-d1c4-9d76-ec2e79e310ec@gmail.com>
 <3dd81519-4a73-efb8-abf0-0b766f993a8b@arm.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <a7a858e9-d6e6-cd06-85fc-8826e45d460e@gmail.com>
Date: Thu, 18 Mar 2021 17:48:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <3dd81519-4a73-efb8-abf0-0b766f993a8b@arm.com>
Content-Language: en-US
Cc: opendmb@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 "open list:SWIOTLB SUBSYSTEM" <iommu@lists.linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Mike Kravetz <mike.kravetz@oracle.com>
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

CgpPbiAzLzE4LzIwMjEgNDozNSBQTSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjEtMDMt
MTggMjE6MzEsIEZsb3JpYW4gRmFpbmVsbGkgd3JvdGU6Cj4+Cj4+Cj4+IE9uIDMvMTgvMjAyMSAx
Mjo1MyBQTSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+Pj4gT24gMjAyMS0wMy0xOCAxOTo0MywgRmxv
cmlhbiBGYWluZWxsaSB3cm90ZToKPj4+Pgo+Pj4+Cj4+Pj4gT24gMy8xOC8yMDIxIDEyOjM0IFBN
LCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+Pj4+IE9uIDIwMjEtMDMtMTggMTk6MjIsIEZsb3JpYW4g
RmFpbmVsbGkgd3JvdGU6Cj4+Pj4+Pgo+Pj4+Pj4KPj4+Pj4+IE9uIDMvMTgvMjAyMSAxMjoxOCBQ
TSwgRmxvcmlhbiBGYWluZWxsaSB3cm90ZToKPj4+Pj4+PiBJdCBtYXkgYmUgdXNlZnVsIHRvIGRp
c2FibGUgdGhlIFNXSU9UTEIgY29tcGxldGVseSBmb3IgdGVzdGluZyBvcgo+Pj4+Pj4+IHdoZW4g
YQo+Pj4+Pj4+IHBsYXRmb3JtIGlzIGtub3duIG5vdCB0byBoYXZlIGFueSBEUkFNIGFkZHJlc3Np
bmcgbGltaXRhdGlvbnMKPj4+Pj4+PiB3aGF0IHNvCj4+Pj4+Pj4gZXZlci4KPj4+Pj4KPj4+Pj4g
SXNuJ3QgdGhhdCB3aGF0ICJzd2lvdGxiPW5vZm9yY2UiIGlzIGZvcj8gSWYgeW91J3JlIGNvbmZp
ZGVudCB0aGF0Cj4+Pj4+IHdlJ3ZlCj4+Pj4+IHJlYWxseSBpcm9uZWQgb3V0ICphbGwqIHRoZSBh
d2t3YXJkIGNvcm5lcnMgdGhhdCB1c2VkIHRvIGJsb3cgdXAgaWYKPj4+Pj4gdmFyaW91cyBpbnRl
cm5hbCBiaXRzIHdlcmUgbGVmdCB1bmluaXRpYWxpc2VkLCB0aGVuIGl0IHdvdWxkIG1ha2UKPj4+
Pj4gc2Vuc2UKPj4+Pj4gdG8ganVzdCB0d2VhayB0aGUgaW1wbGVtZW50YXRpb24gb2Ygd2hhdCB3
ZSBhbHJlYWR5IGhhdmUuCj4+Pj4KPj4+PiBzd2lvdGxiPW5vZm9yY2UgZG9lcyBwcmV2ZW50IGRt
YV9kaXJlY3RfbWFwX3BhZ2UoKSBmcm9tIHJlc29ydGluZyB0bwo+Pj4+IHRoZQo+Pj4+IHN3aW90
bGIsIGhvd2V2ZXIgd2hhdCBJIGFtIGFsc28gYWZ0ZXIgaXMgcmVjbGFpbWluZyB0aGVzZSA2NE1C
IG9mCj4+Pj4gZGVmYXVsdCBTV0lPVExCIGJvdW5jZSBidWZmZXJpbmcgbWVtb3J5IGJlY2F1c2Ug
bXkgc3lzdGVtcyBydW4gd2l0aAo+Pj4+IGxhcmdlIGFtb3VudHMgb2YgcmVzZXJ2ZWQgbWVtb3J5
IGludG8gWk9ORV9NT1ZBQkxFIGFuZCBldmVyeXRoaW5nIGluCj4+Pj4gWk9ORV9OT1JNQUwgaXMg
cHJlY2lvdXMgYXQgdGhhdCBwb2ludC4KPj4+Cj4+PiBJdCBhbHNvIGZvcmNlcyBpb190bGJfbnNs
YWJzIHRvIHRoZSBtaW5pbXVtLCBzbyBpdCBzaG91bGQgYmUgY2xhaW1pbmcKPj4+IGNvbnNpZGVy
YWJseSBsZXNzIHRoYW4gNjRNQi4gSUlSQyB0aGUgb3JpZ2luYWwgcHJvcG9zYWwgKmRpZCogc2tp
cAo+Pj4gaW5pdGlhbGlzYXRpb24gY29tcGxldGVseSwgYnV0IHRoYXQgdHVybmVkIHVwIHRoZSBh
Zm9yZW1lbnRpb25lZCBpc3N1ZXMuCj4+Cj4+IEFGQUlDVCBpbiB0aGF0IGNhc2Ugd2Ugd2lsbCBo
YXZlIGlvdGxiX25fc2xhYnMgd2lsbCBzZXQgdG8gMSwgd2hpY2ggd2lsbAo+PiBzdGlsbCBtYWtl
IHVzIGFsbG9jYXRlIGlvX3RsYl9uX3NsYWJzIDw8IElPX1RMQl9TSElGVCBieXRlcyBpbgo+PiBz
d2lvdGxiX2luaXQoKSwgd2hpY2ggc3RpbGwgZ2l2ZXMgdXMgNjRNQi4KPiAKPiBFaD8gV2hlbiBk
aWQgMktCIGJlY29tZSA2NE1CPyBJT19UTEJfU0hJRlQgaXMgMTEsIHNvIHRoYXQncyBhdCBtb3N0
IG9uZQo+IHBhZ2UgaW4gYW55b25lJ3MgbW9uZXkuLi4KClllcywgc29ycnkgaW5jb3JyZWN0IHNo
aWZ0IGFwcGxpZWQgaGVyZS4gU3RpbGwsIGFuZCBJIGJlbGlldmUgdGhpcyBpcwp3aGF0IHlvdSBt
ZWFuIGJlbG93LCBhcmNoaXRlY3R1cmUgY29kZSBzZXR0aW5nIHN3aW90bGJfZm9yY2UgPQpTV0lP
VExCX05PX0ZPUkNFIGRvZXMgbm90IHJlc3VsdCBpbiBub3QgYWxsb2NhdGluZyB0aGUgU1dJT1RM
QiwgYmVjYXVzZQppb190bGJfbnNsYWJzIGlzIHN0aWxsIGxlZnQgc2V0IHRvIDAgc28gc3dpb3Rs
Yl9pbml0KCkgd2lsbCBwcm9jZWVkIHdpdGgKYWxsb2NhdGluZyB0aGUgZGVmYXVsdCBzaXplLgoK
PiAKPj4+Pj4gSSB3b3VsZG4ndCBuZWNlc3NhcmlseSBkaXNhZ3JlZSB3aXRoIGFkZGluZyAib2Zm
IiBhcyBhbiBhZGRpdGlvbmFsCj4+Pj4+IGFsaWFzCj4+Pj4+IGZvciAibm9mb3JjZSIsIHRob3Vn
aCwgc2luY2UgaXQgZG9lcyBjb21lIGFjcm9zcyBhcyBhIGJpdCB3YWNreSBmb3IKPj4+Pj4gZ2Vu
ZXJhbCB1c2UuCj4+Pj4+Cj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogRmxvcmlhbiBGYWluZWxsaSA8
Zi5mYWluZWxsaUBnbWFpbC5jb20+Cj4+Pj4+Pgo+Pj4+Pj4gQ2hyaXN0b3BoLCBpbiBhZGRpdGlv
biB0byB0aGlzIGNoYW5nZSwgaG93IHdvdWxkIHlvdSBmZWVsIGlmIHdlCj4+Pj4+PiBxdWFsaWZp
ZWQgdGhlIHN3aW90bGJfaW5pdCgpIGluIGFyY2gvYXJtL21tL2luaXQuYyB3aXRoIGE6Cj4+Pj4+
Pgo+Pj4+Pj4KPj4+Pj4+IGlmIChtZW1ibG9ja19lbmRfb2ZfRFJBTSgpID49IFNaXzRHKQo+Pj4+
Pj4gwqDCoMKgwqDCoMKgc3dpb3RsYl9pbml0KDEpCj4+Pj4+Cj4+Pj4+IE1vZHVsbyAic3dpb3Rs
Yj1mb3JjZSIsIG9mIGNvdXJzZSA7KQo+Pj4+Cj4+Pj4gSW5kZWVkLCB3ZSB3b3VsZCBuZWVkIHRv
IGhhbmRsZSB0aGF0IGNhc2UgYXMgd2VsbC4gRG9lcyBpdCBzb3VuZAo+Pj4+IHJlYXNvbmFibGUg
dG8gZG8gdGhhdCB0byB5b3UgYXMgd2VsbD8KPj4+Cj4+PiBJIHdvdWxkbid0IGxpa2UgaXQgZG9u
ZSB0byBtZSBwZXJzb25hbGx5LCBidXQgZm9yIGFybTY0LCBvYnNlcnZlIHdoYXQKPj4+IG1lbV9p
bml0KCkgaW4gYXJjaC9hcm02NC9tbS9pbml0LmMgYWxyZWFkeSBkb2VzLgo+IAo+IEluIGZhY3Qg
SSBzaG91bGQgaGF2ZSBsb29rZWQgbW9yZSBjbG9zZWx5IGF0IHRoYXQgbXlzZWxmIC0gY2hlY2tp
bmcKPiBkZWJ1Z2ZzIG9uIG15IDRHQiBhcm02NCBib2FyZCBhY3R1YWxseSBzaG93cyBpb190bGJf
bnNsYWJzID0gMCwgYW5kCj4gaW5kZWVkIHdlIGFyZSBieXBhc3NpbmcgaW5pdGlhbGlzYXRpb24g
Y29tcGxldGVseSBhbmQgKGFiKXVzaW5nCj4gU1dJT1RMQl9OT19GT1JDRSB0byBjb3ZlciBpdCB1
cCwgc28gSSBndWVzcyBpdCBwcm9iYWJseSAqaXMqIHNhZmUgbm93Cj4gZm9yIHRoZSBub2ZvcmNl
IG9wdGlvbiB0byBkbyB0aGUgc2FtZSBmb3IgaXRzZWxmIGFuZCBzYXZlIGV2ZW4gdGhhdCBvbmUK
PiBwYWdlLgoKT0ssIEkgY2FuIHN1Ym1pdCBhIHBhdGNoIHRoYXQgZG9lcyB0aGF0LiA1LjEyLXJj
MyB3b3JrcyBjb3JyZWN0bHkgZm9yIG1lCmhlcmUgYXMgd2VsbCBhbmQgb25seSBhbGxvY2F0ZXMg
U1dJT1RMQiB3aGVuIG5lZWRlZCB3aGljaCBpbiBvdXIgY2FzZSBpcwplaXRoZXI6CgotIHdlIGhh
dmUgRFJBTSBhdCBQQSA+PSA0R0IKLSB3ZSBoYXZlIGxpbWl0ZWQgcGVyaXBoZXJhbHMgKFJhc3Bi
ZXJyeSBQaSA0IGRlcml2YXRpdmUpIHRoYXQgY2FuIG9ubHkKYWRkcmVzcyB0aGUgbG93ZXIgMUdC
CgpOb3cgbGV0J3Mgc2VlIGlmIHdlIGNhbiBnZXQgQVJNIDMyLWJpdCB0byBtYXRjaCA6KQotLSAK
RmxvcmlhbgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpp
b21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
