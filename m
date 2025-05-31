Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415A41A2872
	for <iommu@lists.linux.dev>; Sat, 31 May 2025 05:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748668796; cv=none; b=Nsl9JUtVbmi/206laXqe0glwj9Cx4MKPBihV+OIAOmTsJxZWNn0WSaZxVUi9bgDbe8h+7VXQXSQUDTILSxYslflBNI93udE+InXx7SCRrme3HeinV5co7P9Wgd4Qe11yVPar+5sCwD+SeAyWtX30XBCe2xzvyZqbdclWy5aRdBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748668796; c=relaxed/simple;
	bh=ezSk1AScLKA5gqQ1etOOqZ8zKztgHmnwelpnkUWYS0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjXo8kHOuC5Gz6xSNj0FTRfgTZtKipj2AstGnmNx2ykBW6LwFJhlVPEbxMHWOse3AZGX2YNn/ztO2IzxqRUeTsYsTAWn2F45qemS3+hSKqDthzxxBKGgM4pbDY4AVBJy9IIjbf8RJnmTEXEoCJT2wlIa9JS3XkPZv98Ckra++2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=G9lhgLDJ; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="G9lhgLDJ"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id E17F64C65E;
	Sat, 31 May 2025 07:19:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1748668792;
	bh=ezSk1AScLKA5gqQ1etOOqZ8zKztgHmnwelpnkUWYS0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G9lhgLDJFvR5tpEy12C9Lm0lQXRGrjrbpqUUZXr4hy5K8JDFMS5oGbPjS1raLyAxR
	 9wtGAtVpqRxGKYWaoMHv99FcR5wmRa5vtVtvvqptFkydPEJ2dLoN6pXEBr4J+856w7
	 0VpV5kgustMmnWJ8YlCznY6qmPSjIEWOa0KqgSRol5Jpu+bAgNTE9RHXV8nlFWBzJh
	 mPEYZk+UYrrnATLmY6SM4dHWKRtKJ64xTpngcqKwvbXjFuUA1woOm/twizf4qDGTX+
	 i4gkWq0ADdtKKLTCDXScPVZl6liRoFfNngK68aUIg8EKhHlmh6VO/XU/04YcszRVjh
	 sEYZsHp5wo14Q==
Date: Sat, 31 May 2025 07:19:51 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [git pull] IOMMU Updates for Linux v6.16
Message-ID: <aDqRd6Nh7iwnFvmw@8bytes.org>
References: <aDmght5YpHmJ6qZ2@8bytes.org>
 <CAHk-=wguPX5w3UVmQpOk+v1ahJwRzRNXKHUJB92cwJfNpMU4ZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wguPX5w3UVmQpOk+v1ahJwRzRNXKHUJB92cwJfNpMU4ZA@mail.gmail.com>

On Fri, May 30, 2025 at 09:57:34PM -0700, Linus Torvalds wrote:
> On Fri, 30 May 2025 at 05:11, Joerg Roedel <joro@8bytes.org> wrote:
> >
> >           - SMMUv3:
> 
> Bah. This seems very broken.
> 
> I haven't bisected it, but my arm64 build - which I sadly didn't end
> up doing earlier today - breaks with modpost errors:
> 
>    ERROR: modpost: "arm_smmu_make_cdtable_ste"
> [drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.ko] undefined!
> 
> (and the same error then repeated for arm_smmu_make_s2_domain_ste /
> arm_smmu_make_s1_cd / arm_smmu_make_bypass_ste /
> arm_smmu_make_abort_ste / arm_smmu_make_sva_cd / arm_smmu_get_ste_used
> / arm_smmu_write_entry / arm_smmu_get_cd_used).

Gah, sorry for that. I didn't see it in my testing, but have seen a
similar problem related to iommufd which was fixed by removing the
iommufd part of this patch-set:

	https://lore.kernel.org/all/1926170.CQOukoFCf9@devpool92.emlix.com/

So maybe it is worth a try reverting the arm-smmu part of this series as
well:

	e436576b0231542f6f233279f0972989232575a8

Regards,

	Joerg
