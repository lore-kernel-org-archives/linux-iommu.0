Return-Path: <SRS0=4mi1=S3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F5CC43219
	for <iommu@archiver.kernel.org>; Thu, 25 Apr 2019 19:34:18 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6DA320685
	for <iommu@archiver.kernel.org>; Thu, 25 Apr 2019 19:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="iaApaGFc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6DA320685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 42E73228F;
	Thu, 25 Apr 2019 19:34:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CEB9721AC
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Apr 2019 18:21:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
	[209.85.214.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 823A0786
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Apr 2019 18:21:30 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id f36so197162plb.5
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Apr 2019 11:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=DbfVxgdfCkhec35GU1HQ4GzG8kpZ8WlM4OxO53B8PaE=;
	b=iaApaGFcj6uU2U94JYwH+aiYpAs7mH4qgTvb/UfwCTNP1OssqnPAGZHW7IpbqdtiYp
	PyIuw9vaPpUD6RIQXKUtWGkSMvCzm3i5yCj4lH+X4560EZv9zmEXdNBAESbJ9v6+aOSV
	X++1ZxWBxs4iDNmx5gM00p77NUpD85HuuGe1GibMkOsENpkcOtmd35qt73CJhLIM2Cxh
	a+YNZry3+A1b2YcezOlSUbKGZ40TC2qUo3zcSW0L78XJYGbf9QzXqwIe3rG3oTfp9RuT
	k/Xqvp8/Oqyzg8Z9HdPmDsNmRNrhpxw6FrYQDR5AVepA2k3Jr9F8F8rwF1ZGAqfF04q/
	AXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=DbfVxgdfCkhec35GU1HQ4GzG8kpZ8WlM4OxO53B8PaE=;
	b=oFrVbfAqg+r9yonMeAdUdCwyRoZ71rHE7aa5rgkNOQHz9ZU44r6iTuGR33oLgnTJ10
	9ERiGe2A0PDnYrhBWSIb+8c7OSQO8l11pTxbc4AyEuDcbYc/cfpRbsfhnzYQ6T03OKiw
	+wcjwSiFcrPbHKlSXOGbY9wBDOO1hyRmPtx777lZNepPpk+ZqAcnRkHdzYygRyTkzh4f
	u/Se7dm6iCIwKxpNw9Oh3LzKdywgbTzYimjU2EE2uXatKXPNTKYGs//ebzYwrlxIz0WM
	V8D8nmjYAMHOlHYmZ832L9QVEC1PGqfDar8FSIC2dlB7xwxfVXMFnFr4MSE9Xk/4cnuP
	cfZA==
X-Gm-Message-State: APjAAAXAXuC6Bm/qNxEXpEIiZY3dXhHySMi2yOK1c7iUSYVKF//ufm0N
	fOJFJclxa16dbd59UN0PKPgf1g==
X-Google-Smtp-Source: APXvYqx49q90L/wWwW5GuHsq/Eb9SbYDthv2PbvdhVaz1WB1tjR5W5Iz+vYFKxKh8VhUnwu/NtNifA==
X-Received: by 2002:a17:902:b617:: with SMTP id
	b23mr38726843pls.73.1556216488899; 
	Thu, 25 Apr 2019 11:21:28 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
	by smtp.gmail.com with ESMTPSA id
	a18sm12011087pfg.177.2019.04.25.11.21.26
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 11:21:26 -0700 (PDT)
Date: Thu, 25 Apr 2019 11:21:21 -0700
To: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v2 9/9] platform/chrome: chromeos_laptop: use helper
	pci_dev_id
Message-ID: <20190425182121.GA175682@google.com>
References: <2e1f9a57-6d08-d017-24da-3e6b97fa2449@gmail.com>
	<e882f58b-0808-952e-d293-5e8cc3f04c97@gmail.com>
