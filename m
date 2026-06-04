Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F6F3C0639
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 05:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780550831; cv=none; b=owYxOGUPXPFj9cJH6D2T9ZDiAmXiTU0th97HqdQIHAdn77AGfIhoGWBbLXfXXQamwHEbKgylpJ5BgXrChfTEog5v4ZuIuOezkZKjOGZvCUJ8zhE+Py3sPuxPHyS9RQ6nT+UtCUYNCozp86XOOyzUC/UzgWIZ80pYsxsQK4Z18Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780550831; c=relaxed/simple;
	bh=6vYccFvpHJxo6gmdS+Et6Gt4nDg85oXfTNZ2IrGNAKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5n3AWhX+JSTWkLdBe9pocnk7eThNpRi5zXH2QYYaT7yrD7YeX8goBRLGDdF8G42T+zbyT4qcqmAD5zD35CuA81QllfVMqRcA+wXAof/3mVSvU5lInQWh8i4v2qfPCLOQyfXRibBS1Etz2ZShUbKPy3NlC3gL5PBAXn7oSujQSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dtfUFgCm; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dtfUFgCm"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c0b1a48855so72675ad.0
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 22:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780550830; x=1781155630; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vqyI6pdg/9zrIkzXA1zT6p8ma6D6NCvwQYYXXSoUzMY=;
        b=dtfUFgCm343tLKImW7NRkwggZ2PA+5JkLueLhilHs/CoF6bdcg1upVJklx7fH5OX8z
         arL0I2KIuBRoT+qJOTwYj7EGZGez43PXnhPggOeOwPKrfSzlwh3hb5B8BtLycu1aOLFF
         WfBJHHVbATlhOIB0/rNpR33z2OjXdheg7M8D411GDwwVKNOFAoQmYRQgnNfDgGBrCoI1
         0PrdOGzq20hkX2GNivB2dF6fr5VJIOu4/XrsnL4bfqGIH3DQDlWj46glkGRPZx0NvMif
         uoQ3icTRLnQTaHr3lyLpY1QjBeeUpgnA9+pM3HsIxiJnF4ZSk60aHF28382q/DmGaN0V
         qVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780550830; x=1781155630;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vqyI6pdg/9zrIkzXA1zT6p8ma6D6NCvwQYYXXSoUzMY=;
        b=hjrP/Cp9zLmst2wimm6fsBquA1k8fPwhTON6qIzvFvcEaWmBziNE1PovrPvitYxzQX
         iiXBJfw3+wDYaLwU6xtMIiOoYP73fHl0GqOyzlti+Um0uxJaSJ0/JuLa12+zFQToupoH
         5DaZDx5fNNuTAEnmYcqqHToghtzCtoN7sUBpDMC2oY7oPn8Rfk0l0X5UjcOkQbeSV0q1
         WZMzqkHPmzaS00i78zIGnUC2uJE8H8L4v9Tmu0eJFUlX1x9GVe2I8FPYbrMlKPYirOq0
         nw0U14DUgktCyqy4s3C8kE3QUt7I27c3Vg64ALO/noX2G74RqJTyjVambcmzHoWM5d2P
         KGYQ==
X-Forwarded-Encrypted: i=1; AFNElJ/MEXUW7mT63L7F5bKEP6ZISNkg1Edbl1gl7oXnYTGP+vil6ASXmMxVlGyvhxXMzHb4IkQ8cQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwjFHFt9hK5OJpeHUYgFo/Fd6ncZxlSRFrPwWrTgJ+NRpAVxMm1
	XhLKBfMTgsl0lCHTKj33NB24srxKUt2L0bvPXy6uMoRlkOcCFFjXfxGj1rwacqM98A==
X-Gm-Gg: Acq92OFDlD/ARMQ1b99Z5E4hqsXy4RuugvZty/vGUOjKujuaS2ddYCMJhG6Vxc3U9Da
	oxUfL0AMih5mezeb8/n21uzvL11/Sn6XhJFtYvEK9AeGapJRmb5iIHnQYslKVU89iBqMI8fQrSV
	2nNo5FRX2FFYPoY2jIhj9wLyStNzEGceBN2ygaDxiXEJUZ3v/liNSm8SA6QjoJYXVd6+aJcGvZs
	Qy0sd3/2iQpJjUmg6Z3/IRFdMVXDSyR5aatPLgTFUxAt2AzBPhQBRyIkeUODn9+MthvKUJSQ95e
	x8EPNO2P3BJyL9VhUTi1XJYX/GxHZKBFFE4BguCrDr6sbhCXMxx3/D58GiWFRTokGuilacuZK4T
	LhPhVcXajtdc/gn4QeKxo/y3yEfD8jxTso4lrc6wO9sPIcTLOeqvlyOGQHAEyio1srasdw5fw4I
	QMTZ38jycck42Sfkq4jME1QKDmTGUU4MGw5I+q9Pr5oRFeOq55NhKJ1i7+r/XhIyBT6htNf3k=
X-Received: by 2002:a17:903:b83:b0:2bd:5fc9:27b9 with SMTP id d9443c01a7336-2c1a1707b4amr1375255ad.3.1780550829316;
        Wed, 03 Jun 2026 22:27:09 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6d109dcdsm1777236a91.9.2026.06.03.22.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 22:27:08 -0700 (PDT)
Date: Thu, 4 Jun 2026 05:27:03 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	=?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>,
	Michael Bommarito <michael.bommarito@gmail.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] [PULL REQUEST] Intel IOMMU updates for v7.2
Message-ID: <aiEMp4DsP9k6pN9K@google.com>
References: <20260602233426.357499-1-baolu.lu@linux.intel.com>
 <c9c542bb-5b67-4ec3-a5ca-28c59292809e@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c9c542bb-5b67-4ec3-a5ca-28c59292809e@linux.intel.com>

On Thu, Jun 04, 2026 at 11:44:30AM +0800, Baolu Lu wrote:
> On 6/3/26 07:34, Lu Baolu wrote:
> > Hi Joerg,
> > 
> > The following changes are queued for v7.2-rc1. This update introduces
> > a few quick fixes and several refactorings, including:
> > 
> > - Add the PCI segment number to DMA fault messages.
> > - Improve support for non-PRI mode SVA.
> > - Ensure atomicity during context entry teardown.
> > - Fix RB-tree corruption and a UAF error in the probe error path.
> > 
> > These patches are based on v7.1-rc6. Please consider pulling them for
> > the iommu/vt-d branch.
> > 
> > Best regards,
> > baolu
> > 
> > Guanghui Feng (1):
> >    iommu/vt-d: Improve IOMMU fault information
> > 
> > Lu Baolu (1):
> >    iommu/vt-d: Avoid WARNING in sva unbind path
> > 
> > Michael Bommarito (1):
> >    iommu/vt-d: Clear Present bit before tearing down scalable-mode
> >      context entry
> > 
> > Michał Grzelak (1):
> >    iommu/vt-d: Remove typo from pasid_pte_config_nested()
> > 
> > Pranjal Shrivastava (2):
> >    iommu/vt-d: Fix RB-tree corruption in probe error path
> 
> [...]
> 
> >    iommu/vt-d: Fix Use-After-Free in probe error path
> 
> This patch is unnecessary per the discussion here:
> 
> https://lore.kernel.org/linux-iommu/505c8f52-2526-4d78-bdff-1bf67f49129d@linux.intel.com/
> 
> I will send a v2 pull request with this patch removed.
> 

Thanks Lu!

Regards,
Praan
