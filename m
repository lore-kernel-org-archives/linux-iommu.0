Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B44B17BEC7
	for <iommu@lists.linux.dev>; Wed,  4 Sep 2024 08:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725439196; cv=none; b=siZzLIJCuCO0/rGZ5ok6Gh1vTe3A+3gyV08QOp7r+nzoU3v3S+aVONla5ggjqUts8I5yFCP3tTr/mAQ8W/WeMQDGYwLSym2awE4fMvc+VbwR59Up0pVR6PMEiEub/Z9Pjtn6hSb1xBISM34vvYMCdT2oIjLuedHYRJQPpstJfmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725439196; c=relaxed/simple;
	bh=r82FA6nPpW5RfY9hlelJ5OUi9Pd7zZXF6VLiolBkOsI=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=TywGmqG/rivwIbIvoUJBKcjdJEvw52fFsuUvsGKlqiVOCu9caiA5DZwC0jN8QLVVABwF4o10axD17NUoWunUCWtrkcLEhHmoH7JH5mECsxV6dBTsuMFzQFPfCHID6B1cmqI+137ddkmr6ZOgWvXqJrBr0equ3NWvqkawPvLUyDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=c+UIsG1X; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="c+UIsG1X"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240904083946euoutp02d47099168a7fcb650acd7e5d46d7ec2e~x-cxcJVej1338813388euoutp02Z
	for <iommu@lists.linux.dev>; Wed,  4 Sep 2024 08:39:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240904083946euoutp02d47099168a7fcb650acd7e5d46d7ec2e~x-cxcJVej1338813388euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725439186;
	bh=QhPV2sVUc1lKE1/z5DgSRnIGJ8zJuuo9oNVersZODxI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=c+UIsG1XJPXX7M63mw3BiKR6+ttdYcv70pf9n+GJDVvfHUj+xN5Iymh5A2nlTgrzd
	 3+udtBWTea+ELTbgHUDLgCAX8U783BfoHUdOFbL2nealLf3PhZO2IGrQTMUy3Y/d0K
	 nMTHqSKjeorRwomXIXevPQtlFk6lH2fTE+L3lGtg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240904083946eucas1p28082ce4850ed9aa3c53b6db414f9988e~x-cxLd6JW1069310693eucas1p2f;
	Wed,  4 Sep 2024 08:39:46 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id F5.BA.09620.1DC18D66; Wed,  4
	Sep 2024 09:39:45 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240904083945eucas1p2a444ad211bdccb73cb638f37cbddcade~x-cwrWM-u0099700997eucas1p2-;
	Wed,  4 Sep 2024 08:39:45 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240904083945eusmtrp2cf3c17962314a9a952a089e6c15c1b1c~x-cwneHiN2481324813eusmtrp2f;
	Wed,  4 Sep 2024 08:39:45 +0000 (GMT)
X-AuditID: cbfec7f5-d1bff70000002594-f5-66d81cd1ebf3
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 6C.8B.14621.1DC18D66; Wed,  4
	Sep 2024 09:39:45 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240904083945eusmtip1201173e2c3d3ace8c626ac1eca08e6bb~x-cwZE8mL1801518015eusmtip1g;
	Wed,  4 Sep 2024 08:39:45 +0000 (GMT)
Received: from localhost (106.210.248.110) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 4 Sep 2024 09:39:40 +0100
Date: Wed, 4 Sep 2024 10:39:36 +0200
From: Joel Granados <j.granados@samsung.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: Klaus Jensen <its@irrelevant.dk>, David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian
	<kevin.tian@intel.com>, Minwoo Im <minwoo.im@samsung.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>, Klaus Jensen
	<k.jensen@samsung.com>
Subject: Re: [PATCH RFC PREVIEW 1/6] iommu/vt-d: Separate page request queue
 from SVM
