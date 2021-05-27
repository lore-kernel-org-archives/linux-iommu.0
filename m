Return-Path: <SRS0=nChL=KW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7D4C4708B
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 05:00:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28F686124C
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 05:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F686124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E7BC84023D;
	Thu, 27 May 2021 05:00:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2uOZQ_Gu1r-h; Thu, 27 May 2021 05:00:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id EB87740260;
	Thu, 27 May 2021 05:00:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2ECDC000E;
	Thu, 27 May 2021 05:00:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3FF1C0001
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 05:00:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D3E7240599
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 05:00:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5hsbDI2gaKsx for <iommu@lists.linux-foundation.org>;
 Thu, 27 May 2021 05:00:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7BBBD402EE
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 05:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622091619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WvNDULJK9zHRMwqe44K4RR3WKdtWUGMATeJjP7wtcZY=;
 b=AU2+5mfOda8rjlBycUP8H5Fiq0WOpjX/9SbilqkatzEYPPJ5N0cFNo43QxQfV+zJm/pq+j
 HYE+gpkV20ZAiO+sypzMoTjQXRjdxiCmibLOZ3ytDT35ajLfr4s2z0WBYV3Q8s6zB+oS+b
 KBnMnw8KWpH2uYOpNlpI6M4SY5OutN8=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-nV4AqYEYOMuzasp1ftcDgQ-1; Thu, 27 May 2021 01:00:17 -0400
X-MC-Unique: nV4AqYEYOMuzasp1ftcDgQ-1
Received: by mail-pf1-f200.google.com with SMTP id
 d17-20020aa781510000b02902e921bdea05so2099504pfn.21
 for <iommu@lists.linux-foundation.org>; Wed, 26 May 2021 22:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=WvNDULJK9zHRMwqe44K4RR3WKdtWUGMATeJjP7wtcZY=;
 b=Vpc17iP5PkbZ+Y67vYzEhDkzbWugi0ZVAzbA1QGM5MGoHy3wAYQCOy1QZtaI594qGn
 Cm8NN+FDZ1nBoukAIx1yEIawocjN31VBe+LCvk1gDxVWNxRjgtbTUvtpqYn/HSIUJ5Wb
 ukRiBXLR5lqNLSzkypVi3mgsVTozaDSoekTtP1oWLGu7DwkgZ4MFOYhGDUek9OpNa/8F
 6yw/j2m0eLNqdeqZvv4Uw+IxeZ9J0VwKDJNaKhRt0Pd/HLe1Li8ha/iVJrCQ97j7K44Q
 tPywDzEF3BCGxWXs2pNgHi8MzZ4IiwAFFHkOoPaayUG/8c9rbNxt42oRRLOIiJSf6dSW
 zWEA==
X-Gm-Message-State: AOAM5302cQtMSdoO5GO3Y/9GM7g93TbaMKWeefQCK5ooV11f8h9Ybyig
 byB1Wx5z3eFOC7gQQk6P1tITALVWEZOZoA3TC9BZdAx38laTkkAjSIcA4GXLD+1iTLY01uXmGM5
 foKb1zys3DJRJuEoA22VCcQGXJ6vD7w==
X-Received: by 2002:a17:90b:1d8f:: with SMTP id
 pf15mr1854484pjb.36.1622091616471; 
 Wed, 26 May 2021 22:00:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbQssOI3XI76V4pKYYsFesmyrvxjTc0EKTWn6Zl6xKwlpjIji0dLlRJIWAqJ1uNqyHlcKbWw==
X-Received: by 2002:a17:90b:1d8f:: with SMTP id
 pf15mr1854461pjb.36.1622091616242; 
 Wed, 26 May 2021 22:00:16 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id u5sm715334pfi.179.2021.05.26.22.00.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 May 2021 22:00:15 -0700 (PDT)
Subject: Re: [PATCH v7 11/12] vduse: Introduce VDUSE - vDPA Device in Userspace
To: Yongji Xie <xieyongji@bytedance.com>
References: <20210517095513.850-1-xieyongji@bytedance.com>
 <20210517095513.850-12-xieyongji@bytedance.com>
 <3740c7eb-e457-07f3-5048-917c8606275d@redhat.com>
 <CACycT3uAqa6azso_8MGreh+quj-JXO1piuGnrV8k2kTfc34N2g@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5a68bb7c-fd05-ce02-cd61-8a601055c604@redhat.com>
Date: Thu, 27 May 2021 13:00:07 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CACycT3uAqa6azso_8MGreh+quj-JXO1piuGnrV8k2kTfc34N2g@mail.gmail.com>
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

CuWcqCAyMDIxLzUvMjcg5LiL5Y2IMTI6NTcsIFlvbmdqaSBYaWUg5YaZ6YGTOgo+IE9uIFRodSwg
TWF5IDI3LCAyMDIxIGF0IDEyOjEzIFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+
IHdyb3RlOgo+Pgo+PiDlnKggMjAyMS81LzE3IOS4i+WNiDU6NTUsIFhpZSBZb25namkg5YaZ6YGT
Ogo+Pj4gKwo+Pj4gK3N0YXRpYyBpbnQgdmR1c2VfZGV2X21zZ19zeW5jKHN0cnVjdCB2ZHVzZV9k
ZXYgKmRldiwKPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdmR1c2VfZGV2
X21zZyAqbXNnKQo+Pj4gK3sKPj4+ICsgICAgIGluaXRfd2FpdHF1ZXVlX2hlYWQoJm1zZy0+d2Fp
dHEpOwo+Pj4gKyAgICAgc3Bpbl9sb2NrKCZkZXYtPm1zZ19sb2NrKTsKPj4+ICsgICAgIHZkdXNl
X2VucXVldWVfbXNnKCZkZXYtPnNlbmRfbGlzdCwgbXNnKTsKPj4+ICsgICAgIHdha2VfdXAoJmRl
di0+d2FpdHEpOwo+Pj4gKyAgICAgc3Bpbl91bmxvY2soJmRldi0+bXNnX2xvY2spOwo+Pj4gKyAg
ICAgd2FpdF9ldmVudF9raWxsYWJsZShtc2ctPndhaXRxLCBtc2ctPmNvbXBsZXRlZCk7Cj4+Cj4+
IFdoYXQgaGFwcGVucyBpZiB0aGUgdXNlcnNwYWNlKG1hbGljb3VzKSBkb2Vzbid0IGdpdmUgYSBy
ZXNwb25zZSBmb3JldmVyPwo+Pgo+PiBJdCBsb29rcyBsaWtlIGEgRE9TLiBJZiB5ZXMsIHdlIG5l
ZWQgdG8gY29uc2lkZXIgYSB3YXkgdG8gZml4IHRoYXQuCj4+Cj4gSG93IGFib3V0IHVzaW5nIHdh
aXRfZXZlbnRfa2lsbGFibGVfdGltZW91dCgpIGluc3RlYWQ/CgoKUHJvYmFibHksIGFuZCB0aGVu
IHdlIG5lZWQgY2hvb3NlIGEgc3VpdGFibGUgdGltZW91dCBhbmQgbW9yZSBpbXBvcnRhbnQsIApu
ZWVkIHRvIHJlcG9ydCB0aGUgZmFpbHVyZSB0byB2aXJ0aW8uCgpUaGFua3MKCgo+Cj4gVGhhbmtz
LAo+IFlvbmdqaQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
