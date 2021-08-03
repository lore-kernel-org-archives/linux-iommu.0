Return-Path: <SRS0=qwh6=M2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98B6C4338F
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 08:54:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AD6161029
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 08:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5AD6161029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1F65F402AF;
	Tue,  3 Aug 2021 08:54:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zOig_FWPSnGJ; Tue,  3 Aug 2021 08:54:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DC58F4016B;
	Tue,  3 Aug 2021 08:54:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1EEAC0010;
	Tue,  3 Aug 2021 08:54:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74A6EC000E
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 08:54:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4F84C400E6
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 08:54:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vtVancQ7hgro for <iommu@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 08:54:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 58A7B4019B
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 08:54:16 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id qk33so35212388ejc.12
 for <iommu@lists.linux-foundation.org>; Tue, 03 Aug 2021 01:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=1DVuCuuKly3zqPgMlidKVCYH4f+rj2v8udMt+8e+Uk8=;
 b=MZubOip1Xuw9qiOUr/kIGiSZitdzEOs8Ev3b4lxWtajhiEQKwydeyb77dkWORzxr+5
 I0/ejnvL4DaoVnpNpUdg1oEminxd1mRaWoZRj8bwrvUHNCn0mjNO300Pi9tAwh+Oi801
 gSSS8X1xcafLCF7kbMODXynVqrHdZKumBJxcRUfwNTScuorPWQugV7ZkkalNVMCNVs2R
 9s52YDDPCYkF8dKdTOXw8NBIEQgR4nrTX0bvsfLdbJPDO/EmX1CrkNhJHbYPSRZ4cKnG
 QlBsDHrNlcwlhk46REypbTfQobXYQHhXCY2QZ9BYzxXo0InKXaCkqgEdCaV0QNqRaA/C
 kpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=1DVuCuuKly3zqPgMlidKVCYH4f+rj2v8udMt+8e+Uk8=;
 b=q/MSb4H6Pzu46KcYGyl2L28g6g9BVcBRZlKCci9hXCcHLpSIC7NdnrjwplSUYTebbT
 n+nxhf9ZYFDv2fQdFnUoDPMrpEKSHt7bZ1DflQnZolwSUb2HcPW6UUjV2BAc2Z+LE9yl
 nDyzHDF99EiP7NGOxvrWTn3rZHMrFaTne+DEyggsH/X01wZyZ3tHaUwwn/Z5WrQ5GxsV
 j6zZtJRrWKEeGezFSaTxgehnUUTSWaiIZwXygZhy3pbRcHNdFA+urtVZqlLYFWlHUbSW
 CkyBuij7VwfDEwZGjZf1OC+2z2N/1oBFo2cSx+coUEUA5TbSJiiDPgmwkwd9uN/OuVM7
 IV/w==
X-Gm-Message-State: AOAM532AnkuYjHT3Y47dXsZvf+ZPnofM94NvEBrpANi3tTurFKR/c8ER
 mNwW2ZGLgCPVAuTFYZMTyA0F8OBHIhWjKDshiyNT
X-Google-Smtp-Source: ABdhPJzB2Rc0yO2aoVU5Tdu2hZC6usoNGChwlVypWWdIUMwNhodGIYWH6xML1M1VZIQCiXVlhOS7usO1CIDwdk4oZOA=
X-Received: by 2002:a17:906:58c7:: with SMTP id
 e7mr19068058ejs.197.1627980854338; 
 Tue, 03 Aug 2021 01:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210729073503.187-1-xieyongji@bytedance.com>
 <20210729073503.187-2-xieyongji@bytedance.com>
 <43d88942-1cd3-c840-6fec-4155fd544d80@redhat.com>
In-Reply-To: <43d88942-1cd3-c840-6fec-4155fd544d80@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Tue, 3 Aug 2021 16:54:03 +0800
Message-ID: <CACycT3vcpwyA3xjD29f1hGnYALyAd=-XcWp8+wJiwSqpqUu00w@mail.gmail.com>
Subject: Re: [PATCH v10 01/17] iova: Export alloc_iova_fast() and
 free_iova_fast()
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

T24gVHVlLCBBdWcgMywgMjAyMSBhdCAzOjQxIFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhh
dC5jb20+IHdyb3RlOgo+Cj4KPiDlnKggMjAyMS83LzI5IOS4i+WNiDM6MzQsIFhpZSBZb25namkg
5YaZ6YGTOgo+ID4gRXhwb3J0IGFsbG9jX2lvdmFfZmFzdCgpIGFuZCBmcmVlX2lvdmFfZmFzdCgp
IHNvIHRoYXQKPiA+IHNvbWUgbW9kdWxlcyBjYW4gdXNlIGl0IHRvIGltcHJvdmUgaW92YSBhbGxv
Y2F0aW9uIGVmZmljaWVuY3kuCj4KPgo+IEl0J3MgYmV0dGVyIHRvIGV4cGxhaW4gd2h5IGFsbG9j
X2lvdmEoKSBpcyBub3Qgc3VmZmljaWVudCBoZXJlLgo+CgpGaW5lLgoKVGhhbmtzLApZb25namkK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFp
bGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
