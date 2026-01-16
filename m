Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3E020C00C;
	Fri, 16 Jan 2026 02:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768530173; cv=none; b=EJVXsUOz6eHV9RLgbJr9RSXO5Z/W/x9CzzNu8S/mnOOocKXB6b9BZjQQLqQ+AagpAE/Cfq9CMWa7jFNoqihaoSoV83aXp8qPko2PeL7iq6QW9U9sN4BDRb7/V9TLrarxe9Vwa8KACodPPHsdyhZyiJfg2cVVlcwON2GjZYgsbvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768530173; c=relaxed/simple;
	bh=TWHUtPL95MkRiG+v+nOoNJAuEBWRyynH8/ZewunoRlU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ldDle4X/uhbIe4yV88Q6crjVvo9mGYAExw6Fnn4VsKvL8MBCOcrF13af/qubfvbpbF6dTivY9q9IyxMURyuIEyaKRwt8Dzah0axda7fbXG3x+BegnevSOtTD0426QQS/jFwflbViYYF8LcbdyKVlZDvghji4vhjY4zIkhAr6atw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCAlzKrY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCAlzKrY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B845FC116D0;
	Fri, 16 Jan 2026 02:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768530172;
	bh=TWHUtPL95MkRiG+v+nOoNJAuEBWRyynH8/ZewunoRlU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=JCAlzKrYUleW8QYv0gHGTOyq0iGusgjtJwqGC0Q6JIjsbOAfxWbbcz1BZxfTWElhS
	 GDXIvbi4jT9pcTn+YqFAGlWpHng3FaxtljcVyRLTLvgECdg+rEYWKTu+z/nLGitKgQ
	 3DthycaqrMunmmyaQVl5JrVqpYHyZBjoL1WtAkzBo1U6/86aqiySIhk5TbfmvPl208
	 PpixjdsaxqFRnmt75oCTNmHS7ky2nd4iDkaFNMjXPzgzeMLIRD6eLDjb0XOXwvCwkm
	 AQ8uPXDYXemMvU91FLzuXcwOg0yMvxqfo8zIYSjfgnYe0PdbJREny6H3VncTNcg0Wk
	 IXmKXG6KwM7tA==
Date: Thu, 15 Jan 2026 19:22:48 -0700 (MST)
From: Paul Walmsley <pjw@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev, 
    Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
    =?ISO-8859-15?Q?J=F6rg_R=F6del?= <joro@8bytes.org>, 
    Palmer Dabbelt <palmer@dabbelt.com>, 
    Paul Walmsley <paul.walmsley@sifive.com>, 
    Robin Murphy <robin.murphy@arm.com>, 
    Tomasz Jeznach <tjeznach@rivosinc.com>, Will Deacon <will@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, 
    Qasim Ijaz <qasdev00@gmail.com>, 
    Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: [PATCH] iommu/riscv: Simplify maximum determination in
 riscv_iommu_init_check()
In-Reply-To: <d1a384c9-f154-4537-94d6-c3613f4167bc@web.de>
Message-ID: <d36377ae-97bf-a39e-a3e6-caa982dc29ac@kernel.org>
References: <d1a384c9-f154-4537-94d6-c3613f4167bc@web.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 28 Feb 2025, Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 28 Feb 2025 18:56:00 +0100
> 
> Reduce nested max() calls by a single max3() call in this
> function implementation.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Thanks, queued for v6.20.


- Paul
