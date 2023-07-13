Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C1E6117
	for <iommu@lists.linux.dev>; Thu, 13 Jul 2023 07:23:50 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-51de9c2bc77so412525a12.3
        for <iommu@lists.linux.dev>; Thu, 13 Jul 2023 00:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689233029; x=1691825029;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2smSIC6Mx2KRuBQW3mY2Yb4bW79lOcDBYxUDHm0cCk=;
        b=UEbHeTJbZ7LyKuvjSWRk1VpJ+YgIkM7PpaFfowtm55Ej1jcmkh+TuENe4EQMwTcBF+
         oYfZ3yhd/iGtc/m1ONfnaYI82MKYqqlBfk+ww6ydh8i7AJ22REU4kJhQ2svjjDVp+SZN
         K7jetlEVrziajYXMuJKGNHgKqmgX0m1aPDfnnSRF1Iul5N7ySD1ye6iESNzt4wRkibil
         VUZImgiiCk+BmkBOiodWYrWyNR3h7v+A35x+Sm9WVIU/WJe95mC3s6AEq/AJnZk2WpW6
         4yv0RwkU7Dpg3g3kMArpTI1ITBL5YDDnHOGLsKnMUMpGGXZI8K9TSAOs+dcPOarzOnEz
         3I3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689233029; x=1691825029;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2smSIC6Mx2KRuBQW3mY2Yb4bW79lOcDBYxUDHm0cCk=;
        b=UY81XJP/eebKaO+YDmvy0G3MEdvEX5oVvuQmM9m2+YFUhIzrHT4huGvVAUTlpl1IaZ
         mBoEKltjH7+G3LUJ8YIkJOlmr8BmqloEdO5eCafyU1yQNQW/eGHtIdjAMqj+xgkUI9JX
         Re/hIQIhn3VjnbiHZgd9W48/RIRvIwEbKdx5KIYIift5LCYowYBpOlrTzofKY7CGume9
         5DqXiCjwVuoQPzgUwhIZH58fH7RIZnoXfJyPJKEuZwq6lCJL8zXRMwgFxcH7P/WP9Pgh
         UB7ci5YUIWHWKb9W61aeRt3wIYGJ99GyFL1IvnhHyksf8TSqKRaP9DApXlKKWwkY8VZz
         pZZA==
X-Gm-Message-State: ABy/qLZ83cyaQa3K/pDpe+HQtBJSs9Ytct/hiYAFGKfwoaTvZTPV5Lpt
	lgES2KcJfgFJda4wg0NHTSs=
X-Google-Smtp-Source: APBJJlH/V3c8kH8fWRfoVqeUd4He7ZuLqIRUfMKRDtHQtMkd9sYqGd5NZLZM61W1OSMe1QjvoAlS6g==
X-Received: by 2002:a17:907:985b:b0:982:cfe2:32fe with SMTP id jj27-20020a170907985b00b00982cfe232femr669996ejc.63.1689233028794;
        Thu, 13 Jul 2023 00:23:48 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id f25-20020a17090624d900b00992316f0690sm3571611ejb.74.2023.07.13.00.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 00:23:48 -0700 (PDT)
Date: Thu, 13 Jul 2023 09:23:46 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Minjie Du <duminjie@vivo.com>
Cc: Krishna Reddy <vdumpa@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	"open list:TEGRA IOMMU DRIVERS" <linux-tegra@vger.kernel.org>,
	"open list:IOMMU SUBSYSTEM" <iommu@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>,
	opensource.kernel@vivo.com, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v3] iommu: remove redundant parameter check in
 tegra_smmu_debugfs_init()
Message-ID: <ZK-mgtHQQkDxkVqq@orome>
References: <20230713071902.9007-1-duminjie@vivo.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wLMCeSBFKkFZ5p/5"
Content-Disposition: inline
In-Reply-To: <20230713071902.9007-1-duminjie@vivo.com>
User-Agent: Mutt/2.2.10 (2023-03-25)


--wLMCeSBFKkFZ5p/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 13, 2023 at 03:19:02PM +0800, Minjie Du wrote:
> debugfs_create_file() will return early if smmu->debugfs is an error
>   pointer, so an extra error check is not needed.

Not sure where the two spaces at the beginning of the line came from,
but they don't belong there.

Thierry

--wLMCeSBFKkFZ5p/5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmSvpoIACgkQ3SOs138+
s6EvshAAiJBn5EfHfP6glGtjvawsr+NfMraodhNfMmfA8n2I8P8eruokHKamOTaQ
N+byvxO7+oR4kZ+4vpn9ZPp4eI24LJzPz2wg8fqUcb4eaoUcOHPczUe/lIHJt6t7
bOp7pwSgPqc0YMe+bIXa2EwUzxw2qAV4M2W7CpL7+i16kFMk4dtRKhsU5BBw2uYN
wU1pryJnLUho8kB+Da3P32+sTD+8288hs7JZ8aj6JzUe+x4BJGWfkoUoj4EqFs/x
L4bdIaFsqsQ/1lr2CP7B/sb7h5Z1GByfbw+gJa92/3sYu8FAaeaXyHYorlj5aUUD
mVgDw9s+r+oc1S3jTinubNZ3O9FkQAURFBnWBlqGHbW2Zfsuhr6ABwjKt7Xjdq/v
qSYnTyuzGoHScIHF/pXd/1lN7e8bNH0c49bO+gd9OuJ2SxfKBqANGLgz8LZGGzkT
irW9FT0zuQ+YUkYbPEvW4TzJjP90Rz70n9kQvkl/8WEWAG8Ka2gBarNWFN+/HgTs
m2x4CT13QuT1NWEp+SIi67KYcBIAPJEB3Q1jWXSkS6D2X0/+eCax9FLlrREEm3bl
XzIdpgv0yw+dE6fI3VD2V11CNsaHiqPpG0w03R8LOeiKnc7pkc4RhGM0ngC0SQWl
0omANMnOkxKmBNXuksgCagQjYlBgWj3vSvo8vllACp3tpPXawpo=
=UiJF
-----END PGP SIGNATURE-----

--wLMCeSBFKkFZ5p/5--
