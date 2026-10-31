Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793417084;
	b=gQ0Mo+QwOPjWja5zgAKTefVmSzHQXsxQHqT4yNJJ4CgtRGJ9a3a8aHi9I+gK7ikLNubH
	 OlUJCjEdPbnTSYhZ+M7vS/qPYe5pc2D2+U+NzyzGvrahaMkznhRIWnvG9JAN2sG5ppYYO
	 ZAJLPA7XBLYcoW3E+XlIVgUaKtHh31fpktE8sTbkIpSpZmISFqgNqlA7smoNzEFH3VUTj
	 nPBV1SWVSp37ony4mU7LWz2Ni7y4RcpFddacRNhPMsATOIx0No00W1Q/zvvj1iwM1RDWm
	 3wZZooV2Zr5DVhT2kHh+XQIX5k3+6rmXLY/e3KtjBAsUid9Mw+JMZG/jOPi3cG4zK+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793417084;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=CNOdgi8pXw7fCfRQBi53Vsp5m4ux5kk2uvEIcUUPf94=;
	b=Fmpnbu/UT+E2DKOzSlrefgNpgpqPUNQWf7lKFkHS2TncsWDHuWoWQCEwoAD0ry0mol2d
	 aAR0oXjYDw99gkhdVW3LXxj+DzDAgE9VIpJKiPCS4fmCnw6IXep6KoaUvytZnnjDC60c4
	 ru/5c60GrIlWrcSIDrovvFaRvHkmRdy011JBMljEeHx+bhh62TID3P0m6l1Ne9BB44Ofq
	 jhmVAQb+XyScYfwEq0Lnu5htYKZGjrCf/5eiQPGPEQvTw4bA2qIem3IBSeEJ9Gm4EQ61f
	 ZL1jYlC8ec69wtmVfSeQ2AKAFd752QlLvbpN34zBGQwiwyVT2VYgnAcbL2ybyeA4llA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KIWLRyuV;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E54606A31D
	for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 03:24:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52E54606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KIWLRyuV
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ea7f9c11e6so27875ad.0
        for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 20:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793417084; x=1794021884; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CNOdgi8pXw7fCfRQBi53Vsp5m4ux5kk2uvEIcUUPf94=;
        b=KIWLRyuVdNVpk20xkqyz1DbRPysEeT2M8oZcHWg5sUGGlNV+rBHmg9F17mZsF4tR76
         VqhoG8odZe/rSXpT64TsuKYwF9RelPKiJZxTum6UlEELN7zKGuSVDA7UsthR8dQsqdUG
         4zTfLUPyyS0NaRISNHpVX7pRebr1gJrURj38kuSNfpziiSFhyLZDnFZbfgtZFv8h5QxL
         lPjG1nPBgFN2mlLgKbvr+u/kJvFbeGyX9eRJpm3/AcHhlnMZ8Yr4LHZMM3uuEWEAwYMz
         tFP+axkNwqg3dXI2J5eaGI0sQgsLrP02UxFypImkVW3+sN3lUzftHJV3Fz7wV+Uhnud2
         vLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793417084; x=1794021884;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CNOdgi8pXw7fCfRQBi53Vsp5m4ux5kk2uvEIcUUPf94=;
        b=eImPEeOyOhj0a3KHBLwA3c10nhhBI1DcTwEv7YZ8/olkrGNkTn6DhrDkvlHsnZa+qv
         KhLXaEWOTtdJGOagWzfCNqFOMd6v9UpyqcGXCKY26Ic3SICvwU5DV1K91Lv8Q+JqYBM9
         stokDPusLa2/VybHrDNjhQ1TzTCxn/BxhhRbrNf8Sja0PsybxYaieDbtBPj8yjBrtzh1
         fnylzmehtfgwQHGYyhhesxpNA9insC+J6zWhZ+MD+gNt4+1gUmBdhV+qZmtEJL5giXHJ
         dP1ltkdKyKi/5XaV0OhDdIsOQdJKOlWFbwcDxXvOVAMvZMbAs5Zxmv9YaSHW7TztkmCq
         iXnA==
X-Forwarded-Encrypted: i=1; AKwUvByeGe32ZCbjesDwlQ8iAqyML9h3oL+1cAWGrhLbDte3RktUizWBGLAxk/6K4aeoJpCsJFKAag==@lists.linux.dev
X-Gm-Message-State: AFq9FYJQQkxprQBF31UEOP3SulqSOAhAcWNGvEg7GgZ8LorFRipvcUtM
	ODKitybbLm7PLm783mK0oB1aTxbSRvvLhTpbH3kFTZkKcPSrnw52YBTKcvHYC0UIXA==
