Return-Path: <SRS0=XPcP=LW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60873C49EA3
	for <iommu@archiver.kernel.org>; Mon, 28 Jun 2021 13:24:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 211FB61C6C
	for <iommu@archiver.kernel.org>; Mon, 28 Jun 2021 13:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 211FB61C6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F18BD82F9B;
	Mon, 28 Jun 2021 13:24:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IQ8F1ZVLNSLb; Mon, 28 Jun 2021 13:24:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 02169831E3;
	Mon, 28 Jun 2021 13:24:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E084C0022;
	Mon, 28 Jun 2021 13:24:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E101C000E
 for <iommu@lists.linux-foundation.org>; Mon, 28 Jun 2021 13:02:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5A63D401F0
 for <iommu@lists.linux-foundation.org>; Mon, 28 Jun 2021 13:02:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AbZfde_Avgiz for <iommu@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 13:02:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B1D8C4019A
 for <iommu@lists.linux-foundation.org>; Mon, 28 Jun 2021 13:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624885354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fndY61EcgfzsXcmaCK7BMnLfNMbphujT+QMr+Pswt68=;
 b=PGfmTACvAqpUJzwPjJ5xCRO9N3+up85oL8AVWjBsFYsbkaG0rXjH3Fxumk5HSF2FuxPtl5
 YMW1Ah4dD5pKCIUOOCu/rYnE/v7OvKkULjsoOBCiVFgrrRHGP/csbA5REN7lmaNHjX08y7
 CI24pan6AQxIIpG8WllqSTz7KeyXw3E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-lJbSiAWjOGCgZVrmUVHPPA-1; Mon, 28 Jun 2021 09:02:28 -0400
X-MC-Unique: lJbSiAWjOGCgZVrmUVHPPA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88C80800C78;
 Mon, 28 Jun 2021 13:02:25 +0000 (UTC)
Received: from localhost (ovpn-112-170.ams2.redhat.com [10.36.112.170])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7AFA969CB6;
 Mon, 28 Jun 2021 13:02:03 +0000 (UTC)
Date: Thu, 24 Jun 2021 16:12:09 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH v8 00/10] Introduce VDUSE - vDPA Device in Userspace
Message-ID: <YNSgyTHpNjxdKLLR@stefanha-x1.localdomain>
References: <20210615141331.407-1-xieyongji@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20210615141331.407-1-xieyongji@bytedance.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mailman-Approved-At: Mon, 28 Jun 2021 13:24:05 +0000
Cc: kvm@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org, christian.brauner@canonical.com,
 corbet@lwn.net, willy@infradead.org, hch@infradead.org,
 dan.carpenter@oracle.com, sgarzare@redhat.com, viro@zeniv.linux.org.uk,
 songmuchun@bytedance.com, axboe@kernel.dk, gregkh@linuxfoundation.org,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, bcrl@kvack.org, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, mika.penttila@nextfour.com
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
Content-Type: multipart/mixed; boundary="===============0440501645321586255=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============0440501645321586255==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Bv+EGssEb3iM6ws2"
Content-Disposition: inline


--Bv+EGssEb3iM6ws2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 15, 2021 at 10:13:21PM +0800, Xie Yongji wrote:
> This series introduces a framework that makes it possible to implement
> software-emulated vDPA devices in userspace. And to make it simple, the
> emulated vDPA device's control path is handled in the kernel and only the
> data path is implemented in the userspace.

This looks interesting. Unfortunately I don't have enough time to do a
full review, but I looked at the documentation and uapi header file to
give feedback on the userspace ABI.

Stefan

--Bv+EGssEb3iM6ws2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmDUoMkACgkQnKSrs4Gr
c8i9mAf/TQBs0m0AVmZZD8+mPJMwfeWR4pxCS+XbMMUr1xqCc7eSxhjMY6H1LNO6
3r+wPajMdIuXEW16AsGRAplQmvTNAdUMjcDnSeS/Y1LBecoKKAnKOYuvRZ1HCaqk
Ye3vT+jpDz+X/+miO5LiIenkJB9bouoqAxeNXIXQL5jOMw+pW7R2CD3YUK0k4AMn
+X179rAMEOsPG+jyOlWDU1MDbdy1vZEIRQ7MoqrMqsHq/O+AnBXFyZISDwrUttZw
HoXWFEeLdyh0mKaniHbsEvSQaAXrG+UBg5xqpYw9RNmbJ7ax+qQ4sUZHbkZlsXXe
p++cvUCG1Xk7kOv1o28B3KBn/lyQQA==
=Kg3j
-----END PGP SIGNATURE-----

--Bv+EGssEb3iM6ws2--


--===============0440501645321586255==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0440501645321586255==--

