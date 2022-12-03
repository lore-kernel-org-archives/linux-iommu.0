Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8857C
	for <iommu@lists.linux.dev>; Sat,  3 Dec 2022 00:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670028618; x=1701564618;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9vIXaYbbqArKlbNUcGZT4O2VFsT2UZnPQbUk/fLylKA=;
  b=ezdIkwNsESchTSsKoaH/nZNeRrOvUYlNsWvYSno3az82He8YLMyiTL07
   UPhoB0KAEuTJ4JxmqXlT7e26gDQUtoIIUkAKXxwCZcER+KSXK0HXz7+Vv
   waLFqew/x9bKRhA1wIrGNNTZ0u8Bcts4sEnNpu72O/6SZJ5+JLMRuTfI/
   F1rjd3zCb7QazieVqUXAtkOIiIIu4lcKAMUB4OKtq1iensXJQtkJlIEGa
   gwevF3X8JThQUoogQdcIMoFOqOzRb545/xh9wblQ7ZbJ3GmmlK5m2s2f5
   uWcuhJYfAzpMGAs+UzW31Lzc3Mnlf4e3m5sYMeUeO3tHJXvDtjYbS7HrB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="295769887"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="295769887"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:50:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="708670328"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="708670328"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:50:11 -0800
Date: Fri, 2 Dec 2022 16:54:05 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Xiongfeng Wang
 <wangxiongfeng2@huawei.com>, Yang Yingliang <yangyingliang@huawei.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 0/4] [PULL REQUEST] iommu/vt-d: Fixes for v6.1-rc8
Message-ID: <20221202165405.50be86a6@jacob-builder>
In-Reply-To: <Y4nXu9uBwXZFwjq2@8bytes.org>
References: <20221201040127.1962750-1-baolu.lu@linux.intel.com>
	<Y4nXu9uBwXZFwjq2@8bytes.org>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Joerg,

On Fri, 2 Dec 2022 11:47:23 +0100, Joerg Roedel <joro@8bytes.org> wrote:

> On Thu, Dec 01, 2022 at 12:01:23PM +0800, Lu Baolu wrote:
> > Jacob Pan (1):
> >   iommu/vt-d: Add a fix for devices need extra dtlb flush
There is a bug in this patch, I will send a fix patch. Or can you squash the
fix below?


From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Date: Fri, 2 Dec 2022 16:22:42 -0800
Subject: [PATCH] iommu/vt-d: Fix buggy QAT device mask

Impacted QAT device IDs that need extra dtlb flush quirk is ranging
from 0x4940 to 0x4943. After bitwise AND device ID with 0xfffc the
result should be 0x4940 instead of 0x494c to identify these devices.

Reported-by: Raghunathan Srinivasan <raghunathan.srinivasan@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d8759f445aff..0b10104c4b99 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1401,7 +1401,7 @@ static void domain_update_iotlb(struct dmar_domain *domain)
  * This quirk is exempted from risky_device() check because it applies only
  * to the built-in QAT devices and it doesn't grant additional privileges.
  */
-#define BUGGY_QAT_DEVID_MASK 0x494c
+#define BUGGY_QAT_DEVID_MASK 0x4940
 static bool dev_needs_extra_dtlb_flush(struct pci_dev *pdev)
 {
        if (pdev->vendor != PCI_VENDOR_ID_INTEL)

sorry about that,


Thanks,

Jacob
