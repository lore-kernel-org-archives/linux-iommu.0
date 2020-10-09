Return-Path: <SRS0=yPDG=DQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B3EC43467
	for <iommu@archiver.kernel.org>; Fri,  9 Oct 2020 12:26:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B92F0222B8
	for <iommu@archiver.kernel.org>; Fri,  9 Oct 2020 12:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwXhEoXG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B92F0222B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5AC3F86AE8;
	Fri,  9 Oct 2020 12:26:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8eD5eUqbfk-s; Fri,  9 Oct 2020 12:26:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AD01386A8F;
	Fri,  9 Oct 2020 12:26:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FA20C016F;
	Fri,  9 Oct 2020 12:26:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0583C0051
 for <iommu@lists.linux-foundation.org>; Fri,  9 Oct 2020 12:26:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 99792876C6
 for <iommu@lists.linux-foundation.org>; Fri,  9 Oct 2020 12:26:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p++3hsLcRSyz for <iommu@lists.linux-foundation.org>;
 Fri,  9 Oct 2020 12:26:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com
 [209.85.218.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 91625876B5
 for <iommu@lists.linux-foundation.org>; Fri,  9 Oct 2020 12:26:01 +0000 (UTC)
Received: by mail-ej1-f68.google.com with SMTP id t25so12725920ejd.13
 for <iommu@lists.linux-foundation.org>; Fri, 09 Oct 2020 05:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=vxWvga10iK++hQGsOFVlXKsQyXZ7GztSMmrf028ztk4=;
 b=NwXhEoXGxC+R37EfS1lfuy3g8wbdrNmU1E77zfyzc9D/fJwROKORSsZfAQKLCnnOMk
 d5vWXwQRNB4Bi+3zTINWBL0LgydS59ZKZRYp40cKQvY8QiUfAY73FMiBfEWBIGw56R8y
 iS4a2hSi7xRdR5vj0D+RFTrOaiYJ7evxpNryiOknzByilQ9uNIGR+y0R5FUhcVptSfMM
 63P7nk78F1hZKMy+TR1hNm9QyO+zYqHIC3cstDV2l2kqtjSuIyCxdIXx5aF63qupP1vn
 P+WHmPHGzAyyA1lXVqWwtitoHl7b4GiR/PsPmEYg76+c2mfqCWA9pNAP7fV4/QKiLCux
 D0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=vxWvga10iK++hQGsOFVlXKsQyXZ7GztSMmrf028ztk4=;
 b=BwQhWbvjQsmmXyS2CJmFfP0hvw74sFAMpcGAmNBzM0j2xhU6kqYt3Se5US5Y1ACDKT
 YyguysDkkMeCtFMIPJ7ZlkHsL6HoGQ9BQPCwR2gB45mvUzoTYXEai3n0oLBgRRYZJfUT
 EiZkmkoR9h9dsBuYrwN3HHMCy7dIilL+oihPROctSawfu/0q37sAhdAo6gx+nO/1SnhL
 LypvBNl/vmN7eEfd5frGf5vxfJSQYEs+Ttgr0+JSNSwfoUnLdPE1v5qGII1jxBr7cs+I
 Rmleen/+e4MzhQiibdS/hhmxzy99ykAFuqX+pC+RXDiN+Z80uZ9kQ5X6sHhZZNucu5T3
 9KHg==
X-Gm-Message-State: AOAM531my1er4fkmew02q7/W4HGQUnvsQ3ZG7SfjFcPP6TEdpvdf2QGA
 5DD2XnTWyROUqKuiHD00STA=
X-Google-Smtp-Source: ABdhPJxkD3KtJ6bfK9EwnyjmX+Fl4PJjDDa08bzc4YEJmViDgYAtnI0ithJ1zzW1tf+4J5V2VWMRNQ==
X-Received: by 2002:a17:906:490d:: with SMTP id
 b13mr13800241ejq.122.1602246359881; 
 Fri, 09 Oct 2020 05:25:59 -0700 (PDT)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id lb11sm6271626ejb.27.2020.10.09.05.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2020 05:25:58 -0700 (PDT)
Date: Fri, 9 Oct 2020 14:25:56 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v4 2/3] iommu/tegra-smmu: Rework tegra_smmu_probe_device()
Message-ID: <20201009122556.GE458338@ulmo>
References: <20201002060807.32138-1-nicoleotsuka@gmail.com>
 <20201002060807.32138-3-nicoleotsuka@gmail.com>
 <5542b314-f414-1e83-8cf6-2bf22a41ae9c@gmail.com>
 <20201002185828.GC29706@Asurada-Nvidia>
 <20201005095754.GJ425362@ulmo>
 <20201006010546.GB28640@Asurada-Nvidia>
 <20201008095343.GA2349275@ulmo>
 <20201008211209.GC32140@Asurada-Nvidia>
MIME-Version: 1.0
In-Reply-To: <20201008211209.GC32140@Asurada-Nvidia>
User-Agent: Mutt/1.14.7 (2020-08-29)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
 Dmitry Osipenko <digetx@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============6359188187697409744=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============6359188187697409744==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TD8GDToEDw0WLGOL"
Content-Disposition: inline


