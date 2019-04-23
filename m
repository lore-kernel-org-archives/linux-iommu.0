From: Juergen Gross <jgross@suse.com>
Subject: [PATCH 0/3] xen/swiotlb: fix an issue and improve swiotlb-xen
Date: Tue, 23 Apr 2019 12:54:54 +0200
Message-ID: <20190423105457.17502-1-jgross@suse.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, sstabellini@kernel.org, Juergen Gross <jgross@suse.com>
List-Id: iommu@lists.linux-foundation.org

While hunting an issue in swiotlb-xen I stumbled over a wrong test
and found some areas for improvement.

Juergen Gross (3):
  xen/swiotlb: fix condition for calling xen_destroy_contiguous_region()
  xen/swiotlb: simplify range_straddles_page_boundary()
  xen/swiotlb: remember having called xen_create_contiguous_region()

 drivers/xen/swiotlb-xen.c | 37 ++++++++++++-------------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

-- 
2.16.4
