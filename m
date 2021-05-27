Return-Path: <SRS0=nChL=KW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7244C4708B
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 04:57:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47A7D61186
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 04:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47A7D61186
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0B00A402CC;
	Thu, 27 May 2021 04:57:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lvv_xXQYFmq6; Thu, 27 May 2021 04:57:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id F3A38403A0;
	Thu, 27 May 2021 04:57:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BEEE3C000E;
	Thu, 27 May 2021 04:57:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2922EC0001
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 04:57:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1CA744023D
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 04:57:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v9XoIjsQrU23 for <iommu@lists.linux-foundation.org>;
 Thu, 27 May 2021 04:57:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F1F6C40249
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 04:57:20 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id h16so4180530edr.6
 for <iommu@lists.linux-foundation.org>; Wed, 26 May 2021 21:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=YJ0dWA2LN7YqfF1ySTSNQvt81ovDnTZhfscP6j/isLs=;
 b=gKB8fvK0cCWN4lEkm4wDH6rz4Sa0FsxRwsg5F16JeFZeSk5+GIGcIQz76DqI7jCKna
 1n5SBDwT2tPkv3xz9FZpqyHuntur92hGyhaJqhPLvrxOpxjMAwWwnzEI+ond1RyDNj2M
 hSKTWiLfyXawwcHjtm/qvhYeQS3O4ky+w5QeGyceqwSLyP/TheaH2Ne18IVUbd8qIt3/
 KCdb3Z51nRn7l+3Pmv10fGurtavWFZ1jh73TQbyQtJqZwO5c78iH8kmQAAcbOJ6mGvgX
 3uDqtsAOrG8BYjKnqsMxPZMs+PQNCK4Ce6nPSunMJjOob1tFMqZxwaa9xuHBoDSMyEVR
 hSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=YJ0dWA2LN7YqfF1ySTSNQvt81ovDnTZhfscP6j/isLs=;
 b=DLHIk+mbE+9X8R1mzQWcWtn2Okkh7VRuRaF+3BzxL01zKc+r/z8KUOngAVnuF1UJyy
 zhQ10l2JfRDJVDMOecwSaFIum/09iPFpC3X/wLJeECV1Bgar2hoy1CllvHUQIkhIsgbu
 sKNgpm30qeJMuxrXq/y6WHTQmsqjQbuRcQoKuFgsgb3nyCLE7JBthj6Ky3x30daCiEBl
 ULN/HpvlBWO9vMi+bf9xWTEyJkajkGFjL62jgN5oRt50qaW1oRATMkEpYx8c1qWqdug2
 QmB7gcUAvHVfdpw3AS0CHjlkupVhhU20zfbOmroR9wujLnaSNMZHz17I6+lpgBuaXwRj
 f4wQ==
X-Gm-Message-State: AOAM532m4BL6+7lHlJjYCEX5p327hsbJJiRdTlhtHRSxQmt3D2WE3OTI
 Ao9yRrio0xg54Azu1lu+uCszDQ+D6sfwogf3B0sl
X-Google-Smtp-Source: ABdhPJz7HIu5MQLRpH/FbPdTqRTue+3JMybVC+vY85i/I/de3bl/zvWYSVdjNKEUlXy6fDXCcVP8dUSaDhAFYIw47Ng=
X-Received: by 2002:a05:6402:4252:: with SMTP id
 g18mr1953908edb.195.1622091439123; 
 Wed, 26 May 2021 21:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210517095513.850-1-xieyongji@bytedance.com>
 <20210517095513.850-12-xieyongji@bytedance.com>
 <3740c7eb-e457-07f3-5048-917c8606275d@redhat.com>
In-Reply-To: <3740c7eb-e457-07f3-5048-917c8606275d@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Thu, 27 May 2021 12:57:08 +0800
Message-ID: <CACycT3uAqa6azso_8MGreh+quj-JXO1piuGnrV8k2kTfc34N2g@mail.gmail.com>
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

T24gVGh1LCBNYXkgMjcsIDIwMjEgYXQgMTI6MTMgUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4KPgo+IOWcqCAyMDIxLzUvMTcg5LiL5Y2INTo1NSwgWGllIFlvbmdq
aSDlhpnpgZM6Cj4gPiArCj4gPiArc3RhdGljIGludCB2ZHVzZV9kZXZfbXNnX3N5bmMoc3RydWN0
IHZkdXNlX2RldiAqZGV2LAo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2
ZHVzZV9kZXZfbXNnICptc2cpCj4gPiArewo+ID4gKyAgICAgaW5pdF93YWl0cXVldWVfaGVhZCgm
bXNnLT53YWl0cSk7Cj4gPiArICAgICBzcGluX2xvY2soJmRldi0+bXNnX2xvY2spOwo+ID4gKyAg
ICAgdmR1c2VfZW5xdWV1ZV9tc2coJmRldi0+c2VuZF9saXN0LCBtc2cpOwo+ID4gKyAgICAgd2Fr
ZV91cCgmZGV2LT53YWl0cSk7Cj4gPiArICAgICBzcGluX3VubG9jaygmZGV2LT5tc2dfbG9jayk7
Cj4gPiArICAgICB3YWl0X2V2ZW50X2tpbGxhYmxlKG1zZy0+d2FpdHEsIG1zZy0+Y29tcGxldGVk
KTsKPgo+Cj4gV2hhdCBoYXBwZW5zIGlmIHRoZSB1c2Vyc3BhY2UobWFsaWNvdXMpIGRvZXNuJ3Qg
Z2l2ZSBhIHJlc3BvbnNlIGZvcmV2ZXI/Cj4KPiBJdCBsb29rcyBsaWtlIGEgRE9TLiBJZiB5ZXMs
IHdlIG5lZWQgdG8gY29uc2lkZXIgYSB3YXkgdG8gZml4IHRoYXQuCj4KCkhvdyBhYm91dCB1c2lu
ZyB3YWl0X2V2ZW50X2tpbGxhYmxlX3RpbWVvdXQoKSBpbnN0ZWFkPwoKVGhhbmtzLApZb25namkK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFp
bGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
