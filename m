Return-Path: <SRS0=ygJE=DB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE2EC4727D
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 10:16:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7898A23741
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 10:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeJYJaMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7898A23741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 334BB86FB8;
	Thu, 24 Sep 2020 10:16:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U3Nv4EHzr30b; Thu, 24 Sep 2020 10:16:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B255886F96;
	Thu, 24 Sep 2020 10:16:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96A96C0889;
	Thu, 24 Sep 2020 10:16:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B688CC0051
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 10:16:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9F4A486FB7
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 10:16:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eR32tolzXxwB for <iommu@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 10:16:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B8E0A86F96
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 10:16:44 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id w5so3157783wrp.8
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 03:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=aSjDAH2snju8R3q+4/T0EE6wjXqyrlifnf57RELtEPo=;
 b=BeJYJaMCHnL0aB6F/iUlSDLZ+jXsNh5J7eEl+OXczqw6pRlpuTvN4SJXSSKUXLKlK0
 R74xoyip/4rRV4+yX2Is5Hsh9AXDdgUSlPpI6lrwwm6pq7skGowdiqZosccXmi9R2vIo
 juC/KMMAz3IxRUIgZ+T1f2GgInsH/087Kt5tYjcPnsq7d1bFF11ESnQvF/rlCFu5rtDJ
 E0eWyzGPoFAcR1hRlP2mAxOs7V31Mre4QKN5BG/du0BluLg+VOBorsrb9j7TutNbpP8y
 3JqJGpiHG5tQHOE7CyVLyr2SnDs38sJ3wL0oAzz0q9ezic/QBCMBFtRwgsnuLp0GvzZF
 DDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=aSjDAH2snju8R3q+4/T0EE6wjXqyrlifnf57RELtEPo=;
 b=Uin8wafu+WkRSSUChCbtb/F1EbRU8zALlfKy1u2dwxOPu8L9FB/tYiX9PqljWkXMj5
 rVoeHfqpR0+K8DrR+V2eFQpKZHZ09JJwKsxX+c0H9dHn1MiqrYduIhetWo52I04FXuw7
 HscPGKE/AAWieBYoDKuqF4qONjeuQcwe73RdHJKU1JlBmgUo0Pds0JXDs6QmMaOIwMr/
 kuGIlbsfTDzcIpvrW2WzBXGUNPI7OE7pJMUAXyvWONExdYZXubu3sJOSDYWS5T/M85D5
 yNA9ttO242D2dNlU9QkhGw5+vNR+3ToNQoqBcZwivOkchsMhY8k6m+OLa36siXzLnnm1
 qNyw==
X-Gm-Message-State: AOAM530Q/t+prg7fIVbUR0Jm/2MWH/R094XggpprtfF2T5oBBH6yWjGL
 yQetLcRofAF6Y4o3/+WHWPg=
X-Google-Smtp-Source: ABdhPJwCKtAYprKKYxxF3JdUnbgwkJ2ifDcJjSlJEycf+CXdgujOEgIYaEmIkzffMUV24P0Rs870eg==
X-Received: by 2002:a5d:69cd:: with SMTP id s13mr4120447wrw.379.1600942603215; 
 Thu, 24 Sep 2020 03:16:43 -0700 (PDT)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id y6sm2968176wrt.80.2020.09.24.03.16.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 03:16:41 -0700 (PDT)
Date: Thu, 24 Sep 2020 12:16:40 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: IOVA allocation dependency between firmware buffer and remaining
 buffers
Message-ID: <20200924101640.GE2483160@ulmo>
References: <CAEC9eQOX9BHX4v5aY2cfCT=T-ZHA7y0xF7aiZhW9xzG4fme36Q@mail.gmail.com>
 <CAEC9eQPaeF9=Li74x9RrSHyDgRZ6b653yBRu6EYsaU+eSj2wsQ@mail.gmail.com>
 <59cda41f-170c-a1ad-a345-bc38b9ed4d73@arm.com>
 <CGME20200424161534eucas1p29177cad5b4790d392acb69a335a3992e@eucas1p2.samsung.com>
 <CAOD6ATrWYLPT0ydz2vFhNwWhqHum_q_pyCe=oGJWOcEqjmNOqQ@mail.gmail.com>
 <11584d09-5995-6133-3bd3-8f7a0afd0e01@samsung.com>
 <20200924082830.GB27174@8bytes.org>
 <37e767b8-8ec4-ae80-ea0d-1caf3cdab8fa@samsung.com>
