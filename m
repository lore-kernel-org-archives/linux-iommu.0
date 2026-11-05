Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793844083;
	b=YDs8JE63xwS2Kjo9JfbXZqwFIGghROp9pXkETlgaGrcH5sIqwIJE1qlzDYVpcS3DIRDE
	 b16rI4xY08bRlhtUcfShB/H14fFZF1NuDxk+kWlM9qXGTN2FA/F2CzuwtSSfsNOaqeurm
	 hCvNhYKbeOgXFkvzCisvC8QV8xEF8U+sqyGQ/iOcs668al0exSmoAD/LEIEwnNJ8Y8LHW
	 XOe7hN46j3ArKBJ/oVoE2KOsuip0VaMUgDJG6I4HOigav17PvrlOIhhzG+ITOAe7kXvrz
	 KPe591wpjlAZI+iGA5QMFtucbqNfrxJDnU0j4n9Xo/tWxPpRsclnYyEq9lY3Grg8isg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793844083;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
	bh=VCBsFynuOrE8eD7Pz2S8sWwbPOUUcj3FdysVp5dx9ts=;
	b=SCAbhbi/Oq5xgefQoeXWoZZ5U6DRcHqZizPPpA1YUgRv0c6+CAZT6P5PeBbJB7MFYO/Y
	 RwQpMvX4LwuJm33n95SL3zvHS6zDtpyhnTifb3HaRUtq++FaPBY1RBmy9FLWgGeiS9f40
	 idZe1ty8lxy+XVAuJxI3+pjUmp0dfW8K0xTAa3R94p/04sFtYlvM4BYQyMecv1sJFaPE3
	 LcNl70vYBRXfga1K7P+gEAQEwtIqRhONpUwb6Y4eFT3n39mNoTLF9KX4ctTcDEwU/T1co
	 5G8CVBpASU+BNj+nQakzQY4j19VnH8GpLS1TogWOnBoUXGEv9j/fXvD8H1lvc5wjOCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=F9btZDhp;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE1A6083624
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 02:01:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AE1A6083624
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=F9btZDhp
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id AD3E320B7169;
	Wed,  4 Nov 2026 18:01:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AD3E320B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793844067;
	bh=VCBsFynuOrE8eD7Pz2S8sWwbPOUUcj3FdysVp5dx9ts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F9btZDhpmpksZ8VkM5u+rHtCl4ZJIbrll4SasJlVFien2zuv448KSS6E9tLLmmIOr
	 KNWXwR/OPSMAgf/gnyZaUwQtT6Tby3M29vgcYjGWJ3tVzfZb/iT7P4Au6Aq4HOz0Y2
	 NjLdr4pFEhN82j5sGXyD3BSubG0sT9DZPbvKCxbs=
From: Mukesh R <mrathor@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-arch@vger.kernel.org
Cc: jgg@nvidia.com,
	jacob.pan@linux.microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	arnd@arndb.de,
	mrathor@linux.microsoft.com
Subject: [PATCH V4 3/5] mshv: Import data structs around device domains from hyperv headers
Date: Wed,  4 Nov 2026 18:01:04 -0800
Message-ID: <20261105020106.3496339-4-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
In-Reply-To: <20261105020106.3496339-1-mrathor@linux.microsoft.com>
References: <20261105020106.3496339-1-mrathor@linux.microsoft.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Copy/import from Hyper-V public headers, definitions and hypercalls that
are related to checking for device domain availibility, and mapping and
unmapping of device pages.

Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
---
 include/hyperv/hvgdk_mini.h |  4 ++++
 include/hyperv/hvhdk_mini.h | 15 +++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 966945f0504f..606b16f43e16 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -327,6 +327,8 @@ union hv_hypervisor_version_info {
 /* stimer Direct Mode is available */
 #define HV_STIMER_DIRECT_MODE_AVAILABLE			BIT(19)
 
+#define HV_DEVICE_DOMAIN_AVAILABLE			BIT(24)
+
 /*
  * Implementation recommendations. Indicates which behaviors the hypervisor
  * recommends the OS implement for optimal performance.
@@ -489,6 +491,8 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST	0x00b0
 #define HVCALL_CREATE_DEVICE_DOMAIN			0x00b1
 #define HVCALL_ATTACH_DEVICE_DOMAIN			0x00b2
+#define HVCALL_MAP_DEVICE_GPA_PAGES			0x00b3
+#define HVCALL_UNMAP_DEVICE_GPA_PAGES			0x00b4
 #define HVCALL_SIGNAL_EVENT_DIRECT			0x00c0
 #define HVCALL_POST_MESSAGE_DIRECT			0x00c1
 #define HVCALL_DISPATCH_VP				0x00c2
diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
index 57b70efe60d4..bb42b81df848 100644
--- a/include/hyperv/hvhdk_mini.h
+++ b/include/hyperv/hvhdk_mini.h
@@ -549,6 +549,7 @@ union hv_device_id {		/* HV_DEVICE_ID */
 } __packed;
 
 /* Device domain types */
+#define HV_DEVICE_DOMAIN_TYPE_S2	0 /* HV_DEVICE_DOMAIN_ID_TYPE_S2 */
 #define HV_DEVICE_DOMAIN_TYPE_S1	1 /* HV_DEVICE_DOMAIN_ID_TYPE_S1 */
 
 /* ID for default domain and NULL domain */
@@ -657,6 +658,20 @@ struct hv_output_get_iommu_capabilities {
 	u64 pgsize_bitmap;
 } __packed;
 
+struct hv_input_map_device_gpa_pages { /* HV_INPUT_MAP_DEVICE_GPA_PAGES */
+	struct hv_input_device_domain device_domain;
+	union hv_input_vtl target_vtl;
+	u8 padding[3];
+	u32 map_flags;
+	u64 target_device_va_base;
+	u64 gpa_page_list[];
+} __packed;
+
+struct hv_input_unmap_device_gpa_pages {  /* HV_INPUT_UNMAP_DEVICE_GPA_PAGES */
+	struct hv_input_device_domain device_domain;
+	u64 target_device_va_base;
+} __packed;
+
 /* HV_LOGICAL_DEVICE_PROPERTY_CODE */
 enum hv_logical_device_property_code {
 	HV_LOGICAL_DEVICE_PROPERTY_PVIOMMU = 10,
-- 
2.51.2.vfs.0.1

