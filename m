Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793017922;
	b=TCXj6uzqcNMIyQkgtIIok85QXRxTZgYbM2Y2c+uSZxCFmTRyGt11LTI2s61p/7KD/muT
	 6B15U7aDIDu6jAQPUEPxz/UVv/d+d4fYhfLUZCOstN8PQvT5QtZwtRPFnW4u9KiDYQ734
	 DgdsKsuFf1w+K4/n1Iy5zk8cp4dQg7NIf9t3fVUlXxvub7nchZoDqqFCo3IRox9lSX3ub
	 tSXMJmQy6XNCstxIzZhC/AiBqqQgRQv+Jf6LDmmPpChBIcWAD7bFuLK79MaVyGPqrm6GB
	 RB9BRSalBLmtZ37+T8pct+jh0VhQQExlUizD/OhCqsMuMB+PcD23b3Z9Tvj5WJIuSyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793017922;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=n4vj9UdlQuQU69tpB4POuZ9TjkQJc+GCVbAWOXKkV58=;
	b=wy+SppyjIpKl6Gzk0MuIHSkrRfd//JjnjAvYDCFtw88XkfdxdO2M3pcrT3qV6UPIwFlU
	 6KcZWT1CFm1EPdW0kOYnLPm/ZIXOi7+U5KlreXsNwSpKa/TJm/V5eZPHLu3JNC+4Ni77v
	 /mtCdCuTy/wQxS6rScKvy5G1RAzzOMJOlplcRqoAWxS8XaVVOCAn3l5jj8/RKQdBO/iEC
	 fr3TFvDc3Pz8sQP2n/wNHMgxNwBejflTe3R2BS06IXj9c3Wz3Ey6Ci2Qb7eWf01aHbzGK
	 ps4fcDa7JmFvZLlrQgMBZ/Xo4Nar+gH0V5eacZg5LclQvOdxd9SOWUldMZdz60YmXpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jyeat6lh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBF1606A31A;
	Mon, 26 Oct 2026 12:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jyeat6lh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81481F01825;
	Mon, 26 Oct 2026 12:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793017922;
	bh=n4vj9UdlQuQU69tpB4POuZ9TjkQJc+GCVbAWOXKkV58=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Jyeat6lhqqe4xqdQIZ3z3a/sfEVkaxlVl/e2kFlLiH4wex4RGU5whRzUe47cJrUTE
	 STEOKuJe+HAgzzW8BJsdrzCU11+Lgmg4hN+V6358zhICg2sXdWIXJKEOOPt3zovTPS
	 Ogs+dWmCIL0fWiS7N9gSwj3A+iABv5JfheXf1nox92bEhnxjB7x5F5XZ1AXnr0DO8i
	 jGQyWH521Gn2sgPOnkrY3uISNZCGpG0QJWaiySRRo+VKLj4Pw92XvdAmar21H0Hx8X
	 AuJnQIXgSIK8+Jxm+V+03EMid6bVGA37sTM3oRXoZVElylfH+Y1i+u+rMFrMTJYVjQ
	 7psVVkI/iKFrQ==
Message-ID: <ea527310-f173-4546-948a-d275ff40ade7@kernel.org>
Date: Mon, 26 Oct 2026 12:31:55 +0000
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
Subject: Re: [PATCH v5 04/13] iommu: of_iommu: Add support for "iommu-ranges"
 on a device node
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux.dev,
 Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
References: <20260926-vpu_iommu_iova_handling-v5-0-0322ca5dc10c@oss.qualcomm.com>
 <20260926-vpu_iommu_iova_handling-v5-4-0322ca5dc10c@oss.qualcomm.com>
 <99a419c3-81a8-4b37-b9c7-2dd56978162d@linaro.org>
 <3_cePPPMBo_SOwJDa7jnPr3t5UWeJDb_FTzCsX8_RVql4u6ZrS-Aw_UCfhWYNllz4QZwHVwxm3dCG7UY3XZXnQ==@protonmail.internalid>
 <a0ed3cf6-a58d-4a74-939d-62c9e6643b79@oss.qualcomm.com>
From: Bryan O'Donoghue <bod@kernel.org>
Content-Language: en-GB
Autocrypt: addr=bod@kernel.org; keydata=
 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
In-Reply-To: <a0ed3cf6-a58d-4a74-939d-62c9e6643b79@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/10/2026 12:08, Vikash Garodia wrote:
>> https://github.com/devicetree-org/dt-schema/pull/207
>>
>> Perhaps splitting this into two patches as an iommu-series would be best.
> Intention was to keep the patch to add iommu-ranges property as part of
> iris driver patches to show the usage of this new property.
> 
> I am fine either ways, whatever it takes for the maintainers of this
> file to review.
> 
> Regards,
> Vikash
> 
>>>            end = maps + size / sizeof(__be32);
>>> @@ -258,6 +367,9 @@ void of_iommu_get_resv_regions(struct device *dev,
>>> struct list_head *list)
>>>                    }
>>>                    type = iommu_resv_region_get_type(dev, &phys, iova,
>>> length);
>>> +                if (type != IOMMU_RESV_DIRECT)
>>> +                    continue;
>>> +
>> If you look in iommu_resv_region_get_type() you can emit
>>
>>           dev_warn(dev, "treating non-direct mapping [%pr] -> [%pap-%pap]
>> as reservation\n", phys,
>>                    &start, &end);
>>           return IOMMU_RESV_RESERVED;
>>
>> on a mismatch - which is not what the code will do now. Mismatch will
>> warn and then not map.
>>
>> So maybe dev_err() saying you won't map - in the new patch for reg.
>> Either way this isn't a change specific to iommu-ranges.

Sure the above needs to be addressed though because its not a straight 
change.

Before if there was a mismatch it would sill be mapped - now we print a 
warning and _don't_ map.

I'm not sure that's really what you meant to do here but if it is it 
should be stated in the git log and IMO it should be a follow on change 
_after_ the initial addition (or before it) stating why mismatched will 
no longer be mapped.

Because add iommu-ranges != don't map mismatched, basically.

---
bod
