Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD1A43D515
	for <iommu@lists.linux.dev>; Thu,  8 Oct 2026 12:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791463943; cv=none; b=HfAbdbQp5gz8Dtxj1Uz1DKQ+PqLwXoGgn+joxLfmtzl8wjJnRIiFnIzO04C1g3+nkObpUYSN2kNXz5YgdqTLMj2pou/s05dKZ4yTvPewoJVEsg6o+eBsWiuG19olyz/Hh9LYKpk6kMLkKZZNBUIs1AMttvzB3zDrXqlYwWTZHUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791463943; c=relaxed/simple;
	bh=6dIlz9XXAXD7hMCFtpO+FQoMd6e7ys9QKDGE/4a3ZjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f01EcGGGQq0mi4k2x08iiOIbXUdu9CrkKZXFtBrm9FBog1lzQDvXhC7WJEMcRnLRMH70iMnyn/x96iNJwl1ju2mINZOLc6GfOx1CEvl/Pdq7W2ETdJL1mkMa6rtPPD/rYu7pk/vEv1BVRxNEVrl3FZGjLb2H6CFYmoDkTk4RdtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DP94H+g1; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DP94H+g1"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48b02a2359aso741216f8f.0
        for <iommu@lists.linux.dev>; Thu, 08 Oct 2026 05:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791463940; x=1792068740; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f8QWxVZoZeLawAHvciNRJOIulLw+ldBkjXIfdbSrmQ4=;
        b=DP94H+g1BDzODX6A/rmm7I7KCeoSgUEjAfMqI08dquN20Mu9FPqAAz3jw/PDFmHvuP
         YcKxlmuIxzz+zDzgjXGkyVMs4GgItMHlHBB9sJLbPi0Ti3tIC51ML3I+FgvZuwEMrpRO
         xf3iJ3KH9q4a5MB5oetg7j+jSkPxYbqSoJyJ8Wvsnb5oeJhEvD+6m0qKOfPR3fWFXCd/
         cLYsliujMZN345YC1ypaHU/6hjBdgP4eSt7dn+Up3HZuWWZ/bBT8AYCtSrJB1WaXLeaR
         gygJhkuIhEGmxNHzQTu9pdqh9g8NxXljXjkrZzGHXBSr1fHnZ7EzoQ7UU9XaWCh/PnuM
         aQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791463940; x=1792068740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f8QWxVZoZeLawAHvciNRJOIulLw+ldBkjXIfdbSrmQ4=;
        b=u6Gfj3T2bysW4h+GSBPPNUncktBkC/PJFhM9xrOWg+B3gGt/bbZrf8AlygKlNxIVQl
         OOFcFFHCtJTZOTP27YShlJoAbN1tdsKV9465pf+mmjNOzemeNc3gDqjSxZYOa3i/o+fT
         YKGrNhgtOnN115328mpRx2F4a+/W4kVdaViiUIjTSjQMt/4B3jpyjBfQoBPA/DX9fIK4
         +sYn3LXmswzQoeWjmPHWzL9Hv7jh1Jvj2H/8uCb+8cqSD6b7WXTjzMbVpWrMBOStGCJz
         ZKA6yZ3HpCIHWQ7rFBzGKNJrDg+IRjRbkG8dIcIyd838glo2i5cibw3SJeXxiC8WGgGY
         lyfA==
X-Forwarded-Encrypted: i=1; AKwUvBwZRUu8Znt5J/kS6dc7oL8WycVLlc5TEzmua0hwcwhccX+v6hR7d4amAxLsuLg8V/+zpx1ENA==@lists.linux.dev
X-Gm-Message-State: AFq9FYLuVpmI+EzRieHHsejO/PsTdUBZ8E41VhQMaTaMTfA7T+cLov3b
	2xWfTOCKRfSh2qNuWfibA5xg7Q9DdjrdDtYxaQgTyKxkXh6cFIfkpMXj
