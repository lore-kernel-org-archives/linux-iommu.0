Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CDE21CC61
	for <iommu@lists.linux.dev>; Sun, 18 May 2025 14:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747579358; cv=none; b=Xf4O1njSYfcZhuzdwPLqTmRl6pA8sVPJmYPbPEI/x2Mb5wBNl1UQi4GyX5zGXJUoCxO50Us2eTg5W+9iqoyGrtRRWReFRTulJPa120SvDjewYDbuv3XClc1UuMKI8lqpqoTglREJPJApxjDmJwxuAk23VP5WracxaAwwWPNqa9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747579358; c=relaxed/simple;
	bh=rAUybgx3w08Pk16V3V7ElWMaPW68BeTRsRpRxxQzxeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1PO2xylGll94R/nHkgM/fczSfgeBTBNCUPWXd+AIM14ale7NIk1t3FbzhOR1IIuzM8dLLnZMamAhvP7JUocLFXGIPlls+RUyTAAMERX6iyUlcN9E8zgDzkjackaLw8PImIFER/bM7X4RuREbty72vgdZiNPxLtMUry3Nq68AXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Omtsa67x; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Omtsa67x"
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-ad1f6aa2f84so725808866b.0
        for <iommu@lists.linux.dev>; Sun, 18 May 2025 07:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747579355; x=1748184155; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAUybgx3w08Pk16V3V7ElWMaPW68BeTRsRpRxxQzxeE=;
        b=Omtsa67xPi7EK23ysDTicJ5gSSekslLaKTRMEl270ADiwige5LHbf7+yccOHzVm9gK
         w7WeUHpGidu9iMYacLKzuiSepHYDoYTIRTRlmKRK4tNaiqMXdVKtZsjlu3OAJmuZtIzC
         ux+3A+683B4ugFTsfDoVwe5E1fRxfPYz4AMcqwU9yI07q356wIIfEnCjbJYuVyImJtP1
         ClQC88H8Zn03DxyB6VIjlae7xl4Fd9QbqdNzuX8fsB4YbrinT+IGIpS9CEc1t28MXAIP
         HYT0XwfkXOfdFJjBBxf4liBJ5Mmp/sv8w1nJ5NZi4raD6LSFB7QMcj2UR63QzGJRFD1r
         0rog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747579355; x=1748184155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAUybgx3w08Pk16V3V7ElWMaPW68BeTRsRpRxxQzxeE=;
        b=l3He9VueETfsY/iLU/6gK3F9DVcFAABzPOqEKDKqAXOW7FHu9J1oKs/5huemer4Qzg
         zwaoKse2oH9hARBDAfWRQ9Wu3SNg0f5UJctjPTe8+q4DXCKDX6KQWLvB89xIbflEgsVO
         NC/anvI0NItq+riyKJFrSfkUJ/6oPb4gqToj+KVdFGl0WH+RyC0F+VrWFlhj2MBQ4in5
         /gJXLlc0O++ZhsA+XTq6eDKbNvfiWgUZBRnkU/vCG7olhIe7RdRZ4PM5n0ejM/1MFLW4
         MuvW8kdYNGRX6rtYtM5WtwEbTeCsBOwgJIw2W2iThL2kxiAmz31EWYrOT1i+DGhNzUln
         BNzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdoq740MakvqQXNH3ElHr46F06FvwYcWnTsWLYpmw8pSMydhrSDtQIgEc/C7AWHKTWWXj4dg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx190EMK8Jl7jLUuxqU4B+9sVswZwaxs93lcsgIhF4g29MT827g
	nobd/ARew2y1hGSjfJFVXucq9lRs/XtjGYhnKvdaajRynOMyvXa3DJlS5p8pzP8cewy1UFC+BTP
	CrbXLi5MCUDTyJvsaVhfcSCeJ74ckZ+U=
X-Gm-Gg: ASbGncuKW0BlCyzOM426FvGlREzHENXuylNEsuMHtoqPqZlsML0OBtU3h5pKw+qLmI/
	vmV6rrBmcAfznL/pMqGg8cKceDbJfdk3a0eiSB/fmNf+CwC1zPxtQAfyIDCl0f3Gn/hk9rJOSD8
	jEYNyDZhg7XWf1u1HJ0BGGVPrrahvcHA==
X-Google-Smtp-Source: AGHT+IHB++m0GR0lO5TfW8cZq+R6bSxHcLUjm6jGofGJAl2FV1P4JdhTYEzSIBs2qV2FvWjm0WoY9STztiddXe/xN+k=
X-Received: by 2002:a17:907:7d8d:b0:ad5:4998:9f1a with SMTP id
 a640c23a62f3a-ad549a7e5e8mr600457266b.5.1747579354599; Sun, 18 May 2025
 07:42:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <18F9BD47-282D-4225-AB6B-FDA4AD52D7AE@gmail.com>
 <9b18e8e3-f3e2-48d4-839a-56e1d8f62657@intel.com> <03d0db6b-628e-4a5e-8e71-852233b83f60@apertussolutions.com>
 <fbb23ee0-c0b4-4b0e-8861-940f8ceaf161@intel.com>
In-Reply-To: <fbb23ee0-c0b4-4b0e-8861-940f8ceaf161@intel.com>
From: Mike <mikewallacesmith90@gmail.com>
Date: Sun, 18 May 2025 09:42:23 -0500
X-Gm-Features: AX0GCFuU42_TMoi_HKtSGmNW7XrkC1FL6iyDZjOSvOw7NwM1rf6CdCYLar4WcGI
Message-ID: <CAAyYeYjp0v2PYt1owTdOpQD8_NjakquyXbUr5M1a_OWLEKHQ0A@mail.gmail.com>
Subject: Re: [PATCH v14 00/19] x86: Trenchboot secure dynamic launch Linux
 kernel support
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Daniel P. Smith" <dpsmith@apertussolutions.com>, Rich Persaud <persaur@gmail.com>, 
	Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, iommu@lists.linux.dev, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, 
	ardb@kernel.org, mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com, 
	peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net, 
	nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net, 
	corbet@lwn.net, ebiederm@xmission.com, dwmw2@infradead.org, 
	baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com, 
	andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com, 
	Sergii Dmytruk <sergii.dmytruk@3mdeb.com>, openxt@googlegroups.com, 
	"Mowka, Mateusz" <mateusz.mowka@intel.com>, Ning Sun <ning.sun@intel.com>, 
	tboot-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 7:57=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 4/28/25 17:04, Daniel P. Smith wrote:
> >> OK, but why do this in Linux as opposed to tboot? Right now, much of t=
he
> >> TXT magic is done outside of the kernel. Why do it *IN* the kernel?
> >
> > There was a patch set submitted to tboot to add AMD support. It was
> > rejected as tboot is solely focused on Intel TXT implementation.
> >
> > This meant I either had to go the route of yet another standalone loade=
r
> > kernel or do it in the kernel. Doing it as an external loader would hav=
e
> > required a new set of touchpoints, like the one you are highlighting. A=
t
> > which point, I am sure I would have gotten the question of why I didn't
> > do it in the kernel.

Will this cause any patent infringement issues in Linux [1]?

1. https://patents.google.com/patent/US9075995B2
