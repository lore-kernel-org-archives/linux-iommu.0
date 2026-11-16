Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794850698;
	b=equAlLBz2iZgstZ3JoxVtJ+CLlpKhMjSXLSZG/XoU9V1THgU5/iPOkTOrLb38JfE8LGg
	 C+2HoHZlEHq9HgOIGca/5Ffp8yBpEktgTLpOhFj73SF1qhTQHiUTUDdZp71q4Dfspaei4
	 xUIk4I7sW2nF0qxoyuXrRMEqIQ0qk4RDUEjS+mpavgu+bPBnIxaMmSMkhEmP1DY5mD5Ih
	 Qhvb4LnBBm1XVgUGTaSFHhi8yc0hHX7OlCxPg2noyFDfVF8j6APlEgCB2St3Uu0iuXVto
	 SJzmdK8ET5Whg5hqVQ52lFnQpcAd4xaXHd+zG7gjKaPKNaJ0FzVdIyaim/Evb0h7Yww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794850698;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=Hx4wP6Qpw+W2JkzO57bSdEnCFN3xLXbhd0iZcTNwJZ4=;
	b=j9fq/Gh3Kpr3IRobCLZWoUN+KoUyccaWjMIp51t1rGMvzr/shOlrq+36yYrF1WmfsKoo
	 dp40aJtR9cT+yqDYpxzIGjt4lxZyeEbyCbOszBtXsNZWxkqBsZQyTpEmOydIyX/+j+qZ1
	 PPeLwahFS9kuPI4VynNG8/1XC6ytoStR+NH40/ew9V0rwYiirKVLC7YSW6l8wv+q01w8W
	 LfYML+jUYJFUCuRtfgQH0hQu2asJDmkkO8E+nmT/F3S5HelkMoB0RuaBHcoyc80mRe243
	 7FUdQgyHqI/yzR+JsOn/8JyxVSk6z07YgmBn79gPqcCdyUNcrpu6bcR4JM3JYedKwSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=eEukfZ54;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE95606A32A
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 17:38:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FE95606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=eEukfZ54
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c40e30c26a4so14814266b.0
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 09:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794850695; x=1795455495; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Hx4wP6Qpw+W2JkzO57bSdEnCFN3xLXbhd0iZcTNwJZ4=;
        b=eEukfZ54TRVZVQo/cVzh/STBMeMAifr+Q/bxSQbvEgNidWcm85yjJxnaNi1dRtFUJw
         fNyEfKUVFYNgGwW7Wg+yFRp1zHlhsJZws85ENCInUBPQKLPH/bu5EQbX1h+PW0S1UDlH
         c7rDZMgH6gILvgbzf3CSlEqciOpcmghy1mzRbmdABepsZ9W3Ut9JvR8eGaof8kCBQA78
         /E0/5cF2QSrwYC/oPyobfWaf4AYBfSiUg7/wcjRXCvi/qvHjBIDoNsWg8DvgRtpc2CcO
         E+GUUWn4GivK+hg9LrJ2aTkrxOCoYnXa24pA038Gf2wOWJO877E5vjSNw8m7+uRya7VA
         GkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794850695; x=1795455495;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Hx4wP6Qpw+W2JkzO57bSdEnCFN3xLXbhd0iZcTNwJZ4=;
        b=ZM9x5iOXUmHbCnebE6D6jh5h78RE3wfdizUwFo2Ggl8XWYEOw0/nZSZX/PK710F3Hp
         GKqW/IzqABA6pdUXJ83KS86GQlnRyOsWaI5cMEHHyLGVcgoIJHeIHVBqrxMfP5TPieI5
         Ym2mAG6vvTeA09lRmzjbnSBtt758oAkv95V9ibx4tbXNsImbuv3wwcYh5Mbj94n+ysae
         AIDddjdRqdPkOGknL+k0bNsf9S3hsfoie/HcG7c4KPAexvkQ6Tg9A1TmGUM6KjvQ2u6J
         lAz67AjnAjgYVuuQlqPOrYnEDhZ/dmZnATiQ4PCU9Amurs3n6QV/ZYKxWHCGyTnr36sd
         rFyQ==
