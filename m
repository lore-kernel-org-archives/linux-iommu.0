Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DA54A0902;
	Tue,  8 Sep 2026 21:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788904120; cv=none; b=W04zIfClJx/zeF8ZcKiVR65XdEOW6TUXcpxyVdRjPrzfE5pyAQGtvQxJdBBRoixrMo282W0WB6lt5POrA92/bOQz4fVHJyvNHJ2g6wIlMS40F2bZUQEkD22FdjLM3sfg51wJVcZaf+qpZ7MeCmG2c7hp86tqw5AxwYqlxi23aXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788904120; c=relaxed/simple;
	bh=Bo+6Rdn77POaJ6YwdOntdmZgfwKCdhinnWntII9lVdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ISoMW6OQle22j7lYCbTVp+3zVjcxWsXxKVXqxrex619rh6ovPsqlejRsBvbE0PvEThLir2CjT4IsXvIVRbHaODGXV2PAg5yFTkuz+0IgSA2M1/AcMwcgKHwhxBvI0Jf2Ck0b3sdcmdRLMnKm+s2sKIJqP1yOuohNcQUKSf9IXsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=ioicMYGF; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ioicMYGF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=1f34i7ELcyl//Ubi8x1ZRHLDiv9uG7Y8v6wrp7ZZgSE=; b=ioicMYGF/98d
	qqjSckkmuGfCT4jG2sqqS5SHNBYilUq7PKPSjAOqQ97blwRkAbMGvXwul/TqrGC2PoyXN5pZl4+I9
	BisoZ1Jrs7mHw0YphNv29cCzAYkFZLdRUAtThlbGn6+IYXSAHe4Y5j54TrYMfzDB2g+r87bjD9l2S
	sJ3wDPOI4SKkE2DgHNGPdYZLpQ+z2XL/y5hCyiU85K5QbjLTSOG4bMcbztR3DCX/lo114qVxjfNTa
	afzC6XCwu9zY1Fzz5R7kmLCH91yfXLiS0g64cudwuG2v+dhwPXsVmPQWRNHE4wSRpADBDdOcbLBeb
	UOq8JbAcCCsEs49oUYBgRA==;
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=LekKit-T14)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <eva.kurchatova@virtuozzo.com>)
	id 1x43db-002qQQ-1B;
	Tue, 08 Sep 2026 23:48:23 +0200
From: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Eva Kurchatova <eva.kurchatova@virtuozzo.com>,
	iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/2] selftests: iommu: skip when the mock device is not there
Date: Wed,  9 Sep 2026 00:48:12 +0300
Message-ID: <20260908214825.2682078-2-eva.kurchatova@virtuozzo.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908214825.2682078-1-eva.kurchatova@virtuozzo.com>
References: <20260908214825.2682078-1-eva.kurchatova@virtuozzo.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both iommufd tests need the mock device the iommufd module registers
under CONFIG_IOMMUFD_TEST, and they open /dev/iommu in every fixture
without checking, so on a kernel that does not provide it every case
fails on the open.

Checking the open is not enough on its own. /dev/iommu appears as soon
as the iommufd module is loaded, which says nothing about the mock
device: the release config here is CONFIG_IOMMUFD=m with
CONFIG_IOMMUFD_TEST unset, so the open succeeds and the tests fail later
in the ioctls that drive the mock device instead. Only the debug config
sets CONFIG_IOMMUFD_TEST.

/sys/bus/iommufd_mock covers both, it exists only once the module is
loaded and the kernel was built with CONFIG_IOMMUFD_TEST. Check for it
once before handing over to the harness, rather than in each of the
fixtures, and report a skip. test_harness_run() is what TEST_HARNESS_MAIN
calls anyway, so the tests still run exactly as they did.

Signed-off-by: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
---
 tools/testing/selftests/iommu/iommufd.c          | 15 ++++++++++++++-
 tools/testing/selftests/iommu/iommufd_fail_nth.c | 15 ++++++++++++++-
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index d44b34b05757..446306badcdc 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -3613,4 +3613,17 @@ TEST_F(iommufd_device_pasid, pasid_attach)
 	test_cmd_mock_domain_replace(self->stdev_id, self->ioas_id);
 }
 
-TEST_HARNESS_MAIN
+static bool iommufd_mock_available(void)
+{
+	return access("/sys/bus/iommufd_mock", F_OK) == 0;
+}
+
+int main(int argc, char **argv)
+{
+	if (!iommufd_mock_available())
+		ksft_exit_skip("no iommufd mock device, the tests need "
+			       "CONFIG_IOMMUFD_TEST=y and the iommufd "
+			       "module loaded\n");
+
+	return test_harness_run(argc, argv);
+}
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index 25495d8dceb3..c516e00f7316 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -745,4 +745,17 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 	return 0;
 }
 
-TEST_HARNESS_MAIN
+static bool iommufd_mock_available(void)
+{
+	return access("/sys/bus/iommufd_mock", F_OK) == 0;
+}
+
+int main(int argc, char **argv)
+{
+	if (!iommufd_mock_available())
+		ksft_exit_skip("no iommufd mock device, the tests need "
+			       "CONFIG_IOMMUFD_TEST=y and the iommufd "
+			       "module loaded\n");
+
+	return test_harness_run(argc, argv);
+}
-- 
2.55.0

