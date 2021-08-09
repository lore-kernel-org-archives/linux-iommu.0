Return-Path: <SRS0=YfIy=NA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDC2C4338F
	for <iommu@archiver.kernel.org>; Mon,  9 Aug 2021 05:56:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F74861057
	for <iommu@archiver.kernel.org>; Mon,  9 Aug 2021 05:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2F74861057
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E6BA0401E1;
	Mon,  9 Aug 2021 05:56:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xjHYZ_1aAfMN; Mon,  9 Aug 2021 05:56:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 60144400D4;
	Mon,  9 Aug 2021 05:56:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B673C001A;
	Mon,  9 Aug 2021 05:56:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 971D3C000E
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 05:56:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 736AA82B1A
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 05:56:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EkBIMe-t5tqm for <iommu@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 05:56:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2307F82AA9
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 05:56:43 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id b15so2834598ejg.10
 for <iommu@lists.linux-foundation.org>; Sun, 08 Aug 2021 22:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=1QKCwJXH7b2bV95pG+j9QIMKAhZHvf1ykyTmniZz1n8=;
 b=Tz23BY9lPnQ3vIL8d7cY3bYV2IhYyaRUOu6xQBORJN4cz8W0au9Gfbaf8lAUsNVPjB
 tAe8PYHGpUriBFSopttHCQqPoMMqR1rexL5EnAAhvV7l1kBuiWYPDjMEaayMcy4xi6aA
 5uuCDZ/qs9RJhz3WH8weHBsQyMPk7q4EdO+FETqAWaWTUAwpTlufojrgm+S4Uy1A1zXZ
 ZIxfVRVGOJA3AjSm25fOEwYePUK2HcOeOIwdB6uMCtposnKf/XtfViVOX2BxRLFe5OIJ
 L4Gu9IBkOOJTcyhBSto5DUifQ4gSNns3GbgdZ0iDqXV+q6HNfQZu9lYsJfT7RE/U4CCP
 sTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=1QKCwJXH7b2bV95pG+j9QIMKAhZHvf1ykyTmniZz1n8=;
 b=XrIMv16y48bJw2X/XGwdM9dvtyCtLeLFzN520e5y79PCA+3TZQvRxnOZrQiVLlX7fu
 xZdgOkR9lY0yA5FUm/QBNKjnh6Go+9gzRulxkDls/7NfXktoKaeBTQ8lSDd/av0Dm9vc
 zEoTRcEXl/nWtiKD54w8i0SjDJWLlH6nGOyiRC0Z+oYgdP4pyn/TbIU39e7ZO81CNAHA
 pyEIaT3dsRBj5zV1JVx9knuwv/NqxOxMIvFl4ee81ZeKL+ctXk3wtbJHCSSHTwhkr2xz
 soYsw+lj8hri12iyIVju9+eMcCadOcfkJ3hdkIf8KyKbjGO6teMIT8HrrnNlJFitMAzT
 qy/g==
X-Gm-Message-State: AOAM530YyHlIP4B0AwDTY3knBrebZIiYJuTQ3GDBstNsPhC5iDH24OkF
 SM9uQebbgPsG/UIervfAksZHSk/eJgtxB/rGuB+3
X-Google-Smtp-Source: ABdhPJytSHJOcxF9+rpBixPa7fMmae2NjP3sPUJopLOrs0pFpyMSkYVK2NfzI4kxhNLm4dqCFsDdPFoJRqjc++Vk9j4=
X-Received: by 2002:a17:907:3e0d:: with SMTP id
 hp13mr20504923ejc.372.1628488602064; 
 Sun, 08 Aug 2021 22:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210729073503.187-1-xieyongji@bytedance.com>
 <20210729073503.187-2-xieyongji@bytedance.com>
 <43d88942-1cd3-c840-6fec-4155fd544d80@redhat.com>
 <CACycT3vcpwyA3xjD29f1hGnYALyAd=-XcWp8+wJiwSqpqUu00w@mail.gmail.com>
 <6e05e25e-e569-402e-d81b-8ac2cff1c0e8@arm.com>
 <CACycT3sm2r8NMMUPy1k1PuSZZ3nM9aic-O4AhdmRRCwgmwGj4Q@mail.gmail.com>
 <417ce5af-4deb-5319-78ce-b74fb4dd0582@arm.com>
 <CACycT3vARzvd4-dkZhDHqUkeYoSxTa2ty0z0ivE1znGti+n1-g@mail.gmail.com>
 <8c381d3d-9bbd-73d6-9733-0f0b15c40820@redhat.com>
