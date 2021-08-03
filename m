Return-Path: <SRS0=qwh6=M2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EB2C432BE
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 09:13:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E114660F0F
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 09:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E114660F0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A24CB40435;
	Tue,  3 Aug 2021 09:13:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OAsjbAMfruXo; Tue,  3 Aug 2021 09:13:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8CCC640439;
	Tue,  3 Aug 2021 09:13:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4EA4FC001B;
	Tue,  3 Aug 2021 09:13:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04911C000E
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 09:13:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B58B34043B
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 09:13:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id khs8fL2wEnSV for <iommu@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 09:13:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5800140439
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 09:13:45 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id y7so25863544eda.5
 for <iommu@lists.linux-foundation.org>; Tue, 03 Aug 2021 02:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=TzdywkyaGO6eDzvYKvoBys7MoF5h7biikR9uQQ2v4KY=;
 b=DEM52txH8kmvAxsC/lp3YibL085f86KNaEqwdtqjBneskd0IwK0e82rXwYB9c8t9Tr
 ww3wmXWrMP+YvxKKT1uoX0D7YO1isLAI7ThWYluU0YqLEZfwyV3Now5FHhcsj9Cr4md2
 DZbBBbTbmK4BxlAzhBhpLgE8bQmmioK+cAe9+tZXxl+zmcGsylSDUZow3cip4f0fIcZu
 MERRn3uePPig17zL37ynIRKvdD/aR+949V8EqcMSPuQnAxFERSIirzW9KgUlD1mKDCqP
 30ZZw62oN0JD1lDOJ7F2XvxmIbwFaTw/pPYHnAPUzntV50gGc5kMQcteBHILZ55utDRZ
 Y5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=TzdywkyaGO6eDzvYKvoBys7MoF5h7biikR9uQQ2v4KY=;
 b=cKyyVePGN8YgAMAEsNknvUzuXQ/4gcZ6QnW1dHPRMfi3wj50P7HaN/sS5wdmrscovR
 kduu+ceTvQ/aVjx2nCRRPkhbfpJahvyrRpc1SPtKYrPafL/glRRjs34/gTq/o119auV1
 RJVK920xDhljUlDXXaMTxCWyi1D5iqgMHEj8cewi96CzUrPtPi8r9UU7DT6d6kzzeBIu
 F36OgYNVs64yLy93nGfPP9MZCNgGugHPxpdAJAa5z+HUVUh0cFbaGQUUkcBznidp0hND
 +ohruK5t8eZJuNNBg76AXsixg0tohwHNR9ARB1IQ54w9xT9Pio+Si62l+6dXffiomJ/a
 iXkA==
X-Gm-Message-State: AOAM532S3Hh5erGXzQnBN5/hiyVffQo8JijSaQIoy96EJrKsMkpH7dwy
 NUpT4zYiXAdgH9yMFJX0dKm28s/1fX2Sz+Lo+MCV
X-Google-Smtp-Source: ABdhPJzTcfFrmUvQ6VoEyuq0IwD//odDZyHHo9um9hSrSwgnp0TxB8fuvj0AdwM4682E0gxOiogSbfaYRhrBcwi+Smg=
X-Received: by 2002:a50:fb05:: with SMTP id d5mr23600055edq.5.1627982023010;
 Tue, 03 Aug 2021 02:13:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210729073503.187-1-xieyongji@bytedance.com>
 <20210729073503.187-4-xieyongji@bytedance.com>
 <aaf82d3f-05e3-13d5-3a63-52cd8045b4c6@redhat.com>
In-Reply-To: <aaf82d3f-05e3-13d5-3a63-52cd8045b4c6@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Tue, 3 Aug 2021 17:13:32 +0800
Message-ID: <CACycT3upc6-Sfo-68vg7aFR1zd8=ovg_-rR4UQaqgcVTG62USw@mail.gmail.com>
Subject: Re: [PATCH v10 03/17] vdpa: Fix code indentation
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

T24gVHVlLCBBdWcgMywgMjAyMSBhdCAzOjUxIFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhh
dC5jb20+IHdyb3RlOgo+Cj4KPiDlnKggMjAyMS83LzI5IOS4i+WNiDM6MzQsIFhpZSBZb25namkg
5YaZ6YGTOgo+ID4gVXNlIHRhYnMgdG8gaW5kZW50IHRoZSBjb2RlIGluc3RlYWQgb2Ygc3BhY2Vz
Lgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IFhpZSBZb25namkgPHhpZXlvbmdqaUBieXRlZGFuY2Uu
Y29tPgo+ID4gLS0tCj4gPiAgIGluY2x1ZGUvbGludXgvdmRwYS5oIHwgMjkgKysrKysrKysrKysr
KystLS0tLS0tLS0tLS0tLS0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyks
IDE1IGRlbGV0aW9ucygtKQo+Cj4KPiBJdCBsb29rcyB0byBtZSBub3QgYWxsIHRoZSB3YXJuaW5n
cyBhcmUgYWRkcmVzc2VkLgo+Cj4gT3IgZGlkIHlvdSBzaWxlbnQgY2hlY2twYXRjaC5wbCAtZj8K
PgoKVGhpcyBwYXRjaCBvbmx5IGZpeGVzIHRoZSBjb2RlIGluZGVudCBpc3N1ZS4gSSB3aWxsIGFk
ZHJlc3MgYWxsCndhcm5pbmdzIGluIHRoZSBuZXh0IHZlcnNpb24uCgpUaGFua3MsCllvbmdqaQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWls
aW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
