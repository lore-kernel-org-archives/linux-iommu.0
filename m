Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413996;
	b=A9eXsQw9jlt+g6/2zKg2dOFekQAV2++eFJSz2yuXe0mxR36n3Ju2T8Pgimiz93c6aiL1
	 dwlEAqi/96RSlwyY1mMgJqEvwSTmZIBNXZXTfABkINZsin+jGsF/hbNkZz+4+vI2a8jBd
	 06QhYgq6iN6H/007pzEIYPvmhDFJ/NrlbM01RMxcC+wDaZJs1XtpDWurJA8r5b8BRaoaq
	 JaqWlh42+blNLrWuJclq0vNsK/uaM/UXfWaoGh23nQ8tZimIZzASGBNR6nO4rgzOZDfRU
	 mZC0d6NomN9QZ4cSrALvYmwXRjarhEYi/H9vvRcxGVfDzOXuWZ05elZax5T9nGS/adQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413996;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=44DfV0bL6HPYkPp0Ecl6fd5OA178t8+1rLF7XPfImuM=;
	b=iqHFfnppYEr8UmR86oWuyGpxRmMkg7hWyhlLE3nj/559CC72cheXk2UFEh3q+/kYCBqn
	 noQtyAXvfvOIWO1QTpXsFIAg49dq02PMm3ixiA7JmJDxn5+T7Foz1L1pD8OdQKcwDovdL
	 o3/Id4Cdgb9f40CFLid+6Xlkz7weQb3Tv03GnCoNoi5j7RxYkNIcTS4QApCKEO4WNSBi2
	 yRC6tqIB1zutpz6quhQbUA0VXFfMWRb8uqsy5UoBHWZpaoRKbrR9QhiL1HmCNIKSORo5x
	 EhliGhNepCntpvFZIFVsc+Iai9Y+bLXAT/VIIlRAWog/zVIF+3lKV1VDAgs0bfRumOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mfdm5A7h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C9760A2631;
	Wed, 11 Nov 2026 16:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mfdm5A7h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44471F00A06;
	Wed, 11 Nov 2026 16:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794413996;
	bh=44DfV0bL6HPYkPp0Ecl6fd5OA178t8+1rLF7XPfImuM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mfdm5A7hJTz/OLhPk7a/A6xxBAGkInGaTECbYA1+4nh07RbKH900tnmi/4RGbIRze
	 iOqonH/hUJCLKzPRxGnckwjZQi9VpFEIn1+jSeUhDjcV8MClHAlsn0kY9E+KAfGAzb
	 N3mPrnbA3YMG97uzBLieJxwqLGOXD0lOgtbsWBBs+5yuwJiG9Abvc3XKEx22ZFiz7r
	 AIbq7i8/af2+L+3TxRiRhKDDhRhWqmNkTegI13JN4WyQfR3yifYZVfMF3nq1pSkK9J
	 WioB1LY0L1Yeih4BdPe5FErB6zDv5M58dlQZqOxH9otBIt0RHP6ZJcxgPxwuztRr35
	 eYQ/g+U6y+pEA==
Message-ID: <c724e3c3-7acc-4c3e-8410-426c7ca6cf19@kernel.org>
Date: Wed, 11 Nov 2026 17:19:50 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/15] dt-bindings: nvme: apple: Add apple,t8142-nvme-ans2
 compatible
To: Yureka <yureka@cyberchaos.dev>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, iommu@lists.linux.dev
References: <20261106-apple-dts-m4-m5-nvme-v1-0-22f4827b4ece@cyberchaos.dev>
 <20261106-apple-dts-m4-m5-nvme-v1-3-22f4827b4ece@cyberchaos.dev>
 <20261111-comical-quaint-turaco-e8c1c2@quoll>
 <fb7b4ede-a325-4c5e-a37d-fe3cc7a92f87@cyberchaos.dev>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <fb7b4ede-a325-4c5e-a37d-fe3cc7a92f87@cyberchaos.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/11/26 15:32, Yureka wrote:
> On 11/11/26 13:46, Krzysztof Kozlowski wrote:
>> On Fri, Nov 06, 2026 at 10:04:12PM +0100, Yureka Lilian wrote:
>>> "apple,t8142-nvme-ans2" on the Apple M5 SoC is compatible with
>>> "apple,t8132-nvme-ans2" so add its per-SoC compatible.
>>>
>>> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
>>> ---
>>>   Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>> Squash all nvmem patches. Don't add compatibles one by one.
>>
>> Best regards,
>> Krzysztof
>
>
> Hello Krzysztof,
>
>
> (replying to all three of your emails here)
>
> thanks for your feedback! I did run `b4 prep --check` and `make 
> dtbs_check` before sending and it passed without warnings on all 15 
> patches of this series. I will now also run `checkpatch.pl --strict` 
> as you suggested.
>
> For v2, I will make one commit per type of dt-binding, so 
> "dt-bindings: nvme: apple: Add t6040,t8140,t8142", and then "mailbox: 
> apple,mailbox: Add t8132,t6040,t8140,t8142", etc., ok or do you have 
> another suggested grouping?
>
> > Please stop inflating this. You are only making it difficult to 
> review your work.
>
> It would be appreciated if you can tell me clearly what is expected, 
> as this statement is not actually telling me what is inflated / wrong.
I think you already understood it: Just one commit for SART, one for 
NVMe, and one for the mailbox bindings that each add all new compatibles 
at once because the hardware (likely) didn't change and there's no need 
to explain what's different from the previous generation.


Thanks,

Sven


