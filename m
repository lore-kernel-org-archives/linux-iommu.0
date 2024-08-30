Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44701BE24B
	for <iommu@lists.linux.dev>; Fri, 30 Aug 2024 20:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725049256; cv=none; b=g9Rwdpd5kGOyA6O/jG219RKMPv55BrS/WJxI34j0EzRXKRAHIqIXATi6OxGRe+/1ckn1Wn7ebIP36FyisCbqDTAo2NTQFlN/bWT2dyfXhm6yAbJDCRxv+dcLx40MnmtJBpn7krZErCxyOz60IKG+jLwNlmqiF+QqCkMaZJ8Fm08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725049256; c=relaxed/simple;
	bh=x940T/CWdOLitdTMf0+Kq/bsjfn2qskNi3/i39EhhZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlYIsjajpepMoABjzJSNOylhUUCF6qMEfXYeLmfVvIG+axccuGwI/cQwlO3rFPuF/jOQ8HBnI2M/oDMjkcmZmYzJVAwNz+qpJJLq6zUf5zC4MPA2f0Hy5h/uqSBlIUhgOCbQV0HEfnd7daMeGmu7Jgofr1airCKK9kyuTa1HCGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JsKF84kZ; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JsKF84kZ"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a812b64d1cso73646985a.0
        for <iommu@lists.linux.dev>; Fri, 30 Aug 2024 13:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1725049252; x=1725654052; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C3rag6kG53WcMSHubZMStlK3s50dmNUdZFfCovwHxTw=;
        b=JsKF84kZ/GU0H6JFVFn8Y+27f8u8d6OmPZq4VaDITtuhwOBlkuSLMWdUb8nzQ/l908
         o1Z28Rsh9ezMQtU0LybqP3QZOd3+dIB2MWUKeyUwcr++zOptOqd+gjUbxx6XsXbVkClQ
         H0y5fE7W4Vb/EOaiuyTT72r+CViBoJk9mNJJb+iP9Q/MwUVPN6EiN9LPogAuro7D16US
         24vAoPGXVnjIjb6gU4TqGUtwkwR13WjA9V6zQ7GPuG1gOEHw1eTQVE/sFmSeCJdt/WYB
         TvWArDhAsXCkNT+o8YWUzoG84Db3yYDrHjFSjV4A0uOFSqxg4KzjIllRC7RYTKDUmTVD
         KW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725049252; x=1725654052;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C3rag6kG53WcMSHubZMStlK3s50dmNUdZFfCovwHxTw=;
        b=X5oa42ydMWlsuls8A/RtXKxiPV25jyZt3nxSLoFLJ3yWzr9kMEmx4AW3ORS6On1CnV
         1V05KRv3/f3A/4c1GFqDBeposJEAHbqpethZ8SWFtizpapC0D+x3DwEChd3YDtc3XPbE
         AJ4pZlBLbfJnHdDn1bU9eE1vTDiwQyfErEmLNpFCqdKRV8InxFhKkiHmCaOvgRlVvxeP
         uafB3f68BuG9e1jVvx5knvzSfXJ8aeVT4UJTy52fPhQD7j+gxgHlKUj5JqIU1tMY8PW2
         G4NCRyx2sIWniUWpWV45Ydr1GJ3OwJVQgSUo/Ew7YPn38C1XTB/m5uuDU0NbBPg2Cpo2
         S7Jg==
X-Forwarded-Encrypted: i=1; AJvYcCVNBo36roYNqO0LE8HEJKHlhNmeWgX0mIi2T0UdzxdBS5X7XysxqAhmAYo4L2HSFtqHoSWXAg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/bxC9bBPT0YfMVqEou53UbIbYOE5VJ7EpFM3R0mldd12MPkZv
	1LiDfwQOXeH8L+EBqMyqSRITUe0YrrZJzhUPg/5h9L5Sp0WI8nbBzhB0/ggRsIE=
X-Google-Smtp-Source: AGHT+IGa8ZC6ULosslU6KxF4lsKV5fNNPBipe3IFWTAzo3iClKo/pIRjeGZnnW+uV6FdOsonKj5d1Q==
X-Received: by 2002:a05:620a:240c:b0:7a1:e001:bb1b with SMTP id af79cd13be357-7a80429221amr701958385a.60.1725049252392;
        Fri, 30 Aug 2024 13:20:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806c4cd7csm175949185a.69.2024.08.30.13.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 13:20:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sk871-00GaTI-1j;
	Fri, 30 Aug 2024 17:20:51 -0300
Date: Fri, 30 Aug 2024 17:20:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, jean-philippe@linaro.org,
	nicolinc@nvidia.com, mshavit@google.com
Subject: Re: [PATCH v4 1/2] iommu/arm-smmu-v3: Match Stall behaviour for S2
Message-ID: <20240830202051.GA3468552@ziepe.ca>
References: <20240830110349.797399-1-smostafa@google.com>
 <20240830110349.797399-2-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240830110349.797399-2-smostafa@google.com>

On Fri, Aug 30, 2024 at 11:03:47AM +0000, Mostafa Saleh wrote:
> According to the spec (ARM IHI 0070 F.b), in
> "5.5 Fault configuration (A, R, S bits)":
>     A STE with stage 2 translation enabled and STE.S2S == 0 is
>     considered ILLEGAL if SMMU_IDR0.STALL_MODEL == 0b10.
> 
> Also described in the pseudocode “SteIllegal()”
>     if STE.Config == '11x' then
>         [..]
>         if eff_idr0_stall_model == '10' && STE.S2S == '0' then
>             // stall_model forcing stall, but S2S == 0
>             return TRUE;
> 
> Which means, S2S must be set when stall model is
> "ARM_SMMU_FEAT_STALL_FORCE", but currently the driver ignores that.
> 
> Although, the driver can do the minimum and only set S2S for
> “ARM_SMMU_FEAT_STALL_FORCE”, it is more consistent to match S1
> behaviour, which also sets it for “ARM_SMMU_FEAT_STALL” if the
> master has requested stalls.

Hum, that is looking a bit out of date
perhaps. ARM_SMMU_FEAT_STALL_FORCE should definately set stall, but
for stall-optional it should probably only be set if a faulting type
domain is installed (probably on a PASID)..

Still looks Ok

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
