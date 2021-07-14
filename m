Return-Path: <SRS0=i+j8=MG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0563C11F67
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 05:45:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 840AB6138C
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 05:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840AB6138C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3F70740295;
	Wed, 14 Jul 2021 05:45:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fuq6XWyXT8Ei; Wed, 14 Jul 2021 05:45:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 100E040104;
	Wed, 14 Jul 2021 05:45:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D63EFC001A;
	Wed, 14 Jul 2021 05:45:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD839C001A
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 05:45:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A7B1F406AF
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 05:45:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1Z0CYcHaSP-N for <iommu@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 05:45:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 60E33406AB
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 05:45:23 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id h2so1501550edt.3
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 22:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=CHZPSlSYGfv/SLrxAM/jOzUDS1kn5mU0G7/MnH+av7w=;
 b=TFIXYmOj7xWCYyEiL8IfX/z7XfVUXzphq5lOB8eXolpRNkYjOSMo0nDnxvLCmz0v0P
 4eGMqbLigvSrkWD5Ktxv46HxIXTFcGk13cG3kVrsNbQzLREMK2CU0ptM1QqPqXW9BxdS
 yI4oyRP0mP48+7gXh6dqlj0high4D9cExctbn2AE52uoOqBY9Swobwxv+2it40H4ayu7
 w3w1GZTkgOOUrnt/2hwL0W/gWDo4Pi9Ue3FoX1Gqies4/s5dcU7t+zv44Y6s1Srs86AZ
 4j0nZgRECcfTY+He18dAroizi7KMqRIvXRIBJ9g/s8NvMcfm0xZ4ZqsIQ2184Hh5NyoU
 dwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CHZPSlSYGfv/SLrxAM/jOzUDS1kn5mU0G7/MnH+av7w=;
 b=taYeSJC+jEr/tMaZzBNhbK5fJxAnnx2bQtzVpBU4cgLijMBdPKWbsGv6kuRzWckIn2
 WQvQM+jq0PQwp/0Pi5h9kAXAezjTgaBJn3vp5CkbR0S9Hn2hn8Po7TFMtfocfGn1Q+oV
 gmFqL1QhKowDhp0zfMAxdqc+bJDZBXH/dnZCJpZicXx7kW9zKjbN2sjMXePnLaW8G59v
 vZoTW7qnjzpGW0/r0Z3nrtyuXGDhdJadmorj73NnOQzKlScMxbegc1n5UNN7LQKVq2y9
 iCoU8y94bivOuSfe2By4w+H26CFaZHfvXKiCvp2e5fBvFg8Lup1YqAkMoIi6jrdZf3nG
 VD2g==
X-Gm-Message-State: AOAM532+cDdX0povWvkdNycLYJmE5jN36IMhVzRFtWKw2PmsuDt7QwLO
 kkbwEr9Z50vOlpifHmla5N06JHuHXls+WdFoTJj8
X-Google-Smtp-Source: ABdhPJxB+DrOBDXuwclE4BqKnRj6flob2oW8SNccGw0iEXIiLGhLEqaAkjs4n04tANFRLCsq6H5lMvNd7tbeRCpkn8s=
X-Received: by 2002:a50:ff01:: with SMTP id a1mr10874200edu.253.1626241521339; 
 Tue, 13 Jul 2021 22:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210713084656.232-1-xieyongji@bytedance.com>
 <20210713084656.232-17-xieyongji@bytedance.com>
 <20210713132741.GM1954@kadam>
 <c42979dd-331f-4af5-fda6-18d80f22be2d@redhat.com>
In-Reply-To: <c42979dd-331f-4af5-fda6-18d80f22be2d@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Wed, 14 Jul 2021 13:45:10 +0800
Message-ID: <CACycT3vNiAdOLVRhjqUjZGBfPnCti+_5+vdkgtbJ4XyRsYfrPg@mail.gmail.com>
Subject: Re: [PATCH v9 16/17] vduse: Introduce VDUSE - vDPA Device in Userspace
To: Jason Wang <jasowang@redhat.com>
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christian Brauner <christian.brauner@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Liu Xiaodong <xiaodong.liu@intel.com>,
 =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, songmuchun@bytedance.com,
 Jens Axboe <axboe@kernel.dk>, He Zhe <zhe.he@windriver.com>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 bcrl@kvack.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>
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

