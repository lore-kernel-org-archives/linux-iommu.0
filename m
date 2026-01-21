Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3E348A2CA;
	Wed, 21 Jan 2026 12:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768999857; cv=none; b=o2SzBHGywLKtcc3kssII6nyYCECKHdndHLy1rLiQMr+Tc2oDcUxlHaZ4/Qp/7KVfsBggWZShW/BYV4jDUvqt5+eXk/6AAH5Awd2zWN7Mr8hDdWLE5RxfwemavYr2+/3QvbmudMkz9I6/zr+k7LG79DecgyoDiKuk4zY2W1Kc6fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768999857; c=relaxed/simple;
	bh=4JAur7llvguIAmMUDHp790ZHmuw0p6cxamedtw+ULo0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=hF+RiU3gmfYg0uKL2ln8y5gy1uE1swKT4m9EYIfLd1HIQfsjRRhhfFmwBD22DdrkMMCKhLHNO4hvE+FfmWZPswTTTpQ9FKrG1EEzLQy95khpR5kCe7nFjBCb0qtXKbl9T7xMWRau80MW75itVpY9iPJrL4LCsqM5RMgnnRQQc1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vip49Vfk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vip49Vfk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C45C19424;
	Wed, 21 Jan 2026 12:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768999857;
	bh=4JAur7llvguIAmMUDHp790ZHmuw0p6cxamedtw+ULo0=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Vip49VfkeE21xXyn+cg4qHDjDIBlo+7R5mkWtWUOwcnq4NNnROclQv/1MsuIMcqFY
	 Aw8IwrU0K9jX8NCRBN260SH7PAYfCCdPQSJArDwEel6mhsnyBAJnVWnke0FR+F4c6y
	 7ML0Biy83sJIhsjRl/XeDvrK8LyUcRpjHPxY7i7pYf927jmZOwu2EawTqm0CL1xEdj
	 A82QP7ApgJZauyiKV6QD5NQvr9q8IenJTu/jEtTwV6/3Qq24tSWYo384fK+uA8fOuk
	 0Tqihc/WQVDzLq4A+eLOQ//AYHuuGWjwfrFe9MJFdH/0nckdeSrDTjZ2alrh8ivvpM
	 AV1M6xhDC9tsw==
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Jan 2026 13:50:52 +0100
Message-Id: <DFUA41G0WJ04.3TZX9914SM60E@kernel.org>
Subject: Re: [PATCH v5] driver core: enforce device_lock for
 driver_match_device()
Cc: "Wang Jiayue" <akaieurus@gmail.com>, <hanguidong02@gmail.com>,
 <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <Aishwarya.TCV@arm.com>,
 <chenqiuji666@gmail.com>, <linux-kernel@vger.kernel.org>,
 <m.szyprowski@samsung.com>, <robin.clark@oss.qualcomm.com>,
 <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
 <iommu@lists.linux.dev>
To: "Mark Brown" <broonie@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <CALbr=LYt-MqGM0ua78Rt7M679WR9hNnk0Or-WrB2myZ=KhaN0w@mail.gmail.com> <20260121085549.165428-1-akaieurus@gmail.com> <DFU7CEPUSG9A.1KKGVW4HIPMSH@kernel.org> <DFU7SVI5SYE5.3MJP2ECGGZK5P@kernel.org> <789030ba-c5bd-4c1d-a10a-2bed4fd76dce@sirena.org.uk>
In-Reply-To: <789030ba-c5bd-4c1d-a10a-2bed4fd76dce@sirena.org.uk>

On Wed Jan 21, 2026 at 1:49 PM CET, Mark Brown wrote:
> On Wed, Jan 21, 2026 at 12:02:15PM +0100, Danilo Krummrich wrote:
>
>> I assume that this should resolve the problem (unless there are more dri=
vers
>> that register drivers in probe()):
>
> This makes sense to me, I guess we can just fix any other instances as
> they arise.  Will you send the patch?

Yes, I will send it soon.
