Return-Path: <SRS0=i+j8=MG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69174C11F66
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 09:42:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F186613CA
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 09:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F186613CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ADE6C4158B;
	Wed, 14 Jul 2021 09:42:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wFNNudI5kxGs; Wed, 14 Jul 2021 09:42:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6C45D4159C;
	Wed, 14 Jul 2021 09:42:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3264EC0010;
	Wed, 14 Jul 2021 09:42:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9AF78C000E
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 09:42:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7435160804
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 09:42:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G6asUeqHN2UI for <iommu@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 09:42:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AC03560A78
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 09:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626255729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZplaldvdPUqWqjFHRQy6XqAYb6B2IbOETrAj7lOt6Jc=;
 b=U/iYW3aw5IvGT0aLmnDGEgbNSbd3zFCuMNZvKUaU6vdvh/QQ3wHtRhFO8uI/3Yie8wQicU
 A0VzkvKIq4XVYe2Pz89y/TfGPrHHYaqbLAtkTA32Rg5QWVy+NaiLybW60HuUIXYIm1eYq7
 IR5D4ADt9M7YDgtgA9PJudwghn9bWfk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-WsyWGMIJPVK2xGNnIQC1MA-1; Wed, 14 Jul 2021 05:42:08 -0400
X-MC-Unique: WsyWGMIJPVK2xGNnIQC1MA-1
Received: by mail-pj1-f72.google.com with SMTP id
 z5-20020a17090a7b85b0290173d3902d78so1140457pjc.9
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 02:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=ZplaldvdPUqWqjFHRQy6XqAYb6B2IbOETrAj7lOt6Jc=;
 b=O2rm0IexmU15Gis4l/KYE7t+L/OA9QGGRcPnLmexWcbiq5jkBhTwtmpi5JyXaMKBpY
 z9GUL7X/UkWtMp96VvwiPsv/rkFUe+8VWqMncWqO827Y5h8kMu1SHB0kibhH5o8mq8iF
 TLPUsz4/VhUhDeDBoc+n2CJ0WAS2O9JM1iPQ6Vq1RIvY806yj4wn4TW7lBQN9x6qL44W
 FtH2M8BxXxDqbwpcZE8L1BsaoqinbRo59PhDhKnswL3yBbnESXWL42xoMHSAVcgIgrHV
 obPXZQ7B/cqVex5GyzY/s1EHjJVZQ+/MlmkHRX7Fajgx7s6r5l1zPxT3J+ABWZ/FGAeO
 /X9w==
X-Gm-Message-State: AOAM530ZSCfJa2XAc3ubqdzVpozq7asYtzNRRTbVSB2um+d+dRZt5mRO
 NEVukoEVK2sL/CSisDjB1Gxu8Q4Tg5LmXBk4DC4zVrl1LPAKKPWmyah0A4NPwv0qp5w4d1t3xD6
 k7dUyvGGqkMplu/g83TAh+CeXGT1DTg==
X-Received: by 2002:a17:90a:7a86:: with SMTP id
 q6mr3009937pjf.141.1626255727205; 
 Wed, 14 Jul 2021 02:42:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzB8iUML1glTVs5bknbuEkym014DDJoi+0qmllMveSYsw48CwsnGAccGqgHSeXUC5btvXZSoA==
X-Received: by 2002:a17:90a:7a86:: with SMTP id
 q6mr3009902pjf.141.1626255726913; 
 Wed, 14 Jul 2021 02:42:06 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id p5sm2075572pfn.46.2021.07.14.02.41.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jul 2021 02:42:06 -0700 (PDT)
Subject: Re: [PATCH v9 13/17] vdpa: factor out vhost_vdpa_pa_map() and
 vhost_vdpa_pa_unmap()
To: Dan Carpenter <dan.carpenter@oracle.com>
References: <20210713084656.232-1-xieyongji@bytedance.com>
 <20210713084656.232-14-xieyongji@bytedance.com> <20210713113114.GL1954@kadam>
 <20e75b53-0dce-2f2d-b717-f78553bddcd8@redhat.com>
 <20210714080512.GW1954@kadam>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <db02315d-0ffe-f4a2-da67-5a014060fa4a@redhat.com>
