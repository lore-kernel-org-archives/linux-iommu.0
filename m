Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165EB35D5F7
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 15:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769526616; cv=none; b=TwWgbTJJZxbbx1W+akSMPQsv6x1URaQyIGeiwDYFrKHhHNq2gt5E3HL1G3NmDHHM8TyTYpQIvJReNWTjLH/uxGcMaBxidKhrhh6rbbOJUeGC2Sl0FBToCX+7S4B88tajkMMZbdaahbZBgTP98Qk3y7y7cZT05qAQ1mkC+k4j2UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769526616; c=relaxed/simple;
	bh=V2NzastbFhpzOzHM5nA+miN7xKYKTp/1Xy8T6Y+6Cv0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p/HNGjOTk6i4pubWWEmUcgu0HCAEzSmUUc9SMEAxl5sjV8BjF3+n5D3ojs0P32Naf5y4KN0owp11p8REHyEFkAaQ6CAztm4IFOYY/kRIULi6xbM3ECDDzpk5Y1JDiQYktvGkecFckPOeDtiIeabq7/nTLx/cYdr22/BkziuFn3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=eKCt8/kn; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="eKCt8/kn"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-502b0aa36feso70103521cf.1
        for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 07:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1769526612; x=1770131412; darn=lists.linux.dev;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OhCrE4/omd3Aqh9ad+ieSaeycC5AgJDDUBgsMqT4cBk=;
        b=eKCt8/kn27rjdXzV1wxLtB2CUo0sWgNxrvuS1I4yTGJU6jauKz4o91Fy3RNo2LwiA/
         jc9Nj4OApbhSjqdF54iUowYCPzGsOkKiePdawF6FRyiAzJ3DdjcPeF6SFFmrXAB7y4cj
         IrfZfC8roi+BSrvbTtNRIfwXbikcI7HgwoTpvZzM6excGc1DI2u7HeIDouGFobdGhr0V
         lk1jr8RBUaIVIiLQaB3oTHjtHpahKprcImPooWgnWPYttZ8pOvhv+cSGWRJL5lLToC+P
         FNCTqk+rDCWbwyWii+xsx/NoQsB8ulS0BkMiJqkNOpyQ0F63MvkJu4VkMNW5J9eDVK3U
         1/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769526612; x=1770131412;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OhCrE4/omd3Aqh9ad+ieSaeycC5AgJDDUBgsMqT4cBk=;
        b=wx/AzMbvaONBlPZLrppEhdUGZFdVG1jREL2Mh0LHDwFH9gVG6tgMLjS6b9qntANrJW
         HMjqmLQ9c4eOQ40hKDp6Ur0k9SKIkSYVXapIWZmxMp9cEs0VmLNvg3uKaWkaMLHDcsWi
         P7nON10X8zXASV5RFjM0U9quJ7AOnXYX0oCnGWZVvIvQFk1F44sM8uDs9LRSOp9G9tBV
         BSSkA6/ZpGoYrvIqQKv1y+2k6ULDTVj4miiJi4tmp9N+WN4Vl6uhz2mad0d/D/8KDbnO
         BOuleFoRXOFY1jYIOA2NVzWzcYomgYpeT5/QWE8rLsfoLmmVt7ywS9NQt8Knjm719dCM
         9AhQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3bbjnngptvagmZkUrcWDryyaW0HkBTnCHiuujfiJGqqdVZxFF/HKAFTRfaCV40hdc25iV9g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxyTJXg7thK/TrBfZcWaMBT7oQJIyDeZz9CljoFMVKYX56uoQNO
	+cpNVusuoTILQm156UO8DBHTvMOc2RMO4y75Uh0BiT3IpaiHT3kt0RtGGDEDrSUmrqA=
X-Gm-Gg: AZuq6aIm6jL6h09WVttC2OF5LAfonsYqmQmEizWrx/gV7V1qYF6hU7Vl1M4alzxb90r
	KDWPCcLDu+gtTWtzX+sumD8TjJRigZ6KvHfNSBVYIaWdzLOf0FwqRpdjGu06rul3F5+57nlBLoa
	Q5UbOlmc7H6wGUHcrXEPRwXXBNKlpsOOd4TAtn4AhcoVyOrf1ywj8NOY4/qjeffAAtwXQwpJoe6
	iHn2+Vde4J5pFoEio2ufqj2yB1vbdia91X9rStz1NSnozIVYWrQLA5IBawx4POULZMVKqOLgnK+
	rIYXL2qfppi8jwBhfXucQ+6nMqx6JlTewKmY7w+4VtNZSYSkO3Vw/0mNx+PZtT3Z8MOy6iuHCwb
	Cd3asfid4AaP6EpSsRFl2sq4rcjQKiVIX7qAwllV2shT2Rr1ZMQQlaqGD0Z5FZ0Xl+fYmI1/w0O
	M9bkcpyoaJ1ngn65qY
