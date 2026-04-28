Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2A73FA5E9
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 12:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777378551; cv=none; b=SRZVGBoKklNrpCZUE5geHRuaN1WNyLRqsCtpPuVCyoi0uM/6qd7j42Nz2a/mMo1vMc6btjcV3uUyjdayXwbr2mlRxsydLOcSiBYqr0LqwrvbhkKRZRVgB/Vp8T2Lv0EASptm3Kd6HQTrvKP0odW1c3AZ4A5coQAhBklJGn3QaFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777378551; c=relaxed/simple;
	bh=3fst81hgXT1DjLs+ugyssDJtgCauuJ7FLz0RieP0aU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AYuVKD3JEtigQZOHBb98uuRj/Ke990kUDR5H9hNcn2xwtwJZmfCi+TCbkoENALp21HLjJvrdwSzptwevAbOOFP7EZJnYoVIn+6ONhNaFMH5EG40ee1H5B3O/HzavjMKKVUVhX+Hkk+DT7HymQesAkGEcWQq6z5hOg6EuHbmbUrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=mqXvml95; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mqXvml95"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D00ED16A3;
	Tue, 28 Apr 2026 05:15:38 -0700 (PDT)
Received: from [10.1.196.85] (e121345-lin.cambridge.arm.com [10.1.196.85])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 967AA3F763;
	Tue, 28 Apr 2026 05:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777378544; bh=3fst81hgXT1DjLs+ugyssDJtgCauuJ7FLz0RieP0aU8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mqXvml95+i3+UlU3esUAcxxPiHRb35xok3BVGSeyMMXanZuGqUO9bsbTQK8jBajZ5
	 U6TXQRwJGqKz0jVsoNC0BNR+SiQUepizmSxA3IlJkrL9nfGG/0K7NaL9TqRFeDrkrY
	 bXekHEpkA5ps0MZd8Lt+75Py5IxXFgPNS6+cNjsA=
Message-ID: <d860b6a9-e4a9-494f-821d-8b0a347e1591@arm.com>
Date: Tue, 28 Apr 2026 13:15:34 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QUESTION] Is the ARM SMMU v3 implementation designed to always
 ignore SSID when SSID_VALID == 0?
To: Joonwon Kang <joonwonkang@google.com>, jpb@kernel.org
Cc: baolu.lu@linux.intel.com, cychu@google.com, hhchung@google.com,
 iommu@lists.linux.dev, jgg@ziepe.ca, joro@8bytes.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stimim@google.com, will@kernel.org
References: <20260428090522.GA3048463@myrica>
 <20260428111442.1584248-1-joonwonkang@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260428111442.1584248-1-joonwonkang@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/04/2026 12:14 pm, Joonwon Kang wrote:
> Thanks for your prompt and insightful answer!
> 
>> Hi,
>>
>> On Tue, Apr 28, 2026 at 07:38:59AM +0000, Joonwon Kang wrote:
>>> Hi team,
>>>
>>> According to the ARM SMMU v3 spec, I believe that SSID should always be
>>> ignored when SSID_VALID == 0 and the current ARM SMMU v3 module
>>> implementation in the kernel seems to comply with this without exception.
>>> For example, when handling an event from SMMU, the implementation checks
>>> SSID_VALID(SSV) first and ignores SSID accordingly. If there is any
>>> exception to this rule, I believe it is a bug.
>>
>> Indeed
> 
> Acknowledged.
> 
>>
>>> Is it true for all the current and future cases? In other words, is it
>>> **mandatory** that the ARM SMMU v3 implementation ignores SSID when
>>> SSID_VALID == 0? or there might be some cases where the implementation
>>> needs to refer to SSID even when SSID_VALID == 0?
>>>
>>> Asking this question since our HW may not be able to clear SSID when
>>> SSID_VALID == 0 and so there might be some garbage value in SSID at some
>>> point of time(the HW will have a correct SSID when SSID_VALID == 1,
>>> though). If the ARM SMMU v3 implementation is to refer to that garbage
>>> value for any reason, the result would be devastating.
>>
>> At least according to the architecture, SubstreamID is ignored when SSV=0.
>> The SMMU is allowed to propagate the garbage:
>>
>>    7.3 Event record
>>
>>    * SSV: The SubstreamID validity flag
>>      - 0: No SubstreamID was provided with the transaction and the SubstreamID field is UNKNOWN.
>>
>> But the driver will ignore it.
>>
>> Same for PRI queue but in that case the page request wouldn't have a PASID
>> TLP prefix.
> 
> Although the PRI request without PASID may cause unpleasant ATC flush with
> SSV clear in this case, it does not lead to the implementation referring
> to the garbage SSID. Is this understanding correct? And while this case
> seems to be handled solely by the ARM SMMU v3 implementation, do you see
> if there is additional care required on our device driver for this?

A transaction with SSV==0 does not have a SubstreamID, therefore by 
definition there is nothing that an SMMU could validly attempt to do 
with a SubstreamID that does not exist. Sure, implementations can have 
bugs, but I'd expect any such bug in this regard should be sufficiently 
obvious that it most likely wouldn't get past architectural validation 
in the first place.

If you want to know the exact behaviour of Arm's implementations then 
you're best off asking Arm support, but since this piqued my curiosity 
too, I can save you the trouble - I checked with my contacts on the 
design team, and indeed our SMMUs should ignore the SSID value entirely 
when SSV==0 and just treat it as 0 (e.g. in event records).

Thanks,
Robin.
