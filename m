Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A27B2FB2
	for <iommu@lists.linux.dev>; Fri,  2 Dec 2022 14:04:35 +0000 (UTC)
Received: from 8bytes.org (p200300c27724780086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7724:7800:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id B52D72A0CAB;
	Fri,  2 Dec 2022 15:04:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1669989874;
	bh=kShbm2DVbDLM8u7qiGKqyBr7ML2l9/8XDIaiynzASyM=;
	h=Date:From:To:Cc:Subject:From;
	b=kZ8sqEUGGOXDfecl8FKT+J87xKayhmlT85v1d8TcHUpxhs6Mpw5ab6VfT82ym4Sdu
	 oWvH27JjSEfC1rHkF6kizgZBmq/jQmDSYxFz5tGIUGgXHwo8OxAylkKwy6nu2NCaNE
	 F0fYVZLQQyGj4eh5/cuEVcz9KEIi/iht3Bdp8idV17iNPm/6SH0TqxhIIpIo9l6cyh
	 ODAT8cfYa1OSSKMqI1F6gW1hjjKATaVwFtmcFlfu2yhIEpZsTguGcV2e1GIu0Mgq3U
	 hJPj1b2z9JiQ4i+jDJR0Cq7w8LWuLa7Yd0VJqoGGW8QWcU9AAbtCuwT/C87jzQB06m
	 pRR5rB07DR81g==
Date: Fri, 2 Dec 2022 15:04:33 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.1-rc7
Message-ID: <Y4oF8e7quzjm2kzD@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mAB3ZrP845gYXOu9"
Content-Disposition: inline


--mAB3ZrP845gYXOu9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit b7b275e60bcd5f89771e865a8239325f86d9927d:

  Linux 6.1-rc7 (2022-11-27 13:31:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.1-rc7

for you to fetch changes up to 4bedbbd782ebbe7287231fea862c158d4f08a9e3:

  iommu/vt-d: Fix PCI device refcount leak in dmar_dev_scope_init() (2022-12-02 11:45:33 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v6.1-rc7

Including:

	- Intel VT-d fixes:
	  - IO/TLB flush fix
	  - Various pci_dev refcount fixes

----------------------------------------------------------------
Jacob Pan (1):
      iommu/vt-d: Add a fix for devices need extra dtlb flush

Xiongfeng Wang (2):
      iommu/vt-d: Fix PCI device refcount leak in has_external_pci()
      iommu/vt-d: Fix PCI device refcount leak in dmar_dev_scope_init()

Yang Yingliang (1):
      iommu/vt-d: Fix PCI device refcount leak in prq_event_thread()

 drivers/iommu/intel/dmar.c  |  1 +
 drivers/iommu/intel/iommu.c | 73 +++++++++++++++++++++++++++++++++++++++++++--
 drivers/iommu/intel/iommu.h |  4 +++
 drivers/iommu/intel/svm.c   | 19 ++++++++----
 4 files changed, 88 insertions(+), 9 deletions(-)

Please pull.

Thanks,

	Joerg

--mAB3ZrP845gYXOu9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmOKBfEACgkQK/BELZcB
GuMU+Q//cN2dE+o7jdl4uPrfxBCn5MkdejyVcv88I2r3I97ewFcBqRi0ziVSAz8R
BFekWcpiaAH9ZrqtS0e455xqsIvZLZVaxjgrltW9biYi+1EfBfMnS+Hp9YHOth9M
rFdLfbHJLVEqgX0PZx3Z69Twp8SpxAmChN77kL+9HQbB809HjIYkSHMYwfOPaI+X
YVynPd7E/1IbvdMZn242WK4fXBJKkA2zgq99sDwt9L++viTfgxEmmirRNVOcT032
O/7hdTItNqCZCbbFXUKvNecjDOgeI7JQGDSUXlm1OfzFkp636PZkSEEom6LI/DwM
zjx7TfpBh5JTr9oIpK9vGP0Ltq/G10jMfrHBTi1+GC8GUwbaT7enJOe9mthWpH+Z
TeJvnlGltDQrChWof/JYNVfBpsVz/RRYWxEWyBHPYRxJW6L1hkvgtCROVDCar/6G
i52ELEz56aAMAt7wtO/Jsa5nEhRn2jrfeym++JHNu+ks05y46xjUIDZm8bCBOtJj
mOS5/FY4Nui05OGPzBX4/FLV+kAx5yrd5psYZPF0mOOMGLKNV4xqyiCRnxW85H/F
k2l7qXe8LFucM+i6lNj9mTDkKMDbalWhSAobPrJYQPZuGMJDMBa76KxVWFfKtTEu
LBAi0LZrVSMRtA2mGrlz7cdaefcz5LKDE0K8GogkSyBeKATRAiA=
=62iX
-----END PGP SIGNATURE-----

--mAB3ZrP845gYXOu9--
