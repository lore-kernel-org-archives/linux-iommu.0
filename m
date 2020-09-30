Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717FFC4727C
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 15:23:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D23B12071E
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 15:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoIndwf/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D23B12071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8B8F383F66;
	Wed, 30 Sep 2020 15:23:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LoSklTUrH19v; Wed, 30 Sep 2020 15:23:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id CA43C83DA4;
	Wed, 30 Sep 2020 15:23:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F4B6C0890;
	Wed, 30 Sep 2020 15:23:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91E65C016F
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 15:23:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8108B83F66
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 15:23:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KeObos-500ZR for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 15:23:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BBE5D83DA4
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 15:23:24 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id n13so2268228edo.10
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 08:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=2DHtrnIA8o4CB8S35Hwhaekafbny6oX0rWN4GwHpG0A=;
 b=HoIndwf/0dNx+FTzfoWU6WcSIuggJG/fuUnDvzeRU9NjlbJort3dAOW2CONbMSx6Hh
 yNmqpwApaXgnBrAkCat0e3fgeeghUAmf8YiBP7ZB3rX1b7Yzqy9444oWNkuaD7f+hfXa
 bI1vZKgbsthsKOFTu0WHNntubi8rJuqIFyr7J/xZ1YB4nhxb0HaoxQ5J4oZJ/uXqPNpH
 uDL5+DcrBofdhYBh+0WrIPpNp/3zomm6af1b1S2Wv99Ngz9ejbyhfjthhikzxetMlzyL
 +ADe2stFy+78pSV/L3yjsbvT4FqzR1jBiQmTyUE5xTYjl+GVljCJ6DvnvF5NfiLU7SkN
 mPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=2DHtrnIA8o4CB8S35Hwhaekafbny6oX0rWN4GwHpG0A=;
 b=hHiCkmtpkgp6/pfgpoHkJ3uhgxXOp78ny+vk983a2m/I1VgvHivOwHjwHARxvjQfkV
 zpO9v/ets8jooQ2Osy8vhIhx1CBUGFPXSyi/8GXwzmvou8Uf7XpiS6r+N8wKY3gF65G+
 I06/CiAzxNivTYW85gyuV19ic/TADgZPGFVSsqMwfnYX7bM08NlU1B5fxhMHDtyph81A
 u8suq4v8Ja9qwKE0K696avcMN1LwnUuvGVsq7dD0V7H6VFfnkftHGQll71+G4nvFit3M
 OfWG//kfChAuqAU9ODYJ6VsZYRZk8ZsNP9T0/OAWOR/yC6DkmYSTeLd6Ea2jJMrVuKh2
 GwWQ==
X-Gm-Message-State: AOAM532Y6YZ5c3o6ot/8yrbfZOHKNMygRAlBC9urHXt614JMKXCI4TF0
 np5NAGd9RnJp/uR5oDbBV1Y=
X-Google-Smtp-Source: ABdhPJySzwiEk88jyPnNbBg/HN8xcT9495DFNaDdUb7a/cLuHdBMGxr6hBjQ1M/WGZlXYGNrO7cy2g==
X-Received: by 2002:a50:dec9:: with SMTP id d9mr3328095edl.145.1601479403296; 
 Wed, 30 Sep 2020 08:23:23 -0700 (PDT)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id z17sm1819511edi.90.2020.09.30.08.23.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 08:23:21 -0700 (PDT)
Date: Wed, 30 Sep 2020 17:23:20 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v3 1/3] memory: tegra: Add
 devm_tegra_get_memory_controller()
Message-ID: <20200930152320.GA3833404@ulmo>
References: <20200930084258.25493-1-nicoleotsuka@gmail.com>
 <20200930084258.25493-2-nicoleotsuka@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200930084258.25493-2-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 krzk@kernel.org, jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
 digetx@gmail.com
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
Content-Type: multipart/mixed; boundary="===============3771076943140633191=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============3771076943140633191==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2020 at 01:42:56AM -0700, Nicolin Chen wrote:
> From: Dmitry Osipenko <digetx@gmail.com>
>=20
> Multiple Tegra drivers need to retrieve Memory Controller and hence there
> is quite some duplication of the retrieval code among the drivers. Let's
> add a new common helper for the retrieval of the MC.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>=20
> Changelog
> v2->v3:
>  * Replaced with Dimtry's devm_tegra_get_memory_controller()
> v1->v2:
>  * N/A
>=20
>  drivers/memory/tegra/mc.c | 39 +++++++++++++++++++++++++++++++++++++++
>  include/soc/tegra/mc.h    | 17 +++++++++++++++++
>  2 files changed, 56 insertions(+)

Let's not add this helper, please. If a device needs a reference to the
memory controller, it should have a phandle to the memory controller in
device tree so that it can be looked up explicitly.

Adding this helper is officially sanctioning that it's okay not to have
that reference and that's a bad idea.

Thierry

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl90ouUACgkQ3SOs138+
s6G0NA/+JtP7HDf54k4WLttD9PHeHmArpo9ZQ9Cih4NUP5xCKMD3bmzowtvSTGJ8
xPvIdl9O855MlxNNauh+7cXg3nDvn85BUCNaMKtAzVQ30BtXWB95H7QhFVG2Kbgd
+evbfXFPrpqaWBZ6egGauexDgTfefBKtOypZz7aof4auiUHpKGooSheje97iA9b5
+aof5Hr8iZUgr26RreE/zS0YzcqSG90mGMHt6gSOi1YYh53MIIjMz9wqWIar3CoI
Tf0K6GdsuYfEnNPaANj0QGyX56MIN/rxHS8t4pc3wa626ZDIr4Lbqbub2X2bqfph
VzqnbHp6pKJlF14Vl9kBMALzuozE2YQPzNGXPmx0atTx6D7CMemh1lDEgl9s6jOY
xLkGXaaXxeuAG7uRpjl5e/ZvKcZPAo/5h7e1rVI7YzqT8fOQFutSnIee7OtUJn1I
NofIhug9Nr2AACZedAO/ogsi6OzKpCGisFSA5u/QNf4oo+428a9kNgmgPUtye1AP
Bs63Kyo3FC45T8qOGbh3Fq/+PmutQ5jrxZ4GvlzkFrEvNi4jF92eIpPbqkw/g+SO
r/mfCXbnb9D3wnqhxP54A4HD+7vAN5idvQwx7WORs4bOMmH1+n/FazDn/Cc2uVqS
rV3XsDxoezc0DG8Rw+fsIY2ni4j23qLwTnyZGkSt/3gI9g9LM4M=
=56Ae
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--

--===============3771076943140633191==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============3771076943140633191==--
