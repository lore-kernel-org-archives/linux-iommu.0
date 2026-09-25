Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4E6126C02;
	Fri, 25 Sep 2026 06:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790318829; cv=none; b=QxJaRXayaJtPe/xjdb+JVOfOvo2CW3C/SRoJ+Ubax2FksXlNLd3Hakh9Wy48/styuUp/dohiluXuv+/zbcf0CRU1f1b/+KSN7DBT77R+kqCOH+qF9cfxW394E+OGnx4Gp3DeYgNoNXxvszJdaEQSS3Oe61IXuvVWHuulWP77ChQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790318829; c=relaxed/simple;
	bh=8f+gswlACgozdTz8iyPhelemFLgSo5hsf/bjDclOIr8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E/RSesUUc47YDrLcBTuUHnmTnn/69sh56pVFi2AUTm1plT8phcUVa15dW44Pn6VgM73IVLPHPu2vO/V/YmhzBzu/7VbcAeobJaFa4K0ourTdVNj1S9RYN8HZFpNKSz+YCauNnMCfSwDzAea+ip1RPBYqMlvyJrvafz1wHF/uQHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeninARG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeninARG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE7D61F00893;
	Fri, 25 Sep 2026 06:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790318827;
	bh=8f+gswlACgozdTz8iyPhelemFLgSo5hsf/bjDclOIr8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=NeninARGTpOwQ5rlNxK7fiUxrTMBbzUXF1TZPIjOUbDRCwmvuDAiL4ZZfZByxTi3j
	 RP6zhKNLlmHEVRd8ffpzXoKS84KHpEh1F/dCP+m8ZZd8zfzqhnFaHjl3xfK6YG+s1l
	 0VBEsqUqBtZNmzBXnm5F/rVOPx5qZYjEoY6DlKELM6abvjXD0z9uN13rQDDgB8Kw0q
	 NJRDUMXgkSdGjvlLoagn0neF50+D+Q55WTUTABevdTui/DDY2aQLqc8SXc5aVQgpaE
	 NGL4v6psklItXzhEPG+PTiInjeUUVMjV1JydjaSmuwsZiGdCl9N/pw3OiLbwS0VeZE
	 yd7clkMlnzlKA==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-coco@lists.linux.dev, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v6 00/11] iommufd: Infrastructure for vIOMMU
 creation for confidential guests and guest TSM requests
In-Reply-To: <20260924190935.GA112301@nvidia.com>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260924190935.GA112301@nvidia.com>
Date: Fri, 25 Sep 2026 12:16:58 +0530
Message-ID: <yq5a8q4pkeu5.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@nvidia.com> writes:

> On Thu, Sep 17, 2026 at 07:31:48PM +0530, Aneesh Kumar K.V (Arm) wrote:
>> This series adds the IOMMUFD and PCI/TSM infrastructure required for device
>> assignment. It introduces an IOMMUFD-owned vIOMMU provider registry and the
>> IOMMU_VDEVICE_TSM_REQ ioctl.
>
> I couldn't guess how to apply this with b4 review. Since it requires
> the series to apply I can't use it without knowing your base..
>
> .. and for some reason this series doesn't have a base-commit trailer
>
> .. nor does it specify a git URL to find it on.
>
> I strongly recommend consistently doing both of these, by script, so
> it happens right every time.
>
> Please send all your series in a rigerous way. Make sure you have a
> script that does all of this stuff, ideally automatically. I have one
> if you want to see it..
>
> Anyhow, I used a crazy AI prompt to make this apply on top of the last
> tsm series..
>

I should be able to split these changes into an independent series on top
of upstream. I did not include a base-commit because the series is
currently based on other CCA patches, solely to enable testing of the
complete stack.

The full tree, including the other CCA changes, is available at:

https://git.gitlab.arm.com/linux-arm/linux-cca/-/tree/cca/scratch/vdevice-tdi?ref_type=heads

For the next iteration, I will rebase the IOMMUFD series onto the upstream
kernel and include the base-commit trailer.

-aneesh
