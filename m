Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337E61D2B9
	for <iommu@lists.linux.dev>; Tue, 23 May 2023 06:32:29 +0000 (UTC)
Received: from 8bytes.org (p200300c2773e310086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:773e:3100:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 2B37824819F;
	Tue, 23 May 2023 08:32:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1684823548;
	bh=lDZD3zzGrByAcwmUfn2k+Bv0ncFvLlgDZU7+Qxs0X6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bj1hp9MuQ8xPbY1sKM2Qo+DaAR/9V51A2/8bML1yndoTmcK1P2svZ8kcn9Z4lCG9F
	 iYhrmFL+ah2BH5uo7YwQ/WcCeHlIQHA9QX79dkJjMwWjG6jgw9H6/cqt0FQKuMl2Eh
	 /dKm9ZLM0xoNdmlJq9PtDsx5fCL42hUE8NNWMX6Ae7ucdJmkd36yOr5nOl/K2CqO2x
	 AzR1uNHoS1wQMh/YP5Z9Lj4GTXPLDZWwAFYv8K08PFMkgDl0hoR6w1jIypllLTHOiH
	 Aw7XopLfkKsBcCLoAZKqGPo5NdQNZPdc5VyRBQ5b4o1MqpZ5BAWsZQZEXeV40taur+
	 Ge1z+RJnfz3uw==
Date: Tue, 23 May 2023 08:32:27 +0200
From: Joerg Roedel <joro@8bytes.org>
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc: jsnitsel@redhat.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, joao.m.martins@oracle.com,
	alejandro.j.jimenez@oracle.com, boris.ostrovsky@oracle.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, vasant.hegde@amd.com,
	kishon.vijayabraham@amd.com
Subject: Re: [PATCH v2 4/5] iommu/amd: Do not Invalidate IRT when disable
 IRTE caching
Message-ID: <ZGxd-4mKvSgmYCvN@8bytes.org>
References: <20230519005529.28171-1-suravee.suthikulpanit@amd.com>
 <20230519005529.28171-5-suravee.suthikulpanit@amd.com>
 <byrqmwgki5ak5yn74ubvgikeb7ibrzml2lcnnx3qgkyi2omn3x@qyo5q5atbe33>
 <700f08ad-0eb6-4ad6-329b-fe5b9cdb6a4f@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <700f08ad-0eb6-4ad6-329b-fe5b9cdb6a4f@amd.com>

Hi Suravee,

On Tue, May 23, 2023 at 10:38:59AM +0700, Suthikulpanit, Suravee wrote:
> Joerg, Please let me know if you would like me to send v3 with updated
> summary.

Yes, please send a v3 with all updates included.

Thanks,

	Joerg
