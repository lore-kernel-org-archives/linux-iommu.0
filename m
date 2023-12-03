Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538BBD26D;
	Sun,  3 Dec 2023 12:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnzinRh0"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6cdd28aa7f8so2853046b3a.3;
        Sun, 03 Dec 2023 04:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701606698; x=1702211498; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0MUy55F2F+wgLbUaq7AQf9HgfhTQk1XTmdlJL+JJNEo=;
        b=mnzinRh0ovIb61yTm8d6Qhzmi/K87b5M9mAC4fbSJ5VgX1KTyLDKttFkxWpMaXO1sd
         61+DRprMpNVWc2BY63lMhJ1S5f7Dxlq7d7COhMdjyMMnNF7ebZbETx1ODLTKCgCa70r1
         A7xZv7nhjTeFo6uN4O0/lDAhQRukEo9QP6yoG8nC+4E2oGD4hI+K4DlqqnyvbQb0n3fb
         hLWb6ojm1w09qWgzOFg709zUCpx7TK7PgebJc+3OyHwuIUWourPBpKmGNDFKWspF82E4
         0I1sv2/JjHiFOxO7lkTZQowNGAI1A9M1rwGRf9MnjxDmTVSBA0n1u/F7lPlesMTvWsjR
         OPmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701606698; x=1702211498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MUy55F2F+wgLbUaq7AQf9HgfhTQk1XTmdlJL+JJNEo=;
        b=QCgiwJqUQqWri+AOoy23hPs5Q/uVDMvtjDq+hk8HIbSuipckZbwu2ziTZNQWSNfflL
         u2sfEhZMyAYELQHXxn/c/d2BCvnX9QghDb0THLsZIFdKdtoNzgaUWKzqy/lcP2BO3A/p
         bUk9hnbEpljJayHX9XwKRRY8nLQKGiUn+OJ6gWq+cd0bCf3pWy8stR3XUaI6qgxc+NA0
         zpn5DveX0gJMZsDryeIjxSiH5UnHRSZupIhZwvxyggYHv2blmeiVNBlnA9i5lNyUJTLx
         Hb14REsu2K5AI8U5VPx5GQXnvQgUI5LGC3geZBgpV1xaBW6fuYpmcBfWWNBIrf7cb+tj
         FHdA==
X-Gm-Message-State: AOJu0YzPDW2A9GD34tlO/0pn8JsH1rdmFC8L1nydbkrHr+iu0qKqAaoc
	p+9kFK9xmKUvRVoYTFu/orE=
X-Google-Smtp-Source: AGHT+IHmLadSlZkgkEbu7BCMhHy54Dhejaw4nkpOT9L4Al3PzBof4xcJ8kA+G2XiA2o5lw1MMiqVvg==
X-Received: by 2002:a05:6a21:81a9:b0:18b:cd15:b832 with SMTP id pd41-20020a056a2181a900b0018bcd15b832mr777612pzb.42.1701606698415;
        Sun, 03 Dec 2023 04:31:38 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902b94c00b001c613b4aa33sm6529854pls.287.2023.12.03.04.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 04:31:37 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 8AE2D1033EDE8; Sun,  3 Dec 2023 19:31:28 +0700 (WIB)
Date: Sun, 3 Dec 2023 19:31:28 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	Linux IOMMU <iommu@lists.linux.dev>,
	Linux Power Management <linux-pm@vger.kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Michael Kelley <mikelley@microsoft.com>,
	Oleksandr Natalenko <oleksandr@natalenko.name>,
	Helge Deller <deller@gmx.de>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, kbugreports@proton.me
Subject: Re: Fwd: Kernels v6.5 and v6.6 break resume from standby (s3) on
 some Intel systems if VT-d is enabled
Message-ID: <ZWx1IHBE9KCk6rWj@archie.me>
References: <4b3c624a-f114-4e39-9e1c-0df18f307e8c@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dO/hfGGfuReF84Ss"
Content-Disposition: inline
In-Reply-To: <4b3c624a-f114-4e39-9e1c-0df18f307e8c@gmail.com>


--dO/hfGGfuReF84Ss
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 08:09:24PM +0700, Bagas Sanjaya wrote:
> Hi,
>=20
> I notice a regression report on Bugzilla [1]. Quoting from it:
>=20
> > Note:
> >=20
> > I'm just a Linux user, I don't work in IT or even write code, so, I'm p=
robably using terms to describe the issue that are not the ones someone who=
 knows code and what the system does under the hood would use.