X-Forwarded-Encrypted: i=1; AL+hErE3a4i7xPkUR2EefJaiJ9moM9kOV7O83QOLQqx5lEEiZ/NPsauMVQYEKEIoT1JqTWpbfQrehA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+Qzho7eVe2CIKToTlyYoEzK6KyQANhyIv7bSSCWI03PotjM14j
	mnbmTNba5aYGibZr/gGqo3ZiCHl3FsyCuWj2oSC9kfRz8Uly4QZRjtQ3GpXh5X/cS/Y=
X-Gm-Gg: AYBFou0XrMhlXWVBekVIgicOxg01wlyeh9UgREng/RWCJx9Vs9woSknsVQRITMKcr04
	WK0h8vRpOdOB5KVEBOXghYZWN+d89t7rCT3wUiE6uvZXxb0Yc7aBRn1EP7iA4C++UxCmbvcpjf4
	JuFXG2O69rHx3OxJlMI9neb2pyq65GotaMYDXJS2F84PG27/DHSmBcRAOJk6LRa22jDe16Ojsln
	PSb1f15jFz+rmGI0feAfkrN+ogJEWgEQnn+f6q7CoqWgQ2G/KF0SauZsj4mKqjk5oNzrb4wE4om
	oynSb2KxrcusBuHxUQCm+jISACwMcaQeoDFUlkuqG90Tb4sZFrgMhlytnrbmFrpiKk22zhnfz/Q
	L9u/z9/Eu2i6h2bPbyddjaog6pIAl65TKjhJIR9QYb58pp9plNz4mJCFOUFlU7LtJJHQkpqfELs
	Fq2KpTpbQHfX+e6ARG/r2GndWpf4wdUUi1gAyD948PjyF8cBoJFoJo5XVTR3fHLt1rM4v1Br7+7
	b+B01y+mOvF5yRxn+ZxrDoIs6I9/liSyh5mGllGs+lLfRqwbRSosvrL3aMKhKGaaJrxau2DvkOA
	3z9b68/QZcotmjpFamnyR09GtINcs6TpTj0EtSKaSRz6W0KHQFi6XIZ2tYHwRVomU+ZwBBe8psL
	I+9ETilV2JVX4JK/CUKYi
X-Received: by 2002:a17:907:c05:b0:c4d:31ca:e316 with SMTP id a640c23a62f3a-c50f3750c5amr12270066b.20.1794850694766;
        Mon, 16 Nov 2026 09:38:14 -0800 (PST)
Received: from petegriffin.c.googlers.com (131.44.147.34.bc.googleusercontent.com. [34.147.44.131])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b236d4sm446139766b.18.2026.11.16.09.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 09:38:14 -0800 (PST)
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 16 Nov 2026 17:37:45 +0000
Subject: [PATCH] iommu: Add iommu.passthrough_devs early command line
 parameter
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-b4-iommu-passthrough-devs-v1-1-dc5b493f7551@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGk/+2oC/x3MTQ5AMBBA4avIrE3S+qlwFbGoGjoLKh1EIu6us
 fwW7z0gFJkEuuyBSBcLhy1B5xk4b7eFkKdkKFRhtFYGxwo5rOuJuxU5fAzn4nGiS1CVY+PaurH
 OtJD6PdLM9//uh/f9ADzTmQFrAAAA