X-Received: by 2002:a05:622a:592:b0:501:45d7:10cd with SMTP id d75a77b69052e-503301175d8mr21471091cf.20.1769526612072;
        Tue, 27 Jan 2026 07:10:12 -0800 (PST)
Received: from ?IPv6:2606:6d00:17:7b4b::5ac? ([2606:6d00:17:7b4b::5ac])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89491841640sm113651406d6.17.2026.01.27.07.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 07:10:11 -0800 (PST)
Message-ID: <df2d7dcc31c9a47752a1d58efdd7a416311e55ec.camel@ndufresne.ca>
Subject: Re: [PATCH 0/7] media: iris: add support for kaanapali platform
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Vikash Garodia
	 <vikash.garodia@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, Abhinav Kumar	
 <abhinav.kumar@linux.dev>, Bryan O'Donoghue <bod@kernel.org>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Saravana Kannan	 <saravanak@kernel.org>, Joerg
 Roedel <joro@8bytes.org>, Will Deacon	 <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Stefan Schmidt	 <stefan.schmidt@linaro.org>, Hans
 Verkuil <hverkuil@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Vishnu Reddy <busanna.reddy@oss.qualcomm.com>, Hans Verkuil	
 <hverkuil+cisco@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Bryan O'Donoghue	
 <bryan.odonoghue@linaro.org>, Charan Teja Kalla
 <charan.kalla@oss.qualcomm.com>,  Vijayanand Jitta
 <vijayanand.jitta@oss.qualcomm.com>
Date: Tue, 27 Jan 2026 10:10:08 -0500
In-Reply-To: <vv4stkmrrwdqmbnpv7pg5nd4immtqo5iplwbcia3oykycfmg2m@dsithotfy5ls>
References: <20260126-kaanapali-iris-v1-0-e2646246bfc1@oss.qualcomm.com>
	 <lpgw6eodclsvfwgvtljfiorvjkpd5vd27yhxs7i3ijfibaqzuk@bak2lwbyh77f>
	 <2d4632b2-916a-4eda-ad08-44af68461dc8@oss.qualcomm.com>
	 <vv4stkmrrwdqmbnpv7pg5nd4immtqo5iplwbcia3oykycfmg2m@dsithotfy5ls>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual;
 keydata=mDMEaCN2ixYJKwYBBAHaRw8BAQdAM0EHepTful3JOIzcPv6ekHOenE1u0vDG1gdHFrChD
 /e0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPoicBBMWCgBEAhsDBQsJCA
 cCAiICBhUKCQgLAgQWAgMBAh4HAheABQkJZfd1FiEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrjo
 CGQEACgkQ2UGUUSlgcvQlQwD/RjpU1SZYcKG6pnfnQ8ivgtTkGDRUJ8gP3fK7+XUjRNIA/iXfhXMN
 abIWxO2oCXKf3TdD7aQ4070KO6zSxIcxgNQFtDFOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzLmR1Z
 nJlc25lQGNvbGxhYm9yYS5jb20+iJkEExYKAEECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4
 AWIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaCyyxgUJCWX3dQAKCRDZQZRRKWBy9ARJAP96pFmLffZ
 smBUpkyVBfFAf+zq6BJt769R0al3kHvUKdgD9G7KAHuioxD2v6SX7idpIazjzx8b8rfzwTWyOQWHC
 AAS0LU5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPoiZBBMWCgBBF
 iEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrGYCGwMFCQll93UFCwkIBwICIgIGFQoJCAsCBBYCAw
 ECHgcCF4AACgkQ2UGUUSlgcvRObgD/YnQjfi4+L8f4fI7p1pPMTwRTcaRdy6aqkKEmKsCArzQBAK8
 bRLv9QjuqsE6oQZra/RB4widZPvphs78H0P6NmpIJ
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-fIhbK5YC4Jyx7+92/gYN"
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0


--=-fIhbK5YC4Jyx7+92/gYN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le mardi 27 janvier 2026 =C3=A0 13:52 +0200, Dmitry Baryshkov a =C3=A9crit=
=C2=A0:
> On Tue, Jan 27, 2026 at 04:56:34PM +0530, Vikash Garodia wrote:
>=20