X-Gm-Gg: AYBFou0Z0nJ6ZP+3+kvJ1mADmXzW5PGYNaRfYbauMh+lDbrPcyJMaXSETggy0xmmwmy
	Ku2JQkYSRDG5NC5bwApnwuTxU9DqHMVqnW2w1zmaB7DTBKtVGPc9gYfQXu0AvISNU/RpMvyEghq
	uijX39+BnZFHlH+trd38kuJrZxTXAy+d1QU0JkpUKjo1fAbyzcIO3+sYRuSNNb8piHqE36q+rS7
	WHFz2jzl1pvzhSWECVzRRenbhmbfXYVzAwr8hpBFH5anhQ/g7yQqfgZG0PPXJoYM1B4p6xAI/v2
	ileOjcF1aaL89/DmYXk7tUHr4ATsyQYU1in0cLl53iR9GVArWGiEboWKUVxC2tmRRJ7np7kOMSD
	VEgfbQSdtyl/pnn6k0c0EUD0r2ONP8QZ0jE56WbqpFjrcBCIAkY0kH1oQRO3Yn2fBkYMGN5QjWP
	cmrhrTPnfK5S2PrvjJWCmh4wIrePQEz7Q3wvABgN+DU/Pu1T33MezfN/7TAF9i3XE+B1B076HBO
	gWNbnKmblaJuuRKb9PQmoOMYWgopV4Pv3X2XCsz0JhPylJasalPai9DVHjbkYOh79sG1r1p4uTb
	ylwE3nvXfGphlXrioxQsAYH+aRhBgk5G+CPvteqb8LeamINHfDkshUqwGPc/9kSB2aGJLzyV9QT
	OOgiWZRHDgSGim3Knf7CGkDIQvCslpeeswLkSGLu4EUE=
X-Received: by 2002:a17:902:fc47:b0:2d5:db38:8010 with SMTP id d9443c01a7336-2eb1ecbb24cmr15024995ad.15.1793417082975;
        Fri, 30 Oct 2026 20:24:42 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e8fb2fesm10363129a91.4.2026.10.30.20.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 20:24:42 -0700 (PDT)
Date: Sat, 31 Oct 2026 03:24:38 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, David Woodhouse <dwmw2@infradead.org>, 
	YiFei Zhu <zhuyifei@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Ankit Soni <Ankit.Soni@amd.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Subject: Re: [PATCH v6 15/18] iommufd: Persist iommu hardware pagetables for
 live update
Message-ID: <auVatSyjUkYAoFR4@google.com>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-16-skhawaja@google.com>
 <98fe2806-d4a3-4bee-9324-d1862b2a2cb4@linux.intel.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <98fe2806-d4a3-4bee-9324-d1862b2a2cb4@linux.intel.com>

