Return-Path: <SRS0=qwh6=M2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455B9C4338F
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 09:38:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE92760F8F
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 09:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CE92760F8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9BD68600C9;
	Tue,  3 Aug 2021 09:38:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3PIYYDnJeDQn; Tue,  3 Aug 2021 09:38:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 906A56058C;
	Tue,  3 Aug 2021 09:38:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A4F1C001A;
	Tue,  3 Aug 2021 09:38:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDA7DC000E
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 09:38:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9FF318300C
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 09:38:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pFlS740FfSih for <iommu@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 09:38:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AD11C82F84
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 09:38:47 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id n2so28139736eda.10
 for <iommu@lists.linux-foundation.org>; Tue, 03 Aug 2021 02:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=QXQ5EvP/sNqFfx/lhQN+wsnZRMKa67ICv+oT5WdZOpE=;
 b=d9H53aWMga71ZSogCXHiF8qpa+uw6YSJZZLnbaXGojLmBu48pYHrN5FlH5t+zrb02N
 Y8gllvm+wxdYbG0zmDLk2trjQy8gwyDE6v4ZrLUoMhkPeGA9yPm7xn5NF+3Ek7lR4mwR
 zzIfBqdSHwydns6LOE3eadPk6Vd6b4SaOSlfoPNg7zsN657qccdvrtRHt7YGIW3Yh1YX
 XXy/mU3ExHLUoMRjlIjW22H5MtQh+mPSb9XuTXbaQNTyiC7iRMjb/ovohNYOoI4VQLFU
 878RKYupj/Diz+T3bCHHBTB7bvUpT/L8tT6CsI7OwqiPIV/dJpECcgn53okRlQaPuphy
 gA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=QXQ5EvP/sNqFfx/lhQN+wsnZRMKa67ICv+oT5WdZOpE=;
 b=dI86c2+sgMvkiQKOLH/waGVKXrQrFNkxFetZey7u2X99dzW2F+ysvnjY5uC/tdloLi
 H9tM5CxVictQHwvmijDDQWYJhaBe62MFmqk7t4Hoo7g/K5f9BwqW+qC+twSKUYDZ+F/L
 EnXMYjO9V8/DIqw1XRKZFyJtwD/Nw7uJJzsWNdRhVNoj73wZa64InDBxxrl3q6QrHBSv
 LlnZkJGts20kehZdHsJAaQdkZldUb6/EdijXK/PKP8Th1qMih3yITmuEuGLyPbbrrmL6
 AL4GL/ha+sihoJCGs0wzAMpjB3DGNgAlhaZoogvZ61caBP9mB4sbwqQpVBDKr4tlK0IN
 jD3A==
X-Gm-Message-State: AOAM530xcKJxT8xbjU6188n5hOKdrut6Jqo0ago0AggdKeLlrn0bvOC5
 h01RTueuHdM3kpRLKUg4EjeJlsJSsrI3bbsmiDPL
X-Google-Smtp-Source: ABdhPJzvDCZ7IM+d+eleUGoW8vFLGyxK6YWGr3cxlRwj4gkELxKZ80TChkbewe/R9lGSWrWBD7cinTUwyX8EuEgFvLI=
X-Received: by 2002:a05:6402:1d0d:: with SMTP id
 dg13mr24634764edb.312.1627983525876; 
 Tue, 03 Aug 2021 02:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210729073503.187-1-xieyongji@bytedance.com>
 <20210729073503.187-11-xieyongji@bytedance.com>
 <6bb6c689-e6dd-cfa2-094b-a0ca4258aded@redhat.com>
In-Reply-To: <6bb6c689-e6dd-cfa2-094b-a0ca4258aded@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Tue, 3 Aug 2021 17:38:34 +0800
Message-ID: <CACycT3v7BHxYY0OFYJRFU41Bz1=_v8iMRwzYKgX6cJM-SiNH+A@mail.gmail.com>
Subject: Re: [PATCH v10 10/17] virtio: Handle device reset failure in
 register_virtio_device()
To: Jason Wang <jasowang@redhat.com>
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

T24gVHVlLCBBdWcgMywgMjAyMSBhdCA0OjA5IFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhh
dC5jb20+IHdyb3RlOgo+Cj4KPiDlnKggMjAyMS83LzI5IOS4i+WNiDM6MzQsIFhpZSBZb25namkg
5YaZ6YGTOgo+ID4gVGhlIGRldmljZSByZXNldCBtYXkgZmFpbCBpbiB2aXJ0aW8tdmRwYSBjYXNl
IG5vdywgc28gYWRkIGNoZWNrcyB0bwo+ID4gaXRzIHJldHVybiB2YWx1ZSBhbmQgZmFpbCB0aGUg
cmVnaXN0ZXJfdmlydGlvX2RldmljZSgpLgo+Cj4KPiBTbyB0aGUgcmVzZXQoKSB3b3VsZCBiZSBj
YWxsZWQgYnkgdGhlIGRyaXZlciBkdXJpbmcgcmVtb3ZlIGFzIHdlbGwsIG9yCj4gaXMgaXQgc3Vm
ZmljaWVudCB0byBkZWFsIG9ubHkgd2l0aCB0aGUgcmVzZXQgZHVyaW5nIHByb2JlPwo+CgpBY3R1
YWxseSB0aGVyZSBpcyBubyB3YXkgdG8gaGFuZGxlIGZhaWx1cmUgZHVyaW5nIHJlbW92YWwuIEFu
ZCBpdApzaG91bGQgYmUgc2FmZSB3aXRoIHRoZSBwcm90ZWN0aW9uIG9mIHNvZnR3YXJlIElPVExC
IGV2ZW4gaWYgdGhlCnJlc2V0KCkgZmFpbHMuCgpUaGFua3MsCllvbmdqaQpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9t
bXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
