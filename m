Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E4440B6EB
	for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 17:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768929870; cv=none; b=Ip59Jv58JbblzSOR+1IJhh00zw0V5MQf2F9D+p5BhGKpOrHB8rAIg/p4ZaA2BeUfHSxvdCT9wA8fu1CWO2cyfWYuRMGN/01ilzh4bd+EfgeOXu90uYkvq9Xxq9glJp2R2XSHQtn3d0bgyC9FVdk/EUCyfjQsYeLxIIeWsot32e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768929870; c=relaxed/simple;
	bh=5bL60qb20EhXrNOMh7AxwUBB3DdXknRv7p7jngQupDs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uESG3ju8Pv3I4MFD9HU5nBiFsmB9U1PTd2SIsf34JAiBEMdlRGXm+yV8SP0yGnAIIdGtmOQ9wARVLDqvd98ClQbPqTvszN/hBQbhINf0wbDkpQdXOdijXcFedPROp8UqBog3/EF0nsypYi268UlPv9s1fGlKt0E1J3+WzjpQwdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AMr8o2aW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AMr8o2aW"
Received: from localhost (unknown [20.236.11.29])
	by linux.microsoft.com (Postfix) with ESMTPSA id BEBBD20B716A;
	Tue, 20 Jan 2026 09:24:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BEBBD20B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768929869;
	bh=rAvan7uCS/VjRPrCEciTwP185oGdpk264vz99WC0BcA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AMr8o2aWp+BZuJzQJp5J4o+czJMcOadfzoj+Z4jSuc+5pG250oHlKQpwrMoEAJZpN
	 i6u1mcB2FzH97Cz6AVHZW+5DvD4DemMEYxw9y/8e6LxacmimbRT0/Ds8Os8aaCLjrS
	 9+d8t/41ktfoEsARHelnZepkQ9otyh3Yb+u9pfDc=
Date: Tue, 20 Jan 2026 09:24:27 -0800
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: <iommu@lists.linux.dev>, <vasant.hegde@amd.com>,
 <suravee.suthikulpanit@amd.com>, <joro@8bytes.org>, <will@kernel.org>,
 <robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
 <Srikanth.Aithal@amd.com>
Subject: Re: [PATCH] iommu/amd: serialize sequence allocation under
 concurrent TLB invalidations
Message-ID: <20260120092427.00001794@linux.microsoft.com>
In-Reply-To: <abcfda19c05becb988ede3a1a0ba6d87161943bf.1768899638.git.Ankit.Soni@amd.com>
References: <abcfda19c05becb988ede3a1a0ba6d87161943bf.1768899638.git.Ankit.Soni@amd.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ankit,

On Tue, 20 Jan 2026 09:05:07 +0000
Ankit Soni <Ankit.Soni@amd.com> wrote:

> With concurrent TLB invalidations, completion wait randomly gets
> timed out because cmd_sem_val was incremented outside the IOMMU
> spinlock, allowing CMD_COMPL_WAIT commands to be queued out of
> sequence and breaking the ordering assumption in wait_on_sem().
> Move the cmd_sem_val increment under iommu->lock so completion
> sequence allocation is serialized with command queuing.
> And remove the unnecessary return.
>=20
> Fixes: d2a0cac10597 ("iommu/amd: move wait_on_sem() out of spinlock")
>=20
> Tested-by: Srikanth Aithal <sraithal@amd.com>
> Reported-by: Srikanth Aithal <sraithal@amd.com>
> Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index d7f457338de7..593fb879b7b0 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -1422,6 +1422,12 @@ static int iommu_queue_command(struct
> amd_iommu *iommu, struct iommu_cmd *cmd) return
> iommu_queue_command_sync(iommu, cmd, true); }
> =20
> +static u64 get_cmdsem_val(struct amd_iommu *iommu)
> +{
> +	lockdep_assert_held(&iommu->lock);
> +	return atomic64_inc_return(&iommu->cmd_sem_val);
Do we still need this to be atomic now that it=E2=80=99s protected by a
spinlock?

> +}
> +
>  /*
>   * This function queues a completion wait command into the command
>   * buffer of an IOMMU
> @@ -1436,11 +1442,11 @@ static int iommu_completion_wait(struct
> amd_iommu *iommu) if (!iommu->need_sync)
>  		return 0;
> =20
> -	data =3D atomic64_inc_return(&iommu->cmd_sem_val);
> -	build_completion_wait(&cmd, iommu, data);
> -
>  	raw_spin_lock_irqsave(&iommu->lock, flags);
> =20
> +	data =3D get_cmdsem_val(iommu);
> +	build_completion_wait(&cmd, iommu, data);
> +
>  	ret =3D __iommu_queue_command_sync(iommu, &cmd, false);
>  	raw_spin_unlock_irqrestore(&iommu->lock, flags);
> =20
> @@ -3119,10 +3125,11 @@ static void
> iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
> return;=20
>  	build_inv_irt(&cmd, devid);
> -	data =3D atomic64_inc_return(&iommu->cmd_sem_val);
> -	build_completion_wait(&cmd2, iommu, data);
> =20
>  	raw_spin_lock_irqsave(&iommu->lock, flags);
> +	data =3D get_cmdsem_val(iommu);
> +	build_completion_wait(&cmd2, iommu, data);
> +
>  	ret =3D __iommu_queue_command_sync(iommu, &cmd, true);
>  	if (ret)
>  		goto out_err;
> @@ -3136,7 +3143,6 @@ static void iommu_flush_irt_and_complete(struct
> amd_iommu *iommu, u16 devid)=20
>  out_err:
>  	raw_spin_unlock_irqrestore(&iommu->lock, flags);
> -	return;
>  }
> =20
>  static inline u8 iommu_get_int_tablen(struct iommu_dev_data
> *dev_data)

