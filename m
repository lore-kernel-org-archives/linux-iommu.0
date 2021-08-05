Return-Path: <SRS0=+AsR=M4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9CDC43214
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 13:32:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E71F66115C
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 13:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E71F66115C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A41D883412;
	Thu,  5 Aug 2021 13:32:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yjomyfxis8Xt; Thu,  5 Aug 2021 13:31:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9494383417;
	Thu,  5 Aug 2021 13:31:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65596C001A;
	Thu,  5 Aug 2021 13:31:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74336C000E
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 13:31:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 61A2040357
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 13:31:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o-YYLPd0sM4o for <iommu@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 13:31:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 612C040424
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 13:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628170315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KFeFt1ww8WzoDvTA8B4ID/THa1sBrEwi6JiSRoox5oM=;
 b=UYNe/jicwMop7jWFr8j3AEnGB1jlLJmLNLel8lHczjZGBudnlDBRcMMaLJ5BdrSYphVBad
 coEPIY1VjClyve620cm55Ufb5xdLNlqrK3uimJA1tPcXt9DoXYFPuvbWJXNB5SRnvj6W0H
 AWFnokaf0gfNVaPDr8W0y3cNWuIuvvA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-lOtLiE0mPNGA60cLMyYYPQ-1; Thu, 05 Aug 2021 09:31:53 -0400
X-MC-Unique: lOtLiE0mPNGA60cLMyYYPQ-1
Received: by mail-pj1-f70.google.com with SMTP id
 g12-20020a17090ace8cb029017797b2c0f8so3896175pju.4
 for <iommu@lists.linux-foundation.org>; Thu, 05 Aug 2021 06:31:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=KFeFt1ww8WzoDvTA8B4ID/THa1sBrEwi6JiSRoox5oM=;
 b=Nj0eNr95ll4cO/4XWEo5nJB90H6vMVxNycM/rB2NLfJId9T7/yzaMzk3iMlG3b+BhG
 5jEAX3KZO9EnqfWYueyyKVF3zzdMSLzn5rjJ0XuBcBldt6goGSK49bKPbBd9PnR1Iwbe
 X2CM1h02pZRBvsgQhGE6Dd+m5mfhLSVrBL6uGM5dna+B/vXjMwrqaLgNLkpGglCP0jJV
 s6eIJLwmX2xO/EuIuUcHXKmLiWzul7MLL2UEbG7gUFDgQlgV/wNu8jzENHH4E0tHEkBp
 g5W7q+4U54Fpx8GQrvBxQhs9I3PvZBeUFs3ZD0HCmk33Y/JjovSBig4tF6Cym6L6Ea6I
 Lhug==
X-Gm-Message-State: AOAM531ieZRqPAxYNGY++Lr08X9rmiLXFMFqCaheG/iwgpMZlWIL3co+
 r9N6q4BaK5zDxHR/+vxh62CC6wrPtKk1JHNN/Q5ytVT7er5v6N/0024OE8Ql0TC0bxiIhEaxIOf
 FRH2qFmy1Ek3JvsOve7u+7MWoKWBYYg==
X-Received: by 2002:a65:610c:: with SMTP id z12mr612906pgu.453.1628170312973; 
 Thu, 05 Aug 2021 06:31:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJweBq6SSyDD2nP+XrrpaLsd2Knf9rcBqrsnAXcXPB8geZ/AllW4llVpLKWNfVfqwtMjCV4ZTA==
X-Received: by 2002:a65:610c:: with SMTP id z12mr612875pgu.453.1628170312586; 
 Thu, 05 Aug 2021 06:31:52 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id y67sm6867035pfg.218.2021.08.05.06.31.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Aug 2021 06:31:52 -0700 (PDT)
Subject: Re: [PATCH v10 01/17] iova: Export alloc_iova_fast() and
 free_iova_fast()
To: Yongji Xie <xieyongji@bytedance.com>, Robin Murphy <robin.murphy@arm.com>
References: <20210729073503.187-1-xieyongji@bytedance.com>
 <20210729073503.187-2-xieyongji@bytedance.com>
 <43d88942-1cd3-c840-6fec-4155fd544d80@redhat.com>
 <CACycT3vcpwyA3xjD29f1hGnYALyAd=-XcWp8+wJiwSqpqUu00w@mail.gmail.com>
 <6e05e25e-e569-402e-d81b-8ac2cff1c0e8@arm.com>
 <CACycT3sm2r8NMMUPy1k1PuSZZ3nM9aic-O4AhdmRRCwgmwGj4Q@mail.gmail.com>
 <417ce5af-4deb-5319-78ce-b74fb4dd0582@arm.com>
 <CACycT3vARzvd4-dkZhDHqUkeYoSxTa2ty0z0ivE1znGti+n1-g@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8c381d3d-9bbd-73d6-9733-0f0b15c40820@redhat.com>