Message-ID: <20240904083936.ftqz4sbuykk6mbjy@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e3f3e82e-8884-48da-b5ed-e0016fc27b04@linux.intel.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsWy7djP87oXZW6kGax5amGxeeJWNouJKycz
	W/z6YmGx/+A3VouZM04wWnTO3sBusfTtVnaLy7vmsFkc/PCE1aLljqkDl8eTg/OYPNbMW8Po
	sXmFlsfiPS+ZPM7tOM/usWlVJ5vHvJOBHi82z2T0+LxJzmPr59ssAVxRXDYpqTmZZalF+nYJ
	XBmzlvawFvRpVpz4sIG9gfGzfBcjJ4eEgInEvF132boYuTiEBFYwSvTc/8sK4XxhlDg65T2U
	85lR4uXqX4xdjBxgLTcOckHElzNKzD7znB1kFFhR62R7iMQWRoldK+ewgCRYBFQk3p/dwQZi
	swnoSJx/c4cZxBYRUJdoatwLtptZ4C+TxNLdT8AmCQuES7Re2Q/WzCvgIHHw+W42CFtQ4uTM
	J2BxZgE9iRtTp7CBXMQsIC2x/B8HRFheonnrbLD5nALOEhPe7GOB+FNZ4uCyQ+wQdq3EqS23
	mED2Sgis55SYv34+M0TCRWLh5ltQDcISr45vgWqQkfi/cz5Uw2RGif3/PrBDOKsZJZY1fmWC
	qLKWaLnyBKrDUeLNn00skPDik7jxVhDiOj6JSdumM0OEeSU62oQmMKrMQvLaLCSvzUJ4bRaS
	1xYwsqxiFE8tLc5NTy02zkst1ytOzC0uzUvXS87P3cQITGen/x3/uoNxxauPeocYmTgYDzFK
	cDArifC+FrmRJsSbklhZlVqUH19UmpNafIhRmoNFSZxXNUU+VUggPbEkNTs1tSC1CCbLxMEp
	1cCUwD9zVfms84t5+uKlEr4eTFvgpNz/dTdfzepJi3597zlq7pxwwNhhRUTRvoAXxo8LjZ5I
	dD57cHv/Cfn8vxesfa46SRwXlNRRW3gk3ON9sEqRPMNSU/6pLwKlbthK29l92vJOnC3NW0xq
	jmUs2/L7cVN5N9rHl8d9/xc4MfcF707zewkz+VR2aApc9Cuaod7/1FRjqfc68/qp6jMV21LC
	y1MrN+p/u29vcPr95oQHhpkfuTfzey1TuFKs3v4k/K5b358p2ZKH1pWGRs4J2Jhj6J5w4uT8
	bR9+b3wrEhD4/+jnQzPMJO7HH4qM2KzRn1xi2HDgsrVI46TOMo/F9qL7mZwiHond81hds3KT
	dokSS3FGoqEWc1FxIgCH0ZX51gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsVy+t/xu7oXZW6kGbxbJ2mxeeJWNouJKycz
	W/z6YmGx/+A3VouZM04wWnTO3sBusfTtVnaLy7vmsFkc/PCE1aLljqkDl8eTg/OYPNbMW8Po
	sXmFlsfiPS+ZPM7tOM/usWlVJ5vHvJOBHi82z2T0+LxJzmPr59ssAVxRejZF+aUlqQoZ+cUl
	tkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehmzlvawFvRpVpz4sIG9gfGz
	fBcjB4eEgInEjYNcXYxcHEICSxklZux5wdrFyAkUl5HY+OUqlC0s8edaFxuILSTwkVFi+UxT
	iIYtjBKHes6DFbEIqEi8P7sDrIhNQEfi/Js7zCC2iIC6RFPjXjaQBmaBv0wSS3c/YQdJCAuE
	S7Re2c8CYvMKOEgcfL6bDWJqG5PEwb+dUAlBiZMzn4DZzAJ6EjemTmEDOZtZQFpi+T8OiLC8
	RPPW2WDLOAWcJSa82ccCcbWyxMFlh9gh7FqJz3+fMU5gFJmFZOosJFNnIUydhWTqAkaWVYwi
	qaXFuem5xYZ6xYm5xaV56XrJ+bmbGIGxvu3Yz807GOe9+qh3iJGJg/EQowQHs5II72uRG2lC
	vCmJlVWpRfnxRaU5qcWHGE2BYTSRWUo0OR+YbPJK4g3NDEwNTcwsDUwtzYyVxHndLp9PExJI
	TyxJzU5NLUgtgulj4uCUamAqlm0Nfj69SEZ0uX18b3flVU0vFjbWl/7FdaHiG2xbdrpsefE8
	+1Pwh28ZB9Wu2zI53/4uH1lzTbg0duVPYcNp6yP3SN1OehWbbKipLjpJKf7EFDWNGRsnu/z+
	saq+3/sjf4RxXufVlP+rZn8376uMjLshmLiFO+peZkRsc8iruM7sbyvjT7/afM0gLlEt7OCb
	E6dNV3AzaGbZK6p1Kvr8/sh7LWWT++luDdYHc369zj36UPvWvp4wg9Vak3jUE836frTkqKx8
	9bwt8iBH7qol9usKKl1XxF2YIr1MPeNH6pvO40bviz3ypTac80jIefop7YHNBKcDWgfc9v31
	m31S24wtj4V37o2HG3VU1yuxFGckGmoxFxUnAgCrcILrfgMAAA==
