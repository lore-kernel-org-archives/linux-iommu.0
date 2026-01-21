Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E9F2FAC14;
	Wed, 21 Jan 2026 14:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769004464; cv=none; b=RVWRdCMl3DFQCHrtjcIiP3u0U3b96CYkvuYR6N+18Ob8siekTwce43FA6CZ2TWk4RQbdOgxaBHvNVw/rsnGw67ebkIFJAOd3TYiMGqkoWXejetxcH4PqP65zPnnQJl2yFwOeTAr/7VfrxfCYsF5c6bKHODmBUbAWHC7ZLKl48wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769004464; c=relaxed/simple;
	bh=1p+gfSfGxm9mZ78viLelVBy6vHdyo8DHwhMtpzOkZgU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=ef4VHi2Jac5EX8QYxcRJR8DbZm5sYf4D6+rOGEf9B7XrhCGx3hVYnUz7a03nKwYT4pp7xWiN/oEYEDd0RiD0I5qq4Hf3yibrJgSzFNoPdzgrLfVYp0tvBIBCYtaFV4vUnZKt+xVB+4Mb1/xpabwnARadlg3L7ca/pxogeIRbbn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSJnig8O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSJnig8O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D838C4CEF1;
	Wed, 21 Jan 2026 14:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769004463;
	bh=1p+gfSfGxm9mZ78viLelVBy6vHdyo8DHwhMtpzOkZgU=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=jSJnig8OB28vkDhOxwum3npqVBKUlRO8EkE/pfnlNUHLWIo4SZNJQAObdTc9M6eLB
	 4XVr19bSZcdhKTs6EjDOSpmWBHpCK381ZlEDxy+K8JAZald5CFKePEFaMA3mDCcPwN
	 DFilr6Qd426EWqQJGSQARFeXGTKwNTwupOmHci5tnd1V+Q4zpnt86Cg3QJLVnYjlBs
	 7DVp+xD4Fyk+vcSbP6zBvJQxFKqBU3h6HMw6PHQekUc9YnycjJqyYbZNZzA9Gkj8MN
	 LPtAezUZjybDf6vEgcj76B0LESYvpojaaK/y4Amhi+5jVJNcb7VHCaszfT4MB5jNOk
	 WaSe7JvqLaFyg==
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Jan 2026 15:07:38 +0100
Message-Id: <DFUBQTBJJ8N8.DK0KCGBTV1UL@kernel.org>
Subject: Re: [PATCH v5] driver core: enforce device_lock for
 driver_match_device()
Cc: "Mark Brown" <broonie@kernel.org>, "Wang Jiayue" <akaieurus@gmail.com>,
 <hanguidong02@gmail.com>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <Aishwarya.TCV@arm.com>, <chenqiuji666@gmail.com>,
 <linux-kernel@vger.kernel.org>, <m.szyprowski@samsung.com>,
 <robin.clark@oss.qualcomm.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
 <iommu@lists.linux.dev>, <quic_c_gdjako@quicinc.com>,
 <dmitry.baryshkov@linaro.org>, <dmitry.baryshkov@oss.qualcomm.com>
To: "Will Deacon" <will@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <CALbr=LYt-MqGM0ua78Rt7M679WR9hNnk0Or-WrB2myZ=KhaN0w@mail.gmail.com> <20260121085549.165428-1-akaieurus@gmail.com> <DFU7CEPUSG9A.1KKGVW4HIPMSH@kernel.org> <DFU7SVI5SYE5.3MJP2ECGGZK5P@kernel.org> <789030ba-c5bd-4c1d-a10a-2bed4fd76dce@sirena.org.uk> <DFUA41G0WJ04.3TZX9914SM60E@kernel.org> <aXDOg9YXqWyV3JTR@willie-the-truck>
In-Reply-To: <aXDOg9YXqWyV3JTR@willie-the-truck>

On Wed Jan 21, 2026 at 2:02 PM CET, Will Deacon wrote:
> On Wed, Jan 21, 2026 at 01:50:52PM +0100, Danilo Krummrich wrote:
>> On Wed Jan 21, 2026 at 1:49 PM CET, Mark Brown wrote:
>> > On Wed, Jan 21, 2026 at 12:02:15PM +0100, Danilo Krummrich wrote:
>> >
>> >> I assume that this should resolve the problem (unless there are more =
drivers
>> >> that register drivers in probe()):
>> >
>> > This makes sense to me, I guess we can just fix any other instances as
>> > they arise.  Will you send the patch?
>>=20
>> Yes, I will send it soon.
>
> Please make sure you cc Dmitry and Georgi when you do that.

Sure!

> I'm worried that you proposal means we run the probe code once per TBU, w=
hich
> looks like it will break.

It shouldn't change anything in this regard. It only changes when the
qcom_smmu_tbu_driver is registered, initcall vs probe() of another driver.

- Danilo