Date: Thu, 5 Aug 2021 21:31:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CACycT3vARzvd4-dkZhDHqUkeYoSxTa2ty0z0ivE1znGti+n1-g@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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
 =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
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

CuWcqCAyMDIxLzgvNSDkuIvljYg4OjM0LCBZb25namkgWGllIOWGmemBkzoKPj4gTXkgbWFpbiBw
b2ludCwgdGhvdWdoLCBpcyB0aGF0IGlmIHlvdSd2ZSBhbHJlYWR5IGdvdCBzb21ldGhpbmcgZWxz
ZQo+PiBrZWVwaW5nIHRyYWNrIG9mIHRoZSBhY3R1YWwgYWRkcmVzc2VzLCB0aGVuIHRoZSB3YXkg
eW91J3JlIHVzaW5nIGFuCj4+IGlvdmFfZG9tYWluIGFwcGVhcnMgdG8gYmUgc29tZXRoaW5nIHlv
dSBjb3VsZCBkbyB3aXRoIGEgdHJpdmlhbCBiaXRtYXAKPj4gYWxsb2NhdG9yLiBUaGF0J3Mgd2h5
IEkgZG9uJ3QgYnV5IHRoZSBlZmZpY2llbmN5IGFyZ3VtZW50LiBUaGUgbWFpbgo+PiBkZXNpZ24g
cG9pbnRzIG9mIHRoZSBJT1ZBIGFsbG9jYXRvciBhcmUgdG8gbWFuYWdlIGxhcmdlIGFkZHJlc3Mg
c3BhY2VzCj4+IHdoaWxlIHRyeWluZyB0byBtYXhpbWlzZSBzcGF0aWFsIGxvY2FsaXR5IHRvIG1p
bmltaXNlIHRoZSB1bmRlcmx5aW5nCj4+IHBhZ2V0YWJsZSB1c2FnZSwgYW5kIGFsbG9jYXRpbmcg
d2l0aCBhIGZsZXhpYmxlIGxpbWl0IHRvIHN1cHBvcnQKPj4gbXVsdGlwbGUgZGV2aWNlcyB3aXRo
IGRpZmZlcmVudCBhZGRyZXNzaW5nIGNhcGFiaWxpdGllcyBpbiB0aGUgc2FtZQo+PiBhZGRyZXNz
IHNwYWNlLiBJZiBub25lIG9mIHRob3NlIGFzcGVjdHMgYXJlIHJlbGV2YW50IHRvIHRoZSB1c2Ut
Y2FzZSAtCj4+IHdoaWNoIEFGQUlDUyBhcHBlYXJzIHRvIGJlIHRydWUgaGVyZSAtIHRoZW4gYXMg
YSBnZW5lcmFsLXB1cnBvc2UKPj4gcmVzb3VyY2UgYWxsb2NhdG9yIGl0J3MgcnViYmlzaCBhbmQg
aGFzIGFuIHVucmVhc29uYWJseSBtYXNzaXZlIG1lbW9yeQo+PiBvdmVyaGVhZCBhbmQgdGhlcmUg
YXJlIG1hbnksIG1hbnkgYmV0dGVyIGNob2ljZXMuCj4+Cj4gT0ssIEkgZ2V0IHlvdXIgcG9pbnQu
IEFjdHVhbGx5IHdlIHVzZWQgdGhlIGdlbnBvb2wgYWxsb2NhdG9yIGluIHRoZQo+IGVhcmx5IHZl
cnNpb24uIE1heWJlIHdlIGNhbiBmYWxsIGJhY2sgdG8gdXNpbmcgaXQuCgoKSSB0aGluayBtYXli
ZSB5b3UgY2FuIHNoYXJlIHNvbWUgcGVyZiBudW1iZXJzIHRvIHNlZSBob3cgbXVjaCAKYWxsb2Nf
aW92YV9mYXN0KCkgY2FuIGhlbHAuCgpUaGFua3MKCgo+CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vaW9tbXU=
