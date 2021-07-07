Return-Path: <SRS0=iPMr=L7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9EBC07E95
	for <iommu@archiver.kernel.org>; Wed,  7 Jul 2021 08:53:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C6D61C93
	for <iommu@archiver.kernel.org>; Wed,  7 Jul 2021 08:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C6D61C93
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9AA0740215;
	Wed,  7 Jul 2021 08:53:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lki80t8oYUrd; Wed,  7 Jul 2021 08:53:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 86B9B400F4;
	Wed,  7 Jul 2021 08:53:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5FBD0C001A;
	Wed,  7 Jul 2021 08:53:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69E4DC001D
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 08:53:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5770740357
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 08:53:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QwLe8aLW0ZPa for <iommu@lists.linux-foundation.org>;
 Wed,  7 Jul 2021 08:53:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8BF6B4052F
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 08:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625647986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RSGta0qNpB6QcJ/llRMjKtAhvAPIvAnC+iGh3rJx/qg=;
 b=NT1EE/LRRu7LXIYR87bjnsG/ltfCrDLnwLJJJWcK2eL9U53uJa26agf9QwDD8WJaHqdlUf
 45HyAoYBOJOvBgPskP2uxx9TxJ+UeZkMVDlBwOCL/7PjdMiqq+HWg3AENxQVG0ThKUq2l9
 3cYdiu4T5F+sBe/ANhQg8GS72z39tbc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-v1nUrO-5Ov24IW-5AspE9w-1; Wed, 07 Jul 2021 04:53:03 -0400
X-MC-Unique: v1nUrO-5Ov24IW-5AspE9w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4831F1800D41;
 Wed,  7 Jul 2021 08:53:00 +0000 (UTC)
Received: from localhost (ovpn-114-152.ams2.redhat.com [10.36.114.152])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A3E7719C44;
 Wed,  7 Jul 2021 08:52:55 +0000 (UTC)
Date: Wed, 7 Jul 2021 09:52:54 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH v8 09/10] vduse: Introduce VDUSE - vDPA Device in Userspace
Message-ID: <YOVrZtGIEjZZSSoU@stefanha-x1.localdomain>
References: <20210615141331.407-1-xieyongji@bytedance.com>
 <20210615141331.407-10-xieyongji@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20210615141331.407-10-xieyongji@bytedance.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
Content-Type: multipart/mixed; boundary="===============1263127556867454793=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============1263127556867454793==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FCq4Eu07/ej1hAmI"
Content-Disposition: inline


--FCq4Eu07/ej1hAmI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 15, 2021 at 10:13:30PM +0800, Xie Yongji wrote:
> +static bool vduse_validate_config(struct vduse_dev_config *config)
> +{

The name field needs to be NUL terminated?

> +	case VDUSE_CREATE_DEV: {
> +		struct vduse_dev_config config;
> +		unsigned long size = offsetof(struct vduse_dev_config, config);
> +		void *buf;
> +
> +		ret = -EFAULT;
> +		if (copy_from_user(&config, argp, size))
> +			break;
> +
> +		ret = -EINVAL;
> +		if (vduse_validate_config(&config) == false)
> +			break;
> +
> +		buf = vmemdup_user(argp + size, config.config_size);
> +		if (IS_ERR(buf)) {
> +			ret = PTR_ERR(buf);
> +			break;
> +		}
> +		ret = vduse_create_dev(&config, buf, control->api_version);
> +		break;
> +	}
> +	case VDUSE_DESTROY_DEV: {
> +		char name[VDUSE_NAME_MAX];
> +
> +		ret = -EFAULT;
> +		if (copy_from_user(name, argp, VDUSE_NAME_MAX))
> +			break;

Is this missing a NUL terminator?

--FCq4Eu07/ej1hAmI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmDla2YACgkQnKSrs4Gr
c8iwDwgAklDinwoNdcTKlrJAeuzd7lkg6g0pp6GgPOoSoPbIEzizyjezLIi98oHV
vF5TkSJ9SmhwrTkrfniJQf7czNd+oWvB/PeLW+YOTNYnHkS4AlS4z4/Z48sAiees
bjx0y6rK8AKEd1d2F5lOEbHr1hyPAEuA5j1trgrHzaUhKLKiRfCYQI0mJIaWYUTT
5AJ6lKidGWNOayzU4/GQ+PfEPahMie3/T2g+ivR4j0E6YLNvJs7CFFerZYRNGLXQ
D5MqzXxvgHF75J7QuXmOOYTRhRMzWoYI4K6EfwzZJHWIJrBhVeXogKJ0Z4tnp82W
f66VauRbMPZNCJ5g0gXGzczBzlXh0A==
=aR1n
-----END PGP SIGNATURE-----

--FCq4Eu07/ej1hAmI--


--===============1263127556867454793==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1263127556867454793==--

