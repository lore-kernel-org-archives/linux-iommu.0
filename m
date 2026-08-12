Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB16279DB6;
	Wed, 12 Aug 2026 02:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786501149; cv=none; b=lsHGUTM9+7sxkilWHbBq5ds+5bSVvo8ZhZhq6ALP4iA+/IcVSjm/lB7UI2Sb7zcBAHHF2kc8qNGRImvOp1nfAxPxkrNXUbet4rqtRitElD7hf7fPL8O7tGNrJYAQBCOOaP1kBFfdhnQmBjSK4ZxDzsSJte0i9PsEgYeegwKdB1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786501149; c=relaxed/simple;
	bh=k1vXOZvYRnfs9hRYQLoxONrEwGhlRHk2wwZ+9XOy0H8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDWarCD1yXAXk7qDT7ysszMDb3A8R5R5yplQpFjDFgq+0DmQAQsrbFrYdaHUYyLUI6T+i/Yd5m4iucDqDAo0uxC9lTNpw4msQmQACsrJtK2+K0QbYcozCShDeI2P96ELMjCgpRxDEnzGCDw+EZzjwHJ8Csruy6t64cXIa7iZuqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNdNZeAO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNdNZeAO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FDC1F000E9;
	Wed, 12 Aug 2026 02:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786501148;
	bh=ycLlSOHTauxo4PZFYfru/N1BjjuXsszYlQ61e8B13FU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KNdNZeAOTmL3g1Q5f+zq4R+xp1YeQQortTkMT0z7ccREjUF0IUtWx04ovwNbjShWg
	 qPjNk7jrLRV8UOYUX6eUDwqgIg6Ly4YIyx4kS/zij1c/e0KSdPKyU7DLf6INYqIhL+
	 RKlVAk5n+BLOWEzD65T1VUfCImRT6SaTAb9PW7fara1QBzt8GNkF8E5rgZelRYxzIV
	 gKtG+XeQwW2NWQ8Vs8PQFwl8AfJ0QuUGuvbH77ZALY2FZSWi9iowSRXoLrp1gTGFR0
	 eaaZyv6IpvMShZJynGMEn+iSboKMwe8XoW7knKBTFZtmUyzoDz6D+RJ34e+1ed/IuW
	 8PTxG5rAC1qVg==
Date: Tue, 11 Aug 2026 19:19:06 -0700
From: Drew Fustini <fustini@kernel.org>
To: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Cc: joro@8bytes.org, palmer@dabbelt.com, tony.luck@intel.com,
	reinette.chatre@intel.com, tomasz.jeznach@linux.dev,
	will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
	aou@eecs.berkeley.edu, alex@ghiti.fr, Dave.Martin@arm.com,
	james.morse@arm.com, babu.moger@amd.com, corbet@lwn.net,
	shuah@kernel.org, jgg@ziepe.ca, kevin.tian@intel.com,
	cuiyunhui@bytedance.com, yuanzhu@bytedance.com,
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC PATCH 3/7] resctrl: Add a devices file for external
 requester assignment
Message-ID: <anvYGuNF3MC//Q94@x1>
References: <20260714130657.46963-1-zhangzhanpeng.jasper@bytedance.com>
 <20260714130657.46963-4-zhangzhanpeng.jasper@bytedance.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714130657.46963-4-zhangzhanpeng.jasper@bytedance.com>

On Tue, Jul 14, 2026 at 09:06:53PM +0800, Zhanpeng Zhang wrote:
> Do not overload the resctrl tasks file with architecture-specific
> non-PID tokens. The tasks ABI remains a list of task IDs, while the new
> devices file carries external requesters assigned to a resctrl group.
> 
> Add architecture hooks for assigning and showing those external
> objects, and reject group removal, reparenting, or pseudo-lock setup
> while devices are still assigned. The teardown path performs a
> best-effort reset to the default group.
> 
> The devices file is an assignment interface only. It does not describe
> a new resource schema or domain; resource allocation and monitoring
> policy remain described by the existing schemata and info files.
> 
> Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
> ---
>  Documentation/filesystems/resctrl.rst |  26 ++++
>  arch/Kconfig                          |   6 +
>  fs/resctrl/rdtgroup.c                 | 206 +++++++++++++++++++++++++-
>  include/linux/resctrl.h               |  45 ++++++
>  4 files changed, 280 insertions(+), 3 deletions(-)
[..]
> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
> index af2cbab14497..2e424c911049 100644
> --- a/fs/resctrl/rdtgroup.c
> +++ b/fs/resctrl/rdtgroup.c
[..]
> @@ -2067,6 +2236,16 @@ static struct rftype res_common_files[] = {
>  		.seq_show	= rdtgroup_tasks_show,
>  		.fflags		= RFTYPE_BASE,
>  	},
> +#ifdef CONFIG_ARCH_HAS_RESCTRL_DEVICES
> +	{
> +		.name		= "devices",
> +		.mode		= 0644,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.write		= rdtgroup_devices_write,
> +		.seq_show	= rdtgroup_devices_show,
> +		.fflags		= RFTYPE_BASE,

Once CONFIG_ARCH_HAS_RESCTRL_DEVICES is built in, the file shows up in
every resctrl group directory, even on hardware whose IOMMU does not
implement QOSID. I think it would be better to make fflags zero so
rdtgroup_add_files() skips it, and enable it at runtime from
resctrl_init().

Thanks,
Drew
