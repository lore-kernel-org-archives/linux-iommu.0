Return-Path: <SRS0=BMay=CL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E604FC433E6
	for <iommu@archiver.kernel.org>; Wed,  2 Sep 2020 05:32:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 994132075D
	for <iommu@archiver.kernel.org>; Wed,  2 Sep 2020 05:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 994132075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7D261863E2;
	Wed,  2 Sep 2020 05:32:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xABzJUppdYWz; Wed,  2 Sep 2020 05:32:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8F7B4861F2;
	Wed,  2 Sep 2020 05:32:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F97FC07FF;
	Wed,  2 Sep 2020 05:32:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3CFCFC0051
 for <iommu@lists.linux-foundation.org>; Wed,  2 Sep 2020 05:32:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0EA112041D
 for <iommu@lists.linux-foundation.org>; Wed,  2 Sep 2020 05:32:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id szKz+GTS8CPp for <iommu@lists.linux-foundation.org>;
 Wed,  2 Sep 2020 05:32:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
 by silver.osuosl.org (Postfix) with ESMTPS id 04445203ED
 for <iommu@lists.linux-foundation.org>; Wed,  2 Sep 2020 05:32:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by a.mx.secunet.com (Postfix) with ESMTP id B4F5D201CC;
 Wed,  2 Sep 2020 07:32:20 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
 by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QX-lgkqzo0Yp; Wed,  2 Sep 2020 07:32:19 +0200 (CEST)