T24gV2VkLCBKdWwgMTQsIDIwMjEgYXQgMTA6NTQgQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4KPgo+IOWcqCAyMDIxLzcvMTMg5LiL5Y2IOToyNywgRGFuIENhcnBl
bnRlciDlhpnpgZM6Cj4gPiBPbiBUdWUsIEp1bCAxMywgMjAyMSBhdCAwNDo0Njo1NVBNICswODAw
LCBYaWUgWW9uZ2ppIHdyb3RlOgo+ID4+ICtzdGF0aWMgaW50IHZkdXNlX2Rldl9pbml0X3ZkcGEo
c3RydWN0IHZkdXNlX2RldiAqZGV2LCBjb25zdCBjaGFyICpuYW1lKQo+ID4+ICt7Cj4gPj4gKyAg
ICBzdHJ1Y3QgdmR1c2VfdmRwYSAqdmRldjsKPiA+PiArICAgIGludCByZXQ7Cj4gPj4gKwo+ID4+
ICsgICAgaWYgKGRldi0+dmRldikKPiA+PiArICAgICAgICAgICAgcmV0dXJuIC1FRVhJU1Q7Cj4g
Pj4gKwo+ID4+ICsgICAgdmRldiA9IHZkcGFfYWxsb2NfZGV2aWNlKHN0cnVjdCB2ZHVzZV92ZHBh
LCB2ZHBhLCBkZXYtPmRldiwKPiA+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmdmR1
c2VfdmRwYV9jb25maWdfb3BzLCBuYW1lLCB0cnVlKTsKPiA+PiArICAgIGlmICghdmRldikKPiA+
PiArICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07Cj4gPiBUaGlzIHNob3VsZCBiZSBhbiBJU19F
UlIoKSBjaGVjayBpbnN0ZWFkIG9mIGEgTlVMTCBjaGVjay4KPgo+Cj4gWWVzLgo+Cj4KPiA+Cj4g
PiBUaGUgdmRwYV9hbGxvY19kZXZpY2UoKSBtYWNybyBpcyBkb2luZyBzb21ldGhpbmcgdmVyeSBj
b21wbGljYXRlZCBidXQKPiA+IEknbSBub3Qgc3VyZSB3aGF0LiAgSXQgY2FsbHMgY29udGFpbmVy
X29mKCkgYW5kIHRoYXQgbG9va3MgYnVnZ3kgdW50aWwKPiA+IHlvdSBzcG90IHRoZSBCVUlMRF9C
VUdfT05fWkVSTygpIGNvbXBpbGUgdGltZSBhc3NlcnQgd2hpY2ggZW5zdXJlcyB0aGF0Cj4gPiB0
aGUgY29udGFpbmVyX29mKCkgaXMgYSBuby1vcC4KPiA+Cj4gPiBPbmx5IG9uZSBvZiB0aGUgY2Fs
bGVycyBjaGVja3MgZm9yIGVycm9yIHBvaW50ZXJzIGNvcnJlY3RseSBzbyBtYXliZQo+ID4gaXQn
cyB0b28gY29tcGxpY2F0ZWQgb3IgbWF5YmUgdGhlcmUgc2hvdWxkIGJlIGJldHRlciBkb2N1bWVu
dGF0aW9uLgo+Cj4KPiBXZSBuZWVkIGJldHRlciBkb2N1bWVudGF0aW9uIGZvciB0aGlzIG1hY3Jv
IGFuZCBmaXggYWxsIHRoZSBidWdneSBjYWxsZXJzLgo+Cj4gWW9uZyBKaSwgd2FudCB0byBkbyB0
aGF0Pwo+CgpTdXJlLCBJIHdpbGwgc2VuZCB0aGUgZml4IHNvb24uCgpUaGFua3MsCllvbmdqaQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWls
aW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
