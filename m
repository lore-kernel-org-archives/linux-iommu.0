Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED22D3E558E
	for <iommu@lists.linux.dev>; Thu, 19 Mar 2026 15:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773934348; cv=none; b=qiJtfPMbTa5IjBnYxNug7MlPMeOfR0XTsRECDgYDVRjyzAjlUOp61t+KW7ArzHkXsRd3o1f1q8xAPu/c3onWXupfNiaCxGGX4ERvmaCq0jLk8mR4WlAkvnqed6t9AKXUC+sCFXbg9vvUEafCLVIsil/DQYjHRYIqD9jaUP37rgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773934348; c=relaxed/simple;
	bh=OMf00bxp1dMo08fcsjygvPUMlRjqnEhwnrCIv/r7goQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XT4/adB0N3uVd5bJ1nMW8srCzZMMxiJF2EWLWTOTScEpzy9q2K+Xs3xv2E7hIwWxC9Do2PSHui2mz0tZTnOB5Rlvt265/Dcl+Wsj9MXzzgsuVAUdLEUIo0rC3NvTIBM49Q/6YqMmt1o5+hccEr47xkrh21V5mGMPDOCPp3VJvU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 663831A25;
	Thu, 19 Mar 2026 08:32:20 -0700 (PDT)
Received: from [10.57.59.172] (unknown [10.57.59.172])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7972A3F778;
	Thu, 19 Mar 2026 08:32:25 -0700 (PDT)
Message-ID: <7fe97d37-b6e4-4fe7-a871-b4d67763079a@arm.com>
Date: Thu, 19 Mar 2026 15:32:22 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: errata: Reformat table for IDs
To: Will Deacon <will@kernel.org>
Cc: catalin.marinas@arm.com, joro@8bytes.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, daizhiyuan@phytium.com.cn
References: <cover.1772125743.git.robin.murphy@arm.com>
 <3adc16d4d035cf76803e706e325822b99c13e977.1772125743.git.robin.murphy@arm.com>
 <abwNg5LY9Ll235vS@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <abwNg5LY9Ll235vS@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-03-19 2:51 pm, Will Deacon wrote:
> On Thu, Feb 26, 2026 at 06:10:20PM +0000, Robin Murphy wrote:
>> We have some inconsistency where multiple errata for the same component
>> share the same Kconfig workaround; some are one ID per line, some are
>> smooshed together, and some are entirely separate entries. Standardise
>> on the single entry, one ID per line format so that things render nice
>> and consistently in the HTML docs, and it's simple and clear to add new
>> IDs to existing workarounds without churning the table too much.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   Documentation/arch/arm64/silicon-errata.rst | 44 ++++++++++++---------
>>   1 file changed, 25 insertions(+), 19 deletions(-)
> 
> I think we're better off doing this at -rc1 in the Arm tree, so we avoid
> unnecessary cross-tree conflicts for something that doesn't really matter
> that much in the grand scheme of things.
> 
> For now, please can you send the SMMU patch on its own so that I can
> pick it up?

Yeah, that's fair enough, it's not like it's a real dependency that 
would justify taking the SMMU patch through arm64 either. v2 sent, and 
if I haven't forgotten all about this by -rc1, I'll rebase and re-send 
this one then.

(And I did rather expect that patch #3 might end up getting dropped, 
hence keeping it separate at the end. Oh well, worth a try.)

Cheers,
Robin.