X-Change-ID: 20261106-b4-iommu-passthrough-devs-03b7c957ac69
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mostafa Saleh <smostafa@google.com>, 
 Daniel Mentz <danielmentz@google.com>, Juan Yescas <jyescas@google.com>, 
 kernel-team@android.com, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 Peter Griffin <peter.griffin@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9600;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=Urii5UKIxhJqrjIOWrcWNvsYviHjsPHlhkwtRzKuN1c=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBq+z+FdmbITb7QSpfMSMqFlTLiiBCd9JSTCLH+A
 y3xzXvXjFeJAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCavs/hQAKCRDO6LjWAjRy
 ugkwD/9qAsQpXBexhOE0F92j/h8ThC5MjImpB5XuU5sP+iZkubQpQME68KqcxlWtriHDtYmMck/
 V/8gx+6ZM7BEan//0oKVbRk8WVE1ZS7tz6ux7YMNof5ppP4EcaOTbhQUPb0Ud0XBVn2KJRTayfB
 5IVJsjU4alquntf+SnaOvNtg5MoBWVaTzNVfpNLutOLMyW7cxFQrA+vBSpIysIxxi7zaK1Nvrbw
 zcXQGNqk2tCRFEQaCNOC7RZzl/OUiVhauPLbCc2jEuCiBWBWR1gw1rPBNmtoZisclaTVG3dCTV1
 PleJtd28phplPOzcxMuHNwC/kysdPiNSoNT7JJJZfqZfaCKhLUqXoFlPW/ZgfD7VdddINoUVBf8
 BMy9E9OMkKNk38iL1XnWZZUSfNCAHKzoPpGewxknhrFwlIjl73zyW4fohdh3to5k3gO3rACMzZO
 e7TFOBB1zId4C0TEuPm6pXfEswtf6T8UiZtp4XJlRkIA9o3FHeZB7zbgdAaRyZQIwt2s0KbTrDu
 LDZKfmIqp16Q5hcCsUwb6hrIQgHw95UAyfTyB3ZSDKUfyfm3Svdz+0LtA+HG2bkOy03W5tEfnlL
 s/5mTy0kfDmnW/5PKOCGtEGWVhkG5dsBx8vI0Wruaxx38gQqgees0Clr61s/bnWwg/4WqE38k6O
 gcsj4cMgajuTGqA==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

Currently, the generic IOMMU core only provides an all-or-nothing global
switch ('iommu.passthrough={0,1}' and CONFIG_IOMMU_DEFAULT_PASSTHROUGH)
to configure default DMA domains in passthrough (IOMMU_DOMAIN_IDENTITY)
mode at boot time.

Add an 'iommu.passthrough_devs=<dev_name>[,<dev_name>...]' early
command-line parameter. When allocating the default domain for a group in
iommu_group_alloc_default_domain(), if no mandatory domain type override
is present, check whether any device in the group (or any of its
parent/bridge devices via dev->parent) matches 'iommu.passthrough_devs'
and request IOMMU_DOMAIN_IDENTITY, warning and falling back to
IOMMU_DOMAIN_DMA if identity domains are unsupported (consistent with
'iommu.passthrough=1').

Device names match dev_name(), such as PCI BDFs ('0000:01:00.0'),
Device Tree platform devices ('3c400000.ufs'), or ACPI platform
devices ('AMDI0010:00'). Walking dev->parent also allows specifying a
parent PCIe host controller or root port (e.g. '3c500000.pcie' or
'0000:00:1c.0') to cover its downstream endpoints.

Note: Untrusted PCI devices ('pdev->untrusted') and explicit IOMMU
driver '.def_domain_type' requirements continue to take precedence.

Configuring per-device passthrough mode at boot is needed for several
use cases:

- Performance tuning and benchmarking: high-throughput storage
  workloads (e.g. fio benchmarks on UFS) can incur measurable
  IOPS/latency and CPU overhead from IOMMU page table management and
  TLB invalidations. Selective device passthrough allows bypassing
  translation for these devices while keeping IOMMU isolation enabled
  for other devices in the system.

- SoC/board bringup and debugging: isolating whether a DMA fault or
  regression is caused by a specific device's IOMMU translation without
  disabling the IOMMU globally across the entire platform.

Implementing this in the generic IOMMU core allows it to work with
ACPI and Device Tree (DT) systems as well as across all IOMMU drivers.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
Hi folks,

This patch follows up on a conversation with Jason Gunthorpe at
Linux Plumbers regarding how to upstream support for configuring
per-device IOMMU passthrough (IOMMU_DOMAIN_IDENTITY) at boot without
abusing Device Tree properties.