MIME-Version: 1.0
In-Reply-To: <37e767b8-8ec4-ae80-ea0d-1caf3cdab8fa@samsung.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Cc: jean-philippe@linaro.org, will@kernel.org, linux-mm@kvack.org,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Ajay kumar <ajaynumb@gmail.com>, Shaik Ameer Basha <shaik.ameer@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, hch@lst.de
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
Content-Type: multipart/mixed; boundary="===============9028826850600468590=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============9028826850600468590==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7CZp05NP8/gJM8Cl"
Content-Disposition: inline


--7CZp05NP8/gJM8Cl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2020 at 10:46:46AM +0200, Marek Szyprowski wrote:
> Hi Joerg,
>=20
> On 24.09.2020 10:28, Joerg Roedel wrote:
> > On Wed, Sep 23, 2020 at 08:48:26AM +0200, Marek Szyprowski wrote:
> >> It allows to remap given buffer at the specific IOVA address, although
> >> it doesn't guarantee that those specific addresses won't be later used
> >> by the IOVA allocator. Probably it would make sense to add an API for
> >> generic IOMMU-DMA framework to mark the given IOVA range as
> >> reserved/unused to protect them.
> > There is an API for that, the IOMMU driver can return IOVA reserved
> > regions per device and the IOMMU core code will take care of mapping
> > these regions and reserving them in the IOVA allocator, so that
> > DMA-IOMMU code will not use it for allocations.
> >
> > Have a look at the iommu_ops->get_resv_regions() and
> > iommu_ops->put_resv_regions().
>=20
> I know about the reserved regions IOMMU API, but the main problem here,=
=20
> in case of Exynos, is that those reserved regions won't be created by=20
> the IOMMU driver but by the IOMMU client device. It is just a result how=
=20
> the media drivers manages their IOVA space. They simply have to load=20
> firmware at the IOVA address lower than the any address of the used=20
> buffers.

I've been working on adding a way to automatically add direct mappings
using reserved-memory regions parsed from device tree, see:

    https://lore.kernel.org/lkml/20200904130000.691933-1-thierry.reding@gma=
il.com/

Perhaps this can be of use? With that you should be able to add a
reserved-memory region somewhere in the lower range that you need for
firmware images and have that automatically added as a direct mapping
so that it won't be reused later on for dynamic allocations.

Thierry

--7CZp05NP8/gJM8Cl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9scgUACgkQ3SOs138+
s6H9BhAAmPnnd7f1xF0OFvCBxYdVGJNgcXZ7BIrZYlC5j+o/KcGZeVycNplEvNMU
vJMRLxDCE4xNx5nYf1xfLNovACaJ0vG2/fgdjIbGVVRPcehtz9b0TNVXCdp8OgVK
uucQqx7/Pt34GRNLxVs99les7VYl9VffLL6BJWJ0ObuR6wtg6N50PcVXUXwnOEuX
ojX6IUwPugc/64v1Go/8M384PWqggWzTgUD23RBhiLlGZoQD4xbMYsTLFmSutj16
qOix3SC5qDihQYFBZueF9iBTMBHtAlRSixxCZQh/7nBNkn56xm29VWe3C1b7d0eB
vd/Yme5eSez/4tK71ml12mu2wvSv3pzrvKZwD2z6sDWoJX70tFWpnuLZCjZgjjlS
4abXFGtyLlPLDWJW5IWQiQulyMlQ1fk2NnKwZ9AUNOwXECIkf0JDgwqPznLi2S46
sarkEXPwrBW8OSBhwGlUasvw93IQHa+PxS12WT1LIIysUf0YMtRFP8G/c/rw+l42
M6BSXDxwN+bW7Hocae4IheLpVeuE/ycVClEG0S7uu+JIuloRuL8YePp4mPSPak0/
lJpt3rm0RHRaAzcdJ74R3wA8CJXyRRg+tQoyH88sj1JXD/zNneyqqmwRwTe3PiFh
gasKuQv+uMHiJhna6XvHKskzVw5Eh+gVkSdVAbI6omLFKyICYfY=
=THJe
-----END PGP SIGNATURE-----

--7CZp05NP8/gJM8Cl--

--===============9028826850600468590==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============9028826850600468590==--
