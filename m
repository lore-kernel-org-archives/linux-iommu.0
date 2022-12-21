Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281B01FD2
	for <iommu@lists.linux.dev>; Wed, 21 Dec 2022 10:28:00 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id C4C3267373; Wed, 21 Dec 2022 11:27:55 +0100 (CET)
Date: Wed, 21 Dec 2022 11:27:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: "chenxiang (M)" <chenxiang66@hisilicon.com>
Cc: Gerd Bayer <gbayer@linux.ibm.com>, Shuah Khan <shuah@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] dma-mapping: benchmark: Fix compile error in
 user-space tool
Message-ID: <20221221102755.GA25835@lst.de>
References: <20221205135022.49708-1-gbayer@linux.ibm.com> <fd189113-deae-d6b7-bb9a-a5a94f7b0815@hisilicon.com> <3193d6833feccc5c2fbdef9b1f71f292eddb8f27.camel@linux.ibm.com> <357fa52d-ae0d-ded9-5fd0-c5d15bc06ff9@hisilicon.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <357fa52d-ae0d-ded9-5fd0-c5d15bc06ff9@hisilicon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Can you explain what the problem is?  I just say a maze of quotes
and top posting replies.
