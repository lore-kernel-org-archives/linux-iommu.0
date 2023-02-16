Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE807B
	for <iommu@lists.linux.dev>; Thu, 16 Feb 2023 10:24:43 +0000 (UTC)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 50A152246CC;
	Thu, 16 Feb 2023 11:24:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1676543082;
	bh=EIBMPAdejZ5+9OgpAb995sNA/DVRf/RwDbao+hnEl4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GRgl/tinAxLX/gzt+IP97trFOZTuitOSHhZog35pcKzVdWhaUkoJbJZAfO3kJN8IV
	 qRW3LP0GY6wmGVI0qp0wt8kVF0DuBW5evJpPa9oHgdmw50w1+vBsPfoFqTApaDos8s
	 S5ut/jjU5nElieNywKOQdjWirdrok9q0PGpPWXTFGcJJb4j9Ch3/s4YO76dthVBFcD
	 PdLJG1QlFEK8+fh1LcBXDq8bWU1jpJGHm/mYSMIhu6tcqBunFeIlUTLcdgoDinuw5T
	 4hkjHTPVmY2E3QL3uTJNQbgih/xFdDfzW7DvUXLR4uqwKu+FTifTuy4XVi/1gKlrNY
	 qlkvS2uRCTa9g==
Date: Thu, 16 Feb 2023 11:24:41 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	kvm@vger.kernel.org
Subject: Re: [PATCH v1] iommu/amd: Don't block updates to GATag if guest mode
 is already on
Message-ID: <Y+4EaSuEj9V8REf0@8bytes.org>
References: <20230208131938.39898-1-joao.m.martins@oracle.com>
 <Y+3+xtof4tC8koSj@8bytes.org>
 <6f5da7c9-cec0-3034-ca58-41115c565df5@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f5da7c9-cec0-3034-ca58-41115c565df5@oracle.com>

On Thu, Feb 16, 2023 at 10:08:11AM +0000, Joao Martins wrote:
> On 16/02/2023 10:00, Joerg Roedel wrote:
> > Missing Signed-off-by.
> > 
> 
> Not really missing it. It's actually there, right after the 'Fixes' tag.

Right, missed the separator to the notes part.

