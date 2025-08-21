Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5204A2F5492;
	Thu, 21 Aug 2025 10:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755771922; cv=none; b=Lwu3NAq0YL2d6SN5cUdtLhQ2Z6UcgHtNwslMSUbCJ5HE62A73X1vJlXozcjo0kBCXPZ+s6+VTFi8GOyMnBZ+MpaSHRszUz/n5SnfF5XbxzruGw3etPsFYDwqI+6HOX2cJemZINRGKh0ZdPGSy+zYbAVJEq1OkDG3Z3kyGJjrQao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755771922; c=relaxed/simple;
	bh=ORTjv3YVqf7tKuswYRO+Ecti+tHql9FqphRkmWE57tg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uIS4C3Wt7QK17ztir7oYm6gaLk0vIAx8BvxSzIDc92qaqnqIdaXzPp9ESDcl0l9I6C+0vYEzuuQJnk5lzKwPIiqP420lS10GtNkt0ksM7TZQZUXZgCptFMyawM0aV0LmQo+qK9LWN0723DF4w/F9+Aj+09Z3LoVynyRBv3hqFYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPULIdwc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPULIdwc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9A1C4CEEB;
	Thu, 21 Aug 2025 10:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755771919;
	bh=ORTjv3YVqf7tKuswYRO+Ecti+tHql9FqphRkmWE57tg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QPULIdwcaNqt09nbyOt6cG69mFU7KE+z/YDsBLC+6QCrO733Rv8gicsUdi/n2CLra
	 3pjjq3rP7mvOXOfd2byRx9QriPg0Tev/gGPaV9mz3O0DvpWyzBCvi6cFyT38BehraB
	 KKphm+1osP13chkL5WxNxZd7sE+hHAQ3jP+d0o+LW88a1X+j89AJW1F2KB3iaU0x3E
	 EvHLNVKv8Tff+anLhmUPHpmoCpUzq+XUQ3f94dPR9PFeQVBzq3txIrdAX+0ynUF4Nn
	 qe27HLnYSx+ZLvON6+k87GoFcr9c/jWh6tRDYVqXro9/k/Yubt3N1Sf40TE8rL3v5F
	 P3jFLeR5cR66Q==
Message-ID: <8279536d-c4f4-477a-9823-3e7b452c3c33@kernel.org>
Date: Thu, 21 Aug 2025 12:25:13 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] dt-bindings: nvme: apple,nvme-ans: Add Apple A11
To: Krzysztof Kozlowski <krzk@kernel.org>, Nick Chan <towinchenmi@gmail.com>
Cc: Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, iommu@lists.linux.dev,
 linux-nvme@lists.infradead.org
References: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
 <20250818-t8015-nvme-v2-6-65648cd189e0@gmail.com>
 <20250819-polite-papaya-catfish-1a9d1a@kuoka>
 <8ac418ae-7ff0-4d5c-9f11-c24e36618ac1@kernel.org>
 <b3cd1b3f-fa0e-4a98-84c7-e4271f262795@kernel.org>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <b3cd1b3f-fa0e-4a98-84c7-e4271f262795@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.08.25 13:34, Krzysztof Kozlowski wrote:
