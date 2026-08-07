Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DB12F30;
	Fri,  7 Aug 2026 22:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786142867; cv=none; b=kTjDtwb8P3OoXWACDCdMejJSlll63h4rAjTxjncARBvcpcuoY+9a05DyNTZzP9IoO99b4Ae/jZfB6PO9F5Ex6halQ3lqXMIhuSXJ/JjTLO09XpGXIZ2ucGaFJeDDdZHm6/hlHvaCAzTHDKnIgszREaZZt9CKCc3NhiL5dJn13Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786142867; c=relaxed/simple;
	bh=m/t7YNqLN4lhCBPIGyQW4TrxhazrR3WzxP//FdWq1M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgGhGpjQYn2o3JX9Z3AYqNL8NUi18gILVOrqnpqGToHwur7f127bBBVXRj9TJhKyWGEubtFJQkM+yt/jv+3jB0jWrvJuCl6O9H/Vsy62JtefZYnwHus1YDuFWr3/fcM414kukmcwetZvt9c2lRf7Pi586ipZ2xA/5RFls3HBKr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7n/Obi+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7n/Obi+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445701F000E9;
	Fri,  7 Aug 2026 22:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786142866;
	bh=gvBLabH+gYeCjXmeaZJWzRhHmO5itOeocUvJaUv2bxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G7n/Obi+qKguJL2eOLzNdgfLdfqf4Z5r6c3RtgIH/ZyzX6gq6OcpfnhKYa2BQseMf
	 26y5CXyHWj0QoBuMofdXUvZ6YnWPFXGiHeE8aQoRFtSH/vdrHQhxXBl74YvD5W8LTs
	 sTFZ06J4vMsbS6kZwWhtsSaHeLrOzweQ4SLfb5xsPUbNrKHCUWsh+kdjsHo/3fgt9s
	 U1QabgrAF5nrwMkRWxt6lJBEAiuXauuzPWozhJUA6usmDuJ4yL4vn/pYLkU3nw8MmC
	 XMsoNohyJVsdvyJcnHzBG8BpjyFuMBHS0GtY94w5ImpPGDtfA0ffmQyguR0vtw2hoo
	 vEf+Ka74WBetA==
Date: Fri, 7 Aug 2026 17:47:45 -0500
From: Rob Herring <robh@kernel.org>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pranjal Shrivastava <praan@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@android.com, tudor.ambarus@linaro.org,
	andre.draszik@linaro.org, willmcvicker@google.com,
	jyescas@google.com
Subject: Re: [PATCH 0/2] Add arm-smmu-v3 support for instcfg data override
 feature
Message-ID: <20260807224745.GA2180415-robh@kernel.org>
References: <20260724-arm-smmu-v3-instcfg-override-v1-0-e7acf4a8a525@linaro.org>
 <amYIuhYenP4-qHyV@willie-the-truck>
 <0b7c0272-5506-4aee-82b3-76a78f2b39dc@arm.com>
 <CADrjBPqZFDvyLFpDy1YP9qrMNUCtZYtJhiaDd0iTnmB4ZYO8GQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADrjBPqZFDvyLFpDy1YP9qrMNUCtZYtJhiaDd0iTnmB4ZYO8GQ@mail.gmail.com>

On Fri, Aug 07, 2026 at 04:25:11PM +0100, Peter Griffin wrote:
> Hi Will & Robin,
> 
> Thank you both for your review feedback.
> 
> On Mon, 27 Jul 2026 at 11:53, Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > On 26/07/2026 2:16 pm, Will Deacon wrote:
> > > On Fri, Jul 24, 2026 at 01:39:41PM +0100, Peter Griffin wrote:
> > >> These two patches add support for a new "arm,instdata-override" DT property
> > >> that enables the override of the instruction/data attribute of incoming
> > >> traffic to Data by setting the INSTCFG override bits.
> > >>
> > >> It is intended to be specified when the smmu can't guarantee that these
> > >> attributes are provided correctly from the client device.
> > >
> > > This is going to need an in-tree user and a much more detailed
> > > description of what is being worked around before we consider this for
> > > inclusion.
> 
> Regarding an in-tree user, I haven't sent the Device Tree (DT) patch
> yet for Laguna SoC which adds the smmu nodes and this property because
> 1) I want to land the initial SoC/board DT first
> 2) I want agreement on the DT property name. Currently I used
> "arm,instdata-override" which is what downstream used. However, since
> this is intended to work around silicon errata something like
> "google,lga-instcfg-data-override" might be more appropriate?

Shrug.

Really, this is why we want SoC specific compatibles so work-arounds can 
be added without DT updates. But we've generally avoided doing that for 
SMMU for whatever reasons. Just make the property clearly sound like a 
mistake, not a feature you might want to use. I'd keep the arm prefix 
just so the next vendor thinks they can't use 'google' and creates the 
same property with their vendor prefix.

Rob
