Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 872A5C43334
	for <iommu@archiver.kernel.org>; Tue, 28 Jun 2022 07:01:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F349841581;
	Tue, 28 Jun 2022 07:01:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F349841581
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PnJBFi1L
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f6vzCE7PBwYP; Tue, 28 Jun 2022 07:01:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 785134109B;
	Tue, 28 Jun 2022 07:01:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 785134109B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56A5FC0032;
	Tue, 28 Jun 2022 07:01:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1707C002D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 07:01:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BAD4340A05
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 07:01:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BAD4340A05
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oJuWqJd6db4F for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 07:01:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ABE1D408B3
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ABE1D408B3
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 07:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656399708; x=1687935708;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=aAQLpyuwGe/blCnik+wxyAV++Cqpx2JtHD4cMfZzvcE=;
 b=PnJBFi1L0lYnFTC9T5G/5mfNQfTIwF9/ZQGy6hkNGlWixjGjCx5kbQFi
 ROZuSujvFWD/+5RxxLicwVDs+zTD46sjw/F3/yUgtJjP4CNEMjq33HpJj
 jWRcpJqm4zxSTdDp959VNoBq5koYuRQ6GG4eRlGI1zvpqUCM78fh53Qte
 3YugKy/MqYo91mwHV9Mgr+L99k9EdKbh2IGrmoHBFquvjuyHDNrYhX2nf
 2i4AskkXElm0jBxGIBOBxOwx4Bjy9DqK5gZAtUfFxFwdXYi3w+MlG6+eo
 sYbZlWLeXFWkW7HQAxsBwmIMmysNanGwcNtQblOl1pz5QX59owPs4KnLL Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="345652848"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; d="scan'208";a="345652848"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2022 00:01:47 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; d="scan'208";a="646782818"
Received: from spr.sh.intel.com ([10.239.53.120])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2022 00:01:43 -0700
From: Chao Gao <chao.gao@intel.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] swiotlb performance optimizations
Date: Tue, 28 Jun 2022 15:01:31 +0800
Message-Id: <20220628070136.419163-1-chao.gao@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: len.brown@intel.com, tony.luck@intel.com, Kees Cook <keescook@chromium.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, linux-doc@vger.kernel.org,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>, rafael.j.wysocki@intel.com,
 Muchun Song <songmuchun@bytedance.com>, dave.hansen@intel.com,
 iommu@lists.linux-foundation.org, Randy Dunlap <rdunlap@infradead.org>,
 Borislav Petkov <bp@suse.de>, linux-pm@vger.kernel.org,
 ilpo.jarvinen@linux.intel.com, dan.j.williams@intel.com,
 reinette.chatre@intel.com, Andrew Morton <akpm@linux-foundation.org>,
 kirill.shutemov@linux.intel.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Intent of this post:
 Seek reviews from Intel reviewers and anyone else in the list
 interested in IO performance in confidential VMs. Need some acked-by
 reviewed-by tags before I can add swiotlb maintainers to "to/cc" lists
 and ask for a review from them.

swiotlb is now widely used by confidential VMs. This series optimizes
swiotlb to reduce cache misses and lock contention during bounce buffer
allocation/free and memory bouncing to improve IO workload performance in
confidential VMs.

Here are some FIO tests we did to demonstrate the improvement.

Test setup
----------

A normal VM with 8vCPU and 32G memory, swiotlb is enabled by swiotlb=force.
100 in Host/Guest CPU utilization means 1 logical processor. FIO block size
is 4K and iodepth is 256. Note that a normal VM is used so that others lack
of necessary hardware to host confidential VMs can reproduce results below.

Results
-------

1 FIO job	read/write	Throughput	IOPS	Host CPU	Guest CPU
				(MB/s)		(k)	utilization	utilization
vanilla		read		1037		253	228.48		101.92
		write		1148		280	233.28		100.96
optimized	read		1160		283	232.32		101.12
		write		1195		292	233.28		100.64

1-job FIO sequential read/write perf increase by 12% and 4% respectively.

4 FIO jobs	read/write	Throughput	IOPS	Host CPU	Guest CPU
				(MB/s)		(k)	utilization	utilization
vanilla		read		885		214.9	527.04		401.12
		write		868		212.1	531.84		400.64
optimized	read		2320		567	344.64		202.8
		write		1998		488	312		173.92

4-job FIO sequential read/write perf increase by 164% and 130% respectively.

This series is based on 5.19-rc2.

Andi Kleen (1):
  swiotlb: Split up single swiotlb lock

Chao Gao (2):
  swiotlb: Use bitmap to track free slots
  swiotlb: Allocate memory in a cache-friendly way

 .../admin-guide/kernel-parameters.txt         |   4 +-
 arch/x86/kernel/acpi/boot.c                   |   4 +
 include/linux/swiotlb.h                       |  47 +++-
 kernel/dma/swiotlb.c                          | 263 +++++++++++++-----
 4 files changed, 229 insertions(+), 89 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
