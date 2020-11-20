Return-Path: <SRS0=3eTK=E2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F7AC2D0E4
	for <iommu@archiver.kernel.org>; Fri, 20 Nov 2020 16:26:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EB7B2225B
	for <iommu@archiver.kernel.org>; Fri, 20 Nov 2020 16:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7Fu2uHG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB7B2225B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E86E387478;
	Fri, 20 Nov 2020 16:26:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DNMQVM08Ai7j; Fri, 20 Nov 2020 16:26:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8472487447;
	Fri, 20 Nov 2020 16:26:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72546C163C;
	Fri, 20 Nov 2020 16:26:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0477EC0891
 for <iommu@lists.linux-foundation.org>; Fri, 20 Nov 2020 16:26:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E3C3686F3B
 for <iommu@lists.linux-foundation.org>; Fri, 20 Nov 2020 16:26:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TzMa8ZoxJ2uU for <iommu@lists.linux-foundation.org>;
 Fri, 20 Nov 2020 16:26:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2B79986EA1
 for <iommu@lists.linux-foundation.org>; Fri, 20 Nov 2020 16:26:36 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id k2so10672836wrx.2
 for <iommu@lists.linux-foundation.org>; Fri, 20 Nov 2020 08:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=uLP0sG7IAs7+cc+GreF3lr0MerBJLvcZOPUd3stxzAw=;
 b=X7Fu2uHGBxHD9Q0cLEJcbKQlyyEe6ZL5+8Rojb8tsCgxQtfTVox4rzCWhmnR16gpYC
 ux81LFBM7fgBYCa/8NdgpNpS1zClv44/zPqkBV/FkCc/At52qFwY9OK2hmClKlCMOwWV
 BvRbX0QI9ZPGEv9XqjxvUvv+dBc4hasXlcGUEBLfuI/f7FEYv/XJXBF+MzWyNHW+iqCF
 JaL3nwrdTysU0tg/XucM1i02u1jwhKwp4839LaKrx4sun0/m8KfqOIouDqZgKpX8LQBB
 BANXCtdH9FJCrQseVWOZVSh7Vnvr482vHOT27GYEnIveqEPkZrBAOs4bndBLrzJoMXzz
 4NFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=uLP0sG7IAs7+cc+GreF3lr0MerBJLvcZOPUd3stxzAw=;
 b=kbBYIv+liDC4S0BKTtcRhjt/j+dm1Z0tM9irKYbA8jYI2qJmrR/YmP/4EzudsQbxbx
 l2sffNtBOtoUonTGu7dPKQxLWuEkHEIU4/cFFF8KioQ1bkNUqSv4PcBIHcrt3yf/X1WB
 acOaZmEZ8RAjqRfFz6sPyGJf2RDdhS5YBQH/azIZrpmYWVvhNoeDTL0yNma5uI04lLSX
 YYMybCeccx5HCJa2PiyVYXczTyhQbcy/mGKkAD8lCr+s8XChlZ+08UNnY5DaDD8L13zu
 56jcvV6Ndnd9LRBwYKRzZzNuUX1B1eHOyANfxA19zQljgSKjkfCxqmsvTmDJ9ZUmUPGq
 1WPg==
X-Gm-Message-State: AOAM532SH+V0Ru296U3teEGoxT+VMSwJdnjWZ7+HxByiQqYpE5JZ7r60
 jcQSyP8xFSNlzUyIFsV/oQY=
X-Google-Smtp-Source: ABdhPJzhkS/cosRT2dyRGlAjfUutCi3tca5uZYK6T7Td7wjTAaL8iqjhxeZEShhwZOBC9zJ2ktURgQ==
X-Received: by 2002:a5d:5446:: with SMTP id w6mr16889747wrv.122.1605889594525; 
 Fri, 20 Nov 2020 08:26:34 -0800 (PST)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id b8sm6055040wrv.57.2020.11.20.08.26.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2020 08:26:32 -0800 (PST)
Date: Fri, 20 Nov 2020 17:26:31 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH RESEND 5/5] iommu/tegra-smmu: Add PCI support
Message-ID: <20201120162631.GG3870099@ulmo>
References: <20201111222129.15736-1-nicoleotsuka@gmail.com>
 <20201111222129.15736-6-nicoleotsuka@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20201111222129.15736-6-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, linux-tegra@vger.kernel.org
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
Content-Type: multipart/mixed; boundary="===============5653905667146747193=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============5653905667146747193==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cyV/sMl4KAhiehtf"
Content-Disposition: inline


--cyV/sMl4KAhiehtf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2020 at 02:21:29PM -0800, Nicolin Chen wrote:
> This patch simply adds support for PCI devices.
>=20
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Tested-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  drivers/iommu/tegra-smmu.c | 35 +++++++++++++++++++++++++----------
>  1 file changed, 25 insertions(+), 10 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--cyV/sMl4KAhiehtf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+37jcACgkQ3SOs138+
s6EiTg/9GRPPoHHfgJdC1KDJNHfaIvRHgIfN7UJZrAi+9AohCLVeZv7Hy4tc2f+W
9CGahWmVzh/ES/nlePd2ZU5dv7Ef+g7Pn6RFd2iBrK90oR+9FBoXfOIL42xWSgZm
iHBYOXt40v1+UOXGJ2Am0twNqHJ2nhP7o0s1I46WHOZbaW797J76HQd/vbLF5AYP
surUNEMbp2e49FwVBDn+gScDQfPvX88L6AcSWXuihwUEgSl0zYmByK2nav27GAmf
jTNDOi4i3I3uGTYgB9eOJLqlbWqgy50Ld7Ot2GoTHsuetAPB1wK8PxpXJGjVqCxR
AxxgIUFjmawetf/k9qAYL7SbC2aSYi5p/vu4EeTlXkvHzDaHzchCzacj3YCztlVE
AMzQ+Qhi6smuDbKF93Fb0LsD0dBUEE9Dam7UxzpdZj08Es3lC+e46srGVTWSDL5x
hA+v/qhB+QysJLuUTPiU8sg38tSLJ9rHyZqVU1fvLmvSa5fZyCVJaoCFhFk5I1vR
1Wos2O1lX6QcoO4u0H2HXw/mAmK3mdRsTl1nbu5xCISIcc9zld4sJwcEyx7vE64W
Jz9M51nARrLd9v/UhGMzwp3PuvLlguvVNY62R75gbnvPjQDDJCBm+HZBRlcup+pI
0Tnke8ctQk+71cQeUlgiv/GjzsOJo2KCsE5tyoFKbnIjyx3z9TA=
=0u3o
-----END PGP SIGNATURE-----

--cyV/sMl4KAhiehtf--

--===============5653905667146747193==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5653905667146747193==--
