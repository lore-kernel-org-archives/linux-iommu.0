Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE997F
	for <iommu@lists.linux.dev>; Wed, 14 Sep 2022 09:48:36 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id r18so33404114eja.11
        for <iommu@lists.linux.dev>; Wed, 14 Sep 2022 02:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=O6/51sRCVz/G+JMMiz4jUXKcq/lDDLeL+799B6cifJY=;
        b=m4iKwRmseKb2qBCAV8yrFJqvxQf9BfcXcWFgtWrzYjSwjnWyH/dEJ3chIsXAf/pDDy
         edjaGQMhABfXi6TX+VEJZwUiww5ghb/5M0NrTobZdWSs+H0aXvdJyIA1NA7KndJpGFu+
         2YMtlrsx+ZN2IKMkdRRUOKkbmh4HYxL8nB5FzP/SW6BM7MS+MqGueTTevuCFpiTem6SG
         ICVVBiEyME9oPdnayfbWjIMtzh4vAQf/qmXFltD03sCaQv+oFhHAMZhCPw+YXTAoOn6c
         GmKsf1fH3i31hmj09Bw8tuun8c5QGWwTtza4DC0yxw/sshSjQlJ1jKSX8ygKBl/kN0+a
         7OUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=O6/51sRCVz/G+JMMiz4jUXKcq/lDDLeL+799B6cifJY=;
        b=Q91ZhWLxP025D2pETLwRDruxyqxol241E/wlFbYPoDW1z+dPNfdI0UxogH+XGsdzgp
         WbiJm5hDh7E2WEj8Oe0DGUhyui2FdYwHdIKSR3LDeu4KHpQrLkOyrXIHvo/M0upAV7t+
         lJt830qd2lUinWevEqI2yW/NNn3VN9WAaovEOzFi/aSGku56eF03oYlpwmHL9mQxAU14
         vueHD7D6tczcoPPR1/lrJ4mBbVvxe/dbnLJF4zsY4zWZ/l63SgQ97H7C1JUYOBvTQCCu
         Pg2LvfduivJFwR9ovuqxBUHLH9UO2yFqvO2aWVOOa+zAISPs6/+29cy98DH4po8ufiMn
         UJXQ==
X-Gm-Message-State: ACgBeo1HnTECGxhmxhytq4ORY1W8vRvt+XHypA1JPDVTQfNX1bwjEaN5
	vxyrFKEGjOqjaVeF6KuuGOI=
X-Google-Smtp-Source: AA6agR4cbNn3vgqQ1w8yp96TSvi3BC3ugARcldB/Hs0CwQ3HenzBgDLbK4GS6PixYFm7I3L1DMmggw==
X-Received: by 2002:a17:906:9c82:b0:6df:baa2:9f75 with SMTP id fj2-20020a1709069c8200b006dfbaa29f75mr25671187ejc.762.1663148914326;
        Wed, 14 Sep 2022 02:48:34 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id n8-20020a056402514800b00451319a43dasm9352986edd.2.2022.09.14.02.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 02:48:33 -0700 (PDT)
Date: Wed, 14 Sep 2022 11:48:31 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, John Garry <john.garry@huawei.com>
Subject: Re: [PATCH] iommu/iova: Fix module config properly
Message-ID: <YyGjbz19ub2D9qZe@orome>
References: <548c2f683ca379aface59639a8f0cccc3a1ac050.1663069227.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LhEFjvIk9c/nknZd"
Content-Disposition: inline
In-Reply-To: <548c2f683ca379aface59639a8f0cccc3a1ac050.1663069227.git.robin.murphy@arm.com>
User-Agent: Mutt/2.2.7 (2022-08-07)


--LhEFjvIk9c/nknZd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 13, 2022 at 12:47:20PM +0100, Robin Murphy wrote:
> IOMMU_IOVA is intended to be an optional library for users to select as
> and when they desire. Since it can be a module now, this means that
> built-in code which has chosen not to select it should not fail to link
> if it happens to have selected as a module by someone else. Replace
> IS_ENABLED() with IS_REACHABLE() to do the right thing.
>=20
> CC: Thierry Reding <thierry.reding@gmail.com>
> Reported-by: John Garry <john.garry@huawei.com>
> Fixes: 15bbdec3931e ("iommu: Make the iova library a module")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>=20
> Phrased as a fix for the sake of complete honesty, but it seems
> everyone's been making do for years already so by now it's really
> just more of an enhancement.
>=20
>  include/linux/iova.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--LhEFjvIk9c/nknZd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmMho28ACgkQ3SOs138+
s6EHwA/8C45u4Kc3+4y3O4DYuTVJSS+dM596uWeku6R8KW5q4zZ/OYZWkagYzw6d
jIJQks0KHx/OAvEFLcfjbVURPbOeaXU+Q1Wa/og4mqDfiW0ALAlor8UrXXvYBmUo
sI+w0L8MQWrTSV4g5lbP0clgmiQ8bItFdJzPVMraO2B5Bm7i1wmYamaZRUdSWSJb
qOEAsWW2yBh3LLSZFVoUnLEGb2OKFYvWmomGAiKWPhWLrLfTWeWQM3eYzq38yCDn
JIunl/S+VKLsWmSrfhaCsvXu8+Hm3LbuTuFWjuFcrQ5R91i3tMr5Vb8WgXOSo4KE
I24xBaPYQuPSh7LUsSGxVoepf3maD5iG1zCFqvBPPB1pGkds+2iXaQwtTM3gjRhU
bv4crFyiHxsZHPVV+KLSf3pA9j5a30BVEeEKc+KMvNWOCxuggzGxFzb00wx74PHS
+Lqbl/1VwiyeT8Wp9xMdBZcNbXswbHwL3NpAbScXr24/CHsHZLBrjBKCifKFw/5P
WWlBW7XUCi0T+57QtLoRoiG95xTd0A7Tcx91h+9qluBIv9QDGGAC1+LdQ7L8wJev
UDH8tap7SMMudR83vic7c14tDQwzxMJpRI8EQOiWSs9t8WrdHzgjfgrkZUmfo+e1
y/KAmb+UmVCnpjG00cD8SsCsHm1Esl9cbQqhBSrNcmHGor2jSp4=
=LSgo
-----END PGP SIGNATURE-----

--LhEFjvIk9c/nknZd--
