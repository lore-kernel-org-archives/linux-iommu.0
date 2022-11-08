Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F392CA2;
	Tue,  8 Nov 2022 03:45:19 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so12281184pji.0;
        Mon, 07 Nov 2022 19:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qckFeD/Pt+sjt3ZlSfmlazZQAbxsJ1ktBLsagW6IgrQ=;
        b=FH9VAzFoXUR46qDebGlu3fcJnK6+nfGW4qTxltGPb6jzH3adwTNgTYkarxOUiNIlVO
         8ONzopdMsT3HUr26AGwrr9HvIg2iNaLFMz8QRpOdIqGaNX3fdM174GJuvGX3030eiTh1
         q7cpasGEeVPpB1eDaw9JREPbNBd65Ezz+Pfw/ZIztSwL847bk2FFrtlHrazQInx0eHf5
         RuhcW6K85YkWY25fnBJZowCCzFOEkCGNNpO5Kv7rDYPvig7cI/smneUMCUe8j6ZkDoxN
         6LJl0pEsUl4RojdAG7FQ8yyJLK3ybfAD8CgYw/FzDj8yVMpvDbkt2M53CNm3TKyeGKfm
         /Itw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qckFeD/Pt+sjt3ZlSfmlazZQAbxsJ1ktBLsagW6IgrQ=;
        b=k1wHh+G35dUXHjDXBlBHmBHK7E2YmbZin5pQsjdMFHN5P6bdF3ZWqCPpg6XgJhiHjS
         ki8Lq1BYsprDdT0CcWNh2z8niDgwI4YBn2hr5GnPPqssDsUD3J1PpAWNcp3wWMviwbmM
         8jEXxQmrxhQc1BXM5ExSRD7xTwg8wEnyZYyxTRfF5NupGi2k34LPiUU5DtNN7LEXIzbl
         xJDntyjHTYhMwdqieXYSppjuWMt0SlJ4h/C37MAmeiejdzoXHrLsikfPmzkdv9ROk/SG
         TJ/ZPY5UNYT7DN557MYvLobkh5z3CmhN0PHIvtg4bxLL6apG5Gg4YepuDroqFwsaeXGd
         q7XA==
X-Gm-Message-State: ACrzQf1C8KQF1Vv4SPmaM3sQ/Bqm5NgsnLPSt/NhAG8JHXUlV4936gKv
	BE8svUspUAzhXoM9k+oQoh4=
X-Google-Smtp-Source: AMsMyM5tBTqgUASBPjV21N8H6J2m+peEz7OGJWQsDcGg1rbGeXDb0doOv+V8wKJ1pTFS9FnJWBBTCg==
X-Received: by 2002:a17:902:c94a:b0:186:e68a:9aad with SMTP id i10-20020a170902c94a00b00186e68a9aadmr53540653pla.72.1667879118728;
        Mon, 07 Nov 2022 19:45:18 -0800 (PST)
Received: from debian.me (subs02-180-214-232-93.three.co.id. [180.214.232.93])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090322cf00b00176d347e9a7sm5752203plg.233.2022.11.07.19.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 19:45:17 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
	id 1B5A51038C6; Tue,  8 Nov 2022 10:45:10 +0700 (WIB)
Date: Tue, 8 Nov 2022 10:45:10 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: bpf@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Eric Auger <eric.auger@redhat.com>,
	Eric Farman <farman@linux.ibm.com>,
	Jason Wang <jasowang@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
	Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v4 04/17] iommufd: Document overview of iommufd
Message-ID: <Y2nQxvRQKYtSAfTc@debian.me>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <4-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VlYIyqR9GGcDMQ/y"
Content-Disposition: inline
In-Reply-To: <4-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>


--VlYIyqR9GGcDMQ/y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 07, 2022 at 08:48:57PM -0400, Jason Gunthorpe wrote:
> From: Kevin Tian <kevin.tian@intel.com>
>=20
> Add iommufd into the documentation tree, and supply initial documentation.
> Much of this is linked from code comments by kdoc.
>=20

The documentation LGTM, thanks.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--VlYIyqR9GGcDMQ/y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY2nQwQAKCRD2uYlJVVFO
ozsKAPwOuRyOmFizFmjuooe/gexDrhdGHJSdBsMEQGnAYJfwKgEAsJqlXtWAwodg
hHXROiqV7JqrnspKYDSIglvCm5IePAc=
=NHaN
-----END PGP SIGNATURE-----

--VlYIyqR9GGcDMQ/y--
