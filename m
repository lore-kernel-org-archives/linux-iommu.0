Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7AD3E4C6D
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 10:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785149626; cv=none; b=qXjwbQmIN9DfykpibRuXtCJJWfY6oMRa8hHp1I3iPslb16nLSgJIJs0iFvL49gbd1P6wf0lgWYpEK2Mm2fCRyV1xLp4PCPTYHf+frZmw6QXxKE0iZqqKnqeIw2R5ICd20+OOV3VviA8hZPHMilfvxQcfWfTp80Zog1HlgQ0L0HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785149626; c=relaxed/simple;
	bh=7WpwP8RisrxnArjb2LK5kEATiDum+IBvXOvgLgkJm6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kyg4s2Bp8/kNIs/M7Q0yi5RttIfWqwhZjcn18jQgQox3UuYe0U54Y1lRkEO/8VsGBWgYJ3eoyQn1S3s+uf2YoYm9MHwliuioWfSVdRnok6RBUrdap0QWWCu83qh1z2s/azc9BmFZPW45LoPQCQ76vorR80leKq5KLEcoJ0Y6kuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=sbtuWqmQ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="sbtuWqmQ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0307D143D;
	Mon, 27 Jul 2026 03:53:39 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0ABBF3F86F;
	Mon, 27 Jul 2026 03:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785149623; bh=7WpwP8RisrxnArjb2LK5kEATiDum+IBvXOvgLgkJm6c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sbtuWqmQYn9269wgUse/Rtj71CbSRnD6TElxQDFKMGbYdmWesPYBJdvdbR3GzHBB/
	 AmMc/nUI1r5ExsyP52QqsPN9VsEK3TXB43MKsg5v4GzUvcRu/7uHw8fjy7m0jbsQmE
	 QETa8MrZxMizcuWF/YcIaAknmugdqFxzrgikFxio=
Message-ID: <0b7c0272-5506-4aee-82b3-76a78f2b39dc@arm.com>
Date: Mon, 27 Jul 2026 11:53:37 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add arm-smmu-v3 support for instcfg data override
 feature
To: Will Deacon <will@kernel.org>, Peter Griffin <peter.griffin@linaro.org>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Pranjal Shrivastava <praan@google.com>,
 Daniel Mentz <danielmentz@google.com>, Mostafa Saleh <smostafa@google.com>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@android.com, tudor.ambarus@linaro.org, andre.draszik@linaro.org,
 willmcvicker@google.com, jyescas@google.com
References: <20260724-arm-smmu-v3-instcfg-override-v1-0-e7acf4a8a525@linaro.org>
 <amYIuhYenP4-qHyV@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <amYIuhYenP4-qHyV@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/07/2026 2:16 pm, Will Deacon wrote:
> On Fri, Jul 24, 2026 at 01:39:41PM +0100, Peter Griffin wrote:
>> These two patches add support for a new "arm,instdata-override" DT property
>> that enables the override of the instruction/data attribute of incoming
>> traffic to Data by setting the INSTCFG override bits.
>>
>> It is intended to be specified when the smmu can't guarantee that these
>> attributes are provided correctly from the client device.
> 
> This is going to need an in-tree user and a much more detailed
> description of what is being worked around before we consider this for
> inclusion.
> 
> In particular, if a particular client is emitting data reads as
> instructions, then a better work around would be to avoid mapping its
> domains using IOMMU_NOEXEC. But I can't tell what's going on from the
> limited description provided here.

Unless it's also emitting the privileged bit and thus falling foul of 
the implicit Unpriv-W -> Priv-XN rule, but then we also have the means 
to deal with devices which actually do that themselves (hello pl330...), 
so that would seemingly only leave the case of some innocent piece of 
AMBA-interfaced IP which doesn't expect to need special attributes, but 
the system integrator has gone out of their way to tie the AxPROT bits 
to some wacky value, which I would put in "erratum workaround" territory.

Thanks,
Robin.