On Sat, Oct 31, 2026 at 10:46:56AM +0800, Baolu Lu wrote:
>On 10/25/2026 10:19 AM, Samiullah Khawaja wrote:
>>From: YiFei Zhu <zhuyifei@google.com>
>>
>>Register iommufd with the LUO framework and implement the preserve and
>>unpreserve ops to save marked HWPTs.
>>
>>To make sure mappings do not change during preserved state, add a
>>liveupdate_immutable flag to IOAS. When an HWPT is preserved, its IOAS
>>is marked immutable and any map/unmap attempts will fail with -EBUSY.
>>This is synchronized using the domains_rwsem to prevent races with
>>concurrent mapping operations.
>>
>>The preserve callback iterates over the marked HWPTs, verifies that the
>>backing memory pages are preserved, and calls iommu_preserve_domain() to
>>preserve the associated IOMMU domain.
>>
>>Signed-off-by: YiFei Zhu <zhuyifei@google.com>
>>Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>---
>>  MAINTAINERS                             |   1 +
>>  drivers/iommu/iommufd/io_pagetable.c    |  24 ++
>>  drivers/iommu/iommufd/iommufd_private.h |  16 ++
>>  drivers/iommu/iommufd/liveupdate.c      | 327 ++++++++++++++++++++++++
>>  drivers/iommu/iommufd/main.c            |  10 +-
>>  include/linux/kho/abi/iommufd.h         |  56 ++++
>>  6 files changed, 433 insertions(+), 1 deletion(-)
>>  create mode 100644 include/linux/kho/abi/iommufd.h
>>
>
>[...]
>>diff --git a/drivers/iommu/iommufd/liveupdate.c b/drivers/iommu/iommufd/liveupdate.c
>>index 5fb491ff3a3d..828203d7254c 100644
>>--- a/drivers/iommu/iommufd/liveupdate.c
>>+++ b/drivers/iommu/iommufd/liveupdate.c
>>@@ -9,9 +9,28 @@
>>  #include <linux/file.h>
>>  #include <linux/iommufd.h>
>>+#include <linux/kexec_handover.h>
>>+#include <linux/kho/abi/iommufd.h>
>>  #include <linux/liveupdate.h>
>>+#include <linux/iommu-liveupdate.h>
>>+#include <linux/mm.h>
>>+#include <linux/pci.h>
>>  #include "iommufd_private.h"
>>+#include "io_pagetable.h"
>>+
>>+static u32 iopt_inc_num_preserved_domains(struct io_pagetable *iopt)
>>+{
>>+	guard(rwsem_write)(&iopt->domains_rwsem);
>>+	return ++iopt->num_preserved_domains;
>>+}
>>+
>>+static void iopt_dec_num_preserved_domains(struct io_pagetable *iopt)
>>+{
>>+	guard(rwsem_write)(&iopt->domains_rwsem);
>>+	if (!WARN_ON(!iopt->num_preserved_domains))
>>+		iopt->num_preserved_domains--;
>>+}
>>  int iommufd_hwpt_liveupdate_mark_preserve(struct iommufd_ucmd *ucmd)
>>  {
>>@@ -70,3 +89,311 @@ int iommufd_hwpt_liveupdate_mark_preserve(struct iommufd_ucmd *ucmd)
>>  	iommufd_put_object(ictx, &hwpt->common.obj);
>>  	return rc;
>>  }
>>+
>>+static int iopt_area_validate_file_pages(struct iopt_area *area)
>>+{
>>+	unsigned long last_index = iopt_area_last_index(area);
>>+	unsigned long index = iopt_area_index(area);
>>+	unsigned int page_offset = area->page_offset;
>>+	struct iopt_pages *pages = area->pages;
>>+	unsigned long iova = iopt_area_iova(area);
>>+
>>+	guard(mutex)(&pages->mutex);
>>+	if (WARN_ON(!area->storage_domain))
>>+		return -EINVAL;
>>+
>>+	while (index <= last_index) {
>>+		phys_addr_t phys = iommu_iova_to_phys(area->storage_domain,
>>+						      iova) - page_offset;
>
>iommu_iova_to_phys() returns 0 when there is no underlying DMA
>translation. It would be better to check for !phys and return -EINVAL
>before passing it to page_folio():

Agreed. I will also move the page_offset subtraction after the check.
>
>		if (!phys)
>			return -EINVAL;
>
>>+		struct folio *folio = page_folio(pfn_to_page(PHYS_PFN(phys)));
>>+
>>+		if (folio->mapping != pages->file->f_mapping)
>>+			return -EINVAL;
>>+
>>+		iova += PAGE_SIZE - page_offset;
>
>This walks a full page table per 4K page size, right? Isn't it slow for
>large mappings? Why not jump ahead by folio_size()?

Yes. When filling a domain, iommufd reuses pages that are already pinned
(by an access or another domain). If the memfd was punched in between,
an old page from a different folio can sit in the middle of a folio
range, and jumping by folio_size() would skip it. I will add a comment.
Also see batch_from_domain() implementation, it also does a similar page
walk.

In parallel, I sent a proposal for memfd to block or track hole punch,
so this walk can be skipped. It can be a follow up.
>
>>+		page_offset = 0;
>>+		index++;
>>+	}
>>+
>>+	return 0;
>>+}
>>+
>>+static int iopt_validate_preserved_memory(struct io_pagetable *iopt,
>>+					  struct liveupdate_session *s)
>>+{
>>+	struct iopt_area *area;
>>+	int ret = 0;
>>+
>>+	down_read(&iopt->iova_rwsem);
>>+	for (area = iopt_area_iter_first(iopt, 0, ULONG_MAX); area;
>>+	     area = iopt_area_iter_next(area, 0, ULONG_MAX)) {
>>+		struct iopt_pages *pages = area->pages;
>>+
>>+		if (!pages)
>>+			continue;
>>+
>>+		/* Only allow file based mapping */
>>+		if (pages->type != IOPT_ADDRESS_FILE) {
>>+			ret = -EINVAL;
>>+			break;
>>+		}
>>+
>>+		/* Make sure that the file was preserved. */
>>+		ret = liveupdate_get_token_outgoing(s, pages->file, NULL);
>>+		if (ret)
>>+			break;
>>+
>>+		/*
>>+		 * Make sure the mapped pages are still associated with the
>>+		 * preserved memfd.
>>+		 */
>>+		ret = iopt_area_validate_file_pages(area);
>>+		if (ret)
>>+			break;
>>+	}
>>+	up_read(&iopt->iova_rwsem);
>>+
>>+	return ret;
>>+}
>>+
>>+static int iommufd_preserve_hwpt(struct iommufd_hwpt_paging *hwpt,
>>+				 struct iommufd_hwpt_ser *hwpt_ser,
>>+				 struct liveupdate_session *session)
>>+{
>>+	struct iommu_domain_ser *domain_ser;
>>+	int rc;
>>+
>>+	/*
>>+	 * Make IOAS immutable so the DMA mappings do not change while
>>+	 * the HWPT is preserved. Since one IOAS can have multiple
>>+	 * HWPTs, if an error occurs this call needs to make the IOAS
>>+	 * mutable again if it was the one that made it immutable.
>>+	 */
>>+	if (iopt_inc_num_preserved_domains(&hwpt->ioas->iopt) == 1) {
>>+		rc = iopt_validate_preserved_memory(&hwpt->ioas->iopt, session);
>>+		if (rc)
>>+			goto err;
>>+	}
>>+
>>+	hwpt_ser->size = sizeof(*hwpt_ser);
>>+	hwpt_ser->token = hwpt->liveupdate_token;
>>+
>>+	rc = iommu_preserve_domain(hwpt->common.domain, &domain_ser);
>>+	if (rc < 0)
>>+		goto err;
>>+
>>+	hwpt_ser->domain_ser_phys = virt_to_phys(domain_ser);
>>+	return 0;
>>+
>>+err:
>>+	iopt_dec_num_preserved_domains(&hwpt->ioas->iopt);
>>+	return rc;
>>+}
>>+
>>+static void _iommufd_unpreserve(struct iommufd_ctx *ictx,
>>+				struct iommufd_ser *ser)
>>+{
>>+	struct iommufd_hwpt_paging *hwpt;
>>+	struct iommufd_object *obj;
>>+	unsigned long index;
>>+
>>+	xa_lock(&ictx->objects);
>>+	xa_for_each_marked(&ictx->objects, index, obj, IOMMUFD_OBJ_LIVEUPDATE_MARK) {
>>+		if (obj->type != IOMMUFD_OBJ_HWPT_PAGING)
>>+			continue;
>>+
>>+		hwpt = to_hwpt_paging(container_of(obj, struct iommufd_hw_pagetable, obj));
>>+		if (!hwpt->liveupdate_preserved)
>>+			continue;
>>+
>>+		xa_unlock(&ictx->objects);
>>+
>>+		iommu_unpreserve_domain(hwpt->common.domain);
>>+		iopt_dec_num_preserved_domains(&hwpt->ioas->iopt);
>>+
>>+		hwpt->liveupdate_preserved = false;
>>+		iommufd_put_object(ictx, obj);
>>+
>>+		xa_lock(&ictx->objects);
>>+	}
>>+	xa_unlock(&ictx->objects);
>>+
>>+	kho_unpreserve_free(ser);
>>+}
>>+
>>+static int iommufd_liveupdate_preserve(struct liveupdate_file_op_args *args)
>>+{
>>+	struct iommufd_ctx *ictx;
>>+	struct iommufd_hwpt_paging *hwpt;
>>+	struct iommufd_ser *iommufd_ser;
>>+	struct iommufd_object *obj;
>>+	unsigned int num_hwpts;
>>+	unsigned long index;
>>+	unsigned int i;
>>+	void *mem;
>>+	int rc;
>>+
>>+	ictx = iommufd_ctx_from_file(args->file);
>>+	if (IS_ERR(ictx))
>>+		return PTR_ERR(ictx);
>>+
>>+	mutex_lock(&ictx->liveupdate_mutex);
>>+
>>+	/* Count the number of HWPTs to preserve */
>>+	num_hwpts = 0;
>>+	xa_lock(&ictx->objects);
>>+	xa_for_each_marked(&ictx->objects, index, obj, IOMMUFD_OBJ_LIVEUPDATE_MARK) {
>>+		if (obj->type != IOMMUFD_OBJ_HWPT_PAGING)
>>+			continue;
>>+
>>+		hwpt = to_hwpt_paging(container_of(obj, struct iommufd_hw_pagetable, obj));
>>+		if (!hwpt->common.domain) {
>>+			rc = -EINVAL;
>>+			xa_unlock(&ictx->objects);
>>+			goto out_unlock;
>>+		}
>>+		num_hwpts++;
>>+	}
>>+	xa_unlock(&ictx->objects);
>>+
>>+	mem = kho_alloc_preserve(struct_size(iommufd_ser,
>>+					     hwpt_array, num_hwpts));
>>+	if (IS_ERR(mem)) {
>>+		rc = PTR_ERR(mem);
>>+		goto out_unlock;
>>+	}
>>+
>>+	iommufd_ser = mem;
>>+	iommufd_ser->size = sizeof(*iommufd_ser);
>>+
>>+	/* Preserve HWPTs */
>>+	i = 0;
>>+	xa_lock(&ictx->objects);
>>+	xa_for_each_marked(&ictx->objects, index, obj, IOMMUFD_OBJ_LIVEUPDATE_MARK) {
>>+		if (obj->type != IOMMUFD_OBJ_HWPT_PAGING)
>>+			continue;
>>+
>>+		if (!iommufd_lock_obj(obj)) {
>>+			rc = -ENOENT;
>>+			xa_unlock(&ictx->objects);
>>+			goto out_unpreserve;
>>+		}
>>+
>>+		/*
>>+		 * HWPT is locked so it will not be destroyed. The xarray lock
>>+		 * can be released here before preserving the HWPT.
>>+		 */
>>+		xa_unlock(&ictx->objects);
>>+		hwpt = to_hwpt_paging(container_of(obj, struct iommufd_hw_pagetable, obj));
>>+		rc = iommufd_preserve_hwpt(hwpt, &iommufd_ser->hwpt_array[i++], args->session);
>>+		if (rc) {
>>+			iommufd_put_object(ictx, obj);
>>+			goto out_unpreserve;
>>+		}
>>+
>>+		/*
>>+		 * Mark the HWPT as successfully preserved. This is distinct
>>+		 * from IOMMUFD_OBJ_LIVEUPDATE_MARK, which only indicates the
>>+		 * userspace intent to preserve.
>>+		 */
>>+		hwpt->liveupdate_preserved = true;
>
>Can userspace re-mark an already-preserved HWPT with a new token? It
>seems that mark_preserve() doesn't check hwpt->liveupdate_preserved.
>Would it help to simply return -EBUSY from mark_preserve() once
>hwpt->liveupdate_preserved is set?

Yes, I will handle this case.
>
>>+		xa_lock(&ictx->objects);
>>+	}
>>+	xa_unlock(&ictx->objects);
>>+
>>+	/* Store the actual number of HWPTs that are preserved */
>>+	iommufd_ser->num_hwpts = i;
>>+
>>+	args->serialized_data = virt_to_phys(iommufd_ser);
>>+	mutex_unlock(&ictx->liveupdate_mutex);
>>+	iommufd_ctx_put(ictx);
>>+	return 0;
>>+
>>+out_unpreserve:
>>+	_iommufd_unpreserve(ictx, iommufd_ser);
>>+out_unlock:
>>+	mutex_unlock(&ictx->liveupdate_mutex);
>>+	iommufd_ctx_put(ictx);
>>+	return rc;
>>+}
>>+
>>+static void iommufd_liveupdate_unpreserve(struct liveupdate_file_op_args *args)
>>+{
>>+	struct iommufd_ctx *ictx;
>>+
>>+	ictx = iommufd_ctx_from_file(args->file);
>>+	if (WARN_ON(IS_ERR(ictx)))
>>+		return;
>>+
>>+	mutex_lock(&ictx->liveupdate_mutex);
>>+	_iommufd_unpreserve(ictx, phys_to_virt(args->serialized_data));
>>+	mutex_unlock(&ictx->liveupdate_mutex);
>>+
>>+	iommufd_ctx_put(ictx);
>>+}
>[...]
>
>Thanks,
>baolu

Thanks,
Sami