X-Gm-Gg: AYBFou3IuKiCbQhxFmLAbI6DL/4mkwDx8967vvq+z+zUkdWDRpaGgpED703l+3enKsl
	ja+XkDW7Easm9ppS/0FfM+0eU4OBNM2IAHAfVH4M8mUGDBX8RERzAdhIFC0wuMAcWDcTsY4RSyk
	DWbxtU7423lqnmYK6Vn4PygZo29cwbOUr7hXoaBsn7afj7ihqSS6r325ispoi5xfeXeByJ4XiEr
	6HMtZjaE7isXKqDqj/kGLdiTFyXQwqTpBqDaipgHJv+rGsxjoZnd0HsrrteLXM77CO7qzuv8tV7
	fh3AoPUcVnQX20l33NLby98pe6XvlTXGvRHvyNDJsT4KTPA6HxPUKAlo0DRH3LSdglG5/iRmMFQ
	UXMZ/PHtvGiTYLUIncc8ZLEGKJXzjRiv28EIl41cpB8v53tvaESvqA4p79JnJ1DoR5GJSrQsvkC
	jMmh5HQUEyoJVcs5ctdXGjc4Um+cgtBrsUojNV6Iqy9hzOfywH9lsCJuVb56LymEcWOX1XPEMKX
	kyZeAyvmejfVYP7y0x4TwFppvG8Q9mI5E2oSqhtH8D+/CuHM0INGEw=
X-Received: by 2002:a5d:56ca:0:b0:48c:4f4d:4d6a with SMTP id ffacd0b85a97d-48c7f12dee4mr3518058f8f.28.1791463940003;
        Thu, 08 Oct 2026 05:52:20 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.41.237])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d3032csm10584338f8f.45.2026.10.08.05.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 05:52:18 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] iommufd: Keep dmabuf MMIO attributes in domains added later
Date: Thu,  8 Oct 2026 14:52:02 +0200
Message-ID: <20261008125206.11990-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A VFIO PCI dmabuf mapped into an IOAS gets IOMMU_MMIO only in the domains
that exist when it is mapped. A domain attached afterwards, or an
IOMMU_IOAS_COPY of the area, reads the PFNs back from the existing
domain and maps the BAR as cacheable CPU memory. Patch 1 always takes
dmabuf PFNs from the recorded phys range instead.

Sashiko first reported this on patch 6 of David Woodhouse's RFC "KVM:
Allow alternative providers of guest_memfd backed by PFNMAP memory",
which picks the batch kind in pfn_reader_fill_dmabuf() from the
exporter's memory type. This fix does not depend on that series and
combines with it: with both, a domain added later gets the kind the
exporter reports.

The mock page table has no memory type bits, so the existing selftests
cannot see the difference. Patch 2 makes the mock record, per domain,
the pages mapped with IOMMU_MMIO, adds IOMMU_TEST_OP_MD_CHECK_MMIO, and
checks the domain filled later in two new tests, dmabuf_mmio_new_domain
and dmabuf_mmio_copy.

Tested on x86-64 under virtme-ng with CONFIG_IOMMUFD_TEST=y. Without
patch 1 both new tests fail on the second domain in all three mock
domain variants; in dmabuf_mmio_new_domain, a temporary print in
batch_to_domain() showed that domain mapped with IOMMU_READ |
IOMMU_WRITE | IOMMU_CACHE, where the first got IOMMU_READ | IOMMU_WRITE |
IOMMU_MMIO. With patch 1 the dmabuf tests pass, and the other iommufd
selftests give the same results as on the base tree. Patch 2 also
builds for i386 with W=1.

Not tested on hardware that uses the memory type bits (ARM SMMUv3, AMD
with SME, RISC-V).

Changes in v2:
- Validate the MMIO check range before converting 64-bit ioctl inputs
  to native-width page indices. Reject range overflow and values that
  cannot be represented on 32-bit kernels. (Sashiko)
- Patch 1 is unchanged.

V1: https://lore.kernel.org/all/20261005143737.2915-1-parri.andrea@gmail.com/

Andrea Parri (2):
  iommufd: Keep dmabuf PFNs MMIO when filling another domain
  iommufd/selftest: Check dmabuf MMIO mappings filled from another
    domain

 drivers/iommu/iommufd/iommufd_test.h          |  5 +
 drivers/iommu/iommufd/pages.c                 | 13 ++-
 drivers/iommu/iommufd/selftest.c              | 92 +++++++++++++++++++
 tools/testing/selftests/iommu/iommufd.c       | 51 ++++++++++
 tools/testing/selftests/iommu/iommufd_utils.h | 13 +++
 5 files changed, 170 insertions(+), 4 deletions(-)

-- 
2.53.0

