Return-Path: <SRS0=qe9F=AK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BF1C433DF
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 09:21:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02883233F9
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 09:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJ889BmJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02883233F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D1B99893A3;
	Mon, 29 Jun 2020 09:21:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id REcyDKo1GluJ; Mon, 29 Jun 2020 09:21:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5CDE689393;
	Mon, 29 Jun 2020 09:21:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 523FAC07FF;
	Mon, 29 Jun 2020 09:21:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED5D8C016E
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 09:21:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E916788829
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 09:21:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eZPEpI+9xuNP for <iommu@lists.linux-foundation.org>;
 Mon, 29 Jun 2020 09:21:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1D1CD88822
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 09:21:36 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id q5so15768073wru.6
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 02:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=u36sE6+AVFdBFxDD1Z4WGH1iqkdyYgs1gbZlLzZxPLE=;
 b=IJ889BmJs5fJA5JUI2j9TnvlzUL6xKrXd3eu1AW6e3BrxmyJ2ATlUFZy+P7GIYORW6
 HYez5wQ7G/KioFh7zuBQymOuqxnI7c6j5yRe11o57m44r8/F60mZ6D+45IRLGvKPT5qt
 aW3wey9iITO657/ug3AKdVol5V7hFGckvAEbPUkmm4tbITw/bvsNqYeXyI4ykT/inVt3
 sloPqSCvfLyPkPQG7mNpTNMCsWUbRe5bsYtwjHO8nL5cv993DWt6EhGXXCUqNcGEwttk
 prxRqeBfShqro3WzaLRT8X+17rgo3DhgNG5L8W2ai+AlV91Mlb7pJO0OmOXsHs/DEz10
 PgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=u36sE6+AVFdBFxDD1Z4WGH1iqkdyYgs1gbZlLzZxPLE=;
 b=CeQ3ZuGX2a++IXT9XwkgfBeGAgWamFqk4LmEnUnFZ+bGyuiskXKrilwwXGIN2tTxTZ
 yfxMtVKIa2WDLdBLmNtUg7MUZ+p8f6ibP5UrgQVxPYBKcNx7Vphk0Rju6mWWyuwgA/JI
 C5W1GVaMqvS1xGYrQ6Cn882d/v+B/CRRi4Tua2UHRSzWlDA7xbKoPEGSXuq977q9OhLD
 bJEp7ud14TBrCp/yxAZLX2vv02d/7yZAucAfJf9BYc/3v2MUWsjw0nn7sxgOQtAVZQip
 1sIv77Py7/UCN3n6Tb92ovsvNVL3GO3bK6T3IBp/GAyCTQKuyXyBBgnvNF0rtbV2G0ww
 +HmQ==
X-Gm-Message-State: AOAM5306m99sRFN97EnMwZo35HTSrOjVn3K1xfd8nUIxByaL84ioje4o
 pTxNmeROWKA7kGgTukK6PYg=
X-Google-Smtp-Source: ABdhPJzh7GPo/4W5Lhu8m6qyhHoxvF0iYmpIYlqSS2hKwQ7UFkCIhEfG19AD/L05HblV+ynNCJCBSg==
X-Received: by 2002:a5d:508e:: with SMTP id a14mr15439712wrt.335.1593422494478; 
 Mon, 29 Jun 2020 02:21:34 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id b18sm18487064wmb.18.2020.06.29.02.21.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 02:21:33 -0700 (PDT)
Date: Mon, 29 Jun 2020 10:21:32 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [PATCH v3 13/14] vfio: Document dual stage control
Message-ID: <20200629092132.GA31392@stefanha-x1.localdomain>
References: <1592988927-48009-1-git-send-email-yi.l.liu@intel.com>
 <1592988927-48009-14-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
In-Reply-To: <1592988927-48009-14-git-send-email-yi.l.liu@intel.com>
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
Content-Type: multipart/mixed; boundary="===============3257902884824086574=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============3257902884824086574==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 24, 2020 at 01:55:26AM -0700, Liu Yi L wrote:
> +Details can be found in Documentation/userspace-api/iommu.rst. For Intel
> +VT-d, each stage 1 page table is bound to host by:
> +
> +    nesting_op->flags = VFIO_IOMMU_NESTING_OP_BIND_PGTBL;
> +    memcpy(&nesting_op->data, &bind_data, sizeof(bind_data));
> +    ioctl(container->fd, VFIO_IOMMU_NESTING_OP, nesting_op);
> +
> +As mentioned above, guest OS may use stage 1 for GIOVA->GPA or GVA->GPA.
> +GVA->GPA page tables are available when PASID (Process Address Space ID)
> +is exposed to guest. e.g. guest with PASID-capable devices assigned. For
> +such page table binding, the bind_data should include PASID info, which
> +is allocated by guest itself or by host. This depends on hardware vendor
> +e.g. Intel VT-d requires to allocate PASID from host. This requirement is
> +defined by the Virtual Command Support in VT-d 3.0 spec, guest software
> +running on VT-d should allocate PASID from host kernel. To allocate PASID
> +from host, user space should +check the IOMMU_NESTING_FEAT_SYSWIDE_PASID

s/+check/check/g

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl75spgACgkQnKSrs4Gr
c8gpagf9FTccG+B43s7SRg40eJAbPdgjqaIGSOHqn1yr6h4wG9TuIbEZ9RTdmYdm
OsRKzgTHXIQ6C7tk9qW9o5tUa0qFbeYKsOaxMPYt11sEio0dTJsv82DN4Frl422t
8UMqnTHS2w6hK2ia+Vze5zRF1otE0YPJmnO2riabWnX0i3Imp3n2sEaV8uuZMFie
WSEUaVcm2db2HnS1W02ydcserBdM2RmaMCJ3mbbzlLMfqF6sK/h+UWXqIIfgJk6y
A/F0I15YUSxlGVeNpWym8mbJPDrKmdxu2LuB8Mc1HF/ByH9OY9tlmApru5EGkr/x
hGn3rreQu+7yknOXixQ9sQ5l8jiweg==
=PF2X
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--

--===============3257902884824086574==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============3257902884824086574==--
