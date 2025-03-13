Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCCA265CAB
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 10:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741862597; cv=none; b=d3qEA5BOEhLndQHeHB1Kxo5GhxqVUtV9dksF0E7TQmIYByPmcQILzAFRCK8PdrnPRUghlpMFadtMLpjmr7G2ojMRCMhQ7jnQmCioeQGRLEbg3NA++6JxWpgN21eUuZX19Dk3UpUPonDAxneOTVpdVI4SAPttg2i1M9HF/PZFMAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741862597; c=relaxed/simple;
	bh=IVeYqcQ7mMJgmqLGzL+8J1PV9CdWuhC7wLLbzMbjGWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kiINjyK/ipBO/PHoAWi6mxXlZ8rBAS34JsSES6z3GtXObT5iBs3znbTx4aiVZttoErUekfNVnxfj17JioBtFZF3fqXv+JpQ3li7Wh3/ZS8fzhwF4w61X7gPIBK39rCqL6z83oqooHUApMGFwPellEHr+PqvoRE8HVg8sCEc8Kl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 319561516;
	Thu, 13 Mar 2025 03:43:25 -0700 (PDT)
Received: from mazurka.cambridge.arm.com (mazurka.cambridge.arm.com [10.2.80.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 987113F694;
	Thu, 13 Mar 2025 03:43:10 -0700 (PDT)
From: =?UTF-8?q?Miko=C5=82aj=20Lenczewski?= <miko.lenczewski@arm.com>
To: ryan.roberts@arm.com,
	suzuki.poulose@arm.com,
	yang@os.amperecomputing.com,
	corbet@lwn.net,
	catalin.marinas@arm.com,
	will@kernel.org,
	jean-philippe@linaro.org,
	robin.murphy@arm.com,
	joro@8bytes.org,
	akpm@linux-foundation.org,
	mark.rutland@arm.com,
	joey.gouly@arm.com,
	maz@kernel.org,
	james.morse@arm.com,
	broonie@kernel.org,
	anshuman.khandual@arm.com,
	oliver.upton@linux.dev,
	ioworker0@gmail.com,
	baohua@kernel.org,
	david@redhat.com,
	jgg@ziepe.ca,
	shameerali.kolothum.thodi@huawei.com,
	nicolinc@nvidia.com,
	mshavit@google.com,
	jsnitsel@redhat.com,
	smostafa@google.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Cc: =?UTF-8?q?Miko=C5=82aj=20Lenczewski?= <miko.lenczewski@arm.com>
Subject: [PATCH v3 0/3] Initial BBML2 support for contpte_convert()
Date: Thu, 13 Mar 2025 10:41:09 +0000
Message-ID: <20250313104111.24196-2-miko.lenczewski@arm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi All,

This patch series adds adding initial support for eliding
break-before-make requirements on systems that support BBML2 and
additionally guarantee to never raise a conflict abort.

This support elides a TLB invalidation in contpte_convert(). This
leads to a 12% improvement when executing a microbenchmark designed
to force the pathological path where contpte_convert() gets called.
This represents an 80% reduction in the cost of calling
contpte_convert().

This series is based on v6.14-rc4 (d082ecbc71e9).

Patch 1 implements an allow-list of cpus that support BBML2, but with
the additional constraint of never causing TLB conflict aborts. We
settled on this constraint because we will use the feature for kernel
mappings in the future, for which we cannot handle conflict aborts
safely.

Yang Shi has a series at [1] that aims to use BBML2 to enable splitting
the linear map at runtime. This series partially overlaps with it to add
the cpu feature. We believe this series is fully compatible with Yang's
requirements and could go first.

[1]:
  https://lore.kernel.org/linux-arm-kernel/20250304222018.615808-1-yang@os.amperecomputing.com/

Mikołaj Lenczewski (3):
  arm64: Add BBM Level 2 cpu feature
  iommu/arm: Add BBM Level 2 smmu feature
  arm64/mm: Elide tlbi in contpte_convert() under BBML2

 .../admin-guide/kernel-parameters.txt         |  3 +
 arch/arm64/Kconfig                            | 11 +++
 arch/arm64/include/asm/cpucaps.h              |  2 +
 arch/arm64/include/asm/cpufeature.h           |  6 ++
 arch/arm64/kernel/cpufeature.c                | 76 +++++++++++++++++++
 arch/arm64/kernel/pi/idreg-override.c         |  2 +
 arch/arm64/mm/contpte.c                       |  3 +-
 arch/arm64/tools/cpucaps                      |  1 +
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  3 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  3 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  4 +
 11 files changed, 113 insertions(+), 1 deletion(-)

-- 
2.48.1