X-CMS-MailID: 20240904083945eucas1p2a444ad211bdccb73cb638f37cbddcade
X-Msg-Generator: CA
X-RootMTR: 20240901051654eucas1p283642707d8dfafef7ce45b37c7685204
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240901051654eucas1p283642707d8dfafef7ce45b37c7685204
References: <20240826-iopf-for-all-v1-0-59174e6a7528@samsung.com>
	<20240826-iopf-for-all-v1-1-59174e6a7528@samsung.com>
	<CGME20240901051654eucas1p283642707d8dfafef7ce45b37c7685204@eucas1p2.samsung.com>
	<e3f3e82e-8884-48da-b5ed-e0016fc27b04@linux.intel.com>

On Sun, Sep 01, 2024 at 01:16:43PM +0800, Baolu Lu wrote:
> On 2024/8/26 19:40, Klaus Jensen wrote:
> > From: Joel Granados<j.granados@samsung.com>
> > 
> > IO page faults are no longer dependent on CONFIG_INTEL_IOMMU_SVM. Move
> > all Page Request Queue (PRQ) functions that handle prq events to a new
> > file in drivers/iommu/intel/prq.c. The page_req_des struct is made
> > available in drivers/iommu/intel/iommu.h.
> > 
> > No functional changes are intended. This is a preparation patch to
> > enable the use of IO page faults outside the SVM and nested use cases.
> > 
> > Signed-off-by: Joel Granados<j.granados@samsung.com>
> > ---
> >   drivers/iommu/intel/Makefile |   2 +-
> >   drivers/iommu/intel/iommu.c  |  18 +--
> >   drivers/iommu/intel/iommu.h  |  40 +++++-
> >   drivers/iommu/intel/prq.c    | 290 ++++++++++++++++++++++++++++++++++++++++
> >   drivers/iommu/intel/svm.c    | 308 -------------------------------------------
> >   5 files changed, 331 insertions(+), 327 deletions(-)
...
> > diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> > index b67c14da1240..b3d98e706ed8 100644
> > --- a/drivers/iommu/intel/iommu.h
> > +++ b/drivers/iommu/intel/iommu.h
> > @@ -694,6 +694,35 @@ struct iommu_pmu {
> >   #define IOMMU_IRQ_ID_OFFSET_PRQ		(DMAR_UNITS_SUPPORTED)
> >   #define IOMMU_IRQ_ID_OFFSET_PERF	(2 * DMAR_UNITS_SUPPORTED)
> >   
> > +/* Page request queue descriptor */
> > +struct page_req_dsc {
> > +	union {
> > +		struct {
> > +			u64 type:8;
> > +			u64 pasid_present:1;
> > +			u64 rsvd:7;
> > +			u64 rid:16;
> > +			u64 pasid:20;
> > +			u64 exe_req:1;
> > +			u64 pm_req:1;
> > +			u64 rsvd2:10;
> > +		};
> > +		u64 qw_0;
> > +	};
> > +	union {
> > +		struct {
> > +			u64 rd_req:1;
> > +			u64 wr_req:1;
> > +			u64 lpig:1;
> > +			u64 prg_index:9;
> > +			u64 addr:52;
> > +		};
> > +		u64 qw_1;
> > +	};
> > +	u64 qw_2;
> > +	u64 qw_3;
> > +};
> 
> Why not move this structure to prq.c? It is specific to that file. Or
> not?
I had left it here because it was included in `struct intel_iommu` but
since it is just a pointer, I think it can be put there if it makes more
sense.

> 
> > +
> >   struct intel_iommu {
> >   	void __iomem	*reg; /* Pointer to hardware regs, virtual addr */
> >   	u64 		reg_phys; /* physical address of hw register set */
> > @@ -719,12 +748,10 @@ struct intel_iommu {
> >   
> >   	struct iommu_flush flush;
> >   #endif
> > -#ifdef CONFIG_INTEL_IOMMU_SVM
> >   	struct page_req_dsc *prq;
> >   	unsigned char prq_name[16];    /* Name for PRQ interrupt */
> >   	unsigned long prq_seq_number;
> >   	struct completion prq_complete;
> > -#endif
> >   	struct iopf_queue *iopf_queue;
> >   	unsigned char iopfq_name[16];
> >   	/* Synchronization between fault report and iommu device release. */
> > @@ -1156,12 +1183,13 @@ void intel_context_flush_present(struct device_domain_info *info,
> >   				 struct context_entry *context,
> >   				 bool affect_domains);
> >   
> > +int intel_enable_prq(struct intel_iommu *iommu);
> > +int intel_finish_prq(struct intel_iommu *iommu);
> > +void intel_page_response(struct device *dev, struct iopf_fault *evt,
> > +			struct iommu_page_response *msg);
> > +
> >   #ifdef CONFIG_INTEL_IOMMU_SVM
> >   void intel_svm_check(struct intel_iommu *iommu);
> > -int intel_svm_enable_prq(struct intel_iommu *iommu);
> > -int intel_svm_finish_prq(struct intel_iommu *iommu);
> > -void intel_svm_page_response(struct device *dev, struct iopf_fault *evt,
> > -			     struct iommu_page_response *msg);
> >   struct iommu_domain *intel_svm_domain_alloc(struct device *dev,
> >   					    struct mm_struct *mm);
> >   void intel_drain_pasid_prq(struct device *dev, u32 pasid);
> > diff --git a/drivers/iommu/intel/prq.c b/drivers/iommu/intel/prq.c
> > new file mode 100644
> > index 000000000000..2814373e95d8
> > --- /dev/null
> > +++ b/drivers/iommu/intel/prq.c
> > @@ -0,0 +1,290 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright © 2015 Intel Corporation.
> > + *
> > + * Authors: David Woodhouse<dwmw2@infradead.org>
> 
> Many contributors have worked on the code moved in this change. The
> original authorship is no longer relevant.
> 
> Consider adding a comment like 'Split from svm.c' to document the
> origin.
Good point. Will do that.

> > + */
> > +
> > +#include <linux/pci.h>
> > +
> > +#include "iommu.h"
> > +#include "../iommu-pages.h"
> > +#include "trace.h"
> > +
> > +static bool is_canonical_address(u64 addr)
> > +{
> > +	int shift = 64 - (__VIRTUAL_MASK_SHIFT + 1);
> > +	long saddr = (long) addr;
> > +
> > +	return (((saddr << shift) >> shift) == saddr);
> > +}
...
> > +			QI_PGRP_RESP_CODE(msg->code) |
> > +			QI_PGRP_RESP_TYPE;
> > +	desc.qw1 = QI_PGRP_IDX(prm->grpid) | QI_PGRP_LPIG(last_page);
> > +	desc.qw2 = 0;
> > +	desc.qw3 = 0;
> > +
> > +	qi_submit_sync(iommu, &desc, 1, 0);
> > +}
> 
> The intel_drain_pasid_prq() helper should be moved to prq.c. It's no
> longer specific to SVM.
Oops. missed that one. Will do.

Will address these and the rest of the comments in my V1

Thx for the review

Best

-- 

Joel Granados