MIME-Version: 1.0
In-Reply-To: <e882f58b-0808-952e-d293-5e8cc3f04c97@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailman-Approved-At: Thu, 25 Apr 2019 19:33:38 +0000
Cc: David Airlie <airlied@linux.ie>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"open list:AMD KFD" <dri-devel@lists.freedesktop.org>,
	Paul Mackerras <paulus@samba.org>, "moderated list:ARM/STM32 ARCHITECTURE"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
	Jose Abreu <joabreu@synopsys.com>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Alexandre Torgue <alexandre.torgue@st.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Alex Deucher <alexander.deucher@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Benson Leung <bleung@chromium.org>, "moderated list:ARM/STM32 ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	"open list:8169 10/100/1000 GIGABIT ETHERNET DRIVER"
	<netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	"open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	Enric Balletbo i Serra <enric.balletbo@collabora.com>,
	David Woodhouse <dwmw2@infradead.org>,
	"David S. Miller" <davem@davemloft.net>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
From: Benson Leung via iommu <iommu@lists.linux-foundation.org>
Reply-To: Benson Leung <bleung@google.com>
Content-Type: multipart/mixed; boundary="===============5066707304174517735=="
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190425182121.VFfjbzAEvQWfTfTG1M6Of9bFW6ZjwgCU3MGDI4q6QHQ@z>


--===============5066707304174517735==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Heiner,

On Wed, Apr 24, 2019 at 09:17:19PM +0200, Heiner Kallweit wrote:
> Use new helper pci_dev_id() to simplify the code.
>=20
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Acked-By: Benson Leung <bleung@chromium.org>

> ---
>  drivers/platform/chrome/chromeos_laptop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/chrome/chromeos_laptop.c b/drivers/platform=
/chrome/chromeos_laptop.c
> index 24326eecd..7abbb6167 100644
> --- a/drivers/platform/chrome/chromeos_laptop.c
> +++ b/drivers/platform/chrome/chromeos_laptop.c
> @@ -125,7 +125,7 @@ static bool chromeos_laptop_match_adapter_devid(struc=
t device *dev, u32 devid)
>  		return false;
> =20
>  	pdev =3D to_pci_dev(dev);
> -	return devid =3D=3D PCI_DEVID(pdev->bus->number, pdev->devfn);
> +	return devid =3D=3D pci_dev_id(pdev);
>  }
> =20
>  static void chromeos_laptop_check_adapter(struct i2c_adapter *adapter)
> --=20
> 2.21.0
>=20
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlzB+qEACgkQHwn1ewov
5lip2g//eS1J0w28ODQxNNXn6vFg16ufHWY3pS3fpqOzY2iOnxmiL4V9a8qXXgs6
Nb7+tl1LTqFgN10TKr4KcYiPShVug0uz3SX9Gx6sI8d0C8Cy74QrQf4wQp48cg6I
0J0BgM0Icd6QdpdrNYZrcRmFJc7FY16i30SMAuINtfcnqgw4oU6hSG3qNXjqNrFG
2VUUjZHpvbAwWso0xToWjfK0TNPQXSslFKi+ROjvWlL+y0TGUBbcMbxviAp1H35X
CuT5Ijknh8FdG+NaMFnGXf6JvzGORNgXlAon15XEbKDf25/K/JyyDh9nJuPesOwG
MmYEiWj29dwg3/8rKvuWpuJVqWplC4x+ZCFvvEaDFeoxZuoLVc5QkVMRkupxwoA7
Ux1/Q9A7YS7OjOPhN2DikJIn2hEJnEyCBU2PdKEZToCUJ/C2gA+WqHyNXcflOldD
PBJSisoYM4LcuV1hhhfXUU/n/BgVPbmYWfvyQpHEbDpnlnDxMb+LheCgDlBn9mAh
QBD82gS5LcMo20071hVEqReV4zBzOc+S+h/4OxYW2HCNyn3qwztqYOge2oM/ezQ8
CV98H+KfIw+dYK8Vi40O9C05+NRkcAY/RaZzjQMyDJG2KxcO1mZhdhhbzCBRuS0o
pj3CU8ScPFa+s0qe7xk/Pac8fR6hmcse8jaJKX7in5MDKQNQ2CY=
=Oshd
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--

--===============5066707304174517735==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5066707304174517735==--
