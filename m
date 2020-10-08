Return-Path: <SRS0=Q5Oi=DP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6F1C433E7
	for <iommu@archiver.kernel.org>; Thu,  8 Oct 2020 09:53:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64F2C21531
	for <iommu@archiver.kernel.org>; Thu,  8 Oct 2020 09:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMr1Kaur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64F2C21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id CA10086A0C;
	Thu,  8 Oct 2020 09:53:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qs1QoPWnd34i; Thu,  8 Oct 2020 09:53:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A4E878683B;
	Thu,  8 Oct 2020 09:53:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E1C4C016F;
	Thu,  8 Oct 2020 09:53:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DEE76C0051
 for <iommu@lists.linux-foundation.org>; Thu,  8 Oct 2020 09:53:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D326687458
 for <iommu@lists.linux-foundation.org>; Thu,  8 Oct 2020 09:53:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aD2d63TZd7+B for <iommu@lists.linux-foundation.org>;
 Thu,  8 Oct 2020 09:53:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
 [209.85.208.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C580387455
 for <iommu@lists.linux-foundation.org>; Thu,  8 Oct 2020 09:53:47 +0000 (UTC)
Received: by mail-ed1-f65.google.com with SMTP id cq12so5194350edb.2
 for <iommu@lists.linux-foundation.org>; Thu, 08 Oct 2020 02:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=lqr4ABnW85C3Je0foNXfCbbtgfxpQ2jxIk+IuODdI2Y=;
 b=OMr1Kaur1CMf3Bb2u6SfXVx0so8WS0J5PYKBVqjDMN61IiUVUNdeSZFfI0RtDQvTHr
 +pBjVdv6Mv3lJ6t8n2V2n4mLIcxGnVmy1YFKVp1TsnjM985AztiOkmHTz817n364jcBF
 dP+b8uct4rxtwDJCZqUE4WZ+UpcYWHaQf/7WgMs64G8T4kNugx4ZKOq/Uk49+R921rX0
 og0H/B7hR7VkthHvHPQ/B0tRSOaZJrr99GbreVQkb1s+O4jkVs9HoMfLhrRHFrFVxXFh
 no4UnkO343TxtLCWtpgDFm+7P9O0AklpSpxfVFB3dQ+ynS8qdLs3zSE/Tw9lzKeo+Qqr
 5U2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=lqr4ABnW85C3Je0foNXfCbbtgfxpQ2jxIk+IuODdI2Y=;
 b=CqbTu326ENMjhCGjUXG0PQ/KEJTnjoljQozY7kaKf4VIrRUz9EwnjSbh785l7rGjP0
 HlnvzuTeMfy1zZr3S5idQ5tylSSmesQSEuc1wmQcgNBe+aFiJH2+9fDxGsRSmnGksvKW
 c4HnCGMdV0Wq7p69y9fN5/OxnCo3zxt9RAOhlU6yCVQWmrrhrqYzQthf/kSmMSDAuKEP
 Qqe9BYe+N+JDS/oalWn1A9OBMT1J3SREh7B3sAp7cgXWmuvOe1Se2PtJHhxntYr84mV4
 GYpXfS7W6ZWW2YQ+ycqZqstE2b3Uy7QHcxdMtYr7j1tbxFFO8WodcsAXdNQ8x6KE1FS0
 qalw==
X-Gm-Message-State: AOAM532DQdFa076xsCRxfLUCGKG1Ke4f3lYq/AbA8vcVboeb9OupKKp6
 pA0tXaQMIT2MCR0YMVTTQ1/OORkBj1A=
X-Google-Smtp-Source: ABdhPJwXAgXumiQ2YlXTkZUA5rbcE6A65/i02wvNNq8+5V40qJvkjd4wlCjH7H2R/YojN/w30Pdeaw==
X-Received: by 2002:aa7:c447:: with SMTP id n7mr8110557edr.134.1602150826103; 
 Thu, 08 Oct 2020 02:53:46 -0700 (PDT)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id dm8sm3553145edb.57.2020.10.08.02.53.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 02:53:44 -0700 (PDT)
Date: Thu, 8 Oct 2020 11:53:43 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v4 2/3] iommu/tegra-smmu: Rework tegra_smmu_probe_device()
Message-ID: <20201008095343.GA2349275@ulmo>
References: <20201002060807.32138-1-nicoleotsuka@gmail.com>
 <20201002060807.32138-3-nicoleotsuka@gmail.com>
 <5542b314-f414-1e83-8cf6-2bf22a41ae9c@gmail.com>
 <20201002185828.GC29706@Asurada-Nvidia>
 <20201005095754.GJ425362@ulmo>
 <20201006010546.GB28640@Asurada-Nvidia>