[..]

>=20
> > =C2=A0- 4 testcase failed due to unsupported resolution
>=20
> Can it be fixed?

Its nicer if you name the failing tests vectors. I can guess this is
PICSIZE_{A,B,C,D}_Bossen_1 by experience, but not everyone will guess. HEVC
level impose a limit on bandwidth, not on resolution. These files are eithe=
r
very large and small height or the opposite. One of these is just 4K in por=
trait
mode (that is more concerning). Though, there is a V4L2 limitation for this
aspect, since we advertise the resolutions by range. Most hardware is desig=
ned
to support 4096x4096, in that casse that's what you should expose as limits=
.

Though, some hardware do have dynamic sizing capabilities (like RKVDEC HEVC=
), in
this case there is not much you can do, you have to find the right trade of=
. But
since you expose LEVELs, I think its fine to overshoot a little. Both
constraints should ensure it works with valid streams.

>=20
> > =C2=A0- 2 testcase failed due to CRC mismatch

These are clear example of "no one can guess".

>=20
> Which means an error in the testsuite or somewhere on our side?

The testsuite fully pass if you run using Franhofer reference decoder. This=
 is
logical since the MD5 has been generated with it.

>=20
> > =C2=A0- 2 test fails due to session error (under debug)
> > =C2=A0=C2=A0 - PICSIZE_C_Bossen_1

Hmm, see, I have no idea which fourth one could fail due to resolution, and=
 that
forth one is likely a bug on your side.

> > =C2=A0=C2=A0 - WPP_E_ericsson_MAIN_2
> >=20
> > VP9:
> > 235/305 testcases passed while testing VP9-TEST-VECTORS with
> > =C2=A0GStreamer-VP9-V4L2-Gst1.0.
> > =C2=A0The failing test case:
> > =C2=A0- 64 testcases failed due to unsupported resolution
>=20
> Can it be fixed?

Check if you aren't mixing up constraints between display, coded and alloca=
ted
resolutions. On most hardware, all 3 can differ. The OUTPUT queue should ei=
ther
not care at all, or use it to allow optimistic pre-allocation. But check th=
at
the low resolution constraints is not coming from the OUTPUT queue software=
.

VP9 coded resolution, it always at least 64x64.

>=20
> > =C2=A0- 2 testcases failed due to unsupported format
>=20
> Hmm?

Clarify please, I suppose these are YUV444 (aka professional profiles).

>=20
> > =C2=A0- 1 testcase failed with CRC mismatch (fails with ref decoder as =
well)
>=20
> Could you please raise an issue against fluster?

Check your setup, it fully pass with reference here. The MD5 has been gener=
ated
using the reference.

  ./fluster.py run -d libvpx-VP9 -ts  VP9-TEST-VECTORS

It also fully pass with the GStreamer wrapper, though it had been fixed in
recent GStreamer versions (I'm testing with 1.26.10).

>=20
> > =C2=A0- 2 testcase failed due to unsupported resolution after sequence =
change
>=20
> Can it be fixed?

This one can't be fixed without adding an extension to the V4L2 Stateful De=
coder
spec, like we did for the stateless decoder spec. In order to handle inter-=
frame
resolution changes (a resolution change on a non-keyframe), you have to not=
ify
userspace with the new resolution, give it a way to read back this solution=
,
have CREATE_BUFS() support to allow allocating for that new resolution with=
out
going through streamoff (to avoid looking reference data), and finally, a w=
ay to
remove buffers that are now too small (or too big if userspace wants to red=
uce
the amount of RAM used) through the new DELETE_BUFS ioctl. You also have to
track in your driver the reference buffer resolution/stride.

This is non-trivial with the existing stateful state-machine. You have to m=
ake
sure userspace won't be confused between normal DRC and inter-frame DRC (dy=
namic
resolution changes).


[...]

regards,
Nicolas

--=-fIhbK5YC4Jyx7+92/gYN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaXjVUQAKCRDZQZRRKWBy
9K0kAQD0MAxPQbBuvjXyEOQ54AGTdA6LiPXI/V2NXsiuOOyzsQEA0zSjwWpUUgI8
OAbqxNRQbDIJW1n1zkHysWn/LRy5NQI=
=TSG9
-----END PGP SIGNATURE-----

--=-fIhbK5YC4Jyx7+92/gYN--
