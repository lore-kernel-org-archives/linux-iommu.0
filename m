Return-Path: <SRS0=ygJE=DB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF8EC4363D
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 10:26:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A17920888
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 10:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U77b18qo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A17920888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 60016869FD;
	Thu, 24 Sep 2020 10:25:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gj5yfP8OHQw3; Thu, 24 Sep 2020 10:25:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F393E86A0F;
	Thu, 24 Sep 2020 10:25:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3754C0889;
	Thu, 24 Sep 2020 10:25:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C554DC0051
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 10:25:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id BB2C086BA5
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 10:25:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o5hsKdhLGhUo for <iommu@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 10:25:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A7BC386BC8
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 10:25:38 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id e17so2981943wme.0
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 03:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=4/7mHE7BxkmccTTH2BLUO+DA7CrohaCzbOjCPDUfgN0=;
 b=U77b18qoLIwiwEgjDl1y0OmVs0s+KcFyNqBtmJC+gEZsC59CmvhDuUmV9kPsu+nRja
 AlTM2xqOR+n1UsA8OiD6ll5MsvaXcTYcPn9x59MUz33PbYOZqOFV1zuym/tvbHeEJOrX
 rS2ebaaHtDwd4Nu+9dZDesyYDFxoMibS30iyrUX5i9cGIcTXddHWgT2+NbveDPYnc3JK
 9W+hQGyTRosm4EwV/P7bhTE0GADzXO9+FNdUMAl3kCWa/mI7zkMZCvGpPBJnb0kFtl6J
 5A06+gUmTGe6UKhZA/5Vu00FhyoVokvTJdE72buu6lbnhMjX2jj2CCo8yejjoZUPIpLK
 eUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=4/7mHE7BxkmccTTH2BLUO+DA7CrohaCzbOjCPDUfgN0=;
 b=HW5SwVapvWBIlsMgZREcYKfuNa953nWZr9Sx9Biqj1tXcDlRXV8QaZFrt/WYrVgaRo
 N7qlJ1YSFExrMHxi1Rbc0Bo8IqUVocH+1BS+EsXchsaEk5kfN3V0nNMyOvOQpph/BFUM
 oY0RaLuvy2pcNvQny2NsiplwXv3YSK6/zUs3UDZL+8Cj2/SupuiA0/0TiXGN2ymtqEqT
 /MkItxOnjv7TXrDrAfRIQv3m3jTGJR6Kw/05eUPmfNVLBawCbZVvBCgI/80YRWtrhrfz
 LA2cAgDozzYoNbT2RTYRI9QRU3CFc65AaITm9zpuEWzjMJb8rGAxjWkR6oyQuim+yelC
 VHkw==
X-Gm-Message-State: AOAM533mr6LJ6BkyzMlVI0Hqfwko9eWzB6TUJvO3CxcjZSb+CpNILFsN
 PfavGLZZn0F7y+S4NFhwHZE=
X-Google-Smtp-Source: ABdhPJyhb+PV6AabI5OtSsT0y1M2LOJjr35vXCf598N9AvMGTg3pKW/7E6qXjKSx6r7UnQabmUmiew==
X-Received: by 2002:a1c:e904:: with SMTP id q4mr4199133wmc.151.1600943137217; 
 Thu, 24 Sep 2020 03:25:37 -0700 (PDT)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id j14sm3209005wrr.66.2020.09.24.03.25.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 03:25:36 -0700 (PDT)
Date: Thu, 24 Sep 2020 12:25:34 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 3/3] iommu/tegra-smmu: Allow to group clients in same
 swgroup
Message-ID: <20200924102534.GI2483160@ulmo>
References: <20200911071643.17212-1-nicoleotsuka@gmail.com>
 <20200911071643.17212-4-nicoleotsuka@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200911071643.17212-4-nicoleotsuka@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============0319342759461567336=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============0319342759461567336==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r4QXMf6/kyF/FvJJ"
Content-Disposition: inline


--r4QXMf6/kyF/FvJJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2020 at 12:16:43AM -0700, Nicolin Chen wrote:
> There can be clients using the same swgroup in DT, for example i2c0
> and i2c1. The current driver will add them to separate IOMMU groups,
> though it has implemented device_group() callback which is to group
> devices using different swgroups like DC and DCB.
>=20
> All clients having the same swgroup should be also added to the same
> IOMMU group so as to share an asid. Otherwise, the asid register may
> get overwritten every time a new device is attached.
>=20
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  drivers/iommu/tegra-smmu.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Makes sense:

Acked-by: Thierry Reding <treding@nvidia.com>

--r4QXMf6/kyF/FvJJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9sdB4ACgkQ3SOs138+
s6FXSA/9HImjNheVtwru469lJEW3LBct1GkjgSPN4oFezSxMJgy/vj/YRrTy9Ezd
X55ZrMV9GkKyXW5Bj9LUrnI8svadFcgn8Lyq19ywPJuDRz9KRwjpNYhsTbHycbDM
qTaWGh6xzL2RCvRq0LvofEtJBdn972bpZWoBgNNN/obKs76RGEFasx6YhX8MI9L3
I59OWzZMYraOjbVfiupZ+25wpVEHf2L4ADleLTJjM7SprxZX2wzqpH4k+simc01d
V1yw1JaQk6YSKKy5+qHUWq9zU2g+j92YhZ38CVsdRcmqOnwljDkvHXSQREIOvBoL
aGQcGE6F/KPI5G5bl2u6vI0Z+pDd886/zLKAUNThqhsi3CApLfr/r9ZnaUWjE/5O
G6zEzghEY6lA88dWqQzg4Q0EVpSbJAt2a/QkoN0tdmtaoi0Kv6w2chKnzxU8Ql2s
uVQd46EKITbnIFxYW713HAyfQ6mCbT0BGUwYhItM1H4du5Sc2x0e2Llv4WhM/7pP
9vfs1bJjp5ZRhU4zb7ktuypFepunlYIW41lHA1PJkIm+O7kPf+leVUL86JeOjgyo
142PMzUDPgKFbJa3VpmCerNtVE9+jp25tu0E+nsUvOvZhINvCYxE08sz1fMjn+84
MKRzue+EB7DjFQefNE7Fww9+GoJ9qjffNunue6EX9QfZIw5Sr8Y=
=nmeb
-----END PGP SIGNATURE-----

--r4QXMf6/kyF/FvJJ--

--===============0319342759461567336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0319342759461567336==--
