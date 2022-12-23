Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C15F6106
	for <iommu@lists.linux.dev>; Fri, 23 Dec 2022 09:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=OyPsDfn6EY3YtQWol1kUj4ZkKQ779YWu6usWCZrDVyU=; b=3vSN5lDJRYtQDXMD4ceVKN3r/6
	iK16qYTqy2Rr8bBRNyrcjRDbQNsmuFotVPpHnYAwMGn4oTxZK98mHdSLqlS9iBfJZOpMNoEALGHyT
	8gGuZywdrNMc458UL5qkuO0RLdjn6QTqBtHWDaqqa5l1sW7zI172v20K0PO8mtOfrkpBtxjcbLrCx
	ZnGUnb3Aql8+9jIqgJmBfoeZGteAptd3lxNwnxqic+V6yejfqQpBmvCtMf1Trgsz54hl4jKx2Pd7B
	mdp3paNZrboT8AzhGVnc2OGhMQNb4MAQ9/CngUxoFXuKi0jjO8H/g7wtGYDaTlzP/LN48Mdjnkoih
	nqWt/2SA==;
Received: from [2001:4bb8:199:7829:8d88:c8b3:6416:2f03] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8eKY-005hQ1-4D; Fri, 23 Dec 2022 09:27:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	iommu@lists.linux.dev
Subject: revert dma-mapping and vmap API abuse in qcom_q6v5_mss
Date: Fri, 23 Dec 2022 10:27:01 +0100
Message-Id: <20221223092703.61927-1-hch@lst.de>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this series reverts a completely broken commit to qcom_q6v5_mss the
abuses the dma-mapping and vmap APIs in multiple, and mostly clearly
documented ways, and then adds a patch to document and reject the
so far undocumented API abuse.

Diffstat:
 drivers/remoteproc/qcom_q6v5_mss.c |   38 +++++--------------------------------
 mm/vmalloc.c                       |    3 ++
 2 files changed, 9 insertions(+), 32 deletions(-)
