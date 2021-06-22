Return-Path: <SRS0=IFPa=LQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F66BC49EA4
	for <iommu@archiver.kernel.org>; Tue, 22 Jun 2021 08:15:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18DE2610C7
	for <iommu@archiver.kernel.org>; Tue, 22 Jun 2021 08:15:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18DE2610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF7A74033E;
	Tue, 22 Jun 2021 08:15:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z8d1-giRgme7; Tue, 22 Jun 2021 08:15:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1B1C840322;
	Tue, 22 Jun 2021 08:15:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9E53C001A;
	Tue, 22 Jun 2021 08:15:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C577C000E
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 08:15:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0105860757
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 08:15:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9TQEE1aPt4QL for <iommu@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 08:15:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9AF8960751
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 08:15:06 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id dm5so20752082ejc.9
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 01:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=YVCp8xiBvtUwUFNttbUN5nSyQGNG3BOtMHGI4CyjTHQ=;
 b=o28htubtbLEiarTQcM4helMW63ggtrRYD6odB80RYrMKlzXBuBNkg6jqk7xSk51aaf
 O28DIRNwUv88sKL7YBwXuvCLNoIBLB+qyueDzvX1XAPAF+lP7b6r00JG0ydO3mbfBvjj
 MITBvN5IFEf9VgWqwbQ5cTBOQbN005m0gdSrZ4UFZ5PhJfMcLeyIImvlDYQppBZOLOIs
 wivfY/Yy9LtygR+8wILj+pUcRikwSCVZB5LjievWPsu4MJMdYRsp3p46J9zcNoF3btSf
 hqfnJys8BLX9k98ZfHt7+Ao5s4RN54hEJpzwW0KS+1cLQ67k5xAElsfeANuN+ySwxymS
 gCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=YVCp8xiBvtUwUFNttbUN5nSyQGNG3BOtMHGI4CyjTHQ=;
 b=cZzuITnSDkHsqX40l21eLTaHfqM2NjyUoEYwsMS2mklU1/1pNrMzfAb4P3mGzRxKmZ
 mAOwL+BI3DbRlgQtiqNziqiyrmw23nXeJCIdVAEG8FFbV60Yvd0mh24m7/avCmIop1sD
 9X+nQVuh95JuhY5vVWdLeldACBscUi8fLSS3Dd8hmUE9xAfliu44phzNQdDIu49XpR2N
 vlXHCq7+MzBywfSGwRmj9CLCjXvJqUZiTsX+0Znfwd2H4cKWRFLUqKY3dyUhgJDZadxf
 3hw7izRY3Wc/fyEgvbLTLdEj2JFYVKxO+C6jpDYyfvM+QwBMFxqHIQNGxYPHLWJxPCU7
 AqnQ==
X-Gm-Message-State: AOAM530ZztHeV9kb4O+/dh9n6AVDxGEDrK+1MABD1vvmCOyKEoZVjogn
 133HjSgCBVCqvss0UalyWLam2Rhb8gef8DEzXCcN
X-Google-Smtp-Source: ABdhPJypM7pjKQ3KkOxcIFLDNBXVrECsVU1ZZT8FKvu2e7Av799B1KikoicL0OhYmYSH0T8F/YyLCEgy2EG+tm9UOts=
X-Received: by 2002:a17:907:1b11:: with SMTP id
 mp17mr2736493ejc.1.1624349704564; 
 Tue, 22 Jun 2021 01:15:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210615141331.407-1-xieyongji@bytedance.com>
 <20210615141331.407-10-xieyongji@bytedance.com>
 <adfb2be9-9ed9-ca37-ac37-4cd00bdff349@redhat.com>
 <CACycT3tAON+-qZev+9EqyL2XbgH5HDspOqNt3ohQLQ8GqVK=EA@mail.gmail.com>
 <1bba439f-ffc8-c20e-e8a4-ac73e890c592@redhat.com>
 <CACycT3uzMJS7vw6MVMOgY4rb=SPfT2srV+8DPdwUVeELEiJgbA@mail.gmail.com>
 <0aeb7cb7-58e5-1a95-d830-68edd7e8ec2e@redhat.com>
In-Reply-To: <0aeb7cb7-58e5-1a95-d830-68edd7e8ec2e@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Tue, 22 Jun 2021 16:14:53 +0800
Message-ID: <CACycT3uuooKLNnpPHewGZ=q46Fap2P4XCFirdxxn=FxK+X1ECg@mail.gmail.com>
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

T24gVHVlLCBKdW4gMjIsIDIwMjEgYXQgMzo1MCBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPgo+Cj4g5ZyoIDIwMjEvNi8yMiDkuIvljYgzOjIyLCBZb25namkgWGll
IOWGmemBkzoKPiA+PiBXZSBuZWVkIGZpeCBhIHdheSB0byBwcm9wYWdhdGUgdGhlIGVycm9yIHRv
IHRoZSB1c2Vyc3BhY2UuCj4gPj4KPiA+PiBFLmcgaWYgd2Ugd2FudCB0byBzdG9wIHRoZSBkZWl2
Y2UsIHdlIHdpbGwgZGVsYXkgdGhlIHN0YXR1cyByZXNldCB1bnRpbAo+ID4+IHdlIGdldCByZXNw
b3NlIGZyb20gdGhlIHVzZXJzcGFjZT8KPiA+Pgo+ID4gSSBkaWRuJ3QgZ2V0IGhvdyB0byBkZWxh
eSB0aGUgc3RhdHVzIHJlc2V0LiBBbmQgc2hvdWxkIGl0IGJlIGEgRG9TCj4gPiB0aGF0IHdlIHdh
bnQgdG8gZml4IGlmIHRoZSB1c2Vyc3BhY2UgZG9lc24ndCBnaXZlIGEgcmVzcG9uc2UgZm9yZXZl
cj8KPgo+Cj4gWW91J3JlIHJpZ2h0LiBTbyBsZXQncyBtYWtlIHNldF9zdGF0dXMoKSBjYW4gZmFp
bCBmaXJzdCwgdGhlbiBwcm9wYWdhdGUKPiBpdHMgZmFpbHVyZSB2aWEgVkhPU1RfVkRQQV9TRVRf
U1RBVFVTLgo+CgpPSy4gU28gd2Ugb25seSBuZWVkIHRvIHByb3BhZ2F0ZSB0aGUgZmFpbHVyZSBp
biB0aGUgdmhvc3QtdmRwYSBjYXNlLCByaWdodD8KClRoYW5rcywKWW9uZ2ppCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdApp
b21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
