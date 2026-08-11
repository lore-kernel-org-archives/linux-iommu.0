Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A0A45C6F7
	for <iommu@lists.linux.dev>; Tue, 11 Aug 2026 17:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786469333; cv=none; b=dXJNs1NKvK3+iD53U4E83vOQVmQ8loJG+N+tXCZXjNvRkZRkQpxoKt0toaBAqeKBGhm0mILjXnmYHMB7bhU1nJ3ATQQF3Z6i3CXYX6PTRQvxIjpEyuKhMYPvtzkHGREu1qZwIbni5aRBiAM4x9agPhe4Omnoi0Xo+xSPPKVWwQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786469333; c=relaxed/simple;
	bh=tz4iSbZQOmwhQi85QuHBOwwK5bkgkFtPz0AFXWjDfmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sHAG0qugPfli197+pkxltf7HtWRmJ3Yct6nV9tMfrmG85+87beT4PjVUoa1+a/P5FELpMyH6uvaqTgOUN4OB7GKmmrlzSGdmiK0sJXO2Kn9tUv7EglGqDihddVFSmUcUHLGxUI0NpL+Kva52ZjWViBp+01pUYDqpvsCwgC/vPyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0OkDFQd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0OkDFQd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431231F00A3E
	for <iommu@lists.linux.dev>; Tue, 11 Aug 2026 17:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786469326;
	bh=tz4iSbZQOmwhQi85QuHBOwwK5bkgkFtPz0AFXWjDfmY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=l0OkDFQdpboXND6N6MA2YZRG7RfIROUSlsjT1xENiFyKAbZ8w/bv7zeZfO+AFidfl
	 sMQjor2WRO+RNqqlx2Eynzgq4YZ2EVb3hgoRcmmAKqyM/Sz3qj1WY7l9XCGgjuvDJw
	 K56peIq6/MTSgk1grN0Lw+B7yc3ASdvHCDdO+7uhRMPhd1ITWmfmAISyZw3fn+gVAI
	 wVy75Mo4a1Em5kGFjzM0270JjOneXoJKciYa/iD/1dO5e1084jb2GB5EDDoN0fi4zb
	 sgxGE+tjLbGYAoYIGdCIPSq5I9RkRfvXscKomeoZjBAp9w3b7SAlsGf5lG9I+txbES
	 psg0iRYMaQO0Q==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c15e2dab83eso11316266b.1
        for <iommu@lists.linux.dev>; Tue, 11 Aug 2026 10:28:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqSRuNkcDeghssfs0EWSayQiibtycDSxcqT/bog9E5SrOqgj8eaNEvEXFzX8iuGtYYjz7jLPw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzqlayWV+iiBTfIuVBX4mM5IINthlBGghJX2m4f9q5SvhbGCIKk
	8JlZK0TNB8Mbm8eZvoW72Mk2IN4tikwjenBuhSC2ID79B18nxVBw1dq7KYxEYcI5ef2xuGN6712
	bcoOQzklFDrsmqCzwIrzFf9gcxJMloA==
X-Received: by 2002:a17:906:7951:b0:c1c:5ec9:1954 with SMTP id
 a640c23a62f3a-c20e6266914mr225672866b.32.1786469324696; Tue, 11 Aug 2026
 10:28:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260724-arm-smmu-v3-instcfg-override-v1-0-e7acf4a8a525@linaro.org>
 <amYIuhYenP4-qHyV@willie-the-truck> <0b7c0272-5506-4aee-82b3-76a78f2b39dc@arm.com>
 <CADrjBPqZFDvyLFpDy1YP9qrMNUCtZYtJhiaDd0iTnmB4ZYO8GQ@mail.gmail.com>
 <20260807224745.GA2180415-robh@kernel.org> <530dbb40-e7e2-4121-a5eb-5f16152fd11b@arm.com>