Downstream on Google Pixel G5 Laguna platforms, we have historically
carried a custom 'iommu-idmapped' DT property parsed by the arm-smmu-v3
driver to place specific client devices into bypass mode. As discussed
at Plumbers, Device Tree seems the wrong place for this because choosing
passthrough vs. translation for a given device can sometimes be an OS
policy trade-off where we choose device peak performance at the expense
of DMA isolation. This is the case for UFS and PCIe WLAN on Laguna,
which share a common SMMU instance with other peripherals (such as DMA
controllers, VPU, and ISP) where we want DMA isolation to remain
enabled.

A secondary benefit is it could be useful during device bringup and
debugging for fault isolation and to work around firmware/device issues
before a proper driver quirk is in place.

Instead, I propose handling this in the generic IOMMU core via a
kernel command-line parameter. This makes it available uniformly
across both Device Tree and ACPI systems and across all IOMMU drivers.

In terms of upstream Laguna support, initial DT support has already
landed in tree, along with USB and phy support. Other support for
mailbox, clocks, powerdomains, reset is under review in the following
series with more to follow.

https://lore.kernel.org/lkml/20261023235408.3063350-1-dianders@chromium.org/
https://lore.kernel.org/lkml/20261026214359.3122870-1-briannorris@chromium.org/

Feedback and suggestions are very welcome.

Thanks,

Peter
---
 Documentation/admin-guide/kernel-parameters.txt | 11 ++++
 drivers/iommu/iommu.c                           | 76 +++++++++++++++++++++++--
 2 files changed, 82 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c343bc9a0d28..926380cb1e99 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2689,6 +2689,17 @@ Kernel parameters
 			1 - Bypass the IOMMU for DMA.
 			unset - Use value of CONFIG_IOMMU_DEFAULT_PASSTHROUGH.
 
+	iommu.passthrough_devs=
+			[KNL,EARLY] Configure DMA to bypass the IOMMU by default
+			for specific devices.
+			Format: <dev_name>[,<dev_name>...]
+			Specify a comma-separated list of device names (matching
+			dev_name() of the client device or any of its parent/bridge
+			devices) whose IOMMU groups should default to passthrough
+			(identity) mode (e.g. "0000:01:00.0" for PCI,
+			"3c400000.ufs" for Device Tree, or
+			"AMDI0010:00" for ACPI).
+
 	iommu.debug_pagealloc=
 			[KNL,EARLY] When CONFIG_IOMMU_DEBUG_PAGEALLOC is set, this
 			parameter enables the feature at boot time. By default, it
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b486b8bbd1fc..0a7796e0311e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -33,6 +33,7 @@
 #include <trace/events/iommu.h>
 #include <linux/sched/mm.h>
 #include <linux/msi.h>
+#include <linux/string.h>
 #include <uapi/linux/iommufd.h>
 #include <linux/generic_pt/iommu.h>
 
@@ -43,9 +44,12 @@ static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
 static DEFINE_IDA(iommu_global_pasid_ida);
 
+#define IOMMU_PASSTHROUGH_DEVS_MAX_LEN	256
+
 static unsigned int iommu_def_domain_type __read_mostly;
 static bool iommu_dma_strict __read_mostly = IS_ENABLED(CONFIG_IOMMU_DEFAULT_DMA_STRICT);
 static u32 iommu_cmd_line __read_mostly;
+static char iommu_passthrough_devs[IOMMU_PASSTHROUGH_DEVS_MAX_LEN] __read_mostly;
 
 /* Tags used with xa_tag_pointer() in group->pasid_array */
 enum { IOMMU_PASID_ARRAY_DOMAIN = 0, IOMMU_PASID_ARRAY_HANDLE = 1 };
@@ -805,6 +809,27 @@ static int __init iommu_set_def_domain_type(char *str)
 }
 early_param("iommu.passthrough", iommu_set_def_domain_type);
 