> On 19/08/2025 12:01, Sven Peter wrote:
>> On 19.08.25 11:18, Krzysztof Kozlowski wrote:
>>> On Mon, Aug 18, 2025 at 04:42:59PM +0800, Nick Chan wrote:
>>>> Add ANS2 NVMe bindings for Apple A11 SoC.
>>>>
>>>> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
>>>> ---
>>>>    .../devicetree/bindings/nvme/apple,nvme-ans.yaml          | 15 +++++++++------
>>>>    1 file changed, 9 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
>>>> index fc6555724e1858e8a16f6750302ff0ad9c4e5b88..4127d7b0a0f066fd0e144b32d1b676e3406b9d5a 100644
>>>> --- a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
>>>> +++ b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
>>>> @@ -11,12 +11,14 @@ maintainers:
>>>>    
>>>>    properties:
>>>>      compatible:
>>>> -    items:
>>>> -      - enum:
>>>> -          - apple,t8103-nvme-ans2
>>>> -          - apple,t8112-nvme-ans2
>>>> -          - apple,t6000-nvme-ans2
>>>> -      - const: apple,nvme-ans2
>>>> +    oneOf:
>>>> +      - const: apple,t8015-nvme-ans2
>>>> +      - items:
>>>> +          - enum:
>>>> +              - apple,t8103-nvme-ans2
>>>> +              - apple,t8112-nvme-ans2
>>>> +              - apple,t6000-nvme-ans2
>>>> +          - const: apple,nvme-ans2
>>>
>>> When some months ago this pattern of generic fallback appeared, I
>>> believe I commented it is bad idea. So now months later we have a proof
>>> - generic fallback is useless and you should have been using SoC
>>> specific compatibles from the start.
>>>
>>> Now it is just confusing and this broken pattern will be spreading more
>>> and more, because you folks put generic compatibles everywhere.
>>
>> I haven't commented on the dt-bindings yet because I suspect this patch
>> is wrong but haven't had time to test this yet.
>>
>> I believe we want "apple,t8015-nvme-ans2", "apple,nvme-ans2" here and
>> then use the code Nick added for "apple,nvme-ans2" by default and only
>> enable additional features (NVMMU, linear submission queue) when we see
>> the SoC-specific compatibles for t8103, t8112, and t6000. IIRC these
>> newer SoCs still support the old way of submitting commands just fine
>> and the new way was added at some point to add support for this weird
>> integrated IOMMU.
>>
>> I've already seen some strings about ANS3 somewhere which I suspect
>> will be the controller in some future SoC (or maybe M3/M4 which we
>> haven't reverse engineered yet) that actually breaks compatibility.
> 
> 
> This was 99% predictable and expected months/years ago when first Apple
> M1 generic compatibles appeared. I just do not understand why so much
> effort from reviewers has to go into explaining this and for arguing
> over that, and eventually we are right.
> 

Right, so we're in a bad situation now because we didn't listen. That 
sucks and I'm sorry.

How do we move on from here now though?

I think for any new bindings it's pretty clear, we just do what we 
should've done from the very beginning:
Whenever we upstream a new device that has no bindings yet we only use 
tXXXX-whatever as compatible and use that as a fallback in case later 
(or earlier) SoCs work with the same driver.



Then we still have to deal with the stuff that's already upstream. I see 
two options here:


1) For situations like this one where the generic one just doesn't make 
any sense we deprecate "apple,nvme-ans2" in the binding and use
"apple,t8103-nvme-ans2" as the fallback instead, i.e. just
"apple,t8103-nvme-ans2" for M1, "apple,t6000-nvme-ans2", 
"apple,t8103-nvme-ans2" for M1 Pro, and just "apple,t8015-nvme-ans2" for 
A11.

We keep the generic one in the driver for now but also add
"apple,t8103-nvme-ans2". We then remove the generic one from all 
upstream DTS files but keep it inside the downstream files we ship to 
users for now to avoid pain with kernel upgrades/downgrades.
A year or two from now we can then delete the deprecated generic 
compatibles everywhere. This all has to be synced with OpenBSD and 
u-boot as well since both also use these bindings.
It's gonna be rather painful but this would clean up the entire mess.


2) We keep using the ones that are already upstream and just accept that 
the situation is a mess and add comment above all the bindings that we 
messed up and that this should not be used as pattern.
In this case that means it'll just be "apple,t8015-nvme-ans2" for A11 
without any fallback and we keep everything else the way it is.

I prefer option (2) but if you really want to get rid of all this mess 
I'll also work on (1).

Would either option work for you or do you have a better idea?



Thanks,


Sven