In-Reply-To: <530dbb40-e7e2-4121-a5eb-5f16152fd11b@arm.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 11 Aug 2026 12:28:32 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLXS=33sDo8iDp-FkxVedqVaOUEemFjK8XuBNTu9KxyxQ@mail.gmail.com>
X-Gm-Features: AUfX_myXX1L5EgRLy36vB46Oy8CB1eR9qmcP-4ps2dCdsR0e5dEIjJ3SLJpQsnw
Message-ID: <CAL_JsqLXS=33sDo8iDp-FkxVedqVaOUEemFjK8XuBNTu9KxyxQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add arm-smmu-v3 support for instcfg data override feature
To: Robin Murphy <robin.murphy@arm.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, Will Deacon <will@kernel.org>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Pranjal Shrivastava <praan@google.com>, Daniel Mentz <danielmentz@google.com>, 
	Mostafa Saleh <smostafa@google.com>, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	tudor.ambarus@linaro.org, andre.draszik@linaro.org, willmcvicker@google.com, 
	jyescas@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 1:03=E2=80=AFPM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 07/08/2026 11:47 pm, Rob Herring wrote:
> > On Fri, Aug 07, 2026 at 04:25:11PM +0100, Peter Griffin wrote:
> >> Hi Will & Robin,
> >>
> >> Thank you both for your review feedback.
> >>
> >> On Mon, 27 Jul 2026 at 11:53, Robin Murphy <robin.murphy@arm.com> wrot=
e:
> >>>
> >>> On 26/07/2026 2:16 pm, Will Deacon wrote:
> >>>> On Fri, Jul 24, 2026 at 01:39:41PM +0100, Peter Griffin wrote:
> >>>>> These two patches add support for a new "arm,instdata-override" DT =
property
> >>>>> that enables the override of the instruction/data attribute of inco=
ming
> >>>>> traffic to Data by setting the INSTCFG override bits.
> >>>>>
> >>>>> It is intended to be specified when the smmu can't guarantee that t=
hese
> >>>>> attributes are provided correctly from the client device.
> >>>>
> >>>> This is going to need an in-tree user and a much more detailed
> >>>> description of what is being worked around before we consider this f=
or
> >>>> inclusion.
> >>
> >> Regarding an in-tree user, I haven't sent the Device Tree (DT) patch
> >> yet for Laguna SoC which adds the smmu nodes and this property because
> >> 1) I want to land the initial SoC/board DT first
> >> 2) I want agreement on the DT property name. Currently I used
> >> "arm,instdata-override" which is what downstream used. However, since
> >> this is intended to work around silicon errata something like
> >> "google,lga-instcfg-data-override" might be more appropriate?
> >
> > Shrug.
> >
> > Really, this is why we want SoC specific compatibles so work-arounds ca=
n
> > be added without DT updates. But we've generally avoided doing that for
> > SMMU for whatever reasons. Just make the property clearly sound like a
> > mistake, not a feature you might want to use. I'd keep the arm prefix
> > just so the next vendor thinks they can't use 'google' and creates the
> > same property with their vendor prefix.
>
> I dunno, I'd be inclined to keep it more vendor/SoC-specific and tied to
> the problem more than one (of potentially several) specific workaround -
> if we did ever want to support using the INSTCFG/PRIVCFG/MEMCFG
> overrides per their full architectural intent, they are per-StreamID
> controls so as such would really want to be encoded in an additional
> #iommu-cell (or at worst maybe a property on the client device node).
>
> Frankly for a workaround condition to just blanket-apply to every SMMU
> instance in a particular SoC, I'm honestly thinking that just whacking
> an of_machine_is_compatible() in the driver isn't necessarily the worst
> idea either - after all we do already have the ACPI equivalent of that
> for some of the HiSilicon stuff, it's just hidden in the IORT code (and
> OK it's used for the SMMU PMUs rather than the actual SMMU devices
> themselves, but still...)

Unless we need to avoid a DT update, I'd prefer adding an SoC specific
SMMU compatible which can use match data and avoid DT updates on
future quirks rather than using of_machine_is_compatible(). I view a
driver using of_machine_is_compatible() as a last resort.

Rob
