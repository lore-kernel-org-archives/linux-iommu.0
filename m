Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A7930C159;
	Thu, 15 Oct 2026 21:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792100006; cv=none; b=nn/tL1X0CF0rCbWitG4WH4rUcEu42RVvX+cYSIIubFnB1cpZkpTVobMY3S5/hrJrEJEyAhaAhhMozo92Beo18jxYna3aLNcIeDv/yTuUhE3X23v8oO+ZyY+XMy8hT9JKfic3wvwU8S0magIUCgT1w2WsV7ml0QV9YD6rzQy5eEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792100006; c=relaxed/simple;
	bh=5Yx23oGPRdic9RmKMw6Xussx9kuO7CpNoC42ywopOTk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b39oaSDA8diC3uWjY9+Y8qQ2oz3ru5aAARw5M3UMl9w/q46lh+XkbO6yxp4eL4PPXs12zCLdbLyoE4GwUXKqV9nhH5FCFqQStV+xLa/Jbx6fCCCwyyNjWI/LY5Zt3UA9h+KIR6I/3t32Eu9OtJqzpuI/SE4hQHysLNdoGS57q7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSFGEXE5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSFGEXE5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350211F000C4;
	Thu, 15 Oct 2026 21:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792100004;
	bh=5Yx23oGPRdic9RmKMw6Xussx9kuO7CpNoC42ywopOTk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=FSFGEXE5laPox3hCH6IqswvdbITnxGACV/RzYNIT82YqU7+mwCqbfXWM6nyNV8ChN
	 uYYrsWU7zPqbSyg7Dsb6xLYfh0GuwQo4UzIYzcBeKfzORePtL0vGdKkCfjORbCam6d
	 CxAKVqWLDU/iqj1ilpBNnnqzWLkSckWIiqz2ChAQQDGztHSKs/9xpSHtChY65Jdo4e
	 5d3nUjIJ4PthlR3iI66AtxbQqeOjoeHH3T0VMZ/62jBNgskV/yI0hSgBXkzC1QFPhD
	 v8wV82T72EeyzUEy92xxVApPJn6B35Ptn1DxTcOVbBDwSLk/6wqFolL/5up4EU+oDI
	 z+ikhD0Seee+w==
From: Thomas Gleixner <tglx@kernel.org>
To: Anup Patel <anup@brainfault.org>, Andrew Jones
 <andrew.jones@oss.qualcomm.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
 tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
 kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v6 10/16] irqchip/riscv-imsic: Add MSI address list
In-Reply-To: <CAAhSdy37AUsq0ixwiaGz5HwSJw+jTAonoCHG5Oi8h5=Hw+bXrw@mail.gmail.com>
References: <20260925151659.419512-1-andrew.jones@oss.qualcomm.com>
 <20260925151659.419512-11-andrew.jones@oss.qualcomm.com>
 <CAAhSdy37AUsq0ixwiaGz5HwSJw+jTAonoCHG5Oi8h5=Hw+bXrw@mail.gmail.com>
Date: Thu, 15 Oct 2026 23:33:22 +0200
Message-ID: <87v772d4yl.ffs@fw13>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Sep 25 2026 at 21:21, Anup Patel wrote:
>> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
>> Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>
> LGMT.
>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Acked-by: Anup Patel <anup@brainfault.org>

Can you make your mind up?