+static int __init iommu_set_passthrough_devs(char *str)
+{
+	size_t len;
+
+	if (!str || !*str)
+		return -EINVAL;
+
+	len = strlen(iommu_passthrough_devs);
+	if (len + (len ? 1 : 0) + strlen(str) >= IOMMU_PASSTHROUGH_DEVS_MAX_LEN) {
+		pr_warn("Too long list of device names for 'iommu.passthrough_devs'!\n");
+		return -EINVAL;
+	}
+	if (len)
+		iommu_passthrough_devs[len++] = ',';
+
+	strscpy(iommu_passthrough_devs + len, str,
+		IOMMU_PASSTHROUGH_DEVS_MAX_LEN - len);
+	return 0;
+}
+early_param("iommu.passthrough_devs", iommu_set_passthrough_devs);
+
 static int __init iommu_dma_setup(char *str)
 {
 	int ret = kstrtobool(str, &iommu_dma_strict);
@@ -1750,14 +1775,45 @@ __iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
 	return ERR_PTR(-EINVAL);
 }
 
+static bool iommu_is_passthrough_dev(struct device *dev)
+{
+	for (; dev; dev = dev->parent) {
+		const char *name = dev_name(dev);
+
+		if (name && *name &&
+		    parse_option_str(iommu_passthrough_devs, name))
+			return true;
+	}
+
+	return false;
+}
+
+static struct device *iommu_group_passthrough_dev(struct iommu_group *group)
+{
+	struct group_device *gdev;
+
+	if (!iommu_passthrough_devs[0])
+		return NULL;
+
+	for_each_group_device(group, gdev) {
+		if (iommu_is_passthrough_dev(gdev->dev))
+			return gdev->dev;
+	}
+
+	return NULL;
+}
+
 /*
  * req_type of 0 means "auto" which means to select a domain based on
- * iommu_def_domain_type or what the driver actually supports.
+ * iommu.passthrough_devs, iommu_def_domain_type, or what the driver
+ * actually supports.
  */
 static struct iommu_domain *
 iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
 {
 	const struct iommu_ops *ops = dev_iommu_ops(iommu_group_first_dev(group));
+	unsigned int def_type = iommu_def_domain_type;
+	struct device *pt_dev = NULL;
 	struct iommu_domain *dom;
 
 	lockdep_assert_held(&group->mutex);
@@ -1777,19 +1833,29 @@ iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
 		return __iommu_group_alloc_default_domain(group, req_type);
 
 	/* The driver gave no guidance on what type to use, try the default */
-	dom = __iommu_group_alloc_default_domain(group, iommu_def_domain_type);
-	if (!IS_ERR(dom))
+	if (def_type != IOMMU_DOMAIN_IDENTITY) {
+		pt_dev = iommu_group_passthrough_dev(group);
+		if (pt_dev)
+			def_type = IOMMU_DOMAIN_IDENTITY;
+	}
+
+	dom = __iommu_group_alloc_default_domain(group, def_type);
+	if (!IS_ERR(dom)) {
+		if (pt_dev && dom != group->default_domain)
+			dev_info(pt_dev,
+				 "Setting default IOMMU domain to passthrough via command line\n");
 		return dom;
+	}
 
 	/* Otherwise IDENTITY and DMA_FQ defaults will try DMA */
-	if (iommu_def_domain_type == IOMMU_DOMAIN_DMA)
+	if (def_type == IOMMU_DOMAIN_DMA)
 		return ERR_PTR(-EINVAL);
 	dom = __iommu_group_alloc_default_domain(group, IOMMU_DOMAIN_DMA);
 	if (IS_ERR(dom))
 		return dom;
 
 	pr_warn("Failed to allocate default IOMMU domain of type %u for group %s - Falling back to IOMMU_DOMAIN_DMA",
-		iommu_def_domain_type, group->name);
+		def_type, group->name);
 	return dom;
 }
 

---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
change-id: 20261106-b4-iommu-passthrough-devs-03b7c957ac69

Best regards,
-- 
Peter Griffin <peter.griffin@linaro.org>