Date: Wed, 14 Jul 2021 17:41:54 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210714080512.GW1954@kadam>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, mst@redhat.com,
 virtualization@lists.linux-foundation.org, christian.brauner@canonical.com,
 corbet@lwn.net, willy@infradead.org, hch@infradead.org,
 Xie Yongji <xieyongji@bytedance.com>, sgarzare@redhat.com,
 xiaodong.liu@intel.com, viro@zeniv.linux.org.uk, stefanha@redhat.com,
 songmuchun@bytedance.com, axboe@kernel.dk, zhe.he@windriver.com,
 gregkh@linuxfoundation.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, bcrl@kvack.org,
 netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 mika.penttila@nextfour.com
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

CuWcqCAyMDIxLzcvMTQg5LiL5Y2INDowNSwgRGFuIENhcnBlbnRlciDlhpnpgZM6Cj4gT24gV2Vk
LCBKdWwgMTQsIDIwMjEgYXQgMTA6MTQ6MzJBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4g
5ZyoIDIwMjEvNy8xMyDkuIvljYg3OjMxLCBEYW4gQ2FycGVudGVyIOWGmemBkzoKPj4+IE9uIFR1
ZSwgSnVsIDEzLCAyMDIxIGF0IDA0OjQ2OjUyUE0gKzA4MDAsIFhpZSBZb25namkgd3JvdGU6Cj4+
Pj4gQEAgLTYxMywzNyArNjE4LDI4IEBAIHN0YXRpYyB2b2lkIHZob3N0X3ZkcGFfdW5tYXAoc3Ry
dWN0IHZob3N0X3ZkcGEgKnYsIHU2NCBpb3ZhLCB1NjQgc2l6ZSkKPj4+PiAgICAJfQo+Pj4+ICAg
IH0KPj4+PiAtc3RhdGljIGludCB2aG9zdF92ZHBhX3Byb2Nlc3NfaW90bGJfdXBkYXRlKHN0cnVj
dCB2aG9zdF92ZHBhICp2LAo+Pj4+IC0JCQkJCSAgIHN0cnVjdCB2aG9zdF9pb3RsYl9tc2cgKm1z
ZykKPj4+PiArc3RhdGljIGludCB2aG9zdF92ZHBhX3BhX21hcChzdHJ1Y3Qgdmhvc3RfdmRwYSAq
diwKPj4+PiArCQkJICAgICB1NjQgaW92YSwgdTY0IHNpemUsIHU2NCB1YWRkciwgdTMyIHBlcm0p
Cj4+Pj4gICAgewo+Pj4+ICAgIAlzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYgPSAmdi0+dmRldjsKPj4+
PiAtCXN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIgPSBkZXYtPmlvdGxiOwo+Pj4+ICAgIAlzdHJ1
Y3QgcGFnZSAqKnBhZ2VfbGlzdDsKPj4+PiAgICAJdW5zaWduZWQgbG9uZyBsaXN0X3NpemUgPSBQ
QUdFX1NJWkUgLyBzaXplb2Yoc3RydWN0IHBhZ2UgKik7Cj4+Pj4gICAgCXVuc2lnbmVkIGludCBn
dXBfZmxhZ3MgPSBGT0xMX0xPTkdURVJNOwo+Pj4+ICAgIAl1bnNpZ25lZCBsb25nIG5wYWdlcywg
Y3VyX2Jhc2UsIG1hcF9wZm4sIGxhc3RfcGZuID0gMDsKPj4+PiAgICAJdW5zaWduZWQgbG9uZyBs
b2NrX2xpbWl0LCBzejJwaW4sIG5jaHVua3MsIGk7Cj4+Pj4gLQl1NjQgaW92YSA9IG1zZy0+aW92
YTsKPj4+PiArCXU2NCBzdGFydCA9IGlvdmE7Cj4+Pj4gICAgCWxvbmcgcGlubmVkOwo+Pj4+ICAg
IAlpbnQgcmV0ID0gMDsKPj4+PiAtCWlmIChtc2ctPmlvdmEgPCB2LT5yYW5nZS5maXJzdCB8fAo+
Pj4+IC0JICAgIG1zZy0+aW92YSArIG1zZy0+c2l6ZSAtIDEgPiB2LT5yYW5nZS5sYXN0KQo+Pj4+
IC0JCXJldHVybiAtRUlOVkFMOwo+Pj4gVGhpcyBpcyBub3QgcmVsYXRlZCB0byB5b3VyIHBhdGNo
LCBidXQgY2FuIHRoZSAibXNnLT5pb3ZhICsgbXNnLT5zaXplIgo+Pj4gYWRkaXRpb24gY2FuIGhh
dmUgYW4gaW50ZWdlciBvdmVyZmxvdy4gIEZyb20gbG9va2luZyBhdCB0aGUgY2FsbGVycyBpdAo+
Pj4gc2VlbXMgbGlrZSBpdCBjYW4uICBtc2cgY29tZXMgZnJvbToKPj4+ICAgICB2aG9zdF9jaHJf
d3JpdGVfaXRlcigpCj4+PiAgICAgLS0+IGRldi0+bXNnX2hhbmRsZXIoZGV2LCAmbXNnKTsKPj4+
ICAgICAgICAgLS0+IHZob3N0X3ZkcGFfcHJvY2Vzc19pb3RsYl9tc2coKQo+Pj4gICAgICAgICAg
ICAtLT4gdmhvc3RfdmRwYV9wcm9jZXNzX2lvdGxiX3VwZGF0ZSgpCj4+Cj4+IFllcy4KPj4KPj4K
Pj4+IElmIEknbSB0aGlua2luZyBvZiB0aGUgcmlnaHQgdGhpbmcgdGhlbiB0aGVzZSBhcmUgYWxs
b3dlZCB0byBvdmVyZmxvdyB0bwo+Pj4gMCBiZWNhdXNlIG9mIHRoZSAiIC0gMSIgYnV0IG5vdCBm
dXJ0aGVyIHRoYW4gdGhhdC4gIEkgYmVsaWV2ZSB0aGUgY2hlY2sKPj4+IG5lZWRzIHRvIGJlIHNv
bWV0aGluZyBsaWtlOgo+Pj4KPj4+IAlpZiAobXNnLT5pb3ZhIDwgdi0+cmFuZ2UuZmlyc3QgfHwK
Pj4+IAkgICAgbXNnLT5pb3ZhIC0gMSA+IFU2NF9NQVggLSBtc2ctPnNpemUgfHwKPj4KPj4gSSBn
dWVzcyB3ZSBkb24ndCBuZWVkIC0gMSBoZXJlPwo+IFRoZSAtIDEgaXMgaW1wb3J0YW50LiAgVGhl
IGhpZ2hlc3QgYWRkcmVzcyBpcyAweGZmZmZmZmZmLiAgU28gaXQgZ29lcwo+IHN0YXJ0ICsgc2l6
ZSA9IDAgYW5kIHRoZW4gc3RhcnQgKyBzaXplIC0gMSA9PSAweGZmZmZmZmZmLgoKClJpZ2h0LCBz
byBhY3R1YWxseQoKbXNnLT5pb3ZhID0gMHhmZmZmZmZmZSwgbXNnLT5zaXplPTIgaXMgdmFsaWQu
CgpUaGFua3MKCgo+Cj4gSSBndWVzcyB3ZSBjb3VsZCBtb3ZlIHRoZSAtIDEgdG8gdGhlIG90aGVy
IHNpZGU/Cj4KPiAJbXNnLT5pb3ZhID4gVTY0X01BWCAtIG1zZy0+c2l6ZSArIDEgfHwKPgo+IHJl
Z2FyZHMsCj4gZGFuIGNhcnBlbnRlcgo+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby9pb21tdQ==
