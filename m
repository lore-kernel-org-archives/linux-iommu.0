Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1876282F1D
	for <iommu@lists.linux.dev>; Mon, 13 Apr 2026 16:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096704; cv=none; b=YETwxiIsf1D5YgxJHy2+7bDbpgGrzS+OS2sGZqUwl87gQBdBXw4jXfesOl/YuidewHzo+sNnGmIlM7BBF2Tnjq/pH/qHPTmTbNccKExBnpk9Qi/YcCtdZFwVwDtNDdM13xkUXTXBhxvlrIy5Vd7Us78d+3tQ6K2cqVwKLtDtC9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096704; c=relaxed/simple;
	bh=SCn5wm2yybzmEsHCzOQ6NYQiDsWfUHmQMro1wb2ubo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKVurTzO8g9ndPxNie+kFu4o7WqrK3ystX7E2dGVeqXDwVoE3wuNya4SY3tW9dPoQIECBPFfo7MBEFF5QdImxms6xkWkLN4DbMlGqiANEOkHSol4aaRhifXfFYZBovrkuApckGTVmSfrD2ZbGw//LXcNvIJC/gNleRlVuIHyayM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ktrEb230; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ktrEb230"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-506bcb23a78so33868931cf.3
        for <iommu@lists.linux.dev>; Mon, 13 Apr 2026 09:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776096702; x=1776701502; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5qHTXTqjIeq0VpY7l9NeZbvHarj7L7Wvl8QGhgFW0Qw=;
        b=ktrEb2308OXHxabHEAuMdSh6RtlhqnPywH1QhwvzSFBjb0sd0/PTRTO+GzYxKufJAW
         3uDLPwdB3IiInAC08ZnlNdrSibaxgOvjxmsC/yyPJ1M5fe6RQv/Wn2oqLvzXEQvy1NX1
         IwBLq8N10gwdBT3O41PK97GexyA/6VllGQYw3Q6Yrio2Boh3DJairCU7KDWfktrPHqHO
         mA4n7mS6BdgLWkuYSbdX3b+Y38iAp82F3nKTq2HVv8fwIwzkNonSZpj4KHHmXKpEeMTS
         GpDqOFoyGsfX3wsh50zkggYLP3LLxHwg2hMc3LoSiazRJ5aglNd2QENbxBt/l4lT53Of
         p2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776096702; x=1776701502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qHTXTqjIeq0VpY7l9NeZbvHarj7L7Wvl8QGhgFW0Qw=;
        b=T4i/6RBq2bQsvEChUAWQKZVabvpR0GaWmEr+FIQNm33hEwxuq701JR5a6ypPT/5kku
         Br+5DqM9XqYtjjONH0UVUrfyMVplcuZ2oHfYTZGd71cl7a0hubUI16WPjGHnXk8PWGvH
         IT8RJePyvsMg9AeLNb9sfd+gjQevniyLTRR7GvpsvmlM1tghULaoOY3jRu1gFKRLU6e7
         oFnbR8HcxffWP2/QXv+5b8Fz+ldEj0do8b5peiEMlgwlqY0KoIlMRwrUFX82fOkV+9WS
         cH+KDsc4N3aUTXkhtBEY/OAE6bDuMpAAC4YhlaLewTQhYRWYvv7TZ97fIOOVk//rDSTO
         fG5A==
X-Gm-Message-State: AOJu0Yw6iV6IduMvrKzCxPVTPJOnzViESUIAM5QyE7kWeLSehAr3PbBq
	X1EZhLs25nhXR3TvQuviwQgII7zkd9Y7smOltyizP17ox3zkDoKvHPFLwYCmf/0bgII=
X-Gm-Gg: AeBDieuXxoN+7wStv/BBXse/XvHTXJv56WtwMNxZPnLp0C0c2ZObZiQJUBOyJeOlJ0u
	ZwmC4YLpkDQeLEAM7XF9oFCL+Kcissxy8aywz/bYoYWbg1tRxtSXALkI4tW3krc4QnYk5aU2IAW
	3ygRWvS/0xXibHxxC0d1HB03Vm32T9r2KxGM62D3652tkPlH3a62lnxGlEqBjNAqu3+jJELo2+Y
	CgNdcHsPpAKn03tIcaFcLDiZ795xlICZX37JznZMs4zGwDTQ7/2BM0Zx5F/Q+wh5o6x8MktGM1s
	kpdmM9/iDcLIuut03Bqq8CFwIt/BD8Agh5uJTYDxNhRJyjXnU07LB5o+hzGlcDGzjxmwihW4ED/
	qXTMuZvx9nLacH0uDX4o5FZAxCs8OpZBEjH8l0Ik8SX9zch92LvqqOnkwOmQXBvLmufBHNMF/LG
	+OQj85iqQEaas9gDS7WK3mUEhqVztswJ83IQTiH8y3Msr8fRmjIOxm4mvBMWCLIZFkZ/e4PEcK2
	Xobkw==
X-Received: by 2002:a05:622a:4cce:b0:50b:3e64:9b2a with SMTP id d75a77b69052e-50dd5ada476mr212404671cf.20.1776096701731;
        Mon, 13 Apr 2026 09:11:41 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50dd561adc2sm92695761cf.27.2026.04.13.09.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 09:11:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wCJsy-00000005QJz-2hk6;
	Mon, 13 Apr 2026 13:11:40 -0300
Date: Mon, 13 Apr 2026 13:11:40 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: iommu@lists.linux.dev, vasant.hegde@amd.com,
	suravee.suthikulpanit@amd.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] iommu_pt: support small VA for AMDv1
Message-ID: <20260413161140.GO3694781@ziepe.ca>
References: <cover.1776075533.git.Ankit.Soni@amd.com>
 <64515b0d53c541ae52347ac3c0f90b75bcbde0c2.1776075533.git.Ankit.Soni@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64515b0d53c541ae52347ac3c0f90b75bcbde0c2.1776075533.git.Ankit.Soni@amd.com>

On Mon, Apr 13, 2026 at 02:45:19PM +0000, Ankit Soni wrote:
> When hardware/VM request a small VA limit, the generic page-table code
> clears PT_FEAT_DYNAMIC_TOP. This later causes domain initialization to
> fail with -EOPNOTSUPP.
> 
> Remove the clearing so init succeeds when the VA fits in the starting
> level and no top-level growth is needed.
> 
> Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
> ---
>  drivers/iommu/generic_pt/iommu_pt.h | 4 ----
>  1 file changed, 4 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
