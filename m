Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FAD38A706
	for <iommu@lists.linux.dev>; Mon, 10 Aug 2026 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786385007; cv=none; b=ZkH00qFsyPWYgSBS8Mt0bf34QQdWW5c4BW8V5bNsS4sTCCpxJcIMIA258RBpTa4vGFUyexFwtFauoOaTdsR/Dz7d8a8PFsHnJwpjYgGkVkg0Vq5Y3iKhAUB1WyEezlHbAcG8YmxdGAv7ML5pCzz9tPpTEw7mlEzY6m8f/24shIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786385007; c=relaxed/simple;
	bh=iqkN+MCW+ZeceZp70Va10kFXV0Ae5WHVvuwaPIe0BHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cdwH4Eh/3HWmnFil4MD1TEhYT/N7QjYoMqMGg/Y/+5amBSsMy9WWLqrDruqYoa7ds98utxjCce1AftMpV+RjukaEVDyBp80DoV7CUEhzy3oUIdysG+aMYqJwNrcJQ9yNhdGVg1pofIr3HPFhSyxGnhqRkKEQjMNZPtFD1hGv/7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=uV1lkrJp; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="uV1lkrJp"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2326A14BF;
	Mon, 10 Aug 2026 11:03:21 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 569D43F86F;
	Mon, 10 Aug 2026 11:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786385005; bh=iqkN+MCW+ZeceZp70Va10kFXV0Ae5WHVvuwaPIe0BHo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uV1lkrJpi27dsmHgqVdZoC6YQCyQqxSaQ4yha6qZ7KhlAJxrIDRQ7I0y21VRFW17J
	 RBEcQdiTYv/CD02/lNqrWcMPmlupTvriCJENfZLQutIB80r7ao1/vEYQqcRn9psAX2
	 3XCJGvAL0qtR7C89llo/aN1FRO+uKq9uZRsjOnZU=
Message-ID: <530dbb40-e7e2-4121-a5eb-5f16152fd11b@arm.com>
Date: Mon, 10 Aug 2026 19:03:20 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add arm-smmu-v3 support for instcfg data override
 feature
To: Rob Herring <robh@kernel.org>, Peter Griffin <peter.griffin@linaro.org>
Cc: Will Deacon <will@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Pranjal Shrivastava <praan@google.com>,
 Daniel Mentz <danielmentz@google.com>, Mostafa Saleh <smostafa@google.com>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@android.com, tudor.ambarus@linaro.org, andre.draszik@linaro.org,
 willmcvicker@google.com, jyescas@google.com
References: <20260724-arm-smmu-v3-instcfg-override-v1-0-e7acf4a8a525@linaro.org>
 <amYIuhYenP4-qHyV@willie-the-truck>
 <0b7c0272-5506-4aee-82b3-76a78f2b39dc@arm.com>
 <CADrjBPqZFDvyLFpDy1YP9qrMNUCtZYtJhiaDd0iTnmB4ZYO8GQ@mail.gmail.com>
 <20260807224745.GA2180415-robh@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260807224745.GA2180415-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/08/2026 11:47 pm, Rob Herring wrote:
> On Fri, Aug 07, 2026 at 04:25:11PM +0100, Peter Griffin wrote:
>> Hi Will & Robin,
>>
>> Thank you both for your review feedback.
>>
>> On Mon, 27 Jul 2026 at 11:53, Robin Murphy <robin.murphy@arm.com> wrote:
>>>
>>> On 26/07/2026 2:16 pm, Will Deacon wrote:
>>>> On Fri, Jul 24, 2026 at 01:39:41PM +0100, Peter Griffin wrote:
>>>>> These two patches add support for a new "arm,instdata-override" DT property
>>>>> that enables the override of the instruction/data attribute of incoming
>>>>> traffic to Data by setting the INSTCFG override bits.
>>>>>
>>>>> It is intended to be specified when the smmu can't guarantee that these
>>>>> attributes are provided correctly from the client device.
>>>>
>>>> This is going to need an in-tree user and a much more detailed
>>>> description of what is being worked around before we consider this for
>>>> inclusion.
>>
>> Regarding an in-tree user, I haven't sent the Device Tree (DT) patch
>> yet for Laguna SoC which adds the smmu nodes and this property because
>> 1) I want to land the initial SoC/board DT first
>> 2) I want agreement on the DT property name. Currently I used
>> "arm,instdata-override" which is what downstream used. However, since
>> this is intended to work around silicon errata something like
>> "google,lga-instcfg-data-override" might be more appropriate?
> 
> Shrug.
> 
> Really, this is why we want SoC specific compatibles so work-arounds can
> be added without DT updates. But we've generally avoided doing that for
> SMMU for whatever reasons. Just make the property clearly sound like a
> mistake, not a feature you might want to use. I'd keep the arm prefix
> just so the next vendor thinks they can't use 'google' and creates the
> same property with their vendor prefix.

I dunno, I'd be inclined to keep it more vendor/SoC-specific and tied to 
the problem more than one (of potentially several) specific workaround - 
if we did ever want to support using the INSTCFG/PRIVCFG/MEMCFG 
overrides per their full architectural intent, they are per-StreamID 
controls so as such would really want to be encoded in an additional 
#iommu-cell (or at worst maybe a property on the client device node).

Frankly for a workaround condition to just blanket-apply to every SMMU 
instance in a particular SoC, I'm honestly thinking that just whacking 
an of_machine_is_compatible() in the driver isn't necessarily the worst 
idea either - after all we do already have the ACPI equivalent of that 
for some of the HiSilicon stuff, it's just hidden in the IORT code (and 
OK it's used for the SMMU PMUs rather than the actual SMMU devices 
themselves, but still...)

Thanks,
Robin.
