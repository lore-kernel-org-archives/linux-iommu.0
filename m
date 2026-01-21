Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F028D407562;
	Wed, 21 Jan 2026 14:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769004813; cv=none; b=Q6WmP9ZXgGoEZB9E6nY3Tt5qLfz1MM4Z0ZPpZv/gebR07TZo1GX5hymsmof1mMuO0OheQs0bWpn3dH+zKGneUwJq2mgLXxBkttw4Qo14R3dMga+uUuj1UsdwrraHdX5pu1SfHxm5+yNDRGxiasr0ZtG5gXm5O1XMBWs57fkBKlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769004813; c=relaxed/simple;
	bh=hT/Lb4kvN9r9/VgCjGWMqaym3fBn5y3YdB99iQF+KS0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=j470sg5MMlnYYruCosJ/O9DSCZp8x+B4WKO+547/RlLSbrru03j7zY5J5hInGHYj7/zcbfFCr8GEl9WRiOv0nrNb1U5+WcU+egqTaE5OdKaA/EOQ0gquxLYkF/njVmfq1smR4KBxOeBuLC539vx9ttQ1//4hL3C6BgoBrBsaRkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlFHSx3H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlFHSx3H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A49C19424;
	Wed, 21 Jan 2026 14:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769004812;
	bh=hT/Lb4kvN9r9/VgCjGWMqaym3fBn5y3YdB99iQF+KS0=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=OlFHSx3H0fc/+r2aVJdm2pdBMxOEYvxl6a6dO64dwFfQLVBBqJT1I9EjA0i4iyFNV
	 MiwARU4GpWy8F46eL9wRbGAjM/Ty801cK1by/dQuvkiq7Btntffi6/vsY9U9VOOQxe
	 zP3aadIRHZigwjzlXtOoFWGwDH3gTecuyWPFRt4bHac+ipO3qbUuC3xvwwGvGp+Diu
	 oJrfBDl/toYq+1FK0D1R/qu97umP8T410nuAquWXZe2xQaSFPoecNJiDzjAJczOQFd
	 jyqbvJ1Q0P/I5sHuLtBn4ivYDF6QjAh297e+LelcqGewuca305S0GD4YtjQnIl0BzB
	 AJDeQ8J2A+y1A==
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Jan 2026 15:13:28 +0100
Message-Id: <DFUBV9W83Q46.NJ8CDRLL3SJ3@kernel.org>
Subject: Re: [PATCH v5] driver core: enforce device_lock for
 driver_match_device()
Cc: "Wang Jiayue" <akaieurus@gmail.com>, <hanguidong02@gmail.com>,
 <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <Aishwarya.TCV@arm.com>,
 <broonie@kernel.org>, <chenqiuji666@gmail.com>,
 <linux-kernel@vger.kernel.org>, <m.szyprowski@samsung.com>,
 <robin.clark@oss.qualcomm.com>, <will@kernel.org>, <joro@8bytes.org>,
 <iommu@lists.linux.dev>
To: "Robin Murphy" <robin.murphy@arm.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <CALbr=LYt-MqGM0ua78Rt7M679WR9hNnk0Or-WrB2myZ=KhaN0w@mail.gmail.com> <20260121085549.165428-1-akaieurus@gmail.com> <DFU7CEPUSG9A.1KKGVW4HIPMSH@kernel.org> <DFU7SVI5SYE5.3MJP2ECGGZK5P@kernel.org> <0c0d3707-9ea5-44f9-88a1-a65c62e3df8d@arm.com>
In-Reply-To: <0c0d3707-9ea5-44f9-88a1-a65c62e3df8d@arm.com>

On Wed Jan 21, 2026 at 2:03 PM CET, Robin Murphy wrote:
> On 2026-01-21 11:02 am, Danilo Krummrich wrote:
>> On Wed Jan 21, 2026 at 11:40 AM CET, Danilo Krummrich wrote:
>>> So, the problem is that in the callstack of the arm-smmu driver's (a pl=
atform
>>> driver) probe() function, the QCOM specific code (through arm_smmu_impl=
_init())
>>> registers another platform driver. Since we are still in probe() of arm=
-smmu the
>>> call to platform_driver_register() happens with the device lock of the =
arm-smmu
>>> platform device held.
>>>
>>> platform_driver_register() eventually results in driver_attach() which =
iterates
>>> over all the devices of a bus. Since the device we are probing and the =
driver we
>>> are registering are for the same bus (i.e. the platform bus) it can now=
 happen
>>> that by chance that we also match the exact same device that is current=
ly probed
>>> again. And since we take the device lock for matching now, we actually =
take the
>>> same lock twice.
>>>
>>> Now, we could avoid this by not matching bound devices, but we check th=
is
>>> through dev->driver while holding the device lock, so that doesn't help=
.
>>>
>>> But on the other hand, I don't see any reason why a driver would call
>>> platform_driver_register() from probe() in the first place. I think dri=
vers
>>> should not do that and instead just register the driver through a norma=
l
>>> initcall.
>>>
>>> (If, however, it turns out that registering drivers from probe() is som=
ething we
>>> really need for some reason, it is probably best to drop the patch and =
don't
>>> make any guarantees about whether match() is called with the device loc=
k held or
>>> not.
>>>
>>> Consequently, driver_override must be protected with a separate lock (w=
hich
>>> would be the cleaner solution in any case).)
>>=20
>> I assume that this should resolve the problem (unless there are more dri=
vers
>> that register drivers in probe()):
>>=20
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/=
arm/arm-smmu/arm-smmu-qcom.c
>> index 573085349df3..9bb793efc35f 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> @@ -774,10 +774,6 @@ struct arm_smmu_device *qcom_smmu_impl_init(struct =
arm_smmu_device *smmu)
>>   {
>>          const struct device_node *np =3D smmu->dev->of_node;
>>          const struct of_device_id *match;
>> -       static u8 tbu_registered;
>> -
>> -       if (!tbu_registered++)
>> -               platform_driver_register(&qcom_smmu_tbu_driver);
>>=20
>>   #ifdef CONFIG_ACPI
>>          if (np =3D=3D NULL) {
>> @@ -802,3 +798,5 @@ struct arm_smmu_device *qcom_smmu_impl_init(struct a=
rm_smmu_device *smmu)
>>=20
>>          return smmu;
>>   }
>> +
>> +builtin_platform_driver(qcom_smmu_tbu_driver);
>>=20
>> @qcom maintainers: I'm aware of commit 0b4eeee2876f ("iommu/arm-smmu-qco=
m:
>> Register the TBU driver in qcom_smmu_impl_init"), but I think the above =
patch
>> should work fine as it is still *not only* registered when
>> CONFIG_ARM_SMMU_QCOM_DEBUG?
>
> In principle there should be nothing wrong with registering the driver=20
> unconditionally - that existing tbu_registered logic looks racy in the=20
> face of async_probe anyway - however I don't think the *_platform_driver=
=20
> macros will work here, as this all gets combined into arm_smmu.ko=20
> wherein ending up with multiple module_init declarations breaks the build=
.
>
> (Please do double-check all the build permutations of ARM_SMMU,=20
> ARM_SMMU_QCOM and ARM_SMMU_QCOM_DEBUG)

Indeed, I accounted for this in the final patch I sent out, thanks!
