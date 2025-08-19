Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1E023BD17;
	Tue, 19 Aug 2025 10:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755597723; cv=none; b=LfQ9AYTTWoJl4orMbdd708QgYkz+C7mpbii//RszCAdWzWG0kpn1wkr77RBQaFxVhKvFflhMx5BsnBuYywdBlA4y6FnFYw121PKAOEq0IFG/vbLlJPTRoIHMXg8gv+Rv5jEhhUI76eB1mvuD/HL0DoJL+EGMncsvlbO86epacy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755597723; c=relaxed/simple;
	bh=pw2fnfhmflhIZ1bq9JJ2pTYcVzb7LXTiDoC60DsC640=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CWxvYqE5EstFD1ckP1Qh6Qfbm0S1IXKX/Ncir79yuHFnabChrE0+dNWpbKlJC/MfJU0gpU+2KgyR19FOC1lzZ0aHDlnFnKgG3LVifgl7y4uzOu8zs+PD1dMJ+u6hjiDClInH5fMzAlTsn8qX3oLVFf84DIawYAXucZTI5L9IIkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSrIBn5u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSrIBn5u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC44AC4CEF1;
	Tue, 19 Aug 2025 10:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755597722;
	bh=pw2fnfhmflhIZ1bq9JJ2pTYcVzb7LXTiDoC60DsC640=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PSrIBn5uEJo54gUUN0UoLpYD3c1+PxV/rMhboUSl03RK7VARtjkynNxTz1k+Jr9ee
	 mZpssBb475d5oZxbWZINXl3wS2z4JWXLpQKzlrIc729FGIlhg2jlrbK2IGRt5s1MKC
	 3kt2SygUnQrp0D+Ate39vermY65xaeBwJakkdHHBjkTJF7aUFk+BxspRplvBcGlPTU
	 Smx4jIR5LXurX6sjK1vV06M7gQbIH4mnucf8tPUnxNe+hWYJyAHP+puWDqMbXbYnWl
	 gQEvkNoapYYK9DGdXdm46nQbwhs1mxIYQ6sJsxSy1hiSE+GPtPn3GUKXXYR0Zqu/wV
	 4B89QRfZt5XSw==
Message-ID: <8ac418ae-7ff0-4d5c-9f11-c24e36618ac1@kernel.org>
Date: Tue, 19 Aug 2025 12:01:55 +0200
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
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20250819-polite-papaya-catfish-1a9d1a@kuoka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.08.25 11:18, Krzysztof Kozlowski wrote:
> On Mon, Aug 18, 2025 at 04:42:59PM +0800, Nick Chan wrote:
>> Add ANS2 NVMe bindings for Apple A11 SoC.
>>
>> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
>> ---
>>   .../devicetree/bindings/nvme/apple,nvme-ans.yaml          | 15 +++++++++------
>>   1 file changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
>> index fc6555724e1858e8a16f6750302ff0ad9c4e5b88..4127d7b0a0f066fd0e144b32d1b676e3406b9d5a 100644
>> --- a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
>> +++ b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
>> @@ -11,12 +11,14 @@ maintainers:
>>   
>>   properties:
>>     compatible:
>> -    items:
>> -      - enum:
>> -          - apple,t8103-nvme-ans2
>> -          - apple,t8112-nvme-ans2
>> -          - apple,t6000-nvme-ans2
>> -      - const: apple,nvme-ans2
>> +    oneOf:
>> +      - const: apple,t8015-nvme-ans2
>> +      - items:
>> +          - enum:
>> +              - apple,t8103-nvme-ans2
>> +              - apple,t8112-nvme-ans2
>> +              - apple,t6000-nvme-ans2
>> +          - const: apple,nvme-ans2
> 
> When some months ago this pattern of generic fallback appeared, I
> believe I commented it is bad idea. So now months later we have a proof
> - generic fallback is useless and you should have been using SoC
> specific compatibles from the start.
> 
> Now it is just confusing and this broken pattern will be spreading more
> and more, because you folks put generic compatibles everywhere.

I haven't commented on the dt-bindings yet because I suspect this patch 
is wrong but haven't had time to test this yet.

I believe we want "apple,t8015-nvme-ans2", "apple,nvme-ans2" here and
then use the code Nick added for "apple,nvme-ans2" by default and only
enable additional features (NVMMU, linear submission queue) when we see
the SoC-specific compatibles for t8103, t8112, and t6000. IIRC these
newer SoCs still support the old way of submitting commands just fine
and the new way was added at some point to add support for this weird
integrated IOMMU.

I've already seen some strings about ANS3 somewhere which I suspect
will be the controller in some future SoC (or maybe M3/M4 which we 
haven't reverse engineered yet) that actually breaks compatibility.

It's too late to drop them here but if you're strongly opposed to these
generic fallbacks we can just switch to only use tXXXX-nvme-ans3 at that
point without making anything confusing. Same for any other new hardware
blocks we reverse engineer and upstream.



Sven


