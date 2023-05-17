Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAED17C8
	for <iommu@lists.linux.dev>; Wed, 17 May 2023 04:38:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E15C433D2;
	Wed, 17 May 2023 04:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1684298293;
	bh=w1ksh5SW51N7P3fxKWJSi/zCpCMqnT7dGkZo8SzmGt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s6l6PoHRe0twkKrF6TdPe/SocecPF0YoIAXzkMqlYJCsEhbY/TMJDnRj8DSNhg1Ru
	 uI8+c/nZyGbkkp2q5UxvqbCV8QTf1v6hg/I4acstgmNoNpAkm4Q8ENnsjm6jZ0nJRF
	 r/8MU8sq8kw+WQoXwMh8MFsoayAmrWzml0Lo+j0E=
Date: Wed, 17 May 2023 06:38:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jon Pan-Doh <pandoh@google.com>
Cc: Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Nadav Amit <namit@vmware.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sudheer Dantuluri <dantuluris@google.com>,
	Gary Zibrat <gzibrat@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Fix domain flush size when syncing iotlb
Message-ID: <2023051703-unpaired-phonebook-58e9@gregkh>
References: <20230426203256.237116-1-pandoh@google.com>
 <CAMC_AXXgBoRZOaDpCex+g_YeOdPQpKD3moQ8VMsqVEm2nqSrjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMC_AXXgBoRZOaDpCex+g_YeOdPQpKD3moQ8VMsqVEm2nqSrjg@mail.gmail.com>

On Tue, May 16, 2023 at 01:59:16PM -0700, Jon Pan-Doh wrote:
> Hi Joerg,
> 
> [Cc'ing stable@vger.kernel.org per Nadav's suggestion]

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
