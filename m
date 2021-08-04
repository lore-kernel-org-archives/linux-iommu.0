Return-Path: <SRS0=FZ/Z=M3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE46FC432BE
	for <iommu@archiver.kernel.org>; Wed,  4 Aug 2021 08:33:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77B4B60F43
	for <iommu@archiver.kernel.org>; Wed,  4 Aug 2021 08:33:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 77B4B60F43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 35E7340238;
	Wed,  4 Aug 2021 08:33:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 63J_BGBztKfR; Wed,  4 Aug 2021 08:33:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A5CBE400FD;
	Wed,  4 Aug 2021 08:33:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62584C001A;
	Wed,  4 Aug 2021 08:33:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41776C000E
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 08:32:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 218EA606F6
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 08:32:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BhxrRRhvemYH for <iommu@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 08:32:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 59B9F6067E
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 08:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628065977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Mht9KhrSAoC5vXTThxE4PNfv46coChGKCgMCqOMEH8=;
 b=Ab6vzhVNwnp7pZQedfUxDvQXXEM4Azw9lKGQQUDQfDZu0TmNaFqhlNUKBdCDoCmj71rSLS
 7LfOL7lWc+vQ6H2W92wCG+gD9VeTg1mgebtqlTWdVB0hM69GByqoNFkG55JGUH4I3hFj/6
 Nba4XkSXeuC3LNLg+yXRngb2D+c9Nqc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-5AjadWhlO9u_uYQO2SMQ2g-1; Wed, 04 Aug 2021 04:32:54 -0400
X-MC-Unique: 5AjadWhlO9u_uYQO2SMQ2g-1
Received: by mail-pj1-f70.google.com with SMTP id
 az9-20020a17090b0289b0290176a0987ce6so1888112pjb.0
 for <iommu@lists.linux-foundation.org>; Wed, 04 Aug 2021 01:32:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=8Mht9KhrSAoC5vXTThxE4PNfv46coChGKCgMCqOMEH8=;
 b=Nvsq++qj5PqBhGiRwt/MLx+24j7sp0v0dy9ToavsTdWnRynyLZrQCDIVtRgHY108wl
 HJB7iSAxnTdKrnJfB+BG2N8yMdO991sNfTsNOGUe2XT0nDjE2LvRUFizHs+L7aUdtGP9
 Gf8FpCdEzf4rlGp6/UfBOoCbemqEUY9N02rzpuNqPGNGV2/G4BUnP8idW2HaKOoXXVgU
 18hYjeo+b0oLvm86XpHBEHxFxFiNx3QpeR5qg14b6sIB0Xx7exFbpalMIHS/dqZzuvAt
 e4oWu4ek0695a0ZA1pQlbkcPRPlmUyGXotxG9zcwfrUnDZ0smd0I5FWdqIoV/Bo0CWPz
 xZaA==
X-Gm-Message-State: AOAM532yPyRJnn2tbn/jAAZXsoTOiCni4F+R61eO6qKH+R/P1Ud9Scjc
 c0bLDRNeKIQOrFd154YcqZ+IFMiqymgzikPIY/l8ZBGTEAnUI1NnxqjaqYwFYwBfDvWDaif550a
 HhQlpc2LlXuvPJ56GBsNE7UscRhzD1Q==
X-Received: by 2002:a17:903:2448:b029:12c:cbce:8f86 with SMTP id
 l8-20020a1709032448b029012ccbce8f86mr5117582pls.72.1628065973043; 
 Wed, 04 Aug 2021 01:32:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0IqxY2soH2Uz1iq8mrB6lhygXB67xl2gJSTSu+DC+/FQJJ+3UJPurBSvXJuePHIlHPLAFsQ==
X-Received: by 2002:a17:903:2448:b029:12c:cbce:8f86 with SMTP id
 l8-20020a1709032448b029012ccbce8f86mr5117546pls.72.1628065972803; 
 Wed, 04 Aug 2021 01:32:52 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id d65sm1065176pjk.45.2021.08.04.01.32.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Aug 2021 01:32:52 -0700 (PDT)
Subject: Re: [PATCH v10 10/17] virtio: Handle device reset failure in
 register_virtio_device()
To: Yongji Xie <xieyongji@bytedance.com>
References: <20210729073503.187-1-xieyongji@bytedance.com>
 <20210729073503.187-11-xieyongji@bytedance.com>
 <6bb6c689-e6dd-cfa2-094b-a0ca4258aded@redhat.com>
 <CACycT3v7BHxYY0OFYJRFU41Bz1=_v8iMRwzYKgX6cJM-SiNH+A@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <fdcb0224-11f9-caf2-a44e-e6406087fd50@redhat.com>
Date: Wed, 4 Aug 2021 16:32:39 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CACycT3v7BHxYY0OFYJRFU41Bz1=_v8iMRwzYKgX6cJM-SiNH+A@mail.gmail.com>
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

CuWcqCAyMDIxLzgvMyDkuIvljYg1OjM4LCBZb25namkgWGllIOWGmemBkzoKPiBPbiBUdWUsIEF1
ZyAzLCAyMDIxIGF0IDQ6MDkgUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3Jv
dGU6Cj4+Cj4+IOWcqCAyMDIxLzcvMjkg5LiL5Y2IMzozNCwgWGllIFlvbmdqaSDlhpnpgZM6Cj4+
PiBUaGUgZGV2aWNlIHJlc2V0IG1heSBmYWlsIGluIHZpcnRpby12ZHBhIGNhc2Ugbm93LCBzbyBh
ZGQgY2hlY2tzIHRvCj4+PiBpdHMgcmV0dXJuIHZhbHVlIGFuZCBmYWlsIHRoZSByZWdpc3Rlcl92
aXJ0aW9fZGV2aWNlKCkuCj4+Cj4+IFNvIHRoZSByZXNldCgpIHdvdWxkIGJlIGNhbGxlZCBieSB0
aGUgZHJpdmVyIGR1cmluZyByZW1vdmUgYXMgd2VsbCwgb3IKPj4gaXMgaXQgc3VmZmljaWVudCB0
byBkZWFsIG9ubHkgd2l0aCB0aGUgcmVzZXQgZHVyaW5nIHByb2JlPwo+Pgo+IEFjdHVhbGx5IHRo
ZXJlIGlzIG5vIHdheSB0byBoYW5kbGUgZmFpbHVyZSBkdXJpbmcgcmVtb3ZhbC4gQW5kIGl0Cj4g
c2hvdWxkIGJlIHNhZmUgd2l0aCB0aGUgcHJvdGVjdGlvbiBvZiBzb2Z0d2FyZSBJT1RMQiBldmVu
IGlmIHRoZQo+IHJlc2V0KCkgZmFpbHMuCj4KPiBUaGFua3MsCj4gWW9uZ2ppCgoKSWYgdGhpcyBp
cyB0cnVlLCBkb2VzIGl0IG1lYW4gd2UgZG9uJ3QgZXZlbiBuZWVkIHRvIGNhcmUgYWJvdXQgcmVz
ZXQgCmZhaWx1cmU/CgpUaGFua3MKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vaW9tbXU=