> >=20
> > Affected system:
> >=20
> > Thinkpad, Intel Kaby Lake (i7-7600U) chipset / cpu and onboard gpu (Int=
el HD 620), no separate graphics card, current bios firmware; running Void =
Linux, xfce / lightdm
> >=20
> > Symptom / problem:
> >=20
> > Since the upgrade to kernel v6.5.5 (from v6.3.13) my system doesn't wak=
e up from standby, i.e. resume from s3 fails 100% of the time.
> > When pressing a key or the power button nothing happens. The LED that i=
ndicates different states of the system, keeps indicating standby mode.
> > The only way to use the system again is hard reset by pressing the powe=
r button for a few seconds.
> >=20
> > So, there is no crashing on resume or incomplete resume or only sometim=
es failing to resume or failing to go into standby in the first place.
> >=20
> > Granted, this issue was present with kernels before v6.5, but only occa=
sionally and it would not re-appear for many many boot cycles. So, I never =
had any lead as to why it would happen.
> >=20
> > I installed kernel v6.4.16 to test for the bug - it's not in there.
> >=20
> > For further testing I also installed kernel v6.5.2, as this was the fir=
st kernel of the 6.5 series available on void linux, (and because the kerne=
l logs mention VT-d for kernel v6.5.5 and v6.5.3, see below). Result: The b=
ug is already in v6.5.2, too.
> >=20
> > There's only one thing I noticed from comparing logs between kernels v6=
=2E5/6.6 vs v6.1/6.3/6.4. In the moment the system goes into standby, if ru=
nning one of the latter three kernel versions the system would print the fo=
llowing messages:
> >=20
> > [elogind-daemon] Entering sleep state 'suspend'...
> > [kernel] PM: suspend entry (deep)
> >=20
> >=20
> > But with kernels v6.5/6.6, the kernel message is missing, only the elog=
ind-daemon message shows up in the logs. As if the kernel didn't get the me=
mo and thus didn't prepare and didn't listen for the wake-up call to resume.
> >=20
> >=20
> > To see, if this is a bug that might be tight to a certain chipset / cpu=
 generation, I tested kernel v6.5 on my old Thinkpad (Intel Sandy Bridge ch=
ipset / cpu, and also onboard graphics only). Its BIOS also has VT-d enable=
d. Interestingly, on that system, resume from standby with kernel v6.5 is n=
o problem, even though its system is set up the same as the current Thinkpa=
d.
> >=20
> > So, this bug seems to be limited to certain set of chipset / cpu. Which=
 seems feasible, as I couldn't find a bug report on this - not too many see=
m to be affected.
> >=20
> >=20
> >=20
> > There's an older bug report on similar symptoms, but the cure doesn't w=
ork on my system:
> >=20
> > "intel_iommu=3Don breaks resume from suspend on several Thinkpad models"
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D197029
> >=20
> >=20
> > Although it sounds just like what my system is experiencing - apart fro=
m the fact that term suspend being sometimes also used to describe hibernat=
ion and it is not specified which one is meant in the bug report.
> >=20
> > So, I was hopeful on the one hand that the (workaround) fix (adding int=
el_iommu=3Doff to the kernel parameters) would work on my system, too - on =
the other hand, this bug report was for kernel v4.13, so it's probably not =
necessarily relevant to similar symptoms with kernel v6.5 and v6.6, respect=
ively.
> >=20
> > Anyway, adding intel_iommu=3Doff to the kernel parameters didn't change=
 anything on my system. I made, of course, sure once the system was running=
, that intel_iommu=3Doff was in indeed used as one of the kernel parameters.
> >=20
> >=20
> > With this information in mind I did a regular internet search and found=
 some information that in case intel_iommu=3Doff in the kernel parameters d=
oesn't help, disabling VT-d in BIOS might.
> > And in my case it does indeed help avoiding the bug - for both kernel v=
ersions, v6.5 and v6.6.
> >=20
> > Reading some other bug reports and some changelogs, I noticed that iomm=
u and vt-s are connected, to I posted this bug report in drivers/iommu. If =
it is misplaced here, please feel free to move it to the correct category.
> >=20
> >=20
> > I attached a file with the output of some commands I found being used i=
n several other bug reports on here, just in case they might be needed / he=
lpful.
> >=20
> >=20
> > Thank you very much for your help in advance!
>=20
> See Bugzilla for the full thread.
>=20
> Anyway, I'm adding this regression to regzbot:
>=20
> #regzbot introduced: v6.3..v6.5 https://bugzilla.kernel.org/show_bug.cgi?=
id=3D218191
> #regzbot title: resume from standby fails on Thinkpad with Kaby Lake CPU
>=20

The reporter had done bisection (see Bugzilla for details), so telling
regzbot:

#regzbot introduced: 0c7ffa32dbd6b0

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--dO/hfGGfuReF84Ss
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZWx1HAAKCRD2uYlJVVFO
o9tkAQD39PHo7FdONECmYZXrv+d6mV48M232+oW13+R1CiakrgEA1d/iKH+VFtPl
UK+NIN72mc22rpkszIA/Br5ww/0w0gw=
=tabU
-----END PGP SIGNATURE-----

--dO/hfGGfuReF84Ss--
