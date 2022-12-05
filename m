Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E016F23CC
	for <iommu@lists.linux.dev>; Mon,  5 Dec 2022 10:55:47 +0000 (UTC)
Received: from 8bytes.org (p200300c27724780086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7724:7800:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id A5EE42202AB;
	Mon,  5 Dec 2022 11:55:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1670237746;
	bh=UVOyFFaGYlpHJfm3mAMdFZ8zDZRV5tP+GuufCO475L4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=50ZzaDPqm6zSg1911499wI12ZJg8Zfh0ZeU4ptABj61knUN9uman1W/Zj3OEYkx5o
	 DT9ag6YE8z9ZTFTyx8NXeKVyX07AjJ5Y6upV3L3aXZ/D460VDVWyQafxz15zOjjp4S
	 FgdSVQjAe6xWxLCc2OH6AjuG6WHUyTjlxiuvxDq5rQ2/mXrNf4qAAR1Pe5N1Y/pvFQ
	 Yhj/72n4bxUlGQer/1yKN42pLQMYn0kWFsXltRhMpwfVCMAT6640YBKA6YihbyoJeU
	 NGKhXkJLpH1XQucxnBVkOjqWKoVoQneM7GOQ/2JkWO+TE92+yU4RW13aCKBdVkF2a2
	 Tb0yRdJ7AuqDA==
Date: Mon, 5 Dec 2022 11:55:45 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/mediatek: Fix crash on isr after kexec()
Message-ID: <Y43OMbwJUTv0dmOt@8bytes.org>
References: <20221125-mtk-iommu-v2-0-e168dff7d43e@chromium.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125-mtk-iommu-v2-0-e168dff7d43e@chromium.org>

On Mon, Nov 28, 2022 at 11:16:48PM +0100, Ricardo Ribalda wrote:
> If the system is rebooted via isr(), the IRQ handler might be triggerd
> before the domain is initialized. Resulting on an invalid memory access
> error.
> 
> Fix:
> [    0.500930] Unable to handle kernel read from unreadable memory at virtual address 0000000000000070
> [    0.501166] Call trace:
> [    0.501174]  report_iommu_fault+0x28/0xfc
> [    0.501180]  mtk_iommu_isr+0x10c/0x1c0
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Applied with commit-message spelling fix.

