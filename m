Return-Path: <SRS0=wTTv=AV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2732C433E2
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 13:27:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99D12207BB
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 13:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N80RV3Lq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D12207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6F689885E2;
	Fri, 10 Jul 2020 13:27:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HjCwcGivKWJ3; Fri, 10 Jul 2020 13:27:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CEAAD885BE;
	Fri, 10 Jul 2020 13:27:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C115BC0890;
	Fri, 10 Jul 2020 13:27:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 050F1C016F
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 13:27:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E38A020415
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 13:27:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t-LbA6Bz3jbT for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jul 2020 13:27:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by silver.osuosl.org (Postfix) with ESMTPS id DA2962045A
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 13:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594387634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8A/1vpEmoSOyHkkH6nhIq0DHvbGeWI2fZCwGb0gKD0U=;
 b=N80RV3LqN5bz2s18o0c3FN3L0JmGOPh/GZ4R8AhH+psuFLh04qlI7x8FV0J6P7dbcjuWG4
 7ikTbJPZk5SA0e2pcSSvam/QFinDDNVZ6ciAZG6MeAm4WN0sx9h/COgj5R/6e6mydYzacf
 jV2u+UCSAJM1lEg2MOiabTsfIBPfe60=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-iB5ik_0TPn-3lfedhmvmhg-1; Fri, 10 Jul 2020 09:27:10 -0400
X-MC-Unique: iB5ik_0TPn-3lfedhmvmhg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 447AB1092;
 Fri, 10 Jul 2020 13:27:08 +0000 (UTC)
Received: from carbon (unknown [10.40.208.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ACAD478A4B;
 Fri, 10 Jul 2020 13:27:00 +0000 (UTC)
Date: Fri, 10 Jul 2020 15:26:58 +0200
From: Jesper Dangaard Brouer <brouer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: generic DMA bypass flag v4
Message-ID: <20200710152658.31a9391a@carbon>
In-Reply-To: <20200708152449.316476-1-hch@lst.de>
References: <20200708152449.316476-1-hch@lst.de>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, brouer@redhat.com,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org
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

T24gV2VkLCAgOCBKdWwgMjAyMCAxNzoyNDo0NCArMDIwMApDaHJpc3RvcGggSGVsbHdpZyA8aGNo
QGxzdC5kZT4gd3JvdGU6Cgo+IE5vdGUgdGhhdCBhcy1pcyB0aGlzIGJyZWFrcyB0aGUgWFNLIGJ1
ZmZlciBwb29sLCB3aGljaCB1bmZvcnR1bmF0ZWx5Cj4gcG9rZWQgZGlyZWN0bHkgaW50byBETUEg
aW50ZXJuYWxzLiAgQSBmaXggZm9yIHRoYXQgaXMgYWxyZWFkeSBxdWV1ZWQKPiB1cCBpbiB0aGUg
bmV0ZGV2IHRyZWUuCj4gCj4gSmVzcGVyIGFuZCBYRFAgZ2FuZzogdGhpcyBzaG91bGQgbm90IHJl
Z3Jlc3MgYW55IHBlcmZvcm1hbmNlIGFzCj4gdGhlIGRtYS1kaXJlY3QgY2FsbHMgYXJlIG5vdyBp
bmxpbmVkIGludG8gdGhlIG91dCBvZiBsaW5lIERNQSBtYXBwaW5nCj4gY2FsbHMuICBCdXQgaWYg
eW91IGNhbiB2ZXJpZnkgdGhlIHBlcmZvcm1hbmNlIG51bWJlcnMgdGhhdCB3b3VsZCBiZQo+IGdy
ZWF0bHkgYXBwcmVjaWF0ZWQuCgpGcm9tIGEgc3VwZXJmaWNpYWwgcmV2aWV3IG9mIHRoZSBwYXRj
aGVzLCB0aGV5IGxvb2sgb2theSB0byBtZS4gSSBkb24ndApoYXZlIHRpbWUgdG8gcnVuIGEgcGVy
Zm9ybWFuY2UgYmVuY2htYXJrIChiZWZvcmUgSSBnbyBvbiB2YWNhdGlvbikuCgpJIGhvcGVkIEJq
w7ZybiBjb3VsZCB0ZXN0L2JlbmNobWFyayB0aGlzKD8pLCBnaXZlbiAoYXMgbWVudGlvbmVkKSB0
aGlzCmFsc28gYWZmZWN0IFhTSyAvIEFGX1hEUCBwZXJmb3JtYW5jZS4KCi0tIApCZXN0IHJlZ2Fy
ZHMsCiAgSmVzcGVyIERhbmdhYXJkIEJyb3VlcgogIE1TYy5DUywgUHJpbmNpcGFsIEtlcm5lbCBF
bmdpbmVlciBhdCBSZWQgSGF0CiAgTGlua2VkSW46IGh0dHA6Ly93d3cubGlua2VkaW4uY29tL2lu
L2Jyb3VlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
aW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
