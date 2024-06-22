Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4D57FD
	for <iommu@lists.linux.dev>; Sat, 22 Jun 2024 00:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719016332; cv=none; b=Nf9CwE9u81IXtjayMgNb1JWpCkaReDc4jcyGYJkkfcl6T6OkeS4Ls8sqhBakrlhQlniUz1xkRWNvkSBuRjb+qu2nAnU3TvyVPiGjMjgU3jqxRFgEGkm94U+UrGWQEzg9bAcv+DVRJWU1i0Hw5GR8nktOSpL6XpucKENPVGDTqLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719016332; c=relaxed/simple;
	bh=hIZn1UUeNKeNY1HQLRtHpsYDoE285cZ/BP9RtjZJdHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZYqiqkzParRSda+a09uaDyJAJ979IBCY0ACon3fVBaxviKg+KHNJjTRCg2H8+/R29E30te8L0wS+kdCBE07CqSZaynPOHb2ac7AurtY1FBWsS06tIk7o1678H16Yee81w/x2DSwla1GDAN9WKFuMVAvO5W87mnWEmj2gOzax5Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FBcLbVTr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FBcLbVTr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719016329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mehg7iYe9gacUGBo2xgMiIqrkNufQg7M/2JsA9x+O3k=;
	b=FBcLbVTrhvFV7K66F95Qcm1D1a97+ClN1PMjwiHlhxwwCNHX73+2PCRkRO2CNckQicr4in
	dmiNbSux8+A9p1uNCWCRUtXIaSFxV4RfbCvQPc3Jgf9+PgnqC9WfApbTsXyEdTUHjNvqe0
	2b3Y+o2It+13oTnu/syYsj5JLmRqDtI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-b-1Lc4C4OY-veFjTe9kosw-1; Fri, 21 Jun 2024 20:32:07 -0400
X-MC-Unique: b-1Lc4C4OY-veFjTe9kosw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-795d19c522eso382313385a.1
        for <iommu@lists.linux.dev>; Fri, 21 Jun 2024 17:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719016326; x=1719621126;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mehg7iYe9gacUGBo2xgMiIqrkNufQg7M/2JsA9x+O3k=;
        b=sqmPQNnKs1dd12lISboQc29PNQYdSgP3T+eBcSFsKIaTjbs1DkZKyiWVrCMXJ+Sb0u
         6GY4PUQV0vcygUfWno+2P9LY1AXWOltNBw75VZIvhvCSZAKcf4jhqFD+vm1kaLKMt870
         G1H6O9VeENCuWgE1Q8CjHvuffDdwqSwdA1yI/96/jYWB8fYVFKb6pIXpnZxZXnNAa1O7
         GRE4frriAa/7IZ7JzJoQZYkXJH/c0/aaYjlGVcJ7ON9+vL0c82+XTYjbwtqJCk4ELQNS
         Oi9E8iQQDCNWMCdwNvNI1maik3HTwYxv91U0bXD+ErAKDUDNtTyO6JSP/8YC+KNd5gKl
         5dog==
X-Gm-Message-State: AOJu0YxLtNcjjFtAX6fAOkCd42D8Ie1ThP/cM+TcxyKfYf1rlMnvfKRx
	ITNEco05O3YV9EL8P5o4Fqj21rRmC38HOjwfJsJoW2Vx/qQYiAnSfQG2+laNAQaBRquTTfnahGX
	B1WRtye+BOraYqTm7OCAGfwbrPPp8MCXzVBJ6Syo1ixuP1a9BmEBK
X-Received: by 2002:a05:620a:444c:b0:795:5d6a:34f0 with SMTP id af79cd13be357-79bb3ee6c86mr1108926685a.75.1719016326670;
        Fri, 21 Jun 2024 17:32:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEt9HnK+mUZP6Q/3jYtWobj1ADK3YzPG4viQ4Cy3qdby2TtN7QQfUrxtgBz7m2v6qInn9prdQ==
X-Received: by 2002:a05:620a:444c:b0:795:5d6a:34f0 with SMTP id af79cd13be357-79bb3ee6c86mr1108925485a.75.1719016326349;
        Fri, 21 Jun 2024 17:32:06 -0700 (PDT)
Received: from localhost (ip98-179-76-110.ph.ph.cox.net. [98.179.76.110])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce91f288sm127044885a.89.2024.06.21.17.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 17:32:05 -0700 (PDT)
Date: Fri, 21 Jun 2024 17:32:04 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com, 
	=?utf-8?B?QsWCYcW8ZWogU3pjenlnaWXFgg==?= <spaz16@wp.pl>
Subject: Re: [PATCH rc] iommu/amd: Fix GT feature enablement again
Message-ID: <ra4nsmclnp27vm6himfmrefxtczknf4rnsd5zbynvcsoig3irg@iccfqj6n7tt7>
References: <20240621101533.20216-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240621101533.20216-1-vasant.hegde@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jun 21, 2024 at 10:15:33AM GMT, Vasant Hegde wrote:
> Current code configures GCR3 even when device is attached to identity
> domain. So that we can support SVA with identity domain. This means in
> attach device path it updates Guest Translation related bits in DTE.
> 
> Commit de111f6b4f6a ("iommu/amd: Enable Guest Translation after reading
> IOMMU feature register") missed to enable Control[GT] bit in resume
> path. Its causing certain laptop to fail to resume after suspend.
> 

Does this bring back the issue that de111f6b4f6a was trying to fix in
relation to getting a bad value in the IVRS table?

> This is because we have inconsistency between between control register
> (GT is disabled) and DTE (where we have enabled guest translation related
> bits) in resume path. And IOMMU hardware throws ILLEGAL_DEV_TABLE_ENTRY.
> 
> Fix it by enabling GT bit in resume path.
> 
> Reported-by: Błażej Szczygieł <spaz16@wp.pl>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218975
> Fixes: de111f6b4f6a ("iommu/amd: Enable Guest Translation after reading IOMMU feature register")
> Tested-by: Błażej Szczygieł <spaz16@wp.pl>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/init.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 161248067776..c89d85b54a1a 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -2743,6 +2743,7 @@ static void early_enable_iommu(struct amd_iommu *iommu)
>  	iommu_enable_command_buffer(iommu);
>  	iommu_enable_event_buffer(iommu);
>  	iommu_set_exclusion_range(iommu);
> +	iommu_enable_gt(iommu);
>  	iommu_enable_ga(iommu);
>  	iommu_enable_xt(iommu);
>  	iommu_enable_irtcachedis(iommu);
> -- 
> 2.31.1
> 

