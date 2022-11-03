Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBD57488
	for <iommu@lists.linux.dev>; Thu,  3 Nov 2022 14:53:18 +0000 (UTC)
Received: from 8bytes.org (p5b00664c.dip0.t-ipconnect.de [91.0.102.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 0E894260033;
	Thu,  3 Nov 2022 15:53:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1667487197;
	bh=W+503lTP2jRAK3Vj/frLD3iD/xxYLTMy9NfG9rA+raI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=inVtOODTjwGgyJlA7Iw794Ad9BngxsaqLHg7pXU8cE21CYQBhPuH9VdUpIQOeaTSA
	 fJRx4FJ0TaD8loMduyufhX8+Le3tGOOTTSCzJkzEbwBKjIrdm/eN28sgxmf+v0n8Aq
	 3PFZrjec5c0TcKVsuoVv048G4EeBWwcabN+T7uc6MXQoi+GwA8IWO8eAfAM/qbbB+6
	 PqSTLVX+5sgCz7aSyOxDrkdrzQFN7TnyvR6B1E8PpBd97S+SidrA2xTFoaLtyIY69b
	 0jUBi9bVQBURoAIydeT86AZeQ/oLUb0hIbNNjzY2aYTLZEbhFbCGKSy7KiYEeAbsC5
	 lMxXjvVEer9cQ==
Date: Thu, 3 Nov 2022 15:53:15 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, kevin.tian@intel.com,
	quic_jjohnson@quicinc.com, suravee.suthikulpanit@amd.com,
	robdclark@gmail.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
	yong.wu@mediatek.com, matthias.bgg@gmail.com, orsonzhai@gmail.com,
	baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	jean-philippe@linaro.org, tglx@linutronix.de,
	shameerali.kolothum.thodi@huawei.com, christophe.jaillet@wanadoo.fr,
	yangyicong@hisilicon.com, yangyingliang@huawei.com,
	quic_saipraka@quicinc.com, jon@solid-run.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: Re: [GIT PULL iommu] Please pull iommu errno changes
Message-ID: <Y2PV26igcbY6Atu+@8bytes.org>
References: <Y2Jn7Jskqzz95XB4@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2Jn7Jskqzz95XB4@nvidia.com>

On Wed, Nov 02, 2022 at 09:51:56AM -0300, Jason Gunthorpe wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-joerg

Pulled, thanks Jason and Nicolin.