In-Reply-To: <8c381d3d-9bbd-73d6-9733-0f0b15c40820@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Mon, 9 Aug 2021 13:56:31 +0800
Message-ID: <CACycT3steXFeg7NRbWpo2J59dpYcumzcvM2zcPJAVe40-EvvEg@mail.gmail.com>
Subject: Re: [PATCH v10 01/17] iova: Export alloc_iova_fast() and
 free_iova_fast()
To: Jason Wang <jasowang@redhat.com>, Robin Murphy <robin.murphy@arm.com>
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christian Brauner <christian.brauner@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Liu Xiaodong <xiaodong.liu@intel.com>, linux-fsdevel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, Stefan Hajnoczi <stefanha@redhat.com>,
 songmuchun@bytedance.com, Jens Axboe <axboe@kernel.dk>,
 He Zhe <zhe.he@windriver.com>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 bcrl@kvack.org, netdev@vger.kernel.org, Joe Perches <joe@perches.com>,
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

T24gVGh1LCBBdWcgNSwgMjAyMSBhdCA5OjMxIFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhh
dC5jb20+IHdyb3RlOgo+Cj4KPiDlnKggMjAyMS84LzUg5LiL5Y2IODozNCwgWW9uZ2ppIFhpZSDl
hpnpgZM6Cj4gPj4gTXkgbWFpbiBwb2ludCwgdGhvdWdoLCBpcyB0aGF0IGlmIHlvdSd2ZSBhbHJl
YWR5IGdvdCBzb21ldGhpbmcgZWxzZQo+ID4+IGtlZXBpbmcgdHJhY2sgb2YgdGhlIGFjdHVhbCBh
ZGRyZXNzZXMsIHRoZW4gdGhlIHdheSB5b3UncmUgdXNpbmcgYW4KPiA+PiBpb3ZhX2RvbWFpbiBh
cHBlYXJzIHRvIGJlIHNvbWV0aGluZyB5b3UgY291bGQgZG8gd2l0aCBhIHRyaXZpYWwgYml0bWFw
Cj4gPj4gYWxsb2NhdG9yLiBUaGF0J3Mgd2h5IEkgZG9uJ3QgYnV5IHRoZSBlZmZpY2llbmN5IGFy
Z3VtZW50LiBUaGUgbWFpbgo+ID4+IGRlc2lnbiBwb2ludHMgb2YgdGhlIElPVkEgYWxsb2NhdG9y
IGFyZSB0byBtYW5hZ2UgbGFyZ2UgYWRkcmVzcyBzcGFjZXMKPiA+PiB3aGlsZSB0cnlpbmcgdG8g
bWF4aW1pc2Ugc3BhdGlhbCBsb2NhbGl0eSB0byBtaW5pbWlzZSB0aGUgdW5kZXJseWluZwo+ID4+
IHBhZ2V0YWJsZSB1c2FnZSwgYW5kIGFsbG9jYXRpbmcgd2l0aCBhIGZsZXhpYmxlIGxpbWl0IHRv
IHN1cHBvcnQKPiA+PiBtdWx0aXBsZSBkZXZpY2VzIHdpdGggZGlmZmVyZW50IGFkZHJlc3Npbmcg
Y2FwYWJpbGl0aWVzIGluIHRoZSBzYW1lCj4gPj4gYWRkcmVzcyBzcGFjZS4gSWYgbm9uZSBvZiB0
aG9zZSBhc3BlY3RzIGFyZSByZWxldmFudCB0byB0aGUgdXNlLWNhc2UgLQo+ID4+IHdoaWNoIEFG
QUlDUyBhcHBlYXJzIHRvIGJlIHRydWUgaGVyZSAtIHRoZW4gYXMgYSBnZW5lcmFsLXB1cnBvc2UK
PiA+PiByZXNvdXJjZSBhbGxvY2F0b3IgaXQncyBydWJiaXNoIGFuZCBoYXMgYW4gdW5yZWFzb25h
Ymx5IG1hc3NpdmUgbWVtb3J5Cj4gPj4gb3ZlcmhlYWQgYW5kIHRoZXJlIGFyZSBtYW55LCBtYW55
IGJldHRlciBjaG9pY2VzLgo+ID4+Cj4gPiBPSywgSSBnZXQgeW91ciBwb2ludC4gQWN0dWFsbHkg
d2UgdXNlZCB0aGUgZ2VucG9vbCBhbGxvY2F0b3IgaW4gdGhlCj4gPiBlYXJseSB2ZXJzaW9uLiBN
YXliZSB3ZSBjYW4gZmFsbCBiYWNrIHRvIHVzaW5nIGl0Lgo+Cj4KPiBJIHRoaW5rIG1heWJlIHlv
dSBjYW4gc2hhcmUgc29tZSBwZXJmIG51bWJlcnMgdG8gc2VlIGhvdyBtdWNoCj4gYWxsb2NfaW92
YV9mYXN0KCkgY2FuIGhlbHAuCj4KCkkgZGlkIHNvbWUgZmlvIHRlc3RzWzFdIHdpdGggYSByYW0t
YmFja2VuZCB2ZHVzZSBibG9jayBkZXZpY2VbMl0uCgpGb2xsb3dpbmcgYXJlIHNvbWUgcGVyZm9y
bWFuY2UgZGF0YToKCiAgICAgICAgICAgICAgICAgICAgICAgICAgICBudW1qb2JzPTEgICBudW1q
b2JzPTIgICAgbnVtam9icz00ICAgbnVtam9icz04CmlvdmFfYWxsb2NfZmFzdCAgICAxNDVrIGlv
cHMgICAgICAyNjVrIGlvcHMgICAgICA1MTRrIGlvcHMgICAgICA3NThrIGlvcHMKCmlvdmFfYWxs
b2MgICAgICAgICAgICAxMzdrIGlvcHMgICAgIDE3MGsgaW9wcyAgICAgIDEyOGsgaW9wcyAgICAg
IDExM2sgaW9wcwoKZ2VuX3Bvb2xfYWxsb2MgICAxNDNrIGlvcHMgICAgICAyNzBrIGlvcHMgICAg
ICA0NThrIGlvcHMgICAgICA1MjFrIGlvcHMKClRoZSBpb3ZhX2FsbG9jX2Zhc3QoKSBoYXMgdGhl
IGJlc3QgcGVyZm9ybWFuY2Ugc2luY2Ugd2UgYWx3YXlzIGhpdCB0aGUKcGVyLWNwdSBjYWNoZS4g
UmVnYXJkbGVzcyBvZiB0aGUgcGVyLWNwdSBjYWNoZSwgdGhlIGdlbnBvb2wgYWxsb2NhdG9yCnNo
b3VsZCBiZSBiZXR0ZXIgdGhhbiB0aGUgaW92YSBhbGxvY2F0b3IuCgpbMV0gZmlvIGpvYmZpbGU6
CgpbZ2xvYmFsXQpydz1yYW5kcmVhZApkaXJlY3Q9MQppb2VuZ2luZT1saWJhaW8KaW9kZXB0aD0x
Ngp0aW1lX2Jhc2VkPTEKcnVudGltZT02MHMKZ3JvdXBfcmVwb3J0aW5nCmJzPTRrCmZpbGVuYW1l
PS9kZXYvdmRhCltqb2JdCm51bWpvYnM9Li4KClsyXSAgJCBxZW11LXN0b3JhZ2UtZGFlbW9uIFwK
ICAgICAgLS1jaGFyZGV2IHNvY2tldCxpZD1jaGFybW9uaXRvcixwYXRoPS90bXAvcW1wLnNvY2ss
c2VydmVyLG5vd2FpdCBcCiAgICAgIC0tbW9uaXRvciBjaGFyZGV2PWNoYXJtb25pdG9yIFwKICAg
ICAgLS1ibG9ja2Rldgpkcml2ZXI9aG9zdF9kZXZpY2UsY2FjaGUuZGlyZWN0PW9uLGFpbz1uYXRp
dmUsZmlsZW5hbWU9L2Rldi9udWxsYjAsbm9kZS1uYW1lPWRpc2swClwKICAgICAgLS1leHBvcnQg
dHlwZT12ZHVzZS1ibGssaWQ9dGVzdCxub2RlLW5hbWU9ZGlzazAsd3JpdGFibGU9b24sbmFtZT12
ZHVzZS1udWxsLG51bS1xdWV1ZXM9MTYscXVldWUtc2l6ZT0xMjgKClRoZSBxZW11LXN0b3JhZ2Ut
ZGFlbW9uIGNhbiBiZSBidWlsZGVkIGJhc2VkIG9uIHRoZSByZXBvOgpodHRwczovL2dpdGh1Yi5j
b20vYnl0ZWRhbmNlL3FlbXUvdHJlZS92ZHVzZS10ZXN0LgoKVGhhbmtzLApZb25namkKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBs
aXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
