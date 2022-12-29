Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40979399
	for <iommu@lists.linux.dev>; Thu, 29 Dec 2022 08:38:34 +0000 (UTC)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 31BDD1C09F6; Thu, 29 Dec 2022 09:30:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1672302650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GMDiP+si500La00phNcMqFDqIk07ZuaffuXl6TOuXZk=;
	b=hreBY2Gq0qPdVV2AreCvib6znrR+veQn1XOcjer0BGSek7nBorfHy6PV3r6geAMyF4RJPR
	GcW1vrsHK6cVVfsIysL8GTR+Gdakje/O8QKG/HSFjWyjMQU1LG3teBsW6NYHF7Bg8R10yH
	RE/j7iwL7oq4Qo381iDimzr4wrPrCyY=
Date: Thu, 29 Dec 2022 09:30:49 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Peter Zijlstra <peterz@infradead.org>
Cc: torvalds@linux-foundation.org, corbet@lwn.net, will@kernel.org,
	boqun.feng@gmail.com, mark.rutland@arm.com, catalin.marinas@arm.com,
	dennis@kernel.org, tj@kernel.org, cl@linux.com, hca@linux.ibm.com,
	gor@linux.ibm.com, agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com, svens@linux.ibm.com,
	Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	joro@8bytes.org, suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
	Arnd Bergmann <arnd@arndb.de>, penberg@kernel.org,
	rientjes@google.com, iamjoonsoo.kim@lge.com,
	Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-s390@vger.kernel.org,
	linux-crypto@vger.kernel.org, iommu@lists.linux.dev,
	linux-arch@vger.kernel.org
Subject: Re: [RFC][PATCH 04/12] types: Introduce [us]128
Message-ID: <Y61QOe8XG5sUAXoc@duo.ucw.cz>
References: <20221219153525.632521981@infradead.org>
 <20221219154119.087799661@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fTFbN55brR9qMT+p"
Content-Disposition: inline
In-Reply-To: <20221219154119.087799661@infradead.org>


--fTFbN55brR9qMT+p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Introduce [us]128 (when available). Unlike [us]64, ensure they are
> always naturally aligned.
>=20
> This also enables 128bit wide atomics (which require natural
> alignment) such as cmpxchg128().
>=20
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/types.h      |    5 +++++
>  include/uapi/linux/types.h |    4 ++++
>  2 files changed, 9 insertions(+)
>=20
> --- a/include/linux/types.h
> +++ b/include/linux/types.h
> @@ -10,6 +10,11 @@
>  #define DECLARE_BITMAP(name,bits) \
>  	unsigned long name[BITS_TO_LONGS(bits)]
> =20
> +#ifdef __SIZEOF_INT128__
> +typedef __s128 s128;
> +typedef __u128 u128;
> +#endif

Should this come as a note here?

> Introduce [us]128 (when available). Unlike [us]64, ensure they are
> always naturally aligned.

BR,
							Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--fTFbN55brR9qMT+p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY61QOQAKCRAw5/Bqldv6
8vQtAJ9J9UDlQpqaRV7DVlgZctKi1W8mygCfRehrcFJV2fHBfVb6C4cplLPxxog=
=Yely
-----END PGP SIGNATURE-----

--fTFbN55brR9qMT+p--