Received: from mail-essen-02.secunet.de (mail-essen-02.secunet.de
 [10.53.40.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by a.mx.secunet.com (Postfix) with ESMTPS id C74D420411;
 Wed,  2 Sep 2020 07:32:19 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 mail-essen-02.secunet.de (10.53.40.205) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Wed, 2 Sep 2020 07:32:19 +0200
Received: from [172.18.16.185] (172.18.16.185) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Wed, 2 Sep 2020
 07:32:19 +0200
Subject: [PATCH] iommu: Allocate dev_iommu before accessing priv data
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <jroedel@suse.de>
References: <e27cd096-a721-db9d-e4ce-7a432ed6cd4c@secunet.com>
 <12935d0b-61ff-d274-b1ee-3b1fba36bdc7@linux.intel.com>
 <1eafacd8-8cdb-d6ae-130c-dca66dbe3598@secunet.com>
 <175fe2a7-922e-1800-298e-1481b648c6d8@linux.intel.com>
From: Torsten Hilbrich <torsten.hilbrich@secunet.com>
Autocrypt: addr=torsten.hilbrich@secunet.com; prefer-encrypt=mutual; keydata=
 mQENBFs5uIIBCAD4qbEieyT7sBmcro1VrCE1sSnV29a9ub8c0Xj0yw0Cz2N7LalBn4a+YeJN
 OMfL1MQvEiTxZNIzb1I0bRYcfhkhjN4+vAoPJ3q1OpSY+WUgphUbzseUk/Bq3gwvfa6/U+Hm
 o2lvEfN2dewBGptQ+DrWz+SPM1TQiwShKjowY/avaVgrABBGen3LgB0XZXEH8Q720kjP7htK
 tCGRt1T+qNIj3tZDZfPkqEVb8lTRcyn1hI3/FbDTysletRrCmkHSVbnxNzO6lw2G1H61wQhw
 YVbIVNohY61ieSJFhNLL6/UTGHtUE2IAicnsUAUKR8GiI1+3cTf233O5HaWYeOjBmTCLABEB
 AAG0L1RvcnN0ZW4gSGlsYnJpY2ggPHRvcnN0ZW4uaGlsYnJpY2hAc2VjdW5ldC5jb20+iQE3
 BBMBCAAhBQJbObiCAhsDBQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEJ7rXZh78/h8+tIH
 +QFYRQH4qh3WagcmjbG/zCe2RmZZePO8bmut2fAxY04aqJZGYUBxb5lfaWaHkstqM5sFD8Jo
 k1j5E7f1cnfwB21azdUO8fzYL889kdVOzatdT/uTjR7OjR59gpJMd4lx7fwFuZUg8z6rfWJ3
 ImjxxBgaJRL6pqaZ9lOst82O0qJKEFBR+HDUVvgh4n8TTOfKNv/dGPQhaed+2or98asdYRWo
 S/zc4ltTh4SxZjLd98pDxjlUyOJoMJeWdlMmLgWV3h1qjy4DxgQzvgATEaKjOuwtkCOcwHn7
 Unf0F2V9p4O7NFOuoVyqTBRX+5xKgzSM7VP1RlTT4FA9/7wkhhG+FEK5AQ0EWzm4ggEIAL9F
 IIPQYMx5x+zMjm8lDsmh12zoqCtMfn9QWrERd2gDS3GsORbe/i6DhYvzsulH8vsviPle4ocU
 +PaTwadfnEqm0FS7xCONYookDGfAiPS4cHWX7WrTNBP7mK3Gl1KaAOJJsMbCVAA9q4d8WL+A
 e+XrfOAetZq5gxLxDMYySNI1pIMJVrGECiboLa/LPPh2yw4jieAedW96CPuZs7rUY/5uIVt0
 Dn4/aSzV+Ixr52Z2McvNmH/VxDt59Z6jBztZIJBXpX3BC/UyH7rJOJTaqEF+EVWEpOmSoZ6u
 i1DWyqOBKnQrbUa0fpNd3aaOl2KnlgTH9upm70XZGpeJik/pQGcAEQEAAYkBHwQYAQgACQUC
 Wzm4ggIbDAAKCRCe612Ye/P4fEzqB/9gcM/bODO8o9YR86BLp0S8bF73lwIJyDHg5brjqAnz
 CtCdb4I+evI4iyU9zuN1x4V+Te5ej+mUu5CbIte8gQbo4cc9sbe/AEDoOh0lGoXKZiwtHqoh
 RZ4jOFrZJsEjOSUCLE8E8VR1afPf0SkFXLXWZfZDU28K80JWeV1BCtxutZ39bz6ybMbcCvMS
 UfwCTY0IJOiDga1K4H2HzHAqlvfzCurqe616S4S1ax+erg3KTEXylxmzcFjJU8AUZURy/lQt
 VElzs4Km1p3v6GUciCAb+Uhd12sQG2mL05jmEems9uRe3Wfke/RKp8A+Yq+p6E0A0ZOP+Okm
 LXB2q+ckPvZG
Message-ID: <96717683-70be-7388-3d2f-61131070a96a@secunet.com>
Date: Wed, 2 Sep 2020 07:32:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <175fe2a7-922e-1800-298e-1481b648c6d8@linux.intel.com>
Content-Language: en-US
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
Cc: iommu@lists.linux-foundation.org
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

After updating from v5.8 to v5.9-rc2 I noticed some problems when
booting a system with kernel cmdline "intel_iommu=on,igfx_off".

The following stacktrace was produced:

<6>[    0.000000] Command line: BOOT_IMAGE=/isolinux/bzImage console=tty1 intel_iommu=on,igfx_off
...
<6>[    3.341682] DMAR: Host address width 39
<6>[    3.341684] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
<6>[    3.341702] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 19e2ff0505e
<6>[    3.341705] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
<6>[    3.341711] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
<6>[    3.341713] DMAR: RMRR base: 0x0000009aa9f000 end: 0x0000009aabefff
<6>[    3.341716] DMAR: RMRR base: 0x0000009d000000 end: 0x0000009f7fffff
<6>[    3.341726] DMAR: No ATSR found
<1>[    3.341772] BUG: kernel NULL pointer dereference, address: 0000000000000038
<1>[    3.341774] #PF: supervisor write access in kernel mode
<1>[    3.341776] #PF: error_code(0x0002) - not-present page
<6>[    3.341777] PGD 0 P4D 0
<4>[    3.341780] Oops: 0002 [#1] SMP PTI
<4>[    3.341783] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.9.0-devel+ #2
<4>[    3.341785] Hardware name: LENOVO 20HGS0TW00/20HGS0TW00, BIOS N1WET46S (1.25s ) 03/30/2018
<4>[    3.341790] RIP: 0010:intel_iommu_init+0xed0/0x1136
<4>[    3.341792] Code: fe e9 61 02 00 00 bb f4 ff ff ff e9 57 02 00 00 48 63 d1 48 c1 e2 04 48 03 50 20 48 8b 12 48 85 d2 74 0b 48 8b 92 d0 02 00 00 <48> 89 7a 38 ff c1 e9 15 f5 ff ff 48 c7 c7 60 99 ac a7 49 c7 c7 a0
<4>[    3.341796] RSP: 0000:ffff96d180073dd0 EFLAGS: 00010282
<4>[    3.341798] RAX: ffff8c91037a7d20 RBX: 0000000000000000 RCX: 0000000000000000
<4>[    3.341800] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffffffffff
<4>[    3.341802] RBP: ffff96d180073e90 R08: 0000000000000001 R09: ffff8c91039fe3c0
<4>[    3.341804] R10: 0000000000000226 R11: 0000000000000226 R12: 000000000000000b
<4>[    3.341806] R13: ffff8c910367c650 R14: ffffffffa8426d60 R15: 0000000000000000
<4>[    3.341808] FS:  0000000000000000(0000) GS:ffff8c9107480000(0000) knlGS:0000000000000000
<4>[    3.341810] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[    3.341812] CR2: 0000000000000038 CR3: 00000004b100a001 CR4: 00000000003706e0
<4>[    3.341814] Call Trace:
<4>[    3.341820]  ? _raw_spin_unlock_irqrestore+0x1f/0x30
<4>[    3.341824]  ? call_rcu+0x10e/0x320
<4>[    3.341828]  ? trace_hardirqs_on+0x2c/0xd0
<4>[    3.341831]  ? rdinit_setup+0x2c/0x2c
<4>[    3.341834]  ? e820__memblock_setup+0x8b/0x8b
<4>[    3.341836]  pci_iommu_init+0x16/0x3f
<4>[    3.341839]  do_one_initcall+0x46/0x1e4
<4>[    3.341842]  kernel_init_freeable+0x169/0x1b2
<4>[    3.341845]  ? rest_init+0x9f/0x9f
<4>[    3.341847]  kernel_init+0xa/0x101
<4>[    3.341849]  ret_from_fork+0x22/0x30
<4>[    3.341851] Modules linked in:
<4>[    3.341854] CR2: 0000000000000038
<4>[    3.341860] ---[ end trace 3653722a6f936f18 ]---

I could track the problem down to the dev_iommu_priv_set call in the function
init_no_remapping_devices in the path where !dmar_map_gfx. It turned out that
the dev->iommu entry is NULL at this time.

Lu Baolu <baolu.lu@linux.intel.com> suggested for dev_iommu_priv_set
to automatically allocate the iommu entry by using the function
dev_iommu_get to retrieve that pointer. This function allocates the
entry if needed.

Fixes: 01b9d4e21148 ("iommu/vt-d: Use dev_iommu_priv_get/set()")
Signed-off-by: Torsten Hilbrich <torsten.hilbrich@secunet.com>
Tested-by: Torsten Hilbrich <torsten.hilbrich@secunet.com>
Link: https://lists.linuxfoundation.org/pipermail/iommu/2020-August/048098.html
---
 drivers/iommu/iommu.c | 22 ++++++++++++++++++++++
 include/linux/iommu.h | 11 ++---------
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 609bd25bf154..3edca2a31296 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2849,3 +2849,25 @@ int iommu_sva_get_pasid(struct iommu_sva *handle)
 	return ops->sva_get_pasid(handle);
 }
 EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
+
+void *dev_iommu_priv_get(struct device *dev)
+{
+       struct dev_iommu *param = dev_iommu_get(dev);
+
+       if (WARN_ON(!param))
+               return ERR_PTR(-ENOMEM);
+
+        return param->priv;
+}
+EXPORT_SYMBOL_GPL(dev_iommu_priv_get);
+
+void dev_iommu_priv_set(struct device *dev, void *priv)
+{
+       struct dev_iommu *param = dev_iommu_get(dev);
+
+       if (WARN_ON(!param))
+               return;
+
+        param->priv = priv;
+}
+EXPORT_SYMBOL_GPL(dev_iommu_priv_set);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index fee209efb756..e3e725cf64b3 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -609,15 +609,8 @@ static inline void dev_iommu_fwspec_set(struct device *dev,
 	dev->iommu->fwspec = fwspec;
 }
 
-static inline void *dev_iommu_priv_get(struct device *dev)
-{
-	return dev->iommu->priv;
-}
-
-static inline void dev_iommu_priv_set(struct device *dev, void *priv)
-{
-	dev->iommu->priv = priv;
-}
+void *dev_iommu_priv_get(struct device *dev);
+void dev_iommu_priv_set(struct device *dev, void *priv);
 
 int iommu_probe_device(struct device *dev);
 void iommu_release_device(struct device *dev);
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
