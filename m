Received: from mail-dy2-f16.google.com (mail-dy2-f16.google.com [74.125.229.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DC23E0749
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 22:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790290223; cv=none; b=dvTNXenBawYQzg5MxVoQl85qcW/PPWU0h5i2EduJmFvu6EIjYF62YSvNxuo7jssRAHHY8Bc/8/MP6H7OHCYPWJRbFSgMqlveZ733FmW/XbD/LIXvJe6135Q+ky6fK5Uxv5zk7G4rIDnjLoSPe93FDyj+i32+wu39qQRiSyIw75o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790290223; c=relaxed/simple;
	bh=Jb6vc6BOQznPAYX80+SRk6VItp9GXPoNisyCk2caNW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BX41IdR3YMToUSi9HMoeqkV50dG2haPECzPGAp2IRrQ/hmaAW2owdKk7vx/G2cB9dzTGdqGxhD8EibxUNb4o+efcHNVuX3hNfrL7GIqJCpuR/WVgqAFKWV2fOV/lvCB8Gj6+K3MLMHj0bTEjj3IoifD4nLWmUn2W5+yIVJn4qbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bMepoXj0; arc=none smtp.client-ip=74.125.229.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bMepoXj0"
Received: by mail-dy2-f16.google.com with SMTP id 5a478bee46e88-341027843a5so150057eec.2
        for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 15:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1790290221; x=1790895021; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iN3QgyvzfZDTdr6KkDKa56Csi5I9mIhZDrQiq00doWs=;
        b=bMepoXj0n2ExAqPE7eYsTiC5vw6EGTlJU5GUZ5y0/x2AlAR8FXqCSFDgavGsVjhg6B
         Fp+GujYsWhdZYD8Q1ySr3cOc2AgqDhLSeUpogZINT8RYaqpMTxla10UUPdljcGt2X1bU
         a1CFh6UotkWjAKElQ3XfR+1kTJy3cSC8bHQTM6nKbOhjIP6uu2xreiWwZG1bcNGJ3aOQ
         Wt6wQ3+gEsAJ+HWWtulS7SwC5FjCGV9dZ5+FNAqUA2a5/f7shBVbw8qH/SPTRqyw+19E
         cr8yLhVCB5q1MVBdTh6Fjh0WLA/yXbto2SbUrFBAaWlUOY6lYA97YuoKNWpGZ8+u25o9
         FBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790290221; x=1790895021;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iN3QgyvzfZDTdr6KkDKa56Csi5I9mIhZDrQiq00doWs=;
        b=beaA4Udi+AsPPV0+CBgqmrZpeDz8mX3gxosJviqg112P5NIApxEk2HF+8+udeC8Tah
         Wljb3hNjpcnezW7BSERtds3p2OBIrxdHByBQNUKHR7BKxj4GaZ4fFoxUsd6NO4cwEVOh
         b5Pb1jCE3/+6Bz9w1ehFQE/C1sXnVpHT7oXaPBvWFTddkR/kKLcKwF2AWl9j54M2M4Q3
         4UX2i/uK7OOTt1f8pdkWutsDIzmTEIG3TIOHcX8DRc3gDLtjghzBtc8NmIZhaDRE4MG8
         Wos0ngJqumJdqyGrh+PtC2jlxbPQdTKFsM9UunIPaGD3V7h9okxsmVibX0w03nvxZyUK
         aeEw==
X-Forwarded-Encrypted: i=1; AKwUvBw9f0dN87Az1PH590FIKcAPylOYuy5K4O2d+CNWNNfZg2RzbwemmMwUO9iIE/gPEcB32lPKJQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lFXnaMM81+G8GjhvNyMN8735WWgnCltD/7dtAsjKBQKOE87TwN
	qdM4Yqz8ETvAwztWaEQl0l5reDb/wcL9o03lFx+GgfLdXmtZLdyWGdtzNze84tl3FPo=
X-Gm-Gg: AYBFou2Rj1ZTTl7iPM07bBDE3+GoAOyrCFrqe/Go8xsSslu+x0r5XNqMnPD0TsWXjTp
	jmCY2QaLN7vPJegjt2mJnM9h8MaMn+3zr5SfxqMbj1XA0XiNX+LwaTEqWT81qXp7NUBal2pmthY
	SEh0jzFd+z16Z8ynP8h1LBOE2qQSHUODn16UOy4dedUvdAKYKbgcjiIOdC5b6r3yK2/ij0sphZX
	muzIGHzPYH5mHslc13LLKlnb192orAuELyGMxbIS+f4zSFtVTqqlG96XXTtbu0vgtu1LuqgGTAG
	ZmQxBQN/UJotA1g8SDbhiBrdv1Df95vdnaXf3kYtqbhLZNALaJTOBwMYF8UfDuNR+uUCBtPZpEV
	2SrbL6hNH1AT6jRu5vKWWyVoyEDQ85d7KZ0J+As6vz+K4UWr5FIi6R/YcEomRih5HSi2qzQyQIX
	BGfuWW7I2U7340utxpRhAfTW+WtyetHIscDY1ZXq1mKBBq
X-Received: by 2002:a05:7301:18ab:b0:33c:3134:1055 with SMTP id 5a478bee46e88-340032c267emr3017847eec.12.1790290220645;
        Thu, 24 Sep 2026 15:50:20 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144173a2asm1592472eec.6.2026.09.24.15.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 15:50:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x9sGg-00000000eVK-3LHc;
	Thu, 24 Sep 2026 19:50:18 -0300
Date: Thu, 24 Sep 2026 19:50:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Joerg Roedel <joro@8bytes.org>, amd-gfx@lists.freedesktop.org,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>,
	Jatin Kataria <jkataria@netflix.com>,
	Boqun Feng <boqunf@netflix.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>
Subject: Re: [PATCH v2 1/2] iommu/amd: Add PerfOpt IOMMU performance
 optimization support
Message-ID: <20260924225018.GB16465@ziepe.ca>
References: <20260908041207.38113-1-mario.limonciello@amd.com>
 <20260908041207.38113-2-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908041207.38113-2-mario.limonciello@amd.com>

On Mon, Sep 07, 2026 at 11:12:06PM -0500, Mario Limonciello wrote:
> +EXPORT_SYMBOL_GPL(amd_iommu_enable_perfopt);

Last time we hardwired the GPU and IOMMU drivers together it was a
huge mess to undo.

Why does the GPU driver have to request this? Why can't the iommu
driver know that this is a special device that can use this magic fast
path and then auto set it when identity is asked for?

How does the GPU driver even know it is magic special?

> +	/*
> +	 * Restore ATS/PRI/PASID (and thus SVA) by re-homing the device onto its
> +	 * identity domain with the flag cleared, so a later bind without PerfOpt
> +	 * sees a normally-capable device. See the locking note in
> +	 * amd_iommu_enable_perfopt().
> +	 */

And this is sort of a wrong thing in the driver, it shouldn't have ATS
turned on for identitiy mappings, and it certainly shouldn't have PRI
turned on until a PRI capable domain is attached.

Jason
