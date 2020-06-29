Return-Path: <SRS0=qe9F=AK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF38C433E0
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 09:24:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C250233F7
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 09:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nwiUy9yd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C250233F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4D26F893A6;
	Mon, 29 Jun 2020 09:24:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fSyR4e36cXFk; Mon, 29 Jun 2020 09:24:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D891D886A7;
	Mon, 29 Jun 2020 09:24:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB322C07FF;
	Mon, 29 Jun 2020 09:24:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 802ACC016E
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 09:24:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6E713893A6
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 09:24:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BL7H5z1ZVshR for <iommu@lists.linux-foundation.org>;
 Mon, 29 Jun 2020 09:24:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9B89D886A7
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 09:24:52 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id w3so2933447wmi.4
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 02:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Ld9UvqUlCnaDa6Nr3mgdlVma1GzBMI5TiJRPCMQofBE=;
 b=nwiUy9yd09ET9XzcpcuXez3fMHQncNtE8g7djjkGgNt2GR+i//HlDlD37trW1/VkEv
 816mnzjBNfxUnnGthrCdGeibMQDDOYLZh2pTjsf38WtAXbWqWCsP0eAGT8SSXiNlX35y
 H8dYrWISxUff+AHAT3X2ZCH+jBq0N9R15IY8Xa95ER+hDlDDOEhMdSWaaCG5z1rpkQRL
 kzHTatKOeVnb+VeXWALxLiJ3TozcMod7N2rqSrV9IiZJD9vhAaan8CWoKiESTNpeTXTt
 VZPYjg9GrERjBs0f2V6Bb+u4jSAzsd9Lwvg8x3x1Mj7Rd8DXQY06jouGdiyjp3Xx16tX
 hBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Ld9UvqUlCnaDa6Nr3mgdlVma1GzBMI5TiJRPCMQofBE=;
 b=syCVp+NbrzB9h+Dx7RMRkkDXJN0iq6CymQMxWYDavzYHi64kyIDgjnDc+dt4qF8sCl
 ZJDlkuoxJW3t45BtWSeKMKMLC7tvs1sGRj8tXw6u/ASI+r18V48u2npt10Dbg6ttNtZY
 2YrYzUp30R++wTgVXB8SDtVR8xIA+9aWeIMLjhXfFqeUF3uIxNGfwkOZRVbRZzKEpuhQ
 oUeodxM0tXtn41ZToHpcVNBwSS4/O8k1hOlCEiOSe90B09rK0RlvGEeAO7w5KyuaObjc
 mmMiW/EK9kEdyRoz9IANJ5nfIyjpMYDMbI1lQE0PS3UkIYIKFurIb/V2mS1rCRveA66X
 T3Lg==
X-Gm-Message-State: AOAM533GqZqm7TqyjOURFV5hT5xJtJLXmIj99t+BlpdI7AFoaqR2S9JI
 jgD9U1sZXfHgwKjwAT2hTII=
X-Google-Smtp-Source: ABdhPJw2RkUG8Z0dPKHKb4TAjtfyGZ1T5JajSYZC/wPGfYi1xn86DVsJzfXAObmKns0fDMcS6MpByg==
X-Received: by 2002:a1c:e285:: with SMTP id
 z127mr15922880wmg.162.1593422691054; 
 Mon, 29 Jun 2020 02:24:51 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id w2sm38771557wrs.77.2020.06.29.02.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 02:24:50 -0700 (PDT)
Date: Mon, 29 Jun 2020 10:24:48 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [PATCH v3 02/14] iommu: Report domain nesting info
Message-ID: <20200629092448.GB31392@stefanha-x1.localdomain>
References: <1592988927-48009-1-git-send-email-yi.l.liu@intel.com>
 <1592988927-48009-3-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
In-Reply-To: <1592988927-48009-3-git-send-email-yi.l.liu@intel.com>
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, ashok.raj@intel.com,
 kvm@vger.kernel.org, yi.y.sun@intel.com, linux-kernel@vger.kernel.org,
 alex.williamson@redhat.com, iommu@lists.linux-foundation.org, hao.wu@intel.com,
 jun.j.tian@intel.com
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
Content-Type: multipart/mixed; boundary="===============2802975179253045304=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============2802975179253045304==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 24, 2020 at 01:55:15AM -0700, Liu Yi L wrote:
> +/*
> + * struct iommu_nesting_info - Information for nesting-capable IOMMU.
> + *				user space should check it before using
> + *				nesting capability.
> + *
> + * @size:	size of the whole structure
> + * @format:	PASID table entry format, the same definition with
> + *		@format of struct iommu_gpasid_bind_data.
> + * @features:	supported nesting features.
> + * @flags:	currently reserved for future extension.
> + * @data:	vendor specific cap info.
> + *
> + * +---------------+----------------------------------------------------+
> + * | feature       |  Notes                                             |
> + * +===============+====================================================+
> + * | SYSWIDE_PASID |  Kernel manages PASID in system wide, PASIDs used  |
> + * |               |  in the system should be allocated by host kernel  |
> + * +---------------+----------------------------------------------------+
> + * | BIND_PGTBL    |  bind page tables to host PASID, the PASID could   |
> + * |               |  either be a host PASID passed in bind request or  |
> + * |               |  default PASIDs (e.g. default PASID of aux-domain) |
> + * +---------------+----------------------------------------------------+
> + * | CACHE_INVLD   |  mandatory feature for nesting capable IOMMU       |
> + * +---------------+----------------------------------------------------+

This feature description is vague about what CACHE_INVLD does and how to
use it. If I understand correctly, the presence of this feature means
that VFIO_IOMMU_NESTING_OP_CACHE_INVLD must be used?

The same kind of clarification could be done for SYSWIDE_PASID and
BIND_PGTBL too.

Stefan

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl75s2AACgkQnKSrs4Gr
c8hGZgf/S6BmV5BJlZFL4v96V8MqJ1UApXYPiFhSWcTAi3F2d7D1PHEMnb2lik58
p5STu+PaKGaPqTdgbYN9HuBnxDICBJeK15QlUiYiqUZ4fJWyoji1YKex99TBArJv
d+aM8KEhWqQAmX6XC98rBa22CpE2o2KGopAAeHYebRuB7HLeaPbP0382nABszqQt
JpkAcSMTXRXiwM82Bkt9wajLDQt90FksLcZl3mdMqYCn1sqKmOxLeCwJ4T4EuJMz
/zH426rvbLkJeLWNgeI3+5fMdvqfAkbflq34AI6MQITTkhjKtfEs0WOH7Sn8EBA/
SdAw3quTGbPopTw9cv2jtd+owKiL8w==
=IfDH
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--

--===============2802975179253045304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2802975179253045304==--