MIME-Version: 1.0
In-Reply-To: <20201006010546.GB28640@Asurada-Nvidia>
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
Content-Type: multipart/mixed; boundary="===============4503937263524344516=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============4503937263524344516==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 05, 2020 at 06:05:46PM -0700, Nicolin Chen wrote:
> On Mon, Oct 05, 2020 at 11:57:54AM +0200, Thierry Reding wrote:
> > On Fri, Oct 02, 2020 at 11:58:29AM -0700, Nicolin Chen wrote:
> > > On Fri, Oct 02, 2020 at 06:02:18PM +0300, Dmitry Osipenko wrote:
> > > > 02.10.2020 09:08, Nicolin Chen =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > > > >  static int tegra_smmu_of_xlate(struct device *dev,
> > > > >  			       struct of_phandle_args *args)
> > > > >  {
> > > > > +	struct platform_device *iommu_pdev =3D of_find_device_by_node(a=
rgs->np);
> > > > > +	struct tegra_mc *mc =3D platform_get_drvdata(iommu_pdev);
> > > > >  	u32 id =3D args->args[0];
> > > > > =20
> > > > > +	of_node_put(args->np);
> > > >=20
> > > > of_find_device_by_node() takes device reference and not the np
> > > > reference. This is a bug, please remove of_node_put().
> > >=20
> > > Looks like so. Replacing it with put_device(&iommu_pdev->dev);
> >=20
> > Putting the put_device() here is wrong, though. You need to make sure
> > you keep a reference to it as long as you keep accessing the data that
> > is owned by it.
>=20
> I am confused. You said in the other reply (to Dmitry) that we do
> need to put_device(mc->dev), where mc->dev should be the same as
> iommu_pdev->dev. But here your comments sounds that we should not
> put_device at all since ->probe_device/group_device/attach_dev()
> will use it later.

You need to call put_device() at some point to release the reference
that you acquired by calling of_find_device_by_node(). If you don't
release it, you're leaking the reference and the kernel isn't going to
know when it's safe to delete the device.

So what I'm saying is that we either release it here, which isn't quite
right because we do reference data relating to the device later on. And
because it isn't quite right there should be a reason to justify it,
which is that the SMMU parent device is the same as the MC, so the
reference count isn't strictly necessary. But that's not quite obvious,
so highlighting it in a comment makes sense.

The other alternative is to not call put_device() here and keep on to
the reference as long as you keep using "mc". This might be difficult to
implement because it may not be obvious where to release it. I think
this is the better alternative, but if it's too complicated to implement
it might not be worth it.

> > Like I said earlier, this is a bit weird in this case because we're
> > self-referencing, so iommu_pdev->dev is going to stay around as long as
> > the SMMU is. However, it might be worth to properly track the lifetime
> > anyway just so that the code can serve as a good example of how to do
> > things.
>=20
> What's this "track-the-lifetime"?

This basically just means that SMMU needs to ensure that MC stays alive
(by holding a reference to it) as long as SMMU uses it. If the last
reference to MC is dropped, then the mc pointer and potentially anything
that it points to will become dangling. If you were to drop the last
reference at this point, then on the next line the mc pointer could
already be invalid.

That's how it generally works, anyway. What's special about this use-
case is that the SMMU and MC are the same device, so it should be safe
to omit this additional tracking because the IOMMU tracking should take
care of that already.

> > If you decide to go for the shortcut and not track this reference
> > properly, then at least you need to add a comment as to why it is safe
> > to do in this case. This ensures that readers are away of the
> > circumstances and don't copy this bad code into a context where the
> > circumstances are different.
>=20
> I don't quite get this "shortcut" here either...mind elaborating?

The shortcut is taking advantage of the knowledge that the SMMU and the
MC are the same device and therefore not properly track the MC object.
Given that their code is located in different locations, this isn't
obvious to the casual reader of the code, so they may assume that this
is the normal way to do things. To avoid that, the code should have a
comment explaining why that is.

Thierry

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9+4aIACgkQ3SOs138+
s6HueQ/+IOZaomOI+NW0LwMajWW2zjW4gBRAz5bNFuobcJxakAdxvpd+HqnE//XM
GZ1AdJsC31UjUcaSzyyYNr87aCBjadMOTdUkgPOTl7hplEOMY8tt4aFa0AQwCjqF
FvtoCeMZ1fQsTAaq7FLChGrNi2zeHuUS7LMSM1W8ZStUSWqrHvN08fbV+hxy+ikK
FxS+9YrAdxVlnzIczrtceOE8AwmtYk8KouHi81UXSUxqesjBaJZUoo7acF4GwfMC
pTWmuwckCRW51yx9KSZnQJk+vZrQ0BKw4rhDPrwWnIL180fL74Q53A7Z7LuPTdi7
E4D6cNh70nWgJBUTo2Gq3YYKawhZOTSsGyWIvhQiGL3NVlRdYdzk1sa9hvCl/owk
88ERcDSkO82WNapN9ugABK9PYZWdlH9UxdzcTd35r6h/uX6yWogZhC4Mu6kw31bg
2zs7LOQq5nGZgoIB3YriFxLN/HzoVnLV6BYNX7/ZZhMENBpVHh1M3A0u5YUzOxrL
yMgfabkWJSopA2vMbsS/sLVHCQyfjjeQq9lOFNph0mooeUqisiMT5/FE4GCDFIK1
T8vPohPrtu7X5qDms5eoieet0+NfuvUUEFKa8SmAN3NoNQmsuQaFUP6zzEIqj9Ci
zuN3m2IIkv+53g+02oz52FUa4t5V+GvCMrkzqJ3i8mtXUbNCess=
=P2RE
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--

--===============4503937263524344516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4503937263524344516==--
