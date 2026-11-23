Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795417403;
	b=q2oWbCkCaR6TQwLwnS3XwQ8xsXNdwCzgD6hjbBjcWdVmLXuvDs6zcoCCYPjB4mUL0usr
	 qdp5uahD+0WvCPiGIbAVXXNVoOwrjyT+m5EgfQh3EG5NpAswzOBZxNftRsjLtlFB0SS7W
	 EN9fFjvl8TZFn9GqaJULnZ4zSsyFEC1yIbEkV9Rb/tgXquhMkEpDVsAgOMsBjlenp5ZeM
	 G+YY/Y0tibjGN6rAvzRfrP44ROKoxXX7GXOmmNBZQFkoYzHxO0aKx9LqAuzu/STjWuRII
	 /DApQebyrYyaJQunLaQ3ywKw8/dLy3fgUy3rQY/NCHdeanXo2bBUsX8iNWs3meh4XMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795417403;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=66EgM4zK7IG8zCwjPTbi5vNEz/2nI2TGX5jJdEmsI1w=;
	b=3f5TkPYFlv98HwsK6RC6LPnq0uhUSXqZVYXTGH17ufwO0Y/Iu99d6jcvS0QHZQEjcDx0
	 aeQuLbLcQBoLcO/HqqBrBceKrtrUf2tbZol98WaevZ+hc/wyURviL/HalBbkDVhhoLZU5
	 NH1A+N9T5fUgP5JkUgitaLxk1sqbYu8BYoyY02rUEPu0EIHN2BJt9GI5zhw7kJiev88YU
	 yR+j6x8F7CRiKPSAzBW+X0fimudut8FjiRedqUPRtxZtzo+Esd+OrDigCtcKWsuVLnSCV
	 XK4QMh65f94zRrQ4Q6H3E6Hm6L1gf+w0gxyStIdpoALe9oUdCc+fMw9tq3sOJ1MWbGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="L/sdxyYw";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5AA606A31A;
	Mon, 23 Nov 2026 07:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L/sdxyYw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D6F1F000C6;
	Mon, 23 Nov 2026 07:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795417403;
	bh=66EgM4zK7IG8zCwjPTbi5vNEz/2nI2TGX5jJdEmsI1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L/sdxyYwswL8f2rMWAqr3ihbnMkAIAtcHSXZRSy1l2QDyg2A5hK52dS56/KD4UCo7
	 1ScMdhRxOaGteIvmGFmYqewqT2eyLZrYpFuwojA56X3B23UiCtYFXm8vId9JR350MW
	 9U4SPAhiFXoTw+42YLk72O8/c6kIaTa1XF6dNdym/wWvhVdQ1zCsOhNgtJQ6ufyDVE
	 m+fALj0z0zXsa3XoifoTRsQjrMkTs7CpOnqPalJtmgSlX4AAC+65LdUeDTpOz/we0s
	 y4UHq0Vu3UKF4UdufTGdwVKu8ZGlpr0fM64QnMSUs3yPdgkW/YiLNcq+bVI9sj1qu5
	 vBNGDLVQc1tsA==
Date: Sun, 22 Nov 2026 23:03:21 -0800
From: Drew Fustini <fustini@kernel.org>
To: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Cc: joro@8bytes.org, palmer@dabbelt.com, tony.luck@intel.com,
	reinette.chatre@intel.com, tomasz.jeznach@linux.dev, jgg@ziepe.ca,
	james.morse@arm.com, ben.horgan@arm.com, xiaqinxin@huawei.com,
	will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
	aou@eecs.berkeley.edu, alex@ghiti.fr, Dave.Martin@arm.com,
	babu.moger@amd.com, kevin.tian@intel.com, corbet@lwn.net,
	skhan@linuxfoundation.org, shuah@kernel.org,
	randy.dunlap@infradead.org, cuiyunhui@bytedance.com,
	yuanzhu@bytedance.com, iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	x86@kernel.org
Subject: Re: [RFC PATCH v2 0/4] resctrl: Assign registered devices to
 resource groups
Message-ID: <awPlOY9vr8Mqq2vJ@thelio>
References: <20261116071338.35991-6-zhangzhanpeng.jasper@bytedance.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116071338.35991-6-zhangzhanpeng.jasper@bytedance.com>

On Mon, Nov 16, 2026 at 03:13:39PM +0800, Zhanpeng Zhang wrote:
> This RFC lets resctrl groups include devices as well as CPU tasks. It
> uses the RISC-V IOMMU QoS ID extension as the first provider and builds
> on Drew Fustini's CBQRI resctrl v12 series [1] on Linux v7.4-rc1.

It does not seem like riscv-iommu in qemu models qosid. Are you testing
this on a hardware implementation?

> Feedback would be particularly helpful on:
> 
>   * The provider registration and lifetime contract, including how to
>     represent devices that share a tagging context.
>   * The bus/name token versus using an existing sysfs identity.
>   * The scope of protection after a command queue failure. If an update
>     leaves the hardware state uncertain, the current code prevents ID
>     reuse by blocking group removal and future mounts, including for
>     groups unrelated to the failed update. Would reserving only the
>     affected old and target IDs be sufficient?

It seems like blocking future mounts would be too much since resctrl
should still be able to handle cpu tasks.

Thanks,
Drew
