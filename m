Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1C5480973;
	Thu, 22 Jan 2026 12:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769083981; cv=none; b=Nyc2TS9JM3feypIqSlDXyYbJACmLFv4qYYmcPJezOMdwLPqTtFJEbtcY656qQtsr7GIOImbUkc5apAVn35RkdUfmHwvT2XMf4UbgEbuxdbvwAwQLUbyo3HSBHIg/+Q2wcMIxVJIxIq8i8roeKcqowyXGutUQY+BoRq0JneSX9/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769083981; c=relaxed/simple;
	bh=BPfY/Gnf0QsAl+WZe3Pj2UYJa/GxAUnm6Hk0MlMg79s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iYjaNV46x6ZXdWWkCHo723kOPrX6crHK/77gLgaBEyK8ltOwElrC9d+Feaw9RNFrytQ1SI/osGBuIBhDhPw74aqpkGTK7ecudT/i1U+5+H189wDc2s0WWPz77zFlNFuMFxCDeuMTMaX2MRRwKhQmQscV01J7wxQW4BXFgBTA32Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A97831476;
	Thu, 22 Jan 2026 04:12:51 -0800 (PST)
Received: from [10.57.51.35] (unknown [10.57.51.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B38FB3F740;
	Thu, 22 Jan 2026 04:12:55 -0800 (PST)
Message-ID: <d2ddbb72-30a8-44da-b761-876b2d37567e@arm.com>
Date: Thu, 22 Jan 2026 12:12:53 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu-qcom: do not register driver in probe()
To: Danilo Krummrich <dakr@kernel.org>, Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, broonie@kernel.org,
 will@kernel.org, joro@8bytes.org, robin.clark@oss.qualcomm.com,
 hanguidong02@gmail.com, quic_c_gdjako@quicinc.com,
 dmitry.baryshkov@oss.qualcomm.com, driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org
References: <20260121141215.29658-1-dakr@kernel.org>
 <6oogrqe3n5sxtpdydjqo4ucwp7n3ipqoupxtekvzbnqd7dae3s@q22wc7fpbtya>
 <DFV3I3D5UIZP.38TNCAJWQGI3O@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <DFV3I3D5UIZP.38TNCAJWQGI3O@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-01-22 11:52 am, Danilo Krummrich wrote:
> On Thu Jan 22, 2026 at 10:21 AM CET, Ioana Ciornei wrote:
>> The boot lockup was visible also on the NXP LX2160ARDB. This patch fixes
>> it.
> 
> Interesting, this means that qcom_smmu_impl_init() must be called on this
> machine, is this expected?

Yup, same as on the Juno boards and probably others - an Arm SMMU is 
present, which means if ARM_SMMU_QCOM is enabled then 
arm_smmu_impl_init() is going to offer it to ask "hey, is this one of 
yours that you might want to do something with based on your extensive 
and complicated match list that we don't want to maintain in the common 
impl code?", wherein qcom_smmu_impl_init() *should* return without doing 
anything at all as it's not a match...

Cheers,
Robin.

> 
>> Tested-by: Ioana Ciornei <ioana.ciornei@nxp.com> #LX2160ARDB
> 
> Thanks for testing!