--TD8GDToEDw0WLGOL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 08, 2020 at 02:12:10PM -0700, Nicolin Chen wrote:
> On Thu, Oct 08, 2020 at 11:53:43AM +0200, Thierry Reding wrote:
> > On Mon, Oct 05, 2020 at 06:05:46PM -0700, Nicolin Chen wrote:
> > > On Mon, Oct 05, 2020 at 11:57:54AM +0200, Thierry Reding wrote:
> > > > On Fri, Oct 02, 2020 at 11:58:29AM -0700, Nicolin Chen wrote:
> > > > > On Fri, Oct 02, 2020 at 06:02:18PM +0300, Dmitry Osipenko wrote:
> > > > > > 02.10.2020 09:08, Nicolin Chen =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > > > > > >  static int tegra_smmu_of_xlate(struct device *dev,
> > > > > > >  			       struct of_phandle_args *args)
> > > > > > >  {
> > > > > > > +	struct platform_device *iommu_pdev =3D of_find_device_by_no=
de(args->np);
> > > > > > > +	struct tegra_mc *mc =3D platform_get_drvdata(iommu_pdev);
> > > > > > >  	u32 id =3D args->args[0];
> > > > > > > =20
> > > > > > > +	of_node_put(args->np);
> > > > > >=20
> > > > > > of_find_device_by_node() takes device reference and not the np
> > > > > > reference. This is a bug, please remove of_node_put().
> > > > >=20
> > > > > Looks like so. Replacing it with put_device(&iommu_pdev->dev);
> > > >=20
> > > > Putting the put_device() here is wrong, though. You need to make su=
re
> > > > you keep a reference to it as long as you keep accessing the data t=
hat
> > > > is owned by it.
> > >=20
> > > I am confused. You said in the other reply (to Dmitry) that we do
> > > need to put_device(mc->dev), where mc->dev should be the same as
> > > iommu_pdev->dev. But here your comments sounds that we should not
> > > put_device at all since ->probe_device/group_device/attach_dev()
> > > will use it later.
> >=20
> > You need to call put_device() at some point to release the reference
> > that you acquired by calling of_find_device_by_node(). If you don't
> > release it, you're leaking the reference and the kernel isn't going to
> > know when it's safe to delete the device.
> >=20
> > So what I'm saying is that we either release it here, which isn't quite
> > right because we do reference data relating to the device later on. And
>=20
> I see. A small question here by the way: By looking at other IOMMU
> drivers that are calling driver_find_device_by_fwnode() function,
> I found that most of them put_device right after the function call,
> and dev_get_drvdata() after putting the device..
>=20
> Feels like they are doing it wrongly?

Well, like I said this is somewhat academic because these are all
referencing the IOMMU that by definition still needs to be around
when this code is called, and there's locks in place to ensure
these don't go away. So it's not like these drivers are doing it
wrong, they're just not doing it pedantically right.

>=20
> > because it isn't quite right there should be a reason to justify it,
> > which is that the SMMU parent device is the same as the MC, so the
> > reference count isn't strictly necessary. But that's not quite obvious,
> > so highlighting it in a comment makes sense.
> >=20
> > The other alternative is to not call put_device() here and keep on to
> > the reference as long as you keep using "mc". This might be difficult to
> > implement because it may not be obvious where to release it. I think
> > this is the better alternative, but if it's too complicated to implement
> > it might not be worth it.
>=20
> I feel so too. The dev is got at of_xlate() that does not have an
> obvious counterpart function. So I'll just remove put_device() and
> put a line of comments, as you suggested.

I think you misunderstood. Not calling put_device() would be wrong
because that leaks a reference to the SMMU that you can't get back. My
suggestion was rather to keep put_device() here, but add a comment as to
why it's okay to call the put_device() here, even though you keep using
its private data later beyond this point, which typically would be wrong
to do.

Thierry

--TD8GDToEDw0WLGOL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+AVtQACgkQ3SOs138+
s6FyaRAAkt3dP2DNCS6TI3/NevoBQ2IpMYqF1ex7aH/lNxsI1ES7OlWIkSvq7Nbp
OdGJxPgxHA9kvYKCwk6u97yR8TX8erODLYov8YWeIYT4j5QcSS/axChfZJwYScEy
TPMyMZrSoQz89AbZjJ1nXF7pafhPzc+9VI9oyouFL2kwJ5nG7oCmHM+oIswYy5gO
ek1ARsPvwoQu1hBT19wRzaQMgE9TVc/HzaRtjaCbWBAXZSNlScjn3MxuWW4Teo6P
5lG3qhBCof7r374RLMz/7bq5MUndj3R5MuwX1eOVzcJgxVYV+94fjTs4ysawaG7f
vqetJ3RBUHia+rXWZx09T3F0ax+EErEs9cQ94OysiDqdnvMSxb/av8yS0j+rYN2u
ZLOBqTMgfQaVLiTZgehSSYU1wGyId93lWNvH8oQ9VZ032x5ys37j8y5+9IOtufM7
ebDWZwobYybBpr8qVA/odW6gStS5qj7gbUE9GBg06y+VB74UdN8K7YLzr4nYNFgz
HEatjuW3kEIAB/Si2fB/yTBm62HAL7pZ2eGeIDxhFr9d0An5mhTkkUF4eN3GPIyA
gfOkKq+Vfq+0JOFF4GJj1nGB5kV7CON90yy/lZ5Snt5ru2SdQNhhreFAo3v6QhgH
IdtXPzcQLz/qJ+QceSHsqujPWojzkVLkGTJVkzojRKwOv6B1vVw=
=8opr
-----END PGP SIGNATURE-----

--TD8GDToEDw0WLGOL--

--===============6359188187697409744==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6359188187697409744==--
