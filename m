Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E256FAA
	for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 14:42:51 +0000 (UTC)
Received: from localhost.localdomain (unknown [IPv6:2001:b07:646b:e2:e4be:399f:af39:e0db])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 930A466071B1;
	Mon, 21 Aug 2023 15:42:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1692628970;
	bh=ZsdQa5njkqr8DLmpGjyKBbMPVOfqKBFppcErYJGoDDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=egrMEBcdzmNh/J+cKMg/du6tVm8ZOKbrWrAVqvqKTGyKiqCxLXcrhFqUh6Ao2dsmz
	 sDo8vxiR8xczeOtxhwzukbVH2JHSdibVdSbYfuSuM1zSNDa8fRiEcpNL/lW7hzQP5X
	 FYgfeHFRyo7NtgWd2nmMtv3CsEZcSiGgMFtjjPa0cz95ISiYQH4QDxoxq5JjGip0ZN
	 0VC55fJcDPwxOrg5TTGpG3esBzNAp2mjaX6I24qk59iwbNFGvk3ddADpX9l8qtagwp
	 I0mmpAU7ZJIIj4LuvDVAqE38eUeldDZdT/YNZFuJKFqpCt7tjhhxyP6y6fLa5CsgGL
	 Q6Njh9xJst9Uw==
From: Laura Nao <laura.nao@collabora.com>
To: yong.wu@mediatek.com
Cc: angelogioacchino.delregno@collabora.com,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	laura.nao@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	matthias.bgg@gmail.com,
	robin.murphy@arm.com,
	will@kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH] iommu/mediatek: Fix share pgtable for iova over 4GB
Date: Mon, 21 Aug 2023 16:42:34 +0200
Message-Id: <20230821144234.301491-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230819081443.8333-1-yong.wu@mediatek.com>
References: <20230819081443.8333-1-yong.wu@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I confirm this fixes decoding on MT8192 and fluster tests are passing again (tested on spherion with next-20230821).

Please note that I was only able to test this patch on MT8192 at the moment.

The regression was originally reported by KernelCI, so:

Reported-by: "kernelci.org bot" <bot@kernelci.org>
Tested-by: Laura Nao <laura.nao@collabora.com>

Thank you!

Laura

